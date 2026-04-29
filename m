Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E367FF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 12:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA8710E38B;
	Wed, 29 Apr 2026 12:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bC+w7nGV";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D593F10E38B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 12:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlYLrp437JFY+mAGcb3Qs4rroFlJs0MZlIejAPYVYU7xUacBTHWhMOovcLQfGeanzkTbt8ltXRTMBO0/Y2U4ltwtSzJgjYd0ySC7YTI6ZA2LjD4Zgasar1pa9rZt2aM+XcYegmAsZHf39t4XDH5jlZJ1ZYdPSTMlfyXFKnKzswEJKm9TsmtV+eNZ7f0eyu6DZmhb3NXld3X7BXRYEI29RYLR5FtTdNLeRSLz+AfxYvjqOqiIlNwAujaG++5DzBhl75gVahSyKYWyuSnXPs2fTI6HgzCJBwZa/OethGkIc85Xs9a/6Hur5cxNKl5zD5oy7psEpyDsiSREwS0uFa4dWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDrR4gRDf9wd4d1vweV2ZJhw9dEUtytfB+fqm4FnKMY=;
 b=I9AuTjLk8Jp01uJTjB4JcJMEWI9jmPAGSksQaq7zVInndXJVU2gkEZE5bs9MCKC7Ir3E+Gm/vhPxlq7MeKxaIvcty/wzoR0M7JUiB1iAZvYGTaQ+/6P1NBM9LDJW6Rr1caxEkQoHPDQ6SpVNvWyDEXqLMOJv1bO/wCfyxXP55vb9conT+6nNrekfo5PAFV4QWMvONDe6S1Ct6E5CHFx6jI1ZkhYxwvcyfIMy9741idJHDmoZ6qcXxll1ine8FIhqbo8Rj8+LS1xV1YhNsToffZZTN5Q7RVNrSTCnJVRxgCXtk6Ho6cjGxtr4M3fg1QA/ItTwKc1RvcLn2xISDA57Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDrR4gRDf9wd4d1vweV2ZJhw9dEUtytfB+fqm4FnKMY=;
 b=bC+w7nGV/Wk/m11UVR3dxqT8eFlxgOblY4AwJ01UzbKjBzw1kKORiJ1bZobgszgyxkqtFctTdwXUgcjwup2MIHDXr6qpUvcsbZuUkAw2uo63KY96tdFKcOy3N+HUicKZMLn2SUKopPsro5NogEZ3VfcYeTL6wsmWMeXyj6XE4+c=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Wed, 29 Apr 2026 12:45:21 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 12:45:21 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Adjust GMCv10/11/12 gart size
