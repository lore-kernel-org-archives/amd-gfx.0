Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16816606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Tnvi3yJV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CC7112092;
	Thu, 29 Oct 2026 08:05:23 +0000 (UTC)
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732CD10E342
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1793196858; x=1793456058;
 bh=3B9pb6vCsnCnbOeR5GmpL4ETSRTzIUQ/rfJdv4A2OPw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Tnvi3yJVJ8J77SIQIPN24OfE1vAXT4D+N6m/+Dg0IkYKQU97hgefABZ4eXayAnwCG
 kNKYzqDK1Q3RGqeSMGXzobne1F12UF/6Qbd+jR5gqVOH5IrIUJGH4PLJAxFVzg1E6T
 cUAwsS4PRl4LYw2GtzVf2OcLSNhwdV1zw5OChkJPWCgCg6C8ag4xzgexWVqSUuQe/o
 YoBO2FG2081g5lycXUBZZzjgOJsIGFaIIR6Xefo0N5kRb0QY8ajHJuO26EkT2fXV2Q
 KXmVluhPhsTG25uaKHapwN59ccNa91TBaGywcRcv0RndmzZi974RuT9bxAFgqI2wTz
 /EpnjIK2/V/mQ==
Date: Wed, 28 Oct 2026 14:14:14 +0000
To: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
From: "caspar.adriani" <caspar.adriani@proton.me>
Cc: Nirujogi Pratap <pratap.nirujogi@amd.com>,
 Benjamin Chan <benjamin.chan@amd.com>, Bin Du <bin.du@amd.com>,
 King Li <King.Li@amd.com>, Hans de Goede <hansg@kernel.org>,
 "Adam J . Sypniewski" <ajsyp@syptech.net>, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [RFC] AMD ISP4: OV13B10 (OMNI13B1) rear camera on ASUS ROG Flow
 Z13 GZ302 - ISP comes up, SET_STREAM_CONFIG fails with error 6
Message-ID: <OLda3elCE7K_s9l7K6IHRCAJ0glPZx-B9zZCvsMzHeKMUfqfeQaIoV-466scB2JcOSOuZ4H6WRf0XVK7QnTz2c1TUind2lEAMczie9ieNX0=@proton.me>
In-Reply-To: <20261027093218.35631-1-saif.elden.hatim@gmail.com>
References: <lWYl1YJwDSh-q2Ew2f8b0BweQ4V-SUnPMSMurU5gT1LkqVdrmWFunj0sSgjC7m66bORBAD_jRCFTt1_ZOkotOMukY46rI4ayYbIfPQq4E9U=@proton.me>
 <ea758386-13b0-4667-8eca-9aa4efefe92b@amd.com>
 <P9m7agZFwqTsT5eczqDOuUVoP-lGl6Nd8FLvknyAj7gm7R_4cwIpb2_3-DNis287elaS_x5ummKLdOf_rk7LcHZqnrTnjMuzEPcX2syIefg=@proton.me>
 <20261027093218.35631-1-saif.elden.hatim@gmail.com>
Feedback-ID: 135490423:user:proton
X-Pm-Message-ID: 9970a4af79b75806f1fa910fa70679c4852f1fc9
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 29 Oct 2026 08:05:22 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Seifelden,

On Tue, 27 Oct 2026, Seifelden Abdelmonem wrote:
> Caspar, did your hang happen after a suspend, or also without one, and
> did you see those two messages?

Without a suspend. I checked the journal of that boot: there was no
suspend between boot and the hang. I did see both messages, several
times, for the earlier attempts whose stop completed.

The hang itself turned out to be a different bug from yours. The
hung-task report said:

  task .v4l2-ctl-wrapp:38440 is blocked on a mutex likely owned by
  task .v4l2-ctl-wrapp:38440
   isp4sd_stop_stream+0x43
   isp4sd_enable_streams.cold+0x8b
   isp4vid_qops_start_streaming

isp4sd_start_stream() holds ops_mutex and its error path calls
isp4sd_stop_stream(), which takes ops_mutex again. It is the same
pattern Yifei Gao fixed in isp4sd_pwron_and_init(), and it is still
present in mainline. It does not need the GZ302 to reproduce: start
and stop a stream, then start it again without S_FMT. The stop clears
the subdev pad format, so setup_output fails with "fail to get out
prop" and the task deadlocks. Your setup gets past setup_output, which
would explain why you don't hit it.

