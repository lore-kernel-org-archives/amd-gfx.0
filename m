Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A40CD98F0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 05:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70AF10E952;
	Tue, 23 Jun 2026 05:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PmUw6dQZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA9810E952
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 05:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvnKpHrtiCweoD0jSXDnT6vBI8mayfzB84xUDbVngcwHc7oNxGyV5EvvoYzYERFLuY2oBtwu9rs7XI7duqJcHvvnM48e8t9/sKw2jGvuxqdmal2Pb1z66v8H1o++hYXKuh+69hAvQfR0LRWK1fV9b9VY/SFzfzwmfyTCyILaKqWUiaLNc9mq8gCxC8TY1K+UX5bG4RXcQyWyc+9E1Sz6aNoJPcurKNhlU3jAuEqP/Vy/neZtQEdboAvZUvAmqqaTkGprL5mMubj+9qgK3YPfST7uoIS2xWWsFLzY9Jp3/H27NK9MobCqkmDNGMY09jO3j8p4d5DElNPBhIa23USxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5aolyKWqaAfsqEL5dfsxyGQL+Lg5+m1Q+dtDis5QEQ=;
 b=tekTdN7wZVzbBbFXp7mrWZJ+QJlFEOq5MSd9D1zXMI7c2QHP/sis2ct1mbr6S0FCPInoWehqP0ACyYBEVZcdLSx+kFtclEEyzO3fn4v2ehfqhmZgpoRFKE1gYLA7VPhtjtnTJyAVHbw9lkRWavrmF4B8/qTSpZeTRnvd8Hc/nLKYCqXvcjC1kePW5VPGoegQMnuJurW5H4icE8QpE8zUyyuf1SIgv9ae1wKH2ddLa3cCpOMQLa7zZgEQe3QREPu1ZcVpSeVXX8EOEL33xplF4Z78fLmkEW+SMLIEj5B1nGQEXyWhrvsr6f/b5QX61WyfU7oUzREZxlUtx338inqyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5aolyKWqaAfsqEL5dfsxyGQL+Lg5+m1Q+dtDis5QEQ=;
 b=PmUw6dQZ8MxSpV7fZFensWR0TKB3zgpmAiG7ovuy+KUXlM9bcj8630BgVnJPjKnKgVFyDLTDTARVR+txjt+rFnGQGuHv0pv1JsjF9FF0t6Yfc2eiSWDKh4gbRShsht6o5SYI+Q8wUiHcKLGQILbFlCY/Vn0QUDBzivOgTCKY068=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 05:40:29 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 05:40:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/5] drm/amd/pm: Validate pp_table header before reading
 size
Thread-Topic: [PATCH 1/5] drm/amd/pm: Validate pp_table header before reading
 size
