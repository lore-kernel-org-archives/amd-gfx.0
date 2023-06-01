Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF100C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 15:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE1F10E23C;
	Thu,  1 Jun 2023 15:53:41 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA0710E23C
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 15:53:38 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202306011753365625; Thu, 01 Jun 2023 17:53:36 +0200
Message-ID: <e152ce5a-d269-549c-c888-8a21734c6515@daenzer.net>
Date: Thu, 1 Jun 2023 17:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-CA
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chalmers, Wesley" <Wesley.Chalmers@amd.com>
References: <20230414155330.5215-11-Qingqing.Zhuo@amd.com>
 <9deeb132-a317-7419-e9da-cbc0a379c0eb@daenzer.net>
 <CH0PR12MB5284513F3548D749845BD7B48B769@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CH0PR12MB5284BDF5F23009597E1503E38B769@CH0PR12MB5284.namprd12.prod.outlook.com>
 <714c875f-21f1-7e29-fb39-4a1f97eb712f@daenzer.net>
 <14582e0e-58cb-02df-50ae-1af22d194b29@amd.com>
 <ea2f979e-730a-4bea-4092-3798f718ce0d@daenzer.net>
 <8e0d6d87-0f73-1ae0-bce8-8b6231e6c068@amd.com>
 <aca2a2e5-76c3-4df9-336e-2d9060333389@daenzer.net>
 <CH0PR12MB528437770699502A9A26F3A38B499@CH0PR12MB5284.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
In-Reply-To: <CH0PR12MB528437770699502A9A26F3A38B499@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F15.6478BF00.0011,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/1/23 17:45, Pillai, Aurabindo wrote:
> 
> I see, thanks for the info. I'll try repro'ing it locally.

Thanks. Note that I'm using a GNOME Wayland session, which doesn't support VRR upstream yet (I'm building mutter with https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1154 for that). I don't know if it's reproducible with Xorg.


> But do you have the open userspace stack from AMD's packaged driver installed ? If not, could you please try downloading from https://www.amd.com/en/support/linux-drivers <https://www.amd.com/en/support/linux-drivers> and install just the open components?

I don't, and I'd rather not unless it's absolutely necessary. I'm not sure how the user-space drivers could affect this.

I'll happily test further patches though.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

