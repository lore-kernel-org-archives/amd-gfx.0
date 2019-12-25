Return-Path: <SRS0=dgkk=2P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDED0C2D0DA
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Dec 2019 06:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5D92071E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Dec 2019 06:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X45vUdWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5D92071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2441589D8A;
	Wed, 25 Dec 2019 06:53:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC2489D8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Dec 2019 06:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzI88PbT3CsEmyGHeotjyFsg37bvXL1pm1iUxwpaBr61EciqSNzM8kNM79iP7/svewegEFEFiuLQJr0lBXF315XxR6Neg93xi2Vy3eZS+Xc5VRiCp6qrrg5xvOsK/0hKX6IRS1WYk+KxDcxlMk/8XZlm1udmCGBKP51jCp2Z8XWYOnkesXYWjHNDdqFBQ1cgumSpus44wGxlUqwsO6FAJUK/iXICvDzv/rKVjuNS+r6OaxNFBSnqnv7QX0OxkKgrk8m6IZfX3zOdbeAv+zRWejk060OxVNvYdgvafM8V6uNLOF1ud8mqKcIXvBx8fUBNT3j8hshQcZwJlwxNXAdduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud21XlslRiSf9mNN5fTAhzblZsxxCEVy9P9z07+Cm0c=;
 b=XVKc7GFfmzPGjkibTsPf8AqusXwUaGkdu+wX43h/L13hZK+o9T9aV+1uTQ8GDqWiysoqxpQ9mRYWXmTUT176do+iU6WZhL0oPVViEogz8vAzOYA8haTttLmR4NbXlajI9eFgBfWrQGMQzeSeWYc0wFp7kiUeWcgQRJLDUZuV0Ml5vUr9V9qaNbdJpq1SaFdFRjxOnV1BqPYRVFG5nrhrfmfWwYpko7vae7zHBexlGO7wa8WVxkhwH9bqSlmn0+gK8Hr/59uOeE1xdztoYVCN1Z/xZL5rk9k9YR1EezFdYeyC5OvV5UEc8T4gB3E4FqaXMTE+VG3Eoz0KFZqUJUOxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud21XlslRiSf9mNN5fTAhzblZsxxCEVy9P9z07+Cm0c=;
 b=X45vUdWIcACqfObHqdRr+R/Lj5fTKACfjwurjwPrn4JgBIJ2WisqcGAZc5jyFsBRMW2e0h8Fu69nYTTLsNRASNeu8M05zhlV2iCcdIUghxvswNTQxCKrcS4Eyp5cJVFrK2VciYX2afaxAkV10m6B/Po0+maVqHlTBaEBvkHDlyQ=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 25 Dec 2019 06:53:28 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::e944:3f8b:ca64:ad1b]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::e944:3f8b:ca64:ad1b%5]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 06:53:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct RLC firmwares loading sequence
Thread-Topic: [PATCH] drm/amdgpu: correct RLC firmwares loading sequence
Thread-Index: AQHVuuvQdpToFweWy0uNpJ5Y0GdkZafKahmQ
Date: Wed, 25 Dec 2019 06:53:28 +0000
Message-ID: <DM5PR12MB1418E80E85BA3A7841305C15FC280@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191225062247.4115-1-evan.quan@amd.com>
In-Reply-To: <20191225062247.4115-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-25T06:53:27Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1a87f7b5-3a70-4b3e-b91e-0000cf5956a0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-25T06:53:27Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c0a77e56-26c7-48f6-845d-0000c79f4d33
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8c900b8-0eae-427d-6ef3-08d7890725dc
x-ms-traffictypediagnostic: DM5PR12MB1163:|DM5PR12MB1163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB116376C15CB3CF134EFB8017FC280@DM5PR12MB1163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(189003)(13464003)(199004)(33656002)(8676002)(26005)(71200400001)(7696005)(53546011)(6506007)(5660300002)(76116006)(66556008)(66476007)(86362001)(66446008)(64756008)(66946007)(81166006)(478600001)(52536014)(316002)(55016002)(9686003)(81156014)(110136005)(2906002)(8936002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1163;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aXv/u/NHocEQySFzVAg2xCjTewp3bIiRMJmhVVv8BsQwlgElPQjW8YGbb3a4rKhLSnjye0Hil/gKEzMYvD1AMcLjgXhZSachP+j+xmHzPCg152d6Hvv90meeW+zlNLQOcUO0Pv9HnyRw1yHdnqU4pQCOlpS51SMOYn4K/y9OlykNeUJVX6bjg5fSzLG/YQfLCUDWfIYLWe/ate5janY2m8ct/tY2yHktpcK2WXxn3VtpTefPyReVgFImAoC+Sru8AwRMAxC/tkPLDK/lIVvjdJgMlQGqX2SeL0B4XlHbNiCQvoJX2uXrRE6o1Xi4REnjYa/bMYh+W88I1IcCUHBMs0fvQ9jYw38j1hHd67On9KFFJfY4PKZpfISxGk1quLPqQAblyrpdQMifJO9+O+bhSdryDa1PxCLeTwFrzUJHVat73GZUdBoAp5hvayyCCEQQE0z7omhTqWjIPsAxPqNV2GLvhYIsRDGWuDtW4HfpZ6CPkd9W6HvdM/hMcHZU22qJ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c900b8-0eae-427d-6ef3-08d7890725dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 06:53:28.8754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7YlPN4I1kDzscY5XfJoHCApDcshceBPR3kt6KeNLL09Wwe26RZhvi2VAFvx5m4Xv9rDkQL8OMQhcC1sj304/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Wednesday, December 25, 2019 14:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: correct RLC firmwares loading sequence

Per confirmation with RLC firmware team, the RLC should be unhalted after all RLC related firmwares uploaded.
However, in fact the RLC is unhalted immediately after RLCG firmware uploaded. And that may causes unexpected PSP hang on loading the succeeding RLC save restore list related firmwares.
So, we correct the firmware loading sequence to load RLC save restore list related firmwares before RLCG ucode. That will help to get around this issue.

Change-Id: I4f5cad5e6bb2e5fd632957163516d9be9498234b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1b89bc3e2e8f..56540885f5c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1466,7 +1466,7 @@ static int psp_np_fw_load(struct psp_context *psp)
 
 		/* Start rlc autoload after psp recieved all the gfx firmware */
 		if (psp->autoload_supported && ucode->ucode_id == (amdgpu_sriov_vf(adev) ?
-		    AMDGPU_UCODE_ID_CP_MEC2 : AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM)) {
+		    AMDGPU_UCODE_ID_CP_MEC2 : AMDGPU_UCODE_ID_RLC_G)) {
 			ret = psp_rlc_autoload(psp);
 			if (ret) {
 				DRM_ERROR("Failed to start rlc autoload\n"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index eaf2d5b9c92f..b0e656409c03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -300,10 +300,10 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_CP_MEC2_JT,
 	AMDGPU_UCODE_ID_CP_MES,
 	AMDGPU_UCODE_ID_CP_MES_DATA,
-	AMDGPU_UCODE_ID_RLC_G,
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL,
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM,
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM,
+	AMDGPU_UCODE_ID_RLC_G,
 	AMDGPU_UCODE_ID_STORAGE,
 	AMDGPU_UCODE_ID_SMC,
 	AMDGPU_UCODE_ID_UVD,
--
2.24.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
