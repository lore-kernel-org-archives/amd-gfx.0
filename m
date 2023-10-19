Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C08CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 06:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C326E10E483;
	Thu, 19 Oct 2023 06:00:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCC010E482
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 06:00:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCBKjFInPKIf5O/ba/PdO+SUHwLR28OQ6l7UWYBOpJvx9DJp56uH83jxTUIj6SzHE8dzPQQbrkyglYRw38uxWoi1TwxXz70D/Ce4HYWSK5EhM+gz2GJe8Hc1H4mnlwjE2aqlV4Q0r2ma4hRM/aE54kRQ+6J1b3g87pmpS4xMSGp0lJoU9iwCesqvF7CqdI5XoUdNlzs8W5uKU8jGgqoBgoqr1SSb8/FqOEUwGZChfJwT1kgdVK5tlJBPPSX/000FuHnpA9IfAhebrgRdBtNS1jot34OLorhgW5E7mdP9rrxLYya49O7vhnBV7wGXJjF34UMf4QkNYaZ1+d7Ogb1g0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sC6xZijMJ2yCg/0QcJ6cuSQWrt13ovtuDM+9kBYO8k=;
 b=Li+nEgoX2jclzvZwakyzUqZdmDE6u7hUbZFMDFLP3TByzvghJlITJQUNX8hm62udmSgfj053i1IcmNdwBy/e8TqXquzJBcEMq3rzLcj83iwT5cYCTPGpcsnvsjzXxm9DMY6uETyEntQv99kDnUVgst7FhFM4NlWp2uz8HH4SGOIRY6BiqVCj2PHEYlA/UjSZsJF7v50245i2nGrfJygHNp2DZquhIKyd3mLGdsjBcVxiuQFgz10/hluLhKMh98gd9RPRWKEJ5oTq1g4QqUn4Tjue3SX+Ev3WLR9ZvgK4D03feo2hsl1X4j+2id/zVi5BSBtsPHOf3W15B658APdtCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sC6xZijMJ2yCg/0QcJ6cuSQWrt13ovtuDM+9kBYO8k=;
 b=sUnY28EP6GyXRyoTur4h40A93WTTNImjna5WzK8RbEZnDo3lnv3CjUeww7F/1WpSBtt908Xw6IHkE98iUo3QDNn8McplZq10RVLW0ENcshDSZ/GLOR+OsuXDLDkKbo+IARgqOsCavCB97XUbbXGHIc2uLBAeSd1gitPUUB/NpZI=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 06:00:36 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 06:00:36 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add tmz support for GC IP v11.5.0
