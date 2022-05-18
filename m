Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FB6C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 17:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD735113F3E;
	Wed, 18 May 2022 17:56:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8D97113F3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 17:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiCuYBvGIw5XROMGo+ofOYN4CZ1P8BCbF71Aj7xwYL3mYM135Zg88hN6avGG0p67fe5kH1JwoYGsHNDpIW7VUZThDAAIWATceZxUWxrmXZjbVRBUqEjRbIhMI9Sh+q76HzOkr79rbhQhEiNBAP5X+xhrokPgkVyh9ubEH9iGOB7KAWPKqRU8DbPrQaHWywcBoaAALCi/o2PH8BbSTHveHXBNrYV++Jn1yskN4HyTlxCCR4t5P/73X554ZxOo7fF+Ooylx5ETLzj6YXyeOOb62MY3242kvglR5eW0fg72VjPmaAVs2Wq77o9QhTqCGWjxXc66WNQeH9EtRzB2GE3mJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y07HY/bkiQULcc4f28Dmkhw+DCbLRDe8I6hBmX7oHEI=;
 b=Br6oOoX4v6XdauJGTpPsnECd7fNoNPJfwWdP3ww+tv6zhbfLuMeym9ZtzcnvJFW7z4GFVk7UH8+zjZnB1WrhBVzCS0IO/czIuyAfLRBMHTpErnjuvK/q158AQ4f5R4KbbLINqTTzANJ3WhaMKqAhWMh5Grys9nnfYKZS4ZJ7JDAk7t4NgXqnom5AoggiY2T7vST9Y0vgaSjRcnrHndC4+v0w7F9dsVYnebFXYjp2wo/O8F8I3iYX8nKNgp8fqh/FNaksCC3JlZ+KmjXm94c4PgekJ+7aPGL0SIx20kGvgsH8cppBldARSAuxMS201ZLOwRQnIunmcFAhYZRQ9O6DNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y07HY/bkiQULcc4f28Dmkhw+DCbLRDe8I6hBmX7oHEI=;
 b=VA6aWO0weGjxz27WQvD3zeAjI6DH2hkTlJMp75J9EMthyJM9d5A1vmVAo3MDI3Z8BvN/6jVvHwJMMZuehd4ZWnaUsPLDQhxHZPA4oOEwv7Mutv2ytat94CN6jUtKw4EojxaSFfGZjiNJWaTQQ26ITMbKhbcFtSNPpZcrinJlkNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 17:55:59 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%8]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 17:55:59 +0000
