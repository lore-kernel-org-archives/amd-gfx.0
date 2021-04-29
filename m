Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F8C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F1C61447
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F1C61447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED676ECE1;
	Thu, 29 Apr 2021 08:28:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA796ECE1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN3V/3OG4/UaUvHWb4Y8Z+7A1Cj2uJGj0saWftprmCf6oL2imvrBpViiW6+euc4ve7D1mupoLiybPnx8T0x/A9JG2zhx4OWXAX0m6V3h6Ig/NlwAdyP3ttmk0CbdnBb3NYpHuz/Uf48iQ8eUGF4dSzfvSMRCAZ1n3KiCZw1jcp7w6i9hBWy6Y6juZ9Iy5oMwToOwKW5z91sl2kP+RvXVBOPZmm7dRujLxUexGfPUiBhdQpuivnbi/wZfw6hY0sc3Tsmapz+TyMAkhOL9jtPZiUK56OD1p1opj36RijXMZgQHzriYbKgvae+bIqjZwUC/S2C3C8t2BUUCWc3mVg34wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVbrNcfcMY5taou8lqotGuNOd7A8X6WdJnB/s86RpW0=;
 b=GxMXOCosVeed8hbDCS6TzH2GAYFsbhz+sAL53mtfophAs3nTtuMxsMb/t+R5PYe8VmsjO2BW424h1T9ezdaDust15H4uklffTTM8lVNPaX7A0qaGcRU112PUv7zuXjaTYnDiNy5TNu3GM9xqvRtjy3LtInUY1+Jztg9RyUtRP3qQreo5lviyOt0XLyg5c+w1QlfWLMX1tNoWnDyTHgK9Bx09QSr/MF9WSkHPW9h/8kPMeWiYK5OR5fWsTvVliJyuWHodEJ+fLCtWltcTWJs4rReTcOwZ7peB/Ugs+wLuUziap1TMirZftRis3Ws6qqH6cB7GDgc5i+lqqpcU2ytu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVbrNcfcMY5taou8lqotGuNOd7A8X6WdJnB/s86RpW0=;
 b=NRhACwwPCVzzTtyhL8kPluVa1qNfbmpkZnVk5F4lmPMFZ8eg6ehYGxEONYl5rqYlxdTS4V4GQ/8leD7PhtteA1wnSfrUWW77y7MIW9m5j4slyIhYgT8nKH5PnLLvSGUAsVWUJVmHOzOGy/cGLoe6qSwsudlLHQadIYfg3M9MMeE=
Received: from BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Thu, 29 Apr
 2021 08:28:19 +0000
