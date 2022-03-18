Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576F0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 15:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E544B10E260;
	Fri, 18 Mar 2022 15:45:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D44810E260
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 15:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdqNaRvF7/UJCkl4ETeljdwn0D3AZt+aTpro1v/a4DDAbLNi+fm9j17e7mz+wI4a/r7IBgIG8TleBk9tEb5ULUIIM6EIiQ4GdB/elz4WPun0Oiu+7R4DzYZLrVOR96XMoscB9vI/ro4+HlI8XHQH3q6OQO0KXMuV/xMEDgXG2H1OU25/CO3KOMu6Sr6iVlSfbMOGs1xBGZ9tinZfGQ7Zg8QoVxY4isbLlIOkz992OG5GSDipTthb8YPR/uTbSaGko543STYxdyIILG6RwgMvojPULVYruA/1WkiDivey4SGNY7M5Vv41xrW2qeyYxklD6UY2GbXCSX+hFsCJVAipGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t6pN9mrbr8Lc8UeMo5fY2+yxFbixWbx+HtuQoVBtcI=;
 b=GeeGcYijZc2qMGmEXwnjmuqOmsB7jputlMiCSkzbb57qxs9kS1RAGf3n/dKcT0t/yEdUT+kaqkyypRfEmAxAwIskPtQIbQshxGW48cApDIlZUGXcfnUEqKhU2opPDKoytzSp1HR9u1z+IEoS1PJ81YnG5qnWkXY/EkWkg8lxIwrMxmgPoJdCavsDvNaF8pckFe9eB5zqHZXpLvbDGZ7zEYqwIQYj6EKVaCqIG9vTMT82jiL1wIqh4BwkaRk5KBgpBBl4mC3Ci4Z8HLQsYLDQk4mKNwCfaA1642PE/grXIwSbgqLCorl4CF8I9uCdEp347ZvevDNPx4H3DwrcOK/rig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t6pN9mrbr8Lc8UeMo5fY2+yxFbixWbx+HtuQoVBtcI=;
 b=Elu5NrdQ4TM2j/WtEcl/3QfdJYfc+l3iKky9j/md9tCf1CRQdnvTswJpRgDwX5TzeFRiu6Ia28EUXvs5Uts/zYc5bQqi6eOfFyGB/xwLMPj+VGkJ5owNj0BOyTKIG6FzbiGC3AUwi61dleug7EEVfEG4QxD982DjtIa8fZXuXs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BN6PR1201MB0163.namprd12.prod.outlook.com (2603:10b6:405:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 15:45:34 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329%7]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 15:45:34 +0000
Subject: Re: [PATCH 4/7] drm/amdgpu: rework TLB flushing
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com
References: <20220317135044.2099-1-christian.koenig@amd.com>
 <20220317135044.2099-4-christian.koenig@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <3e23d276-d9fd-b9c2-cf23-572f4ede51a0@amd.com>
