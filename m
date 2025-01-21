Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C50C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 05:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0BD10E068;
	Tue, 21 Jan 2025 05:43:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="02KtPa9L";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D152B10E068
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 05:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zF3+6DcUADDXyZ4B6poovF76N2hQivYKWfvM2wREAqLxDKnTIVtVkfjh4vSEJH/Zg/QJyhsXrG0jCltue/5rkiCctypHJZ9+1rFM1SJyMw7YlcpeKOuIC+PemvTnXcUGd8yVnsLsKlYmS2yKa1DR7G5VYvfjpJdUepDCQfBLIFs/4lihIra3CJ1lZTXg7s+Zjsk6mCi1jbggb0PnPoow+Bf6EmmZy8mBbwpd5JtBgIBhHe+pde8CyrL014QVlpQM5jtPEoTgOxKoeIoqAc8PmC+rWAFgrAsDDyLLmB5gFQPUr8DNXbNlSVsPNXPSHsVhE6VfBEBTQd2/rG0SsA9LSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoFAQcHEebkV3g4J8dTbFwSGFYeLnarrafnYRyE6OxU=;
 b=E3E702z/Ss+32abb6hIh9ZLghmNi/t8mk6hhMWSbP1ID8s8N5lZy1WYRlKIg2q3xL2sDs6OVW40uqNvgyAi+ujftEOMDyLTG6jH0AskeUJRaY++gFt09+0t7NSgPP/0psc9LwntFYvy3/h+edtft6XjsKc+YKQeg29KSSee8Aa4ggSysY6U/txxuRDFqDqKG6Vv9TpnF1+9SxEe5dnvykYD8Mh6AWOIeropVGY1AGP4TfwPIUB/KFZU2cRxjOWyl9izg3O4I3R6i3ALomQRY/NqJNrWvNEUtKaH+hCa/GBIcuVLkj+AqDqgdKca9SaJb3Rd2F9OEyeOudEqcjdo4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoFAQcHEebkV3g4J8dTbFwSGFYeLnarrafnYRyE6OxU=;
 b=02KtPa9LLBp8lNC+w2PBqU/wX4BVhkxP6QvYoNVxqljrJRCRI8ni2yjlv4QgXKL3q377ZlotvBjFdJxS7s4scLEQG95niR+1DKWqDrC3jqsfTEvrASlCWqKgp0DOY0TKjzbesj2dW3djAD830BNK5/C51xcs7pVFDBNPg3aOxN8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 05:43:33 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 05:43:32 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3] drm/amd/pm: Fix smu v13.0.6 caps initialization
