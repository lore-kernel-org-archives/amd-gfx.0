Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCAFC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 14:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5102E21974
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 14:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cd0jQTGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5102E21974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D312F6EC3D;
	Thu, 17 Sep 2020 14:49:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAE36EC3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 14:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQYNh8B+NENNoeurI0io5cuo/2FdqOLec4fVZ+sNHH2sKrfAUFatEEu1KTkn5TiHeFmtNmtE0728YxhasL+ZyvPch37RTLFF6l6ELW4iDaAbOHrGUEhATXbTYvwOBxHYgGH0bX1LG/OrK0zkTv523WfwscN2wsuWAZBxUv8SIbAwvFpsoI2C0BwU4re8Z+UKaYodr5oCr9J0riz4/2OBnbslevQFKHZh25i560ZTu9uok/0D3RVYNAfhNNA+tIyBIUpNUFhjqECAjLWNc0WOnggOOw+rftBN9gGFPp/2X0+w/ASN9McIPmA53B+NwfQLX2yU8l8OCsUPE+DVIpLfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJGhNk0DNUSobsV9LMy3PDaCIQ36b8FvXcyh1OCbltg=;
 b=JlBbVKiplq8rSl2aqysqrPhAb29WOHtN6eDX8m9CjJFztJfQNLFzYjTcMSVn4FBnU474uwN2geOt9hdHGpt9b03Yvkp6j6ZFO5mi51RLmaC91Q1sEgPetR2smzolB6euVVwKBaMqvz3DudNqJQKuLyUOTu21kDX46k/Db5mt3FtCsNN5x+TLJJcBIaZArV7noRSAfPzz2Dj7JQmcm3qDixs7v+4YnajGkO2tNKUR5EqfgrjQwrb3VA81wzNylwo1Tzni13n1U02w7ZUxLqJMv08cKVFlu8hfMRmN0oOk5qoCBU0/tBcRRqLMtpk2pS6+m2MnHqGnd3HnI9PXEdh8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJGhNk0DNUSobsV9LMy3PDaCIQ36b8FvXcyh1OCbltg=;
 b=Cd0jQTGCcrF0cC2ZMrY5bLzuzq76k6nfYdL0iRtri69/NadrLpeX56ntiosX3WovJZhhaz6mGBYw+zJhUg1bgZECLFFEb9BJ+NNs0vf8EiRwecpsvAuLE4Ab+KqddtTQewxfgPeuMpveLq1aD3eXkp9PIVqvsf9LvFtzgrAX2hk=
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 14:49:08 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d0e:8fca:e862:1f05]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d0e:8fca:e862:1f05%6]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 14:49:08 +0000
From: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, Jinlong"
 <Jinlong.Zhang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
Thread-Topic: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
Thread-Index: AQHWjGC1UduKz8mDykmlsJcMNv3i8KlryXeAgAAHQHCAAAUXgIAAqgaAgABK5OCAAB1TgIAAAc8AgAAAJ/A=
Date: Thu, 17 Sep 2020 14:49:07 +0000
Message-ID: <DM5PR12MB188423FB1E7D9916F6E7236BFB3E0@DM5PR12MB1884.namprd12.prod.outlook.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
 <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
 <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
 <CADnq5_NFc+wdWLeb+aQ3QNHW7BZOXYHjCh-jzMRYTvRWBidLxA@mail.gmail.com>
 <80b70e69-8489-5f5f-a5a9-3f91431cdcfc@gmail.com>
 <DM5PR12MB1884C1E88327D7E903BC851CFB3E0@DM5PR12MB1884.namprd12.prod.outlook.com>
 <DM6PR12MB2762F8ED3915C76E3915A688EE3E0@DM6PR12MB2762.namprd12.prod.outlook.com>
 <02898d0b-04bf-ffd0-8ad1-31824335d7ae@amd.com>
