Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB9C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 22:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4773D20663
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 22:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiBXbIbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4773D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D002B6E201;
	Fri, 12 Jun 2020 22:30:12 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989806E201
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 22:30:11 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id i4so4452546pjd.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qaA3b7leNpYbme1fx1m2p6LoBu5wUHPR+kZ/cTigF20=;
 b=kiBXbIbquichWBqhB0ce0SZ+NsvxWKu1iGP8vRpQm7qM1FyUv63t0MKSDcwaURWAmj
 Dr34zUw+j9HopexJjNdSabnCui98S8MZhNc6ZVYlFX0rXcLH2S0GUicJuHdcifedV3Zf
 KP8B3xHhZ5qYzSpfuyrSpIs3uTLcM+VcbtgUoPmA3h/Vuaayz19SyLCH9YcoIKlVcckh
 WWKaxO2iSxY/hMQht773XHC/KvHpa9Tqv+3KQ4A9gOraIhAaGbi4cDxISYU7aDga391U
 EadjA64iCraA1LGmM/YXwACD7IFV/y05KNABYe8TazfUzujAj6Y8ja4uTYksC0HsIEyw
 uhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qaA3b7leNpYbme1fx1m2p6LoBu5wUHPR+kZ/cTigF20=;
 b=JpLiWrWFgYvQdLUallP8xait9lmCziATfVmf+vyNcrlw/8e0JUlTnzPLCFgjEksnLg
 zmuw4WUmoD+Zxmrmln6aQeNGlvyzJ3PMz6aF6TFgSBi3LULU2TBwNtk9+0ZClRlkC5/x
 F7PV22lMz+IjhsacyrMy61wF6NSUm1YNKXSxABy+kVjTAZCcciBdCh87vmON0m334i7K
 pdApD0/xWkihTDBoZSC3/GddYOFyVqx0wlMUgKSdy0I8kg1zQWY8UoWgH9zV7MN/Nb+3
 dqBUJZdMskH7qeKj1EUOvt8Jpjpfc6atmjhChM6iJdBd2DR75g5j58baV+u0MCDurCYt
 TcCQ==
X-Gm-Message-State: AOAM533oJi/gIYorkBl1/901lubZr8aPPfIoexO3+Do0dW+tQAsWtp+G
 6StJE6KW4hg8MrHNLDWSAk1mb1AlYKcQuSML144exg==
X-Google-Smtp-Source: ABdhPJzGekBX/y/adH4sAmu2HFP8yh8reZexe0EitWmI2FICylcmLBEwG4CPcp//37ThjNIakyR6zIu3VyQwvHuBNnU=
X-Received: by 2002:a17:90b:190e:: with SMTP id
 mp14mr999669pjb.198.1592001010902; 
 Fri, 12 Jun 2020 15:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A6T-hGWE7r_aFVmPyO__wh5kptbJiJ7rYd7dFg2TH2BKw@mail.gmail.com>
 <DM5PR12MB24405F71791676A64CB02D9EB4830@DM5PR12MB2440.namprd12.prod.outlook.com>
 <b47f193a-9103-ca7b-85e6-c8a52a977da8@gmail.com>
 <82cfde02-d2e4-35fe-f790-7ce63145aacc@amd.com>
 <CAAxE2A4JsmQL8kUA1Z0aq3sK86D3oJ54YkRe=yEo1AXJ1MT-yg@mail.gmail.com>
 <161297ae-c098-27fe-ed80-2b46f64c1065@amd.com>
In-Reply-To: <161297ae-c098-27fe-ed80-2b46f64c1065@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 12 Jun 2020 18:29:34 -0400
Message-ID: <CAAxE2A6UzvbR3SniEt=YvjJB2i1tjFy5Obiuz2B6NnWV1Lmp_g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove distinction between explicit and
 implicit sync (v2)
To: Chunming Zhou <zhoucm1@amd.com>
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
Cc: "Zhou, David\(ChunMing\)" <david1.zhou@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0671591083=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0671591083==
Content-Type: multipart/alternative; boundary="000000000000bcac7c05a7ea9e91"

