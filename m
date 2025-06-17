Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5326EC71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 06:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AB710E108;
	Tue, 17 Jun 2025 06:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hoQW7iud";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC17410E108
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 06:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d66KSFZX+EceD+/ZFfwdCylk6ijjvmttj3mceGFxWQvAIAFE8b90xF7G4yep514WPBRpPnu0iTveen0tssi5pPfeLXqRGEPiiZ0PvLligeFloC2yOg2ulBndH4fAfDHPi5GsH0CsjTF2+2vzXNWDKd7zu+UmqxavVl5yIT4/RqgLhfoxHYOYrhmDKmdFBs3mpc1bgWe4gt2G3R5V56qRF0Db9pbeSYOsmkRNWxeKsR9zxH9dqDOxQPBRWS5F9I4e9p5zCTuhTnMHuEJI4YXmBqSYlfxioiPOwZRoK7uqO+Rmo/sHDtCOsw8H25xeZLanUtvQrtMj9WNzhdzYl6Wj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UITJm9ShMPfStl5nN9G7pLdewaqqP0uqyD0rPhgjDn4=;
 b=FOLe1bjq9PZM2qPbEHlw+yKJpetI/mCxuZeopXmSnZmIBs3Z7pAfTtKY0koNW+Tr84cbmXO8K8mFAiVghCqlMX+SzlLGKw+LDrjDUCHvAOYxOmSmVsAwm1oU2EArsK+UgvyNR9drCNp02RC60FuBkAgQe6/hdSiY0VWZGdzNEoPdtUO/4cboXE/mm0vOYfAGfFqCBUF68rYt1o2BUIEy+xBXSzEXy2TSetcIJFTifKAzhoLQ6zwvF9FBHf5xIxsU7duheyQ9X923be1/sjRhvyjjg0+AcailapfD2JjkMbJsUdjdGaRN7iist12M7BBD2EKy6aICuX17kDRRbZgiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UITJm9ShMPfStl5nN9G7pLdewaqqP0uqyD0rPhgjDn4=;
 b=hoQW7iudYZr/Bp2DkmOD56D+ErZ62acf3pMLxEg5LTZCyUYKgyka0HFSjCA20xsuSJKArMfrD4FjlNHuMXI69Uh2ilPQgNSNSQ1yAGOm818qXem3G6qsOPnmfSMc8Slv4Dd5+xcU77klKGtu8ouQbSXUw833NcRMXK6XzoO4ONw=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 06:09:24 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 06:09:24 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 06/36] drm/amdgpu/sdma5: init engine reset mutex
