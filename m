Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872B4C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 03:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1DB208B3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 03:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1DB208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80EC6E5CA;
	Fri,  8 Jan 2021 03:07:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86246E5C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 03:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnhXOE+frAeGs9wQd7NyF6aGIcMEWIuUZTW6PReVOmn+9xRlUs2yjeX0Qrbg2o3dXRI33gS0RQIh1u7PoHDPQQ6/6r5/aXHIKfivNrnNYwaxwgmvKxi3S2oFCSZlzSAXGckd8hm03BG7HaI9ZIiC0vz2PhrggHaRY31mkZzfYkFY9wUdIZFIK+vao3THCSNs0SGc0O4EhcUKLVE9D4X+h8Lu7XM18CFoocE2nOZvkIGwh1qI/Muzhwg3kzymTSr8CR9tFaf8kjD5F+iXi2VC08yJtBWsDwyWIXf08nPZ3UT6S0PAOCnccDQOwm/uGKLCa2S7n/4Q7++lsn/Bs2iA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOyOrJ8K9RfZhgslINMVUgjrE5P6+ajpo9ijkAoZiSU=;
 b=M+dQawP6zMUpxho+wxHvImZxgj9CVvLTOjYoMEppjztubE1aRnpdPHrGPBW0DfhXsmvc9GaMGkzZ4ClEIwjAah20w/9gh+nm+zvuMBseeGeZ8e63t7W6N3MzKPs3B8+NtFP4b24tm6KVTFlhSm4+5YJeibS+vJf+vFZb2L69y+8u/f4Me2LKqTs/i40wC43jzOKuDK65GQDhyrl3PoPXM1GvPWVuFIivHULMvRf1PXFsnwPxTEhPMZ6tLIkJSSZGwefJ4BUA/738qNRtGreMTKIb+RX5lSeJxytNTtvVQjCbO+nsl0o3dBUahI6zIIWJGa/eWPFg+yQeRwxqYoRZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOyOrJ8K9RfZhgslINMVUgjrE5P6+ajpo9ijkAoZiSU=;
 b=DHwg8Nultn0c9XKUTvnmpnXimp8C1WWz/Bu7LxHe1w7RXbC6TbN0QPftm4igh3Yi+Uk7HmCPujOBtO1fxmRamM6CEnjmXTLJ1IhlpzUiQ5Rp5T/CIt2U8TencVaiFJ4S4R+6fZqRRWd0sKTN8O1s/Rvql8kxGSZBqvbm3aGKj+Q=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 03:07:02 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::f07a:7ec6:defc:acf2]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::f07a:7ec6:defc:acf2%7]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 03:07:02 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
