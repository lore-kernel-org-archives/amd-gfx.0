Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C53CC27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 19:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBC810E239;
	Fri, 14 Jun 2024 19:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0eTY58N";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E2210E239
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 19:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc1IRhAtHWMR00YfiiK8QAeuFtg0iPp+7/5WnZJ6acfqqQLgALDCZjncTzYqcWPmXHfA8QevtOc3qqcG3kcf8Fe6VV+WrKTfuuRSvg5ikTQW+w5y7Pn5Zjtw7n+zkbFbeSfFmctk1zHqgxgzCRbvx+gC0XFOYHooEtrHC0Wglndnj8XKUPor//Bm378eXEapvYcqb+N4xEbgYDYtrx5A0HX6JJIOr7nWOydoyhVqdVVblhvPMoFqt9aqXxsTOHpF5x5SHkXR7xsPBx3bt6eywURE2kzEKlR3CYorOsLxPWg48k4OLlOOSqqaNX1zLI9A3IYQRuqS4WNByePnhbtYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q//1ePNBmOZeD/9lflWB9df/WkwYo7VmkjHMrutUN4=;
 b=YuuqR8bJJrIVpQXIGg2Kel/bmR1XMrrEuWveOJTuc3RQomR49Xcd8PrwQyqu66uEpJ2GThtlPvDGEwxUehgngn0taA8zI+spcVFHCtvQ4dDvnHPjsmGbCKZ8iazxJQp5MFOYXY+IuA5oulLsYsta7O1B3Ga9EDGsbWSEPKm7PhUDI/Y+tVdjHVHB/Y/ZLeDWVtcu1ocpa1DjYMh5M4Ea/u4uNfJ2g/mv4PuhGSSkK4aWneCGkZM4NFdIR0+26GrvVJxGupRIw6eWOfoxiX238VYdsoYXfQ/3m+YXuD3k6WikJFicLHD4pIQ3p0WNfJj89gpRyvcd3JKfmDetHe5qnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q//1ePNBmOZeD/9lflWB9df/WkwYo7VmkjHMrutUN4=;
 b=I0eTY58NUZh3zDa4W7B6+Ao/fIEq8F2/qZP4sLlia0AxHQiStoDEt5uSkdtFqaWT8AxNyri9+nB6eCPd8Z6wfZSESXMLcws4x1ZSBrm/zNepsAYKDx8gT9Y1WgNT7uZm/iNvfCq7QTW73R0qj7odaW0PEhiBd7e61kC/pVN/ln4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 19:43:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 19:43:02 +0000
