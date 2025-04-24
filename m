Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E114C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 12:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C9D10E7DC;
	Thu, 24 Apr 2025 12:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZrM8Yte4";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C401B10E7DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 12:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMoRBTKsfiTxx48aZbBlsAwZN1kUbM/ZOLS1dYkzVxYalKa4g43uP5KWm5zJpaMyOP6RvBRW0MZNKKhS4reLoDLyykPDElEumfaTYMAUd7b87gi1uCRxKwmaFvziD2hOSYBwoykHKHkamJoL5CzgV1Le5N2vszi4hsJA63X0oLZsQnq0dfzOOQObi/9BRrJAS+FfQq6Ktz+/fUHG34ld2YbRxP1t66NI3/ub6GzK1hE3rSAP9gpuJ0VVTK8KGgwuQQNwG0rrrOGwWlc9ZOoDaXoiC5rHQv0s86GNLUOP85DlPplscl5W6VOqzOhesAX1zFAEFWReBogv4Dgc69uWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZYWL9kNWvzVNMOyWbh7HMsVx8Cw7nQoBnoTEHz5f1w=;
 b=Gw1hJiDE+6QnBKaDTZtDfHRyAW72SsfbapOB2Ulcq0Ba0kwHqfmkwIuZu4ANfou9fzKnS75xmMRn6sMgNmEAOUxajjz8vzEqWA761ia5fWzTiaFafMlog8KssMEo/UbYW2EwhPJs1jUr1+uCiyrV17Tr1K5RDpUsDLm79tiRo3w+iXEoklRdw3ufPpxCuYwWLIrgcYry5eckXi0+4whedzmmp8xgYJIq8cFiiihiCOyGpOfqO5vAay3Mv5LlCZkocWpRuG4z78QjZV/HMxksqSAP5L1vYPWovXKDOzvQSoEulTntEKQ//4GS+ONFmgjCvzMcAyxt0lvTrh/xMmUarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZYWL9kNWvzVNMOyWbh7HMsVx8Cw7nQoBnoTEHz5f1w=;
 b=ZrM8Yte4ECvlbHG5q/1n/305v6NsjtLYQa2PQ4Ji8aA5l9DJQYD/Appb72ajaPbyyqCpIFKfedMdBSc/Asu1Sf2v0AT7blfT8xb/Pa42qBkMXsD/jxhMpAdv61tu8i1GKFHGkT8KuvCz2UFlfzxzIL6CNKxc1AuWFxrGIu+mVKk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 12:03:09 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 12:03:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>,
 "alexander.deucher@amd.co" <alexander.deucher@amd.co>
