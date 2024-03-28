Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353E5C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 04:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE0B1122E3;
	Thu, 28 Mar 2024 04:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QO7mTCND";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAE261122E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 04:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0Ezw0fFY48yuzROr6NsXi8F2KQUGE+1yUm4CaGm8U8ygNu3qnGyrmPwAYtIZkHkATsKWwdfYI3QuV04KHN+/GB6RlaES7nVkgq7LG2IILVvForWHCyLdMd9vSBDXzBrJHDSYOhPDWIbfTe7oQYCNapfsb6YSMwRSSAjae9FRI1Z6xPE4yRWcD9DWRIsgeyjmkijnSnJyvQlRJSDO7/pOLiyjzc/GLVot9+EZWCmK9xRlhLo6WHSVQxrq6I8Vj4P0WxQlPUPgklznr31L5BULo3Aj+aDD65+OqcILBTffInQ5LhMe1bpGM5wHCtfMDOJeMeTMdcFGPxfFtbhtkDEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLrU+Yf11EazJ+2kADzQpAp1S2d/ygOgkZfIdc+nEMk=;
 b=hio1VdXR0Ef1lHKv/2WAKyPgoALELK34Bfk9h+ZenwUwYD0TVwBpv4Q9B89DNO4i4r/CzT5BbLAHni8kedyTgrnJR9K05m4VsnR9QHdz/Hmqs3pFNjA83Kzv0LJpgU+u/1F5MIEtWhwoFLzgYOkGUnCJGLvipUfhqKvtwyaoXAePT1Y+n0XDxjWVVkc6kXbo3XFgRs2GJuc8qrvGD1QAkyVmn5XlWVOC6Glptpej+fBh2somPdJGfVj6Lx2/GIlAxfa3oRfIVtr7yA0Cik39Z62LIrAf5uOLJg8FwueKiPYPjWxUuMk49AYzhg5yEebT86QLFlgFQqRe3qr2ZEhlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLrU+Yf11EazJ+2kADzQpAp1S2d/ygOgkZfIdc+nEMk=;
 b=QO7mTCNDV/lPuMBEpUXw++4n3cqMqBNbCspQU5txmh6lrWbJkr8DLvnv2HGrSvdxlD0umg+dlcbeuP9KQlYsE+6096yAINalPOYKG1UsGijtemqyN8fMNxFdfdS/wXj+cDkzyVrkLen/34DnV2fidq0DVwP2tNwNVeobe8h+zLM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 04:30:53 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 04:30:53 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Reset dGPU if suspend got aborted
