From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Wed, 25 Apr 2018 12:13:58 -0400
Message-ID: <311660b9-9e46-b960-3088-06e16ac3838d@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
 <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com> <87tvs05mik.fsf@xmission.com>
 <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com>
 <20180425071444.GM25142@phenom.ffwll.local>
 <94828a42-02dd-29ad-a3d0-dc4c0cc82ddb@amd.com> <87a7trwbh0.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1335928257=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <87a7trwbh0.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David.Panariti@amd.com, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, oleg@redhat.com, dri-devel@lists.freedesktop.org, Alexander.Deucher@amd.com, akpm@linux-foundation.org, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============1335928257==
Content-Type: multipart/alternative;
 boundary="------------A8AF598B092F571358D5FB27"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A8AF598B092F571358D5FB27
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/25/2018 11:29 AM, Eric W. Biederman wrote:
>> Another issue is changing wait_event_killable to wait_event_timeout where I need
>> to understand
>> what TO value is acceptable for all the drivers using the scheduler, or maybe it
>> should come as a property
>> of drm_sched_entity.
> It would not surprise me if you could pick a large value like 1 second
> and issue a warning if that time outever triggers.  It sounds like the
> condition where we wait indefinitely today is because something went
> wrong in the driver.

We wait here for all GPU jobs in flight which belong to the dying entity 
to complete. The driver submits
the GPU jobs but the content of the job might be is not under driver's 
control and could take
long time to finish or even hang (e.g. graphic or compute shader) , I 
guess that why originally the wait is indefinite.

Andrey

>
> Eric


--------------A8AF598B092F571358D5FB27
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 04/25/2018 11:29 AM, Eric W.
      Biederman wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87a7trwbh0.fsf@xmission.com">
      <blockquote type="cite" style="color: #000000;">
        <pre wrap="">Another issue is changing wait_event_killable to wait_event_timeout where I need
to understand
what TO value is acceptable for all the drivers using the scheduler, or maybe it
should come as a property
of drm_sched_entity.
</pre>
      </blockquote>
      <pre wrap="">It would not surprise me if you could pick a large value like 1 second
and issue a warning if that time outever triggers.  It sounds like the
condition where we wait indefinitely today is because something went
wrong in the driver.</pre>
    </blockquote>
    <br>
    We wait here for all GPU jobs in flight which belong to the dying
    entity to complete. The driver submits<br>
    the GPU jobs but the content of the job might be is not under
    driver's control and could take <br>
    long time to finish or even hang (e.g. graphic or compute shader) ,
    I guess that why originally the wait is indefinite.<br>
    <br>
    Andrey<br>
    <br>
    <blockquote type="cite" cite="mid:87a7trwbh0.fsf@xmission.com">
      <pre wrap="">

Eric
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------A8AF598B092F571358D5FB27--

--===============1335928257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1335928257==--
