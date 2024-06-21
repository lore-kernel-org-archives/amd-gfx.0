Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDADAC27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 09:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B80610F137;
	Fri, 21 Jun 2024 09:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xpnbgj5g";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1907910F137
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 09:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIOa1AX8CczYlyDn6RUPI3z6i6Y0mC7XvBpUnDQ5BWHXum1fRBV3VU4R1HV4hku90WQkFoRLf55ow2ZkNpivqvC+vQnEjfOIN5XEr2KEY/ZtB1t7qtN4HtYvbQB3xb+l8D6Cwhj6JmwTcMmwmN6DXEKDkW6ZoeE3teTKDvVr+iJKWQNrkCqpLjN0+kE/rFgJOo6jzzfTC86LAoByt+liAN6tbwm1VY0XERdOG9T09E/tx64ASe+PPQyLn5fv8ki42EKbas1GIwaEtn+R38qTQ6ahyCGSUJ3vrKCFnDGfUGQzF8Q4R9+1RWuJTcTklMcMZHLHY3yYovwDr8bmWUtV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37gGww6Q5QJCQWOGDunkT4ILH7s2tZoc9auQrFFatYY=;
 b=ZV5NbaUeik9Z6vXmPr90O4tKngnQ0uWHUlGKhAp2GTnsxBVLTaYHeuxTebXCMdB6mqINPV5Swg/Vj7OSElAivYovTiARLzzbCNa+GVGtwVaP9qOthQOoQTm0FVEg8Jv1UPNhIcjIEP5ubORlYLDGhsQMEKQYWZhJUs11ps/0Na8mHsPShbUopADs2HoOiTzwU9zhvsD6x0WLReycwoGrXtX+7SiLeT0UrusH/XCwM47FSDkYEvT+tmAu5jZ9SQA3nX9nMiLuo9PLsAzSv1FvU/TUy6tOcKGQtQvtwnFJeGmp8dfAqnKuNGiV9LN6o9E4ZBBVJUXPL/wDI8QjhM5K0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37gGww6Q5QJCQWOGDunkT4ILH7s2tZoc9auQrFFatYY=;
 b=xpnbgj5gzyHM32NGTH6DCdmvSh+rb4XSY46/5ZHNNzBlCsqh4s03o7xHlW0JXJUUAz8/PN81fyg7DypCT+5Aw4aocpO18Ajy3VuKB8qMGz0TreLqo3/M+vfTGjty492Os4OlwzcNhnUZghiDyNkqEkw/5rfFE/RqsC2vFx0Ek4k=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.24; Fri, 21 Jun
 2024 09:55:30 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:55:30 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix smatch static checker warning
