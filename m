Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDAFEE49A8
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 07:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD94610E201;
	Mon, 21 Aug 2023 07:46:05 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9533110E2C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 21:24:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7F8836340B;
 Fri, 18 Aug 2023 21:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E71C433C7;
 Fri, 18 Aug 2023 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1692393876;
 bh=Wdz4oVuBLe9dL/FbEM8zLUrqIvKI32lgagofb0qvY6o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qCq6FBHKwur8aDhPsmBJ8x7a/pO6VKC1iTCOZWMlrV+nEghj+H0DqAjTnOlZUR00P
 OdozVSYiigsj0UhUy+ly+qwBkX+RJEOGfUzAj4Hwm6GEpTCj7+gItKltc+AVOsfrqs
 5g3zd+1+RH9uR0hpRVYfZeJOm9UwkwF1061rIaxY=
Date: Fri, 18 Aug 2023 23:24:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Evan Quan <evan.quan@amd.com>
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Message-ID: <2023081806-rounding-distract-b695@gregkh>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818032619.3341234-2-evan.quan@amd.com>
X-Mailman-Approved-At: Mon, 21 Aug 2023 07:46:03 +0000
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
Cc: andrew@lunn.ch, rafael@kernel.org, linux-wireless@vger.kernel.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org, edumazet@google.com,
 Mario Limonciello <mario.limonciello@amd.com>, horms@kernel.org,
 netdev@vger.kernel.org, alexander.deucher@amd.com, kuba@kernel.org,
 johannes@sipsolutions.net, pabeni@redhat.com, quic_jjohnson@quicinc.com,
 davem@davemloft.net, lenb@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 18, 2023 at 11:26:11AM +0800, Evan Quan wrote:
>  drivers/base/Makefile                         |   1 +
>  drivers/base/wbrf.c                           | 280 ++++++++++++++++++

Why is a wifi-specific thing going into drivers/base/?

confused,

greg k-h
