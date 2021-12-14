Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E40C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA29810EBEF;
	Tue, 14 Dec 2021 03:53:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3555410EBEF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN1p5feTwajrjnrNjHD7RTf+8dSl3gFkPaR8GTeoxdXzimOx/2FEh8H1/e68BcLWtWd24C27ZZPy+EbG/NxdzLvQAWJEVJui03QhcUf0zsQKbZtQNuA33simK01H7dgdjixw4yIb3G1LRT9SzpI5TN4PgupjhfH8ZLF4fqH8ZKZl8uTyuxgcErOKotnTeC27O5nBJ2LweCQIV6U0GIJsybqAfdhQKKnymREuRhmPIVxTMwMw8am4HvJhZ2ybAK/vjMRG1KzTKMUZKMUwd4LBro71eRy8udPM5L/ltVbHMtl6TPZsBzNa2Zg3GA2DN8pgwLuoVki3zj7Pn5Wea3Tv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn654liPe4ydNRWpuvvXLO6HTv9Nat7m3uEuYOBwL9c=;
 b=S9PRmNQo3uRlPszYzBMBCtgH1h/iLsle6BPXrdPD66CAT680Gq/PS5fymBQy2Y1Mh+c1ZdI9zsH0/6ofHIRs67bSFQva+45Yj6lBzVzmk6pSXoDybjFDr5/r5191EIsVxZo+p6VZZ+ZYodVBuYHnmETzsXbC+dy5O4P6kvyjKpaxZuhwD6JD0kzF3hcMJUrM5V6F355kkVnKpM8svwCEStzL+N+9hYfy5t3QW4F/LTCFUu2L9K59Pn5c+VgqVYi/kS0d7ddCHecIkuZu0/5LrvbQoa07rlXaXL0tQiGZTfU6TjQyTokuvKl+C6H4EjWixG6uDfrjyMu0Kpt1y9zv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn654liPe4ydNRWpuvvXLO6HTv9Nat7m3uEuYOBwL9c=;
 b=e1h+AjB5P4esLi9z3aRdo7+rL1vVTjTVG7FfjrSx2+mMrkH7UcspMQYHVQkblW2ac60IvZhX/xNn9XgcyWJccYRunTlt4l+4a1vgwHO103znKN4zpi9ufx6eIrC5XCOkkoP28wpBOFYkuNm4AFh4Z7izuURgRu1xCU2RGA41y7c=
Received: from CO2PR18CA0045.namprd18.prod.outlook.com (2603:10b6:104:2::13)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 03:53:19 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::ba) by CO2PR18CA0045.outlook.office365.com
 (2603:10b6:104:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16 via Frontend
 Transport; Tue, 14 Dec 2021 03:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 03:53:19 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 21:53:17 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/amdgpu: fix psp tmr bo pin count leak in SRIOV
Date: Tue, 14 Dec 2021 11:52:52 +0800
Message-ID: <20211214035252.15798-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6d93f25-8287-4022-a026-08d9beb54459
X-MS-TrafficTypeDiagnostic: CH2PR12MB4069:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4069D8F98F57738E0A9CDD4FB7759@CH2PR12MB4069.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/JXRoS+Gx6NE9xqsnGPhOH4bQyCrCBs2UwcQg/kV5l7UPd9RLYPBWZAvDLolx0yqRlZSyd908DUQ4cwJvh07qtE1UcCsilhH97it6gTdiKMThEZiz1I4aQS3wQ6dIhQHEW3hWpcMXjdlzK+o44npWZHjoqRT5ZI5ahjK3smiD68B268yxwHTSu0utlFFgkAaA+9ZbEtVoXapLpchW9KPoX54G6zGmFxnQ+QY8HC7Kpg7YytZ+hGg+yHcvTHlESJDU9QxA+n04oU9tfNCthzBAfjcbdTxouK5F/xzvBrV1LYzJLOK9kHxvPdrJXC14nqw/nenvqLPDlDYSsndIXyTtfWl5RMSEUYRnOdOdsLAYCFq1N7wIehrrJtkb/8LCdouPm3wa845T0C10Rng7goOBz309eZKrFo0V2gblkZ2Q9xrzV+68yXRYY6jKs6AAiMMITNwITdcMO14BVtrog8xMGHguktoniBPXmH0OwBmmlFbVa8dnUewQ9sOUoyoKZ0SuAEVRoSNFcSqvQyIBZn2KOnMnVyw5v4NMBkBuYJ4ezfGKTlr/GaYIxV3wgAaNdcAnhIylwpcUn3LKQA9HtB4VeovIyIw1NsAWNOmPJuHfi1PNS/ztHcGJu3TvIl9L6Q7EWMitlIqaXVJWwQM4j9/rsn7WCOApe9GYKapWk228KfeliCcuJdYYAPvCLxT1vL/4A4g8jVecninvkeQ1DSHT+FzT9H7iYNHyoe0ak7Q9kzBY2MRmOl2eJRkhf8nlRVoB/ly/2/TWtZWBBzM07k8soqSZ1Q4g6Qle409Ngd92o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(2906002)(83380400001)(8676002)(36860700001)(70206006)(356005)(6916009)(54906003)(16526019)(1076003)(6666004)(186003)(508600001)(81166007)(426003)(336012)(4326008)(8936002)(7696005)(82310400004)(47076005)(36756003)(40460700001)(5660300002)(70586007)(26005)(2616005)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 03:53:19.3155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d93f25-8287-4022-a026-08d9beb54459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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
Cc: horace.chen@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
psp tmr bo will be pinned during loading amdgpu and reset in SRIOV while
only unpinned in unload amdgpu

[How]
add amdgpu_in_reset and sriov judgement for psp_tmr_init

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 103bcadbc8b8..19c026c47c96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2017,13 +2017,14 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_tmr_init(psp);
-	if (ret) {
-		DRM_ERROR("PSP tmr init failed!\n");
-		return ret;
+	if (amdgpu_sriov_vf(adev) && !amdgpu_in_reset(adev)) {
+		ret = psp_tmr_init(psp);
+		if (ret) {
+			DRM_ERROR("PSP tmr init failed!\n");
+			goto failed;
+		}
 	}
 
-	/*
 	 * For ASICs with DF Cstate management centralized
 	 * to PMFW, TMR setup should be performed after PMFW
 	 * loaded and before other non-psp firmware loaded.
-- 
2.30.2

