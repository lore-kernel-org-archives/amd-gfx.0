Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E7C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 10:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA4F20714
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 10:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="suEJ4x+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA4F20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 137F06E9EE;
	Fri, 27 Mar 2020 10:17:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7040B6E9EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 10:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBSAntEWhE+dR2ifEpHB3rtlZ9rIWgQp7XWDqyTkfXflUL3jZ7hAoKPW8SDx+9A60lD1ApVGNmJAtzLs/SFZQAOjmLNtRD1jR+EJw4PYsCkUA1CdhWUxLpREI+VZFNHNSSdf2cTbOy0pjcf3Yvp25w8qHk17W8Ie61tG2oalE7eKBOtDemLmESY6x3eSgQEshFNYD1fRZ0HZGkXULMi7+zNVdvycYStACj7adFHJVmHUoSGcFBqOa03XcqKRvwACT0s2x5h+2E/f6fSVr15FuDKYMYkzOYVQZjDb0CwYRTA3wACUb6eyXjeJPzl24IcGr2H1Jxu9vVu52Ec/syVovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkXwZnYIG/32A/5lbcQB6URgGRAX4Ai9J1QEC7ZIJzk=;
 b=jNNwuV4qJNWrJT4Tcl/QqdFyxgJMuqi8ES0EhlcHHO0tS+vexLVvnl1RKPBFOewi/9t8WTb/nTW/2W053IPOdIEXRDW+BOIi803Vm+IOuWuLLQH8q2xXYdX1lymBWT+rG46cJ4I/7X6jZpYz+1w9WtZh8EGw9Qs3qFYAOrDODRi/X1aEeWHOhzryzKHV2ZsO403sztmNiqnqVOpBomCIu2SwaLOIZU5ICVuOIphjlf5i3hIx+JTC9pPwiueR/Kyrsjywyj70qvKbn7GFpStr4uLBVRbkq/fTO+5wshKR5cvuXjh4CGU1cvQdMPT7Mh2qI4NjRYuIf6E4wPRF7pUCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkXwZnYIG/32A/5lbcQB6URgGRAX4Ai9J1QEC7ZIJzk=;
 b=suEJ4x+8VSNPT6ngshrbzDEyy+epH0BiI81FG0685gNMsRXQDmMlK6cDbbgtbs3LG4Bqdkbx7Ke+RQ9cdi43IBBm2xNOCxbAhBJ2IjtRUAzviFUrbfsOwnp8ipT5BDBaoddfBG6zMIHimUzz51NLyhKq3hRRFjNxVEFarbFTqAA=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) by
 MN2PR12MB4405.namprd12.prod.outlook.com (20.180.247.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 27 Mar 2020 10:17:20 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::65dd:a977:c7a7:e9a7%7]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 10:17:20 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix non-pointer dereference for non-RAS
 supported
Thread-Topic: [PATCH] drm/amdgpu: fix non-pointer dereference for non-RAS
 supported
