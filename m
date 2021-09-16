Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A26BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 15:52:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA663611C4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 15:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA663611C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770566EE1F;
	Thu, 16 Sep 2021 15:52:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC316EE1F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 15:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VktooHn+YbxHV/tzE6JvQvAxzk+f5j9oi/vbQ4RijdW8838eu4q0mSlfu+WF4IKvopCraF4tfADURZ+215KzgUBqpdbM7MAcrbrqE4Z1PoDIJrn3SzaqbjIV75vhcnsGBzFBrmLv17acVvvZCcKA3X/15O9ydNkr2h1saNlj+Rb5Pu1IMT6yDmYlWYaKX840CJspWzn69HfT0lJCDccpRxjmiZIE1olrDXtZ0WAQJKfrcRYIg23h+BJfnqmSfNG7gpMzMoxIOZS8qA0puPPuOIPGJ9dPzbJ6lLXVxfAzJywhvixB8g+MKizsaHW0RUiXNYGxPHBYyg2PUp+u3DyOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=r4133LD56ZaiiCmf4bwJVpQ9gnh63H/k2hE2HhUdRlE=;
 b=GjJE2IB3irUevkDOhELhZEfjSwN6MwYLV5Z6nBnbDssPnjQLvAyTlmDEutwRytPEEAJO2kSD5U/8dayEo3CNqoiTKUV729ylZ9n/Wpz4JMzZNgvc0ciggbvP6TMzlS0pXAKMVmdQdftDwryc9BZy6krpMDQ8fHmicS89YbwFuNnHgZUJAAvMkdTIhQNB+zGYiDUhp/SDKUdIFEc1qmuCKvtnqz7RZfFI1l9/+kqFbvY7MyO/TNx3ke6EqtEXqIYqPPGSIRvPQN3WUW3fukx0/uXlFdF8TQ0BGoxZKpkRPpHaaJIRVXsVbxKglYzwPDVsnwmteVRLsf+AxxrM/Kwu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4133LD56ZaiiCmf4bwJVpQ9gnh63H/k2hE2HhUdRlE=;
 b=Jvx+3/AxrhJD5HtWxRhKjPJTaF9VnT/5UmP50OWHbya/dmdLDFpAT/Y8PhDZ1V8vlNdWt12Uv/4WXH0g5yCe7PUS+nLPspPevg2H34zaEAdanzS0HBlOfksviesV2S+ZMYPhZIWJvcAt8Eb43xWyp/F+ozzRNDi4SG+LUC/f2l0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 15:52:04 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1%9]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 15:52:04 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix crash on device remove/driver unload
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: evan.quan@amd.com, xinhui.pan@amd.com, alexander.deucher@amd.com
References: <20210915194153.455140-1-andrey.grodzovsky@amd.com>
 <e5f543f5-f2c3-294a-59f1-4c5ca99233ee@amd.com>
 <a0c98e67-9690-cfb2-35ef-806561d6bf44@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <8269157a-fc6e-37ef-63e4-9b2de79a6b05@amd.com>
Date: Thu, 16 Sep 2021 21:21:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <a0c98e67-9690-cfb2-35ef-806561d6bf44@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::15) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
Received: from [192.168.1.9] (103.160.194.48) by
 PN2PR01CA0160.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 15:52:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1705d4b4-ff8b-4170-86dc-08d97929edce
