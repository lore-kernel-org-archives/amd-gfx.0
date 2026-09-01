Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD9AC61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 16:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD76210E406;
	Tue,  1 Sep 2026 16:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n3S4gEjG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC3410E406
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 16:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbNqy1TDpK6ou+h5KLfE1pSqCg+/4AFnC7cRn5tH04zBf1HkXSLn12WhM8LOSUDUwdI2BQp+MnyvCDI+aEttsOQr+UJDr0y9IoYoDTA5pYBxZMedtw8r7hHGneqdldP4FZh/oVRU8U68ABV3Rj8ffbc+WnB/gFvbZc0YC4JUHsBlvVUcRUbNE4MclM6epbokBndHY31C7OYhq5EiyIFjpqxxlgahEvhjpBa3FXyS4zVyXck98yJLiYBr7RYJA863U+VUc68jeFaLsG3ogRcjKKs2AgO7lV5D0KVfQV0FFT54sfy4IOntGMGK52gj5VIItfESqrfbAkvpnnFDocr76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPqk6i3LmTmJRzyXMvvkvzIe44b/OWsWRJDVxxDna7Y=;
 b=YyzrATGhwL7EBTtRihJg7STvxGWv7ZiLSblv9I0Y8jrEAMzUMwXj1+zsQanpg5u8Rfmof9Q/HxgqHV350/+f+rKWd/vtbfzuTC9QDHR1M3Olx7QGYScRsED7CDxhIb8KIc1p02n+YeQb3244h2H/0gl+v4+/HcRdGaGsyU6yiF/Ug9RQzTn+aP26MdJn7gMTxhA/Ao83zohOxJR9SIIfkrN/yLwuM/OlzltjpG8JSxErmYbgvKTX3CS0XKBqQsEmv0BYcmWl3xVBVrgfaR1zkIeM8+XRzHH2Ue0J2xQi+Y2aJvR06RunrcT5S7qJi8ExkY0x3trYYEOoN/rSTg6HUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPqk6i3LmTmJRzyXMvvkvzIe44b/OWsWRJDVxxDna7Y=;
 b=n3S4gEjGta9KxyX9iGoL8rTm77H8p2xSk3ChVxhscqHGYL9ilFUMJDbmAirJ3TeOe1CsmtrgYCmg0PdZm24DQZ+9i2r3qtNxEc9p9Q0g+cMNsDnU4IUn3aQkQ2tJSDHNiIjSNirbIB5YDW9H4bvvaTcF+CXEQiA7C2VQ0z25leE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:45:33 +0000
