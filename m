Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDB2C636CB
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529F360C40
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529F360C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A21F89E15;
	Sun, 18 Jul 2021 14:06:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8C789E0D
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwuszU0pVhNm5wdwsjCuEieV7mpZJlwMCgq1wh2siNAIcbWxxU54DQ8L51K3pW0c6vkCUt0H8U3QnHVide9ZYtDaNRp1Nlt31eS7YOyHZ4njWe5uW6OU0Loxmrga/VlMJNstJFYFmMntCDwRBqi2NOjzztsJNYoQq5pmeCFxIrt61enQiIgbv1Eu7+c2PNGJtTHlcrOqHk8W0I7iuoXU2H9bd8veCEqEDXImoJB/EEoQ9a1xzjuIBFSB4ysrmWq43CrvOMpOVwzjimF6nnJNRD4H5Wj+IfqcIhruxmwFYxBQIN6qUxUaXLr8QOfIgWl4IkD6SCDCelhv6j52/EIe/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tda+68Ytb5kE0nfBJm/CwXELo1S0cRnyMFSW+ppvT+I=;
 b=ac3oqLeSHo6qM/0x7i427xVVfc8Yg78n8uFKTyhpCBaB2BdzoFpLGVBvNV8tKZ8eoD7z9n4pXoIyTvY+9FRoFjjAv09oK1MvVuVAFO5ZkSQObEH58KkRd+OtgudFQCxpWaLbJQw58BrcSkPVLhcOka3J9Vhl/UWbarkIdCuXomAdQ5SmacCIN2kA7/aoIVg6Absi6ro5MdYHnzP83o02Hro2+Obqyp9LLg7SW/XBeD5chEz6WNOGi7OD5lCxy8BWu1eOqF28K2W3sRwuAVeCEAtcZR691tFbvZZNS5RWC8rAQTxz7oXK7uQ/LYyK9dkERq3NVl6tSJlLb5dACiIi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tda+68Ytb5kE0nfBJm/CwXELo1S0cRnyMFSW+ppvT+I=;
 b=t1lpLAi/y3kFY1sOlRc0ZwZ5FaQUlxzrPf3TPoIUHTtFbMhyj/9xSdoGNtofyLuc80ku9ySFhcNVEs/Xr6ag1DOf+jyRy1huZQjx4uIGWAAoNSAnIZSNVFOog5+xk37SN2v0Tu6iZHQdYvKTBtFffTg6AhaPGxnIbUWC1mWq3Ls=
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by CH0PR12MB5090.namprd12.prod.outlook.com (2603:10b6:610:bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Sun, 18 Jul
 2021 14:06:30 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::c2) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:29 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:27 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/32] drm/amd/display: remove compbuf size wait
Date: Sun, 18 Jul 2021 10:05:46 -0400
Message-ID: <20210718140610.1584616-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1405a3a9-aab9-4e3a-bf86-08d949f53db7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5090:
X-Microsoft-Antispam-PRVS: <CH0PR12MB509020FD4EAC4364EBC35D7A98E09@CH0PR12MB5090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wE/syFnwgRHoyhAELyB/fSKaOsgP5BD8LtkZOTUd6L4fptBBfnMSgJFwFxleSwBWGwAXsBSxVFKA0/Lv0qLF79Gf3o8pszopX8iAWPhLT+6y8NApHqSXFACHCKMY9KPKbDX2epkcukchRg1lklCu5d21qoy4Zf1xLqeC/ibMgvP+9ZQnIQUV2wvmVMtOLvueKh9y123S8xy9oNF6B9sz21LxRPnDs0vI5VONad38MMbplDaXJPutP5XYsXGP1Ukgb/Y4ZOvJ7PvZEm18tk55frdwa6DoM3Ap7DB/oEne2O8cvdSDmXYB0CYOFvaIVMWkkDVTnzNU2bCXXKGFpd+giE8Xb8SBTg5n7zFgJbEZYsAEaYYXPP4TVYeFu1V9aOdy2onYJIE73y2EnWeIa8YPo2QcDYM/ZETd75+ECBoneZPZeENA76p8KNI2KrnV3k8AiHgYsx6V+/DNLg4219x1J5dMMXCgcf1vqxX7xMIltn+hoHLZZFUMO6+3yhh78v60k924EUhJHnvm8qN9BQrYP7moIuL2vMEcVXQZSQ5cx7BGizH4XRTECh0ZzIRDE+OJ2B3tn3clIUZHFVMXsIaFifan0PHRfMBR3tuMSYswTljGewHSCjqhIOlEx1u/sN3nrzTNJhtxBPQfcVM3yLg/ZnBp+JIMSzGw2zUMyakyLK9pRIFvUv9ggu+ugQgwABX7EQYjANS//R11iE+BiUmYlj05xH51+JvBMmkNEw4VRtA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(356005)(5660300002)(70206006)(47076005)(82310400003)(336012)(70586007)(426003)(86362001)(2616005)(6666004)(36860700001)(82740400003)(4326008)(1076003)(36756003)(81166007)(54906003)(8936002)(2906002)(83380400001)(186003)(478600001)(16526019)(6916009)(8676002)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:29.9184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1405a3a9-aab9-4e3a-bf86-08d949f53db7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5090
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

This tends to take miliseconds in certain scenarios and we'd rather not
wait that long. Due to how this interacts with det size update and
locking waiting should not be necessary as compbuf updates before
unlock.

Add a watch for config error instead as that is something we actually do
care about.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
index 32fb22daf4a2..39485bdeb90e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
@@ -319,6 +319,7 @@ struct dcn_hubbub_registers {
 		type DET3_SIZE_CURRENT;\
 		type COMPBUF_SIZE;\
 		type COMPBUF_SIZE_CURRENT;\
+		type CONFIG_ERROR;\
 		type COMPBUF_RESERVED_SPACE_64B;\
 		type COMPBUF_RESERVED_SPACE_ZS;\
 		type DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index b5a7fa67958b..2043528d3490 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -124,8 +124,8 @@ static void dcn31_program_compbuf_size(struct hubbub *hubbub, unsigned int compb
 		ASSERT(hubbub2->det0_size + hubbub2->det1_size + hubbub2->det2_size
 				+ hubbub2->det3_size + compbuf_size_segments <= hubbub2->crb_size_segs);
 		REG_UPDATE(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE, compbuf_size_segments);
-		REG_WAIT(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE_CURRENT, compbuf_size_segments, 1, 100);
 		hubbub2->compbuf_size_segments = compbuf_size_segments;
+		ASSERT(REG_GET(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR, &compbuf_size_segments) && !compbuf_size_segments);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
index 298858d8259b..e3a654bf04e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
@@ -98,6 +98,7 @@
 	HUBBUB_SF(DCHUBBUB_DET3_CTRL, DET3_SIZE_CURRENT, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE_CURRENT, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR, mask_sh),\
 	HUBBUB_SF(COMPBUF_RESERVED_SPACE, COMPBUF_RESERVED_SPACE_64B, mask_sh),\
 	HUBBUB_SF(COMPBUF_RESERVED_SPACE, COMPBUF_RESERVED_SPACE_ZS, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_Z8_A, mask_sh), \
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
