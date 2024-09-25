Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B332ECCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591C110E864;
	Wed, 25 Sep 2024 20:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4doDaASn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A36410E864
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Clh9kwND1V2VLcY1EZwM3Hi0RFu7vTnaI1Yujppg7SL3AWHvVecD2160NvofLxl4l/LFnAhHNjT9M9irJWBrZ/UWWn6+JriSXMGHyH/KtB1G5Nq8Qcjuy2ItNuh9iZwIRu3CXvPvFzYyEHjVaU1RKJki+76z4YyhcKsVEVS+S1WIrvBAUIc5TOzWJ6Ne2zu7Gj+1WWKfius2s/3GcdaTaSdg8VU1HxBl5yZvbOSL56bUdRBQVTovVTc4jRe9DTdc2IXhQU7AMQCyes03ABzZbYRmHTC9tHRH0OrbwkmJCPymkObgxhKQCeQI+hjThvdlG+1wECcQVDSBKkj3eEMMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQL7HO5Efmwf7ezf0JvphThCh9BHBHwMop/yPtTFNIY=;
 b=iVw8o44kHrbArqmFH1h3v54cr0om0wm/e5LiWxGf/eZa6ACFbVHcFIJgm5GU3trUe1fLo5H/OKB+ff2TiGNYLXRyed6mtf4eo+ao/1ZqiOrDf1jLg7IYHhPL+cLQmb5tk+JXOps6/wz+MLOpfMezyk+RYikS2eyFaGiERQ8LdrxIQJ/E6WpMN0M+T9MoHqSlL/SHxEVfWxEX/VMKVVWbHshQE46WbZdZlDWuNqyYa5d6iUF/XGgXDdwzAVcq4B/8coLGR+0WQsfNMq+JbvMYgnT/NKXWfWZjMEc6G28nk3Z5Qbeab38IYOqjLBUcWNY/Mt9cfrAN4OXn+GtJd4lyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQL7HO5Efmwf7ezf0JvphThCh9BHBHwMop/yPtTFNIY=;
 b=4doDaASn6fM+4mWyMwqpXKyfL+BE1LOfPsFOQkcWoJaN5ndnoj9VlrVmCUUcaTuzmXsL2H4Wm7IzHeTu2pOmAOumv2tFH0SpCuhZwks/WTwFHuOpA/l1qzIAYIUCWUK56jOUzJuEMNEmWEF8z/6UFAVf70O5DllfkKAR4ewZ5KY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 20:12:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 20:12:26 +0000
