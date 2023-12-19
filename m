Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB35C41535
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Dec 2023 10:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811AF10E45E;
	Tue, 19 Dec 2023 10:37:26 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4F110E45E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Dec 2023 10:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvwWAytbj5yq5Gj9XLf6uGo6UWV5HbT8bAug5/XxjFn6DhM86Wuu4cKxUYzcaZ9W9ji0DE2cN/0FgPj/c+0Peqfs6++hjIFLn7a6IensRbpKHR7LDIXJERNEMdAGS6QjiLLF8RQPccV3TAoiqes9G4+BPl+sBCf6++pr5tRG9RMo0BlDm2qN0sJx26vq25A5iA4v04nw6oy0kP0OSeU2b6oiOfZzByhBt3FQ05gro6/fyhF8g1ejRisx5UoRU8RrfZxQZhza8ug+VsQg8Ivactf130gD6C0oC+Hp6KKTX6IDCK83Nx+wq1CxfUM31PPEKBEgzIo1yhLYm4eb0bOu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//doSwE7nuq3EBTMkgC8T6TFVVd51e9H4IBgIBGrcQ4=;
 b=j9BWruNQ80LrzMklKzM5JZQnwk/2Lsxpo8Q1jzktrxSzlagk/yshCKmPKN82C4YGMon4KtYilSb7Um/y8QNzSIM1YOlGpOdecPJ3HxPf0tYw3omuX8DuS47CguWsRiKyl9YUSftdqbd+afzK8aHT7XShivcRe3v6+Kx9tvBzfh2rE/hclyASHibxa3DcRMsnkzdFkv6D4+p2VtrtdgY26lgFjJ9UbWXjP5knSA/s002Td7gqRhFJ6z85+ZNsuHza9AAZW6EwVVxPtMUqBAhw5msTkDCERNz0E786MRNEzIi6gvhBhYSvGcLvhCx7E1y/9XjZf1Zge9STCmIAdbnvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//doSwE7nuq3EBTMkgC8T6TFVVd51e9H4IBgIBGrcQ4=;
 b=gXCPfRQ4MX6U+NkzzGqQyzY5NgcMu33AJM2qa7bKWfu2E/ajZngw40oQFnp5XGibT/dc4Ot1qRKQGO+W+lcz3LONLD5xOGrM9COL1/dpQCaIudHkMiT38B95AarTwPihYXiifWIj7cQ8KmHjFFJ4RsSrkimK6f98Q2T+7MRHzGU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 10:37:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 10:37:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET
