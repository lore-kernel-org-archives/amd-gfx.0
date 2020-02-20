Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB1C11D07
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 13:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9BC7208C4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 13:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AlWfPzaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BC7208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D376ED95;
	Thu, 20 Feb 2020 13:56:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C306ED95
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 13:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVs/XzaC24JRg0d272OzLg091XRVhw2mYCsQnXQsXxV9u4E+lkIHYHFDb/sjuJ5HQ56XaOd7JfmKULR9gIjx2kar4XRKUmvRotbrJ0ztgsRBZPZD9p/Vr3B1Cnc25yS4WVORPh66SldqlvD7bP/D3wSzV4+OQ1f9x9BbxAnvdqUDQy21Xo8dbrVmtS4SnXJqqv6FGPEqSj8/CpsViYnpnzJPfsjd8Kp1z+gFHQUfoWuEi4NSjTuvj7Slyi/U6Dt8uPDNSUgXUnQIQlfzGgOOb2P5YtD7nxDAnQs+MVmc1B07ieiuNGEf99brb5G+v5C8Nsy+D9O/JtsvYfYfVNIu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F94lJE5RZ9AhM+VDgroue2CKaA0nVQj99Zm2GFITur4=;
 b=lHAs6W2+k8qozULxzzI7ikOTl6hhyDuji6Jd3TpbF+BRsOAYq9UYvd1GDlvaI5D44osoBHlD/xqSRrYtNla/YyfS9nP69NnGPWnBFwiJ2hTQEuPNTOhtEuoJ8BOcae1rpOUTX0PkgAqxWXkOD1sYkIflP+LGZH3Lm2gLkIXoqU7nBouh/XZvme3xdKoiniguyJkf5tr+McldbjqtXW9CyodVqLUfsFuYFpNzVp40dV1QekQk0Cnn6Fkc3UdzfYOXoPalG/jv8bhL3WWRtGLO1HtFFV4GGmYwv0GYfabkPXhy5LxkRdZWY3wh6SAIR7wHpb7L5qsRLRseK5Tk18Y0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F94lJE5RZ9AhM+VDgroue2CKaA0nVQj99Zm2GFITur4=;
 b=AlWfPzaAge9HgAxgurTGStN4AEsvsQLkyZNmlpYobYYy8NRgLI99RW2Rz9ti1kg1S58zqG7zvF/jtaAQlOgMrIeyHnxR0Dj6eUIT6BCZO+A4bk8/vVflaRzbwjFOD44q1YeMhmh55vUkDg26BFdyECPZB4YYAtUOFXzTtI/h8fo=
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (2603:10b6:208:d2::32)
 by MN2PR12MB3408.namprd12.prod.outlook.com (2603:10b6:208:cd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.34; Thu, 20 Feb
 2020 13:56:31 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 13:56:31 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/discovery: make the discovery code less chatty
Thread-Topic: [PATCH] drm/amdgpu/discovery: make the discovery code less chatty
Thread-Index: AQHV51WgIeESZsNfKEy3YK9TlA7BxKgkHFw/
Date: Thu, 20 Feb 2020 13:56:30 +0000
Message-ID: <MN2PR12MB3087BB083D053D9B6F0163B289130@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <20200219185130.222028-1-alexander.deucher@amd.com>
In-Reply-To: <20200219185130.222028-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-20T13:56:33.978Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
x-originating-ip: [180.106.41.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29435926-14bd-40b8-db72-08d7b60cb051
x-ms-traffictypediagnostic: MN2PR12MB3408:|MN2PR12MB3408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3408A07503A7A335F2B3F16589130@MN2PR12MB3408.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(64756008)(66446008)(66946007)(91956017)(76116006)(66476007)(66556008)(52536014)(81166006)(81156014)(8936002)(8676002)(33656002)(5660300002)(71200400001)(2906002)(6506007)(26005)(316002)(110136005)(966005)(7696005)(478600001)(4326008)(186003)(53546011)(55016002)(45080400002)(86362001)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3408;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:3; MX:3; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdugnJEYESQACyK3VJcXzOzkwt/5spYdBop1EN9V0aHKBF/Z66TsSPiztZuwXsLKJ+/kZIyZig5Bvb0KbJBt+bs/KBsKDcEW6yjBnr5y6Fxdx5MUsTp6Ph958dw0BeoO5omh8S+uVtrCu46cpNSH1rtSFweKI5fK1YW64D4bFICJP+Z6FDJsknLmcJSaYr1JvDPaZ9SYD91Om2Bk1uPRvQ1VVUBZH6v2363DeL28ilnK6Qp0OWOnoz/qCl7WOMVgK5ArHL04W+3QNzMThH8I0HfxNykR+0PaPj80PdpsRoGQG1u7BdUmTK8wbm/RRx1HsOSp1kXO7aGhSpMr1oHSIN+KGbzcNJTcjhvxhnEUsOQPCkEgJl03zE2/AysDAcWSueyGNAdT5S/EfJb/ufsvwz+FPJ6D8iUOK6OA/sa1R/s06+lraXNoOLo9ikqJpKiXvoXzlzBGA/7JzcSkn/B9EPg5AW3mmz2Nn0vZtu+vQYIgwZLoDlXpAh7AUKUnGcuP44Ev3AM6P0AYV/yn57Ew/A==
x-ms-exchange-antispam-messagedata: q3sNJXutqOjr09O3lAuuGgeIrbDu+Ov20rfurQ5s7uof6bptGafom997eX/Rd9BmTYpNAgqPmMHPe+3ZIHnm5tuk07N+PMT6A0Mdb+K7234sy52zcSEw7yKOHv9moONCgFMtiGynkv41aKSByZQ9cQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29435926-14bd-40b8-db72-08d7b60cb051
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 13:56:30.7973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVcC8wPgeV9vc2Oi0SHUN5G0A1bkFehUD0Cx24BGKcNyIYKEmuegx+7qujTxsgnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3408
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

Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>

BR,
Xiaojie

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, February 20, 2020 2:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander
Subject: [PATCH] drm/amdgpu/discovery: make the discovery code less chatty

Make the IP block base output debug only.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f95092741c38..27d8ae19a7a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -307,7 +307,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)

                        for (hw_ip = 0; hw_ip < MAX_HWIP; hw_ip++) {
                                if (hw_id_map[hw_ip] == le16_to_cpu(ip->hw_id)) {
-                                       DRM_INFO("set register base offset for %s\n",
+                                       DRM_DEBUG("set register base offset for %s\n",
                                                        hw_id_names[le16_to_cpu(ip->hw_id)]);
                                        adev->reg_offset[hw_ip][ip->number_instance] =
                                                ip->base_address;
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CXiaojie.Yuan%40amd.com%7C6bea1e07f83447f56c3c08d7b56cc1d1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177351030201676&amp;sdata=Hyukxx%2FJjHeCQrsvWboFy5t5WTrj1h5zI68ugDbT0m8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
