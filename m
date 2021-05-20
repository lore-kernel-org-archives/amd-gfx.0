Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5607C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 21:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C566135B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 21:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C566135B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11626E43A;
	Thu, 20 May 2021 21:04:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C6C6E439
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 21:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC8tM0GyfX4xfz7XNRzvvSDMJ4zDadAUFc50ubhkDlGAFcIAy2zcmRzvCyhZLIMWG/eA9+CC5hpy1ohuxK0Nq5YD3I4l1kipOKxO7o4V8f+LN3/lYIi2iz4jHscOJsTlDXoqc/dUdoUx7QdmgAvEHQTjw/ZptPNwjy7MlpX6PnA6mtM92Zkz6JS6GQSCZgaHdLlh6gktv2Ty1fu9ofjVCC09UAAlWruuajPy7aQ/lfnVZ+D8q8znZcYu1AjD9vgALUW9tx0UaHShs9mRncFqYSvpVREvaXy7K1Vtt753wXg8ye3xTbRkBTyh131wvGsrU3B9N7U6OPvsd0/TJegQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKKN+z4R//hXlcKBM217ew/yL+PHdF5xp1gFpTnXAS8=;
 b=byIp6WnyxuAqyWifKGVtG50k41fLRRr+hT/340NoIosvVsVJAp3/E7pUGW0p+2jQ0BNQ/JyExbYgc69Mxw3dXymcNO2QkCsSH/Nq66X7lp5HU0/YqZV+l2N61rVBrcPU8DLmZ8Hs+6HxFuSplACvVXyTdmZU9fqLDh/9HcCrsYPhlFfzMpZXzUY6eZ3FSzc753Z+hJJmaTiB5pLwlctUfIrdxOjkCUwl4Dni68sHt9ltqVwt6wGXFzLeM9te/j7Xd/zgw+g+sRda4ShuUfEvT2LBPm+iBlSguAg0qCad2zO8q2xC4ry9cOKcAqlcuyMAU81RnsN+YG401HAYsUqhaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKKN+z4R//hXlcKBM217ew/yL+PHdF5xp1gFpTnXAS8=;
 b=Wq/F531174K4QaVGaAJ43r/tjkWwyhg6XEBALtJDa1evUmuZlONo63GIdgCc3G5la+IF9cpY2m2mZQDBvMeIE1dwNV0xvHn3OxmRvfi2DFJe9rKAKuNm51VIo0YDjjc0Ujcrol2Efz30mZrZfpwX2FN4loty8ZxF63lFa8/nwLA=
Received: from DM5PR21CA0059.namprd21.prod.outlook.com (2603:10b6:3:129::21)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 21:04:56 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::17) by DM5PR21CA0059.outlook.office365.com
 (2603:10b6:3:129::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.4 via Frontend
 Transport; Thu, 20 May 2021 21:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Thu, 20 May 2021 21:04:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 20 May
 2021 16:04:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 20 May
 2021 16:04:51 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 20 May 2021 16:04:50 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Allow bandwidth validation for 0 streams.
Date: Thu, 20 May 2021 17:04:29 -0400
Message-ID: <20210520210429.2467700-1-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b491420-e65f-4e26-6ff2-08d91bd2ebce
X-MS-TrafficTypeDiagnostic: DM4PR12MB5263:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5263DD8FF3ACC6A081FBA310F52A9@DM4PR12MB5263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dz/KvPYjoHz1o047NNEnQL2el8qYjxQbUMgTaztPcxABQug2D/xa3uVQ8AlcA144PlvlcJwr2gZ7wP633jO5KMgbLxWS7FlGqWJ7fTCHZ1qGU5anxR0Rq8jThpqM8LS8al0bZ6RhsNL+5pLCzsxYKPZXiDvO4s9jFm8TuuR8lozlfLu1WnqfXeQWnT2p+kpjnfWOBfHzodbaLXDdiONQ0rSoG5UwlEBNuvccOJIJ5hYrCnaX8E/RUOzEcmkvEWFE27SqfhSqVtRF/W6qIOxR5+JVGkBddpRNopmJppArVIvOxN3uMrNMd7tlY5Kc/G4OAHBz5bcej7cYd2qqiSOqG/4yQESJMpE4Aw01embIABUInAwHDDNTT7l4POQMWBSJCCnKMWHbQfW+6AnIrayas4qpE84c8BgG8VHOWSsj8QC4psJ7BkTaBTfGqjm9pn1jhClchQh5JMyZ/w7fMpijwyHjyP3goLJFYVmYn94WXdr5+xdf07QuvQDuxx68zPNQM8BPum3pjYUl5AbEyXSM2VnuwscW457ystkfJv9S/NWCMgCQ+s8FCUDdgc5bt1akzfobHwbPau7PZVBeOFvHXzJpftoB52P56rrHDRvcRDVn6OImkhX+xnnFTAPLKgh/W6vd+Be/ANx9mQ1gBJVjDRawggJ83FLYsrYoLl229nTzMKm2jWNCOJBtgdCmbpwv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(36840700001)(4326008)(5660300002)(54906003)(1076003)(478600001)(70586007)(336012)(426003)(6916009)(316002)(2616005)(186003)(2906002)(81166007)(70206006)(6666004)(36860700001)(7696005)(82310400003)(36756003)(82740400003)(356005)(83380400001)(86362001)(26005)(8936002)(47076005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 21:04:56.1903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b491420-e65f-4e26-6ff2-08d91bd2ebce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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
Cc: roman.li@amd.com, Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    [Why]
    Bandwidth calculations are triggered for non zero streams, and
    in case of 0 streams these calculations were skipped with
    pstate status not being updated.

    [How]
    As the pstate status is applicable for non zero streams, check
    added for allowing 0 streams inline with dcn internal bandwidth
    validations.

Signed-off-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 6a56a03cfba3..0b49420e7d64 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3236,7 +3236,7 @@ static noinline bool dcn20_validate_bandwidth_fp(struct dc *dc,
 	voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false);
 	dummy_pstate_supported = context->bw_ctx.bw.dcn.clk.p_state_change_support;
 
-	if (voltage_supported && dummy_pstate_supported) {
+	if (voltage_supported && (dummy_pstate_supported || !(context->stream_count))) {
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 		goto restore_dml_state;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
