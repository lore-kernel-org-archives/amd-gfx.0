Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3237C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5906710E4E0;
	Wed, 19 Jul 2023 18:33:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C3A10E2DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRJFDZGzHTy/2jYI28zBj77LE4lVvcOsTsy+W+QOeLI++N8YuJb7P6ncd4/k3LylQQ7HcFn/7jb13yF+zGvMAQ40tqjzHEIL4O5T/80nDoH10PXL3uvv28N8C4hfF5Sk3TM8GliwnewG48wUozdPfFtWQJOCcl4W8wrXgIm9f0F9igDRO6nShE5r2G4nvqY7kII250rEjL8EMpuT6rMgbXMMtxt18VwkPSRWbvhleST8Wm1vzjHnV0rCkx4GU95ongMLb/Fc8vdAvfY0cST9tWzr1FiwQcb3ah87m+B/Pgxv+QYfVfmY2g8FlAN0ka9iEgb3sG49IPgGkferPqyYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/jeVh+5SJPDoMLjbHyKsHn3GqQmwJSA0zqkZKG42r8=;
 b=SzN1JD//25P+U9Y53MK5u4GPr157Ywhousgx5SBO3uL0nHkoUPky2+djdM/QgWTJm4wMti3Tb6HyA36kNBBuYDvqXtFiNAkPfhWSc4vQeudAoeVGtTqQNJsyb9+VzA7yRnxNRQfFodfL1FGabQwVxKlO0bxOIXHZXhumjqnA1OkftfHGWRc0yxZcUzJVMApJnzjsQlkkT0OtOgNh1kU52Ok8wcu5mwQoYlE4hEXE66thbU2Pw3UfKnK1MCAJWFsHZ4nXvVRp4dsp5kDUcm1EcGrp83TjkmDR5cQwZVc+1akFEseTzdyWRKUmsCXJpxqk4cA33lQdCOeVCAg32wRKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/jeVh+5SJPDoMLjbHyKsHn3GqQmwJSA0zqkZKG42r8=;
 b=drW1R6FBbxhUWAWIIyPeNGM0Ujcl5gOb/l8edi12I/nXUh1AroBPSMGxSzzbEDsANG2ChC8pVYEWFB8l6BihFj9KSTK4E/3JqNtrQtAqHmrpZEOMuStKQEInQGNB2RInZvffFlo/iVBJ+K+n4GRjzkJxgNMNtzf5SVU3pZaIlxY=
