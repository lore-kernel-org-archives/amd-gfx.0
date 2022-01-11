Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4F0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 06:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0EBD12B064;
	Tue, 11 Jan 2022 06:34:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE5612B064
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 06:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyCBF9DjqxkZAAOEeSjkdhdksJ2le3MXVEDFO+7Fi9zEh6A01eQBAoH2CCU4D4yL137qrQKR3whblYxETnmrrO74t5DclXWnfk6St4zpMqQHHzUf58zSPbWh7EFO7pPIpAm9bhMeFzu+LGmmTH50fJd0nTGlug0h2c5oKVAZOf923xZTyXzF2ZX2NeHVQqb3zKL4uMDV+qCFjldwUS6V/6qkHj7nHXPCn6EO5JzLhZY8Wz0N1PMUhoOJb0kGtMeo2FFoj86YtljtWDRx2ViMnP5qOWs0FKPBOA2Xpb0WrEdedKUiefbyEps6cVb+rZ7rdFRwY+VBp8owOzH4wDSqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jwAM2Lqi4E2HO/wKySW0bNbtfe4pHDgT1eKCuUA+0I=;
 b=PwVtEluEGNNKSENDsbRib4/2hVIWvStC0OO1abW40dFnRBgFgww9Bt6rgVMgo1aHJzgs/yLOWgkXbkOcGHMPH0TcyvgnafFamYJVNj02d0Jx1tRD386GfO+hyV95ZxHhtqhmG03LEyVER4Ff48IrcQtSvM09gJdHq7wCIxVfcJWdR9fROXfUtTCgj67wACH3FCbUaextyQlzKZBDwZb+wptanLNT4LUJDabKQ3i68uIm491Sm7Ay72Bl/u/pk/swAn713qAKhR06PKzmeToVmFbOJg3uILlRzqKkeZ0ch8jiZ5e61eBZ5nke4rH2bPc6X2NUx1fc8l16xXPuZh12EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jwAM2Lqi4E2HO/wKySW0bNbtfe4pHDgT1eKCuUA+0I=;
 b=Arp/6AjBkazu96H4p8q9DFbtIrk9BwYEvvVq9BktGsjz82h+m7vF0xxUVR4eEGm1VGks/Ei21lCepfvurxQ7gX3Sq94MancqD3WL5nZrj8H1Yryyl7Wr5agpGrg4x50T94u8d7E6bVVBl7aLLFkW7gY3R50cpweopBRdOwKYHJA=
Received: from DS7PR03CA0158.namprd03.prod.outlook.com (2603:10b6:5:3b2::13)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 06:34:09 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::7f) by DS7PR03CA0158.outlook.office365.com
 (2603:10b6:5:3b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10 via Frontend
 Transport; Tue, 11 Jan 2022 06:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Tue, 11 Jan 2022 06:34:08 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 00:34:01 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Evan.Quan@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: only send GmiPwrDnControl msg on master die (v2)
Date: Tue, 11 Jan 2022 14:33:52 +0800
Message-ID: <20220111063352.16123-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a09bb21-32d9-4ddf-887e-08d9d4cc5f78
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3944CDBAC2FF450377AF343DB0519@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmxHvmbAJ9i4qvomH8acPT9jQ81BJ2OzF4KxqazuyKkiODIjljXgCqjRngorUUy01cymZnlzlS9IcAhU4S654R9Lk4ifsSFVeYTN5Ent5jeWWQeYr7F+udn/G+76yOCw4gsEzQ/ry+aS7DdkTtkw2pLVVfx6FxLOHM+imd4pZTim+1yaKXzBwDMFBe+IamzEMhRiT8rF1CkakODSSsY+z8S36skhy85rYpWTLW8wdZfbABL57du6yIrFf+9kfxabT3kR7TZY25cvGbI3oVzDzSksulrXAN5qOk/hfhc4CxlOqgkSX3lddce6jbBlTeh6y72zBmpog8BpnN+h8o9wOGluKTaYHZ/zYRNvgkcK5/qlMfyaibuyXKrlLbEM5KwCEbN69Qnx2YN0I4ATwt2rOyCrL4cIHBhA3lohdukmOU8OKjalxZjfhybHUTeWBg/PjZoouuzFE1FWZnG6U72irRi0rdT9wRhV2cfD6GHgg++SfaXFwXj9RceFoQdikqFIokGFFAIP6CZFSuWgB1nxVPb39lEJeXVVzGNR/cEIRvp1WbGvMkTN07h8NBBFrAkreuvittYHAWiDagF6X8Z6U3jWCIm8Jz4Nqg/tuIsgqSPMzE/XxzJSdo3mybVZezBSOfzaXKnWcbXT4hnAtevrJeKkDxkjvL8LJ0xRrCHxqg1Q2ZydzW9I0Tr7OBATAyDE6B0qfMRKJP/PdNeGWHX6KwDbE8zYJppmlVRfRuU7fnsE4W98XBJ98jsLQNkLeja1/xtbXgIHemGhHGC6ovL4VHA+gWVBMb27JNzcyv9Y9rA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(6029001)(4636009)(36840700001)(40470700002)(46966006)(8936002)(26005)(8676002)(6666004)(47076005)(186003)(16526019)(83380400001)(356005)(70206006)(70586007)(40460700001)(82310400004)(36860700001)(2616005)(316002)(5660300002)(7696005)(2906002)(81166007)(110136005)(508600001)(6636002)(4326008)(86362001)(426003)(36756003)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 06:34:08.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a09bb21-32d9-4ddf-887e-08d9d4cc5f78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW only returns 0 on master die and sends NACK back on other dies for
the message.

v2: only send GmiPwrDnControl msg on master die instead of all
dies.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 261892977654..3fe5c05ced77 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1625,10 +1625,27 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
 
 static int aldebaran_allow_xgmi_power_down(struct smu_context *smu, bool en)
 {
-	return smu_cmn_send_smc_msg_with_param(smu,
-					       SMU_MSG_GmiPwrDnControl,
-					       en ? 0 : 1,
-					       NULL);
+	struct amdgpu_device *adev = smu->adev;
+
+	/* The message only works on master die and NACK will be sent
+	   back for other dies, only send it on master die */
+	if (adev->smuio.funcs &&
+	    adev->smuio.funcs->get_socket_id &&
+	    adev->smuio.funcs->get_die_id) {
+		if (!adev->smuio.funcs->get_socket_id(adev) &&
+		    !adev->smuio.funcs->get_die_id(adev))
+			return smu_cmn_send_smc_msg_with_param(smu,
+					   SMU_MSG_GmiPwrDnControl,
+					   en ? 0 : 1,
+					   NULL);
+		else
+			return 0;
+	}
+	else
+		return smu_cmn_send_smc_msg_with_param(smu,
+					   SMU_MSG_GmiPwrDnControl,
+					   en ? 0 : 1,
+					   NULL);
 }
 
 static const struct throttling_logging_label {
-- 
2.17.1

