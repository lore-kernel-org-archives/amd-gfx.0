Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B8DC07E9D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 07:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A1C10E5C0;
	Mon, 26 Sep 2022 07:33:40 +0000 (UTC)
Received: from ach1ajh116.fra1.oracleemaildelivery.com
 (ach1ajh116.fra1.oracleemaildelivery.com [138.1.108.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D82710E1C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-fra1-20220101;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=ndCYhNAZBZbgHcU18FVTrsBX5+3mkgNgpLzef++0BQU=;
 b=WFXGBT/rlEKu5laIFfFKgd8vFhz42tQQc4MkZ2RnsRTyFQ9WUfSreGMFUozstItmkMzxhU6T+GWm
 pId3LY53WLKhw7dMbhZhO7+WwSdOrceQSZ5Ir3VBTus/RJJ8BGJu4H0lSExH31XQl/O5EF2m0/v8
 XlqBZo02Jr9Md8Okw1CBbpABqMJnfOKhlPmSWQB10OrSCPpMz4JLDDcfnRa0CR5EfH411BpgzBfl
 u7GHlC3Z8pfWltB15580aTr0la0177Ptm9dszDaosM19ts5VDasEwuCrEW4rtx0vKGf64+AFu6/w
 qsNPdXoYnj3319VOnsjZAZIYlgWOJSNFUVeKdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-fra-20191115;
 d=fra1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=ndCYhNAZBZbgHcU18FVTrsBX5+3mkgNgpLzef++0BQU=;
 b=YShm9dfRt5NcsTk92nfsS2E8sP3EmKrfhSdE4rp4TeDYc9sbnZUMtNacW73CqsxUn65vTmhK3CRS
 en4iTs6nfyWltzRoXFCl+w0EEzUPXj9+7AqjHG4NufbhU+lsnbY7iZV1rZttuuXk9HDek7+nhNJ1
 l/bOsQBacVyV1Tgp9HknyW2Cb7VkUoPsUSrlbSUt9nX2U0UR9eIoXM+k3b4bG4EuDtwAr8oaQEo+
 2TN39mPyY9wehHaBydo+0WrHkUEQJ5nM2dloh4Z8ic/qeGZkTQ6Yjhdg1RhC0fmCZvwIGxIWv4C4
 5ihnQHNFZ/zAhKtgkPf5B5bj5uinAb+vLY5dOw==
Received: by omta-ad3-fd3-302-eu-frankfurt-1.omtaad3.vcndpfra.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20220914 64bit (built Sep 14
 2022)) with ESMTPS id
 <0RIO000VHJGHDL10@omta-ad3-fd3-302-eu-frankfurt-1.omtaad3.vcndpfra.oraclevcn.com>
 for amd-gfx@lists.freedesktop.org; Fri, 23 Sep 2022 20:26:41 +0000 (GMT)
Message-id: <ea1f1d81-650b-768a-30ab-c9d7d9f9fa54@augustwikerfors.se>
Date: Fri, 23 Sep 2022 22:26:35 +0200
MIME-version: 1.0
Subject: Re: [REGRESSION] Graphical issues on Lenovo Yoga 7 14ARB7 laptop since
 v6.0-rc1 (bisected)
Content-language: en-US
To: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se>
 <eee82fb8-0fc5-98cb-e630-f86891574f21@leemhuis.info>
 <CADnq5_PRP3ekHPLhdXALxt9GL3aHHZQUw5TNAwm4t+ggimUq7g@mail.gmail.com>
 <33cf5071-3157-a3c2-3252-3a8ab926c60d@augustwikerfors.se>
 <f4818fc3-7015-29ed-95c5-ab6a18da33d7@amd.com>
From: August Wikerfors <git@augustwikerfors.se>
In-reply-to: <f4818fc3-7015-29ed-95c5-ab6a18da33d7@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAEOL0javX7vJbTonMYC2eM4teWqEd60MX20U+3Im6izcE4iNa76d+RAkf65cWfX
 p514OTw7+zyMCBtIa6gaDTMiMR2v31KQAxJrhMTN8BXaqmiK7HM5ZVSh0EH7ZZEc
 aqEqUjEYyWnoRxw41sw4L97Eziwy43WOcgg/Ev64F5PZem3/ZAnlcAQl84J17V5v
 lVuNHqXrm3P3UNmuoB57fkqc7AZZ0gLLpWMP17WOsYUZSmjNETTx1SN3uuo/n5tg
 66UaK4xdhgweQbxFxy4DaVVV24bWzEL9SiTWHpX1LgWi1L9e2EuOXoPCV+VXrARh
 u4fwMMU7KzqOyhry1zVdu6q2i5oow6qNXK6Oh5uFGy7AFc2YmrB9UEl8XqMQc3SU
 ApCsPm8eJSN1uNyBFuDxHltJdFVrKsxWXPPj3kN8zvUXF7QR/bVuLuD6lG1qzAFx xhhF+/cpvSc=
X-Mailman-Approved-At: Mon, 26 Sep 2022 07:33:28 +0000
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
Cc: regressions@lists.linux.dev, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Leo,

On 2022-09-23 20:41, Leo Li wrote:
> Hi August,
> 
> Can you provide a dmesg log with drm.debug=0x16 enabled in kernel cmdline?
Log is available here: https://files.augustwikerfors.se/dmesg.2022-09-23.txt

This is what I did during that log:
1. Boot the system
2. Type into the password field in SDDM (this is when the problem occurs)
3. Switch to a TTY to save the log (the problem doesn't happen there)

Regards,
August Wikerfors
