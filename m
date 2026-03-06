Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9329BF01818
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 09:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2510210E0BA;
	Fri,  6 Mar 2026 09:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="01rTNzYD";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3B610E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 09:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcJmkiEnJUoMOE8dieX4KPjM8r2mB24soKgHFT8XodE3K+1PFQNGn168GS25u6XVNSXgz6vyZJ/r/bLccUsfQTFw9tZjVRuJUCYHEB6812ZZa/3TTFHaNVUn8g0v3o1twIrXvRXh9TlG1rRd7TNRA4U5cPi/mjUfh1OJr9hXJNL3h75X41qdnO4/DzJkNIBuRnR6GsfdhmlntfdIcjUjRqZ/Ju4F78PlmFSI2QgMV24ln6z5Xd+0hcKmyNQ40Sz94sVlC0YELznx3gkqUdpxbSn1AweMH5C2b737JYsWMAi2JWnscB4XYBetD6kcRS4f7WTaXklI2CtHeduE8f5X+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tpOgNziwsRNd/K7xsJ76PiR3nmuaDN64MhDQ8hUE1Q=;
 b=KRgTZUg3rJGDlStIks/zPi/94SGE7mUiwWFNQ3c8Tw0uGa+s+qV6kOOyr/Xtl9uW7N56AxeM2MiWQz0sZWZy3AELA3ycoJzDrWgyeh1s8YFq4cxBxr1vXWaT7TAStQf8lA11/ThWvO/zfWAtuiyb6e9rQDCybiPUdcaKPi2dg2zPpWGt72KPxgj0QSSDkB7b+HOXh/hsvS5owIOToSrcrbldWlQ4bxZkHXnkMco5HSxEsVQy1AauG4/R2M800Rr3k/BN9KqXYfiJOQ2A3plj7WtmM5vLkVp4BcqZdgUuo3WwEp9gmq/6bdBSgXoWNmR4ADKn486QOUixUOvqfEWyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tpOgNziwsRNd/K7xsJ76PiR3nmuaDN64MhDQ8hUE1Q=;
 b=01rTNzYD+ZXI2+MCbIi3qbvg8VRcT9zNacw1L16aawR44NuMsH3gR3OUTwspZ5aHNFIV77kRKgmbIYjp6OuTf83fVegwv7PNxP0r3cCUn6xk4+lZXvjxF/7zUOVGH3YFkNSiwOIdAUEPjWYK4HutyBtiueEsn8b+dG5gFypZk60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:40:04 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 09:40:04 +0000
