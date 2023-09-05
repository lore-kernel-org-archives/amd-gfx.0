Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1019CCA0FF7
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 18:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702D910E447;
	Tue,  5 Sep 2023 18:50:24 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7753210E445
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 18:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp41UMNOeMZ7YGaLAOg4VAB6cTKaihf/unffFTqiS7cTwcGNBlDkSBh/JX0evMQLy2zGYHxmFAca40J06k6zGrY0UyN7oQPq4F0ANZJX3s8RQpF9qTYueXP7YunzUtZetwwFpJADZny9Ja06CHIHgV/aGt4S1fQoDS1BKxI7Mek5M9Dkr/yBo/gEXO0pgvSpFyIAQYN31AJDi/zayC3PrzyxrDAeDgUvd6AvGnbWGd9jjJDHPmp37FTxQ9UNVlWBA2cIaPKP1vhNSQtvF22QTpVxTPSBkanm1pX2jlFEZotC7UCNEFJwb02PFI3p9bYWD2tmKJObz3xWb58jlXQjCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeXJRKzgPWONJBAIcsb9kV+ClJRdOEWcZgG4VslDdmY=;
 b=TTTA/6RB8O5D6gxImDhbrkmpduDW1jTALgSy6C+2x6TZEPh2CPAYp52wcHzfHygFqZFhqDbLVDjBO0XM8uQTXtn4B6uwn9r8zTPKlxoaFvZ6Dfr6Yt6EF/OUglY1jskKVJnF5bfRD4VVIlD2q0n9pgt6nl7Cq6ZSWoD1LKCYOhC3iAHlaAfrw8x2NE2VpOPDaF1Lyv6PqmqokGVp43W3r/Gz/0tSjWpbApfNDjx5agVizoRYM5EL2OiWWoTV/3bYVFDPj31pTTsMQL6cxLzUWtRdNoX3wLyB9Vpm8RM4OeuyrzqBDLYxneTHw0RU60I13HjHT6WezutkiqdRQ3P8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeXJRKzgPWONJBAIcsb9kV+ClJRdOEWcZgG4VslDdmY=;
 b=xeEiBfSOrtRKv9woIKIbur3GJlaiKjbrXAqIwFBMth2BZsr3pK4szVoWa8/sIIeV/uWhz5uJuW8TX9W0gdFzNPlwQZSuM+CSM6JJVxUuzUI0E1ZqM88Oe0m9gyUGq7xL69pTQaTwbXr84NEqiU9cqVzAmV7QPIYcMh8/hwk4hfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:50:18 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:50:18 +0000
