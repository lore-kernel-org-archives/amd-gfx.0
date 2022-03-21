Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE7CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 13:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A63210E43E;
	Mon, 21 Mar 2022 13:43:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBB310E43E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 13:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/VOSMgDu7ThpEQKrt4F7bZnqY67Sm9+W4b04UI7oohyXEk5lQ43/1Sjt6QIV4QSLgBXsvokhjRa3kTunkzrNFF2OlzOI71BR8NL2cSB5xCAyCvUmAoxkHxCQuP+TkBbUcGg0bwta77P3FMsVXxwNoaVSa0NF1LCG2ey9mMkMojYItQ4sdS/kjxmQMfC8Sq4GEiPJzHiH4O0C9mGiPpvI2Es1+VPg5inedeC/6j+2On96Ijq9c2oVKBIucUzf3OiUi25d7I4zD3Ifhd6fR0iL+ESciv/YSsax05MsxiohTOfxlgd1e0PeQvk5mK0OmEDg8Cfp0MrDCJT3IIrNrTHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PGib+UR1itEIjC2cT2IieP6SrWssFvqURG3rE2G/RM=;
 b=jQDKANxqzJ/ZizYdnxCS6Dl+XKK10X6uWXCLFB7n2rn2n48gBdbinmYUlOjnMMAkMC7AVqDVNqF839talGZemE6RCtXKE87xOIMrj+t8BU6pcD4MVO7Z3lKnvI08DDGwt3RIj5Sjc1/wOYv0fqgsFs2UoEqq1EuGq3FNAMcrf7EbqTUDvCzuAYIW2FGVYwy9iPFowZRMnmvxe0LNF5xGT0Rhnj63SQlZaQx0wV1/yj3OOw1arQ86wke6PSddq6z8ca+GFKvrev57RyZBCoBZHVkw0eCpqm6A7wAa8qHn909S9IPVYx9Gvj6YmGDajb4D12e9k/K3TJX/ySDTXJ90+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PGib+UR1itEIjC2cT2IieP6SrWssFvqURG3rE2G/RM=;
 b=tT8pyMVSKs2psxkw3CmCKDxFFIFSvoIbKBRAp9qQzt9cYuPHUKefkRRW9P6ZYIDb8gJbl36mkC1zcdvMl+y00WRdlpHaSKGGhc6wsS9lBJRVm6F5awYekKsNSg1AnUVmyIUuW6r/NSMFxJD3q1wqVsB51zKbR+IsgoCpSCeoH2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MWHPR1201MB0189.namprd12.prod.outlook.com (2603:10b6:301:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 13:43:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329%7]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 13:43:06 +0000
Subject: Re: [PATCH 4/7] drm/amdgpu: rework TLB flushing
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com
References: <20220317135044.2099-1-christian.koenig@amd.com>
 <20220317135044.2099-4-christian.koenig@amd.com>
 <3e23d276-d9fd-b9c2-cf23-572f4ede51a0@amd.com>
 <9a2ecbb9-21dd-842b-2787-7c50930acfc3@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <98fa8e35-5576-81d7-59bc-d9d2da83fb0c@amd.com>
