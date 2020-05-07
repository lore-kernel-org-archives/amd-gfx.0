Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDACEC38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 17:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D4521473
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 17:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nekwnWxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D4521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 529716E17D;
	Thu,  7 May 2020 17:35:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782C16E17D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 17:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx1kpBrCXd3uCEKXTlgLwz1hmS8Bf5zrcJZGXvLC5dq5wPXYQOLMcfrbRAkkl5+CL4c3XgctGuFUrkSHvIuhtEZ2Ub4yGImC99w0sYl4EYddrBOyOEqhGxZ4aabvSKpbPVwybPTa70X1UWV9ofqWDULDxQ3qAp41THWMOClmm15O3dH78tbBxCJKtDq1VaN7V2HtP38f0XRZ0niTim6oT/TGupZmQsVEuJa/ilB4YLj2cSj1NIFE9V0G1n17bpakaDUDuAuBQcHe3i254N63Z8/HgOyDTAjsAXcMvrkn4Ay3ZPqn0S92yfpl9TGQk7CWnLfEYj/S3QhDggJa2X+vSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERd+UIwmQIrIsoDSeRXD1bYTwPro0VFXhoUWnnuGzcU=;
 b=llGJkvkzt7MGVa3XcKKGNjv5IsaO1PZQVIl3VJKM25MOlKzU/ST8mui9g2btMgkm0fjXVHSU6kpYeJC64tGLgbjhFN/CJpcjCixwEXEu0Owsb1VTB4YgAPIuzN0+ZyBTlEVtICmhcKS9/G8n6NQful0Hk7cwoyLdszTeu8DWZSZD5vYrIQoGXD6L0xohIW7ybcH8IW61v0DhJiThCzs6D+vQNbbfp6rLiT2fM42aPWN1grHmG49vEFHiBaJSR7USYn90srHA2ejHR2aPQN3A0npSC8qmSn9ocwfbQblj98Wi7IfT68A9REc9BizDm/dmeHuf3mvRvy06IIbFIVsNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERd+UIwmQIrIsoDSeRXD1bYTwPro0VFXhoUWnnuGzcU=;
 b=nekwnWxq8sljDcjCnhNT5bbc0/eLAH0tQ5oVA6B3Ou6YRwH2hJCPFMdsS2Pfvf0RobYrjWYNonW4Uekeo1gueRcV0HZFFDzIegt0/9voHovqn44/OO2oIC8MG0QNvK2RD0ypIdnQh648ivlsZzSCQW0xN8TLWI2f+mwV4CCRDjA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Thu, 7 May
 2020 17:35:25 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 17:35:25 +0000
Subject: Re: [PATCH] drm/amd/display: Fix vblank and pageflip event handling
 for FreeSync
To: Mario Kleiner <mario.kleiner.de@gmail.com>, Leo Li <sunpeng.li@amd.com>
References: <20200506194754.10780-1-nicholas.kazlauskas@amd.com>
 <33b0a4ad-496a-51f7-dbd4-ace5e807b3e9@amd.com>
 <CAEsyxyg0Vt=t=Ukt9H_6DQV_ikwqVKkkC3LtGQB3RPg8p=QUeg@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <3afc03fb-220f-ae9a-3849-ff429eac5607@amd.com>
