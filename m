Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3066C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 10:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A116320767
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 10:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HDeesAbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A116320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E6B6E895;
	Tue, 16 Jun 2020 10:03:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798EA6E895
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 10:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY3zMVdN2Nsg/gjljOk6yn9YPpL8tRPI7TfDsdt1bTU9aRQ7wrv9CJ3dnZ/p0R6kiM1w/zKN8LM7WLkVLe3l2DQ9BxuFaarmTvy+20Uj1JvxRsOEJI6G/fLhTizAnkklaqfqY4Pb6x1DBDVWiMfTOOnXYGi/qrG+SJ96UxQiFcpynKi8Qxaue0De591TsvL2Sy4Yhpht2ep2AXioP/2cysEFJFg93rexnmw0UhCioWFtOwtkGXe4/btR6dELfKq1kM/yJq5IASqu8QXBBPJ3fq7dJsl0GciemrKl/vhZpaalqX42KuAqvj5uOwqSknFOuvKk2QIJ9JEZ1GexTTP5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvWcjDKWVaJJgNHghkI4519Dn7733USDa6BN+hA3rrY=;
 b=n4Tj7lb+AWvraGdxcc38tjWe6+mpkoWHS4zIO7IBwDIlvs6gc2WiJStrZxPPuN3M3cHAmjGVhJFNCpp9SlfbCbk+N1YCKW0fRUodAs7cqlsXDsrm2xpZ1J2IpDSsbVa0cbTmG0Rjx3Wz9zRrFFogok0Oekf3MFbpZbxPqInM/Rj1FkOUa7i62/5UN7LOgkn3PzwtBBO1D6z1qYBndCZMP+pIrs4Vs95gZEKxXK4bvepjomRyuMcHez2KbCC3GEjURPv0oJCb1JtiD9HuGO8TA6XhEEYak9tsCOKTf43m2dMsLFf4Y0oR7/TCXSIOWao0TDODx4fkT7k7KzWiYbYdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvWcjDKWVaJJgNHghkI4519Dn7733USDa6BN+hA3rrY=;
 b=HDeesAbf9m4t/cb3T4tnzvdIVxXg0mcPTCBiVvPIfLTaMVgg57Oz8NopT5hiTnH0UKZEqbtS7rnkf3QVXc88BEpT7MMl84rMhcUBCl+Y3rPP225Pm3TDOGIEiTUP3SWnoVOKNT3ckamc6rvWVEwX1dhH1rv50a0VAauxr1UrIq4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Tue, 16 Jun 2020 10:03:09 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:03:09 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos
Thread-Topic: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos
Thread-Index: AQHWQ6yi7ks60OadZkSjglZ42zFyJ6ja9law
Date: Tue, 16 Jun 2020 10:03:09 +0000
Message-ID: <DM6PR12MB4075010E37CD01131FF6B279FC9D0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200616070546.4190-1-kevin1.wang@amd.com>
 <20200616070546.4190-2-kevin1.wang@amd.com>
