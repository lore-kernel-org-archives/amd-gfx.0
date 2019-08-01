From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: fix a few spelling mistakes
Date: Thu, 01 Aug 2019 12:16:23 -0700
Message-ID: <ce8c8a7342282467c3b681fd1b0874817250c16e.camel@perches.com>
References: <20190801083941.4230-1-colin.king@canonical.com>
         <CADnq5_OdBM83zkkgtjwzQ0jqsiDP5wZoMXioGcq4mycX2=Tavw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_OdBM83zkkgtjwzQ0jqsiDP5wZoMXioGcq4mycX2=Tavw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>, Colin King <colin.king@canonical.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, 2019-08-01 at 15:02 -0400, Alex Deucher wrote:
> Applied.  thanks!
> 
> Alex
> 
> On Thu, Aug 1, 2019 at 4:39 AM Colin King <colin.king@canonical.com> wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There are a few spelling mistakes "unknow" -> "unknown" and
> > "enabeld" -> "enabled". Fix these.
[]
> > diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
[]
> > @@ -39,7 +39,7 @@ static const char* __smu_message_names[] = {
> >  const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
> >  {
> >         if (type < 0 || type > SMU_MSG_MAX_COUNT)

This looks like an off-by-one test against
SMU_MSG_MAX_COUNT where type
should be >=

> > -               return "unknow smu message";
> > +               return "unknown smu message";
> >         return __smu_message_names[type];
[]
> > @@ -52,7 +52,7 @@ static const char* __smu_feature_names[] = {
> >  const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
> >  {
> >         if (feature < 0 || feature > SMU_FEATURE_COUNT)

here too

> > -               return "unknow smu feature";
> > +               return "unknown smu feature";
> >         return __smu_feature_names[feature];

Perhaps instead it should be against ARRAY_SIZE(__smu_<foo>)

Also, the  __SMU_DUMMY_MAP macro is unnecessarily complex.

It might be better to have some direct
index and name struct like

struct enum_name {
	int val;
	const char *name;
};

And walk that.

Perhaps add a macro like

#define enum_map(e)
	{.val = e, .name = #e}
