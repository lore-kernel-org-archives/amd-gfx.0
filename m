Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E079C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B6861B62
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17B6861B62
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AFD6EDEF;
	Tue, 16 Nov 2021 08:02:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55D16F3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 08:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBizpOb1VZyyxk4Ha2HkG0ocov9SvQR8bG3h1/Mpp9ackqw8c3ywz0U1/6ESTXzPCEsY3c46zAxvRJCzFBOclPQFU3/XktK37IwEGKisENtyhQwJFlh++Nyywi25vNVMrqPwXbduEvV3BTnqyamioGpZVrGC4a1ZYBz73+IV1/MGI0bN0YRuUWAfahlrPa9YqO6snb6DXWij37F5RMFiSuXODI9cuMR/NrS/Qw2AqE9KMuwv1aCLTC+e85sSXVm3HhRcCYeEzrCC4E9E3uSMRiBb2/oNyg4/M6MwCUoLUA+d3+m2GBGIA0xvoVqgg6WlXb2O1Lfya4kws4m+AttNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OijA9Ph8+JDmGl+9r/jF87r054yxxdTM7864tRO21s=;
 b=bBytEA4sa53ZumGr8CF0nQODwOT0BbW5JNuWxohU2ZUabrSeBXTqw1GbvR4CMM6s6g6ui5tO26gmBnf/sdkFqE0UkDH1EVNJcHrC9dGADe6xzaNVpLmN/M0AWe4vMMIcsPIRDw//yNvLk/9Ec3mI3KUFe35MykqHT5RMx+/XLaIUzMSeMwp6bdGoB8imE+uc6vJFVqA8w4XrjN+/yESkMKfxwDHmfdiOTWOhTxqnw1ofWWw1BFqKi56406CDO426O39G8S4TwpGAiG+nzZ2Ie6QBXXgwMARAv3KBzB5gLods4rizN6fv//kikIgqXpr/BRaOg5hf7FPhAMWt1VBx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OijA9Ph8+JDmGl+9r/jF87r054yxxdTM7864tRO21s=;
 b=LZx8PPG2jPJhebctdgy6NJv0FbwkIwGypkbJZnffVvCcoezkEuABuezeiyPB8u5//nLXZktJyQtJcd8GvHitoAX92VemYjZ8LHHh4PTLAOqo28pSmrl0pVImpOGMj467pfad/2jAIE2JlwdAO+0lP+hPzL83RpHl8uKN5JT+T10=
Received: from DS7PR07CA0016.namprd07.prod.outlook.com (2603:10b6:5:3af::18)
 by CH2PR12MB4008.namprd12.prod.outlook.com (2603:10b6:610:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 08:02:10 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::21) by DS7PR07CA0016.outlook.office365.com
 (2603:10b6:5:3af::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Tue, 16 Nov 2021 08:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 08:02:09 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 02:02:05 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages function
Date: Tue, 16 Nov 2021 16:01:46 +0800
Message-ID: <20211116080146.3183-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 412fd12e-7310-4ab2-e678-08d9a8d763ff
X-MS-TrafficTypeDiagnostic: CH2PR12MB4008:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4008C3722E436457DBB0E89991999@CH2PR12MB4008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqR74oIRzeKQA7qeBibOiua4yjh2rnatL7luQTolTAqsGdfd6InLKaNYX5XoB9DtgiqFd9782PUo2C5yS9b6WsPU4gYhT7uozdjgVVMB/2rPAJyDKEP2VQuT3fRSKm/GKoRe3FAVJBNLgu231VWCMRT3qLGfUpzcle9AQlx4dt3zsEKXt1ukI26RZO6QCM79CXAEBzAdEFlFXx1UvNRHnvmMTWm2fCyidMPhyqw3EywGBn4HMrj5qoZjbVnXo8+o/tnIVrou3FCd1zanuTYbGRkPgsYHZJnz40twsoZriS1I+G6a8PuUmlhcMqfcO6/GE4ovjNcq3qbq0BLeylyoWMM6qlEOkJt5ko7buYumjVZvcO4N2Q/J8Ov69ab2Un0LyJ6Bot41szf0SS7VZfW21ne3Ena/ytqnDncTWczjrDVsgM5ruua3a8SC2FOcEnq63FnY4pcz9DHXvV/2/7bjez8+kMGD31oR+5Wb9PwgjN5SwTGoEMsmygYx3oW5chmQf7CSw4ttF9oJ73DVwV0WESQz82GHb2NkHt3v2/hCw4mqi/f/VCl10uY3qVoGYNHnKWvFzcESd5BqxC0HW5FOHs8jeiurm2pCPYJLwVT3fGuk6hosk6rX7eBbG03MKYU9NncMq7neVddYpgTCah1GXcYjMzzc+V3/YKo8UiUSwNGiDkomUIlkCl0ti463i7GzESo9ctKjPpy2pybhHCzkRakVraAYzTZV2tiot5M1bhY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(54906003)(36756003)(70586007)(83380400001)(36860700001)(8936002)(7696005)(426003)(70206006)(2906002)(508600001)(316002)(5660300002)(8676002)(6666004)(336012)(6916009)(44832011)(2616005)(186003)(16526019)(4326008)(26005)(86362001)(47076005)(356005)(1076003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 08:02:09.7776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412fd12e-7310-4ab2-e678-08d9a8d763ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4008
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
Cc: Tao Zhou <tao.zhou1@amd.com>, John Clements <john.clements@amd.com>,
 Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix race condition failure during UMC UE injection.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 08133de21fdd63..711b5fb26d47d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1931,10 +1931,12 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 	struct ras_err_handler_data *data;
 	struct amdgpu_ras_eeprom_control *control;
 	int save_count;
+	int ret = 0;
 
 	if (!con || !con->eh_data)
 		return 0;
 
+	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
 	save_count = data->count - control->ras_num_recs;
@@ -1944,13 +1946,16 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 					     &data->bps[control->ras_num_recs],
 					     save_count)) {
 			dev_err(adev->dev, "Failed to save EEPROM table data!");
-			return -EIO;
+			ret = -EIO;
+			goto out;
 		}
 
 		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
 	}
 
-	return 0;
+out:
+	mutex_unlock(&con->recovery_lock);
+	return ret;
 }
 
 /*
-- 
2.17.1

