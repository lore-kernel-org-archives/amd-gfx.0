Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTTPS_HTTP_MISMATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B774BC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 14:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDAE20833
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 14:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDAE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173AB6E1F6;
	Mon,  2 Dec 2019 14:20:40 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A9D6E1F6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 14:20:38 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id g206so22073299wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Dec 2019 06:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WZAwQzStkVeuEGBsxeuKxpvC4svfnCjsLrdX40vqvzk=;
 b=uWJZMPoS3uBIhf+eV+vzf+u+yH7SFbmAy7wk1+7DYsIKRluSJHmUt+dDGnA+so07ns
 wfsq5VwKKwB5PUK2qfxJI9Al2w0BiO/A7CDOGQIlToodb0ibDgJxBF0KJh2VN3/FqMG4
 UZaRrVrP+Gfe6TykNH1M4ceQfg8uJuQdqFAUjMFxSEWr5vHI0FP4jmGNoRUYvyECuWqc
 EPDSXxYRZlo8f0/s6mg22eYRe2DDjak/DNi/iaD1byVMqBL+/390vjKwBT+bHwmb3NYh
 wlmIB+Se4oT1X4wR3wr2pGYeDS/0AbQseYQ68gWRzROelA9uiQ2Rk9Lr20giif6xDc0s
 3Nuw==
X-Gm-Message-State: APjAAAV+nDR0WbCiOqnHgcefxBFBNjCXXX4809+XCv/awoRyKavh2w/X
 4IGo8K8cv1ZQCDYDepPUnlpZEFkO/4OZCmNXoDg=
X-Google-Smtp-Source: APXvYqxt3tjvZ6akDajbK5O0mf+CQ9VKvja3x9bi/Lyo9qmKejwyQQJxM1iJGo1lcmau0M2rmn+iOjzd4PxSaKhmQv8=
X-Received: by 2002:a1c:7910:: with SMTP id l16mr8963439wme.27.1575296437315; 
 Mon, 02 Dec 2019 06:20:37 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjxGE5p3AVQf=dm4ubBrKgbTagr4QrUJo=bPmueNSyjecw@mail.gmail.com>
 <1b8f92ae-6faa-49a4-8b38-6bccec006b68@gmail.com>
 <CAGzVRjyz7P3uiCgyFX=zZ4xzKwN+X2i8y7oabNkLBU4CnRpBmw@mail.gmail.com>
 <ec0b6313-1a5a-8195-84da-ee549f82f142@amd.com>
In-Reply-To: <ec0b6313-1a5a-8195-84da-ee549f82f142@amd.com>
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Mon, 2 Dec 2019 17:20:25 +0300
Message-ID: <CAGzVRjzELaG_CToBxUWzh+kadp3qUQY6RQSGHMO1W1eSs+d-_w@mail.gmail.com>
Subject: Re: [error] Drm -> amdgpu Unrecoverable Machine Check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=WZAwQzStkVeuEGBsxeuKxpvC4svfnCjsLrdX40vqvzk=;
 b=eQizgMBEgECy3BpnFYLZhXz82TPLVa4DYaDhvvbX9mwUdo0zIe+pbEBSVK6DnOWOmW
 VdXO2RdJyQfamnuTR4zzMtefmbnLnQ4V7XGDA9sBbk9vR3p/vQjJM1QFAgAKeLhIhHbg
 JpIDcJVd1lRPTx+5w+BAWqSPuWKSkx0t9TNxtePUY4u8fI7sXqe0EZnvU/A1Px52XgQK
 buBCaGp6tAPwCBiJLyz7PobJhB1j769UVOX0YAdhMGheSYE4PHOTnvcMdafrzbDMN94o
 GzWYfaq3xPfjJl5bWRUDQj5JvChIl2CQSfrzdmeeGRVbx2uOaqef7a7ro6zwkwBxARlv
 CxKQ==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Content-Type: multipart/mixed; boundary="===============1620372281=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1620372281==
Content-Type: multipart/alternative; boundary="0000000000008fed960598b948fc"

--0000000000008fed960598b948fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> That is an expected result. 256MB is not enough for the VRAM BAR and the
> doorbell BAR to fit into. But you can still use VGA emulation that way if
> I'm not completely mistaken.
>

Hmm, then what procedure should I follow to take a VGA output. It seems
Graphic Card does not have a VGA output. And isn't there any way to use
this GPU with a 256MB buffered PCIe?



> Then I canged 256 MB to 4GB in .dtsi and U-boot conf file.
>
> How did you do this? Is your memory layout consistent?
>
> See when you just changed one end address you might need to adjust other
> addresses as well.
>
> Regards,
> Christian.
>

It's not consistent I seems. At first I changed .dtsi like it's consistent.
I only changed PCIe1 Device Memory and I/O range. It gave same error. Then
I also changed PCIe2 and PCIe3 devices starting adress according to PCIe1
device end adress in .dtsi. I am not sure I made this correctly or not but
it gave same result again. This is why I asked "If it is, is there any
sample PCIe configuration for E9171?".


*This is a code piece from my T104xRDB.h file which is contain PCIe
configuration variables for U-boot. I made changes like it's not
consistent. RAM size is 8 GB.*

#ifdef CONFIG_PCI
/* controller 1, direct to uli, tgtid 3, Base address 20000 */
#ifdef CONFIG_PCIE1
#define CONFIG_SYS_PCIE1_MEM_VIRT *0x80000000*
#define CONFIG_SYS_PCIE1_MEM_BUS 0xe0000000
#define CONFIG_SYS_PCIE1_MEM_PHYS 0xc00000000ull
#define CONFIG_SYS_PCIE1_MEM_SIZE *0x10000000 /* 256M */*
#define CONFIG_SYS_PCIE1_IO_VIRT 0xf8000000
#define CONFIG_SYS_PCIE1_IO_BUS 0x00000000
#define CONFIG_SYS_PCIE1_IO_PHYS *0xff8000000ull*
#define CONFIG_SYS_PCIE1_IO_SIZE *0x00010000 /* 64k */*
#endif

/* controller 2, Slot 2, tgtid 2, Base address 201000 */
#ifdef CONFIG_PCIE2
#define CONFIG_SYS_PCIE2_MEM_VIRT *0x90000000*
#define CONFIG_SYS_PCIE2_MEM_BUS 0xe0000000
#define CONFIG_SYS_PCIE2_MEM_PHYS 0xc10000000ull
#define CONFIG_SYS_PCIE2_MEM_SIZE* 0x100000000 /* 4GB */*
#define CONFIG_SYS_PCIE2_IO_VIRT 0xf8010000
#define CONFIG_SYS_PCIE2_IO_BUS 0x00000000
#define CONFIG_SYS_PCIE2_IO_PHYS 0xff8010000ull
#define CONFIG_SYS_PCIE2_IO_SIZE *0x00100000 /* 1M */*
#endif

/* controller 3, Slot 1, tgtid 1, Base address 202000 */
#ifdef CONFIG_PCIE3
#define CONFIG_SYS_PCIE3_MEM_VIRT *0x190000000 /* I changed this to
0x190000000 instead of 0xa0000000 because PCIE2 end adress is changed. End
adress is to 4 GB (0x100000000 hex so I added 0x90000000 with 100000000) */=
*
#define CONFIG_SYS_PCIE3_MEM_BUS 0xe0000000
#define CONFIG_SYS_PCIE3_MEM_PHYS 0xd10000000ull
#define CONFIG_SYS_PCIE3_MEM_SIZE 0x10000000 /* 256M */
#define CONFIG_SYS_PCIE3_IO_VIRT 0xf8110000
#define CONFIG_SYS_PCIE3_IO_BUS 0x00000000
#define CONFIG_SYS_PCIE3_IO_PHYS *0xff8110000ull /* Did same things for IO =
*
#define CONFIG_SYS_PCIE3_IO_SIZE 0x00010000 /* 64k */
#endif

