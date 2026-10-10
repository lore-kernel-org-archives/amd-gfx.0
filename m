Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B58CA9EBB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 02:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FFA10E535;
	Sat, 10 Oct 2026 02:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5rcjVvVF";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4711B10E535
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 02:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oatosQSnxyc5xeDstgcw5h8UvJSjLdYQnRpjfi4UbRgjA10FbnM9F0kA8gCZMGZZSZShfnAoe54ny2i0qh3uTEmZpWRa9EdixR9MTLVy4A1I/4BfSlLGxGPVGhxM60tSLIone2SWw04p1YZhYvEMg7HT5QHwMV1u7m8+8Vzj9uUQEahBmz/R9cY2t1ES5UUiHBimZIc62oUDhzgWTKMtgIJBAS2VvldeOA1TLtRpL/jpWX88Ey7ApVTDsn8XMbp82/Q8me+7+JmTvJLs3uQlLSVEIYLwBF5ogYP89nBp7+mwHSZloHU8VM/+q6X2CRwlyZoHbmj8p6L37FsbGdROLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIdE7M6XclEe9LoufJ5tzP9QvDlhaUBD1/SykSMUL1I=;
 b=JkWxKEQshKpK6f96zi/koXg/ESJx9necwxXfPtBV2iXLgBjutO5DYzBfSGIPodw7mDc4kVYPMnwPHDiQ3jlwuz8lgAL6YIq175anw091Zp8f7DepjtUBYGPxsjZmK8Xwaj9Sz+ws+gcUDN/2FYYBMTCXcUBRx2EY0tUWEY3TPKRmlv7IyWV7nActBhpTKQn6eM9GwXis6N/IKdnnxJKW2KXpfPQPtKijtwQY1wDFMEw9HHq1WgJfSNRgWpXP63mNCgtJuirL6zCEiQHrhFwf55LFQbzQr1IXwAQEsmliUAxjGBi6Cq3E5nuX6NBD9pgTWYFRRlZEiQNqhb1SFk9VWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIdE7M6XclEe9LoufJ5tzP9QvDlhaUBD1/SykSMUL1I=;
 b=5rcjVvVFN4arloWjnKnnDZKpyFpG0bTAoff9/ujktpE8nqnSb1G3kJrGa4DVKDucbHPJUNAgB28FrdKPA8Kowv0tSC0iRshoJhHgYSWhc2a7o368e6IBxqjcQsJKR/Dyx2ai6ZlYGpYgXFZT52+BscxW+u/cvbu/Ex9sbRNKPzo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sat, 10 Oct
 2026 02:16:09 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 02:16:08 +0000
