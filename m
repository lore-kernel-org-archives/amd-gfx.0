Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CA9C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 11:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C201964EEA
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 11:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C201964EEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A8BD6E249;
	Wed,  3 Mar 2021 11:30:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF0F6E249
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 11:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8m/a39KZWpv56kDxw2GHBn6eOA9I6n35EqQKLZBzGspc3GTaL91waf8tvFIY0Cpe8xoEWSJ30aihCQZbWYXCDvs8PdGo/YYEzfPhpzuC2DTx8Gl573yYfQQ50/yZA04zCVP2Y2P2cwQpAX8O4a4+2k9zWxGvSkB/s8llP7q+w+MJWN1Whimzae9RsQShaAv7vgJi2/gV/Ty1D8a6wsTl9Tf5S0jmL31dPWejvHcnaQhlmRowi0QxRUMXZMbjTFTKwug7G4+c/eUFjXt0r6vqJejYQY9/UN1hI1pr6JTYU4wFnaIezFF1NV8mZilgZCvRZYYlvVaAxBn+NDnABbAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZovCHql2HRL/BJ3cPw1R8G9fysDPjC6BfYWArV9zl8=;
 b=WxmymHJVXUCX8g564QhNlXvqJiIxLypl9uWR1fLw6lT+8LhNYg/isOLVLcM4dlnaW8zhxD91nkrfte+TLW8W8cC+/GttUHzGK5rJs5ul9q/m0curPD+RTwc5cy3Zg1JhOWehzD0OVVEz4lfDSuwRlN0nLPTY/sZZU5LM/UUrrEhNDZ+kXzAs5MG5OdjvylqeVsU2YHhXCjXXGaAQ3YNMi3UED+VnXiG6I56BO4vb4R9yNiveciLW/MTXpnPm5Hody8tQbe/JbFNn9ccP1PdEywM17MjPHCnPVdC8M2CdCf7BS/lh849KYr034gEMwMEwHo+3cTzmF4G+SV77PVh3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZovCHql2HRL/BJ3cPw1R8G9fysDPjC6BfYWArV9zl8=;
 b=CO87ODCZ2z2QifHyaGx51p/AcNWVzUtEgKXssigBK4td9fHBsZuseA9hBLpeSPAxPRMjzRuHfg2/vAVXcRlcdl9rIgoPuTW+aNta+5cs21PpUrvtGQobtYnK05WhYd4yMPIL9zItSJfA+u04m7RKyXij55EqRzFbCKgEXc4A1iM=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Wed, 3 Mar
 2021 11:30:13 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7907:4699:3faa:e290%10]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 11:30:13 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
