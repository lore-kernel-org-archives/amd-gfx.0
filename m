Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ACB606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Q19meuYc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DAD112ABD;
	Fri, 27 Nov 2026 13:04:41 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C693112ABD
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 13:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDXBnDoXTb1Gq8jZyZFplCifPRePr6Jqs39MVet2bkY1dm+45Xcrrg/RGmTs+AytHYcVOMTQYBpuqoP6q9Qff6uhIZ1C5iX6hTIA7lb6OidCT7ST44hcTodhpYIHLRQYJ3FgNfjZNSmQWd7BGNMV6EY65FG91zgkpvgc4506zeQLIsBPAMaN13sma4UStr27Mzul+vpar2WBw3MjZ8Vgrwd7dIhJvFnXKedIBVxIxVTGB8/PajCgSd20xERI80QvACGMVm4HUPWusDSTMLC9fclSq7BnhgKKGNszec0kaXHLT72OL09xWNRDGUhg6j1FYlWSCVHPEeSyRSKwC57+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKcR0zQq5hWPqnWBhrgF5xo9j9g0B57mAZomHmtiiaU=;
 b=bdFhykDnu6LOwVglMAINW9kjsy+slNGEodOpzeRtnaUFcI7ro1vahWp0nfdX9k0NcFzl4CCJTvIhkpPhsGS8K2p7MPr43/PS4HvoduEMz2hHxb2sgwmgNH0HCXyJJ63b3Zn/3MTeyPeIvLqGN67v8hiFhXheWf22gWRNrbegKCqog9cy2mgUhVrO0kL8zKeCbv53RTu4QNenqjPWg5j3c6GclCZ833A2I9LEREbxGE94dDdQ+fw/supWhIOM/Jy+F01qhV2Mmcpt07AhhQGwCuGFaVI7NIaj7c4Em91oT3oQtnqJS8AvhNEzRLhUJIYSUI8rByNJj4y6NZZKBBJlkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKcR0zQq5hWPqnWBhrgF5xo9j9g0B57mAZomHmtiiaU=;
 b=Q19meuYcgjuSN4gEEVKJzNEUd/SCcsNbCl953wRKAgJeCqfTxvl1RXHV1IOO7lstx9WNzlFryt0iIM/mUcD5bph3cbj9mFFYliZKLXANt8gdb68rC2mHcYwO3qtkwSLVehUm3qbki4nW+hA3gi6BRnY9QmAIWF4uhhWCqeJwSMg=
