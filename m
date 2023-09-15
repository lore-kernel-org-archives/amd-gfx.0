Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F75FEE6432
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 07:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E8B10E168;
	Fri, 15 Sep 2023 07:57:40 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A08D10E168
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 07:57:38 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202309150957325156; Fri, 15 Sep 2023 09:57:32 +0200
Message-ID: <f5d349b6-849c-4ea8-199a-c9edc64db23a@daenzer.net>
Date: Fri, 15 Sep 2023 09:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230911143639.3110-1-michel@daenzer.net>
 <CADnq5_P-r5mtirGWgb3HzOwj9AeLSn3rB30u969gLxBF3DVHGQ@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amd/display: Handle NULL dccg in dce110_disable_stream
In-Reply-To: <CADnq5_P-r5mtirGWgb3HzOwj9AeLSn3rB30u969gLxBF3DVHGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1F.65040E6C.003B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 9/14/23 22:52, Alex Deucher wrote:
> On Mon, Sep 11, 2023 at 10:36 AM Michel Dänzer <michel@daenzer.net> wrote:
>>
>> From: Michel Dänzer <mdaenzer@redhat.com>
>>
>> It can be NULL e.g. with Raven.
>>
>> Fixes: 927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
>> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
> 
> Looks like this was fixed in:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/7f7925e258288cfcfa2b0e0631fcd91a39744f94
> but needs to be applied to 6.6.  I'll queue it up for 6.6.

Thanks.


FWIW, I notice some minor issues in that commit:

The if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) block in dce110_disable_stream still always calculates dto_params & dp_hpo_inst, but doesn't use them if dccg is NULL. (My assumption here was that dccg cannot be NULL in this block, I might be wrong though)

And some cosmetic issues:

The second line of the dccg->funcs->disable_symclk_se call remains incorrectly indented.

The newly guarded dccg->funcs->update_clocks calls lack curly braces around them.

dcn20_enable_stream is left with

	} else {
		}


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

