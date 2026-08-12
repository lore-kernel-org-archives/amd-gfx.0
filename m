Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5688C5CFDB
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 08:37:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4591310EEDB;
	Wed, 12 Aug 2026 08:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rZoLpn7c";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F3A10EEDB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 08:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ6IwMz6D0JTbLQ+HFAX9+8GH06Zj0UM5Bpdy/IMkdjhRaADZ+Nmkrg0utRViGPNdq9o51JpamaugxVGe6JxTmZgox7iLtecugcn4nF4NwNHNMdSvpP709qo3SCQaVcYxMqhOsIDT5/oXYnCacZum1URkU995BvSvxTnO58YG5FaWsyNrh4pDfldMYigqLQM/IulOocJIa6NZcwoV4r55KJr4usVGrBoF10whxC7PI7woAKrTgVNo0q+u4UJPAiONvbQMwbZZuOjlmqBmKTltlCIgLGX+VIwq4Gw7aUn+SmtqtNKnT2XTKLFhkV7XhQdfxq415B0Spytw7RA1LjfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKwCMWu7Nbg9BMsvScVHfOW2oW6xFfYU+Q6LrARpaOA=;
 b=ZsEAGMrQf+KxeGZmhZA/4CsK4uBxiKY8rJoKwxMxM/dLzjLRItLKnV1Udki2JlRuoI2ovAsULD/SHwbkz/SjjiEDCJFYG9pIdPyZ3T8VagrTVWCVe/XYdrk4sjgBF/8L3O4WvEYPDli8XGKQwmaQ6qlzDlVPw0DN/kzgnqR0wcDxGxMMKOyzKaTsB6Ku/6G5aHjhljTaJicoKAqMY8B6GgF2dMtPrp17t/9HM/M76W7hktvbufLw6tC9NvSDSb6NkX7SK5w0Ja2kv+llaFH22FiuKBw49r4SgNYRaqVp5p3kAUoez/5yst+2HpRaoux1WUn6EpvuTvzDSyjQ/CCmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKwCMWu7Nbg9BMsvScVHfOW2oW6xFfYU+Q6LrARpaOA=;
 b=rZoLpn7cU4Q8q5/hU8gAjk23bEeyQV94JwTFkMcUL2uN93j9/aGt30G0VS20j46tFBjbRqggjLtBlFceHjB4nxoQ45gH7Bvs5MiwLZNTu/KQkfLTawPPsb9lrk++i2xUqEr5+swY2T1xTBrsAe5XNnGaxoiSPJaky/sbQxi8S/I=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:37:22 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 08:37:21 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable runtime PM for externally attached
 dGPUs
Thread-Topic: [PATCH] drm/amdgpu: Disable runtime PM for externally attached
 dGPUs
