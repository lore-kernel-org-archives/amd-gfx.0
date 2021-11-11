Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53CDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 20:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF50611C9
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 20:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DF50611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF5289D58;
	Thu, 11 Nov 2021 20:53:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B193889D58
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 20:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpTkFVmZs2zXBGx9pJJ0iTuhnZJgxY4iPHgXag5JCr+52HZh8X5OW6qQ5uL5dddzrDJEYzG7KZdLWIMqdMny25Q94Eth8nZsvEizi0s2rXh8BKy+hhlpaQjz4rXIX8WOTzypr4vFSYYE2rvMsnyZL2tJNEsNYVOFYhBwxrNj9X5sY+JQ6TAnt+JacQkSBmP6ChthfY6OkcT9+fNZL0rAYS08SxBhZwLuOvXD7QT3BYY+a2Ngi/G+CbRJbwTPxlG1AGAan0N7iZ0Cc2lh49f3uwWpoocgztuWqnfx1P4cpRHV3flUNp+KKnoD4X99NwusKJQuaFhW+avzZeGaiDiv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i+fT5MBY+JzRx4cxjupyC7zXF9XMyrXKFrQJYVdQMs=;
 b=bFebGRc/aZI51XEtAIws1h2vK+4kR+FyYBnndGyAN8mX5ZQpxxe7wJalDDOV8eNshkrgf7Mnx/EjJhYfwxLeAyBdT+q+TkZ0zzLSzx0Zo7wXN2WV/X3s5aYDGtiCpfyymAKr1kUOkYJ1UzfEAXoyR8zU+JUrFZlu1V5Ebf2OlON4B312xVEO6UQrxNkkKaq7shpFo0KsTs8GS6DZDlNx+UzDh2qV0Jub6mP0cWpeneRe3jcv5CESDnoMHgmYwIKQG9lqhbqdggQc1Ysi7FTkTUaS/QNKHnugH4VANVfmmfu/eOBZy2N13TcCaeqTXzoy3B7AKUZ1w2KdA515Astr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i+fT5MBY+JzRx4cxjupyC7zXF9XMyrXKFrQJYVdQMs=;
 b=GPDtqCRyWnVsL7LCYgQiAXPmR/MJoG6sFjjQMvXGRXoDB3jUhrzo8lx6eX6P3HeKbv8I5GC2hlJGVUW1Us/zqhVaBscVwlOlMOmKE6N43xvhNm4WwjKl9lfp11zhwW+bbeOsgsTKLT4FOBR8VZyO0pQ41Kqg9GZL7lveo/BpA/U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 11 Nov
 2021 20:53:54 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 20:53:55 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Update BO memory accounting to rely on
 allocation flag
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211109061304.13110-1-Ramesh.Errabolu@amd.com>
 <b743f99a-6486-aff2-2664-fa1eff4f7fdc@amd.com>
 <SA0PR12MB4399F23B39000EF8672759E6E3949@SA0PR12MB4399.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <24daeb34-8ebb-75d3-798c-6e7e7e6a962f@amd.com>
