From: Kyle Mahlkuch <kmahlkuc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] drm/radeon: Fix EEH during kexec
Date: Thu, 31 Oct 2019 10:24:53 -0500
Message-ID: <412d6237-d5d7-cd4b-d227-0c84e776fae8@linux.vnet.ibm.com>
References: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
 <87o8xyfrmp.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1229226286=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <87o8xyfrmp.fsf-exYd9J+JjbNEdatCaa6vohCuuivNXqWP@public.gmane.org>
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
To: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1229226286==
Content-Type: multipart/alternative;
 boundary="------------1BFA037AD571F71D234D7E5D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1BFA037AD571F71D234D7E5D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/19 5:35 AM, Michael Ellerman wrote:

> Hi Kyle,
>
> KyleMahlkuch <kmahlkuc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org> writes:
>> From: Kyle Mahlkuch <kmahlkuc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
>>
>> During kexec some adapters hit an EEH since they are not properly
>> shut down in the radeon_pci_shutdown() function. Adding
>> radeon_suspend_kms() fixes this issue.
>> Enabled only on PPC because this patch causes issues on some other
>> boards.
> Which adapters hit the issues?
>
> And do we know why they're not shut down correctly in
> radeon_pci_shutdown()? That seems like the root cause no?

Hi Michael,
This is hit by the Caicos (edwards2) adapter that I have on ppc. It is not hit
on the Cedar (FirePro) adapter - though I haven't tested this one recently. I'm
not able to test any other adapters. As far as "why", I'm unsure. During
initialization after the kexec we hit an EEH. There could be another point in
the shutdown / start up process where something doesn't get reset correctly.
I'm open to other ideas if you have any.

>> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
>> index 9e55076..4528f4d 100644
>> --- a/drivers/gpu/drm/radeon/radeon_drv.c
>> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
>> @@ -379,11 +379,25 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>>   static void
>>   radeon_pci_shutdown(struct pci_dev *pdev)
>>   {
>> +#ifdef CONFIG_PPC64
>> +	struct drm_device *ddev = pci_get_drvdata(pdev);
>> +#endif
> This local serves no real purpose and could be avoided, which would also
> avoid this ifdef.
>
>>   	/* if we are running in a VM, make sure the device
>>   	 * torn down properly on reboot/shutdown
>>   	 */
>>   	if (radeon_device_is_virtual())
>>   		radeon_pci_remove(pdev);
>> +
>> +#ifdef CONFIG_PPC64
>> +	/* Some adapters need to be suspended before a
> AFAIK drm uses normal kernel comment style, so this should be:
>
> 	/*
> 	 * Some adapters need to be suspended before a
>> +	 * shutdown occurs in order to prevent an error
>> +	 * during kexec.
>> +	 * Make this power specific becauase it breaks
>> +	 * some non-power boards.
>> +	 */
>> +	radeon_suspend_kms(ddev, true, true, false);
> ie, instead do:
>
> 	radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);

I agree, this is a cleaner way to write this patch. I'll update the comment as
well. Thanks for the help.

>> +#endif
>>   }
>>   
>>   static int radeon_pmops_suspend(struct device *dev)
>> -- 
>> 1.8.3.1
> cheers
>

--------------1BFA037AD571F71D234D7E5D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <pre>
</pre>
    <div class="moz-cite-prefix">
      <pre>On 10/30/19 5:35 AM, Michael Ellerman wrote:</pre>
    </div>
    <blockquote type="cite" cite="mid:87o8xyfrmp.fsf-exYd9J+JjbNEdatCaa6vohCuuivNXqWP@public.gmane.org">
      <pre class="moz-quote-pre" wrap="">Hi Kyle,

KyleMahlkuch <a class="moz-txt-link-rfc2396E" href="mailto:kmahlkuc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org">&lt;kmahlkuc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org&gt;</a> writes:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">From: Kyle Mahlkuch <a class="moz-txt-link-rfc2396E" href="mailto:kmahlkuc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org">&lt;kmahlkuc-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org&gt;</a>

During kexec some adapters hit an EEH since they are not properly
shut down in the radeon_pci_shutdown() function. Adding
radeon_suspend_kms() fixes this issue.
Enabled only on PPC because this patch causes issues on some other
boards.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Which adapters hit the issues?

And do we know why they're not shut down correctly in
radeon_pci_shutdown()? That seems like the root cause no?</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">Hi Michael,
This is hit by the Caicos (edwards2) adapter that I have on ppc. It is not hit
on the Cedar (FirePro) adapter - though I haven't tested this one recently. I'm
not able to test any other adapters. As far as "why", I'm unsure. During
initialization after the kexec we hit an EEH. There could be another point in
the shutdown / start up process where something doesn't get reset correctly.
I'm open to other ideas if you have any.

</pre>
    <blockquote type="cite" cite="mid:87o8xyfrmp.fsf-exYd9J+JjbNEdatCaa6vohCuuivNXqWP@public.gmane.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 9e55076..4528f4d 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -379,11 +379,25 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
+#ifdef CONFIG_PPC64
+	struct drm_device *ddev = pci_get_drvdata(pdev);
+#endif
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This local serves no real purpose and could be avoided, which would also
avoid this ifdef.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown
 	 */
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
+
+#ifdef CONFIG_PPC64
+	/* Some adapters need to be suspended before a
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
AFAIK drm uses normal kernel comment style, so this should be:

	/*
	 * Some adapters need to be suspended before a
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+	 * shutdown occurs in order to prevent an error
+	 * during kexec.
+	 * Make this power specific becauase it breaks
+	 * some non-power boards.
+	 */
+	radeon_suspend_kms(ddev, true, true, false);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
ie, instead do:

	radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">I agree, this is a cleaner way to write this patch. I'll update the comment as
well. Thanks for the help. 

</pre>
    <blockquote type="cite" cite="mid:87o8xyfrmp.fsf-exYd9J+JjbNEdatCaa6vohCuuivNXqWP@public.gmane.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+#endif
 }
 
 static int radeon_pmops_suspend(struct device *dev)
-- 
1.8.3.1
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
cheers
</pre>
      <pre>

</pre>
    </blockquote>
  </body>
</html>

--------------1BFA037AD571F71D234D7E5D--


--===============1229226286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1229226286==--
