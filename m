Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73188C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 05:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0D510E00E;
	Wed, 29 Nov 2023 05:27:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139FE10E00E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 05:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaCD7/lrAaldzSyRkDkE5MmutWdHw8DQ1EO0iSHB1jMjkGVEKF39Re8oCPMwdUDUh4EEssJ6Jo41DKzmnE2AzwwCaW0U37CKNKA+/anmmTlUt2Dt98eZuEMpRr9NNrEUEzsyxnG0NgBBq8cUaSBLtw1A7thocfpj1V5dlNxrsGRTwls/JMIy/Bch6leDRxf8dvXS9dgtMp7ZSfkqzMzpycBvvVrH1h8VE9JzSgJJSSvEyHtSykWyCzkjVv5orwIyKhGKkxiWTKGK3MgWHyHRbczbtDNeqAoKoClxaJexEmop/pJzYSruomIqg1SFzaiVY9VQGZP+q1luZZ7mQCz3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Okadp7vprhGtLuHJqPGfDXtQhBzkMb2UgYO6EVhY/Ww=;
 b=Jzb58NJ9/SSB+OLPyqzieWp0DcEf6Oeh8eN4ET3GGDWYIj/mwz9aJQcGuuL7bvQ6rKgA6qb3rnspJ2mgySyu2cHUTN4QZoejY1yiBIx6iYM+2kcrHz92cVWPQkky8H2lRid3zXx6glz4Pmm9fFu+LCnlxMgbXHVr9L1nOoZ4O/JVsD9oCvvhk9k8UDPEC7xLGYyhGJqK1ZjLKsJCFJj4ZFY1Ppl4oFiPsfESgQ6aN9vjL8SsNjMsDRtddjWDAoD30QB7tSngwliXKwT+xN5orbI+7rqhAIWjXFcTFvuaW7QcRZsroB+PZC6VJIpgU8RSh8sFzDqUwvdGnnRBBf1anw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Okadp7vprhGtLuHJqPGfDXtQhBzkMb2UgYO6EVhY/Ww=;
 b=3dcJC/6KJp7Ly3AArJHrrDUXpcTThl9v0yqBiCrCe+8w/nlkCJbgoDOF7kkghvULbP/ZQpjmM/R3e1Zm4eW4IKJssruzccCf8oWpJlrJqegrI4m2AFuOdAk3H6hzLOu2APGOo+BVtAyucgXEnhSmJpE4Zi5ndgoxJk0cqFpV+wM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 05:27:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 05:27:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use another offset for GC 9.4.3 remap
