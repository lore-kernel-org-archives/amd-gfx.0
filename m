Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F6BF53D69
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 15:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB6410E25B;
	Mon, 16 Mar 2026 15:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="YEGpZmPb";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D33E10E25B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1773674245; bh=PfykYu2sk6Y6WzjpKFDISZ0lpp4tId3wtvgVXVkkJ5w=;
 h=Subject:From:To:Cc:References:In-Reply-To;
 b=YEGpZmPbIX6PqphLJVTqxe+rTbDqkgNkrGlHUvmBQPnGMU3AR3Ibz3zxS1pGOkaeE
 rZo877mJBVOV/m30QIlVyL+/CHXYAJQwTREPzYgDOr7N1avBTlEHTGn5+LvGvM0m0F
 k0hUOP0OcmUs9RoRxfHdoNJxYpXE1+GzGd+AWh/U2PE0yq+iuQ8SqLYOpivYHa08kN
 ckS0ZwyaKK5hIAsPQ2MeEY3EAVEpU7Q8r01aZ4FtooT79FhNsZILXMlN9rFJaJpbn4
 ZDTAYSZVNox8fsF0iIcaxoRxxykc85zyceMa5x4CJeTQ1ow0ZKDf24/TEIYhAIf32z
 LK31gcfyI8ZaQ==
Message-ID: <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
Date: Mon, 16 Mar 2026 16:17:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
From: Michele Palazzi <sysdadmin@m1k.cloud>
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
Content-Language: en-US
In-Reply-To: <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
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

On 3/16/26 15:55, Michele Palazzi wrote:
> On 3/11/26 18:56, Leo Li wrote:
>>
>> dm_crtc_high_irq() not firing on CRTC 0 is quite strange. It suggests 
>> either
>> the interrupts were disabled (even though 
>> drm_vblank_disable_and_save() was
>> not called), or the timing generator in HW hanged.
>>
>> Could you dump the interrupt state registers once the timeout is hit? 
>> Using UMR:
>>
>> # get the GPU instance for your 9070XT, it should be the one with 
>> "dcn401" under
>> # "IP Blocks:"
>> sudo umr -e
>>
>> # Dump interrupt state, replacing --instance # with your 9070XT instance:
>> sudo umr --instance 1 -r '*.*.OTG_GLOBAL_SYNC_STATUS' -O bits
>>
>> UMR is available on aur, building it is also straightforward:
>> https://aur.archlinux.org/packages/umr
>> https://gitlab.freedesktop.org/tomstdenis/umr
>>
> 
> 
> took me a while to get the umr output after the timeout (taken within 1 
> second from the flip timeout)
> 
> https://pastebin.com/dz4tkfDV
> 
> 

actually there were 3 dumps in rapid succession, here you have all 3 for 
completeness

16 mar 15.33 umr_dump_20260316_153356.txt https://pastebin.com/LvYrjw5y
16 mar 15.35 umr_dump_20260316_153540.txt https://pastebin.com/SmSvCXva
16 mar 15.35 umr_dump_20260316_153550.txt https://pastebin.com/BbsWbbTN

