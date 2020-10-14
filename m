Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0578FC433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 23:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2AA214D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 23:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fdz7LwhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2AA214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88DD6E955;
	Wed, 14 Oct 2020 23:59:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88BC6E955
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 23:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+WoMHKMhP6nAKJz3XWPySY0r368dCUfvnyPRucrFO5uBMChScT7lSHIUPThyT+8oN3CGBsFeSUtpXC3ZEMSrNaLeN46K6IlUM7m9XyzNp33SOwOwOdP8GG3xuEb2CxpdY8Fs34wlkJZIO9ZHodE9KGsDynFGV+N9wP2yeDg4U/rFgsKZwbYZ2AIz36odF0vpezW4LECzWzQudXKmtmYsYvyRxsYGF6zJ/CFxVWdDMQ9Jzl0kX3eD4FN/yMIkfcvtd6FuICRgLay1462sdqqWvENpDTceQtRW8o/5re8w6+tGopm0sdsJ+GH9EkAeCyDd2ayzJn1XDELBTMsYOnd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abt6OsTL+YyzFSUb4xk+GXFvVUHkEtabpfdb2y9Ye8c=;
 b=SbYvFjPc2XzE9hPmLMaVr/s53Ru7xnnBaszAhrmOQYPrMn5w4maUdNAhZ3VFNWGaok9SJDU9ODrFAsqTz+e9Sg3Uv+LebDkCMks6Pn1/A5P4CLjGeS8v6cYQzDgtq8Z5+y23Ps5YnFzjKrvDKdLP5YTPOUPazQvZdk1uurae3fiFFiYkctRglBXPp0NyOtsDLdV9YMYWIOxHEIgmftQgldKaB2UIGUY3l2iF6/tSPOjrkvpk2S8bClO1tUK/SVqoF8LlIxawJMgNVqDLXo8Ux62TuO3S8ZTaxD77D9MGknNgBr3C03ZQ4ocPuITMKXfA3SNVF9JyT1HGt0dPlqvLIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abt6OsTL+YyzFSUb4xk+GXFvVUHkEtabpfdb2y9Ye8c=;
 b=fdz7LwhA/65BeGFAT/mN0IlC2vs9+5hox6eIDz7HEmEPr2jzJS/WOs9KTuT57Mm3YOoNpXRyAQGZG1qXruyYL3DeKjbe99CU/lwhcTWvWhp2L3YPBL/iOM0hMqn4rEuPJqh/SyYOWJd+7zehKg8j9dTWyM2giL3iFTaRfiGthPE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 14 Oct
 2020 23:59:04 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3477.021; Wed, 14 Oct
 2020 23:59:03 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: disable gpa mode for direct loading
