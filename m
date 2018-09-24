From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change status's type in
 aux_reply_transaction_data
Date: Mon, 24 Sep 2018 15:22:25 -0700
Message-ID: <20180924222225.GA26613@flashbox>
References: <20180921215505.14634-1-natechancellor@gmail.com>
 <CAKwvOd=PYNbPjK86Fxct=LShqnuRNhX3nih8whyjEUQBULDTLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOd=PYNbPjK86Fxct=LShqnuRNhX3nih8whyjEUQBULDTLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Sep 24, 2018 at 03:07:16PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 21, 2018 at 2:55 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:315:19: warning:
> > implicit conversion from enumeration type 'enum
> > aux_channel_operation_result' to different enumeration type 'enum
> > aux_transaction_reply' [-Wenum-conversion]
> >                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> >                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.c:349:19:
> > warning: implicit conversion from enumeration type 'enum
> > aux_channel_operation_result' to different enumeration type 'enum
> > aux_transaction_reply' [-Wenum-conversion]
> >                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> >                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I think the enum is actually wrong here.  I think the correct fix would be:
> 
> -                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> +                 reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
> 
> The identifiers are so similar, my guess was that it was easy to mix
> them up.  This looks like an actual bug to me, since the identifiers
> have different values between the 2 different enums.
> 

Hmmm interesting... I will be happy to send a v2 with your suggestion if
one of the maintainers could confirm that to be the case (given DRM code
is rather dense).

Thanks for the review!
Nathan

> >
> > Instead of implicitly or explicitly converting between types, just
> > change status to type uint8_t (since its max size is 255) which avoids
> > this construct altogether.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dc_ddc_types.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
> > index 05c8c31d8b31..97e1d4d19263 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
> > @@ -79,7 +79,7 @@ enum aux_transaction_reply {
> >  };
> >
> >  struct aux_reply_transaction_data {
> > -       enum aux_transaction_reply status;
> > +       uint8_t status;
> >         uint32_t length;
> >         uint8_t *data;
> >  };
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
