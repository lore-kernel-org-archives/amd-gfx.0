Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E73D60074
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 08:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D060410E0CF;
	Tue, 19 Nov 2024 08:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eIj5fDiB";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DAB10E0CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 08:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhGjvGiUs6wwNLH6seIv3HNuKAO/58aCXpbu57FHi/FmQCQ+jmZLS9FA1yakm9DSLqE37K4gyF6HIkQlzdNeNGp+uKqVzJ8djPNnLvgRvNHEJW3OhodZkHN8SvzxDIXeNbTtNYTscPB+tXxrMX9vslDOJkEKocE4LehYqRVAmL8ud7tUsYzs+1xHHVmluD4aIMGJKl40NNhKTHzZtPZ1vQedIGdle08EizFuq33eyi5+gz8rsPc88leYni7Rdy0112a20pJlgZyIF1hyBzTyJ73qLX8mnMShJS5SU4hoPQ7RwZdnasROwqCWNOOB87I2KH1Bfk99vDJBUi9SlzRAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFjYXFTFwxnMBDfhdxgZuXQrlj6JxVUc8poyUuGovNw=;
 b=ivSEJpMCh3MEug89gnLKhQHgyacTYMHWETefdJ5I4svFM5HtmCVg2MHzZOeGvZYJpD6bHHA4WgwOLGjcltBLTFqPo+vuDzi/iAspeEgEwB+AxAw6CKyYl2KSp1T372W3o/YppM0OQztB7h/1ERY6aKx/DUlMX63RQ0fpDgJ1J+G+i7T8w88gyGydgMFQ3+nE4iJOy+XaRp/5LlKHq1Y3kOTFJP7ImFpbTI9bheiVsmPwhO+OCGw6YViJtJDaQ2ahwxeHZcm09UVSfhhytiktAhAoJ3DpZUCGuQ7LKZ/vP7l4UoBbG4h4qlwLiN2HQP7O+yotWApiQS9loGL1CVQFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFjYXFTFwxnMBDfhdxgZuXQrlj6JxVUc8poyUuGovNw=;
 b=eIj5fDiBGL5+//xYScQkSTh/bXwAgCrSR7cbXmvkPMmwpFf80lY0wD6pQ133380oSln0daM6cFRL/9DrNAiyTtXx0XVuNtRAB2EdAzT5kHb5LY+Zhwctdbolvepideif2NcMRxED0vciVBMLYMRMi3rF4tS/0I1VMI9jLbkabBI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Tue, 19 Nov
 2024 08:00:15 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:00:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 01/21] drm/amdgpu: simplify RAS page retirement in one
 memory row
Thread-Topic: [PATCH 01/21] drm/amdgpu: simplify RAS page retirement in one
 memory row
