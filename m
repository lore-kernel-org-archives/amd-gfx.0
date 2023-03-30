Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670EEC761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B4510EFB9;
	Thu, 30 Mar 2023 19:18:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33CE10EFBC
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHLQ7U/Xw0oTB2K3KX5hgvM6lPEt4+0Hsw9b9ozXSHzZoL6F8+icZzTHYHgx9AlkoEw+RR1kZjew3lSeLnlqg0QEdDIB46kp1DhvzzsU5hKdsUeesqIUwKUQpNN/gTj1iFhtYPJfbqbLdxPm64egJwZ5QgHWQrgKAZuJ9aSFAqMdN2pGdZWOIpT1oauMBUpnLuXdmbqjD0Mikp8EVWM0GRkXsj2UUiclklhBeEluMNRs64lVNmi7qOxx+/6qvi+oXswUYIMDXtk4RbQGPKzvvKfMG9Jx0BKHC3QuSuWbfaQw/rmHKOAZ8zQzNNLA5EQBeQEd2iBkNf5BHwy6W2zrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hpazb081GZq7uVg2fr2+sIlSSbx1wOblUHxjgV/nmo=;
 b=QQ8+yVnASWDqBj+Y4yZBNKpl0eWFXrF11ysSXFysnhzS9ppUfPzmY04ZPUojZJWmyGuTz1X/bRkqIDCewMzAiReveFnxSe7dSXpbJXM3PNpMJ84AbrvW4Tr+ysYe+T+rspFRNMNHr82ZSukyJZyLrhUvNRfN8oEa84+Kezpu4ruY/aTNnAtW9ipk5KUW3GXqR1SEpgAtY9z+MUwO3u+2aUTS6p+w0EwNF2vaj1O/6RwtrUylPM3ppjnzQpynnRpMoIuHYI2Rry6M18uU+0SRyLWQXwkeE5DM8EvPqWuLcjOL0sc5wJa5c4XDD4qd3jaXP69D5n6AKSHyuXwKhhhm0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hpazb081GZq7uVg2fr2+sIlSSbx1wOblUHxjgV/nmo=;
 b=nbhVIRmzuJRCGK77SWmjLiybSzHs21Wzt+n7P4K8WEgSUJcFHG+CS1m078GKjpPublRNH/4ZsFSaCCnGNVyTJ+uwVxFjoyB0szHM/mdxBtCRmCUx/OfavT4fsDfn/vFEY29C8yVAar/8KpMHh0GJdzeqdcnkqJUJML4WaSUIDQU=
Received: from BN9P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::11)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 19:18:09 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::a3) by BN9P223CA0006.outlook.office365.com
 (2603:10b6:408:10b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amdgpu: bump driver version number for CP GFX shadow
Date: Thu, 30 Mar 2023 15:17:48 -0400
Message-ID: <20230330191750.1134210-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d659b54-1980-4d81-997a-08db31537f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPeIcAKRV9pkI454+oKCaIwo69gn7WDWtZzfeCOYv0dz8FxTWbXKIqOfaU+hTqBCFDeTHqbvI7Gj9jal4rn21e49k2yltO7ER7oaIW4THPFWxq189vRfpP7gP/n6n6YHVlEfrgWxuphs2ZGv7YOb6go+zn+0sRtHqxFBp9gLAaF0aEFJtCDQAzhTT3HGTwaSYEtix8LO2pEDUIJVl09O+KPmAGo0yjmxS5uFF6SilAjXcp8gmODTqQHfLQhnQlt+jdwYKpMoTr+ygx+eRahP127MtRwD0RGNsG0zk2iWD+EMmJkl0T6b+kQj3uhZB6g9PJook9aBsYguU+TTUyzk2a3YLbsS28jak2HI1UXjPbOgkjqUxDYhHgv+/HyPXkUUYoKo6A6132BP3Q5OIq7mUyRnoOsKBLd379vcmdkgsOaZX72TTVO9z1FsyKfVLEcBkKZN32HjAu3Kq1kD0ZS5uSMFs12mFhofVF0atVfceU57hjuNR1WMcFWJUjTj3ffxo+xBAMnKGvVBUI6J9o+hr5rLwnArlAo/eHjmOBbESdufjX2KTBwRpWqP3G9xxb5lJlAMPUn0taCyxLPWFeGJMOpDbCMondi16dt82OVWXwsEgblmFe4QlSz1X5J4DRDHQqmRQQQt9WLqtcB/BUYFNQEkzIEbX/9HIIRG6O5WURZN7+8ptGovhQ2g9q1tLLeQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(70586007)(81166007)(4326008)(36860700001)(6916009)(8936002)(70206006)(8676002)(41300700001)(5660300002)(316002)(82740400003)(186003)(356005)(16526019)(336012)(1076003)(426003)(6666004)(47076005)(2616005)(7696005)(478600001)(26005)(83380400001)(966005)(86362001)(82310400005)(2906002)(4744005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:09.2221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d659b54-1980-4d81-997a-08db31537f66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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

So UMDs can determine whether the kernel supports this.

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21986

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 917926c8dc5f..c35baee082e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -111,9 +111,10 @@
  *   3.52.0 - Add AMDGPU_IDS_FLAGS_CONFORMANT_TRUNC_COORD, add device_info fields:
  *            tcp_cache_size, num_sqc_per_wgp, sqc_data_cache_size, sqc_inst_cache_size,
  *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pipes_mask_hi
+ *   3.53.0 - Support for GFX11 CP GFX shadowing
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	52
+#define KMS_DRIVER_MINOR	53
 #define KMS_DRIVER_PATCHLEVEL	0
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
-- 
2.39.2

