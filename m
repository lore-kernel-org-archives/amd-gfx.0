Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B55CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 05:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 396EE10F8B4;
	Fri, 29 May 2026 05:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g8dAb6T7";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBAB10F8B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 05:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8MD5X88jggne+MhST6I1PtHooEL0klEV713eIZg2VQ/17KS82LHwu8J5jpNizLhEiILQMe7THNQ4TRMQ3Xf1wDAFmsiI5PBrhhMnxOWgyBTLD+egh8MS1l4qX9bruwFGJWpphRt/Yp8gZ4iZ8FPkaj6Ddw3Tfv1Q1rIUjHt3HjjycRAGLOQ/l7DxqifNGDdkrCxABQ7vOdlZnScnwf873e4+ajierrSumIwL3JXLoh8CHN9ttDQW5rXeGVOU+gOXJc3NDnFi6rJJ1rlNztiUwK3Evk9yV8lEkkSV2wUy0PpIMWKJodAGUXMLSDcRgqV6eDilgMv0YKqQIVWdeVBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sih2VS6bGyeWbcNbFBdQIdaNrdQZPutG5Z9BUn5rHgE=;
 b=pKYJALTO4bdc258rOOFDzw4N5G1J/aHGJB7FqJEASNaTkMT6THqOjY+QQq2Q+K2ftJ7JUL99c5yMfb7GAqL++5ZS91CSSAmLbc5Td0ZFef9vp835LTeJ8uD+LPk0pZaCLi70UN0qrs62hN1CaPEvOU75mgB8RyP/G7agZK+N+JDrepAfQwh9yg/dXnYvHh9sqWn1g9FRFLiGuCbLnorb3rSynIqg8jFf9SYl3s8jZisrrTLF19vBaoIHc1ZpFYzgz0DEvFQGnSPV4TKEuEbvPY8kdHG4Rs8xmbOWXSfsRnGOYGNjhbWazac0ljih3aPA4cWUciz/pXP2ruvhAbOLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sih2VS6bGyeWbcNbFBdQIdaNrdQZPutG5Z9BUn5rHgE=;
 b=g8dAb6T7h5xNuPygtiXXHVoUwZBb23hUN4RbHdsp5wZiVGL14DakenVQPWAGKwXZeQdnxhvrc1txrXkRVjgtcRYfbW4bCFPWZfL2eLfDU/U8TozdTM26McBGPr5z+ZMmeFhg9yOsZe/0bLJJBjev7dub2JLZbUv/6ZRH7hcSlf4=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Fri, 29 May 2026 05:18:30 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 05:18:30 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: set energy_accumulator to UINT_MAX for smu
 14.0.2
Thread-Topic: [PATCH] drm/amd/pm: set energy_accumulator to UINT_MAX for smu
 14.0.2
Thread-Index: AQHc7x5VPobazXb0S0OY5d41enbW4bYkbjuAgAAIlsA=
Date: Fri, 29 May 2026 05:18:30 +0000
Message-ID: <DM6PR12MB29720D96C3AE3E9CF2FA21B682162@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260529035013.1389055-1-kevinyang.wang@amd.com>
 <CH0PR12MB502707D73150EA4BB19851A98E162@CH0PR12MB5027.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB502707D73150EA4BB19851A98E162@CH0PR12MB5027.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T04:46:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|IA1PR12MB6018:EE_
