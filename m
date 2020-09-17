Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0986C35257
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 14:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5845E2223C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 14:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XEIlPp7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5845E2223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D127B6EC36;
	Thu, 17 Sep 2020 14:39:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF4646EC36
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 14:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdB5txihH2v2k39fecQTP0SIAJjGn1mQ/HPibvZN9rYGX9u+OkoK54s+MMV0TLnK8HUkFqeoc/Gx39qAq9+0UeCQG7/MuXVgLoTh/yJEM40ECh9subbARn7yGjJcAd/FOUWO5Il8x8DLs3Ht9i+fFNn3guS2gPACan5oC0IXl28JxwarIeLnkzBpEIlPWZR+MCLJrIUSS29ULDtUp7olqj7Aqphx+JaSDJrKB1+cjiBtwGJOIPPVukeoUO34TU0igRNkP9SPWBmr2VaSTkv3xQm0aH+UXkSBT1vREXskO7GSanucnln4bfbF7Aqs9ACp1coixWXTwQ88G6wCUO65Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR5xpoGWiLTW2h69CXQaxt49dv/Jr5EwVJwavVaYvz0=;
 b=ZPUUtyd7DRc7gEROW2MxZDgePfZJsTGoSiADuNq36c3VeLZ2WLH6FK+9aGZW4UlupTkWK0jcG7+R5pghmD2guaUkgODF2rU2qgpWhojK3yLrx4xVw/BeQWmP0c/mHkKzo0FceoryrUATG03VngWMox68LYVEpbhHfef9pSm1GrF1BozuI3L7ssrWKh4cDhQtFP9Cz5BoXUq2gFeAt2W4LH6GUqm4PTRv+Tson5JEcDEPZ1vLGHHQU35hm6IN1k8/+mDh7RsCOzQFvA24KucvZhfBb3LJS+Yqzcb2g3eBrm3XvoJWHXGyIwTiaF12ep0RGlUrYzaJfRH89uQ9I6SAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR5xpoGWiLTW2h69CXQaxt49dv/Jr5EwVJwavVaYvz0=;
 b=XEIlPp7aE+N9wSwHdFNTuNGmYOQ+pk+c/3EAwgrNa+A0ITeyB8NgMBn9h1B237f6hLCDqysDUCKNeC8XkzEmx7cLZDoyEgBnSPB4ktBuatUWPbQm2bIuOaPuEfHRe04tsttYkEyQHxmpIAPacPkmaBd0wzLRffoSqLca2vHpzQ4=
