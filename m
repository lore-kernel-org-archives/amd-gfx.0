Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF0BC4707D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 19:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85952613D8
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 19:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85952613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 098658981D;
	Fri, 21 May 2021 19:29:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474F989E9E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 19:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bawW018hQNsRpWtH6x7vmM8Covmbre5jxhuGSllc4Z19FeXc5Y1nZpgjzi8vnVw4CpD4ASmOJZP52qBIm2IyQGyzq5kckRj0K6SS8nuTx4N5WaE/T2vUx17mML9kkOpo/FvafXK/9MInsQ5K+B4dZuQanJbr7YHZjAC3MfU+3u9t790crVpvS06o71Q6eGfMxw+bwTw5k/2OtHra7WPclbeEqRqyIBWXRfowjv9yJROCpgS94n2FNIXFN+Fh4IttsM1Kbn/zmWxJUxeRYpwR3GD3NIV8jZhV3Tb7kDj+Ky2+ejgCnWmf2AHJRZaydQ0N3lGMZ0l6+Q4NMoIIeWTKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTmY6HpFrke7QdJK5jcwqTCIKjNv8PAXJooDbaUjmvc=;
 b=MrRErP9rkwbavmyM4QXPTI43A79wRVkrBUTziKsxJtYZ734I35XXaQRycyA/rk/LA2jvEcLo/4I8Teg8unPVq6zaUxiiyeYbe5e9EUU996wTUTzCM3JMwGMS2ON3GNMbX4Rsn6/HrEhqlHpNZsN+5idUW96b8Imk8ewUNaVFxS3pQIKX5Cv9RNSY/QPUjti3LBHQWw34I0fdr02sGCTVOAPJd2hSDp9qXeQR5y2I7G9Ky/AtAxu+QJkpTHCNToWaRV+uiEUGjtFCMvVV+ztcK3jg7QI7BeHtk6sErqTfp3EcxBKZNsgGMvHwYe8BtUfUgFD1+qDLGR/Tvkc0piUEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTmY6HpFrke7QdJK5jcwqTCIKjNv8PAXJooDbaUjmvc=;
 b=bFnLvVD0hMFkXLEtEbKUGRm2yZdGw9Lhtnq4o+bryStPiAlNClqgE6RvsSkEguUW3gLh9rEfi02H0sDgRaFGf5y4xTrSnMoWAiOVam6cYJqU2+n3t9cduvKkjk6Uai+kVqy/8F0f7SJycpRqu/5LiIOCgJtFIwVsbk1C3rQIkq4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 19:28:24 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::407d:38a8:e51a:8145%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 19:28:24 +0000