Message-ID: <70806b81-227e-48b7-a839-0c9092d61496@amd.com>
Date: Fri, 9 Oct 2026 20:16:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amd/display: Simplify debugfs token parsing
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>
References: <20260924114049.55201-3-tvrtko.ursulin@igalia.com>
 <20261002081041.69497-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261002081041.69497-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:303:85::17) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd3b3c4-3d46-4e4b-56f4-08df26747238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|6133799003|3023799007|261009223027099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eIbqSFeECwPem65eM1M1ZQP+C5NWiijObv5B0tlcc42cbBqZu4trOt+Jx/+P1ZT04X2NffIFN+EGp0ZK/3MT2BW+FEHiyB6FvOY/9OwE/eCx1si4DGwf75CXM15fiyw7VQEogNBXzhJeN5LDifmYffc2D0xBOCGLWqwBHSqVS8pNkn+fOzB47o8NAiJ/3kjHgjMIDT2MWia1k4Z91TzrXqM99Z2GUkA7+mNoViwPar+cUkMx28ZW7JlcE+zm1GWIihrqogM/8uT+83Mu3qqAegxMYH9sB87f/ef/k0avd5xK26+NcZvEsbXVpJMzS/nquWhaY8Z5eUbli5MTffyYEgXef62QgPWwF7EqRHCnRXyY7IDTjmOz/4R63rfshQAPllpZpgDUQRI7UyKkufiduSA7BjqTdSem9UNXe/dSY0CAvdoiuRnOmw2K1cislVSRFEPpu1wu+JkXLvkotLdQXMr+718TIOcPgR5P7+xy10G4F/wPRA6Njc9K5Y6tEAtbXUzhjhhE5ojbl8FjHo1B/jcVdWMq1fYC6PznBNcquM0CyUbh1ASNc8pxBfWe5GkbWh/7RgHBAapZ1pZxMUZddxMECXM+633lNfutg+nLJbNdPSaukY0Mb1ztFXW1xckvZsV9ZkO8TDkRtzmc07c5Tm28144lN699ae3/nZgusaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(3023799007)(261009223027099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFJFbmlOam1pSGxhbFIwY2E1L0VJWHd2V0h5YWN2RGZwVGVCNVljVXBZblBh?=
 =?utf-8?B?Tk9wVmZqQXBicE9qUHVaaGs4MzJhUWs0Wjd2N1Bjb1A0SlRCZGsra2RiL1pF?=
 =?utf-8?B?Wkoxd0p1RGJjNTdYWUczdDVubCtXV2ppdUdRankvOHdaWU9KN0RpbUtMbTFn?=
 =?utf-8?B?NVRYV0pxU25YU0RWSDJDYUNwaFlHNk90V25XdlpRSWFWUitCWnl1UHB5TEgv?=
 =?utf-8?B?VG11dFZiRW0xdUtrMFlONldRTjROa2FlNFFBR3JneHY5NlhDZnNhQnpwaVhV?=
 =?utf-8?B?d2ZCUEtUTkxMRFRyRkdLclNxSEJqVGp4Um5kTDFDVWh5eXVGdlJ1dlhpSGpj?=
 =?utf-8?B?Z2xCL0VJeE5PVlowTFVWTnFwSW9SZUNiNUMvYlJlRkNqMlBKcFhocjJxckpR?=
 =?utf-8?B?TE5ZQUhsY0VoV0F3MXFCbFVBU08rVHRkM25ZaUNqUlkySG4wZnc0Ti9EcU84?=
 =?utf-8?B?bk1mNGxBcS84SzZDd1d3UnFoYnNMT0ZyOFEvUHlzeTVoQUdzVXlRRW13STVD?=
 =?utf-8?B?VGxBWGdhR0pjZDhxcU45ZUQvSzhoVFoxMWk1SnlBZHpHZlpNUWhvVWpsQm9V?=
 =?utf-8?B?K1B4WTBhd0pCc0V6a3hWZ2kxRUVZNWh2TEQyME5IM0NBLzRGUm0xdnZnWVdt?=
 =?utf-8?B?WjE3Q1RtK1Y4NDJIMUxGWURwUlFUcWFNamFhWmZxWXBmeS9LOEw5bjdnS0VM?=
 =?utf-8?B?ZlA2U0xFd1BBMTlTSWlXLzVLbU9jdE16USs1YXVadW0wb3JmRGlydXFtc25G?=
 =?utf-8?B?bjE2Rzl6ZndvRzFtbmdxaVAxdW10ckNIaUowVm1hNTlHWExJR0QzNkc5dUNM?=
 =?utf-8?B?c0ZCSnpHSk1DOUIzaWVOYXcydjNpWWNVc3dNeDdmTWd4ZnFQMThpc2pyL00v?=
 =?utf-8?B?cHFHRC9Fb1VOQm1FcFh1OHJRUHQ1LzYzck01eUJoK3JkQUhUdmQrYzJXd0lD?=
 =?utf-8?B?NGJTN0pPVE15U3pYbjR3NSsydTNiQXYzaENnVXkrL3lyVkJvbGxkNnJCVFlQ?=
 =?utf-8?B?OHZGMFhXb3p6TVdUOG5lN01OYXJsdURjYzkxRzVwZzRHMjdCZlF4eGt6RnRV?=
 =?utf-8?B?cGdWeXM3Snp3Sk85d01YZm12Y2NRYW9ja1ZtbzlNaG5xempGSzc0VHEzUzg4?=
 =?utf-8?B?L013R1lldXZObXpRNlZITHgyR3NEMXkwcGpKcDdhMDdldjJYbUZlaXRWNUFH?=
 =?utf-8?B?dUFBWTVrQ0VtVzdLRnU4dHRVbmxUTTJmekZMQUVMOWZzdnNKRWEyeGs1S3Av?=
 =?utf-8?B?d256NFNuMHJZSmk2cDFuUzRLcnh3dHNQQjlYRnFhS0w0YWhSaW4zUHVxWUtI?=
 =?utf-8?B?VlNpTjBJT3VnbW9IY0c3S2xwUXBpd3RMUHFvWTJrdmNDaFFCd0F2bWhRbU9M?=
 =?utf-8?B?T1pHQm1wV1IzTmhSeUVVQ3NYazA5dS9JRE1Cb0Q5T2Zqak9WTzdYczcvaEJV?=
 =?utf-8?B?NWNpYkJYT2hqSFdWbGprRWt2V0RRb1FVaGFlLzc2dFRVT09Yb2J6SUtXN0hk?=
 =?utf-8?B?KzVhUk1jSENiSDN2eDFmYkU0SkRDbVNVL3dBV3ErN0RBaWVUcExQVW1zY2VL?=
 =?utf-8?B?SWhwR2FZUlgyVnNUY0lTNXEzckpNNXdDbFgwUFVlc2xGeGF3VFZ3R012cjJp?=
 =?utf-8?B?QmJlMEkrL0ZIZ2RmL2ZaVUhSWkJVN1ZQcWc3R2sxS3lpT2tFMGhCVnMvTjRq?=
 =?utf-8?B?NFI0ZHpKeklCNVRzQ3lPS3pMU2dGcEk5aDdSb0w3MEZ4aWYwUHpSbC81blc0?=
 =?utf-8?B?ZUhwOVJBMnQ3ZEdFQ0RTR3ovS3p2WGFQMU0ycEdHYWpybE95dEFOOC81T1BP?=
 =?utf-8?B?MEhpWVZ4L05WV0tYZWRRU0VncVQ2NUhYa09CZktZUllBSmJ2NTlqbU9UN3lh?=
 =?utf-8?B?WlJtN0ptTzAzamZiWFlqbTFsWUZhQTZnVml4b0NNVXRuQnVUclFxcHJGQVMr?=
 =?utf-8?B?OXM3UlQ3R1cyNWxsSkVDdU5YVXNkWDhVRDlBVElwaG5FNExxT3NZMGpWeDJZ?=
 =?utf-8?B?OEhxZkRTYXp6SE96Zm5ONWtKU2M3ZTI4dTlHbElTbFBGR0VEdGEyRWRhcnAx?=
 =?utf-8?B?ZjhwSW1XSTl5aE9Obi9OWmgzWE5JWWpaL0lGWDlWQmYvWnF1VjZ4cFVuckZF?=
 =?utf-8?B?LzFMZ1dsVzRIa250Vkdvcm9JY3JidlVVNGlNMjd0YnRPZ3IwWERaQjd6VVA2?=
 =?utf-8?B?a1RhL3BtMjhLOGh0YVRXTkhtNk1MaFlnZzFUbU1mQ21WQWZ4L2xmNGdSMjlF?=
 =?utf-8?B?eHdteUZhNjVOdjc5eFVCRm5vOVZ4VXg1Z2lMT0JoamVScUVwamtrYkhBR0dM?=
 =?utf-8?B?dVg1TUc5TEY5MHhVSmZ3bzRSRjcrTGUyRHpkeURLVHJzV3RtczF6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd3b3c4-3d46-4e4b-56f4-08df26747238
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:16:08.7050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7z9Y3cHyxsVOxM1lH9V/SdR9girh2FHxKoiFzr/UB1YEJ85za2dv2zDsqiRb+cGB4WBVQ0a3JzaLplOyydBbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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

Hi Tvrtko,

checkpatch reports the following warnings and errors:

WARNING: 'lenght' may be misspelled - perhaps 'length'?
#21:
always copying a hardcoded lenght regardless of what the userspace had
                            ^^^^^^

ERROR: that open brace { should be on the previous line
#349: FILE: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c:652:
+	struct dc_link_settings prefer_link_settings =
+		{LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};

ERROR: that open brace { should be on the previous line
#351: FILE: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c:654:
+	struct dc_link_settings cur_link_settings =
+		{LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};

total: 2 errors, 1 warnings, 813 lines checked

On 10/2/26 02:10, Tvrtko Ursulin wrote:
> The current token parsing is complicated, conflicting with itself, broken,
> and also results in a lot of duplicated code throughout.
> 
> Lets simplify it by replacing the two pass (count arguments + parse them)
> with a single strsep driven pass. The current two passes disagree on the
> set of separators and this makes it consistent.
> 
> Then we also pull all of the repeated boiler plate into the helper -
> buffer allocation, copying, checking pre- and post-conditions. This
> removes a lot of the error handling from all the callers.
> 
> And another bug fixed, lucikly mostly harmless, where copy_from_user was
> always copying a hardcoded lenght regardless of what the userspace had
> actually written. Assuming the userspace memory was backed it would copy
> neighbouring garbage into the string to be passed, or -EFAULT in theory
> but probably none of the exercised callers to date constructed their
> buffers in a way that can hit the latter.
> 
> There are some behavioural differences though to call out:
> 
>   * Before tabs were counted as separators but never split on. Now they
>     become full separators.
> 
>   * Previously argument counting stopped on a newline but parsing was
>     considering them as separators. Now they are always considered
>     separators.
> 
>   * kstrotol failures used to be logged but assumed zero argument. Now the
>     code errors out.
> 
>   * dp_dsc_passthrough_set had no error handling and writes with no
>     parameters but not otherwise invalid would silently result in a
>     successful disable of dsc_force_disable_passthrough. Now the debugfs
>     write would fail.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Alex Hung <alex.hung@amd.com>
> ---
> v2:
>   * Fixed buffer leak.
>   * Improved commit text.
> 
> v3:
>   * Undo some over-eager initialization removals. (Alex)
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 540 ++++--------------
>   1 file changed, 124 insertions(+), 416 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 969e1361a5da..ee2675909e4a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -67,76 +67,46 @@ static const char *const mst_progress_status[] = {
>   	"clear_allocated_payload",
>   };
>   
> -/* parse_write_buffer_into_params - Helper function to parse debugfs write buffer into an array
> +/* parse_params - Helper function to parse debugfs write buffer into an array
>    *
> - * Function takes in attributes passed to debugfs write entry
> - * and writes into param array.
> - * The user passes max_param_num to identify maximum number of
> - * parameters that could be parsed.
> + * Function takes in attributes passed to debugfs write entry and writes into
> + * param array.
>    *
> + * The user passes max_param_num to identify maximum number of parameters that
> + * could be parsed.
> + *
> + * Returns zero on success or a negative error code.
>    */
> -static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
> -					  long *param, int max_param_num,
> -					  uint8_t *param_nums)
> +static int parse_params(const char __user *ubuf, size_t size,
> +			long *param, unsigned int max_params)
>   {
> -	char *wr_buf_ptr = NULL;
> -	uint32_t wr_buf_count = 0;
> -	int r;
> -	char *sub_str = NULL;
> -	const char delimiter[3] = {' ', '\n', '\0'};
> -	uint8_t param_index = 0;
> +	char *buf, *tmp, *token;
> +	int ret = -EINVAL;
> +	unsigned int i;
>   
> -	*param_nums = 0;
> +	if (size == 0)
> +		return -EINVAL;
>   
> -	wr_buf_ptr = wr_buf;
> +	buf = memdup_user_nul(ubuf, size);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
>   
> -	/* check number of parameters. isspace could not differ space and \n */
> -	while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {
> -		/* skip space*/
> -		while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
> -			wr_buf_ptr++;
> -			wr_buf_count++;
> -			}
> +	i = 0;
> +	tmp = buf;
> +	while ((token = strsep(&tmp, " \t\r\n")) != NULL) {
> +		if (!*token)
> +			continue;
>   
> -		if (wr_buf_count == wr_buf_size)
> +		if (i == max_params)
>   			break;
>   
> -		/* skip non-space*/
> -		while ((!isspace(*wr_buf_ptr)) && (wr_buf_count < wr_buf_size)) {
> -			wr_buf_ptr++;
> -			wr_buf_count++;
> -		}
> -
> -		(*param_nums)++;
> -
> -		if (wr_buf_count == wr_buf_size)
> +		ret = kstrtol(token, 16, &param[i++]);
> +		if (ret)
>   			break;
>   	}
>   
> -	if (*param_nums > max_param_num)
> -		*param_nums = max_param_num;
> -
> -	wr_buf_ptr = wr_buf; /* reset buf pointer */
> -	wr_buf_count = 0; /* number of char already checked */
> -
> -	while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
> -		wr_buf_ptr++;
> -		wr_buf_count++;
> -	}
> -
> -	while (param_index < *param_nums) {
> -		/* after strsep, wr_buf_ptr will be moved to after space */
> -		sub_str = strsep(&wr_buf_ptr, delimiter);
> -
> -		r = kstrtol(sub_str, 16, &(param[param_index]));
> -
> -		if (r)
> -			DRM_DEBUG_DRIVER("string to int convert error code: %d\n", r);
> -
> -		param_index++;
> -	}
> -
> -	return 0;
> +	kfree(buf);
> +	return ret;
>   }
>   
>   /* function description
> @@ -248,36 +218,18 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
>   				 size_t size, loff_t *pos)
>   {
>   	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
> -	struct dc_link *link = connector->dc_link;
>   	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
> -	struct dc *dc = (struct dc *)link->dc;
>   	struct dc_link_settings prefer_link_settings = {0};
> -	const uint32_t wr_buf_size = 40;
> +	struct dc_link *link = connector->dc_link;
> +	struct dc *dc = (struct dc *)link->dc;
> +	bool valid_input = true;
>   	/* 0: lane_count; 1: link_rate */
> -	int max_param_num = 2;
> -	uint8_t param_nums = 0;
>   	long param[2];
> -	char *wr_buf;
> -	bool valid_input = true;
> +	int r;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		kfree(wr_buf);
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 2);
> +	if (r)
> +		return r;
>   
>   	switch (param[0]) {
>   	case LANE_COUNT_ONE:
> @@ -308,7 +260,6 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
>   	}
>   
>   	if (!valid_input) {
> -		kfree(wr_buf);
>   		DRM_DEBUG_DRIVER("Invalid Input value No HW will be programmed\n");
>   		mutex_lock(&adev->dm.dc_lock);
>   		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, false);
> @@ -328,7 +279,6 @@ static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
>   	dc_link_set_preferred_training_settings(dc, &prefer_link_settings, NULL, link, false);
>   	mutex_unlock(&adev->dm.dc_lock);
>   
> -	kfree(wr_buf);
>   	return size;
>   }
>   
> @@ -380,39 +330,21 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
>   				 size_t size, loff_t *pos)
>   {
>   	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> -	struct dc_link *link = aconnector->dc_link;
>   	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
> -	struct dc *dc = (struct dc *)link->dc;
>   	struct dc_link_settings prefer_link_settings = {0};
> -	const uint32_t wr_buf_size = 40;
> +	struct dc_link *link = aconnector->dc_link;
> +	struct dc *dc = (struct dc *)link->dc;
>   	/* 0: lane_count; 1: link_rate */
> -	int max_param_num = 2;
> -	uint8_t param_nums = 0;
> -	long param[2];
> -	char *wr_buf;
>   	bool valid_input = true;
> +	long param[2];
> +	int r;
>   
>   	if (!dp_mst_is_end_device(aconnector))
>   		return -EINVAL;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		kfree(wr_buf);
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 2);
> +	if (r)
> +		return r;
>   
>   	switch (param[0]) {
>   	case LANE_COUNT_ONE:
> @@ -440,7 +372,6 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
>   	}
>   
>   	if (!valid_input) {
> -		kfree(wr_buf);
>   		DRM_DEBUG_DRIVER("Invalid Input value No HW will be programmed\n");
>   		mutex_lock(&adev->dm.dc_lock);
>   		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, false);
> @@ -473,7 +404,6 @@ static ssize_t dp_mst_link_setting(struct file *f, const char __user *buf,
>   	mutex_unlock(&aconnector->base.dev->mode_config.mutex);
>   	drm_kms_helper_hotplug_event(aconnector->base.dev);
>   
> -	kfree(wr_buf);
>   	return size;
>   }
>   
> @@ -599,41 +529,20 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
>   				 size_t size, loff_t *pos)
>   {
>   	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
> -	struct dc_link *link = connector->dc_link;
> -	struct dc *dc = (struct dc *)link->dc;
> -	uint32_t wr_buf_size = 40;
> -	long param[3];
> -	bool use_prefer_link_setting;
>   	struct link_training_settings link_lane_settings = {0};
> -	int max_param_num = 3;
> -	uint8_t param_nums = 0;
> -	char *wr_buf;
> -	int r = 0;
> -
> -
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		kfree(wr_buf);
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		return -EINVAL;
> -	}
> +	struct dc_link *link = connector->dc_link;
> +	struct dc *dc = (struct dc *)link->dc;
> +	bool use_prefer_link_setting;
> +	long param[3];
> +	int r;
> +
> +	r = parse_params(buf, size, param, 3);
> +	if (r)
> +		return r;
>   
>   	if ((param[0] > VOLTAGE_SWING_MAX_LEVEL) ||
>   			(param[1] > PRE_EMPHASIS_MAX_LEVEL) ||
>   			(param[2] > POST_CURSOR2_MAX_LEVEL)) {
> -		kfree(wr_buf);
>   		DRM_DEBUG_DRIVER("Invalid Input No HW will be programmed\n");
>   		return size;
>   	}
> @@ -674,7 +583,6 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
>   	/* program ASIC registers and DPCD registers */
>   	dc_link_set_drive_settings(dc, &link_lane_settings, link);
>   
> -	kfree(wr_buf);
>   	return size;
>   }
>   
> @@ -740,47 +648,25 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>   				 size_t size, loff_t *pos)
>   {
>   	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
> -	struct dc_link *link = connector->dc_link;
> -	uint32_t wr_buf_size = 100;
> -	long param[11] = {0x0};
> -	int max_param_num = 11;
> +	struct dc_link_settings prefer_link_settings =
> +		{LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
> +	struct dc_link_settings cur_link_settings =
> +		{LANE_COUNT_UNKNOWN, LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
>   	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_UNSUPPORTED;
> -	bool disable_hpd = false;
> +	struct dc_link *link = connector->dc_link;
>   	bool supports_hpd = link->irq_source_hpd != DC_IRQ_SOURCE_INVALID;
> -	bool valid_test_pattern = false;
> -	uint8_t param_nums = 0;
>   	/* init with default 80bit custom pattern */
> -	uint8_t custom_pattern[10] = {
> -			0x1f, 0x7c, 0xf0, 0xc1, 0x07,
> -			0x1f, 0x7c, 0xf0, 0xc1, 0x07
> -			};
> -	struct dc_link_settings prefer_link_settings = {LANE_COUNT_UNKNOWN,
> -			LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
> -	struct dc_link_settings cur_link_settings = {LANE_COUNT_UNKNOWN,
> -			LINK_RATE_UNKNOWN, LINK_SPREAD_DISABLED};
> +	uint8_t custom_pattern[10] = { 0x1f, 0x7c, 0xf0, 0xc1, 0x07,
> +				       0x1f, 0x7c, 0xf0, 0xc1, 0x07 };
>   	struct link_training_settings link_training_settings = {0};
> -	char *wr_buf;
> -	int i;
> -
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		kfree(wr_buf);
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		return -EINVAL;
> -	}
> -
> +	bool valid_test_pattern = false;
> +	bool disable_hpd = false;
> +	long param[11] = {0x0};
> +	int i, r;
> +
> +	r = parse_params(buf, size, param, 11);
> +	if (r)
> +		return r;
>   
>   	test_pattern = param[0];
>   
> @@ -811,7 +697,6 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>   	}
>   
>   	if (!valid_test_pattern) {
> -		kfree(wr_buf);
>   		DRM_DEBUG_DRIVER("Invalid Test Pattern Parameters\n");
>   		return size;
>   	}
> @@ -878,8 +763,6 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>   	if (valid_test_pattern && supports_hpd && disable_hpd)
>   		dc_link_disable_hpd(link);
>   
> -	kfree(wr_buf);
> -
>   	return size;
>   }
>   
> @@ -1185,29 +1068,15 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
>   				 size_t size, loff_t *pos)
>   {
>   	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> -	uint32_t wr_buf_size = 42;
> -	int max_param_num = 1;
>   	long param;
> -	uint8_t param_nums = 0;
> -	char *wr_buf;
> +	int r;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   &param, max_param_num,
> -					   &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, &param, 1);
> +	if (r)
> +		return r;
>   
>   	aconnector->dsc_settings.dsc_force_disable_passthrough = param;
>   
> -	kfree(wr_buf);
>   	return 0;
>   }
>   
> @@ -1440,40 +1309,20 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
>   							size_t size, loff_t *pos)
>   {
>   	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> -	struct drm_connector *connector = &aconnector->base;
> -	struct dc_link *link = NULL;
> -	struct drm_device *dev = connector->dev;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
>   	enum dc_connection_type new_connection_type = dc_connection_none;
> -	uint32_t wr_buf_size = 42;
> -	int max_param_num = 1;
> +	struct drm_connector *connector = &aconnector->base;
> +	struct drm_device *dev = connector->dev;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct dc_link *link = NULL;
>   	long param[1] = {0};
> -	uint8_t param_nums = 0;
> -	bool ret = false;
> -	char *wr_buf;
> +	int r;
>   
>   	if (!aconnector->dc_link)
>   		return -EINVAL;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	kfree(wr_buf);
> -
> -	if (param_nums <= 0) {
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 1);
> +	if (r)
> +		return r;
>   
>   	mutex_lock(&aconnector->hpd_lock);
>   
> @@ -1484,6 +1333,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
>   	}
>   
>   	if (param[0] == 1) {
> +		bool ret;
>   
>   		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type) &&
>   			new_connection_type != dc_connection_none)
> @@ -1637,34 +1487,15 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
>   	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>   	struct drm_connector *connector = &aconnector->base;
>   	struct drm_device *dev = connector->dev;
> +	struct dm_crtc_state *dm_crtc_state;
>   	struct drm_crtc *crtc = NULL;
> -	struct dm_crtc_state *dm_crtc_state = NULL;
>   	struct pipe_ctx *pipe_ctx;
> -	int i;
> -	uint32_t wr_buf_size = 42;
> -	int max_param_num = 1;
>   	long param[1] = {0};
> -	uint8_t param_nums = 0;
> -	char *wr_buf;
> +	int i, r;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 1);
> +	if (r)
> +		return r;
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> @@ -1676,7 +1507,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
>   	}
>   
>   	if (!pipe_ctx->stream)
> -		goto done;
> +		return size;
>   
>   	// Get CRTC state
>   	mutex_lock(&dev->mode_config.mutex);
> @@ -1712,8 +1543,6 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
>   	drm_modeset_unlock(&dev->mode_config.connection_mutex);
>   	mutex_unlock(&dev->mode_config.mutex);
>   
> -done:
> -	kfree(wr_buf);
>   	return size;
>   }
>   
> @@ -1814,36 +1643,17 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
>   				     size_t size, loff_t *pos)
>   {
>   	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> -	struct pipe_ctx *pipe_ctx;
>   	struct drm_connector *connector = &aconnector->base;
>   	struct drm_device *dev = connector->dev;
> +	struct dm_crtc_state *dm_crtc_state;
>   	struct drm_crtc *crtc = NULL;
> -	struct dm_crtc_state *dm_crtc_state = NULL;
> -	int i;
> -	uint32_t wr_buf_size = 42;
> -	int max_param_num = 1;
> +	struct pipe_ctx *pipe_ctx;
>   	long param[1] = {0};
> -	uint8_t param_nums = 0;
> -	char *wr_buf;
> +	int i, r;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 1);
> +	if (r)
> +		return r;
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> @@ -1855,7 +1665,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
>   	}
>   
>   	if (!pipe_ctx->stream)
> -		goto done;
> +		return size;
>   
>   	// Safely get CRTC state
>   	mutex_lock(&dev->mode_config.mutex);
> @@ -1891,8 +1701,6 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
>   	drm_modeset_unlock(&dev->mode_config.connection_mutex);
>   	mutex_unlock(&dev->mode_config.mutex);
>   
> -done:
> -	kfree(wr_buf);
>   	return size;
>   }
>   
> @@ -1995,34 +1803,15 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
>   	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>   	struct drm_connector *connector = &aconnector->base;
>   	struct drm_device *dev = connector->dev;
> +	struct dm_crtc_state *dm_crtc_state;
>   	struct drm_crtc *crtc = NULL;
> -	struct dm_crtc_state *dm_crtc_state = NULL;
>   	struct pipe_ctx *pipe_ctx;
> -	int i;
> -	uint32_t wr_buf_size = 42;
> -	int max_param_num = 1;
> -	uint8_t param_nums = 0;
>   	long param[1] = {0};
> -	char *wr_buf;
> +	int i, r;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 1);
> +	if (r)
> +		return r;
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> @@ -2034,7 +1823,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
>   	}
>   
>   	if (!pipe_ctx->stream)
> -		goto done;
> +		return size;
>   
>   	// Get CRTC state
>   	mutex_lock(&dev->mode_config.mutex);
> @@ -2070,8 +1859,6 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
>   	drm_modeset_unlock(&dev->mode_config.connection_mutex);
>   	mutex_unlock(&dev->mode_config.mutex);
>   
> -done:
> -	kfree(wr_buf);
>   	return size;
>   }
>   
> @@ -2167,34 +1954,15 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>   	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>   	struct drm_connector *connector = &aconnector->base;
>   	struct drm_device *dev = connector->dev;
> +	struct dm_crtc_state *dm_crtc_state;
>   	struct drm_crtc *crtc = NULL;
> -	struct dm_crtc_state *dm_crtc_state = NULL;
>   	struct pipe_ctx *pipe_ctx;
> -	int i;
> -	uint32_t wr_buf_size = 42;
> -	int max_param_num = 1;
> -	uint8_t param_nums = 0;
>   	long param[1] = {0};
> -	char *wr_buf;
> +	int i, r;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 1);
> +	if (r)
> +		return r;
>   
>   	for (i = 0; i < MAX_PIPES; i++) {
>   		pipe_ctx = &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx[i];
> @@ -2206,7 +1974,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>   	}
>   
>   	if (!pipe_ctx->stream)
> -		goto done;
> +		return size;
>   
>   	// Get CRTC state
>   	mutex_lock(&dev->mode_config.mutex);
> @@ -2237,8 +2005,6 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>   	drm_modeset_unlock(&dev->mode_config.connection_mutex);
>   	mutex_unlock(&dev->mode_config.mutex);
>   
> -done:
> -	kfree(wr_buf);
>   	return size;
>   }
>   
> @@ -2592,36 +2358,17 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
>   {
>   	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>   	struct drm_connector *connector = &aconnector->base;
> -	struct dm_connector_state *state;
>   	struct drm_device *dev = connector->dev;
> -	uint32_t wr_buf_size = 42;
> -	int max_param_num = 1;
> +	struct dm_connector_state *state;
>   	long param[1] = {0};
> -	uint8_t param_nums = 0;
> -	char *wr_buf;
> +	int r;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 1);
> +	if (r)
> +		return r;
>   
>   	if (param[0] < 6 || param[0] > 16) {
>   		DRM_DEBUG_DRIVER("bad max_bpc value\n");
> -		kfree(wr_buf);
>   		return -EINVAL;
>   	}
>   
> @@ -2637,7 +2384,6 @@ static ssize_t dp_max_bpc_write(struct file *f, const char __user *buf,
>   	drm_modeset_unlock(&dev->mode_config.connection_mutex);
>   	mutex_unlock(&dev->mode_config.mutex);
>   
> -	kfree(wr_buf);
>   	return size;
>   }
>   
> @@ -2959,31 +2705,13 @@ static ssize_t hdmi_automation_enable(struct file *f, const char __user *buf,
>   	size_t size, loff_t *pos)
>   {
>   	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> -	const uint32_t wr_buf_size = 40;
> -	int max_param_num = 1;
> -	uint8_t param_nums = 0;
>   	bool hdmi_comp_auto;
> -	long param[2];
> -	char *wr_buf;
> +	long param[1] = {};
> +	int r;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		kfree(wr_buf);
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 1);
> +	if (r)
> +		return r;
>   
>   	switch (param[0]) {
>   	case 0:
> @@ -2998,7 +2726,6 @@ static ssize_t hdmi_automation_enable(struct file *f, const char __user *buf,
>   	/* Persist setting across sink re-detection/hotplug. */
>   	aconnector->hdmi_comp_auto = hdmi_comp_auto;
>   
> -	kfree(wr_buf);
>   	return size;
>   }
>   
> @@ -3768,39 +3495,22 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
>   				 size_t size, loff_t *pos)
>   {
>   	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
> -	struct dc_link *link = connector->dc_link;
>   	struct amdgpu_device *adev = drm_to_adev(connector->base.dev);
> -	struct dc *dc = (struct dc *)link->dc;
>   	struct dc_link_settings prefer_link_settings;
> -	const uint32_t wr_buf_size = 40;
> -	/* 0: lane_count; 1: link_rate */
> -	int max_param_num = 2;
> -	uint8_t param_nums = 0;
> -	long param[2];
> -	bool valid_input = true;
> -	uint8_t supported_link_rates[16] = {0};
> -	uint32_t entry = 0;
> +	struct dc_link *link = connector->dc_link;
> +	struct dc *dc = (struct dc *)link->dc;
> +	uint8_t supported_link_rates[16] = {};
>   	uint32_t link_rate_in_khz = 0;
> +	/* 0: lane_count; 1: link_rate */
> +	bool valid_input = true;
>   	uint8_t dpcd_rev = 0;
> -	char *wr_buf;
> +	uint32_t entry = 0;
> +	long param[2];
> +	int r;
>   
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = memdup_user_nul(buf, wr_buf_size);
> -	if (IS_ERR(wr_buf))
> -		return PTR_ERR(wr_buf);
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   param, max_param_num, &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> +	r = parse_params(buf, size, param, 2);
> +	if (r)
> +		return r;
>   
>   	switch (param[0]) {
>   	case LANE_COUNT_ONE:
> @@ -3816,7 +3526,6 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
>   		valid_input = false;
>   
>   	if (!valid_input) {
> -		kfree(wr_buf);
>   		DRM_DEBUG_DRIVER("Invalid Input value. No HW will be programmed\n");
>   		prefer_link_settings.use_link_rate_set = false;
>   		mutex_lock(&adev->dm.dc_lock);
> @@ -3853,7 +3562,6 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
>   						NULL, link, false);
>   	mutex_unlock(&adev->dm.dc_lock);
>   
> -	kfree(wr_buf);
>   	return size;
>   }
>   

