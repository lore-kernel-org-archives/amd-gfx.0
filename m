Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC25C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 13:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4BA60F58
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 13:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F4BA60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036836E509;
	Wed, 10 Nov 2021 13:53:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A192E6E509
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 13:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdUqPQmKyjSwdNvWZoHXBxmw28LtHiz/uFXBQ/B/do+Pd/lihj3EajB/GN0/d4qMndTWXxI+ZVBCZQC4GIw9GE7rkwyXdGW0G2bJ2wE5FMTsVH7kJRgGZ31qMFb3uHqPz2giIGdKf2T3LmPo7LgTD6vaO+i3b9KCMxQrl0bRxU8mMc45U70tRkT4hrpNDqzq0F0PcrdEtGIjvYbBVv03+CL0MOP9yJ2LzW/EfelUbiwbgdDBnpVB8sz5NhCRWyajiK6864LfxaQ4HlY6/ys75z8d95FJiKYpClrTsSXoowhl6ehE+RsvEbhxYWgSJVP5Bm0/5WhWvNkeRYWF60X2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKF6FQnB1OLWeyF90XJ9vTMWFYp/kgCl7DEFMbCPi2I=;
 b=iqgmLBwrbcJ0dga/nAGu/LdG2xTM9uYD8+Mzo2OTqeshTlq+XVaOq7E5S5bBAXkBWd+6xGsF/5T66CXSs+0s0Lx7SPlMetNV8lxnbbxE+8bkJehye0xhyQ92az+KROeCtAw3wF+uiGZTRtLS+waIxICii96CCFO4qNOR1CsJj4DFkM3eV4uugabdnJ1fCvIrBXNUCd4Er+ZGXxJf2EbwZT4zFrEVeZA8bnMdxq0aQ2/X6bVsadegDrEzHJTX5JyKe94JhDCdwNqnRZIYx8QF4scYpGA9i/JKV9mXm9fw0dSNcSz46ve3vSWvsZL9RbVcvXndYu6P0/2Q0hVnVCBeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKF6FQnB1OLWeyF90XJ9vTMWFYp/kgCl7DEFMbCPi2I=;
 b=SxofzbO3IuWoj8IH9+OjM4p71H4530jtTdrJKHF8UI/2/1m44FLvBZhSl8U7i2b3pm1DJ8kvmGlYYvVowp6P/cIsVSdre/uB+YUOukrmbiNhVi8rarQCi552eZKE+Liini/uzG2b8xHeciNp2Ai+fBWoQNm3WxRTtwgu+/Dun5I=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 13:52:58 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4669.015; Wed, 10 Nov 2021
 13:52:58 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 3/3] drm/amdkfd: convert misc checks to IP version
 checking
Thread-Topic: [PATCH v2 3/3] drm/amdkfd: convert misc checks to IP version
 checking
Thread-Index: AQHX1btCGXsLHUZ/uk+0YXqtpTuk2Kv8yKvq
Date: Wed, 10 Nov 2021 13:52:58 +0000
Message-ID: <BL1PR12MB51446D984B9B76B9C5CC1455F7939@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211109224251.3484398-1-Graham.Sider@amd.com>
 <20211109224251.3484398-3-Graham.Sider@amd.com>