Thread-Index: AQHbOk1lKZew3MoGXU6skJ6poLUmwrK+PJpw
Date: Tue, 19 Nov 2024 08:00:15 +0000
Message-ID: <BN9PR12MB52574E63581EAAC7BD01B415FC202@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7d148d50-d870-4afb-8711-de9720705c60;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-19T07:56:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB6969:EE_
x-ms-office365-filtering-correlation-id: eac9ef16-4c41-481c-e751-08dd087033b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?G6Cp5QtljEMiJceSBGNAaaK9oQ+ZZ5kJe9pffCqdtA1c9GbQxa2mtWLCf+uA?=
 =?us-ascii?Q?3Z4WUEAbGxF1hGkgPFtBEqdg3WzmzWBpXOY9JnSBGufMbC9Syrmwx33kA+bb?=
 =?us-ascii?Q?DEECAW+j2rw9iORiES4BlM+WYsUbXL7BFgcm64aI2Bm/QhbYamLEGme2Ct3v?=
 =?us-ascii?Q?9xCENFOMQfAF4ZMzRbdCQAmUaMrBqey+o2ugM/f3+jJdWB15YCJEIIiUN2zZ?=
 =?us-ascii?Q?pV6x2Qcw2XdPFmk4fh7O6T8ruTeq5JJ6IrxjrW0loPHk5yrVw5GrgjE6jksS?=
 =?us-ascii?Q?hB9VeaDfocDyr/2doxBgDmdJPHSBDsmRiHm8vpe8kFVwt8idf4VBXU7Y8AhO?=
 =?us-ascii?Q?xEkmRg36mJ9OXqs1lLm5HX9PZrDwgb1U3NnWYs9SFNi/VTi1PU2ThyXmHqKX?=
 =?us-ascii?Q?JGWOEyg3sDYE1dx+kM9KGr5kkLE4dDgACvzFFagVjkhudv7RCubEg01jJAF0?=
 =?us-ascii?Q?fEKRMSfkqJy2EeLfkdPnSqHT89Vuq/aEqnvAOVOyXV8ZrrJdIlQrPB0/Ac95?=
 =?us-ascii?Q?d9MnzevJd0TI+Fd6UJ6Lne6XeGRQzzr5Rn5X4fQnpvLJhpEwGfAjTwOttWtR?=
 =?us-ascii?Q?tEZjsqo8DFKkFvqqkz6VNLBF+t2tgapbM+4losLxfx3U5LvdpOdCgFbDK0gy?=
 =?us-ascii?Q?WHqHc7FKKFBrchBr7Br9XMnlC8DwTDgFKWKjYbP/ecsbo6uV9bB3JjGz8EDe?=
 =?us-ascii?Q?jkNZtsJvnvq6TPxmtLGmdFzibkvYaeSAELuHz1FPlXyeTczEVaajkONGAcIk?=
 =?us-ascii?Q?qU8YmSbDJMZVaPqs7fLNFuFfSJ85/SVDfHCogDjPxWFZHr/BkdzLyY+1nhu/?=
 =?us-ascii?Q?BrUjqGFVl/JtJMllnZu6XMykspxC7mDVEiKpauFcejet1y7UEo80MP5FRfWF?=
 =?us-ascii?Q?DzJxs3/id5yBJnj37KPZBzXtDYzKTzJrcdMPg/nnjiUjcwAVpzf4MRS88pIS?=
 =?us-ascii?Q?FaIOFMBXEyMv6OtHY6cQYUSsVS9GkxB4D6yj6CDxFvDkZfkZa4/Io98J9b2E?=
 =?us-ascii?Q?jNh7v4BCB89z1OqeSiu1yxWE1Mq1HSAntvcYnW2RB+2RdMPWiyjrKPL0+nwW?=
 =?us-ascii?Q?CK7S4aLoj2nYxt77L0qb4JQkrfqKznN+uj+CpoXnmbNmyfl0BljKjAoEPOgM?=
 =?us-ascii?Q?LRm/aoSmnp0kukmQishTPkYcsjc3c85g6q3uAlrhWv7jqdUbte22URsy5DA6?=
 =?us-ascii?Q?eZdRyypRFVoESdD81/LqKVU2ehKNaA/jSgwik8HIVsjzTo9zLUxMFLxQvHP1?=
 =?us-ascii?Q?CmjhdBKhmbyWHr6YBBUlK7uYMwI8WPcvbcI9CMMcMrB3r3mth9gLAaAHzgj3?=
 =?us-ascii?Q?vjOBoG3qMoaWucOmp7BFkQ2HrlK6tYf2+jXZhQPK65gsNQdTnH/94lLpyb3t?=
 =?us-ascii?Q?jRLJAyM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rC6ZZRhS0D4Ui3pXIumkDfbFoZC/F/4MUVLgEdKC58X0QFfcDIrqwCE24jAD?=
 =?us-ascii?Q?Okv9f3MJR0tdh2xfHf4QTWxZHXngqJIoc/saYH8RLbwZpI8xdiSPWWbU94X1?=
 =?us-ascii?Q?yRHKaXIgrpTPJO/KQG5KXrV8HAulZ67kG2qAe0Vx+MHbOL/ZXcdaQ2qNKaGW?=
 =?us-ascii?Q?5eCu+Y0G9UXpPHEQoZf/vdDKCCY9gsAeVHXu5x7QqAw9lz55roSr2fVwPPPb?=
 =?us-ascii?Q?SWUsmGDxXj134MtTcEGfEBoGQMDq7XCpeN5OFS/LUoN0wfdIf8/CDV2tQIPO?=
 =?us-ascii?Q?AwMlxgufp2nzhiQEtVf/VLu9pDAJUroB6Df5C+PUvzOL1zHga87rhZGN57t2?=
 =?us-ascii?Q?7nUKUEjO/wnH3jX7EgXTY8uy8cWFF3oJBUTg5louD4NdxRvfsQMo1DaoJYvq?=
 =?us-ascii?Q?j4ivgX8JSsrgaBwh4qbqYoxEdJ9w65uAC2RSRN8Ew4G7ArYBMhoSioznwmaE?=
 =?us-ascii?Q?spuCGiI1TXEXGSs4uucd873EUwd3IN92iwqjQndRWWhKSzCn1EoFFlejhmNe?=
 =?us-ascii?Q?5wCGZGj7IELmYUXBRD+bv4ads0Auyb2PiwN3ki+n4le1QHcJzRdvd6yUVi+g?=
 =?us-ascii?Q?E7ZqbJUZTxMi3AojFAp42OIT2tWl8IU7gSZ6Wm5Ls4GwssHXgS6XXbMaP6hr?=
 =?us-ascii?Q?jxdwOIpKGhpgB7oSIHkTBUqlRghJ9PvuHlwytiQJgvT0O97qTvS6G0z4nLZq?=
 =?us-ascii?Q?8zSPSdgOOjC8iXDbwpZOC/+/Vsl5l7iTdm4z0QShlCwDdXjzIYORNoGhg3No?=
 =?us-ascii?Q?qTfUplSMP4eGfD4CRJqn3dV5N7UzLsRfY3KwtHNmfbYpySmrxoVn2serZ8Pe?=
 =?us-ascii?Q?BS4AU1/s7G78Jz4uM2pUseOghDMsYgTRbHPYjiqmCJutSg/m6Itxvu6Ekto+?=
 =?us-ascii?Q?ujfp6vCAuJI22m2ty9LrT3Ua0jOku9fqNSqLuCwAw5qfXQUQB9iXQd3TY0Qm?=
 =?us-ascii?Q?4Eeg8r3fHdsFwD1KrnNf8hMl1D2FEn0XmrhNWUXVq+1HvZOWJZHOc+oOtl8w?=
 =?us-ascii?Q?6ZncfvZSPXSv3puem7MhvY3pUBpIzfR/ovYv1U7Qhh7FZBkhlWm7HNgB03Ck?=
 =?us-ascii?Q?V1VNOs/hKwmC+ZAH3Lce+pV0Tw9MFx3AJhe5ZFWlmMl3JMgpQi3sUBqiTqg9?=
 =?us-ascii?Q?Pt10e9C4DhOHw0Srfn+AHqx7JAJrtkxxQKHpiNASnwZhYyyJe8U5Cl/Pb41w?=
 =?us-ascii?Q?HmQzL5wDnYAcikwzycZHwAc6X6swmOl1UhcgpRvGmln8vd0uUSWAaYHPdzTs?=
 =?us-ascii?Q?hCZ2Qr4dzEwYasuDxLUgRrKQBoAAogqAisE0tagXbmlhrGecR7KckzJSJHiG?=
 =?us-ascii?Q?NJI5Q6NSuukhf5Y0Mby/OFAZqpOZ2Bul/41btTloaNnbxyU63Bhf1FMEBo98?=
 =?us-ascii?Q?pzWjw23Lh2JCIw8TImJnjRSrG9KBguvx9BbuePf8gl4koXEbCTUFihZ5VNeF?=
 =?us-ascii?Q?k/sfAlHEUG+SQV2yWGgU23tEL47jPSGSQ7cwT0eJeXwPm2JBQvddjIZDvPZj?=
 =?us-ascii?Q?3hb95hnhEf/E529SQn8PR1hgQWJaXrWuqATtL8q1BB2w3HzpI3Pdd30ER9as?=
 =?us-ascii?Q?buS4vp1TZR/KOBglk1bqcxfN/5gB8qtejP+eJppj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac9ef16-4c41-481c-e751-08dd087033b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 08:00:15.2897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMUXOha1N4LvBDSmLOfDj3Amg0RXLCaNc6GWl/IKiruKDp1b8gePVratFiO9cLp1v7GDegz5OjQlwQUbYg94TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Tuesday, November 19, 2024 14:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 01/21] drm/amdgpu: simplify RAS page retirement in one memo=
