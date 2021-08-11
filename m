Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC829C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 14:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBFF60F55
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 14:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EBFF60F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42A26E14B;
	Wed, 11 Aug 2021 14:29:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F31E6E14B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 14:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGeeE7zZQjpdjoJURyN6Ae2EyYUreKBqoo9fNakh9PhggBc5+GKHzTGqc0lSulJFv1ZfNKPwGZ2kJ2vdg1yxe70aMIWQzYzl17F3OBFiasl07h5YR+c1p+1QCKG6OtxAwB047V7L1si6DkvcxvWzJLbjW4GeCXXfa34we0f4Z0xONobTPLbh1n/XMeHhIh+MzYabYKnLRNWZry4dkgc9sNJg0qAn79Cx/dmizwC/3e5ekjZscM3Xwr64PYWbMZDvAisaIXy/+/v1MsKct99eSF9ozslen5O5CSAbLe1bj9iAa4U6DdDV8LARxh7eug8tVYYGxu5Q9KfdJ05dyQL6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x94q1QjNtt6NVv0+veBmldAHtmcU8o2nLMb2CpVncLs=;
 b=b4gj8GPaGYxK4837EBiWKcuPGK0yRswwuLCM39TfIM8jXIoeD0l8F74mOwYCZB9+6lGA0wnL/YDqOVQnyiW+y9bf6z6IPUkQO0eFGMMPlf63BxShSmFJ5Q+sqJbCjmWauQ8Eid/xiwxQjOjvkxmZ1Q5cu0CWyQC83yW3If1a9vogKF4ocsMYq8ZAljVI8oyTt4GAMtUwzeuRaTL1PtVRwSgS2T8uBkxZFA7eIR31BI9WRFKzAusgowxefppY03yriK+ZEEb9Foef6U+7yFnBwWPZsmucEG5KZtOI2QXkeDRqLehFsO1vJuKWmy4l0Atf4cgTBABKJUXF6U/bgM2OpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x94q1QjNtt6NVv0+veBmldAHtmcU8o2nLMb2CpVncLs=;
 b=tuK0wf8Y7SpeOsIl9Ld0UPsJX3pfUvGDmhHPhjkoJ64xY5Ntvy6Kpt+3Du4Pufd62NCkDS7oGOWlsziHU316SQ0MW/t1TWGIJpanTXYWvozt5h3Rr2txkU2Oz+VoJOKQucEoBhyuwNCVgkuZ3di3rqtabqRTSYEMkIYdrPiPw+w=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Wed, 11 Aug
 2021 14:29:12 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::ac0d:a66f:c4e0:aabb]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::ac0d:a66f:c4e0:aabb%3]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 14:29:12 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Min, Frank" <Frank.Min@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 4/5] drm/amd/pm: change return value in
 aldebaran_get_power_limit()
Thread-Topic: [PATCH 4/5] drm/amd/pm: change return value in
 aldebaran_get_power_limit()
Thread-Index: AQHXjouWT0foYXs4QEW1BUb4ObWxmqtuDh0AgABPE04=
Date: Wed, 11 Aug 2021 14:29:12 +0000
Message-ID: <CO6PR12MB5473B8CA55219AC274EF9815A2F89@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
 <20210811083323.1084225-4-kevin1.wang@amd.com>
 <d854470c-65b5-3207-359d-405ccdb55ae0@amd.com>
