Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB01C4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 21:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02EA810EA79;
	Fri, 15 Dec 2023 21:18:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4026810EA79
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 21:18:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kubk0/2JGhjfkymbN/D9HCwxW6Ki4h0JbW55lcwwYjRdHIT10ASDw+MvFfRWtBi55bctQiTLEa9yDmlgY5D937XpO0ca4/msowmx1oV5A1bRFZ+M55Cw1rGu3798EEhjnDeE0I+jzCKvtzxXDPQn4kWzrY9tfgRL1CNiT98KQ/Ucn3MniEIn8Y5JRMsZaEbCwlPMh303aLC640mdaAnp3KsAoRT9iGhmptqgQPlU5FTpF020dgRoy9m70Ega4+uiitALvMOl/wNucn0wwT5iPchKalVZ1nzlevtpWTAQCa4+To70NOVWEjd8xf9rkALedYIKLgohkVDJHNPSUCSY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXoEcFPiG1cyRv1rpyAMeSVSIIx5P9V5D4EvKXHCfnY=;
 b=lDkW8XThZLjK13c9zJaqjWw9obUZ9MxwekT+udfSY+ArQiWxPAAcM+AHUQWpx22buqgwANdq7vZyQKHSW8jXtQFyoW1AJnz3558q1+DzKfZo6p5jNdAi7txxLI7/8/MWq3nMnNQqiDhGqPXe+dOhKsBGXUG/6UXGSOtiVgaW1nVe5OLqUY1vIp6277xvasf85DxYBwgUUmQb4FU19AXiRpxfy/QC9EqsVLFRcH87wcvS+5mjrPjP1EQjdaUsonFgCRNAM5TNiqyxJfx1o/zEOZvLG8hppA5vmN+CVWobKluoCwkzus+E2xKKzIa22dpP3yB9jVkyKzmgRa2HyjclyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXoEcFPiG1cyRv1rpyAMeSVSIIx5P9V5D4EvKXHCfnY=;
 b=cW2i2lUzWcoa5NYNSLz9bC+LqmkNfIfKkdAxsVqKPhsYyKJywRu5UHdUoMszFZYtPE6oOjgfPX99TJJtjI9Xh2/9CZiDnFcXOsWngR/Frkr+udI/rCBNg2eiqvfeM8qliOYOgVl3SrJkm5BMoCOCCiKCSsVBlYdbkGvUstHYm5E=
Received: from MN2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:208:1b4::26)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 21:18:08 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::50) by MN2PR15CA0013.outlook.office365.com
 (2603:10b6:208:1b4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 21:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 21:18:07 +0000
Received: from OriUbuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 15:17:47 -0600
From: Ori Messinger <Ori.Messinger@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdgpu: Enable GFXOFF for Compute on GFX11
Date: Fri, 15 Dec 2023 16:17:36 -0500
Message-ID: <20231215211736.139200-1-Ori.Messinger@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f96380b-c935-4f19-f928-08dbfdb3556a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ta3rY/7BPUixGEJ4J6yhbH6GeIdn4HtF3LowcWHql58UQOjgX+RsfQMDXKVLcS3JPkeJAE6qwilRbEsdg2p7yJXov2BfMNmtEK3jX1qBanDCnCEETsZMJzWW6CmvHk+D74ZBD9ufweuaEs+jgc6AjkP7KAPLMBZtKi5cGukJ9K1WHygvZfKjqicxieREtG6ueH0eyBZTIlKizyVeUTac6K/dy8VVnl6ArcROGYwMAr6W0Gk0J60YcHVf/bS2aM9ML2q8bE64ATH0PhYXk3lZNVLK31aUoNTeolDqwGaizKjmZCA1ylrNL+mYulRLj+4gs+MUZq+HioqlhiYa1EH+ScVD8+GvflYzc5+F3b8F91nEzdKulUeLe+Juzt0W+2t2bhcmFlCOdrK6OMaY2hWK6qe3AukH1lUPIQ5oH8KDtxfXnFcnicb6RgzELM3LnBDRkfa2S0CtoUu5v/VoQqWuasVOGs501ZBSjq807siZw6F7IHBFQhos8yx2ksg7QYaVU+0+Xwo5uN94TOVlT5wu5CMe/27kERLb5/a2jczfn1voW9GrdgO3PC6knODFvz6BypikQgh+j/KtLcy6xXZe1RR0HuR5WXHFAOXGNrGMiymFzUCurNS7l1/nv7/tAG1cZiMG75iuCdQOkIJ/ImIld+RrBzePc0r4dBPjjIJe2xyCRU1y1FpNwGYtZJVdamla+Wi6PPPc6RVqUzeyM1Y6dTVs1+IDZ94moU4WLgajxkqpBIw5QfaXvG8S6xd1+A3ls7wC0+RSQHvhpezMdJ+8VH6uBiTuranR38+I10ZZO9L67pNaShwmj01gqpLxdr7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(70206006)(70586007)(4326008)(8936002)(8676002)(316002)(6916009)(478600001)(41300700001)(5660300002)(2906002)(86362001)(36756003)(2616005)(1076003)(36860700001)(83380400001)(40480700001)(356005)(426003)(82740400003)(16526019)(26005)(81166007)(47076005)(40460700003)(336012)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 21:18:07.6791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f96380b-c935-4f19-f928-08dbfdb3556a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
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
V3: Add parentheses to avoid GCC warning for parentheses:
"suggest parentheses around comparison in operand of ‘&’"
V4: Remove "V3" from commit title

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

