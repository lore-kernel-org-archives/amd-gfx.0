Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ED0C79F8C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 03:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5272510E332;
	Mon,  7 Sep 2026 03:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MTT5Mh/r";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1344910E332
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 03:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXE3OV6lbOIJO2pjmHzRbYNXSP5c6+jkAz7RF3EnxPGmnQiP6+nreujUHT2dRt53KYsL/6TmjBntHW3/qNdFtwECO09y+WOEv1cDCv+5LNurV18WCoyfFit+ufJlu76jzJZ4Dvfwv4A1Ci42qw+aOm/aoyxo33qoVIxNUx21wxBdzXjgInYeWhyYO2OjrcxB8RTfhOlxgdv0UPlzkoMAXbtvVpKAqUiTrZFjsHCcHvWzAf5dyDkAdmiFcJb5tppkEi8i7oYPkwaVTGcv3xuaFn5GE5Kve0TJjqkeIlFFXgRHb3h1xQSlWW/vto26ispnCfbZD/QiyNNTu+VBt7saAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FKyoOHYBYzInH5Nj0sT+Sc7bH1N4a+ejiV7OAouLRc=;
 b=YvNf/MMIvH2CRAPIrYEsywEZK0UJMMjj1A3hzn4cL1iFL11GTzyuV6vr+flwaiBbU3v416BSWey8dk5M3ZjmQ0p0xGYKhh2m63a94qPVEvT5qZeQbZY636D/VDaiGa+NaT+/UEKZeJ8niuPBzjLmIc9Z12Wmk3yMOn+niKp3W6I5UdCbxbxCt2epCc5Q+l64JsbDg8pDQlqM7BDpXR8mW1ZNnzzx4kqcdti45WKNFAXI0c+9dQLxWyFjZq0PmhxuTAlJj9/b2B6idn76cPZCTPm0pdmrNgqTSXqXnDSTpeV+rfhceuL0eFUocD3CIvNoQpq685xj0iLiEmVEG1zTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FKyoOHYBYzInH5Nj0sT+Sc7bH1N4a+ejiV7OAouLRc=;
 b=MTT5Mh/rkGbSicYN8+A6U3L4dl/+tV7Qa0VGHkKOVrkWVcNph6Fe7QKCbaA2It25Gyn6qPac5It8pONcwDLTBcoOhlxgbWOUF8Og5du79dpYKNhbQHiK2bxf1eu6iCJ6pGcL6xEC6DuK56ExixPUJGBLCWM8QLmgnkhPWU1lBco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Mon, 7 Sep 2026 03:12:11 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:12:11 +0000
