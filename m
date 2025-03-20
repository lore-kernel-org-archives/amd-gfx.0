Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE54C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 15:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D9210E64C;
	Thu, 20 Mar 2025 15:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="blpJ/khl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2275A10E64C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 15:11:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeJX0yrv114ruBrlb2yM3Qex0nLeetsDWMWIjllaDKcOc3BR73MtacpwTaPFKz8F29NpiTQ1ADGI6i0KF52Uz45PLZea4wCCLb2VvgjfPGD4qitm5EixVriByvLHdJkrcq6zBD/5j2zmecd2OIXQtUdxdYB7fQtnKTY4UJXUjlo2lz1UnyhpO/FvB+H9gsL2Y2Ccsuu1peT9wcO/uQv19MzvOpNCKo2GJqGK82/9Pjyham7Qzcf0Q/iS86IIJ5muBYlM3X26y98S8gesn6oUEyn4ku0Xm/wBSS0asaRZUfUEf0kxb2rxesKJQ7H0a0jZHuu/+uc1SzoFUS8KELOf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e0qwGvuVXMCDqr06uFxpTpPwGhw8ogUVTsflegZLDY=;
 b=xtq5C3CRbL5LuY07xHVwvC2OKOiWW1x7ea8Hv3mBWtRPOHcAJ5odPlDJ7F0xrWgXkj8OG3is/tsZ08JpCBZMjNAU2stoING6rT66yNuWqUOOS22xzPJaCPSRrAfQADG+PQTfraAMfe8iuwDJgqzNUASUVm5HUy1aFT6GeYGUIvnlaUBCAMwuR+274atMuQwVQwoNwvJW6OGYswBRo6NfT6+nj4z/WFOnk0SjACdmlIaxkC1N3YqFHklI5g1gpHlgyXC+7c39LJO2b3vQPxB5klN+7rz6S9FA/YcdL3QGM1S1q/IfFUVTgI6YEUM431KeqZ8V5Xii8yrJxcvZ06PHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e0qwGvuVXMCDqr06uFxpTpPwGhw8ogUVTsflegZLDY=;
 b=blpJ/khltckJGT3o00wdWQgMkE1H+5rYR9ihnY28nl/Ssz2KDfysdze6sebFyDWurVS/8rLdpx8X6kTvSGJdNKGBHUZPz8hSEatU4UAHJHQ7XEBnZ06oymEjboNI8vNTwIRbpOTkHoMML2u2cB07o1qoEg2W7SUaX6Wl8mjOJLo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 15:11:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:11:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Thread-Topic: [PATCH v2] drm/amdgpu: Decode deferred error type in gfx aca
 bank parser
