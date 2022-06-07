Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29763C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 14:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A164910E5A9;
	Tue,  7 Jun 2022 14:59:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFED510E5A9
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 14:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FelGg8+y78mWsNNFD1qw8b/lXEIDp0UuPLiiPkjrtM9sL4G+wDhdkJEy84QEAqVe2JCcR9jC/2nEBi6xBd9xQPTyisqWm12ClXqByjfI4NdCSjlV1Wmv+Nm3QxtR4DNDe1ZmJVGFjamDM28u8MyL5ugE650Hi/zmmLyfh6xLJViphE8glwbUKrHeyGGZiY2vG6Ng2CIs241+sRR2uxB6sEaL7PE11XPclMgG4h6k0v3mT9uSmiHfFNH1e2LpXEriICZWwpevuFcGaFcbarZMY/ZRfTUOk6MmbhzwBtBmTqUI06vTSnwIg1sCH305rnbxJAyXWc7VL+kxCqETZr6g3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYszeAWOJDfPJMs0/FWGTuYG/gdOdAxeII3DzifIc8E=;
 b=fYiPZLpsgSA/+9OWnt4EEPoBqY2E1XWhojBJ11awI9vqKN5qK455Ut/GsmCmMNJ/+rEc/7asOSirjaX8zcCv8XCanjxtaxymrTC9M1ON58otIGVpOcYW4NMitGHhfnaUvLs3ec58trxax5kKcL3vxDWLi4t3Zj+jT+logS8ssoYFAgV2qf5/AyLvlou1uM/EqDLEXOUccQ9K2t2E1ETCQSSnofV7n0IUghMzqsK3+pyfJu+AjEH+FXrJbKLprqvlbipgHtpC8GTJh+ExasQmgi1GZNRgOm0S4gOBo1ph7PUhfTnF1Bi3Fne6DJwZuyHIfb2tiwnIFYoXiJQdIS4pYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYszeAWOJDfPJMs0/FWGTuYG/gdOdAxeII3DzifIc8E=;
 b=AuinTpDXkDMKlTPc6eYb1s1XOfcWwZFjTQhR48FC94oTDD5GPtzmtzNq/MQPF+5d/8yRwIJRpxXKxoLED+Ejq4jsNxl8IiyS9yGcutbUQo6OeikNF61cpkAGvHt5D6zUx5W1EIZAgUWfSaJ/ZQYJE+JRtdVg1Gk/tzPL60KQB3g=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 14:59:28 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 14:59:27 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish
 loading both pipe MES FWs.
Thread-Topic: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish
 loading both pipe MES FWs.
Thread-Index: AQHYeZIHa2viF0YrWE+h3BMoDZQIPa1EBGOggAAGuUA=
Date: Tue, 7 Jun 2022 14:59:27 +0000
Message-ID: <BY5PR12MB3873F58FD4E7BD58E6F07C88F6A59@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220606104007.3801900-1-yifan1.zhang@amd.com>
 <CY5PR12MB6369D69C432A2052DF49B587C1A59@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369D69C432A2052DF49B587C1A59@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-07T14:35:15Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9bc84cba-3eee-4862-a1a0-8c29d3f8ba39;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baa54276-c1ab-4fd3-6bb0-08da489651ab
