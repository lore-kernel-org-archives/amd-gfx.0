Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD9C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 06:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6524722DA9
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 06:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6524722DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E881B6EC56;
	Fri, 11 Dec 2020 06:46:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 658796EC56
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 06:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT42QuIZwhxybf8ba4+Uv/ZwrOXKyLbmghxCdMSr8tUWyMY6gHtsqZI22tJWzFGAm3PEeDUMxYjpAMJEhYeGUt1xmfXDUIHORKGVMIgjBoj63rAKuzAVI1l9rgOzB4c6ExUcg4uJgDWGxT22f5pICFSguO1roJhvKHLPnMqUv1sxrp5liAVQ/eqIgoW1xzCGzhmzZMGonXb21p5ec7KX9cdMxn/leUSAJp6J7e73+Gsxt/NpqvDVUuwhav+Huh5aneJAZ/ESqKBQIvgQDNgncozFX9cmXHVXUMUF1ekQfvWF+SFZSzHChKn4crRs4Ii+tHzN5EigyoU62zqQjBPh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPPuc2cEsELBUcxASoAxozcVToCeQF7cjysZcQiS9to=;
 b=l9v0pmSnO3a0N+9wEBubQCAzDI8wzgbQiuHD/OkoqB/1yaO2kKErI5axE99s1Gp6mIFiwkeapXAXPhvDx/Jr7+hvja64qHZsq+mT+TZknJ9p4Tqn8Qw3SdrW0B8IGUS28t3flko1lAsOzPztSUH4BRQEk/8bWJPqtIkf+LtRsX5La9ZalMiyMvQ/S3kd6kAfxvGg4+DRB2ws/sucD96HXjl8zQIL0djVfEH4ZVBrYwQzDM9sEwSAjq8WWeAhtlegFCmUfGtHFnUX3Fsqx0xIH53FfZXCIZcHgRralcssTwoTKW+TpTlTy8rmw4apgh9pHqQAhuhUTWp8jSb9marKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPPuc2cEsELBUcxASoAxozcVToCeQF7cjysZcQiS9to=;
 b=LLIM17wTctzQBD/4eLsFeJT7zb5UcEi2g1MyQPMHXtU8qmFUdfHU0o8YMnksWqOqJXOlxleRtMLjzqXfArpPKtcYk0to3FQajnHSwxkQNGd9hjJYpWbg6gdsrqD4Shi9kffH+PHXAIcd7UpRTF9FepWCkuKdmvWtxvw0FpxKLBw=
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 06:46:01 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3654.016; Fri, 11 Dec 2020
 06:46:01 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sdma5.2: soft reset sdma blocks before setup
 and start sdma
Thread-Topic: [PATCH] drm/amdgpu/sdma5.2: soft reset sdma blocks before setup
 and start sdma
