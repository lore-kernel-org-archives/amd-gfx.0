Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159C9C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 17:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD4C10E10E;
	Wed, 19 Jul 2023 17:45:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A5210E10B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 17:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVBdcKr8xn+Nc8CgTKcc8jhLKfs+MejSxHWuqr/8Lj8D3eDAdko8FBX3hghZM1nMPgyyhYsKfTHnYz62/dh8YceCW1LgOpbjJB/pybdLkqxB4gOK5jFc+XcXJ0xtVlUJFCQ2J3uiNmKnCRHKga9poNyvq5jxKUZtvkZm9YSLYJSve8plNvwxZnKgON1hAy7q6751OBAt5aPz8anjUyajCX5pIGivWpnCntqGMDn0i/2XHeT8shqWxWadjgq1pvmGD23OhMB4EXUZ7Zzs4nMPNG1WZaFZmYKYIAhTjOBdC1frlFeDaJV4stnMbAl+pv9vE7MxabyGQufD9xdxusFGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+1OUVYgpdpyR+XVfs37GhPiTgFhFp7LpwLyyfV8JI0=;
 b=mU0NlHAJ+gyigzMmn3y6/a5GXH1O6XS0mUXCoglyu8URG2mZCPecwQJ0K1Gwr/qrTo8ntN1RxrpAPa3GdNGG0SgjDbpBwbSMcGtlTJ2sAOBJEE7QDVuR8T6r+NUhIWHiG7b8cg4o51bYiYEfeHgVAwknfzo5tlNAdCCMTagyGKaOtSM9HKSmxjDDBsmdgvhOd+MhndQK6FCjc/p4OTmUmzXHKG/l+0D4/J4nBEAhABN+wEL8bxKq9lQAQiWnWbuWXezh0nJAZnmE5Kp8rlFj4xjqlaalmiMwLoCK6orEj2zC5ngTMPxpUN41VlUpdfoHTNSw6Bo0zcQoexKHFtL1Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+1OUVYgpdpyR+XVfs37GhPiTgFhFp7LpwLyyfV8JI0=;
 b=Tm21i38g1SllWxTwU4yuBq/ZZLy8wot9XuOwXKWJY5Hq7JQso5Dp0GquQDtu2vpMYRQWf68SJKJZGkEMk0yeCZVXDslgfu7JvjU+BCbXiaRalvB3Da1CDrPdK2wZBaNO8XjWdP46BijIIAyAS5huVsPJ9vhs81C9lFKTiDkqP6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 17:45:39 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::3743:dbe0:a51c:330f]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::3743:dbe0:a51c:330f%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 17:45:39 +0000
Message-ID: <7c806c59-d49c-a80b-d2e7-e2c1feb8f407@amd.com>
Date: Wed, 19 Jul 2023 13:45:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/10] Freesync Panel Replay V2
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
 <CADnq5_MAhTwsCsmMps7XqEzSAEQ1TV=nf+rnHQs0Amidn4s8KA@mail.gmail.com>
