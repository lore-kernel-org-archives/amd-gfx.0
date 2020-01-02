Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF22AC2D0DD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 08:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8493920866
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 08:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5CGkqno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8493920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E00389803;
	Thu,  2 Jan 2020 08:41:28 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894F689803
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 08:41:26 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id c14so38474400wrn.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jan 2020 00:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UYncsbIDBtajYSthICMPweYs8Y1j/z5wwz2Bk4D4ZNM=;
 b=h5CGkqnovY2qFizhf9smexrmRfCsgc60RLJaacxKtNEVSrPIgxF/vJ1OvamPV2hx8i
 Ap0la/xdunHyfwufw6Yfgs/036rWrebHm1h2mgi59sC2yCd58m2+WKxs2yXKWAoyzi+V
 HE/Nn/kSt86c8WtqP2fXI94kg+Ipb+4hB4OwDvEgsjr+8TK/y8e7HTkjlJiscgUTEDHX
 awVhDWApKaj61Do/D1Qbm93l3kteCtgRiVJ3g1zhMFh7TMoPwI0n4GE2Dt8JsyySqzLN
 9kTS0+lVaBh5yvcqIoi3zch4AbeuT+sfgspQYJ55iW9vEA9YRDDLdAD4TaD9paymZYU2
 TPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UYncsbIDBtajYSthICMPweYs8Y1j/z5wwz2Bk4D4ZNM=;
 b=g3RS7/Ej6FwX82Anu3EIHcmebFhRQ5c+jUb2z8+UMJPknEWVi9AWhmkzd/TdPfjBiJ
 Mwckdla1Y79k/WuTLY7WXKJVe6wYmMYkbeBG6gxr7AYy7rRRGHGrkHa8NcfKWFkj443v
 oYUz+Iw4TMrlzWcINpPS9K/M/pgwjyZG1zOY6haNREFPax+OFcFkaPru0glJhIlG1sbE
 yBqeIWj+5LPaAEocR5NaE76/91dNnJANg26fQ044aWzMFyaiEgxvrg9EwB7HbD7nbT+w
 8n71c7gIX4xxes5DUpzYol2FlP1cG1cqdx4Ce85N0mZJy6FEIlWJ7xmv+9qYt82lrmch
 X1hg==
X-Gm-Message-State: APjAAAWznXH7OfLQAwg7udZJ7QbIl3GrMZ3+uclS/gLdxwmpTlllys0q
 2+nGLnUIm+qA/EattJSbQFJyZosjjjFMI5bp0xDvaT6M
X-Google-Smtp-Source: APXvYqwb0donDMFaeGilHd6pAJGNIO2ou/RaWcwlLKsoIVBqv9ssjiE49Jzn511Vyr7vWhOc3q/N3NM/f3ZrgJ0jq30=
X-Received: by 2002:adf:fe90:: with SMTP id l16mr85863445wrr.265.1577954484724; 
 Thu, 02 Jan 2020 00:41:24 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjxGE5p3AVQf=dm4ubBrKgbTagr4QrUJo=bPmueNSyjecw@mail.gmail.com>
 <1b8f92ae-6faa-49a4-8b38-6bccec006b68@gmail.com>
 <CAGzVRjyz7P3uiCgyFX=zZ4xzKwN+X2i8y7oabNkLBU4CnRpBmw@mail.gmail.com>
 <ec0b6313-1a5a-8195-84da-ee549f82f142@amd.com>
 <CAGzVRjzELaG_CToBxUWzh+kadp3qUQY6RQSGHMO1W1eSs+d-_w@mail.gmail.com>
 <ee330d5d-047e-8342-9c40-c547dcc7a17c@gmail.com>
 <CAGzVRjxFx-+Rduwm2ejxzkNnCQq_pyT9k0LO1z5_MSq95EmOxQ@mail.gmail.com>
 <CAGzVRjzDKaA96VqXq=W3jUDJga3Fc=vWOm_XQE9e6WTTNujXaA@mail.gmail.com>
 <e295f685-a46b-dcea-ad65-627f8839da2b@amd.com>
 <CAGzVRjz-EEZDamT3OvJ8r9ERd7gNLdjBwaOisnQ9pY_MPKAKyg@mail.gmail.com>
 <80c63f19-d1a2-1310-c93f-9f4e292cffef@amd.com>
 <CAGzVRjwVdgojwsM1pOYftcXf6WeQN_46QwfQ1gvVUd6duyXiEQ@mail.gmail.com>
In-Reply-To: <CAGzVRjwVdgojwsM1pOYftcXf6WeQN_46QwfQ1gvVUd6duyXiEQ@mail.gmail.com>
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Thu, 2 Jan 2020 11:41:13 +0300
Message-ID: <CAGzVRjxCCUUtMpRxEJCVZgku1bB5jSsCdV9s-XO=6WMLnwWqmw@mail.gmail.com>
Subject: Re: [error] Drm -> amdgpu Unrecoverable Machine Check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1660137890=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1660137890==
Content-Type: multipart/alternative; boundary="00000000000088ab02059b242897"

--00000000000088ab02059b242897
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christian,

I solved this problem weeks ago. The problem was, the system I use could
only give 256 MB address range but GPU was demanding more. Even if I give 4
GB, PCIe slot is only having 256 MB, nothing more.  I put a empty area that
is between PCIe2 ( GPU was connected to this) and PCIe3 and everything
worked fine ( I moved forward the start adress of next PCIe device) . If
anyone encounters same problem, here is a sample Device Tree Source for
linux;

pci0: pcie@ffe240000 {
reg =3D <0xf 0xfe240000 0 0x10000>;
ranges =3D <0x02000000 0 0xe0000000 0x2 0x0 0x0 0x10000000
 0x01000000 0 0x0 0xf 0xf8000000 0x0 0x00010000>;
pcie@0 {
ranges =3D <0x02000000 0 0xe0000000
 0x02000000 0 0xe0000000
 0 0x10000000

 0x01000000 0 0x00000000
 0x01000000 0 0x00000000
 0 0x00010000>;
};
};

pci1: pcie@ffe250000 { // GPU CONNECTED TO THIS ONE
reg =3D <0xf 0xfe250000 0 0x10000>;
ranges =3D <0x02000000 0 0xe0000000 0x2 0x10000000 0x1 0x00000000
 0x01000000 0 0 0xf 0xf8010000 0 0x00010000>;
pcie@0 {
ranges =3D <0x02000000 0 0xe0000000
 0x02000000 0 0xe0000000
 0x1 0x00000000

 0x01000000 0 0x00000000
 0x01000000 0 0x00000000
 0 0x00010000>;
};
};

pci2: pcie@ffe260000 {
reg =3D <0xf 0xfe260000 0 0x10000>;
ranges =3D <0x02000000 0 0xe0000000 0x3 0x20000000 0 0x10000000 // 0x3
0x20000000 actually it must be 0x3 0x10000000 because I gave 4 GB to pci1
but I also added 256 MB empty area between them. So it started from 0x3
0x20000000
 0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
pcie@0 {
ranges =3D <0x02000000 0 0xe0000000
 0x02000000 0 0xe0000000
 0 0x10000000

 0x01000000 0 0x00000000
 0x01000000 0 0x00000000
 0 0x00010000>;
};
};

pci3: pcie@ffe270000 {
reg =3D <0xf 0xfe270000 0 0x10000>;
ranges =3D <0x02000000 0 0xe0000000 0x3 0x30000000 0 0x10000000
 0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
pcie@0 {
ranges =3D <0x02000000 0 0xe0000000
 0x02000000 0 0xe0000000
 0 0x10000000

 0x01000000 0 0x00000000
 0x01000000 0 0x00000000
 0 0x00010000>;
};
};



Yusuf Alt=C4=B1parmak <yusufalti1997@gmail.com>, 3 Ara 2019 Sal, 22:20 tari=
hinde
=C5=9Funu yazd=C4=B1:

>
> What you could try as well is to use the size 320MB for the MMIO. Those
>> ranges usually don't need to be a power of two (only the BARs itself are=
 a
>> power of two) and this way it might even be easier to fit everything
>> together.
>>
>
> Hmm this makes my job easier it seems.
>
>
>> By the way I wonder how can I get at least VGA output from GPU. Maybe I
>> can get a text console on screen or something like X server? Do you have
>> any recommendations?
>>
>> What could maybe work is VGA emulation, which essentially means text
>> only. But no guarantee for that this really works as expected.
>>
>> It's a well known board and U-boot is the most popular bootloader in
> embedded world it seems. I think I am not the only one who tries to conne=
ct
> a GPU from PCIe so I think there must be some config variables that enabl=
es
> VGA emulation, or some kind of packages.
>
>
>
>> I am just wondering, does modern gaming motherboards have more than 4GB
>> PCIe buffer for this job ?
>>
>> They don't, resources are dynamically assigned instead.
>>
>> See on x86 you usually have 1GB 32-bit address space where the BIOS
>> shuffles all the mandatory devices it sees at boot time into.
>>
>> Then when the motherboard has multiple PEG slots the BIOS also configure=
s
>> a 64-bit address space which is usually rather huge (256GB-1TB). Since t=
he
>> the VRAM and the doorbell BAR are 64bit BARs on the GPU they can be mapp=
ed
>> into that as well.
>>
>> This way you can easily have 10 GPUs connected to your CPU.
>>
>> Ah that was a clear answer. So the adress that CPU uses after mapping is
> actully an imaginary/virtual adress. It depends on the operating systems
> bit configuration. If I am not wrong, those addresses are adding on
> previous one meanwhile PCIe is mapping with endpoint device.
>
>
>
>> The problem you have here is that U-config doesn't do this resource
>> assignment automatically and you need to configure it manually.
>>
>
> Yes. By the way, thanks for your answers Christian. I am a newbie to
> embedded world. I have been dealing with these stuffs for 3 months. I
> couldn't get the answers I seek from google. Your answers were more clear
> and understandable.
>
> Best Regards.
>
>
>
>> Am 03.12.19 um 13:50 schrieb Yusuf Alt=C4=B1parmak:
>>
>>
>> Hi Christian,
>>
>>> 0001f000
>>>
>>> Exactly as I thought. The hardware does support BAR resize, but
>>> unfortunately 256MB is already the minimum.
>>>
>>> Sorry, but there isn't anything I could do from the GPU drivers point o=
f
>>> view.
>>>
>>
>> Yes unfortunately there is nothing remained to about GPU side.
>>
>> The only good news I have is that 256M+2M+512K+128K=3D260M address space
>>> should be enough for the GPU to work, maybe that makes things a bit sim=
pler.
>>>
>>>
>> Right now I am trying to increase MMIO size config to 512 MB, I hope tha=
t
>> should help me. By the way I wonder how can I get at least VGA output fr=
om
>> GPU. Maybe I can get a text console on screen or something like X server=
?
>> Do you have any recommendations? I tried this GPU with my own Ubuntu 18.=
04
>> and its special driver. Everything worked fine.
>>
>>
>>
>>> But you definitely got an interesting use case here :)
>>>
>>
>> This is the worlds the most interesting use case I think. I can't
>> increase MMIO size because U-boot freezes. I can't decrease it to 256 MB
>> again because driver does not accept :D. I am just wondering, does moder=
n
>> gaming motherboards have more than 4GB PCIe buffer for this job ? :D
>>
>>
>> Am 03.12.19 um 11:31 schrieb Yusuf Alt=C4=B1parmak:
>>>
>>> Hello Christian,
>>> My "setpci -s 0001:01:00.0 ECAP15+4.l ECAP15+8.l" output is;
>>>
>>> 0001f000
>>>
>>> 00000820
>>>
>>> Regards.
>>>
>>>
>>>
>>> Yusuf Alt=C4=B1parmak <yusufalti1997@gmail.com>, 2 Ara 2019 Pzt, 19:31
>>> tarihinde =C5=9Funu yazd=C4=B1:
>>>
>>>> Most likely not. There is support for resizing the VRAM BAR, but
>>>>> usually you can only make it larger and not smaller.
>>>>> Please give me the output of "sudo setpci -s 0001:01:00.0 ECAP15+4.l
>>>>> ECAP15+8.l" if you want to double check that.
>>>>>
>>>>
>>>> Okay I'll try it tomorrow. What does the " sudo setpci -s 0001:01:00.0
>>>> ECAP15+4.l ECAP15+8.l" command exactly do ?
>>>>
>>>>
>>>>
>>>>> Well you rather need to ask if anybody has sample PCIe configuration
>>>>> for GPUs in general. That problem is not really E9171 related. You mi=
ght
>>>>> want to ask NXP for that maybe.
>>>>> Sorry, no idea if that is correct or not. You need to ask NXP for hel=
p
>>>>> with that.
>>>>>
>>>>>
>>>> Okay no problem. At least I know what is the missing point now. The
>>>> problem is probably because of the .dtsi and u-boot config files. Memo=
ry
>>>> ranges are overwriting like you said. I'll ask nxp to take some sample=
 PCIe