Received: from CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa]) by CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa%4]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 16:45:31 +0000
Message-ID: <037a59c6-f698-443b-9fe0-5fdcc23e9084@amd.com>
Date: Tue, 1 Sep 2026 11:45:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix TCP XNACK scoreboard reset race
To: "Russell, Kent" <Kent.Russell@amd.com>, "Ba, Gang" <Gang.Ba@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260831205059.1803721-1-Gang.Ba@amd.com>
 <BL1PR12MB5898416E809BE5392EA63D9A85A82@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <BL1PR12MB5898416E809BE5392EA63D9A85A82@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS3P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:45e::15) To CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9629:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 179c63b9-d8f3-47ef-a2cb-08df08486fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IC3+nk0cHqIdphMbcfeTgPa4E6tV2YjrHCtqIclzvlz0E9d2Wvgws0og0DMlA++22SAQk3DCEInTX+ssAURH53Lgw0vSrd8R8IsU0LmS4yim13WBt1q2krUQsy5oJNBuGe+Q0qDiwWqpWv1VmA7bUKNXs2lWPWgFZUEeSmY5g/CBDAhHnJVaY2jRvuAAC1sXt4uDx36shB7SPkXyQwKPz3tIjCUqTPUXZnfjkST0mCKR3C9qMHAPDtxpt9h042pqZUbnYfMNpsmfU7qwQYTHZCSOLa2Vnt7IeF9c7AotRTSXrd9KdaovzYbXvuA/tE1wUDUDqGnAEi9LmcxV4Vgi4OhQJXxLG/pbeEAZuiPx8CLT2PScVGfMB2WwMGJdKrEsexySlN7B0Nr99CFbHkzMPLJD1rwC60u7Pax9TBDXfzzqFfz4wqltDdpjWGhRHE+sPOmWeo0nERwe/p5fUolyEWy5uqecYNTj4cjAzWzfknHJouqeU4iXhF330EnB/4IkT+E946CscWfNmDtcdbMmHkDboIHVCaM+qiUQoko8eR6e0lVtU4IL5+JP6M8aJRUv/xRwOyLKmaxYQAeKYThoZEPHK7ogrL8wFDoLZJzjR28YdJKyyc99w8SKJUFYQn5lRgW7GJEeLa0Yh47/SWK2Y149BJItIc4XsBRnN6Vt6aw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTdpbC9aTmlNVDg4T0RoU1lPc0JrdWVnZVk3QThFL25sdnZsSkxlRFpzL0VV?=
 =?utf-8?B?V2U0eEdHUWpPb2d0V0FTMTN1R05LNHVSYThrUWlBS05maE42Tm5aYlBnaHdq?=
 =?utf-8?B?NGlCcGJJVmc2dXhOc2V3ZkFNeUlHbUsvZUNNT0ZZQ1VvbmVBNGhFVUFSbmRT?=
 =?utf-8?B?QzRadXlxaGFiUDhPNlZGWmE3cVFYYnJiWmd5TFo0a3M4MDNLaXNoQ1BEMWVD?=
 =?utf-8?B?QVV4TXVSS3RaNStwNFhhQkQyeWI1WGNIY1ozdGVNWVpKS0c5Nnl0aDB5TWhH?=
 =?utf-8?B?djNYWmVsM2RwUnhQd3BRYlFzV0UreDVGK0dhSW96SE0zYWFwTXE5d3lWaGFz?=
 =?utf-8?B?YWIrN1pkMnRuRmZUVXovdmYzTFBnOWlQN2hTeHdUNFNreE9NQW9LTGFFQ2hS?=
 =?utf-8?B?NFVYeVZ1dFdHRElhT0xhM2I1cm1pa3htQ20ydk9BaUcxSzZxVmp2YkNWdzFP?=
 =?utf-8?B?dERPS1RNVHJDODhYSTdDTlFGUVhJZGxHWndNWnBGQkp3czkvNXF0cGZDcTR6?=
 =?utf-8?B?SXU2M3RGRzJGU3liQUxQVC9TZG5nYkpLS1hrdGxWRXRSOHFOeWcyZ21uSE41?=
 =?utf-8?B?VU8vaTlOWGpCRFRFcFF1cjNSK1hYYVhYelVaRHJTQnV1R0hQV2dhZVFDbktI?=
 =?utf-8?B?WjBwdXl2RTJFN2Y2S1ZVdEpkUDVqeWUyOTNDVjR5aVhhUDFCRko2V0p3MnNN?=
 =?utf-8?B?SmsxSFVqaVh4c0tKYm5iRGZYTjYzWUxFZXVuK2VuYmhQZllRcDlUdU0yWGkv?=
 =?utf-8?B?Uis0eCszSFdpdzdrL1NkU0xlUGUxbVVteWJSbzFDdW12ajJOcjJ0N1kxWlFZ?=
 =?utf-8?B?emN1bzBocER6UHFUOVlWSHF0dE5zcmt1WU1PT0kxSG9iRUd4bDM1ZEgwTGxM?=
 =?utf-8?B?cHZ1YXBvV0xrNTNRMHNVSkp5VUY5aW5JRGR6aDdIUWZobEswL3Q5VTNHRk5k?=
 =?utf-8?B?SnNWZ3JzZUlOdWxGNEF2U0xKT0JQN3ByT1lNL3ZPVENuelBJVVJZNndIcnZL?=
 =?utf-8?B?WEd4ZDFLZkFzQklVYi9rT2dmTHlpenhXQk11QjlCSStrZ1FhYVovZ1dBUmNF?=
 =?utf-8?B?L2xZempSeWR2OCtpNUZhQ0QzMXMvRzRreUNJcE00Wks1aS9SOUlWcFdrSGNU?=
 =?utf-8?B?dXlvdWc5MW5CZThSYm1JNW1xL1h3eWRyZzdqMWxoT0dvNDVKZUFKWnp4aGlu?=
 =?utf-8?B?MGNyU0g4TlJVN1lQMFZ6ajV1RjZlZ05tYXYwck1nbU9mc2Ziai9wOTJPb213?=
 =?utf-8?B?WW15VGN4YXZtS1pib1Myek4wS1BoZFZtS1VYWjNDQXY5NU1YUEZHbnkrVnVQ?=
 =?utf-8?B?VXRuNDhqVSthKzRYTEE2QUNwRGVZL0dtSjF3Z1AxU1dnY0c1eW9UZ2huRXhN?=
 =?utf-8?B?LzBFVlRtSFNkMXlnd1NzK1Z0QnBEbU1YOUxDRC9DeVNoWlp1bHNqNWhNVXFD?=
 =?utf-8?B?N0JxS2RRUkkwaGFaTUFuUUoxYXQwL3JMTWswZjVMdkFnMzBuSTJtemdGU1Az?=
 =?utf-8?B?NTFROHZPN0RUbzlSeU51cnJta0F4WTZFd2ZBdkFwNUdGSlcxQjVmbUNDVUF5?=
 =?utf-8?B?TURTWmFTaW9rTkswKy80dGhwdkpDaFMwL3NDTnUyVHRjRmtUTTRYWE5ZSXVm?=
 =?utf-8?B?VEhDMzdOZnVTbmZpUlF3RDAzZjU1RWNnWDFuWHJFZ3FuSVVSVDF5cDNYY2xI?=
 =?utf-8?B?cmwvSS9YTnVjLzFzSkJUSlArbWRBMHdXUS90U1picDQwSlp1YjlwNFdGcURi?=
 =?utf-8?B?d0VGaWM5eDN4T0hZOTBsUnBNc1FiYmV2Z2UveHRPK1ZsS0V6RjNKUVhOVU5L?=
 =?utf-8?B?eG5WZnFtOHRuYno2OW5oOTJDTU9nejVneDFoOWwyekJlak9rTDQxRnp0RzR3?=
 =?utf-8?B?U2s0RTlMWXFaVGlVc0x4eFdmenJxYWFBWkxtZ0ZkZDQ1UXkyTnFEV3ROOUI0?=
 =?utf-8?B?a1dwTW1mZGZHOEwzeDV4UDlqY0tJMlA3amVxaTZBaHlaL0R2bHlVd0JMQjYw?=
 =?utf-8?B?T1prZnpzbENPaFRuMEJlMTZucFMyYnJTb0RabzdGUEQzYTBrVnk2aGcrQVlp?=
 =?utf-8?B?aWViSnN2bjQ0Ni9xNXJvQXRibk85OURhTVBOYkVTS0VKbFo4UEhhc0kwQ2pa?=
 =?utf-8?B?b1IyUXhoMFh3V0QyM21hVFJmZlRoZmI0eEhNNmhhUkJnQ20vUkxrWkpublFC?=
 =?utf-8?B?OXhZUkdPc0VEaVFYeGkxaTl2aGFJQWU4cUZuaENjR2dBYmoyOW96ZzBzSUxQ?=
 =?utf-8?B?ZTg1aFhka3lzVzJOdURwQ2dOR2lxajlnYmtSU1pwd2lNZFlXaGVXVmpqTXBT?=
 =?utf-8?B?NFVBRFlzQnNVRXREdG1IU3ZEMmcwNDNiUVo1dkJDU3BWcisydDg1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179c63b9-d8f3-47ef-a2cb-08df08486fa2
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:45:31.7258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41OhoA0vJvoA1J9bgIb7pxKhk3Z3mUe24VCwSfeD6SCSwWPitaCJXtHc560cDO+9Hz9s6CobwMEcJJn+6lNT6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

