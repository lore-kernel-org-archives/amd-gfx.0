Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC59C77B72
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 14:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3117910E033;
	Wed, 12 Apr 2023 14:03:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 906A510E033
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 14:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fel5pbnrlLeIWaSUUs0sEfXIrsZ+YDi1IuyJGmErHxZjKGKR7inQOFP+uHwXS5Fvjmd2vzbPOtX1S4V8H+oDydSNrlvC0bR7mUVnx/+On+7JuUveu+jVReqxckjqSeRkzaiaIF0l056qeZnIj9ftPzvWcJQpkeMZS84YfTJg3cbsWN447DTpbhAKDi4NEDPdFTfni+ci9QHjrrLBb/Uj9/Xr09nrBKm2YnVVSJcw0ynLEEjNIbVxLUp777S3Jrtl/SGTQWFKF926+8QGN6KKzCdrJ6NDY0KGCv0sQpWTXC2IgAcEcjoI4En05QPKh6LTdUa864gwLXNsXg45UFr3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FdLm/GSXt0/tSI7vt3ivjh5x4r3JCdPW8sb4aKK7Nc=;
 b=JUv2kimtRr2/2QYOv3/qP7Ba0DmFKAr81LSzUjIrUbiyNymIFaeuUqWdnN7zjOZdEr0KmKa8M/ef4P6mlN3cqGBus+gmTo5NhX6MGqGl4rHCgpE7of+ioaupJG0gZJuY+FOp7JlkX5pY/7bebc/bf6q5/rHm9refg4xC0Nn7seOaF6PMmyCyeAQudAKoiJ9KiB9PVnbinAYZDP/x9J1MnPjb0r5aac0YF2zxFvMP7eYnfrm7rsemm3vwn6qy6eK+CmEW2U8Za5tkAWxl0W/K7KeWxhpiyZjT/eY5ach6CToMRJp12PjRDjQTjjKtV41kWdhs2Ni+7FRafKwTH7Yn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FdLm/GSXt0/tSI7vt3ivjh5x4r3JCdPW8sb4aKK7Nc=;
 b=vJaR1MFz0AnJJC/LfB7c66wbGiJNp0Pk1NjGa4Xmpu6Z0Jh7WDufQddcRuKRFtjzbCmkzvfvlVE4fDlh+EkHbVE2JgaZOazaUqL7qgFNN0N5qqdp1AHID0/gtcHR5pke1bt3eXPBmtyIrIXu39QxHYfg4591ZK74Pn5/WkNmCGM=
