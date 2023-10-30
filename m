Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535C6C4167D
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 09:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD3810E43E;
	Tue, 31 Oct 2023 09:23:52 +0000 (UTC)
X-Greylist: delayed 918 seconds by postgrey-1.36 at gabe;
 Mon, 30 Oct 2023 16:41:56 UTC
Received: from 3.mo560.mail-out.ovh.net (3.mo560.mail-out.ovh.net
 [46.105.58.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3229D10E0F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 16:41:56 +0000 (UTC)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.4.127])
 by mo560.mail-out.ovh.net (Postfix) with ESMTP id EBF8527582
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 16:26:35 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-7hln7 (unknown [10.110.208.67])
 by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 16CAE1FE61;
 Mon, 30 Oct 2023 16:26:35 +0000 (UTC)
Received: from RCM-web3.webmail.mail.ovh.net ([178.33.236.78])
 by ghost-submission-6684bf9d7b-7hln7 with ESMTPSA
 id zBVnAzvZP2VUTQEAW38/SQ
 (envelope-from <jose.pekkarinen@foxhound.fi>); Mon, 30 Oct 2023 16:26:35 +0000
MIME-Version: 1.0
Date: Mon, 30 Oct 2023 18:26:34 +0200
From: =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant check
In-Reply-To: <ce1b69e1-fa38-2e12-1ad5-375ac244af42@amd.com>
References: <20231029124404.16159-1-jose.pekkarinen@foxhound.fi>
 <ce1b69e1-fa38-2e12-1ad5-375ac244af42@amd.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <3c228e4f69c01dddd4743bdb68845566@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 162.247.74.74
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 15653104930003855014
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddttddgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeekhfeguddufeegvdelgedtvdffgeehvddtkeevkeejvedvgeeitdefleehtdeitdenucfkphepuddvjedrtddrtddruddpudeivddrvdegjedrjeegrdejgedpudejkedrfeefrddvfeeirdejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth
X-Mailman-Approved-At: Tue, 31 Oct 2023 09:23:45 +0000
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
Cc: dillon.varone@amd.com, george.shen@amd.com, sunpeng.li@amd.com,
 airlied@gmail.com, dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org, samson.tam@amd.com,
 SyedSaaem.Rizvi@amd.com, amd-gfx@lists.freedesktop.org, daniel@ffwll.ch,
 skhan@linuxfoundation.org, alexander.deucher@amd.com, Jun.Lei@amd.com,
 harry.wentland@amd.com, christian.koenig@amd.com,
 linux-kernel-mentees@lists.linuxfoundation.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-30 15:52, Aurabindo Pillai wrote:
> On 10/29/2023 8:44 AM, José Pekkarinen wrote:
>> This patch addresses the following warning spotted by
>> using coccinelle where the case checked does the same
>> than the else case.
>> 
>> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c:4664:8-10: 
>> WARNING: possible condition with no effect (if == else)
>> 
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> ---
>>   .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 
>> ----
>>   1 file changed, 4 deletions(-)
>> 
>> diff --git 
>> a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c 
>> b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>> index ecea008f19d3..d940dfa5ae43 100644
>> --- 
>> a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>> +++ 
>> b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>> @@ -4661,10 +4661,6 @@ void dml32_CalculateMinAndMaxPrefetchMode(
>>   	} else if (AllowForPStateChangeOrStutterInVBlankFinal == 
>> dm_prefetch_support_uclk_fclk_and_stutter) {
>>   		*MinPrefetchMode = 0;
>>   		*MaxPrefetchMode = 0;
>> -	} else if (AllowForPStateChangeOrStutterInVBlankFinal ==
>> -			dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
>> -		*MinPrefetchMode = 0;
>> -		*MaxPrefetchMode = 3;
>>   	} else {
>>   		*MinPrefetchMode = 0;
>>   		*MaxPrefetchMode = 3;
> 
> What tree did you use to generate the patch? On amd-staging-drm-next,
> MaxPrefetchMode is 0 for the second last branch, which is the correct
> one, so this patch isnt needed.

     I'm using the stable tree, sorry, if it is out of
date just ignore it then.

     Thanks!

     José.
