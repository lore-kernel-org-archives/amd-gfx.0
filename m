Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7300C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A4010EB2F;
	Wed, 29 Mar 2023 15:25:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F7C10EB09
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4bQ3SZitUNckqabKa2pfo5uHqf89Sec7pz6DWUp1clU7oBE3X5jeaFV0eqvtNTU4hrdvBe2Mxq20JnC/dg8y8Vma18UhXZKEtWD1EZaidLdszbtYn9vaeH46I27M9lrzB2y39P0AvS5yUrAhnwvhmZ0KkE/piMnygURMUqR/WUMYIbjrgcMTmnDF0B28BKs8LE4pkepmuM2vRG8PHM/Kfo5Hg/9sodG9Bg5LiNuF1szQoXAcaQ35RQ2Gddf/DIPeCl7O8Io5ZGlLUxgcFhcEXHYlH+lxrxN5SU8ZVROWckMUUVXQgWQM4MUsxeR6+DO/QVRHYeEIUVqDP7zJV/jcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVGUi39F74g48J4e9V4sW6L9Vv8kIhxqCOd38a2eeG4=;
 b=OpS297MImd8A0Zc/JEnWZ1a6Fus0v843oe9WYa4m9if9nPNYgHYif2HAOIWTjAOFPKuZKKMEVzHGF3cj4NIGKPsHVNeqLbulPNWw8PC27JT9mS+K0XKpbeMCPXmbfTI2WYWp6oKJv1gOHfe7TwKHsngMjw5uLXdx/ihYA/44iAOlxbhQz0UTJNhaWk1iG0IEDveaE6d42otBLZsEfNrVh9oPxALhDBoLpfO25bQRq9w0TNBueHeoTnoFX4cAmsNWpms+EmU9NCzB2yfLsJRh+G4X+o9oLziFLNTdfIY+KPsXiycymozrWVW8qGEtaF4tMaLXsDsGRyYsSdBy8ocw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVGUi39F74g48J4e9V4sW6L9Vv8kIhxqCOd38a2eeG4=;
 b=IIh2jwLoEM9FylHaraRcPD4vcvoeAagQFrqqz49z8U6MORX+jEI4KtVUz2acteQoO5zkcU5VrvlgaZDa/O/vX6Yzz/JQVo+iI3Ete6p2Ka8mXC+rL7zob5UBldrx4jaKBLNMkEes60NylSZ5cVrzGG/R0tQV7Rzype5CGSTyDTk=
Received: from BL0PR02CA0125.namprd02.prod.outlook.com (2603:10b6:208:35::30)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:25:36 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::2e) by BL0PR02CA0125.outlook.office365.com
 (2603:10b6:208:35::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/13] drm/amdgpu/gfx11: check the CP FW version CP GFX shadow
 support
Date: Wed, 29 Mar 2023 11:25:10 -0400
Message-ID: <20230329152521.1980681-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8e230f-62f2-4309-22b5-08db3069d840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EQARG+EAQbK8t5XLnD+9dckvbsLfN0TcEX9/ImxAOd3V/nqn/Iry2o7R4rEKA/dCsieFo/mTkDTeRdeEhgdbeWYSAy+RacYXSc6S8y173upPGN2xxAqDncZoZi8UTwpAK8wWv828tTaL04saZWO0OjnOPQzFV4d3AFzz3x04pv6Vd9gt9j37/SWsMMRw3K4oDXDfQ5SPBuF/KcKjyBdMgTriR/sGV6XtmtyBPxoth1ejX5KkLQ60Q9sahe3caMnKfGdit1m4QuhgvqwcdPrGnScRM66HZ5fctFLZetWscA83lA8Vx8Tt3zt4gtMXOjn0SdhqKq98RwCchc5Dil14bxQXQJrlI8I2NN0GF6iUsfffNwc7W5Ibi2pQ44oMolGMYiZjVOZHO6KKyAYseN0Q4u0DZ7SzQ3xwCkL81KLAvArFXvKP9EWK2yvohRL1kQY8pcCrPj9YRe/+fB/SiJTJ65N6/mW70qD7cdr6IdeqyJ6NFaqGrEhjDS3kocoosISt3UZyIxADE2yat7UHOUmRme7WSgwpKeXtvijiWZnboFLzc/rth4oR9Th0Erk3xm9oRp9Jlko7yL+RqCQ6w3at4hfhtW2Ilq1Wrc4hhVg11z1AvbxFy51Urd/J7v9YZ9x2PYCVYx1zj0vhEuY6/ewtspkY2iM5wPRPmRSQyeurbWsXpwDf7rHMzxElE60h9XPp7Xu566picQo82Ray9VtkpOimtOp/Tce+k7wnv9IZzP6JiPH4Fr5gWM3dJaPCPs4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(316002)(6666004)(40460700003)(82740400003)(86362001)(54906003)(356005)(5660300002)(81166007)(8936002)(47076005)(41300700001)(70586007)(6916009)(36756003)(8676002)(70206006)(4326008)(16526019)(186003)(82310400005)(26005)(40480700001)(1076003)(36860700001)(478600001)(2616005)(2906002)(7696005)(336012)(426003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:36.0525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8e230f-62f2-4309-22b5-08db3069d840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only set the supported flag if we have new enough CP FW.

XXX: don't commit this until the CP FW versions are finalized!

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a0d830dc0d01..4a50d0fbcdcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -469,6 +469,15 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+		/* XXX fix me! */
+		if ((adev->gfx.me_fw_version >= 1498) &&
+		    (adev->gfx.me_feature_version >= 29) &&
+		    (adev->gfx.pfp_fw_version >= 1541) &&
+		    (adev->gfx.pfp_feature_version >= 29) &&
+		    (adev->gfx.mec_fw_version >= 507) &&
+		    (adev->gfx.mec_feature_version >= 29))
+			adev->gfx.cp_gfx_shadow = true;
+		break;
 	default:
 		adev->gfx.cp_gfx_shadow = false;
 		break;
-- 
2.39.2

