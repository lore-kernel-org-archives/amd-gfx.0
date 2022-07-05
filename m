Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D93FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 16:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A95113F19;
	Tue,  5 Jul 2022 16:09:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AAF911351E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 16:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5OJh31QDcla9ZCaJZh3O7cW35TK6a6j0O90oiwwivExfMYKrPECgRkHXg3r4EZLuc6FMev3xJEN/qm72xfnNrkzTBbhuUfblJXCzkT8gqeuYyqlSGay4tHslmZeJjlLw76wlcJ+SkVvJTIDDCY+M/rih94ylFuo3gB5u/TXSCdLpnqBQ+bdRcft1BPoMGtBRfJgEDoySg1koJCNWnfOOvkMIC9o+NAOVY+8boOomMvgTdeG+fZrBPyuracnB0hmGRu+AFA+/8a+Hp0DZbM6ooChi6U6HjDb94wcaw0mm+YPyBusJuBZsh1YYVEAYXhCHjd+dKGO5umRG2poAKhbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU+j3XNiPwpMyTY0SwlaTRBccD1BRQMKm2DILLOLyPU=;
 b=RRlisStS3nJnPJP+yyFZKIhRgE0V1i4fm3msHcrJNyS02rhNfPl5PAtHctIvlsuOhscjNhQhnnm10iOsqb5MeNFc8PR9daXjDt0/vUqTps1vZsth8MpBlvg7bHN79w6OshxwsxJ8ePpNuGXDKtMduzwfO91oUFPd+SNNkoooyFETb04YtmueUipNOwTGv4n6tqUlXE9RKRw4M5uStKgpZOHKHVFfNaWKBxcfyev5VkjjS2G3goZkP4J9tpMWoXnFbtmca9/R1AUbUGC96JqUQLyxaPJgorRa6anr4orpiXQjG9qzcySpVXjK6S5HzldwkYaD11JN+WbeGWbCEwsiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU+j3XNiPwpMyTY0SwlaTRBccD1BRQMKm2DILLOLyPU=;
 b=0eca7PofQBSFSaTv05dxLGYo9PqPAkZgxZbZcl+5uNE/zKKe2iibEzLV07wZcQezH8koSsfL17cfjy7PFTXgQ8w6Xoq4s+/6e8ofj93oduriXgYn91RgJHSgiHy3uYiIZkSvGkZoz85omMOg4G0/bqecUn3sU+xSxY5Xq92/UxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BN7PR12MB2612.namprd12.prod.outlook.com (2603:10b6:408:29::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 16:09:27 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::f484:f216:c67b:e595%5]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 16:09:27 +0000
Message-ID: <cdcf6a70-c553-49fd-320e-7b3b178337f5@amd.com>
Date: Tue, 5 Jul 2022 12:09:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] drm/amdkfd: track unified memory reservation with
 xnack off
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628002347.3982-1-alex.sierra@amd.com>
 <20220628002347.3982-2-alex.sierra@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <20220628002347.3982-2-alex.sierra@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:610:e7::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b793eee-0b2f-4c44-290b-08da5ea0bc83
