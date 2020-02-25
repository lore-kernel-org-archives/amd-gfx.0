Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B87C35E03
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5ACF20658
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vMaiZqgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ACF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725D46EAEE;
	Tue, 25 Feb 2020 14:30:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56C46EAEE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 14:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COM7FMs6rJMxKXHFVZ30h1GopDr2zyO5CqQgh5wAvf2kcS/LkYRSZ98sBo9J60DarAON3z3sLFStyEC2P5P9IbB1XTETD4Y644nFA41ewL2JnZDB9eH78c1DR+6wksNLbAZ3t3DE8KdPZNwPLknn6l/Gx9z0zCSUs4Z6/sK5vUkCNgXM2bZVnlF7edXQMxM5JA+a6brSPxNEio4cXXRuGrCkj1s+FWcl8FdjtvAiio8ZD6UaMtxcXzxmCRzqly0n/8tvDk06NvlgL0giUAh9wm3cCLobP/rJG9oXGLHJtmn43fBgXAq51+HTrBV9hF4OVy1aEO9Jpg/KlutB/dRCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfLKfTTNmerJygX2dh17fbR3PNYWsF+xVKrjrqnnEg8=;
 b=ZgnoaqrcXLoCFX3j8TGCIcv3xJ1U55FGedSFqC8rSXO6VA1IbROovJs0rGl91PKNnpMMTaofCUgYmOXyc1z1fbhlcBjHO5c1ORiq60ccaRMg7/haS2/JC+/PIYEQxvuJJUUZrdMfmqcFY4ErDswT8V9Nj+6hXyMztswHyh04vhbYJmrRHZ41HNdRztvruJM3xZuZ0qlOJbmYExm9y273ammWdCpr0WbLYoc1cm1xDTz8eKTmzrXVgbK2X9eGPy7/NtHgk3/qYft70MlSGi/ST2XJ739H/n8YXkGb3fvNPOH33YUuusiEagr9JM0tgF8FkgohwQ2LhUUFB/ZBtYN+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfLKfTTNmerJygX2dh17fbR3PNYWsF+xVKrjrqnnEg8=;
 b=vMaiZqgkeQ9U2rASmkY2tRsDWLw25FBwvpKR+DmLO51QDxI5wUb4hMRQ4XYQLNDG01pzPhNiIEiSCdJ1bc9fsc8a0Op0ap7cA3WHotfOSqXrf7FUyHhHRpbmeTHUquA1vHAzMBfKlhs6LYjwXjjL05g6br4uT+UxaU4cBl13wlo=
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (2603:10b6:208:16c::11)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 14:30:26 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::15c1:43a:bd6f:bccc]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::15c1:43a:bd6f:bccc%2]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 14:30:25 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix the gfx hang while use per-ib secure flag
Thread-Topic: [PATCH] drm/amdgpu: fix the gfx hang while use per-ib secure flag
Thread-Index: AQHV6+Olj5MVQsnBIkG+BKm8LvYdqKgr+AZg
Date: Tue, 25 Feb 2020 14:30:25 +0000
Message-ID: <MN2PR12MB3838CED3CD967213C6F3C5A0F0ED0@MN2PR12MB3838.namprd12.prod.outlook.com>
References: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1582639073-16555-1-git-send-email-ray.huang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-25T14:30:22Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=040769a7-0414-4d6c-aa42-00000856eb98;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-25T14:30:22Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5ea76b18-1932-48c0-ab98-0000323615a2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51d9c2f5-2785-47c7-54be-08d7b9ff414a
x-ms-traffictypediagnostic: MN2PR12MB3165:|MN2PR12MB3165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3165D2264D71E745E61B9AE1F0ED0@MN2PR12MB3165.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(498600001)(33656002)(86362001)(2906002)(55016002)(9686003)(54906003)(110136005)(7696005)(5660300002)(76116006)(52536014)(66476007)(66446008)(71200400001)(66556008)(81156014)(4326008)(8936002)(66946007)(81166006)(53546011)(8676002)(64756008)(6506007)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3165;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hfOCgc5GnIHbVStMYcB7JUiAOAah52P4J9V/33hYHRLLuYMdnyMLnB7FBzXVXRSM/3x5jxdVIfWm7XqjH07VsEiqA36xDYqbi7pY+nI1LEJyvQXRZ206xKzCcIuJ8Dbn0NIq8d7L5fckkgeEm/JGGBMMDC6WIw9d+plDAWIZYq3BV7ZelmGvWixyztuD1o3Iy8QdI4sMRDqFfTY3wQppIjl2Bu3dcer1Z7qZ5kxVkd5SweB6MWRt9l0U0COMdjLV0upyVi2yLpzYVrMbii5DG29Ny+embebvUh0Q9vfD3mOu/uGSaPOaYNEOfQ0nPRhv59OOURKMxzjmkLiMyCLV+E2OJnR+oi4slPqRf+dpd22oXpdZFaCXp5ixRCHJQXGC71ZXQ1k6jjV5Zo64vidBm0nPzf4MKz9hDOGv4dnu0OW7QAKhywYZw3E5lDnCOMqI
x-ms-exchange-antispam-messagedata: pa7A1z07M/ARSNaj/+bMwRQayatOM7n72nY0AJ6hGv24bt/JlZo1Wo8owGdOQUfy12guMGSduC+llSxDR/jPXpzCov0TECXSzbYqIRer3lZpNKE/fFIHTipByvtRPVhQi11gXVpteO7ERPpiyGqq/w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d9c2f5-2785-47c7-54be-08d7b9ff414a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 14:30:25.7595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYccBKC4OAvPVlNJDtNGDAi2QVCn2lC71iUkTaN0joUQDKPl8a1GCWowywiBRHTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed&Tested-by: Aaron Liu <aaron.liu@amd.com>

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com> 
Sent: Tuesday, February 25, 2020 9:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Pelloux-prayer, Pierre-eric <Pierre-eric.Pelloux-prayer@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix the gfx hang while use per-ib secure flag

