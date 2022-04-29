Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5814DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A7010F3BE;
	Fri, 29 Apr 2022 17:47:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7288E10F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKLV9swNAfbq8jKucWWBfIco9XX0W5BFccI9n+v5xs4xk9nFDmbGUfAdJ8VQ0QNA2J6JO/2F7RarEHKhlKrOmTqYXVf1fdoT1PF66SaJoppcYi1UnLo4XKra/KEcruz+iGGHH9iSlI+CahSdcb63OgqFIhOaaS5vzHpmln2yx3vAh+r6VkS0qMdHLEXUov4cef3X5r5scub+AB/DihZmZ2LPfIhIw3iHCORIleuE1D6sW9TFHZeb1BALfnECQQYME62ZfmfncOsbdhnQgpeXD4zaAMaPDcWFempynamZwaAOcfrvcrdTvmtDItFk3gK/lGOcBE66QuIZdStrti6tgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUGVt7ucSY5edroCc5kvUmLHRaWtssG0GrX6iz/HbTE=;
 b=IqNsjOESNjSNy0Y8+LXCTKbjdMjbB58O1TKWFD+Xt/dfm7bOcmUx4uRwbRH9vqomwSDwM1fZPTqSt6NmkVeU3KPcNmVpJ+LBWuGjInM8wYqa6ZiKPQQr5I8cKdvxJuTN0Z0DP7KqRJTjHzE7xfIEIq/wyb4yT2XH2OLe3MNIhyyvc2J5F0fn+2qyi+0vwDrBmn2EPlSXEp8dBwQHbDHmWn7QbMP00suXN7ADwe44nIzmFuRabtljWAyFaCw2ZTl1bWKn0CoHvoO09er280uRR1Ry29WuS9YV6zksJtQpZBZFgL9qDBwsdm0TBvt2dFWPm0orjbcX+nrcaTGctnwXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUGVt7ucSY5edroCc5kvUmLHRaWtssG0GrX6iz/HbTE=;
 b=kLPSR/TieLrxgnlmZg2IqUrCD2IESXENJR9CSqX0enCu6htEJO/FWqcATs5E1i46mlMSEu521+KRmrKrHO0J6MP4b8g2BzQZI4I6UlUbNNzN7HOUP631ZuJJ+7LPunklUQGZu5OGPH9kcvOQNvcP1Jh2haoAtYM09YayiNS2M04=
Received: from DS7PR06CA0018.namprd06.prod.outlook.com (2603:10b6:8:2a::9) by
 MW2PR12MB2394.namprd12.prod.outlook.com (2603:10b6:907:f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.20; Fri, 29 Apr 2022 17:47:00 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::3) by DS7PR06CA0018.outlook.office365.com
 (2603:10b6:8:2a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/73] drm/amdgpu: add mes kiq PSP GFX FW type
Date: Fri, 29 Apr 2022 13:45:46 -0400
Message-ID: <20220429174624.459475-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e022af2-7976-4598-5c20-08da2a08431e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2394:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB23941E7F453AB9DFD3B12341F7FC9@MW2PR12MB2394.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njG+xTtmHEP5B4gqHfU1HjvuBde4t/+eTA4M+SEgL6lZniI+6mCDPBeig+Qe7jQBC69e4+Ed7kKjzidNTNgFVhnAO6MrO7gZM8KrdFsLrdadYOshf/BRt9nP3dPZMuXfT4b6xTwiQOrOIGteE/6Gyo61AIYzvHgH48RLPoylylsOEBficOyiUNzA/Nmdgbm3yithxhurfio43qmUb4eTWKr1VpaMpAj90m49GtYay9TsldRTAtfZ0Sszifu1XhN2EgUQ2n+TEW+KGDnuTPi6CPQrkJeaTPqAqsi75edKoy1udvAUv5yzw3W+30jtgB+yrjNJsIwuq6k/XvC5hGrsxtywztAZ4q5gH4+6+/Hc8JRz/Y9VySlUElrEnl8zwP73zlH/e03hqyYobWR6WqL0w+9UTdHJdc+USAYf5oF20g9ptTUeuY5taLAfBwL5y8x5RjHBWOTnFYAWlWKCv6kNalE96neH38ULXD2TtSLyDiAStVoUR+JhELAqC2Ng6E02qIvqiBwqKNdDZYGRWXL3BBhTgBL/m28S6aK+IFijto8gH5cOHHFaW/GEFjKrW5ZWtpMhNi+UrmZZh1BxE5kPWWzSFJhnNOurhMdCPmaAUYpvd6zKCSmyc1TQpDTDWoq80gPMP3oJF4ak2JXp/b/xmCEbOsVSdAAWhXZXFJFW+x3fsLpKm21L2wAKZkS4eUVZynXQQu4bOZNwxYLDFlj43A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(356005)(54906003)(86362001)(40460700003)(70206006)(7696005)(8676002)(2906002)(81166007)(4744005)(186003)(316002)(16526019)(2616005)(6916009)(1076003)(4326008)(47076005)(36860700001)(8936002)(6666004)(336012)(426003)(36756003)(82310400005)(508600001)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:59.9577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e022af2-7976-4598-5c20-08da2a08431e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2394
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add MES KIQ PSP GFX FW type and the convert type.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index aabb208bebde..d0fb14ef645c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2190,6 +2190,12 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_CP_MES_DATA:
 		*type = GFX_FW_TYPE_MES_STACK;
 		break;
+	case AMDGPU_UCODE_ID_CP_MES1:
+		*type = GFX_FW_TYPE_CP_MES_KIQ;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES1_DATA:
+		*type = GFX_FW_TYPE_MES_KIQ_STACK;
+		break;
 	case AMDGPU_UCODE_ID_CP_CE:
 		*type = GFX_FW_TYPE_CP_CE;
 		break;
-- 
2.35.1

