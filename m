Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39743D597C8
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 03:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2D410E334;
	Wed, 13 Nov 2024 03:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ozE7K4kR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1603810E334
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 03:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqs36BQNNl86kziWcDxMsrzkIcE9qhlUy9Ao1G2fJ29VnqrWRaB/JUEeSc4uWVxdJG7jRJSBL/ZAv4/oi6PXzT018hrCr0yROO7O08ie/tcaskj5NhQCHWxNRWDx9XdsWWwj207NCFmnDn0pXgwexO+7d+Yy8mx/uPEoOignS1VD2Fp+xDfch22sLErkAhX+lHYdp9BwsjWQF9RGUf2wlbkzuz7nRnv1GTw3hzJoLvrRjRhV1MIjOAYa+lqb3lPfV5nIrBHtrMo+sQtllf34hTiCG8M79PLW9UPTuvANJoh9E4ly9LJF0Pc/KHrKz8pjDxf3nUdjDvqLfHO2UZvZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbMihwGIGv2nodSyUK+8F29ITOHI6YNANsazPZst81I=;
 b=ooE+liOnkfuIQn3ctPISW1c7PgmrPefU1YyWqZuSXZb2AqIuPdbB0QCpoHzKZecK7WT1E6+arCRHmbMy1bsnR09KYCUXVxtizH9JJ2tlJYGr+5iy5a2SvyjE95pzCeKJ/lA0M+xYxZKeyR8J9DgI9J3WB/8bbmpUeBfCVpr6aoRnsIxiWvPUvtGxykJukSBzsxQd5zYZrJ+6yDDSugBFyCE+ximYCeqApIVVyIVOviDNG8vGJSEQ5TF8avDzIkHXK0jekLou+Q8NXp0d7EmQApkJfH2aEPJeeUADqf5VoHMIedvUEAMLe29BqijPEhAKUitrpKkAvXuA7ozuoA+czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbMihwGIGv2nodSyUK+8F29ITOHI6YNANsazPZst81I=;
 b=ozE7K4kRlesvPm72DhYgt3NoP4rNiZ62PPtyTRB14wiJgOlxysFHqm52wmBfLYXvmey+4i30Xxioc9e2SUuJtgS7ErsYozYU2NGmp0qvDTLlLnbWvY+NzJEF6dqrzLnVXFVDqROjP7HDlFCcIMOaKqiZ061Yhj2zzNb+6Gwk0Hs=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 13 Nov
 2024 03:15:22 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 03:15:22 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>
Subject: Re: [PATCH] [PATCH] drm/amdgpu/sriov: Check pending job finished or
 not to  identify has bad job
Thread-Topic: [PATCH] [PATCH] drm/amdgpu/sriov: Check pending job finished or
 not to  identify has bad job
