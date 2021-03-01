Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB9CC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 11:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC83C64E37
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 11:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC83C64E37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E1289DA9;
	Mon,  1 Mar 2021 11:37:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27CF89DA9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 11:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8Gv8xq3hgagQ9UVslkigFf3Hw6Kn7ACiq5MnNkhT944hucUDjuiO+U0tC2zCpp5CgHKgUxe4q2Vvxp3IckNGDkYp3GUt5SLnNbZknpGM214CXhLsf9yT1GBMOkBIW7FW8fxILtNTfcEcxX//+znKGKim79+LHNbA49ylUZzi+teBYxoTESGHTQtED3GIangEGQ2+dfCYHHMQJD4k/tNiZHd19z4Ti0+Lei5DOUk6I6GF9LmeCfaqeE9pT+zZthhKphvtCXO0Rkza4hvp2AtFgICQlueyIRmBOQ2aLAZKpG86zJfUYsf7frBfBV2rvhpmE0j95HRiR5I7x5ntzjqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3gSFj5E5i/G1apJ9M8wpPbyc44UvbXqpo9binCsMoo=;
 b=JbsH098JSXvIoGT/+KWY5/AvBf4HeR8pRsoTYXqqRCcmTio2Bx9poNB3FbEKRFt8ARnudppuBYWcaJaPne2tkEB5SfDelwyJ52VEytYdrhhLr1LocmPNQDciFYT4PckvgBebfobxKz+oKnTZihqkVt2lASQD4VgZHcDitbIOqJDtlc26BVEWQY82BZBndgsnaC1aULvfEmpycbB3UBJZMdoMIhFrh5brWI9TanxyhwIP88T2aXDAeV4oOh5LJM2AcwWIbe6inEOzK/bIKw0rTCI7uXKaMZyJdrDABdw16KiinUpXD0zwKnRgjzV65dsB7T3SBjNe10gvzk47zzDzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3gSFj5E5i/G1apJ9M8wpPbyc44UvbXqpo9binCsMoo=;
 b=T/v3Vl2oqG+oR7xH0+sW37ioH/NQL9iV5scuYQ7Zw+WMXRCTI1p478mlKVPjupc8/iNptPNqq5nHMyQPmj2BRTbg9T8R274xmL1dH62sq3SE2GzdxDFqzpTnpjCyjikKoEcxRDh79pgYDMGTNQ8KO5v+RUK29bQrpNXou/AbHEM=
