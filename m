Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD47CA0EEB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 07:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E6F10EA7E;
	Fri, 22 Aug 2025 07:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rGKLdtnk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F0010EA7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 07:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbZ6d1oa7EDquF0NaIgmImNmBVHKwiLt5pwfttcyIIaaBBocVmtVB/BYJCdaZJFsVQz65iPIkWu18lu+TeoMRBJWrw0QZOct8/4QN3BQXme/u552bDrSY8O84qfpdTaePIedPEpWok+SoXrqzPwgQre2H3UX3+USPezPmphzBl21P4y2hzFLISzCYAyIikuDemsTxGjsNS3oUHFnFhxj8JE1ZCwiUNBA+8ZAe0NCzmzUE6rJTjyZfd77VAMfMWpiIn13PoTUruxrT8GeDRww/HLPnaSYvltOOE09hdSadskd7FfAdBmfEij7JRCMPzMMg5VdZLKpNRAXZg8uexFsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUXAHnlz4aD2KPhD8I8Cmfa1HGN3wTssIHtkndN/bd8=;
 b=J0Byxa2CT1fvSTvVtZ3mA9NInGUrU1CoblpmQx3+JLs6hVlp7BSgf0GoJBTlapWGevOobqwCvh8g7HwvIbwV5dhN3WyMPRD85LM62sw881Sa5Vgqu6M9qXUZlAH00j7Yj3wIN4KbJaRo1kLwU1jSx8C5YdIriREiRxNsvkCLDgWHK6nTNjTx+nJjuAByfOC6Gr1fKyKpArB7CB0zNbLE4H8PeOWTw0KbwxejIp64OlEBo9uKnU842t7PpbQUZ6B8cZ/UqvMKPtrqDjHxsrN1Wq6piZKi06q3v06P4jhXMVlj/9lgG4vj/4rnvq7+autltT3lSGrUfa6PalJ6OoE56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUXAHnlz4aD2KPhD8I8Cmfa1HGN3wTssIHtkndN/bd8=;
 b=rGKLdtnknz9KUeQyWBx6E+kIHoFKnwZ597gcyTAqKHu0nCOZKBBAL78szNUfGWhVSbOfWqWeATjizDNWrV3jGPGAmnrQk2DFQoDEzJIYRFCL7FrzaU/+SgfZYLC8QeQk7fo2pmIRgECTQEktsq1MUmq8gPN++EPDFnSpstqUkz4=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 07:36:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.018; Fri, 22 Aug 2025
 07:36:23 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny"
 <Sonny.Jiang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [v4] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Thread-Topic: [v4] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Thread-Index: AQHcEzW5QdyojgR/m0WPcBkbyvb7/rRuSGzA