Thread-Index: AQHdAsJGwofXsVwBKkOcnOazrVm9c7ZLlLBw
Date: Tue, 23 Jun 2026 05:40:29 +0000
Message-ID: <BN9PR12MB525743E4275B69416F99AF3BFCEE2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260623034151.263746-1-kevinyang.wang@amd.com>
In-Reply-To: <20260623034151.263746-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T04:59:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB7685:EE_
x-ms-office365-filtering-correlation-id: bdfe4b8f-64aa-46be-1bbd-08ded0e9ef3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: GzeCD3/EZtNE7tWULTkDiG5FY5riFzpQJKp8kK/wDBn349udgpxQu+3R48vEvhMjgWwcRi0FlIb0Dc/iKmVwQSy689e/YYFNXop4WMQfW/aaix0ZBotxpmwMZSu8tcweJN1rCG2Ue30pCOV49iK/X54E5vuUucLb/B5esHr6Rpi7yAvyP+u1lizjujg9B/A8h1RaNbL4PgvwDWFOw5tYBt6PMUxm7lnWIbTTGpSPrXaLH77CDCQ2TlIF/t0wdx4EyuPAjD2arI66NuBzqHDiMxQamGL0UlyViNbQpdripMSWMC+RnrT3iCRdnbjfabq0Nd6Vv+94ASe4pRbac/M/iKUZIHGAY/qAA8VmXfuFZAJ+ckNE4lMj/JwY11z/zPPhl/UoMeHnZfQLBF/WkWmIuQ2J7UnS5GyS1OuNVHD/NssYw/8+etApDIBng3Q1Q1himOAF68U+iQ2oVJR+eMCylI8+SZweUNU2A0gCY6ldr8Z9kRBPR5YeEg/bgP91F17OHX6YVmQFJSteTl1DLmLfCJvDpgsWMO/sxSoYv390VU2Z9xxDi0VMUHJNhKwC54QboiOh/ad0RYacyVCL7gF35lN1QLhllGjCmhMcSMPuTcC1gRU0En5nrCcowb/AFSpq5EAngYSPNQaBegWDURj7XoR5McvftEx6cG/AMKmMDDlCL/SLihKL+7h42ZJavD/QeQUJ+xRBAP7Zl7Q+FSzTLDQY81/dv6pbDrgqOQuXhFw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qskYP5u8JJTl5j5cbR6K0zbYaon6Vn41sJg4x7puDQ7Rwzd+12Wzxxu1hoVY?=
 =?us-ascii?Q?poFG/yjzJBA9yH8aFQV5ykvZJfbQiczcLa96VwiMvRZ2sL2NDu2V83X8chPN?=
 =?us-ascii?Q?u7OT60IX4Y0bkTiODTjXXSbGNjDd4bb8gDFcgTwKcnFKAB7QjAgQTRtcRKCk?=
 =?us-ascii?Q?ionWPnzFSmCqssYGzW6XBAbkq0HhKTirEG7LiMEMdikiYFRhDq7bbLuwtqds?=
 =?us-ascii?Q?7SfHib1Jm2+5FtX7Ag/YLM93olm85wJjyrYFD683vlq0zLSNXYHLqBb/8Rd7?=
 =?us-ascii?Q?hoL7HIQoeArTWimA8S3lxpH7FLKYisvkHYe1o1LmhD5LM1eG7I6xEEFZq2Sg?=
 =?us-ascii?Q?wUuErUS0Wg9EHnywMxW0dWBHVWOEzuCHq6qbc+QKbWR713eqRN/MIOc7yHlV?=
 =?us-ascii?Q?iGRPAG9pQhnvX42mV/Pph7y5BO4ac2n3MVb7r6sMkaMW4pHr6+V4VGD+v0rE?=
 =?us-ascii?Q?QHxpUvOVnq3UKOw12ei0FrYjagCvTpD7as3sbSks/70gxRssU/h3jFpzwL4z?=
 =?us-ascii?Q?X8R6wBdHKRRZcCY+tfLP6KgKUCxsW66YVm8bpahdaUVVNyVcoILm3J1SQHDx?=
 =?us-ascii?Q?F4t6oJszlCvhVUOqGY5iFJRHz3mg/5We0hFREMeoCGjy6WK8aaItVZRTn4E7?=
 =?us-ascii?Q?B7chfE4SbYd0L1vFjTTL7MtuEvBHDPDx+JaK3erlkqW/dUGmUqBYv3CloyqG?=
 =?us-ascii?Q?XsYF+7vfalHg3tUYmZa/Ii9csh8QYw6afImYF7aKOYwhDhI9t7bdy1gz0Brp?=
 =?us-ascii?Q?WAUDBSQ93XxQUENzxmt8SeWsLNJRMQVQLWPk3rFwjcoR8WOY8mKPWG8oI30M?=
 =?us-ascii?Q?LdHxSGDgFx6np4qIwmney1Wg0K+WPdqzMDCOit2zYwH+j9rW9SQ+Hzm0pYHe?=
 =?us-ascii?Q?z9ZIR9EXOHa2t2JgguxHt6glhdLakSaVe6usB9uWXzryX5QIha+Uplu/JYty?=
 =?us-ascii?Q?12K8VGSs0bkK4mCbukYkm4WZKNFe/7xHNiFZ1ZFrOGL0pdHDW809W0ZkNtSy?=
 =?us-ascii?Q?38VreOEr1afs2GOUTmu+phDeyCEBEdyuLkm/2J76NNveK/CQt3SvnM8E28uH?=
 =?us-ascii?Q?V8POuoFDV+5dp0Srsr/8IEFcDSNQ4As83IuqqcNqFRYP/VVuhqowfe38G3r0?=
 =?us-ascii?Q?iXNWkxh7A9k9gcyvs/wn9UiCriSXcfuU1q2TgOErx+ts+NIGnn7Y2JQVBJqI?=
 =?us-ascii?Q?B68GDXHzXmh8mNm5NcQlxQFrAfKy/XT7i5s4qiA1hVRh3DtAcHeGMjDbEhab?=
 =?us-ascii?Q?yiX2dmb8dr7221kkDsP23iclPslia7T/t+P4A0TbAYZWnD71IUZbb7qxHSua?=
 =?us-ascii?Q?H0kq5zobHd/+sJ8b9LVNEL8HE3gCrWPKSHSyw/F6kTQjrDbAVqTsMxD55G6d?=
 =?us-ascii?Q?a1XXVSXyk6WI8Ggi+5cHmX0QE6iZat88iD7EMrUp6upxzmWiM5Iyl5Q+XHuO?=
 =?us-ascii?Q?uBGFF5/2TynlCK/9LzDW9XPgza1fP6fbwC2h7nQb7C4rMJoZWiDd77kPWmBF?=
 =?us-ascii?Q?e0kCurOQ85FLneXJlXu34mxcUCsSrHaYji4okAs+6oXjg4Z8Qyx9fbEmK6At?=
 =?us-ascii?Q?dF440211Ddt90wAFhkkKvo7P/AaghK4zLFUTi8vSO6QZyDhhyODNpoONdrS/?=
 =?us-ascii?Q?Pp1Iy2UlXsJiA1uZqqRJ11Dk5znfBFlGNu1e1z7TT8XD2ySUtLhQdBqbYcs3?=
 =?us-ascii?Q?30Co6GZnzrs8pt9K99wPC+3auunbDsl2kaUYB3ivWrfB2B2z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfe4b8f-64aa-46be-1bbd-08ded0e9ef3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 05:40:29.2347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfqeMKjh85FleErnBv0FelT8M2E1EwBCCuognV6BywVYb4WmSVjVWL2Vq+DZfSjcW8dYCKrElipsBIblouCG0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, June 23, 2026 11:42
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: Validate pp_table header before reading si=
ze

