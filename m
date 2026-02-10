Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132A0EA8129
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 15:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C6A610E1E6;
	Tue, 10 Feb 2026 15:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bRyrUSGD";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A8E10E1E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 15:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1D3Inx/gLfhcpPCeO18qfA4ihwLKDGosCJcpq7jHXB8+BE04F0GhIqueVEB66HtleIzeNrk8UhGkoYIaCXdSbj7WqumK2aHBDSTXO+m0jAMhhKr0jxB60lHxcndcnLax2QXgusHnmj+AVhTqnw7DsQcNa9GXwOt8aPvLWRcJ6+8/QJ512HwLkk0/ku8ad2ljsffM07NURpkFabDegVhXyYTpm+ZKNjs54Ia7mKvxhBeGZui2jy98eyAvKhNeAFLdfHmqFEKK+/8kp/vNSU/tJpRXgfQz4tBF84ure8GSsDV4bI4rCcHUHrxmFZWiusL8LNa+okEnkLqkay+8dokDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxI/58AnE/ZRo6ryRiqm+SuYN6rutMrGTQDhU9DdOxk=;
 b=Yt7eXIzuUhtGiHolECZ5rxEX88xLKPo02YKjRPJatwXivqTtMAw1HvKoPdXmT/CQHAsvMsNjEK2OuQKRqQf06MLceLmtH/CrWnPZt1g4WI8UDkOUmBfyTIQb5xyCsEqmTw3W+WziJI1jV9caSErhd7/LV9k1EmU6i9jcIsbBnlWnppavtZ+BPHxdFoolUQJRmFm4fDE6RnaWEyPUgE0Eu4iu1C7rVk5c02MmVzPDyzA+Q4PeuSZFtcQT1FRx6Siz/swgjBqvZMaOue2xRpPX6UdXHR0HXx7hR/MDStd2H5/d8owvdVSooVDXS34979DjX759ul906Tx5KzKobmJ8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxI/58AnE/ZRo6ryRiqm+SuYN6rutMrGTQDhU9DdOxk=;
 b=bRyrUSGDF5OB+8eTxAI7FTBA6PhoZk+rkn0Qh0BNJSC0aOA64AvENSAyNdc50tX3kOFpV1PiPXRWiozqcyAbpaYsoMVLnoHPjnznpKnNqSAGJ+QNbIsqkvobQX34Zssb9n9xKnjJsHBiQbIfXL6eN3zWRYM8X6pxyyueyzrRAI8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 15:02:34 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 15:02:34 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "Aitken, Will" <Will.Aitken@amd.com>, "Louis, Simon" <Simon.Louis@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Move xgmi status to interface header
