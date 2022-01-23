Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA80C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E83310E8C5;
	Sun, 23 Jan 2022 18:21:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948CA10E466
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TU1aeEraBCg9FM0jwCuiH5BEISXL+7HkxeN4lVyWWJjNr+0cVPIbuQbroC+7XgIFYYyPHxBfbYIeWD7lvgmh3e1h1y9Bzed1/rPDxAJQZEU48RihkCOEj5sOZYFppsz1g0phhVgGLXWloLOU5ADiRvzCl8dX16rcIUqB+6FhXX/Kk+t2MYXNxy279qJa98uiUCHbL1k+aVqJU6PN4x7K5Iplum1frU1+15mEjb8cMDmJ6QDtn5z2l0O0VZPuYA3IBwMmd2zRZXqKSi4FKmeE9BMAcc684QLyJPB/KDZezoOOcLrVQqceDrdMH6PA6SYEqeKXEgXrbnLzV4bMMSzAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8K89pGxcARtrnwJRLnshF0G2np4RIsL5f8a0NG+Cv0=;
 b=kiELojotZZl8vcu+Rzw3A8k2Fk/1IpSmX706OuLxl8ZfzcrZsXDk5+u8CdRPizwo03aW1/TWw9iDPoUYnaDkfyle0u4V1ORQ3qnl4ABaYgGbhQBkDkTSCN7CF3Sd8QdPcZTHoOzNAgwH+dYuJ04cumJyVuHqU9KlOd3Zg5Ar3QUjhOqkkR/fh13pPw2xOt7C961N/2cag5qAjEElYLMSzMPGrk40AilOgJMdS0YAFC/XVQSmv9y7bv/vQ0sWTFPQ6pq7XZ2w9iaxMROSeWxpL6FTl02rXvMWrAJI3F9aMbtIdHzsLZu2YJv3bkS+7MQRTf7vv6uEiJZ+o2rKuUeN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8K89pGxcARtrnwJRLnshF0G2np4RIsL5f8a0NG+Cv0=;
 b=N5wT+WXb3nfUf/LMs5WvuJhW67bkY/0Lf/Qto0Tl8smw3inEA8gHxPAtZOtK2yFcsDLpsekOvvyFaf7gHOi31pJfbO5XqZ7Sct/sqWE0ugfhGLvwCx+VEdiMV2tmoaQsVP46ZYd7SJgfqjLrMDrqlJlrtYrJ2cmCB2VLIcT1VrA=
Received: from BN9PR03CA0970.namprd03.prod.outlook.com (2603:10b6:408:109::15)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Sun, 23 Jan
 2022 18:21:14 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::7f) by BN9PR03CA0970.outlook.office365.com
 (2603:10b6:408:109::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:14 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:10 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/24] drm/amd/display: Reset preferred training settings
 immediately
Date: Sun, 23 Jan 2022 13:20:14 -0500
Message-ID: <20220123182021.4154032-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 027afedd-8f4b-4f92-8b2c-08d9de9d23e8
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2717D9C6875DEFE837E279CB985D9@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3zDGE++Qyr+ZhjpVO9JJpuUDOFOloXXgXmF7TGaU2Gnf0ric6kjkX5jdPn4u2Cs0hb3sdXINItxfBTn7MBTru1W3GtsoPipelBB6q0/XmzI5rrQDaqYga09mz68Z8QRyJ0NzPQe9OiTRcWZduahJGeZSvodvRYEes7D3l+FWASW/G4rp/IjUbKfVMO5QFPvrkysv69irOF2IdWE1WS2OMBbAz+XjpyGhvrTFIiNdbW22Fp/Z3ArWLRxiwPVwn3yglf4BFW9HIwFl5SEFDIHocGnbDinjR9lcP1Y2AOSHmPtKiryuH7VfU4w8giFW9eFaAhgy+Sld4yy2hdAicfA+zzo6omaoCwNmtr2Vz/y4R6bxyJx62TiQLsY3CS39Fxremo5yUN+OHuJ7ESuRBvbG56vCJUm9PQZAp/EcPbJCy1YJgYc1KjFTPU85CHUuAVzwSCXlWNW7pQxWOPCLAo/5efiNA9b/s4dcufiADTdjmsPlk6JRMxv5PpP7AxE112HyVgdQ3xOVQhCvcBx09XJV0xQKd9uLmn5buPRpqUZRwQ2gbiLESLgGz4eZ370FGZN4FIry3aUXA2yeBuIBe+fZ7rnbufSLyWC1zJBNzUmsmj9PWo3GFJIiO7qnXDpgdQfBd45fAFqX4BRnmS73+hbSS/cIh6p6YqsrJKsSZwPh0K88HHLbjLKkUdD5hXeP8pEfbrMfbkFkdb+iQ12Q/Tdc1nwGP8uWaLxMSB8vlzGhtI5hCHSF6RSRq5gr7j0tgmsvwBdoePO6b66FjxomDt8lWZkM9gyi/ZaBz+6nhi7XUolfkgyg+6uc+6I9tQIo1xnOsLSwFcyhkik1u6hQ4Rl8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700004)(46966006)(4326008)(508600001)(70586007)(47076005)(36756003)(26005)(336012)(316002)(8936002)(70206006)(16526019)(186003)(81166007)(6916009)(356005)(86362001)(40460700003)(2616005)(83380400001)(2906002)(426003)(1076003)(5660300002)(54906003)(82310400004)(8676002)(36860700001)(14773001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:14.2841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027afedd-8f4b-4f92-8b2c-08d9de9d23e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
In order to easily test ilr by immediately reset the preferred training settings,
fix the code to disable skip_immediate_retrain.

Reviewed-by: Solomon Chiu <solomon.chiu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index ded64d0e34c1..c783643d2940 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2851,7 +2851,7 @@ static ssize_t edp_ilr_write(struct file *f, const char __user *buf,
 		kfree(wr_buf);
 		DRM_DEBUG_DRIVER("Invalid Input value. No HW will be programmed\n");
 		prefer_link_settings.use_link_rate_set = false;
-		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, true);
+		dc_link_set_preferred_training_settings(dc, NULL, NULL, link, false);
 		return size;
 	}
 
-- 
2.25.1

