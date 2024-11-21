Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF6DD75BCA
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 06:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D3EE10E3DE;
	Thu, 21 Nov 2024 06:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXqRiuWx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21B8410E3DE
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 06:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9pdhkw0szGJza7vXpl/SigWtGwLI68KvLKmN06OcT6aM//jSzMlXsvRRUb/3WIwVtzQfv8szoyKDe3VUcHN2DHtSc3aeCbSziwdIngi5cmM9cBm0zY0V1Z/eq1G5ZX8kSQIfHFZ1FCAjdV2kVJVxb0EJHtEpy6C3v2B5M4+7sv3Mlzw2TzYyPGW8as7DR/ezDGTpoPbRXM10firtauSVubranMz+wMe3GmAE7qXhfBLOI6qYqWky2+y3Sfy2YhCL8uzO1/vBnMRZajznis9NG7Rf4OJgh1qGV92CLDq2xBaDoZsAu8BR5rOpM+KbnL3HwXk/1m5ovp7xYu0W1/xew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIPYXhwc9eOgPK1nFgWGzzta2d1I0FrN/l8M5b3ZwG4=;
 b=htiU4ranPTc/Sc15OYCC7eWj7kYUsLG2r3sxtGx2+3UAynIM2o4YP/VIu+cLb9hb3ztnJvTFLRQaqDQ2jaSC2VmDoOk+oGQ0TSiP24RzsYbDZv3IpU3Bn5+Z+vIjSaxzk/sKd7x4qXtMowwjpu3E4zGH2k9mc28pYktEzoVnig56S0UMIXGEpp/wWGmcpeXmVO39ErbrsdSDArNBkb8saXUOmLl9m45DUceI1hy6Bei64vt++wXSLhY3gFSvCbnNXCfZ5z6U6aVtHEsMul2WsrfHOq89btDd5FDfb1gzEQoYX88+5CHW1cwuSJRab29KrVdWTZnLAaFWlTGd8Na+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIPYXhwc9eOgPK1nFgWGzzta2d1I0FrN/l8M5b3ZwG4=;
 b=eXqRiuWx+CSiHvynZZyqq9N026JeE9MmCpISAKTEttwzAvgsKM/nIvlLBR8UtsR41Q+b2M6/dKQ0pC2c6CjEeLWYC9/TiQnJZkRNqA5GyJtJBHYOGGHWSPks6Hkqfex/jJWzou0SSRRJ7HjNzJQQf6b3V6aL7/RuFbQXwhlkDRw=