Subject: RE: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset
Thread-Topic: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset
Thread-Index: AQHW5OJwvaTYLCLu60ysNYjjeG68hqodDK5A
Date: Fri, 8 Jan 2021 03:07:02 +0000
Message-ID: <DM5PR1201MB0204502D7A2095C9AF1795C0BBAE0@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210107104656.24107-1-Jack.Zhang1@amd.com>
In-Reply-To: <20210107104656.24107-1-Jack.Zhang1@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b029bbc9-7896-49b7-0a5b-08d8b38278a6
x-ms-traffictypediagnostic: DM5PR1201MB2489:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB248969422BD29338CFBA9A81BBAE0@DM5PR1201MB2489.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sZNbMxV9hUoiwwbPm3JPYDTEhsYnUH5UmNyB/TH14PY0kZtdbCVc3f1Y8wIyc07vK6O5ApcMKFgHGek88Z5Sh0nuCRBYIxHwgs7bi70G7QY0AfG7axwSVRRzIIX8cl5/WiYcO4LpMsuw8AAERitSfD3ZxchDvhMtccPRl16rpS9ADzigM/GDT876UinL8ltC0/0U39TDnb3G2sn01FWQ+dzYSztFkD371wQ1u2gKrgTe0gQD5NY7/hIPZLfoXYvaWn3k+mrfb8HHc4HTH/ZQN/XkSpwKd7QbQ/ABHtAUNWC2a1B20OonyiwfWBcv7Epg63f/ueEHvhYFov9QNrWaHrOYoKEKYeXYDDjz8Flk3jr49p4yE3oQgi8Oa/oaPCDu6oWZNterUV8zQba2Dtvscw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(478600001)(316002)(2906002)(66946007)(83380400001)(8936002)(6636002)(110136005)(5660300002)(9686003)(55016002)(52536014)(71200400001)(66446008)(66476007)(186003)(76116006)(86362001)(66556008)(6506007)(33656002)(64756008)(53546011)(8676002)(26005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?RXRoQUpGMitScDh0YS9Ba3k5TldVY2VESElyMnZWQzUxNDBiZU42S0kzRUNW?=
 =?utf-8?B?VXlFQUVDQ2h2RHFFMTJ3MC9QVk1MS2RmVlU5TC96K0pkQmpIcjlXSkt0ZUtl?=
 =?utf-8?B?bUQxb0h5ZDJxYUZidGRrNmZYRHdQNmVMdkFxZnBZeHBIRkcwY2JBUFRJYXlB?=
 =?utf-8?B?dlZHS1dEQWdxTEE5QjkwSkFpQmpDS3ZXWkYxR1ZmM1FrVWlUWnp4U1pScmRC?=
 =?utf-8?B?ZEVCakJ5azAwWnk1blpxcWF1SnlSejRaenVjUlFPUXJyd0hzTWUzSWJqSFBS?=
 =?utf-8?B?OXVKbkJaRnlKMnZoV1gyMmJkazM1TGdEZ1J6bkhIWHFCSFFMT2dYNnlyRGZV?=
 =?utf-8?B?T3hRVTcrNzg5ZmJjeDQxOVlPOGVWRDB4MVBVcVlvN01WQnoxN0h4NG5UWExa?=
 =?utf-8?B?M3djVkhjaE9FZ2xxUXNodW9pdGkyVjYwTlhzY2JkL01RVE0zUWFzSE9VNlQ4?=
 =?utf-8?B?Q2hNejdvaXp4ekQ0cWVSaWxRNC8yaWEyaktOejZmVnFoQTRsYXJZNy9uSG9D?=
 =?utf-8?B?V0FBVVY0dWNkVlptRjFlcHJzb3IyOGJIQThDbmZPWnRCVU9neklaSWU1ZC92?=
 =?utf-8?B?N2RaVzA5ZDR1bmxaK3V5eElGSTNJUDFkbndmS2RQNlRKSHQrMVNhTE5vTERL?=
 =?utf-8?B?aGkwdDJ2dW9YdFdObERVNThIY1RuaGtVcm5mUVNtVVNpYm05SWtDTGFmODZY?=
 =?utf-8?B?MzcwTU56MlFWQVFVVklQdnJsdWo2K0k3TmYyTm8zMUZwSUVxNFFoZVlLV3cr?=
 =?utf-8?B?RTVFRW1BNUV2WHRUcnVVRTliQ0h4UDQraWJkUGJIcUZHdVN3QThHV05PWjBW?=
 =?utf-8?B?SzRLbUxESTI2b0EyN2owZE5TQVphWEgrTm4xWnlGbnJsRWNoYkZBdDJRMHBO?=
 =?utf-8?B?T2VWT1dlbEZuSGV0Q1FkYTkwdFhHWFNrT0RhdHpBV0tQdS9tRWZyS1R0Tm1p?=
 =?utf-8?B?aGVLa0ZuZ284N0pMN0lCR3EyYkxPQlJyNVBXL0ZQTTB0ZE9GSlpBaXRiUFFR?=
 =?utf-8?B?VzRiZ0dKSjNlRXhWR1h3bmRKdEFFUHcweU5qNXliQzl1K3ZpY0RmeDkvNUFn?=
 =?utf-8?B?TlNQRk5PWTZidEVCSFlXdHFvU3NQNHc0bmZCRTdDdnMvVHM4dW96TXB3ODlj?=
 =?utf-8?B?ck9yZXVHcjJOUTZBSXJmWkViQjRhaDBmT1N2cEg4NThyNlcrckJNQlF1TEtC?=
 =?utf-8?B?MmdHSlFTUzA1UzVzdms5WDZ1cFBKWlBZTjRUSTJrME5ibWNxK0N4VFI3eWVN?=
 =?utf-8?B?MUdXVmFMdEJiWnY5aTUxZHhsU05ORXI3SnVjMFh0L29OSGVaSXdpRUhzdVo2?=
 =?utf-8?Q?NYw2PA/KzDqz0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b029bbc9-7896-49b7-0a5b-08d8b38278a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 03:07:02.2923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ELV3/QsWJpuTQNSK2hyg/pR4DVc6xcSkVMlyE6i5xyt6JDqyxjZzeYMGzgoq8qQ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
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

Ping

-----Original Message-----
From: Jack Zhang <Jack.Zhang1@amd.com> 
Sent: Thursday, January 7, 2021 6:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] amdgpu/sriov Stop data exchange for wholegpu reset

[Why]
When host trigger a whole gpu reset, guest will keep waiting till host finish reset. But there's a work queue in guest exchanging data between vf&pf which need to access frame buffer. During whole gpu reset, frame buffer is not accessable, and this causes the call trace.

[How]
After vf get reset notification from pf, stop data exchange.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 83ca5cbffe2c..3e212862cf5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -571,6 +571,7 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
 		DRM_INFO("clean up the vf2pf work item\n");
 		flush_delayed_work(&adev->virt.vf2pf_work);
 		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
+		adev->virt.vf2pf_update_interval_ms = 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 7767ccca526b..3ee481557fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -255,6 +255,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	if (!down_read_trylock(&adev->reset_sem))
 		return;
 
+	amdgpu_virt_fini_data_exchange(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
 
 	do {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index dd5c1e6ce009..48e588d3c409 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -276,6 +276,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	if (!down_read_trylock(&adev->reset_sem))
 		return;
 
+	amdgpu_virt_fini_data_exchange(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
 
 	do {
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
