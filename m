Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2282AC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 12:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F5361400
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 12:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F5361400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9D36EE96;
	Thu, 29 Apr 2021 12:46:21 +0000 (UTC)
Received: from mail-m17642.qiye.163.com (mail-m17642.qiye.163.com
 [59.111.176.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAAD46E214;
 Thu, 29 Apr 2021 12:31:11 +0000 (UTC)
Received: from vivo.com (localhost [127.0.0.1])
 by mail-m17642.qiye.163.com (Hmail) with ESMTP id AD4B3220082;
 Thu, 29 Apr 2021 20:31:09 +0800 (CST)
Message-ID: <AL*ACQCtDqK3Fh4IaI0da4om.3.1619699469579.Hmail.wanjiabing@vivo.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBSZW1vdmUgZHVwbGljYXRlIGRlY2xhcmF0aW9uIG9mIGRjX3N0YXRl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210429120841.egvj3m23kehofsfc@outlook.office365.com>
MIME-Version: 1.0
Received: from wanjiabing@vivo.com( [36.152.145.182) ] by ajax-webmail (
 [127.0.0.1] ) ; Thu, 29 Apr 2021 20:31:09 +0800 (GMT+08:00)
From: Jiabing Wan <wanjiabing@vivo.com>
Date: Thu, 29 Apr 2021 20:31:09 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGkIYSlZPTB9CTU0eSEhNSE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1ISUhNSk5CSEJMN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6N1E6OCo4Dz8KMEg9E08yGjJLHxpPFBZVSFVKTUpCTUJCT0xLS0xLVTMWGhIXVQwaFRESGhkS
 FRw7DRINFFUYFBZFWVdZEgtZQVlITVVKTklVSk9OVUpDSVlXWQgBWUFPTE9MNwY+
X-HM-Tid: 0a791d9c8d96d998kuwsad4b3220082
X-Mailman-Approved-At: Thu, 29 Apr 2021 12:46:20 +0000
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
Cc: Aric Cyr <aric.cyr@amd.com>, Jacky Liao <ziyu.liao@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 David Airlie <airlied@linux.ie>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, kael_w@yeah.net,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 
>Hi Wan,
>
>Instead of remove the first dc_state, remove the second one.
>
>Thanks

Hi Rodrigo,

Thanks for your reply.

OK, in fact, there are no functions using struct dc_state between two
struct declarations. So I think removing anyone is OK.
Remove the first one to make it more closer to user.
Remove the second one more secure.
I will send v2. You can choose one of the two.

>On 04/29, Wan Jiabing wrote:
>> There are two declarations of struct dc_state here.
>> The later one is closer to its user. Remove the former duplicate.
>> 
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>> ---
>>  drivers/gpu/drm/amd/display/dc/dc.h | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
>> index 8108b82bac60..cad045db6ea2 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>> @@ -276,8 +276,6 @@ enum surface_update_type {
>>  /* Forward declaration*/
>>  struct dc;
>>  struct dc_plane_state;
>> -struct dc_state;
>> -
>>  
>>  struct dc_cap_funcs {
>>  	bool (*get_dcc_compression_cap)(const struct dc *dc,
>> -- 
>> 2.25.1
>> 
>
>-- 
>Rodrigo Siqueira
>https://siqueira.tech

Yours,
Wan Jiabing


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