Received: from BN8PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:60::39)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 18:33:05 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::b6) by BN8PR12CA0026.outlook.office365.com
 (2603:10b6:408:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 18:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.35 via Frontend Transport; Wed, 19 Jul 2023 18:33:04 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:33:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Correct grammar mistakes
Date: Wed, 19 Jul 2023 12:27:51 -0600
Message-ID: <20230719183211.153690-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 270f77b0-b43b-4181-0003-08db8886972d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbuIzcv2GgU76kpgrBc8ddzuP/oD40g3hpaNaZFm+cdck7vCCHqOLuuGZfYw7nswsc7WsTpiOaWCHr46Hs+6yiFbpBJ58H8KQudy5K69xJhGLoVaq7WoiZiYW1xxb8kSb/zTHTqPIW95ujpbpidQM7be3vECZEktCEFvS71USQjwTQvQsJ8BvQLlbFl1q7gv0xls5ny2TWBgY8C1ESYFbInp88KkcRRcJZ1aRVM0kuuuSAAxA/H+torGx2lWk5dTIFQLDUWaS6i2U/JUzFnCwkDlwrsJOkg3KhV348w+zQ5PZdvQeeanYJriQjSWHvFEvFYC8ZFNPE+pN71J00vR/d873dyFMLxSl0/O/e9PJVm2ZHMhjcZK0tPLXcFp/376znNG80Tp3pN1tilZylV5a0mUC+JlqNAqdlLu41dpHxi/2lz9hm+VT97ZywGW/EoW7CYWim0apbxhujXRcQGwGM8c0VPf96QH3lYwJ498w/Tt1TFl4PPnW2FCbqHYBucHvBe20qGJ0FUBWPwvaKUYJjKyVwJtLAr/y92LnQoThB3FfxDMCQXWmuccGnoAwEZqTiq9F7q17lVzWvl85KBx7XAKnnj1pK99TX8O3kOxcJdwRqYS3CdvFF5uLy+3szMuVK8DZg/Mnw/36DXInAOw/MlMffBZltvLn/vh+R/9Jqr6VdL6+NiIcVdfjOnUMdhN7I1Qn8fgR/9UVCVW+RC/W2v9AAsppAuhjlcN4UlllpQje/MHr3KO23nOqzCS+icydVkodv0iUKSyXgSlBJjqIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(82740400003)(81166007)(356005)(7696005)(41300700001)(478600001)(5660300002)(8936002)(8676002)(47076005)(6666004)(70206006)(2616005)(4326008)(70586007)(6916009)(316002)(336012)(16526019)(83380400001)(36860700001)(186003)(1076003)(54906003)(26005)(426003)(86362001)(44832011)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:33:04.5892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 270f77b0-b43b-4181-0003-08db8886972d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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
Cc: stylon.wang@amd.com, Reza Amini <reza.amini@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Anthony Koo <anthony.koo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <reza.amini@amd.com>

[Why]
There are grammer mistakes in comments

[How]
Correct grammar mistakes

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Reza Amini <reza.amini@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 15fea2bcb34a..a81c8f7215bb 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -149,39 +149,40 @@
 union abm_flags {
 	struct {
 		/**
-		 * @abm_enabled: indicates if abm is enabled.
+		 * @abm_enabled: Indicates if ABM is enabled.
 		 */
 		unsigned int abm_enabled : 1;
 
 		/**
-		 * @disable_abm_requested: indicates if driver has requested abm to be disabled.
+		 * @disable_abm_requested: Indicates if driver has requested ABM to be disabled.
 		 */
 		unsigned int disable_abm_requested : 1;
 
 		/**
-		 * @disable_abm_immediately: indicates if driver has requested abm to be disabled immediately.
+		 * @disable_abm_immediately: Indicates if driver has requested ABM to be disabled
+		 * immediately.
 		 */
 		unsigned int disable_abm_immediately : 1;
 
 		/**
-		 * @disable_abm_immediate_keep_gain: indicates if driver has requested abm
+		 * @disable_abm_immediate_keep_gain: Indicates if driver has requested ABM
 		 * to be disabled immediately and keep gain.
 		 */
 		unsigned int disable_abm_immediate_keep_gain : 1;
 
 		/**
-		 * @fractional_pwm: indicates if fractional duty cycle for backlight pwm is enabled.
+		 * @fractional_pwm: Indicates if fractional duty cycle for backlight PWM is enabled.
 		 */
 		unsigned int fractional_pwm : 1;
 
 		/**
-		 * @abm_gradual_bl_change: indicates if algorithm has completed gradual adjustment
+		 * @abm_gradual_bl_change: Indicates if algorithm has completed gradual adjustment
 		 * of user backlight level.
 		 */
 		unsigned int abm_gradual_bl_change : 1;
 	} bitfields;
 
-	unsigned int u32all;
+	unsigned int u32All;
 };
 
 struct abm_save_restore {
@@ -192,7 +193,7 @@ struct abm_save_restore {
 
 	/**
 	 * @pause: true:  pause ABM and get state
-	 *         false: un-pause ABM after setting state
+	 *         false: unpause ABM after setting state
 	 */
 	uint32_t pause;
 
@@ -2764,7 +2765,7 @@ enum dmub_cmd_abm_type {
 	DMUB_CMD__ABM_PAUSE	= 6,
 
 	/**
-	 * * Save and Restore ABM state. On save we save parameters, and
+	 * Save and Restore ABM state. On save we save parameters, and
 	 * on restore we update state with passed in data.
 	 */
 	DMUB_CMD__ABM_SAVE_RESTORE	= 7,
@@ -3152,6 +3153,7 @@ struct dmub_cmd_abm_pause_data {
 	uint8_t pad[1];
 };
 
+
 /**
  * Definition of a DMUB_CMD__ABM_PAUSE command.
  */
-- 
2.41.0

