Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5E6EB64DA
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jun 2023 03:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D696D10E079;
	Sat, 24 Jun 2023 03:29:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEF310E079
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jun 2023 03:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb4/8b9tPxcPk/ru3Hsz5Yov35hlkb66IR5sxPBDtnWXqIt294Co+w/XmimzI4pGdxQDVw5L5oY5lpCC85EoU5tkBjdgP94ENcgsBZv4ex6okxKSAvS2x98nGewlG5P1v3sOZy1jBDwBBRqJfLuVsuitRJf1J8Ku4mY42SsPUB1kgg/hAxNgcp+ExlJx9rttTZCF1kP2BdkC8BPjjesujmFSXDv720xOrIhFmexGczlYZxYPGi97JwmjnhzcTYhUbiA2+i440Mb/bcjr0GrThik10r2jZP86av6UHyG/hGRpXRgeMhjAdCGKWC+lr+/UaqKkLUifkmWJjIrij5vTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0a6T8ob0aD0oJdV7G9rx4+840vI/AR2fGuj5IHEI5s=;
 b=RU5zKixZCRnWDAcjbMSbXFVKjQzfXKXgz5NAi6RzEyzFsz21OkAU/baw0/lkFwCmMuAk4PhnRHHBo8SkYtW6uZZjkGOCg4gAq4ZO5ynBYjKXw3Dkg90kLwp9eTJf/XFBjdTH0fyCU5mJN8/AOCRsSvM9ofnAvVLn+kCtuXrm6/ppEohHqQWU4YvCcF4rpr1tKBUBNtE3cYz9w382WRas+G2Ui442Nz/X0FV9MuHgtJRpmPFSMrxm3oNJFXm6JhvRtLhbHSCg2dW0o9bOt9YNOEn1c4j0pH74nDlRUaQ4eYg+jeJdl3ZmxMLi59QDrltcXI+PrOm1eQtxNWDDOCMAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0a6T8ob0aD0oJdV7G9rx4+840vI/AR2fGuj5IHEI5s=;
 b=gTcO16P+EV5Rvt9hZs2K5sy+zYZob0FRIgDSusyk94UzRM3fqBoX2smcZHMLtVcCby4HCtMpSReV6an9Ue8O6cqNngyidcf/xOtrx1+RDqNVriYR1y4bJMYQVyHpT/Ul2Vg59TiIpV3SUK9dV44RPeLID/oUrDAF0AAngKjXpbg=
Received: from BN0PR04CA0157.namprd04.prod.outlook.com (2603:10b6:408:eb::12)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sat, 24 Jun
 2023 03:29:51 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::25) by BN0PR04CA0157.outlook.office365.com
 (2603:10b6:408:eb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Sat, 24 Jun 2023 03:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.44 via Frontend Transport; Sat, 24 Jun 2023 03:29:50 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 22:29:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2] drm/amd/display: Remove spaces before tabs in
 amdgpu_dm_hdcp.c
Date: Sat, 24 Jun 2023 08:59:35 +0530
Message-ID: <20230624032935.1230632-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a541c4-78a8-4f7c-73b0-08db746344d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKJV/Wbpd22bTVObW2DMTvAu9+Zydls60G9Zoez0PK8eVnTDsQg/fjDqoZYegdIDl9OXWelBnxpfjb6ERLVKY6yDGn66FVraI1sVTsKMvDP5+imtdRGodvAbt9+VfzSFocHWNG6gXj3l1ztgWLfr/VE7U5xMV4v54kVGcS+y2xBxRS8yoAA3KT0AhKOZpdRalrqDJwL26D9cSXMPo9ZKtUg9sbheX0a3c+vfPz1R8cKcO7+SNIIp3eVeJH2AvEBkvcQINzqSiCdFAGWe+VnTyVoerzxtPaP8aNRXtx+yrnnK779pvERi1pTTCXOZ6xEeaAjOp7g7kU18djKaeCeWegCFdJhq1Jbzg43++IhHQP4XKho0hb9ee87mU7SSVmgZGeT3JPYhDEHa0Pzf5neXGaUW9/L1mML9FynuvhUntuOi5k5UdmFKwk/Yh7Pl+G+DRGl9zyW5uiNPevpHYWLSy4Glw3fa4UUCPWC1sqe7t7Bm5pRSLr5HH6ncPB10fi5bP+LzxMmYlQP5BJ2IZoZnVu25Xj81cVea/V0ykB/y9B57MJuWmacHJ3L2atqLKLAK9xzGTAY/EpDmNYywYrispVse9kOutPiIC6/GUU/uDsT7VqIckyIuzE7GzEVuzQdp3zY9Zay36rOIFUoUzpX025uKF3wAAlxXKZPMjBlFbgfU0e0ITl+a/0jRbiV6kxPin5DipO8jEo9mWtgufanFojpfyz76RA8tLDooJBgf6wnVW6LJ+hUlTeGOPw3nj+jfS8dfngSgP3v5S5XZ/8saMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(2906002)(44832011)(40480700001)(82310400005)(82740400003)(81166007)(356005)(36756003)(86362001)(478600001)(54906003)(110136005)(6666004)(7696005)(8676002)(8936002)(41300700001)(316002)(4326008)(70586007)(70206006)(36860700001)(6636002)(47076005)(16526019)(26005)(426003)(83380400001)(336012)(2616005)(1076003)(186003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 03:29:50.8077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a541c4-78a8-4f7c-73b0-08db746344d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
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
v2:
 - Promote sysfs entry for set/get srm to kdoc (Rodirgo)

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