Since 6643ba1 frame control packets are only issued in presence of secure IB(s).
This causes hangs on some hardware (eg: Raven1). This patch restores the unconditionnal frame control packets issuing, that's to keep the per-IB logic regarding the secure flag.

Fixes: 6643ba1 drm/amdgpu: Move to a per-IB secure flag (TMZ)

Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 41 +++++++++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 +++++-----
 4 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 4b2342d..9713a7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -131,7 +131,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
 	unsigned fence_flags = 0;
-	bool secure;
+	int secure = -1;
 
 	unsigned i;
 	int r = 0;
@@ -216,7 +216,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		amdgpu_ring_emit_cntxcntl(ring, status);
 	}
 
-	secure = false;
 	for (i = 0; i < num_ibs; ++i) {
 		ib = &ibs[i];
 
@@ -228,27 +227,37 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
 			continue;
 
-		/* If this IB is TMZ, add frame TMZ start packet,
-		 * else, turn off TMZ.
-		 */
-		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
-			if (!secure) {
-				secure = true;
-				amdgpu_ring_emit_tmz(ring, true);
+		if (job && ring->funcs->emit_frame_cntl) {
+			if (secure == -1) {
+				if (ib->flags & AMDGPU_IB_FLAGS_SECURE) {
+					secure = 1;
+					amdgpu_ring_emit_frame_cntl(ring, true, true);
+				} else {
+					secure = 0;
+					amdgpu_ring_emit_frame_cntl(ring, true, false);
+				}
+			} else {
+				if (secure == 1 &&
+				    !(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
+					secure = 0;
+					amdgpu_ring_emit_frame_cntl(ring, false, true);
+					amdgpu_ring_emit_frame_cntl(ring, true, false);
+				} else if (secure == 0 &&
+					   ib->flags & AMDGPU_IB_FLAGS_SECURE) {
+					secure = 1;
+					amdgpu_ring_emit_frame_cntl(ring, false, false);
+					amdgpu_ring_emit_frame_cntl(ring, true, true);
+				}
 			}
-		} else if (secure) {
-			secure = false;
-			amdgpu_ring_emit_tmz(ring, false);
 		}
 
 		amdgpu_ring_emit_ib(ring, job, ib, status);
 		status &= ~AMDGPU_HAVE_CTX_SWITCH;
 	}
 
-	if (secure) {
-		secure = false;
-		amdgpu_ring_emit_tmz(ring, false);
-	}
+	if (job && ring->funcs->emit_frame_cntl)
+		amdgpu_ring_emit_frame_cntl(ring, false,
+					    (secure == 1) ? true : false);
 
 #ifdef CONFIG_X86_64
 	if (!(adev->flags & AMD_IS_APU))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 24caff0..4d019d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -166,7 +166,8 @@ struct amdgpu_ring_funcs {
 	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
 					uint32_t reg0, uint32_t reg1,
 					uint32_t ref, uint32_t mask);
-	void (*emit_tmz)(struct amdgpu_ring *ring, bool start);
+	void (*emit_frame_cntl)(struct amdgpu_ring *ring, bool start,
+				bool secure);
 	/* priority functions */
 	void (*set_priority) (struct amdgpu_ring *ring,
 			      enum drm_sched_priority priority); @@ -247,7 +248,7 @@ struct amdgpu_ring {  #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))  #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))  #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m)) -#define amdgpu_ring_emit_tmz(r, b) (r)->funcs->emit_tmz((r), (b))
+#define amdgpu_ring_emit_frame_cntl(r, b, s) 
+(r)->funcs->emit_frame_cntl((r), (b), (s))
 #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))  #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))  #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7b61583..748ac35 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -256,7 +256,7 @@ static int gfx_v10_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev);  static int gfx_v10_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);  static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume);  static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume); -static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start);
+static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, 
+bool start, bool secure);
 
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)  { @@ -4729,12 +4729,13 @@ static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 					   sizeof(de_payload) >> 2);
 }
 
-static void gfx_v10_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
+static void gfx_v10_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
+				    bool secure)
 {
-	if (amdgpu_is_tmz(ring->adev)) {
-		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
-		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
-	}
+	uint32_t v = secure ? FRAME_TMZ : 0;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
+	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
 }
 
 static void gfx_v10_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg) @@ -5188,7 +5189,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.init_cond_exec = gfx_v10_0_ring_emit_init_cond_exec,
 	.patch_cond_exec = gfx_v10_0_ring_emit_patch_cond_exec,
 	.preempt_ib = gfx_v10_0_ring_preempt_ib,
-	.emit_tmz = gfx_v10_0_ring_emit_tmz,
+	.emit_frame_cntl = gfx_v10_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1c7a16b..fbde712 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5230,12 +5230,13 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
 	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);  }
 
-static void gfx_v9_0_ring_emit_tmz(struct amdgpu_ring *ring, bool start)
+static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
+				   bool secure)
 {
-	if (amdgpu_is_tmz(ring->adev)) {
-		amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
-		amdgpu_ring_write(ring, FRAME_TMZ | FRAME_CMD(start ? 0 : 1));
-	}
+	uint32_t v = secure ? FRAME_TMZ : 0;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
+	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
 }
 
 static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags) @@ -6477,7 +6478,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
 	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
 	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
-	.emit_tmz = gfx_v9_0_ring_emit_tmz,
+	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
