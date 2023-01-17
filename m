Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF94C677F1
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 18:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A69610E5AC;
	Tue, 17 Jan 2023 18:41:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5861F10E31E;
 Tue, 17 Jan 2023 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kzZmbkn2+LdMFxtNeyl7Xvo+4oh9nHM9XdpmuuW5X+0=; b=WIaS/QqoWOWyxqNxGRqttx/2cR
 9t4u/BL8WtaGQTQuzrkLLKq0bxVBCvYhSFmGFBgXP/OCt8dtS2P008XEvt0zql5I8+Uf0n3vpqsJn
 W9entreFNnfZu1e3gVBUiXv4ZQwYdimKtU4JCorFs/UeAXelQxg2iPJG+l98HM8Y3fOsZHUGZrmjR
 tuB9qI/OzxN58IF93kTwVeBtQCNUWvNC/WBp924uDaFKeMw58U49pL/YDxPp5muWejJhNWQFkq239
 7oiahOk4rOLWUyhJUl4Ld5zK63BNcA9TnkPh2OIe8+StUxTr72GPl1VxUrFSNzS8nAajKU1lKXsz+
 Dhfs0OpQ==;
Received: from [187.56.70.205] (helo=[192.168.1.60])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pHqTA-00AqdG-SO; Tue, 17 Jan 2023 19:14:02 +0100
Message-ID: <3526e25c-c0bb-a61f-319f-1c313f8fbea1@igalia.com>
Date: Tue, 17 Jan 2023 15:13:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] drm/amdgpu/vcn: Remove redundant indirect SRAM HW
 model check
Content-Language: en-US
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230117175836.914304-1-gpiccoli@igalia.com>
 <20230117175836.914304-2-gpiccoli@igalia.com>
 <MN0PR12MB6101FE6B2CC0AABB239DB06BE2C69@MN0PR12MB6101.namprd12.prod.outlook.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <MN0PR12MB6101FE6B2CC0AABB239DB06BE2C69@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 17 Jan 2023 18:41:05 +0000
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
Cc: "Jiang, Sonny" <Sonny.Jiang@amd.com>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "Zhu, James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 17/01/2023 15:08, Limonciello, Mario wrote:
> [...]
> 
> Should have added this tag too:
> Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> 
> Looks good to me, thanks!
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 

You're totally right, thanks for the reminder and apologies for missing
that! Just sending V3 heheh

Ah, thanks for the reviews and prompt responses.
Cheers,


Guilherme
