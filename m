Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3F0C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 08:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE8920885
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 08:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NPwLQLSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE8920885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B716EC32;
	Fri, 19 Jun 2020 08:29:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88936EC30
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 08:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkEvmXyz7R7z3KPji4sXsQnXA0SjwCdPGyx7zyNLk01Pk1198biMBC64T8QyeRfaoaLhAVQ0JjbeWatx8PRiDo451gs6RDqCOV6opgcwpR53s/Z9hSBz7FUtFOAgBuMrwlfEpfgn8rW8dzprq0smxobw9g+vbvs2+PgORDIC5dxcFs7JOORZQE/IZeY4U5ymkjLkd3M41S6ZID6YgHfcSx5KdNnLE4hhdKnDZ1uSZuh784p7KBCxWjNU/Nuhjuw84khpYwT7/XGR6jtgtxqFTk6fOBgvzrJlfdSrrtXJJx6xFlxI01unkIu50OUTMl5WBBEZpSwpN/12Nied+61NOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe+g2I1QqH7zg972d0MUHNvOrJh9t8qJXdrK6GjTR60=;
 b=Qgzo09CRaeAAqUCHEiRxlDByYCdYmlxcCBnd71fNld1MszqYLCW3iIWuCRId0jPVz5szh1i5EvDrBNaYMmJSAsGiDDyBJpxYkA9tdGqyQ+aceFh/AXZr4YLh3T1z74MVWdi8KscO5ChP3HS5rSqFHO2Ai/YAY6xnPYvRA4AMxPxtqfOVGmUsL+y+Sz+mN9vRGOz0ZZpWLG4/zZpfr+BVxjhWISyD6Abuk3gI/M/BO371FaO1Gwi+R3vVG+ej0ntUSpGGYdSKymT46Im7MjItFnby6WtYEhQQvczBCyZfm9uekjePTM28L+9otIxUryXSeGfgzmNf6Tdf0QdeODP6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe+g2I1QqH7zg972d0MUHNvOrJh9t8qJXdrK6GjTR60=;
 b=NPwLQLSx/IcPd2CKAWO06rpvZLdByQCuHnTX2j1qd+3eyXaebEzqc3kQR1gFFJo85DgxKAE3yeZGxod5WcFAeo1HwAax3oIIEiUMycw526T5qyGCFeWlSu6I16cHXU6Zxt18RfctgSwHvakGXK0y/O9oGxCWO1nGCQEF1mxtsOA=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Fri, 19 Jun 2020 08:29:34 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 08:29:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Topic: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0
Thread-Index: AQHWRUWxvOeWHrzTwEmA5HSarh+Ps6jfnJXw
Date: Fri, 19 Jun 2020 08:29:34 +0000
Message-ID: <DM6PR12MB40750A469A68693BEC7B6F85FC980@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200618075307.3721-1-Wenhui.Sheng@amd.com>
 <20200618075307.3721-2-Wenhui.Sheng@amd.com>
In-Reply-To: <20200618075307.3721-2-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-19T08:29:30Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=75b2b37c-3ca0-4dd1-9785-00007f75f505;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-19T08:29:19Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3ac9e6a9-54fe-4ce9-ad64-0000827cb545
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-19T08:29:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b3bfe477-230e-4e7f-a95d-000084d4b887
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 070a5597-d437-4854-6de1-08d8142ae58d
x-ms-traffictypediagnostic: DM6PR12MB4124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4124736061D56A1DA40E0386FC980@DM6PR12MB4124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xc47RbN4vRMbBzBxwkWZwF3UbNukm0+7BJ0Z8NaWcg6fT8JUr7Df9950JX3JUNp+Si5dNK9fpvbkzm2tCs0Y2AjrFcHA9ts40MSDs+X7efe4z+QV9Mj+xVEwotM6kVR2XDIWyMYhsTlvfx63dosZseU6dY1mHPTCGuY14krfNRLQbazV/JQrEcWPvrdaZ8RQ+fZzd3oN87It0F22mNq/d6M5TAIBn1/+NYAs/RSPk+i8pey1AfdSLbFn3K1WUKUvgjncMBsQOU5QesIzIvKQrqRl7KKFP/lW0mAV9OGr2IhZgsvTogTfEXVv+s2Ibwe/qCVAePNGPm4Nw62DZKQMarFH2B8ODBmJ0LiLLnqaBFw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(76116006)(186003)(66946007)(66476007)(66556008)(64756008)(66446008)(7696005)(26005)(33656002)(83380400001)(86362001)(316002)(53546011)(6506007)(45080400002)(8936002)(478600001)(71200400001)(52536014)(8676002)(110136005)(5660300002)(2906002)(4326008)(55016002)(9686003)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 8wXC9nvGBJzpSwPb/ELz6iQx2XTv40y13Q/3zECaAlah9Xbjzsu3ygI2/jKE8Lub9WwAkUTKr/7Q8XToNkgmKnW252u79gP4sluX/Ffg5jshzAxiw/l2RctJFej1FDlRMtkcvPzbZIZcv6FD5xAIHbQqx+WaLXnIkEEc611fSABrMFjGJeL448jQDjRZTRNGJ8JLmdFXyejQw4HyPnMl4MjJcSpNPviGYSKcBN2YjFOJqweVqC9tNA820ITf5jZ9F+0R7A/A61ev/GVKHfcBiFJ7QTQ4O4kvS6F2H+FBxkn11v5VN5aE5WDtWDFAyfw0citeLqmuHamkhAGkDioTB/wB/bNFlNlkMSNw4g6atpC1SjTjhTm3BSJfO1qkLgWjKJG33W8e6COwc6XQtmBsVeBexvrdqbqDo0E6l/vm7GlPn1XrpCq24L16o4Lv0S1rApHLdj3jFyNDwtWSsgaxRl4GcA1fYQJ3L5AHNMHoWJ93WI3qXOjXOT5wNqwhWBm7
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070a5597-d437-4854-6de1-08d8142ae58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 08:29:34.4611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bj4YQRbAesa/qpSyMlkyVpl4k3mAv+skcFASerg5tRhpLKoOtMijo+QEmRKwSNVqPRfey4Rfb4havU1VtHWBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
Cc: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is:

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wenhui Sheng
Sent: Thursday, June 18, 2020 15:53
To: amd-gfx@lists.freedesktop.org
Cc: Sheng, Wenhui <Wenhui.Sheng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add fw release for sdma v5_0

sdma v5_0 fw isn't released when module exit

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 58d2a80af450..6751ad69ed90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1299,8 +1299,12 @@ static int sdma_v5_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++)
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (adev->sdma.instance[i].fw != NULL)
+			release_firmware(adev->sdma.instance[i].fw);
+
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
+	}
 
 	return 0;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7Cd0b8b72e0be443a7343d08d8135cb093%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637280636689938431&amp;sdata=2g%2BOLo5Hg6gxO2pF%2B2uDnshodSAmLaSh9RZQsKrnFUI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