Thread-Index: AQHbmXvurWWmW0x6ykm3pEHAWPSk+LN8IYUQ
Date: Thu, 20 Mar 2025 15:11:02 +0000
Message-ID: <BN9PR12MB52572A260FEA71061A95A8EDFCD82@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250320093845.587026-1-xiang.liu@amd.com>
In-Reply-To: <20250320093845.587026-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fb6e0007-6277-4c73-be8c-7eed652fac92;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T15:10:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA3PR12MB7924:EE_
x-ms-office365-filtering-correlation-id: dc86f792-ea85-47b9-febe-08dd67c16d8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sif/7IwlGcJKOD68jIIwbzDpjO7HnFVOTLrdVygBFe9YrZ87u/n5bS2SYAN9?=
 =?us-ascii?Q?5OuZ8DxWs3nOpDvqpUiSkMf4ZzIhMMc/GxuoZEzdCzJwU10NU/YEsWeMQBmu?=
 =?us-ascii?Q?MAUajIOEOA3KRQbSPgZJheHMcJx6PpF3Ia4ZgehrhmzH8yYPkfcItOGTxfCk?=
 =?us-ascii?Q?1DYGURuKqalgTxyYYgLeq6EjYK02SJU4uqffZgnxgVCtNGluyWjDCAASCM+N?=
 =?us-ascii?Q?XNUN2DVsIUm+KSBxStWIJOddybKYH627Ef3PHB73yiIfnZ9j/JWxH/OIb0AY?=
 =?us-ascii?Q?UtxlVocvaIB4sOaoTNn4VLFQt6zlpzrQFMiuuzu+vZJR7azt9pt96TPFFbez?=
 =?us-ascii?Q?rLg/dnVzVFFzkk03HqTR1xXUHdx0h9FNsH+VoF186Z2XGBwaJ51cCqf49mJj?=
 =?us-ascii?Q?Kzb7XHDEvp66Kh3G8qmYUjJiZziGsVPv8YihFO3tvTINXPCt+bDfn5NuNad9?=
 =?us-ascii?Q?d4+jDhxSbtZ2Ede+rI4a+cmam2+jdk9AaOO9FL78iLeMwlR/64UfVRNFmtgZ?=
 =?us-ascii?Q?/VZYy0sJBtLp/FdREbDC9VSjy+NKLAZcZ63JFD1tunOwi//0QPmeA8hGAKUX?=
 =?us-ascii?Q?NweRM/p2hedp8xCQo6o0hCpac+blzONINc7UdO2fa09Aaotm9J7BGaZCqSjs?=
 =?us-ascii?Q?mxmIlVhFvkswAPatnGj2/nXNYODYp1FhbYuyiYspkelm1KK/7Ox/TAE+nMv+?=
 =?us-ascii?Q?y5sF+qHTs0I0agEBJ9KJ+LDNfdWPgjRo7duG/eQSrlHYnH0SQW6YK5voQ67g?=
 =?us-ascii?Q?WkQcZyQT5TKQupA5jVb8RsUYXrjwonPfCpvbMnS0FbQzqrtANwxvmCVwvdqn?=
 =?us-ascii?Q?G9/9UHI3/05u2L6WVbjjFwNbcAXwWCoaL24nCDby/nHebA/col+6WD3HH5gg?=
 =?us-ascii?Q?M9woMXMa2Uei7RZqMiQYXcjyU8FUNzvJTY20Fx7514dsfuEep4Mh07zyNBqt?=
 =?us-ascii?Q?LUCXigkw42Xxy2K2HFYFlpJU2I/6qqMlp31mNcgzNgI9TVH8LvOhvwVQsPqc?=
 =?us-ascii?Q?LM3kYqkaDxEGPcKcWwMGDVNjQK2Bb7ZHZlZRnMg7UPQUodHMD0pUymuF6+ev?=
 =?us-ascii?Q?4FM81fbsT2qi48yPl70LFVcp/CGojDenky+NuWlICYU33rPTwg+XQ7rRDFgm?=
 =?us-ascii?Q?RTqcqDVUnb/8QDPLaObX39AnWFl1whGddAxq+noBHSDuPBKiLYhBAGpRnHt4?=
 =?us-ascii?Q?t5jMNtpEBVDYEAgFEzmViqJLIwZJurObq536+w/ZTd707psVPTZFzqPK1eLE?=
 =?us-ascii?Q?8Wg7RUDXCIXhQLGqqkOBplPfyz5jrhXiPx2+EbjaotB9M7P+U45LhuKdGNXZ?=
 =?us-ascii?Q?cJHTol8VSuN8huYO3+VsnbLAu5MEP7ZxEma6urw7Kf2V4GSCtUhWuGW67atg?=
 =?us-ascii?Q?KCl2PIkYYWfwKlylLLEuyajMPDfCt4XCdoA69YydUjplTVtB+TVO1ZpoURgb?=
 =?us-ascii?Q?bgr6MoXoAK6YdIUsNno9tw5qWExv4rIA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6qGEYeUKRagUZ+b4xXxcl8fec36FVskMqbHKHGn/dJcmjIKFzepEguntigy?=
 =?us-ascii?Q?ACwmWY8UXKRtCcniUcJoQqiednYSkbWKKP8KhXmMMMJZeczgQk0HTxBR/26J?=
 =?us-ascii?Q?qs0oHGZo12VkHCbzVhKMLSdlerD7+vk9jmjpak9iGDeGTy2TYRzdigfccVcA?=
 =?us-ascii?Q?bLQb4d1Btotzg+hCJdXNIQWOh2erMFtJWea1KQNUtrgvPtGJoX7W1nRnwW5/?=
 =?us-ascii?Q?C7mriD/2nxqPeE7rfHIu/yTzllg53u6Pn4uvPYRMQ1s2OTIQzIR0y53e1eyL?=
 =?us-ascii?Q?SWsswVgDhoQSbt/wEtzKbzF427s8y9IMy6bbzWGge8gpAvqQ+7LQ1rdhl41q?=
 =?us-ascii?Q?k0kGFsbdla6oYIG1ttNCtedVIvxq5Q8qYKLeB0qRXHX4bMTEIH3g4we3+Eqg?=
 =?us-ascii?Q?ctEwv74Hdnx5fs45xIKHioFmBYnyNdFsxQySuOy+Jv3lvhDCptoQMmkn5Gw0?=
 =?us-ascii?Q?xbH7aewoWnuaR9rSnLjEKI/2UtMphwDCYGS0w/J+1bKyhVcH8Kur+QymuZoO?=
 =?us-ascii?Q?E3MkekmpWF2n7R8raHahdsNH2Oowfws4DI8qVxFNV0af0SQequ9sIzbbf6Um?=
 =?us-ascii?Q?rTPM/PzVnvTvhFGd3jSoMO3x9Y6JTbvBx6M+xk7Tpf5Plq3BHipoGtR9Q163?=
 =?us-ascii?Q?Uka1J+A2uWdktIFHTnD0C2IQHSN9WM8c45HpOxJqRv25tC6OtR96GpcLvhrh?=
 =?us-ascii?Q?GTedfKFQQFr5ggPg/oIOsJ08uCV3Ay1tBEnEFxI4zcxa45wAXH8QazK9IHjw?=
 =?us-ascii?Q?CZdi7h0dkLRI0lV6Z5CxzrrneYD67zo5U8BNjjDbYuTVWCWD5IZGwSODqcNj?=
 =?us-ascii?Q?ytvEUrtoLUbKSXufiZvbQy46syg12GsJ2yp21O4QZqgz2EiKZFvXl8mdx1xh?=
 =?us-ascii?Q?uyjcGE/jiO83znx8M4mq8CWlLCS3bHWSJOLwvbBNPbbrTUo8UCfFACZfQNT9?=
 =?us-ascii?Q?zjL4xazB/lif6Rk0MsI4T9pOxa2KS7iFDQ+TuTxq9PExP3/0GlsddEc8qku4?=
 =?us-ascii?Q?RHUy5m2W8HRWlNzHcRwhIy9pPPfw3PaV06GRHjToGsFt4ZYqSJu+H/Npl63Y?=
 =?us-ascii?Q?A76Qhdi4OWaUi+0qiuncqhP1LQrPFw/O113MnfXt8eNaYuVPEvTc6eS60oCG?=
 =?us-ascii?Q?NFDUC4TCZBbANBu06wbxGTA1AmxN+y0uh0HgigIAEkD5Y45EU/07wQcoK6QP?=
 =?us-ascii?Q?Oazj5fo/dz8slSzp+tLMx4RENmlk2FKdqDS4BJXVpSd43S077Wj4M9frqPv/?=
 =?us-ascii?Q?E4J47OzwhgXd9wobhMOo1kTPjFgmJIojm7xmoMAE5AbIGp/zkd1Z8dN8H01M?=
 =?us-ascii?Q?DQSFLfiwEphMO9xUnXlvjLv9hx1zlopa+Vu8A+E4S1ROzzagsSg6ymTqckDZ?=
 =?us-ascii?Q?7HZ5SVStKzZx0iZw8o2o6pZGQrQLkSwA9cG76Nb6/dSOwN5662wCU0XvYY6w?=
 =?us-ascii?Q?XqfvV/3F0VuFBXyx2NK3dQbIDz0H1DIw632MycDClB8LVbOUfbtExjiD/Q5J?=
 =?us-ascii?Q?v1Y/GqKNWPdYz2hcNl2Llx1KpJ7P6f79j0i4jbr4gOS6XGraol4yIzfFe4UP?=
 =?us-ascii?Q?Kf71fHhY9uTgunQtFJ0VInku3Q0oQ+wE1JubLRS1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc86f792-ea85-47b9-febe-08dd67c16d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 15:11:02.0468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7J1tWQxe6HfAQR4TG8C1pK4dwMdIWJgY/LEetBT6nhJ3j4V/A2HQluK815HU0NGkyQXFSB0fBh5V8fNwESBBTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Thursday, March 20, 2025 17:39
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.=
com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Decode deferred error type in gfx aca bank =
parser

