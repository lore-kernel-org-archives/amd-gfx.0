Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59860CDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 09:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B1A10E12F;
	Fri, 13 Oct 2023 09:06:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE19F10E12F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 09:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/3CwuHccDF40g5/4ncHGcyIn7F5RGovydu1isYiy7umTGgyRDS1YYgm0aSSrRXlqouH9lABRMSrcrlHtGqrMla7djlEMqCNymFLNjFyoseHu0EFwz2EiAjHrPov4ga4zcEZwtNSGimD3atKozIiPEHZpGLHLM9ObPscuL8h+F2KtD3E9E9qSLLv0WkGmI9KNqMDXarvH/K1feGvcWUEG9KuCIRpOWXy7sQvdqJjYJOaNvxtlZ13a5NvYb4mJhXKc2ndLCzRilSNS1HalBSE21CrHAq3iVEkpyxMy2L1JlKOsDERvGsDySWMKK4pmSHIme5GLqwNLxgc5Kqsw5asEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13EMRQIzLSQ2oI1uosz8QXIpA9Am3s3mQtNqeZxezHk=;
 b=judQTWnygLtpHaQHJewotjtgqGOVZ/9J5hn7HnLSEcr1QVuwONe5fZ9IPrvo2WZIkmKmPPocbrCsbY+IXqG4KTKKEirJHFLECuWwuVN389qGgdkYnyow2EW85QRYAnvDjupSvmbUECe6NP0jFkbaxx0akda6nm+gQOTmZbOnhbUxF/ApMlHrEocHFA8fdot5NDD5BoF3H+LRcEIeDo1/JEpEn6Tt956jk9zQDuvNwvXSl1/fFpjns3z5EyDjxflDC4lOL7bltUDl16UOIxxi/1dgEvDT35gAOhfaZyUTLwLW5wwVypmReMoX+5GBqdfQzK5D3ZVTwdypLMThxFLK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13EMRQIzLSQ2oI1uosz8QXIpA9Am3s3mQtNqeZxezHk=;
 b=k+7OmJespBEv91xdiSJ1FF4u5jcKSeIzhnN26Y6wBBWb6nvsGvyK6KQYSEd2R8OnYy/R9lhSdQYMvS07C0xHFt7PK3sxthkLKoSqI2csQepg1R/ZfsF/98Dc0hI5mp0+KERG/mZu37YO+Nt9lZGBLCXpdDeYDeIiHVAIqTs3VFQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 09:06:07 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::fe76:c56e:1243:ba57]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::fe76:c56e:1243:ba57%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 09:06:06 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, 
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions
Thread-Topic: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions
Thread-Index: AQHZ/OqnAh473+IaoUC/oeFTrqt0/bBGIiCAgAFJ+V0=
Date: Fri, 13 Oct 2023 09:06:06 +0000
Message-ID: <PH7PR12MB87968C30CFD03482D4CE8952B0D2A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20231012090034.31055-1-tao.zhou1@amd.com>
 <20231012090034.31055-4-tao.zhou1@amd.com>
 <BN9PR12MB525713DC934E04C624AF57BEFCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525713DC934E04C624AF57BEFCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-13T09:05:44.387Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ0PR12MB5469:EE_
