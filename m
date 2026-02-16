Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83590E63F3F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 09:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D2C10E1FC;
	Mon, 16 Feb 2026 09:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="um9QKiId";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB6E10E1FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 09:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsso+Qs9dmtv3KZzNzvmC20PB0OIr46PhqmvPlIqbLsCuzfamy8xqh8tnxPepPODl6sC7/oPcpIcTkrF/LpDjRIWRfuah6oeWDtArHegsiM+yvq1WB/QQCWKKEbDYhwi68nb1ME1CppEN+J1+ibE7pUr8mlB9cnIZrUI9Sn+AuOmOrzDywlEAzmcwVWw5vbMegYOJfuiGdUISvdxLbNeWUHObkhgaGS/Feci0Pw00355U+YhInzO7dS6PYHvc7gqXyYBdXyqbqJZYzJ6PCbI49Mearybv4BQaV/PF7+YvUfmYgf8woFw//0Ck0R9TYE9CPAg4v5E2dmebpM7qY7T7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoWXw4rnETf63ymrrsAAntegLWTAy6rlMjsjQCt6VZI=;
 b=EW+8bGiwjJFeO4w5cbFqVq2oTefjlyQvRS1QeTHyY2aBtBQG4AnF1kMoQYxZQ66tkwNbKW7lxy/12SRzzQSi1jNqee4s5lAFiaG5JUSavpArZ0NOJsbFioAJqJQNreaOqL3vNr4uMGjadC88DVf5Oi/Y9ajgJuvevDdRH/MIjQXBwcIp8S8UmDAUcpNoEMQOidI4MrK5FiCUEwu+lwRJdOJ5ojojTD/xaJJDQBR3uGBu2cdiVZ3/X4AxSVOACC0k/KTdNbrhzrDH8pd+L5pkqycpj3GKy+FG2Br6GIR5Tl14tgDC+zIQgbL2cSY6MXLMw+W+fljleIqx9CEDl/+xbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoWXw4rnETf63ymrrsAAntegLWTAy6rlMjsjQCt6VZI=;
 b=um9QKiIdOyZlji1Vvl3cLB73buYONpjde6zJ7bC3L1xVJ4j9K0nDbIa54NiEFqZsX4LozL5NOBcNJpRWcdIuui8Alc+1H0rqyABGrejfOrrTG3klqCO+GV1CG242PSfwva2BlCWAnqUBz8bnWmLIZf4jgahOgRhbpLlv+dj/s+Q=
