Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56BBC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 14:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2344410E572;
	Tue, 22 Mar 2022 14:05:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6691310E569
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 14:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obM3c+5OsOc3g3QTvM6Iy0V0ANYqKH/fnVL4UzpDiikp8R1MeExyCLIktuUtk3S5SoHGV4rP9j30Vwo2N7bD2F15f3QLwlbTAbjdtkC3C6zdL5JRDC19K4DhOw6p9sXNB1fK5lL0mHH1o1PAkV5GPmGz7t8HA+U6htV4YS/BaR5v+5h3w2kSCdYjEEIwJlhuia6vDfFlio9YNivJmg1a3stwCp6BM1mWcR8WvNn12e1eY5eANMl3IEIJcGLn2Z0tlU+K82yt3ctRY+M2t7Rt3w1mdIXE1zObmc5l6ND8766UeQZijT+uJze+jbXwjOZKWNuZUQZjSD+R+26SdrwUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDKxbb4EneYHgJ2jWMmzB3e7vIO544wkDO8QHxbkrvk=;
 b=I45WQBfSUnvE+wn6n4hl2vIXIZ9MY9Fdu1ctw8ZcGMuLlldpCAj3FxyA6mhAjk54p7s1VyO/NzCZjoV5Lz+izpOBvjE/KmRnZeTXH6cJfmKG6SH9z0WZK7uxC/zYV3h6WW6NHb4kLqJvB4CXxAmvFOgYmALKB2EGGyiD4hCTvl02ltI1CPhfGdvJuUzT/vxLfp1qOjeQsj/Xd3vYKj+Ueaoj2xNSGqh0wJ4EG+49PzxEf8LjXHhVz8WAqYxhb4hHw8BZYUstk5RBmlRNA/LZ+AB5Gn18H5SnEERyaLtpA0b1IlyCxp2eSWzm9gCdabQNLK1ZtPNQ1lr0t2K8Vk55Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDKxbb4EneYHgJ2jWMmzB3e7vIO544wkDO8QHxbkrvk=;
 b=4bo+xMUg0AUH7978zmBLZdoBZc/L8tQNOGjDee+J24+pvbH7WgEByC9FT9IAhzx0CFnHGohTPq+xTBohO8aPnwM0Pz5BEGc4UXf9GJUbKwS2fyAiafWtPoyZKuIB+IEORazuctZftnXdNQrJuMhYwEuArPEoR/d9slzIUAlRJS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1902.namprd12.prod.outlook.com (2603:10b6:300:10d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 14:05:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 14:05:11 +0000
Message-ID: <3fb30903-0b1a-757a-f107-4cbe878c1dd1@amd.com>
Date: Tue, 22 Mar 2022 10:05:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Content-Language: en-US
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
References: <20220321093818.24270-1-tao.zhou1@amd.com>
 <25fe0aa1-aec0-4dc1-0238-24dc496f3528@amd.com>
 <DM5PR12MB17706EFCD71EA2F4DAE3264CB0179@DM5PR12MB1770.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM5PR12MB17706EFCD71EA2F4DAE3264CB0179@DM5PR12MB1770.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117b61f4-e259-4609-fb2c-08da0c0cfac0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1902:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB190238704DDA3C53119040ED92179@MWHPR12MB1902.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrsR6vbSKUidykiJtgZxrmL2WyJkFSRBPR23n7VdRbXCLDe3Py3lEAmolyrYdxoU2H3MLN0gJN6y/KuX4GyiaZ+RvY5wc/88NW5TBZcvVmZtabGX1ogwKbTo7bnx+b9dvH4u/dbzP9uHNzrL/osBQEtKur8gEsZg4rshUy9bcOfR9Yn21f8J6DFeEYl7+MG4GlU6Fb/zVH8TXt87NDeSo1HtdXY34OnEJPLq7sM0KXu6KtV3C8qyt8z09LN20C3kku5V7sog9u4BrdBNaDW7t4dc+t5/02i4EDjelwBqMbLLHfxB6xLT0g7P2aDcGaI4CJPM/f4t2D8msjfScYoGvLyIMhHXujJEGXsAp1rWfXsxxZ7n/t7UOyWIb5zsMuD9sjnEWPxiB1G9xgxU+xdOQ32A0Ds8WgcbxErXiYxIrUvX2B3h78ds0UC6Y7+69fNRHPvJdigYRcF9uYTZtidyDA7PxlEN2F0WPm48DOIDWBaPLsom1/cuZPa6bonwSGea2ZDYjvEqWvu1toaxrZlCfQtAEPFS6VJD2jZ60ZcrP/x+ZRVl2dw3bCuaFPNL7ugL5NTLana/oRj7dYGG4JWJGXeLKOXvS4lyxTVbnndJ7slWyp8fPETAH947Qc46Ktqz7yrqdeInmzytNohBQmW/Y9FCNd3kZCiP1DJ+x3z6fd3DhOC06E8QphQH2wK8rndwiz30+L/r6uYPpYmZxTYwUYnv+K/07ga5RPLNSs3qY5rH3/ch7eROOJF2aObQPFJv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(83380400001)(38100700002)(921005)(8936002)(2616005)(5660300002)(44832011)(66946007)(66476007)(66556008)(8676002)(2906002)(508600001)(31696002)(6506007)(316002)(6636002)(6512007)(53546011)(6486002)(110136005)(36756003)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlR2UmtpbWpSUGs4dC9jMDdkMk55bmEweTlKWXowMnRRUjJNSHdERktyajd6?=
 =?utf-8?B?cUh0d1JwMnNGd0pzdjVoU2VvWENFNUwvSnFBSmgwcDRkWTJ4R0M1WW41VS8v?=
 =?utf-8?B?L3Z1S3ZNRHRrNGVURzhmV1VKK0psUis2MTFLbE5GYU8reldWV1hyQ1hzVUYw?=
 =?utf-8?B?NitKOTBZcDhuMWtoMnNVSUN1UUhvdXhUK1F5NWIwQUswWjZlNnM3cWU3Z0dF?=
 =?utf-8?B?THZnQXNGTFlobld0bGdzbm92eUtwZWFXSGF3djluVm5UOEhwRndBY1dvYWkv?=
 =?utf-8?B?S0sxR0o4cTFIdytUZXBtaERFcGswd3ZWdXI4d20ySllYZ0wyNTV1S2NTQ1BO?=
 =?utf-8?B?NVFZdE9ob0hDVXVOT2h3My9QOHBCZFo1WmNyV0dDY2cxZ1RGczZ0UWgwaXg4?=
 =?utf-8?B?ZDc1Um9WQ2Y3RTlrMFJGUTVwKzZHempNVTBjdTFFdmhmMjFXSVBQSmFHNnNr?=
 =?utf-8?B?dEIrcGt1YXdacnNRTm40KzRtejFtMVRseUhYeUk2STVRVCtiL3BIZWE0eUMw?=
 =?utf-8?B?d2hMY1ZEOXByNnJRRzRod1lvMCtIbXVvRG9ndndTOGlSeDJSNmtSUUxtOUJH?=
 =?utf-8?B?c2pQcFlvRUhXcHVONmF0eXpIb2ViTlJqWW9RZWY3U2FTYzRuQUF1QnBlYjY0?=
 =?utf-8?B?c3FWMEFySm9TNWFtYW1zNEdTcUxCbjdzeHNWVnVNdFFMTzhpeHNEWFpUbks0?=
 =?utf-8?B?N2xyYU1YQko4RndQbWgzS1BGSzkwRGdVYmtHRXE1UzVMNU5IbzFTV0dSZFh1?=
 =?utf-8?B?QUhxTFIzN1NIVHp6MzJPaThmdG5CNWtTSjlYbERPNGk3VjBuZGFVV2hxbHBT?=
 =?utf-8?B?T1JmNkRRQmc0cGZDcEQvbzhhTmNTeEJqVDV2RVdyTnhrUDE3aFVrdXlUTHRZ?=
 =?utf-8?B?cmJSQUlzWWduaUYvYURCN29BUGZ4U1BSR1pySSt3QmVjK1VBMjBRNEJKcHlN?=
 =?utf-8?B?WDhXMHBsOEJ2WW1ySTZxMDlCSXorTEF1UmlVZmh0VHRoWUV6YTZsUTRvR2FY?=
 =?utf-8?B?MEtWZHFFUjZkeHkxUlBxbE5ib2hIZnQyOTdHb0p2SmxNbGRMN3lveXNtb21o?=
 =?utf-8?B?Yzh5Y3AyRW1rdXBnc1d2ejZndTBKaVZpV3JmTGwrdjMrNGM0Y0JId3RxazJF?=
 =?utf-8?B?QithQWkzTW9TV2c1cHVCVzFyeTVrWmxjeFNOOEtXTmFMbzdxY2JHWFRGakx0?=
 =?utf-8?B?SEZaTHM1NThwRWowS05lMDRRNmVsSU1EWDNkeTN0SDJOZDB2R0NVcG1nVDRn?=
 =?utf-8?B?eGtMWVFhNXA4ZG1wOVhsQlVnbW11VFdremdUSWFRM0M0M0JHaTJBQllTVFRY?=
 =?utf-8?B?L1hESDVLbTZubitueVV5a3Z4TlRlelIrUlBkSmdwRG1pbEc5R01YM3NZd2lZ?=
 =?utf-8?B?WnFuSEt3a3RRZHFOWitSQU5ML1Nrbnd5Z0o1ZXdyRjVqWFJtYUcwMzZIQ2wx?=
 =?utf-8?B?R2s0a0hGOUF6NEJSbE1oUTBTY0gvMlVnMjI0dHBteXRZbk5GUmZpOVRRRmMv?=
 =?utf-8?B?WXlGN2MxVDg5cFI3aTRSWnl3VHk0b09uQ0tJdTFsTnB0dkkzY0JuL3M4S0dm?=
 =?utf-8?B?dlFKanRMOU43YkFhUkl3c1lMUVpVLzJyUU8zTkJUYkFPb09TUlVMOS9lSVFz?=
 =?utf-8?B?emplcmRvNzc1Z1BFbHp5THhtcHh4WXdsNEFHSElyMGNQSFZVVEtkNXFkVlll?=
 =?utf-8?B?TkF0emFGbE5jWUU5SnFMMGFGS245Vm1HRjZjMEF0bkF2bUQ3MzZtYWc4Ymcz?=
 =?utf-8?B?MDJKMWR6cUdEVmFva2ZYaU8vVk1rcC8wSTFYZlphNXlLVXVPUC9hbkVabnM5?=
 =?utf-8?B?NW9DdWwyb0EvMHdUTVFXWjh0MVEyenpOYkRTWEsxek9UaU5WdnN2OWtpYmlv?=
 =?utf-8?B?ZTdUbEFNTTZSeVVUUTg2c1FtUFNEaU1zVVYwUk1DTm00ZVRCSmd3RFMzWnV2?=
 =?utf-8?Q?G6TpQSin1C0vPAiBv4yX5kVPZrx6fYwu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117b61f4-e259-4609-fb2c-08da0c0cfac0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 14:05:11.4014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fKaarRs8mPm3cCFwQDyfQeFhMD0icdEFazgxCWTeFpwaqUxWV/igHBsUFwiCSY9W4Pf/giZ4Ep7P3EDWXT6xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1902
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


Am 2022-03-21 um 23:17 schrieb Zhou1, Tao:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, March 21, 2022 7:21 PM
>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
>> Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
>> Thomas <YiPeng.Chai@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
>> consumption (v2)
>>
>>
>>
>> On 3/21/2022 3:08 PM, Tao Zhou wrote:
>>> Print the status out when it passes, and also tell user gpu reset is
>>> triggered when we fallback to legacy way.
>>>
>>> v2: make the message more explicitly.
>>>
>>> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 11 +++++++----
>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> index 56902b5bb7b6..32c451f21db7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> @@ -105,8 +105,6 @@ static void
>> event_interrupt_poison_consumption(struct kfd_dev *dev,
>>>    	if (old_poison)
>>>    		return;
>>>
>>> -	pr_warn("RAS poison consumption handling: client id %d\n", client_id);
>>> -
>>>    	switch (client_id) {
>>>    	case SOC15_IH_CLIENTID_SE0SH:
>>>    	case SOC15_IH_CLIENTID_SE1SH:
>>> @@ -130,10 +128,15 @@ static void
>> event_interrupt_poison_consumption(struct kfd_dev *dev,
>>>    	/* resetting queue passes, do page retirement without gpu reset
>>>    	 * resetting queue fails, fallback to gpu reset solution
>>>    	 */
>>> -	if (!ret)
>>> +	if (!ret) {
>>> +		pr_warn("RAS poison consumption, unmap queue flow succeeds:
>> client id %d\n",
>>> +				client_id);
>> As discussed in another patch, I understand that pr_* is the legacy usage in the
>> file. But it won't be helpful for this case with multiple devices. Would suggest to
>> change to dev_info() - the message here and below seems informational about
>> the handling of this situation rather than warning of something bad.
>>
>> Thanks,
>> Lijo
> [Tao] I'll replace pr_warn with dev_info. I think we need a dedicated cleanup to retire all pr format message in amdgpu.
> RAS poison consumption is a special event should be paid attention to, I think a waning is also reasonable.

Or you could make the "unmap success" case a dev_info and the "gpu 
reset" case a dev_warn.

Either way, v3 of your patch looks good to me and is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

Regards,
   Felix


>
>>>    		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev,
>> false);
>>> -	else
>>> +	} else {
>>> +		pr_warn("RAS poison consumption, fallback to gpu reset flow:
>> client id %d\n",
>>> +				client_id);
>>>    		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev,
>> true);
>>> +	}
>>>    }
>>>
>>>    static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>>>
