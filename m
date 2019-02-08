From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/sched: Always trace the dependencies we wait on, to
 fix a race.
Date: Fri, 8 Feb 2019 09:43:04 +0100
Message-ID: <0d7c09cf-caeb-c706-928e-2a668ae78e53@gmail.com>
References: <20181207191653.30118-1-eric@anholt.net>
 <ba4a98f4-062e-0cb4-bd22-a0a191385f82@amd.com> <87tvhf2o0l.fsf@anholt.net>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1144892552=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <87tvhf2o0l.fsf@anholt.net>
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
To: Eric Anholt <eric@anholt.net>, "Koenig, Christian" <Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============1144892552==
Content-Type: multipart/alternative;
 boundary="------------54F459BADCFDA435A524D0A3"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------54F459BADCFDA435A524D0A3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.02.19 um 00:10 schrieb Eric Anholt:
> "Koenig, Christian" <Christian.Koenig@amd.com> writes:
>
>> Am 07.12.18 um 20:16 schrieb Eric Anholt:
>>> The entity->dependency can go away completely once we've called
>>> drm_sched_entity_add_dependency_cb() (if the cb is called before we
>>> get around to tracing).  The tracepoint is more useful if we trace
>>> every dependency instead of just ones that get callbacks installed,
>>> anyway, so just do that.
>>>
>>> Fixes any easy-to-produce OOPS when tracing the scheduler on V3D with
>>> "perf record -a -e gpu_scheduler:.\* glxgears" and DEBUG_SLAB enabled.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Going to pick that up for upstream and will add with a CC: stable.
> Looks like this got misplaced.

My fault, pushed to our internal branch now with a CC: stable tag on it.

Christian.

>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------54F459BADCFDA435A524D0A3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 08.02.19 um 00:10 schrieb Eric
      Anholt:<br>
    </div>
    <blockquote type="cite" cite="mid:87tvhf2o0l.fsf@anholt.net">
      <pre class="moz-quote-pre" wrap="">"Koenig, Christian" <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 07.12.18 um 20:16 schrieb Eric Anholt:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">The entity-&gt;dependency can go away completely once we've called
drm_sched_entity_add_dependency_cb() (if the cb is called before we
get around to tracing).  The tracepoint is more useful if we trace
every dependency instead of just ones that get callbacks installed,
anyway, so just do that.

Fixes any easy-to-produce OOPS when tracing the scheduler on V3D with
"perf record -a -e gpu_scheduler:.\* glxgears" and DEBUG_SLAB enabled.

Signed-off-by: Eric Anholt <a class="moz-txt-link-rfc2396E" href="mailto:eric@anholt.net">&lt;eric@anholt.net&gt;</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>

Going to pick that up for upstream and will add with a CC: stable.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Looks like this got misplaced.
</pre>
    </blockquote>
    <br>
    My fault, pushed to our internal branch now with a CC: stable tag on
    it.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:87tvhf2o0l.fsf@anholt.net"><br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------54F459BADCFDA435A524D0A3--

--===============1144892552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1144892552==--
