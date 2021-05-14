Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17294C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECE861029
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECE861029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458ED6EE25;
	Fri, 14 May 2021 07:27:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F0D6EE28
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLQnr436Ic+XMevTBFpxmj5/Q+FGodVsdGqplzvdUEnKZiACUAyl+3s2Ru1I7HJU1vhV8i0kPAsfHP90quX3QMS06eKk5BMX5As5QTVLf9vtaLknxR+lH1xu7lEjwe4yEhm/4wqUjmgz9yPitald64Loav4JB7hlPE1hYqeqZD0k5+x4W7FZeze9H2Vvk08tS/k7Vc5/gu9OC5g/c7V2JpyXxcufAGO/f/LH3iNkUHmrjbD0Gbsd9Wn0zTCApY0JlEDhxcOX7qmHfWVA3/FuRBQVsMwi5lkHLI7cw2BG/h8tI21kFVtoUDuQad22f67KTBoZ9LDAdaeR2FP+f7grdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXqgSWNLTHd1lj8ji4rCYDySSC1b2OrwYNOuolfB3eg=;
 b=WhjCzGAmR1Tsq0kStquG+xyh3REdktXps5UOx0BFLu4VWyvGMjzk4lk3XNYJtclvrAsKlpEIfSKSRQoa+1zQADEFZ7pcYJ32DuizdZU+U33qIy8QctuQBO/LgK/jWQEyi+vljrDvshZaPuiUvJ4X93uSONXqWUWbi9L5H1qc/vBMdZlWGcQgXkkxJpDOyQ+W3gNCInFpYF2fu1Azk3e504wwWhZFztXxyk6sgSyLnda+cWRcGdIlmRLoeCBkOYJi3iBXlP7IzF2Nab86oD039T0ObjR/fJsW/rgLEi4Aof8NfHVVLYXoowXEj4/amHyj+gJJ1oJkYg9athhl+CB/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXqgSWNLTHd1lj8ji4rCYDySSC1b2OrwYNOuolfB3eg=;
 b=01ggbtMGsMrS/r0fw8s4Rv/p72/eBf7AomNnG5pNKfMoWFYQLRyxcw+1eWRDQG2C+xIzNjmE87KRn8zSkuZICtzc5zWaT7NWLS0ZlJUBrIBtCHoJCUVA0K8objzgYPQVNjnDX1XuY0JKohaKfJR//YM+DdLC4hVsUYPPNVZtBQg=
Received: from MW4PR04CA0340.namprd04.prod.outlook.com (2603:10b6:303:8a::15)
 by BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 14 May
 2021 07:27:32 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::a7) by MW4PR04CA0340.outlook.office365.com
 (2603:10b6:303:8a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:30 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:30 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 15/16] drm/amdgpu: Refine the error report when flush tlb.
Date: Fri, 14 May 2021 15:27:05 +0800
Message-ID: <20210514072706.4264-15-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7597968-613c-42e3-629f-08d916a9bcbb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:
X-Microsoft-Antispam-PRVS: <BYAPR12MB304819ED6C2E9FFA605134F5F8509@BYAPR12MB3048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSTPAoAm6k8tiK7FZzULJWE/YpVeKFlTjr2TCes8OX4qSq2oKhRyiQJUaMWQKMcTQMop9It+5cnO7sWoUBQsj4MzgtEsUYKlStRl1UjB0G1BR40wkVqY2hneTDKQMYPCksCuwh3fb4hRcaNUxh2G/SOAcHxYW/Xb+HwpEUR991y69QO0XJmYUKOHlSVvxkGvwOS8nmXMiN1eGuTWPVsrEMDx3h+LmS+l6EWeVMzhE6Mdes4Fm4XL7K947xGJA6g6vO2JU1NRCrGD0JEFWeeFhHEDQQEpiii8JaVgZi4IJvvTtyN4E+sPxuKHiM1Zn1FV4Sb4DsP3D1k+gWOHgMN0MwPnXmTAW8aFMBekltWYyoeHpL6x3WWecPkKTHtZK9gbaiQxPHgMlra6AR+Fp/8lR1hQZjpeOkkFF6wlNjQjr8488FHsKfJA0z2GT9H4JoKuAuq483BMi4pbGfzD6qhCvVGV9j3lvSSNnxJ2EOLorsiTLsH3tQJMDv4h6+yR/okuYWRSnVWM1X7QzSBECkTJsTljuoPfvUaVS3+krdgxMK7fCAJL7iYj3mfVp4ELwwcs7w5uzh0K+Bcd5AuHQpq4BmmmxqjfYwAuyXta2k5pPv8sXm+BlVzDW9vR5yKGqGhzYRh2WhDAzJKDd/L7uT5HspoprMRYmINPGBpCKGGWSZ8kK8uGNX8ipJ7JGZvqhy9x
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(186003)(83380400001)(82310400003)(336012)(26005)(6916009)(8936002)(478600001)(356005)(5660300002)(47076005)(316002)(70586007)(7696005)(1076003)(4326008)(81166007)(8676002)(6666004)(2616005)(36860700001)(86362001)(426003)(36756003)(2906002)(4744005)(70206006)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:31.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7597968-613c-42e3-629f-08d916a9bcbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3048
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

there are 2 hubs to flush in the gmc, to make it easier
to debug when hub flush failed, refine the logs.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index c25541112663..52eba885289d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -297,7 +297,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (i < adev->usec_timeout)
 		return;
 
-	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
+	DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
