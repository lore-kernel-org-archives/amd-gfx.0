Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F74EC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 02:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8559710E2FD;
	Tue, 11 Apr 2023 02:43:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E58B010E2FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 02:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWa8XXHMiGwQ+sft6Ia4TrGZv2SioFNz+qHWHoXlpGn4QZB3AMFHQjo2z4YaqE0UEhLTNSGDbh2afwZDCijtdKa5aKEl0heIe8PSMIwQt1k/0w3nXHwGux422GUIsn94c3UQ6B9DxPtngHovuKZ4pAcmn58LWtwJOSRA9Mv+BglIwqi5NNQpflC/0u3JVo/2eCzQylzbkD+W75JwReGIY/6yHsNLSj10SJ0h0G4ypfKyqbXinYP7Q/rDj6honcz3ljBTB6Lu+5WOSMiIEeadWsfuTNueyOe30Sf90aPauShTsHRcUovux6kw8AHKGfg4bpHwmCUxHFM8JntZu0pdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdRHc9xCxMzVrexQgVwVQovIgAfFACFBUlGdmeJM1Ag=;
 b=VRiG2sD52wgMpqcGwykvxBvzdRkd5HC8L4ALVclqSXhvewSX7RXHOapdzgq4e4cq9ogSc/j+5Euhfpls7RklnXOV9Ey9ET/82ZXaKaKG2xHfcSDBVl8kAl9bhuJxynQA9Dtb5lZnY9VHnmBxhdhBLPFr+OG837yVQFWgrxpdKppDUuCd0xrG+TnyqyrbCvpmuJBfBTYu2irCKdJB3BbUtn8hhvwRkoHkivBZVzdbQQf8vm10zlFKyRtdTYfSOWqtit7N3nKV9gAPWOV+XIxjWYTiuqvi0YLJc8hqSCSgso/S8lo9if+s43LG/d4b1IuhSoY5Xkg4uhHsSF0XyPi93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdRHc9xCxMzVrexQgVwVQovIgAfFACFBUlGdmeJM1Ag=;
 b=y9K7Uq8bJKW4d8+9hB0esyHtiQog6wNXbqY0p4H6uJJabtUXjGoDf/XxkLCUatshta488IJ/0oVW4IiB1CbTvAim8fAL4lOIQ5C04F2NAonsSoQz3B+n4FbIajRQFRY7DKiVOn9xBqpa1JJ5u+s0Dn83dFL8gY7euCXz0rRAVig=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Tue, 11 Apr
 2023 02:43:20 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1647:e9a8:e6b7:7a0a]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::1647:e9a8:e6b7:7a0a%6]) with mapi id 15.20.6277.031; Tue, 11 Apr 2023
 02:43:20 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix introduce gc_*_mes_2.bin v2
