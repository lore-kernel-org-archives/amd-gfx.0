Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBDAC433B4
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EC661029
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EC661029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98486EC7D;
	Sat, 10 Apr 2021 02:05:07 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E1E6EC79
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HulTdPSLzNOz4/Aor4O0xUSmIN4OOl7Y9n6i986GiA7liL8zVyN/7LuXZzpId/pvP7QpyfgXQnf/t2f1j3xExUZhtTZnh8YpYZesO6mLnPK6bJCHvcHesen6Q1eTaBXZ+lE0msBTrFHIz9bNcEFLZF7Kc5xELe3UEyTNrYQy7MG4H9mMi7EqqXdz793UyhU6vrTlZjo2K+JVfm7mMW/LoFO/Ah63BikZBqong1K1N+/xyANFfuV3He+s6FgR2fr7o9wFXN7eRw1/0kIr9HSHt113e5ljNIIyikY9mjX8bANqxmvPsIKj83qsY/snzZOzEhb1hVJFLERxZGW0WCteSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMRBaqSK+76xqQm51RWXGp1ynCfwU7du+0b3fm/hbvA=;
 b=cHbLu735QhxnA4ZiplPrxzCwPQ0UHYuEajXlcGJmlMr/zYgoXYGSbOcQYQnMVjPgT3MaL8M3jr8YTForlyoTrTPxNvCZRXV9r4LVoctiQsG7qzPjVhNDg3FVMnT1VXf2uG23ElKok6fcDk8t7bdDQ3Ky/17NBW3Sm0/8KLAY2C7pIZOt4wsl5CDTAx4LxTbOO2qSuzZ1H/3k+7DHO4IfyUGFEeg1oDdfaVJjuU4t6SxWhVLFg8THZ5+ttYQQxvNO+gfplHnw+4AqnEldcjns7ndYzTnZ3y+jclRSNX2w90vl7AUOF9b7CMKw+hwEr/ccNR7ACaxCLWTvOJJEFLHsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMRBaqSK+76xqQm51RWXGp1ynCfwU7du+0b3fm/hbvA=;
 b=sMeuDdWmCKCUWIHlYfyKdJerkpZXsTM24pnvZgYI+f8sb8yDA/NBH1r9BodimyQt6QhIE9Ver/K1Z3oURD8tUcN82OlNmX68iH4RMpcu6ZBs6lqf91NnKSL9Ls9bO91HLGH2c1wXxW6Nyy70/0N89jIjka4x67hXGCV4Ln4vQGQ=
Received: from DM6PR10CA0024.namprd10.prod.outlook.com (2603:10b6:5:60::37) by
 MN2PR12MB3341.namprd12.prod.outlook.com (2603:10b6:208:cb::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Sat, 10 Apr 2021 02:05:02 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::99) by DM6PR10CA0024.outlook.office365.com
 (2603:10b6:5:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Sat, 10 Apr 2021 02:05:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:05:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:05:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:05:01 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:05:00 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: 3.2.131
Date: Fri, 9 Apr 2021 22:04:00 -0400
Message-ID: <20210410020401.1100228-16-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edef3ec9-c3bb-4680-3d81-08d8fbc50d86
X-MS-TrafficTypeDiagnostic: MN2PR12MB3341:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3341E28994DA71E794391C85F5729@MN2PR12MB3341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TM8yOl4TcPt6dfu70StrJCMSbCXhU5mI1bqBkb/Ce3jBGmi61gnItsnl+3hdP3n1WvIcTyPSYC1vycBcJqq0YxS4q+PBJbFsbTXRPbWTQbMuXCiUjzVgeM5TMgC5Rcv6ZW8qNWuI8GI5EC0+VwCGgSIfcwrTzgCKWyBSmHp3jCD58DuFEVuTs9sJewfbKyn1emkFhLikCn+mYXSQ0/hmKnXMJqo66OfcRKRKDoKI+/jzxuk7Jrc0qwpD1y3L3rLFrAbHm3xrWVkqjTTDizheQq3t+THXnYcSlZZ3o4FsI1MS4D6ZGYqxbgyow7F0j9g8pmYN57cma9vNyueM8d6rYMe1jo/JuLvL1WQ1pjsKhnkNJ+r+Phr1y9SoEx8Xx73AasKYTIaJPreMYkFzQ6cfMcvEriaEb8Gu0ikJAeNclxe0W6/Avhbqm1CbqpDlX7dxAayshG305bm+HQmGVaZ1DGRdu6yMrFCzpGax5QPv2RN64TbAzyza2m7WB09EAtj/VBer+2zVxr57A345S8pom5ZAfaiNrwYgKEF3otRn/LdOF2jtxPFdJSpuoXGkLh3idriHQVqUBCzO93EKyuREFJrOU6jbcw2MsnsCAo0FDmNU/DUswVNdDIw7LdgkSvFsafCN05Puva82LyzRQGus/2xupVETbnAoW7oFicxJM7UTH3tEp3kTxZDfumivkyp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(26005)(186003)(6916009)(336012)(426003)(83380400001)(82740400003)(5660300002)(2616005)(81166007)(356005)(4326008)(86362001)(47076005)(8676002)(4744005)(36860700001)(316002)(70586007)(70206006)(1076003)(36756003)(54906003)(8936002)(7696005)(2906002)(478600001)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:05:02.5996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edef3ec9-c3bb-4680-3d81-08d8fbc50d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3341
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bindu
 Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC version 3.2.131 brings improvements in multiple areas.
In summary, we highlight:
 -Enhancement for multiple eDP BL control.
 -Add debug flag to enable eDP ILR by default and debugfs to repress HPD/HPR_RX IRQ.
 -Fixes for DSC enable sequence,Force vsync flip,hang when psr is enabled etc.
 -Firmware releases:
  0.0.60
  0.0.61

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4d2ea508fa13..82a324a618db 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.130"
+#define DC_VER "3.2.131"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
