Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51223C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Mar 2022 05:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABD810E071;
	Sun, 13 Mar 2022 05:29:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E6410E071
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Mar 2022 05:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHvvJVvc8gNKgPqltdyttOPfhE2fbzskXq5d+r5CU7AuFabWTvsUb16JDuyMA/SW3MX9NBSE4GaUTIVaSrBhzMNx1Uvzy4eOKpgnWRwTAOIE/Rr5YL6Ia65lQJ7CXaSWi5wJ7L3S6YjUXgSqO2JoLh3X7p+otQzv8kDhu91orDYX0wLWVU2qAKUcaEVB6HY1SFsXTIO6Tw9NgazPSnWaXKpODK8OVmznUB2Be6p6TJ7+oPXMBbtnVV24OFhO9ABrPP5CwnZ3gihz0EHMyDpDPckSBrje5F0gnZcDdiOXMFnShK4rPqauqeZObzcQ4OYKUeYX5kf/Ovzy28KZQ3VHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv3k3cJxv/mXmSmY6OtlAcWXvB75MNBkww/kt7HaUnY=;
 b=N4xqdooDbLbRaSuR5sispahDISuKuC5QvTEDCkmGG4QyFveEVKIfKk2f38hcQgJ4GhO28gxnojjfygSMSk5OOUZ1/+OrWG7Ch9OM2InRgfyNVv8cSnITvYIYE2acfygvdt5ziGoNihxZ2x6V8WXzD7RXC+UpBJN5ZlFQkuraB5O9NKNZiUdHUC42XHESMQq2vqIHGK3KhWA9rxbflLKbRJKltFpCEr0DhKVR0MmReeVCdJzlnn3CaXPk7JdQD6+qhtAj2AE8v2crsJ9Yp+Nfc7KxUm7CSzfPEk/HM7O2yQ3fwog2nD0N4fq2++cmIcf7ZdUsadqillf41MLoFVJxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv3k3cJxv/mXmSmY6OtlAcWXvB75MNBkww/kt7HaUnY=;
 b=wAkI1HzNm+nzq5U8brVK7cCw0SyIIGR3Fk7Ne+Vxe4QHxbFP6Vznp8NTCO/e3mnMyB9Gho6Hh1bSF3Dp68MxxdXyAxXjnOjjFdJevuJvDqCkk6mhjVZ3LIdumqsWxHD9WvoxlXfE/kw4mZ0A6nQtRbjuW/uhVqZhB8wBMBgjFBc=
Received: from BN6PR19CA0089.namprd19.prod.outlook.com (2603:10b6:404:133::27)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Sun, 13 Mar
 2022 05:29:44 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::66) by BN6PR19CA0089.outlook.office365.com
 (2603:10b6:404:133::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Sun, 13 Mar 2022 05:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.24 via Frontend Transport; Sun, 13 Mar 2022 05:29:44 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 12 Mar 2022 23:29:41 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] amdgpu/pm: Add new hwmgr API function "emit_clock_levels"