/* controller 4, Base address 203000 */
#ifdef CONFIG_PCIE4
#define CONFIG_SYS_PCIE4_MEM_VIRT *0x200000000 /* SAME STEP WITH PCIE3.
This time I added with 256 MB (0x10000000) */*
#define CONFIG_SYS_PCIE4_MEM_BUS 0xe0000000
#define CONFIG_SYS_PCIE4_MEM_PHYS 0xd20000000ull
#define CONFIG_SYS_PCIE4_MEM_SIZE 0x10000000 /* 256M */
#define CONFIG_SYS_PCIE4_IO_VIRT 0xf8120000
#define CONFIG_SYS_PCIE4_IO_BUS 0x00000000
#define CONFIG_SYS_PCIE4_IO_PHYS *0xff8120000ull /* Did same things for IO =
*
#define CONFIG_SYS_PCIE4_IO_SIZE 0x00010000 /* 64k */
#endif




Am 02.12.19 um 14:32 schrieb Yusuf Alt=C4=B1parmak:
>
>
>> I attached my dts file.
>>
>> System is working fine when GPU is not plugged in.
>>
>> *This is the last console log before freeze:*
>> [drm] amdgpu kernel modesetting enabled.
>>
>> [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987
>> 0x1787:0x2389 0x80).
>> [drm] register mmio base: 0x20200000
>>
>> fsl-fman-port ffe488000.port fm1-gb0: renamed from eth0
>>
>> [drm] register mmio size: 262144
>>
>> [drm] add ip block number 0 <vi_common>
>>
>> [drm] add ip block number 1 <gmc_v8_0>
>>
>> [drm] add ip block number 2 <tonga_ih>
>>
>> [drm] add ip block number 3 <powerplay>
>>
>> [drm] add ip block number 4 <dm>
>>
>> [drm] add ip block number 5 <gfx_v8_0>
>>
>> [drm] add ip block number 6 <sdma_v3_0>
>>
>> [drm] add ip block number 7 <uvd_v6_0>
>>
>> [drm] add ip block number 8 <vce_v3_0>
>>
>> [drm] UVD is enabled in VM mode
>>
>> [drm] UVD ENC is enabled in VM mode
>>
>> [drm] VCE enabled in VM mode
>>
>> ATOM BIOS: 113-ER16BFC-001
>>
>> [drm] GPU posting now...
>>
>> Disabling lock debugging due to kernel taint
>>
>> Machine check in kernel mode.
>>
>> Caused by (from MCSR=3Da000): Load Error Report
>>
>> Guarded Load Error Report
>>
>> Kernel panic - not syncing: Unrecoverable Machine check
>>
>> CPU: 1 PID: 2023 Comm: udevd Tainted: G   M              4.19.26+gc0c214=
1
>> #1
>> Call Trace:
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing listamd-gfx@lists.freedesktop.orghttps://lists.freedeskt=
op.org/mailman/listinfo/amd-gfx <https://nam11.safelinks.protection.outlook=
.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-=
gfx&data=3D02%7C01%7Cchristian.koenig%40amd.com%7C9be244504efb4ff9cc0a08d77=
72c1630%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637108903547899069&sda=
ta=3DOL4UKczXinKq5FM3Cid5kYcESkHAl0esXfOB83AUPU8%3D&reserved=3D0>
>>
>>
>>
>
> Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>, 2 Ara 2019 Pzt, =
15:28
> tarihinde =C5=9Funu yazd=C4=B1:
>
>> Hi Yusuf,
>>
>> Am 02.12.19 um 12:41 schrieb Yusuf Alt=C4=B1parmak:
>>
>> My embedded board is freezing when I put E9171 on PCIe. What is the
>> meaning of Unrecoverable Machine Check error about GPU?
>>
>>
>> Well see the explanation on Wikipedia for example:
>> https://en.wikipedia.org/wiki/Machine-check_exception
>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fen.=
wikipedia.org%2Fwiki%2FMachine-check_exception&data=3D02%7C01%7Cchristian.k=
oenig%40amd.com%7C9be244504efb4ff9cc0a08d7772c1630%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637108903547909070&sdata=3DmBxI9LnRBO4iu5oyHc9OrrFj0K1=
0SiOf5%2FztzmNedaI%3D&reserved=3D0>
>>
>> In general it means you have messed up something in your hardware
>> configuration.
>>
>> Could PCIe settings in .dts file cause this problem?
>>
>>
>> Possible, but rather unlikely. My best guess is that it is some problem
>> with the power supply.
>>
>> If it is, is there any sample PCIe configuration for E9171?
>>
>>
>> The E9171 is just a PCIe device, so the dtsi is actually rather
>> uninteresting. What we really need is a full dmesg and maybe lspci outpu=
t
>> would help as well.
>>
>> Regards,
>> Christian.
>>
>
>
> Hi Christian,
>
> At first, I am using NXP T1042D4RDB-64B which has 256 MB PCIe buffer
> according to its. PCIe memory range was arranged to 256 MB in .dts file a=
nd
> in U-boot configuration file. Driver was giving error with exit code -12
> (OUT_OF_MEMORY). But I was able to reach the linux console.
>
> [    5.512922] [drm] amdgpu kernel modesetting enabled.
> [    5.517065] [drm] initializing kernel modesetting (POLARIS12
> 0x1002:0x6987 0x1787:0x2389 0x80).
> [    5.524507] amdgpu 0001:01:00.0: Fatal error during GPU init
> [    5.529296] amdgpu: probe of 0001:01:00.0 failed with error -12
>
> Then I canged 256 MB to 4GB in .dtsi and U-boot conf file. I also changed
> 64KB I/O size to 1MB . When I do this, I wasn't able to reach the linux
> console because board was freezing. But driver was successfull at this
> time. I already mentioned successfull driver console logs up.
>
> *this is lspci -v when GPU is plugged and Memory size is 256 MB.*
>
> root@t1042d4rdb-64b:~# lspci -v
> 0000:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0824 (rev 11)
> (prog-if 00 [Normal decode])
>         Device tree node: /sys/firmware/devicetree/base/pcie@ffe240000
> /pcie@0
>         Flags: bus master, fast devsel, latency 0, IRQ 20
>         Memory at <ignored> (32-bit, non-prefetchable)
>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>         I/O behind bridge: 00000000-0000ffff [size=3D64K]
>         Memory behind bridge: e0000000-efffffff [size=3D256M]
>         Prefetchable memory behind bridge: None
>         Capabilities: [44] Power Management version 3
>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Kernel driver in use: pcieport
>
> 0001:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0824 (rev 11)
> (prog-if 00 [Normal decode])
>         Device tree node: /sys/firmware/devicetree/base/pcie@ffe250000
> /pcie@0
>         Flags: bus master, fast devsel, latency 0, IRQ 21
>         Memory at <ignored> (32-bit, non-prefetchable)
>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>         I/O behind bridge: 00000000-0000ffff [size=3D64K]
>         Memory behind bridge: e0000000-efffffff [size=3D256M]
>         Prefetchable memory behind bridge: None
>         Capabilities: [44] Power Management version 3
>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Kernel driver in use: pcieport
>
> 0001:01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Lexa [Radeon E9171 MCM] (rev 80) (prog-if 00 [VGA controller])
>         Subsystem: Hightech Information System Ltd. Device 2389
>         Flags: fast devsel, IRQ 41
>         Memory at c10000000 (64-bit, prefetchable) [size=3D256M]
>         Memory at <ignored> (64-bit, prefetchable)
>         I/O ports at 1100 [size=3D256]
>         Memory at <ignored> (32-bit, non-prefetchable)
>         Expansion ROM at <ignored> [disabled]
>         Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Legacy Endpoint, MSI 00
>         Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>         Capabilities: [100] Vendor Specific Information: ID=3D0001 Rev=3D=
1
> Len=3D010 <?>
>         Capabilities: [150] Advanced Error Reporting
>         Capabilities: [200] Resizable BAR <?>
>         Capabilities: [270] Secondary PCI Express <?>
>         Capabilities: [2b0] Address Translation Service (ATS)
>         Capabilities: [2c0] Page Request Interface (PRI)
>         Capabilities: [2d0] Process Address Space ID (PASID)
>         Capabilities: [320] Latency Tolerance Reporting
>         Capabilities: [328] Alternative Routing-ID Interpretation (ARI)
>         Capabilities: [370] L1 PM Substates
>         Kernel modules: amdgpu
>
> 0001:01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device
> aae0
>         Subsystem: Hightech Information System Ltd. Device aae0
>         Flags: bus master, fast devsel, latency 0, IRQ 17
>         Memory at <ignored> (64-bit, non-prefetchable)
>         Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Legacy Endpoint, MSI 00
>         Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>         Capabilities: [100] Vendor Specific Information: ID=3D0001 Rev=3D=
1
> Len=3D010 <?>
>         Capabilities: [150] Advanced Error Reporting
>         Capabilities: [328] Alternative Routing-ID Interpretation (ARI)
>
> 0002:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0824 (rev 11)
> (prog-if 00 [Normal decode])
>         Device tree node: /sys/firmware/devicetree/base/pcie@ffe260000
> /pcie@0
>         Flags: bus master, fast devsel, latency 0, IRQ 22
>         Memory at <ignored> (32-bit, non-prefetchable)
>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>         I/O behind bridge: 00000000-0000ffff [size=3D64K]
>         Memory behind bridge: e0000000-efffffff [size=3D256M]
>         Prefetchable memory behind bridge: None
>         Capabilities: [44] Power Management version 3
>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Kernel driver in use: pcieport
>
> 0003:00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0824 (rev 11)
> (prog-if 00 [Normal decode])
>         Device tree node: /sys/firmware/devicetree/base/pcie@ffe270000
> /pcie@0
>         Flags: bus master, fast devsel, latency 0, IRQ 23
>         Memory at <ignored> (32-bit, non-prefetchable)
>         Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=
=3D0
>         I/O behind bridge: 00000000-0000ffff [size=3D64K]
>         Memory behind bridge: e0000000-efffffff [size=3D256M]
>         Prefetchable memory behind bridge: None
>         Capabilities: [44] Power Management version 3
>         Capabilities: [4c] Express Root Port (Slot-), MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Kernel driver in use: pcieport
>
> *AND This is PCIe dmesg message when memory range is 256MB. It's also
> giving same message when memory range is arranged as 4GB;*
>
> PCI host bridge /pcie@ffe240000  ranges:
>  MEM 0x0000000c00000000..0x0000000c0fffffff -> 0x00000000e0000000
>   IO 0x0000000ff8000000..0x0000000ff800ffff -> 0x0000000000000000
> /pcie@ffe240000: PCICSRBAR @ 0xff000000
> setup_pci_atmu: end of DRAM 200000000
> /pcie@ffe240000: Setup 64-bit PCI DMA window
> /pcie@ffe240000: WARNING: Outbound window cfg leaves gaps in memory map.
> Adjusting the memory map could reduce unnecessary bounce buffering.
> /pcie@ffe240000: DMA window size is 0xe0000000
> Found FSL PCI host bridge at 0x0000000ffe250000. Firmware bus number: 0->=
1
> PCI host bridge /pcie@ffe250000  ranges:
>  MEM 0x0000000c10000000..0x0000000c1fffffff -> 0x00000000e0000000
>   IO 0x0000000ff8010000..0x0000000ff801ffff -> 0x0000000000000000
> /pcie@ffe250000: PCICSRBAR @ 0xff000000
> setup_pci_atmu: end of DRAM 200000000
> /pcie@ffe250000: Setup 64-bit PCI DMA window
> /pcie@ffe250000: WARNING: Outbound window cfg leaves gaps in memory map.
> Adjusting the memory map could reduce unnecessary bounce buffering.
> /pcie@ffe250000: DMA window size is 0xe0000000
> Found FSL PCI host bridge at 0x0000000ffe260000. Firmware bus number: 0->=
0
> PCI host bridge /pcie@ffe260000  ranges:
>  MEM 0x0000000c20000000..0x0000000c2fffffff -> 0x00000000e0000000
>   IO 0x0000000ff8020000..0x0000000ff802ffff -> 0x0000000000000000
> /pcie@ffe260000: PCICSRBAR @ 0xff000000
> setup_pci_atmu: end of DRAM 200000000
> /pcie@ffe260000: Setup 64-bit PCI DMA window
> /pcie@ffe260000: WARNING: Outbound window cfg leaves gaps in memory map.
> Adjusting the memory map could reduce unnecessary bounce buffering.
> /pcie@ffe260000: DMA window size is 0xe0000000
> Found FSL PCI host bridge at 0x0000000ffe270000. Firmware bus number: 0->=
0
> PCI host bridge /pcie@ffe270000  ranges:
>  MEM 0x0000000c30000000..0x0000000c3fffffff -> 0x00000000e0000000
>   IO 0x0000000ff8030000..0x0000000ff803ffff -> 0x0000000000000000
> /pcie@ffe270000: PCICSRBAR @ 0xff000000
> setup_pci_atmu: end of DRAM 200000000
> /pcie@ffe270000: Setup 64-bit PCI DMA window
> /pcie@ffe270000: WARNING: Outbound window cfg leaves gaps in memory map.
> Adjusting the memory map could reduce unnecessary bounce buffering.
> /pcie@ffe270000: DMA window size is 0xe0000000
> iommu: Adding device ff6000000.qman-portal to group 0
> iommu: Adding device ff6004000.qman-portal to group 1
> iommu: Adding device ff6008000.qman-portal to group 2
> iommu: Adding device ff600c000.qman-portal to group 3
> iommu: Adding device ff6010000.qman-portal to group 4
> iommu: Adding device ff6014000.qman-portal to group 5
> iommu: Adding device ff6018000.qman-portal to group 6
> iommu: Adding device ff601c000.qman-portal to group 7
> iommu: Adding device ff6020000.qman-portal to group 8
> iommu: Adding device ff6024000.qman-portal to group 9
> iommu: Adding device ffe100300.dma to group 10
> iommu: Adding device ffe101300.dma to group 11
> iommu: Adding device ffe114000.sdhc to group 12
> iommu: Adding device ffe210000.usb to group 13
> iommu: Adding device ffe211000.usb to group 14
> iommu: Adding device ffe220000.sata to group 15
> iommu: Adding device ffe221000.sata to group 16
> iommu: Adding device ffe318000.qman to group 17
> iommu: Adding device ffe31a000.bman to group 18
> iommu: Adding device ffe240000.pcie to group 19
> iommu: Adding device ffe250000.pcie to group 20
> iommu: Adding device ffe260000.pcie to group 21
> iommu: Adding device ffe270000.pcie to group 22
> iommu: Adding device ffe140000.qe to group 23
> software IO TLB: mapped [mem 0xfbfff000-0xfffff000] (64MB)
> PCI: Probing PCI hardware
> fsl-pci ffe240000.pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io
>  0x8000080000010000-0x800008000001ffff] (bus address [0x0000-0xffff])
> pci_bus 0000:00: root bus resource [mem 0xc00000000-0xc0fffffff] (bus
> address [0xe0000000-0xefffffff])
> pci_bus 0000:00: root bus resource [bus 00]
> iommu: Removing device ffe240000.pcie from group 19
> iommu: Adding device 0000:00:00.0 to group 24
> pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> fsl-pci ffe250000.pcie: PCI host bridge to bus 0001:00
> pci_bus 0001:00: root bus resource [io
>  0x8000080000021000-0x8000080000030fff] (bus address [0x0000-0xffff])
> pci_bus 0001:00: root bus resource [mem 0xc10000000-0xc1fffffff] (bus
> address [0xe0000000-0xefffffff])
> pci_bus 0001:00: root bus resource [bus 00-01]
> iommu: Removing device ffe250000.pcie from group 20
> iommu: Adding device 0001:00:00.0 to group 19
> pci 0001:01:00.0: enabling Extended Tags
> pci 0001:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5 GT/s
> x1 link at 0001:00:00.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
> iommu: Adding device 0001:01:00.0 to group 19
> pci 0001:01:00.1: enabling Extended Tags
> iommu: Adding device 0001:01:00.1 to group 19
> pci 0001:00:00.0: PCI bridge to [bus 01-ff]
> fsl-pci ffe260000.pcie: PCI host bridge to bus 0002:00
> pci_bus 0002:00: root bus resource [io
>  0x8000080000032000-0x8000080000041fff] (bus address [0x0000-0xffff])
> pci_bus 0002:00: root bus resource [mem 0xc20000000-0xc2fffffff] (bus
> address [0xe0000000-0xefffffff])
> pci_bus 0002:00: root bus resource [bus 00]
> iommu: Removing device ffe260000.pcie from group 21
> iommu: Adding device 0002:00:00.0 to group 20
> pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci 0002:00:00.0: PCI bridge to [bus 01-ff]
> fsl-pci ffe270000.pcie: PCI host bridge to bus 0003:00
> pci_bus 0003:00: root bus resource [io
>  0x8000080000043000-0x8000080000052fff] (bus address [0x0000-0xffff])
> pci_bus 0003:00: root bus resource [mem 0xc30000000-0xc3fffffff] (bus
> address [0xe0000000-0xefffffff])
> pci_bus 0003:00: root bus resource [bus 00]
> iommu: Removing device ffe270000.pcie from group 22
> iommu: Adding device 0003:00:00.0 to group 21
> pci 0003:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci 0003:00:00.0: PCI bridge to [bus 01-ff]
> PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will remap
> PCI: Cannot allocate resource region 0 of device 0001:00:00.0, will remap
> PCI: Cannot allocate resource region 2 of device 0001:01:00.0, will remap
> PCI: Cannot allocate resource region 5 of device 0001:01:00.0, will remap
> PCI: Cannot allocate resource region 6 of device 0001:01:00.0, will remap
> PCI: Cannot allocate resource region 0 of device 0001:01:00.1, will remap
> PCI: Cannot allocate resource region 0 of device 0002:00:00.0, will remap
> PCI: Cannot allocate resource region 0 of device 0003:00:00.0, will remap
> pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000]
> pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
> pci 0000:00:00.0: PCI bridge to [bus 01]
> pci 0000:00:00.0:   bridge window [io
>  0x8000080000010000-0x800008000001ffff]
> pci 0000:00:00.0:   bridge window [mem 0xc00000000-0xc0fffffff]
> pci_bus 0000:00: Some PCI device resources are unassigned, try booting
> with pci=3Drealloc
> pci 0001:00:00.0: BAR 0: no space for [mem size 0x01000000]
> pci 0001:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
> pci 0001:00:00.0: BAR 9: no space for [mem size 0x00200000 64bit pref]
> pci 0001:00:00.0: BAR 9: failed to assign [mem size 0x00200000 64bit pref=
]
> pci 0001:01:00.0: BAR 2: no space for [mem size 0x00200000 64bit pref]
> pci 0001:01:00.0: BAR 2: failed to assign [mem size 0x00200000 64bit pref=
]
> pci 0001:01:00.0: BAR 5: no space for [mem size 0x00040000]
> pci 0001:01:00.0: BAR 5: failed to assign [mem size 0x00040000]
> pci 0001:01:00.0: BAR 6: no space for [mem size 0x00020000 pref]
> pci 0001:01:00.0: BAR 6: failed to assign [mem size 0x00020000 pref]
> pci 0001:01:00.1: BAR 0: no space for [mem size 0x00004000 64bit]
> pci 0001:01:00.1: BAR 0: failed to assign [mem size 0x00004000 64bit]
> pci 0001:00:00.0: PCI bridge to [bus 01]
> pci 0001:00:00.0:   bridge window [io
>  0x8000080000021000-0x8000080000030fff]
> pci 0001:00:00.0:   bridge window [mem 0xc10000000-0xc1fffffff]
> pci_bus 0001:00: Some PCI device resources are unassigned, try booting
> with pci=3Drealloc
> pci 0002:00:00.0: BAR 0: no space for [mem size 0x01000000]
> pci 0002:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
> pci 0002:00:00.0: PCI bridge to [bus 01]
> pci 0002:00:00.0:   bridge window [io
>  0x8000080000032000-0x8000080000041fff]
> pci 0002:00:00.0:   bridge window [mem 0xc20000000-0xc2fffffff]
> pci_bus 0002:00: Some PCI device resources are unassigned, try booting
> with pci=3Drealloc
> pci 0003:00:00.0: BAR 0: no space for [mem size 0x01000000]
> pci 0003:00:00.0: BAR 0: failed to assign [mem size 0x01000000]
> pci 0003:00:00.0: PCI bridge to [bus 01]
> pci 0003:00:00.0:   bridge window [io
>  0x8000080000043000-0x8000080000052fff]
> pci 0003:00:00.0:   bridge window [mem 0xc30000000-0xc3fffffff]
> pci_bus 0003:00: Some PCI device resources are unassigned, try booting
> with pci=3Drealloc
>
>
>
>

