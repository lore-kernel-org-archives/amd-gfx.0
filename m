Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C79C77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  2 May 2023 13:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BDC610E552;
	Tue,  2 May 2023 13:50:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0EB10E552
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 May 2023 13:50:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z685VVzvPGojLz4+xdgGz8tm0XbD9BtQv5QGgEp61CPa9ajlDzeFYGS6dm2YaMn1XrfetTJKqiH2ndG54gJpJ9o3NRu0LZv+aNASnYqz2vox+VYIBNV7PkNTUwxqQySLExnDlAHte0JgKA/VR+1LgRosqNTQZFHZz06R/7H9pMRIjLOjOkfQvNTRnmWex9wlhJAvSDBST6Ajw+7wmwDhbEpBHeYiiozGomOQt7SNbbY+cNXdArnXf8kJMSk5RdBNwXcpEB2yE2m7IGepL0ZT9+PtqvTVVIJtfRIUqSjDEZCEGXdIsXFDvyX2hkZaFbFd2MZF2ErV0n+XhOoP4RKgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG+rimHJvLECP2w42G8vnpIxSgEbw3T9O5TYNWKy8Hg=;
 b=SrOOTBJE3b/6DFGNNZS2vzfbOfTL8qcc786rgDXpbenSaESn0l2Qb7RtMfxL2LuOuhojHR4S8NCyKW/tWy+H3OYk2l/cX8g1JElAPU3QOcSW98DSvYGQiRfjlF/vpPGRobR3sMbXB4wuUXvyvRiDS68vJaMrTSpbNiT99p5m+E/qqYu4OvDZgs0Ey1UCeiYuRXsdRf4uVi+ivfdLsTIWk7HKX4jXw+ZrFjn2qOYBO7EQxQ1bL5LsRAByKz59HIFnhqexQBwIVvAb73HPUIl4WhEMZu43ExYDGPirvmKkqCDsz0ATCqus8bPL/lq/4VSJPTKHWSMeuKGRDRIsb2Xj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG+rimHJvLECP2w42G8vnpIxSgEbw3T9O5TYNWKy8Hg=;
 b=cKnRHSBxjf9/XePDXJzdfUn91dI+1jJRPejSqWgyVsg77r+DuUF4tJ4ywS0N93CMGKd3A28RpMUkO24bzJjr7HKlkAlJFpCAV6AvE7erJvSwSNA0umzBhmpxITulh8OyRGKJDlD1+AfDz5fMwXjM7uguzJl0VmrgRoG7Sc1Szsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:50:16 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::636d:c8bf:601a:75f7]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::636d:c8bf:601a:75f7%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 13:50:16 +0000
Date: Tue, 2 May 2023 21:50:03 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Yifan Zhang <yifan1.zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: set gfx9 onwards APU atomics support to be
 true
