From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pages
 for pool
Date: Wed, 16 Aug 2017 09:55:17 +0200
Message-ID: <8f64cef6-e7f7-e245-93b9-a0d1bbc411aa@vodafone.de>
References: <1502868046-32511-1-git-send-email-Xiangliang.Yu@amd.com>
 <BLUPR12MB044923B80FB13FACC4DA726E84820@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0410514263=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <BLUPR12MB044923B80FB13FACC4DA726E84820@BLUPR12MB0449.namprd12.prod.outlook.com>
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
To: "Liu, Monk" <Monk.Liu@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "labbott@redhat.com" <labbott@redhat.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0410514263==
Content-Type: multipart/alternative;
 boundary="------------137C0B67936EA0D6BECD34E7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------137C0B67936EA0D6BECD34E7
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

CC stable?

Reviewed-by: Christian König <christian.koenig@amd.com>

Am 16.08.2017 um 09:25 schrieb Liu, Monk:
>
> Reviewed-by: Monk Liu <monk.liu@amd.com>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Xiangliang.Yu <Xiangliang.Yu@amd.com>
> *Sent:* Wednesday, August 16, 2017 3:20:46 PM
> *To:* akpm@linux-foundation.org; labbott@redhat.com; 
> dri-devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org
> *Cc:* Yu, Xiangliang
> *Subject:* [PATCH 1/1] drm/ttm: Fix accounting error when fail to get 
> pages for pool
> When fail to get needed page for pool, need to put allocated pages
> into pool. But current code has a miscalculation of allocated pages,
> correct it.
>
> Signed-off-by: Xiangliang.Yu <Xiangliang.Yu@amd.com>
> ---
>  drivers/gpu/drm/ttm/ttm_page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c 
> b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> index eeddc1e..8715998 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> @@ -615,7 +615,7 @@ static void ttm_page_pool_fill_locked(struct 
> ttm_page_pool *pool,
>                  } else {
>                          pr_err("Failed to fill pool (%p)\n", pool);
>                          /* If we have any pages left put them to the 
> pool. */
> -                       list_for_each_entry(p, &pool->list, lru) {
> +                       list_for_each_entry(p, &new_pages, lru) {
>                                  ++cpages;
>                          }
>                          list_splice(&new_pages, &pool->list);
> -- 
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------137C0B67936EA0D6BECD34E7
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">CC stable?<br>
      <br>
      Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
      <br>
      Am 16.08.2017 um 09:25 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB044923B80FB13FACC4DA726E84820@BLUPR12MB0449.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <meta content="text/html; charset=UTF-8">
      <style type="text/css" style="">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
      <div dir="ltr">
        <div id="x_divtagdefaultwrapper" dir="ltr"
          style="font-size:12pt; color:#000000;
          font-family:Calibri,Helvetica,sans-serif">
          <p>Reviewed-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:monk.liu@amd.com">&lt;monk.liu@amd.com&gt;</a><br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Xiangliang.Yu <a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu@amd.com">&lt;Xiangliang.Yu@amd.com&gt;</a><br>
            <b>Sent:</b> Wednesday, August 16, 2017 3:20:46 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:akpm@linux-foundation.org">akpm@linux-foundation.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:labbott@redhat.com">labbott@redhat.com</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesktop.org</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
            <b>Cc:</b> Yu, Xiangliang<br>
            <b>Subject:</b> [PATCH 1/1] drm/ttm: Fix accounting error
            when fail to get pages for pool</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">When fail to get needed page for pool,
            need to put allocated pages<br>
            into pool. But current code has a miscalculation of
            allocated pages,<br>
            correct it.<br>
            <br>
            Signed-off-by: Xiangliang.Yu <a class="moz-txt-link-rfc2396E" href="mailto:Xiangliang.Yu@amd.com">&lt;Xiangliang.Yu@amd.com&gt;</a><br>
            ---<br>
             drivers/gpu/drm/ttm/ttm_page_alloc.c | 2 +-<br>
             1 file changed, 1 insertion(+), 1 deletion(-)<br>
            <br>
            diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c
            b/drivers/gpu/drm/ttm/ttm_page_alloc.c<br>
            index eeddc1e..8715998 100644<br>
            --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c<br>
            +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c<br>
            @@ -615,7 +615,7 @@ static void
            ttm_page_pool_fill_locked(struct ttm_page_pool *pool,<br>
                             } else {<br>
                                     pr_err("Failed to fill pool
            (%p)\n", pool);<br>
                                     /* If we have any pages left put
            them to the pool. */<br>
            -                       list_for_each_entry(p,
            &amp;pool-&gt;list, lru) {<br>
            +                       list_for_each_entry(p,
            &amp;new_pages, lru) {<br>
                                             ++cpages;<br>
                                     }<br>
                                     list_splice(&amp;new_pages,
            &amp;pool-&gt;list);<br>
            -- <br>
            2.7.4<br>
            <br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
            <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------137C0B67936EA0D6BECD34E7--

--===============0410514263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0410514263==--
