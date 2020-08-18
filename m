Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6256FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1901120786
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pqOohmxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1901120786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E7B89E69;
	Tue, 18 Aug 2020 13:43:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A879C89AB2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 13:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAbwv4dXVrRDe5bTkgsD6WZfLl68ASwYpuqfmVRdfGeid4eslw672qPBNaf9PWeHmrolKe6IBPmEAkFsv/1tKjbizBGl+E6ebmUlUSPvgNxbW9OnlJPDUV9NyJ8fjtsToiz4oRsPeyqEVo5+CwYzXhqo0muDGx7CMu4J/iSPlEhVTJDXGIhbkYeJYlrr5qUbjGwxAKSNuNVHMF4YWJCv1jGUVydRfIg8NkRCpQB5/sr6GAq9lf3+hhApc5O5oW3hVH6/0lkrlmmKyGAawIlXQtKyhfoEHtNVo7ArZQDYEin12tDD/Df3s1vCrKyFZcFFGosDNswxUX22XVv8Q8rV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bdKnCIt3nMk5CfkG1E5HeGLR+62lQwv0ckDpS6ERAc=;
 b=csaS++abFijMhkboFiRHba8yv99luwJzIgzCa2llxmqDFrmF3DDAvyqXBJvOw81srI49R4CF6Lbd+8nUoBQcxYcnugUDiLQRJSCQy4ZNR8HJuGX2hhooGvYZFgKPaFNZdDgFyhYXTW2fL+tZ/C+LNE+lD9oG+onDMBnb6npZbkKX1HEjnu6Jxg7bpSPzmS5D5ez5EjKXWAGtSSHzb5BDXwQo1s9WVvSPsrA0OWGcp1mkvJ6hTOxSwhAejlwcVePaoMF55SwuxQ6gtf6AbjAiOXKLyX/cM2VA+yNdGaHaydSwUjQCNZkqAxFKOWqb21Pd6exKCyi1SkECb8hVYkj6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bdKnCIt3nMk5CfkG1E5HeGLR+62lQwv0ckDpS6ERAc=;
 b=pqOohmxurFLYy2BmUH+a8Ud3lji30SHvgd6mQopNz5Q0Z8fJvpbWRVSpwFxCug97U0iZOG/UN6cfp2wCBho1L1ux54YtY0jdMJqcza4tDfY3FV9s4R9EDEhtp5Eu1MQYdTQiY2//lLXYkc8YELSm5CNqD3xzI9kWxyKI8qEnBvE=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Tue, 18 Aug
 2020 13:43:43 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1d86:f142:9f3d:eb07%8]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 13:43:43 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Limit the error info print rate
Thread-Topic: [PATCH 2/2] drm/amdgpu: Limit the error info print rate
Thread-Index: AQHWdUPQRMgRhdc+8EGMObEiSPQn+ak94I6w
Date: Tue, 18 Aug 2020 13:43:43 +0000
Message-ID: <BY5PR12MB41156F2FF9DBC5A5FE111F438F5C0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20200818094144.378857-1-Emily.Deng@amd.com>
 <20200818094144.378857-2-Emily.Deng@amd.com>
In-Reply-To: <20200818094144.378857-2-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1d0ae39a-7f24-4f23-9a9e-f282763cf63b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-18T13:43:25Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7d77423-1876-4d3a-11bb-08d8437cb966
x-ms-traffictypediagnostic: BYAPR12MB2918:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB29182D900223841A79841FAB8F5C0@BYAPR12MB2918.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZ5TZB5VYjaocwxT0d8aN6WkW9L8o3tmCOTNcM+V9gMaAWozJ04yNBT+cIEE4mETUy9jXDUVi3YPE+1xDvwuABC1mILez7mxyWxaIg4kBmouPrKnR4SGa0NP+e4N/du5hcBV1pipyMy47IND4wQVJdMKomp5FnMUrqQSgWmAMXTLWmsI+tmTLaUvZs5wsRdCBGZ5VREZ+epnoiHwcK6q1gi/Ko45kvTvstjv1rU1G4dbcPmDuHyzDXRGT5ExtJzgsgoIyCwXYt27UxAz7gaEaTLrCWayDcwilI2SDpjpW0txLGAH7eVVPR7qIzfrKEPo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(6506007)(76116006)(86362001)(110136005)(26005)(8936002)(66476007)(9686003)(66946007)(66556008)(55016002)(5660300002)(52536014)(7696005)(66446008)(186003)(64756008)(83380400001)(8676002)(71200400001)(33656002)(478600001)(2906002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: KKIEj4KYY5JlU6Y8KS12A46CidWsqHwm+PubGuwo5TSpQGrOFbbNO0vX0eQL6S9QqKSuIXq5T3Qt+qhzv6MJ6KC2Qk3BJ3BmGgMR3SsStz9Eb8F2asMa3HD0KJC1igEyaowo0x+YFKDScpGF/ZohsNjRgE+hpCIGKRqmkryEn5NEdsRET/RT2y+Oq5Y7vDzQ0I4Us6X36n0n2RUihfGFRQ3wg8L+77TOPRF3BysdlNIL1ojnWLe1oOOp8q+3mgJcOf8anIQRxuzna40TYfm+hTvn2Psrm7vnWOpMo5NXgxlxFyZUo8cPMM6qMH8JFuMkL8FexMrVGJMok2nViNsJRBOaTydup+AwtBogZFBNh/aSwvEKJoHp8o08DzvTLfFYdzT/9SOyaXgyLwrr6AWx+3PdMQhZfs3YjEslMJZVYGahj6tHhUfX85ymI2rFE4LQ0nemvDiwzu6UtRb2X+O3jPOP5zRT8lyQl1rcmv7uHsZIJoRj/7qXzHVoomMKcydSl9ghE7ilXY/045TLrXvr96L/OIvnC1cuM4mhgrEE2p1QJpRCLQtO/K5fjwBJ92oT2DpefJuRrdIzbbETO6qH8njSQ6iPBpz4GLlKrVvBy1+nZxz9BIUBCKbZyfQd3XytRRWBoq0xPN8Q5MxMFibQkQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d77423-1876-4d3a-11bb-08d8437cb966
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 13:43:43.7080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwKhOqRJOulq4ZPYX+hkVzc9zgloVI/z9pXSqqVwT2a1FU2K6NZNrAuCYa1MgWI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
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

Ping ...
What about this patch.

>-----Original Message-----
>From: Emily.Deng <Emily.Deng@amd.com>
>Sent: Tuesday, August 18, 2020 5:42 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 2/2] drm/amdgpu: Limit the error info print rate
>
>From: jqdeng <Emily.Deng@amd.com>
>
>Use function printk_ratelimit to limit the print rate.
>
>Signed-off-by: jqdeng <Emily.Deng@amd.com>
>Change-Id: Ief05debe30d975cbcf88e473c9f486d70b5a202c
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>index a94b3f862fc2..727b909b4b9e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>@@ -1296,7 +1296,8 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void
>*data, struct drm_file *filp)
>
> r = amdgpu_cs_parser_init(&parser, data);
> if (r) {
>-DRM_ERROR("Failed to initialize parser %d!\n", r);
>+if (printk_ratelimit())
>+DRM_ERROR("Failed to initialize parser %d!\n", r);
> goto out;
> }
>
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
