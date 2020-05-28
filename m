Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43740C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 19:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFCF208A7
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K82KT3hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFCF208A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CD06E0B7;
	Thu, 28 May 2020 19:35:54 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653BB6E0B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 19:35:53 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id v15so13516897qvr.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2vcnhV6xPNC3wNkvFlRegZyVBksXFCrZ8fjwORI+ySM=;
 b=K82KT3hdISKY2Pvly9+bycu9qwEVi2Ka0sNvtFNV+02NY0dFBZx3BLlNYpVhryc9Nz
 LKaknPT7aNzYlEfObI3x6aHOSFNg+yYTkFg5zDriztYu47CgRSvAFGKHIZFu5BNwsi4i
 x4SPggTTa1lewPAEJHWpP+AXkcwXFsbRQPxIsNTTkhOLCKgZbUH2aX6cPtRxGRb8dW6x
 gTS2cT9WitgxrHAJUc4o1xZKt7dRr/NT5GvZu2BwugQiOx5il1qrYj8qr1ny7nhL7DOu
 hoyna7QOVWbsRy9Gk5CRk9m0/MWRV7nvJx4C0oZ3KXBB93+sSAMMB+rImMBS7Ed5fnyu
 cQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2vcnhV6xPNC3wNkvFlRegZyVBksXFCrZ8fjwORI+ySM=;
 b=GQWn2WHMM/gHqLjnoyzZH2ZkqTR3c3HKVlzqkOK6QFG9D4P5kUJ4noXTbdOFQHZQkh
 EittUvuiCWida24bKldHdSwWBR0g+7JzSUK0USp2GKqvy1fOUW+Hynlp4kR/w+KRHNRg
 hR4xfDbhNh13rJ3Wr1csd3Oh1UVFslkoUc9XcCqtvZRBFapiFik7S3qeGQEjct3zt4PP
 0ffN5rxYJPaAXzXYnWYCCNjdu78Vg3DmnlqVwoAzaITm+fT9yWpdZwSxdGiHmCqgoj8i
 oVlYuSHN/5SbPIfM20mltzGcmQzmrUK2+d6AhsD5VYMjKR9VHB2c6lA60shLvZOni2W5
 DWQg==
X-Gm-Message-State: AOAM533MiWfFYr3x5JLjE5EO+XWAipI9B1Qj0kjraxceJgD/wOXerocE
 zqZqYhAwuR2sTGKIkCzMSH46eCQLx+G/jeEMaFn06oi1LWw=
X-Google-Smtp-Source: ABdhPJz0hJ2Abup+W8ALAVgC0RTpXJ8IfqFV71Ek94+UtUaf9LKxg4e+JpGGoVjUIjVC4N6nV6bmA6a4bEXbxEX+XEE=
X-Received: by 2002:a17:902:9007:: with SMTP id
 a7mr5425389plp.194.1590694551632; 
 Thu, 28 May 2020 12:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A5Kv9oB7TnoAKSLfuB7unYZzgggSY=BaNyHZq0Fvi+5Qw@mail.gmail.com>
 <CAAxE2A7wy4CBevdHwQzGgYFZHkEUP4Fokj2CzET9GmJWHA+kww@mail.gmail.com>
 <1b4cc0a0-b690-3f54-d983-76975fe788bf@gmail.com>
 <e2f2843b-db9f-bba3-1925-55af2a68432d@daenzer.net>
 <1adb6ee4-7472-fa3e-fd67-6e5c6668cbc3@amd.com>
 <CAAxE2A4-5RT==eUzsO+jciucJ1t1aw+Fb=zoi9YB9q2fz1ZaSQ@mail.gmail.com>
 <c352b59e-b0ba-390d-f532-71c0380760e4@amd.com>