>>>> configuration for GPUs.
>>>>
>>>> Thank you for your interest Christian.
>>>> Regards .
>>>>
>>>>
>>>>>
>>>>> Am 02.12.19 um 14:32 schrieb Yusuf Alt=C4=B1parmak:
>>>>>>
>>>>>>
>>>>>>> I attached my dts file.
>>>>>>>
>>>>>>> System is working fine when GPU is not plugged in.
>>>>>>>
>>>>>>> *This is the last console log before freeze:*
>>>>>>> [drm] amdgpu kernel modesetting enabled.
>>>>>>>
>>>>>>> [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987
>>>>>>> 0x1787:0x2389 0x80).
>>>>>>> [drm] register mmio base: 0x20200000
>>>>>>>
>>>>>>> fsl-fman-port ffe488000.port fm1-gb0: renamed from eth0
>>>>>>>
>>>>>>> [drm] register mmio size: 262144
>>>>>>>
>>>>>>> [drm] add ip block number 0 <vi_common>
>>>>>>>
>>>>>>> [drm] add ip block number 1 <gmc_v8_0>
>>>>>>>
>>>>>>> [drm] add ip block number 2 <tonga_ih>
>>>>>>>
>>>>>>> [drm] add ip block number 3 <powerplay>
>>>>>>>
>>>>>>> [drm] add ip block number 4 <dm>
>>>>>>>
>>>>>>> [drm] add ip block number 5 <gfx_v8_0>
>>>>>>>
>>>>>>> [drm] add ip block number 6 <sdma_v3_0>
>>>>>>>
>>>>>>> [drm] add ip block number 7 <uvd_v6_0>
>>>>>>>
>>>>>>> [drm] add ip block number 8 <vce_v3_0>
>>>>>>>
>>>>>>> [drm] UVD is enabled in VM mode
>>>>>>>
>>>>>>> [drm] UVD ENC is enabled in VM mode
>>>>>>>
>>>>>>> [drm] VCE enabled in VM mode
>>>>>>>
>>>>>>> ATOM BIOS: 113-ER16BFC-001
>>>>>>>
>>>>>>> [drm] GPU posting now...
>>>>>>>
>>>>>>> Disabling lock debugging due to kernel taint
>>>>>>>
>>>>>>> Machine check in kernel mode.
>>>>>>>
>>>>>>> Caused by (from MCSR=3Da000): Load Error Report
>>>>>>>
>>>>>>> Guarded Load Error Report
>>>>>>>
>>>>>>> Kernel panic - not syncing: Unrecoverable Machine check
>>>>>>>
>>>>>>> CPU: 1 PID: 2023 Comm: udevd Tainted: G   M
>>>>>>>  4.19.26+gc0c2141 #1
>>>>>>> Call Trace:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.free=
desktop.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.ou=
tlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2=
Famd-gfx&data=3D02%7C01%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad=
08d777ef717c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63710974260333542=
7&sdata=3DDstGsDW0X7ennQoF1vg%2FYLGAStF4p1dAeMFhzsAFc1I%3D&reserved=3D0>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>, 2 Ara 2019 =
Pzt,
>>>>>> 15:28 tarihinde =C5=9Funu yazd=C4=B1:
>>>>>>
>>>>>>> Hi Yusuf,
>>>>>>>
>>>>>>> Am 02.12.19 um 12:41 schrieb Yusuf Alt=C4=B1parmak:
>>>>>>>
>>>>>>> My embedded board is freezing when I put E9171 on PCIe. What is the
>>>>>>> meaning of Unrecoverable Machine Check error about GPU?
>>>>>>>
>>>>>>>
>>>>>>> Well see the explanation on Wikipedia for example:
>>>>>>> https://en.wikipedia.org/wiki/Machine-check_exception
>>>>>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fen.wikipedia.org%2Fwiki%2FMachine-check_exception&data=3D02%7C01%7Cchrist=
ian.koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637109742603345420&sdata=3DNtHiZmL7me4JRZR4L9KHZz=
pD8Zcn6caURVvtiDSgHsE%3D&reserved=3D0>
>>>>>>>
>>>>>>> In general it means you have messed up something in your hardware
>>>>>>> configuration.
>>>>>>>
>>>>>>> Could PCIe settings in .dts file cause this problem?
>>>>>>>
>>>>>>>
>>>>>>> Possible, but rather unlikely. My best guess is that it is some
>>>>>>> problem with the power supply.
>>>>>>>
>>>>>>> If it is, is there any sample PCIe configuration for E9171?
>>>>>>>
>>>>>>>
>>>>>>> The E9171 is just a PCIe device, so the dtsi is actually rather
>>>>>>> uninteresting. What we really need is a full dmesg and maybe lspci =
output
>>>>>>> would help as well.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi Christian,
>>>>>>
>>>>>> At first, I am using NXP T1042D4RDB-64B which has 256 MB PCIe buffer
>>>>>> according to its. PCIe memory range was arranged to 256 MB in .dts f=
ile and
>>>>>> in U-boot configuration file. Driver was giving error with exit code=
 -12
>>>>>> (OUT_OF_MEMORY). But I was able to reach the linux console.
>>>>>>
>>>>>> [    5.512922] [drm] amdgpu kernel modesetting enabled.
>>>>>> [    5.517065] [drm] initializing kernel modesetting (POLARIS12
>>>>>> 0x1002:0x6987 0x1787:0x2389 0x80).
>>>>>> [    5.524507] amdgpu 0001:01:00.0: Fatal error during GPU init
>>>>>> [    5.529296] amdgpu: probe of 0001:01:00.0 failed with error -12
>>>>>>
>>>>>> Then I canged 256 MB to 4GB in .dtsi and U-boot conf file. I also
>>>>>> changed 64KB I/O size to 1MB . When I do this, I wasn't able to reac=
h the
>>>>>> linux console because board was freezing. But driver was successfull=
 at
