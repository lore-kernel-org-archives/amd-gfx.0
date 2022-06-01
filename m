Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3575AC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 17:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A993010F0D8;
	Wed,  1 Jun 2022 17:57:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D2210F0E0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 17:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbt+kgZhqo4Oz1k8pzS0QegtIoPuoYzgHWDNyT4glpk2UElb99GLDV1bk/rkywTuWBLddHYoB84mFWoME8cPc2/Et0iEgQrRBoH+WpRtE+Ou1+IaPvMw44rO4O6JQ0kufSAFVvSI4gFvk2RTARXlTvcTwBFMuREQo4B88VlX7iFGoQgLrcpXS5rwwQawFMZlBQIaO+1xLt8W9ZIfqNaa69qWoM5fLjyMQc5Rn/XtuL5vfuJT4gTkY9wiiCum25dyLw7hYt2k9x2eLFGnsr164cvIshC8VruEw82cgv9HlliKmSrZ4W8+irMZFIZ8Z4xdjOlFMVaRrgXEUHAwGCd+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdbQiAuFkiDG1A+MLkZxMGlQR8NSCSPkAc35RI1vWq4=;
 b=XB+fMfDZE3SfktgQRsg2feweH0itJdlnjz3Xca0jgBDP1Bhe0Zmue8QFLid1khoLeithAB8O/lo0PFz9kCAaCqCu+2RAQKh/s1yX/NlGiUuY6mwwANmhuz4/vaOo0mtpNlWWBdQOrHevWWyedKPEaX4h9fwrvCccz18evICTdeLH532raFyr7EVFonLQdJcmMs6ISmmZrjfZ628vOZmBMWh8SY2XeO12qS3S/XlVx3fJvkhrGyIZWDHzRT+VmZDqGfGSpT26PxWz6+alk1rbki6Oionww2gM0ZxHXl7PvI2UmWKJUmQ3sj7sFTPDTPXYupqY8A7ns2ZpxhvBbodoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdbQiAuFkiDG1A+MLkZxMGlQR8NSCSPkAc35RI1vWq4=;
 b=iJnt++bkab/LzRW0iwEEYKKcr0EJFWKtIqzhPprhW2iXc53LNlsgL/AWzwzfVX+mVd7B8bi23SzWD4Oq+xZIAkzSopUQz8yxCi5Bcd2WflFYo4VwJ5wB+sF6sF6E0PWBEWVGgHlhmFmt+Tn2DiV8aCpC5QweN1ASXbIlmA/rLbI=
Received: from DM6PR08CA0018.namprd08.prod.outlook.com (2603:10b6:5:80::31) by
 BL0PR12MB4916.namprd12.prod.outlook.com (2603:10b6:208:1ce::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Wed, 1 Jun 2022 17:57:06 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::11) by DM6PR08CA0018.outlook.office365.com
 (2603:10b6:5:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 1 Jun 2022 17:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 17:57:06 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 12:56:29 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Resolve RAS GFX error count issue v2
Date: Thu, 2 Jun 2022 01:56:10 +0800
Message-ID: <20220601175610.28448-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5de42c3c-219d-4288-cb50-08da43f82444
X-MS-TrafficTypeDiagnostic: BL0PR12MB4916:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB491618BF283D543E2259CA9391DF9@BL0PR12MB4916.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05TBYalCWnr7nCvWl/wxBnKvAPrlUBFvbgPEIVoaN3zHim4imYOiVCrKvnB415rz4wVcDhQ8nIWsuHapzwYQ/ge6kTMmtbOcFPtHwdi9kTnnoetSoMvMqICCPO1O9D+YD49cU3kTk4wj3mSqTrMX8jIbeFGeQ+Wk5Eq7CVbvWY5yUmkBg8M8cBLJNnKytOSqcmBggEk3vYpShySIM5GJo+tQo2aiWFK9MYkmJvWIkFpp2RHJpzz+VJTV2CVQXQ7PfsXfF5aj7KMiyViYPwT26pMiJyiekwPoB0X2hcKYwsB5/AgiLX/Ahp09TfcZw79JFcuD1cM3+qTNhPPVsZkVPQyyjZ/1WCE0azW3h03Iy6otvORIRCB2HanmRp4R7wGeqfmYAJ9LWklOgxcAGeEZaAOyaxN86yMkfCM0/fk8CIzR8txTZCc0JAfBHxE+Jbr4FafHX5o7t+5XkKkKa2b5E/jhePkcOJp4PnY6w92SLoraBeZ9YrvhRy+h8y7SucGP7P6kszXVCUD1yEpip6BW/RerFYQObkAjUmHjP9e9SFs3P9gps1XStjC2uRAFY0piUWNpGPKCir0W3ByKYg6o0EKIbwQERal5EbRJgVz8o/w/5knN5zKXedcPec2LGztElyghQUUy5orQ99/bxIudSRufNWF8q8F3Cz5DJaaBX+jlEruY05dbxQ0wZF2qUDbxaU0PtYjXOi2S3b05VhP3tA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(82310400005)(36756003)(2616005)(81166007)(2906002)(316002)(5660300002)(4744005)(356005)(44832011)(6916009)(26005)(7696005)(6666004)(4326008)(508600001)(70586007)(8676002)(70206006)(8936002)(336012)(83380400001)(40460700003)(186003)(16526019)(47076005)(1076003)(426003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 17:57:06.4847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de42c3c-219d-4288-cb50-08da43f82444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4916
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix misleading indentation and add ras unsupported checking
for gfx ras late init.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 99c1a2d3dae84d..16699158e00d8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -599,13 +599,15 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 		if (!amdgpu_persistent_edc_harvesting_supported(adev))
 			amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
 
-	r = amdgpu_ras_block_late_init(adev, ras_block);
-	if (r)
-		return r;
+		r = amdgpu_ras_block_late_init(adev, ras_block);
+		if (r)
+			return r;
 
 		r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
 		if (r)
 			goto late_fini;
+	} else {
+		amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
 	}
 
 	return 0;
-- 
2.17.1

