Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D70C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A542463C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tAukXfuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A542463C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DD36E4AD;
	Wed, 28 Oct 2020 08:33:56 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700063.outbound.protection.outlook.com [40.107.70.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8041E6E4AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 08:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPogcg8JDwEsITi7qfzQb2uj3JtgfWbSJ+4sals7QEeDGow4wH6FQOb7hFJh+roBx0h0nFAInB0+fEdUqvShTh6PoQ3TuI7QzP/xE7V1/1N8N1gim8YTPkrr45cJlYSNjVtUVerkKfA+udNxKWEzyUU/qQ7b0cwmv9p0EMnaPKYpCldZcSQRTkkmZpdWZXPKLNlSgLRvz/5Co8aOKrH5mhr9yeJUNzFjl4xKJ0tcY0A9paN2g4OfAR+VHaJacXElEZzQmqcO/0CblUMUz6tUTA6BVnMCuoElTWdrprtVpeGcr5mJNQrhh4kkQVzsSw02KMsB6fGojNmc6m58w865Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmoKYobvWAk1rPVnVR8Cn4it2Cd3x+6p+s3RfOJ67hw=;
 b=H+rm7FfE4mAkcgFx6rzZ8a1K+177JAg7oBZas+uFCu8y97o0iIvSlT1wA/LnbDYfvyytmkHOSGs/xe5PefOXF74Cge9LgiMenZVERj0v5jpAwjXCHMJeLgaKkaP26xiC3jIbV99JIitfcncglx1Vr9ji+LhPlqVZwpS/7k1IaMdk+aT34/wNrSNVyxQdYm3+HJhTcYO8ABpVZWEGBKZ/QAP/rBtPlW+/E6ElOuQ12qfboLvcX4hghPjijTEHeZC9VB7jWW3lHQwHqSSahMuvApg4TFNQsC4S1VFIMsrTqCUFyx3rsEaPxeyCjKqLVXbQxKF6XE+TgSt4fIORd84jGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmoKYobvWAk1rPVnVR8Cn4it2Cd3x+6p+s3RfOJ67hw=;
 b=tAukXfucWGo9xwA42HYLydYAvQFB9I32F4sKCuVPGxiMPKA63ux1s4LAtrD3im4SpB/LaYR7W0E55fYs5jH6cz76PTC27mmiLOeIIQRgteK74ZrkNcLvy9zsItbpXFxMMJ2cFT+0yMmpkPnt3qe42Faf+y4laXlQ0rB/CYeIdhU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 28 Oct 2020 08:33:54 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 08:33:54 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Sandeep <sandy.8925@gmail.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii
Thread-Topic: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii
Thread-Index: AQHWrAqSOUBwlR64Qk+8hXTBXKdCVamrUXcAgAAAoYCAADHWgIAAtxGggAB2d9A=
Date: Wed, 28 Oct 2020 08:33:53 +0000
Message-ID: <DM6PR12MB2619B3319B3CB174006B5F74E4170@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201027024025.32269-1-evan.quan@amd.com>
 <CAGPDPzDniqOW7YyRQht0Fx7uqReQk3zm89rwsZJEhjtrt4WN_Q@mail.gmail.com>
 <CAGPDPzB69-phK2hPYSv_qZLO-gB1ikMrAZRDYE85pO0rFAXSFw@mail.gmail.com>
 <CAGPDPzBbEspwRvgnzKt+siPDZqGMFH0Zunc3GXVPUzSb3U0hww@mail.gmail.com>
 <DM6PR12MB2619444751837A8BAAC3B2D2E4170@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619444751837A8BAAC3B2D2E4170@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3050e818-3953-4348-b1ec-0c46b6ed71ad;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-28T01:27:47Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3104ec3-5dbb-408b-5d29-08d87b1c3479
x-ms-traffictypediagnostic: DM6PR12MB4699:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4699A1EF298547CBE67A85A0E4170@DM6PR12MB4699.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oph/fLKLSxa+X0piUlTmwKU1FSMwbm4n9qgTUYRI//e6JgQsiz1//Wb4+XCdqE8zO/jkqOOQBqalo/uL6ZOahmV+X/Xbdz6CoR6oslddbUW90HpF0jmoNYWmubWHG3NGs3Obg0yhUu5vTtbMzkj2nDOa2oAEY2wrZ75OP9rJB3+iAOJsvEqjsJN1nj195B9IPK5rd7JVgt4/N1H7qOvkfVRG0LNde9FBzHAC09LQjuY2QvBYsNxZlRhOivF+18skEw/BwhvHKntX1+FD83FJmHw4xbVEB+/KWUCWt9KURtj8meaz2GRB8HpwAylCHRkziflIq9nkcCkgqeRPzP9Up7eT+eMISU/AqCUB1QgXkD0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(86362001)(7696005)(6506007)(53546011)(26005)(76116006)(66946007)(316002)(71200400001)(8936002)(9686003)(8676002)(54906003)(52536014)(55016002)(5660300002)(66556008)(64756008)(66446008)(6916009)(83380400001)(33656002)(186003)(2906002)(478600001)(966005)(66476007)(4326008)(2940100002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Um2RaxWNaSntHcnOnRBsdXbOsSJXP+W/D43OEzq/+gHFuahq6GaSuoaevVmKBtGGiNyvW/g3Vbj1uQvMoLJeAyeUXkuwyQzc7wKVQyTJUe3A0OFwELuslo4RXbVuVMA6KBT0nlokMzZpOGwIhAjZWcuZ3o62WSn+tBxRuwvkaJCD0aiNSjcf6+6tf/40wPZewgWyI4xem16g9pHs5GYY5zRrH3uX90JhzvIg3w4Yr2y0A9XHNzn/2NgEhKFx4Hm+jy2TrvbWjs6BA4vLfQiUaTAqn4Lw7nQYX8nYUa8Kha3Nwsb32mNeAQCKBFvGmqlDqzEllmlSYEKMlOjs/6bZLeDJAFli82ukt7ylKAR1SYvE8RXtJCeNZ6p3B9znn2pW7BqORtPIphyNasXorwS7ZX9H1rMpn1p1MI36e6FKwdOBttRiqP+k6uYf7zidEUh/ZvF4scH2H+N2157UaRJ5kqp1+JX7d/XvuxrNtx1fQh+axTbKX8QUd0vBaNVGNtjKcaTo+DaLblv1hYfhOYDJVx9L6VURD+TbSFyXOatBKneS4m+SVb44YBOtOOGG49/GyWrJe1j7nnIsBwNuIf+5Sf5QkoJ5o8S4zUZVQotBKrJUfoyE/Vmj0hR6cBmR1TzRiHVYRivjgsGCD21C6V5yOQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3104ec3-5dbb-408b-5d29-08d87b1c3479
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 08:33:54.1685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5v4nAZ86lCrpZvSrbnAQbzXmyvc3uDnrnAijN5DwOar33I6ODeHn9l6zE72e2FF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4699
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

If it turns out "PCI CONFIG reset" is used, please try the new patch series I just sent.
https://lists.freedesktop.org/archives/amd-gfx/2020-October/055327.html
https://lists.freedesktop.org/archives/amd-gfx/2020-October/055328.html
https://lists.freedesktop.org/archives/amd-gfx/2020-October/055329.html
https://lists.freedesktop.org/archives/amd-gfx/2020-October/055330.html
https://lists.freedesktop.org/archives/amd-gfx/2020-October/055331.html

BR
Evan
-----Original Message-----
From: Quan, Evan
Sent: Wednesday, October 28, 2020 9:31 AM
To: Sandeep <sandy.8925@gmail.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii

Hi Sandeep,

Did you run the tests on Hawaii?
And can you help to confirm which method is used for gpu reset? "BACO reset" or " PCI CONFIG reset" (you can grep these keywords in dmesg)?

BR
Evan
-----Original Message-----
From: Sandeep <sandy.8925@gmail.com>
Sent: Tuesday, October 27, 2020 10:33 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii

On Tue, 27 Oct 2020 at 17:04, Sandeep <sandy.8925@gmail.com> wrote:
>
>
>
> On Tue, 27 Oct, 2020, 17:01 Sandeep, <sandy.8925@gmail.com> wrote:
>>
>>
>> On Tue, 27 Oct, 2020, 08:10 Evan Quan, <evan.quan@amd.com> wrote:
>>>
>>> Which can be used for S4(hibernation) support.
>>>
>>> Change-Id: I6e4962c120a3baed14cea04ed1742ff11a273d34
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/cik.c                 | 4 +++-
>>>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c | 7 ++++---
>>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
>>> b/drivers/gpu/drm/amd/amdgpu/cik.c
>>> index 03ff8bd1fee8..5442df094102 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>>> @@ -1336,11 +1336,13 @@ cik_asic_reset_method(struct amdgpu_device
>>> *adev)
>>>
>>>         switch (adev->asic_type) {
>>>         case CHIP_BONAIRE:
>>> -       case CHIP_HAWAII:
>>>                 /* disable baco reset until it works */
>>>                 /* smu7_asic_get_baco_capability(adev, &baco_reset); */
>>>                 baco_reset = false;
>>>                 break;
>>> +       case CHIP_HAWAII:
>>> +               baco_reset = cik_asic_supports_baco(adev);
>>> +               break;
>>>         default:
>>>                 baco_reset = false;
>>>                 break;
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
>>> index 3be40114e63d..45f608838f6e 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
>>> @@ -142,12 +142,12 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BCLK_OFF_MASK,           BACO_CNTL__BACO_BCLK_OFF__SHIFT, 0, 0x00 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MASK,          BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0x00 },
>>>         { CMD_DELAY_MS, 0, 0, 0, 20, 0 },
>>> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0, 0xffffffff, 0x20 },
>>> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0,
>>> + 0xffffffff, 0x200 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ISO_DIS_MASK, BACO_CNTL__BACO_ISO_DIS__SHIFT, 0, 0x01 },
>>> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c },
>>> +       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5,
>>> + 0x1c00 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ANA_ISO_DIS_MASK, BACO_CNTL__BACO_ANA_ISO_DIS__SHIFT, 0, 0x01 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_RESET_EN_MASK, BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x00 },
>>> -       { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x10 },
>>> +       { CMD_WAITFOR, mmBACO_CNTL,
>>> + BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x100 },
>>>         { CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 0x00 },
>>>         { CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0,
>>> 0xffffffff, 0x00 }  }; @@ -155,6 +155,7 @@ static const struct
>>> baco_cmd_entry exit_baco_tbl[] =  static const struct baco_cmd_entry
>>> clean_baco_tbl[] =  {
>>>         { CMD_WRITE, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },
>>> +       { CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 },
>>>         { CMD_WRITE, mmCP_PFP_UCODE_ADDR, 0, 0, 0, 0 }  };
>>>
>>> --
>>> 2.29.0
>>
>>
>>
>> Not sure why I'm cc'd on this, I'm not a maintainer, nor does this patch seem related to any patches I've contributed.
>>
>> - Sandeep
>
>
> Ok, I just saw the other email. I'll try testing the patch and see if it fixes the hibernation bug.
>
> - Sandeep

I tested and while suspend works correctly, hibernation is completely broken. The system fails to resume from hibernation which is much worse than before.

- Sandeep
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