--0000000000008fed960598b948fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div bgcolor=3D"#FFFFFF"><div=
>
      That is an expected result. 256MB is not enough for the VRAM BAR
      and the doorbell BAR to fit into. But you can still use VGA
      emulation that way if I&#39;m not completely mistaken.<br></div></div=
></blockquote><div><br></div><div>Hmm, then what procedure should I follow =
to take a VGA output. It seems Graphic Card does not have a VGA output. And=
 isn&#39;t there any way to use this GPU with a 256MB buffered PCIe?<br></d=
iv><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div bgcolor=3D"#FFFFFF"><div>
      <blockquote type=3D"cite">Then I canged 256 MB to 4GB in .dtsi and
        U-boot conf file.</blockquote>
      How did you do this? Is your memory layout consistent?<br>
      <br>
      See when you just changed one end address you might need to adjust
      other addresses as well.<br>
      <br>
      Regards,<br>
      Christian.<br></div></div></blockquote><div>=C2=A0</div><div>It&#39;s=
 not consistent I seems. At first I changed .dtsi like it&#39;s consistent.=
 I only changed PCIe1 Device Memory and I/O range. It gave same error. Then=
 I also changed PCIe2 and PCIe3 devices starting adress according to PCIe1 =
device end adress in .dtsi. I am not sure I made this correctly or not but =
it gave same result again. This is why I asked &quot;If it is, is there any=
 sample PCIe
                        configuration for E9171?&quot;.</div></div><div cla=
