Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E71C27C53
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Jun 2024 19:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9A010E22D;
	Sun,  9 Jun 2024 19:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; secure) header.d=glanzmann.de header.i=@glanzmann.de header.b="qpBd76mk";
	dkim-atps=neutral
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8552E10E0BA
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jun 2024 04:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
 s=infra26101010; t=1717820208;
 bh=a/1BslFuQBjT+587aQj+A1QnMBSxBJyMrEf3omJ4Km4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qpBd76mk6TEq3hOFHxy9SLKiuo01IrXFsY8+el6r7KpZQQf5xkvuX1dkWYSL05PNK
 BPD8vSglBEhLuTMTb5GJeZXKOn7eFI9XeO3CRFF0yfMU7fesA9HHV7Uo9eeTvHgjHq
 k4WcR3ErZaybcgEOMC4RuatdJdWUk3HkLjhEQxJiWThX1yij92+DLYzX7z2lmk+twR
 NNjFfGYe0NzJ2f6v+HZHXeTm7QZ0o4XXF4g1Tu9ybojI5t61+67iWhr1RZkhYyEpGc
 vuvOeWPJBzYVrOLBsxU/lRPyDLTG8im1Dax+odnNfytkMy6CxcWfC+OXBgJHT6c2e6
 iQ0drNrEx7Shn/UL6ulJqmjAoJLXHssdrqEMchWV++KEFuzAWCYqtOb5PGPDFQEOhO
 Z0Ejbvf6VCkugsHOVsOthFjuaUF2QfFmDAY4Vj/Bk73Mvq9Judp4D9vKjzZ0CrSkhq
 nIywm+E0j7LDapOuUah4e6jkLL9msp7YwAI5UwCKwQ68QxdZvZBEsuAkbrPX9rK6K3
 LNigey1pZNnszL3LktBTKEh2Mm5mfLOEm7yVL2423GZvHRm85h91HsIZKmwaVUqbEm
 wrb6zeRa+odxFfsfhSuU9T9tG4gPcLG57LZ2GW6mLc+I2sAtncV9EP6l1js2UVQ5TZ
 jN7NTsRXeBu/+FwjHSvXHDmA=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
 id 943967A800DC; Sat,  8 Jun 2024 06:16:48 +0200 (CEST)
Date: Sat, 8 Jun 2024 06:16:48 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory
 with ring turned off.
Message-ID: <ZmPbMJQ1mAGSqTek@glanzmann.de>
References: <ZmKSGSvm91qXzN_J@glanzmann.de>
 <BN9PR12MB51464A7312B77085E72C468AF7FB2@BN9PR12MB5146.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51464A7312B77085E72C468AF7FB2@BN9PR12MB5146.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Sun, 09 Jun 2024 19:36:30 +0000
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

Hello Alex,

> Should be fixed with this patch:
> https://patchwork.freedesktop.org/patch/597421/

works for me.

Tested-by: Thomas Glanzmann <thomas@glanzmann.de>

Thanks.

Cheers,
        Thomas