Received: from SJ4PPF48ED87C81.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::907) by SJ2PR12MB7865.namprd12.prod.outlook.com
 (2603:10b6:a03:4cc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Fri, 27 Nov
 2026 13:04:30 +0000
Received: from SJ4PPF48ED87C81.namprd12.prod.outlook.com
 ([fe80::ebd3:b410:9ff7:4a55]) by SJ4PPF48ED87C81.namprd12.prod.outlook.com
 ([fe80::ebd3:b410:9ff7:4a55%4]) with mapi id 15.21.0639.012; Fri, 27 Nov 2026
 13:04:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Avoid MCU_CNTL access in SDMA v7.1
Thread-Topic: [PATCH 1/2] drm/amdgpu: Avoid MCU_CNTL access in SDMA v7.1
Thread-Index: AQHdfLDKxhvUpVeuK0mVzoPgFuKJcrdB5ihg
Date: Fri, 27 Nov 2026 13:04:29 +0000
Message-ID: <SJ4PPF48ED87C81E87581DAC890B75892CDFC412@SJ4PPF48ED87C81.namprd12.prod.outlook.com>
References: <20261125074359.3144477-1-lijo.lazar@amd.com>
In-Reply-To: <20261125074359.3144477-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-27T13:04:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPF48ED87C81:EE_|SJ2PR12MB7865:EE_
x-ms-office365-filtering-correlation-id: 30583be6-bf8a-494a-b542-08df4c86f8fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: //f+G15BciOhk+h9pUIg/d1N6RVHK5ZABWG4JU52Bnikd3uXXWkHi2n4X2l8icQDt6v+g7U+1lpuaeusSSUZfwArSFXZlmHccd5C4bEDzfJaRpZ98cRiF4htrMqFGfqzPapxO51wU4CYacpRUo5Z0la3J2C5KdIZacnylmzPYRTuJJfbutW4xy9JYSHsuWrAFBcsL5oYHSAXkpI+wNjagdxuVKvKPnc5B8w4LZ3TgRX0xu6PBVSfiEPyfCoY54V3SLxwat8dX/Du5rybyDvAsckaasj/oDD6PqcjZB1pM4tbc93OMdTBbpV+sfhv5/0MwV+PT1usV+cf9cRMoEP05FFrvMuL2yFbsVK4AUji1hmTNKqUPpRYdzEz+4wZqh1UH5ZHNmQUtLhU/z21H12aQzaGXdZk77iSEawSpfdmCJmIC7cc0OtH8ncHgtbpQUwD+wBOHRRA3YTxrTH2olqYi5SCh18flB5YBSy+DoCngUVeh5iqB4WOL1aL79UgAHk4rn2TzMS9GW+lRXObc8hMLgqCDZ9XUhW8CGHi0ElCcvoygUA8S0Y2LI7S4G0cUJduQ/VlE4voT7Ai/vRAIEtJbK/W7aAQmNUudV/YwX5Hc/pLGuq4abTRe9QhBjA1vsosTxXGdDFtnvV+93D5L5352ACOLe9mzbSdnyEHIges4lustgiLKxv7T4akE1U+eLdGEXV2JHaH3oQu8hGzW4PAAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPF48ED87C81.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?koG7XK6NUdU3PNK7L3emTdCCWOtIW5L2ocnWkj9BtNkqGBPB0WSbNzMK12S4?=
 =?us-ascii?Q?JrCkPe8htnIdS6Tc/TFE92mID6YAlR+T6RryM6iVk2R0vyEW6wrU7f1UcskL?=
 =?us-ascii?Q?u0wvHIjLJHSehEDIsX8ctzi7QZmITdITHcGcC0z5yhbwXDq5QGULuDs5SGJ9?=
 =?us-ascii?Q?398991X/GAejlua5J2QlYGeTYY40cwGc+ryQlzQn1oPFD9KJfQdXFS6DkKWd?=
 =?us-ascii?Q?Wvr1Pk+tMrnX8hKDeLXAJUXZ0Req5ZdwjMPw2deT+63ku94IBjwbkmVfys6e?=
 =?us-ascii?Q?BoZO82/j/oG8NISrJDhniA5aghV61E8+HrOx3reBjbHYx74/KG2hC54xAf+9?=
 =?us-ascii?Q?EWaZ+hsAXvskrC39OrJHU9IHWgIgo4lgbc4FHLrlLkHHvEfWq1gqhDhW+t4d?=
 =?us-ascii?Q?i6XJ3p0y8gk82q7j1kB5M2uosHwLDJJr61x/Xy4oa+cPtcjbwkpLT8FJgGIH?=
 =?us-ascii?Q?OipjwwKDt+hlt7IVV099dmqJ8OH/51OPF24T9GQ9YK6FXaEfvhPIYlF7Ittw?=
 =?us-ascii?Q?ib58w33KiD9IEYp+rkMlux9zaTorAuxNhomDiIig7l2K78oBXi3BEEUT8vQM?=
 =?us-ascii?Q?ZTNOmpDqALcTxFNWWEgJ8bZkgD6zRtmVAwWFbHLGBobaQd518sfcyw9uZFPJ?=
 =?us-ascii?Q?PabPOEpaptRxZ3g8abxrL16bZ7O5/8GEJgqa8HYUIXVhFeSGzBga1PyKniWI?=
 =?us-ascii?Q?U5Jnl19tSmNA5blagNb1zycCQQlunf/102O6Hy7GsBwd5oPkjgDX4aT+mU6G?=
 =?us-ascii?Q?QBoCs8MEp+Z5XsANljsXBYrPH2HlthZe00Ni9/Z1lzoj5+cIkTEwon7Z4DBy?=
 =?us-ascii?Q?VTI0xqIhEZC/hUTlnfzk4GZz8h7B4b/p3W80D70bTSEgETzhMLXpDOZT0hwx?=
 =?us-ascii?Q?lEXUvgJd4le/ddDcA6A6odzf3FKYnxgTZT3rnZQb8PjXAiY/ZRqLD8ylW6Sm?=
 =?us-ascii?Q?KMPy1wBG8CKug5BRqBL3AZcQ3Et35/IHP1I1AWsc0WHpG9qgmmIXejUlTQPz?=
 =?us-ascii?Q?yE2D8WoDxEe7L6ZmjY9fADZGkhYbZDkdA0kbUKUFhlqNSh62+kL7/p7XKAi/?=
 =?us-ascii?Q?KbrCEjwxLqPluqgmic2pfGqp3ZMax91IglBk2VCaABvYLrRSTtheaXmCx7jE?=
 =?us-ascii?Q?OIfKjzkFk2Y8Kt41Q6S0/XWD70DozGlUx1ivcYnawgtHCBUkJXH2zMZPEBkv?=
 =?us-ascii?Q?8ned3mlPAsLefJuG9fkObkghlDEChy9XRMFx3nIbviB7zxWf39I0Ug+lXw7c?=
 =?us-ascii?Q?flrV4FIz1NyHRBE56PauRl+5jQ+21BxFSMM8fIA4O6DDsyLO+Awo3rxOfl7D?=
 =?us-ascii?Q?KDaSifElyNAUT9F4b7Apz5OT1oEH2E8mkRqQcwiZQmrHOStyPRnCRjUN2U9S?=
 =?us-ascii?Q?ieUJCT99PatQxUJVjCpzQJYXm3eeBvTPqONn12jqvyexPlG9b1sSl6Uu2dUG?=
 =?us-ascii?Q?qX2abECliSk/xn/WP4QzMB/A3MbukOPR8r4s5NGOf0C+eQNS6xI1m26G+mAV?=
 =?us-ascii?Q?Fz7jZ9r+SeYPfdVsQNToyFVmcLeYQAHwra9AJDR/uq2/Im4cNc5ds2RQIkO2?=
 =?us-ascii?Q?qcOKEO95tER6msI3wEQUqsjYknRnEcXMDdN1i+xk32ZUQ/AXO0R1V/8zYSnx?=
 =?us-ascii?Q?vUl1PmDN1v34PZO0qdUJZTcUJpVarMazbNJXS5hi5bKlTpQmhf3X0JAabwuw?=
 =?us-ascii?Q?VEAUKjCR3gX1yjLSK2QmJuB3Debh+kseU35FYYIz0LOv4CE7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPF48ED87C81.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30583be6-bf8a-494a-b542-08df4c86f8fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 13:04:29.6236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIcMYV2lv5+Do013nAz5F4HPdcG293g/+Q1AUS2CA3O/KJbT66uKNNlt7bqmc3bCo/zRW95otjBMXKMXfs3e3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

The series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 25, 2026 3:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Avoid MCU_CNTL access in SDMA v7.1

SDMA_MCU_CNTL is write protected, avoid access.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 33 --------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v7_1.c
index c6b2c46db4c4..3e8facc0358d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -436,27 +436,10 @@ static void sdma_v7_1_inst_ctx_switch_enable(struct a=
mdgpu_device *adev,  static void sdma_v7_1_inst_enable(struct amdgpu_device=
 *adev,
                                  bool enable, uint32_t inst_mask)
 {
-       u32 mcu_cntl;
-       u32 xcc_id;
-       int i;
-
        if (!enable) {
                sdma_v7_1_inst_gfx_stop(adev, inst_mask);
                sdma_v7_1_inst_rlc_stop(adev, inst_mask);
        }
-
-       if (amdgpu_sriov_vf(adev))
-               return;
-
-       for_each_inst(i, inst_mask) {
-               xcc_id =3D adev->sdma.instance[i].xcc_id;
-
-               mcu_cntl =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_=
MCU_CNTL,
-                                              SDMA_INST_OFFSET(i, regSDMA0=
_SDMA_MCU_CNTL));
-               mcu_cntl =3D REG_SET_FIELD(mcu_cntl, SDMA0_SDMA_MCU_CNTL, H=
ALT, enable ? 0 : 1);
-               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
-                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_C=
NTL), mcu_cntl);
-       }
 }

 /**
@@ -631,16 +614,6 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu=
_device *adev, int i, bool
        WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_UTCL1_PAGE,
                            SDMA_INST_OFFSET(i, regSDMA0_SDMA_UTCL1_PAGE), =
temp);

-       if (!amdgpu_sriov_vf(adev)) {
-               /* unhalt engine */
-               temp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_=
CNTL,
-                                          SDMA_INST_OFFSET(i, regSDMA0_SDM=
A_MCU_CNTL));
-               temp =3D REG_SET_FIELD(temp, SDMA0_SDMA_MCU_CNTL, HALT, 0);
-               temp =3D REG_SET_FIELD(temp, SDMA0_SDMA_MCU_CNTL, RESET, 0)=
;
-               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
-                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_C=
NTL), temp);
-       }
-
        /* enable DMA RB */
        rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_SDMA_QUEUE0_RB_CNTL, RB_EN=
ABLE, 1);
        WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_RB_CNTL, @@ -8=
31,12 +804,6 @@ static int sdma_v7_1_soft_reset(struct amdgpu_ip_block *ip_=
block)
                //tmp |=3D SDMA0_SDMA_FREEZE__FREEZE_MASK;
                //WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_FREEZE,
                //                    SDMA_INST_OFFSET(i, regSDMA0_SDMA_FRE=
EZE), tmp);
-               tmp =3D RREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_C=
NTL,
-                                         SDMA_INST_OFFSET(i, regSDMA0_SDMA=
_MCU_CNTL));
-               tmp |=3D SDMA0_SDMA_MCU_CNTL__HALT_MASK;
-               tmp |=3D SDMA0_SDMA_MCU_CNTL__RESET_MASK;
-               WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_MCU_CNTL,
-                                   SDMA_INST_OFFSET(i, regSDMA0_SDMA_MCU_C=
NTL), tmp);

                WREG32_SOC15_OFFSET(GC, xcc_id, regSDMA0_SDMA_QUEUE0_PREEMP=
T,
                                    SDMA_INST_OFFSET(i, regSDMA0_SDMA_QUEUE=
0_PREEMPT), 0);
--
2.49.0

