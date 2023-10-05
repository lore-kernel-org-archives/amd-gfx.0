Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80606E92730
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 19:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0642A10E17C;
	Thu,  5 Oct 2023 19:28:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B00310E17C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 19:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Acx7kKcORAYEuCRkfVzPkkILrEiNXvuj6rmfoiVkGq1Fofz2oqYJf6l1Z1NaiRtDKYyyFCPd19tjKH5uzO0ZZpaTSv2f2eWGU4B/qCq+PNSWs24hHWhBL70Aqdl/LGMkPWhZksdRUgPaoblH3kQrWb6qblku9fhZsCzVlJ+fLstthd/RYfm63fVkg4UiHso5ArNeKVxhH0nSJbAhwignSqo4rKxhoh8xxb5vIxijx/h/S1F9bYPLBQVflcb+NCOHoG/2OOcusHqNxX5oyHKtto/bMwlfWO+zEcy0YJ2ySUAumjc1e0jzGGSDN+b7ffLwAHLWxmawJe3QTxNtxvz+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvd4I0CHpoKVDVFO3KMOaR+bh5kqlOWSl/La5d8Z4Ig=;
 b=OnTHVa2nGdT/A1GkzSKi3oSaB4l3egtFFIkBnXTqdeSJRgCOrDY18nW5rGmT0jiH78jE1JxAQUABylRKUN9ISl09FcFdlEWVc8Lpbmm4x2uwB3UgmUqG0abxKVW26EJ9EkSyQbC22BFKeujPzJfHsLHRZnq/O7XVOtWcsMpwvX3h+/8Bzw+T+oZNwZNkjqX9WI7DkjkW9jvBveDlMgB12z9YTDUb552IlcF9v94lsx6wj1wNNDzAJC76Ob7prpbkyrJefLppCf8Wo2lQMbHcU2Sx34/ckMDcJvJ1T1TIM5r63N/qLHITKd6KD+n6I1mwQE0bI2TrstDQ6FyTvgjRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvd4I0CHpoKVDVFO3KMOaR+bh5kqlOWSl/La5d8Z4Ig=;
 b=N/A5Q4UZ4dROCdLejR5t2oPwbiz4VA6XmWusb24/5iAO3ufWdQNT8aXLEBWaOmnp57Wz3jZz60R6SX2KIvn00M5GekrF+qmdPyWjDAl/Dxe4V5M40E59Pay+fXU38DXBYwQVGV/x3umrEg+8PSo9850qbR/2v5t0P+LdDMeJyug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 19:28:15 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:28:15 +0000
