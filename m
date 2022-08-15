Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81D9C25B0D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 08:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337DC8A9C1;
	Mon, 15 Aug 2022 08:41:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4FCA03C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 08:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWTw1QUMgoB9qxA4vR3Zw78higUrPW2BYeiiRqON+eZ7bCH1JLqKZq7lj/rDzdsBCZldBUUZc7CB3svkgIw1bzxiuWWfeE3Uyp0Q5Pjj2WlPBM55QVMaPmusUwnXK8qRPN6fuYhughaCMJdfKlhKge+PAc3/kvC0GIHtwBwLG5tmonZrCFObS+lLcdd1MabEz9x/OD+qmFnqv8tUp/2hMC4YwsyJYRd5G4zgL52c6GXVKNQgwarEpCdijtqnACugRwUHZolnSuisRG+nf354aXWRRy1QBaioblbPqnzK5nEmFyK9PzhjFGDlSWkCcigK092fiSziB5t7PXYAwEMuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czM1pDg3la2WC5ti4Bs/QrOF+iOf83FGysTc+qg2RXY=;
 b=fhEnMKrsakpC6iRmfSzsEUhbYY69IVONSTA3dDxlQcQclYtlEz7FjAYemjGOAkzfLVpgBlCjgY96Ie4NM353uqDpbq0P+kTFJyGmtPJzZP21DO67RoGs9ifFoX/8A1vAp2vlI0xMknHnBbOqcDcb7kJKQqfYcAZtg9Py0msog5/cKDps7ShBNCjY9fXSrvhgrb2MFPjKNf/M/JaXQNpvEJKCiwQH8xq96u0S/zBvv0T4Mcac4qLit7Zp3ScJWyg4hOafr6Tm5dF6lBJ9a4WabcR6Wl681M55fWejFo8LJ4xdY6huz3iMBlRXvGrwhdlrbZkJ4/dLf0uQViXpoNdNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czM1pDg3la2WC5ti4Bs/QrOF+iOf83FGysTc+qg2RXY=;
 b=UrnXYicIKE48QmhWCOK9wzSgaP2Qzvh+5E4iybB5V5T6uHHGhLoio3MGcsgbb6oamJAUpuqQbWpG5sHQL1HFwT6Lzn4vSj662eBRmFu2Hx3UN28rc8FZBpvoILGoXEZU1RbWhfPCZfFB51veFwbsa+455WI42bhdBN8e/cTSgMg=
Received: from DS7PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:3b7::7) by
 CH2PR12MB3735.namprd12.prod.outlook.com (2603:10b6:610:25::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.10; Mon, 15 Aug 2022 08:40:39 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::1c) by DS7PR03CA0092.outlook.office365.com
 (2603:10b6:5:3b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.14 via Frontend
 Transport; Mon, 15 Aug 2022 08:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 15 Aug 2022 08:40:39 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 15 Aug
 2022 03:40:37 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add secure display TA load for Renoir
Date: Mon, 15 Aug 2022 16:39:52 +0800
Message-ID: <20220815083952.1303363-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f90557-23b4-4b22-5fd9-08da7e99d52a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3735:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQWdz1y1rm6SCTWGyd9o5DJI3+gIVNU28ewzNtjj5wfMgCciAGhAspDBBszlM9fYQ4zlHzjdrsNx8XHqnO24XJoiU4AJAtSwDmY2ezSGpYsdHm7eEUbhyHSyWB/vfztSxCUVyTWUWPMwHoSAIeV1V/Ozp4jPH8FbFE+BLcFf6GJ5x4oofzW47c5Zbg86sU2OQtDqlyny7KsybN5rXcNO6gHjgIxf+ZyORF0qH4AJ3d/jfGX7B6O0agWS8ZW4V/erzGbvG0MeoTh96qfD47UfoSo4qfOQNJcQr1gBIAY+zrt9LkqKaOzRtnfnkTXLuh9PmY2tUn9pcvEQ9RhPXcSftu/4st739OXNuz87jiPQ2PTtkqVga6wGL0gEI4/Zw/0ZQKedbH+K+J9VoT2m40qP+yloLAcfm2n1aArxg3xpJa2F3Ws2oM2dOyz09mN/59O5ZgXOQSEmW2nB5pL4LqdBd5SlwdJdMiLHjtrXOdBro8J7VoQ+0Uqd1s9b680ATpWGHsY2yulFt17blwwRQOHlLqPTSO7RtIxu+/PoofOIDkC8qio5PVcp7VaC3oIRz+B1akzg3Ah0rwoGB6fBMkOLu6ZeysoDYgeBgAUusMRtoMPIVvoiQ9bqrPx49rIFkGlyYsD3KKky80HgdjLEa8afSKh4HJ29kbiK4jlzr12PNCjYNKADSCYpK/Wk2AA64PhvTsRKRMJEaeKHGCWRvJ03ySjJSivYZURSq3K5918ol5gSP4CBmiFHOKddsgUvz9VL9lHIOmzZCiCE8OCE8ifGhXoUA5jv7luMaAbGPxoC+HYfkaHzTCRXw7Jh26G/ZB5AAdbTd8ZZ6//GJgdf+ACwUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(40470700004)(44832011)(5660300002)(316002)(6666004)(6916009)(70586007)(41300700001)(70206006)(4326008)(86362001)(36756003)(8676002)(8936002)(2906002)(26005)(7696005)(336012)(36860700001)(81166007)(40480700001)(356005)(40460700003)(186003)(426003)(82310400005)(47076005)(1076003)(2616005)(16526019)(478600001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 08:40:39.6672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f90557-23b4-4b22-5fd9-08da7e99d52a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3735
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
Cc: Shane Xiao <shane.xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add secure display TA load for Renoir

Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index a2588200ea58..0b2ac418e4ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -101,6 +101,16 @@ static int psp_v12_0_init_microcode(struct psp_context *psp)
 		adev->psp.dtm_context.context.bin_desc.start_addr =
 			(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
 			le32_to_cpu(ta_hdr->dtm.offset_bytes);
+
+		if (adev->apu_flags & AMD_APU_IS_RENOIR) {
+			adev->psp.securedisplay_context.context.bin_desc.fw_version =
+				le32_to_cpu(ta_hdr->securedisplay.fw_version);
+			adev->psp.securedisplay_context.context.bin_desc.size_bytes =
+				le32_to_cpu(ta_hdr->securedisplay.size_bytes);
+			adev->psp.securedisplay_context.context.bin_desc.start_addr =
+				(uint8_t *)adev->psp.hdcp_context.context.bin_desc.start_addr +
+				le32_to_cpu(ta_hdr->securedisplay.offset_bytes);
+		}
 	}
 
 	return 0;
-- 
2.25.1

