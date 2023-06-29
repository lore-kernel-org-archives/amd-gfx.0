Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006AAEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7176610E071;
	Thu, 29 Jun 2023 04:42:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5510110E021
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvtoY5PPVB+C+oaIvWd6z3/S+UJataWQ7FUWLZ/lCbxx8Sas6Iarrubjdtej9nK9LToysiUTNMRYw8y22kSnCmG0X+I/fYfypdZN1SrTqd4E1NlXc4nnBooEvLE3ji/ggHGusXS5I9pjhcNKrp7iprjSYmLZf4P8OBgMp23G2vexA+w8JYk1XjVLTjMcbBVhgFFMzbYFSD/fGhx311MSwyL8AoNJChSdlQElUUEpMMG9hJP/1vYxDR0V6R6tigFQk0XB91AGBaozlGUamQM1m1WlXSp5Tz/vVSZu8dns43DN+otouW2VjWJnXdnVvoEJ3Fq0eQoMkhfqV/ynoYj0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WZ8dp0YW0I9Cm2ge8GQWTu9vcazlcIZcJQgIG45RRg=;
 b=SS2l0Ic37ekVCazHLfRJ71LFD5IM5qcC+qA04FDVEysVyxqi7W0isWNEgUi+y+DUDcLdJLLF7yjHZSAxcNXSL4n1L6A1FRxP1SLbzNRmNCguu7QiKhg9faDBv+WJ3k+gOFN7J21NVa9tIOTZymF6sLfsJLr92LdQFE+Zw89wX50kJ6tLoGc6GenmqJbXhUa5WxNaO/YAe1CN/7G4nT6v0f2QEd+2ObEveGr1QQeUDO+/3rIX5HqR7MzpJWj0wE/8HwXPI2gwIC2ka4z4Au7g3vMI4pOfd8RkuPWibvqmUYEgUnDind0PXpe8AuQ3zhEn2qqkCTo/PnkuBNsS7qNqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WZ8dp0YW0I9Cm2ge8GQWTu9vcazlcIZcJQgIG45RRg=;
 b=w4b7phpfYt3XEpZapk9msTqqqX/JDn0ssHd7xjObNjWsxm21odtLKh2SjP/ER77AfWfKxYy0GbMpiWNiGoh3pNWWvEHyDoN7G5tSA1o+h8JwpqM7kC/1btT1b8VkPtgZq9ral89JsqRv9eO1LpWL2F/6GoB7tTOXY1V+LbN8qng=
Received: from BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 04:42:35 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::47) by BN9PR03CA0289.outlook.office365.com
 (2603:10b6:408:f5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 04:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 04:42:35 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:42:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 2/6] drm/amd/display: Remove spaces before tabs in
 amdgpu_dm_hdcp.c
Date: Thu, 29 Jun 2023 10:12:04 +0530
Message-ID: <20230629044208.2266584-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
References: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8c75a8-727e-4ad7-be11-08db785b422e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYyX/GD3vvrrnI0JXUhCwbZ0w5raEoQUN/d2zEv0caHfMQCmUCXoGzKWtP7A1E0k1cG7f7d+QIk5wEDhq0SDj3wmNp7UHNk4mV4pLajDsx951ccpOCClr0kbM1qtCJqA72CMBdvSivzsEM9g0Cxz4YO7Mzz0xH3lZrXmCcsu04Y1nWjs+furL1eOlTvmNKcbty5G0B1TfzCiLBi1JJJOfPpHI2IjoC9xAu1Zwtv8nBj50XULuuXCeHWHBgB+/S03t3O+NDuJCAGq40IwYhqHdKTMtZvq1gXkIB6kjoACP3XHjDwOZoFzblsaO7GTlp7x/eA4DdKaii1z9pGhLhvU3GSqPcGS5cZWR2Q4laubsqkNgPLHDrizn8hSfVQa10i4mp7Pxv3QsosOZ7rRn4F6FaxK1t2yNK3IX25jiCj7wPOFA6p583LvPLg+JD2HpvEaYS87fTqY78Oyem+9qOtKM8Ml/LkqdOfpYuKnROUkPRbBXC4wit/cqXo/7lQjdTA5Fg/1tG4cXfSmzgFk+r454W7uG79x6eK+5Pk0VhbPNVEuRKt1sD2LwuRWhlZHX43wK50Tjp1M1RVMUxfLSdpMu9JkXRVx1hVelNeezVXSvPKmnnozHOnlqtTCyrfWCjo4L74R9KhsO5xuZwcu8leZriUtlqyiELi1/7dNMAM7RHowwAZ43uW+d8lrvEl7SoKqyHxoonS5Jyky2DQ357ZpEpguq2gRzTot3yqnwwwdvcwCEqwjihfowLqeAP+QfmmSU2jBwaOqIw0vdo4bq3PCeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(36860700001)(82740400003)(81166007)(70206006)(40460700003)(44832011)(356005)(86362001)(5660300002)(316002)(4326008)(41300700001)(8936002)(40480700001)(6636002)(8676002)(70586007)(47076005)(2906002)(7696005)(478600001)(1076003)(186003)(16526019)(426003)(26005)(336012)(83380400001)(110136005)(54906003)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:42:35.0305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8c75a8-727e-4ad7-be11-08db785b422e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Conform to Linux kernel coding style.

