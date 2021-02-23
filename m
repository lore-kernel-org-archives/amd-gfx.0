Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BE6C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 07:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B473864DAF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 07:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B473864DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2748B6E053;
	Tue, 23 Feb 2021 07:54:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2176E053
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 07:54:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAzzkh12RDy+S4ksLshvp/I4DusUxQtUY0qRUTkIEH8a7N3sfiEFTvanQZQwKaFM2zYh1VQunwpJKUGxDJIUVBI02grrnn1HBIKCw7SSo+uBaj8DwW5J80QF4k4ETezD1KzaHu2sXb+0ir45TTn2RJ37dGYY+n5v2wgEeFsH2pZgQRhKtd9Of0yOJD8GNW89F4SP/qD4qsgg1icdBfPPNwjPyCcXrpL71BxbTVMXlt1olJ8gsxbNHBJDdO0Lksnf48pE5UEttLCmTWdkQH2IbAPvyxnWMd6Qyq7HH6fT3rQFx9O2D5aE3r8TpzAFXCjKCxlCYXLu7QA72EMxywBgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHmZdN8vtW9zx7mw7MsUuiG+OE61psmHrFGLDc4YbWk=;
 b=LNkCwYGE9LDSzmoyMnt5nfgZUlzZrnZl1502dk+PSUruFYRz6+Pso19RsAs1D9a0V2tA0zuH0+6wjk5+baLnll0L5425KqlN2hKX1fxSG1Sf6kfTJJmq8D1D62Z4bcKwB+CiFAaFemCqq7UKLoorxQ8bYBME02aH23SkdiBhAx/P7aLWvKIxrCBvBxmW4eQSQUMTD7dKX6qtreZdGvaEb8wI8qJ84YTY7YSFi/ODHbpiJIvJBBWPBARuJlQWkMJ4Dfh293bxuitlMphpENDm/DFKYNqOuogNGKsJSykFIWCuSgBDkHdxO66WapY0aYRVGfWFyFZ2sirYslUTKJhEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHmZdN8vtW9zx7mw7MsUuiG+OE61psmHrFGLDc4YbWk=;
 b=0FkfPfsmqO/BG5SjCTJY6/VrRhwl79V6vTp+tu+q7F45CKmMk+2jbyNhzjbmT9RtT78wLZ3F3kPC4tXVoZkRdLDe9TSdtr4xslgkKnbB3lKpwtcLw+cJ5UnKrO8BiOpOoK4Ttod4d9YaXk9vtqrFtAqPfx1NS2qbe1YtK7DDrW8=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3689.namprd12.prod.outlook.com (2603:10b6:5:1c7::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30; Tue, 23 Feb 2021 07:54:30 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::bddf:50bb:25e4:80eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::bddf:50bb:25e4:80eb%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 07:54:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: reserve backup pages for bad page retirment
Thread-Topic: [PATCH v2] drm/amdgpu: reserve backup pages for bad page
 retirment
Thread-Index: AQHXCaN6d5n5eDD6hE6pkQttKWNLZKplXkbA
Date: Tue, 23 Feb 2021 07:54:30 +0000
Message-ID: <DM6PR12MB40755B934F2DFD66E66B7727FC809@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210223051920.11945-1-Dennis.Li@amd.com>
In-Reply-To: <20210223051920.11945-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-23T07:54:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7a766c90-550b-4c1d-991c-af1311c7bf21;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4ebd4b5-1b76-47e4-78a9-08d8d7d0406b
x-ms-traffictypediagnostic: DM6PR12MB3689:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36893A349C77033FB5D45346FC809@DM6PR12MB3689.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:313;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3X0nQibCHkNE+Z86FSz/oSj+Piux23CNDkF0K3NaPhzBArDTyedNleiqq8dB0PRocXRjbYDgp7T/BT6x+10SQgP1ITmDIrzBBct0DLpWzcyu07xdqOqF8hr/FlLdPJkI/692P5SVnMPA6k2F5XRRwuendaRLW7OOBm5GTsk2K6vtUCJyAXzAqpSBqX2uf9BG0Rj6qFRg8d5BFBBJzuVmhZYd0A1emJ1eO9uG4Bq2a693undKFa8W4dvvdrw1QeBJSbyCSL+V/y8mSWGG0JTYDKC7LtRlpthGr7bGN/pg+QxcFepf/CzwQDFoEsjnHsFIqzoESs/SZ3qToPWBEwF5BrmeWG0E5eLFtgnZpatPYjCR5OEK6N6UPSc+A0hgsarw2QoIJ9fiiiRaiFiHD0VL2zpe4QVWCTDEHWsu3L80JvBmqshXkSc4CV1wn106X5DVTS6xXqynDEPnhHWWHL6FbLUYYw+MOI+BRjmqyIiifBXaQUhRBR3i04Lxo16f+s1kSSDA6kEbTRZFimXX3p4pfA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(110136005)(53546011)(52536014)(66946007)(8676002)(8936002)(6636002)(478600001)(66476007)(4326008)(186003)(33656002)(66556008)(5660300002)(66446008)(64756008)(316002)(55016002)(6506007)(76116006)(83380400001)(26005)(2906002)(7696005)(86362001)(9686003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0uxd5REzDQK/YHS8xIQ3lC23V0Vg/ubcvZfN5Kn0uM5mxUjyoyaf3OjkTjb2?=
 =?us-ascii?Q?ut/leMCMY5GEZKgC3Fh1foluqZjmOdQnKbDfMLpN5KaivQ7CXGjkIQwWdP1H?=
 =?us-ascii?Q?0RshioPzxOoSZlWUjKcrQyX0FoQ8eydR44qJmlAStjuk0++KfDOFiIBQqUHY?=
 =?us-ascii?Q?P5H7vs5fzMsKhZyXHBad92TptHiLr3SaLGaU6yZqM+bn9UDrL2+bxD7BuNvP?=
 =?us-ascii?Q?o9Tt1M65SeXwp2WwkeQoBjnfA7rJDy6XKlAgGBJfUrKUN/bN4+mM73DFctth?=
 =?us-ascii?Q?7cq/05QY1r6Xfw51VlWzFv9eu1sfg82DS6ALPtMmF8eLhQmjvo/2mpzghWkX?=
 =?us-ascii?Q?0QK+SWulcJljI5CjvyKAtZXQtvHSASRG5FX5LjOZt6xgW0B3MXvEvIzPPK5A?=
 =?us-ascii?Q?e/BNyN+Z3XAG7qc2L/XLraXjncdCZS/tYH9lipbsnO0nX6dlY54hLZpd4IS7?=
 =?us-ascii?Q?wV+EnbnA4t+mZn5wurBgUsetlRNSKh2HDOdLMSyrb70QVSKZi2aCwhUiF/Gv?=
 =?us-ascii?Q?GO0jtyHuhA+spJwLJVeqHp8SuMzyzfExBKlWGwerQez5HFA1KL/WYB2MmgQh?=
 =?us-ascii?Q?aexZ9+nswjkgGDwrSlMM1v6Tpzdy06bhoL+utPq4G1u+t/PZ3VliRDmS/A2a?=
 =?us-ascii?Q?7xd8B7GA/3nO67Di70CdkJ/RbK0Zk4M1AwbJsFIEErd4xWejo3o1Kj4T8OC6?=
 =?us-ascii?Q?IQ5V/6p+2/jPa+NbLOAcsmgTR18j6DHaK702kts6uRLtmuT293ftDEWwQcEX?=
 =?us-ascii?Q?BKQZbP513u4kFKEfEZrQv20vatUKzXDWu2++QtTtsgRUwnyRnG9pwWyjxOhy?=
 =?us-ascii?Q?qpTEWpmcd2tlWFElhWyulU0XGnrbWjocW5wEXOyJDfLeCQrRhTSuBuel0jzI?=
 =?us-ascii?Q?+sEjKbKHIzq1sFZC1tsfrh9/k66/NT0D8S5DAJ5DMF8IoeIrzTQErXWonwCv?=
 =?us-ascii?Q?ZpMeQp3vVnXqqhJWWki1qR7ec1FfiF0D8ZwThX+xPWOzB40k50w11jCMThiU?=
 =?us-ascii?Q?ld7bfIqzOBP7gtWJ5+9eI+os5u3JUdJCYqfaoQu/QNqQwdeQXxV07psaZfXh?=
 =?us-ascii?Q?kFLawy5/aPyr0p2h6Zj8k1OGzqhJ5uxFUiXcDmNHBxpJ4gPeSQN+S/kqOv11?=
 =?us-ascii?Q?vNfxVqHmxiDVRp7nT1qEeOpjZRkW7QiWcey5LX+IaVoA3bhMiYnGrfYg3LIA?=
 =?us-ascii?Q?nVYId0No8h85N8p8X6TD1YieaSn8ifkOffenQIyuvry/N+pSrGm04E8GD2z8?=
 =?us-ascii?Q?e7JSOVrg/eSCqU0NBf5JsoqfvS9GXVpHQu0Eh8/lYuk4hXm0AJK7Xga1M4SM?=
 =?us-ascii?Q?XvmGjbhUuxlDmlGk5JryXefN?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ebd4b5-1b76-47e4-78a9-08d8d7d0406b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 07:54:30.5824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fC8ATKpfaKZSyh+n0T+SKpt2N3y3gHJBt4KcAoukSG/j6YZyLu00RizkC6lR2er9ZKw/9cS0Nkf2Cwzk6Upfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Please fix the commit description since this has nothing to do with user experience. This is to ensure user have a constant of HBM memory to accessible to them in run-time.

With that fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Tuesday, February 23, 2021 13:19
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: reserve backup pages for bad page retirment

it's not user friendly that users' visiable unused memories are decreased when bad pages are retired. Therefore reserve limit backup pages when init, and return ones when bad pages retired, to keep no change of unused memory size.

v2: refine codes to calculate badpags threshold

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b7ee587484b2..ff4387bbfb1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -170,7 +170,7 @@ struct amdgpu_mgpu_info mgpu_info = {  };  int amdgpu_ras_enable = -1;  uint amdgpu_ras_mask = 0xffffffff; -int amdgpu_bad_page_threshold = -1;
+int amdgpu_bad_page_threshold = 100;
 
 /**
  * DOC: vramlimit (int)
@@ -804,7 +804,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
  * faulty pages by ECC exceed threshold value and leave it for user's further
  * check.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto, 0 = 
+disable bad page retirement, 100 = default value");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 93699ea4860c..09546dec40ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1747,13 +1747,14 @@ static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
-					uint32_t max_length)
+static uint32_t
+amdgpu_ras_calculate_badpags_threshold(struct amdgpu_device *adev)
 {
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int tmp_threshold = amdgpu_bad_page_threshold;
 	u64 val;
+	uint32_t max_length = 0;
 
+	max_length = amdgpu_ras_eeprom_get_record_max_length();
 	/*
 	 * Justification of value bad_page_cnt_threshold in ras structure
 	 *
@@ -1779,20 +1780,18 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 		tmp_threshold = max_length;
 
 	if (tmp_threshold == -1) {
-		val = adev->gmc.mc_vram_size;
+		val = adev->gmc.real_vram_size;
 		do_div(val, RAS_BAD_PAGE_RATE);
-		con->bad_page_cnt_threshold = min(lower_32_bits(val),
-						max_length);
-	} else {
-		con->bad_page_cnt_threshold = tmp_threshold;
+		tmp_threshold = min(lower_32_bits(val), max_length);
 	}
+
+	return tmp_threshold;
 }
 
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev)  {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
-	uint32_t max_eeprom_records_len = 0;
 	bool exc_err_limit = false;
 	int ret;
 
@@ -1812,8 +1811,16 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	atomic_set(&con->in_recovery, 0);
 	con->adev = adev;
 
-	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
-	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
+	if (!con->bad_page_cnt_threshold) {
+		con->bad_page_cnt_threshold =
+			amdgpu_ras_calculate_badpags_threshold(adev);
+
+		ret = amdgpu_vram_mgr_reserve_backup_pages(
+			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+			con->bad_page_cnt_threshold);
+		if (ret)
+			goto out;
+	}
 
 	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 69ba8dd4f3ee..927d33d75c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -52,6 +52,8 @@ struct amdgpu_vram_mgr {
 	spinlock_t lock;
 	struct list_head reservations_pending;
 	struct list_head reserved_pages;
+	struct list_head backup_pages;
+	uint32_t num_backup_pages;
 	atomic64_t usage;
 	atomic64_t vis_usage;
 };
@@ -127,6 +129,8 @@ uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);  uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man);  int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 				  uint64_t start, uint64_t size);
+int amdgpu_vram_mgr_reserve_backup_pages(struct ttm_resource_manager *man,
+					 uint32_t num_pages);
 int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
 				      uint64_t start);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 21d18efca277..b325b067926b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -28,6 +28,9 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
+static int amdgpu_vram_mgr_free_backup_pages(struct amdgpu_vram_mgr *mgr,
+					     uint32_t num_pages);
+
 static inline struct amdgpu_vram_mgr *to_vram_mgr(struct ttm_resource_manager *man)  {
 	return container_of(man, struct amdgpu_vram_mgr, manager); @@ -189,6 +192,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	spin_lock_init(&mgr->lock);
 	INIT_LIST_HEAD(&mgr->reservations_pending);
 	INIT_LIST_HEAD(&mgr->reserved_pages);
+	INIT_LIST_HEAD(&mgr->backup_pages);
 
 	/* Add the two VRAM-related sysfs files */
 	ret = sysfs_create_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes); @@ -229,6 +233,11 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 		drm_mm_remove_node(&rsv->mm_node);
 		kfree(rsv);
 	}