Message-ID: <6561bb8d-d68d-4ead-ac86-cefff6f0fd37@amd.com>
Date: Wed, 25 Sep 2024 15:12:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Taint the kernel when enabling overdrive
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240925200507.75767-1-mario.limonciello@amd.com>
 <CADnq5_N9PiSMWEKLtyi_+dQvQQhH87MQC2XRgYP5OMsUMRaGTw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_N9PiSMWEKLtyi_+dQvQQhH87MQC2XRgYP5OMsUMRaGTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:806:121::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4811d0-3c9a-4dd6-00fc-08dcdd9e5ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzJoSVhncUI5WmV6USt6dk5qOTE0cWVtYTdUUzA5S0IxSVBmaTBWc3hQN2VR?=
 =?utf-8?B?L2JJRll1eTRxcklrUWd2dVlXWGZlSkE2Nnczd1NKTkgrTWRpY0E1d2ZzUnJQ?=
 =?utf-8?B?VGV4a2dFL2V3WTRmdXBuR1ZtZ3BRWVZVaTdKeFpyMHNyZVVWcFVBTFExMEo1?=
 =?utf-8?B?aEk3bWwxNFl2MkVNVjNkOU45UEVPNklOZzlvTFZnWEtXS3VHMHUyaWVJRGJC?=
 =?utf-8?B?YmdnUjVTc2F6a00wL1VzVmxra1hFU1hnbnBQSjlyK1BKWU1STnhGU0kzcVdQ?=
 =?utf-8?B?RDZPdWlLQnkwdjBUUjJ0YVpSYkp0QS9sNTJxeEJJM2gvNlN3d0ZrVWJIUGwy?=
 =?utf-8?B?bDg1SzU3eml5dzByMzIvRk1tcUd1THg2OFRCeUFHM2lmdjhLYm1zMWQ2bE1h?=
 =?utf-8?B?Q3pna05OT1ROanQ5U2J6SzM5T3NTdHV6emFGS0FCSS9hTXBDY1FURWNjUFgw?=
 =?utf-8?B?T2drMXpYcFYzME9QQVFKN3FrQ0JrUGE1TE9vdTFNWm80SmlSSWFkWVB1RlRG?=
 =?utf-8?B?ekt1L1ZtY3krNy9pcnFGQ2Iyckc5R3E1ejNaNWF1aWtabU84RU84VlpIOExD?=
 =?utf-8?B?L2wxRlZNWEpObWltU3FicDFveFczN1N4Tkl2U3lnS1NpdlJTakdhbW85Uzhi?=
 =?utf-8?B?SHFxWEZLQkMvMk1YWEFmM3o5MWtOcUpwRlQ1TGlUSXRIQTR6OGVRY2ZXOVVp?=
 =?utf-8?B?Z3JGbU9rOUQ4a0M2WUd5QTQwcWExaXV5MlQ1a0lXQTNLZ1RLSXgxbGJiYkty?=
 =?utf-8?B?bDJsOHpuS012djJrQytwMEpPZmpxYTI3MFFHWldBam0zTXlwd01NYThSYkdW?=
 =?utf-8?B?ZWtvOWo1bkIrVXJuOE1ROW05QzN1MUdiYUhqS1B3WU96V0lrbmh6T05Ia2py?=
 =?utf-8?B?WUlndU05UVBzQmVXUEVKQ1M5TnIvSklRdTJ2U3FDQzJjWGpsNGRhVzFoaG9j?=
 =?utf-8?B?K2lhdXFXd0ZTR1hLK3BwMDloNERGZ3Z5Q3ptQkUzSXVHTzNiV2dURzBacm11?=
 =?utf-8?B?a3hTWHJTemVZVzRVN2tzNTVoRVk2OU95L2FXUDcvakJDVVU5ZmpzYjBKby9v?=
 =?utf-8?B?TFF4aHBDYVp5Z3ZhdHA4S2laWmtBRHM4Tkp0T1BmRnlxYmVaZFRVckhFSG1j?=
 =?utf-8?B?QWljN20wN2tCMHk4UzlmOXJUdGNRWC9xSkxsT0ExdDBTbFpqZHZuUXQydnBD?=
 =?utf-8?B?OHNIZC92UVRDZ1JWRXByemxzWDU1RHF5bGRZT0hDSm9qZm50U3J0ZGNRNjBH?=
 =?utf-8?B?dk1OTzVkdW1EWldjUy91NGJ4MkQzNldMNDlCck1neHFTVGc0bW5JZlhXQVR3?=
 =?utf-8?B?bVd2MDN3STFTcXV4Qk16b0hIcEV6Q1RpUGc0R0QrMnRVSDcyKzF4QW9XNzJL?=
 =?utf-8?B?aHdDMkxleEhWTSt4S2t0K2tveFh5SCt4NCttdGZTL21jT1BoV0RqMUdGMXI3?=
 =?utf-8?B?RjRoNXRSWGd2WlhmcXJOMXhnTkZFdkhXMWVNeHJWY0lhU1FyWmZWWk4xZlZm?=
 =?utf-8?B?cWIwZitnU0tGRStpblEzVHhKMkkyZGRySi9hNGNodGk1K2x4bTlDSUVoNzdN?=
 =?utf-8?B?ekxHUS9xejJKZThQTXE2ejNlUjFYMU96M2RiLzRoZGpnOUc4ODBweG1OQjAy?=
 =?utf-8?B?SUt6SEFCazNyM0RLK3ZrMS9odUFQWHBqZEtON250YXZZSitKbFc3K0IxRnBC?=
 =?utf-8?B?VlVFRVNLOTI1bFVsbEhoRUN6bEVDYVl6UlNpS0UxZDVGcTFNRFVNTlh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUtsMTJMeVE5eDVPNlhhVFdINzc3SGFVZlp3a2dhenF3Vk05T3B6SXpHOGlB?=
 =?utf-8?B?blZNN012elBJQURzYXJYNUNjRGt0RnVsYW9nS0wrNWR6anZLSHBQWFU1WnB4?=
 =?utf-8?B?d21GU2NiL0RWQnBtQTVKRzQ1MjBKZDFDMWJLNFBiZndHTUdIakpTeXJlc0Rx?=
 =?utf-8?B?Rjk0RmZodHBFOUNqeCtqMGxqaVFVZGJuZFRRYTFzdXNiRVJicG84bmoraGpw?=
 =?utf-8?B?aGdpSnRXWkRxT1R2eGQ1UEhxbjRLdTVWa29ONVF1d2F4NXEzYUN4cVlxTURi?=
 =?utf-8?B?U3VSUkQyQVhrMUNELzZkZm1tcUIzTk9EK1pIWnlkeStSVlF0a2htSEUwL0Ny?=
 =?utf-8?B?MFgvNjZFNW82emFZTFVkaFVQMG9SU1kvUmRndDZUL096SnRlbmUvOWQxUmJF?=
 =?utf-8?B?WjZjeG1RdXE3T0tSQ1Z0bFRaSDloSDM0LzU1RG5Ga2JybWFwWlJTR1JnUDQ4?=
 =?utf-8?B?WTJ3Z3ZqY0ZqMHNvV2NsZVFManh6UHhxOGkrS1c4ZG1UdHFNV3FqWUk4Y3RG?=
 =?utf-8?B?c2F6cld0cmZDdE1UZEJHcWFmS0Z4UUdDZGVrbXF4eXZkN2lncnRYV0EybzJa?=
 =?utf-8?B?RXRINTZPTWI5UXZKbDd6eis2NXNrQWJxMzJ5MGxuYlFLREYwTkpSdmxlWFow?=
 =?utf-8?B?cmJlbDBtNVZRZEl2aldzeE1BdEVOUGxaaHppSDlha015UHMrRlFkeUJqeW1l?=
 =?utf-8?B?eTROL3NYV1J6MVI2ZlNGZXBjNjBqYkEyYnZsZVVrWFRYY3MvbTdGcnViRWp1?=
 =?utf-8?B?aklMV0s3YUpKYnlPSkRGelhPWU91UE9vRnk3YXZMS3VGTjJMSklNV2cza1k0?=
 =?utf-8?B?ZHpnRFk2cHpJOTA5VGNxcTJXT1l1d3g5bXpvOFFqWmtEcTdXOEFFYjlOYm4x?=
 =?utf-8?B?UnpmTXlwM1plYzU0L2Q4VE9IdlpYWFlIU2gxaHV5M1F0MmJTcStNYWRBSExQ?=
 =?utf-8?B?KzNxQWU3OGJ1OHNVQzZ4UTNQcXRwWVFxL3B5T1hlV25rZzJlbVJJTUdrYkVH?=
 =?utf-8?B?QmhuR0phU3RXdEtER2V2NmpyRVpDbFYxVGtUK0RIUDNnRUVDdUcwZnRYR2NU?=
 =?utf-8?B?bTlmRnljQ3FsQzE4eWdaVlFPRnYxOE5relQwNmNBMkRuUlBIV0x3OEZHZmhZ?=
 =?utf-8?B?d1VrSWx4MzVobEZxWGJKTnNxbk9Wc3E2RHhQcVlhLzNhTGZvYURBOTZpSkhV?=
 =?utf-8?B?NnYrK0xnL1FZNU02Nzg2Y1VhOWxnaHNvVkI2dGFucXExZ0lWMWk3L0wvMXRY?=
 =?utf-8?B?ZFljemYyeFkvSmN3dDJIL05raWZjMjRGdllFWktVR2NhUTRjaENnTk5ROE9l?=
 =?utf-8?B?VkxyYWt0UFpTam9BWHFtNmJ4MFZSeVBJUWwrNmpHMGtZUlhCeHhQU2FySlhF?=
 =?utf-8?B?akdEb2puMGNlV1IzM1BKQ2wvZHhtbkxlbDZlS1pWV3VybUNJUXNqcVBocTh1?=
 =?utf-8?B?N3BlQ3JDajBhSkNJcUJCTFJFVnlGNGJNY0tDMjNWRW9BNklqaHNmTm53dXg3?=
 =?utf-8?B?Tm1sd2JTbTE0RnZUQkVra0Rkc0ZKUDBsNjA4UFB3c2hSeXkyVHdkSG9EQk5H?=
 =?utf-8?B?d3p3ZDIxNkp0NlZadmtqQTZzNHBuNFpqaGRwMjJucC8ySUtIQmxWdkRNZ29X?=
 =?utf-8?B?RlVTNlBDN1ROa1p3LzhPeVFTTWFGMzVXRGtEa3YweThHL2h4eElmbndsaVlX?=
 =?utf-8?B?NzJNZm1lcnBTZXUyRmpnL3U1bFFZTjhzNlczeEh2U3VyZ3RrRlV3UHkxUGdC?=
 =?utf-8?B?MTJScG45ZVJBREljNDdJYmVLMkZCRC9ZVDJYd0VDUTVRVFQ3L1I5QW1veFFm?=
 =?utf-8?B?MmdVWWkzK1NOblI0RGtpM2JtbFpDMFRoOUFaQjFuN3lVOXJPNzA5SmVjY3k5?=
 =?utf-8?B?cUh3YzlqbTVVc1RJTzhGdUVyM2tkQ0t2R1QzTm54czhrRVAvczdVclVWeWo2?=
 =?utf-8?B?aG13UzArY0ZHVDhtZEx0Y3Y3RFJGeVp3NEVNcjc4Rzh2K1RKY0xXQTF5N3FK?=
 =?utf-8?B?dXBnWXY2bkhESlhOWXZ3WHk0d3lVM05EVHkzdXh6SUlWa0U4ZE5vdVlEd0hm?=
 =?utf-8?B?RUJxeHd6d2NYbkVEenY5MjFuSmVkM2N3bVI5V3FBQ1VET25XU0o5RGZVdlQ1?=
 =?utf-8?Q?AYnGsiU5rptcB5OJkXaLEDlR2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4811d0-3c9a-4dd6-00fc-08dcdd9e5ff4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:12:26.5213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heC1NnZItwQ3cDxsU8mS4NpMJPMqE9m9oxua+IfLNJjW4bVGda7eHp7zOJftvnELr2TP+8nhLdoVyetmioMbyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
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

On 9/25/2024 15:09, Alex Deucher wrote:
> On Wed, Sep 25, 2024 at 4:05 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Some distributions have been patching amdgpu to enable overdrive by
>> default which may compromise stability.  Furthermore when bug reports
>> are brought upstream it's not obvious that the system has been tampered
>> with.
>>
>> When overdrive is enabled taint the kernel and leave a critical message
>> in the logs for users so that it's obvious in a bug report it's been
>> tampered with.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index f57411ed2dc2..99717a1d7f61 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -3067,6 +3067,11 @@ static int __init amdgpu_init(void)
>>          /* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not set. */
>>          amdgpu_amdkfd_init();
>>
>> +       if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
>> +               add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
>> +               pr_crit("Overdrive is enabled, please disable it before reporting any bugs.\n");
> 
> Might want to reword this to something like:
> "Overdrive is enabled, please disable it before reporting any bugs
> unrelated to overdrive.\n"
> 
Thanks, good suggestion; I'll reword.  Are you in agreement with the 
selected taint code and location in the driver?

> Alex
> 
>> +       }
>> +
>>          /* let modprobe override vga console setting */
>>          return pci_register_driver(&amdgpu_kms_pci_driver);
>>
>> --
>> 2.43.0
>>

