Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569B6C83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 14:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B301610E52C;
	Tue,  5 Sep 2023 14:20:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D391F10E52C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 14:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8GdpGqMtBbsEguyyRP0ZerS0FO/QsP4cxIzHMlDBxzmqTYq1a2aUQYf385fzqPni6gq7Ng89iyNDGu3wFQvOhGUXqNkWRNaXp+3FM+GXwGuQv0TV0MJhVrGy1YdWJZx+yX12Djw3m0HVs778z/N1rQDAhoGdL+vwgpTZH1QoJCKJrHq0G7E97e7SJ4je11/OKdl6OXgsCObt1UvlSAMpxDNYp2dXPbnWTOV5tDglNqgMTAVVePktUq91o1BRG20Xrc2VPx4PXkDo9q0G0P8oLWpk5AuZOOKYchbuNC+Si8FnZO9cm95wYRqDAECOVF1wZ8fj9BU4kNN4jz0AHxjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzvVIa4Gn7JyzWOUfK5+dPB/yZZyZZBee8eEAUjv7Gw=;
 b=F0L+dKkZPTo0DXYoQQw0ziMItfI9kZqZXyw1qBq4LHzRvFTldg9EqUOUiYOPGKDe0a2nwln925bjVH+3YSDQ9bbWXGaRXWY6gdQX/XS/T0OmvHomdGewTk2BEOMvwb0zu5CewSTJCkmJYizFCFJhRVIFW96i3ZropWLslmSV5Mz8iAWlvKKZqXWwjIrCvOMayYkRVd6eZnFjVwEBcoi1hxuu/G5y/f9atlQIKw6giBFKAmP/BcWmBg53YAtNbX2nTnEbcSR3xNZR915HMkP2loyJ0MeyOnP3tof4Spd5fygabb+CTKVqomRjNnDhuVg7CKs7UbRNcaynRkm9Bzvxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzvVIa4Gn7JyzWOUfK5+dPB/yZZyZZBee8eEAUjv7Gw=;
 b=ga4OuQs4/1jnN7br/ySgxx5ENKOQ28wcpjuaMQ6Gygd+e2OUTnXsv8HZnjVVk9TjaDCX1htdfDIWZtR+lqNo2G7dQnGIW8Tzb5v/VZCtnnN44NP39Gt7DKmY2hem8YPq0LCi2SLzwBQuY8ICp3yR1yC6ekcVTNrHbp9ePok8SyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 14:20:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 14:20:35 +0000