Received: from BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029]) by BL1PR12MB5350.namprd12.prod.outlook.com
 ([fe80::2da6:ea50:5bed:f029%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 08:28:19 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/7] drm/amdgpu: implement hdp v4_0 ras functions
Thread-Topic: [PATCH 3/7] drm/amdgpu: implement hdp v4_0 ras functions
Thread-Index: AQHXPMCGoOfU40HAyky431k7LMxhm6rLKXnA
Date: Thu, 29 Apr 2021 08:28:18 +0000
Message-ID: <BL1PR12MB5350DC26183673D1D27E1391ED5F9@BL1PR12MB5350.namprd12.prod.outlook.com>
References: <1619677546-2630-1-git-send-email-Hawking.Zhang@amd.com>
 <1619677546-2630-3-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1619677546-2630-3-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T08:28:15Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7e490f19-3f9c-4251-9a3c-98d97e3b3fc0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e26ed7c-9928-4e05-9c65-08d90ae8be40
x-ms-traffictypediagnostic: BL1PR12MB5223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5223E673012D45953259149CED5F9@BL1PR12MB5223.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sPSOV0REmq2TC/Wuoyap2aVGh8ZWALMS01jMsmQDyEJt9ZeHTWuW9npz94Gwj39zkHc03AIFxt8zPMBH8Jx6g1ynUSf1mQcNPZnXjp4K5ABUNYLPwr3eocZAcfqWmxUXKnTrAazuYOtt1NMZk4ohHDe+wH9zzS2ORTURBvsStu4fo/00caM2VpWcojb6xzW+VJ0U2zYhdDKhhXZwaMAqGmE/I+tUqvvxagoAUzrJsm1ts0Gnvyq3RaVt7ZiQ4EFwxkSFcJShbCBI9ycUuuDh1R5Shs7mYfIpzRuout0AIzBu62QIWGk2RWRAspufo83YI6fQJfcm+Q+CpYIoz8YhzhqxyD5enb9NyKek7WV/0cdEnhNL1I9CxL44cm2UGOcnano5PDmMaRwjLbgZWcEjGP7vmqm6mCj6Wgcg4WlACMu7sWPmh7ruCf8VK6VvtbrJnBLxfeZpQVqE3EU4eBFH3GaqnSPaM0HcdlpKjZ5tuWBF4GWNsVm5oqzf0dW+itGVAJNfXRTY+IZrPXO346NKmWy2O/jl2sAaSFKtKA63HVOdu6YaSX4H/tTfecepXsrID14LBOLe/IUCr7mSkKntYuf/HByk7oTShb2pTductqk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5350.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(7696005)(86362001)(66946007)(66476007)(122000001)(186003)(9686003)(26005)(38100700002)(66556008)(478600001)(33656002)(53546011)(6506007)(64756008)(110136005)(316002)(5660300002)(55016002)(8676002)(66446008)(76116006)(4326008)(83380400001)(71200400001)(8936002)(52536014)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?K2x2ZmpCODgvak9ub1N5NG1VK2Vod3lydThEZFNjYThBUXpBbVgwaE1DNHBv?=
 =?utf-8?B?cUEvcjEyMis3MXRBVGFVcFhGYWJUUmZ2bGY5blN0dytqVEpNcmsvVklRaUwy?=
 =?utf-8?B?RndYUUYvQlMzbnRzZGdRcTZNYTk0Y2Q0d0tncml6QWpCODVwbjM5MWc0cytP?=
 =?utf-8?B?NDlWanlTQXUrK2lFVFRKc0NhLzlpRnEvYjV1VVQ0UE0vSGZNSm1vSDlFOFdT?=
 =?utf-8?B?OFFQWDJrVm4vRkNJK2wxMzBxRk4ra2lPbXdBU0FvSFJ1L1NSOGJWVS9jYTkr?=
 =?utf-8?B?VXJDMTdaQlhUd0Z2NmQ0SzduOTRyUW8zRXcwOVo2eElYR3l4RmRacWFXTm9E?=
 =?utf-8?B?YTVBU1E4U1FFK1l4Mk5hOEs5TllRSE51ajM5QnhYRUQxZklrN2k2RDF2dGp3?=
 =?utf-8?B?OTZwVVl2YkFNUGpsZENQV3d1NDU3WFBRQnd0T0t6cG5yWEVCSy9lZVNRdUQ0?=
 =?utf-8?B?empudVhvaVFHZGx6Y1ZPZW9IWVA0Z2huV3VSZ1A2cFNYVXBRZUtEOHpsd1Ny?=
 =?utf-8?B?R2NWQ2R3QmxOb0lXQ0VxT2VtYldXRTVDZU9EcFRZdytkSWs5MWNEYm9MV2NY?=
 =?utf-8?B?cnZ1bVl6MDhiTlJDR3hTTCtpVFJUb1NyM25WWld6MW9RSU1nSTg4SElUcSto?=
 =?utf-8?B?R1dTNXdzNVM3dG41eUl2MjF6T1lsclp4aXR1ejQ5OVQ3VkRYNDFsTWpXMGUr?=
 =?utf-8?B?ZWgxaUExUHhNZ3VSLzN0K1dDMGkwUnBlNnV4MGtHOUt3Yk5IS1hZd1pPa0xm?=
 =?utf-8?B?enlwZmdxWnVWNjByN1ZKU0QvN0lRMTRZTW9XL3pjU05telM5RmoreEhjakFq?=
 =?utf-8?B?Ti9Hc3hRcTgwMUlsU1VwRjduZGdETXBlTHB3Vzc2RitSVlZwNitObldZdlJW?=
 =?utf-8?B?eHBxVEF1RkV3Rkl6VmgrZ2htQmt4dXY4NTJUZmc3L0pLOG05bGw4dG1IZ3R3?=
 =?utf-8?B?WkJ3RUQyQ0MydFZUWCtnNHFhNldKZXREc3AxSDl4RkJydHJEanFhdFhoak5E?=
 =?utf-8?B?emRqSjZlSE9aMEZtVGtPbXFlQW1aWFpSTXErM01lU1Nsd3NkUnZUb0NVa0xC?=
 =?utf-8?B?MU0wN1RVOGlsZFptdEtjZnozMDF3SHRzU0NDdURlbWxPSjFYclRwSkowTFBU?=
 =?utf-8?B?QVN5R2VTZUxNSWVJNEFEOFpnc0t5cytQRlBQQi9vWXRrTG1RUFNERUJlRFNQ?=
 =?utf-8?B?UEZuKys4U3gwOGMwU05BOXBMVFgxTWRERlUvcm1OWFNKMWFRcTZJT0I2cTZQ?=
 =?utf-8?B?b1UyTHhWZ1M5N0ZwY2JkZTUvTlkvZWVCa2E3RVBPWWRvdXdaU2svVnVsb2hx?=
 =?utf-8?B?cVIvREt6QXR2Ym9SNG92QkdEcDVkbkN3NWxwZ0hXYjkzNzRTZUNjbjA5cllY?=
 =?utf-8?B?cnUzaXBtdXRQdjFxY08zQzgxbldPT2gzT3gvbVNnL2F2WlFoTS9hWlo1TjRq?=
 =?utf-8?B?RGVhZjU3MnhtK2gyZkZWcko1cWlaQ1NEL2FBa1lSb0RHMFM3ZUtoQUQ1SlRH?=
 =?utf-8?B?NnlKem9vZGtPRW1TbXlJU2tZMTRWOUZ2WjJEWVJwbWpLd2tXaTBlS2VIZlUr?=
 =?utf-8?B?RkE4YWIxR2NrdllEaGNXY2pRYjZMMjhYcGpibkhwNmk4QUtjZ3hrUFVQQlBM?=
 =?utf-8?B?QTMvMGF0YXd2MjZGT0hWbHZBZlBCSExteVgrTFh4QjhFQ2JZSFZ4bG0xb0J5?=
 =?utf-8?B?c1JWNmxPZUhudHBrSzdhd0Zvd29vNmNqVXVFWHhVYmNmczVhUkxrRmFlVzhQ?=
 =?utf-8?Q?gg3K6pRaOYb9gk19V1f7XaF+C35Si7BAHMYZPil?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5350.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e26ed7c-9928-4e05-9c65-08d90ae8be40
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 08:28:18.8588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ik0qIIRlJrz/cIpBhJBYPk/iYoHWk6eG9uFCo8b3zm+4g5ixEuFsm9a98LMpOVjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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

[AMD Official Use Only - Internal Distribution Only]

This patch looks good to me.

Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, April 29, 2021 2:26 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: implement hdp v4_0 ras functions

implement hdp v4_0 ras functions, including ras init/fini, query/reset_error_counter

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 30 ++++++++++++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index edbd35d..330c0f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -59,12 +59,31 @@ static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);  }
 