X-MS-TrafficTypeDiagnostic: CH0PR12MB5330:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB53306597D0C016E0BFAE9E6797DC9@CH0PR12MB5330.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/aEA/E0cf2D8jThzsxr9eQTfv/e3koSQroKMHvHufadomkpOVNKA0vsWJoruRtRMl+SCMK9oPtJUdKM146Q7OGIkxb/VHwygCESUpLZ2kRJDLKFpF5kwC4rKAsfQgI/CTIEJO0UPjLJ9NWlok2J8yk7F7t9kUkS+5ZXiSyt2yvrO7zrHp7wzg0YlMyQZGNyfJ7Dq7PQIg9VwmHRe6FU7Og+Kk2omq99EsfHJJ1C8vnW7bCHojFAGIICj6/QkThBpN2vgm1sblBkVbdQPzxeTQhOyJxGYxwmCBH2yGiUJYDoiOVppRTLoKmZCr5oEG8M0o7VPUNQC4kHvaBollFr4Wivhbf0CtVQphCemfv/mOetcLH8nbs1g3yRr7/l6qxYZX2uugiGYI8w/13LI6xF2rVN/mI0eLhhltFTL6LcjOODY0k9bmyOp3ImuXFeGVeogucwXOHJxPCZsGEPj5oKv9vr8kH5Xo5TVwxva7+UC3y1VXXnwuY62wKynE3PB81+qmo76y9rS2OcPdVSzAeCeoTydfgeEXE8rTRLYItIo8MTuFnfCa1shu83/y4mfc7d5VO8JUvclDFIOMNVvKRZPRakRbQT18DEXxhgCUcZDIfQr6pz4c73gEJjWVQy4Sq8kz9aEVFwlF69yvhDZQ5eCqWPBfRoyNIgwlF9naaeWBdKC49CzOg9DdHlee3cxUoWhELj99t6bp8S+/FWfmSyUFXePV7BeHgGoi3e2ekksWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(8936002)(316002)(66476007)(16576012)(478600001)(53546011)(36756003)(66946007)(86362001)(8676002)(31696002)(66556008)(956004)(4326008)(2616005)(6666004)(38100700002)(83380400001)(31686004)(186003)(5660300002)(26005)(6486002)(2906002)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGIyNnp2eVNWMDNJWTRSZkNQbURlL3ZRd2RCa1FkT3lQd2JpNXdpS0lHR09k?=
 =?utf-8?B?UXFNQytlRm44WUJ5ZFQ3ZDlWdXhZZy83b2hHOGFSejkwUGsrVnJXVG1NUDRX?=
 =?utf-8?B?UWx2R1VubGFtd2k1TytXVDF3ZURBdktXQVZ6MFJpZVA0V3kxTjY1WnpKSWo1?=
 =?utf-8?B?M04xTWgyRmN0eWExMXc4Nncwc2pwRFN2VFZReVExOHRWM2N5bExiYXJDMkFM?=
 =?utf-8?B?NklJcW1UYUdTVW9NdUltSFZoRWoxN3B3WnczaE9Ya3JCbnpFNFdKR2ttUk5y?=
 =?utf-8?B?d0tjc2VRa2kxSmZFQnBCYmxyU1lNdTVLNjNzT0taUytodWE4ZnNuNDBWa1Q4?=
 =?utf-8?B?UVQzUlNDdkRFNzhrd29DWTROZjFlQ0RkbXhEZGxDUFpLbmplL0dJUFVKcERE?=
 =?utf-8?B?Yk8rUmxiclpGWWk4bWVpNGdPV0s2WWhPZiswa095WjVRb3NYSUlvQ3loVUI1?=
 =?utf-8?B?M3k2WGRWT3F1b2Q2eUxmTENsZkttczRVYVNoK3ZWYnJTMXhHOTY0eDFWZzl4?=
 =?utf-8?B?M0RXZUdPaytLTk9ZdEJLc2h1Q0swMHllaEd4TnNzS3pDWkRlczZIcHZnaFNw?=
 =?utf-8?B?dndxbmFlaWMvendFOW9QQkc1ZXgxN1BzYlNYUEp0Rk9LKzZxU2YwVm9GS2Vq?=
 =?utf-8?B?eGNjbGlrYUxkaElZWnlZemh1S1plMmFvWVlraVZ4dUp1a0g2cjRpSTRIc05y?=
 =?utf-8?B?bWpEc0I1YVdtdmN6SVVLbDJUWGZ6WnFtSnBqdmV3Q2MxWktSTEJqL3dMdE4z?=
 =?utf-8?B?Tm53b0ZDMUoyMmhuRkcyQWVkSEE3VlVsRnViRkJmUXBxL1lMQU9NaWYrWElH?=
 =?utf-8?B?TXNNVk5EWWp5RzlNQUdmTktVYmxZNDlNUzF4NzZOWXFsWXNrRk5lU2VrdFNr?=
 =?utf-8?B?TjN1SmJwRkU4WEdGMXZOOEpZVTlpN2dmbkdwcTV6aldYQWNqcEwyWmxYWWh4?=
 =?utf-8?B?bmRuQXRpY0g3a3NvSDkzV1ZEalNFYkY0VitUdmg0Q0NZdlM0MTlUT1ZyUXp5?=
 =?utf-8?B?a0lqSVY1SEU4eUMzQi92WTlxSFdBNy9ZU0FOdjRRd01NVkpxNWlxZ2dDRTcz?=
 =?utf-8?B?dFR1dnJzdjF0NC90N1BHQkJLYVlnVThYU2xTaWhDeUJNUkt0ZDBRVVZSWEQ5?=
 =?utf-8?B?SXhnSVoxd3pYVmlVWHhBTFNqeWNuZ0FMNDd2RjFudjM1L0ZXS2xaS3Y1MXlB?=
 =?utf-8?B?ay9SM2xKVXIzNFcrVUtzT0crdXBsY0lmMzJxV3l0d1hDL1p2NGFmc0pTbEc4?=
 =?utf-8?B?dlRNWHJNYm1rZGszQUVJbEpqVmErYVdlMi9PSGtVaVEvT1BCMEd4UFNTVG9F?=
 =?utf-8?B?c0lzUXZjZm5rWGFwS1VpdEF3clRMWjZnZkdXN0xJLzR0ZnQ4SFNEa3R2eUw1?=
 =?utf-8?B?eCtLMnh1bWJUcWwyK29QK1MwYkowQUt3Umc5WUo4Mm1nVm1qczJ1ZGltcXMx?=
 =?utf-8?B?aXkxOTVTL0lFM0E2U252d04zK3FubndZb2xpT3k2clhic3NnOTB2Q01zaE9Z?=
 =?utf-8?B?MTdFU1BXMk9XcFNnRklzd1RxN2Q3dTVCdzBiQTRsTjJTL25vZERuSWJLc3Qz?=
 =?utf-8?B?TnpUd1VrdTlmZmd0NDJNS3pUT2JKekd3ckFHcWhlQTU5cEVISHRVM2t2RlQ1?=
 =?utf-8?B?RW5JSEZTMzZKaXV0SjQwNElDblNTZlRHSVp3R0JBZ3lIMGk4ekpUajhRUFI5?=
 =?utf-8?B?b0ZFYzhqNFFJYW5XdkxWMjlFTWhTKzR2VENpVGxXQWlkWTEwaVpCNzgxUDgz?=
 =?utf-8?Q?ojBHGeKxCavoR2mqSmpf5iYJQumxPQodURl6x4r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1705d4b4-ff8b-4170-86dc-08d97929edce
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 15:52:04.1813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +y/I9f+s2ucd5XbPEn0hjHcMkfuVeJpNcfV5VgAl3FUj2tePr5yAmpV/ex9YeuWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
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



