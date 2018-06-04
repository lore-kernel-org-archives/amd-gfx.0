From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3 1/2] drm/scheduler: Avoid using wait_event_killable for
 dying process.
Date: Mon, 4 Jun 2018 14:03:02 -0400
Message-ID: <707e5e63-ba88-0cb7-c8b0-5b4bed550d0c@amd.com>
References: <1528124636-17283-1-git-send-email-andrey.grodzovsky@amd.com>
 <e765149d-99a7-10ce-0669-e978acf7044a@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1389495162=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e765149d-99a7-10ce-0669-e978acf7044a-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1389495162==
Content-Type: multipart/alternative;
 boundary="------------A90A933482DF2450FBE61D0D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A90A933482DF2450FBE61D0D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I reread the documentation for wait_event_timeout, my bad, all this time 
i assumed it returns

amount of jiffies he spent in waiting while actually it returns "the 
remaining jiffies (at least 1)

if the @condition evaluated
  * to %true before the @timeout elapsed."

Will fix that, please take a look also at the second patch.

Andrey


On 06/04/2018 01:53 PM, Christian König wrote:
>> +            ret = wait_event_timeout(
>> +                    sched->job_scheduled,
>> +                    drm_sched_entity_is_idle(entity),
>> +                    timeout);
>> +
>> +            ret = ret ? timeout - ret : ret;
>
> Ok we still seem to have a misunderstanding here what 
> wait_event_timeout() returns.
>
> As far as I know that line shouldn't be necessary and is actually 
> quite harmful.
>
> Apart from that this patch looks fine to me now,
> Christian.


--------------A90A933482DF2450FBE61D0D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>I reread the documentation for wait_event_timeout, my bad, all
      this time i assumed it returns</p>
    <p>amount of jiffies he spent in waiting while actually it returns
      "the remaining jiffies (at least 1) <br>
    </p>
    <p>if the @condition evaluated<br>
       * to %true before the @timeout elapsed."</p>
    <p>Will fix that, please take a look also at the second patch.<br>
    </p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 06/04/2018 01:53 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:e765149d-99a7-10ce-0669-e978acf7044a-5C7GfCeVMHo@public.gmane.org">
      <blockquote type="cite" style="color: #000000;">+            ret =
        wait_event_timeout(
        <br>
        +                    sched-&gt;job_scheduled,
        <br>
        +                    drm_sched_entity_is_idle(entity),
        <br>
        +                    timeout);
        <br>
        +
        <br>
        +            ret = ret ? timeout - ret : ret;
        <br>
      </blockquote>
      <br>
      Ok we still seem to have a misunderstanding here what
      wait_event_timeout() returns.
      <br>
      <br>
      As far as I know that line shouldn't be necessary and is actually
      quite harmful.
      <br>
      <br>
      Apart from that this patch looks fine to me now,
      <br>
      Christian.</blockquote>
    <br>
  </body>
</html>

--------------A90A933482DF2450FBE61D0D--

--===============1389495162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1389495162==--
