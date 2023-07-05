Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A275EEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 20:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFC710E3B7;
	Wed,  5 Jul 2023 20:10:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410E810E3B7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 20:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5xeGXoOwEgzinFI/2kXbuUaZeiyvkvlrCqq+KePx89KgJkJa8G/9bhvYzh5+iWKmnEK6Nc03r8XchXaEooLD15GDYo1J9bmoV4x0+sFzioKyCyJnk50CyD1c129a6B9poDIAz3scKB3y2Jh6eRHmTf+lf8cDBjlKSZlYMCEc2Wk9QfaQYs+LM8267h68xIHhMS/Z7OoXMr9W+9fQJObFAii0PCQdjmLXaYv5D7HQtp3X1o8v1w64xWzmRhJk9FvVBYAmWD1wy0pWY2cZkscKoWd9A8q0LY6CDQI3TYqdR7yQvDLkB4iQhpewho6GWjR5gfvpWQePY5WwiVVu18QPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhLyUzpR8fhezSRpG7MYzBhK2GR0uBy0mZde74RKOOQ=;
 b=Fr9t9zYK40TeW/HGW7tEZ/g7RkqmM7gGVOux4n8dik5tbzR8w/CDwEX2qU2WpdnqlHdJv1x9xB+b2gSJXybxnTSU2/Kmf4ITLW4KA6pXXiv3186DycHAbAN8Qk2wcCH2dporiHZ3LyyBzfD6D+PIc3uZM6wPJ5l1HqeugJmPGAalJNxY9yZZjwzZfSfv3QNCi4oxr2HfGFgGx3Wa5cqDmCY6f4B2n3zjGgjlOOTZfPZZ+XvSaNZecuY/44BVNHgBW2FdQfkIWSrksvmM4dAVNN4yS9wXVkZru3fQqHFh/8NLWwA+5Tzt9HkfwZUAod7DI2cPR+uRjPXE7SjIUS4GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhLyUzpR8fhezSRpG7MYzBhK2GR0uBy0mZde74RKOOQ=;
 b=WW1WcKJ+0nVzLD33AFrBE8lc9pKxnUWRYO57YngyfzfmZjpBoT6baBDVYKDi8g7NyxU1fcW4S/V8oEkD3NltxhYtZkAl02dyvHL2RvXujKa9SFD0vbiPMhDU+/+pOaAQcixblKmCTrsV4DYjdENJu71xHn/FUvLVGELQ4oOAlkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 20:10:35 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 20:10:35 +0000
