Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BD2C7618A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 17:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBDC810E61E;
	Mon, 20 Mar 2023 17:38:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B733610E617
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 17:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GI0mxeFzalFACj8/wO/4Fcu81POvlOJzXW6DF5b+DxTK8JEO/lqE5hTP8PFO+X9vkQvzFG/IvvmjpqZPkKfVNiUnVM4J+1TFaoB0eZZYi1Y38ToGDOZVBJsVHmsD5TmnHEhtyoSgTD2QIzrhTzJYjKYJ77HGZNHKtG3ycNGD1uHiepBhq8FL2+STZsbK7LzWedwL5Ivaq1nAyxR0YDIIGDYE5cYo0ZUwrDdRncF5tfgQrFve7TI6/9x667Y8VCNjdq/cQI6MArhcM+Sc7lspoj4Hd38UwSA2AhFMwddsc7Q8p0N/kwWvkOG67wV0+XQOz3CLfBVRTv3LZ5FRwxHzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0V+P6JF/7mrp+OpCfRuHXGAhoRlMgoHX9KUNheIHKpE=;
 b=aZU6Xg1wWoW8yIeJU3q7yoOlwWUHedE3Og8Yj9cdbb/kr/XfrNwPxeNQ3RyTu+xnoU/TyjJotzfXvAhp1nw9+UvK0tr+JFP71kBV41Tos6GgJe6Q6qRXkWKGjPqbn4WRPwce+FVJy6IfX3gaKSUcPOzbh+/kgIz1hP7SF2wkbE/MN5darlXQKtHxx8OkSAmpH+i8MTeOZlln+ZDZH954ViRDU9t1MzN8gOSw9y4vUx/k0yP6pNyDYXOVuFy//vg5FHGyzH2mLW/4yRfRChsNO3m9+6uhkFiKIN78fPFgvZ1U8GJMIEypMXgR2xMVVHmDLY1akrNIufL9fcKuxDaNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0V+P6JF/7mrp+OpCfRuHXGAhoRlMgoHX9KUNheIHKpE=;
 b=TiMS55u62Y2e6SApn8Qwe3q5AX7OCxHsHCbM9RTQ4x2g0e8axHN5bCFx9iJ25Nq8T1OkFORPPfhzVfvdQlJvkfOnoY3aEPQzBofKciyHlV1jfDPh0/x/2iwbhEeSgB1z/xLCmfgdoH+wLugyv38Knuu2zztc0/6Aas71qgffIVc=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 17:38:34 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::5a) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 17:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 17:38:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 12:38:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amdgpu: add support for new GFX shadow size query
Date: Mon, 20 Mar 2023 13:38:09 -0400
Message-ID: <20230320173810.250835-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320173810.250835-1-alexander.deucher@amd.com>
References: <20230320173810.250835-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 989cbf4c-b5a7-4a04-8f5d-08db2969edc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YNWl5IeX2x7KikAkxyw4V0Pb9c+p+1nVHcKOfKCJDPhPhBPVIjMnabYx0WumXc8jQRwZ4qJswR3vUNOGHhiwPndFWKT4dv+SA7V7d1HFXrQWMkCEOXlZQhpIzL39mB+qRyzYncQ1/FPDwQrEDhFUU5GtTW8aCpsILpNJwplFOMU/sKRakLsFYRITRMi5FU0iUAs9qUFwhjbqA2ptCbBINz7bCGx4EfFRjk6YGnDR8UYwX+v5uFIT/37y448850Bk9sdBXTmR6jWA/YH5s215jxEtV+B6qNtDKzbqKZmskJBh81Eo55KoGpNbVsteQH3W6D4NR2vukU6kNWt0aGpzsMi75PTHzIVuAFu9XZ88Igwl9F+U7w4Js2ThWVAlibwc0KvMULzgeoL05FF644OXs0D8zzvzciilxtR8gm3/uxiU7oAFfngRIDeDMkYBRjA7BN9iFP6c15x78BeeQWVlJt5qlxYRVgWhSIchwf26AHgw6lXZ7pRKwNwhros5n/8xLVaLOwxrqn8zavlrI51sQDMgc6xFUiHeWI5GddAjcCJAj/UXaNmeOHcgJF6tmH/ThahazrhlIhOKkL4K5QrAO406LN+XI5o6gtW5UnrRg4iMM1Z+cZH2AwdRvmEb2wQfjkD9wuepezc/h87qGUnrhMvfbrjoqRyngH4cu0C3Eb3QFWbxkTLqhnlqVKLuWAfp1VMyCQ2A+GNr5cbzf9Wf8xfll2VSLFGdRcJzd4JXy8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(2616005)(426003)(47076005)(83380400001)(82310400005)(478600001)(7696005)(316002)(16526019)(1076003)(26005)(5660300002)(186003)(6666004)(36860700001)(356005)(86362001)(336012)(81166007)(40460700003)(82740400003)(8936002)(2906002)(41300700001)(40480700001)(70586007)(70206006)(6916009)(4326008)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 17:38:33.8921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989cbf4c-b5a7-4a04-8f5d-08db2969edc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9e85eedb57d8..8a6764756dcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1139,6 +1139,32 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		kfree(caps);
 		return r;
 	}
+	case AMDGPU_INFO_CP_GFX_SHADOW_SIZE: {
+		struct amdgpu_gfx_shadow_info shadow_info;
+		struct drm_amdgpu_info_cp_gfx_shadow_size drm_shadow_size;
+		int r;
+
+		memset(&shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
+		if (adev->gfx.funcs->get_gfx_shadow_info) {
+			r = amdgpu_gfx_get_gfx_shadow_info(adev, &shadow_info);
+			if (r)
+				return r;
+			drm_shadow_size.shadow_size = shadow_info.shadow_size;
+			drm_shadow_size.shadow_alignment = shadow_info.shadow_alignment;
+			drm_shadow_size.csa_size = shadow_info.csa_size;
+			drm_shadow_size.csa_alignment = shadow_info.csa_alignment;
+			drm_shadow_size.gds_size = shadow_info.gds_size;
+			drm_shadow_size.gds_alignment = shadow_info.gds_alignment;
+		} else {
+			return -ENOTSUPP;
+		}
+		r = copy_to_user(out, &drm_shadow_size,
+				 min((size_t)size,
+				     sizeof(struct drm_amdgpu_info_cp_gfx_shadow_size))) ?
+			-EFAULT : 0;
+		return r;
+
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
-- 
2.39.2

