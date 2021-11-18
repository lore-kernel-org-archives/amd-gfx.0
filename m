Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE05C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 15:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB9861547
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 15:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBB9861547
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642C36EC3B;
	Thu, 18 Nov 2021 15:00:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 299A36EC3B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 15:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B69g13DfIGRZJa0i9+b5+57SnwJjFaX8Gn9dXUUkbXwHqv/YVO8ZZ4Aw5uSy9LrXUS2aC8tWukQIENYlvGmFWEhtgs+Hf+/hJRcDwbag8sKm7y71r5FVbF429SqYiegx+oQXuB9/PiqreA7GQPtHo17Fu8Nq0gy1qv/sfb5VlSb73hB+stZlewkc+A9vdd3q4GpmwAKVkbgyIpIcHSLeWGabzPJc1q/DH6A9ciZqB5Rq46vrD36VizVk7xkErlQVGj46BQjc4V3PpDFRbef8wFd5wZS1x87mRGq7awPhzlCauQRFQMzNmMKU7kbBeYYThYQ7pa6JglHPdKVcAEASHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9ybq77vYufCvB+C6ZHiBDHTSZLQXqlV6jhdo/V5Rxw=;
 b=Yz3oC2g/QJNYpkHi1z9srH0M9ycT5XW0f//Uk4sArVGN0py96zqdoUbQK616QdbQA8sdqFVo41p+ACEOxzaF5g39WhROBWDhDSzsKvedmc4KxVEQGSDiI1WMIDiRSdrLQwNsj4ipd3AVEhBOoKKtIxasR5WeULQcwiDhi12AYF/QvqTDXmuJ+A1tmFwKquCftfhXY0wwkTm7dqkZAtMvaa9fV/p6xFFnucY9EFpBWG22cbI0SY9OV0GWqxYy/UcYOBeX55Q2MP3yXSHohB+knFYC25aPmIH2lgGVOWT2TACaeQxgmmUzk9mNBVlR5GnSqK5MzoFUEo0EDXdL3rUYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9ybq77vYufCvB+C6ZHiBDHTSZLQXqlV6jhdo/V5Rxw=;
 b=f/2zD/ev13hP6W4HXhkL0YHpzVaaK9HBrh666K3jAdpsVivu5yVO4fNv7JZ9AbgHf8pGUS2MwXt12zoLX8d0yu1C5XsiEPYCu/bTBC2/fnpE4swnqE23SiEwB0d7pe3W4p+g+5lEGPv68KFNCViJzU0BsPbFSSVjjYCz5ie60ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Thu, 18 Nov
 2021 15:00:23 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Thu, 18 Nov 2021
 15:00:23 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: handle VMA remove race
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <20211117034324.4663-2-Philip.Yang@amd.com>
 <5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <5162a906-2f1d-bf1d-8313-62105e8f618e@amd.com>