x-ms-traffictypediagnostic: CY4PR12MB1432:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1432E7BC803F691BC32F5EA3F6A59@CY4PR12MB1432.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5hP+YKeYSg4MXthUMdU2Mktrfh71wnlGKKT5c8JQyRD2hLmS0Yw0aXOtYdXjENvT5Mq74OUYOeVu00RjygUyNlYZOGQyI2iE6133mO0SPDpzQy+3SaHYzc6iAxei+ja23G13Vd2GaHhPQuxhBCFrhlRYuFVT63/zQcNY5ytKziiR0qLpD7Psh6U0Z98lVAjPhlOW1RjiWJT+1ArkzfvaRdbXT24ReFm+YdjlEd54qc10gwKPe3SUfo4YFDPZMKgiBEp5+5SSZ6PG6C8KVtykApANP2bsbSRDqqvMGfpycJtQKFnAJtgxWEaSQ7Pzr2cRT9r4MbDJ1CIXb2ht7/GzVukHHvaob0fhTa5Fj6Ij1eB/9zdfKdJhp4+/AV0SqMYxNOyiPHE4LSObBX1SOILF3qnE3zeN6oO3VHOJDTNnwLVGjsDthzNfH+bsKKZNp22vxaynKahM2Zrs9ywTEHtmDKqLhdqDFa9KTsOps/K0yxVkN+NvH5yiG1Z7f1+9upfk3LgYRS8GcRQNkbfVgebQZTGo3u7rgZkOcYpvULf8hSDaJrwWhZiqw9HdbUir7ZjVgk4ZCJqLWw1nvjQ7atxJUZM7o0fSP1QeBJDBdqm/XEvSupzmufoZ7Ole0TKLDIvpa0HzjqS2pYHqoh0LTy7pTUXlIJlUM2ZABZthTlo8TSZsfybwDC2OcMFrWbNale8eMOTemP2aClyNczEVHL9jsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(55016003)(26005)(38100700002)(122000001)(33656002)(2906002)(9686003)(316002)(86362001)(83380400001)(53546011)(54906003)(38070700005)(7696005)(71200400001)(8676002)(64756008)(4326008)(66476007)(110136005)(66446008)(66946007)(76116006)(186003)(508600001)(66556008)(5660300002)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EZrIyTvWpA1ega9x3Eh831HCWUAqKGGB+/bUD1jm4zulvJfdCddnT6XZTw/V?=
 =?us-ascii?Q?ug0fu0F90tKqEEA8mTNXrZh3o1A7r2mLX9ANl6rPswGPmHukqDFniy2f/KWA?=
 =?us-ascii?Q?2oVgQsnTkxfVqXQ7NuHi9a+B8T7DRcGHsOGs5C5YytgyOshvx1f4xH6Wv69u?=
 =?us-ascii?Q?KGRVESCRIR2D7nsDb7p1upNUx9E26jNTKzoIQtlglCVxUk7WWRMFtqziQ5sl?=
 =?us-ascii?Q?1Qr8rRa3HHzmYWBoSrYZOre0D/7ONwPel9GlWvssgZbnCel+dThH1fEnSvHj?=
 =?us-ascii?Q?6cOs1paeCghvf9KZvm+apf5YXemSI1CzteJLlEIQV2K086IiZ95mQ11QhwD3?=
 =?us-ascii?Q?rKh4UtHs+E8BAPB5K70rHKGEk1ralv8Ipwa7AOtU1n1U/nVpUeRTZNqJcr3g?=
 =?us-ascii?Q?xJvfMyU4jFIOzwacsAtBTdt+6dY6xUyuY0pnvvfdNb2/MNJtoOCNGZjsVU7g?=
 =?us-ascii?Q?ONBOUdK6WnrBai9x0RQlYqyW/JkjO6A31NR5HqQ6HCZr8CWbprxELjTM8pw7?=
 =?us-ascii?Q?NBvLVWK760F7kyrIEZQhhVRDI8CTt0KOa4ta88d5hW1hpp1dOKdAYSEmbjZ3?=
 =?us-ascii?Q?P9+XNgVvW4opVRWeYfMr1XvTfYhzg7YPXPUESU6DBYnyca6dgzLitq25AUM0?=
 =?us-ascii?Q?ZAmt5+cClbSRFi2obmwGDyJ0LmejxJaki4WsYqwuxCvZ9ZnQUyo2vwdShR3Z?=
 =?us-ascii?Q?bUxOxJWFQWyHKGf795PB7X3mrffCv0T2v1N6wIBHJ2AAFy5w+KJJ9na6enif?=
 =?us-ascii?Q?GAvHj6Wyo95iMlcN78koBFJzCskWeuP1/0A/usahHR2fl7vEGojNMsP5g1ND?=
 =?us-ascii?Q?nK+uZnMTwzU2Gu6HNVJW109PF3Y/GWGpn1h9QVMfbQaFgyNBo2x1+6YDLyLF?=
 =?us-ascii?Q?FeCaq+2iLzdPyvqpQvr59jDNE+q+EGc5e7Uxec0As4I6tKqKszX3VDWwX9IY?=
 =?us-ascii?Q?w9Jr8w3AdLJOAozua2PEBLPz4Lku6hrb3ftYsyj4ctCEj6mnqxvIaPD7tjki?=
 =?us-ascii?Q?YrBaSjBEtDE2bIKjbB1mUvD8G3nXNH3vFZwAE8ggDAiBvsCjl9F9/snstmuf?=
 =?us-ascii?Q?brrtjDZ9HVaxHmKmOExx1ETkt1dqNCvWrEao4S6MlVmm+etGGFV58OEJeVMi?=
 =?us-ascii?Q?ooOJVQzvnwUS4Ut4LqnOb/i+fVT9dp4z+7B6ug38nSL1mz3mZl7SdjLDXgjh?=
 =?us-ascii?Q?Gny95qHF65DP6JPv6IjWgD3DxCkG3Ew+Oxd+m8lNr6DGobur9KrlykRQifzm?=
 =?us-ascii?Q?qdmhJDycJnMM3spn42oHvgaZt8k9gCfPq07yAs/QoY9YVZnu0QGyLZY9yO+n?=
 =?us-ascii?Q?E8XKIoI3Vs/Le2R6kAJb/FL5fg7Bsj2UaAWEVVrV+R/SOXSZweC4CJQlJC+e?=
 =?us-ascii?Q?jcQR8hdrlMelpwIOv2Z48xhcuLIU3Y6PGHrc5F33epExTZ9Uhumd7PInUejw?=
 =?us-ascii?Q?vKWk3+IPon/jnAdCkJG7y7bb1jFcwuxfqIcmCxWHLxO8XN+/XuX6wmpUus8+?=
 =?us-ascii?Q?MK9mQrTFJKDIaCSMfr+LEChCSgqXPj/vdKe5WpB+hv0MiqPmkU+EdAaQs7Ex?=
 =?us-ascii?Q?IyAhNIlU/ooWqHHGJaVVYhbFOIU0EJwScH18pdEbr/MpIyc/WqeQhW24aZDw?=
 =?us-ascii?Q?HXXrSCFfAcnVINI4kbOal4ifAGzbBoWWfmZ8ekA5bCiDtMU2wfHQ0nnQL+K5?=
 =?us-ascii?Q?4RrkRsj0r/IyjP1Tmeef1M7riweQ+hS9Nx9WyCcgcl+yl19rLht75EYOftxf?=
 =?us-ascii?Q?27g/EKLGvg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa54276-c1ab-4fd3-6bb0-08da489651ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 14:59:27.8671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4iNhjUGsS4dxsIuX3FlGwnsY/W0xlj1Mu34oc3i83I+iUNuzT/BGMFlpRXM9qMHFgtZGtJsVJpNupeWmFIVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1432
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
 Ray" <Ray.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Tuesday, June 7, 2022 10:37 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Huang, Tim <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish=
 loading both pipe MES FWs.

