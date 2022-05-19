Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 19:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EA811A7F0;
	Thu, 19 May 2022 19:07:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7700F11A7F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 19:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYE8LnLtoMYhfz0P+Y5YAbdbtpHLQOCcPYgNg0E6mmyW76lFbMd1s+h/iB6O+mlFnSopS541rdAEpiRN/8TeMYg+isZLaqTk9fJNkJTxb3qhUXVSPVQWe3xlBM4hMlwYGwyaSdSnpdeaQPzMu2BIxzqivrdKhMKNyMKOjBafm9akEjyg+C4yFvHxNtBEwwO5wx58IJB5f5F08qkx7h954CarDIMJCAPhXG4CJvlYHuXP60ysfmA585Ugc6NkYeEOnpevZVKN9zpbQ5zh5FR0bB5bL5NjZer3BXJHpjYam2rvFXENGdNW0pimmCo4xnxoKB1gfBmhm4HTKq+omIgLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YcGw294YIDmmJ6czE6w61WZ3cHe04EwcHBuXEOuNTY=;
 b=XdmbKoYv8mzkgEXra5UnoQMzHe+298eCxhtZ1l6/c6L8Qds6zSPcBbAHX/69Wt39KgSLZwV5KwkQDzKrc6LYYpmU2UEbXLylc7+vzVHml3MJuXd/iytM0ylLATq1tyCTyA0TsAZswVMUksjwHtUX4h0AuGSY0+ZrSlPxbHPH4GNl7gHbeU0YuwMQB1L1y347W6GnD1j+zkflMfAwKVS41LmvFNDSLYNBjhbpNMAk2Wu/vejJeBgZohyuK9eqZ2tI9E4xiFAzNwby+Qavjw/TApaZ7VvQbrb5KFH6f2l3LP5ks/95/mxOgSphSMFG/DXut9Zv4LriND9T5olXn40lRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YcGw294YIDmmJ6czE6w61WZ3cHe04EwcHBuXEOuNTY=;
 b=bJSwDwwAz9HmJWeUmlzYdHRfll472SDpgKKnQeGTGSwSCEEkCUjJQS/sLoP2qoI/1mJaP2Zkdi4QjK+/WoWsfB6x3u38oqH9eBc0Mjo9VLI4CfoaYtOSWtUeR63X7cLh4oq/E8LmFuAoUh6iML8l2TqWYCuhMR1DYK1YKmnu9E0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4582.namprd12.prod.outlook.com (2603:10b6:208:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 19:07:49 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%8]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 19:07:49 +0000