Received: from SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 06:49:41 +0000
Received: from SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b]) by SA1PR12MB7343.namprd12.prod.outlook.com
 ([fe80::cb36:d7c3:c354:e74b%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 06:49:41 +0000
From: "Fan, Shikang" <Shikang.Fan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
CC: "Deng, Emily" <Emily.Deng@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Topic: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad
 jobs
Thread-Index: AQHbO8hOnWx5fJjctEim5f/IwIjsn7LBSehlgAABLnI=
Date: Thu, 21 Nov 2024 06:49:41 +0000
Message-ID: <SA1PR12MB7343558D8C9CB6A72BB898FFEB222@SA1PR12MB7343.namprd12.prod.outlook.com>
References: <20241121034835.1011382-1-shikang.fan@amd.com>
 <SA1PR12MB73430909A842EFAB0FBD01A9EB222@SA1PR12MB7343.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB73430909A842EFAB0FBD01A9EB222@SA1PR12MB7343.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-21T06:49:41.376Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7343:EE_|DM4PR12MB6637:EE_
x-ms-office365-filtering-correlation-id: a7542baa-9837-49b2-fc4b-08dd09f8ad18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xgzJfPAhQdUCOOjDsWTuJ7GVxdsqMnk6loWzNlDjDW3NvgLBFjlm4jY8ah?=
 =?iso-8859-1?Q?miqCIed1z0RO6rLOu2eiwh8HiI8l5Nab7IdcpejnJYtBjWDuf+U2nsLguY?=
 =?iso-8859-1?Q?Wj6eqSdXhuscEhX8yGEmZ5tysB/dg9dg5lME30rmoqPyuPemvphf5q3Cee?=
 =?iso-8859-1?Q?Oiz0/bNwS4XR6Up2mXiLj2ow0+zdLehSEBazsd24/PgII7rQvDd8NmYWNv?=
 =?iso-8859-1?Q?HXCYb5Cl29GCLnoXNUBlFhaEzGW1dUf9aKBdbt9UixHUd6MQ/kRJ//Wz0o?=
 =?iso-8859-1?Q?0i5vKrD5CX2YuWQmyigRp80GgO0+UGE647yPwlEaVsn9zcq1HCruQJJm8x?=
 =?iso-8859-1?Q?5M0o703MGDR760Pvt88yEiRjqHP+RmbqcJTI1lECbg7jdSIP4orn//d2Pe?=
 =?iso-8859-1?Q?QCk+2z7zvNq8wICwco2meTrMtTbQyZEELmGcANu1Vwb0gMjRxZT2NCUq98?=
 =?iso-8859-1?Q?IcuFCk27+unLS6z8KRHIGsUuHOtn8Ym0fuLC9qS2SC52PVbL4V9hsPHA2o?=
 =?iso-8859-1?Q?14ogTSEpWe2ksQZSejPsMb4bvFT3oJ3nUTvD+A2OV9HIl3qfpvLbEtBK5P?=
 =?iso-8859-1?Q?iqnLvG0sXe1MWnwpsaeWesesTjV02niLIx+oUJPxrCo26363Pa31pguOln?=
 =?iso-8859-1?Q?N1ImprcUC1qK5jAQgCTxdP0Tzee/RHf92TmE1QL6OPPEEPgwbRVp9EVjf8?=
 =?iso-8859-1?Q?CfeBgm9kAp0+n8RL7sOMSrELYrQFmq7P84pOcpgV8Y8ltuVfwLmwLBF0k+?=
 =?iso-8859-1?Q?SGcePuKhvRbXXSOwYYh7jmZb7/PMP2oM/GI5idGjN+P3BTxEHEsPu3DGe+?=
 =?iso-8859-1?Q?N1wZL3I/TtRD9lwR/DElmz3EWqE+OohVYQ380y6Of8x06oawG6CBcWOZRq?=
 =?iso-8859-1?Q?vg/31r/QRGar6ywsdHorLlbKX65S5zAlUlQ1CO929lxw5LiLRy4L9Ch4lI?=
 =?iso-8859-1?Q?hbwIA8F85DfxMqZj+enwWmsQhrD+THfjSf/IiZKZhAzmpFEzgNs22pvttZ?=
 =?iso-8859-1?Q?h/vAFT2B+gaGLpdUH/D1HAidufq4RKwCSUezIOL+1R4PT+Wvyw6ymQvPmK?=
 =?iso-8859-1?Q?lJZAb+8qdgFgw7ohgtyandzRxOR7kBUdJ46//G+TRkJzYa23sSmykehteU?=
 =?iso-8859-1?Q?Uu8EM0Jb+jK1EHGz7Rk/7lUv4SLhQF0ic5b5fI5uYu0IvU+QOHiDHiqhWC?=
 =?iso-8859-1?Q?aO37m+ruKhegw/inC6iBAPZ7rcEzzW01uAuGBiIXk6MTEiychnUsWCqqyM?=
 =?iso-8859-1?Q?Wfnrbzxr7GWkfJhmW2BPHCLL5jFsqwu3TW0JLBmXC1DzFkZbM5ufJZ3P6R?=
 =?iso-8859-1?Q?VKWr6mqKqMB+VplfM061dvJaE7AHRYYGbOl8pGcTsV9ezCS2zxj3ZrEpwU?=
 =?iso-8859-1?Q?6z8JhzjYFTts7t9nUANvnQ2ubq2QAcL0f5h8GSlOc7H8Wiascxso0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7343.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p5F3vaWa3wEdtCtOtai4et42m8dSYhvDHGa1g8zO0QViH6Arr8HoKuKTqC?=
 =?iso-8859-1?Q?4J3JDaJgfEeYyIrueFVYVMvIOCvRoEfTrv+p8EN9Y6a9jwO2vjS06V9bvR?=
 =?iso-8859-1?Q?LuJEjf0yJ6Wbkm1a8oo1jtLNN0i3XTNji7e8jXuNJEtOWow+TOno7zuMj2?=
 =?iso-8859-1?Q?xHR31VhOLrwlSJ5KwlV8s0Vw6Wd6tW4K4tcjmpOvEfQHSlCYznuBPvdHl+?=
 =?iso-8859-1?Q?UmyJDi9DQ/BHQd05iPrjwJRyxCsrYGoNHKcNS7fS5qpzyVEXRw5kReVTkH?=
 =?iso-8859-1?Q?9uQcXHbXEnKGZNjFlzpZGH5yLJIU9tHJ5xY7FNNigSP06FCkBXZrLrl5ao?=
 =?iso-8859-1?Q?eCZz9AGdg43k182e6NFGhvpfOnsHy5r7b/B9uzwQ60vtcoMi6ZZ+gN3viW?=
 =?iso-8859-1?Q?LYTMFM1SsGoP/KtIjGHmlLjZvHcw/xQK5UO8M892rTvDy5DMGYHPAjNeER?=
 =?iso-8859-1?Q?/bTibknRGrVyS4zZaiFlevC5pmf9apA2/TL9KWbzx14ijqO8ksb4MzTEHE?=
 =?iso-8859-1?Q?OuE0SqwaUws/I/HPtTRkUp0epK6h+oikiDPga1SyBKAUMO53y/pwrsnCi5?=
 =?iso-8859-1?Q?6CBTYI7kN5E6cdEEXlbs/nQgHnTI4kny3kM3miMHocoCKko9cbYq1PUpai?=
 =?iso-8859-1?Q?7BK9Z6SR+UftYFJ6ErRKdpmf8oJh0ox9SgDOhsHmNHC0XztJiiW+JiSn/q?=
 =?iso-8859-1?Q?hJ7x2d6pGQf52CHsMNgHkQhbZb0RZw+rWxwzdN3o+x5GZnmtElKdhLzQQK?=
 =?iso-8859-1?Q?nK7aWjmjE3NFcp0SKT+S6z6IQyH+sHg/aWyaoBOW1fTIv+OsMATHNdM3L1?=
 =?iso-8859-1?Q?qYDQGxZZz3IiXqXpPp+LhNZEzl1L6gIsxTv/ZJWnfd8wgvPjgBrIB7+gDO?=
 =?iso-8859-1?Q?gO4lC6ybRV2ydheQe4JhmD0Ys/aAgOp4oDFVvXDC0Sv9a2aBncoZGBajgt?=
 =?iso-8859-1?Q?II1sVbNrbtUBm7pYagHOS2ftNXGKMJXbpx/xXmccRVUyE7o6tRFwqANzws?=
 =?iso-8859-1?Q?ENUvRXiExxpFMLhGPtnP1PEO77fkAMnftQKdaMykVU9i8dPiGpb7ivSU1Z?=
 =?iso-8859-1?Q?PVgThpElDLDEcyqhQ8fJmPT8Bm/NBMmoOtmWM/jHc8jnPNC/lpsOMI0cbz?=
 =?iso-8859-1?Q?AVf0SjGSS/sWUPMDO7wMiKBbBiq2yE/BE0MuzJgBzHT6hZ9LhON/FNcBdr?=
 =?iso-8859-1?Q?RkY2bH9AIZF8JoEtVf8sWuESlOtwk1zNX1TB2NAzsnPB6YUOpOFchY0OJ7?=
 =?iso-8859-1?Q?KqvMHOtIDrhNOT9Bn0VRWElz+k5EfU2sipxK0t12ZmtQaNmSpKbPQ4h7eA?=
 =?iso-8859-1?Q?HqG1+nop1/u4gAUCyr/GfqBWSJFQvxpyQPHD3bNcTLyes2If6mekoT8rHY?=
 =?iso-8859-1?Q?CiRcraIitXn/YJURpBxvbpvVQIzeb+AeFSRghWnQu8gMBlrbI3p0+818Sv?=
 =?iso-8859-1?Q?7PSfJ53u0CSum7zx0mgNtu3WSBDdntszUyqkkUxw/tPypwMiAheUCocZMv?=
 =?iso-8859-1?Q?UvpDib96v8H3T5CrkpDqq0FK/Ota0I1y+6EBJZG+eZBpVN2Ua9HApdrORM?=
 =?iso-8859-1?Q?gpQhT1oO+QyEQWARZ+DROae2p/CcVxBXVF0ucr6zc02seLZn6+ey6LR58h?=
 =?iso-8859-1?Q?vuxz6oV1Dqdig=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB7343558D8C9CB6A72BB898FFEB222SA1PR12MB7343namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7343.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7542baa-9837-49b2-fc4b-08dd09f8ad18
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 06:49:41.6899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5sXxtWdj5OpYNywlhzQqO4xJNXu5fNXFzfgiHb9XXnom0g4qakdvzn93Ub4969AL8bQsY68e1joINa0+Qf87vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
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

--_000_SA1PR12MB7343558D8C9CB6A72BB898FFEB222SA1PR12MB7343namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

I forgot to delete the unused counter "j" from the patch, I'll remove it wh=
en submit the patch to the branch.

Thanks,
Shikang

________________________________
From: Fan, Shikang <Shikang.Fan@amd.com>
Sent: Thursday, November 21, 2024 2:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Koenig, =
Christian <Christian.Koenig@amd.com>
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Check fence emitted count to identify b=
ad jobs

+@Koenig, Christian<mailto:Christian.Koenig@amd.com>

Hi Christian,
Could you please help review this patch? I removed the timeout wait in the =
function.

Thanks,
Shikang

________________________________
From: Shikang Fan <shikang.fan@amd.com>
Sent: Thursday, November 21, 2024 11:48 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Fan, Shikang <Shikang.Fan@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdgpu: Check fence emitted count to identify bad j=
obs

In SRIOV, when host driver performs MODE 1 reset and notifies FLR to
guest driver, there is a small chance that there is no job running on hw
but the driver has not updated the pending list yet, causing the driver
not respond the FLR request. Modify the has_job_running function to
make sure if there is still running job.

v2: Use amdgpu_fence_count_emitted to determine job running status.
v3: Remove the timeout wait in has_job_running

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index b3ca911e55d6..f53889ce71a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5222,15 +5222,18 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
 }

 /**
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t
+ * amdgpu_device_has_job_running - check if there is any unfinished job
  *
  * @adev: amdgpu_device pointer
  *
- * check if there is any job in mirror list
+ * check if there is any job running on the device when guest driver recei=
ves
+ * FLR notification from host driver. If there are still jobs running, the=
n
+ * the guest driver will not respond the FLR reset. Instead, let the job h=
it
+ * the timeout and guest driver then issue the reset request.
  */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
 {
-       int i;
+       int i, j;
         struct drm_sched_job *job;

         for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -5239,11 +5242,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_dev=
ice *adev)
                 if (!amdgpu_ring_sched_ready(ring))
                         continue;

-               spin_lock(&ring->sched.job_list_lock);
-               job =3D list_first_entry_or_null(&ring->sched.pending_list,
-                                              struct drm_sched_job, list);
-               spin_unlock(&ring->sched.job_list_lock);
-               if (job)
+               if (amdgpu_fence_count_emitted(ring))
                         return true;
         }
         return false;