Message-ID: <ZFEVC3Q+PSKFJ1e+@lang-desktop>
References: <20230430020220.1266699-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430020220.1266699-1-yifan1.zhang@amd.com>
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dd5d6d-6136-4092-4166-08db4b142879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFk6psNFDg6HEmfUVntpH1WUgX4SqtBIlXIdy/wl498F3rgxMfdA8BpKsDt7xxkEWehAPH674WZFBLFFzBhDDRACC8rq/e7PYN/X/RuQCV2mp2f8U/RhHCdOCIlian1xKYCplMXtzGW5aNOMMDEvjsR0y+VA/j6bZ0HTfupVzHkxgB8Vzo9MquidAWwJcFK6Yttlh4KGdeR64syvrIK2ah3xj7rzmPsEObgfqOC3vLs6HR0QP8jde0AD/1c3EYgksZZXurW3G8oDbR7xL1ciPkoh2+07bjqm+r6GW1dee9KroBFKoKGumHtxnTGpgaUQcEif8Quk+++bEf4caMPewh4V7y/LM60pbH9bq/x/VOLScpxEFIBqUZN4TsKXTQ+v97UWmeC6FaVa7pRxgLEObEWWHB4W7zEoJiKWmR6HiijEdwkCUSixBXzVPSHI19Q1+WcBujVDH3Kd3o2LXd58JprbTI1498kjO62FYWRhOj4jgovJnTviuGygGx0i5sxtXpp9HHaaF6xjyfPoLvwK9eKWHxjR0pTug26o781L+ksJpSvp8fx1rDRa6VmnGSq0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(9686003)(6512007)(186003)(26005)(6506007)(66556008)(316002)(66946007)(4326008)(6636002)(66476007)(2906002)(478600001)(6666004)(6486002)(8676002)(8936002)(33716001)(6862004)(5660300002)(41300700001)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQD0hfcSNKabvRQVaN56E/IL93TSQ23gtj6OJotWrsTokC/SopUV+DSukkAC?=
 =?us-ascii?Q?1MHlXdW+iY5MzxgicZv5XuDM0DN69GjeenygO3EjurvhPLXU+9u1QOwx4GIv?=
 =?us-ascii?Q?kRvz2AX2Xnd/9IsnXndiIshvyATiqgadAp1dqdF6fb+o64YuxzkSHseeekQf?=
 =?us-ascii?Q?bJK2Iu3FO2N1EIwJAda8H+M+hiM5gDj4lnmxtlNvT2VeR3wLBjaZLnnd2xos?=
 =?us-ascii?Q?8MxfKnS4URPQvCldgHXexqxzE5h7f9c2swMiVRRnMN6qL2GVclbvJwlal63j?=
 =?us-ascii?Q?T6iPuec4aL/o2diN5TU4+pLu5Po5j03ceZ8Li+wy78J5QrWpxZN2ZT5oiR5a?=
 =?us-ascii?Q?ciFsp1WUwqtUDAUuESw1hqWoK7vjxbKKYW1AT3M5LKt4TuDV2WLAXvNZS1FB?=
 =?us-ascii?Q?CSdmOaMcEjjCBWCANel+WLqtcKrDknA7R0HkQ2Wr0O7lo8jianV4g0RfNQff?=
 =?us-ascii?Q?EEFIv7I9xPPq+2ZZmkv0gPb54vU8NKeAW8ANdwt0Q2XzZzfl5NNr7WpQ3ldm?=
 =?us-ascii?Q?SKInxZinG6Dp3BWdONxmKsO/1lACr4b7yFrx0HvD8D39d+C6W181DmVUTpSq?=
 =?us-ascii?Q?v1ZVP4EF3uZLOC4V22yCswQCeONOh3v6TiT7v6spmfaDTBqA9ibrDQ0GAryi?=
 =?us-ascii?Q?Vigj+gkenx7syStQuMhllr8kQukP9aS8UG4+5zw4R1ndRAAlMC2K60aNjg0Q?=
 =?us-ascii?Q?H2d2sduAC1CiSc1I8QXkYJCC1p2MS1S2noABRItb5UUJUOH9yB79nakUjbrL?=
 =?us-ascii?Q?ewKzSzG8/8gKU65jpWJNFaHT7U3cb5QFa172TK/GAmds9sHy9XLjA9eB7pep?=
 =?us-ascii?Q?rJSogGcPpGO8pcXJgXU4TMLrZBD87DzAeaJGkDy98g/YhQ9F+Grl5qf9Td+E?=
 =?us-ascii?Q?3VBsArs5g00KE+1W6HowzHz8K0PvMWGxu+JSiL+Pl4jAKe3TYlbiawQxg2/E?=
 =?us-ascii?Q?6WXNbmlfdZyU6OOqqRr644cBOAPVUx24846O3LJo1iYlnjWQO5qLc8K5aGyC?=
 =?us-ascii?Q?ZSZOEZ0t3kn/GQA0Ug1OkzOaGaeM2oGXr/JDZTBemcv969uG70mXOMZkC8On?=
 =?us-ascii?Q?Yb9zN3lDYZ9Wv5kZZBMqhuOBmQAab0wBXQJdQV9hibOb6vbR8DwuGz/k/NaG?=
 =?us-ascii?Q?xK5HX+l8PPvZ32ayZpegZTLpreUwVNsuetBUqKCKCziItmjIZXG+8EUUX6Ob?=
 =?us-ascii?Q?fs5PnPp/kbLiarwEP61h5TBawd+/PA4VJCu/Q1iJx2OBffP0xvv9mkkmyJ2E?=
 =?us-ascii?Q?O7SXmFhN/Rev5ruztMDb6yIEQRCBJiw12Eoau9r+u2/11kTsOCOCo6B0MC5T?=
 =?us-ascii?Q?YFbNAV5sJmSNeBRahPuKNl+L+v/qx/r+qr65fqW51pSdgfACsBuCA6ERlC11?=
 =?us-ascii?Q?sxW/Ex7S7gVNIrdjHOK3KH/h5BucfoJzP4s+/Xq1w8RPDVJSjPGPwyQhfu97?=
 =?us-ascii?Q?ayf5g2vIdDnm+54n+dYSaSHGld3aL6QuuoZClpmbF/196ejiO3UJ7G5VFsh5?=
 =?us-ascii?Q?bMINl5D2gJXSIAcoPWlL9qmyCWso4dhwgbqtZVOaOL/3+ILYwVEvkLlOAKhQ?=
 =?us-ascii?Q?UJ5TvwCMcwpUmoOpzQ6+2dZFCtIAok8ed8VL5PPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dd5d6d-6136-4092-4166-08db4b142879
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:50:15.8874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiRxtM5McZ02xfTSVKjsF7WNDtmKn96ZhGR8R4yoaawS0AkdX63dA+8EUX4ptAy1lUOsXYWFasuXpfDC4TUabA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 04/30/ , Yifan Zhang wrote:
> APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather
> it is internal path w/ native atomic support. Set have_atomics_support
> to true.
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Lang Yu <lang.yu@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b57e7776055b..750eaffa81ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3757,6 +3757,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
>  			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
>  			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> +	/* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is a
> +	 * internal path natively support atomics, set have_atomics_support to true.
> +	 */
> +	else if ((adev->flags & AMD_IS_APU) &&
> +		(adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0)))
> +		adev->have_atomics_support = true;
>  	else
>  		adev->have_atomics_support =
>  			!pci_enable_atomic_ops_to_root(adev->pdev,
> -- 
> 2.37.3
> 