Thread-Topic: [PATCH] drm/amdgpu: enable one vf mode on sienna cichlid vf
Thread-Index: AQHXECBvpj0dm0VpC0uXk9Qsom7wUapyINhA
Date: Wed, 3 Mar 2021 11:30:13 +0000
Message-ID: <DM5PR12MB1708E8BA9F91A46521FE576B84989@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20210303112856.3251-1-horace.chen@amd.com>
In-Reply-To: <20210303112856.3251-1-horace.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-03T11:30:08Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c9fe4bfe-2885-4457-8a79-a0cf734c3e01;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 077dcd07-f63c-4a23-749e-08d8de37b669
x-ms-traffictypediagnostic: DM6PR12MB3868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3868ACC429FDBE30D96168CD84989@DM6PR12MB3868.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pS/08ImRtyAozUpPIn9muPsXiSvxmzr5BrzWFncjAPAlpj8liRFbbHMZpL8V0XMVd2OcNPuEIyXjp/lbANTYah6Fx9S7T297lwCBJuKs3PXKFqBxtb0T9kBJgPzlUVRLn+PAo+wVuN4AcWaN5Z7UMBy3qxrwl1t/Y/O76nAfTryzX72jvBhmuK3uXPnfm2ObyOpnDz6pJqB0GFWw1TRmFPtldADrPbiqTP5zBsVSCRM6OSJ8O1sS73pgvbPrGJ8WNBI/55kbXnQiUz9pcLdo4Mzy5YrGSXTbRFXH8sr0rVTyh3nToFh01DT05X531XqjwdvI2frcc4tRf7WPNJpnthpkTcIud4ra0oRbXfH/tFixi+8Awp9+/4Uw/Bh70YVWPM3UZm9/liGNLCTw4wCbyQuGxEGWQ2UVCP3DBrQ4w8NSjxT6z1X44fsD/cUL2E8iEzdCSF0BHhE+lMqxFoJP+hBpahU2ZnVYZNo3uE/akpRqipd4sneH6gU8GzXxR25A8hKV6m7Qn+R+V7q187c6mw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(66476007)(66446008)(66556008)(64756008)(66946007)(76116006)(6506007)(54906003)(110136005)(52536014)(86362001)(316002)(33656002)(71200400001)(5660300002)(186003)(7696005)(26005)(8936002)(8676002)(53546011)(4326008)(55016002)(9686003)(2906002)(478600001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?r9oib/B8ajWUwOixyf254AEYMR/GkkfbNF7YCt657x2vNk68DybOXw3ThDYH?=
 =?us-ascii?Q?m4UqkDUpFZY4yhLsf3o8viJ2g7MsI8AGHfGr5zn1BsGn/DgDlP/h0W53vAGA?=
 =?us-ascii?Q?saVAGKenHdDTLvBSy5nYBXXKTsbgqfgJfOSBJ34kkjgZHG6p3MIQSrEcgooY?=
 =?us-ascii?Q?iH+OKo0wWZGaJm220c4oLVqccJF02MYzwKBXlww6nz9+BZprPgDwoPP//b8d?=
 =?us-ascii?Q?DKpITW45sFLQJlKCWBisWyxR7pMoHI5Ssko2ukpOoWBMsBWVkyXWxptjBmpo?=
 =?us-ascii?Q?40xJQ1oKaTeb10XtIu4WZSmF4EuSljYZ556Wr8vDFVIqd+cBKxlod5GGRmg2?=
 =?us-ascii?Q?yEan1WZGcDs1AYvqKePi2G1fnOVOBERasD3yt0e+JMJDUv/Ilq+zG9SSgJeL?=
 =?us-ascii?Q?minl4FKmoNhWuVoziUlPQq3NJeJJvJ/7GEbJt9lwXR2Hm/GpOjdU/eK7Rfow?=
 =?us-ascii?Q?ny4Dq/eJ1unKXtA2vCub3eeYWqngJYhywDBiCvntcm3KGgQ7ikMUYV/ZJDlS?=
 =?us-ascii?Q?jokbnAU6r3/PPha/xaJJG2uGZtKTH7u+K0YZ2oO9A/dRCvn2nRTQpxrFsrG+?=
 =?us-ascii?Q?3WYIG6hGMTRS5ODXdV/jkSue5tPhSevoHVrrPFCsQmK4CnItwyW7ozrjwZdg?=
 =?us-ascii?Q?u0qv6IsFvEQ+POZdPNWuIaqDx5D8TbhIxs4LNIZBjK9zANLso673X1D6yF3I?=
 =?us-ascii?Q?OK4fS/+BYCai5QCyeSJG/ksK0dllirNd6FvnRBg52hBS01fDb8ix2VmJ8hgb?=
 =?us-ascii?Q?fnC61xnlHI7ZigQcFRzhhoWrVVzp6NDEQflRpG4QjbuvE5Yzug+eqDNttrF1?=
 =?us-ascii?Q?Ca2f6vV7x96lftGMetwetVGkcvDJ0XNleTbGOm0joEI3dN08SLrisB5ILlnN?=
 =?us-ascii?Q?a45+vshCAjet0QgX/ySL+dWs8SVMLsTfa1yMnWsz8prDidMAcVkX6ka/Vg7M?=
 =?us-ascii?Q?/wEjAtV4e9l63W+Yqhn5UbPlE76GS9fNGOuKIaDUy9KHrsTuKWt8VbBcqL0X?=
 =?us-ascii?Q?Abi2+LuWP6049c5fIzSr7OK+sjIP2yR5XWhYnXhqVi6sbgYGdnE4yJv0B54g?=
 =?us-ascii?Q?+uiOqGRtoONSTfZuTTmXGqGdwKiKmpGXpMVAQW4pu2Q1R2DpFrIWa2WRQbQV?=
 =?us-ascii?Q?pRMdUX/nI3qmp3d84PDNUB5kLHT8fksVa5Zo+Hlf/VG+9VUE2NRkTgjVVlZY?=
 =?us-ascii?Q?mprzGa1NLMhsLDWU7//xP9qQDFSJAry1yE8GCwj+y31xVc/tYMaypGtDquXL?=
 =?us-ascii?Q?+i+sh16OlpNp31QWIk7yM4/M7zndZrR4c1yMyTEnL1ZFwgV6+mUA3jmOz9uS?=
 =?us-ascii?Q?6MaDKBbi9uhQihYUi9PzqdTG?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077dcd07-f63c-4a23-749e-08d8de37b669
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 11:30:13.5638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhUBgq2GuicpmS1a4PGCcJj2sw89mkycoZHYnzWQZ6DJctPny99lYzhfwq1b8dyA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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

Reviewed 

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Horace Chen <horace.chen@amd.com> 
Sent: Wednesday, March 3, 2021 7:29 PM
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
index 71805dfd9e25..a11760ec3924 100644
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
index 5f77e1c9ebd4..f2a64bd47f42 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1750,7 +1750,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f5d9590f2178..3d0a165bf563 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -653,10 +653,12 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	ret = smu_set_default_od_settings(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to setup default OD settings!\n");
-		return ret;
+	if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
+		ret = smu_set_default_od_settings(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to setup default OD settings!\n");
+			return ret;
+		}
 	}
 
 	ret = smu_populate_umd_state_clk(smu); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c2d60d75be08..585db482c6d1 100644
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
