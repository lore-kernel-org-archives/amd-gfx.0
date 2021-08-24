Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	HTTPS_HTTP_MISMATCH,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_MIME_MALF,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93313C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 01:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5414A61027
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 01:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5414A61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D9289D7C;
	Tue, 24 Aug 2021 01:38:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E8589D7C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 01:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQK8aT7I11Tf/wfdAUOwikK3fhu4p8sF9oRUezQref06kWV+azmTsBsFWAmdWKrrXlkMZ/6WTmZ33NXmyF58UhRxUOnYY4soktMt2+/8lTy1yR897ltsdk33hrHFFWn1qMArKeqzemkUqRmZQ21EiW/iV6+hWPf0Mb2Lb8az3Aqfq7x0IW7LbTDnJTIrq56W6d33PJmpLqCFDSfI/jxyAEptY7KxXY8Z3hT8nEF0cwD7saIjidvEDaNIiG6v0o5rXKUkMLPlU9xNXs1+Dp0kQLoil/3/HWVjJOkB4OTu/LrzppbFdeis6ywef2yD1IpJuBIFCvyzrDwuuTqTf2R9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hctYQgq8WwM4vtBzv7/kPzyCwlXbRF3vbe3I2YpSj4I=;
 b=Ya5MpSx5lFEx2AZpSpT8kNCk+uSrsGy6NTlUgCwSSR6IV2dPrpDxZ/owhPKRaUlZJGwvqifp/ETh4FtQA70FuOuuGaMNdXaIuyIfCOV8CYQJxQh+az+jsRr+5TFdwJaXoIw26YumwYeEeJFiIMuD4brdAvsb5p0lzhFgOclf2a4QeeTwdc4iZc1eKQbxnvYCZPPFoU8yfbTGx1juWLEfOruVWnxInkZhtsmVivBCg4FZiMgoFNlmKpACrWYYrTGbJz5uN+OiRYJEp9bsdSBAU6bWIMWtopJNuVMVp80HtgwrnaLZnYm5K7bCrRlOixHxufS536L+RFW8SEcLdzGhLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hctYQgq8WwM4vtBzv7/kPzyCwlXbRF3vbe3I2YpSj4I=;
 b=hoSTxB6y/jV2WJuVPteWhKsyoAAqEY6c6o8lesbtuI7Uegl7hBtyPu/kdgHCXYb/FcPnJcK1qLFUiJxl8cTyoqE1I1UKdAl/fqyx8nv2Yfe+6FjBCgH9AMPkhd8uSK8MjpxkcSkSmkdSHRiK6F5EXUlmzFVtEgb/72oS4bbWh4U=
