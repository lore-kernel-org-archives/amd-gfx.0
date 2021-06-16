Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E013CC48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 12:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D29E61359
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 12:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D29E61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC746E02D;
	Wed, 16 Jun 2021 12:30:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D91516E02D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 12:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVx+0yhlQa77edpDTbIzhTAEObZopjVz+9tv7c+Uvrdr5N+xjCHulxd7Lsc2jNO+z07hCsQEVf3IEkuKbFNxUj3Otue8BWa2K2JznJPAeCCY5M9PjbK0hVMbU7RwiYKG2l92Y3GnOHgsfsjVMKJQQUrng+khX1mDIXIuUjF/GJBvI32/+SGd9V+2Y1j957K14IsxTEDLRFknI/P+lAUfJ/mLgFh3vHYikMBmrBYq7AIqN3Wbo/73IWmnQh4LpQfNgaimSnx/iPghCZAbSqi3X2yGEM5NEKePqoNjTAvnnQKeTsgVfwteLI3woCe689n+Q9m27/ASuMhH4hOYUfcf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGbnCUJDRGXn4vYCaLmQVUafmBU5Cl+gSk2sZVaMu5M=;
 b=UgnrLtSQ+62WjaPu9FBugiptVbek2RhmAadowmX7ukiaT5KEnJCHHvnn6PO12RYG5QepjomFM+yzyhwVlhPbhRe6ce1zkKWiMGmRgoWEE/dEgaOTcYFD8kdkDARouGOwnFmBewNgS90Q8ylF6eNesScZDvFEq9Obcv5BPZQJzrCfRoszNOX/89E61nrwXSXHoxRZRZMtCpmJEzdSHACHWo37YbwazO2FZhaSypjl6OyjtslQUyq+9gh6QPqfJ/muWN6U/GV7uqTlwrI1mbr+qVfQE0SCfITxDNKvm3qs2/Rn9Vy1vNQ6nFIEslMpGvgmz2FrnVW56Migf/BGE/LUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGbnCUJDRGXn4vYCaLmQVUafmBU5Cl+gSk2sZVaMu5M=;
 b=XG4KwAyIoxleQvLtfG/qtloKDbHJ8pjK2wv09zbPnHrmcw7SLHs0m2u1gWi8i2BW8Go+/HKf0rlIzxi35RJG75AGeCAvVq0VsmGQxKjQZbSU8aMwYOdGLXC8G0VdwDnbc5UtjFD60NsBXdFHEhsJmkw3LIZDTHM39xvjYk+RiH4=
Received: from MWHPR1201CA0020.namprd12.prod.outlook.com
 (2603:10b6:301:4a::30) by MN2PR12MB4271.namprd12.prod.outlook.com
 (2603:10b6:208:1d7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 12:30:44 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::f4) by MWHPR1201CA0020.outlook.office365.com
 (2603:10b6:301:4a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Wed, 16 Jun 2021 12:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 12:30:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 16 Jun
 2021 07:30:42 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 16 Jun 2021 07:30:41 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: force enable vega20 gaming sku gfx ras
Date: Wed, 16 Jun 2021 20:30:40 +0800
Message-ID: <20210616123040.32629-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4621deb8-16a4-4ab2-b97c-08d930c28f7a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4271:
X-Microsoft-Antispam-PRVS: <MN2PR12MB427193E0CA60B141DB25ADFC9A0F9@MN2PR12MB4271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWfZAS4srbrun7gy9y0F+Bx0xM05aYEGZDyT/QBF9KbFGPuihGV7PhhaYhQOh1Qa+lcuvnsDCK/NORoA0wmE1AT6+7p26r4UA3KRhcy8wmV2Aex58m8dbCI44fjFr/tIrI93+MDolsnh1hPrRB/OtsimIfAr7kRR81nn/tQ2OCmtwbKR9IDLj7kiNOE+eiCvP0d3yzAIV+rU8Six3HnS4rFHlLhblLN3l2h4nb9H71BhceQmlJCQmEF53KprR4M02yU6cLmp/a5jqwTQQnbmXeAzZn6Y+XBtma471mgVDuuxc6I7JHRNJ90sryiOAxouDoQ6ibfJZhCASN/Vv7gBfSB1NLqOKQnruUM/0AFuo+UTkZVfuHNRP70hqoRLcMEdHTeic9omGwqw7+OFrNARCjyQQCUuRHS45xTGeeNHZS5Sh039ktbJbSh8OehwHDF5Jl2hbWMzmRIN8aVKMr9+SsYQhZ9wN1lCHiOBWOycf+Zlr2XWWd/FEpX8ewM4sBIgDrm2a7cn0VWyK4Whoc9OeehzArWF8IX5loSGXHlbF2Lui0hOLV9RR1uSRvXHshWS9AXYN63Cdg2wXAfKJu6KXejh5EhR+FgU6AawMiPSs9MsjVeabdwfSfQjBaLbiVJtKzJWJE6m7GpqjdEoM1UHHf+dPLvTnPEf+fO0avQ4cCl5QcxEtd59RoYXRRhCSp1u
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(36840700001)(46966006)(70586007)(5660300002)(4326008)(1076003)(6636002)(4744005)(70206006)(82310400003)(478600001)(36756003)(2906002)(26005)(186003)(426003)(8676002)(356005)(81166007)(7696005)(8936002)(82740400003)(47076005)(2616005)(86362001)(110136005)(316002)(336012)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 12:30:43.7030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621deb8-16a4-4ab2-b97c-08d930c28f7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f404c2321a6a..ca5a32944242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2083,7 +2083,9 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
 		return;
 
 	if (strnstr(ctx->vbios_version, "D16406",
-		    sizeof(ctx->vbios_version)))
+		    sizeof(ctx->vbios_version)) ||
+		strnstr(ctx->vbios_version, "D36002",
+			sizeof(ctx->vbios_version)))
 		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX);
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
