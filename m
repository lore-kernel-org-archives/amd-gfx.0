From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU during CS
Date: Tue, 14 May 2019 15:47:06 +0200
Message-ID: <f9017911-b08a-1f98-3fc9-98121bbde78a@gmail.com>
References: <20190514123127.1650-1-christian.koenig@amd.com>
 <20190514123127.1650-11-christian.koenig@amd.com>
 <-vf7xt3-qgf5mz-veq8ih-okgxtz-9ehg3tx8dyemoidihe-fwj066fntvvx-x3y4nh-bn07hl-82anfo4oofx-4di7gg-3nkfhtbcgh58-yj9ws0-pthytc-oq9qcxd40s4g-249dv8-x6wbfujry6xi-mu2nvl.1557839540398@email.android.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0474673352=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <-vf7xt3-qgf5mz-veq8ih-okgxtz-9ehg3tx8dyemoidihe-fwj066fntvvx-x3y4nh-bn07hl-82anfo4oofx-4di7gg-3nkfhtbcgh58-yj9ws0-pthytc-oq9qcxd40s4g-249dv8-x6wbfujry6xi-mu2nvl.1557839540398@email.android.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0474673352==
Content-Type: multipart/alternative;
 boundary="------------84DE613EEAB1B4265261C3A5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------84DE613EEAB1B4265261C3A5
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hui? What do you mean with that?

Christian.

Am 14.05.19 um 15:12 schrieb Zhou, David(ChunMing):
> my only concern is how to fresh LRU when bo is from bo list.
>
> -David
>
> -------- Original Message --------
> Subject: [PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU 
> during CS
> From: Christian König
> To: "Olsak, Marek" ,"Zhou, David(ChunMing)" ,"Liang, Prike" 
> ,dri-devel@lists.freedesktop.org,amd-gfx@lists.freedesktop.org
> CC:
>
> [CAUTION: External Email]
>
> This avoids OOM situations when we have lots of threads
> submitting at the same time.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index fff558cf385b..f9240a94217b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -648,7 +648,7 @@ static int amdgpu_cs_parser_bos(struct 
> amdgpu_cs_parser *p,
>         }
>
>         r = ttm_eu_reserve_buffers(&p->ticket, &p->validated, true,
> -                                  &duplicates, true);
> +                                  &duplicates, false);
>         if (unlikely(r != 0)) {
>                 if (r != -ERESTARTSYS)
>                         DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
> --
> 2.17.1
>


--------------84DE613EEAB1B4265261C3A5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hui? What do you mean with that?<br>
      <br>
      Christian.<br>
      <br>
      Am 14.05.19 um 15:12 schrieb Zhou, David(ChunMing):<br>
    </div>
    <blockquote type="cite"
cite="mid:-vf7xt3-qgf5mz-veq8ih-okgxtz-9ehg3tx8dyemoidihe-fwj066fntvvx-x3y4nh-bn07hl-82anfo4oofx-4di7gg-3nkfhtbcgh58-yj9ws0-pthytc-oq9qcxd40s4g-249dv8-x6wbfujry6xi-mu2nvl.1557839540398@email.android.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <div>my only concern is how to fresh LRU when bo is from bo list.<br>
        <br>
        -David<br>
        <br>
        -------- Original Message --------<br>
        Subject: [PATCH 11/11] drm/amdgpu: stop removing BOs from the
        LRU during CS<br>
        From: Christian König <br>
        To: "Olsak, Marek" ,"Zhou, David(ChunMing)" ,"Liang, Prike"
        ,<a class="moz-txt-link-abbreviated" href="mailto:dri-devel@lists.freedesktop.org,amd-gfx@lists.freedesktop.org">dri-devel@lists.freedesktop.org,amd-gfx@lists.freedesktop.org</a><br>
        CC: <br>
        <br>
      </div>
      <font size="2"><span style="font-size:11pt;">
          <div class="PlainText">[CAUTION: External Email]<br>
            <br>
            This avoids OOM situations when we have lots of threads<br>
            submitting at the same time.<br>
            <br>
            Signed-off-by: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
            ---<br>
             drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-<br>
             1 file changed, 1 insertion(+), 1 deletion(-)<br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            index fff558cf385b..f9240a94217b 100644<br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            @@ -648,7 +648,7 @@ static int amdgpu_cs_parser_bos(struct
            amdgpu_cs_parser *p,<br>
                    }<br>
            <br>
                    r = ttm_eu_reserve_buffers(&amp;p-&gt;ticket,
            &amp;p-&gt;validated, true,<br>
            -                                  &amp;duplicates, true);<br>
            +                                  &amp;duplicates, false);<br>
                    if (unlikely(r != 0)) {<br>
                            if (r != -ERESTARTSYS)<br>
                                    DRM_ERROR("ttm_eu_reserve_buffers
            failed.\n");<br>
            --<br>
            2.17.1<br>
            <br>
          </div>
        </span></font>
    </blockquote>
    <br>
  </body>
</html>

--------------84DE613EEAB1B4265261C3A5--

--===============0474673352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0474673352==--
