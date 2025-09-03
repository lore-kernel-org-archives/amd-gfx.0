Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0981ECA100B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 07:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EADF10E1DD;
	Wed,  3 Sep 2025 07:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZVqRj3JZ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE2110E1DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 07:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylJBzaV4yt1Y+KVicilDf6hAZKQrk+BvRmpxrjjHK9koLF7eH0XjVLC5pg/R4aIWZWgGbPXBCJ0fLO7PToyK/r0GkThXs7ZIELXPUM15InsLue+JIDBZJ6L2ELXIq91dPUYwiTdW2nMJ+vd7q4Z07E/cDZ59a83Ncj3HYOHqdZWKMKiSjeXQpkgS+Wi5rJsQFgujRMp3faGAmSxqfeW14KbWLSgAOhQ1IY0XOjUUQHdzwnA8D9Y9TB81HQuhpZl+Q7k7hjqS625Y0bL7wpcHmWzUES9hwe3YRCOdPFgosHuwAOzHX6gY/PEbNNuXOdm6xZKRnSpLMtpZ4GPhsWV+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFnCmEn5cRHL4KRAGFVvoNdNGnV8vvL2h2XheQU1o5g=;
 b=baF/1NT4IPtNa4Y63WDfue0jTtMVsqnrr0mk1Pdo48w8vAUQr8RBz308nAjXfGvtcZx2ph3VFYKcYQsQv+tkFACzUOmFulxogVX79thbelCHZU1Z2PL8XP4yDxXivpJ0/5NhAFvE8thFKALMfDZyoQoa/GE1P6cwcTcslgSXGny1WxB2dQ2HmDzJne45cQ5f0hZkh/+zyM4E1xkBU3NN2jvfVlPm/S2Tnz1oIyrQ/w0FR7MZeKl08xIKpWK6Y5npZoBRcnIbmOl+3OTTnJrP1aoqGobWMtA1qwGUb9MLkyZ7i9PdGv9LtvBfCh3O32SzBhGklNgK4t/+3MEDmM5tGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFnCmEn5cRHL4KRAGFVvoNdNGnV8vvL2h2XheQU1o5g=;
 b=ZVqRj3JZarPYe8fzSS2pcMipS1DvdZouCOQ4kV8/6KwZN6STD29ye10p9iJ9rgoSjyK7rmhQDvkK9eDdrzR+gf7fScZqqf+qo/IPonDD0Pfj3beXIXpPwpnzu204cCoBscAjo1C9s1bsK0+EWh0Vf4BCqyPKDKG+WpbdVPyolR8=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 07:07:46 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:07:45 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: refine amdgpu pm sysfs node error code