In-Reply-To: <20200616070546.4190-2-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-16T10:03:02Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9b5d5996-9992-491c-8789-0000911b7fe7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-16T10:02:51Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f2784987-4b79-4bdc-8bc5-0000c2d68718
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-16T10:03:03Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ee042b91-76cb-4b8b-9fdc-0000bea01294
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 113c3173-4357-47ae-4d9d-08d811dc7958
x-ms-traffictypediagnostic: DM6PR12MB2988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2988299297287FA5D0952D6CFC9D0@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cmw/+BdLPSH66Z53Ee+CaUWSLSVpRtgb/xKs6jzlfFNXRT4KtwcETAfsNXlqCrwdmCV8jtMuBVFRHnU6Nfeq6Bz2UYTDq4+HjqSzxEUa/aZneLxZBcy0p9KThmniA+i79zeuEdtCGKmhNkUQ6sl4sd+ezQW0pB7wKLDzblMvzwF/IrqCFiEFg9Be1tl0jqRwl9T8kYzh6DQX98tsqaeXnLeJM5iIp2vdn6bcVfkvtJM09c/gQcuw9XjBqKOsQ6Fm2wxOy+EzxIzvNQHoMmuZ0Gm8wKgpXy0l/q4977JPiFEsSe7/sg9LQ2jzebJmjTY4vrNL2a5B0AKMxirryFrsxFcgEgN5+sgTqPHG41v2lXItNgewbPYl1NbKmbzQ6huX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(478600001)(316002)(83380400001)(55016002)(30864003)(71200400001)(9686003)(110136005)(8676002)(53546011)(186003)(33656002)(8936002)(52536014)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(76116006)(26005)(7696005)(6506007)(4326008)(66574015)(21314003)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wWdigcZbusCdUh76m9k5BeXCA7mVfnnfPAhfT+rve67JcZZSfA1p3u512A+Ihag5BIuoniGGVJqcYUTBn2NbkywiIX1Nbi02xGZKlVgy6Cy9lTtI4zX7hlVRIWC2whq1gaNxyvWdpoHlTJ8LqptYlMks+858JgliEJeDChMAfV1f9DVsGIyrmXEe4/G0u7MOWCHeiaBMLrD+yykwiFDF/uzzNOFreTCr2/kDEhd96JpsFvEZZUZlfYgDwEmXzaC5DtUItys5yEOrRVZa+AdvP/RHhFDMQXlMZWHMkUwiT0TRZhj8T9QPT1H05N2vBQ6T0ra+QI1fR+jdCVrPx/jZvN9Qvx++1UxffVl0exYYuSd2vL/SeSPWt/pkCZSKJm1can3WK1zbzCEjnCh+xq5DHoogVhGMwUquTvYw0mTqAb4k9l4FlW1cwqQtQzEjwkKXe0fipWQxHWl0pjALuHUXFPIeoGQqYvMciuXB/oIBQtKSf13n5oVU3m2fhShbFuji
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113c3173-4357-47ae-4d9d-08d811dc7958
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 10:03:09.7490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jck6F0O8ppaN8bv+CpE8y7nV2Q25bzsQTu+EW96qd8UWsDrGDUQYHMQrPSQk4+LcrsiXSnUn8t62DNWvVzhHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

The naming style smu_ppt_xxx makes me confusing..... at first glance, I thought you just have some dummy code or the patch is something still working in progress. It would be better to rename it to smu_ppt_funcs. 

Regards,
Hawking
-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Tuesday, June 16, 2020 15:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 2/2] drm/amd/smu: unify smu ppt callback marcos

add the new macro "smu_ppt_xxx()" to unify smu callback interfaces

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_internal.h | 266 ++++++-------------
 1 file changed, 82 insertions(+), 184 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 880ef54884f8..0f9841bcdcb8 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -25,191 +25,89 @@
 
 #include "amdgpu_smu.h"
 
