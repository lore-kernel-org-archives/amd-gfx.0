From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: GPR read support via debugfs (v2)
Date: Wed, 7 Dec 2016 19:46:07 +0100
Message-ID: <66b70798-0f50-9287-77ed-08be460d9a03@vodafone.de>
References: <20161206145014.9140-1-tom.stdenis@amd.com>
 <b0979deb-7d97-f81f-65af-3a0800d55e4b@folklore1984.net>
 <CY4PR12MB1768F2C7EF86AE04BB957AEAF7850@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CADnq5_OJJFGDLt405YdQN3k6O5jbM_t0miDo=ZenMp9jG9QjcA@mail.gmail.com>
 <CY4PR12MB1768C0C95CA7F8A50E07C28AF7850@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CAAxE2A6d6XuB8wSG2foFEsVVgJcZh5fVXYKRwsRQA=ao6q5f4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0978117633=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6d6XuB8wSG2foFEsVVgJcZh5fVXYKRwsRQA=ao6q5f4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0978117633==
Content-Type: multipart/alternative;
 boundary="------------2CFFF68F06106891B39BDC8F"

This is a multi-part message in MIME format.
--------------2CFFF68F06106891B39BDC8F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Completely agree, couldn't take a look but feel free to add my Acked-by: 
Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Christian.

Am 07.12.2016 um 18:59 schrieb Marek Olšák:
> Yeah, it can be useful for GPU hang debugging.
>
> Marek
>
> On Wed, Dec 7, 2016 at 6:49 PM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org 
> <mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     Hi Alex,
>
>
>     I'll wait on pushing it until I hear back from one of them.
>
>
>     Cheers,
>
>     Tom
>
>
>
>     ------------------------------------------------------------------------
>     *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>     <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>     *Sent:* Wednesday, December 7, 2016 12:32
>     *To:* StDenis, Tom
>     *Cc:* Edward O'Callaghan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>     *Subject:* Re: GPR read support via debugfs (v2)
>     Patches look fine to me.  Assuming they are useful to Marek and
>     Nicolai, the patches are:
>     Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org
>     <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>>
>
>     On Wed, Dec 7, 2016 at 12:05 PM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org
>     <mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>         Thanks.
>
>
>         Could use a RB/NAK from Christian or Alex when they get the
>         time :-)
>
>
>         Tom
>
>
>
>         ------------------------------------------------------------------------
>         *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> on behalf of
>         Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org
>         <mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>>
>         *Sent:* Tuesday, December 6, 2016 17:15
>         *To:* Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         *Subject:* Re: GPR read support via debugfs (v2)
>         This series is,
>         Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org
>         <mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>>
>
>         On 12/07/2016 01:50 AM, Tom St Denis wrote:
>         > These patches introduce debugfs access to read GPRs (SGPRs
>         for now).
>         >
>         > (v2): Fixes white space, addressing is in dwords not bytes,
>         and removes
>         >       the buggy sanity checking.
>         >
>         > _______________________________________________
>         > amd-gfx mailing list
>         > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>         <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>         amd-gfx Info Page - lists.freedesktop.org
>         <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>         lists.freedesktop.org <http://lists.freedesktop.org>
>         To see the collection of prior postings to the list, visit the
>         amd-gfx Archives. Using amd-gfx: To post a message to all the
>         list members, send email ...
>
>
>
>         >
>
>
>         _______________________________________________
>         amd-gfx mailing list
>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>         <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>
>
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------2CFFF68F06106891B39BDC8F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Completely agree, couldn't take a look
      but feel free to add my Acked-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
      <br>
      Christian.<br>
      <br>
      Am 07.12.2016 um 18:59 schrieb Marek Olšák:<br>
    </div>
    <blockquote