Thread-Topic: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET
Thread-Index: AQHaMl0dZ00NLgCbR0iZqCdJ7eQufLCwaVKQ
Date: Tue, 19 Dec 2023 10:37:21 +0000
Message-ID: <BN9PR12MB5257E4DAE8AEC73DCC4B92A0FC97A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231219092340.1601929-1-Jack.Xiao@amd.com>
In-Reply-To: <20231219092340.1601929-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4a8ede88-8165-4ac4-a658-4cc462ac262f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-19T10:35:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV2PR12MB5869:EE_
x-ms-office365-filtering-correlation-id: 9284e5ab-63e5-4636-f017-08dc007e7b69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SfDTOcsUyo5aJCaH7fSerYv950GT5ofie47oo5kOlgbebIHBK0G/CpHEWDQttW1q4dxcr/AmNn+LuGJ0xgnPXfWYGWtDDUegG0ytyL+/WS3EoFHf9uTU/ECp1IGyObTSBTOXTfj3tcM+dhEALJpm6JPfcwjuLLOPsrIUFiKnttPOK2L5/L4VwVT17ELkIRSPHOIDqwBNQ+tMeEd2haWecT/qv0gL2g5vILXjd6+vmWKGUOnDYbv0bxV3vin9nKc8UaVY2iUd71l5Fk327eq4tN1NfjbLQ6jn/S0M7Yr4AM1oU8UlcbQwf7yxnFCYeDe/z9vYI5RA0alANN6juB3gYvaxckg7ym1UVLYPcCHyoQ7LUCQgJ+4frbirnDn1TVC8oKDVaLGYY0Aom1uwhrVw1h3em9H8qQqdczDAlIkvdZYu7MFx+bdX/H/MgV3N/w05fzLajeNg7+3bpzp3OtriNa6l5jq0nITCD/xEINaSMUZAHAA1FHfYSo3bn4Aw9+Pj0e0s5BBBm4R3Bb74EB3mGwbKF/dIdsA+5it/pG7uGA8TWsBqNl0Roa8CwbQb5hgKvyZY621hRvqYNtBXz6YrbdlSC/ppCptmlr6KPE4JJNu9yDnpKviCQY+pCg+Lltiz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(122000001)(38100700002)(33656002)(38070700009)(41300700001)(86362001)(83380400001)(8936002)(8676002)(71200400001)(478600001)(55016003)(26005)(64756008)(66446008)(66476007)(6636002)(316002)(66556008)(76116006)(110136005)(66946007)(7696005)(6506007)(53546011)(52536014)(5660300002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gOF6h7uCIa5e8FxUnTjnijgwqdxmCU/PEmm/Q/fiNU70EGjrYuN/cgi++Dpu?=
 =?us-ascii?Q?IPyHbCV7yhtD1tzXDcY7CStuUERVoY25ycIn5/gwLWZy4wKP5Ms8QNTR5CVl?=
 =?us-ascii?Q?3M3mE/tDx6Z7bUR3FUcEgav07Zcv44WLB69L2+BQ3IbAJRPGNMEZM/2ygXIe?=
 =?us-ascii?Q?vuR+4KjpzofdJ/tWLmUFJv4nmBn86EIQPrvfuCJj1Bh5JccvvnQDKkVnwFdZ?=
 =?us-ascii?Q?yWqKyprFOPs857bBnJzPbkkRJVUTJMdCTZkHTC61KJOSiFbc/4fAHcpsn7fs?=
 =?us-ascii?Q?nnI3IWThGAsLobHZtds+XE1Sq6wxYLkIshkSbDgK16Nkk/9XIYa7RgvxQ9sH?=
 =?us-ascii?Q?xtcmwdAQZDx+9KODabsalqkMkm0xKyBjWsOHTYrr0enLT8dA3oxAJkjGIg3w?=
 =?us-ascii?Q?G+rDnJWF8f8TNUbaRRExUT2EDSgsFukJF9IzmPQQwh065h55myI2oUFG+hSm?=
 =?us-ascii?Q?fgSrOJo9W6BSgVFT9pqmPmXwOtGHYfSyIA7CufdpgkSMOJzT8WuCE3xucJeL?=
 =?us-ascii?Q?c4kLhgVoYU9GJ8EkNWiITYkJxQomLDgdhUTRbW+ryhlu2BKW2RaMIBr4m+OU?=
 =?us-ascii?Q?f7+ZDpTmJO1wyjAPQxUceVrSNqV8D9nYKqhGGMYZx94golOKc45HmXeXWCUg?=
 =?us-ascii?Q?ImAVSqvC+IKV770kYM/dMqDmXG095RgdT0Qna6G07nGN/Sv6GFjsPP7KirZH?=
 =?us-ascii?Q?v6Ltl6Z0fMAD0EkHIuAhCKR5i/pMv8PD9sV55FSZUt7DdB50B6NRwUB5TjBf?=
 =?us-ascii?Q?96v/77jf2xh5zZkyDnt54RGH/bPHHaXzhM3oZoRsGmkMNTk5BTyYfSIJDikJ?=
 =?us-ascii?Q?ZcBiZ13J9YVfAQHWgDSWpmvZp7fghC1lDWXKThi5j8GpfaJxtAJbssfHKz+o?=
 =?us-ascii?Q?oFjSyRZ6/qUXPzc1bVR+iKvvC+8w/Cqn7LeSLXx39IeNviJU+DFARFT1touB?=
 =?us-ascii?Q?pshZqcH+LQ0MxsiZzOJjvPpJXBoGJdl6n/G0mfqMWCggLqT/wj5Zt5ZcSn5V?=
 =?us-ascii?Q?sQSspTEAC8nPgVxrdv9ibOByWF97qIlaD/U5rlwGPbpnEEvHbLkn8jfwWi1F?=
 =?us-ascii?Q?imC999mVGc7Jpzdd7X3S1PeaTT4j+T5Rgzou17/dZ6fWIbqzus3e2qC92J5X?=
 =?us-ascii?Q?7ynRZdOZclawPLK0JWG2XDZIbrTpl6luudT7M5Gt8AmdIAd6NWlyyy9qXPQh?=
 =?us-ascii?Q?E4xZxpkJ+8+rKcx5g2NouuMmv1ORYDodEMDtWpu0vIz86k/ETF+z6yOUapok?=
 =?us-ascii?Q?XqqejzNSkBsF0LGDtjiKqAV3/NbjecHFm3Ty09VmdL29taawHpSfXMPVwbrC?=
 =?us-ascii?Q?fhTGjGWUBghzdzVYHOCCtHj/zXBKlK6cfhZtcr6Uh44DsTQx84gkLNw80BOs?=
 =?us-ascii?Q?VijtytQStc0i+EQz/WZnjmbkPWFrjNlTj98bBZhc7ZTQOrYODKg10RfMuo/8?=
 =?us-ascii?Q?NLJz59YgYjPPlcvt0kRiclli+gDQincTcHwdSueJxVB/k5KhxXsLbjR/he+i?=
 =?us-ascii?Q?J+4y8yFGJk7v6nrRw9Hxc8KaJBL5sCNSDViOLKw+UwX+Fn0viME1sflhGp3S?=
 =?us-ascii?Q?zjRVkBJo/odEK68kgNoUshVSVRjrsOSYS7jBTqBA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9284e5ab-63e5-4636-f017-08dc007e7b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 10:37:21.5874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3eRLFG/rjJYuUHiFW3igUAB14HOPOtNBSwzavZkbyBrb3uLHW4mA5PXdrfXpNDXIIIonWCznGH8knKfwODRow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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

+       /* release the gfx mutex */
+       tmp =3D REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, REQUEST, 0);
+       WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);

