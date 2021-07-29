Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C367C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 07:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE9160527
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 07:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAE9160527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5486E4F3;
	Thu, 29 Jul 2021 07:58:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DCE6E4F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 07:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f652vGBcO3qwt0VNplKu+DboIkhLGAeL2l8sStFlHG9xE2OwEnOyJLTtRtrzNVONVU2/nl025unm4Ei5LySEcKxHeyWIgZAealGXKobMNewqvFWgFz5vNb1VPoaqDO65bV29ToaFejuGJ7H6njJsUYuocq821sIMNafza03SS1nzOsvz7WR6cBWynyfumPdxC8gXF6QCubn8CMHNnMw8mCvG4y6dIMRasB/7AKo3kqy7C0u1x08FcBVhep6fEMsuy60CzJihuMw+g/zElM+X/bnODA8SnwdKv7guw9HfdnRFEsj88yT0aPUIfbtgrDSZvz2gqcDZlni4Sz3eX6sZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InLoRiejheoPBqzvHGnNCEAv0B93YcT5xatsBwlrAjU=;
 b=Zod79Brk2JNQG1Gc1pT5c9J+wMI3JOFHPjG3FwPz6jaanvv/i2LDKj8nEPIG5Ga5eoaRc0OgfTEDdGZ9Ltg2fa/Z/6W5OX9HpoOB+eoghjrj21UIb2o5fo0Posetluiw7GJCX6XfdrsKMSMXSGPGcOdNpVHqXOIY4JGP8LHTK8J7pQfjvXzucl/y7CbYC55D6Hnei/Eu+j2CMqIyJknQnzO+xEi2TNvZWYOEFE8mNgvbamrtaSyuvFBZKa5f6tFsK4D4QzK5Vtbh9DjEBy0VSPFkB9MoQVkKeDbcDSijIpF1IrYR3pFpViW0mNbkGl9KqVSMBmT3TEhZzhaDokFidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InLoRiejheoPBqzvHGnNCEAv0B93YcT5xatsBwlrAjU=;
 b=Io+vpLsEHfbjT6fxnruEp/C1JZqn7adxfJVCLUSkJVms9EW+aHwilS84DDQgdKo9dlzYbOkJT9UP2Y4BXT2TNhjp3OTUNBc+OqLuTnHRm+b0HBkGHjgn9yFqo/txjyasicaofq+Uk2ACZVkuyyJWSSyha/9yAuDRTYZgTMoUUjE=
