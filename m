Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFB7C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB57060527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB57060527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E4F6EA78;
	Tue, 21 Sep 2021 18:07:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145EF6EA33
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDfb3cowzYKs41ajD/K5t/HO2nZtUy+g9nWG2ESrkwLv2ogY0QfQDQuxALrxQQQhqOImAX9Gf9iRfm3vjoESghOPzEDuUgKPAQj6m6J5gxKmd8EDJeEIfMQqbVsw/oi0IKgRQ9THlQeSqPv1WkwyLswiUuWc3zCL+aZda+Qm73eG1oZ31Y/uAFdf5qZVjvIEDENH81ggkSp6y+pndLoEiov+ol4IQ+zCIIWy1LwAq9p/YDA/jzb3JT5Nlq7P7j95Iu3gLYwwA6y37yIxZaEVisPWq6V/55/RfwVz7jLckCE2XtftiObRKJbQW0yByBORM9d13bSTQZPMrKEVEFR2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=IVT1kRy2tKYn93gMMexS+SNzDrFrBVtCvXv4mmb0MPE=;
 b=StDPqK9rzo8YXo+HgpsUxbt7Q1KQ3oim6ra0ej3FVY0edQicGsL22zPRNZEK1FVFfyPHu7t6ApMQ3xmGzwlojj6bUsXYa3cC36DwyPvTJLnZcedaadF6VfvTQ5ySFg+3pPUqYTct27qxhPc4ynr0InYYYO0dzfEnG+vhFg/ClSKxcVQRxAlD3b4F9ZStf/EuBfMrZTIozibRBLxrqQqGXrbDC2ivOGMX9QFXKoVbhnU6xKtvcLul8Cmi5tASpXgNBbPCouYag4jBAllHM4hDoWGmluRypWW2J9agDTwApxd/Ay0q9F06BMKbWVbfgZWCrO7dxbGq2glv+oeN+AoW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVT1kRy2tKYn93gMMexS+SNzDrFrBVtCvXv4mmb0MPE=;
 b=X2WctkN8xG+Sk0Fk73gQewvxak9JEHdhNPnsBnCdXdotfRhzl/XYwEQ6tEBQtxI6oADr+xS+al68yn84sQpwbeGZiJbW0Wxxxj/5sh84WNlI3h4fUQc82eD75ofrKLLvaNoPI2SKx5SoxR0RzETOUa4YErOjwDZ8V8ShcjjyG4U=
Received: from DM5PR11CA0005.namprd11.prod.outlook.com (2603:10b6:3:115::15)
 by MWHPR12MB1887.namprd12.prod.outlook.com (2603:10b6:300:111::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 18:07:45 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::3) by DM5PR11CA0005.outlook.office365.com
 (2603:10b6:3:115::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/66] drm/amdgpu: filter out radeon PCI device IDs
Date: Tue, 21 Sep 2021 14:06:30 -0400
Message-ID: <20210921180725.1985552-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faca00d5-54e3-45a0-1f79-08d97d2ab6cb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1887:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1887981A35D779813B3E43A9F7A19@MWHPR12MB1887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urHb0t2huLV5FP1kl2jpUArTQOJ3wSO7tQtZjhWyBV86IMVlXYODLnU3P5JTNkvoe8NH77zvj1cyYHTO/98HAzuH1WbtOuqFHLwe6lnaMZoE1+5+78nJprrlFgJkathaRnirc4+b1fPVvakaLw+AvVQPK22TsC6FgDS+CSfZE9vIpr4ynrFvPk06gLosa1pGdNbtzNMV/BQhCb7up8jgCy53TJ1EqYNrw9GXNy35g5IsW4Yf35hVLZ2FXIf0Qe5gx2CAPYSna2NPdqCUjHvJfJme6wpEMnYx/TS/6exOdWp9+NAh2vkChTVvgop+2K8NXAxDkH7PDts+IbDad60OjH60v40QK99/Wqy9fa9x+aoEAmgBrzcw07KaGschN6rWMj6oZaK6JBUDaresuvTS/CyTIh8XnJZbTZz+Q7br/Rg/WU3F8G4u+7ZNDhOY+S5AF1q02yIk1OpPFdAWm4Sl2N4SalBZQBtDG3/WgWXW1ufR6iwCq2azKPRddXS7/w8bY0E6rjA2F6Jm4/g/zPDijdqZK9sP2lZ8qWpX1loU2Ztzpg3fyFAOEQprcxpZPVFKCxl3almcnstGTHnRBIIvEVXlASVHOgSE5WXbkTZTEczeh9CYeCGddKGZ0v2XbYBMM2+qnsBh6G9Ru6RpKDCTABiqHgst3jQTfn0Moc8SAqnBwh3Q/fRBA4vjOhHXwx3PaRvjpuNFKLertdCXyFiwJDINJYlSAimn54LEiHFHXn4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(70206006)(2616005)(7696005)(86362001)(8936002)(6666004)(4326008)(36860700001)(70586007)(1076003)(316002)(336012)(426003)(83380400001)(5660300002)(82310400003)(16526019)(36756003)(186003)(8676002)(47076005)(6916009)(26005)(81166007)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:45.7709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faca00d5-54e3-45a0-1f79-08d97d2ab6cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1887
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