Message-ID: <3030efae-8dd1-3318-44a9-e69649de815d@amd.com>
Date: Thu, 5 Oct 2023 15:28:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] amd/amdkfd: Add granularity bitmap mapped to gpu flag
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
 <5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 851fb059-bb3b-4e87-3dfa-08dbc5d938f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8ZDelDOLyxQcVZ/i1BN/pGCi6+iO0jfLkfllXYByZaxLX6tZzsV/L8VCXwjhmpnGzsZHnCFeVicRaCMBobnGNpSnxY7shR5Rujzfl/tXyv1T1UdZDKYfm1P7yqZd2rsbmIGPnLD7mTAAxLdg5zkNheZpUDKKmP/GTqlRDl09u6LjUZXoUjggBdB2qMoN4a154kFUPlJIN9lTEv941pJ+i7co+xBk2KNF2euxrlsfAUUYpSOKBq8nWsV9xaegCV06RlESvNVPGMB8pqfImL9cWLf5LxSUn3SusGSMnUW8yUsAIVc+HnWuXdW3defTjnyfl9pk46RQ42WdMe6rBdDXoHJIMoMgLXqFiwAUQJ9/cIYMaFeTI8Swequc08CZzP0OGjVXpe/1fKql/0YyE0o6etDTv88wZyy9+xJtzgD6JWFxNi7mrFp+CBBkJI0vHdqIbkZuUbln3XuMzCyhwQ43yTHLGyqfp8jNml1IR1YA2eSD21qr/HxwKbsHcKYuyD9BZluZ/UV7YDeK2YJ0h1u6jXYYEsgIv4lvGl+6W3FRAyCeiIKAZ9xbdoGP5+8Rwr0m9kxRutu1y0Tnl5ZtsWhei2CHPH5k+44C4a7RYQTK6HHRXp3SlEnDreIxkiCyIohyWDDdWEDMQc7ofng7x/J4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2616005)(6666004)(5660300002)(26005)(8676002)(8936002)(31686004)(478600001)(31696002)(6486002)(66946007)(66556008)(66476007)(316002)(110136005)(38100700002)(30864003)(53546011)(6512007)(6506007)(83380400001)(36756003)(2906002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFJQ1RSZGhGUktoRnY1bnd4Nkg4Z0lHcVNYcENlVVRzc2JlSmZ5UTVOWHlI?=
 =?utf-8?B?eTZ6K0x0L2Ixb3UrME5sMTQ2UUlnZEpvZ3F2VURHTHh5d05JUDRPOW1meWFp?=
 =?utf-8?B?NVRIcUluUTJGMXNGSGU2MnpJZHlhS2lGQlZXNkhBekNzUnJ5V0I5Y3JIZlBD?=
 =?utf-8?B?T1FlNmQ1ZWRIYlZzMCtDTW9rTmVkYWtkOEx3Y2U5NFZGV2ZINGxlVWtpVjUy?=
 =?utf-8?B?dnJJRERqUUw0bjJ3RXE3Qk16cEZvay9jc0dCYmdYak9XcDJiZWR3ajc2ZGtR?=
 =?utf-8?B?ZW1FT0JLVTVwUWVRRmlPRlNsQ1pZTTM0cTNVNlZUQmZBOUlIWTd4WUplNWlq?=
 =?utf-8?B?ZGliS2hVcXlBVkNsNHRSWmsyL0pZQ3dNWkhUbEJiWWhiL0NvVlJDYkYwSjNX?=
 =?utf-8?B?bHV6RUJGK01WL21zQnlOOG9zMzlaVjdrN2VxaE9VRFpUR0txc20wME9HZkxr?=
 =?utf-8?B?d3JoS1NSNzRaUHVXaVJUUW1aZ2dXYVVQY0gyUUVEUXNiWklrL3EwSVFnOFB5?=
 =?utf-8?B?VWpRUVNFcWc4a0tUSW1aQWJLdEZyeHZaRXdFN3UxYkRUOXRoaEJDU0FQckRv?=
 =?utf-8?B?eWp5dTkza0JyRGk1YldyRDBMcWJ6ZTJJa1RGeWVNY1ppekhhWVQvTldHeERN?=
 =?utf-8?B?a2NIMU1DOXNuUlU4Sk9GWXBSaFYyNXVOWXdDdm5CbnA5WEdjSHI0TTcyek53?=
 =?utf-8?B?dDNZRitDNVRBRGJaUzBZSVFOeFZZdWhRbm14SlV5K3F0MTM2TFNEZ0R1eEEz?=
 =?utf-8?B?dUVvTncrVHp1MjFNaEY0aDZEbWsrWitJTjF5R3ZzRWFVU3IrckNERzRiTG5m?=
 =?utf-8?B?K1pvQjVQZi9aWkduK0JSSnpTalc4V3hQR3lUTDQ3RzlZOGFXVldRbjNqenZ5?=
 =?utf-8?B?d2dyTHVJN2tGYjFac2FHVmhJYnplakgxV2s5NGlEL1BiT1FDbityWGhzQi9i?=
 =?utf-8?B?bVVOc3ZiQVpJYWlCQU9WQ2RaUDhmM20vZlJPdUh3eHRVZlFjU0JQeVlmakNH?=
 =?utf-8?B?S1FpNDFoeFl5cjVIc1BnOXhvbUtjUW9NbTVkc2hnMUFQb0lnRFlPSTZlOUlC?=
 =?utf-8?B?TnM0dnRoN3c4T3ZDRjRVY3YrcU1IZHZPcTVUZnhrOTJaaEppL3dzUkw0N2Zr?=
 =?utf-8?B?WTREWmVlaHNHVWNKeUZDTEs3d2VwK0ZMOVRMbDhBMGJrcE1OYmxOaFk5MWU1?=
 =?utf-8?B?QmpKRFlzNzhqTU1mSTdVK283NkFab0RESlgzYkxpNjQ1ZWQvUUVwMEpsRlZx?=
 =?utf-8?B?cGxteEhzTVgyYUxrbGo2SW52TmZPYzRScHNSN1NrYVRsSXdFbU9rakdTTjNv?=
 =?utf-8?B?YVFqdEh0TXJ4WGpZUFVSeWs4LzNMdUdJcGFxNi9rYU90cXVwbXhIcnFqU1p1?=
 =?utf-8?B?REEzcGdBQjUyUGlxZThXNFhXVTRqbWt1cWlVVUY1dXkvWHQ4T3pqSnJkUUUz?=
 =?utf-8?B?WkIwcGFPVlJtWWNYV2tqWG5mOXRza1p0eVZJQUJ1Y2duZ0Q1VjhLQmp4S3Bm?=
 =?utf-8?B?T3BteE8wbEc0Rks0OTBFc0RQaDZCTkxLNXBlRUZLbVNaWDYwUjgvM2RObjlI?=
 =?utf-8?B?elF5NnJLSmlkRlc3ZDRnQ29uclYyRjlpbnk2WXBTYTJzOVRqRndZc3YrVkRV?=
 =?utf-8?B?WDZ0YVFHK1ZCNTFiZGZmVlN6dVBlWVJQRE1GK3dpcmY0dWJzR3hMazFwYlNu?=
 =?utf-8?B?L05TaXNhbDlQV0RVbGEyUTBNOStKcnVTWGRCWTFXLzNoOHVBSjVlb3JTcVJl?=
 =?utf-8?B?STNpNzZjUlNzL205cUs0RmpocVV5amhLWHBudGJUckp2b3lXYmlSbWUrQ2hk?=
 =?utf-8?B?eXVWblZGbkpPREFackMrOTZEbllwSmJHNHArMXVCNnpNVDY3WmQ4SXBnZDdk?=
 =?utf-8?B?Vk11S0xXL3pTZS9WYUxYZmRLc2tEYllReGtUYk54Ty9zQ2E5Z3VKRTdJbTI4?=
 =?utf-8?B?U2NoSjdYYzd5Z2ZMVUJWUFRQNTlkTzhkdW5CemFuU1p2WTY2d3lrVGZPeEhK?=
 =?utf-8?B?ZndjUTkvNno1dkJ1RFI3M2UzSWorRWtLbUdKeGc4RWdxaVJ3TG9XZkhGWW5u?=
 =?utf-8?B?emRFUnFoa0tibG5BNTd1VExZbEc0bno2NHN0QkRZcVBjK2dia0FUdFNZRTQw?=
 =?utf-8?Q?fvd4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851fb059-bb3b-4e87-3dfa-08dbc5d938f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:28:15.7953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4uHn0BKEEq7j84RBmNHvl5uSfEaKcZ5Kl0pHyEuK0rYMQPMnU27KlAoovZE16lE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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
    <div class="moz-cite-prefix">On 2023-10-02 14:35, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2023-09-29 10:11, Philip Yang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">Replace prange-&gt;mapped_to_gpu with prange-&gt;bitmap_mapped[], which is
based on prange granularity, updated when map to GPUS or unmap from
GPUs, to optimize multiple GPU map, unmap and retry fault recover.

svm_range_is_mapped is false only if no parital range mapping on any
GPUs.

Split the bitmap_mapped when unmap from cpu to split the prange.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 218 ++++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |   4 +-
 2 files changed, 184 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 040dc32ad475..626e0dd4ec79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -292,12 +292,12 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0);
 	}
 
