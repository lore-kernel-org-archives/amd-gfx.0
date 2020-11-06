Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ABBC4741F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143AD206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c33vigaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143AD206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CD56EB53;
	Fri,  6 Nov 2020 23:19:33 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680082.outbound.protection.outlook.com [40.107.68.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A5AA6EB53
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5hjOetYcLPh3ntMCUBqddLEJYn6l+C4nsGPXSEDC2j8B3z3CVpsJQKCtdBCjQftXzLJJCNXQLe0eqzjlLOQ8uUTzWN0/djRtfHwQvwGi/Jl+et01C3ahfb8FHqK3X3lJDlRWtao44NSaMBhQjYS37i9cVqQra/zKdfgeRGXkn6e50cw8me95rvPYTnFxwUggEk6KtM8okRq2L9xS1DhRD27CRI40G1cJC4TaAkfhldqcsFjP1fDtWojqXyGvbxpgl0KKEoQBzPlsCP9PMxgNjHWsjSBTDHZhywp+Rm6oQZtV3pqHb2K95xgTtdyHbl7WQ/lKws9ZUUENG8Fv8jTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtRAO6xoWG6Gl8q13A6scKAPuNKLwJJ+xKS/W6F4qU8=;
 b=Balx86UEJrd58x5Ho+5pZqDdw/H5z/GIorZlQJoBeQMaNtGacdNpeAet9fvOssyx+7ks3Gz4HHhXVt1gjvQ5qDALbnH9DVSFJy44Oihkj35cTaTVHD4NULNbGIMG9sOaj8UxyVputfg29TfNVXKfC9C7RB+i1KQ4cLndIo51UcqoH0uOtVwKIOLv9I1y+UGJfB6UAyHMJ1VHiqk1kL992Vj6JiUMrx+0lhXKX81A3KwUT6qYqzkPLylHKN7pNU47lev0msrkQ15ksMaBa9sFSNezZ2BkGg8Krw29B91O/8oMJ4W1t4doEPNGpytleNSlAYP8q7euP7zqX5ku+M8Syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtRAO6xoWG6Gl8q13A6scKAPuNKLwJJ+xKS/W6F4qU8=;
 b=c33vigaAaoZ8lIy/l0SLAZL92qiwyp8J2xjhgMbh58Jz/XcejPJUlNSR/TefiEmpCQzJ94IEbN0fYvs2usaPVIbBfEvj84GidESasx8n7efqiEgDM31g0FrJTFPuar8ulcc97phn0pzhenKT6jTWyw3rJSgyEJ3/IHprzx8IvJ0=
Received: from BN6PR13CA0037.namprd13.prod.outlook.com (2603:10b6:404:13e::23)
 by BL0PR12MB4993.namprd12.prod.outlook.com (2603:10b6:208:17e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 23:19:31 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::8c) by BN6PR13CA0037.outlook.office365.com
 (2603:10b6:404:13e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:30 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:30 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:29 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: Explicitly disable cursor when
 disabling CRTC
Date: Fri, 6 Nov 2020 18:17:05 -0500
Message-ID: <20201106231710.1290392-10-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6955257-a4b3-4588-2745-08d882aa6a2b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4993:
X-Microsoft-Antispam-PRVS: <BL0PR12MB49930888DE2BB720562FE971F5ED0@BL0PR12MB4993.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Fbh+WBsKLfj7/soCrGif1VyziCzw1pgGm2I1edXvLNlxiMRPFRPnWyzBewywGkRBpDsxMtPn3SaLsD4O7a/vgvMt+OknfZmUGh+EFk43EmeRiitCDhWt0Ng8YysPo9OFbtfFrW6Oq6GaL/IiD/yjYBinmO8ulYY6x2xsfEkI1CJ0W6XXiMoO1T/w45e2dqX+mEKw4EGz6C0HJKb4q2JmgYEKraPXgwSY8EwHCteIApREOOAkm4wl/tBwUcGxaZyJc9TGz/4Mul3Kwrvok1lIj1e571yHt/y9i+1GVjvu9hIZz1xw0kvhQg/Q8zNFxuMXiyiMTSQs33KbqFRtIr1CS9icGfscf3nGFJurDB5QcbORW9y+F+ggXmXSqrj6AB3zmL6oZPAfXjo01iy2epL/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(186003)(86362001)(6916009)(26005)(70206006)(316002)(6666004)(478600001)(8676002)(4326008)(82310400003)(7696005)(83380400001)(2906002)(8936002)(54906003)(2616005)(70586007)(47076004)(356005)(1076003)(36756003)(426003)(336012)(81166007)(82740400003)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:30.9749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6955257-a4b3-4588-2745-08d882aa6a2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4993
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
On DCE, the cursor is not being disabled on commits where there is no
CRTC or FB enabled.

[how]
Explicitly disable the cursor in the commit tail only if the pending
commit disables the CRTC.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 88893c9711cb..c147ef8120b9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8176,6 +8176,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			new_crtc_state->active_changed,
 			new_crtc_state->connectors_changed);
 
+		/* Disable cursor if disabling crtc */
+		if (old_crtc_state->active && !new_crtc_state->active) {
+			struct dc_cursor_position position;
+
+			memset(&position, 0, sizeof(position));
+			mutex_lock(&dm->dc_lock);
+			dc_stream_set_cursor_position(dm_old_crtc_state->stream, &position);
+			mutex_unlock(&dm->dc_lock);
+		}
+
 		/* Copy all transient state flags into dc state */
 		if (dm_new_crtc_state->stream) {
 			amdgpu_dm_crtc_copy_transient_flags(&dm_new_crtc_state->base,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
