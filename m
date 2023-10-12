Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E381FCDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 05:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 625B710E101;
	Thu, 12 Oct 2023 05:53:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF03B10E101
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 05:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4SruEksFKTG7JK2OhxAIspZSbZ6dfr2KxgPJ45e5oeqfvo8ceTk0PuwHBg/ulqrGrFWI9efFhXLJAVvkaKDjHxneEN88WqAuziamvwUNMVa/PVOtgQLRLSmyBJaw6tQvY180FbkBJa/mE4RCiYy7pK34ZRxRGyLUKay5wYD3m3kKnY2wn124B2D19NBt6MErRuWFODngr+/G5Uh8Ad+MD2uJRXIGP9pip0eoJIWG0rbBvkMf/fbcIX+YvXf3fhOCY/Kcy5dluWQJ6gPXCfnvKYP2jR344S+oEgo/VsOL3F8fn0KkUxPYwendlcWtBNgDrHvz0Q1SUyEw81N5YpFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fzHJNUzXNWYUsUlZqlswoZxNRNXrYisYWX6w0pPAVY=;
 b=NKwd/LFeOpP6ssMRinBCo1oTI+txzcOYzWgD0Zq6Qo+hGIQ/svCjVNWmUkXQI/dlMZ+0AK1tsPtaUqmYlUiTtRwkGDUzS2Sh3B14yCb3hW5vpx+qx4wEPrEjnNCQtTWzW3zJHAcZCpmENwojXoI+ve2fNXA+V6Lz3FujKzAfCwv24LPgHR+xxz7zUzrsNCy3eJ/o9hnu4pohjfhPlKUT2NbpyTW3JlnrUYV7JagoTBs8fU/6ZH+lhrwPbosDicZc76J/O2M1lIR4+teBdKz8cEfBaA3vp5TdI7itP1cjWf/mbnlmprauqTFiwFV8t142MZ3jIZAZb9UE2NfCn3mXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fzHJNUzXNWYUsUlZqlswoZxNRNXrYisYWX6w0pPAVY=;
 b=Ig5UXA8ua5c2Xr1ESznZsYo7HmVqkgVTtYrhGViRP+iP+xYVBfBo7Q8yROxoAeQZGW4c1GRL4G8wpm4Fs+keF9+5n0JZTeM6ZmNF4iFNEwLfKSsS04Xwq8bpdk0lrGg17jCzgDRP37rWkVB0daHGgeFRwMSF+qALIgxnFOJKP9w=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 05:53:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 05:53:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Restrict PSP OS version read to PF
