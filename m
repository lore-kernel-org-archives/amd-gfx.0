Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB811C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 15:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6325610E4E8;
	Tue, 15 Feb 2022 15:11:28 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C79710E485
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 14:57:03 +0000 (UTC)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149]
 helo=[192.168.66.200]); authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1nJzGD-0005P7-Tf; Tue, 15 Feb 2022 15:56:57 +0100
Message-ID: <5a68afe4-1e9e-c683-e06d-30afc2156f14@leemhuis.info>
Date: Tue, 15 Feb 2022 15:56:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
Content-Language: en-BS
To: Jim Turner <linuxkernel.foss@dmarc-none.turner.link>,
 "Lazar, Lijo" <lijo.lazar@amd.com>
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87pmo8r6ob.fsf@turner.link>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1644937024;
 cf2b22bb; 
X-HE-SMSGID: 1nJzGD-0005P7-Tf
X-Mailman-Approved-At: Tue, 15 Feb 2022 15:11:26 +0000
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
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Top-posting for once, to make this easy accessible to everyone.

Nothing happened here for two weeks now afaics. Was the discussion moved
elsewhere or did it fall through the cracks?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

On 30.01.22 01:25, Jim Turner wrote:
> Hi Lijo,
> 
>> Specifically, I was looking for any events happening at these two
>> places because of the patch-
>>
>> https://elixir.bootlin.com/linux/v5.16/source/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c#L411
>>
>> https://elixir.bootlin.com/linux/v5.16/source/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c#L653
> 
> I searched the logs generated with all drm debug messages enabled
> (drm.debug=0x1ff) for "device_class", "ATCS", "atcs", "ATIF", and
> "atif", for both f1688bd69ec4 and f9b7f3703ff9. Other than the few lines
> mentioning ATIF from my previous email, there weren't any matches.
> 
> Since "device_class" didn't appear in the logs, we know that
> `amdgpu_atif_handler` was not called for either version.
> 
> I also patched f9b7f3703ff9 to add the line
> 
>   DRM_DEBUG_DRIVER("Entered amdgpu_acpi_pcie_performance_request");
> 
> at the top (below the variable declarations) of
> `amdgpu_acpi_pcie_performance_request`, and then tested again with all
> drm debug messages enabled (0x1ff). That debug message didn't show up.
> 
> So, `amdgpu_acpi_pcie_performance_request` was not called either, at
> least with f9b7f3703ff9. (I didn't try adding this patch to
> f1688bd69ec4.)
> 
> Would anything else be helpful?
