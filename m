From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH] drm/core: Fail atomic IOCTL with no CRTC state but with
 signaling.
Date: Mon, 19 Jun 2017 16:11:35 -0400
Message-ID: <f9bdcba7-1549-75ce-c1bf-39525cc3fb47@amd.com>
References: <1497043819-28591-1-git-send-email-Andrey.Grodzovsky@amd.com>
 <0d603149-3fb0-3d48-89e5-77e3f7686415@amd.com>
 <20170619192431.tbsntjjdkianx2kc@art_vandelay>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0482437771=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170619192431.tbsntjjdkianx2kc@art_vandelay>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sean Paul <seanpaul@chromium.org>, Harry Wentland <harry.wentland@amd.com>
Cc: intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0482437771==
Content-Type: multipart/alternative;
 boundary="------------CA32949480719FBED6879A48"

This is a multi-part message in MIME format.
--------------CA32949480719FBED6879A48
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 06/19/2017 03:24 PM, Sean Paul wrote:
> On Mon, Jun 19, 2017 at 11:35:28AM -0400, Harry Wentland wrote:
>> On 2017-06-09 05:30 PM, Andrey Grodzovsky wrote:
>>> Problem:
>>> While running IGT kms_atomic_transition test suite i encountered
>>> a hang in drmHandleEvent immidietly follwoing an atomic_commit.
>> s/immidietly/immediately/g
>> s/follwoing/following/g
>>
>>> After dumping the atomic state I relized that in this case there was
>>> not even one CRTC attached to the state and only disabled
>>> planes. This probably due to a commit which hadn't changed any property
>>> which would require attaching crtc state. This means drmHandleEvent
>>> will never wake up from read since without CRTC in atomic state
>>> the event fd will not be singnaled.
>> s/singnaled/signaled/g
>>
>>> This point to a bug in IGT but also DRM should gracefully
>>> fail  such scenario so no hang on user side will happen.
>>>
>> Can we create an IGT fix for this to make sure this won't happen?
>>
>>> Fix:
>>> Explicitly fail by failing atomic_commit early in
>>> drm_mode_atomic_commit where such problem can be identified.
>>>
>> The change seems reasonable to me but I would like to see some input
>> from someone who's more familiar with the usermode side of things.
> I wonder if there's ever a case where it might be desirable to generate an event
> from a commit without a crtc. I don't know if anyone has explicitly said that an
> event can only be generated from state with crtc.
For a generic event i agree, bit seems to me without active CRTC no way you
can  expect PAGE_FLIP_EVENT to fire.
>
> I usually don't mind letting userspace shoot itself in the foot, so keep that in
> mind :)
>
> Sean

Seems to me you still would try to avoid a bad configuration, returning 
error
will help debugging for user who made a mistake. I also see something 
similar
in drm_mode_atomic_ioctl around line 2122 -