Date: Fri, 18 Mar 2022 11:45:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220317135044.2099-4-christian.koenig@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95bc08d5-8f8f-4b14-60cc-08da08f65719
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0163:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0163D6E5AB966513BEAD3791E6139@BN6PR1201MB0163.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCFN58M1phX785ziKAXVPw06yAwbjiEu7PYVEjB2SIg5qOdZLsqrb1lCDd0NCpg6y8c6hqxls8mleKQvfuPWrh0awWYsjlg1/j/8ejy0nsWtSZSD509Lv4TA2WF74Ld5hNz8unypxHD4KHTxUYuwVkPTREgUnVL26zVuTPscePFfT7+NAcaH2tCDJCxV0HisJnMWD2u4SVSnzz0dSvihui1rBawHegCBqlwwSA/OLqQrv48a3XW9uDPDrNUeEdzCqrPMk6JWvR2lpge2E61sFzlPikSluD5VVEIKXBz9huIkPR8myGTv0s5iztUR85jl7mBserFHTEbGQ4QFEltS0JsNnAJ+v2ypj3eiq63UPT6GgazXQSLR+s1O25Mo3R7VBmaJdCTfHat6upzp2Qc71VDB7UcWrfLy5IW14rKEjFEmv/IcmGlpy7bBBLQuSEy5NRSo97e6/jyH9crSBSfzH/92XRY6nwqZ3NBIofYY430qlb3xsiRxP6Egq8Zb5OjI+syABCFKMbC3NiGrPun0weczTn95aRcwNpRYlrW0il6g6F3m4W81OPGonre1nYnsy1pNA4/rwmis32d59HncrAJ4POvRM1RLBXyqeOx7SCWtV4t8tukxZqLTRkLOUKno0r4WJsYbQTTKkKCYS+up7CDuoB48L+AUc8nwevpCDec5Zi+AkccS5tc64G2A03Fv7FnVMJrvop025FNuKuGcqf3KnYj7K2PjHlPidO1MKkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(53546011)(316002)(6486002)(6506007)(8676002)(4326008)(36756003)(31696002)(2906002)(66476007)(66556008)(66946007)(31686004)(5660300002)(38100700002)(8936002)(508600001)(6512007)(2616005)(26005)(186003)(6636002)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3pWcDBJWTRvSjhJVXhON290T2wrSE1oRUUyNjhLejU1NnkzeG9oNnQyd0Jm?=
 =?utf-8?B?a2ZoaVFwWDMvbFFjUXpZQktuRVFMRzk5QU9ibVNhWi9taGZsMkxwb29WaS9Q?=
 =?utf-8?B?RGxiV0lrTHBGcVp3WTFTQ3hwWlRjSjUwWmxOcWxUUmplWFhLcm9GSjZmMG80?=
 =?utf-8?B?dmc5Y2YybDZYY1hDOElSNG4rc3J6cHZKaWJiZVJmR0txenlXd0xtUjRRNjV4?=
 =?utf-8?B?cjM0RkFKZi9Oa3lXU0x0WkUwbjdMSEhuQjZna0JmSGZzOHYvcjQ1SGg3OFkx?=
 =?utf-8?B?Y0x2MmVBWmJpREphSm9HSW5YbW5MVkpXVWE4YlJ1aWkyUHR2ZWxrMGVDNFc3?=
 =?utf-8?B?ejhXT1VDbXF5MVlxanNZS09CUnFOMVFMSVd4OFNXR3hjZlRrR2hyTzJzVEtH?=
 =?utf-8?B?eFdJOEhRTEJkRVhvLzN5b24zck42QXVKWkg1MnIvVWU1YzNKV0NiRlpjR0RZ?=
 =?utf-8?B?cTBjak03d0dCQmsxR3Z6cEUxU3pHVkNndjlZMTVveWVKekhyeDdya0FveWVN?=
 =?utf-8?B?VnN6c3FpRjNLY09EV3dqVGpzMVFVWWZVR1dWY0M1dXpXK0hiMjFyMnoreGNo?=
 =?utf-8?B?R2dUSEc2WHkzYjJFU0hMQ09uOVY1cnp4ZTdoeDFHOW1KaXgwWm1LWFozRUNx?=
 =?utf-8?B?YjdmZUV0aGZGaCtNV21jVG8vdDQrTEczZmZDd3AxTzRKSTZ1eTZIMVAxQTRF?=
 =?utf-8?B?ZUtzMGl5Mk9MYnlDcGdTNFEyRzRzSzRSYXRER1pWeGlzQUR4OEJhZDFyaGJI?=
 =?utf-8?B?eEZHRGs3ckJlUGJBSVpKU2ZkeU9RUldHWVh4eFg2OU5JYzlXL2wvY2tWQ0ov?=
 =?utf-8?B?TDdrTERjejh4Q3VCcHNmSmt1NnlpZEdrbTZhbDd2cVBkbHpOak5CMDArRmJy?=
 =?utf-8?B?UFlpc0tNSEgyVjVvU0VBSExyWXFHaHhFUGJGRWNlclZmS3NxT01DVGowalRh?=
 =?utf-8?B?TGQ2SkRpR1BIeE9FZTFTWXJsazR4c3JFQW1JRllDWDFDZVN3bXBRYytqalR0?=
 =?utf-8?B?anRTMk0yYVJ3UFk0Tkc3bStFUVFyN3RjUmREQTBkRUl5WU9GWXVucjF1eEVv?=
 =?utf-8?B?ZG1WNVgvcWNieDY0Rk1JSUlhaFo3UmE2OWJuM1IyL3UzdHAwVC94TWs2Ymgw?=
 =?utf-8?B?YWg3UkhNSUhJRTVaNDVXQkpyV1VJUmRxWmFUbDJXdmFuWG85Tk1CSzJDOGlG?=
 =?utf-8?B?bWdwV3VxOHRVdzZVVjZvUVEzZG1iblVXMlkrTTk1TE1LWWp6ZG1Jb2lXaHdx?=
 =?utf-8?B?QVhtTnMwQ3g2Z2FYbTQ0eXFpTzgxbWN5YTQzOEFFTTJLTFA1Sm1jVGM1ckxq?=
 =?utf-8?B?QjBpRTlNSFlJZ3FTOXpwakdRUmJUL2hnN0cxdnNOZW9TUjBTQjZ6L3pWK09x?=
 =?utf-8?B?VkM1dEg0b2pUWEZPZGcvUXlMV3FCcHQ5SUtyUUlCRUdIa2hKa0I0SmhYQ01k?=
 =?utf-8?B?VyszajV4YTVTN1BGWXREVitQaXNoeWFQMU1qMC9UUStBUE5lNDUzaW92a2tr?=
 =?utf-8?B?TGF4SjFub3duUUtsejlsYTlmREtjT1RNUXVaVjRuU1dBTTZtUWxUeFRscUx6?=
 =?utf-8?B?WDg3b2NkaG90clJoRk9oVHVDMG8vZTBxdTN0VllnOXV5cVVRdFZONTdNaGth?=
 =?utf-8?B?TzVVUTdUNDBVbGlIRFFPWmVNYmRxeHczeXkwTkUrWnErUUUwTFdSM3VKR2JH?=
 =?utf-8?B?QmtZakR2eEExcjVnbmhaeVJSSXFrR2F5eCtyUHZFMzVqcDFweW1YSFFqWTh0?=
 =?utf-8?B?cS92QUNodGJMcHVheHl1Y3NYdnN4bWNTaGhZRkxQSFl6WDcxZWJ5a1p0aXUr?=
 =?utf-8?B?QVJlYy9QR05rczlJdVRZMS9GMlZxVEp1VmwrSGFTdHpBYXlhb0c0dGN6VGdS?=
 =?utf-8?B?T2R3ejRlMVhjMHNKM25tVXVlQk9lejhHS1dHdDgwTExLRElselhUWE1VNFJm?=
 =?utf-8?Q?NksFVm2HQ8rja4z4bCw7cw6QcrMAOl4m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bc08d5-8f8f-4b14-60cc-08da08f65719
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 15:45:34.5416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXeLInqY09hMqO9v/XivHilff63owDZPmANkJVZUEEyVgtcicxQx3diAwOgv3+N6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0163
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-17 9:50 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220317135044.2099-4-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">Instead of tracking the VM updates through the dependencies just use a
sequence counter for page table updates which indicates the need to
flush the TLB.

