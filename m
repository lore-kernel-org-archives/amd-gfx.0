Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991DBC7113B
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C33610E5CB;
	Thu, 24 Aug 2023 21:53:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AAF10E5C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Shn6a7F6fWQp+9nTPjjT2YpXwfO70Tr9OmlsSLFPdG55LouLbflr/FsJHUtfOMbvkNwUfvI62t9gxU3TfraWGU5ECkHc0oDD88ON1g9g/zlPBcMIezuo4LMIBP1keXzCExJHGD+szfhObI2Enq0b+M9EEvEtdQmLZ7b+c2Jajud626H+Ge03Pwe1WycbTc6Z86K1iry4XmohF09wtUrdTX8e5ioqrSik+SqU7F/OI3TrYdtdo2Odsdhod8jH4bWO/lhwrRBRd3mSAsFoeqKIIs0041aWgrN5EzEwvBYLnn5mNGeDsZMGNulf/5D5srQNVUF/D8VFEwLm6tZZXIR5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F//lZfL6y6gn1ovWzowjXQk83h37dcC25X13wKjgWHk=;
 b=nPM7p8tUIRJBn8osUNsx5cbUIzRmgGvKDhkIqRbgNhmuutuC2VpaWjSNrI1oRTzALRuvoT47Ogz3bYgVxoVy9+fRuX0AvqsG5vH+FEVR7x1t7jSAojCBZgSiVc7kZL1NHRjSwnN55mEB+Gi23o5m7PmsKFywcWxH1iDumTMpxh81RKI3pl+/9xnvvd/lgVLdYJOzg34rNeqyzz+13mATj2eE+qt0bFJ0gGfr/LVjgfh9wcG66VGgFtJKjwPx0yAz4uLbz6jk4VN8z1VQlktpodm8TRqQFFnfzEXzZNuO44IZtJoIvtc2ZZYwfDOW6HCrdt5/lSzH6lf4tvGTcf15Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F//lZfL6y6gn1ovWzowjXQk83h37dcC25X13wKjgWHk=;
 b=kbWZCYIDikGhYXgRnfEfxs8zELiWfrLVrSF7Y7k1lpkENwXQYpykdtfsoQ0eBqJp1uAa2TP1Ukmfgh6kWI5H7vSpZce48JSq+B/mTAS6uGwa+A2+NIu8hYbj2snS822n4TuYWXY4TQAz98n+lugaIMMT4GwwnyV6dtFgtda6wao=
Received: from CYXPR02CA0044.namprd02.prod.outlook.com (2603:10b6:930:cc::12)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:53:17 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::1c) by CYXPR02CA0044.outlook.office365.com
 (2603:10b6:930:cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:53:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:53:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/9] drm/amdgpu:enable CG and PG flags for VCN
Date: Thu, 24 Aug 2023 17:52:57 -0400
Message-ID: <20230824215301.2739707-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215301.2739707-1-alexander.deucher@amd.com>
References: <20230824215301.2739707-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e13ce3-dac1-4e49-3b96-08dba4ec861f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXxo8SoMxYuI8p8hS5N+tAg/mnsFMu4SXKy9obLw7A+qHmNNipXn9KxYCf/mK6o1zdSQRNdBt7e9Ddq03ZcAF8OL7A22n/J0wX1pZIDKC378CRZf58JuV9rY3LwKaONWqsqYldGpm7wd1wuKra0n/WExdRgHiLBOHwVPl8q/x52R/PyCQvo+rsU/3TQp22JjkCsrtwIJ1d9x8/MAIKb+4utbDX0ceY5Tbgmk18poCotJLnFd0um8/njpyj7RS9LGcJmE5v8VDty7Z5c4U2SyGoNzdtOFJ2CDnmXr01FzpwngNPQxVMuSDuZjXLmUzvAub6zYy2PDI3BSv9JKMEWb/jg/05q5Zm+U4bqk330EpqXyVJZUgwZywYj2fMj04RyHPzNg+cg+DrnQ/Cn/3BQH89w/GOWZ1/5ZyoF4GLNcyqM98E+w6h9hNGubm9JPvESLZWSKojp83nGAb+KOM4Gkq9iOWNk9yTWoJGJcXT6OMs5NvGjMdcN4JpNwOrHWapzGcIurcv1gbNokjfdWgcRuxdDj9Ax/qmD2EnIieq8T7g6j5tExqSH/UXLaIopOHbwNpPf9zqDNfC+IfyZDh+XfBbHLGMGfg0Wtf22bxHT27OYIXB2soI0ZJH6qCzJ/9Y8GW6N6mDDHWyLpx4ZMx3DS0/M24SfX8+7NwyP2qri2fRpIiE6cHLov9YB0YhF9mLtahHlFGXl/blA8x9eKvh+TMUAPb7SG8C238h7KwNe62QDE7nUsDidnL2uBgB0PuqR4E1EPM7KjvvcAv1MNhkGCZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(4744005)(83380400001)(7696005)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:53:17.1394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e13ce3-dac1-4e49-3b96-08dba4ec861f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Enable CG and PG flags for VCN on IP 11_5_0

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index cad57afa89e4..bb281ee3bd15 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -691,8 +691,10 @@ static int soc21_common_early_init(void *handle)
 
 
 	case IP_VERSION(11, 5, 0):
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
 	default:
-- 
2.41.0

