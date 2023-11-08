Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE267C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 14:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5BD110E77B;
	Wed,  8 Nov 2023 14:11:56 +0000 (UTC)
X-Greylist: delayed 4159 seconds by postgrey-1.36 at gabe;
 Wed, 08 Nov 2023 08:12:19 UTC
Received: from 7.mo560.mail-out.ovh.net (7.mo560.mail-out.ovh.net
 [188.165.48.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA96810E704
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 08:12:19 +0000 (UTC)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.108.20.39])
 by mo560.mail-out.ovh.net (Postfix) with ESMTP id 1175728BD4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 07:36:15 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-k8mr2 (unknown [10.110.103.34])
 by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1CE1B1FE9A;
 Wed,  8 Nov 2023 07:36:15 +0000 (UTC)
Received: from RCM-web9.webmail.mail.ovh.net ([151.80.29.21])
 by ghost-submission-6684bf9d7b-k8mr2 with ESMTPSA
 id t3ULBm86S2VjUxQAdDy9bg
 (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 08 Nov 2023 07:36:15 +0000
MIME-Version: 1.0
Date: Wed, 08 Nov 2023 09:36:14 +0200
From: =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicated argument
In-Reply-To: <d56cd927-49fc-cb4e-8abd-abc539e4d276@amd.com>
References: <20231029093926.137766-1-jose.pekkarinen@foxhound.fi>
 <d56cd927-49fc-cb4e-8abd-abc539e4d276@amd.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <e095fae915d44ccc186d5e5ee74ec119@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 185.220.101.156
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4210584177794590374
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigohhitgfgsehtkehjtddtreejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepkefhgeduudefgedvleegtddvffeghedvtdekveekjeevvdegiedtfeelhedtiedtnecukfhppeduvdejrddtrddtrddupddukeehrddvvddtrddutddurdduheeipdduhedurdektddrvdelrddvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth
X-Mailman-Approved-At: Wed, 08 Nov 2023 14:11:48 +0000
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
Cc: sunran001@208suo.com, sunpeng.li@amd.com, airlied@gmail.com,
 qingqing.zhuo@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Zhongwei.Zhang@amd.com, alex.hung@amd.com, Yao.Wang1@amd.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, skhan@linuxfoundation.org,
 alexander.deucher@amd.com, Jun.Lei@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com, linux-kernel-mentees@lists.linuxfoundation.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-30 15:54, Aurabindo Pillai wrote:
> On 10/29/2023 5:39 AM, José Pekkarinen wrote:
>> Spotted by coccicheck, there is a redundant check for
>> v->SourcePixelFormat[k] != dm_444_16. This patch will
>> remove it. The corresponding output follows.
>> 
>> drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:5130:86-122: 
>> duplicated argument to && or ||
>> 
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 
>> +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git 
>> a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c 
>> b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>> index ad741a723c0e..3686f1e7de3a 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
>> @@ -5128,7 +5128,7 @@ void 
>> dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib 
>> *mode_l
>>   			ViewportExceedsSurface = true;
>>     		if (v->SourcePixelFormat[k] != dm_444_64 && 
>> v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != 
>> dm_444_16
>> -				&& v->SourcePixelFormat[k] != dm_444_16 && 
>> v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != 
>> dm_rgbe) {
>> +				&& v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] 
>> != dm_rgbe) {
>>   			if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k] || 
>> v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
>>   				ViewportExceedsSurface = true;
>>   			}
> 
> Thanks for catching.
> 
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

     Sorry to bring this up, I just wanted to check whether this
has been applied in the following pulls or not.

     Thanks!

     José.
