Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E6C55179
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B11206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T20boaCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B11206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F4C6EB55;
	Fri,  6 Nov 2020 23:19:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969FD6EB55
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECvk1fQsFKIqf8/kZeJhd4m1HZjqezC8/1vDOHQhGVmtRw0GuiAY+RT0BFsbI76/j+k8DTg53i9wu7lbi7zRiCO6vBZnJoQNu9j7DhB60jgmQKGgrlXlMbCyEdtY2DaVqjQOroNL/Wlutzzd3Xd9vPPM/i/fBrpsWRWB67mXDuTqzcpVt1OjZzm2gsyAxWeajq8IYfar1HB50saVKQwKc8GwU+QQ+A3OWPhq2kKCd+qIUZ+ilSyoNFhm4ddw3LEaBOs5cORS0rOoGjc/gxgLcgmGbUfVhtJA9Rg5g1az18Qw80HZMc8jcrHjaRr6+NQ0aNyEqokf+4xavZDjBg75QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edjImWX0HxMYvhEZWyiDPt1c4gLIKE347Plh9JrRjbQ=;
 b=GKkSgJ4reCYKFuYXJvV7765CYy2wgtRytO7fmPNztzNz7bcs3fXvlKpiBPwIyMKJiNiykWup2v0kZKBGhyyYj3zwQTO7Nns1jdSv5z1cYz28D3WTbEWRtMhhl2LySM7B9Fl7A6CMxxtThYegrfIRdhciSSrUlbsBdro2JokGr1/YjJsVSo0eyjDG4XPCdnq8Fo+aGjXV74iQSfLGxAioVCwFICg7NCxBqcN3fHtQiHDofQlsClL/fzaSyHjBh7h5VCu3onh9Ih2/X05Wcporcla/tuENF/nv2zXUyk2M+GAIDMiXKh4MVoEzOjTA8BggrGbvuLtpf8gp1+/9RkWWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edjImWX0HxMYvhEZWyiDPt1c4gLIKE347Plh9JrRjbQ=;
 b=T20boaCa+nG7YgpIMLpLpNRth9Mi4f8iNAchM8vZC31Gst7TT2XOxGggvln9t8Yz83HDN1S4UMdn5xn20NWSsQNYkS+K8mIsfWf8O28DXboS5va/3QhQjbsXtB1AVWiOpDJplc8HHDxXutbRfDrcQ+H3g2aA6p8UVTh8TYcOv0s=
Received: from CO1PR15CA0094.namprd15.prod.outlook.com (2603:10b6:101:21::14)
 by BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 23:19:25 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::13) by CO1PR15CA0094.outlook.office365.com
 (2603:10b6:101:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:22 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:21 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:21 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: Only wait for flip pending on
 immediate flips
Date: Fri, 6 Nov 2020 18:17:02 -0500
Message-ID: <20201106231710.1290392-7-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 420d5ccc-fb2a-4bfc-cb6b-08d882aa669a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3048EBC976DB2A6DBA05893EF5ED0@BYAPR12MB3048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aknSxwQMaybP1taCx+Xf9ZILUlbSYHU8MuVhgSwUk1mm4CO/r3sOWKV2cb48vOuySEtnicndYbrCnXLPT1fYERoKYRdq59GDZSRlMoJIMjSx/ADnpBNGs4TleeORFDqmgAqSv0r/V/uFOHJ2QWjE8CRbSimvnNlVSbkIeYW5UWudPCR0ns8wKioCTjAjsNWJpO7WxeQrxiryO6ranfpkRP5cly3PRfRDA5DFw2p0xHjBwmDaHWFcom2jdW3EananjnUjuWPaY8efph7WUw1R9jENWGrItMMY90c3KWqMISE94L4DCiEDM8TqOlrYmrhycXkuely2AKdIaCllTFeJhnWwF5X+Qx4rbGiEbWmSCfV3nneRiTxnkT9XxliIoPlDgoEl7ADrST6YOPSn+NEfySMiXq5750aoIGtxvrQMKA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(186003)(336012)(426003)(1076003)(2616005)(7696005)(26005)(6916009)(83380400001)(86362001)(4326008)(6666004)(8676002)(82310400003)(5660300002)(2906002)(70206006)(36756003)(8936002)(47076004)(54906003)(70586007)(478600001)(81166007)(82740400003)(316002)(356005)(14773001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:24.8618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 420d5ccc-fb2a-4bfc-cb6b-08d882aa669a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3048
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
We want to make sure all immediate flips are completed before locking
the pipes, but not pipes that are not flip immediate as they will be
locked by the OTG

[How]
Skip non flip immediate pipes when checking for flip pending.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 62788ad28230..da776de1dd1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1172,27 +1172,28 @@ void dcn20_pipe_control_lock(
 
 	temp_pipe = pipe->bottom_pipe;
 	while (!flip_immediate && temp_pipe) {
-	    if (temp_pipe->plane_state != NULL)
-		flip_immediate = temp_pipe->plane_state->flip_immediate;
-	    temp_pipe = temp_pipe->bottom_pipe;
+		if (temp_pipe->plane_state != NULL)
+			flip_immediate = temp_pipe->plane_state->flip_immediate;
+		temp_pipe = temp_pipe->bottom_pipe;
 	}
 
 	if (flip_immediate && lock) {
 		const int TIMEOUT_FOR_FLIP_PENDING = 100000;
 		int i;
 
-		for (i = 0; i < TIMEOUT_FOR_FLIP_PENDING; ++i) {
-			if (!pipe->plane_res.hubp->funcs->hubp_is_flip_pending(pipe->plane_res.hubp))
-				break;
-			udelay(1);
-		}
-
-		if (pipe->bottom_pipe != NULL) {
-			for (i = 0; i < TIMEOUT_FOR_FLIP_PENDING; ++i) {
-				if (!pipe->bottom_pipe->plane_res.hubp->funcs->hubp_is_flip_pending(pipe->bottom_pipe->plane_res.hubp))
-					break;
-				udelay(1);
+		temp_pipe = pipe;
+		while (temp_pipe) {
+			if (temp_pipe->plane_state && temp_pipe->plane_state->flip_immediate) {
+				for (i = 0; i < TIMEOUT_FOR_FLIP_PENDING; ++i) {
+					if (!temp_pipe->plane_res.hubp->funcs->hubp_is_flip_pending(temp_pipe->plane_res.hubp))
+						break;
+					udelay(1);
+				}
+
+				/* no reason it should take this long for immediate flips */
+				ASSERT(i != TIMEOUT_FOR_FLIP_PENDING);
 			}
+			temp_pipe = temp_pipe->bottom_pipe;
 		}
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
