Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EB8C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 08:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A762164E86
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 08:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A762164E86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C2889D57;
	Mon, 15 Mar 2021 08:11:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA96D89D57
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 08:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUkZ72tPg/t9cEf+gd/7f+fYQx52n3Ey7OmTaZBtLFxBdXkBJz4KqRbvlLMJwxwbxLZLkCyzxtPJidfuAMMAiMmhWIa6miV2s7IFxOM8bjZQECulKenEZjZx7ZIeb6KdbvDHrdHjPHB5dVXLlT5UazgBOpQl3hzGbDL+kuH+mSNXdYdC8vW0dvhmFIDH5IMfITUGVrMwL4Sk62by3efiLOhImUDlu1LG+3VlMgnhGFjxKrfDDhPU5fGzAlRnABv/0cXXeFkzqQvtgNRHhERwaaRiAoPOjq2ae/KOn7hEydaxuF6/uvgXPjRLNLca5a8wiVSrUIkWyuddEwnG0Q8/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu+Xlp570dhG9yzk7mwPmzLstIjfM6Sabt+DvLDubEs=;
 b=jKptAING/7hxy+k6sxoAGoD4DMQJrdDmhscdq2Ssf39sZHiiH2hW/z7B2UezHmVWf2/XGwiuqzwnDBUElTy7UKJc2PfOJZYHFGpKTVzJr6sM9D3w1qnUc/OvimblLQ8jfMGOTntvdjvJMko2/8apJStzavPdXudOhpbkK6wGOaevzYulrAqGLpwVy+o5/ccxsiWF3wgbHSBoCSf4mTos0P3Ndb0TDAHFjhfMTole2aymvf6HdhdlbuEvB+ejKGxw58qmXRt4BGkiBfu16lF2ApzqUmrFjVhCLdVr5x7Q7d1+a4m3qSA5sKt2m/6ORjTPW1aJOWVsC3llDq9ZOysQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu+Xlp570dhG9yzk7mwPmzLstIjfM6Sabt+DvLDubEs=;
 b=ge784MPfIbLJC1VSH9bad6i/TF+Ci8dRdaJ3FhF9w6xyR6BTKAu9ao5HrImSWQtyI1IOGfEl32sq3hv0SzJxfBR0/e/LvMKQLwcoHwq9O0VgjWvBTDWwNFfqzLLAlVaSc68xo5aL/bu/KBgEEZhZWeORC9+s2BFrL3YrFXxGOFs=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 08:11:07 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 08:11:07 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid
Thread-Topic: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid
Thread-Index: AQHXGWbW4oPL2DTD4EWhsdjDotTQAqqEob/AgAAEzoCAAAwCIA==
Date: Mon, 15 Mar 2021 08:11:07 +0000
Message-ID: <DM6PR12MB46037AED621952F01A678603FE6C9@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210315064541.4620-1-Feifei.Xu@amd.com>
 <DM6PR12MB460380E2364B359753ED5D00FE6C9@DM6PR12MB4603.namprd12.prod.outlook.com>
 <DM6PR12MB4075B656A7D1D04BA2064D34FC6C9@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075B656A7D1D04BA2064D34FC6C9@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T07:27:36Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=55840098-5439-4e53-897e-10c34fce3185;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 089bbcbf-7a37-4d5b-8c60-08d8e789e2a1