Received: from CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9)
 by CY4PR12MB1783.namprd12.prod.outlook.com (2603:10b6:903:121::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 11:36:58 +0000
Received: from CY4PR12MB1703.namprd12.prod.outlook.com
 ([fe80::b4f9:7823:86f9:7afa]) by CY4PR12MB1703.namprd12.prod.outlook.com
 ([fe80::b4f9:7823:86f9:7afa%6]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 11:36:58 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
Thread-Topic: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
Thread-Index: AQHXDAkTjsueu4oqfUOkVlWzFtQRVqpvBhcg
Date: Mon, 1 Mar 2021 11:36:57 +0000
Message-ID: <CY4PR12MB17036381E3A8C93A36AAC8E2849A9@CY4PR12MB1703.namprd12.prod.outlook.com>
References: <20210226063122.9902-1-horace.chen@amd.com>
In-Reply-To: <20210226063122.9902-1-horace.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-01T11:36:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=07a5187a-a59c-47ff-9411-b9b7d565459d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8632dc09-13e9-4294-c431-08d8dca6528b
x-ms-traffictypediagnostic: CY4PR12MB1783:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1783132BBF2BDBABC0D8262B849A9@CY4PR12MB1783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YqtdylvmzLrUikR4MVFh2hkY5NCj3u6PynPPj/Mz3MSRVVjmMkIgLuH07qyYoCZZKasNmouwTWoJp7BohuKNc/RQRy3qvGpz6JqwLgC40zgu52qedtMwHT4/yndB5IH6iMlcoKVJym1+9bSEpw2NcvMUPGjlPkcR9OY3DZfUjlESoGx/t+XmZPUNdK2waYN/SoxiNvEFb08lbC3hZwG4hZ5bOiwJf+tXM4j1WGRCjRpZacY9J1Y7h1AXQHCQWW5DSNk/a1EmiYb53FIQ8Deo8U3orzwq9r1NMv7qu6MUgtP4qFlMhpgEhJEG8XVyAe3iqQ6Miu/rbrXQYO72yXFs9AqvQg4LD+JqZQcd7OZnv5lNyNtBuHk0op+N6KKWEmFoCaRluj5byJlms4o8WoaSjcg/y8nyTdPSJu+ZDW7H/maEXLwQ7g0j8fKMaHbjMqnPYABTHvB/aofhmKH5aDCEIeEN8/niULosj3psqEY4+5WwdDB6bEs3SgJLV7ETgWmXTzXuKXalRxEoq95vslHxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1703.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(76116006)(64756008)(66946007)(66476007)(8676002)(186003)(52536014)(478600001)(66556008)(8936002)(26005)(66446008)(2906002)(83380400001)(33656002)(86362001)(7696005)(6506007)(9686003)(55016002)(54906003)(53546011)(71200400001)(5660300002)(110136005)(4326008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6GUjdoiGzj7VjO06XFv1sPi7UMYR6D6E5wiKAbcO8Xvoal5XSx1Xbe+tRd2M?=
 =?us-ascii?Q?OlOUje2qCqoXs+ErvPz+u5G+Zg/4t0WXltDYfQYHoPm9wipB7mZCz42mEv8i?=
 =?us-ascii?Q?Awn55BLwEr1IUgSBWfexeCfk0RbGmck9mIKWtGlkSeY/hjkzOAp8C8Q7oQbh?=
 =?us-ascii?Q?athgtqVqIEW1X4JhxZagQj/Wbu6OLZKkK9YzXr7f1CUwPgDSrtDCwOcb5WYn?=
 =?us-ascii?Q?MnloST0Rua6PR+/Gv8FA2hW53fmnE5DK+jsJEhljC3V72qDqiyIcIVSxpmBP?=
 =?us-ascii?Q?byBUnK7IZdJhC4bIJq7iC+F45a5qGyoGtSKmPM3fZtksEdfvdudc8UaRks8X?=
 =?us-ascii?Q?S1kgrMCa4gsj4SFKKgjZgyVCDJM2HWBkM9/R/h7FBYZAMYRe9pv2iBcyfyOW?=
 =?us-ascii?Q?dN2DagiTThrP6YxNObC+fn+0JUyaWRh4BZoRVpRo/pplsTg14xgj8zay5uRV?=
 =?us-ascii?Q?m+GPZnkzxWJ1KiqkJ+mT5X2DkXi0a82phRvkwy4UFSFctEVacrH43/oI6xlR?=
 =?us-ascii?Q?6TeIx9SsbKgimFYFmuKSXTsPp9P8U4Daj+q0ggMPrADiPWZ/CTQEF472LjwF?=
 =?us-ascii?Q?Soy0nvawwfMnPqRJ712RV/x078pFLcDkOzZIs/Nee3OlGDarVHdmFY7Z0xO0?=
 =?us-ascii?Q?F38CQWjR1YSmSgX+oHvNapXha9+WGivi4x4gOcM3FDfg3cr5lz1L92X1HmU/?=
 =?us-ascii?Q?0BS/xredmCVBggP9EilbLtgFU541rTWlMTbActYF2VoqHB/VB7J5k033xXdL?=
 =?us-ascii?Q?Kp2TBACMM9DclsAUiWnTUQoBIFtZXQpSjBSBKF8Djmjb0WIIjX6nt5j/2+Er?=
 =?us-ascii?Q?DIQ2n+nE6ebzsgpLq0mw74MBQJRYTsJmvTc9yMsv33uxSpJWQ1z/Oej0OS9d?=
 =?us-ascii?Q?HXl2+OBk/3X731Tn9z93Uyuhxc3YkzA2inWYLrQah3M5pDDzw78xmWKeKmsb?=
 =?us-ascii?Q?8s/SPKaM+MIc2v6yVhZTvNCo/Hh3lBtnUP3j1PCJSvsTl2lcn4BGtN5QvIpi?=
 =?us-ascii?Q?vIr6BOEdsTYC3jDLnlpq33YVx0uyhKrbipAnHej8dTISLEMR69/EXr8ouUsD?=
 =?us-ascii?Q?4ZDZLhSn6biQI99D0ynJs6iHvliGs1JJTSPDQEuVWBctmv9WUzLBsU6iLIsw?=
 =?us-ascii?Q?gpQF8MsldcDZANQDMuBmL/PAOxApYZfFSlowZTlji3TpQJzvX3oHdtyseipN?=
 =?us-ascii?Q?hsj/P+pl+gDeJr+kv/BcAoFtWcxqkf/WiYBCXcpfPkSbwnY5S79DAVWnOEzJ?=
 =?us-ascii?Q?sWVz650QO0BqI4cxlDZEkjNJ+F3MKKczDgJc6RCBJaTT8B7wkvZBV4gkVLAn?=
 =?us-ascii?Q?RIuT4Nn7HCd0JM7RlRHBIFZI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1703.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8632dc09-13e9-4294-c431-08d8dca6528b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 11:36:57.8439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dG2zkttrog9Nt5hIzFsxrerId0RP8Q7Ug09CHwcDXVjaCX4lIvG4FM+0UPs/7mM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1783
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Pls change " 	if (smu->od_enabled) {"             to       " if (amdgpu_sriov_vf() && smu->od_enabled) {"

With this addressed the patch is reviewed by me 

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Horace Chen <horace.chen@amd.com> 
Sent: Friday, February 26, 2021 2:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf

sienna cichlid needs one vf mode which allows vf to set and get clock status from guest vm. So now expose the required interface and allow some smu request on VF mode. Also since this asic blocked direct MMIO access, use KIQ to send SMU request under sriov vf.

OD use same command as getting pp table which is not allowed for  sienna cichlid, so remove OD feature under sriov vf.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                   |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 10 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c               | 12 ++++++------
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f0f7ed42ee7f..dfbf2f2db0de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2043,6 +2043,8 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
 		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
+	if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_SIENNA_CICHLID)
+		adev->pm.pp_feature &= ~PP_OVERDRIVE_MASK;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if ((amdgpu_ip_block_mask & (1 << i)) == 0) { diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b770dd634ab6..1866cbaf70c3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2167,7 +2167,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d143ef1b460b..7033d52eb4d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -612,10 +612,12 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	ret = smu_set_default_od_settings(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup default OD settings!\n");
-		return ret;
+	if (smu->od_enabled) {
+		ret = smu_set_default_od_settings(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to setup default OD settings!\n");
+			return ret;
+		}
 	}
 
 	ret = smu_populate_umd_state_clk(smu); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index af73e1430af5..441effc23625 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -89,17 +89,17 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
 	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,             1),
 	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,                 0),
-	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       0),
-	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        0),
+	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       1),
+	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        1),
 	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh,        0),
 	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow,         0),
-	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       0),
+	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       1),
 	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,       0),
 	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           0),
 	MSG_MAP(RunDcBtc,			PPSMC_MSG_RunDcBtc,                    0),
 	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   0),
-	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            0),
-	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            0),
+	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
+	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
 	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
 	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,            0),
 	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,               1),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index bcedd4d92e35..d955dc4c6998 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -73,7 +73,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,  {
 	struct amdgpu_device *adev = smu->adev;
 
-	*arg = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	*arg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }
 
 static int smu_cmn_wait_for_response(struct smu_context *smu) @@ -82,7 +82,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 	uint32_t cur_value, i, timeout = adev->usec_timeout * 10;
 
 	for (i = 0; i < timeout; i++) {
-		cur_value = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
+		cur_value = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 		if ((cur_value & MP1_C2PMSG_90__CONTENT_MASK) != 0)
 			return cur_value;
 
@@ -93,7 +93,7 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 	if (i == timeout)
 		return -ETIME;
 
-	return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
 
 int smu_cmn_send_msg_without_waiting(struct smu_context *smu, @@ -111,9 +111,9 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
 		return ret;
 	}
 
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-	WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+	WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
 
 	return 0;
 }
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
