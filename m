Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B006FFD5F94
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 08:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502F210E56B;
	Wed,  8 Apr 2026 08:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CjDrEy0t";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE5C10E57C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 08:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVrRGN2rvBNjJ/swHHuIAby/iS+/L/In4Fd6Axw/tKybLtgukwYjef7RPA3eedkby7fxmYjXi8SjHJ7k7oklEeUxDmwn6ei3UcHtWvacPPazRS02Hv5OcgOsLgeBKYMXTsl9f2NCQ9T7JGVg8zatPbmfCDrv+ITRX5M20VqSYkKSTnwj5woEZE2+NUgCzv/Fh/CV/f/NeWgV+3YoZonXVzIx8SqE0tGes4IAykDjKLd5avVqbBsk56uSoFbX2YSNKpHMI29M81zhuG2BTDTyXzSi6zq4tAWXk+3OZ16rFrBKOz/OJZkzFjDKEa+ewr5V9VVI96yqotf0XsjeXbMZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42Cy+R6GbtzYGyLCtQZ9E059aEq+oHb6ZXE17geWaPg=;
 b=udKipC/gRzrZ7BOz8sDtE/bWuN41VCOhnq9BsZF9rzS/QmHU+RR/tvtk+EouajxegoGWGkHVQwyRWJOA3WbcQwX1ev6V1rtEvGtH/VjJr3AcT32YL//3p3U5S+r0McuCGQIyZKfLQosA7jfL5ZXXXGATmHND1AmZ6HWiR9YXEXA76wjPsjV42JqyMEijDYS6APT93S0qOJSHeLyr5M5I8mZdW99MOxhpdiq9vV0spv98VwgvIfAkTqDf5pl/nsdFWFrINuQz1Tu1JmVsTqM0wn7WIY1M9MpOHVTtRK/u7xuy7OJ3fxdhOmY7ppCFMQmayMI7jRv3aJ1dDKWDoBrI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42Cy+R6GbtzYGyLCtQZ9E059aEq+oHb6ZXE17geWaPg=;
 b=CjDrEy0tF/ZOYuojqgAG0jZhb/D7h86vzNvE9FtceEMJc6QzqUWYBQdQf0p5gCLYnurGla1ucbL3YbSW7PzVqH1BIgPG5UOhfQZk19W36mteJCiPb7quvhI/FJvAuiaZvTImMVLBREUHy189H0nCvvAuLN3aA0hw5Q1rdvse+pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 08:08:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:08:39 +0000
Message-ID: <07233918-9132-45b5-a84e-7cfa4d5058aa@amd.com>
Date: Wed, 8 Apr 2026 10:08:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [[PATCH v6]] drm/amdgpu: gate VM CPU HDP flush on reset lock;
 force-complete KIQ before VF reset
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>,
 "Dhinakararam, Lokesh" <Lokesh.Dhinakararam@amd.com>
