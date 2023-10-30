Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3303DC4167B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 09:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6BF10E082;
	Mon, 30 Oct 2023 09:58:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B7710E082
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 09:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYComnU+Pi0kspkQAYrPSgWKgY/0wYe1P6ihyD+qDd+7qkHIGY14SuxQZ9QUcpL54v878CZfQOqrY2igRbrjaM/OrnbzLGAdOGD4z2QpNysoUcJ4Jw329OYi+043QQ12/eCDUv2cpaaV2Bl5ABy12khAfy13ycfprxY1K9o888su/O2NSbCGt2J6MGdQ5Cqkb76dFjSjtJ1xWGGuEkMd4GfQAjQ0DrxDc6cvpNyVJZNaY/WiiUWsjdDLvXNELwQ8lM/y9xkaQvmQicxyIXpvQO0Ls0k2WoXUIFgR7wyHEkz4lnltKuVsxk6KQ4mVPCet3BgAbNdhZn2GfyuVPybFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEIelHp5hHwNZCXZjKJDSo1hGNt+kg+zDhkXAK0ND8E=;
 b=g4Ao7d0t5JTkhHKWxCXZssk/nTB+n9rMafVUmhT7A4+mD3WupzHkjANnnqtnQ3FWR3n7J1RRVVfyHTxaa1BLlTOFbfisw1TGalyM35CrTwjygge81ZxQ2DZPmpMjKnYgFKNi5Hs09npVAW1u12LtYugA1+3zbln6lMaV6prjmI+NP+PyJ50jZyznMIkEP6HJ1eoRayk+WnUzXMvsl4DRqQt9gkVsa+sbEZdDtHn2C6ShkXxBojO1KN0CGkzRJ+ELOKeKeNTCNoHWXieWFP9lDN+spjsglDjuzCIvkV5GztBRzVmrVmAonBNj8Yh/IIJ8EBwUrU2W3mmC6u97bRs/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEIelHp5hHwNZCXZjKJDSo1hGNt+kg+zDhkXAK0ND8E=;
 b=vA7D9lKC9EzSl/lxOhF+75xHf3LCNr8hsRpgG27yckZoXYNf6XJQ9FdbV1V9YhT6s0PSxo5aaddPYnGOJ0gBODYnfRWzsj+V8gr51Kbqc81u21tCLIZfsxeYaRTOHd2GdtV99SCrEuhQyRUWmkN9D+/NLYDQue9UtcWPIaUQxzE=
Received: from DM5PR07CA0064.namprd07.prod.outlook.com (2603:10b6:4:ad::29) by
 PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Mon, 30 Oct 2023 09:58:37 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::96) by DM5PR07CA0064.outlook.office365.com
 (2603:10b6:4:ad::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27 via Frontend
 Transport; Mon, 30 Oct 2023 09:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.22 via Frontend Transport; Mon, 30 Oct 2023 09:58:36 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 04:58:31 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu doorbell range should be set when gpu recovery
Date: Mon, 30 Oct 2023 17:57:53 +0800
Message-ID: <20231030095753.7946-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 648ec917-6c97-4ede-8bf8-08dbd92ec8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/BYjQRjl789BiX4fWSxvCiaDD0l4xHu9AwxRsjmp/yE/Ga2PW5pwrjai/0jQgjb7xHsfDypSrK25JmuZs4afbjYi1r6xVHKACsqQrOEQuXFh7uW7dmKdGeTV8MyW4T9RYGBnbmKVjUk0c7pGcbQE3RR0hPmHA8vHYry21HBTGbjK8PwfjFNiOnTQRX/L37vXyEn3Hpvp7JWOKBKp1l3ZkSf4FuZLyKmkz5K4Dlcqsf8xbusWpyZONrzl18MOLTCghBRYlf4rQqossBFzpPFReMzr+ALHxaT4/MXhXjMgShoT4rTVCoQsU5q2rjhD6oXydQmtU4uQpAxy38wyuLUNM/cTOAP/o28Ct7Qi3Qvt8X3ExmT2Xk0cDfqT4UvfGfKvu7lR4ovZTSfu000ILxRdyv8O6dUtDyhEDy3dZkaCys00I/P2r13C6n4tczMS7On6U4O7OekYoZpsnZ6TXF0v4RkLFICWPu/MW3RRlppC1Ylh9XLLw0EmZPOEUY8IaMOAo3pym4dJzuuCzfq5P7aCXDRy5dmNUw1ftRbaoSn+4TWsk7oAq0KHpj1DJCy2ZfyJyT+ZUbz9s0iIzl/46jM8KfRHEP5oCwR55L9Jase6Fes2T+ccnPVRd/QXLH8F8YiQMAMNOxcCCIV6Ndscg3t7RRftIY1uqbEyhraoSas9okDyXx9TZbJSughuNLdua5jBSJcknMsBfCO48O+Dth7mE//LjHzCKvaOzYmqq+5jbVFjI7VQVacqHMts24AEfL5WF/z64DaDFoszTTDYqzk9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(7696005)(83380400001)(6666004)(82740400003)(47076005)(36860700001)(70586007)(6916009)(70206006)(336012)(1076003)(426003)(2616005)(26005)(356005)(81166007)(16526019)(478600001)(316002)(54906003)(41300700001)(5660300002)(40460700003)(4326008)(2906002)(36756003)(8936002)(40480700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:58:36.5534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 648ec917-6c97-4ede-8bf8-08dbd92ec8f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
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
Cc: zhenguo.yin@amd.com, horace.chen@amd.com, jingwen.chen2@amd.com,
 lincao12@amd.com, haijun.chang@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX doorbell range should be set after flr otherwise the gfx doorbell
range will be overlap with MEC.

v2: remove "amdgpu_sriov_vf" and "amdgpu_in_reset" check, and add grbm
select for the case of 2 gfx rings.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d9ccacd06fba..c9f4e8252070 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6467,6 +6467,13 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_ring *ring)
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
 	} else {
+		mutex_lock(&adev->srbm_mutex);
+		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		if (ring->doorbell_index == adev->doorbell_index.gfx_ring0 << 1)
+			gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
+
+		nv_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
 		/* restore mqd with the backup copy */
 		if (adev->gfx.me.mqd_backup[mqd_idx])
 			memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
-- 
2.25.1

