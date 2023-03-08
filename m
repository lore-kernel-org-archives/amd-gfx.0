Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2E9C678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 03:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3EF010E0C2;
	Wed,  8 Mar 2023 03:44:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6665010E0C2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 03:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo3tBhRf7u6+iQMOdLPFxnsiVXh0XuScs97bOCA6BCBVOYFvK5kEG4rJtA7kZAhRduZI8uMh099zYXi5r1vsqHuDlgmwxvXH46hJv/j47Vnbi8os9CFLugu3dakrPSTsS5lxfFSjMzjksRZ+5BvRBw/Yi48VIYSIkRH2R6++Vc8mL0iddILmK4XdfIdegwDZip+XKTz/QdyOl1I4NOP+LC9drUTgjS46Lp7mUPgrNmzAGbAjiWf1dkm4Hjhy4ih6pPFVbGie4HX00CWZGMnSP3ia/eUOlfTFTvyuZXe6auoVTSfZg3ok6g5mbNdQoG4l5lOkEKU3V7ShAu/lBRzGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMSTKMOc04baylyihB3wZaDeuSJTfolPt3RlpjmXtzs=;
 b=IVjMELrZr3aHw30zsk/DS8pnpaKELyQjpgt6HBUKQPy3Nje20rVgdz70PevTEN+N9OXo4B8uscosyMfo6IEiEQd2TG8awXnb8AoAr5pi07/yccqukFqy7X3iVIqVKih8z5VjsEtMve4KC96w8PkGBEHp63qlcGHmHNz4X1xVsBwF3HvFAXFRxdZrGqy7Fb0j5KGoFSW9XhSCbQcTVAEILuTxwDBn+uwhHy4DfYQXXJVV1L3Q3eI8I8oMWyn8UrkwLiiUk/0FT/Ixue2eT3cKR1JYa3bD2I/3ENvrlltiEe8+kymviV+mZSbfqir34FD85K1adSi32Q0qg5rxokjZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMSTKMOc04baylyihB3wZaDeuSJTfolPt3RlpjmXtzs=;
 b=kXMgiAA5wJiCmSWD8iQFQhDe/jO7FheCgmggheftgZFaMxjJZh71tijQ0YBdZ8icX6/Ij2eOfUd/8hVQjkYxzv1Q+9npjXh5CL39Tk0DFTo0HhIl2SyQ1UZ/KPZDSupdyyfxeBy/1sklFWA3hggvdD2WrAd5fZ9GV0KVWOxDC2Q=
Received: from BN9PR03CA0632.namprd03.prod.outlook.com (2603:10b6:408:13b::7)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 03:44:00 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::a5) by BN9PR03CA0632.outlook.office365.com
 (2603:10b6:408:13b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Wed, 8 Mar 2023 03:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 03:43:59 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 21:43:57 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: bump SMU 13.0.4 driver_if header version
Date: Wed, 8 Mar 2023 11:43:28 +0800
Message-ID: <20230308034328.3836244-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b60975-a9a5-4ea2-1e0b-08db1f875a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kU8DjLVmWMUobLHw2U2aFfDSejA0N3SNmXTgRBcX5mTlcgVPotwFXcbmVW1QvxMCD5RC7Yhu0vUMf8p65Rk9adNPNTCfX2bCjlu913WXWvLwIXYrmqLJa58phmedY3vwQyaC1WUEUqW5UBzRFnoIXY4QOpoDFPPg4X1shEMhUHObFn6n/F5djV4MzZkhP3C6oTarS0RU7Ekub96odq9WZELtf91de4tqPAfQ6UC5uwHbGvzrOVYG2EyUR8oaM5xpw8KwNcyf9sobRwzOOAH5dCUWPH06Z7uTicbPvYhSpSZkuzfZI9Tz0qF7Sxuk4xC4uTh1PKZTP823raBFaMn4dDFTSLh/hLf5+2xEzVbUixkiIst+8YekXmDEACOUjGDZWQMUmEvRX853XJAbB0+MNRyZLKTshb308Ctd/8kLjfeKzBlBpxPrWNZ46U7/AmnyKO6ydelYgadu5NWd6OKEyMkcYnnGr99daRj+xJ4sPXAiko+SveLfln2Ij46znuQXnORl5VxWxhcjqOkpU/PkskAgEvv8jBQLj1thCUVvt9y7ateG/YuAm1psO4nkKygXKCbuqX44FZsHptVbTrX5GQKU9ZbN41M7HwjecXSih3b0U+P6eIb2auwT0DAbYuqvCRIa8i1jaofSbiKGQl4Qiyia8m88NN8ILGzXPeWqKPRDiAvOGxAJcGfKO07JvPx65uHMMxTgP6fOkgr6mv4Qp0bCFpgWfd1OkDQkPJ5xa0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(82740400003)(36860700001)(47076005)(83380400001)(36756003)(478600001)(54906003)(356005)(316002)(81166007)(336012)(2616005)(426003)(6666004)(40460700003)(7696005)(5660300002)(1076003)(41300700001)(26005)(186003)(16526019)(44832011)(6916009)(4326008)(8936002)(40480700001)(70206006)(2906002)(86362001)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 03:43:59.5754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b60975-a9a5-4ea2-1e0b-08db1f875a21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com,
 Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Align the SMU driver interface version with PMFW to
suppress the version mismatch message on driver loading.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h    | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
index f77401709d83..2162ecd1057d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-#define PMFW_DRIVER_IF_VERSION 7
+#define PMFW_DRIVER_IF_VERSION 8
 
 typedef struct {
   int32_t value;
@@ -198,7 +198,7 @@ typedef struct {
   uint16_t SkinTemp;
   uint16_t DeviceState;
   uint16_t CurTemp;                     //[centi-Celsius]
-  uint16_t spare2;
+  uint16_t FilterAlphaValue;
 
   uint16_t AverageGfxclkFrequency;
   uint16_t AverageFclkFrequency;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index e7d8b4eb4b56..0ef37837b164 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -29,7 +29,7 @@
 #define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x04
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_0 0x37
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x37
-- 
2.25.1

