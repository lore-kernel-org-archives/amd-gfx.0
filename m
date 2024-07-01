Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE20C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 18:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E14410E4C4;
	Mon,  1 Jul 2024 18:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0kp4j/+";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26D110E4C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 18:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPP8vmHbfxnP1e4MaeuOeQ4L4jveflK7oZiNjEdpxxsEzDzFFFUh3lP9WZaGUllAv5Uy/3ngBJtCUGDrBol29+DdOvFPvpWJ/L+lfRYohh5JC4SRdVx4gQ5M+K5zwTbYhuzJwv5l8tn7/eRR2Nljkgs+gZQF7Od1DMhYLRqpjl2p4DWLv/QJtr9VPXCIcP+Zus8xEF9wT/cvrTv/D2lO3TCKQijVsSZANK063FZ946hpZvY1WMYLf+Lr5rTr9ZEP+zyfWGO0/lI9bFQ0fBxQIWhhMfAJJvHN+zxxcfMFBKjD/UJ9RJII54RmaH02/JMwPWCH5vbvlbd0mWP3Dn4tXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKANRM4jwv797zst7Pw4i/37SGwGwtX252nQSK4iffg=;
 b=JNNy2be+a6//UAvpQ6g6vITVoRi17TfhRpDlFserlEWj//8LK/grcLZgWsGK3Etxl5Rkau/9z1em4h0rW+Zi9CdnFRqrNyGgBH9iVZu1omHjLfJDuBfLX7VTUjoZ5NT6Dw8KBApuDJiZZjFxHO2YNuL23/wIdzrVlegOWpgCWIUqZkar5TxHXNFcuNyNgjALKjF5wiS8vgAbQNcf8/3uPWNKHT3IK43JoaJoQ281bXBoWc47VQlgBOLgL4o/gPDMTnSFjajySJZzwv1W964bRVgAJcQl3d5BEas7j57XV50PT1eyAgPq6j/8qltDhlOGkvVk74v0j6GyY4b4Y6n5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKANRM4jwv797zst7Pw4i/37SGwGwtX252nQSK4iffg=;
 b=W0kp4j/+5OOeXdCiFE0SrvXK/2SxoeeZAvBKyfykOE3UtSzK7gW+05MhSoayxfoajIlg1xWvqh3V3C11uv2D7vTAiEeK3ktZelQOdzv1hGKyb59fC5tKMtOjuOwTzGWzYHjsG/AS3tQqGUfRvZCgZQLxKTO+XLZ5AQN+QViMBpY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 18:01:31 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:01:31 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH 7/7] drm/amdgpu: add firmware for GC IP v11.5.2
Thread-Topic: [PATCH 7/7] drm/amdgpu: add firmware for GC IP v11.5.2
Thread-Index: AQHayvuGYI20/LEjqEqYJJmFExhdk7HiK1Md
Date: Mon, 1 Jul 2024 18:01:31 +0000
Message-ID: <BL1PR12MB514421133F8E64E16B49026BF7D32@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240630143836.2015991-1-Tim.Huang@amd.com>
 <20240630143836.2015991-7-Tim.Huang@amd.com>
