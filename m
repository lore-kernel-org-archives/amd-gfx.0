From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/ttm: fix ttm_bo_bulk_move_helper
Date: Fri, 7 Sep 2018 13:18:59 +0200
Message-ID: <24dbe7c4-63df-b8a7-28c3-df0e9866841f@gmail.com>
References: <20180831131019.2486-1-christian.koenig@amd.com>
 <a186be44-e64b-f408-fa30-bb81b59322f6@daenzer.net>
 <c8d0d5c6-1221-26be-4005-2f7ae21ade80@gmail.com>
 <20180906100244.GA27674@hr-amur2>
 <3be7e67a-2ffe-21c0-2160-69a330413858@amd.com>
 <CY1PR12MB0043539F7EE805B3A98E1FE2EC000@CY1PR12MB0043.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0820292378=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY1PR12MB0043539F7EE805B3A98E1FE2EC000-1s8aH8ViOEdbUNsZNX5b0gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0820292378==
Content-Type: multipart/alternative;
 boundary="------------E08D4D6F0A1FA03CDFA1EDBD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E08D4D6F0A1FA03CDFA1EDBD
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.09.2018 um 13:02 schrieb Huang, Ray:
>>>   Yes, that was one problem. Another was that the cutting code was buggy
>>>    and determined one of the positions to cut at the wrong time.
> I went through again about the list cutting behavior and wrote down with the attached picture.
> After do the second list_cut_position, the list2 should be point the end of "before" list. And list2 won't be used anymore after list cutting. May I know am I something missed?

Let's take a look at the original code:
> list1 = is_swap ? &pos->last->swap : &pos->last->lru;
> list2 = is_swap ? pos->first->swap.prev : pos->first->lru.prev;
>
> list_cut_position(&entries, lru, list1);
> list_cut_position(&before, &entries, list2);

As far as I can see the problem is that the first list_cur_position 
could modify the value of pos->first->lru.prev and so make the second 
list_cut_position work on the wrong position.

Regards,
Christian.

