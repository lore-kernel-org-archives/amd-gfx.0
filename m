Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32DEC41535
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Dec 2023 17:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7083910E7F5;
	Fri, 22 Dec 2023 17:23:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CF6E10E7F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Dec 2023 17:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foFxD3lZg+OTMN+WfFOrbjuZPwsQh0JHK2jT7IyWNZn7of6C2Gaz31LdjGDDgMrSsbCEkzGEoKhbVXCXrqbrvGoCktC7ZiTpBldHF99V9S2pTv1DduigQSoAu9jt9U1uDDbIHqwN/4qRZQrXQvdVZWFQM64QozAjY8mPbCXxKACjzHeeCZe+18T+vLzhVOARdxp6ShbF8pSCLyndFQRzoDJVx5+1lo4+dz2j5ho9lDAGwbR/IJ0qJsYwHXn6Ynp8RjoJNYWqTw40+P7/LLA05DzbrcQZYs+IVZf4UgCWpzN2OAnU20fHu6yaZqLbK/Nfj6b2DE4WrUbHQA1YCGj3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/84h8iMegk4qSlbC25xq+xB/fWECJPnlddpXSsgb29k=;
 b=nGxpLs8VLbwp57w8Xb5U+6dfaZ8ONaLey/chKjcQ5D04JTivMKLRqR/6EmVavX+eX7+R2Yw8amZceaGOTRO53wgOmlt3iC2yW3/DrS8ZyIadzFyB70wsvzUUjhE0TbaZ8iUPTwT1NVY9yT5Niw3oMCY0iklSQ66s7kwHAR+1P/eTHMD+qX4wwNU42LpTR9lEU2lMXXX9b9sROmog8gnNRGg4rqASRqAjBC0GF7GsMStVR1/ooA/LRIHrdiKN+epqv/Oi7xzJQ3X0K58faQP+289ra2+VBCMZpZel63M3JHoJDdAGv3BaV+82ua26c3UhQlQ9ZgLyh3qnMbAsINOShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/84h8iMegk4qSlbC25xq+xB/fWECJPnlddpXSsgb29k=;
 b=3YXqr4KzToQG68ntUgXifOTWDonuDuzhsDKKNRVgzTXQGoW/V4nb/SnVsbv7WmZoQ2Wb+P0YJzwzIge2wLumQtiiCORHOYivC37QWFtb0BmX/4KI+7KYtKkjA/RTVwMvB+py8zqV0K3sgfF9OpFwnK289HLXsZ52QVcGjvwlXP8=
Received: from PH8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:510:2cf::21)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 17:22:57 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::ab) by PH8PR07CA0026.outlook.office365.com
 (2603:10b6:510:2cf::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Fri, 22 Dec 2023 17:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 22 Dec 2023 17:22:56 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 22 Dec
 2023 11:22:53 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
Subject: [PATCH] drm/amd/pm: Add mem_busy_percent for GCv9.4.3 apu
Date: Sat, 23 Dec 2023 01:22:38 +0800
Message-ID: <20231222172238.412001-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f4c906-a998-4deb-b582-08dc0312a347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwOI8Xr5hdeUSGAPTUDm02IjZDCpb8VBACddtZVbx0qR7iVNmRO8IkY5Ln7QSwKv9binEDp7rZkne+6Q4BDWAEBd1IfZrBVpFEnszbPIy4F8NIwY3y45uz9yxH4V4VMNcXiwmZgo3oS54WreI+g4avb52tIMfjsO/rPaWu6bNh424Wozx8hp5D6XZ7ChNSnZYiSicedYFwA6KMPBYlQjFNIIPGOp8Hr5ve49BHz3yLPmw/c5j74RVX09r82dZUaUyC6kULXXt6IGKhj7pNt+mcoaCjqOlh59OxJXYjBENOaAHJ/Qe+4KcwIDfTDgv30YQMIbuSMQwGMsv5WojkV7x0hOFTLbzB/qrXVlySHuZq7V4nkM0IlzSFtp9+YpubxI14UYcM/4lQr8Apr9C/x8Z62DWlBYK7WGlPO/7TA82CO8CIXD8KPQHrySvuWDNfDwkVdmTHxLcfnFAsVWFxuzqPTaSFUfHz3nYckueRl68BAFQWMDRmsh2cg9h86KsHqpkF5hUGP1TnMM21ePgYB1hpeH7uK4gBdaiqZdZ59A1Yrn82/br+Uc2vAuPeVirKZbmNB6UMqpDNE6Ys+2J+QNpF2huzLv2IIMmx1S1NmGXgbf2wdK501w97yX/SriBau/ZJnV5JnukL0K3PUb/XHON6b5FJOWGpdMzsgVA5D6BWb98KXNGeJX2ToH6E4nv4YyzhbSQTTGAC2ki4m23QSYV74NGB2zIsvnLMAbM580GNqTJAl0YcvFdZVCL9KcxEA2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(426003)(336012)(316002)(6636002)(2616005)(2906002)(54906003)(1076003)(4744005)(26005)(16526019)(478600001)(83380400001)(110136005)(70206006)(70586007)(8936002)(6666004)(40480700001)(47076005)(4326008)(44832011)(8676002)(7696005)(81166007)(36860700001)(82740400003)(356005)(41300700001)(36756003)(86362001)(40460700003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 17:22:56.2823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f4c906-a998-4deb-b582-08dc0312a347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
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
Cc: sepehr.khatir@amd.com, shiwu.zhang@amd.com, daniel.oliveira@amd.com,
 le.ma@amd.com, donald.cheung@amd.com, asad.kamal@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expose sysfs entry mem_busy_percent for GC version
9.4.3 APU system

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2cd995b0ceba..f3cb490fe79b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2168,7 +2168,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (amdgpu_dpm_is_overdrive_supported(adev))
 			*states = ATTR_STATE_SUPPORTED;
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
-		if (adev->flags & AMD_IS_APU || gc_ver == IP_VERSION(9, 0, 1))
+		if ((adev->flags & AMD_IS_APU &&
+		     gc_ver != IP_VERSION(9, 4, 3)) ||
+		    gc_ver == IP_VERSION(9, 0, 1))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pcie_bw)) {
 		/* PCIe Perf counters won't work on APU nodes */
-- 
2.42.0

