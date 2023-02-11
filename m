Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8EFC636CC
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Feb 2023 08:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD35E10E4CF;
	Mon, 13 Feb 2023 08:37:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CE810E039
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Feb 2023 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676114842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TWzbGwMUNW+n8L9sktXtMN7s4j2QAb4DRV1g3S7J38=;
 b=bu8Dmz7z3uYl5g+DMcdGoOP4fnNBbFsp5gzAXtJ4J26NXu0mYNONW1zlpggu2WRWils9nL
 /r0ZuL+j43xMsHL4QuKUNxGoB6G/4iqT79dXcfhQ0ytkPCoHtDi4cZ4mVj1L8J1FU2blG7
 p7cQMliqhaUuU1WP22r3Apd1oWJwivw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-JSKG6oSkNaaKmA7OjMU9Iw-1; Sat, 11 Feb 2023 06:27:21 -0500
X-MC-Unique: JSKG6oSkNaaKmA7OjMU9Iw-1
Received: by mail-ej1-f69.google.com with SMTP id
 l18-20020a1709067d5200b008af415fdd80so4427855ejp.21
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Feb 2023 03:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+TWzbGwMUNW+n8L9sktXtMN7s4j2QAb4DRV1g3S7J38=;
 b=cBOD5M4KKG8+hq/rhH+jBubtIo31TxYXvnG680dH23d2nvqN+Sc+cX1n6Y7xmnJd8k
 e6MKvIGJdp060Jx6sz4PyOb/itYjJCYB7vpmFmtWV9y5sgm1WVW3QSbiUQE7yP+tpKpW
 SgeJu6nr770P2eq3T0BMsUg2lX0bLE0itcFpEXsLrAKuQMwyeDYlngYMVuoyIm+vZsvC
 AWNC9sZgNflkzE/495Z9IOD4tQmI+fFMfSr77OJXe2uekgcAaszhjgBiECfj2syoWixt
 IuEHJ9mFKmrBX+4BD/9YleZZh7bqikPGAiFEzasx3J/4ddCmL+F9ekGkmgHPTekY6g5g
 3yiw==
X-Gm-Message-State: AO0yUKXp6CCkiJe9P6TYCXusbbkQKop0k64IqVzyQiy0Yn3I/DgHj+z9
 CFFhE3015rY1M3o+A5yEkTY4/+kwWioLKDckYIahNVen3CIRRzzGa7376Ph2v1WO/FLIjFD3l53
 ghx9PeZHDzKWuBqEPD5/FwAPkpg==
X-Received: by 2002:a17:906:6a15:b0:895:58be:94d with SMTP id
 qw21-20020a1709066a1500b0089558be094dmr27969770ejc.3.1676114840053; 
 Sat, 11 Feb 2023 03:27:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+CyhHdGJQxbppC+Q3hsT5VQygsBF0ob0PfWcSKa7EUj25Mb49WmvY947P55TtHbER842rQYw==
X-Received: by 2002:a17:906:6a15:b0:895:58be:94d with SMTP id
 qw21-20020a1709066a1500b0089558be094dmr27969751ejc.3.1676114839857; 
 Sat, 11 Feb 2023 03:27:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170906490b00b0084d4b8f5889sm3715458ejq.102.2023.02.11.03.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Feb 2023 03:27:19 -0800 (PST)
Message-ID: <3b6f8d89-f803-ace8-a3ae-ed9870f22b37@redhat.com>
Date: Sat, 11 Feb 2023 12:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
To: Orlando Chamberlain <orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-2-orlandoch.dev@gmail.com>
 <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
 <74e3c9ae-b1f1-1e7b-4af1-56f918471b36@redhat.com>
 <20230211103024.2a204487@redecorated-mbp>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230211103024.2a204487@redecorated-mbp>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 13 Feb 2023 08:37:42 +0000
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
Cc: alsa-devel@alsa-project.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rander Wang <rander.wang@intel.com>, Lijo Lazar <lijo.lazar@amd.com>,
 platform-driver-x86@vger.kernel.org, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Evan Quan <evan.quan@amd.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 amd-gfx@lists.freedesktop.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>, Mark Gross <markgross@kernel.org>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 linux-kernel@vger.kernel.org, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 2/11/23 00:30, Orlando Chamberlain wrote:
