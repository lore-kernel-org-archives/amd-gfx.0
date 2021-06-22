Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23363C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C2C613AB
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 10:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C2C613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5EB6E491;
	Tue, 22 Jun 2021 10:51:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E666E086
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 10:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+ra7cDbkLUkVvqaKVXqJXooorR8cQy6jWA8MwPGW9GdS6xbWBBfKS1R1Z2sIs8Kot5vO2x6ITr8MsqbsidoLriDmOH4C7wGSmKrTYa358IOhhVzG56HdEhFYmzZHEApFScTtxTTBwxeghB7lJBSqEq6ZWMvBhuaiP0SEejqf1WdKB7xfp4uZ/EttCEhCIn+zRAQFbGk69+FPmYg2fQNmieZtbEruqk+gjd45UMXLSmYzyxLKTIqbICTkvtTEZo2NnW4E61/Kijq6RPxkeD7ZY9mhLXQbIpACQONrY86xmr7Z084yHLB0gEU1QvhX1ahV+VeNdGS9Nb9dKflJsgP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7CE7oxIMYo9hxH99BnRyCgd7FrjKFuMD/BKp918Wow=;
 b=HKh3uC/HrB4wj5cMCqdpHKB8uxLLN1U9k6OGQvY7e5v2bXke7vE0ltioT9wM91NOPjWdzqOHF5cMlu54bIBE5KkvYoU6asXY6efSUhx6ExukKyxdxxLoxcCz/4kmw2iCrb5r79f7VADzDaUe2sW2FvHnFaz6ALANrlpzRlXFYqp/ItGviwNZoLhERqwYdLOPzy8iRWeNuTxl7nG2Z2JVK4yz9Sq28a2ksA8t5/ZxBnp2Zzxam1RF31emJYhLDayh0OLm29mPqAK0uhYtLIRpV282dOohs4HPGM2lCz4U1SvFFMG5ypcc/4SvsKGf7mm7dNnDYVTKhXIZL5oRCJAz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7CE7oxIMYo9hxH99BnRyCgd7FrjKFuMD/BKp918Wow=;
 b=5EZGcGNyzhB0uHQwJgkOiREAiF4E1KC1JHpQGHNJ+a+KyYFi/tkNXKfbq6pg8WMrKmKmvEpnHR83cvYN0mRyr091vF/TRAn1zkjd/9UVbJzWE4cF3YqvcWi6oIodsA58jjuoQOTWdlwnUK80Ez9Ivfn0keWtdhrvx3yre/hTMZ8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 10:51:31 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 10:51:31 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: add helper function for vm pasid
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210622065711.4589-1-nirmoy.das@amd.com>
 <e2a64dee-ca51-ab36-9255-8950e78c6190@amd.com>
 <5ad4ce29-2a7c-efc2-1541-4e204064f045@amd.com>
 <9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com>
 <564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com>
 <c28d9c08-0ab8-780a-ae44-e444ae49500e@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <18309ad2-8fc9-30dc-cfa0-9baa1a08f5f4@amd.com>
Date: Tue, 22 Jun 2021 12:51:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <c28d9c08-0ab8-780a-ae44-e444ae49500e@gmail.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f26:2100:2c2d:c190:70a6:56ff]
X-ClientProxiedBy: PR3P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::27) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f26:2100:2c2d:c190:70a6:56ff]
 (2003:c5:8f26:2100:2c2d:c190:70a6:56ff) by
 PR3P195CA0022.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Tue, 22 Jun 2021 10:51:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0a7c545-0ba3-41e0-4443-08d9356bb196
