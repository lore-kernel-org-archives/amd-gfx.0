Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C831C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 13:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B7E10E6BF;
	Thu, 21 Dec 2023 13:21:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E447A10E6B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 13:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czPociB+kwMWiqgbadS9H3VcGeS8/vbJCukqxqYG6BY8PnkOTX4UaabzXq3EnQlyXPDbpdLCf5fFT6s49HBHOv6G77Gg56lTsqqIXhKXSWw+RFt8CBmhZ4BpesLNixI4IIvssxBhE3KkbEsOLhxve4q2PNEdCYUtxRCdRzwGnAvVEiWNQUV873dyE75S45MU8H07J8CAR8mM3IDF8wAMqGfUKBo2x1yBo9JUJNoeVfCHtpzmSgkst6dVpB0tFzAfdN+sj7VTc6f8kQ7Iv7Tf5RTWTcjTMvgqf+XDmyJoMK2F5uZKrGcxIozYiW7VnwAbg/NOTcv5YyZFSbybMt8rTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwPi/PmZl/XaKbBgTADVv7Fo0TK4Z0fcaLULqqKThPo=;
 b=gjoLyL6uhIeJ0ipv/bEXl9R3s6+daGc95hMamFnhwOUJoGuEYG6GhhrtUx2ycx4X9JRN1Oy7uB+kSjx8vNGcAkl4qC7eMQfyTTRqJzRwwsW0V0sD38WuI3GXdv3WomV79shxbDjYnaNbMwSlR7tMjitJrDq8BwjxXM4Y5sNL+I1ayBaW7iOUjN4dx2Xk087X2Ut96XNo6MTsEBLzIXpql+mmjHr5zXG4D7UUD/2G32lk9zU9PAUuUngsA1m1wIsS7jlKMKsGDxgPzu9UIqhkvBSihDr27QmojRx16Z7bKUCgWC8hblwkAs2wnISYPBu3E5Wz4iJmojbBT1LVUpo8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwPi/PmZl/XaKbBgTADVv7Fo0TK4Z0fcaLULqqKThPo=;
 b=sNsinLlYqT5bDJHLHHhg8bKhQ+BSibvITguV/MHpXgFnZSRu1ehNulCi2cxQZlTP/55fZKbRV9gwS8nPSc4TnLi/Gdkasvfi/NleD+aWLeGVRZja5z3etr8kaj+Imn/9s3KuARkAowI+yQoAYFpZAjUeQ1wZIMV8pGnMAx3lEwA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 13:20:58 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 13:20:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET v2