-	/* free dma_addr array for each gpu */
+	/* free dma_addr array, bitmap_mapped for each gpu */
 	for (gpuidx = 0; gpuidx &lt; MAX_GPU_INSTANCE; gpuidx++) {
-		if (prange-&gt;dma_addr[gpuidx]) {
+		if (prange-&gt;dma_addr[gpuidx])
 			kvfree(prange-&gt;dma_addr[gpuidx]);
-				prange-&gt;dma_addr[gpuidx] = NULL;
-		}
+		if (prange-&gt;bitmap_mapped[gpuidx])
+			bitmap_free(prange-&gt;bitmap_mapped[gpuidx]);
 	}
 
 	mutex_destroy(&amp;prange-&gt;lock);
@@ -323,19 +323,38 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
 	struct kfd_process *p;
-
-	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
-	if (!prange)
-		return NULL;
+	unsigned int nbits;
+	uint32_t gpuidx;
 
 	p = container_of(svms, struct kfd_process, svms);
 	if (!p-&gt;xnack_enabled &amp;&amp; update_mem_usage &amp;&amp;
 	    amdgpu_amdkfd_reserve_mem_limit(NULL, size &lt;&lt; PAGE_SHIFT,
 				    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR, 0)) {
 		pr_info(&quot;SVM mapping failed, exceeds resident system memory limit\n&quot;);
-		kfree(prange);
 		return NULL;
 	}