Received: from BY5PR12MB5560.namprd12.prod.outlook.com (2603:10b6:a03:1d8::15)
 by BY5PR12MB5509.namprd12.prod.outlook.com (2603:10b6:a03:1d7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 01:38:51 +0000
Received: from BY5PR12MB5560.namprd12.prod.outlook.com
 ([fe80::75e1:c194:6ae9:695b]) by BY5PR12MB5560.namprd12.prod.outlook.com
 ([fe80::75e1:c194:6ae9:695b%3]) with mapi id 15.20.4415.024; Tue, 24 Aug 2021
 01:38:51 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Evans Jahja <evansjahja13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: Voltage control on Southern Island GPU using radeon
Thread-Topic: Voltage control on Southern Island GPU using radeon
Thread-Index: AQHXmAtTbJUUngjuzkWPiN95PvruV6uBzFmggAAUixA=
Date: Tue, 24 Aug 2021 01:38:51 +0000
Message-ID: <BY5PR12MB5560A37C4992C7858134940F8EC59@BY5PR12MB5560.namprd12.prod.outlook.com>
References: <mailman.1512.1629705579.907.amd-gfx@lists.freedesktop.org>
 <CAAq5pW_6ExZURMJkSPWr0+b_6XTzD0kON99+j9=vQVqQWL=sBQ@mail.gmail.com>
 <BY5PR12MB5560F652AA337BEFB31A9F8B8EC59@BY5PR12MB5560.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB5560F652AA337BEFB31A9F8B8EC59@BY5PR12MB5560.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-24T01:38:48Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d92e0295-95ac-448b-ae4e-1a603b435634;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1de1a1f5-ee50-4f06-bd48-08d9669fed2c
x-ms-traffictypediagnostic: BY5PR12MB5509:
x-microsoft-antispam-prvs: <BY5PR12MB550941439E887F86D820AADB8EC59@BY5PR12MB5509.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l78VAWODn6rMIyOrv51q43UvPOFe3L5HrBvNnhhHw+EOEhq2zp8/y1fnWtNbtA/FRKlQFvGnTMbDfqDR+coC+qGgNP79FX/ddULPHvnDSk4NMp+iy+puE29q659Ryk16k3vDKc6jjsan2RIBMTzsvW5jVAvX9YakjKW1G6CVJ1d8K1tvffTtOyeGiNOwRDqdnLems4qKW8fGGYdB0sgQ4Z+bAJZnKndIeqJy/M3qX5wb2ivkNFDHnUrw1D1AiMTb7tLZdF2TdqNT90wjiNoHe20dZg6tM/8Cx7VRtUgRO661s0E3rNIOQGL9xmiA3FUHy9+kEmLIr+Sqr5M6mAxwfzfgwNEsXxHdbd4moZgAr7w49zX9S6ySUFiub2LEmj+CYu0Rf9d8btdQT6/olOD5gag4gTD4P5ZZbBMJS3Rtdz1e6hliDd6TY48r+GBgpbx+/0KTTH0UVIJbZeVdFOo2scgDE6Bu9iTSZYryclVCVFsBtR6OY7jQf1Oj3bG1J8EPNfDFS3CWzKtqCKeeKNC7QDENer+9TSX1X/fHM87/Xn32VSb91SCnmmVDD1NwYJw+E6Gzru4+dj2tV+OcRxWqVSmzvM2a94zTkneO1Gmy1qvOL/azGXXoOaMyapMypOJ0YbFP+8HHCqWCXI1i46r3csWdDB3gQrhACLWg0P+Qf2SEfb1RqehHKv8axLP9jrwX6RTN2AQHYkk7FyNpQVLajw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(2940100002)(38100700002)(186003)(122000001)(83380400001)(166002)(53546011)(6506007)(30864003)(38070700005)(8936002)(26005)(8676002)(86362001)(9686003)(66446008)(110136005)(316002)(5660300002)(45080400002)(66556008)(64756008)(66946007)(71200400001)(966005)(478600001)(7696005)(55016002)(33656002)(66476007)(2906002)(76116006)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w/E5Utf+zK6nJ1ruzgJ9klmTtpjtFkH4OSd9SrMsTNZ9F/sLuQZnxCAb6Y5Z?=
 =?us-ascii?Q?tvOFkE+NgQn8Bc7zx5KQ+F6S+FYxKng99f88xcH9zOJ9dprc3tklKL0y2iFP?=
 =?us-ascii?Q?FPxXPwefeWxTDUtMCnwEMM9tNij/RfmAw0CPftlSYC7ECnFZLrdKkZnenxBX?=
 =?us-ascii?Q?ylv55Y3Y/f7FFTbsVGDzEHUVQJ3oarfNP88fOrCKDf+mytmmBxEZNuWEsooq?=
 =?us-ascii?Q?NADnk5FohuFST/KFhDg6lXBMdn9DkxwJTSB0UtM4fFdQKTwkxSWWP2IrP+bB?=
 =?us-ascii?Q?UtwCHztc1mZZ3GYymsgCeF1RlcfxF316dtnq6jCCeIRWO4AF3m1Dro6EpFW0?=
 =?us-ascii?Q?9Hnps6VdxjNVXlietKRDeQ64pfh7XWC5Q7qj/kCx1fshCoG41xHtXlIORkzs?=
 =?us-ascii?Q?GTr+0doKRXxT3WThkU6JD1eolZ2OdgzuLm/5ew6GfBk68CegyokZxiIJXGH4?=
 =?us-ascii?Q?gkBksOrwsxToqj0s9CFMg1XRhwy5ZFE3IjNKAfXtLwMrfKwqGsdK/OVXxGvC?=
 =?us-ascii?Q?Npzob36fuRZ9rKvsIG/MixKnK8Av4eEMj9x3nFFnKRHpwastxKWwK16hkTK0?=
 =?us-ascii?Q?+94PM6uuv/ZcO8iRXDAVq+8G6qWvNUWZptH6oSzkbxfsmdY6x33/z2IC8UE5?=
 =?us-ascii?Q?x6bZejJJkr3YlKszbTIGcfo1krJm3t8DyfzmkEHsBmeQirYKbDOe4XNEdJvo?=
 =?us-ascii?Q?E1bKAsMHfIOaI/Qmy83QTQh0rEmTly4qeUsm4SU1SZ/bg+FvvQruWQOGqbHe?=
 =?us-ascii?Q?jBf0k8XsmlB7n3Et97yTCsT0kHXS5rF5Me6E4QjKxEbQQ0C6D/wqoa5LdICI?=
 =?us-ascii?Q?H8NypL4bghkxHZcb9iHojQvo+U5zJjH3BdUmwVZxNkJyBhDk1VG3xQZmVr+t?=
 =?us-ascii?Q?zdnjOc4BCK+J5tMJ4gg/YZ6TcUpzai2VSIRHz6qLM2lcRk9faLf7GFZZv/DI?=
 =?us-ascii?Q?LBmhVAN6h1aDnEczjHpH61EtrFq/dJrBrKN/wY3cbvieBy0vA/x/fIISTQJz?=
 =?us-ascii?Q?VJlXDrQbMgmNvkhLqBWVvbcXjebBO5FBlyX79Bg46jvRU6UJOsxGvsqjbGi2?=
 =?us-ascii?Q?FvU+VN3n1HtTvdrPy0O8Jwn62av9YaojW1ya5Xg7fwxyrJkyGfGK9ALuiBjs?=
 =?us-ascii?Q?ONLtjPMdeq6Mb0q2fSUdvjoNM59p6BIsGPZMqeqevcAna/m8TViXS0dpMqnt?=
 =?us-ascii?Q?JZhGAUErkGWaFtyPxWCYHeih463i8hp3YAViQhiXPwdrFxBqX/4VmpJACztI?=
 =?us-ascii?Q?z7qhT/EEeTYaspEGixsnBE05OA2L8PVpovCmmJ38wP2GK1k+YRnJdK1Kozn4?=
 =?us-ascii?Q?X2tSE5YGd4bcjF3/6iYlhWCA?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR12MB5560A37C4992C7858134940F8EC59BY5PR12MB5560namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de1a1f5-ee50-4f06-bd48-08d9669fed2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 01:38:51.3068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iw32AssMiXQeQ1OmFTEfZ5eeJjGvmUEHbkkXAM/tXPMb9ZLaZihm6mCuziGfFAcP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5509
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB5560A37C4992C7858134940F8EC59BY5PR12MB5560namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Evans,
I think you can refer to the code in r600_parse_clk_voltage_dep_table.
And print the value in radeon_table->entries[i].clk(sclk in each level), th=
en override it to a lower value.
Thanks.


From: Feng, Kenneth
Sent: Tuesday, August 24, 2021 8:26 AM
To: Evans Jahja <evansjahja13@gmail.com>; amd-gfx@lists.freedesktop.org
Subject: RE: Voltage control on Southern Island GPU using radeon


[AMD Official Use Only]

Got it, Evans.
Since HAINAN is very different, need some further confirmation.
Thanks.


From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Evans Jahja
Sent: Monday, August 23, 2021 6:40 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: RE: Voltage control on Southern Island GPU using radeon

[CAUTION: External Email]
Hi Kenneth,

I understand that changing voltage 'standalone' is not a good idea. In that=
 case, would it be possible to change the voltage table so that it would gi=
ve a lower clock on certain voltage?

For example, I would like to change

sclk 900, vddc: 1050

to

sclk 800, vddc: 1050

Thanks

On Mon, Aug 23, 2021, 14:59 <amd-gfx-request@lists.freedesktop.org<mailto:a=
md-gfx-request@lists.freedesktop.org>> wrote:
Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CKenneth.Feng%40amd.com%7=
C0b14ab3222974cad7fc208d966225a2d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C=
0%7C637653120441041294%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=3DMqu4fj33aPkAwLKNNALu8=
ZNnj%2Ffn4zGn1F3qzi5SYbA%3D&reserved=3D0>
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org<mailto:amd-gfx-request@lists.=
freedesktop.org>

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org<mailto:amd-gfx-owner@lists.free=
desktop.org>

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. RE: Voltage control on Southern Island GPU using radeon
      driver (Feng, Kenneth)
   2. RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
      UVD/VCE on suspend (Quan, Evan)


----------------------------------------------------------------------

Message: 1
Date: Mon, 23 Aug 2021 07:11:10 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com<mailto:Kenneth.Feng@amd.com>>
To: "Koenig, Christian" <Christian.Koenig@amd.com<mailto:Christian.Koenig@a=
md.com>>, Evans Jahja
        <evansjahja13@gmail.com<mailto:evansjahja13@gmail.com>>, "amd-gfx@l=
ists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>"
        <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org=
>>
Subject: RE: Voltage control on Southern Island GPU using radeon
        driver
Message-ID:
        <BY5PR12MB55607F9193F1A315210D1B838EC49@BY5PR12MB5560.namprd12.prod=
.outlook.com<mailto:BY5PR12MB55607F9193F1A315210D1B838EC49@BY5PR12MB5560.na=
mprd12.prod.outlook.com>>

Content-Type: text/plain; charset=3D"utf-8"

[AMD Official Use Only]

Hi Evans
I'm sorry but I don't suggest you manually control the standalone voltage b=
ecause it's predefined with the clock value.
A decrease of voltage could hit the hardware critical path. You may need to=
 change the clock and voltage together, we call it dpm level change.
Thanks.


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Christian K?nig
Sent: Monday, August 23, 2021 2:26 PM
To: Evans Jahja <evansjahja13@gmail.com<mailto:evansjahja13@gmail.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: Voltage control on Southern Island GPU using radeon driver

[CAUTION: External Email]

Hi Evans,

in general the voltage tables are stored in the atombios and the best advic=
e I can give you is to first double check if there isn't an updated BIOS fo=
r your hardware.

But Alex is the expert on power management, especially for those older hard=
ware generations. Maybe he has another idea what to try.

Regards,
Christian.

Am 23.08.21 um 03:56 schrieb Evans Jahja:
> Hi, I have a HAINAN GPU below:
>
> lspci -nn
> 0a:00.0 Display controller [0380]: Advanced Micro Devices, Inc.
> [AMD/ATI] Sun LE [Radeon HD 8550M / R5 M230] [1002:666f]
>
> I run linux 5.13.12 on Arch on a Lenovo B40-70 laptop.
>
> I'm trying to understand more on how voltage control works and how I
> can modify the voltage for doing overvoltage / undervoltage on my GPU.
> The reason is I am observing how running programs under high GPU load
> (glmark2) would lead to crashes when I use dpm=3D1 in either radeon or
> amdgpu driver, which seems to happen when I am reaching power level 4
> (sclk 900MHz), while a lighter program like glxgears could run and
> switch power levels  between 0,1,2 without issue under both drivers. I
> believe my laptop might be faulty, but I would like to take this
> opportunity to try fixing it from the driver's side so that it can run
> anyway, however limited.
>
> Right now, I have managed to increase the performance of my GPU by
> manually overwriting the sclk to 630MHz in all performance_levels in
> radeon_pm.c, which surprises me as overriding the clock was not
> possible for me to do previously via sysfs.
>
> I've managed to tweak both sclk and mclk (or so I believe), but I
> still cannot tweak the voltage (vddc). The reason is, if I increase
> the sclk to 650MHz, the lockup will happen again. Changing the
> pl->vddc  variable does not seem to do anything. After various tracing
> with printk, I understand that on my system:
>
> pi->voltage_control =3D radeon_atom_is_voltage_gpio(rdev,
> SET_VOLTAGE_TYPE_ASIC_VDDC,
>    VOLTAGE_OBJ_GPIO_LUT)
>
> this returns false, while:
>
> si_pi->voltage_control_svi2 =3D
> radeon_atom_is_voltage_gpio(rdev, SET_VOLTAGE_TYPE_ASIC_VDDC,
>    VOLTAGE_OBJ_SVID2);
>
> This returns true, so I believe my system is using SVI2 somehow to set
> the voltage. Having no experience with SVI2, I read online and found
> out that SVI2 is a voltage regulator that uses Data / Clock pins to
> clock-in 8 bits of information and convert it to some voltage value
> between OFF, 0.5V -> 1.5V, offering fine control based on some look up
> table.
>
> My questions are as follows:
> Is it possible for me to modify my system so that I can manually
> adjust the voltage to my GPU?
>
> Thank you very much in advance. This is the first time I deal with
> kernel drivers, so any guidance on the matter helps a lot.
>
> - Evans
>
>

------------------------------

Message: 2
Date: Mon, 23 Aug 2021 07:59:36 +0000
From: "Quan, Evan" <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>
To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>, "Zhu, Ja=
mes"
        <James.Zhu@amd.com<mailto:James.Zhu@amd.com>>, "amd-gfx@lists.freed=
esktop.org<mailto:amd-gfx@lists.freedesktop.org>"
        <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org=
>>, "Liu, Leo" <Leo.Liu@amd.com<mailto:Leo.Liu@amd.com>>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com<mailto:Alexander.De=
ucher@amd.com>>, "Chen, Guchun"
        <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>, "Pan, Xinhui" <X=
inhui.Pan@amd.com<mailto:Xinhui.Pan@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
        UVD/VCE on suspend
Message-ID:
        <DM6PR12MB261946019274A3F1B5C09995E4C49@DM6PR12MB2619.namprd12.prod=
.outlook.com<mailto:DM6PR12MB261946019274A3F1B5C09995E4C49@DM6PR12MB2619.na=
mprd12.prod.outlook.com>>

Content-Type: text/plain; charset=3D"utf-8"

[AMD Official Use Only]



> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>
> Sent: Friday, August 20, 2021 10:23 PM
> To: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Zhu, Jam=
es <James.Zhu@amd.com<mailto:James.Zhu@amd.com>>;
> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Liu,=
 Leo <Leo.Liu@amd.com<mailto:Leo.Liu@amd.com>>; Deucher,
> Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Chen, Guchun
> <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Pan, Xinhui <Xinhui.Pa=
n@amd.com<mailto:Xinhui.Pan@amd.com>>
> Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> UVD/VCE on suspend
>
> On Thu, Aug 19, 2021 at 10:15 PM Quan, Evan <Evan.Quan@amd.com<mailto:Eva=
n.Quan@amd.com>> wrote:
> >
> > [AMD Official Use Only]
> >
> >
> >
> >
> >
> >
> >
> > From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> > Sent: Thursday, August 19, 2021 10:36 PM
> > To: Zhu, James <James.Zhu@amd.com<mailto:James.Zhu@amd.com>>; Quan, Eva=
n
> <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>;
> > amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuc=
her@amd.com>>; Chen, Guchun
> > <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Pan, Xinhui <Xinhui.=
Pan@amd.com<mailto:Xinhui.Pan@amd.com>>
> > Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > UVD/VCE on suspend
> >
> >
> >
> > [AMD Official Use Only]
> >
> >
> >
> > If that is done  ?
> >
> >
> >
> > +               amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> > +                                                      AMD_PG_STATE_GAT=
E);
> > +               amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> > +
> > + AMD_CG_STATE_GATE);
> >
> >
> >
> > Usual order is CG followed by PG. It comes in the else part, so less li=
kely to
> happen. Nice to fix for code correctness purpose.
> >
> > [Quan, Evan] Thanks Lijo. Make sense to me. However, actually these cod=
e
> were copied from amdgpu_uvd_idle_work_handler() of amdgpu_uvd.c.
> Same logic was used there. So, maybe @Zhu, James or @Liu, Leo can share
> some insights about this.
> >
>
> It looks like it is wrong there as well.  We should be gating the clocks =
before
> the power.  The order is also wrong in amdgpu_uvd_ring_begin_use().  We
> need to ungate the power before the clocks
[Quan, Evan] I created a patch for this. But during the verification, I got=
 the errors below
