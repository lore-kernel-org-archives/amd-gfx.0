Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D78C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 03:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843E010E22B;
	Tue,  8 Mar 2022 03:12:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA90B10E22B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 03:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3IXMgcGyv++xDUzdhsaVt6YWH2dqnZmLOgVHoVnhMH2le3CC3l88GCmfKOtaxJK8AgpmosFbKphmrbPfLcMhdkMeLi11G8tKVcNZwCl1IgYOBIgZjUDJmACQ4p3KZm/6D37BK/t4QDZAgx30Rfgt8e8++SmlkLFqg29oa67xPZ+rslkh2hJprsk9YFV+yJ99N7k6v3+UlpvujcL7VcAohvAWBmdM14Q8dOWx+lCRx0S03pPJaMF+fvQwYvYQyE5MDJv0o5Riend2ROpwdFol+0juzp/LVImcoUvK4Atq/DIzrm0EzF6mU36bSPpmtZVvfWQ9/JPWSjQk8xdRy/IAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMMc+nqhvAPBGkmD2phz8TwYNNEERZPKX1NiDRH8xNc=;
 b=V/VXMfvd+9htIjEkIaHUMPEk37bhY09//Yd/P13gxnGTSyqbPbW2TMKhlAbfuPsdTM4bbMr7klgspALFv2za0H/n2Os+fkycOEQSUYfQDaTRo4Jq8KChMXbvEBIr/K3WnEj4PLnG6TUoeWwH/cqAhv+JeyCutJsOkrz0HTQJ+yXYgmvpvSKJNNLLH00SK9U1ChnoC3zwJj00cDbgBfEB8bBWMvrkvfcPRfcvGz0+lm/zYmIJ9nUvtdBAke2Zztq76mOpQHajRWxJbU9C/3Vq10Jer167ZH4KgaEb+mGRAFDwwAUqGRgP5vd2i7JBv3w1R2jv1g+ebR77xP7lavFi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMMc+nqhvAPBGkmD2phz8TwYNNEERZPKX1NiDRH8xNc=;
 b=D8pMoNUz5mStFE0xkCk0n624tKiI1TuHNupbvF8f8uu5hsL7QZ9t3NGjgRT2N5uDDzMglCletrL4p9Y/bqTnE+qR+vVzagBRKjuZkb8wdy/i9T6DIXSRwI2hdyb2BuzJeQb4BbiijDgzD/MlhudpX5nFXzOD/hvOvw+4d5KU2ZE=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY4PR12MB1893.namprd12.prod.outlook.com (2603:10b6:903:127::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 03:12:46 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e8:9acb:62ae:8fb3]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e8:9acb:62ae:8fb3%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 03:12:46 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: Move common initialization operations of
 each ras block to one function
Thread-Topic: [PATCH V2] drm/amdgpu: Move common initialization operations of
 each ras block to one function
