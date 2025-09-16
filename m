Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8D8CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 07:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D2910E69E;
	Tue, 16 Sep 2025 07:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MhLJoyJo";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6D110E69E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 07:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9YRJ/oiwaSGPf1OJ4efkqB6LypQNCIW3rT9hXTHk0egzI2BFpqdQCL3e4djipM5lIhhXJd516iVXANZVofZawTdczfTp0fwgXA4u0kWSrLDYVffxhuqCGDQX+wjpGfk4LO04eoQbZRAdZ80b5MTEekZmUNhh7vNEtXoP/x9+wP4cdC7DgKV3UlxlTzGDwuMztpSFKP3RWJyE9EFcBPq6L7Fwq7Qt3rUkCq2KKs5f/1QMAOhsmvsudVu7neqVmNY4HhWYvCY8XwU6C9yRuwYyorRyl9GfscehaQyO4pAxKbgObWtb65OSu5XZ9u0QEKF7am7TNdfG9qxTAWhdDeX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYVEju0QvoZ9ori0s0+1b2PLHCu/eGUm9COiqFByp0E=;
 b=f1eGVySV1BfmA7D0yUfixaAwO7vugXusN4nOT/QlwiIuT3Ivqxb3YLrX1o6VbnSy8yK7Bk8cLlzMGPeSLmjz4UdYtyxxiX3thdxhSO0XjkKFTsogde+9vmPS4AlVdqReqJBAc8OJwSuG8Ugtwmx7GHpTE2LMu8q887oWCDM0XiGipTBlHnyszxGrPbDzDqNedStwixBZXgH6sRKnP51M74WBkudlgz94kMPxKY0Qhdp4CW/W+wBuO63esA3ukBWA88RZLQJRC2rNG6LxZu0yUKZENAHx8X3GryEtaH5AGnfXvdbHrVb+FEmXQBeUfGwullSdEu3HNy3rKlvJxaEbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYVEju0QvoZ9ori0s0+1b2PLHCu/eGUm9COiqFByp0E=;
 b=MhLJoyJojFp3ABqK16SfcLYJq5AAdagnNlEFNOV/ZsfyG7mjQWE3ot8/LeIh9UXcVLF6tFz3KVeXJ0WV7UzhwURmymj/d+23fZOsRU1XdX/m2C7s0CJ7iIU90cSSGIDoq5pdec38lTLGhJC8KyX+f1J3BirHwK3IjDI4eI8hIAo=
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 07:13:24 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 07:13:24 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Add fallback to pipe reset if KCQ ring
 reset fails
Thread-Topic: [PATCH V2] drm/amdgpu: Add fallback to pipe reset if KCQ ring
 reset fails
