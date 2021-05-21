Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5072AC4707C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE45611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE45611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF39E6E542;
	Fri, 21 May 2021 17:37:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB4D6E51B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/U9XvdGjNvtDJM8GPPrm7Dk6Ji8T/7eqn3YVlW+CsgmCM9P6pfQ0yZK1QfgWotVpTeGoISCyANpfZzZub/kF1TLy8nO0d1soF/CK+YbThFWhscnYnNZ+zjRUCuNwXvoaoearSL7Q6r/LPdWX0EtFJYvhLXhA7wW0KYGXRyuDc/jIjDvkrkVS/jgupDAoBsu0wt++MqQp+s5K8GdRRjX/UB0cDobSv0FhmVeTJrdClEfd0P2uyxacr6aTGOYHnVz8EK4otSGx055eUmKO2Zo7yL8ehxPOFxbeFwEk0dr/R8LiizMEi2YSHv6XMoMQWica93hfjRK87e7XS4pBqJ0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zi4brOd47YNcsR+U06czVuRB4zfO8SzsOQBcCtzwf0=;
 b=X0FLuOT+e7gKeLQDoUxcw8GKGG6Kd6M0j5WB3erCI8vI0UPbZ+PACF2tL2DITgyVx+LpNrZwMnoJkgw68SwZ0h/BR7C0eGxaJEJm9zEQUgiz7xdOuEzgtziNC38nKWtm3DmHHN4eGv+Hrx1QoIWy6qGcGisBA5yc9Wax7Q2VkKVgFHmLNFMaIKRc3QKCE+7rcANIq12tcwQg3dyzVQJ8N5Vmef5tdEzfZRm5Cjmxd+IOrTcK4LR+XHgbIiWWm30ELuKdPxZ7tc6pf9fUbW7jxR3lnU901Gf33O7sYevoluKdiNVs8/rE6txjb43sJXDB9wipCmNsOZ43UxSv/Y4+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zi4brOd47YNcsR+U06czVuRB4zfO8SzsOQBcCtzwf0=;
 b=U/1IWgAWGQqM55QnXQmI9fcyUhsRDhRgz4UlFskvFoG5UnSgQ6OItQ3E50mEJNhT+3cE6lYY+S2/YdGpHx5BMLNXzfyhzutA8hTwgrZiRXSWBJwLSqWsf5i+lGngDB571czvR4jpCfgoYnCT6+40QbRW+tf5o0b2vFAp/IlOlVo=
Received: from BN6PR19CA0062.namprd19.prod.outlook.com (2603:10b6:404:e3::24)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 17:37:02 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::e7) by BN6PR19CA0062.outlook.office365.com
 (2603:10b6:404:e3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 17:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:02 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:01 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/15] drm/amd/display: Remove redundant safeguards for
 dmub-srv destroy()
Date: Fri, 21 May 2021 13:36:37 -0400
Message-ID: <20210521173646.1140586-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03ecc6c0-0e45-4280-3676-08d91c7f0b67
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0158:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01587DA5D9E36369A9014046FB299@MWHPR1201MB0158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: igUSTpoVE5kh4KfBFJNFUtFzND7c60UV5vQH1tGRyqbHWHDJRAJFYjG5tznanYFNx82g/xGoldc+ALdeNa2B+/8q3Qhu78ITc6dUVqP5KK5zTQEUgSx/GiQtqrURx7sB6nMj0Vi5vafxUZdmqaMI4gMMaP31A+8uOeBWJ+iSW3CaaocEHuuSeYXiqefDVdEI+MIRH3HH5Qnt5P6Q6MWIstn+aboISA+fH4jOanCRBJtk4NDoFv3NPvkL7c5hdsvF8OLHSPRrqLtbeWTiyWTECrwTOAgYp4oZWXgcVQO6ld1R6+oA6VzkaTFwMzWVCD/URyLayS30e/gSA8t6jf9xSHKmynT80L7ZGiDYqBg3K/la75JqC6D8DJcxcokWKFvfzC+FJ6Ro5E5GHqKNEcBWh8kAZY4pkqLn9jeMHbGTOKfDEAWjd8MEwHm7Q9HDzroIUIFKn5bXY6pKnmXouLzmVWfA4TYx2YpOeknryND45mCApzMRR2h3Xt1+hUxwo0/vvgf4SAjUjQlTYMpzucMzZZP733qd0cDnrDAZSjS0agQ+0hkuURKS1QJQz4lWwNNPtLOUhsSR0YogbxeUPjgZJccl5hBGN6Eq1FajrNQX3Ssjvbf7rlMU5ItmUtwN32W2+mJxvG+XUbSBM3f2cGQD+IACT66G2Oljm9eaUG5m88ZzyO1s3M7W022p37UxkP6U
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39850400004)(376002)(46966006)(36840700001)(54906003)(81166007)(316002)(5660300002)(83380400001)(6916009)(8676002)(47076005)(1076003)(82740400003)(8936002)(6666004)(16526019)(186003)(4326008)(82310400003)(44832011)(356005)(2616005)(36860700001)(86362001)(70586007)(70206006)(2906002)(478600001)(26005)(336012)(426003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:02.6943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ecc6c0-0e45-4280-3676-08d91c7f0b67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
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
Cc: Lang Yu <Lang.Yu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
dc_dmub_srv_destroy() has internal null-check and null assignment.
No need to duplicate them externally.

[How]
Remove redundant safeguards.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 40d119354509..9be4ebb5fac4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1329,10 +1329,7 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	}
 #endif
 
-	if (adev->dm.dc->ctx->dmub_srv) {
-		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
-		adev->dm.dc->ctx->dmub_srv = NULL;
-	}
+	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 
 	if (dc_enable_dmub_notifications(adev->dm.dc)) {
 		kfree(adev->dm.dmub_notify);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
