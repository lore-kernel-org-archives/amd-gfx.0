Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1EEC77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 02:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFE210E38C;
	Wed, 17 May 2023 02:48:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FAF210E38C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 02:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpGJT/1KfnDEzyB6m4TzgVSLPLGmSH8T5ktmQyFo4P6/+hoOZIDxE2Obyo+w3sewMhUmQcqzVPjkwTdPYu1EDrbgSXC2h4SU/G9yKwfgKTWo3pW5YPScrTRB13BEmYqzavxrhMpJ5jCOmrLl1N7oB72M7aLu4oqlHqWycTcLZKYVkA2lZANCMoV+0AjPp29C1Z+WL+e06oVSC14yVIgAYtf+TwNauxKojFMaFeXDjogp8obVMf2OuR7iINm37kkawG59GPxlP+kdIZ1HHphDk6awZA0vMEvU9ylvAQ8RKWLZo+L+iOwc+Cg+nIOey7aQqOuZBkfvzwoeQENfKX9dfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozhp68ofPKHVGWj2eDi8Q9CTOl4p9dgtYmFP131M8rI=;
 b=TT/iMB09KjmpyKYDnNYQjgtB3wwrMAl+zROnP6iDMy5evs/6ZJNkhr8LzoyRDstVT3S0J2NqnTFIZp+THD1yl8grM009lGXa/eKs1mIDe3Z9vrYDlo7wj32s/FxMomFbDR8jTqRZMdKUmZ7SiOr9mL5W2B9GbySj+iJS0UKixkWGyqDP8vvvWk/AhSKBZaM5KoxDZOuffj9WS9iK2LGl59OMhnnSfQWd0NlUNy/eFyl/L+osmtIV8i8nk3udzHEnqRvTSM0/reWvAIQoFllOtObgbVRhh0cI3LWd4wwiGEbQQpcJqLBq6eBbPvqs5TWhN0yKdbN5Zs6WO1pRLs1icw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozhp68ofPKHVGWj2eDi8Q9CTOl4p9dgtYmFP131M8rI=;
 b=WZya3/X5ldknxlGNqJe2UFPjwOSYKjY42xch6kW6hFEEePqbSpnsvHpEcu0yIH7hzU8jwmndeENKtbAnmVDdB+QJQW7329JzpcEcnFgfSl3zMS7Xb26Iytj5wHI3b04z6TLnQGZ2xa0NCqj05QAbGDZ0Ka5um3SzlcGMg9ZV60g=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 02:48:10 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 02:48:03 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amd: Poll for GFX core to be off
Thread-Topic: [PATCH 2/3] drm/amd: Poll for GFX core to be off
Thread-Index: AQHZiCJ0KTSZu8aw8EmDfO0U8hqHX69dwg/A
Date: Wed, 17 May 2023 02:48:03 +0000
Message-ID: <BYAPR12MB4614D9DE08BEBE6A415940E0977E9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230516175214.3491-1-mario.limonciello@amd.com>
 <20230516175214.3491-3-mario.limonciello@amd.com>