Thread-Topic: [PATCH v2] drm/amdgpu: Reset dGPU if suspend got aborted
Thread-Index: AQHagMc8UDsWOZUHZ0aBsylb8FrPN7FMj8zQ
Date: Thu, 28 Mar 2024 04:30:53 +0000
Message-ID: <PH7PR12MB59972D58876C83B334BBBC85823B2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240328041936.825960-1-lijo.lazar@amd.com>
In-Reply-To: <20240328041936.825960-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1926305c-bf9c-42d2-855c-69d3fd2875f2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T04:30:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB8093:EE_
x-ms-office365-filtering-correlation-id: 0b2d1088-bcbb-4134-319e-08dc4edfdad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZa4z7TmdGBOewN1H57oGm6EGmQtHE5ucsye1q7XmIRVICJZzkBKnAxXrwMQmA4qgxBH1eJTT5eeqC8FfOpdEJD0QkBTMt4fLOzbgR08Ljfjk2Z/JNzN5qpGkRkyTlZv8WSzT5VbY+7kLxeVLiQSZSrgmStpQB2VsfmLmtuNvLijLnBjIPEaM7lno/Fa/cONQ3KZlddJwdDWbu0VUTX+HlJW+oPmq5vYtoNP/OqrnplnA8mc9daPM3bEYvxiO0Yb/zCZmvzWd4yZZwJ2rvchOlFQepre/Jgz5C7og4Qlk14p1HMZV2c7Kgnx8T6o7TtxJhvMsK22wFIbdikl+1BtlY1XaA9CbL9kuDN2IbBpEtoSYdMNiHHjRE6ntcREakBJOW+dnFZnLFaJPQH9cu0KiT9guUYkgmFH12n2ZsIgr9R5sNvLX6g+qT51KBgk6xY7uyee5eyQzOf1mDTQA5fvL0cYhuP8vh3dZxpxRU+gLBhWX+/HsMEGGmzyrRaSqFx+006brLmyEWUZg5CaFDFViD8//xZjG4CUQp1r3TaluBnZcKBTgkQ257g+xdpV85bRrd56yS9NiGmHBxW4T0eic6PL3ymRoGChWDh3tmnpjrjAzTpGs+c23wzij4jRfRjb8iZ4AjM1tVpDH10HCi3bNhT5spe+CYZswFF03vjgg8qpTPwWH0DPtNARtPZjZio5XooKrrESHj2zVZYj9+yYQOeGXITn1fITzOYtNju/RDg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VM5Bal/ytJxEQfArZrXV8J4yqx7Hj1nmK+ZLS27L86IZ3HoB0rEi3MEA3Ocq?=
 =?us-ascii?Q?S/lYawQqcXJi3StcV/Qgu1fhtXCHPMss6IiOZ9Ul6F2mngVzcrTffTWNtmlf?=
 =?us-ascii?Q?a7YhbhRCcgqkKuh/wovHyvP3kB66KARgLgy/2z7M6N1IGVayAstZdl7S1p2x?=
 =?us-ascii?Q?+o2FLEwL/IchMLQp/F9jI98Web8AKw0lTKBq/u+ZhXmvsXHlpPIXqwekNv9+?=
 =?us-ascii?Q?ewdPdCxt0qFCXTnDmnZCCub4hH0uMQj0LCpWMjtJvh6SxivOZv3AbX5jnE9c?=
 =?us-ascii?Q?tjMqk6l4IIy+l04Pwpzq0mnCcHtJnbJG/TK+n/wbpuFPj+KmPsGEFd27kQta?=
 =?us-ascii?Q?KJzl2XHom2VSitAg2+RAp9DGbcQJUIsHAkOTpywJudP5n7klsSU34NOBphWW?=
 =?us-ascii?Q?JTVpVKhwGUO3ecS7V/L7bjHggFIbDVHXZj+uN66q0D0xOBWn+w7PPXJnWxCN?=
 =?us-ascii?Q?XLBzAcrNRA4oh9Okg92ppPtW5hUThAC6aEL55zdmihqz0AvicEv1X4K+mPZK?=
 =?us-ascii?Q?h0Qc6d32wKF/b/DY5GQv3szN7nOcPBoUb8vXelttEFkL5X7WYyM2ZXrrDt5G?=
 =?us-ascii?Q?14tw91sQaWwOb7s04Mc1/NqwcCo2aVeypXB0nPbNgI/6vFxndxqTqH8sHsCo?=
 =?us-ascii?Q?zvOmP0ckvwE6WhLbAF7rOMUDeo+F/umzAJDt2a1uZKGVBRuZ0GSkHau/QKRB?=
 =?us-ascii?Q?zzMoxL0pp4wWgip7LxTYlle7kFG3ScQgNj87KUfkx7Tf9IbWyMZnml/WpyVF?=
 =?us-ascii?Q?wXTf5dOQVzx1jQ5nz4AVijVCRqVV1YXryOWy0GiTG4v40yQ4iH9MUYSXtB7s?=
 =?us-ascii?Q?MulKvGeODGOJzblK8LpWubv1B+LHw9S8L/SBf5iu5qHG7gyuKCtHfYpP215r?=
 =?us-ascii?Q?obOVvvM0nuztu98QJ9ZBp6r5Q/LOEVwbB3hHZDcLuBMkfIeSjQhiAtDf/588?=
 =?us-ascii?Q?Fghawg5me49S3nADnf1F6HvKrab/Oer7wG3Hd12em6Ig87+QpQd4efaVuZzc?=
 =?us-ascii?Q?i3rLNk1iX9hKBiYM80/9WeqPyJrM+L7C9Up1kZiBCtvbuumAeOBUMR3zd4p9?=
 =?us-ascii?Q?301tbnQkPFoyvR1kICd5sTOcZYp0XwOR5XXvOlzHuZhqAnHdskvRW1RqQNc3?=
 =?us-ascii?Q?xBMXLQAg9L25NvAiF2TSQKlCTwSGqz/q8KL3IeqGqn+VDPQCn5gDFXK0d8iJ?=
 =?us-ascii?Q?wCdkxA4S3bJ2D0PWWQJZbQh362F3VRkfZXSNhXOBwgT0zAhjdIgbcIQkHEf4?=
 =?us-ascii?Q?qSLSlpCs++X0f0pr4j6K3/4kmvqtvN/0wJJzqn6vHpCgv2fwhbVI2W+wmbzy?=
 =?us-ascii?Q?+PcUvym81AppmLtHfnbKyvPriuwducdn7fTdlbQBbxCOdExhMkUDdmCXqD3h?=
 =?us-ascii?Q?DI4IYJSNNe03kTj1y/1NyD2c0DfaB2qkgwTBV9dHAla9LCv833c5VWmpBa9r?=
 =?us-ascii?Q?/1pLEq02fgq+HdgYw/JXhNSaKEanC2jcZpO+1/tAun5FhnvrpNw5kYsPGSmh?=
 =?us-ascii?Q?PhXg+juedWo6hBgKNQjFEy8YGoMHoe2zPrGg7Rn47FzxRnQXLELaRSCbM200?=
 =?us-ascii?Q?Kp6Decl+NNFjCxEtyfQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2d1088-bcbb-4134-319e-08dc4edfdad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 04:30:53.5376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DCa9gmX5jF4VfgXINpU+akaaNS0gzg2Yz7Uhmdsa2gJikPhZhmX0+tM54o1NnSZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, March 28, 2024 12:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Reset dGPU if suspend got aborted

For SOC21 ASICs, there is an issue in re-enabling PM features if a suspend =
got aborted. In such cases, reset the device during resume phase. This is a=
 workaround till a proper solution is finalized.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Read TOS status only if required (Kevin).
    Refine log message.

 drivers/gpu/drm/amd/amdgpu/soc21.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 8526282f4da1..abe319b0f063 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -867,10 +867,35 @@ static int soc21_common_suspend(void *handle)
        return soc21_common_hw_fini(adev);
 }

+static bool soc21_need_reset_on_resume(struct amdgpu_device *adev) {
+       u32 sol_reg1, sol_reg2;
+
+       /* Will reset for the following suspend abort cases.
+        * 1) Only reset dGPU side.
+        * 2) S3 suspend got aborted and TOS is active.
+        */
+       if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
+           !adev->suspend_complete) {
+               sol_reg1 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+               msleep(100);
+               sol_reg2 =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+               return (sol_reg1 !=3D sol_reg2);
+       }
+
+       return false;
+}
+
 static int soc21_common_resume(void *handle)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       if (soc21_need_reset_on_resume(adev)) {
+               dev_info(adev->dev, "S3 suspend aborted, resetting...");
+               soc21_asic_reset(adev);
+       }
+
        return soc21_common_hw_init(adev);
 }

--
2.25.1

