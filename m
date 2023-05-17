Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66E1C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 03:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108AB10E395;
	Wed, 17 May 2023 03:59:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E60810E395
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 03:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRpmKCjIgT7Kv5GL/NI8bbSO6b0ptF9/MzHChXknj9gNFbYJ/jRYv/+3JBeeSUzpBP2d2PGLiO2Mxb5Hjjx0YsBwmFk1WPsZ13yyjfi6aPaJifMvODfJI6MdUxOw+AB3H60BP9ZVB/j+Aw2uUfwLnHosa71WcMiHMZAfSy+/9rnCPqWDxsxxSyxgACYSQsVB8Ob2ujtUU1fRL8XStnNZzlMTwWjikww8t76TDTlhB7EkTJBr5LkbFrAxyB03lMIluOe15n7aT/CMlGckmYoaULvPJQTxownCj7vI+9LrSpUFZ30ln7/ZUYX6QRQ66yZHbbOEMUq/Eh4RODzZ+Gvivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCmYROhX18eKM4ZbB1SsntCsbt4XkmiKoHpdxtNmjqI=;
 b=ks+IMo65E2OIhOdcJmf8LDjdInw900MIL29BomlxlbT2I/JrBhoZ/I0g6SS6swa4j0O+fEgLN1fuSq64RI7Q8v8DUdqUwpP9lp+hsJuelKl4vYYSwZaDFqkszWXv2b/R85iYACplh1UQeuMdW/O+0Kd2nqkLXEAQBOzgnUzZoo9fSdl+f6AkSCHmFg7dYoYvbJ/bGRxAN/2Db3u+BH5jc87n2xEgc4LSCg9/DPYc0jL1OiFqgbln3vv+Qgu4j3RGZfAMXPNoupP7fQEMo3BNC3srsLlCdQkSdxtV+4PQvXoVgD6s2fWuS6sobezgU0X6WM6ibg2pNIzjSZ4ZyHbW/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCmYROhX18eKM4ZbB1SsntCsbt4XkmiKoHpdxtNmjqI=;
 b=uYdV5L/rLopG5ElLiux9RebtnHas2XIP6+0f/DZXPerUT3CEJI9cGtLd44iQ19GOSnWjYLzN8ki55L6csBo4hmh1gYTtgE/8kSYvqK0dNk+qIOGKFIfzYfqxFCytlGntJ08bdzHWUZsMzRi49BardVGnqdB+oLjGDirEJYPGmHs=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Wed, 17 May
 2023 03:59:35 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::6fb0:11a4:1f00:d8ec]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::6fb0:11a4:1f00:d8ec%3]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 03:59:35 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amd: Poll for GFX core to be off
Thread-Topic: [PATCH 2/3] drm/amd: Poll for GFX core to be off
Thread-Index: AQHZiCJttQYGlNsugE6TMjr1urb4HK9dw7qAgAAOjTA=
Date: Wed, 17 May 2023 03:59:35 +0000
Message-ID: <BY5PR12MB387339273C962D2541110876F67E9@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230516175214.3491-1-mario.limonciello@amd.com>
 <20230516175214.3491-3-mario.limonciello@amd.com>
 <BYAPR12MB4614D9DE08BEBE6A415940E0977E9@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614D9DE08BEBE6A415940E0977E9@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d46fa2bb-f27f-44a9-b4aa-c12ecd75164b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T02:48:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|CY8PR12MB7098:EE_