X-MS-TrafficTypeDiagnostic: BN7PR12MB2612:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bdc+gWa3ioximfksEe7aXg+4mWCu+SzQG0f7O4FIJl91fbteUQWZUFrMWlwmM56ee3R7iTrg4CGV4Xw4U0+Ise6ZgfDKqZhcQmhHvO5Hf17+pWM4op0bIFuWDKboPOvgpVKyh64bc1yvH93p8MU6gUjE132Bf9OqcnPgr6hj/EiT6pRKbOCMcjRzszCR6KbiH0D+vwefaMSnSq+PT55cdNoVm5THL7JbOG++zXQx75K+KivZILwSaBAIrOkUsZIaKZtXIyp864W591LnlO6o0ZwqUZkCinnxjW66d8s5eQeq03m07CaC+uYMykkbZVOEJaLPSzlZuuJHalswsGzDf43d01sw93Ggsus/hx7H3mzuIj7gSmEELQWXbFSRJ4K7EGeIBTtpvwPExhAIxWL3kOnUYZXKoDTKtAIxFAvbg7FK9Bd0AXap4SvjwgOJZML7nCGA/P/vxPMeCA7xeVaBjIa0//kiz5mJhH83X7JU9cAbdi35HdxP7UpDsw5VDxZTcqwXa6MtiGPOTdzxjj+ftp2IvUyCqWsNqiidyg65zEH7I+kzhw9teWglLCHDPieWqqJBcwl8xqLQASNDl3Cdz3T5QGfyzE4JBXVTfFX/S6v258m+KPRzin+3td02MS2s3nGFUpARNZCMUR1HraNfmCseZ3ZTEQJSoekIL4em6Cbjo9KLti8Jp5BrJSTGEHtVdiu9221f6XDf/hyxLKIHIJHYbkT5+6HAS2aNJ6TGlpTP/qiMI01xilLHDCGdbnEdz50cffbqWImZV552G465aBuSQ0J05KzGG0qQXuEpN3YsOcp+gMQCYeksAengjmsuDm7tGraS4ZHzZ1tWgt693A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(66946007)(8676002)(66476007)(66556008)(316002)(186003)(38100700002)(4326008)(478600001)(2616005)(6486002)(53546011)(6506007)(41300700001)(26005)(6512007)(83380400001)(31696002)(5660300002)(31686004)(2906002)(36756003)(8936002)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTMwT0srMlJJcy83c0FXQnY5TXk2L3ZoNDg1endDaDJVci9oTzJTdUF5V2cx?=
 =?utf-8?B?TkRSTDcwSHlGNU5UREFyZXpwWWk2bGszL0FqOHFzbU9BTGIrUWhaTXRKR0Qy?=
 =?utf-8?B?ZFdZMUpvVTFOUzhiWEtWbTBZV1lnMmI5L3Rmb2pXekVsVXZSSVhVbGYzNTRQ?=
 =?utf-8?B?bUdIRWxUb1VKcFRtaE1nbFVNRGp5Tnh6Q2tMMmNNZHEzWmFNcFpmWUZIdmR2?=
 =?utf-8?B?Y1NLQmZTelJlY1hYUHBMSWVxdlUzK2xSV2wvMjgyamFnVGNzWmJJbnNvUzlB?=
 =?utf-8?B?c2dnVER0Z0w4aTBjQkN2M0w5Z3hzNWdLMWhmenp0ODNERmMyNnRwdEx0QURF?=
 =?utf-8?B?WEFtVHd5Z2hvL3FqTDdueFdOdGtKU1JZTjd4dWtJRTJvWGF6Sk94TE5iaGRk?=
 =?utf-8?B?empzWUYrbDNmblMrOEdjQ0pXZnJXRkYvejZxcVZ4Y09sem02Z1Y0ZmV1eVNX?=
 =?utf-8?B?MTY5NnAyQjBLa0Fna3VsVzN4bDFmR3NoTmVVMEhHRXJQS3gxbUlBS043bUdU?=
 =?utf-8?B?ckMwb3lBUHdGMVZrblduekk3c3BuV1pnUkd2TkZmQ2t2N3F6NyttQWpSdGJj?=
 =?utf-8?B?aTZxRlJBbkRFbDdUTjFuclBnRHd3dzB4bzRyL3JBYzVORWFhZUVUZUtwZkVK?=
 =?utf-8?B?ekRRWmQ5aE1kWnJjUFRralNTWkJmSXZtbGI3M1lCR3BydEhWL1BZUGZ1YVhF?=
 =?utf-8?B?OXFsd1BwY2xnZ0Ztdi9ZeGpvc016SU50YTZsalZNT3RhY0owYWV3UWFKZHZx?=
 =?utf-8?B?NUFvclhlREg0TXJBWkVZcU9jbzBCVVV1OWpiTGRuYlZqdDAxTUFlQXU0cTJT?=
 =?utf-8?B?VlY0ZVRLc2FJV2FjQXNtb2h4VkY0alhudFBOZ0lna1J2VTYySTVUMWRyOGIv?=
 =?utf-8?B?Y1NCdUtTbG5aWVR5d2pSc1V0TG43aC9hODVhMTl1WGxSOG1WNnhnbmorTC9u?=
 =?utf-8?B?a2dIZUExbUZxMzBTNDJsNFUvaWRlNUlPclNaUjlra09EMUdMaFlVQm1mcGdX?=
 =?utf-8?B?aDB6aDNaNG1sVWRHK1ZBM2pMbXVuVC9aQWN6TlBEUmhIMDgvYXo0QmpqYi9u?=
 =?utf-8?B?K2tZQTl3RXg0MUlONm51VUpWREY3N0kvZ0w1OTl5SHdiVTZqMXk5eTgycFN5?=
 =?utf-8?B?NDExejhnZVVQNFA3bk01UDh4TTRNNmlERC9vN21DNnBTNStXUk5oTGdqK2Zn?=
 =?utf-8?B?NW5rUENJa1hYaVo3eTVNM1JVOHpDWTArcFlzQXBkYUpJTVE0ak1xWkhVZmxo?=
 =?utf-8?B?RlZmMEN1MGVZVGRUZWg0WGZKYmdYRDU2YU5UU2M1TVhmTkhIam9SQzhPSDZC?=
 =?utf-8?B?NWdzS29uZFg5dVNRS0lRSjlucEoycWF5eEljUTBlRDZkWmNHam1DRWpnMW94?=
 =?utf-8?B?b3hSR1owRWRJN0ZaYlZuTkdYM08rWFJ6dEFXdmk1RW9sMGxhaHFNeEprNmVw?=
 =?utf-8?B?RXVZakl6UUU3bEd2a0xRQWthc2Z4VS8zQ1dsbmQvMk5GY2lWS25aSDY2NGZn?=
 =?utf-8?B?dU1RZG9vMHdiaVFEN1VwUWJqelE3ODRZMHJKcjZYSkY1elZkVnVJM2Npb1Q2?=
 =?utf-8?B?QU5ITmVzelNMOGdLOTQ4VzZ0dE9pbHpocm44VDJaRW5qSDg0RE5yWGc0Q05M?=
 =?utf-8?B?eE5RZnhvQ1Y5akRNMGdscThBMHZDRHFSLzcxVnNWdVUxUkVqNUgrL1IxTFpt?=
 =?utf-8?B?eGtWZmMrYXZ2cGpQQjg4SkovcnRDZHM2R0tCQ2hkd092NG5nU2dPL1Y3S0pY?=
 =?utf-8?B?Y3pqYXpxUUZPWU8zdkc4MEpwSmRlSU1vUGRTRjkxR3BsMTRCWTJZWktwd05Z?=
 =?utf-8?B?VS9jYjI1MklwVGVzelFJVjNka0p5bGtHaVdIbUo4TjM3QzBJOVlpZTlhNjRR?=
 =?utf-8?B?QThCYTZJNVM1Z2d6eUV6Z09wTjh5RkpLb1RoQmZNanJqQlhHckxBY20zZVAx?=
 =?utf-8?B?LzdwUjFGZ0JMOGpHMmpuZXlSazBORDJmVVEwL0ovMGkvZVUwb01YY0dzQkx3?=
 =?utf-8?B?QzNpZThDRlRLa3NXbDlSUlM1YjVhY1lXOHl0Q0IrVVliN2hiWGN3ZWV2bFoz?=
 =?utf-8?B?Z0dRYkxuR0U5enJhREk5WnZlekdQMkhHbGpVWUxaRllkY2pTUVEyT0h4V2tz?=
 =?utf-8?Q?eHyY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b793eee-0b2f-4c44-290b-08da5ea0bc83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 16:09:27.8086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEkD74bTrd7/T0HsBFkzX6XdSiIoMMXXOZXzLw/RV1K1+fdKnRzQf1p+c+b/F8E+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2612
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
    <div class="moz-cite-prefix">On 2022-06-27 20:23, Alex Sierra wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220628002347.3982-2-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">[WHY]
