Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0639EC4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 03:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE7111309F;
	Wed,  7 Feb 2024 03:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Izeskjbh";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97CD11309F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 03:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCb5o2t/U1No2v6fkGEXtSyS098+qg0VdAwFckanSNvQZ0qLoFuoaNvG9FQxQxSxF/WIM3MAZFEff1HsxmNYWGKaE7URWPK2VLX03RNWajKoLU3+TKo98H3gA+EQTQmG3TAhZvCyS7i1vg1hBAs+ZHvPK8eVYdZxSCSET/F1+UnXUjmovx8yCyKw3c4k41CPQzP00YRs5ubxhek9ym21cQgte3QLlsgo6XgfSEW7flhSL14FwlZVVbmcMtxHi6ATvMaRMnhOFkNzU6eObr6KvnGupzyTYQbf6OF5Ka6OHpUGDcxrqHHZJsFfAWpfEwaNFEZ8t0HuN0ZdhG7aO/Legg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fHI136R2gBPaq5LlGM3rEOTKY5jdacPyz8OR9iJKnc=;
 b=FjWt2vvkLAC1v94NendxE/M9LOT+CWvIxyq2S9BZ5OCd8C2TxQBG9z9uCiQRPfOfIx3oMtO5WOVdeCDhNmSEGpnNDIOCbM4odR41bX5UDx0Xwr6mFEEd4X2QTHQ04/tTRa7UIbdnn2B7G91vtix04njTq6oDcxdx2htEw2l7zBXAolsaYJSDCMDjoRMjgYJ6rz3SCtnVPuN2o3djwLoMaNs/gSIUK/mjuThbc5Cf92zgRWth0/pR/YUND69oIrzMrgdcF+147hdgzUa7QVMb0Fo2/Axq3qXLM2jsT8B+ujwu1NM458lQXyvmn3Xx/zdychfNFAMw8NznjOxMlrTnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fHI136R2gBPaq5LlGM3rEOTKY5jdacPyz8OR9iJKnc=;
 b=Izeskjbh9CxgG1C6WuX86z/StTlkKyv5da/VZ6v2X8CnoLSUcTp6Ke++oIuoTCjaXiY2FlNqC/J+gHJzZldC/E6jlu+kw2IS2HbLK4Rx6dqnkuJIR4ft8tnk9X0lVYsnuZdnYVnTNWzDN5veVtuzChP4eCHuT19EwpoOetsDEig=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 03:39:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7270.015; Wed, 7 Feb 2024
 03:39:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ming, Davis"
 <Davis.Ming@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Ma, Le"
 <Le.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix HDP flush for VFs on nbio v7.9
