Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C812DC32793
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 17:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C856110E7B9;
	Wed, 18 Jan 2023 17:28:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB6810E7B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 17:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtXzLaJ0yZ76ll0eDizUYo1xDAjWPXiHWq7ZXcETOqqMTHgY8H6feHbzGILZUpDMIss4yuPpWhUhvrXSuVGaK4hqG2tlUrE0j65pJwC8PnjO4YI38jKqHPxPIYDOlARP97pPQ40oCtT9b+38hIziii49R8ZR8exoTx+aH4EvKm/mSCC+wRsyc8s+vKsqj4VxKqdPZRh0ag1fcmhS56DnKt47uFyiw1UQ15QkBIn+8z1HkUmH4+lMVsiSRk5b4mauVS1bgskoSWdf0O7PVQrdUANlaIhp8w/RS8E04GoEeU/vmBZM/MGl/FysmGDO919Ex7qbKEkVFiP6IV+scAQJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3prS2AyyznUBpv7H5HTBliidrC7agVrfwMG795qjbxA=;
 b=InQb8eQbPfcFYZVf1bSuNiguHaED4sjLLQ5z2S6LPesvRmm3bGsib4wXBKNei2JlYMKNE1WcMLMh/yuA0M0bQCl0lNl9rcPRqB15C3gDJylUHbvsPY0TMLMbTcOV5YOG2Qfo6iJXVgb5UPqFwIU53nzJIQKbmRgiOZ5Vyw1TBq8BieDrm1KhZdvs8yvHeUOlj5DTY5OSHJS0Pl4SzJguoE5cLwpkt8oBIKi2aYQsDaXDoKeA0ROWhd3nWbg8M/AugtYIG9kan6yI9dtJmXi2FLLLcAbji5qXLU5hVzbxaAG5dQit1qRcQNaF2nihLGgduH2ENMoP/GAzUPmoSD953A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3prS2AyyznUBpv7H5HTBliidrC7agVrfwMG795qjbxA=;
 b=aKVjQ8TzIis5/Ga59vz+c1P9JTkWxcWYtgzd7mpNG8qav2vOExzKskILChS8XI0vPgzOZSVecOx+/Yr+EbmJjqt171KXw7FCCjV8mbPT/xis0rbPLQ2BhPGmOIw0Ec4z0vmdTPNXrJA88dOoa8V04MYd952Ivh9Ay2yVB9F0WnE=
Received: from MN2PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:160::22)
 by SJ0PR12MB5423.namprd12.prod.outlook.com (2603:10b6:a03:301::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 17:28:40 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:160:cafe::27) by MN2PR13CA0009.outlook.office365.com
 (2603:10b6:208:160::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Wed, 18 Jan 2023 17:28:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 17:28:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 11:28:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] Documentation/gpu: Add MP0 version to apu-asic-info-table
Date: Wed, 18 Jan 2023 11:28:38 -0600
Message-ID: <20230118172841.5690-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118172841.5690-1-mario.limonciello@amd.com>
References: <20230118172841.5690-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|SJ0PR12MB5423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f40788f-5ebf-4d5c-3be8-08daf9797094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+taSLpGPhv6tMy7vl4ncguqfe+nmidV0zqhBF5N6GtgcYPINl0zg+F6daeseV1nUt7FZjU5+LG4JY6PMdRw0sBcgnS1v4phNhw0cOfVE+1kwJaKRT2QYP0q9glo05Qe2NXDsPCOPd9kGHs7GXo48i4kF5Ov2na16ZlPcm9ewx/lyKU7My19vEGIzHl5OInTgiIfM2GSsFTKpKe5lurLjpvqL2Ke1Ntw9N3AL8r2g+Rfl7dtKx3D26Kk0ZOoG/oxDfO/IuAHi20GWDSl1pMspOCqtSR7Q9Wt/qaN+BV5bRVDG98EXgnDh8IkdAVXZ2Ts71+HFokUkheXgLutHTCT/h5Sr2Zb8O1rUTL2J9kXilQZsTdWHT32yeL3KqOUpIHcwJW6FgJ6WvfmYYosxt4F0TW0osGNvUVCvTlWR+Xfxrws4r6wkpbiVjAxvVlpUbY5kFxE2Zt6QeN0GcsZQTSOP/Ajx4bF+a2ac65zroXAuRL6tIpkLuju2u6gskb10jqV0E9p/bYMZye84VO6Wozr60/x6UnTOKh3B+7TjGHEHhZrxfFD4pdsiPqfWCpOqJ34QCLoVnsrU6VF6t4P11sgAsK3kz8O3CZGsv5MXNv/sHjddUXop6a4aOQM6QyUv9DR+xHvcY2fHzt1TxVZHOueSNsKJqkgy59lYXTAzti03xTN3dBHWpfsm5dOz0PUOBNM3Gulm+fpBPFzlrB5YiIRdgY5Bm8bForfiAcqQE7RJXs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(86362001)(356005)(44832011)(70586007)(5660300002)(8936002)(2906002)(36860700001)(82740400003)(81166007)(70206006)(54906003)(7696005)(47076005)(426003)(316002)(36756003)(478600001)(82310400005)(41300700001)(8676002)(6916009)(4326008)(40480700001)(186003)(16526019)(1076003)(83380400001)(26005)(336012)(2616005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 17:28:40.0374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f40788f-5ebf-4d5c-3be8-08daf9797094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5423
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
Cc: "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MP0 version is useful to know to figure out which firmware is intended
for a platform.  Add a column for all supported APUs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/apu-asic-info-table.csv | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
index 98c6988e424e6..6e14ae82e97ca 100644
--- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
@@ -1,8 +1,8 @@
-Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VCN version, SDMA version
-Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3
-Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0
-Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2
-Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1
-SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1
-Ryzen 5000 series, GREEN SARDINE, DCN 2.1, 9.3, VCN 2.2, 4.1.1
-Ryzen 6000 Zen, YELLOW CARP, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3
+Product Name, Code Reference, DCN/DCE version, GC version, VCE/UVD/VCN version, SDMA version, MP0 version
+Radeon R* Graphics, CARRIZO/STONEY, DCE 11, 8, VCE 3 / UVD 6, 3, n/a
+Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0, 10.0.0
+Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2, 11.0.3
+Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1, 10.0.1
+SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
+Ryzen 5000 series, GREEN SARDINE, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
+Ryzen 6000 Zen, YELLOW CARP, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
-- 
2.25.1