Thread-Topic: [PATCH] drm/amdgpu: Adjust GMCv10/11/12 gart size
Thread-Index: AQHc19UIt3SOePwK2EWQJDJ1o7QZArX1/GSg
Date: Wed, 29 Apr 2026 12:45:21 +0000
Message-ID: <DS7PR12MB60713ABC5F3BD8AA1D7002EB8E342@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260429123745.3930780-1-lijo.lazar@amd.com>
In-Reply-To: <20260429123745.3930780-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-29T12:45:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CY8PR12MB7313:EE_
x-ms-office365-filtering-correlation-id: 64022c46-edf2-4cb3-f1af-08dea5ed2d1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 72Wp1UU8aPjq2wCJwjhFlgcASyGcOmhLx897SsaTG2utP1SkbdtdyriB0zDVt/C3g71uFRIKmkNzJkEUKU1QhjOdWPD0nfIBleHuy5YC2vlY8hG+4pMK5LZFS5/Hf4D8ocJVZJhF5P8gvkdukHnCDdwI4qrfWSAj954WdXMEw/GoQLGJGek+02t6p70uv/3sCJftnePOZvPXToF8Bdt8sUzqMb+buUuQv+bSSmYbEHrxDOGw7sgq4fK4fK/zKiIT0/a8purFimLK2sA8pcuncrOfFks7AbAwKUkhduy4T4PXVBuEuGPhxAhR/0YoIvIitTJZXupJWphsNJPzw5xjcDQdRmx/59PeYNTX5NCudFuu41J/zrXR1G7askvjrEsRwk8C+xU7M5OHkKxkidt19Coo5fqvLp+NRH0PUiQX7GjUmMdomIjaCX7n8jQtnsjlCZtslN82Ik94Kl4UUFPoYNsSIS8h4o+A5x8UUkJtK71dh9yGhPWANQSMvL13vGK9Jhk8QgwcDH6+4tuqW7FaTHI0aPbGhw9X0TELLGBNy1cU4yKX5AL+VJN5PoN7/QdHz2pd7CjDYi1YD/tI44XkwHcDVGCing0jjLtgJY2QyT3UzG8AfUeI58JKH1J/CTfhhuhKwUlOMKGeRKOnmJJ66E5uIQ3t0rHAIfCBRgqZja9lOJkwmzEbl/n6HHK0UZMh8TIglVzs9YZFGHtZslUdw6lTgCPZMBZuwSq3PkYAuiNUs03M/69cddd8Srfk0oM5hR96HamAIrU6e5eouZosLtVvue0LyGDCGqzS8yvs5r8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?My7G4zhkvdf5sTjddGor8bUksBK3zoCmpLgmT6OZupPmaDzhjlH0/ifJisVU?=
 =?us-ascii?Q?BUi0d1tUUK2wisslrwAVuyr6JLgdAWHrPzJpDA3AAVWXw9qORZLtMMaB/ska?=
 =?us-ascii?Q?8h33xsEyBcPvr4Tk3TQMcf/spdeUmhfoG+vyV78Wldo6okVB85nPCGa4EGrP?=
 =?us-ascii?Q?wxAGWEBQueeIoUzO0XLyoO7fgFK8n0KR0Z0Xyg+kGnbJPLTmZwcanN5LZdih?=
 =?us-ascii?Q?ZCvx6PXOPrbn/2jmD+udFq0zHeHW6fGI/By1vXCkZCJLgjegIzEZpjIp1Ln3?=
 =?us-ascii?Q?bwfDpzrId7783T9+GqzOd9yEfW3ApqEbKaH4QyHh6lKa85//SaOQLsmQeDTT?=
 =?us-ascii?Q?EGzj0+HrAKi9ODs06rxAGc8XMRqMs6u2jbu45RaeUNpbkryPUhstT0qgwokT?=
 =?us-ascii?Q?aTw9Gyuj39MIR0QrF86FCmbhO/yV7G1CJ86ySBr5+YX6NvW8y523Bvua9/d6?=
 =?us-ascii?Q?oC5FGPeChxtk0nt//8q+Vx+hkVKgiShewaSWX/qBfRQ83kcG8Nze2TLiXuT6?=
 =?us-ascii?Q?yPQnQStKS15XQ/ctXUoywYl+Dh5AunmgTCQNxxBIVKJ6MKgBQYWz+HlKgfus?=
 =?us-ascii?Q?U0d3wbf14m0tJPqcSh+udyL4gJ/d2uX3CkOg4xwPJu4NS+p/GOOu3CRoFsNC?=
 =?us-ascii?Q?Mkv5NqyOVds17us83/97KJNDMhGjbJP4lwUrKt2wTT+A53jzypA2JixirLD2?=
 =?us-ascii?Q?8Bviy2YeaWeCwbzCpU8PaYFMPUWsIDY7UcMbYT2QUJUKnni7yIJIj09IJsR8?=
 =?us-ascii?Q?gSbtw/Qe+LIrMB4zAw5b8EuucGeTHeOc5+Spc9sZS/ceKLwyL25ticUmOkrB?=
 =?us-ascii?Q?I8l6BJdlq5lLFpxPXx0O5dtpCK8eiQE9OyExj2KcQASGwe2TctoMvC+mxwqx?=
 =?us-ascii?Q?jNunRJNj9+62BcYqKEsz3JqLruLkNfuEhfDpP0InAeeHN00XyAjWY9v7rXih?=
 =?us-ascii?Q?hVXHAEDSuV2IRC2I3lVI8ucbn6gZ9U9/hwwwQ2vcIYucrdRhH/RICvZ9RczB?=
 =?us-ascii?Q?OKTAEH9Ia9Rw0RDW2Ono/9QE4IrB3McFw4XXDovK4yS1hbc+vQecQUKlmyfq?=
 =?us-ascii?Q?FXA29eeyBWp4mCvlaz751w0osPVll/mI6Rt7OUGrtvEBFfff6XO/qKfAT5P3?=
 =?us-ascii?Q?O2Qq4CeMUvvW4FXMPvUcJ+bHiclaRa12NXRuYZubvn/4rNtgDvJu3JYjv6wf?=
 =?us-ascii?Q?ctzvKTjaCf2kohkom3N/XG2qOsWXbyso+sV76vCngw0igaCrT5yTsO8smxuH?=
 =?us-ascii?Q?7yb32e7Zqh00TBgcDIAlovkB1cgCNcIbN1Z54sT4D0RC+xk63GdUs5Cofyy3?=
 =?us-ascii?Q?yowZUB1vbynM621FQltn2k9aipBC4MIHQxl9slXKjKuYRdUMxmL2QMUmgyZK?=
 =?us-ascii?Q?I1DBx8IfVKa5EbSwxatDpFOspLM/GXkxF5G9ZY3xt7nc56Qx/XyXwj+UpXa3?=
 =?us-ascii?Q?pwTfHaByjL1k0EtPGoMuTJOvoylGqtIIapE3hI5siG+2Xt4Sp/HflTqKl2Hl?=
 =?us-ascii?Q?UWdFppVvGFY6WaedyeKoqI43DxvQIEKUylzUwvkaULlcgKZmGxn/9PCj53uD?=
 =?us-ascii?Q?3V8dbHvjAX+DthT06wYiJExKl389gGF4VKcun9Ivi4bbOiGO2ehgb7e4YkTH?=
 =?us-ascii?Q?tkeuwhjxLjygmdqkf2XuxYWNRAREWR3Jf1manuAoAiPpe6oW8i2IzgeUIgpe?=
 =?us-ascii?Q?9yMwFAqr3Q9yaavC+YT/6lZxkeYguAMQQL51zfSjNBn6XmB0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64022c46-edf2-4cb3-f1af-08dea5ed2d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 12:45:21.5328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKiY+8ikh5WS1onPaSu9OA1tFwEd02n0NfsR/WR1I91oeo6jsWNMwK838M8THmEUc1rR4aDufc743ehbqgok2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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

