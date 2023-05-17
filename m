Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6868AC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 04:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0D310E39F;
	Wed, 17 May 2023 04:55:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A1510E39F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 04:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAyBxIM7djXFLdwTQnLvj4dr6WS0Pyt6zrKAn+oq1pmWvqBh43X4okISGEjD6FQTBwrdyNQ3AnwY5jJL8feREstlKPCIdxlsBmjzUsrCICj++LJzk/5szQk2imA5NDNpm7yCk20M64WhV0zkxRFvtDuochPZ89f9fyil7AR0G2s4JboPimB6A83fJZHopm7Z9lQOvPyy5JZM/kEJmc+idsAv5KthEtsu8HXqeM6Csr22vGt05VeJlnnjXtO41h6zVtF8OWvBmMNa+KLf0XV3TMYmg2/Uy1ewkgB9KvyEfi2wIBOsqN32vo6pDoqe+rSzUdq24LJR1juoDt6vItdFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9O4HHc8Kj3UWc0aJEoZmt4ZOfTFwx+tLgg1XLsZqlxA=;
 b=ob7ibjQPGn24Y5mj6a9KboXPsV3c9yCV23XCvgCUtU3qoxa7hczV2G7Q9nkmhcIsymNwRqfVhkZFJOnY6zIuj1TGcAN2gTD8ktXWkMHlXKhOl4ygLITCw6ugAzX+fQxfqi/k9eU4Bx9p1Xx19k1c0qVTK3tFBrNKWwkv7yo8G1QLzvBe3qqslsd+QEFevGk/MnWNGmypHTjS5s0YkH8nJu/mU0j/Hgr3OKd1iEYpdprOAGL8qJsSRWCccb3eiKBJw97PymsxJbxURklZGl5BonJRJiuwzsiNu3QFsVXr/MXU3C1F7IzVGuooyM9QMS/Oi8Xmgs1UdFWiO0sqQTL41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9O4HHc8Kj3UWc0aJEoZmt4ZOfTFwx+tLgg1XLsZqlxA=;
 b=IbBXd+DIvfkKpq2sfojL2cUu9B8x7YesLx00IcnTCCgScXJ+p6jX/ePopqi12dNXatBX+uXfxFHcpdafC12jT2qhClfa8rejR4oJW3wd+ryyCk4uiHDYUeezA/ruJlrGEcSbXkOr6xw7JnyrvHUW2BXQqA2kVuRleDSnerM5fFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 04:55:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 04:55:29 +0000
Content-Type: multipart/alternative;
 boundary="------------0CH8zhIx4zdq5QNRXkTvhO74"
Message-ID: <55fbad92-010a-f7bd-6a90-ac105acb38eb@amd.com>
Date: Tue, 16 May 2023 23:55:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 0/3] Fix DCN 3.1.4 hangs on s2idle entry
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230516233420.2087-1-mario.limonciello@amd.com>
 <89d0c8be-d118-1b02-0406-835557d712b1@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <89d0c8be-d118-1b02-0406-835557d712b1@amd.com>
