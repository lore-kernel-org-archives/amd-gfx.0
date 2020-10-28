Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178AC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 01:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B2A222E9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 01:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VraR2yiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B2A222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98176E233;
	Wed, 28 Oct 2020 01:31:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F65E6E233
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 01:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BY/3MEm0B4NwAEVSfUQvmlx2wqF6BvV6J6t2gS3BUsc8yXMH7XxGQNR55jTPXJlcP8AAdjPNTqSMkTlI3wv7zKvnaTxFBoc/FFrc76PZm/riR2PNbs7y/QzKQtV8Q/DXbCOZ+9H2m6RK8Ow+128P84IWvY1nvgwNnWl68xv+5koTHWdXuKp54BeRzh490JDfnBQVOFaUOyQc6fYsQJkuQJ/DQXq/I22HDpJ3RWFKqtWk8q69HV0LXIxQej+5dQOUp7cuUgbEpsx5tFXupas3lEYHPkhRoYsSiR46S3mkYkkwznczi/C132K4kXJJc7ya5GaFiMF2VWk54jNWOCKnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o21pzIfb+ocst7GazjF+Lavdz9WmmQOJdDLAOBGssac=;
 b=lRsLD9HPGWiih26JDBOJ5qj+zT9uO4Hw7Rw8yjF2dMsTL/m2irfaclN72jtqQuFarCa97C29QXNA2qrys7vOerWUwvb2wunouaMBPz9fyjRKB8EC+xtmy7po+lU9rKcW3aY8NDx7oK8XiZEXlEbXJRA/8Re8FVTo6c0YGkp42K7YLJWf/g+xawq1ZaLezlwNSasp0GFG/5RRTs/V0x+QsMqcaDLUawv6y0OfPAEnbtnwB1YDHM4imUUsV9bta2mruUKYBVG02hzOYSa54zrzVZrlMBmb4z3P+JNO1QQrXiDthrbO3tR3b4YtDZrpQIMq1LWxM+q3EY62dLyFFVXJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o21pzIfb+ocst7GazjF+Lavdz9WmmQOJdDLAOBGssac=;
 b=VraR2yiu1xjkLL6dvIxWxHiZ4AbNp0vF1sTDh4Cpp1w77rrx/AjW9Z+YDDjsxp6OEnG5SyfwUm2kyQPMuX4t85dCJV6efNRwIWvH30cHfLwxLqP5z+DI3bJbBDRzvkCKlu0H2Z8VkJ65lve18bOTMIjAz/sVwnipNEVIhii/W/I=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 01:31:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 01:31:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Sandeep <sandy.8925@gmail.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii
Thread-Topic: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii
Thread-Index: AQHWrAqSOUBwlR64Qk+8hXTBXKdCVamrUXcAgAAAoYCAADHWgIAAtxGg
Date: Wed, 28 Oct 2020 01:31:13 +0000
Message-ID: <DM6PR12MB2619444751837A8BAAC3B2D2E4170@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201027024025.32269-1-evan.quan@amd.com>
 <CAGPDPzDniqOW7YyRQht0Fx7uqReQk3zm89rwsZJEhjtrt4WN_Q@mail.gmail.com>
 <CAGPDPzB69-phK2hPYSv_qZLO-gB1ikMrAZRDYE85pO0rFAXSFw@mail.gmail.com>
 <CAGPDPzBbEspwRvgnzKt+siPDZqGMFH0Zunc3GXVPUzSb3U0hww@mail.gmail.com>
In-Reply-To: <CAGPDPzBbEspwRvgnzKt+siPDZqGMFH0Zunc3GXVPUzSb3U0hww@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 0f9c45de-1987-40fc-7022-08d87ae1281e
x-ms-traffictypediagnostic: DM5PR1201MB0220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB02201E04B0C74E4A2E76B4DDE4170@DM5PR1201MB0220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9e6QyO0TuyAw8c4VAZsYE91nGlFmPncz4cSdmdY4mbUYJ+tpmJLhpy7RkJlnlH1Lnk1GpaZ9ezkrouLJsO5HUDWM81kjMAEo/5DJnBLUOQXu2jPnpuk3EuqKVxxUrs23RJ9kikwditHz5YBsSqG31ErP0xneliFXObT55qn91xczXjM/SkEO3SN9325UWFOeWh662SC6QfSq7dK8OOa51ndxuoMuukioJMJxGUXNkWzqB+S2a51p+crOQ1ZEsoTyNx4bztc4NSo0aS7FbszFW8otmwa1PAHU30a9SMT6/gTwcW8BjqLRQjWTDUfNuu/WRiUGUdmePV1RaRNgoiJcbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(39850400004)(346002)(396003)(316002)(26005)(66476007)(53546011)(6916009)(71200400001)(86362001)(66946007)(83380400001)(6506007)(9686003)(5660300002)(4326008)(66446008)(55016002)(7696005)(66556008)(76116006)(64756008)(33656002)(2906002)(52536014)(186003)(478600001)(54906003)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zPLJfB1Y6IIAlusqXbfHp4Ydzmx20p9o3A8nM2MhpQgAW4JVKoXBgaFBk2hTbwnLzFYdCcTLVXLau9t7OP0pnrUT+QnzpGaCLuxTYYjt2b+AmI7Otnhtsv5ibtG20REZKCsu0TAEwOMIrCuz0Ovn6Q/Jp47D+Rgd0tm/T9jiYIj1YOScUPw//pZ4jtrVUzw9vGnMOgaAuLG9xZ6rhUsEWSy7KqZJkyhhnH+iqmvBaS72++zaAnmmTkBzj99+GiHCk3SJRjkDO2+WIFzmgbLGOy7lbd5mtwQY9AngexyDZWKf+9txlcET4dZmcrHZis0+Mke3ZoULHquuPRPc5fzrScgQcaJTZhvDT3TQyXrwvfePuBgtI9StTSccufIvU4rmVtjexhc6Tc+dJIGpPGzaOoRV5zhfH7vMzApZCoc0h6RiTcC8WwQ1QxXBqVmgx0BJFLO0dskHGYZABO3q1VREgRjqvuUpdTk4+5nXYb1at56QPFETmN6sJfXTuNGIFKwIqY9d8r0LgWXcI36li9bfoRR8rkBfhQS8fSKmyyh+NY+LO9kieIyDWdO1xkmSWByvYC6O0pxY+x3L27962dx+yVm0bfuI57KGsF7ib8SQdAmSnggaiG4tNQ55YizW1WYtqxs+nR1y30TqqQK4ln1aIA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9c45de-1987-40fc-7022-08d87ae1281e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 01:31:13.1139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfgvbXTU8Bm+Iz8XHYKvJkm3gt2stRINpYh/QGJs46eruDeSFoLTVaG9juloc72T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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
