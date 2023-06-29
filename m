Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3C2EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 08:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F286F10E3BD;
	Thu, 29 Jun 2023 08:14:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3086710E3BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 08:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+fAGOz5bt1d6SfJAZkjTvQLCbPhoq0VtG4tVjUc55o43hvTzkog9ngxG40C06DKTAXMnm/u9n8f3ygp1332uoDVdA5bQ0XaFmP9iRhzjphBjk1q0E8arNU3hW/44aUQNuYouSu5JPZ4pbuAGGV+bvIC93XhCFW4efuKdQCdiwFFckvSZgOhCqr8RMNUyHF4jXpGQlz3EzWz8PDkkNCc5K+4acG7CRSeR1CW0MqdPyofDaO3dZdwePna3g6L4WWwzKq2ruAaW5QYSztJkjUqiMUkCYg6C5bVSmgtQE+p3cH/SQC93J4LzYKW5oaXv8Zg3To44B8lClUd50KYc+ZU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uACZcWcHDjww8oUuLZ4tVI7QT4McFD4UWZuapzP7cVA=;
 b=Yrg0zIgMGHzbqx4tegMQKtO+oUkdjqOw6bPI+5xz8mEu2lFi1jr8FJkWc7WEKi9dh0jU11ulgxHt0RxKYpewJ/OdOOVzl994yKiv5cgUOW8Whce9YFOBJhwpHv6ggHCB5drtBKpHABoDAvttYQ3+3Ef06EfG9VaEiO/KFa8rDHMqiU97gUf0mSX7w2DSRUco92nckRSn/Spo2bpxf4XmY76FoJa+E5F4Hy3UtaOhP80/Lg7K0yNDZLgPHXCLlkLQDJDxa0u6VG7ozflPzBviZIJ9PlrLSDGLsRRnb8CsRV8+uaObzF728K/jr23madv9F2Lo3616Xy6J1ziphtDFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uACZcWcHDjww8oUuLZ4tVI7QT4McFD4UWZuapzP7cVA=;
 b=TxCGmZu/+pxW+OzxoC0l4epfHylxZTi6Y6udqONna8Q3dncAM0532gkyaRsfdKjHGJM1r0Y+pyifOFtFCKisX2+RZagJkhcpMCd3mw3OPZaU48X5VlzQ+7Z5elWk3V1VQ3EHlEbK5mam8Xedm4wu5Z5SpRO36uwg6HZIiUSWbf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 BN9PR12MB5194.namprd12.prod.outlook.com (2603:10b6:408:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 08:14:44 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::c4f0:c05:8644:5637%3]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 08:14:44 +0000
Date: Thu, 29 Jun 2023 16:14:36 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: use psp_execute_load_ip_fw_cmd_buf instead
Message-ID: <ZJ09bLtx8ANXl0wl@lang-desktop>
References: <20230627044833.3668402-1-Lang.Yu@amd.com>
 <20230627044833.3668402-2-Lang.Yu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627044833.3668402-2-Lang.Yu@amd.com>
