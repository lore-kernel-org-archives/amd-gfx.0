Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7999C53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 09:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681D510E029;
	Wed, 29 Jul 2026 09:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AKQGQerB";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A106C10E029
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 09:55:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfoBQOsahcPI/BLszn7XuIqW1zI10HICPNoS9WFIR/J3AVwoTFvEC4wdGaMluPytQfSEXxLOKNZai2+pDBZw2qyml6Kp54RJJ3B9ij0tw8OOgABfDbqX9NOoYNQujwNTLfUPD9RFz+XYo2aNCdJbqA3m1wiHptCsyeTS2+yF4eNMmrRsRRCbdVjIGeUbgxQfnHCzcYb+WQF1l070uX2aVM6czpEIcs36nR6s+vBcqltyGIYBDobUpt/nlo5npoYor2qNS5ByqrCjHcEXz7uiES52/4Nl+gz0a2nRV48vOAjx4I6B44rk5iThtbDJhfycQisIFHp8mIPny3SQA71KeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTVtooUmgWimU0EZuINuMoLmJp0tyrm7We6GJySwOfo=;
 b=BEm8rIKp9VDz2Idz97yYdE6t//PBRQdvfxb6C6ZXxrhy/PlvcoBvNTnPqVl1U8Q0Kz45B0fK85PlvNALIFGbdlKld/JW9Z4mDYAkld1HuBswzYXoJCbbrjtvTJmbyHztjPbbz6BmH3q7TzEk/8Xrlpock0r6iY2ISixLlO4D5g91gi+IHF52e4b4nIWuXp8o/3Lv7sRDGLznRbxEjKB3s0mnJlgVkFK0u1/cpSGMQuHia0XvM5bKZbLXhhMI3G4AdL0G0fT+BYeYDo70ScLZjwU1dnwh0tslRbQGCCfz8iuO0+7FAunwYEl0hypj3LuvS3UYKXJyA4uzHL2uPswtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTVtooUmgWimU0EZuINuMoLmJp0tyrm7We6GJySwOfo=;
 b=AKQGQerBif0gIAY549YDm6F+7PJGV3PTtaVn+TAuB/6/yPIajGGmzuBmDOIDCKAoFO7wzteUmwKzg15fHojctwyT0VfbaOezLTGsEN65yjY6sfBUy17kz/NFjjnQxuu2klbG/n6aMLB9KTvMzWrEspDNr6254UhiD8o2hfGavHo=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 09:55:48 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 09:55:48 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Milind Sardeshpande, Shubhankar" <Shubhankar.MilindSardeshpande@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Vishwakarma, Pratik"
 <Pratik.Vishwakarma@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Milind Sardeshpande, Shubhankar" <Shubhankar.MilindSardeshpande@amd.com>, 
 "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>, 
 "Guttula, Suresh" <Suresh.Guttula@amd.com>, "Ramalingeswara Reddy, Kanala"
 <Kanala.RamalingeswaraReddy@amd.com>
Subject: RE: [PATCH V6 2/2] drm/amd/pm: fix SMU v15 metrics fetch, scaling,
 and sensor mapping
Thread-Topic: [PATCH V6 2/2] drm/amd/pm: fix SMU v15 metrics fetch, scaling,
 and sensor mapping
Thread-Index: AQHdHz5WuaINjOPTW0eOuTBdq9zp17aEQRTg
Date: Wed, 29 Jul 2026 09:55:48 +0000
Message-ID: <BN9PR12MB521192B6593D43D88C1F945C82CA2@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260729093928.2958771-1-Shubhankar.MilindSardeshpande@amd.com>
 <20260729093928.2958771-2-Shubhankar.MilindSardeshpande@amd.com>
