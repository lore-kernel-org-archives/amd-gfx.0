Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CFEC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E2E60F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4E2E60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D0C6EE7E;
	Fri, 17 Sep 2021 19:25:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B586EE79
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3xMIsLwCTmu2L+X8trWwZ1ueR17EYGP3a/vd3iMKgF3kyfu8txv1Tc6PEe0arMi4YpIGUBaPD7adAfCaIn6dxlQtznBZQYFFGqT8a1WUNrhSWhC38N0UPibbuW1TKxcLtvs3JjhrMAfx7+ndcLyAzsFcfjOMYDEMAoFu3sFQqNyvWv/IJfb/S5KmnX2VPmqajG/uKwGBo0PSpi++wAbJ3TdnIeSkwwsGlGJaeiMkpekBy6X7hw+lR8o7M1s+kzgI2anv3QyAyziP1lz7kuKLFAmWFkaQwp7QTSpDxDltxqqkxvkS3//UAMatHhyqlUqND/X6aU8k9mKYIPUUC4E3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=c/MvOtEOmA0NksVTaHkP4cISg3dolEEdOTRd5Fw9DL4=;
 b=c/XPGllMWQJLAOpaRt6QBCENNVylX9ouw6tgu0bBiEJhNd7HTT/ZCRuw7c7uopS2sHABWNS6DyCoxxGajub3+cR2FOXjCJ/1OQTfPVV1Pj/+ucAtD8CK9UG+rasacdbMtTbNtZ8sdaHIhbEj38688dV8+yS0CF3gy+0mWTdrh27/PFTKIWJ045RThqCFqB/rsDoqEB1aW8f+1LHCHcyAgoGEyz076OfUpjcqrjifUkfYqa1kca7ToACjIwk+md1t6WUFLItJ3la7jWfpZIFA7wAZH1UX+enK9+8dcqah8oSEyet3Oo/QhM4KIHjryJMkoHypG8Jt5uRkbdQTFAv3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/MvOtEOmA0NksVTaHkP4cISg3dolEEdOTRd5Fw9DL4=;
 b=PON8HrJYqiZccb+/2DxQRiIQegme/gsX2cDRod8LmuGHbZzRCkN16T8vFpZfEge4G4MJx45FSlSABT2d97sahOMRfe2gauWROPzYqn0qF/aXEoYueFXuhWibwlvjxSX8zz+ZAT9hOOoHumH6YE5rh+YTF+PA1XViavjfeRwqsMQ=
Received: from BN8PR15CA0024.namprd15.prod.outlook.com (2603:10b6:408:c0::37)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:25:50 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::58) by BN8PR15CA0024.outlook.office365.com
 (2603:10b6:408:c0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:50 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:48 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, "Liu, Zhan"
 <Zhan.Liu@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 04/18] drm/amd/display: Fix DCN3 B0 DP Alt Mapping
Date: Fri, 17 Sep 2021 15:25:10 -0400
Message-ID: <20210917192524.3020276-5-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 07bf1136-746f-4bea-594a-08d97a10f524
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52050F2E2CE81B59F67B92A698DD9@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ok7z3r3/5f292fc637pekIU9TbZG4S8BU9AAQsIMUPTF06WPuVD7roNg876e03UXn8zB/QtiW2jyUbhXpaNnkmrE6mX5OoWVST0as1cIXLHrQFMfn+Rp4L/MSeWjgxWdgufwxmteza2R1jNkVxqrSWxn51+p4fV5G/AyB3yfNdPwMGM/RRjW9LB3fEC8kThSXFivO3m2ecCk5ETivbsQ3EBg3sZCLKfO+WcLsIjew7P1ZddAOjMflH+29leBBVd+jVjRpnlK+yR6QxcHusc0cOx1WDzuYvGB/HnZbFKP6WvmXaj2ndRTuxrBMBjMJGL3Oe8Q3oGRFevVA4HwmfHD2hUobQPr9yftROdslIHmHfC3hhs4Snf9TTC6uJ57SE0blRJvkBQPUVX9KvZfIXe/kQDVSCEV5XTLP8R4YpO6s1jVsnUl6zEwSeExSe7UqsXPbAIZGBzKNLtTWkLz4EDEcrAhj4AALIzBR3eFgkzU6UB8NOoysfbRDs3Lf2WozgIcMpT+/VAuqdV/Yibn6+p29bAiGi8oQsFySvFdxMiT0bX1JRWv5VcrlOM8pbVA4DSL2I7Zbp+w7TyI1P8eSPDF8r2aIDxIC/gZlttd2wVwPn2SKDI6fzv+pO0NDADBDZx36mMb6IQy7QYdMU/73HWzrUF3t4udlQlfOzYnk96V8Xu5xYM+OxvDfcGkuC81YBqlMjN5mDXoQj7LL7nm3Pdn1qCfoGK/F5gD0wH88/FetLg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(26005)(54906003)(47076005)(16526019)(8936002)(186003)(478600001)(36860700001)(36756003)(426003)(5660300002)(6666004)(316002)(82310400003)(8676002)(6916009)(1076003)(2616005)(336012)(4326008)(82740400003)(70586007)(70206006)(356005)(81166007)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:50.0072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bf1136-746f-4bea-594a-08d97a10f524
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
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

From: "Liu, Zhan" <Zhan.Liu@amd.com>

[Why]
DCN3 B0 has a mux, which redirects PHYC and PHYD to PHYF and PHYG.

[How]
Fix DIG mapping.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Zhan Liu <Zhan.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 613d34bde7dd..a823a64d02a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1383,6 +1383,12 @@ static struct stream_encoder *dcn31_stream_encoder_create(
 		return NULL;
 	}
 
+	if (ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
+			ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+		if ((eng_id == ENGINE_ID_DIGC) || (eng_id == ENGINE_ID_DIGD))
+			eng_id = eng_id + 3; // For B0 only. C->F, D->G.
+	}
+
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
 					&stream_enc_regs[eng_id],
-- 
2.25.1

