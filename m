Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45979C0018C
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 13:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE8C10E765;
	Wed,  8 Nov 2023 13:57:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B0410E765
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 13:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Iv6vKHasJAoD5Faq0ZHoSHL8rHsfbkDvQ0/GTAy6xcVH7wY1FrzS1K3z++54oWVU3DxU0Qibs3UPvl7hXqGwXS9uqn3oBWLNhkD8jSOGatF5zJHfWYAEBOVpRoRqazFKx+XN6UBSPAxbDZXls+CQ+VklLAIehRegD+mNOlyRI4k65HfZJmYmG4b6A9NJiE1UzDGk2soWXKjTA0/XyuNwzvZvFp5UwysoYNW1vkvSUltFVje3rY2KRYwNp8wHG44OlPqHfnO1ks9+J7i1MxqKZehJNhlnAeoOZo6Ku3ZrBxNuqFQm9kNeHAXnOqBtRf4+Ug1AzMclDqRdfsjwxYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DngQ6gB0h1Ece9Ln5lUGLViQ4z6PK8L4Y2L1Feace+c=;
 b=MbwQPCbrnHZDE0WLrx5bj8hATaYvVIA6OY5tTzSX9nxekoecm9WTRpJv2YMtuZSig4KLlY8EeLaCxuaLxyd7Ktt28Kc5VOiEndPqJlkFixe3s46tCabcnF82MtcNWkLf7DqYR0cIXjE3qg1ELBv4VvDwaXo52CfszeNYpsjgYrRCUCJYFgX76G6dYcNaym+036h10k5tURJ2suULmobPkC/Bm5QlWyPCz4j1VtcukNt5B3jDdLdthmjPteL689GBcMKOOhKgNJlGURf0paeK7pO87FVTK57MdDTfAgu6Er7kcTTPlifb/HuY1k4l5L9bujumuKXIvqAbcmpCy47jWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DngQ6gB0h1Ece9Ln5lUGLViQ4z6PK8L4Y2L1Feace+c=;
 b=KbCqH7tELphGkwp5q4dEmc82ks3N2QLXc2GYS2nA+8+VN117zZjMGzo8QDZ/jZdmc0OOM7oIJG3ojCQcmAgKebvAVp0trEvoCRwcNERhjPJXgmZyHlcaVJUIVT9YPbLrbZNFXLeKKHl+dvHIQIGbXdtiOcTGJoHfyZVsgQv86c4=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 13:57:26 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 13:57:26 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/7] drm/amdgpu: correct acclerator check architecutre dump
Thread-Topic: [PATCH 6/7] drm/amdgpu: correct acclerator check architecutre
 dump
Thread-Index: AQHaEkNAvq8jDP8tI0uSQG9DcSFxbrBwcm2A
Date: Wed, 8 Nov 2023 13:57:26 +0000
Message-ID: <PH7PR12MB5997C00C34DBDE06E7BCF6CD82A8A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
 <20231108125735.2497856-6-kevinyang.wang@amd.com>
