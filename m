Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFA7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 15:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9936D10E708;
	Wed,  1 Jun 2022 15:05:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B69D10E404
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 15:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/qauIRnqnJGL85a4vSixqKWkWRQ/ha8/dGXx5A0wnDOq7J7qq6qLLhuhsVplykuV/oTE/PGHe/JLmi0S6B+hRwP4okyyqx5CxL0CKaS129ON3opIabDCZpmtxo20mg84WBjzFOiEnUJBDy68PW3zca401CM0vPtN8usnvtzj3gWN+2vH3EXuuKc+UuCIrkDiSJBWE8+9CKCal7mx4iIC4b9JdZukSUq6TCD+Fjrt7sW9ctecI/K/fG7ra2uECabRyuXT2wgitQZhj6DAwrEQiquRUjJH4NZMEVxNKysckjURmdxCxRmUOS5lWf3cB9UWZ83b42Dz9LlzBTHxcTMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkVGKbUxkuz4Vl49NikaTM7x3vPfqeRaHz80bo8pmwY=;
 b=i1TGYw2zZ0QlxzI+LbB3ODGZNrfhSIYgotkrwwQ3hc1aljWqYvKe6KiP0xv/fL/V/U0JGAfg9I3MdllzNmxXMHYMRTdhEHXspWKoipnxutVcQ5v7THBT9h8kIyvpc4rpoP5RNdRqmTL5sU2JIsGaL6Y3wxdvrqlY90YSHrJEm8WVJu+3cSGpqD+QK2zj2UG0CQHb2GKEEyGS9FgadtMzIEBxVoYO4fY9t5h67LJHXjEmSkkLc5jBTI3tXrZzVDdZgBm4A5zs5gnAlXJc9wE9ijNIkF57Jv9/6NH6mQikZDf0DBub+VfAsqX0RtAbUgTciNtVfttDGfMT7x+Ip+PmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkVGKbUxkuz4Vl49NikaTM7x3vPfqeRaHz80bo8pmwY=;
 b=5KjGrxCmKgzl25lkPkc519rCkENxjb31mCR/ayQdgHct8RMs8FmywPaNmTXVbAYpRG2myMkzyPo6JtFZ/jhsQTOB5wL6GQc/VZWErvjPtQF+Ori2LrSNc4gp8DaNgRVSIIrxO0GbbiPvJmYvXbhAxjQ7nSGVQFau1Rpwoby7Ntc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 15:05:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 15:05:21 +0000