[   87.420822] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   88.443029] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   89.465386] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   90.487629] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   91.510380] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   92.533782] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   93.557400] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   94.580708] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   95.603832] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   96.627727] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, tr=
ying to reset the VCPU!!!
[   96.657453] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, gi=
ving up!!!
[   96.665892] [drm:amdgpu_device_ip_set_powergating_state [amdgpu]] *ERROR=
* set_powergating_state of IP block <uvd_v6_0> failed -1
[   97.697422] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ER=
ROR* IB test failed on uvd (-110).
[   98.721432] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ER=
ROR* IB test failed on uvd_enc0 (-110).
[   99.745407] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ER=
ROR* IB test failed on uvd_enc1 (-110).
[   99.857784] [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERRO=
R* ib ring test failed (-110).

After checking the related source code roughly. It seems the underlaying im=
plementation of -> set_powergating_state(e.g.  uvd_v6_0_set_powergating_sta=
te ) performs more jobs than just power gating. And I guess maybe some of t=
hose jobs needs to be performed after -> set_clockgating_state. James and L=
eo may comment more.

BR
Evan
>
> Alex
>
>
> >
> >
> > BR
> >
> > Evan
> >
> >
> >
> > Thanks,
> >
> > Lijo
> >
> >
> >
> > From: Zhu, James <James.Zhu@amd.com<mailto:James.Zhu@amd.com>>
> > Sent: Thursday, August 19, 2021 7:49 PM
> > To: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; amd-gfx@l=
ists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuc=
her@amd.com>>; Chen, Guchun
> > <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Lazar, Lijo <Lijo.La=
zar@amd.com<mailto:Lijo.Lazar@amd.com>>; Pan, Xinhui
> > <Xinhui.Pan@amd.com<mailto:Xinhui.Pan@amd.com>>
> > Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > UVD/VCE on suspend
> >
> >
> >
> > [AMD Official Use Only]
> >
> >
> >
> >
> >
> > Why not move changes into hw_fini?
> >
> >
> >
> > Best Regards!
> >
> >
> >
> > James Zhu
> >
> > ________________________________
> >
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bou=
nces@lists.freedesktop.org>> on behalf of
> > Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
> > Sent: Wednesday, August 18, 2021 11:08 PM
> > To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuc=
her@amd.com>>; Chen, Guchun
> > <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Lazar, Lijo <Lijo.La=
zar@amd.com<mailto:Lijo.Lazar@amd.com>>; Quan, Evan
> > <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Pan, Xinhui <Xinhui.Pan@=
amd.com<mailto:Xinhui.Pan@amd.com>>
> > Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12
> > UVD/VCE on suspend
> >
> >
> >
> > Perform proper cleanups on UVD/VCE suspend: powergate enablement,
> > clockgating enablement and dpm disablement. This can fix some hangs
> > observed on suspending when UVD/VCE still using(e.g. issue
> > "pm-suspend" when video is still playing).
> >
> > Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
> > Signed-off-by: Evan Quan <evan.quan@amd.com<mailto:evan.quan@amd.com>>
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com<mailto:xinhui.pan@amd.com=
>>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24
> ++++++++++++++++++++++++
> > drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23
> +++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > index 4eebf973a065..d0fc6ec18c29 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> > @@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
> >          int r;
> >          struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > +       /*
> > +        * Proper cleanups before halting the HW engine:
> > +        *   - cancel the delayed idle work
> > +        *   - enable powergating
> > +        *   - enable clockgating
> > +        *   - disable dpm
> > +        *
> > +        * TODO: to align with the VCN implementation, move the
> > +        * jobs for clockgating/powergating/dpm setting to
> > +        * ->set_powergating_state().
> > +        */
> > +       cancel_delayed_work_sync(&adev->uvd.idle_work);
> > +
> > +       if (adev->pm.dpm_enabled) {
> > +               amdgpu_dpm_enable_uvd(adev, false);
> > +       } else {
> > +               amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> > +               /* shutdown the UVD block */
> > +               amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> > +                                                      AMD_PG_STATE_GAT=
E);
> > +               amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> > +                                                      AMD_CG_STATE_GAT=
E);
> > +       }
> > +
> >          r =3D uvd_v6_0_hw_fini(adev);
> >          if (r)
> >                  return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > index 6d9108fa22e0..a594ade5d30a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> > @@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
> >          int r;
> >          struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > +       /*
> > +        * Proper cleanups before halting the HW engine:
> > +        *   - cancel the delayed idle work
> > +        *   - enable powergating
> > +        *   - enable clockgating
> > +        *   - disable dpm
> > +        *
> > +        * TODO: to align with the VCN implementation, move the
> > +        * jobs for clockgating/powergating/dpm setting to
> > +        * ->set_powergating_state().
> > +        */
> > +       cancel_delayed_work_sync(&adev->vce.idle_work);
> > +
> > +       if (adev->pm.dpm_enabled) {
> > +               amdgpu_dpm_enable_vce(adev, false);
> > +       } else {
> > +               amdgpu_asic_set_vce_clocks(adev, 0, 0);
> > +               amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> > +                                                      AMD_PG_STATE_GAT=
E);
> > +               amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> > +                                                      AMD_CG_STATE_GAT=
E);
> > +       }
> > +
> >          r =3D vce_v3_0_hw_fini(adev);
> >          if (r)
> >                  return r;
> > --
> > 2.29.0