In-Reply-To: <20240630143836.2015991-7-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-01T18:01:31.138Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB6778:EE_
x-ms-office365-filtering-correlation-id: 375c88f0-d9cb-4cad-418e-08dc99f7d681
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?60MI7dR1LfqxXr17LrLwjsxR8Idocx8j3lxxWr0NX+ySRO7kYPKOJ4lFG23h?=
 =?us-ascii?Q?7MjABKD8CG1pjQw8/gcOzZ8Kd8vWy0KEx+UKaVybBThS4WblcsV2q8+gWuDW?=
 =?us-ascii?Q?6WaLPlzcUQD5UzFNf5wac20CBdQ28oq8VIc1CTGY44Jywqd4tKdBf4zrYNLu?=
 =?us-ascii?Q?P6vsVLVyyBcb31+wkR7WECFxDChEyduZjfoVFcuwaTWElE5t5ZLGkgdrUB/z?=
 =?us-ascii?Q?qKI7S4SiMY8ilT9cB0F++t7C0byEW50m/O6GpcxHSq8ZLF1+V2hoyc0tzAAL?=
 =?us-ascii?Q?Om8ro8NxvG6aSLsMF+15LvIVu0KR0ZZuXuhQuMbTT7c0neBrQ1VmZYFoHpoy?=
 =?us-ascii?Q?nQSCWmKop1VnpCVKZnCdNsfzpLv9nS1+MfH2CJP6Tvdt1WoegZIeEXN7NuCa?=
 =?us-ascii?Q?P0UoUIFUvofmPTqpdiQN1mSZVRaLRjz7nO2SKpODn7WDp6uTnln9ELy3dRh/?=
 =?us-ascii?Q?es1hIAGQQH/bNUfB1UjJ8e7pXJ3wzsdhD0aUqeQgutYPtdvpINUtSXrhQhsX?=
 =?us-ascii?Q?AtBFpzUNNxgteCJyPC9iulny9V+Vj3OxVbCEVO3TdUWDsAZdyG6H4zB9i+lx?=
 =?us-ascii?Q?eehcDF9KN3ZCYibeHNY7Mls/CwMNwqZUVNGqcXCUYR/qVbJUyTIBYPuHJ0YZ?=
 =?us-ascii?Q?H2kTtl0CzUUS7Oa2bkn0JcwnhkJt9FGEBz3VBxbKxl5kRWwuUiBgYFfRa/nz?=
 =?us-ascii?Q?9+33KgJZ85NdsUEMqcvT/BGRrkybUvXokOjfGuECl/lLynInXhvJu3MeL9DX?=
 =?us-ascii?Q?OgRCyAdlLfmkB76ytKtaHPPg6lJbbCUjq4KUPYOSRrI+FH+BNomwhi672ipq?=
 =?us-ascii?Q?WmbWnnMgTGuatgUfTHXyCzhXPFeasNDkW7nEW844Uumum99RRbfJ0hJ7B2WH?=
 =?us-ascii?Q?nQSF20Nc+fznEb+L9TH8PiGXPZk6Y8t3L4oYseSUVr86+UcxY/48ChDz9eUA?=
 =?us-ascii?Q?IHMzIuB5XPmYbi5ltVOeOArmOcdmBNkQbRLs2+hHbzmLbfV/hyJZE0z/ruXm?=
 =?us-ascii?Q?hOGE93dPPtHvUal2hr7hpiaCzG9wZKE6831fHcqpM0LOvvUt+Wmv3abuA6oA?=
 =?us-ascii?Q?YTNCbz+Pb+6Ygqf9AFk3Rz3o0+GAAUr62q4CUYkhtvlzs7IkIOnRu0JOFLbu?=
 =?us-ascii?Q?5S28KdfuFe/j/SnZItl3RnOBJcUniZ2oWaSUWFE6Z562yLBwPNBUUM+849xc?=
 =?us-ascii?Q?N7YKVtL3rCj0MnUR0un1hPZxXyNy6K6OB6ORzndQN2xcynBA9cWH50dbJhJx?=
 =?us-ascii?Q?bnq9mZL9+mPBCjJznvPIFSPJVa/xEMMM0hX1GAivExale1HJesYtEUxW2mlO?=
 =?us-ascii?Q?pvOifijkP87FJ/N54CHgd5Qv6keJZC3lKOlqaIA81u86EiEsuU8rFV2uWeTi?=
 =?us-ascii?Q?oWVLKrtVABO3+kXl6DMjCWW75F5KSfSYJD+LMXtC6cfCxCw9/g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uBAx1K6RCd9aSyyrC7wujn7nuEcxaGjH5NwK/2dzLSGna/kaX5Mfa0rsZjOz?=
 =?us-ascii?Q?0Mpcpk38gk46darC2scthw+60Q6YY+Sbl2BuAR/s1SM438oYLitepQa9tB1c?=
 =?us-ascii?Q?Ycf7b9HzB3VFrauDuA0+3dvU4MWRmJUN/qVp19n+uDcYFvkRPfrvB3GbpVR+?=
 =?us-ascii?Q?pBBGXZCNN1AOT0nqvARkXFGrG9gnKQJ8Wv+5IADaI8QXnKGwCVtk6hYgc27C?=
 =?us-ascii?Q?2gpqNrXcgkYeIMpfsJb7t8rnW9Vv89MBCXizGkKsZ2nYevfrhX8KVYgdFfnK?=
 =?us-ascii?Q?cFbHUPSniQF6jMaEXo/KEPvbscZE3QQosqUPzq/RhUauAK3hXGLsRQa2sktl?=
 =?us-ascii?Q?tzx5kHWUixTfAG/fxxgH1Tw2mY8OfsslIpoxm5dMpoEwpDnhzB4eFkJWrXq0?=
 =?us-ascii?Q?JI2X4qu2De9tdLdOm3KN+pMyD4us8ZLknKQpE6v3AOUMUcUhA/oLhcf9B+VR?=
 =?us-ascii?Q?bVR+oMO8SvGE3Hblvy1KRuo2a2cnlJgQCLYcFyrHobLrnn/9Y6w0hgWVnT1F?=
 =?us-ascii?Q?cwrU41fqa+o9GpLyBLYVK6BeAie9121pBMW4N+SulwyOdRbHIcuTEl+egT3J?=
 =?us-ascii?Q?SFiUQrzuR0yEqi2fylJydMz/qegAkHV8jq6JmiQOqZiZwKzwJHOxezUTgyV3?=
 =?us-ascii?Q?cm0txsYyBI/ERn5HkUpJpo7jx8xYuwAt0Y2bKbsxMXAGXmvmj38xrZCn+14a?=
 =?us-ascii?Q?Ze2HTrg5smRtw+PcNbVd7EfL6BLdV5b4dSYDB8xAOKvRSHVfuXmJsiRDsE9f?=
 =?us-ascii?Q?sSUBDP+Mdki2JIqsqHiNnM3b6d4FPJMLSoy6UOOExTaznU5TKXPQigsblXWi?=
 =?us-ascii?Q?FpIeu2KIi57IGM917hPaj7TrKLc+Yry6VBscMNZdIP0FmMyFTD9mcP6xSZlS?=
 =?us-ascii?Q?UR/7e6yqQ7CfcTBIIzrqkrVOgafhtI8cOTEKc61ZjBX4qmweEv4C8VQGnXwK?=
 =?us-ascii?Q?s0vAGRSE4A+G7rEPmaaQR70B84Zq5wO4lJDj5mWh4/gKlTePxixP+40PQoNG?=
 =?us-ascii?Q?lDdMe+Q06p35B7po1KZT8UBXPzRI4dQEcJj+eiZDmeDNy93QlhB6on7VocXQ?=
 =?us-ascii?Q?Tjvh4vlzqk3PWT8qvZXcpDx0G/cCtoLD/PE3eriP4+QfNTKmuYTIVBZzmWyk?=
 =?us-ascii?Q?sqHGc1ctRPt9e54ZKMjPNOzExyE2WW47BwqbsqUjWx4QdEUfYadG4r9tN9Z1?=
 =?us-ascii?Q?xNzOfQ47oqmOQ4bfCjzMeEUCIFn4gMnlsBzs0KAkuOhQfzI82xgep9C5OHQO?=
 =?us-ascii?Q?ZzCC+cwD80YtExQ1X2zk2TKqgudBY+RHS5CInF8f6G0aMAzhT4rCsN7ZgkhG?=
 =?us-ascii?Q?mbrHjL8qjelmF6ySqiII+pUtCJM6cPrDhSD6nhoggi88dWoZzHcZscPv8uVF?=
 =?us-ascii?Q?Wk6PrErgezUhXstDVrPV9ThUOqGdKYZ2ruN5I+O7PmaEdfkysSymcFkwqICO?=
 =?us-ascii?Q?ScrgySdEaByQCO0jaP8zsJ1Rz0LkhoaPNvx6TH6aJTMC3eRjV7SSEflAApB+?=
 =?us-ascii?Q?TfTlvjdTaln/J8+CXAWrwBtcJ80D/OTjx3Ad1w9aA9Xgm8xX3/NBQ1IVL2kL?=
 =?us-ascii?Q?0jJPvbNhQm1O53vuej0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514421133F8E64E16B49026BF7D32BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375c88f0-d9cb-4cad-418e-08dc99f7d681
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 18:01:31.4431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vnCKvZiGHWNsfjvM38OEWjTXYaq7OxKyD10PwPWfWzRk44kaUtzLeAFKVL9e5gTyj/TyFX/Lujd7iO+6huJqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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

