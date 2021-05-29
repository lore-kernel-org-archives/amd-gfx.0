Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B943BC4708F
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 08:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8C7610C8
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 08:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8C7610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156E46E87D;
	Mon, 31 May 2021 08:17:29 +0000 (UTC)
X-Greylist: delayed 693 seconds by postgrey-1.36 at gabe;
 Sat, 29 May 2021 12:41:01 UTC
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CAD6E16F
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 May 2021 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1622292058;
 bh=qjHm73v3dGQmzJZHlvrVW1oQb9sbygrVOZh13TpYGC0=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=WiMZWOMFTx6+HAbxFmAQiOQIaTL1tjzY/Ps6FNRVouuzqJ74erposZlQaqvfu0S7B
 AkJiIfNcYJkYMMdmsdg3b+dQy0DWWYsnhNIF4cFIs8qOUmBVhMto3g2vVjmoVYG3gt
 wIx2MsU0lXGow8hrksTU/pjoietrG8sy057Bs04Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from schienar ([92.105.189.242]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1lKG3x0IFH-017Fb3 for
 <amd-gfx@lists.freedesktop.org>; Sat, 29 May 2021 14:16:30 +0200
Date: Sat, 29 May 2021 14:16:28 +0200
From: Julian Wollrath <jwollrath@web.de>
To: amd-gfx@lists.freedesktop.org
Subject: Re: 5.13-rc3 Renoir (ChipID = 0x1636): error GPU reset, fences
 timed out, failed to initialize parser -125
Message-ID: <20210529141628.1951ee33@schienar>
In-Reply-To: <20210529134054.099661dc@schienar>
References: <20210529134054.099661dc@schienar>
MIME-Version: 1.0
X-Provags-ID: V03:K1:lLkritVMHFPyfMt2ztZ0K8fgg7jVTeD4Qc2QHKR4lEfeuLjr6eR
 qZknbpxg+/g3nbVnvtatUlNPLGnz7SesVQS2nxk+jcjBKcpLYyU17GE0MIgV6jYKiqLMLyj
 ndEcnerAmLgW3rcqmI2I7gmFwANDLEzZ0TSIAcYa50QqwhYjbxLrW+mnliGNZl1o/QJ08Ya
 6ddb9ZXOlJT6kdME+M6Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mOGit2t+Lbw=:2h9G2l2trGIXfO6vei2rgD
 fAYMenkHcHmtHiZ5HfS4pFdOWwoj4ERU3CskNybFmjKwYvZacnhavHzecjSpoMNkcBD7fVuby
 0PQnz+hCCY4bN7r06xU7FDcANhuQdQcflL53GQO/RhlsvgECroIB2Hp+5iQnZSGKMoMLvzsJB
 UtxAurd31bfZwWEcWVkJMb1XdJOao7Uz3SiUMJLhmXWfKWppZ6tQTyZtgO+I+y1GVwHiHKdWP
 LRTQNInDnHu2ZsN88tJnpOCS6YokFkJQKF96g1UBWS25qmjIDX6KcVKLILSjrkGMZ/wjR0bA3
 HQTnCs2Zxgds293nP2RzVBWGMRxl8vJ2OZRSNueP0EsTkgbi+G6ho5KzC+CN08kIPz6OqiL5x
 11YqLIGnBffZ0kKzfjwp/QrkPyEcYt4FYbZpqr/JcV0TB1zRp/x99l7FEL34ZCbc128RsjAfO
 gT/r2fO3FqGB2tMynSJjX2Q4DTIEHTZChLDa4Y+FjgXVTPuNn1OqpXjRODtlDxuE8fRNhaej3
 bxLYn5guz8/oOmjnqCz46fz13xkCp6TsedkGjvdgaFsS6sraCMIAa2YHxalwFcKzx/YwTyUwz
 hXNAmDGFyaiav6OBsywHb2XkD/lxwME6wkrJQIY2j6fBTdxMYj4PuD8RBjGOfQl2F+0pY7Srd
 DmwvO3q7RFNYReaHxq6EErmTf0xldyYhYrE72WBRl7KEr9G/+GNFtXV1cpkA3Y15AcfrKJbWs
 w5iyuDGoWsiQTs6nyBu3gYJxImUh244eYB2gCIjF0gayMhZFylrQlab94xdsAZ5QACRBUsebY
 t6A9e1zjun1fB+Fyq1wX2HSQ6zKygeAH7FczAZMB1ef+bnRQQTpEK2EibenprSflqWSgIhF1I
 Q5HzcDji/CwCpkcvpE081D6iiOW6nOoWKt47Eo7jLUiCGCG7Hcx6e+FN5Vyuy6XBKFlF68YPA
 S/IAjEZ0xypxqakwLy6g29beSCQTnMRDtG53dyqmhTTEM8/OI9MrffazyNHFCQx6/pFcgUW+7
 V11f6RvPP4vIXd1HxpIPN3essC9YIZ0sQPcDf7lzU44rfpr8aBV9Fhx/0yqyUeGW6xMFGpiKB
 fLioo8oK+wvJHFlrSIG3Q0weTkcTWXPN5tNOACS4GIFRwrXLciifAQ6//4UnGt1ezq6n0LjZZ
 nAqXhPQpELip3tyTJsiN+AA4MAo2/4g40g9DZSBzcMCAipCksRnIxsLExJ94pWN2mF1mo=
X-Mailman-Approved-At: Mon, 31 May 2021 08:17:26 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

> on 5.13-rc3 with a 4650U (Renoir, ChipID = 0x1636) I am able to
> reliably get the GPU to reset under X11/Xorg with the amdgpu driver
> (current from git) and having persistent problems afterwards. I
> achieve this in the following way (using ROOT (root.cern.ch) to draw a
> histogram):

p.s.: this also happens with 5.10.40, so it is not a recent regression.


Best regards,
Julian Wollrath

--
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