Once we claim all 0x1002 PCI display class devices, we will
need to filter out devices owned by radeon.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 561 +++++++++++++++++++++++-
 1 file changed, 560 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b6ce53fa9b03..3ab7099a1b16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -891,6 +891,559 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+static const u16 radeon_pciidlist[] = {
+	0x3150,
+	0x3151,
+	0x3152,
+	0x3154,
+	0x3155,
+	0x3E50,
+	0x3E54,
+	0x4136,
+	0x4137,
+	0x4144,
+	0x4145,
+	0x4146,
+	0x4147,
+	0x4148,
+	0x4149,
+	0x414A,
+	0x414B,
+	0x4150,
+	0x4151,
+	0x4152,
+	0x4153,
+	0x4154,
+	0x4155,
+	0x4156,
+	0x4237,
+	0x4242,
+	0x4336,
+	0x4337,
+	0x4437,
+	0x4966,
+	0x4967,
+	0x4A48,
+	0x4A49,
+	0x4A4A,
+	0x4A4B,
+	0x4A4C,
+	0x4A4D,
+	0x4A4E,
+	0x4A4F,
+	0x4A50,
+	0x4A54,
+	0x4B48,
+	0x4B49,
+	0x4B4A,
+	0x4B4B,
+	0x4B4C,
+	0x4C57,
+	0x4C58,
+	0x4C59,
+	0x4C5A,
+	0x4C64,
+	0x4C66,
+	0x4C67,
+	0x4E44,
+	0x4E45,
+	0x4E46,
+	0x4E47,
+	0x4E48,
+	0x4E49,
+	0x4E4A,
+	0x4E4B,
+	0x4E50,
+	0x4E51,
+	0x4E52,
+	0x4E53,
+	0x4E54,
+	0x4E56,
+	0x5144,
+	0x5145,
+	0x5146,
+	0x5147,
+	0x5148,
+	0x514C,
+	0x514D,
+	0x5157,
+	0x5158,
+	0x5159,
+	0x515A,
+	0x515E,
+	0x5460,
+	0x5462,
+	0x5464,
+	0x5548,
+	0x5549,
+	0x554A,
+	0x554B,
+	0x554C,
+	0x554D,
+	0x554E,
+	0x554F,
+	0x5550,
+	0x5551,
+	0x5552,
+	0x5554,
+	0x564A,
+	0x564B,
+	0x564F,
+	0x5652,
+	0x5653,
+	0x5657,
+	0x5834,
+	0x5835,
+	0x5954,
+	0x5955,
+	0x5974,
+	0x5975,
+	0x5960,
+	0x5961,
+	0x5962,
+	0x5964,
+	0x5965,
+	0x5969,
+	0x5a41,
+	0x5a42,
+	0x5a61,
+	0x5a62,
+	0x5b60,
+	0x5b62,
+	0x5b63,
+	0x5b64,
+	0x5b65,
+	0x5c61,
+	0x5c63,
+	0x5d48,
+	0x5d49,
+	0x5d4a,
+	0x5d4c,
+	0x5d4d,
+	0x5d4e,
+	0x5d4f,
+	0x5d50,
+	0x5d52,
+	0x5d57,
+	0x5e48,
+	0x5e4a,
+	0x5e4b,
+	0x5e4c,
+	0x5e4d,
+	0x5e4f,
+	0x6700,
+	0x6701,
+	0x6702,
+	0x6703,
+	0x6704,
+	0x6705,
+	0x6706,
+	0x6707,
+	0x6708,
+	0x6709,
+	0x6718,
+	0x6719,
+	0x671c,
+	0x671d,
+	0x671f,
+	0x6720,
+	0x6721,
+	0x6722,
+	0x6723,
+	0x6724,
+	0x6725,
+	0x6726,
+	0x6727,
+	0x6728,
+	0x6729,
+	0x6738,
+	0x6739,
+	0x673e,
+	0x6740,
+	0x6741,
+	0x6742,
+	0x6743,
+	0x6744,
+	0x6745,
+	0x6746,
+	0x6747,
+	0x6748,
+	0x6749,
+	0x674A,
+	0x6750,
+	0x6751,
+	0x6758,
+	0x6759,
+	0x675B,
+	0x675D,
+	0x675F,
+	0x6760,
+	0x6761,
+	0x6762,
+	0x6763,
+	0x6764,
+	0x6765,
+	0x6766,
+	0x6767,
+	0x6768,
+	0x6770,
+	0x6771,
+	0x6772,
+	0x6778,
+	0x6779,
+	0x677B,
+	0x6840,
+	0x6841,
+	0x6842,
+	0x6843,
+	0x6849,
+	0x684C,
+	0x6850,
+	0x6858,
+	0x6859,
+	0x6880,
+	0x6888,
+	0x6889,
+	0x688A,
+	0x688C,
+	0x688D,
+	0x6898,
+	0x6899,
+	0x689b,
+	0x689c,
+	0x689d,
+	0x689e,
+	0x68a0,
+	0x68a1,
+	0x68a8,
+	0x68a9,
+	0x68b0,
+	0x68b8,
+	0x68b9,
+	0x68ba,
+	0x68be,
+	0x68bf,
+	0x68c0,
+	0x68c1,
+	0x68c7,
+	0x68c8,
+	0x68c9,
+	0x68d8,
+	0x68d9,
+	0x68da,
+	0x68de,
+	0x68e0,
+	0x68e1,
+	0x68e4,
+	0x68e5,
+	0x68e8,
+	0x68e9,
+	0x68f1,
+	0x68f2,
+	0x68f8,
+	0x68f9,
+	0x68fa,
+	0x68fe,
+	0x7100,
+	0x7101,
+	0x7102,
+	0x7103,
+	0x7104,
+	0x7105,
+	0x7106,
+	0x7108,
+	0x7109,
+	0x710A,
+	0x710B,
+	0x710C,
+	0x710E,
+	0x710F,
+	0x7140,
+	0x7141,
+	0x7142,
+	0x7143,
+	0x7144,
+	0x7145,
+	0x7146,
+	0x7147,
+	0x7149,
+	0x714A,
+	0x714B,
+	0x714C,
+	0x714D,
+	0x714E,
+	0x714F,
+	0x7151,
+	0x7152,
+	0x7153,
+	0x715E,
+	0x715F,
+	0x7180,
+	0x7181,
+	0x7183,
+	0x7186,
+	0x7187,
+	0x7188,
+	0x718A,
+	0x718B,
+	0x718C,
+	0x718D,
+	0x718F,
+	0x7193,
+	0x7196,
+	0x719B,
+	0x719F,
+	0x71C0,
+	0x71C1,
+	0x71C2,
+	0x71C3,
+	0x71C4,
+	0x71C5,
+	0x71C6,
+	0x71C7,
+	0x71CD,
+	0x71CE,
+	0x71D2,
+	0x71D4,
+	0x71D5,
+	0x71D6,
+	0x71DA,
+	0x71DE,
+	0x7200,
+	0x7210,
+	0x7211,
+	0x7240,
+	0x7243,
+	0x7244,
+	0x7245,
+	0x7246,
+	0x7247,
+	0x7248,
+	0x7249,
+	0x724A,
+	0x724B,
+	0x724C,
+	0x724D,
+	0x724E,
+	0x724F,
+	0x7280,
+	0x7281,
+	0x7283,
+	0x7284,
+	0x7287,
+	0x7288,
+	0x7289,
+	0x728B,
+	0x728C,
+	0x7290,
+	0x7291,
+	0x7293,
+	0x7297,
+	0x7834,
+	0x7835,
+	0x791e,
+	0x791f,
+	0x793f,
+	0x7941,
+	0x7942,
+	0x796c,
+	0x796d,
+	0x796e,
+	0x796f,
+	0x9400,
+	0x9401,
+	0x9402,
+	0x9403,
+	0x9405,
+	0x940A,
+	0x940B,
+	0x940F,
+	0x94A0,
+	0x94A1,
+	0x94A3,
+	0x94B1,
+	0x94B3,
+	0x94B4,
+	0x94B5,
+	0x94B9,
+	0x9440,
+	0x9441,
+	0x9442,
+	0x9443,
+	0x9444,
+	0x9446,
+	0x944A,
+	0x944B,
+	0x944C,
+	0x944E,
+	0x9450,
+	0x9452,
+	0x9456,
+	0x945A,
+	0x945B,
+	0x945E,
+	0x9460,
+	0x9462,
+	0x946A,
+	0x946B,
+	0x947A,
+	0x947B,
+	0x9480,
+	0x9487,
+	0x9488,
+	0x9489,
+	0x948A,
+	0x948F,
+	0x9490,
+	0x9491,
+	0x9495,
+	0x9498,
+	0x949C,
+	0x949E,
+	0x949F,
+	0x94C0,
+	0x94C1,
+	0x94C3,
+	0x94C4,
+	0x94C5,
+	0x94C6,
+	0x94C7,
+	0x94C8,
+	0x94C9,
+	0x94CB,
+	0x94CC,
+	0x94CD,
+	0x9500,
+	0x9501,
+	0x9504,
+	0x9505,
+	0x9506,
+	0x9507,
+	0x9508,
+	0x9509,
+	0x950F,
+	0x9511,
+	0x9515,
+	0x9517,
+	0x9519,
+	0x9540,
+	0x9541,
+	0x9542,
+	0x954E,
+	0x954F,
+	0x9552,
+	0x9553,
+	0x9555,
+	0x9557,
+	0x955f,
+	0x9580,
+	0x9581,
+	0x9583,
+	0x9586,
+	0x9587,
+	0x9588,
+	0x9589,
+	0x958A,
+	0x958B,
+	0x958C,
+	0x958D,
+	0x958E,
+	0x958F,
+	0x9590,
+	0x9591,
+	0x9593,
+	0x9595,
+	0x9596,
+	0x9597,
+	0x9598,
+	0x9599,
+	0x959B,
+	0x95C0,
+	0x95C2,
+	0x95C4,
+	0x95C5,
+	0x95C6,
+	0x95C7,
+	0x95C9,
+	0x95CC,
+	0x95CD,
+	0x95CE,
+	0x95CF,
+	0x9610,
+	0x9611,
+	0x9612,
+	0x9613,
+	0x9614,
+	0x9615,
+	0x9616,
+	0x9640,
+	0x9641,
+	0x9642,
+	0x9643,
+	0x9644,
+	0x9645,
+	0x9647,
+	0x9648,
+	0x9649,
+	0x964a,
+	0x964b,
+	0x964c,
+	0x964e,
+	0x964f,
+	0x9710,
+	0x9711,
+	0x9712,
+	0x9713,
+	0x9714,
+	0x9715,
+	0x9802,
+	0x9803,
+	0x9804,
+	0x9805,
+	0x9806,
+	0x9807,
+	0x9808,
+	0x9809,
+	0x980A,
+	0x9900,
+	0x9901,
+	0x9903,
+	0x9904,
+	0x9905,
+	0x9906,
+	0x9907,
+	0x9908,
+	0x9909,
+	0x990A,
+	0x990B,
+	0x990C,
+	0x990D,
+	0x990E,
+	0x990F,
+	0x9910,
+	0x9913,
+	0x9917,
+	0x9918,
+	0x9919,
+	0x9990,
+	0x9991,
+	0x9992,
+	0x9993,
+	0x9994,
+	0x9995,
+	0x9996,
+	0x9997,
+	0x9998,
+	0x9999,
+	0x999A,
+	0x999B,
+	0x999C,
+	0x999D,
+	0x99A0,
+	0x99A2,
+	0x99A4,
+};
+
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
@@ -1253,9 +1806,15 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	struct drm_device *ddev;
 	struct amdgpu_device *adev;
 	unsigned long flags = ent->driver_data;
-	int ret, retry = 0;
+	int ret, retry = 0, i;
 	bool supports_atomic = false;
 
+	/* skip devices which are owned by radeon */
+	for (i = 0; i < ARRAY_SIZE(radeon_pciidlist); i++) {
+		if (radeon_pciidlist[i] == pdev->device)
+			return -ENODEV;
+	}
+
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic = true;
-- 
2.31.1

