Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E9DC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 07:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C5F10E59B;
	Thu, 20 Mar 2025 07:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vHRcM74j";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FCC10E59B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 07:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqQ4atvsE3KaJunwSt8hOyk9+BpBy8RCdGlzWTUXRv2t23RU6StCEkHgRWnpTV0EeIsfTrzffxX+Cmzb5j3+j9BB+4aVCa/k6woxu8kiPH5QJUXUK2+/j/FjBLs/ANyBWV+C4nJ9JdeTTylS6Z+/Sr+mvwGOLWgPoSaDEToiKd4c2CA1pewWmzGjKbzq8gSa9XEyj+Q0irvBPUqaXeHVGrXgfp2WvzotRXJxJOK+Ik3BBF2GRKmk4GZCfU38xh0kFyX5tzP/FLEogU/fKKowL5q6QwLmPd99A6EFCb1xCL2L+KT8/DXFxCO87WiG26NOZ3lVDerhR1v2CCF1ZMbkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0bIgBs6HjTB2enO8+9649j6JoUZycx3YTONogO5ckw=;
 b=CEqeA+VOYJOOrB7C5iNf7Vfa6JM4mZnfsNdvuqaYgWFeBCajToHcnWeoWKYvEeCQMOa1R0fs/dae2MtU1DXTIsq+9zeAtuEjRCfjn6WjyVesx6pX994+iCTJQke8DOwbkTSpDcJFZ6mkOxgXV09QO3obLleVfG6yEuFVrDU9iP8/QHrmJOENzFabZsA+cZewjoq18iY/wso1rbBZuE1VqL7dZhL8Tq8iAAbpfhT6qWeqdpK4eOwtPrvOVrpORRIdv5WxJ+VaT1uhWw+AH/XeLe+p4kA0J6FPBHfn9Cz5fGaeQBIUtsaReBatsWuB3gW7tNCWpbKhbD6AcW0Xx6V1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0bIgBs6HjTB2enO8+9649j6JoUZycx3YTONogO5ckw=;
 b=vHRcM74jUxjzYxNcz78gbfkVsRj2qG6Kiw+uesnM5UrATbemjSNIr1X3rK6STyE6EjeOkmr8Ld/FMtJBj85bj3uAGFPY7UHdmPoJixxS1WsfhvtHZhmeLhDXtbmowgZ/srGWD0dIJzmLMoFZ166Arg1zw+aQ0Pz5z8L6h2zBS1I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 07:24:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:24:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amd/pm: Remove unnecessay UQ10 to UINT
 conversion
Thread-Topic: [PATCH v2 2/2] drm/amd/pm: Remove unnecessay UQ10 to UINT
 conversion
Thread-Index: AQHbmWZceM/WShAUg02LEcEVaDsKWbN7n0dw
Date: Thu, 20 Mar 2025 07:24:18 +0000
Message-ID: <BN9PR12MB5257151C7D2B46B863F682EEFCD82@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250320070421.1266690-1-asad.kamal@amd.com>
 <20250320070421.1266690-2-asad.kamal@amd.com>