X-MS-TrafficTypeDiagnostic: DM4PR12MB5054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50543FE62B33127517E2D59E8B099@DM4PR12MB5054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5WYsdSOB6tZr/aPMGXAQGKeDPhtH9pqlsqWA57Gr2+1kA2a6igYzGcXIIO9zVIWyRgw4TSNLkYq4oMESNQTtH8S1lxMUeFZsQOuINOoNI2QslnqqZ7Yv0ft2wePYvhcPu3QuvdG6nrmu0IU5HM6N6k/jEICzHNTxUzVY81oXfGvrnlbcUjZ26Zj7Yi6Zfuu7fzUEQU0Stfxoec2cPxvPjOg7YeJbrqndXGBCkff4Q09wsxLUKlI7Qa+xrqPtLYMAXE5h87Cbv7JJFZiahkHiTHX0TNTBoYXUUcNlWcV+eecsU8dBk1kbK8ZSp2PrgYiK/whe+1YXSdzHSYqC2dWPxyMzr44/Hw7IOil5sRtJKe3OuafqSe4AdxKXjFgPDmzzVt5nRjMbJgMIIArwrn5+cAb7qBuBB4YTzwDp4l3zrn0L7fsfPLuyW+ymbbMu/cwdZ8XhgqUQNc5+CphKGrxSUiOLvXchPEhtn+2l4jCjofHATKIn3m2U+WWU7r8u53NXSdgpZ7Uo15nNgGMOsg6kKgT6iDbZpTu7pF9rtgSsdlObrDr1eubWKG/zaOeonY0JrNVugR3uSn2Ii2Y/kB7CXTfi4iMW5RqcmjRStUq+6NcipmIBuX7Un6iQUct8Lz7JBpB+UpfZVhzfknLtBM3BYloRcgUvcmkgLBp0T+4+StfpM37USomccRN48QT6zFXHIJRTUAPu7/0DsSH4w5XaHoMg3dOlswWNbuyHnsKqhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39850400004)(110136005)(2906002)(478600001)(8676002)(4326008)(66476007)(30864003)(33964004)(31686004)(6666004)(36756003)(186003)(38100700002)(316002)(2616005)(66574015)(83380400001)(66946007)(16526019)(966005)(166002)(66556008)(53546011)(45080400002)(31696002)(5660300002)(86362001)(52116002)(8936002)(6486002)(45980500001)(43740500002)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1YWC9HZ0t1UllxVUQ2STV4bWRCTnFrYmFhYUwxNjBYSVNTM2JiTUF2OXZU?=
 =?utf-8?B?NFV6SFVKdmh1QmlFUldyaE1XK2J6emE5U0ozSE5EQTVGK2ZEK1B1RWUzWWh4?=
 =?utf-8?B?dHVWakVKTDA2dFl2WXBXQ0pRWmtVUTE0ZS9hdUdOdmU4TkFXa3cxMUo1bEc2?=
 =?utf-8?B?akxNcTFMQk5ucEF5bFFXU3NhQXh1dlduWElOYkNWRENEaUtFQ3kzQXU0K0hF?=
 =?utf-8?B?MFFUNlFrWXM2Y3g0UC9tR1RBNy9uelpRZWxRYkpSQ09ZMUpvcnQxT1IzRUJR?=
 =?utf-8?B?YkVNelRXRTVtdHFMbjZ4YzEwcGZKOGpBbllwOW1MelhXODhXd1BjTTV4Y1o4?=
 =?utf-8?B?WThoS3ZvWFJ3RW9ld09qVHVKa0ZOSFhDczgxaUxPMkJlSHJuUU5EeC9rVlRp?=
 =?utf-8?B?R2dCM3JGdnZMdlNmdEVlUGZBYjRMQWdQZ3k3ZEM2UjRrYmt0amdtVnZ6ZFQw?=
 =?utf-8?B?SkwyZ0Y2V3RVNXdQYmxiVDhHQVFlN1ZNblZzOHVzUnQwMU1wTS9ldFBJTzZr?=
 =?utf-8?B?eVA5SE5IcEVRMTJoaUFrOXI2VEVFcjdya1pDN3lGSUlqT1p0emlZN25rdFdW?=
 =?utf-8?B?ai9QZ2txdWNYNnlKZWo3SEtsTVpUb0FaNEZicnBmcW9mRkNxOEhQQ1cxVUo4?=
 =?utf-8?B?b2lQK1JBQ012M0FlNXFuU0FCUkFDaUpONEZLd0tYL2x6ZTRQWnE2T3JaTjR6?=
 =?utf-8?B?WG1GY2pTUE5JaDkyMVJnYnB5UEhtWU8wcUd1aUpkcC83dzhZY1FjckNXYVhU?=
 =?utf-8?B?VUZPMC9IRVJpa0l1dWVua3J3ZEdiZTBLRTlPYkRlZkt2bkhBVTNLd2lFNDBU?=
 =?utf-8?B?NDRJZkxnaUhqRnorZ3dROVgxeG9Meno5dzRzYTh6S2d5UjlZTEpqWUgvVk4w?=
 =?utf-8?B?SWt6TXhsVDZ2Um9VZGF3L3pqcmljdmo0Q0lzVDQ1eC9HQXZ1QVVldWEvRVBZ?=
 =?utf-8?B?QTd4OUt6aWVJZlFtbWh5YUtGRGhVcGhlVlBQWU1WSkR0THpMQnVtY2ZrQlhS?=
 =?utf-8?B?T1AvM1hlRkxyZkVXSE1Ya3ZpT1ltdzJTZ040ZUVUeDlCTjJFT1UzMTFXTlVQ?=
 =?utf-8?B?UmF2NUNlQ1IraUo5Kys1UndMYTBIS1hpSVEveXFsMEMwSWkwMVpXeTlPdjNo?=
 =?utf-8?B?SE1IaFJPWS85YlR5d1dPczR5Rm5JYXRJTWVCNFJNZUVmbDMzWnZVYXRxR0Zp?=
 =?utf-8?B?Uy80ZzEyQTFBMWVrSXdIUzV2d29OUm5FWjBRaFdQb3d5MkRnY3NKNFFZemtB?=
 =?utf-8?B?WHAyTjd5UzFVeXdyaURnSkgzaVRad2R1Z0dUbDJPMVp1NlkxYmxvT1V0L1ov?=
 =?utf-8?B?dlJKZlVpb0dPMC9ERXFDTnFEOTVqd2s0KzZKVWYxbXBTVGtObUhGMVltUFhM?=
 =?utf-8?B?Ny96cTFuaDJ6ZUFUN2MzNGI0WkhYOHZuamRCTmc5Sjh4endBMHBYbzBISkZS?=
 =?utf-8?B?RnNsemxZamdHZGhNOTE4bXU1RlJyMlh3MXYyQzE0SnFaWUJIS1ZVNTNQbE0r?=
 =?utf-8?B?QVV4RXlKdW5KV08xSFhrNHJQOUZ5blVUWGZGTUxZUTFUeW9uRjRheVFXZThv?=
 =?utf-8?B?QVZINDI1M1NhOHlLSEZPdHBGdWtkMFhBS2laUkJPVWVaejFtdkJRVkJGRWJI?=
 =?utf-8?B?WTdCYWk0dnRXaEdic1FkMkRmUVJSVkI4SFZnRzlnUkdtQm9XT1VJRDhpMDBr?=
 =?utf-8?B?RFJCb3JRbjZybWFGenJ4OFB3SlA4T1RsWU9TYTFXU3gzcEdhbzlrSXVSWlN1?=
 =?utf-8?B?d2RmUEpYZVB1ZVJVbk0zS2tKMXg3Y1hCOE82Z1hUUnJmMHFyR21oR3FlU05D?=
 =?utf-8?B?ZkxwdmFOWEswOWZrQXNVQzd6Szk3OUdGc3NuZlcwOTJtb2lpeDAyaDA3S1E2?=
 =?utf-8?Q?lbaO+LQRRNQji?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a7c545-0ba3-41e0-4443-08d9356bb196
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 10:51:30.9730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RXyHsMdXfDCx375noMUrwCoiS3P2HnqzxX4q1opwvJJMpHd/ja9ShLBKPEpNDZTM5jm+FK12IPE/xypsPwLTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5054
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
Cc: Felix.Kuehling@amd.com
Content-Type: multipart/mixed; boundary="===============1154079789=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1154079789==
Content-Type: multipart/alternative;
 boundary="------------F469BF6EA619BFC862265DCB"
