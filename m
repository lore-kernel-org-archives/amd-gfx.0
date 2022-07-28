Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DADAC19F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 07:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F38818A8EB;
	Thu, 28 Jul 2022 07:05:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 793A418A5E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 07:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8t8X9xGJlHmDLJKenXTeM+v0Yu0YTwf2k3pPQwNQpznInC1pfFxxoL4cM5Ek0EL2pPEZLGjaUGjAHFdBuvBMhrg/PmNsQryf0++b3rfc/FG0+24vS0/GulvZLQQjehmIMwlK1wWt3DMzBAJ5pK0GJHIsrc9RaToKjT92SeLwmfM8RcFO3kTcp5lewN6r9IDbTEToDhfksEDpUX5UoCJIrMihyMBVBQiqSubRJOh9nrMsu+TyuEV9zreT7BHVwE+0BFlpb++IzxspcZWEQoRcp6Qj70lbhyFXct1YYtlTnRC8lmWiZHdWLCNXcPagHcTw02eymplIfi5QTVQIRl9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwxwkUIzRjMHhlnhQi/CvZtz2ttuygT8D1UlnP6zPgk=;
 b=dtLlGUsoEZsIv28hPtF20jEzYV7UPbt7Lim9QWJ4LiUlS7ddqCIgsgcuRo7tJHxJahakEvN/vV5YoOAUESvFPhHWzF52FdzOuIkaNg89Sz+7EpVFMzpkIgbgeIuBDsSlvfMGgpcqtD5bo7IXcjcgzTvCszeS7a7ddGOv8r2tS3eTlcUo/WpbydHeE7JY/K3leQkHGD2K2cQcPiKGq8kJDUDjc9wYOFilAQb8/8eXGSLV3vaeULe3c1iuqUWv7rcjIbg252eD/GizNebejPG4PdoWDe/30o6Y5pbXF6ky7sAHdBupCdVzJkw7RV3ZEtrAHg5A0kgptmnr+rR9Yptwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwxwkUIzRjMHhlnhQi/CvZtz2ttuygT8D1UlnP6zPgk=;
 b=WWFS8TIGENM7cdnSlP/jWW2Ge3Hr0jDnC0O4OKLW2hh+HtETOJYuSjLve1SHZ4KJs0GzQcDqLdUwYJEgWA8XSo1g0gKqWc/knF9mDXDo2Y/POaZcDOuIF6G/w3wuG6W0uSDgOifzY995Q7I+QZRKDiqGyMpsvwTr6hbPlndcB4M=
Received: from BN9PR03CA0719.namprd03.prod.outlook.com (2603:10b6:408:ef::34)
 by MN2PR12MB3087.namprd12.prod.outlook.com (2603:10b6:208:d2::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 28 Jul
 2022 07:05:16 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef::4) by BN9PR03CA0719.outlook.office365.com
 (2603:10b6:408:ef::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Thu, 28 Jul 2022 07:05:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 07:05:11 +0000
Received: from jenkins-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 02:04:38 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door loading
Date: Thu, 28 Jul 2022 15:04:15 +0800
Message-ID: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 066032c0-caff-4758-e969-08da70678346
X-MS-TrafficTypeDiagnostic: MN2PR12MB3087:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJ3lrOEYvgSVBNSHVOxbyoyfPvBWx+IyuatbrIn8LE0VY6aYfrTztuc15yNHGMRMkahyMeAUv18VsyhxsXT+42gZx4Cg8le/gu5eKCXWqRDLI/Q+w6PgrKK4VV++EUMBsHBQtO7F63bu/h5UcUDqLXYqWxL1GdxplypiT/V6renBvNGBOaQFFjHz8xiXQ8MEauLjrMeSDMuw2yZBPEMCI+6fkFbSUOTLCcYdnTDoodfmf/7iYjyRKzEK5U0O4X+HqDcgKOY2EWX2lRQBMr5Sh3UAn6PZyENPWYRKT0l11MPFnbwJ/ox9fti52HwjuqxjaOysgDGvN38QJ3MAMJo/4URByLp6ye+8Ae+BoNYMmZAnDvB8h7XzPixq+NpAcG3QP2A59K7n1+w4GDmwIT7Lf5J8SC5eLYRE1c2MJZ77inWo470PDLuXhdBQHxjsYFblO4NYb3HC0sX+iSAcsyRXyPzL+iG4wbjDsGCz7fF85oDc1YoHu0z5Uee9fCMRPZ5F+1wQyZoWWWi9vKMb1wmd32zksp5nASKgyFAfHL7dCCfRyCwVzk9lyxVwF9zMJv1MIB+0qLJHcFNbTuBAjtzX1A/SJjp5IK1y7aL+eamtLe2OQAIO/YZLF56rNkaLTQv4QvFk9Ps5gN24hOMh6/ELstGwEPCO39hRcRh1/2baQAiOpJhQdJkIMDdt3j3Vvq3a/kwLm5ufI3wUvn3Chm2PaUWrPBn7T5BKDqgI2dDLDCaOi+SulBC/0NrycGFhGo80nOAZ043ty7AqAYOHO3nLKHYUZApfjoYz25PDvi7EHVe+U7fJP1NwTPWwHqCGJpuIZIwJ+ITH09XyNlgrjiHiEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(40480700001)(86362001)(36860700001)(81166007)(356005)(82740400003)(316002)(82310400005)(478600001)(4744005)(8936002)(5660300002)(8676002)(16526019)(70206006)(4326008)(70586007)(47076005)(426003)(2616005)(1076003)(186003)(336012)(40460700003)(7696005)(2906002)(6666004)(41300700001)(54906003)(26005)(6916009)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:05:11.2126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066032c0-caff-4758-e969-08da70678346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3087
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
Cc: Alexander.Deucher@amd.com, tim.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch will make SMU send msg to IMU for the front-door loading, it is
required by some ASICs.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6d9b3c6af164..79c01fa4b875 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1360,6 +1360,14 @@ static int smu_hw_init(void *handle)
 		return ret;
 	}
 
+	if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
+		ret = smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to Enable gfx imu!\n");
+			return ret;
+		}
+	}
+
 	if (smu->is_apu) {
 		smu_dpm_set_vcn_enable(smu, true);
 		smu_dpm_set_jpeg_enable(smu, true);
-- 
2.25.1