This reduces the need to flush the TLB drastically.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 20 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 56 ++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 15 +++++++
 6 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e8a3078a85cc..2d4a89fb264e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -810,7 +810,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_vm_fence(&amp;p-&gt;job-&gt;sync, fpriv-&gt;prt_va-&gt;last_pt_update);
+	r = amdgpu_sync_fence(&amp;p-&gt;job-&gt;sync, fpriv-&gt;prt_va-&gt;last_pt_update);
 	if (r)
 		return r;
 
@@ -821,7 +821,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_vm_fence(&amp;p-&gt;job-&gt;sync, bo_va-&gt;last_pt_update);
+		r = amdgpu_sync_fence(&amp;p-&gt;job-&gt;sync, bo_va-&gt;last_pt_update);
 		if (r)
 			return r;
 	}
@@ -840,7 +840,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_vm_fence(&amp;p-&gt;job-&gt;sync, bo_va-&gt;last_pt_update);
+		r = amdgpu_sync_fence(&amp;p-&gt;job-&gt;sync, bo_va-&gt;last_pt_update);
 		if (r)
 			return r;
 	}
@@ -853,7 +853,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_vm_fence(&amp;p-&gt;job-&gt;sync, vm-&gt;last_update);
+	r = amdgpu_sync_fence(&amp;p-&gt;job-&gt;sync, vm-&gt;last_update);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index b05c5fcb168d..93be290fc327 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -277,7 +277,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	unsigned vmhub = ring-&gt;funcs-&gt;vmhub;
 	uint64_t fence_context = adev-&gt;fence_context + ring-&gt;idx;
 	bool needs_flush = vm-&gt;use_cpu_for_update;
