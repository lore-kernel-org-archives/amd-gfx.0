Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86716C47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 22:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D905E10E572;
	Tue, 16 Jan 2024 22:15:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9E510E0D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 22:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TybB9lUkP6E+lOrFY+dvwVsH0dnn39Yk9U/Z4BhBv4HshTp7ApOix9uh8lGauto9jqQ5S4kjG60NI6ctQQOfKvPmCa8bYHxDw1zb36rHATJGRoVYvVd99rby2sLKCHKSTtF3mPRCCWVsBLKyf+TjvdJs4Jg3pbi69q0hFNlfS5W92A0gYqNDs3TCCdw6ujd3FZcdKN4Af2n/UIttMUJC/FI5l9KsztcWfKHIWgfU+yMDtz/hAwn6AfBmyEixZJCiHSjANL+aQ+ettEwtrA9vSmCRhswRusE8QrAkBTo5wV78CAIdJcSXMul5iX9k7VnSN72oivB6110skXu2jIJ3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wfb4cilPCzOS2ehxuqM3Skri4iH0xMMwRLnx7U1waYU=;
 b=V4zhcwpStbxrhhP/L5GSWPpbtZ/GLviYrsQJZG+fH8Ai0HludTFgS6KTO3xHyvtec7FMRN5uEDqgphVszfs/ECyamDnmV+4wtJWWfxNORD21JJizPWT6dbeFLUdFzYoKNsKn6vBD5ysmnTJsxHaPIWkoH2+j1uSOc/WeIwBpDEyC2RBT4z8q2QCm+LmKpfGWHEGBWNgVK6Zh7cze5HQ9wib8qc2yVH5JYEdL9jb3fxW/sDbUXL2WJ61ULNFjrqZwcI6GhNaUNgYQx9hnQVbpoOig1Rnjnzl3yxIFw2wJU7pNngoGcZrSiZNwsgzPBLh0HW9IlD/+nRPQ+hDWJ4fJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfb4cilPCzOS2ehxuqM3Skri4iH0xMMwRLnx7U1waYU=;
 b=SxfGZ1xhq+IzZLSs7QZcItbZUpFC6xxUIIaFySsSfQJBlBiwuqQfecNnBj/XEvfWTpRjiXmDwpYb0L5l3NODBJ/jhZHhNMDPqEAd+EK3Fp2Vmq9qrQ0CWbYIlq8pwfQ2vQ/NVrJRHwJgVXkmu1agOmr2t0pJwVbRtALbUBV0qYk=
Received: from BL0PR0102CA0044.prod.exchangelabs.com (2603:10b6:208:25::21) by
 IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 22:15:03 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::fd) by BL0PR0102CA0044.outlook.office365.com
 (2603:10b6:208:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Tue, 16 Jan 2024 22:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 22:15:03 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 16:15:02 -0600
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5] drm/amdgpu: Enable GFXOFF for Compute on GFX11
Date: Tue, 16 Jan 2024 17:14:47 -0500
Message-ID: <20240116221447.195652-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: dba78933-dba9-4fa3-1a34-08dc16e0967f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oQOfpWop8guHpEYU4YqMkVXdgNQte58HJDJsB+Qqe5kwHT8KSqk0qxl5kfBmYOmms35FZrEoC+gsBw5bBK+gItdxx8zrto5m2ko1p22A403c3/+bBvpirTLPR2+36gIzzbuiEiCdahRPkQyXkU16D+4lB7bhIHoXmfUUF+/TYN5zdX5BO3g3H4ehdnfzZrSuIqohQnma4aYqD54INhGVx0SWp/mzhqdq62d5fyJNl/GqQeCewefzvyvD2Gv5h7OLtBK8lh7c59C2PshM+zVRSluKUJlQsHoAGNtxY2r6X8tD9FgxqaqF/DhFKlvVA3hc+yXY+oMTxIkbz4XfqtLlJgzld/RsT94KYGcdC5Y/68T/T0xvdwlovCqGGBK3bKmNjeiunUxQua3rQfvPZJzmBYJQA5Ula/gY/aD7eq8vAPkd80O22w3sMgK7nPVNelbsmiUHRoJ/sBa0CbTvV+oq9H1gG/H3rOv+Gc0PFhUFbLHL22i01JsM3ZnI4j4IU2wt0a2Uvw9BHwg8bagGg5sxUEEYmW4X7wyt/mXbAQQNmjHHs15NXncN/4JUFtga/vC93EkpoGFZaaZNNkXKuh0nDY8B/tPx1I0cn5/6C312BudzPUAOHX1jO+hiNTWdnFpk3IvnO3iIe+itQuAsqaCaIZvy5ORKGSNtMWQBWv3Ky3VJNzWTeRnV091+FWD1gYmwb8zGe7SPz7VIyaeZvXous8EF5tmTOVZYFuvikc0gDS/mSTQEio5Ijuhy/Ykuotbbxi6zkGIJeYZxVBekIwwABox/KSxwEqQMQHknZFkZS1mT74ahyYjc81hi2BaDSc0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(4326008)(2906002)(5660300002)(70206006)(8676002)(8936002)(70586007)(316002)(54906003)(41300700001)(6916009)(82740400003)(36860700001)(81166007)(47076005)(356005)(40480700001)(40460700003)(83380400001)(86362001)(36756003)(6666004)(478600001)(7696005)(26005)(2616005)(336012)(16526019)(426003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 22:15:03.2696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba78933-dba9-4fa3-1a34-08dc16e0967f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Ori Messinger <Ori.Messinger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFX version 11, GFXOFF was disabled due to a MES KIQ firmware
issue, which has since been fixed after version 64.
This patch only re-enables GFXOFF for GFX version 11 if the GPU's
MES KIQ firmware version is newer than version 64.

V2: Keep GFXOFF disabled on GFX11 if MES KIQ is below version 64.
V3: Add parentheses to avoid GCC warning for parentheses:
"suggest parentheses around comparison in operand of ‘&’"
V4: Remove "V3" from commit title
V5: Change commit description and insert 'Acked-by'

Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 81af6bf2f052..77e263660288 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -698,10 +698,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
 	enum amd_powergating_state state = idle ? AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE;
-	/* Temporary workaround to fix issues observed in some
-	 * compute applications when GFXOFF is enabled on GFX11.
-	 */
-	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11) {
+	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11 &&
+	    ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <= 64)) {
 		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
 		amdgpu_gfx_off_ctrl(adev, idle);
 	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
-- 
2.25.1

