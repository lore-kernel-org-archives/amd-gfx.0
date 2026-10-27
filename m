Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D04606A326
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dJb+y1HS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F268110F44D;
	Tue, 27 Oct 2026 12:33:16 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58CC310F34A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 09:32:27 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a56e05568aso5577315e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793093546; x=1793698346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lonrPgzITxIfOIRaHBMV3jndVBT4kID24OJ8RZmSv+Y=;
 b=dJb+y1HSYYrvYI78bEriGqEeI9DPjn9V6z++STtEXxV0c5FjGW1FyfvEN950mxlKKj
 A1xSdbXNZVmZ5CHVrZy/0Wbc4CkpfePez5YBTl2zSgufpQYaWySbw7kf1KAHuUbWyV12
 RbUAtl9+RFXV/zGJuEF1crYlxjndy9QsI5tFT+Txeo4Rl4Yv2WoeUujDTOEVQt5sb2cJ
 nlT8nD9fHBsRHMO39E2KwmC6aOCJpmzZ6tYCn9dPXZD1Fj1eskQqfR21fZ7UijEIb162
 0i8FHYzDFnsdTNuZnMhCl/08VzzJKI8mZJXYXABh6pSQtMBSOyoqeU1x4jbh2lEgvDNj
 KYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793093546; x=1793698346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lonrPgzITxIfOIRaHBMV3jndVBT4kID24OJ8RZmSv+Y=;
 b=St5qarYo2TCGtQtLjsU831fUab6PZZt2DIDzrDGxEmy5wXXYFAskeKQV+6pUGLRCqT
 sGthyy+1X+RQERkDNG5rmlntP3RRO/ORvyiNlbVEnNC3umvfQhO4bsN9W90XhyXj2Dqc
 Fw9vALKgiVtyo8Y4Zmu6GifwQYV0mY3tp8vGIdO4VVnYEzYuYDYBdvXd3Ch3sTQFmknk
 klpbTb27oiSK0Q071CL8L4PmWLX2E6K9RVIXcPK6ASpt8C5ldL92F2YklIktVPMkXyQN
 dMH0NrnfZ26flrxR1uDsOf7XLzRRnk7vjqQtv4NOx8JCLju0otI8mLvV5tw8tE3aCZVB
 Z4tA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5SNS8K+EH+4aVYXX5HYUSndJ3G/Q61VryRWdJS0bTfA+S4UK9Z+fya/RtV2q3X6bmbhO3M+5v@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLdPFEavaRfeDbqtbj3lh5RQ/EZ+m5UYFmuPpq76kCLwF6bx4++
 rdK4KGpT5q7+38x2XhZlsaue1E/hlx+g6y//bGxoDJsNI1aJoWDFAaCj
X-Gm-Gg: AYBFou13L6CAtprlXdFjbQCCugjbuKHdz8fpYucRPmHSxqZuHsO2LL306xPNdH0h4ge
 wvxy7g9rqfY1k5oWASWmSDJ4XjbhqPqJYRE1ihPDhoKpsQWsireR7602pGrMEO0s9mrqwRPSv/A
 Cl65FmQAdLUhrODD2iKDCzTE4wFUBJfq/wvvH7YMynQ8brSXGx7j3LB/dna9AwiYc26nVww2d/6
 Sjo76h8ldriS5sRuiYzrdB5uzoW++XpyTU50a392OcrpmhIyeTnLVDDDzN/xnWmCh1qNk7APNxg
 KhTO6JlFjdr52hUB4C5mLD1XenoGdxuLrP73m3GRm/XYB1QufcztCLTA1wXmyBqI0dOct1Ty3z0
 4FB42EeB02HtnNnAWRam2NegILoWqqwU9+ajfNlU1KSIMtbfv/3h3CdywSpuGHr5oirmeZpkQVt
 3y8tSSV3VceRCv+nAbl6gFGfyY65P7gTpopTEicTL1mhsPTZJ5D5FYjlMj5bKoum7AHBC88B+d4
 1JygXdqSFgxJk3Sn81l1tqmw6QFonLinM7pdKrZWVtm3B+FrED69kGZ2WaG
X-Received: by 2002:a05:600c:6088:b0:4a0:1e9f:64f6 with SMTP id
 5b1f17b1804b1-4a35aae2effmr166021995e9.0.1793093545448; 
 Tue, 27 Oct 2026 02:32:25 -0700 (PDT)
