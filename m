Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97119CD5BDD
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 05:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00CD110E042;
	Fri,  6 Sep 2024 05:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRrMAqRz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0CE810E042
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 05:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cejMlcetGQ0Wi78vG1niWb1uYdwgapS6JbvTUFjMVejKvgNuKF0/3AEEpL9Oii0Rtu1dQIuesvxgi3e9fe6wy3aSHbwYmLZ41iHQRVeyeRBThialqYc65ZijUhUiTW2iQuHaCQtXCD+hc3aAvCFI5P90HZyEG6pvAGbZtIsJUNYewRrsPORz7bLu2xx9teCs/pQQtvudeY+3Na8cNrP4AJN9vnHxNL7lNmI39SiVoWoo3zp+qcT7P8UwmcTFnYGeH4ovADPFGbL+XQKcqI24z0p6JY0yvmarDfneg8+vjNbXp26vly4Bifr3sDxO77GMedopp3LpZPBT8FT3sZMhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hr0AJTppAAysPdVVsa8B06ODbhMUFk54PMuymeo244=;
 b=qclL4Ot3HjCOe/HJXQcidPASjRGsgaodijtv9nfr0QKFDBPVY6h6NYwtYR5YOduh2mYHRyV4ROs8yGhPbi7EsuYIPHL6PSzEk4d9OYyvtxJtd7EwPTjIbIwObc6Dqe8yKWsL9nf55BtVcbGfPUX6wnLv+t08PdW331yIlx7NHErpDV1NRQ4iQL9SpMtsSP7DNAJpRJVyw0AwecOOdvHkHR8gck2Sug6ebv07IfCITEDzlXNFbKdRv0izemFPUpvCOujiwsrTpvPo5Gdo4N/pY7t97wSRHBZwvM4bN4EfrLbcLuFwCpaNQqVRLeY8P6GYvhglNH4bnEvkzbJkv/AARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hr0AJTppAAysPdVVsa8B06ODbhMUFk54PMuymeo244=;
 b=yRrMAqRzLzQfBvauRVpvNfNQONiyP5QODZzRlY02btw62eUJoT8elrCjZWHRnd2oCw2wf4ltn8ZpApUjrN2BCme7mu3xszLdL2zGSTIjQnbboFOQWJrIvWbNHXrt8oJWRhSAYe1FKYBitspS0x2jhRGSNEHaPv5zUdklfzW67Zc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 05:47:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 05:47:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Gao, Likun" <Likun.Gao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update golden regs for gfx12
Thread-Topic: [PATCH] drm/amdgpu: update golden regs for gfx12
Thread-Index: AQHa/o0BzGQsCVXA/0iS8pr7O/PHXbJHHV/AgAB+GfCAANZHcIAA31+QgADyQgA=
Date: Fri, 6 Sep 2024 05:47:40 +0000
Message-ID: <BN9PR12MB5257EAA6D4E2C2038E1C3608FC9E2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240904053844.16075-1-Frank.Min@amd.com>
 <SN7PR12MB6932F0EE6B6551AA1263C2D1E99C2@SN7PR12MB6932.namprd12.prod.outlook.com>
 <SN7PR12MB69326E152F81556F0DBD4906E99C2@SN7PR12MB6932.namprd12.prod.outlook.com>
 <DM4PR12MB51819C8A7CF5C6AF899620D8EF9D2@DM4PR12MB5181.namprd12.prod.outlook.com>
 <SN7PR12MB69321FD7560AAF65A45EF0C6E99D2@SN7PR12MB6932.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB69321FD7560AAF65A45EF0C6E99D2@SN7PR12MB6932.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a289e013-e7ba-4179-bfba-19ca893326ea;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-04T05:42:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB7767:EE_
