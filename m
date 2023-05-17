Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA444C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 03:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE7C10E392;
	Wed, 17 May 2023 03:41:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE0710E392
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 03:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQPhdXwT3o2vO9m2Gcf07wdks1VmMQSAc2D4QPLQgl2y5gerKXVuj3mC76YFjndHOhFud7++b7gMCKOpIr/U8ZequbCDexr3/MlT3uDKMmMDbOa7/7qtb6M+KGuzPjycNyEMInVm/sib6A32nBp/GTgEzTE2Vcv2KXMCEMoYIX/2Qtivx+/fppfn3pMdK1a60IA1pFFMLyDKKDj3Sa/3WmX5blu0vu+mp5BLPBkO4OA1AChYJYl3cJPuLRJjaVZMGvRpVkT1mTMkFGvwbRGj/+AnP8TF21ZJCjHkHehzrEw3tI55dTpNf0+Mqi2uFjDRKJdWvU+kC/eh8wDNxLfnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KheDksCQGrIcZBnzCFxFcryiX7dvkOQ4jcz5Z4BtAbE=;
 b=agbGiUldl/cVuZZAOAQ2wl7/afTQ1ajWee8WMmAKhz+IlnQoc+5oWGqT0G50skgtTx68R8v2eCuWIlTtApaw+qbRS3fVDU7cQnBVkMXvbHf7iFvpT8Zjl4+ptmj4FN7FsPud+1Q8o3y3ZcxQOox/gVtW+SCPnQr76iCjb6mvviFWZb7eECjdQpUSyai6TT2zVS9lmQBBwm5wiK6yhCLyQfBSXByLRqebhYpEo3GF6nPpBcrGxJREEURR/j3OWVsFcnaC3/aWIrZ3use/8DoM/TLkX0fxzBJUcoMgrsdTORM1nDPx32I6mXccecdHyAnAu3QSdqBvbJ/u+JFmpx6iIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KheDksCQGrIcZBnzCFxFcryiX7dvkOQ4jcz5Z4BtAbE=;
 b=IEMHmKgHWQrSxvdy9TqALrNfvtcuNnrHtEpmUtGIJv9uSkpxeXqVp1pHubXrrjtjHcEfPEAwpu7wlWSgr9bSZZtuL/cIM3M+B5sC9dk2BXLq5qGpMZPQ5LbGb4g4FLKnDLZXj46W16IDSyuZRYRui0p4dWOTytR2GOGseblu9S4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 03:41:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 03:41:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on gfx
 v11_0_3
Thread-Topic: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on
 gfx v11_0_3