x-ms-office365-filtering-correlation-id: 95e5fc54-1ce5-4c17-dc63-08dbcbcba246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KESHJ5RKOocDcxS1Owa/mKi4rg8oRxLT3fWzC8a+qv6xxJERjrYNqbJr819QO8I0j8Ye7t4SCmuYdLdxnhumFZaiwTwaVLkFoTTStHgKUriQR1k3FWKIT7qwA2YESpzsFBInR92OEHIqMBFqSssUAePMhqk2DLevqaqP0cF+zBa5R9f+3Z/x+oZgOvpMEi6XFEN/9jMivz/DMUpvTx7uGLo9bvUU1ZAUHyZwMCLG2nkxfcXYiCnRhHOot2r0MB93CBad2HdTLnp/oWf4y27PNn8UbnijD74nUud2ABO3cyNz+XwQgRJONI/maoLEsxxnm9iD8da+CCSYBs6dJjhHmKp+jYlS9ySUYGdg9vMzfo3rUOUnL+2zKT74UQK2M3nOLnTKHT+MXORz+2DbZfZG4dMr6ZIArulzqtUKizTWdutL8WxAnUBGUiePQ8UVogHJ4nDcQzC6JGja2315M1C7WmFRW47bnYkI7PY79qIX4fYKDjrqQPGDOH5ScRY1urOlLV3zbLJecljKTBl0jOF8TdIc/sYwWmEONFHtpnF9059p3w2+UocM9gUV5zfcqY6hcEW2VG9GTAbefasRq2jhZjqw7r78pteMAFcKefmv4eov11fD2n2uuMlSbl+SDEjqOkfs/2zSm2BHxJ9Kon35w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(55016003)(52536014)(5660300002)(66446008)(91956017)(66946007)(64756008)(76116006)(66556008)(6636002)(316002)(66476007)(19627405001)(110136005)(2906002)(33656002)(8936002)(83380400001)(8676002)(41300700001)(38100700002)(38070700005)(478600001)(921005)(26005)(122000001)(71200400001)(53546011)(6506007)(7696005)(9686003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6hxvo4W+KH21MvbQ6v9LxeQB5VviwwW9gi3APux2QIt8xXhg6f4h1dLmDz?=
 =?iso-8859-1?Q?rfZBlRRlr6Gn6OISGWgikTQls2VwuWd+jZs95KbwfQqHm+WIOKqfDORXM3?=
 =?iso-8859-1?Q?E0H25Hvj9hFSdeUZ0BW/ER/1hbycimIWBG6hU9B2QR8txEG8xrCZANSGUe?=
 =?iso-8859-1?Q?rzN/K3KSsG6P/vOxW64aFC0XvVo3R2QvueE/4O/DjwqK9DpXr5kXB38Ldm?=
 =?iso-8859-1?Q?fpZE86oI7yeFtpQROyvbjm5/x8RqKFeoBvnatsyDpgrg5r39Uz3PIENh2T?=
 =?iso-8859-1?Q?PnRyrDOjqSxD1HaUTJR6/QzeCbmBCg9mp8M8Ka0/FIi5Zr68iNIm+lLt+S?=
 =?iso-8859-1?Q?jIbVZ0B82UIfNTUAOw9WPtdO4kTkPhQMLrdiksBC1G4uazHKBuy/432kjn?=
 =?iso-8859-1?Q?AuN+bZz27Up+OHQbsGxnEZ9wm1X4G7PmvsIu7YGO0NcVYiE5ZG7Dc4IoWU?=
 =?iso-8859-1?Q?0Ul1iC0x3gv12riteU3BPVqS6COOOBMBAwIQdyd9+BbY5gOS640bMGqzPe?=
 =?iso-8859-1?Q?rveBMQ+5aO/SWLU1LWg69BUJEhfRchrS5Q39VaiL5dvFmAP3zlSb2IF32+?=
 =?iso-8859-1?Q?aTNpT97v0iF345vMxiqdeC8kNFWU2HzCssIuKca/TI18TNwTvbyLKgpORC?=
 =?iso-8859-1?Q?EPaQYX8TKAcaaocVe1vZnzcI+RSZHa18txV8LEOR4plmep5zV0ifdgTgXs?=
 =?iso-8859-1?Q?SoOhAFkdUaKB39BZNpZymVTLEYWS4lvwDpOyIlGex4yrAAv9YdYF4NbLgR?=
 =?iso-8859-1?Q?FlQqyKu58F2TCfS71dsDozINTWRFcsG3SqH6OeAhwhLRmfvvBY+jcrHfuM?=
 =?iso-8859-1?Q?nt3YTb9jj37rL1JagHZ90JUWA8xDTF6A+gFi0b+Wh/keDTXAIy2PZC8j2e?=
 =?iso-8859-1?Q?9DZ4ZvOLxVZNEHELqTQuIciZgjMIUD0E5V3XRdbZSkb0ekGMbB2RHLCdxS?=
 =?iso-8859-1?Q?AthXfbxXBghppXKCBOLfHLUHA0IAHtl4PQpELQWYBiUrGYRmAh/JgZWECk?=
 =?iso-8859-1?Q?DsZcxnz7osv2qZDsnxWahqov9NZYCp9tdgBiuG9srWjXNKOpBBshZkJPqe?=
 =?iso-8859-1?Q?2s2WbErvMDOJHm0nY/MNGec/D1uDcMKxcO/R+a4RY03qf+N3NPRV3gJq/F?=
 =?iso-8859-1?Q?0gChbBrFYLiRMcuglNAJTDJTLFTepjJIfhmRyOY/yU7b4953FB4rie+mrw?=
 =?iso-8859-1?Q?5b+akXp/83pQasT0rMAx8HOZ5KqRlLdC0uy06VUv9Z3QOE90vl7rvUUSEM?=
 =?iso-8859-1?Q?oo4NYhTA1nwtKmyipFzM7gPPPYHn6yEO30B0/0a1o5X84x8jbGZRnEM6sc?=
 =?iso-8859-1?Q?QnBXSsNPDv+PTu2C0L2h2K2zXV3Vd45BpXlVJhkj6qO2tcbTN8zPKb3O2/?=
 =?iso-8859-1?Q?YYAR2UDDD+0YwOdqlMAxbDuTD3Jfc9ajn5++s7lIcPa281JHmD1n/8KqFo?=
 =?iso-8859-1?Q?3Tlaw0J25Dtse5EC8nd3fwcsuU1rDc8sTo4RCore8Q50RZsf/BNudncLTa?=
 =?iso-8859-1?Q?hasMI6sk7/8/fvWo4qNTRdhrjld30WqIrTeLktwhPsps2PMwjmwSKkGyPy?=
 =?iso-8859-1?Q?nygo47DNtgj595JeNljNQgnmKYuq0SxHBcv4le1F5r+mm1pUFe7Kop2YfA?=
 =?iso-8859-1?Q?wClxH5XP/Dhh8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB87968C30CFD03482D4CE8952B0D2APH7PR12MB8796namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e5fc54-1ce5-4c17-dc63-08dbcbcba246
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 09:06:06.4180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rB3drbXkXFa3+BgIEVY8Gbd6iGn0M8Q5Kl+EnmF255dccEJ+z3nndYx6SMcDkYj2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
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

--_000_PH7PR12MB87968C30CFD03482D4CE8952B0D2APH7PR12MB8796namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

How about this condition:

if ((amdgpu_in_reset(adev) || amdgpu_ras_intr_triggered()) &&
           mca_funcs && mca_funcs->mca_set_debug_mode)

I use amdgpu_in_reset to skip touching it in all gpu resets, not only for t=
he resets triggered by ras fatal error.

Regards,
Tao

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, October 12, 2023 9:14 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>; Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <=
Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) =
<KevinYang.Wang@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditi=
ons

