Return-Path: <SRS0=vyzA=7C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F54C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572EC20873
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2020 22:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cRM8aEA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572EC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4836E8BB;
	Wed, 20 May 2020 22:03:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A936E8BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2020 22:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuYlScfqMqftprXog/3qDSKOcRSeXsfCIc5bPFrJKAKcWC9B+SPlTLpSviJhMGMReNIi8/kVaVSnXlicCtGjNKzYBAuXRU6HfZBkEWbuwPxYGHyrHflUwJTOxRu/Ma3BR18pu5cBq5AnbqVGnSjuh0vO8txhcbnzO+1XdRYHbB0EK2/ZDqRlLD49jrHbr7x8oyJMdvxLE8l1byHsqnnwnDu3TIESVeib2MILL+Veo0e4pYuJHA8Rb16xyV6WY67u//t+Ji7kBa3/5yG0KJCkQ5vUMz+JZ8I7l/QyQSTYoP94FZXxKhY+/U+k8C4fYLN5OlmLdBNQNWVrduZoREVVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWpXlvippaUsYTPAlCb4wdtHg2ajjp0upQ2fQt2XUek=;
 b=NeRUjnG0oE/+UuUmYSRMXeaqVJcKvrn2slYHiVEhFnEPUaulNBWlr3xhHWOZ/sJvvGJGX/pla7BQyebmsVgcw45lfjKLRUkhJa5vSIuNciL2Qv2hrnYAtlq4OeDCeXXDzD1Dh/Al1Q/EoXeS+78KwSBPOKzNWqZR0KYSFJCF63hFSUPTm64OhHqFofkkIiFFJdesFvLgUFU4WGmMu/KvKN15o/lOUNkSQ8T2SONKFxr0nFn9xe/GEznO/K++hk6RuMewCej8HnAUobqdMdP6RhD7eaXluTb/rqlB0aaWVvfeb8kG2tiyowOTNhxRqoSdwn5CWj3RVxAb0GEuGKxOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWpXlvippaUsYTPAlCb4wdtHg2ajjp0upQ2fQt2XUek=;
 b=cRM8aEA50E+bBRLZUY6ia2coPwyP833WxiilzEhEunrDCh1Xa7ozESXvEjnbTux69S7bLJ8qTr9/naP9Jh/q29e/VcQWthQeIRWMMl8dn3UeEOsMCbjLFiGcS8DGHin0OsLZ3MJrWlm8XkwDTb8qyxjaxK1qNcD+4ahjvzYZaYI=
Received: from SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 20 May
 2020 22:03:56 +0000
