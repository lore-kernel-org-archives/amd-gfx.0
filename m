Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C31C47247
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 03:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C724E20725
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 03:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m89azTBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C724E20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C926E1B8;
	Fri,  8 May 2020 03:46:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0F96E1BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 03:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/tZW7l83btAfktDejf+45X5ecXsPWG9zQzDDojwCW3/rt3A3OYHXKWlLFluaW1FucPYHwM0lS4S78MccL9XAhY98ivEstW4eIxjqqdQ5uqM2EUS+wMEJh+sv1Rh6x3IqE6kNq/+uIYlEH5CxOpUwuZOMdcOCLOnpQlUJUFklFSw8LFHY0OrCjwW7csmkCKLap+QB5uzsD/a/SaoVWukbYGRL0aUpFhs/pxaGMX5rk2wE13/ly1d/tk1J7mYA/1YgL2BqELg1TPGDY4dqABif8cVFuBSjT6wxF3LxzS1HtZlT5PpI9rNvUueM2hueesrWE6T3b81CN9KVlyOJO/uRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FSlbm5n5HgucC0h85usrdR5Clymt/3ldxB1cJdh1sI=;
 b=XM0r19HmyTzHtMqngnMpe/ZucLN4lsRr6iqS2Ht4m8njRp7IeiS/InVoe4lacDvchM2Kb5jy7BrZF98k9KOj8JPntEIMKTmN4ZdaAuJbiigUnlQ6gjzjYOM28ouagx7Z9zlEEkUcDenHKWMUkTiEoSSbpUzJaYvuJi0CHD+ZSd9DvFfmh7uketo+5NdofdJhK9ZECG0IuGQeTrqOa9hOM0Da+s2SY9btSz11JHyI+Ye3G0EgTVRHM5ik8S8rEDboJRvntftpVsLwQvfGhKckCtq2yFT8Tc1qCGvJmojHWf0YT5ShhFMj4DKUIiTVYMnU3SWeIi/yalM6CRosg4nuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FSlbm5n5HgucC0h85usrdR5Clymt/3ldxB1cJdh1sI=;
 b=m89azTBqt+UkAJ5JYYRD1EFcrRKJYmqh5MSoPPN6gXsGl1797J9ucnzULvtZtuU2AKnh6q5WTjRSSAbCyxfm1AwCvNWKyeLj2Bkvy4esie/YCaXFadnXBxxpzV5OnhvS09Fhu01O1lufMt47dhJanOfu4belBZrUANKxmMSVFs8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.27; Fri, 8 May 2020 03:46:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.030; Fri, 8 May 2020
 03:46:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: only set DPM_FLAG_NEVER_SKIP for legacy
 ATPX BOCO
Thread-Topic: [PATCH 4/4] drm/amdgpu: only set DPM_FLAG_NEVER_SKIP for legacy
 ATPX BOCO
Thread-Index: AQHWJIm+UIcvgWNKOk+tfUAwe+fhJKidjScQ
Date: Fri, 8 May 2020 03:46:13 +0000
Message-ID: <DM6PR12MB261932171757318D2C6866BFE4A20@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200507160808.4250-1-alexander.deucher@amd.com>
 <20200507160808.4250-4-alexander.deucher@amd.com>
