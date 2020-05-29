Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D844C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 03:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E361A20721
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 03:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ywAZ45ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E361A20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E186E856;
	Fri, 29 May 2020 03:03:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DB26E856
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 03:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU4TiOaUfgAb2tlWoiNZVPji3VUWdmsARrY9JMHPQhxLnjnoM7V4GjfNgJZz0J5jtWrefbU0SwLFLgZayPg5h0vrGP+mkLO4U3AUPiukoX2KxruGIAyoV2WrirMxUH/SSHtTO6UxCqVcX5l502/pf6+2fCi6/kP+UIxGOAHu8Mn263ICfsNPqS1+bdCU4wnBC+QcZ1h+kNVW5cejbBRffc07l93H5oIHbBv520dEcyRkVE7YqIJP+WnYzxIy3QCpPWZtrZ1vc7dWo1nqF9dVrKtp0bWftYpyIWheXMIVUJwfSBElzz3aiGvyw2kdsp9PAMJp5gpp0MNyo8JhVGNmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYEqHrI6y0Bez58YZlFBJHt1i4zWlcdWNIvsabJcxg4=;
 b=hIuRkURzqf8q+LcQgXAvA67WHKsVaFcILUI08zZznXbB6Tn0J2YRgvip15MN0PrF8D17jAqbeq/R36twdyTx6HN9fMCwDrTTfKMGzt81Nrqs2jtO79p4xVVwvNL//sz4Qz9LVQbHt+Wq6dDtBjIj1aQyLMbtZz/ZdbEKDdEYZuYc1wlwm3quexaaqJLrZjiMZHnh0BKHO1jYcTRuPaij+fPDZ/qDIXwDHOitWHc4mMNciO5B6K6gYnZJ6XjbXU+0MPCF+wJyHWLks7f1Ukq2wMa/q6+S3wjMYQtmBNumNNuWKPlyOwSswMi8aQcbKcZgqCENKEE5B4PUQ3QoXDmWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYEqHrI6y0Bez58YZlFBJHt1i4zWlcdWNIvsabJcxg4=;
 b=ywAZ45ho1YVaX5GsPBURZN1cEPnG2VpVCbXuhcsQdHt7owtzz1B4DYnPxui6Tt+NUdo9CZHFxJ7y6tnm+HrLx7v/ehUjGA695N4uKUq3jOjGFvMByfvUA+P6I+MoRd90fQ1qdrs+FC9JmvuUIoQQb/JP7K/xoca5IMSgWfH6HHM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Fri, 29 May 2020 03:02:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3021.030; Fri, 29 May 2020
 03:02:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 6/6] drm/amdgpu/nv: enable init reset check
Thread-Topic: [PATCH 6/6] drm/amdgpu/nv: enable init reset check
Thread-Index: AQHWNTf27Jgx2poy/E6LIE2qrg/9oai+YKGw
Date: Fri, 29 May 2020 03:02:59 +0000
Message-ID: <DM6PR12MB26194BB9FC1D6B80D2A084BAE48F0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200528213529.673145-1-alexander.deucher@amd.com>
 <20200528213529.673145-6-alexander.deucher@amd.com>
In-Reply-To: <20200528213529.673145-6-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=82a07fea-cb7e-42f3-8eac-00002de17195;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-29T03:02:06Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52053251-0184-4057-55fe-08d8037ccb8c
x-ms-traffictypediagnostic: DM6PR12MB4450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB445084659D942F397FC41B20E48F0@DM6PR12MB4450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5mT9mo/JlPrRMBMmJzPwoWO8vX0HX7B27mgdPsbWEx2YtRoFrVaKzNG7ifW/iGcmSmg4tB3F5md03u7ugIG2bx+Fgw0IN8SeuBXi2/dtnUQQmAq6D8KJZng/eq/Mdp7YFCs5JnXtJKoOsm0d2pf/OoQIPnNP3dJw/jtCQDrQai0iiGD6F88r28AOgRJW6W6enTZY7vIF+yba7IudYOdjmAmclxbZ9FL/+C/sj7+aqDv8dNuhoH4OqlSYDh0TUj9NJzxr0z9XKxFB7hymCFR28IguSGgCaU6hvOs20GRcBiGOZEvWzhFJIIL8IPe5dIQtufUtq3psPNtnQXJSIwLvhfw0M8b5HbKmK55J8BGzi8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(83380400001)(5660300002)(33656002)(9686003)(55016002)(26005)(71200400001)(66476007)(64756008)(76116006)(66556008)(52536014)(186003)(66946007)(66446008)(110136005)(8936002)(4326008)(53546011)(6506007)(7696005)(86362001)(316002)(2906002)(45080400002)(478600001)(966005)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 3u+6TTdZAH2M/WZS5RMcrFmO0DoCrSWxNfKvIzbsPVjwcsQs5GgH1x3aTiHTqtaHOf1UEHcWYHq0QycdZBWwQ6xiJZJ2SW2NMnR47GNis56Ki7wQxUffS5V5bqsed7GdjQAG5tiwCeg8O7MQvCJqRX8jAMTSsqVmtdnedG2JfgIUyhUDwq0hOoRFQbbiMV1wzdwwe7we0u3l2MVLBYIGsP6KKlVTuPvnQAPDlAMgpm0XV+NAmhkYvkgBnWPK6vr70YJa+G9TAP+nhs3RB3M1MuF/EhNrVfG0Qq9pc4isTCyoygoFKm5yPcqtxZ/iA4AW/50QmiiXOpUqJt/M4nXJWD7bwJ13DAD/6NfFd0cCEAwQ504W5MBt/75v/bvBZthzY5bE6ou81tdn4jQ2Me/4pYYoWa3kIE8XPAwj/InMHJR2QA2Ej5T3zg69D6CAVsbVPLPxL7TOIe6AUiCYwh5phVBErqW/855/Xu/2qzAqeqXuL6CszZTkM3EybdaOkM4X
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52053251-0184-4057-55fe-08d8037ccb8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 03:02:59.7805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iULReVq1HFqp9JSJ4S762WlVeY+8yeL3oEXvwHdOSFPLc2iTb9Rde1P2FJZ71Ktr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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

Patch 1-4 are acked-by: Evan Quan <evan.quan@amd.com>
Patch 5,6 are reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, May 29, 2020 5:35 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/nv: enable init reset check

gpu reset is implemented for navi so we can enable this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 0f927fcff0d5..fd3b9e21a5bd 100644
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

 static bool nv_need_reset_on_init(struct amdgpu_device *adev)
 {
-#if 0
 u32 sol_reg;

 if (adev->flags & AMD_IS_APU)
@@ -526,8 +526,7 @@ static bool nv_need_reset_on_init(struct amdgpu_device *adev)
 sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
 if (sol_reg)
 return true;
-#endif
-/* TODO: re-enable it when mode1 reset is functional */
+
 return false;
 }

--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C7a7488e91f1e452df51c08d8034f1589%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637262985526500839&amp;sdata=1GY9VAybW%2BvAU0mZme2y6jll%2FuUPllXT9YwJq54wmmU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
