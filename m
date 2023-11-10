Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AA4C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 14:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3FD10E03C;
	Fri, 10 Nov 2023 14:01:22 +0000 (UTC)
Received: from 9.mo584.mail-out.ovh.net (9.mo584.mail-out.ovh.net
 [46.105.40.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5682110E992
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 11:27:27 +0000 (UTC)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.108.1.20])
 by mo584.mail-out.ovh.net (Postfix) with ESMTP id 3075F27A4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 11:27:24 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-2pfnd (unknown [10.110.103.155])
 by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id F29D91FE99;
 Fri, 10 Nov 2023 11:27:23 +0000 (UTC)
Received: from RCM-web4.webmail.mail.ovh.net ([176.31.235.81])
 by ghost-submission-6684bf9d7b-2pfnd with ESMTPSA
 id SggZOpsTTmU0owAAFXiS3w
 (envelope-from <jose.pekkarinen@foxhound.fi>); Fri, 10 Nov 2023 11:27:23 +0000
MIME-Version: 1.0
Date: Fri, 10 Nov 2023 13:27:23 +0200
From: =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH] drm/amd/pm: make power values signed
In-Reply-To: <6e26746d-5e4a-cc9e-fe5f-20187313fbfe@amd.com>
References: <20231109084110.4056-1-jose.pekkarinen@foxhound.fi>
 <6e26746d-5e4a-cc9e-fe5f-20187313fbfe@amd.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <334c8e5e3fcc99752d28ecf0937c53dd@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 185.220.102.4
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1413004385302324929
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeetveejleefudduueehfedvjeekteevhefhtdffkedvffegieejgeettdeuueeiteenucffohhmrghinhepfhhrvggvuggvshhkthhophdrohhrghenucfkphepuddvjedrtddrtddruddpudekhedrvddvtddruddtvddrgedpudejiedrfedurddvfeehrdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth
X-Mailman-Approved-At: Fri, 10 Nov 2023 14:01:20 +0000
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
Cc: jdelvare@suse.com, Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, skhan@linuxfoundation.org, alexander.deucher@amd.com,
 evan.quan@amd.com, airlied@gmail.com, christian.koenig@amd.com,
 linux@roeck-us.net, linux-kernel-mentees@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-10 10:25, Lazar, Lijo wrote:
> On 11/9/2023 2:11 PM, José Pekkarinen wrote:
>> The following patch will convert the power values returned by
>> amdgpu_hwmon_get_power to signed, fixing the following warnings 
>> reported
>> by coccinelle:
>> 
>> drivers/gpu/drm/amd/pm/amdgpu_pm.c:2801:5-8: WARNING: Unsigned 
>> expression compared with zero: val < 0
>> drivers/gpu/drm/amd/pm/amdgpu_pm.c:2814:5-8: WARNING: Unsigned 
>> expression compared with zero: val < 0
>> 
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> ---
>>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index e7bb1d324084..913ff62d5d5e 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -2795,7 +2795,7 @@ static ssize_t 
>> amdgpu_hwmon_show_power_avg(struct device *dev,
>>   					   struct device_attribute *attr,
>>   					   char *buf)
>>   {
>> -	unsigned int val;
>> +	int val;
> 
> Hi Alex,
> 
> It's a different code in drm-next.
> 
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/pm/amdgpu_pm.c#L2936

     I checked it, and ssize_t also removes the warning,
so you can stay with whatever is in the amd-staging-drm-next
tree and ignore this.

     Thanks!

     José.
