From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] drm/amdkfd: Use logical cpu id for building vcrat
Date: Tue, 16 Apr 2019 08:44:37 +0200
Message-ID: <f9597352-4f96-9519-d03e-69f8c6c3c70b@gmail.com>
References: <84019ce7-4bda-4740-81f7-bfeb06f11b13@BY2NAM03FT064.eop-NAM03.prod.protection.outlook.com>
 <87066753-b061-da00-9795-ca38ada81622@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0143932078=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <87066753-b061-da00-9795-ca38ada81622-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Hillf Danton <hdanton-k+cT0dCbe1g@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Mark Nutter <Mark.Nutter-5wv7dgnIgG8@public.gmane.org>" <Mark.Nutter-5wv7dgnIgG8@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>" <arnd-r2nGTMty4D4@public.gmane.org>, "Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>

This is a multi-part message in MIME format.
--===============0143932078==
Content-Type: multipart/alternative;
 boundary="------------F49A35958949D884242BAD29"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F49A35958949D884242BAD29
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> It's not a high priority as I'm not aware of any applications that 
> actually make use of the cache information.
>
Which raises the question why we have done this in the first place? When 
nobody is using it could we just remove the interface?

Regards,
Christian.

Am 16.04.19 um 05:24 schrieb Kuehling, Felix:
>
> On x86 we use the apicid to associate caches with CPU cores. See the 
> Thunk code in libhsakmt/src/topology.c (static void 
> find_cpu_cache_siblings()). If we used a different way to identify CPU 
> cores, I think that would break. This code in the Thunk is 
> x86-specific as it uses the CPUID instruction. We don't have 
> equivalent code for ARM. So for ARM it doesn't really matter much, how 
> you count your CPU cores in the CRAT table.
>
> I think eventually we want to get rid of that fragile CPUID code in 
> the Thunk and get the cache information in kernel mode and report it 
> to user mode through the KFD topology sysfs filesystem. Then we could 
> also move away from using apicids as CPU IDs on x86.
>
> It's not a high priority as I'm not aware of any applications that 
> actually make use of the cache information.
>
> Regards,
>   Felix
>
> On 2019-04-15 22:39, Hillf Danton wrote:
>>
>> Hi folks
>>
>> In commit d1c234e2cd, arm64 is granted to build kfd. Currently, it is 
>> physical
>>
>> cpu id that is used for building the x86_64 vcrat, but logical cpu id 
>> is used
>>
>> instead for arm64, though the function name requires apicid. Can we 
>> use the
>>
>> physical id for both arches if it really has an up-hand over the 
>> logical one,
>>
>> as the following tiny diff represents?
>>
>> --- linux-5.1-rc4/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>> 2019-04-16 07:55:56.611685400 +0800
>>
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 2019-04-16 
>> 09:16:50.506126600 +0800
>>
>> @@ -1405,11 +1405,7 @@ static int kfd_cpumask_to_apic_id(const
>>
>> first_cpu_of_numa_node = cpumask_first(cpumask);
>>
>>        if (first_cpu_of_numa_node >= nr_cpu_ids)
>>
>>              return -1;
>>
>> -#ifdef CONFIG_X86_64
>>
>> -     return cpu_data(first_cpu_of_numa_node).apicid;
>>
>> -#else
>>
>> -     return first_cpu_of_numa_node;
>>
>> -#endif
>>
>> +    return cpu_physical_id(first_cpu_of_numa_node);
>>
>> }
>>
>> /* kfd_numa_node_to_apic_id - Returns the APIC ID of the first 
>> logical processor
>>
>> --
>>
>> Or is logical cpu id enough to do the work, with some cosmetic 
>> applied to the
>>
>> function names(not included in the following simple diff yet)?
>>
>> thanks
>>
>> Hillf
>>
>> --- linux-5.1-rc4/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>> 2019-04-16 07:55:56.611685400 +0800
>>
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 2019-04-16 
>> 09:18:24.546578400 +0800
>>
>> @@ -1405,11 +1405,7 @@ static int kfd_cpumask_to_apic_id(const
>>
>> first_cpu_of_numa_node = cpumask_first(cpumask);
>>
>>        if (first_cpu_of_numa_node >= nr_cpu_ids)
>>
>>              return -1;
>>
>> -#ifdef CONFIG_X86_64
>>
>> -     return cpu_data(first_cpu_of_numa_node).apicid;
>>
>> -#else
>>
>>        return first_cpu_of_numa_node;
>>
>> -#endif
>>
>> }
>>
>> /* kfd_numa_node_to_apic_id - Returns the APIC ID of the first 
>> logical processor
>>
>> --
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------F49A35958949D884242BAD29
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <p>It's not a high priority as I'm not aware of any applications
          that actually make use of the cache information.</p>
        <p></p>
      </blockquote>
      Which raises the question why we have done this in the first
      place? When nobody is using it could we just remove the interface?<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 16.04.19 um 05:24 schrieb Kuehling, Felix:<br>
    </div>
    <blockquote type="cite"
      cite="mid:87066753-b061-da00-9795-ca38ada81622-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>On x86 we use the apicid to associate caches with CPU cores.
        See the Thunk code in libhsakmt/src/topology.c (static void
        find_cpu_cache_siblings()). If we used a different way to
        identify CPU cores, I think that would break. This code in the
        Thunk is x86-specific as it uses the CPUID instruction. We don't
        have equivalent code for ARM. So for ARM it doesn't really
        matter much, how you count your CPU cores in the CRAT table.</p>
      <p>I think eventually we want to get rid of that fragile CPUID
        code in the Thunk and get the cache information in kernel mode
        and report it to user mode through the KFD topology sysfs
        filesystem. Then we could also move away from using apicids as
        CPU IDs on x86.<br>
      </p>
      <p>It's not a high priority as I'm not aware of any applications
        that actually make use of the cache information.</p>
      <p>Regards,<br>
          Felix<br>
      </p>
      <div class="moz-cite-prefix">On 2019-04-15 22:39, Hillf Danton
        wrote:<br>
      </div>
      <blockquote type="cite"
cite="mid:84019ce7-4bda-4740-81f7-bfeb06f11b13-9zgFLTTCnj2VNr1+fo7GR8DXdtEM2QSaEmlz1D7Bsj1Om+2sqEXiZ9VYi19F/pQSQQ4Iyu8u01E@public.gmane.org">
        <meta name="Generator" content="Microsoft Word 15 (filtered
          medium)">
        <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
        <div class="WordSection1">
          <p class="MsoNormal"><span lang="EN-US">Hi folks</span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">In commit d1c234e2cd,
              arm64 is granted to build kfd. Currently, it is physical</span></p>
          <p class="MsoNormal"><span lang="EN-US">cpu id that is used
              for building the x86_64 vcrat, but logical cpu id is used</span></p>
          <p class="MsoNormal"><span lang="EN-US">instead for arm64,
              though the function name requires apicid. Can we use the</span></p>
          <p class="MsoNormal"><span lang="EN-US">physical id for both
              arches if it really has an up-hand over the logical one,</span></p>
          <p class="MsoNormal"><span lang="EN-US">as the following tiny
              diff represents?</span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">---
              linux-5.1-rc4/drivers/gpu/drm/amd/amdkfd/kfd_topology.c   
              2019-04-16 07:55:56.611685400 +0800</span></p>
          <p class="MsoNormal"><span lang="EN-US">+++
              b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 2019-04-16
              09:16:50.506126600 +0800</span></p>
          <p class="MsoNormal"><span lang="EN-US">@@ -1405,11 +1405,7 @@
              static int kfd_cpumask_to_apic_id(const</span></p>
          <p class="MsoNormal"><span lang="EN-US">      
              first_cpu_of_numa_node = cpumask_first(cpumask);</span></p>
          <p class="MsoNormal"><span lang="EN-US">       if
              (first_cpu_of_numa_node &gt;= nr_cpu_ids)</span></p>
          <p class="MsoNormal"><span lang="EN-US">             return
              -1;</span></p>
          <p class="MsoNormal"><span lang="EN-US">-#ifdef CONFIG_X86_64</span></p>
          <p class="MsoNormal"><span lang="EN-US">-     return
              cpu_data(first_cpu_of_numa_node).apicid;</span></p>
          <p class="MsoNormal"><span lang="EN-US">-#else</span></p>
          <p class="MsoNormal"><span lang="EN-US">-     return
              first_cpu_of_numa_node;</span></p>
          <p class="MsoNormal"><span lang="EN-US">-#endif</span></p>
          <p class="MsoNormal"><span lang="EN-US">+    return
              cpu_physical_id(first_cpu_of_numa_node);</span></p>
          <p class="MsoNormal"><span lang="EN-US">}</span></p>
          <p class="MsoNormal"><span lang="EN-US">/*
              kfd_numa_node_to_apic_id - Returns the APIC ID of the
              first logical processor</span></p>
          <p class="MsoNormal"><span lang="EN-US">--</span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">Or is logical cpu id
              enough to do the work, with some cosmetic applied to the
            </span></p>
          <p class="MsoNormal"><span lang="EN-US">function names(not
              included in the following simple diff yet)?</span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">thanks</span></p>
          <p class="MsoNormal"><span lang="EN-US">Hillf</span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">---
              linux-5.1-rc4/drivers/gpu/drm/amd/amdkfd/kfd_topology.c   
              2019-04-16 07:55:56.611685400 +0800</span></p>
          <p class="MsoNormal"><span lang="EN-US">+++
              b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 2019-04-16
              09:18:24.546578400 +0800</span></p>
          <p class="MsoNormal"><span lang="EN-US">@@ -1405,11 +1405,7 @@
              static int kfd_cpumask_to_apic_id(const</span></p>
          <p class="MsoNormal"><span lang="EN-US">      
              first_cpu_of_numa_node = cpumask_first(cpumask);</span></p>
          <p class="MsoNormal"><span lang="EN-US">       if
              (first_cpu_of_numa_node &gt;= nr_cpu_ids)</span></p>
          <p class="MsoNormal"><span lang="EN-US">             return
              -1;</span></p>
          <p class="MsoNormal"><span lang="EN-US">-#ifdef CONFIG_X86_64</span></p>
          <p class="MsoNormal"><span lang="EN-US">-     return
              cpu_data(first_cpu_of_numa_node).apicid;</span></p>
          <p class="MsoNormal"><span lang="EN-US">-#else</span></p>
          <p class="MsoNormal"><span lang="EN-US">       return
              first_cpu_of_numa_node;</span></p>
          <p class="MsoNormal"><span lang="EN-US">-#endif</span></p>
          <p class="MsoNormal"><span lang="EN-US">}</span></p>
          <p class="MsoNormal"><span lang="EN-US">/*
              kfd_numa_node_to_apic_id - Returns the APIC ID of the
              first logical processor</span></p>
          <p class="MsoNormal"><span lang="EN-US">--</span><span
              style="font-size:12.0pt" lang="EN-US"><o:p></o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        </div>
      </blockquote>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------F49A35958949D884242BAD29--

--===============0143932078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0143932078==--