Thread-Index: AQHbMbIX8zmrDDJ+a0ik1Bqx57RLcLK0kPEq
Date: Wed, 13 Nov 2024 03:15:21 +0000
Message-ID: <SA1PR12MB73435E05146A9DBA720ECFB3EB5A2@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20241108074435.641831-1-shikang.fan@amd.com>
In-Reply-To: <20241108074435.641831-1-shikang.fan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-13T03:15:21.585Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|PH0PR12MB5631:EE_
x-ms-office365-filtering-correlation-id: f1ba8cf7-cd32-45ee-93b0-08dd039168d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5vj/wbwcXI7U2eIpcF10k/hwYMRHejsw8IotNTDk622Tq+gRZSDxHLcfIJSt?=
 =?us-ascii?Q?M57eV4PIf8SdceNcPjidCuy1hZ+tFYIkLqU1MotHck47nUPhQkrye3yVbppp?=
 =?us-ascii?Q?tpULToaGIigjffc/BSehjwyEjwSszQxZb01wF2MlIEVHwD30e4KJ4AucgsoX?=
 =?us-ascii?Q?FJ7zgNpumAwqJTNKhtd7B4TKNT8loeLQ8orYZN3jm6JdtRpZdtLQTsQCvlWt?=
 =?us-ascii?Q?J/mzKy7jYW4nmIKOD6BvFGVjerIZfkp+5z1UTpkNZeE09WWYRRCkYLb8ax3A?=
 =?us-ascii?Q?aqNFj0T1m29ifidtb2MgkKF7oQS6xuo5shEQg6jAWkuJzhKTyaMsPd0FSyNG?=
 =?us-ascii?Q?PyJQPnFNQ48XRrJ4+pIwIKx8HUmU+eKX8BBsgo/6LQ9b6DfMDlizGnZ6lEoe?=
 =?us-ascii?Q?r7jSbTA6068KSf+Oe3oyPnz2atpSw6JdrMXKGmIyVIWSk7T3tK2/PbV4HBPD?=
 =?us-ascii?Q?FwcQQ/mSZSyLp4RSUWrUOw4ayShw9OuQrqdJ23wwzGLNOBFvvHjxdE0Zbmdv?=
 =?us-ascii?Q?W0EgAbb7q/I0GYJSuCV67+i0B0VHQju3wIgl9h9SqgTUCqh5oicfQdqCOAwE?=
 =?us-ascii?Q?kXHig8fz6QE3E7EnJSJcCroQeaVvK8sfwHbBrIlMJ541kQSQ0dpx19gnigHN?=
 =?us-ascii?Q?INb+b7YKrajAPAfCJA/Pu0xWwjIDf2R0M8tut5jjwxzPtl2puMoSCq/IGnQC?=
 =?us-ascii?Q?nI7J02McqLQLOZft7p2w7ds9AnRitp40ooNKjL98yfTFRZkbAIob6VY9eVuH?=
 =?us-ascii?Q?IwA0v17n2lCrzG4SLT11lX04z+3wisUhyAFULUI92yn0wchSTRV11qjBEzE5?=
 =?us-ascii?Q?Z+0VSJ/YgNUkzPWu2naeXTP/HH4Y8jbXGd8IN0mUSofyhxw7tgaa3eTcHzq7?=
 =?us-ascii?Q?pVCg/OhSRysMoyzBKQUQDzjzU7DtWfy+EIn4KRrbWYpQW+qObCG4bY1bgX3K?=
 =?us-ascii?Q?s1aGteq8Gc7qlznkR6BS2v+JjreOhlWgzCeSABhGoi2dLesYqWS3W/gnRNGC?=
 =?us-ascii?Q?M2XOsqzUyAYNHPoEJyCNE8mLX33wxgUVs0QxU4IRQRrJYfo3K62uuIPZ+jEQ?=
 =?us-ascii?Q?bDWV0vlDOGvOzsFl3rz/9My5xOEeIZ3iThM4B0Gu1Fc/3mKnh4S/UHX1m0AO?=
 =?us-ascii?Q?fdzCulOQVglha4vpBkAWe7zyb7MRFIAVDK/BpQVmcEuwE1jWyZUgS7VxTICr?=
 =?us-ascii?Q?PuHyhg9AU9UMZQJ+XWJXAHXBboYOsMOxMB/4TSIHpGmfCbQ7Nb0ShHgFLjlP?=
 =?us-ascii?Q?ZxXQ99kM4QUuCOavsOj9DomsRr+zxVbPeWcPdHYMAhHfjxAUHnmom+u74DdS?=
 =?us-ascii?Q?BYDgAPTFLkXT52AaY0NS+/eVuwBOkISio2S35Sn/iRad0nf0djxWdrXEAymz?=
 =?us-ascii?Q?QEakw5M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1EZ44OGtrhr4uWdJgnd4EC0M5R6SclDIcJ70B94p9AOdxTdJwCGrI9kXuJ4W?=
 =?us-ascii?Q?axAwQ5eYRThYsNmBCB8D8AS1oYCWiFrx0i8hkJyE+KLkGIJCVa17P8J5sZVK?=
 =?us-ascii?Q?l8dfwY4EYPWtNFl3Ke50IoXw0J0EdtR6zAq2WCDc4Nk3Ig040o32dcdtJOLu?=
 =?us-ascii?Q?uW7ITyxlf92wzEL/P22viOykuAx8i++cvpuWoXzItAkDcK/tTrsailFksDDz?=
 =?us-ascii?Q?OcuaXTZo5n5yEFIGRe23s48PSYfnkVMH1vgrOQJ2KImkuZJUtqTIV657JUYO?=
 =?us-ascii?Q?NdRHba9AaCTgyGwP4YMrmXnO4v76qidQr+XbAwS4XeeEsJdpLaO2aUKUSCYC?=
 =?us-ascii?Q?OxiTtExRK2Qil8bB9M7R0Xhec2qksT3YCKAqPXlw62g6vKCTDgf4H+GJg+X7?=
 =?us-ascii?Q?RoTRU9dFHa9P5rNPZtdkRSZkMz9Wyg0MyZXCepY7Q0nKKpGZElC/37UM7xyV?=
 =?us-ascii?Q?h4PceONg0od98/lNyB5m8ezHLRGpRUcxwBWLvvEE5zRDPRoxlaILSsJTaRfP?=
 =?us-ascii?Q?f4/x0mH/UGmxRhmLb3lXuk9eoSXMpinQo07+DWu8IgUqTYkDStS9Rqw/49nu?=
 =?us-ascii?Q?HZKW7HlKOWA6utcm85x4hPWthnXHJMHcPkxJvo7g+vxDonmU/D0+l04vcTSr?=
 =?us-ascii?Q?FTXpdJGHoRb49NBa7XgVDge4YoAXWUaTZMKgoaDK68EUnkPj/5KfOcs9YgbU?=
 =?us-ascii?Q?og+V6E7kWQI7RVaXgHYIWYk3Bh+ejyJKATtRWPhALI2fGEmldMj45My26Hu+?=
 =?us-ascii?Q?38c76azJUChAsl6zaO7Xx5EEAXvUcKF93VbC89hDpPSPXjTInCltay/TI/mH?=
 =?us-ascii?Q?lCdz4eoJ51tMgPpJ+DPq9F7Tx+2dUZ05MhGy92+NYs6KP/o/WR1tF3N0oXnL?=
 =?us-ascii?Q?mEk4lWlVZxCPLhcg/7jYpaY5KotnJ2sKfvRe2lqTBhnb8z356u9qC0AemwuH?=
 =?us-ascii?Q?Rn6PfamG8uj6qgcYztqIkcYFwieZBQwmrLkCn54hJF70hHld7pLA7o9fs5zu?=
 =?us-ascii?Q?XC1QGZljdqxVm7ZHC5u+72yrCPS3osYJbfPHF7fv+HTIAr0x68KxQ8m27Yh8?=
 =?us-ascii?Q?NGV9zHwL6WKfiLYltCGXirvvMSjUOyJJK0xSmEY0tAeGjvu/r3sGE4itRgcr?=
 =?us-ascii?Q?43LkKA/bbEXvSoMuI5tXCG4yUsWhPUc0IrRe+poJuNJShGpv7TtXEwew+ys3?=
 =?us-ascii?Q?t+AEANFSB5KLwKSqim6J1eynwmxNrugLi+vBniX979NIKERnHfYtFdc8YGos?=
 =?us-ascii?Q?S7vkaVW9YA8NOa3wTju+3QzzWnk3iHY+P8pCV0NQKcVikGHhzWdWW5oXJo41?=
 =?us-ascii?Q?UdcjvUf6sOC0QmojC1QlGsKXFGSb+wgZrQ5mC140pr7gVDGjOz8KZYbPLNpE?=
 =?us-ascii?Q?Xm4zzLG6Bg16cPYo81leE8cfvqrIh3Y15xuhka49gAnh5elBPOrJt8/+Q7FJ?=
 =?us-ascii?Q?MhG3UKc7cTlx4ArT+gV0+7AQavoLEdJPcowHPE4Fkf0wIvuBOw3mo736B+v4?=
 =?us-ascii?Q?o79pSCZTkNXjb/6BXdi0Yx1S2yBKAHB6lRNIuGshwpJAy3mOO/Kq3UZ8akFG?=
 =?us-ascii?Q?9Jsp1g1qp2Ciou48PxE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB73435E05146A9DBA720ECFB3EB5A2SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ba8cf7-cd32-45ee-93b0-08dd039168d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 03:15:21.9941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: As+vhjmh9l+Ti8ovMqg7gmzexqfvApE0/9hAK/ru0nuCx9aBK7h5FIEAnaO2Z3loTLtDabriE4jHscXlyfU0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SA1PR12MB73435E05146A9DBA720ECFB3EB5A2SA1PR12MB7343namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Abandon this patch as a modified new patch is sent for review.

