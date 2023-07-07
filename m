Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB848EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 11:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316D010E560;
	Fri,  7 Jul 2023 11:12:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A84910E562
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 11:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=libYrI8rnH85LixdHaEsoQSyLTzPLsqbW6JoxR3IONEJgN1dvfBYmjiSL0CqqC1jVvE0mx61/rzS/L1gBkxYdel3uavtot9tKCMTuhoLgct/iqBcOYg6E6S95iH/n5pl1iVcMM5UcMGSfRpcGklQepVL8Vsf0l5auSsprezKud6TiuWU4TPHCTGAlbbkX30aNWmu0r8X+Jqem+K/mPlpkBrtVQ/QqlANeN48X+dCylgB2zgNBZw5SLxH5JlJbj70sWqBmIBeDIwWH4n2hPHeyiI4QYlhei+4HDm7WO+ajXkKB2PlGDTJQyTK1WrGdlyo8VSSBU2aE0b1HkKKpTVrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMawCp0U9yNcHLfGrc+XgHsyFoKqzoWYB2Hjzbo9ugQ=;
 b=bvqXEDE+Ay8WHGYUDC75OJU5tNpiUeQZqg/yK9r0hHiiJVhMmEtuquazig3dgUIOa64CQHW4U6ejIaGDfrObTsJmS2PDMtBDKaG7lubs/XYc9oFEjqZM//8ORLMtST1W4N6+rHUyAVpIc7Jt9BtxjimHa1hYJN8Exvz6/PNGKWDqqY85N/AhA2jZb/HzXU6VFcBCZoUQA8XA6WwJoqSaVUoUxBQ6gr8Egy99iOEEWDYaytPV+t4kGYN5O3XXdGnseehJ2TmQ/pEM1VzBavHD+PNN3Q6BY4iR+WiEvy2j9Duce9l82NXuNFZmTp/b+aKM+LipatdWYnWEBaDKALVQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMawCp0U9yNcHLfGrc+XgHsyFoKqzoWYB2Hjzbo9ugQ=;
 b=FFHebMtWXTAPqXd8he9jzqsUOgz106mQ9gp3tfeVNUMyhoVOhD6ngRADkPXlp8l89nphKPZKsIrzKvQdLToxYScRt5iekHUi79ZRIAd0jGPkeTjmTC6gCvOkOd2n3TJB5eHxXTMzzM9egFruBhUVwHbafUPd7nYp2O6x9GS1jUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.25; Fri, 7 Jul 2023 11:12:03 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637%3]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 11:12:03 +0000
