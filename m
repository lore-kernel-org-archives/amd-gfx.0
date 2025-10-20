Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08DBCCD19F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 17:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8608F10E497;
	Mon, 20 Oct 2025 17:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cFac1jYc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDA110E495;
 Mon, 20 Oct 2025 17:24:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A30A66205F;
 Mon, 20 Oct 2025 17:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF12C4CEF9;
 Mon, 20 Oct 2025 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760981063;
 bh=uN4YzlNmTDyMTVbkr8hP6fCxIeShyG12ItAxTKnPx/U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cFac1jYc5I/mpLogrxJs+C1FSnV2hXbV3gLCdZCPseI5UTHbib0gaI8Bw7ULWpQRK
 /3yIC+HPGOrBZQrCrR/9ZHTVPQIlr+dHqzdvXocWj5RB89FAcpyaPYZtWDIaFf9ttH
 s458D7gJOxhlLDUeI7EcwRltwTNawyrHYamEDpgSKf7wyWVGjSZDtHU5HvA6IGCNaM
 jenI2DlyZ7AZ5vgD3amV/0/fmmetkdx+3pS5p7vQBfT9TRHuvadRfsd8+UpKjXmhmV
 mkKbzPz0qi7umxDfn/uTfqjzzrgG0pYTdz0wWLhQFfCeNLKH0PIa8bjc1pSCXPuvi2
 mmYc2ddF7qVyw==
Message-ID: <f44ec6c9-80f9-4e5b-9cdb-e92d4c6b72fc@kernel.org>
Date: Mon, 20 Oct 2025 12:24:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] PM: Don't pass up device_resume() -EBUSY errors
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org,
 lenb@kernel.org, pavel@kernel.org, simona@ffwll.ch,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org
References: <20251020165317.3992933-1-superm1@kernel.org>
 <20251020165317.3992933-3-superm1@kernel.org>
 <CAJZ5v0g64Hu15k5sLVfxj-AADy2goyvseGGm_zTAqSPHXEaxOA@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0g64Hu15k5sLVfxj-AADy2goyvseGGm_zTAqSPHXEaxOA@mail.gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/20/2025 12:18 PM, Rafael J. Wysocki wrote:
> On Mon, Oct 20, 2025 at 6:53 PM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If a device resume returns -EBUSY the device resume sequence has
>> been skipped.
> 
> Is this actually demonstrably true in all of the cases?
> 
> And what about -EAGAIN?
> 

I haven't audited codepaths of all drivers to guarantee it to be true 
for all cases.  That's the main reason I wanted to make it RFC - to 
discuss the idea of a dedicated return code to indicate it was skipped.

Another idea I had is that we could make it return a positive number, 
and PM core could recognize that as a skip.

So would like your thoughts against the ideas currently presented:

* -EAGAIN
* -EBUSY
* Some other return code
* > 0

Whichever is decided the PM core documentation would need to be updated 
to match as well.

>> Don't show errors for this or pass it up to async
>> resume.  If resume is run again in another stage the device should
>> try again.
>>
>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/base/power/main.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index bf9c3d79c455f..f6bc7ef9a8371 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1112,7 +1112,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
>>
>>          TRACE_RESUME(error);
>>
>> -       if (error) {
>> +       if (error == -EBUSY)
>> +               pm_dev_dbg(dev, state, async ? " async" : "");
>> +       else if (error) {
>>                  WRITE_ONCE(async_error, error);
>>                  dpm_save_failed_dev(dev_name(dev));
>>                  pm_dev_err(dev, state, async ? " async" : "", error);
>> --
>> 2.43.0
>>

