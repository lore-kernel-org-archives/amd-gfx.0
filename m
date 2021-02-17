Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E916FC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 11:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFF764DDA
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 11:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFF764DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF0289C49;
	Wed, 17 Feb 2021 11:37:56 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADC389C49
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 11:37:54 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11HBYuNi061979;
 Wed, 17 Feb 2021 11:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jPvdeDdVcilj7SA18xFp7qCuNlolfCOSsRK5nC8WTXQ=;
 b=lh4acUks7TDLmXZKx9rfFeUo7zbQmplYN/ljQstkoz1v4+Ylk+KUB64f+eoTqa60+VT1
 E0EiFLDS6z/GpFiazrydnEhe8bykZQV5i5eXY3yFckxIwnxknmrm/9G4k20N6kCYFMRC
 2slgMzR4xpZo22E7tkTi2ePZe1VT+ACUpmbLKmusMm14igs7QwjPQGttwMR1v9gLNSSn
 Gxqp86kW9ZvEb0iAH9/dGWMsndSZRjOE19hWKYpXp6Jh0d5Y/HPYT4pmEHPUlccxB55u
 cYI6MMbyBeH3Otird7u5ukVKCcWeJh6uIKhyNnnbNVqztC38git6/3U1vSrjWJjEJcWT 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 36p66r22e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Feb 2021 11:37:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11HBaBox140178;
 Wed, 17 Feb 2021 11:37:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 36prp04tch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Feb 2021 11:37:45 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11HBbeKZ008056;
 Wed, 17 Feb 2021 11:37:41 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 17 Feb 2021 03:37:39 -0800
Date: Wed, 17 Feb 2021 14:37:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix an error code in
 init_pmu_entry_by_type_and_add()
Message-ID: <20210217113728.GB2087@kadam>
References: <YCwefEWbsHeME7vQ@mwanda>
 <CADnq5_NUk+t46Phbfm6H5wFjaTxkrbM49Hd5py-NtTr+v76vgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_NUk+t46Phbfm6H5wFjaTxkrbM49Hd5py-NtTr+v76vgw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170091
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102170091
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
Cc: Jonathan Kim <jonathan.kim@amd.com>, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org,
 Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Luben Tuikov <luben.tuikov@amd.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 16, 2021 at 02:52:55PM -0500, Alex Deucher wrote:
> On Tue, Feb 16, 2021 at 2:35 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > If the kmemdup() fails then this should return a negative error code
> > but it currently returns success.
> >
> > Fixes: b4a7db71ea06 ("drm/amdgpu: add per device user friendly xgmi events for vega20")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c     | 4 +++-
> >  drivers/gpu/drm/nouveau/nouveau_backlight.c | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > index 19c0a3655228..82e9ecf84352 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > @@ -519,8 +519,10 @@ static int init_pmu_entry_by_type_and_add(struct amdgpu_pmu_entry *pmu_entry,
> >         pmu_entry->pmu.attr_groups = kmemdup(attr_groups, sizeof(attr_groups),
> >                                                                 GFP_KERNEL);
> >
> > -       if (!pmu_entry->pmu.attr_groups)
> > +       if (!pmu_entry->pmu.attr_groups) {
> > +               ret = -ENOMEM;
> >                 goto err_attr_group;
> > +       }
> >
> >         snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d", pmu_entry->pmu_file_prefix,
> >                                 adev_to_drm(pmu_entry->adev)->primary->index);
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > index 72f35a2babcb..3786b1c85182 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> > @@ -274,6 +274,7 @@ nouveau_backlight_init(struct drm_connector *connector)
> >
> >         if (!nouveau_get_backlight_name(backlight_name, bl)) {
> >                 NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
> > +               ret = -ENOMEM;
> >                 goto fail_alloc;
> >         }
> 
> This hunk looks unrelated?
> 

That's so weird...  I don't even have any clue how that would happen at
all..  Weee wooo weee woooo  ALIENS!

Anyway, I'll resend.  Thanks!

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
