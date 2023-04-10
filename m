Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C19DC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 21:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65B210E12F;
	Mon, 10 Apr 2023 21:33:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82B310E3AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 21:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYF5P4VV6h8HlAlGIUSR+PKezNqEqjufkly8yUxs7Q32WbTJcRNx2wNxqxVVea9uF8V8ASZ6Rw4zO8PbvIOPRNzXUthFgRqehCIlt0qbQcSvo3oGBuVq39DoLLb1tKV4DNagEDR0ftYs3xyIY/RiqGcr24WDUvPPng4YkSCX2PpDeHqXMqJhfxzRsHuYMrStFUw6N2UMs4AOZu7jsl/QsM6JNgbhq4dQotQ+cN9HgoQXdiUUITRR8K/yn66ukSWUN32eoS+xBFUWGUACvpSA/dULt6ygmyLRQwKC7PMWWIOpmVjgj/LvK7G6377NNJQ6ONwccLfwmE/wSP8Cgd+lPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ+qAFCHRkqNG+h4uO9Zba2pOSfl458a4Q4SyltDmO8=;
 b=f357Tr0jK6rdlUJ7WMoawtogLaDqvfT1o0Re3Cg+tmQm1ghLMZkbbelIvnP2kw/9Y5Q2CBzQpbvAs2/zwIo8h51fqRjqqHkWRtF5x/nJJ1AJkc45f1URr98LZinLlYuAWsCu4j8GadTybWHMBumsP5eH3N1AtKVZaPqPKk/7jxnsLcChNO5vsWizjQK2n5e0pYqWrnJ1RZdzoNYdERX300wrNlYvfXRW5ir6x1hc43LPWj3IBPF8CtJ2QQbyBHe1ndYyZXlzRp8inwuBNhSiBe4IBtFrneztkDvpQ51tj+NjeW10X5vy/GhDichrcUGb0UCfgIid88gQbPESf5PUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ+qAFCHRkqNG+h4uO9Zba2pOSfl458a4Q4SyltDmO8=;
 b=BMkjONQ8wK6TMPQ+nIRSylbwQe/w3g7k79vL3COgNL3fPmYuFDPB815Qp5Ffr8EnEezZO13034K6LfCjrjFMxbjREITCl5YqlkDWwS2yPLiz5D/Gh8mMFMIzHUn8a2mz4qcRUX7i2Xa/qXbu0Sh6w9I0wLmMOqRG9RTj6goNzL0=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 21:33:40 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::56ed:8c25:8345:fb54]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::56ed:8c25:8345:fb54%7]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 21:33:39 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable GFX11 SDMA context empty interrupt
