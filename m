Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB5FC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D70C61055
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 06:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D70C61055
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C513D6EC6E;
	Thu,  1 Apr 2021 06:03:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7542E6EC6E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 06:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U99DUnpns4xuYfJnaNzrVIsz86UTC9KvKGwUNYiFLoLKg7XY9a5Ksyu43hdKJvnJGMeO5AKH3hWXn650hekeQRjW3dvAd7mVqLayxQ/T7tNWkl/mufRcLSxTBIgI14OWS/9X/PdhYVn6BtSKyJmox+B0omFjHr63uTTS3TMykm8vjhKKEhS6MwBv/HvSmftog1/wNnN+9heoTRq3UputqtbsogUOCOtAgTKmTBk9orKR9b6mBzjzaP2In6AYQSUe6zr6ZDTKG9z5E04o2jAs8PUuAX2RQvg83mxOtXZnirYcHRj77Hkxv6sXtR4d9RdlGmdezjX5+3fV2CupPTwBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc74nnIoyvI7OtB+Vyze5lD+vCa6mnVBdnHqTbyxkI4=;
 b=PLZxzW00NQZDMwED+PqI+ki74D3HyqxKAyzbt84ClgJDh4LwlOnjM4gRBdrft7Nv5yKTbJN3lqKM64Rg4BAHLQ8tXSA/Bhn4iMa3NU2+epUOhONFC9SQ8qkHmwcPptbc6TAM8xLc36OnDu/tixpUh4bjvH1NWBaDEOlkjCM1bVE2mL6MfUXqGW1x3er3II30/t3UFo+ZPyhWHj/nLKYU0Su1erUIwX61qxZf9GkAZxL2q6hSEmy83I8zUfdoP+QAq5SjEVtV6+bYPCmnlE3r7Tp1Fp7zGrqEUSaF7fWRaxF+C+X0WjNlSj0xNq0jUYhgrw7Qgp8VJjOOOBX86J92iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zc74nnIoyvI7OtB+Vyze5lD+vCa6mnVBdnHqTbyxkI4=;
 b=GGekQwj8OQqmPLyX9ecP6xYsdghxkMJPGtygBgLmnlcodOQyCdOBRAxaWSQyc7MFtmoanHQzZ+aEDRgUzAOmXGtGSc5uqpxycSwg0+uCauH123IwMWC3O894yK/86QsLKLFHVO4/XjXY0d3S9o95JuiSvfir3ffiP/QRTb+6krg=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 06:03:45 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 06:03:45 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Topic: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
Thread-Index: AQHXJUkHjQ3O8F/sT065IKansoIo16qdzltggAFgkAA=
Date: Thu, 1 Apr 2021 06:03:44 +0000
Message-ID: <BY5PR12MB411574146B6118CFFDA0FCEE8F7B9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330094235.69090-1-Emily.Deng@amd.com>
 <BY5PR12MB4115E71D30C636258455A81B8F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4115E71D30C636258455A81B8F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=266b6fb1-4d85-4d1e-ba21-b0d02abb0e1d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T09:01:40Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab840044-e695-4fef-809a-08d8f4d3e8e7