Thread-Index: AQHYMf9uF6lp38P3wk6fIN2tzrfx0ayzomSAgAEuUyA=
Date: Tue, 8 Mar 2022 03:12:46 +0000
Message-ID: <CH2PR12MB4215652CBE9C978A705F219AFC099@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220307084259.1752140-1-YiPeng.Chai@amd.com>
 <DM5PR12MB2469A8BB6896786AB2059A7AF1089@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469A8BB6896786AB2059A7AF1089@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-08T03:12:34Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=dfc9bfd6-1409-4559-b3b5-ea5e9b3645c8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-08T03:12:43Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d2cd7185-15d9-4bb3-8688-02865c2a4466
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6346ad15-e957-4bd7-8d88-08da00b184c2
x-ms-traffictypediagnostic: CY4PR12MB1893:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1893F3F64972EB056EAC3A55FC099@CY4PR12MB1893.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qa9o/VJpH9UYuQDLJEFtX7mqWNHxI0Ftzd5iVrghcZqalDeOPPxxUXgOWGkv9ZuwHyD9OIE7WOZlHJMOaTD3QmzjWtyQwDq6UU1lqkl4qenF2Ac3qjRg1JyNU+A043QRK7vYH2jKZ2Muj1fj7NrGW5A7Sn1/9qA40yk/DotNx5Mk1SlzpzMjstMiH0Sjqf7zs8VHWrFaBUeIYHZ4fhm1tHazJEJ3yCpq0MwSoZz89i56m+aPGEjZkkbwbQ1rtSJpT2/28QZ3XGMteMzRQWr46Gv1r1qCZsiXWiSLu9asQKeRfL+vwfXbr65wd3PLUfyneqsCBTXzDnuPAcFqkrpNAwyPcyPQqv5LZcIHIq7n8HnNyNerxhPIW6x5AozHrr3H8bNdVfjSPrY9LvMGRdiuONHvaJA7/gkN2iFVVRbONYJCEFIlDNmjamU2Qf2AdG/3XlRpse6me+TRa5gqi2VLhmbROGBXzCS+qfl55LKFyhnfYSYTODS1n/qLizk5UBTGJHvYVMSqi9xwv9rktWljnZBtDWNgiBgtiPMA+Z2sTlw6L01aNP2xruXNAuJUoIFn5bGtoSofcH8/SS4BatJBCgAvotjXAQrgyx7SEq4tvVuBCLPbpLQcmwox0RSi7AzdZvHX4S1gCMiF9Bt/8QivO1CCT1ee4I5vKJVDqL9w87LvOnLHdE5j3GGcJk7AoFHkwJXzS6H2VmTVZEA6aOtYRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66556008)(76116006)(9686003)(52536014)(30864003)(316002)(5660300002)(8936002)(54906003)(26005)(66476007)(110136005)(64756008)(508600001)(66446008)(4326008)(86362001)(122000001)(186003)(8676002)(7696005)(38100700002)(53546011)(55016003)(71200400001)(6506007)(83380400001)(38070700005)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LstdPeCPhfbPEFtmk9XSaEOhLQwq/ztV3tu0Lys8jW+HYC6tiCf0n+YGoRKS?=
 =?us-ascii?Q?XWV1n2m70zoxTS1xoJeed8tSzVOd+hoyNNepLJR7+ne1fo178dWJsUphNUg8?=
 =?us-ascii?Q?87mavIp4zRP4W/U45/9WcxOaBb/9qccUhukA6qLnl4QinTE6Zi+gym0XkIG9?=
 =?us-ascii?Q?r9QkFgKeymJfJmQxfCyPyZRCZLckB1lymDRUMQsWn77Gfhe1YTqKUUNyxB+T?=
 =?us-ascii?Q?25wd8j6KHqljR5RxggVgpIqZeKyAN+E10E1YNsjaqg9Gjtj1nEgVS/oDthEF?=
 =?us-ascii?Q?rPrFvHBz/w4TZfnS7TjnEgUeVRX3qzt8cNKOmLDBB2iIpRPJW3zNV1akmio/?=
 =?us-ascii?Q?/QKXnDyCACbSbmS+EN8yKL/DPLsG0EfvEO0ERUQdHCIrXW3jRdkYkz+NhrED?=
 =?us-ascii?Q?rLIPuiuFp850i1I5r6/CAEbIeZ0lmDF6G/mADHd62jm06tSkkRktT4Mv+etb?=
 =?us-ascii?Q?jRKIwhHKo4wZmS8TRjfdYu9uZ5D8LhW8ghrrZKEnVq46yEEULtcNiIXcCewm?=
 =?us-ascii?Q?PBU/RKc5bbsQ7rty1pLn7ZyAUdZDhz7UvLenUbrGcAYgd9fyfGo04Mo62ITR?=
 =?us-ascii?Q?YyTkqKn4TG73ey1jrC+ZSssPKfKnhgiTkm527BTtLQ/pDOq2Mea7hGnk4sNo?=
 =?us-ascii?Q?vDwiw6/+GOpdbdd336j/zQfY90iFbU83m25XlFTg+mMqym0iy4uz8tw3bH2V?=
 =?us-ascii?Q?X5adyIWcqiY6Zj+ZQziUWngUwhUTosJmWaDCjJndastJzSmEEu5KP6emCOTq?=
 =?us-ascii?Q?MUnBA6XAxD8oIPOSnzRaYhFZUpptNJ5mQbMDIndl5vUi2IcZ39cy0weIRBvj?=
 =?us-ascii?Q?CSFyg33VeDFJcmwwVfFjiNVuB87PzKpX8Hs4BgzwP5H7gb294zeNpXvL/mvr?=
 =?us-ascii?Q?Z73/a/g3bbGO80S/Znn8v8kjzG9/mHZONY5MynZL2/LJ4D+7oGinNm/ZvZPZ?=
 =?us-ascii?Q?AObb81KqmhYELNPWKDqeLef/spPSrFMtOxl6YjpcSTZ+eYwBlzZk59pP7D0M?=
 =?us-ascii?Q?g0lYoYWMOp5Fq7C9ZE9CjL641zqMB+/8FoiuyB0s04EPa0W2DKSZ775RdTTB?=
 =?us-ascii?Q?8EATn0aFBnQPxaFKlNv0rfHNzsH5rPF9F5DxGxudISm1ogCorAI+fKn7DXHl?=
 =?us-ascii?Q?ojwFkAgnYInCQo5CWED/XnQSlS/XLsmH1k+4HVdxM4edipcHJ1IRNDwPndxb?=
 =?us-ascii?Q?9WOYgHN/xykveELwN64IHKdaqAulOF5DxvLO8JR4r7ZuHgaJY8xz0s2cZEgv?=
 =?us-ascii?Q?/8AHHWJStprqE39qpjl0MbUc7QRnPvzEIGkBCSJr0PmuRmrMWqZP6lu88zBU?=
 =?us-ascii?Q?h8px+c2t9oUcWvlRwvt7zZMwpURdC0aH0mTU/FyzvHX8VkSSUWC8K9XSMMjz?=
 =?us-ascii?Q?HP3yPFRyT3TIWG6wxLT8EVqAjoQjkO7RjhGLh9cAKq+H0aEvmdm/dXioeJp2?=
 =?us-ascii?Q?QzZifNIMZeba+39O1FuSr4kY8LTgvhnhDsH5qJzo1xiwDLCStuwv4zUHcOrz?=
 =?us-ascii?Q?/arKReFrY49qGV7xBnBReNmLoeKcrCg4zg0YLin0atKg7U2uqoAk+INphn2a?=
 =?us-ascii?Q?CiqDLujJsbpEsh5hJG47IJerCtbjSpsDZjdYh+b3RRq6voLvMPZmhHtjTDOC?=
 =?us-ascii?Q?ViiRpPoSXqdILZzaDLWYnw0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6346ad15-e957-4bd7-8d88-08da00b184c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 03:12:46.0869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9j4qxpHwdoJOZHhXz9v61WJuOvCwsjmKYQ3KGdrLdV2wm+ajpTw3teNk+uz0slK1iakx0WE7Etdo5G0dVJfzZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1893
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