X-ClientProxiedBy: TYAPR01CA0147.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::15) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|BN9PR12MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc75456-d8f2-44fc-b9c4-08db7878e539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzqYKOlqa8ls4z84rjxGMRvRNBY1ckoRqHo4njEozMYrj7ZBqglHYuyWV7qJc2MYYJzQdikF/pM+gymMlKjz22H49/56nTYxTyYad8TY8W01ziBlDr5YcpgG/N7M9+szqwYKY+thaNkytW/wwjmx6T/3ZA1ItQmNNvxOICNsNOARNhGkvEtoIbGEs565XnkFco04b+InPeY0GxmrRFio4tfzsFKYss5A4k1NvDgRWhoHQxXopiDTcrNMQoouK08Ygn/Rg12pD3eKPopLMSh1kK4mgTzh6syrOOCCtF53xN9N1/HGEOwDbUYOr8JQyFqiHRPGjSvQ+rzBAR4Ud4bHxLz/v3oeuRd6Ko8EJHRjTt7D85q8gspcWX+GSL+uNwjf3/+jO9eflfYUJxWBcBh49acpsbPf2DRUMJP4UzTX6UyZZWndSr6e68b2fpORdt8waV1VaG7PxcJNVkDLQ0DeyvpJ4Frl6fuj0ez8wIQTXhK0UP/jR7En3EwFnaoPe8RqmwHpgWfU5qZtmZDncKSh858oPt9qn7kC22OVzh2SXvedZQUCnfivDry25H9sfEI4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(6512007)(38100700002)(5660300002)(86362001)(33716001)(41300700001)(6916009)(66476007)(8936002)(8676002)(316002)(66946007)(66556008)(478600001)(6486002)(6506007)(2906002)(9686003)(26005)(186003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XRzVOmjQlvbkuTDeMvAojvFGYTuo2kDggwe7PrD94jEJLxXYSZLT0MstJkdn?=
 =?us-ascii?Q?96LQJMwY7tqtEqKTR44GiUnEOuD7Bt7NPq36CqiUGbfQmlOMSfOVEbltcxTc?=
 =?us-ascii?Q?3LkBLL8i/vWfwM39djRm9Ka8q+Cxm9HHAX8uquVOxLe10FcUogXree9JvLXN?=
 =?us-ascii?Q?B3kMHPJbVlxmK8wsbJGPmHtIcgWqHpS/bMJpK9AI+FCOb8Yr+KGePHL/n21M?=
 =?us-ascii?Q?ZAiTGvJ868a8SkS1MnEJPP9utsBjdi1xWp8w0BCcTJ7Mkz/PSCqKX2L00rI/?=
 =?us-ascii?Q?aMHpfgKmD1enSvyO4AzzHjLjGivYswOQzDbPW3X1eB9md6e9Hoha2OgeaIXI?=
 =?us-ascii?Q?LQ/9ue2kP6M02D3ghsoUNNhhCqCq2vb8w5npasOWMgEWXuNibEU3h8jhaSRa?=
 =?us-ascii?Q?V4TVbgeqW1vxRbAW/r5CKRjZ+9BAnmUIiuKBUlcC2WX5Ochr5gD34YiIMsij?=
 =?us-ascii?Q?GudJuK7nvR7nC/MmEeU0ZGSI1Mwnr9VZUW88xJ6llfK2nZ1mhbWAox7APNuk?=
 =?us-ascii?Q?pYPlNjLfz0+EQsU4FIjefTRl+Dg19AVsfYgNHcx2PhF8f2P8Cx81oDICGzE9?=
 =?us-ascii?Q?NQW66uBz91bfa7/gQV5Bz6QBu50F7zkHxhtFzEhmmEzkkxgoYc2QpCeWtnt7?=
 =?us-ascii?Q?CzpWkjhMM5P0o/8zNWyUr7l1Ap6k5XiLXkOo6MSZ/jtclLq1yg0W0C0Pgzkc?=
 =?us-ascii?Q?Q4YHz643408uZZ+S8/W/FNhsB2q/ohch6BEdATTjnUPUXZWGE5lQ3p2Vv0K3?=
 =?us-ascii?Q?uC+EXli4xtisd9BcvWDZKMIUtmAYrwYKuxbJxUgECiAczF03CgqwGbkHa4r8?=
 =?us-ascii?Q?KDxAjjLWZDWFOGo0GMLnHEILLdpPyZbvpRoEj7ftN7KTdVvFAaIpx1UYEzLa?=
 =?us-ascii?Q?dXvY3S9IXZKVszfdDbBpd23u8fdYSn/+RatRcoEfAb9AibJxdNPltvD1Dt1/?=
 =?us-ascii?Q?xsYGJak6Oc47tHlm9pcZ5S+9sfLDV5HDme+DyCkgEtRmZlQKeiUTVqHV4Bwc?=
 =?us-ascii?Q?81XJUHCCEqIUqN7fNm/e9+0rZ+nTeKqfPZUJOytQ7csHynUp93rDTMKk8n96?=
 =?us-ascii?Q?Et1C+gqA/wbNMJtQUw+sVuOlqbeJJjzlQ40mG8Z1YzIwsP3PpmKQb7SSNPmK?=
 =?us-ascii?Q?VhSWSDdMUDV1DkUlnZ/LsqA68DNekY7EN/gdeLbzoTnrW2gg/CnOK84FkN2C?=
 =?us-ascii?Q?YXdKtskCv/lZaHbqZOuiV8DE/y/rPPz8WwvyMuuhK0KCMetNresWtPbwrXLX?=
 =?us-ascii?Q?CbN9eaOEqlxWR5SnikcBRzg6FWlEmWEv+0KP7EJf+rMNL9cbN+VFflnwywy1?=
 =?us-ascii?Q?iDFVEqN23+jXoIiWT8PS24UVphLpF3gDe5uty3tXnTxVRlwbAYD4q/um2QAq?=
 =?us-ascii?Q?rPQjlJCKAMCE4/2ABhwrVGL++GH15f0STuThAUg1mXD5KGFaKVG3QuqeEU3f?=
 =?us-ascii?Q?V31banWi2OcHzrrgEVktejaBPyPPwur15eNtRQSFEqoKLdpkpneUeCCIB3VV?=
 =?us-ascii?Q?ZGx5DHI/wJauIRv7pUq/ghirZVAcs0MshJ9N4Bu6G+IAeEQiyqd5cyNyGrjl?=
 =?us-ascii?Q?9i+/TW0gAo/v9ew0fUT+B9RI+6fPoljNad2sKjsV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc75456-d8f2-44fc-b9c4-08db7878e539
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 08:14:44.1214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRod2ZR55rm9i5TGbG870MjAKPN4Oh2sTDsr7nqdxe6s01SS2WK6CuNviRux48aQt8VIbJcwM9BPnKO0gwcFHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5194
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping.

On 06/27/ , Lang Yu wrote:
> Replace the old ones with psp_execute_load_ip_fw_cmd_buf.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 31 ++++---------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  9 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +---
>  9 files changed, 20 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a1cb541f315f..b61963112118 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2474,21 +2474,11 @@ int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
>  	return ret;
>  }
>  
> -static int psp_execute_non_psp_fw_load(struct psp_context *psp,
> -				  struct amdgpu_firmware_info *ucode)
> +static inline
> +int psp_execute_non_psp_fw_load(struct psp_context *psp,
> +				struct amdgpu_firmware_info *ucode)
>  {
> -	int ret = 0;
> -	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
> -
> -	ret = psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
> -	if (!ret) {
> -		ret = psp_cmd_submit_buf(psp, ucode, cmd,
> -					 psp->fence_buf_mc_addr);
> -	}
> -
> -	release_psp_cmd_buf(psp);
> -
> -	return ret;
> +	return psp_execute_load_ip_fw_cmd_buf(psp->adev, ucode, 0, 0, 0);
>  }
>  
>  static int psp_load_smu_fw(struct psp_context *psp)
> @@ -2946,19 +2936,6 @@ int psp_rlc_autoload_start(struct psp_context *psp)
>  	return ret;
>  }
>  
> -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
> -			uint64_t cmd_gpu_addr, int cmd_size)
> -{
> -	struct amdgpu_firmware_info ucode = {0};
> -
> -	ucode.ucode_id = inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM :
> -		AMDGPU_UCODE_ID_VCN0_RAM;
> -	ucode.mc_addr = cmd_gpu_addr;
> -	ucode.ucode_size = cmd_size;
> -
> -	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
> -}
> -
>  int psp_ring_cmd_submit(struct psp_context *psp,
>  			uint64_t cmd_buf_mc_addr,
>  			uint64_t fence_mc_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index bd324fed6237..e49984a9d570 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -459,8 +459,6 @@ extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_inde
>  			uint32_t field_val, uint32_t mask, uint32_t msec_timeout);
>  
>  int psp_gpu_reset(struct amdgpu_device *adev);
> -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
> -			uint64_t cmd_gpu_addr, int cmd_size);
>  
>  int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
>  				   struct amdgpu_firmware_info *ucode,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index d37ebd4402ef..1805cd042d34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1257,3 +1257,12 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
>  
>  	return 0;
>  }
> +
> +int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx)
> +{
> +	return psp_execute_load_ip_fw_cmd_buf(adev, NULL,
> +		inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM : AMDGPU_UCODE_ID_VCN0_RAM,
> +		adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> +		(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> +			   (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 92d5534df5f4..3ac5ad91ed08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -414,4 +414,6 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev,
>  			struct ras_common_if *ras_block);
>  int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
>  
> +int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index c975aed2f6c7..74cd1522067c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -881,9 +881,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>  		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
> -				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
> -					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, 0);
>  
>  	/* force RBC into idle state */
>  	rb_bufsz = order_base_2(ring->ring_size);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index bb1875f926f1..79d40203c952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -912,9 +912,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>  		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>  
>  	ring = &adev->vcn.inst[inst_idx].ring_dec;
>  	/* force RBC into idle state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c8f63b3c6f69..9e1570648b6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1037,9 +1037,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>  		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>  
>  	ring = &adev->vcn.inst[inst_idx].ring_dec;
>  	/* force RBC into idle state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 2db73a964031..4febc7629512 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -993,9 +993,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>  
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>  
>  	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 5d67b8b8a3d6..ce8c766dcc73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -778,9 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>  		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>  
>  	if (indirect)
> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>  
>  	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>  
> -- 
> 2.25.1
> 