Thread-Topic: [PATCH] drm/amdgpu: fix introduce gc_*_mes_2.bin v2
Thread-Index: AQHZbB5c6VO7hD3VZEKmmf+P3X3goq8lZawA
Date: Tue, 11 Apr 2023 02:43:20 +0000
Message-ID: <CY5PR12MB6369C27A5375B58A51145EE5C19A9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230411023534.2439943-1-li.ma@amd.com>
In-Reply-To: <20230411023534.2439943-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T02:43:17Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4b058e19-782f-4bdf-92d4-9f66729dc15a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T02:43:17Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7a62de35-4393-43f9-be0a-8bdc224db49a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM4PR12MB7501:EE_
x-ms-office365-filtering-correlation-id: 91f24b95-87ab-4433-fc02-08db3a3682f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUAypLmTmKRlSjKnAHHFBjZB/hZQlBqwaMumatAumRu0VjM5Shqh3JRHIYhGjqbyuQCxfOfn1Qkj7YRAUIde35LpecjfLyrMLmc4qwq8ZajM0XDywNWyLQjDGM6PhcXUahJDCmt0nNYZyz915RKTMS6tSPpTuoMI2F7BayzJ5B/ico3zbqqrzcGm4vJLm8JboIJKV7WHBrjg8nNr0eqm8tN9YMl7cSzLkW2ytTfZ+HV4vEUXKUZ/2H3YuTFwHQkkAPwuSoIgYlxpz5V6lhemFPhwqmuvRPdCUlyeqHGYFSvZK0uQvTxcfApN9UsGceJeh/5dEmEoSsbwfefXJRUaEfD2+Faaw6updxWezadaCo5RffpjH2zwFZaxzsgOGbPS4Yr1opS56Infy5OlZ0cKeeAhE9Ewsqep0H+SuEApbZPQhqY1/FqVALG7N1K+0CEKO0gklHwO1ZeMXTGNzy7H8skyix4a5kmY790jTzeCD7WljYl0pH9ARQzLfoyohst9iBbKKgW9gJ7+4sQRBHkIfQmuVToH/OM8QdLqXMwrYfUJ69i65l6OtEtK87710jm6+7/xQE4JhOtYBrpbfe+V9yxDYTNOx4HalKQaSB5hlOP6RtU3XO8zlonxDT7ewwRP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(316002)(110136005)(478600001)(54906003)(66476007)(64756008)(41300700001)(66446008)(76116006)(122000001)(33656002)(9686003)(26005)(7696005)(71200400001)(66946007)(8676002)(4326008)(66556008)(6506007)(186003)(53546011)(2906002)(5660300002)(38100700002)(38070700005)(86362001)(83380400001)(52536014)(8936002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qjHO5kmtT/tDg3k0OG5Ih/lUvjiVP8M4hiC7bhUnCroSFHH+4Ybvg9NdUhu2?=
 =?us-ascii?Q?o9XvdPmgsq4P+n9LjhmOXPwWAdRqdPtifGqKHeFwp+p6bh6pBSJNQnUe/TlH?=
 =?us-ascii?Q?nuM4HrzfoVJ/Ek0ct9wgUojEJ4MvKwofPcELpQR+Pw7ApPoL+gCPoSpb93BR?=
 =?us-ascii?Q?AzqW5oPHPJLBJq5tCGNGnqVPnGTefQBd6VJ8dAn8V+nwv18BCEU6xKCriO8E?=
 =?us-ascii?Q?E3GySvssdYhnll3NWrd2Pd90ozETZR6HuAuEq7SDaiOP4BKC9dLwDLXsB1GN?=
 =?us-ascii?Q?pWvyxHilaz/SJyH3+pNqZ9pPXBrHWfSRbzkrP6SWSbfs9mn2pxSCbO2S6EXo?=
 =?us-ascii?Q?bYhPWBmeg2Xdh8FU64NjxHKrLBbMUVEjaZkMtRCHebOqlbML3MNG7XkX1taj?=
 =?us-ascii?Q?GRoenXQ68bJcZ0HQObgjbHMesOoi5YHw4XawUHTRYvf0B5+leTJa6durgvu/?=
 =?us-ascii?Q?3ePvpXqCtpPPKMqIOyNN7uaOAewxnKv9hxcH5jFuy2sHitZcnHSUfg1KPjGc?=
 =?us-ascii?Q?E3mC6Uud0F3YzPqy/czHo+STjBMeKaKoWRijFgkYPiICtD+LYrt7CixqvY5o?=
 =?us-ascii?Q?p/fIG+iKUA6ylruYR5e4ZcuiUa2CnBgJCSz/dwwV/gnNYO1Ek8XzyrwaE525?=
 =?us-ascii?Q?bANUE0/hb1FbGeJP4pZaMS8UvCOcfoJ+OONy+Cte5qGYrrXBrbXYBt2PR5HW?=
 =?us-ascii?Q?S6XCc3tjgWEbHJmw7C/5MpwZxwaDWfQWDWW2Tgge1Vu5GZeztSxLecAUDVRu?=
 =?us-ascii?Q?zU8UcI5zbGmiZ/Uy6F8KbazCK6CrNyhGxrPYoe6Pw03lV5GuZgbFrJFbE8mq?=
 =?us-ascii?Q?XD+9XBDyI7elC/XRFadRT5IN5Cdz4bCPhmUPP75waBw34zZmUy9HbmWLILea?=
 =?us-ascii?Q?Bp7TQc9CYW2ZCBN4RbunK7WpYEVQzsBOOH+yaGVFwsSayBpN0Q4laXlNbm0v?=
 =?us-ascii?Q?y1sf2uBsq/NtSuuAJD+4PM6TUyRVKXB/j0B4NJfEkSRnnCcCYf89724dutmy?=
 =?us-ascii?Q?jWXUuwzOvVFFwoWlsedaZctkzg8RPltquszbx9KDmCb04YLdQC69EriIizgX?=
 =?us-ascii?Q?JjipyL9LqlkV2c4FrFdtvMNln6JdWLSu4l+Go/jfXlGRB++ozCh7NuEYZP6e?=
 =?us-ascii?Q?WUAX1Day3ldxI29Y3NYb8F+obGeOohlHz5gFRytv+/HbhTTtqMG0oS9+DJ3Z?=
 =?us-ascii?Q?oI5myloYvuYczMF/cH6OyWU+s6ONqKPkr3xoGjUWBIkJOvLqFDogP76sGpUk?=
 =?us-ascii?Q?hzWBclrO+knfkQ/I9yc2NVambOBeTG8ZEfSlNJj7zQCmUYZtLBljy8eX8AuI?=
 =?us-ascii?Q?rwRYpTyGyjyckwfT4jXBdHLhTfXnIqDE4xQeO5DY+og7pYe2cIIxu4JZtcV7?=
 =?us-ascii?Q?HG75CaMLd4f4DbpfANcrElkRgcU6Ae9kOgv3s2z2gzAtmvuNWPtQ7wCzwCv9?=
 =?us-ascii?Q?zgxGLXVl8hv5d6n5snP1SotCQ6XNrfLXJUFnp99yKE4JCtVx4MwGhuWrqNLd?=
 =?us-ascii?Q?BktDSHH48TnXtsvWqvz0jzohKRxST6ygv0fPD39O4OpYop1cWYZj6CjFkRCH?=
 =?us-ascii?Q?FN18XyCsKVRzjFjqtcM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f24b95-87ab-4433-fc02-08db3a3682f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 02:43:20.2574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9EVl/WHvUaJVu/i/ezME66kksqGIhS6q1Hjc7OsvuBKfP/AbkmpnPtOZIuB3Y2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please add=20

Fixes: 0f486b64b8d4 ("drm/amd/amdgpu: introduce gc_*_mes_2.bin v2")

With this fixed, patch Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>=20
Sent: Tuesday, April 11, 2023 10:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd=
.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: fix introduce gc_*_mes_2.bin v2

Rename MODULE_FIRMWARE declaration of gc_11_0_4_mes to gc_11_0_4_mes_2

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 67f7557d545d..7e8c15cd8dc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -40,7 +40,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
=20
 static int mes_v11_0_hw_fini(void *handle);
--=20
2.25.1