In-Reply-To: <20250320070421.1266690-2-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d4c20711-b24c-4a98-914f-966e8e6f5dc5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T07:23:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6236:EE_
x-ms-office365-filtering-correlation-id: 0b6f4700-ab9a-48f8-8729-08dd67803a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?l+sI0QVcUBkCXpAK+s4hwfuKByl2enEhLMzjuJRgmZtC5MWcwjcXoBgvZAvn?=
 =?us-ascii?Q?YV/3tZ47gdKt7y9ugvaXV2/8Mi1SmNopiH0t6cHjX5qw2SxOp/A1qwoNnx7X?=
 =?us-ascii?Q?budZ1zBXaUpmuSRkl1Ph6/0gYYHzEqCok1pSycrcR1yXZYs4X2VsxUxPBHld?=
 =?us-ascii?Q?yaO9Z1pz3nHiImXNX81NAx49kSaIjFblVb+4KzFFrOq0BJib6AunCBJ1aGNq?=
 =?us-ascii?Q?uGEsirYRkP2qYZVFN+ihjckjZ0ClP3kmuBF2wvjN7aUFz+KgJJSNcedjVZGm?=
 =?us-ascii?Q?nat/9MrpwtKL1qMxdIHxFQS/SbuoC2FXou17TwSLctw86HezMcs5y+BD2XwK?=
 =?us-ascii?Q?PTdUxQMx+MWXgNRhySKOXRA74j4z9xrRBh3Z9+CyGHN11vAyxWIUGAnabXaZ?=
 =?us-ascii?Q?EkK9Gt9vjH0/DQg/fhzKG6QOMNyy+fnbwRWlsA3rQfaEsaPx/PLTqpsVtQRC?=
 =?us-ascii?Q?F2xy+G6xFUB4eoMOBe7PwNQ53hx+yIhjyjMlVHScT3gcco7brz6hQ2tBnJ2z?=
 =?us-ascii?Q?HGiEEpIEVc2ckofUQOOu/dIGhC5k6jMuzedelz1GUNyqCnLFShTgJX4qF0OP?=
 =?us-ascii?Q?wPMOVyHn830bCd1BQdMqrJQoKTMZ/0n1rAY0jw7phahX68ur0nqkNWR7KOUi?=
 =?us-ascii?Q?MfpfwpLkb3deSTpqGslgUsmQr+/s1JwGXyB96jvR4y434msDjvn324onIZ41?=
 =?us-ascii?Q?Qcn/7frTdb5FV0d/7es8coOWuKy3r2Q+MJCq8s84YsM59LkaBUvu/JEL6pYC?=
 =?us-ascii?Q?2sHPaVM+az5MYH+vfbuVq+0Z8IU3A4HZ1/s0iRalf0wkbUIPIF1A97et9MIB?=
 =?us-ascii?Q?o1Zp1ftYDAJLqiiRUmJiWHhlmi1SEZ5A6JbdaK/ySu2vU7QT/Tn0EqamwBid?=
 =?us-ascii?Q?16hDLEqH+j+g6Kq+7Iqt39CYfDwWfOFHFElttxnMBks1TwC7Hxisz/7Rk27D?=
 =?us-ascii?Q?QAaOH3m2dwhUsEMQdYv/7AK/pOF6aMN9cGAejSGA7MdgRe1frR0eVRIIbUrk?=
 =?us-ascii?Q?zmhnQ9tRMlXT43Poejt/WTxX94bV8wm0ZVPVHxRZ5CTJdlyPKGFIqGHva9sI?=
 =?us-ascii?Q?t/2JstzgsjcBMUIhlqsPF9jZmGjzci4aWto0Ijtggecn5v2Ow9aruGWS6ZcD?=
 =?us-ascii?Q?bz5nwAUvomWT1etM2xvtCE8bRh9YOAzV3P1P7Wwv7FlEl5SJ/071myvwSSv8?=
 =?us-ascii?Q?NQrRK/SaV0rInCS4qb/88LxmPNbe2RF+xBSJK0y8oJreuf8MaueqkpFJfHwq?=
 =?us-ascii?Q?F2TVNR5BMG6pdSDKiUKIKO32X6k0IyuPixMbnramw//sGegATAH7h4EJhIPC?=
 =?us-ascii?Q?Yubqq3bv6I/L1zdREkQA12P1rzDmk/fKLCkHJoyyGNqVDKuALQKE/Z17gxYq?=
 =?us-ascii?Q?DFJ15Do79SJDC+rHY+QJsB1izG6M/0vsvaCuAa+LjNSmvt0yswBB/nfxgW7w?=
 =?us-ascii?Q?FcPZuV9qW78naUUWSlCSQR+T882J5MB9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+/kWYv3Ol6mfcIl/2t9bzCU2etvjeTzshVjs+5HxLAzAI1ncNASgAMPPhHSn?=
 =?us-ascii?Q?cJQAHVbJqriAyYw/61cs0cUSzqn64rwcyKk6/YXe1qv0M5J2o7tpk0h29Y1z?=
 =?us-ascii?Q?ijCs2fpBDc0s7fjMd0tlpM/NMwqfkiZhdJ2jd5Fyp3AXbwkAP1rwqi/4sjpl?=
 =?us-ascii?Q?SY0y/cJnYPpoyoOPvLmwsZrgRtqP17894CJboqQV1qKhue79dYYlFHdxZx92?=
 =?us-ascii?Q?nEJyBeQrkgJJ8Y6N1yaUyJv3WnBWLsDN6qyRz9wWiXp3waYLALzSJqSgHifr?=
 =?us-ascii?Q?OxhHb8wEdKrQ/+pGfgvJ7LgABWbmp1y9KWx75myzdIhkLz6NpyIJd07eo98G?=
 =?us-ascii?Q?1E6xdQl8WCQ3s+AkZecpQkiyGH2t/iyUhHaO+ZZfO2GYfcewLF8vAvojPtqa?=
 =?us-ascii?Q?j7PYnX52Xvjx6zVGnba2byZTNXiv57f4mibo5bXdrsjN6P+59g5jXxJXaSbJ?=
 =?us-ascii?Q?HDsMOVOk3B+Z6s0wtS7x9y02Xv0Ehga3bJ9r58nLQL2eOgfp68LuDj2WU7uF?=
 =?us-ascii?Q?n7dHuXTfJOwv4B01rfjoznEXVQ8hLPI2Voa868kHZDNsC0BU6gWoc/1xZEig?=
 =?us-ascii?Q?2MfwttM5jixBXQOMrUm0+EtJt81H7mR4QK9FmgbBAK/DZ37Zt2XKNVSs/oR3?=
 =?us-ascii?Q?Ktf5Ol9LjvWuFuyeei52IHJTgpB09+DWG1IYSGMpcAX30cgDLfzd6BLRxgbp?=
 =?us-ascii?Q?qVKw5kZEJyc36rHQU/9m9ZMCqjBuTmT/ymVfkpnfkanIAMXTbRei5BdtrIAc?=
 =?us-ascii?Q?wLiccV8VrTaOMut8FeHt53UzuHPrNFRxIQFo0oZvHrVDr4bZ8KFsMGLpWHob?=
 =?us-ascii?Q?RGPJON7eHl9Ybf59w0kTjas5f90pYPBiIuvKOVtAuNV621f8EvOIiTRN7KJv?=
 =?us-ascii?Q?7QrEh8Wp6dUFPXm2U+oTGrqhcSIxlU05LSpta7+IpnVxSZuUiJHHBXxxzup8?=
 =?us-ascii?Q?uu3UhyqZsTQgtLzc6nVnwA0TlOzh5pq7e9EtPvBtEgBhxXwz2qQcp23EiiIA?=
 =?us-ascii?Q?E5z/417l1jWVYlsTSXXLl7ygrbADMuLRa8vbTCTyjKOTAN+6X7Vwc4fLCo+z?=
 =?us-ascii?Q?eorT4JTcp0uSi1ouJ+mb2GLt4rGcg24MLwaNeziBbCCexpkcblSrsATPPkAH?=
 =?us-ascii?Q?ngtbPqTNWGv7/BIacs3TpbgOn9SJvsFuvbiCE10Y1MO1UBBDlHfd7rN1SWVv?=
 =?us-ascii?Q?+uRjRjgPVpxIy4ENg0uKmqBv3kRd9WbXy0jXYiH4BguHZroM0dxI2h5asx0K?=
 =?us-ascii?Q?FAc0Y5lcJWPxQt0nguiiCUyzHWUkO5vj0yKWHKLGC+R5UIwYP7aVjdaOts5u?=
 =?us-ascii?Q?ekZmUJiSt8eBIvbNIarICKE8SV3AokuouCyUlJgKyFVuvFxI+PUwkl6R1lg7?=
 =?us-ascii?Q?3BN3QDDiTKCf4qJtCFwbcOv1jcXjPr6QBkTc5XEbRKu/uA0mdKZA53SOkFG+?=
 =?us-ascii?Q?yFkcTAEK7T/iRSatljXV2qut72Q/gc3DmoTY4NxINUZOPFz6HiB0hUgTHIeN?=
 =?us-ascii?Q?6kPS5Zp0/EABK0dUwrqa4oTux3XLVPjH4LNaujrpp8ko9YHg/7Wc/HgfNNSd?=
 =?us-ascii?Q?izwN5Lp8AcYMd7L40EGBeyxCCBdWRHMN84XchtU3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6f4700-ab9a-48f8-8729-08dd67803a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 07:24:19.0215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhMzY1sxIQb1z5ohcmi2E1YMwvOpd18kVLBil/NrP21Ck6qglyiVhfmFnYCjzGVP4PldoJNz0K4tCduBgeQCuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Thursday, March 20, 2025 15:04
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH v2 2/2] drm/amd/pm: Remove unnecessay UQ10 to UINT conversi=
on

Few of the metrics data for smu_v13_0_12 has not been reported in Q10 forma=
t, remove UQ10 to UINT conversion for those

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 12ee8d07d0c8..5d4437e413cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -488,8 +488,8 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context=
 *smu, void **table)
                }
        }

-       gpu_metrics->xgmi_link_width =3D SMUQ10_ROUND(metrics->XgmiWidth);
-       gpu_metrics->xgmi_link_speed =3D SMUQ10_ROUND(metrics->XgmiBitrate)=
;
+       gpu_metrics->xgmi_link_width =3D metrics->XgmiWidth;
+       gpu_metrics->xgmi_link_speed =3D metrics->XgmiBitrate;

        gpu_metrics->firmware_timestamp =3D metrics->Timestamp;

--
2.46.0

