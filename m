Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBBC606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uVx1nWtw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5C410EBAD;
	Tue, 17 Nov 2026 17:00:20 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECCB10EBB5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQYz4kBoEF+GCe3LcXbNeQbxOu15ql5lmtpurqyd9v0HrqNqt8hhxIYR/vxkBrkyHpAMhImz25tEpj2h5XFnL1t4vkTA8wsQkQZ+ry2D78wWqfBLQ5JoqFWoqQetJGHnUo9ZeYNPNsMPOKo6h/eRDQd6V9wiLWB+38KfGnSuiqRPtHAALGnUw4PVSNo2+TSMCghan/4ybw+cBTfWoTkspJts1Zyqj7UusixA+XwSh2NS6oI1CiktmNCDN/xYZ0k+kIuwChI4xY1Rwms2EqaU81MXhDpRjTle6hOo5snUb4qp4vKi0UyPQeGuOG0CzhRhlQgDhxnPkOCtK5J0l668dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxw0kvp42sE9TAeF2WZ1qMQmpyYgHQYSL24MtgeDDR8=;
 b=wQo/pTddMHDSBksvzfWh8vejNabgehIQ0I/b/Ri9HJDvyPHazMN7NL9qWFogss5Bkz4xhkQYmILptF33MR9ZN3LcsiEdZp5zGp2CVdxptk5Fb/tOzzKnbN2LM8ipeQ2vsl3w4AaF8SXHdnmKZr0l/v7/WKjPRorfXif0RD2ahpT72li2bKfzsDV4NVSy7FwsHJHI3wE3iEs/7H9tWPGb8hXvX3k0CWmDefK0twtdkQQee5jyXUlQ1EgcHB/CYdzcCAMBOVBZB9oakpNI8HJB3L7iSQs341UDZDM5ZXdkA31CJZcqZjg2C4SfWFlfYo7GH7qoUPPN1U34ugALbVr3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxw0kvp42sE9TAeF2WZ1qMQmpyYgHQYSL24MtgeDDR8=;
 b=uVx1nWtwrDpXapit8zdDhOw9RpHBLafA5/khM7utHTkH99tMGlScmVGYeSIZsd6rXR7SbDx15Weg0owCRzuovkABS98N8PgkSZUOplqlKZYA4G03fgewvWOfb8783jT15Es4pwGHG89BdwUFCiPPgTiCtW7liwmwQM4irzXanVc=
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:00:00 +0000
Received: from MWH0EPF000DD30B.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::3e) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 16:59:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000DD30B.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 16:59:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 10:59:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 10:59:58 -0600
Received: from work-495456.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 10:59:58 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [RFC PATCH 1/3] drm/amdgpu: expose the XCC-masked setup_vm_pt_regs as
 a gfxhub callback
