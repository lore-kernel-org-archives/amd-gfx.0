Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C27AC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 19:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1F610E4FD;
	Wed, 19 Jul 2023 19:34:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5380C10E4FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 19:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED3OEyYGj5I7Z8m0lgXF/Q68iErzvRUQUxTP6MCndnTEQ6ihVve87e4HIJjAyI3K1mrTTXhP3AZAVTr8D1vEzQNgQdWH6yBqFNUGwdRL1dy+Ufu+E1TRDlTEley2cEY7vOcg5SrMYmepnlyGD72xDB2QbhREVLK68Czcai4yrs2pne3TYnN6ExmnLo0xGTxgyFeibM92JjtCSi9qUE6RDKXre40n3dNL1BgpxVsuzaFkEWk1VPTIKtI+KxOQlGBiuCtMUUekN2MrBpi/CCDgsbkhFra3d4HnPwYNMvNoeIKcX5WJJNvI4CTzs7mkbGtFSbiNlh3gG25AKihKKrnUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3C6iRVGuRNzsSFLtsZ8FhPz7nVPpweerj6m3fN7AGU=;
 b=Tt6PjNCHumqBem5Q4TvPwICuXy2t2YzECVIBAzveXlU+zw+WbhgHRGAgN7inFChEW1w7SYeA4Vr7uD9RA12EiTNGpxSR40OrRM93qq76o9Z2NDIELtdjTlBI8OQgkDHY5NMvBZrP/cse29s0Gq0p+7VfGO6e2hS6t03lIW/y3QFhLKiNSMC7sd+LtbgKV2ADxXloZkIpBV22YV+1R9dUscO/ZLijfgRhPQtSrdUx3adoeDz38PiTVWArlviPpmasNvzrnnDHpNONWMfvJkG3CdqzNsYuR8ogxnkhxIe271kwsh7SwN34NMuQz8PwUZomJsiW30lxnZJxKh1aZB0OWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3C6iRVGuRNzsSFLtsZ8FhPz7nVPpweerj6m3fN7AGU=;
 b=mDOYjiXIvrt/mHku5J0dmW2FW/cJxt4x++mh7vM+S9choITfyP853N/knz+q3dZfQb3Vr0Ig2LxA36JUGFKySmmxrpk2FqMQfILdWSQEcidy9/R8ay9dSNhlfGV0K+yf+jc6i8GQP16WpBUDc3dWNS4Az7M2+ejS4IeeCa0u5ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 19:34:36 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1a2e:ca36:f117:d2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1a2e:ca36:f117:d2b%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 19:34:36 +0000
