From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: tidy'ing up cz_hwmgr.c
Date: Thu, 18 Aug 2016 17:48:11 +0200
Message-ID: <0efca328-0a24-3efe-aa6b-623a90be2b7f@vodafone.de>
References: <DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
 <642600e3-dd63-7b36-a749-451a451ab153@vodafone.de>
 <DM5PR12MB11329451427722B9088E40F7F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
 <CADnq5_Ntb79gEF=1Xa7BP=J4GgTzb+vY8ZbZijVTVPvaAJGrng@mail.gmail.com>
 <DM5PR12MB1132AF7ACC738F339571ECAFF7150@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1216612852=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1132AF7ACC738F339571ECAFF7150-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1216612852==
Content-Type: multipart/alternative;
 boundary="------------2EEF5F1D8CD6E4FCE2172F96"

This is a multi-part message in MIME format.
--------------2EEF5F1D8CD6E4FCE2172F96
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


> theory would be better with [0]
It depends on the gcc version you have and well that is probably the 
difference between theory and practice.

In theory it should work, but in practice we had tons of problems with that.

Best practice I think is to still calculate the end of the structure 
manually and don't embed the array into the structure.

Take a look at drivers/dma-buf/fence-array.c fence_array_create() and 
fence_array_enable_signaling() for an example on how to use it.

So please don't use this,
Christian.

Am 18.08.2016 um 17:39 schrieb StDenis, Tom:
>
> It had to be something more complicated because this demo program
>
>
> #include <stdio.h>
> #include <stdlib.h>
>
> struct one {
> char *foo;
> int bar[0];
> };
>
> struct two {
> char *foo;
> int bar[1];
> };
>
> int main(void)
> {
> struct one *a = calloc(1, sizeof(struct one) + 4 * sizeof(int));
> struct two *b = calloc(1, sizeof(struct two) + 3 * sizeof(int));
> int x;
>
> printf("a == %p\n", a);
> for (x = 0; x < 4; x++)
> printf("&a.bar[%d] = %p\n", x, &a->bar[x]);
>
> printf("b == %p\n", b);
> for (x = 0; x < 4; x++)
> printf("&b.bar[%d] = %p\n", x, &b->bar[x]);
>
> return 0;
> }
>
> produces this output
>
>
> tom@fx8:~$ gcc test.c -o test
> tom@fx8:~$ ./test
> a == 0x1fd4010
> &a.bar[0] = 0x1fd4018
> &a.bar[1] = 0x1fd401c
> &a.bar[2] = 0x1fd4020
> &a.bar[3] = 0x1fd4024
> b == 0x1fd4030
> &b.bar[0] = 0x1fd4038
> &b.bar[1] = 0x1fd403c
> &b.bar[2] = 0x1fd4040
> &b.bar[3] = 0x1fd4044
>
> Which is exactly what you'd expect.  I'm not strongly advocating we 
> change the PP code just noting it's not really clear that it's correct 
> from a first reading and in theory would be better with [0].
>
> Tom
>
> ------------------------------------------------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Thursday, August 18, 2016 11:33
> *To:* StDenis, Tom
> *Cc:* Christian König; amd-gfx list
> *Subject:* Re: tidy'ing up cz_hwmgr.c
> The problem we ran into was when we had a struct like this:
>
> struct table {
>    uint16_t size;
>    struct element elements[0];
> };
>
> and then we would try and index the array:
>
> for (i = 0; i < table->size; i++) {
>   element = &table->elements[i];
> }
>
> element ended up off in the weeds.  The only thing that seems to make 
> some versions of gcc happy was pointer arithmetic.  E.g.,
>
> element = (struct element *)((char *)&table->elements[0] + 
> (sizeof(struct element) * i));
>
> Alex
>
> On Thu, Aug 18, 2016 at 11:21 AM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org 
> <mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     Any modern GCC should support [0] at the tail of a struct.  This
>     came up because when I was reading the code I saw they allocated 7
>     slots (plus the size of the struct) but then fill 8 slots.  It's
>     just weird 😊
>
>
>     Using [0] in the struct and allocating for 8 entries makes more
>     sense and is clearer to read.
>
>
>     Tom
>
>
>
>     ------------------------------------------------------------------------
>     *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org
>     <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>>
>     *Sent:* Thursday, August 18, 2016 11:17
>     *To:* StDenis, Tom; amd-gfx list
>     *Subject:* Re: tidy'ing up cz_hwmgr.c
>>     Has a [1] array at the tail which is then kzalloc'ed with N-1
>>     entries.  Shouldn't that just be a [0] with N entries allocated
>>     for clarity?
>     Actually the starting address of a dynamic array should be
>     manually calculated instead of using [1] or [0].
>
>     We had tons of problems with that because some gcc versions get
>     this wrong and the atombios code used this as well.
>
>     Alex how did we resolved such issues?
>
>     Regards,
>     Christian.
>
>     Am 18.08.2016 um 16:26 schrieb StDenis, Tom:
>>
>>     Tidying up cz_hwmgr.c I noted a couple of things but first is
>>
>>
>>     static bool cz_dpm_check_smu_features(struct pp_hwmgr *hwmgr,
>>     unsigned long check_feature);
>>
>>     Which will return "true" if the smu call fails *or* the feature
>>     is set.
>>
>>     The structure
>>
>>     struct phm_clock_voltage_dependency_table;
>>
>>     Has a [1] array at the tail which is then kzalloc'ed with N-1
>>     entries.  Shouldn't that just be a [0] with N entries allocated
>>     for clarity?
>>
>>     Tom
>>
>>
>>
>>     _______________________________________________
>>     amd-gfx mailing list
>>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>
>     _______________________________________________ amd-gfx mailing
>     list amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx> 
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------2EEF5F1D8CD6E4FCE2172F96
Content-Type: multipart/related;
 boundary="------------51949A15BF858DBD1BF4309D"


