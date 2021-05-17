Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7EC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3FE610C9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 08:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3FE610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6BB6E8F5;
	Mon, 17 May 2021 08:39:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441B689D64
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 08:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCNG+ryjS1gmLgiLpuXJHlx8VRBvoagieJXjrHpuOLIS+ZVMb1rqZszFnpMjIgrjDnldgg+wcPYR+yQGflV6/uNyD3iN/2lDixBTddZRoG9UG9TTu9+BaiZP9IRD0Z8c9cwNz187qhJUPLsO9/sKjxeUyCopXUsAYMrI/C+jPeesRlHtZAUFylFDt3ifDNmu/R+2cM2qr5kqDP9qw7AMFFD2u6DLFYMMho7Fv5pqYz34z1/tLap9k7HoKuQ6VY2XBZVAXbOcVybHMo/idA18YO5SM48zli2crpGLNo1ca2xhaLprgIIGUv9A6uKi1OL5s0RswLvPpbGvgzOuQe8T5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX68DFCjnVNY0AmxNgV4oS5r76KEZLUkvEMpMFa8CeA=;
 b=W6KFEvrPWjICKHMxSCm64x5yFYNeJeHiqXfozMOHKh6QcdOwI30TMcVz6XmZdeD1uOuG87xAWOfULOq7Dlu0ATTunnW+Q8vvmvGw3qNzW+hUjxzrQ2hOwoYh0jPMtdvJNruKmm4Xj0+6Pbi1qPkkkvzBk1lO803b9zTQNGtVV3Ajta59P8VyqYnWkklUW9nq+Oq6tt5ZgMf9j2/Z/bWLZwPpHYQcKqb93PbDuaFMF5NMdQsMdWk75U0a0Mm3rdimwkfvIR6jDI3Y7i2/qSoZbOcx3Wn0qxQepsZTlC/IC8tK6i3Q+kdMCuv+hk1+tnKPbPktoT11RnEU+rpGt6Qkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX68DFCjnVNY0AmxNgV4oS5r76KEZLUkvEMpMFa8CeA=;
 b=PAUB+CbJsBo7mfKKFgXtxl1BL5+R8EvmFpVksqvptzf34bfkMMrvljogpM/D/rR5zpX5enL3/a64tVu/1nh+09ZqDp5asle7h9VwqXRLbvuNbKGWRjK1bjjajpVsILiauXie9nM7fQU2Bwj77iLPDowR5dNfFGLW/nUEj+3M384=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 08:39:43 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 08:39:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amd/pm: Add custom/current freq to pstates
