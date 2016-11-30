From: Jochen Rollwagen <joro-2013-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati] Replace loop with clz to calculate log
 base 2 on non-x86 platforms in radeon.h
Date: Wed, 30 Nov 2016 18:52:54 +0100
Message-ID: <583F11F6.7000005@t-online.de>
References: <58372ADA.8040009@t-online.de>
 <dd911a26-9976-6570-f5ac-5efe67e27928@daenzer.net>
 <58380BA2.3060006@t-online.de>
 <f3c04cd0-06b0-85c4-48d0-1bfbdd98dfdf@daenzer.net>
 <583C74DA.2070701@t-online.de>
 <e3556fa8-39eb-6b1d-9d71-316c23bff9ea@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0461226669=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e3556fa8-39eb-6b1d-9d71-316c23bff9ea-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0461226669==
Content-Type: multipart/alternative;
 boundary="------------020706050908000601060600"

This is a multi-part message in MIME format.
--------------020706050908000601060600
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 29.11.2016 um 08:32 schrieb Michel Dänzer:
> On 29/11/16 03:18 AM, Jochen Rollwagen wrote:
>> This commit replaces the loop for calculating log base 2 for
>> non-x86-platforms in radeon.h with a clz (count leading zeroes)-based
>> version to simplify the code and, well, eliminate the loop.
>> Note: There’s no check for val=0 case, since x86-bsr is undefined for
>> that case too, that should be okay.
>> ---
>>   src/radeon.h |    7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/radeon.h b/src/radeon.h
>> index cbc7866..b1a1ce0 100644
>> --- a/src/radeon.h
>> +++ b/src/radeon.h
>> @@ -933,17 +933,16 @@ enum {
>>   static __inline__ int
>>   RADEONLog2(int val)
>>   {
>> -    int bits;
>>   #if (defined __i386__ || defined __x86_64__) && (defined __GNUC__)
>> +    int bits;
>> +
>>       __asm volatile("bsrl    %1, %0"
>>           : "=r" (bits)
>>           : "c" (val)
>>       );
>>       return bits;
>>   #else
>> -    for (bits = 0; val != 0; val >>= 1, ++bits)
>> -        ;
>> -    return bits - 1;
>> +    return (31 - __builtin_clz(val));
>>   #endif
>>   }
> Any reason for not using __builtin_clz on x86 as well? AFAICT both gcc
> and clang seem to generate more or less the same code with that as with
> the inline assembly.
>
>
I guess not. According to 
http://stackoverflow.com/questions/9353973/implementation-of-builtin-clz 
"bsr and clz are related but different.

On x86 for clz gcc (-O2) generates:

|bsrl %edi, %eax xorl $31, %eax ret " |


--------------020706050908000601060600
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 29.11.2016 um 08:32 schrieb Michel
      Dänzer:<br>
    </div>
    <blockquote
      cite="mid:e3556fa8-39eb-6b1d-9d71-316c23bff9ea-otUistvHUpPR7s880joybQ@public.gmane.org"
      type="cite">
      <pre wrap="">On 29/11/16 03:18 AM, Jochen Rollwagen wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This commit replaces the loop for calculating log base 2 for
non-x86-platforms in radeon.h with a clz (count leading zeroes)-based
version to simplify the code and, well, eliminate the loop.
Note: There’s no check for val=0 case, since x86-bsr is undefined for
that case too, that should be okay.
---
 src/radeon.h |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/radeon.h b/src/radeon.h
index cbc7866..b1a1ce0 100644
--- a/src/radeon.h
+++ b/src/radeon.h
@@ -933,17 +933,16 @@ enum {
 static __inline__ int
 RADEONLog2(int val)
 {
-    int bits;
 #if (defined __i386__ || defined __x86_64__) &amp;&amp; (defined __GNUC__)
+    int bits;
+
     __asm volatile("bsrl    %1, %0"
         : "=r" (bits)
         : "c" (val)
     );
     return bits;
 #else
-    for (bits = 0; val != 0; val &gt;&gt;= 1, ++bits)
-        ;
-    return bits - 1;
+    return (31 - __builtin_clz(val));
 #endif
 }
</pre>
      </blockquote>
      <pre wrap="">
Any reason for not using __builtin_clz on x86 as well? AFAICT both gcc
and clang seem to generate more or less the same code with that as with
the inline assembly.


</pre>
    </blockquote>
    I guess not. According to <span><a class="moz-txt-link-freetext" href="http://stackoverflow.com/questions/9353973/implementation-of-builtin-clz">http://stackoverflow.com/questions/9353973/implementation-of-builtin-clz</a>
      "bsr and clz are related but different. </span><br>
    <p>On x86 for clz gcc (-O2) generates:</p>
    <pre><code>bsrl    %edi, %eax
xorl    $31, %eax
ret

" 


</code></pre>
  </body>
</html>

--------------020706050908000601060600--

--===============0461226669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0461226669==--
