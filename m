Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D98C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 20:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2E9619E8
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 20:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D2E9619E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EF06E171;
	Mon, 15 Nov 2021 20:50:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E11D66E171
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 20:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj8lSGaDY+Ta8CRWk/I+KH4JKzrVeabY2O5pPuh+edA/AtRElFtxGNrDGMcB396kaOcmBepAv5XcBeJ2YHX2W0o9Ar5uAXiOEg0BINJw4juijcsmuzjkMNu7WJp4NYU8Ht1a2p3G/hHT7zgsBroZ17je0b1oqQH/qebqtP3UG0YjY7B838mzFCWiL5PZ1vDo6gabuf08lrBe8vXIiLH92Q3d1GyIdQDz+V5SekssEFhySZumcC9egWqP/aWUYOZrhXA8lkIoGUNU2Gsz8j1HwBQMLNC8SD7Md5SLWY+vAOn9c+TVuLoCEegf6hQgpRBBiXmikr/ZdakakXTGwhdudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0uSaQoE9QtT//w18xqWDR+/NgwDErWBSTnetkzairA=;
 b=Jp+TIo74Eiz9jUvKX2VgSjvX5UU7jeaF9KjmFYEP7yhOTn6YrEzhaBPcdeDyN7jKkGe+UHsAMv0k5HuCg51QA2mN/ahzk2UZ7hYHdntBP3bleL3IuJ0MCUTCgE+iHWqhBa2PdHd4NgeMVCR9OuK+/GDg8pQl/hxgeINSZJa3hrFrLcuFawTQ9LdOvOGGt7J64D5tB11ZehT0gvkkhRRrHD5kBpYzdsNo1EpNvR0KkkeoVeOVCuj1dmekrWQvCqcIERc9th/yFHmvDcvL6U58VQFpXtTCn5XHGwo/JlfpTIo2XhqWmIks9//JyOn+xPnZDxedGOUKwM8t6HKHxDCzvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0uSaQoE9QtT//w18xqWDR+/NgwDErWBSTnetkzairA=;
 b=kdx4cfLVUsbvSoRJHCKo959Kk9McvfvyBnm7dRmvGDZq7ZweIeYM95BJJpblVIg+P62bT3ZuAb7qsrhF4kIAaqJKoHFDBGws8GUVNikZlTzhTHdzDZsuiWXDDRNLIHpg5BrfLij8eQ2aMwWh7WiBchhlHArokNcNttKT6BVXf34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:39f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 20:50:45 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Mon, 15 Nov 2021
 20:50:45 +0000
Subject: Re: [PATCH 4/5] drm/amdkfd: restore pages race with process
 termination
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109230432.3947-1-Philip.Yang@amd.com>
 <20211109230432.3947-4-Philip.Yang@amd.com>
 <d27056e0-c563-ced9-326d-b1b35237e77c@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <6af63f67-73cb-253a-b886-14dce0c2ba8f@amd.com>