ss=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><b>This is a code p=
iece from my T104xRDB.h file which is contain PCIe configuration variables =
for U-boot. I made changes like it&#39;s not consistent. RAM size is 8 GB.<=
br></b></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote=
">#ifdef CONFIG_PCI<br>/* controller 1, direct to uli, tgtid 3, Base addres=
s 20000 */<br>#ifdef CONFIG_PCIE1<br>#define	CONFIG_SYS_PCIE1_MEM_VIRT	<b>0=
x80000000</b><br>#define	CONFIG_SYS_PCIE1_MEM_BUS	0xe0000000<br>#define	CON=
FIG_SYS_PCIE1_MEM_PHYS	0xc00000000ull<br>#define CONFIG_SYS_PCIE1_MEM_SIZE	=
<b>0x10000000	/* 256M */</b><br>#define CONFIG_SYS_PCIE1_IO_VIRT	0xf8000000=
<br>#define CONFIG_SYS_PCIE1_IO_BUS		0x00000000<br>#define CONFIG_SYS_PCIE1=
_IO_PHYS	<b>0xff8000000ull</b><br>#define CONFIG_SYS_PCIE1_IO_SIZE	<b>0x000=
10000	/* 64k */</b><br>#endif<br><br>/* controller 2, Slot 2, tgtid 2, Base=
 address 201000 */<br>#ifdef CONFIG_PCIE2<br>#define CONFIG_SYS_PCIE2_MEM_V=