-#define smu_init_microcode(smu) \
-	((smu)->ppt_funcs->init_microcode ? (smu)->ppt_funcs->init_microcode((smu)) : 0)
-#define smu_fini_microcode(smu) \
-	((smu)->ppt_funcs->fini_microcode ? (smu)->ppt_funcs->fini_microcode((smu)) : 0)
-#define smu_init_smc_tables(smu) \
-	((smu)->ppt_funcs->init_smc_tables ? (smu)->ppt_funcs->init_smc_tables((smu)) : 0)
-#define smu_fini_smc_tables(smu) \
-	((smu)->ppt_funcs->fini_smc_tables ? (smu)->ppt_funcs->fini_smc_tables((smu)) : 0)
-#define smu_init_power(smu) \
-	((smu)->ppt_funcs->init_power ? (smu)->ppt_funcs->init_power((smu)) : 0)
-#define smu_fini_power(smu) \
-	((smu)->ppt_funcs->fini_power ? (smu)->ppt_funcs->fini_power((smu)) : 0)
-
-#define smu_setup_pptable(smu) \
-	((smu)->ppt_funcs->setup_pptable ? (smu)->ppt_funcs->setup_pptable((smu)) : 0)
-#define smu_powergate_sdma(smu, gate) \
-	((smu)->ppt_funcs->powergate_sdma ? (smu)->ppt_funcs->powergate_sdma((smu), (gate)) : 0)
-
-#define smu_get_vbios_bootup_values(smu) \
-	((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
-#define smu_check_fw_version(smu) \
-	((smu)->ppt_funcs->check_fw_version ? (smu)->ppt_funcs->check_fw_version((smu)) : 0)
-#define smu_write_pptable(smu) \
-	((smu)->ppt_funcs->write_pptable ? (smu)->ppt_funcs->write_pptable((smu)) : 0)
-#define smu_set_min_dcef_deep_sleep(smu, clk) \
-	((smu)->ppt_funcs->set_min_dcef_deep_sleep ? (smu)->ppt_funcs->set_min_dcef_deep_sleep((smu), (clk)) : 0)
-#define smu_set_driver_table_location(smu) \
-	((smu)->ppt_funcs->set_driver_table_location ? (smu)->ppt_funcs->set_driver_table_location((smu)) : 0)
-#define smu_set_tool_table_location(smu) \
-	((smu)->ppt_funcs->set_tool_table_location ? (smu)->ppt_funcs->set_tool_table_location((smu)) : 0)
-#define smu_notify_memory_pool_location(smu) \
-	((smu)->ppt_funcs->notify_memory_pool_location ? (smu)->ppt_funcs->notify_memory_pool_location((smu)) : 0)
-#define smu_gfx_off_control(smu, enable) \
-	((smu)->ppt_funcs->gfx_off_control ? (smu)->ppt_funcs->gfx_off_control((smu), (enable)) : 0)
-
-#define smu_set_last_dcef_min_deep_sleep_clk(smu) \
-	((smu)->ppt_funcs->set_last_dcef_min_deep_sleep_clk ? (smu)->ppt_funcs->set_last_dcef_min_deep_sleep_clk((smu)) : 0)
-#define smu_system_features_control(smu, en) \
-	((smu)->ppt_funcs->system_features_control ? (smu)->ppt_funcs->system_features_control((smu), (en)) : 0)
-#define smu_init_max_sustainable_clocks(smu) \
-	((smu)->ppt_funcs->init_max_sustainable_clocks ? (smu)->ppt_funcs->init_max_sustainable_clocks((smu)) : 0)
-#define smu_set_default_od_settings(smu) \
-	((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu)) : 0)
-
-#define smu_send_smc_msg_with_param(smu, msg, param, read_arg) \
-	((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send_smc_msg_with_param((smu), (msg), (param), (read_arg)) : 0)
-
-static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_type msg, uint32_t *read_arg) {
-	return smu_send_smc_msg_with_param(smu, msg, 0, read_arg);
-}
-
-#define smu_alloc_dpm_context(smu) \
-	((smu)->ppt_funcs->alloc_dpm_context ? (smu)->ppt_funcs->alloc_dpm_context((smu)) : 0)
-#define smu_init_display_count(smu, count) \
-	((smu)->ppt_funcs->init_display_count ? (smu)->ppt_funcs->init_display_count((smu), (count)) : 0)
-#define smu_feature_set_allowed_mask(smu) \
-	((smu)->ppt_funcs->set_allowed_mask? (smu)->ppt_funcs->set_allowed_mask((smu)) : 0)
-#define smu_feature_get_enabled_mask(smu, mask, num) \
-	((smu)->ppt_funcs->get_enabled_mask? (smu)->ppt_funcs->get_enabled_mask((smu), (mask), (num)) : 0)
-#define smu_is_dpm_running(smu) \
-	((smu)->ppt_funcs->is_dpm_running ? (smu)->ppt_funcs->is_dpm_running((smu)) : 0)
-#define smu_notify_display_change(smu) \
-	((smu)->ppt_funcs->notify_display_change? (smu)->ppt_funcs->notify_display_change((smu)) : 0)
-#define smu_set_default_dpm_table(smu) \
-	((smu)->ppt_funcs->set_default_dpm_table ? (smu)->ppt_funcs->set_default_dpm_table((smu)) : 0)
-#define smu_populate_umd_state_clk(smu) \
-	((smu)->ppt_funcs->populate_umd_state_clk ? (smu)->ppt_funcs->populate_umd_state_clk((smu)) : 0)
-#define smu_set_default_od8_settings(smu) \
-	((smu)->ppt_funcs->set_default_od8_settings ? (smu)->ppt_funcs->set_default_od8_settings((smu)) : 0)
-
-#define smu_get_current_clk_freq(smu, clk_id, value) \
-	((smu)->ppt_funcs->get_current_clk_freq? (smu)->ppt_funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)
-
-#define smu_tables_init(smu, tab) \
-	((smu)->ppt_funcs->tables_init ? (smu)->ppt_funcs->tables_init((smu), (tab)) : 0)
-#define smu_set_thermal_fan_table(smu) \
-	((smu)->ppt_funcs->set_thermal_fan_table ? (smu)->ppt_funcs->set_thermal_fan_table((smu)) : 0)
-#define smu_enable_thermal_alert(smu) \
-	((smu)->ppt_funcs->enable_thermal_alert? (smu)->ppt_funcs->enable_thermal_alert((smu)) : 0)
-#define smu_disable_thermal_alert(smu) \
-	((smu)->ppt_funcs->disable_thermal_alert? (smu)->ppt_funcs->disable_thermal_alert((smu)) : 0)
-
-#define smu_smc_read_sensor(smu, sensor, data, size) \
-	((smu)->ppt_funcs->read_sensor? (smu)->ppt_funcs->read_sensor((smu), (sensor), (data), (size)) : -EINVAL)
-
-#define smu_pre_display_config_changed(smu) \
-	((smu)->ppt_funcs->pre_display_config_changed ? (smu)->ppt_funcs->pre_display_config_changed((smu)) : 0)
-#define smu_display_config_changed(smu) \
-	((smu)->ppt_funcs->display_config_changed ? (smu)->ppt_funcs->display_config_changed((smu)) : 0)
-#define smu_apply_clocks_adjust_rules(smu) \
-	((smu)->ppt_funcs->apply_clocks_adjust_rules ? (smu)->ppt_funcs->apply_clocks_adjust_rules((smu)) : 0)
-#define smu_notify_smc_display_config(smu) \
-	((smu)->ppt_funcs->notify_smc_display_config ? (smu)->ppt_funcs->notify_smc_display_config((smu)) : 0)
-#define smu_force_dpm_limit_value(smu, highest) \
-	((smu)->ppt_funcs->force_dpm_limit_value ? (smu)->ppt_funcs->force_dpm_limit_value((smu), (highest)) : 0)
-#define smu_unforce_dpm_levels(smu) \
-	((smu)->ppt_funcs->unforce_dpm_levels ? (smu)->ppt_funcs->unforce_dpm_levels((smu)) : 0)
+#define smu_ppt_xxx(intf, ret, smu, args...) \
+	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ? (smu)->ppt_funcs->intf(smu, ##args) : ret) : -EINVAL)
+
+#define smu_init_microcode(smu)						smu_ppt_xxx(init_microcode, 0, smu)
+#define smu_fini_microcode(smu)						smu_ppt_xxx(fini_microcode, 0, smu)
+#define smu_init_smc_tables(smu)					smu_ppt_xxx(init_smc_tables, 0, smu)
+#define smu_fini_smc_tables(smu)					smu_ppt_xxx(fini_smc_tables, 0, smu)
+#define smu_init_power(smu)						smu_ppt_xxx(init_power,	0, smu)
+#define smu_fini_power(smu)						smu_ppt_xxx(fini_power, 0, smu)
+#define smu_setup_pptable(smu)						smu_ppt_xxx(setup_pptable, 0, smu)
+#define smu_powergate_sdma(smu, gate)					smu_ppt_xxx(powergate_sdma, 0, smu, gate)
+#define smu_get_vbios_bootup_values(smu)				smu_ppt_xxx(get_vbios_bootup_values, 0, smu)
+#define smu_check_fw_version(smu)					smu_ppt_xxx(check_fw_version, 0, smu)
+#define smu_write_pptable(smu)						smu_ppt_xxx(write_pptable, 0, smu)
+#define smu_set_min_dcef_deep_sleep(smu, clk)				smu_ppt_xxx(set_min_dcef_deep_sleep, 0, smu, clk)
+#define smu_set_driver_table_location(smu)				smu_ppt_xxx(set_driver_table_location, 0, smu)
+#define smu_set_tool_table_location(smu)				smu_ppt_xxx(set_tool_table_location, 0, smu)
+#define smu_notify_memory_pool_location(smu)				smu_ppt_xxx(notify_memory_pool_location, 0, smu)
+#define smu_gfx_off_control(smu, enable)				smu_ppt_xxx(gfx_off_control, 0, smu, enable)
+#define smu_set_last_dcef_min_deep_sleep_clk(smu)			smu_ppt_xxx(set_last_dcef_min_deep_sleep_clk, 0, smu)
+#define smu_system_features_control(smu, en)				smu_ppt_xxx(system_features_control, 0, smu, en)
+#define smu_init_max_sustainable_clocks(smu)				smu_ppt_xxx(init_max_sustainable_clocks, 0, smu)
+#define smu_set_default_od_settings(smu)				smu_ppt_xxx(set_default_od_settings, 0, smu)
+#define smu_send_smc_msg_with_param(smu, msg, param, read_arg)		smu_ppt_xxx(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
+#define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_xxx(send_smc_msg_with_param, 0, smu, msg, 0, read_arg)
+#define smu_alloc_dpm_context(smu)					smu_ppt_xxx(alloc_dpm_context, 0, smu)
+#define smu_init_display_count(smu, count)				smu_ppt_xxx(init_display_count, 0, smu, count)
+#define smu_feature_set_allowed_mask(smu)				smu_ppt_xxx(set_allowed_mask, 0, smu)
+#define smu_feature_get_enabled_mask(smu, mask, num)			smu_ppt_xxx(get_enabled_mask, 0, smu, mask, num)
+#define smu_is_dpm_running(smu)						smu_ppt_xxx(is_dpm_running, 0 , smu)
+#define smu_notify_display_change(smu)					smu_ppt_xxx(notify_display_change, 0, smu)
+#define smu_set_default_dpm_table(smu)					smu_ppt_xxx(set_default_dpm_table, 0, smu)
+#define smu_populate_umd_state_clk(smu)					smu_ppt_xxx(populate_umd_state_clk, 0, smu)
+#define smu_set_default_od8_settings(smu)				smu_ppt_xxx(set_default_od8_settings, 0, smu)
+#define smu_get_current_clk_freq(smu, clk_id, value)			smu_ppt_xxx(get_current_clk_freq, 0, smu, clk_id, value)
+#define smu_tables_init(smu, tab)					smu_ppt_xxx(tables_init, 0, smu, tab)
+#define smu_set_thermal_fan_table(smu)					smu_ppt_xxx(set_thermal_fan_table, 0, smu)
+#define smu_enable_thermal_alert(smu)					smu_ppt_xxx(enable_thermal_alert, 0, smu)
+#define smu_disable_thermal_alert(smu)					smu_ppt_xxx(disable_thermal_alert, 0, smu)
+#define smu_smc_read_sensor(smu, sensor, data, size)			smu_ppt_xxx(read_sensor, -EINVAL, smu, sensor, data, size)
+#define smu_pre_display_config_changed(smu)				smu_ppt_xxx(pre_display_config_changed, 0, smu)
+#define smu_display_config_changed(smu)					smu_ppt_xxx(display_config_changed, 0 , smu)
+#define smu_apply_clocks_adjust_rules(smu)				smu_ppt_xxx(apply_clocks_adjust_rules, 0, smu)
+#define smu_notify_smc_display_config(smu)				smu_ppt_xxx(notify_smc_display_config, 0, smu)
+#define smu_force_dpm_limit_value(smu, highest)				smu_ppt_xxx(force_dpm_limit_value, 0, smu, highest)
+#define smu_unforce_dpm_levels(smu)					smu_ppt_xxx(unforce_dpm_levels, 0, smu)
+#define smu_set_cpu_power_state(smu)					smu_ppt_xxx(set_cpu_power_state, 0, smu)
+#define smu_msg_get_index(smu, msg)					smu_ppt_xxx(get_smu_msg_index, -EINVAL, smu, msg)
+#define smu_clk_get_index(smu, clk)					smu_ppt_xxx(get_smu_clk_index, -EINVAL, smu, clk)
+#define smu_feature_get_index(smu, fea)					smu_ppt_xxx(get_smu_feature_index, -EINVAL, smu, fea)
+#define smu_table_get_index(smu, tab)					smu_ppt_xxx(get_smu_table_index, -EINVAL, smu, tab)
+#define smu_power_get_index(smu, src)					smu_ppt_xxx(get_smu_power_index, -EINVAL, smu, src)
+#define smu_workload_get_type(smu, type)				smu_ppt_xxx(get_smu_power_index, -EINVAL, smu, type)
+#define smu_run_btc(smu)						smu_ppt_xxx(run_btc, 0, smu)
+#define smu_get_allowed_feature_mask(smu, feature_mask, num)		smu_ppt_xxx(get_allowed_feature_mask, 0, smu, feature_mask, num)
+#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)	smu_ppt_xxx(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
+#define smu_get_dal_power_level(smu, clocks)				smu_ppt_xxx(get_dal_power_level, 0, smu, clocks)
+#define smu_get_perf_level(smu, designation, level)			smu_ppt_xxx(get_perf_level, 0, smu, designation, level)
+#define smu_get_current_shallow_sleep_clocks(smu, clocks)		smu_ppt_xxx(get_current_shallow_sleep_clocks, 0, smu, clocks)
+#define smu_dpm_set_vcn_enable(smu, enable)				smu_ppt_xxx(dpm_set_vcn_enable, 0, smu, enable)
+#define smu_dpm_set_jpeg_enable(smu, enable)				smu_ppt_xxx(dpm_set_jpeg_enable, 0, smu, enable)
+#define smu_set_watermarks_table(smu, tab, clock_ranges)		smu_ppt_xxx(set_watermarks_table, 0, smu, tab, clock_ranges)
+#define smu_get_current_clk_freq_by_table(smu, clk_type, value)		smu_ppt_xxx(get_current_clk_freq_by_table, 0, smu, clk_type, value)
+#define smu_thermal_temperature_range_update(smu, range, rw)		smu_ppt_xxx(thermal_temperature_range_update, 0, smu, range, rw)
+#define smu_get_thermal_temperature_range(smu, range)			smu_ppt_xxx(get_thermal_temperature_range, 0, smu, range)
+#define smu_register_irq_handler(smu)					smu_ppt_xxx(register_irq_handler, 0, smu)
+#define smu_get_dpm_ultimate_freq(smu, param, min, max)			smu_ppt_xxx(get_dpm_ultimate_freq, 0, smu, param, min, max)
+#define smu_asic_set_performance_level(smu, level)			smu_ppt_xxx(set_performance_level, -EINVAL, smu, level)
+#define smu_dump_pptable(smu)						smu_ppt_xxx(dump_pptable, 0, smu)
+#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)		smu_ppt_xxx(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, freq)
+#define smu_set_soft_freq_limited_range(smu, clk_type, min, max)	smu_ppt_xxx(set_soft_freq_limited_range, -EINVAL, smu, clk_type, min, max)
+#define smu_override_pcie_parameters(smu)				smu_ppt_xxx(override_pcie_parameters, 0, smu)
+#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_xxx(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
+#define smu_set_thermal_range(smu, range)				smu_ppt_xxx(set_thermal_range, 0, smu, range)
+#define smu_disable_umc_cdr_12gbps_workaround(smu)			smu_ppt_xxx(disable_umc_cdr_12gbps_workaround, 0, smu)
+#define smu_set_power_source(smu, power_src)				smu_ppt_xxx(set_power_source, 0, smu, power_src)
+#define smu_i2c_eeprom_init(smu, control)				smu_ppt_xxx(i2c_eeprom_init, 0, smu, control)
+#define smu_i2c_eeprom_fini(smu, control)				smu_ppt_xxx(i2c_eeprom_fini, 0, smu, control)
+#define smu_get_unique_id(smu)						smu_ppt_xxx(get_unique_id, 0, smu)
+#define smu_log_thermal_throttling(smu)					smu_ppt_xxx(log_thermal_throttling_event, 0, smu)
+#define smu_get_asic_power_limits(smu)					smu_ppt_xxx(get_power_limit, 0, smu)
 #define smu_get_profiling_clk_mask(smu, level, sclk_mask, mclk_mask, soc_mask) \
-	((smu)->ppt_funcs->get_profiling_clk_mask ? (smu)->ppt_funcs->get_profiling_clk_mask((smu), (level), (sclk_mask), (mclk_mask), (soc_mask)) : 0)
-#define smu_set_cpu_power_state(smu) \
-	((smu)->ppt_funcs->set_cpu_power_state ? (smu)->ppt_funcs->set_cpu_power_state((smu)) : 0)
-
-#define smu_msg_get_index(smu, msg) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_msg_index? (smu)->ppt_funcs->get_smu_msg_index((smu), (msg)) : -EINVAL) : -EINVAL)
-#define smu_clk_get_index(smu, msg) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_clk_index? (smu)->ppt_funcs->get_smu_clk_index((smu), (msg)) : -EINVAL) : -EINVAL)
-#define smu_feature_get_index(smu, msg) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_feature_index? (smu)->ppt_funcs->get_smu_feature_index((smu), (msg)) : -EINVAL) : -EINVAL)
-#define smu_table_get_index(smu, tab) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_table_index? (smu)->ppt_funcs->get_smu_table_index((smu), (tab)) : -EINVAL) : -EINVAL)
-#define smu_power_get_index(smu, src) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_smu_power_index? (smu)->ppt_funcs->get_smu_power_index((smu), (src)) : -EINVAL) : -EINVAL)
-#define smu_workload_get_type(smu, profile) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_workload_type? (smu)->ppt_funcs->get_workload_type((smu), (profile)) : -EINVAL) : -EINVAL)
-#define smu_run_btc(smu) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->run_btc? (smu)->ppt_funcs->run_btc((smu)) : 0) : 0)
-#define smu_get_allowed_feature_mask(smu, feature_mask, num) \
-	((smu)->ppt_funcs? ((smu)->ppt_funcs->get_allowed_feature_mask? (smu)->ppt_funcs->get_allowed_feature_mask((smu), (feature_mask), (num)) : 0) : 0)
-
-
-#define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis) \
-	((smu)->ppt_funcs->store_cc6_data ? (smu)->ppt_funcs->store_cc6_data((smu), (st), (cc6_dis), (pst_dis), (pst_sw_dis)) : 0)
-
-#define smu_get_dal_power_level(smu, clocks) \
-	((smu)->ppt_funcs->get_dal_power_level ? (smu)->ppt_funcs->get_dal_power_level((smu), (clocks)) : 0)
-#define smu_get_perf_level(smu, designation, level) \
-	((smu)->ppt_funcs->get_perf_level ? (smu)->ppt_funcs->get_perf_level((smu), (designation), (level)) : 0)
-#define smu_get_current_shallow_sleep_clocks(smu, clocks) \
-	((smu)->ppt_funcs->get_current_shallow_sleep_clocks ? (smu)->ppt_funcs->get_current_shallow_sleep_clocks((smu), (clocks)) : 0)
-
-#define smu_dpm_set_vcn_enable(smu, enable) \
-	((smu)->ppt_funcs->dpm_set_vcn_enable ? (smu)->ppt_funcs->dpm_set_vcn_enable((smu), (enable)) : 0)
-#define smu_dpm_set_jpeg_enable(smu, enable) \
-	((smu)->ppt_funcs->dpm_set_jpeg_enable ? (smu)->ppt_funcs->dpm_set_jpeg_enable((smu), (enable)) : 0)
-
-#define smu_set_watermarks_table(smu, tab, clock_ranges) \
-	((smu)->ppt_funcs->set_watermarks_table ? (smu)->ppt_funcs->set_watermarks_table((smu), (tab), (clock_ranges)) : 0)
-#define smu_get_current_clk_freq_by_table(smu, clk_type, value) \
-	((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
-#define smu_thermal_temperature_range_update(smu, range, rw) \
-	((smu)->ppt_funcs->thermal_temperature_range_update? (smu)->ppt_funcs->thermal_temperature_range_update((smu), (range), (rw)) : 0)
-#define smu_get_thermal_temperature_range(smu, range) \
-	((smu)->ppt_funcs->get_thermal_temperature_range? (smu)->ppt_funcs->get_thermal_temperature_range((smu), (range)) : 0)
-#define smu_register_irq_handler(smu) \
-	((smu)->ppt_funcs->register_irq_handler ? (smu)->ppt_funcs->register_irq_handler(smu) : 0)
-
-#define smu_get_dpm_ultimate_freq(smu, param, min, max) \
-		((smu)->ppt_funcs->get_dpm_ultimate_freq ? (smu)->ppt_funcs->get_dpm_ultimate_freq((smu), (param), (min), (max)) : 0)
-
-#define smu_asic_set_performance_level(smu, level) \
-	((smu)->ppt_funcs->set_performance_level? (smu)->ppt_funcs->set_performance_level((smu), (level)) : -EINVAL);
-#define smu_dump_pptable(smu) \
-	((smu)->ppt_funcs->dump_pptable ? (smu)->ppt_funcs->dump_pptable((smu)) : 0)
-#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq) \
-		((smu)->ppt_funcs->get_dpm_clk_limited ? (smu)->ppt_funcs->get_dpm_clk_limited((smu), (clk_type), (dpm_level), (freq)) : -EINVAL)
-
-#define smu_set_soft_freq_limited_range(smu, clk_type, min, max) \
-		((smu)->ppt_funcs->set_soft_freq_limited_range ? (smu)->ppt_funcs->set_soft_freq_limited_range((smu), (clk_type), (min), (max)) : -EINVAL)
-
-#define smu_override_pcie_parameters(smu) \
-		((smu)->ppt_funcs->override_pcie_parameters ? (smu)->ppt_funcs->override_pcie_parameters((smu)) : 0)
-
-#define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap) \
-		((smu)->ppt_funcs->update_pcie_parameters ? (smu)->ppt_funcs->update_pcie_parameters((smu), (pcie_gen_cap), (pcie_width_cap)) : 0)
-
-#define smu_set_thermal_range(smu, range) \
-		((smu)->ppt_funcs->set_thermal_range ? (smu)->ppt_funcs->set_thermal_range((smu), (range)) : 0)
-
-#define smu_disable_umc_cdr_12gbps_workaround(smu) \
-	((smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround ? (smu)->ppt_funcs->disable_umc_cdr_12gbps_workaround((smu)) : 0)
-
-#define smu_set_power_source(smu, power_src) \
-	((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)
-
-#define smu_i2c_eeprom_init(smu, control) \
-		((smu)->ppt_funcs->i2c_eeprom_init ? (smu)->ppt_funcs->i2c_eeprom_init((smu), (control)) : 0)
-#define smu_i2c_eeprom_fini(smu, control) \
-		((smu)->ppt_funcs->i2c_eeprom_fini ? (smu)->ppt_funcs->i2c_eeprom_fini((smu), (control)) : 0)
-#define smu_get_unique_id(smu) \
-		((smu)->ppt_funcs->get_unique_id ? (smu)->ppt_funcs->get_unique_id((smu)) : 0)
-
-#define smu_log_thermal_throttling(smu) \
-		((smu)->ppt_funcs->log_thermal_throttling_event ? (smu)->ppt_funcs->log_thermal_throttling_event((smu)) : 0)
+	smu_ppt_xxx(get_profiling_clk_mask, 0, smu, level, sclk_mask, mclk_mask, soc_mask)
 
-#define smu_get_asic_power_limits(smu) \
-		((smu)->ppt_funcs->get_power_limit ? (smu)->ppt_funcs->get_power_limit((smu)) : 0)
 
 #endif
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
