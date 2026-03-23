Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A50D58CDC
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 06:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F1E10E305;
	Mon, 23 Mar 2026 06:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vh+sb20p";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013023.outbound.protection.outlook.com
 [40.93.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8C710E305
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 06:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+POMisiyl0XEBGPTk4wSvVCFyPmIsZosSB/dsVlrNKbOQb6rWgkAf8/RC/C0IO9OoJK/0i6IPdm5n/u9z6zma0T+UJyVPSIkOIaiq6WZFTOG4UXlrqtVGyE5DlIT0pGwr93YXWegBip/+RXEBWIswbFDzPIepZcIMj15wzuhE27+c8btnUpmewjF5uF6KLFik5HFZob8I0Dx+izHIXcTzBaEz/AMrvUCZuL7IZrBrSd4HU8Qdl1A5kWeQUwtZnDrMNOStmDfO3fAh1As2pbxkeJnTC/5hLqY6NNF92Kjhjr99OnOdjgrtC6+j3jbiLuvAzo0rLwIhWhJqXNpNLefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+3tsYHsBXsejtDd13M5aA4KYwzmmGWprFyWfuiK4tg=;
 b=ImzQMgxALLKnhK+4yhJEwqD21S7Wt77EJ6hBuFhVV5Ov4XhY02j/PvooDIf7V+u/AhBxGsKqF7nqXiKLh0lQOtL3v1WjW7qTLVTD5PKHMmL8jbkYKRrEL2RXVzeZZNpY623wgq3qwE2wJ6c8MRoSIrW8GSV2jh/MOKhoKA/3SmwLDirymROdJZUK3IexstfnHpScTMAQiQCa0hOAupciJeun0nMcuDduOpBVq68XuTNLeV7yhrXVP8N+8h7Oy4QCPFOqq4BYFXPF1jVzYpR2C6FnPNWjL01HiUAxV5bpmaKOrljgdZ7Kdpg7KQ7f1sdZ/JpVpRVGKnwSWtc9y4Z+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+3tsYHsBXsejtDd13M5aA4KYwzmmGWprFyWfuiK4tg=;
 b=Vh+sb20plaE6pQt/C86s0RwyQ+/bezNK7mF1KO95MBbjnZGEEhz8fC/BJexXiKt+qEfhSfvQ2/fsyeRImHR/m01t4X+BE6r3kE+PaS3nNeEKonwFWI56NdmDtNxYjpdXChC4t+kgpRsDe1ZGgcwRHT7Fb1wE5HJaOHYjA2IK6DI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 06:28:23 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 06:28:23 +0000
Message-ID: <89ba634e-7929-4e1d-b4da-456c685756d0@amd.com>
Date: Mon, 23 Mar 2026 11:58:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu/vcn4.0.3: gate per-queue reset by PSP SOS
 program version
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260323060701.437428-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260323060701.437428-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c0a3fe-fcd5-4110-11bc-08de88a561f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: lITWDstLwwojdyZvGwcDer670xmepPFdlmvy4qYfAgaGuW73wt9VkBgBQxXKwlnxpFaMA7N5rybKrFqhInX9qARVQZn9XdOqXy0nrxt3BfjVc1a9Va5mkcUYw1MJ4hxvh52kPJ+MKeRrpO3OglNjPL/DjcMCCzZywNy0lf51qP4yCyu4a89mnwRunGXPismbjPXszuapy7mt9cNOIIQ6naiWhhRD55UDrBEUbg7JdAestXn7SzO4XYrCasXIenQV7HgBWx0YjQOakclhKzOUyA5IVBUTyI2yX43C9kwAkB3VUcj63n3UXdvLIWy4Il+0s7ScrKRUJXdtlKaTxbLv7VgtsSm+9GzBMaQOeBq3025zwLeezNp/QVIKmGIaZ8LeEIOQ0J4ZUfMZeZHW0kcvs/RMZSBGPYvBGCASok/yldcZQvfMifIX6U8/MK03I7wYGK3rQs2ewLf2D2Bc0T11ikPArRnMCeHLmSfcl3ZX6a+JiHmjPX5iGB+o1R1bdeRnKetNkJaXrQFVMkL1VUrP8MAadh+PhvJilMisNfoDhGQy6UfyPDcN79FF2gkWOkOlc6Lytq27qpEE7WomkxPL/9tCGcUXDNITFIxZbWgvVWr0pagi8FAj455oeqfJiDnVKWRNG5N8IIp1z7tc73XRN1RF8CHgf+fO2oZnecuJRDYxQJ76ZiNu+g2SKMRvjev+Tx89jRuU9MFMOB91I6/vsJrfp2jWCyBCWp75gucdRqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHd3SytpUjc4L1U3L2FvVm04djZ5aDJ2K3VXOUMzTkNKR2QxcVVHUVRlaS9T?=
 =?utf-8?B?UWVhbWtpSFgrNUUzNndpR2x5Q1kwSkZ4YVMyNmlxdkp0Yk1KcWFJczdNT1Mz?=
 =?utf-8?B?UEJkbHlLcE1DOFdCWEo4eEIzdnRIUDFjSWkxOHNqa28waE5vb05DMHdXSUFV?=
 =?utf-8?B?Wmtud2hUQTJUWS9vREdtUG9ra0R4RXYwSkFIYnJZb2ZrUVZvOFRIaXJtQlcx?=
 =?utf-8?B?T1NhajNtcEZscnRPZDJaOTlXKzViK3VpZzZiSzROQm5nM0RMaVFHeXlRY2d0?=
 =?utf-8?B?S2htMFNEL3dWdGNCbU1yMjI3YitYOFZkTlU5aWx5NmdIY3ZEcnh1UEY5aXpT?=
 =?utf-8?B?VDVqK2d0TktHNXR3YmM2eHlSb1d0SE1JSE1FcWVseXdWNWtXblNScHpkcFlv?=
 =?utf-8?B?ZDRUY2RvblBPaXgwdkpiMm1pTGdLWjh1L2w1ZmNUTlRGbXZLYlNITTM4eEkr?=
 =?utf-8?B?YU1DQW5scE1NWk81SEhqbjh1LzJaV2VHRHV4T0RPSFBYSDhick9PNW41NUV3?=
 =?utf-8?B?YWE1VmdJdXByOEZmMC9aWTlzYXF1VzdmazFGOTBQbnJRNEhycmxRQnpyMVdG?=
 =?utf-8?B?NEVzMmF2Z2FxejcxK0VtUEQ4a0FxalFMT2hkZUtnMHduLzlROWQwL09zcEZV?=
 =?utf-8?B?WG5ucW1YYVh2M1JHNGxXVTRoTUE4cVoyNGRRK2tqVXlKc0dFMFZid3lsZ29T?=
 =?utf-8?B?OUJSWnBLL09JVWRVc084L2ZHMHdOTW9MMDRGV2ZnWjA2TnA4ckxZcWRhbi91?=
 =?utf-8?B?RG5WODRzSkFxTS9vR01oa0ZWQnhoRWtZWURxbm0xdFJoYXEvYWtoWVpwZmhv?=
 =?utf-8?B?V0t4OVJ3a0NHMVJTMEw4V2R4ejJjYklSckpjbm9rQndBKzk0Z0hJUFkxQWd4?=
 =?utf-8?B?amQyQ0o1bFFabXV5WCtST0Q1S25zMS82U3grL0xNOVNnODBncC9VMHJnbWlk?=
 =?utf-8?B?RlRTMmF1QW5ISzczQ0U0MjRVL1k5UEFGODNlc09CWVVOQnNOZjBBWXpGU2xF?=
 =?utf-8?B?ZDd2ekcwaG5vN0FMQXNHUGg1TGZLK3l5Qkdtd0hiUmlGc1JyOVpsU0JaYkwv?=
 =?utf-8?B?eDZYMkVqdTZIQnJxL2dDMzFsdVpiM0N4TnpJM25mVmFjZGdPSldaNGV6d3Ja?=
 =?utf-8?B?UjlwSHpFK013NHZyeGlrT3FsZkdXN0ZINVJvdUY1ZVp5Yko2cXdJWTJ1clZR?=
 =?utf-8?B?RUtHVmdycmh4R04zZFhsOGhGRWhzRVc0ZU5TajZUOGUrSEZreS83RjFjQmcw?=
 =?utf-8?B?d1RVdjJ2UXVja3M3UUdwcEVFYVNxL0ZjTXR1M0lBdGpHK3dQd1h6RDdRQlBV?=
 =?utf-8?B?T1BJdFQ2R2NpUFg4aDF4dW9sQVMySThSc2RMNi9idVM5WXI2V0lmWVBoZVB5?=
 =?utf-8?B?Vlc3YmtSU012Z09RcnErNlZ1NVluTUtJK3hsMzNzb29NUmtPcFdQelBEQkFr?=
 =?utf-8?B?TExJUHQvUk1UTXIrdmdMd3J4WGpUQWhnM1grd1YzSXZ2ODdZb2FtaTd3RzN5?=
 =?utf-8?B?Y1hXRXpObUNlbGY4b29BZ015NHFGSU4rZ0tHK2VwNk1LZ0NxRlZHUzdxVytJ?=
 =?utf-8?B?ZmlSQzhmOGtMUGV2YmVPMFFVRnBjdlBuVXBGSjFFb3JaOTBYWFhkQmtxRFBI?=
 =?utf-8?B?QzU4aEFRTW9KSkE3Q3JsWHFuZXNoUDFZSXhKSGtObFlGSmd0eGJJdUN2WUs4?=
 =?utf-8?B?OHh4cTVXa1pKbEgvdUk3Qi9zeWNCdWgrYjRDRXdCZjh5SzVKQlVOWDlSSm91?=
 =?utf-8?B?RDcxSjNJSktua1czRVE3MjVnbm5lVlp3dE9CcU5QNVdYZWIzVWhDRmNHOUQ3?=
 =?utf-8?B?cEhDZ3Boa2h2VXdTbEhXNjllc3Z4VmE4cStNU0o4cVBJNytIK2NhRjk4bUdw?=
 =?utf-8?B?cHFCRW9qSGFhRkRxNnhUQno5N2M2WElxOVNRdWVHMHM4OENQM0RJMjBkQ3JM?=
 =?utf-8?B?d2NxaEpaR0V0THRPQlJNVXhra2N2Z08wOXRjTEhBcWZLTUo4ekprV0IvRGhl?=
 =?utf-8?B?SVBocks5a2E1Y2k0VWdjeDhSR0JMOHRpYVFsSGV6VlFFQ1A1REZZTU1OMU5U?=
 =?utf-8?B?SFNQSGcydEhQc3V2d2h5djF3TnMyZXd3UTd1MUhPS0VnUEZGOTA5THdyYmZJ?=
 =?utf-8?B?alhuOHJkRHZ6T1ZySmM1MXEzRVBXdmRUZUk2OUxWcnNueEtxc0RvUEErS2Rq?=
 =?utf-8?B?NXd3REc2NkY0NDU2YVgzU1RwbDlmcTRUVW9mcHN2cFNpNWRyV1ozV2Rub2o3?=
 =?utf-8?B?OFdMSmRaUzRNck5OTm5iQzRLTGVtbEUxdlBZUFZUamEvRkt3R2Q0Vjk1Nmdn?=
 =?utf-8?B?bTJBUEZXSnN4YWthT2k4VElTeE5tUWxsa24zZGFBS1V6Y0UrSldvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c0a3fe-fcd5-4110-11bc-08de88a561f7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:28:23.1369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpckiR6lnoleRl4RxRJAZQtYX3KXonF6zAmd8G33BmV2F3vI4gwbw+deDm1YkzgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603
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



On 23-Mar-26 11:36 AM, Jesse.Zhang wrote:
> Add a PSP SOS firmware compatibility check before enabling VCN per-queue
> reset on vcn_v4_0_3.
> 
> Per review, program check is sufficient: when PSP SOS program is 0x01,
> require fw version >= 0x0036015f; otherwise allow per-queue reset.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>

This is not my suggestion :) The patch adds PSP FW version check and 
that logic remains.

> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

One minor comment below -

> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index e78526a4e521..ff3013b97abd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -134,6 +134,21 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> +static bool vcn_v4_0_3_is_psp_fw_reset_supported(struct amdgpu_device *adev)
> +{
> +	uint32_t fw_ver = adev->psp.sos.fw_version;
> +	uint32_t pgm = (fw_ver >> 8) & 0xFF;
> +
> +	/*
> +	 * FWDEV-159155: PSP SOS FW must be >= 0x0036015f for program 0x01

Usually we don't put internal ticket information in comments. You may 
want to remove the ticket reference (version comment may be retained, 
but it's also obvious from the logic).

Thanks,
Lijo

> +	 * before enabling VCN per-queue reset.
> +	 */
> +	if (pgm == 1)
> +		return fw_ver >= 0x0036015f;
> +
> +	return true;
> +}
> +
>   static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> @@ -141,7 +156,9 @@ static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
>   	adev->vcn.supported_reset =
>   		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
>   
> -	if (amdgpu_dpm_reset_vcn_is_supported(adev) && !amdgpu_sriov_vf(adev))
> +	if (amdgpu_dpm_reset_vcn_is_supported(adev) &&
> +	    vcn_v4_0_3_is_psp_fw_reset_supported(adev) &&
> +	    !amdgpu_sriov_vf(adev))
>   		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   
>   	return 0;

