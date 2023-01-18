Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB776C38159
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 18:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E9B10E208;
	Wed, 18 Jan 2023 18:48:28 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907DE10E1F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w3/BzGSjM3v35VOlw6u0YiLN5Fbs78e9/j7fauVAu9U=; b=CJBulUMNSIvPJy7Qg11PjF5/Lp
 XUYQycEoH/uoPOBjKaVhxABzf1DXJYXvdQAKXUcwz+KGdPOUhVK9URUQaxcuBH+LdkO29yEMRjNA8
 9HjysHFsioj9S2nB2s3Jnadt92RP7UkWv+Xbx2vXpWexkgABV/gq3z8QtSl9ZwvaH54i3OglD6MsO
 6BMSjoa5DO77uci/d0BQN5xmHi2bb9B5DcZn+6kQ3Ukxk2T8x0RlkfhiaOCpQfA5ioBwlfTW9RoQ+
 JzCIj7pfQV7FiswwzgOypGRuW7PSE9GgCKbnJojlWR0b2eYkLGi+gTQ5KBJNrh+rVY51rIPTrCNpR
 U+U22PHQ==;
Received: from [187.56.70.205] (helo=[192.168.1.60])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pIDSb-00Bj7Y-Vy; Wed, 18 Jan 2023 19:46:58 +0100
Message-ID: <47070ba3-b18b-b9a0-1073-b8dc6e6cac58@igalia.com>
Date: Wed, 18 Jan 2023 15:46:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/4] Update AMD APU IP version docs
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230118172841.5690-1-mario.limonciello@amd.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230118172841.5690-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 18 Jan 2023 18:48:27 +0000
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

On 18/01/2023 14:28, Mario Limonciello wrote:
> Guilherme G. Piccoli submitted some patches recently to the mailing list
> related to removing IP version detection code.  As part of the discussion
> it was mentioned that non-obviously some IP blocks are shared between
> multiple APU parts.
> 
> The example given was for launched products Rembrandt and Mendocino VCN,
> but in looking at the existing table I found that we don't actually
> indicate the VCN version for Mendocino.
> 
> So I added this to the table, and then noticed we're missing references
> to some other recently launched products.
> 
> So update the table with all missing launched products as well as products
> launching this year that don't have IP version changes.
> 
> Mario Limonciello (4):
>   Documentation/gpu: Add MP0 version to apu-asic-info-table
>   Documentation/gpu: Update lines for GREEN_SARDINE and YELLOW_CARP
>   Documentation/gpu: Add Mendocino to apu-asic-info-table
>   Documentation/gpu: Add Raphael to apu-asic-info-table
> 
>  .../gpu/amdgpu/apu-asic-info-table.csv         | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 

Thanks a lot for the improvement Mario, much appreciated!
Cheers,


Guilherme
