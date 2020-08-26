Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81E1C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 10:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBFC2067C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 10:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2rUc3bKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBFC2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDEB6E106;
	Wed, 26 Aug 2020 10:01:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76ECC6E106
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 10:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdrOTqynjXq6ixI4/vivqlcJyadJq2rSNLZAu1WD7Va4APzqc/XCemrJ0YeBMYyA7xg1Eh+XII/G0GNtNyYEJNvOr+SSk3CkRClN6bnbtYMW6bmE3Pq/TX5JQChbFIDUe9RLfsu4QzM3rS5V7X2ZADzIox2xqwxrea4B4uFmwrqJNOfXTqE44I6Oql6oUa9mxwlPZLT7JegDYkjYl/9SRv4leeN1KuByVAf0tR1x+9LYgy105aTQH540FAEdWS7DE2yF/cfooqr1LdfGXkEXkxhnt1Vzz7Wg7nWhLMqwjeYLxoGH4dIn7x/+IAPFd3c+QYtduXvb4dVPsyWFh5b7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhVEAIzIn6OqYZ6VHM+HrlhuVqY3uX2bMFofl4pSUog=;
 b=M00CHKE5fRZsufrpuYZX+heqqZqX+VxaHAPXIia7q8R4BYyVqKJhr/mbV3RDA3I49HtbHs/WRkw+GwuuTyRdfiuQWLJcai7cUTi7/rqKBoQ2+zaf/jqQ+WhwiCGBpECts+34TH0n77njtHoyLYNmmteFYaxeSlEJR5wK0ho7rs5xnCjDy9A5LAICAgnIY8wXJ+o8ol8zigz1dMpjSbB0V5a4+At0fOYWkJa9y8KFLYUJ2fhtKACImm04vziYngvYYlG3lrbJZHWLnN5eVTQv+GERq0zSbI8E/1ZnAahwOtMhITZDF7cYPUWf7IFGPRT1OekucMLzPuzmVa9FisC+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhVEAIzIn6OqYZ6VHM+HrlhuVqY3uX2bMFofl4pSUog=;
 b=2rUc3bKgEqQVlWZDFBRC9kaJfdIkHd+Z3FCgPREEEWU6Dn31Bh+PopsyFGhNa+j6lyuh9hZ2sGJhWva9BTTlS/M86tDD6HsiEIMmupS8aGAGR1qeF8sZutZad14e6KCFt68QOSIaGC8TwDAtONxeYV0dnaHBY6S7aory7rEa4Ng=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1450.namprd12.prod.outlook.com (2603:10b6:4:3::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Wed, 26 Aug 2020 10:01:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 10:01:49 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable runtime pm for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: disable runtime pm for navy_flounder
Thread-Index: AQHWe37URHki4+tmbkCcNVozHJMbfqlKKJug
Date: Wed, 26 Aug 2020 10:01:49 +0000
Message-ID: <DM6PR12MB261978DCCB09D4EF10520B53E4540@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200826075917.2598-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200826075917.2598-1-Jiansong.Chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a4167001-93e7-40a6-8d71-f378cf231ec2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-26T10:01:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e078f6da-88b3-47cf-a32f-08d849a70cd5
x-ms-traffictypediagnostic: DM5PR12MB1450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1450646477668D2E0B575FC6E4540@DM5PR12MB1450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r0zto7pBnDvpG4/rKd59yZrlqZANlka3dG69ykgIdpXCsbaWz0em0yr9d8hQ7UsICdva0c53b8vDisdLOCGheCAx63/ayYcgqXxb9OBjvf+5fEzX8nlHtUU2tm6K4GcwE4MONUyoEiaGxMXhc3Y6PNuoW/P0I3f7yGexqzE6FKz8SzUGagWRZ9q8bZcHohN4PDV0bJKSqdrRAQar6K22gBae8TXlfNc0p+LSF0ZjYLblOmORihK008Q2NN1R6Er6BrgcZAXjeL1eOIncpdkfRwGOhweuyP3XtjIfXNtimnaSSZUfWmCu8kLTZVr2uyhbBruuTD3lMBXvWPZcxVGzMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(8676002)(66476007)(66556008)(64756008)(33656002)(76116006)(5660300002)(66446008)(66946007)(54906003)(316002)(110136005)(478600001)(52536014)(4326008)(186003)(9686003)(6506007)(53546011)(8936002)(26005)(86362001)(71200400001)(55016002)(2906002)(83380400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TgAeWK/plDoudIWrSbeQjTIO7q51pQs5buNStnvKOVlsPc5ZnApcN10yBEaHrZ/+qxQ3YFTZxhkuICV+A0pTf96NCxskqg39FRgMXC4gYb/ogIXYulLL/JmXyLivDXXyYxIS30YOzh1hCMfoio0EcS2F4VxMdrEVtycW/CoUUI/W6l2gUZxwFk7+b+BXrsPYW37f17aQf874OpsiaND8pUc+bh8hL/TtLlsOh6jD1Rkjr80xEU5ZapRN5a5KGHa5Ntu/nNe12zCUkbJrfsVyzD7qbW4dabOA1lKbZjk9rmITksOcsrQlNXcZ1Y1wewXDOLwM5JAr5VGjEFavQxwusooWLRFvznIxNFbkgR4tW1sw9B2FAloe1U4mImLv78Ld32mfzD53CoKy0bl8o8+ZpeRwvCQ5b4XhQ7MZDBdhmU6+mwyWDl53H4G9VhyxQTX4hnH55hg2Wr+L7LomfjEclgw5SmAn5ejVH0VpnbK3eiVTujOcfh5Rk6xO6ZqKAyxC/z8mzYHAJnDw9ulQqz2M9cdv+R2lOeQdLtqBjfwDFeVH1RxR9L9qr1tsUGeR4cBNGLdyh4f+bQjfZ3zUjZYx3N3axEwPc9Y+iNMmpP5cwXMZg8vJzJIU91Te9/BzDsfkZOmk8e2ilnPP6UixJITyag==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e078f6da-88b3-47cf-a32f-08d849a70cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 10:01:49.6229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FpyhjFLo1uZOJjxQLoDo2AyivxDVzxs/vreEIhoWQmdxjA1yRGqO0e+fFGZwxBNK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Wednesday, August 26, 2020 3:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: disable runtime pm for navy_flounder

Disable runtime pm for navy_flounder temporarily.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Ie1b03f09ab70e79b6dd67ede5547afa23c063eee
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9f80eaeaf0ae..caed73d72d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -170,6 +170,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 case CHIP_VEGA20:
 case CHIP_ARCTURUS:
 case CHIP_SIENNA_CICHLID:
+case CHIP_NAVY_FLOUNDER:
 /* enable runpm if runpm=1 */
 if (amdgpu_runtime_pm > 0)
 adev->runpm = true;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
