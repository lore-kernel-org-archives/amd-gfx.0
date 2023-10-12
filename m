Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C387FCDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 04:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5076010E096;
	Thu, 12 Oct 2023 04:58:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64BDB10E096
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 04:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggmAxkEZA5UbKcentuW4h0EIPOQNyTJR+Fd427ch45jnTC0UjM3GES4LZnvPd3hbz0TOfQmuf4/73yKa5uDeUbPFPlyi+cc3XqzgjbOVei8VX0QMokq2bAVCRFaToXElWuJfH9GtapgB8PW/561Ui3sENC1sWslEFkevgqd2nnj0/u9zruUJNUkVPas7FWdxtAOyTaYDSRoHVkAD5aK/msUUP6NRpu1kjwHOGPMfrUbcBG06SFxBLRWfB6/Ab5Z5I6sJEOgLgZQ7sjgBbZZ+u6VMf8iEmrKgy24gcYFGtn25VFBG6e2PhVOhxFip3KBJM2t4XIGrsfiLwr3nuogCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq8x9hmXNtgFolXXbkhm4gzlB5b9XW/Ls3ARzQZNsYs=;
 b=i6uvwQ7hgVmELFp8bqge5qImhhD5j/dwiGPFHzrvK12SwRSPwftn9ZH0qBh6Xt6gdTF8lMnUPLMbHC8hgOB4NUHxdNjfi/+QX8Wq7Hmd16QzzWr5WUPX1/U5hlAOEjEkWTC7lQ2VtpGgFcHzm/kg2BBKyUi+wq5PqyKbRhK2nut58/1xkMvM2wu2ZIfx3o70owgfJzX9KfPZXGwSnfaUwD8VCW2Dpw4NfY3xHx/gFOtPSUY8jJe8WLJ1zskOLLxnSfORM5LCbZjr7VI5T/D36/3+MF47qiQmjtseMOUaUQlKKk4XX38aEmIOH4a/y1BIBZV8LPlazllZwmEQP80Q8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq8x9hmXNtgFolXXbkhm4gzlB5b9XW/Ls3ARzQZNsYs=;
 b=S8HoicZ9pc97UMxiaKXG/+khZYRpbxwK5MZmAPPz+tVYb9dI1UJ3vLN8OrXpuCPkJvNjRCyE+JxUnm1Z8h4QSgqOT2+WwnqSSUCgii71GvWME4vcaKSF2S0rzuNnI5XzPOUYJVkL1mPP/m/pACwH7X/tzfVsr5mhY9aJYKa3lRo=
Received: from MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 04:58:13 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::5e) by MN2PR04CA0015.outlook.office365.com
 (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Thu, 12 Oct 2023 04:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 04:58:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 23:58:11 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: Update PSP interface header
Date: Thu, 12 Oct 2023 10:27:53 +0530
Message-ID: <20231012045755.111418-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c404bd-48e6-4954-93c1-08dbcadfd6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2iY7dVVhtqiWoGhAdQ5/kiolX1+S+CpnJYue0HZ78GwuXZD1DBzl05uSXQGYzN/OTWBb8sjG2/oSo9OkTXN5C9yShv6t612n/dEDwx7Ah0THeGNfSywsJO+US8uMIYsXuhnIejm+X76UvuP/Rx6OUSHvuI6lL+5Za+f23YOSr6dmmBljcE6u55AocFcxKAugfIZmeobB8WKau9njvqC2Chms0ZCYUwlLV7vgQNIF2JNZQOMw3zIcWbh6vx5a7v6XZmJ1gdEPen31uNPDFjs4VUKTbfc/yGKfSdorSL4is2KcO3YK9dPARiq0PZKDylGy9F6RO6XFmzTG4GrsmqzyJBrbbkdRrUT0rP+xi4U5A3tHUvKKnZ+wj4OtTI78KNEHcPFPRRUByE15kVXGBKBbB4XodEliugqwjaTihmozVsJe7TdR7DYO0v2UwyI3PYxQWJsnegcUAXf8UrG8SGHoEefmgRVX73cakt8FJjKysTJAC3mxUt9lXmdHGtAnwPwug7s/8C4uAv9kNyKSu9m2JE0poFq4fzAKXhdppxlMc5XWdR4wqI3B7QUAsWaPp0v2zKMviPZEIfusoIqQDtAhs7v7zEGBqpcirMPZw570OU4bzte0VTNQOhpLpT5RoeyqZzedEkQ7JHaQ8bMykY1JaHY0f27kPOBi30dkeCsn4l4+NryxOdzexVH3FekiE3r8wpxrErwR/VujHnyuB3ualzqvWuehRpRVK1dsrddfwvEUB6cl1EBRSvPlimyV31BT84GlOesGntEAuzQwiurzcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(6666004)(426003)(478600001)(336012)(8936002)(8676002)(4326008)(7696005)(26005)(16526019)(70206006)(70586007)(2616005)(316002)(6916009)(41300700001)(54906003)(1076003)(44832011)(5660300002)(40460700003)(47076005)(2906002)(36860700001)(82740400003)(40480700001)(356005)(81166007)(4744005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 04:58:13.0175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c404bd-48e6-4954-93c1-08dbcadfd6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adds FW id for P2S table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index dfd60db97012..4bb5e10217bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -296,6 +296,7 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_VPEC_FW1                        = 100,  /* VPEC FW1 To Save         VPE     */
 	GFX_FW_TYPE_VPEC_FW2                        = 101,  /* VPEC FW2 To Save         VPE     */
 	GFX_FW_TYPE_VPE                             = 102,
+	GFX_FW_TYPE_P2S_TABLE                       = 129,
 	GFX_FW_TYPE_MAX
 };
 
-- 
2.25.1

