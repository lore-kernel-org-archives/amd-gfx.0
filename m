From: zhoucm1 <zhoucm1@amd.com>
Subject: Re: [PATCH] [RFC]drm: add syncobj timeline support v5
Date: Wed, 19 Sep 2018 11:20:06 +0800
Message-ID: <0231250d-0ed0-e99b-84c6-166b47a0b9cc@amd.com>
References: <20180914103747.23663-1-david1.zhou@amd.com>
 <a5d2d299-4360-4267-046e-40b550239524@amd.com>
 <29f4106d-1d10-075c-b90a-61b2da7c6957@amd.com>
 <2bea4bc7-ce1f-e1ff-8308-d932d108f237@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389076963=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2bea4bc7-ce1f-e1ff-8308-d932d108f237@gmail.com>
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
To: christian.koenig@amd.com, Chunming Zhou <david1.zhou@amd.com>, dri-devel@lists.freedesktop.org, Daniel Rakos <Daniel.Rakos@amd.com>
Cc: Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

--===============0389076963==
Content-Type: multipart/alternative;
	boundary="------------CBEBCA67879DA47E410F6C59"
Content-Language: en-US

--------------CBEBCA67879DA47E410F6C59
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年09月18日 16:32, Christian König wrote:
>>>> +    for (i = 0; i < args->count_handles; i++) {
>>>> +        if (syncobjs[i]->type == DRM_SYNCOBJ_TYPE_TIMELINE) {
>>>> +            DRM_ERROR("timeline syncobj cannot reset!\n");
>>>
>>> Why not? I mean that should still work or do I miss anything?
>> timeline semaphore spec doesn't require reset interface, it says the 
>> timeline value only can be changed by signal operations.
>
> Yeah, but we don't care about the timeline spec in the kernel.
>
> Question is rather if that still makes sense to support that and as 
> far as I can see it should be trivial to reinitialize the object. 
Hi Daniel Rakos,

Could you give a comment on this question? Is it necessary to support 
timeline reset interface?  I only see the timeline value can be changed 
by signal operations in Spec.


Thanks,
David Zhou

--------------CBEBCA67879DA47E410F6C59
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018年09月18日 16:32, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2bea4bc7-ce1f-e1ff-8308-d932d108f237@gmail.com">
      <blockquote type="cite" style="color: #000000;">
        <blockquote type="cite" style="color: #000000;">
          <blockquote type="cite" style="color: #000000;">+    for (i =
            0; i &lt; args-&gt;count_handles; i++) {
            <br>
            +        if (syncobjs[i]-&gt;type ==
            DRM_SYNCOBJ_TYPE_TIMELINE) {
            <br>
            +            DRM_ERROR("timeline syncobj cannot reset!\n");
            <br>
          </blockquote>
          <br>
          Why not? I mean that should still work or do I miss anything?
          <br>
        </blockquote>
        timeline semaphore spec doesn't require reset interface, it says
        the timeline value only can be changed by signal operations.
        <br>
      </blockquote>
      <br>
      Yeah, but we don't care about the timeline spec in the kernel.
      <br>
      <br>
      Question is rather if that still makes sense to support that and
      as far as I can see it should be trivial to reinitialize the
      object.
    </blockquote>
    Hi Daniel Rakos,<br>
    <br>
    Could you give a comment on this question? Is it necessary to
    support timeline reset interface?  I only see the timeline value can
    be changed by signal operations in Spec.<br>
    <br>
    <br>
    Thanks,<br>
    David Zhou<br>
  </body>
</html>

--------------CBEBCA67879DA47E410F6C59--

--===============0389076963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0389076963==--