In-Reply-To: <d854470c-65b5-3207-359d-405ccdb55ae0@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-11T14:29:14.131Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1206a345-a5d8-44f8-eba3-08d95cd463b2
x-ms-traffictypediagnostic: CO6PR12MB5396:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB53966D5F14C767F893EAE417A2F89@CO6PR12MB5396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOes/Lhb0JpyIwjgjFBPoywHybCIbFTjZOuccYinmFxermVzWT7bAmxKCCZ51K5IYTgPoOQNOnuc57R1KHTznCs3tBNf1wYDyajey8tF1UYJW7ZJV+SzZQCJM+ZsVJWeN5q87q8MbiqZR1bc0bA8mtF3I3Yw//HnCAfYehTWXlHkxAQZ7/JXfB+44GY+Pyo/ZKTfUIRxAR22XP1PqaoB2fajffhM9WVpU2ZcSpAehCqE8UbZ7ykgVjpeHa16B8pVmw4mkNolSHBH0U/oCfiHmy5wYLmjrKND5P27esaHYdiVNiYAQXXtf/Oy9IeZIA0kH3TqhmJ8rECVbczBIeuTOyNSpP4Ak8AoIOLQA2uM6itk7yPp4O38G7W7zP1XjzYq7hGuYwhREXTwpvHunAV8Cq0V+w6+r9yI0SID6GDGIbwmwy2OUydDKzFt5R3tGse1cDX4iKB2F+cDHBYhkyNBq4IkCPhG1FRJebME5eZTnGRNhaxP8PEHSiIVbzD0pYRI6nbetatqSZPNcAKLE5wHwC8qcCnSX4r+Hk1Tr1VZxdDKS8r9IPr8/EP98zXiouCXDJVCMoLKvMv/OCWiRSMtCmIgidibcdPW70nZWW599lxB+BHdJfsms5iETwGlKXfAxyNcrMzXnBJrppsJ09WBYRsmWtPXnQEjDYbO9UgA9Cr49n3EevCNLRkXfh17aLdewpkYDun9/MwLImr+y4cBjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(66556008)(66476007)(66946007)(83380400001)(66446008)(186003)(64756008)(76116006)(91956017)(2906002)(26005)(38070700005)(86362001)(19627405001)(38100700002)(122000001)(8936002)(6506007)(316002)(52536014)(478600001)(5660300002)(33656002)(71200400001)(7696005)(54906003)(110136005)(53546011)(55016002)(4326008)(9686003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lwtn5xXjjupinK+PQsDzaEhR9EEo2vfleOZoGdWufjahG7hnxXsSC9hBmh?=
 =?iso-8859-1?Q?jRwkfl7HjwbNp2IHg5y1c3L1ZvqmE5ehtHqKol0SFJmdez4lOSRwvwx3wA?=
 =?iso-8859-1?Q?+pcX7bONY5TjRaLdbVsmIgvMdl0UfdkVK08WVk7Pa5md83s403sGFCBX0t?=
 =?iso-8859-1?Q?REvBXFg+obtEJQZzgq7NVQhr+0mPh8aLj/Txu2zz4pgDA4BRS4eVgqFCdQ?=
 =?iso-8859-1?Q?i2u+jrxlwOvG5ansIGC+MDDSuIGED5WHW/BOJEpGmMqHnaCHk1rmyZQ9cU?=
 =?iso-8859-1?Q?yjXdvmFH+BT9G9CiAxBjslrOrZeOrhCw7nkQxPAothCqTWwpAf1OhXvZkD?=
 =?iso-8859-1?Q?WrqmrUx7a7/QErP7jEOvL3b6PALNrFwDG9ACdFdWAAKA4zspEIdqpj7bPM?=
 =?iso-8859-1?Q?vMXOW3utUZOWrPW0ldoqNXgOLWmr/Lf33FW9SWYk3+fFukHdmb8jMOmGTn?=
 =?iso-8859-1?Q?vMFe3GzCyUbtE3tdAubovKKP3RjhVihKXyPuZRUxYgDGnPWuRpq8iLo2XY?=
 =?iso-8859-1?Q?SzCjik0vE+nbvwmyjc+s5OCgxcwtkBfwH97PFwvRKwSSxVfuwKND8/I+9D?=
 =?iso-8859-1?Q?lQC2paX32TpYZYRECj7eDKsRGiM33sqGZGYakzcQ2Q9X2CiMKWfJbecA/a?=
 =?iso-8859-1?Q?ed0474IGS++Ty2p3wsawhb8UYWUUEDreCNAFddu1NHk8NwCUscTiT75c13?=
 =?iso-8859-1?Q?VeuFrmU91ZXzJUh0rvA/L4RfGb/y/EHSyQ4SCoU3ndfPkI7gj0L9MDzNj5?=
 =?iso-8859-1?Q?UCN+eZTyBgD1kALFxzHy9HEx8yIMuEeVOVYbKP8vb4wp84U/vke8mu8TmQ?=
 =?iso-8859-1?Q?iCLZ8xIfti65mkdCWY4ZVIcld/+YkfZvMCEJHXhrmH9p0kiF05Nlgtq6HW?=
 =?iso-8859-1?Q?wqmwRxR2Xg0/0ersSSErj6F8SX7LR/xF81eYVHhW6PZkoIUN0Qw8l6cioS?=
 =?iso-8859-1?Q?boH7orShg4bgWPmNPcgV8ifgMAr9WZrI3zzZ+8B68XfbjCbtj6+Kr6hMDc?=
 =?iso-8859-1?Q?To1gxrq2i2PppAybE0hwZcsb97ikhcs0rEslevtNi+AxiLsnH0QRSOOhzW?=
 =?iso-8859-1?Q?6fdikBGovhZ9w9dxC3a4Be4aRfVKlYfN0yLY0CGb103nOHT76+IfEDQY+4?=
 =?iso-8859-1?Q?THg0b4/9sZLeEooH+wmPO2WiKt5IGSWT9dMgi/zlEHpaIC5Gco0zfijm6r?=
 =?iso-8859-1?Q?TiY/PX8exbdoicGP5eEuX9J12Hq55++gk16L+OXxG/inS9YSMUfYXSx9aJ?=
 =?iso-8859-1?Q?gnRZ9wXuonlQaGIncZYF8+XUhHlXWUTkDrvAiUk5dQrbJHSHYz4vCPRamu?=
 =?iso-8859-1?Q?wT275YlnjMiHsjuLTx6GSftsHZSDe8VDWGJHYrf7Wh2358A=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473B8CA55219AC274EF9815A2F89CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1206a345-a5d8-44f8-eba3-08d95cd463b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 14:29:12.3495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: twCVYgb3VGEWS68HpuxX3a60NabJtH/Gzj/Gc9D2JOBBhxh6E+Ta6pMVLCH6Nruj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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

