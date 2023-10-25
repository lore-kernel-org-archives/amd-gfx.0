Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBCEC07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 02:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298CD10E53C;
	Wed, 25 Oct 2023 02:31:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 702FC10E53C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 02:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPSnDQ/UaftUDJ58abAF0VJVCrLKF3Ud95m57MhuGZEcXismcpYbwu++n6cFwN5Qy8dOZyZI/MppPmdFhmyNSiAhk4+yBAAYCidltE7wsibTqY9G2TsArqga8zv4vuysiESDW6goF4eg1inZg+KkHHQgwYhqcVjbfhrbTrxMET2sRxFUhDoFjKUs/RxSsOGuZyXXwZDNvEMdvFPHtAJ/3Q83iOcerGFmFvgzIrOvCerWGRERjGFLNHEAWTnMvSConYblDXXTAKm/KC7PbI2/AOUkoujtKeCVn8jlPdvp6GGqp6q61lUWevV+8/fs7Y8h+nb7Z1JrUrktY2zaGDUMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7HN38brS7p8WVt6lO6pHn5Mqrly4rgnm4Pn+AVKTqc=;
 b=LMHQNwhiUD9Ev5akAT4LA7/XB6x3alSZtTloPw83EPuLShEExZMuGkqyMMPXucKQwEV5g8Vg8qBlKoScJVbrx1V9Yjdgh1/DTIMBVocRNUaX13ejEzWGgCZI2T51hVFplf5VNnw/FE2gHwu+pfWHUZJSiMLtuYSHDEdFecekTgSVR6PpBBLh2GJmT1Y5B6og1pg+htlM5jgVIErOjhxTDCFYtLi78jLX6Ray9XedrjlsnyVy7c0eKjgVCc3SVX1eE04tIGfChSic3t3e679RxG90MjSkl2PYW/8QHA0ZjOZKIAFrjBQjOPI5eagE+o+UetZj+lCafGlyiFzis/aAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7HN38brS7p8WVt6lO6pHn5Mqrly4rgnm4Pn+AVKTqc=;
 b=mcZzoPMmFW6NEP0o3SCAcghrP2GLNdBgNBVBuYRzpexgkbnr61twPu8Ez6wtLt6zFa7VWe2dfQOnyIaHJMiR2LEfMA/S2eY7pyI+UwhGEHPBe54/2SXUrjOMSOs5HLHb0jMfv3yzfK33zx/bSScz+FOcWiBd821TGQkWrQfNI90=
Received: from DM6PR07CA0120.namprd07.prod.outlook.com (2603:10b6:5:330::10)
 by BY5PR12MB4951.namprd12.prod.outlook.com (2603:10b6:a03:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:31:02 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::6f) by DM6PR07CA0120.outlook.office365.com
 (2603:10b6:5:330::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 02:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Wed, 25 Oct 2023 02:31:01 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 24 Oct
 2023 21:30:59 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: fix the GPU power print error in pm info
Date: Wed, 25 Oct 2023 10:30:45 +0800
Message-ID: <20231025023045.343239-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|BY5PR12MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d5dfea-1a8f-4805-207f-08dbd5026e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8G0tzIoVJtC22duxh+oLKrqVJlqTMJmf6KJyVDT6U7FbuSvdaJFlj95PPSb+FMELHWDbA7JaMKVb/MpMynsr3m9qECFE9eDvAwkrm0zNI7+0YcvUzGZMG6npRUCNhU+u+dUuZHuVrsPK9jLl2gGItZq8ubwVTpPzVNJIcxtWPiv6plzU5MvJZtDU68+158+q0S1VMoUlNzO3VfY81FLeCFOD4geqcBodgeZNffV887ok0uxkYMienqFBzmgodY0gqItW7uivi/CtK3uj1/ipHQcklrpU+AO27LXh9c1SyWg7DFgfSC5y7PlKx+LR64ldPc6YxGMp6S9bmG6Vt4THlXXOntjxKq0nwimv/dVozlymkR2PVY5IsVNEKCQMsKE5aY74DpRKftdBv4L9yK8GZdbzt7PxcD1TqbxgAfbNkrvIsUOZ5W7PiYoSwwVPbm1Rmvh1Tz6m4tYyx2VYOzPHv6NKPI3xKueIsTpV5+WpZoOtokc0/IILtHrE7Qbhvug6VS8mgq6IM8vWlsptJdFZ1Qnw3mo98gkLztYg9jNSLldjE6ubrxU3gWbMtSGACZIE+v5BJzBLN3KdsrUNM03pjpr2yQq+o3hHS4kr7j6LdlBTxo7xoygC5DMjA/g+waUmjedt5qvsk/nzjruuKJlV/3ublgKHIA0WYazVWP2rsJeB7AEfhEx2GO7rbz8SM0NKGlHAENz1MugwDkKTN2qO7Fmki5pIDsG59hygTf0p1Luubf9Y9kwPcxNCt/kUwwa+u8WVQwo1lCgRBj28EyXcyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(426003)(1076003)(336012)(26005)(47076005)(40460700003)(54906003)(7696005)(36860700001)(86362001)(36756003)(478600001)(6666004)(316002)(82740400003)(5660300002)(8676002)(4326008)(41300700001)(44832011)(8936002)(110136005)(6636002)(81166007)(70206006)(356005)(70586007)(2906002)(16526019)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:31:01.6591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d5dfea-1a8f-4805-207f-08dbd5026e21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4951
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
Cc: alexander.deucher@amd.com, tom.stdenis@amd.com, kenneth.feng@amd.com,
 Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify the print format of the fractional part to avoid display error.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 358bb5e485f2..517b9fb4624c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4290,10 +4290,10 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 		seq_printf(m, "\t%u mV (VDDNB)\n", value);
 	size = sizeof(uint32_t);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size))
-		seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8, query & 0xff);
+		seq_printf(m, "\t%u.%02u W (average GPU)\n", query >> 8, query & 0xff);
 	size = sizeof(uint32_t);
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size))
-		seq_printf(m, "\t%u.%u W (current GPU)\n", query >> 8, query & 0xff);
+		seq_printf(m, "\t%u.%02u W (current GPU)\n", query >> 8, query & 0xff);
 	size = sizeof(value);
 	seq_printf(m, "\n");
 
-- 
2.25.1