> On Fri, 10 Feb 2023 20:19:27 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 2/10/23 20:09, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 2/10/23 05:48, Orlando Chamberlain wrote:  
>>>> Currently it manually flips the byte order, but we can instead use
>>>> cpu_to_be32(val) for this.
>>>>
>>>> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
>>>> ---
>>>>  drivers/platform/x86/apple-gmux.c | 18 ++----------------
>>>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/apple-gmux.c
>>>> b/drivers/platform/x86/apple-gmux.c index
>>>> 9333f82cfa8a..e8cb084cb81f 100644 ---
>>>> a/drivers/platform/x86/apple-gmux.c +++
>>>> b/drivers/platform/x86/apple-gmux.c @@ -94,13 +94,7 @@ static u32
>>>> gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
>>>> static void gmux_pio_write32(struct apple_gmux_data *gmux_data,
>>>> int port, u32 val) {
>>>> -	int i;
>>>> -	u8 tmpval;
>>>> -
>>>> -	for (i = 0; i < 4; i++) {
>>>> -		tmpval = (val >> (i * 8)) & 0xff;
>>>> -		outb(tmpval, gmux_data->iostart + port + i);
>>>> -	}
>>>> +	outl(cpu_to_be32(val), gmux_data->iostart + port);
>>>>  }
>>>>  
>>>>  static int gmux_index_wait_ready(struct apple_gmux_data
>>>> *gmux_data)  
>>>
>>> The ioport / indexed-ioport accessed apple_gmux-es likely are (part
>>> of?) LPC bus devices . Looking at the bus level you are now
>>> changing 4 io accesses with a size of 1 byte, to 1 32 bit io-access.
>>>
>>> Depending on the decoding hw in the chip this may work fine,
>>> or this may work not at all.
>>>
>>> I realized that you have asked for more testing, but most surviving
>>> macbooks from the older apple-gmux era appear to be models without
>>> a discrete GPU (which are often the first thing to break) and thus
>>> without a gmux.
>>>
>>> Unless we get a bunch of testers to show up, which I doubt. I would
>>> prefer slightly bigger / less pretty code and not change the
>>> functional behavior of the driver on these older models.  
>>
>> A quick follow up on this, I just noticed that only the pio_write32
>> is doing the one byte at a time thing:
>>
>> static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int
>> port) {
>>         return inl(gmux_data->iostart + port);
>> }
>>
>> static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int
>> port, u32 val)
>> {
>>         int i;
>>         u8 tmpval;
>>
>>         for (i = 0; i < 4; i++) {
>>                 tmpval = (val >> (i * 8)) & 0xff;
>>                 outb(tmpval, gmux_data->iostart + port + i);
>>         }
>> }
>>
>> And if you look closely gmux_pio_write32() is not swapping
>> the order to be32 at all, it is just taking the bytes
>> in little-endian memory order, starting with the first
>> (index 0) byte which is the least significant byte of
>> the value.
>>
>> On x86 the original code is no different then doing:
>>
>> static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int
>> port, u32 val)
>> {
>>         u8 *data = (u8 *)&val;
>>         int i;
>>
>>         for (i = 0; i < 4; i++)
>>                 outb(data[i], gmux_data->iostart + port + i);
>> }
>>
>> So yeah this patch is definitely wrong, it actually swaps
>> the byte order compared to the original code. Which becomes
>> clear when you look the weird difference between the read32 and
>> write32 functions after this patch.
>>
>> Presumably there is a specific reason why gmux_pio_write32()
>> is not already doing a single outl(..., val) and byte-ordering
>> is not the reason.
>>
>> Regards,
>>
>> Hans
> 
> Sounds like it may be better to just drop this patch as there's very
> little benefit for the risk of causing a regression.

Yes if it is easy to drop this please drop this.

And the same more or less applies to 2/9. I would rather have
an extra "if () ... else ..."  in the code in a couple of places
then change behavior on old hw where we cannot get proper test
coverage (but will likely eventually get regressions reports
if we break things).

Thanks & Regards,

Hans



>>>> @@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct
>>>> apple_gmux_data *gmux_data, int port) static void
>>>> gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
>>>> u32 val) {
>>>> -	int i;
>>>> -	u8 tmpval;
>>>> -
>>>>  	mutex_lock(&gmux_data->index_lock);
>>>> -
>>>> -	for (i = 0; i < 4; i++) {
>>>> -		tmpval = (val >> (i * 8)) & 0xff;
>>>> -		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE
>>>> + i);
>>>> -	}
>>>> -
>>>> +	outl(cpu_to_be32(val), gmux_data->iostart +
>>>> GMUX_PORT_VALUE); gmux_index_wait_ready(gmux_data);
>>>>  	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
>>>>  	gmux_index_wait_complete(gmux_data);  
>>>   
>>
> 