Regards,
Shikang
________________________________
From: Shikang Fan <shikang.fan@amd.com>
Sent: Friday, November 8, 2024 3:44 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Fan, Shikang <Shikang.Fan@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@am=
d.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] [PATCH] drm/amdgpu/sriov: Check pending job finished or no=
t to identify has bad job

drm_sched_free_job_work is a queue work function,
so even job is finished in hw, it still needs some time to
be deleted from the pending queue by drm_sched_free_job_work.
here iterates over the pending job list and wait for each job to finish
within specified timeout (1s by default) to avoid jobs that are not
cleaned up in time or are about to finished.
if wait timeout, return true

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 6c0ff1c2ae4c..83ce1c85e680 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -100,6 +100,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_PCIE_INDEX_FALLBACK (0x38 >> 2)
 #define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 >> 2)
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
+#define AMDGPU_PENDING_JOB_TIMEOUT     msecs_to_jiffies(1000)

 static const struct drm_driver amdgpu_kms_driver;

@@ -5198,7 +5199,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
         int i;
-       struct drm_sched_job *job;
+       struct drm_sched_job *job, *tmp;
+       long r;

         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
                 struct amdgpu_ring *ring =3D adev->rings[i];
@@ -5207,11 +5209,20 @@ bool amdgpu_device_has_job_running(struct amdgpu_de=
vice *adev)
                         continue;

                 spin_lock(&ring->sched.job_list_lock);
