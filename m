Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D37DC47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D9C10E113;
	Tue,  2 Jan 2024 03:45:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE8A10E113
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipPgnySH+WRbf/7DHJWz71euMLu3MHF8X7L4IEWU6PL+eughG042D58kuu99XJ7yA6WLYyxjUVrbM1gnjcsqMDwUDSniXjbV01MTsUtapMqgCPPjgD/A9hk4euoAA5jFj+3f9Hr/cjn8rcOQxaluYlIFpyQpeK/Z3X6HulLelbNpJyUNxjxZxd9qB+jaywLc46dJsd5CMdtd8rsfNbCFe2iCh5UMlfVeDA6LiQzWM7xDLWq+3FZU05l0Yo8jF46Vr0wMiRVqGDhR6VN0zvSc4tdu9/eVJxDE/nHSsRbMWmxqKb1tuPFQQFFTwsu5qDKYDPYOO3WVPToqAZptdPuteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYccdudRrnP/b7mEwYdxKvA2EUllupHoR5lRme14NT4=;
 b=PIrUninTV6c1SeryAWM91zUvLYiNskC+Ixact/MFVJ+17xKZHVeouL8P8WZxXCIZPp9djPKUdnCm8ljs5eLWVHrPYlNjxjp5xylPN4uhuwDkqCs5NSvlpdkihLXGQVPkDPiKUiJInRh+EupgdmUPs6FXbi8zjWsxSz0lR/Y+kB0pHZpoS+xJBISezTk/I+XcYy6cNqEuXF1MuGxeYl4Q+5HuAUYlChJH3LgEmznkDQNOGF9ZbqFhpKTF9VEGXX9cj3DL6i9kpl6dQR/pbRq6lS4mP5N4A0TVJT+V+sDvehtAa4N0rr9uEWZsfUgu8iUmM56gga/cIwRBEGzhWzCbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYccdudRrnP/b7mEwYdxKvA2EUllupHoR5lRme14NT4=;
 b=A5X54bHOaITcKlajrYJuStGYVz6VYBagm/gepnwPEuj4oDAjKEgVahMbi6f56fYHbf11kE+eHaoc1qcyfQa5G36BTp/kHn+SCJh29xzQjvEaOo8d35Ds7n/Y8yLPTAfNh+jFCpNxAvbU4z3BLfZ+6D4oZaB4Wlp/qURYR3auKJE=
Received: from SN7PR04CA0031.namprd04.prod.outlook.com (2603:10b6:806:120::6)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:45:14 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::b) by SN7PR04CA0031.outlook.office365.com
 (2603:10b6:806:120::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 03:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:45:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:45:13 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:45:11 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Packed socket_id to ras feature mask
Date: Tue, 2 Jan 2024 11:45:06 +0800
Message-ID: <20240102034508.16426-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 470f6421-48ae-40c5-74df-08dc0b453a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3kCgsAvKYGixEcjXaUtR/w6fZfGQ03CwohzAdqHk8b/q1qQ6NAtULeNxTPIsActjR5GsO8m7BvAx/9U7k+npIk3TcqqHR70gdS9eCI3RfTLXdjy4bQL7dloKVLPEbppIyXTNerkBMIEcUcuo1BiXUNH/aaVhVon8tgGbzMVOju6uBShkkdmfmi2A3Bpcfs2sRyK5wIg9RZNXK6DCrZHReoSnMRGQw0h9ObT09H+E6z55YTPJ4fQlk+jxAZB/e1zssm8XIbA8VPNV3hlD+P2y3LugbIQ70RUZ6wT5ardAEPq3tcW4k/ipRlWb6Zo21MHohhdcfHsr+EHjdNvLhp4JqP5yJxUeQJncBwQ1WIRP46iV9OIozOlIMa20GlzZzAUBZN43DM+5mezU2LtKWu4JVSBZbREFkVHKZVkMohrhJVYQbkp9JgIdhI9qmXwi78L2SoKO1ni2SZ7SivIJo+4ZJa83QrpQ4cAwMGDHmgrN/i16v67Zk7VI6Nngk/hDauS/1QFFFg8m5ymCXpp6+KFZDzgX6nTfbGtt5NEDImR37O11NDWuqjjoLGbYeOvAUD7geRCd3NN+8ymAED2KseaZaAkAD2EJ2cq65pM6GooxEJ0EBUgvGMhU7rBqAnLCeIsMa1aPoDBIQWj/7y4/Nk8OuoZ2JMdNd90VoOjD6clJR0g5e0bpoz+QRpaPSX+709nVX9Yfd/TAqQKVtMDLpFGEeFZUE8tNrwOH4ky+H6Oz25QGLgb/pm/VQIOiNOEgHe5BYPQ6Ng3S1uTiizOEz3uKcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(47076005)(26005)(2616005)(1076003)(336012)(426003)(41300700001)(356005)(81166007)(82740400003)(36860700001)(8676002)(8936002)(54906003)(316002)(110136005)(4326008)(5660300002)(2906002)(4744005)(6636002)(478600001)(6666004)(7696005)(70206006)(70586007)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:45:14.1066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470f6421-48ae-40c5-74df-08dc0b453a7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize RAS feature mask bit[31:29] with socket_id.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 72b6e41329b0..842405bb8995 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2936,6 +2936,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
 
+	/* Packed socket_id to ras feature mask bits[31:29] */
+	if (adev->smuio.funcs &&
+	    adev->smuio.funcs->get_socket_id)
+		con->features |= ((adev->smuio.funcs->get_socket_id(adev)) << 29);
+
 	/* Get RAS schema for particular SOC */
 	con->schema = amdgpu_get_ras_schema(adev);
 
-- 
2.17.1