Subject: RE: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Thread-Topic: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Thread-Index: AQHbtQ2XRFrmZkoeo0GTgMQLcEdrM7Oyt3RA
Date: Thu, 24 Apr 2025 12:03:07 +0000
Message-ID: <BN9PR12MB5257C994FF25BE90CC039D4BFC852@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250424113930.464303-1-asad.kamal@amd.com>
In-Reply-To: <20250424113930.464303-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8a9f4db3-9775-47b0-81ce-36fc0f3aa9da;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-24T12:02:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB8164:EE_
x-ms-office365-filtering-correlation-id: ecd09129-df48-4e81-3151-08dd8327fa01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Y5gRB6kAJ/bYvRPFv5riFQfkftPbA1t+Y2qgpKjV3WJTOYPZ1u0cN//nGth6?=
 =?us-ascii?Q?bXDg6PS1wBEmuzGb0esSZpu1xPMjPMms61P5VwcuZhe6P+UsybH7uunodS95?=
 =?us-ascii?Q?GjR9Wi5B7bj1mK6N8d9PhJUH5/Qs1bFVWqWtCpxTkLhUD9f0ixCxD4E/gBCI?=
 =?us-ascii?Q?A79MkBkBz5asmonoUYYzNDiRYp909q7Fx2/366aYGsK4TKLVqQHBpzG/0fIc?=
 =?us-ascii?Q?L4t9LWQtaWVDF2DEbpLRW4hc0EstXJ4lVzgfxkhzre36IPAFmaXrl4iwTSbr?=
 =?us-ascii?Q?sxkHHVNwrQWu3OW32VxwDHmXekPV9iWtPUZjlV9ZUfRzTswMQUJKBOvwGBC4?=
 =?us-ascii?Q?UC8nIlvCOf+ieAWUJJHk4GrK9HP8DykOthtOqFR9avAhjp9fbjDcPKZ+2+Zo?=
 =?us-ascii?Q?zX7fiFr6pLZgOrpxKSmGqAzFXIcHfm/3ODC6l6Kqo4hFhzy4n3N/F2CWgbgu?=
 =?us-ascii?Q?wPDU0N7XtcTbtOQhisYfHeuZRy6eZZGvuUqTAC/9/e8IP+gHSDcyvjcyLZfg?=
 =?us-ascii?Q?TSGfJiLQEDAsKThj5pk98s6eDeRQPAlC2sofmOk/nIhLCboJVpcWfX4YQZga?=
 =?us-ascii?Q?AuWGmVlQQlVChntb1v70Tq1vTZFzE9OkkLYh9jmGUOuc44aqhj75HwPK+tdM?=
 =?us-ascii?Q?60bqRXaDG+C1ZG1OPh+o6VOqUQEUFek5WWpvBcYlWl7Mx5WeVcearAp5fJMn?=
 =?us-ascii?Q?WCsvr8ug2fowIURbQWFKEHdbIxVS9ikyUCChnJD+iEgzNW7h4LdyZPCZe6wO?=
 =?us-ascii?Q?dZn2S0gePSr2wzOiWYmQxHijylAnCFbuyF4mVP2ORoWYwsqSORj8BBJ78G+Q?=
 =?us-ascii?Q?ekNPZhw1wPXJ0iAwaOuushnE31kW5mjE2KyyNZoYCKUyEuqnMEaQIa8nZG0/?=
 =?us-ascii?Q?C8JsB/sB+RZelk/b0H70MLG3EwpP4nm9m5NYmwCqy5kM9qPTlN5u1+h1vGz6?=
 =?us-ascii?Q?rIfC8qY7ZIGhXE3xlAk8GZwtTVq4CQZYUD4rAfqvLBPz7mTAwfn3+XfABSv/?=
 =?us-ascii?Q?j1jrqe/n4hLOh0d5DLb7ulOS164rEgwFQ0HDyC0iaEwK9Q8fmWdlHztOwRMx?=
 =?us-ascii?Q?h8JSil2rxcs11y/Lg68B0kR5bJq3oASWH7Lp/7p6EMsMvoB9DTuiJlMeDH7L?=
 =?us-ascii?Q?d/nX9QqBKmiVaV1u7otNWaKUT8Ew/mmAlKLsjRV66BtrbqV8iDKDUQFlN27B?=
 =?us-ascii?Q?8t8iTK3ejtg+zf53LIRvZCruXibZexMRyL/xlYVSJ3tcAD9pDxeJW2WlhZ0Q?=
 =?us-ascii?Q?xnccvE3+XA88c3VbqV8gebVpqmHeaku77pRA6imbT8UclAx2wDHEDFGorAuA?=
 =?us-ascii?Q?o6ZG1pn4C1cH3kRobzWwz10kKqLNVcXTs7vU11lIAeyiQYckq0XIxskk/4cF?=
 =?us-ascii?Q?iYVprR+iEpxJuDqZoKawNt9E2e6aPlIsbvFvYwYxRYMlnro8cTmFsTcYeTbo?=
 =?us-ascii?Q?mYOYO+5J+ayw+MESCrGMxyAUmhcDdRSsOvWg/PmBH40AUl3S/dW4SQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OhPUt9iscA7a6JaJweoKhtrsa08XJyjHKNihc5P9QZXBsrN0MKE/AzVlrtpr?=
 =?us-ascii?Q?l0TKi5ZYKqkjgZ3IZurT5erxfLCwTsDen7ATY+i6vdzLn1UJEvo1Y7VVGArp?=
 =?us-ascii?Q?SgIORZzwu7r8JbZHIgH8zTShKQVqCXOZ9u926cw5qPwCv3zism6Z9I4TiL7n?=
 =?us-ascii?Q?PpvcVnrMxYVw95qNLCnxthwi4mYEC28HqLiw+X6QWYxpHR0leLSi4vSAqeEH?=
 =?us-ascii?Q?mpjGUlA540M1MGkVy7FlppTWv65cJP6s13M8uinuIDV2vYPiRm4coIyPzEZK?=
 =?us-ascii?Q?1Q4nA+5wX9ad54+gb65pooLP5UHt7cM13fcZ22omkET0UNqp66uiPyWDIMiT?=
 =?us-ascii?Q?syKPVwyZ5ivAVlxSmEYJUbS3klq8kxmU+VfR9MmsbZKAOm5edEk/49UKASbV?=
 =?us-ascii?Q?VDvn9JW73gz77fYAjjPAuYdYwtoEbDrBKHELmU/9W4guAq1hqNPonRbXV69w?=
 =?us-ascii?Q?sIb9EJewImqaOxqck+OLtEYjEq1KRz9+at4KapHMiiidLTxOcks0Cz2MG5OI?=
 =?us-ascii?Q?7q5zML3oTmz2QhksRKm2bEst4xRaS8Y6w2NBA8e5pM7nPmhRNhmlRZj/Dnos?=
 =?us-ascii?Q?+rWYmaa7svITqNoeh3pRVLYfQK5iES86OKOTsHQd1IAB1dHCjbM2vxc6ni9Q?=
 =?us-ascii?Q?VW5XtMVSHqg08/7rT0b5/5yX8vjVMpf6jnmVJXqxdsFHU3orAk7XTE5e/dtS?=
 =?us-ascii?Q?AjKR1WgzQZVFY4YGb0kyBDf1rtRCxyghXFCxgpmU+ya+f9tTsiUoHf2BtfC8?=
 =?us-ascii?Q?AZk1EbuyVLx/9bmxxrPFhd2PKXjOxJI225T6gmvjFnW6eObvrL8rHX9ca5B4?=
 =?us-ascii?Q?37Fe31n+CGcM2lfqDizIQzfQtgGDT+6OUDY7frMTYHyUQKZSzSgCNS4e+Rrp?=
 =?us-ascii?Q?MxotguZL/7WnvncLwp71goYJsnkKQpIYgashkjSCcbRf555KQ3aa5IfBFcBP?=
 =?us-ascii?Q?LV/VmgdlnCm5RnJ6WVPcm2aho38AaKUfKrpMoGQaZIx7aJVKwxYzSEHBpRcx?=
 =?us-ascii?Q?ioM8Phq2VJCQhUBSyrRvTCxo6x13+eHvrXM5V1PiHWXwFdrCBOvDLUlbU8Pi?=
 =?us-ascii?Q?RqN4wov2QUq2O464zKGI27DmDtiINAkkPOWoIYGRAf3vVoaNCrQFnteiOws1?=
 =?us-ascii?Q?OXX0qBSdH+kukCHIDZoGvnyzz4HRUmh7ARqI/PHT4iJePgs9PWop5C72lLpt?=
 =?us-ascii?Q?NBmMk5UIf3X3NnIDMtO0qlMVzqsn9rSkCZGV8KT/JqbBfuR4eK/SCEJ6nZII?=
 =?us-ascii?Q?7O3GFYZS20GCUUFPPoRu0f3tVz40X08V7l5C+TP4+/u3MM+59N57J18B67yI?=
 =?us-ascii?Q?zaDFpny+eKNrunwl807sEsKRkbSnybnR24TyBZxlFbRaXAN5V7LI8ewX6WQw?=
 =?us-ascii?Q?tdC69JAXP48jEbnTpQIF/nM+p1abbubHQnJD11vDOhnJMN57a3k64qCH9jOh?=
 =?us-ascii?Q?gG6ecnmNH88plT15qqDjrd7NI1uPQsjplKVbbi73V0dhVueJUMLV3WsxEXbs?=
 =?us-ascii?Q?foQTpooOKrn7e/FmqaK23rkg+7jPGBG8UrsrcjmKLUPapQ+lKoOdRVlbY1K9?=
 =?us-ascii?Q?eptGMkN+odtatrFuJmw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd09129-df48-4e81-3151-08dd8327fa01
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 12:03:07.7588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FsWO+c7V2fTcGWnCVvnC13Qh+QYmdcB7Lxhs4oOdMCignRI5oeLaWwjHIZSUv345rFPSzxdMOKnqCHqQmAn0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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
Sent: Thursday, April 24, 2025 19:39
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; alexander.d=
eucher@amd.co
Subject: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12 f=
unctions

Add ip version check to use smu_v13_0_12 specific functions

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8d845b5912c5..96fb6c111ea5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -748,7 +748,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_=
context *smu)
        int ret, i, retry =3D 100;
        uint32_t table_version;

-       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_setup_driver_pptable(smu);

        /* Store one-time values in driver PPTable */ @@ -1131,7 +1132,8 @@=
 static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
        if (ret)
                return ret;

-       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_get_smu_metrics_data(smu, member, value=
);

        /* For clocks with multiple instances, only report the first one */=
 @@ -2496,7 +2498,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct sm=
u_context *smu, void **table
                return ret;
        }

-       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_get_gpu_metrics(smu, table);

        metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
--
2.46.0

