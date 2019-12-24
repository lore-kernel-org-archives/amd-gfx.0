Return-Path: <SRS0=l0jK=2O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB71C2D0CF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 07:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAF2206CB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Dec 2019 07:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PE06SfBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAF2206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9646E0A8;
	Tue, 24 Dec 2019 07:21:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCC96E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Dec 2019 07:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjeRgGFb6SVVRdmCyzkXtJ+dptCa6jUOTa9+3KhglXEoPa4b4bsgH2fKvgkeBSaJZL06YhXkLmBKqzv+NtdOBawtFjA0ekv/grOYTYfx9U4hJ1pO92ivILW2K9D07ZSXCZd/fuzMVqaNz0iZdr8RYOtRu8ilNlrS9Vxp/hA4twOq69SCO7qecDRjh3nReGVNpgo3pronqYgnXzkjc45XtM3rpnKRUWw4zyYZvZueZR5olcdwPY44B73h0bewgKGx9VMQilGd4/nGdUguHRt9fw37v7/9ga7FnaXYpUmfnWRPHFLSkD3AzpBCvyIhdTlJUR8k8kd/5x0hmfGqurFqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNnfEaWiJhEUCpt8z0VSTT5kkBgPq6WtHNxSBlQF9oA=;
 b=MMYwzCzZbO/gxCdoCToL52Q+3eYhynGG6hpQFgcly5ZASZWd0/QDioAptLr8EqN4IYSwby/p7Dmhzt3jtl+/v4mFotMg09KQFeTB9/7lFoTofcfuJ5rPXZ74Zkl5F381e4Z6RYrfMuysb2Px6znVmK/vIk/0DIVJ4Eb73YFP7Tke7g134mokUMY1Wxc2qSogvVCq9WqylW0cunl7bZ36rEcZVBIXZGc8SPj4oyZCZG319NMhAdDV7dWvIbqSNivd/05+LbNuT0AAW0H/g05oNxaDbPbSHwxHOO9Nx8Krhug+iHyVkooKIoRz/7cK/6AI1wzDkLZURMZa1sD/A3t8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNnfEaWiJhEUCpt8z0VSTT5kkBgPq6WtHNxSBlQF9oA=;
 b=PE06SfBK62f/d9CrzBuFYofGKv2p60dYtbogXncbLEXSRsTG/L/FAezdTE/iTz3kczkQcNBl8xKO1VdCNyPCA/HmH6trNDA94WBa8evManSC/zbf0aI6I+qczwBCpC8HD/ZBSXYXGG6PQT8br5nNuys8AwK9NGZ7HiUWTNCCSj4=
Received: from MN2PR12MB4285.namprd12.prod.outlook.com (52.135.49.140) by
 MN2PR12MB3374.namprd12.prod.outlook.com (20.178.242.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Tue, 24 Dec 2019 07:21:03 +0000
Received: from MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::dc02:3d41:a510:98f6]) by MN2PR12MB4285.namprd12.prod.outlook.com
 ([fe80::dc02:3d41:a510:98f6%6]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 07:21:03 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify function return logic
Thread-Topic: [PATCH] drm/amdgpu: simplify function return logic
Thread-Index: AQHVuiQV0br4uYFEREKv9LP51ec7x6fI4N5Q
Date: Tue, 24 Dec 2019 07:21:03 +0000
Message-ID: <MN2PR12MB428598B16455F2BD79B8BCE4F6290@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <20191224063321.4359-1-guchun.chen@amd.com>
In-Reply-To: <20191224063321.4359-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-24T07:20:59Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b56c3658-7503-413e-9618-0000386a864e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-24T07:20:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6bc7581d-aff0-4784-875a-0000a59dbafc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=Le.Ma@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54dd0e0a-443b-455e-3f51-08d78841d5ce
x-ms-traffictypediagnostic: MN2PR12MB3374:|MN2PR12MB3374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB337411A016C552924F99A8A9F6290@MN2PR12MB3374.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(13464003)(199004)(189003)(5660300002)(86362001)(66946007)(76116006)(66446008)(110136005)(66556008)(64756008)(66476007)(9686003)(55016002)(33656002)(52536014)(8936002)(8676002)(81166006)(81156014)(7696005)(53546011)(71200400001)(316002)(2906002)(478600001)(186003)(26005)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3374;
 H:MN2PR12MB4285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z5b75vnWeCV97WtsoUZdytShNAqNDiKAqjUH69Rm1cSXkSfdRRQbsgJTNaWKAtFODGSEzr4RWje/1APumgjdsNWmVpwx921Erhb1wOghLv0K9jctL2LT2HcsqO6aELiScAuMycuaLXNee1HbPjUsJAE8+bXVMV0Q0gl8+9WUCmPiegNUP0/qBVpwMgHs+Dqe3QHRHlyh2MlU//TtpT8pXiSVpKEjnF9SiaiHqaXcotWW8yFbXMHwAzq1lPoGbah83jkDUFdUHYgTcDw60D78TRMhlpL/pxbjejGfHLk2+ErkrZfpabWxA7nmK0wJyQShNZ1N+euOf0JiDi1GV1q71C578QA/QYi/5+j61sq/yqICa60edm1vZYwGTQ3mBjSH/CmXD4BqHuJMRpy42tRRPLyfU74CILSIXABZoKkqfYhQHM4GelSD3+Q1vQJID+CeNsm2QxkTMeAVYxO21t4RKcWmaxNi6qmMropmain0l0JdRqEtrs88ynaCyDdqTQjg
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dd0e0a-443b-455e-3f51-08d78841d5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 07:21:03.5110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OphNsvMmXDtz7GxuD/vhHdnFRQf5/8A3lolLtlRgVz++2regccnHzgu+eIY1hJX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3374
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

Reviewed-by: Le Ma <Le.Ma@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, December 24, 2019 2:33 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: simplify function return logic

Former return logic is redundant.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index bb701dbfd472..41af6d0801d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -456,10 +456,8 @@ static int nbio_v7_4_init_ras_controller_interrupt (struct amdgpu_device *adev)
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
 			      NBIF_7_4__SRCID__RAS_CONTROLLER_INTERRUPT,
 			      &adev->nbio.ras_controller_irq);
-	if (r)
-		return r;
 
-	return 0;
+	return r;
 }
 
 static int nbio_v7_4_init_ras_err_event_athub_interrupt (struct amdgpu_device *adev) @@ -476,10 +474,8 @@ static int nbio_v7_4_init_ras_err_event_athub_interrupt (struct amdgpu_device *a
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
 			      NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
 			      &adev->nbio.ras_err_event_athub_irq);
-	if (r)
-		return r;
 
-	return 0;
+	return r;
 }
 
 #define smnPARITY_ERROR_STATUS_UNCORR_GRP2	0x13a20030
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