In-Reply-To: <c352b59e-b0ba-390d-f532-71c0380760e4@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 28 May 2020 15:35:15 -0400
Message-ID: <CAAxE2A7ORPncQnr98Z_N5uG7rPGzEh6yXUqw-=L9QRh1-ne4+w@mail.gmail.com>
Subject: Re: amdgpu doesn't do implicit sync, requires drivers to do it in IBs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/mixed; boundary="===============0259078585=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0259078585==
Content-Type: multipart/alternative; boundary="000000000000b23de405a6ba6fb1"

--000000000000b23de405a6ba6fb1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 2:12 PM Christian K=C3=B6nig <christian.koenig@amd.=
com>
wrote:

> Am 28.05.20 um 18:06 schrieb Marek Ol=C5=A1=C3=A1k:
>
> On Thu, May 28, 2020 at 10:40 AM Christian K=C3=B6nig <christian.koenig@a=
md.com>
> wrote:
>
>> Am 28.05.20 um 12:06 schrieb Michel D=C3=A4nzer:
>> > On 2020-05-28 11:11 a.m., Christian K=C3=B6nig wrote:
>> >> Well we still need implicit sync [...]
>> > Yeah, this isn't about "we don't want implicit sync", it's about "amdg=
pu
>> > doesn't ensure later jobs fully see the effects of previous implicitly
>> > synced jobs", requiring userspace to do pessimistic flushing.
>>
>> Yes, exactly that.
>>
>> For the background: We also do this flushing for explicit syncs. And
>> when this was implemented 2-3 years ago we first did the flushing for
>> implicit sync as well.
>>
>> That was immediately reverted and then implemented differently because
>> it caused severe performance problems in some use cases.
>>
>> I'm not sure of the root cause of this performance problems. My
>> assumption was always that we then insert to many pipeline syncs, but
>> Marek doesn't seem to think it could be that.
>>
>> On the one hand I'm rather keen to remove the extra handling and just
>> always use the explicit handling for everything because it simplifies
>> the kernel code quite a bit. On the other hand I don't want to run into
>> this performance problem again.
>>
>> Additional to that what the kernel does is a "full" pipeline sync, e.g.
>> we busy wait for the full hardware pipeline to drain. That might be
>> overkill if you just want to do some flushing so that the next shader
>> sees the stuff written, but I'm not an expert on that.
>>
>
> Do we busy-wait on the CPU or in WAIT_REG_MEM?
>
> WAIT_REG_MEM is what UMDs do and should be faster.
>
>
> We use WAIT_REG_MEM to wait for an EOP fence value to reach memory.
>
> We use this for a couple of things, especially to make sure that the
> hardware is idle before changing VMID to page table associations.
>
> What about your idea of having an extra dw in the shared BOs indicating
> that they are flushed?
>
> As far as I understand it an EOS or other event might be sufficient for
> the caches as well. And you could insert the WAIT_REG_MEM directly before
> the first draw using the texture and not before the whole IB.
>
> Could be that we can optimize this even more than what we do in the kerne=
l.
>
> Christian.
>

Adding fences into BOs would be bad, because all UMDs would have to handle
them.

Is it possible to do this in the ring buffer:
if (fence_signalled) {
   indirect_buffer(dependent_IB);
   indirect_buffer(other_IB);
} else {
   indirect_buffer(other_IB);
   wait_reg_mem(fence);
   indirect_buffer(dependent_IB);
}

Or we might have to wait for a hw scheduler.

Does the kernel sync when the driver fd is different, or when the context
is different?

Marek

--000000000000b23de405a6ba6fb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, May 28, 2020 at 2:12 PM Christian K=C3=B6nig &lt;<a href=3D"=
mailto:christian.koenig@amd.com">christian.koenig@amd.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">

 =20
  <div bgcolor=3D"#FFFFFF">
    <div>Am 28.05.20 um 18:06 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 28, 2020 at
            10:40 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.k=
oenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 28.05.20 um =
12:06
            schrieb Michel D=C3=A4nzer:<br>
            &gt; On 2020-05-28 11:11 a.m., Christian K=C3=B6nig wrote:<br>
            &gt;&gt; Well we still need implicit sync [...]<br>
            &gt; Yeah, this isn&#39;t about &quot;we don&#39;t want implici=