-               job =3D list_first_entry_or_null(&ring->sched.pending_list,
-                                              struct drm_sched_job, list);
+
+               /* iterates over the pending job list
+                * wait for each job to finish within timeout (1s by defaul=
t)
+                * if wait timeout, return true
+                */
+               list_for_each_entry_safe(job, tmp, &ring->sched.pending_lis=
t, list) {
+                       r =3D dma_fence_wait_timeout(&job->s_fence->finishe=
d,
+                                                               false, AMDG=
PU_PENDING_JOB_TIMEOUT);
+                       if (r <=3D 0) {
+                               spin_unlock(&ring->sched.job_list_lock);
+                               return true;
+                       }
+               }
                 spin_unlock(&ring->sched.job_list_lock);
-               if (job)
-                       return true;
         }
         return false;
 }
--
2.34.1


--_000_SA1PR12MB73435E05146A9DBA720ECFB3EB5A2SA1PR12MB7343namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Abandon this patch as a modified new patch is sent for review.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Shikang Fan &lt;shika=
ng.fan@amd.com&gt;<br>
<b>Sent:</b> Friday, November 8, 2024 3:44 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; Liu01, Tong (Esther) &=
lt;Tong.Liu01@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> [PATCH] [PATCH] drm/amdgpu/sriov: Check pending job finishe=
d or not to identify has bad job</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">drm_sched_free_job_work is a queue work function,<=
br>
so even job is finished in hw, it still needs some time to<br>
be deleted from the pending queue by drm_sched_free_job_work.<br>
here iterates over the pending job list and wait for each job to finish<br>
within specified timeout (1s by default) to avoid jobs that are not<br>
cleaned up in time or are about to finished.<br>
if wait timeout, return true<br>
<br>
Signed-off-by: Tong Liu01 &lt;Tong.Liu01@amd.com&gt;<br>
Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++-----=
<br>
&nbsp;1 file changed, 16 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 6c0ff1c2ae4c..83ce1c85e680 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -100,6 +100,7 @@ MODULE_FIRMWARE(&quot;amdgpu/navi12_gpu_info.bin&quot;)=
;<br>
&nbsp;#define AMDGPU_PCIE_INDEX_FALLBACK (0x38 &gt;&gt; 2)<br>
&nbsp;#define AMDGPU_PCIE_INDEX_HI_FALLBACK (0x44 &gt;&gt; 2)<br>
&nbsp;#define AMDGPU_PCIE_DATA_FALLBACK (0x3C &gt;&gt; 2)<br>
+#define AMDGPU_PENDING_JOB_TIMEOUT&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffie=
s(1000)<br>
&nbsp;<br>
&nbsp;static const struct drm_driver amdgpu_kms_driver;<br>
&nbsp;<br>
@@ -5198,7 +5199,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_de=
vice *adev,<br>
&nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job, *tmp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D adev-&gt;rings[i];<br>
@@ -5207,11 +5209,20 @@ bool amdgpu_device_has_job_running(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_lis=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* iterates over the pending job list<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * wait for each job to finish within timeout (1s by defaul=
t)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * if wait timeout, return true<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry_safe(job, tmp, &amp;ring-&gt;sched.pending_l=
ist, list) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_fence_=
wait_timeout(&amp;job-&gt;s_fence-&gt;finished,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
alse, AMDGPU_PENDING_JOB_TIMEOUT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r &lt;=3D 0)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;ring-&gt;sched.job_list_lo=
ck);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (job)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SA1PR12MB73435E05146A9DBA720ECFB3EB5A2SA1PR12MB7343namp_--