Received: from DM6PR12MB2762.namprd12.prod.outlook.com (2603:10b6:5:45::15) by
 DM6PR12MB3994.namprd12.prod.outlook.com (2603:10b6:5:1cd::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Thu, 17 Sep 2020 14:39:52 +0000
Received: from DM6PR12MB2762.namprd12.prod.outlook.com
 ([fe80::d85e:8fb6:ec3c:755]) by DM6PR12MB2762.namprd12.prod.outlook.com
 ([fe80::d85e:8fb6:ec3c:755%4]) with mapi id 15.20.3370.018; Thu, 17 Sep 2020
 14:39:52 +0000
From: "Zhang, Jinlong" <Jinlong.Zhang@amd.com>
To: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
Thread-Topic: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while
 read edid return defer.
Thread-Index: AQHWjGC1BxnHoXd0Y0eo9gpl+i7h1qlryXeAgAAL0YCAAACGgIAAqgaAgABM7ACAABiMUA==
Date: Thu, 17 Sep 2020 14:39:51 +0000
Message-ID: <DM6PR12MB2762F8ED3915C76E3915A688EE3E0@DM6PR12MB2762.namprd12.prod.outlook.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
 <20200916193635.5169-5-qingqing.zhuo@amd.com>
 <CADnq5_O+rFANJbv1sN8SzGfyQ_kbv7xpeaSvhOKvtOSG0ui+ZA@mail.gmail.com>
 <DM5PR12MB1884F92A66DDF75EE2C770B5FB210@DM5PR12MB1884.namprd12.prod.outlook.com>
 <CADnq5_NFc+wdWLeb+aQ3QNHW7BZOXYHjCh-jzMRYTvRWBidLxA@mail.gmail.com>
 <80b70e69-8489-5f5f-a5a9-3f91431cdcfc@gmail.com>
 <DM5PR12MB1884C1E88327D7E903BC851CFB3E0@DM5PR12MB1884.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1884C1E88327D7E903BC851CFB3E0@DM5PR12MB1884.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-17T13:02:05Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b0b6abea-888f-47a1-b2a2-00009bdd7386;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 543bc0db-fdba-472a-bfa4-08d85b17896a
x-ms-traffictypediagnostic: DM6PR12MB3994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB399438DAC8B979AAC6223CB0EE3E0@DM6PR12MB3994.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: toH54IUweDdxqSRBvaGL8Y5jF242cyAPB7gc4KqfRIEbsm6HDvAGUA19s72sbY0TYe0FtCqGZ+NAKZFc1WMcTzf6fDGbYogsFxxCOhoiarUyeKkJwjYy+9P3J1iQDZjQFWgLK2QuwZKbswuAeWUwUxnrCcuXPwLwoPSd2gI924sl5R0J7NdUKctG/P70LZ7iDNbCWDby/1mWq3+tUvtXEQOwGVYc1cXOJF9b6RDDFAZBpphtxAQ3a+KXD2CS/B3WGpDzSA7aar7JEdNDwlx340/Ckuerm1mfg3/F9KpItg50U/CE8ZDQejSROhN/sxUIYK1jyHdIVCeyVWUx8uFgJvJACF65BuYPyDOqJTCpo+6pXGiuR+xt7Y+AeDxy+FuwzVaxwLergMEKo17AsMj4JQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2762.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(55016002)(66556008)(76116006)(8936002)(66946007)(66476007)(9686003)(64756008)(71200400001)(66446008)(4326008)(6506007)(26005)(53546011)(83380400001)(2906002)(966005)(83080400001)(52536014)(7696005)(8676002)(5660300002)(316002)(186003)(478600001)(33656002)(86362001)(54906003)(45080400002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wHQbJIz1N37SazR1oDepLAZCw9hML0fV10nBSczDliX8zpBGj1md0G61oqohZXdVCna5ofVpgyT/MGyjB5TKGDpoTo/mQ9lKMj/0QzIpzsE9y83kmzma0BrKR1SGp9qVlQNMMtYCyyTzxc6GqQH3qUCaekvLz/BhAr0Eo5qrkwd+2WFxJptStz+JHIYjLioHlktTaKyyhxNc8djtNcnK+hHAVKSiOcBHiXzk+7WGtqcutol83mt7ru2383MwgxzEH2VDE2aV/SU16In4wBWCzpEQl1AiLBddGr11xZ0nmZSWau4zx95E1WEnxnxHTszPjPgBLMw8k1bUVvFktP0/rCqaZrVof7/KSdzVwRM9QFLPvlWGo7gJ4Y6KjBWYhOxSbY2piASk+xboLzz2wor6gbtbu0Yjob4HiiZ6BRbhDBkAuZNT/gbJGysDFQkKn3dZSo9FR+6OOJQOcKKT0Ti7GqRzsH+xmJ8N8lqkhvt0+LYRl4mlClHM/qAp76m3SCSUC+popGDhSQ/VpJhGdsx7WUlY0T3YEAGh8C6AAxOV7hQEaVrZI3tApLdB0Yu0EYrkdaiOjFCKLcezmbMyYixTNh7AzDMi8okdaEZ5oQkm0CbwEcfbm4QZBFB4yyUE022i/gWT+QfirZe9Mgqy4aFbLQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543bc0db-fdba-472a-bfa4-08d85b17896a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 14:39:51.8476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dI9yIPrx1XBK7ff9n/LPR9CgBMcEE2fHB22XUVaIqkziD+q/0bl/uwIsII9mYcmj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3994
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

HI Christian
While #include <linux/delay.h>, it prompt ..\..\..\..\..\dc\dce\dce_aux.c(31): fatal error C1083: Cannot open include file: 'linux/delay.h': No such file or directory
Could you help to check how to include the header of void usleep_range(unsigned long min, unsigned long max);

-----Original Message-----
From: Zhuo, Qingqing <Qingqing.Zhuo@amd.com> 
Sent: Thursday, September 17, 2020 9:02 PM
To: Koenig, Christian <Christian.Koenig@amd.com>; Alex Deucher <alexdeucher@gmail.com>
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Jinlong <Jinlong.Zhang@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
Subject: RE: [PATCH 04/15] drm/amd/display: Replace msleep with udelay while read edid return defer.

[AMD Official Use Only - Internal Distribution Only]

Am 17.09.20 um 00:18 schrieb Alex Deucher:
>> On Wed, Sep 16, 2020 at 6:16 PM Zhuo, Qingqing <Qingqing.Zhuo@amd.com> wrote:
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>>On Wed, Sep 16, 2020 at 3:42 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
>>>> From: jinlong zhang <jinlong.zhang@amd.com>
>>>>
>>> >[why]
>>>>while read edid return defer, then it enter to msleep, but it 
>>>>actually took more time during msleep, this will cause remaining 
>>>>edid read fail.
>>>>
>>>> [how]
>>>> Replacing msleep with udelay, it will not take any extra time, edid return pass finally.
>>> How long of a delay are we talking about here?  Some platforms don't support long udelays and someone will send a patch to change this to msleep.
>>>
>>> Alex
>>>
>>> ---------------------
>>>
>>> Hi Alex,
>>>
>>> It's between 0-5ms for generic cases, though there exist some dongle workaround cases where we will do 70ms. Would this be a concern?
>> I think ARM has a limit of 2ms for udelay.

> Yeah, there is even a define somewhere for this.

> If you need a delay which is longer than this but still more precise than msleep() then there is the high precision timer sleep as alternative.

> I've forgotten the function name to use here, but there was a LWN article about this a few years ago. You just need to google a bit.

Hi Alex and Christian,

Thanks a lot for the input! Given what's been discussed, I will drop this patch for now.

Regards,
Lillian

>
> Regards,
> Christian.
>>
>> Alex
>>
>>> Thank you,
>>> Lillian
>>>
>>>
>>>> Signed-off-by: jinlong zhang <jinlong.zhang@amd.com>
>>>> Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
>>>> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
>>>> ---
>>>> drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>> index 743042d5905a..cdcad82765e0 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>>>> @@ -653,7 +653,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
>>>>                                          if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
>>>>                                                  (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
>>>>                                                  if (payload->defer_delay > 0)
>>>> -                                                       msleep(payload->defer_delay);
>>>> +
>>>> + udelay(payload->defer_delay * 1000);
>>>>                                          }
>>>>                                  }
>>>>                                  break;
>>>> --
>>>> 2.17.1
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
>>>> i
>>>> st
>>>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7
>>>> C
>>>> qi
>>>> ngqing.zhuo%40amd.com%7C36c3bee68c28448769fa08d85a884619%7C3dd8961f
>>>> e
>>>> 48
>>>> 84e608e11a82d994e183d%7C0%7C0%7C637358888627498307&amp;sdata=mynpHp
>>>> i
>>>> up
>>>> J%2FU2o5gZNW%2Bft%2Fg2beFY86%2BzMRWoTZCghQ%3D&amp;reserved=0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>> t 
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CQ
>> i
>> ngqing.Zhuo%40amd.com%7Cd4acd0d5e65c49a7270f08d85ae37036%7C3dd8961fe4
>> 8
>> 84e608e11a82d994e183d%7C0%7C0%7C637359280197936127&amp;sdata=ahcoCqG9
>> 1
>> EDMNlHNSk4Eimh1azMtRWSX%2BKyHCdpFq1Q%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
