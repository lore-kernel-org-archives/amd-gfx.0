Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00178C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 09:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899E210E22C;
	Wed,  8 Jun 2022 09:06:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBF310E22C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 09:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxP7E59ooWaj31IjOqoIJSwbhikFbpAwapAO3uySZI+nCDlIynG/ZUaNKvf7qa6AQAoflT7YaTrvQMS+bETS2wx6xq+t1OaJpR0BOTPDTJVjPayOANOYKutDtznL6MVOxqZ0hhLN74Gz7y2O483adhAwc+Z7a5sED+PcAF2DdKnStsr1Hk26p5Q+T9ra+rkkXxwqkcFN21yzb1KddN71fscwmdk9mkayPKNhvxAgvfRQvEn+QDdm1+MPAq+oXnDLlfzVIitmtNP7IZhSDQN/TBvRoTE+ebS8pmhXHPuQDcE+DK2YQLkiTSLrPFkkIC2Xv+f+mD+mCIRD7x80cdl9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgG9OYei5B1waBnRjt7a713yuI9QpqjC7jyKgJQaLQs=;
 b=BNWZC1fUarGRzC/o2l8YgAHkz1Dn5CzD0B6xis9/7ZiKpZWM/DsHkIyDcR9dgD/I+HeJfTK6Z5Blew2q6VuS9aHCutK7qmXF3pvgLvmRMmf1ZCCztl1A7wGUiDsXUaxLAg1aMwAzo7WNi4ndF6lzKik2aaYJMECSvO28AfIqAbxOTLTWStewtTCwb/EaA6Dij2vz9Tyf/2PZVSQnGYcNRvUDei2GLYfbfkpYCTW86YoGUYriPmHNDXB6sVm/QkHgEaSqZrN4PJmhUnXl9XebhslrWsfhqSqvSbFNFeSfp0JPsXh/nzgBUuj3BZ5jKQZv+IpEOsT/sLh4n3tkgBgRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgG9OYei5B1waBnRjt7a713yuI9QpqjC7jyKgJQaLQs=;
 b=SEo0ciDFyrWfIIqFHmFjN9KBPJSXG9d7yzm668cLo5UWplIVR6YpEDiT2vF/bTYhsABxYR49eFuShwHo92CCeoo4KoAm82ggv2T/SevTo2uH/5Zl+qVzCU1vULMkd4CzK5+0t1nH9pU4vjuK0FESMqvnlzKfsnrsLylQqy2NEO4=
Received: from MW4PR04CA0384.namprd04.prod.outlook.com (2603:10b6:303:81::29)
 by BN6PR12MB1316.namprd12.prod.outlook.com (2603:10b6:404:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16; Wed, 8 Jun
 2022 09:06:01 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::4a) by MW4PR04CA0384.outlook.office365.com
 (2603:10b6:303:81::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 8 Jun 2022 09:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 8 Jun 2022 09:06:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 04:05:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 04:05:58 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Wed, 8 Jun 2022 04:05:57 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amd/pm: enable gfxoff on smu_v13_0_7
Date: Wed, 8 Jun 2022 17:05:35 +0800
Message-ID: <20220608090536.1969621-4-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608090536.1969621-1-kenneth.feng@amd.com>
References: <20220608090536.1969621-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e846348-3f2f-4625-b106-08da492e1bb8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1316:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13161C450D93792474527A488EA49@BN6PR12MB1316.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHzIKTUsyx80fdi1DZfK+k26jil3iYgIEBpLJmbUUy52U2j0xWALe4ZAsbPSs0pz8TKj8+y4c5+q7YCGpec60xmYUac2o2Y5A4sXFp2tCDtOyWgu501GuPGNwaDjwXOVKwe7gbq2J2gvx8v04AbMZFP1AnCxdFobeJJd1ep2eleJu+zrziK1nat0zO0wHmIopnUyX0UKehqhjaXVYmrRNVGJiR6lCRiIFtCHfjoO7U4t56thAOl3h800cxdQHZ89iKvaB7jTCenapmgfltpzWbzeHgYkuG4PWh0SeQxslIp3dGGtY/wLKSzK6L4JRR6b3WiCkbXiHPoBv6ZWC5qWOEixfUXfRj/i2l1XMuI8fsNms/Ix+4Czx1MkK2v8qIjmfo2MplnF6NrwI5UJrEPHomKqemb10r/6KovAct7+ZfQLAs3K1zx7rcfXjfUseaLedvzBLz7ydMjS8WzWLqzJkaFGpyC2pHXP8Xxx4aokqqAgChGePuHPiNyQy2qshNOR9mKnwaqLIQ/96SAzBiaTaSilAzh1aVfyDH6PDK+BXTsDIeOG91G78VMUL7T4ydNJgzIDhOJLJCd4Oeu3KmWR3Ed9gSYLeXoBuiCDWFwpksX6TZR+OEPEHt8XBYdgCsCs4Yx0tDSfllnFWMrWi5nyLgCVL8gv/nPrGXdhTxDnclr9MKlGJC0Nw2Lzh404Esn9FzclRyULNqj8pBDqoEVeIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(8936002)(336012)(426003)(5660300002)(6916009)(47076005)(36860700001)(70586007)(8676002)(4744005)(70206006)(44832011)(508600001)(4326008)(316002)(6666004)(82310400005)(36756003)(26005)(356005)(2616005)(2906002)(86362001)(7696005)(81166007)(1076003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 09:06:00.6883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e846348-3f2f-4625-b106-08da492e1bb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1316
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable gfxoff on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index dc614befcdf5..b635c2b4f81c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -249,6 +249,9 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_IMU_BIT);
 	}
 
+	if (adev->pm.pp_feature & PP_GFXOFF_MASK)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFXOFF_BIT);
+
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK) {
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_FCLK_BIT);
-- 
2.25.1