------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CKenneth.Feng%40amd.com%7C0b14ab3=
222974cad7fc208d966225a2d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6376=
53120441051245%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi=
LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=3Duuc1RkDLEtK1Afn%2BzWXvVALBRAQ=
QDmp3BTAeLr0p%2BK4%3D&reserved=3D0>


------------------------------

End of amd-gfx Digest, Vol 63, Issue 280
****************************************

--_000_BY5PR12MB5560A37C4992C7858134940F8EC59BY5PR12MB5560namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Evans,<o:p></o:p></p>
<p class=3D"MsoNormal">I think you can refer to the code in <span style=3D"=
color:red">
r600_parse_clk_voltage_dep_table</span>.<o:p></o:p></p>
<p class=3D"MsoNormal">And print the value in <span style=3D"color:red">rad=
eon_table-&gt;entries[i].clk</span>(sclk in each level), then override it t=
o a lower value.<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Feng, Kenneth <br>
<b>Sent:</b> Tuesday, August 24, 2021 8:26 AM<br>
<b>To:</b> Evans Jahja &lt;evansjahja13@gmail.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> RE: Voltage control on Southern Island GPU using radeon<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Got it, Evans.<o:p></o:p></p>
<p class=3D"MsoNormal">Since HAINAN is very different, need some further co=
nfirmation.<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Evans Jahja<br>
<b>Sent:</b> Monday, August 23, 2021 6:40 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> RE: Voltage control on Southern Island GPU using radeon<o:p=
></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[CAUTION: External Email] <o:p></o:p></p>
<div>
<div>
<div>
<p class=3D"MsoNormal">Hi Kenneth,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">I understand that changing voltage 'standalone' is n=
ot a good idea. In that case, would it be possible to change the voltage ta=
ble so that it would give a lower clock on certain voltage?<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">For example, I would like to change<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">sclk 900, vddc: 1050<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">to<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">sclk 800, vddc: 1050<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">On Mon, Aug 23, 2021, 14:59 &lt;<a href=3D"mailto:am=
d-gfx-request@lists.freedesktop.org">amd-gfx-request@lists.freedesktop.org<=
/a>&gt; wrote:<o:p></o:p></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal">Send amd-gfx mailing list submissions to<br>
&nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"mailto:amd-gfx@lists.freedesktop.org=
" target=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"https://nam11.safelinks.protection.o=
utlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%=
2Famd-gfx&amp;data=3D04%7C01%7CKenneth.Feng%40amd.com%7C0b14ab3222974cad7fc=
208d966225a2d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6376531204410412=
94%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DMqu4fj33aPkAwLKNNALu8ZNnj%2Ffn4zGn1F3=
qzi5SYbA%3D&amp;reserved=3D0" target=3D"_blank">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"mailto:amd-gfx-request@lists.freedes=
ktop.org" target=3D"_blank">amd-gfx-request@lists.freedesktop.org</a><br>
<br>
You can reach the person managing the list at<br>
&nbsp; &nbsp; &nbsp; &nbsp; <a href=3D"mailto:amd-gfx-owner@lists.freedeskt=
op.org" target=3D"_blank">amd-gfx-owner@lists.freedesktop.org</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp; &nbsp;1. RE: Voltage control on Southern Island GPU using radeon<br>
&nbsp; &nbsp; &nbsp; driver (Feng, Kenneth)<br>
&nbsp; &nbsp;2. RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12<=
br>
&nbsp; &nbsp; &nbsp; UVD/VCE on suspend (Quan, Evan)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Mon, 23 Aug 2021 07:11:10 +0000<br>
From: &quot;Feng, Kenneth&quot; &lt;<a href=3D"mailto:Kenneth.Feng@amd.com"=
 target=3D"_blank">Kenneth.Feng@amd.com</a>&gt;<br>
