Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC17C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 06:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D61310EC30;
	Fri, 28 Apr 2023 06:05:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE1E10EC30
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 06:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThLbMq1zm6T1Uv5aP16k9mhBToORRO8T49KKUG8gN491fMZhk28BDp034hszEBlnltpLM48276qsyLSP6UeMJehWQpOTc24b1WA4xuF7QbiQRfRa4BYaQI+Q/4A2vh+Tbmn/rtVA+t4sJ+onHJ4kmiPayHCY0d+k3qNR4j8blT2OH/DLyqM2cAlCL5BABqdzjf7rtcbqO2Snb0vpIbOl3KRpSlq+iPas/MZtNgMqywJESpXh0tv9g2DBubiu5D5aAeMh8JrTKaKQ2R4O8FGBhOBW0ly7OKonrmEftkS3vmfWGWyA/TyGwaFKmocS/I5DGHabZuPGspbfOlUKgK0GNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKPeP2LrIxYtWjoPLd4qQiC2zB5x3Hjav3YdQQy4IiA=;
 b=fN49qN/S5dtRJAT9nb9d493hqP2hKcxnMnnpuoeQyNveqQPVBmfTgSKpTS2o7M8ipEmg6mJVdtFkdzSBYDnopYPLK1aD6JUyxsSb2fR5C0XPVRCeql8o3gPaJYHDAo934kDUgkRBpubZg6eaH8qTkZGXkABS4HQEphFWa6ODiZdsYGuvywU8ROjmAXZjH/qzya2UcuUgOMruNakip6HmIeNzR2CDMl6e4esgWOwNXiJbkA+1E7b33aEYKGR7sqm4Nt6kU3wEFKRA2BUuk1DO1IZE9MESzvJMJut52FQD5CkvA8MVtkzp2u6mPt2InWw4V/KijI/Z/ipgyVWSNA7IAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKPeP2LrIxYtWjoPLd4qQiC2zB5x3Hjav3YdQQy4IiA=;
 b=hO4SReB1YsretYYMmzH5MJ/E7cWqP6ygGFjluUsjClRfcO5B/wk7zMlSNjEJezt4LBF4J7+mCIVyYp1oIr6zTlzCn4/wTn/lRC3ArDia5c+t1fAjlxb7rkeb69Inif5J6udW2e98uO81b21ue56QbRgKYYB+V8sjLQmCRGo+t4I=
Received: from BN7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:408:34::24)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 06:05:37 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::e6) by BN7PR06CA0047.outlook.office365.com
 (2603:10b6:408:34::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 06:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.24 via Frontend Transport; Fri, 28 Apr 2023 06:05:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 01:05:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 23:05:19 -0700
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 28 Apr 2023 01:05:16 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable mcbp under sriov by default
Date: Fri, 28 Apr 2023 14:04:50 +0800
Message-ID: <20230428060449.1215710-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT085:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 56890249-93e3-4d10-1aba-08db47ae95cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNqx4vUIR8k8yqYVL9QYfuv4EaaLrSWYLZGjFyi+RZmZrtMvmXo918HU+iBG0v2ddj3dUSditIshI+AiBeMxegijfntZtAN48cArdecb5Pw5Sd06WhnQzJ9QMkjqIAzqat01yGrTVaONq+Ccbbi9mq/0ayxup5ShegjwPIpN31aDkqeRlf0CIMuyLKH2DbwGqayCTXyhiqnsmUyOsAobc6tQoyct+ORO5qT9jru6FJW8Loi8J8CGqeMgM+zjGCRdWu/MmpcvvHrGT+ItJrMCXb0rGsbxt4FF7bR2yyxmGKxR9Q7cI9G1hYysF5ubADbYhnUPvzC2FoBE4ck/MAj/lRMhghv5eIcjgTPlKLn2D1/7vvXPt3H5ia0tbwpWPfg8JRMEHS9KkYHTjpJiNGntRZ3dj9hNIMBAUEWyxX2+X3pa+9fR9T0W0woXwtPbTbctJrWLsYZMowsD9tTYR6UUiqLE/oX7az3m/QRpo+CQ2c9FMPGMhzi9Vy818ICD1d8ztBHqyNJzD4ppsILF7pyX9ZFhks2+GfiEY8gAXQZT9FiPEZnpYYZM0I/vS8VHNyVW0zobDKL3xVRJme3n4JuR6FvFYNi21ke3VKGyxbah8vCFQpbt+H1wYBCdHWNb3OINf3ftgvFQhz6gwDubDB3Z0Tj7fYwx27W70fE+knk9CvPExs2SeUriFV5ZrgeOZp3lcKdFj2c2341IGTKC4GD3K+WV43N4OwPKLGc8mq/8XF0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(4744005)(41300700001)(26005)(1076003)(2906002)(47076005)(5660300002)(8676002)(40480700001)(8936002)(336012)(36756003)(426003)(81166007)(40460700003)(478600001)(83380400001)(356005)(54906003)(186003)(7696005)(6666004)(82740400003)(36860700001)(82310400005)(4326008)(6916009)(316002)(2616005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 06:05:36.5651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56890249-93e3-4d10-1aba-08db47ae95cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable mcbp under sriov by default. Asics with soc21 supports mcbp now
so we should set it enabled.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 9dd474262c29..1311e42ab8e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -65,8 +65,8 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 	adev->cg_flags = 0;
 	adev->pg_flags = 0;
 
-	/* enable mcbp for sriov asic_type before soc21 */
-	amdgpu_mcbp = (adev->asic_type < CHIP_IP_DISCOVERY) ? 1 : 0;
+	/* enable mcbp for sriov */
+	amdgpu_mcbp = 1;
 
 }
 
-- 
2.25.1

