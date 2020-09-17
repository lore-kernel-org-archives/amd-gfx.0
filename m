Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36406C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 14:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD33020639
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 14:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uwWaPTcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD33020639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9616EC37;
	Thu, 17 Sep 2020 14:46:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE806EC37
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 14:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeO37jrAhD3kfjYQdURyL4JZEN6KUNyUUiiNUKSB1WoK+i4PNARH5KRfvOCBtnT3kTZnwnFtfUnPNo/75RXGGdVGSV1al2ZnJgUM0uSQKb6oQJoQG2UhgJyjQUsVv9t0PL7O/cY2gC25rkTA/1g1ZXqtxeRplZ6501WeEXrwZYtrfKARL0myvlY/to+abvjHmhSIUfPGS4gPQ+6tGeKECvKkTzML0FbMw5ydXZxV8ieFjx8ul9LlsV8kKqgGATDCABZbJAvCsUC3jDv6fNwrKy1HlCzRWmqSh8ldFmKDGgqOeRZmcyxS3JvpH1nbkVxkWpagLG47h591Bl5NKe0BDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt9YoiYUK1ADnXgRvAFSsAuLkYmlcSLI1e3qfN9I+Sk=;
 b=ltRP7msfhyCJALZ1HaRnRH2izZMT0l7pJw0tg/eIFhaURemQN9TJH/TA6U6AWJaRdLuj4nY9Os/ZbTH/ofLKYbAj8VbVzYPMTjIy7/yVCChFEXOxghuIl5KVHN+tXxEpi11+n0yUV6xFQECcE88tyKY+XcoRut1rcATx4NuMSTllgU+eW7aX/q+BUe3zzRgf49leB6lP7iNN268EoNnxTpA+eKHOVS4MvRDRFbOui8x6D8UjITS3pfSZgAAWN3rSuTbSTA96R2QLzGzmi+ozV6GV4GmFHpYg9mcb4bHhz3jd1pNQCcor5QjruVP9H5EJ2bybLvOywCV4dAa/B1PXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt9YoiYUK1ADnXgRvAFSsAuLkYmlcSLI1e3qfN9I+Sk=;
 b=uwWaPTcEO7uQV9E+17dkqQXSK0veQKVWQTz4jMIC5EBjnMJVudbECqcxS/SZPVF16gQm/m/6xN/STLdiQzKj/gGUzJBmV+mGtDWLX237gzofApuuj8Nu5/esT5oAXvrIk5rU4vIDArYR4HKdHymalm4ownmug53fsN9f8bYnHjs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3887.namprd12.prod.outlook.com (2603:10b6:208:168::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 14:46:26 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 14:46:26 +0000
Subject: Re: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
To: "Zhang, Jinlong" <Jinlong.Zhang@amd.com>,
 "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
 <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
 <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
 <CADnq5_NFc+wdWLeb+aQ3QNHW7BZOXYHjCh-jzMRYTvRWBidLxA@mail.gmail.com>
 <80b70e69-8489-5f5f-a5a9-3f91431cdcfc@gmail.com>
 <DM5PR12MB1884C1E88327D7E903BC851CFB3E0@DM5PR12MB1884.namprd12.prod.outlook.com>
 <DM6PR12MB2762F8ED3915C76E3915A688EE3E0@DM6PR12MB2762.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <02898d0b-04bf-ffd0-8ad1-31824335d7ae@amd.com>
Date: Thu, 17 Sep 2020 16:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB2762F8ED3915C76E3915A688EE3E0@DM6PR12MB2762.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0074.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0074.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Thu, 17 Sep 2020 14:46:24 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64ae2e42-01aa-4e29-5296-08d85b187428
X-MS-TrafficTypeDiagnostic: MN2PR12MB3887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38878E813F2FA1F073B1D27E833E0@MN2PR12MB3887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxJv1Sq2S+YenniDETlHLUggx5pr4xtBfJnHk6aHiu3xBi1fD/U0zfdSxOZgxn3Q3Ff1FyYvjs/MQzfRCQ6/NNxweqbss2rjo3A/ZHf6XFIzs/y2UIcgTVkrbwFiW6JZYNWOMzNgnDs75CrBqq2QBfgM2fRSFmS9Z4jtADQWwwzgY/5vWn3CAO6Cb8zDIICAQuTR8UKe4WbB5j5EgXLLa3MAbbUiWSh9ipsRg9rFKni/AnrnBixf+A1jRPYc28QGRQBTmrYhD8pk4L46Ka5+iOCRCOtS0vBrqLLJ5F8VewRvvs59pflodEOV9fGzFQRmnjlBof5fPY202iXalqLSHorjrfOu9kMHIsEPYK3CD6AWJHgKzsEvW+T9VRnu5hFPMz3+0M/jbKaKuBZCU4F60hekwDUVOpdAqpYa25XYDfv9DurD5rit6B2lw3eDvRIYH3gwnn3TFL+CEZ8TjRTfyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(316002)(31696002)(8676002)(2616005)(110136005)(966005)(5660300002)(66556008)(45080400002)(54906003)(478600001)(66476007)(6486002)(66946007)(52116002)(86362001)(83080400001)(4326008)(83380400001)(2906002)(31686004)(53546011)(6666004)(36756003)(186003)(8936002)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: t7vXv6iWgX9Mtwd1RLM7yhI78UixV3CEk6EKqNyhMgxMG8FDQsbIV4cYfB2Jjx8POKwt2PXxh218OUqzHm5w/5FteIF9LS0MwyeeRheOJ6FuwhBU7h+0Rh3nO10Ie7I7oYn8jwu/zZgSfD3vS33FVLHWOIbjymkjvC5rePZgzKjh7EwP2fwYLGHv5GxhGZ5Q6j157ymgPN0iRzSjRxtfkahQJSQO5Rh7CF7uDQ6Sk9HvsXCxpe4HXuUjK9ZY+3ni/nGnCtuUCgA9cI9vfKyrY8yDMB9ldDkHk31o9BHUELdkiivkVQBg+gJZcbo+crWx54tYGcVojqbCxpCgPqSZBDSAcNHhP6ioK9T/fVVj9DaNYn8aiHgkJjcAeuPrZKC/l8rrQzyhKFqQ5GmuLn4EoN3dxZl17AGsqiv3kmA2aCwfcfHV2Qnc7Zsx4/9OJQHLxbYMIbmzcvYR/7pBGS2RHfpJ7y0uGfd8F6+64nKYvYL7qTZ/12fW43PTrpPdbGFzXn4FulN0iyoRzShIstYro2wnv++W6RpDjhok8G287q3ulkL5yv/at7p3WLzosyziZkSxMfPZo7lHSb0uo9Jq+wmTj/nxwxm/uagvsdyEUFjL/fz8Y3kd8bayuuiN3UDOK1Ve30/D4C1gaT5M76w1TLCebToF3Yst5EkfW5d+loAfITS7VxYEMc/hQzvOecb2U6ie8esefrwgh1COd4hDMg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ae2e42-01aa-4e29-5296-08d85b187428
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 14:46:26.4464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDi2Ey06jGdYN87tx5mQtDZkqLy48gp2R0PpTNhZiBI8Z2MYNkxCbhlXprmK/KJy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3887
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No idea what that is. I can include delay.h just fine in the rest of the 
driver.

Must be something DC specific.

Regards,
Christian.

Am 17.09.20 um 16:39 schrieb Zhang, Jinlong:
> HI Christian
> While #include <linux/delay.h>, it prompt ..\..\..\..\..\dc\dce\dce_aux.c(31): fatal error C1083: Cannot open include file: 'linux/delay.h': No such file or directory
> Could you help to check how to include the header of void usleep_range(unsigned long min, unsigned long max);
>
> -----Original Message-----
> From: Zhuo, Qingqing <Qingqing.Zhuo@amd.com>
> Sent: Thursday, September 17, 2020 9:02 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Jinlong <Jinlong.Zhang@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> Subject: RE: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while read edid return defer.
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Am 17.09.20 um 00:18 schrieb Alex Deucher:
>>> On Wed, Sep 16, 2020 at 6:16 PM Zhuo, Qingqing <Qingqing.Zhuo@amd.com> wrote:
>>>> [AMD Official Use Only - Internal Distribution Only]
>>>>
>>>> On Wed, Sep 16, 2020 at 3:42 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
>>>>> From: jinlong zhang <jinlong.zhang@amd.com>
>>>>>
>>>>> [why]
>>>>> while read edid return defer, then it enter to msleep, but it
>>>>> actually took more time during msleep, this will cause remaining
>>>>> edid read fail.
>>>>>
>>>>> [how]
>>>>> Replacing msleep with udelay, it will not take any extra time, edid return pass finally.
>>>> How long of a delay are we talking about here?  Some platforms don't support long udelays and someone will send a patch to change this to msleep.
>>>>
>>>> Alex
>>>>
>>>> ---------------------
>>>>
>>>> Hi Alex,
>>>>
>>>> It's between 0-5ms for generic cases, though there exist some dongle workaround cases where we will do 70ms. Would this be a concern?
>>> I think ARM has a limit of 2ms for udelay.
>> Yeah, there is even a define somewhere for this.
>> If you need a delay which is longer than this but still more precise than msleep() then there is the high precision timer sleep as alternative.
>> I've forgotten the function name to use here, but there was a LWN article about this a few years ago. You just need to google a bit.
> Hi Alex and Christian,
>
> Thanks a lot for the input! Given what's been discussed, I will drop this patch for now.
>
> Regards,
> Lillian
>
>> Regards,
>> Christian.
>>> Alex
>>>
>>>> Thank you,
>>>> Lillian
>>>>
>>>>
>>>>> Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
>>>>> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
>>>>> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
>>>>> ---
>>>>> drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>>> index 743042d5905a..cdcad82765e0 100644
>>>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>>> @@ -653,7 +653,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
>>>>>                                           if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
>>>>>                                                   (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
>>>>>                                                   if (payload->defer_delay > 0)
>>>>> -                                                       msleep(payload->defer_delay);
>>>>> +
>>>>> + udelay(payload->defer_delay * 1000);
>>>>>                                           }
>>>>>                                   }
>>>>>                                   break;
>>>>> --
>>>>> 2.17.1
>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx@lists.freedesktop.org
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
>>>>> i
>>>>> st
>>>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7
>>>>> C
>>>>> qi
>>>>> ngqing.zhuo%40amd.com%7C36c3bee68c28448769fa08d85a884619%7C3dd8961f
>>>>> e
>>>>> 48
>>>>> 84e608e11a82d994e183d%7C0%7C0%7C637358888627498307&amp;sdata=mynpHp
>>>>> i
>>>>> up
>>>>> J%2FU2o5gZNW%2Bft%2Fg2beFY86%2BzMRWoTZCghQ%3D&amp;reserved=0
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>>> t
>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CQ
>>> i
>>> ngqing.Zhuo%40amd.com%7Cd4acd0d5e65c49a7270f08d85ae37036%7C3dd8961fe4
>>> 8
>>> 84e608e11a82d994e183d%7C0%7C0%7C637359280197936127&amp;sdata=ahcoCqG9
>>> 1
>>> EDMNlHNSk4Eimh1azMtRWSX%2BKyHCdpFq1Q%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