>>>>>> this time. I already mentioned successfull driver console logs up.
>>>>>>
>>>>>> *this is lspci -v when GPU is plugged and Memory size is 256 MB.*
>>>>>>
>>>>>> root@t1042d4rdb-64b:~# lspci -v
>>>>>> 0000:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0824 (re=
v
>>>>>> 11) (prog-if 00 [Normal decode])
>>>>>>         Device tree node: /sys/firmware/devicetree/base/pcie@ffe2400=
00
>>>>>> /pcie@0
>>>>>>         Flags: bus master, fast devsel, latency 0, IRQ 20
>>>>>>         Memory at <ignored> (32-bit, non-prefetchable)
>>>>>>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-lat=
ency=3D0
>>>>>>         I/O behind bridge: 00000000-0000ffff [size=3D64K]
>>>>>>         Memory behind bridge: e0000000-efffffff [size=3D256M]
>>>>>>         Prefetchable memory behind bridge: None
>>>>>>         Capabilities: [44] Power Management version 3
>>>>>>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>>>>>         Capabilities: [100] Advanced Error Reporting
>>>>>>         Kernel driver in use: pcieport
>>>>>>
>>>>>> 0001:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0824 (re=
v
>>>>>> 11) (prog-if 00 [Normal decode])
>>>>>>         Device tree node: /sys/firmware/devicetree/base/pcie@ffe2500=
00
>>>>>> /pcie@0
>>>>>>         Flags: bus master, fast devsel, latency 0, IRQ 21
>>>>>>         Memory at <ignored> (32-bit, non-prefetchable)
>>>>>>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-lat=
ency=3D0
>>>>>>         I/O behind bridge: 00000000-0000ffff [size=3D64K]
>>>>>>         Memory behind bridge: e0000000-efffffff [size=3D256M]
>>>>>>         Prefetchable memory behind bridge: None
>>>>>>         Capabilities: [44] Power Management version 3
>>>>>>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>>>>>         Capabilities: [100] Advanced Error Reporting
>>>>>>         Kernel driver in use: pcieport
>>>>>>
>>>>>> 0001:01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>>>>> [AMD/ATI] Lexa [Radeon E9171 MCM] (rev 80) (prog-if 00 [VGA controll=
er])
>>>>>>         Subsystem: Hightech Information System Ltd. Device 2389
>>>>>>         Flags: fast devsel, IRQ 41
>>>>>>         Memory at c10000000 (64-bit, prefetchable) [size=3D256M]
>>>>>>         Memory at <ignored> (64-bit, prefetchable)
>>>>>>         I/O ports at 1100 [size=3D256]
>>>>>>         Memory at <ignored> (32-bit, non-prefetchable)
>>>>>>         Expansion ROM at <ignored> [disabled]
>>>>>>         Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
>>>>>>         Capabilities: [50] Power Management version 3
>>>>>>         Capabilities: [58] Express Legacy Endpoint, MSI 00
>>>>>>         Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>>>>>>         Capabilities: [100] Vendor Specific Information: ID=3D0001
>>>>>> Rev=3D1 Len=3D010 <?>
>>>>>>         Capabilities: [150] Advanced Error Reporting
>>>>>>         Capabilities: [200] Resizable BAR <?>
>>>>>>         Capabilities: [270] Secondary PCI Express <?>
>>>>>>         Capabilities: [2b0] Address Translation Service (ATS)
>>>>>>         Capabilities: [2c0] Page Request Interface (PRI)
>>>>>>         Capabilities: [2d0] Process Address Space ID (PASID)
>>>>>>         Capabilities: [320] Latency Tolerance Reporting
>>>>>>         Capabilities: [328] Alternative Routing-ID Interpretation
>>>>>> (ARI)
>>>>>>         Capabilities: [370] L1 PM Substates
>>>>>>         Kernel modules: amdgpu
>>>>>>
>>>>>> 0001:01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
>>>>>> Device aae0
>>>>>>         Subsystem: Hightech Information System Ltd. Device aae0
>>>>>>         Flags: bus master, fast devsel, latency 0, IRQ 17
>>>>>>         Memory at <ignored> (64-bit, non-prefetchable)
>>>>>>         Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
>>>>>>         Capabilities: [50] Power Management version 3
>>>>>>         Capabilities: [58] Express Legacy Endpoint, MSI 00
>>>>>>         Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>>>>>>         Capabilities: [100] Vendor Specific Information: ID=3D0001
>>>>>> Rev=3D1 Len=3D010 <?>
>>>>>>         Capabilities: [150] Advanced Error Reporting
>>>>>>         Capabilities: [328] Alternative Routing-ID Interpretation
>>>>>> (ARI)
>>>>>>
>>>>>> 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0824 (re=
v
>>>>>> 11) (prog-if 00 [Normal decode])
>>>>>>         Device tree node: /sys/firmware/devicetree/base/pcie@ffe2600=
00
>>>>>> /pcie@0
>>>>>>         Flags: bus master, fast devsel, latency 0, IRQ 22
>>>>>>         Memory at <ignored> (32-bit, non-prefetchable)
>>>>>>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-lat=
ency=3D0
>>>>>>         I/O behind bridge: 00000000-0000ffff [size=3D64K]
>>>>>>         Memory behind bridge: e0000000-efffffff [size=3D256M]
>>>>>>         Prefetchable memory behind bridge: None
>>>>>>         Capabilities: [44] Power Management version 3
>>>>>>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>>>>>         Capabilities: [100] Advanced Error Reporting
>>>>>>         Kernel driver in use: pcieport
>>>>>>
>>>>>> 0003:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0824 (re=
v
>>>>>> 11) (prog-if 00 [Normal decode])
>>>>>>         Device tree node: /sys/firmware/devicetree/base/pcie@ffe2700=
00
>>>>>> /pcie@0
>>>>>>         Flags: bus master, fast devsel, latency 0, IRQ 23
>>>>>>         Memory at <ignored> (32-bit, non-prefetchable)
>>>>>>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-lat=
ency=3D0
>>>>>>         I/O behind bridge: 00000000-0000ffff [size=3D64K]
>>>>>>         Memory behind bridge: e0000000-efffffff [size=3D256M]
>>>>>>         Prefetchable memory behind bridge: None
>>>>>>         Capabilities: [44] Power Management version 3
>>>>>>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>>>>>         Capabilities: [100] Advanced Error Reporting
>>>>>>         Kernel driver in use: pcieport
>>>>>>
>>>>>> *AND This is PCIe dmesg message when memory range is 256MB. It's als=
o
>>>>>> giving same message when memory range is arranged as 4GB;*
>>>>>>
>>>>>> PCI host bridge /pcie@ffe240000  ranges:
>>>>>>  MEM 0x0000000c00000000..0x0000000c0fffffff -> 0x00000000e0000000
>>>>>>   IO 0x0000000ff8000000..0x0000000ff800ffff -> 0x0000000000000000
>>>>>> /pcie@ffe240000: PCICSRBAR @ 0xff000000
>>>>>> setup_pci_atmu: end of DRAM 200000000
>>>>>> /pcie@ffe240000: Setup 64-bit PCI DMA window
>>>>>> /pcie@ffe240000: WARNING: Outbound window cfg leaves gaps in memory
>>>>>> map. Adjusting the memory map could reduce unnecessary bounce buffer=
ing.
>>>>>> /pcie@ffe240000: DMA window size is 0xe0000000
>>>>>> Found FSL PCI host bridge at 0x0000000ffe250000. Firmware bus number=
:
>>>>>> 0->1
>>>>>> PCI host bridge /pcie@ffe250000  ranges:
>>>>>>  MEM 0x0000000c10000000..0x0000000c1fffffff -> 0x00000000e0000000
>>>>>>   IO 0x0000000ff8010000..0x0000000ff801ffff -> 0x0000000000000000
>>>>>> /pcie@ffe250000: PCICSRBAR @ 0xff000000
>>>>>> setup_pci_atmu: end of DRAM 200000000
>>>>>> /pcie@ffe250000: Setup 64-bit PCI DMA window
>>>>>> /pcie@ffe250000: WARNING: Outbound window cfg leaves gaps in memory
>>>>>> map. Adjusting the memory map could reduce unnecessary bounce buffer=
ing.
>>>>>> /pcie@ffe250000: DMA window size is 0xe0000000
>>>>>> Found FSL PCI host bridge at 0x0000000ffe260000. Firmware bus number=
:
>>>>>> 0->0
>>>>>> PCI host bridge /pcie@ffe260000  ranges:
>>>>>>  MEM 0x0000000c20000000..0x0000000c2fffffff -> 0x00000000e0000000
>>>>>>   IO 0x0000000ff8020000..0x0000000ff802ffff -> 0x0000000000000000
>>>>>> /pcie@ffe260000: PCICSRBAR @ 0xff000000
>>>>>> setup_pci_atmu: end of DRAM 200000000
>>>>>> /pcie@ffe260000: Setup 64-bit PCI DMA window
>>>>>> /pcie@ffe260000: WARNING: Outbound window cfg leaves gaps in memory
>>>>>> map. Adjusting the memory map could reduce unnecessary bounce buffer=
ing.
>>>>>> /pcie@ffe260000: DMA window size is 0xe0000000
>>>>>> Found FSL PCI host bridge at 0x0000000ffe270000. Firmware bus number=
:
>>>>>> 0->0
>>>>>> PCI host bridge /pcie@ffe270000  ranges:
>>>>>>  MEM 0x0000000c30000000..0x0000000c3fffffff -> 0x00000000e0000000
>>>>>>   IO 0x0000000ff8030000..0x0000000ff803ffff -> 0x0000000000000000
>>>>>> /pcie@ffe270000: PCICSRBAR @ 0xff000000
>>>>>> setup_pci_atmu: end of DRAM 200000000
>>>>>> /pcie@ffe270000: Setup 64-bit PCI DMA window
>>>>>> /pcie@ffe270000: WARNING: Outbound window cfg leaves gaps in memory
>>>>>> map. Adjusting the memory map could reduce unnecessary bounce buffer=
ing.
>>>>>> /pcie@ffe270000: DMA window size is 0xe0000000
>>>>>> iommu: Adding device ff6000000.qman-portal to group 0
>>>>>> iommu: Adding device ff6004000.qman-portal to group 1
>>>>>> iommu: Adding device ff6008000.qman-portal to group 2
>>>>>> iommu: Adding device ff600c000.qman-portal to group 3
>>>>>> iommu: Adding device ff6010000.qman-portal to group 4
>>>>>> iommu: Adding device ff6014000.qman-portal to group 5
>>>>>> iommu: Adding device ff6018000.qman-portal to group 6
>>>>>> iommu: Adding device ff601c000.qman-portal to group 7
>>>>>> iommu: Adding device ff6020000.qman-portal to group 8
>>>>>> iommu: Adding device ff6024000.qman-portal to group 9
>>>>>> iommu: Adding device ffe100300.dma to group 10
>>>>>> iommu: Adding device ffe101300.dma to group 11
>>>>>> iommu: Adding device ffe114000.sdhc to group 12
>>>>>> iommu: Adding device ffe210000.usb to group 13
>>>>>> iommu: Adding device ffe211000.usb to group 14
>>>>>> iommu: Adding device ffe220000.sata to group 15
>>>>>> iommu: Adding device ffe221000.sata to group 16
>>>>>> iommu: Adding device ffe318000.qman to group 17
>>>>>> iommu: Adding device ffe31a000.bman to group 18
>>>>>> iommu: Adding device ffe240000.pcie to group 19
>>>>>> iommu: Adding device ffe250000.pcie to group 20
>>>>>> iommu: Adding device ffe260000.pcie to group 21
>>>>>> iommu: Adding device ffe270000.pcie to group 22
>>>>>> iommu: Adding device ffe140000.qe to group 23
>>>>>> software IO TLB: mapped [mem 0xfbfff000-0xfffff000] (64MB)
>>>>>> PCI: Probing PCI hardware
>>>>>> fsl-pci ffe240000.pcie: PCI host bridge to bus 0000:00
>>>>>> pci_bus 0000:00: root bus resource [io
>>>>>>  0x8000080000010000-0x800008000001ffff] (bus address [0x0000-0xffff]=
)
>>>>>> pci_bus 0000:00: root bus resource [mem 0xc00000000-0xc0fffffff] (bu=
s
>>>>>> address [0xe0000000-0xefffffff])
>>>>>> pci_bus 0000:00: root bus resource [bus 00]
>>>>>> iommu: Removing device ffe240000.pcie from group 19
>>>>>> iommu: Adding device 0000:00:00.0 to group 24
>>>>>> pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]),
>>>>>> reconfiguring
>>>>>> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>>>>>> fsl-pci ffe250000.pcie: PCI host bridge to bus 0001:00
>>>>>> pci_bus 0001:00: root bus resource [io
>>>>>>  0x8000080000021000-0x8000080000030fff] (bus address [0x0000-0xffff]=
)
>>>>>> pci_bus 0001:00: root bus resource [mem 0xc10000000-0xc1fffffff] (bu=
s
>>>>>> address [0xe0000000-0xefffffff])
>>>>>> pci_bus 0001:00: root bus resource [bus 00-01]
>>>>>> iommu: Removing device ffe250000.pcie from group 20
>>>>>> iommu: Adding device 0001:00:00.0 to group 19
>>>>>> pci 0001:01:00.0: enabling Extended Tags
>>>>>> pci 0001:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5
>>>>>> GT/s x1 link at 0001:00:00.0 (capable of 63.008 Gb/s with 8 GT/s x8 =
link)
>>>>>> iommu: Adding device 0001:01:00.0 to group 19
>>>>>> pci 0001:01:00.1: enabling Extended Tags
>>>>>> iommu: Adding device 0001:01:00.1 to group 19
>>>>>> pci 0001:00:00.0: PCI bridge to [bus 01-ff]
>>>>>> fsl-pci ffe260000.pcie: PCI host bridge to bus 0002:00
>>>>>> pci_bus 0002:00: root bus resource [io
>>>>>>  0x8000080000032000-0x8000080000041fff] (bus address [0x0000-0xffff]=
)
>>>>>> pci_bus 0002:00: root bus resource [mem 0xc20000000-0xc2fffffff] (bu=
s
>>>>>> address [0xe0000000-0xefffffff])
>>>>>> pci_bus 0002:00: root bus resource [bus 00]
>>>>>> iommu: Removing device ffe260000.pcie from group 21
>>>>>> iommu: Adding device 0002:00:00.0 to group 20
>>>>>> pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]),
>>>>>> reconfiguring
>>>>>> pci 0002:00:00.0: PCI bridge to [bus 01-ff]
>>>>>> fsl-pci ffe270000.pcie: PCI host bridge to bus 0003:00
>>>>>> pci_bus 0003:00: root bus resource [io
>>>>>>  0x8000080000043000-0x8000080000052fff] (bus address [0x0000-0xffff]=
)
>>>>>> pci_bus 0003:00: root bus resource [mem 0xc30000000-0xc3fffffff] (bu=
s
>>>>>> address [0xe0000000-0xefffffff])
>>>>>> pci_bus 0003:00: root bus resource [bus 00]
>>>>>> iommu: Removing device ffe270000.pcie from group 22
>>>>>> iommu: Adding device 0003:00:00.0 to group 21
>>>>>> pci 0003:00:00.0: bridge configuration invalid ([bus 00-00]),
>>>>>> reconfiguring
>>>>>> pci 0003:00:00.0: PCI bridge to [bus 01-ff]
>>>>>> PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will
>>>>>> remap
>>>>>> PCI: Cannot allocate resource region 0 of device 0001:00:00.0, will
>>>>>> remap
>>>>>> PCI: Cannot allocate resource region 2 of device 0001:01:00.0, will
>>>>>> remap
>>>>>> PCI: Cannot allocate resource region 5 of device 0001:01:00.0, will
>>>>>> remap
>>>>>> PCI: Cannot allocate resource region 6 of device 0001:01:00.0, will
>>>>>> remap
>>>>>> PCI: Cannot allocate resource region 0 of device 0001:01:00.1, will
>>>>>> remap
>>>>>> PCI: Cannot allocate resource region 0 of device 0002:00:00.0, will
>>>>>> remap
>>>>>> PCI: Cannot allocate resource region 0 of device 0003:00:00.0, will
>>>>>> remap
>>>>>> pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000]
>>>>>> pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
>>>>>> pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>> pci 0000:00:00.0:   bridge window [io
>>>>>>  0x8000080000010000-0x800008000001ffff]
>>>>>> pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc0fffffff]
>>>>>> pci_bus 0000:00: Some PCI device resources are unassigned, try
>>>>>> booting with pci=3Drealloc
>>>>>> pci 0001:00:00.0: BAR 0: no space for [mem size 0x01000000]
>>>>>> pci 0001:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
>>>>>> pci 0001:00:00.0: BAR 9: no space for [mem size 0x00200000 64bit pre=
f]
>>>>>> pci 0001:00:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit
>>>>>> pref]
>>>>>> pci 0001:01:00.0: BAR 2: no space for [mem size 0x00200000 64bit pre=
f]
>>>>>> pci 0001:01:00.0: BAR 2: failed to assign [mem size 0x00200000 64bit
>>>>>> pref]
>>>>>> pci 0001:01:00.0: BAR 5: no space for [mem size 0x00040000]
>>>>>> pci 0001:01:00.0: BAR 5: failed to assign [mem size 0x00040000]
>>>>>> pci 0001:01:00.0: BAR 6: no space for [mem size 0x00020000 pref]
>>>>>> pci 0001:01:00.0: BAR 6: failed to assign [mem size 0x00020000 pref]
>>>>>> pci 0001:01:00.1: BAR 0: no space for [mem size 0x00004000 64bit]
>>>>>> pci 0001:01:00.1: BAR 0: failed to assign [mem size 0x00004000 64bit=
]
>>>>>> pci 0001:00:00.0: PCI bridge to [bus 01]
>>>>>> pci 0001:00:00.0:   bridge window [io
>>>>>>  0x8000080000021000-0x8000080000030fff]
>>>>>> pci 0001:00:00.0:   bridge window [mem 0xc10000000-0xc1fffffff]
>>>>>> pci_bus 0001:00: Some PCI device resources are unassigned, try
>>>>>> booting with pci=3Drealloc
>>>>>> pci 0002:00:00.0: BAR 0: no space for [mem size 0x01000000]
>>>>>> pci 0002:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
>>>>>> pci 0002:00:00.0: PCI bridge to [bus 01]
>>>>>> pci 0002:00:00.0:   bridge window [io
>>>>>>  0x8000080000032000-0x8000080000041fff]
>>>>>> pci 0002:00:00.0:   bridge window [mem 0xc20000000-0xc2fffffff]
>>>>>> pci_bus 0002:00: Some PCI device resources are unassigned, try
>>>>>> booting with pci=3Drealloc
>>>>>> pci 0003:00:00.0: BAR 0: no space for [mem size 0x01000000]
>>>>>> pci 0003:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
>>>>>> pci 0003:00:00.0: PCI bridge to [bus 01]
>>>>>> pci 0003:00:00.0:   bridge window [io
>>>>>>  0x8000080000043000-0x8000080000052fff]
>>>>>> pci 0003:00:00.0:   bridge window [mem 0xc30000000-0xc3fffffff]
>>>>>> pci_bus 0003:00: Some PCI device resources are unassigned, try
>>>>>> booting with pci=3Drealloc
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freede=
sktop.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outl=
ook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fa=
md-gfx&data=3D02%7C01%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad08=
d777ef717c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637109742603345420&=
sdata=3DPO02mQtDBnkAdNfCn%2Fp7QmKX8IbJ7zke8edrfhsM6Mg%3D&reserved=3D0>
>>>>>
>>>>>
>>>>>
>>>
>>

