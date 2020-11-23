Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325E5C2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0062204EC
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Suf4RByw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0062204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1758B8976D;
	Mon, 23 Nov 2020 13:37:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1178976D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 13:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Runc+79psQLhCAkViCKPsvbbdraYICNAzMr8PcGusfXIfZPCoWk1Gk2oiMneDoU5eezdZ9yXc4s1PlZurYDnqMYz+FPvFtrv8MZ3eXMdKpyxrdu6QKfomaJFgY0zC+TAS3xP8xm/xOWWQxkMSpD7OR6MeIesisoCCUC5g9JMB1BmU5xk84urD2Dgp06bzpZ30boCCrN8X6iBGcPjCkm1XoOqngiboWyK4WOcHRy0fvEs4mps5pUqmLwP1a0o/ORpPpURd8XXoTSO81nthIwEt8okO9XlEfQeQWStL5/t/2dY1Lsi1DaXHUUua5rstcPLkwVm5+wU8RtrzT+jzreFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez/mKQQy3XJM9JfREHzcM4ToVw5BQpcK1fFdQrFrKWQ=;
 b=S+bPqIdfcFKPoKkSZJxHytnm4B9enbKD2JEIgllYHQywba3NfJ/ECZRY3XMqeAqxdC6mVvmQ5VG/Z0ifQl1sHk45JiP9mFBpMNbqa2igZ9d8fDfJAcHUdaGHk2sQx7o4kOBgi1bjiLMc9h7hsEu/TZPBVA+7pRE9RlpNUW2/KDFG83vGzmixafjwrdV8LMcIKnzJ1j+Veb5Idec0jvtabPB5wiBgiRq+zcdtIwp1/ZdanlMpWo/I4y0LshjjahsU26hUTI11PCVQNpHcUykWCLpMoWIlEPzjZncY8B9wOG+8kCagQlx9M4hI2duIURBFA0ZwrGorpBOQ59CevsId3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez/mKQQy3XJM9JfREHzcM4ToVw5BQpcK1fFdQrFrKWQ=;
 b=Suf4RByw9qZTnSAFXr4+5IECFrMr7KiOkeUW8RNQZvEwmrtpiaVhqu6gZ3BfRYoc243gIfuz9Iaa7zVjfGY764eCA4KdulKub23h4XravIxeUi5CcWiRiWWj9K6bATcSipcQ7O4BbHbAO+c0/F00Ugob4D9vXHkLboQsGT7QTJo=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.29; Mon, 23 Nov 2020 13:37:47 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 13:37:47 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: set default value of noretry to 1 for
 specified asic
Thread-Topic: [PATCH 1/1] drm/amdgpu: set default value of noretry to 1 for
 specified asic
