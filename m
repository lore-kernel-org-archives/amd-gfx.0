From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH 3/3] drm/amdgpu: add FENCE_TO_HANDLE ioctl that returns
 syncobj or sync_file
Date: Wed, 13 Sep 2017 15:04:29 +0200
Message-ID: <8927d6b6-f87c-00d9-57af-fdf4fb6dfcb8@vodafone.de>
References: <1505248934-1819-1-git-send-email-maraeo@gmail.com>
 <1505248934-1819-3-git-send-email-maraeo@gmail.com>
 <7413e296-b7f5-5963-b477-b04acfb4bb91@amd.com>
 <CAAxE2A7aR15Y9C2r_V_+6fTp-kEuFKwDApQRCnx_rxdsDOKtmw@mail.gmail.com>
 <MWHPR1201MB020689874960A24D32C4A39CB46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <CAAxE2A5UKZTuseX1Sqggc-XRprnfG+eQSZqbiytRyge5KJrCUg@mail.gmail.com>
 <MWHPR1201MB0206A14F0D2148D5036A9485B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2130597380=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <MWHPR1201MB0206A14F0D2148D5036A9485B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
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
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, =?UTF-8?B?TWFyZWsgT2w/6Yaf?= <maraeo@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============2130597380==
Content-Type: multipart/alternative;
 boundary="------------5C1B67DA4099A763F43EBA74"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------5C1B67DA4099A763F43EBA74
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> syncfile indeed be a good way to pass fence for user space, which already is proved in Android and is upstreamed.
Not really. syncfile needs a file descriptor for each handle it 
generates, that's quite a show stopper if you want to use it in general.

Android syncfile are meant to be used for inter process sharing, but as 
command submission sequence number they are not such a good fit.

Mareks approach looks really good to me and we should follow that 
direction further.

Regards,
Christian.

Am 13.09.2017 um 14:25 schrieb Zhou, David(ChunMing):
> Yes, to be comptibility, I kept both seq_no and syncfile fd in the patch set, you can take a look, which really is simpler and effective way.
>
> syncfile indeed be a good way to pass fence for user space, which already is proved in Android and is upstreamed.
>
> Regards,
> David Zhou
>
> 发自坚果 Pro
>
> Marek Ol?醟 <maraeo@gmail.com> 于 2017年9月13日 下午8:06写道：
>
> On Wed, Sep 13, 2017 at 1:32 PM, Zhou, David(ChunMing)
> <David1.Zhou@amd.com> wrote:
> > Could you describe how difficult to directly use CS syncfile fd in Mesa
> > compared with concerting CS seq to syncfile fd via several syncobj 
> ioctls?
>
> It just simplifies things. Mesa primarily uses seq_no-based fences and
> will continue to use them. We can't remove the seq_no fence code
> because we have to keep Mesa compatible with older kernels.
>
> The only possibilities are:
> - Mesa gets both seq_no and sync_file from CS.
> - Mesa only gets seq_no from CS.
>
> I decided to take the simpler option. I don't know if there is a perf
> difference between CS returning a sync_file and using a separate
> ioctl, but it's probably insignificant since we already call 3 ioctls
> per IB submission (BO list create+destroy, submit).
>
> Marek
>
> >
> > Regards,
> > David Zhou
> >
> > 发自坚果 Pro
> >
> > Marek Ol?醟 <maraeo@gmail.com> 于 2017年9月13日 下午6:11写道：
> >
> > On Wed, Sep 13, 2017 at 5:03 AM, zhoucm1 <david1.zhou@amd.com> wrote:
> >> Hi Marek,
> >>
> >> You're doing same things with me, see my "introduce syncfile as fence
> >> reuturn" patch set, which makes things more simple, we just need to
> >> directly
> >> return syncfile fd to UMD when CS, then the fence UMD get will be 
> always
> >> syncfile fd, UMD don't need to construct 
> ip_type/ip_instance/ctx_id/ring
> >> any
> >> more, which also can pass to dependency and syncobj as well.
> >
> > For simpler Mesa code, Mesa won't get a sync file from the CS ioctl.
> >
> > Marek
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------5C1B67DA4099A763F43EBA74
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
syncfile indeed be a good way to pass fence for user space, which already is proved in Android and is upstreamed.<br>
      </blockquote>
      Not really. syncfile needs a file descriptor for each handle it
      generates, that's quite a show stopper if you want to use it in
      general.<br>
      <br>
      Android syncfile are meant to be used for inter process sharing,
      but as command submission sequence number they are not such a good
      fit.<br>
      <br>
      Mareks approach looks really good to me and we should follow that
      direction further.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 13.09.2017 um 14:25 schrieb Zhou, David(ChunMing):<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR1201MB0206A14F0D2148D5036A9485B46E0@MWHPR1201MB0206.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <div>Yes, to be comptibility, I kept both seq_no and syncfile fd in the patch set, you can take a look, which really is simpler and effective way.<br>
        <br>