Received: from BYAPR12MB3416.namprd12.prod.outlook.com (2603:10b6:a03:ac::10)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 07:57:58 +0000
Received: from BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::f5f9:93c:a602:61ff]) by BYAPR12MB3416.namprd12.prod.outlook.com
 ([fe80::f5f9:93c:a602:61ff%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 07:57:58 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG
 issue for renoir.
Thread-Topic: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG
 issue for renoir.
Thread-Index: AQHXg3dCKMUfZnH4u0W53sQJbTf2D6tYZtCAgADCkNCAABFeAIAAXOPA
Date: Thu, 29 Jul 2021 07:57:58 +0000
Message-ID: <BYAPR12MB341602DF402CE7D568AC575EC1EB9@BYAPR12MB3416.namprd12.prod.outlook.com>
References: <20210728061018.2512047-1-yifan1.zhang@amd.com>
 <CADnq5_Oc-TY9e9=wEnhY7mgV8gBpxM=qPSwomW4ceQ-ondngGw@mail.gmail.com>
 <BYAPR12MB3416560A44B08B69871F64FFC1EB9@BYAPR12MB3416.namprd12.prod.outlook.com>
 <CADnq5_PJONeFX2rNaL-y__geeN=0C5dRiDJdMC5Bq5_V34n0Hg@mail.gmail.com>
In-Reply-To: <CADnq5_PJONeFX2rNaL-y__geeN=0C5dRiDJdMC5Bq5_V34n0Hg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29cd53b2-d84d-4066-f4f3-08d9526694ae
x-ms-traffictypediagnostic: BY5PR12MB4324:
x-microsoft-antispam-prvs: <BY5PR12MB432482FB18CDE9682C9273FDC1EB9@BY5PR12MB4324.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+mZJGLMwjavgZzhbchoehdXmd+m6ZOj2c5iWBA5xhm6TYQTN+IbAkhkbUdQEg/ItyHb1mS/3N9R2mOOnW4y4iejxxTC5qSawN6thuKyu2FtcS5Ytv1V0p+B4plgBcfGFeYhfww/9bBxBs4ISn4rw3I3Wrqm+sGT6KypdDNvKX5fiv45YVsBXiRNs1o3JFODdBMpWDRi/z9+woF0tVi9g2YDwJ10MdmiSnT+MKTTJeeXbki0y4Vtbqab6bmVaSpf+qL8acEboQvTVmpV38OFeGgdk2/0tZc3F3+DsQn6rQIYb9zheotFrXsuDu4NCsbr9e6IaN/1hc9aPGdOPfp/Z/5Mu6CmI6qKV4aINXWod19bKiu67dU+8+hSYt/FQmd9XB+exZnHBdjL/eSUJ4YqlGDU/CeKVpvEnh0x5SI9GzbOxPTlEYcyd7CNKBbRn2TDn+P5D1/uj4XtkwnH23TZIwGeG8/9t4GY16Wcj3/ygkVwXjjbffOYsvy3nKNokdF411pZTAEzqP8e7RtOD+1uEfO2UGSQQUaqWGBN7BHh8PyJU2IcI2XxecxSFiBXeRm8TiXAKp0WMteZpWYar+WwjuclVUlPwKfkKMuDmFtNfpsdCGUMTBdnLsQD5zjdm3WqK40pvcjJyGty/w+sF5zspjcImep1JQt4ZIAMDr1S09KscDs2Mra3H3wifIpUBZwu3A9pOJ5cmPCF6OFGrMhM8VG8gxIR0izs3x2X/IS+lx87cQs+LcgXr6eBqDuLy74BIE/aAoIxzxDs4v0WbBrE3w6lfbsf4Isp7vUFIJb5s0w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(66476007)(52536014)(7696005)(71200400001)(64756008)(66556008)(38070700005)(55016002)(6916009)(66446008)(66946007)(2906002)(9686003)(966005)(6506007)(186003)(8676002)(5660300002)(76116006)(316002)(33656002)(122000001)(53546011)(45080400002)(83380400001)(8936002)(478600001)(4326008)(26005)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8V+2Vkutt+zAeVLrn29IgOYyfG1yXF1CjaQbOGQIutnrHmDBPM75P1N+txVU?=
 =?us-ascii?Q?wnE8qOXb3972i7Fp18A37a6uh8JMGtezpiOuGrYdvYWkoLZ2UidKE7C4DrfK?=
 =?us-ascii?Q?JmuPPrJBFNBE0DXvS9aeTpa7W1LYS0U2t60mH+ioNEYMzFdD9Nj8HS0JVeYZ?=
 =?us-ascii?Q?dXGzeySkyaueX6ZTlk8FYGFW8vrVGG0pi8gatoaeyr+4biTn+SPBEQtgpWNM?=
 =?us-ascii?Q?TsA5ACf0G1XsBngsyIEs3XIzHgz30X3rm5Z0cawqxO8FBjCHdzSUbP2ibqnn?=
 =?us-ascii?Q?/5RhUdrUXeUpHngQkNPiH5ToDijE0N/L1He864ySl36+imWwXQQG4iwMD61t?=
 =?us-ascii?Q?mdg6SsAEQdK23M9uWeTfbelK5c0c3CFtzzqYU165ozm4heyTWDJgbZxEmaab?=
 =?us-ascii?Q?eCsBDvEdmh4CYGfx2rw8u1LQEbWzKVK4sxgVuYailYf3V/5a8Vp/5etQzrto?=
 =?us-ascii?Q?3lgdExRVDMx2JXiZQr3xY9KmpgSvFeK1g8pz2WF+bdkF92OIU7/DgBtSunPb?=
 =?us-ascii?Q?L555FhKvt105CemwT3stlr6ilZX1TvajrZP4i8oFeOzkpGlr0Iwp3iVnXir/?=
 =?us-ascii?Q?6f1PuMU3yISPq24gCDUsL6hIxrNGIQ52TfOYyjM6rIZfekRnZwYhEgrhBYxj?=
 =?us-ascii?Q?Z1cX+kfn5xYKSTaE0M1/oWyeaRtx4E1SQlNZXjwKJNc0pPvoO3/ZF2BbWQ5E?=
 =?us-ascii?Q?IUIawdZ0wBjDR787pGi9BmSvEW2BBuJPHG6G0oH7eklTdgfQRRHqUx8cGoTI?=
 =?us-ascii?Q?u8NnqxUwEQEH7o4bXPMcgOmv6M9EJKdhH+WsyYrTlzS+6Phjmi86ZFs7M5R1?=
 =?us-ascii?Q?Ny5Ivmi1s7N+hp9EI06Y8ZA+6T13ncKohWdt69fnH2PvBD3Qb52y8hQ/uQF2?=
 =?us-ascii?Q?2FI1nZc3RGLFjNjkWGX9lcMfuiGC96LJA7BLQZZz8BgIsNs737rHtEZio+Q9?=
 =?us-ascii?Q?Zi+DIMhp8mGii9QSVDjeV8Y8qccHbfwAzja2AHtJgi7vOjjdABqg4RCbzAvf?=
 =?us-ascii?Q?AFuOQaiEA2caUmHZyeGp5FhWfyyvnA9O8bEJOks+drUefIVRprzXk1yjrn3V?=
 =?us-ascii?Q?vrwF29mSrcu2F7dX/5b5S4U/e1tooyE1U0ft0Wusi8RGvpFgFqC4kNS+lOjE?=
 =?us-ascii?Q?9E5Qm/ohRCO6R8xaxoj2AnTUpk7DqWfPCSS9UC804lsGtq+BWq2Sxdl51Ulc?=
 =?us-ascii?Q?1/jVgbXWNiX+Av3KEtZwNES3LjeoAW2D0/TRD+hD+mp9dV/u1sxA/tibPW2q?=
 =?us-ascii?Q?gxL+/9FmULGqlj6eGVOV9hBqH/bwzjurYeNft/YMkyO8les6y+5pYGFfLtDt?=
 =?us-ascii?Q?M9zeuVNtSnDvsj+NLQg9ID7L?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cd53b2-d84d-4066-f4f3-08d9526694ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2021 07:57:58.2932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ7K9pXArs053b/ayKGVAw6/koA72HtvaPZKF0TsQPSv/j66Ik+KRdvrlTjIvOXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Agree. Patch updated. Thanks.

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Thursday, July 29, 2021 10:24 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG issue for renoir.

On Wed, Jul 28, 2021 at 9:33 PM Zhang, Yifan <Yifan1.Zhang@amd.com> wrote:
>
> Hi Alex,
>
> No, it won't break gfxoff. The "gfxoff broken" issue we saw last time has been fixed on CP firmware update for Renoir, and this patch changes doorbell range setting specifically for Renoir, not covering the other ASICs. I think it is better to change doorbell range setting per ASIC to mitigate possible side effects.
>

Thanks.  Do we need a firmware version check to determine when to set the range differently?

Alex


> BRs,
> Yifan
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, July 28, 2021 9:46 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH v2] drm/amdgpu: fix the doorbell missing when in CGPG issue for renoir.
>
> On Wed, Jul 28, 2021 at 2:10 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
> >
> > If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
> > Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>
> I assume this won't break gfxoff?  The last time we changed this, it broke a bunch of scenarios.  Won't this cause just about all doorbells to wake gfx?
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 03acc777adf7..70b64b510743 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -3675,7 +3675,15 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
> >         if (ring->use_doorbell) {
> >                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
> >                                         (adev->doorbell_index.kiq * 2) << 2);
> > -               WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> > +               /* In renoir, if GC has entered CGPG, ringing doorbell > first page
> > +                * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
> > +                * workaround this issue.
> > +                */
> > +               if (adev->asic_type == CHIP_RENOIR)
> > +                       WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> > +                                       (adev->doorbell.size - 4));
> > +               else
> > +                       WREG32_SOC15(GC, 0, 
> > + mmCP_MEC_DOORBELL_RANGE_UPPER,
> >                                         (adev->doorbell_index.userqueue_end * 2) << 2);
> >         }
> >
> > --
> > 2.25.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > st 
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7C
> > yi
> > fan1.zhang%40amd.com%7C4a2605541c22483b4a3a08d951ce097c%7C3dd8961fe4
> > 88 
> > 4e608e11a82d994e183d%7C0%7C0%7C637630767650055129%7CUnknown%7CTWFpbG
> > Zs 
> > b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > 3D 
> > %7C1000&amp;sdata=1TIsNslKHeSNNMDR3MHPaIiP%2BSLVrr5cEfAbCmvZlCw%3D&a
> > mp
> > ;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
