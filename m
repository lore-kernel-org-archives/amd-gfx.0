Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8594CC64ED9
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 20:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD6610E79F;
	Mon, 20 Feb 2023 20:16:53 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A629F10E297
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 20:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0bELhS+cx1dDvUi3iCciQfJc5tFK+feCnp/S7OMMB5cS9kjQiP3Kq6vdBGkc50M8EySAepIhLUGf5GgYBBZoBkTwTAD1ZLjJ0JPfRA9nTPqi7OMSKjSfRvCvyidYtOXkr0QncbW95aF+qvMRGfaLCXeQORb3R9eqaato86FVqFxmeXG73d1E/LYeNdzbh/ZgxLjk5ingkYy7Ho/taKBQscdAlnnnaKFuPzZV9IW1lluWRCFzsBAMaKZkH5hJw0w06JKnwKlKDQ2FqF8WvRcAZ3djUODMvnFQ+l9EIgFFS4oihkbbWnQcsDBOzv4Ev9AvJjXh5GiGvsLi5CirGZVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UudfsmJyE1AgqvBP6XNVX4Rm3bEcYZf/c16AV7dcAw=;
 b=WD1nsqxYxxeifsZCfgIcbB3zJLbefYpTI5iRMaY7gRp65mMnT60AeUXtn5Tpt9n2P3ERbbENahUcZ2N3zdXZwl2cdO1pAA88sXH8/ug9A3uwKADBtgxWHb50AsI9bD+qEOpNr3FrJbkruf9tPA9aUFOQt5Zzg+WFIvNn2qcohMrYRMZnD87jIwEZ4PDC13Y6PZ+iA6RfWA+f+db3lp+qxab5NqqZVMX83I1Ia4wFQzKXZxYTiX3EQgtjVogQtOJl2gcsWN5j82y07gTz2Rw2mxG7cllxUDjiENXTB/2GGgq4nHs6uTTpdGHHtL4yB7V66yH63RixBFTPczAI+O8VpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UudfsmJyE1AgqvBP6XNVX4Rm3bEcYZf/c16AV7dcAw=;
 b=NOssn13JNitq073ujgPmpZK8pn1IZ+4HWjl675bIGRsw1ehQJeuoU0r3IuQIoTbkgGjfmQfScDAr1roICaflNfg9zPTKZiPPA2hw95j1y2mcNeD5t1qrcxlajSOS9zqhbH3pyfAm9jQHMCZjx17nca7KwYxrMK+ez5z5+udUQqs=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 20:16:46 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::f8) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19 via Frontend
 Transport; Mon, 20 Feb 2023 20:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Mon, 20 Feb 2023 20:16:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 14:16:42 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd: Allow dGPUs that support BACO to use smart
 suspend
Date: Mon, 20 Feb 2023 14:16:16 -0600
Message-ID: <20230220201618.25962-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220201618.25962-1-mario.limonciello@amd.com>
References: <20230220201618.25962-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: d26a224b-9ae9-4f71-0b1c-08db137f63e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ThKQgEQ+UlMTkXRl+Q0DgJX2T6dtJOGMsFOuTQ49gekadfmDnwYY/gn3e315UtLNibaInrqlqH1tuUpNIwU1SHAtU8flnGK1vQgHUmzXHIMWKuJwM9TwLHlW1dSBtNJLcu0d2dCGLJoyK2/29kS6rQEYnYtSmWTdLK8lqaPzm3B/nqxnxXsr3PWfDuFRMd6tUXl829F+rBuii8urIBARmgb6s23kRAPoRbaELOlaQE4cVAyxN3c5h0hJFUkLOk2ed5xunL9O1p8YAIoqNwJwfGy9SQ5JvnDPWJnSrx+nt/5XydS3sPDO2s4AuOj9vYECnz1hM3DcLnRzQ70Ea5EjOszIU4dlCq7B79qcfuyMoDjLS6BR8uV2kFLQVlQJhTpu9lk6b/MJ52YsvHpab363XJaDJgzvCokKbrc36NToXQ+vT43DQFtyaxQta8kJ7XFzaUPp3a2lFivyLs8eVr2LkfyCWpyXcyF5YwWQRrGLMGUIOtpNi+WICQ997CA0nxyOM0cXcxahJjyV/hOuC+mzDcblNERPE7K4hxS9ue2yCT9i77BDvq55AqF/Y8U9lW2XmeaJrXGjVlt34tuV/0WTppFT7kYCX/WZ19k2tCEyy6nH2G+wG+5lTknETcCkjcXWH/G5pgRyhoCYzGgu7l7jFWIYbZvvsTc4y0DRnkOe6C52wWUt6dBkQf1Yygz2j89+rbudN7oEbExuSSLtdGLq2szv9to/2R10oYn45BnNfd0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199018)(36840700001)(40470700004)(46966006)(186003)(26005)(4326008)(8676002)(6916009)(40480700001)(70586007)(2616005)(83380400001)(8936002)(70206006)(16526019)(6666004)(1076003)(7696005)(36756003)(5660300002)(336012)(47076005)(426003)(54906003)(40460700003)(478600001)(356005)(41300700001)(316002)(82740400003)(44832011)(81166007)(86362001)(82310400005)(36860700001)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 20:16:45.9420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26a224b-9ae9-4f71-0b1c-08db137f63e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
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
Cc: Peter Kopec <pekopec@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a dGPU is already runtime suspended using BACO, there is no point
to waking it up to run regular suspend callbacks.

Cc: Peter Kopec <pekopec@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1f6d93dc3d72..c3d3a042946d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2187,8 +2187,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		/* only need to skip on ATPX */
 		if (amdgpu_device_supports_px(ddev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
-		/* we want direct complete for BOCO */
-		if (amdgpu_device_supports_boco(ddev))
+		/* we want direct complete for BOCO and for BACO */
+		if (amdgpu_device_supports_boco(ddev) ||
+		    amdgpu_device_supports_baco(ddev))
 			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
 						DPM_FLAG_SMART_SUSPEND |
 						DPM_FLAG_MAY_SKIP_RESUME);
@@ -2389,7 +2390,8 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(drm_dev))
+	if (amdgpu_device_supports_boco(drm_dev) ||
+	    amdgpu_device_supports_baco(drm_dev))
 		return pm_runtime_suspended(dev);
 
 	/* if we will not support s3 or s2i for the device
-- 
2.34.1