[AMD Official Use Only - General]

Ping

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Monday, June 6, 2022 6:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish loa=
ding both pipe MES FWs.

invalid/prime icahce operation takes effect on both pipes cuconrrently, the=
refore CP_MES_IC_BASE_LO/HI and CP_MES_MDBASE_LO/HI have to be both set bef=
ore prime icache. Otherwise MES hardware gets garbage data in above regster=
s and causes page fault

[  470.873200] amdgpu 0000:33:00.0: amdgpu: [gfxhub] page fault (src_id:0 r=
ing:217 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  470.873222] amdgpu 0000:33:00.0: amdgpu:   in page starting at address 0=
x000092cb89b00000 from client 10
[  470.873234] amdgpu 0000:33:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS=
:0x00000BB3
[  470.873242] amdgpu 0000:33:00.0: amdgpu:      Faulty UTCL2 client ID: CP=
C (0x5)
[  470.873247] amdgpu 0000:33:00.0: amdgpu:      MORE_FAULTS: 0x1
[  470.873251] amdgpu 0000:33:00.0: amdgpu:      WALKER_ERROR: 0x1
[  470.873256] amdgpu 0000:33:00.0: amdgpu:      PERMISSION_FAULTS: 0xb
[  470.873260] amdgpu 0000:33:00.0: amdgpu:      MAPPING_ERROR: 0x1
[  470.873264] amdgpu 0000:33:00.0: amdgpu:      RW: 0x0

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 32 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index fcf51947bb18..9741b7ff4224 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -541,7 +541,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev=
, bool enable)
=20
 /* This function is for backdoor MES firmware */  static int mes_v11_0_loa=
d_microcode(struct amdgpu_device *adev,
-				    enum admgpu_mes_pipe pipe)
+				    enum admgpu_mes_pipe pipe, bool prime_icache)
 {
 	int r;
 	uint32_t data;
@@ -593,16 +593,18 @@ static int mes_v11_0_load_microcode(struct amdgpu_dev=
ice *adev,
 	/* Set 0x3FFFF (256K-1) to CP_MES_MDBOUND_LO */
 	WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x3FFFF);
=20
-	/* invalidate ICACHE */
-	data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
-	data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
-	data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
-	WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
-
-	/* prime the ICACHE. */
-	data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
-	data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-	WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+	if (prime_icache) {
+		/* invalidate ICACHE */
+		data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+		data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
+		data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+
+		/* prime the ICACHE. */
+		data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+		data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+	}
=20
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
@@ -1044,17 +1046,19 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_devi=
ce *adev)
 	int r =3D 0;
=20
 	if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
-		r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE);
+
+		r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE, true);
 		if (r) {
 			DRM_ERROR("failed to load MES kiq fw, r=3D%d\n", r);
 			return r;
 		}
=20
-		r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE);
+		r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE, false);
 		if (r) {
 			DRM_ERROR("failed to load MES fw, r=3D%d\n", r);
 			return r;
 		}
+
 	}
=20
 	mes_v11_0_enable(adev, true);
@@ -1086,7 +1090,7 @@ static int mes_v11_0_hw_init(void *handle)
 	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
 			r =3D mes_v11_0_load_microcode(adev,
-					     AMDGPU_MES_SCHED_PIPE);
+					     AMDGPU_MES_SCHED_PIPE, true);
 			if (r) {
 				DRM_ERROR("failed to MES fw, r=3D%d\n", r);
 				return r;
--
2.35.1
