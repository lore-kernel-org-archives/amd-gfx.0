Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63634C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15238206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xdXe9SNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15238206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B351C6E9BB;
	Fri, 16 Oct 2020 03:27:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C166E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNJHkA3eKnfbidZuLZbUwGt0Qi2YqufsKBAiv13WPl6LyMGGRRdzdkjlKSPhtjZTBCu/z3YGYRlvdDXhrmJxVH7pYkC0O73DTRbo0Irn+yQjtNqZ2rRTCGGxyQSjGzeinJQQaULyypa3yNqkFog0taKVzfm/YdVT7HMgtUu7h1m2NYGA/zKfyPz+zb5xvljK43pErPsXUpAs5ARRpKQcCDwL9VyE8NWJqzT0IQIak8kWmTBQOdow6wGjpmJqTSOYi8K5H4HerncCcyN5ZKGopLMpoJU0336yxTwAb4jPRNnA/JOgIGyk6Rqu70aiMh03An7WsG3PZtJVhZLZR8EyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjkCNVPPGTWqDnUyAVU6zFFD1HdUPmAUqCDmI6IMgJE=;
 b=WZSfhCh9OvTitmfARQd61ZibGkbjC4Lx5r6wAJbzcRt3ER0e4pwRun2hn4v6rLH5Ph3Yn5HNfWO0Jsy7hamoAbw2LASQkvvLTYSv7FG6mHMexX9lMFDJLFasvRxTnDJFwIOh7QVKAA6BsIehU52CAJBfscdee5y4VQCrnGwBi9LuU0AOk/b78LJOt+h2f6wHc0YqwU7M3A6s475l7K8XrxNHytGvKjbbKH8kTmgxWWGZrva3hcMzxi25tzLRpX5VCvg8Ou5wDNA1sjPva5nKqqt7mSnJ302j+4UUUbwilOYY4HzFSN1dT1CRhUcbxFWWDLw+LxLmNale+GzF49bKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjkCNVPPGTWqDnUyAVU6zFFD1HdUPmAUqCDmI6IMgJE=;
 b=xdXe9SNxQkPGodH/VqAI+VnYs/CwYswci8LcRZ3uWdorfGsU3oDwgDbJM1oyTW/LvzM2GfinW6alYeVKHOYqBZ6kb7j/dZzkA+QBA14vLvF3vn+j52DoSWjjb18hzbp5PpZXtuC5u+xOPS5dU5LZb3pM3f797CEvFHUhHPT8Xus=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:52 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:51 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/40] drm/amdgpu: correct CG_ACLK_CNTL setting