To: &quot;Koenig, Christian&quot; &lt;<a href=3D"mailto:Christian.Koenig@am=
d.com" target=3D"_blank">Christian.Koenig@amd.com</a>&gt;, Evans Jahja<br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:evansjahja13@gmail.com" t=
arget=3D"_blank">evansjahja13@gmail.com</a>&gt;, &quot;<a href=3D"mailto:am=
d-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.or=
g</a>&quot;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop=
.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;<br>
Subject: RE: Voltage control on Southern Island GPU using radeon<br>
&nbsp; &nbsp; &nbsp; &nbsp; driver<br>
Message-ID:<br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:BY5PR12MB55607F9193F1A315=
210D1B838EC49@BY5PR12MB5560.namprd12.prod.outlook.com" target=3D"_blank">BY=
5PR12MB55607F9193F1A315210D1B838EC49@BY5PR12MB5560.namprd12.prod.outlook.co=
m</a>&gt;<br>
<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
[AMD Official Use Only]<br>
<br>
Hi Evans<br>
I'm sorry but I don't suggest you manually control the standalone voltage b=
ecause it's predefined with the clock value.<br>
A decrease of voltage could hit the hardware critical path. You may need to=
 change the clock and voltage together, we call it dpm level change.<br>
Thanks.<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org" =
target=3D"_blank">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf O=
f Christian K?nig<br>
Sent: Monday, August 23, 2021 2:26 PM<br>
To: Evans Jahja &lt;<a href=3D"mailto:evansjahja13@gmail.com" target=3D"_bl=
ank">evansjahja13@gmail.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
Subject: Re: Voltage control on Southern Island GPU using radeon driver<br>
<br>
[CAUTION: External Email]<br>
<br>
Hi Evans,<br>
<br>
in general the voltage tables are stored in the atombios and the best advic=
e I can give you is to first double check if there isn't an updated BIOS fo=
r your hardware.<br>
<br>
But Alex is the expert on power management, especially for those older hard=
ware generations. Maybe he has another idea what to try.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 23.08.21 um 03:56 schrieb Evans Jahja:<br>
&gt; Hi, I have a HAINAN GPU below:<br>
&gt;<br>
&gt; lspci -nn<br>
&gt; 0a:00.0 Display controller [0380]: Advanced Micro Devices, Inc.<br>
&gt; [AMD/ATI] Sun LE [Radeon HD 8550M / R5 M230] [1002:666f]<br>
&gt;<br>
&gt; I run linux 5.13.12 on Arch on a Lenovo B40-70 laptop.<br>
&gt;<br>
&gt; I'm trying to understand more on how voltage control works and how I <=
br>
&gt; can modify the voltage for doing overvoltage / undervoltage on my GPU.=
<br>
&gt; The reason is I am observing how running programs under high GPU load<=
br>
&gt; (glmark2) would lead to crashes when I use dpm=3D1 in either radeon or=
 <br>