Thread-Topic: [PATCH v3] drm/amd/pm: Fix smu v13.0.6 caps initialization
Thread-Index: AQHba8bk5d+/Bwgv2UiFj7H98yveQLMgtzEA
Date: Tue, 21 Jan 2025 05:43:32 +0000
Message-ID: <PH7PR12MB5997794AE9DC8E88B0F205E082E62@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250121053929.1538914-1-lijo.lazar@amd.com>
In-Reply-To: <20250121053929.1538914-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=48b4040b-3cce-4c22-8708-aa0cd4b153f9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-21T05:43:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN6PR12MB8469:EE_
x-ms-office365-filtering-correlation-id: cddd5d96-bc25-4ad6-a2ce-08dd39de8ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9nQLpWhvlLSUNg5OrYmPDdJGQuB/0ZXESvxBKtsrjxeOr/Dz3r1vWXEFsFWn?=
 =?us-ascii?Q?g1pNp6plStbQN/rB8l23YHPoR1PWeVeUbjkML6O8D1+bUG5lAgFqGmxlsGJY?=
 =?us-ascii?Q?IvZWrXcXTOCezE6H603dUKOHDg6WVNZ2tOULJ1hmdvWzbwM2MMLcZRBWfTtp?=
 =?us-ascii?Q?KO8F9oE8fcfjkDDh2y+QHDhF801F8vdsGsuHTJc8RpCbN5h2yyRGW4qnwuSC?=
 =?us-ascii?Q?s9yik1dlBSbeJXGNeKMoKFfeIr7nZrlowMZJznmgzv0PfH1i422P3Uw2l7sV?=
 =?us-ascii?Q?l4Kw8Ro8qIwvsF14pHyt/un1DtzcezsgTwy+leKstcFNpetkUfdJCdyUqj6d?=
 =?us-ascii?Q?1rnOx7bs5lnhcuP/WjlmEro8m33xTPIjKc/k1QES+eA/bbZpsB0ER+uzId9l?=
 =?us-ascii?Q?tXWZr+Gi0lFPq/SBmGAyj94wgPby9QMc6kvWNYCFBcuUiaZwsldbJ6RlwQtx?=
 =?us-ascii?Q?J3bjinVeech1pPjcd9e2zYfkqZ1O7DpU+V8V0Z3s/29sKgCFOr3oLoGT2nC2?=
 =?us-ascii?Q?usgBxG0+gFulBYqZopw2x3nrD3XsoiU/G0OIIx8eLe7gODFAdoMQ94HkjKtE?=
 =?us-ascii?Q?hRE3tlrn22RZEFXxZzwYW4bmcOd4RhJ/psYcWjvKj52/nhNUaGKS9+QaeCQw?=
 =?us-ascii?Q?a9WvtRrZ1cwVem6m6wJufuc2sSM9h/+x6DSxYjtJcAeUspQhwLqZH7rqQhIy?=
 =?us-ascii?Q?qQ+pwjGvO/TQ/Cteix1xi7dLAbsiQPet2xETeNvi6BtYSKpvsT5zwZxAEHLy?=
 =?us-ascii?Q?5u1EIa2xS1QpcVwJQ5hTTsEHIPc1qT5ZHOluqUSMgr8LLx7P8vCK6XOyyhEK?=
 =?us-ascii?Q?sF7GpEmM0lzw0cwdN1bU7yDu09CpMBC952GzTr9bL3WnSn02H2gDzrXuIyfc?=
 =?us-ascii?Q?n5my84KzRMShLufw0BtW6JbSTcmOV5QyA5UQB/QE2UWJv1rXumPRadSdeccT?=
 =?us-ascii?Q?e1CeOvw3TgC1iOWlk14eRwba+fmM8RClF19yC7r3RV47/+yHno7XdEUZnu5H?=
 =?us-ascii?Q?ZEVlCMcw25oz7nmWsnk7m9wCswvb5dSE09ImFdZrkIrZE5ex11F8i+W7DNWg?=
 =?us-ascii?Q?RU/TyUE4vCSYgUlZjLelFo7/cuj67D/shIsDn31hK3Nnk2xzjegoJgP9r1Hf?=
 =?us-ascii?Q?oFcWsDxVk4ubMx64KfxFdqxM7kSJiOvKA684VD98DUZxb0+t7xfIhiw92DGm?=
 =?us-ascii?Q?/0YtokHteud4YnAGkQYiVrNrRpl2UTwEf3sqffeTPliXuePrvKeHUh0HQVA7?=
 =?us-ascii?Q?y50SHFDaDbN52ywSsS+iS1Xt7uKQsYI2dndJ1wv/PNHjXiYPjLsuIMYZiJEO?=
 =?us-ascii?Q?WbyNvv6Ag5WgFwv8XK88oeDO476PLDKp0H8METHgyhWE2RArkhh+DY75pFPj?=
 =?us-ascii?Q?2kac7WHvk/Hl6R3CL+EGqlE+2F3AnocIiIMpRfiJbFeTkE4U/5flbdZC8NkR?=
 =?us-ascii?Q?Wra3exTAxcpZhKoXQJmqWXLGjZT8bjwm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R4cXuDOCyqUmVwW/+7KZ+JDngl7SAd/5dsdKzchQaP6e8ZNXrliLPAUwP6rs?=
 =?us-ascii?Q?tHdNMKbsa15mjtaR1h6kAiDR5CzX4QGf4REUk67zoN5HrkDbOBGSYCnAbphX?=
 =?us-ascii?Q?fMrfLWb+gsFaG5d9BuvfLePKfcsg/2qcmWBYDKjoysJr1bmN+hhYI1VupH/E?=
 =?us-ascii?Q?RMbPTlUMfhe4iP0a5BIH7oOMaWg+TgLYItAvv/9jnd53yhVlMaiCBo/9W02P?=
 =?us-ascii?Q?jF/dQnRGziCsdfLIIF77vvfvU5wc23ZwYEin2FmZ8vy3XHmMP/3sQWl2+wWL?=
 =?us-ascii?Q?61+PB40NM74aF+CnNNyDN3GKRNtscHaFVaIv8Fc49LNVQ/8uOa+g1kBXy1yO?=
 =?us-ascii?Q?G2S+g6Pk1asbKPMPyJE6eDRKZLf9rFbCo7Wxl6wfBG81pB6p6KazCnGCqpB4?=
 =?us-ascii?Q?P+mq+Zrq0qHbhTGviRAGL3I+kR+BxeOohLH3ysP+++HJlhx6/WeHmRiBda5q?=
 =?us-ascii?Q?/0ubj9Fc4oB1BeOtovZftdtwmVCUykEVDtIGwfoCsgpj6yUDvJ0ClIdvAXA7?=
 =?us-ascii?Q?+vgCGoLjxeYbr2I3LzBf+YT4kZlOehiSSK9/sWH4lchEegXis+k2w+8j93/f?=
 =?us-ascii?Q?8qLpqTJOz8WlDDy7PF24XRyFHTYt/7Zrtst8AaepnXfs7e7JOyyK9mGGbC+B?=
 =?us-ascii?Q?u8sDCyy+ODAAqd+jjcZP6hFxe/BcbfqdOvtzyGBb0Cii1Ez5aGzTIvx+BwUk?=
 =?us-ascii?Q?7HNTmrdkWHN5JI1QzQ7cLKf6FJ7HDomeBxiJ9mP7OKym0jPtWcCkaPaLjb2i?=
 =?us-ascii?Q?jSymju/YoW8uZ5MnofDegdPZORhjkbsrRqQdOz9oM4WZVQxPGUq9GtTMe57a?=
 =?us-ascii?Q?utEbg70nG3nbtzC4xhtE9SXc5R01raonjCElOExISOk1fghLdbnkSItme8Op?=
 =?us-ascii?Q?70cn9DMtvENrmj4nbvTxJNChnhykYtWuiaL9zvzavi8IFxaJARcnYN00cYhM?=
 =?us-ascii?Q?gE3c+dx5XthmmL2uRq6FfmlUamijI2cPCGd3GKREy9pn978ZZmDtU5xkxXHR?=
 =?us-ascii?Q?ZOwtpcZPB4INH+Li0Lk4CIIlN5ALGYXMh4f16CHZsFg9vMNfY45pXm/m0YjK?=
 =?us-ascii?Q?BXDVrsXR/AZLhACwj/is00FDyxokyevt8p5lWsQPscVpxXZixetAwZWiHXbW?=
 =?us-ascii?Q?sfsTHSHj8dzAweTfIAxtIFvMMSKkkGO4PQoxyvvYimyAQtrmeEj/H+2cZ68Y?=
 =?us-ascii?Q?YaTKpkYwjIfv67cxkeio0zoA7GoZxlDpqOqsz5VKav+cevi6W5MXRM76SHJr?=
 =?us-ascii?Q?rpIpNWUnNLUGqtIr1j6J2xtKYQHauU881WcBVho2da6SArCa8d/qATCvlIcZ?=
 =?us-ascii?Q?q0UUKuw2dlqNjZSaenNpVPBJvz5Df01JtUUzpApJ9vlKdQr1NNbJinwoETBc?=
 =?us-ascii?Q?lggvru7FqTfvqnJ3gBNVmhsKSJzTcJVSqRZDIqoaTZfFg7RJizML8YBf5BK4?=
 =?us-ascii?Q?4hMoy55RWNEfcft9eb/CCmEJeQjc3vqIyE2yIjXPUU5XHjOcD4WoK14Aac1D?=
 =?us-ascii?Q?mGWZQGzQDZT3P2v2/HIs6kQ5LmrDrb+Tf/XaWk4rf2WzqMH3KE3n3KLeyiKp?=
 =?us-ascii?Q?UCWLkgGd3GaLnDUpwr8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd5d96-bc25-4ad6-a2ce-08dd39de8ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 05:43:32.8196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRoEcbdUjvJ3BWXmZatZQYSo3bfYNxKb7DD4IH16Xwni9ZwtA+eI6cXCqqVPXtTC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, January 21, 2025 13:39
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH v3] drm/amd/pm: Fix smu v13.0.6 caps initialization