Message-ID: <cfedc739-8a80-49eb-42c2-990cb3d8e51a@amd.com>
Date: Thu, 19 May 2022 15:07:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220519162153.6268-1-alex.sierra@amd.com>
 <20220519162153.6268-2-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220519162153.6268-2-alex.sierra@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0059.prod.exchangelabs.com
 (2603:10b6:208:25::36) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b8180a4-1e7f-48a8-8cb4-08da39caddb8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4582:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4582ADD0CE29CDA1C7F40AA3E6D09@MN2PR12MB4582.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FocdF02RjxJNO/ODGpV/bHzl3PUnClwGKGaz0j387DQ+hiPMjVxbLIR9+3i7YlEnmsXaHFZlZjP2Vo+b6hrXbNdRQ//wvon30dAc8vL5g6LMUn95+T9qJo8vvrns2nxu8DnHgypmIbCWm9ICMJq+PVzAskMQqPU0I6rF9Me5FqhbzxS72wONomCenjQUsMUZTe511jwGctrMKj1N4zHtMGvrR1JCFCARUKS5fCNRljlhdxJSyzdhJBJ7auCWMw8CS0DLv46Z6uCLZv+RRBLW5kryPWd1/9xRLlqcTl9xwzQ0lW3p8hwu0kDO2vyCYaY47pHqvvIEVzDUbuzwPwE98sBHTbjdx+oXTSiCX53pj+F3VYSewk/DDSKhctZvsTGNQ2mP4ARqtTdFyPgs/+9wzCPqOvCi/vaDydr8TMWD+xx1pHQPAMks96Ngu3Yty0LXdL6VlW1WY/0ePpYsr3KyLsD5Jrp90O5Csnouq9UnUDAnoAizt0of30rNqim8jeP14+DiXqMCV6m+aSQhQKHMfDSXDdjQuu2tJrEpq1CtjudME4TaMnEEh6i6+PuPXZVRAAW860IYAqcKHZ4JJ7/SMRJM/f6NdB6AaCU9iHeNsHcjxQOWIpfLCLPB9hcIGBaKU3SaHE5iCaqIcitugz7bvsepFU/8qpP9e7fIrgbg15BTu351VDlIJzlNURlvGzVXB9wqEILa20NpciFX6IfCmzsACEBfoJJ6Qy2glBB457I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(83380400001)(186003)(38100700002)(5660300002)(8936002)(2906002)(66556008)(8676002)(508600001)(26005)(6512007)(53546011)(6506007)(316002)(66946007)(66476007)(6486002)(31686004)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzZzQkZ5d2JzUGllZENPWU5kMU0wbkxLSlFCWFkwa2EraGZjbUtlZXQ2b25y?=
 =?utf-8?B?WTNQM2RFc05pbU9BRjA4NWQwN3M4dzdRdFFaem1scmhSM0c4KzJKbjVXSXdI?=
 =?utf-8?B?a0JxWVUzMDIzbnU0bUpFMTFNcEpLV1pkQkxka2MzVDBFTnQxbjNmbllOMFNI?=
 =?utf-8?B?bEJrSEhsYVRVcWlBYTRWNDdhekpSTlh3SGN1NC9ybTYvWDl2bG5oTkEzQ0ZZ?=
 =?utf-8?B?VWN0dWM3NHNOZWlCUzNUaW9YTWdnYzNOTzhQZzBtZldNWDl2OVVWd3B0ZHZX?=
 =?utf-8?B?cnpKZXpLdmZHb2E2SVRkYXZ5R3NBL2RQcEJVSGdIZlhvT2VGUm52SXpKT2Ry?=
 =?utf-8?B?SmErb3lROU15WEYwNC9UMlU1YVB5cml3Tzdoa1I2UkpnNmVtZnJWVm9xRTVz?=
 =?utf-8?B?eThhTzhsVGhuWEJvdU9BMXBoQVgzd01mVjVJU2EvbFZaNlVRc1prR0Q1OXRT?=
 =?utf-8?B?YWNLVlhva2JDbXJFZ0ZiSXRjbE1QY2hCV1JVLy9nczJDNUNMbkJSbkd4Mytk?=
 =?utf-8?B?c04xNmc4V0JIbGQyZlNkemN2U1JvR2Z1YVdrL1F0NFo1VWVyVjVJMnZIblg4?=
 =?utf-8?B?eXh2NStLQkg0L2N5UDBCTm5NK1llbExXS1ZTYUNtM2Q0WkF3T3RVVGZIS0RR?=
 =?utf-8?B?S1plOVMrcXVlYWpkQnlCUU9kNFdRQW5hUlJBbU5wRzRlc25yUjFBVjdXY0kw?=
 =?utf-8?B?L0JFbVpLbENZdHN4ODdxUnVzR1ZKeVQvMWdvNDhJazJXQURGQks1UmhZRlNP?=
 =?utf-8?B?RXUzYTkwU05xYmZYZzN1S2t1YlYwa1JoWUNlSUxCRTFkRVV0NVp4L3o2YmRM?=
 =?utf-8?B?bUlxWmlpeUpkMXg4bDlRQTNtd0kvcG05Sk9QYmZMTXRUYTA1V1MySG9CN3dy?=
 =?utf-8?B?NEJDVnlOOXV1SkI4ei9saXdTRmZTaE5RK1RVQmNrOUxPbkNkWGVnUno3cmNz?=
 =?utf-8?B?TU9KV041aFRCbEtiOEhveFpCNklWZ0ROQUY4QllLbWhrQU9hZ2pQSGFqY3VQ?=
 =?utf-8?B?Q0tRM21hZ0VDZysrWks2MEdJWmR5dkZnTVF2RDRSVi80dFFIZ3BBa3NaQVdl?=
 =?utf-8?B?bit2d2I0NFFDaG41V0lMNWY1MXJTLzV4NlZRbW9pVk9xdjRWR1hEYlkvWE8r?=
 =?utf-8?B?TlpLTWo4d2pWOU51VTYvbnEzVDIwcmNZbHVZd09KNE9jMFMxNldjbGZaK2FH?=
 =?utf-8?B?WmdVWVM4SlJ0ZXZqNW9Mekt4M1E5dFpneG9nVlZnK1JkWElUOG5GMnRSeGh0?=
 =?utf-8?B?aHhoSVJOTkdKa3JCVGRWSnR0S0RYNG5ERGdhV2F1RmZjdTVrR3p5eGNvWGN2?=
 =?utf-8?B?S1B1OWw2ZVJ3UzdYRUZpQmU1VjhaWWFIVTZQTW9va2M4b1RvUVhqcUhDcDVZ?=
 =?utf-8?B?Ri95Kzd5Y3YvVXNpTHJNRGdQaG5JbDU0TFNwOGVVVFBjK1JFYkFHVHJwV3lD?=
 =?utf-8?B?bDlqb1YxZ2ZtQnRBajV5QzBHbGJxOUYvOUVaQVY5cmRYeFd5ZzlxZVR1bHVz?=
 =?utf-8?B?UE9JU3hJTjZUdTdpNDRpd1FHam1xM1ZhSnZPS3puT1RlOWhDazF6V1NPMEFt?=
 =?utf-8?B?a2pjV1NzUDc5UHQ4N2Fhc0s1RGJFRm0xMmZLMTNZNys2VW9lNlBhVHFodVZk?=
 =?utf-8?B?c2crdzNBdmprQlQrcXVsenRhYUZ4N3dKR3F3bW9aZWdhaFh4bFNXOW1oQnVV?=
 =?utf-8?B?aXlKTmlNbG9QTERYM2VhRVFPckxYUzZlTXExbTl2SmEzNFk4RHpNSkhrZFg3?=
 =?utf-8?B?SjkwWHJNRzVUNUJQREhlNjNMSTJYQUlJaEc5RE1BbjJKek90YzVoSlRoam90?=
 =?utf-8?B?ZTBRUmVhUEVnUUtKS3MyaS9ReW8vcFJqYWxDbGVFTlFPZUh4QnFzaGFpVVFZ?=
 =?utf-8?B?dGw1UkxHNWZBWEI0cmFZekdJb0xYTThuM3VKWFJlazJHL09Ud0NTdzgyckFh?=
 =?utf-8?B?Z1pzR1lVNjJJa2VlTVNKaDEwY2VSYktsdjRPVGdXd0xFZklmNFpUK2RLVTJt?=
 =?utf-8?B?eU5YMHg4L0NQeFN5a0V0NHUzbjFXNGYvdnN6OFUyNkVJdGFPSUFkUlRaME9Z?=
 =?utf-8?B?cmFlMTFoSEdRT09GUFBlcjU5ZG5PbFh3YkZ4WGYwUzdFK1NwQkhPYnF5Ri9K?=
 =?utf-8?B?V25PZGYzSHJaNjdTZHFyQzhxL2ZkeFlYOUl3Vk9HN0hpQ2RxdWdJbHhLN2Fx?=
 =?utf-8?B?cmwwRStaMXRZS2loMDFtL3F3SGtEMVRkZW5IWjAzNjdmaTBXSzd6U3ZabXpm?=
 =?utf-8?B?cFFWbWtzdWt6NThGMnBPK3d2d1RuaUkxSUV6K3kzeUlIR2pFUU5FTGxvZjV2?=
 =?utf-8?B?SjU1WlIvaHlVbzgydk90S0Z2TEdoN0JUMEpjS0tWcGtmOE5NOU83QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8180a4-1e7f-48a8-8cb4-08da39caddb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 19:07:49.3788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aux20kD47sd7YKHel+Sj68V0mRqCqvElgUVRmJ5kSntDgs0JrRsoVqfVgJ0pXDwm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4582
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
    <div class="moz-cite-prefix">On 2022-05-19 12:21, Alex Sierra wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220519162153.6268-2-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">[WHY]
