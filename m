Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489F3C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16DE9613D3
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DE9613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED216E06E;
	Fri, 11 Jun 2021 17:55:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044D16E06E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 17:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZMoO9d5aPIa/V2P5zMwhDaJwC4mZKHkXA6HQXFNdThi619XHY23Md0mnClxEMh5qllk1wHa88oW7YdMJgZQyznx+hqFqO1NFSnQTfcsw2M+A03LEYBHTd/sVlfcSDcWhwN1eHs2wVnJgmSPjeKc/SlwoIHMyO7Q6hWO/udu3clz0g4Dr/k5QaOEnLOSsfCAZ5jF4UA84qSTpK586Y85Og9Sjj6YrORgnYddjkWfC1UcpYkFfAvBDVGpaANkMt4MztQHxEjZunJitFOWR9JjQ03yoUCHGAgfLKxbOgI0fClHqq8Spi2IZocoJqPk3uekU2/3xIt7tybejd9wit/VaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnmZ8Hkne4640jHM9scqI6EO+IOnqToStZGUHm5yijc=;
 b=F37QcwvxV46AB0FPrXycbjpAt1Joyr4BWJyB43sv4AFjHlwVa/1nLuEm5BEbVllMCQRORXejtuSVL9jdlPodrNI2/hfMJqAdLAqgYF1toTQiPrlBFI2wk14Y+sYt+nWIUHkSw6w3lkSVwvifWxsKlsFQ+qbIOGR9z5EZ5zmjoLS4asjTRRN7VKnjgz7TlBxpsLKJAtH+0RXbcHTADe77F821Ibv0h0bIOec+ETpAVVEIq8xj6LlXg0nvUXWOHWHpzNX0NKSE0g2/bsE8PaFzgiFXhF711gzpu6TyRsvtVR9QFOdWSCPvrG4eWn8xUu8ZUoYL/dvvXM4Olau4LCm+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnmZ8Hkne4640jHM9scqI6EO+IOnqToStZGUHm5yijc=;
 b=f9bDMpE4k9rMZl7H36iztP4m3M3m4787r7cda9zzHvpUjNRsZBYk7eGtVhuh083h+Syn7OqTsb/scV3BZbD8BnWeT204iugx/HH1hFcqq8Bp8gjHWJqgdp9PKhO6rQyiteiskEFiZTFMjRBYhlJg48lZdbUSO9HFiLA0ulOeMRQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 17:55:32 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f0d0:ef63:9b7e:b13]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f0d0:ef63:9b7e:b13%4]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 17:55:32 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Disable SVM per GPU, not per process
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210610232916.23748-1-Felix.Kuehling@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <1ffd2a32-b7ab-b023-fe1a-95242b80c686@amd.com>
Date: Fri, 11 Jun 2021 13:55:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210610232916.23748-1-Felix.Kuehling@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 17:55:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31c7b08c-2a6a-476f-df2c-08d92d021b73
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5374A906C0767851A5464728E6349@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeepNB9pjYDQBbBOFIr5KmtdngUWtZLAZ7iDH2wRoHoiH/rgkZ0ZkFO4Hlg03YwE4jFU7SMeFaQUhOvO2xCgqRp4N8hnhVMgW4I/8lyQ/gigIzImA6vhtdoeL9/a2Z9Dzy8goskHijndkKsNNjD3kD0rTWI8VGvUXVJ0vHhI1UGzULjPhXudL1RR0Cg6sHESQzvvAEm91vRg/HDsIE/gjwLmJoptgSL2TXeD9D8TLp7NNMMqBJKt1SsiD67cw5AfAqMoP+2XEwt3HlaiAUKRrW7NwTpeFwoeUHf7j4qiLTDLCwUlBpRS7/GuSBFaYdceFMcqgcC6+dcJs5Audy+oaas7OBIlmi5IpWZIQk7KKYZ9ZwQu4WkKRAgn2LyXIYVqVSuMnKLmwqgVUo9uHiJb2C+9ghmdMYZ5XT8rPgvjLeoLBhh7NGV6gfNT8CWrrs9DL4GtPoKGc7obIgO1Pb/ybU0Gy3TEjvXgeNV6UM8eIyFUAUJbF528F16xXqthP3iACK0OS9b7lhH72G7QZllKHfWRpJftPcBdgqkVQ4OdCZYzi5bjSsB/4QpuQ7YCahKlGPaPa0vyPrp1w/gHl3Vqux5e8FvSzAbl20C0TsyZAZA+v+ZopNX2AeCVqHaoEY/GT1ED/wu3WqoVneHlVrVxWv3enOIh27xMBXGXvrv9ckVu35XH6SQ6n5hD8jvL2MSn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(4326008)(5660300002)(8936002)(83380400001)(36756003)(478600001)(66946007)(8676002)(31686004)(26005)(53546011)(186003)(16576012)(6486002)(66476007)(16526019)(66556008)(2616005)(956004)(316002)(2906002)(38100700002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2M4K21YWFlCMDNyQ3VFS0JWUUR0NXB6Qmp0Y0ZWbjFvZDlqUXZSYkZWYU5u?=
 =?utf-8?B?OTNqK3ZkdUtleXNySHpSSDVMSjRBeDZ5RWd0NzR1QWVTdDE5NWhPb1E2YmtD?=
 =?utf-8?B?TjhZaGRBcytzOS9taTJ2UGhVZmxjZk45UCtXS2s0eTc3NEpCRnJRNFBWMUVk?=
 =?utf-8?B?ZjJ2YVdSclRlbDgvSVg4YmNWQ3N1dGJ0SGhZWHZlUW1nM0lHUkJoOWgzSXVT?=
 =?utf-8?B?bnU1aGhIek9sQnl6VHFWVFQrdFpWNFpuSFFwTGhNdW5zRi9TMlNRWVc3R2F4?=
 =?utf-8?B?ay85Y3dDZjNFdFVTZ2dSbkd1SXRsMlZVT3hnVDZiQzFObDNUOFJ3YTYrNk1I?=
 =?utf-8?B?dWJtQ2RJbEVLR0ZYL05sQklOREE0c212U25OZzdJY0ZMSzNBQnZadXo2a01q?=
 =?utf-8?B?RzYrb2dqQTE0cWgzM256Vk84aFd6VXhjZTIrbnQva25qckduVHQ1WnNuTTdU?=
 =?utf-8?B?b2w5bDRYUWJaSWw0c2dWb2NMNlhMY3llWkRJYzJWcUNyZmdmeVNFbmVpd2kv?=
 =?utf-8?B?djl1Z2JiT0ZuWjBJbEFTV2MwV0VvNUlINjg4SWlUYzlabU9oNVRXM3R3eVov?=
 =?utf-8?B?SFlsbjlKc3d4enhOemxjaVdCQjBwNVBrQzB2SnFFNlpMSlMyZ2lTUVdNSkVr?=
 =?utf-8?B?eFlxcjlFaC83YTJLbGlmYStuRVB6TC9TSnFJNFdDOWZIQXo4Mm9KdGlIQW1m?=
 =?utf-8?B?SWNjRmpSZUhpVXl3dGZNbGJKSGVqWUNKMkMvcVJqN2lPdUtxbjE4Y0pTSnp5?=
 =?utf-8?B?UUpNN1pRc0VSSjY5cW1VMWlRZy9Wdksyc1JzK083WExNbVZFMjVualhJaEdr?=
 =?utf-8?B?c254OE5ETlR0QTVMKzdEbVJCcjdFSSt3Y3NoNnZQcWFKR3l0UWN3RFN4SGw1?=
 =?utf-8?B?WElObWFWWWJHRmdaOTRKd20zUFFXWE4vZngzdjNkRGFGeFEveEZKM0xMVkhv?=
 =?utf-8?B?Wkl2QzJEU01vT2N4b1cvRHpJMTlrQVRiekMrVGJGT3Ztd0FHOCttbFgzQzFJ?=
 =?utf-8?B?OVcxc28zUUhhUG1aYnFENS9OaFJ6U3BuZFRueWpIdVRXV254OWZQY0owazJB?=
 =?utf-8?B?bFlpVnRUOVVEY0RmdjhmcWdNdWgzNkE1UU5HRVdBaDQvL1czek1lR1JlWFVv?=
 =?utf-8?B?RHp2NDA0Y3Vjais0TzIyYW5NRGZFcWN3UFVxcU5YbzJzYWhwNS9jTDBvQkFH?=
 =?utf-8?B?TldVbm83b1ZNTk1xNDJlOS9IdlpmbzNHcFdMOWpDV0xIbWpvbG1jcjRJRTFF?=
 =?utf-8?B?OTFWNXJGbEtDZ0E2RE1kZTkzTEVQSDlwdU5UdkNhMVRCSi9TaEk2eVlLYzY1?=
 =?utf-8?B?eUNIalpVdlRWejI3VEdDUTMyU3BFU2ZIMVpsekUybmFITlZGQUxOQ05lUytu?=
 =?utf-8?B?dFE3R1JzY3BBVWxUS0poRU4wMjZaNjc4V25NU2hpSUZkTHh4OXh5aTVhTGRy?=
 =?utf-8?B?WmpEaktSMGtDQSs3NjJlZkxyVmJ5M1l4Mm42a04xY3E3STMzbE9TNk9NNnpz?=
 =?utf-8?B?K0JSQWJNS3NCUzBUSk5STThwdFVuUWtVNGhnOXFxRXk1dnVVeWp4L0hBc1lw?=
 =?utf-8?B?enA5V2o3NWdZaWs3TXhVTDlUVm5aKzJVN21zVllWc0xTeXhCeDcyQUcxN1ZL?=
 =?utf-8?B?THZhaEh4N2RsaUQ3L0lXNmdpaFNBa0NuQ1hSNTRuNGJETlk4c1dZSCtuK3Fn?=
 =?utf-8?B?U3VsZHlUbW5mWlpGa3VOZUp3RlpoenExaG8yRGtsajJaa24raUxqOENIdTdp?=
 =?utf-8?Q?q8qzBjB5fOJ5QMRaRTP1vn4TWO03BBpOxm9uNLM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c7b08c-2a6a-476f-df2c-08d92d021b73
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:55:32.4952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DWXz/E4lPTXnJDhNYwz80D8nMiEANIUMJMKKFbyVXCGYP6CTKpK8BFCz8+vrEDt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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
Cc: alex.sierra@amd.com
Content-Type: multipart/mixed; boundary="===============0837172612=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0837172612==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-06-10 7:29 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210610232916.23748-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">When some GPUs don't support SVM, don't disabe it for the entire process.
That would be inconsistent with the information the process got from the
topology, which indicates SVM support per GPU.

Instead disable SVM support only for the unsupported GPUs. This is done
by checking any per-device attributes against the bitmap of supported
GPUs. Also use the supported GPU bitmap to initialize access bitmaps for
new SVM address ranges.

Don't handle recoverable page faults from unsupported GPUs. (I don't
think there will be unsupported GPUs that can generate recoverable page
faults. But better safe than sorry.)

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a></pre>
    </blockquote>
    <p>It's smart way to handle SVM support and non support GPUs mixed
      on one system.</p>
    <p>One suggestion inline. With or without the suggest change, this
      is</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    </p>
    <blockquote type="cite" cite="mid:20210610232916.23748-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     |  3 --
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c |  4 --
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c         | 55 ++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h         |  7 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c    |  6 +--
 7 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5788a4656fa1..67541c30327a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1797,9 +1797,6 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	struct kfd_ioctl_svm_args *args = data;
 	int r = 0;
 