Message-ID: <8f46d033-32f5-49b3-bf4d-6e62460e6370@amd.com>
Date: Tue, 5 Sep 2023 10:20:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] drm/amd/display: Enable writeback for amdgpu
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e4cdec-f0b5-4ffd-8b28-08dbae1b4513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsT3wyp3UdXMg7QjeKR1W+LAY3JlyVFrb2TUz+g6idBzJCtCfCMeeRUKmSQ7IZFeHqUA37454AQykyncyK7wphvPAU3jTi02xasOFj7Lu4que4+u03nXZusaGZvprXHoQV8OJ74kqozg4MTn59zELiwNJx3/rCjPLkcpbJPHs3qKWLScSUp6XshcJJfquKXa1g5RVr8rGyjza+L7LrmHXt8PyfSYiFZuktUAM6fpZPPm5jZIXZ0k59G5aHpvtSr9pFSq7JJbgnOaDkvzheEd+Q+SQgR55JBFKJgfR1pUry8tuaEmTeOxlGcWsGEriELYe6p47aAdtmfHoHNUUptbgMpf7od/KLpHcjRdFDvKUsp5nZNqbN13CgCQB8AcUMuVHPnYqQ1culhMeTF6oWPWfVQJE8EbzdLXgeNMx6DB1vUNWf/Q33stdPu8YQk4EGsArAxFd3cIwK1gPQEFvx0dzJvnkvyZbPRHtYjUTUuuysOZC1InVBFACCn9ks7SqEGNjNsJatQsBAuiS9nnLPruC0NAQE78Kip6FINFtts7Z5wm5RtWPygVdi4dpKWY9pVgjxtSTSz3GTVga4h7omLZIP3tWwqzTIrftkPwqpOh1t5+88gkI7TSKUAEq/m4HJb3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(1800799009)(186009)(451199024)(966005)(478600001)(6512007)(31686004)(38100700002)(36756003)(41300700001)(6486002)(6506007)(53546011)(26005)(2616005)(66946007)(66556008)(66476007)(316002)(83380400001)(6666004)(5660300002)(44832011)(4326008)(8676002)(2906002)(8936002)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmdqUnZnUlB1Qm1BcFBvKzdqdkxJakdWN2hQUzV5ek5yQ01yMjhSMlZCcURT?=
 =?utf-8?B?NGd3cXpiYnlGQWNtT3Z6N1hOdmdOMWEyZlpDVjZYTHE1NmlYdkN0U25uUk12?=
 =?utf-8?B?ZTFlN3pOU3RVSElWcENkQ1ZwT0xjMFBrdmw2dUR1bVFQYjQrZkpuajF4UnhK?=
 =?utf-8?B?UVpHcWUzWEVnb3JyR1lTRHFLT0NyNld5N0RyZ0R2YjZXQVBzdkUrZDVyZk5j?=
 =?utf-8?B?di94cFN3MlpibGZ4L28zdXpqaTBrTThzYnlabElhRzJRQzRCdWRDWTMwTGZv?=
 =?utf-8?B?SElTUndOVGMrTmhLWlVOQzk4RDEzUDdwYXRYZUNSZCtKSFhXMnRNb3FEd1Rs?=
 =?utf-8?B?ZDE3T1l0Z1RBOGZ3dVE1TEpFNlVIaHJsczVLNm9HVnlXbUR0TWhlT3UrVEpv?=
 =?utf-8?B?aCtXY3B1M1NPdENPOWY2MFFWMDVBUC9FbW02WTJMQnd6NXVxOEF2NDE3Q0la?=
 =?utf-8?B?Z09PbTJsVTdtdHNrZ3NaVUZXOGFramwyc1ZpaVJzcHdPRXlMR0JOY1VMU095?=
 =?utf-8?B?bHluRjVmblBDVmNXMEVOc0pabjVlL2cvb1pkVUZBUTNKaVBRSHZzaEc4S20y?=
 =?utf-8?B?SmhFVjNSTENsaUZLUFhNQUF5MjhiWDBqbHY2OVB4MnRaK0pBMk5jajEzd0hW?=
 =?utf-8?B?OEs2anpsTTQwVzgrZTZtMmxOT2FvcTVQUWRXczlFbkt1ZmUxZmxGNS9iTXVP?=
 =?utf-8?B?MlhpSWp2SFN5aDJiTXEyRVdWdmsrc243U203YnpFVFU2Mk1EaFBxWmxQNmRu?=
 =?utf-8?B?U1VYZ1NXMTFXek9WMGh5R0JHcTAzUGxNUnRkS2ltdlh3YS9SaDRCQWtFK1pW?=
 =?utf-8?B?c1YvNzY1TTZmY1RrYnFtejkzN1ZaME9iMGhpSFNCWFJDQWlxT0NoMTREMm9B?=
 =?utf-8?B?WTdwL3kzSzR3NExqOWR5dTJDRUNWRzg5cVN0RVJLSm5yZFJkRDd6T1FwcWhJ?=
 =?utf-8?B?SWYwNUZJYktaK0VkRmEzejNVK0lNVnhIVlJxMGd5QXJrRkoxSW1FUUlIclQ0?=
 =?utf-8?B?SlZBNTN2ckVhQUFjdXJOTURMaXNCaGl2NjBFd1ZQcGZScC9WWUVoeFpSYWFD?=
 =?utf-8?B?SWNKWE9rZkpVQzcvL0xqQ0dPa0RteGt1OHpmamVlZWxXRlQ5eDAreHBLTTFV?=
 =?utf-8?B?K3ZaWDliYUlTNVFmaHllTE1qMzM4OUZXOVNwYWl4MDZXVGRVOHI3NWc0MlhC?=
 =?utf-8?B?bUFsdWNaMy9Nei9sV0w3VHZuYjNzVXZUcGxjNHpXanVmcXFqTUw3RjlwcnR0?=
 =?utf-8?B?d3B1M0FMVzFLM0dlNUt1b2Q1NHZ0SkdLZHk2MGRUYjFjMSt4TlpHbXpUM2Vh?=
 =?utf-8?B?RzVsc25rRjE5S2h5SVNYZUc2UVZXTGNZUTZ5c1Myb202YlB3WWtTc01tZGZt?=
 =?utf-8?B?UUEvaUExWk8wU3NTcEl3SDB4ZUVOa2UrWEFVaitxcU1zcUdkc0gwbllkYkRC?=
 =?utf-8?B?TVphdXFqUWUzUUg0ekRTMWhacDVYczc5MVU4T2pxZjBXbkFvRGVyczhYSHZp?=
 =?utf-8?B?TmJMWUY4OUwwQ2s0Q2tSbzVOR05EeDNrR1RORnpSSG0yUzhtaWZFWHk2bGhI?=
 =?utf-8?B?STVlMXpyMU8xTkJYK2t5aHh2MWpJeWtNdm92Q1RMb1FBNVoyM3BRMVV6VkNx?=
 =?utf-8?B?S3NSaTVtS2ZnVWxnU2ZzU3Q1MG9kV3pvSHpSS2tBaHZiVG1QWjY0ajdhK1l5?=
 =?utf-8?B?c3Ura1k5YU1NMXRGamQxUDRPdFplQVpkRE8rdkhGUTlUS2dGNWMwZFNZV1Bk?=
 =?utf-8?B?UnZLRTF5UlZCYTRoRVB4ZFdXRzY5ejZHMXBWcWwzQkdtTVR6Q3NkNUJwTy9r?=
 =?utf-8?B?VWd0REhiWHUvclduR05MOXB6eVNDK2tKWXNqRGFaa0dnaXptR0swb1BlM0lN?=
 =?utf-8?B?LzR3b1QwZ1BKRUpadVk2T0pJMzBBeGNiSFBaVHl5OVRXQTg0QXpUL0t1N2hM?=
 =?utf-8?B?eHp4dlFkMlFqS2JKSmp6U21wb0lOKzNIdjJJMnZ0V2h6ME9Ddklkbzl4YW1Y?=
 =?utf-8?B?blBveWNoai84ZkNZZ2wrQ2NyY1c1RnczSVJlZjRZU0gxS2RFUDY3bWFXNEV5?=
 =?utf-8?B?VmVRZjdTY3NPVHpBaDg4OGwxOTR0WmU0QlQrTDQ5bEs2c2Z3QU9uS3BvUnln?=
 =?utf-8?Q?6p72TNApS1sujD65mEgs0DvbA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e4cdec-f0b5-4ffd-8b28-08dbae1b4513
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 14:20:35.2086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fyuys7HHUJTRre7YQomysPFfYLEH4YNTEjetRaz+NoEVMGyBMqNglAb0VNkEuz/QIaCig05GpjCXF0uGiWaiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
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