--
2.34.1


--_000_SA1PR12MB7343558D8C9CB6A72BB898FFEB222SA1PR12MB7343namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
I forgot to delete the unused counter &quot;j&quot; from the patch, I'll re=
move it when submit the patch to the branch.<br>
<br>
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shikang</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Fan, Shikang &lt;Shik=
ang.Fan@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 21, 2024 2:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3] drm/amdgpu: Check fence emitted count to ide=
ntify bad jobs</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
+<a href=3D"mailto:Christian.Koenig@amd.com" id=3D"OWAAM340083" class=3D"x_=
tWKOu x_mention x_ms-bgc-nlr x_ms-fcl-b">@Koenig, Christian</a><br>
<br>
Hi Christian,<br>
Could you please help review this patch? I removed the timeout wait in the =
function.<br>
<br>
Thanks,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Shikang</div>
<div id=3D"x_appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:11pt; color:rgb(0,0,0)">
<br>
</div>
<hr style=3D"display:inline-block; width:98%">
<div dir=3D"ltr" id=3D"x_divRplyFwdMsg"><span style=3D"font-family:Calibri,=
sans-serif; font-size:11pt; color:rgb(0,0,0)"><b>From:</b>&nbsp;Shikang Fan=
 &lt;shikang.fan@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, November 21, 2024 11:48 AM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Fan, Shikang &lt;Shikang.Fan@amd.com&gt;; Deng, Emily &lt;E=
