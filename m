Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE8606A337
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eg8JmYYK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE70510F12B;
	Thu, 19 Nov 2026 21:40:27 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E9A10F139
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 21:40:22 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7f421638271so26406a34.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:40:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795124421; cv=none;
 d=google.com; s=arc-20260327;
 b=UZtMnyqmwIKYzyOyS+UVFvbcEMeATYg0lX6YgxCy8VXq0/TRJI3Clt63nz5Dz9C2N9
 +NxouxM9m+H+19pdMAwO4ceshyK2KiKHRXhdBWnZdANUcI43xmW9EzIpXeRLB46qb3na
 cSUqu3Vf70x0IaH7IjtYeWQjNF8NqDoBSxZw9LlVzVhLN1SykeT10WRfF/n/POyVyIo0
 ZUzmlK0ObuSw2pFiNXIhnXi0le2v4BgeZNUFUJCN1p5ej/Xn+U0o8DhqfHBUC8BbXQqU
 HcZlNqXz9tBv/Al7i/o4lvn6q7keVYv5uPKSrxHLEAT+i8hVmJNmY75SRBwA441eZMzd
 J4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dh8hPARkgkUETdolih7JoovnBIYD0QkI16GrSMzuIaU=;
 fh=uHjnq5dCen4565/BdRN9TS/VaDD3PV0MNNiON+Z9i+w=;
 b=bjsrJwgCxDUgDgiPImtLBR6GzH6cgoVoOKe32J/cTMTBeLCq4BzUMM5YKQOj/hN3vg
 q2Qnw8B9uZ3De5004Q315kp10M5HjtnL74YFLadkWDavNQ7fItVcud8U0tjQa4rqDS3C
 Gd8LGgG9h0eoiQwHilYN3eLq7Fwvb2ltUPEPZKuH7U41DIxdC6FOphunnXmkQBPZxZt7
 yU+vc00f5lil0suuZ4G9e63Gkcl3P+abfMFjI43BbwOpR+Ds1XXNe4JjTkgyOHNgLSQW
 hvVJUecuf3KdNRPCz2wihFdWyqWz33Vj1fwiOrBGEXa1Tz0k7tX8umwe3UY/HGu8Ntmu
 G+PA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795124421; x=1795729221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dh8hPARkgkUETdolih7JoovnBIYD0QkI16GrSMzuIaU=;
 b=eg8JmYYKxdVSi+7BU3Mi4PiqO95lf5Q+Inx3eU9kHZdD3eVmefYH0lGmJkHv4JB2Q6
 h6dBY1bsmsYkoZXeQ0y+TzxcXC0ugWlRGrxbNN0/WPQObNfHmwExAp/4ZXNZfZRfWOuw
 69tJ3dpcK0g2pMqsZ3viUaZCu7dfT1ITAYoiCFHFOZ8NzGjGL7LabMh+SjTsRWpUwf3m
 sQTl9K7kNfOWSOrM39XGGwerYZpunMM1yjVD4EYS3zOMvwxmjuqEwRBCBHU7+a/WrkA1
 Ywz5SQKRiwJlHAHnZcuGEYLLoa2/7V96+CtzcWLSzlBXpC+qHNjo5nUMMhrUzG5KjCi0
 bs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795124421; x=1795729221;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dh8hPARkgkUETdolih7JoovnBIYD0QkI16GrSMzuIaU=;
 b=1rIckA4ooSkkPH47GK2NWMW64lVt6Qu8QremjEjGewaoxPm25TSuMqPtIXDEqZotHH
 d6Z+ruloNURKaYK+mVKu2YEVExeevU4eq5JqHyLR8wvDHTgr19ReFG7VtfVSDWm/3I3p
 s+nSUf9pgNGgpwlD9Nv03K083ePWGrtFnIAzgb7GCbgoMbFqhRUhao/K77vU5iNqTZiT
 MqAM8VhMzkMrjsGpH4WKRWOR9OYFYpjgI3a2EsSqrJ8IfQdmM7zSFD/7oyvzeHoBS3iU
 9F924TEp0H6Keg4dYK6LlHI9z/vzVl6czMCj2xX2+hqlGqE20ZUZy0QfKTKmQvaQE38s
 QNaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFBJgiQMr0VdRIjM0xMJNy+xhUwjKm/xhEiGmytB6O3hdhKop4/UVXNDbC05mUEjptklpiAbByI@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8l4D4MW6ASSAaQiy9oZJhS3qN8VyQbQcLuYg31hvO/56QEpQcF
 wSfbmg/x8BV91zaGkKTROHRIsJWrZnVQwPWfD4rk3gk2LazEL7FG5Z5ISYi6WBgwvHdLEIHPjwS
 e4y6VEMIBEMrT1czcN2n4jffka+wneMc=