Content-Language: en-US

--------------F469BF6EA619BFC862265DCB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/22/2021 12:36 PM, Christian König wrote:
> Am 22.06.21 um 12:30 schrieb Das, Nirmoy:
>>
>> On 6/22/2021 10:36 AM, Christian König wrote:
>>
>>> Am 22.06.21 um 09:39 schrieb Das, Nirmoy:
>>>>
>>>> On 6/22/2021 9:03 AM, Christian König wrote:
>>>>>
>>>>>
>>>>> Am 22.06.21 um 08:57 schrieb Nirmoy Das:
>>>>>> Cleanup code related to vm pasid by adding helper functions.
>>>>>>
>>>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 105 
>>>>>> ++++++++++++-------------
>>>>>>   1 file changed, 50 insertions(+), 55 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> index 63975bda8e76..6e476b173cbb 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>> @@ -87,6 +87,46 @@ struct amdgpu_prt_cb {
>>>>>>       struct dma_fence_cb cb;
>>>>>>   };
>>>>>>
>>>>>> +static int amdgpu_vm_pasid_alloc(struct amdgpu_device *adev,
>>>>>> +                 struct amdgpu_vm *vm,
>>>>>> +                 unsigned int pasid,
>>>>>> +                 unsigned int *vm_pasid)
>>>>>> +{
>>>>>> +    unsigned long flags;
>>>>>> +    int r;
>>>>>> +
>>>>>> +    if (!pasid)
>>>>>> +        return 0;
>>>>>> +
>>>>>> + spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>>> +    r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid 
>>>>>> + 1,
>>>>>> +              GFP_ATOMIC);
>>>>>> + spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>>> +    if (r < 0)
>>>>>> +        return r;
>>>>>> +    if (vm_pasid)
>>>>>> +        *vm_pasid = pasid;
>>>>>> +
>>>>>
>>>>> Ok the more I read from this patch the less it makes sense.
>>>>>
>>>>> We don't allocate the passid here, we just set it up in the idr.
>>>>>
>>>>> What we could do is to replace the idr with an xarray, that would 
>>>>> certainly make more sense than this here.
>>>>
>>>>
>>>> xarray looks great, with that we don't need pasid_lock either.
>>>
>>> You still need the lock to protect against VM destruction while 
>>> looking things up, but you could switch to RCU for this instead.
>>
>>
>> xarray has xa_{lock|unloack}_irqsave() and adev->vm_manager.pasid_xa 
>> will exist till devices's lifetime.
>
> That's just a wrapper around the lock.
>
>> So I am thinking something like:
>>
>> amdgpu_vm_pasid_insert()
>>
>> {
>>
>> ...
>>
>> xa_lock_irqsave(adev->vm_manager.pasids, flags)
>> r = xa_store(&adev->vm_manager.pasids, pasid, vm, GFP_ATOMIC);
>> xa_unlock_irqsave(adev->vm_manager.pasids, flags)
>
> It would be really nice if we could avoid the GFP_ATOMIC here, but not 
> much of a problem since we had that before.


I think it is possible as I think  only amdgpu_vm_handle_fault() runs in 
interrupt context which tries to find a vm ptr not store it.


>
>> }
>>
>> amdgpu_vm_pasid_remove()
>>
>> {
>>
>> ....
>>
>> xa_lock_irqsave(adev->vm_manager.pasids, flags)
>> xa_erase(&adev->vm_manager.pasids, pasid);
>> xa_unlock_irqsave(adev->vm_manager.pasids, flags)
>>
>> }
>>
>>
>> xa_{lock|unloack}_irqsave() can be use while looking up vm ptr for a 
>> pasid.
>>
>>
>> Shouldn't this be enough ?
>>
>
> Yeah I think so.


Great.


Nirmoy

