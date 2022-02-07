Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D20C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 15:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7883610F94F;
	Mon,  7 Feb 2022 15:17:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A636710F94F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 15:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYwMbbgPK2SqrgqDu9xnsIQbRNAAM8CIrvqPo24ug1W2xsSX4Fqe19ljAp3inRssMAGMV8TfdFM4RQc7DMsTGmMoJd3/HZFtBjDjei/uCMj/e+CiTsxP/9R3FTKHJwtgKnqFydTnPnUKCUwEQSP9oG6JfQ9wHmbPZbSu0+gnwS9jWVIElcIanwmFUIgmEUBnjiZK9qgQjE6l6WQbfc648JRVOLeEl5KwcTXrClKgSRbnbkbWcKmjcI1XuhrJ702WBx7XGjiI2TNbQfRiWI5Y2TSp+6MGb0YPGmRVLMC/3GWgnLUDhb9gFhC8OIsw3wWj3EpA9GtG/Phhl3+dPm7h6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6qB0Xq5jR00nZUmFVEwam0QajHNA7QGa7mxI7UFCng=;
 b=EPY6ZcDbdAL8zKw70KtGDIyzF0WVgJzBo/FzQAI4oHSoJa+zWBOL/PvyTXz96NgfD9T+Mpf4CoC9XLFc9AuKpdQ/HUCgppI0rqgZnFB4pbSpCiJ8HLMb29JVGcCrvZOP+cq4+PEnGTsbdMHoLWMbYlAiIqOehyQskvTVPXhFTxO4a3MpI29nbGU+J4PKDtES7l3zHQ9zyHFxsNKaw174qFJ9bTSvcJvEjR6mtgNMgSRRmyVS2egZB4iK6Heg9OQEUThhHQCydG/R8jJhVjjqal1RdebDuMpx4eFYycRlgRVAFcV3xIpTr/3Ah+tHdEj1Hg3KKowDixiiGnTx4iCWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6qB0Xq5jR00nZUmFVEwam0QajHNA7QGa7mxI7UFCng=;
 b=e6+OhwNAY5UZ+ah5H5HjgC+1YN1yZWCm6OKar3ogtWfMrgQujRP3DQ2FXX2PBf2EaG+qr6kq+TDqbloNRInS9hMW4+pFRebRJoGwdchNeRTo+NYg8r5Qc4eE19NBUpTPQvdsHnGFpkGINjXPkBDfBZlc3IrPl81GFQSNZbm3+bo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY4PR12MB1270.namprd12.prod.outlook.com (2603:10b6:903:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 7 Feb
 2022 15:17:53 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::14cd:f56f:bac0:a862]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::14cd:f56f:bac0:a862%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 15:17:53 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Fix TLB flushing in KFD SVM with no HWS
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220204234513.11714-1-mukul.joshi@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <3f7c9fb2-d53b-5c51-2af2-797a14c2210a@amd.com>
Date: Mon, 7 Feb 2022 10:17:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220204234513.11714-1-mukul.joshi@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:610:60::16) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da55f275-d74c-4061-8f54-08d9ea4d0301
X-MS-TrafficTypeDiagnostic: CY4PR12MB1270:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1270ABAAE781A94D0D208D59E62C9@CY4PR12MB1270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ot7DGcbvxIViGQPI9orD7GdIn6h9rAfQBgksEEALnvi5QfXiFROWw2rzeqf1/9AsyqGZV24pnA/tFCHIcv9Tt4yDBb5t+OvPstPSPjzSxnlyFzx2FnevKeRsP/IdSf5CHRigNTuBQWMroj0k1eAcDi2CgcZsN3s16A9NST/ljiQm4cfzi+n5veG4S21lCabAJMpas177q5izj9XtsUZ+yU6+RWmgtz+jSWffbEvaQr9wbUFd0GpbU7u8tj4kDxdK+tdnP5c7wIYXXynG0rvADs3NK5zMU5n2PGU4NvPH0OGieRvdBpHJBbg1LuN68FIcuS2/axAoQuhkHK0bM0wI5QFis0hltZLlQpwLi2CqkraUIx1HAhjvrJ2P1ibq9O4Lr30uWWKEdTvMN+ZJSbKOKKvVEHJf4hCKYqFYnbGq5mhGW5WMtCNZsYY+q4PElWy91qvkBtnLZG2taStiXjTc33HIc4ONifWq2OSONrEy1ufqNjQlXNzTKZdM49/b3g+80sEm3owBmKf/nm0bxYR/1bkzUooe8FPrpvM9PI3NC8ie/eQNUgCjYzEVr/pS59yc2zt+P3+RHSn/RwqlZwyOAX278TQDLSlSGmJuzmtXNhJDVa7HOD1MnNM2kngquRUpXcYUORpjQ6/TphMYkjSh4ZPFejIM8t0mPn0YtT1hXyQ1k9DsusUCzFRub25ets7x90jS2Np6e3VfM9O5+2puEm07MAaY0Mxljbf0m/L1eYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(8676002)(66476007)(2616005)(26005)(66556008)(5660300002)(31696002)(6486002)(66946007)(83380400001)(4326008)(8936002)(6512007)(53546011)(316002)(6506007)(2906002)(31686004)(508600001)(38100700002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUxzelhyUXB3MEpING9sNXd6enFvUEJMdGRFV29oYWZ3K3E0dnRFbWRxYXl2?=
 =?utf-8?B?R1cxYVI2QUJnU0h3WlptdlNjU005R0FwYVVwQm9PWEQzYm9NM3pWaUEybWRh?=
 =?utf-8?B?Tmh0T1A5VmRTTS8wTmI0cmhreGsrVmY3WnVkRmdWTE9BcjE1aEJGU0NPeW1q?=
 =?utf-8?B?Z1ZwdCttQXJQWDYvSEdjWGYvTGM4NGdRd2tGVnBTWXE5NEd1QjZxQ3RYNWRC?=
 =?utf-8?B?MU5DM0w3bDNDcXdLQWZyeXA0bmZVWWZETC9CaHJmaEFNMS9jTUFqbXA5c3pI?=
 =?utf-8?B?b1pSdVZMMmttbmlWN1QyYzhObmhjRldmKzI5cUJ3LzNPUWJlQnBleG1WWFRl?=
 =?utf-8?B?WDIwa1RVQXlaKzZ0Nms4VTdTZmRvSGdBd1BwdzRoc2h1ZlZoNXBTTFFSYTRs?=
 =?utf-8?B?M2VRSWJsQXhBVFZQYkFkUmg1TTVhOENMRDhXWnkvY0hwbnA2MWUrR1NPR0xH?=
 =?utf-8?B?eWtQWVNoaktWNjg0NXNzYWM5TmJqV0wvR2lGcDFsN3VFbUIwTkNDYnc4b3RJ?=
 =?utf-8?B?dXpZc1ZtNnF2ZWxBTk5OUytqN1JhV2JmWjhoVWEwNlZaSGp4UmlwWnhERlZl?=
 =?utf-8?B?VVNFYmpZY0hqYzVGZGNmdjJ3b3hRelVRbkczankyYmQ2RHdJRGNBYjBwQmZN?=
 =?utf-8?B?LzEzMWdnWEJXSHRyR2xKZ0JQK3ZqVVJnakVZTHl2QVZxbVVrRjJ2di8yRW9G?=
 =?utf-8?B?d0xzOFBtZWhHUFg4eE9lUS9IOG5jZjg1Ri94bGJYNUgydWtWOUh5cHRqVytE?=
 =?utf-8?B?R0VvazNnSDFpSnU3SDdxRkJwZ1Z4SjV0REFXczk0SGNSOFVTUDErdE5PclNI?=
 =?utf-8?B?a29neEZOZXp6YXN1bWtqck1qU2xNaVJzR1JZcXBCVFdWWUhmRTV3aER6SDhk?=
 =?utf-8?B?S0hmQ1JONk51TkpuZENsaS9wdWFWR3UvV3dQY0llK0NONGF3cUl4anI5MFpp?=
 =?utf-8?B?Z0VvaEZBaEpPMVNNRUJXdWVPZlV6dlNIQWxXVjVoeHdGTVV3NGRvVTFqbUc0?=
 =?utf-8?B?a2dIYUt5T2lrbTE5eVowakZXTC9BOFZtS29LaG1EVktXWmVFcC9mVzFuRkZZ?=
 =?utf-8?B?Y1ZYT2c0NDRDai9sdVZHT2l1dU1QQ0pGazBBNGdtcElvVmE2ZlgyUmh0VGFm?=
 =?utf-8?B?NWs0WGxtUHlDR053T0xEdHByZW5WM2JKSUxSN0IyZEM3MEwxUi9QRFZBQ2Fn?=
 =?utf-8?B?NGF2M1hINDhYWE9hSXc3bEVFbDFhZzliQXpGa2ZMRS91SzFhcUtXNFZXWmhF?=
 =?utf-8?B?NDdER2U0TFlVWW5PUE9ManhiSElWOXZpcDRENzh0bkZjaW14MjBQdDUvd2ZI?=
 =?utf-8?B?ODkrTWFZem82OWdpNUxqd0JlL2JKUzVTU3RQL3RsMXl5R2laN1A4dzY5S1Ar?=
 =?utf-8?B?TGI1dW5tdHdoNkVseG1Ca2JHQmx0bFRZLzJvc1dxd1RURmZsemYzYzZ4YmJl?=
 =?utf-8?B?YUNqT2pRL211TjRXN3pQeThRN1g1WThibHBPUGM1eDJxVkJRV0JsdjBLKzNQ?=
 =?utf-8?B?STBVT1Arc0JGSmdzOFR6RmdxY2sxUjZNVERXY2V1cDQ0dG1oMnRCekNvN3Fs?=
 =?utf-8?B?cGxFZkpoS0phUjVmV0VjOHNFbk9OTnRvZWNQK1ljRC9vNlRwNWdTaER0QVI1?=
 =?utf-8?B?alhmZkZkeTJjV2xzb0tqaHdYaFlxUm9aQjU2cUQ0cUJqQmltQTdrbVBtbUcy?=
 =?utf-8?B?R1lYL2J5UDFQc1ZsM1RqYnhQRy9hOEN0ckVXbVNBbTF1bmNQRFhPdWtoYTNM?=
 =?utf-8?B?WGlDZVB6bnluVWowY2FQdFN0TVhmeHNnK1drbER6ekxDM0pDMXVrYzBEYUJs?=
 =?utf-8?B?UDVOK2NXVGtKd0xOWHFsOHRHelErUGZWM2VycGppZkRLZTFHbktVVHpocEhv?=
 =?utf-8?B?OVRxc0ZCSm9FMVcyek9uVHREc0lqKzN3OS8xVFBicmxTOXJ5Z2t5dTBSbER0?=
 =?utf-8?B?N3BkM2UwYnR6WXhtWno4dXZTSmRiaVB6TERUM2RaWkFiSTA5SnZJWlcrQlNB?=
 =?utf-8?B?WGY4S3RmQjczUlp0bUkvZ0ZVT3dlYWFxZWwrajRRMnhKREZJV0NIQ2xtcUNT?=
 =?utf-8?B?YzAzRis0blU1WTFDanZ4RVJaYnM4TjdzYUxHZjM1MXNCZC8ya0drMHM4WERT?=
 =?utf-8?Q?inHw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da55f275-d74c-4061-8f54-08d9ea4d0301
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 15:17:53.5627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PI688XVHySLB1uo10zm1m+lfkKdHU22nSITlSD2y0GTDL1h80ebwO6y6M1Hpqxin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1270
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
    <div class="moz-cite-prefix">On 2022-02-04 6:45 p.m., Mukul Joshi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220204234513.11714-1-mukul.joshi@amd.com">
      <pre class="moz-quote-pre" wrap="">With no HWS, TLB flushing will not work in SVM code.
Fix this by calling kfd_flush_tlb() which works for both
HWS and no HWS case.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a></pre>
    </blockquote>
    <p>With below change to remove one extra calling parameter, this
      patch is<br>
    </p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a></p>
    <blockquote type="cite" cite="mid:20220204234513.11714-1-mukul.joshi@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 41f03d165bad..b1315c97b952 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1229,15 +1229,14 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-		amdgpu_amdkfd_flush_gpu_tlb_pasid(pdd-&gt;dev-&gt;adev,
-					p-&gt;pasid, TLB_FLUSH_HEAVYWEIGHT);
+		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
 	}
 
 	return r;
 }
 
 static int
-svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+svm_range_map_to_gpu(struct amdgpu_device *adev, struct kfd_process_device *pdd,</pre>
    </blockquote>
    svm_range_map_to_gpu(struct kfd_process_device *pdd, struct
    svm_range *prange,<br>
    <blockquote type="cite" cite="mid:20220204234513.11714-1-mukul.joshi@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		     struct svm_range *prange, unsigned long offset,
 		     unsigned long npages, bool readonly, dma_addr_t *dma_addr,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
@@ -1248,6 +1247,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">struct amdgpu_vm *vm = drm_priv_to_vm(pdd-&gt;drm_priv);
struct amdgpu_device adev = pdd-&gt;dev-&gt;adev;</pre>
    <blockquote type="cite" cite="mid:20220204234513.11714-1-mukul.joshi@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	int last_domain;
 	int r = 0;
 	int64_t i, j;
+	struct amdgpu_vm *vm = drm_priv_to_vm(pdd-&gt;drm_priv);
 
 	last_start = prange-&gt;start + offset;
 
@@ -1305,12 +1305,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (fence)
 		*fence = dma_fence_get(vm-&gt;last_update);
 
-	if (table_freed) {
-		struct kfd_process *p;
-
-		p = container_of(prange-&gt;svms, struct kfd_process, svms);
-		amdgpu_amdkfd_flush_gpu_tlb_pasid(adev, p-&gt;pasid, TLB_FLUSH_LEGACY);
-	}
+	if (table_freed)
+		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
 out:
 	return r;
 }
@@ -1351,7 +1347,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
-		r = svm_range_map_to_gpu(pdd-&gt;dev-&gt;adev, drm_priv_to_vm(pdd-&gt;drm_priv),
+		r = svm_range_map_to_gpu(pdd-&gt;dev-&gt;adev, pdd,</pre>
    </blockquote>
    svm_range_map_to_gpu(pdd, prange, offset, npages<br>
    <blockquote type="cite" cite="mid:20220204234513.11714-1-mukul.joshi@amd.com">
      <pre class="moz-quote-pre" wrap="">
 					 prange, offset, npages, readonly,
 					 prange-&gt;dma_addr[gpuidx],
 					 bo_adev, wait ? &amp;fence : NULL);
</pre>
    </blockquote>
  </body>
</html>