In the case of injecting uncorrected error with background workload, the de=
ferred error among uncorrected errors need to be specified by checking the =
deferred and poison bits of status register.

v2: refine checking for deferred error
v2: log possiable DEs among CEs
v2: generate CPER records for DEs among UEs

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 25 +++++++++++++++++++++++--  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_aca.h | 16 +++++++++++-----  drivers/gpu/dr=
m/amd/amdgpu/gfx_v9_4_3.c |  8 ++++----
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index ffd4c64e123c..dc47f5fd4ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -391,6 +391,7 @@ static void aca_banks_generate_cper(struct amdgpu_devic=
e *adev,  {
        struct aca_bank_node *node;
        struct aca_bank *bank;
+       int r;

        if (!adev->cper.enabled)
                return;
@@ -402,11 +403,27 @@ static void aca_banks_generate_cper(struct amdgpu_dev=
ice *adev,

        /* UEs must be encoded into separate CPER entries */
        if (type =3D=3D ACA_SMU_TYPE_UE) {
+               struct aca_banks de_banks;
+
+               aca_banks_init(&de_banks);
                list_for_each_entry(node, &banks->list, node) {
                        bank =3D &node->bank;
-                       if (amdgpu_cper_generate_ue_record(adev, bank))
-                               dev_warn(adev->dev, "fail to generate ue cp=
er records\n");
+                       if (bank->aca_err_type =3D=3D ACA_ERROR_TYPE_DEFERR=
ED) {
+                               r =3D aca_banks_add_bank(&de_banks, bank);
+                               if (r)
+                                       dev_warn(adev->dev, "fail to add de=
 banks, ret =3D %d\n", r);
+                       } else {
+                               if (amdgpu_cper_generate_ue_record(adev, ba=
nk))
+                                       dev_warn(adev->dev, "fail to genera=
te ue cper records\n");
+                       }
+               }
+
+               if (!list_empty(&de_banks.list)) {
+                       if (amdgpu_cper_generate_ce_records(adev, &de_banks=
, de_banks.nr_banks))
+                               dev_warn(adev->dev, "fail to generate de cp=
er records\n");
                }
+
+               aca_banks_release(&de_banks);
        } else {
                /*
                 * SMU_TYPE_CE banks are combined into 1 CPER entries, @@ -=
541,6 +558,10 @@ static int __aca_get_error_data(struct amdgpu_device *adev=
, struct aca_handle *h
        if (ret)
                return ret;

+       /* DEs may contain in CEs or UEs */
+       if (type !=3D ACA_ERROR_TYPE_DEFERRED)
+               aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data=
);
+
        return aca_log_aca_error(handle, type, err_data);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.h
index 6f62e5d80ed6..6b180f1b33fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -76,11 +76,17 @@ struct ras_query_context;
 #define mmSMNAID_XCD1_MCA_SMU          0x38430400      /* SMN AID XCD1 */
 #define mmSMNXCD_XCD0_MCA_SMU          0x40430400      /* SMN XCD XCD0 */

-#define ACA_BANK_ERR_CE_DE_DECODE(bank)                                  \
-       ((ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) ||   \
-         ACA_REG__STATUS__DEFERRED((bank)->regs[ACA_REG_IDX_STATUS])) ? \
-               ACA_ERROR_TYPE_DEFERRED :                                \
-               ACA_ERROR_TYPE_CE)
+#define ACA_BANK_ERR_IS_DEFFERED(bank)                                \
+       (ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) || \
+        ACA_REG__STATUS__DEFERRED((bank)->regs[ACA_REG_IDX_STATUS]))
+
+#define ACA_BANK_ERR_CE_DE_DECODE(bank)                             \
+       (ACA_BANK_ERR_IS_DEFFERED(bank) ? ACA_ERROR_TYPE_DEFERRED : \
+                                         ACA_ERROR_TYPE_CE)
+
+#define ACA_BANK_ERR_UE_DE_DECODE(bank)                             \
+       (ACA_BANK_ERR_IS_DEFFERED(bank) ? ACA_ERROR_TYPE_DEFERRED : \
+                                         ACA_ERROR_TYPE_UE)

 enum aca_reg_idx {
        ACA_REG_IDX_CTL                 =3D 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c0de682b7774..e62072779ae1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,7 +876,7 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle=
 *handle,
                                      void *data)
 {
        struct aca_bank_info info;
-       u64 misc0;
+       u64 misc0, status;
        u32 instlo;
        int ret;

@@ -890,12 +890,12 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,
        info.die_id =3D instlo =3D=3D mmSMNAID_XCD0_MCA_SMU ? 0 : 1;

        misc0 =3D bank->regs[ACA_REG_IDX_MISC0];
+       status =3D bank->regs[ACA_REG_IDX_STATUS];

        switch (type) {
        case ACA_SMU_TYPE_UE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_UE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    ACA_ERROR_TYPE_UE, 1UL=
L);
+               bank->aca_err_type =3D ACA_BANK_ERR_UE_DE_DECODE(bank);
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type, 1ULL);
                break;
        case ACA_SMU_TYPE_CE:
                bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
--
2.34.1