>
> Christian.
>
>>
>> Regards,
>>
>> Nirmoy
>>
>>>
>>> Christian.
>>>
>>>>
>>>>
>>>> Thanks
>>>>
>>>> Nirmoy
>>>>
>>>>
>>>>>
>>>>> Christian.
>>>>>
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void amdgpu_vm_pasid_remove(struct amdgpu_device *adev,
>>>>>> +                   unsigned int pasid,
>>>>>> +                   unsigned int *vm_pasid)
>>>>>> +{
>>>>>> +    unsigned long flags;
>>>>>> +
>>>>>> +    if (!pasid)
>>>>>> +        return;
>>>>>> +
>>>>>> + spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>>> +    idr_remove(&adev->vm_manager.pasid_idr, pasid);
>>>>>> + spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>>> +
>>>>>> +    if (vm_pasid)
>>>>>> +        *vm_pasid = 0;
>>>>>> +}
>>>>>> +
>>>>>>   /*
>>>>>>    * vm eviction_lock can be taken in MMU notifiers. Make sure no 
>>>>>> reclaim-FS
>>>>>>    * happens while holding this lock anywhere to prevent 
>>>>>> deadlocks when
>>>>>> @@ -2940,18 +2980,8 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>>>> *adev, struct amdgpu_vm *vm, u32 pasid)
>>>>>>
>>>>>>       amdgpu_bo_unreserve(vm->root.bo);
>>>>>>
>>>>>> -    if (pasid) {
>>>>>> -        unsigned long flags;
>>>>>> -
>>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>>> -        r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, 
>>>>>> pasid + 1,
>>>>>> -                  GFP_ATOMIC);
>>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>>> -        if (r < 0)
>>>>>> -            goto error_free_root;
>>>>>> -
>>>>>> -        vm->pasid = pasid;
>>>>>> -    }
>>>>>> +    if (amdgpu_vm_pasid_alloc(adev, vm, pasid, &vm->pasid))
>>>>>> +        goto error_free_root;
>>>>>>
>>>>>>       INIT_KFIFO(vm->faults);
>>>>>>
>>>>>> @@ -3038,19 +3068,11 @@ int amdgpu_vm_make_compute(struct 
>>>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>>       r = amdgpu_vm_check_clean_reserved(adev, vm);
>>>>>>       if (r)
>>>>>>           goto unreserve_bo;
>>>>>> +    r = amdgpu_vm_pasid_alloc(adev, vm, pasid, NULL);
>>>>>> +    if (r ==  -ENOSPC)
>>>>>> +        goto unreserve_bo;
>>>>>>
>>>>>> -    if (pasid) {
>>>>>> -        unsigned long flags;
>>>>>> -
>>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>>> -        r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, 
>>>>>> pasid + 1,
>>>>>> -                  GFP_ATOMIC);
>>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>>> -
>>>>>> -        if (r == -ENOSPC)
>>>>>> -            goto unreserve_bo;
>>>>>> -        r = 0;
>>>>>> -    }
>>>>>> +    r = 0;
>>>>>>
>>>>>>       /* Check if PD needs to be reinitialized and do it before
>>>>>>        * changing any other state, in case it fails.
>>>>>> @@ -3089,35 +3111,23 @@ int amdgpu_vm_make_compute(struct 
>>>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>>       vm->is_compute_context = true;
>>>>>>
>>>>>>       if (vm->pasid) {
>>>>>> -        unsigned long flags;
>>>>>> -
>>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>>> -        idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
>>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>>> -
>>>>>>           /* Free the original amdgpu allocated pasid
>>>>>>            * Will be replaced with kfd allocated pasid
>>>>>>            */
>>>>>>           amdgpu_pasid_free(vm->pasid);
>>>>>> -        vm->pasid = 0;
>>>>>> +        amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>>>>>>       }
>>>>>>
>>>>>>       /* Free the shadow bo for compute VM */
>>>>>> amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
>>>>>> -
>>>>>>       if (pasid)
>>>>>>           vm->pasid = pasid;
>>>>>>
>>>>>>       goto unreserve_bo;
>>>>>>
>>>>>>   free_idr:
>>>>>> -    if (pasid) {
>>>>>> -        unsigned long flags;
>>>>>> +    amdgpu_vm_pasid_remove(adev, pasid, NULL);
>>>>>>
>>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>>> -        idr_remove(&adev->vm_manager.pasid_idr, pasid);
>>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>>> -    }
>>>>>>   unreserve_bo:
>>>>>>       amdgpu_bo_unreserve(vm->root.bo);
>>>>>>       return r;
>>>>>> @@ -3133,14 +3143,7 @@ int amdgpu_vm_make_compute(struct 
>>>>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>>>>    */
>>>>>>   void amdgpu_vm_release_compute(struct amdgpu_device *adev, 
>>>>>> struct amdgpu_vm *vm)
>>>>>>   {
>>>>>> -    if (vm->pasid) {
>>>>>> -        unsigned long flags;
>>>>>> -
>>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>>> -        idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
>>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>>> -    }
>>>>>> -    vm->pasid = 0;
>>>>>> +    amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>>>>>>       vm->is_compute_context = false;
>>>>>>   }
>>>>>>
>>>>>> @@ -3164,15 +3167,7 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>>>> *adev, struct amdgpu_vm *vm)
>>>>>>
>>>>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>>>>       amdgpu_bo_reserve(root, true);
>>>>>> -    if (vm->pasid) {
>>>>>> -        unsigned long flags;
>>>>>> -
>>>>>> - spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>>>>>> -        idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
>>>>>> - spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>>>>>> -        vm->pasid = 0;
>>>>>> -    }
>>>>>> -
>>>>>> +    amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
>>>>>>       dma_fence_wait(vm->last_unlocked, false);
>>>>>>       dma_fence_put(vm->last_unlocked);
>>>>>>
>>>>>> -- 
>>>>>> 2.32.0
>>>>>>
>>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C3285a973b5a4498f3b0608d93558d909%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637599478002028860%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=QLv4hbUpPF9H%2BVL4eOQlTeROWQA%2FG1LrPGFBzCQRt7o%3D&amp;reserved=0 
>>>>
>>>
>

