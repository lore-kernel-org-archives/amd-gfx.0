Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F71C3ABC9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 08:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E0210E514;
	Tue, 13 May 2025 08:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=nordisch.org header.i=@nordisch.org header.b="mr+0UuJB";
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="c/Fv6QMh";
	dkim-atps=neutral
Received: from tengu.nordisch.org (tengu.nordisch.org [138.201.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F8010E476
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 18:17:53 +0000 (UTC)
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
 by tengu.nordisch.org (Postfix) with ESMTPSA id 6A0ED75AB1A;
 Mon, 12 May 2025 20:17:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_rsa; t=1747073871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7C+IqFAnduKOsEIdx5Dnqcx1MlTmcKCBi2j6bEthGU=;
 b=mr+0UuJBHcfCCms0qMyT9ItFY2i5GrRhRTCLKqQyaw+3/afKyIIPuw4M2/kDypkhTzKjUn
 TVXC0k2aO8zclVmGrM1N9uOVbjQ4nmMsLL2//Yos95lYGrMsTKRkaSvY2rE6RQQGICxm6r
 w1KdC21OdLEj8B62jOe6xZi/nD2Pf5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
 s=tengu_ed25519; t=1747073871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v7C+IqFAnduKOsEIdx5Dnqcx1MlTmcKCBi2j6bEthGU=;
 b=c/Fv6QMhaqouGg9DxGWMt4Ab1OC8HZibQcxPLF/dn/qndg41BUEuj6dckqY8ce+XeBT6lv
 +j8q0MteqUdeVODw==
Message-ID: <e2ee9985cb880f72751a087f91bf21fa31c6fd09.camel@nordisch.org>
Subject: Re: amdgpu: Reproducible soft lockups when playing games
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <amd@nordisch.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
Date: Mon, 12 May 2025 20:17:51 +0200
In-Reply-To: <45fc722f9b113fe32d29c5f45466b41faff34a59.camel@nordisch.org>
References: <123e013307ad395b3e26c2dd53fb99594191dda0.camel@nordisch.org>
 <20250429130929.GCaBDPiT_CwyKmHB5o@fat_crate.local>
 <CADnq5_PBjOYV5TH5EDXBVvth1ZX6S_TcpDOKOMrbDJUEDzkTww@mail.gmail.com>
 <688457c1079a5cdbb81a0dd21e6d744e72c89101.camel@nordisch.org>
 <CADnq5_OfudYrLEf2OWqhaC2LWVOc_rGBs+NaizT2MfmxU=sZsA@mail.gmail.com>
 <6023ab4f8c490594a882704fa0e1afeb076c2ad2.camel@nordisch.org>
 <45fc722f9b113fe32d29c5f45466b41faff34a59.camel@nordisch.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 13 May 2025 08:15:53 +0000
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

On Mon, 2025-05-12 at 14:23 +0200, Marcus R=C3=BCckert wrote:

> > I opened a video in clapper to take the browser out of the equation =
=20
> > and
> > started working in a terminal. -> kernel oops. will look into setting
> > up kdump.
> >=20
> > Mesa-25.1+git1019.7c4f501e9-39.1.x86_64
> > kernel-default-6.15~rc6-1.1.g42f9fa3.x86_64


actually before the machine crashed it provided some actual debug output!

```
May 12 14:16:57 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:16:57 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:16:58 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:16:58 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:16:58 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:16:58 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:16:58 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:16:58 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with=
 your previous command: SMN_C2PMSG_66:0x00000008 SMN_C2PMSG_82:0x00000400
May 12 14:17:02 kernel: amdgpu 0000:03:00.0: amdgpu: Failed to enable GFXCL=
K DS!
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with=
 your previous command: SMN_C2PMSG_66:0x00000008 SMN_C2PMSG_82:0x00000400
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: amdgpu: Failed to set workload=
 mask 0x00000001
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: amdgpu: failed to set default =
power profile mode
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:06 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:07 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:07 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:07 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:07 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:07 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:07 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:07 kernel: amdgpu 0000:03:00.0: amdgpu: Dumping IP State
May 12 14:17:08 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:08 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:08 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:08 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:08 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:08 kernel: amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_=
diagnostic_data: DMCUB error - collecting diagnostic data
May 12 14:17:11 kernel: amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with=
 your previous command: SMN_C2PMSG_66:0x00000008 SMN_C2PMSG_82:0x00000400
May 12 14:17:11 kernel: amdgpu 0000:03:00.0: amdgpu: Failed to disable gfxo=
ff!
May 12 14:17:15 kernel: amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with=
 your previous command: SMN_C2PMSG_66:0x00000008 SMN_C2PMSG_82:0x00000400
May 12 14:17:15 kernel: amdgpu 0000:03:00.0: amdgpu: Failed to enable GFXCL=
K DS!
```



```
--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.




```

