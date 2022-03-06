Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D88C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 08:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C98BB10E1C1;
	Mon,  7 Mar 2022 08:26:54 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C79A10E471
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Mar 2022 15:48:19 +0000 (UTC)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149]
 helo=[192.168.66.200]); authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1nQt7F-0006pL-Di; Sun, 06 Mar 2022 16:48:13 +0100
Message-ID: <092b825a-10ff-e197-18a1-d3e3a097b0e3@leemhuis.info>
Date: Sun, 6 Mar 2022 16:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 "James D. Turner" <linuxkernel.foss@dmarc-none.turner.link>
References: <87ee57c8fu.fsf@turner.link>
 <acd2fd5e-d622-948c-82ef-629a8030c9d8@leemhuis.info>
 <87a6ftk9qy.fsf@dmarc-none.turner.link> <87zgnp96a4.fsf@turner.link>
 <fc2b7593-db8f-091c-67a0-ae5ffce71700@leemhuis.info>
 <CADnq5_Nr5-FR2zP1ViVsD_ZMiW=UHC1wO8_HEGm26K_EG2KDoA@mail.gmail.com>
 <87czkk1pmt.fsf@dmarc-none.turner.link>
 <BYAPR12MB46140BE09E37244AE129C01A975C9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87sftfqwlx.fsf@dmarc-none.turner.link>
 <BYAPR12MB4614E2CFEDDDEAABBAB986A0975E9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87ee4wprsx.fsf@turner.link> <4b3ed7f6-d2b6-443c-970e-d963066ebfe3@amd.com>
 <87pmo8r6ob.fsf@turner.link>
 <5a68afe4-1e9e-c683-e06d-30afc2156f14@leemhuis.info>
 <CADnq5_MCKTLOfWKWvi94Q9-d5CGdWBoWVxEYL3YXOpMiPnLOyg@mail.gmail.com>
 <87pmnnpmh5.fsf@dmarc-none.turner.link>
 <CADnq5_NG_dQCYwqHM0umjTMg5Uud6zC4=MiscH91Y9v7mW9bJA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CADnq5_NG_dQCYwqHM0umjTMg5Uud6zC4=MiscH91Y9v7mW9bJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1646581699;
 b1c67397; 
X-HE-SMSGID: 1nQt7F-0006pL-Di
X-Mailman-Approved-At: Mon, 07 Mar 2022 08:26:53 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, "Lazar, Lijo" <lijo.lazar@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, this is your Linux kernel regression tracker again. Top-posting once
more, to make this easily accessible to everyone.

What's the status of this? It looks stuck, or did the discussion
continue somewhere else? James, it sounded like you wanted to test
something, did you give it a try? Or is there some reason why I should
stop tracking this regression?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot poke

On 16.02.22 17:37, Alex Deucher wrote:
> On Tue, Feb 15, 2022 at 9:35 PM James D. Turner
> <linuxkernel.foss@dmarc-none.turner.link> wrote:
>>
>> Hi Alex,
>>
>>> I guess just querying the ATIF method does something that negatively
>>> influences the windows driver in the guest. Perhaps the platform
>>> thinks the driver has been loaded since the method has been called so
>>> it enables certain behaviors that require ATIF interaction that never
>>> happen because the ACPI methods are not available in the guest.
>>
>> Do you mean the `amdgpu_atif_pci_probe_handle` function? If it would be
>> helpful, I could try disabling that function and testing again.
> 
> Correct.
> 
>>
>>> I don't really have a good workaround other than blacklisting the
>>> driver since on bare metal the driver needs to use this interface for
>>> platform interactions.
>>
>> I'm not familiar with ATIF, but should `amdgpu_atif_pci_probe_handle`
>> really be called for PCI devices which are bound to vfio-pci? I'd expect
>> amdgpu to ignore such devices.
>>
>> As I understand it, starting with
>> f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)"),
>> the `amdgpu_acpi_detect` function loops over all PCI devices in the
>> `PCI_CLASS_DISPLAY_VGA` and `PCI_CLASS_DISPLAY_OTHER` classes to find
>> the ATIF and ATCS handles. Maybe skipping over any PCI devices bound to
>> vfio-pci would fix the issue? On a related note, shouldn't it also skip
>> over any PCI devices with non-AMD vendor IDs?
> 
> The ACPI methods are global.  There's only one instance of each per
> system and they are relevant to add GPUs on the platform.  That's why
> they are a global resource in the driver.  They can be hung off of the
> dGPU or APU ACPI namespace, depending on the platform which is why we
> check all of the display devices.  Skipping them would prevent them
> from being available if you later bound the amdgpu driver to the GPU
> device(s) I think.
> 
> Alex
> 
>>
>> Regards,
>> James
> 
> 
