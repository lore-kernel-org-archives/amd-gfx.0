Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADDEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F7B10F118;
	Fri,  8 Apr 2022 17:27:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDFB10F118
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a46YnRGOtoE/NlozALUi2tGBIH8UyARrHITW3s6aPbd4pbFIbgS5FUHUShwdvUBojM8GuNvO8LPX529prOnqtvZBtNT3fNPXGp7q22acquPDTD4pc0F7DyLs8Qi9tjg8pjEFVU66BlPy40vQhx3gZxI9bW8I36HubGJFWN5J3OPQaZ/igbxSvP4A0oriACQIhKWfR6rcSXQRVKycg92aR7v0GIp9G1858uVVuos5DEjM3vjghIqTm6aXnhPMtZ7R2AcbsFbzCLV8wbwg1IzkXubCZ8fyew7CjzowFWhjvmb2LqCcP3oecmpZyJT/pGmlXqv4bayFOPH8Hq3Pg5/WdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6h4jkvlgSEu3S0yz2k6YFQfmY6LDElsJABvd+k02fM=;
 b=TJXW/oDAaufi8FmLWGaf6Ls+Ii/x8ItYgSRat2BaWVo7MCY7/Q8Aeup0MT1C000aFpgHVuBujruWv8aYTgAdui94SgdMsjqFXYS8HAqXnaj/JjTJXffSSEsR1Yu9eMqDmJ2v+fFK0r8XH8q/ObfVaBH9NOBxDbqWQtPBJwyYp0L93NrJN4m0oTWbIlYntgep3Q1cz+SOT9h5E2CN3EpALVQ4pPm/3Nh5aY/677tNgVNAyAlcEiGA1PTQYg5hW64DjvHs7/GnXl631bR3VsXbQ6Gl7xPkw2nJ4J5CS0NI+b9FSIfSUd4aOqr3PEHAEUTrXo5QuAgJ9kLnEo4/i6Jvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6h4jkvlgSEu3S0yz2k6YFQfmY6LDElsJABvd+k02fM=;
 b=QXtM6EPPLfVEOmcotPClUM0cOgyaAf4Vm1OuvEBUgsdYQ7qm+mfogZFTFBVqRe4+76zL+BQ18ZgMEce8jxcJUrxytQMW9+S2/oKVYteVGMl8UcCsLhZNbY7UdXRTUUb7jdqvkNvA8oWo2LGgPY5qv2M2nhUMTTnCfmVjwb4I/J4=
Received: from DM6PR07CA0123.namprd07.prod.outlook.com (2603:10b6:5:330::24)
 by DM6PR12MB4700.namprd12.prod.outlook.com (2603:10b6:5:35::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Fri, 8 Apr
 2022 17:27:50 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::3e) by DM6PR07CA0123.outlook.office365.com
 (2603:10b6:5:330::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:49 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:43 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/20] drm/amd/display: Fix inconsistent timestamp type
Date: Fri, 8 Apr 2022 13:19:05 -0400
Message-ID: <20220408171911.601615-15-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb69b837-f504-4a35-a923-08da19851ac9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4700:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47005AEC5EDF748C91A2AC56FCE99@DM6PR12MB4700.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxDgtBrz/sAaBkm2ow6KoTlVBdSMfzWHlz70HZYZn/d+AD7RGP9tIaulDn+6RAS+qun+fej1h8Nq/63lmuwoXnXOj2bNL9zczm8JZ36+4vVeFHX4s6cvbb6HTtzQmLp4EN2xbNxWuNTuE6fL8pqLF/lHENXD4KhiXZgmvnaICxXwmSK4CU/Ih3IkD2MQg12AhzJ9SdV8kGyKucDrDPey8uUSRWgqlSQ20x1a8ykainTYOoaGRiCwP0blmKgbjnBOxyPaSnypsLLWDaMVx38ecB2Hk/1fn7QGmoIY6AHByeuUxN8z/gEHqkuC6phhWQutMSbYWlp72a8OpMRoWjcl6S3n1qStnSnbn6PHBDPxFMMgs/YA5gR/KUlf1kwgBPTATNrWACF3H+UPGGQsLF7/dgHIGk/VYoqUiWRXb4PDzb9GT5waHou6ITQT2heSFWnQkCatcme+RujRlwU4PbrX9Pg0ijAJRRd3GrGMpCRv+UT1FJvfYHUaxwQ10fiG9ds+QZeOo+/p09lHI959PbpWwpZFkW/73chK9MQT0ZwICQOnsOQbBbtMMXZf3u2150P6HF8bh94oF3USgxT9MKaTw83MdPe6rprUHxOaz87W5SlkuxVY0Vnw3pl3/Et56GASWkqO743Hp6w4PUnh84ZGIlYwbbaCDpb+gs79RHaw8Ns+qxV0X5/sAZ+KA9TW+A+bFhzz4oZLnP0T4qBk/wVwfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6916009)(70586007)(8676002)(4326008)(70206006)(2906002)(16526019)(36860700001)(54906003)(36756003)(356005)(86362001)(81166007)(508600001)(186003)(7696005)(83380400001)(316002)(336012)(26005)(1076003)(82310400005)(47076005)(5660300002)(8936002)(40460700003)(6666004)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:49.6021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb69b837-f504-4a35-a923-08da19851ac9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4700
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Angus Wang <Angus.Wang@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Angus Wang <Angus.Wang@amd.com>

[WHY]
An unsigned int timestamp variable is assigned with an unsigned
long long value. Also, the assignment directly converts the
tick value to us without using built-in get elapsed time function.

[HOW]
Cast the assigned value correctly and also use built-in function
to get the timestamp in the unit we want.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Angus Wang <Angus.Wang@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 0130f1879116..c1d540f017a8 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1230,6 +1230,7 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 {
 	struct core_freesync *core_freesync = NULL;
 	unsigned int cur_timestamp_in_us;
+	unsigned long long cur_tick;
 
 	if ((mod_freesync == NULL) || (stream == NULL) || (in_out_vrr == NULL))
 		return;
@@ -1239,7 +1240,9 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 	if (in_out_vrr->supported == false)
 		return;
 
-	cur_timestamp_in_us = dm_get_timestamp(core_freesync->dc->ctx)/10;
+	cur_tick = dm_get_timestamp(core_freesync->dc->ctx);
+	cur_timestamp_in_us = (unsigned int)
+			(dm_get_elapse_time_in_ns(core_freesync->dc->ctx, cur_tick, 0)/1000);
 
 	in_out_vrr->flip_interval.vsyncs_between_flip++;
 	in_out_vrr->flip_interval.v_update_timestamp_in_us = cur_timestamp_in_us;
-- 
2.32.0

