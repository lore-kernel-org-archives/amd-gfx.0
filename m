Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44E6C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 15:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5A089E3F;
	Mon, 22 Nov 2021 15:55:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDAF89E0E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 15:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOWafoPXH+yoImig2Sf42VS96eTvmRTz063WDFtq/IDg0jd/ZmZHGebg7SVwNaNowNqw2TUHLw7eg9NqXgTYOtPpC407bExV0tzgAwaD0T0CAcv+6mIGDiipZj9C13kx/VsU5HAMaiQPTLfa6/Wrgm44paXK5GJpuk5LCaZVK9xTwdNXy6Td3O62RNmGv/XbcBsRvocCmfe/quFY9U2BvUX3qLb0DZ4hfCMVEyoNO5VVCIxgv7T/gj8YBxRRykwbjj6Z3ZJBFVkyu1ZvLXW9ay+BwLusDEUIRbLo3yL9mS4NsgxlC83JADKgUhYNEb0R/zQGS8BH/T0KPQpP+EKb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYWfAjlx87vmCzdpjhUTnwK9MY8rPtCePWjMtwFYXbo=;
 b=UMKrYeuBVDId7z+A/0i+c10sgk9gj9jefD8KUSmvsARUDxN1hztLeP2aQV2uuyTI6a8+nM/ucphBMf6LOmbIBrgWEauhHm01duPtRUPWbjnZAJvwkj6z5hdCR4NjcEmNzT8ZVrALY0TwB+YW3/O2VUmOWEKUPm940TDY1JJqcw6YkUN2FlT51zgjjS3whgD+FJ8RQ0jEpWPMt/zYPT8MAaA2qIJtHdkUqv2AyzcwkK9J+gGVxFwhtXiMzXsSv4Bj/QVXD09P7TEo6szbFWXxiELc5rb0v+8MfZmuNxC8Fu+FHjXz8aq0wdM0w1eHsEa5DhgH9DPXq915d19B+aFpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYWfAjlx87vmCzdpjhUTnwK9MY8rPtCePWjMtwFYXbo=;
 b=2A5HWYCb4fxVm3gwihs52eymY3qE1j6Yc6EV9/tHSkmrG9cp2IAAUFpOjrVTAv28PKVIjJBNR+bFAKsAT3i38VMj1G6gxnDvXFVIWioyHMQIpjcIsmjiJXr+eB+srKfthv0PO/Avymo39+diOYaqjTfa5vf/V01oGXjOu9drzbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 22 Nov
 2021 15:55:35 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 15:55:34 +0000
Subject: Re: [PATCH v2] drm/amdkfd: handle IH ring1 overflow
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211119202233.13486-1-Philip.Yang@amd.com>
 <2a610519-689f-c3d0-3675-59f7c64eaf4f@amd.com>
 <3d49a81d-793f-177f-606a-2c405685036e@amd.com>
 <64e46791-cbe5-1bcb-93e2-be52d2dcce0c@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <339f6845-2f61-5896-987b-532af0692245@amd.com>