Thread-Topic: [PATCH 06/36] drm/amdgpu/sdma5: init engine reset mutex
Thread-Index: AQHb3zUo9q2EK1C1ZkO9DE77zqpT8rQG3kag
Date: Tue, 17 Jun 2025 06:09:24 +0000
Message-ID: <DM4PR12MB5152E23749FED429C03BEEC4E373A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-7-alexander.deucher@amd.com>
In-Reply-To: <20250617030815.5785-7-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-17T06:09:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV3PR12MB9167:EE_
x-ms-office365-filtering-correlation-id: f0887ad8-fcef-4e79-3b7a-08ddad658238
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eS1Ai2sRwaV6Wtqa0T33jyhPVRkbWaSRtpwcTy+Y4Go3P7ssvu2nXjuAnSYw?=
 =?us-ascii?Q?EvC0cIo2ILRIBAt6Gda3s6x1dkDi41gwetorDkUdY2DGxioVpyu06I4uUFGk?=
 =?us-ascii?Q?FZoeBdEaQN1MAAIm4Rcqr93a1zeKdB3swYHnAIobKs7YkBUsIp0+jJpX0Dw5?=
 =?us-ascii?Q?5t74SPU9q5uyIf9Zehrj5bw2LmWjcYQuHDIJTMDxzddJPo81PmoiO+kbW6sq?=
 =?us-ascii?Q?EdDRpGsioueJCCxE989amN1rcCPIhdeh/YyfTcjImd25jIdY+J6MnKHwy8Td?=
 =?us-ascii?Q?p/Nt5txFNYSVwiaFkwziVW1Vq1KSSGHaCXCOgtlA+BvdivNpWSKbFsk5tanh?=
 =?us-ascii?Q?w5sSzgBQ+ZVhWosx3RBlcy6DD43pdeOzgcZ9j9pTiorX/RpzETZ4MTERQ9ET?=
 =?us-ascii?Q?/XNKmfH/6eeX9/Ip3dPiTCFGlISPtmS4Umr6piEy/zqMVu6qxNBzN9I7OuPS?=
 =?us-ascii?Q?mBXbVH+jo2h/FWgFMzDaIr/oC543o3m9+Hau0+5lDCFxYMseBfUn6oWf+gAW?=
 =?us-ascii?Q?OeRGUoZJeU3Ev9XiS71zK7K6ydeyFkfX0I7UtQfQdv9z6gqU670T9YgmCdNY?=
 =?us-ascii?Q?ONJvIdw3dAlkW+ouaiWSjSLbCv62ajtc5+jZp4YkcrgOwuRafSU4Es6reXzw?=
 =?us-ascii?Q?tWm7znbUihlDPbGjL6maVgrxwTK7CmH7q6YLNe84Qk+8MRHV0/1LHa9oNy4z?=
 =?us-ascii?Q?ZsWyBFqdNkOZAO3BDRFAlTTv0ehdP5ZjwhSBdOjdo+5DezgNfaLGnsUkxdHV?=
 =?us-ascii?Q?NZ33ccxTgKHSD3C8EqG6M/l0ukxi/7JX7sykKVBkkWJbyL+8azJ3UfJq6g1j?=
 =?us-ascii?Q?F44Jz92n/fiXbPjVkUaFW5/van+JBoH4HTu2eJbhpsSeD5rIMjJeZ8f3tJpq?=
 =?us-ascii?Q?man1tqJSKiiI2Pp9An6hUSGrlpkAI+eRZDWJYsynX8H5n3yfA1HGxwpOJQe+?=
 =?us-ascii?Q?Xd7nfjN/YnqfIN+ZKZld4bJ0VSkKxzI9XB1DzsN8x5zL+iJdyLhRh/RavJf8?=
 =?us-ascii?Q?hu7PgQahOggwE+PIR+y/1OO9MsAdAuvrTzbKckbeAV8g4Wky5h2lyvngWOQn?=
 =?us-ascii?Q?alRvLPO2X2TCgYH1+ql1N2wT5Y6D/HgxetGkjm1BccJaMz3IWz/6151VCIgi?=
 =?us-ascii?Q?g3H/+jfhgEvL9JNcDrxxjuGjmZwQvrEOctHsKFYwe47oHbeEOLM+beZxiH4S?=
 =?us-ascii?Q?6nG5xI2tZlDoPv6B6J72lrdIt0spo7N/QWXRnHBO8uuxHxYHEztvRKyKrlxx?=
 =?us-ascii?Q?pkz+akq0YrpfixPbzuk0MCYmPZ0IKGnCtBiHuciUBePoWrfu4rofNG81tBDm?=
 =?us-ascii?Q?9dUblyO1gClSJraxFAw8Z6QAAhGSXPajmQTafhdap4MfZ70nQIPqENSTB8NO?=
 =?us-ascii?Q?irIpWVYOJqvtD8tQzTLA8Xqvn9vybdBsELGTuFE6GOZcCP0C+xESL9KT01iY?=
 =?us-ascii?Q?OZsckrh/+vPbYldLYqiZ8ADjYRcGOtsKe6Th+dKRBV6IYzxHPt7/w4dN4tWF?=
 =?us-ascii?Q?vLvmO0su4JKoD04=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ueb4/p2mB7Bfwhq1RLexAxNqgay1gTDKgAJVyYp3SgJRwJ2oN2tF/BZ/xPji?=
 =?us-ascii?Q?jdc32rQ8VQTRuhpLbQFrnlf2YD9g/NM4EdChZJdyKqeTct+vU7GTUkNeJ5Q6?=
 =?us-ascii?Q?yS6XD5GWIRxyqSmJx+QmoaZyNFKmOOEiluCWdD+n00iK8Edd0EO7OE8tYKp2?=
 =?us-ascii?Q?VdUcs2niuv+l0P0a9IpAuZ59/uwkW3t9zH6ZnBsDYDJnacVHkxNeMXauGTfQ?=
 =?us-ascii?Q?ZCeBLRmHpDvVPIQy3ibQMG7TNK+ijecSla4Kx4Dt7W8hWkWUVxSt9viYtuJ8?=
 =?us-ascii?Q?TfnClTxHpi9kZugLEl2aYKPiyQ9a2pmCJ/3qswSc/jAM5ETOBnxkt9l7o798?=
 =?us-ascii?Q?MeNWUS0AwNRxfvXdkoZ0xxpiqfbMMg89ylNkCPoYgnJs8seHvvX0+Ctp3tiv?=
 =?us-ascii?Q?DT3JrahjyR/a4XxB/Le8r6rf2rxAiDRAg88SIj/NMJiMV0T4q1M8oWwsF1+h?=
 =?us-ascii?Q?0gpAqms5aw9IVo2QQFCq2SBMmPw6P6zvhL3LMG6D4HQ3cGdz0IUe8y0TPLCl?=
 =?us-ascii?Q?0K0EWP7uqpxgP3tPvGglPLJwHUCV2a1TlBF88VRqMnPnhifbFCdOowONIbAP?=
 =?us-ascii?Q?mMC7Pk3lDIP+bXAiXnvzDQY1jTJhG/vONO+CV7L5Nd5V+asHfhu9d+WmX5Xq?=
 =?us-ascii?Q?I9fiVIHCXltq9s6asA5/ywvSGgFWe4jxkAHfI4fAm2lb9FdnZ+wLGccZbLd5?=
 =?us-ascii?Q?DpxYD5ebbrefmWgk4cenrAhHDdMzOedd6c4KmOqHE1Mo7iqooxHK4XMTD16t?=
 =?us-ascii?Q?wxAcZ+MHPGVWisM7ANbk5dOCQ55TZ/nU2g/zwRVaIgR5ctSWceTpAtzbraVV?=
 =?us-ascii?Q?LiltlJ7qC3rTtDECsY+IwrWaIzE0y7VstfCataR9Idd7Kzl/SoLao1Df1KpA?=
 =?us-ascii?Q?aG8CtoroXh1v2qkOfndOqeBOjK+U7BZmNEdpr3JeO7t0a0siPBKp8ooLBgrF?=
 =?us-ascii?Q?yYZBAIRRKR0bKqV6PCu+03J7nPJ/6dRVXK78nrZFBS4xCE/nTPEK/j1jEagh?=
 =?us-ascii?Q?qkjTpZQsZTiTrX8F84GSsEWsipoyNNUlNrZF1dfLhYOwAYqecHmigXcpVHzL?=
 =?us-ascii?Q?Qi925uQSlOiJ6yh/bgHN+97lPmMN/II3e76QcoDlQwQSrztVm2vJGtfoX8hw?=
 =?us-ascii?Q?Hov3deffOKOclSUBSABSQiEoSRVXrMPIBap7ddIvcZh+w9KM7QmjIC/Ngvg0?=
 =?us-ascii?Q?Ssuq5Z9dnVlUtyZTt8gOlz/8mu/SNirGsj9C3/rs+RSEWtFzsVF7+sPLQI4o?=
 =?us-ascii?Q?HBbEqNuJ5QcN3vRhFRfv/xEMFnL9TZaOBvkdNn96/5V4TgwasWp5Yk9obDlx?=
 =?us-ascii?Q?agE9nxtCwL64b1DiQLrO/S1w+TxI0ZDanWIMSAmaoT4Ya4Mud+90oJqYbnCL?=
 =?us-ascii?Q?lG5dWXdhrTqrdrh07lr8AwRRzTS7p40Ypv3QUxhFIgDffkaZ7b6/dVPThUXd?=
 =?us-ascii?Q?0etbWZyHX56UYuKF6mbxsPCCza8MP+TI3PYkE0RBaX3gjTH6gJuKmBxllwdq?=
 =?us-ascii?Q?U8+1JHM0yi3XaA19WxTflG6mhgFJnep9UzmkeywdkCoM13Y/SOte628OggSo?=
 =?us-ascii?Q?/E8hK8gJtzT4k0d7V8Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0887ad8-fcef-4e79-3b7a-08ddad658238
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 06:09:24.4084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d58PLnll69i+n59qgLaRo5UxvGavyRcpn77LDOlkDNzZwo6mKc3UigM5itpUXW1+OJY3HV5uWVBbSssDSG+Tpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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

This patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, June 17, 2025 11:08 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 06/36] drm/amdgpu/sdma5: init engine reset mutex

Missing the mutex init.

Fixes: e56d4bf57fab ("drm/amdgpu/: drm/amdgpu: Register the new sdma functi=
on pointers for sdma_v5_0")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 2d94aadc31149..37f4b5b4a098f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1399,6 +1399,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *=
ip_block)
                return r;

        for (i =3D 0; i < adev->sdma.num_instances; i++) {
+               mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
                adev->sdma.instance[i].funcs =3D &sdma_v5_0_sdma_funcs;
                ring =3D &adev->sdma.instance[i].ring;
                ring->ring_obj =3D NULL;
--
2.49.0

