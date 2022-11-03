Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF55C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 06:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587BD10E240;
	Thu,  3 Nov 2022 06:24:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E587F10E237
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 06:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kat3BjUlYlB/GwGz3SIgJX/cdN/6osgMgNSFAO/CkSD6EEAxL90YkjbjsPX/HWCR4/9oYbnUXvz+F6YiDSzQ1ggeYZUSM5D+aAXJoapyqHLcS0woNl3PnP/EkIgpJdxXi9fIRKbO+3CKB4RLvc2STUDfU7NAaUu19H2OS4GCdzzKpywVWjlKxv1iWc2ZuSjCO44KX0kTUCxkZNSIGgcReaCVFKZbPT7ZYPaoKkUidqOYbY93VviZCdDEqK/7WOUyGp9dF9m0hhOA2lP8PgcK+CvyeAt20Jetn04u9qeljpsVUq+IwEOdMXluMlKKwiTSpQWANJSo7naBEDpbe6vPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJkfDrCfQz/ftUXGAX7PU54pyiMfDYhQDMMuJtuEaYc=;
 b=l9PdHsw1sCgmhFEKKXhT1jayLXYKduoPcrlIvPMWyVLofWEvMpnWAfrh3PIUzgKgkp51ASTL+QHgvC1L4DWAwfpXF0iCdnyHuVqzWjBIFY6xntTEOkaPAVXOLwXa+Y0dt91Vvl/31u1y0Hdjag0bRlNrZnoLj80zxOm19Zwk3o/bHOxfxSdgIw/DE7YtZ8nnpyYG4wCC5FRjkcFBUEfouwyG9TiC4NVOUl8yIPsDxKMYtPMQEqAX7dq7Iwj7aUMD6xoxPo8XXgaZ8HJfluMPrv1J/o6DM3h+Xi0F+ndVFoecZg8eGjchQctnsrvbGBggop02bJF9QHIrk8m415V6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJkfDrCfQz/ftUXGAX7PU54pyiMfDYhQDMMuJtuEaYc=;
 b=gHnNxT7IIkLoyETHMF5ukFsx1/jBvEoHy3vLnO4opKj8Aa00o6/KrHwFDuhK9zWDsRLkJ+bL0uSLTqyjh0lKqAXOyjm6bW3psmnZJAKIOb8pQrBTuZliBQjklqqt562Y8AEIEb60fqSy4TubS6IiM2YEIViXYe8/uE9731BoFwE=
Received: from BN9PR03CA0206.namprd03.prod.outlook.com (2603:10b6:408:f9::31)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 06:24:16 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::27) by BN9PR03CA0206.outlook.office365.com
 (2603:10b6:408:f9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Thu, 3 Nov 2022 06:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 06:24:15 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 01:24:13 -0500
From: Perry Yuan <Perry.Yuan@amd.com>
To: <Alexander.Deucher@amd.com>
Subject: [PATCH v3 2/3] drm/amd/display: change GPU match with IP version for
 Vangogh
Date: Thu, 3 Nov 2022 14:20:55 +0800
Message-ID: <20221103062056.2162715-2-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103062056.2162715-1-Perry.Yuan@amd.com>
References: <20221103062056.2162715-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|CO6PR12MB5441:EE_
X-MS-Office365-Filtering-Correlation-Id: aea56238-529b-4028-241f-08dabd64083f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKqsb6SY7EezyXBjzdEvhzO3aqHQP75FjVupd1dJdx1V0PKzhcqabR8256xwkak65hJ2c+iPNqmUAttoonAdy8KlGTRqGcXSe/alXDyhbnmvdxIkxu/W+s5f1yPn3cfGOzcCJakj0LEy289feA61FtAhA5MocAurqqqmI/h0oIdsWk7yKeF6ccM6B2SqtBAjwDtJHnWuKUWAwZknvi3LQopk7g+fInwMC3YEYl9bcQQ3qkA3X9QjDicdBNHaD3l2LvJaPloEWCJuhRRkvIRam0nx0l1EbYmKrqt925gI9YdzFcFuAuHRO0tQKdt0RtiUJGdffON40MYM4s4xK3a8EUWp0bDJ0eNlj68nRybzlVTzvBoSG50+wCaDCNvvUt1bMzeRN7PbcEZiWkP0AuJPZaQA8W8Y1dwlB1Z0SMDNSJiA86G0AQg7fAkNaEAmJuukh3GZMQbd706ejkThUwCH0cZZM8praNTyDKtLu7IFhToToCRMNYo/VDN9OJ4TYM8C0OMudTWt2BgDqdQ2cvLuk/pqI8nKlU4mf8dHtnO8+wkhSOSPI+ZszD5MYWHOyqqqQTwyGvvnWbsgq8z8cCSLcCHt10hpq/ohmT5ltOSJwrhD/fkGkSVTQ2PLdcFStSjByZyygP64fhzKnz3Mk5VvfITsgzHQKB0pOIUz9eMQUXzlyNEryyqvihQRFxYrVGT8APk9KCsM7/o9HiEggnraMU5o/Ky0+TFPiZDlVLUE5KbEGQZtIaDpH3y4LEuXuZwr/uY/PsaQsNi+Sp43MQTn5j6Qy1tr3t2OVxr9LUMicKIRmlEbEwRCSf0kW86uP73/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(36756003)(356005)(40460700003)(4326008)(86362001)(7696005)(40480700001)(6666004)(2906002)(4744005)(8936002)(5660300002)(316002)(70586007)(37006003)(8676002)(70206006)(6636002)(6862004)(54906003)(41300700001)(1076003)(16526019)(82310400005)(36860700001)(478600001)(2616005)(26005)(186003)(336012)(426003)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 06:24:15.8612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea56238-529b-4028-241f-08dabd64083f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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
Cc: richardqi.liang@amd.com, Shimmer.Huang@amd.com,
 amd-gfx@lists.freedesktop.org, kun.liu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use ip versions (10,3,1) to match the GPU after Vangogh switched to use IP
discovery path.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1efe7fa5bc58..cfdcd8852ebc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10202,8 +10202,8 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux, struct dc_context
  */
 bool check_seamless_boot_capability(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_VANGOGH:
+	switch (adev->ip_versions[DCE_HWIP][0]) {
+	case IP_VERSION(3, 0, 1):
 		if (!adev->mman.keep_stolen_vga_memory)
 			return true;
 		break;
-- 
2.34.1

