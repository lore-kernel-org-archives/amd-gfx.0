Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB4BC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 07:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1173F10E972;
	Wed, 17 Jul 2024 07:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="niYczWNO";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA5110E96F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 07:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nc9MVTcApY8w6sDS212jPDUuuhJHomT+7DTkh155dEcbvXwbSKl1cYnPgq3PIGbGGVsqJb76NEBGR+MyOVSCuTzlrxoaf9uz5CSI5YYn6NgzJYUBWkQCkT5A71VQLt2+hRl98xE9GHp6JuA4GyjxNyKMcHAJ6/JTvscQGzijj3UZPLTikLcb+WPjNemoyAzVxcoE09l81svpmxnO1xNI7/Ev8tcti6qB4O4Tc4BlgiMkMQOB42ethhZ5DQHQjghdGNklib6adQOtXHfPcHyQNRfuGdB3i7Lyi7OxkoWsHaqlXDGXrFczBnGx4102jeHzvdCF/w5YK0PxBtvKSWpXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIhXdptbb7HIchcyUYEdHMljONN/xMBp99Fbf54+jEs=;
 b=eB1pHk9pIBis1+4j234l/uh3ZWM781cYVyj5Y4ftPKLbDMTc2KwqbMjyw+8qkWrUo0E50SEB55KzQb3d96Xf0gpXTXYzWeyYfhT7nPdrvlv1Pgt2Zrr+tnwgi02Xhv5l1XXKosKiBNXtT7hjh3LxmMaTiDMkjTZPMVZ4rWZr2FYEFBXSPk4kJVTGneTjl96e4ygqX45jLCNXxie23Gxy/j3sFvapMV8JVnzMtx1eL3mSHDEFcZc5kVEV/qxGijSJspq3zwDGHg2zsX74PIpmmEBJqvGfVACoV6HBbwcjJs+wXLp1yKgjpCzhCZ67qmkF7CaYekVdyEYa7fZSaHTCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIhXdptbb7HIchcyUYEdHMljONN/xMBp99Fbf54+jEs=;
 b=niYczWNOQTXFdVAgXQf9ArbqnZ8AM7zCaB3U/ARKj8pkys+Mqg9kEL6ZbRTXzXghaPpmoHkvUE+uZBG0n9B2FeBXYJ4dzRhNIPOAv4AWuzuUf38T/fpAW5/ugYNpll3h92MTM7U5GcuI0BeYux1d4D3FG2YW7+q9xIXvaGlewtU=
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Wed, 17 Jul
 2024 07:09:47 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 07:09:46 +0000
