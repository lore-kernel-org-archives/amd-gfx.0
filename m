Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6DEE80AB3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 14:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1D4410E539;
	Wed, 27 Sep 2023 14:29:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F33E10E194
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 14:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAGEvZIXrhYyRUw656IN9n4MRYUBRKma7SjJYdhAweOeuNKiNUOdrapu1yOHGi1NXoFVLguC7lHhp1YXB+eDNfLYZwiAt6tt/4O/y8YlomZgI2sTsqs0uWKK81pGNkNUfcqvRwj8qeIQqiWONSC3Rn0zpUbX1hgbPXR6zi/O8JU2CJhsvA4ZxGiUOs0sGEwRZiBhql2QeG+D/JNKt6y9s9Y5VXVhkAYsXReXqA+Q91lu0+9btteGkCSzhbE0hQimySNieOlq4ZbiC24tcHuREBBojHHxkDjPVilxQGvcxHZJ9n6RNo5rXOZI0umSbqdihG0n+TKcZkaIpnlXU9/PvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc0KMyHNodrt5T6oLpFzxLh5nytJm7/2Ydv7k+YqbHw=;
 b=AL/jv4rCuCLQizJCi8zlYQqLn4m9X0qzuaLbbqta2srfgZ580elkgJ4kENRcZxt/LNzzOoeyPyjif03YxUP8Hpe0Q9jfmgPeGO/VWVqCbiYMzsYBi6WSVyWTNjsA4TPETbeOW8K12VIik5xpZnbvrfG3ZunjTBrjMcGYKTbmShz/U4+MCKaBdpSSCFL9MmMGWoDXGR5VM4ar6MokiFX4WLyUEffyXJFdtfIbGQH7mYI/Btz1/cZHZaiV5A9eEdygywI8cRsC3SqUwL8PNGWEwANsGgaAq2F8mlnTW0LnHmCz4dH/QNEE0nlbuFxu8hwqGLMNGTB+J6bCGIsf6pdAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc0KMyHNodrt5T6oLpFzxLh5nytJm7/2Ydv7k+YqbHw=;
 b=fLK1ixklabQm02q3l7cLjYU9e07OPncuXXT8bizOQWfTvN7n40dTq2+tzOQ1VA6QFgj0dFnw3uCxVcANgZCiJqYKWQIUXXr+DhyFVOtplObqMS4TIdVVx2XiQ2fsJKz+PCGpPHbRwpMZNt4JJ/3TR7ffIEfa2VcShBGpMeJfKEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Wed, 27 Sep
 2023 14:29:51 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 14:29:51 +0000
