Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824A5C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 03:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010A961139
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 03:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010A961139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD0F6E051;
	Mon, 26 Apr 2021 03:45:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEFD6E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 03:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lykTKsgRHlUDVfwPleF9bJ32RNhfyD+9mAFJTTCcR0JHPPNjxna7d4otWgyltjlDEm7c9JVe0sgQzygthf9u6TW9f6YauHC5XngFv0PfaSUoojRWFGyc9E7nQI6S4/+kIdWZ15nHBvpmyXuOa0JrFeLlXsEuQa0mlmR2PhBY9D60b0Uxe4mziXl/lBl/APQ1PLFbyt4fQVp/jlaNEdVFlK5FmuRIrRzbpLaWriCIlI+Zzt0R4dgEQjYVgs2KK9OBNOOVdmH1WujoabqBc2LX+R5f8HxQVpOoi8bEXB0kVwDhmdvTnTRnAz+TDSnU2STIdar4RRy/vvQ98CISv/c26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBaat/GCzdg/z83uD7oL1e5KeYHAtNvGS+JF70P+Zuk=;
 b=iXX3DH/qXeOIFJTZf10T1sox1MFhvjq4+Crsrba7iIC4yebORbJ4XyDJtDdo44uiQJSmR/Z89lAoIw/6nV+TgxYNzxB19eSjMWI8ssEZw135MQNl2lYLopzJrDzDN1nYxIFbroJD9rgFdnd9oKqyGyz+HPH/i/GKhK5e0SuHWUiCqj8ifuywwV/RZ4embrZYIacNKgNSdLbPXdM/b8hI31Jwe/jnx7TGraFF93h1lQUVUi3IMWTUjU7eUlwj9RS9zZvHLYHhVJGSHI5F7PS8KkF376rE3UkUccBK/h9Hhj5ES9yBsOeZ19tQGpcvdSPT8mUVEIaIOb/Yr5djZ6m55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBaat/GCzdg/z83uD7oL1e5KeYHAtNvGS+JF70P+Zuk=;
 b=VZQqpS5Ofyy49QZc+UaSmEFfRWqUndTXmT7ItwCAwqPD4Rnr61EHs9HknCbHIUQOQ/P7jCx9cqce1RXjjh8OJoTMUNo4bNK2cUI5rSDSIlw1blOn2mjNfO3oQ2ByH9Bq0jd4Ut1Q/zWweAdNxo1LCHj+cDahC/EXHNMJ9BLr6Lo=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5209.namprd12.prod.outlook.com (2603:10b6:408:11a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 26 Apr
 2021 03:45:09 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 03:45:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Correct and simplify sdma 4.x
 irq.num_types
Thread-Topic: [PATCH 2/2] drm/amdgpu: Correct and simplify sdma 4.x
 irq.num_types
Thread-Index: AQHXOakJlFgjIWJuT0e7rZSjGTZyCqrGKZEg
Date: Mon, 26 Apr 2021 03:45:09 +0000
Message-ID: <BN9PR12MB53688F9387B40B458EECBA72FC429@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210425075955.49499-1-Feifei.Xu@amd.com>
 <20210425075955.49499-2-Feifei.Xu@amd.com>
In-Reply-To: <20210425075955.49499-2-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-26T03:45:05Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f490e288-a967-4975-b374-3b4b5d441acd;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e82cd7a-a378-42b3-a7c6-08d90865b0aa
x-ms-traffictypediagnostic: BN9PR12MB5209:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB52093659DE8E7A6E28E0A63EFC429@BN9PR12MB5209.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DoJU7V9BxRjctFJtlYsuCK1JEWaPXwcAxKcSeEo3KGyB4+1UHB/pD/aRTac1pGhhvK1s/CH5t7u/x/O0mYaXfrC70eNDjmJ3q19+Yv6NkcaRHEo1QRwEN9kNvJMdPuAX2X1FCMHtvvUZrxbh5QNUyEbmOWIKA8Fc5k3ac6M3Zo1HD/3fGAInCTvaHH/ApIYnYXdCyd0vkAVSLiychTC/MiIhX1uURSy26Iqa/zmziC3f/t39Ac7U0ClENLcH1OOxOns72ZCsIP3ArQIiuGUEtLYEWDLWbHNmrgXnT761vvC6G29Jr61qRnCbFOrKtUzX+IAxJOoGYzdDxAOJJ/ImPw6SxLHvRmQ+Vv/aSEYnxLhVdCzmYUJjedp80EsVVEFflf7VVsb8btJa1aJgc50gcxuUU6MjvuOQdbQYrVDDkiTuf6I5eWIvVD5xInp2OMNOvX03ckyU68yKUcReMEFkUtsR38095fVOG3vuyc3ugKEL1RvWGAr0s6NF1e+oVO9lztTNPSOKvYEfm4U5SyzFLGEyltXo3ZZXgagswvSEzFZ3xyKw4GzDK5bWIZn5cuJjIt6akWjzuTkRlzOjCRkGk8WqTUuqBnm3fRT+8dVy7a0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(83380400001)(9686003)(26005)(55016002)(86362001)(5660300002)(71200400001)(122000001)(4326008)(6506007)(52536014)(76116006)(8676002)(66556008)(38100700002)(66946007)(66446008)(8936002)(316002)(2906002)(33656002)(186003)(53546011)(66476007)(7696005)(64756008)(478600001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ThuXH1zhKu3p+yjQCl9I2f7vMpUq+JBKPSa5hI67UE4lX7i5VZH9zf5EcjUj?=
 =?us-ascii?Q?LdmcMohpRlnJJKcmcAqOoNcTXWB9uQX2xb7//8uJIf22ds6ch5SsFc9EDFnM?=
 =?us-ascii?Q?7KqSCBb9JqyT6AaFBc0IOcI8bzhp2NT59NQZM3Szhxb/qRvESMpBBkcT7Efh?=
 =?us-ascii?Q?2kmHHUQs54YOcOKbPZ46Fsx+G2Gat5e2u/S7kqsypvdNdBTrCbCZwgtBlZsp?=
 =?us-ascii?Q?RSuLr8p1/Wv0Avl2zbvkZz25dI9mE15ywMMgS58BLCSSl64EZYYDhLTcqA72?=
 =?us-ascii?Q?zkw+sQPv4sXzI02yD4cMWfLij7uQBfTNBqi1qt+EJT1CjVPTrfsz7AYiGe8h?=
 =?us-ascii?Q?ICSsUJa3Zq6L5jPiVlZ3sKmDmZrA9IPZwboPhfzavj5NAqVnu1o4bsJnvDLH?=
 =?us-ascii?Q?AADEEmkTsefqCYnO+sIAFjX3qpqa9pUUStSCdtX0edI3GxWMAbYrzxPFgcta?=
 =?us-ascii?Q?cBkS3iXW6MScdvXsqOOruFGDFphXSh0Rz4GorqtIXV0tio+nyVz+MFqf42a1?=
 =?us-ascii?Q?Me9wB7UCc1I598mrflWoPpnWixq5T8b1MunMK1/yqad9dD77GOqPhxtkFkpK?=
 =?us-ascii?Q?Yhze26FUgHULyYaeOlU1lFge6qKvatSAhKbsl5DUnmUIW5kHJZ7a7pM+GnNx?=
 =?us-ascii?Q?Ly5BLJsP2zwm6kPzO1XWlJlCnicUw8OkpSrEY/uUucASqP4bciLT5wOQFZMQ?=
 =?us-ascii?Q?7WSnzdMLgJLDJ3l5X3BDapnWkTpHFv6ISo7RvRvfr9MpArvf5KGYMVPyZwVy?=
 =?us-ascii?Q?J73D3v8pmuFkGSGo9UGJuNprAPvEb8BLYFITIypnzQ4su3N/DDCW1b7nhSnr?=
 =?us-ascii?Q?C3S1QdxC/NcbT0rmOcqTmpkihyhLG1ilCQ1qAqe1GReBSdSYZsEDi6hjN/tM?=
 =?us-ascii?Q?RPT7iIdkMEhA4d5L241xJNTKj9sFgUuV74EWlW0PmzKntOKZl6iPMh8q8Wt/?=
 =?us-ascii?Q?FgVWBg0URR8KobTJiJoNdBCHUMolk7pGHrqQP8vSTJ8RtAiCzX2ia1Xj2PLg?=
 =?us-ascii?Q?gB1+FOXwi5KeZIUW6lLK7ZXit6wSOroW+2ACUI1rllMuFpGQ/WfzIs+uDroe?=
 =?us-ascii?Q?35WG58Vh9PbK+88aZr7nUEvCOHHG9U5nRacmBkfEtZpwjgxF6L2bQBVwETMP?=
 =?us-ascii?Q?bf/VpqRQXjFr71DEY2dO01Cx1ZMvWD76aWqAsiihkQ7dgUcOwERleANme0Jj?=
 =?us-ascii?Q?gELMd+USVZOcnPjo6aNz4b+F+H0EGlO6uJ8Y1hMuDVq17vf9+ivitHu3m+JS?=
 =?us-ascii?Q?W0YWuPMoItpscawIpvVSvvQ9xsAVGV82myXHzbIR5NEGB8C+kOfvlP6XorCc?=
 =?us-ascii?Q?wMK4TsLSdV5lao5yTfS0ajUT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e82cd7a-a378-42b3-a7c6-08d90865b0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 03:45:09.7413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0bz1WJm8oE7E5+oZZt+tCYWYQslgNzo1jWi2tmd3amROgFyV7sg97YNhh5KTMOuaU9P910MNbWlJGc7gOYz5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5209
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com> 
Sent: Sunday, April 25, 2021 16:00
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Correct and simplify sdma 4.x irq.num_types

Correct and init the sdma4.x irq.num_types.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 29 ++++++++------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 7870fd09d98d..8a9b194b5826 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2601,33 +2601,22 @@ static const struct amdgpu_irq_src_funcs sdma_v4_0_srbm_write_irq_funcs = {
 
 static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev)  {
+	adev->sdma.trap_irq.num_types = adev->sdma.num_instances;
+	adev->sdma.ecc_irq.num_types = adev->sdma.num_instances;
+
+	/*For Arcturus and Aldebaran, add another 4 irq handler*/
 	switch (adev->sdma.num_instances) {
-	case 1:
-		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE1;
-		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE1;
-		break;
 	case 5:
-		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE5;
-		break;
 	case 8:
-		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
-		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
-		adev->sdma.vm_hole_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
-		adev->sdma.doorbell_invalid_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
-		adev->sdma.pool_timeout_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
-		adev->sdma.srbm_write_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE7;
+		adev->sdma.vm_hole_irq.num_types = adev->sdma.num_instances;
+		adev->sdma.doorbell_invalid_irq.num_types = adev->sdma.num_instances;
+		adev->sdma.pool_timeout_irq.num_types = adev->sdma.num_instances;
+		adev->sdma.srbm_write_irq.num_types = adev->sdma.num_instances;
 		break;
-	case 2:
 	default:
-		adev->sdma.trap_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE2;
-		adev->sdma.ecc_irq.num_types = AMDGPU_SDMA_IRQ_INSTANCE2;
 		break;
 	}
+
 	adev->sdma.trap_irq.funcs = &sdma_v4_0_trap_irq_funcs;
 	adev->sdma.illegal_inst_irq.funcs = &sdma_v4_0_illegal_inst_irq_funcs;
 	adev->sdma.ecc_irq.funcs = &sdma_v4_0_ecc_irq_funcs;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
