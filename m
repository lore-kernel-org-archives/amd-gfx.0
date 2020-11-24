Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A603AC63777
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204C8206D9
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 15:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ehWjS5Ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204C8206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84CC86E432;
	Tue, 24 Nov 2020 15:34:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D8889CD8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 15:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V73vsuoq4OrfFPIk7/eZ1JtH25zJp6KVXxQEMEEinQ4BytTKAfAgbMLN61dw5Ve8OFyJXIwDTwUsneI9XZk6HMrbSfJ4d3UsAaYNqII35FHGTR3wMrkHOGy7NJTyQm+UlJDZ3Nkvbb+E+6x6kqNHHRm4MPrcqc/ZD58n0YtxpSdl6kUbdyZd5LIcU+knnorb5mwHK60FOkap+slJ2DXYTJGRkV/OmOpuUeF2lA354QtwdArFOJV1tm7fFRyg0iMesdjutK1GrbyvyTsTyvcfZEY2rcEFByn1PKtQWGdAq3AZnuvAJmxhDLG+Q6Y5/IAFHlBq1Zhu0pd5GJgw1LuY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXUvEQC6d9t0vrww5kyxEccQXIOhUV/tH1SUoR9+Ntg=;
 b=VDwWt8Thwt3gxjLA98VBOQi7Yhn6ShH/fzt//tBgxXmijOz6sOMx8VQEV7ujWTiwZKE05V90CKBZVAXrhHOMsZyEl9wAl++xJz/IbyPYZ4HQW5e6wx3h2DEB4F4/u5ZdncxH8hhZhyrHFPjKSsUod7gJp2UagRk2NPuUeh1nbSavPvl4waclyaY7KfYcHjQ0TrWI8SrDfqJtnx1kVD+jKxndlZozj2AH0BQmgdZXF1B95QEkDtbMqYHBbemAML5PuA6TRv+sKaar0MTzN4Kl3MgVmQH+/Fd8QLYJU9Dj4BJ6mgjEDs7JGfEVJmq8irw6SUrXhKQRJPYMaJP28qMwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXUvEQC6d9t0vrww5kyxEccQXIOhUV/tH1SUoR9+Ntg=;
 b=ehWjS5EjTQw7gP2r6bgP7U0iRqO7N9O8Ps2HWMRnVC0G2baH+xPY9wmGG2PjahgprYqaNx9RmAvecscaBcfCzwBJW+KY2aZFa5tMRFTTw1pNNDK6OfNl3102DJUluLykdZSTNTb6gBZWKCD6rV5ms50t/60JNtBHmD/C+sHrex8=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 24 Nov
 2020 15:34:27 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::29c8:b853:6998:7578]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::29c8:b853:6998:7578%6]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 15:34:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/dce_virtual: Enable vBlank control for vf