Date: Thu, 11 Nov 2021 15:53:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <SA0PR12MB4399F23B39000EF8672759E6E3949@SA0PR12MB4399.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Thu, 11 Nov 2021 20:53:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6654abc-72f7-4a1d-bc8d-08d9a5555fcc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5361C36B5BD349C72590D6AA92949@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCLDjRjb3Oyb1oxcVQZRp52X+ljx9Jd1LLbF3Shc/MyLodFmi9tiQTB0rWcu6Ze+WmfVx3g6GG6+HegK5vJNjiQqVjc3VUNAcy4zssVcb9L01jTct8M/nlwy5CPwT+t4BM6Sohug1xC1QXCtsk1EdZMQslkd04xJnXRz8VzWXbxm2yFUBuqi+NRlZZSb7k1DXN2rONu5yIxslPriU/9N6skDzACEZwo+QQj24ufVQJpUEfEH5SDIexEIIVJbnPd9O6K0Mffb+DBIYWqflQo+nW32ux/LvOw2CWc5VReWhvAUf2kTdqOn5OJjz3lea2Ga3qayMGjDbRhdyqLSZxh0Dvk8DAlIKoF1/+YdC0gJp/HOUQitnFmhrU2Qtn7aUXEsL8Rq8nrPJV8JWHIkYhnNuS6ic2F8993XHRf10GNPU5I4Cc61QpH+4EZSaMXeZzbqo0HdLmzWDsex2PbbaemK9BTBoJ3yINIjof48Pxf0dpxC90B9qb+Zg4DvEPLb9gNUFfsWF2e41VWmE4AqUh3XWiiurDXHGki4VXeOsiG7wOwku0dUhzxamvheoi/DyBNz4K7yU1DOYdC1HLs2mtKf82/SN9+cxdLTHJvZj+IFF59KWhAZ/AhzVdhwUOhzHZr+sQqYFmbAOKJs1wATVZY/fBQUnpvVnim1sZz6ZbPEy+Zu1Qm8c4lOVTsYPfrh4Jo3R8ganplxbauRXtPflBVZZc8dxgXGttL8rziEjzx+H11Vd85dIebEk+26Pf5Qlmv1C2EWmNQdKQqGSZroYS5eUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(36756003)(31686004)(8676002)(6486002)(26005)(31696002)(66556008)(66946007)(508600001)(66476007)(316002)(83380400001)(110136005)(16576012)(53546011)(44832011)(15650500001)(2616005)(956004)(38100700002)(30864003)(186003)(5660300002)(2906002)(86362001)(8936002)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNqSXM4eGpWNTkwTVpCdmJoT01pNjFOV1BlN3ozd2tpd21Jam1FenN2R3Fp?=
 =?utf-8?B?S1FEL09UVTZGa25zaVUrVG5rWUVRVFU0bTUxcStMZWhxbXBmVVE1UDVXS0FF?=
 =?utf-8?B?NVN5MnNFR0FOd3lqcUIvWXBiOXhTU1BmbW1pcVJDYjd3ZGplVGY2emhMb2Zp?=
 =?utf-8?B?SXltUnJsR3pkYXNDTFZVTitBdVVKUGhsQ2FrTGM0dkpBRVY2WE1hd1ByQ1g2?=
 =?utf-8?B?YUNtblF1UmZ6Vm9rd0wwZ05OdzBJVUJBb2xkSTVBYU9oODZORjYxZU5xWkFv?=
 =?utf-8?B?dUFBWU1pTDhtLy94bXl1eGZFamRQSCsyVlZXRG16RWJmSk54d3BENTlDeSt2?=
 =?utf-8?B?ZE5rWVhZaTYrV0JsMlZEVE9OVDk0WWV3LzVVR2ZzT0VmTit0OW9TOWEycWln?=
 =?utf-8?B?S1B1Z3dEc01memFHRXBMUnlqajhEM1U1M3RxYzlDRzgvVTlrdFoxL1QwL2VW?=
 =?utf-8?B?MjZGWmFvMTNRc2FEdFJaZVZpSmIyL2ExWnhXZ2dlUU5GL1hGNjQ3UGpGSS83?=
 =?utf-8?B?NDRVV0RlU0JlTXA5ZkZQR09YWVExV1FhcTNVS0VHMzNWR0o5MEVySElaTHdU?=
 =?utf-8?B?QXdBaEd5aGVVWnhyRFdYQ3hDWU5FUUlTWDFldzhLU2dmT0xUU3JnT2VYSDc2?=
 =?utf-8?B?L2RESUN1Z3U1UnRsQ1pHY2pTMGhFemdEdGJaNHVOcU5uRWVNYmEremIrVUNR?=
 =?utf-8?B?Si8wV3FzVENIS0QvYktGZU5MdVFOWUpHTjM0WUdxdVdEa1YwT0FmbnhBSE53?=
 =?utf-8?B?WHJEQWl1ZUFremhmeVVGZm9kcko4L3hoRDJzcWN4SmhqZ1lUS0tMMVhBY1lw?=
 =?utf-8?B?cDRLaHlOVlNsT29VdmowMkJSOVJaTVRCYkRkN0JyS053SEQ4Ym85ZXZYRzJl?=
 =?utf-8?B?b1ZOUDlFRXpSV3hiUXd3SnNZVWNYVTZpYXZteUpuSWtIUXF0dVpKT09NYzZB?=
 =?utf-8?B?eEJ2dkRodXBzSGlOWFJDRjlCRUlKNGVMSVcvM2J6ekFkMTNxUkpjQm45Y2dm?=
 =?utf-8?B?M0ZySHlhSXhIeFoxODhkSjZBYmVCbHVNUFJyM1F5ejQvVGU1amUwbTZFSkJX?=
 =?utf-8?B?aFQrTFp1UG5FYVdTY09mbnZsU3hPQ1UrMjFyWEV3SGp0N3RvQlpmMU1rU0p2?=
 =?utf-8?B?d3QwTUNZTjNGNDdJSkFRNUNjV3h5dWlWM2k0RnhFSGtwVDVsV1BRZWc0M3o1?=
 =?utf-8?B?d3g1UnIxamRJaTlFVzNvTnAwUTJKbndSUzFMZWwwcGV3NHoyNFJDbXVOYk42?=
 =?utf-8?B?NC9hZFhGdzVObXhwRENIbnArdmpUNU9WajFweTZNa01FODJBNzh5Yk9mVUxk?=
 =?utf-8?B?TXR6VkM2Zml3WUFZZFpkbHVNbnRLb0pJY3BNZUNUTnozVWp1WFZKVXlzTFAx?=
 =?utf-8?B?bTZ4Vk5ORyt0VWFRZVkwa3lYR0JLa0JFcEhPbkVXbDlFWUNYR3NLTDJuUy9D?=
 =?utf-8?B?WVYwVHhKNi9Vd3E1MFUwN1ZYY1R6bXNEbkg2c2liVjd6RmRlN3VKUGE0UU5z?=
 =?utf-8?B?R0paWWdEQzFTOHpVcm8yczd3bktSZ2JnZzI3Q2hDTXl5a2ZjN1hLT0lraG82?=
 =?utf-8?B?S0ZwYXdwNG5EYkVIRXRSV0VqaENlYVhEVGt0ak5oZG9YS3F3cE9kZitJeUVn?=
 =?utf-8?B?MjJTR0Q5YUFJZUhGam05K0dUWHgwREt2dHBlYXlyRi9Xd2JxUDMzekcrS0cr?=
 =?utf-8?B?YjNVOStwb3VjSlVYYVV2TW5XWTVVcnRPb09SRVVGa3NSMUh6WVZoWU5LZHM1?=
 =?utf-8?B?Umh1QXlXdXVrRTJoSmpCSjJ6dXlTZ2ZYNE1aVXFoY0FXSWdFUndQQk9idG9H?=
 =?utf-8?B?ZkFmLzFxNUdkV0Rvcnd2RHVvanBnVk5XNkJxYVFJWUk3MmdPRW9iMy90V016?=
 =?utf-8?B?T1RKaGZYTEhPMUtKRDN3T20rRlJodWI2SDQ4Qzd6bml5NzdmOWtIckxQcjFv?=
 =?utf-8?B?Y0R6dE1pQThFN2h4Z0loVHIvaE56UnBPYi9wNm9QWWJVcWtNQ3VCU0Npd0xQ?=
 =?utf-8?B?MGdxYk43TXRYdWhUdVZGR0dQTnlzS1Jzd1pINGprRi9PZWtCbkx3QkNiV2F0?=
 =?utf-8?B?MTBIS3pEb2xURTNyaVlzaThtNVhEOHhQSXEzNU5vSXF6cVpscDc5OVNGUExC?=
 =?utf-8?B?VTcrM29wWW5aZVNiTFpOQUxSYU5ZRllkQy9KVmVBeFQwT0l2c285d2xNWlhU?=
 =?utf-8?Q?XMHlg3zlRjRUlrArNAbIxCk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6654abc-72f7-4a1d-bc8d-08d9a5555fcc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 20:53:54.9255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: co2wReHT+C5HlK4djE5aimgx2Jpo0U09SWWTTWLdFmxQWUkCPxO5ph2/rVLS/7G2x5b7PIvNw0ctw99FRtSg8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
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

