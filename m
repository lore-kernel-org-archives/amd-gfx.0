Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACB0C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 03:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531DC2064C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 03:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GkOOO3OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531DC2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07576E88D;
	Thu, 11 Jun 2020 03:27:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03A66E88D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2020 03:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/bMvS66anwc4SHhOjwVioIIfp77UfTiChxVKIOBW/7LV9Bn3kzUYwSqSKB6s2VI8mfqMi0KZYTEocUJYFhCV8EnVkYAZeITw1ZCVgcYZ+p8HVtBRhh+4NVIhW1klzTz1JNTlzWp1XuAtpcra6dEA23aGxGSz7Q/QGJxXeDqF9FK36+gaXLkBHUcOP2W8WPHRfxf1DPgn5Nah/Ldc5lqmRo3SpTbOlBF4mRsZ+8YM/2efT+o+PEHek+pqS6+t7kF+taD2SX3JuFo66iw8te5SFxo/nWngTt4FwO/2oBvY1oXioMEi4Q150eHK2Lsv5eUsWQFmNeZ/nQJQ9RKbyZcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csEk4qLJpEsGTR9FppuvuTe83OfOKG/WAQz1TfM7AEY=;
 b=I3xvVp7vLU6cd40qZn/yyHYxndoTKxDr8Lr6rWpiQ3mizWh79PpRbXU4HFlieI09A+VpDcOgXeCWl6YA/pCl0XvMSrHFGZ+DM6NcoK6FMXAmg9TZ3OrX5llDfruwZAS632tOXTrsQgOMmPtFKUGdVQq9eeGUFEECmudhDH52yWv03KToTlg94mKxR2spNuMIOzJd8xO5if+CCrZO9FvNPD0Uhni0FGtRstEDT7fdjHTRWnGCmetTR+3gXcNjt17NJCJHAt8s6+CqfSCoBdZpLY7dxOOqfDxMZnYIgCbmhXkrvSkxlwLI6si8Bmu84t+9HMnzdkTEaMnBAqx9dN6MjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csEk4qLJpEsGTR9FppuvuTe83OfOKG/WAQz1TfM7AEY=;
 b=GkOOO3OMPkq7ch/4OsVWJKkR9XDANuSdaE6EgE1W/Pe9H1PsXXr2yQHtIkDyFNg4kPLCK6iqfHrHGARcknsMyut6y1aD7ImtRbMdjKIy7e/2hLTpqyvR0fDQeqF8KG6lSwb2USi/4zWfRnhd6HF1bhUwOuhwf48hKZKm+dhs4Hs=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Thu, 11 Jun
 2020 03:27:02 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::1833:ccab:8c0f:4570%5]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 03:27:02 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Topic: [PATCH] drm/amdgpu/sriov: Disable pm for multiple vf sriov
Thread-Index: AQHWONrDcaSY4g/gLUyuCLUEMIRdcKjSzo0g
Date: Thu, 11 Jun 2020 03:27:02 +0000
Message-ID: <DM5PR12MB1708B4367D0FF362E06FB22084800@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1591101603-21219-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1591101603-21219-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 630f650b-54b1-4009-bfd1-08d80db74ecb
x-ms-traffictypediagnostic: DM6PR12MB3371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3371838A477D5D6218374AC684800@DM6PR12MB3371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7LPcMAZ/2eRSZ40BO/WxLbeGUD/BgURm6QENRyfQakp9iCwVjKdVwQjtXetqVokd43Ts1VkQngneU8o4qMcS4einACC5CIuCwbCtAwTKoaeSUubXcJsiRtKyTuIm/RWFbkEOmZNKdVP9Dc64ON9Mp4H2GCizLhA+ixTyImKEfRZyaAAQqSIxHjCqOCHsm+mkwXNsdAZbcL86nviDzye2sRzR1I8fWEAX4f4fD+OGheD5fvKc66NLrKQB7QfUYiGxdmdcxNv6vQG8hiIWldjqw/yT1OyxH7lPCQZ0kpMxKA45YHUGBxqZii97IGd8UepMDZPnA3jE88A2i+IVsK+z9IKck7x2oUDfK0rW7R3sH8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(110136005)(33656002)(52536014)(86362001)(5660300002)(66556008)(66446008)(76116006)(8676002)(4326008)(7696005)(966005)(186003)(66946007)(55016002)(71200400001)(26005)(478600001)(66476007)(8936002)(64756008)(316002)(6506007)(83380400001)(9686003)(53546011)(45080400002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: oAYOyzT7Hk1l4H5D5d3VXsHQdDNIq5XIsgNfRW9jl60OeEyAOfkpKgBShCxAV/XePkIyOovuH6NQKw/v8n5PdyqZeabmYC6nGlLqy5nqnSXMXQ4qTa3ESl5YUSumShltraTINkSL4fcB47wriK2mQ7j8gx6/ye6A1V3ct+ZzlFdCGSI2NA1GnlgXft+Cyhx47I8sb8j57OV3B9azsg/5ylPcrAN15oSlp5qxc4G4wGvkV3AAORuUJZ9Ai7dbiywaQxAl2gPp4tz6FR+5XYEBDZS6V3PlrADELIMnFGLKuBezD94Lut/dwTK4CsIre/vXBPefYI3X5lVz2uroJcrJcHpi5v17tEts/bwWqKNdR3y6Z+xHh00blKKCg5obnl3DTyshTH6KpIjUINavA6QmnuAT/V72dsinXHnr7dYlrHyY8NiETJ58W5RvKKYqv766YDRc06FMWwXwjj2kQmJhp4GlA/N3dlTQGUAEsv+aJL85M0/1AaEjLbaoszil0jOu
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630f650b-54b1-4009-bfd1-08d80db74ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 03:27:02.3118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PKjLzEI+BxudDpHX8ZBpHHrWizn7qc97yK2kQRvT1buLNZjXtd47wLnbD4Ag34s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3371
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


Ack-by: Monk.liu <monk.liu@amd.com>
_____________________________________
Monk Liu|GPU Virtualization Team |AMD


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
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
+		smu->pm_enabled = false;
 		return 0;
+	}
 
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C2641ef6641d145a005c708d806f1e44d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637266983285813096&amp;sdata=sTB0tRfcRP3bqm9L5qNDTVsbdJxZcfHxPs9WuH1tf1M%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
