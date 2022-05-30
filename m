Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B9BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 06:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C69910E4F0;
	Mon, 30 May 2022 06:10:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8015D10E4F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 06:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja3Apa/IPnTFxlzah8PsR0ll3m74qYPB8cT+q6INr2+QhA373XH9iDuhPsIXrkXzi8hzV2GCAx4LxT6Cv4zI5BeW2u75gHW6iGbwAA4AO6Nu2igOP8CqP1sy8gTZkDZBFRPJzTJvmPQ7UL2SffhzOqOfABGHElwpuJ1UPwcsSQqL+IDY9v5JhTW0Z5WF/dFhKOErJUxOEbK0ZUWwA15aoyDPuq4OOnfj6aQaWgobXDnSBd1nSTXOzvlmcRqdP88kXY3PxJYTMrTwcmHzd+VeL1+K+FlDSrK7vSt0xU1AiGQf92TL0nB4NoIHhae9ntgb8vl9yDu56sQSDKRLD82vCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcJKwj+/ystblNrTUdU8+O/m4/byK1ItP8V4WRxdBZM=;
 b=MrB4iBgn+h/r7C2YUh+FSx4mQvSZHdr7hR6LZlWWYMmKpJGCCb/JtD4u/LhE0Rmu1Kauz68t2tmN3iZiAzhjV840LEDa8gQnOwZNrZugEY2tjvfWvFaeHbfh65/G2SXwOs0oOHZM5Bejzi3nJgqudy8OfAuEQAsCsNKytYMZdu9UMKRu+rR0/xdfRzHVMvZIylQ8a6LkRJGIhnIxHYAwYFSihX7te07Ag7PFup1l5zXhowWdLBn4rWUxrk+UXnmtUkFvm4SVPwHDU/cL2kxxgFCFiOS0Y+jEnJ76zU1axg7lSniT0V0Qn/ikRoJggTHHz74LWbU1+sjuHRKQYfMVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcJKwj+/ystblNrTUdU8+O/m4/byK1ItP8V4WRxdBZM=;
 b=q9Tx1T8jOxVXOBK3qPz4PeirxrXkpkeHEM78QSRT/m7X7QLGvI0IGFfXFJsoev3txe4ZXjlAUYErxr7aPUlGoqOqRDBUPv++GWxkt2JXTAWSmSK0FB0zT07uUjcjRq40CWvGWab+uml54q8cwkScUnncnmc87Gs8D/UrSIBVbZ4=
