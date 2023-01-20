Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAD9C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 08:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2697910EA86;
	Fri, 20 Jan 2023 08:09:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA15A10EA86
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 08:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx3vCJqN5VjYTcNL8L9SOAcfq2GEIRfd1srftN1zqWEMBNPFu/zGvnBEgnuVnVLpK9SDo0wtgt2aMyYS5l5l8doh/a6UFXv4pw/x2MYSfff8047X9cRefY2PKvjDKi+Oug+e4JyWk6OBO//cEec/SFCOKWnlNjkEcoI6GflxWKrjmLeDsvjd6fXFsPmx2hI6WmBzGDp7WT7JGxI98ide7ZUD/xa/auUif+JbyqDGCluZIPs6nA2YJIRokI7MDr1VqMproIdCv7nkrTMQ0J6H9BFmFjZnH4i+Op7F6Y73J56dk/wthWoFHh1SNI+NKMQZ9AEchXUXXlDoPy6U0hFGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFboN4v99WEtx9nv0Ru93yXJ00iHAXbpEsaWuH1nwlw=;
 b=Ov4ttADjW49lWpEf+4v5tqcXD89t2Ctm33z+6Sxuzmnq1yUi6lxaNVQ7eHwlNyqla2/XguyUV5o1+lYJJGe8SPkfIvfMHz3HAK/EP+EjO5wqO3A1syTf4mne4e649T4xtZTTll84IF6tzo+zE0N6nb17oWOtxIo6uKmjJgpgfZ2NCYKUXvEtQZG7JRAz8fqqZIkrATyE9sDVaQgc2JfdpaUOo2as306eHx0FuYiiiM3f4BNyrYOO10YVCmm237X2Ky14IXXEZ1NdNXYfat9sir98usfnzfb9IAjTpyrFMBumzgBZes5ddyg/0M/niBeUPjkeksj8XNF7V7XKzyrYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFboN4v99WEtx9nv0Ru93yXJ00iHAXbpEsaWuH1nwlw=;
 b=a8tnj7HrldQ6wmslhFcwC8bm3jhizNGvnLEFx6BPAkaCj1XgUXCy8Zu6G6lJm8GmOZFXjmDyUyfP1YEZMIfKdIH/7TaEgCJJmwoPVQVEIyCdnssX2u3VEjYRVun8uarvX+E64I57mFFYp8e+k2uyVmfr4Nm7GRrZMo6h1vyKBxU=
Received: from MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 08:09:34 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::47) by MN2PR03CA0024.outlook.office365.com
 (2603:10b6:208:23a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 08:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Fri, 20 Jan 2023 08:09:34 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 02:09:32 -0600
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: enable imu firmware for GC 11.0.4
Date: Fri, 20 Jan 2023 16:09:08 +0800
Message-ID: <20230120080909.948932-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 0830695a-e499-437a-a562-08dafabdaa9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQFkcFutMSulYM6CjsCqWyXtvAmoVjSmWMJyT4eN/O8HVbruyttZeoVsZ+/GtXmglOxe7lyvj0Nme33T79iZ8yrxS7ovdgzihChqpXB868ksKsdEsGSmsHR38tLgWFsl8joC/0qvso+XO0TbqLlB9d8tKzsPn2WxjnPIWNGdCNrVO/bPrOyIw7wzxs2q3+HrmKbZMH7fKFde8FxY/VB8LWrVukfjDk7cw2HYmNoznHL3Dp4nwlN52Dcmb+HsDjdH2GwDcNPxbj5891JGm8605/vrwWJLeJ3+EHSpGaBXHusKEelhfsLFaDxKl+V8O0Pj34f2ztWzXW5UcdTk0jGiqNzyXfmJUnUFuMsccANIV9TEKRUWbIZkgsBb9aeH8DfPwzEpyktq6Pszu6YmJeMDVBoarU2W2LI2bIw5ZoxzJmrvLPaL0C7CujcvFDjm11GzQyog+gUVdblCDvDaoTLeOz5yB5LeGrZBRE41N3LRKKpEWiSRZJvMjsu/csK/gDY9uHoputzj3KIuoR6IIB11jTmj0gYjYVQLGPk1bLKw+6JNMsBIqtKYDy+5cXpjtyFWqYo0RtsrFM7oaQy2uj0xSey9aNM6GMFDWpppncKA8TsHcr9GeqJ9Qa9Po6Zyyx/3sBRTm5XpgVaqTLSjHZMjGJztocirzjjPq13NS5OWUfGYvq4Ncxv6Z+s7PcXFJzwztwuUfUnfXqyQJuz8xMbJ2MYtGHQayRU+xHI+eoWpYJE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(81166007)(70206006)(36860700001)(82740400003)(44832011)(356005)(5660300002)(2906002)(70586007)(4744005)(8936002)(8676002)(4326008)(40480700001)(6916009)(1076003)(41300700001)(40460700003)(26005)(2616005)(82310400005)(16526019)(186003)(336012)(7696005)(426003)(54906003)(6666004)(478600001)(36756003)(316002)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 08:09:34.4034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0830695a-e499-437a-a562-08dafabdaa9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, Li Ma <li.ma@amd.com>,
 xiaojian.du@amd.com, tim.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The GC 11.0.4 needs load IMU to power up GFX before loads GFX firmware.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index ed0d368149aa..4ab90c7852c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -35,6 +35,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-- 
2.25.1

