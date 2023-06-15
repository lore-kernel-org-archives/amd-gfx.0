Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4C6EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 08:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7647C10E4A0;
	Thu, 15 Jun 2023 08:56:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769CB10E4A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 08:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1PyzMYZwWy7X1adLYrYE/O6M5afWZvzu8GjXuyrhwz7K0aQrpx3cDI77NEDz7sG+jYxWMEGabwW9DgBaFUHOu0bDGJrG1+WNXAVmk8CC/AqlENAqPjsHVaCTJMKVsZn50vebQV50C2ETBMumA7ZsT3mhty1ODkQCROW7SkKsokAvsbzfgWI9wNjne0qs3N/CevOjd3ae/kU0BSmwUEWmI5h7shL768fmfyK/LfiKku/fTYsG1IBLdOoCMQhSrvrcfgI2U/Xfg48hnB1qg9nZhna4MEB7nXfp54tMyQVBETitN4BIfZN37yop7I+QR1EVVUfybb5iivLUm7mOIGnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhVrnNeZ2P/i2RYEt3nihjEJ1XX+33oROBbskuZlCe0=;
 b=Bl7/BprtxZFXtAkcHBic+JIvSg7xEGCXQTP8CDx1+is+ydAjWJnQYssQ7AVAkcK/7eea9JHspixebkf6+buAG+Q/SrU6/RfeNh8H51v8aoZf8XvkWevUjS68/7DiZdRKLoKDlI9Yt3u6FlvI+jy0nIGgzX3R5XHp+leQv+BjEBK9VUxilQA82qLGamHook1zzVfNCMOCW4muwOpI+c17844JF3EYK/jQI0bWgVt6RT3ajbpfdoBRD3Vxsg9RzN4TIPJasEQ36ihU1ub/vmYSipiIhlxNNww53rgU6gNTkEA8ylcRsyPn/iMLJmAok8U7Tzow3Dah+lEVGpJ6PMKIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhVrnNeZ2P/i2RYEt3nihjEJ1XX+33oROBbskuZlCe0=;
 b=RDoKE3RmThLXNo6+GxQV/haLZa9FI8PaSkCCggiWTeNNdT3nQn4RXR6XL4ZoTz9TRgmrmseHNw3ZWukZgkByOZcMG/AVGY9LnzNbRgsJdytl1ZxejnzA2g3MQS+LieM4Bily/CUhp9pZz0+T+xkqRCwC70Y8olj0ub2gK9PZ9N0=
Received: from SA1P222CA0185.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::11)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 08:56:53 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:3c4:cafe::d2) by SA1P222CA0185.outlook.office365.com
 (2603:10b6:806:3c4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.38 via Frontend
 Transport; Thu, 15 Jun 2023 08:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Thu, 15 Jun 2023 08:56:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 03:56:28 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add vbios attribute only if supported
Date: Thu, 15 Jun 2023 14:26:10 +0530
Message-ID: <20230615085610.1619133-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1eca9c-2147-450b-e06c-08db6d7e76da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1Sb+uoT20qwBHhC4obD1qAh0d6c7dszJOUuivBJ8yHdKCVFlHVLfWQ+XrSuuniVB9ACAXqWKjYYwbu1QquMJWJC/EpTGCjggpuUNWbJkTCBwpI2MitP+h7eKOiTLinZeq0eTdJLlBVhM4ahfCvw/dhVxSJThb0yUWeaKtz1qvZyV0ldChEQDXxERiDZDEq5VjJ6PyNFv6W8ncPXdQlCuBNn/ryvJbwSk49adxytJrZ8uKj5gk8LXmo7L4tCLCaj9mQgYjRNFYqtILKoo5UQGXFdC87bWuThreO7nhmnhcqbTxgNoOF4XtoE+zcjePtfmeuqw+42WAXdvHzozXpIqixG/c9tyL26drf4Z0tEAgY9K21VQ2M2g5puRnllkG+Z5Ya8RNaEVZBJlB+BI+LWT9Q4SNdKVlyAtLfJbJOAK9BgwDoXHe3Wlynl0/yjZpHJuy8usZ3ZunGDeJSvguisgNv9ZJ9a8ZNn3fQhFbzniuL1fQbsc2CW9Ae9jNNzfm9PSwE9WvUTxD9ugn8f3HOUOdxNGP300gpm19VXEdDkrZQFcX2ULnsboBuZ+JMASiO4swoyAt/w8/CRbnOzpxqBsqyt+yz+8hEXas7VF6k0fErPirh8JbvKZM4f/8aO/wpc9QTHrnkZee9KSib6pnWSBSjmTyXgoxo8tDvOLTDLX05g4Ds5dbFrOirIMXQqjqPBtuBM8B+OtW3XAbUvSu8OoGQk6NTSlv50bbAidM8WcWH3Bmt8h1OuI+hN+rtly/9kuIOxpCz4VUCNsgmzkbKvmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(82740400003)(81166007)(356005)(336012)(2616005)(426003)(83380400001)(1076003)(186003)(16526019)(2906002)(26005)(36860700001)(47076005)(44832011)(478600001)(40480700001)(6916009)(70206006)(316002)(6666004)(8936002)(8676002)(41300700001)(7696005)(86362001)(82310400005)(70586007)(36756003)(4326008)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 08:56:52.9794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1eca9c-2147-450b-e06c-08db6d7e76da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not all devices carry VBIOS version information. Add the device
attribute only if supported.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      | 2 --
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 9ba4817a9148..f4e3c133a16c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1791,6 +1791,15 @@ const struct attribute_group amdgpu_vbios_version_attr_group = {
 	.attrs = amdgpu_vbios_version_attrs
 };
 
+int amdgpu_atombios_sysfs_init(struct amdgpu_device *adev)
+{
+	if (adev->mode_info.atom_context)
+		return devm_device_add_group(adev->dev,
+					     &amdgpu_vbios_version_attr_group);
+
+	return 0;
+}
+
 /**
  * amdgpu_atombios_fini - free the driver info and callbacks for atombios
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index 4153d520e2a3..b639a80ee3fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -217,5 +217,6 @@ int amdgpu_atombios_get_data_table(struct amdgpu_device *adev,
 
 void amdgpu_atombios_fini(struct amdgpu_device *adev);
 int amdgpu_atombios_init(struct amdgpu_device *adev);
+int amdgpu_atombios_sysfs_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e25f085ee886..eda0a598722e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4018,6 +4018,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Get a log2 for easy divisions. */
 	adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
 
+	r = amdgpu_atombios_sysfs_init(adev);
+	if (r)
+		drm_err(&adev->ddev,
+			"registering atombios sysfs failed (%d).\n", r);
+
 	r = amdgpu_pm_sysfs_init(adev);
 	if (r)
 		DRM_ERROR("registering pm sysfs failed (%d).\n", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 999d008b6b48..70455b00c36e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2896,12 +2896,10 @@ static struct pci_error_handlers amdgpu_pci_err_handler = {
 
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
-extern const struct attribute_group amdgpu_vbios_version_attr_group;
 
 static const struct attribute_group *amdgpu_sysfs_groups[] = {
 	&amdgpu_vram_mgr_attr_group,
 	&amdgpu_gtt_mgr_attr_group,
-	&amdgpu_vbios_version_attr_group,
 	NULL,
 };
 
-- 
2.25.1

