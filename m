Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F2CC3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 05:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74042064A
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 05:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SCsypj6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74042064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16506E996;
	Tue,  3 Mar 2020 05:41:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD716E996
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 05:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJO22tj4/YZkxbFfty6STDXueheufmo53DXrwGoDnCmAWCbGX5zY8EOVvB25AQjWHGnlr9LuUx2rHMuYhV8OgyTU6jG9sM0S9oLn/UZL/I++iCl3igv85AqIA6kPJfN2C6x4QJYfDkrEvYRfpzM0P2u8lyxw9WKeFj1L5ue1YNfMmktRUQDz9rulP0OI6QBeJe5mvWT8nAsMXJXpGSb19c8sBP7XrRiP3o1KXfTuOslw0iHmiAkt9e7tJU1gKHn2ewTAVjuZfhCtaaAZ/aG/+R5Uqy/uJx2bC/G6hv1Cs5wmn8q8CBIA39nOiGechMnF5oLOIxf0wSr54gmgGBbVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fwqG3ROLViOo4401BQMp9jYOEO345MZ3Z0XRLD8w8k=;
 b=J+RQpus0VdEFUwb8ZwTe5Ew2IRC8QwRwRdDJLYaNKXEpppodyY9/MFd3Yg7YH/BlQ6YsgIi0S4acflLqYk1ahsW8dF4MO2Jo9LOsfXykusY18N96ThWEflA60AAmDTKzkw7ZxNR7DxCLm/8dy1GijN3nf19F01riZT40RywmTuffW7Gv/dBWndox3K0Wjj4DSKKYiCIUufJYnChuTbn2iJdkJKbNIFjI7Cuyh8LjbrYaf8EAZx2Zwhq78OnWbBZxd5m76jf/+OXi66i/l50NBneEaHMB0pu59Qbus24D8LgU+utD+3GAeF+hqtTL2/Q/ywCErgc1dlMYiqyr6Fd3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fwqG3ROLViOo4401BQMp9jYOEO345MZ3Z0XRLD8w8k=;
 b=SCsypj6wnjU64yKCuNA5bMp6wTjL8FSvW0kdYdFCMIdplL028rF8wO8M9OrS/yohETb0/qLwOpyOC7X0p2N615ZdI6bo5DwL9j1D9ysebUHLVCS46RV7XxVOZCjv/wfo4bmpTvYhVuUJAwuJgXQi+35OyHLuitU7MIsFHe7Hl/M=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20)
 by BYAPR12MB3334.namprd12.prod.outlook.com (2603:10b6:a03:df::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 05:41:02 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 05:41:02 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>, 
 "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function for HDP
Thread-Topic: [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function for
 HDP
Thread-Index: AQHV8H4uEUaajje7K0SvQ5MEKVNXEqg2W4Eg
Date: Tue, 3 Mar 2020 05:41:02 +0000
Message-ID: <BYAPR12MB2806040DD178EE15CD7B8D8EF1E40@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200302103339.31723-1-Hawking.Zhang@amd.com>
 <20200302103339.31723-5-Hawking.Zhang@amd.com>
In-Reply-To: <20200302103339.31723-5-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-03T05:40:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=bae7c1ce-f8bf-4af9-99c2-00002da5fce0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-03-03T05:40:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 17458709-6475-4d13-8a45-00007affe361
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [101.224.57.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85b06697-c0e5-416a-f134-08d7bf3575ac
x-ms-traffictypediagnostic: BYAPR12MB3334:|BYAPR12MB3334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3334C1180F4AEA696E0F80C9F1E40@BYAPR12MB3334.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(52536014)(478600001)(4326008)(86362001)(2906002)(6506007)(71200400001)(5660300002)(8936002)(110136005)(316002)(64756008)(66446008)(33656002)(81166006)(66476007)(8676002)(9686003)(81156014)(66556008)(53546011)(26005)(186003)(55016002)(66946007)(6636002)(76116006)(7696005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3334;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i4dlKcJF6l7kxCFmCpv/v0j26JBqX45tFMV9KvkEZ0eycXy5IXf/ecoK6N2v3FFL7gteHQC78TjaaYOdqUw9X62Opbn+VCe1zcujniRyyGhZNqlg3slerlT9Hz1OAut8TNd4IQkqaid40VZ4HCCeqUUqRsDVQk8h5jP/XAzNKog9Ae1IaPs+8/ah3cEIL/i4ThmJ1bN/o7V4MT1m6Pvw4rQ6xu3Av9TElIUN/Thvl9x0k5zFOeadSt9GE8Qt3tbf5d5+xRjALyhFryoQcg28amKbSUpPpjKo98h8Eccld9tu3JERq/3clQt1/NdpGayZVb6fW+5fqZBJ/9BGw+CCZZD5gQ4vAYs5elp0ASx2BldxQnqNcGWGvHLKDD+AptJ78b939IoySCChnsS8Uf6Mbap3Ek/M6JVB5+QmcXRtOWIYq8MQGI/xOV+6kr9hfRatvhojBGRXiFoLojFfrqTn+Ne/IJtbzUJ4DTKRNprF3ez4gBbCIr06fgNYif3x30tt
x-ms-exchange-antispam-messagedata: jUr6jzIbUMxn8/UCmQxaH6HnR3k0NNBwNViNb0YtVQYzn3Ek+elA4XF2SG3YFEqm6dYjK1t++d0KKmYGHbq6t8RIHntrcnBKWExA/FRyS/sBGfUBeDFIRuxeHyWb/RkS/a91RPHiTf+dzXMyTi+EMw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b06697-c0e5-416a-f134-08d7bf3575ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 05:41:02.2905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEZPt7Fgda9d3QbB1Wca9Z7jPJEKsS3vXgW3u3XsH/MYOI8mJ3o6f7M0s5WSwyWpbH2LLEwQAYaKnsDG5v06iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
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

Series is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Monday, March 2, 2020 6:34 PM
To: amd-gfx@lists.freedesktop.org; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add reset_ras_error_count function for HDP

HDP ras error counters are dirty ones after cold reboot Read operation is needed to reset them to 0

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |  1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c    | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a58b0cf9da51..b735e20888a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -595,6 +595,7 @@ struct amdgpu_asic_funcs {
 	/* invalidate hdp read cache */
 	void (*invalidate_hdp)(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring);
+	void (*reset_hdp_ras_error_count)(struct amdgpu_device *adev);
 	/* check if the asic needs a full reset of if soft reset will work */
 	bool (*need_full_reset)(struct amdgpu_device *adev);
 	/* initialize doorbell layout for specific asic*/ diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b746f26f933c..efd52bcf8785 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4149,7 +4149,6 @@ static const struct soc15_reg_entry gfx_v9_0_edc_counter_regs[] = {
    { SOC15_REG_ENTRY(GC, 0, mmTCC_EDC_CNT2), 0, 1, 16},
    { SOC15_REG_ENTRY(GC, 0, mmTCA_EDC_CNT), 0, 1, 2},
    { SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT3), 0, 4, 6},
-   { SOC15_REG_ENTRY(HDP, 0, mmHDP_EDC_CNT), 0, 1, 1},
 };
 
 static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4aa5b9c8e43b..6b717691d554 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -827,6 +827,15 @@ static bool soc15_need_full_reset(struct amdgpu_device *adev)
 	/* change this when we implement soft reset */
 	return true;
 }
+
+static void vega20_reset_hdp_ras_error_count(struct amdgpu_device 
+*adev) {
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
+		return;
+	/*read back hdp ras counter to reset it to 0 */
+	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+}
+
 static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
 				 uint64_t *count1)
 {
@@ -994,6 +1003,7 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.get_config_memsize = &soc15_get_config_memsize,
 	.flush_hdp = &soc15_flush_hdp,
 	.invalidate_hdp = &soc15_invalidate_hdp,
+	.reset_hdp_ras_error_count = &vega20_reset_hdp_ras_error_count,
 	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &vega20_doorbell_index_init,
 	.get_pcie_usage = &vega20_get_pcie_usage, @@ -1239,6 +1249,10 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
+	if (adev->asic_funcs &&
+	    adev->asic_funcs->reset_hdp_ras_error_count)
+		adev->asic_funcs->reset_hdp_ras_error_count(adev);
+
 	if (adev->nbio.funcs->ras_late_init)
 		r = adev->nbio.funcs->ras_late_init(adev);
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
