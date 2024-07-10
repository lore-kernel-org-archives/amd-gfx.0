Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B722C3271E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 07:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BEE10E979;
	Thu, 11 Jul 2024 07:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=glanzmann.de header.i=@glanzmann.de header.b="jOPNXuuk";
	dkim-atps=neutral
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933AA10E865
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
 s=infra26101010; t=1720634614;
 bh=9o1nZukWgMgh1glhxVCcsAECujJFXkWG/FS0pOTW54c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jOPNXuukb60apfsmuUcqzf3pWdaSyzFPvb4VfmuLNRlr/HQI7Jc5Z7A/HFStBpwTQ
 uphzek0ymjBul3gLxfO05FKreKuxasfUW58nX0w6NidnHwRALxX8DFyHmON0xtz7EE
 Q13LO+gmr76GbnhwAmB+9pG0nO7VQurvrIZ64bQrz/v/uVE29A5XkzeX2vrkKQ6kf3
 ZIedbNF1qah5xD/+kiNYCEjXgcT8hvii2NnddfJ9T60HMYhXT5rfjFZsC9+Za1NvEn
 5XDV6VRxy8OSvhz4llp5dnbkbYcqyWgNqCnKSTukyaWhqw3/GKAI5xdMhhUtI0Sdye
 15fTUXJLhngCf6U1Qp1C3vTtMW3ra8XEzFVbgD723sxNJSvF4hC9IbioPpg7hJnLxF
 AMpHJ+0l+a8MVrssWybwnx/SgIvvvjKel2J3l4FYUbh4Ki9Vhw2rhPfHuZNzjZEDKW
 vKS1FL5+8pSHjRzw4hXYM2zi1qGo7OeeqXUoZaXwgd1KZvlC9Nik3nssf1wdUU8X6T
 a9PFCO0upIDBV3i7tM+K2yVCmT5A9RFv7jLersVZkShRHS5PvKR2McmrIfQPaejHHg
 vfeuhNqSGLswFy/SnFmFeM5eY/uqVwFjL02mQKDHPErpxESoOznTWMaaOrkOshalVF
 Xfd9hAhI8Oj+wUhmVfSv3Bfk=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
 id 97EB17A8009C; Wed, 10 Jul 2024 20:03:34 +0200 (CEST)
Date: Wed, 10 Jul 2024 20:03:34 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB
 error - collecting diagnostic data
Message-ID: <Zo7M9us1xwUdYaP6@glanzmann.de>
References: <Zo4Z2yCK4RrYtJKo@glanzmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo4Z2yCK4RrYtJKo@glanzmann.de>
X-Mailman-Approved-At: Thu, 11 Jul 2024 07:18:56 +0000
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

Hello,

* Thomas Glanzmann <thomas@glanzmann.de> [2024-07-10 07:19]:
> [   11.902016] amdgpu 0000:0b:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data

I resolved the issue by updating my firmware:

git clone https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
cd linux-firmware.git
sudo make install
sudo reboot

Cheers,
        Thomas