Message-ID: <eb10b124-7b4e-4e96-8da0-06f90c35bd81@amd.com>
Date: Fri, 6 Mar 2026 15:09:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] drm/amdgpu/userq: defer queue publication until
 create completes
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260306080417.1798029-1-sunil.khatri@amd.com>
 <d7552977-3152-4744-85b9-987df7402778@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <d7552977-3152-4744-85b9-987df7402778@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0105.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: b3dfe3e9-0ec2-4b2a-1247-08de7b645854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: ypQfD84dPYZk0H+WJR615Fc/szQz+yXetm6irmN0wLkaxLwDkMkRv81+X/EvLgZIkxQaxFhylLVHGJwgcvxSgSeoAZZ4Fm3yBcqbX0QlqeG5KEHwjPsAcWeGvApuUaw/lSUbFw0p5YpOKbJTGrklWIHTgxJ3LH1p4X//bpM8u7fDQ6ZhqSdCEshqPZhcq/gOfw3roi0SNr1wRDfYvWcHGG7uGpVf7NEM13WUDA7Pe1RLg+5BlS4NcyHf+yAdSqwvP6B0a3XTGBR2dG8U0LZiOIxnvNgEtSzqJuBfz17gFWhJZ8XGHKjb7HIyAxPLRYUiNoi26T48UbR2ozAl5nNhmQZ0TX/9WrnSB/x1hqm1OJsIBPn/jYOZ7b67wK/j31Oxc5i4AqY6+t9G+/6rtH34fxQwbzjQ9C+BiyNmzrUfSrwoXDty5TzK3MvhpLrxnDwQDu4WcLQ3Yzf0WgpzYl89MSKogMF6rZzv+Q09heOqwhYwYj9SyRkgV8hIj/Gj8mV5VmxYZHtTnaaE3PnAxOmbBy1ekMlMX8wVG4nXZ07+SR+IPnl+GWjHL/wlL+vjIkTdyzfpkrMZd8EwjZY1AvQ2gjpX3z+O0Zrxyg4rwS+rdqzfyHmtpGo5kBh571Z2Mb0yjfh5YCBHGdqTsFemUFqai/scoNqu9EMXiDxd/0c2kD/hJvOymmpkpK2Hb9KEstg6QWJtzOlop7ZX9tpoZqBU/s3d9U+kYpRbPjQz171dGqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTdEWXpzYjNnZjN2Vmpoa1NZRW9RemdwRXowc2F0QjVuelVMd0gwcU9vaFR6?=
 =?utf-8?B?UE85VlpLQTJzczhYRE5FNGFYalFhTTFVMCt2NzZSbUlYK2duMmlYWXdabXZw?=
 =?utf-8?B?R1d6QXdRcXpRS0Qvb0VWTXZFT1MvMEsvcHZRRjc3WlY4ZzhyUS8zU2t1ZjBB?=
 =?utf-8?B?QSsxRGJrb1MyU3BiYWYzVnMvNXNqQ2hHclV5TUFzMlV2eDdYVGk3cTBVdUl4?=
 =?utf-8?B?ZFN6dkpjRkEvNGsvZDJIU29oZytacU1QKzZiQTc3NExCQnZUa3dXOWtJOFAv?=
 =?utf-8?B?eDNtdzE2QW1SZjV3SURveGxkdWx6UTlsbi9MOUhZRHVKenQrdGtxZ0NNbGtU?=
 =?utf-8?B?TVNYamRPR0ZTRmErMXdRZ3o4bUo1M00yTzRpODV5K3poQ1hEY0dSS1pKcUdm?=
 =?utf-8?B?eW5QOGtFVERETmlDOFRGOU9JUTJBQjVzcTVBOWsza0p1aWIySEdEait5ZG8r?=
 =?utf-8?B?WE52RTZGaGlmN1g2ZFloL3VXK25rYmlGNUFQNGlHS1FuNHJORmplZDBRcHJT?=
 =?utf-8?B?SlErMjRmYlVhVzJ3QU10Vjk0SVZlQ1NiTHFMWlNoQmttK0QvaDlpSUgxVWRH?=
 =?utf-8?B?c1h4ZzZHUXNLdnBDd1NwV3hKS2R6Q1YvMzhaY1BPV3JRanlSZjhiR2MrZ09G?=
 =?utf-8?B?WHo2WkpaUnRGTjBMdFZ6VlhOMHh1WVBsd21rd3lUeDlHSld1WFM1Rnd5VmJP?=
 =?utf-8?B?UzBmMHJHZ0dyS09iNUxVOVcvMGdlMmtQWWZSWmhjZkx5UVBrYzVIV1E3UGZC?=
 =?utf-8?B?M1J2YTcvOEplWEQvZnJ3RlF4VUp6MWIwSFA5Ykc1ZzBHMXNkdUhNalh1dlZo?=
 =?utf-8?B?WkNsVjBaelpSTzdCK3lsRFFyU3VMTmgxKy9MWlhzK0xNZDJ4QW1HRzFTbDBw?=
 =?utf-8?B?M2JzcituSXJNQzNmNWZSZEg2enh4R0hOUEdGdW12bUZtRFd2WG96Z0QrT2ND?=
 =?utf-8?B?cUhiRDloblBweGxmM3RyV0M2WS83SWtFTnJXdGdoN21aWjZSSUFRQ1NaV0Jz?=
 =?utf-8?B?clhBeWRld2ZXVnFUdXRBN3drdnFGYVRIUkF5MUZKeUtLYkxzYndNQk8zelRQ?=
 =?utf-8?B?dGVhTWdDNjhFNDJVekZhTnZPVTZwYysweFVSWkpYMGRjZm85ZmYrWXZoalRw?=
 =?utf-8?B?bmFUVWN1N1ZvMG4vV2Z0SHJ0ZnlYQmg3Vm1SNjRkZjMrUnhwbTdwaXdXb2sw?=
 =?utf-8?B?eDZhRkNnbVA0M09ISGZhZ1VTaFhRdWRlaERIbkJBQTluTStpaW5BSmxTL1VR?=
 =?utf-8?B?SDJGWWs4c0hTVy82TXNoQy9xOGtjK2JOb0ttb3YzVjRpRm9vc1ZhQ1hEOGZO?=
 =?utf-8?B?K0c0b1labTVsbHlRSHU0ankzZi8wOE9QeXhIdkdWS2djUE05S2VaeDVqSXk2?=
 =?utf-8?B?YzhFQ09jWmJ5cUQzMVg0ektOZnI4bVM0VzM0aFMrcXJEZGIrY2ZjaUhnLzRJ?=
 =?utf-8?B?dENUTWJXWGNCVXovQkhLYmpyODBtSnZrNll0RUduK09rdXQzRTVUdHIvSWpJ?=
 =?utf-8?B?T2tIZDc1ZzVaM21COEVZK2U3NDBGUFhqNTVwMm9vK1Z6ZWlDQ3EyZkR6ZlJU?=
 =?utf-8?B?SkFrQjhMbmxwTWNqWVZQTHovSXlYTDJRMkJzNjBmdVVDS3I2NXZNK0UxcVNH?=
 =?utf-8?B?Sy9lSllzYk94NlZMbDk1UUhtSnhIN3RBa1RtckJMa0swVC9jT1p3QTRaOEFn?=
 =?utf-8?B?UlNwK0d3bTNTc292ZnJmMzlsYWRWM2NXazZvUWpnbSs2TG1taDJadzB3d0t5?=
 =?utf-8?B?UWF2MGR2Nks1bXFYQW9BRVlKN0o4K0taOVROREI5YXM1cVVPdnZLdWFrV0FB?=
 =?utf-8?B?ZS9FLzNDVHkxWDJaVURhcExqVXc5QUdCVjJrNHVYMUdLeEhPcjFhbW5IRHN1?=
 =?utf-8?B?djBpaGVmMWxTTzNtTElpNEdhM3Fsdjd1clIxeG9kMmVVV2hBbndFL05rVzlG?=
 =?utf-8?B?VEVBaWR4MU5mOFcxb25aa3BJT1UrUTBwYlJxcXd4anJaWllIbDRUdDAvb25x?=
 =?utf-8?B?YW53M3JmN0E4ODNYSzZQeUVLRHBBNy9ONWUyVGF6YThDRW4ycFJqZ25YWFNC?=
 =?utf-8?B?eVNKR2dkWGJTRTZ0U01ZZlQzUnBZMndwVFJ3TmxJMEQ3VW5IeVhXdXlKOW91?=
 =?utf-8?B?QmtCbkhkOE5qdzZTN1NzVzZrWmt6ckJ4NWVCNkhFMHJZZzl1QWpudk95YXZQ?=
 =?utf-8?B?cThQZ1ovUDE2elVobUhQb2w1cnB1WlBsSWRiR3dKMlhkZktjM0VSd0hLSkR2?=
 =?utf-8?B?L1J1ZjFnVHB3QXhIV1MvTXVmQjk0ZXk2cWNqUC96L3ZCczlsLzF1NytiN0dT?=
 =?utf-8?B?Wndka1FURzB6bTZiTU12cTlmTnlFWi9OcURSM3pZKzRRNFo2RDQ3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dfe3e9-0ec2-4b2a-1247-08de7b645854
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:40:04.5894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dLadKEcwAbmNu+rDbgKQHpegMZW+Mczegu+n6HGAXfTbGOGgA5j55qiTdG9GfeQdezvmgwnTVfsYrM3bh4xZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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


