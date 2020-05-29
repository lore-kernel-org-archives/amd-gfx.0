Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B64BC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 03:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF27520721
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 03:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GugcgGy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF27520721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD9F6E235;
	Fri, 29 May 2020 03:02:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690636E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 03:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAzfpwetMKngtfYELLNl6u+Um4R7ETzgUS/1N2woVHJoCkBVaMgkNF8Kl+ozMnpu8+paNQaWVv86YvEtufWIcy9rvkDPOuwd3lI/aNDwVWa20vjBEF1qH0XWYeelxVJqxy0KDU3Ta2yFvU+MbawxxdrboH70mf43heaGN1AgNJPm1NTbWLB5MxzKkX0+B1ThdJlLPGaU0YA2/jFKiAHHA5tgA82e9xh/Xg/+uxVoEZuiwlt/X4CLW2/SxKH5v5oaBJutgt0g/vLdxugqY1H1+WG6cqu4uVv5/FBQnQR6ozlayPFxf/HFWGRtLzrUVccgmvdpO8ANpRIcI7oPCozEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bo5JFZYQHTpq0ducqNn+kztQiL4rC9AcRpuSypw/2s=;
 b=MXH3zXoSPZJDgvXSQfLilVP7OWgRmKNVJECfCIDGk4oBfPuIArC/J3jxdMMTa4bx6KTnMKv8tKYoXGCkudYs04DrnKSGcSzFcMdDPBIYO3sqRFz/SRgx49Q6hIW66eimVgDBe0vI+N4b7S8XTLgtl1wVS6utBimQ8AAy265OsE/h94GmQIvD0oxerJaKvDLDoYfb3ioIbuTjxLDIX/RY3WauthKGwAL4Urk+VfpzRuvDR25Hj4k+xcA0LSfyeeKvgnb4mgq/8Mn8dSksKVD4XQCge30xV6CJhvCrAWbTTvodRRPBb9ADIas7E1F0v6v6Lq+P44xqno3+NxQIUfJdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bo5JFZYQHTpq0ducqNn+kztQiL4rC9AcRpuSypw/2s=;
 b=GugcgGy/spQDJE1g622IfjNc0iT5clPtamwjZq+PjO+Ic+QsyI+4o4b9YD15RlafBnEcWF0vQ7b5e1xNotf07A2vlC66re0BaH+gkcmRtW1KY/+OGA7+0HESRgVGC6lDl0Cu2wGODWouE1WCBOAWOLiZV8dgzNICKiyxdl9BxNY=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 03:02:20 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::286f:9ca8:b189:3c2d]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::286f:9ca8:b189:3c2d%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 03:02:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/6] drm/amdgpu/nv: enable init reset check
Thread-Topic: [PATCH 6/6] drm/amdgpu/nv: enable init reset check
Thread-Index: AQHWNTf0xIXRpXzN/EmPso0eNTWduKi+YJSw
Date: Fri, 29 May 2020 03:02:19 +0000
Message-ID: <MN2PR12MB4078616A24773003DF552944FC8F0@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20200528213529.673145-1-alexander.deucher@amd.com>
 <20200528213529.673145-6-alexander.deucher@amd.com>
In-Reply-To: <20200528213529.673145-6-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-29T03:02:17Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0f1394a6-78ba-41a6-978f-0000e6dc2390;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-05-29T03:02:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f91e1347-c763-4ff2-bb45-000043bd0d0c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8d5bb75-cf47-4cc8-dc25-08d8037cb3e5
x-ms-traffictypediagnostic: MN2PR12MB4486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB448654EBB7B71C0657D54168FC8F0@MN2PR12MB4486.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYIX24Lg4t91sUMd5sRurVz+Oy2quO4JvT+wOe/73GJwYbhE9nGGnTGzsvIqtXW5c2vzc9B3dTvOFbT6Hk7XRl7jKrhQwLXV/euhk9rqxlC2ZgMj4rRTiaU6hElXZlGZzmD2aVIl4V72KLDKgDitZFaYR7Ke3OMULXRg/QYmyDBwE3G2WueQ+Xr9dykbsZ/SGAGy6wadCBl25hoMG4eeVoAtgRcTi68YnQQuwl3wurkvHdXUqO64gM34UMSuwpzfrSk7VCO8gq7MpW1A62YIk/6nXWtLlV6BYItI0n1pc1g7Jf2IBrai5pnk0aJWk5E6JwtZB6/aFBpNUBOBfzkRxH3qyzDure3eEbmG8DkT9TU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(55016002)(9686003)(478600001)(4326008)(45080400002)(26005)(53546011)(66946007)(66446008)(66556008)(186003)(76116006)(33656002)(966005)(83380400001)(64756008)(6506007)(8676002)(8936002)(66476007)(52536014)(7696005)(71200400001)(316002)(110136005)(5660300002)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: AYiw4uH5KBtmce5tiv+YQgr0Lkh7MoSdKAAXvOL6le1OTnYnT3CtxIo5z+Sw4iWcw/dn1cgY7zpt8s1qIpq86Cf4d8BvTFzfAgQy7oWHUWb5owX5i4NdgCDmfzf05GHIgaquMX0T4ZdLzFrGc2xaaAxFU2VI/JMWgcJEe8j1M+l/izMNVmeAvDeVazfUaFzxUQ6qYg7DI//QE0hTm8OcntdOe2vz4uG8isWIeXtpa4Rtpag/DoRpu33E+zhomC0ESHKkZF6rjTKzZfyvjl3W8XoFa7eGYye3zSPEkg4KLGtOvt8/x6rp4no37ov5KE3wNXH3q7iJwMz4D/BRyLBc7WqS38xeAyl2gsRUbyIo10oYtWbjZIAj5y83STyfB6DIjD4pQ4i/Drd+Ca9cfdgSS1XjN4MuhGxsqTFUx2tNxqVgqDxgRrSB/UOGyt0Ur3UAcNZxpHBSAxLr2beJaum74eJTuVaoeQBDKvDe5P579cIpTetfzB2On2aHYh9g3fkp
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d5bb75-cf47-4cc8-dc25-08d8037cb3e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 03:02:19.9390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fLvwJhq/eiHtllj3t7iWoiVD/vG2CEq7d/2WxrKL59JDpUxhkcS2CLDUR9ZIQ2vsQMqhHvr05B4gHFAy7MHQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

The series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, May 29, 2020 05:35
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/nv: enable init reset check

gpu reset is implemented for navi so we can enable this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 0f927fcff0d5..fd3b9e21a5bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -41,6 +41,7 @@
 #include "hdp/hdp_5_0_0_offset.h"
 #include "hdp/hdp_5_0_0_sh_mask.h"
 #include "smuio/smuio_11_0_0_offset.h"
+#include "mp/mp_11_0_offset.h"
 
 #include "soc15.h"
 #include "soc15_common.h"
@@ -514,7 +515,6 @@ static bool nv_need_full_reset(struct amdgpu_device *adev)
 
 static bool nv_need_reset_on_init(struct amdgpu_device *adev)  { -#if 0
 	u32 sol_reg;
 
 	if (adev->flags & AMD_IS_APU)
@@ -526,8 +526,7 @@ static bool nv_need_reset_on_init(struct amdgpu_device *adev)
 	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
 	if (sol_reg)
 		return true;
-#endif
-	/* TODO: re-enable it when mode1 reset is functional */
+
 	return false;
 }
 
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C461e9591172c445fd4b308d8034f15fc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637262985495510583&amp;sdata=NGZFIi8Z13c8JPnescBK9zOU91Ow0o5ZgrBwSer29%2Bo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