Fix the initialization and usage of SMU v13.0.6 capability values. Use caps=
_set/clear functions to set/clear capability.

Also, fix SET_UCLK_MAX capability on APUs, it is supported on APUs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Fixes: 9bb53d2ce109 ("drm/amd/pm: Add capability flags for SMU v13.0.6")
---
v1: ("drm/amd/pm: Use correct macros for smu caps")
v2:
        Use caps_set/clear instead of macros (Alex). Commit message changed=
.
        Use BIT_ULL (Kevin)
        Fix SET_UCLK_MAX capability on APUs
v3:
        Rename to cap to indicate operations on single capability (Alex)
        Use SMU_CAP in enum value definition also for consistency

 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 197 ++++++++++--------
 1 file changed, 108 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 56e26fcd3066..d991a5df3796 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -101,26 +101,25 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 #define MCA_BANK_IPID(_ip, _hwid, _type) \
        [AMDGPU_MCA_IP_##_ip] =3D { .hwid =3D _hwid, .mcatype =3D _type, }

+#define SMU_CAP(x) SMU_13_0_6_CAPS_##x
+
 enum smu_v13_0_6_caps {
-       SMU_13_0_6_CAPS_DPM,
-       SMU_13_0_6_CAPS_UNI_METRICS,
-       SMU_13_0_6_CAPS_DPM_POLICY,
-       SMU_13_0_6_CAPS_OTHER_END_METRICS,
-       SMU_13_0_6_CAPS_SET_UCLK_MAX,
-       SMU_13_0_6_CAPS_PCIE_METRICS,
-       SMU_13_0_6_CAPS_HST_LIMIT_METRICS,
-       SMU_13_0_6_CAPS_MCA_DEBUG_MODE,
-       SMU_13_0_6_CAPS_PER_INST_METRICS,
-       SMU_13_0_6_CAPS_CTF_LIMIT,
-       SMU_13_0_6_CAPS_RMA_MSG,
-       SMU_13_0_6_CAPS_ACA_SYND,
-       SMU_13_0_6_CAPS_SDMA_RESET,
-       SMU_13_0_6_CAPS_ALL,
+       SMU_CAP(DPM),
+       SMU_CAP(UNI_METRICS),
+       SMU_CAP(DPM_POLICY),
+       SMU_CAP(OTHER_END_METRICS),
+       SMU_CAP(SET_UCLK_MAX),
+       SMU_CAP(PCIE_METRICS),
+       SMU_CAP(HST_LIMIT_METRICS),
+       SMU_CAP(MCA_DEBUG_MODE),
+       SMU_CAP(PER_INST_METRICS),
+       SMU_CAP(CTF_LIMIT),
+       SMU_CAP(RMA_MSG),
+       SMU_CAP(ACA_SYND),
+       SMU_CAP(SDMA_RESET),
+       SMU_CAP(ALL),
 };

-#define SMU_CAPS_MASK(x) (ULL(1) << x)
-#define SMU_CAPS(x) SMU_CAPS_MASK(SMU_13_0_6_CAPS_##x)
-
 struct mca_bank_ipid {
        enum amdgpu_mca_ip ip;
        uint16_t hwid;
@@ -284,95 +283,116 @@ struct smu_v13_0_6_dpm_map {
        uint32_t *freq_table;
 };

-static void smu_v13_0_14_init_caps(struct smu_context *smu)
+static inline void smu_v13_0_6_cap_set(struct smu_context *smu,
+                                      enum smu_v13_0_6_caps cap)
+{
+       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+
+       dpm_context->caps |=3D BIT_ULL(cap);
+}
+
+static inline void smu_v13_0_6_cap_clear(struct smu_context *smu,
+                                        enum smu_v13_0_6_caps cap)
 {
        struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
-       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(CTF_LIMIT) |
-                       SMU_CAPS(MCA_DEBUG_MODE) | SMU_CAPS(RMA_MSG) |
-                       SMU_CAPS(ACA_SYND);
+
+       dpm_context->caps &=3D ~BIT_ULL(cap);
+}
+
+static inline bool smu_v13_0_6_cap_supported(struct smu_context *smu,
+                                            enum smu_v13_0_6_caps cap)
+{
+       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+
+       return !!(dpm_context->caps & BIT_ULL(cap)); }
+
+static void smu_v13_0_14_init_caps(struct smu_context *smu) {
+       enum smu_v13_0_6_caps default_cap_list[] =3D { SMU_CAP(DPM),
+                                                    SMU_CAP(UNI_METRICS),
+                                                    SMU_CAP(SET_UCLK_MAX),
+                                                    SMU_CAP(DPM_POLICY),
+                                                    SMU_CAP(PCIE_METRICS),
+                                                    SMU_CAP(CTF_LIMIT),
+                                                    SMU_CAP(MCA_DEBUG_MODE=
),
+                                                    SMU_CAP(RMA_MSG),
+                                                    SMU_CAP(ACA_SYND) };
        uint32_t fw_ver =3D smu->smc_fw_version;

+       for (int i =3D 0; i < ARRAY_SIZE(default_cap_list); i++)
+               smu_v13_0_6_cap_set(smu, default_cap_list[i]);
+
        if (fw_ver >=3D 0x05550E00)
-               caps |=3D SMU_CAPS(OTHER_END_METRICS);
+               smu_v13_0_6_cap_set(smu, SMU_CAP(OTHER_END_METRICS));
        if (fw_ver >=3D 0x05551000)
-               caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+               smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
        if (fw_ver >=3D 0x05550B00)
-               caps |=3D SMU_CAPS(PER_INST_METRICS);
+               smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS));
        if (fw_ver > 0x05550f00)
-               caps |=3D SMU_CAPS(SDMA_RESET);
-
-       dpm_context->caps =3D caps;
+               smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 }

 static void smu_v13_0_6_init_caps(struct smu_context *smu)  {
-       uint64_t caps =3D SMU_CAPS(DPM) | SMU_CAPS(UNI_METRICS) |
-                       SMU_CAPS(SET_UCLK_MAX) | SMU_CAPS(DPM_POLICY) |
-                       SMU_CAPS(PCIE_METRICS) | SMU_CAPS(MCA_DEBUG_MODE) |
-                       SMU_CAPS(CTF_LIMIT) | SMU_CAPS(RMA_MSG) |
-                       SMU_CAPS(ACA_SYND);
-       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
+       enum smu_v13_0_6_caps default_cap_list[] =3D { SMU_CAP(DPM),
+                                                    SMU_CAP(UNI_METRICS),
+                                                    SMU_CAP(SET_UCLK_MAX),
+                                                    SMU_CAP(DPM_POLICY),
+                                                    SMU_CAP(PCIE_METRICS),
+                                                    SMU_CAP(CTF_LIMIT),
+                                                    SMU_CAP(MCA_DEBUG_MODE=
),
+                                                    SMU_CAP(RMA_MSG),
+                                                    SMU_CAP(ACA_SYND) };
        struct amdgpu_device *adev =3D smu->adev;
        uint32_t fw_ver =3D smu->smc_fw_version;
        uint32_t pgm =3D (fw_ver >> 24) & 0xFF;

+       for (int i =3D 0; i < ARRAY_SIZE(default_cap_list); i++)
+               smu_v13_0_6_cap_set(smu, default_cap_list[i]);
        if (fw_ver < 0x552F00)
-               caps &=3D ~SMU_CAPS(DPM);
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM));

        if (adev->flags & AMD_IS_APU) {
-               caps &=3D ~SMU_CAPS(PCIE_METRICS);
-               caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
-               caps &=3D ~SMU_CAPS(DPM_POLICY);
-               caps &=3D ~SMU_CAPS(RMA_MSG);
-               caps &=3D ~SMU_CAPS(ACA_SYND);
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(PCIE_METRICS));
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM_POLICY));
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
+               smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));

                if (fw_ver <=3D 0x4556900)