+static void hdp_v4_0_query_ras_error_count(struct amdgpu_device *adev,
+					   void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data 
+*)ras_error_status;
+
+	err_data->ue_count = 0;
+	err_data->ce_count = 0;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
+		return;
+
+	/* HDP SRAM errors are uncorrectable ones (i.e. fatal errors) */
+	err_data->ue_count += RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT); };
+
 static void hdp_v4_0_reset_ras_error_count(struct amdgpu_device *adev)  {
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
 		return;
-	/*read back hdp ras counter to reset it to 0 */
-	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+
+	if (adev->asic_type >= CHIP_ALDEBARAN)
+		WREG32_SOC15(HDP, 0, mmHDP_EDC_CNT, 0);
+	else
+		/*read back hdp ras counter to reset it to 0 */
+		RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
 }
 
 static void hdp_v4_0_update_clock_gating(struct amdgpu_device *adev, @@ -130,6 +149,13 @@ static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));  }
 
+const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs = {
+	.ras_late_init = amdgpu_hdp_ras_late_init,
+	.ras_fini = amdgpu_hdp_ras_fini,
+	.query_ras_error_count = hdp_v4_0_query_ras_error_count,
+	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count, };
+
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
 	.flush_hdp = hdp_v4_0_flush_hdp,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp, diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
index d1e6399..dc3a1b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
@@ -27,5 +27,6 @@
 #include "soc15_common.h"
 
 extern const struct amdgpu_hdp_funcs hdp_v4_0_funcs;
+extern const struct amdgpu_hdp_ras_funcs hdp_v4_0_ras_funcs;
 
 #endif
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
