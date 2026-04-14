Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E82DF9D0C9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 12:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBD510E5EF;
	Tue, 14 Apr 2026 12:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ipx5bJOf";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6C810E5EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 12:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAAGru7oMPnOrt2LD68JTioLFU2os0+KdUjNWB+QNO5lQ5homZQ2o23HoS7m2J2WZeBbmlO+XwhR0gQeNqbFValp1Kf8Mw18tpbrXOWG5Dl15EHMwe3TZswqTK1K2ntXgrMpBHnu6r4f3zchEoQTplA1u7iLFMiUp7PP9VgzM9Iq8JUTgxR4I7/LgulRjpiv2zMEwveCBu0NKpwaKbihEnDsMdBLgTBLMCYvxNPDVWKQqvoNK1C7rPto53+dAsVGu64C78wCCeJy8jYEeGU0pmbUcB0XcWXS8UBQpaDf25RCAcNbXk9i3eKgAyCgViXtSxAtDhJxD3oyw8+nXdLE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmLc/ilF2rWPFTtNRWnSUWH2707klSFpg5/sftPl+1Y=;
 b=mnrecIiOVjKFY704ATzjXGU6FXp9bY9GC4P88Vol8JT6i5eyF4ClTFXypdaTf7wa655ClVmBoRiqH/SnnRvZpgSvO2gYw2L0iCriTtuWGGf9kXJC8QXcARNF9sXGRoeChbk0oFKyd8co1Tx3gI987S5KKNFYEoc2vkh8Y+A/q0x1DOggymOG9mkgxR62ZC6rb75CIaToDWHDNfVOWTE0sVOAp0d6PzRAqETYsXyyxsHdZjc6n5wFF6eogqQfBjJXRM3zHnTTJx/JZNMVaNIjvLR45qLhGngNCqjhVif/7UOzo5egZqkFtxogheMpTPBmmXFsYRwfl9R9Q7VqRafBMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmLc/ilF2rWPFTtNRWnSUWH2707klSFpg5/sftPl+1Y=;
 b=ipx5bJOfwXtljHbIbz4RDaSMUEUDaFdpVb9uyoaV0h3kyqI7Hx6khgtcPYJVO534XFrig9lwNw70rY0xsJXl8o1WOola9KQunzG0cMPd3ySN032UhlTyVABgA+z/jr9O/qXJ9tdA57RV1TlA1H6F4OMBaIjPZyNGn2ewoM+FXb0=
Received: from CH0PR13CA0002.namprd13.prod.outlook.com (2603:10b6:610:b1::7)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 12:44:01 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::11) by CH0PR13CA0002.outlook.office365.com
 (2603:10b6:610:b1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 12:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 12:43:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 14 Apr 2026 07:43:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 7/7] drm/amdgpu: document WAIT_EVENT condition semantics
Date: Tue, 14 Apr 2026 18:13:22 +0530
Message-ID: <20260414124322.2335906-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
References: <20260414124322.2335906-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: e13ac942-65f7-4fe1-b2ac-08de9a23803b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +Ak6aW4DbqG6QtbBZlu0zH933unb8GQ35eAvdou5c5nvFCbGy2JZcDdQbGDCac2Sf27JSpxC9JR/EhTniWj2pfOS1RPWopEkbCCen6rEmU5kmAiYyY8AkAO+nNk0DSVtNru10/UCw9KLfWG2hpnWc0MiGXJhdOOgCJ5pfNIyxEgGGPLiGm00r4zyc1UAswxSvxV33Rx9Q1rk8Htsml3/lPJsvxoZdcIyy9RghrYd3ejxHwFU83fYqPp7QrqE2H8IvrCK+JQXFrREzLuR57tlr0hY+86SKCWsZ8zZ1xSKRmgJRW0RbZtFxfSj2ESMz67h2zEWn9GIdZo4EMNAuSmZZSBz5WFZxcQQeczNjvQaSV904DRKlYA+yNy2o3W3zaseSSx1EQH6OQ2NaqKI/Rf0Yo2Eae4jEcJQZG3mr4KV5KG65Ei/KSWG/dS9Cvul/eWKMnFT7hF0oU/Vt1XS5orrSTsDWKpc0jz4DyQ9ITw/W6QhFuBqnKicGGXWhbvm8VieLXh6zyo1zg2dHr/hlWnj0ry4mwzDIE4FFPCfChZF99wEG8OfvoDl2Ijmn9qOG49aStFS0OU5Lm5PbEdFTer9ISb6jGbde/fcgP1fpWx72cn1rQxrRcyHMJKnP8gd98nyeTEcVZkRkB1riHW63A3pSOj1CQUCvAywG5UOBqRx+FvWhe1eC0GHH+HmWxVH/jyk5FIvyFUFrV2352ZsXkDkqgsZic+yUSfr6KtHxOQvBktXs+Y2jH5/Io9Gtk8eRQ30IhZyI0NmA0xTNdKqFSiKdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EmSSt/jSRx/3duUfUilOenjwb0L0XnTrRWpj9AsV3yfn9I0RUnTMkjArkWnrvo/XiqJG7z9cPoS4I8d4FUvemcVAzIQSBgRJsxwzksVEGyd9zWLoV0o2YXPKjRKA6xq3e7GlHUk8dXh6fo0HTiiBBwixWYFhBm3k2Uig0YgupCMRT3unJaN+X14NYAQx57rf5kvWmnKuFpA4PZUyBQtZmhRNVemA7WsHuVwfyBSMBUyI10F8du+z53XEET/k7EmGzBmB7WNbLZvHrAyThJqQckgTS8GiuAV8Yxrj3Uj0yeKuODZOFHxxvqaprdUbEmecqz/KOAXCPZlD75rwUrIg7/HL/ROhoZoF+Uiwi2muq1lBnb68MwI5T8QbmJzXLFz2m5eILrrMQKX+JzBikmUYTUmNiBmr63MpJbBNxcInxq7XJHxHSC4Hxcr5tSXWGlB6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 12:43:59.8594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13ac942-65f7-4fe1-b2ac-08de9a23803b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
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

Document the optional condition semantics of WAIT_EVENT.

When condition fields are provided, WAIT_EVENT completes only when both:
- a matching event record exists, and
- the userspace condition passes

Matching records are consumed only on successful completion.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
index ea1e780c3029..5fa8649981d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wait_event.h
@@ -23,6 +23,16 @@ struct amdgpu_wait_event_mgr {
 	bool dead;
 };
 
+/*
+ * WAIT_EVENT semantics:
+ *
+ * - WAIT_EVENT matches pending records by event type and optional queue id.
+ * - If cond_op is DRM_AMDGPU_WAIT_COND_NONE, a matching record completes
+ *   the wait immediately.
+ * - If cond_op is set, WAIT_EVENT completes only when both the record
+ *   match and the userspace memory condition pass.
+ * - Matching records are consumed only on successful completion.
+ */
 void amdgpu_wait_event_mgr_init(struct amdgpu_wait_event_mgr *mgr);
 void amdgpu_wait_event_mgr_fini(struct amdgpu_wait_event_mgr *mgr);
 
-- 
2.34.1