Am 2021-11-11 um 3:45 p.m. schrieb Errabolu, Ramesh:
> [AMD Official Use Only]
>
> Resp inline
>
> Request clarification regarding - amdgpu_amdkfd_reserve_system_mem()
>
> Will send out updated patch upon clarification
>
> Regards,
> Ramesh
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com> 
> Sent: Thursday, November 11, 2021 7:44 AM
> To: amd-gfx@lists.freedesktop.org; Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: Update BO memory accounting to rely on allocation flag
>
> Am 2021-11-09 um 1:13 a.m. schrieb Ramesh Errabolu:
>> Accounting system to track amount of available memory (system, TTM and 
>> VRAM of a device) relies on BO's domain. The change is to rely instead 
>> on allocation flag indicating BO type - VRAM, GTT, USERPTR, MMIO or 
>> DOORBELL
>>
>> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> The code changes look good. Comments about comments inline ...
>
>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  16 +++
>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 101 
>> +++++++++++-------
>>  2 files changed, 79 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 5f658823a637..8d31a742cd80 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -307,7 +307,23 @@ void 
>> amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device 
>> *adev);  void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>  void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>>  				struct amdgpu_vm *vm);
>> +
>> +/**
>> + * @amdgpu_amdkfd_release_notify() - Invoked when GEM object 
>> +reference count
>> + * reaches ZERO. Increases available memory by size of buffer 
>> +including any
>> + * reserved for control structures
> "Increases available memory size ..." is an implementation detail that doesn't matter to the callers of this function. It should not be part of the interface definition. The interface description should be more general, maybe:
>
> Ramesh: Agreed.
>
> * amdgpu_amdkfd_release_notify() - Notify KFD when GEM object is released
> *
> * Allows KFD to release its resources associated with the GEM object.
> * ...
>
> Ramesh: Used your comment as is
>
>> + *
>> + * @note: This api must be invoked on BOs that have been allocated 
>> + via
>> + * KFD interface amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu()
>> + */
>>  void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>> +
>> +/**
>> + * @amdgpu_amdkfd_reserve_system_mem - Decrease system memory that is
>> + * available by an amount specified by input parameter
> This is misleading. This function doesn't change availability of system memory in general because it doesn't allocate any memory. You'll need to be more specific:
>
> * amdgpu_amdkfd_reserve_system_mem() - Decrease system memory limit for KFD applications
>
> Ramesh: Thanks for pointing out the detail. Should this be "Decrease system memory available for KFD applications" as the code seems to track a counter "system_mem_used". Let me know?

That's still not entirely accurate. KFD applications can allocate system
memory in different ways: malloc, hipHostMalloc, hipHostRegister,
hipMallocManaged. This limit affects system memory managed by the
kfd_ioctl_alloc_memory_of_gpu, which must be physically resident while
the queues are active. At the HIP API level this includes hipHostMalloc
and hipHostRegister.

It does not affect system memory allocated with plain malloc or mmap.

My version that just mentions the limit avoids all those details because
it doesn't need to explain what that limit applies to. If you want to go
into all those details, I'm not sure this comment is the right place for
it. I think it takes a more comprehensive discussion of GPU memory
management with user mode queues.

Regards,
  Felix


>
>> + *
>> + * @size: Size of buffer in bytes
> What buffer?
>
> Ramesh: Updated it "Amount to decrease in bytes"
>
>
>> + */
>>  void amdgpu_amdkfd_reserve_system_mem(uint64_t size);  #else  static 
>> inline diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 94fccf0b47ad..08675f89bfb2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -120,8 +120,22 @@ static size_t amdgpu_amdkfd_acc_size(uint64_t size)
>>  		PAGE_ALIGN(size);
>>  }
>>  
>> +/**
>> + * @amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by 
>> +size
>> + * of buffer including any reserved for control structures
>> + *
>> + * @adev: Device to which allocated BO belongs to
>> + * @size: Size of buffer, in bytes, encapsulated by B0. This should 
>> +be
>> + * equivalent to amdgpu_bo_size(BO)
>> + * @alloc_flag: Flag used in allocating a BO as noted above
>> + *
>> + * @note: This api must be invoked on BOs that have been allocated 
>> +via
>> + * KFD interface amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu()
> Who needs to call it? Your statement sounds like callers of amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu must call this function as well.
> This is very misleading because this function is already called from amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu.
>
> Ramesh: Will remove the "note"
>
>
>> + *
>> + * Return: returns -ENOMEM in case of error, ZERO otherwise */
>>  static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>> -		uint64_t size, u32 domain, bool sg)
>> +		uint64_t size, u32 alloc_flag)
>>  {
>>  	uint64_t reserved_for_pt =
>>  		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
>> @@ -131,20 +145,24 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>  	acc_size = amdgpu_amdkfd_acc_size(size);
>>  
>>  	vram_needed = 0;
>> -	if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>> -		/* TTM GTT memory */
>> +	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>>  		system_mem_needed = acc_size + size;
>>  		ttm_mem_needed = acc_size + size;
>> -	} else if (domain == AMDGPU_GEM_DOMAIN_CPU && !sg) {
>> -		/* Userptr */
>> +	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> +		system_mem_needed = acc_size;
>> +		ttm_mem_needed = acc_size;
>> +		vram_needed = size;
>> +	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>  		system_mem_needed = acc_size + size;
>>  		ttm_mem_needed = acc_size;
>> -	} else {
>> -		/* VRAM and SG */
>> +	} else if (alloc_flag &
>> +		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>> +		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>>  		system_mem_needed = acc_size;
>>  		ttm_mem_needed = acc_size;
>> -		if (domain == AMDGPU_GEM_DOMAIN_VRAM)
>> -			vram_needed = size;
>> +	} else {
>> +		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>> +		return -ENOMEM;
>>  	}
>>  
>>  	spin_lock(&kfd_mem_limit.mem_limit_lock);
>> @@ -160,64 +178,71 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>>  	    (adev->kfd.vram_used + vram_needed >
>>  	     adev->gmc.real_vram_size - reserved_for_pt)) {
>>  		ret = -ENOMEM;
>> -	} else {
>> -		kfd_mem_limit.system_mem_used += system_mem_needed;
>> -		kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>> -		adev->kfd.vram_used += vram_needed;
>> +		goto release;
>>  	}
>>  
>> +	/* Update memory accounting by decreasing available system
>> +	 * memory, TTM memory and GPU memory as computed above
>> +	 */
>> +	adev->kfd.vram_used += vram_needed;
>> +	kfd_mem_limit.system_mem_used += system_mem_needed;
>> +	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
>> +
>> +release:
>>  	spin_unlock(&kfd_mem_limit.mem_limit_lock);
>>  	return ret;
>>  }
>>  
>>  static void unreserve_mem_limit(struct amdgpu_device *adev,
>> -		uint64_t size, u32 domain, bool sg)
>> +		uint64_t size, u32 alloc_flag)
>>  {
>>  	size_t acc_size;
>>  
>>  	acc_size = amdgpu_amdkfd_acc_size(size);
>>  
>>  	spin_lock(&kfd_mem_limit.mem_limit_lock);
>> -	if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>> +
>> +	if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
>>  		kfd_mem_limit.system_mem_used -= (acc_size + size);
>>  		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
>> -	} else if (domain == AMDGPU_GEM_DOMAIN_CPU && !sg) {
>> +	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>> +		kfd_mem_limit.system_mem_used -= acc_size;
>> +		kfd_mem_limit.ttm_mem_used -= acc_size;
>> +		adev->kfd.vram_used -= size;
>> +	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>>  		kfd_mem_limit.system_mem_used -= (acc_size + size);
>>  		kfd_mem_limit.ttm_mem_used -= acc_size;
>> -	} else {
>> +	} else if (alloc_flag &
>> +		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>> +		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
>>  		kfd_mem_limit.system_mem_used -= acc_size;
>>  		kfd_mem_limit.ttm_mem_used -= acc_size;
>> -		if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
>> -			adev->kfd.vram_used -= size;
>> -			WARN_ONCE(adev->kfd.vram_used < 0,
>> -				  "kfd VRAM memory accounting unbalanced");
>> -		}
>> +	} else {
>> +		pr_err("%s: Invalid BO type %#x\n", __func__, alloc_flag);
>> +		goto release;
>>  	}
>> -	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
>> -		  "kfd system memory accounting unbalanced");
>> +
>> +	/* Alert user if memory accounting is not per expectation */
> This comment is obvious and unnecessary, and also not even correct.
> These WARN messages are not for the user because the user did not cause them and can do nothing to avoid them. These messages point out bugs elsewhere in the driver. So they are for engineers.
>
> Ramesh: Removed
>
> Regards,
>   Felix
>
>
>> +	WARN_ONCE(adev->kfd.vram_used < 0,
>> +		  "KFD VRAM memory accounting unbalanced");
>>  	WARN_ONCE(kfd_mem_limit.ttm_mem_used < 0,
>> -		  "kfd TTM memory accounting unbalanced");
>> +		  "KFD TTM memory accounting unbalanced");
>> +	WARN_ONCE(kfd_mem_limit.system_mem_used < 0,
>> +		  "KFD system memory accounting unbalanced");
>>  
>> +release:
>>  	spin_unlock(&kfd_mem_limit.mem_limit_lock);
>>  }
>>  
>>  void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)  {
>>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> -	u32 domain = bo->preferred_domains;
>> -	bool sg = (bo->preferred_domains == AMDGPU_GEM_DOMAIN_CPU);
>> -
>> -	if (bo->flags & AMDGPU_AMDKFD_CREATE_USERPTR_BO) {
>> -		domain = AMDGPU_GEM_DOMAIN_CPU;
>> -		sg = false;
>> -	}
>> -
>> -	unreserve_mem_limit(adev, amdgpu_bo_size(bo), domain, sg);
>> +	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>> +	u64 size = amdgpu_bo_size(bo);
>>  
>> -	kfree(bo->kfd_bo);
>> +	unreserve_mem_limit(adev, size, alloc_flags);
>>  }
>>  
>> -
>>  /* amdgpu_amdkfd_remove_eviction_fence - Removes eviction fence from BO's
>>   *  reservation object.
>>   *
>> @@ -1452,7 +1477,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>  
>>  	amdgpu_sync_create(&(*mem)->sync);
>>  
>> -	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, alloc_domain, !!sg);
>> +	ret = amdgpu_amdkfd_reserve_mem_limit(adev, size, flags);
>>  	if (ret) {
>>  		pr_debug("Insufficient memory\n");
>>  		goto err_reserve_limit;
>> @@ -1508,7 +1533,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>  	/* Don't unreserve system mem limit twice */
>>  	goto err_reserve_limit;
>>  err_bo_create:
>> -	unreserve_mem_limit(adev, size, alloc_domain, !!sg);
>> +	unreserve_mem_limit(adev, size, flags);
>>  err_reserve_limit:
>>  	mutex_destroy(&(*mem)->lock);
>>  	kfree(*mem);
