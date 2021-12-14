Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17A2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 21:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A9510E1EB;
	Tue, 14 Dec 2021 21:30:41 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B84510E1EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 21:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFdOGg91cqgXnQj80pfTXt8Y3whXPSZPIGFXEOtZaL2OSXUd7W2S3lDHK05QYPA1JuR3u+3qDptuQw2X0NsUO5+v4KTsjA9p7Da/MTgwuENYNmjSKkXmLwVvCdUtIdzxdQl/dWdgKFp53MxOW6ejYHKl4cLtVFQnaqjrrVQ0I4b2CVPY8ZQngzJ0fqDgBhcH4yuS55JgyhGslp5GT/vDPueFY8Q4BF6eXNkKJ6v6nwyIPukG35Uj80vSYMkmmWAHgJx8ta9qU7w/WWEW+SnlJBKNUIS9sJ1/yViB1G3RGsoTaXVCvKMoz+Xs5icE0Ql716U4bg+B3rmkbJ8A4hK+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXLtgUplMDeGlmjpuhpUMfYugrhVHpyFYLE6PqG/RgE=;
 b=HJ8ZZBtJq+kM/vNOG58NW8UVN0yq9ta7iNlABBdS5bwEWx0t2BHDYQR37NXMANApVDz1sq1C4hqSIFsSitzcKQCRxZ8KJVWhRvsgsMTlS63RVCn0Siwd5gpctLqTKaSfMFnqPCqgVBbJ0RIGeCpHOIutj8Du3Eqn1+4v1oNr3qbyM0MwtnenJkn5mZlbmx9pH4tSj9GCogNRJATro+oOFYfYj2AkDCa7BUmANV1rhtoZUfgtJBI3BKUiLRRaPk/IBmPsWsGAwQ/wSQZ2hJDHYvb2UcVSif0+nvalvR05Lm7nhI3FVHKJaZYsJo2LbyXnb7x6Ngh1H6WPIqfLJ6yAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXLtgUplMDeGlmjpuhpUMfYugrhVHpyFYLE6PqG/RgE=;
 b=SMe6iBTbrhDGPDwkfzPi58qWXkKtrJMfCAKu7CB4prGQrXibZDYEmsGZ/ZsfL0BP3atdVtElN2z9AneWXt36dxiLewJGzWFGdHKfOu/yInkeohDHv1kZmCPnN2F8WVLL7mRmtrb6Vb6iWGW3Zt2i8p1HmIzL4f4mDxAn2sdvD94=
Received: from MWHPR08CA0044.namprd08.prod.outlook.com (2603:10b6:300:c0::18)
 by CY4PR12MB1317.namprd12.prod.outlook.com (2603:10b6:903:3c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 21:30:38 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::ed) by MWHPR08CA0044.outlook.office365.com
 (2603:10b6:300:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14 via Frontend
 Transport; Tue, 14 Dec 2021 21:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 21:30:37 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 14 Dec
 2021 15:30:36 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: restore SMU version print statement for dGPUs
Date: Tue, 14 Dec 2021 15:30:24 -0600
Message-ID: <20211214213024.17116-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e65e531-5673-43e1-9f18-08d9bf48f85e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1317:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1317B376687561416D0A6E70E2759@CY4PR12MB1317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVtBd8Sh31Iad8wuLL2YZXLEKsteXt/ZMxweEK0uiG+g3wd/6yfGjjVxlsYP442E/6Zdwf0uorGL0+4NAHyEGoKZjYVOTOUL8mM1FYnixgB9DOR9NCC/FrEvfy/gKwehTxhy0V8MuAtC/+FbtDeJCKE9b8oNJKaGesvSdZNrFrkNbJx7LKm9FDl118L4gsXoHI54FtqwjOw0tXO54X3Ce4Hvfv8kUogkQRtP5JWWuztRv96b9JKIIFtAEvQCYC6gWVtCeK38704QaVfux9qyBXKhBTY67vvN5DlByJclqcI9DXdAUZ1FyiytiaxPkodQrX9x/GtoWXGda1AmWKrkAlpqERZ/g7XZkvj2EGnFGps5RAXK9g/YZHx+S3qaEgtLDOB3AqdbLhwl5jtbA9SF/YgPYDxp6ODqapZvWJ9w8m4D1TEr3Op2uX5724DEtEK3lSi17Kt9c8azVN9Fj3b38+fXfomW//1g0qoa+9Zj4O53hpmInDMWFjq3zqELHm9tsc7+JRzQbqyff8wg/dNTTcNtLdkN+WhrtvplB++MhKZHB07WrTsk3YS65RRelHV0D2jQ/1K1to3/jSzgzeyayCe/1dA5PFQFkxV/GhabBI9NDQM545EmjyO4/7BlHCpYEdJC3GkOnSNtpA4B6lMQeQ6/5YHxZUROj9ZMa1W7N0f1SHHgAthb+oh8TwAdZrj0FkKCUAsNd4QYcJ92dXjm8zHM1efT7yQ3CiKyeDodYrtjOTxDiSuCrSCAO6vAO1GjGDuvVchQIKCceSoIzwtDcCvGw84A5flocQfVBe9WARA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(81166007)(508600001)(356005)(6666004)(70206006)(36756003)(70586007)(6916009)(83380400001)(4326008)(5660300002)(86362001)(47076005)(1076003)(36860700001)(2906002)(26005)(336012)(2616005)(54906003)(426003)(8676002)(186003)(16526019)(7696005)(316002)(8936002)(82310400004)(4744005)(40460700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 21:30:37.3574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e65e531-5673-43e1-9f18-08d9bf48f85e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1317
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
Cc: Lijo Lazar <lijo.Lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is still needed for thoes in case the firmware fails to load
then the message is the only way to tell what firmware was on them

Suggested-by: Lijo Lazar <lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index bb3f6072ed30..b54790d3483e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -227,6 +227,11 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		break;
 	}
 
+	/* only for dGPU w/ SMU13*/
+	if (adev->pm.fw)
+		dev_dbg(adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
+			 smu_version, smu_major, smu_minor, smu_debug);
+
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
 	 * to be backward compatible.
-- 
2.25.1