Date: Mon, 21 Mar 2022 09:43:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <9a2ecbb9-21dd-842b-2787-7c50930acfc3@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:208:234::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab774fa-ecb3-4b6b-9eda-08da0b40bada
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0189:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB018968C5F34A776178A610D7E6169@MWHPR1201MB0189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjBHpNcZhFdB77hjPBxnEeSG8k6Hqu+PJz1o5rlF7smfIGO4kw8hHCQ6Hh6KCN23ehMcXmDMFBfvGNWS6Nlbr0KvPnL8obc7anE2ocy7c0mSCaYCl9bQtwAzGYSfNhljWp93DR26BvLvjTl6mJmhOS6EKWQYYM8/JyyMwkYtc0ilwlDoZmjx2tPFPuwGC7DLTGPZqianx2Qe4/PGGHyMCSZ8+Y4osk8hwDxr9REKrCrwTNHfooR93jR7EAUnh7LgVvbga4ZglGoNFesILmqWuYx8y19fi+I6Yl0gYxHWg5cWvhLb4eWlXDS7ske4JPQM98wV3wdzRHZ9lY7uMBk1F3xu7hwNzQPaLzugDK5TE6TrA/oVbcdBQRPATf7M4vBS19A5bemomRkWDIOVJEdYT0e7YMmJpIAdaWJyebKvREa4ZBB49e4gkMJrnCtB5NXsrQQ8kIziv1Ziwzt52JjEZumpAXmtsXr31f05hh4Oe7l0myx2H2YJdW1OSsTmjZhqC04U3OzT/Qd9cSBz6TYeGrhBHLZ3Tua1vYFj24JTdqiT98Zke4B3HTcpWv3EZX1XgjfStxnACZb73JHjLbXA1bwaQT0elRzgqANztBfCB8a+/VhvIw39hfnvD92pjXUasiwPrtaegfUszDdtWDey246+9o78oymBpjJmR/DR6T1lccXZIJa5V328SShgXrWx5fiyeqHr+kr+czB5NJYKP86UwBaRMwpBMlbn7N1uXE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(83380400001)(31696002)(8676002)(186003)(66574015)(26005)(31686004)(66946007)(66556008)(66476007)(8936002)(2906002)(38100700002)(6512007)(53546011)(316002)(6506007)(2616005)(5660300002)(36756003)(508600001)(110136005)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmpWMkcvMWFqZS9DcmVick5pRFJLSmI0QUpNak0zNUNjOGM5Y0ppMi9vQ0ds?=
 =?utf-8?B?aXBramtYT1pHZVk4bnZzWEdjZGRnd2JhdFhUam1nWW9ObkFuRHNEV2FQQnF2?=
 =?utf-8?B?b1Z4V0ZJODRWZTYwOWVETW43QW1SUFUxNGwzdVlDSENhY0dMWmM1bW5vNkQz?=
 =?utf-8?B?SWRqaHQxREdCSDFEK0ZCclpqZFFzWGhXaTJTUlFjRWhjR2twTFl5SG9OL0xC?=
 =?utf-8?B?aURveXB2Nk81S0xqZHBZWmp2VUxBWngyTEQ4N1p2czdjR2xyRGlnN3ZiMTNM?=
 =?utf-8?B?SjNrRFNLV0QyalhTQ0hqR1hjQnpMWGNBeDI5K1R3eDRKL1llK2RwNzlTOE9R?=
 =?utf-8?B?c1MvYkIxSkphUlN1dWtDQ2kvM0NYR09UeHJNblFkc2I3ekZXT1RUMzIxOHJC?=
 =?utf-8?B?a3Y5UDVQVjdxVFh0alo2S09CdUFXZEhCWWlnVFhJNUp6RUJXZHd2TkR5b2Zr?=
 =?utf-8?B?UWp5Q3FUdjRHYjR6UXpzOHZ1K2FDREhjYWU5VmI1ZEg5SGs3SWdWendySGxZ?=
 =?utf-8?B?UlRFaC8vbEp4bktEdHhJVENWd2VkSjMwOCtsK2dlbDMzOUNTMGJhRDhDSXJJ?=
 =?utf-8?B?bi9hMHIyd0JXNE5UWXV5TVREM3IxNDNnRXNRWmU1M2ZUQ0ZiYlJkTFNFN0xE?=
 =?utf-8?B?K0lWb2xBcFZBV3VDendKSUptNVlkbkxKM3J5cStQbUFrbmw3QzI2ckEvRXBr?=
 =?utf-8?B?VEN1VlltdVU1QWRzMWRyTlhTcE94T2IrQjBGeU1RNUVzUEhwZkl6cEtqMVdk?=
 =?utf-8?B?T2lETDBkZ29vV0U4dWhNTmtsL1gwRzVuUUozQWtCWWoxcTdRY3d1U25ONmxy?=
 =?utf-8?B?YXUySCt4UVBHSW85RlorcGJna1JWNDdpZUMrVmdnUXNhWjRLbTZNVVc2YVZ6?=
 =?utf-8?B?WXlXRFFqK3NiUVN5d2JPZC9jQkxoV3Q3QlBtQWFPdTBTV3dEalp0Tk9LeStK?=
 =?utf-8?B?U2grWkVSUzlSYWRsQnZUUk50TEtnazdLd3R5NzVmMm16SmdKYks2ZExzQTlS?=
 =?utf-8?B?eDdhbnQybjIySDcvMlZoZDFkSGNPV05ZazRGYlRVb1JhSTZMS2M3eElnNGZT?=
 =?utf-8?B?TnB0NHFIQWU0bll6NCs2am5rNkY5MnlXSVFVRTY3S09yWlo4bnF5aXNneFR3?=
 =?utf-8?B?YUNvbEhGN1R1UVR5aHB6TlpGTFIrQ2hrQkE5bW9takV1MXBTNmRYZHR2WVVX?=
 =?utf-8?B?MkFsRDBpSmx4VFo2cVFRY0Rqdm5SWmlVbEtWaDZkSS9lczhMQ01QUFp3eWlk?=
 =?utf-8?B?SWpFclNkZ0IyQkhRbVdHWmtERmJhVGZRNnYwcnUrTmtIamxaUEFEc0N6bi9h?=
 =?utf-8?B?UVNxQ1Zmc1N2Q0V3S3J3Vm1nQWdKa1NYWWo3R1NzSkUvZTJwWUdHVjhzV1hV?=
 =?utf-8?B?SlJBcjFUekVIWDV2bVFWVllMaUIySzhLLzZsQzZ3VngrWVQzd2IzcWkvYm9D?=
 =?utf-8?B?VWE1MlBMS3BiMnFCNmdWYUxKNEdEejJHcTJhQTAwZnNpMDhEVFpCVWQvTlFO?=
 =?utf-8?B?VTV0NGFqZzg5T3RnUlA5NGFFb01ndXJXZlJTZXc5VlRnZWdWSHcvSWR4VWdt?=
 =?utf-8?B?VnVlRWRlMDEwa1BDVFlPQ3M3MDJ2Ulhzem5uZHA5MjNnRFZhcVluMnVpSCs4?=
 =?utf-8?B?bDVVYjM1VWJobXNOQnlSSlZFSWlpajVYRnVvaVAwcEVHam1DbDE1MFgvZDRP?=
 =?utf-8?B?SlZEMnZENC9STnF0ODE1RUp1T0o0SnZ0WVYvdlFtd2tGajFiSVptUzV6TEo1?=
 =?utf-8?B?N1lWcEhROGM0NEltZUVLdHNvTHk4azdtR21tM25vRlFBa1dFNkVvc2V1QlBE?=
 =?utf-8?B?NWhvRll6b2l1TkVRRGJHVSt5UXYxVDJqOGMrMlF5UFlxM2NKcjMyeGF1YVBs?=
 =?utf-8?B?K3JCc0U1VUdZaE0xL1A1azVETDZvMUFGc2FvS2RYcmdmRHRpSmtnanZTNkZH?=
 =?utf-8?Q?TT3sWooLNnHrwDWQJj3TgYc6aDxtTD2X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab774fa-ecb3-4b6b-9eda-08da0b40bada
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 13:43:06.8142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgtzU6rIzdQh+kXsmR1TlTmNas+duTqOwmf8bVll5qL5BDaQp6R099WXu5cnwUkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0189
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
    <div class="moz-cite-prefix">On 2022-03-21 5:33 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9a2ecbb9-21dd-842b-2787-7c50930acfc3@amd.com">Am
      18.03.22 um 16:45 schrieb philip yang:
      <br>
      <blockquote type="cite">
        <br>
        On 2022-03-17 9:50 a.m., Christian König wrote:
        <br>
        <br>
        <blockquote type="cite">[SNIP]
          <br>
          @@ -890,9 +929,20 @@ int amdgpu_vm_bo_update_mapping(struct
          amdgpu_device *adev,
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = vm-&gt;update_funcs-&gt;commit(&amp;params,
          fence);
          <br>
          &nbsp; +&nbsp;&nbsp;&nbsp; if (!unlocked &amp;&amp; (!(flags &amp;
          AMDGPU_PTE_VALID) || params.table_freed)) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tlb_cb-&gt;vm = vm;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!*fence || dma_fence_add_callback(*fence,
          &amp;tlb_cb-&gt;cb,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_tlb_seq_cb))
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_tlb_seq_cb(*fence, &amp;tlb_cb-&gt;cb);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tlb_cb = NULL;
          <br>
          +&nbsp;&nbsp;&nbsp; }
          <br>
          +
          <br>
        </blockquote>
        <br>
        Should move fence_add_callback before calling
        vm-&gt;update_funcs-&gt;commit?
        <br>
        <br>
      </blockquote>
      <br>
      No, absolutely not.&nbsp; vm-&gt;update_funcs-&gt;commit is what
      provides the fence to add a callback here in the first place.
      <br>
      <br>
      <blockquote type="cite">With this fixed, patches 5-7 are
        Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        <br>
        Need another patch to fix svm_range_map_to_gpu, remove local
        variable table_freed and call kfd_flush_tlb after waiting for
        update fence done.
        <br>
        <br>
      </blockquote>
      <br>
      I think I've already tackled that in the follow up patches, but
      I'm not 100% sure I've did it right. Please take a close look at
      this.<br>
    </blockquote>
    <p>Added the missing patch to patch 7.<br>
    </p>
    <p>Regards.</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:9a2ecbb9-21dd-842b-2787-7c50930acfc3@amd.com">Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (table_freed)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *table_freed = *table_freed || params.table_freed;
          <br>
          &nbsp; +error_free:
          <br>
          +&nbsp;&nbsp;&nbsp; kfree(tlb_cb);
          <br>
          +
          <br>
          &nbsp; error_unlock:
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_eviction_unlock(vm);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dev_exit(idx);
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
          <br>
          index 1731681914f5..38a1eab1ff74 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
          <br>
          @@ -284,6 +284,9 @@ struct amdgpu_vm {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity&nbsp;&nbsp;&nbsp; immediate;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity&nbsp;&nbsp;&nbsp; delayed;
          <br>
          &nbsp; +&nbsp;&nbsp;&nbsp; /* Last finished delayed update */
          <br>
          +&nbsp;&nbsp;&nbsp; atomic64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tlb_seq;
          <br>
          +
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Last unlocked submission to the scheduler entities */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; *last_unlocked;
          <br>
          &nbsp; @@ -478,4 +481,16 @@ int amdgpu_vm_ptes_update(struct
          amdgpu_vm_update_params *params,
          <br>
          &nbsp; void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct
          seq_file *m);
          <br>
          &nbsp; #endif
          <br>
          &nbsp; +/**
          <br>
          + * amdgpu_vm_tlb_seq - return tlb flush sequence number
          <br>
          + * @vm: the amdgpu_vm structure to query
          <br>
          + *
          <br>
          + * Returns the tlb flush sequence number which indicates that
          the VM TLBs needs
          <br>
          + * to be invalidated whenever the sequence number change.
          <br>
          + */
          <br>
          +static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm
          *vm)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp; return atomic64_read(&amp;vm-&gt;tlb_seq);
          <br>
          +}
          <br>
          +
          <br>
          &nbsp; #endif
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