Message-ID: <4f696de5-3e2f-ceb9-bf09-43b4b1078cb0@amd.com>
Date: Wed, 27 Sep 2023 10:29:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Wait vm update fence after retry fault
 recovered
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230922213759.20904-1-Philip.Yang@amd.com>
 <1d6af500-2a17-0f95-3c86-024cdded0fa9@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <1d6af500-2a17-0f95-3c86-024cdded0fa9@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: eb144248-3d02-4442-018d-08dbbf6635b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRzgJNDOjYRUIqI/hy2pBG7rGBxjPj5crzfyxx/+QS0n4f+sATthH6FSA2F2+ArLMFXhcXPxb/AnVgg0pCXKPjJJ9obm2yfcaBwreTiN6DqhwhYA8yhEoVcWWALaWvMRobWqq1/cmNd/CfQDShFFbgc4e3iXYElrn4/N746Vy5vITrPh7JX6bWUt/R7qWYXFy+2A9gEXEzesYYCrv8FzGCItaicubcw/wIaCuJ2IT1t8PyUup8fopGCJi6qmM0opa4464pnUSS/Z+xXgYfRk9wICLOgyO80NcurSCFTHViODztf1LBAIKBOMqBBPbCaQVlxPCNRWyKXKNHtembkiNo7r4wBWTTa77SiOuHseUcfKsbXHc34uq45CeihzunaA6BUPiv3+DqxTrwOYXhlKFIb7UNASNGOehEhCgtpcuKfssY/kdBFhrfdpT8b52XSjWqbowtX67dgX5wzbtXEGaTMUA1eTcf4oglZirpb04fO/oO+88FwwlB/hLHz64HMShh+CUfGwwKL6kFv1Ou2Z0mSpwFKcXpYQ1z1MAXn8lQEi76CMy1Kmn4eVmZl7cTP1FnC5Q+drqkWyNT5m5Ynum4Ch57WTyYX2bS9Yg7YsnKEiBb9fijxQs5dCmREhQpYgQd4j4FuvBjWwINh+BvMfCiQm/ydEEu6h+7mOUhcTWBab0pibAdEGVzPdoX3s65WwhbCPzTbzEBShERMGMM0GEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(36756003)(31696002)(15650500001)(6666004)(38100700002)(6506007)(478600001)(6512007)(2616005)(6486002)(53546011)(2906002)(66476007)(316002)(66556008)(66946007)(110136005)(31686004)(4326008)(8936002)(8676002)(26005)(5660300002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3Zha1JkMldHbWgyMnV4RmNHbWd0RHNBeHhlS1hnQVp6STA2S01oQXZZak1p?=
 =?utf-8?B?KzF1WjZHaWVCU2xSM1FoUjQ5K1dEUTJjQ29hU3JIS28zc25QQ09FM21HRjI3?=
 =?utf-8?B?TGZvR0ZjUjBla2lTM3dmTDA0cnQ3Y0dOdXBndXJqdmltMGZDUmR4UEM0eU45?=
 =?utf-8?B?WFUyaGpyZENHemJBZ1E0Vk1qVHFENDgrdHhuVHU5ZnhCY0pubDRnMGNlWGlG?=
 =?utf-8?B?cUFPeDhlcUtDQ0xYd0svblp0anQ1Si92R2NNaDlmQVdXeXJqa0ptTUNzNHgz?=
 =?utf-8?B?MTRoNmEraWxUSEJkSlhPNElaZStPdjRERTdQUVpYWjdHeWUzUk5ienFtVm8y?=
 =?utf-8?B?R2pFeEd2dWZHeVNlT09ZYzB3aTQ3cXRob1BheDlsSHg4VkYwbEJZdWlpNXFk?=
 =?utf-8?B?eXFWTjRvZXczajBKOXRjM28wMk1rRjRlcjVob29ZR002TTdVUk9jTDFQM2Ev?=
 =?utf-8?B?OHpDVmRaY2tJWlpXZDVKRkwzRkp2UTBYU3lUaDRiNDJ4YkJpOGV6aVB5d2Vs?=
 =?utf-8?B?cHEwYmcvbnUveU1kc0JkaXVyTzBGTlZtVXduUTZOV3VFUlB5SjJxdlREMnVH?=
 =?utf-8?B?NFovMUszeG1SWko2Z2tEaElXUG9SVld3MlkrbW1HMFo3YmJGcEtySGFuRG04?=
 =?utf-8?B?NGI4Qm56NlRPMUZ3ZExoQXA2VWN1S0IrT1ozbi8rbGlialRETUsyLzFxMzFD?=
 =?utf-8?B?aGRDTzgrSXF6L24wNmgzMUQ2aU1Nek5FMmRxZmdVWHRlODNpSGwxZGwyOWJk?=
 =?utf-8?B?K3ZiTkg4VEVoTC9UbDVJNndqeXYyYXl1RUpDVTR2RklVMTdYcHYzZm9UQVZz?=
 =?utf-8?B?M0s0ZEJWZVg4SzNHbitNRGVOT3NzS25CVFo2MkcvVTBZb2V3UDUyOGVndVpO?=
 =?utf-8?B?THNzYjFnVEdWckZlckNqdmRaa3Jhb3FVRXhnZy9WdGU5RWcvUStlN0N6aHlp?=
 =?utf-8?B?WHY4V1VRcWhZVGxnQlhGalJTUWFCKzV4cXdrdjhzU0JmZFpZdEJKb0szNmg1?=
 =?utf-8?B?QllDeDFGNHY0ZEt1UDZmVUJ4NjUyd3NpaU1MWU84RG4rS2NzVEp3K3RWME1o?=
 =?utf-8?B?dVF6OE83ajRXMmhxZ05mUHBNZE9RdkExb1FHK25tcmZjZERiL1ArODVyZHhi?=
 =?utf-8?B?MTg2cDd5ZG1Ubk9hR3pJUklBRmJVY3o5YUg3S1ZQbjBrMk1mMTZEemI0bzMv?=
 =?utf-8?B?eVRWcEh2R1BIUEJRWVFVYUlpcEVjUE5SdXVTNUM3Qk5xdjRqSktHNjJBRzQ0?=
 =?utf-8?B?ZDMyV05GcVJNcm0wUlBxWExmOTdIQmNrczdObjBzTkkyNHNodFQ1TU11TklU?=
 =?utf-8?B?elZHN0xZd3NNSWxtbG1XWmEyYm44N3h5NmlUQjJkZzVVZ1E1RG91b2dHa0JW?=
 =?utf-8?B?ZlBmRTIrOWZhZlRYQW5mV0k1OUVCb3hVRDlYZTJqbDJNNVFiUncrZUtCVUtr?=
 =?utf-8?B?ZTMzUzgvRC9yRFY5ZmUreVBmVDM4QW0wR05CVllhVko2L1htNTRPeXFGeUpS?=
 =?utf-8?B?RHdaN3FPSE8vTUJXM3A1MExNRXNWeTRsN284aHpYSHBmNTUxakpqNUhMQVVG?=
 =?utf-8?B?OXJBUEVGcXJYNHdNRXRpdEk3YzZBWmpVRVFuSVhRTTNwM3BBckdVbVFXb2hV?=
 =?utf-8?B?RFZHZWNiekVFQTM5RllGTFRsZno1YTJORThLZHNWUFdXbFo0ejFoQ2hYTlNK?=
 =?utf-8?B?dklXT3pJYng4Vjc1bTVDcGRoMExjbm1DK1BSU2cxVFhCM25yNkVkN0Q5WFJw?=
 =?utf-8?B?VEtXQWIxa2M0bFdMa1NYblphaitPYUdBMHRFbi80MlJHN1ZwWEJMTXYxR0hv?=
 =?utf-8?B?dU9oa3ZMT0c2ZW9mVnlESmZOVVdXMENmaFJWMkxjZGx6VVdLZVFUN0FJd29H?=
 =?utf-8?B?WTIrZmRiaUt6Z2FkSXlZaU9RWHNmTDY1QUVnYU1xVUJ0aDZ0L2NaWWtVRWl4?=
 =?utf-8?B?SDQ0SG1ZckdySytqVU1YSGk1b2RIUG5iak1oZUJZU3lKOGFzYTRudUt3Yk1r?=
 =?utf-8?B?eHdWK2doTFpWeitDSG03YlJXTGNDOEE5a0c4bnh5RitLWE9Hd3BDdS9obWZ4?=
 =?utf-8?B?SzU5RjNBbFhPYVpJVlBwM1RFTU5wdElWVHNJRGE2V0VNMFJzeVg3am5XZWVa?=
 =?utf-8?Q?n21o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb144248-3d02-4442-018d-08dbbf6635b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 14:29:51.3129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HDknLuzSeNSxtuWal9lHz5O4cC1TjSNhOs9gvQYKlbGiMScBGGCNgh1KQsXKEe2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-09-26 16:43, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1d6af500-2a17-0f95-3c86-024cdded0fa9@amd.com">
      <br>
      On 9/22/2023 4:37 PM, Philip Yang wrote:
      <br>
      <blockquote type="cite">Caution: This message originated from an
        External Source. Use proper caution when opening attachments,
        clicking links, or responding.
        <br>
        <br>
        <br>
        Otherwise kfd flush tlb does nothing if vm update fence callback
        doesn't
        <br>
        update vm-&gt;tlb_seq. H/W will generate retry fault again.
        <br>
        <br>
        This works now because retry fault keep coming, recover will
        update page
        <br>
        table again after AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING timeout
        and flush
        <br>
        tlb.
        <br>
      </blockquote>
      <br>
      I think what this patch does is waiting vm-&gt;last_update fence
      at gpu page fault retry handler. I do not know what bug it tries
      to fix. h/w will keep generating retry fault as long as vm page
      table is not setup correctly, no matter kfd driver waits the fence
      or not. vm page table eventually will be setup.
      <br>
    </blockquote>
    <p>This issue was there, I notice it when implementing the
      granularity bitmap_mapped flag for mGPUs, to skip the retry fault
      if prange mapped on the GPU. The retry fault keep coming after
      updating GPU page table, because restore_pages -&gt;
      svm_range_validate_and_map doesn't wait for vm update fence before
      kfd_flush_tlb.<br>
    </p>
    <p>It is working now because we handle the same retry fault again
      after timeout AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING, and
      kfd_flush_tlb does flush on the second time.<br>
    </p>
    <p>The issue only exist if using sdma update GPU page table, as no
      fence if cpu update GPU page table.</p>
    <p>There are several todo items to optimize this further:<br>
    </p>
    <p>A. After updating GPU page table, we only wait for fence and
      flush tlb if updating existing mapping, or vm params.table_freed
      (this needs amdgpu vm interface change).<br>
    </p>
    <p>B. Use sync to wait mGPUs update fences.</p>
    <p>C. Use multiple workers to handle restore_pages.<br>
    </p>
    <blockquote type="cite" cite="mid:1d6af500-2a17-0f95-3c86-024cdded0fa9@amd.com">
      <br>
      There is a consequence I saw: if we wait vm page table update
      fence it will delay gpu page fault handler exit. Then more h/w
      interrupt vectors will be sent to sw ring, potentially cause the
      ring overflow.
      <br>
    </blockquote>
    <p>retry CAM filter, or sw filter drop the duplicate retry fault, to
      prevent sw ring overflow.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:1d6af500-2a17-0f95-3c86-024cdded0fa9@amd.com">
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">Remove wait parameter in
        svm_range_validate_and_map because it is
        <br>
        always called with true.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 +++++++--------
        <br>
        &nbsp; 1 file changed, 7 insertions(+), 8 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 70aa882636ab..61f4de1633a8 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1447,7 +1447,7 @@ svm_range_map_to_gpu(struct
        kfd_process_device *pdd, struct svm_range *prange,
        <br>
        &nbsp; static int
        <br>
        &nbsp; svm_range_map_to_gpus(struct svm_range *prange, unsigned long
        offset,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long npages, bool readonly,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *bitmap, bool wait, bool
        flush_tlb)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *bitmap, bool flush_tlb)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev = NULL;
        <br>
        @@ -1480,8 +1480,7 @@ svm_range_map_to_gpus(struct svm_range
        *prange, unsigned long offset,
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpu(pdd, prange, offset,
        npages, readonly,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        prange-&gt;dma_addr[gpuidx],
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_adev, wait ?
        &amp;fence : NULL,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_adev, &amp;fence,
        flush_tlb);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        <br>
        @@ -1605,7 +1604,7 @@ static void *kfd_svm_page_owner(struct
        kfd_process *p, int32_t gpuidx)
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; static int svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange,
        int32_t gpuidx,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool intr, bool wait, bool
        flush_tlb)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool intr, bool flush_tlb)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_validate_context *ctx;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, end, addr;
        <br>
        @@ -1729,7 +1728,7 @@ static int
        svm_range_validate_and_map(struct mm_struct *mm,
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_map_to_gpus(prange,
        offset, npages, readonly,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        ctx-&gt;bitmap, wait, flush_tlb);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        ctx-&gt;bitmap, flush_tlb);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r &amp;&amp; next == end)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapped_to_gpu = true;
        <br>
        @@ -1823,7 +1822,7 @@ static void svm_range_restore_work(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;migrate_mutex);
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange,
        MAX_GPU_INSTANCE,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, true,
        false);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, false);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map 0x%lx to
        gpus\n&quot;, r,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start);
        <br>
        @@ -3064,7 +3063,7 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange, gpuidx,
        false, false, false);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange, gpuidx,
        false, false);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map svms 0x%p [0x%lx
        0x%lx] to gpus\n&quot;,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r, svms, prange-&gt;start,
        prange-&gt;last);
        <br>
        @@ -3603,7 +3602,7 @@ svm_range_set_attr(struct kfd_process *p,
        struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb = !migrated &amp;&amp; update_mapping
        &amp;&amp; prange-&gt;mapped_to_gpu;
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_validate_and_map(mm, prange,
        MAX_GPU_INSTANCE,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, true,
        flush_tlb);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; true, flush_tlb);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map svm
        range\n&quot;, r);
        <br>
        <br>
        --
        <br>
        2.35.1
        <br>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
