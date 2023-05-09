Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0DFC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 02:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065DD10E161;
	Tue,  9 May 2023 02:46:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A6DE10E161
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 02:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/Hdz57TdIyll6bv46qQZEfLz9VS8DghNeOxvEiRO9xLItET/sHxhF75COK0AWnY7oJKIdDNTydg//ciuQWD+jVEJZs9FFN9V5dfrHqd+BcT0WpXGGBaUel6+fORCjrBphgpwPWzc19qiYBs6B03klU5Skb1cfWd+jdfPy4JhQcw1BWJ7JoZ2skZzUI9hfv6TDKQrpmyNjgxo2/4PUsYkm1+rRTO3dtHdJb3YA80hyK0e5oKX/6FAE8sod3BInG3nQ2eXldfEK5Vkg4bLmY3crGdJEeChw9goP6zMDOTGlOoENXYrr6MQp7Pbf6erHi9qgOrrZntHiuoHlya6+u8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mODMH1nnhWfXL7ZEGH69r1izN6wFWqGdfO7yPmKACk=;
 b=laLko84XlzHBduNHmHxRAsKrvD89OjKSX5OZoKnUNrgo/KQrmigh7jxgfXAAkWMmd8/f9B342JFH4tlbXstRJv74aBpHXlZaDDYLwKi7Sfrd9kCAnJFob/wWNp2EtzR7gdhPofLQX9aBpLpQbFLW5L0xmFfeI4RHizRKmam6lPq71/h9+0kfCG2fEWhu5W9lt4vXRsOoHJJ9GlEbT9KvK4rEsnqC5jH9AVhmOZpN416X1cJtcl4hYSjMDI7/X7pZA2bwJNLgFN5Is+Wphv9xBNpTt8vTFKZyzydlQ3EWlmrynYRB/XL62WO6mj1IyihTJjgShU7+4ZY18PDn0p2HGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mODMH1nnhWfXL7ZEGH69r1izN6wFWqGdfO7yPmKACk=;
 b=Iu6GFz+zsCprE0muI8OnLyaM9rCtrUi1Pr5tMhkCVIbestJpTlW11IYhVcz5DK9hn7L0meUhHaEhw53SknkNEWKJ6ayrlpv0vNXYtVwtk5I6CY9L+3k/fGR/0uZ9YBZMYYCXay+Upqowi6CSC3sr2VGEVZpdcQG4DsmDNy7tEQY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Tue, 9 May 2023 02:46:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6fe7:b96c:789e:3eac]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6fe7:b96c:789e:3eac%5]) with mapi id 15.20.6363.022; Tue, 9 May 2023
 02:46:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Thread-Topic: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Thread-Index: AQHZgheeXkDHChCB/E2la/aTCAoOoq9RPHuQ
