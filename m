Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577EDC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 11:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A69220717
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 11:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1gLyXIdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A69220717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7AD589DA7;
	Tue, 21 Jul 2020 11:18:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3025889DA7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 11:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbXYiVaoZ2UcM0JNpb/QxhLAOKZ3GcefiTiupIAROZIuudUVqIlkN8UbQkn/6g6LE9tOP+xGmRcseW/bfXAt36gU2Q0uNmgcWNTdCSK5HAAGrqeKUOVsrhH2nxE1xaT3ASdN5rXLNqgpPsNsjNO8TBtgjYPt8ZURbYCF9zgrYzcUuri/xAsMXm1JD71tCWDOWau+lhDRfALsGgJz3DTmg9PkWsB2HiwbaRACnvN/CRIkEwmsFMjJRNZLRSZaDciuO+3nb5FREzEDL2AI4cEOh7ZSudkE5TEQmk/UzD9uPmrzC4LjU2FxFAU2q7DErIjhjHPP7ncrCtraNiW8nbI3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRwg1xoQD6MuCyE8s8PdpfwjYp6+m8GnWk0iTrwTkOo=;
 b=VVsU4vTdXPS4EN62qTmBYxkG8LYUDXwI1b8e4bGuzEklZPUpVWNKIBid3M5fAS1Q59inRDksth0Qh8Ts2l6VQBZRtDiYVrzWZrRQUYAqsEHPan+w6rWUrBf6GV6bZX2BT8adCrvNRqXCt5SxSn9VORViZzNC0zJOkeAHDKmBdCZHaVMja54TTZCkYJbD6VHoNaNVFBLV4hIVQ6QPh2hBXbduWudA/BNZ6Xb/ZFls12xTbePWlAfOIJpqO2abojpaIAAzjRSa5npkR4+wk44crCOb3KYRT1YSQgchk+U/WbesMHqmHDqMLB3MT6lPVaq1Ky29ib8KIG4zoKLPA8Hy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRwg1xoQD6MuCyE8s8PdpfwjYp6+m8GnWk0iTrwTkOo=;
 b=1gLyXIdiGl+ZDN+AORA6Y+kN9ZrI+tOqucEaGfqWPC8MiW2ZHXbLmF0x6sgjyJbQ9g9tsCoTYldg8lUwdGBnrsJ1eIAwZZK1XWO2g8Yyf9Lr8jWS4mBCwu7dtdCM99mBO3rfJ36Mb605m48KyiIW2yOyA6PfBQJOEWtNe3LJKPY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:a::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Tue, 21 Jul 2020 11:18:29 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%8]) with mapi id 15.20.3216.021; Tue, 21 Jul 2020
 11:18:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: correct smu message for vf mode
Thread-Topic: [PATCH] drm/amd/powerplay: correct smu message for vf mode
Thread-Index: AQHWXzrzO7ApQzx1vkavo71+jp14wqkR4rmw
Date: Tue, 21 Jul 2020 11:18:29 +0000
Message-ID: <DM6PR12MB4075513B0E3125D0FF9E3CE4FC780@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200721084245.1256165-1-likun.gao@amd.com>
In-Reply-To: <20200721084245.1256165-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-21T11:18:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=62e3b113-8560-4c5e-bb27-0000cfb836f8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-21T11:18:19Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0b2cf129-42c5-468f-9bf8-0000948f1d0d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-21T11:18:26Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0447c424-0bcf-46c5-910a-000060487108
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da42ead7-7bca-4002-c32e-08d82d67cb78
x-ms-traffictypediagnostic: DM5PR12MB1452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1452EEE9D7ED716FBA80FAD0FC780@DM5PR12MB1452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L4RdqnfEaiDLz4/HOGWvt4Y/XUtZrw8Y/9eVkMKVWd8mubOwnE7lF5YvAAxmOPOqcKn/dlrbZSJ+NScc/4kCpDD4GIWT5NEGZK+gslVPbtA+Wr/SJKUftzNEyOakiFSFwbj+a51FGzmwZi3rtkZXfyksT0S/tOfNp+B2nNJm9i2d3C/AKDCO0p0s69BjRB32EKfcJbKgT+Cyo32u+TMyGRtr3zLdrpbqqhD3nX9GWtzV30FlpJmubbLaLzJKfk1/18GEOG64P1FGY3qcF1lYLx776Bj37vcChd11jKhQBZwKcDOX7pYftMUQFJaEOgo79iq5uEL0cG0aUJ8Be/FkYw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(66946007)(15650500001)(64756008)(66446008)(66476007)(55016002)(66556008)(478600001)(83380400001)(76116006)(8676002)(9686003)(4326008)(5660300002)(33656002)(2906002)(7696005)(6506007)(186003)(71200400001)(316002)(52536014)(26005)(54906003)(110136005)(53546011)(8936002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: O5Zgtbb4lzrgwzKoyIm8ElPqpLBn6ogcf94ria5A3uDLS+vU0T22vumKNULLpSCEW/VSuIxLs7dKRRu4aMLC4f31p0svHeMncIXGyctUNlKsphdWvoxOTFQBaoLGC5ajuik2h2VaoQgI4ucOHux/ZkAwMoZI2WGQWsG7nlrcxBJsiV/O7I2HWFu8N+ZgDMjwey7eL8/UFeM8cfoDcLLM0gR5HD/z0A70lz1dKilspIQpLbRhgFsD9rdrH7Pj1YtxwU8Jle0C16Vu/F9iwB5H4BkPbB8ce1B0BxqBjXYUwobuxWBWHx1dk9wEOigBva1xqY3sPMEkzzAXlrqSkzpKh6mhYaseD0cUvPBR/UIO6VxktcF+sHlCNtnPneM2md/bS0YZpj6y8X5aRjMq1nBt9T5ChWuS+tt82UK5scoORWgfVqTUMMCfJOpv2BWKGZ6o/wZc0L4gbO4YVCfUVkAfyyCOR3m8r5VsIbdaU4SMBB9DTNtpUNoXoqOv+N5sFoti
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da42ead7-7bca-4002-c32e-08d82d67cb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 11:18:29.0271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +55iRH7bZY410n8ys9HVtvrBPU43rKAY69MX4DZpbxHE7Jze/MzFUWCRVVNdis3uwLOhSQAog450VvLe8U/Ivg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Tuesday, July 21, 2020 16:43
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/powerplay: correct smu message for vf mode

From: Likun Gao <Likun.Gao@amd.com>

Set valid_in_vf to false for the message not support in vf mode on sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ib07fe7522eea39a14131945bb76be0b0935598ae
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 70 +++++++++----------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index bf3d6bbba930..d4156804bf41 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -71,10 +71,10 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
 	MSG_MAP(GetDriverIfVersion,		PPSMC_MSG_GetDriverIfVersion,          1),
-	MSG_MAP(SetAllowedFeaturesMaskLow,	PPSMC_MSG_SetAllowedFeaturesMaskLow,   1),
-	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh,  1),
-	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures,        1),
-	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures,       1),
+	MSG_MAP(SetAllowedFeaturesMaskLow,	PPSMC_MSG_SetAllowedFeaturesMaskLow,   0),
+	MSG_MAP(SetAllowedFeaturesMaskHigh,	PPSMC_MSG_SetAllowedFeaturesMaskHigh,  0),
+	MSG_MAP(EnableAllSmuFeatures,		PPSMC_MSG_EnableAllSmuFeatures,        0),
+	MSG_MAP(DisableAllSmuFeatures,		PPSMC_MSG_DisableAllSmuFeatures,       0),
 	MSG_MAP(EnableSmuFeaturesLow,		PPSMC_MSG_EnableSmuFeaturesLow,        1),
 	MSG_MAP(EnableSmuFeaturesHigh,		PPSMC_MSG_EnableSmuFeaturesHigh,       1),
 	MSG_MAP(DisableSmuFeaturesLow,		PPSMC_MSG_DisableSmuFeaturesLow,       1),
