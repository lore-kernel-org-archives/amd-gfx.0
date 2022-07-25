Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2831DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 02:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA35E10E04D;
	Mon, 25 Jul 2022 02:06:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDC310E04D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 02:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHh1sRTQYK/lnFxXi3vOOMSHSYQ9Rt+XYBLb6fvJ2z5xg1zxVJUqQYstFB4rt8QTjhzudYcCjQ6Cv+4YF38wvFPDxRnZTWvcBeRaLiH674APyaj0uyMpRR1SRTH9i3NDjCutirprDfFUn1MuQcvjkhr1LqO27eWgC76dVCiIcMlSDg7HSCIvWxt3y64R9DU9o3jvfB2ZU041u5AZMAfRmVee1lT4sT+E0AGqZQxoYQxw3HWchltOget5ItJqnXoyiCMNkTd4DJ4y6y+TB4i74dHyz3JHkiO7BQXK7OcYpeAOwNOjAdXpFG0hPIxPdQKqhAHJiWv8h80fs20BV/CCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1MTmeq25fiRJTuvb08fx2kEWs8E4i72P7DBfE2xYb4=;
 b=CkCvsjwFe+1UJuc8RV4P5KObPCoZiTdrDZ20CMdDF1IKHGEUCHs6/6Y4T1WQtGdkPb8swn+5ypBDAK/GeF0QlDPITnsnaHef0hnuin1Z2XfSpZCNM/dSNFsIOh4EA+w+K/EnCKZa5IY+Q69IFa6XyGsFstDM7Nl5SjfxUrXPXUgaIFebxOgUnwc8gt4sy8SluBljrtQfvZjHdII954PYdgzz7pKCQNZiygFLymIiy4j2o3hbMiWNjUz9WzTNmzMd0+RCZvd57cd0dnLKWcCmajobUNZfEKAVrYJk7HWOGjMdaq008gG4dGV1+GK2Xz6/z11yvTnXUOEp9ib70sgGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1MTmeq25fiRJTuvb08fx2kEWs8E4i72P7DBfE2xYb4=;
 b=lD/oqHLhnfF0DSd1StAQJWDZi8LeTc6oZFpn/tzDSvXA3MnMuvEUjAj0DquuPWBMkIvZ+/E79uj3iKK8gqZuzP+UQ+EP3CmnZYdMPKnW48BVkownhhGTMWP7Ehl5BYO5EAhDHIV09fu2PJRP+f1mzdla5FPW4wruwvDEl/x3nW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN8PR12MB2993.namprd12.prod.outlook.com (2603:10b6:408:63::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.21; Mon, 25 Jul 2022 02:06:07 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::ec80:e3fd:e3e2:605d%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 02:06:06 +0000
Date: Mon, 25 Jul 2022 10:05:46 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: enable swiotlb for gmc 11.0
Message-ID: <Yt36eh+IvLcWPseY@amd.com>
References: <20220725015908.1434478-1-aaron.liu@amd.com>
 <20220725015908.1434478-2-aaron.liu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725015908.1434478-2-aaron.liu@amd.com>
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6143b099-2da7-47e9-506c-08da6de23c46
X-MS-TrafficTypeDiagnostic: BN8PR12MB2993:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VuyO+6aw4NvhvwftwlGjhx6g7tOlFDOuvtyWFmL9yrv+7/ywJyuQ2vJMxNmsTohRMtjDTQdlBVyvwmA30Z3rI3thV7eUTJJqkqO3KoRSTXK377XUIObk/0NtuLMAbbfRa7F/mJ7yucbBVDS1diGPdT7nQ8mIvhywYMsYFCzlZfn7+D2EkE6IkZ0aV1l0Gsu8QsVvn5fEBX52FVDoMau2gZ9Ztw4LHs5GnhItl88B1CEWGvQMYVSZ0ROLHaEyoSOyyc72kDImks7mNuBotQCgLTUsM4saogJZlzri7Uf1kV7If/zb9Aygu+8y8vviRKkNViwDpFTJh7nXgELQXpUm3jnYQ38CVzYti+5L1lhaYzTxCjHwwi0bz0WLS/70d/SRFJRi0k/CSOaGCkIC9t2V4mTsPqZ4ibn6wOzmjasPUxCD0zUpKL1eWCkDYHOsRdmQuQd0S/nZA6qegLAi1pSHAynGHicqSSRh5Mq8Lb5SmEfbrTV94JIkMvmdObNGZveR9LdMYw244Y/OnNhRPXdWzoBL8a9xWwUXU+mijtNP3ixawB8HoSd5+oy13H9a3j5Mf2SQ51pmV//anY5p3+SjBNsDbAzXE+62OGtNAgHzOrqLJEcagLlccxqgQKBpkAdtiAEsP1gu4VNAZw47KHdNXijJBduoW7iEv7AqlveQEUD3i+4lEgH88KARyBmFOKNWQlFuMjK96isHcac+QPdnZ7ZC9TUKIhVHJyRPZVE2xb9RD2/V/M/zrTrKPg6Opuyw0gX32V+rzYWMfPfFyXGQtVyp9WeYs8zFD3OJfNnnIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(6486002)(8936002)(6862004)(478600001)(5660300002)(6506007)(186003)(2616005)(86362001)(6512007)(26005)(4744005)(6666004)(2906002)(41300700001)(316002)(54906003)(37006003)(6636002)(38100700002)(36756003)(8676002)(66476007)(66556008)(4326008)(66946007)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XP2/s4GsRlrAVFjZ9ibgF44Xx/wAEDXYTc3xC/0bRPXr743TSsOX9m0mrO9?=
 =?us-ascii?Q?1DYH1f5F/pgg+580E+0LltpkarLB2LckniDlSGyOM2kVMRhxAH/YJ18xxQBy?=
 =?us-ascii?Q?a6M5rcW4BFmCtrS2Q+H1FAD2Lo30H5xu4y/Btxs+gk/Co3EFk/o/+GLNkynd?=
 =?us-ascii?Q?Ot+kYNUS9um04M1JurP2hEMTl9eOhFvWoa07jmaoAUByhqQ5ptLFqB6AEj6k?=
 =?us-ascii?Q?cTBG2I2wy2Jt+x8BI37ffIvzrPahes1Vo078ijvH+LTUL1WggphZoK5AoGRh?=
 =?us-ascii?Q?BJfHpo82ZwGq3y3OZ58AMD5KZp9wpwUkqdXgm/VQQ6DI8xHK17Dmsg5Q54az?=
 =?us-ascii?Q?mC+8u2i6hfufupkOvwzOdWNi9PiuIeXOj5YWYkZcO64+rAlY46ppt/nJY+vk?=
 =?us-ascii?Q?mdwfJXnp3TqBerp+FzTjauXwBYh00rZiRo4PJL29mLbJ4ggtu4FyHo6QMs5L?=
 =?us-ascii?Q?VsFVjG/R9MqKN3ICR4eOLY8cJFLt2A682GGEH7sgUxCtmz6qUErTK3mIpv0M?=
 =?us-ascii?Q?+7BAZlXhw9IjJ8M/fH3Dxk5mgCPtYku5VmzYiwaJqRD2ZxhmhFuvy/OLtW7X?=
 =?us-ascii?Q?VR7pJKwCmXDjmfj1OP5Tx2++4PdXux7fUnMjB8fZuMyhcnGssIjIb+Jvr615?=
 =?us-ascii?Q?AbKR9rBNO5V6KUdFIMoxxY2G+25RmllRpzrfiZ6cpZoJ5gi4UNxd1ig1QNq8?=
 =?us-ascii?Q?R2Vcuorus0q2z/5bla0kZ4scg0jvOKn20vamBmRaj7H1UKL8XQTXnv0pOnYv?=
 =?us-ascii?Q?vRvk0Nw7AFMBtk91/pelqlDAoVdSyo05ohfY1EgBhMJmjs13T3Xn2sPQDfdE?=
 =?us-ascii?Q?R5Xg700jR0fax5W5vkrxIyI7rPPREJl5WZOF2Tpos9kuadoGFSOVKA3+MsSC?=
 =?us-ascii?Q?xlMzdvjoaFzTlXRm/KxixNWwVV6dbNj5YxQE1dvQaQKtD0MtWMonKuvvnCAO?=
 =?us-ascii?Q?lhc4dgVcgDt8HvT2Vsys6F+AOol7JupsFs/xJwc+JTUDwsEebFMsOcjcQMrh?=
 =?us-ascii?Q?qBstH24SIfORXhEpGw2UPerhQ+BmtcO9/+qm6fYBa8F/xEAko0XqbCl0LZZQ?=
 =?us-ascii?Q?XjFpKFJjsHWYxqKEpebY6ugQEDCzxU1Exk2HPUhfKGEl54WJh+e8PP8E+sC/?=
 =?us-ascii?Q?jnWeJwpX8NFq7+oYRpEBovS7+xy6mP+7Wkp5qklOmAjt3P1m3JUJOiDPHN9X?=
 =?us-ascii?Q?XO+7/BHDjYQ8DfuAajTPGK82+fMGtYxq5OXLwLQ0EpyE5EJG/+1uvT/E0ZuL?=
 =?us-ascii?Q?IApMENVaUztOldvoHt+dFv/CKRh2P2yG1MidlvJI9ZRJgMINHpHJyyKqXomQ?=
 =?us-ascii?Q?33Z2mNc1gidIWYRObT4+3UXUpV+0+pIkL9mScxP/wU+hyXnAeRKrQIL7aV//?=
 =?us-ascii?Q?R/F44zOQLXuZReP0a4UNkqOAF3CREA8DnnsBHEJg8y8RkjtVOBPskzSzyWYF?=
 =?us-ascii?Q?wOcgTmWQYzyA/lEcNRVCCi3BMDSu6kVIALkauykA9WmzY/779hsyRMgb1N0v?=
 =?us-ascii?Q?eSXyOKuQkRFD4cZCQJBqpfdsxBAiTblr5IgLK8Brm2+Jf/LOTH5MtAZBZ100?=
 =?us-ascii?Q?iMq8FAKEU3/QDOREBYZxrgVI/871AM+S9EeOX+rx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6143b099-2da7-47e9-506c-08da6de23c46
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 02:06:06.8873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6arROlynAsTdKS4SkuIKU75KRIEc5EHrAC3aMIJQUCy8dY3BNdLIhaPKDBOKqXu1UvglxB+7ktaSTRaooSsLlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2993
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 25, 2022 at 09:59:08AM +0800, Liu, Aaron wrote:
> Enable swiotlb for gmc 11.0.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 503e40a90319..1471bfb9ae38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -22,6 +22,9 @@
>   */
>  #include <linux/firmware.h>
>  #include <linux/pci.h>
> +
> +#include <drm/drm_cache.h>
> +
>  #include "amdgpu.h"
>  #include "amdgpu_atomfirmware.h"
>  #include "gmc_v11_0.h"
> @@ -775,6 +778,8 @@ static int gmc_v11_0_sw_init(void *handle)
>  		return r;
>  	}
>  
> +	adev->need_swiotlb = drm_need_swiotlb(44);
> +
>  	r = gmc_v11_0_mc_init(adev);
>  	if (r)
>  		return r;
> -- 
> 2.37.0
> 
