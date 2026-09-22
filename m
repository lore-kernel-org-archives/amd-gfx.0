Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5DCC982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 08:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185FA10EBF7;
	Tue, 22 Sep 2026 08:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SaOrsbxm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B5C10EBF3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:45:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duPw+SxW5/4m3FtTslxM8QZuVlWX3lVf4eNpa6QRfETobRgpZY18pwpJ616s54bofotKfhqUbUWXpnl82keBnzAMaOlln+T8YscR9MVDYH1K/62bP4ucFVGJhyzQ6iqSHATOpUkfv/MVwCJP9n48orh7L8h34p27gB1hOPPAMavGOGJ+WaHol3lLHSjnIGsuQNP/3bbQC7UnnTYg5pKT4y0uoA04LH2y60fuTVGf0Um2eUCvLY2BqmDzUxUUX/UuFto56Jxf3H516k1roMFXRQboY0AOlFoh/1OJn031QvwddWCg4jdxBz6PAww8DlfufY3veG5SRNZiA2zjKeU3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdCt7S45wAY7JatPLYp0JFtFu/iMe2UDD4quSMk/nFg=;
 b=kW/W4GVLKgc3i02kosCpizq4QKvQzHEjKi8L/FWyr1VwuRCyD7USnbS2PdkW+7lmfa223K8HCQattA0WSxrUufPl3c/E1zu8WNk3ENzH7K6BWajlIRvkpRSdAo3HdskKm/VfSSTMc2f+uxpfNfZlcheZgyJFG7iJFx5O+ZIU4kvc3YalhWz1dQNUP+DxoVlFqQg4kviHvw09gI190Y97Ibz5FMp3qTt1+xaxx2N6Ea9FUsb/HqIMXvNZBNElLkJFUHflCyT2L0yi9sqZ4+r3QEvbHgYov1+9lRH1KtJjp1meZ0XclF8jxdned/dAnXypIZodCQ2cp6sC1tVMRP4f0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdCt7S45wAY7JatPLYp0JFtFu/iMe2UDD4quSMk/nFg=;
 b=SaOrsbxmZ5M0RpHeMjKgwgt1CbsfZ2aCym7/ujyGNTRPlNy9XJ2l6x0VNrR6q6CupQU/iNJKED7s+UpPM+4q8XDysfT0b3d1odKKyjuOIQDuXhpkBRz721DrpxlpMHd6YLdYiePQXLTE0jmQfHnZ1gOlDhOnt3xM+J2hnHngVeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 08:45:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 08:45:45 +0000