Message-ID: <f7240fe5-c943-4b41-9518-c811a0b3eb24@amd.com>
Date: Mon, 7 Sep 2026 08:42:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Move GC v12.1 spm vmid init to hw init
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Le.Ma@amd.com
References: <20260903055603.65101-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20260903055603.65101-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0181.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c07ab87-1884-4252-a205-08df0c8dce9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dNF8n7MHa3jOKOfUwC7m9QqrBgMF2loL8nsKwTGpa7EVJzmCHUk73YVxoTEH1y1y36ryPmPDic/Anb1qiACcYJjHCAGB0KAI+5YdUi3oi9r9Je2qhBp2P08jStKgasK9TaWUOCet/jL/l40OehiNxX0k6Osia2C1v5weQmrd3t/vLhycNHKlaWLbvTVPYV9Z0+K459RL3PEfjDTcICZz6d5mtcRmGp+Ptg55gFg7w4rpMi+1NBbe56tw4E1u1FOZlBeLju/97KokBEAnGelde95oWkTGHlMbnIfWJifxRoTbis+KS+5qOqYJVYW+EejmUmGpu61lMToddrJmR7Gg5ivTIeQe2278URA4obh7hHFGqM547qYR8wNp60XGU5SeUJDoQedIqm0xx6SMJZs+lnhOhBZUDw2saVl3hi6CFO/Ta84n18O/QB8uuxxt+/yA56ITtAUM4FxQRsP1+6024W1LlSxbgRqu5XtiKRu/IUlY5qIWJQbcDBefDNfytCnEkn5FAdA5iXn9NzqeNPs6CW9oq33srihZ6cmsvpGrIJKlcGSucs1iCNUx+UwLCvzyxS6hroCrWoTZtNNir2vThsdzCB9qAZiwiu8Cvu+poeez/E6bJFCKXipeCnriQhsZCLStLouSgZSHuXxDFEQgYg0h3lMJN4+NAcB4Mm/BmQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWEwckYzTnZnYkFwRmhhWnI3Z3g4WS9QN1FnMU1hTysvczF4cXh3b2RmdkZt?=
 =?utf-8?B?UUcvNUs0aUhvL04wL291UlR3R0tjbjhNRkZuZnJQWGprdi9IazRnb01KT0c3?=
 =?utf-8?B?QXpQUG1icGloZkFYc0c1dTlmZjRac0hTZUhuK2NVbHdRSkU0WkRnZ3lqanpr?=
 =?utf-8?B?OVVHUmNXUE9xK2F3R1ArV3hsOTFwemlKTUMxYXd5bUQvSHBjbG8rL1ZwSTBu?=
 =?utf-8?B?b0JJWUI1NkdQUll3NGdQTTdWL0dXSmd1a21zcjR1VHptOC9jdkN2VlJ5aXFB?=
 =?utf-8?B?bjF6d0loTWxyR1dSc0s1dXlaWXR3TG14ZEViSC9rcG9rRkxoTWtkOWxmRDln?=
 =?utf-8?B?R0RPM1RaUzFVaFU4M0FTZVpoT256RU5aZjFpOFVNMVB3NHA5WDlvUmorWUQr?=
 =?utf-8?B?bzhQTkU3dUpwdEtNV3U3cldEMTlrQ2dSNE80d2RVUVNrV0xxQkdERVJtOHNp?=
 =?utf-8?B?czRQZnhLcHY0QVRpZnNwaUt3OTR6ZXNPRXh0eG1BZzQ4RGpWUy9QanE1WFht?=
 =?utf-8?B?V2NBeWlxRE0rbk9pTjN2TUdFdExaS2lWUStHR25laGptN1cydUFxOEd6VkEz?=
 =?utf-8?B?cFJJSno5U0d4TnJIaFI0Q1lKUWFubEJCcjZXc01pa0VGejU5YUFzWjZRS2k0?=
 =?utf-8?B?eE1Ob2YxTkN2Umc1YjlaN3lxK3VybVNTb3E1dVV6aGVHZlB0bkRrNGdDcWFE?=
 =?utf-8?B?dWNhZmxJL0diRTFzVWlUSU0va2hxVzkwTjFTWVYzU1N6QkZ4eGhQeUtVTDJx?=
 =?utf-8?B?aU1uWVlDbnZUcVMxallQN01TSlI5d3ZmQStkbCtWKzR0bm5zSGxNUFRoMHdR?=
 =?utf-8?B?eEkxcFE1K2ZhY1NkR2RVTWE2SUJHdWFtSnAvUEtLWExTNk1FTlRYUWxYaWNk?=
 =?utf-8?B?Vm12NWl2VVJ4SlVYT0dSemljSjhNemdnQk9kU1hXNU1xbktZWWNuY2VNc2Qz?=
 =?utf-8?B?aHAvNk02V0ZITklrREE2TnNXYkxmQUppMFpIVzFSYTNYRkFydTJYTDZvd2Fn?=
 =?utf-8?B?T2tHOElmeEtzN2Z0b1hBdmp1VDNSMHNsTVRSVXQvajFVWjhkV2l4V1RQY2xR?=
 =?utf-8?B?TVMySi9GRXdkTlhoZTN6NnFzSGFrQlVlZGgxYzhsMHFBWCt4d0d4SFQydktN?=
 =?utf-8?B?NnYrNHpTcHU0a1RuZm1YSmhZbkpDRWdOWUtYSS9aVElNcWZiVkpmSE1YVXB0?=
 =?utf-8?B?M0FqYkRQODZYcTFFTkVHOE9XUzVCcVJVZC9yTTMxcFBOSjUwK2xjc2pUU2xJ?=
 =?utf-8?B?cW1yV09XdXlUMXczcmFCSERnb3NORlJNNXNOcXFBdGJJTlFlcHF4K3NoeXBz?=
 =?utf-8?B?TjhNTzNwb3VPTHltZ3M5MDBFeWJoekJEU1lQUkxUd0xzQlBvRzBZWjBOazA3?=
 =?utf-8?B?bkdLNDFaMk1CUnFsQk01SGJXc3dCODBkUFpvTFhNOXZtZnBhdmxGUHlpSHNx?=
 =?utf-8?B?VG1MMEF3T0UwWVNHSXVaOEt0Tk8vZXA4SXVMaUZsajdDdEhyZ1h1TGNHc1Bs?=
 =?utf-8?B?bURiWkhqdFcxUFhEaDc5bXJxMmFsNkNteWNaL1loZE5sblZ3anU0djk4bWM2?=
 =?utf-8?B?elhsSzlab3oxbk5TWFczOU1lVHdDUFJYRThPYnZCSitZYXBjOEZIclZYajF3?=
 =?utf-8?B?eHc0Kzc3K0JtVS84bzNFSzh0REI1VmxMbytFSjZWNThkbklGQmVqd3FjdFVi?=
 =?utf-8?B?Qkt4bDlPNXJBZkpKeS9qU0hvQ2g3aWxWNVcvQWRJVW1qVi9rc3NTOXZRL2h5?=
 =?utf-8?B?Q21LbDBMWUxMVEhWV2dRRFdCdExPdjFqMnlGZ09jKzBXWDJGVzlLa0JLOW1B?=
 =?utf-8?B?SHhPS3RNV285cS9sYWJNQkN4VUdxcEsyd2QvNkt2VUR0cUV1TS9pUTVSUk1Q?=
 =?utf-8?B?NVBQV1dVSnhQNUFIQkI0eVhTSlo4Q3BOYWIxMWh3eVN3TW55dHlMSUI2UnV5?=
 =?utf-8?B?R1JNMXlCVmJNMUZWYyt6NkxRdlJaeGQwTEY2NjEzdFMxd3E0SlprekZnRjFE?=
 =?utf-8?B?emRNUnNnUW9lZWhrVGlDM3FRY0h2dEZybDdhUEV5M0xUMFlzSW1JNDYyUGxk?=
 =?utf-8?B?NWZLZzJoaW9zTFRUU241aXg5RHR4TzlVZ2s4RGFwc01YSGlraUdEZjVUb1FQ?=
 =?utf-8?B?VWVCQU5BYW5hSi8rZG1Vc0JyU0t4MDM4cms4UDhMNmJJdDRJZ1d4am9VdWdX?=
 =?utf-8?B?eENoTkhobFJrZHpCdzV1NjZwdDhBWlFEb2RudEsxcU9QemJRNXpZNnJXY3ZY?=
 =?utf-8?B?bmdSRlcwSlpPNHpLR20vNzJrVHlsOFA2YzZDa0N4QnVkY2M4RlpkN0NYSWFX?=
 =?utf-8?Q?jVogLWmnlwJykuJycc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c07ab87-1884-4252-a205-08df0c8dce9a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 03:12:10.9691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QV0BtAtjBW0rlpKybE//gZwzMTvkrCz10t2MzszXzcA3e7vbFaoVwETh4DTHVajD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

