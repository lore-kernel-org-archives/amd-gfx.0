Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBE4C5519F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 13:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAA621734
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 13:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gRMxmWpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAA621734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A21D6E20B;
	Tue, 17 Nov 2020 13:31:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B2F06E20B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 13:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRN6zbw7HDV1VI+9ByjfEAgEW4mhvTinPN+1amVHcXvVk+0vCgRnKxbTYMZ/qUzDZV0/tXVaSc95TTUCXOUfcEUyAAxx1c/v3xgPM/+2ETGzPnfp3lrtPiQZSscOXgE5bUiDfIk0TPt6mfjRdy+NrcThBzoKFm9Ahk5DWQLQcJYr54pzjF+GyKozaaVQfhcS8kc1tvP5Nlb/q1BNhTbT5R1UqiINUVc93rjrn9x82Rn1tPGE4XdkNroRwApB7eusCe0OtmBtZclMsI1ZEvtA62QIh1qSz8fgsamR2eqrtdG6aY7qJE+cID9qDXeobukw51uijq4pJSF8KyPZW10APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmBUhkGP8YQEE5aSEga2IlRNDP7hA1xj6AOHkVUPUYs=;
 b=CfxgJmEolYdbY81c4713pykDJhWthiUzZekVAK642EH8AR4qzXtoX+1S/5CatZiMo6Zae6hEQhw602E6hDubl0VK7BJkXU/f2gZz+/d6OvAOXeZoBrPkA5tK0lTZfDBT3S0C6Af+rfl52kMXINn9pqUdSxvAFbLN1c9wqcamVI1wiLUVPT3xltPseq73cKHHL6oUUFgrtc8b8OOJEakFENLOwIY/qBv8yC5ovAVTFfzFn6JjmdgdsZ78j3Y/aop9BmM7In44ECH22/GmZFsECYZtYATDX6cXZOKqfk3BPYecFS2fuR6yUbu+G09ps9BvoMg0fA3ufIo/Vn0gsWOMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmBUhkGP8YQEE5aSEga2IlRNDP7hA1xj6AOHkVUPUYs=;
 b=gRMxmWpxLSGiRE4Dc2z8N590oCIFXbt670MX2IIYOuN+xT6q1Oubpqa/EaMI+XjlyNWYOsY2MK/n66rzt82M87niPY8bt+mw44I3I2TF0A3WmBIGogm17/kx5vlVTMe4w9oVKwzO61nOFtu5kazaLd8Q8DxReBfGxPzfB1ik+Jg=
Received: from MWHPR18CA0067.namprd18.prod.outlook.com (2603:10b6:300:39::29)
 by MWHPR12MB1390.namprd12.prod.outlook.com (2603:10b6:300:12::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 17 Nov
 2020 13:31:13 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::76) by MWHPR18CA0067.outlook.office365.com
 (2603:10b6:300:39::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend
 Transport; Tue, 17 Nov 2020 13:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.28 via Frontend Transport; Tue, 17 Nov 2020 13:31:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 17 Nov
 2020 07:31:12 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 17 Nov
 2020 07:31:11 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 17 Nov 2020 07:31:11 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: fix the crash after runtime pm resume
Date: Tue, 17 Nov 2020 21:30:51 +0800
Message-ID: <20201117133051.1016-3-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117133051.1016-1-kenneth.feng@amd.com>
References: <20201117133051.1016-1-kenneth.feng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f222aac0-47e0-4691-3338-08d88afd0d8e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1390:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1390DE9B2CBEFBB1FD154DA18EE20@MWHPR12MB1390.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14UuNjtJidu2LS+iJUSv0RqhTbwUv855wNnvKXqkG2tsCqwMot6qmnQJpH0qnPERqMj7n074RTUual29qOtLH2FhDyCWGkIzYHJl0G6Lp68dynDS0e6rqId9Ucusds8D0HMih/bOg6JkF99Y6aBbq5UmkvhhcW7PBuCI++v8ZbwmDdLkowY2Os5icb5Pjp6lCXddvN1PhLE4kBPZ8Z0JflQHB8Xaa45ehS1bL+gSSA4/u1iTBfPH6XsZ69zJk9i3ZvLsBV3fn9H+1CqnAzl58l6MU/xPfcHTaIBMifgPBSG1dlVGduXqKn9R+FrHZlUYi2a5FRo5YXyLFnFMyzRSitMIX4MqnygMH4O+etNgvwPuySpCJNNjnef6D3Qu2RH1hgt5stiyY9LDfwtXPUvatw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966005)(36756003)(336012)(426003)(356005)(8676002)(82310400003)(26005)(186003)(2616005)(8936002)(7696005)(47076004)(82740400003)(81166007)(70206006)(70586007)(1076003)(6666004)(4326008)(44832011)(6916009)(316002)(5660300002)(2906002)(86362001)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 13:31:13.0098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f222aac0-47e0-4691-3338-08d88afd0d8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1390
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

Some features are still disabled after runtime pm resume. This can take the hardware back.
Unlike other projects, this doesn't need pptable retransfer.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 39990790ed67..ebd50f144c5d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -914,11 +914,14 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t pcie_gen = 0, pcie_width = 0;
-	int ret;
+	int ret = 0;
 
 	if (adev->in_suspend && smu_is_dpm_running(smu)) {
 		dev_info(adev->dev, "dpm has been enabled\n");
-		return 0;
+		/* this is needed specifically */
+		if (adev->asic_type == CHIP_SIENNA_CICHLID)
+			ret = smu_system_features_control(smu, true);
+		return ret;
 	}
 
 	ret = smu_init_display_count(smu, 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