Thread-Topic: [PATCH] drm/amdgpu: Use another offset for GC 9.4.3 remap
Thread-Index: AQHaIe20kGG6Ouo/dkO866AQ8/uFTbCQxYxw
Date: Wed, 29 Nov 2023 05:27:33 +0000
Message-ID: <BN9PR12MB5257E8D26720345610697E8BFC83A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231128112536.1129777-1-lijo.lazar@amd.com>
In-Reply-To: <20231128112536.1129777-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e0f6f548-b78b-4aea-ba6d-c576b3dd82bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-29T05:27:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB5792:EE_
x-ms-office365-filtering-correlation-id: d9901dac-2e82-42aa-0fe3-08dbf09be408
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNQuLA/iUGZYuPoi5FafIS9uQyAZ+dn9tNm+e8d5QAxxyPWJspUzhNlVqGEn7A82QjrpNvuZ/q1Fo8t7243w8AoQoENjtbi0WMMZzyC+iBhH+f4xeF4S9Wd2VgOAehI8RVjH0h1yzKXQVaY6MEWqxx1/R58h+ytSXJfM1F7QZL6XeVYJWxTCRx+AKXkVOV7nFa2wX4gb8ofAChxbFNv3+Qr7++tm3ndKz63tFlidlDAufhY+C7+G6Chdm0EXrpyMTLfaF0uJaGq2DlzTkAIIG7+kz7d8FXxdPXH9inVVKrP0w3d8ks2slMaMf2osy3wxtL2Byc6n8HEuq+6SIiOJCdkIsFoJR4XLw55IxkAyiSvDyxQIzhy5OBTfSWl6y4/hAg3tFwluWC6EDH7vDFrx1ywcJZJS5UZP3fuPJoLbBoxt1KT0mugS6Ak4xWN2a4z1A4vPIGDP2UcoIcut5rtNmLPTslDSFz8DI1KB+Ngp4WmpKRTqX10SwJ6k1QKP77by4iG6ngvOcPK3jJdcMKv8BGPTpXKz6Pvz2dh+mIg6NuJj2LUb7w1/SAqY7vdHYjGRUuf0U+hsY+fl0Ttz8o+/vjIaQVt4/Ycxp1NRDPVT6M5rqdF2kyjE4aGbJ7WaO7QPbcAksdNfQWjeCJyqkLty5gGCih70qOfzDek/5HYk1aA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(71200400001)(53546011)(55016003)(6506007)(52536014)(8676002)(8936002)(4326008)(5660300002)(86362001)(66946007)(478600001)(66556008)(76116006)(66476007)(54906003)(64756008)(316002)(66446008)(110136005)(38100700002)(83380400001)(122000001)(7696005)(9686003)(38070700009)(33656002)(41300700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JXOxpHVbCfpRs6eMwJ1tDDHabRdNCiZ0LcyjWdGQ6rhhA/seQ+yybR1eQ6qQ?=
 =?us-ascii?Q?6MNfXxAJvj0/ZpBhFlZTf1UtNAS1WvbZOlBO8S7ziFT6GokPsWWH5UWfIeCs?=
 =?us-ascii?Q?0yoF84cAH4iERYHeXQd6fkDgp/siI8DWGBL+DKfEoY82J4Pmw7xarqx0YqaZ?=
 =?us-ascii?Q?quZo1hi637BjnRmHFOa3V8DWgqoyXS3CWpA5pr5ZCTtX/4naL27ALWfbpw5g?=
 =?us-ascii?Q?tJsUPkn3/BK0RqcLHY2kZqgYQV5pXbVC0aiq2ADa5YK970WUuXQpbNYDZJ72?=
 =?us-ascii?Q?CQQW4GMQNUXOcfELj5d7I+6jpoW7SU0LMMEsjUZnOQu4mXfRR5eye1t7+CrB?=
 =?us-ascii?Q?s+zxm57Z6VyEmGfuuluNhMMeZfO8eBDuB1YLodbXqC2BtJatUG6+PCgdFOpd?=
 =?us-ascii?Q?pPzzjQpA0iMQ3WebycvUKN/vEKhNISatYfdOcza6ZnFSGG39Mih6MFlRvNEF?=
 =?us-ascii?Q?PcxWrckek+dDA2ukm0twwirgXa/Nd9D7NrQtFQIVGYHc2whBwvkFvp7macRX?=
 =?us-ascii?Q?z1HzxbHE1ruK6aU49rLelrglEKuMYtdTt19XawZSQ6JvgoyjqkPhOBargn8m?=
 =?us-ascii?Q?FvRqgJ+s/9AxwF0BE6Vbi9IYUAbAKOWj27gV0JgheFyFosx/9UwwC8wH2FKK?=
 =?us-ascii?Q?9no/rydPjV/hk8J624CX08jeu5AQZ1oz2F/JV9+UhgBxePpSgfRfqlU+alyk?=
 =?us-ascii?Q?mAVwBePCcTYC7pMdIPe9Q78REP4DWATIOuzy7NM+I1Bhl4wHZUvYxecma35b?=
 =?us-ascii?Q?WeLSy3eciNdCgpsReyU+ZsW+CNsr1//iZ3rDu0XQjZZpR/EbB3mtpRY07hZ9?=
 =?us-ascii?Q?M3MG5QJW/BIH7bI3rQyuow3Nkta/Q30Vm6WrWmg+U28mqiAK6ymU6FxyKkUU?=
 =?us-ascii?Q?MVjEI0ent7dAhfRoaXoCqTQRwFPcq8eipq28iUqpwut3W64hPcBj/8Dmj26V?=
 =?us-ascii?Q?CJxOKRIO9tUY07BJWxzI2CLlgbqK2hgaHzvGVsvI30EAp/fpHTKyYr+ndl7W?=
 =?us-ascii?Q?OnlH2qEcqMqy3/BCpbKZaXr/XukZC4L0MWLrJxjZereDxu5FQjy+Rja1iVhs?=
 =?us-ascii?Q?ZYZu60th+6W0Jg3QRRRZEQ0mhAQIY/FvDCG+oUtBz6WYRi3/nZtipjc9Ng6+?=
 =?us-ascii?Q?ycnqawFk4JQFHT43Zv+zZaT3L0bPxxnGLyYVf0KHYp43WKmcicnIRd6r1VnC?=
 =?us-ascii?Q?QOibBQYkA1w9n3y96f8VwgdeQWeTAbEmcu15BFaVzBxXmXRoCXnbbWLSm4TF?=
 =?us-ascii?Q?3dy5292SKH1uuMKfpy8YzyWgQIpbT562te+z2z/b1GmH1cR6e6XbW7zje9bl?=
 =?us-ascii?Q?9wARh6uezbIZYVRUwstwUx1FFnA3QH7cKRThhGmiUQ6mTPS9PM9QedX7ROD6?=
 =?us-ascii?Q?ZGpIqeHcPbc5L73K7j+pcJaamSJUUVfZCfr/ltpY23sUyo9sulIi6C4e3CK3?=
 =?us-ascii?Q?d7BthdLUpY6dJwH5CHPo1ZsvIL+xftl21CC9nR3nnj24XH9DPeN8ca/ozTtY?=
 =?us-ascii?Q?vH9b2WhCE0j9GmmTUu1daxIhAfj1om2qMahNIvwZqKjO1GsuqsH5cZ6MBw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9901dac-2e82-42aa-0fe3-08dbf09be408
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 05:27:33.8886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKp/i8zV9EOu0twab8t0NGpyfh6OzJRef8y0D2n/17Dsjci7voapWajnSJoMPrOEce/zn9u0B7t73aTsLqLZZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Gadre,
 Mangesh" <Mangesh.Gadre@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, November 28, 2023 19:26
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Ma, Le <Le.Ma@am=
d.com>; Gadre, Mangesh <Mangesh.Gadre@amd.com>
Subject: [PATCH] drm/amdgpu: Use another offset for GC 9.4.3 remap

The legacy region at 0x7F000 maps to valid registers in GC 9.4.3 SOCs.
Use 0x1A000 offset instead as MMIO register remap region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index e3d41e8aac9d..9ad4d6d3122b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1162,6 +1162,11 @@ static int soc15_common_early_init(void *handle)
                        AMD_PG_SUPPORT_VCN_DPG |
                        AMD_PG_SUPPORT_JPEG;
                adev->external_rev_id =3D adev->rev_id + 0x46;
+               /* GC 9.4.3 uses MMIO register region hole at a different o=
ffset */
+               if (!amdgpu_sriov_vf(adev)) {
+                       adev->rmmio_remap.reg_offset =3D 0x1A000;
+                       adev->rmmio_remap.bus_addr =3D adev->rmmio_base + 0=
x1A000;
+               }
                break;
        default:
                /* FIXME: not supported yet */
--
2.25.1

