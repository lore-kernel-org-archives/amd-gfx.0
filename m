Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B3C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 12:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F5361378
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 12:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F5361378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E8B86EEAC;
	Thu, 27 May 2021 12:16:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C85C6EEAC
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 12:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAan+3BM378L5gtYHhjLXo3pVbeud9XfOiQfTPyUhwiLIuFAK6xerEZER//PbFRa+byFDZSzhUEBvpQO4mEyQunN/RWWJc1Z7DF77zer9Yd32hSnsHFmroSsFxoI/KCN0xwXrBiRqgP1VQsGKtLYEXgGHfxpGi20VKltIPen+xNDLKvk0YzBCoFzng+wWC2IPCqPlcATVAqFRy9rPg/jh1DUmMNyJxQ3DHx6IHcTwKYMa1F28fYqNpyrXxG5VbnRWHND1IzrcCnZRBnd4qW1uvw2gMNQ9QtOPRJSxJOVVcpmmjR/53MaM9cfZat49zFc3+2GW2DCvAKTVs/TS7quqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHUCOLuEkO9DS3sVCE44t9jwORHKd11YwL+Kqh8VnsY=;
 b=DQZWB4A8kouNzBsKMqQVlc4pF2FRKDRvptjpMGhJAeGaOt3k6FOYsChWtHhw0sETDjTK1rUQ3ijTYgHid0s1VWZrotFE5ZotLMD/V4YJgxEbLw4R+evPzcYOWs6g7MyEdkf8nGHiQHKt1R0HEmJ+VKBcqpgN8u0xnQ/nyDe3lt6ElXiXnnuJGlKm9WgLvkRTAtjNzRnCFc0ELwofsMMyvHdBARcAHqCTfYhEDerV2MxqllZrSLsSzYpqn9ygrxa7KlybdbnEQrJjrgmTgu0oIJIMaGCpp6B3WamU62xJj3zMS0qlYVKhT+3HQR8YYDKUVnsKhUNTZAwQdoOTGIm3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHUCOLuEkO9DS3sVCE44t9jwORHKd11YwL+Kqh8VnsY=;
 b=F76/yod4NnKmDwTH0dVU5jChUWKEkM2CwP9I6GmQB1Fv0QDxmJgMlbhoiLeizgZUst5FDl9/Dpt2BrbeYGOVF7wMn8uz0rI4R55wwLu9BtbOw0c2P/eoWP3ze4Ikw2Odv89qMwopu5dFqSbYGAcpBpWsDPQAJLoKVvTxR5OdfAk=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 12:16:11 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 12:16:11 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH 1/1] drm/amd/display: WARN_ON cleanups
