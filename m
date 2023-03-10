Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DC6C6FA99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 05:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08F710E94A;
	Fri, 10 Mar 2023 05:04:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944E510E94B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 05:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C50wmfLFdonuBnGveiYdncZHTu/zK2vf4D8RY2jl+1icZvak7heug/dVJmxn9fkqliHPhrpO/M7Vpv+G0VYmUtm+6swYlaTedu9qLZayOdlh/0X0ziaQ27zj/gbTiwHQSA0DcmwSuyu4hcVnKLcpV/CiJHTHre0kyzldBxZjvoSPMVZipYm6+qXDipil0y/tibzsFCfxdwE2F13otuF8FM65JnUGqmx0m9QSl0qpQu6MbLS1e7H3gPcbAbmjpMoy5wLDz7y1rIUFBm1lQmRonAErEyzjPwxM3vDvbrdAkW0bJI6LwMfBn752qWfpgs980bXRRtuJlpcWDzmTF7Q9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqN7KHQH1SmLUc4fhOG0kGr5grom1z43i8LqJp6OVi0=;
 b=Lq5gTeAjHpPrUpSC5ZoPFEH9+DcehW/xxvpcnzTRHChUMn+j30nFBL7AuPQ2g2DEOJSlQoJq7uxVcJ6KrSMB+Y5MdH2zA3JTHjoQj+lP5zlrdAtBd1RClNUBVKddPWI2rb+BIFGy9Yq9pMSjOhCmXb+BHfifqd0z1lSs7FZ6skRgWMJ7J3nTj30qZvtzx6a97t2rtsL9T5qP+86JOHmiNPiyrGhVcmsOwDv80rj5lOJA3OWRG2AD3jyVzmnwZyHgv657e5e5HgcUR+VMMHv47nj+GqIhb2EO4SidiboYHRm5reLcvzhXu0jyIVc1HztNuEkJMBy5NZDm4QUEa48nuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqN7KHQH1SmLUc4fhOG0kGr5grom1z43i8LqJp6OVi0=;
 b=jxM3CrR/ZQZNOLcuHS0+tgdvgLYtWfuNP0fib4cfa2Dq5D4Lk27jzawzfCwsaIrxr8wljmNk3E9Fh5y2r+td/5CQZaHjrvkVosZRkF8+ePF/fhkdwYFY9ZuxTFrFOg4VFsYywjAqX8J40XKSeRsIRNwpWiovvnc1MVxsDcML2OM=
Received: from DM6PR13CA0014.namprd13.prod.outlook.com (2603:10b6:5:bc::27) by
 IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 05:04:38 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::90) by DM6PR13CA0014.outlook.office365.com
 (2603:10b6:5:bc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 05:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 05:04:37 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Mar 2023 23:04:35 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <evan.quan@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: use drm_device pointer directly rather than
 convert again
Date: Fri, 10 Mar 2023 13:04:21 +0800
Message-ID: <20230310050421.2903104-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 712c6fd4-21df-4dba-420e-08db2124f2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKVdJjGt9CdTD2u0WrWLSereLsFbbvCRZNa9RXn0Mr6hNLMEvOewZKXsuIJE9kc3PrDgvq18R9Nt14/o9e/mVq0j9Ot7BeI9kDAsqSDZPdezOXkQHb1JugOqHGs61HLEtdKPufMJMNyaMqawk/NzZxJ4MM1cLqRrhnFWzDNZsgCluZ1UGp66bIE21CYZQZPGfAuiLlu5ycC6YDIOFsh4MH1UyxvnKvoSyKMM+onhBQe1AuTWd2KUe8yN8iqPe1AqBwTmKP1Qm8tmu7Yzod2uJCuY4M5GeFt5RgU4dkHQUi89HGg31IjMPdI061vctBExOMElJWr469iVZNRQRKhC5NSihMx1FPc/1EZmjOcYIKdBoxDuhaN70V8F0cdrmQGmsLhpg0CWbPnwKt8c29yjovrIRe0/TP5hwFNFlxpBnPxJzRn8O/QRju0rnWnaxIzVEMxIZP6A7V7xEizwcfxsc2suFqxBeXgyGelqpg7tB6SUQKrv+a6GqzQwRByCPNR519U9gvvifaTQhBkImTAX7y+WX2mxgxV+nCxY02eq+z8zsqSDkpbJmoAklMPWpu9loLZ1Ka4UJkfrCsXhcYghJIGJonM1Gdgb/uJ8xCIeMN0wiaOehOsWDnnfpb2ZtUotXCXHFpxJdbSJqvJu7IlmQbx8R93rxVhsqm/QVS78N5pKOE8aRt1Otu0bZJDPha9WHBKcY/AYs3EXuoP1fweb6hfQwHi8eumttEc5ZFHy0DkeWo9Xloh8dNiTmbNgGssi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(6666004)(1076003)(26005)(83380400001)(2616005)(7696005)(110136005)(47076005)(426003)(6636002)(186003)(336012)(316002)(8676002)(70586007)(16526019)(70206006)(8936002)(36860700001)(81166007)(82740400003)(41300700001)(5660300002)(4326008)(2906002)(44832011)(356005)(86362001)(82310400005)(478600001)(40480700001)(40460700003)(36756003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:04:37.8353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712c6fd4-21df-4dba-420e-08db2124f2cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The convert from adev is redundant.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 41ef3368556b..2937912b7757 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5575,7 +5575,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-	if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
+	if (!amdgpu_device_supports_baco(dev))
 		return -ENOTSUPP;
 
 	if (ras && adev->ras_enabled &&
@@ -5591,7 +5591,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int ret = 0;
 
-	if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
+	if (!amdgpu_device_supports_baco(dev))
 		return -ENOTSUPP;
 
 	ret = amdgpu_dpm_baco_exit(adev);
-- 
2.25.1