Thread-Index: AQHWwZp6cxZK/JicwEGDKDI1mXgZVqnVuEzQ
Date: Mon, 23 Nov 2020 13:37:47 +0000
Message-ID: <DM6PR12MB40755717B1D1B0097875C050FCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201123131334.21704-1-Stanley.Yang@amd.com>
In-Reply-To: <20201123131334.21704-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-23T13:37:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=736feeaa-6fec-47a7-b3c9-0000f2ecd49d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-23T13:37:39Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3973721a-0199-40ab-a060-000046854bf7
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-23T13:37:44Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e3d59053-e72e-4930-86f5-0000495897ff
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88162953-1952-4a28-9cb2-08d88fb4f720
x-ms-traffictypediagnostic: DM5PR1201MB0025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0025250D7C84B19909551FE9FCFC0@DM5PR1201MB0025.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUePuwid7HVHyX3L56+/yuVWeEmpaVfZnOE/b4cO/x91dhHDZtXR/xL2fVlD/b7s0h/CdkOpq6bMlO7ptkY/gTeTR3nME5hq8NTpe+VviGhZe8P6xYvg+VhEyiMFrRI/85xK23efaKt1pSyNhhhcmk+V5PEy9D/jp4DEU2sbrKdr35YIdN1NIbsgmWdQEN1opf4R+m1fEVbqkXnW6oxDdnVkwF9f7ctHPDMRAfI/0PLkF1IXI1bHxmdH2z9TcU1S9Ub4DBCT6ogTRbLivtqJHNVjP99jsnx8W9TvBWwe5hmGSr1TAlY7ULkdEsVLlM4KHJfYz3VoKo/+nOWs7ZVsVMkxCmbIghMo4H4SZ/ittBE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(5660300002)(76116006)(66556008)(66476007)(64756008)(9686003)(66946007)(66446008)(52536014)(55016002)(71200400001)(45080400002)(478600001)(8676002)(8936002)(966005)(4326008)(33656002)(2906002)(6506007)(53546011)(110136005)(7696005)(186003)(26005)(316002)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: j4+MDfFUH7/78EL/tzPFSfXX5SWZX+3i9TZi5+fFWqnuRVTkhC4wQ+Xgxa7zCdVcFGDxQIJSryNQPzonXohKD/OOHn6cr38FOMidt+/ffveRvG42dpqNszC/qRqLApIHNDYZ1wPZijonthhPSveChnpqmt4m/Z/aCphXITipPDkYlR3hnYvGQXQuqsDUBvIwkYqh++r4b9DnTrDqX4kB5lgvpcMtB/cbqKIFh+hSpq29iVpGpBCow8gRrzovhTIzlcFb6xJnVbLx4eoGEh7uOXMntCYYBdKfPZ8ShxBrVmVAaUjWEjS/H1ge3H/XSKd8YLh658eUWpYkJh8IRkbbTcVVq3D7gXmixdqd76/anS3cAEnsf6fFX3odYN+Hp/5GtCAanvjrgwrzS2q01cJA9d1aS3rDwpCMhqxeBhh3Tq8dvIF4WUvoI51oMmR8z+Q1GEl1pIj5oJrs0DIByceJqOhIiBjfJYIUnWYlsDu9pgo+zbdrOR8KK6D4jIcs0gRd7YXBxT79Ckbhm7jzzuWvhLpwjECpfTIUW8uOG9vG0P2vZrYo/Km9o84X5nvEPUeFzrtp6gZnSVrWjG4sJKw3L+FVUTIxVx9UWb+ipMDFmQqs5j2beBhHVYefhAou7FSkpgsW19RhPM46zr5Z9mzjBQkXgnEJOrrb/YfovdvB6nPUd/CB0CxlWdTo/DDXS+sBTJ17vStn26AhMg1I6/8j/J7wOdT89Sf/d78+ysosgUP0St2/8LzOk5IhIPLSoFTZp3DmFZgxYVHksWO55LgLvw9E0TIKUJip3ZheA/s2BJLClfMN3iwo1jgZ7kyIq033JexcGfKsjwE+30sIujjE+CjJKwVIzJzh1RZOe9Y+7Ri/D3v9y/aJmeENl5sRHUQqp3E7VlGy0h3u+39cBetqOQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88162953-1952-4a28-9cb2-08d88fb4f720
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 13:37:47.4755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUo4Pfso/bJyxuWl2uL8xvoI+walrMfJOinU0PN0lG11w5JD1DwHntYEKl6aHPq/gwt0HivfCiV4LDXaKZ0O/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.Yang
Sent: Monday, November 23, 2020 21:14
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: set default value of noretry to 1 for specified asic

noretry = 0 casue KFDGraphicsInterop test failed on SRIOV platform for vega10, so set noretry to 1 for vega10.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: I241da5c20970ea889909997ff044d6e61642da81
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index a3d4325718d8..7bb544224540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -425,6 +425,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	struct amdgpu_gmc *gmc = &adev->gmc;
 
 	switch (adev->asic_type) {
+	case CHIP_VEGA10:
 	case CHIP_VEGA20:
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C6c424996a1ec4400854a08d88fb19a4b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417340270280004%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZLKDjTTy2LGV936z6vnq93hv0GJ2EgsG1kDF70InMrM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