[AMD Official Use Only - General]

-       if (!amdgpu_ras_is_supported(adev, block))
+       /* skip ras error reset in gpu reset */
+       if (amdgpu_in_reset(adev) &&
+           mca_funcs && mca_funcs->mca_set_debug_mode)
+               return 0;

We should check RAS in_recovery flag in such case. Reset domain is locked i=
n relative late phase, at least *after* error counter harvest. Please doubl=
e check.

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, October 12, 2023 17:01
To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Zh=
ang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions

PMFW is responsible for RAS error reset in some conditions, driver can skip=
 the operation.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 91ed4fd96ee1..6dddb0423411 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1105,11 +1105,18 @@ int amdgpu_ras_reset_error_count(struct amdgpu_devi=
ce *adev,
                enum amdgpu_ras_block block)
 {
        struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_bl=
ock(adev, block, 0);
+       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;

        if (!block_obj || !block_obj->hw_ops)
                return 0;

-       if (!amdgpu_ras_is_supported(adev, block))
+       /* skip ras error reset in gpu reset */
+       if (amdgpu_in_reset(adev) &&
+           mca_funcs && mca_funcs->mca_set_debug_mode)
+               return 0;
+
+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_get_mca_debug_mode(adev))
                return 0;

        if (block_obj->hw_ops->reset_ras_error_count)
@@ -1122,6 +1129,7 @@ int amdgpu_ras_reset_error_status(struct amdgpu_devic=
e *adev,
                enum amdgpu_ras_block block)
 {
        struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_bl=
ock(adev, block, 0);
+       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;

        if (!block_obj || !block_obj->hw_ops) {
                dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",=
 @@ -1129,7 +1137,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_dev=
ice *adev,
                return 0;
        }

-       if (!amdgpu_ras_is_supported(adev, block))
+       /* skip ras error reset in gpu reset */
+       if (amdgpu_in_reset(adev) &&
+           mca_funcs && mca_funcs->mca_set_debug_mode)
+               return 0;
+
+       if (!amdgpu_ras_is_supported(adev, block) ||
+           !amdgpu_ras_get_mca_debug_mode(adev))
                return 0;

        if (block_obj->hw_ops->reset_ras_error_count)
--
2.35.1


--_000_PH7PR12MB87968C30CFD03482D4CE8952B0D2APH7PR12MB8796namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
How about this condition:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<font size=3D"3" face=3D"Times New Roman"><span style=3D"font-size:12pt"><f=
ont size=3D"2"><span style=3D"font-size:11pt" class=3D"ContentPasted0 Conte=
ntPasted1">if ((amdgpu_in_reset(adev) || amdgpu_ras_intr_triggered()) &amp;=
&amp;</span></font></span></font></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<font size=3D"3" face=3D"Times New Roman"><span style=3D"font-size:12pt"><f=
ont size=3D"2"><span style=3D"font-size:11pt" class=3D"ContentPasted0">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mca_funcs &amp;&am=
p; mca_funcs-&gt;mca_set_debug_mode)</span></font></span></font><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I use <font size=3D"3" face=3D"Times New Roman"><span style=3D"font-size:12=
pt"><font size=3D"2"><span style=3D"font-size:11pt" class=3D"ContentPasted0=
 ContentPasted1 ContentPasted2">amdgpu_in_reset</span></font></span></font>=
 to skip touching it in all gpu resets, not
 only for the resets triggered by ras fatal error.<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Tao<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt; color=
