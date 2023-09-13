Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFB5EE01F4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 17:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810F710E4BE;
	Wed, 13 Sep 2023 17:15:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF3910E4CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 17:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN+PCFbqvugUkRs7/fYS08eX6F+yhGKZb0TlMBFeXfBUHXFGsnIgrxwSP6PR4Hb/I6O1QmiryDpfWgEYrRnPOzj8yecyRRMgaQzWyo5UcP+tA+1QteTsJjcb9mCAbpvWi1sA3YKSXIKphOgBkDZP4dc8VGai8gcABd/QbkFVlmQZNye20KXoAlMhC3mw/N7p3YYFeGmhxSTThJNM+bA9CBQM7v+D1KBP+k6cNH55yReBCjUNnUe83HtrGDkbya/bnrMO7AKhXqCAKAY3QNOSH7agSZOobz+oEtnlV6I2b0jhG5DvyPjKJJgyZojvtbi7S8FaTxHQVx5aFE3VqRyipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QwKIDwPxhjPh60arrFlHUeuyui9exxOkhEfvTiQK3Y=;
 b=aYD5iHkfrnheKKPvgVbWFmB9WyqXUqWbJqmDbLzvyi9pbK9KtHkfQbP4c5LIua1W8bE8FyMQFFCAonM6mvMDsz9O0v4g0kcPAJ+uHqYZWaldnl4BlnoGLJoPUJacAlsaPJ/XH4EUel5ifpT31GWNtyADSARs+DxSmeMb0QtjUdiysA2/Lr43Q/SdxPbg5BFvx/6KTlztmO4KPO5I3uld22RhZtJA0V2EN/hCfi14psdEhpa+ohxVWTXQk0t6Fm2OoqpmiE9aAIn6eYc8kP4ZgI0BL8Olnghj3G7JXIF9bqmu68sYzbBugARcDR939ThVbyt2wMskshUoEctHvl87qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QwKIDwPxhjPh60arrFlHUeuyui9exxOkhEfvTiQK3Y=;
 b=x94GclQoH0GOa/tchiVK9e5lpBhy0U3yiKzlXVtAqSzQvyNn9ihbJ6YXsiBm3HBJlWhemsH7UwuRBDlM6Ot61XVChCWQjmicVGAi8rovUJxVh50RId7qg4/dhxAmTX75E/45qnyFC0pltif46Yya1VAKdxFfmyAinhZScGv4dns=
Received: from DM6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:5:134::20)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Wed, 13 Sep
 2023 17:15:28 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::b1) by DM6PR13CA0043.outlook.office365.com
 (2603:10b6:5:134::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 17:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 17:15:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 12:15:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/4] drm/amd: Enable seamless boot by default on newer ASICs
Date: Wed, 13 Sep 2023 12:14:55 -0500
Message-ID: <20230913171455.153412-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913171455.153412-1-mario.limonciello@amd.com>
References: <20230913171455.153412-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 553bdc72-f0c4-4563-a24a-08dbb47d0702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mp9fvk5cHCUQi2UNxc3wLCvHEr0pp/NXJLYVp0OT1Lnkf5i4Tif38Kh/oWiHzkeD9R0+2PrBNu9c5ATXgGFpQebko/GK3SIuU6r+dHzsZZO6Agl4s9EkQQVUdXy4N3/duZGuNsR4CYDaYwhX+C1/4HoeFP2Ao3Zy0YkmwVpjlQg3rPXwahK+CfqfLlLM5I4BoExn1Z/sbf/z9DYRneQxA0r5+pR01xpQjM8NXSwVgfTAlTgdaNtvNJH4LcWH/2Rk2zOAR/kXKo6cwZTKShYzoZzUw8OduFhVxxelGVbMT/JY0QD5so3DSS2l7DIi1DFc0YzeEW0pO7WQSgLz9hUfrUK4AYQ/7t9uvRdudhPbqWMkYXf9AqnSh3XZq5UuHkYWMO+MRlyyA0eYftde7y/1VYOk3KNQ3UMZMFFe9Q0nmRQzN8K43A2i9gMX/c4uNEuRcsij30ex/JPg3xwlSwrGryhsE+JJDEVtV5Y3eLGFInaAUGhmdEf3KpL1bg4MJ448povvB3a35lixZs2nfjlhYF+zcNnU1wIjTwxlRf6TZnOfx7wQGpqt3xJFKE74yhqTZ14fmkNGivbpkwFQYHBwIL6xYVsNPwZ9kBO0BIFOC4KbLkaqFM9S672SD6Y1ZkmpWlRxFIlKhhNI3F45kZCmxhps0jz07Wd+ur/t6jRtEw/rmjS7jC27Ixn5FUZpf3WZ/UEtkyiCJU8/8Uy6RKbAYqbsJ6mTJhyjoZhVA6Z42VYbIAuoA9vJA9SPt5gphzOcO9B4gn4gyDbg1zirNiAtOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(2906002)(47076005)(36756003)(86362001)(82740400003)(81166007)(356005)(40480700001)(2616005)(16526019)(26005)(4326008)(8936002)(8676002)(6666004)(1076003)(41300700001)(54906003)(6916009)(70206006)(70586007)(316002)(7696005)(83380400001)(336012)(426003)(478600001)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:15:28.3488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553bdc72-f0c4-4563-a24a-08dbb47d0702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Seamless boot can technically be supported as far back as DCN1
but to avoid regressions on older hardware, enable it for DCN3 and
later.

If users report using the module parameter that it works on older
ASICs as well, this can be adjusted.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2116e016178a..38fafed31a1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1361,9 +1361,9 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 /*
  * Check whether seamless boot is supported.
  *
- * So far we only support seamless boot on select ASICs.
- * If everything goes well, we may consider expanding
- * seamless boot to other ASICs.
+ * So far we only support seamless boot on DCE 3.0 or later.
+ * If users report that it works on older ASICS as well, we may
+ * loosen this.
  */
 bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
 {
@@ -1383,14 +1383,7 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
 	if (adev->mman.keep_stolen_vga_memory)
 		return false;
 
-	switch (adev->ip_versions[DCE_HWIP][0]) {
-	case IP_VERSION(3, 0, 1):
-		return true;
-	default:
-		break;
-	}
-
-	return false;
+	return adev->ip_versions[DCE_HWIP][0] > IP_VERSION(3, 0, 0);
 }
 
 /*
-- 
2.34.1

