Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E15C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 04:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7EB010EE95;
	Thu, 28 Mar 2024 04:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vWvMjUab";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E1310EE95
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 04:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/MmTZOCAx1NWYfJG3EQzO/zy733R1ZjL+sEwlFs1MePHyQBcR8n6dnuCNKAQB1MVNUmvxiFp+TBaNpz5tLLAak/qzXrGMK2ytydMkZOuwC7WEf8eGEbYBpIyffR7Hrt2zBgGBYxtfL1c7vOiS/FEXPeGc9lzOymidG7F6Qr70JjE2UfNTLDtHtvLGhvWtpBhNhi+Jj5zs9/PCdkH7GXwGU1jne0p31Pb3wJuLfqsirCiVmQEak7ZlzO5FJa75ohY1glQz3LCSIgdSNNjC5/v8OC8XL4cdiiAK0W/fQUZHMumOpafSRzWtY0WIN0ldIcGsFTGP9RgElzsAvu4RaHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euy/+BB4ujch243RTKaA3phiCn+4voExa0QrwBHBVFI=;
 b=hb5lmeBz3dKuEZ7GMbN6UwuC2fkRNX3iTgFQ4qdi6naowo9ZLTr9eNsyeZ+D6Y4hH094Ote9EsUBmAFiDrJ7o7Wv2+S2rDLVkMZ6PNy8XIOy7tK5KFDJViXWDcnUMYasYHq1BOjfdtk7YKkv8CJYFhN2y4NJSC5ew6iwkmhsiVEd2BsSc53aeVfaMpHTJXWihMzls1qvZq82m6HqtEqo7gdkiMR3SNvZo6rpX3MqurrG1f+vVKJU0sD7bRHYZWsReLsSh5tSTogRIvXbuJ53LK6YVKDALKw9SRh9/HkIblazTH/Aaq3DzmYjoTs6J2spLr0lrqNK4K7gA5LF1bO9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euy/+BB4ujch243RTKaA3phiCn+4voExa0QrwBHBVFI=;
 b=vWvMjUabrxQNcdr710pdZT4ApvNdTXNaBi+R4L7rc8jSdy84Ea3tSldzSD0wzv8iRSI3f0oFIxjxTUv+O4SVh3m54QoUck9hkQAS3P0jn8MdqgKtl58E/PYEoK+QbaS3xggCNeCFf3FMlqpmi3ggtxAZJpk3HpkcgEqnvJzs0ME=
Received: from DM6PR17CA0029.namprd17.prod.outlook.com (2603:10b6:5:1b3::42)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 04:40:29 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::1c) by DM6PR17CA0029.outlook.office365.com
 (2603:10b6:5:1b3::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:40:29 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 23:40:27 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: add post reset IP callback
Date: Thu, 28 Mar 2024 12:40:14 +0800
Message-ID: <20240328044014.3278891-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: d21932c8-38ba-46ef-8071-08dc4ee13209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2k3GpIXp3tYu9RXgNVqRSwIw9vdyNMSmDtjMWEgRLFaugQla0l9IxbDs+OEHwA/KA+xaVqJHY0IsU/JSlCx/KG1iR4hGIW3LXDDH7AGknI3QsUFlrdS49+F8TBSQr+1HWlSYWI2c2t87mL6mAjtncKHLAsgBlfSV3GiqmmI6QQ7i3O7/S++/7VzVIjQ5Dqw51/m0O3ipZfWpheaDzbmN/TOqBoFJlrZ07JtUNYgGU9XpltxYgvMetIO1pdwMwOi7CHD9k3Nr16E8EdY7y6PpUwhaJlm3Z3x+ZWa4Z3edNz5cQuGaXxxuFqX9umfGDLRdpTnDyCTtQuJ9Naet33jlTTWniVp90mkaY9gSQ0R8Dza975QmD4DUCu/8Qx+t7FQ+K7jgEzG8ux9ASI6DTDvsFaoIU9WJWNrEvAkxqccu+kM1h4a9IgaWmJN81QBwi2Fqm7FjBoCIlH+Zkw24gVS0kjc7Q8SUVnQJ7/EFo4YqJZjSyVP6L+VokW6rr5dipOPVh+VW/8O8L9dgIaC0yT1C4xKjHn2PmN3EhQOi6TF8Yknc8Lah/+uDU4R72GIPzBRc6m5s8lERy37hAmDe7NcVzGLgqAJWY+SpMffANohomE5zjGhuSZJ4kBSdfImnQyPgumeNV/XdVYbFKHc9dKhV53r9bk44mXN/pf98ONfhzbvAuLNpTGT+RgYV2ibbcu61KrjY4TD2oYMY2WV/JsfyKyWE1HV6cSHhryWj9HKa59WxQ8fMLZ1JYIMkugIE2PDr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:40:29.3233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21932c8-38ba-46ef-8071-08dc4ee13209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are use cases which need full GPU functionality
(e.g., VM update, TLB inavildate) when doing a GPU reset.

Especially, the mes/umsch self tests which help validate
the hw state after hw init like ring/ib tests.

Add a post reset IP callback to handle such use cases
which will be executed after GPU reset succeeds.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 12dc71a6b5db..feeab9397aab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5556,6 +5556,27 @@ static int amdgpu_device_health_check(struct list_head *device_list_handle)
 	return ret;
 }
 
+static int amdgpu_device_ip_post_reset(struct amdgpu_device *adev)
+{
+	uint32_t i;
+	int r;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid ||
+		    !adev->ip_blocks[i].version->funcs->post_reset)
+			continue;
+
+		r = adev->ip_blocks[i].version->funcs->post_reset(adev);
+		if (r) {
+			DRM_ERROR("post reset of IP block <%s> failed %d\n",
+				  adev->ip_blocks[i].version->funcs->name, r);
+			return r;
+		}
+	}
+
+	return r;
+}
+
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
@@ -5805,6 +5826,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_put_xgmi_hive(hive);
 	}
 
+	if (!r && !job_signaled)
+		r = amdgpu_device_ip_post_reset(adev);
+
 	if (r)
 		dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index b0a6256e89f4..33ce30a8e3ab 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -287,6 +287,7 @@ enum amd_dpm_forced_level;
  * @pre_soft_reset: pre soft reset the IP block
  * @soft_reset: soft reset the IP block
  * @post_soft_reset: post soft reset the IP block
+ * @post_reset: handles IP specific post reset stuff(e.g., self test)
  * @set_clockgating_state: enable/disable cg for the IP block
  * @set_powergating_state: enable/disable pg for the IP block
  * @get_clockgating_state: get current clockgating status
@@ -316,11 +317,13 @@ struct amd_ip_funcs {
 	int (*pre_soft_reset)(void *handle);
 	int (*soft_reset)(void *handle);
 	int (*post_soft_reset)(void *handle);
+	int (*post_reset)(void *handle);
 	int (*set_clockgating_state)(void *handle,
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(void *handle,
 				     enum amd_powergating_state state);
 	void (*get_clockgating_state)(void *handle, u64 *flags);
+
 };
 
 
-- 
2.25.1

