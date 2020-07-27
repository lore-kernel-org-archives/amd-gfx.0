Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4E2C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 09:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CF32070B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 09:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AKe8AGJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CF32070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E4C289BF8;
	Mon, 27 Jul 2020 09:48:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0256289B9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 09:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR2BXF7g8xTo+CBDEjHWs8qjb6zy15Ojw3mt9HZoVpw6CQQ6Sax54LEJAhBg7YCynLJMPd61ym1mzJRPFOKExODmwr4YPbel1TYksGqNfLWT1LGjyDqRo0vBuHeDuuZbE6Jroo0gwN71C4+TOAvGqD2cEZCvhyHJVxekxhmM/4deSTQF8gqgMtj4bf0zHtuK9yiqpd7CYOOgY93OJVjgfpTlbgLgmqm8Dpww3vpZTrqERbAmsgogySdVMGCgYmm8xnpMUtd1pXCRcrBM/3lX8Fvinm/YfGAOmwepeczB96MQwwfdBxYIbLv6QXzeRt6ePdB1Hg0JITFW5YwJovVgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVq3rJyQm/oOfY7WSj/0z8yuK6ki85vWfBBCPJYjLBg=;
 b=FHv4j2rqPKvmob/OB9Or/oalrUGsZ1LcT2kArqMgmdMI7YEcv6+hsZpxfKCvGyEbgiCGr5JeT00E/INPR5yDMfLWlIeR/xjIAPopote+MDuEpoHFSP18+7L/TlCcWR2KXComjrHENIHwp6nLRnY4345U3qq7lVSdQv1Eu4BY4MoMjEmg5KveJX+KNUOP/WSTNVRGf/2eS8Cloi4xEJiREgsXo8N5MkKB09cYfC52WtFDrbT1DPIgR/WoQfHDeyILSfILmpniUXj9r+jZPfL15QF5XT2SVgjNpFb+Fptjq3eUrUEXAUagy+Nx+DTMBQKt4n7b8Y9NruDkho2pVOnabw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVq3rJyQm/oOfY7WSj/0z8yuK6ki85vWfBBCPJYjLBg=;
 b=AKe8AGJne4GBhw2f/LzrPdeiVPyupPvD6wJrwKGJmGogk4n+chrJLOrSJ2+eUDOhYFvV3oLZfzRm/Si1uQexYOZ4JF6fabZxxLdAwyhcnarUEVZg7nuFxfZ2orMM7gLlMbNyLMjopwsiYuBP4sogq4VF1wiPQOSm1z1EKnWvjJ0=
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by BN8PR12MB3443.namprd12.prod.outlook.com (2603:10b6:408:63::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Mon, 27 Jul
 2020 09:48:13 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::d7) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.1 via Frontend
 Transport; Mon, 27 Jul 2020 09:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Mon, 27 Jul 2020 09:48:12 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 04:48:11 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 27 Jul 2020 04:48:08 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm amdgpu: Skip tmr load for SRIOV
Date: Mon, 27 Jul 2020 17:48:05 +0800
Message-ID: <20200727094805.400481-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de620929-bdc0-450c-78df-08d832122d77
X-MS-TrafficTypeDiagnostic: BN8PR12MB3443:
X-Microsoft-Antispam-PRVS: <BN8PR12MB344321CB2477B42A5655E7BE93720@BN8PR12MB3443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: db6BkOBT1jWV+WSJ8BIDvZVRB2xsVx7v0QA36PQwgaSar+I3GqYQr6V+bP7LMGhpRoqzcq2Rw7rZpVwq7XCtp7kDS9Z3PJ/+Bl97yPecw2S+49T0h+uuMcMaW28Aa5HhaVthJOKzETk0yazbbCDM/1i7+q4hhAA5zT8f/hoIeB/HHeHFbBdEIxSz6c7cmclUsyrSeBIs90IMi9pw62njs3uWwyTfatn6PsTEzQk3be/DVkGD+SxYAsuhaERA/Lmr+X3eRL29P2skqgvRitYZDUwnQ7EpQ10+Wal+SRBFcf07U+ny7qetntwdZ0VjRL1rZSP2E7egT8BISonI3Mh7aA3HBayiPGp46i+pdbwlwGdIwlVfIpptayeO0pFo3e1oeJoEXhvYxvle1fuYrgS/CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(70206006)(70586007)(5660300002)(426003)(8676002)(86362001)(478600001)(7696005)(316002)(54906003)(1076003)(81166007)(6916009)(186003)(4326008)(82310400002)(336012)(36756003)(2616005)(26005)(8936002)(47076004)(82740400003)(83380400001)(6666004)(2906002)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 09:48:12.3941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de620929-bdc0-450c-78df-08d832122d77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3443
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 root <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: root <ChengZhe.Liu@amd.com>

    1. For Navi12, Navi21, skip tmr load operation;
    2. Check pointer before release firmware.

Signed-off-by: root <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 40 +++++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a053b7af0680..b0717b16b5d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -193,12 +193,18 @@ static int psp_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	psp_memory_training_fini(&adev->psp);
-	release_firmware(adev->psp.sos_fw);
-	adev->psp.sos_fw = NULL;
-	release_firmware(adev->psp.asd_fw);
-	adev->psp.asd_fw = NULL;
-	release_firmware(adev->psp.ta_fw);
-	adev->psp.ta_fw = NULL;
+	if (adev->psp.sos_fw) {
+		release_firmware(adev->psp.sos_fw);
+		adev->psp.sos_fw = NULL;
+	}
+	if (adev->psp.asd_fw) {
+		release_firmware(adev->psp.asd_fw);
+		adev->psp.asd_fw = NULL;
+	}
+	if (adev->psp.ta_fw) {
+		release_firmware(adev->psp.ta_fw);
+		adev->psp.ta_fw = NULL;
+	}
 
 	if (adev->asic_type == CHIP_NAVI10)
 		psp_sysfs_fini(adev);
@@ -409,11 +415,33 @@ static int psp_clear_vf_fw(struct psp_context *psp)
 	return ret;
 }
 
+static bool psp_skip_tmr(struct psp_context *psp)
+{
+	bool ret = false;
+
+	switch (psp->adev->asic_type) {
+	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
+		ret = true;
+		break;
+	default:
+		return false;
+	}
+
+	return ret;
+}
+
 static int psp_tmr_load(struct psp_context *psp)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
 
+	/* for Navi12 and Navi21 SRIOV, do not setup TMR
+	 * (already setup by host driver)
+	 */
+	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+		return 0;
+
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