In-Reply-To: <20231108125735.2497856-6-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB5021:EE_
x-ms-office365-filtering-correlation-id: 6a283ded-c204-4e9b-ca82-08dbe062a428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyYYtxBuzkV6YsxsLphyxbYJvKhxmjJfgczWCAPvb/dMDKsvRfqaQHVTihPn5am+9wsXt9YyCsEBd2XbSXTrEI+JbADjt/p+0e2amu5QRRf6s15WIqMifXWiYDSaiwxcHkUmJgcPI+gOurOvZmKHQPfqBoHxrbuLd/GsLGMNJ+L1AGdTe0a59h99IL0ox7wiSRHPaivG0B71ADMhzPdRjdqvjN16XG0VI3J39BcKxIgS0UbRZ6LSShN4tKBezOqdFz09Otiu93cwHlYQ8O+65ht95dR37mf2ogW2rGkgUR8f1R5G3p3+NqNojLFltju6inxHUdO3NVe/hwQ0w0WFetDS4RlNvcJaypyAB1nb9PXl3fa7/OIYTtLzTXSXMUMXyZRszFrqu7FQC47yNFrWfrulOd/VrMpRPIHX/YDPXa4P51R7f36wj0sMlp39qonDp2zB94Hg5VpITU+3Y/r1g+o6nKgzqBh0frrhyWDlOHAI4RbjRmXvZQuka1G7Ag404SJMXVIFmqH0cDm8ZOBH/qA+OQOQIaTPNet8oPnhtY0hhmmxCilrh5UZVSEcvAT7ZZIQ+/M/wS4+4MwALwOgK0YvAagihkHlBQmN8wWqbsRolTjc+R1P8hcNq0sVvMAV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(52536014)(76116006)(122000001)(26005)(110136005)(478600001)(66556008)(66476007)(66946007)(66446008)(38070700009)(64756008)(71200400001)(316002)(7696005)(53546011)(6506007)(8676002)(4326008)(5660300002)(8936002)(55016003)(2906002)(41300700001)(33656002)(38100700002)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wobrT6StHAPep7QDFqNcoTjlaVB4dd1MAH40fCwV9bLZmipvFnqDQBbWh3aD?=
 =?us-ascii?Q?VP3a0wSrDw0sG1tdIwnUzLDbw4V9MpW7X7k0Afck1WVMuDlb3RarHXnIBfy6?=
 =?us-ascii?Q?JIvu3rvuaIkOCzp9nto9DKOpTUaxs5Fnkm/kBn6CictFVATdT7NeCO6XLRbb?=
 =?us-ascii?Q?rEwSHwSrWjqSg828pwUzFV0vnppBgP/XohSuqZDPhPk8EoA4A3jAj2mtl32+?=
 =?us-ascii?Q?NOGi2oOJdp3NLQgBhsy97Z3pzrpmODj8dqFj1iyQPWqva/dU03tFN/5uJAf0?=
 =?us-ascii?Q?J+ezwKdvo2f7JHpoLWxM8Dnw2xT7v5whgEk+pkIJnhGUS/27O598mRq2by4N?=
 =?us-ascii?Q?P74DVSHZRvh/d1Z9gEKQ0fUJGDlAJtlxeORwo3ty9LNHdHEuKkqYAXhXor/V?=
 =?us-ascii?Q?/BwfvqsBw/MEdKXLrdUx8j+92hXranC1rDGveax7uTbdBsIsqg62DqavsjLU?=
 =?us-ascii?Q?awnyYEsl572qh/6q9MmcCbEQbjrJuM15OmB9GCuLnq+G2jFGtWKovPsPPNq3?=
 =?us-ascii?Q?RPZQT77oaOysMDCx+zfe5Gr06p0c33T0SEynIPH95u3XzX+ywB3pTrW79lTw?=
 =?us-ascii?Q?gNLXLp1WqPZNAviKX5o6fsvJghAmyNA27nobqQuXdfdupVwISC74U/1540t+?=
 =?us-ascii?Q?AS0JKZdSW3XE5ml+8r4aHLovG7TKkJdCMNn9A9/0BF03+uxTESkyizppvhdD?=
 =?us-ascii?Q?WcGFBW0uQsfm8EQ3i9OLum9oMakzcAIWKH8t0PoHIFXOFSqsOCn1IbBkDJjt?=
 =?us-ascii?Q?EQ/jWzPJvCNKU0Mkiq55V9x41LHxVJzskjATcSeSAwI6KthMLZSls/hJ4nSS?=
 =?us-ascii?Q?ql28vzVHAqjVSGrqdDEaMDERm+WdeFUJ0RGpiIkZrSPkkQsKdgKlnicvREaP?=
 =?us-ascii?Q?4ER/FLj6pj5nczOuiQ10Be6fiqE5xcXfPHdIWEHB4YPCUAESsZu+h7KPsKyv?=
 =?us-ascii?Q?8fN8HxsDvpsjA/hXyS2rKBObSXTZMsFOLTC3ygtEaMmI1eUP2NSDTPU2O+7m?=
 =?us-ascii?Q?KfjxNts2Cuyn5aca3XPu4ZnBGIs3pPhqBTWwjRITilpVh2MkQWb6gQEbT4Cw?=
 =?us-ascii?Q?JYbd+ItwjfyFVV++AF5r5ZKxzlrMne3QoajO5m3T9wUkFIlguSuysbKDUDHV?=
 =?us-ascii?Q?veMxJQxFiC1gKLU8sjFKo3V+CacyxlSGGcjsp1PudLj7y7MrebDUlnrUkwA0?=
 =?us-ascii?Q?jpL5viL+HQrZhYYx2r1foGaZX3XOlTguY41YJi45S5fdIVy4t7mzPAPlhCWg?=
 =?us-ascii?Q?HTKi9rgM0OocYTau3L1DCvBnkwbYYYBnbS+lYfBBMxJE4+VjhodX6hTpGgDy?=
 =?us-ascii?Q?peZp6NLSrO8vCCYSWbzuQxm6a14r8Gb0V8lOZTlaqIYY1Q6Onli3AZ1t5q7q?=
 =?us-ascii?Q?nllDNgr34jDIqp/eMUOp7XtWy9MTMprcPJryFUKapqViPTz05/RPBYoHzkPN?=
 =?us-ascii?Q?FDjzJ98Xb926Lhae9/EDjfjtEJCWTmvqhWiocC9r1SjLobFBM0aPa7FpQYdF?=
 =?us-ascii?Q?hdnrhdpbaBdhQebx8aTVS2DOOeKm8rfFJPSVWnuMQJ2l85gPSJHqKWLpaN4u?=
 =?us-ascii?Q?IbmRmMT5+4ZeCZjB/Hg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a283ded-c204-4e9b-ca82-08dbe062a428
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 13:57:26.8154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPeZitPrMnd/aIC95UeM5aJrUG7QCavH1eLuv5htovEHu1BMeLfEIBri52XDWJvM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Wednesday, November 8, 2023 8:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: correct acclerator check architecutre dump