+
+	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
+	if (!prange)
+		return NULL;
+
+	svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
+					 &amp;prange-&gt;prefetch_loc,
+					 &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
+
+	nbits = svm_range_mapped_nbits(size, prange-&gt;granularity);
+	pr_debug(&quot;prange 0x%p [0x%llx 0x%llx] bitmap_mapped nbits %d\n&quot;, prange,
+		 start, last, nbits);
+	for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported, p-&gt;n_pdds) {
+		prange-&gt;bitmap_mapped[gpuidx] = bitmap_zalloc(nbits, GFP_KERNEL);
+		if (!prange-&gt;bitmap_mapped[gpuidx]) {
+			while (gpuidx--)
+				bitmap_free(prange-&gt;bitmap_mapped[gpuidx]);
+			kfree(prange);
+			return NULL;
+		}
+	}
+
 	prange-&gt;npages = size;
 	prange-&gt;svms = svms;
 	prange-&gt;start = start;
@@ -354,10 +373,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
-	svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
-					 &amp;prange-&gt;prefetch_loc,
-					 &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
-
 	pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start, last);
 
 	return prange;
@@ -972,6 +987,48 @@ svm_range_split_nodes(struct svm_range *new, struct svm_range *old,
 	return 0;
 }
 
+static int
+svm_range_split_bitmap_mapped(struct svm_range *new, struct svm_range *old,
+			      uint64_t start, uint64_t last)
+{
+	struct kfd_process *p = container_of(new-&gt;svms, struct kfd_process, svms);
+	unsigned int nbits, old_nbits, old_nbits2;
+	unsigned long *bits;
+	uint32_t gpuidx;
+
+	nbits = svm_range_mapped_nbits(new-&gt;npages, new-&gt;granularity);
+	old_nbits = svm_range_mapped_nbits(old-&gt;npages, old-&gt;granularity);
+	old_nbits2 = svm_range_mapped_nbits(last - start + 1, old-&gt;granularity);</pre>
      </blockquote>
      <p>This may be off by one if start and last are not aligned on
        granularity boundaries. I think you need to calculate the index
        for each of start and last and subtract the indices. E.g.
        granularity = 9, start = 511, last = 512. last - start + 1 is 2
        and the division tells you you need one bit. But this range
        touches two different granules, so you need two bits.<br>
      </p>
    </blockquote>
    right, thanks, will check granularity boundary to calculate nbits.<br>
    <blockquote type="cite" cite="mid:5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com">
      <p> </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">+
+	pr_debug(&quot;old 0x%p [0x%lx 0x%lx] =&gt; [0x%llx 0x%llx] nbits %d =&gt; %d\n&quot;,
+		 old, old-&gt;start, old-&gt;last, start, last, old_nbits, old_nbits2);
+	pr_debug(&quot;new 0x%p [0x%lx 0x%lx] nbits %d\n&quot;, new, new-&gt;start, new-&gt;last,
+		 nbits);
+
+	for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported, p-&gt;n_pdds) {
+		bits = bitmap_alloc(old_nbits2, GFP_KERNEL);
+		if (!bits)
+			return -ENOMEM;
+
+		if (start == old-&gt;start) {
+			bitmap_shift_right(new-&gt;bitmap_mapped[gpuidx],
+					   old-&gt;bitmap_mapped[gpuidx],
+					   old_nbits2, old_nbits);
+			bitmap_shift_right(bits, old-&gt;bitmap_mapped[gpuidx], 0,
+					   old_nbits2);</pre>
      </blockquote>
      <p>Isn't this (shift = 0) the same as bitmap_copy?</p>
    </blockquote>
    yes, this should use bitmap_copy.<br>
    <blockquote type="cite" cite="mid:5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com">
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">+		} else {
+			bitmap_copy(new-&gt;bitmap_mapped[gpuidx],
+				    old-&gt;bitmap_mapped[gpuidx], nbits);
+			bitmap_shift_right(bits, old-&gt;bitmap_mapped[gpuidx],
+					   nbits, old_nbits);
+		}
+		bitmap_free(old-&gt;bitmap_mapped[gpuidx]);
+		old-&gt;bitmap_mapped[gpuidx] = bits;
+	}
+
+	return 0;
+}
+
 /**
  * svm_range_split_adjust - split range and adjust
  *
@@ -1012,6 +1069,10 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 			return r;
 	}
 
+	r = svm_range_split_bitmap_mapped(new, old, start, last);
+	if (r)
+		return r;
+
 	old-&gt;npages = last - start + 1;
 	old-&gt;start = start;
 	old-&gt;last = last;
@@ -1020,7 +1081,6 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
 	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
-	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -1310,6 +1370,84 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				      fence);
 }
 
+/**
+ * svm_range_partial_mapped_dev - check if prange mapped on the specific gpu
+ *
+ * @gpuidx: the gpu to check
+ * @prange: prange to check
+ * @start: the start address in pages
+ * @last: the last address in pages
+ *
+ * Return:
+ * true: if any partial range mapped on gpu based on granularity boundary
+ * false: if the entire range not mapped
+ */
+static bool
+svm_range_partial_mapped_dev(uint32_t gpuidx, struct svm_range *prange,
+			     unsigned long start, unsigned long last)
+{
+	unsigned long index, off;
+	bool mapped = false;
+
+	start = max(start, prange-&gt;start);
+	last = min(last, prange-&gt;last);
+	if (last &lt; start)
+		goto out;
+
+	for (off = start; off &lt;= last; off += (1UL &lt;&lt; prange-&gt;granularity)) {</pre>
      </blockquote>
      <p>It would be easier to just iterate over indexes instead of
        offsets. And even more efficient to avoid testing individual
        bits by using a higher level bitmap function, e.g.
        bitmap_find_next_bit E.g.</p>
      <pre>	unsigned long start_index, last_index;

	start = max(start, prange-&gt;start);
	last = min(last, prange-&gt;last);
	if (last &lt; start)
		goto out;

	start_index = (start - prange-&gt;start) &gt;&gt; prange-&gt;granularity;
	last_index = (last - prange-&gt;start) &gt;&gt; prange-&gt;granularity;
	return find_next_bit(prange-&gt;bitmap_mapped[gpuidx], last_index + 1, start_index) &lt;= last_index;</pre>
    </blockquote>
    thanks, it is better.<br>
    <blockquote type="cite" cite="mid:5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com">
      <pre>
 
</pre>
      <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">+		index = (off - prange-&gt;start) &gt;&gt; prange-&gt;granularity;
+		if (test_bit(index, prange-&gt;bitmap_mapped[gpuidx])) {
+			mapped = true;
+			break;
+		}
+	}
+out:
+	pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] mapped %d on gpu %d\n&quot;, prange,
+		 start, last, mapped, gpuidx);
+	return mapped;
+}
+
+static bool
+svm_range_partial_mapped(struct svm_range *prange, unsigned long start,
+			 unsigned long last)
+{
+	struct kfd_process *p = container_of(prange-&gt;svms, struct kfd_process, svms);
+	struct svm_range *pchild;
+	uint32_t gpuidx;
+
+	for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported, p-&gt;n_pdds) {
+		list_for_each_entry(pchild, &amp;prange-&gt;child_list, child_list) {
+			if (svm_range_partial_mapped_dev(gpuidx, pchild, start, last))
+				return true;
+		}
+
+		if (svm_range_partial_mapped_dev(gpuidx, prange, start, last))
+			return true;
+	}
+	return false;
+}
+
+static bool svm_range_is_mapped(struct svm_range *prange)
+{
+	return svm_range_partial_mapped(prange, prange-&gt;start, prange-&gt;last);
+}
+
+static void
+svm_range_update_mapped(uint32_t gpuidx, struct svm_range *prange,
+			unsigned long start, unsigned long last, bool mapped)
+{
+	unsigned long index, nbits;
+
+	index = (start - prange-&gt;start) &gt;&gt; prange-&gt;granularity;
+	nbits = svm_range_mapped_nbits(last - start + 1, prange-&gt;granularity);</pre>
      </blockquote>
      <p>This may be off by one if start and last are not aligned on
        granularity boundaries. I think you need to calculate the index
        for each of start and last and subtract the indices.<br>
      </p>
    </blockquote>
    yes, will correct it in function svm_range_mapped_nbits
    <blockquote type="cite" cite="mid:5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com">
      <p> </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap="">+	if (mapped)
+		bitmap_set(prange-&gt;bitmap_mapped[gpuidx], index, nbits);
+	else
+		bitmap_clear(prange-&gt;bitmap_mapped[gpuidx], index, nbits);
+	pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] update mapped %d nbits %ld gpu %d\n&quot;,
+		 prange, start, last, mapped, nbits, gpuidx);
+}
+
 static int
 svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			  unsigned long last, uint32_t trigger)