cite="mid:CAAxE2A6d6XuB8wSG2foFEsVVgJcZh5fVXYKRwsRQA=ao6q5f4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <div dir="ltr">
        <div>Yeah, it can be useful for GPU hang debugging.<br>
          <br>
        </div>
        Marek<br>
      </div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">On Wed, Dec 7, 2016 at 6:49 PM,
          StDenis, Tom <span dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target="_blank">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div dir="ltr">
              <div id="m_5230846299181212084divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif"
                dir="ltr">
                <p>Hi Alex,</p>
                <p><br>
                </p>
                <p>I'll wait on pushing it until I hear back from one of
                  them.</p>
                <p><br>
                </p>
                <p>Cheers,</p>
                <p>Tom</p>
                <br>
                <br>
                <div style="color:rgb(0,0,0)">
                  <hr style="display:inline-block;width:98%">
                  <div id="m_5230846299181212084divRplyFwdMsg" dir="ltr"><font
                      style="font-size:11pt" color="#000000"
                      face="Calibri, sans-serif"><b>From:</b> Alex
                      Deucher &lt;<a moz-do-not-send="true"
                        href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                        target="_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                      <b>Sent:</b> Wednesday, December 7, 2016 12:32<br>
                      <b>To:</b> StDenis, Tom<br>
                      <b>Cc:</b> Edward O'Callaghan; <a
                        moz-do-not-send="true"
                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a>
                      <div>
                        <div class="h5"><br>
                          <b>Subject:</b> Re: GPR read support via
                          debugfs (v2)</div>
                      </div>
                    </font>
                    <div> </div>
                  </div>
                  <div>
                    <div class="h5">
                      <div>
                        <div dir="ltr">
                          <div>Patches look fine to me.  Assuming they
                            are useful to Marek and Nicolai, the patches
                            are:<br>
                          </div>
                          Reviewed-by: Alex Deucher &lt;<a
                            moz-do-not-send="true"
                            href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                            target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a></a>&gt;<br>
                          <div>
                            <div>
                              <div>
                                <div class="gmail_extra"><br>
                                  <div class="gmail_quote">On Wed, Dec
                                    7, 2016 at 12:05 PM, StDenis, Tom <span
                                      dir="ltr">
                                      &lt;<a moz-do-not-send="true"
                                        href="mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org"
                                        target="_blank">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
                                    wrote:<br>
                                    <blockquote class="gmail_quote"
                                      style="margin:0 0 0
                                      .8ex;border-left:1px #ccc
                                      solid;padding-left:1ex">
                                      <div dir="ltr">
                                        <div
                                          id="m_5230846299181212084m_1549130000763319934divtagdefaultwrapper"
                                          dir="ltr"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif">
                                          <p>Thanks.</p>
                                          <p><br>
                                          </p>
                                          <p>Could use a RB/NAK from
                                            Christian or Alex when they
                                            get the time :-)</p>
                                          <p><br>
                                          </p>
                                          <p>Tom</p>
                                          <br>
                                          <br>
                                          <div style="color:rgb(0,0,0)">
                                            <div>
                                              <hr
                                                style="display:inline-block;width:98%">
                                              <div
                                                id="m_5230846299181212084m_1549130000763319934x_divRplyFwdMsg"
                                                dir="ltr"><font
                                                  style="font-size:11pt"
                                                  color="#000000"
                                                  face="Calibri,
                                                  sans-serif"><b>From:</b>
                                                  amd-gfx &lt;<a
                                                    moz-do-not-send="true"
href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org">amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org</a><wbr>ktop.org</a>&gt;
                                                  on behalf of Edward
                                                  O'Callaghan &lt;<a
                                                    moz-do-not-send="true"
href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org</a></a>&gt;<br>
                                                  <b>Sent:</b> Tuesday,
                                                  December 6, 2016 17:15<br>
                                                  <b>To:</b> Tom St
                                                  Denis; <a
                                                    moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank">
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a><br>
                                                  <b>Subject:</b> Re:
                                                  GPR read support via
                                                  debugfs (v2)</font>
                                                <div> </div>
                                              </div>
                                            </div>
                                            <font size="2"><span
                                                style="font-size:10pt">
                                                <div
                                                  class="m_5230846299181212084m_1549130000763319934PlainText">
                                                  <div>
                                                    <div
                                                      class="m_5230846299181212084h5">This
                                                      series is,<br>
                                                      Acked-by: Edward
                                                      O'Callaghan &lt;<a
moz-do-not-send="true" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
                                                        target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org</a></a>&gt;<br>
                                                      <br>
                                                      On 12/07/2016
                                                      01:50 AM, Tom St
                                                      Denis wrote:<br>
                                                      &gt; These patches
                                                      introduce debugfs
                                                      access to read
                                                      GPRs (SGPRs for
                                                      now).<br>
                                                      &gt; <br>
                                                      &gt; (v2): Fixes
                                                      white space,
                                                      addressing is in
                                                      dwords not bytes,
                                                      and removes<br>
                                                      &gt;       the
                                                      buggy sanity
                                                      checking.<br>
                                                      &gt; <br>
                                                      &gt;
                                                      ______________________________<wbr>_________________<br>
                                                      &gt; amd-gfx
                                                      mailing list<br>
                                                      &gt; <a
                                                        moz-do-not-send="true"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></a><br>
                                                      &gt; <a
                                                        moz-do-not-send="true"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                                        id="m_5230846299181212084m_1549130000763319934LPlnk539856"
                                                        target="_blank">
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/">https://lists.freedesktop.org/</a><wbr>mailman/listinfo/amd-gfx</a> </div>
                                                  </div>
                                                  <div