Can we boot the system if we only apply patces 1-3? If not, we might
want to move patch 2 to the end of the series.

A bunch of these patches are from me. Would be good if they can get a
Reviewed-by from you (or someone else, other than me) before merging.

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2023-08-16 17:26, Alex Hung wrote:
> This patchset adds drm_writeback connector supports and enables display
> writeback block (DWB) in AMD hardware.
> 
> The function can be tested by IGT's kms_writeback test which also
> requires a number of patches to enable 10bit (DRM_FORMAT_XRGB2101010).
> Patches are available @ https://patchwork.freedesktop.org/series/122536/
> 
> Alex Hung (10):
>   drm/amd/display: Initialize writeback connector
>   drm/amd/display: Hande writeback request from userspace
>   drm/amd/display: Add writeback enable/disable in dc
>   drm/amd/display: Fix writeback_info never got updated
>   drm/amd/display: Validate hw_points_num before using it
>   drm/amd/display: Fix writeback_info is not removed
>   drm/amd/display: Add writeback enable field (wb_enabled)
>   drm/amd/display: Setup for mmhubbub3_warmup_mcif with big buffer
>   drm/amd/display: Add new set_fc_enable to struct dwbc_funcs
>   drm/amd/display: Disable DWB frame capture to emulate oneshot
> 
> Harry Wentland (8):
>   drm/amd/display: Skip entire amdgpu_dm build if !CONFIG_DRM_AMD_DC
>   drm/amd/display: Create one virtual connector in DC
>   drm/amd/display: Skip writeback connector when we get
>     amdgpu_dm_connector
>   drm/amd/display: Return drm_connector from
>     find_first_crtc_matching_connector
>   drm/amd/display: Use drm_connector in create_stream_for_sink
>   drm/amd/display: Use drm_connector in create_validate_stream_for_sink
>   drm/amd/display: Create amdgpu_dm_wb_connector
>   drm/amd/display: Create fake sink and stream for writeback connector
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   4 +
>  .../gpu/drm/amd/display/amdgpu_dm/Makefile    |  14 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 375 ++++++++++++++++--
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  12 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   3 +
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  22 +-
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   8 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 215 ++++++++++
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  36 ++
>  .../gpu/drm/amd/display/dc/core/dc_stream.c   |  80 +++-
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c  |  23 ++
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |   2 +
>  .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |   3 +
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   4 +
>  .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   3 +-
>  drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   4 +
>  17 files changed, 742 insertions(+), 70 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>  create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
> 