Thread-Index: AQHcJtKQnr7FfpyzdEuHdxBQsRnZVLSVZBcw
Date: Tue, 16 Sep 2025 07:13:23 +0000
Message-ID: <PH7PR12MB7820394A6A1FA94DAF484B4F9714A@PH7PR12MB7820.namprd12.prod.outlook.com>
References: <20250916062424.926083-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250916062424.926083-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-16T07:09:47.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7820:EE_|DM4PR12MB5867:EE_
x-ms-office365-filtering-correlation-id: 6e0cdc21-9ccb-4e5c-db04-08ddf4f08662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zEUc2WODGx3vFLiFf7xpJGbMT6tiQRMIzQ2/uVLQKJ9G8hD6e2oRKA3g/c52?=
 =?us-ascii?Q?kPCEiTEnZdwcBaVA+KXV3gwgn9xi6yJXeIU5oROEczJ9EJXX6RR4rhc354CM?=
 =?us-ascii?Q?7gfaOXUS2H/XqDpszQnEFqYqE2wW8qfyW4ecYiH+OGci1Kpy6EAZWKsh5duH?=
 =?us-ascii?Q?oCuEnfLY65AMjQTHhl9a3qU7vMT0cJR0tyD+J91b+caDzxZjwMN0A4gSLpku?=
 =?us-ascii?Q?8r0HbT2A4MrwB0mtcNw38+LZSeVV0iMTm/XSE2xUpqSBpwhtf48eAeR7IU+n?=
 =?us-ascii?Q?vVXu9LOvvyaK92byQ4bPh1LZ/1NETGf+XT9XD0lAnnfepemVkoCTJ7J84uS4?=
 =?us-ascii?Q?6sicMJA84P74nHbNg0LwHBPeUKqBo4JYpr3/Q+jNGovatNeuPZ+aq8GjJUTL?=
 =?us-ascii?Q?auKgSCk6SplEm1l7cbWdO8VXJGYHU8EhnE18tF17C9mZupINmtHsKdqEu5xi?=
 =?us-ascii?Q?993GL8a0wbzB40KPhpejQ6qD4IOusEWNH5bJgmoUSNKtHtACTV9FN7IYeNEj?=
 =?us-ascii?Q?Dg2MOZrDQRX73FzL7f9Q5U65cGgiGajtHI1A91Y01hebhsiiPKaxg3MhyLwV?=
 =?us-ascii?Q?Jg8fWqUVkxIp5K5u5LaY4A7Gco9triBvf7WSF/dIBwTkUtRG+M+T8BMqLqZj?=
 =?us-ascii?Q?ouTwxmyqDGKegTaF8lTib2LUPoBs7MhEd6Cu1QdVOYK5SPRMGwV6CBGDbSGF?=
 =?us-ascii?Q?Sy7bO/GWcDt/ji5X/QyvnOEFpF61vVvcIVrxSJdHcZHk848PGGtRPD0R/eWd?=
 =?us-ascii?Q?h4WT0IZv34BjvoIR6TAgu9H0RNGq3eQnTsEXka/UDPd4u2bHpTPZ8oJaEBen?=
 =?us-ascii?Q?af7LiZlBsro4q9wC7dHw8JbqdmZHauUgAlga7rfD1adSorAZZv0ODfxigWWD?=
 =?us-ascii?Q?2LY+xaBYaw3uuiJ16DiiilvZRl5JxHZ4Z1RK1uVtrZnNDtdTUGjwQs4YPcJu?=
 =?us-ascii?Q?luGRCQRYAe5IEh8O0AehR1NK6KOmLIRClj2jxEPw3Sf7UsBzl/5qlWS6t4a8?=
 =?us-ascii?Q?QyvUZu0xJLM0oZnMNf01sn+XN9kpXN5eKrPlPLBcRNIN1u3V4M/oqOudI+S8?=
 =?us-ascii?Q?sLXoT93ESJCflfBWnCFjfgS4UcMNc9SuC6zFJwBCz5p5/Mhiqq2fvzY/bop2?=
 =?us-ascii?Q?Xt9SIzrQ+fQBlC1sq9jfxA1lqKBXTxqhulEtYYPEqGQcF//7lKOrdBLur06e?=
 =?us-ascii?Q?QFAEZSkXfp5M+rXncNYCnWi6rtTaYNARpuyo8m4b1pNpzaD414KSPnuQAuP/?=
 =?us-ascii?Q?G48vc5rPRv3UXBU5lbKlqe+kJ3OHdRfM6h3yZC4eDUs1NR9XOl4IlfF6S2OO?=
 =?us-ascii?Q?crIOhiLmOLd5wU+L4ttPsxiTyr+2fT+9VgWO78UmnddvPcAb27F6eKH0RsLL?=
 =?us-ascii?Q?HqM8fMU7IbWuDbulZyhIBxa3lzej5yJR66DZUjyuB6JlNaWoWfpIMeuS5i2T?=
 =?us-ascii?Q?Mk2axwFH29Oxd7970zhjMRPRmcxbgbNFW3zv53oKoFA0DLv2yZorOSXc9hWq?=
 =?us-ascii?Q?5ejLW1wyXxINoFk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BAg/i9frkd1tRKf/tcAwp4EUTrFV6dSn6wmN2SU1hcoS0hk37htcmW9iKOo3?=
 =?us-ascii?Q?7tj2UjANIfcUubRsteCqD01hiFIqh8yyMntMauABcsmqXvxAPSELrrvkPW3R?=
 =?us-ascii?Q?M1bzTdQtQIVTwC7PqRRMJXDPv7LV3wX7ApIJhs+/VBNhmBtPEpFgGJYyZQQn?=
 =?us-ascii?Q?Av3BX2ZQnanvFKOBXzTyG9q36d3oof7SYBH7jm8oaqHXKhkOCjKrkyIFN5ES?=
 =?us-ascii?Q?O23HPNtZkV+022/6SGTKV1A8ppfKhfffPzCk68fto79kdbK/OPmiEBeuCpTg?=
 =?us-ascii?Q?3sGnChs5pnilnT5nXfeM0csWnhCVpEtjtUSiL+u9fMqnODcCV0HJxUAewfd7?=
 =?us-ascii?Q?VZZmaW1n4QVUtZjXxdAE28mjMLrTknbfOL+oikLp7WeL2/Dz4+e2a6WHusZW?=
 =?us-ascii?Q?yQhp4lgBF+jMeylt/h7ZbCW/QwGBeGcKQ+R5HJUs6I4o6QS0MWOA8Ea2s6s9?=
 =?us-ascii?Q?OHoyO6xB5/LOKsv7uRKKrcl8PBEUCoz1yaKdTELSDxovBdToG/QiRr+CfS/S?=
 =?us-ascii?Q?AZBAEGhCWL9nwBdMaWLZsc1WI1qKn3qfb8GleUYx77V3gHH/TanbqWnjveys?=
 =?us-ascii?Q?Nr0lqoo2mTQPftOUUKtWoaF4HNLXzJv36JKzaA6ew5fr5lvwNOysI3sMR7n5?=
 =?us-ascii?Q?nxC/EtfDCbN3N6AdYgV9oquPveR4gxXJNwctCTU9sYmOSAWjoAIuF/M/9GkD?=
 =?us-ascii?Q?PGzwFBAi1mHGJ84GfRAaumlnyAHMhrCpXgXujOmovbd5sXsnw3EPzOYWg+yl?=
 =?us-ascii?Q?8UKLHW/X06TSMB4l10HQeJac0i8ajGogNohQ6Un8OF9AFyOuqv4qBTnwMgVK?=
 =?us-ascii?Q?CpG8hf71XJtUJYXrLVCShLSlVf1ZZoh3HqTBktEqdaD0FD3S/qxl6iRK0XXU?=
 =?us-ascii?Q?NZAQQCzQzqvJ21ZHOI6BNT7c1Bwkv1p7rcnjPHDin4un07B6qESoa8IQR39G?=
 =?us-ascii?Q?blmmqHv97LMKR8nml2IKoQdhU4e9NOeQIU2Sz5f8EfzQwMacjlsTuRw6OVL5?=
 =?us-ascii?Q?DYrtEda9YAhd0zXdFzQ+tLlP607rwvI3Oq7yGRRMC6lH8dht2rjSaCKUOcSy?=
 =?us-ascii?Q?/OIS9izvBVpPjIkis6gGLb/sT7NBLCavPmFdCzlfyHNSo8GSVwDLkExZ0LN2?=
 =?us-ascii?Q?t61i6fp8x+8gWx8fzV9d3MGzqkGXvVQM9+1FwNzmkM5RBTyGzYyGfko7+YB0?=
 =?us-ascii?Q?YrwiwalwgHoSiLRzT/zLMzBbczxsk/HvkDYygHz4nJH0AHHlslk8xlJstgej?=
 =?us-ascii?Q?Xw9TnU0vwjjWqpBaeBzegLyMP9ZC5Q1cysLOYKcNu2IYvEKEkGFXCBuxBlid?=
 =?us-ascii?Q?ssMCmZSZg/ppU7a3otwXxfJlE2vgxCvuqtdTBwboQizzEtdTDzXxUCU/OnBY?=
 =?us-ascii?Q?MxvhwoTNaK3rJWjsLXW2ibFxsFNkbZqqRENfiUW/h2LzP4lI8KfhZ9VXPQ3i?=
 =?us-ascii?Q?W0tOMg3PciyU1BqVIyZfjG9HzxdoGEiJz/1Z/MFbMTuG7dpq+tIcjUjNwFrs?=
 =?us-ascii?Q?BInZfo04nZkhT92xc+rsiDb/LTjxP+dkpW3UD1h87uhvkcOkZYrOtXDRypho?=
 =?us-ascii?Q?6Vu4ox1sq8eQrs0MiTc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0cdc21-9ccb-4e5c-db04-08ddf4f08662
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 07:13:24.0161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNJdddz83hMJviGne71BoQKbAS+YVgikw0alhMUNZQJ5/pCGnBuMqBujNuI4ENFf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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

