Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A73C43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 00:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9499C207EA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 00:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n6rbErHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499C207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E7B6E0F4;
	Mon, 21 Sep 2020 00:53:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9431A6E0F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 00:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igsd1fOM01T0KYvH5loJSc7J2YBW6qfVlmaYVIqY2TycmrzU8kzNXiNKBzuV4PVo+QZnEP5eu644QxmmzJKJejL7ZOCC2ExXzPmd3j29ipPNnvgBiU/aWz2Cg/QNUEffJCtWSWcWfx5rZiz7t7ovU7l7v35MPmb/vRYyEUFt5FrXl9f7H4t10OcDXjGICiL9bIXEca0dpUUMXoS2IIZ/d7VSa/SCGU1klmIQzllzRe6MCehu1W2hcNdEOQ/VU7qbnlgN7Z8lgA3MF1rywf+YYERnTAOhn83dVpYdVeapEbM1Ta29S5qOB3zmsK/HdRm7xLz4hbTfHskprPYoTtPiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+sjTeeJKY/ONAAOLTpCbEjLcuwObcmyipGhVA8tKN4=;
 b=GcEySsZYYPwBnjq3TCxqmmwBX2zL+Flu2fyWjpGpmpjBLKbWq6vaQM6C6lLDbpsb2wGrhygOvrJ9Wk51mNcbz3qqOPGfdJIGhsN6YbP/3VnFdhtwov29KF7SBA23jOc2bVRyqJjmV4g5nlafJdKqPO5g05+YTlaWncHVUeR0sZNeWMzkYVQDVimFR2qdLww0DLHB1esRDcDFcVVoo7/AzOQlsOXgxf/fj9vokeb/bZn4JkqVpi5RGtKwExn1p/SOLsyq24H/SzRpi6mtZlnJbQHqARPmxkiqluja3r8l8v5myg6Ts1myfdZSb2TUvMfeTOC2fFdwvziPfI46inEcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+sjTeeJKY/ONAAOLTpCbEjLcuwObcmyipGhVA8tKN4=;
 b=n6rbErHUmusGg6C4sYHJhBhpG465lzSwfZ3tlPeI6wgJ6qiqmWC7VmKZCvVNXTyJMAWzGHw53E+AyPXlhC2HqytjBa5L3xpTKLjejZh5K5kYZ4zqnKjr/DkDrVUqWOGB4P5UXPjm+FjjsFMAPYRNdXctkeXVCD6DtY4GrWFEZss=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2503.namprd12.prod.outlook.com (2603:10b6:4:b2::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Mon, 21 Sep 2020 00:52:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 00:52:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: optimize the mclk dpm policy settings
Thread-Topic: [PATCH] drm/amd/powerplay: optimize the mclk dpm policy settings
Thread-Index: AQHWZp2WHc0ZiYTBMEuGj7vhPP7xY6lylcfQ
Date: Mon, 21 Sep 2020 00:52:59 +0000
Message-ID: <DM6PR12MB2619176B52E08A5F3128AA6CE43A0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200730181637.677551-1-alexander.deucher@amd.com>
In-Reply-To: <20200730181637.677551-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9b00358e-0858-4339-b8da-9982ebe75b55;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-21T00:52:41Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01f57a94-7603-4ce9-9753-08d85dc8af9f
x-ms-traffictypediagnostic: DM5PR12MB2503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB25033C70B674144B7347F6B1E43A0@DM5PR12MB2503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPaVMMOaaAkwdHrFRJml4zaB2kh0dxXNbVsXaW9m4BJmaQXKZ78xQRd4HEEZrr6IemznTPikf1hBVVO52Py6eZfPlKh+LgtK45cbH6qLsydF40wKjanIw4pqmxVEoF2sitO/CzNERadHTUbggsvc52n63JgmAwr+elfnHEZW196F6JTIizSw5ihSXo7ciVXJjxYtt5c+ueUR5w2alxye4Mozj6neKKu9/NcB7qTLFmBi+c3+gju1jIZpcO2y8kB5fu+gYAewhJhe8AeZuLpHzEq6FHpfAE6aReqObx2/zt1AMow5evFkNqGbGfFX/ITUW19Xm7Pl56xp6iFSbay61Irjs1/JILeWkludXNhY75F15JdyKaf/pjQahUiZZGSq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(110136005)(66476007)(7696005)(26005)(8936002)(66556008)(66446008)(64756008)(83380400001)(53546011)(86362001)(6506007)(66946007)(2906002)(8676002)(186003)(71200400001)(4326008)(76116006)(9686003)(5660300002)(52536014)(478600001)(316002)(33656002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 86KXmaGcmMSV9FZVlFKwQHRLUxXI5a3FWoGtMV1K8McSCx+w0FVciaEb7xo1o6erzer3xvnU9Y8QhlFmWTt+MoPvdPKE//K0Ja8CiHznpFPFj8jsMGfNq4SBwogfsIuHaD8ghRuBNdHMZpzZ8l0NFJsP0P2jYpGukg4n+X+sIRHosi9jYpN9bqArdreuZPhCqcQNeyiHtDjU4xF9xs0ZzsN8v9Ll3RjGMFageTYFRs2CJC4u2Ev0qq//FWLwIozzArwgdcO8988k91t67IJGKo7L+yNzzNSFWagT63kKv9LdUpjwbGkgbSadccl3LK6fK7p8xmesWSg/G+ek3LNFUA8+IKrFfAoZio0GefuG9B9yK+oSMWBLMECypwLvzvqC66tAC65Z1Q3T7FhG6P01CTbq2DHFdAPJHwObyIIVTWF6OWlmNbe3vwxLHII1w6qrNhVpKwZH8NJ6F+9SaRcU0mi7O9g69pCl6p8CWmocTm6dUuh6p8TUYMLNgKDLItuup6QFIwyOuZtElyjF8cuPMmxz35GMy6KH1WlfrYH9tga6jqivkrXHqYp0EPkEDlcnNyz0Ocvn59yYwOGiOCJRig6883hB2XaxOgjxbgSIVkh5ANKlqXqcBovUEi4QW4cbCCt1UZaV4WeNPwkx9Ytpxg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f57a94-7603-4ce9-9753-08d85dc8af9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 00:52:59.2700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTzYVfn13fwH+O1E3GbrwdDBNoZ49YzKxcPbNEIQQd3rmZPQsxdC2aT7TxBSlbQ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2503
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
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Friday, July 31, 2020 2:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/powerplay: optimize the mclk dpm policy settings

From: Evan Quan <evan.quan@amd.com>

Different mclk dpm policy will be applied based on the VRAM width.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index ffe05b7cc1f0..b81719433017 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -1585,9 +1585,19 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 data->current_profile_setting.sclk_down_hyst = 100;
 data->current_profile_setting.sclk_activity = SMU7_SCLK_TARGETACTIVITY_DFLT;
 data->current_profile_setting.bupdate_mclk = 1;
-data->current_profile_setting.mclk_up_hyst = 0;
-data->current_profile_setting.mclk_down_hyst = 100;
-data->current_profile_setting.mclk_activity = SMU7_MCLK_TARGETACTIVITY_DFLT;
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
 hwmgr->workload_mask = 1 << hwmgr->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
 hwmgr->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 hwmgr->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