/* can't test and expect an event at the same time. */
if ((arg->flags & DRM_MODE_ATOMIC_TEST_ONLY) &&
(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
return -EINVAL;

Thanks,
Andrey
>>> Signed-off-by: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/drm_atomic.c | 13 ++++++++++++-
>>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>>> index a567310..32eae1c 100644
>>> --- a/drivers/gpu/drm/drm_atomic.c
>>> +++ b/drivers/gpu/drm/drm_atomic.c
>>> @@ -1933,7 +1933,7 @@ static int prepare_crtc_signaling(struct drm_device *dev,
>>>   {
>>>   	struct drm_crtc *crtc;
>>>   	struct drm_crtc_state *crtc_state;
>>> -	int i, ret;
>>> +	int i, c = 0, ret;
>>>   
>>>   	if (arg->flags & DRM_MODE_ATOMIC_TEST_ONLY)
>>>   		return 0;
>>> @@ -1994,8 +1994,17 @@ static int prepare_crtc_signaling(struct drm_device *dev,
>>>   
>>>   			crtc_state->event->base.fence = fence;
>>>   		}
>>> +
>>> +		c++;
>> Not sure if intentional, but I like it.
>>
>>>   	}
>>>   
>>> +	/*
>>> +	 * Having this flag means user mode pends on event which will never
>>> +	 * reach due to lack of at least one CRTC for signaling
>>> +	 */
>>> +	if (c == 0 && (arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
>>> +		return -EINVAL;
>>> +
>>>   	return 0;
>>>   }
>>>   
>>> @@ -2179,6 +2188,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>>>   		drm_mode_object_unreference(obj);
>>>   	}
>>>   
>>> +
>>> +
>> Remove these extraneous newlines.
>>
>> Harry
>>
>>>   	ret = prepare_crtc_signaling(dev, state, arg, file_priv, &fence_state,
>>>   				     &num_fences);
>>>   	if (ret)
>>>


--------------CA32949480719FBED6879A48
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 06/19/2017 03:24 PM, Sean Paul
      wrote:<br>
    </div>
    <blockquote cite="mid:20170619192431.tbsntjjdkianx2kc@art_vandelay"
      type="cite">
      <pre wrap="">On Mon, Jun 19, 2017 at 11:35:28AM -0400, Harry Wentland wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On 2017-06-09 05:30 PM, Andrey Grodzovsky wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Problem:
While running IGT kms_atomic_transition test suite i encountered
a hang in drmHandleEvent immidietly follwoing an atomic_commit.
</pre>
        </blockquote>
        <pre wrap="">
s/immidietly/immediately/g
s/follwoing/following/g

</pre>
        <blockquote type="cite">
          <pre wrap="">After dumping the atomic state I relized that in this case there was
not even one CRTC attached to the state and only disabled
planes. This probably due to a commit which hadn't changed any property
which would require attaching crtc state. This means drmHandleEvent
will never wake up from read since without CRTC in atomic state
the event fd will not be singnaled.
</pre>
        </blockquote>
        <pre wrap="">
s/singnaled/signaled/g

</pre>
        <blockquote type="cite">
          <pre wrap="">This point to a bug in IGT but also DRM should gracefully
fail  such scenario so no hang on user side will happen.

</pre>
        </blockquote>
        <pre wrap="">
Can we create an IGT fix for this to make sure this won't happen?

</pre>
        <blockquote type="cite">
          <pre wrap="">Fix:
Explicitly fail by failing atomic_commit early in
drm_mode_atomic_commit where such problem can be identified.

</pre>
        </blockquote>
        <pre wrap="">
The change seems reasonable to me but I would like to see some input
from someone who's more familiar with the usermode side of things.
</pre>
      </blockquote>
      <pre wrap="">
I wonder if there's ever a case where it might be desirable to generate an event
from a commit without a crtc. I don't know if anyone has explicitly said that an
event can only be generated from state with crtc.</pre>
    </blockquote>
    For a generic event i agree, bit seems to me without active CRTC no
    way you <br>
    can  expect PAGE_FLIP_EVENT to fire.<br>
    <blockquote cite="mid:20170619192431.tbsntjjdkianx2kc@art_vandelay"
      type="cite">
      <pre wrap="">

I usually don't mind letting userspace shoot itself in the foot, so keep that in
mind :)

Sean</pre>
    </blockquote>
    <br>
    Seems to me you still would try to avoid a bad configuration,
    returning error<br>
    will help debugging for user who made a mistake. I also see
    something similar<br>
    in drm_mode_atomic_ioctl around line 2122 - <br>
    <meta http-equiv="content-type" content="text/html;
      charset=windows-1252">
    <meta http-equiv="content-type" content="text/html;
      charset=windows-1252">
    <pre wrap=""><span class="cm" style="box-sizing: inherit; color: slategray; font-style: italic;">/* can't test and expect an event at the same time. */</span>
<span class="cm" style="box-sizing: inherit; color: slategray; font-style: italic;">if ((arg-&gt;flags &amp; DRM_MODE_ATOMIC_TEST_ONLY) &amp;&amp;</span>
<span class="cm" style="box-sizing: inherit; color: slategray; font-style: italic;">		(arg-&gt;flags &amp; DRM_MODE_PAGE_FLIP_EVENT))</span>
<span class="cm" style="box-sizing: inherit; color: slategray; font-style: italic;">			return -EINVAL;</span><span class="p" style="box-sizing: inherit; color: rgb(102, 102, 102);"></span>
</pre>
    <font size="-1">Thanks,</font><font size="+1"><font size="-1"><br>
        Andrey</font> </font><br>
    <blockquote cite="mid:20170619192431.tbsntjjdkianx2kc@art_vandelay"
      type="cite">
      <blockquote type="cite">
        <pre wrap="">
</pre>
        <blockquote type="cite">
          <pre wrap="">Signed-off-by: Andrey Grodzovsky <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a>
---
 drivers/gpu/drm/drm_atomic.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index a567310..32eae1c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1933,7 +1933,7 @@ static int prepare_crtc_signaling(struct drm_device *dev,
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
-	int i, ret;
+	int i, c = 0, ret;
 
 	if (arg-&gt;flags &amp; DRM_MODE_ATOMIC_TEST_ONLY)
 		return 0;
@@ -1994,8 +1994,17 @@ static int prepare_crtc_signaling(struct drm_device *dev,
 
 			crtc_state-&gt;event-&gt;base.fence = fence;
 		}
+
+		c++;
</pre>
        </blockquote>
        <pre wrap="">
Not sure if intentional, but I like it.

</pre>
        <blockquote type="cite">
          <pre wrap=""> 	}
 
+	/*
+	 * Having this flag means user mode pends on event which will never
+	 * reach due to lack of at least one CRTC for signaling
+	 */
+	if (c == 0 &amp;&amp; (arg-&gt;flags &amp; DRM_MODE_PAGE_FLIP_EVENT))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2179,6 +2188,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 		drm_mode_object_unreference(obj);
 	}
 
+
+
</pre>
        </blockquote>
        <pre wrap="">
Remove these extraneous newlines.

Harry

</pre>
        <blockquote type="cite">
          <pre wrap=""> 	ret = prepare_crtc_signaling(dev, state, arg, file_priv, &amp;fence_state,
 				     &amp;num_fences);
 	if (ret)

</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------CA32949480719FBED6879A48--

--===============0482437771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0482437771==--