Date: Mon, 22 Nov 2021 10:55:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <64e46791-cbe5-1bcb-93e2-be52d2dcce0c@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:32b::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BLAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Mon, 22 Nov 2021 15:55:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d82b9c0b-d88b-4730-0583-08d9add084f3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:
X-Microsoft-Antispam-PRVS: <DM4PR12MB531114B305E365220C29F4C3E69F9@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0g6h5ytw46qMRaGzZMcDfx7TW/rEYbt+UustftE1747zoEKuFLJyJbbzc4RgzC1WoZGSMfsLQc6j0f52j2FicH1+6QaOLvqdRKP+K1gqSVVxRLeWw4PIEWuPnY4wIrwHF1lvgPrxhxSWfWyzCY0CxuFzJhgfQTAJnhRedOpQUshtH6hyYQB58QRGQf5qJQCzbEtMjyJiA9WIH3HuNPBSd6AaRzkdy8zSQAGnlIKfK5+h+TxGOnmgh/COHILxSxxg9dYbWR655eH6iFO5HnwZvNlnY1fvEVv0ylWLjwE/Wb2p11AvFNaWMwEKUCJi1KSXFeA2Jl5+YNW0BrIm79NDUl1ROzJYW/K7OPaPxzc9pONk3Sbaj2aWV18pnv0/TlPI1dq1qcO7hy+SNggHie0/dU7sY2wH12a25sZY08wcAYWmTTlSe+a/IXHqvMiA69E5aD+SfhYvCUAbOYGH+fWgNNHpYSjQj4u1R01gL9vDCUix8f3ligdI9EwznhpcGDh6uVbLeuY2fUoiqZPG8HFWenwnk2BHt9ogzwyKZFdSsRSbOmH2ShU3Mvlh1tXn++ukkWkBHzOlISEkk4HUkUgQt+Hl93u19gKI1x9WNjJdBG5qdIfrL2pMmh1N1sG2oCVY3kkPI+y0GfcvnQiCxGBZTxH9nY6jMShDi9zpWfKdY/h9+ys5DMmFO7MeEb9DrS82xfWAaBv28EZwDluq0RqgnpIKiPPM/kJ6CW6O1h2N3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(83380400001)(508600001)(8936002)(38100700002)(110136005)(4001150100001)(186003)(66574015)(316002)(956004)(6486002)(16576012)(2616005)(31686004)(8676002)(5660300002)(66556008)(26005)(2906002)(66476007)(36756003)(66946007)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFRnQ0lOUGZYTXFOVGpXeUpDTUVJU1ZOd25oVUxRa29UdUQyLysyM2ZVSzZC?=
 =?utf-8?B?SDZyV0JUZjd2V0liTHUwUFhzYzhaUnI4ZmFBdVFSa0N5OENWaHBtR2xuNHUw?=
 =?utf-8?B?R0JsRVl6eU8ycTlqbTIwUENtZkdyYlhXWFhsa2d4UzNrTUllTjQ1K0hFVjZ3?=
 =?utf-8?B?Mk1wcm5XNm9MUFRKdU84UGpudmo1VzVvMFlIb3BKR3RXbnZlK256dy9lYUV0?=
 =?utf-8?B?bkFTMmswWmJHQVBSeWZBYlY1elpoYlVXNEhHQzBpZW44TzkxUkg2LzZRcng5?=
 =?utf-8?B?S1JaWDRsRm0vTlZ0SmlWTWwxZW5xdVVXR3h2MmxCZ3pVVUM0c21yalo2QzhK?=
 =?utf-8?B?SlNjb0M1Zndic3RHRUszMHU2SXhNOFdJM3U1ODlLbnUvZ2lUMEk1M1pOQkdY?=
 =?utf-8?B?ZUJwd293bGo3YkJqQWR0eFBPcExrbUtsYW9tNHF4Y1pOL21RNVRvL3pacTdD?=
 =?utf-8?B?WmxpdEJXaTFYRFg4VDhQcmNjZnR2bUlTSER5OC9BV3JsNkJrR1ROdHFDWUVr?=
 =?utf-8?B?ZisyM3VKNFNJcGowWnZUd1RBSUM1d2dINzV3aGd1U0MyMFdtWDBtaENZY3Yr?=
 =?utf-8?B?UkpRcWttZGNIbzVpRUpjbmJtQVNNTUVuaExZOVE3b3l0dVU2N3kwVU9UMUF6?=
 =?utf-8?B?UnBOTFlSMEZ1aFNaZ05HWHRhTDR0UHNlYVR2MHR4ekRERWlpd291VGs0Vys4?=
 =?utf-8?B?bHp3eHRudVRIbkY2dkZ0L2hrVitDT2wyUmlyQldVdzlhNkRZbGxwQmtRRGhN?=
 =?utf-8?B?Y2hwbVZPeGM3akZ1S0pnZWZJakJtZTR5RkRieVk4ZEw1eUNMTHpjclczdVZV?=
 =?utf-8?B?cFAyeFdyOTFxbTlkcVpnOGgxckpXUFN6R0c1QnNFOWkrNHRrTEpyRU4rQTJT?=
 =?utf-8?B?TmdkT3ZpNWg1YU1TRUh5UmtVMW54ZlRZeEtTQkhESWxOUVJNbElFdTFyUGN0?=
 =?utf-8?B?aWdJUVNGd1N2REtXMnM3WVBHRVcvTlNCMjg2RnJGTHpNeEJ3NHZyZVRQTWJB?=
 =?utf-8?B?SFJyOC9mbTdzMlJWc3RlWERyME9IUkRXcTg5UUJpRkpnSDJZeVpqa0E5ZWNO?=
 =?utf-8?B?dkI4Vk1UeFpLeDdKVjV5VENwYVk5L1NqLzZrekJZK2xtQk0wa3NCQ0l5SCtP?=
 =?utf-8?B?QVg5NVJRVFVVdlBPNDhkQStoaGtIRG1DdlBSelQ3Z2Q1UzdmRzNoU2JhQmoz?=
 =?utf-8?B?bExFaTY0SmhUcVRYYWpGQ3BoajZESVl6Z3h5eUllbi8vdFBkcUVKbXhLdWRK?=
 =?utf-8?B?ZElNaWhtYzRJSmlscG55QTVkY0N1TS9RZXIxQ082QUlHNWdMVDVpMHNzQ0N4?=
 =?utf-8?B?dkNiL21VNlBjVHVGZG5ITlN4bTRnZnQvOGsxWUhMNmZtRHdhNkl5Zmt1RElW?=
 =?utf-8?B?S0VmMkw0OUVFa3VROVdWZGFwVUNldzNubzN3Ym1RUEpNYUFVVGdZZzJmaThH?=
 =?utf-8?B?Yy8vU1ZCMm1zbjhQTVV1VjVha2ZTU2REcUNyaE96SzBiT1B4ekhkeE8yVU1S?=
 =?utf-8?B?S3AvS1c0cTFjOTN6YWZiTE40MDArRTJuSFp3TTZoeDlSYXR1WkxWdmVXb3FK?=
 =?utf-8?B?TFRnQzBZcldQTlVSYXZUMTFML2d2MGhQSmdiNVRMZFd2VGNrckJyNUkzTEZP?=
 =?utf-8?B?L1VyOVIrTmlycVJaS25Tb01JMzFuY05CbXUxbkN6dTRJQ0dYcDFzaGRzdlVq?=
 =?utf-8?B?RWNndS9BZ3FsS1Z0bnRTR3lsVFE0UjdUNkFGRUhrbXNLem5qNXZRb3BuMUo0?=
 =?utf-8?B?dnFvTHVQR0lzeTdGS3dOVnByeXcyZFNtMXhWb1Q3ZENaTEI0Y0lFa3lkcHU0?=
 =?utf-8?B?QXlzZ0hJRHVCcDZqWVR5TW83K2JVZ3p6dm5uR3VuNWR0YXFlWUFPcmtXNEhh?=
 =?utf-8?B?NHg5cVBlY21QYStYTkUrODdVdUp6c2FKRk1PbmZiNXlTVzllMHNtNWNXVXA5?=
 =?utf-8?B?VXFvQnJEYWtYM1AyWTR6QlZTVDZ3OThtOTdTWUt4Q01rSEVlamsxR2dtTjFj?=
 =?utf-8?B?NFRMcm1WN3gydldZa2pDL1RIK1dsT04waEQ5enpVdGJ0ckYxck1vbjFxMFJy?=
 =?utf-8?B?b2sweXBmR0cyZGl0YXcxNi84VGdWeDRCNDNhZm9TeFQxWDMwS294S2xoYWlr?=
 =?utf-8?Q?uaZs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82b9c0b-d88b-4730-0583-08d9add084f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 15:55:34.7705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyHLIUjbdUjgVk+Vg6eVvN1yy5M/oOsIoKJQSYxIm79D9pxNmY63ZycUTNI4wwKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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
    <div class="moz-cite-prefix">On 2021-11-22 6:34 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:64e46791-cbe5-1bcb-93e2-be52d2dcce0c@amd.com">Am
      21.11.21 um 03:13 schrieb philip yang:
      <br>
      <blockquote type="cite">
        <br>
        On 2021-11-19 5:59 p.m., Felix Kuehling wrote:
        <br>
        <br>
        <blockquote type="cite">On 2021-11-19 3:22 p.m., Philip Yang
          wrote:
          <br>
          <blockquote type="cite">IH ring1 is used to process GPU retry
            fault, overflow is enabled to
            <br>
            drain retry fault because we want receive other interrupts
            while
            <br>
            handling retry fault to recover range. There is no overflow
            flag set
            <br>
            when wptr pass rptr. Use timestamp of rptr and wptr to
            handle overflow
            <br>
            and drain retry fault.
            <br>
            <br>
            Add helper function amdgpu_ih_decode_iv_ts to get 48bit
            timestamp from
            <br>
            IV entry. drain retry fault check timestamp of rptr is
            larger than
            <br>
            timestamp of (checkpoint_wptr - 32).
            <br>
            <br>
            Add function amdgpu_ih_process1 to process IH ring1 until
            timestamp of
            <br>
            rptr is larger then timestamp of (rptr + 32).
            <br>
            <br>
            Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c&nbsp; | 98
            +++++++++++++++++++------
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h&nbsp; |&nbsp; 6 +-
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |&nbsp; 2 +-
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-
            <br>
            &nbsp; 4 files changed, 80 insertions(+), 28 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
            <br>
            index f3d62e196901..ad12f9d5d86a 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
            <br>
            @@ -165,51 +165,41 @@ void amdgpu_ih_ring_write(struct
            amdgpu_ih_ring *ih, const uint32_t *iv,
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /* Waiter helper that checks current rptr matches or
            passes checkpoint wptr */
            <br>
            -static bool amdgpu_ih_has_checkpoint_processed(struct
            amdgpu_device *adev,
            <br>
            +static bool amdgpu_ih_has_checkpoint_processed_ts(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checkpoint_wptr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *prev_rptr)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t checkpoint_ts)
            <br>
            &nbsp; {
            <br>
            -&nbsp;&nbsp;&nbsp; uint32_t cur_rptr = ih-&gt;rptr | (*prev_rptr &amp;
            ~ih-&gt;ptr_mask);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; /* rptr has wrapped. */
            <br>
            -&nbsp;&nbsp;&nbsp; if (cur_rptr &lt; *prev_rptr)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_rptr += ih-&gt;ptr_mask + 1;
            <br>
            -&nbsp;&nbsp;&nbsp; *prev_rptr = cur_rptr;
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; /* check ring is empty to workaround missing wptr
            overflow flag */
            <br>
            -&nbsp;&nbsp;&nbsp; return cur_rptr &gt;= checkpoint_wptr ||
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cur_rptr &amp; ih-&gt;ptr_mask) ==
            amdgpu_ih_get_wptr(adev, ih);
            <br>
            +&nbsp;&nbsp;&nbsp; /* After wakeup, ih-&gt;rptr is the entry which is
            being processed, check
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * the timestamp of previous entry which is processed.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; return checkpoint_ts &lt;= amdgpu_ih_decode_iv_ts(ih,
            ih-&gt;rptr - 32);
            <br>
          </blockquote>
          <br>
          This assumes a IV size of 32 bytes, which is not true for all
          ASICs. On GFXv8 and older GPUs it's on 16. OTOH, those chips
          don't have a ring1 and may not have a timestamp in the IV at
          all.
          <br>
          <br>
        </blockquote>
        ring1 process is enabled for vega10/20, navi10, not for older
        GPUs, as it is scheduled from self-irq.
        <br>
      </blockquote>
      <br>
      I think we should try to avoid accessing the IH ring buffer
      outside of the handler anyway.
      <br>
      <br>
      So instead of that here we should probably just always update the
      last decoded timestamp after a call to
      amdgpu_ih_decode_iv_helper().
      <br>
    </blockquote>
    Good point, add ih-&gt;processed_timstamp in v4 as the last decoded
    timestamp.<br>
    <blockquote type="cite" cite="mid:64e46791-cbe5-1bcb-93e2-be52d2dcce0c@amd.com">
      <br>
      <blockquote type="cite">
        <blockquote type="cite">And I think you need to be better at
          handling when the time stamps wrap. Keep in mind that the
          number of valid bits may vary between ASICs.
          <br>
          <br>
        </blockquote>
        yes, 48bit time stamp will wrap around after 1 year, add
        function amdgpu_ih_ts_after to compare time stamp with wrap
        around case.
        <br>
      </blockquote>
      <br>
      Yeah, I think we need to handle that gracefully.
      <br>
    </blockquote>
    <p>v4 also uses le32_to_cpu to read timestamp to support big endian
      platform.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:64e46791-cbe5-1bcb-93e2-be52d2dcce0c@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <br>
          <blockquote type="cite">&nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            - * amdgpu_ih_wait_on_checkpoint_process - wait to process
            IVs up to checkpoint
            <br>
            + * amdgpu_ih_wait_on_checkpoint_process_ts - wait to
            process IVs up to checkpoint
            <br>
            &nbsp;&nbsp; *
            <br>
            &nbsp;&nbsp; * @adev: amdgpu_device pointer
            <br>
            &nbsp;&nbsp; * @ih: ih ring to process
            <br>
            &nbsp;&nbsp; *
            <br>
            &nbsp;&nbsp; * Used to ensure ring has processed IVs up to the
            checkpoint write pointer.
            <br>
            &nbsp;&nbsp; */
            <br>
            -int amdgpu_ih_wait_on_checkpoint_process(struct
            amdgpu_device *adev,
            <br>
            +int amdgpu_ih_wait_on_checkpoint_process_ts(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih)
            <br>
          </blockquote>
          <br>
          If this function is only meant to work on ring1 now, we should
          probably ensure that by checking that ih is really ring1.
          <br>
          <br>
        </blockquote>
        Add dev_WARN_ONCE(adev-&gt;dev, ih != &amp;adev-&gt;irq.ih1,
        &quot;not ring1&quot;)) to ensure this is only for ring1.
        <br>
        <br>
        <blockquote type="cite">Do we need to keep the old solution for
          Vega20, which doesn't reroute interrupts to ring1?
          <br>
          <br>
        </blockquote>
        Vega20 is not changed, because Vega20 retry fault delegate to
        ih_soft, and wptr overflow is not enabled on ih_soft, no stale
        retry fault issue, keep old interrupt handler for ih_soft.
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">&nbsp; {
            <br>
            -&nbsp;&nbsp;&nbsp; uint32_t checkpoint_wptr, rptr;
            <br>
            +&nbsp;&nbsp;&nbsp; uint32_t checkpoint_wptr;
            <br>
            +&nbsp;&nbsp;&nbsp; uint64_t checkpoint_ts;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ih-&gt;enabled || adev-&gt;shutdown)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
            <br>
            -&nbsp;&nbsp;&nbsp; /* Order wptr with rptr. */
            <br>
            +&nbsp;&nbsp;&nbsp; /* Order wptr with ring data. */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rmb();
            <br>
            -&nbsp;&nbsp;&nbsp; rptr = READ_ONCE(ih-&gt;rptr);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; /* wptr has wrapped. */
            <br>
            -&nbsp;&nbsp;&nbsp; if (rptr &gt; checkpoint_wptr)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr += ih-&gt;ptr_mask + 1;
            <br>
            +&nbsp;&nbsp;&nbsp; checkpoint_ts = amdgpu_ih_decode_iv_ts(ih,
            checkpoint_wptr - 32);
            <br>
          </blockquote>
          <br>
          Same as above.
          <br>
        </blockquote>
        done in v3
        <br>
        <blockquote type="cite">
          <br>
          <br>
          <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
            wait_event_interruptible(ih-&gt;wait_process,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_has_checkpoint_processed(adev,
            ih,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr, &amp;rptr));
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_has_checkpoint_processed_ts(adev,
            ih,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_ts));
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            @@ -253,6 +243,56 @@ int amdgpu_ih_process(struct
            amdgpu_device *adev, struct amdgpu_ih_ring *ih)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;
            <br>
            &nbsp; }
            <br>
            &nbsp; +/**
            <br>
            + * amdgpu_ih_process1 - interrupt handler work for IH ring1
            <br>
            + *
            <br>
            + * @adev: amdgpu_device pointer
            <br>
            + * @ih: ih ring to process
            <br>
            + *
            <br>
            + * Interrupt handler of IH ring1, walk the IH ring1.
            <br>
            + * Returns irq process return code.
            <br>
            + */
            <br>
            +int amdgpu_ih_process1(struct amdgpu_device *adev, struct
            amdgpu_ih_ring *ih)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; uint64_t ts, ts_next;
            <br>
            +&nbsp;&nbsp;&nbsp; unsigned int count;
            <br>
            +&nbsp;&nbsp;&nbsp; u32 wptr;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (!ih-&gt;enabled || adev-&gt;shutdown)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IRQ_NONE;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; wptr = amdgpu_ih_get_wptr(adev, ih);
            <br>
            +&nbsp;&nbsp;&nbsp; if (ih-&gt;rptr == wptr)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            +
            <br>
            +restart_ih:
            <br>
            +&nbsp;&nbsp;&nbsp; count = AMDGPU_IH_MAX_NUM_IVS;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; ts = amdgpu_ih_decode_iv_ts(ih, ih-&gt;rptr);
            <br>
            +&nbsp;&nbsp;&nbsp; ts_next = amdgpu_ih_decode_iv_ts(ih, ih-&gt;rptr + 32);
            <br>
          </blockquote>
          <br>
          Same as above.
          <br>
          <br>
        </blockquote>
        Done in v3
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp; while (ts &lt; ts_next &amp;&amp;
            --count) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_dispatch(adev, ih);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr &amp;= ih-&gt;ptr_mask;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ts = ts_next;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ts_next = amdgpu_ih_decode_iv_ts(ih, ih-&gt;rptr +
            32);
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; /*
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * Process the last timestamp updated entry or one more
            entry
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * if count = 0, ts is timestamp of the entry.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_irq_dispatch(adev, ih);
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_ih_set_rptr(adev, ih);
            <br>
            +&nbsp;&nbsp;&nbsp; wake_up_all(&amp;ih-&gt;wait_process);
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; wptr = amdgpu_ih_get_wptr(adev, ih);
            <br>
            +&nbsp;&nbsp;&nbsp; /* Order reading of wptr vs. reading of IH ring data */
            <br>
            +&nbsp;&nbsp;&nbsp; rmb();
            <br>
            +&nbsp;&nbsp;&nbsp; if (ts &lt; amdgpu_ih_decode_iv_ts(ih, wptr - 32))
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto restart_ih;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return IRQ_HANDLED;
            <br>
            +}
            <br>
            +
            <br>
            &nbsp; /**
            <br>
            &nbsp;&nbsp; * amdgpu_ih_decode_iv_helper - decode an interrupt vector
            <br>
            &nbsp;&nbsp; *
            <br>
            @@ -298,3 +338,13 @@ void amdgpu_ih_decode_iv_helper(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wptr/rptr are in bytes! */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr += 32;
            <br>
            &nbsp; }
            <br>
            +
            <br>
            +uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih,
            u32 rptr)
            <br>
          </blockquote>
          <br>
          This function needs to be in IP-version-specific code. Maybe
          add an offset parameter, that way you can handle different IV
          sizes in different ASIC generations.
          <br>
          <br>
        </blockquote>
        Add decode_iv_ts function interface to amdgpu_ih_function, this
        will be used for different ASICs, to handle different IV size
        and time stamp offset. vega*, navi* ASICs use this as helper
        function.
        <br>
        <br>
        Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">+{
            <br>
            +&nbsp;&nbsp;&nbsp; uint32_t index = (rptr &amp; ih-&gt;ptr_mask) &gt;&gt;
            2;
            <br>
            +&nbsp;&nbsp;&nbsp; uint32_t dw1, dw2;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; dw1 = ih-&gt;ring[index + 1];
            <br>
            +&nbsp;&nbsp;&nbsp; dw2 = ih-&gt;ring[index + 2];
            <br>
            +&nbsp;&nbsp;&nbsp; return dw1 | ((u64)(dw2 &amp; 0xffff) &lt;&lt; 32);
            <br>
            +}
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
            <br>
            index 0649b59830a5..15e8fe0e5e40 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
            <br>
            @@ -89,10 +89,12 @@ int amdgpu_ih_ring_init(struct
            amdgpu_device *adev, struct amdgpu_ih_ring *ih,
            <br>
            &nbsp; void amdgpu_ih_ring_fini(struct amdgpu_device *adev,
            struct amdgpu_ih_ring *ih);
            <br>
            &nbsp; void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const
            uint32_t *iv,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw);
            <br>
            -int amdgpu_ih_wait_on_checkpoint_process(struct
            amdgpu_device *adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih);
            <br>
            +int amdgpu_ih_wait_on_checkpoint_process_ts(struct
            amdgpu_device *adev,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih);
            <br>
            &nbsp; int amdgpu_ih_process(struct amdgpu_device *adev, struct
            amdgpu_ih_ring *ih);
            <br>
            +int amdgpu_ih_process1(struct amdgpu_device *adev, struct
            amdgpu_ih_ring *ih);
            <br>
            &nbsp; void amdgpu_ih_decode_iv_helper(struct amdgpu_device
            *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry);
            <br>
            +uint64_t amdgpu_ih_decode_iv_ts(struct amdgpu_ih_ring *ih,
            u32 rptr);
            <br>
            &nbsp; #endif
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
            <br>
            index e9023687dc9a..891486cca94b 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
            <br>
            @@ -224,7 +224,7 @@ static void amdgpu_irq_handle_ih1(struct
            work_struct *work)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = container_of(work, struct
            amdgpu_device,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq.ih1_work);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; amdgpu_ih_process(adev, &amp;adev-&gt;irq.ih1);
            <br>
            +&nbsp;&nbsp;&nbsp; amdgpu_ih_process1(adev, &amp;adev-&gt;irq.ih1);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            index 88360f23eb61..9e566ec54cf5 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            @@ -1968,7 +1968,7 @@ static void
            svm_range_drain_retry_fault(struct svm_range_list *svms)
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms %p\n&quot;,
            i, svms);
            <br>
            &nbsp; -
            amdgpu_ih_wait_on_checkpoint_process(pdd-&gt;dev-&gt;adev,
            <br>
            +
            amdgpu_ih_wait_on_checkpoint_process_ts(pdd-&gt;dev-&gt;adev,
            <br>
            &amp;pdd-&gt;dev-&gt;adev-&gt;irq.ih1);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms 0x%p
            done\n&quot;, i, svms);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
