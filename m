Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D7C33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 00:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216CE2067D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 00:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v3PWX9sY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216CE2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C196E36F;
	Thu,  9 Jan 2020 00:59:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946996E369
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 00:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2QyDNSsGH2cV7FjvG1/4T555wqimVVF81LTW2pm/kK9CInDoIZ3PjzzZPDEKXbLWE7GSMefIrcZNZPfJDBeMzcTxZildHEKg/Sg0gr7ks2pQSfIUDigECT5KYWJl7kHdPAQDny6eo9NpbiSK8gAUEs6d4XoaNxqblrtgwbcJVtgFKGhj9uoCDEekW8uiq1VVffHdXRNAxJNTIut2UfRnJVmV9ZmWogDTm2mG65eXymGSP/q4dqtP6TxEDhF0KJr+lHKyCYc/QKu6Is+v00BZ6qCqUvLfARB7Qt6nnw/MYmiC++plQA05R9FHPHoaBeOoSqsRYqtevEwPUfBNM0OKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIZAj4i7vhb8uBApWi5Ma88bc6gWUd8c+7iR+L7xyTg=;
 b=XsGJYryhN+lQ996zTnlNY5VaMcD12XTXXT1HrN1nY+7XDjqxlixmXpO6gYhI4fBL9Ut1HKoPwvYHoCWaZXREs/s/1FbB6hJLihHpOpHEzW7uk9qE2iAm11ywm3v1vn5tNKYeQbl1eOUFBYMkL7x1XM9akcp3S3PYjKG2vScNpAacmN+DnHfQaW2xLYP0DnvQE5ygFf1khY44vWHM9RmF5iyb8Q0GwjvkGAr0H2rk/XrAUS61LE6fVAbiLLCdgFzGOEqwIdTS+FsK3jspwkCem3XjVJ8RBDN2l2sRhSCLh2p6Y/G1K7tdWuixsycjvys625qfZDuXHKt8lShYJztXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIZAj4i7vhb8uBApWi5Ma88bc6gWUd8c+7iR+L7xyTg=;
 b=v3PWX9sYzdNSsx4XP/K/nBHHQPo+gMxBYnCxogbtZbjCrTyrQeKec1cFedpZLwU3+tEfBYJrQyTf4lZdax7yo19rdKKdhqXzh6I0wYcakfDGRjNnejTd1CL0c8R0V4h+ZogzmLbm8UB+lNHQAkgd27S4a6kRGhJcrpJHZl2VZo8=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB2711.namprd12.prod.outlook.com (20.177.125.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 00:59:22 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 00:59:21 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Long, Gang" <Gang.Long@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: add query_ras_error_count function for
 sdma v4
Thread-Topic: [PATCH 1/4] drm/amdgpu: add query_ras_error_count function for
 sdma v4
Thread-Index: AQHVxj8sunzGlYIqfkCVHMvTlXZeLqfhgrvw
Date: Thu, 9 Jan 2020 00:59:21 +0000
Message-ID: <BYAPR12MB2806BB2F640912F09306B6CBF1390@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
 <20200108161721.7727-2-Hawking.Zhang@amd.com>
In-Reply-To: <20200108161721.7727-2-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-09T00:59:13Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9619ca30-d7b8-43c4-b7e0-0000d93d2186;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-09T00:59:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1a549899-b55f-47cf-aa02-0000376e9d49
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f99280c-f552-4403-d0d7-08d7949f29c4
x-ms-traffictypediagnostic: BYAPR12MB2711:|BYAPR12MB2711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB27116E91013704CFAE21B835F1390@BYAPR12MB2711.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(13464003)(8936002)(478600001)(110136005)(6506007)(53546011)(66476007)(8676002)(6636002)(26005)(81156014)(81166006)(7696005)(9686003)(186003)(316002)(2906002)(66946007)(33656002)(4326008)(66446008)(66556008)(64756008)(86362001)(52536014)(76116006)(55016002)(5660300002)(71200400001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2711;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6tVi3ABvsI9of7HqbIzFQxiHnoj+m3Mo3HWroJzmuudE+79KTWc/2rfh+BXC36w9rgI14G/fBJdMDg432a5ADUNXnjiYWxWrtMsweoigUWHBka2tA+z4b+gdYEZmXHISFjtI3EyhRKUQLhDoUPRKjZdtOOf59ondnqAcX7mHeUTs+9VAKVLawtJvxb/GffyIRoUB9eYoiEQ50Km3ovcHst12+BshdBumr4QGF6jnIB/4vqoOCwvZtY1RGLAtW0XRpFv40V3+Oyjiejm4tdDpIsZlF291jiLC8OGClhom6QconDTjn+QmuGfRY1YDc8pxivSQ6OnrjVdG9bQTnh9vNQgonYynxLcZ7cbZxe8etBxlFKUg0yoyCrwgryuqlMmUa2+X5Za73cvhZkv4IctSznXsbgh+X63pRXIMJ4ghk2qzuKn7rSBaHYD90NIQ1qRLHBlZujoabIRz+pvI7SBcwnL2Hf4kxf/ISkLf+7p5ZOUFn1OTquMPv9p0X5U3BbQR2oyfgmUdU/O/JqMiZQz7vg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f99280c-f552-4403-d0d7-08d7949f29c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 00:59:21.5041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OIZD9L0l/DTQoYOuY9lVjb7rpvpcQE6VoVe0cQ+YNrrVY0NHNvtU1Ur8SRSFydZ62X0gHGyi9d9lj2+3VIIixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2711
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, January 9, 2020 12:17 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Long, Gang <Gang.Long@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add query_ras_error_count function for sdma v4

query_ras_error_count function will be invoked to query single bit error count detected in sdma ip block

Change-Id: I1b17df7c66e71739ae4c31900bd96c5359af2240
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   6 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 163 +++++++++++++++++++++++
 2 files changed, 169 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 957791673fcd..9e87a97f81fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -50,6 +50,11 @@ struct amdgpu_sdma_instance {
 	bool			burst_nop;
 };
 
+struct amdgpu_sdma_ras_funcs {
+	int (*query_ras_error_count)(struct amdgpu_device *adev,
+			uint32_t instance, void *ras_error_status); };
+
 struct amdgpu_sdma {
 	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
 	struct drm_gpu_scheduler    *sdma_sched[AMDGPU_MAX_SDMA_INSTANCES];
@@ -61,6 +66,7 @@ struct amdgpu_sdma {
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
 	struct ras_common_if	*ras_if;
+	const struct amdgpu_sdma_ras_funcs	*funcs;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 4074314695c3..a00b85934b04 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -82,6 +82,7 @@ static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev);  static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev);  static void sdma_v4_0_set_vm_pte_funcs(struct amdgpu_device *adev);  static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev);
+static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 
 static const struct soc15_reg_golden golden_settings_sdma_4[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831d07), @@ -257,6 +258,105 @@ static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)  };
 