-	uint64_t updates = sync-&gt;last_vm_update;
+	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
 	*id = vm-&gt;reserved_vmid[vmhub];
@@ -338,7 +338,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	unsigned vmhub = ring-&gt;funcs-&gt;vmhub;
 	struct amdgpu_vmid_mgr *id_mgr = &amp;adev-&gt;vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev-&gt;fence_context + ring-&gt;idx;
-	uint64_t updates = sync-&gt;last_vm_update;
+	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
 	job-&gt;vm_needs_flush = vm-&gt;use_cpu_for_update;
@@ -426,7 +426,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			if (r)
 				goto error;
 
-			id-&gt;flushed_updates = sync-&gt;last_vm_update;
+			id-&gt;flushed_updates = amdgpu_vm_tlb_seq(vm);
 			job-&gt;vm_needs_flush = true;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index bc5ab44c5830..ff9229819b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -51,7 +51,6 @@ static struct kmem_cache *amdgpu_sync_slab;
 void amdgpu_sync_create(struct amdgpu_sync *sync)
 {
 	hash_init(sync-&gt;fences);
-	sync-&gt;last_vm_update = 0;
 }
 
 /**
@@ -171,23 +170,6 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f)
 	return 0;
 }
 
-/**
- * amdgpu_sync_vm_fence - remember to sync to this VM fence
- *
- * @sync: sync object to add fence to
- * @fence: the VM fence to add
- *
- * Add the fence to the sync object and remember it as VM update.
- */
-int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence *fence)
-{
-	if (!fence)
-		return 0;
-
-	sync-&gt;last_vm_update = max(sync-&gt;last_vm_update, fence-&gt;seqno);
-	return amdgpu_sync_fence(sync, fence);
-}
-
 /* Determine based on the owner and mode if we should sync to a fence or not */
 static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 				   enum amdgpu_sync_mode mode,
@@ -377,8 +359,6 @@ int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone)
 		}
 	}
 
-	clone-&gt;last_vm_update = source-&gt;last_vm_update;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index 876c1ee8869c..2d5c613cda10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -43,12 +43,10 @@ enum amdgpu_sync_mode {
  */
 struct amdgpu_sync {
 	DECLARE_HASHTABLE(fences, 4);
-	uint64_t	last_vm_update;
 };
 
 void amdgpu_sync_create(struct amdgpu_sync *sync);
 int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f);
