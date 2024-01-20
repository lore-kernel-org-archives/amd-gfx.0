Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FDFC47DD9
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jan 2024 10:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75EEC10EB46;
	Sat, 20 Jan 2024 10:19:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A9310EB45
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jan 2024 10:19:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGI4I7rBxGG85KkdzmuDKs7SDQUA7frxtzR4Vc12R/cE9/4olS0eCkbTp4oXeTX7hOJHN2oT12YnxCbTc0nqeYQ31CXiO5qBP6xeHlV5MVK+m6DOxEAm83FVmhOLne4cgVmcm2163q5kqYT7yddKqDFOREAMcjNlSptRi9GlPGgT/lMHqmUWTR+Ddu3u+6eYErNUYpmscviLLFJAQE2M7Xl/bs0S1/yMEVYn30Gh99ahUFlXthLJdyC/+bRE0/Y0tL59qjzE2vdTLGAefclqIl1QclhSJAzet7uTAxjaDlFH9PkDpxMy6I108I6GhIp0eMZEkgwqDnYmR7V3dkmAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5a4NxXJ3MmoK+V5ikH7bczMHYHJPCC5ZEVYxxPj0Pw=;
 b=Qg74xHgxGlhvgbSlxYcdq2arTtAVnr8jouJtFnXnCKZpWIzSGo2IlzU8CCksE1la8xDR53855BoMX2PbJjP44CtHNtbaXIBZsn/oU22yzSqWS8qxwfZ46Pm/XRMkH4opwrTgsLRCpmFq9dcQBd8Try7OsP3yKjg7pG9YwZcSyewv6jKChr6Q/BjcU5jJcwp5LPSiJrt4iv43ViSeI1DBBXmQOFDpmnRiDzucbCLMl2Dgkeecd7faGhlD8dHAFsz8/T0V5NomRnKmSEo8LZ9I5dIdnlGMNSWhR8iUJyFVHenfIKmFn1UpDFg0ga7r3MZROWfcP3eE4O8PYIBaABRsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5a4NxXJ3MmoK+V5ikH7bczMHYHJPCC5ZEVYxxPj0Pw=;
 b=S2iPzQZtPxYYdbcaVAX6BaU+uCmPQn9FeH3sKN0MME1Pmu031dHj2rj4Qmg+YmffOxHgX8WjqTe5jhAZBezqwlRfn3kTtp3vozgC6OmcQI0fZWGlz6F2UgQsfr0LiAtdYff4oElitgjwx2Xl6Qu3345TGk7DuNQmoTbjdYKqS3o=
Received: from SN6PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:805:106::36) by DM6PR12MB4369.namprd12.prod.outlook.com
 (2603:10b6:5:2a1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Sat, 20 Jan
 2024 10:19:01 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::d3) by SN6PR2101CA0026.outlook.office365.com
 (2603:10b6:805:106::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.6 via Frontend
 Transport; Sat, 20 Jan 2024 10:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Sat, 20 Jan 2024 10:19:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 20 Jan
 2024 04:18:58 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Show vram vendor only if available
Date: Sat, 20 Jan 2024 15:48:41 +0530
Message-ID: <20240120101841.175599-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240120101841.175599-1-lijo.lazar@amd.com>
References: <20240120101841.175599-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: c8660b87-294a-45ea-47ed-08dc19a1386e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0ujSTzjUAh9Ck0ZNiQRc4uy9T12F4V1xLMXKaTaB7LE5HSD+KRg+iZv5YeKn0eRSFgq74W3nudANHp5F3U/hryJDzZnvwRF8LQYuWHrvFmO3qSlLylsQSqO2esLAbniHCwA97O+Awx9qqpEa99B/tsXEexI6SI6yhu+UhQr0KfADDa+AnQKHIQfjeGHJPsqzqVpQA5YSN7Aum+NcRa0MaF0QWr/irl+ELEU/SFHCpDqX5Bg0+dmEtyxp7xtk9+YioS/ux2PJ0aFTJbGZsc7fVK6FC+riRxd4UGZpOR1nxdouNKHIIc1kMFEJmQ3X3BJjSgD9Zuy6n2DjFH/0d7DNyVRXwhSxmRrcDb+as2aKUXbL5u/3yDpOytEXY1uQHeQ4Orq7NIDbO2o1H+vv7JSspcH85VzqHJA9cZcE3LFGnauxKROze79+Ib/eYDeKrUiKD+PxoiDftpmWXGiypwtueE7+uvbQpHARL5/J65fvrJ5Bnu3xeFanuilU/QYiUUrL80cRGAF4oPj1B9rUao10NsgauFOR1foonQTvrWOc6N6X8xiw5z2qAr39HYnAB1BMyu1AMGYQMLiXnqxvYlzQpbXb265+j7EZXGIxeHa5T40JqMhAgRNOeDZLArb33IYKTVLVy+K6pAFWHIWbEbNWbmDeffuZ8upmw3Zlo5zylzOYc5JvE60Nan1Umrrf0lqa4fX/J9HGpBnzj+eb2flqyc+wvAf4ID14+AKgC5AA7YW9yps3XRILPoWaYeUWTFtFoksNYe/N8Un0j8HWfZ+Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(2616005)(336012)(16526019)(26005)(7696005)(1076003)(6666004)(83380400001)(316002)(70206006)(86362001)(54906003)(6916009)(8676002)(4326008)(478600001)(8936002)(426003)(70586007)(81166007)(82740400003)(356005)(36860700001)(47076005)(41300700001)(36756003)(2906002)(5660300002)(44832011)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 10:19:00.6323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8660b87-294a-45ea-47ed-08dc19a1386e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ony if vram vendor info is available, show in sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 08916538a615..8db880244324 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -221,8 +221,23 @@ static struct attribute *amdgpu_vram_mgr_attributes[] = {
 	NULL
 };
 
+static umode_t amdgpu_vram_attrs_is_visible(struct kobject *kobj,
+					    struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (attr == &dev_attr_mem_info_vram_vendor.attr &&
+	    !adev->gmc.vram_vendor)
+		return 0;
+
+	return attr->mode;
+}
+
 const struct attribute_group amdgpu_vram_mgr_attr_group = {
-	.attrs = amdgpu_vram_mgr_attributes
+	.attrs = amdgpu_vram_mgr_attributes,
+	.is_visible = amdgpu_vram_attrs_is_visible
 };
 
 /**
-- 
2.25.1