--00000000000088ab02059b242897
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Christian,</div><div><br></div><div>I solved th=
is problem weeks ago. The problem was, the system I use could only give 256=
 MB address range but GPU was demanding more. Even if I give 4 GB, PCIe slo=
t is only having 256 MB, nothing more.=C2=A0 I put a empty area that is bet=
ween PCIe2 ( GPU was connected to this) and PCIe3 and everything worked fin=
e ( I moved forward the start adress of next PCIe device) . If anyone encou=
nters same problem, here is a sample Device Tree Source for linux;</div><di=
v><br></div><div>pci0: pcie@ffe240000 {<br>		reg =3D &lt;0xf 0xfe240000 0 0=
x10000&gt;;<br>		ranges =3D &lt;0x02000000 0 0xe0000000 0x2 0x0 0x0 0x10000=
000<br>			 =C2=A00x01000000 0 0x0 0xf 0xf8000000 0x0 0x00010000&gt;;<br>		p=
cie@0 {<br>			ranges =3D &lt;0x02000000 0 0xe0000000<br>				 =C2=A00x020000=
00 0 0xe0000000<br>				 =C2=A00 0x10000000<br><br>				 =C2=A00x01000000 0 0=
x00000000<br>				 =C2=A00x01000000 0 0x00000000<br>				 =C2=A00 0x00010000&=
gt;;<br>		};<br>	};<br><br>	pci1: pcie@ffe250000 { // GPU CONNECTED TO THIS=
 ONE<br>		reg =3D &lt;0xf 0xfe250000 0 0x10000&gt;;<br>		ranges =3D &lt;0x0=
2000000 0 0xe0000000 0x2 0x10000000 0x1 0x00000000<br>			 =C2=A00x01000000 =
0 0 0xf 0xf8010000 0 0x00010000&gt;;<br>		pcie@0 {<br>			ranges =3D &lt;0x0=
2000000 0 0xe0000000<br>				 =C2=A00x02000000 0 0xe0000000<br>				 =C2=A00x=
1 0x00000000<br><br>				 =C2=A00x01000000 0 0x00000000<br>				 =C2=A00x0100=
0000 0 0x00000000<br>				 =C2=A00 0x00010000&gt;;<br>		};<br>	};<br><br>	pc=
i2: pcie@ffe260000 {<br>		reg =3D &lt;0xf 0xfe260000 0 0x10000&gt;;<br>		ra=
nges =3D &lt;0x02000000 0 0xe0000000 0x3 0x20000000 0 0x10000000 // 0x3 0x2=
0000000 actually it must be 0x3 0x10000000 because I gave 4 GB to pci1 but =
I also added 256 MB empty area between them. So it started from 0x3 0x20000=
000<br>			 =C2=A00x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000&gt;;<b=
r>		pcie@0 {<br>			ranges =3D &lt;0x02000000 0 0xe0000000<br>				 =C2=A00x0=
2000000 0 0xe0000000<br>				 =C2=A00 0x10000000<br><br>				 =C2=A00x0100000=
0 0 0x00000000<br>				 =C2=A00x01000000 0 0x00000000<br>				 =C2=A00 0x0001=
0000&gt;;<br>		};<br>	};<br><br>	pci3: pcie@ffe270000 {<br>		reg =3D &lt;0x=
f 0xfe270000 0 0x10000&gt;;<br>		ranges =3D &lt;0x02000000 0 0xe0000000 0x3=
 0x30000000 0 0x10000000<br>			 =C2=A00x01000000 0 0x00000000 0xf 0xf803000=
0 0 0x00010000&gt;;<br>		pcie@0 {<br>			ranges =3D &lt;0x02000000 0 0xe0000=
000<br>				 =C2=A00x02000000 0 0xe0000000<br>				 =C2=A00 0x10000000<br><br=
>				 =C2=A00x01000000 0 0x00000000<br>				 =C2=A00x01000000 0 0x00000000<b=
r>				 =C2=A00 0x00010000&gt;;<br>		};<br>	};<br></div><div><br></div><div>=
<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">Yusuf Alt=C4=B1parmak &lt;<a href=3D"mailto:yusufalti1997@gmail.c=
om">yusufalti1997@gmail.com</a>&gt;, 3 Ara 2019 Sal, 22:20 tarihinde =C5=9F=
unu yazd=C4=B1:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF"><div=
>What you could try as well is to use the size 320MB for the MMIO.
      Those ranges usually don&#39;t need to be a power of two (only the
      BARs itself are a power of two) and this way it might even be
      easier to fit everything together.<br></div></div></blockquote><div><=
br></div><div>Hmm this makes my job easier=C2=A0it seems.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFF=
FFF"><div>
      <blockquote type=3D"cite">By the way I wonder how can I get at least
        VGA output from GPU. Maybe I can get a text console on screen or
        something like X server? Do you have any recommendations?</blockquo=
