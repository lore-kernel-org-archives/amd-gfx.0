Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E45FC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5815910E8E8;
	Wed, 16 Feb 2022 08:25:15 +0000 (UTC)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6537610E610
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 02:35:37 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9F8F85807BE;
 Tue, 15 Feb 2022 21:35:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 15 Feb 2022 21:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=turner.link; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm2; bh=TpzoZfj+lZpZb5YGW+c6JSSTWLLq+cAVLwcjig
 xN9pY=; b=jiY6nB/NMb6omuUrZ2iOKgx4BbWJggRnkdloVQUzEadTZD6Y3BR7Jk
 EZTCBJ4BDhiLiWb18ZMU5KT9xwNe8xuCvZEKDxztTdd105SjxyPLXxiZc0SJBMuG
 c8iRyD9HeafaZyHvEmEpvh3gRBibrxf9++GUFfO6jzIvSNhZQqVNk7FakBL0/nWv
 ANql/suOXiiUpqutrz1iLxyICCGG91Itt4Z4g1TBAzrim1exHR8N8e/sgMhzx8Zl
 eYd09z3r0CjAJhsVc7k6gbnARAB3VXOBb6KQnarMlwKmXc4crpvCjsI7v+09LWOu
 zxoykbDKpDLzcxAEg5g2uye4uSMAop4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TpzoZfj+lZpZb5YGW
 +c6JSSTWLLq+cAVLwcjigxN9pY=; b=h0KErPn8bm9yjFrMk5wE+nKKL/iyvwXec
 tymAVZw6TaLuzEl7K7QASX8htJQl9wZYj+T7CK1MLW9cHAGfwetvWJ9YcHPdGFiT
 +eMKUPMX+VVOwjA6t3fvaj6UKa7bbohA7KYJYsQnnXNA8lPpZr9dSs7UAPqb7UYM
 k7x9FxLj4NUB8P0zw63F6mDvvqUYSmGNUeWT4LElt/7ok6if8OJFIIGO/ucud868
 q9MGxnNxnIGGk2zWk7/WLmkfd25vdBRpEfzRGoiU0ukiIUUJ71aKHkaBWLJNB+RB
 VREzWzdcCwCn9Th5o8CZwQ4VGRIhL1jTiQA4glsTiFaXnENq54Opw==
X-ME-Sender: <xms:-GIMYofFCTNIFq1AeLdSRz6qqWwjIOA1HWmQ0CB5iHvdTE1eAMDrwQ>
 <xme:-GIMYqOACvUOsMDdVAoKAcyo3sQSQXBQq8zVXPQAXp_7qeOkHMo4-pbrBdsqO01Em
 7_HDZryHMCR3Z2KdQ>
X-ME-Received: <xmr:-GIMYpiPr6y8rkkCkM5IKlHorXFG1D_RG5eYtMp9_GM9F55NGBCXd-snTl3V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeehgdegjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpehfhffvufffjgfkgggtsehttdertddttddtnecuhfhrohhmpeflrghmvghsucff
 rdcuvfhurhhnvghruceolhhinhhugihkvghrnhgvlhdrfhhoshhssegumhgrrhgtqdhnoh
 hnvgdrthhurhhnvghrrdhlihhnkheqnecuggftrfgrthhtvghrnhepudfhgedvtdduieek
 tdegieetfefhteeukedvieefteelheevveffgeeutddvkeegnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugihkvghrnhgvlhdrfhho
 shhssegumhgrrhgtqdhnohhnvgdrthhurhhnvghrrdhlihhnkh
X-ME-Proxy: <xmx:-GIMYt8fxrYSfpsig9tl3ceOYL_nX_EwxiEMadaX5Wj3xVE4PNpatQ>
 <xmx:-GIMYkuw1dIcVVUcyvoloB0hbDK4Fuz78dNlZ-BUxFw4N-KulLiIiw>
 <xmx:-GIMYkEOatGXYXzOwmzkLXts25_mEsiRyt4H6QfyxZaH7P4rMyoMNg>
 <xmx:-GIMYhNwugAdty2yJUPqUEt1xabyBMcWe0cMxwrZ66jWILoRePewcw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Feb 2022 21:35:36 -0500 (EST)
References: <87ee57c8fu.fsf@turner.link>
 <acd2fd5e-d622-948c-82ef-629a8030c9d8@leemhuis.info>
 <87a6ftk9qy.fsf@dmarc-none.turner.link> <87zgnp96a4.fsf@turner.link>
 <fc2b7593-db8f-091c-67a0-ae5ffce71700@leemhuis.info>
 <CADnq5_Nr5-FR2zP1ViVsD_ZMiW=UHC1wO8_HEGm26K_EG2KDoA@mail.gmail.com>
 <87czkk1pmt.fsf@dmarc-none.turner.link>
 <BYAPR12MB46140BE09E37244AE129C01A975C9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87sftfqwlx.fsf@dmarc-none.turner.link>
 <BYAPR12MB4614E2CFEDDDEAABBAB986A0975E9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87ee4wprsx.fsf@turner.link>
 <4b3ed7f6-d2b6-443c-970e-d963066ebfe3@amd.com>
 <87pmo8r6ob.fsf@turner.link>
 <5a68afe4-1e9e-c683-e06d-30afc2156f14@leemhuis.info>
 <CADnq5_MCKTLOfWKWvi94Q9-d5CGdWBoWVxEYL3YXOpMiPnLOyg@mail.gmail.com>
From: James D. Turner <linuxkernel.foss@dmarc-none.turner.link>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
Date: Tue, 15 Feb 2022 19:25:31 -0500
In-reply-to: <CADnq5_MCKTLOfWKWvi94Q9-d5CGdWBoWVxEYL3YXOpMiPnLOyg@mail.gmail.com>
Message-ID: <87pmnnpmh5.fsf@dmarc-none.turner.link>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 16 Feb 2022 08:25:14 +0000
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
 Alex Williamson <alex.williamson@redhat.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

> I guess just querying the ATIF method does something that negatively
> influences the windows driver in the guest. Perhaps the platform
> thinks the driver has been loaded since the method has been called so
> it enables certain behaviors that require ATIF interaction that never
> happen because the ACPI methods are not available in the guest.

Do you mean the `amdgpu_atif_pci_probe_handle` function? If it would be
helpful, I could try disabling that function and testing again.

> I don't really have a good workaround other than blacklisting the
> driver since on bare metal the driver needs to use this interface for
> platform interactions.

I'm not familiar with ATIF, but should `amdgpu_atif_pci_probe_handle`
really be called for PCI devices which are bound to vfio-pci? I'd expect
amdgpu to ignore such devices.

As I understand it, starting with
f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)"),
the `amdgpu_acpi_detect` function loops over all PCI devices in the
`PCI_CLASS_DISPLAY_VGA` and `PCI_CLASS_DISPLAY_OTHER` classes to find
the ATIF and ATCS handles. Maybe skipping over any PCI devices bound to
vfio-pci would fix the issue? On a related note, shouldn't it also skip
over any PCI devices with non-AMD vendor IDs?

Regards,
James