Reported by checkpatch:

WARNING: please, no space before tabs

And promote sysfs entry for set/get srm to kdoc

Suggested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 50 +++++++++++--------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 5536d17306d0..308f2b0687b5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -576,7 +576,10 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 }
 
 
-/* NOTE: From the usermodes prospective you only need to call write *ONCE*, the kernel
+/**
+ * DOC: Add sysfs interface for set/get srm
+ *
+ * NOTE: From the usermodes prospective you only need to call write *ONCE*, the kernel
  *      will automatically call once or twice depending on the size
  *
  * call: "cat file > /sys/class/drm/card0/device/hdcp_srm" from usermode no matter what the size is
@@ -591,19 +594,19 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
  * cannot throw errors early as it will stop the kernel from writing to sysfs
  *
  * Example 1:
- * 	Good SRM size = 5096
- * 	first call to write 4096 -> PSP fails
- * 	Second call to write 1000 -> PSP Pass -> SRM is set
+ *	Good SRM size = 5096
+ *	first call to write 4096 -> PSP fails
+ *	Second call to write 1000 -> PSP Pass -> SRM is set
  *
  * Example 2:
- * 	Bad SRM size = 4096
- * 	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
- * 	is the last call)
+ *	Bad SRM size = 4096
+ *	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
+ *	is the last call)
  *
  * Solution?:
- * 	1: Parse the SRM? -> It is signed so we don't know the EOF
- * 	2: We can have another sysfs that passes the size before calling set. -> simpler solution
- * 	below
+ *	1: Parse the SRM? -> It is signed so we don't know the EOF
+ *	2: We can have another sysfs that passes the size before calling set. -> simpler solution
+ *	below
  *
  * Easy Solution:
  * Always call get after Set to verify if set was successful.
@@ -612,14 +615,14 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
  * +----------------------+
  * PSP will only update its srm if its older than the one we are trying to load.
  * Always do set first than get.
- * 	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
- * 	version and save it
+ *	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
+ *	version and save it
  *
- * 	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
- * 	same(newer) version back and save it
+ *	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
+ *	same(newer) version back and save it
  *
- * 	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
- * 	incorrect/corrupted and we should correct our SRM by getting it from PSP
+ *	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
+ *	incorrect/corrupted and we should correct our SRM by getting it from PSP
  */
 static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
 			      loff_t pos, size_t count)
@@ -681,12 +684,15 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
 	return ret;
 }
 
-/* From the hdcp spec (5.Renewability) SRM needs to be stored in a non-volatile memory.
+/**
+ * DOC: SRM should be persistent across boot/reboots/suspend/resume/shutdown
+ *
+ * From the hdcp spec (5.Renewability) SRM needs to be stored in a non-volatile memory.
  *
  * For example,
- * 	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
- * 	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
- * 	across boot/reboots/suspend/resume/shutdown
+ *	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
+ *	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
+ *	across boot/reboots/suspend/resume/shutdown
  *
  * Currently when the system goes down (suspend/shutdown) the SRM is cleared from PSP. For HDCP we need
  * to make the SRM persistent.
@@ -699,8 +705,8 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
  *
  * Usermode can read/write to/from PSP using the sysfs interface
  * For example:
- * 	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
- * 	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
+ *	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
+ *	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
  */
 static const struct bin_attribute data_attr = {
 	.attr = {.name = "hdcp_srm", .mode = 0664},
-- 
2.25.1