-                       caps &=3D ~SMU_CAPS(UNI_METRICS);
-
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(UNI_METRICS));
                if (fw_ver >=3D 0x04556F00)
-                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS)=
);
                if (fw_ver >=3D 0x04556A00)
-                       caps |=3D SMU_CAPS(PER_INST_METRICS);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS))=
;
                if (fw_ver < 0x554500)
-                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(CTF_LIMIT));
        } else {
                if (fw_ver >=3D 0x557600)
-                       caps |=3D SMU_CAPS(OTHER_END_METRICS);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(OTHER_END_METRICS)=
);
                if (fw_ver < 0x00556000)
-                       caps &=3D ~SMU_CAPS(DPM_POLICY);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(DPM_POLICY));
                if (amdgpu_sriov_vf(adev) && (fw_ver < 0x556600))
-                       caps &=3D ~SMU_CAPS(SET_UCLK_MAX);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(SET_UCLK_MAX));
                if (fw_ver < 0x556300)
-                       caps &=3D ~SMU_CAPS(PCIE_METRICS);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(PCIE_METRICS));
                if (fw_ver < 0x554800)
-                       caps &=3D ~SMU_CAPS(MCA_DEBUG_MODE);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(MCA_DEBUG_MODE))=
;
                if (fw_ver >=3D 0x556F00)