In-Reply-To: <20211109224251.3484398-3-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-10T13:52:57.648Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 74bf5b87-0eb6-8c74-aba1-ff622db27886
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b01382c2-a5e3-42d4-bc23-08d9a451677b
x-ms-traffictypediagnostic: BL1PR12MB5240:
x-microsoft-antispam-prvs: <BL1PR12MB52406655F7F9E6E0D7F64E2CF7939@BL1PR12MB5240.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eq09iYYQqIBrdrkBJn73V/zHNkT4/lQFtw1YI+jjDR+lkbS5+GgyTqMProGI9m7MHCxc5F5UnQa+rcHgb6p3xPtQbsjKM28DX3Mkqsd8MrxLYsbxal+BjFI3KGKF+VCy0dkPVrpZ8cppoZrq2zd+78vlCPIUE73WulY6ftlRWVJmZ3g2q+n4jUPr4zDGDPSHt/xofCR1ZDcgtse6Tb3vaLSHPke0jyCGvPUlXpn8ENhOz8v7kN22JH875SQtjJaJWxb+dHPP41q0VC1LBrIBied0EVryO+bRnSi51CZa4MsNaDVcRAG5jMjXnWgOVX2Yx7PROJNNXOlgjOK/uUa1AvI99i7OvSy1PBctJkUtYMSb+sRkN75vQxSjlsr87fkNQD75Y5QOE3AkE+2lYkHivQQi05bxkIHPE3N65BZALzUyZuS6bgHmjepqfAuNYXIDdAZrkFuT9YHpHSMwNBf1QDIkx0o97i7osXQgvXmJsWQA22qq42bq8pQGcMyRwe2b1y9/n5SjWZ/sgzIZBC9Tiy0ZwANo7Xp4B+d22mMKbkKNSH9nSzMGo8RUykWhXzz1CrDmEbvAPy3sTuQJ5drGBIB7gtr8qgClKxe01CTMCDk21YWpT6XQ31EsTlYpQQXWCm/1TX9E0J2AGW/X9w3p6BCA4MQCpMzk2Tt78/6U9pDX0alF2u/ltB/nsvp0o0NBETeAEfH9nNjDb4CoKuE1jg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(186003)(30864003)(4326008)(66476007)(9686003)(83380400001)(7696005)(26005)(8676002)(8936002)(508600001)(2906002)(66556008)(66446008)(55016002)(53546011)(6506007)(76116006)(66946007)(110136005)(71200400001)(86362001)(5660300002)(316002)(33656002)(19627405001)(38070700005)(52536014)(122000001)(54906003)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5WHOunv5GCUfn3GpnhklHmEtE7y4Kf7rXBErNuG8GGthBt0wIClw3FSPITC8?=
 =?us-ascii?Q?P0lLzq8bejXMhLrtyh8FNuyujvKb9yxaGduzxm787EgofazF1JSyBwQn31R1?=
 =?us-ascii?Q?qHdXZiEbWyhy5wtRKTASS4aN1/uOBwdb+WjCgN5fLwEPxwlJYC8b6vq7Mo+4?=
 =?us-ascii?Q?2EqfBDe75xeCQxmm5SLEUdyRuMoHhfAW8p6R+fRosoGLsRIgrpcxBY6GGqCN?=
 =?us-ascii?Q?fjiM3c8AFrs4ZdcFgYUmlbafL59YwaDUSfRiryLladhdjYjj6jMHg5fhWyo3?=
 =?us-ascii?Q?l4tVfNgn+sna5i0WUtjyIsXHcxYtQZjpPB+k3tPfg02JSqYldjIYwFlujq9u?=
 =?us-ascii?Q?MUyAI0JtM1SPMT16b+GrRbtyoEdjwriOWrcYs6pZ0cmQzS3zC22rly1+tvcD?=
 =?us-ascii?Q?BqsipRgmXtoH6aSlIpdUipFbl/5SSgD9agNKqRHTXlrAbYDGfOToHFo1eTso?=
 =?us-ascii?Q?KXemPl3xE88d4IAyjjsq9fbO7hhsM+7/x3OXWw8KFEC+pKDiBFB7wejfpxsN?=
 =?us-ascii?Q?f7oWtXYHi8m5GU/RAw7fKWh03LsmK28NW9YBga/vHrfKKj1y1FEHcyGtruzb?=
 =?us-ascii?Q?FkkIJAnVE+IIN+WdSwg1n63i225gbAPU0BXwIAs/zEPSnnLTRhuqqACTW2KY?=
 =?us-ascii?Q?QxGrMP5m+3hMiKR/4CgCiZaXel0X4sRucDAgTecg3czrJE17Gaf+qG5JXiZd?=
 =?us-ascii?Q?XdFsB6C95ZpYAn5EvBkMXXicOODMLs7nvaj0jC+KWfQcyM3KQjiF+awEWnz2?=
 =?us-ascii?Q?DCg3G1gwE/jbBJGAFBZi0MjYZw6dQ/HbLj//t3Q+J0WDVmcrdqY1wH/SKYnY?=
 =?us-ascii?Q?XM1CCSaGSFrdMSoINYqsA64gKsWfFLmWg9HWXuU6SvtQRwGrRtYde32JqMN0?=
 =?us-ascii?Q?8rKVgLjuUyJp2oG2QqygynEQnsy7jDoJ48oKvrn2XSqVYFTnfeZ5Pjdv64cW?=
 =?us-ascii?Q?YNtqCFEYUH8kpMZTB3XYrqTnmNw9uSSgIj6WYpQfhX9Phn9JPjy7wzxCNc2k?=
 =?us-ascii?Q?4Rycl4f7IWBlalosszO4ZV6dYBk4NJo/7tiAateqO9y2MbzR0Ui71S4BB3mM?=
 =?us-ascii?Q?OeYbHuudHrKfHEzX6prAFw6bYSIuPT40+MN2afe487zM0ZUJctGODZbCzsTt?=
 =?us-ascii?Q?Ijn7gdKatLiokx1Hon87BorF7mK5Drf9DTLp8+HVYdEsYpy38ovpPtFQ1i3q?=
 =?us-ascii?Q?70M3YPhorU94/6wIdlJnpLyO02GCqW652zeS+s1lYtZQWrgJIgw02W1lHSoZ?=
 =?us-ascii?Q?j+mqSmA/WbEnsRHYjPjTEOT8Epa4G0cHtLPVHaIC1/REeyZS5z0M9YPJGIPW?=
 =?us-ascii?Q?RkK0bF8EwiBOX+xj8Gxo6KjeLnRQKNOjwG8ZCNxKPmiN2JfU0u4AJd9fYYou?=
 =?us-ascii?Q?GugPmBqVMFjQGoyFP58rJFVYLSNoYrJoQYAB6b3DlWh5q/hhhEpTplp6N8nU?=
 =?us-ascii?Q?fgNHtNkW6kUwPiX0FIFPBISQC2t3gAw9iuqnm1nDOrLFClq491Y2qvPUPE56?=
 =?us-ascii?Q?Fq3JVxOgTTMeb/5nKfkQ3TvqJd72XfNgWn1h/r6ofrdEl8WhZmhKJbXd/Z01?=
 =?us-ascii?Q?d8AwxSxVQsEw1BcuUxnsvFGsruU1wRRqZwBtzjm0SpaP1NIikvGVO0yKLXwC?=
 =?us-ascii?Q?MBUSNKGuc9X7p4UgVXVjnoY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51446D984B9B76B9C5CC1455F7939BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01382c2-a5e3-42d4-bc23-08d9a451677b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 13:52:58.3710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMKvLW/v5l9anww/hM8UrcC0dHpVUsjC8C7UiustLeZd8NkznDp7pnKiIJSafSlKE70F/3rnVAPXojNvzI4q5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51446D984B9B76B9C5CC1455F7939BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Graham S=