--000000000000bcac7c05a7ea9e91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The usage is that UMDs will no longer have to wait for idle at the end of
IBs. If you have WAIT_REG_MEM or PS/CS_PARTIAL_FLUSH at the end of IBs, you
can remove that. The responsibility to sync is taken over by the kernel
driver.

This has a potential to increase performance for fullscreen applications,
because the kernel will sync only when the sync is required for
inter-process sharing, which is never for fullscreen apps.

Also if 2 or more windowed apps are rendering, there will be no longer any
sync when switching from one process to the next in the gfx ring. The sync
will only happen before the compositor starts drawing the fullscreen frame.
Therefore, the windowed apps running in parallel should run faster.

If the UMD syncs at the beginning of IBs (common e.g. with DCC fast clear),
there will be no improvement in performance. For any improvement to be
there, UMDs shouldn't sync at the beginning of IBs either, but this may not
always be possible. (a fast color clear needs a sync, while a fast Z/S
clear doesn't)

Marek

On Thu, Jun 11, 2020 at 8:13 AM Chunming Zhou <zhoucm1@amd.com> wrote:

> I didn't check the patch details, if it is for existing implicit sync of
> shared buffer, feel free go ahead.
>
> But if you add some description for its usage, that will be more clear to
> others.
>
> -David
> =E5=9C=A8 2020/6/11 15:19, Marek Ol=C5=A1=C3=A1k =E5=86=99=E9=81=93:
>
> Hi David,
>
> Explicit sync has nothing to do with this. This is for implicit sync,
> which is required by DRI3. This fix allows removing existing inefficienci=
es
> from drivers, so it's a good thing.
>
> Marek
>
> On Wed., Jun. 10, 2020, 03:56 Chunming Zhou, <zhoucm1@amd.com> wrote:
>
>>
>> =E5=9C=A8 2020/6/10 15:41, Christian K=C3=B6nig =E5=86=99=E9=81=93:
>>
>> That's true, but for now we are stuck with the implicit sync for quite a
>> number of use cases.
>>
>> My problem is rather that we already tried this and it backfired
>> immediately.
>>
>> I do remember that it was your patch who introduced the pipeline sync
>> flag handling and I warned that this could be problematic. You then came
>> back with a QA result saying that this is indeed causing a huge performa=
nce
>> drop in one test case and we need to do something else. Together we then
>> came up with the different handling between implicit and explicit sync.
>>
>> Isn't pipeline sync flag to fix some issue because of parralel execution
>> between jobs in one pipeline?  I really don't have this memory in mind w=
hy
>> that's realted to this, Or do you mean extra sync hides many other
>> potential issues?
>>
>> Anyway, when I go through Vulkan WSI code, the synchronization isn't so
>> smooth between OS window system. And when I saw Jason drives explicit sy=
nc
>> through the whole Linux ecosystem like Android window system does, I fee=
l
>> that's really a good direction.
>>
>> -David
>>
>>
>> But I can't find that stupid mail thread any more. I knew that it was a
>> couple of years ago when we started with the explicit sync for Vulkan.
>>
>> Christian.
>>
>> Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>>
>> Not sue if this is right direction, I think usermode wants all
>> synchronizations to be explicit. Implicit sync often confuses people who
>> don=E2=80=99t know its history. I remember Jason from Intel  is driving =
explicit
>> synchronization through the Linux ecosystem, which even removes implicit
>> sync of shared buffer.
>>
>>
>>
>> -David
>>
>>
>>
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>> <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of *Marek Ol=C5=A1=C3=
=A1k
>> *Sent:* Tuesday, June 9, 2020 6:58 PM
>> *To:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
>> <amd-gfx@lists.freedesktop.org>
>> *Subject:* [PATCH] drm/amdgpu: remove distinction between explicit and
>> implicit sync (v2)
>>
>>
>>
>> Hi,
>>
>>
>>
>> This enables a full pipeline sync for implicit sync. It's Christian's
>> patch with the driver version bumped. With this, user mode drivers don't
>> have to wait for idle at the end of gfx IBs.
>>
>>
>>
>> Any concerns?
>>
>>
>>
>> Thanks,
>>
>> Marek
>>
>> _______________________________________________
>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskt=
op.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outlook=
.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-=
gfx&data=3D02%7C01%7CDavid1.Zhou%40amd.com%7C0d3096fc043f4443f14e08d80dd7c6=
74%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637274567683552668&sdata=3D=
xIHDswGRsdCP%2BE7MRI4nKXdoMgV2LBzFPP46zGpQusk%3D&reserved=3D0>
>>
>>
>>

--000000000000bcac7c05a7ea9e91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The usage is that UMDs will no longer have to wait fo=
r idle at the end of IBs. If you have WAIT_REG_MEM or PS/CS_PARTIAL_FLUSH a=
t the end of IBs, you can remove that. The responsibility to sync is taken =
over by the kernel driver.<br></div><div><br></div><div> This has a potenti=
al to increase performance for fullscreen applications, because the kernel =
will sync only when the sync is required for inter-process sharing, which i=
s never for fullscreen apps.</div><div><br></div><div>Also if 2 or more win=
dowed apps are rendering, there will be no longer any sync when switching f=
rom one process to the next in the gfx ring. The sync will only happen befo=
re the compositor starts drawing the fullscreen frame. Therefore, the windo=
wed apps running in parallel should run faster.</div><div><br></div><div>If=
 the UMD syncs at the beginning of IBs (common e.g. with DCC fast clear), t=
here will be no improvement in performance. For any improvement to be there=
, UMDs shouldn&#39;t sync at the beginning of IBs either, but this may not =
always be possible. (a fast color clear needs a sync, while a fast Z/S clea=
r doesn&#39;t)<br></div><div><br></div><div>Marek<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 11, 2020=
 at 8:13 AM Chunming Zhou &lt;<a href=3D"mailto:zhoucm1@amd.com" target=3D"=
_blank">zhoucm1@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">

 =20
  <div>
    <p>I didn&#39;t check the patch details, if it is for existing implicit
      sync of shared buffer, feel free go ahead.</p>
    <p>But if you add some description for its usage, that will be more
      clear to others.</p>
    <p>-David<br>
    </p>
    <div>=E5=9C=A8 2020/6/11 15:19, Marek Ol=C5=A1=C3=A1k =E5=86=99=E9=81=
=93:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"auto">Hi David,
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Explicit sync has nothing to do with this. This
          is for implicit sync, which is required by DRI3. This fix
          allows removing existing inefficiencies from drivers, so it&#39;s
          a good thing.</div>
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">Marek</div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Wed., Jun. 10, 2020, 03:56
          Chunming Zhou, &lt;<a href=3D"mailto:zhoucm1@amd.com" target=3D"_=
blank">zhoucm1@amd.com</a>&gt; wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div>
            <p><br>
            </p>
            <div>=E5=9C=A8 2020/6/10 15:41, Christian K=C3=B6nig =E5=86=99=
=E9=81=93:<br>
            </div>
            <blockquote type=3D"cite">
              <div>That&#39;s true, but for now we are stuck with the
                implicit sync for quite a number of use cases.<br>
                <br>
                My problem is rather that we already tried this and it
                backfired immediately.<br>
                <br>
                I do remember that it was your patch who introduced the
                pipeline sync flag handling and I warned that this could
                be problematic. You then came back with a QA result
                saying that this is indeed causing a huge performance
                drop in one test case and we need to do something else.
                Together we then came up with the different handling
                between implicit and explicit sync.<br>
              </div>
            </blockquote>
            <p>Isn&#39;t pipeline sync flag to fix some issue because of
              parralel execution between jobs in one pipeline?=C2=A0 I real=
ly
              don&#39;t have this memory in mind why that&#39;s realted to =
this,
              Or do you mean extra sync hides many other potential
              issues?</p>
            <p>Anyway, when I go through Vulkan WSI code, the
              synchronization isn&#39;t so smooth between OS window system.
              And when I saw Jason drives explicit sync through the
              whole Linux ecosystem like Android window system does, I
              feel that&#39;s really a good direction.</p>
            <p>-David<br>
            </p>
            <blockquote type=3D"cite">
              <div> <br>
                But I can&#39;t find that stupid mail thread any more. I
                knew that it was a couple of years ago when we started
                with the explicit sync for Vulkan.<br>
                <br>
                Christian.<br>
                <br>
                Am 10.06.20 um 08:29 schrieb Zhou, David(ChunMing):<br>
              </div>
              <blockquote type=3D"cite">
                <div>
                  <p style=3D"margin:0in 0in 0.0001pt"><span style=3D"font-=
size:10pt;font-family:&quot;Arial&quot;,sans-serif;color:rgb(0,120,215)">[A=
MD
                      Official Use Only - Internal Distribution Only]</span=
></p>
                  <p class=3D"MsoNormal">=C2=A0</p>
                  <p class=3D"MsoNormal">Not sue if this is right
                    direction, I think usermode wants all
                    synchronizations to be explicit. Implicit sync often
                    confuses people who don=E2=80=99t know its history. I
                    remember Jason from Intel =C2=A0is driving explicit
                    synchronization through the Linux ecosystem, which
                    even removes implicit sync of shared buffer.</p>
                  <p class=3D"MsoNormal">=C2=A0</p>
                  <p class=3D"MsoNormal">-David</p>
                  <p class=3D"MsoNormal">=C2=A0</p>
                  <div style=3D"border-color:rgb(225,225,225) currentcolor =
currentcolor;border-style:solid none none;border-width:1pt medium medium;pa=
dding:3pt 0in 0in">
                    <p class=3D"MsoNormal"><b>From:</b> amd-gfx <a href=3D"=
mailto:amd-gfx-bounces@lists.freedesktop.org" rel=3D"noreferrer" target=3D"=
_blank">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                      <b>On Behalf Of </b>Marek Ol=C5=A1=C3=A1k<br>
                      <b>Sent:</b> Tuesday, June 9, 2020 6:58 PM<br>
                      <b>To:</b> amd-gfx mailing list <a href=3D"mailto:amd=
-gfx@lists.freedesktop.org" rel=3D"noreferrer" target=3D"_blank">&lt;amd-gf=
x@lists.freedesktop.org&gt;</a><br>
                      <b>Subject:</b> [PATCH] drm/amdgpu: remove
                      distinction between explicit and implicit sync
                      (v2)</p>
                  </div>
                  <p class=3D"MsoNormal">=C2=A0</p>
                  <div>
                    <div>
                      <p class=3D"MsoNormal">Hi,</p>
                    </div>
                    <div>
                      <p class=3D"MsoNormal">=C2=A0</p>
                    </div>
                    <div>
                      <p class=3D"MsoNormal">This enables a full pipeline
                        sync for implicit sync. It&#39;s Christian&#39;s pa=
tch
                        with the driver version bumped. With this, user
                        mode drivers don&#39;t have to wait for idle at the
                        end of gfx IBs.</p>
                    </div>
                    <div>
                      <p class=3D"MsoNormal">=C2=A0</p>
                    </div>
                    <div>
                      <p class=3D"MsoNormal">Any concerns?</p>
                    </div>
                    <div>
                      <p class=3D"MsoNormal">=C2=A0</p>
                    </div>
                    <div>
                      <p class=3D"MsoNormal">Thanks,</p>
                    </div>
                    <div>
                      <p class=3D"MsoNormal">Marek</p>
                    </div>
                  </div>
                </div>
                <br>
                <fieldset></fieldset>
                <pre>_______________________________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" rel=3D"noreferrer" target=
=3D"_blank">amd-gfx@lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7CDavid1.Zhou%40amd.com%7C0d3096fc043f4443f14e08d80dd7c674%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637274567683552668&amp;sdata=3DxIHDswGRsdCP%2=
BE7MRI4nKXdoMgV2LBzFPP46zGpQusk%3D&amp;reserved=3D0" rel=3D"noreferrer" tar=
get=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
              </blockquote>
              <br>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
  </div>

</blockquote></div></div>

--000000000000bcac7c05a7ea9e91--

--===============0671591083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0671591083==--