&gt; amdgpu driver, which seems to happen when I am reaching power level 4 =
<br>
&gt; (sclk 900MHz), while a lighter program like glxgears could run and <br=
>
&gt; switch power levels&nbsp; between 0,1,2 without issue under both drive=
rs. I <br>
&gt; believe my laptop might be faulty, but I would like to take this <br>
&gt; opportunity to try fixing it from the driver's side so that it can run=
 <br>
&gt; anyway, however limited.<br>
&gt;<br>
&gt; Right now, I have managed to increase the performance of my GPU by <br=
>
&gt; manually overwriting the sclk to 630MHz in all performance_levels in <=
br>
&gt; radeon_pm.c, which surprises me as overriding the clock was not <br>
&gt; possible for me to do previously via sysfs.<br>
&gt;<br>
&gt; I've managed to tweak both sclk and mclk (or so I believe), but I <br>
&gt; still cannot tweak the voltage (vddc). The reason is, if I increase <b=
r>
&gt; the sclk to 650MHz, the lockup will happen again. Changing the<br>
&gt; pl-&gt;vddc&nbsp; variable does not seem to do anything. After various=
 tracing<br>
&gt; with printk, I understand that on my system:<br>
&gt;<br>
&gt; pi-&gt;voltage_control =3D radeon_atom_is_voltage_gpio(rdev,<br>
&gt; SET_VOLTAGE_TYPE_ASIC_VDDC,<br>
&gt;&nbsp; &nbsp; VOLTAGE_OBJ_GPIO_LUT)<br>
&gt;<br>
&gt; this returns false, while:<br>
&gt;<br>
&gt; si_pi-&gt;voltage_control_svi2 =3D<br>
&gt; radeon_atom_is_voltage_gpio(rdev, SET_VOLTAGE_TYPE_ASIC_VDDC,<br>
&gt;&nbsp; &nbsp; VOLTAGE_OBJ_SVID2);<br>
&gt;<br>
&gt; This returns true, so I believe my system is using SVI2 somehow to set=
 <br>
&gt; the voltage. Having no experience with SVI2, I read online and found <=
br>
&gt; out that SVI2 is a voltage regulator that uses Data / Clock pins to <b=
r>
&gt; clock-in 8 bits of information and convert it to some voltage value <b=
r>
&gt; between OFF, 0.5V -&gt; 1.5V, offering fine control based on some look=
 up <br>
