Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900BAC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A8320829
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dPRdhGvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A8320829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742F36E8BF;
	Wed, 20 May 2020 22:16:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4886E8BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 22:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg4Frn5txDJ4il3C/qPhqPrYtmx8cvgeZpnAlJx55DqoLBpaCKG4YUQwSM2tE1inmxx9F39LWPmYdk6yzte5V3Dv3QUoROJSKe70ozD9OodLRiC2ECPYES+8WhsmpGVJebGbpgTHCz1jw3Rfcmv3UFJN/u7Gx0+W3PJkbV8LpRsfK0AIHRWa7w8RYn4u2meH4xGr/qlf2s31Z+LcUdtrLkIHC0+nf/ZscDkyqiwwcdy14MqVZ52aXbAWkETgqBd9RlR10IlTE1LDXFNveH+79SAEeC/6Zf28i83N4N7whcU1Wv4gWX8qAYd9qFbx9M/iQmiDwlGrjL0YCW0coHKFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf16ZO2aMjAflaS2JhcAbF1eoz94wokjgZLJo+3pJ2A=;
 b=Fo9YgWO7RJYer1sgcuYGR0FrTULo4vVLCEn0ZS+WqnawLSvPCqD89DTheoTizOSu2jYfhp5tzCOjHnNITZllmBF4SKjarkpjKILATcrVft9s0pHc/EUESvpBuixJkoK4zg6wv7hDYBcydFEeefvbZSZi93hUl0tBf7s/+E/4QQVj4UN/axTJycL/9PGa27IN+ZGCgCvYhyVSxp+hSo1vA9fh1X2a007+wxn+oSQ5x6vRGT+VnwtNiSSrMogbVKH4AZv+LQ+VkWnqHRgrSOxd0N1TZuy95nSzC8Ef2yBXjgZwUz9YptTzj4KvW1M7duRxa72gbU2ftB3HYRgtA4zpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf16ZO2aMjAflaS2JhcAbF1eoz94wokjgZLJo+3pJ2A=;
 b=dPRdhGvcUG0rup2772rdmL/5bsGx4reeQ5OCVmnOECJQIa1Eprvg5xsme5KcVJSftWiLPNL/ZjmtuDkZ/p7L84aDeHEknWnOFBeX3c5SXLAi4MGgefqYj1iCw7okl5QSOtYOJX26ll0OmY4Bh0tNQkojnuH74DEUnC4u30LXWiw=
Received: from DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15)
 by DM6PR12MB3292.namprd12.prod.outlook.com (2603:10b6:5:18c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 20 May
 2020 22:16:31 +0000
Received: from DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::14f2:ab:f326:5c2d]) by DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::14f2:ab:f326:5c2d%5]) with mapi id 15.20.3021.024; Wed, 20 May 2020
 22:16:31 +0000
From: "Koo, Anthony" <Anthony.Koo@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, Alexander Monakov <amonakov@ispras.ru>, "Kazlauskas, 
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>
Subject: RE: Flaky brightness on Renoir
Thread-Topic: Flaky brightness on Renoir
Thread-Index: AQHWLvD7LaUcO0bKI06W9CcTC/tRIqixhIrggAADzACAAAAIUA==
Date: Wed, 20 May 2020 22:16:31 +0000
Message-ID: <DM6PR12MB4545A28C450D9C717F0870AAF3B60@DM6PR12MB4545.namprd12.prod.outlook.com>
References: <20200520213638.1896-1-amonakov@ispras.ru>
 <CADnq5_OmxeZ3yEOGjCjJgOdi_-PTJ-8KhLzz7nnx_yvVLjSe9Q@mail.gmail.com>
 <792858ed-d675-ce6b-07c2-12002874ffd5@amd.com>
 <SA0PR12MB4560B79A71B3CEE54D37E45AF3B60@SA0PR12MB4560.namprd12.prod.outlook.com>
 <cbba4d03-b4a2-1357-b5ba-1caf01a25f4f@amd.com>