te>
      What could maybe work is VGA emulation, which essentially means
      text only. But no guarantee for that this really works as
      expected.<br>
      <br></div></div></blockquote><div>It&#39;s a well known board and U-b=
oot is the most popular bootloader in embedded world it seems. I think I am=
 not the only one who tries to connect a GPU from PCIe so I think there mus=
t be some config variables that enables VGA emulation, or some kind of pack=
ages.</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div bgcolor=3D"#FFFFFF"><div>
      <blockquote type=3D"cite">I am just wondering, does modern gaming
        motherboards have more than 4GB PCIe buffer for this job ?</blockqu=
ote>
      They don&#39;t, resources are dynamically assigned instead.<br>
      <br>
      See on x86 you usually have 1GB 32-bit address space where the
      BIOS shuffles all the mandatory devices it sees at boot time into.
      <br>
      <br>
      Then when the motherboard has multiple PEG slots the BIOS also
      configures a 64-bit address space which is usually rather huge
      (256GB-1TB). Since the the VRAM and the doorbell BAR are 64bit
      BARs on the GPU they can be mapped into that as well.<br>
      <br>
      This way you can easily have 10 GPUs connected to your CPU.<br>
      <br></div></div></blockquote><div><div>Ah that was a clear answer. So=
 the adress that CPU uses after mapping is actully an imaginary/virtual adr=
ess. It depends on the operating systems bit configuration. If I am not wro=
ng, those addresses are adding on previous one meanwhile PCIe is mapping wi=
th endpoint device.=C2=A0</div><div></div></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFF=
FFF"><div>
      The problem you have here is that U-config doesn&#39;t do this
      resource assignment automatically and you need to configure it
      manually.<br></div></div></blockquote><div><br></div><div>Yes. By the=
 way, thanks for your answers Christian. I am a newbie to embedded world. I=
 have been dealing with these stuffs for 3 months. I couldn&#39;t get the a=
nswers I seek from google. Your answers were more clear and understandable.=
=C2=A0</div><div><br></div><div>Best Regards.</div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"=
#FFFFFF"><div>
      Am 03.12.19 um 13:50 schrieb Yusuf Alt=C4=B1parmak:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr"><br>
        </div>
        Hi Christian,<br>
        <div>
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div bgcolor=3D"#FFFFFF">
                <div>
                  <blockquote type=3D"cite">0001f000</blockquote>
                  Exactly as I thought. The hardware does support BAR
                  resize, but unfortunately 256MB is already the
                  minimum.<br>
                  <br>
                  Sorry, but there isn&#39;t anything I could do from the
                  GPU drivers point of view.<br>
                </div>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>Yes unfortunately there is nothing remained to about
              GPU side. <br>
            </div>
            <div><br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div bgcolor=3D"#FFFFFF">
                <div> The only good news I have is that
                  256M+2M+512K+128K=3D260M address space should be enough
                  for the GPU to work, maybe that makes things a bit
                  simpler.<br>
                  <br>
                </div>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>Right now I am trying to increase MMIO size config to
              512 MB, I hope that should help me. By the way I wonder
              how can I get at least VGA output from GPU. Maybe I can
              get a text console on screen or something like X server?
              Do you have any recommendations? I tried this GPU with my
              own Ubuntu 18.04 and its special driver. Everything worked
              fine.</div>
            <div><br>
            </div>
            <div>=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div bgcolor=3D"#FFFFFF">
                <div> But you definitely got an interesting use case
                  here :)</div>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>This is the worlds the most interesting use case I
              think. I can&#39;t increase MMIO size because U-boot freezes.
              I can&#39;t decrease it to 256 MB again because driver does
              not accept :D. I am just wondering, does modern gaming
              motherboards have more than 4GB PCIe buffer for this job ?
              :D<br>
            </div>
            <div><br>
            </div>
            <div><br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div bgcolor=3D"#FFFFFF">
                <div> Am 03.12.19 um 11:31 schrieb Yusuf Alt=C4=B1parmak:<b=
r>
                </div>
                <blockquote type=3D"cite">
                  <div dir=3D"ltr">
                    <div>Hello Christian,</div>
                    <div>My &quot;setpci -s 0001:01:00.0 ECAP15+4.l
                      ECAP15+8.l&quot; output is;</div>
                    <div><br>
                    </div>
                    <div>0001f000 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
                      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>
                      00000820 <br>
                    </div>
                    <div><br>
                    </div>
                    <div>Regards.<br>
                    </div>
                    <div><br>
                    </div>
                    <div><br>
                    </div>
                    <br>
                    <div class=3D"gmail_quote">
                      <div dir=3D"ltr" class=3D"gmail_attr">Yusuf Alt=C4=B1=
parmak
                        &lt;<a href=3D"mailto:yusufalti1997@gmail.com" targ=
et=3D"_blank">yusufalti1997@gmail.com</a>&gt;,
                        2 Ara 2019 Pzt, 19:31 tarihinde =C5=9Funu yazd=C4=
=B1:<br>
                      </div>
                      <blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                        <div dir=3D"ltr">
                          <div class=3D"gmail_quote">
                            <blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
                              <div bgcolor=3D"#FFFFFF">Most likely not.
                                There is support for resizing the VRAM
                                BAR, but usually you can only make it
                                larger and not smaller.<br>
                                Please give me the output of &quot;sudo
                                setpci -s 0001:01:00.0 ECAP15+4.l
                                ECAP15+8.l&quot; if you want to double chec=
k
                                that.<br>
                              </div>
                            </blockquote>
                            <div><br>
                            </div>
                            <div>Okay I&#39;ll try it tomorrow. What does
                              the &quot; sudo setpci -s 0001:01:00.0
                              ECAP15+4.l ECAP15+8.l&quot; command exactly d=
o
                              ?</div>
                            <div><br>
                            </div>
                            <div>=C2=A0</div>
                            <blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
                              <div bgcolor=3D"#FFFFFF"> Well you rather
                                need to ask if anybody has sample PCIe
                                configuration for GPUs in general. That
                                problem is not really E9171 related. You
                                might want to ask NXP for that maybe.<br>
                                Sorry, no idea if that is correct or
                                not. You need to ask NXP for help with
                                that.<br>
                                <br>
                              </div>
                            </blockquote>
                            <div><br>
                            </div>
                            <div>Okay no problem. At least I know what
                              is the missing point now. The problem is
                              probably because of the .dtsi and u-boot
                              config files. Memory ranges are
                              overwriting like you said. I&#39;ll ask nxp t=
o
                              take some sample PCIe configuration for
                              GPUs.</div>
                            <div><br>
                            </div>
                            <div>Thank you for your interest Christian.</di=
v>
                            <div>Regards .<br>
                            </div>
                            <div>=C2=A0</div>
                            <blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
                              <div bgcolor=3D"#FFFFFF">
                                <blockquote type=3D"cite">
                                  <div dir=3D"ltr">
                                    <div class=3D"gmail_quote">
                                      <div><br>
                                      </div>
                                      <blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
                                        <div bgcolor=3D"#FFFFFF">
                                          <div> Am 02.12.19 um 14:32
                                            schrieb Yusuf Alt=C4=B1parmak:<=
br>
                                          </div>
                                          <blockquote type=3D"cite">
                                            <div dir=3D"ltr">
                                              <div class=3D"gmail_quote">
                                                <blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
                                                  <div bgcolor=3D"#FFFFFF">=
<br>
                                                    <blockquote type=3D"cit=
e">I
                                                      attached my dts
                                                      file.<br>
                                                      <div>
                                                        <div><br>
                                                        </div>
                                                        <div>System is
                                                          working fine
                                                          when GPU is
                                                          not plugged
                                                          in.</div>
                                                        <div><b><br>
                                                          </b></div>
                                                        <div><b>This is
                                                          the last
                                                          console log
                                                          before freeze:</b=
></div>
                                                        <div>[drm]
                                                          amdgpu kernel
                                                          modesetting
                                                          enabled. =C2=A0 =
=C2=A0 =C2=A0
                                                          =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                          =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                          =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0</div>
                                                        [drm]
                                                        initializing
                                                        kernel
                                                        modesetting
                                                        (POLARIS12
                                                        0x1002:0x6987
                                                        0x1787:0x2389
                                                        0x80).=C2=A0 <br>
                                                        [drm] register
                                                        mmio base:
                                                        0x20200000 =C2=A0 =
=C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        fsl-fman-port
                                                        ffe488000.port
                                                        fm1-gb0: renamed
                                                        from eth0 =C2=A0 =
=C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>
                                                        [drm] register
                                                        mmio size:
                                                        262144 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        [drm] add ip
                                                        block number 0
                                                        &lt;vi_common&gt;
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                                                        [drm] add ip
                                                        block number 1
                                                        &lt;gmc_v8_0&gt;
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        [drm] add ip
                                                        block number 2
                                                        &lt;tonga_ih&gt;
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        [drm] add ip
                                                        block number 3
                                                        &lt;powerplay&gt;
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                                                        [drm] add ip
                                                        block number 4
                                                        &lt;dm&gt; =C2=A0 =
=C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        [drm] add ip
                                                        block number 5
                                                        &lt;gfx_v8_0&gt;
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        [drm] add ip
                                                        block number 6
                                                        &lt;sdma_v3_0&gt;
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                                                        [drm] add ip
                                                        block number 7
                                                        &lt;uvd_v6_0&gt;
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        [drm] add ip
                                                        block number 8
                                                        &lt;vce_v3_0&gt;
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        [drm] UVD is
                                                        enabled in VM
                                                        mode =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <br>
                                                        [drm] UVD ENC is
                                                        enabled in VM
                                                        mode =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 <br>
                                                        [drm] VCE
                                                        enabled in VM
                                                        mode =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        ATOM BIOS:
                                                        113-ER16BFC-001
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        [drm] GPU
                                                        posting now... =C2=
=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0<br>
                                                        Disabling lock
                                                        debugging due to
                                                        kernel taint =C2=A0=
 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0<br>
                                                        Machine check in
                                                        kernel mode. =C2=A0=
 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 <br>
                                                        Caused by (from
                                                        MCSR=3Da000): Load
                                                        Error Report =C2=A0=
 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 <br>
                                                        Guarded Load
                                                        Error Report =C2=A0=
 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 <br>
                                                        Kernel panic -
                                                        not syncing:
                                                        Unrecoverable
                                                        Machine check =C2=
=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                                                        CPU: 1 PID: 2023
                                                        Comm: udevd
                                                        Tainted: G =C2=A0 M=
 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
                                                        =C2=A04.19.26+gc0c2=
141
                                                        #1 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
                                                        Call Trace: =C2=A0 =