Date: Thu, 7 May 2020 13:35:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAEsyxyg0Vt=t=Ukt9H_6DQV_ikwqVKkkC3LtGQB3RPg8p=QUeg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::14) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YQBPR01CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 17:35:24 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df3449bd-ba0e-495b-17ae-08d7f2ad06b3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:|BYAPR12MB2806:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2806C022E2941430EAABDF4BECA50@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jutrONPdljtOLc8dbr7GMAT4BW1qlHBek04MrfZi/urDaEG/yFm0gUQgNfDy3Mtbcb9SUK5ptYKVi2AQGaeyDNQD6zQCHgLRqcln9a2YJZYiZn0i825BXtvpKvyAl4UCes6yMXw9EH9QZ8+d9bde6oiTNbfQR9iGDo0hNZoEpv691Zcds9pXwFXxjonI7yioMWKUTC3wTf583movDfLU/mOVEdFMae/VsIRy3EgPZ69wNpRPZJJDG3jczZhJE8weZnpixc8g1La08JLdS12CectEjXfcZcO/muZzvyCaushu/8EQ5WD+9nl2PfgZgsigDr0ldBJ53PELtU76A3b4N1W5SL96hp/s+j2jpfCd/6E6SlrBBmPZaWllzWVNIRddgF7CogEjh+l7pfi41DhUq0rYC864SvyHXNT/AlBKqM29UvzT4NUaSQEXY1TI2UtaIx1NUEhlzq/M40qV2KTInVZNuE3JFZwvNnkOgcua8nBacZ6EoK67zHblNDcK4JUpN6kdyJrU9rT7U1NyKLIrCG9Uw/6YdeYT8X+zrz/h5GeUxlaSqhRcSa0U20bL/Svt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(33430700001)(316002)(8936002)(5660300002)(8676002)(478600001)(186003)(16526019)(83310400001)(6486002)(66556008)(66476007)(36756003)(83300400001)(83290400001)(2616005)(956004)(83320400001)(83280400001)(66946007)(31696002)(30864003)(16576012)(31686004)(86362001)(110136005)(26005)(4326008)(33964004)(52116002)(2906002)(6636002)(6666004)(53546011)(33440700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YKS6f382sC/Ypidh2L8qvP5tzGs+D5bqXxwB3ufDXc39oFOjLzJSnrF7hajz05H03YLoXR3rgIrnjzo8qqQQaThlSYnEXfrz/a/iKWtzd1iRBBrQcrfF2qQBmLEHqNRT3kaCiRgtEgU+I8a0ZSgiQfSeK0/brJHv94p853BkUIY3uu24ObsLAxwaJR5cWX0eLlixVTFcFjujyTa24RF6Y5bc1pcnfOQtpgIG4/wU7/XqgyhAZhlyf6dmMcLc7GwNrJ3KQyNyVYpW6VpFAZSOVu+k69xQLmsq2RVbDlpYEII/6iEA0IQnSeVXxB3PbhwbuXXgLE99S851B8SvJcOt3byvr5jTvKEx5OI3o7wBIElN9Qg0krUeceYqzyfUbjiYUgg72wmivL6H6nhH+1BqEAAzBa8B6845dTC1iXWAVHjbMmP1HDNhT+MCePbfiFUt6F9dEI1UUqMFJLq0B5iiLS0BN7gG4c4aY+RGdEdu1FHwqKJUPQHw7sQw0FIrBAx+d9xVneyPA5IpkYi+6PEH9KCQm3O5CkiUf3cpCdYYxIoAW7x9VkmxBpLFvZ6RWc2rPIGuNrd0wxPlWh0tBG5JOGqnewqKCYW5nU+TNadKUa0uUjZJCjllR63sk8XrKQH9N2TACMDFChIPuYqeyXR/GQXG+nL4x98Ks3c5NC8Uzf86SROU/3o5FR2GTQTjKmn82W3yWk+bR0STF1ZpE1MRtkX5ohOFu9K7meGIU7TcBMXhBWnDpUv2U5bTQ/b3FYAYCPntBLZSMYOns2W7brZziTfsnfJPCWSi8TNPG5r5EEs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3449bd-ba0e-495b-17ae-08d7f2ad06b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 17:35:25.5996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zh4tMDHdSukqYeh51t8XIwRfdLHS6cdGXspa15FbJ5fo6HQAMI87dYMNepZiWhMHYGCsRhSZGIC/GflgsIdLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1239557366=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1239557366==
Content-Type: multipart/alternative;
 boundary="------------6853D065BB922375A0110C39"
Content-Language: en-US

--------------6853D065BB922375A0110C39
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

It applies on top of Alex's amd-staging-drm-next-branch.

It is essentially just a revert to the old behavior with 
acrtc_state->active_planes == 0 special case you added on top and some 
small refactoring.

The only remaining bits that are kind of questionable is the 
VUPDATE_NO_LOCK vs VUPDATE bit again along with some of the locking 
around where we check if FreeSync is active or not.

I also don't think that VSTARTUP is the correct place to be performing 
the update for the registers since the offset between VSTARTUP and 
VUPDATE can be small enough such that the programming won't finish in 
time for some timings. We should be doing it on line 0 instead.

All these issues existed before this patch series at least though.

Regards,
Nicholas Kazlauskas

On 2020-05-07 12:58 p.m., Mario Kleiner wrote:
> Looking over it now, will do some testing. Alex amdgpu-drm-next branch 
> would be the best to test this?
>
> It looks like a revert of the whole vstartup series, except for that 
> one  if(acrtc_state->active_planes == 0)  special case, so i expect it 
> should be fine?
>
> thanks,
> -mario
>
>
> On Thu, May 7, 2020 at 5:56 PM Leo Li <sunpeng.li@amd.com 
> <mailto:sunpeng.li@amd.com>> wrote:
>
>
>
>     On 2020-05-06 3:47 p.m., Nicholas Kazlauskas wrote:
>     > [Why]
>     > We're the drm vblank event a frame too early in the case where the
>             ^sending
>
>     Thanks for catching this!
>
>     Reviewed-by: Leo Li <sunpeng.li@amd.com <mailto:sunpeng.li@amd.com>>
>
>     > pageflip happens close to VUPDATE and ends up blocking the signal.
>     >
>     > The implementation in DM was previously correct *before* we started
>     > sending vblank events from VSTARTUP unconditionally to handle cases
>     > where HUBP was off, OTG was ON and userspace was still
>     requesting some
>     > DRM planes enabled. As part of that patch series we dropped VUPDATE
>     > since it was deemed close enough to VSTARTUP, but there's a key
>     > difference betweeen VSTARTUP and VUPDATE - the VUPDATE signal can be
>     > blocked if we're holding the pipe lock >
>     > There was a fix recently to revert the unconditional behavior
>     for the
>     > DCN VSTARTUP vblank event since it was sending the pageflip event on
>     > the wrong frame - once again, due to blocking VUPDATE and having the
>     > address start scanning out two frames later.
>     >
>     > The problem with this fix is it didn't update the logic that calls
>     > drm_crtc_handle_vblank(), so the timestamps are totally bogus now.
>     >
>     > [How]
>     > Essentially reverts most of the original VSTARTUP series but retains
>     > the behavior to send back events when active planes == 0.
>     >
>     > Some refactoring/cleanup was done to not have duplicated code in
>     both
>     > the handlers.
>     >
>     > Fixes: 16f17eda8bad ("drm/amd/display: Send vblank and user
>     events at vsartup for DCN")
>     > Fixes: 3a2ce8d66a4b ("drm/amd/display: Disable VUpdate interrupt
>     for DCN hardware")
>     > Fixes: 2b5aed9ac3f7 ("drm/amd/display: Fix pageflip event race
>     condition for DCN.")
>     >
>     > Cc: Leo Li <sunpeng.li@amd.com <mailto:sunpeng.li@amd.com>>
>     > Cc: Mario Kleiner <mario.kleiner.de@gmail.com
>     <mailto:mario.kleiner.de@gmail.com>>
>     > Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com
>     <mailto:nicholas.kazlauskas@amd.com>>
>     > ---
>     >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137
>     +++++++-----------
>     >   1 file changed, 55 insertions(+), 82 deletions(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     > index 59f1d4a94f12..30ce28f7c444 100644
>     > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     > @@ -441,7 +441,7 @@ static void dm_vupdate_high_irq(void
>     *interrupt_params)
>     >
>     >   /**
>     >    * dm_crtc_high_irq() - Handles CRTC interrupt
>     > - * @interrupt_params: ignored
>     > + * @interrupt_params: used for determining the CRTC instance
>     >    *
>     >    * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
>     >    * event handler.
>     > @@ -455,70 +455,6 @@ static void dm_crtc_high_irq(void
>     *interrupt_params)
>     >       unsigned long flags;
>     >
>     >       acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src -
>     IRQ_TYPE_VBLANK);
>     > -
>     > -     if (acrtc) {
>     > -             acrtc_state = to_dm_crtc_state(acrtc->base.state);
>     > -
>     > -             DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
>     > -                           acrtc->crtc_id,
>     > -  amdgpu_dm_vrr_active(acrtc_state));
>     > -
>     > -             /* Core vblank handling at start of front-porch is
>     only possible
>     > -              * in non-vrr mode, as only there vblank
>     timestamping will give
>     > -              * valid results while done in front-porch.
>     Otherwise defer it
>     > -              * to dm_vupdate_high_irq after end of front-porch.
>     > -              */
>     > -             if (!amdgpu_dm_vrr_active(acrtc_state))
>     > -  drm_crtc_handle_vblank(&acrtc->base);
>     > -
>     > -             /* Following stuff must happen at start of vblank,
>     for crc
>     > -              * computation and below-the-range btr support in
>     vrr mode.
>     > -              */
>     > -  amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
>     > -
>     > -             if (acrtc_state->stream && adev->family >=
>     AMDGPU_FAMILY_AI &&
>     > -                 acrtc_state->vrr_params.supported &&
>     > -                 acrtc_state->freesync_config.state ==
>     VRR_STATE_ACTIVE_VARIABLE) {
>     > -  spin_lock_irqsave(&adev->ddev->event_lock, flags);
>     > -                     mod_freesync_handle_v_update(
>     > -  adev->dm.freesync_module,
>     > -                             acrtc_state->stream,
>     > -  &acrtc_state->vrr_params);
>     > -
>     > -                     dc_stream_adjust_vmin_vmax(
>     > -                             adev->dm.dc,
>     > -                             acrtc_state->stream,
>     > -  &acrtc_state->vrr_params.adjust);
>     > -  spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
>     > -             }
>     > -     }
>     > -}
>     > -
>     > -#if defined(CONFIG_DRM_AMD_DC_DCN)
>     > -/**
>     > - * dm_dcn_crtc_high_irq() - Handles VStartup interrupt for DCN
>     generation ASICs
>     > - * @interrupt params - interrupt parameters
>     > - *
>     > - * Notify DRM's vblank event handler at VSTARTUP
>     > - *
>     > - * Unlike DCE hardware, we trigger the handler at VSTARTUP. at
>     which:
>     > - * * We are close enough to VUPDATE - the point of no return for hw
>     > - * * We are in the fixed portion of variable front porch when
>     vrr is enabled
>     > - * * We are before VUPDATE, where double-buffered vrr registers
>     are swapped
>     > - *
>     > - * It is therefore the correct place to signal vblank, send
>     user flip events,
>     > - * and update VRR.
>     > - */
>     > -static void dm_dcn_crtc_high_irq(void *interrupt_params)
>     > -{
>     > -     struct common_irq_params *irq_params = interrupt_params;
>     > -     struct amdgpu_device *adev = irq_params->adev;
>     > -     struct amdgpu_crtc *acrtc;
>     > -     struct dm_crtc_state *acrtc_state;
>     > -     unsigned long flags;
>     > -
>     > -     acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src -
>     IRQ_TYPE_VBLANK);
>     > -
>     >       if (!acrtc)
>     >               return;
>     >
>     > @@ -528,22 +464,35 @@ static void dm_dcn_crtc_high_irq(void
>     *interrupt_params)
>     >                        amdgpu_dm_vrr_active(acrtc_state),
>     >                        acrtc_state->active_planes);
>     >
>     > +     /**
>     > +      * Core vblank handling at start of front-porch is only
>     possible
>     > +      * in non-vrr mode, as only there vblank timestamping will
>     give
>     > +      * valid results while done in front-porch. Otherwise defer it
>     > +      * to dm_vupdate_high_irq after end of front-porch.
>     > +      */
>     > +     if (!amdgpu_dm_vrr_active(acrtc_state))
>     > +  drm_crtc_handle_vblank(&acrtc->base);
>     > +
>     > +     /**
>     > +      * Following stuff must happen at start of vblank, for crc
>     > +      * computation and below-the-range btr support in vrr mode.
>     > +      */
>     >       amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
>     > -     drm_crtc_handle_vblank(&acrtc->base);
>     > +
>     > +     /* BTR updates need to happen before VUPDATE on Vega and
>     above. */
>     > +     if (adev->family < AMDGPU_FAMILY_AI)
>     > +             return;
>     >
>     >  spin_lock_irqsave(&adev->ddev->event_lock, flags);
>     >
>     > -     if (acrtc_state->vrr_params.supported &&
>     > +     if (acrtc_state->stream &&
>     acrtc_state->vrr_params.supported &&
>     >           acrtc_state->freesync_config.state ==
>     VRR_STATE_ACTIVE_VARIABLE) {
>     > -             mod_freesync_handle_v_update(
>     > -             adev->dm.freesync_module,
>     > -             acrtc_state->stream,
>     > -             &acrtc_state->vrr_params);
>     > +  mod_freesync_handle_v_update(adev->dm.freesync_module,
>     > + acrtc_state->stream,
>     > + &acrtc_state->vrr_params);
>     >
>     > -             dc_stream_adjust_vmin_vmax(
>     > -                     adev->dm.dc,
>     > -                     acrtc_state->stream,
>     > -  &acrtc_state->vrr_params.adjust);
>     > +             dc_stream_adjust_vmin_vmax(adev->dm.dc,
>     acrtc_state->stream,
>     > + &acrtc_state->vrr_params.adjust);
>     >       }
>     >
>     >       /*
>     > @@ -556,7 +505,8 @@ static void dm_dcn_crtc_high_irq(void
>     *interrupt_params)
>     >        * avoid race conditions between flip programming and
>     completion,
>     >        * which could cause too early flip completion events.
>     >        */
>     > -     if (acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
>     > +     if (adev->family >= AMDGPU_FAMILY_RV &&
>     > +         acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
>     >           acrtc_state->active_planes == 0) {
>     >               if (acrtc->event) {
>     >  drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
>     > @@ -568,7 +518,6 @@ static void dm_dcn_crtc_high_irq(void
>     *interrupt_params)
>     >
>     >  spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
>     >   }
>     > -#endif
>     >
>     >   static int dm_set_clockgating_state(void *handle,
>     >                 enum amd_clockgating_state state)
>     > @@ -2454,8 +2403,36 @@ static int
>     dcn10_register_irq_handlers(struct amdgpu_device *adev)
>     >               c_irq_params->adev = adev;
>     >               c_irq_params->irq_src = int_params.irq_source;
>     >
>     > +             amdgpu_dm_irq_register_interrupt(
>     > +                     adev, &int_params, dm_crtc_high_irq,
>     c_irq_params);
>     > +     }
>     > +
>     > +     /* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to
>     correspond to
>     > +      * the regular VUPDATE interrupt on DCE. We want
>     DC_IRQ_SOURCE_VUPDATEx
>     > +      * to trigger at end of each vblank, regardless of state
>     of the lock,
>     > +      * matching DCE behaviour.
>     > +      */
>     > +     for (i = DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT;
>     > +          i <=
>     DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT +
>     adev->mode_info.num_crtc - 1;
>     > +          i++) {
>     > +             r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE,
>     i, &adev->vupdate_irq);
>     > +
>     > +             if (r) {
>     > +                     DRM_ERROR("Failed to add vupdate irq id!\n");
>     > +                     return r;
>     > +             }
>     > +
>     > +             int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
>     > +             int_params.irq_source =
>     > +                     dc_interrupt_to_irq_source(dc, i, 0);
>     > +
>     > +             c_irq_params =
>     &adev->dm.vupdate_params[int_params.irq_source -
>     DC_IRQ_SOURCE_VUPDATE1];
>     > +
>     > +             c_irq_params->adev = adev;
>     > +             c_irq_params->irq_src = int_params.irq_source;
>     > +
>     >               amdgpu_dm_irq_register_interrupt(adev, &int_params,
>     > -                             dm_dcn_crtc_high_irq, c_irq_params);
>     > +                             dm_vupdate_high_irq, c_irq_params);
>     >       }
>     >
>     >       /* Use GRPH_PFLIP interrupt */
>     > @@ -4544,10 +4521,6 @@ static inline int
>     dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
>     >       struct amdgpu_device *adev = crtc->dev->dev_private;
>     >       int rc;
>     >
>     > -     /* Do not set vupdate for DCN hardware */
>     > -     if (adev->family > AMDGPU_FAMILY_AI)
>     > -             return 0;
>     > -
>     >       irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
>     >
>     >       rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0
>     : -EBUSY;
>     >
>


--------------6853D065BB922375A0110C39
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">It applies on top of Alex's
      amd-staging-drm-next-branch.</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">It is essentially just a revert to the
      old behavior with acrtc_state-&gt;active_planes == 0 special case
      you added on top and some small refactoring.</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">The only remaining bits that are kind
      of questionable is the VUPDATE_NO_LOCK vs VUPDATE bit again along
      with some of the locking around where we check if FreeSync is
      active or not.</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">I also don't think that VSTARTUP is the
      correct place to be performing the update for the registers since
      the offset between VSTARTUP and VUPDATE can be small enough such
      that the programming won't finish in time for some timings. We
      should be doing it on line 0 instead.<br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">All these issues existed before this
      patch series at least though.<br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">Regards,</div>
    <div class="moz-cite-prefix">Nicholas Kazlauskas<br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 2020-05-07 12:58 p.m., Mario Kleiner
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAEsyxyg0Vt=t=Ukt9H_6DQV_ikwqVKkkC3LtGQB3RPg8p=QUeg@mail.gmail.com">
      
      <div dir="ltr">
        <div>Looking over it now, will do some testing. Alex
          amdgpu-drm-next branch would be the best to test this?</div>
        <div><br>
        </div>
        <div>It looks like a revert of the whole vstartup series, except
          for that one&nbsp; if(acrtc_state-&gt;active_planes == 0)&nbsp; special
          case, so i expect it should be fine?</div>
        <div><br>
        </div>
        <div>thanks,<br>
        </div>
        <div>-mario</div>
        <div><br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu, May 7, 2020 at 5:56 PM
          Leo Li &lt;<a href="mailto:sunpeng.li@amd.com" moz-do-not-send="true">sunpeng.li@amd.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
          <br>
          On 2020-05-06 3:47 p.m., Nicholas Kazlauskas wrote:<br>
          &gt; [Why]<br>
          &gt; We're the drm vblank event a frame too early in the case
          where the<br>
          &nbsp; &nbsp; &nbsp; &nbsp; ^sending<br>
          <br>
          Thanks for catching this!<br>
          <br>
          Reviewed-by: Leo Li &lt;<a href="mailto:sunpeng.li@amd.com" target="_blank" moz-do-not-send="true">sunpeng.li@amd.com</a>&gt;<br>
          <br>
          &gt; pageflip happens close to VUPDATE and ends up blocking
          the signal.<br>
          &gt; <br>
          &gt; The implementation in DM was previously correct *before*
          we started<br>
          &gt; sending vblank events from VSTARTUP unconditionally to
          handle cases<br>
          &gt; where HUBP was off, OTG was ON and userspace was still
          requesting some<br>
          &gt; DRM planes enabled. As part of that patch series we
          dropped VUPDATE<br>
          &gt; since it was deemed close enough to VSTARTUP, but there's
          a key<br>
          &gt; difference betweeen VSTARTUP and VUPDATE - the VUPDATE
          signal can be<br>
          &gt; blocked if we're holding the pipe lock &gt;<br>
          &gt; There was a fix recently to revert the unconditional
          behavior for the<br>
          &gt; DCN VSTARTUP vblank event since it was sending the
          pageflip event on<br>
          &gt; the wrong frame - once again, due to blocking VUPDATE and
          having the<br>
          &gt; address start scanning out two frames later.<br>
          &gt; <br>
          &gt; The problem with this fix is it didn't update the logic
          that calls<br>
          &gt; drm_crtc_handle_vblank(), so the timestamps are totally
          bogus now.<br>
          &gt; <br>
          &gt; [How]<br>
          &gt; Essentially reverts most of the original VSTARTUP series
          but retains<br>
          &gt; the behavior to send back events when active planes == 0.<br>
          &gt; <br>
          &gt; Some refactoring/cleanup was done to not have duplicated
          code in both<br>
          &gt; the handlers.<br>
          &gt; <br>
          &gt; Fixes: 16f17eda8bad (&quot;drm/amd/display: Send vblank and
          user events at vsartup for DCN&quot;)<br>
          &gt; Fixes: 3a2ce8d66a4b (&quot;drm/amd/display: Disable VUpdate
          interrupt for DCN hardware&quot;)<br>
          &gt; Fixes: 2b5aed9ac3f7 (&quot;drm/amd/display: Fix pageflip event
          race condition for DCN.&quot;)<br>
          &gt; <br>
          &gt; Cc: Leo Li &lt;<a href="mailto:sunpeng.li@amd.com" target="_blank" moz-do-not-send="true">sunpeng.li@amd.com</a>&gt;<br>
          &gt; Cc: Mario Kleiner &lt;<a href="mailto:mario.kleiner.de@gmail.com" target="_blank" moz-do-not-send="true">mario.kleiner.de@gmail.com</a>&gt;<br>
          &gt; Signed-off-by: Nicholas Kazlauskas &lt;<a href="mailto:nicholas.kazlauskas@amd.com" target="_blank" moz-do-not-send="true">nicholas.kazlauskas@amd.com</a>&gt;<br>
          &gt; ---<br>
          &gt;&nbsp; &nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137
          &#43;&#43;&#43;&#43;&#43;&#43;&#43;-----------<br>
          &gt;&nbsp; &nbsp;1 file changed, 55 insertions(&#43;), 82 deletions(-)<br>
          &gt; <br>
          &gt; diff --git
          a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
          b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
          &gt; index 59f1d4a94f12..30ce28f7c444 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
          &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
          &gt; @@ -441,7 &#43;441,7 @@ static void dm_vupdate_high_irq(void
          *interrupt_params)<br>
          &gt;&nbsp; &nbsp;<br>
          &gt;&nbsp; &nbsp;/**<br>
          &gt;&nbsp; &nbsp; * dm_crtc_high_irq() - Handles CRTC interrupt<br>
          &gt; - * @interrupt_params: ignored<br>
          &gt; &#43; * @interrupt_params: used for determining the CRTC
          instance<br>
          &gt;&nbsp; &nbsp; *<br>
          &gt;&nbsp; &nbsp; * Handles the CRTC/VSYNC interrupt by notfying DRM's
          VBLANK<br>
          &gt;&nbsp; &nbsp; * event handler.<br>
          &gt; @@ -455,70 &#43;455,6 @@ static void dm_crtc_high_irq(void
          *interrupt_params)<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;unsigned long flags;<br>
          &gt;&nbsp; &nbsp;<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;acrtc = get_crtc_by_otg_inst(adev,
          irq_params-&gt;irq_src - IRQ_TYPE_VBLANK);<br>
          &gt; -<br>
          &gt; -&nbsp; &nbsp; &nbsp;if (acrtc) {<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc_state =
          to_dm_crtc_state(acrtc-&gt;base.state);<br>
          &gt; -<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DRM_DEBUG_VBL(&quot;crtc:%d, vupdate-vrr:%d\n&quot;,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc-&gt;crtc_id,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;amdgpu_dm_vrr_active(acrtc_state));<br>
          &gt; -<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Core vblank handling at start of
          front-porch is only possible<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * in non-vrr mode, as only there vblank
          timestamping will give<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * valid results while done in front-porch.
          Otherwise defer it<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * to dm_vupdate_high_irq after end of
          front-porch.<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!amdgpu_dm_vrr_active(acrtc_state))<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;drm_crtc_handle_vblank(&amp;acrtc-&gt;base);<br>
          &gt; -<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Following stuff must happen at start of
          vblank, for crc<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * computation and below-the-range btr
          support in vrr mode.<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;amdgpu_dm_crtc_handle_crc_irq(&amp;acrtc-&gt;base);<br>
          &gt; -<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (acrtc_state-&gt;stream &amp;&amp;
          adev-&gt;family &gt;= AMDGPU_FAMILY_AI &amp;&amp;<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc_state-&gt;vrr_params.supported
          &amp;&amp;<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc_state-&gt;freesync_config.state
          == VRR_STATE_ACTIVE_VARIABLE) {<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;spin_lock_irqsave(&amp;adev-&gt;ddev-&gt;event_lock, flags);<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mod_freesync_handle_v_update(<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;adev-&gt;dm.freesync_module,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc_state-&gt;stream,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;&amp;acrtc_state-&gt;vrr_params);<br>
          &gt; -<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc_stream_adjust_vmin_vmax(<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;adev-&gt;dm.dc,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc_state-&gt;stream,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;&amp;acrtc_state-&gt;vrr_params.adjust);<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;spin_unlock_irqrestore(&amp;adev-&gt;ddev-&gt;event_lock,
          flags);<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
          &gt; -&nbsp; &nbsp; &nbsp;}<br>
          &gt; -}<br>
          &gt; -<br>
          &gt; -#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
          &gt; -/**<br>
          &gt; - * dm_dcn_crtc_high_irq() - Handles VStartup interrupt
          for DCN generation ASICs<br>
          &gt; - * @interrupt params - interrupt parameters<br>
          &gt; - *<br>
          &gt; - * Notify DRM's vblank event handler at VSTARTUP<br>
          &gt; - *<br>
          &gt; - * Unlike DCE hardware, we trigger the handler at
          VSTARTUP. at which:<br>
          &gt; - * * We are close enough to VUPDATE - the point of no
          return for hw<br>
          &gt; - * * We are in the fixed portion of variable front porch
          when vrr is enabled<br>
          &gt; - * * We are before VUPDATE, where double-buffered vrr
          registers are swapped<br>
          &gt; - *<br>
          &gt; - * It is therefore the correct place to signal vblank,
          send user flip events,<br>
          &gt; - * and update VRR.<br>
          &gt; - */<br>
          &gt; -static void dm_dcn_crtc_high_irq(void *interrupt_params)<br>
          &gt; -{<br>
          &gt; -&nbsp; &nbsp; &nbsp;struct common_irq_params *irq_params =
          interrupt_params;<br>
          &gt; -&nbsp; &nbsp; &nbsp;struct amdgpu_device *adev = irq_params-&gt;adev;<br>
          &gt; -&nbsp; &nbsp; &nbsp;struct amdgpu_crtc *acrtc;<br>
          &gt; -&nbsp; &nbsp; &nbsp;struct dm_crtc_state *acrtc_state;<br>
          &gt; -&nbsp; &nbsp; &nbsp;unsigned long flags;<br>
          &gt; -<br>
          &gt; -&nbsp; &nbsp; &nbsp;acrtc = get_crtc_by_otg_inst(adev,
          irq_params-&gt;irq_src - IRQ_TYPE_VBLANK);<br>
          &gt; -<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;if (!acrtc)<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;<br>
          &gt;&nbsp; &nbsp;<br>
          &gt; @@ -528,22 &#43;464,35 @@ static void
          dm_dcn_crtc_high_irq(void *interrupt_params)<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_dm_vrr_active(acrtc_state),<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; acrtc_state-&gt;active_planes);<br>
          &gt;&nbsp; &nbsp;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;/**<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; * Core vblank handling at start of front-porch is
          only possible<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; * in non-vrr mode, as only there vblank
          timestamping will give<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; * valid results while done in front-porch.
          Otherwise defer it<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; * to dm_vupdate_high_irq after end of front-porch.<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; */<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;if (!amdgpu_dm_vrr_active(acrtc_state))<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;drm_crtc_handle_vblank(&amp;acrtc-&gt;base);<br>
          &gt; &#43;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;/**<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; * Following stuff must happen at start of vblank,
          for crc<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; * computation and below-the-range btr support in
          vrr mode.<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; */<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;amdgpu_dm_crtc_handle_crc_irq(&amp;acrtc-&gt;base);<br>
          &gt; -&nbsp; &nbsp; &nbsp;drm_crtc_handle_vblank(&amp;acrtc-&gt;base);<br>
          &gt; &#43;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;/* BTR updates need to happen before VUPDATE on
          Vega and above. */<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;if (adev-&gt;family &lt; AMDGPU_FAMILY_AI)<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;<br>
          &gt;&nbsp; &nbsp;<br>
          &gt;&nbsp; &nbsp; &nbsp;
          &nbsp;spin_lock_irqsave(&amp;adev-&gt;ddev-&gt;event_lock, flags);<br>
          &gt;&nbsp; &nbsp;<br>
          &gt; -&nbsp; &nbsp; &nbsp;if (acrtc_state-&gt;vrr_params.supported &amp;&amp;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;if (acrtc_state-&gt;stream &amp;&amp;
          acrtc_state-&gt;vrr_params.supported &amp;&amp;<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc_state-&gt;freesync_config.state ==
          VRR_STATE_ACTIVE_VARIABLE) {<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mod_freesync_handle_v_update(<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;adev-&gt;dm.freesync_module,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc_state-&gt;stream,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&amp;acrtc_state-&gt;vrr_params);<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;mod_freesync_handle_v_update(adev-&gt;dm.freesync_module,<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          acrtc_state-&gt;stream,<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &amp;acrtc_state-&gt;vrr_params);<br>
          &gt;&nbsp; &nbsp;<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc_stream_adjust_vmin_vmax(<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;adev-&gt;dm.dc,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc_state-&gt;stream,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;&amp;acrtc_state-&gt;vrr_params.adjust);<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc_stream_adjust_vmin_vmax(adev-&gt;dm.dc,
          acrtc_state-&gt;stream,<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &amp;acrtc_state-&gt;vrr_params.adjust);<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
          &gt;&nbsp; &nbsp;<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;/*<br>
          &gt; @@ -556,7 &#43;505,8 @@ static void dm_dcn_crtc_high_irq(void
          *interrupt_params)<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; * avoid race conditions between flip programming
          and completion,<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; * which could cause too early flip completion
          events.<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; */<br>
          &gt; -&nbsp; &nbsp; &nbsp;if (acrtc-&gt;pflip_status == AMDGPU_FLIP_SUBMITTED
          &amp;&amp;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;if (adev-&gt;family &gt;= AMDGPU_FAMILY_RV
          &amp;&amp;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc-&gt;pflip_status == AMDGPU_FLIP_SUBMITTED
          &amp;&amp;<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;acrtc_state-&gt;active_planes == 0) {<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (acrtc-&gt;event) {<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;drm_crtc_send_vblank_event(&amp;acrtc-&gt;base,
          acrtc-&gt;event);<br>
          &gt; @@ -568,7 &#43;518,6 @@ static void dm_dcn_crtc_high_irq(void
          *interrupt_params)<br>
          &gt;&nbsp; &nbsp;<br>
          &gt;&nbsp; &nbsp; &nbsp;
          &nbsp;spin_unlock_irqrestore(&amp;adev-&gt;ddev-&gt;event_lock,
          flags);<br>
          &gt;&nbsp; &nbsp;}<br>
          &gt; -#endif<br>
          &gt;&nbsp; &nbsp;<br>
          &gt;&nbsp; &nbsp;static int dm_set_clockgating_state(void *handle,<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;enum amd_clockgating_state state)<br>
          &gt; @@ -2454,8 &#43;2403,36 @@ static int
          dcn10_register_irq_handlers(struct amdgpu_device *adev)<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;c_irq_params-&gt;adev = adev;<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;c_irq_params-&gt;irq_src =
          int_params.irq_source;<br>
          &gt;&nbsp; &nbsp;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_dm_irq_register_interrupt(<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;adev, &amp;int_params,
          dm_crtc_high_irq, c_irq_params);<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;}<br>
          &gt; &#43;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;/* Use VUPDATE_NO_LOCK interrupt on DCN, which
          seems to correspond to<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; * the regular VUPDATE interrupt on DCE. We want
          DC_IRQ_SOURCE_VUPDATEx<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; * to trigger at end of each vblank, regardless of
          state of the lock,<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; * matching DCE behaviour.<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; */<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp;for (i =
          DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i &lt;=
          DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT &#43;
          adev-&gt;mode_info.num_crtc - 1;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; i&#43;&#43;) {<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r = amdgpu_irq_add_id(adev,
          SOC15_IH_CLIENTID_DCE, i, &amp;adev-&gt;vupdate_irq);<br>
          &gt; &#43;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (r) {<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DRM_ERROR(&quot;Failed to add vupdate
          irq id!\n&quot;);<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return r;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
          &gt; &#43;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int_params.int_context =
          INTERRUPT_HIGH_IRQ_CONTEXT;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int_params.irq_source =<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc_interrupt_to_irq_source(dc, i,
          0);<br>
          &gt; &#43;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;c_irq_params =
          &amp;adev-&gt;dm.vupdate_params[int_params.irq_source -
          DC_IRQ_SOURCE_VUPDATE1];<br>
          &gt; &#43;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;c_irq_params-&gt;adev = adev;<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;c_irq_params-&gt;irq_src =
          int_params.irq_source;<br>
          &gt; &#43;<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_dm_irq_register_interrupt(adev,
          &amp;int_params,<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dm_dcn_crtc_high_irq,
          c_irq_params);<br>
          &gt; &#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dm_vupdate_high_irq,
          c_irq_params);<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
          &gt;&nbsp; &nbsp;<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;/* Use GRPH_PFLIP interrupt */<br>
          &gt; @@ -4544,10 &#43;4521,6 @@ static inline int
          dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;struct amdgpu_device *adev =
          crtc-&gt;dev-&gt;dev_private;<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;int rc;<br>
          &gt;&nbsp; &nbsp;<br>
          &gt; -&nbsp; &nbsp; &nbsp;/* Do not set vupdate for DCN hardware */<br>
          &gt; -&nbsp; &nbsp; &nbsp;if (adev-&gt;family &gt; AMDGPU_FAMILY_AI)<br>
          &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
          &gt; -<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;irq_source = IRQ_TYPE_VUPDATE &#43; acrtc-&gt;otg_inst;<br>
          &gt;&nbsp; &nbsp;<br>
          &gt;&nbsp; &nbsp; &nbsp; &nbsp;rc = dc_interrupt_set(adev-&gt;dm.dc, irq_source,
          enable) ? 0 : -EBUSY;<br>
          &gt; <br>
        </blockquote>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------6853D065BB922375A0110C39--

--===============1239557366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1239557366==--