Thread-Topic: [PATCH] drm/amdgpu: Enable GFX11 SDMA context empty interrupt
Thread-Index: AQHZZ9U9KKNZdFGubkijzw7GQNh5SK8lF7bg
Date: Mon, 10 Apr 2023 21:33:39 +0000
Message-ID: <CY8PR12MB709939AF638CF4F6285C09D98C959@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20230405154203.3899014-1-Graham.Sider@amd.com>
In-Reply-To: <20230405154203.3899014-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-10T21:33:36Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=35d1da91-af16-49f0-ad10-c9218427e96d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|BL1PR12MB5173:EE_
x-ms-office365-filtering-correlation-id: b7812658-408f-4d52-78c6-08db3a0b4004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GpglIT14woYj8eC7L2/8t8C7SdylkzvjvQ7aOFORYyO4sXdoX+UruS2fHzFpx2kwP2wZVwKSpXXxUkMk8RkRPBE71lT6QXt+PqnIT2E4LrIOcaS79uChp4bLTumURqghrFIWvswMwjqLv0UVLc5xEZL3JjdSZVP5l+Qs7SvfhqxvJbMiuq1k48O6MUUdk/X3SG9UNXSPFQtJFwH1Ikd87BP5xHw9rjwVVN8sEZuk+b80Ei3vRMoXLwH5kPyd4veCdZJ4sNB7t4tRp60WQzKNsh4wTcsMx9GCtvQmoZKPBruOKYiBmoX2d3L7vdm+VbL+qTvMGl3SXuYCS6rFxGKo1oKbhQdgC9V/enAD+s2c+lWxnLgRrfo5mcQ0uxYh82ZBw/knvSSKBTYyuoMPFE9JhzZq33sxioEotjKIUfFy4znhoQYq9l2RRNagcTnV6STiAqpKWDBZVzF4KEkdzm0MzroFYrfEU2rOWSRxT4g5NG65wVQCu2F7yw3u0AQfjexXZPMq4ZNA/mRELuViGuXZB3HhGGQwVAc/HWMSpUdtudI/7mBuopltH9YqQN3T0oOKpsVx0aQsfJZZfIOeUL4iyeOVIiJ7dPfXuRTfTtYPTdylLMe5c55hXY3fLXpYLXji
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(71200400001)(7696005)(478600001)(55016003)(86362001)(33656002)(83380400001)(122000001)(38100700002)(38070700005)(2906002)(110136005)(9686003)(53546011)(316002)(54906003)(186003)(26005)(6506007)(66476007)(66446008)(41300700001)(8676002)(66556008)(64756008)(52536014)(8936002)(5660300002)(66946007)(76116006)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?byvowJzj09f/1g8qAhYGErBqi7C0um1WUYwz08XoTNWPybENzYilPwXBvkfd?=
 =?us-ascii?Q?PhNMvyD843gB3U3j6TZXGAoUq0AhJbWWJJFOFZAKY8D+uLOIajNJDo780SH8?=
 =?us-ascii?Q?2URuJXJUHf7Yqul+8MdVlANKfF5M9GhqaqH177fCmXiUrl6IHbNHfJiLURr+?=
 =?us-ascii?Q?4lRf7zlA9QW2F79iBcWxhNSrJaYxc9hdX1N8nJzNtOmVG1hLi7akc0bkuqLm?=
 =?us-ascii?Q?b7BPGap4UKhsOS8JWH66NEveZpVfUw5FClcW+0guZ0Pd++wPDHZK5ZcXze1x?=
 =?us-ascii?Q?0j1+gwbJWxO/lLsIZIv4QPi/tLAupZXnfZiNqSM7T/GSeajaJfsKIZdTPnge?=
 =?us-ascii?Q?g5G0zT/InlBEj2hPcudBg8Zoll/39XOfTEwOK3b8jQidNVxGnBZMWDbM6GyQ?=
 =?us-ascii?Q?EwbFieRoSgL92d0LNPWE51mse0I1KEIzV1/nn/+N4hb+uO8Jx+hVOX5RPujJ?=
 =?us-ascii?Q?RcIUv/Tdsph/IPOQlQsyIDeFm0uEZrFgqK30JZI9gRDEQGOo3Iz2OQTuUTfF?=
 =?us-ascii?Q?2jRgjgBoXxaGVvORxRm41VayzUj1SEJr95MM4Emrtx5bb4O9qOTHOnW8kyEd?=
 =?us-ascii?Q?L2F3ZK+vCetQqBjPjpIdztbvZFK+IY2qChKbpllhIAaJEYZOt1OLZb7Ks8Mg?=
 =?us-ascii?Q?TIF7xXNW5TCr1T5BcpNToFg2P8VYZaKaioNiqmA0gb7Rvk4bUs1avI5j4EJX?=
 =?us-ascii?Q?RcXreViSI/Gjwza3oqYGdhyWGypMQuhEyESM79DgX/h/QwdNoEoXhJwDeTHS?=
 =?us-ascii?Q?STVvGOh850GF/0vwfu2793WyJ0y6nEBxuKOT44CI+kMNRgnl04i3x+RbflaJ?=
 =?us-ascii?Q?EDOXmhU6kLq5PvxEN4b+lEMjnvn5+zMhRL9Kmf2UmzNys4blFOqffJ4/kVg/?=
 =?us-ascii?Q?vq+1mMGMP6pMdQ7BdMozsGJSn4Ajw6+0tEB7n9gx2fhFnHXou92lDRv/D8Ka?=
 =?us-ascii?Q?N/FmfEWH+NLTYT0a/JD6sz2z+FBra5uphkQw9mjwxCKtyt3CgrsEdWRlDEaM?=
 =?us-ascii?Q?J5bn6cygeDfRo5yB+zp+9uCoXyyU2DDo4C0tMdflz8HpEYKfP7Pg15v6hBYE?=
 =?us-ascii?Q?P4zSm2v7OSZL5SZNS6N9FFFlzkJjB9VVPiAJ3G7AZuhZHX13E7OgnnXo/lvx?=
 =?us-ascii?Q?ugCDnRRmlOWGIIK41PHrAi2RnqpwG5t+ZEg5y+JNNuWWgMh5HHanmbV5OrGf?=
 =?us-ascii?Q?2Rw4/7s5Tu3Qcfr5F5Kv4piBUrCo14Qz/QKYzJN+ewTCTBN+MUrKjr7qJqY6?=
 =?us-ascii?Q?OtWkWn1vYLOYNjmDxojoSn5G9itSJ3vXd5aDkC/rDXvP6R/zR6G3vVi76/20?=
 =?us-ascii?Q?uA5Cw2dPtjQyP1cO2Mw8QkikBROHDWZW1Co6+s8CHB+FYD3w8xTh0PLhVzgg?=
 =?us-ascii?Q?xrop87LcKwIdQ62U1To6XlcdLD7Q0LP4jXT8Keqp0IxgWARIUur51WLj/1QV?=
 =?us-ascii?Q?DYHJLGvGzQjGyh+d+eElQsan7Sq9SpjNfE1Zq3Lp472auNHIZ5/Ymelqrq5r?=
 =?us-ascii?Q?Rwg7H0XYP36zAb80Xm/6AWlVpQU2Hd67acuC3d5j9/LyeqskwFcLpntyj169?=
 =?us-ascii?Q?m+s2LAdDptotOTy7xEI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7812658-408f-4d52-78c6-08db3a0b4004
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 21:33:39.5684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weFbiJbxz3mQyQJbqDexnd5mnypccGvSX9CgfT2wTzkwNPPqAsbZnTe8ovjwyu9B8UguxS/FKafHpv0zA7w+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>, "Sider,
 Graham" <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Graham S=