From: "Jian, Jane" <Jane.Jian@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/vcn: Use offsets local to VCN/JPEG in VF
Thread-Topic: [PATCH 3/3] drm/amdgpu/vcn: Use offsets local to VCN/JPEG in VF
Thread-Index: AQHa11zBkbAxGSaCBUqE8hbzNZV8BrH6gYew
Date: Wed, 17 Jul 2024 07:09:46 +0000
Message-ID: <PH0PR12MB548176E4D98CC1B3F720AF6EFFA32@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240716084703.196194-1-Jane.Jian@amd.com>
In-Reply-To: <20240716084703.196194-1-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=add47d8a-c8ab-4fc3-a9a4-862f2220ac8b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-17T07:08:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8233:EE_
x-ms-office365-filtering-correlation-id: ac6137c1-d5d3-4d7e-655a-08dca62f70d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ixmAxUtdxvS6DQUjygjSnZwRoML9mLm1+ynprRkhsh2+CkZJNdrzyVMRJKpT?=
 =?us-ascii?Q?jWqaEi+T7MT0DddtBT4I9zQTIMTgs/O0dV3eckDomHWj4A/2BP3+ip9WbIbC?=
 =?us-ascii?Q?yZjEytk1zqyQJw/wA/vA/vSJBrTkN9P9wbf7fv3gNVJT2wbiQCh6cCdRrqpC?=
 =?us-ascii?Q?E8fLe4jgm5LCGxrUFSg3uNc8nUqpRiG44ji8pBh4YhH7Y1dPDtyusBNtMKAI?=
 =?us-ascii?Q?Oubl3pNBPQOVRDByHqAS10eIY+y0Yd/e9bwGSy4bDjyQPyd/w36O/u4Ho1sW?=
 =?us-ascii?Q?CWrDADiIY5YEErzOApE4/16NmW8PplHDId9TcSWCI7/11FYe0IIJZ+AtGRk8?=
 =?us-ascii?Q?2Tp/kDmnK5MGyKWjc24hBSzqQlo3H5G2clk7nHZhnko6kMhIUQlFB+zRAoOP?=
 =?us-ascii?Q?73XUKNiyNQO9KzP7gu7xq5hgjfSdEH2nllDd4mJPHZKR+Wg7BQ2O4Ki73XmE?=
 =?us-ascii?Q?3A5DmdkYSl5ZNyld28AX8W/Tv4SQbJoWYkyaGbcoBSCnEefijYP0P0nSnexX?=
 =?us-ascii?Q?6a7zmGdcScrmoZwUCnyY+MVt7YORnTGOFHAxX/PK2Gp5jbrvWalZ/hKY7RzK?=
 =?us-ascii?Q?t/q+F5wJe43HkAaJ+QqGOqrz8m9B4XLGy6DB8+FFPVNJIOEkWfe8G4YUd+tS?=
 =?us-ascii?Q?fteDiElsP/XDgO+lDyDAukGumzZV6Q3ljQqsOIG3N62TgPBtP5e9K8jAzk57?=
 =?us-ascii?Q?PfskMK8O8ktWHZCvjBf2EnV6fAEAbhL0EETxCI9E9ReykGy8ysHSq/8gO02/?=
 =?us-ascii?Q?g8t8tHwaJYvlOaqibSVTxwBrlQesFfRK52lPO0uzCqxtuFV3Qg0PUCVZGeql?=
 =?us-ascii?Q?zGFfqdSenBgatfyNEC0Kv46q1+XXanjfcVpxz+WIm5gpJrqE+zN3zpOWg8Om?=
 =?us-ascii?Q?Grk85UBpIPT/ZmTqURB2je0v/c+bGZE9SOfrmXWLpB4ZknelHpoo5RVXWIqR?=
 =?us-ascii?Q?d4QKOUcOY/JOWUbk8xi81FJUOq7cssQugEqJTwDlPJ/mTrn206Tc1bZd4frd?=
 =?us-ascii?Q?BffGl5wGwkZIOuTFkB9ZcQL3ATBOG/TiryCK3E/4zZVb+//KUo0mWp/vbrox?=
 =?us-ascii?Q?8E3S26spXdKWxvz0iOsv2g7tpu2svH7iAf0cFjg3g7TOAjUfUvvCqEdN7dqi?=
 =?us-ascii?Q?kgs2HlEMLIr16gAYDv5pyV+x7c4E1kLlUJ8xY93iyvz8vZCIOmyzBEowtW34?=
 =?us-ascii?Q?8+Tg8Pkp07g2M0FF9vV44JMqaGxurlfl7yGLd7eiImAHQqJza81dMVDUui/w?=
 =?us-ascii?Q?Q/wKtCUywkbSmb8m51SnsuwLcXLn9HT185JjRXcTPuIGompioSEnj49cyo0L?=
 =?us-ascii?Q?xKa3pZBHHeRMrV1UL3WDjeGsgE1BpVBPMuiOlLSq4GYcreGmIArhju9xSWbY?=
 =?us-ascii?Q?lKwdQHzGcrtlZtBM18fUV3d8Tj1Ny8f5ywyNo6zykEmU8ZQfL1VMH90SMrpN?=
 =?us-ascii?Q?kOAnL2PLgHU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aQSDCs40snVjSgPIMQM68+layn7LeOfx9hjb+TtSSBU4xH9x01QlSo5FExZ7?=
 =?us-ascii?Q?8CWRV6xcz39NEpsGV/anh25wQnYpTj3Rxi7/OlvQ3N5Vv/8V1YdSy62QMnKS?=
 =?us-ascii?Q?AeMWUiEhLxIqX49Rc064j5WlWGKTVcOcCy3aw0RwHlbTJdba40FjngaLK2qs?=
 =?us-ascii?Q?vxA1bBm1Bo00NkLtmZ/4asjTx/oyrUVDqtwYJjjt5Sqwpoef34Jumh61zRcU?=
 =?us-ascii?Q?uuK6YF17A9MMt1Wih6RYqQWsahC+qLKb0IYyWrPbmFf4L9a1M172x6MmHglG?=
 =?us-ascii?Q?FtOHTRU3147QZ/LWDTLZ+ISOFiybC3R2snCTgBdfRo9zrgmRd2Cx0FcGrwKK?=
 =?us-ascii?Q?4jTit9DVi9m3AjiW9TUutuDPXF0HSPU3HyWZDmPUlmQAVdNGjyxMHopfWdxq?=
 =?us-ascii?Q?SlchG9NctbVY6sX2If1z6m/7m9mI94Su5jvUENq0mtN44F9ynxQXcLDuehD8?=
 =?us-ascii?Q?Xya0BDv58VLJSm+cb5B19oIfYLnlpjKc7sfSjQZrxLGgbG3S83G/dTMIDqbJ?=
 =?us-ascii?Q?7Kdqw7R6GF9lNbeN4czLSvLDi3rlFQiwqjLS4pUsJO1pjK46y2WPpifN8PH1?=
 =?us-ascii?Q?MnIc9Lki07AVAwE30wW2xSK0DYveXWeRG8A/qgFr+NQ84uoP9YZ7a4s5vACL?=
 =?us-ascii?Q?aDpH8l2Zu/jo+8ctNqfdeOZVjnR+MfnTOZDzAcBD2uNOzVIkQa5lypF7xwuA?=
 =?us-ascii?Q?5kdFM9sQgCzsdFX/36IggFRRybxutusA+x634OqgCICmOgzA/AFBVYXEg8gF?=
 =?us-ascii?Q?oICaQAJTtjcR1rsBDAdIuMXCWu/gqX4dMNZEFOCMeXk+RAfGGWSMNEmU2Eki?=
 =?us-ascii?Q?KJIG62Dv88gVHPaJcmZP3sfUWQTSyRacj7MMWJSIF9APnh66o5udNM2w+nvp?=
 =?us-ascii?Q?KrcIUExhYqdarMnaAazkAkRbY3OGLgCNpjnNTZkZ53pppIA8akhScDqd9VcY?=
 =?us-ascii?Q?XYJBeIwCq6ddV2goR20WhmUyM7F83DhUbqyQyKDzNriv68YOgXAJ5QN1xpjD?=
 =?us-ascii?Q?hxiQ8h82U4GGIGPrk3Y1OIBpWTO1K29XhTGE9mPiAr+85VakdIxnaDhBHb1E?=
 =?us-ascii?Q?RIms18GD10NY67/Z8D8dK6EDaaAiDsm6zuWrGaLGkr3sdXRMszCTUl+jwkA0?=
 =?us-ascii?Q?FVGy5DGjqlu4ZijlH1zUmIpTh+h0P2y/j56oRzwwFjZNi6uIibMMd+UEUnzN?=
 =?us-ascii?Q?GRHDus1Ak9gtJmpcDCPS8cDd2XxOYbBajIpC7OdV1gjWnirHPBTEa0M7Y1BU?=
 =?us-ascii?Q?K3BCeElXbP6wHut6TimwLLPjm0btOon/9F58v9hEFMp3BcdT+M92xM24GRq3?=
 =?us-ascii?Q?vsBN+nss0ntm8W/2xhTwuuEGR4auNL7U4f8uFxzG/TS97neZVk/Z0xUphurO?=
 =?us-ascii?Q?fjlPWA1VfLHlwvjyvqj+YZzoxqDa4KSW2s8KIIHkPVGzBJA0Hnr6qn486x5b?=
 =?us-ascii?Q?Fay5fEOl/CdMmxKb4/4APlKWN8hcEUmMTCrtYjY6PJFN0OgpU5sggCU27+Ot?=
 =?us-ascii?Q?BHWA0/vZ5S5l8f5zuxP0iRYzPL9CWdCi5uaBVTBRDzxF5ngrFQ0aU+lo6Q?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6137c1-d5d3-4d7e-655a-08dca62f70d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 07:09:46.6266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3PmNMqEyyPsQfoqmGshnMtoSuSawOzFIP1EEUqE1nAlH3Y46y4T+bo9P5QTL2CIvXgw6sMX1yX986iPBfmhaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
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