Date: Tue, 17 Nov 2026 11:59:50 -0500
Message-ID: <20261117165952.3558762-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117165952.3558762-1-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD30B:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: e0acd37a-2283-419f-1534-08df44cc36fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006|261026121527099003|261021121427099003|10067099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 1OuCHcljwOASfbinc4veF55YSPgJaTfOJlfFzBxgz4Lt5yZabdTQ4JWSRqNOqTzJHEA+keKfhrjS5pAViwd1X6IXnJWDAC0lqUd2JZ6KdirmFwGlVnrsSripx6QBvfhUVWPk18KBvNdkkgitKsiy+eDt1i1BM161WW4lNQqnZzHLmPJlsonsJRDWEZG4C8DKuVIkWewTZ2yor73oZ+Upx8vbroKUXXn3jL8NnwZVWVy+GIMn04oQgChD7StjSSZn/mDW145soFBDvzOa5bc9orvvQrU65qDMLYagsTdEKVh92+sQYE5S9DAm2XAo3qPZLHkjjXA25ev2aMijb3yJpFTcgDk77A11brNYJrV0ou/huxyLffIPAYvbe50fYlikUFqSaAEWgpCQBT8C8QaN/c5nMWuCV0H4bFOWirOLpTaMInnbkHzrUGY/M3KIQkJ5JF0aQSkSp/qnoaSF+xjwocUGJRY60kNbPf3AGcfuuNWNAFc0zKrYXQpnPYQkXZAjnAl7ZFazt0WfZIInJ4CnEv5m1oC6Wkpe9aTAIr5tcK4IT6Z26wCTRCGqFh6s+Od3RKnIBKQbW5uXNx8pcOk9a68w4HpD443RgHgEIii4Ni/z1M4h5ft9ouSD+ukHGvsu3hgF3JBro3f4CfUUTAbLk0Uxv5gME18DVOyyitbj8S0IGSNqbrAvdab2ufg0xL7H5WcEoXjsrRapMQRpwVhlVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(10067099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c38FUzH2vBGQwsWgHAe5bkjPNhnZ4Gt37Ln3bl/GopZ9vxgo+2jL/TBdpD5eOjLqz40D22Q81KtAVuvDVymKq+mN0g4fDpX/ugziOoG6K/Ebb0Kds1fB/DdkBNGiK1nFyTbOSHhvxdJp8SxGea3Pd6iOyEcQ7UfsILGfP3qIPqfKbNv6Y07MhfYhEYD6aI5zOMEWuGBdKqMyysnuSOX9md4RXOYGPaAUrNk3+XAlt4lTKwjXfcNz0T6PZflupRH5B4Y6YL9c5DRxUIEDvTMCqcjfPRLreEtniAFt2LnikLQjGgDqU/QK+cVvTd9W/0A0RS90XMdCHWBYAGCRXFmV99GGfkDsMqv29XzQRVfizQDaqXUasukGXwMX0yHj9/Ns4HLFMilzrKCIXlJqd9ldpgXVCLvHx1pv7TTuA2VI9bbXBjiThIHHdELgWZ19fuqC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:59:59.4764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0acd37a-2283-419f-1534-08df44cc36fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000DD30B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On GFX IPs with multiple XCCs each XCC has an own GFXHUB, but the
setup_vm_pt_regs gfxhub callback programs a VMID's page table base on
every XCC. Callers which bind a VMID on a single VMHUB, like the SPM
VMID binding, have no way to reach one GFXHUB through the callback
interface.

gfxhub v1.2 and v12.1 already implement an XCC-masked variant
internally. Expose it as a new setup_vm_pt_regs_xcc callback. GFXHUBs
of IPs with a single XCC don't implement it, for them the existing
callback already is per-hub.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
index c7b44aeb671b..19b961cb12f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
@@ -28,6 +28,8 @@ struct amdgpu_gfxhub_funcs {
 	u64 (*get_mc_fb_offset)(struct amdgpu_device *adev);
 	void (*setup_vm_pt_regs)(struct amdgpu_device *adev, uint32_t vmid,
 			uint64_t page_table_base);
+	void (*setup_vm_pt_regs_xcc)(struct amdgpu_device *adev, uint32_t vmid,
+			uint64_t page_table_base, uint32_t xcc_mask);
 	int (*gart_enable)(struct amdgpu_device *adev);
 
 	void (*gart_disable)(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index b13967a1c8fb..7bc17721f463 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -809,6 +809,7 @@ const struct amdgpu_gfxhub_funcs gfxhub_v12_1_funcs = {
 	.get_fb_location = gfxhub_v12_1_get_fb_location,
 	.get_mc_fb_offset = gfxhub_v12_1_get_mc_fb_offset,
 	.setup_vm_pt_regs = gfxhub_v12_1_setup_vm_pt_regs,
+	.setup_vm_pt_regs_xcc = gfxhub_v12_1_xcc_setup_vm_pt_regs,
 	.gart_enable = gfxhub_v12_1_gart_enable,
 	.gart_disable = gfxhub_v12_1_gart_disable,
 	.set_fault_enable_default = gfxhub_v12_1_set_fault_enable_default,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index e89813590539..a56c072daf15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -634,6 +634,7 @@ static int gfxhub_v1_2_get_xgmi_info(struct amdgpu_device *adev)
 const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs = {
 	.get_mc_fb_offset = gfxhub_v1_2_get_mc_fb_offset,
 	.setup_vm_pt_regs = gfxhub_v1_2_setup_vm_pt_regs,
+	.setup_vm_pt_regs_xcc = gfxhub_v1_2_xcc_setup_vm_pt_regs,
 	.gart_enable = gfxhub_v1_2_gart_enable,
 	.gart_disable = gfxhub_v1_2_gart_disable,
 	.set_fault_enable_default = gfxhub_v1_2_set_fault_enable_default,
-- 
2.34.1