Thread-Index: AQHdKjHUDdci0c+x702fvxJ7/cj5q7aaFxDQ
Date: Wed, 12 Aug 2026 08:37:21 +0000
Message-ID: <MW4PR12MB68031B1C2A108FF3BB81E6D08EDC2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260812080841.2936007-1-kevinyang.wang@amd.com>
In-Reply-To: <20260812080841.2936007-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-12T08:36:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|DS7PR12MB5983:EE_
x-ms-office365-filtering-correlation-id: 123e21e8-8aed-4bdc-d6a2-08def84ced7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: J9JglWaHf4KCrAvW9ArzdCKCvV1fFOQEH3qGBdqG3Cf/Gdj6bKKx0fgQp2YWsF6hIsJEN8niLfdbbfesoT9qDOZ/AzgW+pbruxnNaZdyAVZb7VC+VZ7YsmfHqcrFo7pG1DlkU3Yja7irecyoCZgN+dkUcOPERaW7aapLgTZt5rHHoOU4y+4gxC5S35F9tIybUXQQ3rcRXBpg6+1zjLV8yoA1kLT+A7ReYkyX2RD1+JeGs+FN/Wkt6VH9W2JaG6m715DOZ8ogPFuchOfeYUrnQesyxBJG4vKRw0leNRTU10TWpTGFtVdLzB8/iqL1OQNDSkuaCMcF00TNsu5oI7YE0uC5UbCqhCnMFB5eTSNMzZgouMXrB+dd5vGuPQQysXW3JUpncj6ezB1vosnut9LOPJtOAIk0MEYcrgTtiMz9cLqVMgKqvfJAIlgoT3e7JMrtZoGUm4T6ZfOWcDHbLtsoUieJBmVlTKAnjjsYs/l8Vc2dP35C1qDLmkqIy+eTzaajl5/WGMImyhM7UernpeEuHNM09vR9et3rK3glona8Vuw/+Y+cRye66ECaPP8J9hEsFUXKFtq02PDUVXzc+w2MQrtirQLhSqyF0AQE7JtEwFx2x7VOjD9mksarcCjotycoraYH6dLy8Hmgr7AQB7jEY3PgO9J//p5KAXuRXBfgx/fPOP6fT5oihLATyG5yVZs8dDOB71MZtzXLM7z5azzMkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YaP9qYWVfIVOLvFKqTVk6SMFNN3sstrDgH+rLNaNRKeWRuMm9HqEwMcfPqtJ?=
 =?us-ascii?Q?HvxY0a7lwg8mr2yQm/Tppk7TV1mqM1yWrD1VqdjpwCo1gTVDilFKqnhIxdS7?=
 =?us-ascii?Q?hUoOdmoXIcsHHD7CxLDwMrVwGbj9Q5rE+8sv38QGm7slWcYLebos29SIEiwt?=
 =?us-ascii?Q?Os+Y0ptLWGKfP0rCK9HE8pxobVEtJGVVQ5j/wj+dTW/vj62HfMuBRb7K+um4?=
 =?us-ascii?Q?Y4PGho18Y3bLuro0Umw+DWewYKWua+TskRwIdpKZzTf2N+Ljc2dFLea67tkk?=
 =?us-ascii?Q?+GbW6S0lp+TYWzvslPeKalRMRHdgGmBu5XT0bjgh0kP34LDSLwaSRPBG/+8/?=
 =?us-ascii?Q?2ZZtmXPuJloDwUjWEWnSNo3QUb/IPFFXfY4n3PV5uLGiw51xRz3kaOIlJFDB?=
 =?us-ascii?Q?C2NJ8mEUa5e6gTU4P7Gw7qCNuuH9Lrse0ctuV19cztBFnXoa+PbE67bfLfTT?=
 =?us-ascii?Q?aFt1wJqSKpjNq49nH6OtkxbtUXreBkmaN2gsLcQpDhRmGlbW075SpDk8jxEG?=
 =?us-ascii?Q?Z7LJjrzWN0ICdyefPf1o9UiaSXzj6eBMSGj42XzgvGL4P0sv30sanxvOhg54?=
 =?us-ascii?Q?jvicSYGpC66NzcOVaEJ8JjZMrzVg69h+dFJe4VtSXg9RxxL62u/53VIPgs5x?=
 =?us-ascii?Q?cJxLBjnBDAdJhzRm/0L2rCdkV65Fg9vFnTm8WnSjihvLW3TFn5u/q1xpk3ot?=
 =?us-ascii?Q?/B4/t/K2lR4mEsXnNaFjRvIJURFp57IpIeVD0/OzkA+8tzNOEoYC41ZxNkmE?=
 =?us-ascii?Q?PYluYkKrH2HEdkzpYSzptPdL75sHyiUukyt9NduqHv6pEgapYht3losGjAiO?=
 =?us-ascii?Q?r4iceAgzi3iZ/SAyMFLBhp4dKu32AvdS05yoVp1aBD9w5d9kIGlhksCxfoy6?=
 =?us-ascii?Q?2r7GGs6Zhveq4KCe5iO4u1Tds5+pAY6zgcsewtWq2iaPeU3f3IiqSYWcM9/D?=
 =?us-ascii?Q?jZCOLzNKlaFkvOhSMwHzq8SFvXMxxnFYgclsBmepQcVssncVQe0plq0J0XWc?=
 =?us-ascii?Q?gaN0cttZW+Rb2IM8HFHv+FLTQ+8Zj25RK/q2y+Iv0wMWm/LYWrJeHYf5SE4A?=
 =?us-ascii?Q?O0bqUkKj0wP22sFSO9Dakf7j9MhCGwugGkHoWWqchI7QxcDYyALrk569bKDC?=
 =?us-ascii?Q?Bk0MgT2M0hlSDhE3FnoajOVXTg9a1XqOSeuNtd8a9alh8bMzLdwalUfSJGyR?=
 =?us-ascii?Q?yJl7jdTTrb2ABXVbacTzeLCbSHF0ZY15MiVwbtlFFjCFgGzQ3+LNsw0GU3OR?=
 =?us-ascii?Q?DbDBCsS6iz3hboojoHnsb6xuiv0JMDv3ACvTWDr1cwalFnysHNggIBs+DI8u?=
 =?us-ascii?Q?7TyFe1EWAdamkX0M831m9qK+yw492eAvaAlTGhueRHUOjvgc51M4AtZGT4oW?=
 =?us-ascii?Q?+fruKkita1DRZ6qrwtVO6aHOSyztDMGXtZAzrzbfDQvdaVh5yKjgAFLnl72s?=
 =?us-ascii?Q?WfH8ebTtC5xeLl0Mf/vZv9H73dcxatg5Cy6JLII4c8AQGREXj7r5XDryeRqD?=
 =?us-ascii?Q?JAGtwQT6QlHWUxOG7C/t9vDBd1EoIEPyozwYzj//tr1dfmFRm0ATw9NWabBT?=
 =?us-ascii?Q?QDoqSdhRATj3DjCubhz6Vi+5aoDesQAPE+TWMdgzE4JC+gu1MB4EzoDzbPXd?=
 =?us-ascii?Q?F9jYAHWxjGfc5jM91GetD6pDNh61O62kYkC6gHRbhKtaUVeoMk8LdCb3BJ97?=
 =?us-ascii?Q?L3O3ZyoNmksXgw1glOkiSSdYkBs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123e21e8-8aed-4bdc-d6a2-08def84ced7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 08:37:21.8882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOGRZA7DiqAtmTLEZxGlclB6wtroVPr8Kr3xsA4nbhvoWaZ7kO7YBsbF96SPoPWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, August 12, 2026 4:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Li, Candice <Candice=
