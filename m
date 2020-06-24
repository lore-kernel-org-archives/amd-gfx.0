Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62300C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3493F20781
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pQbt6ZIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3493F20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7986EB92;
	Wed, 24 Jun 2020 14:42:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801F96EB81
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjKKFIxnJXoK1yAMl3gqT/wqsn24n7CdyJdZIUQ6lg0xMOll71/1WOE7Q4L99GKQGRl7ecjdGKYexz4ci3u+0kHZTtZCpc3y0bkuE6Ed5wg775o1TNUVzr39ftrOVNLbRgvycQd4zO3pbJLm/LWV+3EQR1lkMghJhtEyKnZijTiwvsyaTg2hb3DK7ReVUcmYOUYdoNuFTW/Kkmz52/uNSX5HZBw9aZyNlPikaRT/0zDI+ub4uzDnaPLU1OM7J3vL3EaMrIF9KrJVznpALxh/u2o1pOWGaoHejrTn5y3wW2T8bsmdFdNN4RyvEEGWX5i640T5L78Z4yYlM8oYE58Xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT5fFS2CZSBvsdR2eMpx/47fg2OX+S2nbVK75tbhtdc=;
 b=lfji7/d2un+DutlaWuclA9v6ji5V3MAqZ0cFeZd4dF+hGSjIm5WyDgpCl74OeA8HoYRnu+775W+gu3FXM3Sa/WLK2ZEY00TfLGyt39ORXV651UEh+xo8nXhsgfxNtTv8TmjofymOBG/3AlwWLNYB3QoG7r/KNOy6Zrcujwf7DJfxjk4WbBKEa0awPx6erQioVfWATdqbOAzL0x2W40QS6jCKlFDcuvX2aeewQ38gALRIjotL5eOUexj04Ri4+gpJOng6JExoY9kLqHft9SNortJlqmbdp5by3aRVYyMjkOYdErRKWMISmm2EwQlIu96zr5cHEO6nEP/6194XTbaoRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT5fFS2CZSBvsdR2eMpx/47fg2OX+S2nbVK75tbhtdc=;
 b=pQbt6ZIe9t6+DZn4M/EWAIBpsKnaCOmm9Mos8jxBfJY+EgU1iR3AeH/Fos+0hFFV5vFlviJ1dyzhLz4j1OhVmi7fkuwLqBOOpS+NTIuw3ozrZn8A8F8VndYAwNp39zuCPHC1zvIh18hO3QzS9XBZ65wSGNF++IKPd7HzBRl4Aj4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20; Wed, 24 Jun 2020 14:42:29 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 14:42:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: merge atombios init block
Thread-Topic: [PATCH 4/4] drm/amdgpu: merge atombios init block
Thread-Index: AQHWSjWG6VwBvFfDX0S5KFbK0A39c6jn1sog
Date: Wed, 24 Jun 2020 14:42:29 +0000
Message-ID: <DM6PR12MB40755E22FB8B2B8E5A1F661FFC950@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200624144021.4297-1-Wenhui.Sheng@amd.com>
 <20200624144021.4297-4-Wenhui.Sheng@amd.com>
In-Reply-To: <20200624144021.4297-4-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-06-24T14:42:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=67bc26f0-2bc3-46f8-b47d-0000fff483d8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-06-24T14:42:18Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 05c5414f-1396-46fb-96cc-00002867210a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-06-24T14:42:27Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 10138e80-1ae4-491d-98c0-0000dba7d0fc
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6910bdc0-5255-4795-e555-08d8184cd24f
x-ms-traffictypediagnostic: DM5PR12MB1162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB116271C947FBABAB132D582CFC950@DM5PR12MB1162.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMuoDYw37R5UQryMYx2vL4jFKSWmOH6cXd1BI4bXxj+ANCoZyTZgfBpzgb29tDbC1N8yicloWNIFyYPf3xScY8C5oEKA7vl8lSDEi0rU1lwNJtBFRo88HqSHY8JCBhvzq28ba69da3pb3QR15n/yBEFOThlWMzUXKGHx3eOopcXhaxG/la70TW1t8vnaH/W298A6JgHn0jC38LO2PgSiawhJFHB7FiYsHgxSKAPBsZylNerrY5DjmQsl88AE4FtT75Lvb1fezSL8BWBz4gwOE5Ab7V4gISSIKyEINZJZup9XE6VuEpQ9tBRkA9bJKZregVxfc6AkOxBmnxeOu4gcNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(83380400001)(5660300002)(76116006)(66556008)(2906002)(66946007)(66476007)(478600001)(64756008)(66446008)(33656002)(71200400001)(9686003)(55016002)(316002)(186003)(26005)(86362001)(7696005)(110136005)(6506007)(8676002)(53546011)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GIBM+wirC10qFWXZZ8Lwa6Ai9DqCkVOV5UIdhQ0quM1bmhBa+xuZAyxWMkFipTEs07FvlQm0qSqr1dtgcHRwepobpwN6qjv2SPIJACjjB8++cvEhoZZVEvKwlNak7yhn0LtSNH3oCPJfBW4phdb31aUlyTdS3oed7Dh3UBzU8/hmtF5wD/HaM7cdHuIch26oNZ0a5JLnq4dviH1Qy2ulP4iOXZbq6If22IfR9aiM3stDckAoN9tS9mSukvXBTNRgKbQLnMLLgW7HDEJsqHcvXbGtoQSoXRJkOWiTv9KpP/GTAZj7tUhFzTMfdv2AWlKhFXNCZd8JQFHHdo6mzqY3AHcWLxnEsu56P2vTmsi+1eBoLOWLY7udreFgGsRMbRjmDsNOP+2ITgQwtBNzYM9eWFFGB2MtQWzj6bd7Ekiw+5bvP+8+DjqwdiyzdANTEXLTOktq9AnlvmTRPHwU9etBiSGlKRzSoa1k6OCy40nOP0+TxO3jHo3IO2azlWGV/zYH
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6910bdc0-5255-4795-e555-08d8184cd24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 14:42:29.7240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmQdzpBra2zkTMvFvvktfDUHbfbCJUY8tci4VhoBWljA9M7N/IpY12qtQkGElh7fyXNIbYt4p29LeC1jVsk0hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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

[AMD Public Use]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Wednesday, June 24, 2020 22:40
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: merge atombios init block

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

After we move request full access before set ip blocks, we can merge atombios init block of SRIOV and baremetal together.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +---------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 138ace9c28d6..f40bc6b5be82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1723,26 +1723,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_device_enable_virtual_display(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-		/* handle vbios stuff prior full access mode for new handshake */
-		if (adev->virt.req_init_data_ver == 1) {
-			if (!amdgpu_get_bios(adev)) {
-				DRM_ERROR("failed to get vbios\n");
-				return -EINVAL;
-			}
-
-			r = amdgpu_atombios_init(adev);
-			if (r) {
-				dev_err(adev->dev, "amdgpu_atombios_init failed\n");
-				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
-				return r;
-			}
-		}
-
 		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r) {
-			amdgpu_atombios_fini(adev);
+		if (r)
 			return r;
-		}
 	}
 
 	switch (adev->asic_type) {
@@ -1855,10 +1838,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			if (r)
 				return r;
 
-			/* skip vbios handling for new handshake */
-			if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver == 1)
-				continue;
-
 			/* Read BIOS */
 			if (!amdgpu_get_bios(adev))
 				return -EINVAL;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
