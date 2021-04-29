Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98480C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07462613FF
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07462613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F336EC8C;
	Thu, 29 Apr 2021 06:27:06 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3596EC8C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5Ft1/46CwSGzAjoYTrql8WB7//YNxIilbx4Z6gVS+dc2t5ynEPZkGdPHH6CE6hd8YF4HnRGVfEJBqDlEN8eL1PSSECBEsnzWWxsd4yVOHJaF2av3gYH5X4bIPeTLkqcl+rRnhHirNeR6O3T1hBaX9xtEegPmyKrM9AMZ/7+HGgS3WuzpV10JvrAxqq5gFzY3ffD0mnJvRu+WoYZJzCmT3C0IxOuWieWvMzIu8xPVuz+VSj14N9qzHXbGgewgTqc5K4n2Fx6UExIEB7W0ufEMMJ/tRP2qxrYUVBO4xJQAfailwPAi8DKv/Z/6ALFlqJ8UyMx8mpEo7ZAn2aHTa59pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S6oph6WQKW51Zt5qWhKfRKz4hy7BuxzlJTjAo2w0NY=;
 b=cyQDli/zp6McWTTiYYFvdZ5oPLLRRdKSYzuxDlwdpdZAE9GGa6TGcRpqVZWSXMEjL9gMkAqKIBRNPUonSkRc+vwtcAL6Oe36NbFUWwf0+JuPA/wQGwCeRCHaZGaNstzgss/dRCGHZegHs0XACUlJRnRg1B/3iVgEoJS8lULG2Dc9ruBvZGiffTF5R91qXO2JcM6cQjjaGQ1XSq/X+k4zRT+9z9RcgpvQcWDRFE6tJKNWpaGiDBSPim7NqGkF/MlJIG22rItCGAqSUAMDB8sqQ6yyjlfDfpOOUob4g6kBrdM3itVqCGP8Y8Db7T2WqTeES83pxZs6MHsNboXyPOq2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S6oph6WQKW51Zt5qWhKfRKz4hy7BuxzlJTjAo2w0NY=;
 b=VcastUlVPhXu3ZzA4roY3Tu+lwq5aMtrBg0l/ykEisz9juLoshK4SuopxTT+o91BLQEA+UsgftTvsBD9p1Lm2ie5C2m1t/4l3yMaY1hOKuNtvCodfEBHXbua3yY7XKgBzy1EI2zVRmWhZjCE5tPKhHSgI6U2SwUS0WH2CBouCc4=
Received: from BN8PR04CA0017.namprd04.prod.outlook.com (2603:10b6:408:70::30)
 by BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 29 Apr
 2021 06:27:03 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::23) by BN8PR04CA0017.outlook.office365.com
 (2603:10b6:408:70::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend
 Transport; Thu, 29 Apr 2021 06:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 06:27:03 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:27:03 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 01:27:01 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 John Clements <John.Clements@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: switch to mmhub ras callback for ras fini
Date: Thu, 29 Apr 2021 14:26:59 +0800
Message-ID: <1619677619-2735-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2413577c-9d25-4afe-6452-08d90ad7cdc2
X-MS-TrafficTypeDiagnostic: BY5PR12MB5015:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5015176174A8345E4F0C16FFFC5F9@BY5PR12MB5015.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKl2N6BdVldrzXlpeWgxj8zbeQ0fZtiPqDm0LTumz38A75XML3dzBskaHxni1gllYHb9qH95kkvJbmY5Tpz6+NwnmC0MTx26Vadb6m/x0yBO8N4u9JSOBnui+3ki8n2cDx7zCi5RJxnAwp2kUvzSFFm7tpSE+Lrr7IiZ8RonhryGEG6oZ5mZzhUWL8/CrJErTQw0qCpGZ/Qcx4eq8ocg8WcQB6Y6jr6ajXY1rNOP0s1euPMkFb6YuiS7wIcfZA1TuPyHlN6nXq76/7TGhs4cyNbG457AKFwJsxmPSjJ9OjCRiaw0p11OkbyZgUWN8CEtKu4pW5Lmv+nuyMENwGBCZ+LLkw3p7pCqOpxLb/peY2SNz99o5wIF6kRuU/pys4GF+VYaLGudOa0v9cxJDRkIa2P7F6KX53E1+cPlST5ISvYqedFjLGzGC0cZiumdOsi1hx+UU8mpFQ4Rj313TktoEAsBjnGz5V4F31CNSi4ziwLhHSa3vFw3Dl9Bk0Ma/6LhfmkuHMlxQg8Oq8nBb35JIk4HsdwGYbaF6cDa4UtdBfZ1v6JmSx3MdM5S0OVSMATHVOjgWRXzAmngKAZj95OMNERF5lwu+M1L6B5zVgGFEbQxSOt3jb93oXr0KqvPylu7azaArGfpMnbnTVFHR4866zf+gGd6HCWmqoAKF3dU2ZD0ouM037SKr5F6snFPoA36
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(2616005)(70206006)(5660300002)(426003)(316002)(70586007)(186003)(82310400003)(8676002)(36756003)(7696005)(8936002)(26005)(47076005)(4326008)(478600001)(81166007)(356005)(336012)(82740400003)(110136005)(2906002)(36860700001)(86362001)(83380400001)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:27:03.5521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2413577c-9d25-4afe-6452-08d90ad7cdc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

invoke callback function for mmhub ras fini

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 697ab26..a129ecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -473,7 +473,7 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 
 	if (adev->mmhub.ras_funcs &&
 	    adev->mmhub.ras_funcs->ras_fini)
-		amdgpu_mmhub_ras_fini(adev);
+		adev->mmhub.ras_funcs->ras_fini(adev);
 
 	if (adev->gmc.xgmi.ras_funcs &&
 	    adev->gmc.xgmi.ras_funcs->ras_fini)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