Thread-Index: AQHWzvR2q8RqdqW44kmL4ZmrQqrivanxdIMA
Date: Fri, 11 Dec 2020 06:46:01 +0000
Message-ID: <MWHPR12MB1248DA3D849ED44EF6001F5AECCA0@MWHPR12MB1248.namprd12.prod.outlook.com>
References: <20201210125952.10245-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20201210125952.10245-1-Xiaomeng.Hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-11T06:45:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6ef73e20-18ad-4f01-8c76-00007e260623;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-11T06:45:41Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 507013a6-fa1c-450b-a98f-000081f226e2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-11T06:45:57Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b411505b-c09f-4cae-b43c-000090b6a8ff
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd974a68-a4cb-4b7a-2f04-08d89da06cb6
x-ms-traffictypediagnostic: MWHPR12MB1440:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1440416164541B4A76783AF5ECCA0@MWHPR12MB1440.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gaXTc1nUD56DSGPhtcYeVET46RiiA1bbRkbT6AYi7ANUUZNfpteD+92NI9jkbG/6SDGZYNMEQHg9jgCXkbfuLe54abM2Ybm0SyRIJ0BuhAB0asjKSl0gA5jHr3yxe3wVutML+o8/20dOIfOzu8r4IU/qrgrP/4Xu9FL2VjEHhRv74WZPhinqobF6ZjAH5X+myabHO6tnCo1r444/LopmVZajRPpObN5z0tsJdF90L+ACdv/jFa9rXrzCLCJSm/tUsJf5G+pt6b77H1xSBMiWFYXilOEO4TCOV/2W1nWPE9w+nixkkiCn7e7W6rbY1nE8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(7696005)(26005)(86362001)(64756008)(5660300002)(66556008)(52536014)(83380400001)(66446008)(186003)(6506007)(4326008)(8936002)(508600001)(55016002)(66476007)(71200400001)(2906002)(9686003)(33656002)(53546011)(66946007)(8676002)(76116006)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lsRD7eHtIeCknu5JTIblrtQCDGIiQQHQlnVo2+Tg4u7sPRDRsRHvSzJlVpF+?=
 =?us-ascii?Q?jvjt3ry+fw4bRlnc7LCi9Nv6EYjK9FbKRbvT5xdQa1iMvXmJXZE1uZrVD3vO?=
 =?us-ascii?Q?3aVVZsaUhRUtPAkhOB112OAxr0p/vctNfrMcy2ou3rGwaWfCfvDnsk94d4eB?=
 =?us-ascii?Q?kXZo/g7JeUGMH69LlIHG60MLQLgoKDe6pEAVyFtO6tyBI/z6M2LlVZzw8dkc?=
 =?us-ascii?Q?/wobnQExKMydPrtSMYX50AqLkWwROFVqeikiVZEIa5653Z3aB+2TsVhSFMVO?=
 =?us-ascii?Q?SIj05nWoj83ykqN4fVuyxjKCyNy6VKcqgjKBl83mpF83acKaurCb9MUE09s9?=
 =?us-ascii?Q?AF+As3C3AApnkTmHAzXvxCvsNBLuEPAbkjL4+S3XLTGFp3fflTs4/WOwuHGM?=
 =?us-ascii?Q?lB92gHWpJLle8WoR9cQAUIBd5YU76pZX8hEPcW6C4pRVDLsYoHI5K8uxNFWT?=
 =?us-ascii?Q?sv/cStkknOxfQ3oxZ0jUjvDnAOtaWx5O0VZ1HvI+rjPeXwEHDWxR7sJSQv1g?=
 =?us-ascii?Q?Kq/clrs9qQo0A747MRxa4v1iz8rpCxO+P1mtgcAhTS+8mrz9Am69zAnHDRsp?=
 =?us-ascii?Q?AdYosU0rBfq854hAsAwpX6V5riYuDCXdGOk0bGKw41OtqMpJ2iG+ur2NwCM0?=
 =?us-ascii?Q?D5GWZrM5xKizQOzqBTZwVGGNuoRzCqfTQQlk5Ljc4vU9KdWKbrNmwXNhyHaH?=
 =?us-ascii?Q?94JEi6o2B++nxdE0utPEIQR8v7cWACAC12ESXFF+M7QgzrI+7HPJMSUXvqo8?=
 =?us-ascii?Q?215JD2Bfam4Nvv0AFj4ljWmXb1YWZcVASn9HlTBp7rdV5cLF3FXe2u7rLmky?=
 =?us-ascii?Q?iqmbtfpgdX87VzsibB+Jqy1+KGtWby10pDqnCXDHeGUu0698iGNAkq8ZLIOk?=
 =?us-ascii?Q?MXlnz/LRveFDHpCNClqTWLZ2uV6O2L1hvS6dedssegQq6RXliPfhOKHoJKn6?=
 =?us-ascii?Q?wEPPJ6OUpS0bf0XwBlIJY4VGBYbREGPNfH0MWPerPlOkjUqaPP5bI3PqmPcm?=
 =?us-ascii?Q?eOGH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd974a68-a4cb-4b7a-2f04-08d89da06cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 06:46:01.6292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ev1wN1lBZeJGyw6jaxHI+NpTZRXBiFg8cq3fura8w8BVjUlrjlDke1BmRjJ579MJkkWBcP/35JnOmss/feVsxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com> 
Sent: Thursday, December 10, 2020 9:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
Subject: [PATCH] drm/amdgpu/sdma5.2: soft reset sdma blocks before setup and start sdma

Without doing the soft reset, register mmSDMA0_GFX_RB_WPTR's value could not be reset to 0 when sdma block resumes. That would cause the ring buffer's read and write pointers not equal and ring test fail. So add the soft reset step.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 39 +++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 39e17aae655f..5acc1e589672 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -807,6 +807,37 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int sdma_v5_2_soft_reset(void *handle) {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	u32 grbm_soft_reset = 0;
+	u32 tmp;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
+						GRBM_SOFT_RESET, SOFT_RESET_SDMA0,
+						1);
+		grbm_soft_reset <<= i;
+
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+		tmp |= grbm_soft_reset;
+		DRM_DEBUG("GRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+
+		udelay(50);
+
+		tmp &= ~grbm_soft_reset;
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+
+		udelay(50);
+	}
+
+	return 0;
+}
+
 /**
  * sdma_v5_2_start - setup and start the async dma engines
  *
@@ -838,6 +869,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 			msleep(1000);
 	}
 
+	sdma_v5_2_soft_reset(adev);
 	/* unhalt the MEs */
 	sdma_v5_2_enable(adev, true);
 	/* enable sdma ring preemption */
@@ -1366,13 +1398,6 @@ static int sdma_v5_2_wait_for_idle(void *handle)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_2_soft_reset(void *handle) -{
-	/* todo */
-
-	return 0;
-}
-
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)  {
 	int i, r = 0;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
