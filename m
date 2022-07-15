Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8750C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E5B910E91B;
	Sat, 16 Jul 2022 14:36:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5059310E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:18:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/0KKlQYZZtnhmz1fFQcjp1E0aSDWbFddD+qjzIMon8lfF+e21bJ5wiorfgibMGa1wKsxj99FcpoE4IixCxpjcWttnHuIJVqglaDyAKVjvbikBO++EdvmvgzU8w2SX70wFdp6JN66Ps+yQLpmAk9UJEMqb4NGusBXF9R9/yd/y8Wapbs4Eq7S53uD1frVGYvZzE0JbBVoBj5/1KjjcGqDwdtv8F/0cPsZxknG73Qu+cwn0q/Kgjl/OknTScrb7dXm/BFaXdkaPi08gCSPsWihINRGfaB5EZVSYJnPQ034JtN7ghVrpi/5lssW4wjSoTFkm2KFfL1SjW0n289SBC0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mv3gVt0GwfzTHqvExXxwiV66JFp9nbfbK1H3TbMDa4g=;
 b=QNpYj/xGSnroSvrOkWomge16OhwTyXZ6TF45r/VJx3DXmFfcm9woxVgqRmMdQb7OOaF9s/y2FPPqhyUHFJPKvB1pclptsxlYcYBaxVVLCLfXl9otvCUxS9rX4M0OFmg74PiY1V6kStjsMcXStIoqucBV68m35Hx2SU1swTCUfId11ZBToLwX3Q5Fez1qBG8StSQsuTk5BsyyMoCsryp51RzT0rFCCwtGIqaSx6mWLxkel1vKBktnMdy3BWkJpLf80epGdYbZ2CqjUWNpBBE4duCRdRfpeeKexH/DvRdmhAKNO8Z/DqQ1KRULrHErihaQmMKGQsDCLSsNra6oC6QcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv3gVt0GwfzTHqvExXxwiV66JFp9nbfbK1H3TbMDa4g=;
 b=K1fzN6IfffX0OBlRBio6kNTpupgsg0/+eHOCPdvhCvlBkyBWGgIIzL9WEovYFjrCFwh3W1FoxTcKoHbVxyv3C9DwG9mgH9ySB6cwG8gM+TAJ8iQgv3f148gHCBwG+bQyQzKbtbjd3ftYVrklKFYozP7B6z6QGaSz9XN0bvY108U=
Received: from MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::31)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 18:18:02 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::d6) by MW4P222CA0026.outlook.office365.com
 (2603:10b6:303:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 15 Jul 2022 18:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:18:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:18:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:59 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:58 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/31] drm/amd/display: 3.2.195
Date: Fri, 15 Jul 2022 14:17:05 -0400
Message-ID: <20220715181705.1030401-32-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea99fb4-63e9-4127-4600-08da668e5ab5
X-MS-TrafficTypeDiagnostic: PH0PR12MB5417:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gf53eQVVhLJK0ScSRONpiM8bSgDD5b/Y+HTcZovhcr2M83QbT1mB0WS4nLPzlwSPMYuh5USliqZcyrOWUFa2mvqOwAMJ3R7Fwp6deFfE8cvZrBgVbs2ygMxIlL7NI8JAdiskFRsGDboH8s2A4zPqKLkCArgkhPDaorOg6rixvUZM2DL9ZYvvZAU6k6wRexZ9T4Pc9usruDbJz/q2F3Aut/KYGRALze/nwSEPDFL+fB4af2WIp5Y8LYI7dbXwajKxGbDKrKKYUdZIrNidubYa1fOEXSeGgIkWvSLiFmz94cqoUTiexMmNaEqJDu879pMGNnjzCjjMDRiCHeDT0YxDIFamQHYfOTDdl/gAJbeNrHVEoFt2am4m/hymGcIIz157conq29i9O2Hx1dZDXpON6hCm/sB1sYNpxhrjeQiJ5irkvHS/ntlXDBZd2Nn3d+b1lc7JldEoQrajsGkGuS07rRhrKOIXDRDEEVz9jr97MrVyIES2NEexXL0Za+IMTJBxbKX3GjYsIW1LL9UwAecUld+DyuhkhXWChW+v5qWhYV2q5s+/fCmjt5XzX+G5tQOS4lptIQjaSUTayB0hxbhXxhFUKK8SeY744U8jaz9jCx+Pi9GrVtZ6IqQvmGdfUGVKX5qzj9FkLAR2xSTfjLQ4RQ/KOdCsOTPQKveTOxCTeB8jMea8Yuf2bDEL5qrrRWuSEGj4VXgiDvlU1OrIH9NSG9MfKJgqVXylzM5im1+1JX+JGl7h/46C0pNuuBCQ3sTq4kB5/ap94zr3xVZ6M4dwKx0hUdkm0h8Nw0PVtGNHGvGyb2B3hEvAiId1iBi6RRjgyXFteY3yVm22/I8Ldan7WH8n6ErqI7MxInLsnX2qsto=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(40470700004)(36840700001)(46966006)(2906002)(5660300002)(8936002)(6916009)(4326008)(4744005)(40460700003)(8676002)(82310400005)(86362001)(70206006)(40480700001)(36860700001)(83380400001)(82740400003)(36756003)(356005)(81166007)(478600001)(316002)(54906003)(70586007)(186003)(1076003)(6666004)(47076005)(2616005)(41300700001)(336012)(426003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:18:01.7690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea99fb4-63e9-4127-4600-08da668e5ab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

- Isolate FPU operation for DCN32/321 under the DML folder
- Create a specific file for CRTC and plane based on amdgpu_dm
- Fix DSC issues
- Update DML logic

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index be41f9fcf1dd..d05bbe193bfa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.194"
+#define DC_VER "3.2.195"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.37.0