References: <20260407162555.65833-1-Chenglei.Xie@amd.com>
 <704f4e93-c237-422c-ae41-ff892a1c4a3e@amd.com>
 <SJ1PR12MB6121FF40EB6CB53641068A32805AA@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SJ1PR12MB6121FF40EB6CB53641068A32805AA@SJ1PR12MB6121.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: b04a06f0-de46-4e33-1c19-08de95460adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 0MQgVvw/XVny1nG3l9Kn85eApnKKih6QgwHJqrW7EVQv1NLQQ5I94jhTXqNSRGGchK3JhUjqW2MwdzJgLBC6Cl0g2B2/BbPtbiTX5ztmXcRUzz6fTFdNW9muWeAAp2Fw7u5Sw4WCLN7aXhCH+MGhgWXhFXCpjm2kj+sv+JuTdH/3yxfsLe5SlAIKYqSHB48np6KBVSj5Ex0yvqd5Pst7kUihXSZxKnLNRpQ/UqDDH6E7X9XNHGdGvmfvqA7/DLzWn22iN8QXFkRmGyw1MkiDKN5gIwh8cjL3+E1TBBhP3VeTLSZa6eZLiArkWzO8k05H+ej5JV27tyaftl18TMBx804dN4KKtNhf4Kd06fFiRb64NFOJ9OZY0L05aMEC0j2uQRAKQc08hNryXqCGYpEuEl8qcIKaV375yDNbh9DqfWUOKvUZ26ax8m++XCjSd17JPZs/5sAOUNphTCLXbvWcOYkNLgpG6PMKdwhuMZ6fO1C3kKkP1oriLfKW3nBEOdpO/QRXzw8DCy+HP+FHBCmlgtfryqEZhXMeMtW52AObPIYTdhZ/AXohujZWuw8JKOhXl//jRLetMORBXipKM/8xnr3kqsot1Oj/s95KdGKg8d50N7irG53Of4qO3Mg6MvqTdTc7jmmwbjOJjX1DLOHCnIv2swNKFv1zIWYDqca3smODqqRck8dG8/vfA8vr8qVut3hjjPFt6vHv7cEKG0THpS5tAfwHn/hVsEmBMIW3hVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1pZQ2hwRktFWFFnOGdHTmk1bjhuZzVPRHBHVzl4YTJBb2h3OUIvYkJheC9n?=
 =?utf-8?B?R2hZYmtCd2YwWjJhM013aHkwY3pURjVZamFFeUxFTkdKYlhXb3NTUHNEY1Ux?=
 =?utf-8?B?aEhHQ0xNczRSMmhOK0szNGpFeVo5a3B3WU5OQ2pQSWJVb3N4S0hqSGsvME94?=
 =?utf-8?B?WUNveTQ1K2E5MWJsZmRTMUF0azFDTkVUek54c3dleWx0WFV0eS9kMmhtR0ll?=
 =?utf-8?B?eVI5eHQvSzMzMHB5TUtST0Q2TFRMUkpOdEZidkFuaG4xdHNGbk1SS3pneHVa?=
 =?utf-8?B?dkh0eTdxYk1QbXpjeXhXNHk2WEhpUmJydmdoYVFReGFJdFo0T1NoY2tzcnMz?=
 =?utf-8?B?UFp1b3hlbWNkd1JYbWVUa1JCR1pYVjZpWTZPZFl0YTFtLzNnb2dCenpYczlI?=
 =?utf-8?B?QlQ1K1dxRkd2bDhJaE9mamN4TGdCVVFjaFNPQ3dIOU9ubWFVdTQrR2h0OHBz?=
 =?utf-8?B?cm8zdjYrWWZEY3loSUx0dHJyQXpZRC9DY2psQ2xvQVVRcnd2cTczb2lxUmJE?=
 =?utf-8?B?c1M5RTlkdnh4and4V1pISHViamR5WklNbVIxRU1CazFNdzdUaWIvZmFhcG12?=
 =?utf-8?B?MG9FemloSVZGMWNzTVJDWFBaUFNvWElleE84Zk1JZEx1N1k4Sk5BYVJrY0Mx?=
 =?utf-8?B?VjFsV20zU1NoZlpPZDc0TlZqbkZDbENrTXdBMUZvU1FiRENIWEo5cUFxRmYz?=
 =?utf-8?B?TytiS0pXRGUzWWduODUvcnh5am5xanBqQkp4bGthdlFRclc2VVozM0ZOa1pz?=
 =?utf-8?B?WFkzdHByd1ZlUmhQRmxPZ2xkMkpRT2RHOS9TQ2R4eEdRd3BzNDQ4MEdRUE1U?=
 =?utf-8?B?eGx0ZUZ0SnAxQUhwaWthWm4xc3dQM1FvbUNsQVZNNGp3M1lDV01KY0hJd0FO?=
 =?utf-8?B?Z1FrT2JTcWkrSkJXL01rNlVweUdXZXBIT2tkcVZSaElCd1ZRemI2ZnVpRHRJ?=
 =?utf-8?B?ZENnS25xRlV4akpRSlorN2JZUGxOZnE0eXBWdW5hRHBrR0VoL0hZbUpzN1pH?=
 =?utf-8?B?bHd5UGlESFE5QnJyOGJsSXlqOGtqY2U1Z0dMUDMrdERaQllLY3lPU3owSGtJ?=
 =?utf-8?B?QVNaQ0hKTytEYXlqcXpJVHhTYURBVUhKU1cyZEtXa0NtVzRVRU81K1pjMCtR?=
 =?utf-8?B?ajhUME11cHlXNDAzYno2YjdVeE5PUkNlZXBLRWQ2Y2Z5UVBmYVhKMlN0SkRa?=
 =?utf-8?B?SGZIUTI3ZkFVbkJlYkE5VUVTRjJMaXR3dzFzUlk1bnhzV0paSTd5WHdRdEFJ?=
 =?utf-8?B?Q2prSnR6ZVFPMndWa1ZEN2daRmFNb3hYaVdJOU40OE9hb1hoWFBPUlNub2Rl?=
 =?utf-8?B?bWU1MTcvdWVRUElreTVqUlRvbGtmYjVlUW1tNjRGc0IrRGtRWUVBY3pSQTJZ?=
 =?utf-8?B?NnBSQk12UVB2TTVsRWVjM2lJSDU3bzdraEdNZ09rQ25NRnJWbEo5ckk1U3JN?=
 =?utf-8?B?cUIzZXlXVTY1a3cyc1ZhR1VNMkMzdWlMUHJrOWlHTFVIUE1CcHBPV01XYThE?=
 =?utf-8?B?b2NlK2UwS3RaRTI0OUl0UE9LamhuR0VDMWdOdG1wc0xqSVhybTBtZlBuZjRH?=
 =?utf-8?B?SjhmSkNibDlkZmtQaGxqMzBkTXlaZHQrQWk5bnRuZC9JMGRsS1NKY0xnR0xM?=
 =?utf-8?B?S0VlSTdHTnNKOHVHMDZjcWxPWlRjOS9Xb3cvYnhCeFlSU1JvL2tUN3BXUWNY?=
 =?utf-8?B?SjVPYjVXMnd1YVlQOTlPN1krUVJwemRUa1pjZTRQY2NnL05FamU2eGgwU1Zw?=
 =?utf-8?B?aHRWQTdtamVsTVNuQVJIOHFWR01WcENVN1R1djJWdTRDTUZBcGsxUEJMQVBy?=
 =?utf-8?B?VkYyVnZtei8raGN3bW1EZ2dvNE5NZFJFeEZjQ21WL2xtbjZjTFo0ekwyTEU3?=
 =?utf-8?B?ZnNvQVJzN3d5NWxmM3pWZ2pNWmZEZUxhcGdjbDZGV0xraFJDNmhEZ2lNUUJj?=
 =?utf-8?B?SG9iMExSZVJtdzdHNGlPRjlhTFdyWHVvTWpDUHgyOWxueFBsUDRoRU02YlhJ?=
 =?utf-8?B?dmtQTzU3WlorVU1rVW04ckJldWV0MUFtQWFFaXlCcnpRNkd3RlZlOXV4Zlht?=
 =?utf-8?B?UE1GWXhxK1JKSGsvVzE2R1BNV3hsSG93aW9YQXI3WjlEb2EzaUpGaTVGK0FJ?=
 =?utf-8?B?dUswTE1PejZrRVhQMXpRcE8yNHQzR3JKZndQeHBGaWFLWGgvNUNEUVg0WTRK?=
 =?utf-8?B?K0d3cDFGNjNkVHV3MjBqS3psZUcxM2R4TWd2OEZhL2JsNWhZd0lTWDBWUGdx?=
 =?utf-8?B?a3Q4Njh4RVZtdUdJUlJzbFhnZmVnVVpSb0FUN3lXRUVTeUdydjBWeVV1Z1dG?=
 =?utf-8?Q?bWqoU1rsjQVIBTmY3z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04a06f0-de46-4e33-1c19-08de95460adf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:08:39.7040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7XwdhaAxOOAbVf0caIAX4zi6jG/PrKg5CIVixfN0CH6JGMComWVukr6FMUsWKTN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
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

