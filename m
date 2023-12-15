Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB36C4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 21:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A341D10EA96;
	Fri, 15 Dec 2023 21:13:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7798E10EA96
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 21:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYUeKWQWf2SBkPDeByfzVmTD1ISKmjwSLFWmfcEK1tgEIC1PtHfdaKfh/aBZjg3vFIm8RfMvNOQFvROkJwzb3vlfLS/qPrOK6xzfmAE5vjBcK33taCXsIYFgTpjjeAYklsFlVyHNpVZiL0lzx4VHFaAW7EKKxpXJaQESu97Uo8p4uQyf89yn/olqkuro0o5h8w2J3qCn9PpV+j/xeCNXt+Ulo1R9hpEp8dGMkFtd0n1gnbNKVhXRrgmHsdYYFXl916DUphhEE5PEol0wdKKBv0r3Ximq5bsRx2MYo4ZHc9Y0Iaq796zdKSSphAOUNDlCmI76gDFv2MtNzg3r+opEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD7vXvOO3E2SJFDaJ9SLtyMCgnozl2KXVLZy98X2y0I=;
 b=BTg24yXzl5jsHEfeu6ZENXziuB8dndkqCLzFD3Rwb5t4jdYi/KUXWgpDQt+r1sjwsW7E6kLcd14iPd4u/CamSH3aJiM+rVI7OTojxifFsIXcQ55Jympo4BOXrPV3/4DigtD6vAvB/Z0omgwB/2WK9DGHtVYsnKxXPOGX0irdr55+iHJmKnURXJ0w5WxKwYAdiOOji85nIzDwUM0zFrMDkTkbtrTGDfVCL8J+Lj57zhabhKz/Lf6pKnwK3GqFRPKfW39xS0GuK1nbZhDy8AxvYicGawL6jh5gyjZW5W2kLZg33C2Ggk6vbJWTv//AF/LvnvCMqj5uXLKo5K6WEC7iiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD7vXvOO3E2SJFDaJ9SLtyMCgnozl2KXVLZy98X2y0I=;
 b=TdHeq7ATa5/h0INIasCGfKJU7sJjfbjAgzLLL6qlVAwm4ktlLia0A4C6fdaQqGJEwqIPcd1JQd9tLGxHJzZeN6wKK9u6TIGAd5UwvIAkBEWqED7FWjdgnVGl3yGnoEFKQq1M3zFIj7cUhg/wuIZVfYSk/I4oXHr1nwNVqGeuMM8=
Received: from MW2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:907:1::42)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 21:13:02 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::c7) by MW2PR16CA0065.outlook.office365.com
 (2603:10b6:907:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 21:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.7 via Frontend Transport; Fri, 15 Dec 2023 21:13:02 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 15:13:00 -0600
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Enable GFXOFF for Compute on GFX11 V3
Date: Fri, 15 Dec 2023 16:12:48 -0500
Message-ID: <20231215211248.138997-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: b535ee9e-65a8-47f8-1e58-08dbfdb29f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sxqpzaz7Yt7r0kMT6+KpxySspXWN2qTO5dh7df6+jA/0/iS9/9JBOw6FlbjlJGmIW+cq+IOXLTwnQHY1bDlu+oRmlB7WXDiKYpCr9mr/ajSSWS41QUOpzOgx009aIvkWVScC/KgGX4Mlni0VUgGTbdQO2BcZNTf3pE1ndWH4syRiyuVj7VhMyjVCWAVw22NpmcEYLFZYwM1iuQ8+rYPg8Z/UxSO7sw0hFm6ZIS9qIo/6lP4nPz+WbkKxgyyDge3EHBXUZXS+7mMderGs+6C/Ix38pz8ZrY6ARXB3ZN+nP+7EpU6B78JlJyunPQSKN3QR8lUYToc4ODmg1Yi4hdcdKnrhRvT6Qc15ut0C9AlZUsxrGiEzDmuJzt6ISjYTFS0WKb+1T02+VwFqkfMuHbQiqmdV63A9qdoPN3qcbcF8/OLXR4bNgPpyV4FvETjdtawJ100BrTi3Va4C0zDT/Ra74XQaYEK+u4AL5Ouv1fWHv5gsa+Y9sx2VMLc+4/dwu20hiNqWEdfVfHlRYOvM//OXc9TovRGnAkyU40+es3xiJ76rZcbHA1lhiLMiBoXzG7IhFwcNlHAHxPme1pQxa1dtjD3tCUVhEqD/ygmmrfv0IrsEturWasX7Z1eU9Gw8rxtfqc7Ik3uusGWlG1uBJlaR01OisAJJoc5BRnEs3m+opGNnylcLSV7+flg6TTpe7v0m6dfR0cAnX2ntuMjJiJUiTAP1ERSzGjf6J81oTwNesp4rSCQff1yapW56vsAWP4ECy1J9ctwcxTBbheQwq+x7hMgQoSsGdDXxxe6FNb5JAD78sV0BzO/rjS2qB2Sr07HF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(36840700001)(46966006)(40470700004)(40460700003)(2616005)(1076003)(16526019)(426003)(26005)(336012)(6666004)(7696005)(83380400001)(36860700001)(47076005)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(478600001)(316002)(6916009)(70586007)(70206006)(82740400003)(86362001)(36756003)(81166007)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 21:13:02.3792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b535ee9e-65a8-47f8-1e58-08dbfdb29f8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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

V2: Keep GFXOFF disabled on GFX11 if MES KIQ is below version 64.
V3: Add parantheses to avoid GCC warning for parantheses:
"suggest parentheses around comparison in operand of ‘&’"

Signed-off-by: Ori Messinger <Ori.Messinger@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 067690ba7bff..04494b385493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -695,10 +695,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
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