Date: Tue, 9 May 2023 02:46:14 +0000
Message-ID: <DM6PR12MB2619AF832408EBCA8CCF2E8FE4769@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230509014233.2101573-1-guchun.chen@amd.com>
In-Reply-To: <20230509014233.2101573-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-09T02:46:12Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=656b3089-f771-4494-89ff-60c80c16c859;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM6PR12MB4579:EE_
x-ms-office365-filtering-correlation-id: aad81732-d770-415c-0c18-08db50378e97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6Hx1YgcKepz42KbC1unwQlI2CD3FbmBMuk/TS9Gsgwedft0VLiC8r76C0eXUtB9R6wXYZtOaC4LiZ7Z6UQmMl8cau4NZDOcP7rXZ2hLpAbxAWEpgDJ5JPIanfdvmb7klf7muPlYW8X4ylkIKffs03r08JPrUNTbEsRGXtuZexXYtU4Fgqm2VhGXN+8J3Vk+aJNOcohrFIspRoJjy4vuySlO6aYdA3tCZGEB+ynS5NXOmY5RUVfxNaQi0AWf1g/6JEvbkKrIXopKkkh4gIftItZ+VIzULLfbrHX9zdjyLEMZG5vhdWmQCyw9O2oZIjrU3rKbWTGbxEcNnkBLd7TelicPAq0+Tyc0s6IWEf66mHoE8HiFDO1+RHfWDwjB6U46yi2czzPFe1onwocs/Bw2EIDrGoVutvW1oadxTJthaP80xd5pHlzAZvq5BlxAlFOfkMG1LFJMlvWFXWHKkFsXS9dpF4gTUlJWen6xYgu3aCVPlSmEeuIpk98+1v6pKNPLjL2r6c46O5k9KVMttx2madOZlZZGrlIWEkdUj0ufWu0kL5MZ/WW1oxoBWjSbW8UvngxIQi9bVmJJuG/AyoK4pE7Ekwpjxlt5cTY3uw3t/GI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(83380400001)(186003)(2906002)(38100700002)(86362001)(33656002)(38070700005)(122000001)(55016003)(7696005)(8676002)(8936002)(316002)(71200400001)(41300700001)(5660300002)(52536014)(110136005)(9686003)(478600001)(66946007)(76116006)(6636002)(66556008)(66476007)(64756008)(66446008)(6506007)(53546011)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?szy9JbpoFwsuNsER+1DrARKSeuXrncHNDIZGRBScOd+mP8RK7THXBrtMiYQB?=
 =?us-ascii?Q?6UThgPVSpOZyRxgSr8aWRwaOladuhwxwv289ugGJVfYYqTUxIhEJHt8OexwH?=
 =?us-ascii?Q?ewkj//Irie4ty+Q48Z9RgB46jxwaxHQEvwD4RcjJ57W0B9oYC4SSU6wr3YbH?=
 =?us-ascii?Q?vrMzTm3ymhx+FgXnthGSQ1bti7Ej8W22ahOrEQJxmiTB5V+JbAjgrnMbdg5w?=
 =?us-ascii?Q?JGHe2sdPONn3RrgQgEf3OFSo/cdUPZ7g29sIOvjnHkq5N9kMb7/CMBR0nZX7?=
 =?us-ascii?Q?1ndngVNWQh6+d5pYVntzb9ikfmm+cBFGD7NlxTbrvch4AxlRdfLJNY4YONyv?=
 =?us-ascii?Q?EuNgqOho0FBTFImqqBHP/xH1Ok293h4/+h5GgTMADAJ43KR/nm67K48PGXL/?=
 =?us-ascii?Q?ajb5fTLbBnFHkRacYH1VLCleKBgFs0opJiy9pkQCE/uLD1fC1gtn6cMM/KWd?=
 =?us-ascii?Q?xXeOfcy1xQtx+i6CDieoHiuHG400cBpFxSQ/nl4Kmigf8gBvLABUtnSMJSAD?=
 =?us-ascii?Q?Z85oj405vPl1V3NGCnTo+/DKR/tde8qoxCFmrJonzgI81zk++t/oWiXOaSjO?=
 =?us-ascii?Q?eyAAH/9TBFJKQjAogYgBpvAT3VTfPHeI54tgZ4RkyJkMeAtUalZsj4BIj+0U?=
 =?us-ascii?Q?jWhy8qM1xXaSGAgdwGJq0E+CgBuzpHM0GE3OQaryXgPamizNBXSkT+eikGh/?=
 =?us-ascii?Q?nuP86xcKfqMJOe9e7HRvcG28qDhTuC8fZ7ixDkJ92SLLyj5bjigbrVVu4QO/?=
 =?us-ascii?Q?LHTcxrUne68qf0CS8HzCprKgHhLS+6sVCwLqlPUG3vdzrp9ZeiuCEktXHjBF?=
 =?us-ascii?Q?Nh87mD+S8Y912+btfyl2PRNWz5Yo9wCQq3GrddPEBpnP4BHxvL5sYt+FwEzD?=
 =?us-ascii?Q?wRLkUdmflk5WYeOCITEARNeP07DIGT86EqesqjY0ZZai4xVI0OJMFBvL7ouY?=
 =?us-ascii?Q?5Rj8VjMhMHdaAm+LESlxlbVvghMkBul3V6HXManMF1LVzHECkT1uViL8W11q?=
 =?us-ascii?Q?5Q9df+Z2UzW/DrP2jF5EGYD3H0H1tZQOxVdopC8TZCAyFmbD4T9TutEOcNPN?=
 =?us-ascii?Q?dR3JY5uEbktZ6Q6n53F5XnL3Uy4wNORXuE9iIVenFFQILZN2jH+ba81cXE0A?=
 =?us-ascii?Q?SC0GLomC+gAKo5dQvpRRa6kUIr0yUflXctCKSINtW2voP9/7D5mStqBHlWwC?=
 =?us-ascii?Q?Z+8yc7DVSaPb64Iq1LRBzQJlOfyd5NJXR7OPX4qLtQvPE+NSePMCxxMKE38K?=
 =?us-ascii?Q?nMQqV9CEm+wcZE82gkjE1maxfZcMviPiQ0CS/GdhvRmmld1ixnGr4N7MtoHI?=
 =?us-ascii?Q?I8TVPibOp5/qoCbpvoU6bz2rvf+p5y9syRDT5wiIZRpoFHOA4knkafGJfems?=
 =?us-ascii?Q?VRjDc8q5xY+jrSMrsz13tCQq4es/Dht888rRQuejGoDCecFugODgJYBYg4PW?=
 =?us-ascii?Q?hvWj+eWRKuCQj+zGpeqYSzzEzUPbF16sqABzkoDNEwqSq8ZjDX3Dd/SkRlOk?=
 =?us-ascii?Q?5X1142Mo+6ZR3ByAxVa7IRMgKOGg0H2LyA3BjFubw1Ht/jGyb+OXS1zxjZR9?=
 =?us-ascii?Q?dfOlBkd3I3qEkQopkLw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad81732-d770-415c-0c18-08db50378e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 02:46:14.8524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNfrERTWbBVImEMpAOQWlVtBl4wRb6WzJXDIQY1WSC1sLRGm83W32ynDEuzZDrmG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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

Acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Tuesday, May 9, 2023 9:43 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
>=20
> Prevent further casting on chip MULLINS/KABINI/KAVERI when calling
> amdgpu_dpm_is_overdrive_supported, this can avoid UBSAN complain
> in init sequence.
>=20
> Suggested-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 86246f69dbe1..ccd3ea89eacf 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1467,8 +1467,14 @@ int amdgpu_dpm_is_overdrive_supported(struct
> amdgpu_device *adev)
>  	} else {
>  		struct pp_hwmgr *hwmgr;
>=20
> -		/* SI asic does not carry od_enabled */
> -		if (adev->family =3D=3D AMDGPU_FAMILY_SI)
> +		/*
> +		 * SI asic and chip MULLINS/KABINI/KAVERI do not carry
> +		 * od_enabled, as its pp_handle is casted from adev.
> +		 */
> +		if ((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
> +		    (adev->asic_type =3D=3D CHIP_MULLINS) ||
> +		    (adev->asic_type =3D=3D CHIP_KABINI) ||
> +		    (adev->asic_type =3D=3D CHIP_KAVERI))
>  			return false;
>=20
>  		hwmgr =3D (struct pp_hwmgr *)adev->powerplay.pp_handle;
> --
> 2.25.1
