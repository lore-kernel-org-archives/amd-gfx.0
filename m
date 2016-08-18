From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: tidy'ing up cz_hwmgr.c
Date: Thu, 18 Aug 2016 18:07:02 +0200
Message-ID: <54985952-6f8b-b882-94e2-4115ce7d5a30@vodafone.de>
References: <DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
 <642600e3-dd63-7b36-a749-451a451ab153@vodafone.de>
 <DM5PR12MB11329451427722B9088E40F7F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
 <CADnq5_Ntb79gEF=1Xa7BP=J4GgTzb+vY8ZbZijVTVPvaAJGrng@mail.gmail.com>
 <DM5PR12MB1132AF7ACC738F339571ECAFF7150@DM5PR12MB1132.namprd12.prod.outlook.com>
 <MWHPR12MB16947C2728D40DEC0BB41502F7150@MWHPR12MB1694.namprd12.prod.outlook.com>
 <DM5PR12MB11323E186DB7B5F065790EA9F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1705543601=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB11323E186DB7B5F065790EA9F7150-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1705543601==
Content-Type: multipart/alternative;
 boundary="------------7C53B9404AB99D52034D39D6"

This is a multi-part message in MIME format.
--------------7C53B9404AB99D52034D39D6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> Either way like I said I'm not strongly motivated to change it just 
> caught my attention.
>
Well if you have time it would be really cool if you could a) identify 
such cases before we run into issues with some gcc versions again and b) 
leave the people who added the code and/or are responsible for this part 
of the driver a note to fix it.

We really had a headache with those things because of the coding style 
in the atom headers and I would really like to avoid that in the future.

Thanks in advance,
Christian.

