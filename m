Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75FFC388F7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 06:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D5022277
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 06:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M3jGHG44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D5022277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC8516E593;
	Tue,  3 Nov 2020 06:16:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538BD6E593
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 06:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St7MMP4FqyiM45Zy/spqP1mTgVAh3pVA3hISn/ivNigKHlxD3G8msAsjrn1GTcR2u/p3+FSNhXj4K9SldJWegMBzpVbORd/qt2OQ4YKG3ghZ+33i06U4lSm14+E7GWQwH1/a/kn4N/CIlLphuv7wHQTc3NFxltXJXNzWXMlLJL2C9vPvrcuMvUkKoAc8XqLDxPGO/tZN7YziVg4aij/ST8YwZFYN8XmwZp+tQQ5fePN17eqpzn1qu7jmx0a/uaLsVKxII1zXk9KeiBF2WHyfH8WvzrlWMxxSjQ90pRA9eUEtr3qt8eiOxq4OcDij4HdL81Ds6P2SaWFPVu5BBaoeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+nYXGB4n9PubFPw6oicC758igVlD5mNCwUhCZlBHNc=;
 b=oYRZZYhb8Ik0kRLuilBJ23c2z5c15KEcQj7etPsSKSVKoqERSfRgZqvcvHkj2dptEMM5VopNqxHLmSGjdll3CD0LeZDK6qcyE9oDMiYuRc6YkhguaJ022Ff4oNtcpTBDDh4O4F5J8g/3bc1C5XCmAE1LUy841VvzR0aTeMkR92gAZ30HzVx2IMeM1uIAvOvDhfcWlDBzTnhojnwRyuPFPqKkDWdJh8/eqbCLXHML7Ys68o4XdOrfmWdQv9rEoAfVnsUNil4fXGMIfmYi9Xq6eGcivgDQxRu9Sv33yZZpaQcs9HDD801Pf2rWUv9NT+H7BCTpibKTZ5yegCUgzdnVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+nYXGB4n9PubFPw6oicC758igVlD5mNCwUhCZlBHNc=;
 b=M3jGHG443wFTAfqOgsDtfifM7AtarMbdp7KpwZGhsBElEd6WdUOW9lXAjnYZb5g3P2csonWLiTiYaUBzdZEQSSY5kn9kqrBKN8oyC20ap/yeRiP5JhM53KCNoRArSRwW+cFWoAQVv0gHhrl2tnDwitIFj/sPB8vA36oeqCGgypM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.29; Tue, 3 Nov 2020 06:16:51 +0000