Thread-Topic: [PATCH 1/1] drm/amd/display: WARN_ON cleanups
Thread-Index: AQHXUvHp7ZOeIa6HKkSg/bFEvfsLeqr3PikQ
Date: Thu, 27 May 2021 12:16:11 +0000
Message-ID: <DM4PR12MB51368EC14A729844AB36FAD08B239@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20210527121448.33713-1-nirmoy.das@amd.com>
In-Reply-To: <20210527121448.33713-1-nirmoy.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-27T12:16:08Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b93c010b-b000-4b81-b9fb-86db74679d5b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2003:c5:8f26:2e00:4878:e1e8:520e:646d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 737e4341-7dac-48cd-82cf-08d921093720
x-ms-traffictypediagnostic: DM4PR12MB5229:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5229E58AA8341BB3F86EF8628B239@DM4PR12MB5229.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWwuZSASXk8r+2b38pElgAjaRkBHozgjX+szeokEsuqvXeDBbClmTwO4DEgbMOdlkgmwcsmNMTQYuXgY166pBTvso9SoZcvOAfLDY6Ym2Ox8srgGyyEmttyyM/t+I3PXixTlTzXxMERsWbVEI3Q02tkmpDznyS7btJ49GN90oKoP1ICg4nIJv01XqYFDCa1ynv3zFPcv7O3xH5LF95riuiuGfNvBh9xtUzUTVsTYC2LU3GsHI3xneAlB9x7Z0lYRVfgPNN9jSAxNopKT0H8eskUJ1EjVssFiNNqiyirGvwRZLgATOcmCIWy5odZr6ttBgcS0vtvX0pwfYU/bSlNMMx6cvWsp2Oye2fveGZSAH/1ipf73aEEcuHLHIw2/q8J9egLP/0snPs2Ri//DPcQgH+puievBeziivhNuDsKn74DqG589wb5Lb9rV8/OeW5tOoRPR//MtkDHzM7U7yiBWlATG4JOOXwHZYvi0f+Oze5W2q/6bWWaxAk8oPBgeCtgEeDG+nqDZyLUO0H9sH8FXlt4sBiC9p1x9EpXRqdh9G0oqRxzEp+GluP8xE2T4uYX+BpoLqq9ZGWPKYRTjkmNK4GK+anys9QiEGEw5nnOgNCA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(5660300002)(122000001)(86362001)(478600001)(38100700002)(54906003)(55016002)(316002)(52536014)(7696005)(2906002)(6506007)(53546011)(186003)(6636002)(9686003)(8936002)(8676002)(6862004)(4326008)(71200400001)(33656002)(66946007)(76116006)(66556008)(66446008)(64756008)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FWyg2N6iuf82Rp4wnQzGbB3CPnu0AFhN4HTg4xZygs0il/4riqH+XKbR6BAv?=
 =?us-ascii?Q?jOW0bzd3qfMRNf3nrSMLLkBfFEud3JYHFT9AJmhynUsZORkzDPKKpRNZPbA+?=
 =?us-ascii?Q?RNtgnE/qdu5OoxbvZz1l/0JyHnkCmryumypKftYd96+vo7ZDF9BBt+cME8eM?=
 =?us-ascii?Q?fzKaIVKBbpNVuTO+bQzzdXkZjp6RIsJ78Ie1IdnopklToJHhHEPbuGh/+3+5?=
 =?us-ascii?Q?9NAZJ2a8hU66jM6MrnuSMGWfJNGFn7clnVuvg7I6q2SigImKpgefmEpAtASu?=
 =?us-ascii?Q?PUaR4RF26pCKWacTTUwVsacFYMgR8bVG+n51sl6JsYDEZD6tZlO7SULTgvO5?=
 =?us-ascii?Q?pBdlfqspsukrwqkE/egm8ITR9at2J7+ihky9oAjGUfvP2Acget5QTp5LVBAO?=
 =?us-ascii?Q?8xqz+TcIWgRBry9D4CbYWiGwPMcKtc5qWgIrtDfMUwX6SZZPlxMVpKMUwcK0?=
 =?us-ascii?Q?P1rBRHVSWcqWw4IxbopubmnfOkWj4vJfTP+ccny5u7ZRVsHFpCnkA6zn6T9v?=
 =?us-ascii?Q?HSvvke3BYSjA1vLgwSDh6W09jqiVq1LFirNkp5XPyU1zII1RnqgRStzgqRpY?=
 =?us-ascii?Q?D+ZLXX2VT/2ANHcaoGpKkxvVHzoPXcLr1EvZx0DrcPpTNfwU67wbG4nYEGSF?=
 =?us-ascii?Q?lKXhMbkNXe7OKSLF/yjcycX/M2/MDqga2OJBAocfYnd4akAifliK5lLfEQiu?=
 =?us-ascii?Q?tlSznoXxTgGJPtDFcIEc1gVLmRRbLWQQYo7h0ZrZ29hyQQUqaGQ/y+T/V8Af?=
 =?us-ascii?Q?4FtZEz7eUOg/LWWLFlb8gHboyvQRtwOAi4VInaPy3/saOpKXitOQjg3JSY6s?=
 =?us-ascii?Q?yh8N/beGFIdeGw/ma0SvqpGCAq3dJSXAF8UExgAay7e3udsWtI4QLZeiZKRM?=
 =?us-ascii?Q?Cu/TT/bQY6MMpHxehewUQDD54cfs2VxDLgiiP00xV4kmTgVzmUbns/1rQkiW?=
 =?us-ascii?Q?5c75fXWTRI2Ke6yPiF1bNAXzn6VLftSwgaLmW+76VjkRdciApMUUbVweR0h7?=
 =?us-ascii?Q?H05mR4ufi2cDuqD1hJsR20SNiQBKxGIyPFhmbDhWyVwdKrpB2pDCy1m2CriH?=
 =?us-ascii?Q?KAPUVvjh56DhzAjj7reG48ClI+uyETud+cDmHbZ3dX6Qy9fw+LsDUl4IQ4Ht?=
 =?us-ascii?Q?ar3VoPymKIXxkBy5b748zeiyWwRlpT7Fs4epam7lZtQeQVG3aLWFG+pvT0Jo?=
 =?us-ascii?Q?eRt4ZjCxM1XyVPxSKFfe78BugnnkeuvahZnn91brOrL4RxVjgooQonQgwyXn?=
 =?us-ascii?Q?OV55iQDOONIt4l9zn390AwBgqHIy7tOVqnDNsMY9PqhXkxB4pOCKUauz6jYw?=
 =?us-ascii?Q?U9Tfo0NjAdELEh2ZvGEgDjVIu/HcdXCU/VOlkpxX0gtZGBBWwq0Fpep6dbct?=
 =?us-ascii?Q?NQHYhUM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737e4341-7dac-48cd-82cf-08d921093720
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 12:16:11.1551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uc6H+3IxtC+UN+wx3P2yWz1ULJz4esfEJf171mvxjKdazr7efCd0MiVqYNyicE4jvtMtSxdRVki6lZAqzUp1Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

s/Uuse/use

-----Original Message-----
From: Das, Nirmoy <Nirmoy.Das@amd.com> 
Sent: Thursday, May 27, 2021 2:15 PM
To: Wentland, Harry <Harry.Wentland@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/1] drm/amd/display: WARN_ON cleanups

Uuse WARN_ON() inside if-condition when possible.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f2ed51484980..736eb537a8e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -315,8 +315,7 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
 	struct drm_crtc *crtc;
 	struct amdgpu_crtc *amdgpu_crtc;
 
-	if (otg_inst == -1) {
-		WARN_ON(1);
+	if (WARN_ON(otg_inst == -1)) {
 		return adev->mode_info.crtcs[0];
 	}
 
@@ -397,8 +396,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	e = amdgpu_crtc->event;
 	amdgpu_crtc->event = NULL;
 
-	if (!e)
-		WARN_ON(1);
+	WARN_ON(!e);
 
 	vrr_active = amdgpu_dm_vrr_active_irq(amdgpu_crtc);
 
@@ -6698,9 +6696,8 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 
 	dm_update_crtc_active_planes(crtc, crtc_state);
 
-	if (unlikely(!dm_crtc_state->stream &&
-		     modeset_required(crtc_state, NULL, dm_crtc_state->stream))) {
-		WARN_ON(1);
+	if (WARN_ON(unlikely(!dm_crtc_state->stream &&
+		     modeset_required(crtc_state, NULL, dm_crtc_state->stream)))) {
 		return ret;
 	}
 
-- 
2.31.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
