Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2CBC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 08:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABB010FBDD;
	Tue, 12 Apr 2022 08:08:47 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E885D10FB65
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 08:08:44 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef95.dynamic.kabel-deutschland.de
 [95.90.239.149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4FD0161EA1923;
 Tue, 12 Apr 2022 10:08:43 +0200 (CEST)
Message-ID: <a91f6e5c-b3e6-5312-9908-572e093f74f9@molgen.mpg.de>
Date: Tue, 12 Apr 2022 10:08:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH ] drm/amdgpu: fix discovery ip failed
Content-Language: en-US
To: "Jesse (Jie) Zhang" <Jesse.Zhang@amd.com>
References: <DM4PR12MB51525F878057240AE5C91F14E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <bbd6939b-227c-f197-5d10-ba9194fd2b76@molgen.mpg.de>
 <DM4PR12MB51529669CBDA773CD36D420FE3ED9@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DM4PR12MB51529669CBDA773CD36D420FE3ED9@DM4PR12MB5152.namprd12.prod.outlook.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Yifan Zhang <Yifan1.Zhang@amd.com>, Ray Huang <Ray.Huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Jie,


Am 12.04.22 um 03:52 schrieb Zhang, Jesse (Jie):
> [AMD Official Use Only]
> 
> Thanks  Paul Menzel
> Attach  the patch file .

Please do not attach patch files, as it breaks work flows and inline 
commenting. Please use `git send-email` or equivalent. Your colleagues 
should be able to help you with this.

[…]


Kind regards,

Paul