Thread-Topic: [PATCH] drm/amdgpu: Fix HDP flush for VFs on nbio v7.9
Thread-Index: AQHaWWx5zo5tWC3uvEGiPfVdQbDfS7D+O4Ow
Date: Wed, 7 Feb 2024 03:39:22 +0000
Message-ID: <BN9PR12MB5257BDFFE9FB39D47D3C230CFC452@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240207022156.297987-1-lijo.lazar@amd.com>
In-Reply-To: <20240207022156.297987-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5a60c3ab-16b4-4a5f-8438-14369041489d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T03:38:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CO6PR12MB5427:EE_
x-ms-office365-filtering-correlation-id: aea0221b-d691-4ee1-2c95-08dc278e600c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fHaL3tSgfnQP+smfu/NXU9kES4i/OyLrnZ/u29CCgZADvTq0mVwnNKdWgFVm5t9Q8LRxyKIS+Ie79ACj6wsqhvdb6rcz5XMhpqb9vRqGB8on5pg33wJtCwqkrmGUTJpHmGGUrKIxFdQmVGh/lMYVIQvVwUUDfV64L8C9VMVym59YeowQHEceeVRamSLPA2dhqdXavwLNwJ+yMKwPvy5UpUC2WW6//gLSJhN5VT49NVfNkVyJCdfuAQOgFlH8e5NQM9cGYrGpkvpK7806IB2o/137ecuIOFvApvnuIsdUbOfHZ3181wPiPEEwp2JXEmmVqDnE2/U0N8BrMg9f8X3UwiyuZbIIwMyr0QA/VmocJcIv4xiSivC6/1a/NfFrDBpLp8l0vNPDt35Y8kxaPzfuk0S5NS9ABige3qwNtPL2czKjAzAb8KOu39nMfXxmcYvq4ryqVJZFY+T0OGFARfDR3LLOaUGMyrJGkGTR0UOF5YNb5h3rdJ3SirvjacWlTvzgVLAUzCm5Ijdn7354Mz0RpyrIe0SITvHvKHJmWkeDl/3M3/0sabSwmZQ4RdxjBvBsw2Pa0spPaG2o29tU4c5jAz2WhH708erQfe5S1T7MUldawRZfFcnsfSLW92C/ceIc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(478600001)(9686003)(122000001)(55016003)(38100700002)(7696005)(71200400001)(53546011)(6506007)(83380400001)(26005)(41300700001)(64756008)(8936002)(66446008)(66556008)(54906003)(8676002)(33656002)(52536014)(5660300002)(2906002)(4326008)(316002)(66476007)(66946007)(110136005)(76116006)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Lvu/lc7oQ8qDnfhfUF24l9NoqloViKHKMHuMU5q738NKZ/fFFTctDsFkk5W?=
 =?us-ascii?Q?awvL9l4RbvVQeBZ9UBfsdzxCmTiNkm+c6H0OVtEJfEo9lo/M5J1Jigruj0Yz?=
 =?us-ascii?Q?cQfo9paQQlh2rvQn3q14Ksq85MDG6fKtJbDbKs00Y+ybQzVN86IZDtprH3/X?=
 =?us-ascii?Q?AXQaIZKndBLiCSbNqck9QYwDp6Okb/V0DXLldK1auxP003ESzHKfbqzU4YEA?=
 =?us-ascii?Q?+1lw24gkdJ0tLDBV8hRwRT9X524WK125YKehfhEuiBqsETHR/dCu3O5YheBN?=
 =?us-ascii?Q?MoDsIlUnBIpPkBGP29GgqqSvRg9ajeOJQ+6eLk2bfpZP2KUM+B8fvH8JXxhS?=
 =?us-ascii?Q?bJH3yLpteL2XtKy67GjLNpDi30GQ5Axc1toUXN7tv5wa9aL5FzCtP+oHUr1h?=
 =?us-ascii?Q?kIwwC30KgT1tGeExxaRIf6EPnj7WBLQ238aaa2bqmqDRRS/5CjAG0HnhWHZ8?=
 =?us-ascii?Q?daxdiI36eGPabiSfCDwDQQQxraHaibyxaRQDESHkAJiQWoV5+oleAgNWxE8g?=
 =?us-ascii?Q?T0fwtDHJFjEsiuBu+yiyIvffnP72XY6DHKY07zFNtrpOFnbv8Kj3YX8k5pLd?=
 =?us-ascii?Q?GgeXXUyQlqAhRXYtwhuN9pHRJZqvTd0gj8vcPZiD0Wyw3FO+FnmfKVQjDmh0?=
 =?us-ascii?Q?9+qUYO4Ytdhny6eODCNmp5U3StrG2NvaABjCB9XQ+NNy8hFCHCBm7cSZXF2W?=
 =?us-ascii?Q?g5Ip4xuXmLWB+nkhI8wL0KXME+naUSk0JQbvfFD+Nfkw3Qp1WURCTBumorIa?=
 =?us-ascii?Q?r6dDQK54XBOB1EQjYdG3ct9JXqLJ387ez04aKNdTpAAA4uhfQvwXvJ+ozTh9?=
 =?us-ascii?Q?8TRojYN1XT7jxpJa4UlUSql6nIHdrwnFjScaUrs91l+Gc8YXlWIY1vMgqjnn?=
 =?us-ascii?Q?rHwN7ICim8vE5lBfwgh9b0LlAN44WMWb2w/AO4pPitVb64R3uVo0GRQysBkH?=
 =?us-ascii?Q?HdQgxkTuo0R0t/0d6wk+yOOhMneDgLAbariGJd8WJvKDXOGTGjiaDU/9OI2U?=
 =?us-ascii?Q?W0wDjyXOsF8luPBOxedJWOrfpJ5ZvISQ3D6t+VwymHoypBMqaTovzSWqel3q?=
 =?us-ascii?Q?J8p5ij2n3xtvA374QaYjvGdm9nzIopVN0Huhy84gd8Z9QVJNUKaqNA+YSjWp?=
 =?us-ascii?Q?KPJwpRAzXS3n8q0GlDn8wRZS5TKVaSsnp+pFBU5BqFYJ41pmPH4SlbC9OWAM?=
 =?us-ascii?Q?RgQ0y+wkN4k8IN9ir3HyyWS0+wgRs8H/avWiEmC+xZ+L7g+V5iTbkwbYdbib?=
 =?us-ascii?Q?LAtwJGV0HRJTW9G/s2aT6amoPrGwWI/WVq8W5ELL5M2VGR65gRwI7EaFJzeF?=
 =?us-ascii?Q?tncB4w83q9KmZbPq1NmVNszDEw7RxcK2p88vO0ZOGQtZV0b8dsPyXdWAzAcS?=
 =?us-ascii?Q?gJ1MPMGB/VjwHbJL7vc8QForlBSWF2y3UlMuaaRChluegfPjC4UipvK+gAQG?=
 =?us-ascii?Q?Q1pet1A9cfALaWXMQepp7qt87gZzW1TMzu6VAelPCTgzZ6nTGCHWrxMX9t2X?=
 =?us-ascii?Q?nft3FrT3891fMEkgMA5xcvOO+Ed0maJxH2eU7rEaOCa43RhKdCW67bqopoX/?=
 =?us-ascii?Q?Tn5EQmgmLwTuinutmCFLvug1yMscnZjJNXTswP28?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea0221b-d691-4ee1-2c95-08dc278e600c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 03:39:22.9891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tE+y7ybwQp/gvJXBA10Gpi2SSbocqcgvzt8B+BMPrQLW0FwtQJ0nZa1uhUOOmBrl9RVMHPlq4IPtL8nr+DpWVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, February 7, 2024 10:22
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Ming, Davis <Davis.Ming@amd.com>; Kamal, Asad <Asad.Kamal@=
amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Fix HDP flush for VFs on nbio v7.9

HDP flush remapping is not done for VFs. Keep the original offsets in VF en=
vironment.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c
index e90f33780803..b4723d68eab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -431,6 +431,12 @@ static void nbio_v7_9_init_registers(struct amdgpu_dev=
ice *adev)
        u32 inst_mask;
        int i;

+       if (amdgpu_sriov_vf(adev))
+               adev->rmmio_remap.reg_offset =3D
+                       SOC15_REG_OFFSET(
+                               NBIO, 0,
+                               regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_F=
LUSH_CNTL)
+                       << 2;
        WREG32_SOC15(NBIO, 0, regXCC_DOORBELL_FENCE,
                0xff & ~(adev->gfx.xcc_mask));

--
2.25.1