Date: Thu, 18 Nov 2021 10:00:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0067.namprd19.prod.outlook.com
 (2603:10b6:208:19b::44) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 MN2PR19CA0067.namprd19.prod.outlook.com (2603:10b6:208:19b::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Thu, 18 Nov 2021 15:00:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd4ede1c-9753-4326-b6e7-08d9aaa42575
X-MS-TrafficTypeDiagnostic: DM4PR12MB5278:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5278D04B3877966A65D3934DE69B9@DM4PR12MB5278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzEDhEiyNeYMOAaWZAx++bJcxXlQKDRthXgVlOSnSm5U0O2EHiFiUhDDItlLNUjUe3/hsxGF0r7uGCQ/l46Lt+/guouSaMNjCaoscVNt2gclvQcs0YdL0AJ3Ll+/9ON8jW8OA3h9JbjoUiTZOeeWfQmTjoLhIrXXkcYM/Z3/to/R0g1jgMtGLASRdbMabiSC/MYqkEy7LLRbTQcBFcZxpuTJ6BYy0XbWiOu5Py5HhkKgncwhU6oKmE6o95EKZZsaVYMZWqKLc9qdWRkTZlUz9vhoizH0xdrLYf8zx0cKhUuIJlRHIscDQE1NiDIl30GFiSzuvphowHOFDw9wNnrKW0/Oe52XDdzEC5sosg8HO244YLBJUVONjuGIhLx8ddfGvcHUjGHXF/cgMW+3GKT7zWgEgzVFVleX3ZPZ85R4bvSfpA9ecKwGbkOUdKvLSqxN1LJummdFybel0QKt0Z0pGXCQ9RTOa+CfKZwciEGySH0GCHyKc2h6GnVQOplZ0BLB+8TzYc8CTiAb6MIlCP0bf3y6qOijGO8OismEu5a217+460+3ivhKF1XoauC4Y7kDedSWnm0k/2WevlnYtBDMMCViFLM1OV2mnM8kKZkW2fqZuGlmVZtb7xx3K50b4dghWm7K7mDDa/yhdDuVqbeXGbqVrvI3lugm5Ws4AhGjKscMDAcjHSxhaVcf1NN1BG9q+Nx474o6zo4SJUvAEAnJIxDEcTO++/3QA6GPzqVp9bI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(316002)(53546011)(26005)(186003)(16576012)(5660300002)(36756003)(31696002)(110136005)(956004)(4001150100001)(8676002)(2906002)(83380400001)(2616005)(38100700002)(66476007)(31686004)(6486002)(8936002)(508600001)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFBpUEl6NWZqVlErZDhXQ1dDaTlRTE5yM1Zqd0Jjb2loTldaREhDMDIxUm1D?=
 =?utf-8?B?UzZjcng4d1lkNTMzaVQ0RkpJeEJDWHRYdGVnRU9KYjNJU2twVm9pRVQ3OTkv?=
 =?utf-8?B?QU9Nanh6SHNmN3NKZzRGdk11WkU5eTc1Kzhndm1JSEtWQjE2dVdJR1JQdGxF?=
 =?utf-8?B?ZXB1YzhiSzRIUzFzTWJIVFZ3UW91S2h5WDUvbUZlQ081SHJ6STF3aTlXOE9i?=
 =?utf-8?B?Z1JmR293clhEYnRoUXM5cERYWWxGOERFeHorNnN3YSs0WjlOOFU3czNrS0ZL?=
 =?utf-8?B?NENMUGJXdVRDWWxmMWNGYnBvN3E1SU9Cano1azhtM0RSb0dFZXBBTk50TG1Z?=
 =?utf-8?B?d2NLZGdKbmJNamNHd1VMaExxZDJxVVdWZ1cvdlZxNmtxeHM5TDZ5TENUTjZ5?=
 =?utf-8?B?M2xTVjFWRlJuWG1zUnNUaFo3NU4vSk5MYlZuYmQ3elZ2ZDJrZ2QxeU1oT3Iv?=
 =?utf-8?B?SGxBa0RCY2dkUGM0ckxsWVAyRUxNaElEQmVMSk1pYm1GbHN0TWJPUzB6K2hj?=
 =?utf-8?B?WkpxWklKd3FkT0V5QldpWTdUZ29FeTAwNmhzOUcyb0IyTG0rdVdiSlpKOVBa?=
 =?utf-8?B?T3cvS0hhTVhnWU1ORmtESmlBRlNtUmpadUxWWXVuNE5FdUFyQ0trUklQaENB?=
 =?utf-8?B?RXE0bHRoR2ZDWG5lV3FKdERVQmVTak9kY2dVVDZSSVBuSDJENmZNTXAwS0ly?=
 =?utf-8?B?UnJvUTlYRSt3KzFOMzYxM2RkaDcxNjgzcnBVUW5KY1l5V25tNEIvaHkyMXhM?=
 =?utf-8?B?NVNDREt6YnNOM3oxT1hqVGo3dUo4Y0ZrRXVvcGFQUWt6RVU5OGlUY09CTUVP?=
 =?utf-8?B?amh3U0hHOU1LT3RwbWZqNmN4Y0F0ZUpGc05EMjgzbnp2Qi9FSU1nUldndUdR?=
 =?utf-8?B?dWNWcS9HdWZCQ0Y0TDVJZ3Jzdm1GdlFxS2FtUEhzdHZKZ0N5YkJhVDRpUXBh?=
 =?utf-8?B?Tm0xaktabmphSkJFWFBERzdlVExnZWoxMitSQkZjVGFIY1RpU3ErRXJqdkNs?=
 =?utf-8?B?c3BOSENHNHUwRk1wdjVXamlWYjIybHFZTFlEV2Y2Y3JwcHRvSk9MVjZGZHZx?=
 =?utf-8?B?bFovazMvR1l2Y0sxTktYWnh4aXdJcXByWFlYYkFHa3pkWm95TDMzdmNnMWFN?=
 =?utf-8?B?blRXanY0TVpVZWtqNlYrUE5GenIvakRPcCt1MzJtQUNzbmRSTW1zbGxrZTR4?=
 =?utf-8?B?eEliLzJ3SEc3clF2VEJETkZUSlpPdDY1YnpVSzJ3MjNkc294OHZ6UVVPd0dx?=
 =?utf-8?B?UFkrZ0hpMXRJZEw4NEdHV0JzR09mVTd0N1MrZzI5RzlpSG9wRzR5YldMdkNY?=
 =?utf-8?B?MVl1OVpFSlEycEhXUGlEU2ZVdXQ4QWpJMWdWekZ1L2FvSkxLMEd1TFczMFZE?=
 =?utf-8?B?eXk4S3JsNGlwU3g4WmNEQ0tuWWJRdjI4RmFGUUlBRk5VM1lMRkpDNmF5R1pD?=
 =?utf-8?B?Tnc3L3JHMkJJenFnZEY2UGNlOWpHUVV2c0ZWc250WHpHRklnZjdEVUlIRi9N?=
 =?utf-8?B?VVBaRFBKajRHeHdpSWhNa1hKdWpsWWlVcFVSZTRXQXRwc2NKRFpmbnBHdSty?=
 =?utf-8?B?N2JzSUY2N2Zydm90b3lxZFZ0K0JNMDJzaWo1WkxOaGNjZllTTnhwWmR3YkN0?=
 =?utf-8?B?NXdnZ295U3V4MWM0TmZicUJhamRnaFBQUkZId1pxNTkzMjRqSWltY1RBdmNC?=
 =?utf-8?B?akw0R3hkQTllajFSTFBzZXlIWldMYVBKSVFQaXRRM2NrMVpSMWN1Wm1IY2pB?=
 =?utf-8?B?NmUyeTVDVnk2aVJYd0wrSkJCTDN3SUVSRzdocVV2VDduL2EwSGoxNnVjaHVD?=
 =?utf-8?B?MVNGNUt3OEI0ZVQ4NndYZlNXQlYyc2RCcUNIRzBOazBVanZ0VVVJQTl0M3hk?=
 =?utf-8?B?N0JMSG00NzhMWGNwSzg0dDlpMWFYRUUyMWY2amFsUHg4QUJhOCthb09aeU5F?=
 =?utf-8?B?MTh0NjJUVjFxalZiSVk5ME5YYmJ6Nmp3Vjg0QUNMTVgya3FqTkFJYkEzUkdH?=
 =?utf-8?B?U3grbWErbkRHK2Yxc0tGZTFIeGlVNFZ1aFhkVERGMWpiZ3VaMzFVMWc5Yk1z?=
 =?utf-8?B?d0hweWRyVlBHYUszOFB3bTljSjAzajVXT2JTNStJZG1VVnVrQ3VJdlVVM0JQ?=
 =?utf-8?Q?znXI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4ede1c-9753-4326-b6e7-08d9aaa42575
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 15:00:23.0491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGa/YG+eTTNNCZ6j/bEtbdt82Y0wcYDDZhteuFuvqZH83FTslee3SChT26X+wLz0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-17 7:10 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com">On
      2021-11-16 10:43 p.m., Philip Yang wrote:
      <br>
      <blockquote type="cite">VMA may be removed before unmap notifier
        callback, restore pages take
        <br>
        mmap write lock to lookup VMA to avoid race,
        <br>
      </blockquote>
      <br>
      The old code looked up the VMA after taking the mmap lock (either
      read or write) and kept holding the lock afterwards. I think even
      with your new code it's possible that the VMA disappears before
      you take the lock the first time, so always taking the write lock
      only reduces the time window in which things can go wrong, but it
      doesn't remove the race.
      <br>
    </blockquote>
    Take mmap write lock will serialize with __do_munmap, to ensure vma
    remove and unmap callback are done, because unmap callback set
    drain_retryfaults flag, so we can safely drain the faults, and it is
    app bug if vma not found after taking mmap write lock.<br>
    <blockquote type="cite" cite="mid:5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com">
      <br>
      I still struggle to understand the race you're trying to fix. The
      only time the svm_restore_pages can see that the VMA is gone AND
      the prange is gone is after the deferred worker has removed the
      prange. But the fault draining in the deferred worker should
      prevent us from ever seeing stale faults in that situation. That
      means, if no prange is found and no VMA is found, it's definitely
      an application bug.
      <br>
      <br>
      The only possible race is in the case where the prange still
      exists but the VMA is gone (needed by svm_fault_allowed). We can
      treat that as a special case where we just return success because
      we know that we're handling a stale fault for a VMA that's in the
      middle of being unmapped. The fact that the prange still existed
      means that there once was a valid mapping at the address but the
      deferred worker just hasn't had a chance to clean it up yet.
      <br>
      <br>
    </blockquote>
    Yes, that is only possible race.<br>
    <blockquote type="cite" cite="mid:5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com">One more
      comment inline.
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp; and then create unregister
        <br>
        new range and check VMA access permission, then downgrade to
        take mmap
        <br>
        read lock to recover fault. Refactor code to avoid duplicate VMA
        lookup.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 65
        ++++++++++------------------
        <br>
        &nbsp; 1 file changed, 24 insertions(+), 41 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index c1f367934428..3eb0a9491755 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -2329,20 +2329,13 @@ svm_range_best_restore_location(struct
        svm_range *prange,
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static int
        <br>
        -svm_range_get_range_boundaries(struct kfd_process *p, int64_t
        addr,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *start, unsigned long *last,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool *is_heap_stack)
        <br>
        +svm_range_get_range_boundaries(struct kfd_process *p, struct
        vm_area_struct *vma,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t addr, unsigned long *start,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *last, bool *is_heap_stack)
        <br>
        &nbsp; {
        <br>
        -&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct interval_tree_node *node;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start_limit, end_limit;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; vma = find_vma(p-&gt;mm, addr &lt;&lt; PAGE_SHIFT);
        <br>
        -&nbsp;&nbsp;&nbsp; if (!vma || (addr &lt;&lt; PAGE_SHIFT) &lt;
        vma-&gt;vm_start) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VMA does not exist in address [0x%llx]\n&quot;,
        addr);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *is_heap_stack = (vma-&gt;vm_start &lt;=
        vma-&gt;vm_mm-&gt;brk &amp;&amp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_end &gt;=
        vma-&gt;vm_mm-&gt;start_brk) ||
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (vma-&gt;vm_start &lt;=
        vma-&gt;vm_mm-&gt;start_stack &amp;&amp;
        <br>
        @@ -2437,9 +2430,10 @@ svm_range_check_vm_userptr(struct
        kfd_process *p, uint64_t start, uint64_t last,
        <br>
        &nbsp; &nbsp; static struct
        <br>
        &nbsp; svm_range *svm_range_create_unregistered_range(struct
        amdgpu_device *adev,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t addr)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int64_t addr)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange = NULL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, last;
        <br>
        @@ -2449,7 +2443,7 @@ svm_range
        *svm_range_create_unregistered_range(struct amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t bo_l = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (svm_range_get_range_boundaries(p, addr, &amp;start,
        &amp;last,
        <br>
        +&nbsp;&nbsp;&nbsp; if (svm_range_get_range_boundaries(p, vma, addr,
        &amp;start, &amp;last,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;is_heap_stack))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
        <br>
        &nbsp; @@ -2552,20 +2546,13 @@ svm_range_count_fault(struct
        amdgpu_device *adev, struct kfd_process *p,
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static bool
        <br>
        -svm_fault_allowed(struct mm_struct *mm, uint64_t addr, bool
        write_fault)
        <br>
        +svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long requested = VM_READ;
        <br>
        -&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write_fault)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; requested |= VM_WRITE;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; vma = find_vma(mm, addr &lt;&lt; PAGE_SHIFT);
        <br>
        -&nbsp;&nbsp;&nbsp; if (!vma || (addr &lt;&lt; PAGE_SHIFT) &lt;
        vma-&gt;vm_start) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;address 0x%llx VMA is removed\n&quot;, addr);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;requested 0x%lx, vma permission flags 0x%lx\n&quot;,
        requested,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vma-&gt;vm_flags);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (vma-&gt;vm_flags &amp; requested) == requested;
        <br>
        @@ -2582,7 +2569,7 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t timestamp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t best_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t gpuidx = MAX_GPU_INSTANCE;
        <br>
        -&nbsp;&nbsp;&nbsp; bool write_locked = false;
        <br>
        +&nbsp;&nbsp;&nbsp; struct vm_area_struct *vma = NULL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!KFD_IS_SVM_API_SUPPORTED(adev-&gt;kfd.dev)) {
        <br>
        @@ -2606,26 +2593,22 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* mm is available because kfd_process_notifier_release
        drain fault */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm = p-&gt;mm;
        <br>
        +&nbsp;&nbsp;&nbsp; mmap_write_lock(mm);
        <br>
      </blockquote>
      <br>
      Always taking the write lock is unnecessary. I think we can keep
      the old strategy of retrying with the write lock only when
      necessary. I think this should work correctly as long as you
      lookup the VMA every time after taking either the mmap read or
      write lock. The vma you looked up should be valid as long as you
      hold that lock.
      <br>
      <br>
      As I pointed out above, if svm_range_from_addr finds a prange but
      the VMA is missing, we can treat that as a special case and return
      success (just draining a stale fault on a VMA that's being
      unmapped).
      <br>
    </blockquote>
    <p>ok, I will change svm_fault_allowed to return success if VMA is
      missing, it is simpler to handle this special race case, without
      taking mmap write lock.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:5e1927f0-2cbc-e639-57b1-f61274ec97f4@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp; vma = find_vma(p-&gt;mm, addr &lt;&lt; PAGE_SHIFT);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!vma || (addr &lt;&lt; PAGE_SHIFT) &lt;
        vma-&gt;vm_start) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VMA not found for address 0x%llx\n&quot;, addr);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EFAULT;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_mm;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; mmap_read_lock(mm);
        <br>
        -retry_write_locked:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;svms-&gt;lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_from_addr(svms, addr, NULL);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to find prange svms 0x%p address
        [0x%llx]\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms, addr);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!write_locked) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Need the write lock to create new range with MMU
        notifier.
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Also flush pending deferred work to make sure
        the interval
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * tree is up to date before we add a new range
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_lock(mm);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_locked = true;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto retry_write_locked;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_create_unregistered_range(adev, p,
        mm, addr);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange = svm_range_create_unregistered_range(adev, p,
        mm, vma, addr);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!prange) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed to create unregistered range svms
        0x%p address [0x%llx]\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms, addr);
        <br>
        @@ -2634,8 +2617,8 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_svms;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; if (write_locked)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp; @@ -2652,7 +2635,7 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock_range;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (!svm_fault_allowed(mm, addr, write_fault)) {
        <br>
        +&nbsp;&nbsp;&nbsp; if (!svm_fault_allowed(vma, write_fault)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;fault addr 0x%llx no %s permission\n&quot;, addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_fault ? &quot;write&quot; : &quot;read&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EPERM;
        <br>
        @@ -2704,10 +2687,10 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp; out_unlock_svms:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);
        <br>
        +out_unlock_mm:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_count_fault(adev, p, gpuidx);
        <br>
        -
        <br>
        &nbsp; out:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);
        <br>
        &nbsp; </blockquote>
    </blockquote>
  </body>
</html>
