Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B85C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 03:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D58206E2
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 03:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="buq/afw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D58206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D0C6EA1C;
	Thu, 12 Mar 2020 03:47:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4436EA1C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 03:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nicC/Gq/kMcKS2fmWoZkl41ppC29/wzUTTf/9JsV8FFf1MLzPVxMSw4x49FkLEQTsBXZKIkr4NiQmEPPOwsnmErPDBa3wf/+3Kr1MB5n7v9YEtDIBzDK7bt9fBzoXbsj461SmiVGONyY69a/lWUAAin/hgXJMlKNS3A0DVTD39chbf4vjKmShCqt+CrA06B+4W1asJFg7vknhxcmekgazrAWDpSdTZ/LdQOSwMaQVf9p0ZkJVB1Q8w6xKxa0ZcAycoITZ8q3MUt3zv6PQ9e63ldCpx2feXyu2MZzstu8TPQ2icn3WH0AR0FG2IcUSta0KryL3yYkprVfcODaNlhpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XVOzWksVRsubmGg4mGz0rix+F48Xo2BRF1wYOgG8UE=;
 b=mr+bSR+LtyPZpCgf/LeNT2YXRf646VtaYUaYsLtJ3JLtG2o3p2fDvHaVvaTiANfddKtGbuMK+/ljOjaHXpJXyvivUv+pzVMRyzi6cpL6FX2ASR8tv1GcS6qHQR3I8iShQdaClENLcui4zP0eE7j5xV4l6AmUrEi7Pee0iaYAgiV5EF4X6oS/o572xu+PBCSsOgkjLRllsNYhUcNVciVnfFpdaP6shykyjrI7eFSDRzMpaH9F4+MxsLKEBSVQWWN2X33BT1iriKmyMizcs57j7oKPxYjvDzcnvHMPECLLMHKmAztrd3ybfUcsRHJ6Y15/4m3eTBcnqQSoSfyzcpdTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XVOzWksVRsubmGg4mGz0rix+F48Xo2BRF1wYOgG8UE=;
 b=buq/afw9JlF0rWBBs1/IxNjGoMaWwRoD9tGDhSHZ/5PPSF/NzPmreyh5/ku1Y4vfrBCvn75zU/joLeczlRzbXoQChzRTNPtNQOuQu0ZsnAa0WBDFMpbnINhWJAOh0d7s9L5otWGLZjmmJky86/+nCI8+2HyWM8+gwMtflCuHXVQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Thu, 12 Mar
 2020 03:47:20 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901%11]) with mapi id 15.20.2793.018; Thu, 12 Mar
 2020 03:47:20 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, 
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: update ras support capability with
 different sram ecc configuration
Thread-Topic: [PATCH 1/2] drm/amdgpu: update ras support capability with
 different sram ecc configuration
