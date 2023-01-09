Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69478C54EBD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 13:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB95110E0A3;
	Mon,  9 Jan 2023 13:40:52 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B203910E0A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 13:40:49 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id cf18so13836057ejb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Jan 2023 05:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n3PtqhRicJQnckTtXZv8to6j5pSWh4cCHypS6fAzDl8=;
 b=W9Q0yFCWHdBwtQ88Ox4RfHr/pfk4/2yIOU6cAZ1aGUdacEhJUHjJKNbG8GziVx5kmx
 UzRIoQbXJ/mCM9kWtbSurCJOx7s9j7w45C7L2x+rvtW+3r7tTThD45BPW7jJAnHnYs0r
 wzQzFEXeSi6Q+JmnVlX4tlAhZdHV/jqM7QsGehZYfdwmyCELcxZXs/rkE4jKD5A7qrvK
 OErY0QuK0AwrPk8RnvJKLyh4wmTlG2xZM1iReBZhV6PEVLGD3/0QX9xPlLKibDrQ5S+A
 OjXpktOVGneE4Kosc9ckF9CuxZ6FdiEmA8ba6pEvcsGbpw4+g0JyYKiUgon3yb0fMOcF
 8x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3PtqhRicJQnckTtXZv8to6j5pSWh4cCHypS6fAzDl8=;
 b=TIz1Lk5kPFcZuXfZYlMkh0n7H/LG+HWo6r1UmkgilDHTEJnGvSD4TGeNRtWUVRAd0/
 x93/PDBkvbnjDjmrjQ4u+2q7/ZhgvSPAtYOyZeaINl8r7ys54Wh0KWgK48rMcOTjifU8
 YssmmU7UWOH5xR3vW3R2evqXI2/ba3Ee7GeeehDJZSlM+6+tpZfFgFnBt4dAupQgccMT
 L6DAztqiYoIKacI9fzfcH6zs4J49TZQ0+4BVMZXDQCQPNkG+f5roDk+jgderJHz9LICl
 10zxH3D1vgOHNtCpI9VwFNBJpHekjtp01Z1V2ydBelJNmYZzNTUN7NZHmRyq7EbfAs5E
 TmWw==
X-Gm-Message-State: AFqh2koUfXiyEBOhG7Lw6bNs8gakFt4PHuVx8BL7ykKcLTVOD/fLFjBA
 7yhdWou+noK8BC+tE+FBvEg=
X-Google-Smtp-Source: AMrXdXt8iBTRXDVnqN9z12zhkOxgDlkCPu6unz2x9pzUo82NZi7wDdz/2VMW978qkzq8X5O+W0mL6A==
X-Received: by 2002:a17:906:9f1a:b0:84d:2025:8501 with SMTP id
 fy26-20020a1709069f1a00b0084d20258501mr9902124ejc.22.1673271648192; 
 Mon, 09 Jan 2023 05:40:48 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 k8-20020a17090632c800b00780982d77d1sm3753569ejk.154.2023.01.09.05.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jan 2023 05:40:47 -0800 (PST)
Message-ID: <82c8b18d-4e51-a137-6078-43b380661c37@gmail.com>
Date: Mon, 9 Jan 2023 14:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
 <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
 <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
 <CADnq5_NxbAgF6sXF6HuGzgcOoY8QOHU-0d9ghuKarx0jpt3Vog@mail.gmail.com>
 <CABXGCsOmtfo=7YWUv0QmGGrCat1Md59oz7UWw9-7MPn7f6AAdA@mail.gmail.com>
 <e6b6a599-8fdd-a4fc-a2bb-d0750e6d477d@gmail.com>
 <CABXGCsOL2SVg=FSOfhzo3wFHB9DqU=B34x+grCxQMhJsmTCMnw@mail.gmail.com>
 <CADnq5_P0Nq-y1U5X4EgYyPSKXOdVsjxX+UOCmzZKnX8FfHC86w@mail.gmail.com>
 <f4c965d9-d985-0030-7411-6d8d0f750058@gmail.com>
 <CABXGCsMJxX3wo8yhQA=nOk0ouzh-WGp_65DJBYb_9v2m4kk7Mw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsMJxX3wo8yhQA=nOk0ouzh-WGp_65DJBYb_9v2m4kk7Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alex Deucher <alexdeucher@gmail.com>, michel@daenzer.net,
 Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.01.23 um 14:13 schrieb Mikhail Gavrilov:
> On Fri, Jan 6, 2023 at 8:27 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> And it looks like Dmitry submitted it initially to the wrong branch.
>>
>> Because of this it wasn't scheduled as fix for 6.2, but rather queued up
>> as new feature for 6.3.
>>
>> This is fixed by now and the patch should show up in the next -rc.
>>
>> Regards,
>> Christian.
>>
> Hi,
> Not sure related to this patch but I caught kernel oops this weekend.
> Reproducing is too hard. I don't know which actions need to be taken.
> but I'm definitely sure that this is happening when I launch
> "Cyberpunk 2077", Google Chrome with a huge amount of opened windows
> and tabs should be launched too.
> But even two described conditions is not enough.
> In a way that is not entirely clear to me, a memory leak should occur.

That looks like an out of memory situation is not gracefully handled.

In other words we have a missing NULL check in drm_sched_job_cleanup().

Going to take a look.

Thanks,
Christian.