Thread-Topic: [PATCH 1/2] drm/amdgpu: Move xgmi status to interface header
Thread-Index: AQHcl3Bhr9+MkdhZhk2vEnJKvIjZfLV8Dazw
Date: Tue, 10 Feb 2026 15:02:34 +0000
Message-ID: <DS7PR12MB60713FEF5403AD4FB86080FD8E62A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260206135539.3843805-1-lijo.lazar@amd.com>
In-Reply-To: <20260206135539.3843805-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-10T15:02:29.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM6PR12MB4404:EE_
x-ms-office365-filtering-correlation-id: b509fd9a-97f7-43c0-fc47-08de68b56bda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?DPqW0+3KGNMylJsY/uHmKsuSY1MnBJVjHormaWvRdvAu1a7FaodAbJ59EajQ?=
 =?us-ascii?Q?zxq7mVgaX0nurMj/5DlwbmKZW2WJThvECXj/lPJ4UpwnW6EtDCSVEWfKee+U?=
 =?us-ascii?Q?VCN/jAq4DUIOesoOwPWrp+f63G7yFzH9u2pkq8qz3xdIvAdkPMbsJvlUkC6U?=
 =?us-ascii?Q?WX8z1lL91FYAWQls7jHYN6/si725l2MMXelL+89GudeerWBBj5yYygeHttfL?=
 =?us-ascii?Q?69tiLjWqNq3pbzOb4W+fq5GkNWhjlDy2nStHN4vCu6J2IplJ53sQnr9PJ+Sa?=
 =?us-ascii?Q?v0HWWBoXzZGELD1YElp4p/UnSTH99iQN6L9uu0F5vFuuBFVxCK2lVkUPwSBV?=
 =?us-ascii?Q?4mNEs7atfO4zynW5xvmprQnwtOVEShCmRhc9WcNhxsABntg2iSIc4ZPo7xPh?=
 =?us-ascii?Q?zcwsJ971o6SryyaLpW/U1Szci+H6aDAWtsIE8xkZYwFlIecx2jhNOL0659R2?=
 =?us-ascii?Q?HnSvzATjicixOpvz+1zvp2He1L6pbCcnotHGJqR42wpqfxZzV7fh4DTYHYAm?=
 =?us-ascii?Q?fp5SsMJtU69yEv9lGKLL/kHaiJdZ5aGIOCUVHKSS6WvqypSMiUxUEG2osYta?=
 =?us-ascii?Q?57BXvdfNH89L5r6lV9DOpxDFdZACy0krjUbcE8VaabUch4t9iA7DpTOFBduY?=
 =?us-ascii?Q?J3syrYR0adgBhLx48mt2ka+wHZ2u4L+TAQxEqtcS1E9Cu78ACDaTRD45Kp4W?=
 =?us-ascii?Q?QaQtz8Zw1Lms/jbSpJywlvi6mO8QSuE1mDtr8Gx8njZ0SWKQPOdiPAmhIhxO?=
 =?us-ascii?Q?/dVpLNiY7SLuIPO44uZ3EbgIAUv6DQnX5rlGm+iBfOtxJSi/7CFNVYI+m7GS?=
 =?us-ascii?Q?LWj40GpC4a0OhDYVVpr7tbDVqitXZT0c2vCQIlp/JvGNkFz3RZ52GOhEJsxA?=
 =?us-ascii?Q?iaS1ztUAdOsdXI0MUh6V1RlCf/v4nMVd8i87MrYH5EAOAsCrkJ6jZUbTQYQ4?=
 =?us-ascii?Q?/Oqme+VGYRIZL/JzH1M9knYeqKvwGiDjdVGq4FMhq3DocLblnQyYHdr3uyL3?=
 =?us-ascii?Q?Vp74N/rXUGV1JePdPPI7b/LKpH1K9RMcY8QfYkb/1oiybyXh5O3gTLpUDV//?=
 =?us-ascii?Q?xNMmD8bvMAVS/jIfH/D+dbOoFxasQDc8/1jRLDw2VeS2tDcwtdtgJSBuhlDE?=
 =?us-ascii?Q?Hc3d49HDdiv5DBFFv/XZCSzOmV+LvI4m2vbQ4zqTv8jCQo/6eEO9PuP8CStt?=
 =?us-ascii?Q?PhPx0NXENg9DGQX5xKRX5d8tk6uQckN0rVkH3oG/dh9tlSeZUQPZoTPHzs9f?=
 =?us-ascii?Q?rRXscvFxsTcGchDskYkjLhWH5veaNbsSZkd75BWNd6PhiKUrudO7R7tObhfY?=
 =?us-ascii?Q?UbGAt+v6EUpmt9vnFXeNPaHyCvV6WdxFJe7hH+fc0/quUt5RgK/jVMPCHJD0?=
 =?us-ascii?Q?yWTx7sBiDCNqAfyTqySlhbOL/VKHYFRfmdq3/OCQ3WA/zQpNX+CvKIUVItP/?=
 =?us-ascii?Q?cOxpMMTAZ5pRKpWYmKgtUkT/Ipn24u+hbm2R0YmvF+E2TdgeD3jCyO39057q?=
 =?us-ascii?Q?YnSlncQO92Vp3iq4mXNPHDpcpctSFNfHTUr837aOTJW1BTgW7SoKM3zaocEU?=
 =?us-ascii?Q?J6FbFhvTzrl50Sl7QBx7M9mD/tFd2P2Bqfhc0Uv8L6O5fLeRrYVKeVvqCvHT?=
 =?us-ascii?Q?UbTol2G9jPmJoSdhkspRgJE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TnCl6P84Ou7AP3TElZ8L9LXqpK2OWjuYwqUUEzdYKTQfPuhyJJ1azV5V1i1N?=
 =?us-ascii?Q?yQX+mHbSUfrLtAULADpcykWFB14YrJeN83IO8WXb0NtM1cU6CRLvdW2VPSlv?=
 =?us-ascii?Q?vmm6BrhrMLxHnsMCnnVwcagKvW35onCJKl1kjIp7c/Au6I3QOBts4WarOA0D?=
 =?us-ascii?Q?/Q0WZY78qn1Q/Dk9rCwtrICyP4LvxU1/d5JDW5qTYvHkDad3j//SAj91oWCC?=
 =?us-ascii?Q?MEm6BoINHOT/yOJPSL5VtUkMMtXM099SDrqzeDXXrY4OoAPnRRh1fkQCFQod?=
 =?us-ascii?Q?frcFJdDGes1bOL4Al67g1/7q0ZawvzBcU/yWCz3bNESJ15ZEwBY9hrPVxvTf?=
 =?us-ascii?Q?yVQYs4U55qkoyzwtI+ehZmT0tLpBz1arzOcXDUYRT4MJb1vgDnc7pLPiMr8V?=
 =?us-ascii?Q?BUeoA0KqvPPi4Mi+9Tvu9iXY8Sv137TDufPdZd1npIpcTtRfhU6CL9rIlBf1?=
 =?us-ascii?Q?g/k+pKvuccKXHWLiIzXs1lRLIMsVpwU22BXKcc0koSOSFOXtx1uKynl9or5B?=
 =?us-ascii?Q?y+aTilyWVzDIUSiMPcH6OcpANtEXKdwoL/0iQkGnG1GWO0Csm0f/aHaFShnc?=
 =?us-ascii?Q?Iyqx+x6Aw0ObDboWqn45F8nEwqxrSgQ+V+FA7Rotmy8naW3XM4RlHM9cWVL6?=
 =?us-ascii?Q?1K8+350bvx3fhFfCiMCvGdkRVCHxXCKsRoiwrACll+IPv37vhxmXSXMCf2Fw?=
 =?us-ascii?Q?Wx7KkolE7R+c0yaDDX4hoQdsn1FFk6vMZpe9eeRCii+YkdBHZ+UOfgNeNsn6?=
 =?us-ascii?Q?D3fDwFuQ5uTexAlWwyPsXavOfzNKRxklkFxi3pyFGs67cCp+wtgsecds3ZOC?=
 =?us-ascii?Q?kU9Cb02vBAhd+LXfJGggx1VWQ4ckcDrxbWXYzmhBCbdOcgJZlJ0fB8wWMN11?=
 =?us-ascii?Q?LcLuUVWY9aRfT/futREoFCE37QX1/7FGfS8JQZFJjt8n0/zGdvhRhXa2n5Hz?=
 =?us-ascii?Q?nOtxwGgz6uZ9WiipsAOByhr3b3mC1TJB+Z/Tl+q6loV0KFJbBBa8gMbsJ6xH?=
 =?us-ascii?Q?BzM78Rgv56b/IdlcZzpFdoqdJt+1Oh1rcDMRPOEJQX4TjBaLhkYTF6MZMAlJ?=
 =?us-ascii?Q?udsXWYriHR6VABqmin9zouuyX08goEbj+9KPyXW4cvm+xNVIfqnamnSBtEBi?=
 =?us-ascii?Q?yhER025sPzzQPJMmXMpQXn0usiRQOBlj8RbyvOjWBiybHaxpIlG5rTR2g/i3?=
 =?us-ascii?Q?7bJSdA5NY9M7usz+p4iaxP5MTLraUin/hkKc2Z1EFFz9NOUyNZEIAVjcm3gj?=
 =?us-ascii?Q?ER9frkGy+GO6Kk1VK2diZ/oGUgJbylQVwN4vfixQYRcaz6ZnKhtwf0cbUthP?=
 =?us-ascii?Q?791PGKnRcBJ50G/q8cZ8FGFEmcPLvMPEXlY1//gDM8ZFLpy9/Wm+U/UwBTt7?=
 =?us-ascii?Q?K7AgNPWPdCwf9aJ6l7ikAruhwcO0tdFa9a4aQR3A32+OI65RNiQ8YWGdqfa/?=
 =?us-ascii?Q?bXJXM0LHVlw/psesb1RJA3WJGTzvgQPtB3w9ejeBDtxxLR1St4bc0Q2qQiAt?=
 =?us-ascii?Q?ITy0JI18TH92djWqC04Eqzeg/wQ8hEPnlgQeBPvi4xL2XK+LdY531IUX8hFF?=
 =?us-ascii?Q?TBuvJG97N9Q0lYqUNqYN2t7lKVT2ah5QGUrR8Wd5Rm9D2XGDw98RZroP98z6?=
 =?us-ascii?Q?0FOWtfQe8wtsjZsdwLEVvglzcq9fQc77qNLAeYMUd5JlH8EG1TWYXwrHElYF?=
 =?us-ascii?Q?Y5QSVbc3WlkQ7bzJsSxrR3fKCPS8HDCPtxkYcwW26Lfx/N2g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b509fd9a-97f7-43c0-fc47-08de68b56bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:02:34.0944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MttI4tapTDDZaCLVOgVXr6QWYz1heA1EmocZcbDmpXVOgNR7VBEuBWwpXW/OnfVLxnz7MxUFVnOAg9JiyhV15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, February 6, 2026 7:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Skvortsov, Victor <Victo=