Received: from BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 14:03:49 +0000
Received: from BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::667e:c725:d563:d13a]) by BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::667e:c725:d563:d13a%3]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 14:03:49 +0000
From: "Gui, Jack" <Jack.Gui@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Gao, Likun" <Likun.Gao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: drop temp programming for pagefault handling
Thread-Topic: [PATCH] drm/amdgpu: drop temp programming for pagefault handling
Thread-Index: AQHZbUdqgvLUTV4TB0OcU9E9At16Sa8ntIKg
Date: Wed, 12 Apr 2023 14:03:48 +0000
Message-ID: <BN9PR12MB5244DE365724DF67B9DB36548B9B9@BN9PR12MB5244.namprd12.prod.outlook.com>
References: <20230412140148.28633-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230412140148.28633-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-12T14:03:46Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=12e84b30-928c-4de4-b805-416a7d52287d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-12T14:03:46Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f58621b5-2374-44cb-a6c7-b3e476439931
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5244:EE_|CH3PR12MB8260:EE_
x-ms-office365-filtering-correlation-id: ab20a057-386d-491a-bbf4-08db3b5ebd30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2Yu7ogkwJf9rW7TR0+CgWRCZDqbBPBAYRu+6ztkBtKAcNnrvfsOHDbzShHjx1yZb5IvvNfrI/sehXtqS+DXB9cYwQ1wVq7btN++XiKu4r4Ks9s0sDeeX9YzKMyecAIpFi9+uwscWsaskuNuA+nw+NvGQ7FMZepV+ziLIYMrTC57+en2kCvWRx9sjwIIaV91xbUyQC5Q6q6okoWZd8hF4XKZWIF6u44KpHgwRiYd4gInEy7vfrNfG/SX3VA9sHQ+EnYk2QKSa/Fhmyf83ezkeICdrLiCHzjA2pAf74h8RPEF4nGG/LjBVarmg7oKTbQ5Aa/rK7ROWAfK10UuR/gls5mOOCKZfT5Zaa2G0LpIrNo5Wb0ekrnQftlX1CBwZqaVlYNaloDYaONCHOjS6JjiurhajFvD1wOq/an8ZVDm9ryVp+K6EBN8ZpndzZ7n3YO7G39MmXdXJWVW7bgZzM0Y5eyOjLzjlpA4G60fQlfmfHlb02t+f4G5JQVFJJDuLOLxhs/t2NPxStsOMHsVFA1jIvqjeQLp21j2GEl7DJJGqvHZhxaGMXojdx7bc/WdRlKsoY8m8Z3m7ac7TaDiYoygCvxBcAA7+yorbto9X5UQWbcc4TnNa4k662i5c8cgngy1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5244.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(41300700001)(478600001)(76116006)(86362001)(316002)(6636002)(71200400001)(64756008)(8676002)(66946007)(66556008)(7696005)(110136005)(66476007)(66446008)(8936002)(52536014)(38070700005)(5660300002)(33656002)(186003)(122000001)(38100700002)(53546011)(6506007)(9686003)(2906002)(83380400001)(55016003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y6sh84g7uxoQ7dU2LgYGAdk056JFzA5ST/MJBLgbQ+sj3lgMLI2eHBwCoQt4?=
 =?us-ascii?Q?7+AxPfBEmXyRHDPlM7cmEZ2nADR0cP64ydcZ8j86k7L0ZR9ZDh/TJpoML06k?=
 =?us-ascii?Q?G5ZZ7hTOoRRb0JLmR4ovxo/ZYv4+8VcNhrip8mGJOam6l1Bxh7zIFtG968Ea?=
 =?us-ascii?Q?X2+UiUpuVXxu3NoKp5xTtImrvBqoaHuB2uA8xHfCVPVAWP49QgC0azLCrnU8?=
 =?us-ascii?Q?V7JqnX6IPWzElt0Jt1jfnvb4mzFs7vPenC+gez0zczzCf0K6gVQiIkUk8flh?=
 =?us-ascii?Q?5Vy2H4ou4iGH6wlLkyxBhmTxWc98wk9d7+pVJm6nwkLDvDjPCi/Zvuc+dCLX?=
 =?us-ascii?Q?tUfPVRIZGM4K1NjPCEBTPKq5Qj9qd+ak22F21/yL5cvdR1jUuGvF+z9XLCDK?=
 =?us-ascii?Q?5u7ttALmushaD33nrJTDRy+FiMRT8RQ0TLoRASCKIUYe2mJhZ5O+OffSYhJq?=
 =?us-ascii?Q?3DvR+F16IHcbcKmWQMpPy/o4Cx9AjyOO/htN+b9EnAV/iID0aqEPMi29MnV6?=
 =?us-ascii?Q?kFBbK8rdrsb3u/PDFzCWDtcvmzV65hGscWZbllfa+dspui5SSbdzbngMNBTH?=
 =?us-ascii?Q?ptzquFeli6Xm2PZ662vzXbHaDw1QX8bXD8QbEnIL0AiRqisseH3qTCtol+Bx?=
 =?us-ascii?Q?QCTop22LiJrSyfyMn1KFoWklJyx243Ta3dR0KDBxpxY+v6cEEy6dWKwSne3N?=
 =?us-ascii?Q?87DX4MnyUCtPOowlhDwVPH9LInbqICQH3nbDoE6Tm1wHC7LdFfdDBMrxMKRy?=
 =?us-ascii?Q?qZxNIzuH0mu8xJ8AQaydl986zfBAFOYmR/oq/IWX69UzK+HGH8P9e+peKSAH?=
 =?us-ascii?Q?lwpO+uHgjVQS0hkEqyCQhzfce0I+09OPmV8JhQZ7QoRUYy1PpWaDyaRScX71?=
 =?us-ascii?Q?ulkAwYvC2xuktK8BPayR1IAxivUSzkXbRVPQEmFCoxpYRNpQh3DSWZaEvOG9?=
 =?us-ascii?Q?j+Lb1vaWMnX6kcfmLvbNSjZVastSb3SCXznikZOn9RGSy4zPXfk9nChgvSI9?=
 =?us-ascii?Q?Lw3xt/qabSUzLJQLkIqjGfZi2+aOY3n8I+8P8LMd0vLt3pSx1P8WSF/ptkwu?=
 =?us-ascii?Q?F1CsfIIwEpSmRVRlRSnYxLFdk08hVr+ECRzUJ1N+4mJYANv5yYY6pBxxlrjM?=
 =?us-ascii?Q?/tXnWDrA85iDzCHjZd0lSbEleOc/5fQ1j5a7v0IoWyzJKM0bZ+NQSOluG4iH?=
 =?us-ascii?Q?vuV68B41mUobFh+D6Os+oyDj2k1x0VHaoSg1ARKVb4ncHR16Q6Wz5ZD2NIPM?=
 =?us-ascii?Q?CRpKTVoOH0krBF6rrkqBLAdOcZgN7cGLCExzKy/rKI5sDjudQ/uSnV9EmzRG?=
 =?us-ascii?Q?Zj+T/q66G56762h3A3KFMQc8CCiUy9F7nJbd99rpNsVUkq8VisASU+LnGNGB?=
 =?us-ascii?Q?xt9HRnrjh+xvkpvCzPEG8KAupMuL3/kRKXXB6dKIXzlt2WNLpqMocCSWnBF1?=
 =?us-ascii?Q?2AwZ88QszT2XvBydbUrC0axhSnkFedMmErYXlj2xeFzxdQrTFaHjlwtEWtsb?=
 =?us-ascii?Q?hOC7TdAGtYtbT94IvMYf1oS9fDn7mjh1x7mseZfNz1V3om+9tUBhsI05uan2?=
 =?us-ascii?Q?amWIZt36VsKpSwi2AB0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab20a057-386d-491a-bbf4-08db3b5ebd30
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:03:48.9757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONcCGCLfFlUtBna7djNYxuk8p54xRJQVjcw107YnZnEFW1huQ9jInLtm/0o5vxY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
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

Reviewed-by: Jack Gui <Jack.Gui@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Wednesday, April 12, 2023 10:02 PM
To: amd-gfx@lists.freedesktop.org; Gui, Jack <Jack.Gui@amd.com>; Gao, Likun=
 <Likun.Gao@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: drop temp programming for pagefault handling

Was introduced as workaround. not needed anymore

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v3_0.c
index be0d0f47415e..13712640fa46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -417,34 +417,12 @@ static void gfxhub_v3_0_set_fault_enable_default(stru=
ct amdgpu_device *adev,
 	tmp =3D REG_SET_FIELD(tmp, CP_DEBUG, CPG_UTCL1_ERROR_HALT_DISABLE, 1);
 	WREG32_SOC15(GC, 0, regCP_DEBUG, tmp);
=20
-	/**
-	 * Set GRBM_GFX_INDEX in broad cast mode
-	 * before programming GL1C_UTCL0_CNTL1 and SQG_CONFIG
-	 */
-	WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX, regGRBM_GFX_INDEX_DEFAULT);
-
-	/**
-	 * Retry respond mode: RETRY
-	 * Error (no retry) respond mode: SUCCESS
-	 */
-	tmp =3D RREG32_SOC15(GC, 0, regGL1C_UTCL0_CNTL1);
-	tmp =3D REG_SET_FIELD(tmp, GL1C_UTCL0_CNTL1, RESP_MODE, 0);
-	tmp =3D REG_SET_FIELD(tmp, GL1C_UTCL0_CNTL1, RESP_FAULT_MODE, 0x2);
-	WREG32_SOC15(GC, 0, regGL1C_UTCL0_CNTL1, tmp);
-
 	/* These registers are not accessible to VF-SRIOV.
 	 * The PF will program them instead.
 	 */
 	if (amdgpu_sriov_vf(adev))
 		return;
=20
-	/* Disable SQ XNACK interrupt for all VMIDs */
-	tmp =3D RREG32_SOC15(GC, 0, regSQG_CONFIG);
-	tmp =3D REG_SET_FIELD(tmp, SQG_CONFIG, XNACK_INTR_MASK,
-			    SQG_CONFIG__XNACK_INTR_MASK_MASK >>
-			    SQG_CONFIG__XNACK_INTR_MASK__SHIFT);
-	WREG32_SOC15(GC, 0, regSQG_CONFIG, tmp);
-
 	tmp =3D RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL);
 	tmp =3D REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
--=20
2.34.1