x-ms-traffictypediagnostic: DM6PR12MB2892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2892759925C77EC16B80F820FE6C9@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RyfpcChBrdnhCOtrQq9Gp2AaHbHIw4g1m8FuVVKbCqV4DJub9xHAexCsNuUh4hIukLkElVAZRpa42xu5ESY5lCaOzWoMfOkjTMxQhEOcKTUpNArBA8BAH46guTVwNhe32q4gQPNLZ9sw6ePlKXNJj0TSddymGRLJzP5CiEeXFgxBvn8O0ZR7wurmnT4ElrsoBqh3QfV2sSDALrQe9+wxrcKNVtdLUv+JqGAgOVgS/oubX63sTftea+3CQ6HSSDsuldIkIZSmENBE9bkIvNYvMhhj1Ms3mdlL5ry/VxG1ormyRn43yTnHgDZjrXxvaCY6a2TYGLdczXG2dXXpdU8kic/svBX4yjLBREfrtdiSAr6pQ+Y8y/rd+9H+MgMVlZ2eRo2rCX8YPEhOeuldW1ptJel4YciD8V4CPo2ML/ljb0BPReKbu7uvgProd2AC1XySEfLsmHMp0bJRlbK4tfdL0vjpWoATLwEssDrphN8FQfeLgDE7+N0XT9UW/bSDat24n2rTb2CQ0v2xFl3J8vKjTl8SXQhY7+/dKwFbRayPYYestRDznJPi5Ic6+wl7xZQx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(83380400001)(8676002)(66446008)(6506007)(66476007)(110136005)(53546011)(64756008)(26005)(316002)(66946007)(76116006)(66556008)(54906003)(52536014)(7696005)(71200400001)(8936002)(33656002)(55016002)(478600001)(4326008)(5660300002)(2906002)(9686003)(86362001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FPnpjd+wgg4Bc5O6rWtp90RgJEJe+AByp6eB9FLa2oVxRooIm9pr1aP9rjbg?=
 =?us-ascii?Q?qiSQlAuiY01a/r8jB8hznvUCYHMNi4h4lxoo0BwmsTdLDKmAdKz2d82ieZzp?=
 =?us-ascii?Q?ddFsozGA0auyJCqJRIf6+n7oTMDHPSWMr62UhUj/OMnjNNh5CqIT8bWOneAX?=
 =?us-ascii?Q?RXtK7vfNyi/2bvuUakcMawsySJlsS9z05DIPTcZOEJS6Obg2nCD3QQjNYg11?=
 =?us-ascii?Q?W7cyHEz4N1nSA1apjhgp2A52ZfKYziK/oH1wm1UwyHqgx7Hc+oV0J0TTGCvC?=
 =?us-ascii?Q?LfFGFmFZZ/CzxFhSDbnKnnY0ZcO+ZI6qdmMZIqZlWNJ4ESnxIC1WlG2Sp0FC?=
 =?us-ascii?Q?fVOyAFwuVxarixzpYZARYTIhyhVmi/SgM5+FLy6/MMuGK0XTCP4vF2q+UNaH?=
 =?us-ascii?Q?HRjV8PghjqJt4JidCuEWAMjAQr/bOrgDFsnqCOWGczH9GGejdHdv9yfmnj0y?=
 =?us-ascii?Q?u0zqHkHiyQhamNiMAOyUoq5hEx6ZFjYpM6HIj+bfg/nn8Us6e0qzINDhvpOj?=
 =?us-ascii?Q?f351Nsa+Vgw8Uj0T2t3cO14JPjU+ivfnYizIx/8shtadNbdMDCVZfkK70Sks?=
 =?us-ascii?Q?VLjtck8O/BtLqDg2CYRXFoSvYdtmeSHeUf4spH2BznJqgjoxFkq85xyWl9ez?=
 =?us-ascii?Q?jI3EQ6+B/Mf7x5CCiE4WCk8XWrfKpXorRAvrjL4GiVu76Gg7c6fxjgLTg/i3?=
 =?us-ascii?Q?TgirCZCyThTYX4eWGWHRjPgTr62k3SDP1r4Sj+bQNdpm110Rg/q1Gax89xoU?=
 =?us-ascii?Q?7V13Fsg0jVsjPwEp+z8/1v+++egd5r6w7sfB/FMXceM9vBy48iMfQO5MINPF?=
 =?us-ascii?Q?KkAo10kPIT1limqS4sZpc8DucY2RLut5UhcPEwvG6fxprSzeGJIuNk35urcL?=
 =?us-ascii?Q?bQuCHX0tG/gPLIAAE5erJd6xd1E66BKMOjeGnwi3UKnNiMeWbjscmtarY76r?=
 =?us-ascii?Q?DK1JRjkZaLluPn7Hvev16fFd3vJOKoyh2AAmgmkXAR8MH8MytgTeWV0LURUf?=
 =?us-ascii?Q?VB0KlTBY/b9vVeIY7uFrGY6PvckBQQEYDOMn0A/9UqgTy3LlP9ToYRnz1Rxd?=
 =?us-ascii?Q?qsnYgPIAIBe2q7KplBtJ32PavA6Nmy0oRcfk3iP+W6QvTVaQMXLvqySx99Qg?=
 =?us-ascii?Q?f14DQ6zGAKkmRfc7K6/d0HeyaU4T6S6CsST9qn0bYvkKMFWUOkgXFPy1ib+e?=
 =?us-ascii?Q?jqhNFThxR61LpHHkHS/6ouQYibzwPYxzpaYKdCXMWBaOPn6fWD5SqP/r8CPV?=
 =?us-ascii?Q?ygoxCHz3FbgpkCoEH8O4bDh7xxfNbMxqmKQX9SsqBLbgWCEQENjBVWz73liy?=
 =?us-ascii?Q?hv+hkiemGl0eDeQhhRjyPOxe?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089bbcbf-7a37-4d5b-8c60-08d8e789e2a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 08:11:07.0879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVTpP77FTtRZgikTonaDMIQA6TQw6rVUHj1uV21TlU7/A8aClEwxphY3EyW15qLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

OK. Will add in V2

Thanks,
Feifei

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Monday, March 15, 2021 3:28 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid

[AMD Public Use]

Might be better switch to dev_err so in mGPU setup there is bdf along with the warning/

Regards,
Hawking

-----Original Message-----
From: Xu, Feifei <Feifei.Xu@amd.com>
Sent: Monday, March 15, 2021 15:11
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid

[AMD Official Use Only - Internal Distribution Only]

Sorry, please ignore this one. I will draft a V2 to remove this one:
if (!adev->bios) {
-DRM_ERROR("Unable to allocate bios\n");
+DRM_INFO("Unable to allocate bios,skipping\n");
 return false;

Thanks,
Feifei

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Monday, March 15, 2021 2:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid

Some ASICs has no GOP driver to copy vbios image to VFCT table.
In this case, it will go to next check.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f454a6bd0ed6..dde27b26a735 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -320,7 +320,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)

 adev->bios = kmalloc(size, GFP_KERNEL);  if (!adev->bios) { -DRM_ERROR("Unable to allocate bios\n");
+DRM_INFO("Unable to allocate bios,skipping\n");
 return false;
 }

@@ -368,7 +368,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)  return false;  tbl_size = hdr->length;  if (tbl_size < sizeof(UEFI_ACPI_VFCT)) { -DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
+DRM_INFO("ACPI VFCT table present but broken (too short 
+#1),skipping\n");
 return false;
 }

@@ -381,13 +381,13 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

 offset += sizeof(VFCT_IMAGE_HEADER);
 if (offset > tbl_size) {
-DRM_ERROR("ACPI VFCT image header truncated\n");
+DRM_INFO("ACPI VFCT image header truncated,skipping\n");
 return false;
 }

 offset += vhdr->ImageLength;
 if (offset > tbl_size) {
-DRM_ERROR("ACPI VFCT image truncated\n");
+DRM_INFO("ACPI VFCT image truncated,skipping\n");
 return false;
 }

@@ -410,7 +410,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)  }  }

-DRM_ERROR("ACPI VFCT table present but broken (too short #2)\n");
+DRM_INFO("ACPI VFCT table present but broken (too short 
+#2),skipping\n");
 return false;
 }
 #else
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