Content-Language: en-US
From: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>
In-Reply-To: <CADnq5_MAhTwsCsmMps7XqEzSAEQ1TV=nf+rnHQs0Amidn4s8KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::21) To PH8PR12MB7279.namprd12.prod.outlook.com
 (2603:10b6:510:221::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7279:EE_|BL1PR12MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 66defa89-dbb2-4168-3f0e-08db887ff700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HY93tMrBSUY28nBrZZ2ueU/9A0Q1ghKjlAPyUCwLAXoL3TM6z8zam7BukTNpzM0BLAJgF5k94PnRepnNLNiTTYwzw6Lo4AcUDJ6ipZ7ye9qJ4IFibJ3asgV9cfFQ9X9HiIMK+pOXXRSkAHldmcl/tBMVzeXaNl0HN4FhZqkewsu92I9dEAsH8H1LNH1+tCWiR3w7hX7vCw6beK3zWn0lczR0mz0ipWRmw9x6yv7pSUmJMdyxwVLKl+qHhtUWQY2rsagTH2vF1LtoWhvca+d+56hPl9leXouVyZfUvQnZLkwipbf9+ACZYlFoOgbUz8YCucJo3vyNc5ec74II008LV1YTrLkm1qkEGxROZmnzS0HV3x5ByiHjEZh6EJUeGmJmoRg3QO3KyhoRpJaQaEPUitJgtY+HFCwckeaddGWyYf86upH/QBywlLu93/yzeUTMVrcIhfXjiIozw3P4fQDH/4f5HmxqSoz4lC0JBHpW07OhtLqxPCl9iH2iv4vBbW3yLKKc89PfV6/X3WbenHsSF1jrU408yIdKbhLW0G0VS2htH1cf95mCh8iWmn6F5AcsB36zuAPVGdvEOUpKpxBy1c23qkNXPtbAvIUXLSV7+Q1+STg1LY56gPx/nEBd3SJ0Iu/z1VCUq0sVttIXKTvJdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(6512007)(6666004)(6486002)(83380400001)(478600001)(26005)(53546011)(6506007)(38100700002)(186003)(2616005)(31686004)(41300700001)(4326008)(8936002)(8676002)(316002)(5660300002)(66946007)(66476007)(66556008)(6916009)(2906002)(86362001)(31696002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WURvVmRCU2kzVHMycW1ZSWtWa29wTUtrUk8wd2pwRGtyaGo0T3diZjl0Y290?=
 =?utf-8?B?blAwaXdiNmczWlROMVlqSmdmaXZTOFl6ZnNiMWhXNThoczErVzNlR1RVai9l?=
 =?utf-8?B?QWdSL1JxcWRqOWpCRTB4ZWFwbVEvM25RQW5XSnFaSzA2QmpUSk16MW44czZL?=
 =?utf-8?B?T0J4VUlsWlRPd1Jld1FhZndVWE94K1RyU1F5NEJkTlZNN0ZwYmsxdDBrQ0dn?=
 =?utf-8?B?MGlzMDNwTk4rRGRCcjNIUXE4TEFYS2JnUHVBdW9OL2RCKy8vSTFVNnhBNCsr?=
 =?utf-8?B?Tk9TRTlsTkMrUkhrajRZZlNzaXdxNVQ3N3phODU0TWc3dk5NaFVsZm9pNXQ4?=
 =?utf-8?B?QzFWRlNVNkROZFEyVGxNL0t1WjRzZnlrVW9NeUY4Y0huQkZkNStrSFNHQlNQ?=
 =?utf-8?B?NlduMXcyNm9ySDdnVVZhSTJ5bmxhRVFEMWtJUmhhK3dKTi85Nm9aR3lZVHAw?=
 =?utf-8?B?UzZjS25RSlQrRFZWWksxYXVrY0N4ZlNHZ1hXbGhKc000MDV0VXRaT3dLenE5?=
 =?utf-8?B?M0JBblZFYTFyclFsTjNXNHlRRUE1bkVnUlNSN2x1OHdMalpJYXY4a3hMR3hZ?=
 =?utf-8?B?Zk4reUVGL1Bock5OZmZBZzJydUtRRkRWeHRWQnVxN3VrWkcwQ0xxOTd4WW9l?=
 =?utf-8?B?dlVzMENzck12UkZoS1JGVWZrand1WStCS3FqSmNCS3M1ZnZrN2FHY2VMQU5x?=
 =?utf-8?B?QkdRR3A2QXhNZWdkNndVL05lL2QvdjdrZWk4ampyWjJCNTBUenBKUC9kVUtV?=
 =?utf-8?B?bittTlJSZkZwVllJbVdyeldCM0xWQXRxeExTbFQ3eW9JZVo5U0VpUzd3Nkhv?=
 =?utf-8?B?YlVRbGVleEtRYVR0UWlSaEVNMlhWSXlpSDdiTythY0g1c05vWUsvSUlPOVgv?=
 =?utf-8?B?Nk9jL3NqWUJRZk9OYkxBcEphYnJvb3FwVlFaWkI4ZGczWVg1c1llYStQWC9U?=
 =?utf-8?B?cmFLeDh5eTJvd0pBU3FMZDE4bjlUdEQ4cGFPckUwUzlVTXhTRjcrQzJUMHJ2?=
 =?utf-8?B?Q0V0TktZbXIvNmhvOEhaZ2tJeVBTU2QrUTFrRHpMWDUvSGNPMFVxTzhaTERZ?=
 =?utf-8?B?MjVIMDlEV001UEdyWVpiTlZKalZVWUtkaGtkby8wRjIwSVZGMlpBRklGd2lJ?=
 =?utf-8?B?RDUyZ0t3K1pLWi9rUTRXSGx3UVlSWDdjVGdhTlA1SlJ3OWQzSU55dmNzSDVm?=
 =?utf-8?B?a29rVGlYeEZqa3JJTHd0N3Jkb0VYQmZJdnZhVlRjaWFhbU1salphakRoRlYr?=
 =?utf-8?B?RloxOHo5YTVmcElvZXFoeThBcUJXK3VseFAvL1ZkL0xteUNHdkQrWDFTM09h?=
 =?utf-8?B?bC9yamozbDFCSHJjcmlaOXlTUzNZRTZOaFpiM2J1cFRzUGIxWXVOckQ3TU9Z?=
 =?utf-8?B?YTh4blIxUnpiUFAwcXVyaHd2L3U3a3kzTzM0Y1dPVWEzVFdlQlY1THNJZGFL?=
 =?utf-8?B?SlJOUHNKY1BTbVdYN0lUZXhQZGk5N0xEOXVQdWtwVER0M0YrckU3a2I3OFI1?=
 =?utf-8?B?SnFCZGRzOXArOTNsY3IrbTlvakZyYVEzb1NOdlE4blN4bnJ0K0I0OU5XUHVV?=
 =?utf-8?B?VUlwVkl4dDg3SVpTeEQwMkJIOUtjS1pLQnJhYnB1RnM2RjUxZVRHM20vSW8w?=
 =?utf-8?B?YUNGcllZdHNOMjJQaVpRalNmZUFvUEpQNmV6Sy9ndmtybW9nalM4bjZneG1H?=
 =?utf-8?B?N3VNRStDWENPaThHZFhuOHlTOTdkREk4VHZQQStLa0xUeXhXWWRvaUlvaUt6?=
 =?utf-8?B?czZCc3ZON1FrVlIva1V6NGpmQkZ1UURNRUdFL1lFbDE5ekNidGNEWmwxSDFT?=
 =?utf-8?B?VElpNWk5TWxnaGJmN1RQUURtUTh6MDZJemI4UG01bGQ2OFBLSWN0QXNQSms3?=
 =?utf-8?B?UzRocmNtcE1QSms1a1g5b20vMlB4d2hkZFNta3pvb3QwT0lhaVN3VzlvU0dK?=
 =?utf-8?B?TVdHdHJBTC9rb2M3MjZQYndnU09vMUVTNWNlVlhnYmlSYUFvUnRDWUNHcktZ?=
 =?utf-8?B?bmg4U1BGekVlMGlIc3dkS1l5SDRxWnNBWkIwekxrWDdyTWVoWUtHVW8walN6?=
 =?utf-8?B?MTdaenNML2RINlppL3B3WXRnZEFIQTArMkR3UUlheG43RTdVMytLcEVERVEy?=
 =?utf-8?Q?jLDQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66defa89-dbb2-4168-3f0e-08db887ff700
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 17:45:39.0886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zg+syEGLBIZl/L/OH9ImnN+jL9N8fnW3/HAbpRqSGEz8RseGS6EQYmY8M9q6ealx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-07-10 16:17, Alex Deucher wrote:
> On Mon, Jul 10, 2023 at 3:27 PM Bhawanpreet Lakha
> <Bhawanpreet.Lakha@amd.com> wrote:
>> This patch set introduces Freesync Panel Replay capability on DCN 3.1.4
>> and newer. Replay has been verified to be working with these patches (in
>> house)
>>
>> These patches are enabling panel replay in static screen use-cases.
>> Other use cases will be added as they are ready
>>
>>
>> The importance of Replay
>> ************************
>>
>> In some instances, the GPU is transmitting repeated frames to the sink
>> without any updates or changes in the content. These repeat transmission
>> are wasteful, resulting in power draw in different aspects of the system
>>
>> 1. DCN is fetching the frame of data from DF/UMC/DRAM. This memory traffic
>> prevents power down of parts of this HW path.
>>
>> 2. GPU is transmitting pixel data to the display through the main link of
>> the DisplayPort interface. This prevents power down of both the Source
>> transmitter (TX) and the Sink receiver (RX)
>>
>>
>>
>> How it improves on PSR
>> ************************
>>
>> The concepts of utilizing replay is similar to PSR, but there is a benefit of:
>>          Source and Sink remaining synchronized which allows for
>>                  - lower latency when switching from replay to live frames
>>                  - enable the possibility of more use cases
>>                  - easy control of the sink's refresh rate during replay
>>
>> Due to Source and Sink remaining timing synchronized, Replay can be activated
>> in more UI scenarios.
>>
>>
>> V2: Bug fixes, V1 had some issues which have all been fixed.
>>          - Invisible Cursor
>>          - Random Hang
>>          - Laggy System
>>
> Are there minimum DMCUB firmware versions required for this?  If so,
> we should check before enabling this.
>
> Alex
There should be one theoretically, but since we only enable this on 
DCN3.2.1+ the FW version shouldn't matter, unless there was some 
specific bug fix done.
>> Regards,
>> Bhawan
>>
>> Bhawanpreet Lakha (10):
>>    drm/amd/display: Add structs for Freesync Panel Replay
>>    drm/amd/display: Add Functions to enable Freesync Panel Replay
>>    drm/amd/display: Add Freesync Panel DM code
>>    drm/amd/display: Read replay data from sink
>>    drm/amd/display: Get replay info from VSDB
>>    drm/amd/display: Add Replay supported/enabled checks
>>    drm/amd/display: Update replay for clk_mgr optimizations
>>    drm/amd/display: Update adaptive sync infopackets for replay
>>    drm/amd/display: Handle Replay related hpd irq
>>    drm/amd/display: Enable Replay for static screen use cases
>>
>>   .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  71 ++-
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  14 +
>>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   9 +-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 183 ++++++++
>>   .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |  46 ++
>>   .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 +
>>   drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +
>>   .../drm/amd/display/dc/core/dc_link_exports.c |   5 +
>>   drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
>>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   3 +
>>   drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  29 ++
>>   drivers/gpu/drm/amd/display/dc/dc_types.h     |  41 ++
>>   drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
>>   .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 303 +++++++++++++
>>   .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  58 +++
>>   .../display/dc/dce110/dce110_hw_sequencer.c   |   6 +
>>   .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
>>   .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 +
>>   .../amd/display/dc/dcn302/dcn302_resource.c   |   1 +
>>   .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
>>   .../drm/amd/display/dc/dcn31/dcn31_resource.c |  13 +
>>   .../amd/display/dc/dcn314/dcn314_resource.c   |  14 +
>>   .../amd/display/dc/dcn315/dcn315_resource.c   |   1 +
>>   .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
>>   .../gpu/drm/amd/display/dc/inc/core_types.h   |  19 +
>>   drivers/gpu/drm/amd/display/dc/inc/link.h     |  14 +
>>   .../drm/amd/display/dc/link/link_factory.c    |   7 +
>>   .../dc/link/protocols/link_dp_capability.c    |  10 +
>>   .../dc/link/protocols/link_dp_irq_handler.c   |  66 +++
>>   .../link/protocols/link_edp_panel_control.c   | 165 +++++++
>>   .../link/protocols/link_edp_panel_control.h   |   8 +
>>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 412 ++++++++++++++++++
>>   .../gpu/drm/amd/display/include/dpcd_defs.h   |   5 +-
>>   .../display/modules/info_packet/info_packet.c |   4 +
>>   .../amd/display/modules/power/power_helpers.c |   5 +
>>   .../amd/display/modules/power/power_helpers.h |   2 +
>>   drivers/gpu/drm/amd/include/amd_shared.h      |   2 +
>>   38 files changed, 1533 insertions(+), 6 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
>>   create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
>>   create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
>>   create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
>>
>> --
>> 2.25.1
>>
