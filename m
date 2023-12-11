Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2216FC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Dec 2023 14:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D5810E468;
	Mon, 11 Dec 2023 14:42:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F1810E10B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Dec 2023 14:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khv/67tqEhJc1Z4hnG6g1ldVZbiX42lALAqCG8SfiyWW2UvLaPQeLOfNWkWghdZGYbQDdE2jE5JuBdVabNzB/EcUKQ8FMIlpqD2sW/KOkI86fDqS5P+juDSXFnuQbe4nMcKLQpZE9nelq63LnJ4x8GSCZ5s31N4sy9ZPu5NQaef95tcQBZ6iCLtNFe91r3gVDkP98xMEa88j31yqa2/gbDEk4aoNUSogemaZeJh2BniHgNxNy5N5MeWx5f75k3WU/E5vpV8cwwdqF+D1IjIuo1zg0ESqPfh6nZpZlD0IYsChvGCpp4X0wFNKIMU/IPL0DxNg5+HHdgFLHXAtzcALrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp8Nkw7kq5yrVQd5CaN31TJwL2Zt0qfIDRgBajBIGwo=;
 b=g5rDI89MbbjfwZ3NLLkjxk3aV2wubf58JqnEK0C61vVgIHMV0EzuTvmTjmIDwhdY86b+qvJ62Ty+4o2Uxy/b3gKP/SBkksMCZw1va7UqMUE6lgABTcBDk8eoNjU3DvogA3PzmNoOU4oTneWFCcJtZ3ZlT9ui63fgphPhilUWwyHNj8VV9CkS/zSuxmLeERw2i2+5gzsb+qM5v8RhhSHa+BmHiuBZ6o1A7HSWw+A4/b5ph2SpEN0clWvuHAhS9VGNXFzE9AdwLGtLEqK6OmMVp2DP/xOdQia/aFWtpcbcrX5ezFgw07H1EPKb/JlXQPNdrhUwjnP0Z0hqs5wSr0z4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp8Nkw7kq5yrVQd5CaN31TJwL2Zt0qfIDRgBajBIGwo=;
 b=UinGnaerKUuuQd1MxqFnGb+QMMXRegHBRBUPkFPW3m97d1egxyhIj4H8cM+L19tna9CNC+0CHJMhvqJet5yihrvVaLDOehrJBaSsy4TxY4elo9BiXGBRU61tE5c3J/o64GK5QZidxWPrRWvjipN7bcz/g1y/rp8T4vjnz2AH3WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 14:42:46 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:42:46 +0000