From: Hawking Zhang <Hawking.Zhang@amd.com>

So driver doesn't touch invalid aca entries.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 15 +++++++++++----  drivers/gpu/=
drm/amd/amdgpu/amdgpu_mca.h |  2 --
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index 3302f4a29387..65926f3c708a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -202,10 +202,17 @@ int amdgpu_mca_smu_set_debug_mode(struct amdgpu_devic=
e *adev, bool enable)
=20
 static void amdgpu_mca_smu_mca_bank_dump(struct amdgpu_device *adev, int i=
dx, struct mca_bank_entry *entry)  {
-	int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(entry->regs); i++)
-		dev_dbg(adev->dev, "mca entry[%02d].regs[%02d]=3D0x%016llx\n", idx, i, e=
ntry->regs[i]);
+	dev_info(adev->dev, "[Hardware error] Accelerator Check Architecture even=
ts logged\n");
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].STATUS=3D0x%016llx\=
n",
+		 idx, entry->regs[MCA_REG_IDX_STATUS]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].ADDR=3D0x%016llx\n"=
,
+		 idx, entry->regs[MCA_REG_IDX_ADDR]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].MISC0=3D0x%016llx\n=
",
+		 idx, entry->regs[MCA_REG_IDX_MISC0]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].IPID=3D0x%016llx\n"=
,
+		 idx, entry->regs[MCA_REG_IDX_IPID]);
+	dev_info(adev->dev, "[Hardware error] aca entry[%02d].SYND=3D0x%016llx\n"=
,
+		 idx, entry->regs[MCA_REG_IDX_SYND]);
 }
=20
 int amdgpu_mca_smu_log_ras_error(struct amdgpu_device *adev, enum amdgpu_r=
as_block blk, enum amdgpu_mca_error_type type, struct ras_err_data *err_dat=
a) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mca.h
index 45f90edf2283..e4f30d20170f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
@@ -79,11 +79,9 @@ struct amdgpu_mca {
 };
=20
 enum mca_reg_idx {
-	MCA_REG_IDX_CONTROL		=3D 0,
 	MCA_REG_IDX_STATUS		=3D 1,
 	MCA_REG_IDX_ADDR		=3D 2,
 	MCA_REG_IDX_MISC0		=3D 3,
-	MCA_REG_IDX_CONFIG		=3D 4,
 	MCA_REG_IDX_IPID		=3D 5,
 	MCA_REG_IDX_SYND		=3D 6,
 	MCA_REG_IDX_COUNT		=3D 16,
--
2.34.1

