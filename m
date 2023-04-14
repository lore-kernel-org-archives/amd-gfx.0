Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4446C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EAA10EDEF;
	Fri, 14 Apr 2023 15:55:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B8F10EDE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce41weLpyI/dqR5c8YDpZirH/clmVldaVmZksyT9yaKV+tsR8AP6x6g9DJVPrVXoJ0pRMap5s246BHHaqzO/cCjZ4L8cUoTIJBSqT3gBX0GEO5krifPl2id8xMmYj3pGx6Ei/Oh5bp8mngr4rdOeiIHCFIpdL761LlNF4s1gWjDwWdZyl2jQWf6k1SGNkgo649XoNmkDT4bgdq2u6styyi8r7ZngZM/+CZ0fI5vO+VN02Pi/CDO3bgFyi7FiMADuMWNM+QrXtOw11eTLjN1a5K4iSdNXhkAnrNEQMWKHdqphl91sfNWHq/qjNOyOzyatS4ymFglICKhyfvKhudlTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrUrz5i1wUD2JINXIh2GQf8s+he1R1Ofdx1UzukawFM=;
 b=UD3FU603FlfFix7ArFGd6GXUnj/s81gjCrit9CkhDiz4hYDlJxvsyFp5JVEj2tAhGa5um+SGnIA7IoVNvEF/nTpBNtGmvJt7jjsg/IqzP/OEHwDsn1DifNBFLhOOpj/5dQQAU59yDN3fpw6jGwqzujkWDUG/J2sZ6lnITNLyAcOON+lqBEItjg3xaChRHkaI7jgt8QWHTNsYoy3BDiFh9uZrXhJrTnQqTLFZuHZ71jy3ymbWRo7JIgJT1shfq4e3KWARlY7y3nLPKTyzKwq2vkBwDnca9Z9H0OklgbY2eTOWf3eoaAB049rssHRD5/EJe5i3/Fi7TowjABL8FPErXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrUrz5i1wUD2JINXIh2GQf8s+he1R1Ofdx1UzukawFM=;
 b=3KUfM95G8aLVOjXqgwAPJ3cuTlWpZfYIIpAVeQxlCoyiFwriByij5oX5MLvHtsfH57YHl4KVdLs0XlciMqtbRxRZpGXTlYntHwJje+s76V70gcUOXDFVDLb6Vut5KMQv4O1gFWmlIi0KOAoqrqrb5gkwlwR4p0XEIz0v2aTVV7w=
Received: from BN8PR15CA0030.namprd15.prod.outlook.com (2603:10b6:408:c0::43)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:06 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::d6) by BN8PR15CA0030.outlook.office365.com
 (2603:10b6:408:c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:55:06 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:04 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 52/66] drm/amd/display: Remove DET check from DCN32
Date: Fri, 14 Apr 2023 11:53:16 -0400
Message-ID: <20230414155330.5215-53-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: e43cb0b4-f8fe-4eb3-09f3-08db3d009e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRXvgEIcQaeCQgsz3R8FaqqcQAIfSGusVOa6m2oPawT/KgVJMM8A6UP+A1SBjleiBnb8RRi0mbz65jgDRAGKNTzrasCUW/3Sasq24cPV9s6B5OArvXj/sUHLvxK1Sl5Ji0fvmv71TUmcjU1yMtatXfT/43TqwvkOoJtGWaH9Qsq+MSsoXuNHPzyULEHoCziBWWjMy3s8YFxJhI79J71I5hAeOgruCb3pqrOt3wj1AZ2btIfCxcQLePRoMY7Zw8SfT9MCfgBsgahS+FLS2w66ijORv/akfRwA+pdtef5bJ5GeD3Up8wW+4VgYzxaSxTo1vt+LS4vouyNcx2zy2aG8p075blNw/y08A3DDRQr5t/27P7QgpVHcMWNBqAluMsIflXUw3VPe8udT6GXW8FfTkim3VIlzaMcTLU0cNVGJnJiSuygBQR4p2wXPebRSc44wjT1bbHlq1S4nMRIPhpvIVfaiARkTstdzg1KTpVQXnWwirz4hQbtOX94prpkA+hRpYmcH/VN2Nmfaix6RJ/eLLp3nQtTSKSi4RAgZ72Yw8zOJDQJmqiFIlwvKPAMWsy3ba1EAWRf5xXnXjimPVc/83Vnly/4cA4iYnnBRAg6u5/SNUlRMDij9571QP05ipSex8w8MTHlAqXEM4w2etBoRHP424kS6JNXhAKcwCjncN59QfiY5XfNgtL2sli58EZfmVhms9WA8XLh3KlpVbOEHsegAA2yK8jV+FP1dMNtsoiA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(2616005)(47076005)(6916009)(2906002)(336012)(16526019)(4326008)(36860700001)(83380400001)(426003)(70586007)(70206006)(316002)(54906003)(478600001)(186003)(6666004)(8936002)(1076003)(26005)(8676002)(5660300002)(41300700001)(40480700001)(82740400003)(81166007)(82310400005)(356005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:06.3340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43cb0b4-f8fe-4eb3-09f3-08db3d009e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Drop duplicate check for DET Swath in DCN32.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index e90ddc33c27e..13c7e7394b1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1697,7 +1697,6 @@ static void mode_support_configuration(struct vba_vars_st *v,
 				&& mode_lib->vba.PTEBufferSizeNotExceeded[i][j] == true
 				&& mode_lib->vba.DCCMetaBufferSizeNotExceeded[i][j] == true
 				&& mode_lib->vba.NonsupportedDSCInputBPC == false
-				&& mode_lib->vba.NotEnoughDETSwathFillLatencyHidingPerState[i][j] == false
 				&& !mode_lib->vba.ExceededMALLSize
 				&& (mode_lib->vba.NotEnoughDETSwathFillLatencyHidingPerState[i][j] == false
 				|| i == v->soc.num_states - 1)
-- 
2.34.1

