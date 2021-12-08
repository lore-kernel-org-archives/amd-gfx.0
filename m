Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B254FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 09:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5095A6EAF0;
	Wed,  8 Dec 2021 09:13:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23296EAF0
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 09:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO3jYhbwAi5zIfNxUAZOBOxyCm9uAY3USf9+3RR2PNsTkgI94wThHBGFYtgAvT8gIN4jThNij9A6RTG/pkdz3CO//tr2J2iasA72rRbjPTcvg3v3eb0LNbp5VAhF66h5qZZL/Y3eAMjNkkXkroBWRFGjR21bDImDwa8GpL8JgXCCUP9qfEjv54a10/Adn6ycJ7CPNlfFxqeKFF8haAXVK8b8tQjVIE3csQ2yUOmmAeM2aE6P9CH0+Ft7/vkp3Ff+eNfltuGSvAaZiLzuV8FV7+4FcpgXv3OJJrE62k5mPvaRre3ePH7mzU87j5cwoi+7PvXcSgmUwh9jRM2C33C3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZUJYfJFIoDwd5wGV2dMILPeWu1REI1NIwI1GflOEI0=;
 b=IKGJ3iiC2XV4GAMSrxgZp2wfGFGk1UadvlLXjfX+U4pxzOYawNmXH4Djs5hI0iFZZlH8DMkYcLbBSyrl/jUQ1BMsZMKuI+Z8YWKlbO2XVJ/PMnrQPA+KwsEXFquqAjKa/oQHGpUZi+73UGvyn776Y4XdKjaYu01rUpvLnfHaVRdypK7iFMFTnIndcPqzAydwjEfDi6+V2GwkKGjT/5FMkQrmvLPc0yqarJjh3YnMiD86v62aR4ONRJ4W1L52RjRZmpvhEbA84F8Po2CJkqXo+a4oc6b9lQKmW/4AAsD+hoxzfpNYCcTSj0Usecenu4Q3n+RJa3W3Ke1Kn3VXC7jC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZUJYfJFIoDwd5wGV2dMILPeWu1REI1NIwI1GflOEI0=;
 b=R1D4xm4wsBkJXYzcMjDFlxdVSjuS+ZmusXVbrKusbAqRJghtMOMxapcLss+YVI67/tWyILEoISzNpYKjTYim7E2ng298JyU7mNyNAY6Utr/u5r2T8Wif5ymZxQREW9CRVzlXT1O7l3xr5WG+a1Yn26PSSxwQVW0At0n+aSTFPS0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Wed, 8 Dec 2021 09:13:35 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b1f6:5cac:acb5:69d7]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::b1f6:5cac:acb5:69d7%4]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 09:13:35 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Shi, Leslie" <Yuliang.Shi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix incorrect VCN revision in SRIOV