Thread-Topic: [PATCH] drm/amdgpu: add tmz support for GC IP v11.5.0
Thread-Index: AQHaAj4P++7d/gBawEWFsbXfz4KsgLBQnj7t
Date: Thu, 19 Oct 2023 06:00:36 +0000
Message-ID: <CY5PR12MB6369040835E0F92AB50CD16EC1D4A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231019034025.3184944-1-jiadong.zhu@amd.com>
In-Reply-To: <20231019034025.3184944-1-jiadong.zhu@amd.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T05:59:04.1879338Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BL1PR12MB5125:EE_
x-ms-office365-filtering-correlation-id: e35cac5b-88a9-46f3-953c-08dbd068b6f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IUPfM9SoRyf1rX9g6xYbWJ7e49g/D/zYf/ldkkpfTwy6RM5+kgd4msTgQv0NdiCvAn25o3j7KROdj8bIe6g+iT7vl3t2lbd926+GkSkNCfrMpLOceM78ZmLKx8tCek46uUMBkokjcAvEngifDMS43WU3+7DiTAHKAhB++qYkruHUOIkxHabZstMu6TYlGr72T+c+I4AN19zz4UDI2CnDRILVGG2jHQAzjwjWWYRzyCC1hueRsqh4WkvCsIiKZPkObis/PxX0aCu26R0GSSstLw1kgX8RuWHBS/Ww3dMLflMF30J0ZA0shW9ounfFVMO8Dhr2HpwKwtjT2ubcphS2ueAHk5Ju3+kgFoWvpGKfmDMaxTXmoPXgnwFrflBKB/eqmUpcrjAiwjJI2Y0NfkX0yyLQZXtCdti/4FRnKbfZKJxR6UVhAe9HFLA2836OYu3i87TpFKYVOwkE6Y8WUaoKaPFiNRVR5ovMC0nH2S7OejgTF0FJb0CAnvKF1TLWPdtl2y69X0MCJm8SOE90fDBFqyCbNkn5HnqAZxpUFZfrf771VTjaYndyPIRI3FsSzgYuMiEd0KOR4O2XZLgJSyBchCzjKoYFPyJii8j2LjCnicrYGQxKOsgAlDhZ71eFI3Xm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(38100700002)(52536014)(71200400001)(110136005)(5660300002)(76116006)(66946007)(4326008)(86362001)(8936002)(41300700001)(8676002)(66446008)(9686003)(66556008)(6506007)(64756008)(316002)(6636002)(2906002)(66476007)(7696005)(38070700005)(478600001)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SXovcSt0QnU2SzNFbjcvVE9CZ1dETC9GQVQ4R0hTTk9tdHhzL3dOMDdoZ2Vz?=
 =?gb2312?B?S2NzZWl6b0huNC9nUDZ2aEFGaXk5cWZJVFh0aG1CQ1BXcys2MFBqZHFSSWFX?=
 =?gb2312?B?cm5LRU1YN25nZzZMMkhRMkNEQll5Yi90Y2toUmRiZm5ja3I5QlIvayt4VkZK?=
 =?gb2312?B?MXVGQ2ZOdHNVL0Q2S01EeGlDa3phVENWZGlGY1BRQ1ZSZkQ4Wk16Q3FvOTRU?=
 =?gb2312?B?YXFNYmNjelkvNHFjenhVenkvcE94Ymc1RzFETWxoVnBBMzBoSkRyS2czdjZ3?=
 =?gb2312?B?LzVJUW5tbFpSOWMycFZSOEIzbGovWkp0ZHREdUJyNnlnTUg1VHhMZWNZdmc0?=
 =?gb2312?B?S2hHQVBOSzEraXJsMk5pem9IbkkwZVZRUDdRWTd4UThyWXlhajlHanBEK1Rm?=
 =?gb2312?B?NVp3bEJKQTlDeTdCVW42UVZGM056Y3Z4cnlpaVRZVU9CMGxIelMvSzkxejJR?=
 =?gb2312?B?WDBwU2J0azEvWkZneVBXOVhSenJiQlFVaThyZEZVbENzYmdsdHkwYnVPWEZQ?=
 =?gb2312?B?WVZqQmR0SlJvMkFVcERsTVVVWnhWc3FDbFFwV1JRQUJQaU9Yb3V3TC9DMmZZ?=
 =?gb2312?B?OG4vTWVkL1VIKzRQWFQyNFFRSm5Fck5aRHUyeU5IUE5CYkxoR2NVc01IN2xL?=
 =?gb2312?B?aytvMklyUldTVGdqWTRHaW9NNEp3NDB6ajVULy8zODFWTWI3cnBnK3g4UUVD?=
 =?gb2312?B?Wm1td0x6SW1WS3pmR2hRdjJ4bzg5b0xiZVMvRVpBYlloNXNzMi9NalVqK3RR?=
 =?gb2312?B?ZnVXdllicEt0VVZZU2szV1NvUy85VHRXdU9OTzNkU25kVGc4UWQ0a2d0SFNJ?=
 =?gb2312?B?Q2FVVzVCUTBkVVJvR3lFREl6RC9mcWNRR0FKSmdHSjU1aDlSUDh0a2dLK255?=
 =?gb2312?B?WmZZNElpZy9GWXpmekxIMVJ1ZEkzK0s2NzRBRnRxTHAvem02OFBNaWJ4d3d0?=
 =?gb2312?B?TExLY3MzRERPVmtLeXRmcXFReVBlS2Vqd0tIWGozNGNYWUdPNWNKMmN5TU5U?=
 =?gb2312?B?a0J3OWV4T1pUaXRSb0NlRHlVSkROMUFES0hjMUt0WVhyWHR5KzYxZ0NmbWtD?=
 =?gb2312?B?cHpvTkYrZnRBd1E5OGltZCtHTkt5SVJQbHF0UEIvYWpHSENnTUdQcURKSWVW?=
 =?gb2312?B?WGhDNDVqWjVxb0xSQm03OXZzODJOQ0pVSGtFaTR0Unowdmd0WURScGhoTDB1?=
 =?gb2312?B?RXFiS1NteEo1MmsxRExLTDg0TS8wQ0hIbEVZYXdrSVBnNXpvdEdidTcxWEM1?=
 =?gb2312?B?RXFJZVRWb1VBeVYrRkNSUmZrMGhEbVl5T29KRUY5Z0VhOEcxbldpUUd5bFBK?=
 =?gb2312?B?YS91TWViUGNRci8xczY0QnZySE8wcmVtUzhUZmprS1EzYk5lVUwvVFNuaCtE?=
 =?gb2312?B?WWphT0tNb0NHV1JUajU3cm4zQ3UzK0RJcm1tUk44bkJId042VHBGN0xDRnZu?=
 =?gb2312?B?MEtEVDV1T0lUaDY3VkNkeE91Wi9WZWZsazFRbzR4VzFCYlZscjd5czJxa01H?=
 =?gb2312?B?L29scXZ5YzNnUGZaQkduTFJnNHdsT2dmb0lKNEMvblRDZi9DTU5XdU1rT2E1?=
 =?gb2312?B?VUdYcUoxRjJWL01tT3FXaVdTOGloRHJwNlMzeXhrMGdLZWN2SlZSMnU1UkNk?=
 =?gb2312?B?djZxMFQwaExpMjJuOXcyUTFCSGdGVXUvWDJOUkpDT0pWc1ZORUkxcG1JU0Fr?=
 =?gb2312?B?dlE1b0FMWHFOeEUxNDZVR2FCR1FUR0ZSdjJ5YzZxSWlrdmsrbkhaaUF1SWpB?=
 =?gb2312?B?eFE2d3JNSndXUG1LS1U1VTBKQnBBWFpRTWo2ZWJrWlI3NlR2Ry9wbDk1UDV1?=
 =?gb2312?B?SWV6bUFxWXJoMEZiSDR6ckx3b08zV3FkQzU4TjFaVUZMWGpoR04zUDZ3Tkp4?=
 =?gb2312?B?OTJWdHNESG9WdG9SZmRtRDlrVHVtbXpBYzF0ekwxdW1FY05aTFJVbkc0dnA5?=
 =?gb2312?B?QUFHWGZ4VnBtd3dQQ2xsZzBZK1BDcWwxR2psaGd6SHZYZHF0TFhyYjFLNURm?=
 =?gb2312?B?V0svZnduMG1TRVljMVIxUEJHMmhUN1daOXBDQUlkR2lydGpiV1krY3hJVTV3?=
 =?gb2312?B?dk1uYlZUTERJU1p3OEdZLzFDU2F5V3BpcVJnWkVxTXNqUjRFellkcmpYRVc2?=
 =?gb2312?B?YVcxNmtOeCsxU2h5SmhlYnduRmR2WTJONVE0djYxODJtYisvZEpoL04vZ0NV?=
 =?gb2312?Q?l8juhnY9P1y2LhDPTOfSQhkvNONgITSL0CYvdVTigTBY?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB6369040835E0F92AB50CD16EC1D4ACY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35cac5b-88a9-46f3-953c-08dbd068b6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 06:00:36.7482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bm8sM1FKeB1D0ZxWwN6uWqKQoLVolO5QMV674pWt09249MJmPd77A4eOc5/dPDc4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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
