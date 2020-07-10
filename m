Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7540EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464C8206E2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 06:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NT6FI2OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464C8206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E926EB72;
	Fri, 10 Jul 2020 06:37:18 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750072.outbound.protection.outlook.com [40.107.75.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259636EB71
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 06:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD6G2xj05698yKHI7ZFFT/ob/uiuqS8rcevNstYDZnx34NYi9IuO7UUqOjlHrlL5P38GSNHngfgrDLgd2JXM2zNn2rnL7OdwtGfyLEcSwRXT45Y0FbfxXpdEb3SKGSRP2T3uA9dxsj/V+0+o4bHkWDNYTNnx5KAmmAlK3eZt4eKdhRzaM7rAYmKnVNThVPNsaRYLGrgckteDa8J4GXGBRku49XCiwG5KG+AUmaZoYNJl83G1ORE9zTl6vueDqzLG6tGpIU5DJlHP+MNNRairG8TLYMStA8R/B0kiguIjJDSK6LftNncb3NfzGXMzcycTtp4faM2SG5wlXDGvXKV8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N7+CZwKLaVtcBqbAhWZYgYMD4YqKCaXb8OxvR1NZ5w=;
 b=gWMKCAxJwKceqDvdNj/iT2SuZD2pKc4fsdrIpoJzBJ6qYTHH8lFw5W6wV5M5ZX7vw+mePEDPqtpaIdc6D/viG9Wt3i3ensCtb4ywrn939YmpWmsGH7LgnN3+utLo6G/iG34zhQcPIt44nK0IEi9V3VzNxqE6t5hTquyfS/Zm6PmJsF3QjALa7Q0uO99jyehudUqEVy2hOovXURt9DTF0tFQcaUTFNilnrR5wMZbcaEbwW82lTjWoqWoIPkhTXLgfQVJ79KuL3Z0Wu1YHOQxm89t1zWpsmz0UDqBg7w2ITqO7WoQy1XCXiF/XBNG61kg6n/IrS1JH+joUwNyoK2e0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N7+CZwKLaVtcBqbAhWZYgYMD4YqKCaXb8OxvR1NZ5w=;
 b=NT6FI2OR+yT+wIoAStjOG/1LjZm0zTB0LRl8dNKyQ3AanKtmXKaGvQ+gBQDLATFV7wC1tmUOalF1rXSImkxVtj+g9kroMKj8D1gtGokrkyHdOZiP3PgcWHxLtK0FhDZnZBUUK+hUcfoLkTDFDXOM/Q1wj800zDcJbJBttMq8WMc=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Fri, 10 Jul 2020 06:37:15 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 06:37:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: add mode1 reset module parameter
Thread-Topic: [PATCH 4/4] drm/amdgpu: add mode1 reset module parameter
Thread-Index: AQHWVn1/O8bCER3nx0e0azbRs3O6JakAW+Kg
Date: Fri, 10 Jul 2020 06:37:15 +0000
Message-ID: <DM6PR12MB4075ADAFCE60F63B1580B8DDFC650@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
 <20200710054626.2487-4-Wenhui.Sheng@amd.com>
In-Reply-To: <20200710054626.2487-4-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-10T06:37:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2c47d695-9da5-4e82-9701-00002b40151c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-10T06:37:07Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ada7af82-781b-4287-b846-0000a2e7801a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-10T06:37:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 73910266-eb9e-4bd1-9c1f-00003f14d499
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e0b9845-4341-48af-b9dd-08d8249baf53
x-ms-traffictypediagnostic: DM6PR12MB4219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB421997B7BF5123A67F390B0AFC650@DM6PR12MB4219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFPsfjS65zreaf2XSKnMUi1gwn2ZB2TcPYDtbde8vlAVtz+rh0VwMYjAYX9u7BBOwi+BgLdtbGEYGh7EomW7SireTa/dbEbrOb5VACJuwgf9Ci9dNSGAwMnjEZEvOMiP3lnEaQt1xfcdGhulSkNHL9IhnKpc50HsP7OppnAB4dU8ISMMyhT7pwUiF1j6owFFRY1k61GFI0Ibf5TxR32QJAEHwj7tlsb+d7Uu5E/KhDOKtmqNlBbRAMx/pN/1fUqH2irA8FP9uKVjD1iWvsPhxTg96qSDnCiBHsPO+/h6wSoEccGs39uT9alM7GdTqyDlYw1v6T6KM82YRIHAAG1uyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(64756008)(66556008)(66446008)(86362001)(8676002)(76116006)(71200400001)(53546011)(110136005)(186003)(66476007)(6506007)(66946007)(7696005)(8936002)(316002)(26005)(83380400001)(55016002)(33656002)(9686003)(52536014)(478600001)(2906002)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 5ujC917g4ns4HyQnfXLUmTeHDbXCa8mpIkHYIPi/PcGMSaXesggAPuO0P/MNDs1M9VVvoon4ijkon4Mw9zr6zVdPCuskKwIgCjL3Vo+eT+DI6n5WbcR2lZ4TJfrqQ2LVaPkAbf9BrS2EPis1DgJePr3ePBrL+4HBGZJeKfPho7i5Gi1AMxL2FSlGeTuNljtJI/u6ThH+FRKBQqD3ljnTmmGQ2a7D5AS0mlu2M9+hn7mUNgTNBl8g7aN9x71QdcCTLNoMIP9lnysdhgiYjzGS8zqg2DnhcwuUbeuB9fvJPxWlh3q/nyC/85v0nRs3szOmaC1CAH+EH1xaKhVOorzQokbbdSgXY2IxqZdWzzIFl5Adq9mtcG0Blg7qQQA5zglEDcvoPPh23XkLpyp8kv35qqjrVDlv0zIzzRc2dJHxifMjRS3YxfcBJMakevod/qhFrXK+m6pxe2AwUh16ZhsjXa8OmNm1QIQnIOompF2QqkxuqtmaSeFhHk2z45jMKqx8
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0b9845-4341-48af-b9dd-08d8249baf53
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 06:37:15.0964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjlcLk9pPemeqLDvxJrGp+I5ceCzuY/PPYceWbapzG+xk8par459LXjkea57AHrnuanZ/nIcCotqb7RlR6u2Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

How about we expose the reset_method as a new amdgpu module parameter?

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Friday, July 10, 2020 13:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add mode1 reset module parameter

For sienna cichlid, defaut path is baco reset, only when parameter mode1_reset is set, mode1 reset will be chosen.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            | 9 ++++++---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0682a270c17b..01b14237dc94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -196,6 +196,7 @@ static const bool debug_evictions; /* = false */  #endif
 
 extern int amdgpu_tmz;
+extern int amdgpu_mode1_reset;
 
 #ifdef CONFIG_DRM_AMDGPU_SI
 extern int amdgpu_si_support;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 94c83a9d4987..d30d31aead7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -154,6 +154,7 @@ int amdgpu_mes = 0;
 int amdgpu_noretry = 1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
+int amdgpu_mode1_reset = 0;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -793,6 +794,13 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);  MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");  module_param_named(tmz, amdgpu_tmz, int, 0444);
 