-                       caps |=3D SMU_CAPS(PER_INST_METRICS);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(PER_INST_METRICS))=
;
                if (fw_ver < 0x554500)
-                       caps &=3D ~SMU_CAPS(CTF_LIMIT);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(CTF_LIMIT));
                if (fw_ver < 0x00555a00)
-                       caps &=3D ~SMU_CAPS(RMA_MSG);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(RMA_MSG));
                if (fw_ver < 0x00555600)
-                       caps &=3D ~SMU_CAPS(ACA_SYND);
+                       smu_v13_0_6_cap_clear(smu, SMU_CAP(ACA_SYND));
                if (pgm =3D=3D 0 && fw_ver >=3D 0x557900)
-                       caps |=3D SMU_CAPS(HST_LIMIT_METRICS);
+                       smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS)=
);
        }
        if (((pgm =3D=3D 7) && (fw_ver > 0x07550700)) ||
            ((pgm =3D=3D 0) && (fw_ver > 0x00557700)) ||
            ((pgm =3D=3D 4) && (fw_ver > 0x4556e6c)))
-               caps |=3D SMU_CAPS(SDMA_RESET);
-
-       dpm_context->caps =3D caps;
-}
-
-static inline bool smu_v13_0_6_caps_supported(struct smu_context *smu,
-                                             enum smu_v13_0_6_caps caps)
-{
-       struct smu_13_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
-
-       return (dpm_context->caps & SMU_CAPS_MASK(caps)) =3D=3D SMU_CAPS_MA=
SK(caps);
+               smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 }

 static void smu_v13_0_x_init_caps(struct smu_context *smu) @@ -716,7 +736,=
