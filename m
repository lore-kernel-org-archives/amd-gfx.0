Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86304C63797
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 22:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2984210E177;
	Thu, 12 Jan 2023 22:37:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7138B10E177
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 22:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkFr2qLZK+RY7eCJLvaqKCwfrNxa5JLAJi9u3X7v1iIYGGuoFdfTHtppiFXDJ94VtQI5Ic6AmvV+C/lX211W6s2pwhEFG4Evkcq5ngYvHbv07x/IBn0e67h0+pYuFvV5YexMY72gyejezIdj8hQ5e+F0cKk52o0jCf9WU1XAjRxbqpIvDYsekvKPgYl6sFDgis6IdTHn9FE3k8AsDfwjEFhe71RZG8B2faqt+7mmIzTO/weooIvMjhGoRBxcik//dpvAGgNYyvJtvWqs6+y6pNXS6GmbRkTBpsXgA7Z1C5ep2mziOOkm2rYXUZZ9a+yBfBGd6YnbRgm8d/GIKzLWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqI6j+9Q12nDDbepq8HVh3HrE5veum+9SvWv6KXwzZg=;
 b=gmy7hTYsIxZTd0lIiZctPt7EW7aWgyMxU0phgDWf9UYtDdsiGvsEK5zZIgDf3tXEHOO/5ee+0YkZaSWLNEc7xyEEmVjyoWgdYjQgb8FOkXR/tGSfYqSm8oRTpeHJ4Q/xcdeqJhoSK1ENGTQKVpK19Qk7Zx0dKEWc7fZfP2QtK9aLR7iNnrVm6O46rbyPkNXHPh4cKWZSrcqNNqbb5BiwiZEMaqY3qsWMFdGTG/MHoBRZj8cwwIiNif7gDiZ1MvN0obDpUp3dX2rDipQqaLdyyYeqsxOL0MaS8VcDnPlISDyWzd7foqDNA2Xfkk+Czu9zATaontV1REeoChUlUOQzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqI6j+9Q12nDDbepq8HVh3HrE5veum+9SvWv6KXwzZg=;
 b=aWznPjieg/YHAFL6IEFGSaqduarSSLDJwFyD26BKwiy+CCXMj9H1pu3M8WVa4Ecl3GpTVkNnA3XNQ3TBdpTAx16H558HpT+ePksLmCriF3GrSKvE3ty9TTX7opE7phn1j8ZuDPdR1sebNxKjc9ozRxK2V1Bsi17BEr5bnRWdTYw=
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 22:37:11 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::37) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 22:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Thu, 12 Jan 2023 22:37:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 16:37:08 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: fix some dead code in
 `gfx_v9_0_init_cp_compute_microcode`
Date: Thu, 12 Jan 2023 16:37:01 -0600
Message-ID: <20230112223701.29477-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a14a29-2177-4016-4b0b-08daf4ed8b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GdbwHFKsT8HyN9Js2dlhtzJGwD8qoRvMU28NRD94IuynrcIHI9Kt+YHMlSmTWjNXiTcAsaAKpTihmugXXpmPxhYvnJj3FIFpbZH8VbKEdyuPqSdfodv8w/pKC/EbNMhS0K3S/IMfL5vRL5TNZV37l4MAXJBeDKxA2LLGd9SgLpU9iPjnerjD9toliVvd5yCnO2ODFfBLY+NElgK7lHDQFbrvyTBoc0Xf+atyyleKLQujTZjfdevv8EE3faEg4yN2Hq5D/6MgXNvAwFdQ0eCMqhaYPh8IZlQH42HXCLkmj4GtN49nKRAxMziq6Q3h4YbJk/+HBOZO8ZosKe958S9FhIl2TFq5u/pbtkjYriSpoyTYUAYk9N8tO1zHJJ9zAQpxkJcEb6pD4BvA/b5iFQWzovyKcovQRCffe5wgy78d+Gf3nl/wkxqiwaXYc43XoJNRr/Hz4a5SLRwBb4xncpzb/lK9twjV4c1rhUpRYR4oaRCuV7w7XRQnuUAuD+QrjjnuwuhE5ynYbw3EjuuBXZhSiqZPKsN3ovLHp7Iooepxz6sc7+bNCQK3iTLGNjIzY8EqMVnViJcN/0yFDvFxiQ8mY7gCNzzyNUM+Bg88tgqqOEo1vz+lfZankdFbIKPhzmxew/5jwc1GAMh+9l0NA4tTvEXmsehM8I7R3Rm1qk+7nsUY7a0ak2pDysJC+LhKzfzh1gEEE0gcMWOkgkcCw4j2V+cKBnmfEk0ygytSVLB2hmpr65q9X1DZ8FQTtmdx8zV8GoMqp1R8pspXl0x2GY8Rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(478600001)(426003)(356005)(81166007)(41300700001)(47076005)(40460700003)(1076003)(86362001)(316002)(54906003)(2616005)(336012)(70586007)(40480700001)(26005)(186003)(7696005)(82310400005)(4326008)(16526019)(36756003)(70206006)(5660300002)(36860700001)(2906002)(6666004)(44832011)(8676002)(6916009)(8936002)(83380400001)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 22:37:10.8451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a14a29-2177-4016-4b0b-08daf4ed8b5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 coverity-bot <keescook+coverity-bot@chromium.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some dead code was introdcued as part of utilizing the `amdgpu_ucode_*`
helpers. Adjust the control flow to make sure that firmware is released
in the appropriate error flows.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1530548 ("Control flow issues")
Fixes: ec787deb2ddf ("drm/amd: Use `amdgpu_ucode_*` helpers for GFX9")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e80685d1e6c6c..d4b0fa4b62a44 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1345,7 +1345,7 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
 	if (err)
-		return err;
+		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
@@ -1355,13 +1355,14 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 		else
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
 
+		/* ignore failures to load */
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
 		if (!err) {
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
 		} else {
 			err = 0;
-			adev->gfx.mec2_fw = NULL;
+			amdgpu_ucode_release(&adev->gfx.mec2_fw);
 		}
 	} else {
 		adev->gfx.mec2_fw_version = adev->gfx.mec_fw_version;
@@ -1370,10 +1371,10 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 
 	gfx_v9_0_check_if_need_gfxoff(adev);
 	gfx_v9_0_check_fw_write_wait(adev);
-	if (err) {
+
+out:
+	if (err)
 		amdgpu_ucode_release(&adev->gfx.mec_fw);
-		amdgpu_ucode_release(&adev->gfx.mec2_fw);
-	}
 	return err;
 }
 
-- 
2.34.1