Received: from DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e]) by DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e%4]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 06:16:51 +0000
From: "Jinzhou.Su" <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Add Fine Grain Clock Gating for GFX10
Date: Tue,  3 Nov 2020 14:16:20 +0800
Message-Id: <20201103061621.10549-2-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201103061621.10549-1-Jinzhou.Su@amd.com>
References: <20201103061621.10549-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB3467.namprd12.prod.outlook.com
 (2603:10b6:5:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 06:16:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85a33524-6d6e-4888-d931-08d87fc00d8a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0217889D59A28F10048DC26790110@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsEEyRyOGPkE1QchPgseWW3B1DRxG7L5SrEE74W5qGYnPXm+Vu/xSkeYlAJUU1qvxwe0AMCVMSzQJBaDhaZeFsFdpzEJsLJadO3e/dvR0CEXyB5PT8eICLIRMDqrc1XMboGUO1fs/xfqVcmyF6MoQgZWuX8sgon+zc1w4Gh/ch1SQbDbnG70V+5U++dL7eCB+5tOt67GCN3vPhIctRfh2OmkksbUWvSol0tOkUMGOdzHn8hQ+5WGaWoHXgMLrBfuo6B/NynKMJ7Qo/Z74z5VnOyTVqqXKvP5wKAEPUFz1jj4Z3hpKiIE0BWDbizIxJuf9GvRBLwrzLueg2WqUVpoLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3467.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(86362001)(36756003)(6486002)(6666004)(316002)(66476007)(2616005)(6916009)(66556008)(83380400001)(66946007)(956004)(8936002)(5660300002)(8676002)(478600001)(52116002)(2906002)(16526019)(186003)(7696005)(1076003)(4326008)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Vpu97D1DRji2TC70L4Wg3llxJ31BXX7Rh9Zt2nkTgqypKrUgd+f2EWu9f5CMvQjRjieB7MH+9Z2pe4hKJVibPAArsmJfgboKQqi5CsODiN82QpUBF+zNHGC9bkOYEFpRRjDwiNF5xEvyGATFaj0BCTv4BlLSPqAqfo4mBWEeUQx9dBMYs2haopJPEaCPtpuUjw0RmsrMhvi73LDmG9l+5X/ocbDtQ9iZLwsevSD0B2V6ZAeuSVdys3RzHXzSvsgWL6XwCodFAu2WKh+bLFU3mv3Vc+ReNK96oPBEYvf3kl8mhm9MW76PsmePnUibn74cqLUsfIqjHoAvlHwDEizeJVv6pNeludBh8pPJVBRpUjFmBGvP9YeCMWdfVy9DSh7MNM1pT1qEoQjezf3L/EHbJpTQ7/WN/lnglI2Ouu6Iv7Ff3aF+xkTFw8uwpTzlUrIA7+W6Ak2oRudgr3jAlEAuzTu7XTaFbrzVGEPxUZykuE6ACCe6j3rEeP5SY1b/1GJOJ4Jbh0NW+BtS+I7Vx7ljpwD0893CRSXlVBf9KHZh+5bqv//z505yyjIqSmF77K/tOsbLyEaQqkr6jTYrr6YeuI1f8QYW82g2lq6I8jPM7KExu3KBLFxVqSQe6R31HGzDpbzvppQnf/3dx7rGcnOdXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a33524-6d6e-4888-d931-08d87fc00d8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 06:16:51.2106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+nTyPNYXaDwn2Qu0WdRFCskPq/nPj35hfgEx0AhhO7qzOfEAaOyvX8bb/wuzULuRseB7tf5VCunh+exi8pF+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Cc: "Jinzhou.Su" <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Add FGCG for gfx10
2. Get FGCG status for pm info debugfs

Change-Id: I4df242c4afb0907706a1aaafb04c89cad2495b13
Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 76eba25b2d9a..7b396b21099e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7658,12 +7658,50 @@ static void gfx_v10_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 	}
 }
 
+static void gfx_v10_0_update_fine_grain_clock_gating(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t def, data;
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_GFX_FGCG)) {
+		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+		/* unset FGCG override */
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+		/* update FGCG override bits */
+		if (def != data)
+			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
+
+		def = data = RREG32_SOC15(GC, 0, mmRLC_CLK_CNTL);
+		/* unset RLC SRAM CLK GATER override */
+		data &= ~RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
+		/* update RLC SRAM CLK GATER override bits */
+		if (def != data)
+			WREG32_SOC15(GC, 0, mmRLC_CLK_CNTL, data);
+	} else {
+		def = data = RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE);
+		/* reset FGCG bits */
+		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+		/* disable FGCG*/
+		if (def != data)
+			WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);
+
+		def = data = RREG32_SOC15(GC, 0, mmRLC_CLK_CNTL);
+		/* reset RLC SRAM CLK GATER bits */
+		data |= RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
+		/* disable RLC SRAM CLK*/
+		if (def != data)
+			WREG32_SOC15(GC, 0, mmRLC_CLK_CNTL, data);
+	}
+}
+
 static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
 	amdgpu_gfx_rlc_enter_safe_mode(adev);
 
 	if (enable) {
+		/* enable FGCG firstly*/
+		gfx_v10_0_update_fine_grain_clock_gating(adev, enable);
 		/* CGCG/CGLS should be enabled after MGCG/MGLS
 		 * ===  MGCG + MGLS ===
 		 */
@@ -7681,6 +7719,8 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v10_0_update_3d_clock_gating(adev, enable);
 		/* ===  MGCG + MGLS === */
 		gfx_v10_0_update_medium_grain_clock_gating(adev, enable);
+		/* disable fgcg at last*/
+		gfx_v10_0_update_fine_grain_clock_gating(adev, enable);
 	}
 
 	if (adev->cg_flags &
@@ -7849,6 +7889,11 @@ static void gfx_v10_0_get_clockgating_state(void *handle, u32 *flags)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int data;
 
+	/* AMD_CG_SUPPORT_GFX_FGCG */
+	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_FGCG;
+
 	/* AMD_CG_SUPPORT_GFX_MGCG */
 	data = RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE));
 	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