@@ -1321,29 +1459,28 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 	uint32_t gpuidx;
 	int r = 0;
 
-	if (!prange-&gt;mapped_to_gpu) {
-		pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] not mapped to GPU\n&quot;,
-			 prange, prange-&gt;start, prange-&gt;last);
-		return 0;
-	}
-
-	if (prange-&gt;start == start &amp;&amp; prange-&gt;last == last) {
-		pr_debug(&quot;unmap svms 0x%p prange 0x%p\n&quot;, prange-&gt;svms, prange);
-		prange-&gt;mapped_to_gpu = false;
-	}
-
 	bitmap_or(bitmap, prange-&gt;bitmap_access, prange-&gt;bitmap_aip,
 		  MAX_GPU_INSTANCE);
 	p = container_of(prange-&gt;svms, struct kfd_process, svms);
 
 	for_each_set_bit(gpuidx, bitmap, MAX_GPU_INSTANCE) {
-		pr_debug(&quot;unmap from gpu idx 0x%x\n&quot;, gpuidx);
 		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
 		if (!pdd) {
 			pr_debug(&quot;failed to find device idx %d\n&quot;, gpuidx);
-			return -EINVAL;
+			continue;
+		}
+
+		if (!svm_range_partial_mapped_dev(gpuidx, prange, start, last)) {
+			pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] not mapped on gpu %d\n&quot;,
+				 prange-&gt;svms, prange, start, last, gpuidx);
+			continue;
 		}
 
