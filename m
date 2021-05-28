Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39883C47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C1460FF0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C1460FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2906A6F587;
	Fri, 28 May 2021 23:06:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629F06F631
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 23:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch1V4M+4ahPk0gWVJsKc0z/1ib1RJp1JMXasDKNOmMift4w94EeIF6T2FiyjlNlb0JsquQDPUWC6JmzMSxdBG0LF8jtH9zakKfBKG4Z1bk14ntAZ4274F3bfnV9QB27FdlHfto2L6BbwUvID3pHWIlFj9MaiGDi+yITJ/SU+sLZuMMpudImDtCHQ1GmbDNTRRNJl9RIZn9pmPLgRejfzvH9nFB0xxg9jzYvca+dbq8+k7QeGp2rgw6fDazRH7SvyjcQ4Tz6jRGCmTgZ/zW2tloI4RqJu5JfD2Fhwc63WCVo/CFYcrRs1lTWmoRhdq0u0WNOxSeEsfI/DR0oerS8kbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZRFyS3HhM5dRboSb25kuKH4dmOVLQ055BCk7jk4i4w=;
 b=aN5I1fzAxerlJbx4SDj8DvCkiM1D8vpmLP3j+EkJb7YF24GQ7jDMNy1sdrWdGJfe/9l+5Wjy+dfPuRCPbhQqTH03dCgT33JZGZUStXc6ESEH5uTLdynnSKGKNQzaOchPm+gdlmuTxKOYGcqVmdaEqUE28c15Ecvy2oELZdNSgA6fgpI4MoeiQcYQRrSezuSvKJH7DD2HQvVrl7Ef1ITe6qqUdHiWHE6bBj6rp6CbDtrZYjBYRdLzDpqdupEeFIL6pL9RH48w85s614Fbi7cC8qEG4snVG5Nnxuv7CdZY3VNxjmcBMuW/TpNPsXLMZ3Mf6PARJS3dl4Xh8ti1+WRt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZRFyS3HhM5dRboSb25kuKH4dmOVLQ055BCk7jk4i4w=;
 b=sm6q/5yL0F6SEfYNUYWb+katlRb+6+gOXaf+n3YdrFjNCSwOuK6ldX3AGWKFPntOv1aw/RVQGKrV22pMgJLIUHTBKtqOHtN9Sy9pOOmHWu4V/VKmy6KWrANI9DCLvtyVDzQPkYCPDUGAgHsB943h1us/eIWHtONLfUySBi9Slw4=
Received: from MWHPR04CA0053.namprd04.prod.outlook.com (2603:10b6:300:6c::15)
 by MN2PR12MB2944.namprd12.prod.outlook.com (2603:10b6:208:ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 23:06:41 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::b0) by MWHPR04CA0053.outlook.office365.com
 (2603:10b6:300:6c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 23:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 23:06:40 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 18:06:38 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] amdgpu/pm: modify and add smu_get_power_limit to
 Powerplay API