x-ms-office365-filtering-correlation-id: fb9b29ef-8d1f-4e2f-2b59-08debd41b8b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: 94WbyryHRXzQdeTE7YLtaFzyDW1TCaoJMWFf5ytPotyPwljvjIYvLArfaQaq8sioy0zkJGtINiomGpoH+lqZitUVmKsyzITEvYrkRjaTyYQ5Z5BhBdhiIm+kYH4cyoXF+aPn/sYZw/65OIJBoQUxx7cF8KOJ/6+Gwd3q1Moz0p3sFhje3+FIrhTM6rci/6/cLryWVFXnLG1LjGniqzECAqbxheFJiQ/2kv1WxBMGmpWPaE0fqDRyWrgVXOejYmfw55CVlJzKLRzf+gGXaEpGZ/hcDAuMqxtDKx2u4Cl0c3ygree0BLVoWVXK8oO8u97soHhdKA9QnGMgZ1cPFduhpbTj99uq6TKY+3RbjtsMC2PEpNXNea2bF/hqizR/n82QLgg8M/EVx7Lb80hyuBkeA0+Y2FbW5bHdSRli/bnkc/YHyIga8G2MI/XxYFJBxMiiYdvKDRnVpx0JGo7R8sDt8zl2sCEubagsBiKBC2DsYGJpDos14+pZhcEcvj2JZl44I8TXAnbzQ1CbPw47s7Q7Cl+JvOUre2Oatm7NsRxmqmp98bS9bNWwUup+SE9e0g5GcErUuOmi5ZwGR0vtuj8NcFAF8o06kRQyLjCdNc5busJWMcs7BZQdJfML0R9a+X7sl4RTNRgMqTzzpXwySTo7qtLNyP/CJi4U1QLuvvptGOu0WEVb88I5x3KEuaGCIzRXGaVEbmcIm0TFp5LeuJd7x8dvip/x+qIIshMr9MP3QMnwfOd21bX1RwQaAP5ezzmq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RgqoYi6UWRckwBd4XOvS7w7NAmW24FOXiqxn79dqIxk+j1OMx9+kT9Z3pGIe?=
 =?us-ascii?Q?K9JJz28qTG0HYflNSgzffoL85/RtQsHUl5bpuHtZzZix1N9ZUtSxThYi19dI?=
 =?us-ascii?Q?+XXp9HZ/0tmQSxde8nQmZPE4wNGKpVY363qrkUhHKYIAcDr/ojB0Do+Fccbk?=
 =?us-ascii?Q?OFHqkY5ecXR+D6lxGTxFe3k4dZTj2owPjJIY8ckolacEc8cqpPWAvcBKKynz?=
 =?us-ascii?Q?2gtAcS3tkgl9qmdee0LGxwH5hpG5agQ+I8Qh+zLXVSJZY4p9j0HieuGLu8un?=
 =?us-ascii?Q?jgbawizx+tsoP6BZBVmPuFBR0UZZaqsUTj9dyi1aG/qT4SKOtGMmVXsn4qv3?=
 =?us-ascii?Q?xZE/CodTPqeKumpDgzocMnRfe44cCCOO2GauOdcXsmxwXa2CS1I/nbUqZlfV?=
 =?us-ascii?Q?QVh13oBj21QbD1qnMgGeI3wkzKVOwsRWknh4hRyrKdNNwMTRcBsnCierb4E6?=
 =?us-ascii?Q?u8Nc9xVrPXVKAfRZ0bT80GaO2GMgH2+YaQtKJQSKz9Y7+3Z+JbceP6X3p3Lo?=
 =?us-ascii?Q?t9D1vcMqYbZFQuPDdhEQohpNrb099wPi/WLqf5CsoPm/yUd/G1K8wjZIuBif?=
 =?us-ascii?Q?/D+BQp5UTCWLngytyvjfjQFVN0vLd9+HPQom0yL/cNsWKDo+6Jbo9hOAdcTk?=
 =?us-ascii?Q?sX+PJhhJ9EU4wloshbgxjTeViJrQ5Jli5GoSpcwTs7TP1HiJwu4BJpEi5xA1?=
 =?us-ascii?Q?Zocgq8WfCtV+Xg6yGNbvHZJxOX74sgoW8E6l0r+UFFrO3pSYcrIekuOQiHBY?=
 =?us-ascii?Q?4+0YgfIvvO8vtoGAND7Bz+W72T8FWEuP0ct8BUsX63cHpUlTx692CPmCGkl7?=
 =?us-ascii?Q?MJBGAwQnfbkH7w9fkHGsJ6rmwEsJbIhzPbZ6Fp/s2IY1TDEHT/xCq6sWeM7L?=
 =?us-ascii?Q?mUSjBmKmc5jBC+Z312xCidbr3G91BCHV66DZGwYKmzEGk/Dbtsn8FmT34j8w?=
 =?us-ascii?Q?7ffv7AMokVvU7OhL9nNXkYFJwUhEzdlsSHZevVzQ7psYokdxvH3NnK89cQv5?=
 =?us-ascii?Q?F+nCS2yJt00qV9BjFNCrMsVlNwZKnzR9QsPsCSIaw1eqAo+2ccobfsN/B+ah?=
 =?us-ascii?Q?biNWnGsHoyCvklBI1MwQuUbRGpVUesboy3NyQ7DIs8kFie5sUHhOpjmQAL1Y?=
 =?us-ascii?Q?WBYyZetVr9fgxlp1FoIIu7gTHM7oRj+x96+yzgmGafqyi5n59So3EKKGq9TU?=
 =?us-ascii?Q?zMxY8bvVNWUQIgVjTHjEvAOIt46/IoS1Q73Tjih9Sv6cUFb+KTrVSCbwqglP?=
 =?us-ascii?Q?bzJDv7FDVW8ajXDvMGINiPp7eVvjKKr5n7wHoaAeRajUAm+EgX0jG+LVf9U3?=
 =?us-ascii?Q?AWUbVxRoazvEcTx2OyRimz6WxOZrnmj763PbuIRt9iYQLtSpz/aH7oe9RqPY?=
 =?us-ascii?Q?VJfo9mggcTEECelXWpFaOFRd2Wph9YZtIaPIIWM5xSwkvrEEfwNOfri0hV81?=
 =?us-ascii?Q?v8bIp9hxxPBjFdM2tK88V5b/5mGe5tB2Tr8FNCdaNjYPCiSXqMJ7e0Cf916V?=
 =?us-ascii?Q?CJlErfYgrfsWQFihFCESJIr0nLRbZBfF2ffcDtViyLlyWc9ZZ+KtvKR3KQ+2?=
 =?us-ascii?Q?Pwz1UYtfzb/p36/Y2DDlUvdnYMwK8oxKZ11VSBcbvRgmw1vmYzA+pNGjpPqT?=
 =?us-ascii?Q?AQtpyo2AZZudcvjGMbD8/wNakA11gGxOf8uxk1dxKHLsQiTfp/tAvpjajju7?=
 =?us-ascii?Q?BxOnAs75tKGZfgfw4oxF447wO/1O+o5oYWku2MBVgaxI8pnB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9b29ef-8d1f-4e2f-2b59-08debd41b8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 05:18:30.2361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdR0B2MKE/CtRolSyWOSZRnVts012Itmr4/5jtX5it8bXs/pghFe+A0f61Cgs+ht
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 12:47
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: set energy_accumulator to UINT_MAX for s=
mu
> 14.0.2
>
> AMD General
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang W=
ang
> Sent: Friday, May 29, 2026 9:20 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: set energy_accumulator to UINT_MAX for smu
> 14.0.2
>
> EnergyAccumulator is unsupported on SMU 14.0.2, mark it invalid.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 6b5aa4e514fd..f98b8e045db2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2153,7 +2153,7 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct
> smu_context *smu,
>                                                metrics->Vcn1ActivityPerce=
ntage);
>
>         gpu_metrics->average_socket_power =3D metrics->AverageSocketPower=
;
> -       gpu_metrics->energy_accumulator =3D metrics->EnergyAccumulator;
> +       gpu_metrics->energy_accumulator =3D UINT_MAX;
>  If we just skip the assignment, it will be already assigned to 0xFF .
>
> Thanks
> Asad

Yes, update in v2.

Best Regards,
Kevin
>         if (metrics->AverageGfxActivity <=3D SMU_14_0_2_BUSY_THRESHOLD)
>                 gpu_metrics->average_gfxclk_frequency =3D metrics-
> >AverageGfxclkFrequencyPostDs;
> --
> 2.47.3
>

