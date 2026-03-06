Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE685F513EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 14:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCCF10E3E7;
	Fri,  6 Mar 2026 14:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NlLpndgQ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C5310E3E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 14:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/tNh2GjkATglDE1omZnaHLBH2VVz1gYpHrikFLVue5BCwdCGGRk7mrBFQpiMjQXbjooFCsvboQvKQiBVScT2DtOYx6OwAOcP2jUm7MUuM1DdWQCY4yEkp1OWk0wK8oZYLveMF0v+h8JydKxIduafXYU/IRw6nL1MnhT8fTOWmdlr88dugNNvSIyCZIaxzZQ98shFFw6ojv1hStA3+oSUy7l+5T0oBnWUsyp8VTfGjEGGi2tLoa9zfnkL0aJ1lN2wLQMRMNxaTud5C3IlK8jaOFMKU/Atk/aL3+BWvskorPEdlYHeztsL6gI0vnyRQ4wE9o6dsODWljcPNT9xbVzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eb353Cs7hR5geRzwWNAu1hXcVOxPvQfOf63H9bTrlN4=;
 b=s7koJr0o2/jYZm6yO3NkEyh2gmNhFS5XxSpFMsiKauqb6d7QyTsfUO6nY8ny2pYesI08ZspVlxDIq6vTm2kR+y66KEIwWqh+b5E5JPpKPVEKWUtYcVuUwuP5J/0T+s8cSysn1uAIsjrN6cjg4U3XLJ2UEigl81bNxBxqp+xvKfe5jXh0IqZ4ehmP2Mmv3NzbYd87I2UH5esKBt/71CJXqPskTqH05VarMx9Ks98Fpky3JPamyam5JeuRI/Raw0CmeATcevwgpcZ3V8tOwzEz32FutNagow5wv70vLUZelt5FVbq1Pa9fR4GJPAgnutUD0UOhSqHbYlxB+VybzYk3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb353Cs7hR5geRzwWNAu1hXcVOxPvQfOf63H9bTrlN4=;
 b=NlLpndgQFNyautY4sP9St6vegQPwEI+aA/Tag2V+tmCBn8x2z67nz43lch7df+gvpTU82haPgfl4Iixbx+z6rE2IL2mzdPzzWNWQpB+3YB76fUFEG786eRPEmAKRy8yHpv/SZFWm3lG+QVlkUB9Ivpz8o90NjfQJl++MlCNvCok=
Received: from MN2PR15CA0056.namprd15.prod.outlook.com (2603:10b6:208:237::25)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 14:28:08 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::94) by MN2PR15CA0056.outlook.office365.com
 (2603:10b6:208:237::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 14:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 14:28:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 08:28:08 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 08:28:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: apply state adjust rules to some additional
 HAINAN vairants
Date: Fri, 6 Mar 2026 09:28:00 -0500
Message-ID: <20260306142801.3914073-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 67911d38-3c27-402f-997e-08de7b8c96a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: kCokdPeVqQsaDCId+A2mFkWd+r1hA9hbJBvWKcI8Rqsb40eYHlapRYINGFAvZe+uoqigbL8ofopzU544S5wsCL69TcQDXHnFPkeqVRxHf5O7Bryg6IvT3vOjKFZt+ggpwrZ3vI2uhgMz5pzkHjtLHH52R/bJdOENIua4BPD2xO0rhV2IxRZrBflgvM2yXGx2rvnCQTcNzr7/C/KQs6C/BNlIoxRo4o69cfOOP+TdPYPi4p89uYpaxhEBA+cBH0UCIiDg/Q4RSyB9U5GNaYLJjCUGxtfDUcldmC1O3mi6IZXriyyc0UFotttrq/cUwQ8jwmg4MRcTLA1CntNjd+3ry/vjwbJoiSZonC2RqoVs0hUu/HqUyeJ6LyfO3DE0SL7wXLE6zJIY/+8DR9aNQOh6YI45TbeATXJBqHphre+hvZycTJRMa7t0df3BzdxRop5z5TUYP0dR9xScn66gaIjEW9fcAcI+7BySxp2+38XtVQysV7GfsXCkoocZQ3UkBlr4I4JnMb/sPLPJPo+4T0Hz1GT4h29SFkOACrpJ+RRvsgdR8M+t59VwPlCz14d5KNgTzX05DQ3tQBnVaRWa91M17VQM8mbLksasu42VtIAHeJBiunwY1afsY44mK59TXSp7Huu2Yh1Cp6n9i3i0SPG8YOGDlpyHCBcdialFktZ9uZ6Tk0niFLtfkBGZsgRIL1B3cvGuXqTiHlekx5VYJ3Jz7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yPoo/F+SSkJ0TCS5spit7OQdWs/tLa0wzliCx1yeZIYjBef+KONgz74d5x8E2/MEsGFQ8kRdvpwHg2GhXzpAql7WgHlLBgaZMlDLTJTGuSZWJralP4NuohjomkOMsYn2xHoVu0wXIZ/cEDRoHt69qgkGw7DMroQz0S65t1rplur0CmwX1ujQW9AG5jPWTnG/IMYdWo/RZliktFDxD0o4VOeOdcblsvkwqHb6OcyOePuu9GTLi7owglS4itwMtRoLNSlTUbeHrexO5CwcZxpjL/rdZpXhxN/st/gnRREuo4gmYIUFaxh78KwMS44aIBsFdv2PUvNSq3tYceEDC8K+s4D5YpY7R1TUVis/Rn4aLyW7pTAQSa1y0p4tcOVyHl/G5dkNZgiD9OGiDlOHTDSBtmt/oRTr8kkDQ522ddOW8sNBZieLTIaYKZ8LqignmPpb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 14:28:08.5867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67911d38-3c27-402f-997e-08de7b8c96a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
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

They need a similar workaround.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1839
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 07d2ee67dcbc3..c2b1383c7db71 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3455,9 +3455,11 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 	if (adev->asic_type == CHIP_HAINAN) {
 		if ((adev->pdev->revision == 0x81) ||
 		    (adev->pdev->revision == 0xC3) ||
+		    (adev->pdev->device == 0x6660) ||
 		    (adev->pdev->device == 0x6664) ||
 		    (adev->pdev->device == 0x6665) ||
-		    (adev->pdev->device == 0x6667)) {
+		    (adev->pdev->device == 0x6667) ||
+		    (adev->pdev->device == 0x666F)) {
 			max_sclk = 75000;
 		}
 		if ((adev->pdev->revision == 0xC3) ||
-- 
2.53.0