In-Reply-To: <20230516175214.3491-3-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T02:48:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d46fa2bb-f27f-44a9-b4aa-c12ecd75164b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-17T02:48:00Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9192f0ab-55f0-4f50-9f13-99908688331e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|DS0PR12MB9038:EE_
x-ms-office365-filtering-correlation-id: cb35ffbb-162b-4bb6-c1c4-08db56812284
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ATYCpxXGVp4ctYvQd6mNaE978WKZKC5qjxn6ONYvYtTcUJ2+cjEvrXhve9F3l1cbEwjNrtEtJqigUJB5ZzmEBxJJBO1MMO3/lp0UscyWcn9y7s/ohB5G0bWHr3u8DdPuLOXRnT8Av2bJAQLbfYNu7QdfBu5d7WHmJH58eJrGl6yPEQ9w7YQFhUYNmRsxEKHG+ulviBozX5xJcj1Enk/Ttjd9TLMGyKlp//eMGiEj5rXP89pLLQu6pG+xtDMVovtrhyqwO0R/+i+nshRffrN+vKa/9f/M5n3nyBwBYayLFZBflfwExHT9tzA7lCd6YuaA5ecvWjZMaLQ9w7LbhY7+sUSUxVarqrmCjEMQ47g1EZRqMihoaI/uBan3EXHIi+rk2LcV02Kk6jUtqkTldX1PzlHvA94B8oDk5F13CGi/DjWoGRpyqaH0OLixpdEUDda406N8oSrHsgG8JC/mmA+06OsHGhzxVkoXJ/wLPXebHg6rfbfuOm607ESM6pdXhn23lttR84CFOFIYksJe7jgS0oNyOAj5TFuevd6WGwPJae3Y+pMx/MT9NWPy/Sko91lnJ3/3SKLm8/MclE5D25To2IBRPmcLrF3XYQsPGcS2VRJCWHgdi/EiuWw5B7Bb8b+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(5660300002)(52536014)(8676002)(8936002)(6506007)(186003)(26005)(9686003)(83380400001)(53546011)(122000001)(38100700002)(38070700005)(7696005)(71200400001)(478600001)(110136005)(33656002)(55016003)(316002)(66476007)(41300700001)(66556008)(66946007)(54906003)(76116006)(66446008)(64756008)(86362001)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wcl/G/yZV2smIdVwAkkaopz1sOnVShjGknYQGGLmtm7jck9ZbmbkvAhIZSTq?=
 =?us-ascii?Q?Xvva40DeOY9VItf6Al2SkLXqBtu1r4w1ajMDYool8R+KNPbXTnu6Yo7QGr0h?=
 =?us-ascii?Q?COQ033u6l06FPFy+YyrZ2KuSuI2EyHVYsHKj774Ed16JsqiAU7PklDt2macV?=
 =?us-ascii?Q?Q7Uw1YBoc2OAWTtP2wGRdttEpo9GjhHXp80h5KujUbUzv1hTfOCN+MtJlmht?=
 =?us-ascii?Q?xQgL090uLYwwECfpeQ+TD9VClUIJyLNftLOFhvnQ3rK8lUsPiNOBS4CLJA8X?=
 =?us-ascii?Q?Li53zCpDrdobleB7ucvAXvsdXrvK7WWge6jOC5O8fliBLDbvbkSo9cWxgORY?=
 =?us-ascii?Q?Tv1p5wGPQq7fp96rlYjFJW6GzxSnIydlZOvX/hUNApXvWmuXYZAqXnNZ1gn4?=
 =?us-ascii?Q?zYZ/iVYjO4e7bMIAuh1ThNotXzCwM+2g8WJvpEaU/XmuI8LvGImWZTm6s1n+?=
 =?us-ascii?Q?M//PwcHb/fSdllAKMcDs+ZFh44NJK9cfl63aCzPPaP3D+PE4nu2hl47i4YC8?=
 =?us-ascii?Q?K03+bqcdoeNNfsmHR/s+VU+HeGy3Ic2kHBr7K7R2Jv6XW72swcFu79lQTIfm?=
 =?us-ascii?Q?uFPaev8XsJ2Xu/Do+8kz/3lX57To+in7oe8uod/95Rfs5+NUElOW7zRl0eGI?=
 =?us-ascii?Q?xiV8Wa6HJ2Z59w4/3WmYFVyTiTkiF3r6oTKIy+ep7zNUy0MpOHw8ffhL/A2C?=
 =?us-ascii?Q?8DUQ2M4A8UC4SiJht2crznu7AarGTdE/wyMfsL1+pNphaGRXZ5gY7TkZJSTy?=
 =?us-ascii?Q?5z4czIhemyYhl+5qFx0eYV1PyjpdSZS2kHV9kfwpJpFSRjZ11h4kOCZqhSJH?=
 =?us-ascii?Q?08YJ2mdr7oUvp1Qc0GUB3OgnR6Qrp5ql7i05pu45pU6AL+FfHbWRifOcYxgu?=
 =?us-ascii?Q?hhqQWE9oekgrDzKQt+oePHdv+/euxczlaTWVn6vpF6p5fY3AwV+OkB/Z/3Vz?=
 =?us-ascii?Q?MH3XCbBSYBnZg02aeV6JcSn4nzuz9788uYNhd54myFIiL/3vHp+VkMzq0dv1?=
 =?us-ascii?Q?JQ9tvv0sjEhR4kL3VVC8DdMIFJ6mEJqOfRyLzLzhzLIyEFvlu4GM5A0aOX2k?=
 =?us-ascii?Q?+9SJiBLncxpEHJnKvcp6s3emvlLeurbdJ0Wql5tQwez2fGePVHfHiVSjLBCm?=
 =?us-ascii?Q?iaQZGBJoSuU/tTDFOm6JnXJyQHWBe6hYTaoJKe5BuOSo7kzp/1JPo9mEO2Ld?=
 =?us-ascii?Q?tE7Iwmb+LezhFSiS1jbpF/WF7AqUZULIQq5uk7pJTwOvQ82eGNY/2MA3Vk5y?=
 =?us-ascii?Q?O0vkX353jZGmjb9YtSO7LK7JMgb0eC5Oz49vPJxNCsvvf+xnZew7bxoodpRX?=
 =?us-ascii?Q?OQ0Pr0KyJ3fjvS+7JxbMksgnPAwmb1rnHNYHnt1ArpgIqqhMqNnePMSLIwyP?=
 =?us-ascii?Q?cKm36aFjKjzsgAGnQa2Dc9s/rP7GYTZiOBEX8Fvw8ZIRWUWtPTKYperekQPA?=
 =?us-ascii?Q?dTeZ8t3Ek2WqRx5xbnabLrfbbPPKrqzgywe3pg/tTRzyxe/wn0xlcp3mGFEN?=
 =?us-ascii?Q?cpgaa/b2+zVJDpC9xQzPjxgPGluI6CRs4RS3sN0kkdA9WxCoFGchCJzkq2wg?=
 =?us-ascii?Q?Ujf3/+dgc0ySwSwaD5I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb35ffbb-162b-4bb6-c1c4-08db56812284
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 02:48:03.2419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/6M3OwAGYpHfJHC3/32BjfZbI3hphdwTWVlB8mFm5q7zyNPJkUVxyeMaNBugJB+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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
Cc: "Tsao, Anson" <anson.tsao@amd.com>, "Martinez,
 Juan" <Juan.Martinez@amd.com>, "Gong, Richard" <Richard.Gong@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Is this register GFX_IMU_MSG_FLAGS outside of GFXOFF domain?

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Li=
monciello
Sent: Tuesday, May 16, 2023 11:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Tsao, Anson <anson.tsao@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Marti=
nez, Juan <Juan.Martinez@amd.com>; Limonciello, Mario <Mario.Limonciello@am=
d.com>; Gong, Richard <Richard.Gong@amd.com>
Subject: [PATCH 2/3] drm/amd: Poll for GFX core to be off