Message-ID: <b4226cad-4e19-0090-29cb-af138ddc33f9@amd.com>
Date: Wed, 5 Jul 2023 16:10:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] drm/amdgpu: use psp_execute_load_ip_fw_cmd_buf instead
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230627044833.3668402-1-Lang.Yu@amd.com>
 <20230627044833.3668402-2-Lang.Yu@amd.com>
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20230627044833.3668402-2-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0315.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::28) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 310d816e-091a-42a6-bba5-08db7d93e492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/wcsAn4hPMZPuTjDRqjQc1GKTOxllSHJazcG7o1V31fi5kU4ve5JdqqL8csdo+ug5z/D0z7YFd0Y3sCcBHJ3f+CDZ9wBZzb/ZmUxH2JsZTmFXEoChZQGn5qXynovtaTjbQeQ1vKgG9DCWAB9Z/7kVab37DJIj0yUjqQKtGSQ8bu4zxRwdyqAVlvRv7mpNjqhQCnNiuvfueQfUl9EsdHgXP9aM3oCCbOmJir42CNM5aRyL84+1aPMi6pRj+v8rgPq1hL9J4zNste2Dfe7tzRxs0i/c13xKwsp8DEY3QTPIt3ff1788wq55olcsmU2dGeETUW+SjRCrfGgJkz2/t41u+DDEg92QcRxXBl/eSmCB1l+fDq8Vywo9C1zZBhCOSIgyV0QcUs9wJfPoRWDnhsX+e90XzG3d2JAICs4spZf8uM9PoqHu+49AQeApj079OmA1i+TtQnszDIC6OGNWT1jee0e6DkEpFWqXLO/dcKGE0wQiKcsybBA55Fq74yfXEuOTNvja1UQ8swifhZAN2Zm0kN8n14t63//FzOx1LR7msCLmk5ZruRwUqp79d4IcVGtwo1kkCfleYp6jizKHMQmU1ZSfrz34SZfMZNPsmq2cbPa2FsYTxnnP5hawctMErGo9ex6D9/slC/0yFZjFzvNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(41300700001)(66556008)(478600001)(6512007)(86362001)(31696002)(38100700002)(6486002)(66946007)(83380400001)(316002)(66476007)(36756003)(2906002)(8936002)(2616005)(5660300002)(8676002)(44832011)(186003)(31686004)(6506007)(53546011)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cityMTJOUkRJNkhkOElUaWYwVExzTGluNHJ3Smt5YUlKNlpSVno5UmljZHpQ?=
 =?utf-8?B?UkZ2NTdDSEJ1R0ZzYTlmcmNiNWxBZ3RKYzlsbHprTE1MalliVkc5cGFjVC9P?=
 =?utf-8?B?enNGL2dkRDR6dWhLYnBtYWhyaTNRV1F2aVV0QjNJOUdOZUVmNDNGU3d0K3hq?=
 =?utf-8?B?UHh3emhiWGpYc1A4cGhmaXZlUnZoMnU3N3pFclRqVGIrcjJaaVl0TUN0bGZw?=
 =?utf-8?B?WnFZaWl6WGt4QTlRRkRUMDdTRzJJNENkY3QxNG9tWmJ4ZyttSURDTzNISFV2?=
 =?utf-8?B?YUc1NEJici9XU0dmYUNaREpIU1ljSEJETmVDTHA5NE9RZFRHK2dXbVZtSUw5?=
 =?utf-8?B?VnZsUWJ4Y3JoamR0TXFOSFFQTGhPT2lQZVgrbVYvTE1DRjBHSEo4TGcvT3BY?=
 =?utf-8?B?cTd6dDRzNHhNRkEzQzRnV0hNL3RueVV0elRtdjlCYzhKOUNYZ0lIbGhnQ2p3?=
 =?utf-8?B?NWRyOHViYnVDdHRnNUpTZzhwOUhqWVhOdXp4Y3hZcEZ2eVFrTS9LQ2NMSzk1?=
 =?utf-8?B?VVZQNks3RitBeVFsQzBEU3M3UjFQZHZpQXFuOUtaT0tsc3U0NnZQcVQ0elJI?=
 =?utf-8?B?THlEVEtsN0cxbWNsWDhDWTJxbXh6SHBQN1U1Mm9XMkx6MjA5cVdPbjh4T2FW?=
 =?utf-8?B?ZW1JR2lKa3Fia2tCRUhmbTV2cjJ5Q044aHJNRDFBTitWNjJiWTBzTjVUSnQv?=
 =?utf-8?B?Rnp0ZjJsNy9iNWFhc09UZnd0VWloclVnb0NQSlZYaGhxaUtIUnh5TXF6VnpQ?=
 =?utf-8?B?YkpmNE03a3B0aUVUcXZyRlA4dHYrWjNPN0VEdlpsY2ZUWm9VTld0bkZ0U3BG?=
 =?utf-8?B?YWgvSEczd0pWYUJkdmJaNjRZVmdDNjFXUWNWZXJmeE50OVZFVXhPb0x3SFdp?=
 =?utf-8?B?MzJ3VUJiaENtT1pPZThjWDJMTnJxenVaRnZoUnVQelhNOEt2OFlRMjU0cmRP?=
 =?utf-8?B?THpDdVNJRkFtbVFPMUNrTjNaS3NrcmdFR1RITzc2U0lTMW1aL3RDcndWeE44?=
 =?utf-8?B?VWRHSEJsRXlEeWU3ajZKVXhlY3JNQmxjNUprblVYVDFsdldrU0dETEFERHB0?=
 =?utf-8?B?bkozUUZVZ2ZtV3ZaQjQwM1l1OWRxNURiUkdNY0ZoamlvVXR3cmVxUkhOY1J1?=
 =?utf-8?B?OFltVzBTUTZKbVVJUTg0MnR6MW1YSFhuNjhhWHJET1V1MGEvSXU1akxmZXMy?=
 =?utf-8?B?c2NEQVZjbU1WemtOaXkzYUsvbml1ZzFodWFxYnBHU0kxUmRMQXBwenQ0V1Vo?=
 =?utf-8?B?Ulg0NWdQKzZBazhMUmczMHFXQmgyeUV6TnhpOHJOVHhzdUpSZGFzRFZOQzNa?=
 =?utf-8?B?M2p5YkxuekZlSFo0N295VU04NkVtWGVEcDB6VXlCWVo3RnlXUlBSM2FBdExM?=
 =?utf-8?B?dE4wUC9GOUROQlllK0l1cVdQUzJQVFZJNGZ3dHpXMUJwdHAyVGNTTDJiR2JM?=
 =?utf-8?B?SG5VeXQxNDQvV2dMOS9FRlcydDdQbkJXOHVDSGh0UWpxM1NPd0hxbU5VWFZ6?=
 =?utf-8?B?SFo2RktiSFZmb1Y3QmpNNlpOeHl5SjVzS0RWZ0JLbWVmcUpKNkcwdWlJUUpX?=
 =?utf-8?B?SlRQbTliTlh5TzBGdzRtZ2tTWU4xdDl4VHVJVkFTcHh6UWRJdi90WVJueVdO?=
 =?utf-8?B?aXJRK3RsWGdacEI0cXVSOWhJSGR2THI2T0tMTmd4T0h0TVVwQkxyR2w0MnAv?=
 =?utf-8?B?RHdoa0xvSVRkbnFnVU1aeWxkcnUxYm1xMWkvdGlmVHB4dVErck85aCt0TCtJ?=
 =?utf-8?B?NENtcFNlanoxUGcwNkhUWFFWeFRPZHNkdTJIWlF4dXAvUDhaYUJBbjNaelZq?=
 =?utf-8?B?ZUtKM3NieTEwRWJ1U2ZMdG4rbHRWVnQyK0RlUEM4Q0ptbG8xd3hmQm5QRmkv?=
 =?utf-8?B?amQzaU5zS1JFdzMzR2E2d2pMV3NXbVovRGtDeUpXM0FIaCtEK09uQnlkeXBR?=
 =?utf-8?B?ejUxT3ZzUXBnNW80alZSbDRPSi92WlNybjBVWXBjaUxtTHhhUE1JQXd0bEhR?=
 =?utf-8?B?RitZWWlVUXZTS3hsOHdyZFNtaEQwS1Z0UTh1UWVOaStETGNYR2ZsWlNmOUcy?=
 =?utf-8?B?THRBWFZOWS9QemFGMzkyczc5K3pyMFo2TXZCb0pObjRMODdFNWo0MUIycndT?=
 =?utf-8?Q?H2+M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310d816e-091a-42a6-bba5-08db7d93e492
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 20:10:35.3534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmDd07SL/6uHCsavOVQmTX66VVuoe+PW7xBpxPZexyAhjT3Y3bSwSwPtGUmrBfJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156
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