Thread-Topic: [PATCH v2] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET v2
Thread-Index: AQHaM/ijhFI94QKj7kWOMlwTmYsNd7CzuE4Q
Date: Thu, 21 Dec 2023 13:20:57 +0000
Message-ID: <BN9PR12MB5257740C006940DEB6E6F47BFC95A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231221102917.1900120-1-Jack.Xiao@amd.com>
In-Reply-To: <20231221102917.1900120-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bc1dbd91-a66e-485a-bad1-44605422c917;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-21T13:18:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7167:EE_
x-ms-office365-filtering-correlation-id: 18af4d4a-5d68-4db8-2656-08dc0227ab04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30uCS3P7WhrWsksS4QJ2NXPHZdxm5OF7lzvrjaMYcU8wHSk0b6Mm9ihOp0qGhmCveW/sGWUTWjs9haQeWaSLu+oWQ+Q1/r3BvZICD/huSu+YXepV4MU27pS8fY4qrPSM/HagbiYT/6krnZhraQ70zP2MZpS616IhRbgFKEEfbc8+lNE/LqkN/HHMlZdHR2iQ7UkSI65UXRO1NzvRzk+OFTNb0faKSHg6E8zH0ZguY+++W5QjJN3YwIM7A7XveOF/ZrEcjZLrkbAWmYkYm99NS7aS4tq8pWkRBPUWVvXni88ICPcVT6w32RPKEpMDgAsQIeYk/yvD6S6xub67Ptzo1cuSNo9TYrCYsCRmRRXW3X3QrdrZ1GTBm8v/h7ywLMp3AdOYPjnspjYB3+CRhBjYZqBTZZhSTrOm4s/fK8zrM4Ae7ABw2RZnNr8G3ZExDcrnCv6UgopVq8JNsIppbs/Ikq4K43e0zt9hO5/m7jhUPVfJLeluQBdS6DBr9WTFdJkJFY1f62Swp5KuaRkKLEh9dtD4CEPXJ3ij6UxLMhxKQ/LdPCPUtW74w4blItcUn28K/WGfLQgGWGvZXkUC3aWLjSGJVDquYDzsCD5jOGtln/q6Y9WVmCQdo6BIJC+BUdC0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(9686003)(53546011)(6506007)(8936002)(8676002)(26005)(33656002)(52536014)(38070700009)(83380400001)(2906002)(76116006)(110136005)(66556008)(66476007)(66446008)(64756008)(66946007)(316002)(55016003)(71200400001)(6636002)(7696005)(86362001)(478600001)(122000001)(38100700002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?evezxZFB001uzHb9QSSC49XNUkbFRKcedbiK16L6w8TsaNYN+xpNBA3LXm+3?=
 =?us-ascii?Q?IrcHyL2cwL/n3FrThqiVd09dk6fwRHmEOPomtHhgawUUM9JSN1HxIr6sdh7j?=
 =?us-ascii?Q?HYUwpiuWom90Dxp1ll8DoamIhDRMvhmgaJX3Idl0+Hu+5oDZg00ZT/C0DbRG?=
 =?us-ascii?Q?MzBw/TJ1xiv5CYjepkuiZA0Eg5QjB7jshvaJ47mjvj7OD9KOC+LbB2nKNn3T?=
 =?us-ascii?Q?iIhwjls2C1uxRIkHs4AL+D1twNkJzcsGWebHk7OrNbiZFo/vp3E1RSs4CaCU?=
 =?us-ascii?Q?nOKZifmdKfeh+LP82aWFML5DQY5Ymp/QOSaS2/JuBZe54orH5PC2Jhd0xgRc?=
 =?us-ascii?Q?UvWjjkTJoo2e7li4M5PZRGeFTQAfWpLc0gf6LxcEcGCE7ENuy7+1qZAZOc2v?=
 =?us-ascii?Q?w/vdF/m80z7p+NugMeXeNHuHIXT3Ez0ic1viOPJ+Atj0LG6zbmKQb9Sj3zM7?=
 =?us-ascii?Q?/h6qmGfYuiQsBuOCg9l7VGPqcLOBmnndcc8UIK8yV5WAuk8QiWG3ihnjHaYi?=
 =?us-ascii?Q?yXA3+zoxcEV7FwbpqvnP6DYYN3NJEsV3wmMmHIx8lXMWYlImWDho0S0ZrB1p?=
 =?us-ascii?Q?TxL+hEJefQzOW7UypsDUZjYmVzhvAJK0Th2+o1YcG0liJUFvVKSEa0kJUYvK?=
 =?us-ascii?Q?QMRJ0lR4hTOhq6NBp3s41E78gTqGfVhLQXeY1jdHLKQ0xyW6jFi2DGTIPehP?=
 =?us-ascii?Q?z+xh3BEeInon1TC9EucVN6G6QBwFHK8YFU3JZsA4rMZynfg528ynrmUoHMTE?=
 =?us-ascii?Q?oS5eFhZjpkh7uj8xIRx6mzVDxtRPXG1S91GBvyLWCfzGj0qB01gpeTUKWl4N?=
 =?us-ascii?Q?oZcsfHcPwltyu22gqwWPxMRzsqwfWj+j1SgX1Ar5RkQNCBdInfk3PQ7IxRUN?=
 =?us-ascii?Q?0tT3PLhbcLBbSz1NKOMksE+MQT3vdf/Lz0PcyTozG1rVvSv8fGfVAiussyla?=
 =?us-ascii?Q?VGFKTNO0KV4hMYgCE8h8CSpNT7CQStSGYTDlQjWw8IjIl52DY0/83lAAM2EH?=
 =?us-ascii?Q?T2AeoXxqlWpgpwvgawjl29viOK6URaAUVyyw/EJYt75gIvNFfbjdqbwX5h3h?=
 =?us-ascii?Q?3/XI6oMC2x45Ee0B9z4+f+LNY06EM+R3M+hG6Qhp5lJgNw7Sy4i1+Be3IeFE?=
 =?us-ascii?Q?C8t7wxiTazdEw2q8RHsOfQifvS03k14F4pB6n2zxbEe/XyV4JifiK1ZxCB5/?=
 =?us-ascii?Q?YgI9YB0ytuTLqzJGeTUp+L0OtBAantZjspjg5UR2JC3qQO2tB25fMmQrV6O8?=
 =?us-ascii?Q?jJOXl31GkHpW7MmBiB7IiXmMIql7FXN3P5sdCqStz4sVkh5J9C6YYncScLzT?=
 =?us-ascii?Q?MFmg9D58Jl9alzMqfCQfrjB9bR/G6cdA1mrT24hhqgWhy419wWmaOsQ4nJIp?=
 =?us-ascii?Q?FhAoyA9Lpb32KGrAit5K/4jkJXQdRn2jDMoWwN8+0+THeWZhtFxa+73ZyUGh?=
 =?us-ascii?Q?fK+PywRIY4RlHadfieVbnRWAJW43xqV6PRshpIdhrhZuYdy5DpZWX6qmelVC?=
 =?us-ascii?Q?TTv+VfqSI1aJ9GtpsNlJNgEwtZ0Qqm8Y9zfYlVdNf/nYgcIZMt/0XKu7YFax?=
 =?us-ascii?Q?MqrRyuw2J/bJ1TVIcig=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18af4d4a-5d68-4db8-2656-08dc0227ab04
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 13:20:57.5824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNMZUAZO7A0nbqzF/oH3RNeU0JS4AcYSI6JIz7Gxq6nOelHWySYYPFFLiYk+Sw/5+qbQ53gyI9xLfaLHOpc0Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
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

[AMD Official Use Only - General]

Better to use dev_err or DRM_ERROR. Apart from that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Thursday, December 21, 2023 18:29
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx11: need acquire mutex before access CP_V=
MID_RESET v2

It's required to take the gfx mutex before access to CP_VMID_RESET, for the=
re is a race condition with CP firmware to write the register.

v2: add extra code to ensure the mutex releasing is successful.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 48 +++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index bdcf96df69e6..44f5b3135931 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4474,11 +4474,43 @@ static int gfx_v11_0_wait_for_idle(void *handle)
        return -ETIMEDOUT;
 }