&gt; table.<br>
&gt;<br>
&gt; My questions are as follows:<br>
&gt; Is it possible for me to modify my system so that I can manually <br>
&gt; adjust the voltage to my GPU?<br>
&gt;<br>
&gt; Thank you very much in advance. This is the first time I deal with <br=
>
&gt; kernel drivers, so any guidance on the matter helps a lot.<br>
&gt;<br>
&gt; - Evans<br>
&gt;<br>
&gt;<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Mon, 23 Aug 2021 07:59:36 +0000<br>
From: &quot;Quan, Evan&quot; &lt;<a href=3D"mailto:Evan.Quan@amd.com" targe=
t=3D"_blank">Evan.Quan@amd.com</a>&gt;<br>
To: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_bl=
ank">alexdeucher@gmail.com</a>&gt;<br>
Cc: &quot;Lazar, Lijo&quot; &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" targe=
t=3D"_blank">Lijo.Lazar@amd.com</a>&gt;, &quot;Zhu, James&quot;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:James.Zhu@amd.com" target=
=3D"_blank">James.Zhu@amd.com</a>&gt;, &quot;<a href=3D"mailto:amd-gfx@list=
s.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&quot=
;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop=
.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;, &quot;Liu, L=
eo&quot; &lt;<a href=3D"mailto:Leo.Liu@amd.com" target=3D"_blank">Leo.Liu@a=
md.com</a>&gt;,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &quot;Deucher, Alexander&quot; &lt;<a href=3D"m=
ailto:Alexander.Deucher@amd.com" target=3D"_blank">Alexander.Deucher@amd.co=
m</a>&gt;, &quot;Chen, Guchun&quot;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:Guchun.Chen@amd.com" targ=
et=3D"_blank">Guchun.Chen@amd.com</a>&gt;, &quot;Pan, Xinhui&quot; &lt;<a h=
ref=3D"mailto:Xinhui.Pan@amd.com" target=3D"_blank">Xinhui.Pan@amd.com</a>&=
gt;<br>
Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris12<br>
&nbsp; &nbsp; &nbsp; &nbsp; UVD/VCE on suspend<br>
Message-ID:<br>
&nbsp; &nbsp; &nbsp; &nbsp; &lt;<a href=3D"mailto:DM6PR12MB261946019274A3F1=
B5C09995E4C49@DM6PR12MB2619.namprd12.prod.outlook.com" target=3D"_blank">DM=
6PR12MB261946019274A3F1B5C09995E4C49@DM6PR12MB2619.namprd12.prod.outlook.co=
m</a>&gt;<br>
<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
[AMD Official Use Only]<br>
<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com" target=
=3D"_blank">alexdeucher@gmail.com</a>&gt;<br>
&gt; Sent: Friday, August 20, 2021 10:23 PM<br>
&gt; To: Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D"_bla=
nk">Evan.Quan@amd.com</a>&gt;<br>
&gt; Cc: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" target=3D"_b=
lank">Lijo.Lazar@amd.com</a>&gt;; Zhu, James &lt;<a href=3D"mailto:James.Zh=
u@amd.com" target=3D"_blank">James.Zhu@amd.com</a>&gt;;<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a>; Liu, Leo &lt;<a href=3D"mailto:Leo.Liu@amd.=
com" target=3D"_blank">Leo.Liu@amd.com</a>&gt;; Deucher,<br>
&gt; Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" target=3D"_=
blank">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun<br>
&gt; &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_blank">Guchun.Ch=
en@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.com" t=
arget=3D"_blank">Xinhui.Pan@amd.com</a>&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris12<br=
>
&gt; UVD/VCE on suspend<br>
&gt; <br>
&gt; On Thu, Aug 19, 2021 at 10:15 PM Quan, Evan &lt;<a href=3D"mailto:Evan=
.Quan@amd.com" target=3D"_blank">Evan.Quan@amd.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com" targe=
t=3D"_blank">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt; Sent: Thursday, August 19, 2021 10:36 PM<br>
&gt; &gt; To: Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.com" target=3D=
"_blank">James.Zhu@amd.com</a>&gt;; Quan, Evan<br>
&gt; &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D"_blank">Evan.Quan@a=
md.com</a>&gt;;<br>
&gt; &gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank=
">amd-gfx@lists.freedesktop.org</a><br>
&gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@am=
d.com" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun<br=
>
&gt; &gt; &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_blank">Guch=
un.Chen@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.c=
om" target=3D"_blank">Xinhui.Pan@amd.com</a>&gt;<br>
&gt; &gt; Subject: RE: [PATCH] drm/amdgpu: add missing cleanups for Polaris=
12<br>
&gt; &gt; UVD/VCE on suspend<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; If that is done&nbsp; ?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_de=
vice_ip_set_powergating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_UVD,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_PG_STATE_GATE);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_de=
vice_ip_set_clockgating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_UVD,<br>
&gt; &gt; +<br>
&gt; &gt; + AMD_CG_STATE_GATE);<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Usual order is CG followed by PG. It comes in the else part, so l=
ess likely to<br>
&gt; happen. Nice to fix for code correctness purpose.<br>
&gt; &gt;<br>
&gt; &gt; [Quan, Evan] Thanks Lijo. Make sense to me. However, actually the=
se code<br>
&gt; were copied from amdgpu_uvd_idle_work_handler() of amdgpu_uvd.c.<br>
&gt; Same logic was used there. So, maybe @Zhu, James or @Liu, Leo can shar=
e<br>
&gt; some insights about this.<br>
&gt; &gt;<br>
&gt; <br>
&gt; It looks like it is wrong there as well.&nbsp; We should be gating the=
 clocks before<br>
&gt; the power.&nbsp; The order is also wrong in amdgpu_uvd_ring_begin_use(=
).&nbsp; We<br>
&gt; need to ungate the power before the clocks<br>
[Quan, Evan] I created a patch for this. But during the verification, I got=
 the errors below<br>
[&nbsp; &nbsp;87.420822] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;88.443029] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;89.465386] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;90.487629] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;91.510380] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;92.533782] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;93.557400] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;94.580708] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;95.603832] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;96.627727] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, trying to reset the VCPU!!!<br>
[&nbsp; &nbsp;96.657453] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not resp=
onding, giving up!!!<br>
[&nbsp; &nbsp;96.665892] [drm:amdgpu_device_ip_set_powergating_state [amdgp=
u]] *ERROR* set_powergating_state of IP block &lt;uvd_v6_0&gt; failed -1<br=
>
[&nbsp; &nbsp;97.697422] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [am=
dgpu]] *ERROR* IB test failed on uvd (-110).<br>
[&nbsp; &nbsp;98.721432] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [am=
dgpu]] *ERROR* IB test failed on uvd_enc0 (-110).<br>
[&nbsp; &nbsp;99.745407] amdgpu 0000:02:00.0: [drm:amdgpu_ib_ring_tests [am=
dgpu]] *ERROR* IB test failed on uvd_enc1 (-110).<br>
[&nbsp; &nbsp;99.857784] [drm:amdgpu_device_delayed_init_work_handler [amdg=
pu]] *ERROR* ib ring test failed (-110).<br>
<br>
After checking the related source code roughly. It seems the underlaying im=
plementation of -&gt; set_powergating_state(e.g.&nbsp; uvd_v6_0_set_powerga=
ting_state ) performs more jobs than just power gating. And I guess maybe s=
ome of those jobs needs to be performed
 after -&gt; set_clockgating_state. James and Leo may comment more.<br>