Message-ID: <b277046c-a13b-4d47-a7fe-55e18a720e20@amd.com>
Date: Tue, 22 Sep 2026 10:45:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com,
 amd-gfx@lists.freedesktop.org, "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
 <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
 <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
 <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
 <5f576123-9f57-4da0-a6d5-fd0390e39f1b@amd.com>
 <f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com> <arI0hEYQbrsWVlV1@amd.com>
 <580d3ecd-57f0-4b4e-8631-5c27f69ddd54@amd.com>
 <cbf15177-c94a-4bee-9ba2-f14b7860c4c4@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cbf15177-c94a-4bee-9ba2-f14b7860c4c4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e36fbc9-e8a5-49af-46b1-08df1885e4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ueRLt0h37Z3BjUS8d2HomEukKKX/D7xwgxQfweQE88ysAwxGTcGmXomAmVFfXt6qF/oqHsxXskCxUOBTg3Lc7WaulvXoetSr+sgkvUCy7MnF53uU02L9q3NiECveiC/AOesMbtcSWicI3OxZ7oc6sptAO1nBQMik5EcPn/uPPSNLGoPBv39jg5UY+MK0tX3K47Oqu9ojXhn0Vyug4pudzDp2RaBj7lV4jf8snpn41dMTWW2ll+9GOJw//1GgZQU4pEe4XFYvkR2RNiOQSQWAslEakravzHdi5H0ufMWYCHRCDEEikMfLuLiJxu4GjEjy7c/N5KeIu0UgkV1dVfqKSE2D9oLaKs5hU/OjeSBZ57tkgnc0o2rDTknY/uMw7LlevQugWjdWVjDUTl4Lrvnb2ZZZ2sLT2wgg0noinZEcjrvqoUtUIjwlZgXoExOPP7wxWY3b2lI7RTqT4MX6FNaE0AKTFIVbtSh2ylEZ51pAfgXoXBldf1bn09TLnZDJ8xaaN3UiruFAj26tj5ugsNH3Yll0/PzKjUuZ2lnEEqdEtZd+c105ECKzAhhrmFoHRarty7JwMomjxbVNmFT+jsz10Y0JhOmzEJGaco87b5s/+Ap+zIkEHOr6STSZpPAAou1z2Qeehz/4iesiSubC8oi3cfodS5IGOcP9wm4m89/wTZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2wrTzhEUEdyNXI5bGV4aWxqNnluNEMyeVVkSVF1eTh6WURUWjRhS3pTUC9a?=
 =?utf-8?B?elc4T1RYWi9BMk9zQXdNR1BJZ3Bzb2lnVHpRKzVDd0lDZ1pHS0dYWFN1QW9L?=
 =?utf-8?B?Y215ZHIvRHZ4MFI3ZUpmS3NDaWV2T090bGExY1d1SXhNVUNJOE04bWxacEJC?=
 =?utf-8?B?UnBFOTZtSjZEUSt6OVYxVUZodVhCc1ZES3N4bDRoclNRdXI2V3liWnBFTHM5?=
 =?utf-8?B?MVVKbEV0NHAycEVibzQrM1FSMTBkWUl0Z0lMczB5TlFWblN0SHNsL2RBK2cr?=
 =?utf-8?B?bGRjU0NTdUI1ajR1cDRIdnBaWEd0bnFkS0krSGU1bGdYbnRSaXFvRW9YbE5q?=
 =?utf-8?B?Mmx5TVpmLzNLK25DY0hHRHU3M1NDNnptRVlvWlFiZzlXZmhEMWhvWkVEeTMw?=
 =?utf-8?B?NithWGZkNit4aWhEeldZc2ZaNm52OUl1UTBtaHVvTjVpNGJQdHY5MmZRUzJi?=
 =?utf-8?B?eElaSHpwNjBKekkzTkIvdEp1TXNQK3lNd0xWM0FSbUlyak1VT1JoVUJtTXc4?=
 =?utf-8?B?STA1dFRDcGdvYjRFb2ltSzFINnNaM2tXc0J3T0drN3dJOGN1R3lRdmRNbG1k?=
 =?utf-8?B?VERCeTUzTmhvVk5kZGYycTU2UFdtN0RZaitWTkJqYzBYcktWL0VrdTcvN2Z4?=
 =?utf-8?B?bjdvK3JSV1FYdW1NZi9EN3JQa1lWck9FUDBxTG05d2Q2Q1BHSitHbDVHa2tB?=
 =?utf-8?B?c1dZeGcrMksvd1JhWUV2NkN6NjAzL1BDS0VzbkxmcE9QUzFHaHJPWXFFaWRp?=
 =?utf-8?B?eGVDcEJXdExRMU9mVVV5aXpwWXkxVFBHMmxCcUU5VnJtNldQbURXVmtjV2ZX?=
 =?utf-8?B?aUNwdWs1bWRGWXdKdVVoVjkvbFVZeGZHeTVHRUZIdGNpeFZTSHZiUWh1Tzkv?=
 =?utf-8?B?UTg1UDdtSzdPUHlkbkxQOS9lVW9HWjV0Q2NOMGhWNFZPTHphMFRYWmk3c1NX?=
 =?utf-8?B?MW91TnZUR21qYi9DYVhTcWFHd3EwUSsyM01yMkpDT0lhcElFdWhkUWZQQjRp?=
 =?utf-8?B?S1Rxa0JFTHkxeTF1UHRYaFVzenQ0Ulcya0JwanEzTDQzYzhNRFJQNHE3SEJy?=
 =?utf-8?B?VUgyMFByNWdjaCtGQXhBMkVITVRxeFRMVU1YUHlRMDZ6cXhjcTdOT2l3Vko3?=
 =?utf-8?B?eDU0aVVCYTJhRm00TDl1cG5JeVovYTFEeG0rRFZ1aVVrMlhxUnNLWDNScXpq?=
 =?utf-8?B?R2o0eGVUYk1nUzNYeVYxQXRVQTlKQXF6QnlpWHhwYUhta0NteTJCUkxKSEpr?=
 =?utf-8?B?NTB4T0VicVhPVERHT0E2bzEyaHJMSCtjZVZ6dy9OZy81NlhLVXpuNWg4RVJF?=
 =?utf-8?B?YjJxYjVLSzZqRHBadGpkZ3hIMEkzZVJEMlZxZitka1VNVzAwbEF6WVNYZm1L?=
 =?utf-8?B?NEdIeVAvNVpvZG9Hb1dsNXliV282YWJwNzRVRHFyaFN2WVNYbGUySTRRRldW?=
 =?utf-8?B?RjRRbXlteEcyNTFpVllnOUowb3p1VTlDL1FyUzNNRVc3MXlxRDZ3eHoydzgz?=
 =?utf-8?B?OXBqK2ZpWTU2TnZqbE0rREszVlE2WmYwak10Vm9acEVzc3FHZFloQ2tSYzlH?=
 =?utf-8?B?NzB6bEpRS1MwdmNZaEFjd1BHMFZnZHFzbmxSbmNldU1ZeE04cm9EQUQ1RFQz?=
 =?utf-8?B?RG50U3VHc1Zydy9qVXc1c1dCemtnMDNQSk1vNStOc2dEa0R6RTZyZ0YwVXdj?=
 =?utf-8?B?K3BnUlVsa1dzWVZpdTNRMU9IMkFZNjVad050NSs0alVGV1JvTCtuTlJNYVNH?=
 =?utf-8?B?dmhkSWd5bko5Z3dWeDY1eGtpUEk1aXFNWVZMRURsVGFENWRDVm5pcXk5cW5Z?=
 =?utf-8?B?aDNsUVRGdWx3R2tZOUJjcUlQNHRFd212SlQyN1lrbDAzMXJhWU54cmM0WTlw?=
 =?utf-8?B?aDNUQm5IdkZKR041ODNxcnNkS2xHTEZlNS92aUVaMk83OEp2SFBzckxTanNn?=
 =?utf-8?B?RVd2dWxUSjFQYzRlZDVsZ1c2bDIrZi96VVpkUWZvcTBLR0E3MnVPS2I0bFpp?=
 =?utf-8?B?ZXpUb0lzYWtla1FiUm9UcnpDQUJJaVUvUG95cnN6TXlhL0gzMjR2c081NC93?=
 =?utf-8?B?Yk9qOFBXQThueWZJK0lYOFJtUlBGWHpPbGlQUjBQN0ZnaDV2OVgwZVdnMHo2?=
 =?utf-8?B?RVZQNXRSZnlIVTl4MVpVWDBGZkhHWm05WTNGZTNoeDJQOHVSeWpiajJsR252?=
 =?utf-8?B?RkxpMVFvQXZaZWtGZ09hWDhvNkFCbzJkRnJlSnhqamRYdGljaDVJQVlXcVVh?=
 =?utf-8?B?L2s1MGpBSkFmVzltUm5VN3FtSTkxQUpOdG5qQ210ejlzVDY4NnVrTmJseTQ0?=
 =?utf-8?Q?ng3ta4qVLkseuszZi4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e36fbc9-e8a5-49af-46b1-08df1885e4aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:45:45.7744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxtvaWiY8M21tHVLXaPlK7XUa5P3vJGT2ENvGdk9gJKDyusjbDEMHTwyWH/Shyn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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