<Ping>

This is also a bug fix.

Fixes: ad5f1ee0a9b0 ("drm/amdgpu: Add initial support for gfx v12_1")

On 03-Sep-26 11:26 AM, Lijo Lazar wrote:
> GC reset is not released during sw init and hence it shouldn't be
> accessed. Move spm vmid programming to hw init phase. This programming
> may later be overridden with the job's vmid.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index f812d6d81e9c..1aa86b85ce88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -218,6 +218,8 @@ static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
>   static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
>   static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
>   	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
> +static void gfx_v12_1_update_spm_vmid(struct amdgpu_device *adev, int xcc_id,
> +				      struct amdgpu_ring *ring, unsigned vmid);
>   
>   static void gfx_v12_1_kiq_set_resources(struct amdgpu_ring *kiq_ring,
>   					uint64_t queue_mask)
> @@ -695,7 +697,7 @@ static void gfx_v12_1_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
>   static int gfx_v12_1_rlc_init(struct amdgpu_device *adev)
>   {
>   	const struct cs_section_def *cs_data;
> -	int r, i, num_xcc;
> +	int r;
>   
>   	adev->gfx.rlc.cs_data = gfx12_cs_data;
>   
> @@ -708,13 +710,6 @@ static int gfx_v12_1_rlc_init(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -	/* init spm vmid with 0xf */
> -	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> -	for (i = 0; i < num_xcc; i++) {
> -		if (adev->gfx.rlc.funcs->update_spm_vmid)
> -			adev->gfx.rlc.funcs->update_spm_vmid(adev, i, NULL, 0xf);
> -	}
> -
>   	return 0;
>   }
>   
> @@ -2005,6 +2000,9 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>   {
>   	int r;
>   
> +	/* init spm vmid with 0xf */
> +	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
> +
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		gfx_v12_1_xcc_init_csb(adev, xcc_id);
>   