ry row

Take R13 and column bits as a whole for UMC v12.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 57 +++++++++++---------------  dr=
ivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  1 +
 2 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 1a8ea834efa6..8939b4f1fb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -177,7 +177,7 @@ static void umc_v12_0_convert_error_address(struct amdg=
pu_device *adev,
                                        struct ras_err_data *err_data,
                                        struct ta_ras_query_address_input *=
addr_in)  {
-       uint32_t col, row, row_xor, bank, channel_index;
+       uint32_t col, row, bank, channel_index;
        uint64_t soc_pa, retired_page, column, err_addr;
        struct ta_ras_query_address_output addr_out;

@@ -195,31 +195,27 @@ static void umc_v12_0_convert_error_address(struct am=
dgpu_device *adev,
        channel_index =3D addr_out.pa.channel_idx;

        col =3D (err_addr >> 1) & 0x1fULL;
-       row =3D (err_addr >> 10) & 0x3fffULL;
-       row_xor =3D row ^ (0x1ULL << 13);
        /* clear [C3 C2] in soc physical address */
        soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
        /* clear [C4] in soc physical address */
        soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+       /* clear [R13] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_R13_BIT);

-       /* loop for all possibilities of [C4 C3 C2] */
-       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+       /* loop for all possibilities of [R13 C4 C3 C2] */
+       for (column =3D 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
+column++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
                retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
+               retired_page |=3D (((column & 0x8) >> 3) << UMC_V12_0_PA_R1=
3_BIT);
+
                /* include column bit 0 and 1 */
                col &=3D 0x3;
                col |=3D (column << 2);
-               dev_info(adev->dev,
-                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row, col, bank, channel_index);
-               amdgpu_umc_fill_error_record(err_data, err_addr,
-                       retired_page, channel_index, addr_in->ma.umc_inst);
+               row =3D (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;

-               /* shift R13 bit */
-               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
                dev_info(adev->dev,
                        "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row_xor, col, bank, channel_index);
+                       retired_page, row, col, bank, channel_index);
                amdgpu_umc_fill_error_record(err_data, err_addr,
                        retired_page, channel_index, addr_in->ma.umc_inst);
        }
@@ -229,7 +225,7 @@ static void umc_v12_0_dump_addr_info(struct amdgpu_devi=
ce *adev,
                                struct ta_ras_query_address_output *addr_ou=
t,
                                uint64_t err_addr)
 {
-       uint32_t col, row, row_xor, bank, channel_index;
+       uint32_t col, row, bank, channel_index;
        uint64_t soc_pa, retired_page, column;

        soc_pa =3D addr_out->pa.pa;
@@ -237,29 +233,27 @@ static void umc_v12_0_dump_addr_info(struct amdgpu_de=
vice *adev,
        channel_index =3D addr_out->pa.channel_idx;

        col =3D (err_addr >> 1) & 0x1fULL;
-       row =3D (err_addr >> 10) & 0x3fffULL;
-       row_xor =3D row ^ (0x1ULL << 13);
        /* clear [C3 C2] in soc physical address */
        soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
        /* clear [C4] in soc physical address */
        soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+       /* clear [R13] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_R13_BIT);

-       /* loop for all possibilities of [C4 C3 C2] */
-       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+       /* loop for all possibilities of [R13 C4 C3 C2] */
+       for (column =3D 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
+column++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
                retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
+               retired_page |=3D (((column & 0x8) >> 3) << UMC_V12_0_PA_R1=
3_BIT);
+
                /* include column bit 0 and 1 */
                col &=3D 0x3;
-               col |=3D (column << 2);
-               dev_info(adev->dev,
-                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row, col, bank, channel_index);
+               col |=3D ((column & 0x7) << 2);
+               row =3D (retired_page >> UMC_V12_0_PA_R0_BIT) & 0x3fffULL;

-               /* shift R13 bit */
-               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
                dev_info(adev->dev,
                        "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row_xor, col, bank, channel_index);
+                       retired_page, row, col, bank, channel_index);
        }
 }

@@ -274,23 +268,18 @@ static int umc_v12_0_lookup_bad_pages_in_a_row(struct=
 amdgpu_device *adev,
        soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
        /* clear [C4] in soc physical address */
        soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+       /* clear [R13] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_R13_BIT);

        /* loop for all possibilities of [C4 C3 C2] */
-       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+       for (column =3D 0; column < UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
+column++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
                retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
+               retired_page |=3D (((column & 0x8) >> 3) << UMC_V12_0_PA_R1=
3_BIT);

                if (pos >=3D len)
                        return 0;
                pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-
-               /* shift R13 bit */
-               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
-
-               if (pos >=3D len)
-                       return 0;
-               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-
        }

        return pos;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.h
index be5598d76c1d..dea42810fc53 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -60,6 +60,7 @@
 #define UMC_V12_0_PA_C2_BIT 15
 #define UMC_V12_0_PA_C4_BIT 21
 /* row bits in SOC physical address */
+#define UMC_V12_0_PA_R0_BIT 22
 #define UMC_V12_0_PA_R13_BIT 35

 #define MCA_UMC_HWID_V12_0     0x96
--
2.34.1

