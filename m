Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248E0C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 11:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0AE2173E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 11:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eZL3h5SM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0AE2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F19A6E1CE;
	Tue, 18 Feb 2020 11:10:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041A06E1CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 11:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRbuldUX2FoO6bScSil9nARnZ/H8Ytium6yyCv1xoHrVylbHUGIIzbGDsz/HcQVS9mIcBAOOESAiVJVPZv63amVkzPdSWJwVvlZY7ynG/UhsG4ufIg/g8JyDe979g0PL4oy52OVF2dmijHz2zYoEANyjk4YMkUXJtlLrl4P5PouUCUrlxbw5e1meS76xahG1XlSfDFBRZSWi2ex7+2F476hyWoZ7xbzLqZSzwijWe7NzH99bUgkbJIqW3gApCu4rWy9BtgKT4ri6lroKwDYsn/dHfjZZP6Z4IIJB/U/x0QchDqiV3DW6tkl4FT0vxItl/qLXdD83XtAovBeZ8vFPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St+eMtzZ9cORo93ezt1KuZ1c6tPDJhbkmZPrIja5E2U=;
 b=WPik2ZmHzhUBXnMTtKlO5grOj8FJAkdDI2JwFuKG/uynJ9qoxw0Huw+fqukLvkMUy0wNYQ8B9lI3Utm0bLyywKvi+A0Y7hyx3bvFG5PoASb5zCtfBwONjx7MwOBG/qNFSSzlEegSe3Uc3o86PSeKTYRI8hZG6vnBZ1KhfxzKBaYM/Gf+OSWB7z4w622mtmTkYY8H/MWyC+bqoKpAdLVYVm0SLNcZxHO9oiR9T4/j8567mS9dqgQZfibkdp87ty03Y0vkiLw7U4CHxk2OtgBNuWxT8zr3DUXZ9v8CjA7I3GvJngvDV05S02k2smwfzQJArx+dwAJQncF5wISm/jJRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St+eMtzZ9cORo93ezt1KuZ1c6tPDJhbkmZPrIja5E2U=;
 b=eZL3h5SMJTwiBvEsbYE2d/DV5yqx0cKCQ42nspAAJvVxmzUoGDKSNo8xkNg1gp8p0HXu/VG3sg4ZI/e76gTPoWSrrsA4CFEXl0H6FuiWjdIOWuvkjif01BX8O30osnebPjnnVwGMokWNJCNMCkVgqYqEIneLDvm8E3WiDdlU9y0=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB2518.namprd12.prod.outlook.com (52.132.139.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Tue, 18 Feb 2020 11:10:31 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 11:10:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: fix memory leak during TDR test
Thread-Topic: [PATCH 2/3] drm/amdgpu: fix memory leak during TDR test
Thread-Index: AQHV5ga9wt5diV09tUSJMKQ6bYvB+aggy3/Q
Date: Tue, 18 Feb 2020 11:10:30 +0000
Message-ID: <DM5PR12MB14185ACF3F7A365183FD95A8FC110@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
 <1581994453-5498-2-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1581994453-5498-2-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-18T11:10:28Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d07ccc14-5798-4d86-bf7c-00005ecbabc9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-18T11:10:28Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 09534602-b12c-4b56-b49c-00004deff649
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ebce979-a016-4c90-b4e8-08d7b4632ae4
x-ms-traffictypediagnostic: DM5PR12MB2518:|DM5PR12MB2518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB25188A6472E6A97E748F2424FC110@DM5PR12MB2518.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(86362001)(7696005)(26005)(186003)(316002)(2906002)(53546011)(110136005)(71200400001)(6506007)(8936002)(478600001)(66946007)(9686003)(76116006)(5660300002)(66556008)(64756008)(66446008)(52536014)(66476007)(33656002)(4326008)(45080400002)(8676002)(55016002)(966005)(81166006)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2518;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wyj11Lx3cxoaN5R/iewKZ8VAGDDmyOSvufHo8dxoKW+juOzpJK3/7hMw2GaGAmn9O8j0vi7t7HSMXcCrMNMTpq2rA6dwqEywZfga/OnDZ+UAhhFe1+DJzYrHw3hn5MBieFYNqimVM0YkUIZqivo23u/AO0dKZpDKJRCHlxcUwdxvDgda7L7P5fUjH+UuzweYR+ybzP47O1PqbwtsA+AIqIi5OQKy0IOzuR7T1I/5Z4sxRC3uFkT1fdpz/UTAPjv+Cmy5rEhPaMK5bUnBaw7XGF002KYOGFo8rlJJA8ZfCtG5Ba+Uxlchc3T9CPEOAg9rSAgNhPvE583BHE6BZylSbJpX/MKBTZmVyNS2Q9AdZ07NngatajbJ1qgPHYyO2SqKujquvWjQJvfG/1QoDE+c5XZkdKWHO1jSgY/MXwoo8/UQoci1JkfmJ2oHID8bS6Kes3MLVJZOaAkzIUrcvi+AWtpS13M7RpT6Xa08QIaIYoCmUbABpqve1avIRzHNbGHJBruI+r1dVkQDcrhOhSM65w==
x-ms-exchange-antispam-messagedata: 9wYC2xzhuucNpBpYDIz54QP3bfltq30JT59zO8KmkHPTswh7jPuZaBIAS9hOzaUJDPQTRVz0wrKibfOQ7genSASHWkupjBNQwgQQVGPAfXCLfBfTOPpDJneIAL16jrsnD7pI7Iu6MnGC3+8RDmleYA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebce979-a016-4c90-b4e8-08d7b4632ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 11:10:30.9868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mA1+BAfjTUFrck8iSo+dJg0sa4DVytDb4ygWzn0x8Qa2QRjaPVro0FslwUDSrL1gZ0/jHBHwzlSRcsEM0KAmQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2518
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

! smu->smu_table.max_sustainable_clocks is the preferred coding style. And please also remove internal changelist no from commit description.

With above addressed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Tuesday, February 18, 2020 10:54
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix memory leak during TDR test

fix system memory leak regression introduced by this previous change of 201331 - Single VF Mode Test

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 9d15acf..3363f1c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -978,8 +978,12 @@ int smu_v11_0_init_max_sustainable_clocks(struct smu_context *smu)
 	struct smu_11_0_max_sustainable_clocks *max_sustainable_clocks;
 	int ret = 0;
 
-	max_sustainable_clocks = kzalloc(sizeof(struct smu_11_0_max_sustainable_clocks),
+	if (smu->smu_table.max_sustainable_clocks == NULL)
+		max_sustainable_clocks = kzalloc(sizeof(struct 
+smu_11_0_max_sustainable_clocks),
 					 GFP_KERNEL);
+	else
+		max_sustainable_clocks = smu->smu_table.max_sustainable_clocks;
+
 	smu->smu_table.max_sustainable_clocks = (void *)max_sustainable_clocks;
 
 	max_sustainable_clocks->uclock = smu->smu_table.boot_values.uclk / 100;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C25101ac0816b4d8229ea08d7b41dde6e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637175912700145000&amp;sdata=hu7hjIM8mNkrmgCktuZssVeHtoKATywBXI2sGJYbRh0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
