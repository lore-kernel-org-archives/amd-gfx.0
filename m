Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27CBC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5531B221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NS8bDomQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5531B221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07EB76EAAC;
	Fri, 11 Sep 2020 16:27:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E19C6EAAC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 16:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QotPrnkj+8f3Ih7s2pQbHbcBapypd1PcZTL8GY3SAs58shok6Ul54sBmUvrAf56ArzIs8N8T5wj7NzLIcZ5CFoE53bmWfhkjS37e3prUIOEWFBr6CREm5OZve2LXtnbceaLOzIjg/V67cDWol7vtKSOddTR4hrM/0C9Jfhs1qEcanOKUluE39eSGPSPo03gZfd9vi2i0abSbqO93+NWmM1YUdZNVBEjZLIQNqlmEeuYfGSDFB4zAoVe1YZsgxlh/+3Tn7IDeF5plgo9wOnbHLl4d65ntc+yK8tenHfIV7U77tlYYfNuamv8967gYuuLWw5cVFalIDiyWmjyqwHqvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtdjblFofuaQlkEfrFwnzTyYPrJQ3MfVVuqb9lYtYBk=;
 b=KlRi8OS3FYtgPCh95zxs4FI2HINq1gLaQCAwvN59Q47ZGmMHvieu3XyTk3MpGqFFfQ2jhT8s8S1xwpDn0StWzprESpTHmApaejET7ab0Nuxsfjs4F0ZgHtceiZp8xoCBnDQ9KQDMnYiq77r3z1FQYaX3OLz3HJhu/qJzOHfr7OO074HG/wAi3tEr9nDsyNc5KgNyS/Em5CJTSNRRrnWC6jrFsv1IvWcvsV0vuWO/sGENDv5QkrH4SjL0smz2U7MQ/YVMiYpZROMaaXuN1egOFFGC3MuosHNCNIHjM2QiT1yvoGVYtP9Xs9fVYUp/yzxZvMmv6sgQ3besnup1ALUSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtdjblFofuaQlkEfrFwnzTyYPrJQ3MfVVuqb9lYtYBk=;
 b=NS8bDomQ/LNmC7MRlI5gKNnesDO6L1exS/oN36IBu1BomoewQWfb5vg2xMqE8FrMfEjMiE8FckJiIrDGJsjX4GxNw8m0S5jxDi6d3vh30CysRYE+1IfehSV4Xso0FbkN5tT448OlKNzEL4vtNbNIVWSg2PN/6VUsuM75+92SsIc=
Received: from DM6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:5:1b3::34)
 by CY4PR12MB1942.namprd12.prod.outlook.com (2603:10b6:903:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 16:27:15 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::52) by DM6PR17CA0021.outlook.office365.com
 (2603:10b6:5:1b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 16:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 16:27:14 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 11 Sep
 2020 11:27:11 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 11 Sep 2020 11:27:10 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd/display: Move disable interrupt into commit
 tail
Date: Fri, 11 Sep 2020 12:27:09 -0400
Message-ID: <20200911162709.87720-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911162709.87720-1-aurabindo.pillai@amd.com>
References: <20200911162709.87720-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f7394f5-7eed-41e4-3a4c-08d8566f8b20
X-MS-TrafficTypeDiagnostic: CY4PR12MB1942:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1942D588A35162420570DCA78B240@CY4PR12MB1942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzAoIke0yo0ioYVjut/OHarCXxKaPhKFegNHbNVdoOJYSKEUWvkQRMLQu8UeZtCxMrb8BaydkcSlWNeUOidvMN5Eh8+KsGnHOs68aQQ6w/nxLoQcNcdyDtzfu4G022HUDAADcVzqISxVud+NMZezKd80UrOLfvp0LVd9AAISQicyYMiBkjKC7RgbxF2Euj0PNOS0NpD2gzvAQzLivzVI2cC2Tp3R4bJEf0XqMthtSQMRWi1CxkAUtcDSOO+IM3btds6ZbpzaCrI68Je6dFqDgoTz0oHYx7og9nsihJMTgmjZ3WCc4ceGopCcKSI5z8+eXv61g7hMCKhpYmBbrs85/IGFYoIbbA1WGyALJEtgbtDFzfrq4w/Zr5VBLzLRWlIou8GN1yZ/17WXFTxLveqhmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(70206006)(4326008)(1076003)(2906002)(83380400001)(6916009)(70586007)(36756003)(86362001)(7696005)(426003)(44832011)(2616005)(8676002)(8936002)(26005)(81166007)(5660300002)(47076004)(82740400003)(356005)(82310400003)(316002)(186003)(478600001)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 16:27:14.7529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7394f5-7eed-41e4-3a4c-08d8566f8b20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1942
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
Cc: nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Since there is no need for accessing crtc state in the interrupt
handler, interrupts need not be disabled well in advance, and
can be moved to commit_tail where it should be.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 ++++++-------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1455acf5beca..b5af1f692499 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7488,34 +7488,6 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
 				   struct drm_atomic_state *state,
 				   bool nonblock)
 {
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	int i;
-
-	/*
-	 * We evade vblank and pflip interrupts on CRTCs that are undergoing
-	 * a modeset, being disabled, or have no active planes.
-	 *
-	 * It's done in atomic commit rather than commit tail for now since
-	 * some of these interrupt handlers access the current CRTC state and
-	 * potentially the stream pointer itself.
-	 *
-	 * Since the atomic state is swapped within atomic commit and not within
-	 * commit tail this would leave to new state (that hasn't been committed yet)
-	 * being accesssed from within the handlers.
-	 *
-	 * TODO: Fix this so we can do this in commit tail and not have to block
-	 * in atomic check.
-	 */
-	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
-		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-
-		if (old_crtc_state->active &&
-		    (!new_crtc_state->active ||
-		     drm_atomic_crtc_needs_modeset(new_crtc_state)))
-			manage_dm_interrupts(adev, acrtc, false);
-	}
 	/*
 	 * Add check here for SoC's that support hardware cursor plane, to
 	 * unset legacy_cursor_update
@@ -7566,6 +7538,19 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dc_resource_state_copy_construct_current(dm->dc, dc_state);
 	}
 
+	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
+				       new_crtc_state, i) {
+		acrtc = to_amdgpu_crtc(crtc);
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+
+		if (old_crtc_state->active &&
+		    (!new_crtc_state->active ||
+		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
+			manage_dm_interrupts(adev, acrtc, false);
+			dc_stream_release(dm_old_crtc_state->stream);
+		}
+	}
+
 	/* update changed items */
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
