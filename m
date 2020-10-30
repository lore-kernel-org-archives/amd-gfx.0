Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B51FC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 03:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6330206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 03:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JIXqxJhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6330206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0823E6E94C;
	Fri, 30 Oct 2020 03:59:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288706E94C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 03:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDHfSLes6HSeyF2L+G7hFSNoFUJYUXn6R+GwhUEANSw2xCBiq86g7QeoPpIzaMrB/MeeoyIelf1c9NLLCnFvOpu2iL1NlyXv4Ku5L+j3f4OJpwaoO1UNczOAqf5XsMRx0YcYx3jvKSHTVVBcJeH6kBcLj7LWQovx9S3hWBQAcs5/814WTrpj35jPFqeOX/mBazX2k4I2TfDVkrghD81645tJ5d/N2Lv/z/l7VBXpzCRlp5QghED+CexCIqQMttaGEqOb5Kd/BAdGB5bxIqSeCHP9jOHlNNWXp5sdeU42+TMhidCX9MpeG779YAOkAO7AGQD1v0tHd+GFDgNDomLh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aLD2/8VxQKmVo75LucexQBMbzsgrqMx86cV2xIOsfM=;
 b=bDyofaF3uVBE0ToSV/5yEWKhwQrPplK8hSNREHShjUVmXuLOCA/lnpdhpCkhDw1vSbp4GxQIq2adgmpb761MSNHh7A7Tpb58n8Xzk21jvJRA1XWq0BR9k21ZqzYl4lLkDmlcXna7ZCq7+soN80om0K/VlNejrXOlms1D5h7kS39/G011/km4NNHXlhUqy5MqmARE+xI8Xb6OmYhC/gxWBWI2FvlLJPkAsPiMM23mGVhPco9YmfnHoYCo5W8f0dDhHHJn/IogEtUM3SVw5jO8xZfS8uW1+Fh5s3D0RYHnOcl5Qp5M/YMDZETROQNhERF5rH/+R1OOONThChK2KGHy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aLD2/8VxQKmVo75LucexQBMbzsgrqMx86cV2xIOsfM=;
 b=JIXqxJhbshk+Lzbc4x0FiJ+1Byb95ftbGykoudA/mn/f5zIlo8Q1+Xt3AY/xX3CWKylw8bQv3rhmUDfdTnojnYOXTbkhOF3wATeeWgxrSEycslJGQsAOZ1lO+cV1MLojEGTKslr4A2XC/29rqZcJCFvNw4npay5J4rkNZ+Lfl4c=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Fri, 30 Oct 2020 03:59:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 03:59:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/powerplay: Only apply optimized mclk dpm
 policy on polaris
Thread-Topic: [PATCH] drm/amdgpu/powerplay: Only apply optimized mclk dpm
 policy on polaris
Thread-Index: AQHWrTwt4St9kaCN2USHsVbVpofpQKmvh3gQ
Date: Fri, 30 Oct 2020 03:59:13 +0000
Message-ID: <DM6PR12MB2619D9D854859594BCFCBF40E4150@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201028150805.2400403-1-alexander.deucher@amd.com>
In-Reply-To: <20201028150805.2400403-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=65e85e74-80b6-40fd-9822-f7cfb33463ed;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-30T03:58:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8121ecaf-c9b2-4441-3bf1-08d87c8829d7
x-ms-traffictypediagnostic: DM6PR12MB4155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4155B1B4ED0E5588410A472CE4150@DM6PR12MB4155.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j1Xl/NC4XsEb7lKr1R/LEwuF2s7acSizbGEbSGukVV/Vt5QYY5U9dse23ur10RyyKuZyq0PuuVM7RkNWnnUlqPQjzY58g0Q8ecZqVwfj9coQp8zQISVo4XVQqX4xdfAnEoG5Kn7HK+dg8K+EWCltNvtsRB5tNGR2oxY58OAl9nzmDn5eRsfnZ2i64H+5+qkXlL9rLoIqBipYib+5Pgh6SqSErF/pA2AXfh6F/1i80csvqGKAi/Vw7K9iqsm/3JroI2hY90dKhs8zCwhSQ/XUIKiHIuDjrPVhlaHHmUKWC70IiA+FkLOORIxR6P449ral4jJp6EzYPSNeJ899RPR+63eUdfqTtVbu0LDra/Dp2n4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(8936002)(64756008)(186003)(76116006)(26005)(66946007)(316002)(6506007)(53546011)(110136005)(7696005)(55016002)(83380400001)(66476007)(52536014)(66556008)(66446008)(478600001)(33656002)(9686003)(966005)(8676002)(5660300002)(86362001)(71200400001)(4326008)(2906002)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DIN++CyBzzASNMj0KlaSaOWVvAWWSG3vd2i8ltOlWl9PRvMLZbaMlcA7DaMGzJHoisD6q+lqLMLbjbrJwqxRVOnmszIbKwgyeNmyJFXZ+mTMcJvrq9hV0+2u+ge4YuudZClVBQfGu0sOSQDo9NuMT9Fm8ffNtk8vwC+WGGWFW/0Mzv3RI6+AzY1WjS/TlHpbRL2I1J027pHayFdCPI0xe9+lV3rPm9DVK3OTo0Ymw257ivumH0YnylYNZ35sO9RrkDXrAnuO7eHcwBu9Ohfj//YvxJeuIU5SUvXgVZU9IVBs0kYeScU5i/9lEE2oUJZbkzz/qmwINkbZ/bxjZjN6VHESqytx8TDpW3I+ybJqVR1HhSlzxBx+/8vD2+g+SPFruJUwIQDho6ukSFVG9GMruAYjzsrQUppRDqSbY+P/YhRKB/r0WEMJ/D8ZcGiT/iwQLhRNbk7K1tXIV/7xKsowHNJHI4pNZeLyyh4etfZZNNJvaSWJsQU+MiIIAULnbg0u0QbOH3UUdxYgmA+hlqoy61M+657UkKQcxx2Zq+Ehg2/hGYkzJcC1p4/B282Xs2rmfGIctBXwM0lE2UBK4EsLwV/P71v4nfEUNzawVrjLBcbOpCHjM0ofRm7CAoOemqaE//qGbb26y2v9gkiXTmpvaA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8121ecaf-c9b2-4441-3bf1-08d87c8829d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 03:59:13.1053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqCMEkmvoR5qtcbhV25hqrUdVVzpovfW1Wk2HM7kuSGr9pSffXXARPQslfqT5g9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, October 28, 2020 11:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: Only apply optimized mclk dpm policy on polaris