7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
        MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metric=
s_table;
        struct PPTable_t *pptable =3D
                (struct PPTable_t *)smu_table->driver_pptable;
-       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS=
));
+       bool flag =3D !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS))=
;
        int ret, i, retry =3D 100;
        uint32_t table_version;

@@ -912,7 +932,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu=
_context *smu)
        smu_v13_0_6_setup_driver_pptable(smu);

        /* DPM policy not supported in older firmwares */
-       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM_POLICY))) {
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM_POLICY))) {
                struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;

                smu_dpm->dpm_policies->policy_mask &=3D @@ -1089,7 +1109,7 =
@@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
        struct smu_table_context *smu_table =3D &smu->smu_table;
        MetricsTableX_t *metrics_x =3D (MetricsTableX_t *)smu_table->metric=
s_table;
        MetricsTableA_t *metrics_a =3D (MetricsTableA_t *)smu_table->metric=
s_table;
-       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS=
));
+       bool flag =3D !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS))=
;
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;
        int xcc_id;
@@ -1102,7 +1122,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct sm=
u_context *smu,
        switch (member) {
        case METRICS_CURR_GFXCLK:
        case METRICS_AVERAGE_GFXCLK:
-               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(DPM))) {
+               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM))) {
                        xcc_id =3D GET_INST(GC, 0);
                        *value =3D SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFreq=
uency, flag)[xcc_id]);
                } else {
@@ -1791,7 +1811,7 @@ static int smu_v13_0_6_notify_unload(struct smu_conte=
xt *smu)  static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu=
, bool enable)  {
        /* NOTE: this ClearMcaOnRead message is only supported for smu vers=
ion 85.72.0 or higher */
-       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(MCA_DEBUG_MODE)))
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(MCA_DEBUG_MODE)))
                return 0;

        return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,=
 @@ -1936,8 +1956,8 @@ static int smu_v13_0_6_set_soft_freq_limited_range(s=
truct smu_context *smu,
                        if (max =3D=3D pstate_table->uclk_pstate.curr.max)
                                return 0;
                        /* For VF, only allowed in FW versions 85.102 or gr=
eater */
-                       if (!smu_v13_0_6_caps_supported(smu,
-                                                       SMU_CAPS(SET_UCLK_M=
AX)))
+                       if (!smu_v13_0_6_cap_supported(smu,
+                                                      SMU_CAP(SET_UCLK_MAX=
)))
                                return -EOPNOTSUPP;
                        /* Only max clock limiting is allowed for UCLK */
                        ret =3D smu_v13_0_set_soft_freq_limited_range(
@@ -2141,7 +2161,7 @@ static int smu_v13_0_6_get_enabled_mask(struct smu_co=
ntext *smu,

        ret =3D smu_cmn_get_enabled_mask(smu, feature_mask);

-       if (ret =3D=3D -EIO && !smu_v13_0_6_caps_supported(smu, SMU_CAPS(DP=
M))) {
+       if (ret =3D=3D -EIO && !smu_v13_0_6_cap_supported(smu, SMU_CAP(DPM)=
)) {
                *feature_mask =3D 0;
                ret =3D 0;
        }
@@ -2437,7 +2457,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
        struct smu_table_context *smu_table =3D &smu->smu_table;
        struct gpu_metrics_v1_7 *gpu_metrics =3D
                (struct gpu_metrics_v1_7 *)smu_table->gpu_metrics_table;
-       bool flag =3D !smu_v13_0_6_caps_supported(smu, SMU_CAPS(UNI_METRICS=
));
+       bool flag =3D !smu_v13_0_6_cap_supported(smu, SMU_CAP(UNI_METRICS))=
;
        int ret =3D 0, xcc_id, inst, i, j, k, idx;
        struct amdgpu_device *adev =3D smu->adev;
        MetricsTableX_t *metrics_x;
@@ -2519,7 +2539,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
                 * table for both pf & one vf for smu version 85.99.0 or hi=
gher else report only
                 * for pf from registers
                 */
-               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(PCIE_METRICS))=
) {
+               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(PCIE_METRICS))) =
{
                        gpu_metrics->pcie_link_width =3D metrics_x->PCIeLin=
kWidth;
                        gpu_metrics->pcie_link_speed =3D
                                pcie_gen_to_speed(metrics_x->PCIeLinkSpeed)=
;
@@ -2548,8 +2568,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table
                                metrics_x->PCIeNAKSentCountAcc;
                gpu_metrics->pcie_nak_rcvd_count_acc =3D
                                metrics_x->PCIeNAKReceivedCountAcc;
-               if (smu_v13_0_6_caps_supported(smu,
-                                              SMU_CAPS(OTHER_END_METRICS))=
)
+               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(OTHER_END_METRIC=
S)))
                        gpu_metrics->pcie_lc_perf_other_end_recovery =3D
                                metrics_x->PCIeOtherEndRecoveryAcc;