smu_sys_set_pp_table() reads usStructureSize from the uploaded pp_table buf=
fer before validating that the buffer contains a complete ATOM_COMMON_TABLE=
_HEADER. A short write can therefore make the driver read past the supplied=
 sysfs buffer.

Reject empty or header-short uploads before dereferencing the header.
Keep the existing structure-size check for the full uploaded table.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index d809487205a4..a6e451f1fef3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -667,25 +667,28 @@ static int smu_sys_set_pp_table(void *handle,  {
        struct smu_context *smu =3D handle;
        struct smu_table_context *smu_table =3D &smu->smu_table;
-       ATOM_COMMON_TABLE_HEADER *header =3D (ATOM_COMMON_TABLE_HEADER *)bu=
f;
+       ATOM_COMMON_TABLE_HEADER *header;
+       void *hardcode_pptable;
        int ret =3D 0;

        if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                return -EOPNOTSUPP;

+       if (!buf || size < sizeof(*header))
+               return -EINVAL;
+
+       header =3D (ATOM_COMMON_TABLE_HEADER *)buf;
        if (header->usStructureSize !=3D size) {
                dev_err(smu->adev->dev, "pp table size not matched !\n");
                return -EIO;
        }

-       if (!smu_table->hardcode_pptable || smu_table->power_play_table_siz=
e < size) {
-               kfree(smu_table->hardcode_pptable);
-               smu_table->hardcode_pptable =3D kzalloc(size, GFP_KERNEL);
-               if (!smu_table->hardcode_pptable)
-                       return -ENOMEM;
-       }
+       hardcode_pptable =3D kmemdup(buf, size, GFP_KERNEL);
+       if (!hardcode_pptable)
+               return -ENOMEM;

-       memcpy(smu_table->hardcode_pptable, buf, size);
+       kfree(smu_table->hardcode_pptable);
+       smu_table->hardcode_pptable =3D hardcode_pptable;
        smu_table->power_play_table =3D smu_table->hardcode_pptable;
        smu_table->power_play_table_size =3D size;

--
2.47.3