I sent a fix to linux-media:
https://lore.kernel.org/all/20261028-isp4-start-stream-deadlock-v1-1-babd80=
273148@proton.me/

I tested it on v7.3 on the GZ302 with a local OMNI13B1 enablement and
the stock firmware: the second start now fails with EINVAL, the
process exits, and the next start and stop work again.

Thanks for posting the board details and the two fixes, that was
useful. Same here: once AMD has OV13B10 firmware or a draft of the
new driver, I'm happy to test it on my GZ302 as well.

Cheers,
Caspar

On Tuesday, October 27th, 2026 at 10:32, Seifelden Abdelmonem <saif.elden.h=
atim@gmail.com> wrote:

> Hi Caspar, Pratap, all,
>=20
> I have the same laptop (GZ302EA) and have been working on the rear
> camera as well. Some results that may help this thread:
>=20
> The rear camera streams on my machine (NV12 1920x1080, about 30 fps)
> with an out-of-tree setup. As Pratap explained, the stock
> linux-firmware image does not start this sensor; on my machine the
> camera runs with ISP firmware and sensor setup data from my own
> Windows driver installation, read from the Windows partition of that
> machine. I do not redistribute any of it. The firmware alone was not
> enough: getting a picture also took the board configuration and GPIO
> wiring below, changes in the isp4 capture driver and in the sensor
> setup, and the two fixes I sent to linux-media (link below).
>=20
> Board details as seen from Linux on the GZ302:
> - The sensor is \_SB.CAMB (_HID "OMNI13B1") in an SSDT, without _CRS,
>   so ACPI describes no GPIO, clock or regulator for it.
> - I2C on the ISP's bus: the sensor answers at 0x10 once it is powered
>   and clocked; the focus motor is at 0x0c and the module EEPROM at
>   0x50, matching Caspar's scan. My guess is that with the stock
>   firmware the sensor never gets powered, because SET_STREAM_CONFIG
>   fails before that, which would explain why 0x10 did not ACK.
> - Sensor reset: amdisp-pinctrl GPIO 0, active low (the "reset" GPIO of
>   the ov13b10 driver), the same ISP GPIO as the OV05C10 enable line.
> - enable_isp (AMDI0030:00 pin 85, as for OMNI5C10): not confirmed on
>   this board. No ACPI device claims the pin, and the ISP also boots
>   with it left undriven.
> - Sensor clock: 24 MHz, as declared for the OV05C10 platform on the
>   same ISP; four CSI-2 lanes.
>=20
> On the hang Caspar saw when stopping the stream, possibly related: when
> a stream is running across s2idle (start a stream, then "rtcwake -m
> mem -s 20"), no further frame arrives after resume, and stopping the
> stream logs "fail to disable stream" and "fail to stop stream" because
> the commands time out. On my machine the timeouts return and the
> device can be closed; the driver has no system-sleep callbacks.
> Caspar, did your hang happen after a suspend, or also without one, and
> did you see those two messages?
>=20
> I sent two small isp4 fixes found on this machine to linux-media:
> https://lore.kernel.org/all/20261026182442.229869-1-saif.elden.hatim@gmai=
l.com/
> After the merge window I plan to post the board data above as an RFC
> (amdgpu OMNI13B1 entry and GPIO lookups, amd_isp4 board configuration),
> explicitly not for merging until the firmware supports the sensor.
>=20
> Pratap, you mentioned contacting testers once there is OV13B10
> firmware or a sensor-agnostic draft: I would be glad to test both on
> the GZ302 and can share logs, ACPI tables and v4l2-compliance output.
> My out-of-tree code (capture-driver changes, the board configuration
> and the test scripts) is in a repository I can share on request.
>=20
> One question for the sensor-agnostic driver: will a board like this
> one describe its sensor through amdgpu and amd_isp4 tables as today,
> or will the firmware take the sensor setup from another source?
>=20
> Thanks,
> Seifelden
> 