In-Reply-To: <cbba4d03-b4a2-1357-b5ba-1caf01a25f4f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b56953f6-38b9-4142-b4f9-0000f4780c61;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-20T22:08:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a8dfe15-8c3a-496b-282d-08d7fd0b7332
x-ms-traffictypediagnostic: DM6PR12MB3292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3292433A83163C44949A6CD2F3B60@DM6PR12MB3292.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x9Gj+GvefvhJxelhEbfFQkI1eJXkCK25tYc+HKRuEsQ1aAeUoD+YOprF1tEjDjl6x6hLK1EaSdNHGS4fcyb8LGHfoHjouXOcQWuFLNXyh1LJl6Bff7ToCIvEjrrfK5zwZTQCSJDRFHC9F1nV25vbE6TVwDDepbDqESbKiOfCZ1FWZdpOY9gw3x7kyvZOmxaHTr/5UvtX4ovrsBmIN+X8z67t4B7ZtQTZsJmMa9EvEobubPSHV4eEsR5U028AiVPEt/jw2vRiRFlS8zOuBOgNH4NH6oItLxJO0UyC47rncZkMisyKBPstIBvIWjjX4Y3P/zjj3wRP4g5iz3vv8LRFb4c/kpF2NhP0Ygc3heHXYF0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4545.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(52536014)(6636002)(66946007)(9686003)(2906002)(478600001)(66476007)(66556008)(71200400001)(966005)(4326008)(64756008)(76116006)(66446008)(55016002)(33656002)(86362001)(53546011)(6506007)(26005)(186003)(8676002)(7696005)(5660300002)(3480700007)(8936002)(316002)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ahPfYQF7Xcs+FmMHzmQkfmlfVQXHMcvndLSnev1RZds3166z8XtovrcBguSyof9eZ6lLPPdUBb6R2MWkxSmGnS+CstVIATNwk9FfRVu/g7sBKadTjQ5eSaqYkj/n703Whyw4AI7fs3LIfwbuilubE3JkXOHdh9XmL3cHDlCxkG/ebLFSHDk5KxtCtg4OiROVRZzhRds/+HM79b2OT/In4g3cnyXbM9M3s5a/eiYVZpwhog/NgWQMxCdZjJr5RKqaEABwi5Fq8Oz9zgw9UH9bOgaEmsqk1IOkyb6bXNSNqZjtVSOBN+N2EwmeY/6+FA70NJEN79dhD0buc9znQjOBHd4TVYQL4x6Fcnho0ASEgp23a6LDOfIWfCj04F+fIFOr6A/HOGlfR6q4HSJt6/r6Wk/i1QCQG0BKLjyPzEMm5XwGEEPGLxbwKaPbiZ+31ZilPt773pYCBEQ98LCkhUqhsmeVg0nvIhGaDRuTMd/cp+ekmq5GmkhpMGoUK0AUS9m0
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8dfe15-8c3a-496b-282d-08d7fd0b7332
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 22:16:31.4124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7IX3kZBpo4gIJBx5BztgIQFsVF3VZisctjcCUPQVMBtfwoTEV3KsEq9PyRL7KG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3292
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chiu,
 Michael" <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

It's touching around that area, but just the endian-ness change itself would not cause the boot-to-boot variation observed here. But it could cause broken backlight behavior.

I also don't know what driver is being tested, so I don't know other details like whether we are using DMUB on this system.
But in general, I would try to check out whether those parameters look like they are loaded correctly.

Thanks,
Anthony

-----Original Message-----
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: Wednesday, May 20, 2020 6:08 PM
To: Koo, Anthony <Anthony.Koo@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Alexander Monakov <amonakov@ispras.ru>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chiu, Michael <Michael.Chiu@amd.com>
Subject: Re: Flaky brightness on Renoir

On 2020-05-20 6:03 p.m., Koo, Anthony wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Harry,
>
> It does sound like a firmware issue.
> I think we will need to do some investigation here. I would be curious if this is a driver regression or just never worked (not sure how new the driver being tested is).
>
> This point below seems to indicate the firmware might be using some uninitialized values in some if its calculations.
> Typically these value would be things like backlight characteristic curves that are passed to the firmware via a table generated in the power helpers file, and programmed in our dc code.

Do you think this could be related to Wyatt's endian-ness fixes?

Harry

> I'm not 100% sure this is the problem, but it could be something we can take a look at from dmcu_load_iram.
>>> There's a bugreport on the tracker from a person with the same
>>> laptop model as mine that says that the threshold may vary from boot to boot.
>
> Thanks,
> Anthony
>
> -----Original Message-----
> From: Wentland, Harry <Harry.Wentland@amd.com>
> Sent: Wednesday, May 20, 2020 5:53 PM
> To: Alex Deucher <alexdeucher@gmail.com>; Alexander Monakov
> <amonakov@ispras.ru>; Kazlauskas, Nicholas
> <Nicholas.Kazlauskas@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Chiu, Michael <Michael.Chiu@amd.com>;
> Koo, Anthony <Anthony.Koo@amd.com>
> Subject: Re: Flaky brightness on Renoir
>
> We've seen similar problems internally.
>
> Michael, does this "fix" your issue?
>
> Anthony, looks like smooth_brightness is problematic on (some) renoir systems. Thoughts?
>
> Thanks,
> Harry
>
> On 2020-05-20 5:47 p.m., Alex Deucher wrote:
>> Adding some display people.
>>
>> On Wed, May 20, 2020 at 5:46 PM Alexander Monakov <amonakov@ispras.ru> wrote:
>>>
>>> Hello,
>>>
>>> I have a laptop with the recent Renoir SoC. Screen brightness is
>>> controlled via the amdgpu driver. Unfortunately it doesn't work
>>> properly: brightness doesn't go below a certain threshold. In one
>>> experiment I've found the threshold to be about 95 (of 255), which
>>> is quite high.
>>>
>>> There's a bugreport on the tracker from a person with the same
>>> laptop model as mine that says that the threshold may vary from boot to boot.
>>>
>>> So far I was able to find a workaround: avoiding
>>> dmcu_set_backlight_level like in the patch below gives more reliable
>>> backlight control (but at the expense of breaking "actual_brightness"
>>> sysfs file, because it reads from DMCU registers).
>>>
>>> What might be the problem and can I help investigate this further?
>>> Would really like to see this work properly.
>>>
>>> Alexander
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>>> b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>>> index b8a3fc505c9b..3274b0d15893 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>>> @@ -428,7 +428,7 @@ static bool dce_abm_set_backlight_level_pwm(
>>>                         backlight_pwm_u16_16, backlight_pwm_u16_16);
>>>
>>>         /* If DMCU is in reset state, DMCU is uninitialized */
>>> -       if (use_smooth_brightness)
>>> +       if (0 && use_smooth_brightness)
>>>                 dmcu_set_backlight_level(abm_dce,
>>>                                 backlight_pwm_u16_16,
>>>                                 frame_ramp,
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
