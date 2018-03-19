From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [Outreachy kernel] Re: [PATCH] gpu: drm: Use list_first_entry
 instead of list_entry
Date: Mon, 19 Mar 2018 14:15:19 +0100
Message-ID: <dfc1bc65-d6c0-8935-e787-4743d3cdabae@amd.com>
References: <20180318215105.GA15431@seema-Inspiron-15-3567>
 <8b1e22f8-7a05-b66b-8825-7d4d97e46dac@amd.com>
 <alpine.DEB.2.20.1803191204550.3392@hadrien>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0506879438=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <alpine.DEB.2.20.1803191204550.3392@hadrien>
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
To: Julia Lawall <julia.lawall@lip6.fr>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, outreachy-kernel@googlegroups.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0506879438==
Content-Type: multipart/alternative;
 boundary="------------6CE5DA37F03A48653B7B4E05"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6CE5DA37F03A48653B7B4E05
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.03.2018 um 12:06 schrieb Julia Lawall:
>
> On Mon, 19 Mar 2018, Christian König wrote:
>
>> Mhm, actually that patch isn't correct. What we grab get here is the next
>> entry, not the first one.
>>
>> We don't have an alias list_next_entry for list_first_entry?
> As compared to the semantic patch I proposed earlier today, it would seem
> that list_first_entry is useful when the types are different?  One would
> have to check the result of course, but a list eleemnt with the same type
> as the structure that contains the list might be unlikely?

The list element and the list head have different types in this case:
>    	if (sa_manager->hole->next == &sa_manager->olist)
>    		return;
>    -	sa_bo = list_entry(sa_manager->hole->next, struct amdgpu_sa_bo, olist);
> +	sa_bo = list_first_entry(sa_manager->hole, struct amdgpu_sa_bo, olist);

sa_manager->olist is the head of the list and sa_manager->hole can point 
to both the head and any element in the list.

The statement "if (sa_manager->hole->next == &sa_manager->olist)" now 
checks if the next pointer points to the head and if so aborts the function.

Then the statement "sa_bo = list_entry(sa_manager->hole->next, struct 
amdgpu_sa_bo, olist);" returns the next element after the hole to try to 
release it.

So with the automated change the code is still correct, but NOT easier 
to understand because we actually don't grab the first element here.

Regards,
Christian.

