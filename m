Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0D9C54FD0
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B7220775
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 10:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mDKJnybs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B7220775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4202E6E7DC;
	Wed, 25 Mar 2020 10:49:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00896E7DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 10:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYNyxspxUb3pTptOatiTiTbu+rPMCkeehw6TukfDYI2YTA5feZCovwvjZN4nxHNGOZz5XxaLafh6cr2T801wTDgWVLimX5kTTgQxXXyRQ1vulFHIpqVcLSoIxhEmen+CRTc3W+MFZFVNndTaqEryVUayNywzeaxh5SQvzOdNUnnN4ikd5hoss8QfZ5kUaV2c8dblkqjAqKSACBNLhqMCP0hwv8sOdttNldQ/ZDX69KumGY+lc38xlHt5+9VLH2uzqNffVaJGVfM7lMUDNS0ixdkx8WHN6TwGoo2A4fhWqCmXQg8Zv9RuauFKiQId+QggWnU4aL4sWV65tueUm/Xh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olUPJK2EfHIUhqp26itfbMJUZGBprHrEhuJ3GXoZCys=;
 b=BGoIIGek2yVJ0Yh8ZjJFCNlnHfsIyZljMCYgy2yDnwhuVI6+eXMLFLsqNOvWYb4pFSaDCkyyyNmf0WAOhyZ+9PzXnjN70L9BYxzqINZeP1mYwrXva3rqoUfl6HMloe3knzd2/cXzTgFEV32jjfxQLU8Dq1Nm90PIRSZcAAdOwJ1UCh657QJjn4bGB3vobICOqDw5FzI/geMi3xALHqRy6wTqKxTqNhh01HAqbb3nhVVBeLMh9nDmTu8Lom7zj1204dvK0DdCG6o4HedP/DOTtZBOe3Wm0vetDsQUwFI8WrRdUl96Dg54SFN7nrST4dN8AS+c1zEsyXlsPsCqQlaE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olUPJK2EfHIUhqp26itfbMJUZGBprHrEhuJ3GXoZCys=;
 b=mDKJnybs1klf8AByegkCCuPdk1ZuiWDo9BN4KP81wQIQCwNMVtATMUPdU+d5iiufd54+hm8d7iFzUXO4sziq+Xk2mkL5yEiLeQWqTBcfBdISstuusSUpiKoC1SOLULMQ/TRXFHAiLYFw3TY/cJr40b0l3PD91Jcn/pvmNRWgKyE=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 10:49:12 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::e9bb:a239:5bd3:7325]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::e9bb:a239:5bd3:7325%10]) with mapi id 15.20.2835.021; Wed, 25 Mar
 2020 10:49:12 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] SWDEV-227979 - Add 4k resolution for virtual display
Thread-Topic: [PATCH 3/4] SWDEV-227979 - Add 4k resolution for virtual display
Thread-Index: AQHWAoAhvrUJD5TyWUWUYUjkZHIPW6hZIQbw
Date: Wed, 25 Mar 2020 10:49:12 +0000
Message-ID: <DM5PR12MB1708D587F14D4778B88ADDCE84CE0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <1585125181-14195-1-git-send-email-Emily.Deng@amd.com>
 <1585125181-14195-2-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1585125181-14195-2-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5136ebb8-8e25-4edd-ad59-08d7d0aa27ab
x-ms-traffictypediagnostic: DM5PR12MB1323:|DM5PR12MB1323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB132330AED101BE1B05AB7BF284CE0@DM5PR12MB1323.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(53546011)(2906002)(45080400002)(81166006)(33656002)(66476007)(966005)(66556008)(86362001)(81156014)(316002)(64756008)(8676002)(8936002)(66446008)(110136005)(7696005)(66946007)(55016002)(71200400001)(76116006)(6506007)(52536014)(9686003)(186003)(26005)(5660300002)(478600001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1323;
 H:DM5PR12MB1708.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K4kLIsFnw2ahhWHC8Z4S9Ss/e3xYP2OSRVQrWmGoTh1nPEHJl7HBdyJYNkAksch/s2Pgo6l7XqL6UI2/09fT95QP59HARn6HhFvXqT5Lc4OloRHdSet7q34uK22pcoRifIJ9QeVfFxIzmirRV84QUePf2fyxt9oQj4To3dRpWStbSt98FOMcLdtMvnwAvwDQGbyGUa4IDqwv7IeJjEnv5Jt3gOv3lUZp0q5M0Vn+IuxuceFUa1fhncjQ8ZjtXYxFJ3Evm+kJH9YX7wt8kDtFv12lsUDBfWvrsYwIFf9CbVjxYGZP9YeTLL8XkcbBgU3QWWfEBaFj+NzORvPlHfvxOmjvbMr5V0LfGVua+w3poeVnIhK5IChOJhCCrjocrW2xiMjid5BvMpLi639fKLY+ACGFJHEM/R0IEKH0U6ouX5R6E9bsVwXHrM8b9Rh+x6Bp/3+ICyFjDrMToUbUhAD9GoK07F63Ca1CSZVqXtNiFZ8=
x-ms-exchange-antispam-messagedata: rRqtOd1pPslyreqMQtNNLXdxP8xBzUKBvsyI/WSz1xcnRLyAYJPk9gv0iwl1UU7zDRpZfooh+f09h8w8Ev6Z+S3I6KCj6G9aI1+yoJoCoqIwKi8gSdhuZVzRwRBTA1VnUNbFGDxtvU7R7+Yymzzu0Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5136ebb8-8e25-4edd-ad59-08d7d0aa27ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:49:12.3235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fg67y+55zw+pR3ibveJJhJWYFHoPAC3LaiS2M2tT4letHNvjpapF4sS22kdcAQw9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1323
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

Reviewed-by: Monk Liu < monk.liu@amd.com>

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily Deng
Sent: Wednesday, March 25, 2020 4:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 3/4] SWDEV-227979 - Add 4k resolution for virtual display

Add 4k resolution for virtual connector.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 3c9f2d2..8656cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -281,7 +281,7 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 	static const struct mode_size {
 		int w;
 		int h;
-	} common_modes[17] = {
+	} common_modes[21] = {
 		{ 640,  480},
 		{ 720,  480},
 		{ 800,  600},
@@ -298,10 +298,14 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 		{1680, 1050},
 		{1600, 1200},
 		{1920, 1080},
-		{1920, 1200}
+		{1920, 1200},
+		{4096, 3112},
+		{3656, 2664},
+		{3840, 2160},
+		{4096, 2160},
 	};
 
-	for (i = 0; i < 17; i++) {
+	for (i = 0; i < 21; i++) {
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
 		drm_mode_probed_add(connector, mode);
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cf39c6d882b174facb0b108d7d09740f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637207220392464369&amp;sdata=NV0xdvR4f%2B76237I5pM8Zd02IU1ZzPZHXpeu8%2BlGb70%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