Date: Fri, 16 Oct 2020 11:26:23 +0800
Message-Id: <20201016032652.507-12-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4591e54-7758-4f69-92c4-08d87183769d
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4680E173DE601C160057181EE4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sda/eN2HaMqpaAEWVykp7xuiavmuraAsVWHId7azpkaK2vGruG61tDfW4acFO50D0quW2GZCGzOIBvwJuDvMPDWiZadxnj0mZgPH/VLmNxQobtv45gB7EQnHVq4h1TSN/V4x1fwWGd6+jIMYEe6XZQJqiWovzyzkF3yWwrMpdIBmO9RN21GujqITp4CBSxgw4bn1Bf1MQy+vg3xXIGKvZx6FY6DdDaTN8KPl74UioPS8mVP6IQ5/z5TU6AIf7ycTcErgC3j6fmIHZloD2LHcPnfAnu53D3rT/nIIKdno7bFRpZed70x9us0pqJavLVBWMRIhhUN6kqKNGmnpSfQexY5PHr213ZHM9c8M2kONW9cpUPgAcrJhp/wuO7HWESPy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ja8xVsR6oUmHyaWt+RqzLOVZpAjrXHorgIbaEqwBM8If9ADAxoewGzeR20/KEI6X1NYmJ1FZ4xvkbUWDNGJMD8Y9FydGwq78gDP6ItBqens6LS/dQdjRbrAKeHfA8KXiZUrlr7r4aVokOXpExJGHf7bsTKAtnDqjZgdBdoUHsyKk64mCbQ6BDngmK5O5m3gjM7HVU1zjBhAbrRRpYUvJ3DcW+KOfrbJgcrAFsJklSWTmSh/p1iWPUeu+UMQOgad3lWizGFsvMsyRPORJ4IL9rSLu/7TB8QlNJeM3nn9lCBrxU7w6O7Y6KOX/JLa3KSFB4uP46JajSBdyT/s9ft5t0ZnZa/smz4x4Z/kKJpCwpKKzvU9k+SWerkv/nHfGTKgk27OFbqdttGgUXY/mzzTY2PuY2jYoAKpKe1d4BYKp2V8DNFHeBe1msJ4zswFlhxg0AA4R2EjeFqz1m71joS7NStUvSvKqhIJrtp72UfKUKIliUKoJm1PoVnWUmYKpoUEcrYY2Fn6T/Ipw9jL7h4JFdHOLkq1Ak3/J7eDgR9xAYIBgW78gmzCeCQPM880H3oUesqVjPwSPJP/i5bkOjXQc5nzy4gOivT5vRNb9uyGkzrrEj626B2BIbZujs/d9RL9y5xL1NWtXd9LotPHhuLTb4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4591e54-7758-4f69-92c4-08d87183769d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:51.8987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfT+lU3waxqsGkN9dlyNE9+KGF+Dxr1jBWVyOJIgw41WxhkgYBBpRslR31iRNUuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct polaris CG_ACLK_CNTL setting.

Change-Id: I7d384ce65d598ae33325c09c571bdc7865c36fdc
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index d5843e8a6e17..8a06c897f27e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -729,8 +729,13 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev);
 static void gfx_v8_0_ring_emit_ce_meta(struct amdgpu_ring *ring);
 static void gfx_v8_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 
+#define CG_ACLK_CNTL__ACLK_DIVIDER_MASK                    0x0000007fL
+#define CG_ACLK_CNTL__ACLK_DIVIDER__SHIFT                  0x00000000L
+
 static void gfx_v8_0_init_golden_registers(struct amdgpu_device *adev)
 {
+	uint32_t data;
+
 	switch (adev->asic_type) {
 	case CHIP_TOPAZ:
 		amdgpu_device_program_register_sequence(adev,
@@ -790,11 +795,14 @@ static void gfx_v8_0_init_golden_registers(struct amdgpu_device *adev)
 		amdgpu_device_program_register_sequence(adev,
 							polaris10_golden_common_all,
 							ARRAY_SIZE(polaris10_golden_common_all));
-		WREG32_SMC(ixCG_ACLK_CNTL, 0x0000001C);
-		if (adev->pdev->revision == 0xc7 &&
+		data = RREG32_SMC(ixCG_ACLK_CNTL);
+		data &= ~CG_ACLK_CNTL__ACLK_DIVIDER_MASK;
+		data |= 0x18 << CG_ACLK_CNTL__ACLK_DIVIDER__SHIFT;
+		WREG32_SMC(ixCG_ACLK_CNTL, data);
+		if ((adev->pdev->device == 0x67DF) && (adev->pdev->revision == 0xc7) &&
 		    ((adev->pdev->subsystem_device == 0xb37 && adev->pdev->subsystem_vendor == 0x1002) ||
 		     (adev->pdev->subsystem_device == 0x4a8 && adev->pdev->subsystem_vendor == 0x1043) ||
-		     (adev->pdev->subsystem_device == 0x9480 && adev->pdev->subsystem_vendor == 0x1682))) {
+		     (adev->pdev->subsystem_device == 0x9480 && adev->pdev->subsystem_vendor == 0x1680))) {
 			amdgpu_atombios_i2c_channel_trans(adev, 0x10, 0x96, 0x1E, 0xDD);
 			amdgpu_atombios_i2c_channel_trans(adev, 0x10, 0x96, 0x1F, 0xD0);
 		}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