ider <Graham.Sider@amd.com>
Sent: Tuesday, November 9, 2021 5:42 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish <Hari=
sh.Kasiviswanathan@amd.com>; Sider, Graham <Graham.Sider@amd.com>
Subject: [PATCH v2 3/3] drm/amdkfd: convert misc checks to IP version check=
ing

Switch to IP version checking instead of asic_type on various KFD
version checks.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 27 ++++++++++---------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +--
 .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  6 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  7 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  6 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  4 +--
 10 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 2466a73b8c7d..f70117b00b14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1603,7 +1603,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct fil=
e *filep,
         }
         mutex_unlock(&p->mutex);

-       if (dev->device_info->asic_family =3D=3D CHIP_ALDEBARAN) {
+       if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2)) {
                 err =3D amdgpu_amdkfd_gpuvm_sync_memory(dev->adev,
                                 (struct kgd_mem *) mem, true);
                 if (err) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 19dd472e9b06..b6d887edac85 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1992,7 +1992,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *av=
ail_size,
                 sub_type_hdr->flags |=3D CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
                 sub_type_hdr->io_interface_type =3D CRAT_IOLINK_TYPE_XGMI;
                 sub_type_hdr->num_hops_xgmi =3D 1;
-               if (kdev->adev->asic_type =3D=3D CHIP_ALDEBARAN) {
+               if (KFD_GC_VERSION(kdev) =3D=3D IP_VERSION(9, 4, 2)) {
                         sub_type_hdr->minimum_bandwidth_mbs =3D
                                         amdgpu_amdkfd_get_xgmi_bandwidth_m=
bytes(
                                                         kdev->adev, NULL, =
true);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index ee813bd57c92..594dd28a391f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -848,23 +848,23 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *a=
dev, bool vf)
 static void kfd_cwsr_init(struct kfd_dev *kfd)
 {
         if (cwsr_enable && kfd->device_info->supports_cwsr) {
-               if (kfd->device_info->asic_family < CHIP_VEGA10) {
+               if (KFD_GC_VERSION(kfd) < IP_VERSION(9, 0, 1)) {
                         BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZ=
E);
                         kfd->cwsr_isa =3D cwsr_trap_gfx8_hex;
                         kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx8_hex);
-               } else if (kfd->device_info->asic_family =3D=3D CHIP_ARCTUR=
US) {
+               } else if (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 1)) =
{
                         BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) > PAGE=
_SIZE);
                         kfd->cwsr_isa =3D cwsr_trap_arcturus_hex;
                         kfd->cwsr_isa_size =3D sizeof(cwsr_trap_arcturus_h=
ex);
-               } else if (kfd->device_info->asic_family =3D=3D CHIP_ALDEBA=
RAN) {
+               } else if (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 2)) =
{
                         BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAG=
E_SIZE);
                         kfd->cwsr_isa =3D cwsr_trap_aldebaran_hex;
                         kfd->cwsr_isa_size =3D sizeof(cwsr_trap_aldebaran_=
hex);
-               } else if (kfd->device_info->asic_family < CHIP_NAVI10) {
+               } else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
                         BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZ=
