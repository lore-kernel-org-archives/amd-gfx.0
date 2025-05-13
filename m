Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B32FC3ABC3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 14:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2163610E209;
	Tue, 13 May 2025 14:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yAUrVAsz";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5030410E209
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 14:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZTfvC+uIkz3ourd+/XFx6JZKUwJh6y/tqW2Mof6VumZtzvHEZj4Zg92b51b19yMdUc1qCQNQoYyksXw0TmRzvAp4N1ov9KWOk33e9PwFa6yM/+OdrOUZ7Y87bc389hnczZwDoqLx8jtBj3ePfMu4aVe5ysMoaKRRc1bVQDqfrQvm8YEgNQikdYbwqvcM2gUcVDlTcpmYBU8JxK6W2QOfE1oQyiaGflHWI9wXpJS6yel5qKJ9RZfLsVZHquiq2xtX6ygQTnS8rVEyTaQiTvSSES1plMdb8EMzaLAPKeRgaZvZryq/m42vZYfaNJuZjNsmOGTrecOMf02FpjhORlNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc4LqK+bXR7dKXHP0vbs5DjXabuyzxW6/ZSvAJG7mRE=;
 b=AwsXVdMwjJRlNqA8YnH0Te2SWS7HfCf7q8gFAUSBQLouJOv7IMsPOEplwDMrhVDeMZW+02ODvJo/Xw116D0gQX+88hsYN8y9/XwnyLEMepkGCyh8Xa/BKbhIAiSY3D3gjaxAjwx4RetCvq8EL0MFWsZ4Xv99+mTQqtWCW0hf3G/fovxom6acIVJAqzpUSBj698nUhUKfzp2Gs0EA0fcUu8RrqFInU03doASuLzPR2RoCKYyxzOsnafW9iSjpr76zXdIJ2HZzUWEaWD6Rtu2uL7nUuwEfgUMcD5Od+C/LsObvEnDeQzCE1YobQmOIf4rUggbSGwiN71pDWrnDImxrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc4LqK+bXR7dKXHP0vbs5DjXabuyzxW6/ZSvAJG7mRE=;
 b=yAUrVAsz6V2ryu7YEW5EDlviAP5n95uI2azSkH7rZAtSpPcfSH5+tOJDW9WTl5O2jbocmg8XewNvZrZAvYc1o8pQ4iS3m9K1Ry7ZZ0bf2/SK6YcK0g9h5VsrtIQk5AWjPXzi22g3rDDbI/9dypoatiM0m/nsZi5lGvwBXB8IQ/k=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 14:23:07 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 14:23:07 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Move SMUv13.0.12 function declarations
