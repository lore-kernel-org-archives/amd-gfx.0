From: Lionel Landwerlin <lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/9] drm/syncobj: add support for timeline point wait v8
Date: Mon, 18 Mar 2019 18:19:12 +0000
Message-ID: <1a9d1138-5638-932d-7cd3-9325c2ae31c5@intel.com>
References: <20190315120959.25489-1-david1.zhou@amd.com>
 <20190315120959.25489-3-david1.zhou@amd.com>
 <5b68b54a-5d8d-9666-bd45-aa53b6b295e7@intel.com>
 <990db9e7-6cae-1165-637c-84aed3a9af49@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1620600533=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <990db9e7-6cae-1165-637c-84aed3a9af49-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org" <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
Cc: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>, Daniel Rakos <Daniel.Rakos-5C7GfCeVMHo@public.gmane.org>, Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>

This is a multi-part message in MIME format.
--===============1620600533==
Content-Type: multipart/alternative;
 boundary="------------7EF774120FD8B08EDF906EDF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7EF774120FD8B08EDF906EDF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/03/2019 17:20, Koenig, Christian wrote:
>>>    -        if (dma_fence_is_signaled(entries[i].fence)) {
>>> +        if (fence)
>>> +            entries[i].fence = fence;
>>> +        else
>>> +            entries[i].fence = dma_fence_get_stub();
>>> +
>>> +        if ((flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE) ||
>> Hey David,
>>
>> Could you remind me what DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE is used
>> for?
>>
>> I didn't have a use for it in userspace,
> The flag is used to wait for fences for a sequence number to show up.
>
> Christian.
>

Thanks Christian.

I guess I missed the additive nature of WAIT_FOR_SUBMIT.


It feels like WAIT_AVAILABLE almost deserves its own commit as it 
affects both timelines & binary syncobjs.


-Lionel


--------------7EF774120FD8B08EDF906EDF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 18/03/2019 17:20, Koenig, Christian
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:990db9e7-6cae-1165-637c-84aed3a9af49-5C7GfCeVMHo@public.gmane.org">
      <blockquote type="cite" style="color: #000000;">
        <blockquote type="cite" style="color: #000000;">
          <pre class="moz-quote-pre" wrap="">  -        if (dma_fence_is_signaled(entries[i].fence)) {
+        if (fence)
+            entries[i].fence = fence;
+        else
+            entries[i].fence = dma_fence_get_stub();
+
+        if ((flags &amp; DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE) ||
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Hey David,

Could you remind me what DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE is used 
for?

I didn't have a use for it in userspace,
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">The flag is used to wait for fences for a sequence number to show up.

Christian.

</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Thanks Christian.</p>
    <p>I guess I missed the additive nature of WAIT_FOR_SUBMIT.</p>
    <p><br>
    </p>
    <p>It feels like WAIT_AVAILABLE almost deserves its own commit as it
      affects both timelines &amp; binary syncobjs.</p>
    <p><br>
    </p>
    <p>-Lionel</p>
  </body>
</html>

--------------7EF774120FD8B08EDF906EDF--

--===============1620600533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1620600533==--
