Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E44EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B104A10E3B5;
	Thu, 29 Jun 2023 04:47:11 +0000 (UTC)
Received: from outbound.mail.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB22B10E3B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgvKRcu1punzdxs9a86/SgpugFIzVUhUHdJjFnw113EaIXHwHWzZxs2z6cPoqcCKADFfHeTP/dsE57TzkE+PSrJc33Rm3IGHipCrNnKwRlOOSLxaQl33PovgzNh/S81eKq//9wDMmL44om34HDZ67G5+zeoMrzeJoqqEyfV3VdAJZQ3DFNpas8os4AIgHGbnh8i1Mf4+ixdUxCZL4SrFWc36GbObZ9KFoQIrg4hzV39swz7ZjMwJrmcl3XtBUkvOd5qxFmnoGM0ERV2vlbDUrb5E8/Hhhqi/5qjJ5r0MUgidd4kwKOveCYkNZbySTrJnmdPODrpFjCu6Sua/58NJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WZ8dp0YW0I9Cm2ge8GQWTu9vcazlcIZcJQgIG45RRg=;
 b=m+4r8tNjpMbZs1fjQJFHSbh1P/uoTkRsK+luBiLbKRiRwcf8192wuq6Bd/fG6JVd1i1bGEBPoTyaQ4yeciYsbLprxDPVcDft5+YdKNDt8iqrU65ssIYmfuJ4ncvZMRjBIPE2ehTSZLWnRwUWJRvGiVyxixeK8tAMsbVZQjCy1djCmXXNHTqb521/TWBSwB1eastQ9uRYHbdRTPiiqf4/CrFIZn9T830bb5NDi/zEy0AW8G/Qsm0ARtsgEDdoDTx4CvFlLgosAJkvircLuAs6qbmBVVzIO6GgDxhdDGxedKCoLvQjTG6s5wzoYT0XPEDZdqPYUNbvAgGYUMsbNQL+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WZ8dp0YW0I9Cm2ge8GQWTu9vcazlcIZcJQgIG45RRg=;
 b=vqinbVjoBJqkAVnNaioeg7NU2yrC+HGfc9RK8eEVwUMpcVrYkePkBcfYIoAngg5P5OjW3EhHA7qAnKYleuWbIuC5rO9O5T8cKODWYTZ+/ye4B98zHenPtu4D7b/oBnEXogqbNziqYuWh3YJCTpD/FYwKbJ6M/w1kJmGoGPQ2T4Q=
Received: from BN9PR03CA0433.namprd03.prod.outlook.com (2603:10b6:408:113::18)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 04:47:01 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::9b) by BN9PR03CA0433.outlook.office365.com
 (2603:10b6:408:113::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 04:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 04:47:01 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:46:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 2/6] drm/amd/display: Remove spaces before tabs in
 amdgpu_dm_hdcp.c
Date: Thu, 29 Jun 2023 10:16:31 +0530
Message-ID: <20230629044635.2266729-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d777a8-b19a-4ca6-4034-08db785be11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRAONT02YVJfmL43WKyC6fzHh4fSJjHLAfmOOc2a5Q+Z5Dn8IJ99AnBC/vpJ3wJCjUrtAsAelej5K2Dr3Z+RUf/2TZ5HZGvN5dBGUI18hI5yp71PiFrMMKRGDhp9SkoApbGNphho4tI5uAiRWHVZkQRLoFUttLBiBN/9O2aSgIDUgNR7pl6ncO0h/SsF/GsV4od3DzzGwtEqRFWu/Wvx9uMLf5gvdom6ftHiMKVjpUmMZDtQKc74Id64lIESpuuJInFL8ImqV7B6mwOGmLDtQQWEyixz/feUaJT1ATY00R2zrddbWQE6Wg5x8JOuXJJoCbGijGnLu7P/4EJH9fblTz0a3XnfQFuVxjzkpwA8kyKGy2q4GjEAT4gqqr9i2AohAtD9ruyRMY+BrOl3TTeWo8/weZEiAEhZ/RJ4t3ADQzj1D3WkG3vsTr5FxLDtHhZImAzR4opzyTCV82iKKuXr6wlbq5w+PzTuMkXUMdv+zS+q/HpvO2fx6D0mwnXQtOKH7WZ+xlOaVNUZNCFEx8eg5mmWiDKfdQ2/enBGWf1Y/ZwQVEqqawujizGH9J9lL9nn7SpVQ5QfkHJ/CiLaJZN1QD1s3pTp4kPphYi1QCvtE2zan+ya8npHVoysy1O1fJgxSauROdStxpHbWzsOo5qF0cPW4/ypvhMPiTTgy4pNpnite33Vee2WwhuVUBpOb8i40j9cZSKIibpikwS/Jm0IamO4ttwbQlqvdEj5/bWjrNvs+7UXRs3TmtDY5osIf+fRjlxJMqlRgzmyBOVFM9TUgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(44832011)(5660300002)(4326008)(70206006)(478600001)(36756003)(316002)(6636002)(70586007)(8936002)(8676002)(2906002)(16526019)(40460700003)(110136005)(36860700001)(54906003)(41300700001)(82310400005)(7696005)(40480700001)(186003)(86362001)(47076005)(6666004)(426003)(26005)(336012)(356005)(1076003)(81166007)(2616005)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:47:01.6710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d777a8-b19a-4ca6-4034-08db785be11f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
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