--------------51949A15BF858DBD1BF4309D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix"><br>
      <blockquote type="cite">theory would be better with [0]</blockquote>
      It depends on the gcc version you have and well that is probably
      the difference between theory and practice.<br>
      <br>
      In theory it should work, but in practice we had tons of problems
      with that.<br>
      <br>
      Best practice I think is to still calculate the end of the
      structure manually and don't embed the array into the structure.<br>
      <br>
      Take a look at drivers/dma-buf/fence-array.c fence_array_create()
      and fence_array_enable_signaling() for an example on how to use
      it.<br>
      <br>
      So please don't use this,<br>
      Christian.<br>
      <br>
      Am 18.08.2016 um 17:39 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB1132AF7ACC738F339571ECAFF7150-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>It had to be something more complicated because this demo
          program</p>
        <p><br>
        </p>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">#include &lt;stdio.h&gt;</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">#include &lt;stdlib.h&gt;</span></div>
        <div><br>
        </div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">struct one {</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">char
            *foo;</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">int
            bar[0];</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">};</span></div>
        <div><br>
        </div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">struct two {</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">char
            *foo;</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">int
            bar[1];</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">};</span></div>
        <div><br>
        </div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">int main(void)</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">{</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">struct
            one *a = calloc(1, sizeof(struct one) + 4 * sizeof(int));</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">struct
            two *b = calloc(1, sizeof(struct two) + 3 * sizeof(int));</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">int
            x;</span></div>
        <div><br>
        </div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">printf("a
            == %p\n", a);</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">for
            (x = 0; x &lt; 4; x++)</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">printf("&amp;a.bar[%d]
            = %p\n", x, &amp;a-&gt;bar[x]);</span></div>
        <div><br>
        </div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">printf("b
            == %p\n", b);</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">for
            (x = 0; x &lt; 4; x++)</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">printf("&amp;b.bar[%d]
            = %p\n", x, &amp;b-&gt;bar[x]);</span></div>
        <div><br>
        </div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">return
            0;</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">}</span></div>
        <div><br>
        </div>
        <p>produces this output</p>
        <p><br>
        </p>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">tom@fx8:~$ gcc test.c -o test</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">tom@fx8:~$ ./test</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">a == 0x1fd4010</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">&amp;a.bar[0] = 0x1fd4018</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">&amp;a.bar[1] = 0x1fd401c</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">&amp;a.bar[2] = 0x1fd4020</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">&amp;a.bar[3] = 0x1fd4024</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">b == 0x1fd4030</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">&amp;b.bar[0] = 0x1fd4038</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">&amp;b.bar[1] = 0x1fd403c</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">&amp;b.bar[2] = 0x1fd4040</span></div>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">&amp;b.bar[3] = 0x1fd4044</span></div>
        <div><br>
        </div>
        Which is exactly what you'd expect.  I'm not strongly advocating
        we change the PP code just noting it's not really clear that
        it's correct from a first reading and in theory would be better
        with [0].
        <div><br>
        </div>
        Tom<br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Thursday, August 18, 2016 11:33<br>
              <b>To:</b> StDenis, Tom<br>
              <b>Cc:</b> Christian König; amd-gfx list<br>
              <b>Subject:</b> Re: tidy'ing up cz_hwmgr.c</font>
            <div> </div>
          </div>
          <div>
            <div dir="ltr">
              <div>
                <div>
                  <div>The problem we ran into was when we had a struct
                    like this:<br>
                    <br>
                  </div>
                  struct table {<br>
                </div>
                   uint16_t size;<br>
              </div>
                 struct element elements[0];<br>
              <div>
                <div>};<br>
                  <div>
                    <div>
                      <div class="gmail_extra"><br>
                      </div>
                      <div class="gmail_extra">and then we would try and
                        index the array:<br>
                        <br>
                      </div>
                      <div class="gmail_extra">for (i = 0; i &lt;
                        table-&gt;size; i++) {<br>
                      </div>
                      <div class="gmail_extra">  element =
                        &amp;table-&gt;elements[i];<br>
                      </div>
                      <div class="gmail_extra">}<br>
                        <br>
                      </div>
                      <div class="gmail_extra">element ended up off in
                        the weeds.  The only thing that seems to make
                        some versions of gcc happy was pointer
                        arithmetic.  E.g.,<br>
                      </div>
                      <div class="gmail_extra"><br>
                      </div>
                      <div class="gmail_extra">element = (struct element
                        *)((char *)&amp;table-&gt;elements[0] +
                        (sizeof(struct element) * i));<br>
                        <br>
                      </div>
                      <div class="gmail_extra">Alex<br>
                      </div>
                      <div class="gmail_extra"><br>
                        <div class="gmail_quote">On Thu, Aug 18, 2016 at
                          11:21 AM, StDenis, Tom <span dir="ltr">
                            &lt;<a moz-do-not-send="true"
                              href="mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org"
                              target="_blank">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>
                          wrote:<br>
                          <blockquote class="gmail_quote"
                            style="margin:0 0 0 .8ex; border-left:1px
                            #ccc solid; padding-left:1ex">
                            <div dir="ltr">
                              <div style="font-size:12pt; color:#000000;
                                background-color:#ffffff;
                                font-family:Calibri,Arial,Helvetica,sans-serif">
                                <p>Any modern GCC should support [0] at
                                  the tail of a struct.  This came up
                                  because when I was reading the code I
                                  saw they allocated 7 slots (plus the
                                  size of the struct) but then fill 8
                                  slots.  It's just weird
                                  <img alt="😊" style="vertical-align:
                                    bottom; -webkit-user-select: none;"
                                    tabindex="0"
                                    src="cid:part2.12A01FCD.899B127C-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"></p>
                                <p><br>
                                </p>
                                <p>Using [0] in the struct and
                                  allocating for 8 entries makes more
                                  sense and is clearer to read.</p>
                                <p><br>
                                </p>
                                <p>Tom</p>
                                <br>
                                <br>
                                <div style="color:rgb(0,0,0)">
                                  <hr style="display:inline-block;
                                    width:98%">
                                  <div dir="ltr"><font
                                      style="font-size:11pt"
                                      color="#000000" face="Calibri,
                                      sans-serif"><b>From:</b> Christian
                                      König &lt;<a
                                        moz-do-not-send="true"
                                        href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
                                        target="_blank">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;<br>
                                      <b>Sent:</b> Thursday, August 18,
                                      2016 11:17<br>
                                      <b>To:</b> StDenis, Tom; amd-gfx
                                      list<br>
                                      <b>Subject:</b> Re: tidy'ing up
                                      cz_hwmgr.c</font>
                                    <div> </div>
                                  </div>
                                  <div>
                                    <div class="h5">
                                      <div>
                                        <div>
                                          <blockquote type="cite">
                                            <div>Has a [1] array at the
                                              tail which is then
                                              kzalloc'ed with N-1
                                              entries.  Shouldn't that
                                              just be a [0] with N
                                              entries allocated for
                                              clarity?</div>
                                          </blockquote>
                                          Actually the starting address
                                          of a dynamic array should be
                                          manually calculated instead of
                                          using [1] or [0].<br>
                                          <br>
                                          We had tons of problems with
                                          that because some gcc versions
                                          get this wrong and the
                                          atombios code used this as
                                          well.<br>
                                          <br>
                                          Alex how did we resolved such
                                          issues?<br>
                                          <br>
                                          Regards,<br>
                                          Christian.<br>
                                          <br>
                                          Am 18.08.2016 um 16:26 schrieb
                                          StDenis, Tom:<br>
                                        </div>
                                        <blockquote type="cite">
                                          <div style="font-size:12pt;
                                            color:#000000;
                                            background-color:#ffffff;
                                            font-family:Calibri,Arial,Helvetica,sans-serif">
                                            <p>Tidying up cz_hwmgr.c I
                                              noted a couple of things
                                              but first is </p>
                                            <p><br>
                                            </p>
                                            <div><span
                                                style="font-family:&quot;Courier
                                                New&quot;,monospace">static
                                                bool
                                                cz_dpm_check_smu_features(<wbr>struct
                                                pp_hwmgr *hwmgr,</span></div>
                                            <div><span style="white-space:pre-wrap; font-family:&quot;Courier New&quot;,monospace"></span><span
style="font-family:&quot;Courier New&quot;,monospace">unsigned long
                                                check_feature);</span></div>
                                            <div><br>
                                            </div>
                                            <div>Which will return
                                              "true" if the smu call
                                              fails <b>or</b> the
                                              feature is set.  </div>
                                            <div><br>
                                            </div>
                                            <div>The structure </div>
                                            <div><br>
                                            </div>
                                            <div>
                                              <div><span
                                                  style="font-family:&quot;Courier
                                                  New&quot;,monospace">struct
phm_clock_voltage_dependency_<wbr>table;</span></div>
                                            </div>
                                            <div><br>
                                            </div>
                                            <div>Has a [1] array at the
                                              tail which is then
                                              kzalloc'ed with N-1
                                              entries.  Shouldn't that
                                              just be a [0] with N
                                              entries allocated for
                                              clarity?</div>
                                            <div><br>
                                            </div>
                                            <div>Tom</div>
                                            <div><br>
                                            </div>
                                          </div>
                                          <br>
                                          <fieldset></fieldset>
                                          <br>
                                          <pre>______________________________<wbr>_________________
amd-gfx mailing list
<a moz-do-not-send="true" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target="_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</pre>
</blockquote>
<p>

</p>
</div>
</div>
</div>
</div>
</div>
</div>


______________________________<wbr>_________________

amd-gfx mailing list

<a moz-do-not-send="true" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>

<a moz-do-not-send="true" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel="noreferrer" target="_blank">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>



</blockquote>
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



<fieldset class="mimeAttachmentHeader"></fieldset>
<pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>

</blockquote><p>
</p></body></html>
--------------51949A15BF858DBD1BF4309D
Content-Type: image/png
Content-Transfer-Encoding: base64
Content-ID: <part2.12A01FCD.899B127C-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAGXRFWHRTb2Z0d2FyZQBBZG9i
ZSBJbWFnZVJlYWR5ccllPAAAAYpJREFUeNpi/P//PwO1ACM2wf9njBWAVD4QBwCxApLUAyDe
AMQTGU3OPkDRA3QUIxaD+oFUAREOaQQa2IDTMKBB84FUAgk+WwA0MBFmGBOaixJIDKYEoD64
65igBjkge+3CrW94TUCTr4eGMdxl8TCZxMYHDIZR1xk2HPiA1SCQOEgepA4J5CMbFgAPhM1v
wfTFW9+xGgYTh6lD1s8IdKIAkH4PEz1w9jOYVpBiZ1CQZMMw7MHzXwwPnv0Esx2MeRESxmcY
WYCUAbJiFAVYAMgCbJbAvPmAWjmACZqS4aHdOOs5wdgEBcWE5a8Y0HIGPAIOwETtjXkYJqIq
xAAgeQM1ThTzkQ2biB5mC7a8xZ7kgeICvMzoYTsRJaMDY3U9chIBpaMHz34xxPsKgwMcFIsL
gckB5KL+YllkgyYAg6oQJW9Ck8h+5NgFhd3GAx/humAGI2cGIHYEGvYBW0YHGTgf2YX4MjkQ
F4IMwlkEIeXVfByGwsqzAwTLMywGg7wNcvED9AIR3TCAAAMAqh+p+YMVeBQAAAAASUVORK5C
YII=
--------------51949A15BF858DBD1BF4309D--

--------------2EEF5F1D8CD6E4FCE2172F96--

--===============1216612852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1216612852==--
