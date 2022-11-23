Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45E3C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 13:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C5D10E558;
	Wed, 23 Nov 2022 13:58:08 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052CB10E57A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 13:58:04 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4NHN4T0gR6z9sW1;
 Wed, 23 Nov 2022 14:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1669211881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DT5Wc1bXYwX1SLznej3PLe1bw76NCL70kW9YZv8SMkU=;
 b=xxCMqV/CfCS7cvK+/7AbggnTB9Mz05FCCmsSipNfNK1rPgmbJyMzASw5rh749CIN3vIhKG
 2IwE0xwVDI/3gE0D2XNerXpT2U6oghk9I0K0wzGt4U9arqQ8AVPeFe50jmzPE+2NU4Ko9A
 UHJ9EpT3SX9WVqLPGoV8Hn7oP/pk/dL3criAThfTLoXrR+lKRITpDNeIbTIWFJ6AX2YfJk
 BJwUnh/2QtNZBjT9BA98E1DZm6e482bqvFWNsvrfQk51afYPpxmJrqeyhAIwKg8UJFV02W
 g5d3qK59vLUfSzo/GBnWRrNWAyDvZq75ZM4dMXdMVk2Z+XSnpxDcuKay6+XBQw==
Message-ID: <8827a1e7-c3a1-9a7d-d774-918bf373c07e@mailbox.org>
Date: Wed, 23 Nov 2022 14:57:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] drm/amdgpu: add printing to indicate rpm completeness
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
References: <20221123014408.263645-1-guchun.chen@amd.com>
 <24eb1835-d49f-f938-c0cc-ac8cfedaba4b@amd.com>
 <DM5PR12MB2469BEB165320703CC12E1B5F10C9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <DM5PR12MB2469BEB165320703CC12E1B5F10C9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nqb8izwmxwcm7xx9s3y3ywzg6ikp4rwd
X-MBO-RS-ID: 19ef2550fbf17fe255e
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

On 11/23/22 07:09, Chen, Guchun wrote:
> Hi Lijo,
> 
> Thanks for your review. The cause for this change is, so far, except one line printing like "amdgpu: free PSP TMR buffer", there are no other printings once system completes rpm suspend. And moreover, "free PSP TMR buffer" sometimes confuses audiences.

How about making those messages not printed by default then, instead of adding more?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