Ping for this series...
Thanks,
Jane

-----Original Message-----
From: Jane Jian <Jane.Jian@amd.com>
Sent: Tuesday, July 16, 2024 4:47 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;=
 Zhao, Victor <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Jian, Jane <Jane.Jian@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/vcn: Use offsets local to VCN/JPEG in VF

For VCN/JPEG 4.0.3, use only the local addressing scheme.

- Mask bit higher than AID0 range

v2
remain the case for mmhub use master XCC

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 19 ++++++++--  drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0_3.c  | 46 ++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index 30a143ab592d..ad524ddc9760 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -32,6 +32,9 @@
 #include "vcn/vcn_4_0_3_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"

+#define NORMALIZE_JPEG_REG_OFFSET(offset) \
+               (offset & 0x1FFFF)
+
 enum jpeg_engin_status {
        UVD_PGFSM_STATUS__UVDJ_PWR_ON  =3D 0,
        UVD_PGFSM_STATUS__UVDJ_PWR_OFF =3D 2,
@@ -824,7 +827,13 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *=
ring,  void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, ui=
nt32_t reg,
                                uint32_t val, uint32_t mask)
 {
-       uint32_t reg_offset =3D (reg << 2);
+       uint32_t reg_offset;
+
+       /* For VF, only local offsets should be used */
+       if (amdgpu_sriov_vf(ring->adev))
+               reg =3D NORMALIZE_JPEG_REG_OFFSET(reg);
+
+       reg_offset =3D (reg << 2);

        amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_RB_COND_RD_TIMER_INTERN=
AL_OFFSET,
                0, 0, PACKETJ_TYPE0));
