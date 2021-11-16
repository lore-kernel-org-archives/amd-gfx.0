Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770D1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA1C61B96
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EA1C61B96
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC086EE90;
	Tue, 16 Nov 2021 08:27:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E206EE93
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 08:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gearhTjofWb5Nv1dTuu6xuOx9ALT6HAeHAi2qRVs96cSjFW/z+3E1NmlXKXvO6iHnLXn2TpSAjjOscZmUBpyQN9T608Jb0B2Py7BlHPYnHEBEqJNWVUUeXMr+tACcTHyTzSUgxx8pFe2ZPcL7sPa8OWKh72G0ZmtjTWuCtuAKfiDhRYxnr1YKKvGacBcFJdDtJqYQPtP6IdTXGULocDD3cmxLLEWnjoxBm5gdqo2vxsfiQfGNCxiXuHgVpm6gJbJ73vThFhNG+JNld5ccB/YBNRx7wRdT2UNSBqoO3ObGH+fzZi3jClfVjhq1XOhQiJxMW6Ndw1A0BTNjdwTjkLAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgBlwbdr7ZNncy5du9XZOsqtNHHo+OLISivzaQ2tnSc=;
 b=C+l93t2xuYY/1nwR5Oz9TYV0rNjxjOyH3qHDm6BlbwoA1HMV+6p/c5rxgUEGpXHeaBCLa/wMlgWany1sLFwABI49hzRMkhz34qHX3l/t0Mvuc+i0y1d608CGhiQDM3o+YPN5kl9WK5zTVYMqvCQ1ZWXda4tNXBOx4Bgxo3E+kq2fxB1g/Nj0b56cUWr6K0+s+wTDbc0unHI0xapbbhwtHpjUGyVFKfyrEmClVuDJql6vOQ3wYXeobN8L93JwltGW6GaYn2b7Zi/oLex+MS/n4vl2IZvvL0FP21qzYtqKDBM1hoNEWFEJeHnXwtWOsYke50gBOISMHSBsQrQatEVBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgBlwbdr7ZNncy5du9XZOsqtNHHo+OLISivzaQ2tnSc=;
 b=sZWxOQ0/ktwxo9rwI/YJwiTiMpkY9qM+oFS5I7NtE9SH4uE2luRhvpnbNpMPE/oMUvp2aef4fggQ9YrwZdH0c62aQ6QWIMSzNR6Ri8tBs4z2L1MAW8UnSh/tK+8AafufBfXedG9tDttWu1zKUZu0HDDUNjznn6SrWWZY2WqF6F0=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB4652.namprd12.prod.outlook.com (2603:10b6:5:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 08:26:57 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 08:26:57 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages function
Thread-Topic: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages function
Thread-Index: AQHX2sBFoxDcc7xd5kSOptJMhBOdvKwF0Iyg
Date: Tue, 16 Nov 2021 08:26:57 +0000
Message-ID: <DM6PR12MB4650F622273174D5E09B0A9EB0999@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211116080146.3183-1-candice.li@amd.com>
In-Reply-To: <20211116080146.3183-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f07cea61-a76c-44a7-a7a8-e09c5b58fcf9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-16T08:21:59Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89f2be37-965e-4cc8-664f-08d9a8dada74
x-ms-traffictypediagnostic: DM6PR12MB4652:
x-microsoft-antispam-prvs: <DM6PR12MB465273F1C1B34C06DA1EFC72B0999@DM6PR12MB4652.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: olLIdrcXjlr3qH0mVnjz3+PDiefIpi8BN17hfNfCGsD5ouIPpHTMPxRoDG3ytGhNxiahvM1ljBcNVnXmzeiok/59dkrNSg8v+VFfkY97Opn2WxeMCk8FQaUeMKOfVBO3mZUdnUp3/YEBSwd+77M1KIcMNrbRe/P69L8tnH2U1qGOPGCjof+pnTpRd1rYTd3JudwAsP9btPyeWW05sWIJV6BdG0J+4YCnt4uc6NiuY122ybfdSmZm3IkOHWEEgj6gPkabLCupcoov6stmHRw6GLdnr5Fc3YU3RFs8Va6JergYyJk7xUdGJzAJievSzL09F7ACSJlAouSaWCznqtC6Fe4LXeOEmdPOGYCWPhuX+T6Fysc4WIDydzxxlFiFLFCN4TMrERyNby1nvIRg3/ZJksechd81b/FoInf9SPsmscoMa8wyQVIGWr3rTu9otpovsm0ObsUJECHD8FyNXIbklq9UKcRthoOuNaiUwydA1Goex7Z0tNRL+DO/PRnu5XSg1JbnIisf8yxxDMdp9VrYslwepnwRPAIDZBrxQYYDUwsAnfhvxZ+b4HsnHlKDSIPLag6/CyKDqUCLh1rE3DkApaYCGu2oJH8ghm2lgw9Izkne1HKtaFX/HK+KvYhsDEwV7z29O01OuZzyDShcQvA57Sju5Cx5vTk0fXogCe6F00UHLRzbt/Te/30faLJOb2llnVZBMuDo5RnAqjbgWM1DNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(2906002)(8676002)(64756008)(5660300002)(508600001)(8936002)(7696005)(71200400001)(66556008)(52536014)(4326008)(9686003)(38100700002)(38070700005)(76116006)(86362001)(122000001)(55016002)(110136005)(6506007)(66946007)(33656002)(316002)(186003)(53546011)(66476007)(66446008)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JcVYcl8PxD9HExxfxzvtG4LcKjXjrcqRbefeMjqEckR7ClTH09Keg4FA0hpO?=
 =?us-ascii?Q?tNyw3aWS54GVII145oushwy7yoNpwwtDbeh7LnQZmffG8KoHwWMwNKXQnF3K?=
 =?us-ascii?Q?bPWl0/lQhApIeegO0iCZ1Rzg51SSWedWS6WDSN3Yw4BP5DZUB91/SkZ9q2Sr?=
 =?us-ascii?Q?dT+kvWhKSszPeS9JAGaPb4BPnL4pwfCDPYO3A3q9PG8Ju5rp/KqhmkFqlJ+i?=
 =?us-ascii?Q?sJuJ7BJKZbK9tQf8diBPDTaHd46UqFsQFEq5kAsQ6/qD8+kcA1ZIWhue0/nY?=
 =?us-ascii?Q?/2Aw1ojLYMkcJfQB415A0kF2JRe9HWcNHiwKggh79lmuI03XxcSV9fpve6zH?=
 =?us-ascii?Q?Tmo6pR41EBLeuEUZqomfvucE5/9vr4MTDpFFUSWjKC/5h85bXbwcmoUBlu+E?=
 =?us-ascii?Q?bL0HalAKjfgMJHU3I0qU4VOQscpaleFvrpRaoTTdJAQ7NKwsFqQlrnxATwT9?=
 =?us-ascii?Q?PwHuasBsqBwOHoo3BusgD//USRMeRQw7dKhXnu1LAoFRfji3UMRXiBZE7Zkr?=
 =?us-ascii?Q?d2t+hNZ28vZtrKfGyNt6J8E5oDh/m2UaQIPJWHQ09sM1H8nVc7E7qlqq4vpz?=
 =?us-ascii?Q?s3JeYVCjc6pnFXXOFzgQfErRan305b3rqc0Zr0Jqv0E6wv5O11fJjlMdvxmP?=
 =?us-ascii?Q?BgzaerFwYAVKp/YMkEsj3ZfeozleUF57gFKcX/C0CwwGVhRmDwOHhbCQHGAq?=
 =?us-ascii?Q?RnRDLVqJwErFJKi21CjAi/2+hb7DC9cl552b7IBAYRo/qpXyjvozhhcxqMk3?=
 =?us-ascii?Q?1Mb49vun/bjlCzzg0dJkjMXbsbBCFTFd5QkfRGx6mna7QbF4TeKxHaxvMvMt?=
 =?us-ascii?Q?xZDs3h27eWXnv/s6mRcccvUE12uJBuGFjA72V4fECP0M3cj1ZCX1m7xhovm+?=
 =?us-ascii?Q?vSt2HV5BF2afoFI/GD4YAu0peZdKDKx3UGsUnmty5tCm0vs4Dl3IZvqWc5kI?=
 =?us-ascii?Q?MxHZ5WuQpgpPJ3HnBKufoI2QXbqSvMqEg3rZA599LzXpeP8tLLdrQvsBsgx9?=
 =?us-ascii?Q?LgjtJycm4V6F4g1Nz4yt6DGiCbLNxTUN0zBjrGSeCjBRxBa9NhbFGFgmrOXF?=
 =?us-ascii?Q?61HE5DLUmqHkKkPqt9nkWcr81rRGxzT4635ISRqAoH0QXM0Y3d2PRGQ5l37z?=
 =?us-ascii?Q?AmL9Hn1TNukVab2p6rcFn3ioGdkv11/0TIZv4/9s2kRi78R2JWiKh2xUPB2X?=
 =?us-ascii?Q?8vaA7PuYQzdDwmuUmqDGD0896yJsZGB9opoTEIZ5DDIGr6kmBTusEvnYry0R?=
 =?us-ascii?Q?EK9S3M2qCAa55QcWMcakoKxXTR3cN52g0EKSZ1IMGk1nZEIgHqhb+Xi/WWRF?=
 =?us-ascii?Q?FGjZn6nAJhP9b/538HRi79YL1COPX8/MjzE+ulMPqlGS2yXJRuTZ/uqrrwdu?=
 =?us-ascii?Q?num6DkYjsdp4iG0Z9DL6dlRGtGd6Omg2oxJ1YtUGv7nhIcZM8Vn2WQKfyKc7?=
 =?us-ascii?Q?uurHk/JrozErarZwyW3ORVIZaV59zGqwTKJw2qq5fCXAuOk/FFWRMU+c9Thq?=
 =?us-ascii?Q?HZaWbn4QMLAAW/jX1hcxXFyvc55NYWgT/4uJhNBuUEgbXabeU3pZ7/3BIm5o?=
 =?us-ascii?Q?IYFhHTVB5Ks7dDdxKRc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f2be37-965e-4cc8-664f-08d9a8dada74
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 08:26:57.0314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9dF0Ni03FqGt0A+t6TAIBqdyhyu8y2AftDMLRSkCdAs3zCsbMJmBvvfMB0kKtrK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4652
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
Cc: "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

> -----Original Message-----
> From: Li, Candice <Candice.Li@amd.com>
> Sent: Tuesday, November 16, 2021 4:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Clements, John <John.Clements@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Add recovery_lock to save bad pages function
>
> Fix race condition failure during UMC UE injection.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 08133de21fdd63..711b5fb26d47d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1931,10 +1931,12 @@ int amdgpu_ras_save_bad_pages(struct
> amdgpu_device *adev)
>       struct ras_err_handler_data *data;
>       struct amdgpu_ras_eeprom_control *control;
>       int save_count;
> +     int ret =3D 0;
>
>       if (!con || !con->eh_data)
>               return 0;
>
> +     mutex_lock(&con->recovery_lock);
>       control =3D &con->eeprom_control;
>       data =3D con->eh_data;
>       save_count =3D data->count - control->ras_num_recs; @@ -1944,13

[Tao] Since recovery_lock is dedicated to protecting eh_data, can we unlock=
 it here?

> +1946,16 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
>                                            &data->bps[control->ras_num_re=
cs],
>                                            save_count)) {
>                       dev_err(adev->dev, "Failed to save EEPROM table
> data!");
> -                     return -EIO;
> +                     ret =3D -EIO;
> +                     goto out;
>               }
>
>               dev_info(adev->dev, "Saved %d pages to EEPROM table.\n",
> save_count);
>       }
>
> -     return 0;
> +out:
> +     mutex_unlock(&con->recovery_lock);
> +     return ret;
>  }
>
>  /*
> --
> 2.17.1