In-Reply-To: <02898d0b-04bf-ffd0-8ad1-31824335d7ae@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-17T14:49:02Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cff27794-2c36-4cbd-89f8-0000ed6d86ae;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-17T14:49:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 462001ed-eaf0-45fa-b202-00001b1b89a4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca15c4db-8b3e-4f03-b99f-08d85b18d4c6
x-ms-traffictypediagnostic: DM6PR12MB4500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB450071F4A62D5CCADDEA6DC0FB3E0@DM6PR12MB4500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqKbXqM8n1IvpR7QPgVR0AUouWLz/E2KGW6q4QOePgAl2X1F2ksizOW/3UybjTrNBqzvb6kpvwGYkmiz8oKQTu2THD1ZGS2HVsSIc/Ha9tA9tVIO1L9xaaCRFUP6eN9iAsvQw8CSxEoP/2rpjqZfzpqk0EYEDc/fIvVXsmoqI1Y05oT62BFz8NuVyILt+gB/fG0xQq94omQ9h5L7rmUfJ11a61Nb1AH7U46sDBnz4qpPT1Mtrhj8uG3WTOmsrT4vdDGXSCMZvwtBa9dUFqdUJ887+BC1mAjPksKeHTd3UUf0XNWTHiJwkdLBNbwvsDm5yS4EsktfLrcSqFjw09ZUh7Gbx7dFPMMlvwz4gzo/9iLtnuGTA3Tp31ke6L53JvKYfZvxWksP1A49cqxkezH6yYBlttHy3gbXjF4Gji0oQ07czIXEV3TeEVi0w29ceHyd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(8936002)(110136005)(33656002)(26005)(7696005)(45080400002)(478600001)(83380400001)(8676002)(2906002)(4326008)(9686003)(55016002)(316002)(66446008)(6506007)(71200400001)(52536014)(83080400001)(76116006)(64756008)(186003)(86362001)(966005)(66946007)(5660300002)(66476007)(66556008)(54906003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Msf1bfKVqyoPJdUaIHObsE4y0XFLXuxpOVSrflZ9LXO4Igs+v9undEiCGFMIxkJhNgyCpmjYlflMssofCL5FY49p4tml+PwxMFWIZtxEHzqz+fXU03/xWQqRNItyruvv4/I0b2Ix8BcunhwvwbXzz+xWGwj8ueX2Y9wj3yBNClaF/E5vnWx/fA6e2IFDOHeGhWx2yu2e/yk04iP93ByAUoLTnaKDgOZd7OMFSnKBiX9VglIV24IcKmZJA6zF6PNdvkKnlMY5eyd+/jKVX+Q537tOh3EO3JRvIy+8+IyfeQXvDpenTgsU09W+aYXC3OqJeDnfa3QQaR0/yQEhS50aWZ2RCptX6iz5z5qzzDQnA2i7AQwF6ya/l1/IOy9mBn0oyC7lFwB34k7Qh8myBia12j4P1zTQzVl5Z0K8SuLBQTLQZLQOgXYyOu60f9TFoLg1Dub4BIYPuo1dp/vGXjzhL9mIDmKiKRrGzFsSQaTCIzYxvKuO60kIGdBdij4SNH/7Qmu0L4ROBng1RRLzki/EbOwsBzglfoPZBREBIfboffJR2RkdzMb1HgzeXdjUlJRC18CoPbYObPzYxooeom/imfaVprCW3fVhFHVr1u2zv56+qaz0KagShJ7rkLusXxn/VffPmjAFNuBdSP8RoY+hHg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca15c4db-8b3e-4f03-b99f-08d85b18d4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 14:49:07.8492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n376aB7T4kSY0iikJ+2EUs7oHjY607OcxTnKGV5yMsssM9y87JAdhCnFiFhZEUY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Jinlong,

This is a public thread for upstream review purpose mainly. Let's sync internally for your issue.

Thanks,
Lillian

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Thursday, September 17, 2020 10:46 AM
To: Zhang, Jinlong <Jinlong.Zhang@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Alex Deucher <alexdeucher@gmail.com>
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: Re: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while read edid return defer.

No idea what that is. I can include delay.h just fine in the rest of the driver.

Must be something DC specific.

Regards,
Christian.

Am 17.09.20 um 16:39 schrieb Zhang, Jinlong:
> HI Christian
> While #include <linux/delay.h>, it prompt 
> ..\..\..\..\..\dc\dce\dce_aux.c(31): fatal error C1083: Cannot open 
> include file: 'linux/delay.h': No such file or directory Could you 
> help to check how to include the header of void usleep_range(unsigned 
> long min, unsigned long max);
>
> -----Original Message-----
> From: Zhuo, Qingqing <Qingqing.Zhuo@amd.com>
> Sent: Thursday, September 17, 2020 9:02 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Alex Deucher 
> <alexdeucher@gmail.com>
> Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) 
> <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; 
> Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; amd-gfx list 
> <amd-gfx@lists.freedesktop.org>; Zhang, Jinlong 
> <Jinlong.Zhang@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
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
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
>>>>> l
>>>>> i
>>>>> st
>>>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%
>>>>> 7
>>>>> C
>>>>> qi
>>>>> ngqing.zhuo%40amd.com%7C36c3bee68c28448769fa08d85a884619%7C3dd8961
>>>>> f
>>>>> e
>>>>> 48
>>>>> 84e608e11a82d994e183d%7C0%7C0%7C637358888627498307&amp;sdata=mynpH
>>>>> p
>>>>> i
>>>>> up
>>>>> J%2FU2o5gZNW%2Bft%2Fg2beFY86%2BzMRWoTZCghQ%3D&amp;reserved=0
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
>>> s
>>> t
>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7C
>>> Q
>>> i
>>> ngqing.Zhuo%40amd.com%7Cd4acd0d5e65c49a7270f08d85ae37036%7C3dd8961fe
>>> 4
>>> 8
>>> 84e608e11a82d994e183d%7C0%7C0%7C637359280197936127&amp;sdata=ahcoCqG
>>> 9
>>> 1
>>> EDMNlHNSk4Eimh1azMtRWSX%2BKyHCdpFq1Q%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
