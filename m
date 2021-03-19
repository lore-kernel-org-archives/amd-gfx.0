Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD379C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 11:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603F064ECF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 11:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603F064ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EA86E9E9;
	Fri, 19 Mar 2021 11:23:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770044.outbound.protection.outlook.com [40.107.77.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B146E217
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 11:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9ysjwLOyrpa0eBx1ptBWFT/WaUucNNqaEGYTT7yRqzYIaMFxjSGkkOgRuxQbNGkPWrwd64dfNA0WhsYQnYbYkSnrVkCCrpY2FQ0WLZtfhA/RQr5qCpvi2h/93K9kebO28Y7AyCKW9svfI5QbUTT3OCPzPZVOA7mJaBDWvCr5KP/LrpVlcFTLkoM41N8/v/JG5EIlX6Qe31uKZPtrWZ0ms3O8UEQUx77xs8rr8IemqClhThiBQkrsZbzs5toFbBm2S/fVCTqlGYa6A4+cXZ2f2ao/xBjLWLOeN/0wSFEQL1n2aJkrd2dHRwhj3c0vnkafQTn1T/aO+ze2AmVyBTOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsIPOp8Nc1fFcX48Veqb39DMRKta16Pen8gZnl1tn9I=;
 b=KcnvfF+7O+mwIHNBQbXw7OxkI/fydZMYnLK2mZhLl6KegPCQz85YbsP+NufpLM4n1FWvZHgLxSqDwoPfxtXLHm/M4mz3sWONr6US88T37VoMDEFfE3iYQhyoXwU/DAVhmnWR2Hq2zoPkzH8bC0NFFvmrk7wHJYRwvGwDXrcU3FHWFHwcnL0CjYvOqNF8pn8MwnXOvwiDsmPhZhCWdqvNW4675YTLDT+d/jtAa3lWB0U7Xhm57ldVemKhf8O71Ni83B4m/NIqIIPOzHykpSlCMOfGDaLVXPjFOg77h0G04UTaG5q3INXU+WJ5bZe44IPGMvZsSLL3a3sb8F0w7hDTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsIPOp8Nc1fFcX48Veqb39DMRKta16Pen8gZnl1tn9I=;
 b=TVKHLC5f1w9PVZtEm3KLEX9xCL3v1KQb513Qap6rUILVR0dd0+WsO063gFA0zdGcW2u3i8w/xpDKpoOruLEqzj9sipXmiXb8APuDLzbIU0Vx1Z3RMwgtDyBQA6xZcHa1X4YdGig6mu5stirU2tegl1OPQ6vrOZjE4G1RiH4zvKA=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3676.namprd12.prod.outlook.com (2603:10b6:5:1c7::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Fri, 19 Mar 2021 11:23:55 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::9858:1263:9afa:4401%7]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 11:23:55 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: drop redundant and unneeded BACO APIs
Thread-Topic: [PATCH 1/2] drm/amd/pm: drop redundant and unneeded BACO APIs
Thread-Index: AQHXHJ/+aGkUs+Cd7Eurn3aliN9fW6qLKqZw
Date: Fri, 19 Mar 2021 11:23:55 +0000
Message-ID: <DM5PR12MB2533143196D7A67C08F847BCED689@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20210319091155.537787-1-evan.quan@amd.com>
In-Reply-To: <20210319091155.537787-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-19T11:23:49Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9333f786-15fb-43a6-bf9c-d05b4ef53340;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03ee9c6d-c851-4a1a-3d01-08d8eac97b62
x-ms-traffictypediagnostic: DM6PR12MB3676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36764A0FAA3BAF61FD0D7340ED689@DM6PR12MB3676.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZZsBxjE3Q0KvDuwm+0X8x2fFYUIno0L+iQeV/JDo54kknEfCE9KzqucaSIH+Ujy7/dN5YEjUHdL12NWdMyZOKXvP7ScVDpsQYkDBZ4Ur57zrwa0RJL1LIFbcuJKJAISL8eLvZopyBtjpM5ZAvnS9SZ5AdA4Ge/Ka2tTFFvMZczfqVUaQDsmk4MltCq0Gq4Ngo2PmC05FExK/nHD3B7LSTjda5pppQUMqliQxCNsxk+jUiU0sWBVWS6XKBfz1jOOqnLqFmOyoB5uhpksPVjRYUSe6MpcRi4lyersLGw2TtUt92f+b42zBenm8jj0o3yiM7cmVp2/niFaKuTyyi2Kpt4vHXNipJhz4drqsD4nnw4eXB9MbhLNDmu/EggXR54sfzybL0wezDMb/7iC1ici/4GVxsu3qQTyRv+mf0PquDv8YfI3Ql9JurZ/XHmf0J40b+EmzXRiaBJ8eFBeYIybenuM7wswiuuBSwYTNkbWEbfkfklq9YY6FEMaC+EIwZ3wuhWv1x5wuoEKkYeNXIFMHKIAhSroihL7bW5i5SRxToLP7LeA0Fi/+03R6FimHlwfEYuDIBGUFBQ9TWQ9tihtKQAKsqBCm8M1F9XShO9GR3x2okAVThvLaBJWi2VEfGYF8wD/i8+GIcJ44M7FjenYSWx3H781EMEjVRvkqJIOoolSxPgEh5HbI01IpLvCEdOQFi/kMpYnToyhUwVEJB9/3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(186003)(316002)(71200400001)(76116006)(8936002)(9686003)(33656002)(64756008)(66556008)(2906002)(66476007)(966005)(8676002)(38100700001)(66446008)(4326008)(66946007)(53546011)(6506007)(7696005)(478600001)(45080400002)(26005)(110136005)(86362001)(83380400001)(5660300002)(52536014)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VUtPVWx4ck5KaHV5M2gzQ3FacXNjOE1mUTdIQmtLanlYTjAxWmRWekJsQnhF?=
 =?utf-8?B?bXlvYjhaaC8ydUUwN3ZNWTJIbW5idHRwVUVYZ2IxVXd6clhJSy91QXJWeVlG?=
 =?utf-8?B?WW5mUytyZk5ERzNtZ0MzWEpBYksyUEk0V0l5ZUJlZEU2MUdsMWZmckJBaWRo?=
 =?utf-8?B?UkVxdEF2enBuUjBXcDFJaHczWjBLYUQwNHJkY0FSWmtHMEF0Q3lOTlpPVzBy?=
 =?utf-8?B?NlcwVEJRWUtIMWIrSW5jMWdualVkQ2l3cUdLMFY3MTNFZ21nTk04SHZkbXYz?=
 =?utf-8?B?RGJ2S3RkNGYxN1NkNWg1cHp5RW1ScytaUGRrK3psbmZobnNJOEFOd0VGQVdU?=
 =?utf-8?B?ZWRNK3R2VklpNlNyLzltK0U0SHE3YXFOMEUxbFVHYjU4NEF4OXBLTkorNGd3?=
 =?utf-8?B?bDA1aHdVY2NBWkdrRGtyTkhOQUUzZVdtV2QyYXphYWs0V1Q1cm1NZ2x4S3gy?=
 =?utf-8?B?S3RJZmd6SVpmM2twblRISEpPVWZwUUs3MUF1bDRtRm1sUVcyUmd2TEFqalQ1?=
 =?utf-8?B?UGQ4VDB6RVlreXRZdEhESXdFNnVTNkdQNmt4RkhoUlN5NzJWdmM4SUhDeFJO?=
 =?utf-8?B?OEgzcFhhK3pGUUtDWmlYL0pDMXIxdU9hMTNDNEJSbWo0R2FYaUpKRDVZQm5M?=
 =?utf-8?B?U1o4K1BsS1NDcE5HVFlyRjNzeGpuOHVTNy85dXNHWnQxR25mZlhiT0hTYVZI?=
 =?utf-8?B?UjgzWjZpdGQ5QWpRN2tWYXI2L1Y3RVo2TTVidW93USsrM2dySklCZWFSTExx?=
 =?utf-8?B?Q2NDd3lBdkVMdFNOM2N1dXhOV2pMZ2wvLzBESVZuaXhKUFZaaEp5MXFob2d1?=
 =?utf-8?B?eE1PdkxaRTZMTEpNbHo4RUJRTzN3RmV1ZXQvNkhTbnR3WEdsbElSZHhwVTVa?=
 =?utf-8?B?RXR1OGhINHY3Q0VCdjZZV2JQcGR0QW9FYUxkLzYxK1E1MERadmNwSmdzYUEv?=
 =?utf-8?B?aDRBRE1mMUFqV0cwZGZVellNMDFqNVpuNmVwdlBSMDBSNWxyUnpIZTdtRWJH?=
 =?utf-8?B?aFRLamVVRkdCNHJLakhzaEVXQ2E1eDRlMFhwVVFBVk5RTm9vb3ZqL3llNEVD?=
 =?utf-8?B?c2E5dGFpbEJvdW15VHJITVEvd2RQZkhtWU9rSTJ1ei9TcDYrcDFmd2lYNDYv?=
 =?utf-8?B?bTJoUG9kM0hoMUUxSFE1dHdjTE56VG1jeTBrTWs0aFBxMzVDSXlreXpVSVhw?=
 =?utf-8?B?MkFGeCtrazlTZWNzR01rZTBMcUJHOVhXRHd5MENMelZ6OTU2S2d3OERuZ3E5?=
 =?utf-8?B?S2ljNFIwOGJmUkZzRGhicTlXMXZEdTgyR25pM3BFdGFmd1lCaEZCVW1scTlR?=
 =?utf-8?B?UGIrNEZBL2xQMVdMS05yQ245ZGdxekhrY0RlaTlmVTI4aGZieituTDdKaXJl?=
 =?utf-8?B?S2VBRTNHbncvRFUyckdML2J6U0lxakdtZGsrWUVwdjRKVmhiTlV1dW9uZEl1?=
 =?utf-8?B?OXgvQkVSQTR6R2pkbTlSR254KzBJdm16R2FUTHdnSHk5dzBzdXlGNlc2NHha?=
 =?utf-8?B?NDV4dUtJeGxjU0tBK3hjUkpMVDdhUTdQa1FuNnBZd1FXc1prN0FaRGVWYXVt?=
 =?utf-8?B?dis5ZHhwdkVEMjJJQjNURmhraG4wbkVJcHFBMHExRVpwRzNYU1N5bG1IcEU5?=
 =?utf-8?B?b3RkeUJVMUtOQzNnU3BBZmdPTG50RUcwZ1ExWjdMa2tNSWlQRWtTRWRQcm0v?=
 =?utf-8?B?dXhoWTQ3NUR6R0swZFU2SnVYM2ZYUDN1azFHY0VzV2w0SXJCMndkWVE2RVls?=
 =?utf-8?Q?vYHQ89/6DY7SGSb6BJO8dHURP7W4w3LFH2i8MzV?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ee9c6d-c851-4a1a-3d01-08d8eac97b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 11:23:55.1197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8HKS/n1jGE304wNGL3hBJsnM6YX0hWtQYH29UqsM/i3nh1STDB29Ep0YR/cqKVH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3676
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, Evan,
      It is better to replace all nv_asic_supports_baco callings with amdgpu_dpm_is_baco_supported, and remove nv_asic_supports_baco function. 

>>> static bool nv_asic_supports_baco(struct amdgpu_device *adev)  {
>>> -	struct smu_context *smu = &adev->smu;
>>>-
>>>-	if (smu_baco_is_support(smu))
>>>-		return true;
>>>-	else
>>>-		return false;
>>>+	return amdgpu_dpm_is_baco_supported(adev);
>>>}

Best Regards
Dennis Li
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Friday, March 19, 2021 5:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: drop redundant and unneeded BACO APIs

Use other APIs which are with the same functionality but much more clean.

Change-Id: I5e9e0ab5d39b49b02434f18e12392b13931396be
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c           | 20 +----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  9 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 95 -----------------------
 3 files changed, 3 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index e9cc3201054f..2670ae00c2e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -517,19 +517,12 @@ static int nv_asic_mode2_reset(struct amdgpu_device *adev)
 
 static bool nv_asic_supports_baco(struct amdgpu_device *adev)  {
-	struct smu_context *smu = &adev->smu;
-
-	if (smu_baco_is_support(smu))
-		return true;
-	else
-		return false;
+	return amdgpu_dpm_is_baco_supported(adev);
 }
 
 static enum amd_reset_method
 nv_asic_reset_method(struct amdgpu_device *adev)  {
-	struct smu_context *smu = &adev->smu;
-
 	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO || @@ -548,7 +541,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 		return AMD_RESET_METHOD_MODE1;
 	default:
-		if (smu_baco_is_support(smu))
+		if (amdgpu_dpm_is_baco_supported(adev))
 			return AMD_RESET_METHOD_BACO;
 		else
 			return AMD_RESET_METHOD_MODE1;
@@ -558,7 +551,6 @@ nv_asic_reset_method(struct amdgpu_device *adev)  static int nv_asic_reset(struct amdgpu_device *adev)  {
 	int ret = 0;
-	struct smu_context *smu = &adev->smu;
 
 	switch (nv_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
@@ -567,13 +559,7 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		break;
 	case AMD_RESET_METHOD_BACO:
 		dev_info(adev->dev, "BACO reset\n");
-
-		ret = smu_baco_enter(smu);
-		if (ret)
-			return ret;
-		ret = smu_baco_exit(smu);
-		if (ret)
-			return ret;
+		ret = amdgpu_dpm_baco_reset(adev);
 		break;
 	case AMD_RESET_METHOD_MODE2:
 		dev_info(adev->dev, "MODE2 reset\n"); diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 517f333fbc4b..02675155028d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1285,15 +1285,6 @@ int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
 			enum smu_ppt_limit_level limit_level);
 
-int smu_set_azalia_d3_pme(struct smu_context *smu);
-
-bool smu_baco_is_support(struct smu_context *smu);
-
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);
-
-int smu_baco_enter(struct smu_context *smu); -int smu_baco_exit(struct smu_context *smu);
-
 bool smu_mode1_reset_is_support(struct smu_context *smu);  bool smu_mode2_reset_is_support(struct smu_context *smu);  int smu_mode1_reset(struct smu_context *smu); diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4120d28f782b..1bb0c0966e3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2682,48 +2682,6 @@ static int smu_set_xgmi_pstate(void *handle,
 	return ret;
 }
 
-int smu_set_azalia_d3_pme(struct smu_context *smu) -{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->set_azalia_d3_pme)
-		ret = smu->ppt_funcs->set_azalia_d3_pme(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
-/*
- * On system suspending or resetting, the dpm_enabled
- * flag will be cleared. So that those SMU services which
- * are not supported will be gated.
- *
- * However, the baco/mode1 reset should still be granted
- * as they are still supported and necessary.
- */
-bool smu_baco_is_support(struct smu_context *smu) -{
-	bool ret = false;
-
-	if (!smu->pm_enabled)
-		return false;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
-		ret = smu->ppt_funcs->baco_is_support(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
-}
-
 static int smu_get_baco_capability(void *handle, bool *cap)  {
 	struct smu_context *smu = handle;
@@ -2744,59 +2702,6 @@ static int smu_get_baco_capability(void *handle, bool *cap)
 	return ret;
 }
 
-
-int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state) -{
-	if (smu->ppt_funcs->baco_get_state)
-		return -EINVAL;
-
-	mutex_lock(&smu->mutex);
-	*state = smu->ppt_funcs->baco_get_state(smu);
-	mutex_unlock(&smu->mutex);
-
-	return 0;
-}
-
-int smu_baco_enter(struct smu_context *smu) -{
-	int ret = 0;
-
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->baco_enter)
-		ret = smu->ppt_funcs->baco_enter(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to enter BACO state!\n");
-
-	return ret;
-}
-
-int smu_baco_exit(struct smu_context *smu) -{
-	int ret = 0;
-
-	if (!smu->pm_enabled)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&smu->mutex);
-
-	if (smu->ppt_funcs->baco_exit)
-		ret = smu->ppt_funcs->baco_exit(smu);
-
-	mutex_unlock(&smu->mutex);
-
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to exit BACO state!\n");
-
-	return ret;
-}
-
 static int smu_baco_set_state(void *handle, int state)  {
 	struct smu_context *smu = handle;
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CDennis.Li%40amd.com%7Cb00f935cbf75466856f508d8eab71ff8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517419531562871%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=J%2FeyHZ%2FPq2ASS5faBddw7PhJh%2FA2Jep4gKnbZ1J122I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