IRT	<b>0x90000000</b><br>#define CONFIG_SYS_PCIE2_MEM_BUS	0xe0000000<br>#de=
fine CONFIG_SYS_PCIE2_MEM_PHYS	0xc10000000ull<br>#define CONFIG_SYS_PCIE2_M=
EM_SIZE<b>	0x100000000	/* 4GB */</b><br>#define CONFIG_SYS_PCIE2_IO_VIRT	0x=
f8010000<br>#define CONFIG_SYS_PCIE2_IO_BUS		0x00000000<br>#define CONFIG_S=
YS_PCIE2_IO_PHYS	0xff8010000ull<br>#define CONFIG_SYS_PCIE2_IO_SIZE	<b>0x00=
100000	/* 1M */</b><br>#endif<br><br>/* controller 3, Slot 1, tgtid 1, Base=
 address 202000 */<br>#ifdef CONFIG_PCIE3<br>#define CONFIG_SYS_PCIE3_MEM_V=
IRT	<b>0x190000000  /* I changed this to 0x190000000 instead of 0xa0000000 =
because PCIE2 end adress is changed. End adress is to 4 GB (0x100000000 hex=
 so I added 0x90000000 with 100000000) */</b><br>#define CONFIG_SYS_PCIE3_M=
EM_BUS	0xe0000000<br>#define CONFIG_SYS_PCIE3_MEM_PHYS	0xd10000000ull<br>#d=
efine CONFIG_SYS_PCIE3_MEM_SIZE	0x10000000	/* 256M */<br>#define CONFIG_SYS=
_PCIE3_IO_VIRT	0xf8110000<br>#define CONFIG_SYS_PCIE3_IO_BUS		0x00000000<br=
>#define CONFIG_SYS_PCIE3_IO_PHYS	<b>0xff8110000ull /* Did same things for =
IO </b><br>#define CONFIG_SYS_PCIE3_IO_SIZE	0x00010000	/* 64k */<br>#endif<=
br><br>/* controller 4, Base address 203000 */<br>#ifdef CONFIG_PCIE4<br>#d=
efine CONFIG_SYS_PCIE4_MEM_VIRT	<b>0x200000000 /* SAME STEP WITH PCIE3. Thi=
s time I added with 256 MB (0x10000000) */</b><br>#define CONFIG_SYS_PCIE4_=
MEM_BUS	0xe0000000<br>#define CONFIG_SYS_PCIE4_MEM_PHYS	0xd20000000ull<br>#=
define CONFIG_SYS_PCIE4_MEM_SIZE	0x10000000	/* 256M */<br>#define CONFIG_SY=
S_PCIE4_IO_VIRT	0xf8120000 <b></b><br>#define CONFIG_SYS_PCIE4_IO_BUS		0x00=
000000<br>#define CONFIG_SYS_PCIE4_IO_PHYS	<b>0xff8120000ull /* Did same th=
ings for IO </b><br>#define CONFIG_SYS_PCIE4_IO_SIZE	0x00010000	/* 64k */<b=
r>#endif</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quot=
e"><br><div><br></div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div bgcolor=3D"#FFFFFF"><div>
      Am 02.12.19 um 14:32 schrieb Yusuf Alt=C4=B1parmak:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div bgcolor=3D"#FFFFFF"><br>
              <blockquote type=3D"cite">I attached my dts file.<br>
                <div>
                  <div><br>
                  </div>
                  <div>System is working fine when GPU is not plugged
                    in.</div>
                  <div><b><br>
                    </b></div>
                  <div><b>This is the last console log before freeze:</b></=
div>
                  <div>[drm] amdgpu kernel modesetting enabled. =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0</div>
                  [drm] initializing kernel modesetting (POLARIS12
                  0x1002:0x6987 0x1787:0x2389 0x80).=C2=A0 <br>
                  [drm] register mmio base: 0x20200000 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                  fsl-fman-port ffe488000.port fm1-gb0: renamed from
                  eth0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                  [drm] register mmio size: 262144 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                  [drm] add ip block number 0 &lt;vi_common&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <br>
                  [drm] add ip block number 1 &lt;gmc_v8_0&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>
                  [drm] add ip block number 2 &lt;tonga_ih&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>
                  [drm] add ip block number 3 &lt;powerplay&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <br>
                  [drm] add ip block number 4 &lt;dm&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>
                  [drm] add ip block number 5 &lt;gfx_v8_0&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>
                  [drm] add ip block number 6 &lt;sdma_v3_0&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <br>
                  [drm] add ip block number 7 &lt;uvd_v6_0&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>
                  [drm] add ip block number 8 &lt;vce_v3_0&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>
                  [drm] UVD is enabled in VM mode =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                  [drm] UVD ENC is enabled in VM mode =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                  [drm] VCE enabled in VM mode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                  ATOM BIOS: 113-ER16BFC-001 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                  [drm] GPU posting now... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                  Disabling lock debugging due to kernel taint =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
                  Machine check in kernel mode. =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                  Caused by (from MCSR=3Da000): Load Error Report =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                  Guarded Load Error Report =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                  Kernel panic - not syncing: Unrecoverable Machine
                  check =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>
                  CPU: 1 PID: 2023 Comm: udevd Tainted: G =C2=A0 M =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0
                  =C2=A0 =C2=A04.19.26+gc0c2141 #1 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<br>
                  Call Trace: =C2=A0 =C2=A0 =C2=A0 <br>
                </div>
              </blockquote>
            </div>
          </blockquote>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div bgcolor=3D"#FFFFFF">
              <blockquote type=3D"cite">
                <div dir=3D"ltr">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 <br>
                </div>
                <br>
                <fieldset></fieldset>
                <pre>_______________________________________________
amd-gfx mailing list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Cchristian.koenig%40amd.com%7C9be244504efb4ff9cc0a08d7772c1630%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637108903547899069&amp;sdata=3DOL4UKczXi=
nKq5FM3Cid5kYcESkHAl0esXfOB83AUPU8%3D&amp;reserved=3D0" target=3D"_blank">h=
ttps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
              </blockquote>
              <br>
            </div>
          </blockquote>
          <div>
            <div dir=3D"ltr"><br>
            </div>
            <br>
            <div class=3D"gmail_quote">
              <div dir=3D"ltr" class=3D"gmail_attr">Christian K=C3=B6nig &l=
t;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">cko=
enig.leichtzumerken@gmail.com</a>&gt;,
                2 Ara 2019 Pzt, 15:28 tarihinde =C5=9Funu yazd=C4=B1:<br>
              </div>
              <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                <div bgcolor=3D"#FFFFFF">
                  <div>Hi Yusuf,<br>
                    <br>
                    Am 02.12.19 um 12:41 schrieb Yusuf Alt=C4=B1parmak:<br>
                  </div>
                  <blockquote type=3D"cite">
                    <div dir=3D"ltr">
                      <div>My embedded board is freezing when I put
                        E9171 on PCIe. What is the meaning of
                        Unrecoverable Machine Check error about GPU? <br>
                      </div>
                    </div>
                  </blockquote>
                  <br>
                  Well see the explanation on Wikipedia for example: <a hre=
