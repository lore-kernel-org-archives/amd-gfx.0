Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126D1CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 06:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DAC10E223;
	Fri, 19 Sep 2025 06:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uR3N5eAP";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4674610E056
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 06:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+mPvB/42nIoZCvpRoTnrLY6zar9bZWzpJqY/+todawEr+HJTp3+DDG8i6GyE+ekjBojxeR7A4CnEbAkYhg8UCD4In6cbYvp6cvTQY3CBc+HbfJmMsQ26MI+0iClnGhRyeZPlS1V1xFr/zWKeMGMS4gv4cqfeNPznjZs/6jyOS9he0jGG5XEiX7MQT4b09TDE2QYQ99RiVgFv0YQq8NrRKtqM/i2B95DQhMyhlOAwSxJaWECo66ot4YV8HGmGwTEMCNrKP9CAyFcKBBhufLGu0Sf70/2V5odXgnd1GqWidkpXSFCpHvdxAuJeLiHxCGyxHNKbMgrmfsAC9qeZUOdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxxv5qIjXEl4OvLMqQ101a72YtRw8m1gNRP+F1D/rOA=;
 b=nTm7repMG7gxTu+cqyGcwr9HfhApAviPh7ppXfRo1+B84SJSwAXRA5wr0Lz1BJVXwORoI7lLDv1WE/s2D1kGre6z1fSr/jK8Qi1xZOidJCaR11beXsRFHXkpVatIl/chqV4TcUlkDau/KGK1o6M/BgEX+zcmp3WHmV+hi+WKS9mo11Qkq9NNrlkU1S+a+CsTrwbak5xHBmANebRLJZyH9zCIwycNC15Lwl4+GBytvxiFWAE63bo+0SLrBqJHVtbAFPbubyEKRyi7inzGBAfbDopzt/oYVsUr+eQhdD+RBvExYbe5LdhnkwC0AxE2w0K0rFWGVWi9+bzYbf76OA/OIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxxv5qIjXEl4OvLMqQ101a72YtRw8m1gNRP+F1D/rOA=;
 b=uR3N5eAPO1+EsUkoNXT135zMsroFNUU/s7BNwqSNmBQ6WuZ6N+RuVtOXjU3+ten6OjhtkuCBH7hZ3J4QBV5/zMKA1FnZSAQrLvzDH+GQJmsOeOQB5M0aw69YlN7SfGEfRekyYSPoKVon2G33/Vvk01y1avXnEMjfRg9OZbkrNZM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 19 Sep
 2025 06:28:37 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 06:28:36 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Topic: [PATCH] drm/amd/pm: Avoid interface mismatch messaging