>
> The trace looks like:
> BUG: kernel NULL pointer dereference, address: 0000000000000078
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 39818f067 P4D 39818f067 PUD 35bbd6067 PMD 4f8438067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 21 PID: 100830 Comm: GameThread Tainted: G        W    L
> -------  ---  6.2.0-0.rc2.20230105git41c03ba9beea.20.fc38.x86_64 #1
> Hardware name: System manufacturer System Product Name/ROG STRIX
> X570-I GAMING, BIOS 4408 10/28/2022
> RIP: 0010:drm_sched_job_cleanup+0x1a/0x110 [gpu_sched]
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00
> 55 53 48 89 fb 48 83 ec 08 48 8b 7f 20 48 c7 04 24 00 00 00 00 <8b> 47
> 78 85 c0 0f 84 b5 00 00 00 48 83 ff c0 74 1f 48 8d 57 78 b8
> RSP: 0018:ffffae3e16c0b9d0 EFLAGS: 00010282
> RAX: 0000000000000001 RBX: ffff91de6f7bc000 RCX: 00000000012a8976
> RDX: 0000000000000000 RSI: ffffffffadbda69b RDI: 0000000000000000
> RBP: ffff91de6f7bc000 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000000 R12: 00000000ffffffff
> R13: 0000000000000018 R14: ffff91e259275000 R15: 0000000000000001
> FS:  000000007bcff6c0(0000) GS:ffff91e667e00000(0000) knlGS:000000007abe0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000078 CR3: 0000000297a24000 CR4: 0000000000350ee0
> Call Trace:
>   <TASK>
>   amdgpu_job_free+0x1d/0x120 [amdgpu]
>   amdgpu_cs_parser_fini+0x119/0x170 [amdgpu]
>   amdgpu_cs_ioctl+0x3f4/0x2000 [amdgpu]
>   ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
>   drm_ioctl_kernel+0xac/0x160
>   drm_ioctl+0x1e7/0x450
>   ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
>   amdgpu_drm_ioctl+0x4a/0x80 [amdgpu]
>   __x64_sys_ioctl+0x90/0xd0
>   do_syscall_64+0x5b/0x80
>   ? do_syscall_64+0x67/0x80
>   ? lock_is_held_type+0xe8/0x140
>   ? asm_sysvec_call_function+0x16/0x20
>   ? lockdep_hardirqs_on+0x7d/0x100
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fe30905e65f
> Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48
> 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2
> 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> RSP: 002b:000000007bcfd410 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000007bcfd738 RCX: 00007fe30905e65f
> RDX: 000000007bcfd520 RSI: 00000000c0186444 RDI: 00000000000000b6
> RBP: 000000007bcfd520 R08: 00007fe2800a6b80 R09: 000000007bcfd4b0
> R10: 000000007e22b350 R11: 0000000000000246 R12: 00000000c0186444
> R13: 00000000000000b6 R14: 000000000000000d R15: 00007fe2800a6ab0
>   </TASK>
> Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer netconsole
> nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink qrtr bnep
> sunrpc binfmt_misc mt76x2u mt76x2_common mt76x02_usb mt76_usb iwlmvm
> mt76x02_lib mt76 mac80211 btusb iwlwifi libarc4 btrtl btbcm btintel
> btmtk hid_logitech_hidpp xpad bluetooth cfg80211 ff_memless joydev
> intel_rapl_msr intel_rapl_common edac_mce_amd eeepc_wmi
> snd_hda_codec_realtek kvm_amd asus_wmi snd_hda_codec_generic
> snd_seq_midi snd_seq_midi_event ledtrig_audio vfat asus_ec_sensors kvm
> sparse_keymap platform_profile snd_hda_codec_hdmi fat snd_usb_audio
> snd_hda_intel snd_intel_dspcfg snd_usbmidi_lib snd_intel_sdw_acpi
> irqbypass snd_rawmidi snd_hda_codec rapl rfkill mc snd_hda_core
> wmi_bmof pcspkr i2c_piix4 k10temp snd_hwdep snd_seq snd_seq_device
> [19447.812785]  snd_pcm acpi_cpufreq hid_logitech_dj snd_timer snd
> soundcore zram amdgpu drm_ttm_helper ttm video crct10dif_pclmul
> iommu_v2 crc32_pclmul crc32c_intel drm_buddy polyval_clmulni gpu_sched
> polyval_generic igb drm_display_helper nvme ucsi_ccg typec_ucsi
> ghash_clmulni_intel ccp typec sha512_ssse3 nvme_core cec sp5100_tco
> dca nvme_common wmi ip6_tables ip_tables fuse
> CR2: 0000000000000078
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:drm_sched_job_cleanup+0x1a/0x110 [gpu_sched]
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00
> 55 53 48 89 fb 48 83 ec 08 48 8b 7f 20 48 c7 04 24 00 00 00 00 <8b> 47
> 78 85 c0 0f 84 b5 00 00 00 48 83 ff c0 74 1f 48 8d 57 78 b8
> RSP: 0018:ffffae3e16c0b9d0 EFLAGS: 00010282
> RAX: 0000000000000001 RBX: ffff91de6f7bc000 RCX: 00000000012a8976
> RDX: 0000000000000000 RSI: ffffffffadbda69b RDI: 0000000000000000
> RBP: ffff91de6f7bc000 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000000 R12: 00000000ffffffff
> R13: 0000000000000018 R14: ffff91e259275000 R15: 0000000000000001
> FS:  000000007bcff6c0(0000) GS:ffff91e667e00000(0000) knlGS:000000007abe0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000078 CR3: 0000000297a24000 CR4: 0000000000350ee0
>
>