f=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fen=
.wikipedia.org%2Fwiki%2FMachine-check_exception&amp;data=3D02%7C01%7Cchrist=
ian.koenig%40amd.com%7C9be244504efb4ff9cc0a08d7772c1630%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637108903547909070&amp;sdata=3DmBxI9LnRBO4iu5oyHc=
9OrrFj0K10SiOf5%2FztzmNedaI%3D&amp;reserved=3D0" target=3D"_blank">https://=
en.wikipedia.org/wiki/Machine-check_exception</a><br>
                  <br>
                  In general it means you have messed up something in
                  your hardware configuration.<br>
                  <br>
                  <blockquote type=3D"cite">
                    <div dir=3D"ltr">
                      <div>Could PCIe settings in .dts file cause this
                        problem?</div>
                    </div>
                  </blockquote>
                  <br>
                  Possible, but rather unlikely. My best guess is that
                  it is some problem with the power supply.<br>
                  <br>
                  <blockquote type=3D"cite">
                    <div dir=3D"ltr">
                      <div> If it is, is there any sample PCIe
                        configuration for E9171?</div>
                    </div>
                  </blockquote>
                  <br>
                  The E9171 is just a PCIe device, so the dtsi is
                  actually rather uninteresting. What we really need is
                  a full dmesg and maybe lspci output would help as
                  well.<br>
                  <br>
                  Regards,<br>
                  Christian.</div>
              </blockquote>
              <div><br>
              </div>
              <div><br>
              </div>
              <div>Hi Christian,</div>
              <div><br>
              </div>
              <div>At first, I am using NXP T1042D4RDB-64B which has 256
                MB PCIe buffer according to its. PCIe memory range was
                arranged to 256 MB in .dts file and in U-boot
                configuration file. Driver was giving error with exit
                code -12 (OUT_OF_MEMORY). But I was able to reach the
                linux console. <br>
              </div>
              <div><br>
              </div>
              <div>[ =C2=A0 =C2=A05.512922] [drm] amdgpu kernel modesetting
                enabled.<br>
                [ =C2=A0 =C2=A05.517065] [drm] initializing kernel modesett=
ing
                (POLARIS12 0x1002:0x6987 0x1787:0x2389 0x80).<br>
                [ =C2=A0 =C2=A05.524507] amdgpu 0001:01:00.0: Fatal error d=
uring
                GPU init<br>
                [ =C2=A0 =C2=A05.529296] amdgpu: probe of 0001:01:00.0 fail=
ed with
                error -12<br>
              </div>
              <div> <br>
              </div>
            </div>
            Then I canged 256 MB to 4GB in .dtsi and U-boot conf file. I
            also changed 64KB I/O size to 1MB . When I do this, I wasn&#39;=
t
            able to reach the linux console because board was freezing.
            But driver was successfull at this time. I already mentioned
            successfull driver console logs up.<br>
          </div>
          <div><br>
          </div>
          <div>
            <div><b>this is lspci -v when GPU is plugged and Memory size
                is 256 MB.</b></div>
            <div><br>
            </div>
            <div>root@t1042d4rdb-64b:~# lspci -v<br>
              0000:00:00.0 PCI bridge: Freescale Semiconductor Inc
              Device 0824 (rev 11) (prog-if 00 [Normal decode])<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Device tree node:
              /sys/firmware/devicetree/base/pcie@ffe240000/pcie@0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: bus master, fast devsel, l=
atency 0, IRQ 20<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory at &lt;ignored&gt; (32-bit=
,
              non-prefetchable)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Bus: primary=3D00, secondary=3D01=
, subordinate=3D01,
              sec-latency=3D0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 I/O behind bridge: 00000000-0000f=
fff [size=3D64K]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory behind bridge: e0000000-ef=
ffffff
              [size=3D256M]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Prefetchable memory behind bridge=
: None<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [44] Power Manageme=
nt version 3<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [4c] Express Root P=
ort (Slot-), MSI
              00<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [100] Advanced Erro=
r Reporting<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel driver in use: pcieport<br=
>
              <br>
              0001:00:00.0 PCI bridge: Freescale Semiconductor Inc
              Device 0824 (rev 11) (prog-if 00 [Normal decode])<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Device tree node:
              /sys/firmware/devicetree/base/pcie@ffe250000/pcie@0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: bus master, fast devsel, l=
atency 0, IRQ 21<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory at &lt;ignored&gt; (32-bit=
,
              non-prefetchable)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Bus: primary=3D00, secondary=3D01=
, subordinate=3D01,
              sec-latency=3D0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 I/O behind bridge: 00000000-0000f=
fff [size=3D64K]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory behind bridge: e0000000-ef=
ffffff
              [size=3D256M]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Prefetchable memory behind bridge=
: None<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [44] Power Manageme=
nt version 3<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [4c] Express Root P=
ort (Slot-), MSI
              00<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [100] Advanced Erro=
r Reporting<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel driver in use: pcieport<br=
>
              <br>
              0001:01:00.0 VGA compatible controller: Advanced Micro
              Devices, Inc. [AMD/ATI] Lexa [Radeon E9171 MCM] (rev 80)
              (prog-if 00 [VGA controller])<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Subsystem: Hightech Information S=
ystem Ltd. Device
              2389<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: fast devsel, IRQ 41<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory at c10000000 (64-bit, pref=
etchable)
              [size=3D256M]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory at &lt;ignored&gt; (64-bit=
, prefetchable)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 I/O ports at 1100 [size=3D256]<br=
>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory at &lt;ignored&gt; (32-bit=
,
              non-prefetchable)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Expansion ROM at &lt;ignored&gt; =
[disabled]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [48] Vendor Specifi=
c Information:
              Len=3D08 &lt;?&gt;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [50] Power Manageme=
nt version 3<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [58] Express Legacy=
 Endpoint, MSI 00<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [a0] MSI: Enable- C=
ount=3D1/1
              Maskable- 64bit+<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [100] Vendor Specif=
ic Information:
              ID=3D0001 Rev=3D1 Len=3D010 &lt;?&gt;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [150] Advanced Erro=
r Reporting<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [200] Resizable BAR=
 &lt;?&gt;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [270] Secondary PCI=
 Express
              &lt;?&gt;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [2b0] Address Trans=
lation Service
              (ATS)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [2c0] Page Request =
Interface (PRI)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [2d0] Process Addre=
ss Space ID
              (PASID)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [320] Latency Toler=
ance Reporting<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [328] Alternative R=
outing-ID
              Interpretation (ARI)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [370] L1 PM Substat=
es<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel modules: amdgpu<br>
              <br>
              0001:01:00.1 Audio device: Advanced Micro Devices, Inc.
              [AMD/ATI] Device aae0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Subsystem: Hightech Information S=
ystem Ltd. Device
              aae0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: bus master, fast devsel, l=
atency 0, IRQ 17<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory at &lt;ignored&gt; (64-bit=
,
              non-prefetchable)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [48] Vendor Specifi=
c Information:
              Len=3D08 &lt;?&gt;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [50] Power Manageme=
nt version 3<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [58] Express Legacy=
 Endpoint, MSI 00<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [a0] MSI: Enable- C=
ount=3D1/1
              Maskable- 64bit+<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [100] Vendor Specif=
ic Information:
              ID=3D0001 Rev=3D1 Len=3D010 &lt;?&gt;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [150] Advanced Erro=