Received: from Termis-ROG-FLOW-Z13 ([2a09:bac5:521a:2e6e::4a0:b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a573f65sm251384855e9.10.2026.10.27.02.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 02:32:25 -0700 (PDT)
From: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
To: Caspar Adriani <caspar.adriani@proton.me>
Cc: Nirujogi Pratap <pratap.nirujogi@amd.com>,
 Benjamin Chan <benjamin.chan@amd.com>, Bin Du <bin.du@amd.com>,
 King Li <King.Li@amd.com>, Hans de Goede <hansg@kernel.org>,
 "Adam J . Sypniewski" <ajsyp@syptech.net>, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
Subject: Re: [RFC] AMD ISP4: OV13B10 (OMNI13B1) rear camera on ASUS ROG Flow
 Z13 GZ302 - ISP comes up, SET_STREAM_CONFIG fails with error 6
Date: Tue, 27 Oct 2026 12:32:18 +0300
Message-ID: <20261027093218.35631-1-saif.elden.hatim@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <P9m7agZFwqTsT5eczqDOuUVoP-lGl6Nd8FLvknyAj7gm7R_4cwIpb2_3-DNis287elaS_x5ummKLdOf_rk7LcHZqnrTnjMuzEPcX2syIefg=@proton.me>
References: <lWYl1YJwDSh-q2Ew2f8b0BweQ4V-SUnPMSMurU5gT1LkqVdrmWFunj0sSgjC7m66bORBAD_jRCFTt1_ZOkotOMukY46rI4ayYbIfPQq4E9U=@proton.me>
 <ea758386-13b0-4667-8eca-9aa4efefe92b@amd.com>
 <P9m7agZFwqTsT5eczqDOuUVoP-lGl6Nd8FLvknyAj7gm7R_4cwIpb2_3-DNis287elaS_x5ummKLdOf_rk7LcHZqnrTnjMuzEPcX2syIefg=@proton.me>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 12:33:15 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Caspar, Pratap, all,

I have the same laptop (GZ302EA) and have been working on the rear
camera as well. Some results that may help this thread:

The rear camera streams on my machine (NV12 1920x1080, about 30 fps)
with an out-of-tree setup. As Pratap explained, the stock
linux-firmware image does not start this sensor; on my machine the
camera runs with ISP firmware and sensor setup data from my own
Windows driver installation, read from the Windows partition of that
machine. I do not redistribute any of it. The firmware alone was not
enough: getting a picture also took the board configuration and GPIO
wiring below, changes in the isp4 capture driver and in the sensor
setup, and the two fixes I sent to linux-media (link below).

Board details as seen from Linux on the GZ302:
- The sensor is \_SB.CAMB (_HID "OMNI13B1") in an SSDT, without _CRS,
  so ACPI describes no GPIO, clock or regulator for it.
- I2C on the ISP's bus: the sensor answers at 0x10 once it is powered
  and clocked; the focus motor is at 0x0c and the module EEPROM at
  0x50, matching Caspar's scan. My guess is that with the stock
  firmware the sensor never gets powered, because SET_STREAM_CONFIG
  fails before that, which would explain why 0x10 did not ACK.
- Sensor reset: amdisp-pinctrl GPIO 0, active low (the "reset" GPIO of
  the ov13b10 driver), the same ISP GPIO as the OV05C10 enable line.
- enable_isp (AMDI0030:00 pin 85, as for OMNI5C10): not confirmed on
  this board. No ACPI device claims the pin, and the ISP also boots
  with it left undriven.
- Sensor clock: 24 MHz, as declared for the OV05C10 platform on the
  same ISP; four CSI-2 lanes.

On the hang Caspar saw when stopping the stream, possibly related: when
a stream is running across s2idle (start a stream, then "rtcwake -m
mem -s 20"), no further frame arrives after resume, and stopping the
stream logs "fail to disable stream" and "fail to stop stream" because
the commands time out. On my machine the timeouts return and the
device can be closed; the driver has no system-sleep callbacks.
Caspar, did your hang happen after a suspend, or also without one, and
did you see those two messages?

I sent two small isp4 fixes found on this machine to linux-media:
https://lore.kernel.org/all/20261026182442.229869-1-saif.elden.hatim@gmail.com/
After the merge window I plan to post the board data above as an RFC
(amdgpu OMNI13B1 entry and GPIO lookups, amd_isp4 board configuration),
explicitly not for merging until the firmware supports the sensor.

Pratap, you mentioned contacting testers once there is OV13B10
firmware or a sensor-agnostic draft: I would be glad to test both on
the GZ302 and can share logs, ACPI tables and v4l2-compliance output.
My out-of-tree code (capture-driver changes, the board configuration
and the test scripts) is in a repository I can share on request.

One question for the sensor-agnostic driver: will a board like this
one describe its sensor through amdgpu and amd_isp4 tables as today,
or will the firmware take the sensor setup from another source?

Thanks,
Seifelden
