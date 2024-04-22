Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AD3C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 09:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9407511291C;
	Mon, 22 Apr 2024 09:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kJj5NV+n";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E428A11291C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 09:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlsGBCW7PLcgC3qWmDZ3J9gf/PxQev1WEQ9BUXd0KvlPtwwLgy0ECSRwQ1bJS810dLfs7OPKICwERuEYoE3AZg88bxpYJuJvLuEPOzwnLZUGKySzO8n5Hq5rBxRCE3JeluPF+2hr3XASnlksN0XCQkL8LtAXekv8uDCfGc6AH3zFYwe1zeGL5ZiXMvGvrWV61ZSPIxoIc/XMx6vwSvBEKLcR7CbOOHkXccf+kidYe82ZwJg8EueQf++5L948JM19zQ+ay6QstHjCqAgt+3gV+xZqR0VQB3YSy62ZgHpXKUfBHhpNmWH0UBrvPJRL6PsV9kQ15+prVMUoaO8lBQWdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwPyzat6TglY9JlpEkhNzFZ4o6uVNGeOgat7O8JAlVk=;
 b=RGjdH+z7Z2KErEbiHr1/IuO6xA6+nAPpWk0RYCpiD7z/cfbMVm7UW4MquXodJuBxx9n+RC1E/lMo3RX4ry6ia3ZqVrCPHmuvUwyPfZ2AeTs+tgb5OBhJ0w/2TPh3Xsdszql2RHLgH1rMH+w3oU2zImgFF6YeUg/znX3dySOK9ohBx79Xa5MldVBM24mee7NM7ImFfFPM6FSHhA+egFExnKkENQEJkvyI+aHYIhlGmEjicoJoxwpt+Xt4OB/sLG4xMhe/MBUsWI3PQsND1dcjmznl/oKcDdPsTLLroBeaQPoHq/NTvjPvssbdswxvzOca6Pzi5PRPUJBlWaRt9FLWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwPyzat6TglY9JlpEkhNzFZ4o6uVNGeOgat7O8JAlVk=;
 b=kJj5NV+nEyKowcnBRNKePp27h6AmTR6QoZCT2VnJYBSOyx5wrH8G3/OXq7Nn5wvrc7+sIzkCvIjO1HlySVhRIKJ1lRUABfyzkYnMjSUSb1EwtTxuBM0QpNO13x9+5fzN/Y/krPcGW5X5oFcGp47Sqy1MZk17fRTJAYFyjYUgNLE=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:21:26 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:21:26 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
Thread-Topic: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
Thread-Index: AQHakTzIRliRX3pRekKB0Zi4/jMU4bFz95gAgAAG3SA=
Date: Mon, 22 Apr 2024 09:21:25 +0000
Message-ID: <CH2PR12MB421536E01B3D9A3440F23029FC122@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-10-YiPeng.Chai@amd.com>
 <PH7PR12MB8796BA85309CCBC954A8ACA8B0122@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796BA85309CCBC954A8ACA8B0122@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c585f23d-7ab8-43dd-82ea-5f594246e3c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-22T08:12:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|MN2PR12MB4173:EE_