+
+	list_for_each_entry_safe(rsv, temp, &mgr->backup_pages, node) {
+		drm_mm_remove_node(&rsv->mm_node);
+		kfree(rsv);
+	}
 	drm_mm_takedown(&mgr->mm);
 	spin_unlock(&mgr->lock);
 
@@ -300,12 +309,14 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 			continue;
 
 		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
-			rsv->mm_node.start, rsv->mm_node.size);
+			rsv->mm_node.start << PAGE_SHIFT, rsv->mm_node.size);
 
 		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
 		atomic64_add(vis_usage, &mgr->vis_usage);
 		atomic64_add(rsv->mm_node.size << PAGE_SHIFT, &mgr->usage);
 		list_move(&rsv->node, &mgr->reserved_pages);
+
+		amdgpu_vram_mgr_free_backup_pages(mgr, rsv->mm_node.size);
 	}
 }
 
@@ -322,6 +333,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 				  uint64_t start, uint64_t size)
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
 	struct amdgpu_vram_reservation *rsv;
 
 	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL); @@ -332,14 +344,94 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 	rsv->mm_node.start = start >> PAGE_SHIFT;
 	rsv->mm_node.size = size >> PAGE_SHIFT;
 
+	dev_dbg(adev->dev, "Pending Reservation: 0x%llx\n", start);
+
 	spin_lock(&mgr->lock);
