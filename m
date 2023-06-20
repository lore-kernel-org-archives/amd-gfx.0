Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DA7EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 15:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D3510E4C4;
	Wed, 21 Jun 2023 15:38:49 +0000 (UTC)
X-Greylist: delayed 807 seconds by postgrey-1.36 at gabe;
 Tue, 20 Jun 2023 08:10:59 UTC
Received: from smtp.tom.com (smtprz25.163.net [106.38.219.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B14CC10E27E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 08:10:59 +0000 (UTC)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
 by freemail02.tom.com (Postfix) with ESMTP id 0F3B6B00CC4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 15:57:28 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app02 (TOM SMTP Server) with SMTP ID -392110795
 for <amd-gfx@lists.freedesktop.org>;
 Tue, 20 Jun 2023 15:57:28 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
 by freemail02.tom.com (Postfix) with ESMTP id F0181B00CBF
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 15:57:26 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1687247847; bh=fe2gbNBOimrCNd/Vj8kpZhrYgncj1cjN6H+eAQuu4MY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WaJhyRNad5ZsR2ktD4Rm+I92ZQ13LsoT3+qaB9MQJv1C0jYjVCR0+2TEbvtLN4+LM
 EmjPoRH4oQxvKmteMXve0NBeB20NMH7htTpUYffA2Mo2UFnPtTnpJwNI4DPkDExPRQ
 YktBJh9v+sWidKNzvenj/WEmVfYmOgmPb47712ic=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
 by antispam1.tom.com (Postfix) with ESMTP id 8BAAFD41AEF
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 15:57:26 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
 by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HbTKeDdRQ00x for <amd-gfx@lists.freedesktop.org>;
 Tue, 20 Jun 2023 15:57:25 +0800 (CST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
 by antispam1.tom.com (Postfix) with ESMTPA id D096BD4140C;
 Tue, 20 Jun 2023 15:57:22 +0800 (CST)
Message-ID: <c12c4031-52fb-25a2-b411-e668eb9baaa2@tom.com>
Date: Tue, 20 Jun 2023 15:57:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amd/amdgpu: Properly tune the size of struct
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Su Hui <suhui@nfschina.com>
References: <20230620045919.492128-1-suhui@nfschina.com>
 <da6c860f-0ef0-44e4-8b58-0f4d55c1b8bd@kadam.mountain>
From: Longsuhui <Jack_sun@tom.com>
In-Reply-To: <da6c860f-0ef0-44e4-8b58-0f4d55c1b8bd@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 21 Jun 2023 15:38:42 +0000
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
Cc: Jane.Jian@amd.com, Bokun.Zhang@amd.com, David.Francis@amd.com,
 Xinhui.Pan@amd.com, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 airlied@gmail.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023/6/20 15:37, Dan Carpenter wrote:
> On Tue, Jun 20, 2023 at 12:59:19PM +0800, Su Hui wrote:
>> Smatch error:
>>      gpu/drm/amd/amdgpu/amdgv_sriovmsg.h:316:49: error:
>>      static assertion failed: "amd_sriov_msg_pf2vf_info must be 1 KB"
>>      static assertion failed: "amd_sriov_msg_vf2pf_info must be 1 KB"
>>
> I doubt that moving the struct members around is safe.  This looks like
> it's in a very specific order.  So I don't think this patch is correct.
>
> The reason for this false positive this code uses a #pragma to pack the
> struct.
>
> #pragma pack(push, 1) // PF2VF / VF2PF data areas are byte packed

Oh, Sorry, I didn't see this code.

This patch is error, and sorry for the noise.

> Sparse does not support this and Smatch uses Sparse as a parser.  The
> main reason why Sparse doesn't support this pragma is because Linus
> thinks it's gross.  You probably didn't even see the #pragma did you?
> And anything you can't see is unreadable by definition.
>
> "Mark the associated types properly packed individually, rather than
> use the disgusting "pragma pack()" that should never be used."
>
> https://lore.kernel.org/linux-sparse/CAHk-=wi7jGZ+bVbt-UfXOkpEQdHzF3Z2HBjkGdjh8q4dvPPGWQ@mail.gmail.com/
>
> regards,
> dan carpenter
