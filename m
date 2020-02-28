Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF159C3F2D2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 10:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BE5246AC
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 10:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p03ZFevl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BE5246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637936EEC3;
	Fri, 28 Feb 2020 10:19:19 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB316EEC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 10:19:07 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SAHpN1056245;
 Fri, 28 Feb 2020 10:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=gPxHRziFrvaJP9XYffwSlnDaaRH4Zc38ZRMonSzSYh4=;
 b=p03ZFevlnpZmXeLyifaViiuRPFKNE3MBWqFJN/3/mzwNy31MBzHFU7BlS1o5Je0x4jUs
 KzXyIYbxYzPLVd5yyjsvzDsToc/tmcPuoReqimWZfn+C3uLdS4qi26Lf6zFPpWVqHojw
 ly7eBLY//7d44aF2pDoBS+pmalibVc7iDQh9pfTri7I+XAd8jCg5sRdOlaRG40Z3Sl12
 cQ6/WpOET7IZZKbkCrsLjEAYX50jAdJ7xAF74xhhfXMvtc55LtAEz+ii2OgcsbK4OPwk
 /POlGGfe8zwIPvtUh05kpCXu6zXUqu5fQ+I16T5rGlnlYNL0o4gazSZXN5ZxipyVI48u Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2yf0dm8987-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 10:19:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SAGnEW081001;
 Fri, 28 Feb 2020 10:19:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2ydcsex1jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Feb 2020 10:19:00 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SAIuQW009221;
 Fri, 28 Feb 2020 10:18:57 GMT
Received: from kadam (/129.205.23.165) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 28 Feb 2020 02:18:56 -0800
Date: Fri, 28 Feb 2020 13:18:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amd/display: Use after free in dmub_psr_destroy()
Message-ID: <20200228101847.GB4118@kadam>
References: <20200228080436.rmsqe3ytmxi3bwxn@kili.mountain>
 <cba36257-8562-d14a-da9b-cc38076d350f@daenzer.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cba36257-8562-d14a-da9b-cc38076d350f@daenzer.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280086
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Wyatt Wood <wyatt.wood@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 28, 2020 at 11:05:11AM +0100, Michel D=E4nzer wrote:
> On 2020-02-28 9:22 a.m., Dan Carpenter wrote:
> > These lines need to be re-ordered so that we don't dereference "dmub"
> > after we just freed it.
> > =

> > Fixes: 4c1a1335dfe0 ("drm/amd/display: Driverside changes to support PS=
R in DMCUB")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gp=
u/drm/amd/display/dc/dce/dmub_psr.c
> > index 2c932c29f1f9..dc858b152c6e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> > @@ -235,6 +235,6 @@ struct dmub_psr *dmub_psr_create(struct dc_context =
*ctx)
> >   */
> >  void dmub_psr_destroy(struct dmub_psr **dmub)
> >  {
> > -	kfree(dmub);
> >  	*dmub =3D NULL;
> > +	kfree(dmub);
> >  }
> > =

> =

> Maybe
> =

> 	kfree(*dmub);
> =

> was intended instead?
> =


Ah yeah.  You're right.  I will resend.

> =

> Actually, this function and others in this file seem completely unused?

It's used in linux-next from dcn21_resource_destruct().

drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
   986  =

   987          if (pool->base.dp_clock_source !=3D NULL) {
   988                  dcn20_clock_source_destroy(&pool->base.dp_clock_sou=
rce);
   989                  pool->base.dp_clock_source =3D NULL;
   990          }
   991  =

   992  =

   993          if (pool->base.abm !=3D NULL)
   994                  dce_abm_destroy(&pool->base.abm);
   995  =

   996          if (pool->base.dmcu !=3D NULL)
   997                  dce_dmcu_destroy(&pool->base.dmcu);
   998  =

   999          if (pool->base.psr !=3D NULL)
  1000                  dmub_psr_destroy(&pool->base.psr);

kfree(&pool->base.psr); will crash.

  1001  =

  1002          if (pool->base.dccg !=3D NULL)
  1003                  dcn_dccg_destroy(&pool->base.dccg);
  1004  =

  1005          if (pool->base.pp_smu !=3D NULL)
  1006                  dcn21_pp_smu_destroy(&pool->base.pp_smu);
  1007  }


regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