-	list_add_tail(&mgr->reservations_pending, &rsv->node);
+	list_add_tail(&rsv->node, &mgr->reservations_pending);
 	amdgpu_vram_mgr_do_reserve(man);
 	spin_unlock(&mgr->lock);
 
 	return 0;
 }
 
+static int amdgpu_vram_mgr_free_backup_pages(struct amdgpu_vram_mgr *mgr,
+					     uint32_t num_pages)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
+	struct amdgpu_vram_reservation *rsv;
+	uint32_t i;
+	uint64_t vis_usage = 0, total_usage = 0;
+
+	if (num_pages > mgr->num_backup_pages) {
+		dev_warn(adev->dev, "No enough backup pages\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_pages; i++) {
+		rsv = list_first_entry(&mgr->backup_pages,
+				       struct amdgpu_vram_reservation, node);
+		vis_usage += amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
+		total_usage += (rsv->mm_node.size << PAGE_SHIFT);
+		drm_mm_remove_node(&rsv->mm_node);
+		list_del(&rsv->node);
+		kfree(rsv);
+		mgr->num_backup_pages--;
+	}
+
+	atomic64_sub(total_usage, &mgr->usage);
+	atomic64_sub(vis_usage, &mgr->vis_usage);
+
+	return 0;
+}
+
+int amdgpu_vram_mgr_reserve_backup_pages(struct ttm_resource_manager *man,
+					 uint32_t num_pages)
+{
+	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
+	struct amdgpu_vram_reservation *rsv;
+	struct drm_mm *mm = &mgr->mm;
+	uint32_t i;
+	int ret = 0;
+	uint64_t vis_usage, total_usage;
+
+	for (i = 0; i < num_pages; i++) {
+		rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
+		if (!rsv) {
+			ret = -ENOMEM;
+			goto pro_end;
+		}
+
+		INIT_LIST_HEAD(&rsv->node);
+
+		ret = drm_mm_insert_node(mm, &rsv->mm_node, 1);
+		if (ret) {
+			dev_err(adev->dev, "failed to reserve backup page %d, ret 0x%x\n", i, ret);
+			kfree(rsv);
+			goto pro_end;
+		}
+
+		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
+		total_usage = (rsv->mm_node.size << PAGE_SHIFT);
+
+		spin_lock(&mgr->lock);
+		atomic64_add(vis_usage, &mgr->vis_usage);
+		atomic64_add(total_usage, &mgr->usage);
+		list_add_tail(&rsv->node, &mgr->backup_pages);
+		mgr->num_backup_pages++;
+		spin_unlock(&mgr->lock);
+	}
+
+pro_end:
+	if (ret) {
+		spin_lock(&mgr->lock);
+		amdgpu_vram_mgr_free_backup_pages(mgr, mgr->num_backup_pages);
+		spin_unlock(&mgr->lock);
+	}
+
+	return ret;
+}
+
 /**
  * amdgpu_vram_mgr_query_page_status - query the reservation status
  *
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