Thread-Index: AQHV+BmpM56ANolYs0GSJKZFmXkzV6hESCaAgAAJJDA=
Date: Thu, 12 Mar 2020 03:47:20 +0000
Message-ID: <CY4PR12MB12877730B0ABADD08072F0B3F1FD0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200312025447.21000-1-guchun.chen@amd.com>
 <DM6PR12MB4075F2DB3C332761746AA69EFCFD0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075F2DB3C332761746AA69EFCFD0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-12T03:46:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b50e8b07-3f9f-4e29-8c9b-0000186c6c80;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-12T03:46:56Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4a67771c-2d42-43cb-a79a-00006a28739e
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9228c11-b89f-439f-52eb-08d7c638111d
x-ms-traffictypediagnostic: CY4PR12MB1432:|CY4PR12MB1432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1432966F30310ABD33616F6AF1FD0@CY4PR12MB1432.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(7696005)(478600001)(55016002)(86362001)(9686003)(26005)(81166006)(186003)(8936002)(6636002)(15650500001)(81156014)(8676002)(76116006)(66476007)(6506007)(71200400001)(53546011)(2906002)(52536014)(66446008)(66946007)(64756008)(66556008)(316002)(110136005)(33656002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1432;
 H:CY4PR12MB1287.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kWIFZS1ufFsYhKmq2Co/kIG1XdO20DDyqaxEHyk2ro5NDbVhEFVHaI1DNBTmWZH5MsTQmmXMpXGWusEoCoUndf7IFUhdikrW/3+zyl4yk7aSs+XaTIdCjr8yIUW7Jvg5YnhVS1WmT4gTXespnauaJ1luOLbUbdRoNpfWXhkkP7NJq7cM+veXXT/xLCd0Qu/CGRlpD/zA0KqxVb9V1LGWtzGs2uNiOtInhwWjshYAnt3Lu0aXKkrZk89llhqHy9X4QJszPeqR2+wzEFH6VSugBjHcK4EW1PdxRY3V3xvnqr1WJpQLt2KQFmecZjTuzecgQCip6zCwicd1ew79gjxEQzIt79yPBAAR5Ks3bupIjoi9xm2eoFMx8gFW9/TYn39eLQLJ9k7OEMgqF9AupuDd6+j228WPoUaYIXWSr3c/q+FsmSMC0MjTLLB3aqNN7gkF
x-ms-exchange-antispam-messagedata: S+OI8lrgePYj4BM2mDO1bHGkV/YWRT+n/mOrcJESKqznvEjxvclWbSvrPYHzy8Sj5Qv6fST2QsCYXNlL4bCX4J+7JrBaClZRYbdhP2ObVfLzhwzy+5z5SIxmJ3OSgPdYup5EnBxXWVfNP5X2yjgaXg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9228c11-b89f-439f-52eb-08d7c638111d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 03:47:20.2707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vuug6F3Di6Haw4Tg6DcbVoHhXbF/TVn+bHuPMTsFaRHv8dRjR7l3mR9CpS8tt++OqyhEBQ5ctxJVQnzPKNjzcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1432
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks for your suggestion, Hawking.
I will send one patch v3 to target this.

Regards,
Guchun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Thursday, March 12, 2020 11:13 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: update ras support capability with different sram ecc configuration

[AMD Official Use Only - Internal Distribution Only]

Hi Guchun,

It seems to me we still have redundant function call in amdgpu_ras_check_supported. The atomfirmware interfaces are possibly invoked twice?

As I listed the steps in last thread, we can assume hw_supported to 0 or 0xfffffff either. 

Check HBM ECC first, explicitly indicates it is present or not, and set the DF/UMC bit in hw_supported Check SRAM ECC, explicitly indicates It is present or not, and set other ip blocks masks.

After we run all above checks, set the finally ras mask to con->supported.

We'd better keep the message consistent as what we had in gmc_v9_0_late. No need to highlight the what IP block get disabled, that should be transparent to users.

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Thursday, March 12, 2020 10:55
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update ras support capability with different sram ecc configuration

When sram ecc is disabled by vbios, ras initialization process in the corrresponding IPs that suppport sram ecc needs to be skipped. So update ras support capability accordingly on top of this configuration. This capability will block further ras operations to the unsupported IPs.

v2: check HBM ECC enablement and set ras mask accordingly.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 +++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 69b02b9d4131..b08226c10d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1748,8 +1748,41 @@ static void amdgpu_ras_check_supported (struct amdgpu_device *adev,
 			 amdgpu_atomfirmware_sram_ecc_supported(adev)))
 		*hw_supported = AMDGPU_RAS_BLOCK_MASK;
 
-	*supported = amdgpu_ras_enable == 0 ?
-				0 : *hw_supported & amdgpu_ras_mask;
+	/* Both HBM and SRAM ECC are disabled in vbios. */
+	if (*hw_supported == 0) {
+		DRM_INFO("RAS HW support is disabled as HBM"
+			" and SRAM ECC are not presented.\n");
+		return;
+	}
+
+	if (amdgpu_ras_enable) {
+		*supported = *hw_supported;
+
+		/*
+		 * When HBM ECC is disabled in vbios, remove
+		 * UMC's and DF's ras support.
+		 */
+		if (!amdgpu_atomfirmware_mem_ecc_supported(adev)) {
+			DRM_INFO("HBM ECC is disabled and "
+					"remove UMC and DF ras support.\n");
+			*supported &= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF);
+		}
+
+		/*
+		 * When sram ecc is disabled in vbios, bypass those IP
+		 * blocks that support sram ecc, and only hold UMC and DF.
+		 */
+		if (!amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+			DRM_INFO("SRAM ECC is disabled and remove ras support "
+					"from IPs that support sram ecc.\n");
+			*supported &= (1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF);
+		}
+
+		/* ras support needs to align with module parmeter */
+		*supported &= amdgpu_ras_mask;
+	}
 }
 
 int amdgpu_ras_init(struct amdgpu_device *adev)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
