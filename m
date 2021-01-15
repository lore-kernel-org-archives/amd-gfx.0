Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE01C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5970A238E7
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5970A238E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0157B89708;
	Fri, 15 Jan 2021 17:31:08 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690045.outbound.protection.outlook.com [40.107.69.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F0889708
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6G8k6+y5r1cs2DZ7a8sgs+9yEkOOYFrwEKYmyFBcK4NEhjfKx2SsFULG0DoGrT0pBkE4st9yYTupaj8MW+HB+eJna4igJHgTt19Nz3n8zk6A8tRTYQ+Mfb4SjEBTyKn70wcg3qREAmp1+LF91KJV09yLeftyrr9KYQ0mermrEP5FCcTtAATif82L2Xv3rsMJEXHU7pqy22XxzIAPJGALHfHsN2C455Ad9zekd8gauOuk3hVSDqoH3IEhqdWFMGFy3P2D7NXoDnUNnkhBuJVfE/tJNIaSvoP2W19QEpluO/cSIXivkyhyhPyMjIruLm0qKyPzgxo5NWkCXGqn3ktqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrHaPTWJzs486qybQ4eYr6LwdJN1qLvUYLYJYFIhbXE=;
 b=Z95LveydPtMyXtZFP29vTvKhpMuaMghqWpaZ2FeHmRR1POUyU7LMTHJ7odjczI7vER9IOJaUAZWGwNpeUNzhGBlkLcLMDuUiTvzf5W5i6k7iZRXAp111HRgdGUb9yVmYSjkaP6EkrvLJBEjcmXSdPGaChSg1+l4yn3+5gX+3pcjZvmI6zSaGoXq3Vv5YPvrSDiHnFQJ2kwhL16IMzU6/Ev9IzvH0gX909d3YbFP2zVFB6BgygucsJmCZID6nwDU4yDzNYomAdKn+goImNagtNTxKi2vad01eSJ/QczGDEp4R/a/Vn3LsHmmRdB3YNfAzu7IiPeJyC41T6H3j6MPIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrHaPTWJzs486qybQ4eYr6LwdJN1qLvUYLYJYFIhbXE=;
 b=WJPfl3arDcMJs/w6DwSN92iiZbCbdxb548MoIYBR+bGoqMa+GO9cfNIbpT/3Di0Jx5d4AisN1esfyQL6g0XGNVBym5z95aJy+sdMhRE78y49vDepvktdj76Yr0Av5F8bbTG3gjonW7D9jwU9Qk1KEY7TL20p557oLCYG2V3zEa4=
Received: from DM6PR04CA0022.namprd04.prod.outlook.com (2603:10b6:5:334::27)
 by BYAPR12MB3478.namprd12.prod.outlook.com (2603:10b6:a03:ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 17:31:04 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::69) by DM6PR04CA0022.outlook.office365.com
 (2603:10b6:5:334::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Fri, 15 Jan 2021 17:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:31:02 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:31:02 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:30:56 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Guard against NULL pointer deref when
 get_i2c_info fails
Date: Fri, 15 Jan 2021 12:27:09 -0500
Message-ID: <20210115172714.126866-8-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a712a242-b7ab-4662-5898-08d8b97b54e8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3478:
X-Microsoft-Antispam-PRVS: <BYAPR12MB347831980FF2AD2E96EB4A60EBA70@BYAPR12MB3478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhxaOzbyhIvtjPhZgfqjkXvM5JqWJnGOillpzuhYlCeIzbjSVcpWC9Hut9P0+ln5MLd9/gnAe9lEuv5XPZM7mnezWJD1ZxX/yVOaihRkik3np54Ig+KLSxkYxI6xSWI3nzNpCHlaCH5jmJwWLJCWYlLY2tf0fp0gnht/X4s/GEYTrGJId+ezT6M3xl4CMyS5sa7GWxuI49ivOHLf1RLkxcE0+Xpt+81VF8JMgAUF/K55YyD8up4LIBSf3ZnWjoiVNkDemTQV8gpQgtpWXKQMtmouTBr7izZ8e2yVCzzJz4gKED3o+CMcOwjhqnCESputjW/wpCEfYmFRmaw1XK/m5CK4/jyXbkaifP6qI5NTM22abX5ec2gBHsYSA+Kd4wV7QbS2YTQ/yb1qMwllp0FRtvImjLikuemJWUIP0WY5tyX5AjnNJLyNkXDneEzp8aTkH9E/23D0sVN9rkL9Uptl8BXbmD6S/g/DZQzilJuk08YL1Y8Dxxv8UpF7+9JqysR+blUHl5p7JbWXobqYsS+smg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(336012)(426003)(6666004)(2616005)(54906003)(7696005)(70586007)(316002)(186003)(8676002)(8936002)(47076005)(70206006)(5660300002)(478600001)(1076003)(82740400003)(86362001)(4326008)(6916009)(34020700004)(36756003)(82310400003)(26005)(2906002)(356005)(81166007)(70780200001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:31:02.8564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a712a242-b7ab-4662-5898-08d8b97b54e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3478
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If the BIOS table is invalid or corrupt then get_i2c_info can fail
and we dereference a NULL pointer.

[How]
Check that ddc_pin is not NULL before using it and log an error if it
is because this is unexpected.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c7d6ceb8fed8..8b2d387a46dc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1478,6 +1478,11 @@ static bool dc_link_construct(struct dc_link *link,
 		goto ddc_create_fail;
 	}
 
+	if (!link->ddc->ddc_pin) {
+		DC_ERROR("Failed to get I2C info for connector!\n");
+		goto ddc_create_fail;
+	}
+
 	link->ddc_hw_inst =
 		dal_ddc_get_line(dal_ddc_service_get_ddc_pin(link->ddc));
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