Date: Thu, 15 Oct 2020 07:58:23 +0800
Message-Id: <20201014235823.58784-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HK2PR0302CA0019.apcprd03.prod.outlook.com (2603:1096:202::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.7 via Frontend Transport; Wed, 14 Oct 2020 23:59:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c5a4462-c8f5-40a7-59ec-08d8709d20ca
X-MS-TrafficTypeDiagnostic: MW3PR12MB4380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4380413D864053CB4DFB4D48EC050@MW3PR12MB4380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugCYKutOnAuZ/fZkg7r+d9MiNK+um3ifR0gPfzIWkwX8LfQBMPA1UYN5Q2ib2WhQvuFzxWi2d/AgPnxXgQly/Dqd658Iqq2Ggy1EwzqUhW2vi2R2aliD9VAbwYsatoTOuZjNXdHc3+qNucdCXtyMESTXPVyMcfCX3uoQXIQ5O3JnVUyMNXx/WcEk0bPcEclkPaLNpAxFQFD/oVkeqBjgwfy9BqxPq/E7dmz9PVahY5HifjIO4yA1k0dOOsg+DV0LjlKIRL8rfaWNUrEVzNw9hkG+JjkbOT7apfe7dxfPK6iOXtjzDRM0ZLqg6HOcWJWjeeHlsBFtTwx8ntBsbGfCIreYVo8RF79FNAfn1k5JcH+kTrRuWAG+EBYPXNPR0PhM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(8936002)(8676002)(86362001)(956004)(6486002)(2616005)(186003)(16526019)(1076003)(5660300002)(316002)(54906003)(36756003)(2906002)(6666004)(478600001)(66946007)(4326008)(66476007)(66556008)(26005)(6916009)(52116002)(7696005)(34490700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yydpWfEpn8y1ZrnVKU3YtFvWBbui4tGWgtg1oYCk94OO0BQ6xXR2o06Q1kuo77FZTM1Bh4Mq1nZ2/Q0fa06KAm1q3xX5j5N3ym1jJLHskVU4Djs/smcKi2jVvxHfCD4FxTcjiTFXEedUUgQ5UWkYOt9XQ/UstLUWtx+JVhawuJyzG/j++mA0OFj+SzU7s2el8yfBiievQYUGDdUR7cvqDd4S5EDjj6QQqsPiMHx1V/+QKyAqsO576TYDC0O3r/n877l0aE1GDhVLq/DqPa+KS7oOgcUUNw9gIMzQErGM2mN0ltr2aWVxmguiusMXnTVGIGSSKzGraIAt2aN6d34MLZ4LwKHuIBtl5PIWBAecMOLDLRdVksFdm7cTfOlnqVyLv8ywqmk/VYW8ffePfFXUNl4TVQv89OIvSYZBWeN+Eb322DowQAlovTxd/3k/Mwq15DqrfUz+6RaC/oriK8OKDnVxVR7qvCuJUgqOLIbU6vbibnwdnG99vmtaiPP49T09EldhS5WW8BFWZrKnojA5bUQ49OqRuyqUID0hAQer35eH6MVHwpjZbrSgKn1eHBojU4QJDYGK0kJnalgMJP6hpecSMjHEvQprDTJYVb/u9fQb2MFVRFIL/45j1woQlNwUjh2B7EtXHp4ALI9jw3yW4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5a4462-c8f5-40a7-59ec-08d8709d20ca
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 23:59:03.8152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5a9DMWYWHlqdiDb6aK9cegYHgKSgMqjGcKbtOTbd9YTuwAopqUJZeyuKvy88BwToLLFPsEOAUJ3+DO6fV8Zoug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch fixes the gfx hang while use firmware direct loading mode.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 042ad5e4292b..8fc69c208adb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -129,6 +129,13 @@
 #define mmCP_HYP_ME_UCODE_DATA			0x5817
 #define mmCP_HYP_ME_UCODE_DATA_BASE_IDX		1
 
+#define mmCPG_PSP_DEBUG				0x5c10
+#define mmCPG_PSP_DEBUG_BASE_IDX		1
+#define mmCPC_PSP_DEBUG				0x5c11
+#define mmCPC_PSP_DEBUG_BASE_IDX		1
+#define CPC_PSP_DEBUG__GPA_OVERRIDE_MASK	0x00000008L
+#define CPG_PSP_DEBUG__GPA_OVERRIDE_MASK	0x00000008L
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -7035,6 +7042,18 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
 }
 
+static void gfx_v10_0_disable_gpa_mode(struct amdgpu_device *adev)
+{
+	uint32_t data;
+	data = RREG32_SOC15(GC, 0, mmCPC_PSP_DEBUG);
+	data |= CPC_PSP_DEBUG__GPA_OVERRIDE_MASK;
+	WREG32_SOC15(GC, 0, mmCPC_PSP_DEBUG, data);
+
+	data = RREG32_SOC15(GC, 0, mmCPG_PSP_DEBUG);
+	data |= CPG_PSP_DEBUG__GPA_OVERRIDE_MASK;
+	WREG32_SOC15(GC, 0, mmCPG_PSP_DEBUG, data);
+}
+
 static int gfx_v10_0_hw_init(void *handle)
 {
 	int r;
@@ -7060,6 +7079,7 @@ static int gfx_v10_0_hw_init(void *handle)
 				return r;
 			}
 		}
+		gfx_v10_0_disable_gpa_mode(adev);
 	}
 
 	/* if GRBM CAM not remapped, set up the remapping */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