r.Skvortsov@amd.com>; Aitken, Will <Will.Aitken@amd.com>; Louis, Simon <Sim=
on.Louis@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Move xgmi status to interface header

These definitions are used by user APIs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c       | 6 ++----
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 5 +++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 9e32f343097e..0ca6fa40a87c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -42,8 +42,6 @@

 #define XGMI_STATE_DISABLE                      0xD1
 #define XGMI_STATE_LS0                          0x81
-#define XGMI_LINK_ACTIVE                       1
-#define XGMI_LINK_INACTIVE                     0

 static DEFINE_MUTEX(xgmi_mutex);

@@ -365,9 +363,9 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *a=
dev, int global_link_num)
                return -ENOLINK;

        if ((xgmi_state_reg_val & 0xFF) =3D=3D XGMI_STATE_LS0)
-               return XGMI_LINK_ACTIVE;
+               return AMDGPU_XGMI_LINK_ACTIVE;

-       return XGMI_LINK_INACTIVE;
+       return AMDGPU_XGMI_LINK_INACTIVE;
 }

 /**
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 9fd78fcff15c..6683ffd6aa68 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1829,4 +1829,9 @@ struct amdgpu_partition_metrics_v1_1 {
        struct gpu_metrics_attr metrics_attrs[];  };

+enum amdgpu_xgmi_link_status {
+       AMDGPU_XGMI_LINK_INACTIVE =3D 0,
+       AMDGPU_XGMI_LINK_ACTIVE =3D 1,
+};
+
 #endif
--
2.49.0

