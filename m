Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCE9C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A95110ED0D;
	Wed,  2 Sep 2026 05:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rf75r62U";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7BF10ED0D
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzG1hGnISqSx+MgCn1lZp75U6HxGSMWUL+Yl6CrqxXnjbm9xCsqLFlCZdFDNEw4cwFVm+NDswgkx7t708LlbtOVyGCcvtJf8+HXDeevSIOVt8qhOlLnY1f1jteyYbddbN8OTN4wVuV+sVVCSRQ+pVAB6f2MVEJIcOjzTr2WM7wrxh5g5XZfeqdRTzjyiZwlXVsK6HKwl/o/YJvvmXGPP1dZJFLDKw1TIxmt7hZFgxDZGa6EjAsr4lAI+6vSROFB0tKma0XbNTab6F6icdDwZK0lwugVbkEvgZSk7plGErPEM7o56zD6E4fbN5igy+9fWgr7orbXWNZYYcufdSOEXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn7Pb2eRLukKnx8fgApXf7VwYNWkBZTMxFA86rjoJ8g=;
 b=yz+lF0RI1MmYN28ws8fkIINbmIoAk4c+y/YpMMF5n0ApO99Bhwf6SFCKiL/waIanxEaTpHG5gK1itLc9tDSz2o4CeXVNAVcCLotV2+WDeAnA77/hOuYNhKeUMH0JEflSRoL5wA5Xy5lJ6qZiRRneLJfiegVwXs7I3RP/A9orLQml372wwyA0craBAHH1x88vXxVIMu6qnBoffWx/fwo90RJ84IhvojQXVu+VXiVChfbISrzm3SUXP6uua40ko47Ne23K8lwrl++tdfPhwoUuOMtfRg6RFtRv7sHq9zKXsCgReJ4OyxlzArDouyaoyfyGMOtatQTboRVycBl6+Rqtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn7Pb2eRLukKnx8fgApXf7VwYNWkBZTMxFA86rjoJ8g=;
 b=rf75r62U+UBypMpZ41sUJe/xLAIVpLcL9aZvpMlX4kYXAU+OyPQf8ZM1qjVfenHjW2Mnt/lYabEjaKWCVL08k4byuzZKmbALMXXGQRn3JFnXch09/7YYnipF7XBhj6KUwdGNWWecoeVppMOno6I8UtzDgwYc/CJIKdUS4lkVh3U=
Received: from SJ0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:a03:39f::33)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:08:17 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::6) by SJ0PR03CA0238.outlook.office365.com
 (2603:10b6:a03:39f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:08:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:08:16 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:08:07 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 26/40] drm/amd/display: Validate irq source in DM IRQ handler
Date: Wed, 2 Sep 2026 12:58:48 +0800
Message-ID: <20260902050411.3473916-27-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b65f0da-c0d1-46a5-01e5-08df08b032f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: fhqpJ5zwLUEgjNEJOWWS3iW8uE+gRFv8wrFf4sSgBLbv4ZN/y8r9mKvU8FEou84kGOQRegITQNc7VF8MHLs4eg+FyBAdE+JXg3Zb9qtS1y08zoP9hzx1dun3pMu+jng27rSkBBoBvbnceRZvgn2YkFkIssBqWUZ2QWLnJ4PxGh1lZy0Z4KnBpljFu2wMjZ4ag+KHIA3YseLMEAQy4Oz6mOmeDhVECRhs1CS64VFGzqJSCJQzPkkD7uAC2bz6K8vy6E7bCRui6bEsg4evKg6VGu7GWZSKKu0xT0JZY6XyF6O+bR2T8snvm1kTdqB1YktGruJsWSEcd+e3xA5Z+ixB+U+k7fa7BFUlzbFEMqHPV3BYZL35nlBxHsMiaClo7ip2pmuXjACnfvoaouDK66WiWQNilbzI/cg9vt8FKRA8I/k+ie/8j1zkCKuJvC6SID2noLpj2nbru87rYf1USFubcQXBEIkaNHrp0Ql7xzsWaFIyIL3kMLkNv6cYItiT9mrCA322rCDTUO4fn1Wqv6DcMj7+/Mjjshx3QPZh1rbdDQXSixwsBOQi1K1OMsvAOP+2AAjshbhX/JzVMx4mAbLP1Pe0vr27uTzO2KfXCB5DIveUW8+U4DmymJ1le+jTpvonh4lZ8ceycUxwiOC6BvVNZ+Iqo3O8H6cvTbqN+dVl7MZuoyHpQZuWO9Zc0bJyk7XiAkeTZ01PyZDqz8hmUx3fEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dcOPtkc83lOENq6pnr9Rst+9GBLx7G1i6Nz8NuLArhWxM6xpen3U/RrUW8fFOKxCUmuKnuvdARTASu4c7oVfTMhv4G1Mg3V11CcAWOoDY6bVimLTxxENYPJOF9k5Qz2xImLx4KeJ5W7Ozy2Zl4zP5JrGTHHFUzQlvhPGVpj09B21gd8z32D88XHlxvUweXFpE7vBTjpD5lhIf3qla+In6e3XPVg0+rAH7b5juSmMOIrdCVvPIOQnYkBsPgo9QLxWuJ3vkAEwNoFSwt3Ysde1oI9MZFGMFrNZk/VgU0nzRBsUZ+/my0HuaH7TLy2CMDwgYeOSzg7JXhgLbGaEXflAYxuWIXK+4ZQnjjhNqvGIeu4FkMSI1SkX5SWMdQAReA/qRP9PE45XkZBJ5MfjkzGBKz9OZB4cLphTLp6EDY1Q9Dhi3HbQ6OA4q00xe6zKFDq7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:08:17.0545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b65f0da-c0d1-46a5-01e5-08df08b032f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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

From: Alex Hung <alex.hung@amd.com>

[Why]
dc_interrupt_to_irq_source() can return DC_IRQ_SOURCE_INVALID for an
unmapped src_id/src_data pair. The value was passed straight to
dc_interrupt_ack() and used to index the DM high/low handler tables.

[How]
Reject sources outside the valid range before using them.

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 546911b152e4..f997a50c1293 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -713,6 +713,11 @@ STATIC_IFN_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 			entry->src_id,
 			entry->src_data[0]);
 
+	if (!DAL_VALID_IRQ_SRC_NUM(src)) {
+		DRM_ERROR("DM_IRQ: invalid irq_source:%d!\n", src);
+		return 0;
+	}
+
 	dc_interrupt_ack(adev->dm.dc, src);
 
 	/* Call high irq work immediately */
-- 
2.43.0