--_000_CO6PR12MB5473B8CA55219AC274EF9815A2F89CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

yes, it is a coding error, I will correct it.
thanks.

Best Regards,
Kevin
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, August 11, 2021 5:45 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Min, Frank <Frank.Min@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 4/5] drm/amd/pm: change return value in aldebaran_get_p=
ower_limit()



On 8/11/2021 2:03 PM, Kevin Wang wrote:
> 1. change return value to avoid smu driver probe fails when FEATURE_PPT i=
s
> not enabled.
> 2. if FEATURE_PPT is not enabled, set power limit value to 0.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index fd04391364ac..e00ac43515bb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1194,8 +1194,19 @@ static int aldebaran_get_power_limit(struct smu_co=
ntext *smu,
>        uint32_t power_limit =3D 0;
>        int ret;
>
> -     if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
> -             return -EINVAL;
> +     if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
> +             if (current_power_limit)
> +                     *current_power_limit =3D 0;
> +             if (default_power_limit)
> +                     *default_power_limit =3D 0;
> +             if (max_power_limit)
> +                     *max_power_limit =3D 0;
> +
> +             dev_err(smu->adev->dev,
> +                     "the PPT feature is not enabled, set power limit to=
 0");
> +

Maybe downgrade to dev_warn as it is not an error from driver
perspective, it only limits the information available.

Thanks,
Lijo

> +             return 0;
> +     }
>
>        /* Valid power data is available only from primary die.
>         * For secondary die show the value as 0.
>

--_000_CO6PR12MB5473B8CA55219AC274EF9815A2F89CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
yes, it is a coding error, I will correct it.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
thanks.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 11, 2021 5:45 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Min, Frank &lt;Frank=
.Min@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 4/5] drm/amd/pm: change return value in aldebara=
n_get_power_limit()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 8/11/2021 2:03 PM, Kevin Wang wrote:<br>
&gt; 1. change return value to avoid smu driver probe fails when FEATURE_PP=
T is<br>
&gt; not enabled.<br>
&gt; 2. if FEATURE_PPT is not enabled, set power limit value to 0.<br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;=
&nbsp; | 15 +++++++++++++--<br>
&gt;&nbsp;&nbsp; 1 file changed, 13 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; index fd04391364ac..e00ac43515bb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<br>
&gt; @@ -1194,8 +1194,19 @@ static int aldebaran_get_power_limit(struct smu=
_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t power_limit =3D 0;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_cmn_feature_is_enabled(smu, SMU_FEA=
TURE_PPT_BIT))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_cmn_feature_is_enabled(smu, SMU_FEA=
TURE_PPT_BIT)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (current_power_limit)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *current_power_limit =
=3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (default_power_limit)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *default_power_limit =
=3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (max_power_limit)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *max_power_limit =3D 0;=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(smu-&gt;adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;the PPT feature i=
s not enabled, set power limit to 0&quot;);<br>
&gt; +<br>
<br>
Maybe downgrade to dev_warn as it is not an error from driver <br>
perspective, it only limits the information available.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Valid power data is avail=
able only from primary die.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For secondary die sh=
ow the value as 0.<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473B8CA55219AC274EF9815A2F89CO6PR12MB5473namp_--