Date: Fri, 22 Aug 2025 07:36:23 +0000
Message-ID: <DS0PR12MB7804FCD07F213BC8DAAB735C973DA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250822072343.909033-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250822072343.909033-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-22T07:36:17.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH3PR12MB7524:EE_
x-ms-office365-filtering-correlation-id: f94e96b8-7532-4e25-0604-08dde14e9845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+Nz20EAUngUAJqtUKyfSeBh3ZJcyVkinQtI6RfBe79yQrFsdtET2oEbbOqHh?=
 =?us-ascii?Q?aaWATz9cZt+eQLplcuqrdE/atZjngU1wYi/HuCvKFbYFUhSn9TJEsVDkev7J?=
 =?us-ascii?Q?1mnspQUrmcbP0iB9M3+s50aheUmou8MtgKLsRptaD4H1uXByNsGh6kpUwSvv?=
 =?us-ascii?Q?gvuDUcEEF738A1fC2Yac5dpn0W2ys3qaggWNG4Z5gtYbBjjjOqZe3zLXgkKy?=
 =?us-ascii?Q?whbDHtEQfc3+0QWjmZBTpfrdTA7HE3p8L11ff7bszCwScW1ZVhqbeA7Fp7MZ?=
 =?us-ascii?Q?vYg1ny3/WEV5zymO4YzAJrx4AdUB4vQos+jX+/+dcMMgWiYMaaAhkChUTCba?=
 =?us-ascii?Q?nFFfadVLYsEjFi+BJqdnTKAkFT/99rtj2I6Z6spGVOHcVRYAos8mxi37u5Uo?=
 =?us-ascii?Q?zifLJbaXL1iPFossrOzwL4RmIHCZe09EzbfqptDGKYEE+mSGnwX2W5cY5WEu?=
 =?us-ascii?Q?bDMVj/L/mCO1kJeEcEe+0c6U7TgaP6KGpGNZas4fZf6HA61lA4whu1v5EBE2?=
 =?us-ascii?Q?JwJIbf4xPSVImxq+Y/bnqUsfJeo/rUWIDxVU/JbD8ariGvOEHiFLXt0h0SEV?=
 =?us-ascii?Q?0uy8JmqxmJ59WBql1Dhktus9/alZWdSfPJ4Q7JkPzbVaCxae6yP8sUtUUdbI?=
 =?us-ascii?Q?d7xPt0bJIJnHvxW5Ga9utXaFNzLQYeYPfBJNexTJU0YDXV32aSH0vR7CMDp6?=
 =?us-ascii?Q?YuSq4E6XNhcIDt+d4JoMkggMpL9wLoiV7yzT8yjVKB4AhMoACsagVKsW46AI?=
 =?us-ascii?Q?Hjb92jGaogAsO4Z6VaF166gzW4YthKlFi5yF7hpgc+XeAnxwy9Tt4fCgIqZI?=
 =?us-ascii?Q?gn3R2hyTypnEh1AIuuojqyv+LDSIDLgqE/CCc+w3s9MMEM7c80fYtjN4Wae2?=
 =?us-ascii?Q?F8+FeJepO+GsRWkcJUPha7qX9UP3df9DS6t+w/NA1wX8Lc5zvQKXSYsqpJ3b?=
 =?us-ascii?Q?5XumECwLshaCV4MyD2c+klisIqHnrxijy9bjRXKhs0aLifxeW0MUVdPqb38F?=
 =?us-ascii?Q?4mcUlL7VpQSG1JnGkt8paeiHFfNDMwe2Fqum8grQ8/IySqk56mR+aDqVkg+M?=
 =?us-ascii?Q?rB8AMzYE0UMHrOKGnaNVpPw7dOuPPjg6cKooiU8qRC7J9FyrfWlzR9OC9KL9?=
 =?us-ascii?Q?QavWXpZEOxIs8xLzFu+HFZ8zwi+pomzV9tpAlhkw3eQS1ZhjCVaCOkfsKrUW?=
 =?us-ascii?Q?oPBAc6Q59hdvPIyx2ZoYhVdqXMiWnkx2aZV79HXoUmSNKln2HgxmURvNpZMV?=
 =?us-ascii?Q?N0UD3xCUoQkMSdclXQpoP+5+Jr9ih8DJ30OrVulNY6EMTWmYqxjXhb5jX33Z?=
 =?us-ascii?Q?I1eeCSv56L/EpSt/YzBKUuOWdoutGcrkdm56d73Ed+dBue5GgotlRE7WkTSM?=
 =?us-ascii?Q?2x7u78DWGNAhAS4PKTK7Siz5enYtLsKgkjktjcVvbxPdA02idutnWLhmp/Fx?=
 =?us-ascii?Q?BCUgg9ubYrwEZ65VkbAxT9FqIdSga+hwH8oPihjdZuCL0vw1troheCSMkRdl?=
 =?us-ascii?Q?cGV3CxcWFY3aAH0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dl8b4XXrFXG4ZRt5JHvcgvgzpPlRyQ486xgOefNn69BXeDID3mSUyeSygK7Y?=
 =?us-ascii?Q?osjSgpPm91gyQ4+CywQYMrTyebGf68HDidpBTlCRa00u7YPw0EemXVvOCRbX?=
 =?us-ascii?Q?bJU2u86JhAqM5C4GP08ojqV4VqgbIWFqElVjMYg6Xt/4yQ3/c4C5YxIuIgmL?=
 =?us-ascii?Q?TxFkrH3MIpUYEr7x1ItupjvAxTnbc9GllZr+F0+Hxp6mhJH9GnvHJ2OuqQTC?=
 =?us-ascii?Q?1IG8zRurLYdrFN4eOG7+cSgQmFb8jFei4ErKaUNCRrYn6jvq3+gv45mmoWra?=
 =?us-ascii?Q?8qH8FpoYq+fILwHt7+SkBXeURoWfhK85elVgErVPnevmZufu9IBiW9XSag5V?=
 =?us-ascii?Q?J3dvD/4X3tCB1K0C+I7b3EI9Cy8SaP8FAetMo5sTNJIDzdj/+9h+LutsLWlC?=
 =?us-ascii?Q?QGW87fxf7lyqHwNdJ+tafwJW7Mc16VVf1pdEd/tBPTTtb8S+pAda8RxPCUVr?=
 =?us-ascii?Q?C3g+upEiJg2xsyMNypRl+DJqRDM4VztUxrbmnW8gJp6L5zEs1HRTngWWmhnt?=
 =?us-ascii?Q?3RedSBtgJIKR0LZ4wxSbs37hEOSuXh3PqEZF1yXm2iJEBvQwodbIG3afVv0o?=
 =?us-ascii?Q?Nrt70LYs5o1XvQwLNfMESFrgq5KOdl247il7AnVAxb+lxMbmfyTOiO0fLeNQ?=
 =?us-ascii?Q?FhIBIrKHsca3/9eua2F8Z/HFlJTKLjt6FxEuvDv+Q30uWZac3/8m+8LNGSq6?=
 =?us-ascii?Q?nuVxyex5sCm0S9Oz2DUHHtss20qjIj4RUhxbCY1kI2AEK89DIWImaEeNffBT?=
 =?us-ascii?Q?pHELshlJ/3/15EPYn7vn7EapplF+2kGpYiwnyqhbX9NnSFKQgRYJYiFw2zl4?=
 =?us-ascii?Q?/oRXl02Xgm8ZZVX8+M7jACQaNFyjIjbAWd8tyA7fB9J3kZI6x0+rfYGTkOuI?=
 =?us-ascii?Q?KDAOWq3TDI0BbYpWF2Rr2o9U/3NejYx44f6d7XUUQnDjPOVuwbzIPs3X0yQ5?=
 =?us-ascii?Q?h84lUY225MjVcVLxXauAmhem4foGIt+xoxpOi9n3BZG0yD62ulPxfv5KZEdM?=
 =?us-ascii?Q?wJk+xuXGzenvbKmfyIzI6c88qI7Zxj2yqu+EBiFAiBVrtpx5T7kMZunCnKzF?=
 =?us-ascii?Q?ufPr/eVv+2XRn0b5MdTOwGbFy8VLnxgT4Lz4dlQJNPr7QynMTs90DXBh9Bih?=
 =?us-ascii?Q?dbL1VhJVsItJVy06+mY5rCMS65l75ZEvFGxB7VPaM4k+MJ8z2T1rhqd/YEk+?=
 =?us-ascii?Q?UToNb7/CN/JvANUqKApdsbDJ7VQdTRuSqkv2nutXidcb0QArNgXWO0aa4dfX?=
 =?us-ascii?Q?YaVn90/6LgpdahCCOQbMuJbSjIhELk510LkNrdxPMFtmGmEHcStVgBs/j7vZ?=
 =?us-ascii?Q?/ERK6kugZTj/AZWuUwjBE1Q9fXrPv+sVXtKo8DYJEJx6fJR6jcDC3a7T57el?=
 =?us-ascii?Q?rLmeEApDqZc+u1ZlrkYvTzqEHSboQasvuGUgB1SH6qyF4JV5TFusoiY/6lWt?=
 =?us-ascii?Q?7m0LT9VJB0C7uVuyFMJgXQBrXS0S/yszLwYcVt8iB6NMgVuMlzXGD/fOTMSj?=
 =?us-ascii?Q?su2bvwg5/K4jIr8ELJKHKVlNfq83rhxA2y6DuaBk8KDhCxLqyuiWqWQkFVFA?=
 =?us-ascii?Q?68FgNOsI/bAyB9NAAgA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94e96b8-7532-4e25-0604-08dde14e9845
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 07:36:23.4292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vey+t946C4ws82KK1n3lvUFk4Hhycpwzwcijd6kcQBCdH6r+jhsOlMcGrEGlJ+7K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
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