x-ms-office365-filtering-correlation-id: 341cdcff-46ff-4245-c291-08dc62ad95b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?rM0Ux00rRIL7oSW0sR8u67db/tOMsISY56sl/JZGOT/wvCxr35efmTX1XpgI?=
 =?us-ascii?Q?FcDyUTg3Eb5gw0x8ePYkUcEhpLrThf6TM4Lv1kHzQMgAp0MwTDLWAuSv6mjp?=
 =?us-ascii?Q?X/gAatf+CE4fcGuIMqI0j02vjEBCOWBF0Eu/U4wEyPVfJf40z1eg3XvxVmzw?=
 =?us-ascii?Q?qSEvrYOrx2UgSGN9YawrOa6rVx6wEoczdHxinTebUR5toheqLwlPhCXcfKoM?=
 =?us-ascii?Q?hI1ofVKgK7LUzrDMjExzC9UNsPDoU1leaEnh7OGn7jOKywJ9PVD12AnjRnoa?=
 =?us-ascii?Q?5CdofkgULrr0vwHpHuDF1H6/lUlZMaS3a8qKKeN37UpiYd0mQYxTdT31jBp1?=
 =?us-ascii?Q?hXyBWy6GSxRbGUvFUGmG/1u0Yhoqu6u2IrCA3V3FMPcyH5eZt/HUqO9C65zu?=
 =?us-ascii?Q?t6Myz3aEhaMU/Veeg8sSLzKRjLsngiOx82TxKaiof63Mu4S2XsOdy9gOZP5a?=
 =?us-ascii?Q?Yztps1UiZyYQCl7blzHJ5OtYNbg8oo5FxrSwhsbi5OqylPKtD74SFdFebbrk?=
 =?us-ascii?Q?WHiOnqWkI2aJ95naJmywaUONuYHIMNFeDXwyXPi0bSVe3BOmb+DXbDKw5xSR?=
 =?us-ascii?Q?uWBw3krZf73duMlo0QSH+IztmWFOdz9M3JacTgj+Dvmfx1eTAlIOrUIHf4/e?=
 =?us-ascii?Q?/i2f4/s8OqPQQe1gtEe7DRoEDsVC5J1LUl91LpQ4WtfVwdw4Awfp3mU6Uro4?=
 =?us-ascii?Q?NRtXOzz0kK7y8eNjurTNCcCgFUyjD8y/c/5IW4bkMl9PgPrkRkiNBjBGDwpd?=
 =?us-ascii?Q?HNp49H2LyJ7MHzC16F0NrvimX4Wmd1ikvUbrHe7jdrFVX9GF65eot3xQwjrJ?=
 =?us-ascii?Q?Ad9TjZqHpjoKwnk9UK7/6wIO3XKqzfVpdBEzDnLkeOU19i6BeAags9bPXtH4?=
 =?us-ascii?Q?VYk5BEGTx9bYF0PRE7jo/q7WQc1kxwcqsO5XbVOAP9V/4zL8FnzxDsUfeuu5?=
 =?us-ascii?Q?dP7geHYxh6rwPDrUi0r8cV328XpjfnJAQ2i66MjbZUWFIzhTlVgdUrDn0rpz?=
 =?us-ascii?Q?PWe242vwxhD6j9+6Aw904wYGvj8Tdtq2ZlXOdlLuzWJtugke1PF3eQZN0FmV?=
 =?us-ascii?Q?5gH5svOCLIU1PzYXT0q7lQm5XzLcpgRqyIamngooqtKa5IDID2GPJUENhGWZ?=
 =?us-ascii?Q?a7RtTUr4QF3Ppz8bkPKq8qOsvk0tfFKYylrlj+xFKWKt6a14Q6RE5ykl7f9v?=
 =?us-ascii?Q?Ywjeddkx/jYBXBcdP/qDnnJqRRPOILc+LurfQ8bcLxfQcJmT13Bl3+5Ca9bS?=
 =?us-ascii?Q?ftYXkBD1esO1SMO+u8uvzWHf5SsPKSb1PrjUMaJsV9rW+Yu5VVxrSIoXuYGd?=
 =?us-ascii?Q?ePEnlSTyp8V0aN+JdyqcTcp8Dbs/ZlpOtwV2lfqk2gJoQg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OgU8cFqUa6CmNcKV2Ff+zE+PS6UiXqqerivRTVxSTXAMwoAcA+D/WMn3OqV5?=
 =?us-ascii?Q?Z8qm9lTQfquxgBnKkbzhU01MW4q6rHO4jKOzsnsMZZ/f3okilUzB6Nv3QH0+?=
 =?us-ascii?Q?p6xX+1hiViR4FfFpoAIzhzfs5tOVdCu126eK/ZAGKUm2OET5eKlEdpUYeJh1?=
 =?us-ascii?Q?q5olQpHpSWwgacMxwLST2J4bkKrT6aiOEjO501lPiAZXGf8pHE/h0kY0sGz/?=
 =?us-ascii?Q?a4Lf9oF8FM0/WSN691JCg3uqhiJsIWViXp/fpoXiQmftRg59UbzTAvW9MzSb?=
 =?us-ascii?Q?7o5+N7LtG0hWYl8rkS9IAPE8LkWAhRIist5gDw3pMJp6mmYxwdLWYfdasTje?=
 =?us-ascii?Q?TCvuDGNI3807HHVGti4Ysp+QDGOdD3bDZJLYrR4EPWAI8h7uWcnbaQdNwhru?=
 =?us-ascii?Q?zkoOwS7gXvFItKdOhsi643Oi+uaqNKKLN567/pnBr6bPHAmR2AbIro7dganM?=
 =?us-ascii?Q?ph56YWaImt4LqvRf8OfbiV16HKJZDoZnj1K7S6I5I29ijuxinmiLGJG54vTu?=
 =?us-ascii?Q?h6ZyP8+gAO2UrBvNdlkZWgEQOdIRYzF7yndVtiBLBAv3g9RnpiTZNQhWYBwM?=
 =?us-ascii?Q?bl8nguHtEIWtbdKyBDjTyHvh2CrWVZ3rHeeIU0D6zrQrEfHP8kPCGoK1NJDc?=
 =?us-ascii?Q?M6+L9OJAI4KU4k9ELG3Z7IiDoIWkzD9Orx1mIDgnm7kTqSUBODcZqLMOfOTR?=
 =?us-ascii?Q?e3V3dZCpbHwzV9Vf4c6uQSVdlsqDPJXO29XMAU+UKraBZwZ5uj6Ogjz1V/TC?=
 =?us-ascii?Q?3TK0cOa37A4JFK0MbipQxudyeCiuxhDAKv7e8Qef2ngmcQdr3uIpYjzs21pE?=
 =?us-ascii?Q?OFjLwYvehbbObSwqinHVD4aaUMwX9PtbT+atlqGnfsv4uhsxoApUHpVzFWME?=
 =?us-ascii?Q?2pF3hACaywao0q/tP0UqSNGvPW9EcAsnO1vBte+l+aIKA4npVjMfzRfwDPtM?=
 =?us-ascii?Q?a5g5jLC2C29rYaF9erNcxgwOwzx1re+SqLDSUSxnDDul69HPx1BwZbaHhY/9?=
 =?us-ascii?Q?7evX/n2vHVSjOA2lc+5b88tHiju87r/tGXJwwJ3Tib9dcnI0cxw93lRV/266?=
 =?us-ascii?Q?5cBiy+F9umFfjxHc7myZJcoTk+7f+7g3y4VLFnWG3/Nf1DmBz3LbhBUBclee?=
 =?us-ascii?Q?ROnNo0txU3PBhuTb5ngVKC5a1ZCd1uAQZi+OJ5HGFPBx0EU6INofj3T7g8TX?=
 =?us-ascii?Q?EUyaRFSuh5t8OFWd7N5fFUlek01e9Ywmm7y8fovqNWXOxhyNUCHSrpyq45I4?=
 =?us-ascii?Q?irwdqX3Nwv/7GnREa7oXYxBfBMZ+LSLAhVzjkAlGJGoQvF3dSB3u5uqix71Z?=
 =?us-ascii?Q?h0PlJ45dXSXBTHhfYATErmIuq9BxaqV6Znn9uCaTLPr/mLnr/EQqdVGFjbks?=
 =?us-ascii?Q?oWwxy0iaScUbyZPwktEDxZZvFGv1otFaPjyIttn/Wf103OrgYxwWVS4Qfx/6?=
 =?us-ascii?Q?Mo3CR23VyhdgjkKLgxJ3C6n6lFaJ6IA06tlrMGAn7VpEEyt3qfv0U7PfZYuT?=
 =?us-ascii?Q?OalVnST5KkfJ9ibqs+/34d9JOtytK7oTchQoCp8tF9WqgHXV16DWSh79i8rc?=
 =?us-ascii?Q?LcuN3FjJ02jo1rET9FQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341cdcff-46ff-4245-c291-08dc62ad95b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 09:21:26.0254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfFmkFFMQ1JZPLFb772AGxrkBVElp3kQRztsn9Er+osoAwLbDUEdpYUjs4qJ1juzphfZ3shY5+wSSzqog4wnbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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

