Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7B3C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E501C20773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mvbitthx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E501C20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D30D6E2DC;
	Wed,  2 Sep 2020 08:32:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1297E6E2DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 08:32:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQQ+Xjy0jSOdUmHObPHWLmNTpMN26NNUw82zRUSF5DzxFLPiM14raUWZhGw8VYdlW0oc84nB4e1J377Cjk/Vq9qMCbK0lzz97GFcxe8x2Gj+9t4eFuaI76uQr0Lw9OZHS61C3HRQY2+gb8/T13hpHcAbydE8pzDFbYMg/4sT0jigDlBGqVnJRceh5oOiaRcq56vRqXebU8Ai5v7IkpBxFIaqIrvZ2i4tj3noCrjRIf5gIoO2cwYSFJrr/MWAA43edz+sbOxYyXKXkHKATaui24szvxgKb6vnFer+y7imd3d6wXfG9a0nKqFmvHmpomrjfo130qzsiPCWDmv9JnRo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq+3rf1Nu7oM0T1Wx0Hxo9xCaQMnLIjyxdZa1G6jsTw=;
 b=hKeH3LGaKU9EQ6qD6XVR4a5meAgd/lQvz7URUWasmFwk1hOrK1QUL932mdb/Z0LQHk0EnqKnAaaRhV2DDqmVzgdEIlfDwY2Q2gZaDLYIcl2/AEwGidLHqEYlAam8u1UNlcDauLiFtvknMDmNGI4w7Qis3NDGMd6Sb2s8hLk9G7i037hr1rH3xP7ro4tBrtcf6vJw/uJdwYRnhIYhpdf8/ZhG+x3EtEJRear4Qkml9OHULBOlLl7jEzcet9kgZgWU8A8IBdkG8fvX1QkDxu+mrhuhhC9zo30fq124UGKxqA7BJ0szwMo577TGpLy9oRUeSlT6yBTSEzJPUxWCAwE9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq+3rf1Nu7oM0T1Wx0Hxo9xCaQMnLIjyxdZa1G6jsTw=;
 b=MvbitthxDZOkXmiEYO8H5+ysOMwLHTqEUhqQ9hd8Fmdof4mStADXoybFqDKZ/rxIBK8pRIrL1UFhJe0KSWbKQI8Ca9w8ZfnrviPA9NlYbadLMMKAjHaNOkN6ExCBS+vmhDug223Dpp1KnAgAT70Kv5fy339yTSV3FUIHJgmwmUE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Wed, 2 Sep 2020 08:32:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:32:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/9] drm/amd/pm: correct the requirement for umc cdr workaround
Date: Wed,  2 Sep 2020 16:31:33 +0800
Message-Id: <20200902083134.25569-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902083134.25569-1-evan.quan@amd.com>
References: <20200902083134.25569-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 08:32:14 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51e11ca9-ac35-4671-f517-08d84f1ab274
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38681C3425E1E86BECC2282FE42F0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPSXmBroLcM80XBax4JySbS9iKBwRgtjRaPkuZndmiXXlw1rwdRYW68irNjYz5fcRlf9rHO/1C+dns3d40TKly/4f3DjNSq+SCWnxuoPz3viWkicGOQo/oePge4KfTjz+L5hfUvg7hz/NrUWqntkbOn7fcDanEoX9DG+9VpRfKmXCDYDQ5mTU8qIWEGuNFYUH9/mtKceU6lkfr6d+JEsvqXeqzdqeGt+65IQpYwk3uv/FjAWAwDDbIQ/dFQSLSWLgYn4NjVwUlufv68m3Aru8fmcsohK8pk6o5RCihhUgCmvZiqm2nVpgCANFNuBtCeTWGK/XIseH4Edl8oAy9pLxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(83380400001)(66574015)(66946007)(2906002)(36756003)(16576012)(66556008)(4326008)(44832011)(316002)(186003)(66476007)(5660300002)(6486002)(8676002)(86362001)(6666004)(26005)(2616005)(956004)(6916009)(478600001)(52116002)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: eJ2R0EGWnTk5WckU2itlyb+GsJ2E5wcTrPhYcqH1nbX3FJjsdG8uJCPlOek5rNa/1YUOgdWZj8sIIjd4Tojg37I/xrgtfXNwHrbpjlnw5igMkSC8ZZt2Q2ymlYpFzQlIJa31Il9HOdTHm/CHsNjXaldyweGz2yz20097OlHcx/8t59HWZOr2DOs7OX3YXDFIv+tbBs0CT/ugCNANhR098fbhGQz07m2hLud7bpieQfBBX3YO7t2D1yNURa0yHAejfg3AKejAqy7ebpsbgDnNhjKqXAjXGn1uNeCbjoVCJEwD+4RLzU70FsEHCMox7FspMSAwfRz01yik/i+/RYmqCTV4wSvK1+V3l63QB00e2z0fYm0pmmQ+nU5EJ95fwhK9cWehJfSKMDZSilq4RI+MZJ0xjVEGgWnvB+14DyZV7u77DdPVPA6qEqLM+biM271YkcHPd+K9/gLukBNoII08Wz4+vKKwNektVZlzFkOMSuu2a8tzFO9agZeoSzafIi5Ibrct5HrVTmlvmKp5377rYP594F1E88cSrvztm813jUD7Q/wu4BTEF4kK4aYlyfCrdOHantzmuu6LkBlTz3GDRpEJt5D24+uQF2QVJ2ARZHC6MlUc93CZlNn4Xi0RidCGJbO/Eq5hVCknqh4PhYKYLg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e11ca9-ac35-4671-f517-08d84f1ab274
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 08:32:15.6157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfDo7dWG0MuXnKzrqyTeBWkGXGQ7a8eMoGcuboGAlAVTw6Dt4n+FkbSDISu1DTW/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The workaround can be applied only with UCLK DPM enabled.
And expand the workaround to more Navi10 SKUs and also
Navi14.

Change-Id: I8be4256079f81e292b39bcf43b4a84db82aa069b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index e02d036fb298..801c92eb439f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2185,19 +2185,18 @@ static int navi10_run_btc(struct smu_context *smu)
 	return ret;
 }
 
-static inline bool navi10_need_umc_cdr_12gbps_workaround(struct amdgpu_device *adev)
+static bool navi10_need_umc_cdr_12gbps_workaround(struct smu_context *smu)
 {
-	if (adev->asic_type != CHIP_NAVI10)
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
 		return false;
 
-	if (adev->pdev->device == 0x731f &&
-	    (adev->pdev->revision == 0xc2 ||
-	     adev->pdev->revision == 0xc3 ||
-	     adev->pdev->revision == 0xca ||
-	     adev->pdev->revision == 0xcb))
+	if (adev->asic_type == CHIP_NAVI10 ||
+	    adev->asic_type == CHIP_NAVI14)
 		return true;
-	else
-		return false;
+
+	return false;
 }
 
 static int navi10_umc_hybrid_cdr_workaround(struct smu_context *smu)
@@ -2285,7 +2284,7 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 	uint32_t param;
 	int ret = 0;
 
-	if (!navi10_need_umc_cdr_12gbps_workaround(adev))
+	if (!navi10_need_umc_cdr_12gbps_workaround(smu))
 		return 0;
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