Am 18.08.2016 um 17:53 schrieb StDenis, Tom:
>
> Thanks Alex and Christian,
>
>
> Yup turns out [0] is not ISO C but [] is (from the googles)
>
>
> *C99 6.7.2.1, §16*: As a special case, the last element of a structure 
> with more than one named member may have an incomplete array type; 
> this is called a flexible array member.
>
>
> Either way like I said I'm not strongly motivated to change it just 
> caught my attention.
>
>
> Cheers,
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* Deucher, Alexander
> *Sent:* Thursday, August 18, 2016 11:50
> *To:* StDenis, Tom; Alex Deucher
> *Cc:* Christian König; amd-gfx list
> *Subject:* RE: tidy'ing up cz_hwmgr.c
>
> IIRC, zero sized arrays are not technically allowed in C, although gcc 
> allows them. As I said, some versions of gcc worked, others didn't.  
> I'm not sure why.  Also, my example was slightly wrong.  atombios.h 
> uses arrays of size 1, not 0.  So my example should look like:
>
> struct table {
>
>    uint16_t size;
>
>    struct element elements[1];
>
> };
>
> atombios.h uses [1] since I don't think [0] is portable.  The same 
> indexing issue applies to [1].
>
> Alex
>
> *From:*amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On 
> Behalf Of *StDenis, Tom
> *Sent:* Thursday, August 18, 2016 11:40 AM
> *To:* Alex Deucher
> *Cc:* Christian König; amd-gfx list
> *Subject:* Re: tidy'ing up cz_hwmgr.c
>
> It had to be something more complicated because this demo program
>
> #include <stdio.h>
>
> #include <stdlib.h>
>
> struct one {
>
> char *foo;
>
> int bar[0];
>
> };
>
> struct two {
>
> char *foo;
>
> int bar[1];
>
> };
>
> int main(void)
>
> {
>
> struct one *a = calloc(1, sizeof(struct one) + 4 * sizeof(int));
>
> struct two *b = calloc(1, sizeof(struct two) + 3 * sizeof(int));
>
> int x;
>
> printf("a == %p\n", a);
>
> for (x = 0; x < 4; x++)
>
> printf("&a.bar[%d] = %p\n", x, &a->bar[x]);
>
> printf("b == %p\n", b);
>
> for (x = 0; x < 4; x++)
>
> printf("&b.bar[%d] = %p\n", x, &b->bar[x]);
>
> return 0;
>
> }
>
> produces this output
>
> tom@fx8:~$ gcc test.c -o test
>
> tom@fx8:~$ ./test
>
> a == 0x1fd4010
>
> &a.bar[0] = 0x1fd4018
>
> &a.bar[1] = 0x1fd401c
>
> &a.bar[2] = 0x1fd4020
>
> &a.bar[3] = 0x1fd4024
>
> b == 0x1fd4030
>
> &b.bar[0] = 0x1fd4038
>
> &b.bar[1] = 0x1fd403c
>
> &b.bar[2] = 0x1fd4040
>
> &b.bar[3] = 0x1fd4044
>
> Which is exactly what you'd expect.  I'm not strongly advocating we 
> change the PP code just noting it's not really clear that it's correct 
> from a first reading and in theory would be better with [0].
>
> Tom
>
> ------------------------------------------------------------------------
>
> *From:*Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
> *Sent:* Thursday, August 18, 2016 11:33
> *To:* StDenis, Tom
> *Cc:* Christian König; amd-gfx list
> *Subject:* Re: tidy'ing up cz_hwmgr.c
>
> The problem we ran into was when we had a struct like this:
>
> struct table {
>
>    uint16_t size;
>
>    struct element elements[0];
>
> };
>
> and then we would try and index the array:
>
> for (i = 0; i < table->size; i++) {
>
>   element = &table->elements[i];
>
> }
>
> element ended up off in the weeds.  The only thing that seems to make 
> some versions of gcc happy was pointer arithmetic. E.g.,
>
> element = (struct element *)((char *)&table->elements[0] + 
> (sizeof(struct element) * i));
>
> Alex
>
> On Thu, Aug 18, 2016 at 11:21 AM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org 
> <mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:
>
> Any modern GCC should support [0] at the tail of a struct.  This came 
> up because when I was reading the code I saw they allocated 7 slots 
> (plus the size of the struct) but then fill 8 slots.  It's just weird ��
>
> Using [0] in the struct and allocating for 8 entries makes more sense 
> and is clearer to read.
>
> Tom
>
> ------------------------------------------------------------------------
>
> *From:*Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org 
> <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>>
> *Sent:* Thursday, August 18, 2016 11:17
> *To:* StDenis, Tom; amd-gfx list
> *Subject:* Re: tidy'ing up cz_hwmgr.c
>
>     Has a [1] array at the tail which is then kzalloc'ed with N-1
>     entries. Shouldn't that just be a [0] with N entries allocated for
>     clarity?
>
> Actually the starting address of a dynamic array should be manually 
> calculated instead of using [1] or [0].
>
> We had tons of problems with that because some gcc versions get this 
> wrong and the atombios code used this as well.
>
> Alex how did we resolved such issues?
>
> Regards,
> Christian.
>
> Am 18.08.2016 um 16:26 schrieb StDenis, Tom:
>
>     Tidying up cz_hwmgr.c I noted a couple of things but first is
>
>     static bool cz_dpm_check_smu_features(struct pp_hwmgr *hwmgr,
>
>     unsigned long check_feature);
>
>     Which will return "true" if the smu call fails *or* the feature is
>     set.
>
>     The structure
>
>     struct phm_clock_voltage_dependency_table;
>
>     Has a [1] array at the tail which is then kzalloc'ed with N-1
>     entries. Shouldn't that just be a [0] with N entries allocated for
>     clarity?
>
>     Tom
>
>
>
>     _______________________________________________
>
>     amd-gfx mailing list
>
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------7C53B9404AB99D52034D39D6
Content-Type: multipart/related;
 boundary="------------76920BC5009FD07F61C59E6B"


