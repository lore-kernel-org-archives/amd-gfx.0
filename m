Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4153CC4360C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 11:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7AB239FD
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 11:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7AB239FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1626E0D9;
	Fri,  8 Jan 2021 11:34:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D826E0D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 11:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEXDFdd2u9PztuwewhbVv/FI2EQs+8peqXFmcX1ClKT8Sy/3cAm2m1AEeIE1Uh9RYvE46gKzIO9w6LunR7hGFembDN1MBvAHzh26uRzxBpQLXKcvzoJrXKy9gGk7SLapK27/zvHZeKkGCy4f92mm2N+F3ZIeWPJtvQeJXF7SpxsJ7guEDu92g1tplwqe0ooyyCZ877fEmcMhVlgYx+pxK9RshIHZT0JSyycSa1w8DmFaM31f4zFMZgaZkVeG+3D13QVqNREIYRhijfFTk5dzg7T+Kf0kqYd0x71tdXLfTDwTrTKlWR9ecKk7Xuuh63C69GEAbXxTkKEGMYbI99E5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGkMYMnehLm/o6tIkrXnzomOP7u/ksPM0XczYtnmv8w=;
 b=TynnJmfQIr9aSzMM5B2aiwDOFCDad5f/F9i8FRqC3QUB/J5peAoqkiLsgHGi24oe5jTrMCAwhueDPxrcuRHQrsKaeLmg4MKp95bXk/jUH7CyXVyRpg+wcy1AxbzYN2jrLi+nFDAxGCg5Ia8bUf95CSkIitwKbIcdwM3hvUYzHgITi4n4ebDTCScfcHzN3ZmWK/y6gud9r2bAajEUXnv7mWyny8wuzPhNzS0UmLJiGcRHMeYJcEsZW01632cZYmx0/HESIfD5+RoqMGH0wfYECNlPYSQ+DBVeWcNC5YWvVpGNVneilvyj1qALSoAr4eXl6slLO1BnaCX3h+6PPVjMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGkMYMnehLm/o6tIkrXnzomOP7u/ksPM0XczYtnmv8w=;
 b=jgAvG4adwb1CSF+m36LoqdZ7z1nZyGSkGLbP2CJBnkLJ9FJ2k24xs012DoC9kyru/+h4Y0G8iNtdyPbgIS1dB9j3IzY58VSMQ7l2Si6whRn/B4Fh8UnTO4QSB3/rApHGmhpOhF/WKPbY9ajqTyrWOrBhfi9/QPDbG2vfhHv1pxw=
