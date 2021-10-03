Return-Path: <SRS0=HyUd=OX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9995AC433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 04:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E40619E5
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Oct 2021 04:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37E40619E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B416F596;
	Sun,  3 Oct 2021 04:47:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB096F58F
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Oct 2021 04:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khkrqSXWxmUaZIk4KpugJ9Kq183cAeWNKemV5gCp4xexlCghlQJUSktETzQSil8nzgn7ht/Yc8zbFFHTyRf3R00i846TvL0KAeBFLCZYCckjkhHeVWoB+hkrjPd8K04tXdwuj2nRHT5femASvviSNrfTzMQ0IQXpMCFQTav8q0fncvNeGf+tRMXPnH2T2jSwYl7fbAWzt04mCWTKP60doSA3jiuvpXSs/M7LktPRRnE/bd1aiMnl6u5g6fV5Psf/51oa01CKUNx5lfY8c4wki/AucyhTgJwbD/q3AMLb1Lf4YZxylIcCyy1wwcujFI9GOUAZWNSl/OJc52kb3Txf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pEPA/X+0Blydo8PwwPEwiXq+LvfgrHySYjGfG+C2s4=;
 b=TRlA/sGf9GfkLykH6+PCCThAowivHm2ER5F5HF08D9e9MLyWh7R/L+uRkw8JU4q0NX+0+3fsr8JMP5r9xLHmGxANZSHjPNQiQSMSivTfvw0ljdKwpTw3b1UCRttwtbBxQ34w1kDENUQtDxrB5xxCwJIVnYrE4JcSMksEHogn7HVvZTmPXUMl6x4qm2VOXNynXWeBGOViYTn7qF3eAtovvTJ4DX0kKCkI903VhgS3wGQJ2hoHFK2mTBDMm1/6XTK8UsTJzLV5DWtXg0vCjjyAotdRdpFNy9P9CdT+bHa9o56kYBfdsaCmfj0vJSKmBI+MBpeH9N+ZAVizUsXMsGgA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pEPA/X+0Blydo8PwwPEwiXq+LvfgrHySYjGfG+C2s4=;
 b=dy5lmfEtla4Lvy0hAkHPGAke3icBX8F/bVpxNOEUoieBqZHFHvq0g92CI1zwmqpF4xWpPBtbER3qbADSRA2WJP6CImGqsduhzi0y9veCScdaGwkK909Msio2vfo6xJZVQ1U+sg/9UZL8U9Z/exoAMBC8c2PgsVUVRajLlC01lOs=
Received: from BN8PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:d4::31)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Sun, 3 Oct
 2021 04:47:28 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::99) by BN8PR04CA0057.outlook.office365.com
 (2603:10b6:408:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Sun, 3 Oct 2021 04:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Sun, 3 Oct 2021 04:47:28 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 2 Oct 2021 23:47:27 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: explicitly initialize cached power limits in
 smu struct
Date: Sun, 3 Oct 2021 00:46:58 -0400
Message-ID: <20211003044658.29238-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003044658.29238-1-darren.powell@amd.com>
References: <20211003044658.29238-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a579a6ae-3b9f-4901-7950-08d98628e72f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27174884E183C5357AE4D494F0AD9@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiR+VLhmlt3Q0lAxZmc1GYqaItGC9/aAA0GqsGNtPxPQD8D1IBM/TJbFi/qCUTdItSlVN154lIg7Di8XnCsgSOtc4ct51sH5LG2XI2k8bXFkZG+DhqT6um9RTTPiPj93Z4TyyoLBaP+yXtb9VNxQA/KeJo/HajLCNQYR3Mxv8cn/uBnd7Y84bGYBvBK52eUT/nq5J34V7aRqm7kVeLO6H91oRmzJiLuMC2/yVz18PmtcN2e3Vd5M+zMyPbz1kIUk75DSCcz+JiDMun6Qot8Gh92+Mlob+pRoPgLbVHplah8JhEdr6R8hoG7u/CnoBohXYt3OUsMltz0DjeuLkzSUedf83T1PsWDswsgVVlh5Q7CKnw5KURP+H4aF7dRrpCWAV0SuZBPc8I//pKkLmqPeWxTqG/znjP+AkMeuWjDlVHoataQuyzqwaQfpXfV37OzOjGVCMoOJKAfI57shWf06Tta4OKsJUC5aL+FYwpQoiZP8tNx5TngE7VSNSkGrR4xvAXpVmEIzoqqlocHb7ZSyCHEI/VWe6gvXwMNcMvjA1M+tY5hNBqg3boAw6EtjA3PC/lYrPeN3rZWF1Mf8E61gMf+qYlg7w0AupvBrHPddkJgRSJ3CQ7dXYmV6S/cMouw8ZMx3njLF/JKGFX72+jEKDP7umhydxqMJbsRcIbTsJiA/xqb13jv5VdeOZIgcLbQttWcso6QWEDyivKxejkrWN4+BN5pjsineq91FL0xUCuo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(8936002)(336012)(16526019)(70586007)(83380400001)(36860700001)(508600001)(356005)(186003)(82310400003)(426003)(5660300002)(70206006)(2616005)(44832011)(47076005)(1076003)(8676002)(7696005)(81166007)(4744005)(86362001)(36756003)(4326008)(2906002)(6916009)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2021 04:47:28.4658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a579a6ae-3b9f-4901-7950-08d98628e72f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
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

Code appears to initialize values but macro will exit without error
or initializing value if function is not implmented

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index faa78a048b1f..210f047e136d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -712,6 +712,10 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
+	smu->current_power_limit = 0;
+	smu->default_power_limit = 0;
+	smu->max_power_limit = 0;
+
 	ret = smu_get_asic_power_limits(smu,
 					&smu->current_power_limit,
 					&smu->default_power_limit,
-- 
2.33.0