--------------76920BC5009FD07F61C59E6B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <p><span style="color: rgb(36, 39, 41); font-family: Arial,
            &quot;Helvetica Neue&quot;, Helvetica, sans-serif;
            font-size: 15px; line-height: 19.5px; background-color:
            rgb(255, 248, 220);">Either way like I said I'm not strongly
            motivated to change it just caught my attention.</span></p>
      </blockquote>
      Well if you have time it would be really cool if you could a)
      identify such cases before we run into issues with some gcc
      versions again and b) leave the people who added the code and/or
      are responsible for this part of the driver a note to fix it.<br>
      <br>
      We really had a headache with those things because of the coding
      style in the atom headers and I would really like to avoid that in
      the future.<br>
      <br>
      Thanks in advance,<br>
      Christian.<br>
      <br>
      Am 18.08.2016 um 17:53 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB11323E186DB7B5F065790EA9F7150-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>Thanks Alex and Christian,</p>
        <p><br>
        </p>
        <p>Yup turns out [0] is not ISO C but [] is (from the googles)</p>
        <p><br>
        </p>
        <p><strong style="margin: 0px; padding: 0px; border: 0px;
            font-size: 15px; color: rgb(36, 39, 41); font-family: Arial,
            &quot;Helvetica Neue&quot;, Helvetica, sans-serif;
            line-height: 19.5px; background-color: rgb(255, 248, 220);">C99
            6.7.2.1, §16</strong><span style="color: rgb(36, 39, 41);
            font-family: Arial, &quot;Helvetica Neue&quot;, Helvetica,
            sans-serif; font-size: 15px; line-height: 19.5px;
            background-color: rgb(255, 248, 220);">: As a special case,
            the last element of a structure with more than one named
            member may have an incomplete array type; this is called a
            flexible array member.</span><br>
        </p>
        <p><span style="color: rgb(36, 39, 41); font-family: Arial,
            &quot;Helvetica Neue&quot;, Helvetica, sans-serif;
            font-size: 15px; line-height: 19.5px; background-color:
            rgb(255, 248, 220);"><br>
          </span></p>
        <p><span style="color: rgb(36, 39, 41); font-family: Arial,
            &quot;Helvetica Neue&quot;, Helvetica, sans-serif;
            font-size: 15px; line-height: 19.5px; background-color:
            rgb(255, 248, 220);">Either way like I said I'm not strongly
            motivated to change it just caught my attention.</span></p>
        <p><span style="color: rgb(36, 39, 41); font-family: Arial,
            &quot;Helvetica Neue&quot;, Helvetica, sans-serif;
            font-size: 15px; line-height: 19.5px; background-color:
            rgb(255, 248, 220);"><br>
          </span></p>
        <p><font color="#242729" face="Arial, Helvetica Neue, Helvetica,
            sans-serif"><span style="font-size: 15px; line-height:
              19.5px; background-color: rgb(255, 248, 220);">Cheers,</span></font></p>
        <p><font color="#242729" face="Arial, Helvetica Neue, Helvetica,
            sans-serif"><span style="font-size: 15px; line-height:
              19.5px; background-color: rgb(255, 248, 220);">Tom</span></font></p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              Deucher, Alexander<br>
              <b>Sent:</b> Thursday, August 18, 2016 11:50<br>
              <b>To:</b> StDenis, Tom; Alex Deucher<br>
              <b>Cc:</b> Christian König; amd-gfx list<br>
              <b>Subject:</b> RE: tidy'ing up cz_hwmgr.c</font>
            <div> </div>
          </div>
          <div>
            <div>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;">
                <span style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:#1F497D">IIRC, zero sized arrays are not
                  technically allowed in C, although gcc allows them. 
                  As I said, some versions of gcc worked, others
                  didn't.  I'm not sure why.  Also, my example was
                  slightly wrong.  atombios.h uses arrays of size 1, not
                  0.  So my example should look like:</span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;">
                <span style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:#1F497D"> </span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;
                background: white;">
                <span
                  style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:black">struct table {</span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;
                background: white;">
                <span
                  style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:black">   uint16_t size;</span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;
                background: white;">
                <span
                  style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:black">   struct element elements[1];</span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;
                background: white;">
                <span
                  style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:black">};</span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;">
                <span style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:#1F497D"> </span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;">
                <span style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:#1F497D">atombios.h uses [1] since I don't think
                  [0] is portable.  The same indexing issue applies to
                  [1].</span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;">
                <span style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:#1F497D"> </span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;">
                <span style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:#1F497D">Alex</span></p>
              <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                font-family: &quot;Times New Roman&quot;, serif;">
                <span style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                  color:#1F497D"> </span></p>
              <div style="border:none; border-left:solid blue 1.5pt;
                padding:0in 0in 0in 4.0pt">
                <div>
                  <div style="border:none; border-top:solid #B5C4DF
                    1.0pt; padding:3.0pt 0in 0in 0in">
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;">
                      <b><span style="font-size:10.0pt;
                          font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span
                        style="font-size:10.0pt;
                        font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">
                        amd-gfx
                        [<a class="moz-txt-link-freetext" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
                        <b>On Behalf Of </b>StDenis, Tom<br>
                        <b>Sent:</b> Thursday, August 18, 2016 11:40 AM<br>
                        <b>To:</b> Alex Deucher<br>
                        <b>Cc:</b> Christian König; amd-gfx list<br>
                        <b>Subject:</b> Re: tidy'ing up cz_hwmgr.c</span></p>
                  </div>
                </div>
                <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                  font-family: &quot;Times New Roman&quot;, serif;">
                   </p>
                <div id="divtagdefaultwrapper">
                  <p style="background:white"><span
                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                      color:black">It had to be something more
                      complicated because this demo program</span></p>
                  <p style="background:white"><span
                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                      color:black"> </span></p>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">#include &lt;stdio.h&gt;</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">#include &lt;stdlib.h&gt;</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"> </span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">struct one {</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">char *foo;</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">int bar[0];</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">};</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"> </span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">struct two {</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">char *foo;</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">int bar[1];</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">};</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"> </span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">int main(void)</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">{</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">struct one *a = calloc(1,
                        sizeof(struct one) + 4 * sizeof(int));</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">struct two *b = calloc(1,
                        sizeof(struct two) + 3 * sizeof(int));</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">int x;</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"> </span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">printf("a == %p\n", a);</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">for (x = 0; x &lt; 4; x++)</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">printf("&amp;a.bar[%d] = %p\n", x,
                        &amp;a-&gt;bar[x]);</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"> </span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">printf("b == %p\n", b);</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">for (x = 0; x &lt; 4; x++)</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">printf("&amp;b.bar[%d] = %p\n", x,
                        &amp;b-&gt;bar[x]);</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"> </span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">return 0;</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">}</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"> </span></p>
                  </div>
                  <p style="background:white"><span
                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                      color:black">produces this output</span></p>
                  <p style="background:white"><span
                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                      color:black"> </span></p>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">tom@fx8:~$ gcc test.c -o test</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">tom@fx8:~$ ./test</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">a == 0x1fd4010</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">&amp;a.bar[0] = 0x1fd4018</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">&amp;a.bar[1] = 0x1fd401c</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">&amp;a.bar[2] = 0x1fd4020</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">&amp;a.bar[3] = 0x1fd4024</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">b == 0x1fd4030</span><span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">&amp;b.bar[0] = 0x1fd4038</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">&amp;b.bar[1] = 0x1fd403c</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">&amp;b.bar[2] = 0x1fd4040</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span style="font-family:&quot;Courier New&quot;;
                        color:black">&amp;b.bar[3] = 0x1fd4044</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"></span></p>
                  </div>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"> </span></p>
                  </div>
                  <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                    font-family: &quot;Times New Roman&quot;, serif;
                    background: white;">
                    <span
                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                      color:black">Which is exactly what you'd expect.
                       I'm not strongly advocating we change the PP code
                      just noting it's not really clear that it's
                      correct from a first reading and in theory would
                      be better with [0]. </span></p>
                  <div>
                    <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                      font-family: &quot;Times New Roman&quot;, serif;
                      background: white;">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black"> </span></p>
                  </div>
                  <p style="margin: 0in 0in 0.0001pt; font-size: 12pt;
                    font-family: &quot;Times New Roman&quot;, serif;
                    background: white;">
                    <span
                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                      color:black">Tom</span></p>
                  <div>
                    <div style="text-align: center; margin: 0in 0in
                      0.0001pt; font-size: 12pt; font-family:
                      &quot;Times New Roman&quot;, serif; background:
                      white;" align="center">
                      <span
                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                        color:black">
                        <hr width="98%" align="center" size="2">
                      </span></div>
                    <div id="divRplyFwdMsg">
                      <p style="margin: 0in 0in 0.0001pt; font-size:
                        12pt; font-family: &quot;Times New Roman&quot;,
                        serif; background: white;">
                        <b><span style="font-size:11.0pt;
                            font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                            color:black">From:</span></b><span
                          style="font-size:11.0pt;
                          font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                          color:black"> Alex Deucher &lt;<a
                            moz-do-not-send="true"
                            href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                            style="color: blue; text-decoration:
                            underline;">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                          <b>Sent:</b> Thursday, August 18, 2016 11:33<br>
                          <b>To:</b> StDenis, Tom<br>
                          <b>Cc:</b> Christian König; amd-gfx list<br>
                          <b>Subject:</b> Re: tidy'ing up cz_hwmgr.c</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                          color:black">
                        </span></p>
                      <div>
                        <p style="margin: 0in 0in 0.0001pt; font-size:
                          12pt; font-family: &quot;Times New
                          Roman&quot;, serif; background: white;">
                          <span
                            style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                            color:black"> </span></p>
                      </div>
                    </div>
                    <div>
                      <div>
                        <div>
                          <div>
                            <div>
                              <p style="margin: 0in 0in 0.0001pt;
                                font-size: 12pt; font-family:
                                &quot;Times New Roman&quot;, serif;
                                background: white;">
                                <span
                                  style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                  color:black">The problem we ran into
                                  was when we had a struct like this:</span></p>
                            </div>
                            <p style="margin: 0in 0in 0.0001pt;
                              font-size: 12pt; font-family: &quot;Times
                              New Roman&quot;, serif; background:
                              white;">
                              <span
                                style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                color:black">struct table {</span></p>
                          </div>
                          <p style="margin: 0in 0in 0.0001pt; font-size:
                            12pt; font-family: &quot;Times New
                            Roman&quot;, serif; background: white;">
                            <span
                              style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                              color:black">   uint16_t size;</span></p>
                        </div>
                        <p style="margin: 0in 0in 0.0001pt; font-size:
                          12pt; font-family: &quot;Times New
                          Roman&quot;, serif; background: white;">
                          <span
                            style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                            color:black">   struct element elements[0];</span></p>
                        <div>
                          <div>
                            <p style="margin: 0in 0in 0.0001pt;
                              font-size: 12pt; font-family: &quot;Times
                              New Roman&quot;, serif; background:
                              white;">
                              <span
                                style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                color:black">};</span></p>
                            <div>
                              <div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black"> </span></p>
                                </div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black">and then we would try
                                      and index the array:</span></p>
                                </div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black">for (i = 0; i &lt;
                                      table-&gt;size; i++) {</span></p>
                                </div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black">  element =
                                      &amp;table-&gt;elements[i];</span></p>
                                </div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black">}</span></p>
                                </div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black">element ended up off
                                      in the weeds.  The only thing that
                                      seems to make some versions of gcc
                                      happy was pointer arithmetic. 
                                      E.g.,</span></p>
                                </div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black"> </span></p>
                                </div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black">element = (struct
                                      element *)((char
                                      *)&amp;table-&gt;elements[0] +
                                      (sizeof(struct element) * i));</span></p>
                                </div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black">Alex</span></p>
                                </div>
                                <div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black"> </span></p>
                                  <div>
                                    <p style="margin: 0in 0in 0.0001pt;
                                      font-size: 12pt; font-family:
                                      &quot;Times New Roman&quot;,
                                      serif; background: white;">
                                      <span
                                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                        color:black">On Thu, Aug 18,
                                        2016 at 11:21 AM, StDenis, Tom
                                        &lt;<a moz-do-not-send="true"
                                          href="mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org"
                                          target="_blank" style="color:
                                          blue; text-decoration:
                                          underline;">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;
                                        wrote:</span></p>
                                    <div>
                                      <div>
                                        <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                            color:black">Any modern GCC
                                            should support [0] at the
                                            tail of a struct.  This came
                                            up because when I was
                                            reading the code I saw they
                                            allocated 7 slots (plus the
                                            size of the struct) but then
                                            fill 8 slots.  It's just
                                            weird <img
                                              id="_x0000_i1026" alt="��"
                                              tabindex="0"
                                              style="-webkit-user-select:
                                              none;"
                                              src="cid:part3.F176A269.01DFF465-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
                                              width="19" border="0"
                                              height="19"></span></p>
                                        <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                            color:black"> </span></p>
                                        <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                            color:black">Using [0] in
                                            the struct and allocating
                                            for 8 entries makes more
                                            sense and is clearer to
                                            read.</span></p>
                                        <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                            color:black"> </span></p>
                                        <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                            color:black">Tom</span></p>
                                        <p style="margin: 0in 0in
                                          0.0001pt; font-size: 12pt;
                                          font-family: &quot;Times New
                                          Roman&quot;, serif;
                                          background: white;">
                                          <span
                                            style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                            color:black"> </span></p>
                                        <div>
                                          <div style="text-align:
                                            center; margin: 0in 0in
                                            0.0001pt; font-size: 12pt;
                                            font-family: &quot;Times New
                                            Roman&quot;, serif;
                                            background: white;"
                                            align="center">
                                            <span
                                              style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                              color:black">
                                              <hr width="98%"
                                                align="center" size="2">
                                            </span></div>
                                          <div>
                                            <p style="margin: 0in 0in
                                              0.0001pt; font-size: 12pt;
                                              font-family: &quot;Times
                                              New Roman&quot;, serif;
                                              background: white;">
                                              <b><span
                                                  style="font-size:11.0pt;
