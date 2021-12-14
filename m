Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1289C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5E310EBF6;
	Tue, 14 Dec 2021 03:53:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C0B10EBF6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8LI7SRLyr6bPp8WrESwBqJ7ohMi0Uf7FyKGdv17SaLSBj0mmWoUU3pm60mi1Gsnoart9+j8YastVaQYu1T+V3Wh0tbtYGG/o7IOWhAfCM4eIo5GBbLApvym0Cto64YXI0sOG8fXQEMpOe/JvlljdvN6gvw2ZEdsP2BK2y2tjSFYqneQifZE606p+jt5EAkt5YKHKfASl3yqedr4QOxsukMmsz0jTxK1+uTrvrHk/nP1GTpVeRwD4f40pgp+bvpmLF5a45NzjI7oL8NdmimoDCP3UO15RcWx2BUFUl6TYcz4r96A2YGyMK6LJ8Jnr4Yh4uaFdbvGHt8VC43UCc/uTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD7s+XhkRf6sSpsp2jabq5ItU2cdr85IERSYUldge0Y=;
 b=fywU7xOQSc9Kzt4bFGJzST6cFvReIR73e62NS2pNqszxpBpCKKCtBhgRX06blODvBJGu0CCbd1ZateEMIO6NCsw5lKY74iirKZgeOVuMRZux5bHWOocNakxV2HT26Dc1viFW0YQznhOUNo6YdEKSSJVM8jZd8P8IfkfQyuZkWyHzlc4sOkhP2n8a4096/5WqGAG5Dxybf82QmjRqOCHTtMxoQNAX5Kwn7BLLsQxdIxIdEi1eAU/AglH3A/qSr/FGRxNdDypTmxtjMO0dpUhGWsec2NtkX7kBaH76lQyj1CvudjnrX7n8cY/vi6KQqTV6YBuVKooRufmiGRdlMfC8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD7s+XhkRf6sSpsp2jabq5ItU2cdr85IERSYUldge0Y=;
 b=e6n34OspPxudoLjiDs/UeyvgKlVWunK7gPY6nUMX0onncbcNaOsg/34Po+csBTdSRbAuKuJiN5uS65xkbCIM5QmpJA37GEO732Tcv1VVql6xOJe5rgOLDPYrSjmTlQ3J8cYus28vz5ZlfQh7YkvtedZNL7iM4iLrDTRXBv4s6ZU=
Received: from MWHPR15CA0025.namprd15.prod.outlook.com (2603:10b6:300:ad::11)
 by MN2PR12MB3182.namprd12.prod.outlook.com (2603:10b6:208:107::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 03:53:35 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::47) by MWHPR15CA0025.outlook.office365.com
 (2603:10b6:300:ad::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Tue, 14 Dec 2021 03:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 03:53:34 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 21:53:32 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: fix gmc bo pin count leak in SRIOV
Date: Tue, 14 Dec 2021 11:52:54 +0800
Message-ID: <20211214035252.15798-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214035252.15798-1-Jingwen.Chen2@amd.com>
References: <20211214035252.15798-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 825b47ff-2ff4-4f5e-600f-08d9beb54d94
X-MS-TrafficTypeDiagnostic: MN2PR12MB3182:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31820398B54B339AFF43F828B7759@MN2PR12MB3182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrOa46E8aVySnKqEo596UgmXXBhNx/Esd7CCV8Bj2Wj+sQyaHD+7aMEwlePl435WTJV2xGajHzpEoRtSGBSVt6Y43gWZDTcop0A0IqOiDtLGMha6NIaMHBOaPjql4RdxfVLojaHIyD/2LRKQ+/X9BkuI+a452S32p3LpTvrkGCJ8FId5orO+quTwYmYK0awp/crc2WjuoRVe2Dlr75jxJ9kZqHwduYT3aD6I5OueehSMsDwilO8kRGdq8Xov3UFtLnDxfTNnwElUNLcbhb51Y7TN2yLzumtj/zJd+NISrOrGqlKkwN00DFUmcBVP8U8K2Ff1NM6aXfZR61kUy7FuF0Ys9zhWlKglno6kRb+bbyASYMLSWauvZnqPnthhxHHK8XbrZWuLCMzxgsXb3eSr7g/RJl9i74YQIDpg3eehX6BRQrXL9OqGzKgCXl1OYM+22wEpdHAj8ip7uKFgygZOaYykbey/BZEMNo+9c6xxH4vIQQhm9XAxSofR0NcZkci8AqqyR11bTvyO3IhL9FuJezScv72mJOcY1dd1UFo5jw52s4lNzlw0GabjfFJ28p0OUvsOm3rNrCsimantWfbH3Co34n6zk+Zwks0Z+QlhqPd8czmbD0U9M4obr9fXVa/vy13VP800mKwTeKVdiNkhwrwsk+uR7bfVFMINS9Az123ucG+yKW3Ewg0UKarIWoxBtbee5DvJtTF2QMP82/OJdOeh199aYxtiBXkRlxw9MSpxFfu22KNKx7seuyr5bWEaPeQhh8DXlw44jamBpk2k7vLUE+8fFgId4VAuNySikbE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(86362001)(47076005)(26005)(356005)(8936002)(83380400001)(16526019)(2616005)(82310400004)(186003)(36860700001)(81166007)(54906003)(7696005)(6916009)(36756003)(6666004)(5660300002)(4326008)(508600001)(316002)(336012)(40460700001)(8676002)(1076003)(70586007)(426003)(70206006)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 03:53:34.8000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825b47ff-2ff4-4f5e-600f-08d9beb54d94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3182
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
Cc: horace.chen@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
gmc bo will be pinned during loading amdgpu and reset in SRIOV while
only unpinned in unload amdgpu

[How]
add amdgpu_in_reset and sriov judgement for pin bo in gart_enable

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d696c4754bea..b0f4d1ded977 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	r = amdgpu_gart_table_vram_pin(adev);
-	if (r)
-		return r;
+	if (amdgpu_sriov_vf(adev) && !amdgpu_in_reset(adev)) {
+		r = amdgpu_gart_table_vram_pin(adev);
+		if (r)
+			return r;
+	}
 
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index db2ec84f7237..c1adb212276d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1717,9 +1717,11 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	r = amdgpu_gart_table_vram_pin(adev);
-	if (r)
-		return r;
+	if (amdgpu_sriov_vf(adev) && !amdgpu_in_reset(adev)) {
+		r = amdgpu_gart_table_vram_pin(adev);
+		if (r)
+			return r;
+	}
 
 	r = adev->gfxhub.funcs->gart_enable(adev);
 	if (r)
-- 
2.30.2