X-ClientProxiedBy: BN9PR03CA0635.namprd03.prod.outlook.com
 (2603:10b6:408:13b::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: a3549fc0-7ec9-4348-cc6b-08db5692ef94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BrY2ZPGTn9h8lpcVreK4q4FoNocVIsXkYJJGYgSh/fLF1MGC4jZuA5Su3Bw/+YoNnh7SaEgjyvw7OJcfVh9/8hFyXxOaHmNHNvoWd7ICgwMsb/4JjdBZXUaU7wrbqI0toaQnV+/yHrjXnjmTdQoHtzJAkwkTbcYNqAgTdIcT2aMBHPtEqL+bn0IzfVLYlFzvnmgH6lc0KBEXcQBoYonrV0QoUpmefOhgPzz8/44qG5d9WF938d/dOHWz5wb4bZlbw0Zg5jgQnf1B+K3lOK6IoxkugKh0IeVYCgOjld9UbFDcsSn46T1Iw0nH9XxSocPKVINRGMX2MQvHQnnnxm3cHk+AWZedf/eKV86GoOZrgkeu0sA61Y3MDNF1XE5Y9k82vfKArdaRZR5Ya8QXQ739TkyWNQewCtlk6CIUWYnmn/feXVwQo5HePeTos6n37vzlmcAVkb0BXTz0hnQbt32IRX3v2S8R9r3qOh3FPz2WQfE/hQBtbKT+nWY/duOpRcnRv6QUOzSW8GS67t1hAc81zj46/NrWtdOmWll1gn/eyoGSh5G03mTXTcDJqrbMfOtvMMWX7qtDBGHX0H7xPEteBcTuVLwbk5w2jDX4BwrQmfKNu9SmXU2YD9wnrWlXyVGcq7gHew4Mc8nGhw72Yklqwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199021)(83380400001)(66476007)(33964004)(2616005)(66946007)(26005)(6486002)(478600001)(66556008)(110136005)(6666004)(186003)(5660300002)(8676002)(2906002)(31696002)(8936002)(6512007)(36756003)(41300700001)(4326008)(316002)(53546011)(6506007)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhOU3hVcFU4SU1jSEFEODM5SHU3QU51TEI3MDMzeXBXRENCQTdQWDNpTDRI?=
 =?utf-8?B?SjBVRHJ3dEgyOFFrdnlDZW1tYjZ2cFFtWTNYcGNGc0VDOTZFSld2OFptY1FQ?=
 =?utf-8?B?OHNMNnNiOGl2UTJuQ0QxVWZ1elNBTlRqU2Zzbjg5QUwzTGVELzhCZ2tabTZz?=
 =?utf-8?B?eWsxU3REQ0E3bXV1eG1MQjV4OGNqSzVXNGVWVVl3TkdnVEtyamlrbzBya0RY?=
 =?utf-8?B?bWJTbkkrY3R4NFlQRkYyaHJxTWF2MUhscFQ0Tlp5RGxyOEI3WVNRamp0RXRH?=
 =?utf-8?B?NEJUSnJHeDRZRGtxYVdEd2oyalBJVWt2aDVhYWx4SXdyQmt0N3JwZUVhL2tk?=
 =?utf-8?B?SWJreVFtVWhkWDZ4TVliQVY3VU9CRVZaQnR5emlIRUxOUGFxUXBEV3RrN1FN?=
 =?utf-8?B?VzBzRG16aXpmcmZwSStOY3RLZTlmd2hmYW43YTVOKytRYU53MmlmR3ZtS2M0?=
 =?utf-8?B?MTFFZlJJNlFKUmx2a0xDcjhTNTEwRWlQcmwzRzFBOUVodnlIbmFGSFg3UTBs?=
 =?utf-8?B?QUhKNHhRdTkyNjV3bzR3clVJOVdzdnU0UEJCanVXVVc5UENTVDVVOEt4bU82?=
 =?utf-8?B?azJrY21pQkljQ2dZQ05QcEFzNHA3bGY1SnlBL01mMDhVUDQ5TTlmcXpoWXlH?=
 =?utf-8?B?Z2Nhem5SQjZUYThZOE9zRmVFakxqQlNIV0FFRnhKckdsUnQrQ0xtQjhrRldh?=
 =?utf-8?B?cFVjWEZqVkd4OVBDejd0L01palRKc1JROUh6QWgrNU9SRGxWT3NMb052YVFr?=
 =?utf-8?B?eW5tM004dWEvN2ROVkFqQnp3OXd4MzhKcE1KN2RFTjhVNlZOOUc3di9CMjJx?=
 =?utf-8?B?bTVLMDdqTGltS0t5d056dmlyaXpGenBIVTkzZU9maUR3WmJ4RnRFZmdXT0JW?=
 =?utf-8?B?ZXVPRDZEK3kwRStEcVdSNXJqbWFDeUNFOXNUM1UvaGRNa05vZHl3S2hZQmNh?=
 =?utf-8?B?NXhmcnBpaFRQQnhkNnpxYVAreVhzRzVLOGRFUHFLYlRXcllKaHo5S2NnUGZj?=
 =?utf-8?B?bFMrek1Db0xSajZtNDc0a1Q3THdINGxxQXB0UXZRR1JmYmNuTGU1WHRJTGc5?=
 =?utf-8?B?TmVJMFNUTmdKSGo2d25sM3lDVFJzb01ZQ3Uyd1FlNzlETklSakprQmtXaHVi?=
 =?utf-8?B?Y2Q5YXNjR2pJTlFySnhzTElzR0FXUHJVZlVLcUFUaU8ya3E2cVVMcDE5dWUx?=
 =?utf-8?B?UnNCUEZqTnhkaTBaemRqdWpsZjlCRWZSTnpSOENLemY0WFZLWThKVE5iTEdx?=
 =?utf-8?B?M2ZOcDE2T0xwcWtBU2VtMFJvckl6Yi9yVnFBQjYwcHBUVEU0Qm83VTBvUDVj?=
 =?utf-8?B?WEczODlqOFU3VDJKcHQrUkJ2YmhpUlRwdHgvU3pkcmdHaFRWUDdhbEh2cTE0?=
 =?utf-8?B?MEtzU2JPbGU1eVBsMUpQRVlDV05vbnNSbjdDV0pTSGtqUDVscm5OVjNVQm1r?=
 =?utf-8?B?SHBmbzRKbzNVNEZmeFpoY2Nkc09WOHU5ZGhoNm1IZHlCdjhiOXpQQjFCUTBz?=
 =?utf-8?B?UUFhdGl0R0VZT1RmK1dhRis1QWhSUGdDNGgxMU15amdKUnR0NkdaMlRJTGps?=
 =?utf-8?B?UlpSVGJFaGZVS1FVRmI4TmRURFdQSmlRdGJMaGxvdGptVGMwWWJOMGNmdnNy?=
 =?utf-8?B?SUwyaVpQSHV2aE1Ob1RaRWVwalFqdjkxcmZTc00xOTRqTWFNdDBxd2paUmJM?=
 =?utf-8?B?dDZZcXdKQWlJamlscGFJbm9DYmVBaHdvWU5JaU9qTWVuTmVQT2U3UXRlS1Vl?=
 =?utf-8?B?bVg3NUoreFNaMmZtQUNueDBqVzBseEVtVzU4Mmp3SHkzbUdCOXlvMVpEam5k?=
 =?utf-8?B?L3ZRQmZubmFCdTFDTUI3RnhPaHo2VjcraS9PQXVSdXRaZW5GMGVsZEN6S2Ro?=
 =?utf-8?B?d2N6RUJXdzhQYW00WWF0RHRxWU9EVjltL2grTndvUkswMU9lYm1DM2NEamE0?=
 =?utf-8?B?TUdtN3prU2szbS9iUStVUVFTYjIwWURLK1VnTzd0eU15R1NZNmtYaGgvOVk5?=
 =?utf-8?B?VUZhWmIzcmZBb0NEaXBUWEl2c3dUZHZtYjdZanVtNFRXS2krV1NzYmYza203?=
 =?utf-8?B?NXhSdkVFZHV2WUhIYlZ5SXZnSXFkT2lnMUp2VXR5cWxTUXJqaExPa2V2U01X?=
 =?utf-8?Q?226BRWJ9MxzHDP12BTws1MPCV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3549fc0-7ec9-4348-cc6b-08db5692ef94
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:55:28.9720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N+ALLosdlnw+HWZjyL1K1+AH9jblfO3K99hq14rhgAzfpFq6m4xEsqRiE8exg9dGd2xLliYuTj4mZyb5GtnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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
Cc: anson.tsao@amd.com, Juan.Martinez@amd.com, richard.gong@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------0CH8zhIx4zdq5QNRXkTvhO74
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/16/2023 11:43 PM, Lazar, Lijo wrote:
>
>
> On 5/17/2023 5:04 AM, Mario Limonciello wrote:
>> DCN 3.1.4 s2idle entry will hang
>> occasionally on s2idle entry, but only if running Wayland and only
>> when using `systemctl suspend`, not `echo mem | tee /sys/power/state`.
>>
>> This happens because using `systemctl suspend` will cause the screen
>> to lock right before writing mem into /sys/power/state.
>>
>
> A couple of things on this since this mentions systemctl suspend -
>
> 1) If in s2idle, it's supposed to immediately signal and not schedule 
> delayed work
>
> 3964b0c2e843334858da99db881859faa4df241d drm/amdgpu: complete gfxoff 
> allow signal during suspend without delay