Date: Fri, 7 Jul 2023 19:11:54 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: use psp_execute_load_ip_fw_cmd_buf instead
Message-ID: <ZKfy+kffRgVnsXZR@lang-desktop>
References: <20230627044833.3668402-1-Lang.Yu@amd.com>
 <20230627044833.3668402-2-Lang.Yu@amd.com>
 <ZJ09bLtx8ANXl0wl@lang-desktop>
 <d861bfc9-f424-1fc3-788c-73d103d333c9@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d861bfc9-f424-1fc3-788c-73d103d333c9@amd.com>
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: f112dd0f-5e39-47f5-6cce-08db7edafe36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pbr4tnpsSAjri3yiRb+2BvkfZOY+34jEUvsH16dFkPeSdaErZUJa89MtwcvVbdGUZFa8cgBbiBvOlI0KPH+MgrmkcZfJwzlyy2X7oYYKg7ay6rxwoa3HIlofFjY/pNDRWkSiCyxnmZ7ZOhPF9vKEq4tuyVOYsPcv3FKh6BoKoLOEXlhLFuYfNQlKpwFj0CeNaKqyD7UiyKJ8k9ivb8K4TUNVKEg+7x6lSq97FxDTNpH4e2ch/PA7ThmP/8gZdixiiA/zTkKuHE2l/Q90BoCpGR7Ww1N6R4YfqHw9qOCJ2vX2iwXWedLsy31PuWQ1dTCBqbD6Ab1rCiNeOC02kBaNgBJGhojv6Bp5i4y3z3vq3eRqI6diX5Q2qTJSYpRi0dEIX489Sz5XV0obU0xfNFVxVdl6K69Bg1H9Iy1d4Nii5iuC+8oUKwl0lrgaZCcPZ/Kcq4cQYhTLvH6Jt/XeqC3QRRMLT28WAHTYOG16cNmEH5Xmi2HkrbnWlvs8bKvT+7NBuVDXUDcWy0ADXbmdZFIoWEvr0cTMaO8YAZIv6sxye7sQwtPS5wbCKEoEo/Oak5vm6xYTfo1f0mTG79k5I5hhXFuK0eRHCDF9GXZ5WjJ3tjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(41300700001)(5660300002)(6486002)(316002)(2906002)(6862004)(8676002)(8936002)(66476007)(66556008)(66946007)(33716001)(6512007)(9686003)(478600001)(186003)(86362001)(4326008)(38100700002)(83380400001)(6636002)(6666004)(53546011)(6506007)(26005)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/OnAD/SUIBbZ2c748I8BcIT4mM/bcLB+O1F5Hu3o/gOC63+UwhKV/5X+9Gp?=
 =?us-ascii?Q?MUOGL+136PKpn9yqr1955c+VNFeo7VymC0JApSAh7TA5baq3rRseg+Q4VYM3?=
 =?us-ascii?Q?tVpcaVlKIDVOr2RoEzGACEBpKq7jEuQ9Lw0z5HOMIu3vu/7oV8P+zhaMG52Q?=
 =?us-ascii?Q?QWba9++dwsnU42056qBaWgUB2NXtSmeAYQ0uNDXUJaQTj+1Eq7CulGwy4gXr?=
 =?us-ascii?Q?25hApbivoC2z1a7B5nId9627dLMktcy4671HqidmtJCZsshWICeFXrxVMYaG?=
 =?us-ascii?Q?1gCnN0zWuE6rpxK3rjpo8AUnqpYkAfs+ueuHK4fHsdSQCh77ypBVcr1ymBsA?=
 =?us-ascii?Q?gCuHR+++T3NtqK11v2GViYYlTRb82GZI7x2u9qPBB+W/0k9M87cN2wlPOtOS?=
 =?us-ascii?Q?s2WjU1n+SWb9JFJaqEvfJk4EydeYT27vNffnOiB1i87LuYYg0HP2V6o1FypE?=
 =?us-ascii?Q?54kseKORwf3iOO/VDZYbzSiVz8sCICvvs5q9IHxUaB6mLBmGdE7DuK+XU7Ou?=
 =?us-ascii?Q?Nsljmxk2N4FoQggymlHH5XcQf0S9UaTv/zrry3m86ZSAHg8qwLaXlGxeY6vf?=
 =?us-ascii?Q?OVd9EpaUWIddotlbTqFFYDEMn36xd108Y9/FIhrwcjqXJ3WNBdys9kcTZvFR?=
 =?us-ascii?Q?Svp6Bs3vGearxKA64jVh/ofMAQJLsH3HSKOfUUqOKzz5TGztcVOWaq5XrCSG?=
 =?us-ascii?Q?V4Izzl2vqniWrFOC30Z8VI1R8tFCJboWKG4lNblLbdF6zi7nr1ldHgGiQ9ai?=
 =?us-ascii?Q?xJg1pcCXzdDYce+8asOOKFDI3OcgQv1aQu3FsSGAx1pql19DO7zS552GQnHA?=
 =?us-ascii?Q?XK9c4miR6njAJ1ygtaR3dlrRV3eRoEY+vQrmmk92nEkm3BCh51+w7TnIJG5f?=
 =?us-ascii?Q?sn3uDX8Yld2xhOe/E5Y17Ib5A3xeBAHQFilxlIxPxYhkho7MhjxDJKjV1BCJ?=
 =?us-ascii?Q?oMZUMjMwkQxq6uINF/nEaCYAM4V2xcXdXFI+pv0++bOj7t9Quswjy5mcCAdH?=
 =?us-ascii?Q?Oxg9u0eFw9iQCD2KGYihSlmN1/PU3NC2zRhWWyT6QnPJ9FCGjVf14Hoku/v7?=
 =?us-ascii?Q?KrPESfX+kN/nij/DJ/tigmdx5ZgoA7dZhiTahemVwWUk6G15cFlaYALFsTWq?=
 =?us-ascii?Q?kcmmaP+v4p7cKVPgYk+LUBXR8OVJhlSEEVSgxOiJ3zNym9q5WuEMdLLVdap3?=
 =?us-ascii?Q?0u/+BXxMeQfokRmWdlwML7fA9+UuP/pWBtJTTp45T2GDJ43ZohzOCWHZ/Mji?=
 =?us-ascii?Q?sxGYVsV01z5ROFdOFs2PsCt+HjdHf7gWpA476+WJks1xfuUUAHSWt+2oFXAT?=
 =?us-ascii?Q?n+NIbtO0ohaj5BFNcM0X5v5e5vdrjEzn3249LeAmjzK23fV75IloZFBP4X6K?=
 =?us-ascii?Q?Gybh+4m8aonsLkLkJS9X72jbB2fI26dGK5gdYyB8ybgtUjJ9Dn8SG4kI7iSR?=
 =?us-ascii?Q?fxswcYQTQ4xsmSW1JqzzONbFbV2OO2d1gcAXVxZrLluAF4tL0Ip3udIJYvVD?=
 =?us-ascii?Q?e8F0GJDEM2z0bE3oFtjU61ni3swNjcvj+j4PHVqJnGoAG6bf9Y1/49Kn4cmt?=
 =?us-ascii?Q?kc/F0bHsAR1SzsiOB43jL7J8EEVXlbfh19jvMgBi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f112dd0f-5e39-47f5-6cce-08db7edafe36
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:12:03.7243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WNUnxpA0mGCTIg2edCyuc7ftCI2xXirzoENmP8jVlIiUvKnu42ft7A/ZkNjkQTjRWfRalRneX+QIfEntpkp4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 07/07/ , Lazar, Lijo wrote:
> 
> 
> On 6/29/2023 1:44 PM, Lang Yu wrote:
> > Ping.
> > 
> > On 06/27/ , Lang Yu wrote:
> > > Replace the old ones with psp_execute_load_ip_fw_cmd_buf.
> > > 
> > > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 31 ++++---------------------
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 --
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  9 +++++++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
> > >   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +---
> > >   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +---
> > >   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +---
> > >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +---
> > >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +---
> > >   9 files changed, 20 insertions(+), 44 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > index a1cb541f315f..b61963112118 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > > @@ -2474,21 +2474,11 @@ int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
> > >   	return ret;
> > >   }
> > > -static int psp_execute_non_psp_fw_load(struct psp_context *psp,
> > > -				  struct amdgpu_firmware_info *ucode)
> > > +static inline
> > > +int psp_execute_non_psp_fw_load(struct psp_context *psp,
> > > +				struct amdgpu_firmware_info *ucode)
> > >   {
> > > -	int ret = 0;
> > > -	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
> > > -
> > > -	ret = psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
> > > -	if (!ret) {
> > > -		ret = psp_cmd_submit_buf(psp, ucode, cmd,
> > > -					 psp->fence_buf_mc_addr);
> > > -	}
> > > -
> > > -	release_psp_cmd_buf(psp);
> > > -
> > > -	return ret;
> > > +	return psp_execute_load_ip_fw_cmd_buf(psp->adev, ucode, 0, 0, 0);
> > >   }
> > >   static int psp_load_smu_fw(struct psp_context *psp)
> > > @@ -2946,19 +2936,6 @@ int psp_rlc_autoload_start(struct psp_context *psp)
> > >   	return ret;
> > >   }
> > > -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
> > > -			uint64_t cmd_gpu_addr, int cmd_size)
> > > -{
> > > -	struct amdgpu_firmware_info ucode = {0};
> > > -
> > > -	ucode.ucode_id = inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM :
> > > -		AMDGPU_UCODE_ID_VCN0_RAM;
> > > -	ucode.mc_addr = cmd_gpu_addr;
> > > -	ucode.ucode_size = cmd_size;
> > > -
> > > -	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
> > > -}
> > > -
> > >   int psp_ring_cmd_submit(struct psp_context *psp,
> > >   			uint64_t cmd_buf_mc_addr,
> > >   			uint64_t fence_mc_addr,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > > index bd324fed6237..e49984a9d570 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > > @@ -459,8 +459,6 @@ extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_inde
> > >   			uint32_t field_val, uint32_t mask, uint32_t msec_timeout);
> > >   int psp_gpu_reset(struct amdgpu_device *adev);
> > > -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
> > > -			uint64_t cmd_gpu_addr, int cmd_size);
> > >   int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
> > >   				   struct amdgpu_firmware_info *ucode,
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > index d37ebd4402ef..1805cd042d34 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > > @@ -1257,3 +1257,12 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
> > >   	return 0;
> > >   }
> > > +
> > > +int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx)
> > > +{
> > > +	return psp_execute_load_ip_fw_cmd_buf(adev, NULL,
> > > +		inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
> > > +		adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> > > +		(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> > > +			   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> > > +}
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > index 92d5534df5f4..3ac5ad91ed08 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > > @@ -414,4 +414,6 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
> > >   			struct ras_common_if *ras_block);
> > >   int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
> > > +int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx);
> > > +
> > >   #endif
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > index c975aed2f6c7..74cd1522067c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > > @@ -881,9 +881,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
> > >   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
> > >   	if (indirect)
> > > -		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
> > > -				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
> > > -					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
> > > +		amdgpu_vcn_psp_update_sram(adev, 0);
> > >   	/* force RBC into idle state */
> > >   	rb_bufsz = order_base_2(ring->ring_size);
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > index bb1875f926f1..79d40203c952 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > > @@ -912,9 +912,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
> > >   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
> > >   	if (indirect)
> > > -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> > > -				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> > > -					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> > > +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
> > >   	ring = &adev->vcn.inst[inst_idx].ring_dec;
> > >   	/* force RBC into idle state */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > index c8f63b3c6f69..9e1570648b6c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > > @@ -1037,9 +1037,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
> > >   		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
> > >   	if (indirect)
> > > -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> > > -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> > > -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> > > +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
> > >   	ring = &adev->vcn.inst[inst_idx].ring_dec;
> > >   	/* force RBC into idle state */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > index 2db73a964031..4febc7629512 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > > @@ -993,9 +993,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
> > >   	if (indirect)
> > > -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> > > -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> > > -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> > > +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
> > >   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > index 5d67b8b8a3d6..ce8c766dcc73 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > @@ -778,9 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
> > >   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
> > >   	if (indirect)
> > > -		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> > > -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> > > -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> > > +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
> 
> This patch breaks this usecase. Here it has uses a specific UCODE ID (here
> it's always VCN0_RAM), but the buffers are different. In general, instance
> ids cannot be associated with the UCODE ID to be used.

Thanks for pointing this out.

Regards,
Lang

> Thanks,
> Lijo
> 
> > >   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
> > > -- 
> > > 2.25.1
> > > 
