Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD67C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68E2610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68E2610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833826EB9A;
	Fri, 16 Apr 2021 14:34:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDF76EB9A
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4HiDJtG+ISeop6Sdd8UqTDmkK95knsdtQXZ7NlYm4vApQAKN/mywDMuluTy2lBIg2r19ZTqg0uzD96aKNWC5xyP2tt/02Jvu+ms24ZRJTHmaFHwl7pQDzMNG2bEEUBz5u3g+Eh0S4FL1YBQAhkO+4g1qZWjbNx/SGPuQnmADcHM11h6iiOetesW/TEX+1Vf4/NSlTsGrbH1sYidvveQF4mth7MZNrM4tBmpMgreekrFR/fGPRD1YT8/PTUAJHSMmCHfRV5FpprJ2ODKhiAilPiYZ429PAXtn8P5qkiQHqJ6gwIBHs3rOjNzlUynHFPgLwQX1RgUdIoBvntguBn4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yLOTUpIJv2yZQFzqI4wAtWdjXGJFx6JeFtSFxJ2Uyw=;
 b=cQXRpRzN5Nxexr8LLaHmO5G5eGm0E1JbdFxkAl1qbRPbrGFx1WnLvQYITNRs/YQ/Iz8KD9WcZE3iNWOOmHeEJ3lPQEDD274Q9hbkMzefUHp6OcYoJdPpeXBR8MTGVKZhuMuErxJlQhYSOrfhizTD7rXzKfYwY+tSXh1cwaq2b3ZqfXBNOwa2pWVVIEKvyS3WEujHAHuNAbHbCW00V4laSFJQvHCHyahXznPY2WqrlQgotGGS7OT3Ad3jSD7mwdzmAgC5xU8zZEAvo/6wWiu9xGwUlQK3PMB1xJ5618QBnMSTH2vIBN+Xm4ZggzyjFk78Y0cWkMOMB5gqnmmMJLXT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yLOTUpIJv2yZQFzqI4wAtWdjXGJFx6JeFtSFxJ2Uyw=;
 b=JXYOSUbdvQQUP53vM09gGahYjF9wk681evZ4xdS4JoO3Huy+hqrwWjUM9SDa7+cSyAqfLOKZ5r13a4kkeuN7mRUKUHXsuiKpTJkm46R1ZFcGHpUpQ3BKuhRJoobCNNXYIXkQvaWfGINk3MPV+0E3tB0m1+ZP+vgKRYyd6+xwIGA=
Received: from BN8PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:ac::18)
 by MW2PR12MB2522.namprd12.prod.outlook.com (2603:10b6:907:f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 14:34:54 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::54) by BN8PR07CA0005.outlook.office365.com
 (2603:10b6:408:ac::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:53 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:48 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amd/display: 3.2.132
Date: Fri, 16 Apr 2021 10:34:17 -0400
Message-ID: <20210416143417.611019-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c46e606-33ba-4a6b-a83c-08d900e4cd14
X-MS-TrafficTypeDiagnostic: MW2PR12MB2522:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25229111788705144DA34C118B4C9@MW2PR12MB2522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q26ob93kNlZ8dxL1XzzmXNNjPVGsCdELkpnrfh/+r2GZZmOhxnT7nH0crg0mpcfPaLjOOoCfkRZcYwwGQBNYRXVmcz/ZxfFdP8d6QNIio5l5GALiocwG/W/3kEhcfUj2hD5oXh80iyoewkp5ZR90d3KtYky/BSEJwQGPhmCaYaEDfZ52HqMCJzmfqa0I863roGt+3db5QVCRalgetGtqMxSV/7l/0QUyMGaHFd59XQzGAFuJrldJbPUio8OMj6ilUDKN3UGhbvQBhVbdIfJ+xzRbt00r4O03MBN14dbQv/ycfW8hCbT8BSd9wGt3wzX8Cdo28xb6Po+8wtaU2ndWGdCOpjS5DpJ35UhTjSm7DcuxrVfobSUOnRtb3OHdUYS2jGYel9lYRwNsFyZsH4JcgBGVT8zu71oHGcBCjufi4pPADY0Gu2PXeKmoMGjhgzrP1DYZ5T/lbsOgTaPrRW+IWxVhxhW3cV42sK3Bj5lwEDe8s8pWcbG/tgm7C4SrAPOp3wcnQ2qu8uIDZrIxJxf233QhXaiE1iZojoLF+nwt4DTYi28weh4yKnLmx10Vl5pvO1oTjFtomDpcyfzcBm6H13HDlfbMq8YwwHOLq5Ih6cuGF0lnXA5LAoAm2rDCWcAosnQUFnyJFjLGOigC/3d3HrfY7CkQN0Q5xBFaLkoea0nwYZjndzc2ImCjy+Qf8y7A
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(46966006)(426003)(2906002)(316002)(1076003)(82310400003)(6666004)(47076005)(7696005)(82740400003)(26005)(70586007)(8936002)(36756003)(336012)(8676002)(6916009)(4744005)(86362001)(54906003)(186003)(2616005)(83380400001)(44832011)(356005)(4326008)(478600001)(36860700001)(81166007)(5660300002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:54.2422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c46e606-33ba-4a6b-a83c-08d900e4cd14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2522
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ed19b9b39af0..100d434f7a03 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.131"
+#define DC_VER "3.2.132"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