r Reporting<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [328] Alternative R=
outing-ID
              Interpretation (ARI)<br>
              <br>
              0002:00:00.0 PCI bridge: Freescale Semiconductor Inc
              Device 0824 (rev 11) (prog-if 00 [Normal decode])<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Device tree node:
              /sys/firmware/devicetree/base/pcie@ffe260000/pcie@0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: bus master, fast devsel, l=
atency 0, IRQ 22<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory at &lt;ignored&gt; (32-bit=
,
              non-prefetchable)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Bus: primary=3D00, secondary=3D01=
, subordinate=3D01,
              sec-latency=3D0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 I/O behind bridge: 00000000-0000f=
fff [size=3D64K]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory behind bridge: e0000000-ef=
ffffff
              [size=3D256M]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Prefetchable memory behind bridge=
: None<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [44] Power Manageme=
nt version 3<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [4c] Express Root P=
ort (Slot-), MSI
              00<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [100] Advanced Erro=
r Reporting<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel driver in use: pcieport<br=
>
              <br>
              0003:00:00.0 PCI bridge: Freescale Semiconductor Inc
              Device 0824 (rev 11) (prog-if 00 [Normal decode])<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Device tree node:
              /sys/firmware/devicetree/base/pcie@ffe270000/pcie@0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: bus master, fast devsel, l=
atency 0, IRQ 23<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory at &lt;ignored&gt; (32-bit=
,
              non-prefetchable)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Bus: primary=3D00, secondary=3D01=
, subordinate=3D01,
              sec-latency=3D0<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 I/O behind bridge: 00000000-0000f=
fff [size=3D64K]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory behind bridge: e0000000-ef=
ffffff
              [size=3D256M]<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Prefetchable memory behind bridge=
: None<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [44] Power Manageme=
nt version 3<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [4c] Express Root P=
ort (Slot-), MSI
              00<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [100] Advanced Erro=