Thread-Topic: [PATCH] drm/amd/pm: Move SMUv13.0.12 function declarations
Thread-Index: AQHbxA31lwTQfnXhSEi0+8RinL9gF7PQnOiQ
Date: Tue, 13 May 2025 14:23:07 +0000
Message-ID: <DS7PR12MB60712E5C72CE49AF094A8AA78E96A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250513134953.417516-1-lijo.lazar@amd.com>
In-Reply-To: <20250513134953.417516-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=be3fce4a-d8c1-4b12-8fdd-35e8217468b6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-13T14:22:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH0PR12MB8824:EE_
x-ms-office365-filtering-correlation-id: 4f788be8-7314-446f-f310-08dd9229ae6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?UVTd0Fm0zzgckI/kVg8l+nqx1I5xbmQKz83UACM4k1RdSzAuBPFVeaWg228q?=
 =?us-ascii?Q?QRn1F8JcuWBXuVsWux3uto09QCYPD+Mrbt1Sueq2C0QqqEBOPf2Zx33qWS9f?=
 =?us-ascii?Q?V41XDNPz7RWcG2uKbO9uLDcK3Wgn7d/mL4307uCAwia1LVFBuSxMl1JnwnLQ?=
 =?us-ascii?Q?U3ftPrD89lv3HryNOhgrNn8IHcp/tYLMZLzrkBvLkVIn5ehqlu+5jaBZsKAG?=
 =?us-ascii?Q?gpejMSxgeyRv6Ltnf4M3C04kopatYbXdZOfqlR/469W1FdRdRhcwPISRAiKn?=
 =?us-ascii?Q?pNmu77LAOhQTgHWBrf1/+MQ0AdiR6PbJc5xmK8UtiO91wUIDQHq8VoOMY1ky?=
 =?us-ascii?Q?BcbiPcMoV5U10uAWELrfEz69g/FIC61a8CwyfJT26sN6cHROFTv1sXxSQjGM?=
 =?us-ascii?Q?MsFM7QYn2pwgNdddVnmOgdxQxtS6C+oqBD0I6Bak01rb0fyIqFDkyx86jSGw?=
 =?us-ascii?Q?Qc5pkGpTl0sjm9QNLTibdUHf0xmN5nWYt9d77NQCT9vTN4crcJwwmC+Pxnbe?=
 =?us-ascii?Q?Omt/0wZ8Pt+RU7fumUMDbYy8faq1tJh9wjkZRrQqt5aWyNGAgMkcQE2W9WLn?=
 =?us-ascii?Q?5xksCEJbAGmXSGRyXeukg+GoooVTpPwyVzsKc+aub9p2pKsWjgLSWKWKn7d5?=
 =?us-ascii?Q?I9n99g1vDf+gKDnWsA3nQk8Isvh7bxcaYDCsNHJshLU2uIxr2v9JXjp1DT9Z?=
 =?us-ascii?Q?/kA4MHj3jNeOl6Dj/b+kK7HSt6l+qlAwhAlw38tIvkMYK026vOL4GdWFsHul?=
 =?us-ascii?Q?/oqDnCMYzdHip/wNyIxCRhZWEa/RgisUG8rYbaFSJaKEZ8v126TxLNbgfjfQ?=
 =?us-ascii?Q?oabyBc3IrM4lzodrFKjDcEILZMesShpIQQ/SAmmsqYvOt+VQT4U9VRf7RLuR?=
 =?us-ascii?Q?dWjdT8Q/retQbE0x9/d59FNEDoc4Y5GbuasH+OYJ6oO9oUn4MMU7VgWcmkEp?=
 =?us-ascii?Q?b5ZoYDjl57Z7NI+164LIi8/0nhznQ1lXGHtPhtTB2C3G5h2aj41AspKJKfUM?=
 =?us-ascii?Q?HrMDbV+u/f0HmU/u/AfjsA/2QcXuv+mF58jXwft6Yaroj9eiNe/Drg/7C1bE?=
 =?us-ascii?Q?N7YmrsFXsHHWZHeeMG+Ozq5S/ExNhDh6mO3fPyIMs/C34DPFWFRTCuGxQigV?=
 =?us-ascii?Q?KR7LEFmf25Ppmy/mAgzdFpUQEUzLGsC4d6k8i6MXvh+Qk3CFBX/sAdAF96Qr?=
 =?us-ascii?Q?/f5zyGqA2FeFos7oP+J76joQWanwJk8f6GBkmvjlsSNY6rGh+4cgBy9iTQ9R?=
 =?us-ascii?Q?SiDS3J2/ZiM/k5aLpXzc3BZjCtsmYWi+IZVdUZWfFt/d1XtCxEmOMECgfm5I?=
 =?us-ascii?Q?ST52I8MvGWjS/xkHCrfGSfzoEhBTriWiWbJdR7k36LzFy0Hz56dshZfomB5c?=
 =?us-ascii?Q?gkuAu5hG9MD7qPuaj/IRbCWewFMtxOuZsQb3l4rysqAXcI5ftavW7flyY8/T?=
 =?us-ascii?Q?rtKZ0PxJmz/qGAwC00nQK/g6fFhOLxIwIJ+Um3LUzdbm6x9AetqyuA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IoOqfZls0LN2o/8Dmh7YhAG7yBR2+pInlS4CaMmRcE+Z98O0H0Bi33v1U8Pw?=
 =?us-ascii?Q?hCzt5ZPitDaFq9o/wyDatgr8XKXYbY7KMCpa5L0qgWJ0T9e/ZgK2yPA38YPM?=
 =?us-ascii?Q?1hoxqq/YMaUlPO4yocw+47otgj2Lr8LB3ddGUCiYvvYXIx1C4HQJuDH6vpRB?=
 =?us-ascii?Q?t8VyfofupNQGjlsYLYdHE7v/eRq6Vo/Iqs3IMKZpgSZtokBFFhKn1aesu9bq?=
 =?us-ascii?Q?hKMrvXyIIKkX9tiPI4kkEcI9kf8VMiffgIRAnh4xPy/m+VE5JUGsYS5aaZO+?=
 =?us-ascii?Q?3LxcKbv4ZHMfMBuHP0E22nhSA+X280U3MS8G46v10sIKyy5040GzaMCWdMgw?=
 =?us-ascii?Q?Tc/cDYDWwVIXqcDDYE6KiD1fIdD10HBOK1u17TSGuRZGQavlKpdT/onCWJdO?=
 =?us-ascii?Q?H9cGo9QoAR/cpl1JEDct6BY9bPcfMH7U9vKuZcSvtxGlKmF3EnNdAxR5f0a9?=
 =?us-ascii?Q?SXLoFO7+qOjgvd0Mr8cHw7Tq6QssKJP6P09khtdwghMSJBZHgHn5CF7GKWHa?=
 =?us-ascii?Q?LnFuihniTkkFDOfN+YDMS933sNNbd2IZ/29L0HAvlF7XvXeMY6lAZOJPH4Gv?=
 =?us-ascii?Q?fD0/Py6b+HZ6gNnaQwmYWNDftzaH4v4achG95TqPlPahQuNyOqrbzPnLqK+L?=
 =?us-ascii?Q?S9ieAXyzYPBW2zcSgk4dJFLglx9iSzaiRu6Fp3B3H8w6ABfhgUMHmdaeC8xc?=
 =?us-ascii?Q?Z4R9DMcEN3evid/yRAU70bbf9aNADrEI2PUyGNC1104jdRDJJyiiUWbkT/MA?=
 =?us-ascii?Q?LLVz/jZE7KMwacbke0vZ42GUs4VDDEaSa10I9lihzzgNiE046VRTwBLvqOsp?=
 =?us-ascii?Q?nK3z39F/pnlq/2ojLyZdV6qKU6FuBHO7zChGh24Ivt1r503woFeYx/gFr+ds?=
 =?us-ascii?Q?4mf99bB9MynWdQz/qziJVPLd0P4yTLAKw2Z2Qu2jCH04Kblhv13G0vbcQ+aO?=
 =?us-ascii?Q?2gPC5GmkjwtsA/RXjzzp3P+PTo8xGP1eyPDVHbBNKB58kDnuOcTWkxQiT2rF?=
 =?us-ascii?Q?zGtj9pRwECKp68H1f4iOS7HL+RDzT/6VNCl9zdYz7UND4ctLbhCUgi3CO6On?=
 =?us-ascii?Q?3tSJirsnVhuQQQL3n2wwld3qn/54GdYBsrgm58s9Jzu5fJip66GjzlfNSilE?=
 =?us-ascii?Q?edJtEInORfo32nPALRpxblBi5PtwsHndEDXfwncznvvvCP7kmK8dDjhlw6pJ?=
 =?us-ascii?Q?b5yB7oZKzUi57aYqrIgI5SFQXk5czBPrmR12+970wfbwizswZMQv4l4hH4aO?=
 =?us-ascii?Q?awm/GK0iA+V8lHMW/NgpfL4Kb5PMpxED53myovksJB8GK+925OnLUvzPE1rU?=
 =?us-ascii?Q?dzuPYSuRA1xuMEqv4N8UY0kTOjMMrpyP60rImBOOr9ceOHVPaNTnb+Y5xwIh?=
 =?us-ascii?Q?OuMRgEP+A8NmfUpnsMewu9i+dL/UAF62JdFPLFSfHypYDQ0Wd6fatKq7qogC?=
 =?us-ascii?Q?ZDBNfVMzf9v7jZjowLYPCscrrOs8ZFeCyM71WH0IDcIXKJaeHupyqbfobppi?=
 =?us-ascii?Q?UWw/aCI0WFCi7M0LVX2/oQem+E8DkUxMnwpi/dnyeutHxzKAXQwNiyPbrgzu?=
 =?us-ascii?Q?lpN6CdvXUM/9OyJWkvk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f788be8-7314-446f-f310-08dd9229ae6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 14:23:07.3685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DA8faQi0zpet7byLjPEHCnHm8gc/AUYYLAnw0Ckvg8JO0tF/yy1+FF2VgzN/Ub5KcGOTmoBjYoIUrABc1EGaUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 13, 2025 7:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Move SMUv13.0.12 function declarations