=C2=A0
                                                        =C2=A0 <br>
                                                      </div>
                                                    </blockquote>
                                                  </div>
                                                </blockquote>
                                                <blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
                                                  <div bgcolor=3D"#FFFFFF">
                                                    <blockquote type=3D"cit=
e">
                                                      <div dir=3D"ltr">=C2=
=A0 =C2=A0
                                                        =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0
                                                        <br>
                                                      </div>
                                                      <br>
                                                      <fieldset></fieldset>
                                                      <pre>________________=
_______________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637109742603335427&amp;sdata=3DDstGsDW0X=
7ennQoF1vg%2FYLGAStF4p1dAeMFhzsAFc1I%3D&amp;reserved=3D0" target=3D"_blank"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
                                                    </blockquote>
                                                    <br>
                                                  </div>
                                                </blockquote>
                                                <div>
                                                  <div dir=3D"ltr"><br>
                                                  </div>
                                                  <br>
                                                  <div class=3D"gmail_quote=
">
                                                    <div dir=3D"ltr" class=
=3D"gmail_attr">Christian
                                                      K=C3=B6nig &lt;<a hre=
f=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.lei=
chtzumerken@gmail.com</a>&gt;, 2 Ara
                                                      2019 Pzt, 15:28
                                                      tarihinde =C5=9Funu
                                                      yazd=C4=B1:<br>
                                                    </div>
                                                    <blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
                                                      <div bgcolor=3D"#FFFF=
FF">
                                                        <div>Hi Yusuf,<br>
                                                          <br>
                                                          Am 02.12.19 um
                                                          12:41 schrieb
                                                          Yusuf
                                                          Alt=C4=B1parmak:<=
br>
                                                        </div>
                                                        <blockquote type=3D=
"cite">
                                                          <div dir=3D"ltr">
                                                          <div>My
                                                          embedded board
                                                          is freezing
                                                          when I put
                                                          E9171 on PCIe.
                                                          What is the
                                                          meaning of
                                                          Unrecoverable
                                                          Machine Check
                                                          error about
                                                          GPU? <br>
                                                          </div>
                                                          </div>
                                                        </blockquote>
                                                        <br>
                                                        Well see the
                                                        explanation on
                                                        Wikipedia for
                                                        example: <a href=3D=
"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fen.wik=
ipedia.org%2Fwiki%2FMachine-check_exception&amp;data=3D02%7C01%7Cchristian.=
koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637109742603345420&amp;sdata=3DNtHiZmL7me4JRZR4L9KHZz=
pD8Zcn6caURVvtiDSgHsE%3D&amp;reserved=3D0" target=3D"_blank">https://en.wik=
ipedia.org/wiki/Machine-check_exception</a><br>
                                                        <br>
                                                        In general it
                                                        means you have
                                                        messed up
                                                        something in
                                                        your hardware
                                                        configuration.<br>
                                                        <br>
                                                        <blockquote type=3D=
"cite">
                                                          <div dir=3D"ltr">
                                                          <div>Could
                                                          PCIe settings
                                                          in .dts file
                                                          cause this
                                                          problem?</div>
                                                          </div>
                                                        </blockquote>
                                                        <br>
                                                        Possible, but
                                                        rather unlikely.
                                                        My best guess is
                                                        that it is some
                                                        problem with the
                                                        power supply.<br>
                                                        <br>
                                                        <blockquote type=3D=
"cite">
                                                          <div dir=3D"ltr">
                                                          <div> If it
                                                          is, is there
                                                          any sample
                                                          PCIe
                                                          configuration
                                                          for E9171?</div>
                                                          </div>
                                                        </blockquote>
                                                        <br>
                                                        The E9171 is
                                                        just a PCIe
                                                        device, so the
                                                        dtsi is actually
                                                        rather
                                                        uninteresting.
                                                        What we really
                                                        need is a full
                                                        dmesg and maybe
                                                        lspci output
                                                        would help as
                                                        well.<br>
                                                        <br>
                                                        Regards,<br>
                                                        Christian.</div>
                                                    </blockquote>
                                                    <div><br>
                                                    </div>
                                                    <div><br>
                                                    </div>
                                                    <div>Hi Christian,</div=
>
                                                    <div><br>
                                                    </div>
                                                    <div>At first, I am
                                                      using NXP
                                                      T1042D4RDB-64B
                                                      which has 256 MB
                                                      PCIe buffer
                                                      according to its.
                                                      PCIe memory range
                                                      was arranged to
                                                      256 MB in .dts
                                                      file and in U-boot
                                                      configuration
                                                      file. Driver was
                                                      giving error with
                                                      exit code -12
                                                      (OUT_OF_MEMORY).
                                                      But I was able to
                                                      reach the linux
                                                      console. <br>
                                                    </div>
                                                    <div><br>
                                                    </div>
                                                    <div>[ =C2=A0 =C2=A05.5=
12922]
                                                      [drm] amdgpu
                                                      kernel modesetting
                                                      enabled.<br>
                                                      [ =C2=A0 =C2=A05.5170=
65]
                                                      [drm] initializing
                                                      kernel modesetting
                                                      (POLARIS12
                                                      0x1002:0x6987
                                                      0x1787:0x2389
                                                      0x80).<br>
                                                      [ =C2=A0 =C2=A05.5245=
07]
                                                      amdgpu
                                                      0001:01:00.0:
                                                      Fatal error during
                                                      GPU init<br>
                                                      [ =C2=A0 =C2=A05.5292=
96]
                                                      amdgpu: probe of
                                                      0001:01:00.0
                                                      failed with error
                                                      -12<br>
                                                    </div>
                                                    <div> <br>
                                                    </div>
                                                  </div>
                                                  Then I canged 256 MB
                                                  to 4GB in .dtsi and
                                                  U-boot conf file. I
                                                  also changed 64KB I/O
                                                  size to 1MB . When I
                                                  do this, I wasn&#39;t abl=
e
                                                  to reach the linux
                                                  console because board
                                                  was freezing. But
                                                  driver was successfull
                                                  at this time. I
                                                  already mentioned
                                                  successfull driver
                                                  console logs up.<br>
                                                </div>
                                                <div><br>
                                                </div>
                                                <div>
                                                  <div><b>this is lspci
                                                      -v when GPU is
                                                      plugged and Memory
                                                      size is 256 MB.</b></=
div>
                                                  <div><br>
                                                  </div>
                                                  <div>root@t1042d4rdb-64b:=
~#
                                                    lspci -v<br>
                                                    0000:00:00.0 PCI
                                                    bridge: Freescale
                                                    Semiconductor Inc
                                                    Device 0824 (rev 11)
                                                    (prog-if 00 [Normal
                                                    decode])<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Device tree
                                                    node:
                                                    /sys/firmware/devicetre=
e/base/pcie@ffe240000/pcie@0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 20<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Bus:
                                                    primary=3D00,
                                                    secondary=3D01,
                                                    subordinate=3D01,
                                                    sec-latency=3D0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 I/O behind
                                                    bridge:
                                                    00000000-0000ffff
                                                    [size=3D64K]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory
                                                    behind bridge:
                                                    e0000000-efffffff
                                                    [size=3D256M]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Prefetchable
                                                    memory behind
                                                    bridge: None<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [44]
                                                    Power Management
                                                    version 3<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [4c]
                                                    Express Root Port
                                                    (Slot-), MSI 00<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [100]
                                                    Advanced Error
                                                    Reporting<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Kernel
                                                    driver in use:
                                                    pcieport<br>
                                                    <br>
                                                    0001:00:00.0 PCI
                                                    bridge: Freescale
                                                    Semiconductor Inc
                                                    Device 0824 (rev 11)
                                                    (prog-if 00 [Normal
                                                    decode])<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Device tree
                                                    node:
                                                    /sys/firmware/devicetre=
e/base/pcie@ffe250000/pcie@0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 21<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Bus:
                                                    primary=3D00,
                                                    secondary=3D01,
                                                    subordinate=3D01,
                                                    sec-latency=3D0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 I/O behind
                                                    bridge:
                                                    00000000-0000ffff
                                                    [size=3D64K]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory
                                                    behind bridge:
                                                    e0000000-efffffff
                                                    [size=3D256M]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Prefetchable
                                                    memory behind
                                                    bridge: None<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [44]
                                                    Power Management
                                                    version 3<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [4c]
                                                    Express Root Port
                                                    (Slot-), MSI 00<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [100]
                                                    Advanced Error
                                                    Reporting<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Kernel
                                                    driver in use:
                                                    pcieport<br>
                                                    <br>
                                                    0001:01:00.0 VGA
                                                    compatible
                                                    controller: Advanced
                                                    Micro Devices, Inc.
                                                    [AMD/ATI] Lexa
                                                    [Radeon E9171 MCM]
                                                    (rev 80) (prog-if 00
                                                    [VGA controller])<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Subsystem:
                                                    Hightech Information
                                                    System Ltd. Device
                                                    2389<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Flags: fast
                                                    devsel, IRQ 41<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory at
                                                    c10000000 (64-bit,
                                                    prefetchable)
                                                    [size=3D256M]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory at
                                                    &lt;ignored&gt;
                                                    (64-bit,
                                                    prefetchable)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 I/O ports at
                                                    1100 [size=3D256]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Expansion
                                                    ROM at
                                                    &lt;ignored&gt;
                                                    [disabled]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [48]
                                                    Vendor Specific
                                                    Information: Len=3D08
                                                    &lt;?&gt;<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [50]
                                                    Power Management
                                                    version 3<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [58]
                                                    Express Legacy
                                                    Endpoint, MSI 00<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [a0]
                                                    MSI: Enable-
                                                    Count=3D1/1 Maskable-
                                                    64bit+<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [100]
                                                    Vendor Specific
                                                    Information: ID=3D0001
                                                    Rev=3D1 Len=3D010
                                                    &lt;?&gt;<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [150]
                                                    Advanced Error
                                                    Reporting<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [200]
                                                    Resizable BAR
                                                    &lt;?&gt;<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [270]
                                                    Secondary PCI
                                                    Express &lt;?&gt;<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [2b0]
                                                    Address Translation
                                                    Service (ATS)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [2c0]
                                                    Page Request
                                                    Interface (PRI)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [2d0]
                                                    Process Address
                                                    Space ID (PASID)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [320]
                                                    Latency Tolerance
                                                    Reporting<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [328]
                                                    Alternative
                                                    Routing-ID
                                                    Interpretation (ARI)<br=
