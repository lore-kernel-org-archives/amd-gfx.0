Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23E3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 07:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FD410E9EA;
	Fri, 11 Feb 2022 07:03:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE49A10E9EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 07:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9mzs/YMUx6dMlfUQxJBD22nEf+GY61QTp76tovFjCsolsD7VVlzCDIzTO2szOrYSaK63LYXEfNBYvnFK38CpMmHN3OpVXFGY+XTZ7q8QWMwzLBYMZF5vGnjFnDcIaKFj8YAgnWr+ToinpeE0w+EHfuNMWz1SmKecYpQTTSlnmulV4Pj8vma25O0d1UKf8jYVWFKtYxRM57QNXUfmDxXylsuvL8DqJX3zzHzeuDEZHJ32YRBoZ38s0eYVFHL3uK/ak2Evki4/cfMhuQ4S1f7iEi1Z8tNpbDJm9QHULiFRggU6B0AXLH1DTB3GWeRauV2S4vNnA7dBp35DjYdVvbl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CYT1/91LJZabn8JxsOrenwJZifn6WwLb34lFlMuDh8=;
 b=lCnRdYVh1HQ0GbwHOMMTrfWy0BBnOf6lD6ipdCUtESYvtKo/z2hHna7dAdoqGyUOaOfuTJH+j2L76xAIUg/GseCHLztnMj54YAu2SzfjMF3lpBQ33vkgejzjWgha/qvTD84SpZ2g85SDfi2HUXBgipCFBiQLiiy3iND4V5KJpRBUJI5+CkP64XB9X+kSFikP8UV6nY2hfhiUypFqVpQjcuOiW+bJFx5unjpt9qCNcM2GpN29b/aYW9CCvx2T0mUlXJK9rS/EtLsl5xvD3iNI+81q8Kq1xCfwlYGHNCUStW0nBiGJZ99eEOcl9zsc6Pzf1RDDmTCsaJCpa9UyHQKUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CYT1/91LJZabn8JxsOrenwJZifn6WwLb34lFlMuDh8=;
 b=JTys1M+R00ikOYQj6+XYx4ctjJ+S6vs/e5Nle6l2BMuQxecQLmkBr1ovSBWZ3rHJTAJ6vdK8DCwkf5M4sw+mWk3ufUcA6IZpdXx8dX+SyUBprKMf+Wa3W3cO4P17/CnQl/dy9uwaA+OPUBPErvb8qZq8plCeyLOV4+lTjInxTs4=
Received: from MW4PR04CA0041.namprd04.prod.outlook.com (2603:10b6:303:6a::16)
 by DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 07:03:37 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::9c) by MW4PR04CA0041.outlook.office365.com
 (2603:10b6:303:6a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 11 Feb 2022 07:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 07:03:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 01:03:35 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 11 Feb 2022 01:03:33 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Reset OOB table error count info
Date: Fri, 11 Feb 2022 15:03:30 +0800
Message-ID: <20220211070330.32500-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fafbcc74-35cb-486a-c724-08d9ed2c9ff2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4532:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4532811557E576723D16F3D89A309@DM6PR12MB4532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WzN9YlYbd5Sq6KQCU0bLYe3RlqeB4hGZJ7lk6CitRKaOVONbfcqC3z+GEAdPbppoWw9RjZc8YqLngZvyhX7Jc7maB/2o4suiqA0Q+ddWWn5aYeaGCiuJ5tj6LOUURD6w160bZQHJWhjPxHAHPtRKylLOywT+jsbVlhSpTpwM+AeGI1PoZFzs9CL9gCsv4/si1UHnGIbsthx/U0Sr/4H1qLCmRaq9+c2Gud7F7NX45wVxUKuRyWKvFdtO1efcYa+NnBAmM8KP5/gPBm6jB3rCjFVfJJkwvPaazx6mGg/weMqb6LmhchIrYHsAP2HuaYRvmMuJZa46nPAYoLzNQh2k1E4XMP9N4p5f5UIEnGqE21RxUpA+d7ljAN7G4nmDa47GVhSaXR88fXBlH/Ce2B4JAqUmfRN5pgpW0mMKUBGMtXChUXKU3QcR9qSE64CcSqznjQt/wsIzACpaA6cTkJg8fm019yADP4+QmJptQysdR4rr3LoAMg/Offlepv96+c0Nn211eeIrlLtQqRaUSs1O7nuEoVtaKp1UUj7PD6Gw/ZXPQeBzCBlXJxSb7p3VF64dTNrLeU8IM/+SR8yPndnjpzhR/KqX7rloPcnF68e7UZNhJuhp2MV77lwpYhCwXGlWhHErSHEqSCGh5obODhVwMi18x1JXNqUYrI8Rr3kpiWAbSAjCQAlIanC0rkMx4K0cnnIAPFp9J09t4ynTShR+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(110136005)(81166007)(6636002)(86362001)(2906002)(316002)(356005)(508600001)(7696005)(36860700001)(36756003)(83380400001)(5660300002)(336012)(1076003)(70206006)(70586007)(26005)(8936002)(4326008)(426003)(186003)(8676002)(40460700003)(47076005)(82310400004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 07:03:36.5592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafbcc74-35cb-486a-c724-08d9ed2c9ff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The OOB table error count info should be reset after reset
eeprom table

Change-Id: I2a39e0e44b7b1a5ab7d6b4d4b73ebe48264396b7
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index c09d047272b2..2b844a5aafdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -263,6 +263,7 @@ static int amdgpu_ras_eeprom_correct_header_tag(
  */
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 {
+	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
 	u8 csum;
 	int res;
@@ -282,6 +283,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 	control->ras_num_recs = 0;
 	control->ras_fri = 0;
 
+	amdgpu_dpm_send_hbm_bad_pages_num(adev, control->ras_num_recs);
+
 	amdgpu_ras_debugfs_set_ret_size(control);
 
 	mutex_unlock(&control->ras_tbl_mutex);
-- 
2.17.1

