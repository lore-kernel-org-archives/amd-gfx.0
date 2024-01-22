Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05349C47DAF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 16:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9537210F4DC;
	Mon, 22 Jan 2024 16:00:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E1F10E6C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 16:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzUNlBwgXp/WpemEwAm2b0THMKOjkw8sTyPJ2WN/UiqF5XLykrcd2x6upbb3MLAg9II6WZiYzc6xCIdOehHgCr1JrRVadjWmDlbGAP0RJUqb/ozm0TsEwCGdgbEiFm0IuZapJuwBJZPzDXBkjFTv7IMDxkVX9j2WC/6jjDXm6ephxrQVSn/q2WcS2XOlQrPeq5FFZH8Mg1ZnjqEe6SbUWuZGtqJDsHF91kgJL7NhaOW4i3jxbniy97Rp2+s0yhCJ1nEywOXzB7sRLqEdMO+5P68vE2PP/TBZM+u4keyVsRz3PoiQ10ebGo7orrm6grhAPgH9Caxey6eZVjmwsX2S6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mb6e25Mz1JCl4DLMdDEYRu137loGgQqKrAZQUEoUHc=;
 b=AK0cbG8HnwRpo726WBizhuzpIBwBvxVcHwNHsniAR+mVJM59e+sF3R7DY0FTpxn9lTdHwoKFYXiHGXoj+yYkkzB+qSJRyilYsW/ByljJUdUhkloDmhvL7qMtkUFslCoQpUKuUXJE46qvsKjt3CsXt/FG4ivBIx0F76eaX1aMWBz5DLH/XRJF6EHnQMyG4kPVbI4K/e8Ttx8uYkBnZ+IUfPBMkajFRUqttCniQtEZ3wihdYeK/ef2iYm1iuB2TJJugVOiWhOGmrwfHPZSZECth9LBiK7buwwl+PYG3tXYx3Uoc6j6SReoySN0Hh3+0XuHkWKMdIq/l7JhCOE7K7rAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mb6e25Mz1JCl4DLMdDEYRu137loGgQqKrAZQUEoUHc=;
 b=bS5hGJ15xokbuJdCRa4lh91pu6X/LZ0EWoMKJX7QGvRvJR/B07rB3lYpfsVNZq+Lq+A4+PyVE2cfy7K2/lMqAbqEA7VVSLpa7o9qn983bQcEnGS4qNYyuN1N8mrI6Y7MsKYjhZKTBSeZ5j/otl5iN069pq3TLqEpEjCOLoPkM/I=
Received: from BY5PR17CA0001.namprd17.prod.outlook.com (2603:10b6:a03:1b8::14)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 16:00:30 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::2e) by BY5PR17CA0001.outlook.office365.com
 (2603:10b6:a03:1b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 16:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 16:00:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 10:00:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/pptable: convert some variable sized arrays to []
 style
Date: Mon, 22 Jan 2024 11:00:10 -0500
Message-ID: <20240122160010.1132083-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: a5755abf-0ef4-4696-7db2-08dc1b634182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pq58LQSk5WtDZ9h6F0IL9dW4dD3N8Hb/PHrDTJMYCO/ffaGfdnqfahnvqJHPOx7kNhDyx/XEgrRzTJkbh1Z2UJHBi8m59cXcFm+BmdNMrfktyENWIl4hEkPH3s+gdVlPvvtN2pOD6A3yeNvLYmaxX9GjgTz2LR/WUqrlWcZG2xJGBRkeS6ebtGqvDhKYNzow3ic5x4jga6mthx+8dDF7y58Bg46kekOzb47xwnSWnhrcrc3dcXv1nT2WHRNmPHWYZXycgzpNNVBo/lYpsNatBWPWIVCqbcxRpjrcPkZggkqjYOkegYXGch5pPIGz7wYGP9Eao2GySKvb2Q2YF+1jD41nILjf/xO2FpgNK3FGcFoZcOjb7wRUNpx352HDQFNtXzP2cpmK/err1bCB2wTBYhN59n8BD+Y70wKcKOBVLnAsXXXGCrInhnPEq3iwpQtjv75BkDd0e4k1/jOB0tmH+9s+28J3/q5L2ALP9/MDcWIksJ7Usdtj6WDJfairpeOd3/444mQMvZ2vOxrbPX+WGtScfYnuM28scvDeB9XGPYe7yTVzMAac5FxmbBQAS7lNoMmKzUQxj6OnbXyRFRe8IZHoXkKhcY8pCMkC1ENm9av4x7U/lROz1XtgUYpDkLO/NgZX9P/TGLao5FcP9uK/47vruF6hVYNJ8l0HBiBtYISNeO1JiXCnrLRBmGRA7OzgqUoi8O/Co1mOsDDZvl4kP0YYBWNHx3YbcptqCIuGDZqIylofzZJy3NLCZiB6T5LYcdcvd+0uk0OwCZRbSyvAmQfWjsDVFhepSL6P8nn+qvJ/s0e6ZBi8NrPO59ZXAt5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(6666004)(336012)(7696005)(426003)(2616005)(1076003)(26005)(16526019)(36756003)(86362001)(82740400003)(81166007)(356005)(41300700001)(83380400001)(36860700001)(5660300002)(2906002)(4744005)(47076005)(8676002)(478600001)(4326008)(8936002)(966005)(70206006)(70586007)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 16:00:29.2988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5755abf-0ef4-4696-7db2-08dc1b634182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace [1] with [].  Silences UBSAN warnings.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2039926
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/pptable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
index ef3feb0b6674..2e8e6c9875f6 100644
--- a/drivers/gpu/drm/amd/include/pptable.h
+++ b/drivers/gpu/drm/amd/include/pptable.h
@@ -658,7 +658,7 @@ typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Record
 
 typedef struct _ATOM_PPLIB_SAMClk_Voltage_Limit_Table{
     UCHAR numEntries;
-    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[1];
+    ATOM_PPLIB_SAMClk_Voltage_Limit_Record entries[];
 }ATOM_PPLIB_SAMClk_Voltage_Limit_Table;
 
 typedef struct _ATOM_PPLIB_SAMU_Table
-- 
2.42.0

