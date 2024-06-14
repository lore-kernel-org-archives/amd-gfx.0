Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48DFC27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 19:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D4C10E1F3;
	Fri, 14 Jun 2024 19:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HeZfjeMO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E5910E1F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 19:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHFAk9P+Q/kvUb7KefQcgU8kkqUw2XIkbIpnHBB4m8Z+HABBry+OMZM5Ruj04oJQXhWT5Rt/47gTQGezuMf1w2fRDz1DHGC44IfcS6ViPxy4HJTOWnXRZCSJfGrLWGtq2t4MpTuAFhpUZL4gwtBkLhyWpBXrvmDNTdk5aeQObUnbvKgvqrmAw9cZjiNeqt1BEZx3uYTVsYrzCKIMHB5MHskD0K+jiuw32eeOlEppV/Tul7Ito5+gMOzgcMbylIvMkt/c+9eAGgT9vxpIOfyssehm7AcPc83Ux5j/v7TtbfKCh6SbWgbPEgJ9i3gbetaNPGf8+iO1eb893KjVYZnX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahWbGX2dJdZGgo+l9GLU35wHnmO/1ennwld+IfwF8Hc=;
 b=OQbWowosHTZufCZz0Cirfyeq/sh7Ey9hVDF6wtKTiDNI1yhFp/Z4j1TeZrpz5Lpk7m/SjWpvb9L/h92vxSuTuOeCkFhyJYTV14zwl0kEEEvcuCCgmXUVLCHxqDjcP+5GVu0Nrlxb9nIWMwNCW0D1eTl21BxviebDZelrm3y9Minume/kWCNe4S81PulI7yH/dc1f0iv5uJkxR+lyqUqwkYifABRDgMfVx/n80R+71v2/Wz/VCpNVnVZMybnnVKkZlruCJwLal5AGT7ZsuNhE0gZwF9B1w4W4mZuevshMnoOTkGMdcj9GASpvFwo1BXRGUngbLJ+SMkAptl9yLovOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahWbGX2dJdZGgo+l9GLU35wHnmO/1ennwld+IfwF8Hc=;
 b=HeZfjeMOn78WeEbP/st7Dx5uGxfyrgCET6kTYjETzU+5ghWexYjM79YKBHTF2RkHDtVQVdSYe7ZhNTS6xwQlrHMxK03G7zuGgyGGNMgTbKsQIYts+KxeY8vPeptdUwXqCuAny+TkQAHtZ4WwRg6Syfww+nhLA3yaFXuCry9P0io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 19:42:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 19:42:28 +0000