+/**
+ * DOC: mode1_reset (int)
+ * Enable SMU mode1 reset (0 = disabled (default), 1 = enabled)  */ 
+MODULE_PARM_DESC(mode1_reset, "Enable SMU mode1 reset (0 = disabled 
+(default), 1 = enabled)"); module_param_named(mode1_reset, 
+amdgpu_mode1_reset, int, 0444);
+
 static const struct pci_device_id pciidlist[] = {  #ifdef  CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI}, diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index abccb155b28e..11a662a2f8d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -316,10 +316,13 @@ nv_asic_reset_method(struct amdgpu_device *adev)  {
 	struct smu_context *smu = &adev->smu;
 
-	if (smu_baco_is_support(smu))
-		return AMD_RESET_METHOD_BACO;
-	else if (smu_mode1_reset_is_support(smu))
+	/**
+	 * If mode1 reset is support&enabled, choose mode1 reset
+	 */
+	if (smu_mode1_reset_is_support(smu))
 		return AMD_RESET_METHOD_MODE1;
+	else if (smu_baco_is_support(smu))
+		return AMD_RESET_METHOD_BACO;
 	else
 		return AMD_RESET_METHOD_PSP_MODE1;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index cae5aa792ac4..ee74f0cf6231 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2741,7 +2741,7 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)  {
 	bool ret = false;
 
-	if (!smu->pm_enabled)
+	if (!smu->pm_enabled || !amdgpu_mode1_reset)
 		return false;
 
 	mutex_lock(&smu->mutex);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