font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black">From:</span></b><span
                                                style="font-size:11.0pt;
font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black">
                                                Christian König &lt;<a
                                                  moz-do-not-send="true"
href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" target="_blank" style="color:
                                                  blue; text-decoration:
                                                  underline;">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;<br>
                                                <b>Sent:</b> Thursday,
                                                August 18, 2016 11:17<br>
                                                <b>To:</b> StDenis, Tom;
                                                amd-gfx list<br>
                                                <b>Subject:</b> Re:
                                                tidy'ing up cz_hwmgr.c</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                color:black">
                                              </span></p>
                                            <div>
                                              <p style="margin: 0in 0in
                                                0.0001pt; font-size:
                                                12pt; font-family:
                                                &quot;Times New
                                                Roman&quot;, serif;
                                                background: white;">
                                                <span
                                                  style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                  color:black"> </span></p>
                                            </div>
                                          </div>
                                          <div>
                                            <div>
                                              <div>
                                                <div>
                                                  <blockquote
                                                    style="margin-top:5.0pt;
                                                    margin-bottom:5.0pt">
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black">Has
                                                          a [1] array at
                                                          the tail which
                                                          is then
                                                          kzalloc'ed
                                                          with N-1
                                                          entries. 
                                                          Shouldn't that
                                                          just be a [0]
                                                          with N entries
                                                          allocated for
                                                          clarity?</span></p>
                                                    </div>
                                                  </blockquote>
                                                  <p style="margin: 0in
                                                    0in 0.0001pt;
                                                    font-size: 12pt;
                                                    font-family:
                                                    &quot;Times New
                                                    Roman&quot;, serif;
                                                    background: white;">
                                                    <span
                                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                      color:black">Actually
                                                      the starting
                                                      address of a
                                                      dynamic array
                                                      should be manually
                                                      calculated instead
                                                      of using [1] or
                                                      [0].<br>
                                                      <br>
                                                      We had tons of
                                                      problems with that
                                                      because some gcc
                                                      versions get this
                                                      wrong and the
                                                      atombios code used
                                                      this as well.<br>
                                                      <br>
                                                      Alex how did we
                                                      resolved such
                                                      issues?<br>
                                                      <br>
                                                      Regards,<br>
                                                      Christian.<br>
                                                      <br>
                                                      Am 18.08.2016 um
                                                      16:26 schrieb
                                                      StDenis, Tom:</span></p>
                                                </div>
                                                <blockquote
                                                  style="margin-top:5.0pt;
                                                  margin-bottom:5.0pt">
                                                  <div>
                                                    <p
                                                      style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                        color:black">Tidying
                                                        up cz_hwmgr.c I
                                                        noted a couple
                                                        of things but
                                                        first is </span></p>
                                                    <p
                                                      style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                        color:black"> </span></p>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Courier
                                                          New&quot;;
                                                          color:black">static
                                                          bool
                                                          cz_dpm_check_smu_features(struct
                                                          pp_hwmgr
                                                          *hwmgr,</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black"></span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Courier
                                                          New&quot;;
                                                          color:black">unsigned
                                                          long
                                                          check_feature);</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black"></span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black"> </span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black">Which
                                                          will return
                                                          "true" if the
                                                          smu call fails
                                                          <b>or</b> the
                                                          feature is
                                                          set.  </span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black"> </span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black">The
                                                          structure </span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black"> </span></p>
                                                    </div>
                                                    <div>
                                                      <div>
                                                        <p
                                                          style="margin:
                                                          0in 0in
                                                          0.0001pt;
                                                          font-size:
                                                          12pt;
                                                          font-family:
                                                          &quot;Times
                                                          New
                                                          Roman&quot;,
                                                          serif;
                                                          background:
                                                          white;">
                                                          <span
                                                          style="font-family:&quot;Courier
                                                          New&quot;;
                                                          color:black">struct