Thread-Index: AQHWBAtfnuXlV3G51UK72SN4LSrTkahcOXNQ
Date: Fri, 27 Mar 2020 10:17:20 +0000
Message-ID: <MN2PR12MB3663A7BA157FDECB616E4EE7FBCC0@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <20200327074256.16761-1-evan.quan@amd.com>
In-Reply-To: <20200327074256.16761-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-27T10:17:17Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fc53f256-a788-4f76-af7a-000026604f20;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-27T10:17:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9d4918fa-61a1-4cab-8fb8-0000ff745563
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Clements@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99299947-429e-44cc-1f1c-08d7d238090c
x-ms-traffictypediagnostic: MN2PR12MB4405:|MN2PR12MB4405:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44053F265F12AC82FCB93B12FBCC0@MN2PR12MB4405.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(66446008)(66476007)(66556008)(9686003)(76116006)(86362001)(66946007)(71200400001)(316002)(81166006)(81156014)(186003)(55016002)(2906002)(53546011)(64756008)(5660300002)(52536014)(110136005)(7696005)(6506007)(478600001)(8936002)(33656002)(8676002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4405;
 H:MN2PR12MB3663.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i5SmxM29miNQKFj1b8S01O3IQ4zYWlalkhXsNE1AVr/cB20iFmfxPrN+IhllXtUQoMey9SKV4E8ttvq1r2tNgFv2WhVuTbc/NMKUOWNVfXH/sQ3wFzQutkzMnUOYq+MpC/4vc7iFhyiJpFbHU+8HJZvx7iPw80Q5UZt237bSI/Is6ObVefYFbqpIcmc/9ktni7awg6C84fW7eOqcokJQMAZFpnFoZauyP+zI1aJ5WjZXKpbtdnA1XXyOEQhv17n2GPRyHLJOrSwX/TnvaETlAPAiD5UqgDCn5y53zHYH2ozrvsARoroBl91VT4gFBec9DJ64GQxcNR+UE0NEjN33p8kFIvh18AwymcyHWkKMSgKjL7VXHwczBLN5PxDYZNXUPEA53Nfi0zcOxVfxEMxW+4mvNNBafbpIhc7s6BkYejH/AsDJ/U5gzqcToqDPHRd8
x-ms-exchange-antispam-messagedata: eV0U4J71V3zNouN/GKm/HRqh6NS+IWsuXBmQTRO6lg90OnhRMh0zAr+6vZhBgMTfqDRst02ZUutt53SizzX9cqfgzX1FruUFmBwWw7cooSTGtnlydIlLkyoY8xI80ziHoMxWSLpXjzAF79rv6N6gkw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99299947-429e-44cc-1f1c-08d7d238090c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 10:17:20.6796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pW9CT3Qhw7rNGMGnuuXWHCxw3b14XTlGB68av6ElEOvqHmqh7Wm4P+RbmaA4YAL51i5F6EdLq+bBlcRmwAdj4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
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

Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Friday, March 27, 2020 3:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: fix non-pointer dereference for non-RAS supported

Backtrace on gpu recover test on Navi10.

[ 1324.516681] RIP: 0010:amdgpu_ras_set_error_query_ready+0x15/0x20 [amdgpu] [ 1324.523778] Code: 4c 89 f7 e8 cd a2 a0 d8 e9 99 fe ff ff 45 31 ff e9 91 fe ff ff 0f 1f 44 00 00 55 48 85 ff 48 89 e5 74 0e 48 8b 87 d8 2b 01 00 <40> 88 b0 38 01 00 00 5d c3 66 90 0f 1f 44 00 00 55 31 c0 48 85 ff [ 1324.543452] RSP: 0018:ffffaa1040e4bd28 EFLAGS: 00010286 [ 1324.549025] RAX: 0000000000000000 RBX: ffff911198b20000 RCX: 0000000000000000 [ 1324.556217] RDX: 00000000000c0a01 RSI: 0000000000000000 RDI: ffff911198b20000 [ 1324.563514] RBP: ffffaa1040e4bd28 R08: 0000000000001000 R09: ffff91119d0028c0 [ 1324.570804] R10: ffffffff9a606b40 R11: 0000000000000000 R12: 0000000000000000 [ 1324.578413] R13: ffffaa1040e4bd70 R14: ffff911198b20000 R15: 0000000000000000 [ 1324.586464] FS:  00007f4441cbf540(0000) GS:ffff91119ed80000(0000) knlGS:0000000000000000 [ 1324.595434] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [ 1324.601345] CR2: 0000000000000138 CR3: 00000003fcdf8004 CR4: 00000000003606e0 [ 13
 24.608694] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 [ 1324.616303] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 [ 1324.623678] Call Trace:
[ 1324.626270]  amdgpu_device_gpu_recover+0x6e7/0xc50 [amdgpu] [ 1324.632018]  ? seq_printf+0x4e/0x70 [ 1324.636652]  amdgpu_debugfs_gpu_recover+0x50/0x80 [amdgpu] [ 1324.643371]  seq_read+0xda/0x420 [ 1324.647601]  full_proxy_read+0x5c/0x90 [ 1324.652426]  __vfs_read+0x1b/0x40 [ 1324.656734]  vfs_read+0x8e/0x130 [ 1324.660981]  ksys_read+0xa7/0xe0 [ 1324.665201]  __x64_sys_read+0x1a/0x20 [ 1324.669907]  do_syscall_64+0x57/0x1c0 [ 1324.674517]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1324.680654] RIP: 0033:0x7f44417cf081

Change-Id: I053089a8e44749db23ec882d14f876ded9c1332d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9e9e0f7747b7..8a78db648442 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -82,13 +82,13 @@ static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready)  {
-	if (adev)
+	if (adev && amdgpu_ras_get_context(adev))
 		amdgpu_ras_get_context(adev)->error_query_ready = ready;  }
 
 bool amdgpu_ras_get_error_query_ready(struct amdgpu_device *adev)  {
-	if (adev)
+	if (adev && amdgpu_ras_get_context(adev))
 		return amdgpu_ras_get_context(adev)->error_query_ready;
 
 	return false;
--
2.26.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
