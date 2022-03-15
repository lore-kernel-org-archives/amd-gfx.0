Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0042EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 17:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20D510E149;
	Tue, 15 Mar 2022 17:09:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9584C10E149
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 17:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WryPM6zNNDX0ybbYyKyTE0xaIYDsTF/ZW1FqgfrWm100x0xo2qiqWOBeSJiR3GbmH/kMlo8U5qbFpauDTUjiejXvq8zihGozK0DwaWCI2wlAyym726s5KDz9FiMlvqP/u4E9rRfF4fifMOxlu0WbAf0lb/7Kx8m3yG8QqW3sExJRH4LG9ivdbuF8DcT3g5UdVb+kU1xRBijTkX2T2qL8hGACOVsOPfWi57LNj4XqFlEQ6vIfY24cdEJiiuqUDKSV0krOHAz068HUBft7ebvB08xLk3Dwko4kum2ZBTtzSGfXUS/0w4VM1bdaHIvt2daoWsuBlvGY1URkYrC2COS6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpfTcJ6B/L5pK8P2qN6MtlgHPEbFjkxej811vCabnqM=;
 b=ie7m3QOyQSot5CYCkEJK6RZ9OA7ZjzCwJsKXizGit1B8c2s1NuYr28o02p4JEboQb+g5qrGLl5mwhUHhg7r6AzkCuyX5wAoVZbdeuiiRNumJ+zveGNxvgSBKHmzYgHrcu01ljXlyMyty1qbLt0uyPzQbKwCNZARAVfIPWJAmLwYHEO8NtOP3MyhKt8gL0tm3SE+T4dXFnP42oxRejk9yb1EHg1qMIYD36c+oqb4x6JTirk4NpxxX5uuoF514HVnXy8/6xMQghDgzDUL2kb3uId8bYXkl2ByLm/xHKBXlT0d153FOHTmDs6PuIzg0V9Cck2hGZmULDnInTW4VhMk7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpfTcJ6B/L5pK8P2qN6MtlgHPEbFjkxej811vCabnqM=;
 b=bfg0vRB7GSs3daO80nbRcj2CFKx1iJVoJRbyVufykj3den2hAph2zpU0xHiSqbJ15oNH6pexSYSwB53NbKsfcR7zcsMxE2lh3LbSuXLr7CS72vindaToYPxArEDdwBUTLvTk/HpLSe59wWv4NdWYsMo7VSMA5OEmMytv9MAsChs=
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 17:09:28 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::92) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21 via Frontend
 Transport; Tue, 15 Mar 2022 17:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Tue, 15 Mar 2022 17:09:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 12:09:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: make amdgpu_display_gem_fb_verify_and_init()
 static
Date: Tue, 15 Mar 2022 13:09:14 -0400
Message-ID: <20220315170914.2804385-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315170914.2804385-1-alexander.deucher@amd.com>
References: <20220315170914.2804385-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd1ef3f-90e3-42dd-9005-08da06a6907e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32119DF36F003E74CF46DAB8F7109@DM6PR12MB3211.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4L30Rg++vKatmg4wLKnUY2KWprTnd9/fFy9iBMzAJQoUzjKMLWRLqx39pu8L0SUZzsnkOFtl/GOlWkBCgmI4ahx1VmNU2aCyi3YfSU1RXmEwuNufUzvzlWco35Er4eOzfV4g5zfHRr2WkljISg5x0QnnPXzqeusM3yRSbcGQTDDBLbpCPGUDTQSBQSL2Eig4U5Ie26foxmQCcC4c21xBBdgTGgfWSyl4C8iNAljkExYZEp+QF0Ijr9xg/YBnGEeNAPoT8xdqRJp8+PodPwkKVqJZASQLDUMCvypAbCfxP9qYXLhQaN8awdH66c5QQsIqOOJw08dZttEErTUC9eGe0oSI7RARLZU5LjtuPot70mbIP/x0UEdfNDMziyy13LVOzjG6lKb07zoSEot4JodEwd66IFttangF/tbNlG3G/wz84vnQaZ0MDP/icgnKvZJ2rwPFNAKlq6g05dopDzIr99I8cA0w8nfI3NZAnnJtFdI5LT9vcuQFpFKhIgnljx6nwsY+6ZQciZz+erU0sAor4MdvYEkMMEyUSonBDQZXE0t6ULKdG5vAp6SSmy6d+/A7ZYtUsX1dZsBN41zcbKYychPeQhelpLWOdwA+JjHFXchODBQElOP2Pw2Db3n0BPSchc+w6mazUehPgtnn8DY0a2swxHzS3H/at+USmzoSwNXg2vvXZn5O9IvyUYBStV0Dfu6EaE4ro5VFh82S+2/V9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(426003)(356005)(336012)(26005)(16526019)(186003)(1076003)(2906002)(81166007)(5660300002)(8936002)(36756003)(4326008)(70206006)(6916009)(70586007)(8676002)(82310400004)(316002)(86362001)(7696005)(40460700003)(2616005)(47076005)(36860700001)(508600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 17:09:28.4272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd1ef3f-90e3-42dd-9005-08da06a6907e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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

Unused outside of amdgpu_display.c.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    | 5 -----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 6af7a5e9b28d..d137f2c356df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1042,10 +1042,11 @@ static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb
 	return r;
 }
 
-int amdgpu_display_gem_fb_verify_and_init(
-	struct drm_device *dev, struct amdgpu_framebuffer *rfb,
-	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
-	struct drm_gem_object *obj)
+static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
+						 struct amdgpu_framebuffer *rfb,
+						 struct drm_file *file_priv,
+						 const struct drm_mode_fb_cmd2 *mode_cmd,
+						 struct drm_gem_object *obj)
 {
 	int ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 2d2f01eb2521..d794d4a15774 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -592,11 +592,6 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 			int *hpos, ktime_t *stime, ktime_t *etime,
 			const struct drm_display_mode *mode);
 
-int amdgpu_display_gem_fb_verify_and_init(
-	struct drm_device *dev, struct amdgpu_framebuffer *rfb,
-	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
-	struct drm_gem_object *obj);
-
 int amdgpufb_remove(struct drm_device *dev, struct drm_framebuffer *fb);
 
 void amdgpu_enc_destroy(struct drm_encoder *encoder);
-- 
2.35.1

