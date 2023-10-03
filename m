Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CBEE8FDB7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 20:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E13EF10E314;
	Tue,  3 Oct 2023 20:57:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E818B10E312
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 20:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNXKDos9e3KNaMPVgHaOLtyWGjYGFTL9Og8hbijOySiJx6EYq8BFgpGdISHzzdZnSHchbrrtTepH0yOO3WpUYc82pIn5Wa9/mW+QZtTdLBMd6HgqTEliIB/+YqzA849sUBQIbBlDknb2xv30FGUfHq5fMWZwE/jX7U/iXxwQCCnsmRAOFQrXnGFMHsnbsx9mPSl3LDgvCGvq6xtLw/W35OtWqRkvq39FDI0W2JlRhVty7Cz98pRuM1L4f/1ZozVc0M2Hth7ArS2PvKS5vvfnWj1jxFk9wBDvA54wsTml0oRjnMg0ybW3vVe1sFnxYne7Ymjp73vk2xAG2NOIpTAuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QeXuA/5Pwp6G2Q7sEsVGSUWaklKhBA5hxRTG7s2Sas=;
 b=AVe0yCR45Eq4jWFXxKYVEGsy4/67bicdkS1yFkroT38qyBvVFKkB1LcJj2574pIs1ugx5AprlTrpolJhtuhEazZCc0oiUjG4bUexVQavNfAB0SJD/mH7LjqFbCdv8QZX7laVQhonjvIp+zf7avzCIt2x8RvhK6CVNWvQ2Xru3m46Y5Hp+TA6Et4aH6frVSqMSpA1cmNF93kOCQBd4qJJ9SK5J+KOHVrq5syofo5v49q4GdeAxFEG/aXFSM29ie7NT16fla0MgFNdxibFwKuNJnPvVLNcPxwSRUWv7ytYveTSxcesydLymoV5SuSwAHKGB3pU6WKQHIg09JxH3tDvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QeXuA/5Pwp6G2Q7sEsVGSUWaklKhBA5hxRTG7s2Sas=;
 b=k2gzE9boSSaoAKmF39l/IrXCl+zoJKZ+jgtmglimFLXi1SpRqq4Cs9QP6xY57vdoDnm7W1oTBPtLclUbrv5GBouaF5kXOjAeoxXjiAESar3WY8R92L2bsmeiCfQQVbhcxerEoTPXOZy+MsNveU8kwIHRbRxIjQPPUBnEicBF1S0=
Received: from CYZPR12CA0009.namprd12.prod.outlook.com (2603:10b6:930:8b::24)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 20:57:31 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::52) by CYZPR12CA0009.outlook.office365.com
 (2603:10b6:930:8b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Tue, 3 Oct 2023 20:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 20:57:30 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 15:57:27 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/4] drm/amd: Move evict resources suspend step to prepare()
Date: Tue, 3 Oct 2023 15:54:35 -0500
Message-ID: <20231003205437.123426-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003205437.123426-1-mario.limonciello@amd.com>
References: <20231003205437.123426-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8dfb59-dd87-4695-75d8-08dbc4535c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzABSHFHS491Fv1RUE/hJki6yFaUbrdqET3bBePny+AXRnkiO06TESH0sYozDCh2vByvYywYR4MOdjTDA0II2q6p1waxRFrZVHdEM7p09AudhlfsUsdo92+hjZSC2ZJSBdtqB5SIYGgNVrXwDXHsDuFHUVrTEhqDUqsdbYgXcb/QZgJcPNwpn6YscW72WNauWMEGLy/KYZjU44cyQzsZgPduMKu+BWF2HhIT1cVmgNnQGbaM2qFioLcF8QBrBx/gVM8qGzrsb4LoHVeVCOcoGBGZvb+RaL98A5ONxVBG6HF3gDRn8J7CFkE6r3+t+06ZEnswJlyU/gNgCyOEK52kEULm8TTdF8oSOgKcetpj4WZ8p48W1k1+AqSCNawPMhMWswGurUF9WMIPdLcoHbAiMNMnseieljh0IE95eI6ehDvM+djsZqgMGzWCgkpr3FQ1h/oWKn0a6Fykidi885gF+Sb40M9BrH51kJ1wGpt8eY8nAcJUKrbzI4H1b//Ea+h80rAThE5lh+SbPfDyCM2oS1kHL2uC+bDERnPovSrO6LEYGd8gKbtodH2wg6PKrUTriMKVx5ck/mUhXUehRYm/HH9qYozBqg9pxg/8uT+dwf7u6hUwvQGsci6SnHGI4cWcaP0/un2y+gh7UaydMrOkmIXPh5OXaFl8iCcUl0NLYR9HbOeatwkurU8AnBMDuMQSH4iO8uq9vVL7iNd8DI91lKTVYgKG5lfsFoZxwJPxYwWDCpIJYFeSHDleeLERDCBP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(1076003)(6666004)(2616005)(966005)(7696005)(70206006)(316002)(6916009)(54906003)(70586007)(44832011)(8676002)(4326008)(16526019)(8936002)(5660300002)(26005)(478600001)(336012)(426003)(40460700003)(15650500001)(2906002)(83380400001)(47076005)(81166007)(36756003)(356005)(82740400003)(36860700001)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:57:30.7023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8dfb59-dd87-4695-75d8-08dbc4535c03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the system is under high memory pressure, the resources may need
to be evicted into swap instead.  If the storage backing for swap
is offlined during the suspend() step then such a call may fail.

So instead move this step into prepare(), while leaving all other
steps that put the GPU into a low power state in suspend().

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f53cf675c3ce..6d7be949de7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4278,6 +4278,10 @@ int amdgpu_device_prepare(struct drm_device *dev)
 
 	adev->in_suspend = true;
 
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -4314,11 +4318,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	/* Evict the majority of BOs before grabbing the full access */
-	r = amdgpu_device_evict_resources(adev);
-	if (r)
-		return r;
-
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
-- 
2.34.1