Unified memory with xnack off should be tracked, as userptr mappings
and legacy allocations do. To avoid oversuscribe system memory when
xnack off.</pre>
    </blockquote>
    I think this also apply to XNACK ON (remove p-&gt;xnack_enabled
    check), to avoid oversubscribe system memory OOM killer, if we don't
    account swap space as it will degrade performance.&nbsp; <br>
    <blockquote type="cite" cite="mid:20220628002347.3982-2-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
[How]
Exposing functions reserve_mem_limit and unreserve_mem_limit to SVM
API and call them on every prange creation and free.

Signed-off-by: Alex Sierra <a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 ++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 25 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 58 +++++++++++++------
 3 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b25b41f50213..e6244182a3a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -305,6 +305,10 @@ bool amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *
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
index 9142f6cc3f4d..9719577ecc6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -128,7 +128,7 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
  *
  * Return: returns -ENOMEM in case of error, ZERO otherwise
  */
-static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
+int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	uint64_t reserved_for_pt =
@@ -168,7 +168,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	     kfd_mem_limit.max_system_mem_limit &amp;&amp; !no_system_mem_limit) ||
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed &gt;
 	     kfd_mem_limit.max_ttm_mem_limit) ||
-	    (adev-&gt;kfd.vram_used + vram_needed &gt;
+	    (adev &amp;&amp; adev-&gt;kfd.vram_used + vram_needed &gt;
 	     adev-&gt;gmc.real_vram_size -
 	     atomic64_read(&amp;adev-&gt;vram_pin_size) -
 	     reserved_for_pt)) {
@@ -179,7 +179,10 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	/* Update memory accounting by decreasing available system
 	 * memory, TTM memory and GPU memory as computed above
 	 */
-	adev-&gt;kfd.vram_used += vram_needed;
+	WARN_ONCE(vram_needed &amp;&amp; !adev,
+		  &quot;adev reference can't be null when vram is used&quot;);
+	if (adev)
+		adev-&gt;kfd.vram_used += vram_needed;
 	kfd_mem_limit.system_mem_used += system_mem_needed;
 	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
 
@@ -188,7 +191,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void unreserve_mem_limit(struct amdgpu_device *adev,
+void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag)
 {
 	spin_lock(&amp;kfd_mem_limit.mem_limit_lock);
@@ -197,7 +200,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		kfd_mem_limit.system_mem_used -= size;
 		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
-		adev-&gt;kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
+		WARN_ONCE(!adev,
+			  &quot;adev reference can't be null when alloc mem flags vram is set&quot;);
+		if (adev)
+			adev-&gt;kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
 	} else if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
 	} else if (!(alloc_flag &amp;
@@ -206,11 +212,8 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		pr_err(&quot;%s: Invalid BO type %#x\n&quot;, __func__, alloc_flag);
 		goto release;
 	}
-
-	WARN_ONCE(adev-&gt;kfd.vram_used &lt; 0,
+	WARN_ONCE(adev &amp;&amp; adev-&gt;kfd.vram_used &lt; 0,
 		  &quot;KFD VRAM memory accounting unbalanced&quot;);
-	WARN_ONCE(kfd_mem_limit.ttm_mem_used &lt; 0,
-		  &quot;KFD TTM memory accounting unbalanced&quot;);
 	WARN_ONCE(kfd_mem_limit.system_mem_used &lt; 0,
 		  &quot;KFD system memory accounting unbalanced&quot;);
 
@@ -224,7 +227,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 	u32 alloc_flags = bo-&gt;kfd_bo-&gt;alloc_flags;
 	u64 size = amdgpu_bo_size(bo);
 
-	unreserve_mem_limit(adev, size, alloc_flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, alloc_flags);
 
 	kfree(bo-&gt;kfd_bo);
 }
@@ -1806,7 +1809,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	/* Don't unreserve system mem limit twice */
 	goto err_reserve_limit;
 err_bo_create:
-	unreserve_mem_limit(adev, size, flags);
+	amdgpu_amdkfd_unreserve_mem_limit(adev, size, flags);
 err_reserve_limit:
 	mutex_destroy(&amp;(*mem)-&gt;lock);
 	if (gobj)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d6fc00d51c8c..e706cbfa924f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -259,13 +259,22 @@ void svm_range_free_dma_mappings(struct svm_range *prange)
 	}
 }
 
-static void svm_range_free(struct svm_range *prange)
+static void svm_range_free(struct svm_range *prange, bool skip_unreserve)
 {
+	uint64_t size = (prange-&gt;last - prange-&gt;start + 1) &lt;&lt; PAGE_SHIFT;
+	struct kfd_process *p = container_of(prange-&gt;svms, struct kfd_process, svms);
+
 	pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms, prange,
 		 prange-&gt;start, prange-&gt;last);
 
 	svm_range_vram_node_free(prange);
 	svm_range_free_dma_mappings(prange);
+
+	if (!skip_unreserve &amp;&amp; !p-&gt;xnack_enabled) {
+		pr_debug(&quot;unreserve mem limit: %lld\n&quot;, size);
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	}
 	mutex_destroy(&amp;prange-&gt;lock);
 	mutex_destroy(&amp;prange-&gt;migrate_mutex);
 	kfree(prange);
@@ -284,7 +293,7 @@ svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
 
 static struct
 svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
-			 uint64_t last)
+			 uint64_t last, bool is_new_alloc)
 {
 	uint64_t size = last - start + 1;
 	struct svm_range *prange;
@@ -293,6 +302,15 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
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
@@ -307,7 +325,6 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 	mutex_init(&amp;prange-&gt;migrate_mutex);
 	mutex_init(&amp;prange-&gt;lock);
 
-	p = container_of(svms, struct kfd_process, svms);
 	if (p-&gt;xnack_enabled)
 		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
 			    MAX_GPU_INSTANCE);