Received: from MW4PR03CA0298.namprd03.prod.outlook.com (2603:10b6:303:b5::33)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 06:10:30 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::12) by MW4PR03CA0298.outlook.office365.com
 (2603:10b6:303:b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Mon, 30 May 2022 06:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Mon, 30 May 2022 06:10:29 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 01:10:27 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: suppress compile warnings about possible
 unaligned accesses
Date: Mon, 30 May 2022 14:09:11 +0800
Message-ID: <20220530060911.345435-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aeb938d-eaff-48a5-c158-08da420318ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB4156:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB415682642C55AC8164A39D98E4DD9@DM6PR12MB4156.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjLxNdkqZ0+imggA4oAo6qfXsOqGN9TAXShBO5bkrNf12vi3M9qbD2uNqoQaBiUpZIn5fWlIn8JXuoRrOdyFrxg3emQ9ocNNnRSwI9oGghGLaT1ts6UasxbasZjjU4DHG/1wMdW3KlawqDiipG9ApoGWqOA+bgKjOtvOAHplbZfZ0yU74J6Fqcf4F/x7g9Jw7Q/bABwmIXwmJTkklyPZLBqSMBBqPVNOiJyCNLTMG8V8c8XrBwSzTR+PE/QCXGU73V5KO3EH45NB2FXHUJeGXDtlZBBBMzLBXSt3OdHSnNtDIuzc1VOIHXlv5ksO9gBOwIbAPxX87Ocb/8EfzxUxsNuXZCqqoKiNM8K7sxDJ5jlt29YRiB/XXhIG8nNZCCOxo7R+XS3kiqnvg9uX+mdMB5dnDig3o7ZBRjk1zdptWO1IJAOhl0qo+bQcrppEncMzr9NxpM4ghC8kwzk99yNhd/wxHS22ztlvpD8e4og530MDVVuCOPhcnegwGNJhraiSuViafVd02dvwZA57VLsKi/HMt0Hz05bABQiuLzHSpL2/8zxewzxNuQkUMS6rUzpWWwwID5CP+0KDQ/4vi72YDUGSJIl60cdFr33RfBFa/VNmBwqrpyxn82iV0sIfmBz4FgtQoMf1sLEojMpdEaJGIxPT+MExOmkTaoATLetV/wbJ9AH6wuTOFoxXosGOudZNrbDfmsxgHkThc5yw4wqQqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(508600001)(36756003)(426003)(336012)(186003)(83380400001)(4326008)(70206006)(70586007)(2616005)(86362001)(2906002)(47076005)(1076003)(36860700001)(26005)(81166007)(7696005)(356005)(5660300002)(8936002)(44832011)(82310400005)(40460700003)(6916009)(316002)(8676002)(54906003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 06:10:29.5328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aeb938d-eaff-48a5-c158-08da420318ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suppress the following compile warnings:
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_pptable.h:163:17:
warning: field smc_pptable within 'struct smu_11_0_powerplay_table' is
less aligned than 'PPTable_t' and is usually due to 'struct smu_11_0_powerplay_table'
being packed, which can lead to unaligned accesses [-Wunaligned-access]
         PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
                   ^
   1 warning generated.
--
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v11_0_7_pptable.h:193:17:
warning: field smc_pptable within 'struct smu_11_0_7_powerplay_table' is
less aligned than 'PPTable_t' and is usually due to 'struct smu_11_0_7_powerplay_table'
being packed, which can lead to unaligned accesses [-Wunaligned-access]
         PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
                   ^
   1 warning generated.
--
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/inc/smu_v13_0_pptable.h:161:12:
warning: field smc_pptable within 'struct smu_13_0_powerplay_table' is less aligned than
'PPTable_t' and is usually due to 'struct smu_13_0_powerplay_table' being packed, which
can lead to unaligned accesses [-Wunaligned-access]

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I855062e987effd563ccc09336caad75f02751bb6
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h |  9 ++++++---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h   |  9 ++++++---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h |  5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h   | 10 +++++++---
 4 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
index 247c6e9632ba..1cb399dbc7cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_7_pptable.h
@@ -22,6 +22,7 @@
 #ifndef SMU_11_0_7_PPTABLE_H
 #define SMU_11_0_7_PPTABLE_H
 
+#pragma pack(push, 1)
 
 #define SMU_11_0_7_TABLE_FORMAT_REVISION                  15
 
@@ -139,7 +140,7 @@ struct smu_11_0_7_overdrive_table
     uint32_t max[SMU_11_0_7_MAX_ODSETTING];                   //default maximum settings
     uint32_t min[SMU_11_0_7_MAX_ODSETTING];                   //default minimum settings
     int16_t  pm_setting[SMU_11_0_7_MAX_PMSETTING];            //Optimized power mode feature settings
-} __attribute__((packed));
+};
 
 enum SMU_11_0_7_PPCLOCK_ID {
     SMU_11_0_7_PPCLOCK_GFXCLK = 0,
@@ -166,7 +167,7 @@ struct smu_11_0_7_power_saving_clock_table
     uint32_t count;                                           //power_saving_clock_count = SMU_11_0_7_PPCLOCK_COUNT
     uint32_t max[SMU_11_0_7_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Maximum array In MHz
     uint32_t min[SMU_11_0_7_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Minimum array In MHz
-} __attribute__((packed));
+};
 
 struct smu_11_0_7_powerplay_table
 {
@@ -191,6 +192,8 @@ struct smu_11_0_7_powerplay_table
       struct smu_11_0_7_overdrive_table               overdrive_table;
 
       PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
-} __attribute__((packed));
+};
+
+#pragma pack(pop)
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
index 7a63cf8e85ed..0116e3d04fad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0_pptable.h
@@ -22,6 +22,7 @@
 #ifndef SMU_11_0_PPTABLE_H
 #define SMU_11_0_PPTABLE_H
 
