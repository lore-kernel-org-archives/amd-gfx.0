Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD35FD13588
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 07:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B3610E02A;
	Mon, 28 Oct 2024 07:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SnJCHHCB";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1890D10E02A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 07:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh//Q3gQQJscW46+ISk0ny2n1NaSFLHVkW7NK3U9weOZ73M67FMxUZq1h0H4t0cnpLtCW/aMh44F2suTZRklFQItF5vacHI+MbXxpX9ZF+ZkUjO5syVliF/QMsy/H2AtgjFHuM/+Z3ymYYqXrR+HTOHAOqnx8c9kbTWA56red3mhvisDtor7h/brJdgNjD7hE5TdiQUSqx1PQqN7L3hMifCrYlG3pvVcmWqdWtt9F3JI6Rpp23IPY0nvUCPWHRw61+4rBrYQKIZ2blxXwnxyxY6H+n3Sfj7dnEOEtOqYO21Oe1g8XhblaZZ1w3/4ynXUjmcVoA4E0ayKHmxEMfhK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjdwmpV2EH7mBIKQMmUme79EjoltMLwHq6XsimkeKYo=;
 b=a8P+Ex18h7Mb27A5Dd+mp0kHbjB3UhKJBmcGn4s00yR/SOwgMte5gbuj6SP4DvHVZ+fidq3ZrBdQ4OwSL3dIKapmfEOY/oUUyu0HDQgVMpAkB5NSR7gyA+ZuoqzbeRDD9S2ljwVUtwpdzY34vKFzVoxcH8knHUOSkGczl89n01Nl4QI1iWAQwNjWSV+TA/5CLrW/u2r2TFEyetypIzfQj6e2Cs1cWPzo7AJDNYVwNy0De8OyrUTXai5TdDIqg/cb/BFM1BrJN3Jl+nxfJ6997vLo5gH0inEstYSdAcBojSLu1pffEa3xXe/nOgRwbf7/GVQsbjrfj5hs+D2PS55IfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjdwmpV2EH7mBIKQMmUme79EjoltMLwHq6XsimkeKYo=;
 b=SnJCHHCB1eg+EaL6SkoMcK7qokYj5umw/SHfpPWsPUrvMPLPhQozrsVW2vC4Z52BhLz4A5hx2IMgQyq4hqk0NZzPxn9aEw2rV1Eeifpf70odWRTbkqZHQkCMNyrl3HbDBZpQq+jY3iuOD25BCVuKTQ2qasxt52XsmsIQGqFuP1I=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 07:23:51 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 07:23:51 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Li" <Li.Ma@amd.com>
Subject: RE: [PATCH] drm/amd/pm: print pp_dpm_mclk in ascending order on SMU
 v14.0.0
Thread-Topic: [PATCH] drm/amd/pm: print pp_dpm_mclk in ascending order on SMU
 v14.0.0