<br>
BR<br>
Evan<br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; BR<br>
&gt; &gt;<br>
&gt; &gt; Evan<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Lijo<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; From: Zhu, James &lt;<a href=3D"mailto:James.Zhu@amd.com" target=
=3D"_blank">James.Zhu@amd.com</a>&gt;<br>
&gt; &gt; Sent: Thursday, August 19, 2021 7:49 PM<br>
&gt; &gt; To: Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D=
"_blank">Evan.Quan@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
&gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@am=
d.com" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun<br=
>
&gt; &gt; &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_blank">Guch=
un.Chen@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.c=
om" target=3D"_blank">Lijo.Lazar@amd.com</a>&gt;; Pan, Xinhui<br>
&gt; &gt; &lt;<a href=3D"mailto:Xinhui.Pan@amd.com" target=3D"_blank">Xinhu=
i.Pan@amd.com</a>&gt;<br>
&gt; &gt; Subject: Re: [PATCH] drm/amdgpu: add missing cleanups for Polaris=
12<br>
&gt; &gt; UVD/VCE on suspend<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Why not move changes into hw_fini?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Best Regards!<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; James Zhu<br>
&gt; &gt;<br>
&gt; &gt; ________________________________<br>
&gt; &gt;<br>
&gt; &gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedes=
ktop.org" target=3D"_blank">amd-gfx-bounces@lists.freedesktop.org</a>&gt; o=
n behalf of<br>
&gt; &gt; Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com" target=3D"_bla=
nk">evan.quan@amd.com</a>&gt;<br>
&gt; &gt; Sent: Wednesday, August 18, 2021 11:08 PM<br>
&gt; &gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_b=
lank">amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists=
.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;<b=
r>
&gt; &gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@am=
d.com" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun<br=
>
&gt; &gt; &lt;<a href=3D"mailto:Guchun.Chen@amd.com" target=3D"_blank">Guch=
un.Chen@amd.com</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.c=
om" target=3D"_blank">Lijo.Lazar@amd.com</a>&gt;; Quan, Evan<br>
&gt; &gt; &lt;<a href=3D"mailto:Evan.Quan@amd.com" target=3D"_blank">Evan.Q=
uan@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=3D"mailto:Xinhui.Pan@amd.com" =
target=3D"_blank">Xinhui.Pan@amd.com</a>&gt;<br>
&gt; &gt; Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12<b=
r>
&gt; &gt; UVD/VCE on suspend<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Perform proper cleanups on UVD/VCE suspend: powergate enablement,=
<br>
&gt; &gt; clockgating enablement and dpm disablement. This can fix some han=
gs<br>
&gt; &gt; observed on suspending when UVD/VCE still using(e.g. issue<br>
&gt; &gt; &quot;pm-suspend&quot; when video is still playing).<br>
&gt; &gt;<br>
&gt; &gt; Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed<br>
&gt; &gt; Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan@amd.com"=
 target=3D"_blank">evan.quan@amd.com</a>&gt;<br>
&gt; &gt; Signed-off-by: xinhui pan &lt;<a href=3D"mailto:xinhui.pan@amd.co=
m" target=3D"_blank">xinhui.pan@amd.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24<br>
&gt; ++++++++++++++++++++++++<br>
&gt; &gt; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23<br>
&gt; +++++++++++++++++++++++<br>
&gt; &gt;&nbsp; 2 files changed, 47 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &gt; index 4eebf973a065..d0fc6ec18c29 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &gt; @@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)<br=
>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int r;<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_device *adev =3D =
(struct amdgpu_device *)handle;<br>
&gt; &gt;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;/*<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; * Proper cleanups before halting the=
 HW engine:<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *&nbsp; &nbsp;- cancel the delayed i=
dle work<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *&nbsp; &nbsp;- enable powergating<b=
r>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *&nbsp; &nbsp;- enable clockgating<b=
r>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *&nbsp; &nbsp;- disable dpm<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; * TODO: to align with the VCN implem=
entation, move the<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; * jobs for clockgating/powergating/d=
pm setting to<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; * -&gt;set_powergating_state().<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; */<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;cancel_delayed_work_sync(&amp;adev-&g=
t;uvd.idle_work);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;if (adev-&gt;pm.dpm_enabled) {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_dp=
m_enable_uvd(adev, false);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_as=
ic_set_uvd_clocks(adev, 0, 0);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* shutdo=
wn the UVD block */<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_de=
vice_ip_set_powergating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_UVD,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_PG_STATE_GATE);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_de=
vice_ip_set_clockgating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_UVD,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_CG_STATE_GATE);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r =3D uvd_v6_0_hw_fini(adev);<b=
r>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (r)<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret=
urn r;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &gt; index 6d9108fa22e0..a594ade5d30a 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&gt; &gt; @@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)<br=
>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int r;<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_device *adev =3D =
(struct amdgpu_device *)handle;<br>
&gt; &gt;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;/*<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; * Proper cleanups before halting the=
 HW engine:<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *&nbsp; &nbsp;- cancel the delayed i=
dle work<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *&nbsp; &nbsp;- enable powergating<b=
r>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *&nbsp; &nbsp;- enable clockgating<b=
r>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *&nbsp; &nbsp;- disable dpm<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; *<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; * TODO: to align with the VCN implem=
entation, move the<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; * jobs for clockgating/powergating/d=
pm setting to<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; * -&gt;set_powergating_state().<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; */<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;cancel_delayed_work_sync(&amp;adev-&g=
t;vce.idle_work);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;if (adev-&gt;pm.dpm_enabled) {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_dp=
m_enable_vce(adev, false);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_as=
ic_set_vce_clocks(adev, 0, 0);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_de=
vice_ip_set_powergating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_VCE,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_PG_STATE_GATE);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_de=
vice_ip_set_clockgating_state(adev,<br>
&gt; AMD_IP_BLOCK_TYPE_VCE,<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; AMD_CG_STATE_GATE);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r =3D vce_v3_0_hw_fini(adev);<b=
r>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (r)<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret=
urn r;<br>
&gt; &gt; --<br>
&gt; &gt; 2.29.0<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7CKenneth.Feng%40amd.com%7C0b14ab3222974cad7fc208d966225a2d%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637653120441051245%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am=
p;sdata=3Duuc1RkDLEtK1Afn%2BzWXvVALBRAQQDmp3BTAeLr0p%2BK4%3D&amp;reserved=
=3D0" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a><br>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 63, Issue 280<br>
****************************************<o:p></o:p></p>
</blockquote>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB5560A37C4992C7858134940F8EC59BY5PR12MB5560namp_--