On 9/1/2026 08:04, Russell, Kent wrote:

>> +     .hqd_gfx_cleaner = kgd_gfx_v9_cleaner

Prefer a name like fault_cleaner. This is not related to a HQD.

>> +void kgd_gfx_v9_cleaner(struct amdgpu_device *adev)
>> +{
>> +     gfx_v9_4_2_shader_cleaner_workarounds(adev);

Similarly, fault_cleaner.

>> +static void gfx942_workaround_cleaner(struct kfd_node *dev, uint16_t pasid)

Similarly, fault_cleaner

>> +     /* Run the GFX cleaner workaround on the faulting device.
>> +      * Only run once per page fault (evicted == 1 after first evict).
>> +      */
>> +     pdd = kfd_get_process_device_data(dev, p);
>> +     if (pdd) {
>> +             /* Only call cleaner once per page fault. Run the workaround
>> +              * only on the first eviction (evicted == 1 after evict above).
>> +              */
>> +             dqm = pdd->dev->dqm;
>> +             dqm_lock(dqm);
>> +             if (pdd->qpd.evicted == 1 && dqm->dev->kfd2kgd-
>>> hqd_gfx_cleaner)
>> +                     dqm->dev->kfd2kgd->hqd_gfx_cleaner(dqm->dev-
>>> adev);
>> +             dqm_unlock(dqm);
>> +     }
>> +
>> +     /* Restore all process devices after workaround completes */

I'm not sure that we want to do this. Once a process faults there is no 
recovery path for its queues. If we restore them then other waves may 
cause further faults, leading us back here.

Similarly, if the workqueue contains pipelined fault interrupts we don't 
want to do this multiple times. Perhaps check pdd->qpd.evicted before 
evicting queues and only run the workaround if (evicted == 0).