Cc: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY5PR12MB6369040835E0F92AB50CD16EC1D4ACY5PR12MB6369namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBZaWZhbiBa
aGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0Kt6K8/sjLOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPiC0+rHtIGppYWRvbmcuemh1QGFtZC5jb20gPGppYWRvbmcuemh1QGFtZC5jb20+DQq3osvN
yrG85DogVGh1cnNkYXksIE9jdG9iZXIgMTksIDIwMjMgMTE6NDA6MjUgQU0NCsrVvP7IyzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Pg0Ks63LzTogWmh1LCBKaWFkb25nIDxKaWFkb25nLlpodUBhbWQuY29tPg0K1vfM4jogW1BBVENI
XSBkcm0vYW1kZ3B1OiBhZGQgdG16IHN1cHBvcnQgZm9yIEdDIElQIHYxMS41LjANCg0KRnJvbTog
SmlhZG9uZyBaaHUgPEppYWRvbmcuWmh1QGFtZC5jb20+DQoNCkFkZCB0bXogc3VwcG9ydCBmb3Ig
R0MgMTEuNS4wLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaWFkb25nIFpodSA8SmlhZG9uZy5aaHVAYW1k
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDEg
Kw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dtYy5jDQppbmRleCBhMDI5OTJiZmY2YWYuLjJkY2UzMzhiMGYxZSAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jDQpAQCAtNzg2LDYgKzc4Niw3
IEBAIHZvaWQgYW1kZ3B1X2dtY190bXpfc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
ICAgICAgICAgLyogWUVMTE9XX0NBUlAqLw0KICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDEwLCAz
LCAzKToNCiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgMCwgNCk6DQorICAgICAgIGNhc2Ug
SVBfVkVSU0lPTigxMSwgNSwgMCk6DQogICAgICAgICAgICAgICAgIC8qIERvbid0IGVuYWJsZSBp
dCBieSBkZWZhdWx0IHlldC4NCiAgICAgICAgICAgICAgICAgICovDQogICAgICAgICAgICAgICAg
IGlmIChhbWRncHVfdG16IDwgMSkgew0KLS0NCjIuMjUuMQ0KDQo=

