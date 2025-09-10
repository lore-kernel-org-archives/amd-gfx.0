Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641E7CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC0610E8F0;
	Wed, 10 Sep 2025 11:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jGWbO3tD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C5210E8F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anpNqYe7tN6uT9Ys9s4cTABSgZwGIhQk4UieWHPFQ71EpYRBJh/RGckZisZYdhj+BCa6nInT9QKDBo+lAzq+uo7Gh2PiDxuCp2X0ih9YRfzqGEVlMhyWUYxO+NfPb4yEXkFo1VqAtyC7GT+SsY6ZawXnuuTQv+/QjBg5mLFoL1+/Lixj0tPnJLP1gNK6RNSpFRI+CM2RLNEh0nm14t4UkOUMTb/S5pgiSa53JFvZ+EiKiuAddcipnLrhvMtt5B3SbD866T9tmMBle/TldTNiO+79+imj9q8IXts71sxhAMUQO+XNtNjddjj/e6V5DicUbvbNc0PMxUcmkd9jpiR16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz17ty5J//F4P2gBEDPs/t9Kx3anKgAztfdeXNAfaZA=;
 b=dlz7D8fK//vA8KruXxwelny5jfcJl3Ny/fjp3bJdkkH14zhsCax+QmoUKZqk4rgzc8XGD4ZDdrMkTDYUPa16z63r9vaFadohPz+NS5EszJyf+GQ/UJNZ3w/CvBeg17e4O7LKBjYxaql/0YKhvSZYq+12IKH39WaK/1uUp/J/WsBrbKk5AIuQIEUfsHTb6KHCE7QIjLGOf1wCW3dZBXHc9EGMQKGvgQTp2FkDasCDnVPFzupSc1mfDzc1k7L7ace5UtI8nxbQwIppo1Ce4742EP83f/Vlk7pmf4FL7VKOoaMzYPzoj2Sv1KPTMkW2mbwuDEevBlOtZDV9elVae6R/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz17ty5J//F4P2gBEDPs/t9Kx3anKgAztfdeXNAfaZA=;
 b=jGWbO3tDbNkV+Ao5NExl2aosfU7nB6vXF4KcD4HkRUr03ZjbmLcKroUI20udkoD3oxPSdZw7hCPdnwbqf8StcFhNRbc6fWhvR0BAlF9U9uYN9RoPrR3zt0YYn70OAVlr1LaxufJvMyFm+m/0P7ayXC9GMN2KfJ7Rf07hkxTABcI=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 11:40:46 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 11:40:46 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH v3 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v1.9