Received: from CY4PR12MB1573.namprd12.prod.outlook.com (2603:10b6:910:d::23)
 by CY4PR12MB1222.namprd12.prod.outlook.com (2603:10b6:903:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 11:34:37 +0000
Received: from CY4PR12MB1573.namprd12.prod.outlook.com
 ([fe80::b1e2:6f8b:b4e9:6ef0]) by CY4PR12MB1573.namprd12.prod.outlook.com
 ([fe80::b1e2:6f8b:b4e9:6ef0%9]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 11:34:37 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix issue when 2 ring job timeout
Thread-Topic: [PATCH] drm/amdgpu: fix issue when 2 ring job timeout
Thread-Index: AQHW5Cl9cazjK7DmB0apGn+wE1/EF6odltAA
Date: Fri, 8 Jan 2021 11:34:36 +0000
Message-ID: <CY4PR12MB1573ED17C8D9078A8F1A4D65E1AE0@CY4PR12MB1573.namprd12.prod.outlook.com>
References: <20210106124258.31129-1-horace.chen@amd.com>
In-Reply-To: <20210106124258.31129-1-horace.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-08T11:34:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fc04de37-7944-44aa-a785-87f1fade6dc2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 564e0e97-8155-4bff-db4f-08d8b3c96127
x-ms-traffictypediagnostic: CY4PR12MB1222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1222C4B6FE9C5E6E7C4456A0E1AE0@CY4PR12MB1222.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R4egxKbqqE1t60XDs2QzW6r9TOC0A+kgu0polRDDdit+R3Mc/wTMYscjU6u4zCG4HiFh0tCft5rgWu2ksHetvMT/WI8jMKjslcG6dxbrIXrfECUafgOOIhJ+U5jaPa5RY14vh/qX+KQVcf2V0ijxHeUdA2U1GfvA62+TKszAe6xniNgNqCh2fc/FeSyZ1Z+EEnzp1VPEDVHXuoatDwdku4PI/W3EQYi+lnTXU5dOW2qg2aVGHbeQ7d/NxUDpDPdM+yiusjsqCyepXRb5sJnuuoXIjzWrnFMtQIBgA3h7gsA/Zrl42jaJb3j17gbf0UWNqkqDSedZrZUxcuQxh1/+mGCv6YRgWDgMsubzekcuGiPFieRXEAeoaZVQ4l5ypwC0TaeKs4LCKvSCBBmugJ5gLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1573.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(2906002)(64756008)(66446008)(7696005)(8676002)(8936002)(54906003)(9686003)(6506007)(26005)(86362001)(33656002)(52536014)(76116006)(66476007)(66946007)(53546011)(5660300002)(186003)(4326008)(478600001)(55016002)(71200400001)(110136005)(83380400001)(316002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zhXLnkCWEpM7w94l/HCg/z2Zfzq2uYFDiDWwDfH4s0QJxJieWDU30pomVjKX?=
 =?us-ascii?Q?kynsqD5cprQr5J77HV5L59VA6Bls9hBFxy3fEUbQEx0kJFKn1ogirL6oH7OO?=
 =?us-ascii?Q?PD49H1VFUXWfKrHVOh6dzNx790SoyI7uuQNN4kwvrkf/LIkElWLBHUcpP56i?=
 =?us-ascii?Q?w+ztsFkxyE9mnh00sZvTgSZYLTFTtrmDkkaKzqcZoR4u6/12PPw0q52Gq2aO?=
 =?us-ascii?Q?oIkmA5GJQxSUWMT9hLDn+sh4TSDO86I4ixvtUBKT6xZaSCpicZ7Akxf6cmii?=
 =?us-ascii?Q?wvaTZqNGnZPLWzwm1BN+DiUc0OBC/UHL1Mww1z+yGVr5fDneG2VRVwUkQ47h?=
 =?us-ascii?Q?XX5EMU8qbFLg7fGLGuEmdejnpE9gOfGPwTL+F2Zxl9/W/tV8K0vlHK+88PG5?=
 =?us-ascii?Q?tGi++o4EuLMtSDwtbYHZQBZqcZvJoG6wME0xjl3zFqiXGwfn7FgTlZu8odah?=
 =?us-ascii?Q?w9oywon87wWnemIve1BkbJDlLY3zdOzMR6G3cMO7TDIx4K/6Ur3Z8+S///3k?=
 =?us-ascii?Q?YlXsAt1S+VqXIjgUq91DwG/c6PlK3exq93K2i+k5pK5SpDnvOF7aP+OX1Qxa?=
 =?us-ascii?Q?jcqvQVY+SL0r4RJfkd+WAtr7UvUibuInTChbng36hDO8Kl+ezfcC8zyzYGZ6?=
 =?us-ascii?Q?3Wn0LiniLz9XwKhxVVItuFbdDiSN2WHqe0gPsjtaYSYj8nsLrkuubAU/KNtr?=
 =?us-ascii?Q?y52TfFSRbuVNHMQ5zTdR3QGCpv+CbacUPWxJw4NFoSOgb4SmCIKMn++hditI?=
 =?us-ascii?Q?USMT66EexqirE9PlOteRKe20o580hhS/eS6/g3zKoZ2a6pJF85AiadpsR9/v?=
 =?us-ascii?Q?Cu0vU5/Q0Pzc1keJBm2fCoUDU7J0NN0QN+v9dWdHRBHWS8ni1ZbdwVQhbxc8?=
 =?us-ascii?Q?+hxsGDeYtfe4ik2ks9L4GToxKlGZd7leNnj79dTckKCWKn8qZ5gKVhVZscaz?=
 =?us-ascii?Q?Qk0fg+JxhflHSllEpLxbmrDvqjJFKNNrVqNbZJB3lu4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1573.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564e0e97-8155-4bff-db4f-08d8b3c96127
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 11:34:37.0316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0tWCo8Qcks+QUKD8o1uijzpaykVGHjYCh3DZpdiQFoMVKEm4yy/sfD+6KjCOwQK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1222
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Christian,

Can you help review this change?

This issue happens when 2 jobs on 2 schedulers time out at the same time. Which will lead 2 threads to enter amdgpu_device_gpu_recover() at the same time. The problem is that if device is not an XGMI node, the adev->gmc.xgmi.head will be added to device_list which is a stack variable. 
So the first thread will get the device in to its device list and start to iterate, meanwhile the second thread may rob the device away from the first thread and add to its own device list. This will cause the first thread get in to a bad state in its iteration.

The solution is to lock the device earily, before we add device to the local device list.

Thanks & Regards,
Horace.

-----Original Message-----
From: Horace Chen <horace.chen@amd.com> 
Sent: Wednesday, January 6, 2021 8:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>
Subject: [PATCH] drm/amdgpu: fix issue when 2 ring job timeout

Fix a racing issue when 2 rings job timeout simultaneously.

If 2 rings timed out at the same time, the
amdgpu_device_gpu_recover will be reentered. Then the
adev->gmc.xgmi.head will be grabbed by 2 local linked list,
which may cause wild pointer issue in iterating.

lock the device earily to prevent the node be added to 2
different lists.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 ++++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9a3cb98d03be..233dae27c8eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4620,23 +4620,34 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		if (!hive)
 			return -ENODEV;
+
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+			if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
+				dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
+						job ? job->base.id : -1);
+				r = 0;
+				goto skip_recovery;
+			}
+		}
+
 		if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
 			list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
 		device_list_handle = &hive->device_list;
 	} else {
+		/* if current dev is already in reset, skip adding list to prevent race issue */
+		if (!amdgpu_device_lock_adev(adev, hive)) {
+			dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
+					job ? job->base.id : -1);
+			r = 0;
+			goto skip_recovery;
+		}
+
 		list_add_tail(&adev->gmc.xgmi.head, &device_list);
 		device_list_handle = &device_list;
 	}
 
 	/* block all schedulers and reset given job's ring */
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-		if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
-			dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
-				  job ? job->base.id : -1);
-			r = 0;
-			goto skip_recovery;
-		}
-
 		/*
 		 * Try to put the audio codec into suspend state
 		 * before gpu reset started.
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
