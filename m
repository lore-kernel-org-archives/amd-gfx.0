Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77BAC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2556010E9DD;
	Wed, 28 Sep 2022 19:42:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E842910E9AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXOudO+L1wWzao99e/rr5yZNu9+vhf9l//sBh3RMjZCs22m4bbGfhoxhUI4G9nijrrm0pX/3YcjyVfdDYXSde8awrPOwUo7a6k/ULGWaz7GEo0lHblYZcj9XfTCSSsbv6ET7mELFEWLEc5Q5kRFLKVFkhQEopAD1hyMCPX3tpeJhsTzYRWxv6VUlcUO3EWyAZNfaC96Fgt4T3P+DzoByf+msXmvBqEw5ZbqqLE23ibI9kCt3gavDLHWjC7+7B5Hxl5Xus6bdMCTED4unRLvlJ9pSxpCOoWB+8e4AlGexlNwcGukJpjpJ1fkcVru9YapHZmWTm0d+pGC5CxfXn3Ofqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGu667617perv0EvLDhD/sThucZjBxmt7Q048wb/W1c=;
 b=lMwNakvg7czIwVTum4W2U7i4B6nBRznuSJPGbSaaaBs0QnrfnsQr+ZZGcsHKO0Xr6Otg1TFw1exY7YP6hZOiOqojLzlIz6lApckuvrCC2jR10QQofqiXOPYDPt76eQneAk/8r4kkcbEHRjMbimnqgDTg/B2N0v/ilYPUwco/eeCuxfeZzSq6HuRjANk7jBRwRS/08qlKyy6Rz0ddXGp/rG8rZ9Nr5LfXoQkcW9fH72QNwpV2J8rtL9+7QKF2CV+JJ+unkl2BnARTiji9iuWEpaLJBQLvQt5N6CgaDNhCmT8R3i334b48OGlsZlJ2DRb6bgnNe/o08D/WJEfTl9/oYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGu667617perv0EvLDhD/sThucZjBxmt7Q048wb/W1c=;
 b=2h7/REKs5x/9moeXOh4Qzx9zbp1psjsTlYR3Sz+4rK1JkJp4j1Zz+0K658XmMVH+nYOfEZVedAWloMpzvJuS1EHSg5Q5fAdRIwXyWz+z0mN4gv7kGkV9lmuhN9PJYRYxo45haNeg2CTufJN3K/6H/AAcN+C+7EL91hir7Tz3mms=
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 19:40:58 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::28) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:40:58 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:56 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/36] Revert "drm/amd/display: correct hostvm flag"
Date: Wed, 28 Sep 2022 15:40:00 -0400
Message-ID: <20220928194028.144879-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d1c1ac-374f-45fe-5f68-08daa1895dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2N4bRS/8WLVf4OZlIj/PFXRuwLSIJ84YXmb+/Owpcb8NceD5uTI2a0OatB/mTOhSzuYULVM/cpoe/g3PImL8EV070Go9mUVaHOHmmnp8XsyhGKf+Un3IfYhM7bQrCXf/j0tI1tK494va4jCAx/pm0MfCixZRn7GorvLw/uclZZ1hDYP+NaW0F+FJBqFvHphqcjKtoYCfW2T1wgHWB6mtjsf1QY83//sswgljmtd+oh0RizGSKXpoMrqyUHNw2S9xIOQ/rY+j6f3FUe/h6qW97TrZ9jL2jrFI0WktxLwMz0+A9KfKksgIN+h5T5XN0obvFevDG8/HnyvzUpm3VyDXxrELoNcgQGzahGBn/TJ4Gt2+vnegs9yl4g0tw7xyAh9mCcJN3GqQw79jFuXXgWZfnF22RbzbUnYe7EhldMQX4QKVq/Ds/OUnL8wTcneEzfBKqPjuqGWZxsLfgX8+81KxhCrhB/HOXBgdoiSyE7jqIgTxFeXhT6+msvBmqrHdxM4ct7nBmFvlsJ6FVLwNJ2B3aLekq6Ju5hFQyG4SAmjUy7A7tVuWR7E0QKnO/CbQehd9ZCpsJzcFd+Uvk44F1G4sPmcPVu/9sgUlMkHrm4pdk6WcJV6vMmo47MHsZPGFnF5MeBkdbSpwMdriZu6BkmBzyWeqBGeFcwm0pWv2355G+8Q11Ytqe5K3FzQG1vVLUwgk929YxKmV8BbURFBewQ/uZnT4uHHyo2XDO53KfnjZVUA8HDKRJZYyIEfvM+Y8pqV6yiHwgDYfnZ7kngAE2wpt1JY2/mzgeKLOQvacGh9SXvRgGUstqEBhPh9G9LSNsMR4wOUo+2EP5D6g4S/l/rOYgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(2906002)(426003)(26005)(336012)(8936002)(2616005)(7696005)(1076003)(41300700001)(6666004)(44832011)(356005)(40460700003)(82740400003)(81166007)(40480700001)(86362001)(82310400005)(47076005)(186003)(36860700001)(83380400001)(5660300002)(8676002)(478600001)(54906003)(16526019)(316002)(6916009)(4326008)(70206006)(70586007)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:40:58.2905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d1c1ac-374f-45fe-5f68-08daa1895dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Sherry Wang <Yao.Wang1@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This reverts commit bbd46fc8daae7c2a1c79b63854621d8446e9794a.

4K144 resolution isn't available on DCN31.

Reviewed-by: Sherry Wang <Yao.Wang1@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index ce993e8bdd24..fddc21a5a04c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -889,7 +889,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.disable_z10 = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.dml_hostvm_override = DML_HOSTVM_NO_OVERRIDE,
+	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.37.2

