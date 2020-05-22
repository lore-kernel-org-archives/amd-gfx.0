Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A5FC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00D5206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 05:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lH7U0nKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00D5206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1026E046;
	Fri, 22 May 2020 05:35:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99106E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 05:35:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+5x4mgI/jfWFDSJkZvadZ3qYq3NrnSCrbj6RlqoQP4hfRSB5rATl3WnFND2FXr72KrwjQUKSVJtHdX8EHiuirpiRwkBxEAgIrlNtshophOLPeTCh+wKZ6eMj5UJwgum9b1jF2GGfMHiRG4OprnAdFyfTgBafn4p7+TJFTEGtfD48fqdWGJZxVjRc5h7JVEI8DHPR9tQwlUdDKXmxlBwAoEaB97sjz3McFuw1jWf1mVS9oSVSlZfrikV4xZWEbD5gvPSj/RMvWN8ZVMsKe8yNe6p4gfwRIab6m16ms+I6E4O2OvAXnBS2Z0bIYxkksn7tLUKs0mATJK8xhzx59PYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pERAMNZdarxvyKHMX/S9FLki/M+FgLVmRdxhfChGsqg=;
 b=LZVLkVqUCO+bN2W1DIe53cV4FHSRn4oXiML7ntEn+nwLCmnGEEX4+JYu9a74hbp2NNNC52RdQiExrhvL5XXISzAPLI1e8ml3kaZhMqHQ7U8AaPGPrZJ5zB1QBWgSp2AZhiPpY4b8Iw6C3/zaZIWIA3ISl+WANt1gDleJUsRYwAa3hAHu7ayzxY2rNkcPVZpdnH4h/sfKaPmOZmv93Fi5INFbVVDwDS6wRqqQ+yIP+a4JZlADJ6lKn16we+5/Ham1f03AsOyCPvNc42VMFPxsllrt1h0PvuRIY12aD3tXso/d5IQjnu0S+3gFQMfS8m229QCdzNVXHXshqkwM1/leOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pERAMNZdarxvyKHMX/S9FLki/M+FgLVmRdxhfChGsqg=;
 b=lH7U0nKerLS2uw7LSF5J1HHiGL//o3CIrc6xBH2PN0WX06qF6ML7PVyEutgKPiVC9DVU1nNs8lic/O4E9zHrVsfzlSsvUZKhnZrYq+Rjy5FNKuK6MNOjq7/+pZufKs0eYX+AykCL6k0oUS5kF0NtHi0Df5r/LFmQRm5bRLHeyB8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3498.namprd12.prod.outlook.com (2603:10b6:5:11a::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Fri, 22 May 2020 05:35:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3000.022; Fri, 22 May 2020
 05:35:17 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix sysfs power controls with multi-GPU
Thread-Topic: [PATCH] drm/amdgpu: fix sysfs power controls with multi-GPU
Thread-Index: AQHWL7gl6BJxwgFrSUypIHvvSK+vlaizlfqg
Date: Fri, 22 May 2020 05:35:17 +0000
Message-ID: <DM6PR12MB261949C39144B50C765AE290E4B40@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200521213806.4016-1-alexander.deucher@amd.com>
In-Reply-To: <20200521213806.4016-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=89065e4e-8308-469d-9f47-000000075cf6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-22T05:34:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1944000-f7a9-4a6b-4986-08d7fe11e940
x-ms-traffictypediagnostic: DM6PR12MB3498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3498A9EB5C79C7A1258AC8CAE4B40@DM6PR12MB3498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NIzKmepj4uXA2DCC4c84IwtlaX6BxqD4gWHmrNKtzFX7+mcW2TAN8n7R5v7MWFywwCarwYNRSmlYx0PkSDSv6qWZUYLDH2/uWmLvRi24JzNs2ShHKrYBWTzhc+xYyPmi+veIId21eAdWTFjeWLBUjj4lbfO6QtYXmhIMaQhtJPoBpl0EQJAFMCfESVxbm0/zYvOXs4onmdgKEZBMB7BmJEH6IwaEbLtiAf43T4yP0aEKRovsah6LJUyKPvJzp6FV46I9CEI6ksOcGebTQkZz0OIW1CaDezVr6FSjzWToNMOaQr1EhFV25VPa1DeWlitasMvQh318XCyVPDTRFd2FIaCx5HD35LXALfiS2EwtEZeoGF69WreSqN8oMBD+48N3eAAeqLHCrNMAndc8YUBPd0RyY/BBMqpPGt2NiN+nr5ZBMzUEJpsETLrHUs03bu9JVEDT1lWHhchXytPwFyfFRGPIoRe90+gaGYs/RjFAG0Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(7696005)(6506007)(4326008)(186003)(71200400001)(2906002)(33656002)(966005)(66556008)(66446008)(64756008)(66476007)(53546011)(52536014)(76116006)(66946007)(478600001)(26005)(316002)(8676002)(9686003)(45080400002)(8936002)(86362001)(55016002)(110136005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: MeHrYg04DOdDPpI4HoSj6qEsCxsPeVDdiiTiA7lF7T9Pt/Rm5UROBtJ6oT2I9ffXieUo1tJddfK1+FW8AKPCq6CAWgdZP2lJPPLn3PJmP7nDQehyRaZH6qmtF5Wjg0IgDWY4tsE5QEkWjkZSX0IZhoHLb/ycmAvrcVKe1M9KY2I8lzFc3oSiajrSmkC6BCd1lQEd262/1i4yPZRAQVhfxf4o3Xuqf3kbHdiMqVGXXhlSLekcbhgwq4M8qqH/1e1G+ABQT4Fnq9PP47ZS8EXFtm/ZvzYbioGZebu4qNMdtGi2NCXdo6HkNiSv+3EHnkQcH1CvAstahnMWePLTn65zWo5GjwV7W/bnXdU7+NfYZTRZu+w/kGOgUz5H8EBd+GBrpxMI7YleArs3GyymAlrJNw63zQ8SbwKTn6FS8QTuVpEv4hV5mrM7IWtnuZt57et4o7+Ed+mAutzfG7rD9m0nCfHJPzBYveFj3jEuoNep6ULF7NVXEHAr+z5DvOGrzdvX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1944000-f7a9-4a6b-4986-08d7fe11e940
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 05:35:17.5039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPpgVL79OKLIejpRkSsXXzhJCdP1OvCAJ++ItcAsYg+zrqDUDEaGQcQVO/rMI2Yx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3498
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

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, May 22, 2020 5:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix sysfs power controls with multi-GPU

Reset the SUPPORTED attribute.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---

This fixes multi-GPU, but I think we could still race without some sort of locking around the attr array.

 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index e06fef6174e5..4c65444e9ef7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1790,6 +1790,8 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,

 BUG_ON(!attr);

+attr->states = ATTR_STATE_SUPPORTED;
+
 attr_update = attr->attr_update ? attr_update : default_attr_update;

 ret = attr_update(adev, attr, mask);
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C4f723e2ec23445c7cb1b08d7fdcf4618%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637256939010091750&amp;sdata=pZgnlqdAqOFNIX%2FfDKUiB1J%2FoOIFz72E3pEaTgpTg2I%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
