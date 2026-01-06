Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28DBC47BF6
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 14:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C4010E4D4;
	Tue,  6 Jan 2026 14:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="XPTBibit";
	dkim-atps=neutral
X-Greylist: delayed 798 seconds by postgrey-1.36 at gabe;
 Tue, 06 Jan 2026 09:43:58 UTC
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E4C610E48C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1767692636; x=1768297436; i=markus.elfring@web.de;
 bh=6dht8SJkC2rzRbuhZR4GkSwtU/MGsqJhcdvKRHb5nIg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XPTBibitEW4jY+hqvqFkfEav5cnhrJzWqpbDpETxCd5nRafHXvr6fH0l52lRLn/A
 i1zVn9uL0s25tGP+Qydb5tTU0F3Ffe/Ngzx/LlT7XzoVV/hYWNknZJEJcnxekrKNh
 IlL51wHbfSrgTS3Xy4bnxmtnmotC2qeazdQfGdM3Mk/Xox1BDJR+avuq973HSQI+N
 dfyDkdzojtFIL1/5mIJuTOEaEVfzQpQd8z/GkokAf0hIc4h2xNyCGRBUzLyC5ZbOI
 dy9HQ2DhoimH6iD4VRqAY9QqaLv4Au41B/6mJstQIDPf0FHyd8XusK+vpgFDaIiON
 jEqHoEVeD3uFG2LU8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoecF-1wEcG20HIP-00hfos; Tue, 06
 Jan 2026 10:30:27 +0100
Message-ID: <57a9f219-2612-4a64-a9fb-44b04e09ec15@web.de>
Date: Tue, 6 Jan 2026 10:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Felix_K=C3=BChling?=
 <felix.kuehling@amd.com>, Oak Zeng <ozeng@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260106015731.1906738-1-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH v2] drm/amdkfd: fix a memory leak in
 device_queue_manager_init()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260106015731.1906738-1-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27LJ+tSBb4OMp24QRjdLwne1rdlZJUpA7LX3k5d6QKKcEnfp5aA
 gYRNn1vxb7sgau5aF7q5Mr1McPEMf2zY4zNrwLyDGOL3b68CzxCt0ua0v2aDNOjCA6MYpFj
 S+A+uKDP0Ml660z073sj9q8sBYajmj0wAhxkXDrer50QRFoX9gWt9S+gsIV63uD1HiM4ohB
 sGSy+Uq2T/G6Jb9wWHTfg==
UI-OutboundReport: notjunk:1;M01:P0:Z6bX4+tNXLM=;GJitvHWZ7woSUXdqMSd9IZDbvMP
 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
 Eu8VfgL7pE2zzo+StSAvdSoV+Y=
X-Mailman-Approved-At: Tue, 06 Jan 2026 14:00:21 +0000
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

=E2=80=A6
> Move deallocate_hiq_sdma_mqd() up to ensure proper function
> visibility at the point of use.

=E2=80=A6
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2919,6 +2919,14 @@ static int allocate_hiq_sdma_mqd(struct device_qu=
eue_manager *dqm)
>  	return retval;
>  }
> =20
> +static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
> +				    struct kfd_mem_obj *mqd)
> +{
> +	WARN(!mqd, "No hiq sdma mqd trunk to free");
> +
> +	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
> +}

Is there also a need to reconsider the implementation of the applied
null pointer check here?

Regards,
Markus