E);
                         kfd->cwsr_isa =3D cwsr_trap_gfx9_hex;
                         kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx9_hex);
-               } else if (kfd->device_info->asic_family < CHIP_SIENNA_CICH=
LID) {
+               } else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 3, 0)) {
                         BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) > PAGE_SIZ=
E);
                         kfd->cwsr_isa =3D cwsr_trap_nv1x_hex;
                         kfd->cwsr_isa_size =3D sizeof(cwsr_trap_nv1x_hex);
@@ -886,14 +886,16 @@ static int kfd_gws_init(struct kfd_dev *kfd)
                 return 0;

         if (hws_gws_support
-               || (kfd->device_info->asic_family =3D=3D CHIP_VEGA10
+               || (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 0, 1)
                         && kfd->mec2_fw_version >=3D 0x81b3)
-               || (kfd->device_info->asic_family >=3D CHIP_VEGA12
-                       && kfd->device_info->asic_family <=3D CHIP_RAVEN
+               || ((KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 2, 1)
+                       || KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 0)
+                       || KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 1, 0)
+                       || KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 2, 2))
                         && kfd->mec2_fw_version >=3D 0x1b3)
-               || (kfd->device_info->asic_family =3D=3D CHIP_ARCTURUS
+               || (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 1)
                         && kfd->mec2_fw_version >=3D 0x30)
-               || (kfd->device_info->asic_family =3D=3D CHIP_ALDEBARAN
+               || (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 2)
                         && kfd->mec2_fw_version >=3D 0x28))
                 ret =3D amdgpu_amdkfd_alloc_gws(kfd->adev,
                                 kfd->adev->gds.gws_size, &kfd->gws);
@@ -962,10 +964,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
          * calculate max size of runlist packet.
          * There can be only 2 packets at once
          */
-       map_process_packet_size =3D
-                       kfd->device_info->asic_family =3D=3D CHIP_ALDEBARAN=
 ?