Subject: Re: [PATCH] drm/amdkfd: use resource cursor in
 svm_migrate_copy_to_vram
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 felix.kuehling@amd.com
References: <20210521135203.169068-1-christian.koenig@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <914a1fbd-653a-3edf-27cb-4aa064267985@amd.com>
Date: Fri, 21 May 2021 15:28:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <20210521135203.169068-1-christian.koenig@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::41) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 21 May 2021 19:28:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0da99f5-2fa2-4ff1-146c-08d91c8e99d0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5069:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB506902FABCBAB15993BC9FB8E6299@DM4PR12MB5069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWQbUSCqU2UdIGwyu9qoY0eWxDYfhSr+nYwngilj+PLCIegNKmlyZL0/NZp7M3A8M3kvc/SJ6DC8T3mGBFPKyiXEFqn02NBsAKXXJ6zF5wrkwCcFWQyR2QAE/xXqIxIgw+E1o8wSCFw2ErCkaN/yeO+56k/ra1iMEfp3ttjKqmFoyV0DtrotsSr9a1rfb+uYfgXb5xGAyU+h0iBPZ0PlUKukXioNkCRBKXF4LbyRH58EOmK9vEiK2PUgEdCblRRyPHgvkw4SiW3GRqrS2SHAfL+HhK1jzMN3b8jFySP5ygS1Dz3QN0B4Q9neyaFypnwkZVOZdkS4Z66mq4EJITe9T1TpAuIu0+86N/uSsmepaTiQ3AKDT4qh57QvcXLEQJFJf8/u0ZW420Aequ7le7ib3oSuQl/SQn+Y+gX1oIF/1CmLfqzvd3/yUFFU4eDDe8i0KFWs1jXq/VYwlBKKya7B9OWanEmzkXEEcayJh1slDlVFxBfro7x7If0uQ7lNQoEcqZ76UHqtKycVawa1vJ5rGqxgmVo1gDSqFzdmWizZKCelJ5imOBAbpTYqRZTcBgJPaGa4MzDqOEWQxZPbuW8VbAfXEIweMIl4pNB/Ui5kQaOrhhvOw2GMe2ygbmir8MJIewNMoecXUWOBjpzpnHvrB9KOF4EhevWwQGW64jbgr38/w4scpYTcKKVsGeHFO8J+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(4326008)(6636002)(2906002)(6486002)(5660300002)(66574015)(956004)(186003)(16526019)(16576012)(2616005)(26005)(316002)(8676002)(8936002)(38100700002)(31686004)(66556008)(66476007)(83380400001)(66946007)(36756003)(478600001)(31696002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M3NrVUdlOHJrckhQVzRla0Z6YW1kSWIxVUFncmFETTd5Yy9iWVVsZFI5UXVF?=
 =?utf-8?B?TFJRdVJRTVJKWWJuTzBlOHJ4Wkdta2V0eDZPL21JdUpUZ1RTdVNTNFRyQTcy?=
 =?utf-8?B?OVhIeVE2clR0SDVmeHEwdFBZUi8zZ0toOUVoNDc3czJML2pCY05NQ29qb1JK?=
 =?utf-8?B?L3RsVXBOcGhtaUNCYjM2L1VFRHFIMU43MStYM0xpMjk0dDdKY1g4NWpoanVs?=
 =?utf-8?B?V0pvNkpNZ2doUHBvMG9abEIvcEtqU0xpSXJyeGh6dVh0VFNxbGtxTldrdnBx?=
 =?utf-8?B?WGdUY2NaYmd3OXUwUU43MkVsaWxTTXFqNFpnN0tqcWtKZHA1RWdNRWZ3dE0r?=
 =?utf-8?B?VEh6OFpEVUNiNUlEbUxSbk1QOGtrZmoxejF6MXd6dFpHSmhmSnB3RW5SOFh6?=
 =?utf-8?B?ak9vbVUzNytRNVQ5WndmSlJHaWlIMGMwMm92ZnVGMXVUelZmR0FzVVpRQUIv?=
 =?utf-8?B?WE9YTUxDTSt2emlVanRTN2tSSnExUnp1NVllWWhpb1ExR3BTc3FUaU0zc1Vx?=
 =?utf-8?B?R1dKZkFkRzM0c09GY1VkdktnZE1Md1JOTXVCcnMrM1FUQWsyWE1qa0xLMkRZ?=
 =?utf-8?B?NmEzelR3aHE4WU0vZFNZc1VsdTBrNHM3SnFHZDUxRVhvYWFHb1VFbUNTbnZ3?=
 =?utf-8?B?VkVtckNrVmI4NWw4UytzQnR2d3dHSXFIWjF4dzdiaThudEFTbXJTN3ljRzNW?=
 =?utf-8?B?SHh5dE1xOXYrQzN2elg1UVpyY2ZQZ05lUDV3dmt1MzFEMTFkdTVxMElESVpx?=
 =?utf-8?B?VmxKV2JwUDV3UEpOOFgxSGUxa1hGZTBScFpTYStSMDhSTGJualJteWNVdC9x?=
 =?utf-8?B?MTI2cGtYWmQ3aGRxMHN0OHJxUkZyY2w1dTN2bTdKVHpjd1FOTzBDWmhSZldu?=
 =?utf-8?B?NjZxZmppeG1VeExqOGZXSVZCaDBPYkdQaHpKbXIvbldNTmVSMkJXTWNtZ1Nm?=
 =?utf-8?B?V0cweEoxZ0Q0MHFyMks2UnRkdDZVekp4YzFxeEloVkZMbE9RK2tpa2hJajF2?=
 =?utf-8?B?ZUxucWNRcGcxZDd5NkxjKzkvWklMajF3bkhYMG52Q2hmcDFzV0dHTFFpRXc1?=
 =?utf-8?B?cmdsemdCTkIwZnRabmxrUzU0V25ockNKcFdvKzRTNityNDlJK3pNYWZsMW4y?=
 =?utf-8?B?dFp2UVJ2T0NEV2pOZk8ycGhtQmFUTVpGY01aL0Y4ZnRUZ1FYN05IVDJxVnln?=
 =?utf-8?B?OFF0bzlsM1FvNm91UWhsaUljbS94NFhUM3ZDeVdrNENwZWgxTnJYQ3BtSVkv?=
 =?utf-8?B?ZVZoR0RtNjFxbHM4dEtzcis3dmhPaVdadS9QVXI1UGtQdXJ4N1dIRlFkYkll?=
 =?utf-8?B?UHJleXdKdVlEa3FjNytVQkdXZGZaMTNFazdyQ3QyWjhmN3Y5ajJZRVJxaTQy?=
 =?utf-8?B?bktCVyt5WGFwOFpqYXVyOXk2R3RZMU0zSnM1cmo1U01ZanZXbXB0NHord2ZZ?=
 =?utf-8?B?MGdCUkw2RHA1ZUtrcHZPM2Q4RmxRNUlEU3ZkQkZ0bGRwa1lUMFVHUVNtWUlG?=
 =?utf-8?B?bUw0WDBadjZzcVpZRW85L1F3aVBPZG5WS01LV0wrcEp6VGdXTmdwaDlwSTVm?=
 =?utf-8?B?MWYvOXpScy9tS3RMdjh0Y09TNVVCNUJ5MnhOMHlZVGx1emE0aUJ5VFgzYkJz?=
 =?utf-8?B?akwxcWZCNmFESTd5NkxKbGcwMWFoZzZtSnVIOXgzZElLSmczR2ZKR09SNmNk?=
 =?utf-8?B?dXQvZ1VURmFxWVpxZkNXYUZ5VXh4ZlNrLy9CcjBNd25tQWFLa0lOU3JlWStm?=
 =?utf-8?Q?IUzJeDgdtDJVLwXJJ0vapBxnkTTRiY/UtfNyizE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0da99f5-2fa2-4ff1-146c-08d91c8e99d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 19:28:24.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qOtKdc+EOLPQ6b8Dbfrifb0JPiNtxDblf4X+mJ8KbxwjIkJZPZGt+sElWqCXY4Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1153542325=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1153542325==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>This simply the logic, several comments inline.</p>
    <p>Thanks,<br>
    </p>
    <p>Philip<br>
    </p>
    <div class="moz-cite-prefix">On 2021-05-21 9:52 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210521135203.169068-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">Access to the mm_node is now forbidden. So instead of hand wiring that
use the cursor functionality.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 76 +++---------------------
 1 file changed, 9 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index fd8f544f0de2..cb28d1e660af 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -29,6 +29,7 @@
 #include &quot;amdgpu_object.h&quot;
 #include &quot;amdgpu_vm.h&quot;
 #include &quot;amdgpu_mn.h&quot;
+#include &quot;amdgpu_res_cursor.h&quot;
 #include &quot;kfd_priv.h&quot;
 #include &quot;kfd_svm.h&quot;
 #include &quot;kfd_migrate.h&quot;
@@ -205,34 +206,6 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
 	return r;
 }
 
