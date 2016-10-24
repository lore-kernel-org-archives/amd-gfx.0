From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH] drm/amdgpu: update kernel-doc for some functions
Date: Mon, 24 Oct 2016 11:14:23 +0200
Message-ID: <db14a045-b135-4e2a-f67b-867f8a50296f@vodafone.de>
References: <1477247507-11378-5-git-send-email-notasas@gmail.com>
 <20d1f285-6a45-fe57-404a-1974b4e62a49@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1091497105=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20d1f285-6a45-fe57-404a-1974b4e62a49@folklore1984.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Edward O'Callaghan <funfunctor@folklore1984.net>, Grazvydas Ignotas <notasas@gmail.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============1091497105==
Content-Type: multipart/alternative;
 boundary="------------5B46B49F796216C0BCC9CD45"

This is a multi-part message in MIME format.
--------------5B46B49F796216C0BCC9CD45
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig@amd.com>.

Am 24.10.2016 um 00:29 schrieb Edward O'Callaghan:
> Reviewed-by: Edward O'Callaghan <funfunctor@folklore1984.net>
>
> On 10/24/2016 05:31 AM, Grazvydas Ignotas wrote:
>> The names were wrong.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/scheduler/sched_fence.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/scheduler/sched_fence.c b/drivers/gpu/drm/amd/scheduler/sched_fence.c
>> index 6b63bea..3653b5a 100644
>> --- a/drivers/gpu/drm/amd/scheduler/sched_fence.c
>> +++ b/drivers/gpu/drm/amd/scheduler/sched_fence.c
>> @@ -103,7 +103,7 @@ static void amd_sched_fence_free(struct rcu_head *rcu)
>>   }
>>   
>>   /**
>> - * amd_sched_fence_release - callback that fence can be freed
>> + * amd_sched_fence_release_scheduled - callback that fence can be freed
>>    *
>>    * @fence: fence
>>    *
>> @@ -118,7 +118,7 @@ static void amd_sched_fence_release_scheduled(struct fence *f)
>>   }
>>   
>>   /**
>> - * amd_sched_fence_release_scheduled - drop extra reference
>> + * amd_sched_fence_release_finished - drop extra reference
>>    *
>>    * @f: fence
>>    *
>>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--------------5B46B49F796216C0BCC9CD45
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>.<br>
      <br>
      Am 24.10.2016 um 00:29 schrieb Edward O'Callaghan:<br>
    </div>
    <blockquote
      cite="mid:20d1f285-6a45-fe57-404a-1974b4e62a49@folklore1984.net"
      type="cite">
      <pre wrap="">Reviewed-by: Edward O'Callaghan <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor@folklore1984.net">&lt;funfunctor@folklore1984.net&gt;</a>

On 10/24/2016 05:31 AM, Grazvydas Ignotas wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">The names were wrong.

Signed-off-by: Grazvydas Ignotas <a class="moz-txt-link-rfc2396E" href="mailto:notasas@gmail.com">&lt;notasas@gmail.com&gt;</a>
---
 drivers/gpu/drm/amd/scheduler/sched_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/scheduler/sched_fence.c b/drivers/gpu/drm/amd/scheduler/sched_fence.c
index 6b63bea..3653b5a 100644
--- a/drivers/gpu/drm/amd/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/amd/scheduler/sched_fence.c
@@ -103,7 +103,7 @@ static void amd_sched_fence_free(struct rcu_head *rcu)
 }
 
 /**
- * amd_sched_fence_release - callback that fence can be freed
+ * amd_sched_fence_release_scheduled - callback that fence can be freed
  *
  * @fence: fence
  *
@@ -118,7 +118,7 @@ static void amd_sched_fence_release_scheduled(struct fence *f)
 }
 
 /**
- * amd_sched_fence_release_scheduled - drop extra reference
+ * amd_sched_fence_release_finished - drop extra reference
  *
  * @f: fence
  *

</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
dri-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/dri-devel">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------5B46B49F796216C0BCC9CD45--

--===============1091497105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1091497105==--