@@ -2574,7 +2593,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table

        gpu_metrics->num_partition =3D adev->xcp_mgr->num_xcps;

-       per_inst =3D smu_v13_0_6_caps_supported(smu, SMU_CAPS(PER_INST_METR=
ICS));
+       per_inst =3D smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRIC=
S));

        for_each_xcp(adev->xcp_mgr, xcp, i) {
                amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask=
); @@ -2605,8 +2624,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct =
smu_context *smu, void **table
                                gpu_metrics->xcp_stats[i].gfx_busy_acc[idx]=
 =3D
                                        SMUQ10_ROUND(metrics_x->GfxBusyAcc[=
inst]);

-                               if (smu_v13_0_6_caps_supported(
-                                           smu, SMU_CAPS(HST_LIMIT_METRICS=
)))
+                               if (smu_v13_0_6_cap_supported(
+                                           smu, SMU_CAP(HST_LIMIT_METRICS)=
))
                                        gpu_metrics->xcp_stats[i].gfx_below=
_host_limit_acc[idx] =3D
                                                SMUQ10_ROUND(metrics_x->Gfx=
clkBelowHostLimitAcc
                                                                [inst]);
@@ -2714,7 +2733,7 @@ static int smu_v13_0_6_get_thermal_temperature_range(=
struct smu_context *smu,
                return -EINVAL;

        /*Check smu version, GetCtfLimit message only supported for smu ver=
sion 85.69 or higher */
-       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(CTF_LIMIT)))
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(CTF_LIMIT)))
                return 0;

        /* Get SOC Max operating temperature */ @@ -2819,7 +2838,7 @@ stati=