X-Gm-Gg: AYBFou3Ibgsjz/F07QyD0P8qruT02fvHi4yD+QaGe8eMwYrzbHLPzZWH/K6reDEoL2m
 TOQB6hkpX2hfP9JMY7ZC0/RkdQUZqDOkPbmSlvhPZlXIirWYzZQNv1UuB7JzlZvFo/LqRVhfFSR
 rKI3AeUcOAICRmjeztG3WuZKrBvebgK4Vt68MSmk9FL5g/FrGlSL/IJ0dKEj9IV1XoUOnyKPdJM
 kIA6H0tdpovRdKoCugX+oSzNl1SvLNgRRl87Fd3a1wjcSZkVT+SxaTDBOfkIOxlfjE4uHS1ne7M
 QgqifkIIZQBAwQOwwcsRP1R9PMPBJNLOUSXm3FvD8UBhPhiuAtZ/CbCW52mUuwDjVdf2duWpxQh
 qoMhI1a7m3jgj1h+tETEUfuN5T/YwNTDXnu0xPqw3UA1T6nMIgwKXeVashBrUODxHiZ7InFO3ue
 RTk9jGqULc2xXbnxc5I5WoG8DH4/wSIbTUvUMsnzpXbTCzWenI1K2U63EF9tzKCmdyHfduKsTd6
 e23miG2
X-Received: by 2002:a05:6808:1997:b0:4e9:73ce:e2a5 with SMTP id
 5614622812f47-57a0cae51ddmr1946320b6e.6.1795124421207; Thu, 19 Nov 2026
 13:40:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119195553.GA835692@bhelgaas>
 <73e3f0a7-59a7-47f7-9136-9d0b2660c4c7@amd.com>
In-Reply-To: <73e3f0a7-59a7-47f7-9136-9d0b2660c4c7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Nov 2026 16:40:09 -0500
X-Gm-Features: AclHuK-ewSQRrgR13aE9Un8Yxknw3RfIgY0WWBo41PX4kT0S2asNr2h93nN3-9I
Message-ID: <CADnq5_MA9qEPSX_Bt-WToDh2x5R6VoTKxt9GAazsPcX3aBQXOw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Cache bridge firmware secondary bus number
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, linux-pci@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 4:31=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 11/19/26 13:55, Bjorn Helgaas wrote:
> > On Thu, Nov 19, 2026 at 01:21:19PM -0600, Mario Limonciello wrote:
> >> Drivers such as amdgpu and radeon need the bus number firmware assigne=
d
> >> to a device to match it against firmware tables like VFCT. The PCI cor=
e
> >> may renumber buses (e.g. with pci=3Drealloc), after which the runtime
> >> number no longer reflects what firmware programmed.
> >>
> >> Record the bridge's secondary bus number in its struct pci_dev when
> >> pci_read_bridge_windows() reads the bus number register. This happens
> >> once, when the bridge is first enumerated and before any renumbering,
> >> so the value is what firmware left at FW/OS handoff. Devices behind th=
e
> >> bridge can then retrieve their firmware bus number via their upstream
> >> bridge.
> >>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > I assume you'll merge via DRM?
>
> Thanks.
>
> Yeah, I'll merge this through drm-misc.

Might be better to take via the amdgpu tree since it affects radeon and amd=
gpu?

Alex

>
> >
> >> ---
> >>   drivers/pci/probe.c | 1 +
> >>   include/linux/pci.h | 2 ++
> >>   2 files changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 9a178e0e5f7f4..89a7c52ac3e5b 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -513,6 +513,7 @@ static void pci_read_bridge_windows(struct pci_dev=
 *bridge)
> >>      res.flags =3D IORESOURCE_BUS;
> >>      res.start =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> >>      res.end =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> >> +    bridge->fw_sec_busnr =3D res.start;
> >>      pci_info(bridge, "PCI bridge to %pR%s\n", &res,
> >>               bridge->transparent ? " (subtractive decode)" : "");
> >>
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index aa3765a20a96c..4c1b1e557a607 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -363,6 +363,8 @@ struct pci_dev {
> >>      struct pci_slot *slot;          /* Physical slot this device is i=
n */
> >>
> >>      unsigned int    devfn;          /* Encoded device & function inde=
x */
> >> +    /* Bridge secondary bus number at FW/OS handoff */
> >> +    unsigned char   fw_sec_busnr;
> >>      unsigned short  vendor;
> >>      unsigned short  device;
> >>      unsigned short  subsystem_vendor;
> >>
> >> --
> >> 2.43.0
> >>
>
