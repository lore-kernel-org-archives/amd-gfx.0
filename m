Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD9EC47073
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Dec 2023 16:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C28892EA;
	Wed, 27 Dec 2023 16:12:40 +0000 (UTC)
X-Greylist: delayed 439 seconds by postgrey-1.36 at gabe;
 Tue, 26 Dec 2023 10:06:39 UTC
Received: from qs51p00im-qukt01072502.me.com (qs51p00im-qukt01072502.me.com
 [17.57.155.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988E710E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Dec 2023 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; t=1703584759;
 bh=nTSG8UvRj0SnmBXP6fDaupYIG5SUl+AGsX/yawYM2qg=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
 b=n8oQWuMdaZjf4i10MIFxvkkEGthvfTg1LmtsoGnQLJU5tsXZ+Gfu6V74lYym7yMUB
 yljR/BxyjE4HAMx4zrPWNAP0YTlMoS9oZlGFXOdJp/hCFZcNcE04L8+qehLMkt+joX
 nwhUDWtLPNXD3W7bcKU9k6goLkYwVD7Jgq99K35NXeOj6h2uubiYFiyNvKwG/VvDu1
 ylAjYLtVSV93wHLxKeWEymtowK5MnREoZaxI+ig79L2/6JG+YdiVFpD6x0PdNgFS9e
 ybAodXrZ93/b6uG8NsH9d7yEtmEoFRSWrD+az5T8YeEMISKln2x5Y/2ZJI6aOw5aEG
 hebrhXlz5FMdw==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com
 [17.57.155.28])
 by qs51p00im-qukt01072502.me.com (Postfix) with ESMTPSA id 35BEC6EC01B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Dec 2023 09:59:19 +0000 (UTC)
From: Michael Roitzsch <reactorcontrol@icloud.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Additional resolutions for virtual display
Message-Id: <CDE9D7C5-36F5-47B9-A3C9-B450EE0856AB@icloud.com>
Date: Tue, 26 Dec 2023 10:59:16 +0100
To: amd-gfx@lists.freedesktop.org
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Proofpoint-GUID: T0mDk9Hpk4qItkMOZzWYImMBEQmI5R5o
X-Proofpoint-ORIG-GUID: T0mDk9Hpk4qItkMOZzWYImMBEQmI5R5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-26_04,2023-12-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 phishscore=0 mlxlogscore=375
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2312260074
X-Mailman-Approved-At: Wed, 27 Dec 2023 16:12:36 +0000
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

I am using the amdgpu virtual_display feature for display streaming from =
a headless machine. However, I need resolutions other than the ones =
available by default. I found that I can add one mode via the =
video=3DVirtual-1:=E2=80=A6 kernel boot option. However, I would like to =
switch between multiple non-default modes.

Is there a way to add more than one non-default mode to the virtual =
display? My current workaround is to patch my resolutions to =
amdgpu_vkms.c, but I wonder if there is an easier way.

The resolutions I need are 2x HiDPI versions of ones already available, =
namely 2880x1800 and 5120x2880.

Michael