-	if (p-&gt;svm_disabled)
-		return -EPERM;
-
 	pr_debug(&quot;start 0x%llx size 0x%llx op 0x%x nattr 0x%x\n&quot;,
 		 args-&gt;start_addr, args-&gt;size, args-&gt;op, args-&gt;nattr);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 91c50739b756..a9b329f0f862 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -405,10 +405,6 @@ int kfd_init_apertures(struct kfd_process *process)
 			case CHIP_POLARIS12:
 			case CHIP_VEGAM:
 				kfd_init_apertures_vi(pdd, id);
-				/* VI GPUs cannot support SVM with only
-				 * 40 bits of virtual address space.
-				 */
-				process-&gt;svm_disabled = true;
 				break;
 			case CHIP_VEGA10:
 			case CHIP_VEGA12:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 329684ee5d6e..6dc22fa1e555 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -743,6 +743,7 @@ struct svm_range_list {
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
 	struct delayed_work		restore_work;
+	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 };
 
 /* Process data */
@@ -826,7 +827,6 @@ struct kfd_process {
 
 	/* shared virtual memory registered by this process */
 	struct svm_range_list svms;
-	bool svm_disabled;
 
 	bool xnack_enabled;
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f1f40bba5c60..09b98a83f670 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1260,7 +1260,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	process-&gt;mm = thread-&gt;mm;
 	process-&gt;lead_thread = thread-&gt;group_leader;
 	process-&gt;n_pdds = 0;
-	process-&gt;svm_disabled = false;
 	INIT_DELAYED_WORK(&amp;process-&gt;eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&amp;process-&gt;restore_work, restore_process_worker);
 	process-&gt;last_restore_timestamp = get_jiffies_64();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 0f18bd0dc64e..420ca667be32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -281,7 +281,8 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 
 	p = container_of(svms, struct kfd_process, svms);
 	if (p-&gt;xnack_enabled)
-		bitmap_fill(prange-&gt;bitmap_access, MAX_GPU_INSTANCE);
+		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
+			    MAX_GPU_INSTANCE);
 
 	svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
 					 &amp;prange-&gt;prefetch_loc,
