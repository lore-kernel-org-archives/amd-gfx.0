Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67220FCD0A5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 04:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C75BD10E704;
	Wed, 18 Mar 2026 04:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uUwhnwvx";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013069.outbound.protection.outlook.com
 [40.107.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B382F10E6FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 04:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvnJqmjPrPuzAcScLA9J/lZW7E0deqmJFJMx9s1Sbq45KpidN+RhZCY5p6nJKMIudLX1w62yN+EsQ92oRNsVjJRmXIotE1PO79OkfU4jwvpRW4tfstnefoSEBjF7KPrstUgxTME/qUuI2WoWV8XnhKZzZkqN5ngBife5J8KHRXoRUtM+d3FRfM1Cy0ZQcbPyRTL30c0ebHR8+xL2OMaHQT8azYy1m3R8FxhPrNXG23jFS8vZD5eNvLFghmckugeQNuzEYdlt8lS62oUpKvlQLHC7mMvBQiY63JhkP6VsDfFhjZbjFRwPF+DtgJgg+2ebMR9RvIFCkNKdHoeliwbNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRoKaIpwaKVkve6gdrBe8eSvR0kQsJFYaT+x0EJdBb0=;
 b=b7HD1WkM3KiYxvq7K1WOgVouYmODx3RMlmodtR5NOhxeyuJ5d5GP4vcgJYNsVOS6KUrxSrUvtuuId9xP5yFc13XBpTRu6Ssh3IzSus2XWM+MzMSUiIPap8RKpaWNK9VxQtBM/CbTJzqhrI8ijFjcQz0eQuJPWkxgAU6atEuGTUXvngfOXFdbkI2l7T3iXsgc3buLF0YzmC2WCexQ4FCW6wL4UF1Saxzi0vFXH1DfL5Uh1gcn9pD1LWxwn54iVDaU9/l9pw5qHVG81gEGNN5gdRlkiKaEzaYKUF7tvh0yj9cAIavZF88pPQfFrFj8N0R3JL5ZYJE1R7bo197RXEbS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRoKaIpwaKVkve6gdrBe8eSvR0kQsJFYaT+x0EJdBb0=;
 b=uUwhnwvxEZDbMF2KW138m76pBHnOADuMATJdv7gONqahfHriOUVxghdM6ViYEwpyBieheKKlYSAbZdLeuodfKtKFc5c2AzGGnPap8h37pssUy9yZar5tNkvoPa1EyfwG9DLRdlwUASJCUQdjkRjfSyQIf1zcU0vvXkKUvMRo4KY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 04:00:02 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 04:00:02 +0000
Message-ID: <d0189363-c977-4bc4-a72f-b6d46b3db761@amd.com>
Date: Tue, 17 Mar 2026 23:59:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
From: "Nirujogi, Pratap" <pnirujog@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, mlimonci@amd.com, christian.koenig@amd.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
 <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
 <653ccfa8-8b92-4c47-ae45-5bfa91302f50@amd.com>
 <0fb83ff2-33ef-443d-a4a1-1608d52d34cc@amd.com>
 <46fa7959-ff84-4ea8-a17b-3825876b64eb@amd.com>
Content-Language: en-GB
In-Reply-To: <46fa7959-ff84-4ea8-a17b-3825876b64eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: ba180460-6606-4655-c9a0-08de84a2d490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: c9Pot7vo+MF8lT7z5IlrnADEEEOAB/+OmOzKP6htKn/yn5m77YKpQS0e+QKX16I5lDxro3wJtR+ThETbVxUvBe/Xzaxz1SuZws403lu4b/W/h3rCVCayaXS1Wd++eZzI5sLtNMfnMDMqCd92Kt98IixevkVQPRMMUz/+DqxttPf/UXjTbFXThRE8y20qIMqTG4bP0iEg9CaS2KI0Akhlbovy9VhJfgOnuLxmuFxbKjlPwI0IpfJapOkjaLdMZZai/pY2FR8PdSswb8A1LTHpWAel/CalyFMpY7V/uQPVj09/aJNYc799OM3Im4PQEMKt5aAFs+4IHbgZZlamRVLGXpwRazOrT8WikSh6wiJGqbMBjeftxnznxZJszIlCmOrF9wJ3KBtGZkbz/8tIBX3K4t3x9PTzT4MSok1pfPdY/gMR+/Fr/pQSg1uy1D74QC32OV9VU6iCp0/ZNhcwfGk+g0Dm12VmJcQtxyyQXkzzZPooXmEgvQr9jQWX0CR/w18C9WXDjnlNfAcjlh12ld9ML6u5NbIpd+zXc58znIPbXFZJY6GCk3WlFKGQKtJ3lEAMVF3iNcmWSX4oimegbhv2s4pl+5uNQzl3pHMLL9BhjYl0V5hvC9j+bbchrjeGIhlqhzaQKrlgsow+yVXLO6AfoYUx8ryZyddTXi7cuMt1wKDgsP4og35xXY4ABtFWrJOEw6d4ds6EwEjoUdFPo7mp3WxKmd9L42oo67ub2ptseTgjQS2DBRME6bFztq9/2JfK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnZUV0xIN3NOWWRiY1VZZUszYThjYWErVzNsUHUrdzdBdW1Ubzh6TTFnQm16?=
 =?utf-8?B?aThDMWd0NDVyQk1YNE1xOWpNVEYvZUR1bHUwaW5qTkRremQxVDg1bEJwN1Q1?=
 =?utf-8?B?aW90UGh6U0x1bEdOMEtqQnZmQTIrUU1yMjYwcEhwYXkzVWFQdWE3NEtSMGlV?=
 =?utf-8?B?Y21yenoxZGgwbXFyL0NYTTF6Zkt2Tlc5YmpMbVg1Z24xdk5lMFVXQU1ZZzFR?=
 =?utf-8?B?elM3NjlJb2NQeFRSVlpKQ1NBOFZ5blNGWXowRUdaMndYT2RlanZXeXJYNkYw?=
 =?utf-8?B?NkFtTlp6THg4WkVsNjRqMmVnVk5mS2ZqZ3lxdEdFOUdqRElIYjRlVnZxVCtO?=
 =?utf-8?B?bU5jRjB5T28wZnpRUkdyTDlPd2l2OGljSGVwdkFqWHQraFlLVUJMWEJHNmZz?=
 =?utf-8?B?dXE0bHBTVHpIZWJzamFRMmo3NCsvc3NnRmNIa1YyaVl6ZHZ3dDR4cUFJWE9i?=
 =?utf-8?B?UkZxNVZ0LzNzZ3NNb3JlejRBb3NlaURmYnhaZzQvWXo2NDFFTTFjcTJ6eTVS?=
 =?utf-8?B?dnJxQjJzT0FPRkh1aEIyYTdCUGhQVUxEZFV5WEpnR01GN3pnV1NJb0N6Mnhl?=
 =?utf-8?B?NDh0RnB5SW1iQzV5TFlRME5md0pldEVhUGoxU2pQbWZiVFhIVUg2SW5rSUZC?=
 =?utf-8?B?cnlpYXBtVTFiRWdsOUhzOWlBZWxDMGdVMkpQaGlVMm9GVVk4aDBOTS9INS83?=
 =?utf-8?B?WnpUeFdrR1pDSGFTZTh2SVBrS05HVWtNbDRvTVNjQ0c1bTRORjYvaFFqME1t?=
 =?utf-8?B?Umo3Zng0aXlKQmtJTHN0MEFwY0hKTWFyV1lmUEFqWG9BMER5SXNPQTJ3K012?=
 =?utf-8?B?Y2ZXdk5ENEZUOHAwbTk4NTFBaTgyT0NWU0FYd0grRnIrRTBpanZMa2NuM1Nh?=
 =?utf-8?B?Nms1ZXJyMkFucW1CWjd4NWVscmlWRTV4WjMxcTFId09HR0JYWTE2OVVvV0RK?=
 =?utf-8?B?cDlLb0h2NlE4bnZxbTNhL1ZEblFNQ2dOdmdVWnJ5NFBNSkZodHZWMU81dDNO?=
 =?utf-8?B?K09sQXJLWUoxRWE2WWJVcVlDamxSYnNuSWdtNC9tOHZOR1FDSUxFSkg3amJQ?=
 =?utf-8?B?RldDZ1gxYStuZ20xRzFRY0hnVXRTTFJOcXlMVWtLV2RBcmxLT0ZZaDlhZlRQ?=
 =?utf-8?B?b3FCVnprOS93L0xtY3pTMVE2bmJOMDYyeDdNTTl2TlhXbm9ndzJhdHN4dGlk?=
 =?utf-8?B?aU9uaU9NRkNJOTM2QmhzQ0s2dUhSQTA0M0FMSEhTTUxNRUVHNVcrNUxFWHVY?=
 =?utf-8?B?MEYvVFJyU2UvbFMzZ3FjclNNUDdJdVlWNTFaVXRIelYway9MMmczYVlVQ3lv?=
 =?utf-8?B?RmpyNDJtK1h6TzROeW4wTHkzRXhkYWRBU3JwNzg1c3F5T1lKOFZKL2kyYndl?=
 =?utf-8?B?dXdhQTV2SE4xNkZkWUdVMC9pRGNRcGVtV0hsQ3BFTFZsOEVpZTVYYllHZlRP?=
 =?utf-8?B?L2o5dTcva0twcEVyK3ViR0REVEZrS1ZCUUJNZXJPK0NkMFhrU2NxNGNaSmxE?=
 =?utf-8?B?SDhYcXY2WXNIT1pJQVhVVTZtOG5CYm5JZjlreElyRTBiVGd6OWI4YlNvYmJm?=
 =?utf-8?B?SkNGUFQ5MVhQenBpQjNrK0xwUXd5czdQWmpoQys2VUVQZHlZSHdDc2w1RmlR?=
 =?utf-8?B?Sit1NndHVlJXQkFoa0RxMTdKV1F5Vjk0MThlKzZNN1NoSHVrOERuYS8vN2N4?=
 =?utf-8?B?Q091UjFMQ3BKSjZzZVBseUFhN1ZtaWlRbUxGUGhKd29tdHZmSk0vMXBnYk04?=
 =?utf-8?B?d0FPOThZVmtpZVBPMm1iZGJYUmp6YTNGMGtld2lCR010cUJ6a0Z1a0wrRUR3?=
 =?utf-8?B?VEFsa0wxSVFpM2dmZ1lvVk04RnRUTG5xZ2ZiZGtmNTE0QVduSWJwbmJjSTky?=
 =?utf-8?B?NE1DU0JMVjFIdGFFWnNhUnNKbStPWi9WZmpHOGVHS3BxS0F0MEJIaG5KdUxj?=
 =?utf-8?B?Vms3eVczY2MrVkJFa3g1VWx6QjE2WGdNRFlRMEdRMU1xUm1CelBPT0NTR1ov?=
 =?utf-8?B?MXVzRXc5bmFWTGtrYXQzZ3JCZmNsQ0N1cjcwRjk2eUtCZmExdjA3eWRjTDZW?=
 =?utf-8?B?dkhIdi9mSG1jQTllWGhYNVVzclAyakovYXdJbmt6Rkw3dUU0MVBEdDBsRmZU?=
 =?utf-8?B?cGJabjB0ZWtlYzJFd0RZYXA2N1RGUHc0ZnZrNHdhQlFwT1huazQ2V2ZNOXBr?=
 =?utf-8?B?NVFWWUs4R1pZVkhUbVo1bDdNK3U2ODlRY2hnNVBhR2Y3SjRyTFJFK045Vzdr?=
 =?utf-8?B?cndYWGZWdFBETHlNa3hTOVZHTGF2S2cyOXZUaUFIdmNnc294SjJTeDMwbFBy?=
 =?utf-8?B?MVpFOWpZOUs2dCtTa3NWTzAzeW11RHFQb1VyNE93ME9mM0ZuN0Evdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba180460-6606-4655-c9a0-08de84a2d490
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 04:00:02.1878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tSQSt/dT1/pey1bGsHAFucwnulS4CFFZIgPuAd548YGB9/Z58UR1fwnGu2FIMagclXB8LE3RdD0UEa4De6MLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
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

Hi Mario,

On 3/11/2026 11:29 AM, Nirujogi, Pratap wrote:
> 
> 
> On 3/11/2026 1:26 AM, Mario Limonciello wrote:
>>
>>
>> On 3/10/2026 5:52 PM, Nirujogi, Pratap wrote:
>>>
>>>
>>> On 3/9/2026 5:58 PM, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 3/9/2026 4:50 PM, Pratap Nirujogi wrote:
>>>>> Add NULL pointer checks for dev->type before accessing
>>>>> dev->type->name in ISP genpd add/remove functions to
>>>>> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure
>>>>> ISP driver dependencies are loaded in correct order.
>>>>>
>>>>> The regression was introduced in kernel v7.0 where MFD ISP
>>>>> device enumeration doesn't complete by the time it is added
>>>>> to gendp. The timing of ISP device enumeration has changed
>>>>> because of the changes in registering the device sources in
>>>>> the device hierarchy.
>>>>
>>>> It's a little bit pedantic; but I /think/ there are two different 
>>>> problems here with two different root causes that both happened in 
>>>> 7.0-rc.
>>>>
>>>> As a consequence I think you should have this split out as two 
>>>> separate patches in a series linked to a Fixes tag with the reason 
>>>> for each of them.
>>>>
>>> Hi Mario,
>>>
>>> Few things to clarify before I split into 2 patches and submit v2.
>>>
>>> - Yes, you are correct, the changes in this patch are not directly 
>>> related to the Fixes tag 02c057ddefef mentioned. But since it has the 
>>> dependency on the below patch for automatic modprobe of isp to work, 
>>> I have used the same tag to cover the dependency. My apologies if 
>>> this approach is incorrect and misleading.
>>>
>>> https://lore.kernel.org/all/5986516.DvuYhMxLoT@rafael.j.wysocki/
>>>
>>> - NULL dereferencing issue with dev->type observed on v7.0 is 
>>> specific to this commit 057edc58aa5926d63840c7f30afe0953d3994fa3. As 
>>> the wakeup sources are registered using physical device instead of 
>>> ACPI device, wakeup source device (wakeup14) is added as the first 
>>> child of AMDGPU device; and since its dev->type is not initialized 
>>> properly it has resulted in segfault.
>>
>> Sure this makes sense and is a no brainer to get in.  I would just send
>> this one right now and we can keep noodling on MODULE_SOFTDEP (more
>> comments below).
>>
> thanks, I’ll go ahead and send this one out now and will submit the 
> MODULE_SOFTDEP change separately after the root cause is identified 
> ( more details below ).
> 
>>>
>>> In 6.19-rc4 or earlier versions, this issue was not observed as the 
>>> wakeup source device was never part of AMDGPU children list.
>>>
>>> For the changes in isp_v4_1_1.c, I will use Fixes tag 057edc58aa59 in 
>>> v2.
>>>
>>> - MODULE_SOFTDEP change in amdgpu_drv.c is needed for automatic 
>>> modprobe of isp (and other amdgpu mfd child devices) to work in v7.0. 
>>> But couldn't identify the specific commit in v7.0 that is causing the 
>>> issue. I can confirm it is not because of commit 057edc58aa59 as the 
>>> automatic modprobe doesn't work even on reverting this commit. Can I 
>>> submit this as the fix needed for isp probe to work in v7.0 without 
>>> the fixes tag?
>>>
>>
>> MODULE_SOFTDEP is generally for ordering, but I don't think you have an
>> issue with those modules loading before amdgpu do you?  I'm not really
>> following why the modaliases stopped working and I'm a bit worried that
>> it's papering over a more nuanced issue still.
>>
> yes, this explicit load‑order dependency was not required earlier. I 
> agree that the regression point is not clearly identified. I will 
> identify the bisected commit and submit the patch later.
> 
>> To identify the root cause, it might be helpful to do a bisect, although
>> it's a bit complicated.
>> 1) At any point that has that platform driver conversion you need to
>> either revert or add the change to auxillary
>> 2) At any point that has 057edc58aa5926d63840c7f30afe0953d3994fa3 you
>> need to apply the NULL pointer derf fix
>> 3) At any point that has the changes in linux-media for API adjustments
>> in 7.0 you'll need to pick what version of ISP series to apply.
>>
> I tried #1, #2 and few other combinations, but none of them helped. I 
> will investigate further to identify the commit causing the issue.
>>
I have submitted the patch below to address the automatic modprobe 
issue, with the appropriate Fixes tag added. Please review and share 
your feedback.