Date: Sun, 13 Mar 2022 00:28:38 -0500
Message-ID: <20220313052839.5777-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313052839.5777-1-darren.powell@amd.com>
References: <20220313052839.5777-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb54a345-ee9c-4d0c-426c-08da04b27b01
X-MS-TrafficTypeDiagnostic: PH7PR12MB5997:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB59979F3263F96E8F3B9D6C17F00E9@PH7PR12MB5997.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SGvXwD/smStYdkk/mgdwHTwf+2OIqMROTckRJbHUCl4JsXnd/OjGZOCmwoYjrzWNF5WppTiK+Au1zhX9KG0K1kY07D7mLyibOdoH0twwJA1XGivnDO9FFzeg3oXpcks3sT2QqrdGpOSfMfGlddTvbUpd6geuVRAMhKco82BKeX6902hUba8xrpndXpQJXgMRhXV/zTqeL/lsz+d64PIKahbdT+Od1o5q/iNlcCuWKeko7pnJJWPjIIPImq5M8goEXOiS8UK9Wj2EVdKnsxi6pYUoKlEXfXwty3Ov8rHU+YHTsg8iFluR9ziSsNAqDC6oZ8tRkuHKEJvTprDhzp6sZhaVYAZkorKc3FDrPcGTI652Uu3cKDpFHPQKr1EBIZOKXoo4ehqautCGy76nSvJl7vloQqBJPlVi7SZCWmCFFDIhVfE9DTpsc9W5/qGDy+YppVZAtYKsb+wK+UCDRPEfsC0IU6Md9lXzSHNWeL0poxxkHMS1KXUlBUlnXL4aGf346gaX2Wl6nYQ/uWc6koF5VvZXRZhgXRERyr6urT0/jxInnE02Whcud8OtQz34YzdEDjINHOJYS5gqe/5gFLk+13OXGigSTnTiDqx46WU/EW2c692Q0HlXXCVKYEPrH8TtEwHURUDzOGxxhrAnXw+/IJXgJvzMax71dVeIcbGgvhho0vys1qrex68p8hAXoO2hj+HOIax4/F1Jvq+FZtQCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(6666004)(86362001)(36756003)(36860700001)(6916009)(2616005)(1076003)(47076005)(16526019)(26005)(186003)(426003)(336012)(83380400001)(7696005)(4326008)(356005)(81166007)(70206006)(70586007)(82310400004)(2906002)(8676002)(316002)(8936002)(5660300002)(40460700003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 05:29:44.0091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb54a345-ee9c-4d0c-426c-08da04b27b01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
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
Cc: Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 Extend commit 7f36948c92b2 ("amdgpu/pm: Implement new API function "emit" that accepts buffer base and write offset")
   Add new hwmgr API function "emit_clock_levels"
   - add member emit_clock_levels to pp_hwmgr_func
   - Implemented pp_dpm_emit_clock_levels
   - add pp_dpm_emit_clock_levels to pp_dpm_funcs

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c    | 17 +++++++++++++++++
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h    |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index a2da46bf3985..dbed72c1e0c6 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -671,6 +671,22 @@ static int pp_dpm_force_clock_level(void *handle,
 	return hwmgr->hwmgr_func->force_clock_level(hwmgr, type, mask);
 }
 
+static int pp_dpm_emit_clock_levels(void *handle,
+				    enum pp_clock_type type,
+				    char *buf,
+				    int *offset)
+{
+	struct pp_hwmgr *hwmgr = handle;
+
+	if (!hwmgr || !hwmgr->pm_en)
+		return -EOPNOTSUPP;
+
+	if (!hwmgr->hwmgr_func->emit_clock_levels)
+		return -ENOENT;
+
+	return hwmgr->hwmgr_func->emit_clock_levels(hwmgr, type, buf, offset);
+}
+
 static int pp_dpm_print_clock_levels(void *handle,
 		enum pp_clock_type type, char *buf)
 {
@@ -1535,6 +1551,7 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.get_pp_table = pp_dpm_get_pp_table,
 	.set_pp_table = pp_dpm_set_pp_table,
 	.force_clock_level = pp_dpm_force_clock_level,
+	.emit_clock_levels = pp_dpm_emit_clock_levels,
 	.print_clock_levels = pp_dpm_print_clock_levels,
 	.get_sclk_od = pp_dpm_get_sclk_od,
 	.set_sclk_od = pp_dpm_set_sclk_od,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 4f7f2f455301..27f8d0e0e6a8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -313,6 +313,8 @@ struct pp_hwmgr_func {
 	int (*get_max_high_clocks)(struct pp_hwmgr *hwmgr, struct amd_pp_simple_clock_info *clocks);
 	int (*power_off_asic)(struct pp_hwmgr *hwmgr);
 	int (*force_clock_level)(struct pp_hwmgr *hwmgr, enum pp_clock_type type, uint32_t mask);
+	int (*emit_clock_levels)(struct pp_hwmgr *hwmgr,
+				 enum pp_clock_type type, char *buf, int *offset);
 	int (*print_clock_levels)(struct pp_hwmgr *hwmgr, enum pp_clock_type type, char *buf);
 	int (*powergate_gfx)(struct pp_hwmgr *hwmgr, bool enable);
 	int (*get_sclk_od)(struct pp_hwmgr *hwmgr);
-- 
2.35.1