Thread-Topic: [PATCH] drm/amdgpu: fix incorrect VCN revision in SRIOV
Thread-Index: AQHX7BJT9sWsqaMVpUW2xpTX8Z9itawoTp8g
Date: Wed, 8 Dec 2021 09:13:35 +0000
Message-ID: <DM5PR12MB246969CECC6AC8D12C2856A3F16F9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211208084615.437375-1-Yuliang.Shi@amd.com>
In-Reply-To: <20211208084615.437375-1-Yuliang.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-08T09:10:06Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f0dc2dea-9838-4239-bad4-1463c8267e56;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-08T09:13:32Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: d0573aeb-5c0b-45dc-8862-a19372ca5569
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bb4a92f-09c2-454c-676a-08d9ba2b038b
x-ms-traffictypediagnostic: DM5PR12MB2502:EE_
x-microsoft-antispam-prvs: <DM5PR12MB250200DC33294E4077629DB3F16F9@DM5PR12MB2502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZd2I2ZIUQpPY9JIpt+3Ghnulb4bkhOTc2cK43SoQguJDRHjStchppUEpxwGdJ3EI2yzDUSyDwP9X1Tde6qKbhgjeeB/40moNKr9YnozaK91qPD1GBDsak8S2QZHbCqCpTUaiujj9on6Rz/YDi6kOgQQ3JfPv7SXZYNHa9LV/9hRVZZH8VU/tuF6aRzploEeEcIgaDdi4i8x9QuAK58u3lpj+vgb4TwJVyhyUF5sUeDhZNHMj2g/hMocUzfeES99VdGvg4Fm9WwMr1EMHWpeeFHkntl3QG4m7jCb7N0KoVIsZDZnVJtLtgYkWUhVtyYjDs3fhRtPA1jbjJbTqWdB6snShRBzvzmJsjTjPrswEdrcRMOCR7B23inxJiMnmMBaqeimoRWC1b5t+Pw0T77g0MoDGcDyXUl6bzjg/oteqOkyKDACsO17EnBy3iEV4il6lQJOx5voXWib1fombi/HzT/1L2gv/b/WFTSt3zUm+/izv/Ov3fEnF2s0dpdAPUaBnnCUAGAoGqWeCOwVwucl8ubp2qgAlj268D7PRparwOrxTNKc8yrkO7mjTOhO40tS28aFpCSOR05ytR0pz5ceTfRzM1ecRXDlu0C0S8eE58TUQTKx/Dsn6v3M4Gf+WmqC5JIilHbVIJmVS+g45lG4pgBwcFpv+OVg//Svl4saeAybcD1mW6GGUgF0qLvZzZpnUkHfR3DJ/Vy5PRGl6f6Ezw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(110136005)(2906002)(6506007)(53546011)(52536014)(9686003)(122000001)(8676002)(186003)(38100700002)(26005)(71200400001)(508600001)(86362001)(7696005)(38070700005)(33656002)(316002)(5660300002)(66556008)(64756008)(66446008)(8936002)(76116006)(66476007)(66946007)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zsPln8fA6phuIUBrwdoTUTN5uYI8AOUrv/bM2aSpffHIINW7MpVhFDeqYwSk?=
 =?us-ascii?Q?yv5pkVRAknjrybMBZhudsF16VNE00/OGiR7pbRu6QbY7WePAe71gpQq7yaUc?=
 =?us-ascii?Q?JFRWk8HQtrGxNmvsz9MHy6U3iz74BgtEW0HvkxjbS+pbxhVQw1sk/eI6d6k5?=
 =?us-ascii?Q?cZGfh1xrCzus2TIlX60Ru8KN9vY4YkZODYLaOT+h1cO8PLVghLGvVGXXZGyl?=
 =?us-ascii?Q?NLPAG5uYOYUSBEncVsRD7pczrdB+4l1IeLJk6CF/RBs2oLYonGf++DAaKQw5?=
 =?us-ascii?Q?4y25nzugz6R7x59C6OeaY+Qs4KOLg3ebgUe3iU3dWOBfwJ1FaRLDXzK3VDsR?=
 =?us-ascii?Q?VXtvq6qcP0RuXPEIEMJygJC7mbkm+JpL1Ds7I3pRzVd3HeD9W5Y9aybeNgFW?=
 =?us-ascii?Q?xEcl47a98uBhPIe1Yjwt0vv3GzAuVMWgRzki4YwtpvJ2ez4vxHjrGjkNbtkM?=
 =?us-ascii?Q?4Cz3A/FLMFe0fJ1lMiKrbIZC1GM3Uv84BumilfoMC+dmhXfbAtSKVkXk5b18?=
 =?us-ascii?Q?WkMu06bUNsvP8Z52QVRm23nS5Mx85wDc6zL+DL2vMGAoo+1CDXTTuLoDT0Pm?=
 =?us-ascii?Q?DWeggsSLPjLvVF3ttpAroL5hwrUxuhklWaJGR1xJnwswPHjF2w0HKEykD8ym?=
 =?us-ascii?Q?jfUADbpXRvEyzVEUBKpM+6EkTsxfJ0M/bsFbM+TgHEq0UsKq5RjzQIyzKDo3?=
 =?us-ascii?Q?FoYw7iO6GYKJJ9ABiyfpKOwxnYUmA7hDJVHjf4vbV6SeufVHg+zTW03XyXMI?=
 =?us-ascii?Q?Mkt0jx7IF9CMinwexeISh9y6MKc1J5NjZZU9bL7AZ/+Y46GbGZ0Wu+msallL?=
 =?us-ascii?Q?Y+HGHRZchrzVdDFlEJFXKehvtTpojy7jr4Wfvx7uv17Kh6snOFUss/IkRZww?=
 =?us-ascii?Q?vAZKvtGIvOSV1xgsZ3lsrEdWO0jttOwFNyw3760tYx1XonuiMbnuADWXbYLh?=
 =?us-ascii?Q?YTElQPvRC9591oxdEpenbMRo8nLzdnldfoJ32Ifa/BtlaIeWrVYDsy2Vdj3L?=
 =?us-ascii?Q?OeNpk6swZYLVEtoxrQfEts6+V15dfri3hdhuJ/Z/fauM4EXmjeziNFt/nuK7?=
 =?us-ascii?Q?UQKHKJokPyldtBMjKmAILSLA630Wax3NGOoJxyFz616J6tAiPCzkelJ2VWzs?=
 =?us-ascii?Q?P03Nd1gi551fVqycBnBU/ZiPz+GTbWYuq/vOncJ9cH5ArxNgjT77Pm4/i8d9?=
 =?us-ascii?Q?foVAK/5YimTtD1A41uOWsGN3AVh8UCFijmscWDd73/AVKA7JuWp40csqdbcN?=
 =?us-ascii?Q?Ru+kJfOumfHWaDjTCpqE8oXyxFzUIjPKuJAFOOEY8BpwAbXHnrBRo5NbdCtj?=
 =?us-ascii?Q?EqbHGkGxp3B/En24ZbFNFlhpQ3oeno5zayX02++0DmTvPWHhVJL2rjcL5g79?=
 =?us-ascii?Q?0SpNy7Qrn5FeIpce3vgZEnbuX66emFb/MpIHfAGOngBXM8Muw0e1kG5EGIaZ?=
 =?us-ascii?Q?lqVi6rSMeiJrldIydzuOFBnDWUEbqf+eneeBEOfHK4mrVvSYRuBui6LefOZV?=
 =?us-ascii?Q?62UG9VciQ8ASY4cNQHNtxbP3QTUGyQ259BGuMuSNwzZVQIO49KpK7FKlyO8L?=
 =?us-ascii?Q?6MtKJ4yTduoaedrTSyr/EOsiMHARbPDcwg0YRonbkxua192nAtaxvGITb7y1?=
 =?us-ascii?Q?nBYsIR8TAXrq7p/4/IVJR5U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb4a92f-09c2-454c-676a-08d9ba2b038b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 09:13:35.4213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hnCEgvW1enQRZk9kyyyALJS56rfK56B0qluBppSUVLbf3lOErGAqbJf2fYDSU9tPiYeiwNQHPgzRtKq45aQK+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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

Hi Leslie,

Can we move revision handling in this patch into amdgpu_discovery_get_vcn_v=
ersion? Then we will maintain all revision handlings only in amdgpu_discove=
ry.c.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Leslie S=
hi
Sent: Wednesday, December 8, 2021 4:46 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix incorrect VCN revision in SRIOV

Guest OS will setup VCN instance 1 which is disabled as an enabled instance=
.
This will cause VCN ib ring test failure during modprobe.

Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 2658414c503d..2323815ac32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -293,6 +293,9 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *a=
dev, enum vcn_ring_type t
 	if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, =
&revision) !=3D 0)
 		return true;
=20
+	if (amdgpu_sriov_vf(adev))
+		revision |=3D adev->vcn.sriov_config[vcn_instance] << 6;
+
 	if ((type =3D=3D VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE=
_MASK)) {
 		ret =3D true;
 	} else if ((type =3D=3D VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_=
DISABLE_MASK)) {
--=20
2.25.1
