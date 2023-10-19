Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302A1CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 04:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F08A10E0A1;
	Thu, 19 Oct 2023 04:40:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26AA10E0A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 04:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXyaKkhV/7rJ1DB3JgVWXhns1WfPd2NpaoROn6JXkvMwT/4UGrB2R/NrCTmwPMgOFOE/gAOhWsFIwJAtnMoUqtQvxSp/uIQhp1x9aSxkxTwVxeswOMLrrX2QIex+/E+IgdVNmhZuAvaw0snlXbCMHAD3LoP39qKS3mkq1y38LOC9Xb8HV+ZfrTUvsx8ZU992wRnJd2OiD4lok43RllwWZYz4kor+PtfNxt6g/jyI3xdXEDt4bcSgPRBP1lBf2xe/5MkMpnw6+l8jKDDM4UH0bWWsEUDUVTRfyp3rKNFwTj1hYfSrNGWJ8fBqDLFDMdV9JPWM07JCD/CZbmgtgxWQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A11HS91cEcJ0cNrqXr1ttM6JJXcYA0YAiZSr7QaDeDU=;
 b=ZOO0eQG+/EFeng9WFBVyzFft4ZqunC3fBNCtow6F28liuIVfU+hPjYN4k0SwUFrd/pzjydiDdx4G536ypT0n1fRC31JRly/mOjS86slvlJVSR2fGISC6SAXKvSbsOXS4gY6zshjSGA/yq2P44FOCC7SHPttL1b2KT/V+Fl6Ab1DWQHzNwndzyYk7lghMUrx/bhrGJpqTV1XQXGJ68JJaUL2UIpSNEYmwvUVhk+CCWr1aCPGT0ZAiph2RhaUJv2EDb6/Uug6D5/15Bej5wW4x2GsBjdqiw/y4qmubfoIu7KXfn3ns+cIfvz/Ba+ZdFP7sg2IGxbOm/tzIlCAXut2KpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A11HS91cEcJ0cNrqXr1ttM6JJXcYA0YAiZSr7QaDeDU=;
 b=am3QGQrPtRV+0Ab6nQCAEz3bPSqDU+p2ytSVg8dDAb4HqpK3A46S/0jVD4CSNQe0L+fG3WlfFaVB8k0WcE+rxC/YTydKOi5Y6yJjyH9B7d4X6arnLFezJKhxe6io2OrPQk/AzCPSRJcLfgewTn5+xv9WD2vkpIusb8rykZpOyoY=
Received: from MW4PR03CA0234.namprd03.prod.outlook.com (2603:10b6:303:b9::29)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 04:40:01 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::9a) by MW4PR03CA0234.outlook.office365.com
 (2603:10b6:303:b9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37 via Frontend
 Transport; Thu, 19 Oct 2023 04:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Thu, 19 Oct 2023 04:40:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 23:39:58 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add API to get full IP version
Date: Thu, 19 Oct 2023 10:09:41 +0530
Message-ID: <20231019043942.199561-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 188260fc-7255-447b-5076-08dbd05d748d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgJreyysBnwJARKZeIra556ruqwCYn8CIzZWjfxCW4QHJjB/a6rkQ9NCWyKO7cNnOefcU68HFqRPk6Y+8FiCd2J45b6G+FK84nWXSxObzzhPceRiIQBkL7Omn3BGFyo1io6sJxw1QHLy0DD7t4Z0Cpsc14iOsoqv8+UdCiEV237wTY9Ijn7CrJuu4EAOBcsZDLtQHlQaiNDyum1+ACW4p1BQ0YvzoGpd+cM4O0G5mlxrZrel4Sji0aYGlZeYC7H6awgBi2GYvSdIOuSunwSRitI7L2d9tWk9ScRvtatkjlUwaU/87pxR0tznxMuYFtqn1OMYIftkytW40IOb2UmhR+PD+aoHwdN7qWagwRvkzTtth7QJz231F93Wd7JnLHpHa6nTg80o19lZJnXDNWLVEY1Vn6JLxdC4f7EZ067ULV1BaMEwgZoa7XSa4OP9UMbN8d6+EK8YAAcT3QOfTZxE9etRVlk164F9IgHDENOY9BL3Iy6kprAoVM6jByQ/Wa31UnjkWQrJmy/flWHLRnu373CuvypVSMgYUYZcqira6ySmUcVpbhpbXLc69ShZJrfOMVO+aV9HYSRg/nuM2Plwnj4X2QQzSX4MlCoQg6KOX9gHG/+O3q80OnNOi0kzVxX6dqkVLRh786vGunYx+pLaojfKOcr1q/715Rwn1f+XHr/mlJQP7z5HwZCym9WKg973fBqabSuVFO66DQAn0owDWPHtbLheWr5Kl8nShFU0QqPSFSYZT6o2/t3o/YdEihmXQhmJwrSkvKZeDEvdu6vlRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(4744005)(47076005)(2906002)(7696005)(6666004)(1076003)(2616005)(478600001)(41300700001)(316002)(70586007)(54906003)(86362001)(70206006)(336012)(82740400003)(356005)(26005)(81166007)(36860700001)(426003)(16526019)(8936002)(36756003)(40480700001)(8676002)(44832011)(4326008)(5660300002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 04:40:00.7292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188260fc-7255-447b-5076-08dbd05d748d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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
Cc: Alexander.Deucher@amd.com, Le
 Ma <le.ma@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fetch the full version of IP including variant and subrevision.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 65440537def3..5d4995627939 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1122,6 +1122,13 @@ static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
 	return adev->ip_versions[ip][inst] & ~0xFFU;
 }
 
+static inline uint32_t amdgpu_ip_version_full(const struct amdgpu_device *adev,
+					      uint8_t ip, uint8_t inst)
+{
+	/* This returns full version - major/minor/rev/variant/subrevision */
+	return adev->ip_versions[ip][inst];
+}
+
 #ifdef CONFIG_DEV_COREDUMP
 struct amdgpu_coredump_info {
 	struct amdgpu_device		*adev;
-- 
2.25.1