--------------F469BF6EA619BFC862265DCB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/22/2021 12:36 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c28d9c08-0ab8-780a-ae44-e444ae49500e@gmail.com">
      
      Am 22.06.21 um 12:30 schrieb Das, Nirmoy:<br>
      <blockquote type="cite" cite="mid:564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com">
        <p>On 6/22/2021 10:36 AM, Christian König wrote:<br>
        </p>
        <blockquote type="cite" cite="mid:9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com">Am
          22.06.21 um 09:39 schrieb Das, Nirmoy: <br>
          <blockquote type="cite"> <br>
            On 6/22/2021 9:03 AM, Christian König wrote: <br>
            <blockquote type="cite"> <br>
              <br>
              Am 22.06.21 um 08:57 schrieb Nirmoy Das: <br>
              <blockquote type="cite">Cleanup code related to vm pasid
                by adding helper functions. <br>
                <br>
                Signed-off-by: Nirmoy Das <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.das@amd.com" moz-do-not-send="true">&lt;nirmoy.das@amd.com&gt;</a>
                <br>
                --- <br>
                &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 105
                ++++++++++++------------- <br>
                &nbsp; 1 file changed, 50 insertions(+), 55 deletions(-) <br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
                index 63975bda8e76..6e476b173cbb 100644 <br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
                @@ -87,6 +87,46 @@ struct amdgpu_prt_cb { <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence_cb cb; <br>
                &nbsp; }; <br>
                <br>
                +static int amdgpu_vm_pasid_alloc(struct amdgpu_device
                *adev, <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm, <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pasid, <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *vm_pasid) <br>
                +{ <br>
                +&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                +&nbsp;&nbsp;&nbsp; int r; <br>
                + <br>
                +&nbsp;&nbsp;&nbsp; if (!pasid) <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
                + <br>
                +&nbsp;&nbsp;&nbsp;
                spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                +&nbsp;&nbsp;&nbsp; r = idr_alloc(&amp;adev-&gt;vm_manager.pasid_idr,
                vm, pasid, pasid + 1, <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC); <br>
                +
                spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                +&nbsp;&nbsp;&nbsp; if (r &lt; 0) <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
                +&nbsp;&nbsp;&nbsp; if (vm_pasid) <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vm_pasid = pasid; <br>
                + <br>
              </blockquote>
              <br>
              Ok the more I read from this patch the less it makes
              sense. <br>
              <br>
              We don't allocate the passid here, we just set it up in
              the idr. <br>
              <br>
              What we could do is to replace the idr with an xarray,
              that would certainly make more sense than this here. <br>
            </blockquote>
            <br>
            <br>
            xarray looks great, with that we don't need pasid_lock
            either. <br>
          </blockquote>
          <br>
          You still need the lock to protect against VM destruction
          while looking things up, but you could switch to RCU for this
          instead. <br>
        </blockquote>
        <p><br>
        </p>
        <font face="Helvetica, Arial, sans-serif">xarray has <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;">xa_{lock|unloack}_irqsave()
            and </span><span style="color: rgb(0, 0, 0); font-size:
            16px; font-style: normal; font-variant-ligatures: normal;
            font-variant-caps: normal; font-weight: 400; letter-spacing:
            normal; text-align: start; text-indent: 0px; text-transform:
            none; white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasid_xa
            will exist till devices's lifetime.</span></font></blockquote>
      <br>
      That's just a wrapper around the lock.<br>
      <br>
      <blockquote type="cite" cite="mid:564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com"><font face="Helvetica, Arial, sans-serif"><span style="color: rgb(0,
            0, 0); font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;
            background-color: rgb(252, 252, 252);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;">So I am thinking something like:<br>
          </span><br>
        </font>
        <p><font face="Helvetica, Arial, sans-serif">amdgpu_vm_pasid_insert()
            <br>
          </font></p>
        <p><font face="Helvetica, Arial, sans-serif">{</font></p>
        <p><font face="Helvetica, Arial, sans-serif">...<br>
          </font></p>
        <font face="Helvetica, Arial, sans-serif"><span style="color:
            rgb(0, 0, 0); font-size: 16px; font-style: normal;
            font-variant-ligatures: normal; font-variant-caps: normal;
            font-weight: 400; letter-spacing: normal; text-align: start;
            text-indent: 0px; text-transform: none; white-space: normal;
            word-spacing: 0px; -webkit-text-stroke-width: 0px;
            background-color: rgb(252, 252, 252);
            text-decoration-thickness: initial; text-decoration-style:
            initial; text-decoration-color: initial; display: inline
            !important; float: none;"> <span style="color: rgb(0, 0,
              0); font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">xa_lock_irqsave(</span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasids,
              flags)</span></span><br>
          <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">r =
              xa_store(&amp;adev-&gt;vm_manager.pasids, pasid, vm,
              GFP_ATOMIC);</span></span><br>
          <span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"> <span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;"></span></span></span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
            normal; font-variant-ligatures: normal; font-variant-caps:
            normal; font-weight: 400; letter-spacing: normal;
            text-align: start; text-indent: 0px; text-transform: none;
            white-space: normal; word-spacing: 0px;
            -webkit-text-stroke-width: 0px; background-color: rgb(252,
            252, 252); text-decoration-thickness: initial;
            text-decoration-style: initial; text-decoration-color:
            initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
              normal; font-variant-ligatures: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">xa_unlock_irqsave(</span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasids,
                  flags)</span></span></span></span></font></blockquote>
      <br>
      It would be really nice if we could avoid the GFP_ATOMIC here, but
      not much of a problem since we had that before.<br>
    </blockquote>
    <p><br>
    </p>
    <p>I think it is possible as I think&nbsp; only amdgpu_vm_handle_fault()
      runs in interrupt context which tries to find a vm ptr not store
      it.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:c28d9c08-0ab8-780a-ae44-e444ae49500e@gmail.com"> <br>
      <blockquote type="cite" cite="mid:564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com">
        <p><font face="Helvetica, Arial, sans-serif"><span style="color:
              rgb(0, 0, 0); font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"></span>}</font></p>
        <p><font face="Helvetica, Arial, sans-serif"><span style="color:
              rgb(0, 0, 0); font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">amdgpu_vm_pasid_remove()</span></span></span></font></p>
        <p><font face="Helvetica, Arial, sans-serif"><span style="color:
              rgb(0, 0, 0); font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">{</span></span></span></font></p>
        <p><font face="Helvetica, Arial, sans-serif"><span style="color:
              rgb(0, 0, 0); font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">....<br>
                </span></span></span></font></p>
        <p><font face="Helvetica, Arial, sans-serif"><span style="color:
              rgb(0, 0, 0); font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">xa_lock_irqsave(</span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">adev-&gt;vm_manager.pasids,
                  flags)</span></span><br>
              <span style="color: rgb(0, 0, 0); font-size: 16px;
                font-style: normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;">xa_erase(&amp;adev-&gt;vm_manager.pasids,
                  pasid);</span></span><br>
              <span style="color: rgb(0, 0, 0); font-size: 16px;
                font-style: normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                    font-style: normal; font-variant-ligatures: normal;
                    font-variant-caps: normal; font-weight: 400;
                    letter-spacing: normal; text-align: start;
                    text-indent: 0px; text-transform: none; white-space:
                    normal; word-spacing: 0px;
                    -webkit-text-stroke-width: 0px; background-color:
                    rgb(252, 252, 252); text-decoration-thickness:
                    initial; text-decoration-style: initial;
                    text-decoration-color: initial; display: inline
                    !important; float: none;"> <span style="color:
                      rgb(0, 0, 0); font-size: 16px; font-style: normal;
                      font-variant-ligatures: normal; font-variant-caps:
                      normal; font-weight: 400; letter-spacing: normal;
                      text-align: start; text-indent: 0px;
                      text-transform: none; white-space: normal;
                      word-spacing: 0px; -webkit-text-stroke-width: 0px;
                      background-color: rgb(252, 252, 252);
                      text-decoration-thickness: initial;
                      text-decoration-style: initial;
                      text-decoration-color: initial; display: inline
                      !important; float: none;"></span></span></span></span><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                  font-style: normal; font-variant-ligatures: normal;
                  font-variant-caps: normal; font-weight: 400;
                  letter-spacing: normal; text-align: start;
                  text-indent: 0px; text-transform: none; white-space:
                  normal; word-spacing: 0px; -webkit-text-stroke-width:
                  0px; background-color: rgb(252, 252, 252);
                  text-decoration-thickness: initial;
                  text-decoration-style: initial; text-decoration-color:
                  initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px;
                    font-style: normal; font-variant-ligatures: normal;
                    font-variant-caps: normal; font-weight: 400;
                    letter-spacing: normal; text-align: start;
                    text-indent: 0px; text-transform: none; white-space:
                    normal; word-spacing: 0px;
                    -webkit-text-stroke-width: 0px; background-color:
                    rgb(252, 252, 252); text-decoration-thickness:
                    initial; text-decoration-style: initial;
                    text-decoration-color: initial; display: inline
                    !important; float: none;"><span style="color: rgb(0,
                      0, 0); font-size: 16px; font-style: normal;
                      font-variant-ligatures: normal; font-variant-caps:
                      normal; font-weight: 400; letter-spacing: normal;
                      text-align: start; text-indent: 0px;
                      text-transform: none; white-space: normal;
                      word-spacing: 0px; -webkit-text-stroke-width: 0px;
                      background-color: rgb(252, 252, 252);
                      text-decoration-thickness: initial;
                      text-decoration-style: initial;
                      text-decoration-color: initial; display: inline
                      !important; float: none;">xa_unlock_irqsave(</span></span><span style="color: rgb(0, 0, 0); font-size: 16px;
                    font-style: normal; font-variant-ligatures: normal;
                    font-variant-caps: normal; font-weight: 400;
                    letter-spacing: normal; text-align: start;
                    text-indent: 0px; text-transform: none; white-space:
                    normal; word-spacing: 0px;
                    -webkit-text-stroke-width: 0px; background-color:
                    rgb(252, 252, 252); text-decoration-thickness:
                    initial; text-decoration-style: initial;
                    text-decoration-color: initial; display: inline
                    !important; float: none;"><span style="color: rgb(0,
                      0, 0); font-size: 16px; font-style: normal;
                      font-variant-ligatures: normal; font-variant-caps:
                      normal; font-weight: 400; letter-spacing: normal;
                      text-align: start; text-indent: 0px;
                      text-transform: none; white-space: normal;
                      word-spacing: 0px; -webkit-text-stroke-width: 0px;
                      background-color: rgb(252, 252, 252);
                      text-decoration-thickness: initial;
                      text-decoration-style: initial;
                      text-decoration-color: initial; display: inline
                      !important; float: none;">adev-&gt;vm_manager.pasids,
                      flags)</span></span></span></span> </span></font></p>
        <p><font face="Helvetica, Arial, sans-serif"><span style="color:
              rgb(0, 0, 0); font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;">}</span></font></p>
        <p><font face="Helvetica, Arial, sans-serif"><br>
            <span style="color: rgb(0, 0, 0); font-size: 16px;
              font-style: normal; font-variant-ligatures: normal;
              font-variant-caps: normal; font-weight: 400;
              letter-spacing: normal; text-align: start; text-indent:
              0px; text-transform: none; white-space: normal;
              word-spacing: 0px; -webkit-text-stroke-width: 0px;
              background-color: rgb(252, 252, 252);
              text-decoration-thickness: initial; text-decoration-style:
              initial; text-decoration-color: initial; display: inline
              !important; float: none;"> <span style="color: rgb(0, 0,
                0); font-size: 16px; font-style: normal;
                font-variant-ligatures: normal; font-variant-caps:
                normal; font-weight: 400; letter-spacing: normal;
                text-align: start; text-indent: 0px; text-transform:
                none; white-space: normal; word-spacing: 0px;
                -webkit-text-stroke-width: 0px; background-color:
                rgb(252, 252, 252); text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;">xa_{lock|unloack}_irqsave()
                can be use while looking up vm ptr for a pasid.</span></span></font></p>
        <p><font face="Helvetica, Arial, sans-serif"><span style="color:
              rgb(0, 0, 0); font-size: 16px; font-style: normal;
              font-variant-ligatures: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; text-align:
              start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; background-color: rgb(252,
              252, 252); text-decoration-thickness: initial;
              text-decoration-style: initial; text-decoration-color:
              initial; display: inline !important; float: none;"><span style="color: rgb(0, 0, 0); font-size: 16px; font-style:
                normal; font-variant-ligatures: normal;
                font-variant-caps: normal; font-weight: 400;
                letter-spacing: normal; text-align: start; text-indent:
                0px; text-transform: none; white-space: normal;
                word-spacing: 0px; -webkit-text-stroke-width: 0px;
                background-color: rgb(252, 252, 252);
                text-decoration-thickness: initial;
                text-decoration-style: initial; text-decoration-color:
                initial; display: inline !important; float: none;"><br>
              </span> </span></font></p>
        <font face="Helvetica, Arial, sans-serif"> </font>
        <p><font face="Helvetica, Arial, sans-serif">Shouldn't this be
            enough ?</font></p>
      </blockquote>
      <br>
      Yeah I think so.<br>
    </blockquote>
    <p><br>
    </p>
    <p>Great.<br>
    </p>
    <p><br>
    </p>
    <p>Nirmoy<br>
    </p>
    <blockquote type="cite" cite="mid:c28d9c08-0ab8-780a-ae44-e444ae49500e@gmail.com"> <br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:564b4de5-b1fd-283e-85b8-7819c24bca10@amd.com">
        <p><font face="Helvetica, Arial, sans-serif"><br>
          </font></p>
        <p><font face="Helvetica, Arial, sans-serif">Regards,</font></p>
        <p><font face="Helvetica, Arial, sans-serif">Nirmoy</font><br>
        </p>
        <blockquote type="cite" cite="mid:9ff705c2-a4e4-dc37-041a-66c490d8f7ad@gmail.com"> <br>
          Christian. <br>
          <br>
          <blockquote type="cite"> <br>
            <br>
            Thanks <br>
            <br>
            Nirmoy <br>
            <br>
            <br>
            <blockquote type="cite"> <br>
              Christian. <br>
              <br>
              <blockquote type="cite">+&nbsp;&nbsp;&nbsp; return 0; <br>
                +} <br>
                + <br>
                +static void amdgpu_vm_pasid_remove(struct amdgpu_device
                *adev, <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pasid, <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *vm_pasid) <br>
                +{ <br>
                +&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                + <br>
                +&nbsp;&nbsp;&nbsp; if (!pasid) <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return; <br>
                + <br>
                +&nbsp;&nbsp;&nbsp;
                spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                +&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
                pasid); <br>
                +
                spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                + <br>
                +&nbsp;&nbsp;&nbsp; if (vm_pasid) <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vm_pasid = 0; <br>
                +} <br>
                + <br>
                &nbsp; /* <br>
                &nbsp;&nbsp; * vm eviction_lock can be taken in MMU notifiers.
                Make sure no reclaim-FS <br>
                &nbsp;&nbsp; * happens while holding this lock anywhere to prevent
                deadlocks when <br>
                @@ -2940,18 +2980,8 @@ int amdgpu_vm_init(struct
                amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid) <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo); <br>
                <br>
                -&nbsp;&nbsp;&nbsp; if (pasid) { <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                - <br>
                - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                idr_alloc(&amp;adev-&gt;vm_manager.pasid_idr, vm, pasid,
                pasid + 1, <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC); <br>
                -
                spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt; 0) <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_root; <br>
                - <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pasid = pasid; <br>
                -&nbsp;&nbsp;&nbsp; } <br>
                +&nbsp;&nbsp;&nbsp; if (amdgpu_vm_pasid_alloc(adev, vm, pasid,
                &amp;vm-&gt;pasid)) <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_root; <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_KFIFO(vm-&gt;faults); <br>
                <br>
                @@ -3038,19 +3068,11 @@ int
                amdgpu_vm_make_compute(struct amdgpu_device *adev,
                struct amdgpu_vm *vm, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_check_clean_reserved(adev, vm); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo; <br>
                +&nbsp;&nbsp;&nbsp; r = amdgpu_vm_pasid_alloc(adev, vm, pasid, NULL); <br>
                +&nbsp;&nbsp;&nbsp; if (r ==&nbsp; -ENOSPC) <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo; <br>
                <br>
                -&nbsp;&nbsp;&nbsp; if (pasid) { <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                - <br>
                - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                idr_alloc(&amp;adev-&gt;vm_manager.pasid_idr, vm, pasid,
                pasid + 1, <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_ATOMIC); <br>
                -
                spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                - <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r == -ENOSPC) <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo; <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0; <br>
                -&nbsp;&nbsp;&nbsp; } <br>
                +&nbsp;&nbsp;&nbsp; r = 0; <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if PD needs to be reinitialized and do it
                before <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * changing any other state, in case it fails. <br>
                @@ -3089,35 +3111,23 @@ int
                amdgpu_vm_make_compute(struct amdgpu_device *adev,
                struct amdgpu_vm *vm, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;is_compute_context = true; <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;pasid) { <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                - <br>
                - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
                vm-&gt;pasid); <br>
                -
                spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                - <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Free the original amdgpu allocated pasid <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Will be replaced with kfd allocated pasid <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_pasid_free(vm-&gt;pasid); <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pasid = 0; <br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pasid_remove(adev, vm-&gt;pasid,
                &amp;vm-&gt;pasid); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Free the shadow bo for compute VM */ <br>
