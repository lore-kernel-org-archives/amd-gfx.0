Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B6C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8F3310E9F8;
	Thu, 22 Sep 2022 00:19:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B0F10E9EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca+OMhhCCS7wmHbWq/UAAh0meg68BZJEjmNfT4fGQmAeMU0fvX4yHymZIxS3hgcGIwzgmu5Xpn1KJiO5pAp/cT7pvDdwi7RQ3Tr1A6pATunPmQA9PuamxROHMHrAmvefB9gQSn42lslENXz826hCWu/hcrWgV2gMfiihhkb1j3cXyG17jFAFOodCO+E3Nxu02/iAn3OOpznt+igoG13SuKQ3lganGsWU8oMTs4Z2Yzlp20nXh8EtfThHNCP0/DVe0PTP2fusx1Kg+c9I00qRKFzmSxQSEQrnixOjoSt4xAw1kgQ1ydichBtlssPbPTVsySPNGlWE512TVg5eOq0Q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S4pK7saS1hGfcGInCTdzYPquTtR9cSHmAZj/3jGllI=;
 b=m7VTGtisIMdwe3I6kvLvnd7GhXP56tq/bc4dIEhfiUrmat/p0BtTmlLzlxklrL8XUTRtVFjM3bL2HgKEbQacvs6Z4iLkfVy0sYAJe6JIXytgLfnnyVG+WfnOPXYC+yEuResg4JKqgyA7S6JuPFuiIMHEpdZhuqdRt4pMf1JJfrifzfXY8UkduEbiwzDwm1jjojvsWQmByXOsK6jEZIRCdvBtBEbksap+hMiLX/8PJvE48mi1lN86vnydq7kSlbt6ZTRuEN2kRUrQeG7esgv89WE7EUTYpdI/K4riKFSmiTbTOVjPF7902yzLhyOCGayoTZ3azQoYUGpgUBaXws1tWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S4pK7saS1hGfcGInCTdzYPquTtR9cSHmAZj/3jGllI=;
 b=oihpDzKffGoatMdHLPXCFiSVvUWrUNFj1UmBst07moDbsxTmN9MleCIHimkeVfcLKHyUqClweBJEojEKRilDBX5kVRkGkC+xM9ALXGyKtwtDY7l2M/52aZ2E3zn7X1LqQMvA4RtKJy21B/qlNjcozQ2/ZYWIRWqKMjgxlwFqbnQ=
Received: from BN8PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:94::44)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Thu, 22 Sep
 2022 00:18:57 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::aa) by BN8PR03CA0031.outlook.office365.com
 (2603:10b6:408:94::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.23 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:56 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:52 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/31] drm/amd/display: Change EDID fallback condition
Date: Wed, 21 Sep 2022 20:17:59 -0400
Message-ID: <20220922001821.320255-10-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb6afbf-d53f-4d84-5fe4-08da9c300a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVd2kT8QMxhcUtoO+7TaJPiGk9fX90y7xjg+dqpk8iZZWxEnuDKPyKKk0MCq/SN66d8bSTq17BpZYO61HAemHQF3uAI7KeNc3K8rLCj9TMdtoYfyaemnr2tXIh8Ky684JTTtRPFV4TxmwYLRR8k76B6c6op7BVyL3Q74P1VUFrl3ItJpsamRRqm3kEko//IGwtu9sxxgF+jgkoQAgwephdmQt2//TpKlTpor3e3nP7bGZoofuXvKVFoe0lsYCVRFKmxcDNi20chnkTZNKaxtKfBfg8OZKV5cCCIPinB9lRS2D6D0iKCjHG/4zt1p5+tutwgRSFcwF4OhJ1ZPs5spTIhLo+WAOMyN1IX1aTzgxToYX23pw4JDhvNapYcK16RWjK911HNm4p8ybfvRUOU5PqfxROOZnAvuceHDpyn3uwk/4GPPqRRMrmbuDYWwLOj5cxGaExU68EAw/HTFSX7pdKiXlSvPITwhDgjJ0vsXeIPjEm4WpHa6+GHmYgNUloWcKYD5CwclePyk4n/boHuxJiMbCHdreo53y6xJpjUYIkPXRioxf92N57bq5sT75P/C8GsYgJTkTHRN0KAbgDooh8ZXlWUdgwNUHjS99q6AoGlTLNLfRISwfx8jroTiWEF3caPd1SbdpMDdroxaAxoTACFlFI3Htq0omMeqb8k+IoBfGZc6aFrGcru6uPD23gxnaYdBaeoEahgqmiXu6Cmstpsls76MNXIvIK0BD7JZ5faSKVsIDbpAqkOF1kBj4FN6Lp8cFKb83UREAj7BUwq/uIPQ/aPlqblOgMcS4ZA1l1EPYeWFh+DwNLAq3cYutAlP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(47076005)(83380400001)(426003)(186003)(336012)(16526019)(82740400003)(36860700001)(2616005)(1076003)(26005)(41300700001)(5660300002)(40480700001)(478600001)(40460700003)(8936002)(82310400005)(8676002)(4326008)(356005)(70586007)(70206006)(81166007)(316002)(6916009)(54906003)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:56.8805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb6afbf-d53f-4d84-5fe4-08da9c300a2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Partially valid EDIDs on MST sinks are treated the same way as broken
EDIDs or read failures and result in a fallback EDID being used instead.

[How]
If edid_status is EDID_PARTIAL_VALID, prefer to use the valid EDID
blocks instead of using a fallback EDID.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index d93393cc66c0..351888fe9b72 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4061,7 +4061,7 @@ struct dc_sink *dc_link_add_remote_sink(
 	 * Treat device as no EDID device if EDID
 	 * parsing fails
 	 */
-	if (edid_status != EDID_OK) {
+	if (edid_status != EDID_OK && edid_status != EDID_PARTIAL_VALID) {
 		dc_sink->dc_edid.length = 0;
 		dm_error("Bad EDID, status%d!\n", edid_status);
 	}
-- 
2.25.1

