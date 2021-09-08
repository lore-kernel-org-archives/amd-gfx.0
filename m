Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975ECC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 10:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF3A6113A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 10:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FF3A6113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4BF96E185;
	Wed,  8 Sep 2021 10:22:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CFE6E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 10:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3Dy/CtedosVMBMSyyNkYWeUIv8gaGN38FDF2K+0EV8VsVlpA6Z2f0cCZmRiAViJX6hMgCaMaEOEHyRQLYvpnQwrXFYvoGJYAD9/+nN8RCWthzoSoWWOfa2JpC6WFYoP61DayfK2htN+1eZIdIZ0e/3XFUAb+qNpnkLbF6r9lxwvXv6wLgzQnv/dEna4PCCQbXg6Gk/EWOlrE2+nLVxfAgdKQ3irgOl8FF/EmvxK8SsOqYGztuxoqUa3kIERQ1ywzj2Qa5YHgDi39u+HdLwIebea1Utw7aXyFYDk7fFltvbNC0uWzzPTzqTntpwtEF/lxb9h2jN/ujT4OPX0UIAh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=s9C2IOR0S5TvXvLr0p/ITtFXRXWmV1dYSjlRwFlB18I=;
 b=OnvBzxfK0KR9j5KJt+MUYT5+bKnsgxyW4dSCO6P0NVIuJyaPZSk4Sfrijn2RFQOSR4ezjsWrjUL1diWrJdhLsPzVpB5kroHN/K5fqPoG4UJl0aGoS09J4cIyNbcZ3aiRPWAL/yK9nyrW4XwuVCXKwPF6nj9QaXYeckfb1zdL9+vZBYV8P/qJgbDZeU6fHykvzbM68r3ZA3WLKeXD5Ed9oISvi6qWwAKJBgmCYLGct0g9/IYJVsJwg7BnbGZGFCpRoVFBFMnH8FrtAeCgiqmu2xVHfuehX9tW6Db6nkShMKPwkk09UMSvq1rYiwFRWDWCtXKZQXRhH6nnJYtecbQ5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9C2IOR0S5TvXvLr0p/ITtFXRXWmV1dYSjlRwFlB18I=;
 b=Y2Re20hwW+snzBjDOYTgTDJIKDKE5R4DBDJXOgCQyw201C/gr82zk38LO+eynzKqWUniKcBIxxfv5FahbyUVETJP7GPap8dck33tbrX6yfMQnY7kzFlxO9aJxnHxM8GauvXPHJSnZNjfGYoq5wKGWBdRy/0wMp58HKijMTn5lb4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 10:22:29 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.022; Wed, 8 Sep 2021
 10:22:29 +0000
Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, Tian Tao <tiantao6@hisilicon.com>,
 darren.powell@amd.com
References: <20210908055615.3781901-1-lang.yu@amd.com>
 <e8b39f62-ca0c-d4e0-92a9-52487fa0da81@gmail.com>
 <47ed143e-b9ab-a80e-dac0-cfa1ec39d033@amd.com>
 <DM6PR12MB425086A1FFE0D1609581DFBAFBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <39d2443b-c90e-b5c6-85ee-b44bbfd818d3@amd.com>
 <DM6PR12MB4250831801024A782408C280FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <332d81e6-a518-a155-cdfc-008e0bdb324c@amd.com>
 <5edd4df2-c49c-3b87-90d4-8d8b822641f9@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <1fa7224f-de58-6864-6cb2-16a7b8968f54@amd.com>