>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [370]
                                                    L1 PM Substates<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Kernel
                                                    modules: amdgpu<br>
                                                    <br>
                                                    0001:01:00.1 Audio
                                                    device: Advanced
                                                    Micro Devices, Inc.
                                                    [AMD/ATI] Device
                                                    aae0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Subsystem:
                                                    Hightech Information
                                                    System Ltd. Device
                                                    aae0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 17<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory at
                                                    &lt;ignored&gt;
                                                    (64-bit,
                                                    non-prefetchable)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [48]
                                                    Vendor Specific
                                                    Information: Len=3D08
                                                    &lt;?&gt;<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [50]
                                                    Power Management
                                                    version 3<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [58]
                                                    Express Legacy
                                                    Endpoint, MSI 00<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [a0]
                                                    MSI: Enable-
                                                    Count=3D1/1 Maskable-
                                                    64bit+<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [100]
                                                    Vendor Specific
                                                    Information: ID=3D0001
                                                    Rev=3D1 Len=3D010
                                                    &lt;?&gt;<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [150]
                                                    Advanced Error
                                                    Reporting<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [328]
                                                    Alternative
                                                    Routing-ID
                                                    Interpretation (ARI)<br=
>
                                                    <br>
                                                    0002:00:00.0 PCI
                                                    bridge: Freescale
                                                    Semiconductor Inc
                                                    Device 0824 (rev 11)
                                                    (prog-if 00 [Normal
                                                    decode])<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Device tree
                                                    node:
                                                    /sys/firmware/devicetre=
e/base/pcie@ffe260000/pcie@0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 22<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Bus:
                                                    primary=3D00,
                                                    secondary=3D01,
                                                    subordinate=3D01,
                                                    sec-latency=3D0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 I/O behind
                                                    bridge:
                                                    00000000-0000ffff
                                                    [size=3D64K]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory
                                                    behind bridge:
                                                    e0000000-efffffff
                                                    [size=3D256M]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Prefetchable
                                                    memory behind
                                                    bridge: None<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [44]
                                                    Power Management
                                                    version 3<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [4c]
                                                    Express Root Port
                                                    (Slot-), MSI 00<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [100]
                                                    Advanced Error
                                                    Reporting<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Kernel
                                                    driver in use:
                                                    pcieport<br>
                                                    <br>
                                                    0003:00:00.0 PCI
                                                    bridge: Freescale
                                                    Semiconductor Inc
                                                    Device 0824 (rev 11)
                                                    (prog-if 00 [Normal
                                                    decode])<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Device tree
                                                    node:
                                                    /sys/firmware/devicetre=
e/base/pcie@ffe270000/pcie@0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Flags: bus
                                                    master, fast devsel,
                                                    latency 0, IRQ 23<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory at
                                                    &lt;ignored&gt;
                                                    (32-bit,
                                                    non-prefetchable)<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Bus:
                                                    primary=3D00,
                                                    secondary=3D01,
                                                    subordinate=3D01,
                                                    sec-latency=3D0<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 I/O behind
                                                    bridge:
                                                    00000000-0000ffff
                                                    [size=3D64K]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Memory
                                                    behind bridge:
                                                    e0000000-efffffff
                                                    [size=3D256M]<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Prefetchable
                                                    memory behind
                                                    bridge: None<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [44]
                                                    Power Management
                                                    version 3<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [4c]
                                                    Express Root Port
                                                    (Slot-), MSI 00<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0
                                                    Capabilities: [100]
                                                    Advanced Error
                                                    Reporting<br>
                                                    =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Kernel
                                                    driver in use:
                                                    pcieport</div>
                                                  <div><br>
                                                  </div>
                                                </div>
                                                <div><b>AND This is PCIe
                                                    dmesg message when
                                                    memory range is
                                                    256MB. It&#39;s also
                                                    giving same message
                                                    when memory range is
                                                    arranged as 4GB;</b></d=
iv>
                                                <div><br>
                                                </div>
                                                <div>PCI host bridge
                                                  /pcie@ffe240000
                                                  =C2=A0ranges:<br>
                                                  =C2=A0MEM
                                                  0x0000000c00000000..0x000=
0000c0fffffff
                                                  -&gt;
                                                  0x00000000e0000000 <br>
                                                  =C2=A0 IO
                                                  0x0000000ff8000000..0x000=
0000ff800ffff
                                                  -&gt;
                                                  0x0000000000000000<br>
                                                  /pcie@ffe240000:
                                                  PCICSRBAR @ 0xff000000<br=
>
                                                  setup_pci_atmu: end of
                                                  DRAM 200000000<br>
                                                  /pcie@ffe240000: Setup
                                                  64-bit PCI DMA window<br>
                                                  /pcie@ffe240000:
                                                  WARNING: Outbound
                                                  window cfg leaves gaps
                                                  in memory map.
                                                  Adjusting the memory
                                                  map could reduce
                                                  unnecessary bounce
                                                  buffering.<br>
                                                  /pcie@ffe240000: DMA
                                                  window size is
                                                  0xe0000000<br>
                                                  Found FSL PCI host
                                                  bridge at
                                                  0x0000000ffe250000.
                                                  Firmware bus number:
                                                  0-&gt;1<br>
                                                  PCI host bridge
                                                  /pcie@ffe250000
                                                  =C2=A0ranges:<br>
                                                  =C2=A0MEM
                                                  0x0000000c10000000..0x000=
0000c1fffffff
                                                  -&gt;
                                                  0x00000000e0000000 <br>
                                                  =C2=A0 IO
                                                  0x0000000ff8010000..0x000=
0000ff801ffff
                                                  -&gt;
                                                  0x0000000000000000<br>
                                                  /pcie@ffe250000:
                                                  PCICSRBAR @ 0xff000000<br=
>
                                                  setup_pci_atmu: end of
                                                  DRAM 200000000<br>
                                                  /pcie@ffe250000: Setup
                                                  64-bit PCI DMA window<br>
                                                  /pcie@ffe250000:
                                                  WARNING: Outbound
                                                  window cfg leaves gaps
                                                  in memory map.
                                                  Adjusting the memory
                                                  map could reduce
                                                  unnecessary bounce
                                                  buffering.<br>
                                                  /pcie@ffe250000: DMA
                                                  window size is
                                                  0xe0000000<br>
                                                  Found FSL PCI host
                                                  bridge at
                                                  0x0000000ffe260000.
                                                  Firmware bus number:
                                                  0-&gt;0<br>
                                                  PCI host bridge
                                                  /pcie@ffe260000
                                                  =C2=A0ranges:<br>
                                                  =C2=A0MEM
                                                  0x0000000c20000000..0x000=
0000c2fffffff
                                                  -&gt;
                                                  0x00000000e0000000 <br>
                                                  =C2=A0 IO
                                                  0x0000000ff8020000..0x000=
0000ff802ffff
                                                  -&gt;
                                                  0x0000000000000000<br>
                                                  /pcie@ffe260000:
                                                  PCICSRBAR @ 0xff000000<br=
>
                                                  setup_pci_atmu: end of
                                                  DRAM 200000000<br>
                                                  /pcie@ffe260000: Setup
                                                  64-bit PCI DMA window<br>
                                                  /pcie@ffe260000:
                                                  WARNING: Outbound
                                                  window cfg leaves gaps
                                                  in memory map.
                                                  Adjusting the memory
                                                  map could reduce
                                                  unnecessary bounce
                                                  buffering.<br>
                                                  /pcie@ffe260000: DMA
                                                  window size is
                                                  0xe0000000<br>
                                                  Found FSL PCI host
                                                  bridge at
                                                  0x0000000ffe270000.
                                                  Firmware bus number:
                                                  0-&gt;0<br>
                                                  PCI host bridge
                                                  /pcie@ffe270000
                                                  =C2=A0ranges:<br>
                                                  =C2=A0MEM
                                                  0x0000000c30000000..0x000=
0000c3fffffff
                                                  -&gt;
                                                  0x00000000e0000000 <br>
                                                  =C2=A0 IO
                                                  0x0000000ff8030000..0x000=
0000ff803ffff
                                                  -&gt;
                                                  0x0000000000000000<br>
                                                  /pcie@ffe270000:
                                                  PCICSRBAR @ 0xff000000<br=
>
                                                  setup_pci_atmu: end of
                                                  DRAM 200000000<br>
                                                  /pcie@ffe270000: Setup
                                                  64-bit PCI DMA window<br>
                                                  /pcie@ffe270000:
                                                  WARNING: Outbound
                                                  window cfg leaves gaps
                                                  in memory map.
                                                  Adjusting the memory
                                                  map could reduce
                                                  unnecessary bounce
                                                  buffering.<br>
                                                  /pcie@ffe270000: DMA
                                                  window size is
                                                  0xe0000000<br>
                                                  iommu: Adding device
                                                  ff6000000.qman-portal
                                                  to group 0<br>
                                                  iommu: Adding device
                                                  ff6004000.qman-portal
                                                  to group 1<br>
                                                  iommu: Adding device
                                                  ff6008000.qman-portal
                                                  to group 2<br>
                                                  iommu: Adding device
                                                  ff600c000.qman-portal
                                                  to group 3<br>
                                                  iommu: Adding device
                                                  ff6010000.qman-portal
                                                  to group 4<br>
                                                  iommu: Adding device
                                                  ff6014000.qman-portal
                                                  to group 5<br>
                                                  iommu: Adding device
                                                  ff6018000.qman-portal
                                                  to group 6<br>
                                                  iommu: Adding device
                                                  ff601c000.qman-portal
                                                  to group 7<br>
                                                  iommu: Adding device
                                                  ff6020000.qman-portal
                                                  to group 8<br>
                                                  iommu: Adding device
                                                  ff6024000.qman-portal
                                                  to group 9<br>
                                                  iommu: Adding device
                                                  ffe100300.dma to group
                                                  10<br>
                                                  iommu: Adding device
                                                  ffe101300.dma to group
                                                  11<br>
                                                  iommu: Adding device
                                                  ffe114000.sdhc to
                                                  group 12<br>
                                                  iommu: Adding device
                                                  ffe210000.usb to group
                                                  13<br>
                                                  iommu: Adding device
                                                  ffe211000.usb to group
                                                  14<br>
                                                  iommu: Adding device
                                                  ffe220000.sata to
                                                  group 15<br>
                                                  iommu: Adding device
                                                  ffe221000.sata to
                                                  group 16<br>
                                                  iommu: Adding device
                                                  ffe318000.qman to
                                                  group 17<br>
                                                  iommu: Adding device
                                                  ffe31a000.bman to
                                                  group 18<br>
                                                  iommu: Adding device
                                                  ffe240000.pcie to
                                                  group 19<br>
                                                  iommu: Adding device
                                                  ffe250000.pcie to
                                                  group 20<br>
                                                  iommu: Adding device
                                                  ffe260000.pcie to
                                                  group 21<br>
                                                  iommu: Adding device
                                                  ffe270000.pcie to
                                                  group 22<br>
                                                  iommu: Adding device
                                                  ffe140000.qe to group
                                                  23<br>
                                                  software IO TLB:
                                                  mapped [mem
                                                  0xfbfff000-0xfffff000]
                                                  (64MB)<br>
                                                  PCI: Probing PCI
                                                  hardware<br>
                                                  fsl-pci
                                                  ffe240000.pcie: PCI
                                                  host bridge to bus
                                                  0000:00<br>
                                                  pci_bus 0000:00: root
                                                  bus resource [io
                                                  =C2=A00x8000080000010000-=
0x800008000001ffff]
                                                  (bus address
                                                  [0x0000-0xffff])<br>
                                                  pci_bus 0000:00: root
                                                  bus resource [mem
                                                  0xc00000000-0xc0fffffff]
                                                  (bus address
                                                  [0xe0000000-0xefffffff])<=