id="m_5230846299181212084m_1549130000763319934LPBorder_GT_14811303134020.3066773959785267"
style="margin-bottom:20px;overflow:auto;width:100%;text-indent:0px">
                                                    <table
id="m_5230846299181212084m_1549130000763319934LPContainer_14811303133990.7273202165353794"
style="width:90%;background-color:rgb(255,255,255);overflow:auto;padding-top:20px;padding-bottom:20px;margin-top:20px;border-top:1px
                                                      dotted
                                                      rgb(200,200,200);border-bottom:1px
                                                      dotted
                                                      rgb(200,200,200)"
                                                      cellspacing="0">
                                                      <tbody>
                                                        <tr
                                                          style="border-spacing:0px"
                                                          valign="top">
                                                          <td
id="m_5230846299181212084m_1549130000763319934TextCell_14811303134010.6228712278926285"
                                                          colspan="2"
                                                          style="vertical-align:top;padding:0px;display:table-cell">
                                                          <div
id="m_5230846299181212084m_1549130000763319934LPRemovePreviewContainer_14811303134010.667042105097579"></div>
                                                          <div
id="m_5230846299181212084m_1549130000763319934LPTitle_14811303134010.2987133567172171"
style="color:rgb(59,87,119);font-weight:normal;font-size:21px;font-family:wf_segoe-ui_light,&quot;Segoe
                                                          UI
                                                          Light&quot;,&quot;Segoe
                                                          WP
                                                          Light&quot;,&quot;Segoe
UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;line-height:21px">
                                                          <a
                                                          moz-do-not-send="true"
id="m_5230846299181212084m_1549130000763319934LPUrlAnchor_14811303134010.6835253784315398"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                                          style="text-decoration:none"
target="_blank">amd-gfx Info Page - lists.freedesktop.org</a></div>
                                                          <div
id="m_5230846299181212084m_1549130000763319934LPMetadata_14811303134010.9344851329159858"
style="margin:10px 0px
16px;color:rgb(102,102,102);font-weight:normal;font-family:wf_segoe-ui_normal,&quot;Segoe
UI&quot;,&quot;Segoe
                                                          WP&quot;,Tahoma,Arial,sans-serif;font-size:14px;line-height:14px">
                                                          <a
                                                          moz-do-not-send="true"
href="http://lists.freedesktop.org" target="_blank">lists.freedesktop.org</a></div>
                                                          <div
id="m_5230846299181212084m_1549130000763319934LPDescription_14811303134020.7740425410367178"
style="display:block;color:rgb(102,102,102);font-weight:normal;font-family:wf_segoe-ui_normal,&quot;Segoe
UI&quot;,&quot;Segoe
WP&quot;,Tahoma,Arial,sans-serif;font-size:14px;line-height:20px;max-height:100px;overflow:hidden">To
                                                          see the
                                                          collection of
                                                          prior postings
                                                          to the list,
                                                          visit the
                                                          amd-gfx
                                                          Archives.
                                                          Using amd-gfx:
                                                          To post a
                                                          message to all
                                                          the list
                                                          members, send
                                                          email ...</div>
                                                          </td>
                                                        </tr>
                                                      </tbody>
                                                    </table>
                                                  </div>
                                                  <br>
                                                  <br>
                                                  &gt; <br>
                                                  <br>
                                                </div>
                                              </span></font></div>
                                        </div>
                                      </div>
                                      <br>
                                      ______________________________<wbr>_________________<br>
                                      amd-gfx mailing list<br>
                                      <a moz-do-not-send="true"
                                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                        target="_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                      <a moz-do-not-send="true"
                                        href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                        rel="noreferrer" target="_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
                                      <br>
                                    </blockquote>
                                  </div>
                                  <br>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <br>
            ______________________________<wbr>_________________<br>
            amd-gfx mailing list<br>
            <a moz-do-not-send="true"
              href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a moz-do-not-send="true"
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              rel="noreferrer" target="_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a><br>
            <br>
          </blockquote>
        </div>
        <br>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------2CFFF68F06106891B39BDC8F--

--===============0978117633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0978117633==--