x-ms-office365-filtering-correlation-id: 6f707aec-c90f-4e48-b923-08db568b20c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YxkS+rsAOgR9/BoC0b6NOEUMJZtJOyAKXgjsNc110TwFXmhM2KXnwRZ+VoiD0k9UBsBMWO0tldd1pQATh7ywSTwGNLrbX7xzFf9KyoYj48uGs+CJaBGQX8zfqhKv5Z2OaviJ8pVnVUfHyzvYIbP2iW9iCnjm5QGHh9xCIzmMTPifChgfkp5PWJgJSE0EXAzhf30Vliab4MaAIfZlWePUg78nYo5Z0/M4T5jp5LSzglkq2olVpZ57B3G5Zt9k07/SFS6PZlNWarHkVgx0DnRjNK36hqy+Gz/rNJqTxOGjp81P9yrxyo8Zb3iXXXOBu87qQDEN/fG8sdjvq23425x4JH0/0OTOPk+ynlx9C4UneuRilbC6dxIymUskXJsszGF+P7csbnXPT4ZuqUey+fEnmsd5F8W4F62QLG5ENUZGwRqHNGFbSNV0MW6k/D94Bkcc+VPig4lduYGN61vV7sDvYSyAM19zJLt1Ef42E0NsNkpzrTzpcHoMjZsaKEZ9DdiiyQ9lu7NBRhAIVX+vlpHwaA4BN3647V9WbpII/NB56apxhv1neCR83T4AY/5jYrs4enb712zuJ+Qjj0fWtOoOIAMfqWRAF5Ar5YNOVFqhFvHdAqNCymyi2JX9dV5pQyxb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(478600001)(186003)(9686003)(53546011)(55016003)(26005)(110136005)(33656002)(38100700002)(83380400001)(7696005)(71200400001)(6506007)(66556008)(8936002)(4326008)(64756008)(316002)(8676002)(122000001)(86362001)(66446008)(52536014)(2906002)(66476007)(5660300002)(41300700001)(38070700005)(54906003)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C8t/XIEwIg8KF7EQcOXttH07ZgD4YgYEG2DmGfcmelfZ10BMLurKfAIMOkTJ?=
 =?us-ascii?Q?77rhuO8mql4+BK5V7ue9j8JrqCRWb+rpeTQ6YQHYDN8BQ8B2gtZjGqktOHVH?=
 =?us-ascii?Q?yVWAxhr9GbvEpO39tOiXgwWxQ82JMD44xAphgHO1WHXEYBDC93dh0U84bG3T?=
 =?us-ascii?Q?ZB4pZCJnE/6Jhxu6IF45ugYJ1V0f1ac4KwmfjFqqqy27gzIsoTSDJ8aKvXCN?=
 =?us-ascii?Q?LTcotnAAwh7KPy8IW5HcbfY29CbTMa5qXkDRPhBPRGyLE8dKDDf2tW7uaP2t?=
 =?us-ascii?Q?PbDFPG+9WG+rQGYcV7U32dHzHQ9EB/IXAbjvWqnD4reBAi6QlnOYrDRAjWPe?=
 =?us-ascii?Q?hCLW5jAZ+DKJeTrlwsrygsjoSpHgPgEzPSIeA1ddd+b9g+cTMengLS8TRnvw?=
 =?us-ascii?Q?CxeGTMXV1jEoZTt070nKfqAE6tALEWLfcL16SL0VwW3PzpId8GdfxJhhRc2L?=
 =?us-ascii?Q?PtO+cGcZDYFOg+uPMabatfttvBUCK8lRStZRvA7pataH5AdOVPfv19/MYTZm?=
 =?us-ascii?Q?NFvjpDR6mLm7bkGbLxcjXMzWhgxVd9SLZZAgBP9zEVc7d2Y7kdU0g+gasRDC?=
 =?us-ascii?Q?yugcrm26FOqFrNnmbxa7Yw/Gr9hoBrSGUiqtcwLC65aLueIiSMMNY1cThjo7?=
 =?us-ascii?Q?sLp/g6ztjjII0uK2rSgM3hqnSNLwJc/eCehBbfDWiyQCUTShTGd3axLhnzSq?=
 =?us-ascii?Q?EXEKLfqoN+K7dG13YYSaYfN0bL2TUm1ZSx7CsFY9VU0Y2rLgXmEME8V1HDqo?=
 =?us-ascii?Q?U90/HfcY1B2IIRHRlb9L6EpZ6BRpymvOmfxU5m5ailKc5rkvvLy8ZAD0BbFp?=
 =?us-ascii?Q?UChUqm1mOY5INGIhaZ86mLHzqXn2G5Faas4rFOPTWWZXDL/5MRCh2ORmaViR?=
 =?us-ascii?Q?DpZSzTqT8rPtHwC6619Bqr+6ipxWSJW8tYH8UvpgzaChyDSWaBNrAvDA8lT2?=
 =?us-ascii?Q?kfpCFKykerptsKG5Uj9k6zTj9+DHSIxqVEvH06KI+TNGkSQIC2wiXnRrZbA0?=
 =?us-ascii?Q?dWDAZR+B+ODqUSY7xhFhpQgA1unXFncO3FHR5jGhwRylg00pXmv/BffgE59/?=
 =?us-ascii?Q?L8FzK8fSTW/xoGO2UbfWhvBfwPy6M+tSA0vpVkf8vxKJRnUF50BiXd2z4+UY?=
 =?us-ascii?Q?mEnndUYaTLFkfCekBj70wR58WW+Pk/EqydIoyEHph1Dg9+e5Nbpcj+DJddiB?=
 =?us-ascii?Q?Rl3KhFUYOLDfgnsaolGgaQ9eNwXGI4CUnVlUCk7Wse4Gg8A7qOtW6p2sQ1HC?=
 =?us-ascii?Q?4R6QcbpstHtLTNi7hBooJJFycTo7Ua1brjv0TyrMFqc+QToaGY0nofgde/Yn?=
 =?us-ascii?Q?VtHKrWLHCzqW+IjfGKTkiDi8hoyL59Hynmtaa/KtgizJlUHK3c1Cw+MWgKYX?=
 =?us-ascii?Q?yaYHh5BoS14qYQYZmTzv1s+8LrYbMGWrdh4RrVa0Jv2XxaAjXYWSBrUfOE9e?=
 =?us-ascii?Q?Lv1qffUAb/J0YcRkhI/ob1yBDbr4a5beR3CgpvTV+G32yZt0dL3x/tulD1Oo?=
 =?us-ascii?Q?HAc8RizsgAZH39gIzBOuLMqwjLtKXWc5U3DB/EwHE7wItGXDfiz+ay98IGAn?=
 =?us-ascii?Q?u6OWLTjSOP3LSLf/qI8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f707aec-c90f-4e48-b923-08db568b20c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 03:59:35.2879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEALJNPU/ryIEDBb1oAQEg0+IhaPmgNUOJOE3/V8bA54rmv6kJP5DjUJl11AmYcLP19Lx3Euybg91XxnQFut0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
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
 Juan" <Juan.Martinez@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Gong, Richard" <Richard.Gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Lijo,

