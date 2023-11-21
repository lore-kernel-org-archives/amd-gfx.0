Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A1CC5ACB3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Nov 2023 07:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032B310E26B;
	Tue, 21 Nov 2023 07:34:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB6310E27F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Nov 2023 07:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkZl5UQK47b+IIXyqABMMP07BSreeZlLi7XxSp//cg3ZyuKt+nKbaeP/p5vfaik7BV/kHBGbX5TVYR8Xay8t3WFrmsy0abaWn1k+vy84WtoPVAz4mqa+unlOr3kitpHpCg3a7Ya1Xdjg2ieRvMfgI0am+50/47Ei/k4ihtWHPH39eMZQ2vLtMytd/tP5HBipMc5wniarGezOY8Q8pP1H0q00QrNK0PMtH2Pl8lxWN8xEEhM45nusshMxNLGO1/lj66td1khVL3AwkuU4EoqOKRssJoIvyAhk5BTqzEb8kwtE4q9VWvOELO4TEe2i0Vo6DoNtAzXyEIiD+ne4T7hoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQzVmryS143/Qyp7fyMzaumG7eMKHrtkfJMvJzo5x+U=;
 b=cTeACXyWy2GrQwFEFRfbSJKDMsKV7ue6dQuItrFBLeFjAMKdg73JdYaOUOsAvzRjOwIsgdA8thIV35HBHji6M/2HgIdt/oCghmeck7+t8COPlsAZQYJjFrtstMG1HJj/Se7HxL2j2WCkI67JWb5o3s6JqMygB7u+2FmnlMWq+gwUX3vZBZFddfakQdJK8v33/obxRcWYXjDIySumh7kZI3pj6rRaaoHtOYOw078Ot54wvHqPzzDqDfO/TIGvnjNGV61gUAgDljBoT13tTCOWoVohoYvjXJVoNW2oSieyrC0N9xzs19Q2cCFf2DGXE8zTTKWqeXb1JlFA9kkX+Bb/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQzVmryS143/Qyp7fyMzaumG7eMKHrtkfJMvJzo5x+U=;
 b=qjNTIvp4ChvU+M/swfon4pVaFYp42OrWXbhrHxSdqylbLPbik5xjGykXQkVlYtZa+gwIl8AWdyunUfKMfxgN0bvigpcqTQaLbN+MtENR0NBkVOKZIe7njlVJoRs7nxp8I90AmY+sfTK7MzCgVZJ0cLjnM3u0l+GjvehLNxmA/Uc=
Received: from BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37) by
 DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.28; Tue, 21 Nov 2023 07:34:07 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::d) by BL0PR01CA0024.outlook.office365.com
 (2603:10b6:208:71::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 07:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 07:34:07 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 01:34:03 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/6] drm/amdgpu: skip LSDMA for mes self test.
Date: Tue, 21 Nov 2023 15:30:13 +0800
Message-ID: <20231121073014.2984557-6-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231121073014.2984557-1-yifan1.zhang@amd.com>
References: <20231121073014.2984557-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: a9837920-066b-484d-7c49-08dbea643ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WA2meuHuKJQeW5Xu0LGlEO2Gc+W+DVK7fNZYQpp2sFlsMqkjISC65XT7ZDZP3eim86B67GUNSPspAMdniLCvJqHXsHfqA4ZsIGkoWBb+aoiA31xvmDR98CAM3AQtghJw7DMNj412vfKN274rOuCcUc4xxE6E5T84rhKaPubCKcm/9VTY0rejxcko4FTzWe2Hulm/oOnHip9XPXzPFZ2rPIBbBDFvN+E+TnyiMsi6uZEaxMfkp8u0Y5nDQtPUBMeJdBlA1os/40xBgXXB988XBhm21Lnd4pbaPGujmO5DnXqkzkISVipO8PW0QOjHzPGIEjVPzxHzzJTMMZmbWL3Fyxp8Wo8dkQJiAfZznn6kyYVOmMs6sFy9EbbjNKoBWeFk0xf5l8WEnn6/tA4RP5R6RYBNuNyqy5Ae/j+IJTjmI0BaPtOs7J5+VI7uoTIM+3s4DnfoM17wR+KbGyTjyENwlgs39fmf8TVxOCsyukkoKJO9PbfZss3RWo2Z1cL9fGg/dxM90Pv2uy4BtIPaD0PbEX2ixrQBxIhpSa7S6kk1QXvik53tRVVK1MP3fp7+s2Gn/nN40YNo4tqbx+MfrVNGqCd+Ivk71P7EbUjKHr4o4tl67kFOELitCjjDtlR1fzltR8QoWI3r2n3bX1TBf4msvjHm8Y34jKMbwU6DizrfM1E3hcMpmKESibwnG/EOY9NpVpzrXvbIqMBg1ViNOmls5dN/Af1HzDbE+SWJ9N1J8x5vVYT+XtXaXr0AsGrLcQx+NLng5zXAfwLjl+WV09LQ8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(36840700001)(46966006)(40470700004)(4744005)(40460700003)(2906002)(4326008)(8676002)(8936002)(86362001)(5660300002)(41300700001)(36756003)(16526019)(82740400003)(336012)(426003)(26005)(81166007)(356005)(7696005)(2616005)(1076003)(47076005)(36860700001)(316002)(54906003)(6916009)(70206006)(40480700001)(70586007)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:34:07.1275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9837920-066b-484d-7c49-08dbea643ea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang Yu <lang.yu@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LSDMA ring mode doesn't support doorbell.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 45280fb0e00c..2464d246aa2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1362,6 +1362,9 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 			    IP_VERSION(11, 0, 0) &&
 		    queue_types[i][0] == AMDGPU_RING_TYPE_SDMA)
 			continue;
+		/* LSDMA 6 doesn't support doorbell, hence skip MES test */
+		if (queue_types[i][0] == AMDGPU_RING_TYPE_LSDMA)
+			continue;
 
 		r = amdgpu_mes_test_create_gang_and_queues(adev, pasid,
 							   &gang_ids[i],
-- 
2.37.3