-int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence *fence);
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
 		     void *owner);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index accebbac2f29..a43302a86254 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -88,6 +88,21 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+/**
+ * amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
+ */
+struct amdgpu_vm_tlb_seq_cb {
+	/**
+	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
+	 */
+	struct amdgpu_vm *vm;
+
+	/**
+	 * @cb: callback
+	 */
+	struct dma_fence_cb cb;
+};
+
 /**
  * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
  *
@@ -760,6 +775,23 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
+ * @fence: unused
+ * @cb: the callback structure
+ *
+ * Increments the tlb sequence to make sure that future CS execute a VM flush.
+ */
+static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
+				 struct dma_fence_cb *cb)
+{
+	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
+
+	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
+	atomic64_inc(&amp;tlb_cb-&gt;vm-&gt;tlb_seq);
+	kfree(tlb_cb);
+}
+
 /**
  * amdgpu_vm_bo_update_mapping - update a mapping in the vm page table
  *
@@ -795,6 +827,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				bool *table_freed)
 {
 	struct amdgpu_vm_update_params params;
+	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
 	struct amdgpu_res_cursor cursor;
 	enum amdgpu_sync_mode sync_mode;
 	int r, idx;
@@ -802,6 +835,12 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	if (!drm_dev_enter(adev_to_drm(adev), &amp;idx))
 		return -ENODEV;
 
+	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
+	if (!tlb_cb) {
+		r = -ENOMEM;
+		goto error_unlock;
+	}
+
 	memset(&amp;params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
@@ -820,7 +859,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	amdgpu_vm_eviction_lock(vm);
 	if (vm-&gt;evicting) {
 		r = -EBUSY;
-		goto error_unlock;
+		goto error_free;
 	}
 
 	if (!unlocked &amp;&amp; !dma_fence_is_signaled(vm-&gt;last_unlocked)) {
@@ -833,7 +872,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm-&gt;update_funcs-&gt;prepare(&amp;params, resv, sync_mode);
 	if (r)
-		goto error_unlock;
+		goto error_free;
 
 	amdgpu_res_first(pages_addr ? NULL : res, offset,
 			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &amp;cursor);
@@ -882,7 +921,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 		tmp = start + num_entries;
 		r = amdgpu_vm_ptes_update(&amp;params, start, tmp, addr, flags);
 		if (r)
-			goto error_unlock;
+			goto error_free;
 
 		amdgpu_res_next(&amp;cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start = tmp;
@@ -890,9 +929,20 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm-&gt;update_funcs-&gt;commit(&amp;params, fence);
 
+	if (!unlocked &amp;&amp; (!(flags &amp; AMDGPU_PTE_VALID) || params.table_freed)) {
+		tlb_cb-&gt;vm = vm;
+		if (!*fence || dma_fence_add_callback(*fence, &amp;tlb_cb-&gt;cb,
+						      amdgpu_vm_tlb_seq_cb))
+			amdgpu_vm_tlb_seq_cb(*fence, &amp;tlb_cb-&gt;cb);
+		tlb_cb = NULL;
+	}
+</pre>
    </blockquote>
    <p>Should move fence_add_callback before calling
      vm-&gt;update_funcs-&gt;commit?</p>
    <p>With this fixed, patches 5-7 are Reviewed-by: Philip
      Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a></p>
    <p>Need another patch to fix svm_range_map_to_gpu, remove local
      variable table_freed and call kfd_flush_tlb after waiting for
      update fence done.</p>
    <blockquote type="cite" cite="mid:20220317135044.2099-4-christian.koenig@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	if (table_freed)
 		*table_freed = *table_freed || params.table_freed;
 
+error_free:
+	kfree(tlb_cb);
+
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 1731681914f5..38a1eab1ff74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -284,6 +284,9 @@ struct amdgpu_vm {
 	struct drm_sched_entity	immediate;
 	struct drm_sched_entity	delayed;
 
+	/* Last finished delayed update */
+	atomic64_t		tlb_seq;
+
 	/* Last unlocked submission to the scheduler entities */
 	struct dma_fence	*last_unlocked;
 
@@ -478,4 +481,16 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
 #endif
 
+/**
+ * amdgpu_vm_tlb_seq - return tlb flush sequence number
+ * @vm: the amdgpu_vm structure to query
+ *
+ * Returns the tlb flush sequence number which indicates that the VM TLBs needs
+ * to be invalidated whenever the sequence number change.
+ */
+static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
+{
+	return atomic64_read(&amp;vm-&gt;tlb_seq);
+}
+
 #endif
</pre>
    </blockquote>
  </body>
</html>
