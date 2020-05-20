Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E20FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 21:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2A120823
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 21:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rIo1gk3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2A120823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83836E8BA;
	Wed, 20 May 2020 21:52:43 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671EC6E8BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 21:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+610gH6KtyTVGVbAy/agZ4Oveo2al5IH0qLZtg/OJYuoI19l0FTfPgbinlRO+o/6f+Yc1R0pwi+ehArfPOxfC0p6A7HPK9Zo0//oT5B5xrqxSHrLMUuJqNqMzRT8S/jxCElu/ICDAYo7Xs7gmocHk9wIW0BcpQZiW4jKlGqlPfdRagyZQKZlV9x/mt6NTP0u6ruHckUq37XFv7xdKLW20ZBPhQjA0q0wtWumaPG9yCHb3NGgVEhnvunabQcOgNndawgjSuezRtkEDg4DlB9o3yz9etZmQPql2hcSwXpAw0C6BTsv7xiljwCwCcdrDU4a8kAOEk65amCaMijW89cLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh1xCR6UzLI6MwthxVyxIp2dO6qUii8xfSthhuWe5u4=;
 b=iIxlp9XCm+EN8uprjxMxv7eixXvLSLy3ue/H0+yfIZsvnNXNuKfXMVevGU18uy+JgJI9xNbXe+/5u67nEIHZwAg489wBJ6lHlIojuz8bQAufXDkkUvVLFukZLGtKgYH1WV7ngkXkOM/mPdBi5aa5ax/YDu0zOx2Z+0Zjo7q8xEDvd7+TWFpaRT+at9mllgNyv3ZZoXziCaGNI/LHkfrcvjk3Cy6PZzwRdIlgje19ysUYgiCCMjB906KtTABoE2fuvwu+41zhRvJrqiAaMWA8llTlNjUH1rX06r4fAQ7B/JzwdsPvfT5BoIblOxz1OULummNRY7UolZEvQP2pfFhYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh1xCR6UzLI6MwthxVyxIp2dO6qUii8xfSthhuWe5u4=;
 b=rIo1gk3FKHmufw0fzgEfI1RmdSPIExrMhxAFbUQ6IgDmPs1g8yDJE9V5wdfyCASHJGtAEvuGfZxrBqvTFjeVHM386p2/8pZLm7TRSzZBommj4LHXVyXRjBTEXqBX/1U+F8Aa0dSqR/rfbloRKyhkgQ7uXqSCueD2TVyTeOZUatI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Wed, 20 May
 2020 21:52:39 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 21:52:39 +0000
Subject: Re: Flaky brightness on Renoir
To: Alex Deucher <alexdeucher@gmail.com>,
 Alexander Monakov <amonakov@ispras.ru>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
References: <20200520213638.1896-1-amonakov@ispras.ru>
 <CADnq5_OmxeZ3yEOGjCjJgOdi_-PTJ-8KhLzz7nnx_yvVLjSe9Q@mail.gmail.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <792858ed-d675-ce6b-07c2-12002874ffd5@amd.com>