+static int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+                                            int req)
+{
+       u32 i, tmp, val;
+
+       for (i =3D 0; i < adev->usec_timeout; i++) {
+               /* Request with MeId=3D2, PipeId=3D0 */
+               tmp =3D REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, req);
+               tmp =3D REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, 4)=
;
+               WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
+
+               val =3D RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX);
+               if (req) {
+                       if (val =3D=3D tmp)
+                               break;
+               } else {
+                       tmp =3D REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX,
+                                           REQUEST, 1);
+
+                       /* unlocked or locked by firmware */
+                       if (val !=3D tmp)
+                               break;
+               }
+               udelay(1);
+       }
+
+       if (i >=3D adev->usec_timeout)
+               return -EINVAL;
+
+       return 0;
+}
+
 static int gfx_v11_0_soft_reset(void *handle)  {
        u32 grbm_soft_reset =3D 0;
        u32 tmp;
-       int i, j, k;
+       int r, i, j, k;
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

        tmp =3D RREG32_SOC15(GC, 0, regCP_INT_CNTL); @@ -4518,6 +4550,13 @@=
 static int gfx_v11_0_soft_reset(void *handle)
                }
        }

+       /* Try to acquire the gfx mutex before access to CP_VMID_RESET */
+       r =3D gfx_v11_0_request_gfx_index_mutex(adev, 1);
+       if (r) {
+               printk("Failed to acquire the gfx mutex during soft reset\n=
");
+               return r;
+       }
+
        WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0xfffffffe);

        // Read CP_VMID_RESET register three times.
@@ -4526,6 +4565,13 @@ static int gfx_v11_0_soft_reset(void *handle)
        RREG32_SOC15(GC, 0, regCP_VMID_RESET);
        RREG32_SOC15(GC, 0, regCP_VMID_RESET);

+       /* release the gfx mutex */
+       r =3D gfx_v11_0_request_gfx_index_mutex(adev, 0);
+       if (r) {
+               printk("Failed to release the gfx mutex during soft reset\n=
");
+               return r;
+       }
+
        for (i =3D 0; i < adev->usec_timeout; i++) {
                if (!RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) &&
                    !RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE))
--
2.41.0