It looks like dead code to me now actually.

amdgpu_device_set_pg_state() skips GFX, so gfxoff control never gets 
called as part of suspend path.

>
> 2) RLC is never stopped on GFX 10 or greater.
>
System was hanging before this series.

Patch 3 "alone" matches this behavior as described above to skip RLC 
suspend but two problems happen:

1) GFXOFF workqueue doesn't get flushed and so driver's request for 
GFXOFF can happen at wrong time.

2) If suspend entry happens before GFXOFF is really asserted lots of 
errors on resume. IE:

[   63.095227] [drm] Fence fallback timer expired on ring sdma0
[   63.098360] [drm] ring gfx_32772.1.1 was added
[   63.099439] [drm] ring compute_32772.2.2 was added
[   63.100460] [drm] ring sdma_32772.3.3 was added
[   63.100504] [drm] ring gfx_32772.1.1 test pass
[   63.607166] [drm] Fence fallback timer expired on ring gfx_32772.1.1
[   63.607234] [drm] ring gfx_32772.1.1 ib test pass
[   63.608964] [drm] ring compute_32772.2.2 test pass
[   64.119173] [drm] Fence fallback timer expired on ring compute_32772.2.2
[   64.119219] [drm] ring compute_32772.2.2 ib test pass
[   64.121364] [drm] ring sdma_32772.3.3 test pass
[   64.631422] [drm] Fence fallback timer expired on ring sdma_32772.3.3
[   64.631465] [drm] ring sdma_32772.3.3 ib test pass
[   65.143184] [drm] Fence fallback timer expired on ring sdma0

