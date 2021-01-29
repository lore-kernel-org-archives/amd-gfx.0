Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B31C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9F664E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9F664E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F342F6EC29;
	Fri, 29 Jan 2021 21:28:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140CB6EC29
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV33oi3zhv3Slc0gXjvUIH9u2nyglnzMBp2JT7948rjSiKNf0DKqeAS/xX+52pX5AHj16qeBfL5dr+tCyeVN8XK27uy9JnCuS+IVBwCB7IxqWQfuEA2guMlSB9vPbn07/9iIYEBFBdSXlhy7/PddDki8rJEwzyu3A0iZjyNXxbk/+N3BM+6wUId+mB1HnKc9q2EnS0DkedAquQ4HbLWPFYLY5UcnjZhERh6pz9WgNwLbHx5ECudTpyv7RSs72FV8zz5QHeQO12VyLWqpVOMjGg27CWS3kXSqSFdKiMR6Ff7cJSc4gZFu/J0uDje0Sl2G55moENMkBVEcAR0r2ojdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWdrp9cZeJtEI4wcZyttq73oZ0gYKC5FZwBAu5LU9kk=;
 b=DMltCjPWI/o4KJyuanTowEcgMM5D91vA9Gp0wakhjijZPyoyW0cjlbP5v9tAJtT8U7Yd63pORKE83GAyXJW/ZV+tK4UgSucAiMt+zdrrLNq5TXw1fUEXTibmZOIbjL6AwTdTPqqTLXHiIwYUAGA8ox/FkVzPzHM+64INyOwIGnq3z14lfstIMi++sSyy5wXrOoBER7Ij7vbjdY0tX/8Wte4Artw7MSqYQqhjXdaW/iQz1TZZsfw742viv6z8XP8Q6MfYCmdqYRphv4eMPT0dCWMph23tfl4ExHgXIpN6hh+Ckt3kD71xgA0HJ7cJ7IaSOEOhUDZfgykcS59uPfaxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWdrp9cZeJtEI4wcZyttq73oZ0gYKC5FZwBAu5LU9kk=;
 b=QNhMQ5adNYKbOPr993vCEwxkosvDJV2f/RvJpYrtROBgJGqwOr3dqQNWxdGITfnWDjW0QLz/UE7KR71DVR/P6bQOa2ss6HWRyttgZlnmePEwZOzGCNq3LZ0AHZS309kBIb3gEgTlirgpcAlnjUJ5QwRV5YcA8q4CzxlbtHAVxg4=
Received: from BN6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:405:6f::30)
 by CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 29 Jan
 2021 21:28:22 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::10) by BN6PR03CA0092.outlook.office365.com
 (2603:10b6:405:6f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:16 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:15 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:15 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/27] drm/amd/display: Revert "Fix EDID parsing after resume
 from suspend"
Date: Fri, 29 Jan 2021 16:27:37 -0500
Message-ID: <20210129212752.38865-13-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4805fbe2-7826-4d9a-2fcf-08d8c49cccd9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4969:
X-Microsoft-Antispam-PRVS: <CH2PR12MB496916BE10FF9375F7B8BC43EBB99@CH2PR12MB4969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:74;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ig3y+qKGJS25owRdssvkJD1xzFzgkFpoJg/nAt7BTMyeZXNGSy5sitbA/48AcsQ4VOoOhutSQNiys9GNecAOSp+jGQmh8gJ8nxJ6WOoAn2XoK9IrBk16242h033QkGIgS+X2T8WxwEcIdZJz6c3OfMHp65viEs9G8bjWEoq2NBcgrZjUwIjPlIdUgeMtjvBg2YddfnLlYKBhHXMW/awffDDZk25YaiTqXNmRQrgpcR5aRMufFYLLTeKJZPiQZbmSFWyHNMjLG1hV6gAwALgQ7UU/19C+tDz0ywqz5GbErIGWrL1bYtOKmnXgFerj4Jsg2vVJLOP3jb4eZ2zdwGl7R3gpqgkTYUtQq6gJb5rsfGHQVEl6B6DwgUg1s/J38++Ol6rNAIdNxfUq5n/kbzjqA94Oc6EP08osidO9VWsAY24gaAT1KscupeiGJIO7awIXCClusMp49C6g90MnWFnBDRFJqgXgVxqXtLntqfLJ4heORbo2qYR4Xl7/YB2Bc3F6jUQnjAQXqvEd61g35ZUyjnMTcd6ZfwwyYpB/jL/QFVEWtLzm2VZ2/OOXOk9t9rnKjEgFVN3thj8PgNiubMrVyUKMxpiELISO7v3I59wXvw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(46966006)(6666004)(5660300002)(36756003)(83380400001)(4744005)(498600001)(8676002)(1076003)(2616005)(26005)(81166007)(356005)(54906003)(8936002)(336012)(426003)(86362001)(4326008)(82310400003)(70206006)(70586007)(47076005)(6916009)(2906002)(7696005)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:20.3213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4805fbe2-7826-4d9a-2fcf-08d8c49cccd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4969
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

This reverts commit b24bdc37d03a0478189e20a50286092840f414fa.
It caused memory leak after S3 on 4K HDMI displays.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 68209d0a420a..67629ab0db61 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2348,8 +2348,6 @@ void amdgpu_dm_update_connector_after_detect(
 
 			drm_connector_update_edid_property(connector,
 							   aconnector->edid);
-			drm_add_edid_modes(connector, aconnector->edid);
-
 			if (aconnector->dc_link->aux_mode)
 				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
 						    aconnector->edid);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