+       map_process_packet_size =3D KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9=
, 4, 2) ?
                                 sizeof(struct pm4_mes_map_process_aldebara=
n) :
-                                       sizeof(struct pm4_mes_map_process);
+                               sizeof(struct pm4_mes_map_process);
         size +=3D (KFD_MAX_NUM_OF_PROCESSES * map_process_packet_size +
                 max_num_of_queues_per_device * sizeof(struct pm4_mes_map_q=
ueues)
                 + sizeof(struct pm4_mes_runlist)) * 2;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 93d41e0b9b41..c894cbe58a36 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -250,8 +250,7 @@ static int allocate_vmid(struct device_queue_manager *d=
qm,

         program_sh_mem_settings(dqm, qpd);

-       if (dqm->dev->device_info->asic_family >=3D CHIP_VEGA10 &&
-           dqm->dev->cwsr_enabled)
+       if (KFD_IS_SOC15(dqm->dev) && dqm->dev->cwsr_enabled)
                 program_trap_handler_settings(dqm, qpd);

         /* qpd->page_table_base is set earlier when register_process()
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index b5c3d13643f1..f20434d9980e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm=
,
                                 SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
                                         SH_MEM_CONFIG__ALIGNMENT_MODE__SHI=
FT;

-               if (dqm->dev->device_info->asic_family =3D=3D CHIP_ALDEBARA=
N) {
+               if (KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 2)) {
                         /* Aldebaran can safely support different XNACK mo=
des
                          * per process
                          */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c
index 3eea4edee355..afe72dd11325 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -935,8 +935,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 p=
asid,
         /* Workaround on Raven to not kill the process when memory is free=
d
          * before IOMMU is able to finish processing all the excessive PPR=
s
          */
-       if (dev->device_info->asic_family !=3D CHIP_RAVEN &&
-           dev->device_info->asic_family !=3D CHIP_RENOIR) {
+
+       if (KFD_GC_VERSION(dev) !=3D IP_VERSION(9, 1, 0) &&
+           KFD_GC_VERSION(dev) !=3D IP_VERSION(9, 2, 2) &&
+           KFD_GC_VERSION(dev) !=3D IP_VERSION(9, 3, 0)) {
                 mutex_lock(&p->event_mutex);

                 /* Lookup events by type and signal them */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c
index aeade32ec298..d59b73f69260 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -940,7 +940,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
         void *r;

         /* Page migration works on Vega10 or newer */
-       if (kfddev->device_info->asic_family < CHIP_VEGA10)
+       if (!KFD_IS_SOC15(kfddev))
                 return -EINVAL;

         pgmap =3D &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index fafc7b187fad..74c9323f32fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1317,14 +1317,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, =
bool supported)
                  * support the SVM APIs and don't need to be considered
                  * for the XNACK mode selection.
                  */
-               if (dev->device_info->asic_family < CHIP_VEGA10)
+               if (!KFD_IS_SOC15(dev))
                         continue;
                 /* Aldebaran can always support XNACK because it can suppo=
rt
                  * per-process XNACK mode selection. But let the dev->nore=
try
                  * setting still influence the default XNACK mode.
                  */
-               if (supported &&
-                   dev->device_info->asic_family =3D=3D CHIP_ALDEBARAN)
+               if (supported && KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4=
, 2))
                         continue;

                 /* GFXv10 and later GPUs do not support shader preemption
@@ -1332,7 +1331,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bo=
ol supported)
                  * management and memory-manager-related preemptions or
                  * even deadlocks.
                  */
-               if (dev->device_info->asic_family >=3D CHIP_NAVI10)
+               if (KFD_GC_VERSION(dev) > IP_VERSION(10, 1, 1))
                         return false;

                 if (dev->noretry)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 77239b06b236..88360f23eb61 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1051,8 +1051,8 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, s=
truct svm_range *prange,
         if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN)
                 bo_adev =3D amdgpu_ttm_adev(prange->svm_bo->bo->tbo.bdev);