Received: from BLAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:36e::10)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 09:45:36 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:36e:cafe::9b) by BLAPR05CA0003.outlook.office365.com
 (2603:10b6:208:36e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 09:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 09:45:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 16 Feb 2026 03:45:33 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add IRQ-safe eventfd signal helper
Date: Mon, 16 Feb 2026 15:14:46 +0530
Message-ID: <20260216094447.1581407-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216094447.1581407-1-srinivasan.shanmugam@amd.com>
References: <20260216094447.1581407-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 545faea3-6aea-4702-9ce7-08de6d4022bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ukl0aEpka0xsOFAxLzlxdEtTRHdJNUx6OWZyOG5GOHZDeitlVGJxTTJJQWY5?=
 =?utf-8?B?clBVOG0yaC9wTmJiN2lCcFdoNzVrM2NaNmt5STZicjN5UlpIMzFkL0lQZTFt?=
 =?utf-8?B?SUMvZm9LWnZwWWQ4RUFZcjN6T2RsdzJZdDNNamVzc1VYaE1nVHhXckp5Tk8y?=
 =?utf-8?B?L0JRNWhtcy9oRW5FKzdZNCtPNVpabmhQT2lWWDh1dzZXYWt1cUVHNXFFTTd3?=
 =?utf-8?B?SmdXK3hKWTJSdld0TTNIYlVwdmRtWmM0N1JzTU5BUGdLR0ppL01Oa1k5dXlD?=
 =?utf-8?B?alJzaVJRZHZZQ0h3OHVPUUdEVkx3VzliZXhobHB4ekZTOTNLZC85dVlTUW1P?=
 =?utf-8?B?eTdIa015ZWdxckR1ZUV6TElSN3ljM2pWbXBpMjUzOUJXRHBYeWJzTGFvSFQw?=
 =?utf-8?B?Q2hRR0RUakdOM3B6UGQ0NkJVNzZWYzQrQkNsT3cyY0g1aEJSN3RycWloSnox?=
 =?utf-8?B?VmpvVjFONERXUExnRjJxU1BlWldRUXJPeExyM0tKMWhKZDN3UnZoMHlaRld1?=
 =?utf-8?B?cWZqeUM3bnBVc1gyL2NnRGt2c3E4SDlkWHVmdkRZd1lqNlc1ZGwyVCtta2o0?=
 =?utf-8?B?Z05UUzhIaStWWEEvL0NkMmdkMjBsV2RrUnlENEp4UkVXaHdIVGxnU2lHS0I5?=
 =?utf-8?B?UTZjeDJhL2NaWWpwN3N1a3RZaXBlTnhvYk1FdURDMDB4cG54M0dhM3lYeFZ1?=
 =?utf-8?B?SS9ucHYyLzU1cnNLMDA5eVljVWFJL1JhYlJydnlMbGJTZTJtenhNWk5BREJK?=
 =?utf-8?B?bi9YM1lxYlBVeUxmMEZjZmdHU3phSUYvSWFLTkZRTWp3eFM5TmRDUDVRZU9H?=
 =?utf-8?B?UXVpY3hCdThMN0FQanhYaGJqYzNxNWIyTjNBK3Nxb2pyTkRrOCttNGhlWGw1?=
 =?utf-8?B?UnQ0OTN4VmdOZUNuWDNuc2RSTmxnZXZBbnN2NUZyWWhwUlRoUVRhQTJtOTcx?=
 =?utf-8?B?em9VZmhuMndEK1JIVFdqbHR3Q2lIK2p0ZmpCbkU0TWlZbk1WVG1kOERLR3BQ?=
 =?utf-8?B?alpYK1ByMkNuTGRiWDFYbzdGUFVneDhOVmRVeHdobGlsMS9ycEsrWlA4UEZJ?=
 =?utf-8?B?aGdQWHY2OWxxVExnNU1Eemo5eDNiM3ZrWVRDWFdFazllRVJuT0N2QWxrZ0tX?=
 =?utf-8?B?d2puS1VoN0FIaStlUEJEUXlFRWZoeCsrK2xFQ0dvRHNnWjdGR3VPbHhCRzhL?=
 =?utf-8?B?ZWkrMHN5YzFGVmZJRUNrekN1UzMzY1BibmUzenFmdFYxeVF4c0V5V1ZXMmdY?=
 =?utf-8?B?cTBZamgySTRKWUhiSk8yc3VJZHNpYk4xb1J2OXNnZHN2eHFzU1RwajBHOGdY?=
 =?utf-8?B?b0N2ejgrdENlYkZSalF5akhhdWx6TU9UZUtXZTMwU2RwdHpvblRkU3BQelE2?=
 =?utf-8?B?aFRseHl6c0FCZ2dVMDMzMXRVTDZ3ZGhYako4eEF2OHRYNEZMQmREckt3cFM3?=
 =?utf-8?B?YVpEaitWZU0yMnF6Um9la3FvdHlQZGFJNm5JNjR4bjd2R2FyRVZWMGlpcGdL?=
 =?utf-8?B?d2RCaWQ0T1BUdnNDQXE3QnNBbVJINUJjR0ZFU3Zwdlo1VVlrQlhzOXQwN1lN?=
 =?utf-8?B?V2pzK3ZXZzVOS1RWaW1ET0N1YzBET1NCV1BuaFY0b0dEdnBzMlE4WUNmNzJC?=
 =?utf-8?B?YzJta0d1MFc5V0ljcU05TEhoSVRkU3JDWUVLMXJ0Nk44TlMxMVFUNFZHUjhW?=
 =?utf-8?B?SGVlc0pJamxMV2IzN1NJaE5RWmNTc04wTlV0QitlRzcyRS9Ud0ptVDZuOEtK?=
 =?utf-8?B?Tk0vLzdBbmFZZThiajE1UnlRN09tV3p5M1hnZ214L3JBQ3VRMGd6YzlrQ2l0?=
 =?utf-8?B?cHRHNjJnTjZPc01DcjVYL2RZV2loWGd0akNPUjJ0WlNYQ0cxb0dmaHprMUxZ?=
 =?utf-8?B?VnExYkEzQUVlY2pVOUpJUlQxUmNMVUR0cUovMnZaSTE0Y1NIQzkvOW1TaEYx?=
 =?utf-8?B?d0JseGdWNW5FZkFLemlBdVd5WUVNS2QxNHRGTHJib2N4QWphM2NkMnE2d0ov?=
 =?utf-8?B?eWlTVDRUKzVpQTJsU05DOUFIdkN0QzArL0NndEFoalJZY3hWQU1FbitaVXhF?=
 =?utf-8?B?WVpXOGE5cUpCUjRlaVFyNzMxYVM4TVZOSEJVdmVWSkp4bXhNVHZ3dWg3aFRl?=
 =?utf-8?B?U1NqTTVwZ1pGRzNnU1YydW5OdkVZek5OeFpoOThRc0hKaWlZWVgzTmJsVDN1?=
 =?utf-8?B?K3VPMmJFRTg2bHlUdWV3dDVqc0FoTlp0ZzRKbHF6OFZxSmFocjZRMS9GakFS?=
 =?utf-8?B?aWwzaWhpWUJ5L0Z2NlV1TjZ1RmR3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eZa0YZwNUp2iW5YIHVKeDx+qiX2LyDetMKWEsHOAS9Ct6BPBEiKBPUwudHQ2awwxbCgFxfTnf2pgA8Xk4clkYB/hTaci10F9aN5qklYbODIn6ovGGP0JnHsWMpG/UzMPXsmBrWFFzHGp+b+D/p3moXznFCd5pUksVOgTQO1fItXR4KFL4zDkfybA4Vf1vR7xuS24EYY4EkCIDPx1o/LJvF3peQUvIKOfrg1rZdgDXOCfFxWNrcoGdzw1mwqvJ0KTfoP1iRYRfgF9M6K1U7viRqcyvVpDiVvFNvMhTmn6sUNWz479BzhGG8ev6JAIymJERzqy7LOntBoCNdCYx6ABniAQj+UOXLP3jgjy0LjFwQrfXvaQAJP9HBrDbasXMtdDADvvnTcZ+WfEh9ORhwpfa2on6OrLacwAZGSXi8SNtHnuZEGpzX/MalIBp5Qxb1cv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:45:36.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545faea3-6aea-4702-9ce7-08de6d4022bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

Add amdgpu_eventfd_signal(), a helper to signal an eventfd previously
bound to an event_id for the given drm_file (amdgpu_fpriv).

The helper is IRQ-safe: it uses RCU read-side protection and lockless
xa_load() to find the mapping. Bind/unbind and final teardown already
use call_rcu() + synchronize_rcu(), ensuring safe lifetime of entries.

Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2baeb0b20df1..b0e9b7ff2f80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -473,6 +473,7 @@ int amdgpu_eventfd_bind_ioctl(struct drm_device *dev, void *data,
 int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv);
 void amdgpu_eventfd_registry_fini(struct amdgpu_fpriv *fpriv);
+void amdgpu_eventfd_signal(struct amdgpu_fpriv *fpriv, u32 event_id, u64 count);
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 43da5bc36b7c..66e2ae8b7c8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -745,6 +745,27 @@ int amdgpu_eventfd_unbind_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
+void amdgpu_eventfd_signal(struct amdgpu_fpriv *fpriv, u32 event_id, u64 count)
+{
+	struct amdgpu_eventfd_entry *e;
+	struct eventfd_ctx *ctx;
+
+	if (!fpriv || !count)
+		return;
+
+	/*
+	 * IRQ-side: lockless lookup. Lifetime is protected by:
+	 *  - bind/unbind freeing entries via call_rcu()
+	 *  - registry_fini() calling synchronize_rcu() before xa_destroy()
+	 */
+	rcu_read_lock();
+	e = xa_load(&fpriv->eventfd_xa, event_id);
+	ctx = e ? READ_ONCE(e->ctx) : NULL;
+	if (ctx)
+		eventfd_signal(ctx);
+	rcu_read_unlock();
+}
+
 /*
  * Userspace get information ioctl
  */
-- 
2.34.1