In-Reply-To: <20260729093928.2958771-2-Shubhankar.MilindSardeshpande@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-29T09:51:10.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|MN2PR12MB4157:EE_
x-ms-office365-filtering-correlation-id: b088bd6f-813f-488c-df48-08deed5790db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|921020|38070700021|6133799003|4143699003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Uf4Fb8cINunZzE6bcdGl5cbB1U6VGOBFxcUyeVkUeoXfPFJUKmBkaowXdi04ooSBCBSh7X5wDCVXwIPLAPbjjuDcPvwJ9rBfQ+WWJpTlbkyYQRCA+i08molAvQnAMrbcjB+4Vxf34YOITVSz2Js6Zl/J/MUKjcbahSSqXdyokU2YmI5vC1qC04vuYI8LUWiP3vwz6OJEs74z09WoYo8Z5SwtSzh4NUBqAFP6XQRsdkQWSYjQlDYMtB/gArz9LifX/KqjQ9UPvcUoSeFHjpSgz5pKJ8CPLei682/ya4n0I/sY2a+fLQ/zW0A4RE9+jb7+0RPxdgulja4XDqR6PmbxcGPsClXUjAXhz2/Cjc9N9xj63Y2pS+L4tTPfjYRe9QOxQnzTRtlbuLa8PagvCNqtNT0SYg2MP31MuVcTE1GsGkbPDIX6u+mLIQwftpBSRYM7wW4xpvQV7iBGy/m3dzekNzzHG5ZEejY7UQlV9NXoCYsDcZf6/IsqMszK6OMF66hioZ/zfYQwJPkQZDh9ceMkG6ufcIs81q/x3YSiwp6CsmGhjeUmBJGQ/IlY2eBzeNULWdx3NLVffez7QfHNNWOJKWsIMcaUXhwiqzvcAxxUnernMndSW7jC67gL0dtwvQv8ReUplBGxpN4V9NouSEovvur0UDk6ukmSr51/loahlbqt6UtM6u162s4tmIRd9pJNO9MdLyvIdiHq3SpQWWbPIQewoHveFtFlBjOMrJ51CR8zXgyQM6Epi5mtH1u/WXp0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(921020)(38070700021)(6133799003)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aMNtQ5mjxXtsKUJK7yu1ClFDaisHja9qByVAdvlSKqUpVI+MwjL+QAixffvR?=
 =?us-ascii?Q?5V1Na3oAT/D/IRPtutbDUbr5vav5YIMRpyGV9ZW1geGB3eBLOhx/8cykGpOQ?=
 =?us-ascii?Q?SPdWcLnqpCG4kDzIUpxHCyE87+at/9f6sfWCBDOxwznJ+CWQgxBNzasC1E4a?=
 =?us-ascii?Q?DWLORX/KPuZ8R4kt0cJUGs1nle1mgnzzx0iRPBl0uZU+7Q8SsVU0q0GY3qog?=
 =?us-ascii?Q?pvGOtGmpP7zoA/BWvbGxdFIG4ZYVH2mlY60UNN5CW1XOEHTeYYgo183jP/+K?=
 =?us-ascii?Q?mPCklV5pzw7T0G6gU8iHnCTTIWbJW+lbvhNDEYAoDEbyRqYP0PBWTA7ZP6EB?=
 =?us-ascii?Q?qTBoCMwvlvL0dYge6nlaPZghg26QHuoLgHlegh3rSmkdCz4413/nli1GdOmW?=
 =?us-ascii?Q?Q3D4izrJVmsM2OpaDl3TeCbRDZQlVrWETyLFpbhwZFKzA2KU8/aEBumMK9gr?=
 =?us-ascii?Q?hDoZzzQe9cPz9dkKIXom2jcp4sxwr+Qdm1soC+lE/NEDIJueultHVVGxLYZc?=
 =?us-ascii?Q?5OKiOrK6E6u7BzKBYALF5yEjd8YHj/Gdu1JFj6KH0m0+AG+5t5AsjdCLPd2H?=
 =?us-ascii?Q?xrjFkoZHJGtf2ZhEjCksE7+xXPVM/FZrIBxsbiwSXZGdxSclF4NlZjs4ktDA?=
 =?us-ascii?Q?9Z33/vfZ5LJENhFl5JmVcsPSlFjwvPb0xt46d8SbbR43AyS6M8oteo0VBPcn?=
 =?us-ascii?Q?Xm9hZFw1xTGhTl3+3ChxYEX5BG1uACt02g9h82qdo6JC8Q2WKhIiVIsurTm7?=
 =?us-ascii?Q?lQhJz4VPiH8aPh0euODEQeJYIAcfXkTt4toZHzmU9eqqttfmmHzqzwISXXNZ?=
 =?us-ascii?Q?JuURAkVWs2vRMvTbBsD8EuZ40QjHxG+MSZ5LUKDDYhS5kxjRYhzB1BMTav/V?=
 =?us-ascii?Q?KRN3ZsxTvG615LPNx/EZsV0Vo4uZEixkt8iuY6mQcjnK2QjMO6voqSBzASfr?=
 =?us-ascii?Q?7r4wMvxpxcxn3PSXRpDclfRc6FaL+48+O8dlXKuosT5lvyOBG8WmQfopdDtf?=
 =?us-ascii?Q?H6zv962S8XGv2eejYbRDszyne09ioHITczkJYMfNf/g2fknuJ1j0QGwOJa2e?=
 =?us-ascii?Q?rPUkBL3R+YCqcZqkpwdJi/84VdfB8QcyKCGmio13eQYMX3RXgIdq01Ug63a0?=
 =?us-ascii?Q?7WSYrICdTSxD5Qm+ijet3Y7jJdGaLICM+eSDoE2haKVyanU+RKd0QElw8X7N?=
 =?us-ascii?Q?5OdbxTDZ80CamaLcgK+MyGMkKRLRRTWiUdOSOb0fuEp+B+p38ZEi7kITPfC6?=
 =?us-ascii?Q?fwWBU8zIEMyadVyEzTtM13iNHA9GIUDpLQh3DWiUdK3mIKJm33/EclGOW/Fi?=
 =?us-ascii?Q?lSLOlc6CziJ8M/b01Cw9AGwnPd8EVa8hDTfewsbmH+RcZ8yW0WW0jMeav48G?=
 =?us-ascii?Q?cJrTzinxEEpAIdoNUxRs9bxVy09o8jpxMf4xu08A0GI0WGJSt11rnnScRTUk?=
 =?us-ascii?Q?W2TCZ8mZndeug5H1fwUBflsG1P8fO2Jq6OH2Jp+cQ3QUJOBuyDLL2RpIzvVT?=
 =?us-ascii?Q?Q/YvTlGhqKpHtZUlF7mATRqrzBkjO5OekCac6PcgcI6hJrCA5M1hFRnjlNsJ?=
 =?us-ascii?Q?XX/yiKyUnBD7zPV7QoQqaxYBoCLjQEDDC57C3FaNlZB+7v8qouEXRA0EMXPe?=
 =?us-ascii?Q?JekGV3WghdESm40DEwG2HL6RgkebRS8DkNnYsOo1WQbVFynumYMgO29KBRIR?=
 =?us-ascii?Q?QrbcvquV8tIZcKOA1SEahLHlHMhP9hVleLUFrJa9M+NbWhcc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b088bd6f-813f-488c-df48-08deed5790db
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 09:55:48.1163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlycYoY3jLYlbEk04iAwCVcW07mGNDvZxAbpskmDHoLdqtksFndNTx6/E4i1nNGh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Shubhankar Milind Sardeshpande
> Sent: Wednesday, July 29, 2026 5:33 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Vishwakarma,
> Pratik <Pratik.Vishwakarma@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Milind Sardeshpande, Shubhankar
> <Shubhankar.MilindSardeshpande@amd.com>; Gopalakrishnan,
> Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Guttula,
> Suresh <Suresh.Guttula@amd.com>; Ramalingeswara Reddy, Kanala
> <Kanala.RamalingeswaraReddy@amd.com>
> Subject: [PATCH V6 2/2] drm/amd/pm: fix SMU v15 metrics fetch, scaling, a=
nd
> sensor mapping
>
> V6 fixes: Fix several issues in the SMU v15 metrics path that were trigge=
ring CI
> warnings and causing incorrect runtime metric values.
>
> Key fixes:
>
> -Always refresh the metrics table DRAM address during table init instead =
 of