Thread-Index: AQHcKSiM2Aaf1af7uUKBvjQ6W54v4rSaBlSA
Date: Fri, 19 Sep 2025 06:28:36 +0000
Message-ID: <PH7PR12MB5997B2F4AF83B9FDEAA5D0AA8211A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250919054439.3115476-1-lijo.lazar@amd.com>
In-Reply-To: <20250919054439.3115476-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-19T06:12:05.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS0PR12MB7825:EE_
x-ms-office365-filtering-correlation-id: 8797fd2a-0c49-45ca-bcb8-08ddf745c3f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9CqHV3EVYQ/pIiSOHkfBHhG9e2wnOqH7Ws9tAe4SQ8spnqVoT/ki+rRXOsPC?=
 =?us-ascii?Q?DdHqJ0PS+rQbFMj+zGAD3kVIvPJV9/S/xHc8Xawb7q4IkmAUXLhmgjFypmB5?=
 =?us-ascii?Q?dj/mAm3PO0Od8RCPGpVPzh3sbdW5wZ00MRw+4mdNx28iab0K0BBRA/Qh+aKB?=
 =?us-ascii?Q?4zVWapekVt8TDwKqW9NeZbqQppfLJkWD10YSWbYW7sBaE0wAaKhcOz201jUA?=
 =?us-ascii?Q?uJ816nBTkVdAXPj04hRBj4Lga4hekdKJD1ifBRFCvtVFOKV+wgjwX99tehXk?=
 =?us-ascii?Q?/WuNjMl5eNZCfzTY/urrkmuFGCo2bDoEt2B8eaVsyRMtNkY2tYnC10T1/NkY?=
 =?us-ascii?Q?me4nghcdVBvxGHOot91zvK3VAwWSAv4b9Lz894LVoPsGocZeXPXGn75zRBH8?=
 =?us-ascii?Q?AlZPT180xtmrQAcB/FgXOABc6uJHnyF+FSVSBDQpNJBb8HVyGfFlnNof+P3A?=
 =?us-ascii?Q?2IpimBOhKySkTT1yPLszKyAQ8jC69tHdfynZtj0+9f0+BLvQG4xXgH7ZiMEt?=
 =?us-ascii?Q?C/Z+lJAi+pCHH4I3IyNZQQL4ccykx3s5B5/g4MLjX0HANSzZlW3hO3Uh47RR?=
 =?us-ascii?Q?YCi8SDdxYwcy5LXN03aknVktwnExvVmwl/429Dr/2CYibLnm3zzzM9NerOic?=
 =?us-ascii?Q?V8+AwlpDJ3E0/QZgHdtD3nwpFDqLr77KfSioxMZ+jROW4jVj74xXY81ODSKq?=
 =?us-ascii?Q?sdmq9kXEecBfl/XL3y1qnQTbwY+ak3Y8tfuBtbFmMYy6vskhM/JYxakeW1Jm?=
 =?us-ascii?Q?kBpUGADpIf3uWyvUcWKRo+Sk15hLGJrAb9ZehgK13CQo+qflgoGveKmM2ocB?=
 =?us-ascii?Q?BG1UHLLGnK/k5i4avqDT9/XkL+H/LPXBsez1Sd1B6okXCyFjGQnpfffoqcq/?=
 =?us-ascii?Q?A+nKfDF7/v7tPZihJSVbYlFmfSrkdQ22dvVcNra7cVZQecgJLDN8MviFlkW8?=
 =?us-ascii?Q?Gf95NQEMXXrI1jiTmHMJOv2Is3svR62sEGMCXqE/4c18D8tLNSsOaK6UBffS?=
 =?us-ascii?Q?7IjS4QWmVuNev2ii7eo7DCgUtJBKghgLBMyLxyWztxgdUZN72SlkZLJg8X0m?=
 =?us-ascii?Q?ivsC03TMnDkWcb8Tnrmv8MzBVbRDXb/qTNXyewYI1gop03YX3Om+lptS2ErI?=
 =?us-ascii?Q?CH64o+2xs2Br4H3c0PJuVXmHTd12kkWYMjq78+f5jKfTMwQJvw9S7DRpD7ze?=
 =?us-ascii?Q?xEsnRmbqJbOCF63r/aQNJisj3syRKsYPwIXR5PdfDRhNzvm2w1v+ZNDsq3Ry?=
 =?us-ascii?Q?6bMD3Ol4D0mKDIG7NZ+2f06XyMzLTMIo6Kr9fBt4nJN0f/5NI640J5DlmoPc?=
 =?us-ascii?Q?YS9cTqvsFfK9HR6PfP9uaKYYINCYPsPoqkvA9eT3Gr1ltXJR3DKM7NtneCQ4?=
 =?us-ascii?Q?tyQvq4RtM/9DH7LCor+wTwjtjy0Uy7zkAUbyZfXEVlDZvcOi7rR9QdHf3OtX?=
 =?us-ascii?Q?cvhzSu+JZTQ1idhsuHg37I9HzJ6ChsQ6khRHejny/Wtk8+zwdwFH9IdQUpn1?=
 =?us-ascii?Q?7GsDdseM8lSZngA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bOPp3CFVLRzKnGBckwlvLHssc3fBtoTvrGpp4r7kCqZmtlliPOI4ATkK216K?=
 =?us-ascii?Q?plpiTawTTCSd/EJki/pYjyUnK2XUqPF1ALXlxlSj1tXVw+5cl1cysDLPsg+x?=
 =?us-ascii?Q?zbv0CWRqmrWZGtty3KqfXLWc+ltb5C30xidSoK9PCiTpaCjgfF0j4MeAaaW2?=
 =?us-ascii?Q?G1ochLtW7eEMZKQqEpE70GKtsJ01/0pYcjvkAzss8X/APCLxspMc+2NNmWJK?=
 =?us-ascii?Q?jGrAkP6TCTpGl3zjJLr0p8vTcKiHFaGKkKSlcUHq/fmXf2EYJN8G9K7WLlwC?=
 =?us-ascii?Q?10ZzdeJKz8mAiD8TalelobD5dNPCPpbv5xZMD2Rf1vQhCT8hRJCpfm/qEoC4?=
 =?us-ascii?Q?zw9FElBYakNpS2Q1tcEzCptprcPkZoLbCtNf+sXxYWkSVJXtTldL/27ehGgx?=
 =?us-ascii?Q?P4WfVXoQzOJ1km6BFaJpGS0NUKhrNxbG+W3hau2stCMbyUe60CIrqohrdynT?=
 =?us-ascii?Q?supSHERFAVRrGxQGMT+21HTmEmktniLOGqDOU0ZdVKVQ50XCCh4FD4OSVE75?=
 =?us-ascii?Q?U8EMZO4jc5S+5HZVllUjKIJJTTcKdXyMoQvHRfYfPM8t3GK86wl1cDZF6eIZ?=
 =?us-ascii?Q?Y4Wch0Rn2LB71YkLv6X3DBU4AiAUqxZWQnYwqyI8XKqKQAJcXFDhB555HY9p?=
 =?us-ascii?Q?WmxVBEvj3ha5hW332p2lRS6z/6XqbKsM9hZ15qpwNUFxZT7a3XMnA00zfF6Y?=
 =?us-ascii?Q?g3WsfJ3YFxzfjny4bv5BnZCsaUr7E2PwnWs0E1g5Cs06YCgotkuDViRfo+zm?=
 =?us-ascii?Q?65q5hroRRyLxyzk34lPp4JIGDT59Be8IoreebEwpI2P52XLKl+LYN1LvurFu?=
 =?us-ascii?Q?2Azzp4CiJ0x9lx/brviYr6yJLTCztwyumbnOpdrKCvmKSNNgwfdyZ+N2DN9+?=
 =?us-ascii?Q?lmHaiKtF2Q2n9G8jD2HdMv8ZAI232Xxa/PNmC36HOJCNgB1q9AhhutHrrxHb?=
 =?us-ascii?Q?Pb7BlGvaOjZjn6hP4v+Ak4RlUWssiZ0Mj1y2gVPVC5ceYV26Otq+ZuygWym/?=
 =?us-ascii?Q?98Jy2GSLwZCdmOnbOcdVMpL6FA4niF21DlsQ1Icth/PGQLEnoXiBTm+kDSLT?=
 =?us-ascii?Q?qQ8yb/yvLoRsBeUC3kS5ASZQGblcxKUqt4JIY00SxRdBLPGl93U5oUcQi6MU?=
 =?us-ascii?Q?d6KXQNe1l8Z3NNbCGTASvMfvWlNSKfLJeKq1nFMCwIiNQMdzvhRjqzSwK6BF?=
 =?us-ascii?Q?AXRAXqEa8O2nXnOt1wwhREAmtr8xQVp19JGKcoZ6DAVjVA3kIc+SNoN1Zek9?=
 =?us-ascii?Q?bRkbr44o69CPykQ77bro248BRM8IMtKFpb+p+eYm47jgZfVVrLvzFARwPWbX?=
 =?us-ascii?Q?hlmdgOCgLPnmsTBtibN4E8BGCeWO3X/rCIQaT0QHKPqSjYc8fxghkT0t94Em?=
 =?us-ascii?Q?idaFOhiAVzr5Hr3knMjBxRm521WvyxH1aZ3dECQsLRUxsyVjncfKmk2QGQHz?=
 =?us-ascii?Q?B/eGRdWOseZYXoFOQ7xWpTQq+nUD8449lX14scCPLJ0LGkrOf9y+5Xnfl/81?=
 =?us-ascii?Q?RG+2IFV46XgkZYyco+iuM2QFeOEh0Xs92y1GZDuc+7hX7sTRnp1h6nnBIPWN?=
 =?us-ascii?Q?Su3CEkasqV/ERibnD4g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8797fd2a-0c49-45ca-bcb8-08ddf745c3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 06:28:36.8352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1Yt+cGWGlKblmKWYub52fs4U0M//7jp370CjQv/an45awSEUTeYCTpvJ8sm3X4V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825
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

