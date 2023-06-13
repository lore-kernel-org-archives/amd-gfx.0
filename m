Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194A5EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 15:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA68510E3B1;
	Tue, 13 Jun 2023 15:40:45 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0824A10E3BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 15:40:43 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202306131740381377; Tue, 13 Jun 2023 17:40:38 +0200
Content-Type: multipart/mixed; boundary="------------5tiWAXapzVgvXJ59CilsTJ28"
Message-ID: <e3854753-a654-4f56-d7d3-3375711f81b1@daenzer.net>
Date: Tue, 13 Jun 2023 17:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "Chalmers, Wesley" <Wesley.Chalmers@amd.com>
References: <bc662b83-f117-2f61-c580-086c3f404086@daenzer.net>
 <ec919f31-2f33-f085-dfdd-25360b5e082c@daenzer.net>
 <CH0PR12MB528496B026471110065187488B52A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <df1dde7c-f789-97eb-5b67-266bbb95c1e1@daenzer.net>
 <CH0PR12MB5284C88ABA0C45CD177F9C5B8B53A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <f7c2a548-3154-c163-bf73-19a8c2939447@daenzer.net>
 <CH0PR12MB5284FFF8F26F8ACD7838BB6B8B50A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <579a46c1-d33a-dfb6-25e7-b657f0be1765@daenzer.net>
 <CH0PR12MB5284E2DAE880B3C1059076648B54A@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Language: en-CA
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
In-Reply-To: <CH0PR12MB5284E2DAE880B3C1059076648B54A@CH0PR12MB5284.namprd12.prod.outlook.com>
X-CTCH: RefID="str=0001.0A782F27.64888DF6.0028,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------5tiWAXapzVgvXJ59CilsTJ28
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/23 20:14, Pillai, Aurabindo wrote:
> 
> I want to double check if we're identifying the correct monitor for applying the workaround. Could you please try the attached patch and let me know the panel id ?

 amdgpu: ### Not applying any edid quirk for panel 4c2d71ac

I'm attaching the EDID.

BTW, I'm using the monitor firmware version 1011.0, which AFAICT is the latest.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


--------------5tiWAXapzVgvXJ59CilsTJ28
Content-Type: application/octet-stream; name="edid"
Content-Disposition: attachment; filename="edid"
Content-Transfer-Encoding: base64

AP///////wBMLaxxSENHMCYfAQS1dyJ4O8clsUtGqCYOUFS/74BxT4EAgcCBgKnAswCVANHA
GmgAoPA4H0AwIDoAqVBBAAAaAAAA/Qw88GZmwgEKICAgICAgAAAA/ABMUzQ5QUc5NQogICAg
AAAA/wBITlRSOTAwMzA2CiAgAiwCAy7wQhAEIwkHB4MBAADjBcAAbRoAAAIPYPAABIsDcwPm
BgUBi3MC5QGLhJABGmgAoPA4H0AwIDoAqVBBAAAaVl4AoKCgKVAwIDUAqVBBAAAaLdaAeHA4
KUAcILgEqVBBAAAaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA9HASeQAAAwFQnPUCiP8T
PwF/gB8AnwUuACAABwAztwAI/xOfAC+AHwCfBSgAAgAJAONuAQj/CU8AB4AfAJ8FKgAgAAcA
kMcBCP8OnwAvgB8ANwSGAAIACQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAGOQ

--------------5tiWAXapzVgvXJ59CilsTJ28--
