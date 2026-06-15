Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661FBCD98CE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 05:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB5410E1BF;
	Mon, 15 Jun 2026 05:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ncqETvRL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B5210E1BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 05:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIqUB1AJS+6P7aXbTvk9QIkxBUltZjjlRjGh4ZddR5oleLYvMX+mZfbKeqo+1XYFya8n+8pGjfoHSUvdfUwkk+G9czeF16WKt7XVPn5vcdH1kFKat1JDQrIlrSIrgEGNLQ/rq31PWYJ7hMXZL/YyQFzGW/KJcaSfWl8f8AAnQ5jgKiof1ooeju5c2/hEmE17yPPg0UoC5cr4KpTHkSa9Qroi49goDw9JSWFK56GKYw7KN2T1nArF+JhmIIguBkglY5vBVkuNtZ1b9LtJI8RSCB0BodZRMQ4yqjHmC9wlxDcPMtHDK5RlVbszaemLiaF9ibZiLI/I48GhRlMRp+qAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbMLAFaLGhrCPwN7cRnUuNMeu/9lgBCSmNL28hxEYs4=;
 b=l4H/CeHHjI2FD2x6GIdghyM6c9lYHa+9a7pYgSs+vIajDA1QqPj3zlfjhpnSCtPn13bNNshIGkgjEq/nMRLy+zQSmw4oxjTttwsodo6TZQYNJJYT8vReAnZz6pGaeDk7WFXznKZOG/3HRltZNcn3Wye3LlOoWTGTqPjQTKWvM/jMPj19dmvMeFB63uNYQLOvPnFkgoAq9WN0Xj22pBOTx4zI2TR91FQiag2ZUc6i1EYbtPP0uJWuFrX6WvRVI4krPD7cqcXeqvjuiQgEGA7VrXxsB74WfncVZ6UlBfVfSqYrm7ekFkIEgmV2VZV99g5UJijggpuW1Ct7WHS27oxAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbMLAFaLGhrCPwN7cRnUuNMeu/9lgBCSmNL28hxEYs4=;
 b=ncqETvRL0KwY8aD0GZMdezstYFN3Nl2dDZhddboXuB+kvwu2ldevhHxB8pBdNngTffsI/eZipAd8NDlyAth0MYVa6Mh/9w84uTyOydXrz7RGNZpJAxrEay1wwVqydZd64nt1UODr/VX75WiYS8HZvhxwVwvlo/YFpKBnQH9HPss=
Received: from PH7PR10CA0011.namprd10.prod.outlook.com (2603:10b6:510:23d::12)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 05:39:31 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::a8) by PH7PR10CA0011.outlook.office365.com
 (2603:10b6:510:23d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 05:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 05:39:30 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 00:39:28 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <candice.li@amd.com>
Subject: [PATCH] drm/amdgpu: Add checks to vbios fetch through ATRM
Date: Mon, 15 Jun 2026 11:09:11 +0530
Message-ID: <20260615053911.59876-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 878320c8-4d27-41d1-573c-08decaa07929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 7PWOSUmsRNHdKYLOlRCGaBJ4m4m2Gx9EXzTMu8rCRA4FuMUxW1PZhjFYqw9v6LiheubxBEaWWWvGDiBoUWLPJleJZbEDPean02y5G+qUuN+yE/2RgBqp9TClV5eqgNRDOlKw0F8jIfAYa2ewpJO1/AHo+NC/clATGUlFaF9ZJO7bjvZ+ZquPDBwby4bwaNko1HBCfAlKt8aFgXFKaI8OXg4mR8Iacry1c5919UtkQg64gWklusx15WKnlYol3neAWiNLv2VNWW1vkzHQ7QRXl8HRIseMPllkeMZKxVgMh7aS/7Xw629I5TAqx5EccYrXRJBVci1CrCQ8coONrFXngqsFu9sPMoo0mddphlSkUVmEFmnDR2EeLmePAmxEpbp3P8NCfnrQKZTJk0RVi1Z8T+uuQQj1ujoy9RB1u6K+ibcMiOWTT5iz3xtGt1+YOZ9LXFOqDDOLDAJXK9FX0OrSwDUvNWJSvzn3jh+zVT1cptzrV6zPn/Uz0g3+oNNoo4yG16yTPs4GTuH6eKx7LNWk5QewIfpmcl4xWKLVysNMZvqj2Q1ELv9ox/UdoLdHZE9nxgDZROtrQo9FZzMVA6ux/4pLOV+WESlHDMgNSQIa1mRO+Cqbk3/5iabLHPazUkviSZP3xzOllKm03Hbyr7DBkOQw4/+gx+rd1O4sRgAK0/ejODOLOEgqsj/FbnvAnI5MoZcQpHD37e8aOOFnZpI8hyK8GhiZbsW+KN/tWA184ls=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jopGSX3EWPY8/TqkHBGfgKD0EwBKBTkLNpexHeIj7KJ4EEmpTVjc2osxq6bgza/U0Pukudg4uZPu/O+FMQowUoL8IBEu7LThGTP2ItYXaK6v5oFKGV0l7ZqP6J7YFoNJ10KZu8GG1Y02cNgtLKuM0JfB3dhY7Can+DZC2y3L/frIQ2AWneKLuTnTSMWCYi58t6L9XNEyiS4cj0PX0jKnlZjhTZm3pSxp0QnYl31fdForEfxIdXcxBAHlAd3sAmlPJZ7hQ0/M48J0PORYOZkUmcyBMbrsX2lxTL0r22WscwT/q82lLalmw1ARnyM9vRyqiwiGozhZpT//JdDGEOSMMzAK+sR/dy27zvdLLEaHBFDZ9xeRqkiZdHHkl9g92CMBovHlIivl9I2SoSH2a0n001Y9bbYR4aKxMBnWMX+QohxVm3C+REnkETX5k2mNqxR3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 05:39:30.8885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878320c8-4d27-41d1-573c-08decaa07929
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313
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

Check if a valid buffer object is returned after ATRM call. Also, match
the buffer length against requested size before copying.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index aa039e148a5e..3ebdd792feec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -296,8 +296,14 @@ static int amdgpu_atrm_call(acpi_handle atrm_handle, uint8_t *bios,
 	}
 
 	obj = (union acpi_object *)buffer.pointer;
-	memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
-	len = obj->buffer.length;
+	if (!obj || obj->type != ACPI_TYPE_BUFFER) {
+		DRM_ERROR("ATRM returned an invalid object\n");
+		kfree(buffer.pointer);
+		return -EINVAL;
+	}
+
+	len = min_t(size_t, obj->buffer.length, len);
+	memcpy(bios+offset, obj->buffer.pointer, len);
 	kfree(buffer.pointer);
 	return len;
 }
-- 
2.49.0