On 06-03-2026 02:51 pm, Christian König wrote:
> On 3/6/26 09:04, Sunil Khatri wrote:
>> The userq create path publishes queues to global xarrays such as
>> userq_doorbell_xa and userq_xa before creation was fully complete.
>> Later on if create queue fails, teardown could free an already
>> visible queue, opening a UAF race with concurrent queue walkers.
>> Also calling amdgpu_userq_put in such cases complicates the cleanup.
>>
>> Solution is to defer queue publication until create succeeds and no
>> partially initialized queue is exposed.
> Good work.
Thanks.
>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 67 ++++++++++++-----------
>>   1 file changed, 34 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 7d2f78899c47..937403beacdc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -758,7 +758,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	const struct amdgpu_userq_funcs *uq_funcs;
>>   	struct amdgpu_usermode_queue *queue;
>>   	struct amdgpu_db_info db_info;
>> -	char *queue_name;
>>   	bool skip_map_queue;
>>   	u32 qid;
>>   	uint64_t index;
>> @@ -848,32 +847,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		goto unlock;
>>   	}
>>   
>> -	/* drop this refcount during queue destroy */
>> -	kref_init(&queue->refcount);
>> -
>> -	/* Wait for mode-1 reset to complete */
>> -	down_read(&adev->reset_domain->sem);
>> -	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
>> -	if (r) {
>> -		kfree(queue);
>> -		up_read(&adev->reset_domain->sem);
>> -		goto unlock;
>> -	}
>> -
>> -	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
>> -		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
>> -	if (r) {
>> -		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
>> -		amdgpu_userq_fence_driver_free(queue);
>> -		xa_erase_irq(&adev->userq_doorbell_xa, index);
>> -		uq_funcs->mqd_destroy(queue);
>> -		kfree(queue);
>> -		r = -ENOMEM;
>> -		up_read(&adev->reset_domain->sem);
>> -		goto unlock;
>> -	}
>> -	up_read(&adev->reset_domain->sem);
>> -
>>   	/* don't map the queue if scheduling is halted */
>>   	if (adev->userq_halt_for_enforce_isolation &&
>>   	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>> @@ -885,28 +858,56 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		r = amdgpu_userq_map_helper(queue);
>>   		if (r) {
>>   			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>> -			xa_erase_irq(&adev->userq_doorbell_xa, index);
>> -			xa_erase(&uq_mgr->userq_xa, qid);
>> -			amdgpu_userq_fence_driver_free(queue);
>>   			uq_funcs->mqd_destroy(queue);
>> +			amdgpu_userq_fence_driver_free(queue);
>>   			kfree(queue);
>>   			goto unlock;
>>   		}
>>   	}
>>   
>> -	queue_name = kasprintf(GFP_KERNEL, "queue-%d", qid);
>> -	if (!queue_name) {
>> +	/* drop this refcount during queue destroy */
>> +	kref_init(&queue->refcount);
>> +
>> +	/* Wait for mode-1 reset to complete */
>> +	down_read(&adev->reset_domain->sem);
>> +	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
>> +		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
>> +	if (r) {
>> +		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
> This should actually not be printed in the logs. At maximum it is a debug message.
Noted. Will remove this.
>
>> +		if (!skip_map_queue)
>> +			amdgpu_userq_unmap_helper(queue);
>> +
>> +		uq_funcs->mqd_destroy(queue);
>> +		amdgpu_userq_fence_driver_free(queue);
>> +		kfree(queue);
>>   		r = -ENOMEM;
>> +		up_read(&adev->reset_domain->sem);
> I was just about to write that this screams for goto error handling and then saw that you do exactly that in patch #2.
>
>>   		goto unlock;
>>   	}
>>   
>> +	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
>> +	if (r) {
>> +		xa_erase(&uq_mgr->userq_xa, qid);
>> +		if (!skip_map_queue)
>> +			amdgpu_userq_unmap_helper(queue);
>> +
>> +		uq_funcs->mqd_destroy(queue);
>> +		amdgpu_userq_fence_driver_free(queue);
>> +		kfree(queue);
>> +		up_read(&adev->reset_domain->sem);
>> +		goto unlock;
>> +	}
>> +	up_read(&adev->reset_domain->sem);
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>> +	char queue_name[32];
>> +
>> +	scnprintf(queue_name, sizeof(queue_name), "queue_%d", qid);
>>   	/* Queue dentry per client to hold MQD information   */
>>   	queue->debugfs_queue = debugfs_create_dir(queue_name, filp->debugfs_client);
>>   	debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue, &amdgpu_mqd_info_fops);
>>   #endif
> A separate function for this would be nice to have. E.g. something like this:
>
> #if defined(CONFIG_DEBUG_FS)
> void amdgpu_userq_debugfs_create_queue(..)
> {
> ...
> }
> #else
> void amdgpu_userq_debugfs_create_queue(..) {}
> #endif
I would prefer to put this in a separate patch as this need to push all 
the DEBUG_FS related function in amdgpu_debugfs.c, but i will do that 
post these changes. Hope thats ok.


Regards

Sunil Khatri
>
> Apart from those nit picks looks good to me.
>
> Christian.
>
>>   	amdgpu_userq_init_hang_detect_work(queue);
>> -	kfree(queue_name);
>>   
>>   	args->out.queue_id = qid;
>>   	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