On 9/22/26 10:39, Zhu, Lingshan wrote:
> On 9/22/2026 4:04 PM, Christian König wrote:
> 
>> On 9/22/26 09:55, Huang Rui wrote:
>> ...
>>>> As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.
>>>>
>>> Assuming every kref_get() has a matching kref_put(), and the queue object
>>> itself does not participate in a circular ownership chain, I don't
>>> immediately see how taking a temporary queue reference would cause
>>> correctness issues.
>> The reference on the user queue object is meant to keep it alive for the duration of IOCTLs, e.g. prevent concurrent destruction from the close IOCTL.
> 
> why only IOCTL???? Since the kref has been embedded in the struct user queue, it should keep the queue alive during ANY OPERATIONS, Not only IOCTL.
> Or it will race with the destruction callback in kref_put, and causing UAF problems.
> 
> Do you see any kernel documents says that kref should only be used in ioctl contexts? 

> 
> We just cycle over the same questions multiple times now. To limit the reference count to the IOCTL is a design decision I made.

We just cycle over the same questions multiple times now. To limit the reference count to the IOCTL is a design decision I made.

I tried to explain the rational behind that design decision multiple times now but it obviously doesn't seem to be understood.

So to stop wasting my time I'm stopping to reply to this any further.

This patch set is rejected.

Regards,
Christian.

> 
>> It CAN'T be used to grab references from either atomic, interrupt or worker context since then you can't drop the reference any more without risking destruction from non IOCTL context which in turn causes tons of lifetime problems.
>>
>> This is just standard refcounting rules to keep objects alive during an IOCTL.
> Where do you see such standard? It is just a atomic number, not a lock. 
>>> Could you please point us to the historical issue or the corresponding
>>> commits that led to removing this approach previously?
>> See Sunils original approach, he made exactly the same mistake and I already had to fix that back then.
>>
>> I don't remember if it was actually committed or if we only discussed that on the mailing list.
>>
>> Regards,
>> Christian.
>>
>>> Thanks,
>>> Ray

