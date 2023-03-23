Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B764FC6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F39C10EB33;
	Thu, 23 Mar 2023 21:41:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8D710EB33
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOKDwcJvODbSasHcUaoq8czoDjdMivQmnVF2axm0GcewvrdFgi8gVAR07r4SrJdwCGfN1nzls1fojlF8HW1wkVqHnYe8I0a7Dc1uEAik+uLsE3vIyNS3arozl27klk6Z4g8uAP/mMpDAZOgXZcVOC0Se0jxO84PPYeRZbaK1PiFsPjzI5JxWbrgmstRBR3mpGO5PLPkOJZDxJ6fUkQc4WRpBqmUUuC9sC86Zto1+chXI8XEaaekfA+V8wpM2/Qj3xn3zrvdFxHSx8qd5fw7xOS3akGRKqMuU+7EQIJvcmeIjaA5HuFljXKvupKo9kf6otOHAqcIXuyJmR59xQpa08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pJzRDdEHUokjZtOU8RGfsTcRv0qQQII312HSeaI0Kk=;
 b=VKQwqzQkUKh6y5aaeYHgZcx/hMwH4KVFVhaJwu0uVRgGAhw5EYb/szqMwZ0pbUjgS1gtAtwauVyUdEwn/3n2XLLH3y4WSpuwjd9rqomuxZ3IuXxuzBWxo/LIdr3es4xaE93hD2YWXgXUulIkO9Rer09MxUABAS/YYdy+Q3a9MJQvoCN1MguOKOUWmBR3XELeKRacNovNytBtbVqhT2ErUnACLP/GFMOWelhiLLKjO1oRvsd8RvgtJqamTXNtMSlV7wHGwBwa3bFS9nL+Tl1HIt8dGViVU/MMuej+oLUj8ECumv1EMwaxmZ8V40EJpDFE45QNRocL+qGXsGId1DLxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pJzRDdEHUokjZtOU8RGfsTcRv0qQQII312HSeaI0Kk=;
 b=HdB175qbVbRbBjHTfWreqHTNLbf3rFQe9Nc9wymXbHFp6GY2OJbaw0lVyylJLqSb32ag+OjgQ4LLkrwcV7cOeUh+P7uwW16E0hgeWg3onGaW91xsf/mEds5X15egLclEgDlY2WLh8xF35tSzYF73tgyVqaEIt56eurGgWJC4zX0=
Received: from DM6PR06CA0074.namprd06.prod.outlook.com (2603:10b6:5:336::7) by
 DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Thu, 23 Mar 2023 21:40:54 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::dc) by DM6PR06CA0074.outlook.office365.com
 (2603:10b6:5:336::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amdgpu: add support for new GFX shadow size query
Date: Thu, 23 Mar 2023 17:40:31 -0400
Message-ID: <20230323214034.1169310-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: e7357638-ef6e-4694-8536-08db2be747b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6g9dtlD3tay/o1n07d5p9LC1X2NygcxIjO7CDZFBbAdjyaAz3gbgVyKEPPhNARjbTWoW9r3Odzni+GuDv36380W3rxa1UF6a8UuYQjwhRs0Kr0VI/4A7cqcXGMtKtb85lFAXhgjyoPBWiNXJ9KgZn9wcPo2j0Syq28eK+Ry18dUJgj0+dtgd6LTm3i3lIgejYRjBByLMMkvFtYXAnQuPsWua8IXjF+vjzvIyLgo9bifvBCPycHCArsx1iCsaPJu9zU0WhqlXmacQ8jnY9X0KuiQAo3NIVmi34PhHVxz9Q7Lz2596vIirUWeg6S8qD9h6tAJX41ZqdiCMGYMQTSv52oOTQRzrqMGefJpxQJByHPuJ7w5UWm1WJGrqwFp9Onssk0YRl/rUzHyk4RtjOFmgHpd9ypdIqzQ4HldG4FhqB67i3MliKPJKrz3nZA5aj+fcKegFU5q3JAR36JNMZO8VpFLsW5kalgAdvcOb/r7yqMPfn3o7J3Nmn7N9PMiDZED0xKFg3gcGHAlDFMzyufAC9Uf5qdgvzDhmtWFD7Uf4CWMI33lcVDqcaEzrTh+3EpCGjFZObpj4qNYKaEltD4/xj44jCtdZPPAkpkVVhYuECrcGhSZ51IYWJtWtZ3TMQqzsqJ6rLayam9vvtu+HLPMRc5hKxzsf+zUObgs//JdjnKcQzF4fzqYpQRBYWJNce9KrarfMXJEAS0FE92c5m7bscfqDXlB6Dk4lg/CMDhOEF0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(36860700001)(356005)(81166007)(82740400003)(36756003)(2906002)(41300700001)(5660300002)(4326008)(8676002)(6916009)(82310400005)(8936002)(2616005)(186003)(336012)(47076005)(426003)(40460700003)(26005)(16526019)(40480700001)(70206006)(70586007)(316002)(478600001)(7696005)(86362001)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:54.2663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7357638-ef6e-4694-8536-08db2be747b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the new callback to fetch the data.  Return an error if
not supported.  UMDs should use this query to check whether
shadow buffers are supported and if so what size they
should be.

v2: return an error rather than a zerod structure.
v3: drop GDS, move into dev_info structure.  Data will be
    0 if not supported.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0efb38539d70..90738024cc1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -876,6 +876,20 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		dev_info->gl2c_cache_size = adev->gfx.config.gc_gl2c_per_gpu;
 		dev_info->mall_size = adev->gmc.mall_size;
 
+
+		if (adev->gfx.funcs->get_gfx_shadow_info) {
+			struct amdgpu_gfx_shadow_info shadow_info;
+			int r;
+
+			r = amdgpu_gfx_get_gfx_shadow_info(adev, &shadow_info);
+			if (!r) {
+				dev_info->shadow_size = shadow_info.shadow_size;
+				dev_info->shadow_alignment = shadow_info.shadow_alignment;
+				dev_info->csa_size = shadow_info.csa_size;
+				dev_info->csa_alignment = shadow_info.csa_alignment;
+			}
+		}
+
 		ret = copy_to_user(out, dev_info,
 				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
 		kfree(dev_info);
-- 
2.39.2

