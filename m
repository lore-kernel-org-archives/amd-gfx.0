Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE43C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 10:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC21910E140;
	Thu, 25 May 2023 10:26:58 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E81C510E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 10:26:56 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202305251226240002; Thu, 25 May 2023 12:26:24 +0200
Message-ID: <821e8eb3-0ca8-34ff-dba8-7edcef34e28f@daenzer.net>
Date: Thu, 25 May 2023 12:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>
References: <20230522130823.769236-1-michel@daenzer.net>
 <16635e8f-f81e-a731-e81b-3f1c02d24b9f@amd.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/2] Revert "drm/amd/display: Block optimize on
 consecutive FAMS enables"
In-Reply-To: <16635e8f-f81e-a731-e81b-3f1c02d24b9f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1C.646F37E1.0049,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/23/23 18:09, Hamza Mahfooz wrote:
> On 5/22/23 09:08, Michel Dänzer wrote:
>> From: Michel Dänzer <mdaenzer@redhat.com>
>>
>> This reverts commit ce560ac40272a5c8b5b68a9d63a75edd9e66aed2.
>>
>> It depends on its parent commit, which we want to revert.
>>
>> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
> 
> I have applied the series, thanks!

Thank you. Note that these need to be merged for 6.4; they weren't in Alex's 6.4 fixes PR yesterday.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