>> PMFW interface version is not used by some IP implementations like SMU v=
13.0.6/12, instead rely on PMFW version checks. Avoid the log if interface =
version is not used.

" is not used": Actually, this is used to display information to users and =
developers, not the driver itself.

Smu 'driver_if_version': it is used to show driver source file interface ve=
rsion on kernel driver side.
Smu 'If_version': it is returned from pmfw side, that means what driver if =
version is using on pmfw side.

The most perfect aesthetic situation is using same if version between drive=
r and pmfw side, but it can still work normally even if it is not matched. =
(with limited functionality)

According to the SMU driver design, KMD will not reject interface version m=
ismatches to ensure smooth driver loading.
Preserving this information helps the driver understand the KMD/PMFW operat=
ing environment and detect problems early.
Hiding this information seems unreasonable unless there is another strong r=
eason.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 19, 2025 1:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Avoid interface mismatch messaging

PMFW interface version is not used by some IP implementations like SMU v13.=
0.6/12, instead rely on PMFW version checks. Avoid the log if interface ver=
sion is not used.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h               | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 1a1f2a6b2e52..a89075e25717 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -288,7 +288,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
         * Considering above, we just leave user a verbal message instead
         * of halt driver loading.
         */
-       if (if_version !=3D smu->smc_driver_if_version) {
+       if (smu->smc_driver_if_version !=3D SMU_IGNORE_IF_VERSION &&
+           if_version !=3D smu->smc_driver_if_version) {
                dev_info(adev->dev, "smu driver if version =3D 0x%08x, smu =
fw if version =3D 0x%08x, "
                         "smu fw program =3D %d, smu fw version =3D 0x%08x =
(%d.%d.%d)\n",
                         smu->smc_driver_if_version, if_version, diff --git=
 a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 349b6b8be010..062f92635215 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3930,7 +3930,7 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *sm=
u)
        smu->feature_map =3D (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=
=3D IP_VERSION(13, 0, 12)) ?
                smu_v13_0_12_feature_mask_map : smu_v13_0_6_feature_mask_ma=
p;
        smu->table_map =3D smu_v13_0_6_table_map;
-       smu->smc_driver_if_version =3D SMU13_0_6_DRIVER_IF_VERSION;
+       smu->smc_driver_if_version =3D SMU_IGNORE_IF_VERSION;
        smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
        smu_v13_0_set_smu_mailbox_registers(smu);
        smu_v13_0_6_set_temp_funcs(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index d588f74b98de..0ae91c8b6d72 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -40,6 +40,8 @@
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define SMU_IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9

+#define SMU_IGNORE_IF_VERSION 0xFFFFFFFF
+
 #define smu_cmn_init_soft_gpu_metrics(ptr, frev, crev)                   \
        do {                                                             \
                typecheck(struct gpu_metrics_v##frev##_##crev *, (ptr)); \
--
2.49.0

