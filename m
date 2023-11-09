Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3802AC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 14:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7CD10E237;
	Thu,  9 Nov 2023 14:43:42 +0000 (UTC)
X-Greylist: delayed 92406 seconds by postgrey-1.36 at gabe;
 Thu, 09 Nov 2023 08:53:48 UTC
Received: from 2.mo575.mail-out.ovh.net (2.mo575.mail-out.ovh.net
 [46.105.52.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF9A10E1FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 08:53:48 +0000 (UTC)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.20.214])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4C0A125ABA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 08:43:52 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-v4d2x (unknown [10.110.171.163])
 by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3B4F01FE30;
 Thu,  9 Nov 2023 08:43:51 +0000 (UTC)
Received: from RCM-web5.webmail.mail.ovh.net ([51.255.71.60])
 by ghost-submission-6684bf9d7b-v4d2x with ESMTPSA
 id xetbDMebTGXnFgAAqsDEaA
 (envelope-from <jose.pekkarinen@foxhound.fi>); Thu, 09 Nov 2023 08:43:51 +0000
MIME-Version: 1.0
Date: Thu, 09 Nov 2023 10:43:50 +0200
From: =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drm/amd/pm: replace 1-element arrays with flexible-array
 members
In-Reply-To: <2023110835-magnolia-prune-02d0@gregkh>
References: <20231108065436.13969-1-jose.pekkarinen@foxhound.fi>
 <2023110835-magnolia-prune-02d0@gregkh>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <1b20f2e4ddc0b0e94aa9a1f9c76ff75c@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 185.220.102.8
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11224940598066063041
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigohhitgfgsehtkehjtddtreejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepheeiudelueefgefgueehgfeukeejgedthedufedvudetfeduveekleefudehjedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpudekhedrvddvtddruddtvddrkedphedurddvheehrdejuddriedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
X-Mailman-Approved-At: Thu, 09 Nov 2023 14:43:40 +0000
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
Cc: Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, skhan@linuxfoundation.org, alexander.deucher@amd.com,
 evan.quan@amd.com, airlied@gmail.com, christian.koenig@amd.com,
 linux-kernel-mentees@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-08 09:29, Greg KH wrote:
> On Wed, Nov 08, 2023 at 08:54:35AM +0200, José Pekkarinen wrote:
>> The following case seems to be safe to be replaced with a flexible 
>> array
>> to clean up the added coccinelle warning. This patch will just do it.
>> 
>> drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h:76:38-63: 
>> WARNING use flexible-array member instead 
>> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>> 
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> ---
>>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h 
>> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
>> index c7b61222d258..1ce4087005f0 100644
>> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
>> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
>> @@ -73,7 +73,7 @@ struct smu8_register_index_data_pair {
>> 
>>  struct smu8_ih_meta_data {
>>  	uint32_t command;
>> -	struct smu8_register_index_data_pair register_index_value_pair[1];
>> +	struct smu8_register_index_data_pair register_index_value_pair[];
> 
> Did you just change this structure size without any need to change any
> code as well?  How was this tested?

     I didn't find any use of that struct member, if I missed
something here, please let me know and I'll happily address any
needed further work.

     José.