.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Disable runtime PM for externally attached dGP=
Us

pci_is_thunderbolt_attached() requires an upstream PCI bridge with is_thund=
erbolt set from an Intel Thunderbolt VSEC. This does not cover the affected=
 ASM4242 USB4 PCI hierarchy:

  00:02.2
    \- 0f:00.0 [1b21:2421]
       +- 10:01.0 [1b21:2423] -> 45:00.0 -> 46:00.0
       |  -> 47:00.0 -> 48:00.0 -> 49:00.0 [1002:7590]
       \- 10:03.0 -> 76:00.0 [1b21:2425] USB4 Host Router

The host router is outside the GPU upstream bridge chain, leaving no ancest=
or with is_thunderbolt set. PCI core propagates DEVICE_REMOVABLE below the =
external-facing PCIe tunnel. Disable Runtime PM when either
pci_is_thunderbolt_attached() or dev_is_removable() is true.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 8ebe24d59ab6..a4b4f9645c84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -609,6 +609,13 @@ void amdgpu_device_detect_runtime_pm_mode(struct amdgp=
u_device *adev)
        int bamaco_support;

        adev->pm.rpm_mode =3D AMDGPU_RUNPM_NONE;
+       if (pci_is_thunderbolt_attached(adev->pdev) ||
+           dev_is_removable(&adev->pdev->dev)) {
+               dev_info(adev->dev,
+                        "Runtime PM disabled for externally attached devic=
e\n");
+               return;
+       }
+
        bamaco_support =3D amdgpu_device_supports_baco(adev);

        switch (amdgpu_runtime_pm) {
--
2.54.0

