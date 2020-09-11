Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF59DC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F05B206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VnRaZzP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F05B206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87AD6EAA8;
	Fri, 11 Sep 2020 16:28:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1ED6EAA8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 16:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR37T8s/ECi5G2FAGGS40SE4o7Fvy+Gb5Q0u69NoJVNQjZ3umEwSLMCnBKMCqpswg4KRoYreFBxehenpOtv3i/ny1K3NQbB2pUOvtfEQ6GK5FR0CgWXQHDEgr1+U+DdlKXOG3R4U1LAm1m2583iQzQPxTWSKGE7vWV3ILrRoXdhWMVZPayOaSuOg4HkqkZ3o9a9l/KR8cMTk3w0d9mejJetdVlK8cq/pFrGs0INWU5TIXbfL+M83xa7w4eTpQZP5jJyfdPAdsBqjz61NJPJLfVrSOScQaJzbG9qT2zCwgcyjb+fudq+kRGE/Zamu37GoVVjeggZfvXBTKii4jwOeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18biSCUNeVmRy8XnpUowFotpaMW0Ae9izBkG0AulLGQ=;
 b=kFwXKlcj+7Ko7ok6MXdzMttqs2NvP/pC5lJYL1IJeujDszodMmR9Q5GGB/2mhmSMFyIek094N4+4krOztge1FpEfWiNifEdQuj/vKLwiekcGODfuIZv3CC5gtPL4G9mdWt1USfcKW4Ae2xfLAVEhUBonk2LBec8pyk7p+JOsdk89GJK3U3DTdun4NzWe23vrrY7R/lChlAunI9NIOMqJYLClpzuQfBFVd+xZ0MlSuDcNRgKY/0lc6Ua2ql8Y67bDWJulSj+XijwIpdsD1v5EgikswoOzy46rI+noCXMn6UUexQLTjpRgpcX67AMRfxr/iNciWrU9OTmfz2w4tKFvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18biSCUNeVmRy8XnpUowFotpaMW0Ae9izBkG0AulLGQ=;
 b=VnRaZzP+GN6KHqh7OFcspiWnWwnKywJx9WkLhvg49ZigUcOffhjyJCR3kHazTwoSWkDJQFYqLsb90YbuTqrKYS0ZRmE23LQq77nPZxEk6J28mhVBzt/nRHFMgenODf9mDhJMz2q1UrWKmHbqjikyB/wGpK2SQgpZC75gb4kfTv0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 by BYAPR12MB2951.namprd12.prod.outlook.com (2603:10b6:a03:138::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.19; Fri, 11 Sep
 2020 16:28:44 +0000
Received: from BY5PR12MB4082.namprd12.prod.outlook.com
 ([fe80::4144:308:1db8:fea2]) by BY5PR12MB4082.namprd12.prod.outlook.com
 ([fe80::4144:308:1db8:fea2%7]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 16:28:44 +0000
Message-ID: <1c62cb119060915a156222f97e710ac175875d06.camel@amd.com>
Subject: Re: [PATCH 2/3] drm/amd/display: Refactor to prevent crtc state
 access in DM IRQ handler
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 11 Sep 2020 12:28:34 -0400
In-Reply-To: <41e2f4c8-1b9c-247a-b239-36d5ef601092@amd.com>
References: <20200909142854.105032-1-aurabindo.pillai@amd.com>
 <20200909142854.105032-3-aurabindo.pillai@amd.com>
 <41e2f4c8-1b9c-247a-b239-36d5ef601092@amd.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
X-ClientProxiedBy: BN6PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:405:75::14) To BY5PR12MB4082.namprd12.prod.outlook.com
 (2603:10b6:a03:212::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.214] (165.204.84.11) by
 BN6PR17CA0025.namprd17.prod.outlook.com (2603:10b6:405:75::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 16:28:43 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 990a7f1d-daa1-49fb-ea09-08d8566fc044
X-MS-TrafficTypeDiagnostic: BYAPR12MB2951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29513DAA74F52CBA22229BE08B240@BYAPR12MB2951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONWuxW2XVdx7L3ISes1KFhespItPBW2bZugPW6X3cNnmipzisD8Df+j9fn/g+PNOjPAAV/2LQQr5nE+iDkwDLjJsAd9SFKiWXRXO2LSFBsmgMUvK4k/1yxGx5D6qO4HO1obw0FhGW6hu5QP51zBrgLKZNxpEanQTEnuNtyiYrvSZWYKI+z3H1Ecc9DojfO7PxEqFzNG5A6H6kmOwE/dk+GI7nkVlgubGwIDLdlJqEoTpwIlu39wsRRsHoWqGPic8I1SUb64XlfiwXDnf/As8If0/W9RnKy0L50jKDCNCVVPtGNF2ThYHmzHvMn8M8PMyyQY0y47j3jE3R9qxv1vcSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(36756003)(26005)(44832011)(6486002)(52116002)(33964004)(6666004)(30864003)(956004)(86362001)(53546011)(2906002)(8676002)(2616005)(478600001)(16526019)(21480400003)(316002)(83380400001)(66476007)(66946007)(8936002)(16576012)(5660300002)(186003)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sHXmVOJEczuj1ZXFehF13rCfQCCdcjRxf3W4mkJLJViNCn0ZkM/VfM6mEBbpSiEUG//UTEeP49MAAhnJF67mIiy+mfCK4Tkjabz1VK9UXYLBNUEwP2897TBicU9j7561DqGgXKu98Fr1/48PpCYSlNFrZ6z5HsOwJk6pT5tH2EtkJizm7Gde+WP5fOUEL8sBpaZIGHJPgygI6ODpWX0qb485eXpZk3IxFS2rZkLVLn7pSfG7bRLHdIIVQZWzo05pmKbZjAfs2mN9XHJ07MURhKmbZqshFZExlkU1b16H1jCMuytWMG+aJCGBkDmywRq+Q2SBwIUji+jNA5lKSEhgCC6Wyy7TtWml3YUraXYnRziL2OcjhTjnDL7KEleUB7Ssx/R6uz723Sn1cl1kcZQu8Q8tDotNhT6dxpXTkWSJFXt6OyVfps5HFWIj1pdKBh5fqTzbxp12qjDJtTi7A9vQf9NSV4Fenkw7cQN7KVDi+jv5P5SxMLWbGhIkYf8hLMSndfav2hkXtm93wLV61tjXXSctJlAtKjy/3vucKHzzG4Ilc4rmO+Ta/LL6lGTYPCApLagySTZ17sMpqlIQ9h3/0fl53d4YOK4NUIo+YUNb8tH6uBUNZ14UM7t0pxqSAwYikeW1CSkNmJq6LP+8gmSKnA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990a7f1d-daa1-49fb-ea09-08d8566fc044
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 16:28:44.4735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cqs5UozXyx/9uBllEdOz6x4oSY4Y1XfMSx6Ttz7u/9RKAX0xfEfydZ19MGMFmy/oCO5WmFu1ruiavqQpQiaDdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2951
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
Content-Type: multipart/mixed; boundary="===============1707366986=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1707366986==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-AOTAW10BH3KcxB1HBJzo"

--=-AOTAW10BH3KcxB1HBJzo
Content-Type: multipart/alternative; boundary="=-SkXLVuqWHD+24nbeJcqM"


--=-SkXLVuqWHD+24nbeJcqM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-09 at 11:00 -0400, Kazlauskas, Nicholas wrote:
> On 2020-09-09 10:28 a.m., Aurabindo Pillai wrote:
> > [Why&How]Currently commit_tail holds global locks and wait for
> > dependencies which isagainst the DRM API contracts. Inorder to fix
> > this, IRQ handler should be ableto run without having to access
> > crtc state. Required parameters are copied overso that they can be
> > directly accessed from the interrupt handler
> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > ---  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 115
> > ++++++++++--------  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > |   1 -  .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   4 +  3
> > files changed, 68 insertions(+), 52 deletions(-)
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.cindex
> > 40814cdd8c92..0603436a3313 100644---
> > a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c+++
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c@@ -192,17
> > +192,14 @@ static u32 dm_vblank_get_counter(struct amdgpu_device
> > *adev, int crtc)  		return 0;  	else {  		str
> > uct amdgpu_crtc *acrtc =3D adev->mode_info.crtcs[crtc];-	=09
> > struct dm_crtc_state *acrtc_state =3D to_dm_crtc_state(-	=09
> > 		acrtc->base.state);  --		if (acrtc_state-
> > >stream =3D=3D NULL) {+		if (acrtc->dm_irq_params.stream =3D=3D
> > NULL) {  			DRM_ERROR("dc_stream_state is NULL for
> > crtc '%d'!\n",  				  crtc);  		=09
> > return 0;  		}  -		return
> > dc_stream_get_vblank_counter(acrtc_state->stream);+		return
> > dc_stream_get_vblank_counter(acrtc->dm_irq_params.stream);  =09
> > }  }  @@ -215,10 +212,8 @@ static int dm_crtc_get_scanoutpos(struct
> > amdgpu_device *adev, int crtc,  		return -EINVAL;  	els
> > e {  		struct amdgpu_crtc *acrtc =3D adev-
> > >mode_info.crtcs[crtc];-		struct dm_crtc_state
> > *acrtc_state =3D to_dm_crtc_state(-				=09
> > 	acrtc->base.state);  -		if (acrtc_state->stream
> > =3D=3D  NULL) {+		if (acrtc->dm_irq_params.stream
> > =3D=3D  NULL) {  			DRM_ERROR("dc_stream_state is
> > NULL for crtc '%d'!\n",  				  crtc);  	=09
> > 	return 0;@@ -228,7 +223,7 @@ static int
> > dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,  =09
> > 	 * TODO rework base driver to use values directly.  	=09
> >  * for now parse it back into reg-format  		 */-	=09
> > dc_stream_get_scanoutpos(acrtc_state->stream,+		dc_stre
> > am_get_scanoutpos(acrtc->dm_irq_params.stream,  		=09
> > 		 &v_blank_start,  					 &v
> > _blank_end,  					 &h_position,@@
> > -287,6 +282,14 @@ get_crtc_by_otg_inst(struct amdgpu_device
> > *adev,  	return NULL;  }  +static inline bool
> > amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc)+{+	return
> > acrtc->dm_irq_params.freesync_config.state =3D=3D+		      =20
> > VRR_STATE_ACTIVE_VARIABLE ||+	       acrtc-
> > >dm_irq_params.freesync_config.state =3D=3D+		       VRR_STAT
> > E_ACTIVE_FIXED;+}+  static inline bool amdgpu_dm_vrr_active(struct
> > dm_crtc_state *dm_state)  {  	return dm_state-
> > >freesync_config.state =3D=3D VRR_STATE_ACTIVE_VARIABLE ||@@ -307,7
> > +310,6 @@ static void dm_pflip_high_irq(void *interrupt_params)  =09
> > struct amdgpu_device *adev =3D irq_params->adev;  	unsigned long
> > flags;  	struct drm_pending_vblank_event *e;-	struct
> > dm_crtc_state *acrtc_state;  	uint32_t vpos, hpos,
> > v_blank_start, v_blank_end;  	bool vrr_active;  @@ -339,12
> > +341,11 @@ static void dm_pflip_high_irq(void *interrupt_params)  =09
> > if (!e)  		WARN_ON(1);  -	acrtc_state =3D
> > to_dm_crtc_state(amdgpu_crtc->base.state);-	vrr_active =3D
> > amdgpu_dm_vrr_active(acrtc_state);+	vrr_active =3D
> > amdgpu_dm_vrr_active_irq(amdgpu_crtc);    	/* Fixed refresh rate,
> > or VRR scanout position outside front-porch? */  	if (!vrr_active
> > ||-	    !dc_stream_get_scanoutpos(acrtc_state->stream,
> > &v_blank_start,+	    !dc_stream_get_scanoutpos(amdgpu_crtc-
> > >dm_irq_params.stream, &v_blank_start,  			=09
> >       &v_blank_end, &hpos, &vpos) ||  	    (vpos <
> > v_blank_start)) {  		/* Update to correct count and vblank
> > timestamp if racing with@@ -405,17 +406,17 @@ static void
> > dm_vupdate_high_irq(void *interrupt_params)  	struct
> > common_irq_params *irq_params =3D interrupt_params;  	struct
> > amdgpu_device *adev =3D irq_params->adev;  	struct amdgpu_crtc
> > *acrtc;-	struct dm_crtc_state *acrtc_state;  	unsigned
> > long flags;+	int vrr_active;    	acrtc =3D
> > get_crtc_by_otg_inst(adev, irq_params->irq_src -
> > IRQ_TYPE_VUPDATE);    	if (acrtc) {-		acrtc_state
> > =3D to_dm_crtc_state(acrtc->base.state);+		vrr_active =3D
> > amdgpu_dm_vrr_active_irq(acrtc);    		DRM_DEBUG_VBL("
> > crtc:%d, vupdate-vrr:%d\n",  			      acrtc-
> > >crtc_id,-			      amdgpu_dm_vrr_active(acrtc_state)
> > );+			      vrr_active);    		/* Core
> > vblank handling is done here after end of front-porch in  	=09
> >  * vrr mode, as vblank timestamping will give valid results@@
> > -423,22 +424,22 @@ static void dm_vupdate_high_irq(void
> > *interrupt_params)  		 * page-flip completion events
> > that have been queued to us  		 * if a pageflip
> > happened inside front-porch.  		 */-		if
> > (amdgpu_dm_vrr_active(acrtc_state)) {+		if (vrr_active)
> > {  			drm_crtc_handle_vblank(&acrtc->base);    	=09
> > 	/* BTR processing for pre-DCE12 ASICs */-			if
> > (acrtc_state->stream &&+			if (acrtc-
> > >dm_irq_params.stream &&  			    adev->family <
> > AMDGPU_FAMILY_AI) {  				spin_lock_irqsa
> > ve(&adev_to_drm(adev)->event_lock, flags);  		=09
> > 	mod_freesync_handle_v_update(  				  =20
> >  adev->dm.freesync_module,-				    acrtc_state
> > ->stream,-				    &acrtc_state->vrr_params);+
> > 				    acrtc->dm_irq_params.stream,+=09
> > 			    &acrtc->dm_irq_params.vrr_params);    	=09
> > 		dc_stream_adjust_vmin_vmax(  			=09
> >     adev->dm.dc,-				    acrtc_state-
> > >stream,-				    &acrtc_state-
> > >vrr_params.adjust);+				    acrtc-
> > >dm_irq_params.stream,+				    &acrtc-
> > >dm_irq_params.vrr_params.adjust);  			=09
> > spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);  =09
> > 		}  		}@@ -457,18 +458,17 @@ static void
> > dm_crtc_high_irq(void *interrupt_params)  	struct
> > common_irq_params *irq_params =3D interrupt_params;  	struct
> > amdgpu_device *adev =3D irq_params->adev;  	struct amdgpu_crtc
> > *acrtc;-	struct dm_crtc_state *acrtc_state;  	unsigned
> > long flags;+	int vrr_active;    	acrtc =3D
> > get_crtc_by_otg_inst(adev, irq_params->irq_src -
> > IRQ_TYPE_VBLANK);  	if (!acrtc)  		return;  -	acr
> > tc_state =3D to_dm_crtc_state(acrtc->base.state);+	vrr_active =3D
> > amdgpu_dm_vrr_active_irq(acrtc);    	DRM_DEBUG_VBL("crtc:%d,
> > vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,-		=09
> >  amdgpu_dm_vrr_active(acrtc_state),-			 acrtc_
> > state->active_planes);+		      vrr_active, acrtc-
> > >dm_irq_params.active_planes);    	/**  	 * Core vblank
> > handling at start of front-porch is only possible@@ -476,7 +476,7
> > @@ static void dm_crtc_high_irq(void *interrupt_params)  	 *
> > valid results while done in front-porch. Otherwise defer it  =09
> >  * to dm_vupdate_high_irq after end of front-porch.  	 */-=09
> > if (!amdgpu_dm_vrr_active(acrtc_state))+	if (!vrr_active)  	=09
> > drm_crtc_handle_vblank(&acrtc->base);    	/**@@ -491,14 +491,16
> > @@ static void dm_crtc_high_irq(void *interrupt_params)    	spin_lo
> > ck_irqsave(&adev_to_drm(adev)->event_lock, flags);  -	if
> > (acrtc_state->stream && acrtc_state->vrr_params.supported &&-=09
> >     acrtc_state->freesync_config.state =3D=3D
> > VRR_STATE_ACTIVE_VARIABLE) {+	if (acrtc->dm_irq_params.stream=20
> > &&+	    acrtc->dm_irq_params.vrr_params.supported &&+	    acrtc-
> > >dm_irq_params.freesync_config.state =3D=3D+		    VRR_STATE_A
> > CTIVE_VARIABLE) {  		mod_freesync_handle_v_update(adev-
> > >dm.freesync_module,-					     ac
> > rtc_state->stream,-					     &acrtc_sta
> > te->vrr_params);+					     acrtc-
> > >dm_irq_params.stream,+					     &a
> > crtc->dm_irq_params.vrr_params);  -		dc_stream_adjust_vmin_v
> > max(adev->dm.dc, acrtc_state->stream,-			=09
> > 	   &acrtc_state->vrr_params.adjust);+		dc_stream_a
> > djust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_params.stream,+	=09
> > 			   &acrtc->dm_irq_params.vrr_params.adjust);  =09
> > }    	/*@@ -513,7 +515,7 @@ static void dm_crtc_high_irq(void
> > *interrupt_params)  	 */  	if (adev->family >=3D
> > AMDGPU_FAMILY_RV &&  	    acrtc->pflip_status =3D=3D
> > AMDGPU_FLIP_SUBMITTED &&-	    acrtc_state->active_planes =3D=3D 0) {+
> > 	    acrtc->dm_irq_params.active_planes =3D=3D 0) {  	=09
> > if (acrtc->event) {  			drm_crtc_send_vblank_ev
> > ent(&acrtc->base, acrtc->event);  			acrtc->event =3D
> > NULL;@@ -4845,7 +4847,6 @@ dm_crtc_duplicate_state(struct drm_crtc
> > *crtc)  	}    	state->active_planes =3D cur->active_planes;-
> > 	state->vrr_params =3D cur->vrr_params;  	state-
> > >vrr_infopacket =3D cur->vrr_infopacket;  	state->abm_level =3D cur-
> > >abm_level;  	state->vrr_supported =3D cur->vrr_supported;@@
> > -6913,6 +6914,7 @@ static void update_freesync_state_on_stream(  =09
> > struct mod_vrr_params vrr_params;  	struct dc_info_packet
> > vrr_infopacket =3D {0};  	struct amdgpu_device *adev =3D dm->adev;+
> > 	struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(new_crtc_state-
> > >base.crtc);  	unsigned long flags;    	if (!new_stream)@@
> > -6927,7 +6929,7 @@ static void update_freesync_state_on_stream(  =09
> > 	return;    	spin_lock_irqsave(&adev_to_drm(adev)->event_lock,
> > flags);-	vrr_params =3D new_crtc_state-
> > >vrr_params;+        vrr_params =3D acrtc-
> > >dm_irq_params.vrr_params;    	if (surface) {  		mod
> > _freesync_handle_preflip(@@ -6958,7 +6960,7 @@ static void
> > update_freesync_state_on_stream(  		&vrr_infopacket);    =09
> > new_crtc_state->freesync_timing_changed |=3D-		(memcmp(&new_cr
> > tc_state->vrr_params.adjust,+		(memcmp(&acrtc-
> > >dm_irq_params.vrr_params.adjust,  			&vrr_params.adj
> > ust,  			sizeof(vrr_params.adjust)) !=3D 0);  @@
> > -6967,10 +6969,10 @@ static void update_freesync_state_on_stream(  =09
> > 		&vrr_infopacket,  			sizeof(vrr_infopack
> > et)) !=3D 0);  -	new_crtc_state->vrr_params =3D vrr_params;+	acr
> > tc->dm_irq_params.vrr_params =3D vrr_params;  	new_crtc_state-
> > >vrr_infopacket =3D vrr_infopacket;  -	new_stream->adjust =3D
> > new_crtc_state->vrr_params.adjust;+	new_stream->adjust =3D acrtc-
> > >dm_irq_params.vrr_params.adjust;  	new_stream->vrr_infopacket =3D
> > vrr_infopacket;    	if (new_crtc_state-
> > >freesync_vrr_info_changed)@@ -6982,7 +6984,7 @@ static void
> > update_freesync_state_on_stream(  	spin_unlock_irqrestore(&adev_to
> > _drm(adev)->event_lock, flags);  }  -static void
> > pre_update_freesync_state_on_stream(+static void
> > update_stream_irq_parameters(  	struct amdgpu_display_manager
> > *dm,  	struct dm_crtc_state *new_crtc_state)  {@@ -6990,6
> > +6992,7 @@ static void pre_update_freesync_state_on_stream(  =09
> > struct mod_vrr_params vrr_params;  	struct mod_freesync_config
> > config =3D new_crtc_state->freesync_config;  	struct amdgpu_device
> > *adev =3D dm->adev;+	struct amdgpu_crtc *acrtc =3D
> > to_amdgpu_crtc(new_crtc_state->base.crtc);  	unsigned long
> > flags;    	if (!new_stream)@@ -7003,7 +7006,7 @@ static void
> > pre_update_freesync_state_on_stream(  		return;    	spi
> > n_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);-	vrr_par
> > ams =3D new_crtc_state->vrr_params;+        vrr_params =3D acrtc-
> > >dm_irq_params.vrr_params;    	if (new_crtc_state-
> > >vrr_supported &&  	    config.min_refresh_in_uhz &&@@ -7020,11
> > +7023,14 @@ static void pre_update_freesync_state_on_stream(  =09
> > 			      &config, &vrr_params);    	new_crtc_st
> > ate->freesync_timing_changed |=3D-		(memcmp(&new_crtc_state
> > ->vrr_params.adjust,-			&vrr_params.adjust,-=09
> > 		sizeof(vrr_params.adjust)) !=3D 0);+		(memcmp(&ac
> > rtc->dm_irq_params.vrr_params.adjust,+			&vrr_pa
> > rams.adjust, sizeof(vrr_params.adjust)) !=3D 0);  -	new_crtc_state-
> > >vrr_params =3D vrr_params;+	new_crtc_state->freesync_config =3D
> > config;+	/* Copy state for access from DM IRQ handler */+	acr
> > tc->dm_irq_params.freesync_config =3D config;+	acrtc-
> > >dm_irq_params.active_planes =3D new_crtc_state->active_planes;+=09
> > acrtc->dm_irq_params.vrr_params =3D vrr_params;  	spin_unlock_irq
> > restore(&adev_to_drm(adev)->event_lock, flags);  }  @@ -7332,7
> > +7338,7 @@ static void amdgpu_dm_commit_planes(struct
> > drm_atomic_state *state,  			spin_lock_irqsave(&pcrt
> > c->dev->event_lock, flags);  			dc_stream_adjus
> > t_vmin_vmax(  				dm->dc, acrtc_state-
> > >stream,-				&acrtc_state-
> > >vrr_params.adjust);+				&acrtc_attach-
> > >dm_irq_params.vrr_params.adjust);  			spin_un
> > lock_irqrestore(&pcrtc->dev->event_lock, flags);  		}  	=09
> > mutex_lock(&dm->dc_lock);@@ -7545,6 +7551,7 @@ static void
> > amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)  =09
> > struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;  =09
> > int crtc_disable_count =3D 0;  	bool mode_set_reset_required =3D
> > false;+        struct amdgpu_crtc *acrtc;    	drm_atomic_help
> > er_update_legacy_modeset_state(dev, state);  @@ -7651,9 +7658,12 @@
> > static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state
> > *state)  			const struct dc_stream_status *status
> > =3D  					dc_stream_get_status(dm_new_crt
> > c_state->stream);  -			if (!status)+	=09
> > 	if (!status) {  				status =3D
> > dc_stream_get_status_from_state(dc_state,  			=09
> > 					 dm_new_crtc_state->stream);+=09
> > 			dc_stream_retain(dm_new_crtc_state->stream);
>=20
> You're missing a release on this reference (dc_stream_release) so
> this will cause a memory leak.
> > +				acrtc->dm_irq_params.stream =3D
> > dm_new_crtc_state->stream;+			}    		=09
> > if (!status)  				DC_ERR("got no status
> > for stream %p on acrtc%p\n", dm_new_crtc_state->stream, acrtc);@@
> > -7780,8 +7790,8 @@ static void amdgpu_dm_atomic_commit_tail(struct
> > drm_atomic_state *state)  		dm_new_crtc_state =3D
> > to_dm_crtc_state(new_crtc_state);  		dm_old_crtc_state =3D
> > to_dm_crtc_state(old_crtc_state);  -		/* Update
> > freesync active state. */-		pre_update_freesync_state_on_st
> > ream(dm, dm_new_crtc_state);+		/* For freesync config
> > update on crtc state and params for irq */+		update_stream_i
> > rq_parameters(dm, dm_new_crtc_state);    		/* Handle vrr
> > on->off / off->on transitions */  		amdgpu_dm_handle_vrr_tr
> > ansition(dm_old_crtc_state,@@ -7797,10 +7807,15 @@ static void
> > amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)  =09
> > for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> > new_crtc_state, i) {  		struct amdgpu_crtc *acrtc =3D
> > to_amdgpu_crtc(crtc);  +		dm_new_crtc_state =3D
> > to_dm_crtc_state(new_crtc_state);+  		if
> > (new_crtc_state->active &&  		    (!old_crtc_state-
> > >active ||  		     drm_atomic_crtc_needs_modeset(new_
> > crtc_state))) {+			dc_stream_retain(dm_new_crtc_st
> > ate->stream);
>=20
> This retain is also missing a dc_stream_release.
> Regards,Nicholas Kazlauskas
>=20

Hi Nick,
Thanks for the review, I've posted V2.

--=-SkXLVuqWHD+24nbeJcqM
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr"><head></head><body style=3D"text-align: left; direction: =
ltr; word-wrap: break-word; -webkit-nbsp-mode: space; line-break: after-whi=
te-space;" bgcolor=3D"#ffffff" text=3D"#333333" link=3D"#2679db" vlink=3D"#=
202020"><div>On Wed, 2020-09-09 at 11:00 -0400, Kazlauskas, Nicholas wrote:=
</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px=
 #729fcf solid;padding-left:1ex"><pre>On 2020-09-09 10:28 a.m., Aurabindo P=
illai wrote:</pre><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; bor=
der-left:2px #729fcf solid;padding-left:1ex"><pre>[Why&amp;How]</pre><pre>C=
urrently commit_tail holds global locks and wait for dependencies which is<=
/pre><pre>against the DRM API contracts. Inorder to fix this, IRQ handler s=
hould be able</pre><pre>to run without having to access crtc state. Require=
d parameters are copied over</pre><pre>so that they can be directly accesse=
d from the interrupt handler</pre><pre><br></pre><pre>Signed-off-by: Aurabi=
ndo Pillai &lt;</pre><a href=3D"mailto:aurabindo.pillai@amd.com"><pre>aurab=
indo.pillai@amd.com</pre></a><pre>&gt;</pre><pre>---</pre><pre>  .../gpu/dr=
m/amd/display/amdgpu_dm/amdgpu_dm.c | 115 ++++++++++--------</pre><pre>  ..=
./gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 -</pre><pre>  .../display=
/amdgpu_dm/amdgpu_dm_irq_params.h  |   4 +</pre><pre>  3 files changed, 68 =
insertions(+), 52 deletions(-)</pre><pre><br></pre><pre>diff --git a/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/a=
mdgpu_dm/amdgpu_dm.c</pre><pre>index 40814cdd8c92..0603436a3313 100644</pre=
><pre>--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</pre><pre>+++=
 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</pre><pre>@@ -192,17 +=
192,14 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int =
crtc)</pre><pre>  		return 0;</pre><pre>  	else {</pre><pre>  		struct amdg=
pu_crtc *acrtc =3D adev-&gt;mode_info.crtcs[crtc];</pre><pre>-		struct dm_c=
rtc_state *acrtc_state =3D to_dm_crtc_state(</pre><pre>-				acrtc-&gt;base.=
state);</pre><pre>  </pre><pre>-</pre><pre>-		if (acrtc_state-&gt;stream =
=3D=3D NULL) {</pre><pre>+		if (acrtc-&gt;dm_irq_params.stream =3D=3D NULL)=
 {</pre><pre>  			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",</pr=
e><pre>  				  crtc);</pre><pre>  			return 0;</pre><pre>  		}</pre><pre>  =
</pre><pre>-		return dc_stream_get_vblank_counter(acrtc_state-&gt;stream);<=
/pre><pre>+		return dc_stream_get_vblank_counter(acrtc-&gt;dm_irq_params.st=
ream);</pre><pre>  	}</pre><pre>  }</pre><pre>  </pre><pre>@@ -215,10 +212,=
8 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc=
,</pre><pre>  		return -EINVAL;</pre><pre>  	else {</pre><pre>  		struct am=
dgpu_crtc *acrtc =3D adev-&gt;mode_info.crtcs[crtc];</pre><pre>-		struct dm=
_crtc_state *acrtc_state =3D to_dm_crtc_state(</pre><pre>-						acrtc-&gt;b=
ase.state);</pre><pre>  </pre><pre>-		if (acrtc_state-&gt;stream =3D=3D  NU=
LL) {</pre><pre>+		if (acrtc-&gt;dm_irq_params.stream =3D=3D  NULL) {</pre>=
<pre>  			DRM_ERROR("dc_stream_state is NULL for crtc '%d'!\n",</pre><pre> =
 				  crtc);</pre><pre>  			return 0;</pre><pre>@@ -228,7 +223,7 @@ static=
 int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,</pre><pre=
>  		 * TODO rework base driver to use values directly.</pre><pre>  		 * fo=
r now parse it back into reg-format</pre><pre>  		 */</pre><pre>-		dc_strea=
m_get_scanoutpos(acrtc_state-&gt;stream,</pre><pre>+		dc_stream_get_scanout=
pos(acrtc-&gt;dm_irq_params.stream,</pre><pre>  					 &amp;v_blank_start,</=
pre><pre>  					 &amp;v_blank_end,</pre><pre>  					 &amp;h_position,</pre>=
<pre>@@ -287,6 +282,14 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,<=
/pre><pre>  	return NULL;</pre><pre>  }</pre><pre>  </pre><pre>+static inli=
ne bool amdgpu_dm_vrr_active_irq(struct amdgpu_crtc *acrtc)</pre><pre>+{</p=
re><pre>+	return acrtc-&gt;dm_irq_params.freesync_config.state =3D=3D</pre>=
<pre>+		       VRR_STATE_ACTIVE_VARIABLE ||</pre><pre>+	       acrtc-&gt;dm=
_irq_params.freesync_config.state =3D=3D</pre><pre>+		       VRR_STATE_ACTI=
VE_FIXED;</pre><pre>+}</pre><pre>+</pre><pre>  static inline bool amdgpu_dm=
_vrr_active(struct dm_crtc_state *dm_state)</pre><pre>  {</pre><pre>  	retu=
rn dm_state-&gt;freesync_config.state =3D=3D VRR_STATE_ACTIVE_VARIABLE ||</=
pre><pre>@@ -307,7 +310,6 @@ static void dm_pflip_high_irq(void *interrupt_=
params)</pre><pre>  	struct amdgpu_device *adev =3D irq_params-&gt;adev;</p=
re><pre>  	unsigned long flags;</pre><pre>  	struct drm_pending_vblank_even=
t *e;</pre><pre>-	struct dm_crtc_state *acrtc_state;</pre><pre>  	uint32_t =
vpos, hpos, v_blank_start, v_blank_end;</pre><pre>  	bool vrr_active;</pre>=
<pre>  </pre><pre>@@ -339,12 +341,11 @@ static void dm_pflip_high_irq(void =
*interrupt_params)</pre><pre>  	if (!e)</pre><pre>  		WARN_ON(1);</pre><pre=
>  </pre><pre>-	acrtc_state =3D to_dm_crtc_state(amdgpu_crtc-&gt;base.state=
);</pre><pre>-	vrr_active =3D amdgpu_dm_vrr_active(acrtc_state);</pre><pre>=
+	vrr_active =3D amdgpu_dm_vrr_active_irq(amdgpu_crtc);</pre><pre>  </pre><=
pre>  	/* Fixed refresh rate, or VRR scanout position outside front-porch? =
*/</pre><pre>  	if (!vrr_active ||</pre><pre>-	    !dc_stream_get_scanoutpo=
s(acrtc_state-&gt;stream, &amp;v_blank_start,</pre><pre>+	    !dc_stream_ge=
t_scanoutpos(amdgpu_crtc-&gt;dm_irq_params.stream, &amp;v_blank_start,</pre=
><pre>  				      &amp;v_blank_end, &amp;hpos, &amp;vpos) ||</pre><pre>  	 =
   (vpos &lt; v_blank_start)) {</pre><pre>  		/* Update to correct count an=
d vblank timestamp if racing with</pre><pre>@@ -405,17 +406,17 @@ static vo=
id dm_vupdate_high_irq(void *interrupt_params)</pre><pre>  	struct common_i=
rq_params *irq_params =3D interrupt_params;</pre><pre>  	struct amdgpu_devi=
ce *adev =3D irq_params-&gt;adev;</pre><pre>  	struct amdgpu_crtc *acrtc;</=
pre><pre>-	struct dm_crtc_state *acrtc_state;</pre><pre>  	unsigned long fl=
ags;</pre><pre>+	int vrr_active;</pre><pre>  </pre><pre>  	acrtc =3D get_cr=
tc_by_otg_inst(adev, irq_params-&gt;irq_src - IRQ_TYPE_VUPDATE);</pre><pre>=
  </pre><pre>  	if (acrtc) {</pre><pre>-		acrtc_state =3D to_dm_crtc_state(=
acrtc-&gt;base.state);</pre><pre>+		vrr_active =3D amdgpu_dm_vrr_active_irq=
(acrtc);</pre><pre>  </pre><pre>  		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\=
n",</pre><pre>  			      acrtc-&gt;crtc_id,</pre><pre>-			      amdgpu_dm_v=
rr_active(acrtc_state));</pre><pre>+			      vrr_active);</pre><pre>  </pre=
><pre>  		/* Core vblank handling is done here after end of front-porch in<=
/pre><pre>  		 * vrr mode, as vblank timestamping will give valid results</=
pre><pre>@@ -423,22 +424,22 @@ static void dm_vupdate_high_irq(void *interr=
upt_params)</pre><pre>  		 * page-flip completion events that have been que=
ued to us</pre><pre>  		 * if a pageflip happened inside front-porch.</pre>=
<pre>  		 */</pre><pre>-		if (amdgpu_dm_vrr_active(acrtc_state)) {</pre><pr=
e>+		if (vrr_active) {</pre><pre>  			drm_crtc_handle_vblank(&amp;acrtc-&gt=
;base);</pre><pre>  </pre><pre>  			/* BTR processing for pre-DCE12 ASICs *=
/</pre><pre>-			if (acrtc_state-&gt;stream &amp;&amp;</pre><pre>+			if (acr=
tc-&gt;dm_irq_params.stream &amp;&amp;</pre><pre>  			    adev-&gt;family &=
lt; AMDGPU_FAMILY_AI) {</pre><pre>  				spin_lock_irqsave(&amp;adev_to_drm(=
adev)-&gt;event_lock, flags);</pre><pre>  				mod_freesync_handle_v_update(=
</pre><pre>  				    adev-&gt;dm.freesync_module,</pre><pre>-				    acrtc_=
state-&gt;stream,</pre><pre>-				    &amp;acrtc_state-&gt;vrr_params);</pre=
><pre>+				    acrtc-&gt;dm_irq_params.stream,</pre><pre>+				    &amp;acrt=
c-&gt;dm_irq_params.vrr_params);</pre><pre>  </pre><pre>  				dc_stream_adj=
ust_vmin_vmax(</pre><pre>  				    adev-&gt;dm.dc,</pre><pre>-				    acrtc=
_state-&gt;stream,</pre><pre>-				    &amp;acrtc_state-&gt;vrr_params.adjus=
t);</pre><pre>+				    acrtc-&gt;dm_irq_params.stream,</pre><pre>+				    &=
amp;acrtc-&gt;dm_irq_params.vrr_params.adjust);</pre><pre>  				spin_unlock=
_irqrestore(&amp;adev_to_drm(adev)-&gt;event_lock, flags);</pre><pre>  			}=
</pre><pre>  		}</pre><pre>@@ -457,18 +458,17 @@ static void dm_crtc_high_i=
rq(void *interrupt_params)</pre><pre>  	struct common_irq_params *irq_param=
s =3D interrupt_params;</pre><pre>  	struct amdgpu_device *adev =3D irq_par=
ams-&gt;adev;</pre><pre>  	struct amdgpu_crtc *acrtc;</pre><pre>-	struct dm=
_crtc_state *acrtc_state;</pre><pre>  	unsigned long flags;</pre><pre>+	int=
 vrr_active;</pre><pre>  </pre><pre>  	acrtc =3D get_crtc_by_otg_inst(adev,=
 irq_params-&gt;irq_src - IRQ_TYPE_VBLANK);</pre><pre>  	if (!acrtc)</pre><=
pre>  		return;</pre><pre>  </pre><pre>-	acrtc_state =3D to_dm_crtc_state(a=
crtc-&gt;base.state);</pre><pre>+	vrr_active =3D amdgpu_dm_vrr_active_irq(a=
crtc);</pre><pre>  </pre><pre>  	DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d, pl=
anes:%d\n", acrtc-&gt;crtc_id,</pre><pre>-			 amdgpu_dm_vrr_active(acrtc_st=
ate),</pre><pre>-			 acrtc_state-&gt;active_planes);</pre><pre>+		      vrr=
_active, acrtc-&gt;dm_irq_params.active_planes);</pre><pre>  </pre><pre>  	=
/**</pre><pre>  	 * Core vblank handling at start of front-porch is only po=
ssible</pre><pre>@@ -476,7 +476,7 @@ static void dm_crtc_high_irq(void *int=
errupt_params)</pre><pre>  	 * valid results while done in front-porch. Oth=
erwise defer it</pre><pre>  	 * to dm_vupdate_high_irq after end of front-p=
orch.</pre><pre>  	 */</pre><pre>-	if (!amdgpu_dm_vrr_active(acrtc_state))<=
/pre><pre>+	if (!vrr_active)</pre><pre>  		drm_crtc_handle_vblank(&amp;acrt=
c-&gt;base);</pre><pre>  </pre><pre>  	/**</pre><pre>@@ -491,14 +491,16 @@ =
static void dm_crtc_high_irq(void *interrupt_params)</pre><pre>  </pre><pre=
>  	spin_lock_irqsave(&amp;adev_to_drm(adev)-&gt;event_lock, flags);</pre><=
pre>  </pre><pre>-	if (acrtc_state-&gt;stream &amp;&amp; acrtc_state-&gt;vr=
r_params.supported &amp;&amp;</pre><pre>-	    acrtc_state-&gt;freesync_conf=
ig.state =3D=3D VRR_STATE_ACTIVE_VARIABLE) {</pre><pre>+	if (acrtc-&gt;dm_i=
rq_params.stream &amp;&amp;</pre><pre>+	    acrtc-&gt;dm_irq_params.vrr_par=
ams.supported &amp;&amp;</pre><pre>+	    acrtc-&gt;dm_irq_params.freesync_c=
onfig.state =3D=3D</pre><pre>+		    VRR_STATE_ACTIVE_VARIABLE) {</pre><pre>=
  		mod_freesync_handle_v_update(adev-&gt;dm.freesync_module,</pre><pre>-		=
			     acrtc_state-&gt;stream,</pre><pre>-					     &amp;acrtc_state-&gt;v=
rr_params);</pre><pre>+					     acrtc-&gt;dm_irq_params.stream,</pre><pre>=
+					     &amp;acrtc-&gt;dm_irq_params.vrr_params);</pre><pre>  </pre><pre=
>-		dc_stream_adjust_vmin_vmax(adev-&gt;dm.dc, acrtc_state-&gt;stream,</pre=
><pre>-					   &amp;acrtc_state-&gt;vrr_params.adjust);</pre><pre>+		dc_str=
eam_adjust_vmin_vmax(adev-&gt;dm.dc, acrtc-&gt;dm_irq_params.stream,</pre><=
pre>+					   &amp;acrtc-&gt;dm_irq_params.vrr_params.adjust);</pre><pre>  	=
}</pre><pre>  </pre><pre>  	/*</pre><pre>@@ -513,7 +515,7 @@ static void dm=
_crtc_high_irq(void *interrupt_params)</pre><pre>  	 */</pre><pre>  	if (ad=
ev-&gt;family &gt;=3D AMDGPU_FAMILY_RV &amp;&amp;</pre><pre>  	    acrtc-&g=
t;pflip_status =3D=3D AMDGPU_FLIP_SUBMITTED &amp;&amp;</pre><pre>-	    acrt=
c_state-&gt;active_planes =3D=3D 0) {</pre><pre>+	    acrtc-&gt;dm_irq_para=
ms.active_planes =3D=3D 0) {</pre><pre>  		if (acrtc-&gt;event) {</pre><pre=
>  			drm_crtc_send_vblank_event(&amp;acrtc-&gt;base, acrtc-&gt;event);</pr=
e><pre>  			acrtc-&gt;event =3D NULL;</pre><pre>@@ -4845,7 +4847,6 @@ dm_cr=
tc_duplicate_state(struct drm_crtc *crtc)</pre><pre>  	}</pre><pre>  </pre>=
<pre>  	state-&gt;active_planes =3D cur-&gt;active_planes;</pre><pre>-	stat=
e-&gt;vrr_params =3D cur-&gt;vrr_params;</pre><pre>  	state-&gt;vrr_infopac=
ket =3D cur-&gt;vrr_infopacket;</pre><pre>  	state-&gt;abm_level =3D cur-&g=
t;abm_level;</pre><pre>  	state-&gt;vrr_supported =3D cur-&gt;vrr_supported=
;</pre><pre>@@ -6913,6 +6914,7 @@ static void update_freesync_state_on_stre=
am(</pre><pre>  	struct mod_vrr_params vrr_params;</pre><pre>  	struct dc_i=
nfo_packet vrr_infopacket =3D {0};</pre><pre>  	struct amdgpu_device *adev =
=3D dm-&gt;adev;</pre><pre>+	struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(n=
ew_crtc_state-&gt;base.crtc);</pre><pre>  	unsigned long flags;</pre><pre> =
 </pre><pre>  	if (!new_stream)</pre><pre>@@ -6927,7 +6929,7 @@ static void=
 update_freesync_state_on_stream(</pre><pre>  		return;</pre><pre>  </pre><=
pre>  	spin_lock_irqsave(&amp;adev_to_drm(adev)-&gt;event_lock, flags);</pr=
e><pre>-	vrr_params =3D new_crtc_state-&gt;vrr_params;</pre><pre>+        v=
rr_params =3D acrtc-&gt;dm_irq_params.vrr_params;</pre><pre>  </pre><pre>  =
	if (surface) {</pre><pre>  		mod_freesync_handle_preflip(</pre><pre>@@ -69=
58,7 +6960,7 @@ static void update_freesync_state_on_stream(</pre><pre>  		=
&amp;vrr_infopacket);</pre><pre>  </pre><pre>  	new_crtc_state-&gt;freesync=
_timing_changed |=3D</pre><pre>-		(memcmp(&amp;new_crtc_state-&gt;vrr_param=
s.adjust,</pre><pre>+		(memcmp(&amp;acrtc-&gt;dm_irq_params.vrr_params.adju=
st,</pre><pre>  			&amp;vrr_params.adjust,</pre><pre>  			sizeof(vrr_params=
.adjust)) !=3D 0);</pre><pre>  </pre><pre>@@ -6967,10 +6969,10 @@ static vo=
id update_freesync_state_on_stream(</pre><pre>  			&amp;vrr_infopacket,</pr=
e><pre>  			sizeof(vrr_infopacket)) !=3D 0);</pre><pre>  </pre><pre>-	new_c=
rtc_state-&gt;vrr_params =3D vrr_params;</pre><pre>+	acrtc-&gt;dm_irq_param=
s.vrr_params =3D vrr_params;</pre><pre>  	new_crtc_state-&gt;vrr_infopacket=
 =3D vrr_infopacket;</pre><pre>  </pre><pre>-	new_stream-&gt;adjust =3D new=
_crtc_state-&gt;vrr_params.adjust;</pre><pre>+	new_stream-&gt;adjust =3D ac=
rtc-&gt;dm_irq_params.vrr_params.adjust;</pre><pre>  	new_stream-&gt;vrr_in=
fopacket =3D vrr_infopacket;</pre><pre>  </pre><pre>  	if (new_crtc_state-&=
gt;freesync_vrr_info_changed)</pre><pre>@@ -6982,7 +6984,7 @@ static void u=
pdate_freesync_state_on_stream(</pre><pre>  	spin_unlock_irqrestore(&amp;ad=
ev_to_drm(adev)-&gt;event_lock, flags);</pre><pre>  }</pre><pre>  </pre><pr=
e>-static void pre_update_freesync_state_on_stream(</pre><pre>+static void =
update_stream_irq_parameters(</pre><pre>  	struct amdgpu_display_manager *d=
m,</pre><pre>  	struct dm_crtc_state *new_crtc_state)</pre><pre>  {</pre><p=
re>@@ -6990,6 +6992,7 @@ static void pre_update_freesync_state_on_stream(</=
pre><pre>  	struct mod_vrr_params vrr_params;</pre><pre>  	struct mod_frees=
ync_config config =3D new_crtc_state-&gt;freesync_config;</pre><pre>  	stru=
ct amdgpu_device *adev =3D dm-&gt;adev;</pre><pre>+	struct amdgpu_crtc *acr=
tc =3D to_amdgpu_crtc(new_crtc_state-&gt;base.crtc);</pre><pre>  	unsigned =
long flags;</pre><pre>  </pre><pre>  	if (!new_stream)</pre><pre>@@ -7003,7=
 +7006,7 @@ static void pre_update_freesync_state_on_stream(</pre><pre>  		=
return;</pre><pre>  </pre><pre>  	spin_lock_irqsave(&amp;adev_to_drm(adev)-=
&gt;event_lock, flags);</pre><pre>-	vrr_params =3D new_crtc_state-&gt;vrr_p=
arams;</pre><pre>+        vrr_params =3D acrtc-&gt;dm_irq_params.vrr_params=
;</pre><pre>  </pre><pre>  	if (new_crtc_state-&gt;vrr_supported &amp;&amp;=
</pre><pre>  	    config.min_refresh_in_uhz &amp;&amp;</pre><pre>@@ -7020,1=
1 +7023,14 @@ static void pre_update_freesync_state_on_stream(</pre><pre>  =
				      &amp;config, &amp;vrr_params);</pre><pre>  </pre><pre>  	new_crtc=
_state-&gt;freesync_timing_changed |=3D</pre><pre>-		(memcmp(&amp;new_crtc_=
state-&gt;vrr_params.adjust,</pre><pre>-			&amp;vrr_params.adjust,</pre><pr=
e>-			sizeof(vrr_params.adjust)) !=3D 0);</pre><pre>+		(memcmp(&amp;acrtc-&=
gt;dm_irq_params.vrr_params.adjust,</pre><pre>+			&amp;vrr_params.adjust, s=
izeof(vrr_params.adjust)) !=3D 0);</pre><pre>  </pre><pre>-	new_crtc_state-=
&gt;vrr_params =3D vrr_params;</pre><pre>+	new_crtc_state-&gt;freesync_conf=
ig =3D config;</pre><pre>+	/* Copy state for access from DM IRQ handler */<=
/pre><pre>+	acrtc-&gt;dm_irq_params.freesync_config =3D config;</pre><pre>+=
	acrtc-&gt;dm_irq_params.active_planes =3D new_crtc_state-&gt;active_planes=
;</pre><pre>+	acrtc-&gt;dm_irq_params.vrr_params =3D vrr_params;</pre><pre>=
  	spin_unlock_irqrestore(&amp;adev_to_drm(adev)-&gt;event_lock, flags);</p=
re><pre>  }</pre><pre>  </pre><pre>@@ -7332,7 +7338,7 @@ static void amdgpu=
_dm_commit_planes(struct drm_atomic_state *state,</pre><pre>  			spin_lock_=
irqsave(&amp;pcrtc-&gt;dev-&gt;event_lock, flags);</pre><pre>  			dc_stream=
_adjust_vmin_vmax(</pre><pre>  				dm-&gt;dc, acrtc_state-&gt;stream,</pre>=
<pre>-				&amp;acrtc_state-&gt;vrr_params.adjust);</pre><pre>+				&amp;acrt=
c_attach-&gt;dm_irq_params.vrr_params.adjust);</pre><pre>  			spin_unlock_i=
rqrestore(&amp;pcrtc-&gt;dev-&gt;event_lock, flags);</pre><pre>  		}</pre><=
pre>  		mutex_lock(&amp;dm-&gt;dc_lock);</pre><pre>@@ -7545,6 +7551,7 @@ st=
atic void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)</pre=
><pre>  	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;</pre>=
<pre>  	int crtc_disable_count =3D 0;</pre><pre>  	bool mode_set_reset_requ=
ired =3D false;</pre><pre>+        struct amdgpu_crtc *acrtc;</pre><pre>  <=
/pre><pre>  	drm_atomic_helper_update_legacy_modeset_state(dev, state);</pr=
e><pre>  </pre><pre>@@ -7651,9 +7658,12 @@ static void amdgpu_dm_atomic_com=
mit_tail(struct drm_atomic_state *state)</pre><pre>  			const struct dc_str=
eam_status *status =3D</pre><pre>  					dc_stream_get_status(dm_new_crtc_st=
ate-&gt;stream);</pre><pre>  </pre><pre>-			if (!status)</pre><pre>+			if (=
!status) {</pre><pre>  				status =3D dc_stream_get_status_from_state(dc_st=
ate,</pre><pre>  									 dm_new_crtc_state-&gt;stream);</pre><pre>+				dc=
_stream_retain(dm_new_crtc_state-&gt;stream);</pre></blockquote><pre><br></=
pre><pre>You're missing a release on this reference (dc_stream_release) so =
this </pre><pre>will cause a memory leak.</pre><pre><br></pre><blockquote t=
ype=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padd=
ing-left:1ex"><pre>+				acrtc-&gt;dm_irq_params.stream =3D dm_new_crtc_stat=
e-&gt;stream;</pre><pre>+			}</pre><pre>  </pre><pre>  			if (!status)</pre=
><pre>  				DC_ERR("got no status for stream %p on acrtc%p\n", dm_new_crtc_=
state-&gt;stream, acrtc);</pre><pre>@@ -7780,8 +7790,8 @@ static void amdgp=
u_dm_atomic_commit_tail(struct drm_atomic_state *state)</pre><pre>  		dm_ne=
w_crtc_state =3D to_dm_crtc_state(new_crtc_state);</pre><pre>  		dm_old_crt=
c_state =3D to_dm_crtc_state(old_crtc_state);</pre><pre>  </pre><pre>-		/* =
Update freesync active state. */</pre><pre>-		pre_update_freesync_state_on_=
stream(dm, dm_new_crtc_state);</pre><pre>+		/* For freesync config update o=
n crtc state and params for irq */</pre><pre>+		update_stream_irq_parameter=
s(dm, dm_new_crtc_state);</pre><pre>  </pre><pre>  		/* Handle vrr on-&gt;o=
ff / off-&gt;on transitions */</pre><pre>  		amdgpu_dm_handle_vrr_transitio=
n(dm_old_crtc_state,</pre><pre>@@ -7797,10 +7807,15 @@ static void amdgpu_d=
m_atomic_commit_tail(struct drm_atomic_state *state)</pre><pre>  	for_each_=
oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {</pre=
><pre>  		struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);</pre><pre>  <=
/pre><pre>+		dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);</pre><=
pre>+</pre><pre>  		if (new_crtc_state-&gt;active &amp;&amp;</pre><pre>  		=
    (!old_crtc_state-&gt;active ||</pre><pre>  		     drm_atomic_crtc_needs=
_modeset(new_crtc_state))) {</pre><pre>+			dc_stream_retain(dm_new_crtc_sta=
te-&gt;stream);</pre></blockquote><pre><br></pre><pre>This retain is also m=
issing a dc_stream_release.</pre><pre><br></pre><pre>Regards,</pre><pre>Nic=
holas Kazlauskas</pre><pre><br></pre><pre><br></pre></blockquote><pre><br><=
/pre><pre>Hi Nick,</pre><pre><br></pre><pre>Thanks for the review, I've pos=
ted V2.</pre></body></html>

--=-SkXLVuqWHD+24nbeJcqM--

--=-AOTAW10BH3KcxB1HBJzo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEjxfKIKECTdteDMVnC/mGJHAirekFAl9bpbIACgkQC/mGJHAi
rekoqQwA3CREANa09yB9Hd2jPJZKoFZA1CXzZKe9HdmPirlo0KQGgwybP4AySVYP
FH/TX0mQK5Sj9K0Xv9PB7AtrqVIyVkt045BOE+HB9jScb0owqumqz+IGTsCZkt+9
17R5vvniBHnqshc28hcryepnCuCJPwJTnzOUBTXP8RTUqoRlvtqNIbggOCvidjD0
Vxo2PMWXwYH4ggn3OxySdfnVJ/m9WI2d3yb1ag/gZqYVZHDoD6xRarMFWIpjf4Br
dRrcnHSFaxdTq5xhoRbcmkDDA5yQmq+8xslo+z/bTlbaVykHUOGr1QVIJOFeV2iM
KG+lnlY9o2+dErfqLGBtjexljB7ml6DGWSbMPnRUoVN2RbhUkvMdthTDbPOi7+EL
gvvM3p58rizdhP7AUzrQAWjI2SciRJvkuKAw7E9FOcbk2VT3j+WmONk9Yg+/FVGw
6LnC16OCbordX5b6zm6rHQPHcixToxPovUvf4vR1vDC2n0a6VaEGnTxFGrMzrGg/
AkNOuOLE
=LUw8
-----END PGP SIGNATURE-----

--=-AOTAW10BH3KcxB1HBJzo--

--===============1707366986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1707366986==--