--_000_BL1PR12MB514421133F8E64E16B49026BF7D32BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Sunday, June 30, 2024 10:38 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>
Subject: [PATCH 7/7] drm/amdgpu: add firmware for GC IP v11.5.2

This patch is to add firmware for GC 11.5.2.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 9acdabd7719a..38150398a31b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -93,6 +93,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_1_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_rlc.bin");

 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] =3D {
         SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/imu_v11_0.c
index a9f5d9e4610d..6c1891889c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -38,6 +38,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");

 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 3b1f6ad99100..1376b6ff1b77 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -51,6 +51,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes1.bin");

 static int mes_v11_0_hw_init(void *handle);
 static int mes_v11_0_hw_fini(void *handle);
--
2.43.0


--_000_BL1PR12MB514421133F8E64E16B49026BF7D32BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Sunday, June 30, 2024 10:38 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Zhan=
g, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 7/7] drm/amdgpu: add firmware for GC IP v11.5.2</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to add firmware for GC 11.5.2.<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
Reviewed-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++<br>
&nbsp;3 files changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 9acdabd7719a..38150398a31b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -93,6 +93,10 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_1_pfp.bin&quot;);<b=
r>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_1_me.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_1_mec.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_1_rlc.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_2_pfp.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_2_me.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_2_mec.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_2_rlc.bin&quot;);<br>
&nbsp;<br>
&nbsp;static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] =3D {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_ENTRY_STR(GC, 0,=
 regGRBM_STATUS),<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/imu_v11_0.c<br>
index a9f5d9e4610d..6c1891889c4d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c<br>
@@ -38,6 +38,7 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_11_0_3_imu.bin&quot;);<br=
>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_0_4_imu.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_0_imu.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_1_imu.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_2_imu.bin&quot;);<br>
&nbsp;<br>
&nbsp;static int imu_v11_0_init_microcode(struct amdgpu_device *adev)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index 3b1f6ad99100..1376b6ff1b77 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -51,6 +51,8 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_0_mes_2.bin&quot;);<=
br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_0_mes1.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_1_mes_2.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_1_mes1.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_2_mes_2.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/gc_11_5_2_mes1.bin&quot;);<br>
&nbsp;<br>
&nbsp;static int mes_v11_0_hw_init(void *handle);<br>
&nbsp;static int mes_v11_0_hw_fini(void *handle);<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514421133F8E64E16B49026BF7D32BL1PR12MB5144namp_--