Move them to SMUv13.0.6 header file as they are used only in SMU v13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         | 9 ---------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 9d4cb54a45de..4263798d716b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -298,14 +298,5 @@ int smu_v13_0_get_boot_freq_by_index(struct smu_contex=
t *smu,

 void smu_v13_0_interrupt_work(struct smu_context *smu);  void smu_v13_0_re=
set_custom_level(struct smu_context *smu); -bool smu_v13_0_12_is_dpm_runnin=
g(struct smu_context *smu); -int smu_v13_0_12_get_max_metrics_size(void);
-int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu); -int smu_v=
13_0_12_get_smu_metrics_data(struct smu_context *smu,
-                                     MetricsMember_t member,
-                                     uint32_t *value);
-ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table=
); -extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[]; -=
extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];  #endi=
f  #endif diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h=
 b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 6e7293d3f264..1ccc150882eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -75,4 +75,12 @@ extern void smu_v13_0_6_set_ppt_funcs(struct smu_context=
 *smu);  bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v=
13_0_6_caps cap);  int smu_v13_0_6_get_static_metrics_table(struct smu_cont=
ext *smu);

+bool smu_v13_0_12_is_dpm_running(struct smu_context *smu); int
+smu_v13_0_12_get_max_metrics_size(void);
+int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu); int
+smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
+                                     MetricsMember_t member, uint32_t *val=
ue); ssize_t
+smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table);
+extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
+extern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];
 #endif
--
2.25.1