[AMD Official Use Only - General]

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, April 22, 2024 4:14 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0

[AMD Official Use Only - General]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, April 18, 2024 10:59 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 10/15] drm/amdgpu: retire bad pages for umc v12_0
>
> Retire bad pages for umc v12_0.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 57
> +++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 6c2b61ef5b57..bd917eb6ea24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -28,6 +28,8 @@
>  #include "umc/umc_12_0_0_sh_mask.h"
>  #include "mp/mp_13_0_6_sh_mask.h"
>
> +#define MAX_ECC_NUM_PER_RETIREMENT  16

> [Tao] we already have UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL for the purposes

[Thomas]  This is from eeprom view to define the maximum number of eeprom t=
able entries written each time.
The actual data items that need to be written to eeprom may be less than th=
is value, or may be more than this value(e.g.  later, write the data items =
before address conversion).
If the value is less than this value, it will be written according to the a=
ctual value, and if it is more than this value, it will be written in multi=
ple times.


> +
>  static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *ad=
ev,
>                                           uint32_t node_inst,
>                                           uint32_t umc_inst, @@ -633,6
> +635,58 @@ static int umc_v12_0_update_ecc_status(struct
> amdgpu_device *adev,
>       return 0;
>  }
>
> +static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
> +                             struct ras_ecc_err *ecc_err, void
> *ras_error_status) {
> +     struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
> +     uint32_t i =3D 0;
> +     int ret =3D 0;
> +
> +     if (!err_data || !ecc_err)
> +             return -EINVAL;
> +
> +     for (i =3D 0; i < ecc_err->err_pages.count; i++) {
> +             ret =3D amdgpu_umc_fill_error_record(err_data,
> +                             ecc_err->addr,
> +                             ecc_err->err_pages.pfn[i] <<
> AMDGPU_GPU_PAGE_SHIFT,
> +                             MCA_IPID_2_UMC_CH(ecc_err->ipid),
> +                             MCA_IPID_2_UMC_INST(ecc_err->ipid));
> +             if (ret)
> +                     break;
> +     }
> +
> +     err_data->de_count++;
> +
> +     return ret;
> +}
> +
> +static void umc_v12_0_query_ras_ecc_err_addr(struct amdgpu_device *adev,
> +                                     void *ras_error_status) {
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +     struct ras_ecc_err *entries[MAX_ECC_NUM_PER_RETIREMENT];
> +     struct radix_tree_root *ecc_tree;
> +     int new_detected, ret, i;
> +
> +     ecc_tree =3D &con->umc_ecc_log.de_page_tree;
> +
> +     mutex_lock(&con->umc_ecc_log.lock);
> +     new_detected =3D radix_tree_gang_lookup_tag(ecc_tree, (void **)entr=
ies,
> +                     0, ARRAY_SIZE(entries),
> UMC_ECC_NEW_DETECTED_TAG);
> +     for (i =3D 0; i < new_detected; i++) {
> +             if (!entries[i])
> +                     continue;
> +
> +             ret =3D umc_v12_0_fill_error_record(adev, entries[i],
> ras_error_status);
> +             if (ret) {
> +                     dev_err(adev->dev, "Fail to fill umc error
> + record,
> ret:%d\n", ret);
> +                     break;
> +             }
> +             radix_tree_tag_clear(ecc_tree, entries[i]->hash_index,
> UMC_ECC_NEW_DETECTED_TAG);
> +     }
> +     mutex_unlock(&con->umc_ecc_log.lock);
> +}
> +
>  struct amdgpu_umc_ras umc_v12_0_ras =3D {
>       .ras_block =3D {
>               .hw_ops =3D &umc_v12_0_ras_hw_ops, @@ -640,8 +694,7 @@
> struct amdgpu_umc_ras umc_v12_0_ras =3D {
>       },
>       .err_cnt_init =3D umc_v12_0_err_cnt_init,
>       .query_ras_poison_mode =3D umc_v12_0_query_ras_poison_mode,
> -     .ecc_info_query_ras_error_count =3D
> umc_v12_0_ecc_info_query_ras_error_count,
> -     .ecc_info_query_ras_error_address =3D
> umc_v12_0_ecc_info_query_ras_error_address,
> +     .ecc_info_query_ras_error_address =3D
> umc_v12_0_query_ras_ecc_err_addr,
>       .check_ecc_err_status =3D umc_v12_0_check_ecc_err_status,
>       .update_ecc_status =3D umc_v12_0_update_ecc_status,  };
> --
> 2.34.1