@@ -580,33 +581,25 @@ svm_range_check_attr(struct kfd_process *p,
 	int gpuidx;
 
 	for (i = 0; i &lt; nattr; i++) {</pre>
    </blockquote>
    <p>Because we are here, maybe use local variable to short the two
      lines kfd_process_gpuidx_from_gpuid into one line<br>
    </p>
    <p>uint32_t val = attrs[i].value;</p>
    <blockquote type="cite" cite="mid:20210610232916.23748-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		gpuidx = MAX_GPU_INSTANCE;
+
 		switch (attrs[i].type) {
 		case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
 			if (attrs[i].value != KFD_IOCTL_SVM_LOCATION_SYSMEM &amp;&amp;
-			    attrs[i].value != KFD_IOCTL_SVM_LOCATION_UNDEFINED &amp;&amp;
-			    kfd_process_gpuidx_from_gpuid(p,
-							  attrs[i].value) &lt; 0) {
-				pr_debug(&quot;no GPU 0x%x found\n&quot;, attrs[i].value);
-				return -EINVAL;
-			}
+			    attrs[i].value != KFD_IOCTL_SVM_LOCATION_UNDEFINED)
+				gpuidx = kfd_process_gpuidx_from_gpuid(p,
+							       attrs[i].value);
 			break;
 		case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
-			if (attrs[i].value != KFD_IOCTL_SVM_LOCATION_SYSMEM &amp;&amp;
-			    kfd_process_gpuidx_from_gpuid(p,
-							  attrs[i].value) &lt; 0) {
-				pr_debug(&quot;no GPU 0x%x found\n&quot;, attrs[i].value);
-				return -EINVAL;
-			}
+			if (attrs[i].value != KFD_IOCTL_SVM_LOCATION_SYSMEM)
+				gpuidx = kfd_process_gpuidx_from_gpuid(p,
+							       attrs[i].value);
 			break;
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
 			gpuidx = kfd_process_gpuidx_from_gpuid(p,
 							       attrs[i].value);
-			if (gpuidx &lt; 0) {
-				pr_debug(&quot;no GPU 0x%x found\n&quot;, attrs[i].value);
-				return -EINVAL;
-			}
 			break;
 		case KFD_IOCTL_SVM_ATTR_SET_FLAGS:
 			break;
@@ -618,6 +611,15 @@ svm_range_check_attr(struct kfd_process *p,
 			pr_debug(&quot;unknown attr type 0x%x\n&quot;, attrs[i].type);
 			return -EINVAL;
 		}
+
+		if (gpuidx &lt; 0) {
+			pr_debug(&quot;no GPU 0x%x found\n&quot;, attrs[i].value);
+			return -EINVAL;
+		} else if (gpuidx &lt; MAX_GPU_INSTANCE &amp;&amp;
+			   !test_bit(gpuidx, p-&gt;svms.bitmap_supported)) {
+			pr_debug(&quot;GPU 0x%x not supported\n&quot;, attrs[i].value);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -1855,7 +1857,7 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 	p = container_of(svms, struct kfd_process, svms);
 
-	for (i = 0; i &lt; p-&gt;n_pdds; i++) {
+	for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
 		pdd = p-&gt;pdds[i];
 		if (!pdd)
 			continue;
@@ -2325,6 +2327,11 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	bool write_locked = false;
 	int r = 0;
 
+	if (!KFD_IS_SVM_API_SUPPORTED(adev-&gt;kfd.dev)) {
+		pr_debug(&quot;device does not support SVM\n&quot;);
+		return -EFAULT;
+	}
+
 	p = kfd_lookup_process_by_pasid(pasid);
 	if (!p) {
 		pr_debug(&quot;kfd process not founded pasid 0x%x\n&quot;, pasid);
@@ -2472,6 +2479,7 @@ void svm_range_list_fini(struct kfd_process *p)
 int svm_range_list_init(struct kfd_process *p)
 {
 	struct svm_range_list *svms = &amp;p-&gt;svms;
+	int i;
 
 	svms-&gt;objects = RB_ROOT_CACHED;
 	mutex_init(&amp;svms-&gt;lock);
@@ -2482,6 +2490,10 @@ int svm_range_list_init(struct kfd_process *p)
 	INIT_LIST_HEAD(&amp;svms-&gt;deferred_range_list);
 	spin_lock_init(&amp;svms-&gt;deferred_list_lock);
 
+	for (i = 0; i &lt; p-&gt;n_pdds; i++)
+		if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev))
+			bitmap_set(svms-&gt;bitmap_supported, i, 1);
+
 	return 0;
 }
 
@@ -2978,14 +2990,15 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 		svm_range_set_default_attributes(&amp;location, &amp;prefetch_loc,
 						 &amp;granularity, &amp;flags);
 		if (p-&gt;xnack_enabled)
-			bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
+			bitmap_copy(bitmap_access, svms-&gt;bitmap_supported,
+				    MAX_GPU_INSTANCE);
 		else
 			bitmap_zero(bitmap_access, MAX_GPU_INSTANCE);
 		bitmap_zero(bitmap_aip, MAX_GPU_INSTANCE);
 		goto fill_values;
 	}
-	bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
-	bitmap_fill(bitmap_aip, MAX_GPU_INSTANCE);
+	bitmap_copy(bitmap_access, svms-&gt;bitmap_supported, MAX_GPU_INSTANCE);
+	bitmap_copy(bitmap_aip, svms-&gt;bitmap_supported, MAX_GPU_INSTANCE);
 
 	while (node) {
 		struct interval_tree_node *next;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 573f984b81fe..0c0fc399395e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -175,6 +175,11 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
 void svm_range_free_dma_mappings(struct svm_range *prange);
 void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
 
+/* SVM API and HMM page migration work together, device memory type
+ * is initialized to not 0 when page migration register device memory.
+ */
+#define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)-&gt;pgmap.type != 0)
+
 #else
 
 struct kfd_process;
@@ -201,6 +206,8 @@ static inline int svm_range_schedule_evict_svm_bo(
 	return -EINVAL;
 }
 
+#define KFD_IS_SVM_API_SUPPORTED(dev) false
+
 #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
 
 #endif /* KFD_SVM_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index f668b8cc2b57..ff4e296c1c58 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -36,6 +36,7 @@
 #include &quot;kfd_topology.h&quot;
 #include &quot;kfd_device_queue_manager.h&quot;
 #include &quot;kfd_iommu.h&quot;
+#include &quot;kfd_svm.h&quot;
 #include &quot;amdgpu_amdkfd.h&quot;
 #include &quot;amdgpu_ras.h&quot;
 
@@ -1441,10 +1442,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 		dev-&gt;node_props.capability |= (adev-&gt;ras_enabled != 0) ?
 			HSA_CAP_RASEVENTNOTIFY : 0;
 
-	/* SVM API and HMM page migration work together, device memory type
-	 * is initialized to not 0 when page migration register device memory.
-	 */
-	if (adev-&gt;kfd.dev-&gt;pgmap.type != 0)
+	if (KFD_IS_SVM_API_SUPPORTED(adev-&gt;kfd.dev))
 		dev-&gt;node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
 
 	kfd_debug_print_topology();
</pre>
    </blockquote>
  </body>
</html>

--===============0837172612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0837172612==--