https://lore.kernel.org/all/20260318034842.1216536-1-pratap.nirujogi@amd.com/

Thanks,
Pratap

>>> Thanks,
>>> Pratap
>>>
>>>>>
>>>>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>>>>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform 
>>>>> one")
>>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/ 
>>>>> drm/amd/amdgpu/amdgpu_drv.c
>>>>> index 95d26f086d545..920595f0d22ca 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>>>>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>>>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>>>>   MODULE_LICENSE("GPL and additional rights");
>>>>> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp 
>>>>> pinctrl- amdisp");
>>>>> \ No newline at end of file
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/ 
>>>>> drm/amd/amdgpu/isp_v4_1_1.c
>>>>> index b3590b33cab9e..485ecdec96184 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device 
>>>>> *dev, void *data)
>>>>>       if (!pdev)
>>>>>           return -EINVAL;
>>>>> -    if (!dev->type->name) {
>>>>> +    if (!dev->type || !dev->type->name) {
>>>>>           drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>>>>           goto exit;
>>>>>       }
>>>>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct 
>>>>> device *dev, void *data)
>>>>>       if (!pdev)
>>>>>           return -EINVAL;
>>>>> -    if (!dev->type->name) {
>>>>> +    if (!dev->type || !dev->type->name) {
>>>>>           drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>>>>           goto exit;
>>>>>       }
>>>>
>>>>
>>>
>>
> 

