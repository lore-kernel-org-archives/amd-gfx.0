Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A0EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 09:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C2814B0B3;
	Tue, 19 Jul 2022 09:33:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C6514B0BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 09:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAkst/2UJHmI3zCqsnN1XxS6DZmR6Cx3XnQKkoWVTZvsYQOSZv93qa9qj+t17YGqV+lcHvAVHurdPg1GlfWBcGQNbvupQaZZa7bjj30QNO1CV0CO8gwXDacNRscf8MnmT73GeIs6mNeesQ5lHvtIeZ2tF0oZWsMV2HqY6yqt6PPbVxdZRTvnmWqmKSpFdML75rV61muln83p5w/jpMrbP9OV4RPU+C97P9mp6dq72do+dWddRNtZe9SCT2wJiAYBLxv2JOqxbthKsZ+2M8basqW2j2N+Bb4q8AFw+glXyQnPoyrgxAp+O4dZiOVnNGLFBqy/l+Coy+E0bz4t2dte6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6uhoaKwgqHL56ZE2qh+9AtGOIHzJaTujsUQp0Vb9Sc=;
 b=DoQsycYUbx3ahq6t7kCj3RYa4mTL1UoCxvArGV27/HCsc38BtxkQcEjmOjra1hfBk2mqt7YYUqFUnEvtDlDz5RZLyFUaEZ4NYmhgw+b7io6TCsTDhM8I9xRFAmsnMGkiGKtkDsxdfp6832GLw3wYg521cghzziTzbBsGEzmMygiIQlDHjQYHeaypbiiapvN4oBMevUysUT5ZGNX7Z+uBOLjImMzfnH2h9YejzuSxzjErvN5HvM2pNEDDGVr/Nul/mnS0YCp4YBYwo2FtaTLvnZva7xk8jEdd4cJ6StGrLxzR2LdsBkc5/ZdolbbKMJMjdvLeqnDORYXVxAMVcC/uTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6uhoaKwgqHL56ZE2qh+9AtGOIHzJaTujsUQp0Vb9Sc=;
 b=Hk7oqlxqpFo5lLwJegGPbb702+zi0+r+/EDSgSSEuEzQgmgC6kaSevlwCUeaGV7LF82PK6oQP8xwBHZTt6PopGozTQOvfuEv7AwB2JuZYR4ItXeo9ddAPC3jRVAp73CGzZ/bDb+w+JbZx2X1fBhymZqTNwb60ogvcGn7FEZxPIE=
Received: from DS7PR03CA0181.namprd03.prod.outlook.com (2603:10b6:5:3b6::6) by
 DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Tue, 19 Jul 2022 09:33:24 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::e2) by DS7PR03CA0181.outlook.office365.com
 (2603:10b6:5:3b6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21 via Frontend
 Transport; Tue, 19 Jul 2022 09:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 09:33:24 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 04:33:22 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amd/pm: update SMU13.0.0 driver_if header
Date: Tue, 19 Jul 2022 17:32:42 +0800
Message-ID: <20220719093244.27827-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220719093244.27827-1-evan.quan@amd.com>
References: <20220719093244.27827-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582ac736-bc18-4c07-fba3-08da6969ba4e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3355:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhfleeKkvYfAAAFK6RLIY8xZK0M/HQmXoYcJF/7CJ6Lj7a9bB0zoYsIuSiTLqt+0WWi4ha1rccTACETWHG8Ra9VduQZhpTUcWp9Yy2meQknzEzr/+HVc0THs0NaM5tEOfB1tnUB7wcXh9KqoVep/AizI0bjYpUt7/hdW/4c9NuAg3I7VdL/nk5IM7Pbd5NKxisjo6/g4sE1YZo3LEpvOoSy2oq3+8CdbWHxrsH+9kczTJjgPoLq0VPWk06340yZZTczaRXd/hUx096uKdR8H6T3s5dtoZnuVFXjN9H6kjWL299OvYWZkF0hZSiQjzXdk8v53LY7jVEe9UG4i+JePplB4gHQQSXGL1lpozs02zl8Y++59NWgldnisqsmWC0atdnqFDNSB6N39g/JQuG9PKmIR/ALK1/5HI5n9WsZWy88Gh2uRqOAowREm2PL897ig+d3EGfF5OhEPxFmN1SfKkgQqFPjk2FvxVItZha5dL/r5SYXibM2+pN+bEu+l8Om/RUkyLYosvCnKF8zCMXMP5wfO8tz8uQAlaySNF0iLZ3olI4CvOqX5iBkCjT/8eh/HtOEeXVijOao2chEXjzDaj1G3QBHVfIhTTfERnFV44ZKf3dyNdu9md0VTqBXumYbH9CtRPrm6XB/a4JakSN850HtA7BPTBTWQe4uTmghWgLU/Nm+yQTkNoldg1ueKDvTZzI4r0EhP8rvyNAV8VOcVqMwRViUPcYdcYEbshjwN2DZ4nP4MvObQ0WNFWwp+QB5kzY/gzlaeYFB0Hg69c1qO3tNVv5869eIzqKQ7n/Y4j+QuLVaC2B/S0YJk5aFWy09xTU8xfLLMoHapr/apm+PD8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(46966006)(40470700004)(2906002)(6666004)(4326008)(2616005)(15650500001)(8676002)(41300700001)(426003)(70206006)(5660300002)(1076003)(186003)(44832011)(47076005)(70586007)(478600001)(26005)(86362001)(40460700003)(8936002)(16526019)(336012)(7696005)(81166007)(36860700001)(54906003)(36756003)(356005)(40480700001)(316002)(82740400003)(82310400005)(6916009)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 09:33:24.3473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582ac736-bc18-4c07-fba3-08da6969ba4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit the latest 78.49.0 PMFW. Also, bump the version
to 0x2B.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: Icbf79cca25dbfd2850425e9e4afbb77cf1ff28db
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h    | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 5becfc1bb2ec..2b672d102c96 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -973,8 +973,8 @@ typedef struct {
   uint16_t        Vmin_Hot_Eol[PMFW_VOLT_PLANE_COUNT];           //In mV(Q2) End-of-life Vset to be used at hot.
   uint16_t        Vmin_Cold_Eol[PMFW_VOLT_PLANE_COUNT];          //In mV(Q2) End-of-life Vset to be used at cold.
   uint16_t        Vmin_Aging_Offset[PMFW_VOLT_PLANE_COUNT];      //In mV(Q2) Worst-case aging margin
-  uint16_t        Vmin_Plat_Offset_Hot[PMFW_VOLT_PLANE_COUNT];   //In mV(Q2) Platform offset apply to T0 Hot
-  uint16_t        Vmin_Plat_Offset_Cold[PMFW_VOLT_PLANE_COUNT];  //In mV(Q2) Platform offset apply to T0 Cold
+  uint16_t        Spare_Vmin_Plat_Offset_Hot[PMFW_VOLT_PLANE_COUNT];   //In mV(Q2) Platform offset apply to T0 Hot
+  uint16_t        Spare_Vmin_Plat_Offset_Cold[PMFW_VOLT_PLANE_COUNT];  //In mV(Q2) Platform offset apply to T0 Cold
 
   //This is a fixed/minimum VMIN aging degradation offset which is applied at T0. This reflects the minimum amount of aging already accounted for.
   uint16_t        VcBtcFixedVminAgingOffset[PMFW_VOLT_PLANE_COUNT];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 038a8956de5b..50daf1353e78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -30,7 +30,7 @@
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2A
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2B
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2A
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
-- 
2.29.0

