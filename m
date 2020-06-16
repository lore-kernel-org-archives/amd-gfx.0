Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382E5C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1012620756
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3A180hzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1012620756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26F56E7DB;
	Tue, 16 Jun 2020 03:24:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770073.outbound.protection.outlook.com [40.107.77.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52B46E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 03:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUtIyqvNf1/kBfBv2HJ3d4Y6AYUt0yfj3XzmOxIEgXfcQablVAUcNqyBIWVwbImVbe3cncI+aDmeG5LyWD7xcV0lxdpKj32J4FZcrS3q836vXtQ1CRWcpn6MhhkPzddctXUW2Kj244RVhLrUu0hk2TLYirthRqcwRt8Q72opzuT0lS3fdTTHCz20SSYs8Z4Xl1O8glfcMozkJQuALaiPOn8K6dUptt2A7ToOp8AD+JY3tbIq9OKnBBN5ykARwO7WQfNM0Dr/6N8jItmOXhDX0H10dtY9Cl6fku6w8yPwyPyLJyBtHW84lC1MvN9wWubQ/AvxfZVjPTRrjIdpQNmIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjSaS1MSXUu8uVpgY2PiqX9yWYaPOFxxPEpHcmcpFvQ=;
 b=I9GmEem1DJ5hfH7gZNmeAO7SxcXiCnodqiwEBBfGTy2Ujrc/3vcBGVOgLZDE/kaOlezG5TnQMNZhrdt1Ph5sz9KnMFUl++RhUjJh6QtQYQNi5aVin3u+OiqRZgWxNX6246JW4ysS7MpuMMOY1++HWa6y4Z5R6SPVkJrkwVjKZzZQqBnY8YRBifhH1wXvxOTN4vyTZg6HQDciu68Wvq8uauwIdryDYZxC9vjYj+MSOVyxQUAnSmijpC0oiqH4AJ7WkAfUJ+E6ONB1WNUiYwxVuFuxKlZ9YPmCVvJgie+ZTupvkL2JWbulzrCA+e41mVx1/D6G7VSpv3xhoA9WyHl/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjSaS1MSXUu8uVpgY2PiqX9yWYaPOFxxPEpHcmcpFvQ=;
 b=3A180hzKS0TmxiiKfGRNKJFFDKdbluZP2vnKVSDCMZz/0JUgbFEDkzDE8c27t50mKy8GVENtjiWYoiZaWCaH2GaerxpBcQaYERweAFR3ndI49Fm/PyJJYYCxCYD3tV5H5J+hAyCzIQTuxxs8s+utZcMNYzmN1GVQTjYWBQkCDAA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3578.namprd12.prod.outlook.com (2603:10b6:5:3c::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.24; Tue, 16 Jun 2020 03:20:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 03:20:23 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: update comment to clarify Overdrive
 interfaces
Thread-Topic: [PATCH] drm/amdgpu/pm: update comment to clarify Overdrive
 interfaces
Thread-Index: AQHWQ1MsMEHSI/7qfE2wKIl8TD/fAajak3Zg
Date: Tue, 16 Jun 2020 03:20:23 +0000
Message-ID: <DM6PR12MB2619ACFB3204F8EB19397E36E49D0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200615202535.2455665-1-alexander.deucher@amd.com>
In-Reply-To: <20200615202535.2455665-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2bcc6583-3ec2-495a-9d32-0000c1d44176;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-16T03:20:17Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2313fd1f-ef5f-49db-115f-08d811a434f0
x-ms-traffictypediagnostic: DM6PR12MB3578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35780C14158093D849F37596E49D0@DM6PR12MB3578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8h79i+XF1/CUn+tYaW1IXr03l+voQ0rq7hhg2DDGiWZlBzzkcSYB2YqLYZvDLYRmc6bo9atf6gv+tVhCSy9/YVyfd76zdFuES7tK3V3R6SHdv/gyo8RtGhs6L/aeaortCfr7eToDf93d/qMFZITJW77B9AcmYMBLtukC4t4zHBQcVMKwl1NWriznubqLbs8beRPoIDPfDpFwnjwraf0YIilzK3Q0sdM81Yd8v9yQwv9ApXMzCsWoaUy0EtayLA8aSRbcS9f30cFM16Rj3g1l0H0OLdDwTn+NQqDW/FZ0GbH8Ja0Ggt+IiXOgi3pI94Y4lRbO5kAH5vOSfxGCqpqYWXrL2n7kE/MO6cgyQu7j134=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(478600001)(7696005)(52536014)(26005)(71200400001)(9686003)(8936002)(2906002)(66446008)(66556008)(66946007)(66476007)(76116006)(64756008)(86362001)(45080400002)(316002)(966005)(186003)(15650500001)(8676002)(33656002)(55016002)(110136005)(6506007)(53546011)(83380400001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: bqPgohgO+mTjZB66MfZvBDEn6oEagXFodHahga1NtR8L9Pqrx20/acyngsGcFYsVh7t540jWItjTFvIrkcMPdog3l37JHlwIWOjTeYcRe7FcGRb/pu/83jvipOkbtZGoq8SYthwYTxXj333IDtuswBaXHDJ5jO7ll3B/2L1e35QzAJWFhyCJwTplt9a+FDtHBCkU/c9USgehu9DGevquQ8TTV9ecLktH0ZR+hBOIZPLs9MVsdxeKGIOYHmLC4JwVslxOLiiqUBwOvE3GQBMx4nX2QX/FxWZeU304UEwHHe4RkYu3p38YeOe2Vu5A3w1tE7N0GhhEf9msg9QA53bO7PtSWmk6rbZyh8czr58l5M5dszN94O0+u656jvjuIWMC0nJ+lvaliS85nn8qtCSE3lhudkbmH4swxAkWH7Uf6ChiP8/WJp2Ea1G2Eh61GE5kcjC4Njf1NnF0xLXakMTSwDk3GZhALl1Jl8+ZjmEh+0atAB9njHogUeIa/0vr2y1r
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2313fd1f-ef5f-49db-115f-08d811a434f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 03:20:23.2402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 368NqzKmUkN/NXYCAgGnwuSXwalnCxWmyEiIVk4676ex7I1tmc+AcQKBIEpdWLNE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
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

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, June 16, 2020 4:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: update comment to clarify Overdrive interfaces

Vega10 and previous asics use one interface, vega20 and newer use another.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 395ddbe2461c..5a8e177e4f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -696,7 +696,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  * default power levels, write "r" (reset) to the file to reset them.
  *
  *
- * < For Vega20 >
+ * < For Vega20 and newer ASICs >
  *
  * Reading the file will display:
  *
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C37de4916ddd346b7d21008d8116a4b0a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637278495558075603&amp;sdata=AahmUZ6thnm%2FawZML1Y6pNGl%2BDzWovnYImLtfUaLOrc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