Received: from SA0PR12MB4560.namprd12.prod.outlook.com
 ([fe80::c827:69cd:c298:da3d]) by SA0PR12MB4560.namprd12.prod.outlook.com
 ([fe80::c827:69cd:c298:da3d%9]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 22:03:56 +0000
From: "Koo, Anthony" <Anthony.Koo@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, Alexander Monakov <amonakov@ispras.ru>, "Kazlauskas, 
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>
Subject: RE: Flaky brightness on Renoir
Thread-Topic: Flaky brightness on Renoir
Thread-Index: AQHWLvD7LaUcO0bKI06W9CcTC/tRIqixhIrg
Date: Wed, 20 May 2020 22:03:55 +0000
Message-ID: <SA0PR12MB4560B79A71B3CEE54D37E45AF3B60@SA0PR12MB4560.namprd12.prod.outlook.com>
References: <20200520213638.1896-1-amonakov@ispras.ru>
 <CADnq5_OmxeZ3yEOGjCjJgOdi_-PTJ-8KhLzz7nnx_yvVLjSe9Q@mail.gmail.com>
 <792858ed-d675-ce6b-07c2-12002874ffd5@amd.com>
In-Reply-To: <792858ed-d675-ce6b-07c2-12002874ffd5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f145bc53-adad-4777-aabb-0000a4c2afbd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-20T21:54:18Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 153217f5-9548-46f3-bcb6-08d7fd09b0f1
x-ms-traffictypediagnostic: SA0PR12MB4398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB439846B1B18931EE45B846F3F3B60@SA0PR12MB4398.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THfOJCdJeIHCDE0XFnMyYDukxDsg1aVQTb6Yf92kXiEmxGZmxx0b4KKOpkiMW1zhZQZI8Dj//Th0jUX8As3BsJDsXMY0FPpt5/OFBXoCIy2iLDNZ5S5S9ggxoJVHxNjpraaqMnBVVhXCKeXEwPpj1ggONTTRWSRnjVPGxarJP8XoWTiTJWiwHQoxm9ZL4KmRTlESiVnuqlis1S+tqb410l8psOwj3nBvs05jUrfEjKLpzlKUaN5raxqTIrzPFNsV0Qq2qC8NvaaqR/9NgKom2j1phewm4H1VxL4ClLde6cxT9gxWgjWqMEfmgtxlXzHUsoPjDlYKCI5T4hNYjxraEV72iH2TxhjIKpokVR5x4TI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(9686003)(8936002)(110136005)(54906003)(316002)(2906002)(64756008)(66446008)(66946007)(8676002)(33656002)(55016002)(86362001)(966005)(52536014)(7696005)(76116006)(66476007)(66556008)(26005)(4326008)(478600001)(71200400001)(6636002)(186003)(6506007)(3480700007)(53546011)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ulDWF8siezRYL53WET2lWlLmCkZA2B1L4VbZzH/zYthEoYWfN2Ix8iTJuKdaKXXWNi3H7m+6I+j7uKn2epqKCnW3SpRkVMyTJjvELSdo36fdcAovLY4qtG4B/nvke9nPZlL42bRVVr497JBPIqgExZw+Yo5XJLLgOyDJdkJDJc4B7Zat3tPv8HaNKRJ50fN9zKja+8tro3IrzDknybLCIUwFYLP/XRIrXPjIjSsiEElBAOmd9XXXvnQaZZTSh6RD4gzvJFLmqBQqNbT3cU8UoQOYo6AChY0p/rQpQS6xAdt57igHBpCJgLkL90UxHJeU/CYF7O9smSLRaqnijvyMBy8UtfuocckR59W0gQKVC7YSVSuQAe6hmAjNRxPlMrdo57Z9mGlEq7eMWZ29f9ApsjhZeet+vJNiCann52T0Y87lclRh8c3sF8fVFys3JuJRGYwC4AcJQf0NFPw7vY0pqPMoVT2iy4pXVggAfoV/+m006bzHx2bx+SAo84r+TClO
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153217f5-9548-46f3-bcb6-08d7fd09b0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 22:03:55.9926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3a1wurbKwvU6MhLO9uSPfXOa4ueqdS5ZlRNifHFFfnrkxi7R6+2cIJaclYKBh/A1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

Hi Harry,

It does sound like a firmware issue.
I think we will need to do some investigation here. I would be curious if this is a driver regression or just never worked (not sure how new the driver being tested is).

This point below seems to indicate the firmware might be using some uninitialized values in some if its calculations.
Typically these value would be things like backlight characteristic curves that are passed to the firmware via a table generated in the power helpers file, and programmed in our dc code.
I'm not 100% sure this is the problem, but it could be something we can take a look at from dmcu_load_iram.
>> There's a bugreport on the tracker from a person with the same laptop
>> model as mine that says that the threshold may vary from boot to boot.

Thanks,
Anthony

-----Original Message-----
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: Wednesday, May 20, 2020 5:53 PM
To: Alex Deucher <alexdeucher@gmail.com>; Alexander Monakov <amonakov@ispras.ru>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Chiu, Michael <Michael.Chiu@amd.com>; Koo, Anthony <Anthony.Koo@amd.com>
Subject: Re: Flaky brightness on Renoir

We've seen similar problems internally.

Michael, does this "fix" your issue?

Anthony, looks like smooth_brightness is problematic on (some) renoir systems. Thoughts?

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
>> What might be the problem and can I help investigate this further?
>> Would really like to see this work properly.
>>
>> Alexander
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
>> b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
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
