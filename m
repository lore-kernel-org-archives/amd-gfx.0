From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pages
 for pool
Date: Wed, 16 Aug 2017 17:10:17 +0800
Message-ID: <140f09b5-32de-eb00-c2b1-8a660182344d@amd.com>
References: <1502868046-32511-1-git-send-email-Xiangliang.Yu@amd.com>
 <BLUPR12MB044923B80FB13FACC4DA726E84820@BLUPR12MB0449.namprd12.prod.outlook.com>
 <8f64cef6-e7f7-e245-93b9-a0d1bbc411aa@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1759014439=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8f64cef6-e7f7-e245-93b9-a0d1bbc411aa-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1759014439==
Content-Type: multipart/alternative;
	boundary="------------04D1803BB0F53AAC006F8920"
Content-Language: en-US

--------------04D1803BB0F53AAC006F8920
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Fix memory leak of ttm kernel issue?


On 2017年08月16日 15:55, Christian König wrote:
> CC stable?
>
> Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> Am 16.08.2017 um 09:25 schrieb Liu, Monk:
>>
>> Reviewed-by: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org>
>>
>> ------------------------------------------------------------------------
>> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
>> Xiangliang.Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
>> *Sent:* Wednesday, August 16, 2017 3:20:46 PM
>> *To:* akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; 
>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Cc:* Yu, Xiangliang
>> *Subject:* [PATCH 1/1] drm/ttm: Fix accounting error when fail to get 
>> pages for pool
>> When fail to get needed page for pool, need to put allocated pages
>> into pool. But current code has a miscalculation of allocated pages,
>> correct it.
>>
>> Signed-off-by: Xiangliang.Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
>> ---
>>  drivers/gpu/drm/ttm/ttm_page_alloc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c 
>> b/drivers/gpu/drm/ttm/ttm_page_alloc.c
>> index eeddc1e..8715998 100644
>> --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
>> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
>> @@ -615,7 +615,7 @@ static void ttm_page_pool_fill_locked(struct 
>> ttm_page_pool *pool,
>>                  } else {
>>                          pr_err("Failed to fill pool (%p)\n", pool);
>>                          /* If we have any pages left put them to the 
>> pool. */
>> -                       list_for_each_entry(p, &pool->list, lru) {
>> +                       list_for_each_entry(p, &new_pages, lru) {
>>                                  ++cpages;
>>                          }
>>                          list_splice(&new_pages, &pool->list);
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------04D1803BB0F53AAC006F8920
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Fix memory leak of ttm kernel issue?<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2017年08月16日 15:55, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:8f64cef6-e7f7-e245-93b9-a0d1bbc411aa-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div class="moz-cite-prefix">CC stable?<br>
        <br>
        Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E"
          href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        <br>
        Am 16.08.2017 um 09:25 schrieb Liu, Monk:<br>
      </div>
      <blockquote type="cite"
cite="mid:BLUPR12MB044923B80FB13FACC4DA726E84820-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
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
            <p>Reviewed-by: Monk Liu <a class="moz-txt-link-rfc2396E"
                href="mailto:monk.liu-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;monk.liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            </p>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="x_divRplyFwdMsg" dir="ltr"><font
              style="font-size:11pt" color="#000000" face="Calibri,
              sans-serif"><b>From:</b> amd-gfx <a
                class="moz-txt-link-rfc2396E"
                href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
              on behalf of Xiangliang.Yu <a
                class="moz-txt-link-rfc2396E"
                href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Wednesday, August 16, 2017 3:20:46 PM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated"
                href="mailto:akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org"
                moz-do-not-send="true">akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org</a>; <a
                class="moz-txt-link-abbreviated"
                href="mailto:labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" moz-do-not-send="true">labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>;
              <a class="moz-txt-link-abbreviated"
                href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
              <a class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Cc:</b> Yu, Xiangliang<br>
              <b>Subject:</b> [PATCH 1/1] drm/ttm: Fix accounting error
              when fail to get pages for pool</font>
            <div> </div>
          </div>
        </div>
        <font size="2"><span style="font-size:10pt;">
            <div class="PlainText">When fail to get needed page for
              pool, need to put allocated pages<br>
              into pool. But current code has a miscalculation of
              allocated pages,<br>
              correct it.<br>
              <br>
              Signed-off-by: Xiangliang.Yu <a
                class="moz-txt-link-rfc2396E"
                href="mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org"
                moz-do-not-send="true">&lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
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
              <a class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </div>
          </span></font> <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <p><br>
      </p>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------04D1803BB0F53AAC006F8920--

--===============1759014439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1759014439==--
