From: Kyle Mahlkuch <kmahlkuc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] drm/radeon: Fix EEH during kexec
Date: Fri, 25 Oct 2019 15:49:38 -0500
Message-ID: <0064d9ea-4749-0129-05b1-99697fb58730@linux.vnet.ibm.com>
References: <1570736672-10644-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
 <20191011042734.GA939089@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0540271174=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191011042734.GA939089-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--===============0540271174==
Content-Type: multipart/alternative;
 boundary="------------761D57267238DBBF77BF895E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------761D57267238DBBF77BF895E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/10/19 11:27 PM, Greg KH wrote:

> On Thu, Oct 10, 2019 at 02:44:29PM -0500, KyleMahlkuch wrote:
>> During kexec some adapters hit an EEH since they are not properly
>> shut down in the radeon_pci_shutdown() function. Adding
>> radeon_suspend_kms() fixes this issue.
>> Enabled only on PPC because this patch causes issues on some other
>> boards.
>>
>> Signed-off-by: Kyle Mahlkuch <Kyle.Mahlkuch at ibm.com>
> Real email address please, with a '@' sign.
>
> And your "From:" line did not match up with this :(

Greg, thanks for your help, I've resubmitted my patch.

>> ---
>>   drivers/gpu/drm/radeon/radeon_drv.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>

--------------761D57267238DBBF77BF895E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">
      <pre>On 10/10/19 11:27 PM, Greg KH wrote:</pre>
    </div>
    <blockquote type="cite" cite="mid:20191011042734.GA939089-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">On Thu, Oct 10, 2019 at 02:44:29PM -0500, KyleMahlkuch wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">During kexec some adapters hit an EEH since they are not properly
shut down in the radeon_pci_shutdown() function. Adding
radeon_suspend_kms() fixes this issue.
Enabled only on PPC because this patch causes issues on some other
boards.

Signed-off-by: Kyle Mahlkuch &lt;Kyle.Mahlkuch at ibm.com&gt;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Real email address please, with a '@' sign.

And your "From:" line did not match up with this :(
</pre>
    </blockquote>
    <pre>Greg, thanks for your help, I've resubmitted my patch. 
</pre>
    <blockquote type="cite" cite="mid:20191011042734.GA939089-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 drivers/gpu/drm/radeon/radeon_drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
&lt;formletter&gt;

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    <a class="moz-txt-link-freetext" href="https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html">https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html</a>
for how to do this properly.

&lt;/formletter&gt;
</pre>
    </blockquote>
  </body>
</html>

--------------761D57267238DBBF77BF895E--


--===============0540271174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0540271174==--
