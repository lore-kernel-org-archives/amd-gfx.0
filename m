Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60462C83F33
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 13:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC0910E1D7;
	Mon,  4 Sep 2023 13:03:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42CCE10E1D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 13:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2gYH4pl9N9MV/SDKUvtTf3XqRk7DScNeOuENzE2e9RkV/MjMJZfVzJPht1weZSGDA0iOaJtZqx5EdcYdPACGRFIYpritKq+ecRykm8qvUOdsgkpS9SKdNCkOWZMy4dgZZpZtQpb7QNIelfWacVQBtt0tj9iie0M9C/oEPwonwYMGdjTCKHnTDhTMZ8l2cO+6oW5Oi+kAK11K9e30eYJtTbihrBKCYiPr3H1tcPSSL3qoUvJr2Q9yR3aRL1en4bU1Sn2ZV9E8opjKG0udOPCzVKOHdU6xO7d+f5p9gGUpG4KcaSHVqcevGXh+99E649HVlrdY2KaQI31RBV6S8RhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCCpvWj3+/qGWNSDs5llgsKHGYqbAm+Mq6u7mrQ/uGo=;
 b=Y4tSA+nTACQ1FX5LGc5HCGdxwBiKdg3TPDAsbB+7qpcuDbbNyGJ/xiO3Jadf9twH6+/wQp7r5WWXCExr0I+I8vGonzQW2mdX0Hea83/c2LmtAi3dkChYMx/8pqDpTC3o6s/LFrXFR27737QNIkVE3XatilI1vQADsVS35xYmDJfU6TJFtlPwSxJS2NLGFpkASnR56NNpVGGwCXSIE/DSSct/W6jHbYeXQrrI9mHQC1fxhBYCfWHrFqMLnAtLP6OQRSsi/Yp62wNfR9AM4zVFjBTzHZwxYynIrrsUNaxWWfH6LzMm+vufAU09UmkNCt1TYrw6AB4wU3LqePK4eB51eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCCpvWj3+/qGWNSDs5llgsKHGYqbAm+Mq6u7mrQ/uGo=;
 b=ZRLWPBXZpZ2wQfGZArTPHxHBFMtOduPXaFp3VlgxBgcGdcyjpFTq7oheQWig7aQvj4kZ/iEr2P6yAmiPxAJ0LTTr1RrG1mjfw/zu0HZlYqh3v4OVFQFS4o44gzr6EG5vvqJMcvsZNJqetbvqtYXVNfI/BioYcMTYKt77i3ST7aQ=
Received: from DM6PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:40::20) by
 SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 13:02:58 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::ec) by DM6PR03CA0007.outlook.office365.com
 (2603:10b6:5:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Mon, 4 Sep 2023 13:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 13:02:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Sep
 2023 08:02:50 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Restrict bootloader wait to SMUv13.0.6
Date: Mon, 4 Sep 2023 18:31:40 +0530
Message-ID: <20230904130140.911853-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e86610-c3b2-408b-8b53-08dbad4742f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQ0q9Iploh3FM39eo+9HwwYnGPo1BmaaLhX/todr43JwJf+cOqan/8IQkZBaWul1yhFUIBP1QkudQeLRFkN+ZnOGPNOlB3APIdg1gelID8+82oT1CrYBUNg4ihX0mqiiYbgF7/rVNKonHu7Yw9SouP2ASdV+AQn2hj3brXIhRYceJpc5HlStcmBiuCUFToBOJm4yvMzUbcuJLqiYqNgUMzVoWo6QJFAfdNU+JLn43w+Lhc5+Kj9tuM52MKRw8R0zwl/qBJv9Bg5FkxywmhRNtRf0U7Eo2m0dmY98N3es9msD95cAV/KIVDJoBwQt9QO4+fdF8o2m8i0MR7oW/WgE1/ZJ1SQ9OLo7sPIauLA4O5o0JwLIi9tPMhY3A0F2rUsuEtbC1f6kbEVFDB68mErM9Dchx+A1VsEfczOw1TFfz3ETzeGXNCuCcagmj3KTeo2NYVKQVwE9wxMmu/Jfx5bQceManejFlKi91qM8XQPw4/RZ0oqBFcsPzdyhIs8xrLCsgIUMXQ1JFB3WIYcnCdiiN5ZlPwdyinMXY/irL793Rx0lcU6sjxdbloCO9dCN3fzcTmsXzkTQSttw1IpsWgzuKYyEpLHOvwC+zLBkPs9QBzbgzJPWpvgksv1fmnacCONIPQRjWHSNlYea4wN2G4CQFQMlBKvb6/rKshZG7VSKgchV0i8ONf9Yo9HF1QUTLziwpmkhZLJRSNu9f7dbTbv+2LKiP3x7Mda8StIqZID7OpBiYIK0dLEED3OfKYa5Y4fiNypZOYmM+TuE0rD6Wa3SPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(316002)(86362001)(36756003)(6916009)(54906003)(2906002)(70206006)(70586007)(40480700001)(8936002)(5660300002)(44832011)(4326008)(8676002)(41300700001)(40460700003)(36860700001)(426003)(2616005)(83380400001)(26005)(16526019)(336012)(1076003)(47076005)(478600001)(81166007)(356005)(82740400003)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 13:02:57.9725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e86610-c3b2-408b-8b53-08dbad4742f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Restrict the wait for boot loader steady state only to SMUv13.0.6. For
older SOCs, ASIC init has a longer wait period and that takes care.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index d2a88bc630d2..469eed084976 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -160,9 +160,6 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 	int retry_loop, ret;
 
-	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6))
-		psp_v13_0_wait_for_vmbx_ready(psp);
-
 	/* Wait for bootloader to signify that it is ready having bit 31 of
 	 * C2PMSG_35 set to 1. All other bits are expected to be cleared.
 	 * If there is an error in processing command, bits[7:0] will be set.
@@ -180,6 +177,19 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 	return ret;
 }
 
+static int psp_v13_0_wait_for_bootloader_steady_state(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 6)) {
+		psp_v13_0_wait_for_vmbx_ready(psp);
+
+		return psp_v13_0_wait_for_bootloader(psp);
+	}
+
+	return 0;
+}
+
 static int psp_v13_0_bootloader_load_component(struct psp_context  	*psp,
 					       struct psp_bin_desc 	*bin_desc,
 					       enum psp_bootloader_cmd  bl_cmd)
@@ -737,7 +747,7 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct psp_context *psp)
 
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
-	.wait_for_bootloader = psp_v13_0_wait_for_bootloader,
+	.wait_for_bootloader = psp_v13_0_wait_for_bootloader_steady_state,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
 	.bootloader_load_spl = psp_v13_0_bootloader_load_spl,
 	.bootloader_load_sysdrv = psp_v13_0_bootloader_load_sysdrv,
-- 
2.25.1