t sync&quot;,
            it&#39;s about &quot;amdgpu<br>
            &gt; doesn&#39;t ensure later jobs fully see the effects of
            previous implicitly<br>
            &gt; synced jobs&quot;, requiring userspace to do pessimistic
            flushing.<br>
            <br>
            Yes, exactly that.<br>
            <br>
            For the background: We also do this flushing for explicit
            syncs. And <br>
            when this was implemented 2-3 years ago we first did the
            flushing for <br>
            implicit sync as well.<br>
            <br>
            That was immediately reverted and then implemented
            differently because <br>
            it caused severe performance problems in some use cases.<br>
            <br>
            I&#39;m not sure of the root cause of this performance problems=
.
            My <br>
            assumption was always that we then insert to many pipeline
            syncs, but <br>
            Marek doesn&#39;t seem to think it could be that.<br>
            <br>
            On the one hand I&#39;m rather keen to remove the extra handlin=
g
            and just <br>
            always use the explicit handling for everything because it
            simplifies <br>
            the kernel code quite a bit. On the other hand I don&#39;t want
            to run into <br>
            this performance problem again.<br>
            <br>
            Additional to that what the kernel does is a &quot;full&quot; p=
ipeline
            sync, e.g. <br>
            we busy wait for the full hardware pipeline to drain. That
            might be <br>
            overkill if you just want to do some flushing so that the
            next shader <br>
            sees the stuff written, but I&#39;m not an expert on that.<br>
          </blockquote>
          <div><br>
          </div>
          <div>Do we busy-wait on the CPU or in WAIT_REG_MEM?</div>
          <div><br>
          </div>
          <div>WAIT_REG_MEM is what UMDs do and should be faster.</div>
        </div>
      </div>
    </blockquote>
    <br>
    We use WAIT_REG_MEM to wait for an EOP fence value to reach memory.<br>
    <br>
    We use this for a couple of things, especially to make sure that the
    hardware is idle before changing VMID to page table associations.<br>
    <br>
    What about your idea of having an extra dw in the shared BOs
    indicating that they are flushed?<br>
    <br>
    As far as I understand it an EOS or other event might be sufficient
    for the caches as well. And you could insert the WAIT_REG_MEM
    directly before the first draw using the texture and not before the
    whole IB.<br>
    <br>
    Could be that we can optimize this even more than what we do in the
    kernel.<br>
    <br>
    Christian.<br></div></blockquote><div><br></div>Adding fences into BOs =
would be bad, because all UMDs would have to handle them.</div><div class=
=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Is it possible to do =
this in the ring buffer:</div><div class=3D"gmail_quote">if (fence_signalle=
d) {</div><div class=3D"gmail_quote"><div class=3D"gmail_quote">=C2=A0=C2=
=A0 indirect_buffer(dependent_IB);<br></div>=C2=A0=C2=A0 indirect_buffer(ot=
her_IB);<br></div><div class=3D"gmail_quote">} else {</div><div class=3D"gm=
ail_quote">=C2=A0=C2=A0 indirect_buffer(other_IB);</div><div class=3D"gmail=
_quote">=C2=A0=C2=A0 wait_reg_mem(fence);<br></div><div class=3D"gmail_quot=
e">=C2=A0=C2=A0 indirect_buffer(dependent_IB);<br></div>}<div class=3D"gmai=
l_quote"><br></div><div class=3D"gmail_quote">Or we might have to wait for =
a hw scheduler.<br></div><div class=3D"gmail_quote"><br></div><div class=3D=
"gmail_quote"><div class=3D"gmail_quote">Does the kernel sync when the driv=
er fd is different, or when the context is different?</div><div class=3D"gm=
ail_quote"><br></div></div><div class=3D"gmail_quote">Marek<br></div></div>

--000000000000b23de405a6ba6fb1--

--===============0259078585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0259078585==--
