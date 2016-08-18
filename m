From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: tidy'ing up cz_hwmgr.c
Date: Thu, 18 Aug 2016 17:17:39 +0200
Message-ID: <642600e3-dd63-7b36-a749-451a451ab153@vodafone.de>
References: <DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0576035680=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0576035680==
Content-Type: multipart/alternative;
 boundary="------------1E9790D74E7916F546273721"

This is a multi-part message in MIME format.
--------------1E9790D74E7916F546273721
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

> Has a [1] array at the tail which is then kzalloc'ed with N-1 entries. 
>  Shouldn't that just be a [0] with N entries allocated for clarity?
Actually the starting address of a dynamic array should be manually 
calculated instead of using [1] or [0].

We had tons of problems with that because some gcc versions get this 
wrong and the atombios code used this as well.

Alex how did we resolved such issues?

Regards,
Christian.

Am 18.08.2016 um 16:26 schrieb StDenis, Tom:
>
> Tidying up cz_hwmgr.c I noted a couple of things but first is
>
>
> static bool cz_dpm_check_smu_features(struct pp_hwmgr *hwmgr,
> unsigned long check_feature);
>
> Which will return "true" if the smu call fails *or* the feature is set.
>
> The structure
>
> struct phm_clock_voltage_dependency_table;
>
> Has a [1] array at the tail which is then kzalloc'ed with N-1 entries. 
>  Shouldn't that just be a [0] with N entries allocated for clarity?
>
> Tom
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------1E9790D74E7916F546273721
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <div>Has a [1] array at the tail which is then kzalloc'ed with
          N-1 entries.  Shouldn't that just be a [0] with N entries
          allocated for clarity?</div>
      </blockquote>
      Actually the starting address of a dynamic array should be
      manually calculated instead of using [1] or [0].<br>
      <br>
      We had tons of problems with that because some gcc versions get
      this wrong and the atombios code used this as well.<br>
      <br>
      Alex how did we resolved such issues?<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 18.08.2016 um 16:26 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB1132F1D9FF8F44E09BE37EF4F7150-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>Tidying up cz_hwmgr.c I noted a couple of things but first
          is </p>
        <p><br>
        </p>
        <div><span style="font-family: &quot;Courier New&quot;,
            monospace;">static bool cz_dpm_check_smu_features(struct
            pp_hwmgr *hwmgr,</span></div>
        <div><span class="Apple-tab-span" style="white-space: pre; font-family: &quot;Courier New&quot;, monospace;"></span><span
            style="font-family: &quot;Courier New&quot;, monospace;">unsigned
            long check_feature);</span></div>
        <div><br>
        </div>
        <div>Which will return "true" if the smu call fails <b>or</b> the
          feature is set.  </div>
        <div><br>
        </div>
        <div>The structure </div>
        <div><br>
        </div>
        <div>
          <div><span style="font-family: &quot;Courier New&quot;,
              monospace;">struct phm_clock_voltage_dependency_table;</span></div>
        </div>
        <div><br>
        </div>
        <div>Has a [1] array at the tail which is then kzalloc'ed with
          N-1 entries.  Shouldn't that just be a [0] with N entries
          allocated for clarity?</div>
        <div><br>
        </div>
        <div>Tom</div>
        <div><br>
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

--------------1E9790D74E7916F546273721--

--===============0576035680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0576035680==--