: rgb(0, 0, 0);" face=3D"Calibri, sans-serif"><b>From:</b> Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 12, 2023 9:14 PM<br>
<b>To:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;; Yang, Stanley &lt;Stanley.Yang@a=
md.com&gt;; Li, Candice &lt;Candice.Li@amd.com&gt;; Chai, Thomas &lt;YiPeng=
.Chai@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some =
conditions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"3" face=3D"Times New Roman"><span=
 style=3D"font-size:12pt"><a name=3D"BM_BEGIN" data-loopstyle=3D"linkonly">=
</a>
<div><font size=3D"2"><span style=3D"font-size:11pt" class=3D"elementToProo=
f">[AMD Official Use Only - General]<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev, bl=
ock))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* skip ras error reset in gpu reset =
*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev) &amp;&amp;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mca_funcs &am=
p;&amp; mca_funcs-&gt;mca_set_debug_mode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
<br>
We should check RAS in_recovery flag in such case. Reset domain is locked i=
n relative late phase, at least *after* error counter harvest. Please doubl=
e check.<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
Sent: Thursday, October 12, 2023 17:01<br>
To: amd-gfx@lists.freedesktop.org; Yang, Stanley &lt;Stanley.Yang@amd.com&g=
t;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Li, Candice &lt;Candice.L=
i@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Wang, Yang(Kevin) =
&lt;KevinYang.Wang@amd.com&gt;<br>
Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
Subject: [PATCH 4/5] drm/amdgpu: bypass RAS error reset in some conditions<=
br>
<br>
PMFW is responsible for RAS error reset in some conditions, driver can skip=
 the operation.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 18 ++++++++++++++++--<br>
&nbsp;1 file changed, 16 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 91ed4fd96ee1..6dddb0423411 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -1105,11 +1105,18 @@ int amdgpu_ras_reset_error_count(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum amdgpu_ras_block block)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras_block_object *=
block_obj =3D amdgpu_ras_get_ras_block(adev, block, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_mca_smu_funcs *mc=
a_funcs =3D adev-&gt;mca.mca_funcs;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!block_obj || !block_obj-&gt=
;hw_ops)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev, bl=
ock))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* skip ras error reset in gpu reset =
*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev) &amp;&amp;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mca_funcs &am=
p;&amp; mca_funcs-&gt;mca_set_debug_mode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev, bl=
ock) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_ras_g=
et_mca_debug_mode(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (block_obj-&gt;hw_ops-&gt;res=
et_ras_error_count)<br>
@@ -1122,6 +1129,7 @@ int amdgpu_ras_reset_error_status(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum amdgpu_ras_block block)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras_block_object *=
block_obj =3D amdgpu_ras_get_ras_block(adev, block, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_mca_smu_funcs *mc=
a_funcs =3D adev-&gt;mca.mca_funcs;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!block_obj || !block_obj-&gt=
;hw_ops) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; dev_dbg_once(adev-&gt;dev, &quot;%s doesn't config RAS func=
tion\n&quot;, @@ -1129,7 +1137,13 @@ int amdgpu_ras_reset_error_status(stru=
ct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev, bl=
ock))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* skip ras error reset in gpu reset =
*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev) &amp;&amp;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mca_funcs &am=
p;&amp; mca_funcs-&gt;mca_set_debug_mode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_supported(adev, bl=
ock) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_ras_g=
et_mca_debug_mode(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (block_obj-&gt;hw_ops-&gt;res=
et_ras_error_count)<br>
--<br>
2.35.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB87968C30CFD03482D4CE8952B0D2APH7PR12MB8796namp_--
