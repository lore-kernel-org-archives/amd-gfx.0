Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1228C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D8C20657
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4FasZ/zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D8C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8006E6E0B9;
	Tue, 21 Jul 2020 09:20:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 001246E0B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQR38RsF+giOUL6QtmOaAJxtPvNlPlX17yGjVpSSMMY7cr5lMC0ehEjlIoUrd0Qh2QfJ1lvt83yk4S5B15xxim1ILCt11Tegtx5bKW6/g7zL0UAHvXBpPQ2j2yabHmFrrERw1jSpzBrTRMz3rCphrA3Aar8AaDhnQHGTi9Ntt+iuLayKD5EvuHnnkMrGcR/F04fmHFABlzvB2fHI2KrdZnG6wvobf1M9XijF805Gm/m0F4M8UwXPK4YTv2vWtrNhNzaem9wsrQu+FmMb9AuKa0K+S+4z9+/lxOtH8iP7BmKbo1CjPozZcuWojVZ2zcb3W169Wi+ti+ww0EhCZy82sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEcfNkarmccc6VDgzQ9UgvgXn+1SbhtCobGJzyGppz4=;
 b=JOe4Oq5RuKCgHJZnjALPTHS48/T7uVrhvUZllkZ0aAhSRjrkXRp+0qqqRJrhlKpR19xe7ySUKFv/o0ihc4/zzUDyOaBB6Tu+tAk1H81UGwvp2SS8Ekap+r5BS6pKMP5PloVx0l0hWfOYFnvwqEMmDNyrR8YnDYcGxhnM/2nFMu6WXtGrCZtji6/Gr1gNV4cVcjsjR653kel7sV8/WD+L1Svwf9at22DqmpqdOkHSrzaCpEVIf4ur0bmQSIDTmfxGglnlX4VaQiziWDevHGTl4NQ4FsPHpg9JialGAqePhoy6IN+C60SHdY5wWmOpCV7ka+mAgapeLUsiaJ+ELLmFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEcfNkarmccc6VDgzQ9UgvgXn+1SbhtCobGJzyGppz4=;
 b=4FasZ/zgOspQ/oXWRiNcsgXtZ1EgS2Y1FP6sUk/dy/ElR/C4mMRFhuD7zcc6yHvIpckxbiEwlE6vuxrC39Vs4v+awnWsMszUAilgI8OGzeYoeFVBajMPwdj4lsp1hY1lOv31XDlLdyIFbhlw7zG8vfDU3wpWHA9hAHQQeyM1yuo=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2694.namprd12.prod.outlook.com (2603:10b6:a03:69::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 09:20:35 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440%7]) with mapi id 15.20.3174.030; Tue, 21 Jul 2020
 09:20:35 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: retrieve VCN dpm table per instances
Thread-Topic: [PATCH] drm/amd/powerplay: retrieve VCN dpm table per instances
Thread-Index: AQHWXz2Ci6faP/m/TUajqdW6tF5dNKkRwUew
Date: Tue, 21 Jul 2020 09:20:35 +0000
Message-ID: <BYAPR12MB28886358935A6C7097EE37EBB0780@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200721090109.2733-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200721090109.2733-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c659efd9-b86e-4675-9451-0000db1b45e3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-21T09:18:23Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 438a6e06-301f-45bf-43b6-08d82d575324
x-ms-traffictypediagnostic: BYAPR12MB2694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2694358AD5D2CD83D37D6872B0780@BYAPR12MB2694.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 13F2jh6GRYZx62zMZS4tPXw/fjy94E0H6L3pouAMTHdjpgh2LNEgqQm3YysUjawvBiYVJIKU9M+DBRCLgWaAlaVM2eZ7xkc4lNlR/E62LIxOceur/i9DJCQw4Iywo72JxYIXlULA/e5RngYMajCLIFvMxOy5KYvq2Lu1U2rsjE69y8feUE9sIuTQe9TCrNHHKxO8Db7vmu/deQmUn8tPfT52cMxBPaP1KzeEz79+YVfwJZc3zDXSd+zYI8FoJhTPTj59XcehBw0YpVnkHD+UoQc/8vamfjMUTB/cLjAAuWfqQkPX4SCBU7Q726orDttYURsXNCk+qha5xfHIEFhTlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(8936002)(6506007)(478600001)(53546011)(316002)(7696005)(66476007)(2906002)(9686003)(86362001)(66446008)(33656002)(4326008)(64756008)(66556008)(26005)(54906003)(76116006)(5660300002)(186003)(55016002)(83380400001)(52536014)(71200400001)(66946007)(110136005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: VmJcC0kzkrODTGAorR2aHmGBebyY142TOslyEuvD70eAq8R9II2UmQ50cHL4fyQftoqxgDm5NJdNMMno0NAMg/t5mSWibE+2hsU0z5WL2M8TzAwqvbJF/pCPw2s4rTEcN8sXQwcsfVGayG9qPATTYqczt17kk9x33DPnDLbuX/eOC314iHoFCgJ0UdLyMtw39LPWPGrby88d6eWMZ3pJySYuHVF/MxCwM5B5BeG2OloyvvNO0Th6kD16WE45WOqh+SAcVuo6+8ZzOgxLnCQqNghnm9Hl22qmcMiKVrKBQ8FWk3wiSrheE34maxldwIWf6q17I9Usf3qr26r+hp67bzVAr/JKsY4nLGnpx8J/HAO/u/dJ1eBkibkhDiI9++0Gz8bkl8ZI5avjToFyZVL3x8OQpuz1JyQtFKped+zQChfG0QoZsE5mI15D4kLW9UNFNF0y9QmYcRLcSxT6OirsNotOk/C6ko1qOZE4s3nfh7M2/QEPdGdGhnWfBhP0qjl9
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438a6e06-301f-45bf-43b6-08d82d575324
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 09:20:35.2615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3ejmMDJEtntADzI+HfEjLmr2EfE8s9wBzKMZFfs1DU21upSE4oSrGFvubEpoo+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2694
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

With my comment below fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Tuesday, July 21, 2020 5:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/powerplay: retrieve VCN dpm table per instances

To accommodate VCN instances variance, otherwise it may trigger smu response error for configuration with less instances.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I0bfe31f1f5638d539ac6ded3bffee8f57574bafa
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 68 +++++++++++--------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 87eedd7c28ec..c8b59a891f5d 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -525,6 +525,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
 struct smu_11_0_dpm_table *dpm_table;
+struct amdgpu_device *adev = smu->adev;
 int ret = 0;

 /* socclk dpm table setup */
@@ -617,22 +618,26 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 dpm_table->max = dpm_table->dpm_levels[0].value;
 }

