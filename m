Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F329C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 11:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A082110E362;
	Wed, 16 Aug 2023 11:33:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF8010E362
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 11:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E41G4bF4fieDc4mtipj0oB2Jt3dRdZvS2lgLdgMv6iSu6oWEf10fAFEbA//sv6v3tLN2HWnnKyuFiAuUkfnO8PbZe5brgWKQckv8+DnjIRuooDHRnm9jbN5sfntVeHu9z5aBTguNXeKnLrFFhiYYJd3oiICt1nU/gDSCRvuf8In+WwayyhlljbrMiqLZYEsl+WpW1G+iJzlTAsONgoTfwhW89uxpuLXHSrq1dldkTe28EyQjv2KpOT9/M9QITS1+s01YZj8Ucq6U5yd9a2+U3OIAVrZc84UuSitJltVqXkocASXO/YvH21GCMrl1PzCTUSb8JZzBqwM9o6wcQagJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DA2zKE4FgXRO3ljoAgws0vasCWf1wSPbZIga7ELqL8=;
 b=eSG0Q+L6xN1+KZPRVuq7NoeWYkt5K4bDT6Bauox30W/PjFSwkxp4HT8BkJVZHlfRRC1Lou4tWjAxY8F4dmgPQO3vR9uOqoFRksaiZtSwMJQHYnDSuP6hgtF++BvJ2sEvq11+LWEoXfs4AAxNNXIfTjovYVjQh161WiJQXPdDLFIbxvvwn0hdQOlmOO+g+PD+aCntH/3FRN9ikdfN7TV0j5BjOUxd0jbhgfcL9zdqlwouFVVGwcfmyxIAi/2h/SLApnn6pZJjkfJP95javxhY+sVg+KElXavBnPQlKePpeoTmTag61PXbQFgbMr4i7f73srLsAAy9PNzXV+YzU1/4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DA2zKE4FgXRO3ljoAgws0vasCWf1wSPbZIga7ELqL8=;
 b=w3A70Hnjp/qWN4fihsp+ccMp80+d+tYKT0TCThPtilnDYj9/XOvY4tmp1qM9N6MS7M4UkyoWYfgOYWQR6CmU3jnnBHv/D9ZhnF7AEn2+IV8hyYqRbERBjIJiO5LxHJG+Vb/hwASo+d/JSVca8XFcD+NNqdTseliZ8Vx3900Nnik=
Received: from PH7PR10CA0019.namprd10.prod.outlook.com (2603:10b6:510:23d::27)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 11:33:25 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::25) by PH7PR10CA0019.outlook.office365.com
 (2603:10b6:510:23d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 11:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 11:33:24 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 06:33:21 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: Update ternary operator with min_t() in
 'amdgpu_ras_eeprom_init'
Date: Wed, 16 Aug 2023 17:02:13 +0530
Message-ID: <20230816113213.716108-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
References: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 820f0052-f081-4710-eb4c-08db9e4c9a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGBpdmXwO7dzVPyLp3/2aPfgLPi3siGF4pwJIkJ+raccu0+h4sZPWcDp1Q0+pCMdn8tPiu7vL2bMgl9D1vIlXMH2lSbGeneq3SEYnm3cWNOQJ+g4DPKKQVkU1C0/iEbmeuYZ7bp9TQR3kTaWSkbOnYsF9eEHEhUSzmBPQLuk8BDXhk0/dhc6vgaEs5f4CrGNdEni3WGlSPQj7smXdSwikTCk9K7ZHtRzmk4hp4uHkyEBqHIkll9iUO+6trBlh1w2B4FD7bkvR+s54nu85MKu4OvR/3mq63hmIRSUtdV+Sc3dRPm4pOyk3bahTSnI3u6WMXc2G56Q/EpDXkUG7lqnDf6B1GdceI88ZiB4R13NXdUaSR4IbQjk3wjPnX+B1OfJ1OqZ1nUmxv15daEIY0FKyMzK0eow44LkSoMYwa4zkBXLj7Mau/eA/5lAtD08brnxAdN5C1h3nj8G0+vx7CHs3RCfY3gXIbS/EsRumGSPZ3X33RwXCn1qMXMBGdjvhA5Nzt0S+7rpJ+PkiJH134Q2+g0S9mCElZp0ZCoRqTJR7UdTxsa27rnEC6pmorsQkN4l9s3mzXSvOkx+/9ciB7F+KJ2A6clrxqg6HsMy8SjbY2zOycoej8YJN2j8PhxOzEnMpySnaj7uhuHlBeBqy17pKCtC+a8eDDReeTArnBcYG77ZzeiFU9l1+4ZN2KIkRTFjaYH/s/SI+wyTBHFWAC4xVLOejDrcWdb5gFuCyykgFHU6gqw6LOPKpOXfr8oqV02i3cI9aTgnAO+lgpv04nKW3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(4744005)(2906002)(478600001)(16526019)(1076003)(336012)(426003)(26005)(110136005)(5660300002)(2616005)(83380400001)(6636002)(41300700001)(316002)(66574015)(47076005)(44832011)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:33:24.2852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 820f0052-f081-4710-eb4c-08db9e4c9a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following coccicheck:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c:1412:12-13: WARNING opportunity for min()

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 4764d2171f92..8795c4ac556f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1409,5 +1409,5 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		res = amdgpu_ras_eeprom_reset_table(control);
 	}
 
-	return res < 0 ? res : 0;
+	return min_t(int, res, 0);
 }
-- 
2.25.1

