Return-Path: <SRS0=MTnY=7D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B854EC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768F5206F6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2020 14:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FLjfxFAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768F5206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FF86E938;
	Thu, 21 May 2020 14:51:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334886E938
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2020 14:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7MgEm/bzp9sdBCMcH/5V6SXW6Xg8t51c98poEUDfHaxDA2GVH23SIZ6vBEK3OdwDGXnbfTrxLj3nrgRW2d8NjgaERjMRe2NsbUHjicEpTeZreLr47dMe/UR9Wcgu5/1vD5i8dAupvwujW/n2yMFsktRtbWkAUDY+afjRjyybS0uYkOF6LlyUOTQkqc5gCyxtaPh+w7s2cSZ7GVrHfitICr5sRC73pkiRedRwEYK9H9Mu+6HX7epD5ndblFqDV5lGlIEq/Jua9jhDVa7RDuwyFW76XXZ5MfF/5oN4pVlYU3Xi7+sS3Ed69JC7VxhlpKGGXQaLfJq889Aj5P6E7GR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlOQfjXBnuXhoHIwWhzSPOO9a44CV0P12bdjmb8L3gg=;
 b=HM4JkbKO4w0f2LenuMKDL/ZyzbS/7XwxXaIsAb6S9V7JHQIxTKcAgwAw397BRcjqsyDnZCOb1JU6Q8XEgm72uK2MIiaqF1m6WCCZO9lw93/V5/a1WLlsA82fBsDNUW0+awz7S7iKeKPGeFmuACHb2mzHKsBOumLOHDS/9a5ytRXlmZjE/p74AvSzFZ9Gs91pi3bo+r9rEtZZe/uQ1/u8Jr/5+Pte4pZGZovjVMeqtODjUKtGlISS+N7v5/Zxyy18XoU3dFyos6XgFBDE0jKiPUPXhBFka4djjGTChN38yK9WYsVxoH5yvg11JKrKFs51Nzx2Tl0w9PdUBHBUBuv3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlOQfjXBnuXhoHIwWhzSPOO9a44CV0P12bdjmb8L3gg=;
 b=FLjfxFAFoNy9DiGoGUsfE1aTx1N8t2YCnpz8Aeqlxm2VxlNYCt96H5Go9e8EsJQaA3EaZa5xvh80NNAeEairKxqbEQV5qr+MNat4v8e1Dve2ryUl8HZfhkZ8zseHOmk9gICixPWhabBrihQ5VfV+wiQOh6RkOJ9OXYuYTKR2nJo=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 21 May
 2020 14:51:43 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::404f:1436:bda6:49ec]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::404f:1436:bda6:49ec%7]) with mapi id 15.20.3021.027; Thu, 21 May 2020
 14:51:43 +0000
From: "Chiu, Michael" <Michael.Chiu@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, Alexander Monakov <amonakov@ispras.ru>, "Kazlauskas, 
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>
Subject: RE: Flaky brightness on Renoir
Thread-Topic: Flaky brightness on Renoir
Thread-Index: AQHWLvD7fhwLCEwpk0m+jmG3TKt5HKiyngAA
Date: Thu, 21 May 2020 14:51:43 +0000
Message-ID: <DM6PR12MB3993EE7C5E3BDA063185EA2C83B70@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20200520213638.1896-1-amonakov@ispras.ru>
 <CADnq5_OmxeZ3yEOGjCjJgOdi_-PTJ-8KhLzz7nnx_yvVLjSe9Q@mail.gmail.com>
 <792858ed-d675-ce6b-07c2-12002874ffd5@amd.com>
In-Reply-To: <792858ed-d675-ce6b-07c2-12002874ffd5@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-21T14:51:40Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=129f406d-dc38-4403-bdec-00009e6901ca;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-21T14:51:40Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6de1b46f-19e7-40d6-9c19-00005db1c96a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63a74f3b-3c4f-4427-4319-08d7fd967a69
x-ms-traffictypediagnostic: DM6PR12MB2843:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2843A765218ED199664382F483B70@DM6PR12MB2843.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKqzQDIt/W0CbhPPnvB5zJ5B89+kEf8y3u+70xcbFXAHLUXSZoCD0ZnJE75dyLz7C8fgCwonQAu2jPcu4xo6kw8aPJWxfGOWqxhZ9QIDhxymUbkWinj6tUGNyYRsN3zOqGmsHZf509hbkpp5uG1+0MvthyjkuGhEfMYOVPmppxyI+UeBHZl9ygB2Q3hxpfD6oLrrZ6TM2oaGdVdFlwBFjxDkVxqzPoPuOL3urF1c05QKQXhQcTGbBRanUpiU4U7rfCWVhY9oNBLktVuDof5GR79M9R2BWcPHdUfRmftpWwsaiJeS8Ux3imWzCm1VGTgfN9q5L8Ab6LtHd5zLPj7sE305Un2uOQH98I4tM3QKN0zs/YveVcbZuVzSSEc1jaAysOUp+eU2qFGX4hAPmxotBazh0obzunFyoyGw5dPNeedJjcTEhRQNW9p3I5MJs3YrhiJ41G8ganN/xkKpqHF3LVCPA1DUbpC6yeRFEckfGG4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3993.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(71200400001)(8936002)(9686003)(8676002)(186003)(478600001)(6636002)(86362001)(6506007)(4326008)(26005)(66446008)(53546011)(66556008)(64756008)(66476007)(5660300002)(66946007)(76116006)(3480700007)(966005)(7696005)(52536014)(2906002)(54906003)(33656002)(316002)(110136005)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1kQ1gRGQXQ4OLoe80sPBI0adn7D53npwlkDGMf9+c4WZw64r+GVAGaboDAK73VEgxAWiniauSu4dDdnnHrpbhr3lNpZAKX3g22Wal0RCxG/VathtihYF7FidH778VIgNioqRruX3KVrqAubJPNFiXo3MWo15NNsVfpyaBTvK1LceUT8SOClB3s0/R054Oicah1l0PvMFEddk0j/nLwdEijfZaVV50KvSGqyaBYivOMxqfcI9+kB1LWbET22RE2u1jzAI+I48wqkhqm1bX0e+TBX6Lkc6HJ4ZflNyafZmeaszf31iInFIKtet3lOv2BDY9rLwTBEYSkBIvtLFqkh501senbCpq5nzbq6jKyZ2EaHttcbkUoUCYNLQcicBFrD2qnUOY12rgJ6pytpiNPGwXC0y8456zdZFcB7YZNH92/01qOlskTmPzR0byy39iuKfdNYaHLhUtPeCdsJ8GeLr068RiHwkH34O2DbrQ0NpMa9q3kvZRiMS8zz2W5fKzpl2
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a74f3b-3c4f-4427-4319-08d7fd967a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 14:51:43.5555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5KRkkhrQsXSUQdgLn0sh96l3qPRt72cU9yxuTr0oKHW7D5b8UJvtFgip1UhdQSK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2843
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koo,
 Anthony" <Anthony.Koo@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Harry,

" Michael, does this "fix" your issue?"

Yes, the change "fixes" the issue.  It has the same effect as removing renoir_dmcu.bin work-around, where backlight control starts to work.


Thanks again,
Michael


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