Date: Mon, 15 Nov 2021 15:50:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <d27056e0-c563-ced9-326d-b1b35237e77c@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0074.namprd02.prod.outlook.com
 (2603:10b6:208:51::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL0PR02CA0074.namprd02.prod.outlook.com (2603:10b6:208:51::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.26 via Frontend Transport; Mon, 15 Nov 2021 20:50:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae55c1c4-4365-4db8-3b45-08d9a8799857
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53438E91CCA12A12517CFE61E6989@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eclle9TnP9YZgdtAdn7sVs0AOn5fXOClki/BQsPJ1+tRsiTh3rnyDj27/chPOMKyeO1FsrvNl7KWvTX+TOhCwbcFQFHuHz60JEq+94dOLG5k3aC09z2Xmo1FYou/vuzglJVVIpNdi8VN569fy3jse9VA0b3FnzCm+cftZIQqu0tiF2vZGXLqBqQWS5bPBjgo5EwEuaxMiIKuojoAaPZkB6gm/tyg8WuE3Dj/aO67x3Mmx5UOYjkowB7/cMEMXVIjpPr6gmmb/oAW19dgRDb10iH/MYYkxRPFA1O3NDIFrVVa4+FdzJYWOwab8+olTHfmntzzbjsC4riYVJMYi6uDYwEzZ+Eu0R+8opFyktP5McnajY5JDzLmQXe7QkJtLKq1Ml52KZBjoHZLDkAKAg081WQ6vQW4jSt6N2TVomxfOz75CRvVk9k+umZe52XcfktJqef0H+eV1flo4UQp+7rw0c1rePffQG3ctDnRTWmm2xjYVkicTcls7Q7uAJSFllKuLZjtKdPPvV6r5nmmi7CxBYkxynHe/IzxiBHaD0wen5n4U/BjDyHwyqENJp1tos4FKYrLGJ6I2MS61/bQBcLU5ohJzqz6KY8rI4GxFbj8Edfd8acFda+d8uGcOV3+eOJ4VvyXDFC4M9cUnCBdFhY7/DO3SKQB2aujMM5w6BYTzlgaLyBNKc1hMHf/EvWISCfDazzqihfVH9+Vv7GjbU5+kiSzNyD7n1cB+v/GttRmsYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(53546011)(110136005)(956004)(316002)(26005)(508600001)(31696002)(83380400001)(66556008)(66476007)(6486002)(2906002)(66946007)(8936002)(38100700002)(5660300002)(31686004)(2616005)(186003)(36756003)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlnd1JSckkxZ3A1bGFLNjNrdzBKWlhOclBnQyt3Rys3V2xJc1dqK3dWMUFS?=
 =?utf-8?B?QjlQaUZ2S3BJTjlRVzZtQjZKdVdKcmF0bW1ENVZ1ZjdJZHhwMWpEMHppTDNj?=
 =?utf-8?B?ZTdZUFhpWGZwazk4OHBjWU9GUVcxK0NoOVZ2cjQ2QjVCSmhHTWJwVnY2Z2xS?=
 =?utf-8?B?RmhJWi92OEVpVStqODl1d2tkMmpIUE1rLzdJYXZ6eld1R3o5dlZHamhzbUNu?=
 =?utf-8?B?cVN0SkNJSHFOWFh3eVN0TW1zYlBqRnYxdnlRS3g4ZU9MNEJwYTg1QkxKZHI1?=
 =?utf-8?B?WG15dzBiNmJ4VUIvOUZuNWhvdXBtdUR2cDJacVpuaFZtMXBKR01heS85Tmoy?=
 =?utf-8?B?OFB2S1JrblhLMHQwZXJwZ3VYQnFhTGxoZ21EblZFM2c5L1g0MUNER2VjcFdY?=
 =?utf-8?B?bFhRT3hNOFJXaUtzQTVwbFlhVnZ4amFpbm1KbHRGcDNFcmRFdXJ6aGlzRDFl?=
 =?utf-8?B?NGM1WXJHM0tGbFlsVit6RTJkWXNwZlcranZFSm9xRFlXUVYrZGpTKytWWUZ0?=
 =?utf-8?B?YXNxRFFxelBPUnAwVnJnMHRWOVhqMThsZUFudnZOSklyT3hxZXEyWk9CUnky?=
 =?utf-8?B?Y3JFQU9uci9QcVk4TTNiUkF3clFkU2c4MzMrRldTR0dDajAyeTZyZm1Ec2JD?=
 =?utf-8?B?MTh0d3h5QnJiMWpudVRNcDRielJZWkxORkFqMUVMRkNHRzNjYXRFMHI1UFA1?=
 =?utf-8?B?M0xWWHlsWWFmTkZSdEZEWEY4d3JNSTBrWU1vdm1veXZNN2VOenpsaG1JK3F3?=
 =?utf-8?B?c0Zyc1Q5MEFwWnE4RWpWMFhSOUQ1Q09oRGdpb0ZSQ1d2Z2hMektaeHBFTWE2?=
 =?utf-8?B?R1VPbFdQNXZicW1KcGtjZTAyQ0lCazMxYTBYVkIrSXYxZENla1FVR000MUZ0?=
 =?utf-8?B?RE5XYkVvS0NlM3hhTm9VWFZnVGFKd3h5dThJUDU4WTI5Y3ozdmdnbWpwV2Zl?=
 =?utf-8?B?ZEV1bXFHMGhsQVFQOFIwSnBFdkpEb1Rnek1MYjM5R0FIcngyTjBiQWFnMlR2?=
 =?utf-8?B?czRpM1ZlQUMrZnJiYm1aT3cxekJpaERSbG1BeTFSRHNuUzUxM09VMk5DZFlh?=
 =?utf-8?B?UGNPQ05mMzBsc2hrWGZ5ZWxIR2FmV2UzQ1ZQaXhqc29SeCsvNHJyL0s0YTF0?=
 =?utf-8?B?NWh3T1p6c24rMU9QR29nSnNrWUh5ZEMvOW9iSnpwS3c5ME5yeU9GMHB1UEo5?=
 =?utf-8?B?enpNMVpJY1d0QjYzRzJJalQ1ZzA2b1JiTHNCNkowY2ZkMU52MTk1VmR0MVNi?=
 =?utf-8?B?NEpnMUdmeFVuclVtL0ZPTGJHdi90ZVpDdVVWT2gzZEJoNFVkZDlxQ2NhNHh5?=
 =?utf-8?B?VWFZS3g5K3VDdUFtamdFb21rS29JV0pxMGNkWlM0TlEwYTFIQXV5ZDl4ZFQv?=
 =?utf-8?B?QXJSMVlmVnRoQXJRMmJJQzRCK3k2RnR0L21vRnZaa0Y4QkFvRXZjNjdWLzZU?=
 =?utf-8?B?Z3g3RUt0VERMdXVWQTFEblZiN3NYNm4yQjNtZUMydC9VL1ljWm1yak9EWnFH?=
 =?utf-8?B?TzRiOXprYW1xWURNUWdGWis0dG9PNmc5bVg5d25RaVJ0SFJEM3c4MTc2Z2lh?=
 =?utf-8?B?M25jZ2tKRnVna1JoRGgxT3BGTEhmd3g1N0s4ZzBicmsrdXZDYytVNnAya0Nj?=
 =?utf-8?B?MmFROHFkK1lEcE13THVnZElLNEg1dFhWaEdZMzl0UU5CZFkxaDAyUmI0dSt0?=
 =?utf-8?B?NXNDRHNVSE5XSWYrV0J6VVRmU1BQdnFGdVk3VFRESmpWSWREbDZkcnRERko3?=
 =?utf-8?B?OUlKNFY2MEhFSmJockc1REVQaGFMTXlXSDBzSDJhWmdrcVZXRXNpNVN0NXFh?=
 =?utf-8?B?eVF0bTdmUCtFNTBJSkV5dU1sbmZkd0RENHl5U2RuV3VzZmhlMnBFd0xtSzEr?=
 =?utf-8?B?Z3hHSWVNaWJBZXVOc0x6Slplb2p0K0xyZEhmNU4wcm5uajYyWXFDT0IwMEEx?=
 =?utf-8?B?QlI0V2dmTkRnRWFOWmgwZnV2RmlobmNYWktMTkU1ZDZ4TEtyU2QzRHlJVERz?=
 =?utf-8?B?czJGZlI5WldBTzIveGNpRENKd3RhazUvWjRHRWdVTDhlM2NKZHM1MDFNaUdn?=
 =?utf-8?B?Q2I3SDRwcFBBdXpCMGFjcElPcDkxL00xYTMvNnlQR1l0OFlZV0pCNisyN1R6?=
 =?utf-8?Q?c1Go=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae55c1c4-4365-4db8-3b45-08d9a8799857
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 20:50:45.5544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cGxlL9wZ90ektPrpfyAWjHMkMR2XUTkzGbdTaDNYmcvoiag39sJyeXMqVRiy8RK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
    <div class="moz-cite-prefix">On 2021-11-09 11:16 p.m., Felix
      Kuehling wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:d27056e0-c563-ced9-326d-b1b35237e77c@amd.com">On
      2021-11-09 6:04 p.m., Philip Yang wrote:
      <br>
      <blockquote type="cite">restore pages work can not find kfd
        process or mm struct if process is
        <br>
        destroyed before drain retry fault work schedule to run, this is
        not
        <br>
        failure, return 0 to avoid dump GPU vm fault kernel log.
        <br>
      </blockquote>
      I wonder if this could also be solved by draining page fault
      interrupts in kfd_process_notifier_release before we remove the
      process from the hash table. Because that function runs while
      holding the mmap lock, we'd need to detect the draining condition
      for the process in the page fault handler before it tries to take
      the mmap lock. Maybe that's even a helpful optimization that
      speeds up interrupt draining by just ignoring all retry faults
      during that time.
      <br>
      <br>
    </blockquote>
    Call svm_range_drain_retry_fault in kfd_process_notifier_release
    before removing the process from hash table solve this race
    condition.<br>
    <blockquote type="cite" cite="mid:d27056e0-c563-ced9-326d-b1b35237e77c@amd.com">That would
      also allow draining faults in svm_range_unmap_from_cpu instead of
      the delayed worker. And I believe that would also elegantly fix
      the vma removal race.
      <br>
    </blockquote>
    <p>vma maybe removed from rbtree before unmap call back (refer to
      below __do_munmap), draining fault in svm_range_unmap_from_cpu can
      not fix vma removal race, also cause mmap write and read lock
      deadlock issue, will change to check if svms-&gt;drain_pagefaults
      is set, restore_pages returns true if no VMA is found.<br>
    </p>
    <p>int __do_munmap</p>
    <p>............<br>
    </p>
    <p>&nbsp;&nbsp;&nbsp; /* Detach vmas from rbtree */<br>
      &nbsp;&nbsp;&nbsp; if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; downgrade = false;<br>
      <br>
      &nbsp;&nbsp;&nbsp; if (downgrade)<br>
      &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);<br>
      <br>
      &nbsp;&nbsp;&nbsp; unmap_region(mm, vma, prev, start, end);<br>
      <br>
      &nbsp;&nbsp;&nbsp; /* Fix up all other VM information */<br>
      &nbsp;&nbsp;&nbsp; remove_vma_list(mm, vma);<br>
      <br>
      Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:d27056e0-c563-ced9-326d-b1b35237e77c@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
        <br>
        &nbsp; 1 file changed, 2 insertions(+), 2 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 8f77d5746b2c..2083a10b35c2 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -2596,7 +2596,7 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = kfd_lookup_process_by_pasid(pasid);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;kfd process not founded pasid 0x%x\n&quot;,
        pasid);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ESRCH;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;xnack_enabled) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;XNACK not enabled for pasid 0x%x\n&quot;, pasid);
        <br>
        @@ -2610,7 +2610,7 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm = get_task_mm(p-&gt;lead_thread);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mm) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p failed to get mm\n&quot;, svms);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ESRCH;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; </blockquote>
    </blockquote>
  </body>
</html>