Thread-Topic: [PATCH] drm/amdgpu: Restrict PSP OS version read to PF
Thread-Index: AQHZ/NA32DMgWrz6XUCgvQJ7UsJ5XrBFpz2g
Date: Thu, 12 Oct 2023 05:53:54 +0000
Message-ID: <BN9PR12MB52575131A125A030949AD645FCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231012055124.112725-1-lijo.lazar@amd.com>
In-Reply-To: <20231012055124.112725-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=92a490b3-27d2-4c3d-82e9-c5198ebb2140;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T05:53:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB6126:EE_
x-ms-office365-filtering-correlation-id: f9c8ba8a-b63a-4ff0-9e01-08dbcae79e97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O4jqMKMgld7osAAgS82sLrX/uRVH+dz9fHgDWSpJ01qFLs6vVR55+F5RYPz2UJrZ/8WiRxG51OxzqrJlZPLIqiSKGvJuXpFGsP1G91kBrVl8rvj1eVricCq1a2sEuGU7OokiwX1MJ/oN4HqM2l3Cg+r8Q7IIAwqYPylJNjsDQXOUP4hvJK6zxSCwwiuUk99qPW6/Twjhvq/d+ds1TVt4+sxi59nkUYH/Sa21sPdhXlpDHeZtJ6S1Sez17lS04GerIgGJUKWBfCYOrpNtKcZk9KKyI26X7+i8NGoWIfVFixKdnQYuswTFUoUgRyG9qbQ3OTKDu0ZTJI2VNSs6Wg9etaKfcEBCS4SSjwdU6ffMCIaSt59RA0GJ1h+/kB+NCobThlzY8WLYJCILUVAkUhEREtpIA3y8Mq4xTsUhMBz70bPa2YhQVIMJiMmkC8p+REuIZtrEmcIPfnqR3QmhxPloJGShVpWy+KkkL9zdFTXh1srMEN6y3RM3gUbO89TywhzVG6ihz0kfSdW7EUaVwv/Qq3NgLAn/btIlkw+mXSCzYJTQaYGO5kJq4Q/qhCHq22p8s4TLMriMHi2tz0MfUwdNLMtvCQ7AYpTtibv1lV9FcYCm66XL+U8UQWSdzgqGXjOV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(33656002)(86362001)(9686003)(53546011)(7696005)(6506007)(71200400001)(76116006)(66946007)(64756008)(66556008)(66476007)(316002)(66446008)(83380400001)(110136005)(41300700001)(5660300002)(52536014)(478600001)(4326008)(8676002)(4744005)(2906002)(8936002)(26005)(122000001)(55016003)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VLbFgmU86WvWR1rFOZypqZtyVpugQuoGBOIWThrIUgL06RczYM9S/bZTYKuy?=
 =?us-ascii?Q?lcsBao/yPifiM7QQ2ovaqRi9hqC7p+TnVMg1auxLUvgM830BpxaKbMaPCoWZ?=
 =?us-ascii?Q?1XIJuIpgFBOvw1HXLpmblwzG6iLvPftzUGWCgLyHXbzWPCI4/gtCwTZV8hUc?=
 =?us-ascii?Q?OdYOnlHjZvbhhu6bEqfWHIfF+jWhO9B3by1VW6YhsT43la7/C2WEhnCabqC5?=
 =?us-ascii?Q?4RtZHP44q6s3uvm+8K/HPDVbMT1fpM7BoYepzTA0drSTYNHIlH+Cg8i+zmGb?=
 =?us-ascii?Q?asmV9sm7Wuas9Ktb1ItE78HjsTerzfVu2/SEv0kJejzEvtqafZJa7R4tvgFh?=
 =?us-ascii?Q?0MWcQQjmRmE5G3nGukqlTABZg1PMN5e7sBW1achqIg86T6N1/ZiWjDNq5vj6?=
 =?us-ascii?Q?wkL9M14tKYhu2qn0YOCyatVHz0uLoyeXDMYke5xHQiNmzN2hUXtGQv9SE28H?=
 =?us-ascii?Q?x1gwaoueKvtJPsAA0OgxrahcG9tK86VwGsg7glaee0RBL//4ncTG01FJbEp4?=
 =?us-ascii?Q?LvnRhxDnGlheRl39Bf3BI50H1l3mnjpGszABU1IIxYG+g7J+1DKqoUnjbErE?=
 =?us-ascii?Q?hLxVwitzXCe/07F34rNQr1xAyIorQVWODxJTQ3kAJhWkbaOTY83HGSD8l5LJ?=
 =?us-ascii?Q?dUulZThnBmum9JXra7UpwAgGNBac+41GSOrPAz2eAV6b6jf7XhTkC1g0XMLG?=
 =?us-ascii?Q?86yUWpHAAdzlmlT9r4QakSoisqNy596+jwMoclT7GLYeM+UtIEnKPRasqUXa?=
 =?us-ascii?Q?rdVNAky16oy7q8JcJZrNdxFvURSNlD3ClJFUK4NYAcKsWlOovs3trbDc8HnJ?=
 =?us-ascii?Q?bbzM7MMEmeDAkhgriXA4JnNZ3WRhgWI/I35P0Joide9JdJ4VRs6nN8fTg5T2?=
 =?us-ascii?Q?Tyeo8Byjto6j6okKQNJ29oA+XBx7zcwLrsrRSOOIbqXSI+PZ45ZtMrN1FNle?=
 =?us-ascii?Q?ABlAkWjZlsb1lV1wt9NkBqvKeR6FPzemHq3yR12SziDlhrEvcrsjtX9I5KP6?=
 =?us-ascii?Q?WscGng+qRgusueq4J9MsOcHDbzXego9xx/KWPd7huodMwE09yqMs0wxjJDPl?=
 =?us-ascii?Q?7NA5uHtwZshzOkouqc2+G0eq36urNKF0ptOpw12BwQRtWlrIKQHoyoT64zYB?=
 =?us-ascii?Q?oYqhMM0MQT3rtNieZzjR6D3/MfSrj++CJ6XNvAdI9m0vHdqsPkUKBZAB8JcI?=
 =?us-ascii?Q?QlVbM2EMruBjBSy4sk3DbGdzALxwDVOzkKvwr9Jx6Tbyc6A09Z/j4vX4oph5?=
 =?us-ascii?Q?g6sXb854/YdZO0TgtOEiRL9PBIv/XLyv+C37b6ph/oA0Ke35Fryo0j1Yx8C6?=
 =?us-ascii?Q?DpZkcbXv7qsGQpDFX1TlYSbcD6/BE1EBkvltCcN9SacRBV5RTjxMe62TItE3?=
 =?us-ascii?Q?LD/+eFvkx28cMQW6uYIw9WhSCeH2lu9a0FUalaY2IpHNoTyb0PUpWEdEOQnQ?=
 =?us-ascii?Q?f6suikRmJfpv/W+sbtglu4bDJ4ujjTXHeLNJ1BvFsI+fFqNmSG7o/PoWg9xT?=
 =?us-ascii?Q?RA1NV8DCqrcS4N3RnoIOefyoRuBUakv+7jNtS5A35T33T+KK8t8uJqFOyKhj?=
 =?us-ascii?Q?ewXU+Y8PUVxF1qzwgCMwV0gl0AtE7tiNSvr5b1N0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c8ba8a-b63a-4ff0-9e01-08dbcae79e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 05:53:54.9897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGUh2bK6277VDFM+qTACXxLuYVsbwyhhWJjrT0Rzk6+5QoFfQ5A2ECpNOUHD/uFmlKQ+8l+itsVXmUhrED4t2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, October 12, 2023 13:51
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Restrict PSP OS version read to PF

Only physical function can read PSP OS version register on PSP v13.x SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 1997260a8156..96ea64e1bf37 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -280,6 +280,9 @@ static inline void psp_v13_0_init_sos_version(struct ps=
p_context *psp)  {
        struct amdgpu_device *adev =3D psp->adev;

+       if (amdgpu_sriov_vf(adev))
+               return;
+
        psp->sos.fw_version =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_58);=
  }

--
2.25.1