Thread-Topic: [PATCH v3 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v1.9
Thread-Index: AQHcIU2edMrOAfU0kkeT8RlaSCpdurSLtskAgACVDOA=
Date: Wed, 10 Sep 2025 11:40:45 +0000
Message-ID: <DS0PR12MB7804EC0898F02CD7EDA687B4970EA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250909054933.2911159-1-lijo.lazar@amd.com>
 <20250909054933.2911159-2-lijo.lazar@amd.com>
 <PH7PR12MB59970D21801A6A191C451CE6820EA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59970D21801A6A191C451CE6820EA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-10T11:37:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DS7PR12MB6189:EE_
x-ms-office365-filtering-correlation-id: 7572cac4-eeac-4656-da7d-08ddf05ee1a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JMknZUz/NXoBGZFvHmJWj0KytzmY+DjcNYhrWLJ3HdwPF6isPkASRb21ZxHP?=
 =?us-ascii?Q?Uatg0DB6y/VPLx0swQotYoc4RdXlyyZz1+IwzSTyxaa8kmMfEMbjPPx7gG/r?=
 =?us-ascii?Q?ktzcEEPj+zBsyhUYhxGp60JD99ez/2z4hQ3aZLgcRld9zZiCg2Oc92n6u2m5?=
 =?us-ascii?Q?GsTF4zYs9DkNkFazL+FX72xztsAjes4+RH+mYxWdxf1rKYKfBZ2+7Zxt96tq?=
 =?us-ascii?Q?P7x5mrgry8dfE1UU6Eq5iet7WPCe+XLmHYNHcY8XdAoDB/eLh5vIIm4wihU/?=
 =?us-ascii?Q?uj1Xc1Paw2lGmWqzPS5nuzj8+9iUtHuHqeoOxZK/dal5S+uyT1Z7rSutKIQW?=
 =?us-ascii?Q?JFFudYFdSSKgan4LVTR0sHZBlHDeeTMTrR0S3ckIOTRwJptDEAeMr3KPTjLh?=
 =?us-ascii?Q?3E53R/sbP7azSN0apFLT/X1xEyUo2K14K2pN7vsiKWuT7sX5ydKtw7/l1tSS?=
 =?us-ascii?Q?f87sl3cW90XmP/WA3pTjUxaMivrjs8Z1iK9t3N+8tl2VOJCc9GWDKclzqM1i?=
 =?us-ascii?Q?rngILdubYpzoRNuooTChFYohuA9Bt5O3VJc50bAc3CtXCyFXPns/wleAORq0?=
 =?us-ascii?Q?YSAwfbMN+vKox0wy6p2qPuqKNleiXwcRNsondsYX/eVBYSon/Cng6fB23hBe?=
 =?us-ascii?Q?MKZn/ANjSvXZcpzkKqAMTPwYlb03b1jc5NA6CFIKVKwnnligKbbiQzSj8cET?=
 =?us-ascii?Q?alooKwuFvd2rpFrv6+H2a2wmOjPrU1GrS06plE+tvWOHh6txz3FOS8qadLV5?=
 =?us-ascii?Q?SF0/QWOCr1mo0TgBaXxJgMRyr1TqdTj6ZriGWeu8q/n9CctFw6A/IkH1X5uO?=
 =?us-ascii?Q?u8kiqSFWsbPrwmbzEUlrKUkLBkAckUXtY32y5zVrrT1p3v5WZvjp8riA2hjN?=
 =?us-ascii?Q?p34rYgiM0v0dnJGwG6u8jgDYmg8NxmTM7Lc1FbaRd5l4okBgoAlOAFrmsHb9?=
 =?us-ascii?Q?a5kdRIDqIOmwOlqvoRShZ/pPEFwaI0erB9yc4Q4PVAEOONQR5wEBnw0CA+0U?=
 =?us-ascii?Q?iky+awSR0BbG68yJjORlkXiMmGy3raHPNZZgxoouIDcr41iOekGat4A15mVP?=
 =?us-ascii?Q?+Kn0eDAW2blEQbBzeKmhGv8o+Y7p/ROYnmNDuugxyz8sBopbmUxs9myA//jl?=
 =?us-ascii?Q?KylSL5JEJ4IdQoSzGlS990Z2rbVwZdhbgMndliyd3BodEWVD4DApcvRR7IyP?=
 =?us-ascii?Q?hvm3RlnKbd8ddjCpE5RqfOBj+Bv5CJpFZkn1hOPYiuAHXT3XP864DlpT4ixs?=
 =?us-ascii?Q?wUou7hjhAiXtW/OPoGwG2oYu2Du12aHPfymf+aKsvLrJm/SfVJ4JSnECqO8X?=
 =?us-ascii?Q?okMm1dM6Y8jiyaFxH3AS/CYvBzYsH28CC9lSlS4FNJ9XvAx46ldKxqPhnpUd?=
 =?us-ascii?Q?+X8E8dFkpWNMSLnrORwVbStOi/4txL8Tku028VDm3le53NTe4m1hMqEbycJR?=
 =?us-ascii?Q?YR0vFL0Mgd2FnwMMCSJf+DlGkgMcufwmTshUNauRJMJpcjRBa7XwFJcmnntn?=
 =?us-ascii?Q?QMcFE0QvrnTOoLc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ab23Ylzrv/bvHCj0AdQggwRKhNqcdrh3hJsLpwdiRc+T9gLcb5OQIJEly3Ak?=
 =?us-ascii?Q?hQVvMeRkXXHICKFYqojZ7ERGPJQmoF8+3TXpRb4KVLrO9kzMNG4e4pzTo+nz?=
 =?us-ascii?Q?r+Qbff1c+gjBVnpF+g7kOmKWl0rNNkj4cc0xq7uP7xRoZ1IPG4ENKoAS5HP3?=
 =?us-ascii?Q?5GOyaAQg23D911d/dqlUVsPj6m7b5KQv6RTMlXPnd4iFMEFmqG2gHPM8t56h?=
 =?us-ascii?Q?78XIcarxl1+MxuF8f4TTJo8kO3JSK+CXJ3ICRiz6LTrAFAgiZVFbs6yop+W7?=
 =?us-ascii?Q?Iq7yL5+jAkjB4dOsuNHDQv5VUFggbqHUVm6fRxJsxIKjML+WKWbQpXM6h0jX?=
 =?us-ascii?Q?gyQjOPoa6xCWsUaA9Gf3m0qWDwaEfMLucJBLMoL9ME2SAUQ0I9GgWvQXSzfh?=
 =?us-ascii?Q?+tnfOK5pfvx7x31ibs4k+w6qMNnbb2qB568CNpghdqy8EZTm/Wudxo6kSRQ0?=
 =?us-ascii?Q?/egR3lEHGr1L61+HrPJ6C1OQH3YIwx0CWndmdfSNB4pZKL7XNDPPWcUrxd8r?=
 =?us-ascii?Q?7cejwzP51d9xL49RxcmPu1Z9gc+MRNY0FmJwB4W2UmSyBQiZTzhjcrhnSXiN?=
 =?us-ascii?Q?/RLgU1mwG5h9FC4rzinjxe8p5EXPOWKxq/pLCgRANT4nmOwRukZwiKKQKvMu?=
 =?us-ascii?Q?UIf/4ETgtWlkEKNtZ4v+ivtfN4M1Z7Eu24q3PAS6g/OshqMp/886W5u3hoEj?=
 =?us-ascii?Q?6vDJo7PRFZf2hIjQ8GUMm8PT3qM6Cc+PoV4WJ4T/TZ77VU067PrsPjV0YgzN?=
 =?us-ascii?Q?QeG6p/Rq1JL94tln6xU8OGiaNqN0fPMxtN0vVNfs8XsafN8tzTJLPOcjnuAK?=
 =?us-ascii?Q?NtGitiRPYV5BeFp1qijLMNFYa3fCXHujzVef4V6UX4uBl/gTrwmlv9qx94PR?=
 =?us-ascii?Q?h9RYi2QwfAbvjq7t9JNTFnoiMERiVIRMKpE5ojX+/GiQMR2ph0Jt+m+pVzK/?=
 =?us-ascii?Q?W7Tmwg7daT0jp1qYrA1G/qNGK5Qyo5BggDxODcQ/RnMPHsdM6dNKGj65u+lg?=
 =?us-ascii?Q?nqsRrMa0JzbT4+HmzxLN6KMtEMUvwEeGSRSIA4su3F0a2f6U2xCHhn/m+VIQ?=
 =?us-ascii?Q?rjTLFlF3pKxIeM+WddtJ6QlXeuwCB0dU7cHvnr+4h/7xv63rhHf8Ax0OahRS?=
 =?us-ascii?Q?VkSeZuQC0zSsimnWpdnbdzXoG1F1dS0x2kDx3jBQ7K6Nl6unHE8zzBSvOywB?=
 =?us-ascii?Q?Orbfx/WDsPV9l007G7HrqxIFaG6Y07GPZt9UOTFSItgd0EXtFd7Jlo8A8KUl?=
 =?us-ascii?Q?OKoU5b+HuagiwA5Cq1HgVv8i4lfXNG++L7dcb0QIgwmvKnsHulL51e/7S4Pu?=
 =?us-ascii?Q?NGJRNTNHpiJpQCHtr151wde/cfpCsaZIxcTFsv9LCXjJC7P33IESv0nP1+cr?=
 =?us-ascii?Q?vo3YcWkyId2T3XQyQHh+hjc+TnObucKNEWUJUcErDd1wIK0sL+oiFuQiplOo?=
 =?us-ascii?Q?4fnDnunc/PVar27+x5o2d6HigHMLyNdk2jo0F1tCPfFoq+kFwtAH3SUMUVqJ?=
 =?us-ascii?Q?2FXd8baDBnnlQJu2RbkEsmJo9o70OXAUcZhOPCqNW3uLMKfU1h9bKhGZWBGr?=
 =?us-ascii?Q?5iVrS3RbikZxioInN4k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7572cac4-eeac-4656-da7d-08ddf05ee1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 11:40:45.9462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RF9al3FMZY/1J/5xFERg0pvv8BnFCYdftXxfIYvP8TGT2Ir7OWcb7lmjhCxLnF7o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

[Public]

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, September 10, 2025 8:14 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: RE: [PATCH v3 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v=
1.9

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, September 9, 2025 13:48
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH v3 1/7] drm/amdgpu/pm: Add definition for gpu_metrics v1.9

Add gpu metrics definition which is only a set of gpu metrics attributes. A=
 field is encoded by its id, type and number of instances.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2: Add unit field and change encoding to 64-bit.
v3: Fix unit encoding

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 2f7e4b5bebf3..5538c7c671d3 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -528,6 +528,110 @@ struct metrics_table_header {
        uint8_t                         content_revision;
 };

+enum amdgpu_metrics_attr_id {
+       AMDGPU_METRICS_ATTR_TEMPERATURE_HOTSPOT,
+       AMDGPU_METRICS_ATTR_TEMPERATURE_MEM,
+       AMDGPU_METRICS_ATTR_TEMPERATURE_VRSOC,
+       AMDGPU_METRICS_ATTR_CURR_SOCKET_POWER,
+       AMDGPU_METRICS_ATTR_AVERAGE_GFX_ACTIVITY,
+       AMDGPU_METRICS_ATTR_AVERAGE_UMC_ACTIVITY,
+       AMDGPU_METRICS_ATTR_MEM_MAX_BANDWIDTH,
+       AMDGPU_METRICS_ATTR_ENERGY_ACCUMULATOR,
+       AMDGPU_METRICS_ATTR_SYSTEM_CLOCK_COUNTER,
+       AMDGPU_METRICS_ATTR_ACCUMULATION_COUNTER,
+       AMDGPU_METRICS_ATTR_PROCHOT_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_PPT_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_SOCKET_THM_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_VR_THM_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_HBM_THM_RESIDENCY_ACC,
+       AMDGPU_METRICS_ATTR_GFXCLK_LOCK_STATUS,
+       AMDGPU_METRICS_ATTR_PCIE_LINK_WIDTH,
+       AMDGPU_METRICS_ATTR_PCIE_LINK_SPEED,
+       AMDGPU_METRICS_ATTR_XGMI_LINK_WIDTH,
+       AMDGPU_METRICS_ATTR_XGMI_LINK_SPEED,
+       AMDGPU_METRICS_ATTR_GFX_ACTIVITY_ACC,
+       AMDGPU_METRICS_ATTR_MEM_ACTIVITY_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_BANDWIDTH_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_BANDWIDTH_INST,
+       AMDGPU_METRICS_ATTR_PCIE_L0_TO_RECOV_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_REPLAY_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_REPLAY_ROVER_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_NAK_SENT_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_PCIE_NAK_RCVD_COUNT_ACC,
+       AMDGPU_METRICS_ATTR_XGMI_READ_DATA_ACC,
+       AMDGPU_METRICS_ATTR_XGMI_WRITE_DATA_ACC,
+       AMDGPU_METRICS_ATTR_XGMI_LINK_STATUS,
+       AMDGPU_METRICS_ATTR_FIRMWARE_TIMESTAMP,
+       AMDGPU_METRICS_ATTR_CURRENT_GFXCLK,
+       AMDGPU_METRICS_ATTR_CURRENT_SOCCLK,
+       AMDGPU_METRICS_ATTR_CURRENT_VCLK0,
+       AMDGPU_METRICS_ATTR_CURRENT_DCLK0,
+       AMDGPU_METRICS_ATTR_CURRENT_UCLK,
+       AMDGPU_METRICS_ATTR_NUM_PARTITION,
+       AMDGPU_METRICS_ATTR_PCIE_LC_PERF_OTHER_END_RECOVERY,
+       AMDGPU_METRICS_ATTR_GFX_BUSY_INST,
+       AMDGPU_METRICS_ATTR_JPEG_BUSY,
+       AMDGPU_METRICS_ATTR_VCN_BUSY,
+       AMDGPU_METRICS_ATTR_GFX_BUSY_ACC,
+       AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_PPT_ACC,
+       AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_THM_ACC,
+       AMDGPU_METRICS_ATTR_GFX_LOW_UTILIZATION_ACC,
+       AMDGPU_METRICS_ATTR_GFX_BELOW_HOST_LIMIT_TOTAL_ACC,
+       AMDGPU_METRICS_ATTR_MAX,
+};

[kevin]:
How about modify the name prefix to "AMDGPU_METRICS_ID" or "AMDGPU_METRICS_=
ATTR_ID" ?
+
+enum amdgpu_metrics_attr_type {
+       AMDGPU_METRICS_TYPE_U8,
+       AMDGPU_METRICS_TYPE_S8,
+       AMDGPU_METRICS_TYPE_U16,
+       AMDGPU_METRICS_TYPE_S16,
+       AMDGPU_METRICS_TYPE_U32,
+       AMDGPU_METRICS_TYPE_S32,
+       AMDGPU_METRICS_TYPE_U64,
+       AMDGPU_METRICS_TYPE_S64,
+       AMDGPU_METRICS_TYPE_MAX,
+};
+
+enum amdgpu_metrics_attr_unit {
+       /* None */
+       AMDGPU_METRICS_UNIT_NONE,
+       /* MHz*/
+       AMDGPU_METRICS_UNIT_CLOCK_1,
+       /* Degree Celsius*/
+       AMDGPU_METRICS_UNIT_TEMP_1,
+       /* Watts*/
+       AMDGPU_METRICS_UNIT_POWER_1,
+       /* In nanoseconds*/
+       AMDGPU_METRICS_UNIT_TIME_1,
+       /* In 10 nanoseconds*/
+       AMDGPU_METRICS_UNIT_TIME_2,
+       /* Speed in GT/s */
+       AMDGPU_METRICS_UNIT_SPEED_1,
+       /* Speed in 0.1 GT/s */
+       AMDGPU_METRICS_UNIT_SPEED_2,
+       /* Bandwidth GB/s */
+       AMDGPU_METRICS_UNIT_BW_1,
+       /* Data in KB */
+       AMDGPU_METRICS_UNIT_DATA_1,
+       /* Percentage */
+       AMDGPU_METRICS_UNIT_PERCENT,
+       AMDGPU_METRICS_UNIT_MAX,
+};
+
+#define AMDGPU_METRICS_ATTR_UNIT_MASK 0xFF000000 #define
+AMDGPU_METRICS_ATTR_UNIT_SHIFT 24 #define AMDGPU_METRICS_ATTR_TYPE_MASK
+0x00F00000 #define AMDGPU_METRICS_ATTR_TYPE_SHIFT 20 #define
+AMDGPU_METRICS_ATTR_ID_MASK 0x000FFC00 #define
+AMDGPU_METRICS_ATTR_ID_SHIFT 10 #define AMDGPU_METRICS_ATTR_INST_MASK
+0x000003FF #define AMDGPU_METRICS_ATTR_INST_SHIFT 0
+
+#define AMDGPU_METRICS_ENC_ATTR(unit, type, id, inst)      \
+       (((u64)(unit) << AMDGPU_METRICS_ATTR_UNIT_SHIFT) | \
+        ((u64)(type) << AMDGPU_METRICS_ATTR_TYPE_SHIFT) | \
+        ((u64)(id) << AMDGPU_METRICS_ATTR_ID_SHIFT) | (inst))
+
 /*
  * gpu_metrics_v1_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v1_1 or later instead.
@@ -1217,6 +1321,19 @@ struct gpu_metrics_v1_8 {
        uint32_t                        pcie_lc_perf_other_end_recovery;
 };

+struct gpu_metrics_attr {
+       /* Field type encoded with AMDGPU_METRICS_ENC_ATTR */
+       uint64_t attr_encoding;
+       /* Attribute value, depends on attr_encoding */
+       void *attr_value;
+};
[kevin]:

I think the "void *" is not good idea to export data as an interface, and t=
his pointer width is dependent on OS/CPU width (4 bytes on 32bit system but=
 8 bytes on 64bit system )?
so, it is better to change it to uint64_t type.

[lijo]
The void* indicates that the encoding is followed by a field of variable le=
ngth based on the encoding. Void* itself doesn't constitute a field. User s=
pace has to read the attribute encoding to determine the size of the field =
that follows. For ex: if encoding uses AMDGPU_METRICS_ATTR_CURRENT_GFXCLK a=
s id, instance =3D 8 and data type =3D  AMDGPU_METRICS_TYPE_U32, that means=
 the value following the encoding needs to be read that way.


Best Regards,
Kevin
+
+struct gpu_metrics_v1_9 {
+       struct metrics_table_header common_header;
+       int attr_count;
+       struct gpu_metrics_attr metrics_attrs[]; };
+
 /*
  * gpu_metrics_v2_0 is not recommended as it's not naturally aligned.
  * Use gpu_metrics_v2_1 or later instead.
--
2.49.0


