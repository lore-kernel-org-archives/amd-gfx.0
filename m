Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57EAC47073
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 08:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F3F10E381;
	Tue,  9 Jan 2024 08:02:56 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66BA10E381
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 08:02:55 +0000 (UTC)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cd1ca52f31so28945381fa.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jan 2024 00:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704787374; x=1705392174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mnDXd8K8pjaRQUDi5NKjk27lndUKpWmusl1cFgymsyg=;
 b=ApnJmdjFqXv/ZbfCx7U6cgU/D3qRLchlPQvO3OZH6u3sRybmsWubuA2+bLl6DzYBvJ
 iVUNcAew4zGAcd350g/RamqIt8msap2VbO/T3uABrHF2PsDVnCAmoWXj7rJ23fBSmHYX
 djvz+vKMMPwtnvrDl8VgcJAW2PjWD+0H+GGLf6bJKa9ANL9qNnNrZN7HJ3DN/c/R2gPj
 V++//KMaBTDZnoJ0w8o9HAwgLOQ3UpYH+i1Q71b9BrqeD1cLPR4IzWBtpZqWiTVn5StJ
 5nRyijFDJao/iwxh4E11IWljt3HsfD8kMjNa9gQAMG774OlXs/bLtWkAKulpJj54W8Me
 DMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704787374; x=1705392174;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mnDXd8K8pjaRQUDi5NKjk27lndUKpWmusl1cFgymsyg=;
 b=ES3wiCibwGWSSt1TetCXejZvpYwrsBNIvBI4hvEW0E0MEpAo6GEGw5ZzDzhoxl0MSQ
 hVY0cx6ubOd+nr8dvG5q7XCwKb5n8gdpGhEkt4daHMJZxfhLlwMUCglfCwpBWzp4wKPc
 aKiHcyEV6z+mnZBv8e5Y6DcJKO+lii8l1xcZuUSCT3QnGJbowvtCR+BGL5anwf4GKWLh
 hoMwsz0LOWJ5jPDODt+HBkDxzKBpNWu1KyNy1AW/eFDPqPgmUFbgMUlLQq0ZEeO1x2l5
 uTjX4YSTc5rGmBinhwjtKFm50pT4Eb/Plkaps4/J9Of4fAj8gFmF60C83Yh5Z9f4jASC
 YZFQ==
X-Gm-Message-State: AOJu0YwgwVQJAaQk+DX1Dc9QUAT3WxIbEQ4dDlhffFeQ5RSuuum+r8Pj
 7/ev0QFVgRT+rrE8dTyJPU4=
X-Google-Smtp-Source: AGHT+IHbgw9JOuk6zfsLRgeYMSOTHKND9Iv8NrLIJ4TQYVfPnZ2+cYpjOPrYhgy/cvTK9yamt0hwcQ==
X-Received: by 2002:a2e:96d7:0:b0:2cd:1d93:115 with SMTP id
 d23-20020a2e96d7000000b002cd1d930115mr1944657ljj.77.1704787373682; 
 Tue, 09 Jan 2024 00:02:53 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a056000004e00b0033739c1da1dsm1649073wrx.67.2024.01.09.00.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 00:02:52 -0800 (PST)
Message-ID: <1b679a75-27ee-4682-8bf1-c0defcd9e949@gmail.com>
Date: Tue, 9 Jan 2024 09:02:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Documentation for RGB strip on RX 7900 XTX (Reference)
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Alexander Koskovich <AKoskovich@protonmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 08.01.24 um 23:32 schrieb Deucher, Alexander:
> [Public]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Alexander Koskovich
>> Sent: Sunday, January 7, 2024 11:19 PM
>> To: amd-gfx@lists.freedesktop.org
>> Subject: Documentation for RGB strip on RX 7900 XTX (Reference)
>>
>> Hello,
>>
>> I was wondering if AMD would be able provide any documentation for the
>> RGB strip on the reference cooler
>> (https://www.amd.com/en/products/graphics/amd-radeon-rx-7900xtx)? It
>> looks to be handled via I2C commands to the SMU, but having proper
>> documentation would be extremely helpful.
> It depends on the AIB/OEM and how they designed the specific board.  The RGB controller will either be attached to the DDCVGA i2c bus on the display hardware or the second SMU i2c bus.  The former will require changes to the amdgpu display code to register display i2c buses that are not used by the display connectors on the board so they can be used by 3rd party applications.  Currently we only register i2c buses used for display connectors.  The latter buses are already registered with the i2c subsystem since they are used for other things like EEPROMs on server and workstation cards and should be available via standard Linux i2c APIs.  I'm not sure what i2c LED controllers each AIB vendor uses off hand.  https://openrgb.org/index.html would probably be a good resource for that information.


It might also be a good idea to look some of the ATOMBIOS tables found 
on your device.

Those tables are filled in by the AIB/OEM with the information which 
connectors (HDMI, DVI, DP etc...) are on the board and I bet that the 
information which RGB controller is used and where to find it is 
somewhere in there as well.

Adding Harry from our display team, might be that he has some more hints 
as well.

Christian.

>
> Alex
>

