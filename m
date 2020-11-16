Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB01C4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925BF22240
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 08:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bAzBemCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925BF22240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2455589D4B;
	Mon, 16 Nov 2020 08:20:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8984489CF3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 08:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCGSDd7V2auoixS+LPMJD/gM7tQewTGCDuz8lNXy2j1cOFSw1VZ7/34LsHQulVNA1Z5znjpNbIlmK6Jp8CBQ0cqUgkJpMy+qVY5noo3OLhF8IZkc1IOZAU17wk4iXSYu3bc62+HFtURl2Y/Mnz5LeBK6GrNrIPQU0mghhW4a0pByLM2WewYjRQPx4sxN+6+7PkCguDST9iSwCt7OfvIR+zfWahDi3QHQXRbrM0s7QG3q3BSJuT4ssxE39oV6e0IUHd1tAlRJxisw1xHGiqlQzTEY5vPAETvIO9okDnJBGoI47zR+3dMrFmkrwfi0rmzX1InleM8kfRx1oBHTXChSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UEb9UCKVpGuijwXFvXlFp7JkFgEQ4mgEWaSZGNgFS8=;
 b=nqii0Q5fI68XZbCxOC+OW3TdH40WaoTauGHt/cPr8XThTt0ecT5xEH+wjphnNwz+/7+40iwvIJd4AqMGA4iIz351vDoTX9Q1goE7knyea/JKS40OkvSc7m084BCc7sl9bOz4uMr2eJsoOCtnZZJtVmSi6ABNBYjK9L/U/1hyEjqFiDdxsnwsNI57FgNnt6eKu8rWQwDKqgPvxzLBNwDQTf8g5k3bm0jkrVY/NR1Ye3NGXtvHPTxaGMyl3cmTJmWuIOJb2YeCI2dgy7XKbBt5D9+pT4VP5nl9Txq22cnW12GSAFsus3f9IBqm2oxe50lFH+NNMzXfOAKBjpOZFzwPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UEb9UCKVpGuijwXFvXlFp7JkFgEQ4mgEWaSZGNgFS8=;
 b=bAzBemCjmxJFb6Fxe2B7fE7orUWLIoBLNQ3cOLjjzbmnYVm3dZmLfTz7MjzJ71JIRAsp0khA2k0HcoU0eRAT3AMZvPAgD6+YxXa/byuM23Xjth8l1BpZDLXq3tb4MOXR6w3rbxHg+LFS0KaalCk1dx0aniDG6MhxrV7E/hmiGjU=
Received: from MWHPR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:301:4a::21) by MN2PR12MB4437.namprd12.prod.outlook.com
 (2603:10b6:208:26f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 08:19:57 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::8e) by MWHPR1201CA0011.outlook.office365.com
 (2603:10b6:301:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Mon, 16 Nov 2020 08:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 08:19:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 16 Nov
 2020 02:19:56 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 16 Nov
 2020 02:19:56 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 16 Nov 2020 02:19:55 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: change the baco parameter
Date: Mon, 16 Nov 2020 16:19:46 +0800
Message-ID: <20201116081946.15755-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93eba76d-817a-4426-8505-08d88a086775
X-MS-TrafficTypeDiagnostic: MN2PR12MB4437:
X-Microsoft-Antispam-PRVS: <MN2PR12MB443714E32DD6758C87632F708EE30@MN2PR12MB4437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRbpDr3f9oOOzIAEZhIvvxvbQlkg202dJOSuwQylT/HuGG7ZXz3N9KSvWzqgDrHlIo2qriQUufHdJIKDmkAmGA+d+cru0ZU4mZd8roGzqC9jYnlLLb2vU2n98Qews/S8zWXOmKaV66yZiHB70q/qq3A/zCg2dUQs2GT+jh2IghXfTKW+PQxBFJFsnZFXg0xl0JNEwJfQ5qkc9XgW1DLVtdoDkTqvFyfC8UPDCQFm6OAk3YybUYR/6Mu/cPlq/YnzZLwtppS8bioujAGiu3ePeOvh7MtJ4oZiisjaJ2UqrDMg4s+jcrM61xDbyJhRsDRdqUxuAL1fjbYP2+0FNAE5xo92vBtmexoPNIRinqWUBe9YX+16saZD5bwHTzRFLgXzdZrmQrce5tY7vUJ9YR4b2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(426003)(83380400001)(7696005)(336012)(86362001)(356005)(81166007)(186003)(316002)(47076004)(82740400003)(8676002)(478600001)(2906002)(4326008)(6916009)(2616005)(36756003)(70586007)(70206006)(1076003)(82310400003)(8936002)(44832011)(5660300002)(6666004)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 08:19:57.1432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93eba76d-817a-4426-8505-08d88a086775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some products, baco parameter 1 is dummy and this doesn't trigger the baco entry/exit.
Parameter 0 is valid and these products don't depend on ras for baco sequence.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b6453ee6f8e6..3e1a3cf44a69 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1495,15 +1495,25 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 	mutex_lock(&smu_baco->mutex);
 
 	if (state == SMU_BACO_STATE_ENTER) {
-		if (!ras || !ras->supported) {
-			data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
-			data |= 0x80000000;
-			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
-
+		switch (adev->asic_type) {
+		case CHIP_SIENNA_CICHLID:
+		case CHIP_NAVY_FLOUNDER:
+		case CHIP_DIMGREY_CAVEFISH:
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
-		} else {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+			break;
+		default:
+			if (!ras || !ras->supported) {
+				data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
+				data |= 0x80000000;
+				WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
+
+				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
+			} else {
+			  ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+			}
+			break;
 		}
+
 	} else {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
 		if (ret)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