Thread-Index: AQHZiGVOfPdJ+ODFhEiqSGxVzpT44q9d0HBg
Date: Wed, 17 May 2023 03:41:18 +0000
Message-ID: <BN9PR12MB5257E58BA0FCBC45D870B6DBFC7E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230517021330.3096585-1-YiPeng.Chai@amd.com>
In-Reply-To: <20230517021330.3096585-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T03:41:16Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0f329b16-5f4d-4113-95ad-9b22bd404254;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB8206:EE_
x-ms-office365-filtering-correlation-id: 2490500b-3396-479d-f916-08db568892da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JKt6L9x3ZvFe/OF15ns918rfgYiwGdQv37/WVCwhDGyR8cM2BP3/KKpovUIOJ8+r5C5y2FNzd5b6iVF3DfdzCedSPGhx5pMzDIrbx5TDZwSHv1iP0V6hLhTRRbQ8rDWVe3izzPOJGFUZHYI2XO3eIvZG/fY3GvpstnQmg6Brel8oqHDuuvzvc/pJqfIOmWufPwx9Q34DL15bqnBpKcnl0HVlE+R4VxQAPxYa3mxEGTsRm5hPxlIz8CHDmK/XHOely5r1fMjcsp2H91y6Ds3ov+yXzNxg8nnzhJJX4i9VJyqy8K0A620xeK6eZvGNLoDpbCLB7qSZrSqf4K0zxVssQMAfAmwv+qKjCCp62YoEb6hNJDQlrQudRiOHqMaJO5iJ0936+nvtS4Ng/W+WX0eoHs2gMFbbjZDTIRRHrgFIzxEiPrh0oPhrPwqgWL9aGNCJpYwiuU6HZ2+ECktwtCrxBlCEnkjbAmQmkYyyvlzEqe7QmsgUIuk/BL8Bf1NqbgPf3+KDsHk1p/hNQXSTLcs5ofIYtLJWXmeXzH3GtZKnVsSzRDAEZ57I2cxaJzrhfkaaQs9kyqKVyznQcfE2selsT5TaNZJmrdXRHJ3DZinvysQOOcVQROaigEumTHuSfZyr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(33656002)(38070700005)(86362001)(110136005)(54906003)(316002)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(7696005)(71200400001)(55016003)(8936002)(8676002)(5660300002)(52536014)(41300700001)(2906002)(38100700002)(122000001)(6506007)(26005)(186003)(53546011)(9686003)(83380400001)(66899021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/2R4/jFy19MMzTqcm1YvxSkUYzBPr1spBBX7E7mHI4wJi9j+uu9A0bmKQtAu?=
 =?us-ascii?Q?fYFOuUzWn4T4nNFGdt5F039Wn6ucu36LRw6y373e/crkcWCZ5TR5qT7XUD5b?=
 =?us-ascii?Q?j88qeJvsB8cUjHKwVv9utaRuwh/yl3VDKVBub4pQp667i1ionsPebJSLa+MT?=
 =?us-ascii?Q?e7fY7FbAit6MkNcyI+SHmMJKjZbOjBMKBD+E7nSdFtenIN/U3In6ZnYDFeGV?=
 =?us-ascii?Q?WwwUh++xmU3cgsmRaQW3LZcHjXHufRu2gUg1AIPFW2r36d+rVWbhzT2CaTEq?=
 =?us-ascii?Q?FCZ89STmcHE42XTHzPGL0afsk4AvMxLOc9kUEvcZD4vALX5OQ6uZKjaaQbdi?=
 =?us-ascii?Q?03isvjXjBsnP2TV7/JrLwvCYm76tXnMqmeUGKL2885xvQ2gBuHztB5FRkAsb?=
 =?us-ascii?Q?dtIc2YEl62f6p2dJKcB6wh9SdlNblj3VJCWBcKfhli3LgE0GRlPI7QcGkTpB?=
 =?us-ascii?Q?kDR9wFDS1DArGLsIbMYI3RVkHIz01EzFTO+JGeI9u93d6UqvxnsxePEPd9oW?=
 =?us-ascii?Q?7e9IPlar4H9qm2Ka88QigsQ5iyTgtA/I0Uw1ojWhP80VLp8sNwMMKvT+dC1K?=
 =?us-ascii?Q?/j1whMWvzIkMbIeca7fPZWrVeuTxUTHV/TO2Ua1hAsylaOpbNTylvb6aVjBr?=
 =?us-ascii?Q?t2kKGexi9HJOqW07CJR7pya44FbVwazz8Zpq88WlNErNiDKKE8j9HBRENEyz?=
 =?us-ascii?Q?s7ISldbmRe9kB/ye2mueRY28ELiPWM2ggk7By2qQlUbHna8w6xbTvLCqPjzV?=
 =?us-ascii?Q?q3EooleRXC8J5/WDkBneJdNKaCmBK2NI7+UAYeONJwVuVaAjtaPbxJ0b0yDi?=
 =?us-ascii?Q?Uep5/VPBp/OB4Ru/OE42te9CV166x5wFnbbuVo5tEt7xHgayqu1+XZInFHUp?=
 =?us-ascii?Q?pXgQ5T8PAwWmiV0Ihm+sIErAVtaspdd1U0SwOGot/RAKdx46I1Nyo5GWEfzf?=
 =?us-ascii?Q?er3mMFNLUc9IXmB3kn0KJdNDh2lM/s/SJRo/ZJDD1Hoo9T6ivi4dGxoMfc0Q?=
 =?us-ascii?Q?7wrnbY7uTE22A/sVUzihhHRKmf6MqqyK8EMvx39lxUAE9BetIM/U7NfLlLd0?=
 =?us-ascii?Q?ilSufCAzeopSmwz5DRB6CkwKMD5A03WT6wlcBF8gxeMjFvzK+HSm7wt7i5yH?=
 =?us-ascii?Q?5Ai+kokj5X35qSVz5Ui8tEj6k3WhD4ibe6lsPdd1OPNz0y9UuVapky8JHUMB?=
 =?us-ascii?Q?+YiFFcQyN+4IQpjYENzlDqjirgea+ohuiQgVjMxFBPdUuFVIXqYpkptiFxJg?=
 =?us-ascii?Q?EbbbX4XMzLdvldLX8TFDBcrGyLB0b8QB7JdUImx/1T5qoi6Xcf5d942M0c2F?=
 =?us-ascii?Q?eMAjgAtQLHvyyprmPoGfXQTdrSAWWUCQZ9hT+BQj5qYOBa1tCGArjbFkJs8C?=
 =?us-ascii?Q?gpQaX5bJhcYyeDylz9g5w6WS8zD6ypyfWbC+5PzIqFJ7nXd33rz5Vz6JLiuA?=
 =?us-ascii?Q?cY4whA6sVL04d/Ldo2lrYfx0/8r/TQJIWFtT36oEmYAsKhyMOz4d3KjhN3CI?=
 =?us-ascii?Q?zukyGtQx7Nu1y9ZhxSWw/IoTCicmAX8ltVRP9xFoqpELqkdWcdrJ7i+UKjDm?=
 =?us-ascii?Q?A/D9Z0fPIFDuZUcDRwI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2490500b-3396-479d-f916-08db568892da
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 03:41:18.2311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeBc/mSr+IvIIyA9sPWBWG+NldKikOqO2ff9yA9rao+pWLL6kB8VvLWpGQ8q+2qsxJiVcaYxUS0zPSamJl0Ycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Shall we just force the mode-2 reset if it is non-fatal error mode? Is the =
gpu_reset_flag really necessary in such case?

reset_context.method =3D AMD_RESET_METHOD_MODE2;

Ideally, driver decides either perform reset or other error handling approa=
ch (i.e. unmap queue for gfx) in IP specific handler, while keep the amdgpu=
_ras_do_recovery as the unified entry for various driver mode reset as ras =
error handling. Is it feasible?

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Wednesday, May 17, 2023 10:14
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on gfx =
v11_0_3

perform mode2 reset for sdma fed error on gfx v11_0_3.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  8 +++++++-  drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h  |  5 +++++  drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c=
 | 14 +++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 6bb438642cc0..f2da69adcd9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2053,9 +2053,15 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
 		/* Perform full reset in fatal error mode */
 		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
 			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-		else
+		else {
 			clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
=20
+			if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET) {
+				ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+				reset_context.method =3D AMD_RESET_METHOD_MODE2;
+			}
+		}
+
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
 	atomic_set(&ras->in_recovery, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index bc43f7db17cc..46bf1889a9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -339,6 +339,8 @@ enum amdgpu_ras_ret {
 #define AMDGPU_RAS_ERR_STATUS_VALID	(1 << 1)
 #define AMDGPU_RAS_ERR_ADDRESS_VALID	(1 << 2)
=20
+#define AMDGPU_RAS_GPU_RESET_MODE2_RESET  (0x1 << 0)
+
 struct amdgpu_ras_err_status_reg_entry {
 	uint32_t hwip;
 	uint32_t ip_inst;
@@ -427,6 +429,9 @@ struct amdgpu_ras {
=20
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
+
+	/* Record special requirements of gpu reset caller */
+	uint32_t  gpu_reset_flags;
 };
=20
 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0_3.c
index 068b9586a223..26d6286d86c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -84,8 +84,20 @@ static int gfx_v11_0_3_poison_consumption_handler(struct=
 amdgpu_device *adev,
 	/* Workaround: when vmid and pasid are both zero, trigger gpu reset in KG=
D. */
 	if (entry && (entry->client_id =3D=3D SOC21_IH_CLIENTID_GFX) &&
 	    (entry->src_id =3D=3D GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT) &&
-	     !entry->vmid && !entry->pasid)
+	     !entry->vmid && !entry->pasid) {
+		uint32_t rlc_status0 =3D 0;
+
+		rlc_status0 =3D RREG32_SOC15(GC, 0, regRLC_RLCS_FED_STATUS_0);
+
+		if (REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA0_FED_ERR) ||
+		    REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA1_FED_ERR)) {
+			struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+
+			ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		}
+
 		amdgpu_ras_reset_gpu(adev);
+	}
=20
 	return 0;
 }
--
2.34.1
