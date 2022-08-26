Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3E6ECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068F010EB90;
	Sat, 27 Aug 2022 02:52:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240F510EB8D
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apyP/2Be3uG3Wi0IeFKZWR9XAe10lGo7QTaXSOrJxOD60cXOkdKJ3x3qr1vrQGYWXqHSrCt0IKmsxwQd+QWA+0qLk461XxgYZvSe6g88COi3xzOTe+np58VA84Pt84/urT9z6o9sI8ov3hyXSne07mOiR0+I1x1AoG/H6gdoNJnf2o1BRGD4dMwMIP9WzQ8/oLmhriLqpKEEaSe0g7Y7Imx6Pe7XreMamxH4AQ/Dnr7XUSNOuzcSl5OX1etwleguHini1ATGe+Vz2By3B6zc3ybjG1D1hqvJZjSfmUkAaWpalJZquVMbBauSIJDQlmYPxXGAEYAAvX0jRDV8aMMC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6I2cLLue7fzGqxwCaXqp4hKqgnF3nKm3pHztqYxvGk=;
 b=edAJilHudypVBQZyrAkO96tO8EaxsgmAFtxvZZPYYh44cclTTm0yryD9ikhhCYaIa3OBlbYfKNYhO5ammsx12xh+8xp6veq6kpK7eqSrToDYqO40DD+W5/tvbTQdGgtGOVsXKm8k7zxucZ38TEJ+dneHduaaZBNH3+L3+Yct0ygyyhWMNxrLIbu1DNqIB//+PFaBn435IpnO3rYQ8K+oDHaakWdRv9fuRtYubgUoO1nemNwQ4ohFcDxyIAL38eZSne3gEGoF2qZs6F42tbpzLX/wLzi9TBAVKMZRtoIwx6acy1f96lJwliqYBIEshLYBxfcvRsvVvJRyvGgWbo7xZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6I2cLLue7fzGqxwCaXqp4hKqgnF3nKm3pHztqYxvGk=;
 b=sPJJhwfMVGP92R+fe6uaxmr1rR75ra5yT/n8VwVgeVivstBXt1ORfE3mIOHlcsZzFhrkDKWbJ0KKxwWU+Geh26BNYjSyWBEWJBggusRIPyC/vGkvzpca9G5mjjY/9beF52qxRmK0NVbTIZtWlwFQnQ37ntT79sCJKJYYDKUhIEs=
Received: from DM6PR13CA0011.namprd13.prod.outlook.com (2603:10b6:5:bc::24) by
 DM6PR12MB4532.namprd12.prod.outlook.com (2603:10b6:5:2af::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Sat, 27 Aug 2022 02:52:38 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::fc) by DM6PR13CA0011.outlook.office365.com
 (2603:10b6:5:bc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.5 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:37 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:33
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/33] drm/amd/display: [FW Promotion] Release 0.0.132.0
Date: Sat, 27 Aug 2022 06:50:47 +0800
Message-ID: <20220826225053.1435588-28-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77a2e2b-0e74-48ce-d2f2-08da87d733a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4532:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qja6aJVKh+N6qfc84SvkmJh6huF24+QJ8WCw0gdcrbrxoIxcmB4rXJX9C9SuvYY4V3pX4vSESiKzAdUskWeqXmJPQtiAKXcd8+J2KpxrpUP2Cxo2w712IOfjpkOMWEyE87crJe6H2G0y0mLMbWf34ayVIHJMcK7+HqouFmuE/ndP40FBsT+MoAVxcPnmjkr+r3rpRHuJKMgZx1YAiNflVZbpR47f2BmJzuunr4+1leDI8Nv2S2EokBBSIu30Q9mfypKH9irwSZuXxZZnOqzEJN4D5CSLe2go3tnIKpeHXhRER1Xo3DFhswyp1jRNoFD2BYxSM27M+bu4HBSLMPMZ/BC5HMoPIukvkwIf9FP0Add0Sl/84N4Uwd5af1Q1omT8FEOcDpvey6inRfh2NiY7AWA/nGF8T+Z827Rvz8a6yJW9LOhMS2mw2Jlf47tQW9sbbVjiTHTSxspxd8+CXWxKxW0UmxFw4fThn1jJCsBByzv01zycRNuVARJCU1N63i30Sms6H6HiFhfJSzm9t3RfY1OSFMwuexJ21U8z69j2p54k616MyO7dLxU9MWFW5OByWuH3DgcgVRCis5IsRIrWLnGMBcRBWvR9WDT1F/EU8iNmJWEZs2UBoV1P2NOWx2IrsgIhrBJN8wFjl3dkNBfj9gMscgAUCnYhAzksTiULkuDNk6Ds7MpI8F/bZIcCS1ZqYrZYh5G6kpNcEghySHtxkkphwN7LHP1O4xZgGiu0fjsXb0rPJ7x0BpqEDLhnP5qvRr3UN0MgyYy1KUDz6agSmjZCNTEcJnwJcOhdkhrIV5Nty8t/vUg4pN+Gn5ptBWbG+iFmkR4UtMrdk9uboGIabg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(36860700001)(8676002)(4326008)(26005)(70586007)(478600001)(70206006)(5660300002)(8936002)(4744005)(41300700001)(6666004)(83380400001)(2906002)(7696005)(40480700001)(336012)(54906003)(86362001)(356005)(1076003)(186003)(81166007)(82310400005)(36756003)(426003)(47076005)(40460700003)(316002)(82740400003)(2616005)(6916009)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:37.9370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77a2e2b-0e74-48ce-d2f2-08da87d733a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4532
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Fix comment to indicate correct visual confirm option

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 1184bef22673..7cddbc431b57 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -234,8 +234,7 @@ union dmub_psr_debug_flags {
 };
 
 /**
- * DMUB feature capabilities.
- * After DMUB init, driver will query FW capabilities prior to enabling certain features.
+ * DMUB visual confirm color
  */
 struct dmub_feature_caps {
 	/**
-- 
2.25.1