+#pragma pack(push, 1)
 
 #define SMU_11_0_TABLE_FORMAT_REVISION                  12
 
@@ -109,7 +110,7 @@ struct smu_11_0_overdrive_table
     uint8_t  cap[SMU_11_0_MAX_ODFEATURE];                     //OD feature support flags
     uint32_t max[SMU_11_0_MAX_ODSETTING];                     //default maximum settings
     uint32_t min[SMU_11_0_MAX_ODSETTING];                     //default minimum settings
-} __attribute__((packed));
+};
 
 enum SMU_11_0_PPCLOCK_ID {
     SMU_11_0_PPCLOCK_GFXCLK = 0,
@@ -133,7 +134,7 @@ struct smu_11_0_power_saving_clock_table
     uint32_t count;                                           //power_saving_clock_count = SMU_11_0_PPCLOCK_COUNT
     uint32_t max[SMU_11_0_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Maximum array In MHz
     uint32_t min[SMU_11_0_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Minimum array In MHz
-} __attribute__((packed));
+};
 
 struct smu_11_0_powerplay_table
 {
@@ -162,6 +163,8 @@ struct smu_11_0_powerplay_table
 #ifndef SMU_11_0_PARTIAL_PPTABLE
       PPTable_t smc_pptable;                        //PPTable_t in smu11_driver_if.h
 #endif
-} __attribute__((packed));
+};
+
+#pragma pack(pop)
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
index 3f29f4327378..478862ded0bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
@@ -22,6 +22,8 @@
 #ifndef SMU_13_0_7_PPTABLE_H
 #define SMU_13_0_7_PPTABLE_H
 
+#pragma pack(push, 1)
+
 #define SMU_13_0_7_TABLE_FORMAT_REVISION 15
 
 //// POWERPLAYTABLE::ulPlatformCaps
@@ -194,7 +196,8 @@ struct smu_13_0_7_powerplay_table
     struct smu_13_0_7_overdrive_table overdrive_table;
     uint8_t padding1;
     PPTable_t smc_pptable; //PPTable_t in driver_if.h
-} __attribute__((packed));
+};
 
+#pragma pack(pop)
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
index 1f311396b706..043307485528 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_pptable.h
@@ -22,6 +22,8 @@
 #ifndef SMU_13_0_PPTABLE_H
 #define SMU_13_0_PPTABLE_H
 
+#pragma pack(push, 1)
+
 #define SMU_13_0_TABLE_FORMAT_REVISION                  1
 
 //// POWERPLAYTABLE::ulPlatformCaps
@@ -109,7 +111,7 @@ struct smu_13_0_overdrive_table {
 	uint8_t  cap[SMU_13_0_MAX_ODFEATURE];                     //OD feature support flags
 	uint32_t max[SMU_13_0_MAX_ODSETTING];                     //default maximum settings
 	uint32_t min[SMU_13_0_MAX_ODSETTING];                     //default minimum settings
-} __attribute__((packed));
+};
 
 enum SMU_13_0_PPCLOCK_ID {
 	SMU_13_0_PPCLOCK_GFXCLK = 0,
@@ -132,7 +134,7 @@ struct smu_13_0_power_saving_clock_table {
 	uint32_t count;                                           //power_saving_clock_count = SMU_11_0_PPCLOCK_COUNT
 	uint32_t max[SMU_13_0_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Maximum array In MHz
 	uint32_t min[SMU_13_0_MAX_PPCLOCK];                       //PowerSavingClock Mode Clock Minimum array In MHz
-} __attribute__((packed));
+};
 
 struct smu_13_0_powerplay_table {
 	struct atom_common_table_header header;
@@ -160,6 +162,8 @@ struct smu_13_0_powerplay_table {
 #ifndef SMU_13_0_PARTIAL_PPTABLE
 	PPTable_t smc_pptable;                        //PPTable_t in driver_if.h
 #endif
-} __attribute__((packed));
+};
+
+#pragma pack(pop)
 
 #endif
-- 
2.29.0

