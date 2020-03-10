Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C481C10F25
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 03:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F00624655
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 03:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P/ep5kOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F00624655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03706E119;
	Tue, 10 Mar 2020 03:15:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EE46E119
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 03:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXNNolqfYzflF7A5gyjzUeZsxJIFub62VN38xkNv+TcI+rP9453pBmRW4QMB/xkmewowHRTPTcxzcnrJc8MyYFSCQe06EenHhhD5CJnCka5zI7CS6GB11VzlStQwbSa92lwifkjAFR4q+7cNFdXI23l77y+W0Kw/zfKTDDTcYvPfCGtpQP7CJxEF5iDAs1TJ02PvREWWjvTFd4ELCNMXC5Exl+B+KZ795TAqdUjx2h4m76hYaAnUCMWsKocAib5hTAqIeD5uT5J+Vd8PQOS01AetmGDpLf+ytoFOAinpgpUe7JkWWrr9lgmbfkOyk29oqEkqu1zh/CgbgYEhM0naNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOsptbquSkxRSI8c88jasB++ncPqSZYVwy5E2eZ/c/Y=;
 b=dJlyyhByC671dp73Sfe8xrGrEv2bazE3gad8/hv2qIKSYU0TvaLPXNccD15yuxCZuc5Zaw4YNXCBVCtGLMxCLzFANOboOzK+0SIqQhAbs7esaRtaFLsFWSfGv+BUkTn5JpOtL+atvVUUH133mOEKrsjeI4uoWJgCHUXwzzwYfgWUGGtL2xytFdqoZHQKSbIAl/X94kXfTH3P8qlSfmq8sgYeT58dpzqeFR9cet+VTL50/0FF5yAFQ8krrWd1njeEUTW/X0SqPreA9x5uPJfSls5UTCx9YTsNAHj1uWw9BqcQ3fRaMromxyDI1UvOgou9qfBD+hyHDRx3+/AVR7S+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOsptbquSkxRSI8c88jasB++ncPqSZYVwy5E2eZ/c/Y=;
 b=P/ep5kOT5uUBMIfdCPxLaQPFgHH0nwizD8ZoshJ3NkYN6vuAowTZCY9/Xe41N8bjoKGb3EHs9sTeeOH2x1U4cgt0Jul31vqWfRwJ08oUQFWEPNZ02rYo+5RNGlfsGhHtp+umUrX8EjI/WurxPSOIs9Z8nXx/y4s91EOp7WxOTkM=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 03:15:49 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 03:15:49 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: fix the coverity warning about
 negative check for an unsigned value
Thread-Topic: [PATCH] drm/amd/powerplay: fix the coverity warning about
 negative check for an unsigned value
Thread-Index: AQHV9nPx2yNk53hL7ECC4Grwj4M+M6hBJw/g
Date: Tue, 10 Mar 2020 03:15:49 +0000
Message-ID: <MN2PR12MB3344123754EA8640763B188AE4FF0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1583800575-28755-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1583800575-28755-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bba7ac68-741d-408e-924f-00000bcdb2b1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-10T03:14:18Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f247c79-5af1-4214-68e6-08d7c4a15543
x-ms-traffictypediagnostic: MN2PR12MB4190:|MN2PR12MB4190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4190392095712B1766DCB9BEE4FF0@MN2PR12MB4190.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(189003)(199004)(2906002)(186003)(26005)(9686003)(110136005)(64756008)(66476007)(66556008)(66446008)(316002)(53546011)(6506007)(4744005)(33656002)(7696005)(52536014)(5660300002)(478600001)(81156014)(66946007)(81166006)(71200400001)(8936002)(55016002)(76116006)(6636002)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4190;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /KB3LDXfy9CqxDOUf+RCNyK2xQcY5NvMu1Wn6liaDYHaLAUpPBniuEgO3NiwdjAe1buF+BQSaOdGLkPS//ec3lTEH2n27/3xLvw28WRa118JhJoxAD9DzQFlAUrrTSIniQaYG513ZSwmh13h9QKwUgZboOj0Z4Xz2IJwEFc01Vrx7ic3uoiP/2eOSxzUUbY+QMntPeha5mnEnsB5obhHC/8os31cLctE3kI7iqsk2b3RFt/Ej/zu+GQ26JcK1JfUKYJL678JZcWcHOCZFmRKCHkiPiFiDPVJJBCNkdekITrx/VhG916xuyxLi6wNY8PUnzlcXL6ylqMyWWZyO3YVP0zgYJQ8epv2jBK5Br+6afCXSFe2QuJP5ZY0VBpd3BV6mJ3PXPZJnG9JZ6KY1Uzp4GwSoVyLCBIe7Um83eksQ3au2nXWgHpvb77OoiAhqy9u
x-ms-exchange-antispam-messagedata: reYt/iFgEFBV4AmjeXCL/tPglTa3QdUNPoU/7ndqSyo8gg4hUqEuOnzoS98F267UBrPEYWHc8X7GuL/PIFi0TFVF/a3zL7chvSeHnL2MFdBNYh4hpc1NrlTgAISHdnIULero4BiFFbdlp/GmSYOCmw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f247c79-5af1-4214-68e6-08d7c4a15543
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 03:15:49.3555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3g/5M8eSWnJiU8NjR9Pb2Ei3yp3ZsN9pLwzKDrWcTgtEAC8b/ipHmVdQ8X7SacDf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com> 
Sent: Tuesday, March 10, 2020 8:36 AM
To: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amd/powerplay: fix the coverity warning about negative check for an unsigned value

There will be a coverity warning because min and max are both unsigned.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index d454493..f18e3fa 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -214,9 +214,6 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,  {
 	int ret = 0;
 
-	if (min < 0 && max < 0)
-		return -EINVAL;
-
 	if (!smu_clk_dpm_is_enabled(smu, clk_type))
 		return 0;
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