x5551800 =3D> 0x5551800

With that changed -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

-----Original Message-----
From: Jesse.Zhang <Jesse.Zhang@amd.com>
Sent: Friday, August 22, 2025 12:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Liu, Leo <Leo.Liu@=
amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhan=
g@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevi=
n) <KevinYang.Wang@amd.com>
Subject: [v4] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization

Update the conditions for setting the SMU vcn reset caps in the SMU v13.0.6=
 PPT initialization function. Specifically:

- Add support for VCN reset capability for firmware versions 0x00558200 and
  above when the program version is 0.
- Add support for VCN reset capability for firmware versions 0x05551800 and
  above when the program version is 5.

v2: correct the smu mp1 version for program 5 (Lijo)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d65c912d2408..13fb5825e24d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -312,6 +312,8 @@ static void smu_v13_0_14_init_caps(struct smu_context *=
smu)
                smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
        if (fw_ver >=3D 0x5551200)
                smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+       if (fw_ver >=3D x5551800)
+               smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
        if (fw_ver >=3D 0x5551600) {
                smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
                smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE)); @@ -437,7=
 +439,8 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
            ((pgm =3D=3D 4) && (fw_ver >=3D 0x4557000)))
                smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));

-       if ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100))
+       if (((pgm =3D=3D 0) && (fw_ver >=3D 0x00558200)) ||
+           ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100)))
                smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));  }

--
2.49.0