Thread-Topic: [PATCH] drm/amdgpu: Fix smatch static checker warning
Thread-Index: AQHaw8EDjePXEk92DECpUXq9ytFLY7HR+qow
Date: Fri, 21 Jun 2024 09:55:30 +0000
Message-ID: <DM4PR12MB518104318902BE172A3A833EEFC92@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240621095425.27355-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240621095425.27355-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=78be3db8-03b6-4b86-811e-491486821547;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T09:55:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|SA0PR12MB7479:EE_
x-ms-office365-filtering-correlation-id: ea653b27-1d2e-4e5f-d99b-08dc91d848e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?IltzRCZukujmyY1OkdOxd6x5nl4+3EUQCKAHlJ+8DSCNwTTCAlKsmAjGwg4H?=
 =?us-ascii?Q?PIZXwherq7NYdfCFIrqxbJCrxsh0dn73K/tdxDd5f/Q8XnUzwB/8T5dsuacs?=
 =?us-ascii?Q?zSVt8IHOq63BXW7u/gGcIjUs9/sGG3EjaoiOGlWIxgeA0z/edKu6ctAUHmen?=
 =?us-ascii?Q?YDoTzUgS2LG7XSPL0ANViJGSYnkNYyB+NAIEgqhQd/ri6S1kPw7CI0yyKoD+?=
 =?us-ascii?Q?rxFJgcDM3ujSigKIsKh6B3YoVpCPkxrVDvcJPpuw+7eccFmY9Mi2+WbdYPva?=
 =?us-ascii?Q?jf2ql5KL1J8db+mBjlkmzr7bwftAcFfR6HST3VLSCf0T6ZueDCejuhQZ6DhQ?=
 =?us-ascii?Q?KEx1MPu7V20yP/h3Qq2jJsJd3e6RGQw3PFHKiA/VTVPKwQc1oFu9O7KFkghS?=
 =?us-ascii?Q?2ksV79H7JKNHdyo5jYblREE29kgxOKhGrtkknF/Dnlohxtb9zv6aORer6/yh?=
 =?us-ascii?Q?61mjsCPGJG6v4Wmo3M4V2t6iOqDONSHBLyjmN8epCUnWbhSOpnWyaDK/Q6C4?=
 =?us-ascii?Q?9gR+N3wRegHdlLwRzz8kJzEkG+2Ymq5pdvPZQPVFnF45qqX/YXpEoS9M2GyZ?=
 =?us-ascii?Q?MeRoMCyVkh1oElc3LdIVpY4FYv0X57Y6Hya63xPMRl8dEhJ8Kta4CkprqY6q?=
 =?us-ascii?Q?R4JwjXFkc6VCoN60s3Mr8O/q01rKnijQMQU14Dmys7i7T7MuAe5q4xUKvUFQ?=
 =?us-ascii?Q?RScMtbWFXTuxuG2L1SIji/zsTWonbkSBPWqWsT6UEmAtOzqLO6pETu8igLkL?=
 =?us-ascii?Q?CawDpeHm4veRgD3EaUlYWTiX0c0ZSh5nxqlalkwPBrl4lR1oTHwzXE7+Tv4x?=
 =?us-ascii?Q?ZHjNHxpE7LYlx7N+MoV7aPxY22M3lv/p7TaOE9UrY8u9UFs02L+86wS9xC46?=
 =?us-ascii?Q?7Ixu9nt2X+fKmNT9V5nEsZFEUfGLHYgIrRIIw/clax/FEpU5uUjh5VI7pZQa?=
 =?us-ascii?Q?W372xWHbRO7/PBI0s7QosWXMkavR/jVCtE3i9VEweXshEKkSvMYZo/2DqBAt?=
 =?us-ascii?Q?OkQHF3KDD4rWXsLG2ENYsyyRg5DIFpoZNx0MV0vKPl+Q6+BLSueJcwrvMhM/?=
 =?us-ascii?Q?1B6vnX8wyKZ21X/qsH/tGoreroKqWaWt1t1nV7AoYXf6za/eHLgG6X4uWLQa?=
 =?us-ascii?Q?PVm79CnbIlvgYNV6pxpSn0o5lbroJ6wxac2cuxNPx87AfV87b/DB5vX171j/?=
 =?us-ascii?Q?ItQ2WdmQ742flgakS7h/dH22eX2v/cubvRWCaVmF659+VDQbMBnII0suZ12n?=
 =?us-ascii?Q?ZPcIsP5v0rZYFNliZHjhm6sn16r3fOdQTJz8k1e6m/NWMC5v+Q3wpY8CAXhi?=
 =?us-ascii?Q?147u4NRx3jbZa84AAZzzkKs9FAosta3KQy21hnSb+U+6mTZDdW+Eg9G4UCeK?=
 =?us-ascii?Q?QFkpdjw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PXiEyc1h6Go3R1WyV0xS+QZng3cM6vOMv8/s6YpOAyIEFb/cwoidRQ+VAWOl?=
 =?us-ascii?Q?EuxZ6c09f1/jJgbTBXDSwsQbx789amPQMY0yRo99vu07pk5I7/Hzq3Ux4RRj?=
 =?us-ascii?Q?Gieo5yUTa8sO82mrJek7oEDyxWChF1NqJRMI5WwgWku29MhCYlnejWNjZpJv?=
 =?us-ascii?Q?BQRE/ojijVrQVrCow4MldJEMPkzRh01KvXsNBMd7hgaxbXJ9pjwVYTu4VpG1?=
 =?us-ascii?Q?ZGG2xlN16Y29uOBNt3DEYSX6cI+qYs5cpeE1E7Q8hRHF1wQWyfMFfk1ITn/2?=
 =?us-ascii?Q?1W6SKhp/TGo5JhZUPlRY/yZzbMK44sJSSrHCM+3jYEleI/b3fJr2RZwKE0wp?=
 =?us-ascii?Q?R1ulgyg0+2zkvDpHiNxY2xWIhPfl/17qjENzs4RsKPdfM7gKJcvbBsNxugCz?=
 =?us-ascii?Q?10tHXObutPTZZg9KhOmmlM67ZJsBnWb0C8BiyCUzKlis0WX6q2Dv9k0VmkBh?=
 =?us-ascii?Q?lpAl79q2dcCA76m5z6S8qwkqz2qblkGgpchyj7ne+jpwJadcDDe7g2GsxxK1?=
 =?us-ascii?Q?ysT2NPhPlbsMamEkUo12kN2TQKkZAY15oBUJBx5p9VXGBa9rJi7d9fWUG8iD?=
 =?us-ascii?Q?g3Zn2ofJTfyIFHOLUFFPlF2RlQ/NtqGyCLyvGnDrF3B64qVL8nIIBehYREZe?=
 =?us-ascii?Q?QCIUHHNzyqzvWDkCsOFZ6xgWeh6ZaqElThpV//OQHKFxJJljXrfH97/LiO4E?=
 =?us-ascii?Q?qfKgKAKeasY9DCblOn2a6tyX/yeA6rnGW3pM6rbbzx2FTCrVWUXvy+QvmgKs?=
 =?us-ascii?Q?UyedCVh076ULMZQX5PQW7HgZF9WExff4esTJEB3oVIKv1Pb6YCEtsa0vZV5w?=
 =?us-ascii?Q?XoaWCVxSuUuGZVxoi8kBni/krwrcjO/eNU0landVDib7yxp/BoU21jEhxy5w?=
 =?us-ascii?Q?A+ckdGRLJfMAMmfpsedNUf7Yos+Rgu+EeWvdZHTkyCWMs9+8iVTJ3ihxRqQK?=
 =?us-ascii?Q?6Thrx3G5kmF4w8k7Meg/DgoePAY2wEd4EgC9gxgDsXOu51t4jhjUV3yd4800?=
 =?us-ascii?Q?acS1gf2xgSDsim1rqfkJj8+ZNxRyYkKdX/mJAUSMkrjleMzF/BLGxgV2aE8b?=
 =?us-ascii?Q?hUhaKPdxj+pDiMlIhNIC21f9Dgm/ZuA/PAzBngL5bQVpQqq8JW9GqNUIfOoP?=
 =?us-ascii?Q?EGwMh77SjyKp3GhuIYtgOWAKCGxxqR2/GxFMoWsffFTYK1U25gWjGJvn6PXa?=
 =?us-ascii?Q?3j5HP1zzm5pRBWNnE9+za0CoQljqyaRuMZ+uWt5QAjqpcHq11S7wA9sej7K7?=
 =?us-ascii?Q?FlmHYra9SnjowkTHaL1eAKq0teUI26+rKLWfPcV6VWagppNgmnvvPzjSFZlY?=
 =?us-ascii?Q?+AX5ZwEUnEOjUFrpslcD7sHbcTDLvxXpqvMQQmJMWqZTMd3U3QcusYgJkMkI?=
 =?us-ascii?Q?Vb5+NNgDt5A2L+c1gX2SxV8uhOV6onsIGdSY6WH67s316rA9MIIJbhc547Md?=
 =?us-ascii?Q?a1sooGMFEa6d+/GC6eMMlqrGWMQs3pE65B2H7hBwgQPpgOyvic22ENAp7Wo3?=
 =?us-ascii?Q?oHku6Y0I1VxYiJyUD5BPwvzJX+6wdBzrtX9wZw5wR7MpxEF+UY88OOaWjcL+?=
 =?us-ascii?Q?BZlXFJDLVVm4C8EXDPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea653b27-1d2e-4e5f-d99b-08dc91d848e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 09:55:30.1410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mglS22F2ucMIsrbPxkA1TylQZTGl02SChUzT/LCAuku7gV4nc7hqlW0V26RLtNdq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

This patch was
Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Friday, June 21, 2024 5:54 PM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Min, Fra=
nk <Frank.Min@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix smatch static checker warning

adev->gfx.imu.funcs could be NULL

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index b4575765d7a8..5c17409439f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4498,11 +4498,11 @@ static int gfx_v11_0_hw_init(void *handle)
                        /* RLC autoload sequence 1: Program rlc ram */
                        if (adev->gfx.imu.funcs->program_rlc_ram)
                                adev->gfx.imu.funcs->program_rlc_ram(adev);
+                       /* rlc autoload firmware */
+                       r =3D gfx_v11_0_rlc_backdoor_autoload_enable(adev);
+                       if (r)
+                               return r;
                }
-               /* rlc autoload firmware */
-               r =3D gfx_v11_0_rlc_backdoor_autoload_enable(adev);
-               if (r)
-                       return r;
        } else {
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{
                        if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
--
2.17.1