-       switch (adev->asic_type) {
-       case CHIP_ARCTURUS:
+       switch (KFD_GC_VERSION(adev->kfd.dev)) {
+       case IP_VERSION(9, 4, 1):
                 if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {
                         if (bo_adev =3D=3D adev) {
                                 mapping_flags |=3D coherent ?
@@ -1068,7 +1068,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, s=
truct svm_range *prange,
                                 AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
                 }
                 break;
-       case CHIP_ALDEBARAN:
+       case IP_VERSION(9, 4, 2):
                 if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {
                         if (bo_adev =3D=3D adev) {
                                 mapping_flags |=3D coherent ?
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index a4c0c929444a..641e250dc95f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1239,7 +1239,7 @@ static void kfd_set_iolink_non_coherent(struct kfd_to=
pology_device *to_dev,
                  */
                 if (inbound_link->iolink_type =3D=3D CRAT_IOLINK_TYPE_PCIE=
XPRESS ||
                     (inbound_link->iolink_type =3D=3D CRAT_IOLINK_TYPE_XGM=
I &&
-                   to_dev->gpu->device_info->asic_family =3D=3D CHIP_VEGA2=
0)) {
+                   KFD_GC_VERSION(to_dev->gpu) =3D=3D IP_VERSION(9, 4, 0))=
) {
                         outbound_link->flags |=3D CRAT_IOLINK_FLAGS_NON_CO=
HERENT;
                         inbound_link->flags |=3D CRAT_IOLINK_FLAGS_NON_COH=
ERENT;
                 }
@@ -1463,7 +1463,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
                 ((dev->gpu->adev->ras_enabled & BIT(AMDGPU_RAS_BLOCK__UMC)=
) !=3D 0) ?
                 HSA_CAP_MEM_EDCSUPPORTED : 0;

-       if (dev->gpu->adev->asic_type !=3D CHIP_VEGA10)
+       if (KFD_GC_VERSION(dev->gpu) !=3D IP_VERSION(9, 0, 1))
                 dev->node_props.capability |=3D (dev->gpu->adev->ras_enabl=
ed !=3D 0) ?
                         HSA_CAP_RASEVENTNOTIFY : 0;

--
2.25.1


--_000_BL1PR12MB51446D984B9B76B9C5CC1455F7939BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Graham Sider &lt;Graham.Sider=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 9, 2021 5:42 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Kasiviswanathan,=
 Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Sider, Graham &lt;Graham.Si=
der@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 3/3] drm/amdkfd: convert misc checks to IP versio=
n checking</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Switch to IP version checking instead of asic_type=
 on various KFD<br>
version checks.<br>
<br>
Signed-off-by: Graham Sider &lt;Graham.Sider@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 27 ++++++++++---------<br>
&nbsp;.../drm/amd/amdkfd/kfd_device_queue_manager.c |&nbsp; 3 +--<br>
&nbsp;.../amd/amdkfd/kfd_device_queue_manager_v9.c&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_events.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 6 +++--<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_migrate.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 7 +++--<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 4 +--<br>
&nbsp;10 files changed, 31 insertions(+), 30 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 2466a73b8c7d..f70117b00b14 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -1603,7 +1603,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct fil=
e *filep,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mu=
tex);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;device_info-&gt;asic_fami=
ly =3D=3D CHIP_ALDEBARAN) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSION(dev) =3D=3D IP_VER=
SION(9, 4, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D amdgpu_amdkfd_gpuvm_sync_memory(dev-&gt;adev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct kgd_mem *) mem, true);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err) {<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c<br>
index 19dd472e9b06..b6d887edac85 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
@@ -1992,7 +1992,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *av=
ail_size,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;flags |=3D CRAT_IOLINK_FLAGS_BI_DIRE=
CTIONAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;io_interface_type =3D CRAT_IOLINK_TY=
PE_XGMI;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sub_type_hdr-&gt;num_hops_xgmi =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (kdev-&gt;adev-&gt;asic_type =3D=3D CHIP_ALDEBARAN) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (KFD_GC_VERSION(kdev) =3D=3D IP_VERSION(9, 4, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_t=
ype_hdr-&gt;minimum_bandwidth_mbs =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kdev-&gt;adev, NULL, true);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index ee813bd57c92..594dd28a391f 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -848,23 +848,23 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *a=
dev, bool vf)<br>
&nbsp;static void kfd_cwsr_init(struct kfd_dev *kfd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cwsr_enable &amp;&amp;=
 kfd-&gt;device_info-&gt;supports_cwsr) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (kfd-&gt;device_info-&gt;asic_family &lt; CHIP_VEGA10) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (KFD_GC_VERSION(kfd) &lt; IP_VERSION(9, 0, 1)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUILD=
_BUG_ON(sizeof(cwsr_trap_gfx8_hex) &gt; PAGE_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa =3D cwsr_trap_gfx8_hex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa_size =3D sizeof(cwsr_trap_gfx8_hex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (kfd-&gt;device_info-&gt;asic_family =3D=3D CHIP_ARCTU=
RUS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 1)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUILD=
_BUG_ON(sizeof(cwsr_trap_arcturus_hex) &gt; PAGE_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa =3D cwsr_trap_arcturus_hex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa_size =3D sizeof(cwsr_trap_arcturus_hex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (kfd-&gt;device_info-&gt;asic_family =3D=3D CHIP_ALDEB=
ARAN) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUILD=
_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) &gt; PAGE_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa =3D cwsr_trap_aldebaran_hex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa_size =3D sizeof(cwsr_trap_aldebaran_hex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (kfd-&gt;device_info-&gt;asic_family &lt; CHIP_NAVI10)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (KFD_GC_VERSION(kfd) &lt; IP_VERSION(10, 1, 1)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUILD=
_BUG_ON(sizeof(cwsr_trap_gfx9_hex) &gt; PAGE_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa =3D cwsr_trap_gfx9_hex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa_size =3D sizeof(cwsr_trap_gfx9_hex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (kfd-&gt;device_info-&gt;asic_family &lt; CHIP_SIENNA_=
CICHLID) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (KFD_GC_VERSION(kfd) &lt; IP_VERSION(10, 3, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUILD=
_BUG_ON(sizeof(cwsr_trap_nv1x_hex) &gt; PAGE_SIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa =3D cwsr_trap_nv1x_hex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&=
gt;cwsr_isa_size =3D sizeof(cwsr_trap_nv1x_hex);<br>
@@ -886,14 +886,16 @@ static int kfd_gws_init(struct kfd_dev *kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hws_gws_support<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || (kfd-&gt;device_info-&gt;asic_family =3D=3D CHIP_VEGA10<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 0, 1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
&amp; kfd-&gt;mec2_fw_version &gt;=3D 0x81b3)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || (kfd-&gt;device_info-&gt;asic_family &gt;=3D CHIP_VEGA12<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; kfd-&=
gt;device_info-&gt;asic_family &lt;=3D CHIP_RAVEN<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || ((KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 2, 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || KFD_GC_VERSIO=
N(kfd) =3D=3D IP_VERSION(9, 4, 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || KFD_GC_VERSIO=
N(kfd) =3D=3D IP_VERSION(9, 1, 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || KFD_GC_VERSIO=
N(kfd) =3D=3D IP_VERSION(9, 2, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
&amp; kfd-&gt;mec2_fw_version &gt;=3D 0x1b3)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || (kfd-&gt;device_info-&gt;asic_family =3D=3D CHIP_ARCTURUS<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
&amp; kfd-&gt;mec2_fw_version &gt;=3D 0x30)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || (kfd-&gt;device_info-&gt;asic_family =3D=3D CHIP_ALDEBARAN<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; || (KFD_GC_VERSION(kfd) =3D=3D IP_VERSION(9, 4, 2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
&amp; kfd-&gt;mec2_fw_version &gt;=3D 0x28))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_amdkfd_alloc_gws(kfd-&gt;adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;adev-&gt;gds.gws_size, &=
amp;kfd-&gt;gws);<br>
@@ -962,10 +964,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * calculate max size=
 of runlist packet.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * There can be only =
2 packets at once<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; map_process_packet_size =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;device_i=
nfo-&gt;asic_family =3D=3D CHIP_ALDEBARAN ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; map_process_packet_size =3D KFD_GC_VE=
RSION(kfd) =3D=3D IP_VERSION(9, 4, 2) ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct pm4_mes_map_proces=
s_aldebaran) :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sizeof(struct pm4_mes_map_process);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct pm4_mes_map_process);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D (KFD_MAX_NUM_OF_=
PROCESSES * map_process_packet_size +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; max_num_of_queues_per_device * sizeof(struct pm4_mes_=
map_queues)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; + sizeof(struct pm4_mes_runlist)) * 2;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
index 93d41e0b9b41..c894cbe58a36 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
@@ -250,8 +250,7 @@ static int allocate_vmid(struct device_queue_manager *d=
qm,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; program_sh_mem_settings(dq=
m, qpd);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dqm-&gt;dev-&gt;device_info-&gt;a=
sic_family &gt;=3D CHIP_VEGA10 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm-&gt;dev-&=
gt;cwsr_enabled)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_IS_SOC15(dqm-&gt;dev) &amp;&a=
mp; dqm-&gt;dev-&gt;cwsr_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; program_trap_handler_settings(dqm, qpd);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* qpd-&gt;page_table_base=
 is set earlier when register_process()<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c<br>
index b5c3d13643f1..f20434d9980e 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c<br>
@@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager *dqm=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SH_MEM_ALIGNMENT_MODE_UNALIGNED =
&lt;&lt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dqm-&gt;dev-&gt;device_info-&gt;asic_family =3D=3D CHIP_ALDE=
BARAN) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (KFD_GC_VERSION(dqm-&gt;dev) =3D=3D IP_VERSION(9, 4, 2)) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Al=
debaran can safely support different XNACK modes<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * per process<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 */<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_events.c<br>
index 3eea4edee355..afe72dd11325 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c<br>
@@ -935,8 +935,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 p=
asid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaround on Raven to =
not kill the process when memory is freed<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before IOMMU is ab=
le to finish processing all the excessive PPRs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;device_info-&gt;asic_fami=
ly !=3D CHIP_RAVEN &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;devic=
e_info-&gt;asic_family !=3D CHIP_RENOIR) {<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSION(dev) !=3D IP_VERSI=
ON(9, 1, 0) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_VERSIO=
N(dev) !=3D IP_VERSION(9, 2, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_VERSIO=
N(dev) !=3D IP_VERSION(9, 3, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;p-&gt;event_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Lookup events by type and signal them */<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c<br>
index aeade32ec298..d59b73f69260 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
@@ -940,7 +940,7 @@ int svm_migrate_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Page migration works on=
 Vega10 or newer */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfddev-&gt;device_info-&gt;asic_f=
amily &lt; CHIP_VEGA10)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!KFD_IS_SOC15(kfddev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pgmap =3D &amp;kfddev-&gt;=
pgmap;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index fafc7b187fad..74c9323f32fc 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1317,14 +1317,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, =
bool supported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * support the SVM APIs and don't need to be con=
sidered<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * for the XNACK mode selection.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dev-&gt;device_info-&gt;asic_family &lt; CHIP_VEGA10)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!KFD_IS_SOC15(dev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Aldebaran can always support XNACK because it can =
support<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * per-process XNACK mode selection. But let the=
 dev-&gt;noretry<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * setting still influence the default XNACK mod=
e.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (supported &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;device_info-&gt;asic_family =3D=
=3D CHIP_ALDEBARAN)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (supported &amp;&amp; KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9=
, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* GFXv10 and later GPUs do not support shader preemp=
tion<br>
@@ -1332,7 +1331,7 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bo=
ol supported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * management and memory-manager-related preempt=
ions or<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * even deadlocks.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dev-&gt;device_info-&gt;asic_family &gt;=3D CHIP_NAVI10)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (KFD_GC_VERSION(dev) &gt; IP_VERSION(10, 1, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dev-&gt;noretry)<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c<br>
index 77239b06b236..88360f23eb61 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
@@ -1051,8 +1051,8 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, s=
truct svm_range *prange,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (domain =3D=3D SVM_RANG=
E_VRAM_DOMAIN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bo_adev =3D amdgpu_ttm_adev(prange-&gt;svm_bo-&gt;bo-=
&gt;tbo.bdev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (KFD_GC_VERSION(adev-&gt;kfd.d=
ev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (b=
o_adev =3D=3D adev) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags |=3D coherent ?<br=
>
@@ -1068,7 +1068,7 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, s=
truct svm_range *prange,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VM_MTYPE_UC : AMDGPU_VM_M=
TYPE_NC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (b=
o_adev =3D=3D adev) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags |=3D coherent ?<br=
>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c<br>
index a4c0c929444a..641e250dc95f 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
@@ -1239,7 +1239,7 @@ static void kfd_set_iolink_non_coherent(struct kfd_to=
pology_device *to_dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (inbound_link-&gt;iolink_type =3D=3D CRAT_IOLINK_T=
YPE_PCIEXPRESS ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (inbound_link-&gt;iolink_type=
 =3D=3D CRAT_IOLINK_TYPE_XGMI &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to_dev-&gt;gpu-&gt;device_info-&gt;asic_=
family =3D=3D CHIP_VEGA20)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_VERSION(to_dev-&gt;gpu) =3D=3D IP=
_VERSION(9, 4, 0))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; outbo=
und_link-&gt;flags |=3D CRAT_IOLINK_FLAGS_NON_COHERENT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inbou=
nd_link-&gt;flags |=3D CRAT_IOLINK_FLAGS_NON_COHERENT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1463,7 +1463,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((dev-&gt;gpu-&gt;adev-&gt;ras_enabled &amp; BIT(AMDG=
PU_RAS_BLOCK__UMC)) !=3D 0) ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; HSA_CAP_MEM_EDCSUPPORTED : 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;gpu-&gt;adev-&gt;asic_typ=
e !=3D CHIP_VEGA10)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSION(dev-&gt;gpu) !=3D =
IP_VERSION(9, 0, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev-&gt;node_props.capability |=3D (dev-&gt;gpu-&gt;a=
dev-&gt;ras_enabled !=3D 0) ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HSA_C=
AP_RASEVENTNOTIFY : 0;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51446D984B9B76B9C5CC1455F7939BL1PR12MB5144namp_--