Date: Wed, 8 Sep 2021 15:52:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <5edd4df2-c49c-3b87-90d4-8d8b822641f9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::12) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN3PR01CA0108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 10:22:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a414273-abee-4eaf-4f53-08d972b28fe2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5098:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB50988C58E5C5CFEC1AD200D497D49@BN9PR12MB5098.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqlfBX77irE80nf3+SnQLCM2s4kOUR1uhfKKZWYWSzoDvRVInF0fbTz9l+6e0qRXX3o7NKAB8mnDpqhwXwXPXSh82UBbxnpv+wQ/bOcX3P5akM9eC3W1Ztn7yppj2xtKHwmB7YPdr6Nsfziiyaq5A9np95e5pNRton902eAbBMaiWIyJiSggndP0rFumxTw2ZElI3js9VbyguBPfUgvsE+RT2CiMcxjivOeCTC0vY92jyVMeFMTKMJXcdpEQ04XiMgHt+APJ6+/fPGke3oTe09H1k/rJYOivL4kIu98h6M4EW9mUACbcDfxFxjs1/pawWXJNW+i/WGAy2CGHSNZmry1051sOldDlsO6V7/d3KyfPvNdkARzw8gpZEoov1EVxsbLHXUQ0xq2/JO9z9DJ2SHkVXhthsb4EgBRPyLmEwT74ltqbM60ifb3V/y3uU09Df/qEa7BcrH5YO7EEQS9i9/UoykyvNw9bqOCrw1LlcHvsF/x70zonUuYvD5UqTi70w+JmcO9M1Hx2gDVx5IXkwsFawnkr0GWO/29Ic+59+qnrUQ3AmEg8YhONu+FIfmqJ6N2UJA+BYNnMa75FRietKeqGA1SqFAyXQdcXNkauBHCIFUGkbEpM53wj0FbHpNKTw0CAMfvm7oCirPB1hlUguBFC6RZxNX+XL6UcNr2uf+JbHkMKOtXBZmMg1iTfhQeZBjZOFZTjOc7XNV6Nbi0n5+awMFtWjSqYRtdJHRM7qC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(66476007)(5660300002)(6486002)(66556008)(66574015)(316002)(53546011)(110136005)(38100700002)(66946007)(31686004)(2906002)(16576012)(54906003)(478600001)(6666004)(8676002)(8936002)(26005)(4326008)(83380400001)(186003)(36756003)(956004)(31696002)(2616005)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFua1lINEw0Wnl0aWlwd3ZwNmZMdHJjM3hXanJUWGZUbldFTjB6eFhuNmF2?=
 =?utf-8?B?STA1NTBrcm9rdHJLYVhtTlRLTUlNb0dnRHdaZnR1QmszemwwWUtUZVIwNE1R?=
 =?utf-8?B?S01YTDJsdE9lWldUdVBpQmdHbW1WMi9oaGh6cHBEa3ExU1JJQ2pJVTZvRzJt?=
 =?utf-8?B?cnZsbEQzYndRWms2VWhFVEo1VVNHeVBZdDF5QUNRMGI0ZXphblc2ZjNlb1dX?=
 =?utf-8?B?R0YxKzBxd3hlQW1UNHBKaWd1OXJCMHpiaXM0VGVwVklRVHlzNTNEUEZKTnBO?=
 =?utf-8?B?VUxEZmVMZEVKbThjb2Rjd1JzTTN3d0QrNmFGd014WS81cHlhckVZcEowalo5?=
 =?utf-8?B?WGZtV01rRHFQUFRXNnlFRjlGQ1FnNWo5S0NGbnZDdG9XeEJpbjhQa2YvbCts?=
 =?utf-8?B?U2JSUWRpRi84QUpyejJIazBDM3dZSHQwbXYyTGYzNGVFdFUwUHZFRUIwYjFL?=
 =?utf-8?B?akpYOTNjQ2JxNXB1Y1hUcmV0T1NiWWpWdENqUnJsUzl4QnlDUXcxZzZReDhP?=
 =?utf-8?B?OFpsa0pMamJmdjNPaVFGNU1IdXk2UFUrNGl4amMyZnBncy9OVjk0TkJMcFNU?=
 =?utf-8?B?N3pmV01lVHhDT09GMDczNTlkZ2djZXR0aUgzRWZXS2tvVlpZUExLQk5JUzJS?=
 =?utf-8?B?OGpla1VwbDk4TVdUNUFMNlBhOFk0aHRrTmNvRmpNSXhraDZhcUVvdldsSHVQ?=
 =?utf-8?B?VmpvT2VhaUVnamFKQWRBRDFJWXZlVCsyYm1ydk5OYUdGK1hNMHJhU21qTnBp?=
 =?utf-8?B?U21OaTVQdXdRbTFaU0x1cUhMakhqS2VtVFVsUjVoeWZPREVnREk0a1VnZlVN?=
 =?utf-8?B?dkw2ZlVYcGRMeTZSNnVSZ08vaU1uVDA5Z28yYitibGM5eitsQWpwMk9UYzBP?=
 =?utf-8?B?VitQL0MrRVhuYUl0WFdFcEdhS3MrZzFEc1l5N2J6QjZxWk9aZ002ckk4aTdX?=
 =?utf-8?B?NGZzcDZFMDVLUGpBNWdKcXNaeGxYaUE3bmZnNWUxMlZaZ2xMR3Qxb3JUaWx0?=
 =?utf-8?B?UGQwT29rek4xTkhxcm1PYVhCQ2JCbk1pUURyNkszUVY1L3gxZ3NvRGhrNFRo?=
 =?utf-8?B?Rjl5YjdhbnFRbTU5elJJb3pMUlJLYU1VOXBNbG1EZmI1c1Nzc1pvbDRaVVEw?=
 =?utf-8?B?b0VlQ2N6LzhqdEtySmJOZEZ6Ti91bmx1eFA0UjNtS0hwcEhWZVVSNUNFQWMx?=
 =?utf-8?B?WmY3ZnlZWnBXajNRTlZCM2tZeWRnWSttT1FKdUM1NFl3eENLRVpkZ1A5ZnRR?=
 =?utf-8?B?RTJyb1MxOXh5bWJ5cDVrbnJCN3RWaXQxd1M1eHk3cUhFaFlsbFd4eG02UUFs?=
 =?utf-8?B?ZlpDYlJJVkFRRlF6SnU1cXI4SmZLQVV0bEErTklwV3dUNDdTb3BnZjAyL1lX?=
 =?utf-8?B?WUF0TzN0VE1vV3dYeFR5dFNDRDEyUXBlbXFMbjFmZTlMRFFPVDUvT0tuRG5v?=
 =?utf-8?B?TWZUZmwzZG8zaTlITm1QUTlUTlhZek5Zci9DT1Q5T2lJVDhNbWtyd2IzTmFx?=
 =?utf-8?B?dmRKYmMvTTY1UkIyUm45ckMzbFhvNzVZUXpUUDY2RUlPVVZYWWlmZ2wwNkdu?=
 =?utf-8?B?OUdPQVZRYk4yUnRzdXhZRzVVaDZaRjJVVXp3dzNLRTZOaVJ1R0d0YnBTM214?=
 =?utf-8?B?ZUs2K29ydjNrSFNScnd0U0owZzRYbk10ZFZ2aGtrTUNnY3dJWkNveTlFZ3My?=
 =?utf-8?B?NXFCR1lVVGVESTh5aW1obG54NTVTUEJNdW5CV1lhMFZLWjczWTF5QWUvN0xS?=
 =?utf-8?Q?jqPNKDB1HOnulzQalho5f/356x9zT14pFWFWIcr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a414273-abee-4eaf-4f53-08d972b28fe2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 10:22:29.7058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Yiqk3KZQ53OeW7nbGxi7AjdYe9oBGpmzhoAT5f7vMpdZdnsGOP87cNhlWIGhNqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098
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



