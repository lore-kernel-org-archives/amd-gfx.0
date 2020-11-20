Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11716C5519F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 07:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D733222BA
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 07:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dQE0JsOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D733222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC184899EA;
	Fri, 20 Nov 2020 07:59:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059BE6E878
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 07:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2hCzwL5OiZl8L1udW2jbyBfbErXRD/ONkKd4YhY3OXr7y9GlX1oBTGX6ogojjdiY6VNBqddzoGbGqA+VrKXYIq5a2ANEf+Yvz2dyaGQY0aaysNKXuyuV64xK5i93T5v67hWn9yr7yX5sQx8//gKjry1Oq0GqGa0QbpkKR4oGipcLWXUzoNgLud4nS2EhCtH+N06E2p3ifULp4nZra46Ls5Rcj2/O0gCu2bMZjlq55pcXN+sCtpcJjGJlIyBVlDpqLPqgcwc5j3NzkzFkzbjE2Hmqf6ODUyUwoKF3bqk6kVrUzXj7uDStCgHm59wq6FJsvadCEfXynbobnMrQSntow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJlnCmq5ZkWZqAKTuoqdRLH4FsOC03Hs/XmsRWK2HnQ=;
 b=I6jgXbtR/RsidXHU6GWIByOsp/uu356mAAeTXS64qQPl5cE3bD6mnil3wqPrtj/kuKjjJSWJD2s4HUAUPh1XLh42cik8i8910uB+Uvj1GL893dfLtbHpErVMDDd5Xh2NFIJtd1/MURtEqYSKlVhYy3QPZlZb4YCsyQgCaJabS4ZuHO/xBOYf5SEm2XdzXvOzOe1/ljCAM2vNtR+ZyfhRnLQj/UEkWR+NcGo0MBlJCxrxtcf6EfUZLLGeK/9TEdUWn2PII0D/93YM4tLo17wAB4MXB+qAZQ8qrSvbob42ZvL+6tqbubZoPXDUmOXGzsnKMQ1N486xHF0+Sr/KuwqB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJlnCmq5ZkWZqAKTuoqdRLH4FsOC03Hs/XmsRWK2HnQ=;
 b=dQE0JsOx22xWP5Bfmy4qlO++Pqq5lccpINkB00kcEIqfogJIl4q016IdaS5YMK8IBLm9OPETtu/FA5Yyw8EsaTcN6vWe1ugTJvP1H1Kxiw+daHIPDab7pZ8VU0Qws79v2VbPeMyhVLxKguMgZDdPyFQx1qkHlf6ewYdA4ba/x2g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1374.namprd12.prod.outlook.com (2603:10b6:300:12::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 07:59:52 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3589.022; Fri, 20 Nov
 2020 07:59:52 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add module parameter choose runtime method
Date: Fri, 20 Nov 2020 15:59:28 +0800
Message-Id: <20201120075928.104191-2-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120075928.104191-1-likun.gao@amd.com>
References: <20201120075928.104191-1-likun.gao@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 07:59:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d122921-b508-431f-e306-08d88d2a42d6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13742A53F68F660E1EDFC037EFFF0@MWHPR12MB1374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRmzv/1c3ydsomZOUGZmXU9A6En2ffINKsE/+8pqtZuS5nGrF81rek//WlyUXg9PxPoU6Wnn4RBBaAvp59CP10FWR551uv2sU5JE8EPHjhMXXJlCjx07Jgzw9bAmmsX2RGSeLuDnYEzkWOySGR9G5Zh0Cb6RVneuttmc8Be5uBil1I7ozvXA5d+heF2FHWJyLRIVjzpwYPL+kLf/g18M6BWxS5JPa3EDUVY/nb8m5lVcm53pMqwevy1/tPmMW16z+fZstMiRNopJjZtioLrcKItfo8AYkxpIN7XwHcAyozS1ApH4sORYJv1h6129aINyUh9zNTHZLjnBDoqp0YyQjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(6666004)(36756003)(1076003)(6486002)(4326008)(956004)(66946007)(2616005)(478600001)(26005)(8936002)(54906003)(316002)(2906002)(86362001)(16526019)(52116002)(8676002)(7696005)(6916009)(83380400001)(186003)(66476007)(66556008)(5660300002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KzBbnechCNiw4LAKChSQfv2mgoXv9hcBb0VvUaYWLXCNVx6A9ntS7vo11lwG7j76Rhx1ov9p4nTucbfVaJ8nFWdytyrlbRguRNPlu0Qoviqn1HJcFQeazFnffTqxbUDDXfzBALzbITGL0JZXBOBuHobrhyU6kp3y91JpNyv3X4pqyEUp4d9SZCMy43LLx/u0V9iJmNYvHeh1mDvtpf7Cds4N4EBOpMTZQ76pExwzzl8CCnnVeTQZHwhE0XjZ5HeZAIFuVXYH3tyBzxIGoF32AOHFMD1O0rd5aHFViy+SpL/LUB+6Cb2/HgFmiSjD/IkcERIONkLIVhq51kbIcjFjEPnXA/2F7vqmzvwFzwDOU3kUHqmEat+E/Jioo5ZFkTsDTQK0BV2XgA3RV97F2DkYyWMCEGqzwIfNJAjX1AOMS5AZ3iMd1Wj77RQ3JFGloJK1vLdYXSDpR4zSG7Ki3hvgBL+yj919vnKIMmVCmGjyx8CxMuK1l9IhkjPlFTmYSrGHRTJFIvBkufmMS+06BQ4qmCKWoOakjlGKVFIieOmcCsYKWcRd2OZ5NGzp+y8xvi3Sln5ezgi29ORExxSsRl0XKpZ4a0sgqkzAH8SZcZ4vrCAfUcf36M2LMaLO+MgjVj+s/mEgxSic99IIAn35RFWWhhgA0vbGNSvRCfk7HpEmNKhDulgp33cXc+DUVwe5hJdGG17t1sAV7xXAnkYrz6AFpNqmIaRLxyN75wnRVHPqGmPRA+Z10bX1h27C9ZAcVkGdxx+xytlEzR6OupIANuv1pYNLiFhjT4TRS4CDSzZLtjG8+DF25TQtjbxNBuGZcxStz4tFqr+LUzf4BbsLb9J4P/EgzU46+v/sAaEMWVg5bBh+XedNz2bUTpBi+qU4h94oQ4n4xWJfPAqEDlSz7uow3A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d122921-b508-431f-e306-08d88d2a42d6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 07:59:52.5605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wp858qnmm8C07jmKI9Lrwt1nj/ZNTNt7kgvDhlhCmQLPJRngBTFeHEKJxBMpNd0u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1374
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Default runtime logic not changed.
Provide an alternative runtime method. (set 1 to use BACO; 2 to use BAMACO)
When set reset_method to 4, it will use BACO or BAMACO for gpu reset,
according to runtime value.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 38 +++++++++++++++----
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7f98cf1bef07..b2a1dd7581bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -304,7 +304,7 @@ module_param_named(aspm, amdgpu_aspm, int, 0444);
  * Override for runtime power management control for dGPUs in PX/HG laptops. The amdgpu driver can dynamically power down
  * the dGPU on PX/HG laptops when it is idle. The default is -1 (auto enable). Setting the value to 0 disables this functionality.
  */
-MODULE_PARM_DESC(runpm, "PX runtime pm (1 = force enable, 0 = disable, -1 = PX only default)");
+MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with BAMACO, 1 = force enable with BACO, 0 = disable, -1 = PX only default)");
 module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
 
 /**
@@ -790,7 +790,7 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
  * DOC: reset_method (int)
  * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
  */
-MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)");
+MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
 module_param_named(reset_method, amdgpu_reset_method, int, 0444);
 
 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 7144ea4c0b78..62c34a01a3e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1485,6 +1485,9 @@ enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
 	return baco_state;
 }
 
+#define D3HOT_BACO_SEQUENCE 0
+#define D3HOT_BAMACO_SEQUENCE 2
+
 int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
@@ -1499,15 +1502,34 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 	mutex_lock(&smu_baco->mutex);
 
 	if (state == SMU_BACO_STATE_ENTER) {
-		if (!ras || !ras->supported) {
-			data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
-			data |= 0x80000000;
-			WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
-
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
-		} else {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+		switch (adev->asic_type) {
+		case CHIP_SIENNA_CICHLID:
+		case CHIP_NAVY_FLOUNDER:
+		case CHIP_DIMGREY_CAVEFISH:
+			if (amdgpu_runtime_pm == 2)
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_EnterBaco,
+								      D3HOT_BAMACO_SEQUENCE,
+								      NULL);
+			else
+				ret = smu_cmn_send_smc_msg_with_param(smu,
+								      SMU_MSG_EnterBaco,
+								      D3HOT_BACO_SEQUENCE,
+								      NULL);
+			break;
+		default:
+			if (!ras || !ras->supported) {
+				data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
+				data |= 0x80000000;
+				WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL, data);
+
+				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 0, NULL);
+			} else {
+				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, 1, NULL);
+			}
+			break;
 		}
+
 	} else {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
 		if (ret)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