If GFXOFF was flushed during suspend entry it may take some time for GFX co=
re to be powered down.  Ensure that it's powered off before continuing any =
operations that may try to utilize related IP. This avoids hangs from stopp=
ing RLC as well as problems with fence interrupts timing out during s2idle =
entry and exit.

Cc: stable@vger.kernel.org # 6.1+
Tested-by: Juan Martinez <Juan.Martinez@amd.com>
Tested-by: Anson Tsao <anson.tsao@amd.com>
Suggested-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 059139f1f973..17fc053405ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3055,12 +3055,28 @@ static void amdgpu_device_delay_enable_gfx_off(stru=
ct work_struct *work)  {
 	struct amdgpu_device *adev =3D
 		container_of(work, struct amdgpu_device, gfx.gfx_off_delay_work.work);
+	int r, i;
=20
 	WARN_ON_ONCE(adev->gfx.gfx_off_state);
 	WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
=20
-	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true)=
)
-		adev->gfx.gfx_off_state =3D true;
+	r =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true=
);
+	if (r) {
+		DRM_ERROR("failed to enable gfxoff: %d\n", r);
+		return;
+	}
+	for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
+		if (adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYPE_GFX)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->wait_for_off)
+			continue;
+		r =3D adev->ip_blocks[i].version->funcs->wait_for_off((void *)adev);
+		if (r) {
+			DRM_ERROR("failed to wait for gfxoff: %d\n", r);
+			return;
+		}
+	}
+	adev->gfx.gfx_off_state =3D true;
 }
=20
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 4b7224de879e..dcbdb2641086 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4434,6 +4434,23 @@ static int gfx_v11_0_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
=20
+
+static int gfx_v11_0_wait_for_off(void *handle) {
+	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+	u32 tmp;
+	int i;
+
+	for (i =3D 0; i < adev->usec_timeout; i++) {
+		tmp =3D RREG32_SOC15(GC, 0, regGFX_IMU_MSG_FLAGS);
+		if (!(tmp & 0x06))
+			return 0;
+		udelay(1);
+	}
+	dev_dbg(adev->dev, "GFX IMU is %x\n", tmp);
+	return -ETIMEDOUT;
+}
+
 static int gfx_v11_0_soft_reset(void *handle)  {
 	u32 grbm_soft_reset =3D 0;
@@ -6109,6 +6126,7 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs =
=3D {
 	.resume =3D gfx_v11_0_resume,
 	.is_idle =3D gfx_v11_0_is_idle,
 	.wait_for_idle =3D gfx_v11_0_wait_for_idle,
+	.wait_for_off =3D gfx_v11_0_wait_for_off,
 	.soft_reset =3D gfx_v11_0_soft_reset,
 	.check_soft_reset =3D gfx_v11_0_check_soft_reset,
 	.post_soft_reset =3D gfx_v11_0_post_soft_reset, diff --git a/drivers/gpu/=
drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f175e65b853a..ce2e2b6fd6ff 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -298,6 +298,7 @@ struct amd_ip_funcs {
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
 	int (*wait_for_idle)(void *handle);
+	int (*wait_for_off)(void *handle);
 	bool (*check_soft_reset)(void *handle);
 	int (*pre_soft_reset)(void *handle);
 	int (*soft_reset)(void *handle);
--
2.34.1
