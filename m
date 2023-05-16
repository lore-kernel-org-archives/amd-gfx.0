Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31CFC77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 18:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258A410E05F;
	Tue, 16 May 2023 18:15:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E51F10E05F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 18:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3OkueYxuXhNxJV5jQ9ipx8Iiizl8AT9OoofJccy1D7ou6s8BlGf/Dr2/DWJsNVOFi7DaVkP8rnmM4j5dr4tHoPJhneJy1xvyagQ4zHd8vl0piRv5wZd2Hay/YQlskPj1bV4ZA3Ok/+BrU+TrzdaRBzJGbTXT159LmF1vWOIRl26y937kUz250N2kWLS3n0RS/b2tBqmRz9V15DMQN3Yx/rGieDtq0iXhLzBB1aQTPDS/cyEUAbgMWKTxAw6Oo+/cJuTJsoWbrDiNnMv9JEyRrKHNE9zJEUfwoErsqqJP0w2VpqSMqdw+0Yg0FqAlbmPyepe8G7b8Fd7XANBUjJ16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWjCw+wYadcj0/um5wh9hNit4N0m03y3NUOClGHVAx0=;
 b=Ex1TUVeP4nez4eRO5PrZr8jtk/JdxmDxgqkBoZABd1YeIMRVcix8VxYjmjBBzqAiuiHP+H0w0x6johrWrTnJuP4wClRvRf4ohpwJs5J2n9KaeRZ2IItV4+KtdkuplP0i+oLV3m3LmzGm1jijdSOCfkSJkPNYSe/xocAwLgzHALFLNxIMCzrnfHZIenzS6rPKqgIRt+9oez92ay8bfpDTxyH0a/52DVQl0A4yEuRaYaNXjNWzwRzFLILQ1SvfoUHT6tqPsphsAnCaQ/3w/dFBA0xax5tkHzrSTTGC9cGhML0pKFMjaPiE5paJLIDA2AkqcWOq1FF7f5urQ4o5eMdmFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWjCw+wYadcj0/um5wh9hNit4N0m03y3NUOClGHVAx0=;
 b=XcBpWy6fhbDsifOfaO6378mwSt5WI2yN1UfGwTZcek/XAbDMHy02T/oAVofKjViWn6Qkzyv6VX5fV1GeAK1mN/3C/wLPVUjS/k2Ps3KvmdmsA8chx7oNaEoRhIn1e4gF1JpXDKC8kADEYdf+EiH2QEyhEByf0FODucFSyJT3wt8=
Received: from CYZPR02CA0023.namprd02.prod.outlook.com (2603:10b6:930:a1::21)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Tue, 16 May 2023 18:15:41 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com (2603:10b6:930:a1::4)
 by CYZPR02CA0023.outlook.office365.com (2603:10b6:930:a1::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33 via Frontend Transport; Tue, 16 May 2023 18:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.11 via Frontend Transport; Tue, 16 May 2023 18:15:41 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 13:15:39 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd: Flush any delayed gfxoff on suspend entry
Date: Tue, 16 May 2023 12:52:12 -0500
Message-ID: <20230516175214.3491-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516175214.3491-1-mario.limonciello@amd.com>
References: <20230516175214.3491-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: efa3f524-9136-4ba7-620e-08db56398ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWSz2gFsRA2N8iwd9jZlq+dE68UvP2IzN8WAaKRRd8Kye/UCl1soxCjrEzrtyQPjyDM83+lJT7zdBSHwzAcUkluiR2IImHrvD9Ndx+cDG1p9tSpwsVIuN7UKJySWHxfursey/lPZOIsNoKgnMMuQ7GFsc0UHGqjxb9jUWnE2lKPSHrrOD9eXUSlAZ/ijBOHax+sRgBC7U5jcCby0V72VwC1fQteyTaX/ad1mfwjccvi4bD55/1GVTQJKGAQU6X0MeT6mWZaSpgAdrBQeqa4SOFNXtghguunlsc4te039i/h7nWoBd82U5qjDPPMhs0g0tPZGXVeZSqkg8vufs6oxUPThuRDvzrZvPCeOL2WQPiFw/oUsla2TRNxfbAciSmdNNHHxGvZfb7szfP7ZBq6RBlb7tWs0uCVjIj+2TSxcxt9LyonPP7llULPasLFTqMvCQ1bvUz0Y5Fw0uHFC3FPBFx1Q8izd5DR1FNHA2NfSDSrsyNKx3dQ1LTC6EkkNxEvTUzzzgaFNgwstyhNVEihPM1jjddEmP7zjE455UItCSl7ra9ih6yf6oMsMwOfB4t32bPYiHqH6OzlcevM1Hyj7vGqaFq+OSYEkcUwvT55ttVXyRnTCi0CTYkUhw3WVhqiK4QeCHbar6/pZm1nedG2OzKU8Nl2DZR5ZmV78qSFqQvkuFP7COPnYbeOB10bgnNawJBPNYwqzKAsBYcxF5qdZd2gSP6aZ9GLSVPzxMv/YWRDquHKgpr0lBVZytWxfxJSCUjz7CPJupC7GZM3b+148xA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(4326008)(70206006)(6916009)(478600001)(70586007)(7696005)(86362001)(316002)(54906003)(36756003)(83380400001)(47076005)(186003)(26005)(1076003)(16526019)(336012)(36860700001)(426003)(2616005)(41300700001)(44832011)(5660300002)(8676002)(8936002)(2906002)(40480700001)(6666004)(82310400005)(356005)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 18:15:41.1437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa3f524-9136-4ba7-620e-08db56398ed5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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
Cc: anson.tsao@amd.com, Tim Huang <tim.huang@amd.com>, Juan.Martinez@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, richard.gong@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DCN 3.1.4 is reported to hang on s2idle entry if graphics activity
is happening during entry.  This is because GFXOFF was scheduled as
delayed but RLC gets disabled in s2idle entry sequence which will
hang GFX IP if not already in GFXOFF.

To help this problem, flush any delayed work for GFXOFF early in
s2idle entry sequence to ensure that it's off when RLC is changed.

Cc: stable@vger.kernel.org # 6.1+
Tested-by: Juan Martinez <Juan.Martinez@amd.com>
Tested-by: Anson Tsao <anson.tsao@amd.com>
Suggested-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a9d9bbe8586b..059139f1f973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4316,6 +4316,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
+	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	amdgpu_ras_suspend(adev);
 
-- 
2.34.1