It looks good to me. The series is:

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2023-06-27 00:48, Lang Yu wrote:
> Replace the old ones with psp_execute_load_ip_fw_cmd_buf.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 31 ++++---------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  9 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 +---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  4 +---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +---
>   9 files changed, 20 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a1cb541f315f..b61963112118 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2474,21 +2474,11 @@ int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
>   	return ret;
>   }
>   
> -static int psp_execute_non_psp_fw_load(struct psp_context *psp,
> -				  struct amdgpu_firmware_info *ucode)
> +static inline
> +int psp_execute_non_psp_fw_load(struct psp_context *psp,
> +				struct amdgpu_firmware_info *ucode)
>   {
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
>   }
>   
>   static int psp_load_smu_fw(struct psp_context *psp)
> @@ -2946,19 +2936,6 @@ int psp_rlc_autoload_start(struct psp_context *psp)
>   	return ret;
>   }
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
>   int psp_ring_cmd_submit(struct psp_context *psp,
>   			uint64_t cmd_buf_mc_addr,
>   			uint64_t fence_mc_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index bd324fed6237..e49984a9d570 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -459,8 +459,6 @@ extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_inde
>   			uint32_t field_val, uint32_t mask, uint32_t msec_timeout);
>   
>   int psp_gpu_reset(struct amdgpu_device *adev);
> -int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
> -			uint64_t cmd_gpu_addr, int cmd_size);
>   
>   int psp_execute_load_ip_fw_cmd_buf(struct amdgpu_device *adev,
>   				   struct amdgpu_firmware_info *ucode,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index d37ebd4402ef..1805cd042d34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1257,3 +1257,12 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev)
>   
>   	return 0;
>   }
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
>   			struct ras_common_if *ras_block);
>   int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
>   
> +int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index c975aed2f6c7..74cd1522067c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -881,9 +881,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
> -				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
> -					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, 0);
>   
>   	/* force RBC into idle state */
>   	rb_bufsz = order_base_2(ring->ring_size);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index bb1875f926f1..79d40203c952 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -912,9 +912,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>   
>   	ring = &adev->vcn.inst[inst_idx].ring_dec;
>   	/* force RBC into idle state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c8f63b3c6f69..9e1570648b6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1037,9 +1037,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>   
>   	ring = &adev->vcn.inst[inst_idx].ring_dec;
>   	/* force RBC into idle state */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 2db73a964031..4febc7629512 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -993,9 +993,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>   
>   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 5d67b8b8a3d6..ce8c766dcc73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -778,9 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>   
>   	if (indirect)
> -		psp_update_vcn_sram(adev, 0, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
> -			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
> -				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
> +		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>   
>   	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
>   