Thread-Topic: [PATCH] drm/amd/pm: refine amdgpu pm sysfs node error code
Thread-Index: AQHcHJzynCtgCb3ijEyJCLjmT+M53bSBCWIg
Date: Wed, 3 Sep 2025 07:07:45 +0000
Message-ID: <DS0PR12MB780463AE30F8CBF2C1E65DCB9701A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250903063517.1352079-1-kevinyang.wang@amd.com>
In-Reply-To: <20250903063517.1352079-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-03T07:07:06.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH3PR12MB9732:EE_
x-ms-office365-filtering-correlation-id: ce195028-6c27-437e-005f-08ddeab8956c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mXmDfoYeVtSfaYjkChSof9P2Uyyc+8/F7tfk/8M4BxmJpIWKA/2TxkJqxLuk?=
 =?us-ascii?Q?lhloiPgyfMX6AG+D+FkX8ckKoEVhR+lni3aRgfy34H6SuUTLWJv/HOuc5PDV?=
 =?us-ascii?Q?Tm07vU06/BwLEv/drfVsDb4iv2saGgW1rSm/Za3Y6WMfN0VGaY3cISDof4vU?=
 =?us-ascii?Q?oFpc7VQGRY4ew+LHztNNgnFIjov/arAon97GtjkopQCkfF2NJ0sV7sQT0lrM?=
 =?us-ascii?Q?1buTIM2t+mfIU4+G0iWGTCYTj3xe13F7NDeeSUBbwS9l0g4ykgFWDsnyi/fk?=
 =?us-ascii?Q?zbds77i0unU0BUiLbi4vV/I4NcVlLwkj3nw9IukmDTLAd0hfADgj7dYO90TG?=
 =?us-ascii?Q?gstf4pqn5cQ/A9ihw6lfZ9foi8mrh6YKFxqicpnm0CevmaTi3cEU+cWBQp3+?=
 =?us-ascii?Q?bhYLWebxzjYXs5JhXlhDZbgfiB3uqk9VeAjdOuf4fa1a4QUtsldiPXE4RsAB?=
 =?us-ascii?Q?scBP4A+jIiT+huwYlQAjGysCXo3rsaATFYZKP5H4vgKCTeFjfatal6N+YDDo?=
 =?us-ascii?Q?R1mVanoYsKmewyPGKysiN80C9saWBxOkT5fEXqh+MLxyFbjOyhRDDHOFUu0c?=
 =?us-ascii?Q?SEu9N/hYk1gs0DWNWSeOAsIN+k8/odA5ZRgLcKcOlgPAK9zymkVioWdNdDzb?=
 =?us-ascii?Q?Yq6IdyKXAzrdRn7uNXhTCDDEKq3nmPUQhKLECRa9RHF2o3Bbv+aEUkQ0ntRd?=
 =?us-ascii?Q?cHHveKxDGDtwVVyPd8cDwaIe72cziHZaxHBtd/WoKkhjc1k146Q7I6Gmyz3P?=
 =?us-ascii?Q?oPkYBxI7kaAJW5m91MX5215yuBQF22sHuJisEBLoWJ4bmZGWDGcj6KrWNJ6T?=
 =?us-ascii?Q?on3eg/34pJx5w+QDf/8NkA7vIImANfJ3xBFMsAxUg36FiWhmOcS4DseuKbIY?=
 =?us-ascii?Q?05T8USIfmqUMuMHXJzN8mkGg/4mlPPc6qOPuuz699AH5wjyhXsmOoWKPh6gA?=
 =?us-ascii?Q?VCTsZJWUNIa2qUHRSQfVZm9Zv+Oxr1IIuDzYGR1YkEsPOalIsNyKu4cfrpO+?=
 =?us-ascii?Q?M4UmcRd/DNqLzdSksIHY9sWhK7QLSQ0vvrG71DT1Uyj0FHBAJnVOpb4Jt0RJ?=
 =?us-ascii?Q?JHi/IKSJNh/jwVO9lRQiFxFaZIHnRuCCS3r0yC4/0xmDwr0xraO7V/EOPo6H?=
 =?us-ascii?Q?eOdJ9qCOCcRykcb9KA1b3QIG20Rvp2TguGy4WWSn4UvbX9TpqX1UqiJy42Ry?=
 =?us-ascii?Q?cDN7ipNzIY38PDlGdM9U0S0B/u6KSJaj8MaoBIc+VRQbfpQW9dpjONSkb4we?=
 =?us-ascii?Q?F4t3TZf570DFfIjzLvCmaQXt9PXpDBWhWFMFYPP72+EdJ08OFPVFoiAyXolO?=
 =?us-ascii?Q?ibZ7eAnN1kQAv+xMu/lDJu6XNaNoxVazuvNRJBkGLxOqA8Z4gl0K7HEDa0Hh?=
 =?us-ascii?Q?yxeuWvp04rDj9D+30BjA0XIDUFQdsFjrQCyPwQVRDeQItdxHs3nO6Gw9kT0e?=
 =?us-ascii?Q?LyyePZIAzSFbz2gKF8LmsteLpsbOxxmIdH5cteP9BjOM7Y0OCzMIa1ZkZWou?=
 =?us-ascii?Q?ESg5y6zVGMo6AKk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I0CwMPZTbRqpYqV1bQ4ymeiugbq0FWp9t0S24J72Nj5QJCUYtmGPJywCmpgY?=
 =?us-ascii?Q?Hr+sh3r4Hi9GbCJEO55Dy+qJuW3muoa/qaWBgLPf0mQzUMDS/KdeEEln/sC1?=
 =?us-ascii?Q?X1sDsxC9AYjTX2TKcALLsSL7buh6z0ArXDUOKdtpSClaLD1raxjz83qT0RKe?=
 =?us-ascii?Q?e3nmLLoTnnKCk4DgiIyO7gVqcnL/Cvczno6ObhG8HsXdvC96aYaGyy8o5NLr?=
 =?us-ascii?Q?UzBqWV4TmNxIjVaN2vmcAdboc6SH44F1XiDw9RHvBmiuZiWJiFbsn+we9aN/?=
 =?us-ascii?Q?a4w8Uyx31MpHh709hfE3UqR665egFSEFlX6sN83Bu4WkvZN/s5uGk1q14Gzo?=
 =?us-ascii?Q?Ro9kinuMp5OP/yKJh6NpW+sIaT4HVlTMvoPRvhw+1lyciPHQfZZS9RKm9Pjc?=
 =?us-ascii?Q?8yetIw/n9eLeLgvocbGOhxbrmcKInMk16TrlT1N2UQLSlxDF1kHmH2P7pzA+?=
 =?us-ascii?Q?AHApFuMeanjcqpQ81St8RW5tPf9RYQnheI342umValje2NXHeO7bqZXkkyvx?=
 =?us-ascii?Q?2eJuznQB/M1IBtprAGmTri3ghFET1a7lo9Qz9t5opaZrpuu8MEmJX5cBTaRZ?=
 =?us-ascii?Q?R80ub+w39u69Iuk1LCJih3xWF29aSub3qxQZLYPDMSvc1uSIfpQ7tpDvNp8t?=
 =?us-ascii?Q?6eR626ZgP7K679aK4vPolMOx17M45pdTQzfkR/wJ5Z+3soZvxvOYpLe5E7Xi?=
 =?us-ascii?Q?WxrG++Lo/bk6tmfU6GDLew6dHdbfcp6xth1nSeseUHbD/CfKnFGwdqGXS95K?=
 =?us-ascii?Q?4/xv/0QhxpVOneCJClBKWv0KoyFbJOOhkKiwBspHW4B5WGNc0/59GzBC8Gqj?=
 =?us-ascii?Q?x/ZqOnCGn/M6ditLTlNs+Q1pDnlryc3YQSAS00q11H1FRBKQRXFPw0o/EzrF?=
 =?us-ascii?Q?5ykv0aDA2oXfqnVQ35vWLN8e4W9/dsCEJdYPG7La2zZ46CSf1VkSzJ8wAmv7?=
 =?us-ascii?Q?VtJplf6gVj79J0D6h6IKMCBhYvS2pvUhO5Cl1jzq45RtAyUmULYqJsxHcCo9?=
 =?us-ascii?Q?Y7Oj0lNoww2w6rkiiBudSg7maqcPiWkDtjkX8BTMLWowjHnY/3xKDZS98eEH?=
 =?us-ascii?Q?TM9P7VRx/wdGPLfC8Jb0kyNAF4e7fFXlizUBmzmWxzWxMuIAf47PBBhupNb2?=
 =?us-ascii?Q?VI//KOptGPYrIooJFiL5L6ecVZSg8pvzWRRl81dKj5QzzU4EbcbU5d38xDCu?=
 =?us-ascii?Q?EnFEdk+BF6Vi1jM0xH4jwFzNGL7w50ikw2QpT3rcKPMWYwYYepUhRml3h6HX?=
 =?us-ascii?Q?5QmuDmcTKuHnHhUwKNzabWVAyyGU/w/AflmEffR3ZTKVbVObxJpJoxUNz4Yp?=
 =?us-ascii?Q?jGdKZdQ5K0vDbrp9tblmuWwy3ZdJ0qYy+pXpS/iCtqxoZcbPjlMPqQOBEJ4T?=
 =?us-ascii?Q?Kyb2Hp/2w/H+V4px4/vbTKuokb4nj/2EkYQkf4IiWqQpRARa0K/YwVWTagYj?=
 =?us-ascii?Q?XvRryCFVnQMbbhFx36jEtUXKyo0S+mS8qzs55ZVQfCzWckwn7FLa+KQfI+Cy?=
 =?us-ascii?Q?p6RYUILnC6RzSKmkwl/9qreqjQJNsIKDJtknB7isVv2PgCrqddEPWBspiIYC?=
 =?us-ascii?Q?6pa6I3PFGmhJ52oKSvk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce195028-6c27-437e-005f-08ddeab8956c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 07:07:45.7738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPQ2jCaONJEMc3Jp2igEfgMWeu/xtoqB/UzLUOPssza/mIhmyQ/rtA2Kbetvh/3s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9732
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

[Public]

I don't think it requires two separate error codes. The error scenario is d=
evice cannot be accessed at this point of time (that's regardless of suspen=
d or while device is undergoing reset).

Thanks,
Lijo
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, September 3, 2025 12:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: refine amdgpu pm sysfs node error code

Returns different error codes based on the scenario to help the user app un=
derstand the AMDGPU device status when an exception occurs.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 0906bff864cb..6b1de23c26e3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -110,9 +110,10 @@ static int amdgpu_pm_dev_state_check(struct amdgpu_dev=
ice *adev, bool runpm)
        bool runpm_check =3D runpm ? adev->in_runpm : false;

        if (amdgpu_in_reset(adev))
-               return -EPERM;
+               return -EBUSY;
+
        if (adev->in_suspend && !runpm_check)
-               return -EPERM;
+               return -ENODEV;

        return 0;
 }
--
2.34.1

