Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6557CD1284
	for <amd-gfx@archiver.kernel.org>; Sun, 31 Mar 2024 04:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B7D10E3D5;
	Sun, 31 Mar 2024 04:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TlgKdMEY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2124.outbound.protection.outlook.com [40.107.94.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB8E10E3D5
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 Mar 2024 04:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjLTHYtNn6IZl+Q3dLTZ8NCUVYyNuAVadvG294Po0nC09x9466JkYKGmtm99Kbzf1Y1YwYMwg0iGfkfofscZ0M/Hp+RpjD0yeod930FjaiQhlK6lGmrOqhLkkWxgFj1hvCSduDt3TwLcnHBLPIvv2mnZcQCykh1QU0rrPjgOiOPaOBwl0nKMyM22HqWOgPJb2/fhX2YZI6pkXYbwX+6erXaR3AdLwUwK1fitJaHQngO92UNG3L5LkiDVTi/Js4MQTmwwv3Q638536exVwrfByt5xco3uygiuOmPqHLZJuO8WlkfpQxpkQ+Lp7V8YbGLeJ6+dlz3GRWMWGZVGPkFcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqn2VbU5o0g/OMsgYKg1gWeyRmoTcjBsoJMFJ7hlDbU=;
 b=G/Xqo58p84h/9k4pHEnP32BWFW0m4m9YDJEF7IhA/gScuDfJSS9mEajQNFFWLWJha817Kq9K1hung30e5U1kK0FI++7iGQIbpuc7b1g0QLuBXnGdvfDgkPlOQ4+8ZybOssctP6P67eosEbbJMTUviSxDm5uww/CUxhHFBh0lipD/wJxCakIRj85c3s0ETRbm5iFHEhkjeCVUQhPVTTGfl+/Tmwpk2YSaptOQ5eBHa3PEUbF7JN77Bu7K/61eQFezUBWMHh34tlCzyeV4ETVVVXcx1G0TycQ9J6chO5DYxcCeleLFo/TvtaAWf/Ho93cmh2J9ZsvQXT26zEzeVW63bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqn2VbU5o0g/OMsgYKg1gWeyRmoTcjBsoJMFJ7hlDbU=;
 b=TlgKdMEYU6M0wgyIIBTktOmkHbr4bv3D4Y7ISLWQX8iGbl761eC4imV7OVDOoCwFlU24whSau0KS8Q/DjrGu89dVn1zicr5eS0g/kQMhb4zsxVxgyQOLYc6QHyOBUF4fGTLKuBi0eX7FQrRBs7OuStfGQycHUQ8kleCzhOYNVa4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Sun, 31 Mar
 2024 04:58:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7409.042; Sun, 31 Mar 2024
 04:58:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Bypass asd if display hw is not available
Thread-Topic: [PATCH] drm/amdgpu: Bypass asd if display hw is not available
Thread-Index: AQHagb5f65kH4cA6mUeEF00vpV16q7FRTJSw
Date: Sun, 31 Mar 2024 04:58:31 +0000
Message-ID: <BN9PR12MB5257896CF65C62E2B60C903EFC382@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240329094913.32185-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240329094913.32185-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=01f40af1-905f-49d4-92da-e46c77276b4e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-31T04:58:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA3PR12MB7976:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NMDQUftUTLkSMaFuGshzSlE36VGEx5PhkEXA8C4ao5wXKVA+3Efmen2QDsO8ysxwg/vGUxwhgYOY8v/E4zDZjzERgHaPqNaFF7+egQYSj4Jm1dstk+QIC0baL/Qk91FmIpUWjwXJMZt1mU41alPr3dMovNdQ/wKxsL+k0eHeLX//E/s6idH8W3yOSPaHuva8Uau8Jhhhuj+aiAArs2t7yKmlWJxpwBvEEPqCvCm4sm8SeuMXLjhNPxYl/6D6H/aS4+VbfVLQF+4iMkni/IQ+7bvx7AXQ0nA57zvv7yYkWxvywONSjTZFj+vQOS8lxWGbjZos570yWLspMNVxCb+2yQorq2QOzXcJpAaNfiO7uj84FHiSYftFSsSi8DLrggN788qXWE7aKCidj3gjCMTtiSuE1otiUwlGWQuVUHzj6Cqz6A1v+0/87AvbkonDPzQkdT7vQkpqrIib3QgfyZu+8TFle6b9akgBMprjYSca7sDvwG4sOIOr6MZAmqgOHjf0D7P7NbnrjvF5BvTsOE1a/LE8SW5DNSy8tjQE91kzzPLhfA7CTSe5C6Is5LfRmsUFzkpKX3TAkswab8pbCx0a7/7Lze+mgMHXHPlQgU/+8Vojh/uKWqmys+Rhl6JuViFt3Jk0fM4KV1VyDVFDvi8T0lnXkPWa96xOxPqx9NOmbeA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O1eX3fPIZDf8+XWohUHv1dSb6evJK55rKMkaSoIkdJZIbNV/6nvTkxrUfacq?=
 =?us-ascii?Q?Xwk/KNRmqfW6B5/mkE+mdNN3H4zf6D54bxu0lsatoNlG/Iuzs33JVldX3HlQ?=
 =?us-ascii?Q?7NwcgzvSeTVHzlV5rUfd8r/4vOK19pV38BGMmsHVYe+n/GAN2JAKwjUYkNha?=
 =?us-ascii?Q?e38lCq6C7Zl82p+J8nu3zp6IKZu6YUgOANSfFQt3hW+Rk76wDCaAjIEeVwCf?=
 =?us-ascii?Q?GAcrXnVsgwjvUK7h6lIFa1AEubVBWzjQSIOhsSfHK4NSC/filvr+6mQASCaI?=
 =?us-ascii?Q?V3YRjLdP13oU1D/xXDFZWT6TKVhhZ7YEpAHorgig3wt4avHFZWUcZpXg+hwx?=
 =?us-ascii?Q?R7/j0Ty3zcXsdJhyo7VzJYOKViwkslsG/Nf8fJ66E3rO1tNT40Tx3A6+NSWy?=
 =?us-ascii?Q?GUF7xAZxwqxsQZMkJ/UP4yPwdl3gcrLkHujUOs6RY+3IQgLHhBM0xNHSS0/I?=
 =?us-ascii?Q?8reHWZWCRiCXteJqCCz47nhgZGERJoM3GBeth6gszENGN+11LvsBZJV1RTc4?=
 =?us-ascii?Q?CQed3bWzJuF3zF/G4mFdOV7bXdkpxTA4Vt79atnhH6HeSaMXnNJmbuyiFSX9?=
 =?us-ascii?Q?8045KkHihkViAFNaE49w1kwd2EkkMsLnW3UuICkBX6J6c0DHgEKEZ4CcKm01?=
 =?us-ascii?Q?i1O9djPAVcYBIyTwIU+BYs+2/c8gXZ9cpo27kA+thZgM56xpitCvEwF5fhf/?=
 =?us-ascii?Q?qsJ+31p+Vz+24JvP/ABmzUGSRJ8JEjQ1FPov4FPLBmW+yzZD0v8RIMqe1zdL?=
 =?us-ascii?Q?Bt4Wykr+4Ik/9Zxo0s2dxUEcm0++yP4gK3p9bICblVKaRSbZhh+jtK7noXY3?=
 =?us-ascii?Q?bw7Qx1D4Vm4nNsKPtMVBs2DKAgxhkqOyn4sp1ECIvYXRylW30lUAtkEz/Iv9?=
 =?us-ascii?Q?/8Xn3ysGwBzioHjIeT21A9LoKQfLoSGipEacfoatapHMXPuV2C5kFVi6yqj+?=
 =?us-ascii?Q?f2yU3Nmyv3uGCG7kJlMQM3XUG5v9FvAJy2ndDDGmWgB2DCuO+456HDct5HUH?=
 =?us-ascii?Q?Yp3yCmcVoy5BXJHYMm9+quW7wiQoXLlYxsrgFYJrfwjivMaCqcuHibEbAHtt?=
 =?us-ascii?Q?h0l8DoZ/MgF2zKni6qcPcIkoJAwLdeEKnuUmaPDY8DOQLkrLVWwLBoxxw7S/?=
 =?us-ascii?Q?bX6YaNI0XxTW5W3F59nRw6K9gzXjJil68Efp+69nZikENFrgMd1/wqFrjBLg?=
 =?us-ascii?Q?xtWZ9yOXr0ZgHBGJdWV+EXRSz+YpHgfyhuYvZpyqCdN9z0CTzWtD00Vx7UAp?=
 =?us-ascii?Q?09u0P90v4tLuRnzjGJVkAUj1wyhm2XxnOVYI/RvLntdbpMAmzS06HYuDZPbl?=
 =?us-ascii?Q?La2WgCbfeuZQ0BkpYEggUxx9rMlXdZdWmW31KwgYmVxDJBlcBWN6fhmScGPl?=
 =?us-ascii?Q?mQk5a6fCkyo+wr4rGcEKxCxOSVo4goNtTC3HypHTtY0UJU8Z4PwqMCVcij9f?=
 =?us-ascii?Q?T9sGD/tmRJQPB8AbeRkYkODziB4esWRoz0DxSsfiim9N+eLjP6JRJzHQYVaR?=
 =?us-ascii?Q?Ir2AHG1zMFFZTCsf02LmYpc8d3+I/TTSCh1aLot9b6S5m4idlnczJmZlctSh?=
 =?us-ascii?Q?vwh6rPXcPbjg3s9v81A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6185b17-c046-4063-419c-08dc513f3658
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 04:58:31.6289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HN0UP3jwqiRonkMuqD2VSgolxSryMw3H0WzKyNJLnt00CbQ0an5nIrNc/xTIXIJsZyQHFZUhU0PT12+LMolVUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976
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

Please ignore this one. will send v2

Regards,
Hawking

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Friday, March 29, 2024 17:49
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Bypass asd if display hw is not available

ASD is not needed by headless GPU.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 94b310fdb719d..063203865bbe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1053,6 +1053,11 @@ static int psp_asd_initialize(struct psp_context *ps=
p)
        if (amdgpu_sriov_vf(psp->adev) || !psp->asd_context.bin_desc.size_b=
ytes)
                return 0;

+       /* bypass asd if display hardware is not available */
+       if (!amdgpu_device_has_display_hardware(psp->adev) &&
+           amdgpu_ip_version(adev, MP0_HWIP, 0) >=3D IP_VERSION(13, 0, 10)=
)
+               return 0;
+
        psp->asd_context.mem_context.shared_mc_addr  =3D 0;
        psp->asd_context.mem_context.shared_mem_size =3D PSP_ASD_SHARED_MEM=
_SIZE;
        psp->asd_context.ta_load_type                =3D GFX_CMD_ID_LOAD_AS=
D;
--
2.17.1