Date: Wed, 20 May 2020 17:52:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CADnq5_OmxeZ3yEOGjCjJgOdi_-PTJ-8KhLzz7nnx_yvVLjSe9Q@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BN1PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:408:e2::17) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.4.158] (165.204.84.11) by
 BN1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:408:e2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 21:52:37 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0121b19-6caa-4421-8b83-08d7fd081d4f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4587:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45875BF00DAB51299598AAEF8CB60@MW3PR12MB4587.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpSf8iu8d2oCuXY/jfyCGVizzYtw3Ahmer2Pz6ozfy0TrfJkrF6zo4KJRJOgCgS+7gJRVg0ku0nsPQT5ubwp0628ml35xBqW9MjnQNvJeHp72K18g6ZEjKLjhID+n9xENbFVsBtBLBXNU0Rw2Juz2bJ1pDMMe1tzmf9YZwise7mWMUfg3PxUnj3VJ67YEpuAeOOBnuwlEmeolAw0m/lI4jdBAF96qwUCL3s1IvVVtrtGz5llQSJeuXE+SZUvRm0C10AsKyS5fz9ZgxxHlFRZeSIU3w0wJ1hcD0xP7tNmGbxPG6+qEHWyL9GhMopeJge6Mc0N6O6WxPgSU5sjfnVaHPGNfntgbO5NUtnjXF4Y7hwL9fGVNFLt4tQpJ6hmtovINkLgh34smjNiXZhFjyPcKRhk75fr/oGGwu/INA+sX/1inmaos5ERoPS1dOofzIa2uijF9ih3JVL6K/6eB21Vt5ShbarYXFCxLHD4PNZHgK7FPUIkEqwLzxBf0P1jRTrXTHT/ue8d8H5HILob4gciDpzDUtDdJ4vze7EVkeR8Ybk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(110136005)(316002)(16576012)(54906003)(4326008)(5660300002)(31686004)(6636002)(2616005)(6486002)(956004)(31696002)(6666004)(8936002)(52116002)(8676002)(26005)(66946007)(53546011)(478600001)(3480700007)(66556008)(66476007)(966005)(36756003)(16526019)(186003)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1T+y2AwYtD8pgTcSikYjLTaFjCUH1CAJdADofMLNwaW1slmNpRJgK/4DsHH7SS5iupe3eTfBwyFjxo0IMEhoyOjXwdUUUIPIz0vVFGYW0JvRkbL2d90AuHIqxqItljLB3v24YhZfg4wip6+2bLauKO4fiPRVDGVXFw/oW2zZlW4NptW9Fe/LPOw+hleBfDA3VGzlixxpfMPaTNJVUbQBY+0e4shkMJel15XKKdyslmqxGIrduEN5y0LWcNhWsoqviOPu2n3nHGwYRWxbkHqSr39dSO4gdf6XSEfGrieXh8qrVmBUCB53RIN6kHfCQl4NelsLtljLapr2LCCfkWqeEt4Hsvv51+TUSsE3HLRKyOHRFbcyUvMfdU0KQMkJhCyBmq1WmXRjjOGDjzHFYOXN5BaW4ZttkUkDKws6bFBO1Wru5HRhy6I5mXjBjtE5ROWj6ZfWedpakJpspoUO1qBC4fUY2WSaGBgHcWCFbzvTB2BjFStLD9M+qvLW8Q6O42zt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0121b19-6caa-4421-8b83-08d7fd081d4f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 21:52:39.1424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLlSYvOEC/pXyffqYk2cOaVXIhX8Vm3EXsxX1U05d6o4EVfZF7mJzghjFFJ/OKaE2pjwtJkPmpheulduSJJgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Koo,
 Anthony" <Anthony.Koo@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Chiu, Michael" <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We've seen similar problems internally.

Michael, does this "fix" your issue?

Anthony, looks like smooth_brightness is problematic on (some) renoir
systems. Thoughts?

Thanks,
Harry

On 2020-05-20 5:47 p.m., Alex Deucher wrote:
> Adding some display people.
> 
> On Wed, May 20, 2020 at 5:46 PM Alexander Monakov <amonakov@ispras.ru> wrote:
>>
>> Hello,
>>
>> I have a laptop with the recent Renoir SoC. Screen brightness is
>> controlled via the amdgpu driver. Unfortunately it doesn't work
>> properly: brightness doesn't go below a certain threshold. In one
>> experiment I've found the threshold to be about 95 (of 255), which is
>> quite high.
>>
>> There's a bugreport on the tracker from a person with the same laptop
>> model as mine that says that the threshold may vary from boot to boot.
>>
>> So far I was able to find a workaround: avoiding
>> dmcu_set_backlight_level like in the patch below gives more reliable
>> backlight control (but at the expense of breaking "actual_brightness"
>> sysfs file, because it reads from DMCU registers).
>>
>> What might be the problem and can I help investigate this further? Would
>> really like to see this work properly.
>>
>> Alexander
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>> index b8a3fc505c9b..3274b0d15893 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>> @@ -428,7 +428,7 @@ static bool dce_abm_set_backlight_level_pwm(
>>                         backlight_pwm_u16_16, backlight_pwm_u16_16);
>>
>>         /* If DMCU is in reset state, DMCU is uninitialized */
>> -       if (use_smooth_brightness)
>> +       if (0 && use_smooth_brightness)
>>                 dmcu_set_backlight_level(abm_dce,
>>                                 backlight_pwm_u16_16,
>>                                 frame_ramp,
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
