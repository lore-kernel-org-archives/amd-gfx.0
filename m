Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE261C98321
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 17:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9157010E0CD;
	Fri, 25 Sep 2026 17:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vIXfBjuf";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CE010E0CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 17:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeSJqQTEZRiqH7KOBXZ8dSxQQh8EsfuRrKtZG6FdRs5sQoKqk3F4vUB0+okGDZzU6H9HQkeqrskfcQJsRdD3yJh++h8q2fYbG2oQnZbL4MJ2CHLCyLAeUGEuIsLfYegGmTsTx0jyi5SbHyr3M358sUnkbro/FLtnqYMwkBHe2+/gv43BQoVrhiBEBlw05j6SXBmw7BsZRV0iLaUOdFEhZlCTEMVdfxYF7RaW5bn6t4XPEwuETZDn4Pn/AE7OaqY4Q0D0MLGBDggUPHxSzWMuiw9P2meZmMdQ2aGuWxiibUmXLQ4fDCvZuXUZXWMQ/nfdiL+MIiBt9I2KfOtR7IoYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye3YUDBkLUGJwQeD21gqCQd5/mR3tdkuR68+LEk4WlY=;
 b=UK+eDQsFXz9KyxdM2IvqFLF8GCopdUqgsoN+JJhnRhHoaToadzblAMgKufBqF47nWpLRbHixTEqaux6dabATXg2zI80WbdAKAqPtiN40RqJkYqPnX0fVIlZU5XYiTYuptfquLSUigcsZZalT2U7C7dDjSnHyB0Sluu9l/ddXeGSHwphe4sdXKZgR0MzDqU0LgCLsHp6i0IMbn7OYoujVGxbZi2TZA/urh7ei8AG0R3Bjnfij+CQFI6cMkN781KGJDb27NQB413zo3MgItv5fA4nzgNhCoPSJoCbmAV/NWNWXo8D3nkwCb+ccGhv3m8nkYPb/zoYjlYOa5Fa3TXHzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye3YUDBkLUGJwQeD21gqCQd5/mR3tdkuR68+LEk4WlY=;
 b=vIXfBjufSbE9WOzIub0ejnzaehqOjrJbsFDaRg1TFoMBN05yh4KLLseMS5aPFqLhTQdyzpAcoOQShnNucdK2lQROXYT/7jWOjEFASihLZg4ks/UbHdpzXbUDxJSuWSqpZGHWlsGVgAdKMkqvU/u5trXAtKYZCGjqs8IMsDJSY0w=
Received: from CH2PR10CA0027.namprd10.prod.outlook.com (2603:10b6:610:4c::37)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8df) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 17:50:08 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::ac) by CH2PR10CA0027.outlook.office365.com
 (2603:10b6:610:4c::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 17:50:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 17:50:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 12:50:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 12:50:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 25 Sep 2026 12:50:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12: properly pass flush_type to
 gmc_v12_0_flush_vm_hub()
Date: Fri, 25 Sep 2026 13:49:54 -0400
Message-ID: <20260925174954.2931256-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: 149219cb-af06-4029-8a0b-08df1b2d6f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: fOYsqTWHORxm5o0IvTmsuGaSTkS8YYMqPG3jgJk6zTx6RTmYsMMf/5nCSZqQsjC8IaoqebFZ1s3xmuWvMlkBBbojPq74BVILaBSqboNfQrAqO2ovrqwQ+Vyd1QWUX4y3B8MYGpHS0OhRlt0Bv1r1rEVd7o03B+RzeiQCKH3iV9sRx7Yt6fX3DI5JZ3r0JLQ/F1BZQFcWMZ0BMCnlk3N7nGmBGLO5WH8xgdeQvNlfiXm3RRqhrpnPL1Rk1+FyzJ7/NJTzjxJuViiIIjF31apBoLIrcvjlv6RG2/p5IwEKuh9+OT5+xjpJWCx4U8mNYjaytZV/ecAbDp7aCCtynDplEUeQ9A6wm46bGDKe+YkkYlwTjF8jRQSEPpUHMEfcrG8Q5hXcf7ma2gbmmuomv+Kpq7vkRTN009IySKrOJCceCrJRlegzSskgcxhTIhRuIXd2+KKQN2sPN+1qLO2TzXylpv/0H3y+sYgiE2ochYdWkhplUoHgKEyvmGdTxSutOkWgTseKCGtnDYyNje3g2JcogP5saH/WVySMRWKxw3N3PdP+NoC6uNMPOr2oEGJMqw6xOpRZ3qQ/v1NCBjLkHlOkMdm/Ev/+jNTYReWaTp8XPMq+g/vh4mZZsqdV2SpRQtT/88ccW0q8CMez/e8Xo0yxpJ5BfIMjcKQGllEELrYKpghgGNY70sp8UCYwYWZGTagcMfXWX55D4JDxrsS4F6c/Gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xXB4OvAlmba7brxj8QCHdgPjw8tl/nX13eltvaOJH9m/28fi/UmfNz379SeI4zdZfYyAMFQRjf5wgRIuk1+bCiFnakmSZw30wL18hKS5ThjmOVoclVaRZegfX+ARZZihaau/uTfVpkfUjW4Ybdl54WX+6NwDBeisyBrHnCAmkETO4Jkpm22gU8L+WNFI6kn7lFUkWEhXXi/H8rz337mWZ0P0Mw/W0dXyYGGpXp8Jj6Kel737dcKAcbASyS/W8Aip0TYcOcGah//AgvnkSSRlg1W/j27HgWjB8iqA1XsBGEB9SbGw9HIEJFQx3yTloPOYNNwPRv4Nth0240oL7YUfiwZDUPMcXQ4RgBdO4umDdF23R7Ub19JEer3s43Y4C8AT40YWAjkiRbOL5EboAtfxlDFBR2hyuheeYy7sYfe5YPnBQ95Z1Cfw/qvKGySauGLT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 17:50:06.0007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149219cb-af06-4029-8a0b-08df1b2d6f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77
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

In gmc_v12_0_flush_gpu_tlb(), flush_type was not properly
passed to gmc_v12_0_flush_vm_hub().  This only affected
the MMIO path.  In most cases the flush would go through
MES.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index d7f56bbcfd440..8e3fe16668c9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -331,7 +331,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
-	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, 0);
+	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, flush_type);
 	return;
 }
 
-- 
2.55.0

