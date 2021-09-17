Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DC3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 17:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503BE61212
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 17:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 503BE61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D19C46E03E;
	Fri, 17 Sep 2021 17:47:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B7C6E03E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 17:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd5o/RmK0cDThiHP3Us1t801MWw3hxIsZkTFv5mANmR1ywH/SotXy5OJViXotcFolUutqWNz3D58Z2fgNDhmkxBDAx8H7ib+oxE1VTSDadmAVtmPl1E0n8ztPo2VGxJybqFfS2qCwIzX/c6IwAjo9hPgRcAn4wv5KIikPS9XBhPbfSZv7VY1S9dbzIpy8cV9bmkBdIfUkWS2A3mHs71JE7tdj6g34vCXgaCp1uU03XESKPm6lB9++dALzEx8+M6Hm0XvI7etM4SQaNmZj4stQmjMlkB9kkDlk6rnFyz634V/wVCNo3l+Wum756cU6PherLDGnSgxtkB1zyHf87LVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aYx92ySdoE3TsPxwCAdDCLEyvbCNxv6sxD3pwrzd9F4=;
 b=iD3bs6Peb0+3U+5SFUKBboQc9tQLNZ8oBaekQcLW8HVwZon7PveLQCdHLgOUd0n5YQqu5h3+9S2CnfCl/t0/7BOq8qECclzrxaGC0JTEfmXtPNP7WUBajYsTMK8L1XUa6DhDFpfKqLpAvc0mrDfl7xtRKi9fWurelHxifJ2PCDnrLuZpbVqq1/PnsEXdZ5u7irPiCGAUJUWTg+BF8XiGiGcOHxDLHBqUeawJekSjw/BhT5WpwjdL0IPSqV0pF01+5fPWLIImjZ72qizK8urHua2TcXcDMTTycpfiUNW8kZ31QX0NTnzsBON+cmdFIF33i2FOfDU5br6ICxqeon4KSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYx92ySdoE3TsPxwCAdDCLEyvbCNxv6sxD3pwrzd9F4=;
 b=I1v1PlqSO7p5eCo6NvOQ3zR2tE2Y5hwJyvqNQft06QosjvyN1V++Dk3gQZuwWvavZryw3etPr+0sECmYpfnYArAlbiuwvlGX89BFEmDWLuPBevf1B1tytzNlSRZY0lc0M/XtOsDaCh4Lb6Qfr2rkjoNGp2NFR/33/TNkwv9bIxo=
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by MWHPR1201MB2558.namprd12.prod.outlook.com (2603:10b6:300:e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 17:47:41 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::14) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 17:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 17:47:41 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 12:47:39 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 03/18] drm/amd/display: 3.2.153
Date: Fri, 17 Sep 2021 13:47:01 -0400
Message-ID: <20210917174716.3011466-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917174716.3011466-1-Rodrigo.Siqueira@amd.com>
References: <20210917174716.3011466-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b98ade32-8958-48b5-671b-08d97a033f10
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2558:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2558E7F646740CED447B8DDE98DD9@MWHPR1201MB2558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfqgQ6WvcOjKFx7gqAaHafG6zEw0KAsO0Vn8qmOnQMaw1Woq6HFMKsdtfZtqvNF714mVNZq+gFtiqREsdg4VgbVA0L59vlplRSmrQMotxKF4bfdsIQA+lnd417Xt7Tu3IPn+hgeXZZjQeJo6gvm+HUJWWK40s7ngenweoOCmmCKBq8btyFaWhAOnmBxak9V/d87K7T9UixUN9qovAiwM4Mii+LmxNNAlK37XJAsIs16WwyCkiM+mZRnrIH/rogqL8BIfE7A0vQVhBmYCKLWcrMJMW0nmCdMsTKX8KdNowIO2ztGgG+94DWWDSLwV2VasSrVVUaNJ7n5XPBolMWT9KJ0/OzO8Ncd4OWTQbU80tP2VBicER0G19Sv95SiHdOe/FfX3pXt5R4U6AMCmXyuRX60wpBhh5K/NzYSIr3XyvHxNGRvvnoxy1APTMIbN1I5jZjx7yplh3RRj1V6R8ujJg4PP2roEy1hw6458Edumrbbnu5mgvpSBMF8dkJaiLYw4EuwBR5dIGoLLDP9zNQdQ6DrR803sh0JsSdCaW6n7NEbTHX27DreSyqUrCycKLaRQuEtm/lbI2YUxJZsRJtOl/ar46NDRv+MFtvUpAYmYoVFQblO0hv/qb07gQv58ps+uZM33I6G6yNkv34iREfCwzJ9XdHY/u+g0toO6EsfcID/XRiWT4TJ+0GSRUZ+WhhnVeKFY8wWNYppiEWgVRYTP7jrlDcoiCsxB/QVrMqyGIBg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(86362001)(82310400003)(2616005)(1076003)(6916009)(36756003)(26005)(356005)(16526019)(6666004)(70206006)(81166007)(186003)(54906003)(8936002)(2906002)(316002)(4326008)(336012)(426003)(5660300002)(36860700001)(4744005)(82740400003)(47076005)(8676002)(83380400001)(478600001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 17:47:41.0741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98ade32-8958-48b5-671b-08d97a033f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2558
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 8897750bdaea..1306dedc1a98 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.152"
+#define DC_VER "3.2.153"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