Thread-Topic: [PATCH v2 1/3] drm/amd/pm: Add custom/current freq to pstates
Thread-Index: AddK97jERH09djrVRyCiUKAcQkKqHw==
Date: Mon, 17 May 2021 08:39:43 +0000
Message-ID: <CH0PR12MB53485A22A4B6B45A401D4A9C972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-17T08:39:39Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=27a2d63f-fd01-4c5d-a5d2-c3eca2a9928b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a774c155-5e38-4d75-c06b-08d9190f51a5
x-ms-traffictypediagnostic: CH0PR12MB5043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5043C7EE63D856E2CB21A0FA972D9@CH0PR12MB5043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwpjoOkCXFBMVGcWRh3mKfWChwD3tzic7uPiAsD8TeIG/eylRbHsaPXABaCczj3xb+o56cKUnLN2KGNLrXqVM8FmamO4s3yK/nGIl9ar8ANnC/iQD30YIhTv2TotfBobj0hQDMT6uQxydWmxJctSCPEJo+XfRi/t8FKv9nafM+PUTxQlxyO5z47kaKQwEy4B6sKm3ADK3KstlUIUFsrqBPPO2jzy07PeKYSwaHm/bxc5r9kFr5pWmi3yTnLYg/WII+tNpBEy8a8AdhX8wIYXlcmIxaF4MociCoHSSmCr6SESuePj1cOYHy/2UCUXTqW1SQNzu+jnYF8TLx/08ptXCPzAbdjQCZH3YsAE81Y/6ES0wrTMk+E1iwVE0hRDwwJ9/Qg1xNXwwoqs1MH5I+UNUPIL+lHzbU4ch1I0xpLdqNVWY20YowU/e62Q11Y3646abm9fg7VQxis9tdBOIf7L6hjLywKFbyta+J9oZ5HJDuPLqcTXwwSl3K5ixCi5cqTnsdzuYEBQ0PuQSty1wkhNcUtv68N30fs3bk5Mj5/4GEQju2V38nGHLNuVvpPiO24Avu9F5QcOv4/u2FLTM3+QEV7Rfvv/RtjSTyLN9QvNAok=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(83380400001)(86362001)(38100700002)(26005)(122000001)(33656002)(478600001)(71200400001)(8676002)(8936002)(4744005)(2906002)(186003)(7696005)(6916009)(66446008)(76116006)(64756008)(54906003)(66556008)(66476007)(66946007)(316002)(52536014)(5660300002)(4326008)(55016002)(9686003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZyAS3ph1M40/ya9pbmyaNELb7SPGwNPfrZ2fCgoVvNvyzbwD46LtKEUnMdYH?=
 =?us-ascii?Q?8/1tuWmZHew1+Q+krOB1lfzuUFJw5Ai6EEdrGJtkyh7CmF6IYXmJZvqPT/vf?=
 =?us-ascii?Q?9LheH4TB/9pmksZYbB9M8cXdJrAxyxVb+Ej1w/tiOTs6raq8xBOVGJdqYOay?=
 =?us-ascii?Q?qohxi8tDgZ9b+67+sTPnDb4J1BZQ3q1Jsec+h8hwYyHWSPA2fijRwqdmBVkL?=
 =?us-ascii?Q?em7FbCFIYdr05U8u+d7D1eAOCoPOpG+MOroiRtaD/OfDwSgPoD3hF5eGYe8Z?=
 =?us-ascii?Q?ETaGtDtLW+y4u5xgjevlEijy+WuRLjX3iGUA4iBSKqnLZKPV0FyLMlteFll0?=
 =?us-ascii?Q?NZkmhOo1VXiwXJCg9kPqF0uahD2qa2bDutta1r6UDvyRm5ttvOsygHwYzW8I?=
 =?us-ascii?Q?A8Ki4LBWdqpyOF+prPVN7wUqWmaNzXNFFdgKJyGMLg3FtHv36N+lrLE4Br56?=
 =?us-ascii?Q?hfLip1LsPVmHqIOcdD1d1qxAfOwQMIcBcv0oTjx6QiVdo4BNKxPPhsOca0Av?=
 =?us-ascii?Q?1qoxZoyHudR1B7EUtMSsRjuJ5YNI/67wttCBZFeXFN72Alm+JC6F84FrWO2I?=
 =?us-ascii?Q?5c98rKs6lDTq7idZDKv+89oZ3iLXf+0EYS9EKTGTKG/Qyuk9t69labax1Nnw?=
 =?us-ascii?Q?4ezUdhByiWqbWwdPW0PbByAEtGoxppc639aNapaL6dcJziehkbybdtjmfjeK?=
 =?us-ascii?Q?9O2TwVm6LTL2Yo5vccd3tyG6w7bs7+kfL5saT8xkBfclYLeknswD18d7J5AB?=
 =?us-ascii?Q?B5Q5lpPnyBMO3oK8qPtqh/B85EXGRnpNdR7Cy35SaNF/LZ2wSPPbR9c6Jk6e?=
 =?us-ascii?Q?zgqlj2yYUnyavLH3vQ//po5Xp5PJmFhGn/bL+TUJg2s2PvATMYslCS0TENdN?=
 =?us-ascii?Q?+1pel6AA1Zm6367GjYrQMcUyZtLQBIQTPMI2P/dy68IXD2MhwvjQhmYuLdlI?=
 =?us-ascii?Q?6/I3GYdHVOIdnedCMj3CaGZKTSujR4fRXF4q/wVV+zUAG9qLcPQbcRwWyrl6?=
 =?us-ascii?Q?1GjMI7Z2R6mURdUGNajy+Ot6I85Ot8EE1iJ6d7mHQeV0Jg3DGF0FHD2zbwZA?=
 =?us-ascii?Q?Z/DXCrkY/nUE9BmdsCi24xFLfOgh2Pk1vMyO2wBBCV8UXe8YVbrFq8l6P/HJ?=
 =?us-ascii?Q?7CFE0kH4CIljg4NVlLtKAb5/6tpIsJ7GraOqeglsr5hHhyyRnWCA/WjOcsOL?=
 =?us-ascii?Q?pvtTpbttV5xMVn/AWi5Vitbz4CUdvWfCwDMeX/H288WIdVEUU2QVcC6GSB1M?=
 =?us-ascii?Q?+xozjKVaLwjl9eTuiyyeaNpboOQbWYBUe08+3myEuN/neZNWAg/GSu2Tp64D?=
 =?us-ascii?Q?nOvcZSOWWeIzMrV3w1/Xnz+m?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a774c155-5e38-4d75-c06b-08d9190f51a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 08:39:43.2805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NBj+8AG0U6bfVA3K5SN+p3/wVfFqN42w4Bzk9c9rD66EXMzuwn6EeGD1Vbd4YC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Add custom member for user requested custom frequency, level mask
or min/max frequencies. Add curr member to keep track of the current
active values.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 8bb224f6c762..76d670bd6440 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -392,10 +392,18 @@ struct smu_baco_context
 	bool platform_support;
 };
 
+struct smu_freq_info {
+	uint32_t min;
+	uint32_t max;
+	uint32_t freq_level;
+};
+
 struct pstates_clk_freq {
 	uint32_t			min;
 	uint32_t			standard;
 	uint32_t			peak;
+	struct smu_freq_info		custom;
+	struct smu_freq_info 		curr;
 };
 
 struct smu_umd_pstate_table {
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
