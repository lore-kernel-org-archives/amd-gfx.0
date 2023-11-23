Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A969C5AD4C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 17:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3031510E176;
	Thu, 23 Nov 2023 17:59:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E0B10E176
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 17:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRz9liDCdtsNFcTkP+Xd8qx/LO6pIMe0wHUsxyq8elnXqzCF/+HO20EheW6Z6/w9R0Eu+QEZUl7JaHibM6eTe74qrSutSZRFjA5EwivEZo8le1CbZKPMg1Gvk6qvYYPzNlX0bXyVqudF8/9C6mnI5KUyDUYu1ZIq95swO4JTbg87wlYJ1VKG1aZ+tJb3uCCZ3fS4nEe6O79c1wO6Y/TY6NV+sXVg/Lr7RqwNvL6/KsvUXyLRLKyorkKv3ZZckMD0pU/imV0Wb486Fdx1J8i+AtSjebY4THXvGLeuPrvnTbZpeIogWYMoZyljU0onrDts7cG2znuooEVFB6L+gOK4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10Xiss3xuCOHSzYatM6f39MNL5xelGkUIieeTtsAYHI=;
 b=iDmq/otgivjHPm96F/GVVJS0nKNe0598SxSrpe62iX1zv1FJ+JhhfUGEYR+qTdwvC1shWJfz3paz3F3QNZPk1+Fy72yjQbfluUN0yc1gZaYs2fG1wfMV9j/yqAi9BQ1Kdxc+Rg+t6RYpq4NIoy0a7uss/1ZiEATzhWhEreLPeMHAGCt4tdZQKEXInIq64zLEZaMsVOr+X6/deGaZwMcCUsD8lThjWIRGAiMJS+dzMEHO4VCNxhvHclB/btXNu5E7rnAuwVI4CwIcaebuz2ZPt03bDXyUSt+7IPc2O6Mq1maeyWcWbO7xVeAljVqoTz0DFMHWvTXCC6ozkvTxC85Qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10Xiss3xuCOHSzYatM6f39MNL5xelGkUIieeTtsAYHI=;
 b=sWKsVhPObnIaUBX5rp/hfxmpaal75fhwgaPYvlrmwYtDA/uMLUwgo84kzF7yaTYDpFfQ46PmoON/53JyB1N80Fjm/v9EQvFUwBu2xJhRwsSzGbtD4YSPaYkc8WwhN7CfxCJAh6hv9bFqDo3fZ+eXR0NakBfJz+aqSdJL7J9gXtI=
Received: from CYXPR03CA0044.namprd03.prod.outlook.com (2603:10b6:930:d2::17)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 17:59:06 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:d2:cafe::c1) by CYXPR03CA0044.outlook.office365.com
 (2603:10b6:930:d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Thu, 23 Nov 2023 17:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Thu, 23 Nov 2023 17:59:05 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 11:59:04 -0600
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable GFXOFF During Compute for GFX11
Date: Thu, 23 Nov 2023 12:58:42 -0500
Message-ID: <20231123175842.97383-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: d89326b3-eded-48b7-5d40-08dbec4de264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAseNUl5JMhfinrEuqHwHjrJNNGodBYRZAxTX8O+8EaFho8uAsCrVf+nHhnQVWeS8PMaZNb08Lkn5aCgfuY/8tVN/scUk+l9K2sespIw686J61QmGREv4VTxTQMKfWzPrVmZBLqcqCVrkYHpQcBXLEES1kKg+n0twa4aEi2abvNZyhaoxleLDB8a78qgcDZMMm9y672CEiA2wl6brzesvjCL3j7HDDmAOjXyJmRgRFVTRzVRDT0acnmPOxT++u9EqFmtOLYOXRB4aNY1q6oZmnOvWxCJ4iim5SYw8B7REGS6b8naEFSH9OtP1DT1tKWiv8F2jKx+ND+wbrFdq26adQTP+U9vQPQI7benkLIzr25U1jfLWGPq++kSo1V58ApIiUarp6je08oK7dbJYmpdgsti5ZNK0U12HoFc5wAbNU8c3ki9NwG33XpQEQMdH3WSNKNuPoregBMgzFV/ewLmWU0I8KSrxieJDTnEesfP5P7IHd1/uVImAO9JQBbUJQnzBVj8HKYWBG0RY8ghV+1EDgqNW1+DAm5c0Y0/g96Y1/8QgaBH3lRakGZ/R/m/3fCO3OStxu4I0p2ROLHpr35u1Z71N421oO00nlvP1YeJW1Iih+QEkTkY4Z70L1GcOWvcT6m4ejNzCj09ED87d+SQNpXDonEnj8aZ0mBRnunG9AMid9Z4uAElU/pRvbpImi0hRZHFnCTwy72pdlIvNwIPu6sfBAc/HIh9nENBqxrq4Afbltr9Y5J1tVKW9T4nS0PuFjm9L9mc9sIJviT4hx5BWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(83380400001)(82740400003)(86362001)(36756003)(356005)(81166007)(47076005)(36860700001)(316002)(6916009)(70586007)(70206006)(41300700001)(8676002)(4326008)(8936002)(5660300002)(2906002)(16526019)(26005)(1076003)(2616005)(40480700001)(6666004)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 17:59:05.6984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d89326b3-eded-48b7-5d40-08dbec4de264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
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
Cc: Ori Messinger <Ori.Messinger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFXOFF was previously disabled as a temporary workaround for GFX11
due to issues in some compute applications.
This patch re-enables GFXOFF for GFX version 11.

Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2d22f7d45512..bfd54877b8c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -684,14 +684,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
 	enum amd_powergating_state state = idle ? AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE;
-	/* Temporary workaround to fix issues observed in some
-	 * compute applications when GFXOFF is enabled on GFX11.
-	 */
-	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11) {
-		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
-		amdgpu_gfx_off_ctrl(adev, idle);
-	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
-		(adev->flags & AMD_IS_APU)) {
+	if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
+	    (adev->flags & AMD_IS_APU)) {
 		/* Disable GFXOFF and PG. Temporary workaround
 		 * to fix some compute applications issue on GFX9.
 		 */
-- 
2.25.1