Unified memory with xnack off should be tracked, as userptr mappings
and legacy allocations do. To avoid oversuscribe system memory when
xnack off.
[How]
Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
API and call them on every prange creation and free.

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20220519162153.6268-2-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 24 +++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 34 ++++++++++++++-----
 3 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..f55f34af6480 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -301,6 +301,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
 void amdgpu_amdkfd_block_mmu_notifications(void *p);
 int amdgpu_amdkfd_criu_resume(void *p);
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev);
+int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
+		uint64_t size, u32 alloc_flag);
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
+		uint64_t size, u32 alloc_flag);
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 966714dd764b..615e2b34fe12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -122,7 +122,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  *
  * Return: returns -ENOMEM in case of error, ZERO otherwise
  */
-static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
+int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	uint64_t reserved_for_pt =
@@ -157,8 +157,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	     kfd_mem_limit.max_system_mem_limit &amp;&amp; !no_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed &gt;
 	     kfd_mem_limit.max_ttm_mem_limit) ||
-	    (adev-&gt;kfd.vram_used + vram_needed &gt;
-	     adev-&gt;gmc.real_vram_size - reserved_for_pt)) {
+	    (adev &amp;&amp; (adev-&gt;kfd.vram_used + vram_needed &gt;
+	     adev-&gt;gmc.real_vram_size - reserved_for_pt))) {
 		ret = -ENOMEM;
 		goto release;
 	}
