Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA05C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 04:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C936E2074B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 04:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n/RFX8Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C936E2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB3A6E892;
	Thu, 11 Jun 2020 04:40:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE9F6E892
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 04:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sfgw89gW4kYguxx3/kUDehzBfxzhFvsXNuUTOB7nLUn+pMZLY23kNczB6E4DPMw6x0jimkozPhsarQf9eR1pFJlRjP1DhyxSEPFBpyWlg4uSAlqCmjW8ds02VnXFYAIaLqJOyq3qZuo4mreIyxAztG/mbZJp9luaUCJ736r756o9xrr8Zswx9xKldn+IDz507QVbObItQkvdnOPjfoR1XLlED6rkv6JFWIyo14CLUKjHtmcctGi4qq4149NvTbnxJlumCgGRfrMmwQWrTaDPv1nKNsdV3jN1+8uuapPw9CQVMIheUOlK82a+F3lokH92f1bnJICA+qPdIfLwBE4/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NomKAQNYmRVzA7+eAG4h6TRbpIzwAMUJ7gr4WyaD9aQ=;
 b=AidWGyxKRsicbUPivY+E/lrDfiY5KW/RwPghuwvOjSZ9zqrrZ9CavRG5FyfiLVFzF7CYEWMw8xpDgPPfuuNxSYm7PzFQiJb2l7DFfzcOLazGohVDqslgivU75EARQYjUngzY+rlw4DCoJJHGAhxPU5N44TvguR3YQ92+zD8Unc7u9dCHNAv6FAEpsdagFaUFi6PyoLWxRrrMWuMOd1IS6Im7+fnCTcQLmnCAlc56rDG2Pc9F3r8sRFM922dYnHl3n/k5Z3NRojkOstS7Sz/gkJ5+vKZpY2IL6T8VJlcZxB2zrg8SswJe3W3XVvc0JLD8CKmehmR8Hd57lM7ma5zPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NomKAQNYmRVzA7+eAG4h6TRbpIzwAMUJ7gr4WyaD9aQ=;
 b=n/RFX8Ax72Wxw/9D550c8QRyC+v5GKZ6nkXcXS52Vzdgw8ebM5wq4qQ4yQ8DcqaHjIT3/FGjkB3BXDCwdga9fYBLpkVpATIfYD4vSXt6K3CepysZNUzPPgXUHtQQ7vp7fhCiy/x1YylaAmgjixpPlhS8Zk7F/0o3ku0rqIh7duA=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYAPR12MB3080.namprd12.prod.outlook.com (2603:10b6:a03:de::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 04:40:33 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 04:40:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Index: AQHWONrFdJbxYOT38kqsyVb5lmfU6qjS4pSg
Date: Thu, 11 Jun 2020 04:40:33 +0000
Message-ID: <BYAPR12MB26155E9965EE58002E79CD68E4800@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <1591101603-21219-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1591101603-21219-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ac3efb29-8085-4519-a401-0000846dc4d1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-11T04:38:26Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 556a2880-98f5-42a3-56d8-08d80dc1940b
x-ms-traffictypediagnostic: BYAPR12MB3080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3080F038721B9FDFCF56231FE4800@BYAPR12MB3080.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AX7WfEsft7yNN4EWnQWPjcG1BawMX8W0YQSJqOfRyHnUojH0vNLJjXHjQ//INBnEGPWB6SEzGXvuBNxe8K3Up0avfOk3fH1oxUBTN3KmgGA+c+TUMKhxA87tsWuhp3dKrLX/+8pXrRIgCvj0lB7/9bewRNysBjMjVvfFu4d4K8+hTefyx3WW/neLb8uz1agtf/umxHxygGWQFOTwg0LzCujhMgXYZqbgzKZGxpDVXqLMZRUp0h5grHeTemtHk2Cv6g33pTXIB2GlE0junWd/USYEbwHwQYrGqDq9WGeQeijEUI17DcWdAfTukgmAHDIdHYZV4Vr4K+k0WKDuygglDN3PEy9c2wJ44qwbK1c3MqU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(76116006)(7696005)(66446008)(186003)(5660300002)(86362001)(478600001)(966005)(8676002)(83380400001)(4326008)(52536014)(71200400001)(33656002)(6506007)(66946007)(53546011)(316002)(66556008)(110136005)(9686003)(55016002)(26005)(2906002)(45080400002)(64756008)(66476007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: AvKeho0RPL9I8QKSNYbv72/gR7+Ew1JNgHSJ4rbiLvO6lo8aBJ5k9OYa5G6bjyOZOqsn2U+eAR+Soy1iV9K3z6OLA6LDmSsq2mV3kwAqljqXcAE2vFwPfy8pbrlimQ3bcMkVOYv4lF+nlamRUhMGZtTEf8Pj8WMiULs3f+qSHjwS6sUEztfObjpET0lJUE8huwaq3nIO4j1o07YFzJp0HGWXHEoqRTsIkL5nCXYBrEMmGo0Jo6mNa06KJXkxMRn4DUJcFuER0LCcumKrW9MIlj5aMcMcDcYvDWnEEXdgVv/BomNxNKd+M+PCuF+ec02kBulq43cUpOy0zrJBM+Zbycrkhes0Ziyv++dVgYXLM2p1oPvwVXEyQ8MSiBb/z5t/Fc3xfqftVRHWfZenhPyaQelQRgRZH5j26JOk7sU6sPJXEm9UbMC+i92Bw4aDct5cFCmONSSKi56TVgI0MY5dMS4eOZBbAmlvfN6xFvth8KuKcz+hdaemWgtCHZUObAwv
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556a2880-98f5-42a3-56d8-08d80dc1940b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 04:40:33.5687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHToDKEH5FbNwqp91Vg73SwmgOZv1BHgvBopnaC9VXc87rzESJQ6ThdvroW8JuhQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3080
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Can this be moved to smu_early_init()? Or just do not adding the SMU ip for multiple vf sriov?

Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily Deng
Sent: Tuesday, June 2, 2020 8:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 5294aa7..8ed6c90 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1311,8 +1311,10 @@ static int smu_hw_init(void *handle)
 struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 struct smu_context *smu = &adev->smu;

-if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
+smu->pm_enabled = false;
 return 0;
+}

 ret = smu_start_smc_engine(smu);
 if (ret) {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C1f8e52701d674ecc4ebf08d806f1e44d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637266983322685089&amp;sdata=RZ1PZlfRuO5b2jjHVwFcPqCDOZOZ2zRMgxZfjbAeYN0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