Message-ID: <022d86d0-6301-70da-f320-b17c4859443b@amd.com>
Date: Wed, 1 Jun 2022 11:05:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Explicit VM updates
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1138178d-a0ee-4048-629e-08da43e025aa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5031EEF96402C84E7D01A61992DF9@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiTJbbuTo1lkgCMEgcI8wbEsldFjqUa0W9MjQ/nvyazBQ5PfVtZLhdBexM03f027NAq8XBWFB/DgGeo0OFB9rNr29VXzvVZVRAuR3Kki98AZ6JqAm8sM4we2gAnmM64XA8I1R7jzkD37PcTOnxQUpz7H9wpjVKcX1idXKpSFoBpfI58Y+jhU/Ht74B7npvKZZuHVPZgXD/Rn9opSwnKh/hCwgTXR0YF1OwOdVmVltkwpJ7JJZSyhK7CfyRT5+YUJgmoMMQWOZjMkCtYnVLWBvlPyUDPO+FDSVHguW2P2y9UrHP7fKLmD45Lu+nItLZFu+t2H79SkafWU5OnJkRbW1Em7d97mZjkQ/2pPBeqMq67wqweFmlbTK3jA1FAc2sCS0bdWNdqsXKdlQsONTbisVMDjTnLTUDiu8xehDEO1VoarKdJOJfmpvPiwMYSLYsxgJYkm5W+FgtRex3dV6avG6MlbtQyHKfw1iy7HKiXWnFG9ofCQ6IlcLh0O5mhm8aNTeCuY9B1t9BIMcaPPTlF1m4QbMrY5fejza/s1lFR+9N8mPgzM9JgcIwDvf9b/az0RBsh/Ad4ITVZbdg2fdAQZSBgsF2HUsWSqQeCCAFBW5GmTMHfH8CpuLThwSvAZ6t8aJQGf9K0WcIlC2xHtVK1Sa/xonmUJvNO4DcVkkd5rtlkD5wUPqSYIKecU4RLY0KVlCwXegZjImHxiE1D+rtWcVfNA0duj+eSnyfECnvKTDro=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(26005)(2616005)(6506007)(31696002)(6486002)(86362001)(3480700007)(2906002)(31686004)(36756003)(110136005)(8676002)(38100700002)(4326008)(316002)(66946007)(66556008)(66476007)(6636002)(44832011)(7116003)(15650500001)(6512007)(186003)(83380400001)(5660300002)(8936002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzdYS1RYZXl2dEphTlVuRmgyazFVVzAvWCs3WmVvdTRKNlhoblpzWkpzcndY?=
 =?utf-8?B?OHl4MURvYVlneDlrRmJLWUdua1JSZUozZDBVcmtRK0RmalVpRVc3clh3K3NU?=
 =?utf-8?B?ekJnUkRvSGE5VjJtZm5lVVNUVERmUnpTZ0Z2NkRQWmpRWFNtQitkK2xaZ2Jj?=
 =?utf-8?B?djlVREd0OVF6NkVuMGlhR2tpMjlmWExxNVZzalNOVWRhZDZUZ0dJSitoWGY3?=
 =?utf-8?B?eW02Y3N4WUt6c0hncjluTi94TzFoWTFyWWt1ZWs5OXgxbXp1aU1jU2NWbUZC?=
 =?utf-8?B?d281bk50QmpnZjhBd2FMd28zT2R2RnlLWTdFZ3VIYis5TEZGUmltY0k0Rkhv?=
 =?utf-8?B?OUhCcVExQWYrVVRzb09kcER5VzltL3NVODN5SkZQaHpqWEk1ZzNWdXFOWkhJ?=
 =?utf-8?B?MW5iMU1qWDVwdlVhZ3JTWGt2R1hYSzJsY2dhcExXd1B6ZGYzUlFIeEIvK2JY?=
 =?utf-8?B?MFV0QzhLR3VBcUZzRTN2SjhnejV4TmNTZEJQMVRkaStYV1dVZTUyK1RFV3pq?=
 =?utf-8?B?Y1hzQWM5T3R1RmF0U3hKMDVDeTZJS2JDUG1pU2ttSk9kY2dnYVRpNHJDcEc1?=
 =?utf-8?B?WXRvOHVRUE1rKzFidk5zTVdYQ1ozdkRBTVRTUkpZRnhrUzBzY0VEVnk0Yi9G?=
 =?utf-8?B?VUZGZTJiRXlSdFR0Nmp4RWdQZGdQR1U5TUxqeG41RVZjUjVRaU8yNmIvcWlS?=
 =?utf-8?B?V09PSDlVNVFEN05nNWJUdG5aYlJyYXRLcklHTjJwWlZ0SmpmMDVBQWwvUnBX?=
 =?utf-8?B?WnlUOFZLV003UVhpUys3SExvRkllOEFmVWVFQk5aMTlPM3hPc2ZJN0hKUjla?=
 =?utf-8?B?Q3JNUWNBTXoxdTBtUU9ERVRVVkFldjBvVDI0WEVNVjdSTHYvVGZERUVrTU9s?=
 =?utf-8?B?SUZoZWt5TmpqM25adHNJSjlIZVZnQ0pscGVQVGhnT0dLRytnOVNadWYrK0VS?=
 =?utf-8?B?Mi9Jc3had3pvb2IrZ0RSL2VsbE9DWEplN0hGZ3U1Uzc3S1dmdlBCMURUUzht?=
 =?utf-8?B?U3l2cndlbFVleUpNVzFBZElXOHdQcXUwQk9vQ3ArQjMweUMxek01d1czMjVM?=
 =?utf-8?B?b2d1Q3NESHdHZ2ZHYzJ6WVd5L1BYZm5qemtxVXJPaGV2WDlaY1lqb3FoOGRM?=
 =?utf-8?B?R1J3TDA5WER2clp3aG1kZzByYWJoUnVSd2RpWUFiZk4rZ2YzaDh1RHFTVVFp?=
 =?utf-8?B?MkNxL0x4UGl6VWROVnA1aC9jVVF2NnJobkFFVzNvY3Z0Rmk2R3I4Tk5yMHk0?=
 =?utf-8?B?enRwK0UzL2x5NURGeWZZTU1LYmoyT3JjdFVmeE1IRC85QXVjRDdabXQ1ekhK?=
 =?utf-8?B?a0M2MmFKYUZBalBDa25KcW9tUVZiVUw2WVVPNll2NkVnK3lnU3ZSazhTQXpC?=
 =?utf-8?B?ckpIME5qUStTbXE2OGQrMEhGK2lqUDdjd04vQklUNW16YmNMTkFzVDJDbE1E?=
 =?utf-8?B?WCt6SEhRb2ErRzRISDVRTFJXVzlEd1BkVTd5UDVJV2lnN0RJVnJkQlRkRUN5?=
 =?utf-8?B?bytqSURrTEhkUG9FM2hoclFDV0ExaE9oMDFTMGNQL1pOVk1iRndXLzQrQmdJ?=
 =?utf-8?B?UlVtd2RuY2FXOHJFbGJnRmd2eDJ2Ymd3R2VSMHJ0d3k3RWNWMEc2TlVVTEdq?=
 =?utf-8?B?T0EraTlpUUR2eFJaYmNuUEdZZmtBN3ZHU0MzVXRtT2RYWjVGMGpyMEc5c21L?=
 =?utf-8?B?VXBLRVI0WWhVWWtwL0ZRK2c1OWtMb2JzSiswYlh6eVB5S2NtK3EvQlZvNE1J?=
 =?utf-8?B?a3JzVlZhY3RvZlJ6RFBWZklreXlKa2FuNmd6cFcreGI5clh2bHRaTCt0WmRn?=
 =?utf-8?B?RlRQNERRQjduL1B4NUhpdFRURU5pQzZjZHlTTUFFdUpvMDVIeCtNOEhhdHNv?=
 =?utf-8?B?TzAwS1pmbjdwQXhXems3SmJQV2NPUVlEaXcxeWtZb2JiVk5kY21KQlBXNVJw?=
 =?utf-8?B?em54cnJQMnFFWXFCeFBMTzg5Z0tySkNyQW9sT2JLdko2NDZ4QWlCTlBNZ1B1?=
 =?utf-8?B?VXgwcXEzRkUwaWxzUEVYZHhCaGtLWXdJcmVSSEd5U21PMVN5MURyWmU0Nkts?=
 =?utf-8?B?bDR6UXVtbm9iK2JnL3gzbFE5V0YzeVpOMmhEcWZNR0hML0h5dTBxREVTK1Y1?=
 =?utf-8?B?VlY2bFcxNE51Z0htc2Q3NmI4Sm5aNlZuVTFmOWJvSkE0MHV1cHNaeVdwc1d6?=
 =?utf-8?B?ZVE5TFdXb3NIZ1Z4elU4alViNnJqa1kyOVQ0Qm5RNkxjVEJkK04yQzIvY2lq?=
 =?utf-8?B?empmQUw5Rjdxc2FmOWlMZVphUTZsMlI2cHQ4UmdZQnZJSXhQQU8rdm5DNHBY?=
 =?utf-8?B?ZDdOc2NYT0pKd2NwM0xBbDQ3YTNUeW9mRDFaVGV0M2I0YWc5bFlTZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1138178d-a0ee-4048-629e-08da43e025aa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 15:05:21.0786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: af0x8IuJPjxyMi78FdTJfv0dw4OFAc5JeSO0f1uqrIid8NGSKpQFuK/PvljFPoRlebYUoSFPhVJ7oHSd5wloSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-06-01 um 08:40 schrieb Christian König:
> Hey guys,
>
> so today Bas came up with a new requirement regarding the explicit 
> synchronization to VM updates and a bunch of prototype patches.
>
> I've been thinking about that stuff for quite some time before, but to 
> be honest it's one of the most trickiest parts of the driver.
>
> So my current thinking is that we could potentially handle those 
> requirements like this:
>
> 1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. 
> This way we either get the new behavior for the whole CS+VM or the old 
> one, but never both mixed.
>
> 2. When memory is unmapped we keep around the last unmap operation 
> inside the bo_va.
>
> 3. When memory is freed we add all the CS fences which could access 
> that memory + the last unmap operation as BOOKKEEP fences to the BO 
> and as mandatory sync fence to the VM.
>
> Memory freed either because of an eviction or because of userspace 
> closing the handle will be seen as a combination of unmap+free.
>
>
> The result is the following semantic for userspace to avoid implicit 
> synchronization as much as possible:
>
> 1. When you allocate and map memory it is mandatory to either wait for 
> the mapping operation to complete or to add it as dependency for your CS.
>     If this isn't followed the application will run into CS faults 
> (that's what we pretty much already implemented).

This makes sense.


>
> 2. When memory is freed you must unmap that memory first and then wait 
> for this unmap operation to complete before freeing the memory.
>     If this isn't followed the kernel will add a forcefully wait to 
> the next CS to block until the unmap is completed.

This would work for now, but it won't work for user mode submission in 
the future. I find it weird that user mode needs to wait for the unmap. 
For user mode, unmap and free should always be asynchronous. I can't 
think of any good reasons to make user mode wait for the driver to clean 
up its stuff.

Could the waiting be done in kernel mode instead? TTM already does 
delayed freeing if there are fences outstanding on a BO being freed. 
This should make it easy to delay freeing until the unmap is done 
without blocking the user mode thread.

Regards,
   Felix


>
> 3. All VM operations requested by userspace will still be executed in 
> order, e.g. we can't run unmap + map in parallel or something like this.
>
> Is that something you guys can live with? As far as I can see it 
> should give you the maximum freedom possible, but is still doable.
>
> Regards,
> Christian.
