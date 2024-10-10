Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B38D1625B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 12:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE2D10E291;
	Mon, 14 Oct 2024 12:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQE1S9YH";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DF610E972
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 15:59:19 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5c918c067a1so1248031a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728575957; x=1729180757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwbGM2GBS24VwCv3G0yCYJQXN3/p1wbB4ScKP62AMAA=;
 b=cQE1S9YHPFhCxCAKpcXsf6ip+mYS1lmPIrT5bywAI23mMk5jrmW71NpQZHRsZf8R7K
 USfetphcX+TAyMPMFCi0ab2xlq9TQZPvgiQ4IvybBFEaJKU5F95hDY7z9I15egSLMXA5
 Xj/+pGP7cWoTKFgvyO6l0yAXGo0xgCWigWHW56W7R3mtL0hrRLc0tZNL8HKj2Pjsfw0a
 kfsP6po6WLgmDzQGim+IOAWozIj5w8mmzPJiIe+XlldwQLLJ8ikF7oIThQHpoLQIt+9U
 KhfxoSyicyOdMz1Uy2DoIpO1zPxYW+zGJLKxxb38vBlgMnbWwjIgZTT/XqmLnDef6Uic
 v9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728575957; x=1729180757;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TwbGM2GBS24VwCv3G0yCYJQXN3/p1wbB4ScKP62AMAA=;
 b=U9YaFjdzvWhH8qcBXwtoGxaqeTnRT2yDsprvrIICHK191Z0PdQa27Km7/2amY4co0/
 UtOijO/LY2TjoYTSGxduuSMhuuHT0gbCnocYPBfXJY5QDXYgvnENAsN71VqrNsWWdwpZ
 TW3kV7sXwtfaslXOulHKm79FBc0OaVqmN7Wlg//9UUR2xt+WYihQf2bGiOUgqPnlMidq
 Gza2c0494MeIhd0dhbpqQH1Ak1RDdgZNiGvll/VK77WQNmQ34x8sfZRnHVFjiy2Ngf0d
 oSIItks9LBuBgfUi2oPP/o0URMauWqC+W2LaPi+hQVq4FjBm0w1iFyzuE9SushnqWixS
 9Q/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8ILwgEZDA7fTWvjgG50seT39Kp4qwGQ4vk1i1gBTR1L/rwWOrWjAZiiKTIsaQPAPQb9zTa6Ze@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxpk5Oy9+B0uHI2yCENjzI0AH4ZLpCTxpTO/3VJl1UBogx9qgnN
 O61Zqm8Dp0wVFA8EHHDaMICloaaXz08b4cZVRfSttqJv5eeODdWd
X-Google-Smtp-Source: AGHT+IElbzBU/j/0Stgy5/nLvDDKlh349Y4ohJfeszQYxvSNuC6NwtvuuGPvY9h7LABNl5BavOlG5A==
X-Received: by 2002:a17:907:972a:b0:a99:537d:5d10 with SMTP id
 a640c23a62f3a-a998cf3aee8mr538206466b.0.1728575957212; 
 Thu, 10 Oct 2024 08:59:17 -0700 (PDT)
Received: from [192.168.0.101]
 (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a99a80dc6bfsm107133666b.162.2024.10.10.08.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 08:59:16 -0700 (PDT)
Message-ID: <ec6a9eff-89b0-4fd6-b3b3-5b234ee79f92@gmail.com>
Date: Thu, 10 Oct 2024 16:59:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: drm/amd/display: Introduce DML2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 12:50:04 +0000
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

Hi,

Static analysis on linux-next has found a potential issue in function 
dml_rq_dlg_get_rq_reg in 
drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.c

The issue is as follows:

         if (min_meta_chunk_bytes == 0)
                 rq_regs->rq_regs_l.min_meta_chunk_size = 0;
         else
                 rq_regs->rq_regs_l.min_meta_chunk_size = 
(dml_uint_t)(dml_log2((dml_float_t) min_meta_chunk_bytes) - 6 + 1);

         if ( == 0)
                 rq_regs->rq_regs_c.min_meta_chunk_size = 0;
         else
                 rq_regs->rq_regs_c.min_meta_chunk_size = 
(dml_uint_t)(dml_log2((dml_float_t) p1_min_meta_chunk_bytes) - 6 + 1);

it appears that the second if statement is checking for 
min_meta_chunk_bytes == 0 and I think it should be in fact checking for 
p1_min_meta_chunk_bytes == 0 instead. I don't have the hardware so I 
can't test this hypothesis.

Regards,

Colin