OK

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Monday, March 7, 2022 5:11 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: Move common initialization operations o=
f each ras block to one function

if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras =3D &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-		adev->gmc.xgmi.ras_if =3D &adev->gmc.xgmi.ras->ras_block.ras_comm;
 	}

Coding style needs to be fixed as well. '{}' should be dropped as there is =
only one line after upper if.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of yipechai
Sent: Monday, March 7, 2022 4:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: Move common initialization operations of ea=
ch ras block to one function

Define amdgpu_ras_sw_init function to initialize all ras blocks.

V2: Modify error debugging information.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 143 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  21 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  16 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  28 ----
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c      |   6 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  17 ---
 9 files changed, 148 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 6113ddc765a7..0c83eb69dad5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2402,6 +2402,12 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e *adev)
 		}
 	}
=20
+	r =3D amdgpu_ras_sw_init(adev);
+	if (r) {
+		DRM_ERROR("amdgpu_ras_sw_init failed (%d).\n", r);
+		goto init_failed;
+	}
+
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_init_data_exchange(adev);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index ab75e189bc0b..544241f357b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -440,8 +440,6 @@ int amdgpu_gmc_ras_early_init(struct amdgpu_device *ade=
v)  {
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras =3D &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-		adev->gmc.xgmi.ras_if =3D &adev->gmc.xgmi.ras->ras_block.ras_comm;
 	}
=20
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d3875618ebf5..89075ab9e82e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2299,8 +2299,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	case CHIP_ALDEBARAN:
 		if (!adev->gmc.xgmi.connected_to_cpu) {
 			adev->nbio.ras =3D &nbio_v7_4_ras;
-			amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
-			adev->nbio.ras_if =3D &adev->nbio.ras->ras_block.ras_comm;
 		}
 		break;
 	default:
@@ -2533,6 +2531,147 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
 		amdgpu_ras_disable_all_features(adev, 1);  }