@@ -1000,9 +1017,9 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 
 	svms = prange-&gt;svms;
 	if (old_start == start)
-		*new = svm_range_new(svms, last + 1, old_last);
+		*new = svm_range_new(svms, last + 1, old_last, false);
 	else
-		*new = svm_range_new(svms, old_start, start - 1);
+		*new = svm_range_new(svms, old_start, start - 1, false);
 	if (!*new)
 		return -ENOMEM;
 
@@ -1010,7 +1027,7 @@ svm_range_split(struct svm_range *prange, uint64_t start, uint64_t last,
 	if (r) {
 		pr_debug(&quot;failed %d split [0x%llx 0x%llx] to [0x%llx 0x%llx]\n&quot;,
 			 r, old_start, old_last, start, last);
-		svm_range_free(*new);
+		svm_range_free(*new, true);
 		*new = NULL;
 	}
 
@@ -1825,7 +1842,7 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 {
 	struct svm_range *new;
 
-	new = svm_range_new(old-&gt;svms, old-&gt;start, old-&gt;last);
+	new = svm_range_new(old-&gt;svms, old-&gt;start, old-&gt;last, false);
 	if (!new)
 		return NULL;
 
@@ -1889,6 +1906,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	struct interval_tree_node *node;
 	struct svm_range *prange;
 	struct svm_range *tmp;
+	struct list_head new_list;
 	int r = 0;
 
 	pr_debug(&quot;svms 0x%p [0x%llx 0x%lx]\n&quot;, &amp;p-&gt;svms, start, last);
@@ -1896,6 +1914,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
 	INIT_LIST_HEAD(remove_list);
+	INIT_LIST_HEAD(&amp;new_list);
 
 	node = interval_tree_iter_first(&amp;svms-&gt;objects, start, last);
 	while (node) {
@@ -1951,13 +1970,13 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 		/* insert a new node if needed */
 		if (node-&gt;start &gt; start) {
-			prange = svm_range_new(svms, start, node-&gt;start - 1);
+			prange = svm_range_new(svms, start, node-&gt;start - 1, true);
 			if (!prange) {
 				r = -ENOMEM;
 				goto out;
 			}
 
-			list_add(&amp;prange-&gt;list, insert_list);
+			list_add(&amp;prange-&gt;list, &amp;new_list);
 			list_add(&amp;prange-&gt;update_list, update_list);
 		}
 
@@ -1967,19 +1986,22 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	/* add a final range at the end if needed */
 	if (start &lt;= last) {
-		prange = svm_range_new(svms, start, last);
+		prange = svm_range_new(svms, start, last, true);
 		if (!prange) {
 			r = -ENOMEM;
 			goto out;
 		}
-		list_add(&amp;prange-&gt;list, insert_list);
+		list_add(&amp;prange-&gt;list, &amp;new_list);
 		list_add(&amp;prange-&gt;update_list, update_list);
 	}
 
 out:
 	if (r)
-		list_for_each_entry_safe(prange, tmp, insert_list, list)
-			svm_range_free(prange);
+		list_for_each_entry_safe(prange, tmp, &amp;new_list, list)
+			svm_range_free(prange, false);
+	else
+		list_for_each_entry_safe(prange, tmp, &amp;new_list, list)
+			list_add(&amp;prange-&gt;list, insert_list);</pre>
    </blockquote>
    <p>We should remove range from both new_list and insert_list to
      rollback pranges.</p>
    <pre class="moz-quote-pre" wrap=""> 	if (r) {
		list_for_each_entry_safe(prange, tmp, insert_list, list)
			svm_range_free(prange, true);
		list_for_each_entry_safe(prange, tmp, &amp;new_list, list)
			svm_range_free(prange, false);
	} else if (!list_empty(&amp;new_list) {
		list_splice(&amp;new_list, insert_list);
        }
Regards,
Philip
</pre>
    <blockquote type="cite" cite="mid:20220628002347.3982-2-alex.sierra@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 	return r;
 }
@@ -2026,7 +2048,7 @@ svm_range_handle_list_op(struct svm_range_list *svms, struct svm_range *prange,
 			 svms, prange, prange-&gt;start, prange-&gt;last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
 		break;
 	case SVM_OP_UPDATE_RANGE_NOTIFIER:
 		pr_debug(&quot;update notifier 0x%p prange 0x%p [0x%lx 0x%lx]\n&quot;,
@@ -2588,14 +2610,14 @@ svm_range *svm_range_create_unregistered_range(struct amdgpu_device *adev,
 		last = addr;
 	}
 
-	prange = svm_range_new(&amp;p-&gt;svms, start, last);
+	prange = svm_range_new(&amp;p-&gt;svms, start, last, true);
 	if (!prange) {
 		pr_debug(&quot;Failed to create prange in address [0x%llx]\n&quot;, addr);
 		return NULL;
 	}
 	if (kfd_process_gpuid_from_adev(p, adev, &amp;gpuid, &amp;gpuidx)) {
 		pr_debug(&quot;failed to get gpuid from kgd\n&quot;);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
 		return NULL;
 	}
 
@@ -2884,7 +2906,7 @@ void svm_range_list_fini(struct kfd_process *p)
 	list_for_each_entry_safe(prange, next, &amp;p-&gt;svms.list, list) {
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, false);
 	}
 
 	mutex_destroy(&amp;p-&gt;svms.lock);
@@ -3299,7 +3321,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			 prange-&gt;last);
 		svm_range_unlink(prange);
 		svm_range_remove_notifier(prange);
-		svm_range_free(prange);
+		svm_range_free(prange, true);
 	}
 
 	mmap_write_downgrade(mm);
</pre>
    </blockquote>
  </body>
</html>