c int smu_v13_0_6_send_rma_reason(struct smu_context *smu)
        int ret;

        /* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and ab=
ove */
-       if (!smu_v13_0_6_caps_supported(smu, SMU_CAPS(RMA_MSG)))
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(RMA_MSG)))
                return 0;

        ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_RmaDueToBadPageThreshold,=
 NULL); @@ -2840,16 +2859,16 @@ static int smu_v13_0_6_reset_sdma(struct sm=
u_context *smu, uint32_t inst_mask)
        switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
        case IP_VERSION(13, 0, 6):
                if ((smu_program =3D=3D 7 || smu_program =3D=3D 0) &&
-                   smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
+                   smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
                        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                SMU_MSG_ResetSDMA, inst_mask, NULL);
                else if ((smu_program =3D=3D 4) &&
-                        smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESE=
T)))
+                        smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)=
))
                        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                      SMU_MSG_ResetSDMA2, inst_mask, NULL);
                break;
        case IP_VERSION(13, 0, 14):
-               if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(SDMA_RESET)))
+               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(SDMA_RESET)))
                        ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                      SMU_MSG_ResetSDMA2, inst_mask, NULL);
                break;
@@ -3175,7 +3194,7 @@ static bool mca_smu_bank_is_valid(const struct mca_ra=
s_info *mca_ras, struct amd
        if (instlo !=3D 0x03b30400)
                return false;

-       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND))) {
+       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND))) {
                errcode =3D MCA_REG__SYND__ERRORINFORMATION(entry->regs[MCA=
_REG_IDX_SYND]);
                errcode &=3D 0xff;
        } else {
@@ -3464,7 +3483,7 @@ static int aca_smu_parse_error_code(struct amdgpu_dev=
ice *adev, struct aca_bank
        struct smu_context *smu =3D adev->powerplay.pp_handle;
        int error_code;

-       if (smu_v13_0_6_caps_supported(smu, SMU_CAPS(ACA_SYND)))
+       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND)))
                error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank->regs[A=
CA_REG_IDX_SYND]);
        else
                error_code =3D ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_RE=
G_IDX_STATUS]);
--
2.25.1

