Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4552C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953B660F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 953B660F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F166EE79;
	Fri, 17 Sep 2021 19:25:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6690B6EE78
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYRrRawJG6uHnWLITsMdXfhQCncYkHlFAUXsj6xCcQpD5NMdTgJccX/VhMROrfWQhjnHU7txx5K31rez5h0ytKViMwXiMRqeSvUe4BMdXu4dzJR7VHDJzc/A0wg3BdutfPXVagwAxP2EogC6E3lrPePzHcByIMrKf9+Lh5E6HGzJYe35oji0wYny/BXkvoAr4Fa1qDwohfo/vVyV9L/NoOdG6ImW4QZzuxfduP7bwpUrkaWZaXjQ1d9LFu/CHfUjQ+wPM2NdevecTnazkL5m8BvTjcf0pvdImpHwD4JxqEy5eGKuyjAIwY5ZDuLNNdS+AYqZQD/BDf9wMDr22AbisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aYx92ySdoE3TsPxwCAdDCLEyvbCNxv6sxD3pwrzd9F4=;
 b=SJPR8d4VevXQD0+Oj5wYudKNiNJ43nRSjHWT4rhDHbUR6tTiT00blTYD4TbD7NRxECtmTGvgjhfb93REYwyvQ3/AoH4nSV6yqmGg9jVPDjzqhCLY8qWRJD5kuvTpDcwPqKsZVH7iEyppguSCUk+9vb520/LxF3NtpscuBs+xlQkEgzMPCWbVn0A67vLJQ8vPkd9EYxRsb0SdXsbijQoR++PyEtXXX2k/6bH2uz7Nv3MQYENP2UtaPqZEWd03gPmVFtu0J3cofnaCfzlA1K+/1q3emwdunCdKQyS5HX7KMrU7BmfYetlZiFAiz+UNGUAF5Bh/2xdLrmo+c7EHds10+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYx92ySdoE3TsPxwCAdDCLEyvbCNxv6sxD3pwrzd9F4=;
 b=HTx44ew8wtmjtSaAHV0OSf3bOX1BJon20RnRD21dC0hYryj+Rm7+lJocFP1A7KQ5T9KiaeuhdaSzgiLzXaxFeA+80Dpkw+j/Ck7S7riDTnVQAs2yOyDKX0XaleGGTUnhlkqigHd4slF8L5y+w9GDtoEn8sYnJ2yKm8igqOIUQxI=
Received: from BN6PR2001CA0023.namprd20.prod.outlook.com
 (2603:10b6:404:b4::33) by DM5PR12MB1467.namprd12.prod.outlook.com
 (2603:10b6:4:c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Fri, 17 Sep
 2021 19:25:49 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::8b) by BN6PR2001CA0023.outlook.office365.com
 (2603:10b6:404:b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:48 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:47 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 03/18] drm/amd/display: 3.2.153
Date: Fri, 17 Sep 2021 15:25:09 -0400
Message-ID: <20210917192524.3020276-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 237a1b33-f6a4-4d15-9120-08d97a10f481
X-MS-TrafficTypeDiagnostic: DM5PR12MB1467:
X-Microsoft-Antispam-PRVS: <DM5PR12MB146745DBB9C3525879C76A1398DD9@DM5PR12MB1467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEXpdVYNzl9nbDK5x63KQDVwRUadJ0JOPeKvftwDS+Fh5nS31FbW2L77J7xqbesvhZHukV1RRgslgwiNDXwXvnUzWdttTojHaehO4Ckyb0hsyUqdLVOdmXqj4UbGhs7lbpDuUQSi+9ByKvnfq+0iR9xhx4ObGWSLSADMyFzu35x0FkW+Z5Sb93stlXTitEHO+lO4TU09rd0rxttmWnD08lJv1EhBvG+BdFPY2Eom66mSBIKmV30iloh2WSOON2WsH80MRtST22ktboNFB8YCN4XZoWyG/Anw79YPsREvh5Z1d665eXzkkWGAjaIIC4raBuozJruZg2b4Uif+Cg/cunmpg0V0shbDO5BMUQofveQwAlJ+wwbwBCfCSU7G/E4HjBHs8AaoztVvTT+SRbNAkH5T+5wZElbxgA5FFgEY4+8niUUpjsGLQW4NLcJ53SCExIO7bVwJDozlcWkW9xMRee3Yoq/KPpLhtuLDOMBG+OeZHj1xsl5plzgE2O+VvVg8LVIC42bHm1NV0H8Xg5Oj0RyyCHLp1Ij5rYXBTxEh2Gpn2qCM+6i2BGrOHBEv7GxA5g/VsKEdw2p5oNVuKP6peZnaHJ206iNU8NQo2Y8UYq4xuBxLjBDU2QetXdK+lAPvgS7MwOloHKAMnCpAwYbFSvG+N26bJOHfudhgo/n8rWOs6hdmGKPxUN5jgjlGedcc6JfknTwyH+A4BlgLMwfrjnMbmuYvHxad4UaCuzuIQRU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(46966006)(81166007)(4744005)(36756003)(82740400003)(6916009)(47076005)(5660300002)(356005)(4326008)(54906003)(2906002)(6666004)(316002)(8676002)(336012)(478600001)(70206006)(70586007)(36860700001)(8936002)(83380400001)(1076003)(2616005)(186003)(16526019)(26005)(82310400003)(426003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:48.9383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 237a1b33-f6a4-4d15-9120-08d97a10f481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1467
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