+
[Tao]: Please remove the redundant line.

 /* vclk1 dpm table setup */
-dpm_table = &dpm_context->dpm_tables.vclk1_table;
-if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-ret = smu_v11_0_set_single_dpm_table(smu,
-     SMU_VCLK1,
-     dpm_table);
-if (ret)
-return ret;
-dpm_table->is_fine_grained =
-!driver_ppt->DpmDescriptor[PPCLK_VCLK_1].SnapToDiscrete;
-} else {
-dpm_table->count = 1;
-dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
-dpm_table->dpm_levels[0].enabled = true;
-dpm_table->min = dpm_table->dpm_levels[0].value;
-dpm_table->max = dpm_table->dpm_levels[0].value;
+if (adev->vcn.num_vcn_inst > 1) {
+dpm_table = &dpm_context->dpm_tables.vclk1_table;
+if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+ret = smu_v11_0_set_single_dpm_table(smu,
+     SMU_VCLK1,
+     dpm_table);
+if (ret)
+return ret;
+dpm_table->is_fine_grained =
+!driver_ppt->DpmDescriptor[PPCLK_VCLK_1].SnapToDiscrete;
+} else {
+dpm_table->count = 1;
+dpm_table->dpm_levels[0].value =
+smu->smu_table.boot_values.vclk / 100;
+dpm_table->dpm_levels[0].enabled = true;
+dpm_table->min = dpm_table->dpm_levels[0].value;
+dpm_table->max = dpm_table->dpm_levels[0].value;
+}
 }

 /* dclk0 dpm table setup */
@@ -654,21 +659,24 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 }

 /* dclk1 dpm table setup */
-dpm_table = &dpm_context->dpm_tables.dclk1_table;
-if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-ret = smu_v11_0_set_single_dpm_table(smu,
-     SMU_DCLK1,
-     dpm_table);
-if (ret)
-return ret;
-dpm_table->is_fine_grained =
-!driver_ppt->DpmDescriptor[PPCLK_DCLK_1].SnapToDiscrete;
-} else {
-dpm_table->count = 1;
-dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
-dpm_table->dpm_levels[0].enabled = true;
-dpm_table->min = dpm_table->dpm_levels[0].value;
-dpm_table->max = dpm_table->dpm_levels[0].value;
+if (adev->vcn.num_vcn_inst > 1) {
+dpm_table = &dpm_context->dpm_tables.dclk1_table;
+if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+ret = smu_v11_0_set_single_dpm_table(smu,
+     SMU_DCLK1,
+     dpm_table);
+if (ret)
+return ret;
+dpm_table->is_fine_grained =
+!driver_ppt->DpmDescriptor[PPCLK_DCLK_1].SnapToDiscrete;
+} else {
+dpm_table->count = 1;
+dpm_table->dpm_levels[0].value =
+smu->smu_table.boot_values.dclk / 100;
+dpm_table->dpm_levels[0].enabled = true;
+dpm_table->min = dpm_table->dpm_levels[0].value;
+dpm_table->max = dpm_table->dpm_levels[0].value;
+}
 }

 /* dcefclk dpm table setup */
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