Message-ID: <b021b5b5-2ac1-d54f-3987-54f8d6c41af4@amd.com>
Date: Wed, 19 Jul 2023 15:34:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/10] Freesync Panel Replay V2
Content-Language: en-US
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0498.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::6) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH0PR12MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: 99527178-7556-49b3-2c47-08db888f2fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opS9Kn6waRYKYkclareBQJ9UgAp8FRCC8+3OPaftefku4P696D8PCopYrWmjVq4h9ZFBs2Mo8GdMvy8mKmzTDSYskoG7J23flu3rLnqCGf88uxoKbaPWlR/yV1NghaoWkToYZ+aDIwOdxots3sTDk5HW87ogVIZAwyZxEVWYHNOrGqDZKCxYeK4svuu6OW5jVfFOwn6s6uLAGZmmoS4eOik2fqFk1Hqeh/3NHaBgD/Vorhxw46kgn3+2+nsIhVRbllw0SU+cZS9m0gFDecGKn7Y9aDaHkrK5+p+JDe1VvUznVOkHDk90dSsZMj2JzBqb30IISOu7TFbLLvWhBKQWQIp+2dx5T4Ns96Z4zzqR7iLTaWTyxu4Xsf80K2d1aMQkeB+Dzy3MSRJcU3tfch5+1DTN6qsOPD5AlFko4dc1TfdQwvPhIQ+/yceoEYIB7n3+n/9XR++QbZnGgUJOTYavAlHtHwLMCwxLxu79nLxrT1Q733y4SuKzI9KzL/B8+ZZYk7m5HJuNhZQu5LX9vNukTj+SyPeVSsUg3w+RJ3ERPOhpnUVdT8ZmG/zL/L6KR4RDcXXq9OZvFHIu1LbUzWXw1Ptooi8meg6EKZMMRyOd3YxrCBcnbsikach6fiZNlNPpaU6PGeNTtyR5EUrzH22Jvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(31686004)(86362001)(31696002)(2906002)(36756003)(44832011)(6636002)(6506007)(2616005)(6512007)(186003)(83380400001)(38100700002)(26005)(53546011)(6486002)(6666004)(66556008)(66946007)(66476007)(478600001)(5660300002)(41300700001)(316002)(8936002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHh4QURORkU5a2NHcEZZMHJwYWVScW1WVGNnYm4vTGZ5VUdrUmF5OUt4Zy84?=
 =?utf-8?B?MThqZFovSlBlWnRJVVhNQ1A2cGY4VHFQaUtqWnJKLzZxMjl2OTF3bjI4WW50?=
 =?utf-8?B?OGlJOXZCcUwwbGhzRVRabi93K2l6Q2xqRE1RREpTOGJ6ajV0WlZYUHlabWMr?=
 =?utf-8?B?cHc5cDBrQnUxaG5qKzl5Q0RXTUZwR2ptdWRtZ1pmajBIc3JZR0FUWnJpb3ls?=
 =?utf-8?B?d21KbTV6WVJ5OUVkYVBjU3JQem5BSzYxOVNMbzk5bExHemZxMFJDZENXZnMr?=
 =?utf-8?B?NWpRcFhFOFIvTHN0OFROendzYnU4UEx1Unk0TktOY05XNDdMNE5NZDJhSnN6?=
 =?utf-8?B?VmVRQ3lDcXdIRUl3V1NmQk5DTHBDRmtZaFBDOFl0dThRcTNVWW8wclpJRVpU?=
 =?utf-8?B?VGk3Qk1ydjFwODN0b3QwSlVOeUZWdkJ0NXl4bFBVd1U2cERqUXNHMjEzcldM?=
 =?utf-8?B?aEZHNE8wMmp4L1J0VG9FVitiL21PMXMweDFKSWhHblY3RmJZejlBaXUzamRG?=
 =?utf-8?B?eHhQbk9Qa2tJRmhXbGRpS1A2ZzJhaDEyNU9pMjRFYVlwb3ZWdk56d3JXb0RI?=
 =?utf-8?B?Q0NOUk8vRzlBUml4bFk1T3lETmUyaFpzdXNQUnRrU2ozT0VMOE1uRUtGWE4x?=
 =?utf-8?B?VjNYK1FsOTRZcmxVTklyczRrQS9WRnhwZWJBbUNSRkE2c2JrQjYvQ0xZUVBv?=
 =?utf-8?B?RFZUemRSV0VRbXNLMXp1REdEbjcrQkpkenZYOVQvK2pyazNJL055cEgvMzZP?=
 =?utf-8?B?Rzk5UHQxZlM1M24zZFlRcjFkTUlUdkpHc1kyNFM1N2kxeXBhQUxUWXdCVFRU?=
 =?utf-8?B?TEY2eFJOa1lENlBLTUFSamhYOVpvdFFsY1VqNVBBazltL1Iyc1lMVlo1Um5J?=
 =?utf-8?B?WUhsaVZIR2pKZUVTK3Q0eFJ6ekFPcXBVSGVWSzlmaTg5cUNMbi8yT3hvUVBs?=
 =?utf-8?B?R2pJQXI4KzBidUt4L01COEZiSk9tYUdzaHMyK3ZueThJek9xaUxDZDM5dTQy?=
 =?utf-8?B?Rjh4ajNiV2RJN2U5Qnd3ODVYcTBwTld5MlRYVjN3TnFPOEdTTTV5SE5lOHZS?=
 =?utf-8?B?azR3dEdKVjZrZnVreVBjZTVOVnlhVUxGTHdBMXdsQytmQnpxTTFkSUhlaysx?=
 =?utf-8?B?UXF1Q0xGaEc0anlSVURoVFhIYitMcXhxajNxQ0VPZnFpcXhtV0M5RDhWTnM0?=
 =?utf-8?B?OVNzbWZUZU54RE0rQXZRMkJnV3N4R1hYZVhJd1NSS1dGSFZUdGcxV3czdXk5?=
 =?utf-8?B?KzFIQUVhYXlRMFZEMis5OWdySEZ5MlNncW41UmVRZDlGOHBTbzZtc3ZRTVI4?=
 =?utf-8?B?bVhrRGVNNkltd3NlK244OGlEK1hVbFAwbld6SE4ramI4Y2VpdHE4c3MvRmJS?=
 =?utf-8?B?bkdrd0IzNGdMcjljZVYyWU1odmIvSXZTcXY0UENwNlJRTURzNEZjTmNEdG5Q?=
 =?utf-8?B?cWJCSFhKOTIrL3J4MUhYdTAxTXhGS2NzRG9PRmRldjhSNXBOWXM0ak5DYTI1?=
 =?utf-8?B?dUxQU05PRE00T2FGS01NaDM1YUlrVHdRYTdQOUMyUkZCTStBajZBejdod2lu?=
 =?utf-8?B?SldTVXhydUwxWGxMSUlnTktRTVFZUXR4VzhEOHptQko4S2JubjlPaElmeUJZ?=
 =?utf-8?B?MjlGUkR5eDMyYWpyY1FMOHJKb3hTcWIxTTNTd1UvM05lbm9ydTdJYkhSaXZZ?=
 =?utf-8?B?aFg5dnIxdzhadzNaU0tEbGU4TW5vSzFOL2xqNmFUb21XclJ5MWFTU1NnRlFE?=
 =?utf-8?B?bjRTYTgraUlIZklSVUtoSTFRemNxYXpTc0pDcFJqSVpFMi8wZnF5bjF1Tll4?=
 =?utf-8?B?eElNZVRDNTJiUzExcXVaaEN1WDZqQ2RxQmtuVWUyZUpWOHkrNlAxemwrV2hr?=
 =?utf-8?B?dGp2RSs1TzFmME1LUk1DREhZdE9hYVN2aVpCODNVVk1zbGV6bW9Jd0NkK0xK?=
 =?utf-8?B?Vm95Vk1OeHBXc1h5cGpRcy8wWTcwdmJnOCt6UnI5OWhJMFVpRUxIZmtFbkx0?=
 =?utf-8?B?blF4TUVzcEx1bGpIN1JpREJaZFlsVWVSSVZBOWtnNFIwbXJzL29uL08waVIv?=
 =?utf-8?B?bXB3MTFxWnIzT3NVcW8ycnVEWEl1OVZxSjdERXFwVnV1STRESnUxSFNlQUkr?=
 =?utf-8?Q?Q44PLxT7L+aG/hCa8m2S/nG1l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99527178-7556-49b3-2c47-08db888f2fa6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:34:36.5964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIGUl2MAJQWXWA+CdA/xeFdJ26mwGMTWcu1S9KfJPsCHwwljuU7v3Yn/1sVX0KHOwLT/wJrwdu9ZAo3Vvc9Bcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
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

With my comments on patches 6 and 10 addressed this series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2023-07-10 15:27, Bhawanpreet Lakha wrote:
> This patch set introduces Freesync Panel Replay capability on DCN 3.1.4
> and newer. Replay has been verified to be working with these patches (in
> house)
> 
> These patches are enabling panel replay in static screen use-cases.
> Other use cases will be added as they are ready
> 
> 
> The importance of Replay
> ************************
> 
> In some instances, the GPU is transmitting repeated frames to the sink
> without any updates or changes in the content. These repeat transmission
> are wasteful, resulting in power draw in different aspects of the system
> 
> 1. DCN is fetching the frame of data from DF/UMC/DRAM. This memory traffic
> prevents power down of parts of this HW path.
> 
> 2. GPU is transmitting pixel data to the display through the main link of
> the DisplayPort interface. This prevents power down of both the Source
> transmitter (TX) and the Sink receiver (RX)
> 
> 
> 
> How it improves on PSR
> ************************
> 
> The concepts of utilizing replay is similar to PSR, but there is a benefit of:
> 	Source and Sink remaining synchronized which allows for
>         	- lower latency when switching from replay to live frames
> 	        - enable the possibility of more use cases
> 		- easy control of the sink's refresh rate during replay
> 
> Due to Source and Sink remaining timing synchronized, Replay can be activated
> in more UI scenarios.
> 
> 
> V2: Bug fixes, V1 had some issues which have all been fixed.
> 	- Invisible Cursor
> 	- Random Hang
> 	- Laggy System
> 
> Regards,
> Bhawan
> 
> Bhawanpreet Lakha (10):
>   drm/amd/display: Add structs for Freesync Panel Replay
>   drm/amd/display: Add Functions to enable Freesync Panel Replay
>   drm/amd/display: Add Freesync Panel DM code
>   drm/amd/display: Read replay data from sink
>   drm/amd/display: Get replay info from VSDB
>   drm/amd/display: Add Replay supported/enabled checks
>   drm/amd/display: Update replay for clk_mgr optimizations
>   drm/amd/display: Update adaptive sync infopackets for replay
>   drm/amd/display: Handle Replay related hpd irq
>   drm/amd/display: Enable Replay for static screen use cases
> 
>  .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  71 ++-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  14 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   9 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 183 ++++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |  46 ++
>  .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
>  .../drm/amd/display/dc/core/dc_link_exports.c |   5 +
>  drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   3 +
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  29 ++
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  41 ++
>  drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
>  .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 303 +++++++++++++
>  .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  58 +++
>  .../display/dc/dce110/dce110_hw_sequencer.c   |   6 +
>  .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
>  .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
>  .../amd/display/dc/dcn302/dcn302_resource.c   |   1 +
>  .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
>  .../drm/amd/display/dc/dcn31/dcn31_resource.c |  13 +
>  .../amd/display/dc/dcn314/dcn314_resource.c   |  14 +
>  .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
>  .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |  19 +
>  drivers/gpu/drm/amd/display/dc/inc/link.h     |  14 +
>  .../drm/amd/display/dc/link/link_factory.c    |   7 +
>  .../dc/link/protocols/link_dp_capability.c    |  10 +
>  .../dc/link/protocols/link_dp_irq_handler.c   |  66 +++
>  .../link/protocols/link_edp_panel_control.c   | 165 +++++++
>  .../link/protocols/link_edp_panel_control.h   |   8 +
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 412 ++++++++++++++++++
>  .../gpu/drm/amd/display/include/dpcd_defs.h   |   5 +-
>  .../display/modules/info_packet/info_packet.c |   4 +
>  .../amd/display/modules/power/power_helpers.c |   5 +
>  .../amd/display/modules/power/power_helpers.h |   2 +
>  drivers/gpu/drm/amd/include/amd_shared.h      |   2 +
>  38 files changed, 1533 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
>  create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
> 