Date: Fri, 28 May 2021 19:06:19 -0400
Message-ID: <20210528230621.16468-5-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528230621.16468-1-darren.powell@amd.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77fc640f-e710-4e16-884d-08d9222d411a
X-MS-TrafficTypeDiagnostic: MN2PR12MB2944:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29449A3CA2D1C4C348BC2FDFF0229@MN2PR12MB2944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MyKslXRpAfKqUjZ+YsCTaZCMtRiR5j5adYwjX3dkr0qnz+tn31mwBfyE04VWAA/3qkZUg2MRAp8ldFOxBd2FOQvFkKl+jpYOtjDnqGBEoFaIkbDXnwilr4Vbd1Ji9+2GruDy9VLCur0cnkT3o7fxx7WexpSJD7BeEVIerKGf0vrNtwY9nKegvV/VEUGCoLTME6MpBe8sE9ORvV7YJRybyCuAligj3piO56LIoaNR8L9u3DQbxXb5eOJixkwpUoSJOFucaBInDzQ7ACZ4+PIck7MMAiUlE+f4ojJX2Dy2NWhMNbyK5MbFvNH5XjKrGplcj8yyGWN3OE0SVIdHUV16yOZbr0ZKMhXlnrtAaTar2u09L1nGIUDHusmnUX89ailOFkQmxzIVG4nHm7fNy5AGFxSQqPq7GS+gpBfEvHxKNCWJexFZzVvdG6rnCgs4SJrxiZLq42EcSazmX7GDatEhCvFqbv4AwdgA/065oecJcDU0ySCV0EiwszEYuWYoCRKkgB7wqU2oOjxO6i/osKx+fi+5qMGyFn9UG2hk0sGPEug9Z5BQz3hTJGDrThhMX++nFJzGG0pTyuwdbpGmnEZZuBbWbIbf9+SRnj+dkQQ809YSJuYca4zzQFeZzVmVF2GD8WUyX5VHedh+88kEY4HN2ayI3eUZWRPpXSU8TsUyPH/y2bYWscCeotwgoOoP+hi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(36860700001)(426003)(6916009)(4326008)(6666004)(478600001)(2906002)(47076005)(8936002)(8676002)(7696005)(316002)(82310400003)(86362001)(356005)(1076003)(82740400003)(16526019)(186003)(81166007)(70206006)(2616005)(70586007)(83380400001)(336012)(5660300002)(36756003)(44832011)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:06:40.9127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fc640f-e710-4e16-884d-08d9222d411a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2944
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 modify args of smu_get_power_limit to match Powerplay API .get_power_limit
 add smu_get_power_limit to Powerplay API swsmu_pm_funcs
 remove special handling of smu in amdgpu_hwmon_show_power_cap*

* Test
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 10`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=== power1 cap ===" ; cat $HWMON_DIR/power1_cap ;           \
 echo "=== power1 cap max ===" ; cat $HWMON_DIR/power1_cap_max ;   \
 echo "=== power1 cap def ===" ; cat $HWMON_DIR/power1_cap_default

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 18 +++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  4 +++-
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0098c8b55bb4..44715848705a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2734,11 +2734,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		return r;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit,
-				    pp_limit_level, sample_window);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (pp_funcs && pp_funcs->get_power_limit) {
+	if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
 					  pp_limit_level, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
@@ -2775,11 +2771,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		return r;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit,
-				    pp_limit_level, sample_window);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (pp_funcs && pp_funcs->get_power_limit) {
+	if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
 					  pp_limit_level, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
@@ -2816,11 +2808,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 		return r;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		smu_get_power_limit(&adev->smu, &limit,
-				    pp_limit_level, sample_window);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
-	} else if (pp_funcs && pp_funcs->get_power_limit) {
+	if (pp_funcs && pp_funcs->get_power_limit) {
 		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit,
 					  pp_limit_level, sample_window);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index b97b960c2eac..9636a023387f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1260,7 +1260,7 @@ enum smu_cmn2asic_mapping_type {
 	[profile] = {1, (workload)}
 
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
-int smu_get_power_limit(struct smu_context *smu,
+int smu_get_power_limit(void *handle,
 			uint32_t *limit,
 			enum pp_power_limit_level pp_limit_level,
 			enum pp_power_sample_window sample_window);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 44c1baa2748d..5671abd58bcf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2166,11 +2166,12 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	return ret;
 }
 
-int smu_get_power_limit(struct smu_context *smu,
+int smu_get_power_limit(void *handle,
 			uint32_t *limit,
 			enum pp_power_limit_level pp_limit_level,
 			enum pp_power_sample_window sample_window)
 {
+	struct smu_context *smu = handle;
 	enum smu_ppt_limit_level limit_level;
 	uint32_t limit_type;
 	int ret = 0;
@@ -3009,6 +3010,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.load_firmware           = smu_load_microcode,
 	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
+	.get_power_limit         = smu_get_power_limit,
 	.get_power_profile_mode  = smu_get_power_profile_mode,
 	.set_power_profile_mode  = smu_set_power_profile_mode,
 	.odn_edit_dpm_table      = smu_od_edit_dpm_table,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