@@ -82,43 +82,43 @@ static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(GetEnabledSmuFeaturesLow,       PPSMC_MSG_GetRunningSmuFeaturesLow,    1),
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
 	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,             1),
-	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,                 1),
-	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       1),
-	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        1),
-	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh,        1),
-	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow,         1),
-	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       1),
-	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,       1),
-	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           1),
-	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   1),
-	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
-	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
+	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,                 0),
+	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       0),
+	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        0),
+	MSG_MAP(SetToolsDramAddrHigh,		PPSMC_MSG_SetToolsDramAddrHigh,        0),
+	MSG_MAP(SetToolsDramAddrLow,		PPSMC_MSG_SetToolsDramAddrLow,         0),
+	MSG_MAP(TransferTableSmu2Dram,		PPSMC_MSG_TransferTableSmu2Dram,       0),
+	MSG_MAP(TransferTableDram2Smu,		PPSMC_MSG_TransferTableDram2Smu,       0),
+	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           0),
+	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   0),
+	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            0),
+	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            0),
 	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
-	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,            1),
+	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,            0),
 	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,               1),
 	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq,               1),
 	MSG_MAP(GetDpmFreqByIndex,		PPSMC_MSG_GetDpmFreqByIndex,           1),
-	MSG_MAP(SetGeminiMode,			PPSMC_MSG_SetGeminiMode,               1),
-	MSG_MAP(SetGeminiApertureHigh,		PPSMC_MSG_SetGeminiApertureHigh,       1),
-	MSG_MAP(SetGeminiApertureLow,		PPSMC_MSG_SetGeminiApertureLow,        1),
-	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,      1),
-	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       1),
-	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           1),
-	MSG_MAP(SetUclkFastSwitch,		PPSMC_MSG_SetUclkFastSwitch,           1),
-	MSG_MAP(SetVideoFps,			PPSMC_MSG_SetVideoFps,                 1),
+	MSG_MAP(SetGeminiMode,			PPSMC_MSG_SetGeminiMode,               0),
+	MSG_MAP(SetGeminiApertureHigh,		PPSMC_MSG_SetGeminiApertureHigh,       0),
+	MSG_MAP(SetGeminiApertureLow,		PPSMC_MSG_SetGeminiApertureLow,        0),
+	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,      0),
+	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
+	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
+	MSG_MAP(SetUclkFastSwitch,		PPSMC_MSG_SetUclkFastSwitch,           0),
+	MSG_MAP(SetVideoFps,			PPSMC_MSG_SetVideoFps,                 0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         1),
-	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 1),
-	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              1),
-	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 1),
+	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
+	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
+	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
 	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
-	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    1),
-	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,                  1),
-	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,                1),
-	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,                 1),
-	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               1),
-	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,              1),
-	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       1),
-	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       1),
+	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    0),
+	MSG_MAP(PowerUpVcn,			PPSMC_MSG_PowerUpVcn,                  0),
+	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,                0),
+	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,                 0),
+	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               0),
+	MSG_MAP(BacoAudioD3PME,			PPSMC_MSG_BacoAudioD3PME,              0),
+	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
+	MSG_MAP(Mode1Reset,                     PPSMC_MSG_Mode1Reset,		       0),
 };
 
 static struct cmn2asic_mapping sienna_cichlid_clk_map[SMU_CLK_COUNT] = {
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
