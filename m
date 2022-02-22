Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E38FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 10:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8C110E7BC;
	Tue, 22 Feb 2022 10:53:53 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1F910E7B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 10:53:51 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aebb8.dynamic.kabel-deutschland.de
 [95.90.235.184])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id B7CA361E6478B;
 Tue, 22 Feb 2022 11:53:49 +0100 (CET)
Message-ID: <22b59595-d61f-9e15-4724-4ac6ce4b16ee@molgen.mpg.de>
Date: Tue, 22 Feb 2022 11:53:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] drm/amdgpu: Fixed warning reported by kernel test robot
Content-Language: en-US
To: Thomas Chai <YiPeng.Chai@amd.com>
References: <20220222070652.3373218-1-YiPeng.Chai@amd.com>
 <DM5PR12MB17703BA945F89BB64ED36C6FB03B9@DM5PR12MB1770.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DM5PR12MB17703BA945F89BB64ED36C6FB03B9@DM5PR12MB1770.namprd12.prod.outlook.com>
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
Cc: Tao Zhou <Tao.Zhou1@amd.com>, John Clements <John.Clements@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear yipechai,


Am 22.02.22 um 09:39 schrieb Zhou1, Tao:
> [AMD Official Use Only]
> 
> With my inline concerns addressed, the patch is:
> 
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
> 
>> -----Original Message-----
>> From: Chai, Thomas <YiPeng.Chai@amd.com>

Can you please configure the full name too for the From: header field, 
and Signed-off-by line.

[…]


Kind regards,

Paul