=20
+int amdgpu_ras_sw_init(struct amdgpu_device *adev) {
+	int err =3D 0;
+
+	if (!amdgpu_ras_asic_supported(adev))
+		return 0;
+
+	if (adev->nbio.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register nbio ras block!\n");
+			return err;
+		}
+		adev->nbio.ras_if =3D &adev->nbio.ras->ras_block.ras_comm;
+	}
+
+	if (adev->gmc.xgmi.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_blo=
ck);
+		if (err) {
+			dev_err(adev->dev, "Failed to register xgmi ras block!\n");
+			return err;
+		}
+		adev->gmc.xgmi.ras_if =3D &adev->gmc.xgmi.ras->ras_block.ras_comm;
+	}
+
+	if (adev->gfx.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register gfx ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
+		adev->gfx.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__GFX;
+		adev->gfx.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
+		adev->gfx.ras_if =3D &adev->gfx.ras->ras_block.ras_comm;
+
+		/* If not define special ras_late_init function, use gfx default ras_lat=
e_init */
+		if (!adev->gfx.ras->ras_block.ras_late_init)
+			adev->gfx.ras->ras_block.ras_late_init =3D amdgpu_gfx_ras_late_init;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->gfx.ras->ras_block.ras_cb)
+			adev->gfx.ras->ras_block.ras_cb =3D amdgpu_gfx_process_ras_data_cb;
+	}
+
+	if (adev->umc.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register umc ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
+		adev->umc.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__UMC;
+		adev->umc.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
+		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_=
init */
+		if (!adev->umc.ras->ras_block.ras_late_init)
+			adev->umc.ras->ras_block.ras_late_init =3D amdgpu_umc_ras_late_init;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->umc.ras->ras_block.ras_cb)
+			adev->umc.ras->ras_block.ras_cb =3D amdgpu_umc_process_ras_data_cb;
+	}
+
+	if (adev->mmhub.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block)=
;
+		if (err) {
+			dev_err(adev->dev, "Failed to register mmhub ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->mmhub.ras->ras_block.ras_comm.name, "mmhub");
+		adev->mmhub.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MMHUB;
+		adev->mmhub.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNC=
ORRECTABLE;
+		adev->mmhub.ras_if =3D &adev->mmhub.ras->ras_block.ras_comm;
+	}
+
+	if (adev->hdp.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register hdp ras block!\n");
+			return err;
+		}
+
+		adev->hdp.ras_if =3D &adev->hdp.ras->ras_block.ras_comm;
+	}
+
+	if (adev->mca.mp0.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->mca.mp0.ras->ras_bloc=
k);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mca mp0 ras block!\n");
+			return err;
+		}
+		adev->mca.mp0.ras_if =3D &adev->mca.mp0.ras->ras_block.ras_comm;
+	}
+
+	if (adev->mca.mp1.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->mca.mp1.ras->ras_bloc=
k);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mca mp1 ras block!\n");
+			return err;
+		}
+		adev->mca.mp1.ras_if =3D &adev->mca.mp1.ras->ras_block.ras_comm;
+	}
+
+	if (adev->mca.mpio.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->mca.mpio.ras->ras_blo=
ck);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mca mpio ras block!\n");
+			return err;
+		}
+		adev->mca.mpio.ras_if =3D &adev->mca.mpio.ras->ras_block.ras_comm;
+	}
+
+	if (adev->sdma.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register sdma ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
+		adev->sdma.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__SDMA;
+		adev->sdma.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
+		adev->sdma.ras_if =3D &adev->sdma.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_=
init */
+		if (!adev->sdma.ras->ras_block.ras_late_init)
+			adev->sdma.ras->ras_block.ras_late_init =3D amdgpu_sdma_ras_late_init;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->sdma.ras->ras_block.ras_cb)
+			adev->sdma.ras->ras_block.ras_cb =3D amdgpu_sdma_process_ras_data_cb;
+	}
+
+	return 0;
+}
+
 int amdgpu_ras_late_init(struct amdgpu_device *adev)  {
 	struct amdgpu_ras_block_list *node, *tmp; diff --git a/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7cddaad90d6d..fc5ed6c47443 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -595,6 +595,7 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error=
) {
=20
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
+int amdgpu_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_ras_late_init(struct amdgpu_device *adev);  int amdgpu_ras_fini=
(struct amdgpu_device *adev);  int amdgpu_ras_pre_fini(struct amdgpu_device=
 *adev); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gfx_v9_0.c
index 8def7f630d4c..e26fc2ae98e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2188,27 +2188,6 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_dev=
ice *adev)
 		break;
 	}
