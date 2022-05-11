Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64759C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 12:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0197710E2B9;
	Wed, 11 May 2022 12:01:33 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C46110E2B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 12:01:31 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id ch13so3515006ejb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=u0tXYiSeuXA4FVwlCLUjj/6hu6YWAxriDMO2+yxPWNc=;
 b=ZrTmlykHSj+S0huxirDYojqYGuVzHoCYaHH91i7yN0mM5h+M56A12TUvN8Skjs6vPm
 PwWe71+c7ULDUNOD5k6JxDhkDP7ruDyIHNcFPy2cy+YbEVlvQ671sN7JEdGqFGshdvwL
 ZvG2qjbPQ6u9wmSZmmlgezObYMdfJddPQqSxr7kiRcZnwewNpivHI8UF/mii8FdmHHmZ
 V04GU6Ti6LaRLCCcBtSanblCaOZ85U113K6kJeniqfcDhDiG/UIdaPzFqTiyOxS/mX3+
 arUQmzNrq7YdNOLjxrkJd3UeSqYa/Kui04hUX0kZOAR5lbYCo9ZNA+wXDrrx05AnpP/T
 il1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=u0tXYiSeuXA4FVwlCLUjj/6hu6YWAxriDMO2+yxPWNc=;
 b=C0a2F7fM++jJpEPdMBK5IgP7IDlhAHukek/jKo3IsbqIbs4sjYEH98DSt/IrdiZn++
 2YkX7kBKSRfuscKtfMWykKMu4Dl5EWZ9IoMcz1TvkpdGVm+ioMecN01DU7eYziPp14tp
 hyF+IwlMBTRN1gKGMLKBXAYefkTp0HnthpvyTXre4ow66iB5PhOVSyqLggiVE89LSdfV
 NHT2SwjYMN+wA07ZG1tEltBwFMPdcD96+aSuwzJk1iSlpPiGTbCLztlw9hjqyAfrPQIP
 OUbO/N0byxE2+fDwWB7JuiZMIliJ7t1d50i/Sx56ZGOgvsNbAG5a0gCdf109rwxlc7o6
 XSZg==
X-Gm-Message-State: AOAM532GGRIeue8dSW5BeT+iOlqCKhCeldK8v+wMAujRjsWHVdLGfLS5
 ueNZLbuM+aX2w+XG1AJ8VekUgG8TB0I=
X-Google-Smtp-Source: ABdhPJzAFZ+vxEQu3OHLMnECL3HYa9cUsTXIROH8hc9i7mPtTAEXu+GpE2VIzruTOuwuOMr6lj0rQw==
X-Received: by 2002:a17:907:6d94:b0:6f4:531d:742 with SMTP id
 sb20-20020a1709076d9400b006f4531d0742mr24195945ejc.202.1652270490073; 
 Wed, 11 May 2022 05:01:30 -0700 (PDT)
Received: from [192.168.178.21] (p57b0be56.dip0.t-ipconnect.de.
 [87.176.190.86]) by smtp.gmail.com with ESMTPSA id
 t9-20020a170906608900b006f3ef214e35sm918539ejj.155.2022.05.11.05.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 May 2022 05:01:29 -0700 (PDT)
Message-ID: <8e54ec49-09da-f345-35cd-430712f5a6ad@gmail.com>
Date: Wed, 11 May 2022 14:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191 dma_fence_array_create+0x101/0x120" and
 some games stopped working.
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
 <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
 <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
 <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
 <CABXGCsP19VFRgTx5yGn68iCK3NxPxi_b9MTq=AmHtFPv9xR5sA@mail.gmail.com>
 <675a2d33-b286-d1d0-e4e7-05d6516026c0@gmail.com>
 <CABXGCsOqrB5zPFCeLw-VQjePikwDq4EKFQGc9hbOb5f7tGLDgg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsOqrB5zPFCeLw-VQjePikwDq4EKFQGc9hbOb5f7tGLDgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.05.22 um 11:05 schrieb Mikhail Gavrilov:
> On Fri, Apr 15, 2022 at 1:04 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> No, I just couldn't find time during all that bug fixing :)
>>
>> Sorry for the delay, going to take a look after the eastern holiday here.
>>
>> Christian.
> The message is just for history. The issue was fixed between
> b253435746d9a4a and 5.18rc4.

We have implemented a workaround, but still don't know the exact root cause.

If anybody wants to look into this it would be rather helpful to be able 
to reproduce the issue.

Regards,
Christian.