On 4/7/26 22:55, Xie, Chenglei wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi @Koenig, Christian,
> 
>>  void amdgpu_virt_pre_reset(struct amdgpu_device *adev)  {
>> +     int i;
>> +
>>       /* stop the data exchange thread */
>>       amdgpu_virt_fini_data_exchange(adev);
>>       amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
>> +
>> +     /* Force completion on KIQ ring fences so pending fences are signalled. */
>> +     for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
>> +             struct amdgpu_ring *ring = &adev->gfx.kiq[i].ring;
>> +
>> +             if (!ring->fence_drv.initialized)
>> +                     continue;
>> +             amdgpu_fence_driver_force_completion(ring);
> 
>>> Well that is unrelated and clearly incorrect. The KIQ is re-initialized through a reset and should *NEVER* be force signaled.
> 
> HW KIQ is re-inited after reset, but that path does not reinitialize or reset ring->fence_drv.
> amdgpu_fence_driver_force_completion() is SW-only: pending dma_fences get -ECANCELED, writeback is set to sync_seq, and fences are signaled so bookkeeping and waiters reflect that the queue’s prior work will not complete on HW. Without that, seq/writeback can stay wrong and amdgpu_fence_emit_polling() can time out on later KIQ use.
> 
> The generic loop in amdgpu_device_pre_asic_reset() only force-completes scheduler-ready rings, so it skips KIQ. This VF path covers KIQ unless we add equivalent logic elsewhere. So we still need this SW cleanup to avoid KIQ fence state mismatch after reset.

Well you just explained it.

The KIQ is skipped in amdgpu_device_pre_asic_reset() because it doesn't use dma_fences and so calling amdgpu_fence_driver_force_completion() on it is absolutely nonsense.

I mean when there is an intentional skipping of calling a function why in the world do you think that you need to do that manually?

Regards,
Christian.

> 
> Thanks,
> Chenglei
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, April 7, 2026 1:07 PM
> To: Xie, Chenglei <Chenglei.Xie@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Dhinakararam, Lokesh <Lokesh.Dhinakararam@amd.com>
> Subject: Re: [[PATCH v6]] drm/amdgpu: gate VM CPU HDP flush on reset lock; force-complete KIQ before VF reset
> 
> On 4/7/26 18:25, Chenglei Xie wrote:
>> During GPU reset, the application could still run CPU page table
>> updates. Each commit called amdgpu_device_flush_hdp(), which on SR-IOV sends work through the KIQ ring.
>> That can advance sync_seq while the GPU is being reset, leaving fence
>> writeback out of sync and causing amdgpu_fence_emit_polling() to time
>> out on later KIQ use.
>>
>> Fix:
>> amdgpu_vm_cpu_commit():
>>   Take reset_domain->sem with down_read_trylock() before amdgpu_device_flush_hdp().
>>   If the reset path holds the write lock, skip the HDP flush so no HDP-related HW
>>   access (including KIQ) runs during reset; state is re-established after reset.
>>
>> amdgpu_virt_pre_reset():
>>   After stopping the data exchange thread and setting MP1 FLR state, call
>>   amdgpu_fence_driver_force_completion() on each initialized KIQ ring so pending
>>   fences are signalled and writeback is aligned before reset proceeds.
>>
>> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
>> Change-Id: I938bce0cab93a794dbdb02fe3ca9e041f9ac1424
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 11 +++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 16 +++++++++++++++-
>>  2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> index 6974b1c5b56c2..0127b0d6c7277 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -1188,9 +1188,20 @@ enum amdgpu_sriov_vf_mode
>> amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
>>
>>  void amdgpu_virt_pre_reset(struct amdgpu_device *adev)  {
>> +     int i;
>> +
>>       /* stop the data exchange thread */
>>       amdgpu_virt_fini_data_exchange(adev);
>>       amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
>> +
>> +     /* Force completion on KIQ ring fences so pending fences are signalled. */
>> +     for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
>> +             struct amdgpu_ring *ring = &adev->gfx.kiq[i].ring;
>> +
>> +             if (!ring->fence_drv.initialized)
>> +                     continue;
>> +             amdgpu_fence_driver_force_completion(ring);
> 
> Well that is unrelated and clearly incorrect. The KIQ is re-initialized through a reset and should *NEVER* be force signaled.
> 
>> +     }
>>  }
>>
>>  void amdgpu_virt_post_reset(struct amdgpu_device *adev) diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> index 22e2e5b473415..a9e33b7e87406 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> @@ -21,6 +21,8 @@
>>   */
>>
>>  #include "amdgpu_vm.h"
>> +#include "amdgpu.h"
>> +#include "amdgpu_reset.h"
>>  #include "amdgpu_object.h"
>>  #include "amdgpu_trace.h"
>>
>> @@ -108,11 +110,23 @@ static int amdgpu_vm_cpu_update(struct
>> amdgpu_vm_update_params *p,  static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>>                               struct dma_fence **fence)
>>  {
>> +     struct amdgpu_device *adev = p->adev;
>> +
>>       if (p->needs_flush)
>>               atomic64_inc(&p->vm->tlb_seq);
>>
>>       mb();
>> -     amdgpu_device_flush_hdp(p->adev, NULL);
>> +     /*
>> +      * While GPU reset holds reset_domain write lock, skip HDP flush entirely so
>> +      * no HDP-related HW access runs during reset;
>> +      * reset re-establishes consistent state afterward.
>> +      */
> 
> That comment explains what is done but not why.
> 
> Rather use something like this:
> 
> /* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */
> 
> Regards,
> Christian.
> 
>> +     if (!down_read_trylock(&adev->reset_domain->sem))
>> +             return 0;
>> +
>> +     amdgpu_device_flush_hdp(adev, NULL);
>> +     up_read(&adev->reset_domain->sem);
>> +
>>       return 0;
>>  }
>>
> 