@@ -166,7 +166,8 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	/* Update memory accounting by decreasing available system
 	 * memory, TTM memory and GPU memory as computed above
 	 */
-	adev-&gt;kfd.vram_used += vram_needed;
+	if (adev)
+		adev-&gt;kfd.vram_used += vram_needed;
 	kfd_mem_limit.system_mem_used += system_mem_needed;
 	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
 
@@ -175,7 +176,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void unreserve_mem_limit(struct amdgpu_device *adev,
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	spin_lock(&amp;kfd_mem_limit.mem_limit_lock);
@@ -184,7 +185,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		kfd_mem_limit.system_mem_used -= size;
 		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		adev-&gt;kfd.vram_used -= size;
+		if (adev)
+			adev-&gt;kfd.vram_used -= size;
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
 	} else if (!(alloc_flag &amp;
@@ -193,9 +195,9 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		pr_err(&quot;%s: Invalid BO type %#x\n&quot;, __func__, alloc_flag);
 		goto release;
 	}
-
-	WARN_ONCE(adev-&gt;kfd.vram_used &lt; 0,
-		  &quot;KFD VRAM memory accounting unbalanced&quot;);
+	if (adev)
+		WARN_ONCE(adev-&gt;kfd.vram_used &lt; 0,
+			&quot;KFD VRAM memory accounting unbalanced&quot;);
 	WARN_ONCE(kfd_mem_limit.ttm_mem_used &lt; 0,
 		  &quot;KFD TTM memory accounting unbalanced&quot;);
 	WARN_ONCE(kfd_mem_limit.system_mem_used &lt; 0,
@@ -211,7 +213,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo-&gt;kfd_bo-&gt;alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	unreserve_mem_limit(adev, size, alloc_flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo-&gt;kfd_bo);
 }
@@ -1601,7 +1603,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&amp;(*mem)-&gt;lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 835b5187f0b8..1380c2fee0dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -261,11 +261,21 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
 
 static void svm_range_free(struct svm_range *prange)
 {
+	uint64_t size = (prange-&gt;last - prange-&gt;start + 1) &lt;&lt; PAGE_SHIFT;
+	struct kfd_process *p;
+
 	pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms, prange,
 		 prange-&gt;start, prange-&gt;last);
 
 	svm_range_vram_node_free(prange);
 	svm_range_free_dma_mappings(prange);
+
+	p = container_of(prange-&gt;svms, struct kfd_process, svms);
+	if (!p-&gt;xnack_enabled) {
+		pr_debug(&quot;unreserve mem limit: %lld\n&quot;, size);
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	}
 	mutex_destroy(&amp;prange-&gt;lock);
 	mutex_destroy(&amp;prange-&gt;migrate_mutex);
 	kfree(prange);
@@ -284,7 +294,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
 
 static struct
 svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
-			 uint64_t last)
+			 uint64_t last, bool is_new_alloc)
 {
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
@@ -293,6 +303,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	prange = kzalloc(sizeof(*prange), GFP_KERNEL);
 	if (!prange)
 		return NULL;
+
+	p = container_of(svms, struct kfd_process, svms);
+	if (!p-&gt;xnack_enabled &amp;&amp; is_new_alloc &amp;&amp;
+	    amdgpu_amdkfd_reserve_mem_limit(NULL, size &lt;&lt; PAGE_SHIFT,
+					    KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+		pr_info(&quot;SVM mapping failed, exceeds resident system memory limit\n&quot;);
+		kfree(prange);
+		return NULL;
+	}
 	prange-&gt;npages = size;
 	prange-&gt;svms = svms;
 	prange-&gt;start = start;
@@ -307,7 +326,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	mutex_init(&amp;prange-&gt;migrate_mutex);
 	mutex_init(&amp;prange-&gt;lock);
 
-	p = container_of(svms, struct kfd_process, svms);
 	if (p-&gt;xnack_enabled)
 		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
 			    MAX_GPU_INSTANCE);
@@ -1000,9 +1018,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 
 	svms = prange-&gt;svms;
 	if (old_start == start)
-		*new = svm_range_new(svms, last + 1, old_last);
+		*new = svm_range_new(svms, last + 1, old_last, false);
 	else
-		*new = svm_range_new(svms, old_start, start - 1);
+		*new = svm_range_new(svms, old_start, start - 1, false);
 	if (!*new)
 		return -ENOMEM;
 
@@ -1825,7 +1843,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 {
 	struct svm_range *new;
 
-	new = svm_range_new(old-&gt;svms, old-&gt;start, old-&gt;last);
+	new = svm_range_new(old-&gt;svms, old-&gt;start, old-&gt;last, false);
 	if (!new)
 		return NULL;
 
@@ -1951,7 +1969,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 		/* insert a new node if needed */
 		if (node-&gt;start &gt; start) {
-			prange = svm_range_new(svms, start, node-&gt;start - 1);
+			prange = svm_range_new(svms, start, node-&gt;start - 1, true);
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
@@ -1967,7 +1985,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	/* add a final range at the end if needed */
 	if (start &lt;= last) {
-		prange = svm_range_new(svms, start, last);
+		prange = svm_range_new(svms, start, last, true);
 		if (!prange) {
 			r = -ENOMEM;
 			goto out;
@@ -2585,7 +2603,7 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		last = addr;
 	}
 
-	prange = svm_range_new(&amp;p-&gt;svms, start, last);
+	prange = svm_range_new(&amp;p-&gt;svms, start, last, true);
 	if (!prange) {
 		pr_debug(&quot;Failed to create prange in address [0x%llx]\n&quot;, addr);
 		return NULL;
</pre>
    </blockquote>
  </body>
</html>