> Wondering if the code hides something else because of the timing.
> Thanks,
> Lijo
>
>> This causes a delayed GFXOFF entry to be scheduled right before s2idle
>> entry.  If the workqueue doesn't get processed before the RLC is turned
>> off the system is hung. Even if the workqueue *does* get processed, 
>> there
>> is a race between the APU microcontrollers and driver for whether GFX
>> is actually powered off when RLC is turned off.
>>
>> To avoid this issue, flush the workqueue on s2idle entry and ensure that
>> GFX is really in GFXOFF before any sensitive register accesses occur.
>>
>> Mario Limonciello (3):
>>    drm/amd: Flush any delayed gfxoff on suspend entry
>>    drm/amd: Poll for GFX core to be off
>>    drm/amd: Skip RLC suspend for s0ix on PSP 13.0.4 and 13.0.11
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 18 ++++++++++++++++
>>   drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  4 ++--
>>   4 files changed, 46 insertions(+), 2 deletions(-)
>>
--------------0CH8zhIx4zdq5QNRXkTvhO74
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/16/2023 11:43 PM, Lazar, Lijo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:89d0c8be-d118-1b02-0406-835557d712b1@amd.com">
      <br>
      <br>
      On 5/17/2023 5:04 AM, Mario Limonciello wrote:
      <br>
      <blockquote type="cite">DCN 3.1.4 s2idle entry will hang
        <br>
        occasionally on s2idle entry, but only if running Wayland and
        only
        <br>
        when using `systemctl suspend`, not `echo mem | tee
        /sys/power/state`.
        <br>
        <br>
        This happens because using `systemctl suspend` will cause the
        screen
        <br>
        to lock right before writing mem into /sys/power/state.
        <br>
        <br>
      </blockquote>
      <br>
      A couple of things on this since this mentions systemctl suspend -
      <br>
      <br>
      1) If in s2idle, it's supposed to immediately signal and not
      schedule delayed work
      <br>
      <br>
      3964b0c2e843334858da99db881859faa4df241d drm/amdgpu: complete
      gfxoff allow signal during suspend without delay
      <br>
    </blockquote>
    <p>It looks like dead code to me now actually.</p>
    <p>amdgpu_device_set_pg_state() skips GFX, so gfxoff control never
      gets called as part of suspend path.<br>
    </p>
    <blockquote type="cite" cite="mid:89d0c8be-d118-1b02-0406-835557d712b1@amd.com">
      <br>
      2) RLC is never stopped on GFX 10 or greater.
      <br>
      <br>
    </blockquote>
    <p>System was hanging before this series.</p>
    <p>Patch 3 &quot;alone&quot; matches this behavior as described above to skip
      RLC suspend but two problems happen:</p>
    <p>1) GFXOFF workqueue doesn't get flushed and so driver's request
      for GFXOFF can happen at wrong time.</p>
    <p>2) If suspend entry happens before GFXOFF is really asserted lots
      of errors on resume. IE:<br>
    </p>
    <p><span><span class="ui-provider cfr cfs c d e f g h i j k l m n o
          p q r s t cft cfu w x y z ab ac ae af ag ah ai aj ak" dir="ltr">[&nbsp;&nbsp; 63.095227] [drm] Fence fallback timer expired on
          ring sdma0<br>
          [&nbsp;&nbsp; 63.098360] [drm] ring gfx_32772.1.1 was added<br>
          [&nbsp;&nbsp; 63.099439] [drm] ring compute_32772.2.2 was added<br>
          [&nbsp;&nbsp; 63.100460] [drm] ring sdma_32772.3.3 was added<br>
          [&nbsp;&nbsp; 63.100504] [drm] ring gfx_32772.1.1 test pass<br>
          [&nbsp;&nbsp; 63.607166] [drm] Fence fallback timer expired on ring
          gfx_32772.1.1<br>
          [&nbsp;&nbsp; 63.607234] [drm] ring gfx_32772.1.1 ib test pass<br>
          [&nbsp;&nbsp; 63.608964] [drm] ring compute_32772.2.2 test pass<br>
          [&nbsp;&nbsp; 64.119173] [drm] Fence fallback timer expired on ring
          compute_32772.2.2<br>
          [&nbsp;&nbsp; 64.119219] [drm] ring compute_32772.2.2 ib test pass<br>
          [&nbsp;&nbsp; 64.121364] [drm] ring sdma_32772.3.3 test pass<br>
          [&nbsp;&nbsp; 64.631422] [drm] Fence fallback timer expired on ring
          sdma_32772.3.3<br>
          [&nbsp;&nbsp; 64.631465] [drm] ring sdma_32772.3.3 ib test pass<br>
          [&nbsp;&nbsp; 65.143184] [drm] Fence fallback timer expired on ring
          sdma0</span></span></p>
    <blockquote type="cite" cite="mid:89d0c8be-d118-1b02-0406-835557d712b1@amd.com">Wondering
      if the code hides something else because of the timing.
      <br>
    </blockquote>
    <blockquote type="cite" cite="mid:89d0c8be-d118-1b02-0406-835557d712b1@amd.com">Thanks,
      <br>
      Lijo
      <br>
      <br>
      <blockquote type="cite">This causes a delayed GFXOFF entry to be
        scheduled right before s2idle
        <br>
        entry.&nbsp; If the workqueue doesn't get processed before the RLC is
        turned
        <br>
        off the system is hung. Even if the workqueue *does* get
        processed, there
        <br>
        is a race between the APU microcontrollers and driver for
        whether GFX
        <br>
        is actually powered off when RLC is turned off.
        <br>
        <br>
        To avoid this issue, flush the workqueue on s2idle entry and
        ensure that
        <br>
        GFX is really in GFXOFF before any sensitive register accesses
        occur.
        <br>
        <br>
        Mario Limonciello (3):
        <br>
        &nbsp;&nbsp; drm/amd: Flush any delayed gfxoff on suspend entry
        <br>
        &nbsp;&nbsp; drm/amd: Poll for GFX core to be off
        <br>
        &nbsp;&nbsp; drm/amd: Skip RLC suspend for s0ix on PSP 13.0.4 and 13.0.11
        <br>
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25
        ++++++++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 18
        ++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/include/amd_shared.h&nbsp;&nbsp; |&nbsp; 1 +
        <br>
        &nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp; |&nbsp; 4 ++--
        <br>
        &nbsp; 4 files changed, 46 insertions(+), 2 deletions(-)
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------0CH8zhIx4zdq5QNRXkTvhO74--