+static const struct soc15_ras_field_entry sdma_v4_0_ras_fields[] = {
+	{ "SDMA_UCODE_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_UCODE_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_RB_CMD_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_RB_CMD_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_IB_CMD_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_IB_CMD_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_UTCL1_RD_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+        SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_UTCL1_RD_FIFO_SED),
+	0, 0,
+        },
[Guchun]The indentation looks not right.

+	{ "SDMA_UTCL1_RDBST_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_UTCL1_RDBST_FIFO_SED),
+	0, 0,
+	},
+	{ "SDMA_DATA_LUT_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_DATA_LUT_FIFO_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF0_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF0_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF1_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF1_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF2_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF2_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF3_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF3_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF4_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF4_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF5_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF5_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF6_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF6_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF7_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF7_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF8_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF8_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF9_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF9_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF10_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF10_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF11_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF11_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF12_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF12_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF13_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF13_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF14_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF14_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF15_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF15_SED),
+	0, 0,
+	},
+	{ "SDMA_SPLIT_DAT_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_SPLIT_DAT_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_MC_WR_ADDR_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MC_WR_ADDR_FIFO_SED),
+	0, 0,
+	},
+};
+
 static u32 sdma_v4_0_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
 {
@@ -1687,6 +1787,7 @@ static int sdma_v4_0_early_init(void *handle)
 	sdma_v4_0_set_buffer_funcs(adev);
 	sdma_v4_0_set_vm_pte_funcs(adev);
 	sdma_v4_0_set_irq_funcs(adev);
+	sdma_v4_0_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -2417,6 +2518,68 @@ static void sdma_v4_0_set_vm_pte_funcs(struct amdgpu_device *adev)
 	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;  }
 
+static void sdma_v4_0_get_ras_error_count(uint32_t value,
+					uint32_t instance,
+					uint32_t *sec_count)
+{
+	uint32_t i;
+	uint32_t sec_cnt;
+
+	/* double bits error (multiple bits) error detection is not supported */
+	for (i = 0; i < ARRAY_SIZE(sdma_v4_0_ras_fields); i++) {
+		/* the SDMA_EDC_COUNTER register in each sdma instance
+		 * shares the same sed shift_mask
+		 * */
+		sec_cnt = (value &
+			sdma_v4_0_ras_fields[i].sec_count_mask) >>
+			sdma_v4_0_ras_fields[i].sec_count_shift;
+		if (sec_cnt) {
+			DRM_INFO("Detected %s in SDMA%d, SED %d\n",
+				sdma_v4_0_ras_fields[i].name,
+				instance, sec_cnt);
+			*sec_count += sec_cnt;
+		}
+	}
+}
+
+static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
+			uint32_t instance, void *ras_error_status) {
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	uint32_t sec_count = 0;
+	uint32_t reg_value = 0;
+
+	reg_value = RREG32_SDMA(instance, mmSDMA0_EDC_COUNTER);
[Guchun]One question is, after reading SDMA_EDC_COUNTER, do we need to explicitly clear this counter register to avoid duplicated counting in multiple querying case?
Or that register is cleared automatically after reading once?

+	/* double bit error is not supported */
+	if (reg_value)
+		sdma_v4_0_get_ras_error_count(reg_value,
+				instance, &sec_count);
+	/* err_data->ce_count should be initialized to 0
+	 * before calling into this function */
+	err_data->ce_count += sec_count;
+	/* double bit error is not supported
+	 * set ue count to 0 */
+	err_data->ue_count = 0;
+
+	return 0;
+};
+
+static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
+	.query_ras_error_count = sdma_v4_0_query_ras_error_count, };
+
+static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev) {
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+		adev->sdma.funcs = &sdma_v4_0_ras_funcs;
+		break;
+	default:
+		break;
+	}
+}
+
 const struct amdgpu_ip_block_version sdma_v4_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_SDMA,
 	.major = 4,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
