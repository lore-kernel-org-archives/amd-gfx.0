Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D85C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AA510E4C7;
	Thu, 23 Mar 2023 21:41:03 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790DA10EB33
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYfyO0ksViOBd+PVC3wxwyl+XsFHudDpSGFROHpJfbJyI+nWkfUMEOgKnUIq0xMT7hl8B6P1rh69ccEz4UtoH+BVBwHGOhwgTSiN46kuPMHoFqkNyVf35asyeX5G7nQUnEkRtMs92ZecEuZk8uS5lBrtLgv5Q7UUnpP9AnSFCauB4TfIiVz8HgQ+gCKrfW7YpTpQvhljgs2KKu1mWFangyeNa+Ct+Sx20V31ORYwkMjbw7elZ2t/no3xacdG8T8fzFyXIPN/wQzcvwKGYnyj5c3Ly1l8lWskHw3KaOHmRFSLAJHcskmawEKH3/JvfmiVr7n/5gG6SzbUqcDcMDvxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kvKkgaMUcLBtZzDTlleeoCCqYv/r3NCZJpZmo17yD0=;
 b=IUgzH8kig3jZzZTiCY/f/frPeaDiTwV4NSc6IoISFd8Z7i9bAI+U7hZOaP+i6fTZTkYe4QAdNC7ulKN5uWSRJ5o5vDSw0QhBRvvEceiVY0BBokOFLpOQ869a+ncZ/Zta0AuSiigxryPUd+NoWKUnbA1Tyfs+KPC2qE28YbT49ghy7ke2xDAaqpJvEmRJiUBU2ohEQTG4B2ePiFTh8lZ9GCZh/y08KONVRTTawP8/05g8tZ/nfL2ThmiL5mWhmzdI/+zb/G2OFHwVTM8DgK9f2igE+/tcAttxtFQJvXXdbYO9c8HvHYYKh+mi9jqM+hYpW38Jt2O93Pk4Ymxt2H7GHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kvKkgaMUcLBtZzDTlleeoCCqYv/r3NCZJpZmo17yD0=;
 b=vbnqyU4Fy4m9wTqexxqkGRG9PBZD0PxQf5HhLvFUFjzdxjaBst73RmF1Q6Oy3CE98cQPoEZeqSPwq238SYmoRg27DIUeg2pTyjtbfM2JMf9Q8JLJzkYbbHfhjSDx614Sv231dQczZ2pO47rCFZmsnKrANDqkjMezLscyseUlWiw=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Thu, 23 Mar
 2023 21:40:52 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::3) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amdgpu: add UAPI to query GFX shadow sizes
Date: Thu, 23 Mar 2023 17:40:28 -0400
Message-ID: <20230323214034.1169310-8-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d63eb0a-0271-419c-a7e9-08db2be746af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojhbI+3iCSGaDaMmZzjoUDklUrYgqWDaWAmhgIUw1rcdvyaX6TqnKFOhC3KNIEcwNyckrqLuQeVITEC8P009gWFSaawVUpSXVw/rrN2xfJCQJHDsmhkZHYt3DpA/9JiWApGyBtFZZCjKA8tGdfmQDM9eA2r7txF5z2dQtX9Wg0exHg2Lg4YVCorzBUDSvcmCQbDvTqPNGKIp32TbCXey2gcE8QMXpiT527shjjfoAKnX72wf/CA72ZXIU8kEdB1CcS02CxLh7YAuGxvPOD+Cw8gh4eThMzCfb2DXqmmdZz6+sIjDDTUMGHOJW7/3/lZegzIpYeI4Btp8A7YTBnyKNVxwVfq3rKyLG48Vfy7y2eR8RewC3D2s5vQoHjlxoVJMBhlHVv9yxVChxEjXpnbUfOFyJoO2fOa6Z2xHQMaCoQHJIcGJ81XfAIjrBW8U0rGiWSXa+fCkKRjRFV4d7cZlcn2l3hMy2wJ2i039alnT6tAOmxKb8zfOQoelPy9UjWdQcsYq8QtAEhsdd7yqWkh3dDQhdiypUDNXJaLwozUlLKiJqsGY2W83LX005RElFfyq0Bb33aPEUt2GYZBf7ZIGwI9Risr7w7/7udmNFrWTBx8Y7yBjTM8EtsmcMnrYKcod0yVXeFQIt43AY+ZRX1DR64U/xIRMQjr7xGc2HChs17p164QBv9t+pISZiw+ngoHWfg9qb3IZS5Aa/skuTUNUAjclAEFqPAEs/QCh9ZLUi9c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(82740400003)(2906002)(81166007)(41300700001)(8936002)(40480700001)(82310400005)(36756003)(86362001)(40460700003)(36860700001)(356005)(6666004)(47076005)(426003)(7696005)(2616005)(336012)(26005)(16526019)(186003)(478600001)(1076003)(70586007)(70206006)(8676002)(4326008)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:52.5632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d63eb0a-0271-419c-a7e9-08db2be746af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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

Add UAPI to query the GFX shadow buffer requirements
for preemption on GFX11.  UMDs need to specify the shadow
areas for preemption.

v2: move into existing asic info query
    drop GDS as its use is determined by the UMD (Marek)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3d9474af6566..3563c69521b0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1136,6 +1136,14 @@ struct drm_amdgpu_info_device {
 	__u64 mall_size;            /* AKA infinity cache */
 	/* high 32 bits of the rb pipes mask */
 	__u32 enabled_rb_pipes_mask_hi;
+	/* shadow area size for gfx11 */
+	__u32 shadow_size;
+	/* shadow area alignment for gfx11 */
+	__u32 shadow_alignment;
+	/* context save area size for gfx11 */
+	__u32 csa_size;
+	/* context save area alignment for gfx11 */
+	__u32 csa_alignment;
 };
 
 struct drm_amdgpu_info_hw_ip {
-- 
2.39.2