phm_clock_voltage_dependency_table;</span><span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black"></span></p>
                                                      </div>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black"> </span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black">Has
                                                          a [1] array at
                                                          the tail which
                                                          is then
                                                          kzalloc'ed
                                                          with N-1
                                                          entries. 
                                                          Shouldn't that
                                                          just be a [0]
                                                          with N entries
                                                          allocated for
                                                          clarity?</span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black"> </span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black">Tom</span></p>
                                                    </div>
                                                    <div>
                                                      <p style="margin:
                                                        0in 0in
                                                        0.0001pt;
                                                        font-size: 12pt;
                                                        font-family:
                                                        &quot;Times New
                                                        Roman&quot;,
                                                        serif;
                                                        background:
                                                        white;">
                                                        <span
                                                          style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                          color:black"> </span></p>
                                                    </div>
                                                  </div>
                                                  <p style="margin: 0in
                                                    0in 0.0001pt;
                                                    font-size: 12pt;
                                                    font-family:
                                                    &quot;Times New
                                                    Roman&quot;, serif;
                                                    background: white;">
                                                    <span
                                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                      color:black"><br>
                                                      <br>
                                                    </span></p>
                                                  <pre style="margin: 0in 0in 0.0001pt; font-size: 10pt; font-family: &quot;Courier New&quot;; background: white;"><span style="color:black">_______________________________________________</span></pre>
                                                  <pre style="margin: 0in 0in 0.0001pt; font-size: 10pt; font-family: &quot;Courier New&quot;; background: white;"><span style="color:black">amd-gfx mailing list</span></pre>
                                                  <pre style="margin: 0in 0in 0.0001pt; font-size: 10pt; font-family: &quot;Courier New&quot;; background: white;"><span style="color:black"><a moz-do-not-send="true" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank" style="color: blue; text-decoration: underline;">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></span></pre>
                                                  <pre style="margin: 0in 0in 0.0001pt; font-size: 10pt; font-family: &quot;Courier New&quot;; background: white;"><span style="color:black"><a moz-do-not-send="true" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target="_blank" style="color: blue; text-decoration: underline;">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></span></pre>
                                                </blockquote>
                                                <p
                                                  style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                                    color:black"> </span></p>
                                              </div>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                    <p style="margin: 0in 0in 0.0001pt;
                                      font-size: 12pt; font-family:
                                      &quot;Times New Roman&quot;,
                                      serif; background: white;">
                                      <span
                                        style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                        color:black"><br>
_______________________________________________<br>
                                        amd-gfx mailing list<br>
                                        <a moz-do-not-send="true"
                                          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                          style="color: blue;
                                          text-decoration: underline;">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                        <a moz-do-not-send="true"
                                          href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                          target="_blank" style="color:
                                          blue; text-decoration:
                                          underline;">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></span></p>
                                  </div>
                                  <p style="margin: 0in 0in 0.0001pt;
                                    font-size: 12pt; font-family:
                                    &quot;Times New Roman&quot;, serif;
                                    background: white;">
                                    <span
                                      style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;
                                      color:black"> </span></p>
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
          </div>
        </div>
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

--------------76920BC5009FD07F61C59E6B
Content-Type: image/png
Content-Transfer-Encoding: base64
Content-ID: <part3.F176A269.01DFF465-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

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
--------------76920BC5009FD07F61C59E6B--

--------------7C53B9404AB99D52034D39D6--

--===============1705543601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1705543601==--