-static uint64_t
-svm_migrate_node_physical_addr(struct amdgpu_device *adev,
-			       struct drm_mm_node **mm_node, uint64_t *offset)
-{
-	struct drm_mm_node *node = *mm_node;
-	uint64_t pos = *offset;
-
-	if (node-&gt;start == AMDGPU_BO_INVALID_OFFSET) {
-		pr_debug(&quot;drm node is not validated\n&quot;);
-		return 0;
-	}
-
-	pr_debug(&quot;vram node start 0x%llx npages 0x%llx\n&quot;, node-&gt;start,
-		 node-&gt;size);
-
-	if (pos &gt;= node-&gt;size) {
-		do  {
-			pos -= node-&gt;size;
-			node++;
-		} while (pos &gt;= node-&gt;size);
-
-		*mm_node = node;
-		*offset = pos;
-	}
-
-	return (node-&gt;start + pos) &lt;&lt; PAGE_SHIFT;
-}
-
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
 {
@@ -297,11 +270,9 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 {
 	uint64_t npages = migrate-&gt;cpages;
 	struct device *dev = adev-&gt;dev;
-	struct drm_mm_node *node;
+	struct amdgpu_res_cursor cursor;
 	dma_addr_t *src;
 	uint64_t *dst;
-	uint64_t vram_addr;
-	uint64_t offset;
 	uint64_t i, j;
 	int r;
 
@@ -317,19 +288,12 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		goto out;
 	}
 
-	node = prange-&gt;ttm_res-&gt;mm_node;
-	offset = prange-&gt;offset;
-	vram_addr = svm_migrate_node_physical_addr(adev, &amp;node, &amp;offset);
-	if (!vram_addr) {</pre>
    </blockquote>
    The prange-&gt;ttm_res valid check is not needed because we already
    check svm_range_vram_node_new return value<br>
    <blockquote type="cite" cite="mid:20210521135203.169068-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">
-		WARN_ONCE(1, &quot;vram node address is 0\n&quot;);
-		r = -ENOMEM;
-		goto out;
-	}
-
+	amdgpu_res_first(prange-&gt;ttm_res, prange-&gt;offset, npages &lt;&lt; PAGE_SHIFT,</pre>
    </blockquote>
    <p>prange-&gt;offset&lt;&lt; PAGE_SHIFT</p>
    <p>amdgpu_res_first takes start and size in bytes, prange-&gt;offset
      use page aligned offset</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20210521135203.169068-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			 &amp;cursor);
 	for (i = j = 0; i &lt; npages; i++) {
 		struct page *spage;
 
-		dst[i] = vram_addr + (j &lt;&lt; PAGE_SHIFT);
+		dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
 		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
 		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
 
@@ -354,18 +318,10 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 						mfence);
 				if (r)
 					goto out_free_vram_pages;
-				offset += j;
-				vram_addr = (node-&gt;start + offset) &lt;&lt; PAGE_SHIFT;
+				amdgpu_res_next(&amp;cursor, j &lt;&lt; PAGE_SHIFT);
 				j = 0;
 			} else {
-				offset++;
-				vram_addr += PAGE_SIZE;
-			}
-			if (offset &gt;= node-&gt;size) {
-				node++;
-				pr_debug(&quot;next node size 0x%llx\n&quot;, node-&gt;size);
-				vram_addr = node-&gt;start &lt;&lt; PAGE_SHIFT;
-				offset = 0;
+				amdgpu_res_next(&amp;cursor, PAGE_SIZE);
 			}
 			continue;
 		}
