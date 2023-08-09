Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D615DEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 09:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C8610E407;
	Wed,  9 Aug 2023 09:10:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4187F10E407
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 09:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na3scx7o77RcJTIyTHClteAQvSQfbRrkPBAeL/em61tS8+otboS8TSTcppcQvSodBfVwUOVZWWsvQoQf32gMm4h3Zjm021Vs366Pif9sAorexgi2rZHImH861kDT/v2MEth1B63LoXV/M2bLYSuov8bq5CnC1E8qkUAvsv0un7B+EAVDZZUNDzotg3xADU07jhfCBtojbZXTgk5p0tS7EhKkjIKa1DtIq2VD89dvdgPEi3QDq25XHoHr8roGAtXkJgwZU7lIIJuBKMU7hyc/Ppo0kkO8mw001ApUSlhTqij18VdihOyB70Kf7hbbicL5mixL3La0pSkHaFy2KBDADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35w4kJgKdOvCcIf7ZQM7JHwQ+cZrDKhHADoosPJxMjM=;
 b=BZVqTEugHPNSJZqYOfJMQd6nn4utRW9bNP00sIcuctpwtu7pFEp7IIj8jUnbowJLjPG3ONXx+CzO/W8IZfHO11iNv8JENjKD+gFqWO9vEQfAIeKzn1odjW1/uudgQJNFTStGt0WVlAefEeulGDfq2Zekt4wWBKdtyu2XeyClfGllZNQcjRq2ZarxYGzrvwBJl5LcVu87NveS1g2YGzksn42ta75IzsDzfP1fPVY5j3aERpTywR1iehptSQsNlGLb9r4EmcWOhAaYqlw8f2klFDZgDtJf6/6e4LWxFVFPVHrTP1WZ0bZpSzoYWp9V+BpXuUqK0zQCGeiBqWBS3fe8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35w4kJgKdOvCcIf7ZQM7JHwQ+cZrDKhHADoosPJxMjM=;
 b=aWcOe/zJ47MW0P0e4F5sCfLSr9NLJXO7Pti0gr6tozbczYrDD65D1N/SZCee9qzuj/sOZGURU08dBXTDp8kGksHuW2t1CEino0lT5K/33Qh0NohtuQ1Ttq7T4mdgLtgQWBLEc7LFXHqbfscx+hKdlARt8gxqzHALHeGfsyHaOUI=
Received: from MW4PR03CA0112.namprd03.prod.outlook.com (2603:10b6:303:b7::27)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 09:10:09 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:b7:cafe::fa) by MW4PR03CA0112.outlook.office365.com
 (2603:10b6:303:b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Wed, 9 Aug 2023 09:10:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.0 via Frontend Transport; Wed, 9 Aug 2023 09:10:09 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 04:10:05 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Add vclk and dclk sysnode for GC 9.4.3
Date: Wed, 9 Aug 2023 17:09:51 +0800
Message-ID: <20230809090951.435142-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: da681298-6e53-4eed-82d7-08db98b86e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMp3cp7BDs/4Yrng9Y04I63CAvZTyKC8v2FjCUFXQna5coKsOVhXDgMxIVPofIMYnrAo2MC3xTwJm+DB09rTxkBVlcNGH05g6yyhsLoPSXYG5vIr/8JduEjfSg6dc9E1Z9rYZn5A2EmQHJ7voYEC5QcD0yN389j4G8Bmj+FqVuaULIF76aL2OOdgmj9MvUNGouRiPmokHUleskrGRll7hM2MKe+GmJEkPriA1G3+4K9+A75yQso3+hMQewHlOKq0KuRncLLS4i9LJPtCia17KS+vrxxFOsEYMT82ReXp/Tu/ENNDqZEUhGpD03ZPzcAqZLPp8C/BKqYIOYs03vBSbDD6SuQoiNqpy9SnRk9wK1RF4ul3+Avuf7/L+TTChU9nV12YAA+VrKL7Opbb7mIlk2gZxMyIAVANHo4hai4cvm+LR+CGYa2lS+RwWR/mv/Dikm63kVppei5xnyOPntZoMcRDuAcvdDq4c6qKEU2sVV7GwMyhb9PVg4Bj7kxUqHDpxLfqE+31FgkNpbacSetSgXSRdzv19nClrf18sn8+cXwrkyg5cs5VOKb/iPFtU0b98WLmWHG2+yT/nUROT9erfY3leOvF1uFw2MmmuMbl0ETkUe1B7+F5YjnlWAto96PIb/xon6zdlRCgPmfFmOqLLjU/WA41LA0aFD7QyD7BwnrL2bDzjP5RnaMhfoCvegmtCGQ+PbfeNSN5hM0j7jZn60BiarFsMXZhC4QqS+V+Ume0A1/RXRQZaibfvrbVRoILN+T0DUI3LVp/ChkkqlmRUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(82310400008)(1800799006)(186006)(36840700001)(46966006)(40470700004)(82740400003)(478600001)(40480700001)(356005)(81166007)(54906003)(426003)(2616005)(86362001)(1076003)(26005)(36756003)(6666004)(16526019)(7696005)(4326008)(336012)(6916009)(47076005)(70206006)(70586007)(40460700003)(8936002)(5660300002)(2906002)(36860700001)(8676002)(316002)(41300700001)(44832011)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 09:10:09.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da681298-6e53-4eed-82d7-08db98b86e3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, asad.kamal@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expose sysfs vclck and dclk entries for GC version 9.4.3

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 3922dd274f30..e4183d6d7f39 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2095,7 +2095,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(10, 1, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 0) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 3)))
+		      gc_ver == IP_VERSION(11, 0, 3) ||
+		      gc_ver == IP_VERSION(9, 4, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
@@ -2109,7 +2110,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(10, 1, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 0) ||
 		      gc_ver == IP_VERSION(11, 0, 2) ||
-		      gc_ver == IP_VERSION(11, 0, 3)))
+		      gc_ver == IP_VERSION(11, 0, 3) ||
+		      gc_ver == IP_VERSION(9, 4, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
 		if (!((gc_ver == IP_VERSION(10, 3, 1) ||
-- 
2.34.1