Thread-Index: AQHbKQPU1dRPIh5/yEm7rOFWQdtbq7KbwnPg
Date: Mon, 28 Oct 2024 07:23:51 +0000
Message-ID: <CY5PR12MB6369A49869067CA63770625FC14A2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20241028063627.2809942-1-tim.huang@amd.com>
In-Reply-To: <20241028063627.2809942-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=7f4ca00a-4fbc-4be2-aed9-10868eb78b94;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-28T07:23:38Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM6PR12MB4217:EE_
x-ms-office365-filtering-correlation-id: 606ad85e-3f05-4908-e8a4-08dcf72178f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+naLGzOcwjSZXh43KhThiKYHrENWl5VldoFJS34nGm5bUJS++o52bcol3HDr?=
 =?us-ascii?Q?QYQSB1XTQJk2KhKPYQu058IAjTUhwH7bB2UKwdaHs6kjXyQxAmybEm1NOhq7?=
 =?us-ascii?Q?74aZC82GzzJNsL0xqA8DKWIXLEWqvUs+Z/UMJwoM52aN5Zl8z81YqDluB+xa?=
 =?us-ascii?Q?e5zSn0Xx4hDXh7w81Ykzbnv4WKNmvPYTG+48wM2potoGIN251dyBdRGXnxrl?=
 =?us-ascii?Q?MqXhGUVHw2pLTUDwFWqI5FiDiIBp0gQiv8UNyJyG5Pg2PBItEvkdjMoiL4z6?=
 =?us-ascii?Q?neTBaj5pWHIg0f2Njpe5TovfFNtkMAhpn0eyV+IDR/K2bgsEYYIL+XRiTKAb?=
 =?us-ascii?Q?7AvdMvhGKg1qPjXffrSKR4Mht2L3CtVHI2haIPI7bmERvAcpkIOaRgq6MP8c?=
 =?us-ascii?Q?4N/bBOS4kKTsJyDLjMYn4VgJUCAGIsKec0Y+vru6j1S9dyfSi4zm9CLnC2zc?=
 =?us-ascii?Q?JkFh7z5wRSB0iFdvl7jjP3+3RnUle4Rmo0CSFPyZn36+SGD18hnfiz1Kc9RG?=
 =?us-ascii?Q?fn8s2GBSNfhtXHbI0wn3vI9h/fbc0HIoIvEZ+3ijihZMVX7ZwIH/f8RhX34d?=
 =?us-ascii?Q?aGABeyrNGLRKsFHQNJffTXiNYI197Xu7pQCOSXRU+zKGOkMC37TLsdwj9fHM?=
 =?us-ascii?Q?+mI8HD8sJfYjGC9xDNiL/J791ef5FPqEqEZQ5Btm5e43cO0AlSTInrw6+PxX?=
 =?us-ascii?Q?GPhla1JVM0cEZux4J0fKhaUchlzDzTXZ2p/nlPftSlc4WopbzXss6JzHIzjB?=
 =?us-ascii?Q?CJQ1HI7nhvGyHkm5QkMqcxyuh20JI5aScjkaDbd/fFFBwG9fti6BpDfToT+K?=
 =?us-ascii?Q?zENYAXJPTk4ghquE97mOpvnMZDzjzfN2LD+ZEimqvpTyu4sDPL/+Tck+uDjg?=
 =?us-ascii?Q?VTjhOhaFUQrjoFfu0hSL/ngUnPWUbXFtb5dpJjvVgL43ZHnVzpjU/RSHeF4c?=
 =?us-ascii?Q?llLzYMEHzjIIj3I2RQBb2fU51nItJ1VYWmrXng3daWfEJkUunmZwT9T6aoHi?=
 =?us-ascii?Q?RdlzOTE4YSYLju3MN+mUeP4DxBq1BtQsIcZU7rnU/p7AZ93QjKy7kh7M0Q52?=
 =?us-ascii?Q?ENef3DXYYogb0LzonXHTG2nQSyMEXQWInuiPjj69Ku90nBqR1o5UlvmRghT8?=
 =?us-ascii?Q?tWdE7Jmj2QOqfmt+We2pfima3e1/IiX3HE3ZfW2tDNVPJ1jTqfMuaP/93IPG?=
 =?us-ascii?Q?3D6cxPQkjlI1Tszo/V7ih9KLclfwrjYdhX6qoB0a4pQsptdQeR4KtgSohqV3?=
 =?us-ascii?Q?C3kxDgjh12dCaq5JY8WzGmXGr3V56dsTz4mx7iCMt4MsShHdQZh94oKWlwQW?=
 =?us-ascii?Q?pO1YOz/5kROIy+Ao3IefqLRDWHnIvdKVFPyJGulPTgA2hPL+m8nPlgJ3JrSI?=
 =?us-ascii?Q?1yIVw4c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iZCkfAdlOHZwrzjjS+cVucegWTfdrI241srWnf0ktwt5dNgHZOPfoAaFXXd8?=
 =?us-ascii?Q?1nxTanf61jwGSnucYMCEW4whA6+4fihzjR+ufoPy6jKGWzT57eKonxiXunCT?=
 =?us-ascii?Q?5utomlGaXWfNZ0YzaH/bKNtn9rXxeXAk7NiCiWNoNqAwKSQmrEQOx9xh+Hct?=
 =?us-ascii?Q?SWSU5ELYIrYdv6h2vV0IQLeUdMOz4C+IsWhSORmIftCvnFG035b2KiVJtR0C?=
 =?us-ascii?Q?Bj1KPuP22fZdTeFg9d4sSm6ibSVV8hqBrB0nnduPWpCZr1//fkA6vW7LCa1D?=
 =?us-ascii?Q?CWwverN/+AbURMrbD8yMPt/Xvm+5MbsYbA4FcAs3DTo93LqIxTb1Nni+MY+v?=
 =?us-ascii?Q?CdSThb8QHksW3oYZpu+MIDxeWG8IoS6Pscx0jc5LWIhx1gj0B+gUM2CEHtUg?=
 =?us-ascii?Q?dfBbfl3LuJzfM4M+DesvBZslvIPQ7y6vRM0OSuMBUvHSyTJ+kwLMs1xGj7Oh?=
 =?us-ascii?Q?iFQ/k+1DfayRaQlhFz6oSIWuPE2QxFgiBbGjYk2oGnjfsx+aVo7/Qk44Xy2g?=
 =?us-ascii?Q?bWXBMTYYRtT1pb7fSeigjXeXbOOJPhehxTBaYUUqp40pJySuChjuVgnhxBV+?=
 =?us-ascii?Q?9xr2CmJihNuF4Bb2v8qkzaQw0O5ICiYFzVVcy1eGvvxC0s2qNl4QlTReAXR2?=
 =?us-ascii?Q?fFHHyYlhaPxosDRb+aUkVfT8/WyAReVn84Ap+O9Koi3kH72KPNU0Xebr5T5n?=
 =?us-ascii?Q?7hjl5avqtkGsqIpfwxGdRjwzTE3KVywxKgLHDMCKoW4ut0IUM2pnT7yg9PI4?=
 =?us-ascii?Q?oR7sn5JJBwQXgXZbWCL5G3BzK1glEJh/EfKZPh6B78MPWLUcl2wMcNnMQ6Nt?=
 =?us-ascii?Q?h5d2Ep3DAk3FvwAxB7W7k4SC6IxA91v9sRqOsOALg4gEC7ABz1a5AA2Nk+9E?=
 =?us-ascii?Q?7AijQhpmqLhkutRN5ltNj3VM9BQUIuCtD/aPvzv6vvWW3pGPfLdaG9Dy9FD1?=
 =?us-ascii?Q?+9Q6KDRtPCkbWHvJT7bqLgz6kt5oMIE6N+PyD4bimctFD/koZ8XN4AkLOY7G?=
 =?us-ascii?Q?4Q46IcxrM2foZwgWIB3DROT80m24li/v9CSUhYE/JsbydWLsqShry4/9MTcL?=
 =?us-ascii?Q?u+2cuc3MGz6Pb7qA+zf3+O4QyxgbsICRDj6JL6hWOOH74FrZilo8a1ltQxr+?=
 =?us-ascii?Q?aBWk6eijzquohV77wKp5bSPtl1/LzW1Tu1cD9+ngtp+DQnn8ViVwSIwaoKGn?=
 =?us-ascii?Q?oyVGlqhl4NzQ8ssRqsEdQQcJUYoTfft+bmUR2hSVcBmlehpydof8C00xXM9H?=
 =?us-ascii?Q?N9sP/TuNeSfhmpMJAUd17CxC5/1bPST9ogCBuBH8wa/SD6tIKtbiR0mkk1RB?=
 =?us-ascii?Q?9YFalAqDLxE7nPLD2c5UwoVNQUIIa3JiGuD4lYYdweAVVI6SbrLY71LCsaxF?=
 =?us-ascii?Q?LBbARG5UyHo9XEWrpDcF781DuFC1EICOHML3MUNaJiAZwY99dYqlRCs3n2bp?=
 =?us-ascii?Q?m2xiTKddXAsLhqj5L4FQLvDdP7NL0KRyU1RpuxsvRMyG97BDLVFkgDKv+IL+?=
 =?us-ascii?Q?BLtZ65gfqo+WWB6HJ7+pcC0zDSxe6CqdGk4bAbjcdY7jgqtCuiiEgrkeZSl+?=
 =?us-ascii?Q?7Uk2aWpuIHhxQusoVT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606ad85e-3f05-4908-e8a4-08dcf72178f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 07:23:51.4448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkB77KyHBc3nyUnmUQsu/E3PImDU/66Bi9NqDbt62SnpYElRfRgIN2xQxtranU49
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Monday, October 28, 2024 2:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Ma, Li <Li.Ma@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: print pp_dpm_mclk in ascending order on SMU v1=
4.0.0

Currently, the pp_dpm_mclk values are reported in descending order on SMU I=
P v14.0.0/1/4. Adjust to ascending order for consistency with other clock i=
nterfaces.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 8798ebfcea83..84f9b007b59f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1132,7 +1132,7 @@ static int smu_v14_0_common_get_dpm_level_count(struc=
t smu_context *smu,  static int smu_v14_0_0_print_clk_levels(struct smu_con=
text *smu,
                                        enum smu_clk_type clk_type, char *b=
uf)  {
-       int i, size =3D 0, ret =3D 0;
+       int i, idx, ret =3D 0, size =3D 0;
        uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
        uint32_t min, max;

@@ -1168,7 +1168,8 @@ static int smu_v14_0_0_print_clk_levels(struct smu_co=
ntext *smu,
                        break;

                for (i =3D 0; i < count; i++) {
-                       ret =3D smu_v14_0_common_get_dpm_freq_by_index(smu,=
 clk_type, i, &value);
+                       idx =3D (clk_type =3D=3D SMU_MCLK) ? (count - i - 1=
) : i;
+                       ret =3D smu_v14_0_common_get_dpm_freq_by_index(smu,=
 clk_type, idx,
+&value);
                        if (ret)
                                break;

--
2.43.0