@@ -865,7 +874,13 @@ void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_=
ring *ring,

 void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg=
, uint32_t val)  {
-       uint32_t reg_offset =3D (reg << 2);
+       uint32_t reg_offset;
+
+       /* For VF, only local offsets should be used */
+       if (amdgpu_sriov_vf(ring->adev))
+               reg =3D NORMALIZE_JPEG_REG_OFFSET(reg);
+
+       reg_offset =3D (reg << 2);

        amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_O=
FFSET,
                0, 0, PACKETJ_TYPE0));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_3.c
index 101b120f6fbd..9bae95538b62 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -45,6 +45,9 @@
 #define VCN_VID_SOC_ADDRESS_2_0                0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0       0x48300

+#define NORMALIZE_VCN_REG_OFFSET(offset) \
+               (offset & 0x1FFFF)
+
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);  static voi=
d vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);  static vo=
id vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev); @@ -1375,6 +1378,4=
3 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *r=
ing)
                                    regUVD_RB_WPTR);
 }

+static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, ui=
nt32_t reg,
+                               uint32_t val, uint32_t mask)
+{
+       /* For VF, only local offsets should be used */
+       if (amdgpu_sriov_vf(ring->adev))
+               reg =3D NORMALIZE_VCN_REG_OFFSET(reg);
+
+       amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WAIT);
+       amdgpu_ring_write(ring, reg << 2);
+       amdgpu_ring_write(ring, mask);
+       amdgpu_ring_write(ring, val);
+}
+
+static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring,
+uint32_t reg, uint32_t val) {
+       /* For VF, only local offsets should be used */
+       if (amdgpu_sriov_vf(ring->adev))
+               reg =3D NORMALIZE_VCN_REG_OFFSET(reg);
+
+       amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WRITE);
+       amdgpu_ring_write(ring, reg << 2);
+       amdgpu_ring_write(ring, val);
+}
+
+static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
+                               unsigned int vmid, uint64_t pd_addr) {
+       struct amdgpu_vmhub *hub =3D &ring->adev->vmhub[ring->vm_hub];
+
+       pd_addr =3D amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+
+       /* wait for reg writes */
+       vcn_v4_0_3_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
+                                       vmid * hub->ctx_addr_distance,
+                                       lower_32_bits(pd_addr), 0xffffffff)=
; }
+
 static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)  {
        /* VCN engine access for HDP flush doesn't work when RRMT is enable=
d.
@@ -1421,7 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unif=
ied_ring_vm_funcs =3D {
        .emit_ib_size =3D 5, /* vcn_v2_0_enc_ring_emit_ib */
        .emit_ib =3D vcn_v2_0_enc_ring_emit_ib,
        .emit_fence =3D vcn_v2_0_enc_ring_emit_fence,
-       .emit_vm_flush =3D vcn_v2_0_enc_ring_emit_vm_flush,
+       .emit_vm_flush =3D vcn_v4_0_3_enc_ring_emit_vm_flush,
        .emit_hdp_flush =3D vcn_v4_0_3_ring_emit_hdp_flush,
        .test_ring =3D amdgpu_vcn_enc_ring_test_ring,
        .test_ib =3D amdgpu_vcn_unified_ring_test_ib, @@ -1430,8 +1470,8 @@=
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs =3D=
 {
        .pad_ib =3D amdgpu_ring_generic_pad_ib,
        .begin_use =3D amdgpu_vcn_ring_begin_use,
        .end_use =3D amdgpu_vcn_ring_end_use,
-       .emit_wreg =3D vcn_v2_0_enc_ring_emit_wreg,
-       .emit_reg_wait =3D vcn_v2_0_enc_ring_emit_reg_wait,
+       .emit_wreg =3D vcn_v4_0_3_enc_ring_emit_wreg,
+       .emit_reg_wait =3D vcn_v4_0_3_enc_ring_emit_reg_wait,
        .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_he=
lper,
 };

--
2.34.1