>
> julia
>
>> Regards,
>> Christian.
>>
>> Am 18.03.2018 um 22:51 schrieb Arushi Singhal:
>>> This patch replaces list_entry with list_first_entry as it makes the
>>> code more clear.
>>> Done using coccinelle:
>>>
>>> @@
>>> expression e;
>>> @@
>>> (
>>> - list_entry(e->next,
>>> + list_first_entry(e,
>>>     ...)
>>> |
>>> - list_entry(e->prev,
>>> + list_last_entry(e,
>>>     ...)
>>> )
>>>
>>> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 4 ++--
>>>    drivers/gpu/drm/omapdrm/dss/display.c  | 4 ++--
>>>    drivers/gpu/drm/radeon/radeon_sa.c     | 4 ++--
>>>    3 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> index 3144400..646f593 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
>>> @@ -158,7 +158,7 @@ static void amdgpu_sa_bo_try_free(struct
>>> amdgpu_sa_manager *sa_manager)
>>>    	if (sa_manager->hole->next == &sa_manager->olist)
>>>    		return;
>>>    -	sa_bo = list_entry(sa_manager->hole->next, struct amdgpu_sa_bo,
>>> olist);
>>> +	sa_bo = list_first_entry(sa_manager->hole, struct amdgpu_sa_bo,
>>> olist);
>>>    	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
>>>    		if (sa_bo->fence == NULL ||
>>>    		    !dma_fence_is_signaled(sa_bo->fence)) {
>>> @@ -183,7 +183,7 @@ static inline unsigned amdgpu_sa_bo_hole_eoffset(struct
>>> amdgpu_sa_manager *sa_ma
>>>    	struct list_head *hole = sa_manager->hole;
>>>      	if (hole->next != &sa_manager->olist) {
>>> -		return list_entry(hole->next, struct amdgpu_sa_bo,
>>> olist)->soffset;
>>> +		return list_first_entry(hole, struct amdgpu_sa_bo,
>>> olist)->soffset;
>>>    	}
>>>    	return sa_manager->size;
>>>    }
>>> diff --git a/drivers/gpu/drm/omapdrm/dss/display.c
>>> b/drivers/gpu/drm/omapdrm/dss/display.c
>>> index 0c9480b..fb9ecae 100644
>>> --- a/drivers/gpu/drm/omapdrm/dss/display.c
>>> +++ b/drivers/gpu/drm/omapdrm/dss/display.c
>>> @@ -158,8 +158,8 @@ struct omap_dss_device *omap_dss_get_next_device(struct
>>> omap_dss_device *from)
>>>    				goto out;
>>>    			}
>>>    -			dssdev = list_entry(l->next, struct omap_dss_device,
>>> -					panel_list);
>>> +			dssdev = list_first_entry(l, struct omap_dss_device,
>>> +						  panel_list);
>>>    			omap_dss_get_device(dssdev);
>>>    			goto out;
>>>    		}
>>> diff --git a/drivers/gpu/drm/radeon/radeon_sa.c
>>> b/drivers/gpu/drm/radeon/radeon_sa.c
>>> index 197b157..66c0482 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_sa.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_sa.c
>>> @@ -158,7 +158,7 @@ static void radeon_sa_bo_try_free(struct
>>> radeon_sa_manager *sa_manager)
>>>    	if (sa_manager->hole->next == &sa_manager->olist)
>>>    		return;
>>>    -	sa_bo = list_entry(sa_manager->hole->next, struct radeon_sa_bo,
>>> olist);
>>> +	sa_bo = list_first_entry(sa_manager->hole, struct radeon_sa_bo,
>>> olist);
>>>    	list_for_each_entry_safe_from(sa_bo, tmp, &sa_manager->olist, olist) {
>>>    		if (sa_bo->fence == NULL ||
>>> !radeon_fence_signaled(sa_bo->fence)) {
>>>    			return;
>>> @@ -182,7 +182,7 @@ static inline unsigned radeon_sa_bo_hole_eoffset(struct
>>> radeon_sa_manager *sa_ma
>>>    	struct list_head *hole = sa_manager->hole;
>>>      	if (hole->next != &sa_manager->olist) {
>>> -		return list_entry(hole->next, struct radeon_sa_bo,
>>> olist)->soffset;
>>> +		return list_first_entry(hole, struct radeon_sa_bo,
>>> olist)->soffset;
>>>    	}
>>>    	return sa_manager->size;
>>>    }
>> --
>> You received this message because you are subscribed to the Google Groups
>> "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/outreachy-kernel/8b1e22f8-7a05-b66b-8825-7d4d97e46dac%40amd.com.
>> For more options, visit https://groups.google.com/d/optout.
> >
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


--------------6CE5DA37F03A48653B7B4E05
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 19.03.2018 um 12:06 schrieb Julia
      Lawall:<br>
    </div>
    <blockquote type="cite"
      cite="mid:alpine.DEB.2.20.1803191204550.3392@hadrien">
      <pre wrap="">

On Mon, 19 Mar 2018, Christian König wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">Mhm, actually that patch isn't correct. What we grab get here is the next
entry, not the first one.

We don't have an alias list_next_entry for list_first_entry?
</pre>
      </blockquote>
      <pre wrap="">
As compared to the semantic patch I proposed earlier today, it would seem
that list_first_entry is useful when the types are different?  One would
have to check the result of course, but a list eleemnt with the same type
as the structure that contains the list might be unlikely?</pre>
    </blockquote>
    <br>
    The list element and the list head have different types in this
    case:<br>
    <blockquote type="cite">
      <pre wrap="">  	if (sa_manager-&gt;hole-&gt;next == &amp;sa_manager-&gt;olist)
  		return;
  -	sa_bo = list_entry(sa_manager-&gt;hole-&gt;next, struct amdgpu_sa_bo, olist);
+	sa_bo = list_first_entry(sa_manager-&gt;hole, struct amdgpu_sa_bo, olist);</pre>
    </blockquote>
    <br>
    sa_manager-&gt;olist is the head of the list and sa_manager-&gt;hole
    can point to both the head and any element in the list.<br>
    <br>
    The statement "if (sa_manager-&gt;hole-&gt;next ==
    &amp;sa_manager-&gt;olist)" now checks if the next pointer points to
    the head and if so aborts the function.<br>
    <br>
    Then the statement "sa_bo = list_entry(sa_manager-&gt;hole-&gt;next,
    struct amdgpu_sa_bo, olist);" returns the next element after the
    hole to try to release it.<br>
    <br>
    So with the automated change the code is still correct, but NOT
    easier to understand because we actually don't grab the first
    element here.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:alpine.DEB.2.20.1803191204550.3392@hadrien">
      <pre wrap="">

julia

</pre>
      <blockquote type="cite">
        <pre wrap="">
Regards,
Christian.

Am 18.03.2018 um 22:51 schrieb Arushi Singhal:
</pre>
        <blockquote type="cite">
          <pre wrap="">This patch replaces list_entry with list_first_entry as it makes the
code more clear.
Done using coccinelle:

@@
expression e;
@@
(
- list_entry(e-&gt;next,
+ list_first_entry(e,
   ...)
|
- list_entry(e-&gt;prev,
+ list_last_entry(e,
   ...)
)

Signed-off-by: Arushi Singhal <a class="moz-txt-link-rfc2396E" href="mailto:arushisinghal19971997@gmail.com">&lt;arushisinghal19971997@gmail.com&gt;</a>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 4 ++--
  drivers/gpu/drm/omapdrm/dss/display.c  | 4 ++--
  drivers/gpu/drm/radeon/radeon_sa.c     | 4 ++--
  3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 3144400..646f593 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -158,7 +158,7 @@ static void amdgpu_sa_bo_try_free(struct
amdgpu_sa_manager *sa_manager)
  	if (sa_manager-&gt;hole-&gt;next == &amp;sa_manager-&gt;olist)
  		return;
  -	sa_bo = list_entry(sa_manager-&gt;hole-&gt;next, struct amdgpu_sa_bo,
olist);
+	sa_bo = list_first_entry(sa_manager-&gt;hole, struct amdgpu_sa_bo,
olist);
  	list_for_each_entry_safe_from(sa_bo, tmp, &amp;sa_manager-&gt;olist, olist) {
  		if (sa_bo-&gt;fence == NULL ||
  		    !dma_fence_is_signaled(sa_bo-&gt;fence)) {
@@ -183,7 +183,7 @@ static inline unsigned amdgpu_sa_bo_hole_eoffset(struct
amdgpu_sa_manager *sa_ma
  	struct list_head *hole = sa_manager-&gt;hole;
    	if (hole-&gt;next != &amp;sa_manager-&gt;olist) {
-		return list_entry(hole-&gt;next, struct amdgpu_sa_bo,
olist)-&gt;soffset;
+		return list_first_entry(hole, struct amdgpu_sa_bo,
olist)-&gt;soffset;
  	}
  	return sa_manager-&gt;size;
  }
diff --git a/drivers/gpu/drm/omapdrm/dss/display.c
b/drivers/gpu/drm/omapdrm/dss/display.c
index 0c9480b..fb9ecae 100644
--- a/drivers/gpu/drm/omapdrm/dss/display.c
+++ b/drivers/gpu/drm/omapdrm/dss/display.c
@@ -158,8 +158,8 @@ struct omap_dss_device *omap_dss_get_next_device(struct
omap_dss_device *from)
  				goto out;
  			}
  -			dssdev = list_entry(l-&gt;next, struct omap_dss_device,
-					panel_list);
+			dssdev = list_first_entry(l, struct omap_dss_device,
+						  panel_list);
  			omap_dss_get_device(dssdev);
  			goto out;
  		}
diff --git a/drivers/gpu/drm/radeon/radeon_sa.c
b/drivers/gpu/drm/radeon/radeon_sa.c
index 197b157..66c0482 100644
--- a/drivers/gpu/drm/radeon/radeon_sa.c
+++ b/drivers/gpu/drm/radeon/radeon_sa.c
@@ -158,7 +158,7 @@ static void radeon_sa_bo_try_free(struct
radeon_sa_manager *sa_manager)
  	if (sa_manager-&gt;hole-&gt;next == &amp;sa_manager-&gt;olist)
  		return;
  -	sa_bo = list_entry(sa_manager-&gt;hole-&gt;next, struct radeon_sa_bo,
olist);
+	sa_bo = list_first_entry(sa_manager-&gt;hole, struct radeon_sa_bo,
olist);
  	list_for_each_entry_safe_from(sa_bo, tmp, &amp;sa_manager-&gt;olist, olist) {
  		if (sa_bo-&gt;fence == NULL ||
!radeon_fence_signaled(sa_bo-&gt;fence)) {
  			return;
@@ -182,7 +182,7 @@ static inline unsigned radeon_sa_bo_hole_eoffset(struct
radeon_sa_manager *sa_ma
  	struct list_head *hole = sa_manager-&gt;hole;
    	if (hole-&gt;next != &amp;sa_manager-&gt;olist) {
-		return list_entry(hole-&gt;next, struct radeon_sa_bo,
olist)-&gt;soffset;
+		return list_first_entry(hole, struct radeon_sa_bo,
olist)-&gt;soffset;
  	}
  	return sa_manager-&gt;size;
  }
</pre>
        </blockquote>
        <pre wrap="">
--
You received this message because you are subscribed to the Google Groups
"outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an
email to <a class="moz-txt-link-abbreviated" href="mailto:outreachy-kernel+unsubscribe@googlegroups.com">outreachy-kernel+unsubscribe@googlegroups.com</a>.
To post to this group, send email to <a class="moz-txt-link-abbreviated" href="mailto:outreachy-kernel@googlegroups.com">outreachy-kernel@googlegroups.com</a>.
To view this discussion on the web visit
<a class="moz-txt-link-freetext" href="https://groups.google.com/d/msgid/outreachy-kernel/8b1e22f8-7a05-b66b-8825-7d4d97e46dac%40amd.com">https://groups.google.com/d/msgid/outreachy-kernel/8b1e22f8-7a05-b66b-8825-7d4d97e46dac%40amd.com</a>.
For more options, visit <a class="moz-txt-link-freetext" href="https://groups.google.com/d/optout">https://groups.google.com/d/optout</a>.
</pre>
      </blockquote>
      <pre wrap="">&gt;</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
dri-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/dri-devel">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------6CE5DA37F03A48653B7B4E05--

--===============0506879438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0506879438==--