mily.Deng@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v3] drm/amdgpu: Check fence emitted count to id=
entify bad jobs</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size:11pt">In SRIOV, when host driver performs MODE 1 re=
set and notifies FLR to<br>
guest driver, there is a small chance that there is no job running on hw<br=
>
but the driver has not updated the pending list yet, causing the driver<br>
not respond the FLR request. Modify the has_job_running function to<br>
make sure if there is still running job.<br>
<br>
v2: Use amdgpu_fence_count_emitted to determine job running status.<br>
v3: Remove the timeout wait in has_job_running<br>
<br>
Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<br>
Signed-off-by: Shikang Fan &lt;shikang.fan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------<br>
&nbsp;1 file changed, 7 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index b3ca911e55d6..f53889ce71a8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -5222,15 +5222,18 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_device_has_job_running - check if there is any job in mirror lis=
t<br>
+ * amdgpu_device_has_job_running - check if there is any unfinished job<br=
>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
&nbsp; *<br>
- * check if there is any job in mirror list<br>
+ * check if there is any job running on the device when guest driver recei=
ves<br>
+ * FLR notification from host driver. If there are still jobs running, the=
n<br>
+ * the guest driver will not respond the FLR reset. Instead, let the job h=
it<br>
+ * the timeout and guest driver then issue the reset request.<br>
&nbsp; */<br>
&nbsp;bool amdgpu_device_has_job_running(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MAX_RINGS; ++i) {<br>
@@ -5239,11 +5242,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ring_sched_ready(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_lock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_lis=
t,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (job)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_fence_count_emitted(ring))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
--<br>
2.34.1<br>
<br>
</div>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB7343558D8C9CB6A72BB898FFEB222SA1PR12MB7343namp_--