Message-ID: <1e136059-5e56-8709-c252-bee43dec2c1d@amd.com>
Date: Wed, 18 May 2022 13:55:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] drm/amdgpu: remove acc_size from reserve/unreserve mem
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220517231108.14048-1-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220517231108.14048-1-alex.sierra@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7275df0-79e6-465c-fb71-08da38f7aa35
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2680283A9899331A0F3DEA94E6D19@BYAPR12MB2680.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AivgnxXG8J1hzbjmtwEJHhISmfzrKK4vi69pXbP/ZGOzvaSrwXY8gROWVtkPnsAEKTiq2kKmI/XZj8d+Y4KEFU0hAoo7ofIxWR2s0GUuIBRPXko37JvfA3eSQyxj1ffWvmCRx6gK0Y3lGdPtlfvam0sHZGAN5Lee+YjUbIJNpv1wCS7t8yZEmnLxV5C1HRedJHORqnb2IG9muXVZkaH8hCd1uq1kJmOXsLUac/UDuFge8ZOJXE1Cng6BgHctsUDqk/8u0W+5JlzXfG3irawKjPXIDoSmTByUfg1Ajt6m8VMw0CTJrxFtKf8rlntzNxc/PY3A0NZnqPYi+vN3yf5GvVlo19YT2F+65upUWR14AlWdflYCSo4UzA55plt08yO21nTQ6ZRU3xMwTrcjd2zV2MzgoVGk4ZqCqNrOaoSdK5dxgPVbqT0IM+zmjxfqHtAtaeqIpGogQG7+Mk1CXNrRWS8m6gp2D1CfEUVqMTD4y+IqAuMX4LN5ARDi9AiqLlfZT57OhUfka9daHXYnSPRx2XE33vuPlkMPGQI/daPhLH1cX+LWMW6XW9/PusKdQ/lbrtlOu2YpiMF/5/EuVp8Iy4mYUrvsNIU9BqN5NjckhxWJzoQA2fMkfaEw7+SbE+puu2suHZYMw7aiq3H9fHtsSld/SwOFYf3nYSujCMwDJ6B4NXW/tHHzvS4W7X8vJgAEXFkdR3a8M3KvssAde4oAwbb4Cw9W3Xxw+OGZSAlApNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(66476007)(38100700002)(6486002)(316002)(8936002)(186003)(66946007)(53546011)(6506007)(5660300002)(508600001)(26005)(31686004)(2906002)(36756003)(83380400001)(66556008)(6512007)(8676002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZ3Um5QcUhjamtkV1YzQUVFWVJVb00waFdneHFiMCtsRWx2OTVxKzJYNG9s?=
 =?utf-8?B?R01CaDYweXBCZFJEQUE1MS9nN1M1dTRQQks3OW14ZFhWaXYvNmNzWmRaS0V6?=
 =?utf-8?B?V3Uxc2F5dkxLNmZWa1RNTG5hTE1wcTZ6S0t4bk1FaTNUSjh6TWdDQVFBeS9Q?=
 =?utf-8?B?Ky9PWFZseXcrRVJHRDg1VS9HejMrS1ovaWxFQy8wUFQ4NFFlS2tTN25FN3Zk?=
 =?utf-8?B?K0l0aGRPdFJhcUhCWXJoY3R6ZkI5Um95ODV0MXpPK2pQckVaanNhcTQ5YTU2?=
 =?utf-8?B?N29pWG0vVnN1NVZhNDVFQXZ5KzllK1c1RUJtUzl0RllNZ3I5WTRtV1IxZXRS?=
 =?utf-8?B?M0loSGFjQjdOWUVVbVMxQ0Iyd0d1N0NVazhTaWxKYUtwS01hVHpZZzlmcEdF?=
 =?utf-8?B?MDQrb0xJY0FtL203bGsxUUpqYTFScnpnc1FkT3ZKdjU2ZEZveEp6UjRJc0JK?=
 =?utf-8?B?NEN6T3FGWlpMOVZNSmRUaktySnBZbTZhbjVoNEVRTG96RldkSTdYbHVyblNS?=
 =?utf-8?B?SGhKN245dFhGY2pabFg5cjJ4dHlaNE5ibjloQ0FQZ2picmc3RmNvaUZBZ1g3?=
 =?utf-8?B?eFFBaUpKWFh3QllETXYwUzBmOUJDSi85QUZBZXRFM2gyaURHcDgyWVJMMGVa?=
 =?utf-8?B?Q0krazZXeVM5Yy9ta1RyOXZFN0ttUlJpS1hQYk1xbHcwZG1yMjFsOG5ZVXFD?=
 =?utf-8?B?MFVuek1DUFZiQm9lVmFLVmVvYXhEQ3hzRHVpd2FEYnBYcVJGMHB2UFNjVGtr?=
 =?utf-8?B?YnNQdkdUM1d3M1VSNTdDck5uTnJHV0N4QkVZYTYyUXFTV2NQMEh6OVR5L1BM?=
 =?utf-8?B?SGVPS0xSNUVldzljNEVMQ1N2UXdvc3dwNEFzSHpISlNQRCtzRnZVZ3Q2bWFP?=
 =?utf-8?B?WEJXVUUvcXZRVXJxZlFSK2JMc1IyUFVQY1YrRjlzYzNQZjlLT2UxRGNzeWRJ?=
 =?utf-8?B?OWExOUVaaEIvS3R1TEN4b1BlRy9ybFpUd2MzeEJwR2VZd2RodlV4dStMVnQ2?=
 =?utf-8?B?akxvenJacFJLVWpOcENBaWRNc2phbk9rZEp3L1FIZXQ0TzYwZ1YxVFlIeStm?=
 =?utf-8?B?azhkc21saVdmVlFHNzhaZ2VVSXVDZCs3SS80dlUyZDgrVWY0NElhMzU3amdh?=
 =?utf-8?B?b2Z6Z3JDeUEvV1RiUHVNU0c3QmFoQkhPNWxVMG9RQ0x2Umt5emROS2E2SERR?=
 =?utf-8?B?QXNxU2o2RURmM25JcnA0QnVhYXo2akxkWjBxc2dYeDkxc0NNT1pPbjJwTk4r?=
 =?utf-8?B?aTF6YXBNOWkrVFQ5cjZvK2lsWWRNNGZmdmltSk1KSk5qQTIyTzMrRmkrL0xO?=
 =?utf-8?B?WFRyUGE0QWRoOThTQjVBTXhvMllkTU9lOU9jdDhpS2c1YUd1QnVVUTFyUjJG?=
 =?utf-8?B?d2xmK2grRkkrVW1aajA2WDhCYUc5OFdscHNqV01GNTc5S3RsTm8yWHhWK3hC?=
 =?utf-8?B?d0pyTU1PRzMwWFRQRmQ0TkZGWkJYaWhGNkRsVS8rM1h5R0lFckEwbzBTZmVM?=
 =?utf-8?B?YjBWQ0hjbDhwNmZuUGFDUlN2N0RkQTVNVUZTU3dza1FaaUVuN3dPK3dmSjh0?=
 =?utf-8?B?RzNEbFBLK1E4Q3IxdVhLRmtGSE4zbnJlOG54SDhjSnNFd3B5VzlINW1hTVJo?=
 =?utf-8?B?NE1ybHNrbzlsMzF2YTBPVWlLdDRjWnlqYllkKzlhUkREOXVBY0lYZVgvVklr?=
 =?utf-8?B?RlFrMU5vSmhZcEhCdStiT3RlazNNQ1A0anY3LzNvTW82bXA0Zy9qd2gzY1U0?=
 =?utf-8?B?NktNMk5iVVRRemVuL3V5VXQxRzR1Y3ZXYWZ0Z2s0NEk4eElHa20zU01IMkFD?=
 =?utf-8?B?UkJCeFB1TDFjZFNFTWViTmdFYXVUMGtSeXBrU3FZSDVMMmpMWEt1Vlk1cEk1?=
 =?utf-8?B?SDRBdXUyaWY2S1BDckZBYUhJbStVaDhtT3N1TGlKdXgyL3NDOUdncmtUc1lO?=
 =?utf-8?B?cWJuZnNMd1hGZkF6cldNWnVoNTIvOTJMSHhsRGpwb1YxZUhFWWUzOTZxaU93?=
 =?utf-8?B?cUhjZzdFWDFvMVg0dkVIQTZzRDE4UGd6U3o4QngzbkUwVkE4dHdxQmp4cUtz?=
 =?utf-8?B?TXRETlNLdnJhU292dHoyUUlRb0dXdEo4MENRVmRnRXpOUEZWS1h5WWYwNW9z?=
 =?utf-8?B?TGdiZ1dlS2t1VE43cW1KRmFsM0V0ZVh2cUhoVzJ1dzl3QjBOS1UvVC9HWStH?=
 =?utf-8?B?a0ljcFBXVXhubGdWb0FHZCtVc25RenhtcnNYYlNBZytyOWF3M1didi9pK0I0?=
 =?utf-8?B?WjIyV1g5WmZOMEJIMDV3Q1lpdXFzOXhITmNyTm9qS2F2RFJJNitOWkRadk1N?=
 =?utf-8?B?RU52L09NZExBNlRrOGpZdWJnOEdzWi9ubnNWZ3AzTFplbEp5RXc5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7275df0-79e6-465c-fb71-08da38f7aa35
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 17:55:59.1963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbmSMwemeazjYKTSHUJLprRn0NXTTIH0Y6xGQBJEMkNOJlohIZtrBr4Dh0F4MRWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
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
    <div class="moz-cite-prefix">On 2022-05-17 19:11, Alex Sierra wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220517231108.14048-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">TTM used to track the &quot;acc_size&quot; of all BOs internally. We needed to
keep track of it in our memory reservation to avoid TTM running out
of memory in its own accounting. However, that &quot;acc_size&quot; accounting
has since been removed from TTM. Therefore we don't really need to
track it any more.
</pre>
    </blockquote>
    <p>acc_size is size of amdgpu_bo data structure plus size of pages
      array and dma_address array, it is needed for each BO, so should
      track as system_mem_needed. It can be removed from ttm_mem_needed
      as this is not allocated by TTM as GTT memory.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <p>
    </p>
    <blockquote type="cite" cite="mid:20220517231108.14048-1-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 57 ++++++-------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index fada3b149361..e985cf9c7ec0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -108,17 +108,8 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  * compromise that should work in most cases without reserving too
  * much memory for page tables unnecessarily (factor 16K, &gt;&gt; 14).
  */
-#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) &gt;&gt; 14)
-
-static size_t amdgpu_amdkfd_acc_size(uint64_t size)
-{
-	size &gt;&gt;= PAGE_SHIFT;
-	size *= sizeof(dma_addr_t) + sizeof(void *);
 
-	return __roundup_pow_of_two(sizeof(struct amdgpu_bo)) +
-		__roundup_pow_of_two(sizeof(struct ttm_tt)) +
-		PAGE_ALIGN(size);
-}
+#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) &gt;&gt; 14)
 
 /**
  * amdgpu_amdkfd_reserve_mem_limit() - Decrease available memory by size
@@ -136,28 +127,22 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 {
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
-	size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
+	size_t system_mem_needed, ttm_mem_needed, vram_needed;
 	int ret = 0;
 
-	acc_size = amdgpu_amdkfd_acc_size(size);
-
+	system_mem_needed = 0;
+	ttm_mem_needed = 0;
 	vram_needed = 0;
 	if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
-		system_mem_needed = acc_size + size;
-		ttm_mem_needed = acc_size + size;
+		system_mem_needed = size;
+		ttm_mem_needed = size;
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		system_mem_needed = acc_size;
-		ttm_mem_needed = acc_size;
 		vram_needed = size;
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
-		system_mem_needed = acc_size + size;
-		ttm_mem_needed = acc_size;
-	} else if (alloc_flag &amp;
-		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		system_mem_needed = acc_size;
-		ttm_mem_needed = acc_size;
-	} else {
+		system_mem_needed = size;
+	} else if (!(alloc_flag &amp;
+				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		pr_err(&quot;%s: Invalid BO type %#x\n&quot;, __func__, alloc_flag);
 		return -ENOMEM;
 	}
@@ -193,28 +178,18 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 static void unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
-	size_t acc_size;
-
-	acc_size = amdgpu_amdkfd_acc_size(size);
-
 	spin_lock(&amp;kfd_mem_limit.mem_limit_lock);
 
 	if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
-		kfd_mem_limit.system_mem_used -= (acc_size + size);
-		kfd_mem_limit.ttm_mem_used -= (acc_size + size);
+		kfd_mem_limit.system_mem_used -= size;
+		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		kfd_mem_limit.system_mem_used -= acc_size;
-		kfd_mem_limit.ttm_mem_used -= acc_size;
 		adev-&gt;kfd.vram_used -= size;
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
-		kfd_mem_limit.system_mem_used -= (acc_size + size);
-		kfd_mem_limit.ttm_mem_used -= acc_size;
-	} else if (alloc_flag &amp;
-		   (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
-		    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
-		kfd_mem_limit.system_mem_used -= acc_size;
-		kfd_mem_limit.ttm_mem_used -= acc_size;
-	} else {
+		kfd_mem_limit.system_mem_used -= size;
+	} else if (!(alloc_flag &amp;
+				(KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
+				 KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
 		pr_err(&quot;%s: Invalid BO type %#x\n&quot;, __func__, alloc_flag);
 		goto release;
 	}
</pre>
    </blockquote>
  </body>
</html>