@@ -373,22 +329,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		pr_debug(&quot;dma mapping src to 0x%llx, page_to_pfn 0x%lx\n&quot;,
 			 src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
 
-		if (j + offset &gt;= node-&gt;size - 1 &amp;&amp; i &lt; npages - 1) {
-			r = svm_migrate_copy_memory_gart(adev, src + i - j,
-							 dst + i - j, j + 1,
-							 FROM_RAM_TO_VRAM,
-							 mfence);
-			if (r)
-				goto out_free_vram_pages;
-
-			node++;
-			pr_debug(&quot;next node size 0x%llx\n&quot;, node-&gt;size);
-			vram_addr = node-&gt;start &lt;&lt; PAGE_SHIFT;
-			offset = 0;
-			j = 0;
-		} else {
-			j++;
-		}
+		amdgpu_res_next(&amp;cursor, PAGE_SIZE);
+		j++;</pre>
    </blockquote>
    Here to handle cross mm_node case.<br>
    <p>if (j &gt;= cursor-&gt;size - 1 &amp;&amp; i &lt; npages - 1) {</p>
    <p>&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src + i - j,<br>
    </p>
    <p>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dst + i - j, j + 1,
    </p>
    <pre class="moz-quote-pre" wrap="">			FROM_RAM_TO_VRAM,
			 mfence);
    if (r)
	goto out_free_vram_pages;
    
    amdgpu_res_next(&amp;cursor, (j + 1) * PAGE_SIZE);
    j= 0;
} else {
   j++;
}


</pre>
    <blockquote type="cite" cite="mid:20210521135203.169068-1-christian.koenig@amd.com"> </blockquote>
    <blockquote type="cite" cite="mid:20210521135203.169068-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	}</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20210521135203.169068-1-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap=""> 
 	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
</pre>
    </blockquote>
  </body>
</html>

--===============1153542325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1153542325==--