x-ms-traffictypediagnostic: BY5PR12MB4001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40012FE0A6BB4792C030F52F8F7B9@BY5PR12MB4001.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oWvkS1WMWV4RO42/uhOviY+8bXUvDxsrXT/iTV6pCBos3FQjytToieBBgNsk5PrPSy4J007m2fA/aVQNXyrqzPd2BlR0MGNERwKGP+nC0po/RySWQr8OIAnyrEf0wqhO4R5P9XPZulzkVf8nAc0LqPx9b1DDTP17d3uKSS8tWfmyx5yu9LkGo5cbyfv4omlPHeMZ12rP6nra2wIPWWa3Ff7X4RSEAWdUBhf4komN8nuw8zf0FO9TP/nS3+6jkWtwjbJ99tusWWJZjOX1xTwTy4rG1HczKYGASVuh6vQjBKGAZmcjUYCfKNPLNhZTB/CdE5zCb+qC0jWj9H5q5KMQL6aztJLO07mh9M44LWNU3pL3RxFqwTfR6dKetFvt43ShH/rM3VieFJ1pPfJt5aM2dYYHMxPOi/JaZCBDpYOcM1N3UTPASlqdIX4Jm3sUy/N7j6CJh3Gw2vJtJehcnLtldEq4oOukh3oRdPQVNEWBwUUuXqX6BTivIhLRpEBFXpGjBMJvWmhKtVANU1WSLZfzEkXRt8uhNXFmCF1Dw/pfFhtVynHFdT0XIcO5RVkaz9vjtNCl4cd1LKTHCImj2FSu8HI5M5G2k3ZgsJsWoBkc7JKBurMNgHySCtB51cJtqhEYuxZzwNlyWALlfKLADoESxSBvI9LUEeLRTjLynd7bLys=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39850400004)(376002)(346002)(52536014)(71200400001)(6862004)(186003)(33656002)(64756008)(66476007)(26005)(66556008)(316002)(478600001)(66446008)(4326008)(76116006)(6636002)(5660300002)(66946007)(9686003)(6506007)(8936002)(55016002)(86362001)(83380400001)(7696005)(8676002)(38100700001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CsmDC0LQ3d7CWn191bwyg+PrKsNS5N/5DmGerMtmHcg11bhvqk5f/5oPqo0w?=
 =?us-ascii?Q?AuAzJnH5zjRIkOSEwdHwuTnzVI9JOgu8ovxH+X5JPlIA6R79oZsdDsvSNRiE?=
 =?us-ascii?Q?qGhwW9bs9p6PMBV0va2DC8xQDdL8HaKE/U+f2hQpE09XMNuqLcMRtxAE+QNb?=
 =?us-ascii?Q?WCRUhdIHCMjHr1D4+rFPhDio3+jDpHi/6psYjhDU6TSYgzANwXwavLGYw0cS?=
 =?us-ascii?Q?ddObtSy0Fz9rNyAsIwTwDAPUE2fDiuICFhWW16FZYFVnUGgSams05X6mRvZk?=
 =?us-ascii?Q?pAv2Hg8VsBDsEQ5aM6oo+no4wpxcbm9ry5MvvHmy7NIJD0cfxNiXHJr5VLmT?=
 =?us-ascii?Q?f3AeUnmJ7KXy+fDbBR6ZIauYZqHMJG4i7SPX74JFL07QzIta9DEOaOTeB0s1?=
 =?us-ascii?Q?Kg7L4+2McyJkSetCXCoKc51AY48RlMHrrtC941b1yrFfYq8JmoMVGns36+dp?=
 =?us-ascii?Q?2Lf++twr2Q4DxV6QNgoQXA8iiyU3hJ1qN68E2wRLE+aYi4DigK5C0MmlCJQ/?=
 =?us-ascii?Q?WXPCc/tjQmLpKSeIWh836PyEzhwRgoexxTw293DU3rf+wx/QfDgLjvjafK/D?=
 =?us-ascii?Q?N7wH1WcgkkI3Tx77/j8Yj8rBCgqGSy/nDecwIALRumP050RYS/WJny2sqVDZ?=
 =?us-ascii?Q?Z/L/qgCH7jr5SkFaI+zngGKwL0dvSSDOHd+sCozlZrksaBayn6VoTrNR6NXH?=
 =?us-ascii?Q?UvQ5D3ZSwZCVx/FkUbR+QAsJmWguPOpbz7nzV+0TwlJNQtwlrZFZzOaaXOdw?=
 =?us-ascii?Q?UYCQeOBgXr69Ead2MvlbjWLx+FgxGbdBqTXZJ6ebcmGxdg9N6S7OwWQjHFbu?=
 =?us-ascii?Q?oeyMqP5qahoyGNCEh6KDn7SjynAl+QOC5Q2PEXZOnMZiZrt1jl7pY5jRF+e5?=
 =?us-ascii?Q?EJV3mI5tNSfMwEtfhd/hRbzTNHg3rBLaQqY+9o1f851Y8hO4Q6TCW2K1osNm?=
 =?us-ascii?Q?5ODXZ8CF2LE+DRUdtivYwKE6CZxJBM4MxqrI2nrkwLfLrHE0UZJPzKO7SvvT?=
 =?us-ascii?Q?K6RUHiMjyG4X8klsCaKRvjiFQOO9kOQe9/hfav1XOpdAH8odsf/lTB6jKDiz?=
 =?us-ascii?Q?meqbLQsIEOnwl0Qy2HHLQ70P7PX94RevkOBXmULF02w00iGRTWgdYVI8mxYW?=
 =?us-ascii?Q?1a3fw0AXG7t6sBzXQp7wxvnBHjM/xzzCV2LT+BUef8VXqjkoQLzSpxmMjpOX?=
 =?us-ascii?Q?/XeksIqvYxCTF/Xft4fNIa5lR6lRoriIGZsBiui+rZ5VOzbs0GhzK12u6LsU?=
 =?us-ascii?Q?412o9Kq34+sayLDQ0UOvqhhC+B3tSekL4/ET9duznURacp8dUsIGFbiXWaek?=
 =?us-ascii?Q?jfMPNnpsg5oM4lsrQc0oBpZl?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab840044-e695-4fef-809a-08d8f4d3e8e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 06:03:45.4055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVvgAsr9UJ2/Pq0gO2sPfQO06Y5mcJnlmuP8RQOEkMPFKPcQiJzf3WfWpxSkEVMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Monk,
     Could you help to review this patch?

Best wishes
Emily Deng

>-----Original Message-----
>From: Deng, Emily <Emily.Deng@amd.com>
>Sent: Wednesday, March 31, 2021 5:02 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Subject: RE: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping ......
>
>>-----Original Message-----
>>From: Emily Deng <Emily.Deng@amd.com>
>>Sent: Tuesday, March 30, 2021 5:43 PM
>>To: amd-gfx@lists.freedesktop.org
>>Cc: Deng, Emily <Emily.Deng@amd.com>
>>Subject: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
>>
>>From: "Emily.Deng" <Emily.Deng@amd.com>
>>
>>For vf assigned to guest VM, after FLR, the msix table will be reset.
>>As the flr is done on host driver. The qemu and vfio driver don't know
>>this, and the msix is still enable from qemu and vfio driver side.
>>So if want to  re-setup the msix table, first need to disable and
>>re-enable the msix from guest VM side or the qemu will do nothing as it
>>thought the msix is already enabled.
>>
>>v2:
>>Change name with amdgpu_irq prefix, remove #ifdef.
>>
>>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>>---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>>
>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>index 03412543427a..3045f52e613d 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>@@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device
>>*adev)
>> return true;
>> }
>>
>>+static void amdgpu_irq_restore_msix(struct amdgpu_device *adev) {
>>+u16 ctrl;
>>+
>>+pci_read_config_word(adev->pdev, adev->pdev->msix_cap +
>>PCI_MSIX_FLAGS, &ctrl);
>>+ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>>+pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>>PCI_MSIX_FLAGS, ctrl);
>>+ctrl |= PCI_MSIX_FLAGS_ENABLE;
>>+pci_write_config_word(adev->pdev, adev->pdev->msix_cap +
>>+PCI_MSIX_FLAGS, ctrl); }
>>+
>> /**
>>  * amdgpu_irq_init - initialize interrupt handling
>>  *
>>@@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct
>>amdgpu_device *adev)  {
>> int i, j, k;
>>
>>+if (amdgpu_sriov_vf(adev))
>>+amdgpu_irq_restore_msix(adev);
>>+
>> for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {  if
>>(!adev->irq.client[i].sources)  continue;
>>--
>>2.25.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
