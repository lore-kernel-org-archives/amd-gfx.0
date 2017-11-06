From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] drm/amd/display: indent an if statement
Date: Mon, 6 Nov 2017 09:42:49 +0300
Message-ID: <20171106064249.4qkjkidrzxd66oet@mwanda>
References: <20171104061232.5bq5hwr2p2ca2cl7@mwanda>
 <59FD8567.4030500@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <59FD8567.4030500@bfs.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: walter harms <wharms@bfs.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Tony Cheng <tony.cheng@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Yue Hin Lau <Yuehin.Lau@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Sat, Nov 04, 2017 at 10:16:23AM +0100, walter harms wrote:
> 
> 
> Am 04.11.2017 07:12, schrieb Dan Carpenter:
> > The if statement wasn't indented so it makes static analysis tools and
> > probably very recent GCC versions complain.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > I went over 80 characters because other lines do already and it seemed
> > like the cleanest thing here.
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > index d911590d08bc..c83ac4d9ca3a 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > @@ -727,7 +727,7 @@ static void destruct(struct dcn10_resource_pool *pool)
> >  
> >  	for (i = 0; i < pool->base.stream_enc_count; i++) {
> >  		if (pool->base.stream_enc[i] != NULL)
> > -		kfree(DCE110STRENC_FROM_STRENC(pool->base.stream_enc[i]));
> > +			kfree(DCE110STRENC_FROM_STRENC(pool->base.stream_enc[i]));
> >  	}
> >  
> 
> Is that "if (pool->base.stream_enc[i] != NULL)" needed at all ?
> kfree() should happily handle NULL.
> 

Good point.  I'll resend.

regards,
dan carpenter

