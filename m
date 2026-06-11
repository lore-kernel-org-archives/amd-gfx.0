Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C5BCD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 08:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7894810ED87;
	Thu, 11 Jun 2026 08:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZllDDyy";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011055.outbound.protection.outlook.com
 [40.93.194.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890DD10ED83
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 08:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8ESFMPtiSfdK87VCnLNmamsNGBnGeSMQlH8BbBG/YErNyB0XwDuNrGU8AeLWeaFOklLTCAsIb/kH6PPJJcvArAlcNyPmzRCHmtsPB18vE7tJKVh/kEwtvHjo3NdOGeGMSQK7C2W3joPOrK8CZnvtzuflroAOHdhWrvSZChCVyK87SeX4y1VR7MWaDYXjSdmgL8I4QbCA0STog6+zdrXdyPVDBXzaywIavlogjx1xxJlfK/09FR0Yid8W1BkhdGx2rsdi5oYmOaLHXiat4zdUvmJAC0YvQQlLXI/vwMDHNn6Y5mHCB/hXCdYdUqs2imC5R9jbtcVt0PW1kxyZ2JNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFBki5VIrCBKyajjRQ4Z5NVawSr98xiX9RaOUgaK9Rk=;
 b=ywli/MKTgdx5ScrXU+VpnUuogsQieq5VqDz0nwCt8veu28kSQZtjTBWEjRlKcSyympVkmWZXAjCl7z5yvCcLqChYAXm+RqsB+aKfUpBuFo/RXZ24v5pfhw1blOuZ6JPxypv1wdxlQSHz/7y/v7kIhdguEIQtPlQ5mLZX/czYp0SzTGmBniaO4kbgY9CIiwYi1RdgSF7x5VCiW0Sr6WIrT3XLNrfaJQWR/VsNbplhvRM5K19B9bVgxp37nYfZCrKG80UL9bzcdEC2beYKvgufO0RLOqDvnVjhPwcJeOy/Y7xburZFu4yUSdPaYtM7caM4LeQ0Kwr1y71LOJaB6fs4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFBki5VIrCBKyajjRQ4Z5NVawSr98xiX9RaOUgaK9Rk=;
 b=PZllDDyyTVuVinv5iTFkLkGFH26mB97Nj0MKPkKGLWJXmW/iIIzz/z/MKYZFpEvjeUQqPGAt8OwuaGf1ZHxmcsSiwDutRIt/TaUAixhzpMp/8ege8S2oaYlHDDPGKRiilj9MpX+k8iQdXomKllyqgiZ2P7zn9uWcgSiojgaf13o=
Received: from MN2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:208:1a0::25)
 by SA5PPF5EA4322E1.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 08:33:21 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::46) by MN2PR07CA0015.outlook.office365.com
 (2603:10b6:208:1a0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Thu,
 11 Jun 2026 08:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 08:33:21 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 03:33:19 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: set the userq xcp_id
Date: Thu, 11 Jun 2026 16:33:09 +0800
Message-ID: <20260611083311.191012-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA5PPF5EA4322E1:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bb9109-87f9-4acf-c03e-08dec794186c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: NXosiEyMxEIDy9zjuzUevVnb7aYYyg9sQ0W6MEhQi5VI5ZVTKVCxv6COOdXRGmY5B9KQPpFl/Diw6owhtLH3qDAPE/dUZRlEshi8U0Xar1X37BeiurVTjMqYCt2Vg1DM1p1hBsDRGrOyu1U71POsJFrVCwzbDta7J2RwFKVtmnYp+bhPUf4ujnm8VrvgsMAjrdODMHzjUqUizHEGewiuBhem9b5kg24+ZdUyC1W2O3ZdHB2F05UDijlZQIwQbINCiBp/iNykqD8yJg3v43j6r0m2lo9W7xsr6Pk1hKgXh93WxJidl5XY112v6Wf4RQ5jK1UlwtWe2KwLOn+C9bpjsHlhFyuU7s6xAId7Fte0ngsHsiKoxBbCBjgkU6v+R8A0OiOCg8YN0gVmrcF3J+/XCNEjtpm5MhlX11IkUqimmwH4TSNRKE3ef7+IyxNbuyFEAFX6mN2InSF+E+OZ8eOxS6WqWU8/3UrDvYFEfa6rE6Rm1/72++Ko332B1Qcwwdk4NSdsLdm3Eop6IuC2EUcuTf7Yd5s8lA06ltwtz2fFbAw45KqmOw3RskMcUgDqzSvh61GWjiYBzQIzYtAIV7ZhcklfbCgybBFmF/IQL/K49cnDzJ/cUEjGDVguHYvGJz+XG+sD6ohXhL0P2xk/Jd9FNwmr8XT2oH90XPHpNHvBc4UEg2T2YJKkZzlzRoeZbLXki5BQoOclU8q+LrSjseiWWHI1gaDZu1xceyVPA3KRKx8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fmKjiw0zVQ3T7yqkKiPyDeOastD6ZGX/nUinCGIVL0MSt34OPkVvC0viB1lEtpE1u29/dAKm/bno1eP481me27bgIb/jMdZROAbaAyuJqESrZ9/fa06KUr08kkeMOGT7ajafTvF0KKSQBDKdktaC7mrHR3bOgNzwGgD/5/SVcuoKfx+Ou3zIANXuuSmVaT9B3CYw05HXwDp/QzPbn+WBtl2UyPRTFm6WVTXf9eqUi3Ueqf/DQ8y3tmhS4Z0LuMMOZGeRdfbbKbJeGvykvSP3S5mbc5+IBpk5/9bogAowJqJG9nmvJy75F9cLqiWxF6EDNSuBdoPwoxW5BOXjBpECvwqKVBijHZyxO3phyYbiBM9hd0+zz902S9AFowAWQv7YUVOh7tRgPCuYIDtYZSLHL7admSIQH5Ur2QHllI3m7BEbmPJ2bAxNl/KqPm65UsA1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:33:21.1638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bb9109-87f9-4acf-c03e-08dec794186c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5EA4322E1
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

Initialize the userq xcp_id.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3d6b1cfeca24..c1175cb6d242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -585,6 +585,17 @@ static int amdgpu_userq_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
+
+static u32 amdgpu_userq_get_xcp_id(struct amdgpu_fpriv *fpriv)
+{
+	/*
+	 * The enforce-isolation userq path uses idx 0 for non-partitioned
+	 * devices, matching the gfx ring isolation handling.
+	 */
+	return fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ? 0 :
+						       fpriv->xcp_id;
+}
+
 static int
 amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 {
@@ -629,6 +640,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->xcp_id = amdgpu_userq_get_xcp_id(fpriv);
 	queue->userq_mgr = uq_mgr;
 	INIT_DELAYED_WORK(&queue->hang_detect_work,
 			  amdgpu_userq_hang_detect_work);
-- 
2.34.1

