Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE5EC4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 22:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AECD10E2AA;
	Fri, 10 Nov 2023 22:35:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC4E10E2A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 22:35:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJTAPdQD3Jgf7QyYIF0y3JfrN1Pk+C/0tqQaCSQLXuvix3sEGgV9HyV9GdyUoG1LU9PuO///RPCE99gDkZcI9RVuOifmf/brvdzq1pmWKmBH+h6uC6ksigdjz4HXUHMHNHRS1fFkVZxG46X1WupxUdZm3Zk6M7UA5H9gZKRSzSdpSkhlVFWc+cMfHf1adsgBbMGwOZnjwS5CV9Z0gy+rXDffMZuHTiCABCB3LTrnz5BvtrW+LmcBB07S3HN96vAfVtvvjn5R45oMUd0oP0WXftG4ld/D9vl+MmRI228dnXZ86lgpP7F782PlKAU5ikepyq6TuSv30mFugvuvwZb+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIpbTbVlZg1DQmwHflWeH06YlIlW21FFmlvP49blS6U=;
 b=fY8MurZkn8ebgmHg/j5ujL9MUpOxOP2B9xtAyfGimzPjOZGZm0Oqy3KBg5Ixmo4OhwyQPqbhMM0ruyxZy0AC7vX8URhStXm/50hUkWQTmNjhAwlgpKWXUK86VXH5+ObfqOqQZ4x9mXtdaWWOgJZGSDwV1VHEB5V676zzjF0uv+FjfRTiCJEa1JB3Ikwnj/zfZiNJw8oNB6xY80FAr/1SYNfcz6cWesos8JJooOlD5HZi01TTzB2H60deMlIrQJuPWa4rFwOGjJ8D4tNhYA0A9KgcM/r5YRMOoRZJy7HV+evMtagS2Xz4171NXAt5KLYmSbWPGZWp3tnFp2cKZQY5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIpbTbVlZg1DQmwHflWeH06YlIlW21FFmlvP49blS6U=;
 b=W/YXgAHg6hZP4RInJM26uuecM61x1ZlXwL/e5vWbdn4KC9ZWgks27Nm9EIqAEljYzAr86DIVp4DQVxQfnTwuIXcE+y9DXCSPw6O5bDrokkTrOjW8BnnHEYZlIh4U4z2xtXAEBiOjTsXbIH3aT+4mAI1ic0oOdraFMk5NyIM5blk=
Received: from DM6PR07CA0117.namprd07.prod.outlook.com (2603:10b6:5:330::32)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 22:35:04 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::e1) by DM6PR07CA0117.outlook.office365.com
 (2603:10b6:5:330::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 22:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 22:35:04 +0000
Received: from test-TBI1100B.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 16:35:03 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd: Use the first non-dGPU PCI device for BW
 limits
Date: Fri, 10 Nov 2023 16:34:51 -0600
Message-ID: <20231110223452.13439-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e61b4af-d94e-447b-731d-08dbe23d48e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSO8SBlpYUX3DSAdBqPUeTvyy9aLjG4gJFTsDr1ROqf6R919pUxDvxBUgMfQbKkqopIdSeia7flQQ7SDb3UCkFDc0ZIN/jtfqrl5fduLNoLyM9UpE4z1R429L7ifnwb8Yrc9v/AH3URdvZYAoKotnmJ4Jcy1R0Uy+pCWFNQDtn2gxoUgynb9JbEFMKQ/c/qer4FaBv6/UbxdWRQhkrRKHnkNAZCT/L3/Sx8q+bkzR8HcdjOem5uaXuDrV9givG1OUwe1/f5YAhCdr8PHwNbSfE2F/y0PDkHZn1Rdf/Mud2LfMtcihUdjYbhs17jHvYo5aKIeJHaTmnsBtXH441Jds4hgwGRzvn1JF85TJ0vD/H107xOgbNdY8DtUyrSp8SU2dFtBj2TsyrqGC4SIPc6o3UaYiG/LfJ9UV2siWs7j10PTnqtlRMO5WONMknj2yU0nOmJcTa1gVF15GyrKQ7zayyJmJVVBn12Xw1RbaYjG8rDbxcIIslpxyfAzg5xyBGMUZKi5RM/3byLDep46jI1obK9TjtDhBmVdrDwTB8TFff+fl2CkaGwZsRSKyf+Dpn40BMrnKV8m9qSWAGBuPGXZzLJstTzc6MH17mHCjNqFd8qp7iaKiC7RfCNZvb6xQ3h1Nf6witEO3ZM1A3sw5QrK7Gqb9y29wlukMtd+oDnwLlcC84vI5g4dx0gP3kf4sDcwuCoral3rqAcKkNtLQv12igM50cQnN/9FqwxhHdPE9KjQVP+bq5RisURgpiL+VX/L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(47076005)(478600001)(41300700001)(7696005)(966005)(4326008)(8936002)(336012)(83380400001)(8676002)(44832011)(426003)(316002)(70206006)(5660300002)(6916009)(70586007)(2616005)(36860700001)(1076003)(6666004)(26005)(356005)(16526019)(81166007)(2906002)(82740400003)(86362001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 22:35:04.3861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e61b4af-d94e-447b-731d-08dbe23d48e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When bandwidth limits are looked up using pcie_bandwidth_available()
virtual links such as USB4 are analyzed which might not represent the
real speed. Furthermore devices may change speeds autonomously which
may introduce conditional variation to the results reported in the
status registers.

Instead look at the capabilities of first PCI device outside of
dGPU to decide upper limits that the dGPU will work at.

For eGPU this effectively means that it will use the speed of the link
partner.  As the new semenatics of this are unique to AMD dGPUs, create
a new local symbol instead of changing pcie_bandwidth_available().

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925#note_2145860
Link: https://www.usb.org/document-library/usb4r-specification-v20
      USB4 V2 with Errata and ECN through June 2023
      Section 11.2.1
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1fc73bb4ec73..683ea2284827 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5721,6 +5721,39 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_device_partner_bandwidth - find the bandwidth of appropriate partner
+ *
+ * @adev: amdgpu_device pointer
+ * @speed: pointer to the speed of the link
+ * @width: pointer to the width of the link
+ *
+ * Evaluate the hierarchy to find the speed and bandwidth capabilities of the
+ * first physical partner to an AMD dGPU.
+ * This will exclude any virtual switches and links.
+ */
+static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
+					    enum pci_bus_speed *speed,
+					    enum pcie_link_width *width)
+{
+	struct pci_dev *parent = adev->pdev;
+
+	if (!speed || !width)
+		return;
+
+	*speed = PCI_SPEED_UNKNOWN;
+	*width = PCIE_LNK_WIDTH_UNKNOWN;
+
+	while ((parent = pci_upstream_bridge(parent))) {
+		/* skip upstream/downstream switches internal to dGPU*/
+		if (parent->vendor == PCI_VENDOR_ID_ATI)
+			continue;
+		*speed = pcie_get_speed_cap(parent);
+		*width = pcie_get_width_cap(parent);
+		break;
+	}
+}
+
 /**
  * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
  *
@@ -5754,8 +5787,8 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev)
 	if (adev->pm.pcie_gen_mask && adev->pm.pcie_mlw_mask)
 		return;
 
-	pcie_bandwidth_available(adev->pdev, NULL,
-				 &platform_speed_cap, &platform_link_width);
+	amdgpu_device_partner_bandwidth(adev, &platform_speed_cap,
+					&platform_link_width);
 
 	if (adev->pm.pcie_gen_mask == 0) {
 		/* asic caps */
-- 
2.34.1

