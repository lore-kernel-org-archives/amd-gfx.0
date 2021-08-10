Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628AEC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 19:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AA960EBB
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 19:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12AA960EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9686289861;
	Tue, 10 Aug 2021 19:15:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1795689861
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 19:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3JmGbahzi7fqfxx22TG+quDSXWQoaou9k6sjJLC0UXsmeVxNDkQTav2ti19+uOpJz/LEekCzXSg6tIysjepFmn9/QZpTOKh/TmLgQoBNIZ954IsZLgl7OCV9gI4F34IlSuLcNUZg1/6OyTw8JNKKczohgwGVQPBUbhVE68TWNv9i/W1YbdqlCYkdoxwV3DOYYvJXLcXTUdir58Dn5kVdylctzeyTOmu7iWhJtKqX49gaXlBlyxuU8KdYnMu/LNQK5Ah/j3kg7ld30mXosKkmc3U7IEgBqATIOph94A4YwZIntCG1gDTTCM9GJmE9zmU+RTafoy863P/FzJoUdgHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMn2h1be5V713YniqbvJItarTOize4EyGp0V/M7NldE=;
 b=iSzdDJMjeZxVmX9OH9KvFAYzEykXojwmpIr5EZ1yZfY61nUZVnlT3qx/Uhpr+eejTiGVB6quxSzvRnHPNFTvdLM/gZQJ9/f3TYga5T8yR24MEq+Sf9AUY1wAvvocD1rEhDCpJNeXLc/njLejFSPUiHyay6UKf8lUh2mCSu7QYHcZfzibffEK9JE5fa4XavHmwzeoIiQc+57xrXE9nzT7YK0m+m3b6E9Qlzq7GbIYsCjCbfkVw9LKgmtcJTtaF7o9bfdpdG1yGfvQhpWHGFsShvCEm1BpeIeMJLF0j/NcWsA5zWLCTdv2JNzN4nGcXexrPbMLIHwQhLvKI0DakqZMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMn2h1be5V713YniqbvJItarTOize4EyGp0V/M7NldE=;
 b=tjnIFGqibP2J2fIgTgRg1pdX40gZBinXqPhd9POwfNAsQMZ4qB3klPB5WO7UII+sigROuVwC4eQ5Dx7g7d62oVaS/0omNUODxRM3caKVoTzhgwdlhs+lcBDWZyzhfBCE2oSGBYPm/dyMt4eci73E1M8ss138PGMA374p8JX6HvI=
Received: from BN9PR03CA0256.namprd03.prod.outlook.com (2603:10b6:408:ff::21)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 19:15:46 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::4b) by BN9PR03CA0256.outlook.office365.com
 (2603:10b6:408:ff::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Tue, 10 Aug 2021 19:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 19:15:46 +0000
Received: from devbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 14:15:45 -0500
From: Ryan Taylor <Ryan.Taylor@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ryan Taylor <Ryan.Taylor@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: restore fan_mode AMD_FAN_CTRL_NONE on resume
 (v2)
Date: Tue, 10 Aug 2021 12:15:27 -0700
Message-ID: <20210810191528.23430-1-Ryan.Taylor@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ee3c3de-f77f-4fcb-ec3f-08d95c334189
X-MS-TrafficTypeDiagnostic: MW3PR12MB4474:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4474C4B1D2907D2D2601469DEAF79@MW3PR12MB4474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MY/vLPxQInWmN2NuOhs4p5b1WoVrhOST92sKs+/s3Yn8nQzAZHvJ3dk8LT5Tm3gijGF3kdfZkM+25Ip8DcIfEpTirAX/nmUCMH8Erc7EvFvb50cRoJiWKsG9km4QzSzrI71iTS1eYAT1Xsl3oATFsyNjii68WQsihy1+JKtwlIbxGf+LglgRq9xSU2ZF/hvudu3SX4Eu8f5+qdz/HA0OlQGfBc3FcoUbERK1buv4LR644FhPYYcaN2p40yO0/LKdriMaMlyd8MBm/ZmXA+WURGbKczjrPGdwUbDAaZ5MRiSWjtHO0wESev/z4olMM9LgrFzJn3vaUIyC9JJFAdL8osXCgZWvTYgiOW6shsLWNw4EbP3hWLZMhLh8UF1fdA2Gs09FWEhcuxzBIJopjoflBiTc0qGTDJNxsJtbgj/OKHPLqYCJNrFSfma092/RTTyFVctVb2vs6TahzEIEMDBCDthCo1cHTA9orLO1iu3AclT5XSEgV8Wbd+ltdveBv3pasOualj8Q7PkelIDVR7ZBkFG0R8HDD348TxGksmgz18ALoSFhi6xYAAVhzocPK9DDGlxHPPl0lLtHqikwK9q8Yjcfd1iYHhKCaZtQw2OoIQExkyxaHJx3yTP9m8kkpugFDEwENQdpSr17YlpDaNa/va5ZRpl653VyW8xbrBK8QiYgeJAu/kHg8ibQykJlcvV46x4izOcP1m4VgROrZH/dx/JsEgdvvBAUQmxu6HAVWQ1lcD1yEo3E+n9yCQVYgC2BF7n/XiwlUZ33xryX/a6bTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966006)(36840700001)(356005)(336012)(36860700001)(83380400001)(70586007)(26005)(8936002)(2906002)(70206006)(4326008)(81166007)(16526019)(82310400003)(34020700004)(86362001)(54906003)(82740400003)(186003)(1076003)(7696005)(6666004)(8676002)(426003)(47076005)(36756003)(316002)(5660300002)(478600001)(6916009)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 19:15:46.1851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee3c3de-f77f-4fcb-ec3f-08d95c334189
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adds missing edge case to smu_restore_dpm_user_profile.

v2: Don't restore fan mode auto (Lijo)

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Ryan Taylor <Ryan.Taylor@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 71afc2d20b12..b4b4d615bcbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -403,7 +403,8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	}
 
 	/* set the user dpm fan configurations */
-	if (smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_MANUAL) {
+	if (smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_MANUAL ||
+	    smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_NONE) {
 		ret = smu_set_fan_control_mode(smu, smu->user_dpm_profile.fan_mode);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to set manual fan control mode\n");
@@ -620,6 +621,7 @@ static int smu_early_init(void *handle)
 	mutex_init(&smu->smu_baco.mutex);
 	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
+	smu->user_dpm_profile.fan_mode = -1;
 
 	adev->powerplay.pp_handle = smu;
 	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
-- 
2.32.0