r Reporting<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel driver in use: pcieport</d=
iv>
            <div><br>
            </div>
          </div>
          <div><b>AND This is PCIe dmesg message when memory range is
              256MB. It&#39;s also giving same message when memory range is
              arranged as 4GB;</b></div>
          <div><br>
          </div>
          <div>PCI host bridge /pcie@ffe240000 =C2=A0ranges:<br>
            =C2=A0MEM 0x0000000c00000000..0x0000000c0fffffff -&gt;
            0x00000000e0000000 <br>
            =C2=A0 IO 0x0000000ff8000000..0x0000000ff800ffff -&gt;
            0x0000000000000000<br>
            /pcie@ffe240000: PCICSRBAR @ 0xff000000<br>
            setup_pci_atmu: end of DRAM 200000000<br>
            /pcie@ffe240000: Setup 64-bit PCI DMA window<br>
            /pcie@ffe240000: WARNING: Outbound window cfg leaves gaps in
            memory map. Adjusting the memory map could reduce
            unnecessary bounce buffering.<br>
            /pcie@ffe240000: DMA window size is 0xe0000000<br>
            Found FSL PCI host bridge at 0x0000000ffe250000. Firmware
            bus number: 0-&gt;1<br>
            PCI host bridge /pcie@ffe250000 =C2=A0ranges:<br>
            =C2=A0MEM 0x0000000c10000000..0x0000000c1fffffff -&gt;
            0x00000000e0000000 <br>
            =C2=A0 IO 0x0000000ff8010000..0x0000000ff801ffff -&gt;
            0x0000000000000000<br>
            /pcie@ffe250000: PCICSRBAR @ 0xff000000<br>
            setup_pci_atmu: end of DRAM 200000000<br>
            /pcie@ffe250000: Setup 64-bit PCI DMA window<br>
            /pcie@ffe250000: WARNING: Outbound window cfg leaves gaps in
            memory map. Adjusting the memory map could reduce
            unnecessary bounce buffering.<br>
            /pcie@ffe250000: DMA window size is 0xe0000000<br>
            Found FSL PCI host bridge at 0x0000000ffe260000. Firmware
            bus number: 0-&gt;0<br>
            PCI host bridge /pcie@ffe260000 =C2=A0ranges:<br>
            =C2=A0MEM 0x0000000c20000000..0x0000000c2fffffff -&gt;
            0x00000000e0000000 <br>
            =C2=A0 IO 0x0000000ff8020000..0x0000000ff802ffff -&gt;
            0x0000000000000000<br>
            /pcie@ffe260000: PCICSRBAR @ 0xff000000<br>
            setup_pci_atmu: end of DRAM 200000000<br>
            /pcie@ffe260000: Setup 64-bit PCI DMA window<br>
            /pcie@ffe260000: WARNING: Outbound window cfg leaves gaps in
            memory map. Adjusting the memory map could reduce
            unnecessary bounce buffering.<br>
            /pcie@ffe260000: DMA window size is 0xe0000000<br>
            Found FSL PCI host bridge at 0x0000000ffe270000. Firmware
            bus number: 0-&gt;0<br>
            PCI host bridge /pcie@ffe270000 =C2=A0ranges:<br>
            =C2=A0MEM 0x0000000c30000000..0x0000000c3fffffff -&gt;
            0x00000000e0000000 <br>
            =C2=A0 IO 0x0000000ff8030000..0x0000000ff803ffff -&gt;
            0x0000000000000000<br>
            /pcie@ffe270000: PCICSRBAR @ 0xff000000<br>
            setup_pci_atmu: end of DRAM 200000000<br>
            /pcie@ffe270000: Setup 64-bit PCI DMA window<br>
            /pcie@ffe270000: WARNING: Outbound window cfg leaves gaps in
            memory map. Adjusting the memory map could reduce
            unnecessary bounce buffering.<br>
            /pcie@ffe270000: DMA window size is 0xe0000000<br>
            iommu: Adding device ff6000000.qman-portal to group 0<br>
            iommu: Adding device ff6004000.qman-portal to group 1<br>
            iommu: Adding device ff6008000.qman-portal to group 2<br>
            iommu: Adding device ff600c000.qman-portal to group 3<br>
            iommu: Adding device ff6010000.qman-portal to group 4<br>
            iommu: Adding device ff6014000.qman-portal to group 5<br>
            iommu: Adding device ff6018000.qman-portal to group 6<br>
            iommu: Adding device ff601c000.qman-portal to group 7<br>
            iommu: Adding device ff6020000.qman-portal to group 8<br>
            iommu: Adding device ff6024000.qman-portal to group 9<br>
            iommu: Adding device ffe100300.dma to group 10<br>
            iommu: Adding device ffe101300.dma to group 11<br>
            iommu: Adding device ffe114000.sdhc to group 12<br>
            iommu: Adding device ffe210000.usb to group 13<br>
            iommu: Adding device ffe211000.usb to group 14<br>
            iommu: Adding device ffe220000.sata to group 15<br>
            iommu: Adding device ffe221000.sata to group 16<br>
            iommu: Adding device ffe318000.qman to group 17<br>
            iommu: Adding device ffe31a000.bman to group 18<br>
            iommu: Adding device ffe240000.pcie to group 19<br>
            iommu: Adding device ffe250000.pcie to group 20<br>
            iommu: Adding device ffe260000.pcie to group 21<br>
            iommu: Adding device ffe270000.pcie to group 22<br>
            iommu: Adding device ffe140000.qe to group 23<br>
            software IO TLB: mapped [mem 0xfbfff000-0xfffff000] (64MB)<br>
            PCI: Probing PCI hardware<br>
            fsl-pci ffe240000.pcie: PCI host bridge to bus 0000:00<br>
            pci_bus 0000:00: root bus resource [io
            =C2=A00x8000080000010000-0x800008000001ffff] (bus address
            [0x0000-0xffff])<br>
            pci_bus 0000:00: root bus resource [mem
            0xc00000000-0xc0fffffff] (bus address
            [0xe0000000-0xefffffff])<br>
            pci_bus 0000:00: root bus resource [bus 00]<br>
            iommu: Removing device ffe240000.pcie from group 19<br>
            iommu: Adding device 0000:00:00.0 to group 24<br>
            pci 0000:00:00.0: bridge configuration invalid ([bus
            00-00]), reconfiguring<br>
            pci 0000:00:00.0: PCI bridge to [bus 01-ff]<br>
            fsl-pci ffe250000.pcie: PCI host bridge to bus 0001:00<br>
            pci_bus 0001:00: root bus resource [io
            =C2=A00x8000080000021000-0x8000080000030fff] (bus address
            [0x0000-0xffff])<br>
            pci_bus 0001:00: root bus resource [mem
            0xc10000000-0xc1fffffff] (bus address
            [0xe0000000-0xefffffff])<br>
            pci_bus 0001:00: root bus resource [bus 00-01]<br>
            iommu: Removing device ffe250000.pcie from group 20<br>
            iommu: Adding device 0001:00:00.0 to group 19<br>
            pci 0001:01:00.0: enabling Extended Tags<br>
            pci 0001:01:00.0: 4.000 Gb/s available PCIe bandwidth,
            limited by 5 GT/s x1 link at 0001:00:00.0 (capable of 63.008
            Gb/s with 8 GT/s x8 link)<br>
            iommu: Adding device 0001:01:00.0 to group 19<br>
            pci 0001:01:00.1: enabling Extended Tags<br>
            iommu: Adding device 0001:01:00.1 to group 19<br>
            pci 0001:00:00.0: PCI bridge to [bus 01-ff]<br>
            fsl-pci ffe260000.pcie: PCI host bridge to bus 0002:00<br>
            pci_bus 0002:00: root bus resource [io
            =C2=A00x8000080000032000-0x8000080000041fff] (bus address
            [0x0000-0xffff])<br>
            pci_bus 0002:00: root bus resource [mem
            0xc20000000-0xc2fffffff] (bus address
            [0xe0000000-0xefffffff])<br>
            pci_bus 0002:00: root bus resource [bus 00]<br>
            iommu: Removing device ffe260000.pcie from group 21<br>
            iommu: Adding device 0002:00:00.0 to group 20<br>
            pci 0002:00:00.0: bridge configuration invalid ([bus
            00-00]), reconfiguring<br>
            pci 0002:00:00.0: PCI bridge to [bus 01-ff]<br>
            fsl-pci ffe270000.pcie: PCI host bridge to bus 0003:00<br>
            pci_bus 0003:00: root bus resource [io
            =C2=A00x8000080000043000-0x8000080000052fff] (bus address
            [0x0000-0xffff])<br>
            pci_bus 0003:00: root bus resource [mem
            0xc30000000-0xc3fffffff] (bus address
            [0xe0000000-0xefffffff])<br>
            pci_bus 0003:00: root bus resource [bus 00]<br>
            iommu: Removing device ffe270000.pcie from group 22<br>
            iommu: Adding device 0003:00:00.0 to group 21<br>
            pci 0003:00:00.0: bridge configuration invalid ([bus
            00-00]), reconfiguring<br>
            pci 0003:00:00.0: PCI bridge to [bus 01-ff]<br>
            PCI: Cannot allocate resource region 0 of device
            0000:00:00.0, will remap<br>
            PCI: Cannot allocate resource region 0 of device
            0001:00:00.0, will remap<br>
            PCI: Cannot allocate resource region 2 of device
            0001:01:00.0, will remap<br>
            PCI: Cannot allocate resource region 5 of device
            0001:01:00.0, will remap<br>
            PCI: Cannot allocate resource region 6 of device
            0001:01:00.0, will remap<br>
            PCI: Cannot allocate resource region 0 of device
            0001:01:00.1, will remap<br>
            PCI: Cannot allocate resource region 0 of device
            0002:00:00.0, will remap<br>
            PCI: Cannot allocate resource region 0 of device
            0003:00:00.0, will remap<br>
            pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000]<br>
            pci 0000:00:00.0: BAR 0: failed to assign [mem size
            0x01000000]<br>
            pci 0000:00:00.0: PCI bridge to [bus 01]<br>
            pci 0000:00:00.0: =C2=A0 bridge window [io
            =C2=A00x8000080000010000-0x800008000001ffff]<br>
            pci 0000:00:00.0: =C2=A0 bridge window [mem
            0xc00000000-0xc0fffffff]<br>
            pci_bus 0000:00: Some PCI device resources are unassigned,
            try booting with pci=3Drealloc<br>
            pci 0001:00:00.0: BAR 0: no space for [mem size 0x01000000]<br>
            pci 0001:00:00.0: BAR 0: failed to assign [mem size
            0x01000000]<br>
            pci 0001:00:00.0: BAR 9: no space for [mem size 0x00200000
            64bit pref]<br>
            pci 0001:00:00.0: BAR 9: failed to assign [mem size
            0x00200000 64bit pref]<br>
            pci 0001:01:00.0: BAR 2: no space for [mem size 0x00200000
            64bit pref]<br>
            pci 0001:01:00.0: BAR 2: failed to assign [mem size
            0x00200000 64bit pref]<br>
            pci 0001:01:00.0: BAR 5: no space for [mem size 0x00040000]<br>
            pci 0001:01:00.0: BAR 5: failed to assign [mem size
            0x00040000]<br>
            pci 0001:01:00.0: BAR 6: no space for [mem size 0x00020000
            pref]<br>
            pci 0001:01:00.0: BAR 6: failed to assign [mem size
            0x00020000 pref]<br>
            pci 0001:01:00.1: BAR 0: no space for [mem size 0x00004000
            64bit]<br>
            pci 0001:01:00.1: BAR 0: failed to assign [mem size
            0x00004000 64bit]<br>
            pci 0001:00:00.0: PCI bridge to [bus 01]<br>
            pci 0001:00:00.0: =C2=A0 bridge window [io
            =C2=A00x8000080000021000-0x8000080000030fff]<br>
            pci 0001:00:00.0: =C2=A0 bridge window [mem
            0xc10000000-0xc1fffffff]<br>
            pci_bus 0001:00: Some PCI device resources are unassigned,
            try booting with pci=3Drealloc<br>
            pci 0002:00:00.0: BAR 0: no space for [mem size 0x01000000]<br>
            pci 0002:00:00.0: BAR 0: failed to assign [mem size
            0x01000000]<br>
            pci 0002:00:00.0: PCI bridge to [bus 01]<br>
            pci 0002:00:00.0: =C2=A0 bridge window [io
            =C2=A00x8000080000032000-0x8000080000041fff]<br>
            pci 0002:00:00.0: =C2=A0 bridge window [mem
            0xc20000000-0xc2fffffff]<br>
            pci_bus 0002:00: Some PCI device resources are unassigned,
            try booting with pci=3Drealloc<br>
            pci 0003:00:00.0: BAR 0: no space for [mem size 0x01000000]<br>
            pci 0003:00:00.0: BAR 0: failed to assign [mem size
            0x01000000]<br>
            pci 0003:00:00.0: PCI bridge to [bus 01]<br>
            pci 0003:00:00.0: =C2=A0 bridge window [io
            =C2=A00x8000080000043000-0x8000080000052fff]<br>
            pci 0003:00:00.0: =C2=A0 bridge window [mem
            0xc30000000-0xc3fffffff]<br>
            pci_bus 0003:00: Some PCI device resources are unassigned,
            try booting with pci=3Drealloc<br>
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

</blockquote></div></div>

--0000000000008fed960598b948fc--

--===============1620372281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1620372281==--
