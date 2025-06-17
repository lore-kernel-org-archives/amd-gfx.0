Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED05C71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 09:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F33510E582;
	Tue, 17 Jun 2025 09:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TyBNj4cF";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B6210E579
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMkGXZcDRjgTQzKkr7DSupoeaNKQsFpFgs0KLl4ui9ek1+rZcDGGIB29XK1N6nfbe5+dya8O72MN/Py2REtBtI/5xB3DXVofrloo+sbULKAn5VggC2kbFX2M50XNrEnlaC8xmT1LHsFpW4LIQOYEiCnSqAR5lptIO6p8XzbWh0aToSCxDWTc0GRyFATYdMWwPEk4snA4zJOOY4IBBnXn9N7LTVdbXxFspZk5q5S7sNZtuS212nE7LF2SrtkTi9nck4H2l1TbJGvX3rztXoHftc001TbTjDvLDfye4VqXdYB057WThS3UFhkcJuj4dMfqUrGZuJgTb+fmVobdmiZ8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=PXagXFzjo2P6rbzO9Xhqb7tc6+iYoKkTF16Pc4TjFokKaa+UEp43ISkb1nK2s4LHzAt+DeMN3kHZG9jfwj8nmGMWinmW0sLVSAfQb/wgB1il+KQVilUc9kl0Sc2QdRhfTJ9j4O5EAy4Zk3jsRWBQPQaiqKEvV2JyJT29kMAiKNV30lNqYSG2pyz5yO8Eb/L8FKkFWJW0kJ1VbWYiuZ5BrQb4KuTYn7u6C460RfIoKuzZ1t9y9kiikX5X2IL/uAsPMZa2C+nOllxD1f2xX9ZtUJBLRt8ucb4dwna8QyF1SBw1k1qg2zlLJIIFo3zAWOoYzQJiZcq/zTSiJQ7jdaSw8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWGdxHt/CP3Tyx5wAHMiAawbe18qxt+TBMIIx5UrL6U=;
 b=TyBNj4cF6Rfaxzh67AU+GZjL6YCIc5kFqNXLxLUIHvxvaqRfrI5TWTLdsW4QAPgmeX/nJzbwWEOnT/mfqhGe6xTtJNC7girPHq/4Zd7VaT42i0SdJhgU20TylaHgF3maQozYvg2Q/kH7boooOLs5gslmV2Zf2hlb5Q1sU+5AJsw=
Received: from BYAPR11CA0103.namprd11.prod.outlook.com (2603:10b6:a03:f4::44)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 17 Jun
 2025 09:23:05 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::d1) by BYAPR11CA0103.outlook.office365.com
 (2603:10b6:a03:f4::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 17 Jun 2025 09:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 09:23:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:22:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 04:22:50 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 17 Jun 2025 04:22:44 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v3 1/9] drm/amdgpu: add user queue reset source