ider
Sent: Wednesday, April 5, 2023 11:42 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>; Sider, Graham <Graham.Sider@amd.c=
om>
Subject: [PATCH] drm/amdgpu: Enable GFX11 SDMA context empty interrupt

Enable SDMA queue empty context switching. SDMA context switch due to
quantum programming no longer done here (as of sdma v6), so re-name
sdma_v6_0_ctx_switch_enable to sdma_v6_0_ctxempty_int_enable to reflect
this.

Also program SDMAx_QUEUEx_SCHEDULE_CNTL for context switch due to
quantum in KFD. Set to amdgpu_sdma_phase_quantum (defaults to 32 i.e.
3200us).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 28 ++++++++++++-------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  4 +++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index 40e6b22daa22..f45f7469dd32 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -403,15 +403,26 @@ static void sdma_v6_0_rlc_stop(struct amdgpu_device *=
adev)
 }
=20
 /**
- * sdma_v6_0_ctx_switch_enable - stop the async dma engines context switch
+ * sdma_v6_0_ctxempty_int_enable - enable or disable context empty interru=
pts
  *
  * @adev: amdgpu_device pointer
- * @enable: enable/disable the DMA MEs context switch.
+ * @enable: enable/disable context switching due to queue empty conditions
  *
- * Halt or unhalt the async dma engines context switch.
+ * Enable or disable the async dma engines queue empty context switch.
  */
-static void sdma_v6_0_ctx_switch_enable(struct amdgpu_device *adev, bool e=
nable)
+static void sdma_v6_0_ctxempty_int_enable(struct amdgpu_device *adev, bool=
 enable)
 {
+	u32 f32_cntl;
+	int i;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		for (i =3D 0; i < adev->sdma.num_instances; i++) {
+			f32_cntl =3D RREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_CNTL));
+			f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+					CTXEMPTY_INT_ENABLE, enable ? 1 : 0);
+			WREG32(sdma_v6_0_get_reg_offset(adev, i, regSDMA0_CNTL), f32_cntl);
+		}
+	}
 }
=20
 /**
@@ -579,10 +590,8 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *=
adev)
=20
 		ring->sched.ready =3D true;
=20
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below t=
o lines */
-			sdma_v6_0_ctx_switch_enable(adev, true);
+		if (amdgpu_sriov_vf(adev))
 			sdma_v6_0_enable(adev, true);
-		}
=20
 		r =3D amdgpu_ring_test_helper(ring);
 		if (r) {
@@ -778,7 +787,6 @@ static int sdma_v6_0_start(struct amdgpu_device *adev)
 	int r =3D 0;
=20
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v6_0_ctx_switch_enable(adev, false);
 		sdma_v6_0_enable(adev, false);
=20
 		/* set RB registers */
@@ -799,7 +807,7 @@ static int sdma_v6_0_start(struct amdgpu_device *adev)
 	/* unhalt the MEs */
 	sdma_v6_0_enable(adev, true);
 	/* enable sdma ring preemption */
-	sdma_v6_0_ctx_switch_enable(adev, true);
+	sdma_v6_0_ctxempty_int_enable(adev, true);
=20
 	/* start the gfx rings and rlc compute queues */
 	r =3D sdma_v6_0_gfx_resume(adev);
@@ -1319,7 +1327,7 @@ static int sdma_v6_0_hw_fini(void *handle)
 		return 0;
 	}
=20
-	sdma_v6_0_ctx_switch_enable(adev, false);
+	sdma_v6_0_ctxempty_int_enable(adev, false);
 	sdma_v6_0_enable(adev, false);
=20
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 4a9af800b1f1..85d5782eccd2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -350,6 +350,10 @@ static void update_mqd_sdma(struct mqd_manager *mm, vo=
id *mqd,
 	m->sdmax_rlcx_doorbell_offset =3D
 		q->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
=20
+	m->sdmax_rlcx_sched_cntl =3D (amdgpu_sdma_phase_quantum
+		<< SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT)
+		 & SDMA0_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK;
+
 	m->sdma_engine_id =3D q->sdma_engine_id;
 	m->sdma_queue_id =3D q->sdma_queue_id;
 	m->sdmax_rlcx_dummy_reg =3D SDMA_RLC_DUMMY_DEFAULT;
--=20
2.25.1
