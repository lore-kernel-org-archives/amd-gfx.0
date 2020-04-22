Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93003C5518C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A332071C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z1ydtepm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A332071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B856E141;
	Wed, 22 Apr 2020 22:08:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6444B6E141
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRQzU9kAmg26KOjTv63iWJg1YQW3esLXagqaXucd7fto7N8hHXXgBJe71sEit3GXIXQVhqevnwnsn9D5Fv7WuilVD9XTqllGS6LI1KbtXk0hjW1fYZRMQYUuuul/ezmHjR95eiHLfQlQd1Vplyri6eqGVv8yF4YOsurS8s88bi+V1nlXkzUs63nI+GPCoYfg1AxI+dC9WJ1uYWqTOSnGtNZNBb8msXjl4VmPrHEfZGinlVE9gm+OSkPDqMYgjrKAqh/0VV8f4Bdg3KA00IkKThFjMnL8Wx6yZKAhKKi9morUua+iGcWEQ0idhrGJ4jS4aJVovIrw/jN39OgNYbzHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUbYzLJWZxJYjf2VzyeAM1VW++EN7erl0y3RsDpCKx4=;
 b=ZN15t0msoDEPCzh1thMPlPje+UMAIyV4hrVmGM979rZbJsPH7VTlqPhOPtthB59Ok1EeI50OGepmCOeLrenYKXHs9aI4yWk4bl8mdO1kDzb+UH7AxlsGbSa/iSFC1vdyIZjHRssCufTpNyARHjA5bRu5HOpKT81kxV96Iy5+2K0kxDUW1pKoi3xQUK+G81BflcS8YArKpTPreLzUZ4dkXt0LwJXfQ/J7DrxAN71Vxjf+BsirFaKOLHEZ/Ib7CuvrnlaW8hYRYdCbaQQz/Fy2bhSmKv+gF1JVv1Tp6quE0CzHv5qJgAGw9YRrHYrA9SqZVele0xP+vQs7rNf1jIpfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUbYzLJWZxJYjf2VzyeAM1VW++EN7erl0y3RsDpCKx4=;
 b=z1ydtepmWAeefvvH+OpwyX2jAkBf1VS7mKCdsXgI+YN811A0uW4mKD7bw5QuwovmTIkl77ME7OMkK1lMP5ZTa5Uq/FrkahnQ3NvtjA9BswaO7/qTWyb3h+9OxczNPnWoYHaEzfDOzSxp1J3PXioFS4/bemTqA7GX+eR5Rc4nmMc=
Received: from MWHPR08CA0046.namprd08.prod.outlook.com (2603:10b6:300:c0::20)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 22:08:35 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::41) by MWHPR08CA0046.outlook.office365.com
 (2603:10b6:300:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:35 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:33 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:33 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:32 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/19] drm/amd/display: 3.2.83.1
Date: Wed, 22 Apr 2020 18:08:05 -0400
Message-ID: <20200422220805.15759-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(428003)(46966005)(5660300002)(86362001)(4744005)(8676002)(8936002)(316002)(478600001)(82310400002)(47076004)(54906003)(70206006)(36756003)(1076003)(7696005)(6916009)(81156014)(81166007)(4326008)(26005)(44832011)(82740400003)(336012)(356005)(6666004)(2906002)(70586007)(186003)(2616005)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f051b80-9f20-467d-00af-08d7e709b391
X-MS-TrafficTypeDiagnostic: MN2PR12MB4455:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44557EEBA5FB207B84CF23888BD20@MN2PR12MB4455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2J3pMUP1Wd7Pz/PZoddXgHA6axGd3X+SfjPNkavXm0/1/5jGAPpjZOmgiK8dKQGgm6bC7HqyX2GpM28vdWEySc+sKe1Q2aDX73M+Ulj9bZxkVvwQqFtuvfdoKb1SMMCW27TvMPj4/x3Kd7SIt2b0Vjxbi20IgcnWVkwMFPLbMYeNdkPTtTe0XSNUUVFYEycxeUtXNC0gyOg+/81wkF4NjeUercJIJTz6bC/O4ozet2qum3TFagf6d+MxXv9Hdqhz5GiawT3KKJQ8Rfuzj6dhJKXq46UJVHPUsjhbLkinG4y8Fxs/u7b+ZgfQOkAE8/P4T0lcMrhtIcEgtprr1yTJr8/Yga9beSlv1RVQfREiQzn7PT1Sexahya0D/xa2055o/0SwR5xI4XtLeqlqeu6mbdQtZunLpZhjvkpzt5Hj5aX+C+yuxqZuuUFp4jOGL3TmvC8bm2SFwvOf/RFc6SdSx2JXXAtVh2mI06tEhsWPoelK5ss8sNUYlzwq7pVio4T1k2VOJzaTOiDlMRSSSm4Ww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:34.7971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f051b80-9f20-467d-00af-08d7e709b391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Update firmware blobs

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8957429c6a24..17075f99bc54 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.83"
+#define DC_VER "3.2.83.1"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
