Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA09C46CCD
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 12:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58F510E699;
	Thu, 21 Dec 2023 12:46:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD54310E699
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 12:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdjZZPFCHEp8g0RVbOXEGBMCqSy0RJ6A0Ll1Q8ASIcbkM6MZYehgUe9mxIqOUoDqV6Ha9LFsLPPctjHnV//pDkEq/VM8jycW8/RC3qDeON1zBfS8Oy0hFfux6/ystfLh95C2sssNCHoBPhbc3XSZRzgQkqrBim2eurANHtOH06mLq7LlH2xO2srtTABkyTWnS960dTncq2fni9CFoPBtfolFdYXuznoCVW4eNqllX/A4jyjDoWai1JiRvr38HCv0sLKZVqsr+QMaGi3pr1nxRnAVkOq1jElizbVppGn6zmohA4GX0h34r0fAQylWtyhPAhCvNdi1OhttAGnGd8YApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3L6PFYea7VwWyT9ayUeZHepbKr+sUTPgKjTc85tp1s=;
 b=F/bw3ceRoFq0SU5Cm3iIWFrCJl9Kv+JBgMl0sFcPX00jYXJuBncUg9prH8IWvNZtTfa75YxeEknnED7mTjQZTWNDlzsqKEkGnwpzMfnAcTioh3g6RhMNukEHwwo0Ch3FPZhGTxe5DlCki7dY8MpdlGcIX4F6m0NejCMp4sYqIlhp1pcg0RofXWdGlfpyi4XPTR/bS1MzL6+bm7S9aKukqxh6joiix4e8lANGIm8A0lAdt3PaemCpQQpEUFZ8PYJR1jcbXnsOWP8ABgrj6RgsFFGdMaqj1cQR7MYDV2FXXx6rTi65xo7jtQIoUHDlCW9NA4A23GaH2zMfNJHY1AT8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3L6PFYea7VwWyT9ayUeZHepbKr+sUTPgKjTc85tp1s=;
 b=Nyl6TIjm3De3XJT1838aJ2EyUHHQNlF8xyTd4Npbm+FPkArxA36IQi+6CyeLVMWQGU1gmIqiSU5KliNuQ1hG/tmwhB4x84l8WuBQQEktkv0uRoymACBopd80BbiHGWVu9N3O3g5NubNZEEcY6v87hTkeE1KOy/NBrZGhS4bG3NA=
Received: from SJ0PR13CA0144.namprd13.prod.outlook.com (2603:10b6:a03:2c6::29)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 12:45:54 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::4e) by SJ0PR13CA0144.outlook.office365.com
 (2603:10b6:a03:2c6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 12:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 12:45:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 21 Dec 2023 06:45:19 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Release 'adev->pm.fw' before return in
 'amdgpu_device_need_post()'
Date: Thu, 21 Dec 2023 18:15:05 +0530
Message-ID: <20231221124505.1319447-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: a72c8e48-3c3b-4c35-bc48-08dc0222c545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VnCaMHYgSxpHBnmnz6il9o3W/EAPx5rOODEKJ03oP3nvMBIG3Q3sL7P3JBTLQmsBJNwV5djU235YjMMkzIAz1yeUfghc5gpF7cwWhZPXZcA+Pr99TikhVFEQMkLO9/ETQMqkRuZCzetz0BTEiuWEJDSO6lpsSd9r5y43b24wyK9yy8OeeEfvrK3iaSRZmwklziPmR9F4AnZl9b+V04aXDh5AsnWP3HKzkbp4GjnlPHOe71HqM+jYQARnxLwlNpu/vujKmUZbCUxbJyCR0Vymk08xvEiXi3zcUBU7b+pap2FVbAbizxqoAStqLH1W5weOYZGDzPEzBiWGOG1C6G6+HZblkPgzaetBb2JU7TvEzwuT/GTQXb7RweGJ8m8XzEXAjnzVdrIMf9nvZ1cbV+n687dE5E2JuVRZaFxfG5isS4/gPO05OKhuDCDtLrDv+V47bHqbr80aZnwmsZRNotVm6dTLkyhwhaGpO7oxX2XedMoyN46sM13QbvvTQDmuSZan1jdusrdqg495OO7cIyrW4uYGw5PpFoWQ/+nzkzGLPVrtUvWlv2s1KTXZ249Ktk4KwQ5nI5HzwBt3EAx2+6dwtlwq7co0Pub38jHnjG8C6UXORF60Xm5iJKI2jIn8w3QZusw/AgNL5eRIJCUz6LKS2CpBBkAq5BGew/ylKzDlxPsBVufDlROUuV00Lbic4mDKZRFuaDLOtLwwlRYNGtJAYbZDBORA2ggfepwhPpby2DC28jeDcK6SwheBWJyqxWmtEsBhQ2E+HzlzjEanGdCYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(86362001)(6666004)(1076003)(336012)(26005)(16526019)(478600001)(7696005)(426003)(40460700003)(2616005)(36756003)(2906002)(5660300002)(8936002)(8676002)(4326008)(83380400001)(6636002)(316002)(66574015)(44832011)(70206006)(70586007)(54906003)(110136005)(47076005)(36860700001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:45:54.0343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72c8e48-3c3b-4c35-bc48-08dc0222c545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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
 Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In function 'amdgpu_device_need_post(struct amdgpu_device *adev)' -
'adev->pm.fw' may not be released before return.

Using the function release_firmware() to release adev->pm.fw.

Thus fixing the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1571 amdgpu_device_need_post() warn: 'adev->pm.fw' from request_firmware() not released on lines: 1554.

Cc: Monk Liu <Monk.Liu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b694696930e..669e6261b707 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1544,6 +1544,9 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 				return true;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
+
+			release_firmware(adev->pm.fw);
+
 			if (fw_ver < 0x00160e00)
 				return true;
 		}
-- 
2.34.1