syncfile indeed be a good way to pass fence for user space, which already is proved in Android and is upstreamed.<br>
        <br>
        Regards,<br>
        David Zhou<br>
        <br>
        <p dir="ltr" style="display:inline"><span style="color:#888888"><span
              style="font-size:0.81em">发自坚果 Pro</span></span></p>
        <style type="text/css">
<!--
* body
	{padding:0 16px 30px!important;
	margin:0!important;
	background-color:#ffffff;
	line-height:1.4;
	word-wrap:break-word;
	word-break:normal}
div
	{word-wrap:break-word;
	word-break:normal}
p
	{word-wrap:break-word;
	word-break:normal;
	text-indent:0pt!important}
span
	{word-wrap:break-word;
	word-break:normal}
a
	{word-wrap:break-word;
	word-break:normal}
td
	{word-wrap:break-word;
	word-break:break-all}
-->
</style>
        <div class="x_quote">
          <div style="margin:0 0px; font-size:105%"><font
              style="line-height:1.4" color="#629140"><span>Marek Ol?醟
                <a class="moz-txt-link-rfc2396E" href="mailto:maraeo@gmail.com">&lt;maraeo@gmail.com&gt;</a> 于 2017年9月13日 下午8:06写道：</span></font></div>
          <br type="attribution">
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">On Wed, Sep 13, 2017 at 1:32 PM, Zhou,
            David(ChunMing)<br>
            <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou@amd.com">&lt;David1.Zhou@amd.com&gt;</a> wrote:<br>
            &gt; Could you describe how difficult to directly use CS
            syncfile fd in Mesa<br>
            &gt; compared with concerting CS seq to syncfile fd via
            several syncobj ioctls?<br>
            <br>
            It just simplifies things. Mesa primarily uses seq_no-based
            fences and<br>
            will continue to use them. We can't remove the seq_no fence
            code<br>
            because we have to keep Mesa compatible with older kernels.<br>
            <br>
            The only possibilities are:<br>
            - Mesa gets both seq_no and sync_file from CS.<br>
            - Mesa only gets seq_no from CS.<br>
            <br>
            I decided to take the simpler option. I don't know if there
            is a perf<br>
            difference between CS returning a sync_file and using a
            separate<br>
            ioctl, but it's probably insignificant since we already call
            3 ioctls<br>
            per IB submission (BO list create+destroy, submit).<br>
            <br>
            Marek<br>
            <br>
            &gt;<br>
            &gt; Regards,<br>
            &gt; David Zhou<br>
            &gt;<br>
            &gt; 发自坚果 Pro<br>
            &gt;<br>
            &gt; Marek Ol?醟 <a class="moz-txt-link-rfc2396E" href="mailto:maraeo@gmail.com">&lt;maraeo@gmail.com&gt;</a> 于 2017年9月13日
            下午6:11写道：<br>
            &gt;<br>
            &gt; On Wed, Sep 13, 2017 at 5:03 AM, zhoucm1
            <a class="moz-txt-link-rfc2396E" href="mailto:david1.zhou@amd.com">&lt;david1.zhou@amd.com&gt;</a> wrote:<br>
            &gt;&gt; Hi Marek,<br>
            &gt;&gt;<br>
            &gt;&gt; You're doing same things with me, see my "introduce
            syncfile as fence<br>
            &gt;&gt; reuturn" patch set, which makes things more simple,
            we just need to<br>
            &gt;&gt; directly<br>
            &gt;&gt; return syncfile fd to UMD when CS, then the fence
            UMD get will be always<br>
            &gt;&gt; syncfile fd, UMD don't need to construct
            ip_type/ip_instance/ctx_id/ring<br>
            &gt;&gt; any<br>
            &gt;&gt; more, which also can pass to dependency and syncobj
            as well.<br>
            &gt;<br>
            &gt; For simpler Mesa code, Mesa won't get a sync file from
            the CS ioctl.<br>
            &gt;<br>
            &gt; Marek<br>
          </div>
        </span></font>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------5C1B67DA4099A763F43EBA74--

--===============2130597380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============2130597380==--
