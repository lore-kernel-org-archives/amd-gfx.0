Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B78C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 07:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB9410E696;
	Wed, 10 Jul 2024 07:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=glanzmann.de header.i=@glanzmann.de header.b="ElOsO9xZ";
	dkim-atps=neutral
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF64410E0D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 05:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
 s=infra26101010; t=1720588763;
 bh=XXRXNWo56R1hZllazmnsPdRPBXg84OpZEhrR3JAevnQ=;
 h=Date:From:To:Cc:Subject:From;
 b=ElOsO9xZffROmIFHVOuiOD/t8w9jHAtXEwheCnqyqPxn5QVUD41+dFI5YGqCMDJTv
 qKgb8XFXsZWwhb8UWjDbJNiEXpR8ySOSZgbRbuCWbg+qnU5soCnAitKarkxE178bmQ
 Q9TEbmpq3hqInio3dIg5BiG+dPC38DrP9MpU6Ow37gK5+VtuMD0Ih/Fw2pzmUov16+
 c3QthgW1XXFEqnIpfIlVC1u3OBrywrnBlxB+KZa/CaKkw534n9rVbIV0V0ntq7+NjN
 ihZEBsUIkI82sR6nt4nMD3ZWT6TZzgNy6q+jKpj9qgfyGUfwFaI/87Y5LSDaG3cv+R
 xvP2DKXndiG6e8Ha5g+KapB8JDBxfSi1I6SmoQXF6Bn+ylggXM+zt1l1Q7J29Ci2wt
 DdV3e65jz3w2L2JgmnPlkt6rDGuuupUX33fb8dB+x9tEO0FNLdEN02VxmjqbtnbdL7
 2GedGN3T4Xv3YfdPDolfsSf1S8njCWJ9kKdgzOv4LkVG763TniFWibSD80vBdkXLGD
 FzNcvHtWstiU5C9mpab/yzTSXoSMyWzaCgRra1eE6k/pVgSKtM82xr1kKbUZt2x9++
 t/Lteyn8zsfDHJhiiOhSkZXjapgbfzGt4SjmC0UKjBrkBO/1SLlGt1Zx6ptLt+4efS
 snhIqKiC/9jxxbkqOaKPt6zs=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
 id 9D2ED7A80095; Wed, 10 Jul 2024 07:19:23 +0200 (CEST)
Date: Wed, 10 Jul 2024 07:19:23 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: amdgpu [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error -
 collecting diagnostic data
Message-ID: <Zo4Z2yCK4RrYtJKo@glanzmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 10 Jul 2024 07:13:23 +0000
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
I updated my system today to Debian trixie and noticed the following
error messages in my dmesg with 6.10.0-rc6 / 6.10.0-rc7.

...
[   11.902016] amdgpu 0000:0b:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic data
...

Full dmesg: https://tg.st/u/a4718085a69c253aeac68f7f55e0cd5c537c49ee7aa6b7793b8eca65bb481675.txt

Also I noticed that X takes between 30 - 60 seconds to start on boot.
Before the update to Debian trixie it was ~ 11 seconds.

Cheers,
        Thomas