In-Reply-To: <20200507160808.4250-4-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bac2c9f8-7e2f-4a85-8610-0000690ad656;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-08T03:45:29Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61c97173-074d-4a3b-2cd8-08d7f3025aa9
x-ms-traffictypediagnostic: DM6PR12MB3467:|DM6PR12MB3467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34677BCA007763B6D1D4BA42E4A20@DM6PR12MB3467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+ZpklGDgpzYBMbdO0X7lGJQlP5SsW4D/nWTXqEFGaOQmRV0WkHsNs616bkDOn+N+RPfUzrhFrlmqR7EOz1naNRX5My3pD6s5MDUa4Y4lQH/pCArbjlMt8e/yPTc1tD75ChxzbCDDc4eKMfnPVtwVsXqXg42ap8V0Id5kwkQE8ocd61k1kPQLoxUTpB+mD4KAzUWnCSefCzXduPDeP62hJBr9Tr3hksYIyR0P/y4UXHXr1ybKyWd5M1FR4JRcwjv5NHWZlvts9kUE5OnI8ST8PT4dJfLYHmKcBfbo4o7c5889ik+4iIxlK28Am85rRq52n2I3KIHAWfZMjavFHehhD9wC9FtLtGLccIkBT72tsdf15qJ7tNpKf7jQ2MsNBxSl/V4/FmNHjDBGGjKRpgncthYDE00OlnvTsNzv/rM3MqO4ghqkXWMOWIzKEbleoYckp6oJhnBV5gbd3PQfETdiFyEB7w1aIU9A07g1V6IDj24J7dTij7mb9oBFgG4BJQ07VTs4bBKnLcn+OnHvTcvjBtc0W4jX+cboiR9E/DCkTyQFWipM0HGSkGCTAwusZ47
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(33430700001)(8676002)(2906002)(110136005)(64756008)(33440700001)(8936002)(66556008)(76116006)(66446008)(316002)(66476007)(66946007)(52536014)(86362001)(71200400001)(9686003)(7696005)(4326008)(33656002)(53546011)(55016002)(83320400001)(83280400001)(83310400001)(6506007)(83290400001)(83300400001)(26005)(186003)(5660300002)(966005)(45080400002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: uuyTgLF9a+lXQMvhOOrvUIzTqh1OuZivoPTsPk1bZ6X6O6L6xGiQpnEYpZCgdfAE6kxCouVqHJdcJn6RZPo8B5Nzf76RB+JPKqJI9an9rKwVWz2WystD0Me3L6p8YA22B4hQMvNp3QPzkIbWvcRc7WRxo/BvUqI9Zll+van1yhb2dyS1V0On0Vx4uZJB999VrC4n1yYzqbnAcFZqKgXZE6zpkxqEayXh+eHBiIIOLLXop3sLWbvWK0tCQjXRHEXgKB8W9/V0jdqXY6/gQige6BzeoBfa1BKRKQHSdsetyewSeFB9i6Q/kF5j4nJfc+GkQ4s0VLyanrAxMhuT45OtJ96XIs55fYg6ittrCpcoTlLDPzw8fpBmOrSw/W86f6Gdvq+Lu1StaSL9PFINi2ZI3gbnc6QL3/yk7ZPEVHIJ4LRmYGNgo4XZJnefzmqqLVnm7TebLHQJlh+IQlbVsDlv/jSLAUYRasIUkUmfo7Ue4TRf66aqNe/DWmYpbzcUU1pI
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c97173-074d-4a3b-2cd8-08d7f3025aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 03:46:13.1282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4peze3Wf90ui8S/6FaG0MgYw4c4tKQxF8wnsy8tOrfaEjdVDV811q94rSeHQ++J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
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

Patch2 is reviewed-by: Evan Quan <evan.quan@amd.com>
Others from the series are acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, May 8, 2020 12:08 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: only set DPM_FLAG_NEVER_SKIP for legacy ATPX BOCO

We only need to set DPM_FLAG_NEVER_SKIP for the legacy ATPX
BOCO case.  D3cold and BACO work as expected.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 233d6c8c4ca3..4e4c9550dcf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -188,7 +188,10 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 dev_dbg(&dev->pdev->dev, "Error during ACPI methods call\n");

 if (adev->runpm) {
-dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
+/* only need to skip on ATPX */
+if (amdgpu_device_supports_boco(dev) &&
+    !amdgpu_is_atpx_hybrid())
+dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
 pm_runtime_use_autosuspend(dev->dev);
 pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 pm_runtime_allow(dev->dev);
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C62fe0eef98e74285482908d7f2a0dd85%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637244645084791405&amp;sdata=n4w17BAf2MR8AClxM6RQ8MZHoTnMiC3aeGj3RYUPdtk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