Leads to improper dpm on older parts.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1353&amp;data=04%7C01%7Cevan.quan%40amd.com%7C67c0a0638f9c4e316c5e08d87b534d94%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637394945031668072%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vukW5jlFbTqB26IiUU7xljpRNf8muMWwh4sPQCB0IsA%3D&amp;reserved=0
Fixes: 8d89b96fe797 ("drm/amd/powerplay: optimize the mclk dpm policy settings")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 49db61a89505..d642dc95e9ea 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1713,18 +1713,24 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 data->current_profile_setting.sclk_down_hyst = 100;
 data->current_profile_setting.sclk_activity = SMU7_SCLK_TARGETACTIVITY_DFLT;
 data->current_profile_setting.bupdate_mclk = 1;
-if (adev->gmc.vram_width == 256) {
-data->current_profile_setting.mclk_up_hyst = 10;
-data->current_profile_setting.mclk_down_hyst = 60;
-data->current_profile_setting.mclk_activity = 25;
-} else if (adev->gmc.vram_width == 128) {
-data->current_profile_setting.mclk_up_hyst = 5;
-data->current_profile_setting.mclk_down_hyst = 16;
-data->current_profile_setting.mclk_activity = 20;
-} else if (adev->gmc.vram_width == 64) {
-data->current_profile_setting.mclk_up_hyst = 3;
-data->current_profile_setting.mclk_down_hyst = 16;
-data->current_profile_setting.mclk_activity = 20;
+if (hwmgr->chip_id >= CHIP_POLARIS10) {
+if (adev->gmc.vram_width == 256) {
+data->current_profile_setting.mclk_up_hyst = 10;
+data->current_profile_setting.mclk_down_hyst = 60;
+data->current_profile_setting.mclk_activity = 25;
+} else if (adev->gmc.vram_width == 128) {
+data->current_profile_setting.mclk_up_hyst = 5;
+data->current_profile_setting.mclk_down_hyst = 16;
+data->current_profile_setting.mclk_activity = 20;
+} else if (adev->gmc.vram_width == 64) {
+data->current_profile_setting.mclk_up_hyst = 3;
+data->current_profile_setting.mclk_down_hyst = 16;
+data->current_profile_setting.mclk_activity = 20;
+}
+} else {
+data->current_profile_setting.mclk_up_hyst = 0;
+data->current_profile_setting.mclk_down_hyst = 100;
+data->current_profile_setting.mclk_activity = SMU7_MCLK_TARGETACTIVITY_DFLT;
 }
 hwmgr->workload_mask = 1 << hwmgr->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
 hwmgr->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C67c0a0638f9c4e316c5e08d87b534d94%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637394945031668072%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=y0Q%2B5wPg9PnCLtSLMp8i5RdDSB6OH7WvRTRzi%2Bkx0E8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
