Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1C8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 13:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEBB610A8
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 13:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACEBB610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B5036FF6E;
	Tue,  2 Nov 2021 13:24:20 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2DC6FF6E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 13:24:19 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id bi29so19559569qkb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:reply-to:content-language
 :from:to:subject:content-transfer-encoding;
 bh=Vs+RW+QmTfr6AAClFz81xOLAzPMRULeQRqQGsGTra2U=;
 b=Rvg6I6vPxbqFVgijqe2IYAZazDTyuEg0RZiXH6fAtXatmvJqtw4zT/kxqKdTFFc7GX
 1asW5JKegxmfmY4aknHiUV6dQA3Nt4X1fzEGEpd++Ddkeqy8qIJC9pRRm1PQGTR7V/g/
 aeWcT9/ygMK6hqGh4mFldemmpydboNgCGb8wYMMo0AhgSBNHpOX2806gbQLOrXppkMBw
 TiidmUfaoycFbVCNljl1Ec7oTpQHRkgK0Q8PKI8ShWOxx1abkYsrldcD71G8LJk+1Zxc
 oi7lqXXjFIMIMpu40VU9FhDJp0boMmHD8TDH5I4mZYWbVetv+86qfeuFUhwli30copIL
 z6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :content-language:from:to:subject:content-transfer-encoding;
 bh=Vs+RW+QmTfr6AAClFz81xOLAzPMRULeQRqQGsGTra2U=;
 b=7f4u6NBwUY6OBwHiTj9ihSTPudrL7IkMhYKtIRoUGp4FMw9h5qDL1hW5mNA9ISmugs
 t2NAhlIsy9az15bjJIWi2AziCUcwwvjD4WQebjoQCaMr8Mc5D1Ak/VGyHY9mHyM2nXb/
 UIZZukbVGyXyyccBVSozHh9qIuGXW6GeMNBRdMOxy5ZsrcXMj3sa3MnxortEIABUeAeE
 as243uhZ7SJzQmuQm7R9rMO+O7tFcEe6po4f8QDBDKFTnjVSoA62krRpANCN9wLBxb4t
 jMPohcC2PsRT0jomY3Nlx+VFSA9+9flqnGe88hhff9Cx2AD9Y0v7nKNbXJsSYYZKg+yU
 a+Dw==
X-Gm-Message-State: AOAM531sxs+jvnkUx09rowkRHG91Az9dVaWI4p0Ry0pszt+rTFBev1SA
 w3Ki4GroQd+nxWAQvchU0+bKlApCYL4=
X-Google-Smtp-Source: ABdhPJxpIFgUF9Eq2N5uzi7SbJSkgJEESuUmO2HhWjSKn4+T1PumlW9223il3iz5VM6ONgM7V/RGAw==
X-Received: by 2002:a37:2e87:: with SMTP id
 u129mr29109496qkh.208.1635859458198; 
 Tue, 02 Nov 2021 06:24:18 -0700 (PDT)
Received: from mua.localhost ([2600:1700:e380:2c20::49])
 by smtp.gmail.com with ESMTPSA id r13sm10084205qkp.134.2021.11.02.06.24.17
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 06:24:17 -0700 (PDT)
Message-ID: <446fda20-a635-3b00-4886-661fff4ab0f2@gmail.com>
Date: Tue, 2 Nov 2021 09:24:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
Content-Language: en-US
From: PGNet Dev <pgnet.dev@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: amdgpu support for Ryzen 5XXXG, with integrated graphics: is it?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: pgnet.dev@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

i'm running an AMD Ryzen 5600G -- with integrated graphics -- on linux (Fedora34) kernel 5.14.14.

its color output is wrong.

i've reported it to AMD support; their response is that it's ONLY supported on "RHEL & Ubuntu"; they suggest I switch to Ubuntu :-/

i've reported it here, on list; so far no response -- either from *@amd.com, or in general.

before wasting more of anyone else's bandwidth on this --
-- *ARE* the Ryzen 5XXX-G intended to be supported, and known to be functional for general linux/amdgpu usage?