x-ms-office365-filtering-correlation-id: d8ad87da-5804-4cf2-477c-08dcce376b90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?04V897RO3hUwz88/se8xw/fUuZHQJnv7vkz2yhcprexmDubZhIDtFVcqkLmh?=
 =?us-ascii?Q?qEZ3Mqu7SS0k+X9vbnoiiBVTZO16ORGt6QyRj9fMF5qqRrvE7ugCTbcwIVSI?=
 =?us-ascii?Q?1Bsz21TiZeK3a6go+qbwiytlpdcmUqLHf12FpCeGaI3sUI3sDjg8IjusTeZt?=
 =?us-ascii?Q?IPbgwK2IkfhHAaMDzsK+8WuSNFlT1WosVeltax93erb4dvPq3GVLErnI0mEi?=
 =?us-ascii?Q?KzbgGp/qHiDX5Q9TNy2NBsiBUeiim/JdM38v0a+POafBiwTVQfxIfNXC7hDO?=
 =?us-ascii?Q?tpCqqESkwqCAlGaNRdGZYmovs5o7iUkb/TaHbqrdBt1fGTeHZ7eFPuC3s/od?=
 =?us-ascii?Q?jyGc7wc8wG/b2Yt4a4VaRk0MGcGDOaGbQ+jfo/5GpabjdjO/9RLcJxDR+iMi?=
 =?us-ascii?Q?BTVIOKO5/EopEpxAOfb9TrdaWPf0HMVwO7lmSQB6iD2KSmB2SCVVo2fAH4cR?=
 =?us-ascii?Q?umDuFH+9Pm93zqFrGhb1PYrRSd+CuErrom+I0SqF3dLwrxqr40yBZnTqlVCl?=
 =?us-ascii?Q?UEx1YxKCNr7yta+FT8zn+MvhG1y8MNl4zvTR9yb69oqjnPvm2mQiOrvMhcZI?=
 =?us-ascii?Q?V+zTWLgTjTaNdG+d18evXOX+zCZfg1ZA/H4m+oQ1vB3unTyIbksj+neVvghZ?=
 =?us-ascii?Q?Xs08wDMabOcq6hVR9OHmTpRkb8xVYymt7BPoNYAgycE9XVCp+a0CVyWaOkZQ?=
 =?us-ascii?Q?t6idpWBRgxkV/4CQ+jYv+VDt7Xoy+ZABJholX74ddcO2QAG625WP0HiFLi5N?=
 =?us-ascii?Q?oRKZrYC48Q3bvKeqMVmh0RYpK3efkqgQYkefqG8Xuz8Tlnnx6nS9Xoq63Rwr?=
 =?us-ascii?Q?oTtGCUEwLM9+VC9yAKCDG5zF+GM6+Izyora4Fcjsy9PbALQ8pHakxUKRXWIJ?=
 =?us-ascii?Q?9wtcmO1DNgvTvnUSV9Gn4x2KAQPLNz2wkfcEATXxODfZoyJZKPu44kbpS5s7?=
 =?us-ascii?Q?McrNzRx9ArE1PdFxPQnaYgAs9raG5BBTzIHmK4nv/AHuChuwoEnNUUufsr4T?=
 =?us-ascii?Q?RJhvXaRkLf/agrGOMp08KCT2H4eR0tk0Qo7RxS3hg6AdiFdyOv+My8pg+Cuk?=
 =?us-ascii?Q?ZR5ho+JROLDGSyTqeh2fId3MCSAZObOlMolJ/acWXBdJS2AK8t2iLGcygVI4?=
 =?us-ascii?Q?esdFUCGjP9mzJ8sruKtlXKfMTUd/Mw8I5a0ZX7ftMQQjuhfinfGgSgJhCpX/?=
 =?us-ascii?Q?TVY0nunhOw1CzWKx5v0HUzMSoGNQsLrYLt6WvzHYbfhyyVxDmCfXvia2b/uO?=
 =?us-ascii?Q?2YszC0Sr95EmKiFvD7jbEpVspP/VFjpaR1ESZ8NSPkpM9KUZ8QiWphROZ3B8?=
 =?us-ascii?Q?4Lt51hgsRaEt42CGJ2KCnqFgkf/PNCWC3Ulv6GQ1NHwABP6q05jf3Tdb6Q+w?=
 =?us-ascii?Q?txm7Ci1B1uqbui5tJhSadKQpX4BN9VcUQkrgKFFXtEn2yQWqWA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sS5VQlhTjeMmy+w8fbHGQTv2TVCnhuC6XM+ayxafmjuRNklt50JPWFiGsR1H?=
 =?us-ascii?Q?xg1XyUNepbi87iG0OwToIp2CLxBWcGoWGGdT2MjXXRioa4I4fI82sdQ/Z1V5?=
 =?us-ascii?Q?7A+qEC5To5+xhZM9xAShYyWEvqYK4lJUtmdcsBgcp2PiVCY61oJrqJasaxwA?=
 =?us-ascii?Q?A8xFudgn+1UsPOwx2O3TVUxgpb9+iqUN/YgyCVvfHlc//G2rC5GuN6D1Obob?=
 =?us-ascii?Q?VVzxudzBJILFmhZKG/lafWuIh3sTq9+jlvI9r8xmcMNX7ost3GLIpjKheKQA?=
 =?us-ascii?Q?XN91XqGR3dlFg74L4n1WdtuTznJ8Lt7GkcM+lE+RMLl8GsWPAxxMm50aOqCn?=
 =?us-ascii?Q?i0uLvoCnUFAbCbQYyPDqQ4lA885SV6MEop7r7NiQB9MH+7h1bqOSC+zT0Qpn?=
 =?us-ascii?Q?uzPerVlSCjwUt01NXD6t+1RMPcrONhjn9SQcLDu1A/Ey9gqU+Eu9cUfmeqwg?=
 =?us-ascii?Q?MPNx5NCfHuyLW1/UoVI1W5JS5YYTgFERa7n49LMiRGBH//SMiDTU/ROPcjSz?=
 =?us-ascii?Q?4++XUETdEw3aF8MCioZ0TYcWfZUaFeUo7xChF50MG8YO2vu2Z2yzmWYGB6wH?=
 =?us-ascii?Q?Sw5fRY3IAYfMKQ+89IsZ+z9XOe2coemI51l5DvnFbkwKo43V7TaaXhtcKFk1?=
 =?us-ascii?Q?sjnJfvVHEs5Rv1TLY2Usvu9mqCWsmToBHcnAr8BdjtsFIeQDdtn0thjeUdI7?=
 =?us-ascii?Q?wT28w5WB78ElhDDasnf0/Yg6NRe7w010ZgZ7WabJ47izWB0/kj6DFdzdRkE2?=
 =?us-ascii?Q?BULaU5mabWYexIRIp/xJNkCo68lq3gCk72qVet0PsHMG+1yUXh2Uj2M5FUDV?=
 =?us-ascii?Q?Y4kUxBULaDJHAL3eCAKZhHGX1SSXnYE+ou3X+zohgW9lnzOlGTtJI/qtFiIW?=
 =?us-ascii?Q?KT/5hqrWRKaB+tYINzjow+D7Ewxv3ybtvvXNkB2zVeV8incgKimzRN+Jy1i6?=
 =?us-ascii?Q?MgEXxJYlYKn7XdyiWw+gs0yiXWIotz0dP4DBvQIHE7gOjH5WJBmAU0T2jNte?=
 =?us-ascii?Q?59poANIpX6pAPJ9krRuJAxgh4oS3cQgeSIsRCNU8dRVeRMRiEDFi7insIBB4?=
 =?us-ascii?Q?wIAILU/xtVjDvHq3epvwmvnR2mx6WwdeGKvpWEMtOxikUUXhccrvik9GqFZB?=
 =?us-ascii?Q?TWtp5HvJ+7weF7r8DvdQdcLE4FhWk2iD7V0C8xdtcrwvHTz5p0PwBuPjXPD8?=
 =?us-ascii?Q?mzZFAxOtfF+twUPRqh3KUATLPF4fEqsi4hbWhsRdFxBGR7tWnYQsGcr1dDwP?=
 =?us-ascii?Q?g4Ae8L5ZfM67T5tAsdzO2122PHaLdueYnviT90N2BBCtR3jr2Ew1mshaLpow?=
 =?us-ascii?Q?8PqCZRngDnElSJjSVHf/S9IjAlyltU1/7YuXJrFRM+gucoNYrj/aYTsjQJfA?=
 =?us-ascii?Q?Y2GFK73hJCQH9c+Rjg9xhDidodQoK2hhlJaOhchOYaukdltfgxb+iubjUdE7?=
 =?us-ascii?Q?x3bDuT0b1Br3bHmNCi2L1d6hKEIepGEY/iLzcesHZZ4a2RwHV8yanio1LJom?=
 =?us-ascii?Q?Fqwp2c1pxKhWnL50dyNZQmxwtL2/0t8KmV4mz3t4anGaqniUyXee3lFnvzFq?=
 =?us-ascii?Q?c5yAGXbfPJWfOtagyzssZTBU0m7wptveWKp8iOZY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ad87da-5804-4cf2-477c-08dcce376b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 05:47:40.2480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABG+WuQyA1lEEJkWsgdQGydWiTdMT7wwm2aMkhkh3cC4owgr88XBfQmZwK8V2YO9OY6HpRWtVjQ3P5uswpmheQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Min, Frank <Frank.Min@amd.com>
