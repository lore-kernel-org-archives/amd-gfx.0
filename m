Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA527C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 15:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E143210E63E;
	Thu, 17 Nov 2022 15:53:33 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF9410E638
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:In-Reply-To:Subject
 :References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QqtWwqMD4csvdRxHSg56mUZEJ5KpOZiG28Yc7UqUImc=; b=kQEHqN5PjAO3Y+wR8s1Ru5uVWV
 L/SulhhdDDLqBMqVjs8AxazNLkAOr919fWEefkYV5UxxOFBbAVX8shgmNQ57QxGVgqVgKGvdrFADR
 3eDAkLbnVeGnaa5zZwi53s0M+w67fOYRREAAHcGNzrkAs9Y1FSaiZRYTQWizyUC69o1490LOTAyzS
 x9L54P/ZkAxjIfLJV7eQ8jt7VCOr60Jm7j0xteuvJnQtDdTQi9E/F4wkmDW2Ql/rf4k5M4QCd46hm
 avyh0Py4nJ4q7qByc7NkrybYLydkmqnjE+hdzpJSp+SOfX20T3rCjLXeF9SzAenW6RA/h6J5jrEzU
 uB6d3lFw==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1ovh4S-002ftE-84; Thu, 17 Nov 2022 16:44:56 +0100
Message-ID: <1f9d3044-d804-9ec8-45e2-24d2c21f942e@igalia.com>
Date: Thu, 17 Nov 2022 12:44:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
To: ckoenig.leichtzumerken@gmail.com,
 Christian Koenig <christian.koenig@amd.com>
References: <20221116160111.3226-3-christian.koenig@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: WARN when freeing kernel memory during
 suspend
Content-Language: en-US
In-Reply-To: <20221116160111.3226-3-christian.koenig@amd.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 17 Nov 2022 15:53:32 +0000
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
Cc: alexdeucher@gmail.com, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Christian, very interesting idea! I've tested it alone (without
patch 2) and was able to see the PSP code freeing buffers during
suspend, leading to a resume failure later.

Feel free to add my:
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Cheers,


Guilherme