Message-ID: <ad544f20-9df6-e5f4-2cd2-05f0cf511bfa@amd.com>
Date: Tue, 5 Sep 2023 12:50:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 00/18] drm/amd/display: Enable writeback for amdgpu
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
 <8f46d033-32f5-49b3-bf4d-6e62460e6370@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <8f46d033-32f5-49b3-bf4d-6e62460e6370@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:303:b6::32) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: df02b488-ca25-41f7-3add-08dbae40f350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFYMOQ4M0HCLjurVPhjNGd7rr9KirlScKN5Ha/d68cVL323+hH9Cc3U6G6D7PyRlQ9r2EON92xJQqnNBsSc1DL1KK6HmXerrI2z0f7SICg4wKDomYpRTO354Cxsb6Sdd8K8tBUsm6f63dmWajXXNk6/EXjiMKCDPa5AkGjGgIZYrUknEcQTXh/6Dw8vKO2RMJstpalGaRVgzEx+cdEPp3mMtmww/sKBCBuPJnD+xOUNrgeugNZ7biZoekgAZl5e0g0rYECmcti0taOAUY6YVH1o6JRoUQNKBx0C4Wa1TnTKNDPIbfYWN0iFHQE04+2QmvfU1aeHZZyfGADchvPcMhKZn7hL4VF8ffyc55YrGSmoiWjw4EISq4hThWkrFtUXQeYZFDwjCyvxOLmIeUJVcx2b3sNo1H168PY7AyzVhrayqN1SnpuLMEE6yQxvDGiTh0a/L6e8mxhBdsCDNxriGGvcLV7kjqqNzsTAVsFFEaEEySCNlx2YCcFpdizX+hswjdBbiFXV2ldXedF3iFLFVAVYOv82AvUloGeRjRIdSRQA4JNdaJ0lJslTiPNgy0mUk+RdKeW+MmPGR1b7l/Vd6N0c/VG2tOJVBIemyXbWQI+i2f2W6km54Xv2qUZwb36OT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(38100700002)(83380400001)(86362001)(478600001)(31696002)(966005)(26005)(316002)(6666004)(36756003)(6506007)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(6486002)(53546011)(31686004)(44832011)(41300700001)(6512007)(5660300002)(2616005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dsamNKVzJzakx0TmFJLzQ3VEVyQTB3RHljaUlNWUhpeHdDL2RhaUF6R21q?=
 =?utf-8?B?cW9xbFUwTWNSSFp6elBxcDZ6T3NrVkRNaDZMMytMSVBRaWVBWXVsbWJGdUhz?=
 =?utf-8?B?c04yWFUzV214NUU4b1h5SlF0eGdrRjU2QnJzbWRqTmxocFVoMS9LalMzdVFa?=
 =?utf-8?B?ODViU251ODJmb2NLaWtvcG1xQlROWWVNMVlCaU84TDgxU3V2cWFPcjE2bEpC?=
 =?utf-8?B?Q0dxb1pCK0RKRWRoWDgzY0NRZVp5SGRQbENzV0JTK0xmNUxTSG1EbGFkallC?=
 =?utf-8?B?MlpFdklCTUlvT09sQkpYNXZ4N0VXTGR0V1c5MWRRR2RnbWJ5ZnVkM0M4b29p?=
 =?utf-8?B?NGtJb3ZxVVc2Q2NqR2NNWExvWTRDUkxMb3g1T3Y2eXR6WUZHR09lZXRXQVdP?=
 =?utf-8?B?d1BFdDB3STZmQlhScXRPUTVSbFhISlIyY0F5eEh4SkZvQ2t1SXQ0dUFvbUQr?=
 =?utf-8?B?SUxJVWZPeXdDTlFnVGpUbWh6VS91U0t4WWdSUDBINDNJVnhWc1ExRHhjTWRI?=
 =?utf-8?B?TWl3ZzVsWHVWb1hRekxFbzdSKzVza3d3Q1NuWEU5bU53bFBTcXpEd3ZHQkFC?=
 =?utf-8?B?eVVBVGNjd0hGdEszSUdOTlhYQTd3TWFiMTJIejJSV2cyZW5MRExaSWRJVDBQ?=
 =?utf-8?B?SzYxTWdsYU9xSVFkaWkxTzVzU1FROXI1L3BiK3VETVBSOUw3ZUs0TW53ZmZi?=
 =?utf-8?B?TlllVElZYXgzUVF4aDVaUElOWEVQVEFqZzU5c2pjZ1ZSWXY5REkrTUcwR0E3?=
 =?utf-8?B?bCtON2E3QXVGVUt4SG12Kzc4L1Vzakt6Wm1Cdm9QaXE5dDhwVGd5TU1ORFJD?=
 =?utf-8?B?NmlWdVppSGxnelQ1azJtRkhlNWlTYjlPamxmSnd2cmhTdG9yM0g5Qm8rOUFo?=
 =?utf-8?B?d05rajN2bG81Vy93VmZHTk5kRytCTkQ4QWxWVWhKT2xMUVl2Z0s2UFQ0VXZY?=
 =?utf-8?B?TE43aEdIY1ZBMXlxemlFZFJpek8vb3dEaVFlRVlvL3gxMno3Z1k3UE5Bekp2?=
 =?utf-8?B?U1dFY2RwRitBVTU3Tm5iaFpsOXUwOEswNkx6UlduUUF3SUZuTnVVVk8wczAx?=
 =?utf-8?B?bHoxMlRTOFNxRmZnV1FoMFV3SXEzeWlmNXgxWTlJSGpUeHNlemd3N3VGSEU2?=
 =?utf-8?B?MEtYWGZyUC8xaWZGQjBnbm81NHFidDVaOE5GLzZBSXh3ZjRhV0pZdWxyNWQw?=
 =?utf-8?B?OTd4NWJPZ1BjYVZSK3pFa3dlcHBDbE9HSFVvTDgzY3NqTEVyajZsYnBKb2I4?=
 =?utf-8?B?aFg1TFdrc2t1VEtsVlMyZVI5YktFbmVHOXVuS1J6NlFycnlPUmhiR1owR2s0?=
 =?utf-8?B?WFhEdzlQaHZIaG9abE5LN2d4WWxXTDhoOUtqUWVBTWwwejhPMlNCcUtXZXhp?=
 =?utf-8?B?VnRHV3lGeCtkbHkwODIwV2NlT1MyMmNyTVZGNitJSmNObDNSU1BKUFdRa21h?=
 =?utf-8?B?LytWZzVpL0w3cWZsbURTTEtJRkk2UkZWVjVMY0FmUEt2am5UR0UxYUtES1lT?=
 =?utf-8?B?bStiSFpxb28vQlI4MGEvRTlob05Vb09rWEo0ZkNHOUtrS3cyZ1NDbGN0elJ6?=
 =?utf-8?B?VEQ4cS9Rc0VUTHZKelJvb09xckZaZ0NGUkw2R2E4NHFKMlgxK3VEOVNVUS9C?=
 =?utf-8?B?VlN0WkpmTUhQM2N1WERxeFBldHRLL0Z0OVVPSTVlUmM0akZuUkVUMGp0ZmFy?=
 =?utf-8?B?REFmeXVBUVphVkZaNk5Ic1VWY0RiNi8wOWR6eW9SZHNubmthaURuTlpOUHJa?=
 =?utf-8?B?YnRlU3NPMEdWYk55eEhtRCtzRVN3b3h5VmtTZUpJZTJ4WFQ2RnNTaFU3dHJw?=
 =?utf-8?B?cTN0MFg2d08rMUNaQXhUb3MzL0V6b0kwTDQ5bDMwOUJNbVQyUG5ONVhpNFMy?=
 =?utf-8?B?U0kzOWtkRVNOM3RSZnU1a2RhTHhDSUE3M0NDd0Z3WE95Tjh0bWtpMG5SUmR4?=
 =?utf-8?B?NVpzZ3UyL3ZNTVVpdmo0YzloeWsxTThKWEVpNzFTeXp2YlhvSzZycEhaY2Fk?=
 =?utf-8?B?YUtDOEFKeVpIYmYzK29GK2dhTklSL2FqY3RIaVI1aVo5Q2M5cXBnRmRZK2d2?=
 =?utf-8?B?bmRpbjl4NGhBdGJEOTJtWWlGU1cwVFZvVnhwMHNkOTlLQ0hoUzRkSkZqYjFI?=
 =?utf-8?Q?7j08ymf+t+XWlD9t9ylh1Gn1T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df02b488-ca25-41f7-3add-08dbae40f350
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:50:18.7662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KYx8heIl0edua8yh8zT0UwiZ3rhYAcbjXHmMfzkmj1qCQfBOyCZW1whLQ9/c8l5WxJLsAcnc1B2FiTSzvQUbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-09-05 08:20, Harry Wentland wrote:
> Can we boot the system if we only apply patces 1-3? If not, we might
> want to move patch 2 to the end of the series.

The system boots with the first three patches namely

drm/amd/display: Initialize writeback connector
drm/amd/display: Create one virtual connector in DC
drm/amd/display: Skip entire amdgpu_dm build if !CONFIG_DRM_AMD_DC


> 
> A bunch of these patches are from me. Would be good if they can get a
> Reviewed-by from you (or someone else, other than me) before merging.

"Reviewed-by" are sent to Harry's patches.

> 
> Series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Harry
> 
> On 2023-08-16 17:26, Alex Hung wrote:
>> This patchset adds drm_writeback connector supports and enables display
>> writeback block (DWB) in AMD hardware.
>>
>> The function can be tested by IGT's kms_writeback test which also
>> requires a number of patches to enable 10bit (DRM_FORMAT_XRGB2101010).
>> Patches are available @ https://patchwork.freedesktop.org/series/122536/
>>
>> Alex Hung (10):
>>    drm/amd/display: Initialize writeback connector
>>    drm/amd/display: Hande writeback request from userspace
>>    drm/amd/display: Add writeback enable/disable in dc
>>    drm/amd/display: Fix writeback_info never got updated
>>    drm/amd/display: Validate hw_points_num before using it
>>    drm/amd/display: Fix writeback_info is not removed
>>    drm/amd/display: Add writeback enable field (wb_enabled)
>>    drm/amd/display: Setup for mmhubbub3_warmup_mcif with big buffer
>>    drm/amd/display: Add new set_fc_enable to struct dwbc_funcs
>>    drm/amd/display: Disable DWB frame capture to emulate oneshot
>>
>> Harry Wentland (8):
>>    drm/amd/display: Skip entire amdgpu_dm build if !CONFIG_DRM_AMD_DC
>>    drm/amd/display: Create one virtual connector in DC
>>    drm/amd/display: Skip writeback connector when we get
>>      amdgpu_dm_connector
>>    drm/amd/display: Return drm_connector from
>>      find_first_crtc_matching_connector
>>    drm/amd/display: Use drm_connector in create_stream_for_sink
>>    drm/amd/display: Use drm_connector in create_validate_stream_for_sink
>>    drm/amd/display: Create amdgpu_dm_wb_connector
>>    drm/amd/display: Create fake sink and stream for writeback connector
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   4 +
>>   .../gpu/drm/amd/display/amdgpu_dm/Makefile    |  14 +-
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 375 ++++++++++++++++--
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  12 +-
>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   3 +
>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  22 +-
>>   .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   8 +-
>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 215 ++++++++++
>>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  36 ++
>>   .../gpu/drm/amd/display/dc/core/dc_stream.c   |  80 +++-
>>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
>>   .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c  |  23 ++
>>   .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |   2 +
>>   .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |   3 +
>>   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   4 +
>>   .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   3 +-
>>   drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   4 +
>>   17 files changed, 742 insertions(+), 70 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>>   create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
>>
> 
