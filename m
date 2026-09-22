Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AA2C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 07:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557AD10E4ED;
	Tue, 22 Sep 2026 07:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bMkGwoL2";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A1510E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 07:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy4HAgW/G/sM28ewupzThspHRzM+QcgCsDSGnrI87lZwrLr7QX5sfk9ErVME5iyggHlkTcH4kaL2sZXMlTc3QNgeHs6DtBv4dT6mEVyRgPT1Kvj9fW+N6srfBYwh/QaFx4P+eVqfFiEe2JOQKGZ9Z/KgGk01cbAbR+1O7qjYbdAgvo+pSwzGkHvKIu7UmQttDngITLiDd5t+fP9BODfOJagu33iULMHEqP1PgWyiGegr3o9D1ldtM1Se/XsCYImYbt+H+SZ41UqI3xaPvr/S8TKbS2BE/PyXh9aPLnvXX27/L6KEYlGdRsh7m+ESaPDRGbAXAzomwMxtSmfX5WNBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS7otyWlGRslky1aPNlsGlgmz+N38EglW+oWaibo/t4=;
 b=hFF5M1HpxFU02DlPxZDh2WnK25o1gN7MROLWE6+HmVfaFNT0sJru7JBk+5r9ghtwoCTPD198NvPbZHZjFf7DmZhhQ3a/KBnNANPTuL3kJY2B9qQCb7WBiiwyS4PrG3lZpL3bjVBVG1BRUe2TKTt5sKU4hFilfmb+3tGuSf5fVRcExQCpvlxb0sXBsjGo4ZMQE71ZL/uvozVJcDOmZeEvX6JI1V/rtDZL6h2aOGG1axojCEb6DsXdUpWSV8lGDvd/vbc4DPEpPzxC17jlEv3AtlcLeNBuPONRKpouJhkXQs0AV/Awb8BltitorTYEGbrC5zCxdKC8+RuR8GZrULzKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS7otyWlGRslky1aPNlsGlgmz+N38EglW+oWaibo/t4=;
 b=bMkGwoL2YxnowlwbgMGfe1wDcwuB6GgXyNB7vkPG/kqp3Hnca7+2rtf0vzgT/e+qBEDv3zNKuTzqoWECp6pfdwdT9wvRHdp2qnN6aExjyPuJtUMtTQdwZ9AFtKcjmyk1kQiY6zkUS1MvTDAnOtkn25tE5rGMuqNxbOoTEMuG0Gc=
Received: from PH8PR15CA0024.namprd15.prod.outlook.com (2603:10b6:510:2d2::9)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 07:59:08 +0000
Received: from SJ1PEPF000037B8.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::2e) by PH8PR15CA0024.outlook.office365.com
 (2603:10b6:510:2d2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 07:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B8.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 07:59:08 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 02:59:05 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v3 3/5] drm/amdgpu: extend UAPI for reporting userq invalid VA
Date: Tue, 22 Sep 2026 15:58:50 +0800
Message-ID: <20260922075852.2335748-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922075852.2335748-1-Prike.Liang@amd.com>
References: <20260922075852.2335748-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B8:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b34e52-fef1-4d48-8309-08df187f6145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|10067099003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jeJqV9cK2Kji5yhd4Rznv20pSo2IfjeLnlkyXMVEU8WlArPZ1GUwuBcl8jDTwQkG/Z+i9MdiPZVmOe+SsY8uaUcnjERDFep7ua23bTAMxQKg4QiTzatbc6qE7YrC5w/fE75tdkeH2ARYoSuuquy+5JquZVWiXU7TR8mAH5aXIXWDKlf0rjdI900tU/1sFqmV0TdZqCoT8P2bPMcD+qZbdVzJSiR0MxRlKBa7WZ+mW7yhZU6NM0D2bpW7H25tbd5Ayjwv4gYCA9+ewd4JENM6Tx/d0uWaTEPgK+A8FAo7xUMnxcdsvcEA4j4NuM7V7yrvH5idrQuWTmZJW9ZzFh5+llLlQfoa3D3muFHMpg5OxnYtYTdnHkrYhUuJ+Mhio1qEmjHWCpW8ocSWgVxADdxJiTjRhucXsF6MTlTAN6znNyqDhNH+SoRvnThFOUq7FhyU/1Oou3MLy98p4yNH7Q7GVIVzRhj7HyxjDKuC5+/fepDAWUp8KfGNHdcfoVa0WS4I3qBxZhpVo89n/NBb1ItLnKeirvYwhN3IOtz11cNEcZHC961FaGa7J7BVw0yAtD1oUW4FQ77kxUPDJpRaYqKFX22L/+QzHat07Ww8h7QYm7qAUOKVvDFuzAgwhrT0VM6b9mXopcaqvSZyELb3Ijhw47ErLYT1/I4VsYpUIExY+RpbFwtLTKcikO5t8mOi7U6LvO1wiqYdingYq0ttn2wo8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xVcJY3Da4G8VvuPzU5f4j+M++sQunRyqWID56EsDG+DY3IruOEggq0Rz3//jtr8kVMvGpJ2YmiRsozuMNeu+X62Anwh5MFfrzrzXXAB1/RtM+ptS4w47E5BclegrfqdLd7Rwo4N7ybroVVqdSuCOUzvWElHez9cbRIj0Ia9rSYwsmdhrlJMhgvExsHYjZBjYmeRulE2yZmSG2N6FLUt4rwysm+lmZRH96acyn8hkzVSwYqIpFF4shKUKSKUARMX5QZnOvr13NtL7BZXcjOqgQgP5eGIK9sC3I83f/sd7zm+bvCQcX11XxTzG2W062iMCaEIcI/vmSQjfh8e86V0RyPOVoS9sDa1ZK6ReKGpXcOcK1WdWtAFwykuqQjdpQAkCAAKYhTwSq2OgKxS5S/BvQMbMJfLn/KcgvFj+ahJhq8hWHapH6Utr3imJ75L+DHLq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:59:08.0473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b34e52-fef1-4d48-8309-08df187f6145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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

Add UAPI new definition for reporting userq invalid
virtual address status to user space.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 183ac26f2bd3..2f81ec3265cd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -358,7 +358,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
-
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
-- 
2.34.1