+		svm_range_update_mapped(gpuidx, prange, start, last, false);
+
+		pr_debug(&quot;unmap svms 0x%p prange 0x%p [0x%lx 0x%lx] from gpu %d\n&quot;,
+			 prange-&gt;svms, prange, start, last, gpuidx);
+
 		kfd_smi_event_unmap_from_gpu(pdd-&gt;dev, p-&gt;lead_thread-&gt;pid,
 					     start, last, trigger);
 
@@ -1483,6 +1620,10 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		if (r)
 			break;
 
+		if (!r)
+			svm_range_update_mapped(gpuidx, prange, prange-&gt;start + offset,
+						prange-&gt;start + offset + npages - 1, true);
+
 		if (fence) {
 			r = dma_fence_wait(fence, false);
 			dma_fence_put(fence);
@@ -1648,7 +1789,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 	if (bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE)) {
 		bitmap_copy(ctx-&gt;bitmap, prange-&gt;bitmap_access, MAX_GPU_INSTANCE);
-		if (!prange-&gt;mapped_to_gpu ||
+		if (!svm_range_is_mapped(prange) ||</pre>
      </blockquote>
      <p>I think this gives you the wrong answer. As I understand it,
        svm_range_is_mapped returns true, if any part of the range is
        currently mapped on any GPU. But you'd only want to skip
        validate_and_map is all of the range is currently mapped on the
        subset of GPUs you're interested in.<br>
      </p>
    </blockquote>
    Here is to skip update mapping if prange is NOT mapped or prange as
    no GPU access nor access-in-place attribute. if
    (!svm_range_is_mapped(prange)) means no any part of prange is mapped
    on any GPU, this is correct condition.<br>
    <blockquote type="cite" cite="mid:5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com">
      <p> </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap=""> 		    bitmap_empty(ctx-&gt;bitmap, MAX_GPU_INSTANCE)) {
 			r = 0;
 			goto free_ctx;
@@ -1729,9 +1870,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = svm_range_map_to_gpus(prange, offset, npages, readonly,
 						  ctx-&gt;bitmap, flush_tlb);
 
-		if (!r &amp;&amp; next == end)
-			prange-&gt;mapped_to_gpu = true;
-
 		svm_range_unlock(prange);
 
 		addr = next;
@@ -1900,10 +2038,10 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	if (!p-&gt;xnack_enabled ||
 	    (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) {
 		int evicted_ranges;
-		bool mapped = prange-&gt;mapped_to_gpu;
+		bool mapped = svm_range_is_mapped(prange);
 
 		list_for_each_entry(pchild, &amp;prange-&gt;child_list, child_list) {
-			if (!pchild-&gt;mapped_to_gpu)
+			if (!svm_range_is_mapped(pchild))
 				continue;
 			mapped = true;</pre>
      </blockquote>
      Doesn't svm_range_is_mapped already consider child ranges? So you
      don't need to set mapped here.<br>
    </blockquote>
    yes, this is duplicate checking, will remove it.<br>
    <blockquote type="cite" cite="mid:5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com">
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap=""> 			mutex_lock_nested(&amp;pchild-&gt;lock, 1);
@@ -1966,7 +2104,9 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 
 static struct svm_range *svm_range_clone(struct svm_range *old)
 {
+	struct kfd_process *p = container_of(old-&gt;svms, struct kfd_process, svms);
 	struct svm_range *new;
+	uint32_t gpuidx;
 
 	new = svm_range_new(old-&gt;svms, old-&gt;start, old-&gt;last, false);
 	if (!new)
@@ -1988,7 +2128,11 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
 	new-&gt;actual_loc = old-&gt;actual_loc;
 	new-&gt;granularity = old-&gt;granularity;
-	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
+	for_each_set_bit(gpuidx, p-&gt;svms.bitmap_supported, p-&gt;n_pdds) {
+		bitmap_copy(new-&gt;bitmap_mapped[gpuidx], old-&gt;bitmap_mapped[gpuidx],
+			    svm_range_mapped_nbits(new-&gt;last - new-&gt;start + 1,
+						   new-&gt;granularity));
+	};
 	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
 	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
 
@@ -2107,7 +2251,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 		next_start = min(node-&gt;last, last) + 1;
 
 		if (svm_range_is_same_attrs(p, prange, nattr, attrs) &amp;&amp;
-		    prange-&gt;mapped_to_gpu) {
+		    svm_range_is_mapped(prange)) {</pre>
      </blockquote>
      <p>This is probably wrong too. I think you need a check, whether a
        specific range is completely mapped on all GPUs that need
        access.<br>
      </p>
    </blockquote>
    <p>Will correct this retry handling, there is case that previous
      mapping may not finish on all GPUs completely.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:5c6431f8-a7ac-4646-b282-8054bd94fbe9@amd.com">
      <p> </p>
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20230929141115.10016-1-Philip.Yang@amd.com">
        <pre class="moz-quote-pre" wrap=""> 			/* nothing to do */
 		} else if (node-&gt;start &lt; start || node-&gt;last &gt; last) {
 			/* node intersects the update range and its attributes
@@ -3587,7 +3731,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 		if (migrated &amp;&amp; (!p-&gt;xnack_enabled ||
 		    (prange-&gt;flags &amp; KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &amp;&amp;
-		    prange-&gt;mapped_to_gpu) {
+		    svm_range_is_mapped(prange)) {
 			pr_debug(&quot;restore_work will update mappings of GPUs\n&quot;);
 			mutex_unlock(&amp;prange-&gt;migrate_mutex);
 			continue;
@@ -3598,7 +3742,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			continue;
 		}
 
-		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp; prange-&gt;mapped_to_gpu;
+		flush_tlb = !migrated &amp;&amp; update_mapping &amp;&amp; svm_range_is_mapped(prange);
 
 		r = svm_range_validate_and_map(mm, prange, MAX_GPU_INSTANCE,
 					       true, flush_tlb);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index d2e94d8fb4be..10c92c5e23a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -132,7 +132,7 @@ struct svm_range {
 	struct list_head		child_list;
 	DECLARE_BITMAP(bitmap_access, MAX_GPU_INSTANCE);
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
-	bool				mapped_to_gpu;
+	unsigned long			*bitmap_mapped[MAX_GPU_INSTANCE];
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
@@ -163,6 +163,8 @@ static inline struct svm_range_bo *svm_range_bo_ref(struct svm_range_bo *svm_bo)
 		return NULL;
 }
 
+#define svm_range_mapped_nbits(size, granularity) DIV_ROUND_UP((size), 1UL &lt;&lt; (granularity))
+
 int svm_range_list_init(struct kfd_process *p);
 void svm_range_list_fini(struct kfd_process *p);
 int svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>