Message-ID: <ace32c37-d826-4d15-813c-f3e853cb4a47@amd.com>
Date: Fri, 14 Jun 2024 14:42:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/radeon: fix UBSAN warning in kv_dpm.c
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240614183337.483183-1-alexander.deucher@amd.com>
 <20240614183337.483183-2-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240614183337.483183-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b6ea4f-5f66-439e-6aaa-08dc8caa1f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHk2SmwvL0o1MVVCN2owYSttek1nV3Q0NXRtL2JVL20raW9RNjliQmZidzFw?=
 =?utf-8?B?S3Q1UVY5dkwrcFBkNnpwRDJlSFBFOHFIdCtIRW9hYkY4T00ycnZ1TkxQdUxH?=
 =?utf-8?B?RzVDY0xQKzRvT200OVhLb056ZTRBU3F1ekVSYndrb2RybkhydHNLVFZPNmZL?=
 =?utf-8?B?bGdaVWVjaWgrMkgwbUhneHZyUU9mV3JydVdUK2s5L1N1aU43S05jTUxDVHh6?=
 =?utf-8?B?WkthZ0Z2Q2pvS044dkxmYlVLcWZKRG5hTitvVnZLNGN5ZE10eEpTSmhSbkJz?=
 =?utf-8?B?czFhV3VTR2tOQ2VJYmNCc1YveU92VkpjVnl0Y0tHOFdVYzBOSmtLU3JpejNF?=
 =?utf-8?B?aDZsSXFZejh1TWN2bFFQdWc2Nk9ra0JzeSt0elp1bjBiMnlDemkzUmJNUW9Q?=
 =?utf-8?B?Q2tWYTR2dTFPbHVSaU5jcHFxR3I5TGJsNHF4OSszMEZ5UzFPT2NpZzl0bkd0?=
 =?utf-8?B?dkR6SGpjZVNlaElrYlRpUU50V0Z6RDdyZkpneFRMMmVGcVNTZVdOakN5NFJM?=
 =?utf-8?B?RXhUNTM5VjFTeDFwSmpESkUzT0xuMlVNRTJQNHFNa2p2emlMZGQxQkhMOVhk?=
 =?utf-8?B?NFVMQ1J3Um5mR3JTeWptenFmQUlrY3ZQb0FPUGI1WVU2OVUyQmJ2VlFBbExi?=
 =?utf-8?B?eGk4bk4zM0p0ckVhOHBRL2xsRDliZDBNOWxIK1drMnAzR0FYVkdxbmhaTFI5?=
 =?utf-8?B?VVlWcjc5Y1d5OXpPUGNzM0Q2VlA1U3BPelNtOTA5WjdJdDNOUzN3OWhuMUtP?=
 =?utf-8?B?dUpuSWNhOE5KZjJHejNsd2xUeVhnSWxRMU1NZ2JBK0d6bm1rSWxHU3FJRzFY?=
 =?utf-8?B?Mk9WenVmTnVNclYvVUlVeXVmTWRqZ25id0Q1anA3RU12MzFhcVVJR1hzSHAv?=
 =?utf-8?B?TzRKb1h6M2NaWDBwdFdvd1VyMUFUeVViSEpnV1laNlpmeXdtZ2taTXV0d1BB?=
 =?utf-8?B?NEdqK0ZrOEMyK0RRU0daVXg3SXRWRTRoOTJ5NU5yNEVYV2xnNGNoU0NKVXhQ?=
 =?utf-8?B?N3FneFpTNEdhYjZKdTExVUdZQjgrYWRWMUdaZTc4SUVKUGJ0NlQxWkpuemQ1?=
 =?utf-8?B?MWRhYmx4Q2szOHdvL29lSGVBMTBVeXhBazdCdC8xcVROMnUwUUZYeFphalky?=
 =?utf-8?B?TGk4UjlqTHpsNEROQ2pmT0pkdHllSnFnd21jSmZXclJHSjd4Sk5HVE1MdUNS?=
 =?utf-8?B?YzJnNFNZSzZKcDgrZisxZlorQks2NmJmUFJCaml6VjJ3Q3VhWG1YeEVBekhw?=
 =?utf-8?B?c21DZ2dlQzMrYmlEajh2dnBTSUlRWkd5THN2T2t1Q21wVEQ5Q1FrY1dXL0dp?=
 =?utf-8?B?M1gwMTlmR2lIMWM2ZHBiQW9xa0F6MnNaSEN6M28rRU42WEhKWEJTanlnSVY1?=
 =?utf-8?B?cXJtRTVIRzVYR21oRU5VSy9mU0lEeTdpc0pRaTNLVXRkY0Ribk4zTGpZZkZ5?=
 =?utf-8?B?dWFxREZ5Vzc1L1BxN0tqSGNGTDZOUjFDN3BlWjdkY0lnMHBiWXNHVHF1aFZH?=
 =?utf-8?B?NTVGanozVXlnZWxKMmZZVzRNZnRvd21xT0g0WUcxV25XeThaeVRlOUpjb3lR?=
 =?utf-8?B?cEh1eFp2eG1XTTIwVGliTHpqMzdkRWdnQjJMOWdINTJVK211c0R2eVRHLzFr?=
 =?utf-8?B?LzNNcDJ6bmNmSXFqckxWOUVMWGZ1c3E0TWZWVDBUUjJ6azBwOHNkaU1mRG5Y?=
 =?utf-8?B?d0tKMWRWeHFMVU5nZHZ3OURtM2M2QVppTWJ4ay9sVVkrTzlFYkdSaWIwL1gr?=
 =?utf-8?Q?o2MEins3Yxt4NgOBJQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZaN3JOZmZta3lyc1VCRytzZDJMRFo2UlFrR0laWWFnOWJka0MrR0kva0hL?=
 =?utf-8?B?b2V4cmI5NjVURWkrL2Z4YlR5azFWY1d4L1VaeWNsZEpQaExLYTgvdzFRbDRn?=
 =?utf-8?B?Qzk4aGZHN21nSE5BNzJCN0FBQUJOdjQ3TEFZUEszSGI5VEVxbHhTUXRjd296?=
 =?utf-8?B?WjZDdExHT3E0L1JNeWlYS1gvUWs3aWhicnFUTDR1aEM0WENFRWxiMmxrVjdu?=
 =?utf-8?B?Zm5ZVWpSOFhHTUhOeEF5dVRjTkZET01IbGRHVGpERTAvbnYvUzhpbWNOZWRX?=
 =?utf-8?B?Ri9nRjdnU3BWbTlMbjgvVVgzbXh1MEtlMVVMUHJCWmJMN25zUU02TmNoVCtj?=
 =?utf-8?B?MXA5UW1UTmRNZ3JqWlJhenNsTCtTN1JLaEpBbDJHVUlDR1E2U1lOdThuR3FL?=
 =?utf-8?B?MUdJZ2FrdDlyYlFES3F4V3EyZnpsamlxWG4rTVo3RDRqT2c5eU1waTVEekMw?=
 =?utf-8?B?WmRYWGV5WVBmVkU4R2ViUU9pNFVoYU9QRW5xckc3Uzl6WWMvVVJyN256Z01k?=
 =?utf-8?B?RWkzSTBuU2U0clY4WU01UksvOTZBakk0T1hYM2g4WkZkRmxmRFE2NWlwOEgw?=
 =?utf-8?B?NjM5NGpCOStCditPUUlRb3ppRXdNT1ZzWkFhSjdPbDJmMDFGandmZ01semVj?=
 =?utf-8?B?WTdBMjZ2c0ZVV09QTThVVHJTdEVwYU84R3BNemJ2MmVQUDVzbHJoNWJoWVhp?=
 =?utf-8?B?YnMxREg3RFRuc2s4NEVRODBvTXRCcDRMbWNvVXFlQXZCMFdpV3hpNStvVm4v?=
 =?utf-8?B?Wm42NCtnUFpiQTFJWnlhOERXU0RYL3NCWlVJRkJtdThPWXNhNWZoTFYwSXBv?=
 =?utf-8?B?R0tORmNUU1JnMlZ6MGxiNWxZRE0vRFQ0N2J1NDQzL3o5UmRUL2FobndiVVMx?=
 =?utf-8?B?SzFGNThveHJnZVBuemxLcmdZVFVSNFg1aUw4OWZnTjBoT1NCdmZ4U1dIL0p6?=
 =?utf-8?B?RlAzbnQ1Q2poT3N2djRlcHYxZnZJczh1K3BKL21oUDl6RkMrQmw0cWVRc2ZQ?=
 =?utf-8?B?SU9hNzI1RjNsajJodnh3OWlkdEdwa1NWYmNKK1F4UWFDUWM2K1kza1Z4L2t4?=
 =?utf-8?B?U0RrdlYzeDAvaWlxWERjM05vaGlpKzBLZWg1UmI5b3ZIWmNsSktNekUzL1Vu?=
 =?utf-8?B?ZTRxaW1nbENweCtReDBLQTFUN1pIenp0VnlUVG9YVmNCa0h2QTBjNERwRGoz?=
 =?utf-8?B?QWJvbXI1eDI0ajZWNmt6S2NjVjYxTXA5Y3pLUEY2OUl4MTZtbFJwTmZzR1dj?=
 =?utf-8?B?c05TYmQvV1V4aUtoSDQzMEVHVTJQYlk0S0V0R1gvUVVQbi91VTN6YWlCQ3V4?=
 =?utf-8?B?Z0VPdkc2empLeFFaa3ljUzU0c2hHUEtmbmpYVjZMZXh0bkpnOTVxVy9sZnpG?=
 =?utf-8?B?L3lScSs3MEhxZHRaSTRBNFN3VXBaYUNyM0FGVG1oQjRHQjc0WTdnSFRHbWV5?=
 =?utf-8?B?cWJYek11ZTByU3FsTjB3ZUhvcHlMK29DbjRMWi9PSVlsdkdSUmtFQU1CTnRs?=
 =?utf-8?B?NTAwNEZpdTg5Ym9nS2Y2WFZlUVRrSUdUUW5WQWk2V2dza3VwaFNreDRjYW0x?=
 =?utf-8?B?dElINlo1OHRXZGhkRzk0Um82enFJT3pCWEV0dGJrMTRFY1QrVEJnMkx4TVB2?=
 =?utf-8?B?cFRjcG5yUThPY0ZJSFVzMXRNUjc4dUxCUkprNG5aYk1yTVhlWEZrN3BjU0F4?=
 =?utf-8?B?T09SMWpaTGZCS3FSY0pnSGNpaXZmWWJ0VTE5THo0cTVGMlo1SWNFM2pvY0Nm?=
 =?utf-8?B?WXRDS3JiWEp6L2dBdStGMHRmWmJtMFUxbWNXN081YlNjdjB6SlRjWFcrMVNE?=
 =?utf-8?B?eU5kT01PaFE1U0NNTmRCYlhnOFIwcEU5VzhHK2FLVFR5TkozQjVBL2ZLcXMx?=
 =?utf-8?B?UWJTQTBHOHYvQkg0NlZuMDZZc3lYSUZ1TlhPZkU2bzRUcnk5cnlvdkNNRzFk?=
 =?utf-8?B?b3FXaVRPdWlSaDNuSFlJV2NhYWhXY1U1MUZvNFpYbUVBbDkwMyswZCs2Z1R4?=
 =?utf-8?B?MTFFMHJjZ3k5OGZMWldDei9INGtWZDVEdlZ1NE9BVmdrVDZYT05wa1ozVmFC?=
 =?utf-8?B?ZmNNVE9mbi9iQWVDTm1yaXRuRml2cHdGMitIV2VKZUhWRVIwZDliUDRNQlFC?=
 =?utf-8?Q?3p6eE4gOzPFmJNcE9vqIA17ZM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b6ea4f-5f66-439e-6aaa-08dc8caa1f51
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 19:42:27.9067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZYzvBCovMbfJE+gJx+9dKEz4UTefpIsQIKsVpV1Y8a3T8EVJn0rGEv2Y3dgrFUanL9kxQbUrBGIpHszayVohQ==
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
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/radeon/sumo_dpm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/radeon/sumo_dpm.c b/drivers/gpu/drm/radeon/sumo_dpm.c
> index 21d27e6235f3..b11f7c5bbcbe 100644
> --- a/drivers/gpu/drm/radeon/sumo_dpm.c
> +++ b/drivers/gpu/drm/radeon/sumo_dpm.c
> @@ -1619,6 +1619,8 @@ void sumo_construct_vid_mapping_table(struct radeon_device *rdev,
>   
>   	for (i = 0; i < SUMO_MAX_HARDWARE_POWERLEVELS; i++) {
>   		if (table[i].ulSupportedSCLK != 0) {
> +			if (table[i].usVoltageIndex >= SUMO_MAX_NUMBER_VOLTAGES)
> +				continue;
>   			vid_mapping_table->entries[table[i].usVoltageIndex].vid_7bit =
>   				table[i].usVoltageID;
>   			vid_mapping_table->entries[table[i].usVoltageIndex].vid_2bit =