On 9/8/2021 3:08 PM, Christian König wrote:
> Am 08.09.21 um 11:29 schrieb Lazar, Lijo:
>>
>>
>> On 9/8/2021 2:32 PM, Yu, Lang wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Wednesday, September 8, 2021 4:55 PM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; Christian König
>>>> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings
>>>>
>>>>
>>>>
>>>> On 9/8/2021 1:14 PM, Yu, Lang wrote:
>>>>> [AMD Official Use Only]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Wednesday, September 8, 2021 3:36 PM
>>>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Yu, Lang
>>>>>> <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>> <Ray.Huang@amd.com>; Tian Tao <tiantao6@hisilicon.com>
>>>>>> Subject: Re: [PATCH] drm/amdgpu: fix sysfs_emit/sysfs_emit_at
>>>>>> warnings
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/8/2021 12:07 PM, Christian König wrote:
>>>>>>> Am 08.09.21 um 07:56 schrieb Lang Yu:
>>>>>>>> sysfs_emit and sysfs_emit_at requrie a page boundary aligned buf
>>>>>>>> address. Make them happy!
>>>>>>>>
>>>>>>>> Warning Log:
>>>>>>>> [  492.545174] invalid sysfs_emit_at: buf:00000000f19bdfde at:0 [
>>>>>>>> 492.546416] WARNING: CPU: 7 PID: 1304 at fs/sysfs/file.c:765
>>>>>>>> sysfs_emit_at+0x4a/0xa0
>>>>>>>> [  492.654805] Call Trace:
>>>>>>>> [  492.655353]  ? smu_cmn_get_metrics_table+0x40/0x50 [amdgpu] [
>>>>>>>> 492.656780]  vangogh_print_clk_levels+0x369/0x410 [amdgpu] [
>>>>>>>> 492.658245]  vangogh_common_print_clk_levels+0x77/0x80 [amdgpu] [
>>>>>>>> 492.659733]  ? preempt_schedule_common+0x18/0x30 [ 492.660713]
>>>>>>>> smu_print_ppclk_levels+0x65/0x90 [amdgpu] [ 492.662107]
>>>>>>>> amdgpu_get_pp_od_clk_voltage+0x13d/0x190 [amdgpu] [ 492.663620]
>>>>>>>> dev_attr_show+0x1d/0x40
>>>>>>>
>>>>>>> Mhm, that at least partially doesn't looks like the right 
>>>>>>> approach to me.
>>>>>>>
>>>>>>> Why do we have string printing and sysfs code in the hardware
>>>>>>> version specific backend in the first place?
>>>>>>>
>>>>>>
>>>>>> This is a callback meant for printing ASIC specific information to
>>>>>> sysfs node. The buffer passed in sysfs read is passed as it is to 
>>>>>> the callback API.
>>>>>>
>>>>>>> That stuff needs to be implemented for each hardware generation and
>>>>>>> is now cluttered with sysfs buffer offset calculations.
>>>>>>>
>>>>>>
>>>>>> Looks like the warning happened because of this usage.
>>>>>>
>>>>>>                   size = amdgpu_dpm_print_clock_levels(adev, 
>>>>>> OD_SCLK, buf);
>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev, 
>>>>>> OD_MCLK,
>>>>>> buf+size);
>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>>>> OD_VDDC_CURVE, buf+size);
>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>>>> OD_VDDGFX_OFFSET, buf+size);
>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev,
>>>>>> OD_RANGE,
>>>>>> buf+size);
>>>>>>                   size += amdgpu_dpm_print_clock_levels(adev, 
>>>>>> OD_CCLK,
>>>>>> buf+size);
>>>>>>
>>>>>>
>>>>> [Yu, Lang]
>>>>> Yes. So it is fine we just fix the caller 
>>>>> amdgpu_get_pp_od_clk_voltage like
>>>> following:
>>>>>
>>>>> static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>>>>         struct device_attribute *attr,
>>>>>         char *buf)
>>>>> {
>>>>>     struct drm_device *ddev = dev_get_drvdata(dev);
>>>>>     struct amdgpu_device *adev = drm_to_adev(ddev);
>>>>>     ssize_t size, offset;
>>>>>     int ret, i;
>>>>>     char temp_buf[512];
>>>>>     char clock_type[] = {OD_SCLK, OD_MCLK, OD_VDDC_CURVE,
>>>>>                          OD_VDDGFX_OFFSET, OD_RANGE, OD_CCLK};
>>>>>
>>>>>     if (amdgpu_in_reset(adev))
>>>>>         return -EPERM;
>>>>>     if (adev->in_suspend && !adev->in_runpm)
>>>>>         return -EPERM;
>>>>>
>>>>>     ret = pm_runtime_get_sync(ddev->dev);
>>>>>     if (ret < 0) {
>>>>>         pm_runtime_put_autosuspend(ddev->dev);
>>>>>         return ret;
>>>>>     }
>>>>>
>>>>>     offset = 0;
>>>>>
>>>>>     if (adev->powerplay.pp_funcs->print_clock_levels) {
>>>>>         for (i = 0; i < ARRAY_SIZE(clock_type); i++) {
>>>>>             size = amdgpu_dpm_print_clock_levels(adev,
>>>> clock_type[i], buf);
>>>>>             if (offset + size > PAGE_SIZE)
>>>>>                 break;
>>>>>             memcpy(temp_buf + offset, buf, size);
>>>>>             offset += size;
>>>>>         }
>>>>>         memcpy(buf, temp_buf, offset);
>>>>>         size = offset;
>>>>>     } else {
>>>>>         size = sysfs_emit(buf, "\n");
>>>>>     }
>>>>>     pm_runtime_mark_last_busy(ddev->dev);
>>>>>     pm_runtime_put_autosuspend(ddev->dev);
>>>>>
>>>>>     return size;
>>>>> }
>>>>>
>>>> Prefer to avoid any extra stack or heap usage for buffer. Maybe 
>>>> another arg to
>>>> pass offset along with buf?
>>>>
>>> [Yu, Lang]
>>> Actually, the buf address contains the offset(offset_in_page(buf)) .
>>
>> Though it's not a problem based on codeflow, static analysis tools 
>> might complain.
>>
>>> Or we just rollback to sprintf/snprintf.
>>>
>>
>> snprintf with (PAGE_SIZE-size) may be simpler. I think Darren took the 
>> effort to convert these, he may have some other ideas.
> 
> This is not what I meant. See from the design point of view the 
> print_clock_levels() callback is the bad idea to begin with.
> 
> What we should have instead is a callback which returns the clock as a 
> value which is then printed in the amdgpu_get_pp_od_clk_voltage() function.
> 
> This avoids passing around the buffer and remaining size everywhere and 
> also guarantees that the sysfs have unified printing over all hardware 
> generations.
> 

The scenario is one node used for multiple parameters - OD_SCLK, 
OD_CCLK, OD_VDDGFX_OFFSET etc.(mostly to avoid cluttering sysfs with 
lots of nodes). On top of it, the parameters supported (for ex: CCLK is 
not valid on dGPUs),  the number of levels supported etc. vary across 
ASICs. There has to be multiple calls or the call needs to return 
multiple values for a single parameter (for ex: up to 4, 8 or 16 levels 
of GFXCLK depending on ASIC).

I don't know the history of the callback, mostly it was considered more 
efficient to print it directly rather than fetch and print. Alex/Evan 
may know the details.

Thanks,
Lijo

> Regards,
> Christian.
> 
