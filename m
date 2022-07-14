Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ACCC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 22:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D097510E900;
	Thu, 14 Jul 2022 22:28:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8593E10E570
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 22:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkiN/yQcBV6kdch+HzCvcYphQobFKx5/e/H3U2cawPwj0NUtaYUIiEbotLRhaLqrQfC5Li8S24ZT7h6KQ12qXJK008K976EMKN4SlRXgrocH7dvIgLN15Q7UfrXapl+uXbtR/pGhhpvxc0ee0WEI5cEtMJu/ZQt0UsxLHlPzAxsyHIwXBizprjAfJWMzaBfVfZKyy7Mag8+cXxW1ajDbUXAVRJyaGHAO/eqmHMnXHkGE+ILtmr5x+YQWagwE5IUxQZxc6+DOcoCB3mEa/NnJq60ztA86ek200D3/lPFrxQoI3ZxppsBiPSPwH0PhDYviK37IPLRL7qyALAldr2h5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGVII6lOFJJzUlCdIX8mJY6EcLRMSF5ImJiyUw1zaxY=;
 b=NDj+hUNUR3qH3ITc7m9BntSy6d8yF7URam3GG7m4YspDVxqVqs48utkxb3NmkC3tsz+jXolq8f9KtQ6Ti9pGhhCK1OkQ99VbJwrAYVzU+9yC0anT272cxEucn0lS/yTh+JSf/W8+AzV7EBurmajIWuzkIDSITp7PbHiYCYK5HJdfDTraZSpTCmjn7IxZkuJwkzmgQzGfoHO/aNiP1cHBWOeswtGiAiINrVctuaMM3zBXM9Y9ElZridcaVzvxl96le+fWpDrGEWi9WUj/S8ywYlR07HeyaKT4WpoWE62043yGd3NGv8lKmjc0eItYk8ItLJNr8e+D/zPLNRfoOZn4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGVII6lOFJJzUlCdIX8mJY6EcLRMSF5ImJiyUw1zaxY=;
 b=UdDwuX+p7a2pECFfInqoiJkBeQqB538oglCbs3ZYu3hkhWQb6rtMuAtbMkkZWEETVxAfDzTAK7t6kS6PjqWvJGlCqqjW7aRHiVygZMm62qRpNOMRe1VUCnII+9oId0bM6nLZEx5QXlJV3JyCb0xm8eau0h0hyluFzzChZvn1o7M=
Received: from BN9PR03CA0727.namprd03.prod.outlook.com (2603:10b6:408:110::12)
 by CY4PR12MB1416.namprd12.prod.outlook.com (2603:10b6:903:44::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 21:22:48 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::e3) by BN9PR03CA0727.outlook.office365.com
 (2603:10b6:408:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Thu, 14 Jul 2022 21:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 21:22:47 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 16:22:46 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: align between libdrm and drm api
Date: Thu, 14 Jul 2022 17:22:33 -0400
Message-ID: <20220714212233.14571-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2203c7b7-f617-44a7-c79d-08da65df0014
X-MS-TrafficTypeDiagnostic: CY4PR12MB1416:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xXdkhQz/mbSniah9GcR1KTIIxGIvLY6MhQ1Iw7vjKXezA9ix+F4lsFkXERUJHAq8ZBLc8b1nNWbUlaqh31dwmEzqTsrQGW6z/XirYgu7dGd1nEhGT3MJeNuBtYcOp39XabVVUjVhhB+IQyxjeADyAuI4m80xWWps0Lwen653Mwyne1B6t4aE1PDfNS3Jwbu91HuDPjoGna1BHw2y7qlPOqekJQfyiTlVugSCUgmGPDaJHWpoADTRgmDMVBd51/tOqs7B/dNagP3IeJ1/G1M3IHlS6yLiCAQqV8msK1F+K6jgzLxAquL9O9RKwq2Hyis4Nf9jz6G9sz2ZS8Db48lk2DynRQhwHWQJ8MEKX9n2x14gv092XPXzujXF4Zhvkyz9DYjmJiEcnA6vMQnPKsbT6iACKSH9I7ZCuxK4GAzuLOSwUHkSJOViIti2MxBYV2lvr3TUUCWwbpfWkJLQqJ6LMS6vkPn/PxavH8jKQ33Vui79sHVjJv5OxyjDFQImQKq5qf6DA9GeYgpAObHzrBhpyVueL6B+QTji9ZtUjuxueV4DKur9h5xJ1IJdfO2vqWWIEbyTgQw7KYVX2AaoT49P1Z2p6CYXkjhD8uM37HMezEWZVAOUTUiiBrbi/b3TMvjin0IPhSpY/xQhSblKbg0goPzD78EepX/7qAjfMICvV+IY6hiiQfjpB2z+HEnOeQ/Y2rHJU4rya8fORUnBP3n2WKDl8Xv1763rrvfXckIIsrJAysdUSQ4ixLrriZYsucqinTkjgycJ4gkoS5B80Syr2U+fMtqCc9A87u0vJNVoiaRPo0ICPNKaTHNfloVifTUzIOIy1ddDrtMGpVLG3RpjTCbt9JTazYqex9sQPb9B5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(40470700004)(36840700001)(47076005)(426003)(16526019)(1076003)(40480700001)(336012)(2616005)(186003)(6916009)(316002)(54906003)(8676002)(70206006)(4326008)(70586007)(41300700001)(8936002)(82310400005)(4744005)(40460700003)(5660300002)(7696005)(44832011)(478600001)(86362001)(82740400003)(2906002)(356005)(36860700001)(81166007)(36756003)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 21:22:47.9195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2203c7b7-f617-44a7-c79d-08da65df0014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1416
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

define HW_IP_VCN_UNIFIED the same as HW_IP_VCN_ENC

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 18d3246d636e..fe33db8441bc 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -560,6 +560,7 @@ struct drm_amdgpu_gem_va {
 #define AMDGPU_HW_IP_UVD_ENC      5
 #define AMDGPU_HW_IP_VCN_DEC      6
 #define AMDGPU_HW_IP_VCN_ENC      7
+#define AMDGPU_HW_IP_VCN_UNIFIED  AMDGPU_HW_IP_VCN_ENC
 #define AMDGPU_HW_IP_VCN_JPEG     8
 #define AMDGPU_HW_IP_NUM          9
 
-- 
2.25.1

