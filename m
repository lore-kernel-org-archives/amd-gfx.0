Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA55FCCA464
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 18:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577A3112445;
	Thu, 15 Oct 2026 18:57:38 +0000 (UTC)
X-Greylist: delayed 443 seconds by postgrey-1.36 at gabe;
 Thu, 15 Oct 2026 18:57:31 UTC
Received: from mail.teamster.cloud (mail.teamster.cloud [213.136.73.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5234D112445
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 18:57:31 +0000 (UTC)
Content-Type: multipart/alternative;
 boundary="------------cjQjqO3TEIuqPTKbc1iem3vw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shift-computing.de;
 s=dkim; t=1792090204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D81R2Akm8ODFArY4k2feMHo09XnvL00+JdiHWEjTrn0=;
 b=HZ+mPF3uy+C067FJEns+LGhFhw5ym86BXEug35GLe0X8TOwmx4jx82mrBUybLniGJ+kjKg
 gUnjF5pf/So4HRWIS7N7VuXTvG6+CXXxL3B34tywmUYmwFZpRD+9sPXopxfHB29hz/HO+I
 M3wsawKhb6G6iA1w+GEflaGYeAdzgLtQIsoDiUPHdxR/6R2rSXSkQQmDchkvqhDjKU93Xu
 5/PQPnaqIiZy12ZC4gDE1IY/0yX7Cq/+uhglz4bXQYyhf1MBRd8RnLx3SQcR43QiYv+czc
 UHCw4IgYHZAFdwj9+BuHI85mZb/ROSzw2ZgS1g2u6s0UvHd4yAfaZc9ti/WARw==
Authentication-Results: mail.teamster.cloud;
 auth=pass smtp.mailfrom=oz@shift-computing.de
Message-ID: <cadf8cf5-633b-4df5-a458-b020fcaefe7c@shift-computing.de>
Date: Thu, 15 Oct 2026 20:50:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
 VBIOS image
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Min, Frank" <Frank.Min@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "Wang, YuBiao (Ethan)" <YuBiao.Wang@amd.com>
References: <20261014080523.186533-1-rezanikzadch@gmail.com>
 <BN9PR12MB51465FA6B74D63574BA3CCB6F79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <b6c30a27-4f8a-4c84-b227-0c54e5bf39b6@amd.com>
From: Oz Tiram <oz@shift-computing.de>
In-Reply-To: <b6c30a27-4f8a-4c84-b227-0c54e5bf39b6@amd.com>
X-Spamd-Bar: ---
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------cjQjqO3TEIuqPTKbc1iem3vw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mario,

pci=realloc,assign-busses was the fix for my problem.

Without it the dGPU is unusable.

Best regards (and a huge thanks)

Oz

On 10/15/26 04:52, Mario Limonciello wrote:
> + Oz Tiram
>
> On 10/14/26 17:19, Deucher, Alexander wrote:
>> Public
>>
>> + Mario
>>
>>> -----Original Message-----
>>> From: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
>>> Sent: Wednesday, October 14, 2026 4:05 AM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona
>>> Vetter <simona@ffwll.ch>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>>> Min, Frank <Frank.Min@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>;
>>> Wang, YuBiao (Ethan) <YuBiao.Wang@amd.com>
>>> Subject: [PATCH] drm/amdgpu: prefer exact bus match when selecting VFCT
>>> VBIOS image
>>>
>>> amdgpu_acpi_vfct_match() accepts an entry whose bus number differs from
>>> the runtime bus number as long as vendor, device, slot and function 
>>> match.
>>> The caller takes the first entry that matches and stops.
>>>
>>> On systems with several GPUs of the same model (e.g. mining boards) 
>>> every
>>> card matches every entry on vendor/device/function, so an earlier 
>>> entry is
>>> selected for a later card even when the table contains an entry with 
>>> the exact
>>> bus number. The later card then runs with another board's VBIOS 
>>> (different
>>> power/clock/memory tables) and can fail to initialize, for example 
>>> with "UVD
>>> not responding" and a fatal error during GPU init.
>>>
>>> Search the table first for an exact bus match, and only if none 
>>> exists fall back to
>>> matching by device identity.
>>>
>>> Reproduced with two RX 580 (Polaris10, 1002:67df) from different 
>>> vendors
>>> on an ASUS B250 mining board: VFCT holds entries for bus 1 and bus 
>>> 12, the
>>> card at bus 12 was given the bus 1 image.
>>>
>>> Signed-off-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
>>
>> I think I'd prefer to just revert the change the loosened the 
>> mapping.  The loosening was done to fix when someone sets pci=realloc 
>> on the kernel command line.  I'd consider that to be more of a corner 
>> case and presumably even that would potentially break on a system 
>> like yours anyway.
>>
>> Alex
>
> Oz,
>
> Just to double check, it was pci=realloc that caused the issue right?  
> I seem to think so.
>
> Another way we could do this is to only do the soft match when 
> pci=realloc was set on kernel command line.  I think that would help 
> both cases.
>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 71 +++++++++++++++-----
>>> ----
>>>   1 file changed, 46 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> index f9315e047..d42485e6b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>>> @@ -441,10 +441,15 @@ static bool amdgpu_read_disabled_bios(struct
>>> amdgpu_device *adev)
>>>    * the bus numbers disagree we accept the entry if the device 
>>> identity
>>>    * matches.
>>>    *
>>> + * @exact: if true, only an exact bus number match is accepted.  The
>>> + caller
>>> + * first searches the whole table with @exact set, and only retries
>>> + with it
>>> + * cleared when no entry matched exactly, so that an earlier entry for
>>> + an
>>> + * identical card on a different bus cannot shadow the correct one.
>>> + *
>>>    * Returns: 0 on match, -ENODEV on no match
>>>    */
>>>   static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>> -                               VFCT_IMAGE_HEADER *vhdr)
>>> +                               VFCT_IMAGE_HEADER *vhdr, bool exact)
>>>   {
>>>        /* Vendor and device IDs must always match */
>>>        if (vhdr->VendorID != adev->pdev->vendor || @@ -459,6 +464,9 @@
>>> static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>>        if (vhdr->PCIBus == adev->pdev->bus->number)
>>>                return 0;
>>>
>>> +     if (exact)
>>> +             return -ENODEV;
>>> +
>>>        /* Bus mismatch but device identity matches (PCI renumbering 
>>> case)
>>> */
>>>        dev_notice(adev->dev,
>>>                   "VFCT bus number mismatch: table %u != runtime %u,
>>> matching by device identity (vendor 0x%04x device 0x%04x)\n", @@ -474,6
>>> +482,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>>>        UEFI_ACPI_VFCT *vfct;
>>>        unsigned int offset;
>>>        bool r = false;
>>> +     bool exact;
>>>
>>>        if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>>>                return false;
>>> @@ -484,38 +493,50 @@ static bool amdgpu_acpi_vfct_bios(struct
>>> amdgpu_device *adev)
>>>        }
>>>
>>>        vfct = (UEFI_ACPI_VFCT *)hdr;
>>> -     offset = vfct->VBIOSImageOffset;
>>>
>>> -     while (offset < tbl_size) {
>>> -             GOP_VBIOS_CONTENT *vbios = (GOP_VBIOS_CONTENT
>>> *)((char *)hdr + offset);
>>> -             VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
>>> +     /*
>>> +      * Pass 1 looks for an entry whose bus number matches 
>>> exactly.  Only
>>> if
>>> +      * there is none does pass 2 accept an entry that matches by 
>>> device
>>> +      * identity alone.  Without this, on a system with several 
>>> identical
>>> +      * GPUs an earlier entry would be picked for a later card.
>>> +      */
>>> +     for (exact = true; ; exact = false) {
>>> +             offset = vfct->VBIOSImageOffset;
>>>
>>> -             offset += sizeof(VFCT_IMAGE_HEADER);
>>> -             if (offset > tbl_size) {
>>> -                     dev_info(adev->dev, "ACPI VFCT image header
>>> truncated,skipping\n");
>>> -                     goto out;
>>> -             }
>>> +             while (offset < tbl_size) {
>>> +                     GOP_VBIOS_CONTENT *vbios =
>>> (GOP_VBIOS_CONTENT *)((char *)hdr + offset);
>>> +                     VFCT_IMAGE_HEADER *vhdr = &vbios->VbiosHeader;
>>>
>>> -             offset += vhdr->ImageLength;
>>> -             if (offset > tbl_size) {
>>> -                     dev_info(adev->dev, "ACPI VFCT image
>>> truncated,skipping\n");
>>> -                     goto out;
>>> -             }
>>> +                     offset += sizeof(VFCT_IMAGE_HEADER);
>>> +                     if (offset > tbl_size) {
>>> +                             dev_info(adev->dev, "ACPI VFCT image
>>> header truncated,skipping\n");
>>> +                             goto out;
>>> +                     }
>>>
>>> -             if (vhdr->ImageLength &&
>>> -                 !amdgpu_acpi_vfct_match(adev, vhdr)) {
>>> -                     adev->bios = kmemdup(&vbios->VbiosContent,
>>> - vhdr->ImageLength,
>>> -                                          GFP_KERNEL);
>>> +                     offset += vhdr->ImageLength;
>>> +                     if (offset > tbl_size) {
>>> +                             dev_info(adev->dev, "ACPI VFCT image
>>> truncated,skipping\n");
>>> +                             goto out;
>>> +                     }
>>>
>>> -                     if (!check_atom_bios(adev, vhdr->ImageLength)) {
>>> -                             amdgpu_bios_release(adev);
>>> +                     if (vhdr->ImageLength &&
>>> +                         !amdgpu_acpi_vfct_match(adev, vhdr, exact)) {
>>> +                             adev->bios = kmemdup(&vbios-
>>>> VbiosContent,
>>> + vhdr->ImageLength,
>>> + GFP_KERNEL);
>>> +
>>> +                             if (!check_atom_bios(adev, vhdr-
>>>> ImageLength)) {
>>> + amdgpu_bios_release(adev);
>>> +                                     goto out;
>>> +                             }
>>> +                             adev->bios_size = vhdr->ImageLength;
>>> +                             r = true;
>>>                                goto out;
>>>                        }
>>> -                     adev->bios_size = vhdr->ImageLength;
>>> -                     r = true;
>>> -                     goto out;
>>>                }
>>> +
>>> +             if (!exact)
>>> +                     break;
>>>        }
>>>
>>>        dev_info(adev->dev, "ACPI VFCT table present but broken (too 
>>> short
>>> #2),skipping\n");
>>> -- 
>>> 2.53.0
>>
>
--------------cjQjqO3TEIuqPTKbc1iem3vw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p>Hi Mario,<br>
      <br>
      pci=realloc,assign-busses was the fix for my problem.<br>
      <br>
      Without it the dGPU is unusable.</p>
    <div class="moz-cite-prefix">Best regards (and a huge thanks)<br>
      <br>
      Oz<br>
      <br>
      On 10/15/26 04:52, Mario Limonciello wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b6c30a27-4f8a-4c84-b227-0c54e5bf39b6@amd.com">+ Oz Tiram
      <br>
      <br>
      On 10/14/26 17:19, Deucher, Alexander wrote:
      <br>
      <blockquote type="cite">Public
        <br>
        <br>
        + Mario
        <br>
        <br>
        <blockquote type="cite">-----Original Message-----
          <br>
          From: Reza Nikzad Chaleshori <a class="moz-txt-link-rfc2396E" href="mailto:rezanikzadch@gmail.com">&lt;rezanikzadch@gmail.com&gt;</a>
          <br>
          Sent: Wednesday, October 14, 2026 4:05 AM
          <br>
          To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <br>
          Cc: Reza Nikzad Chaleshori <a class="moz-txt-link-rfc2396E" href="mailto:rezanikzadch@gmail.com">&lt;rezanikzadch@gmail.com&gt;</a>;
          Deucher, Alexander
          <br>
          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
          <br>
          <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; David Airlie
          <a class="moz-txt-link-rfc2396E" href="mailto:airlied@gmail.com">&lt;airlied@gmail.com&gt;</a>; Simona
          <br>
          Vetter <a class="moz-txt-link-rfc2396E" href="mailto:simona@ffwll.ch">&lt;simona@ffwll.ch&gt;</a>; Zhang, Hawking
          <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>;
          <br>
          Min, Frank <a class="moz-txt-link-rfc2396E" href="mailto:Frank.Min@amd.com">&lt;Frank.Min@amd.com&gt;</a>; Luo, Zhigang
          <a class="moz-txt-link-rfc2396E" href="mailto:Zhigang.Luo@amd.com">&lt;Zhigang.Luo@amd.com&gt;</a>;
          <br>
          Wang, YuBiao (Ethan) <a class="moz-txt-link-rfc2396E" href="mailto:YuBiao.Wang@amd.com">&lt;YuBiao.Wang@amd.com&gt;</a>
          <br>
          Subject: [PATCH] drm/amdgpu: prefer exact bus match when
          selecting VFCT
          <br>
          VBIOS image
          <br>
          <br>
          amdgpu_acpi_vfct_match() accepts an entry whose bus number
          differs from
          <br>
          the runtime bus number as long as vendor, device, slot and
          function match.
          <br>
          The caller takes the first entry that matches and stops.
          <br>
          <br>
          On systems with several GPUs of the same model (e.g. mining
          boards) every
          <br>
          card matches every entry on vendor/device/function, so an
          earlier entry is
          <br>
          selected for a later card even when the table contains an
          entry with the exact
          <br>
          bus number. The later card then runs with another board's
          VBIOS (different
          <br>
          power/clock/memory tables) and can fail to initialize, for
          example with "UVD
          <br>
          not responding" and a fatal error during GPU init.
          <br>
          <br>
          Search the table first for an exact bus match, and only if
          none exists fall back to
          <br>
          matching by device identity.
          <br>
          <br>
          Reproduced with two RX 580 (Polaris10, 1002:67df) from
          different vendors
          <br>
          on an ASUS B250 mining board: VFCT holds entries for bus 1 and
          bus 12, the
          <br>
          card at bus 12 was given the bus 1 image.
          <br>
          <br>
          Signed-off-by: Reza Nikzad Chaleshori
          <a class="moz-txt-link-rfc2396E" href="mailto:rezanikzadch@gmail.com">&lt;rezanikzadch@gmail.com&gt;</a>
          <br>
        </blockquote>
        <br>
        I think I'd prefer to just revert the change the loosened the
        mapping.  The loosening was done to fix when someone sets
        pci=realloc on the kernel command line.  I'd consider that to be
        more of a corner case and presumably even that would potentially
        break on a system like yours anyway.
        <br>
        <br>
        Alex
        <br>
      </blockquote>
      <br>
      Oz,
      <br>
      <br>
      Just to double check, it was pci=realloc that caused the issue
      right?  I seem to think so.
      <br>
      <br>
      Another way we could do this is to only do the soft match when
      pci=realloc was set on kernel command line.  I think that would
      help both cases.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        <blockquote type="cite">---
          <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 71
          +++++++++++++++-----
          <br>
          ----
          <br>
            1 file changed, 46 insertions(+), 25 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
          <br>
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
          <br>
          index f9315e047..d42485e6b 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
          <br>
          @@ -441,10 +441,15 @@ static bool
          amdgpu_read_disabled_bios(struct
          <br>
          amdgpu_device *adev)
          <br>
             * the bus numbers disagree we accept the entry if the
          device identity
          <br>
             * matches.
          <br>
             *
          <br>
          + * @exact: if true, only an exact bus number match is
          accepted.  The
          <br>
          + caller
          <br>
          + * first searches the whole table with @exact set, and only
          retries
          <br>
          + with it
          <br>
          + * cleared when no entry matched exactly, so that an earlier
          entry for
          <br>
          + an
          <br>
          + * identical card on a different bus cannot shadow the
          correct one.
          <br>
          + *
          <br>
             * Returns: 0 on match, -ENODEV on no match
          <br>
             */
          <br>
            static int amdgpu_acpi_vfct_match(struct amdgpu_device
          *adev,
          <br>
          -                               VFCT_IMAGE_HEADER *vhdr)
          <br>
          +                               VFCT_IMAGE_HEADER *vhdr, bool
          exact)
          <br>
            {
          <br>
                 /* Vendor and device IDs must always match */
          <br>
                 if (vhdr-&gt;VendorID != adev-&gt;pdev-&gt;vendor || @@
          -459,6 +464,9 @@
          <br>
          static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
          <br>
                 if (vhdr-&gt;PCIBus ==
          adev-&gt;pdev-&gt;bus-&gt;number)
          <br>
                         return 0;
          <br>
          <br>
          +     if (exact)
          <br>
          +             return -ENODEV;
          <br>
          +
          <br>
                 /* Bus mismatch but device identity matches (PCI
          renumbering case)
          <br>
          */
          <br>
                 dev_notice(adev-&gt;dev,
          <br>
                            "VFCT bus number mismatch: table %u !=
          runtime %u,
          <br>
          matching by device identity (vendor 0x%04x device 0x%04x)\n",
          @@ -474,6
          <br>
          +482,7 @@ static bool amdgpu_acpi_vfct_bios(struct
          amdgpu_device *adev)
          <br>
                 UEFI_ACPI_VFCT *vfct;
          <br>
                 unsigned int offset;
          <br>
                 bool r = false;
          <br>
          +     bool exact;
          <br>
          <br>
                 if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &amp;hdr)))
          <br>
                         return false;
          <br>
          @@ -484,38 +493,50 @@ static bool amdgpu_acpi_vfct_bios(struct
          <br>
          amdgpu_device *adev)
          <br>
                 }
          <br>
          <br>
                 vfct = (UEFI_ACPI_VFCT *)hdr;
          <br>
          -     offset = vfct-&gt;VBIOSImageOffset;
          <br>
          <br>
          -     while (offset &lt; tbl_size) {
          <br>
          -             GOP_VBIOS_CONTENT *vbios = (GOP_VBIOS_CONTENT
          <br>
          *)((char *)hdr + offset);
          <br>
          -             VFCT_IMAGE_HEADER *vhdr =
          &amp;vbios-&gt;VbiosHeader;
          <br>
          +     /*
          <br>
          +      * Pass 1 looks for an entry whose bus number matches
          exactly.  Only
          <br>
          if
          <br>
          +      * there is none does pass 2 accept an entry that
          matches by device
          <br>
          +      * identity alone.  Without this, on a system with
          several identical
          <br>
          +      * GPUs an earlier entry would be picked for a later
          card.
          <br>
          +      */
          <br>
          +     for (exact = true; ; exact = false) {
          <br>
          +             offset = vfct-&gt;VBIOSImageOffset;
          <br>
          <br>
          -             offset += sizeof(VFCT_IMAGE_HEADER);
          <br>
          -             if (offset &gt; tbl_size) {
          <br>
          -                     dev_info(adev-&gt;dev, "ACPI VFCT image
          header
          <br>
          truncated,skipping\n");
          <br>
          -                     goto out;
          <br>
          -             }
          <br>
          +             while (offset &lt; tbl_size) {
          <br>
          +                     GOP_VBIOS_CONTENT *vbios =
          <br>
          (GOP_VBIOS_CONTENT *)((char *)hdr + offset);
          <br>
          +                     VFCT_IMAGE_HEADER *vhdr =
          &amp;vbios-&gt;VbiosHeader;
          <br>
          <br>
          -             offset += vhdr-&gt;ImageLength;
          <br>
          -             if (offset &gt; tbl_size) {
          <br>
          -                     dev_info(adev-&gt;dev, "ACPI VFCT image
          <br>
          truncated,skipping\n");
          <br>
          -                     goto out;
          <br>
          -             }
          <br>
          +                     offset += sizeof(VFCT_IMAGE_HEADER);
          <br>
          +                     if (offset &gt; tbl_size) {
          <br>
          +                             dev_info(adev-&gt;dev, "ACPI
          VFCT image
          <br>
          header truncated,skipping\n");
          <br>
          +                             goto out;
          <br>
          +                     }
          <br>
          <br>
          -             if (vhdr-&gt;ImageLength &amp;&amp;
          <br>
          -                 !amdgpu_acpi_vfct_match(adev, vhdr)) {
          <br>
          -                     adev-&gt;bios =
          kmemdup(&amp;vbios-&gt;VbiosContent,
          <br>
          -                                         
          vhdr-&gt;ImageLength,
          <br>
          -                                          GFP_KERNEL);
          <br>
          +                     offset += vhdr-&gt;ImageLength;
          <br>
          +                     if (offset &gt; tbl_size) {
          <br>
          +                             dev_info(adev-&gt;dev, "ACPI
          VFCT image
          <br>
          truncated,skipping\n");
          <br>
          +                             goto out;
          <br>
          +                     }
          <br>
          <br>
          -                     if (!check_atom_bios(adev,
          vhdr-&gt;ImageLength)) {
          <br>
          -                             amdgpu_bios_release(adev);
          <br>
          +                     if (vhdr-&gt;ImageLength &amp;&amp;
          <br>
          +                         !amdgpu_acpi_vfct_match(adev, vhdr,
          exact)) {
          <br>
          +                             adev-&gt;bios =
          kmemdup(&amp;vbios-
          <br>
          <blockquote type="cite">VbiosContent,
            <br>
          </blockquote>
          +                                                 
          vhdr-&gt;ImageLength,
          <br>
          +                                                 
          GFP_KERNEL);
          <br>
          +
          <br>
          +                             if (!check_atom_bios(adev, vhdr-
          <br>
          <blockquote type="cite">ImageLength)) {
            <br>
          </blockquote>
          +                                    
          amdgpu_bios_release(adev);
          <br>
          +                                     goto out;
          <br>
          +                             }
          <br>
          +                             adev-&gt;bios_size =
          vhdr-&gt;ImageLength;
          <br>
          +                             r = true;
          <br>
                                         goto out;
          <br>
                                 }
          <br>
          -                     adev-&gt;bios_size =
          vhdr-&gt;ImageLength;
          <br>
          -                     r = true;
          <br>
          -                     goto out;
          <br>
                         }
          <br>
          +
          <br>
          +             if (!exact)
          <br>
          +                     break;
          <br>
                 }
          <br>
          <br>
                 dev_info(adev-&gt;dev, "ACPI VFCT table present but
          broken (too short
          <br>
          #2),skipping\n");
          <br>
          --
          <br>
          2.53.0
          <br>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------cjQjqO3TEIuqPTKbc1iem3vw--