> skipping when addr is non-zero.
> -Use memcpy_fromio() for copying the metrics table from MMIO/IO memory.
> -Store metrics_time after a successful table read to make cache-age check=
s
> consistent.
> -Use size_t for metrics table size to avoid type/size warnings.
> -Correct accumulator fixed-point conversions in
>  smu_v15_0_0_compute_all_metrics():
>  Use div64_u64() for the 64-bit average and div_u64() for  the final /102=
4
> descaling so division stays in kernel helpers  and avoids compiler-emitte=
d
> divdi3 linkage/build errors
>  clocks/activity: keep proper /1024 scaling
>  power: convert to milliwatts
>  temperature: convert to millidegree Celsius for hwmon/sysfs users
>  voltage: convert fixed-point volts to millivolts -Report GPU temperature=
 via
> AMDGPU_PP_SENSOR_GPU_TEMP and map it to the  correct metrics field
> (VRGFX temperature).
> -This aligns computed metrics with hwmon/sysfs units and removes CI/lint
> issues from improper IO copy and integer handling.
> -Bounds-check metrics member before array access.
>  smu_v15_0_0_get_smu_metrics_data() indexes the fixed-size  avg_metric[]
> array with a caller-supplied MetricsMember_t  reject out-of-range members
> with -EINVAL to prevent a  latent out-of-bounds access.
>
> drm/amd/pm/smu15: switch SMU v15.0.0 to DRAM-based accumulator
> metrics
>
> Replace the legacy SMU table-copy metrics path with a DRAM-mapped,
> accumulator-based approach for SMU v15.0.0, using a ping-pong buffer to
> compute averaged metrics from deltas between consecutive samples.
>
> - Add GetMetricsTableVersion, GetMetricsTableLogSample and
>   GetMetricsTableLogDramAddr messages and their MSG_MAP entries.
> - Introduce SMU_15_0_0_MetricsInfo_t holding two MetricsTable_t
>   buffers, the mapped DRAM address, table size and pre-computed
>   avg_metric[] values.
> - Resolve and ioremap_wc() the firmware log DRAM address once in
>   init_smc_tables(); iounmap() it in fini_smc_tables().
> - Fetch samples into the inactive buffer, compute averaged clocks,
>   activity, power and temperature via wrapping_sub() accumulator
>   deltas, then swap the active index.
> - Rename the old get_metrics_table() to get_gpu_metrics_table() for
>   the gpu_metrics v3.0 export path.
> - Smartshift sensor reporting is dropped
>
> Co-developed-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> Co-developed-by: Suresh Guttula <Suresh.Guttula@amd.com>
> Signed-off-by: Suresh Guttula <Suresh.Guttula@amd.com>
> Co-developed-by: Kanala Ramalingeswara Reddy
> <Kanala.RamalingeswaraReddy@amd.com>
> Signed-off-by: Kanala Ramalingeswara Reddy
> <Kanala.RamalingeswaraReddy@amd.com>
> Signed-off-by: Shubhankar Milind Sardeshpande
> <Shubhankar.MilindSardeshpande@amd.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h  |   5 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +
>  .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 312 +++++++++++-----
> --  .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h  |  13 +
>  4 files changed, 218 insertions(+), 115 deletions(-)
>
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
> index bf216f83e689..9f627b5fef5b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
> @@ -100,7 +100,10 @@
>  #define PPSMC_MSG_DisableLSdma                  0x1F ///< Disable LSDMA
>  #define PPSMC_MSG_SetSoftMaxVpe                 0x20 ///<
>  #define PPSMC_MSG_SetSoftMinVpe                 0x21 ///<
> -#define PPSMC_Message_Count                     0x22 ///< Total number o=
f
> PPSMC messages
> +#define PPSMC_MSG_GetMetricsTableVersion        0x22
> +#define PPSMC_MSG_GetMetricsTableLogSample      0x23
> +#define PPSMC_MSG_GetMetricsTableLogDramAddr    0x24
> +#define PPSMC_Message_Count                     0x25 ///< Total number o=
f
> PPSMC messages
>  /** @}*/
>
>  /**
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index acf03838d49d..d6675b4ee9be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -297,6 +297,9 @@
>       __SMU_DUMMY_MAP(GetSmartShiftStatus), \
>       __SMU_DUMMY_MAP(EnableLSdma), \
>       __SMU_DUMMY_MAP(DisableLSdma), \
> +     __SMU_DUMMY_MAP(GetMetricsTableVersion), \
> +     __SMU_DUMMY_MAP(GetMetricsTableLogSample), \
> +     __SMU_DUMMY_MAP(GetMetricsTableLogDramAddr), \
>       __SMU_DUMMY_MAP(InitializeGfx), \
>       __SMU_DUMMY_MAP(SetSoftMaxFclk), \
>       __SMU_DUMMY_MAP(SetSoftMaxGl2clk), \
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index 0da1ffb3a567..12fe2bc0488e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -33,6 +33,9 @@
>  #include "smu_v15_0_0_pmfw.h"
>  #include "smu_cmn.h"
>
> +#include <linux/overflow.h>
> +#include <linux/math64.h>
> +
>  /*
>   * DO NOT use these for err/warn/info/debug messages.
>   * Use dev_err, dev_warn, dev_info and dev_dbg instead.
> @@ -119,6 +122,9 @@ static struct cmn2asic_msg_mapping
> smu_v15_0_0_message_map[SMU_MSG_MAX_COUNT] =3D
>       MSG_MAP(DisableLSdma,                   PPSMC_MSG_DisableLSdma,
>                               1),
>       MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,
>                       1),
>       MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,
>                       1),
> +     MSG_MAP(GetMetricsTableVersion,
> PPSMC_MSG_GetMetricsTableVersion,             1),
> +     MSG_MAP(GetMetricsTableLogSample,
> PPSMC_MSG_GetMetricsTableLogSample,           1),
> +     MSG_MAP(GetMetricsTableLogDramAddr,
> PPSMC_MSG_GetMetricsTableLogDramAddr, 1),
>  };
>
>  static struct cmn2asic_mapping
> smu_v15_0_0_feature_mask_map[SMU_FEATURE_COUNT] =3D { @@ -160,10
> +166,37 @@ static struct cmn2asic_mapping
> smu_v15_0_0_table_map[SMU_TABLE_COUNT] =3D {
>       TAB_MAP_VALID(DPMCLOCKS),
>  };
>
> +static int smu_v15_0_0_get_metrics_table_dram_addr(struct smu_context
> *smu,
> +                                     SMU_15_0_0_MetricsInfo_t
> *metrics_info) {
> +     struct smu_msg_ctl *ctl =3D &smu->msg_ctl;
> +     struct smu_msg_args args =3D {
> +             .msg =3D SMU_MSG_GetMetricsTableLogDramAddr,
> +             .num_args =3D 0,
> +             .num_out_args =3D 3,
> +     };
> +     int ret;
> +
> +     ret =3D ctl->ops->send_msg(ctl, &args);
> +     if (ret)
> +             return ret;
> +
> +     metrics_info->addr =3D ((uint64_t)args.out_args[1] << 32) |
> args.out_args[0];
> +     metrics_info->table_size =3D args.out_args[2];
> +
> +     metrics_info->cpu_addr =3D ioremap_wc(metrics_info->addr,
> +                                         metrics_info->table_size);
> +     if (!metrics_info->cpu_addr)
> +             return -ENOMEM;
> +
> +     return 0;
> +}
> +
>  static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)  {
>       struct smu_table_context *smu_table =3D &smu->smu_table;
>       struct smu_table *tables =3D smu_table->tables;
> +     SMU_15_0_0_MetricsInfo_t *metrics_info;
>       int ret;
>
>       SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS,
> sizeof(Watermarks_t), @@ -173,7 +206,7 @@ static int
> smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>       SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
> sizeof(SmuMetrics_t),
>               PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>
> -     smu_table->metrics_table =3D kzalloc_obj(SmuMetrics_t);
> +     smu_table->metrics_table =3D kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
>       if (!smu_table->metrics_table)
>               goto err0_out;
>       smu_table->metrics_time =3D 0;
> @@ -192,8 +225,16 @@ static int smu_v15_0_0_init_smc_tables(struct
> smu_context *smu)
>       if (ret)
>               goto err3_out;
>
> +     metrics_info =3D (SMU_15_0_0_MetricsInfo_t *)smu_table-
> >metrics_table;
> +
> +     ret =3D smu_v15_0_0_get_metrics_table_dram_addr(smu,
> metrics_info);
> +     if (ret)
> +             goto err4_out;
> +
>       return 0;
>
> +err4_out:
> +     smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
>  err3_out:
>       kfree(smu_table->watermarks_table);
>  err2_out:
> @@ -207,6 +248,14 @@ static int smu_v15_0_0_init_smc_tables(struct
> smu_context *smu)  static int smu_v15_0_0_fini_smc_tables(struct
> smu_context *smu)  {
>       struct smu_table_context *smu_table =3D &smu->smu_table;
> +     SMU_15_0_0_MetricsInfo_t *metrics_info =3D smu_table-
> >metrics_table;
> +
> +     if (metrics_info) {
> +             if (metrics_info->cpu_addr) {
> +                     iounmap(metrics_info->cpu_addr);
> +                     metrics_info->cpu_addr =3D NULL;
> +             }
> +     }
>
>       kfree(smu_table->clocks_table);
>       smu_table->clocks_table =3D NULL;
> @@ -299,7 +348,7 @@ static int
> smu_v15_0_0_set_default_dpm_tables(struct smu_context *smu)
>                                   smu_table->clocks_table, false);  }
>
> -static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
> +static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
>                                                       void *metrics_table=
,
>                                                       bool bypass_cache)
>  {
> @@ -329,114 +378,161 @@ static int smu_v15_0_0_get_metrics_table(struct
> smu_context *smu,
>       return 0;
>  }
>
> +/*
> + * Fetch a fresh metrics sample into the inactive buffer.
> + * Returns 0 if a new sample was copied, 1 if the cached sample is
> +still
> + * fresh (nothing copied), or a negative errno on failure.
> + */
> +static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
> +                                     SMU_15_0_0_MetricsInfo_t
> *metrics_info) {
> +     struct smu_table_context *smu_table =3D &smu->smu_table;
> +     void __iomem *cpu_addr =3D metrics_info->cpu_addr;
> +     struct smu_msg_ctl *ctl =3D &smu->msg_ctl;
> +     struct smu_msg_args args =3D {0};
> +     size_t table_size =3D metrics_info->table_size;
> +     int ret;
> +
> +     if (smu_table->metrics_time &&
> +         !time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies=
(1)))
> +             return 1;
> +
> +     if (!cpu_addr)
> +             return -ENOMEM;
> +
> +     args.msg =3D SMU_MSG_GetMetricsTableLogSample;
> +     args.num_args =3D 0;
> +     args.num_out_args =3D 0;
> +
> +     ret =3D ctl->ops->send_msg(ctl, &args);
> +     if (ret)
> +             return ret;
> +
> +     /* best to flush before copy */
> +     amdgpu_hdp_invalidate(smu->adev, NULL);
> +     if (table_size <=3D sizeof(MetricsTable_t))
> +             memcpy_fromio(&metrics_info->metrics[!metrics_info-
> >active_idx],
> +                           cpu_addr, table_size);
> +     else
> +             memcpy_fromio(&metrics_info->metrics[!metrics_info-
> >active_idx],
> +                           cpu_addr, sizeof(MetricsTable_t));
> +
> +     metrics_info->active_idx =3D !metrics_info->active_idx;
> +     smu_table->metrics_time =3D jiffies;
> +
> +     return 0;
> +}
> +
> +/*
> + * Accumulators monotonically increase and roll over at their type width=
.
> + * Use the kernel wrapping_sub() API to compute the delta so the
> +subtraction
> + * wraps modulo 2^n (correct across a single rollover) without tripping
> +any
> + * wrap-around sanitizers.
> + */
> +static void smu_v15_0_0_compute_all_metrics(
> +             uint32_t *avg_metric,
> +             MetricsTable_t *prev,
> +             MetricsTable_t *curr)
> +{
> +     uint64_t counter, val;
> +     uint32_t mw;
> +     MetricsTable_IOD_t *p =3D &prev->IOD;
> +     MetricsTable_IOD_t *c =3D &curr->IOD;
> +
> +     counter =3D wrapping_sub(u32, c->AccumulationCounter, p-
> >AccumulationCounter);
> +     if (!counter)
> +             return;
> +
> +     /* Accumulator-based clock frequencies (fixed-point /1024) */
> +     val =3D wrapping_sub(u64, c->GfxclkFreqEffAcc, p->GfxclkFreqEffAcc)=
;
> +     avg_metric[METRICS_AVERAGE_GFXCLK] =3D div_u64(div64_u64(val,
> counter),
> +1024);
> +
> +     val =3D wrapping_sub(u64, c->SocclkFreqEffAcc, p->SocclkFreqEffAcc)=
;
> +     avg_metric[METRICS_AVERAGE_SOCCLK] =3D div_u64(div64_u64(val,
> counter),
> +1024);
> +
> +     val =3D wrapping_sub(u64, c->VclkFreqEffAcc, p->VclkFreqEffAcc);
> +     avg_metric[METRICS_AVERAGE_VCLK] =3D div_u64(div64_u64(val,
> counter),
> +1024);
> +
> +     val =3D wrapping_sub(u64, c->MemclkFreqEffAcc, p-
> >MemclkFreqEffAcc);
> +     avg_metric[METRICS_AVERAGE_UCLK] =3D div_u64(div64_u64(val,
> counter),
> +1024);
> +
> +     val =3D wrapping_sub(u64, c->FclkFreqEffAcc, p->FclkFreqEffAcc);
> +     avg_metric[METRICS_AVERAGE_FCLK] =3D div_u64(div64_u64(val,
> counter),
> +1024);
> +
> +     val =3D wrapping_sub(u64, c->NpuhclkFreqEffAcc, p-
> >NpuhclkFreqEffAcc);
> +     avg_metric[METRICS_AVERAGE_NPUCLK] =3D div_u64(div64_u64(val,
> counter),
> +1024);
> +
> +     /* Activity (fixed-point /1024) */
> +     val =3D wrapping_sub(u64, c->GfxBusyAcc, p->GfxBusyAcc);
> +     avg_metric[METRICS_AVERAGE_GFXACTIVITY] =3D
> div_u64(div64_u64(val,
> +counter), 1024);
> +
> +     val =3D wrapping_sub(u64, c->VcnBusyAcc, p->VcnBusyAcc);
> +     avg_metric[METRICS_AVERAGE_VCNACTIVITY] =3D
> div_u64(div64_u64(val,
> +counter), 1024);
> +
> +     /*
> +      * Power: accumulator holds a 1024x fixed-point value in Watts.
> +      * Average it into milliwatts, which is the unit expected by
> +      * power sensor consumers (hwmon/debugfs).
> +      */
> +     val =3D wrapping_sub(u64, c->ApuPowerAcc, p->ApuPowerAcc);
> +     mw =3D div_u64(div64_u64(val, counter) * 1000, 1024);
> +     avg_metric[METRICS_AVERAGE_SOCKETPOWER] =3D mw;
> +
> +     val =3D wrapping_sub(u64, c->SystemPowerAcc, p->SystemPowerAcc);
> +     mw =3D div_u64(div64_u64(val, counter) * 1000, 1024);
> +     avg_metric[METRICS_CURR_SOCKETPOWER] =3D mw;

Yeah, the v6 version converts the power unit to mW based on the below patch=
 change:
[PATCH] drm/amd/pm: use milliwatts for GPU power sensors

So , the v6 version is
Acked-by: Yang Wang kevinyang.wang@amd.com>

Best Regards,
Kevin
> +     /*
> +      * Temperature: accumulator holds a 1024x fixed-point value in
> +      * Celsius. Descale by 1024 and convert to millidegrees C as the
> +      * hwmon/sysfs consumers expect (temp*_input is in millidegrees).
> +      */
> +     val =3D wrapping_sub(u64, c->GFX_TempAcc, p->GFX_TempAcc);
> +     avg_metric[METRICS_TEMPERATURE_VRGFX] =3D
> +             div_u64(div64_u64(val, counter) *
> +SMU_TEMPERATURE_UNITS_PER_CENTIGRADES, 1024);
> +
> +     val =3D wrapping_sub(u64, c->STT_APU_HotSpotTempAcc, p-
> >STT_APU_HotSpotTempAcc);
> +     avg_metric[METRICS_TEMPERATURE_HOTSPOT] =3D
> +             div_u64(div64_u64(val, counter) *
> +SMU_TEMPERATURE_UNITS_PER_CENTIGRADES, 1024);
> +
> +     /* Voltage: accumulator holds a 1024x fixed-point value in Volts;
> +      * convert to millivolts for the hwmon/sysfs consumers.
> +      */
> +     val =3D wrapping_sub(u64, c->VDDCR_GFX_TelemetryVoltage, p-
> >VDDCR_GFX_TelemetryVoltage);
> +     avg_metric[METRICS_VOLTAGE_VDDGFX] =3D div_u64(div64_u64(val,
> counter) *
> +1000, 1024);
> +
> +     val =3D wrapping_sub(u64, c->VDDCR_SOC_TelemetryVoltage, p-
> >VDDCR_SOC_TelemetryVoltage);
> +     avg_metric[METRICS_VOLTAGE_VDDSOC] =3D div_u64(div64_u64(val,
> counter) *
> +1000, 1024); }
> +
>  static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
>                                           MetricsMember_t member,
>                                           uint32_t *value)
>  {
>       struct smu_table_context *smu_table =3D &smu->smu_table;
> +     SMU_15_0_0_MetricsInfo_t *metrics_info =3D
> +             (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
> +     int ret;
>
> -     SmuMetrics_t *metrics =3D (SmuMetrics_t *)smu_table->metrics_table;
> -     int ret =3D 0;
> +     if (member >=3D ARRAY_SIZE(metrics_info->avg_metric))
> +             return -EINVAL;
>
> -     ret =3D smu_v15_0_0_get_metrics_table(smu, NULL, false);
> -     if (ret)
> +     ret =3D smu_v15_0_0_get_metrics_table(smu, metrics_info);
> +     if (ret < 0)
>               return ret;
>
> -     switch (member) {
> -     case METRICS_AVERAGE_GFXCLK:
> -             *value =3D metrics->GfxclkFrequency;
> -             break;
> -     case METRICS_AVERAGE_SOCCLK:
> -             *value =3D metrics->SocclkFrequency;
> -             break;
> -     case METRICS_AVERAGE_VCLK:
> -             *value =3D metrics->VclkFrequency;
> -             break;
> -     case METRICS_AVERAGE_DCLK:
> -             *value =3D 0;
> -             break;
> -     case METRICS_AVERAGE_UCLK:
> -             *value =3D metrics->MemclkFrequency;
> -             break;
> -     case METRICS_AVERAGE_FCLK:
> -             *value =3D metrics->FclkFrequency;
> -             break;
> -     case METRICS_AVERAGE_VPECLK:
> -             *value =3D metrics->VpeclkFrequency;
> -             break;
> -     case METRICS_AVERAGE_NPUCLK:
> -             *value =3D metrics->NpuclkFrequency;
> -             break;
> -     case METRICS_AVERAGE_GFXACTIVITY:
> -             if ((smu->smc_fw_version > 0x5d4600))
> -                     *value =3D metrics->GfxActivity;
> -             else
> -                     *value =3D metrics->GfxActivity / 100;
> -             break;
> -     case METRICS_AVERAGE_VCNACTIVITY:
> -             *value =3D metrics->VcnActivity / 100;
> -             break;
> -     case METRICS_AVERAGE_SOCKETPOWER:
> -     case METRICS_CURR_SOCKETPOWER:
> -             *value =3D metrics->SocketPower;
> -             break;
> -     case METRICS_TEMPERATURE_EDGE:
> -             *value =3D metrics->GfxTemperature / 100 *
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -             break;
> -     case METRICS_TEMPERATURE_HOTSPOT:
> -             *value =3D metrics->SocTemperature / 100 *
> -             SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
> -             break;
> -     case METRICS_THROTTLER_RESIDENCY_PROCHOT:
> -             *value =3D metrics->ThrottleResidency_PROCHOT;
> -             break;
> -     case METRICS_THROTTLER_RESIDENCY_SPL:
> -             *value =3D metrics->ThrottleResidency_SPL;
> -             break;
> -     case METRICS_THROTTLER_RESIDENCY_FPPT:
> -             *value =3D metrics->ThrottleResidency_FPPT;
> -             break;
> -     case METRICS_THROTTLER_RESIDENCY_SPPT:
> -             *value =3D metrics->ThrottleResidency_SPPT;
> -             break;
> -     case METRICS_THROTTLER_RESIDENCY_THM_SOC:
> -             *value =3D metrics->ThrottleResidency_THM_SOC;
> -             break;
> -     case METRICS_VOLTAGE_VDDGFX:
> -             *value =3D 0;
> -             break;
> -     case METRICS_VOLTAGE_VDDSOC:
> -             *value =3D 0;
> -             break;
> -     case METRICS_SS_APU_SHARE:
> -             /* return the percentage of APU power with respect to APU's
> power limit.
> -              * percentage is reported, this isn't boost value. Smartshi=
ft
> power
> -              * boost/shift is only when the percentage is more than 100=
.
> -              */
> -             if (metrics->StapmOpnLimit > 0)
> -                     *value =3D (metrics->ApuPower * 100) / metrics-
> >StapmOpnLimit;
> -             else
> -                     *value =3D 0;
> -             break;
> -     case METRICS_SS_DGPU_SHARE:
> -             /* return the percentage of dGPU power with respect to
> dGPU's power limit.
> -              * percentage is reported, this isn't boost value. Smartshi=
ft
> power
> -              * boost/shift is only when the percentage is more than 100=
.
> -              */
> -             if ((metrics->dGpuPower > 0) &&
> -                 (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
> -                     *value =3D (metrics->dGpuPower * 100) /
> -                              (metrics->StapmCurrentLimit - metrics-
> >StapmOpnLimit);
> -             else
> -                     *value =3D 0;
> -             break;
> -     default:
> -             *value =3D UINT_MAX;
> -             break;
> +     if (ret =3D=3D 0 &&
> +         metrics_info->metrics[metrics_info-
> >active_idx].IOD.AccumulationCounter !=3D
> +         metrics_info->metrics[!metrics_info-
> >active_idx].IOD.AccumulationCounter) {
> +             /* New sample: active_idx already points to the latest samp=
le.
> */
> +             smu_v15_0_0_compute_all_metrics(metrics_info-
> >avg_metric,
> +                                             &metrics_info-
> >metrics[!metrics_info->active_idx],
> +                                             &metrics_info-
> >metrics[metrics_info->active_idx]);
>       }
>
> -     return ret;
> +     *value =3D metrics_info->avg_metric[member];
> +
> +     return 0;
>  }
>
>  static int smu_v15_0_0_read_sensor(struct smu_context *smu, @@ -473,9
> +569,9 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
>                                                      (uint32_t *)data);
>               *size =3D 4;
>               break;
> -     case AMDGPU_PP_SENSOR_EDGE_TEMP:
> +     case AMDGPU_PP_SENSOR_GPU_TEMP:
>               ret =3D smu_v15_0_0_get_smu_metrics_data(smu,
> -
> METRICS_TEMPERATURE_EDGE,
> +
> METRICS_TEMPERATURE_VRGFX,
>                                                      (uint32_t *)data);
>               *size =3D 4;
>               break;
> @@ -511,18 +607,6 @@ static int smu_v15_0_0_read_sensor(struct
> smu_context *smu,
>                                                      (uint32_t *)data);
>               *size =3D 4;
>               break;
> -     case AMDGPU_PP_SENSOR_SS_APU_SHARE:
> -             ret =3D smu_v15_0_0_get_smu_metrics_data(smu,
> -                                                    METRICS_SS_APU_SHARE=
,
> -                                                    (uint32_t *)data);
> -             *size =3D 4;
> -             break;
> -     case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
> -             ret =3D smu_v15_0_0_get_smu_metrics_data(smu,
> -
> METRICS_SS_DGPU_SHARE,
> -                                                    (uint32_t *)data);
> -             *size =3D 4;
> -             break;
>       default:
>               ret =3D -EOPNOTSUPP;
>               break;
> @@ -633,7 +717,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct
> smu_context *smu,
>       SmuMetrics_t metrics;
>       int ret =3D 0;
>
> -     ret =3D smu_v15_0_0_get_metrics_table(smu, &metrics, false);
> +     ret =3D smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
>       if (ret)
>               return ret;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
> b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
> index 8365b9fea77e..8471ba1a353e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.h
> @@ -23,6 +23,19 @@
>  #ifndef __SMU_V15_0_0_PPT_H__
>  #define __SMU_V15_0_0_PPT_H__
>
> +#include "amdgpu_smu.h"
> +
> +#include "pmfw_if/smu_v15_0_0_metrics.h"
> +
> +typedef struct {
> +     MetricsTable_t metrics[2];
> +     bool active_idx;
> +     uint32_t table_size;
> +     uint64_t addr;
> +     void __iomem *cpu_addr;
> +     uint32_t avg_metric[METRICS_AVERAGE_NPUCLK+1];
> +} SMU_15_0_0_MetricsInfo_t;
> +
>  extern void smu_v15_0_0_set_ppt_funcs(struct smu_context *smu);
>
>  #endif
> \ No newline at end of file
> --
> 2.43.0