Yes, the GFX_IMU_MSG_FLAGS is outside of GFXOFF domain. It can be accessed =
when GFXOFF is entry.


Best Regards,
Tim Huang


-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, May 17, 2023 10:48 AM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Tsao, Anson <anson.tsao@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Marti=
nez, Juan <Juan.Martinez@amd.com>; Limonciello, Mario <Mario.Limonciello@am=
d.com>; Gong, Richard <Richard.Gong@amd.com>
Subject: RE: [PATCH 2/3] drm/amd: Poll for GFX core to be off

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
                container_of(work, struct amdgpu_device, gfx.gfx_off_delay_=
work.work);
+       int r, i;

        WARN_ON_ONCE(adev->gfx.gfx_off_state);
        WARN_ON_ONCE(adev->gfx.gfx_off_req_count);

-       if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX,=
 true))
-               adev->gfx.gfx_off_state =3D true;
+       r =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX=
, true);
+       if (r) {
+               DRM_ERROR("failed to enable gfxoff: %d\n", r);
+               return;
+       }
+       for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
+               if (adev->ip_blocks[i].version->type !=3D AMD_IP_BLOCK_TYPE=
_GFX)
+                       continue;
+               if (!adev->ip_blocks[i].version->funcs->wait_for_off)
+                       continue;
+               r =3D adev->ip_blocks[i].version->funcs->wait_for_off((void=
 *)adev);
+               if (r) {
+                       DRM_ERROR("failed to wait for gfxoff: %d\n", r);
+                       return;
+               }
+       }
+       adev->gfx.gfx_off_state =3D true;
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 4b7224de879e..dcbdb2641086 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4434,6 +4434,23 @@ static int gfx_v11_0_wait_for_idle(void *handle)
        return -ETIMEDOUT;
 }

+
+static int gfx_v11_0_wait_for_off(void *handle) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       u32 tmp;
+       int i;
+
+       for (i =3D 0; i < adev->usec_timeout; i++) {
+               tmp =3D RREG32_SOC15(GC, 0, regGFX_IMU_MSG_FLAGS);
+               if (!(tmp & 0x06))
+                       return 0;
+               udelay(1);
+       }
+       dev_dbg(adev->dev, "GFX IMU is %x\n", tmp);
+       return -ETIMEDOUT;
+}
+
 static int gfx_v11_0_soft_reset(void *handle)  {
        u32 grbm_soft_reset =3D 0;
@@ -6109,6 +6126,7 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs =
=3D {
        .resume =3D gfx_v11_0_resume,
        .is_idle =3D gfx_v11_0_is_idle,
        .wait_for_idle =3D gfx_v11_0_wait_for_idle,
+       .wait_for_off =3D gfx_v11_0_wait_for_off,
        .soft_reset =3D gfx_v11_0_soft_reset,
        .check_soft_reset =3D gfx_v11_0_check_soft_reset,
        .post_soft_reset =3D gfx_v11_0_post_soft_reset, diff --git a/driver=
s/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared=
.h
index f175e65b853a..ce2e2b6fd6ff 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -298,6 +298,7 @@ struct amd_ip_funcs {
        int (*resume)(void *handle);
        bool (*is_idle)(void *handle);
        int (*wait_for_idle)(void *handle);
+       int (*wait_for_off)(void *handle);
        bool (*check_soft_reset)(void *handle);
        int (*pre_soft_reset)(void *handle);
        int (*soft_reset)(void *handle);
--
2.34.1
