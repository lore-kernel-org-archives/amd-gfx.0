Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D5DC433B4
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D4F61029
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D4F61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D34D6EC60;
	Sat, 10 Apr 2021 02:05:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A236EC60
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:05:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSfp3DgWX67sMQcONUaw3k0h7cwsTwO1otPeF9wkTy5du3RnCcFhnHclbaipHwpPwbCJX19Pd/FEf92GUE6KLCHFzZ52S/Mu5V/4+haPAeXcV6DgHNZJlTMo7Q9/ACr5XuoFoBu9V4hkU6qJpXxFbx2I83EqmG73SGWdhZGaEnAhh8PuHqklLR8mXc8LNIQwx6LQybGQgsi7IAAIHJeqiI0UoJmo7d9igokbTfxV2fYS9WwGIzTv+iqZMxsOF9OvgEgiggLlOYLsuyp4KSK/fBgcrpvuBU16hXE4t2tUsZ2AI1zuZU8mQ9DKCt4SfDNCILUlKugEHtDHUM6I7BoUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svY/JUk+zFMXEW9sYVbpLXU8dtM0O3grnuwxK4H3e/8=;
 b=QLZ+O6Zq0WuphcvWf5ug7roGl4bBomb+R171oNeVWH+DsFk8SXpVpDt9sE60+SFLQAw9unU6KaxA583ilD9kncVoWXhlj7OKcfD7wi/hK0MRSuqb4AA01pVpzmU0kA1Qq2AWkFYYj524Hw7Mi89aC8PJA7cFtxGiztdnFdqC4g8KGi/Mm2UyqHf9TcpAA3fPOIffrLtYa8FZcpQTmQ1Q5OGKfCjVwcVPgpyPBdgtCTX3YNHbQPuQuhhvBMxsqY3luNBG7z58QueD/Sf9jmbBhAc4M2glzUka5WEQX3wjThM9Jjk3I/0ssJZLGE8EdgQUdscOiWAIVXuiYYja/p+N8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svY/JUk+zFMXEW9sYVbpLXU8dtM0O3grnuwxK4H3e/8=;
 b=QvzQAGlh5U9irfTxbD6ZYw6nXx1I/MHdupntU76VUxVMKVxpIDdYaGAMnW8zygavFzN6WbDMu1QX39v5gtJLDnVYVTPk/P/wkJdU47iqp4BePWQd2YtvCztHpTSuhsTvOAvwP6nl7w9bkAGzGOIbXTqEfOwZlsP26SPMx4JzXaM=
Received: from DM6PR10CA0003.namprd10.prod.outlook.com (2603:10b6:5:60::16) by
 MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Sat, 10 Apr 2021 02:05:01 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::b2) by DM6PR10CA0003.outlook.office365.com
 (2603:10b6:5:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Sat, 10 Apr 2021 02:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:05:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:05:00 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:59 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: Fix hangs with psr enabled on dcn3.xx
Date: Fri, 9 Apr 2021 22:03:59 -0400
Message-ID: <20210410020401.1100228-15-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dd76d89-1097-47be-a807-08d8fbc50cee
X-MS-TrafficTypeDiagnostic: MN2PR12MB4224:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42248720515C804DCB24676FF5729@MN2PR12MB4224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3/ZzVVQPg4T6S3rehDB56Xs4Z/DyhqgstqBqfiQhfMIvMxS5Ch4Xs81sEHnkJui+7iyNT+D4ZezRq/Efgy7pYyfbzYVkx0eJci5FWHLMSnFcnd2sDK5CoGf+Sb4G8n0ZVdL73w6hlERxnDO9zuuHMujgklckvS1vBf2z7Funohf3bNqk5IQbEa42+urONvlF2pEwA+D0RR5lIh7t2Oroi0GZu+Smink1e+fVsIYqdVcLuT/RG4XnkslERR7vh6Iy/j1khIJExOlzpAAy1j8Y4DUtqQXeIQHOKSgN85aSGmcEt0L2WRweejicwXIm5LtazJ+70gY/5IB8PGFmNEDIw9hXfFv7GqWQju8ChbBGr2fNq0lKXjTEdQuShhhBe9Nf8diGnk/T6M9pBm0cHT1LkE4CDGhnM570R9dSK90MFAd/0Kx72FGOdthqFtqZld/5NTw1i46vt1r6yKSoAhQ/LixATnUJ2lkOX4rkINMrz87VbpWplLjXDLPMa/wPDlCIHnyKeq27s7G8NtFo7+zkpp8xRnaa+0N3GXu/blaZGLuPp+VHiDpOKpNOGVme/XZIhvtKBL88ZQP86S58r1h3ilICxqGBAIjHEDtIXumZ1+QyssnzIpRB/oqqRdgdkQPzq88wzLM40EXkIdLwlpgu2DawKDi6Hg4D37np/fL9K6CFwGd6egy7GxPl43Ulc67
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(4326008)(8936002)(478600001)(8676002)(83380400001)(426003)(2616005)(2906002)(82310400003)(336012)(86362001)(1076003)(36756003)(70586007)(5660300002)(70206006)(26005)(82740400003)(186003)(356005)(81166007)(54906003)(316002)(7696005)(6916009)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:05:01.6052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd76d89-1097-47be-a807-08d8fbc50cee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bindu
 Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
SKIP_CRTC_DISABLE bit should be applicable to all dcn asics
not only Raven.

[How]
Replace check for Raven only with check for all DCNs.

Signed-off-by: Roman Li <Roman.Li@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ac7a2b74702e..9507b08567b4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2813,12 +2813,9 @@ bool dc_link_setup_psr(struct dc_link *link,
 
 	psr_context->psr_level.u32all = 0;
 
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/*skip power down the single pipe since it blocks the cstate*/
-	if ((link->ctx->asic_id.chip_family == FAMILY_RV) &&
-	     ASICREV_IS_RAVEN(link->ctx->asic_id.hw_internal_rev))
+	if (link->ctx->asic_id.chip_family >= FAMILY_RV)
 		psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
-#endif
 
 	/* SMU will perform additional powerdown sequence.
 	 * For unsupported ASICs, set psr_level flag to skip PSR
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