br>
                                                  pci_bus 0000:00: root
                                                  bus resource [bus 00]<br>
                                                  iommu: Removing device
                                                  ffe240000.pcie from
                                                  group 19<br>
                                                  iommu: Adding device
                                                  0000:00:00.0 to group
                                                  24<br>
                                                  pci 0000:00:00.0:
                                                  bridge configuration
                                                  invalid ([bus 00-00]),
                                                  reconfiguring<br>
                                                  pci 0000:00:00.0: PCI
                                                  bridge to [bus 01-ff]<br>
                                                  fsl-pci
                                                  ffe250000.pcie: PCI
                                                  host bridge to bus
                                                  0001:00<br>
                                                  pci_bus 0001:00: root
                                                  bus resource [io
                                                  =C2=A00x8000080000021000-=
0x8000080000030fff]
                                                  (bus address
                                                  [0x0000-0xffff])<br>
                                                  pci_bus 0001:00: root
                                                  bus resource [mem
                                                  0xc10000000-0xc1fffffff]
                                                  (bus address
                                                  [0xe0000000-0xefffffff])<=
br>
                                                  pci_bus 0001:00: root
                                                  bus resource [bus
                                                  00-01]<br>
                                                  iommu: Removing device
                                                  ffe250000.pcie from
                                                  group 20<br>
                                                  iommu: Adding device
                                                  0001:00:00.0 to group
                                                  19<br>
                                                  pci 0001:01:00.0:
                                                  enabling Extended Tags<br=
>
                                                  pci 0001:01:00.0:
                                                  4.000 Gb/s available
                                                  PCIe bandwidth,
                                                  limited by 5 GT/s x1
                                                  link at 0001:00:00.0
                                                  (capable of 63.008
                                                  Gb/s with 8 GT/s x8
                                                  link)<br>
                                                  iommu: Adding device
                                                  0001:01:00.0 to group
                                                  19<br>
                                                  pci 0001:01:00.1:
                                                  enabling Extended Tags<br=
>
                                                  iommu: Adding device
                                                  0001:01:00.1 to group
                                                  19<br>
                                                  pci 0001:00:00.0: PCI
                                                  bridge to [bus 01-ff]<br>
                                                  fsl-pci
                                                  ffe260000.pcie: PCI
                                                  host bridge to bus
                                                  0002:00<br>
                                                  pci_bus 0002:00: root
                                                  bus resource [io
                                                  =C2=A00x8000080000032000-=
0x8000080000041fff]
                                                  (bus address
                                                  [0x0000-0xffff])<br>
                                                  pci_bus 0002:00: root
                                                  bus resource [mem
                                                  0xc20000000-0xc2fffffff]
                                                  (bus address
                                                  [0xe0000000-0xefffffff])<=
br>
                                                  pci_bus 0002:00: root
                                                  bus resource [bus 00]<br>
                                                  iommu: Removing device
                                                  ffe260000.pcie from
                                                  group 21<br>
                                                  iommu: Adding device
                                                  0002:00:00.0 to group
                                                  20<br>
                                                  pci 0002:00:00.0:
                                                  bridge configuration
                                                  invalid ([bus 00-00]),
                                                  reconfiguring<br>
                                                  pci 0002:00:00.0: PCI
                                                  bridge to [bus 01-ff]<br>
                                                  fsl-pci
                                                  ffe270000.pcie: PCI
                                                  host bridge to bus
                                                  0003:00<br>
                                                  pci_bus 0003:00: root
                                                  bus resource [io
                                                  =C2=A00x8000080000043000-=
0x8000080000052fff]
                                                  (bus address
                                                  [0x0000-0xffff])<br>
                                                  pci_bus 0003:00: root
                                                  bus resource [mem
                                                  0xc30000000-0xc3fffffff]
                                                  (bus address
                                                  [0xe0000000-0xefffffff])<=
br>
                                                  pci_bus 0003:00: root
                                                  bus resource [bus 00]<br>
                                                  iommu: Removing device
                                                  ffe270000.pcie from
                                                  group 22<br>
                                                  iommu: Adding device
                                                  0003:00:00.0 to group
                                                  21<br>
                                                  pci 0003:00:00.0:
                                                  bridge configuration
                                                  invalid ([bus 00-00]),
                                                  reconfiguring<br>
                                                  pci 0003:00:00.0: PCI
                                                  bridge to [bus 01-ff]<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0000:00:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0001:00:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 2 of
                                                  device 0001:01:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 5 of
                                                  device 0001:01:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 6 of
                                                  device 0001:01:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0001:01:00.1,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0002:00:00.0,
                                                  will remap<br>
                                                  PCI: Cannot allocate
                                                  resource region 0 of
                                                  device 0003:00:00.0,
                                                  will remap<br>
                                                  pci 0000:00:00.0: BAR
                                                  0: no space for [mem
                                                  size 0x01000000]<br>
                                                  pci 0000:00:00.0: BAR
                                                  0: failed to assign
                                                  [mem size 0x01000000]<br>
                                                  pci 0000:00:00.0: PCI
                                                  bridge to [bus 01]<br>
                                                  pci 0000:00:00.0: =C2=A0
                                                  bridge window [io
                                                  =C2=A00x8000080000010000-=
0x800008000001ffff]<br>
                                                  pci 0000:00:00.0: =C2=A0
                                                  bridge window [mem
                                                  0xc00000000-0xc0fffffff]<=
br>
                                                  pci_bus 0000:00: Some
                                                  PCI device resources
                                                  are unassigned, try
                                                  booting with
                                                  pci=3Drealloc<br>
                                                  pci 0001:00:00.0: BAR
                                                  0: no space for [mem
                                                  size 0x01000000]<br>
                                                  pci 0001:00:00.0: BAR
                                                  0: failed to assign
                                                  [mem size 0x01000000]<br>
                                                  pci 0001:00:00.0: BAR
                                                  9: no space for [mem
                                                  size 0x00200000 64bit
                                                  pref]<br>
                                                  pci 0001:00:00.0: BAR
                                                  9: failed to assign
                                                  [mem size 0x00200000
                                                  64bit pref]<br>
                                                  pci 0001:01:00.0: BAR
                                                  2: no space for [mem
                                                  size 0x00200000 64bit
                                                  pref]<br>
                                                  pci 0001:01:00.0: BAR
                                                  2: failed to assign
                                                  [mem size 0x00200000
                                                  64bit pref]<br>
                                                  pci 0001:01:00.0: BAR
                                                  5: no space for [mem
                                                  size 0x00040000]<br>
                                                  pci 0001:01:00.0: BAR
                                                  5: failed to assign
                                                  [mem size 0x00040000]<br>
                                                  pci 0001:01:00.0: BAR
                                                  6: no space for [mem
                                                  size 0x00020000 pref]<br>
                                                  pci 0001:01:00.0: BAR
                                                  6: failed to assign
                                                  [mem size 0x00020000
                                                  pref]<br>
                                                  pci 0001:01:00.1: BAR
                                                  0: no space for [mem
                                                  size 0x00004000 64bit]<br=
>
                                                  pci 0001:01:00.1: BAR
                                                  0: failed to assign
                                                  [mem size 0x00004000
                                                  64bit]<br>
                                                  pci 0001:00:00.0: PCI
                                                  bridge to [bus 01]<br>
                                                  pci 0001:00:00.0: =C2=A0
                                                  bridge window [io
                                                  =C2=A00x8000080000021000-=
0x8000080000030fff]<br>
                                                  pci 0001:00:00.0: =C2=A0
                                                  bridge window [mem
                                                  0xc10000000-0xc1fffffff]<=
br>
                                                  pci_bus 0001:00: Some
                                                  PCI device resources
                                                  are unassigned, try
                                                  booting with
                                                  pci=3Drealloc<br>
                                                  pci 0002:00:00.0: BAR
                                                  0: no space for [mem
                                                  size 0x01000000]<br>
                                                  pci 0002:00:00.0: BAR
                                                  0: failed to assign
                                                  [mem size 0x01000000]<br>
                                                  pci 0002:00:00.0: PCI
                                                  bridge to [bus 01]<br>
                                                  pci 0002:00:00.0: =C2=A0
                                                  bridge window [io
                                                  =C2=A00x8000080000032000-=
0x8000080000041fff]<br>
                                                  pci 0002:00:00.0: =C2=A0
                                                  bridge window [mem
                                                  0xc20000000-0xc2fffffff]<=
br>
                                                  pci_bus 0002:00: Some
                                                  PCI device resources
                                                  are unassigned, try
                                                  booting with
                                                  pci=3Drealloc<br>
                                                  pci 0003:00:00.0: BAR
                                                  0: no space for [mem
                                                  size 0x01000000]<br>
                                                  pci 0003:00:00.0: BAR
                                                  0: failed to assign
                                                  [mem size 0x01000000]<br>
                                                  pci 0003:00:00.0: PCI
                                                  bridge to [bus 01]<br>
                                                  pci 0003:00:00.0: =C2=A0
                                                  bridge window [io
                                                  =C2=A00x8000080000043000-=
0x8000080000052fff]<br>
                                                  pci 0003:00:00.0: =C2=A0
                                                  bridge window [mem
                                                  0xc30000000-0xc3fffffff]<=
br>
                                                  pci_bus 0003:00: Some
                                                  PCI device resources
                                                  are unassigned, try
                                                  booting with
                                                  pci=3Drealloc<br>
                                                </div>
                                                <div><br>
                                                </div>
                                                <div><br>
                                                </div>
                                              </div>
                                            </div>
                                          </blockquote>
                                          <br>
                                        </div>
                                      </blockquote>
                                    </div>
                                  </div>
                                  <br>
                                  <fieldset></fieldset>
                                  <pre>____________________________________=
___________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Cchristian.koenig%40amd.com%7C561d9d3206ff46d338ad08d777ef717c%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637109742603345420&amp;sdata=3DPO02mQtDB=
nkAdNfCn%2Fp7QmKX8IbJ7zke8edrfhsM6Mg%3D&amp;reserved=3D0" target=3D"_blank"=
>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
                                </blockquote>
                                <br>
                              </div>
                            </blockquote>
                          </div>
                        </div>
                      </blockquote>
                    </div>
                  </div>
                </blockquote>
                <br>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div></div>
</blockquote></div>

--00000000000088ab02059b242897--

--===============1660137890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1660137890==--
