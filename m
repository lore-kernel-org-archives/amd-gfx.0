Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41604C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 09:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD81910E5B9;
	Wed, 24 May 2023 09:01:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3C710E5B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 09:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJatU1L/DHc9tt+Bk93uYOXBV+7DOiA/ns9l+z+YTwSpilhfCE74HCFCt1cGhbrtL31Kh7BO7OtyrthEoz5H0w8RkI2/VOwAye05ZmET2x3Yat5XUPtgnpoqBkR7hU9zwURLqb7Dw8L+Hhwtgovwgi1t4u0/rIT9HLktjEnqUf9QW1Y+H7rDyc5cuYyPnEjwn3mH/X+tzV2fXq7a/Ct/lDleerMPZv9glrqcgpI1sBhZV3cESFZ2387TfQbC9+aVucGZ3pElh2TsuBJErNJqb5jgwyGCS8nlxi/iI9BydzYFIERPUjPJ4VYaNlOiRDg2L3YXERg8OqvlA/ZS8sqUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3whBkxyJSZEUhPnblub+ZXw+Mbjy7plaqfyppQoCUCE=;
 b=LAicDSu983y1SuyuNrureGSUj+1b6odJwfH63PCPNWbXfrCguJYjx6zw6JUisWTPCWc2LqeIFhM5gYXyA/0/E2uwZFINHrYTd3TyhCoU1P0/axRdUrn0FSUCmG19pLw1jcfXbpBzeykpmYVi6FnAbkNFByum8jRGJx6nU3vylwUiTF38wi6kEQm2TNklU3nMfEDFDlm7+L2933aEJPi625U00g1mvMjZZ109dWS1elyCBX4jwysCVSO4FUOsqpNTC2W3QBol+9XHGuwz4MkBKtw4Hd0T3uurH+VXQVEi0jJgtl7fIyZLfNnP6NH4+p4GrhZ4mMSngIsj7QLGMx9QBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3whBkxyJSZEUhPnblub+ZXw+Mbjy7plaqfyppQoCUCE=;
 b=iJ0eleeqZFN+h3ttUGLpFaKocAW3idYw4gaBknAhEvw1yBWd6AOHiWfFNsphqJLnNT5T3CCFSX2L1NgtPh2Vo+kkAab1IeY8CzXvxDNoh35fA03xnHGtQmWpEpdwQX26tar1DnJzxuiOyNPgFUZF+TCgZiEqZuuf7Nf+WTllJzA=
Received: from SJ2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:a03:505::6)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 09:01:44 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:505:cafe::2f) by SJ2PR07CA0009.outlook.office365.com
 (2603:10b6:a03:505::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 09:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.15 via Frontend Transport; Wed, 24 May 2023 09:01:43 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 04:01:40 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Remove unused static functions
 si_set_temperature_range.
Date: Wed, 24 May 2023 17:01:25 +0800
Message-ID: <20230524090125.3098744-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 8330defd-1b88-427f-07bb-08db5c357ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAGPigZgOKj1HK6XSWc1jQH1h2Z0e91GAAVlbB7piWjvMREncvfl3SieZcl4fOC86yDO3uHXjZbxpE5+cNRSObw1kGTAhVTfTQ0QAbl695+F+bl/zAzWn2Gr88u11qAlZ3zkJEFwcfQLDC5zIMXFmzeeqcWZciDALQy0jYftSnlu823ANKr9btJ1i+h4+j7UciFFn6FqA2zWiiWybxbo46xtNwHLID8Kz0zWoOhZQQ2CoySmfpkmRPLqnfcaf/WI9h4qRFfimTBOE7FU69z2MJx6Lmfk6OS3JBKGJAhpj3vIOmpwMeXjlhwTkliVGAq2HVh+LbTUNeEBN5V29YVEezPrd/415rs3czI0KO56WdOMkPA5q+pCUpRP3qqKN+vHnfSfdlhd0IJI48xzZFoqYzllPCqk3j9ZkWvmgNR20gApHvnP0P+06qD8Or1DNSKPam/h0qEZIXioh5LjeCywnGm/mFLCUkq6vKF3ZnFb5WEZEt49AfdvczuBKeEtN/rm1sMIBDzvqy4S+XHYZwrKu6uVHEukk7OSoYyouYVzpk1F4X01r5GTmujG9VKps9jPyzlsXuUUyx8KG7/X4XF8Qg1NjhAXINQga1zYD28bcFi726X/tuiUhSb/nBXvlKPabNyu20DtAFBMArC3GRLixGi/bqdUZM3gOu4alYuXayXQ5Dgya4D151ft6HoCozexMe7CqSMSnJ+0HYO+94ppHrNKICM+vuvBK23VDNmlOdH7RvUe3rfwloX8MsZ0oTZI0R7jeHsFXWEdhLY5P0CDgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(70586007)(478600001)(8936002)(8676002)(5660300002)(70206006)(6916009)(4326008)(54906003)(316002)(6666004)(41300700001)(7696005)(40460700003)(356005)(81166007)(36860700001)(83380400001)(47076005)(40480700001)(82310400005)(426003)(336012)(26005)(86362001)(2616005)(82740400003)(1076003)(16526019)(186003)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 09:01:43.4342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8330defd-1b88-427f-07bb-08db5c357ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 lizhenneng@kylinos.cn, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix compiling warnings:
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.o
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/si_dpm.c:6928:12: warning: ‘si_set_temperature_range’ defined but not used [-Wunused-function]
 6928 | static int si_set_temperature_range(struct amdgpu_device *adev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/modules/hdcp/hdcp_psp.o

Fixes: da449f3fef3b ("drm/amd/pm: resolve reboot exception for si oland")
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index ca9bce895dbe..02e69ccff3ba 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6925,23 +6925,6 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int si_set_temperature_range(struct amdgpu_device *adev)
-{
-	int ret;
-
-	ret = si_thermal_enable_alert(adev, false);
-	if (ret)
-		return ret;
-	ret = si_thermal_set_temperature_range(adev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
-	if (ret)
-		return ret;
-	ret = si_thermal_enable_alert(adev, true);
-	if (ret)
-		return ret;
-
-	return ret;
-}
-
 static void si_dpm_disable(struct amdgpu_device *adev)
 {
 	struct rv7xx_power_info *pi = rv770_get_pi(adev);
-- 
2.37.3