Message-ID: <3a9ceb31-cec0-fb51-a6db-55817e30fa95@amd.com>
Date: Mon, 11 Dec 2023 09:42:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Use partial hmm page walk during buffer
 validation in SVM
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231206152410.123993-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231206152410.123993-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: b60cad6e-918e-4d0b-90d7-08dbfa577081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/n8ShAp5our5T2V4JIPJ5OYkYbQ2ElxAgniZmUsr1TWNdWJ3qVg9U0jNsnlnyMKO5VGa7B98Xfaklpsv0LzbIh1np/+hWuFlA2x77jpyIU6hJaaXp0rUS7zNHJAvy1sHXyV8EtaUeaPdnYU3jorIRZV4ZKwO3bsY63kLBI4VoSVCSgaoZ50WwF1QBGugyYpweUWio+wqkEPPJDBK2CluhLLpnFzUoaBkVWq7i9+09fZbfHBedu/Lx4cZ4aFpeSEMGxCALuDU12C/x8J4Q8lUZ2XjhddviYPiW71loK8B70HrHFLefQgzTAdnj7beempctWC7MDbjRnsAv4ZbLJf08kwxurFY+tPmbi171G0IsLWGroAAafy9u1Zw82tPGmI92plDG5UvVtgsrSvKS+13u8SWPgeAi/3hD9vFxMOiwBBBMuItOntFZO4bTM1KwiyFgV09bSZAn1wtN1UhaBS96oZ16QjVl+TCnZgeMsIqHSQVK59SWCmm04w9KOUm7GcSR9IXOgxHC6+88sYw3kcIBujWypnK6abNNcm1ZAkKtcFV03VTDJmbCBEe1Uc0WrTtO0cHdZKLD2Xu48cY9ZmmB9TBZGCOYFy+twr+hFOjBtoizak2O7zECz1FtyyadEVq9rYBq68rkSyxTIigWgiaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(4326008)(8676002)(8936002)(5660300002)(6506007)(53546011)(6666004)(2616005)(36756003)(6512007)(66476007)(66556008)(66946007)(316002)(478600001)(6486002)(41300700001)(2906002)(31696002)(31686004)(26005)(38100700002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDg4R0pMZHUxcDNWVXFxNnZJamhhUjVNS3JEQ3doSGVSbHN0L2lpWmxmS3lp?=
 =?utf-8?B?NEoreEQ3eWJoM0x5VkZuNGhOK0ZTTVkwcktCd0xOZjBmNnIxWkN4VTVEK2Nk?=
 =?utf-8?B?clpJNFFZdlJ3RlY0MUxlcnBtWEg2N1V1TVpnWWtOS3ZpM3B3aXRnem1pV1Nk?=
 =?utf-8?B?R0VmOFMwTUR4K1Z6SGRwZGxWaitPMitndHhkdUU1dldKeHFNajVDVlIwMm9l?=
 =?utf-8?B?TFRaN3laOTFrU1hSaHhHRnNpTjVLbGVvZEEvelZPSFdhM2JMQjloOE92QVZT?=
 =?utf-8?B?aEJzcVB1MXVRbWhUalNKOGlRWXRMcGViTUF1R0ZqTU1EMUh6eWttYU9xSFlo?=
 =?utf-8?B?MTcrbVZQRzFyb1g1bExBc0pmUFVwNG5ocmQvZW1nWGRDZ2lmWlpUQVRJanNy?=
 =?utf-8?B?V0RxTmZLQ2ZESVRibFR6aVc4TWNUZVVieFhHdmJIT3BOL25GenVVazB1RDY1?=
 =?utf-8?B?QnI3V1JSL0N4aElBb0YxcXczWkd5SVM2U0UxLzlJODZYdnZBMFZRZ1B1dGJT?=
 =?utf-8?B?QUxkOGVML2hiQ0ltSUFaS1VET3VlUEJXY25EZG53T3lIS0RkcHBzK0NrdkVj?=
 =?utf-8?B?NUtBa1RFU3JJamllaGVNaVBNeG1oMVpjVW1FaTJrN2R2VHRTblN1MFNYcTFo?=
 =?utf-8?B?eTFPdENhSHVqUzFSOXc3eGIxdG15c3hPMktRS0NQbmJLSkYxeFBMKyszQ0Rs?=
 =?utf-8?B?dUNlNHQ0dkF0YXNlRWtndHJxQkIvRm1za2w4TEJDVGJSM0p0bXJ5TWVwLzl3?=
 =?utf-8?B?azJXNUJyZzhpWkdYdzRkR1VBWTRST3o1d1Y0dVBpWG5VdHFYV0NlMWxZUkVO?=
 =?utf-8?B?eGdTZ1RiN0FVV0ZBWVRVYXV4cm5vR3RLRGVna3YvU1NKVHNhYlVCaUxsS0FP?=
 =?utf-8?B?M0xsdnUwWTFjN3pGc1o4QmRmaEt2TU5Rc0xxYTZrbGZIa3diTmJMVStQUjlz?=
 =?utf-8?B?TGZ2eENZWGZlY0hSM1Z5M1FUV3RaZXdOZS9sY2J3Ym5pYldGcm9NK1RiSXow?=
 =?utf-8?B?Vi8yRXJIUDNKM3R0TXlDTXdPb1hob01WQmlocDhuOWRpMjhjNVkxWlk3Q0Fq?=
 =?utf-8?B?QjBGeGcwKy9idUFOU0xnR3pPMkhZTzAzeEpDa1FVS1ZpNmhNUFN4OG5lTjVY?=
 =?utf-8?B?RUdRNzdiZ2Y4bVk2RWUyeTdQaFlSaC9VWkNQU2FDSHVVNXNQSzdRZllLcW9a?=
 =?utf-8?B?NnZBRkxKVFc1aU5JbGRJb2JZSGd5ZmZGazFQSUhFYzFyRjdGVTkvNlI1WHF4?=
 =?utf-8?B?SC9rY1VSakNicXZ2UjQ3bUgxZjMyL01YNWloMXZKRlk0SjRWenlZbUZOaTdo?=
 =?utf-8?B?T3dwSjZxSk9udC9YN2o0Mi9pdjNwd3dmdndqSkppYms2QldLbDhwdEowc1pK?=
 =?utf-8?B?bzVrZlJQYnNSWmdGSlB5dzU0dUNvQjBldWR2TUE0bC80MFhGMERpc1liMk8w?=
 =?utf-8?B?SWF4RzZ3bmxkWmMwVWZoNFRkaXp3VDRZbjBJU2RLUE5PRjRKVFhzRWNOT2VU?=
 =?utf-8?B?QlhvK0VsZHpyVlMxemQvd3AxUGM5QmtmUFVJbi9PdWFLSGNnVXkvZEpSL3Bp?=
 =?utf-8?B?SHlZU0pWTVgrNkFxT3dhTHNWcUlvZXN3aG05Tm1zM1NZQjJsTHYyNFpEc1Vk?=
 =?utf-8?B?cmlyNjN1U0M4ZkN1aUc1c0VRaStLYXRNb29aVVVnUzF5dDUzaEJHUkgraW9j?=
 =?utf-8?B?SUU3Y1lNQ1AzL2NQekpndVFpMmRRTXd3b0ZJeGxldU1Ja0xQS3JXSzhSWjdL?=
 =?utf-8?B?ODZ1Vms4TUdGK1FCZzNrMG9RQkUyeUVqV0tSSHBrZ1owVjdLUUl0U2R0OVBK?=
 =?utf-8?B?bUZpQjBKWng5Nk5VdDh0bmVOSXlEc0JBbkNiNXRVem9yeXZFUVFYZ1VKRHl5?=
 =?utf-8?B?NHl1cm50ZVpzVzExcmRXL0l3aVBSQVRDZHlMYjE0aDFFa2p1ZjZZK3RIRGZV?=
 =?utf-8?B?NHJtNWNZS3JSbE83dklFTWZHUUJ4SmtoRkJkUU91K0VINjN6M0Rac3pEMklj?=
 =?utf-8?B?a2h5V2tqdXlkSmZ5OVhkNjhrL1A5a1VDQThxcGNxQk9ka2NqcVpJQ29EZzNB?=
 =?utf-8?B?KzZDQTc1RjBRRC83SXNTeGIyMGt1UTRFZHpZaTNzTWdUVGlpN0Y2RG9Nd2tY?=
 =?utf-8?Q?jnL0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60cad6e-918e-4d0b-90d7-08dbfa577081
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:42:46.1009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyfBvMqA4Nitq2LqqT3jPhbs93pOtuFzkSqrXToBDH3pAldoSmrGeiEnfy4pYH6u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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
Cc: Philip.Yang@amd.com, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-12-06 10:24, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231206152410.123993-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

v2:
-not need calculate vram page number for new registered svm range, only
do it for split vram pages.

v3:
-use dma address to calculate vram page number of split svm range;
use migrate_vma from hmm to calculate page number that migrate to vram.

SVM uses hmm page walk to valid buffer before map to gpu vm. After have partial
migration/mapping do validation on same vm range as migration/map do instead of
whole svm range that can be very large. This change is expected to improve svm
code performance.</pre>
    </blockquote>
    <p>This looks better, but it is redundant to loop through
      prange-&gt;npages to find vram pages after splitting.</p>
    <p>Could add new function svm_range_split_vram_pages to split
      dma_addr array and count vram_pages in the same prange-&gt;npages
      loop...<br>
    </p>
    <p>svm_range_split_adjust(struct svm_range *new, struct svm_range
      *old,<br>
      {</p>
    <p>.............</p>
    <p>&nbsp;&nbsp;&nbsp; if (old-&gt;actual_loc &amp;&amp; old-&gt;ttm_res) {<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_split_nodes(new, old, start, last);<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return r;</p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_range_split_vram_pages(....);<br>
    </p>
    <p>&nbsp;&nbsp;&nbsp; } else {</p>
    <p>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; r = svm_range_split_pages(new, old, start, last);<br>
      &nbsp;&nbsp;&nbsp; }<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20231206152410.123993-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 35 ++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 72 ++++++++++++------------
 2 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index b854cbf06dce..34376184c37c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -260,19 +260,6 @@ static void svm_migrate_put_sys_page(unsigned long addr)
 	put_page(page);
 }
 
-static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
-{
-	unsigned long cpages = 0;
-	unsigned long i;
-
-	for (i = 0; i &lt; migrate-&gt;npages; i++) {
-		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_VALID &amp;&amp;
-		    migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE)
-			cpages++;
-	}
-	return cpages;
-}
-
 static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
 {
 	unsigned long upages = 0;
@@ -402,6 +389,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	struct dma_fence *mfence = NULL;
 	struct migrate_vma migrate = { 0 };
 	unsigned long cpages = 0;
+	unsigned long mpages = 0;
 	dma_addr_t *scratch;
 	void *buf;
 	int r = -ENOMEM;
@@ -450,12 +438,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 	r = svm_migrate_copy_to_vram(node, prange, &amp;migrate, &amp;mfence, scratch, ttm_res_offset);
 	migrate_vma_pages(&amp;migrate);
 
-	pr_debug(&quot;successful/cpages/npages 0x%lx/0x%lx/0x%lx\n&quot;,
-		svm_migrate_successful_pages(&amp;migrate), cpages, migrate.npages);
-
 	svm_migrate_copy_done(adev, mfence);
 	migrate_vma_finalize(&amp;migrate);
 
+	mpages = cpages - svm_migrate_unsuccessful_pages(&amp;migrate);
+	pr_debug(&quot;successful/cpages/npages 0x%lx/0x%lx/0x%lx\n&quot;,
+	        mpages, cpages, migrate.npages);
+
 	kfd_smi_event_migration_end(node, p-&gt;lead_thread-&gt;pid,
 				    start &gt;&gt; PAGE_SHIFT, end &gt;&gt; PAGE_SHIFT,
 				    0, node-&gt;id, trigger);
@@ -465,12 +454,12 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free:
 	kvfree(buf);
 out:
-	if (!r &amp;&amp; cpages) {
+	if (!r &amp;&amp; mpages) {
 		pdd = svm_range_get_pdd_by_node(prange, node);
 		if (pdd)
-			WRITE_ONCE(pdd-&gt;page_in, pdd-&gt;page_in + cpages);
+			WRITE_ONCE(pdd-&gt;page_in, pdd-&gt;page_in + mpages);
 
-		return cpages;
+		return mpages;
 	}
 	return r;
 }
@@ -498,7 +487,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	struct vm_area_struct *vma;
 	uint64_t ttm_res_offset;
 	struct kfd_node *node;
-	unsigned long cpages = 0;
+	unsigned long mpages = 0;
 	long r = 0;
 
 	if (start_mgr &lt; prange-&gt;start || last_mgr &gt; prange-&gt;last) {
@@ -540,15 +529,15 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 			pr_debug(&quot;failed %ld to migrate\n&quot;, r);
 			break;
 		} else {
-			cpages += r;
+			mpages += r;
 		}
 		ttm_res_offset += next - addr;
 		addr = next;
 	}
 
-	if (cpages) {
+	if (mpages) {
 		prange-&gt;actual_loc = best_loc;
-		prange-&gt;vram_pages = prange-&gt;vram_pages + cpages;
+		prange-&gt;vram_pages = prange-&gt;vram_pages + mpages;
 	} else if (!prange-&gt;actual_loc) {
 		/* if no page migrated and all pages from prange are at
 		 * sys ram drop svm_bo got from svm_range_vram_node_new
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2834fb351818..8d012ca82cd6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -158,13 +158,12 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
-		      unsigned long *hmm_pfns, uint32_t gpuidx, uint64_t *vram_pages)
+		      unsigned long *hmm_pfns, uint32_t gpuidx)
 {
 	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 	dma_addr_t *addr = prange-&gt;dma_addr[gpuidx];
 	struct device *dev = adev-&gt;dev;
 	struct page *page;
-	uint64_t vram_pages_dev;
 	int i, r;
 
 	if (!addr) {
@@ -174,7 +173,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		prange-&gt;dma_addr[gpuidx] = addr;
 	}
 
-	vram_pages_dev = 0;
 	addr += offset;
 	for (i = 0; i &lt; npages; i++) {
 		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
@@ -184,7 +182,6 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		if (is_zone_device_page(page)) {
 			struct amdgpu_device *bo_adev = prange-&gt;svm_bo-&gt;node-&gt;adev;
 
-			vram_pages_dev++;
 			addr[i] = (hmm_pfns[i] &lt;&lt; PAGE_SHIFT) +
 				   bo_adev-&gt;vm_manager.vram_base_offset -
 				   bo_adev-&gt;kfd.pgmap.range.start;
@@ -201,14 +198,14 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		pr_debug_ratelimited(&quot;dma mapping 0x%llx for page addr 0x%lx\n&quot;,
 				     addr[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(page));
 	}
-	*vram_pages = vram_pages_dev;
+
 	return 0;
 }
 
 static int
 svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		  unsigned long offset, unsigned long npages,
-		  unsigned long *hmm_pfns, uint64_t *vram_pages)
+		  unsigned long *hmm_pfns)
 {
 	struct kfd_process *p;
 	uint32_t gpuidx;
@@ -227,7 +224,7 @@ svm_range_dma_map(struct svm_range *prange, unsigned long *bitmap,
 		}
 
 		r = svm_range_dma_map_dev(pdd-&gt;dev-&gt;adev, prange, offset, npages,
-					  hmm_pfns, gpuidx, vram_pages);
+					  hmm_pfns, gpuidx);
 		if (r)
 			break;
 	}
@@ -982,11 +979,6 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
 	new-&gt;ttm_res = old-&gt;ttm_res;
 
-	/* set new's vram_pages as old range's now, the acurate vram_pages
-	 * will be updated during mapping
-	 */
-	new-&gt;vram_pages = min(old-&gt;vram_pages, new-&gt;npages);
-
 	spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
 	list_add(&amp;new-&gt;svm_bo_list, &amp;new-&gt;svm_bo-&gt;range_list);
 	spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
@@ -1049,6 +1041,28 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	return 0;
 }
 
+static int
+svm_range_vram_pages(struct svm_range *prange)
+{
+	int i, j;
+	dma_addr_t *addr;
+	uint64_t vram_pages = 0;
+
+	for (i = 0; i &lt; MAX_GPU_INSTANCE; i++) {
+		vram_pages = 0;
+		if (!prange-&gt;dma_addr[i])
+			continue;
+
+		addr = prange-&gt;dma_addr[i];
+		for (j = 0; j &lt; prange-&gt;npages; j++) {
+			if (addr[j]&amp;SVM_RANGE_VRAM_DOMAIN)
+				vram_pages++;
+		}
+	}
+
+	return vram_pages;
+}
+
 /**
  * svm_range_split - split a range in 2 ranges
  *
@@ -1100,6 +1114,10 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 			 r, old_start, old_last, start, last);
 		svm_range_free(*new, false);
 		*new = NULL;
+	} else if (prange-&gt;actual_loc &amp;&amp; prange-&gt;ttm_res &amp;&amp; *new) {
+		/* calculate *new vram_pages and reduce from prange vram_pages */
+		(*new)-&gt;vram_pages = svm_range_vram_pages(*new);
+		prange-&gt;vram_pages -= (*new)-&gt;vram_pages;
 	}
 
 	return r;
@@ -1109,7 +1127,7 @@ static int
 svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	struct svm_range *tail;
+	struct svm_range *tail = NULL;
 	int r = svm_range_split(prange, prange-&gt;start, new_last, &amp;tail);
 
 	if (!r) {
@@ -1124,7 +1142,7 @@ static int
 svm_range_split_head(struct svm_range *prange, uint64_t new_start,
 		     struct list_head *insert_list, struct list_head *remap_list)
 {
-	struct svm_range *head;
+	struct svm_range *head = NULL;
 	int r = svm_range_split(prange, new_start, prange-&gt;last, &amp;head);
 
 	if (!r) {
@@ -1573,7 +1591,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	struct svm_validate_context *ctx;
 	unsigned long start, end, addr;
 	struct kfd_process *p;
-	uint64_t vram_pages;
 	void *owner;
 	int32_t idx;
 	int r = 0;
@@ -1642,15 +1659,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 	}
 
-	vram_pages = 0;
-	start = prange-&gt;start &lt;&lt; PAGE_SHIFT;
-	end = (prange-&gt;last + 1) &lt;&lt; PAGE_SHIFT;
+	start = map_start &lt;&lt; PAGE_SHIFT;
+	end = (map_last + 1) &lt;&lt; PAGE_SHIFT;
 	for (addr = start; !r &amp;&amp; addr &lt; end; ) {
 		struct hmm_range *hmm_range;
 		unsigned long map_start_vma;
 		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
-		uint64_t vram_pages_vma;
 		unsigned long next = 0;
 		unsigned long offset;
 		unsigned long npages;
@@ -1677,13 +1692,11 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		if (!r) {
-			offset = (addr - start) &gt;&gt; PAGE_SHIFT;
+			offset = (addr - (prange-&gt;start &lt;&lt; PAGE_SHIFT)) &gt;&gt; PAGE_SHIFT;
 			r = svm_range_dma_map(prange, ctx-&gt;bitmap, offset, npages,
-					      hmm_range-&gt;hmm_pfns, &amp;vram_pages_vma);
+					      hmm_range-&gt;hmm_pfns);
 			if (r)
 				pr_debug(&quot;failed %d to dma map range\n&quot;, r);
-			else
-				vram_pages += vram_pages_vma;
 		}
 
 		svm_range_lock(prange);
@@ -1716,19 +1729,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		addr = next;
 	}
 
-	if (addr == end) {
-		prange-&gt;vram_pages = vram_pages;
-
-		/* if prange does not include any vram page and it
-		 * has not released svm_bo drop its svm_bo reference
-		 * and set its actaul_loc to sys ram
-		 */
-		if (!vram_pages &amp;&amp; prange-&gt;ttm_res) {
-			prange-&gt;actual_loc = 0;
-			svm_range_vram_node_free(prange);
-		}
-	}
-
 	svm_range_unreserve_bos(ctx);
 	if (!r)
 		prange-&gt;validate_timestamp = ktime_get_boottime();
</pre>
    </blockquote>
  </body>
</html>
