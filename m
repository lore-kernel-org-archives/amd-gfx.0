Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AE9C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3B710E402;
	Tue,  9 May 2023 22:10:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2437E10E3E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ6oFU6G4P3J/1R5RoVd8IlI+iD3VE7HOG4E5lbnsMxP0ouUU4ms3BdOzrMzEXYzOmNY+gdXX9vU9sSKZZ2lTndx5Gmz23hFDdMKtRSzqZJpuT2qifLj6u4ncAGIfaEdst11TDyuW66itFPHiOCOiYkFvKtb9EMOVJlZgNfs3ejprLjs0DKA6ct32oJfI0X0PSOsCAUKX9mmj4DfDY5o2DIScU0lkJWi6n6wVfZxUB91pdZA/WKs43NNrHAew9dVlc+UemyRMG2Ri5sffdMl8GJPk5ErenzbcHF7+chlpTECBPmhLtyveSopXlSVvl0gmIH79HHMUl7wGRNX082BQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H1XU8BdFQ1qxMH3V3gqT6RQOlTx2RMUJtDeBZYhUwc=;
 b=dXQHUihVBDE196l9Ed8web70kX/iBACv8GkLucPLBUqeZsDM/fNr3Jp7sFLNc3CCIL1+liecMbnIIskU5FquLIaazPR0PaKZ0RwUuaLPNWY29KeMy6NybHv5J6jfGbMIboQt+B2dELJJI5L/4wNcQdr59iVznnvDVUgJXOXRqg7m5FePOqPYB7mkO1UjoQBfTPReCqhEVv3FlQRaJ6MHGZ6McfXi17SAED2qtHFT71USfmjDrcJ3uWd96Z/T6Drp74I3GJASz9ZtXjviZhFCZrhR6HRf4SdE+mQeEYsxI8EOfB1xcV3G0K1UAeRJhGqc9puaSfdzIyll6P+l/9B2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H1XU8BdFQ1qxMH3V3gqT6RQOlTx2RMUJtDeBZYhUwc=;
 b=TtlqpR+yt+jPNObv6rgMdOQc9di4thEzCBCg1QGSQKt0uciEDVPh0f0mm7JxAX0ufGULlsYlTlZGj6MiiscERBDJ30JRk+f8P51oslSjr0TnI59oTDj79h5CwKaGybC2S9GT3QFZ+DO1yFngUsZanONG8M9Ge4vskUoJq8bGiTM=
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:10:18 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::43) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:10:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:10:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: Add API to get tmr info from acpi
Date: Tue, 9 May 2023 18:09:58 -0400
Message-ID: <20230509221003.475858-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221003.475858-1-alexander.deucher@amd.com>
References: <20230509221003.475858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ebd189-1c96-4c77-07b1-08db50da2c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swn4VaMtQll6brwIy/q7Qh2h1BFukVkliCvVVY3quHb3rb7Fbnamuxhkhq/O5MxF1vhzz9oj8epr9m15zWsyd11dmqnt41IYkLM06wCddbjLn0uYnJMf3LglHievyn2Ut7xFLFOg1z3Fzvc2HSARFrx7q4+8ca9Reb/v5AOi9JRi/+fdfRCr5taxpeHxKXQL+u/66ElL69Kie38KFDKHAKet419qDjkh/FDmtwnzKbuXxhyjb9vkAYSxscGJk4QwcM3BgWnqVSBM4yYVsI91wDZ4VjlLodxoCfOJHnt+OoTPHjbxV0b5i6HnSaTiQfZATctZItLhnZqAen8Ok0T4ijOy7rNsJxFGimR0B/KeOgMvIqZ8NaWaWYwn027F0pw34GW/Y0hEsptxBQNkJ2hSgXipDC91Mw790/5Ju1B/mN9SBsR8iVWWgAQswZmk+UnH903IpTcnSJzpcTBsMdgHKufhQEdJGAseuFEWv04/3GyTN1G8LGoqOjS39o93qj/KACokmioLeY/dSpJ+jhOR+2dXIklvdAs/b5U4eKa+mNvsttxyvnGkH32URYi8wlCStYEwbVWUwGL7ziJj8XWnRq2Ps8GDRWywtm1/enjwt5p5R/cnojGFJU6i8exnlVvk4cEfJewmuYiME2NrNk+8/2b8v92G8xGJRry0AAEiikJoPztZOAPmuC1l3y0lhc4KnCQ0ezczH8Idqc1PvhK8UzNZJvBCDYIsFAI5QtIJYYk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(36756003)(82310400005)(41300700001)(82740400003)(86362001)(2906002)(40480700001)(5660300002)(8676002)(8936002)(81166007)(356005)(426003)(4326008)(70586007)(6916009)(47076005)(70206006)(478600001)(336012)(83380400001)(316002)(186003)(26005)(54906003)(1076003)(7696005)(6666004)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:10:17.7091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ebd189-1c96-4c77-07b1-08db50da2c31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

In certain configs, TMR information is available from ACPI. Add API to
fetch the information.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 196c2a8a6b48..65b3aeef37ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1421,6 +1421,8 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 				    u8 dev_state, bool drv_state);
 int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_state);
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
+int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
+			     u64 *tmr_size);
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
 bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
@@ -1428,6 +1430,11 @@ void amdgpu_acpi_detect(void);
 void amdgpu_acpi_release(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
+static inline int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev,
+					   u64 *tmr_offset, u64 *tmr_size)
+{
+	return -EINVAL;
+}
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
 static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_acpi_detect(void) { }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index d9cc07e01293..52c16b041193 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1072,6 +1072,26 @@ static int amdgpu_acpi_enumerate_xcc(void)
 	return 0;
 }
 
+int amdgpu_acpi_get_tmr_info(struct amdgpu_device *adev, u64 *tmr_offset,
+			     u64 *tmr_size)
+{
+	struct amdgpu_acpi_dev_info *dev_info;
+	u16 bdf;
+
+	if (!tmr_offset || !tmr_size)
+		return -EINVAL;
+
+	bdf = (adev->pdev->bus->number << 8) | adev->pdev->devfn;
+	dev_info = amdgpu_acpi_get_dev(bdf);
+	if (!dev_info)
+		return -ENOENT;
+
+	*tmr_offset = dev_info->tmr_base;
+	*tmr_size = dev_info->tmr_size;
+
+	return 0;
+}
+
 /**
  * amdgpu_acpi_event - handle notify events
  *
-- 
2.40.1