amdgpu_bo_unref(&amp;to_amdgpu_bo_vm(vm-&gt;root.bo)-&gt;shadow); <br>
                - <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pasid) <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pasid = pasid; <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto unreserve_bo; <br>
                <br>
                &nbsp; free_idr: <br>
                -&nbsp;&nbsp;&nbsp; if (pasid) { <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                +&nbsp;&nbsp;&nbsp; amdgpu_vm_pasid_remove(adev, pasid, NULL); <br>
                <br>
                - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
                pasid); <br>
                -
                spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp; } <br>
                &nbsp; unreserve_bo: <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
                @@ -3133,14 +3143,7 @@ int amdgpu_vm_make_compute(struct
                amdgpu_device *adev, struct amdgpu_vm *vm, <br>
                &nbsp;&nbsp; */ <br>
                &nbsp; void amdgpu_vm_release_compute(struct amdgpu_device
                *adev, struct amdgpu_vm *vm) <br>
                &nbsp; { <br>
                -&nbsp;&nbsp;&nbsp; if (vm-&gt;pasid) { <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                - <br>
                - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
                vm-&gt;pasid); <br>
                -
                spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp; } <br>
                -&nbsp;&nbsp;&nbsp; vm-&gt;pasid = 0; <br>
                +&nbsp;&nbsp;&nbsp; amdgpu_vm_pasid_remove(adev, vm-&gt;pasid,
                &amp;vm-&gt;pasid); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;is_compute_context = false; <br>
                &nbsp; } <br>
                <br>
                @@ -3164,15 +3167,7 @@ void amdgpu_vm_fini(struct
                amdgpu_device *adev, struct amdgpu_vm *vm) <br>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root = amdgpu_bo_ref(vm-&gt;root.bo); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(root, true); <br>
                -&nbsp;&nbsp;&nbsp; if (vm-&gt;pasid) { <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags; <br>
                - <br>
                - spin_lock_irqsave(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_remove(&amp;adev-&gt;vm_manager.pasid_idr,
                vm-&gt;pasid); <br>
                -
                spin_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasid_lock,
                flags); <br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;pasid = 0; <br>
                -&nbsp;&nbsp;&nbsp; } <br>
                - <br>
                +&nbsp;&nbsp;&nbsp; amdgpu_vm_pasid_remove(adev, vm-&gt;pasid,
                &amp;vm-&gt;pasid); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_wait(vm-&gt;last_unlocked, false); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(vm-&gt;last_unlocked); <br>
                <br>
                --&nbsp;<br>
                2.32.0 <br>
                <br>
              </blockquote>
              <br>
            </blockquote>
            _______________________________________________ <br>
            amd-gfx mailing list <br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a> <br>
            <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7Cb2e4767f6d044494535808d9356992b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637599549822932980%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=IIysPahKlRK1d6Ak5BtEQbt5%2Bjowly3bZjc3hrCSgW0%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="Pzz6jS7Edf37CYaZZGHdcKlEkCb2J9R9LjLq3W0z4pjZ40b2HmxuFYZIIihmW4LPqUWxJFAgOKwZuYzYAcvO45icuqAo/h7H304uHAIewURbuKeTPT4mQuXEvb/c0azyn546ZvRQZmxPVy6zAkj9uHIlo5HDL/aivvzjqNhvF8c=" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C3285a973b5a4498f3b0608d93558d909%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
 637599478002028860%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=QLv4hbUpPF9H%2BVL4eOQlTeROWQA%2FG1LrPGFBzCQRt7o%3D&amp;amp;reserved=0</a>
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------F469BF6EA619BFC862265DCB--

--===============1154079789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1154079789==--