>
> Thanks,
> Ray
>
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Sent: Thursday, September 6, 2018 6:06 PM
> To: Huang, Ray
> Cc: Michel Dänzer; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: Re: [PATCH 1/3] drm/ttm: fix ttm_bo_bulk_move_helper
>    
>
> Am 06.09.2018 um 12:02 schrieb Huang Rui:
>> On Fri, Aug 31, 2018 at 05:17:33PM +0200, Christian König wrote:
>>> Am 31.08.2018 um 17:15 schrieb Michel Dänzer:
>>>> On 2018-08-31 3:10 p.m., Christian König wrote:
>>>>> Staring at the function for six hours, just to essentially move one line
>>>>> of code.
>>>> That sucks, but the commit log should describe what the problem was and
>>>> how this patch solves it.
>>>>
>>>>
>>>>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>>>> ---
>>>>>     drivers/gpu/drm/ttm/ttm_bo.c | 13 ++++++++-----
>>>>>     1 file changed, 8 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>>>>> index 35d53d81f486..138c98902033 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>>>> @@ -250,15 +250,18 @@ EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
>>>>>     static void ttm_bo_bulk_move_helper(struct ttm_lru_bulk_move_pos *pos,
>>>>>                                   struct list_head *lru, bool is_swap)
>>>>>     {
>>>>> +  struct list_head *list;
>>>>>       LIST_HEAD(entries);
>>>>>       LIST_HEAD(before);
>>>>> -  struct list_head *list1, *list2;
>>>>> -  list1 = is_swap ? &pos->last->swap : &pos->last->lru;
>>>>> -  list2 = is_swap ? pos->first->swap.prev : pos->first->lru.prev;
>>>>> +  reservation_object_assert_held(pos->last->resv);
>>>>> +  list = is_swap ? &pos->last->swap : &pos->last->lru;
>>>>> +  list_cut_position(&entries, lru, list);
>>>>> +
>>>>> +  reservation_object_assert_held(pos->first->resv);
>>>>> +  list = is_swap ? pos->first->swap.prev : pos->first->lru.prev;
>>>>> +  list_cut_position(&before, &entries, list);
>>>> So the problem was that the first list_cut_position call could result in
>>>> list2 pointing to la-la-land? Good catch!
>>> Yes, exactly. Thought that would be obvious, but going to add that
>>> to the commit log.
>>>
>>> Can I get a tested-by? You where much better at reproducing that than I'm.
>>>
>> Michel, Christian, thanks so much to take care of this when I was on
>> vacation. And sorry to let you take a long time for finding the cause.
>>
>> Is that because I didn't hold the resveration before cut the list from
>> position "first" and "last"?
> Yes, that was one problem. Another was that the cutting code was buggy
> and determined one of the positions to cut at the wrong time.
>
>>     May I know in which cases, we must hold the
>> bo's reservation firstly?
> BOs are reserved to prevent moving them. E.g. when the BO isn't reserved
> it can move around and so the LRU where you want to add/remove it could
> change.
>
> Christian.
>
>> Thanks,
>> Ray
>>
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> amd-gfx Info Page - freedesktop.org
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx Archives.. Using amd-gfx: To post a message to all the list members, send email to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change your existing subscription, in the sections below.
>
>      
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------E08D4D6F0A1FA03CDFA1EDBD
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 07.09.2018 um 13:02 schrieb Huang,
      Ray:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY1PR12MB0043539F7EE805B3A98E1FE2EC000-1s8aH8ViOEdbUNsZNX5b0gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap=""> Yes, that was one problem. Another was that the cutting code was buggy 
  and determined one of the positions to cut at the wrong time.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
I went through again about the list cutting behavior and wrote down with the attached picture.
After do the second list_cut_position, the list2 should be point the end of "before" list. And list2 won't be used anymore after list cutting. May I know am I something missed?  </pre>
    </blockquote>
    <br>
    Let's take a look at the original code: <br>
    <blockquote type="cite">list1 = is_swap ? &amp;pos-&gt;last-&gt;swap
      : &amp;pos-&gt;last-&gt;lru;<br>
      list2 = is_swap ? pos-&gt;first-&gt;swap.prev :
      pos-&gt;first-&gt;lru.prev;<br>
       <br>
      list_cut_position(&amp;entries, lru, list1);<br>
      list_cut_position(&amp;before, &amp;entries, list2);<br>
    </blockquote>
    <br>
    As far as I can see the problem is that the first list_cur_position
    could modify the value of pos-&gt;first-&gt;lru.prev and so make the
    second list_cut_position work on the wrong position.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CY1PR12MB0043539F7EE805B3A98E1FE2EC000-1s8aH8ViOEdbUNsZNX5b0gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <pre wrap="">

Thanks,
Ray

From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
Sent: Thursday, September 6, 2018 6:06 PM
To: Huang, Ray
Cc: Michel Dänzer; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
Subject: Re: [PATCH 1/3] drm/ttm: fix ttm_bo_bulk_move_helper
  

Am 06.09.2018 um 12:02 schrieb Huang Rui:
</pre>
      <blockquote type="cite">
        <pre wrap="">On Fri, Aug 31, 2018 at 05:17:33PM +0200, Christian König wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Am 31.08.2018 um 17:15 schrieb Michel Dänzer:
</pre>
          <blockquote type="cite">
            <pre wrap="">On 2018-08-31 3:10 p.m., Christian König wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="">Staring at the function for six hours, just to essentially move one line
of code.
</pre>
            </blockquote>
            <pre wrap="">That sucks, but the commit log should describe what the problem was and
how this patch solves it.


</pre>
            <blockquote type="cite">
              <pre wrap="">Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
   drivers/gpu/drm/ttm/ttm_bo.c | 13 ++++++++-----
   1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 35d53d81f486..138c98902033 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -250,15 +250,18 @@ EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
   static void ttm_bo_bulk_move_helper(struct ttm_lru_bulk_move_pos *pos,
                                 struct list_head *lru, bool is_swap)
   {
+  struct list_head *list;
     LIST_HEAD(entries);
     LIST_HEAD(before);
-  struct list_head *list1, *list2;
-  list1 = is_swap ? &amp;pos-&gt;last-&gt;swap : &amp;pos-&gt;last-&gt;lru;
-  list2 = is_swap ? pos-&gt;first-&gt;swap.prev : pos-&gt;first-&gt;lru.prev;
+  reservation_object_assert_held(pos-&gt;last-&gt;resv);
+  list = is_swap ? &amp;pos-&gt;last-&gt;swap : &amp;pos-&gt;last-&gt;lru;
+  list_cut_position(&amp;entries, lru, list);
+
+  reservation_object_assert_held(pos-&gt;first-&gt;resv);
+  list = is_swap ? pos-&gt;first-&gt;swap.prev : pos-&gt;first-&gt;lru.prev;
+  list_cut_position(&amp;before, &amp;entries, list);
</pre>
            </blockquote>
            <pre wrap="">So the problem was that the first list_cut_position call could result in
list2 pointing to la-la-land? Good catch!
</pre>
          </blockquote>
          <pre wrap="">Yes, exactly. Thought that would be obvious, but going to add that
to the commit log.

Can I get a tested-by? You where much better at reproducing that than I'm.

</pre>
        </blockquote>
        <pre wrap="">Michel, Christian, thanks so much to take care of this when I was on
vacation. And sorry to let you take a long time for finding the cause.

Is that because I didn't hold the resveration before cut the list from
position "first" and "last"?
</pre>
      </blockquote>
      <pre wrap="">
Yes, that was one problem. Another was that the cutting code was buggy 
and determined one of the positions to cut at the wrong time.

</pre>
      <blockquote type="cite">
        <pre wrap="">   May I know in which cases, we must hold the
bo's reservation firstly?
</pre>
      </blockquote>
      <pre wrap="">
BOs are reserved to prevent moving them. E.g. when the BO isn't reserved 
it can move around and so the LRU where you want to add/remove it could 
change.

Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="">
Thanks,
Ray


</pre>
      </blockquote>
      <pre wrap="">
_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>


amd-gfx Info Page - freedesktop.org
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Archives.. Using amd-gfx: To post a message to all the list members, send email to <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>. You can subscribe to the list, or change your existing subscription, in the sections below.

    </pre>
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

--------------E08D4D6F0A1FA03CDFA1EDBD--

--===============0820292378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0820292378==--
