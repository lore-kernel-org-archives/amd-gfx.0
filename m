Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB07C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 04:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC44C611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 04:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC44C611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vfemail.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F7DA6EB22;
	Fri, 16 Apr 2021 04:48:50 +0000 (UTC)
Received: from nl101-3.vfemail.net (nl101-3.vfemail.net [149.210.219.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FCC6E038
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 02:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
 :to:cc:subject:message-id:in-reply-to:references:mime-version
 :content-type:content-transfer-encoding; s=2018; bh=sPy0NxsKGPgl
 wTY38mvRLqWSwJOlEQ0zIlv+0exAHp4=; b=CXcmsaj5zGUhppNE7lzk/1EWwvNs
 qY/LKkUB0p4s0FvhXuXJd/kkgH8Booo+mjhgblEsmtWTS7pq9WwBSPv12O8XPbuS
 N6VgrZLdYJJQwKzQZ5c3Ccp75/WLv3juXe6iKxNf7TF0o8ug6Yy7UHjNMuTV+KxP
 Kjl5LN1qHDkzaBo=
Received: (qmail 27897 invoked from network); 16 Apr 2021 02:16:30 -0000
Received: by simscan 1.4.0 ppid: 27874, pid: 27884, t: 0.2930s scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=)
 (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
 by nl101.vfemail.net with ESMTPA; 16 Apr 2021 02:16:30 -0000
Date: Thu, 15 Apr 2021 22:16:26 -0400
From: David Niklas <Hgntkwis@vfemail.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Regression] amdgpu driver broken on AMD HD7770 GHz edition.
Message-ID: <20210415221626.3a33787f@Zen-II-x12.niklas.com>
In-Reply-To: <20210415212508.7ef57d73@Zen-II-x12.niklas.com>
References: <20210415212508.7ef57d73@Zen-II-x12.niklas.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 16 Apr 2021 04:48:47 +0000
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
Cc: alexander.deucher@amd.com, David1.Zhou@amd.com,
 dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey,

I forgot to give you a bug tracker in case you want one.
Here: https://bugzilla.kernel.org/show_bug.cgi?id=212691

Thanks,
David
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