AMD General

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, April 29, 2026 6:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Li, Candice <Candice.Li@=
amd.com>
Subject: [PATCH] drm/amdgpu: Adjust GMCv10/11/12 gart size

Adjust gart size to account for space required for firmware private buffer =
allocation, if any.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++  drivers/gpu/drm/amd/amdgpu/=
gmc_v11_0.c | 2 ++  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index e1ace7d44ffd..1c32e653a9ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -723,6 +723,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev=
)
                adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;
        }

+       adev->gmc.gart_size +=3D adev->pm.smu_prv_buffer_size;
+
        gmc_v10_0_vram_gtt_location(adev, &adev->gmc);

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 94d6631ce0bc..2f6e338f2a35 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -714,6 +714,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev=
)
        else
                adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;

+       adev->gmc.gart_size +=3D adev->pm.smu_prv_buffer_size;
+
        gmc_v11_0_vram_gtt_location(adev, &adev->gmc);

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index 5bdd4b9b7893..e5096b9cdf50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -770,6 +770,8 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev=
)
        } else
                adev->gmc.gart_size =3D (u64)amdgpu_gart_size << 20;

+       adev->gmc.gart_size +=3D adev->pm.smu_prv_buffer_size;
+
        gmc_v12_0_vram_gtt_location(adev, &adev->gmc);

        return 0;
--
2.49.0