=20
-	if (adev->gfx.ras) {
-		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras->ras_block);
-		if (err) {
-			DRM_ERROR("Failed to register gfx ras block!\n");
-			return err;
-		}
-
-		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
-		adev->gfx.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__GFX;
-		adev->gfx.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
-		adev->gfx.ras_if =3D &adev->gfx.ras->ras_block.ras_comm;
-
-		/* If not define special ras_late_init function, use gfx default ras_lat=
e_init */
-		if (!adev->gfx.ras->ras_block.ras_late_init)
-			adev->gfx.ras->ras_block.ras_late_init =3D amdgpu_gfx_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->gfx.ras->ras_block.ras_cb)
-			adev->gfx.ras->ras_block.ras_cb =3D amdgpu_gfx_process_ras_data_cb;
-	}
-
 	adev->gfx.config.gb_addr_config =3D gb_addr_config;
=20
 	adev->gfx.config.gb_addr_config_fields.num_pipes =3D 1 << diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0=
.c
index d9353bb99314..5046be86702f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -669,22 +669,6 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)
 	default:
 		break;
 	}
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
-		adev->umc.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
-		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_=
init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-				adev->umc.ras->ras_block.ras_late_init =3D amdgpu_umc_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->umc.ras->ras_block.ras_cb)
-			adev->umc.ras->ras_block.ras_cb =3D amdgpu_umc_process_ras_data_cb;
-	}
 }
=20
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 4c3483fbe613..8f6aefb9be08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1228,23 +1228,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_dev=
ice *adev)
 	default:
 		break;
 	}
-
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
-		adev->umc.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
-		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_=
init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-				adev->umc.ras->ras_block.ras_late_init =3D amdgpu_umc_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->umc.ras->ras_block.ras_cb)
-			adev->umc.ras->ras_block.ras_cb =3D amdgpu_umc_process_ras_data_cb;
-	}
 }
=20
 static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev) @@ -1278,=
15 +1261,6 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device=
 *adev)
 		/* mmhub ras is not available */
 		break;
 	}
-
-	if (adev->mmhub.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block);
-
-		strcpy(adev->mmhub.ras->ras_block.ras_comm.name, "mmhub");
-		adev->mmhub.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MMHUB;
-		adev->mmhub.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNC=
ORRECTABLE;
-		adev->mmhub.ras_if =3D &adev->mmhub.ras->ras_block.ras_comm;
-	}
 }
=20
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev) @@ -1297=
,8 +1271,6 @@ static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *a=
dev)  static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)  {
 	adev->hdp.ras =3D &hdp_v4_0_ras;
-	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
-	adev->hdp.ras_if =3D &adev->hdp.ras->ras_block.ras_comm;
 }
=20
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev) diff --git =
a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3=
_0.c
index d4bd7d1d2649..3d2b974f6e0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -129,12 +129,6 @@ static void mca_v3_0_init(struct amdgpu_device *adev)
 	mca->mp0.ras =3D &mca_v3_0_mp0_ras;
 	mca->mp1.ras =3D &mca_v3_0_mp1_ras;
 	mca->mpio.ras =3D &mca_v3_0_mpio_ras;
-	amdgpu_ras_register_ras_block(adev, &mca->mp0.ras->ras_block);
-	amdgpu_ras_register_ras_block(adev, &mca->mp1.ras->ras_block);
-	amdgpu_ras_register_ras_block(adev, &mca->mpio.ras->ras_block);
-	mca->mp0.ras_if =3D &mca->mp0.ras->ras_block.ras_comm;
-	mca->mp1.ras_if =3D &mca->mp1.ras->ras_block.ras_comm;
-	mca->mpio.ras_if =3D &mca->mpio.ras->ras_block.ras_comm;
 }
=20
 const struct amdgpu_mca_funcs mca_v3_0_funcs =3D { diff --git a/drivers/gp=
u/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 01b385568c14..fe61fcd22f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2809,23 +2809,6 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_de=
vice *adev)
 	default:
 		break;
 	}
-
-	if (adev->sdma.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
-
-		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
-		adev->sdma.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__SDMA;
-		adev->sdma.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
-		adev->sdma.ras_if =3D &adev->sdma.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_=
init */
-		if (!adev->sdma.ras->ras_block.ras_late_init)
-			adev->sdma.ras->ras_block.ras_late_init =3D amdgpu_sdma_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->sdma.ras->ras_block.ras_cb)
-			adev->sdma.ras->ras_block.ras_cb =3D amdgpu_sdma_process_ras_data_cb;
-	}
 }
=20
 const struct amdgpu_ip_block_version sdma_v4_0_ip_block =3D {
--
2.25.1
