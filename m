Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F2FC05027
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 19:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B5C10EDF9;
	Fri, 10 Feb 2023 19:45:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224A610E29D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676056774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwSrY4DltmA/yFlYQvFrP0zXeruXNly6+GpVcGdaJm4=;
 b=cGY1HID41yCQord3AoEtAWT+IBagXv1Eb3kHuEO8niuA25gRqV1qKvjpUqFHXA419LhM2v
 GmfrYcuE7E3uGZu74sGMieaNCkxyziEOZZm2EXCOF34bblxwIp+GB5wnmmcN4HkUnGe7gH
 vCExsEy/MzA8UGWDZoS0OK5QEc4m5iY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-93-b2GQXpNjMSyTLZFFkIjaiQ-1; Fri, 10 Feb 2023 14:19:30 -0500
X-MC-Unique: b2GQXpNjMSyTLZFFkIjaiQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 w3-20020a056402268300b00487e0d9b53fso4136834edd.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 11:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gwSrY4DltmA/yFlYQvFrP0zXeruXNly6+GpVcGdaJm4=;
 b=S0f0rW4HY7rVFk88hwgVJGoWg1lYUd/4mq1xBwVDX+S9vygz83s8Ve4/SPEPcTVq39
 UV15T3CPLxoL3Roi3vGrHACvHrW7E7vfqddxYJj0lnnNlZv5xExFs+LJv0vvhyxGEtFV
 ZsGRqeRg9mFGaz+NC5Vl7LPEiDEy72Upo7bnhXlq5hGjtxrdjtoTajrMkMDg6UGDvHRf
 M6LT00XSkO1kRUdAWc4NxPjN73OyYbY91W4C0v2TQeRmfCasZS/DXuKzevlJfwJw/399
 BgM1GvIHhju02saga4tv+EFMviolVGxKB0doTX7F04GRrG+YOAGdsptofmN5mO0GQCFc
 ot6A==
X-Gm-Message-State: AO0yUKXC2YDUNWB7ez/XsvHZMxDHqlKF8rLVZaDT70iQd95j1iMdww2J
 Cl6UPVIHnnWsfVGuwsmuLUco3UnbUpZtRpL/h5rN99GT4Io8cj/jPuiklEsNFDuoiMA4AAeRoBz
 i5c/Kyja/lZpTUZiV/reaktt++A==
X-Received: by 2002:a17:906:308e:b0:88a:da35:dd51 with SMTP id
 14-20020a170906308e00b0088ada35dd51mr16539101ejv.14.1676056769344; 
 Fri, 10 Feb 2023 11:19:29 -0800 (PST)
X-Google-Smtp-Source: AK7set/LjslSqRW4K+lvECJSA5kEr2lyEGJrPcE6CF5MmtIxPBIdllG3b8htAgAt5ndbUDTe3go1qA==
X-Received: by 2002:a17:906:308e:b0:88a:da35:dd51 with SMTP id
 14-20020a170906308e00b0088ada35dd51mr16539083ejv.14.1676056769183; 
 Fri, 10 Feb 2023 11:19:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a17090634ce00b00877e1bb54b0sm2770373ejb.53.2023.02.10.11.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Feb 2023 11:19:28 -0800 (PST)
Message-ID: <74e3c9ae-b1f1-1e7b-4af1-56f918471b36@redhat.com>
Date: Fri, 10 Feb 2023 20:19:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
From: Hans de Goede <hdegoede@redhat.com>
To: Orlando Chamberlain <orlandoch.dev@gmail.com>,
 platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-2-orlandoch.dev@gmail.com>
 <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
In-Reply-To: <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 19:45:00 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rander Wang <rander.wang@intel.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Evan Quan <evan.quan@amd.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>, Mark Gross <markgross@kernel.org>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Takashi Iwai <tiwai@suse.com>, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 2/10/23 20:09, Hans de Goede wrote:
> Hi,
> 
> On 2/10/23 05:48, Orlando Chamberlain wrote:
>> Currently it manually flips the byte order, but we can instead use
>> cpu_to_be32(val) for this.
>>
>> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
>> ---
>>  drivers/platform/x86/apple-gmux.c | 18 ++----------------
>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
>> index 9333f82cfa8a..e8cb084cb81f 100644
>> --- a/drivers/platform/x86/apple-gmux.c
>> +++ b/drivers/platform/x86/apple-gmux.c
>> @@ -94,13 +94,7 @@ static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
>>  static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
>>  			     u32 val)
>>  {
>> -	int i;
>> -	u8 tmpval;
>> -
>> -	for (i = 0; i < 4; i++) {
>> -		tmpval = (val >> (i * 8)) & 0xff;
>> -		outb(tmpval, gmux_data->iostart + port + i);
>> -	}
>> +	outl(cpu_to_be32(val), gmux_data->iostart + port);
>>  }
>>  
>>  static int gmux_index_wait_ready(struct apple_gmux_data *gmux_data)
> 
> The ioport / indexed-ioport accessed apple_gmux-es likely are (part of?)
> LPC bus devices . Looking at the bus level you are now changing 4 io
> accesses with a size of 1 byte, to 1 32 bit io-access.
> 
> Depending on the decoding hw in the chip this may work fine,
> or this may work not at all.
> 
> I realized that you have asked for more testing, but most surviving
> macbooks from the older apple-gmux era appear to be models without
> a discrete GPU (which are often the first thing to break) and thus
> without a gmux.
> 
> Unless we get a bunch of testers to show up, which I doubt. I would
> prefer slightly bigger / less pretty code and not change the functional
> behavior of the driver on these older models.

A quick follow up on this, I just noticed that only the pio_write32
is doing the one byte at a time thing:

static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
{
        return inl(gmux_data->iostart + port);
}

static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
                             u32 val)
{
        int i;
        u8 tmpval;

        for (i = 0; i < 4; i++) {
                tmpval = (val >> (i * 8)) & 0xff;
                outb(tmpval, gmux_data->iostart + port + i);
        }
}

And if you look closely gmux_pio_write32() is not swapping
the order to be32 at all, it is just taking the bytes
in little-endian memory order, starting with the first
(index 0) byte which is the least significant byte of
the value.

On x86 the original code is no different then doing:

static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
                             u32 val)
{
        u8 *data = (u8 *)&val;
        int i;

        for (i = 0; i < 4; i++)
                outb(data[i], gmux_data->iostart + port + i);
}

So yeah this patch is definitely wrong, it actually swaps
the byte order compared to the original code. Which becomes
clear when you look the weird difference between the read32 and
write32 functions after this patch.

Presumably there is a specific reason why gmux_pio_write32()
is not already doing a single outl(..., val) and byte-ordering
is not the reason.

Regards,

Hans



>> @@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct apple_gmux_data *gmux_data, int port)
>>  static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
>>  			       u32 val)
>>  {
>> -	int i;
>> -	u8 tmpval;
>> -
>>  	mutex_lock(&gmux_data->index_lock);
>> -
>> -	for (i = 0; i < 4; i++) {
>> -		tmpval = (val >> (i * 8)) & 0xff;
>> -		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE + i);
>> -	}
>> -
>> +	outl(cpu_to_be32(val), gmux_data->iostart + GMUX_PORT_VALUE);
>>  	gmux_index_wait_ready(gmux_data);
>>  	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
>>  	gmux_index_wait_complete(gmux_data);
> 

