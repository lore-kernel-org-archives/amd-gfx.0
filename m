From: arvind <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH 1/5] drm: radeon: constify pci_device_id.
Date: Sun, 16 Jul 2017 11:40:28 +0530
Message-ID: <596B0354.6030703@gmail.com>
References: <1500102738-23274-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1500102738-23274-2-git-send-email-arvind.yadav.cs@gmail.com>
 <94559aac-60b7-d2f9-7594-89e939980dd5@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0995739061=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <94559aac-60b7-d2f9-7594-89e939980dd5@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>, airlied@linux.ie, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0995739061==
Content-Type: multipart/alternative;
 boundary="------------070502030605040800010507"

This is a multi-part message in MIME format.
--------------070502030605040800010507
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

On Saturday 15 July 2017 07:17 PM, Christian König wrote:
> Am 15.07.2017 um 09:12 schrieb Arvind Yadav:
>> pci_device_id are not supposed to change at runtime. All functions
>> working with pci_device_id provided by <linux/pci.h> work with
>> const pci_device_id. So mark the non-const structs as const.
>>
>> File size before:
>>     text       data        bss        dec        hex    filename
>>     6560      23212         72      29844       7494 
>> gpu/drm/radeon/radeon_drv.o
>>
>> File size After adding 'const':
>>     text       data        bss        dec        hex    filename
>>    28960        812         72      29844       7494 
>> gpu/drm/radeon/radeon_drv.o
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>
> Impressive result for such a simple change.
>
> Patch is Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Are the PCI IDs already const in amdgpu or do we need a similar patch 
> there as well? I only see patch 1 of 5 in my inbox.
I have send all gpu patch to David Airlie. Please check with him.
>
> Christian.
>
>> ---
>>   drivers/gpu/drm/radeon/radeon_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c 
>> b/drivers/gpu/drm/radeon/radeon_drv.c
>> index e25cb51..b079937 100644
>> --- a/drivers/gpu/drm/radeon/radeon_drv.c
>> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
>> @@ -298,7 +298,7 @@ module_param_named(uvd, radeon_uvd, int, 0444);
>>   MODULE_PARM_DESC(vce, "vce enable/disable vce support (1 = enable, 
>> 0 = disable)");
>>   module_param_named(vce, radeon_vce, int, 0444);
>>   -static struct pci_device_id pciidlist[] = {
>> +static const struct pci_device_id pciidlist[] = {
>>       radeon_PCI_IDS
>>   };
>
>
>
Regards,
~arvind

--------------070502030605040800010507
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Christian,<br>
    <br>
    <div class="moz-cite-prefix">On Saturday 15 July 2017 07:17 PM,
      Christian König wrote:<br>
    </div>
    <blockquote
      cite="mid:94559aac-60b7-d2f9-7594-89e939980dd5@vodafone.de"
      type="cite">Am 15.07.2017 um 09:12 schrieb Arvind Yadav:
      <br>
      <blockquote type="cite">pci_device_id are not supposed to change
        at runtime. All functions
        <br>
        working with pci_device_id provided by &lt;linux/pci.h&gt; work
        with
        <br>
        const pci_device_id. So mark the non-const structs as const.
        <br>
        <br>
        File size before:
        <br>
            text       data        bss        dec        hex    filename
        <br>
            6560      23212         72      29844       7494   
        gpu/drm/radeon/radeon_drv.o
        <br>
        <br>
        File size After adding 'const':
        <br>
            text       data        bss        dec        hex    filename
        <br>
           28960        812         72      29844       7494   
        gpu/drm/radeon/radeon_drv.o
        <br>
        <br>
        Signed-off-by: Arvind Yadav <a class="moz-txt-link-rfc2396E" href="mailto:arvind.yadav.cs@gmail.com">&lt;arvind.yadav.cs@gmail.com&gt;</a>
        <br>
      </blockquote>
      <br>
      Impressive result for such a simple change.
      <br>
      <br>
      Patch is Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
      <br>
      <br>
      Are the PCI IDs already const in amdgpu or do we need a similar
      patch there as well? I only see patch 1 of 5 in my inbox.
      <br>
    </blockquote>
    I have send all gpu patch to
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <span style="color: rgb(51, 51, 51); font-family: &quot;normal
      arial&quot;, sans-serif; font-size: 16px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255); text-decoration-style: initial; text-decoration-color:
      initial; display: inline !important; float: none;">David Airlie</span>.
    Please check with him.<span style="color: rgb(51, 51, 51);
      font-family: &quot;normal arial&quot;, sans-serif; font-size:
      16px; font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: normal; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"><br>
    </span>
    <blockquote
      cite="mid:94559aac-60b7-d2f9-7594-89e939980dd5@vodafone.de"
      type="cite">
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">---
        <br>
          drivers/gpu/drm/radeon/radeon_drv.c | 2 +-
        <br>
          1 file changed, 1 insertion(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/radeon/radeon_drv.c
        b/drivers/gpu/drm/radeon/radeon_drv.c
        <br>
        index e25cb51..b079937 100644
        <br>
        --- a/drivers/gpu/drm/radeon/radeon_drv.c
        <br>
        +++ b/drivers/gpu/drm/radeon/radeon_drv.c
        <br>
        @@ -298,7 +298,7 @@ module_param_named(uvd, radeon_uvd, int,
        0444);
        <br>
          MODULE_PARM_DESC(vce, "vce enable/disable vce support (1 =
        enable, 0 = disable)");
        <br>
          module_param_named(vce, radeon_vce, int, 0444);
        <br>
          -static struct pci_device_id pciidlist[] = {
        <br>
        +static const struct pci_device_id pciidlist[] = {
        <br>
              radeon_PCI_IDS
        <br>
          };
        <br>
          </blockquote>
      <br>
      <br>
      <br>
    </blockquote>
    Regards,<br>
    ~arvind<br>
  </body>
</html>

--------------070502030605040800010507--

--===============0995739061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0995739061==--
