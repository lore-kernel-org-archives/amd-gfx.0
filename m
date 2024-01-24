Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B42C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B19B910EAEB;
	Wed, 24 Jan 2024 06:59:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7561610E6CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 06:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDfCrdT5REhGpE0dnnBOzjlU8tgyk38sbbNqn4h9e9qcm4UyENcRyI5yTMKbYZxOce3UxjtlxqR6CKXUJla4u5+XfWpd+NcOBjsewbAiP84UKmeMujI8kcNfLUdx/9MOKQDqi0dRAdg2tCdA+qzwKkFh/EKDB2Hhb2vC6a3ZJ4NEmpJJlkmXtaE4vjQ48I96aq8i1yG0oIFVT+Lmcs/hIjQke55A4uHtcbTky3onnSOKszmB2xPpZjI/8CJx4L1FhukeAwXcQEAkPmufHxi1wM6uGWW6AqJwkApVBL62SZPK170i6KtcUmGAktgz1e8dFJyRMxkRuwr9EqA6dYHBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPvJSQVJ0WgQhclK0N7LH17vl5pjqh5gpz9eMjAbX7E=;
 b=Bj5CSmwW9HIcwdfwUGhHuSZI7LvdWh+PPqctvhJVKC6AdoDLwTO96KRje9nptl6N9DQ0LFt9u8BD5rUl+3VpOKmEU9SUll1Ta/3DfZl5r+rjXQ1ZF8QVDmW4WUkxKM8dh0vx/JzKNccfNDmBDoH2KlGxdnJMfMhQYKF//xyVSc8BjkXq9hEreR2TR9eVlZ3BVUMvYzJGG+F/3vMU+89oGP2mnUT/WvFIo+jCO7eLU5rVkDIBTcBHWYykInJAjZ7JpwxZdOcFw+spE6wqBaJOEqmkiRWoRQJyTSUoQq53j/2EpO7wAEHYuseU1s+CBnICR5P8AdNl+zgCA6ItYJ9ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPvJSQVJ0WgQhclK0N7LH17vl5pjqh5gpz9eMjAbX7E=;
 b=lyR2WE5zb/Bn097mWyRh2SjR34yXd32EiFCmYQwPToUbpdXLbN7v0G9hZzZhtuNifO2eNldkoTNRcyGuYm1wGNT65bdmk7ExSI2azzKqX9JFOq0XImI3LLK3b+Ajjl9u5B6Hs3mHLUy3Yc7s4gt1Y6H4jhVeQA7/WIEoAE3dB7s=
Received: from BLAPR03CA0071.namprd03.prod.outlook.com (2603:10b6:208:329::16)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 06:59:52 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::79) by BLAPR03CA0071.outlook.office365.com
 (2603:10b6:208:329::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 06:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 24 Jan 2024 06:59:52 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 00:59:42 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM abort
 case
Date: Wed, 24 Jan 2024 14:59:31 +0800
Message-ID: <20240124065932.892944-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 220b82fd-008c-42b1-5e0a-08dc1caa102f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUmkOPer5vRczAUiAIyvMVDqwNm7zfXfbfucEqRe/Z61vtOsNiz1W27DyEPRkgcPAtLlB1CDKCwpSIImvAF4WJ1GZL4WGgUglsX7gWCQE1GJijYBfgYjurHCmbIXdSqehSl5UWFBIjDTvhLJLiQGDr6IpFMSwnOiRW6zubckgh30ea33kWKDuW1Mm9iZGM520Qy88jII+wHs5nEV2ziom2pPCArjTP1bZJn0nJ/c1ch3gh1PgOBsArzjo2+QA+pmtWor4KVZhW7XgJPrc/0W4yrC0xjx3tXl5LeSbNxgB3Z9sDs/ejGeIdhg+xv9EddvQxpkWItihbe1Btta49hWl5D+aO9I/YTVNN8UNkiimDlctRrAk0mleCYnZ+ZM9asbrZ9v/WDdbDVDI3HVGbGxHQ0tiMd9HCEG4yMy/rv0EFaWjjbJq2yGAOSEf+D8Z1JE1ha0Y/7O5ARmRPq6/SJg5hYaLFTbZzRoVLSYR+s4J2edK5Mwr9uRgfUwBtgilq9mCh6ba5uXuHHQ7NRlbzAwVK1oAmJw0exQVkC58TUs3MCDFT/DVU/qit+oNBuOG9YjTKGz5u2dMQmS/eV1taeVe1uNBEIaO+xueQGOLIv66bTEtI7GZRXjVv26bDYyXlQLV2q3krWOmHyU85JxaZ0+/AvEUfaDZXqQg4yxFLCnzmK2QmzuuFDcIw2GDP1Mk4QtaJwKfdS46L6QvJaOBzD54gg65nX8Zv1OsnggO58bk2oVwJorhFEHCxnhMc0EH71DFW6BogejnEhHGfHKOhsEkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(83380400001)(16526019)(36860700001)(40460700003)(336012)(40480700001)(47076005)(1076003)(478600001)(26005)(426003)(2616005)(82740400003)(81166007)(5660300002)(36756003)(2906002)(316002)(86362001)(8936002)(8676002)(70206006)(41300700001)(54906003)(70586007)(6916009)(356005)(6666004)(7696005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 06:59:52.0856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220b82fd-008c-42b1-5e0a-08dc1caa102f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
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
Cc: Alexander.Deucher@amd.com, Deepak.Sharma@amd.com,
 Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the PM abort cases, the gfx power rail doesn't turn off so
some GFXDEC registers/CSB can't reset to default vaule. In order
to avoid unexpected problem now need skip to program GFXDEC registers
and bypass issue CSB packet for PM abort case.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c5f3859fd682..26d983eb831b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1079,6 +1079,7 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
+	bool 				pm_complete;
 
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 475bd59c9ac2..a01f9b0c2f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2486,6 +2486,7 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->pm_complete = true;
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 57808be6e3ec..3bf51f18e13c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3034,6 +3034,10 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	gfx_v9_0_cp_gfx_enable(adev, true);
 
+	if (adev->in_suspend && !adev->pm_complete) {
+		DRM_INFO(" will skip the csb ring write\n");
+		return 0;
+	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
-- 
2.34.1

