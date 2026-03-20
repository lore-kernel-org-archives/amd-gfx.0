Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6371A109316C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 01:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D3F10E157;
	Fri, 20 Mar 2026 01:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=m1k.cloud header.i=@m1k.cloud header.b="hr/vTEfI";
	dkim-atps=neutral
Received: from mail.m1k.cloud (mail.m1k.cloud [195.231.66.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C39910E157
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 01:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m1k.cloud; s=mail;
 t=1773970392; bh=Q4n+jLPErvUbvFOhI+w6kjVpt0cpWgI5hOeW0w3eGko=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=hr/vTEfI78gzh7ZZVsDJAoaaCsS3ndSC/KsmAtzpin7VwMMV4PJqNNRBxAtcMMWTo
 tYu56+LrtBvGjDrvPKyV1DcbC+y2QJmobEG2c8r8mWE5TaltvhTFoHucGPFsH5rst7
 WKh4HGve2pyDdI4q3nLRazMGvXoRLQ7FGZPG5TzkFdtb+iPF1V3XVelUqeb570nX+3
 P/e6U8sZYNkilkk2GrQmeQiKKpLUECd0TDlmW3EKJoLApEMi+1RRQBkNXr2idMSt4I
 uv/PkdYZd6hmv0Wy7FkjI57gavjndcZZMotBJHjcGGaVdRPEMJTX+4Do3Qf8kOO6Wx
 Umfcid6OuKRSQ==
Message-ID: <fe88c29c-3fc3-48b5-b6a2-ee4c210e7a83@m1k.cloud>
Date: Fri, 20 Mar 2026 02:33:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, siqueira@igalia.com,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
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
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
 <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
 <deb792f8-70a5-41f9-bcf8-1425994aad14@m1k.cloud>
 <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
Content-Language: en-US
From: Michele Palazzi <sysdadmin@m1k.cloud>
In-Reply-To: <4e48ec7b-ac73-4637-9e42-9c328067ed72@amd.com>
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

On 3/20/26 01:52, Leo Li wrote:
> 
> Hmm, is the "before" captured after the display hangs, but before the flip_done timeout error in dmesg?

yes

> And the "after" is captured after writing VSTARTUP_INT_EN=1, but also before flip_done timeout error in dmesg?

also yes
basically i detected the timeout with bpftrace and got umr dump 
before/after setting VSTARTUP_INT_EN=1

> Did you happen to try disabling some idle optimization features mentioned in a previous reply?
> https://lore.kernel.org/amd-gfx/1356e93b-af76-47f3-afc5-29535a9518bb@amd.com/

only for a bit, need more time on it to properly assess