Date: Tue, 17 Jun 2025 17:20:13 +0800
Message-ID: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5951f9-80f1-46ed-03fe-08ddad809063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JAxP8YZ4EkwUq2nhdFYVj87OfikFB6RMKpHxXuO/QC3Y51WpoccK8RSt/fJ2?=
 =?us-ascii?Q?bZnPGt97U6OL8zSSLColt/NR3gNVhCJR1x6aSgJxCOdpKnUlOo/OEORn3Lna?=
 =?us-ascii?Q?bJEtSotiMmufcmRzwRm0THb3+QK0luIzDmwL5AOTMWhsHQ7WDk6ke27sHhZn?=
 =?us-ascii?Q?nbE6ilfhHjKoX7uQw8P65kkZ6tHYo0EKnaJzErbCMISPLpamSoYn0cH6H0aK?=
 =?us-ascii?Q?Wno2RYhHp9SpX9qUgeEAuKYDdpJHUyFmfKsYjGH2Lve1xekGWQEHcCSRcvnO?=
 =?us-ascii?Q?zusGHZbmn4zNSV+hMeUqMNrMeCkw5lklQbX8PjdbhaI2fPhhqPjD1rYUV7TC?=
 =?us-ascii?Q?HsybV2faEFuHcyAQB4rz6dBWYWArtKpxdYmAEkehEomwzxFvYsr69VAJN2MU?=
 =?us-ascii?Q?JNKSZR7B9S+LX9jEJh87syXOz5555I2VOBYbOu19EU77qm6DivO91WGokaDO?=
 =?us-ascii?Q?Sewtoj13P3wCUeRbSxbU/b5BpRjlsC2JQG8XuMwH+i84JxUYLFuD42niGHab?=
 =?us-ascii?Q?HcvwBn+73S5mXT0+UhwIuZPYBctIUyJGfH9b5hlgsgqL1TJtW5jGIXP3sQUX?=
 =?us-ascii?Q?My39CAqqXQqO1LdaApzczD5QmxWDKlDWM3EeaBL5LxHYgBxPVXf9xT62c07N?=
 =?us-ascii?Q?YpkCF/SFengty2FuvCSnXFDIF3RWZ64pawamd28xmU3LxHbn9d2FYJdc7pUa?=
 =?us-ascii?Q?/WGQrGGMRvbpvQ8nADbpipiFZzBSsZ0ALJB32dDfiiB1rAavsgNhJhgJbyWX?=
 =?us-ascii?Q?H03P9PF+x6RJFAtaP9kgA8qo6+7SPDWqVAls9yBWVhA06RdLJ/iEInLg+xhy?=
 =?us-ascii?Q?cU21JjiomukbpKdpvJud7VLdepAFNOhhI659aWbUQ1AeSKDFjLAc2IZxMlaW?=
 =?us-ascii?Q?csOqitZDwn5iCV7RnbjWGTMYzpbXQ4ClJaez4UQfod9k/hvOPk81jh89r6Ar?=
 =?us-ascii?Q?x64VuSN/dg4rKyLEaILR7mirABDiz3TwfarBbhKYJWOK9C3kJSRvA7YCE5FU?=
 =?us-ascii?Q?UqIWsOZ8SLNxtwdbLltTvpWPRCgjxrRlIdUAqzUK04cbQmu6kfz2x+QV6SNW?=
 =?us-ascii?Q?g4z2BEwMs+2BQDDHqHwUMSoIK43i3DQZ+2TkzBpEwUiMQbDUmM7Ak1uF8bAQ?=
 =?us-ascii?Q?ePv4eMSjae6O9sEH7aILtaKVuub01skaJ2YrNczMGoHVdyMeT6Sriz45YwtO?=
 =?us-ascii?Q?KUz6S73gNEyiS+Pvm9Eat1nAYYKIIYYSO+GGp4/DQgqo6onTnMcMT8dCvOUz?=
 =?us-ascii?Q?P41uwq1PgURdCe0829RdkQ7HJuMmdUEjCoqO+/7iKcdzUGgArBmXvSTF+W03?=
 =?us-ascii?Q?9DG0XEQQTeVtsoamN6PAUFIjRWTNRQtSNa0kpmKGzVOWvmakk9xiS2zqGI2W?=
 =?us-ascii?Q?PCmehJ3ymrHsUz8vviMm4BNLyjvljHqUeq8uGf+Ww9lXQ8FBmf78HM/QNDCo?=
 =?us-ascii?Q?SpzOR/nD31MJWNBl+mZeqZbkeGmfZP/dR3/KWSD/gZlFtgZj7MqeARDmUD5A?=
 =?us-ascii?Q?oh/Tkc6jXSFQNPajvpk1SucneS5Qj/RbmzBG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 09:23:04.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5951f9-80f1-46ed-03fe-08ddad809063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
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

From: Alex Deucher <alexander.deucher@amd.com>

Track resets from user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