Sent: Thursday, September 5, 2024 23:23
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update golden regs for gfx12

[AMD Official Use Only - AMD Internal Distribution Only]

From: Frank Min <Frank.Min@amd.com>

update golden regs for gfx12

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index d1357c01eb39..47b47d21f464 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -202,12 +202,16 @@ static const struct amdgpu_hwip_reg_entry gc_gfx_queu=
e_reg_list_12[] =3D {
        SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ)  };

-static const struct soc15_reg_golden golden_settings_gc_12_0[] =3D {
+static const struct soc15_reg_golden golden_settings_gc_12_0_rev0[] =3D {
        SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_MEM_CONFIG, 0x0000000f, 0x00000=
00f),
        SOC15_REG_GOLDEN_VALUE(GC, 0, regCB_HW_CONTROL_1, 0x03000000, 0x030=
00000),
        SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL5, 0x00000070, 0x00000020=
)  };

+static const struct soc15_reg_golden golden_settings_gc_12_0[] =3D {
+       SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_MEM_CONFIG, 0x00008000,
+0x00008000), };
+
 #define DEFAULT_SH_MEM_CONFIG \
        ((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
         (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE_=
_SHIFT) | \ @@ -3495,10 +3499,14 @@ static void gfx_v12_0_init_golden_regis=
ters(struct amdgpu_device *adev)
        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
        case IP_VERSION(12, 0, 0):
        case IP_VERSION(12, 0, 1):
+               soc15_program_register_sequence(adev,
+                                               golden_settings_gc_12_0,
+                                               (const
+ u32)ARRAY_SIZE(golden_settings_gc_12_0));
+
                if (adev->rev_id =3D=3D 0)
                        soc15_program_register_sequence(adev,
-                                       golden_settings_gc_12_0,
-                                       (const u32)ARRAY_SIZE(golden_settin=
gs_gc_12_0));
+                                       golden_settings_gc_12_0_rev0,
+                                       (const
+ u32)ARRAY_SIZE(golden_settings_gc_12_0_rev0));
                break;
        default:
                break;
--
2.43.0