On 9/16/2021 9:15 PM, Andrey Grodzovsky wrote:
> 
> On 2021-09-16 4:20 a.m., Lazar, Lijo wrote:
>> A minor comment below.
>>
>> On 9/16/2021 1:11 AM, Andrey Grodzovsky wrote:
>>> Crash:
>>> BUG: unable to handle page fault for address: 00000000000010e1
>>> RIP: 0010:vega10_power_gate_vce+0x26/0x50 [amdgpu]
>>> Call Trace:
>>> pp_set_powergating_by_smu+0x16a/0x2b0 [amdgpu]
>>> amdgpu_dpm_set_powergating_by_smu+0x92/0xf0 [amdgpu]
>>> amdgpu_dpm_enable_vce+0x2e/0xc0 [amdgpu]
>>> vce_v4_0_hw_fini+0x95/0xa0 [amdgpu]
>>> amdgpu_device_fini_hw+0x232/0x30d [amdgpu]
>>> amdgpu_driver_unload_kms+0x5c/0x80 [amdgpu]
>>> amdgpu_pci_remove+0x27/0x40 [amdgpu]
>>> pci_device_remove+0x3e/0xb0
>>> device_release_driver_internal+0x103/0x1d0
>>> device_release_driver+0x12/0x20
>>> pci_stop_bus_device+0x79/0xa0
>>> pci_stop_and_remove_bus_device_locked+0x1b/0x30
>>> remove_store+0x7b/0x90
>>> dev_attr_store+0x17/0x30
>>> sysfs_kf_write+0x4b/0x60
>>> kernfs_fop_write_iter+0x151/0x1e0
>>>
>>> Why:
>>> VCE/UVD had dependency on SMC block for their suspend but
>>> SMC block is the first to do HW fini due to some constraints
>>>
>>> How:
>>> Since the original patch was dealing with suspend issues
>>> move the SMC block dependency back into suspend hooks as
>>> was done in V1 of the original patches.
>>> Keep flushing idle work both in suspend and HW fini seuqnces
>>> since it's essential in both cases.
>>>
>>> Fixes:
>>> 2178d3c189b9 drm/amdgpu: add missing cleanups for more ASICs on 
>>> UVD/VCE suspend
>>> ee6679aaa61c drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE 
>>> on suspend
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 24 ++++++++-------
>>>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 24 ++++++++-------
>>>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 24 ++++++++-------
>>>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 32 ++++++++++---------
>>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 19 +++++++-----
>>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 28 +++++++++--------
>>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 44 ++++++++++++++-------------
>>>   7 files changed, 105 insertions(+), 90 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c 
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>> index 7232241e3bfb..0fef925b6602 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
>>> @@ -698,6 +698,19 @@ static int uvd_v3_1_hw_fini(void *handle)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>   +    cancel_delayed_work_sync(&adev->uvd.idle_work);
>>> +
>>> +    if (RREG32(mmUVD_STATUS) != 0)
>>> +        uvd_v3_1_stop(adev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int uvd_v3_1_suspend(void *handle)
>>> +{
>>> +    int r;
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +
>>>       /*
>>>        * Proper cleanups before halting the HW engine:
>>>        *   - cancel the delayed idle work
>>> @@ -722,17 +735,6 @@ static int uvd_v3_1_hw_fini(void *handle)
>>>                                  AMD_CG_STATE_GATE);
>>>       }
>>>   -    if (RREG32(mmUVD_STATUS) != 0)
>>> -        uvd_v3_1_stop(adev);
>>> -
>>> -    return 0;
>>> -}
>>> -
>>> -static int uvd_v3_1_suspend(void *handle)
>>> -{
>>> -    int r;
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>>       r = uvd_v3_1_hw_fini(adev);
>>
>> "cosmetic change" comment - hw_fini is supposed to be the final tear 
>> down call. So instead of suspend calling hw_fini, perhaps it makes 
>> sense to read the other way - hw_fini just suspends the hardware?
>>
>> Thanks,
>> Lijo
> 
> 
> Not sure what you mean ?

Now it is - suspend()-> calls hw_fini()

What I meant is hw_fini() -> calls suspend() and that is read as "to do 
hw_fini() only suspend the hardware and nothing extra is needed".

In short implementation stays in suspend() and hw_fini() calls suspend().

Thanks,
Lijo

> 
> Andrey
> 
> 
>>
>>>       if (r)
>>>           return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c 
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> index 52d6de969f46..c108b8381795 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
>>> @@ -212,6 +212,19 @@ static int uvd_v4_2_hw_fini(void *handle)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>   +    cancel_delayed_work_sync(&adev->uvd.idle_work);
>>> +
>>> +    if (RREG32(mmUVD_STATUS) != 0)
>>> +        uvd_v4_2_stop(adev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int uvd_v4_2_suspend(void *handle)
>>> +{
>>> +    int r;
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +
>>>       /*
>>>        * Proper cleanups before halting the HW engine:
>>>        *   - cancel the delayed idle work
>>> @@ -236,17 +249,6 @@ static int uvd_v4_2_hw_fini(void *handle)
>>>                                  AMD_CG_STATE_GATE);
>>>       }
>>>   -    if (RREG32(mmUVD_STATUS) != 0)
>>> -        uvd_v4_2_stop(adev);
>>> -
>>> -    return 0;
>>> -}
>>> -
>>> -static int uvd_v4_2_suspend(void *handle)
>>> -{
>>> -    int r;
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>>       r = uvd_v4_2_hw_fini(adev);
>>>       if (r)
>>>           return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>> index db6d06758e4d..563493d1f830 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
>>> @@ -210,6 +210,19 @@ static int uvd_v5_0_hw_fini(void *handle)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>   +    cancel_delayed_work_sync(&adev->uvd.idle_work);
>>> +
>>> +    if (RREG32(mmUVD_STATUS) != 0)
>>> +        uvd_v5_0_stop(adev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int uvd_v5_0_suspend(void *handle)
>>> +{
>>> +    int r;
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +
>>>       /*
>>>        * Proper cleanups before halting the HW engine:
>>>        *   - cancel the delayed idle work
>>> @@ -234,17 +247,6 @@ static int uvd_v5_0_hw_fini(void *handle)
>>>                                  AMD_CG_STATE_GATE);
>>>       }
>>>   -    if (RREG32(mmUVD_STATUS) != 0)
>>> -        uvd_v5_0_stop(adev);
>>> -
>>> -    return 0;
>>> -}
>>> -
>>> -static int uvd_v5_0_suspend(void *handle)
>>> -{
>>> -    int r;
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>>       r = uvd_v5_0_hw_fini(adev);
>>>       if (r)
>>>           return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>> index b6e82d75561f..1fd9ca21a091 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
>>> @@ -606,6 +606,23 @@ static int uvd_v7_0_hw_fini(void *handle)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>   +    cancel_delayed_work_sync(&adev->uvd.idle_work);
>>> +
>>> +    if (!amdgpu_sriov_vf(adev))
>>> +        uvd_v7_0_stop(adev);
>>> +    else {
>>> +        /* full access mode, so don't touch any UVD register */
>>> +        DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int uvd_v7_0_suspend(void *handle)
>>> +{
>>> +    int r;
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +
>>>       /*
>>>        * Proper cleanups before halting the HW engine:
>>>        *   - cancel the delayed idle work
>>> @@ -630,21 +647,6 @@ static int uvd_v7_0_hw_fini(void *handle)
>>>                                  AMD_CG_STATE_GATE);
>>>       }
>>>   -    if (!amdgpu_sriov_vf(adev))
>>> -        uvd_v7_0_stop(adev);
>>> -    else {
>>> -        /* full access mode, so don't touch any UVD register */
>>> -        DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
>>> -    }
>>> -
>>> -    return 0;
>>> -}
>>> -
>>> -static int uvd_v7_0_suspend(void *handle)
>>> -{
>>> -    int r;
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>>       r = uvd_v7_0_hw_fini(adev);
>>>       if (r)
>>>           return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> index 84e488f189f5..67eb01fef789 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>>> @@ -481,6 +481,17 @@ static int vce_v2_0_hw_fini(void *handle)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>   +    cancel_delayed_work_sync(&adev->vce.idle_work);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int vce_v2_0_suspend(void *handle)
>>> +{
>>> +    int r;
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +
>>> +
>>>       /*
>>>        * Proper cleanups before halting the HW engine:
>>>        *   - cancel the delayed idle work
>>> @@ -504,14 +515,6 @@ static int vce_v2_0_hw_fini(void *handle)
>>>                                  AMD_CG_STATE_GATE);
>>>       }
>>>   -    return 0;
>>> -}
>>> -
>>> -static int vce_v2_0_suspend(void *handle)
>>> -{
>>> -    int r;
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>>       r = vce_v2_0_hw_fini(adev);
>>>       if (r)
>>>           return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> index 2a18c1e089fd..142e291983b4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>>> @@ -492,6 +492,21 @@ static int vce_v3_0_hw_fini(void *handle)
>>>       int r;
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>   +    cancel_delayed_work_sync(&adev->vce.idle_work);
>>> +
>>> +    r = vce_v3_0_wait_for_idle(handle);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    vce_v3_0_stop(adev);
>>> +    return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
>>> +}
>>> +
>>> +static int vce_v3_0_suspend(void *handle)
>>> +{
>>> +    int r;
>>> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +
>>>       /*
>>>        * Proper cleanups before halting the HW engine:
>>>        *   - cancel the delayed idle work
>>> @@ -515,19 +530,6 @@ static int vce_v3_0_hw_fini(void *handle)
>>>                                  AMD_CG_STATE_GATE);
>>>       }
>>>   -    r = vce_v3_0_wait_for_idle(handle);
>>> -    if (r)
>>> -        return r;
>>> -
>>> -    vce_v3_0_stop(adev);
>>> -    return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
>>> -}
>>> -
>>> -static int vce_v3_0_suspend(void *handle)
>>> -{
>>> -    int r;
>>> -    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>>       r = vce_v3_0_hw_fini(adev);
>>>       if (r)
>>>           return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> index 044cf9d74b85..226b79254db8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>>> @@ -544,29 +544,8 @@ static int vce_v4_0_hw_fini(void *handle)
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>   -    /*
>>> -     * Proper cleanups before halting the HW engine:
>>> -     *   - cancel the delayed idle work
>>> -     *   - enable powergating
>>> -     *   - enable clockgating
>>> -     *   - disable dpm
>>> -     *
>>> -     * TODO: to align with the VCN implementation, move the
>>> -     * jobs for clockgating/powergating/dpm setting to
>>> -     * ->set_powergating_state().
>>> -     */
>>>       cancel_delayed_work_sync(&adev->vce.idle_work);
>>>   -    if (adev->pm.dpm_enabled) {
>>> -        amdgpu_dpm_enable_vce(adev, false);
>>> -    } else {
>>> -        amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>> -        amdgpu_device_ip_set_powergating_state(adev, 
>>> AMD_IP_BLOCK_TYPE_VCE,
>>> -                               AMD_PG_STATE_GATE);
>>> -        amdgpu_device_ip_set_clockgating_state(adev, 
>>> AMD_IP_BLOCK_TYPE_VCE,
>>> -                               AMD_CG_STATE_GATE);
>>> -    }
>>> -
>>>       if (!amdgpu_sriov_vf(adev)) {
>>>           /* vce_v4_0_wait_for_idle(handle); */
>>>           vce_v4_0_stop(adev);
>>> @@ -596,6 +575,29 @@ static int vce_v4_0_suspend(void *handle)
>>>           drm_dev_exit(idx);
>>>       }
>>>   +    /*
>>> +     * Proper cleanups before halting the HW engine:
>>> +     *   - cancel the delayed idle work
>>> +     *   - enable powergating
>>> +     *   - enable clockgating
>>> +     *   - disable dpm
>>> +     *
>>> +     * TODO: to align with the VCN implementation, move the
>>> +     * jobs for clockgating/powergating/dpm setting to
>>> +     * ->set_powergating_state().
>>> +     */
>>> +    cancel_delayed_work_sync(&adev->vce.idle_work);
>>> +
>>> +    if (adev->pm.dpm_enabled) {
>>> +        amdgpu_dpm_enable_vce(adev, false);
>>> +    } else {
>>> +        amdgpu_asic_set_vce_clocks(adev, 0, 0);
>>> +        amdgpu_device_ip_set_powergating_state(adev, 
>>> AMD_IP_BLOCK_TYPE_VCE,
>>> +                               AMD_PG_STATE_GATE);
>>> +        amdgpu_device_ip_set_clockgating_state(adev, 
>>> AMD_IP_BLOCK_TYPE_VCE,
>>> +                               AMD_CG_STATE_GATE);
>>> +    }
>>> +
>>>       r = vce_v4_0_hw_fini(adev);
>>>       if (r)
>>>           return r;
>>>
