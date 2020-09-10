Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D741C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDEF21D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j6SD/oLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDEF21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322B06E95B;
	Thu, 10 Sep 2020 13:47:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770072.outbound.protection.outlook.com [40.107.77.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 737D56E94B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E29HpvsEQm2TvSDFWCF0unr0mFcMpMvzeeXqaWpnlWa9j0R1thyY+5OY+GbCYDTrjxXOixO6Ft14HwbHC/DFzkXxsFVKMvpHNqvemdRKMas/fy/GREognARO5gUHuTLC14x4RyPgiWy01ayoLDkWm764zXmUty0zLu0L/oQ6W4AO8z2ufRePu+qSgzm0W+mWT9exDhcgx+rJXDvuuE9ZUaeXA4uLTYycgDEXdv9d7qhtLl8YUQctXd+4z9P2VGzxbCd65lMvwoRlOZLynZmMhTxK6mibiheaDVB8WCSuprx8qBViMQf0TTzTt/6RfMn7Vd1R68Xz49V+vATE9bCceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAKMSLfZs0He/qu20K6Xt45zF3hxqmL77IEpoSwk644=;
 b=RiUDtdqpgIDERCWOLUU92Gh29gbNt/xs6L8l3mPny9xpnQEg5EehFTmFEnQOWgqnD3i54EcM2jMmp4HdKSvf1O8nwJDY2okYxM38vyvQVkyA55EsKZ7QIUyn5v5RWWHtw2PdmcRhUsYG4JiuXmn/iPqS3aXnzLHR1cv1jeZVHdBxSGpRFjLQLate5JYHOE3Pldhh8ZrOciaeIq3tP0X2HkuB5dVsWKYbbQ5l2tKBtt8Pr8kOxK6Qoaw+ceHh2aIbfmqLfy0k3ji+kvff+5d0DSLMcpJuscGR1dOmAwGVcPfW/ESq5ZKMs89lpqQjLfA4P4zEBZaB2HWQ1JTWBJihbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAKMSLfZs0He/qu20K6Xt45zF3hxqmL77IEpoSwk644=;
 b=j6SD/oLY7cC2KQKtF464HfdJ0jWGYLDMy1hdUGe77gM7t9pAxogBUSS9pXR99JifM7EaCit8LTnva9HopeBsyqLtkHPB2QfMWcQufwGde5/bTnJe9th4FHONsR9K2tHX39/ArEiUJZvzoazESgKm02LK9fcv0SG7X0V9YAT3Aqw=
Received: from DM5PR19CA0003.namprd19.prod.outlook.com (2603:10b6:3:151::13)
 by MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:55 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::5a) by DM5PR19CA0003.outlook.office365.com
 (2603:10b6:3:151::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:54 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:54 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:53 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/42] drm/amd/display: 3.2.102
Date: Thu, 10 Sep 2020 09:47:11 -0400
Message-ID: <20200910134723.27410-31-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6baad963-8472-4369-ee63-08d855901ecb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1629:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16290ED01EAB6877E01EFD9C8B270@MWHPR12MB1629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R34AZ6ymT8Rr5dumvOePoD49oaEKrSNdhP9YS2wi4iMf2l/aLhDbSuKp6QA1BduH/0qYD9abJuwi9O9AV9TI114J+2axghrm72jTVh3zLUKi7Pk7pdzcxgpQA1VTe92tIL4jiS/tB9xkbVXYZA29FurQuJNzdN7WuagdNsZjCdmx/GiNjkBhzLTAxXchwaI6+o4/0FBdQ9udmLXgMFMGdKa3rbw6rYwNUnoHMdhJsl2kDwte35l66FGPMfP2kicYdXfCaqtlRom8G/TgW2l86idQhDLpvnmvXBwGVtf8dHfZeTPFJvGpbbBfOh3saJ2Q6W06HO/LpuxBVSGpgc5Y6s4HiNNGU2+OZ1880qMebDmIgVGaaH4m1q6mO8weGHDO9QJUN0SyBmp0/BGq+fLRhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966005)(82740400003)(2906002)(86362001)(81166007)(6666004)(8676002)(36756003)(186003)(316002)(336012)(478600001)(4326008)(6916009)(426003)(54906003)(7696005)(8936002)(82310400003)(47076004)(4744005)(70206006)(26005)(70586007)(1076003)(2616005)(44832011)(83380400001)(5660300002)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:55.2278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baad963-8472-4369-ee63-08d855901ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1629
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
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 464f2c657597..8631d290afee 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.101"
+#define DC_VER "3.2.102"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