-----Original Message-----
From: Jesse.Zhang <Jesse.Zhang@amd.com>
Sent: Tuesday, September 16, 2025 11:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie) =
<Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: Add fallback to pipe reset if KCQ ring rese=
t fails

From: Lijo Lazar <lijo.lazar@amd.com>

Add a fallback mechanism to attempt pipe reset when KCQ reset fails to reco=
ver the ring. After performing the KCQ reset and queue remapping, test the =
ring functionality. If the ring test fails, initiate a pipe reset as an add=
itional recovery step.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 8ba66d4dfe86..8804c5844f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3560,6 +3560,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *r=
ing,
        struct amdgpu_device *adev =3D ring->adev;
        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
        struct amdgpu_ring *kiq_ring =3D &kiq->ring;
+       int reset_mode =3D AMDGPU_RESET_TYPE_PER_QUEUE;
        unsigned long flags;
        int r;

@@ -3597,6 +3598,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *r=
ing,
                if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE=
_PER_PIPE))
                        return -EOPNOTSUPP;
                r =3D gfx_v9_4_3_reset_hw_pipe(ring);
+               reset_mode =3D AMDGPU_RESET_TYPE_PER_PIPE;
                dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name=
,
                                r ? "failed" : "successfully");
                if (r)
@@ -3623,6 +3625,13 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *=
ring,
                return r;
        }

[lijo]
        Missed this - should pipe reset be considered for the case where ki=
q_map_queue fails?

Thanks,
Lijo

+       if (reset_mode =3D=3D AMDGPU_RESET_TYPE_PER_QUEUE) {
+               r =3D amdgpu_ring_test_ring(ring);
+               if (r)
+                       goto pipe_reset;
+       }
+
+
        return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }

--
2.49.0