Thread-Topic: [PATCH] drm/amdgpu/dce_virtual: Enable vBlank control for vf
Thread-Index: AQHWwb3JFcwMsvZgx0y9j0pEDXB8NKnXaooAgAAAa7A=
Date: Tue, 24 Nov 2020 15:34:27 +0000
Message-ID: <MN2PR12MB407800985A359D39A08FD42FFCFB0@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20201123172455.19789-1-shaoyun.liu@amd.com>
 <DM6PR12MB3835E2345150FD342B5D4E76F4FB0@DM6PR12MB3835.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3835E2345150FD342B5D4E76F4FB0@DM6PR12MB3835.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-24T15:34:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1b27ae8d-8d8b-4ff8-a5f2-00001ae58550;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-24T15:34:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e8dfb80b-6e09-43c1-a7ac-00005a503dda
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-24T15:34:25Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 32fd42db-9e92-4623-9555-00001e3496b0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67ac2568-5280-4313-6045-08d8908e6e0e
x-ms-traffictypediagnostic: MN2PR12MB4534:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4534BEA594EA1F14D3648704FCFB0@MN2PR12MB4534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CwtmYA+A8R3icuYjTqY1bMoWe83I6WwkAtvWKwgms7QiKkbbS77121uv3OWZhZLB2wUDUBVSoPVmRghJ5sMmG2TV1ttWjqQfyGWR4WcNX/2kmM6SX7ZQXDD4AwB8MlvTlhMSZdEPh7QzqjN6ke1M4L+OR7i4k1FiUiYvfJp7NXb2PKPN/SqGvkOH6WlnqGtClDX+Jz0PD11i4hz1KC/0YOh9uZdBgeIARLfK05RPpLLmz3+LrQWLpfhTRPr/E7NVdVlS63B8rPMOsHY51IQeR9aCZc+QpbkM9u+5zmTF7d8jJ23nPH75MKS3AKtvS0DubdMNFnUOUWjrO9Bh42KXTqdTZ6G9pVxZi+DoBLGVQZA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(55016002)(66446008)(66476007)(64756008)(2906002)(66556008)(86362001)(53546011)(9686003)(71200400001)(83380400001)(8676002)(110136005)(316002)(76116006)(8936002)(66946007)(186003)(33656002)(7696005)(966005)(52536014)(6506007)(5660300002)(478600001)(45080400002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tC3Nfv3mjLrm1bHeoCQjAmSFGAYvfDlbRPT+PT+qt3LHC9bfTg1fWF/u+q5SuWMtaGqZnVgmD2rMs9IGfrySVcjCoxgS35FGjr69CsbwP2QjYrFls508ze8LJIqAxQu40QkZiQoWwRniBF/43VxKofCiXNKWaailq/OG2fTt2xJsqmBVC/mYwU/NfUkpzoWifP9cxPY6C4z6avs3Fef/ZVLZ1e206s70U8tslzmfsuK2anrK+x55aD+MnI9wWzBYAvdVhY1ON0dhnmHNL1w2gpHi3B4UYdqqjCScOIYWsCS0Fy76hdgbodI90IJr9LtX7pZPjpuGcSuomn3doVmHiftWfQ7UgtNu2NDqcr/DxFR+9bz1c67AGx86kUUsT5C2YSfafeO6zfbZnVnhnEKm5X3u2oHofgZptfhyDrDXI7yyievoQEu/30nHYnX1ljKDEq4wDyfttCJKstGFITBulCg9Zw0gZAUbFPqFxFGpjSNKhgoHsZ8ErXdKuZ2+D7pKx5zGDZAcno8VTlZaiIWRnDntjBr2BoLvOP1oKdsrw8HhP9Fw782jKFoh9teuTr+xEUjXISATtp795T5+nf06peO9+w0tF9nLhxvrQHuWi65DQUllHkP6pjvXeH/R2555cv6fNou2NTAwUImpRCV6idyBHl+ivSkdt/GLH1H0rTJI61Hd3K4UUkX3csQX60mQiIcLA9KW+G4lq4n0W77kuiL3b0mNxDCKeUlKRAkpV4UTMJdpr6yuDPDVVvecqTQjeOz0ZjKuo+7f0jNF3ljyH0omkDpwABVx+2ijZ7/ok4kItUtrOCPaXq93dxw0wOayXVnGlMi6xVLBiuCkgiDiGQXIQMDyNrz2WMlBQX1pYQ+/lV1fJPbJndSwZGeuOCVFymCvyUXlOc1sdrSBSH9dFA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4078.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ac2568-5280-4313-6045-08d8908e6e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 15:34:27.7802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBbaQqDwJp9PpzHvmw9tqYyPyJggt9lesAxlCoIwZQ2HdPxjnj2PNBODoJMF6XlZPNzwCDwH3R/ghUaN6ap6Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Shaoyun
Sent: Tuesday, November 24, 2020 23:32
To: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu/dce_virtual: Enable vBlank control for vf

[AMD Official Use Only - Internal Distribution Only]

Ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: Monday, November 23, 2020 12:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/dce_virtual: Enable vBlank control for vf

    This function actually control the vblank on/off. It shouldn't be bypassed for VF. Otherwise all the vblank based feature on VF will not work.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I77c6f57bb0af390b61f0049c12bf425b10d70d91
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index b4d4b76538d2..ffcc64ec6473 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -139,9 +139,6 @@ static void dce_virtual_crtc_dpms(struct drm_crtc *crtc, int mode)
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	unsigned type;
 
-	if (amdgpu_sriov_vf(adev))
-		return;
-
 	switch (mode) {
 	case DRM_MODE_DPMS_ON:
 		amdgpu_crtc->enabled = true;
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7Cd95fd29821cd4d595e8808d8908e2936%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637418287547631145%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2FyMdkrzE6RMI6QqjLYbwho%2BzMzScKw4HYY7t8bBv5QU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