--_000_CY5PR12MB6369040835E0F92AB50CD16EC1D4ACY5PR12MB6369namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"ltr">
<div></div>
<div>
<div dir=3D"ltr"><span style=3D"text-decoration: none; font-size: 14.666667=
px; display: inline !important; color: rgb(33, 33, 33);">Reviewed-by: Yifan=
 Zhang &lt;</span><span dir=3D"ltr" style=3D"text-decoration: none; font-si=
ze: 14.666667px; color: rgb(0, 120, 212);">yifan1.zhang@amd.com</span><span=
 style=3D"text-decoration: none; font-size: 14.666667px; display: inline !i=
mportant; color: rgb(33, 33, 33);">&gt;</span></div>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> amd-gfx=
 &lt;amd-gfx-bounces@lists.freedesktop.org&gt; =B4=FA=B1=ED jiadong.zhu@amd=
.com &lt;jiadong.zhu@amd.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> Thursday, October 19, 2023 11:40:25 AM<br>
<b>=CA=D5=BC=FE=C8=CB:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
<b>=B3=AD=CB=CD:</b> Zhu, Jiadong &lt;Jiadong.Zhu@amd.com&gt;<br>
<b>=D6=F7=CC=E2:</b> [PATCH] drm/amdgpu: add tmz support for GC IP v11.5.0<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiadong Zhu &lt;Jiadong.Zhu@amd.com&gt;<br>
<br>
Add tmz support for GC 11.5.0.<br>
<br>
Signed-off-by: Jiadong Zhu &lt;Jiadong.Zhu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index a02992bff6af..2dce338b0f1e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -786,6 +786,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* YELLOW_CARP*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 4):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Don't enable it by default yet.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_tmz &lt; 1) {<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY5PR12MB6369040835E0F92AB50CD16EC1D4ACY5PR12MB6369namp_--