Message-ID: <9b5e5144-1ec4-4bff-9140-39528dbae02d@amd.com>
Date: Fri, 14 Jun 2024 14:43:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: fix UBSAN warning in kv_dpm.c
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240614183337.483183-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240614183337.483183-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:805:66::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc7dae4-07a8-438e-a9d0-08dc8caa33bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVpTaWdXS3Z1N1hMcTI1aHpSelM2OXk4SVJ0UHZ2eVpuYVlBT2tadU8zdEdy?=
 =?utf-8?B?ZHhYeGx5bGprakhDaWJrS1JvZ2V1dmNzN2V6MkN1QmtvRHFOWW5lK3VnMDE3?=
 =?utf-8?B?MmhFMTZVYStsNXUybXczWFI4dGx3cFMrVy9PNXBoMGxMdkROVmRVTTBTbjJE?=
 =?utf-8?B?RCtkNWRnazF1Vmk5eGw5RTdTSHpxUmZEUHZDTmlKenVPTHdoRCsrc2lLUzJ0?=
 =?utf-8?B?SVVSU001WEorcVhmcmJncVR4SlVtSmpMT1VwbFZFbXUrU3JteHhFSE15ay8z?=
 =?utf-8?B?dWtKd1Q2ZUhXaHNRYVJYL0VhL2FVM1RqQisrbm8wV1FkZGM5SWV6VkNlMXd5?=
 =?utf-8?B?OGVwRlBrWU1ndWZ4TmpsdEN1Uk9qeWlCZStnY05mVGZUN3VqeEg2WkE0cVoy?=
 =?utf-8?B?WVBRV1hFb0dTcTlheGdjSkxiUU5FaDJweWdxdHphdXc3a1U2eTVabUxrWmEw?=
 =?utf-8?B?eHR5MnZOOThPbFRQTG8za2xWZmUrcmMrSTU5d25lYkJ5NnhMMS9mRjg2T3Fy?=
 =?utf-8?B?NzZVNE4xTG9CWG1oUTk5ejd2YndFYlp2S3U1VmsvdzNQa2xpbm1DZ0xuMGdi?=
 =?utf-8?B?V2VZdkc4aXpRUlRicHVUK2JiNjAxb3FvTzdGUkRMVjR3QTFmT2hxV0YxY1R1?=
 =?utf-8?B?ZFNJc1h6L2NHY0MyMERnSlVybE80N0I3NHRCUGt4VEdkdklZcC8xL0Ntc05H?=
 =?utf-8?B?bVhmZTVwazdsbUZWeXE1ZWNGR2EwcUx0ajZjcmlidVovamt5MTc3cVhOOGd2?=
 =?utf-8?B?ZjU2K1ZrZk14R3dVNHZNQmtaNDdMUzhTOWVLT1B4ekpucFU5R0h6UmxxWnpr?=
 =?utf-8?B?L0Z4Wk1Vbm9RZDJvVjUvWXF1MDArQXlMV3c4MWpTRVZ5NVRaZXRSK0ErZHpX?=
 =?utf-8?B?dTNqUThvWTRvTmRuTDFIQmFGZ1c0Z3Z4U1JZaHhlRlFoSHVSTC9ZSU90Zjdh?=
 =?utf-8?B?VGxIMCtUajlzQVVLTlJkM0lZYVYrN1UxVTBkdGFSelkvV0xKMXlZd2dhaXM0?=
 =?utf-8?B?VHowY0xNcnQ1dnc3Q0s2b0E4THlhUTBRRHBSZk1EM0N6bys1aytqdlhRSk1F?=
 =?utf-8?B?aGRwbFM4NjE1MXRhRFZUSFMxYlR3eGpoQk1vWDFqQ3VyU0VzbllRSDdPcjZ6?=
 =?utf-8?B?WWlwRWRUckkwL3JEYThPZUo0ZFcvcy9qbWk2MmxDZVBQMkx2RTA4YjB5QWhx?=
 =?utf-8?B?ZGdmVzJFckIvdncycVh4M0VmZkNiUC9VbVVweUtHUmQ2Qm1odFp2V0RrakN0?=
 =?utf-8?B?bUNWUWVSd0tETWthWDl6T1VuS2w4Y2Q0NDFHcWh2eENJWG0rNnFVVHhmVnV5?=
 =?utf-8?B?RUJGSU4xY3A3ZmhWVllRV21LNW4zdkN5MzBCcytsVGlIZVFyd0xUbitxb3pC?=
 =?utf-8?B?TkM3MDdwVFVYZk0zTzFDRmxNSDRkRWYyT3dqNGtJci9ObG83TzN1K3VlV3N1?=
 =?utf-8?B?cWJGVCtQSUlWcjBraXl3Rk5WUVZPUGNhamZ3eE04eVh1TVc3am1CUGZyVWps?=
 =?utf-8?B?eXk3MmFKUCt0b0JrN25peDFHbU93TGpaaG9UMHFqNEJDTkFwRlJ5cTJweXlx?=
 =?utf-8?B?TFNGWk9va3NjV2VzaktMaHM0WjR5eml4YUZOaFE5VnR6ZE9pQll6Z1VmU0Jz?=
 =?utf-8?B?b0s2QlZIa3R1WU5RS21QM0Y5NzA1dk45em9Ra2hnZ21odnhBRHg0Y2VnNVNt?=
 =?utf-8?Q?EDkXJgROVNmxuEoHpDP9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk53ZlVuVDBreDhzeStNNVUwZUhNWHI2bG4zeFNZTnd5M3JyMGN0VFNlTi8w?=
 =?utf-8?B?V1lJZWswbzU3eXhzTlFYbHpscjFMcVJZMFAzUmJ1c1JadWpJR2dWQjJzbUdq?=
 =?utf-8?B?ZExBWUVYcU1rdUFkajRFRVVVNmpZY0wxMWo3ejU4Y1NxRFlvM1RlQ3NlR0Vz?=
 =?utf-8?B?eVArY0g0UFJFLzJkU2tKeVdlOHpMRzlPUE1FTEdGQ2RBVzlXRXNIbmtnUTdX?=
 =?utf-8?B?UFRYWmt0RjM3bWxwK29XODE4ZXN6YzVCblVOS3N2cnNaNlpzWmpQVlBvNXp6?=
 =?utf-8?B?ajJrc1BIYTBLV2JiRVhxc0dXVk1JOW1hM0ZUaTNEcElrcjZpbVVIajEvU0lU?=
 =?utf-8?B?Z2NqOFE2Q2poZ2JhK2ZkdFRBakEyaTBBR29teGlYNVZ1NG5rV1hyMXhuSDU5?=
 =?utf-8?B?UVdINUhTeENQelhoUk10Q1R1WUU3VE5zbTlRc2c5Vm56RTdYLzhFb203bGky?=
 =?utf-8?B?emxPeU5rUFBrN241Mkc4R3NaZEpSa3BmMTN3eGNuQ2NmMG5iejkxQVRNc3R1?=
 =?utf-8?B?RjBWWlpUNFg0WGFuaEYyamJ4aWloZWpUUGQzaGlhWHk5MDZYZVpRcjMySStY?=
 =?utf-8?B?SVU3dlgwcVg1ZGI3UHZMVEIwNkVkNytPckNwVk0yUWlIWkxKQzQwcnljZ044?=
 =?utf-8?B?VU12WVorb2xYbzJLOVk5eFhscy9qV1FacW93UTEzeHg5UktKVlZTR3RzMTFT?=
 =?utf-8?B?bGFSS3NUMFZZSkdSS1pRZXczL3kzem1qcENPcnpuZUdjd1RXMndZQ0V2cUZI?=
 =?utf-8?B?VmUwTjd5bS9iODl4T085SU5sTmVuRnF2aDNyUWsxS3lpbktxTVFsY2diZDNj?=
 =?utf-8?B?ckFxYVhVVG9DSVNzY2pNc0RBR2JHZlNJNW9KOUEyQkIrcjdMT0xFcnM1c0o2?=
 =?utf-8?B?bWhIUk14UUhQaUJXK2hJZDhMRGtqVitLVENkNkUxMEJKUnc5M2dENXZqWTl6?=
 =?utf-8?B?YXNtSmZERG5kSDJmdU16dkd5SmZrc3AwWXJRK3JyczdEeTZIeVVEd2ZTUTZp?=
 =?utf-8?B?MGdnT1dHZFQrcUdSSEgwRVpvTkx4MnBoY3pWckV2RmNYcGJvNkZtZk5pT0dK?=
 =?utf-8?B?QnNzQWQwT2JVd0x0cXZzM1lSVWhRY0pEWXRKMEZvS081YXpkb0h4Q1Zxbndi?=
 =?utf-8?B?YjRVb3ErNVk5QU1VUE1XbUFvcDBYa0hkZ2hncllIRTM4UGcxbnhxaFZJbnBR?=
 =?utf-8?B?SnpJVTdGcW5zUCtibXRQb3MzK0lRdmlHVGlhR3g4eUdkQVBNTzAwbXRENDMv?=
 =?utf-8?B?dUxyNG52WmV2azZ2UThpa2FOZmxhWFUzdGZERWlPRlpLYi9nV05sMmhUV2VD?=
 =?utf-8?B?cjdNQmpDUkloRjN3ZlVGUkw0a1h6R2NwTWRDWFZpNVd6Z09yeUE0UE5ERVhs?=
 =?utf-8?B?dFZZVEpUK1RsUWZrblMzV1k5NGQva3hUZG5RUXlZN3ZlcldJcmpyblY3UWJD?=
 =?utf-8?B?QXAzS01LbzdlanNabDVQS2U2N3Fna3FEZ1FLTis2TE9EWnFrMlZBMnJ5eHRj?=
 =?utf-8?B?WHY5VmZISTZKdCtDMzlPbzhRRkJLTng5S1RkYmlCa1hiSE9pbmpuTDBqM1Bn?=
 =?utf-8?B?cTFvcW91dm5jOFBGZEEwR2hpczJ6cHcwbS9VbWNJeUljWmYzZ3BJL1NVMTNG?=
 =?utf-8?B?eTBhT0g1L3FlMlgwajJLWHp5cUtBcWt6ZDgzNFFXU0lUMlBzenNITXM5b1NM?=
 =?utf-8?B?OWFtV0FyYk1lYkhWZVlVTDNvYnhkbWQ2eWxhM3NERVZKUHJkaWlIeW1tMS83?=
 =?utf-8?B?TUtDb01Sd0FrSVNzMEV4L1ltcUlHT2EwRzBYcnBjUGtDMDJjNEJDSWJhbkVq?=
 =?utf-8?B?VUFMM0hsNFovdExCZktoakkyaHZUL1A0VzI4aGZwb1c3MHhFMmN3R3ZzeEJh?=
 =?utf-8?B?VXVqYnVkSno4OWFVUktUWW53Z0JMbCtlWUNxNVJBWUNhT0VpWnduZ0xrNjFk?=
 =?utf-8?B?bUVlbFlNLzBNY0kyZ0VkUkc5blpmWEJtMTBpeTFKTlNTVW5EV3FTeVFSWWpn?=
 =?utf-8?B?VUZPUFpLbldJVFlQKzYvWHlVR3JGZXRnTkRFcnIxY0FhQlBJcGFLV0JFSHB0?=
 =?utf-8?B?dVhkWVYzaUErVE5ramgySzFNWHk5bWpLeWtkVkZWVkswSnRoY1JkSnp6Tjhx?=
 =?utf-8?Q?2wAAKwZ3URlg70QaaQFNXhDGe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc7dae4-07a8-438e-a9d0-08dc8caa33bb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 19:43:02.1379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOP/7jxI37NRrYzevTEwljSr7MzzUuvnH/0HOMM8Kj3LM4fqO8+2aThpG/TCq2pVn1R6rcCXt7oBP8HIFySadw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
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

On 6/14/2024 13:33, Alex Deucher wrote:
> Adds bounds check for sumo_vid_mapping_entry.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3392
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index 6bb42d04b247..e8b6989a40f3 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -164,6 +164,8 @@ static void sumo_construct_vid_mapping_table(struct amdgpu_device *adev,
>   
>   	for (i = 0; i < SUMO_MAX_HARDWARE_POWERLEVELS; i++) {
>   		if (table[i].ulSupportedSCLK != 0) {
> +			if (table[i].usVoltageIndex >= SUMO_MAX_NUMBER_VOLTAGES)
> +				continue;
>   			vid_mapping_table->entries[table[i].usVoltageIndex].vid_7bit =
>   				table[i].usVoltageID;
>   			vid_mapping_table->entries[table[i].usVoltageIndex].vid_2bit =