Shall we add a check by reading back CP_GFX_INDEX_MUTEX to ensure the relea=
se is done correctly?

Regards,
Hawking

-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Tuesday, December 19, 2023 17:24
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: need acquire mutex before access CP_VMID=
_RESET

It's required to take the gfx mutex before access to CP_VMID_RESET, for the=
re is a race condition with CP firmware to write the register.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index bdcf96df69e6..ae3370d34d11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4518,6 +4518,22 @@ static int gfx_v11_0_soft_reset(void *handle)
                }
        }

+       /* Try to require the gfx mutex before access to CP_VMID_RESET */
+       for (i =3D 0; i < adev->usec_timeout; i++) {
+               /* Request with MeId=3D2, PipeId=3D0 */
+               tmp =3D REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, 1);
+               tmp =3D REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, 4)=
;
+               WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
+               if (RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX) =3D=3D tmp)
+                       break;
+               udelay(1);
+       }
+
+       if (i >=3D adev->usec_timeout) {
+               printk("Failed to require the gfx mutex during soft reset\n=
");
+               return -EINVAL;
+       }
+
        WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0xfffffffe);

        // Read CP_VMID_RESET register three times.
@@ -4526,6 +4542,10 @@ static int gfx_v11_0_soft_reset(void *handle)
        RREG32_SOC15(GC, 0, regCP_VMID_RESET);
        RREG32_SOC15(GC, 0, regCP_VMID_RESET);

+       /* release the gfx mutex */
+       tmp =3D REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, REQUEST, 0);
+       WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
+
        for (i =3D 0; i < adev->usec_timeout; i++) {
                if (!RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) &&
                    !RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE))
--
2.41.0

