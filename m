Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA96C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 18:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E8D112E09;
	Tue, 30 Apr 2024 18:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qkrg+FDF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AED9112E09
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 18:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbxUTiex59JCEwLLAf7f5R9vPsG/GXxiU26NWSoWW43H1EhUsgv5mavcjmG2DLNsMyils6LqlD5oXUJdDWq8egX24ZyWrOKE7PH+rQc225FDEcpkNQNxh825x4iBnt9QhMWuyQabBY49ZYbeabfDZDl6YU00SKzKE9nJ2UPd6EtYJ7NbG0LVnmuhOKMkBZdwEwPFUibL7UTrgd7NckX6gPougoK4FWDtVgGfJAA0miGODZFhJFtYtxrUGPfYBJlXfDLsElDEf6TCqRsOcfqqVO7nOv2aRRs36xGzSas+CdlzC2heDtD1REkfNazJTKRQhKuHuyeiRLRt+Zqpk4c+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e5bnXc/x5YlnOb3tHqjZ/7Xt84E7Of09T0Yvi/UkVY=;
 b=NH5XtFZxCnHD2EKNXhSSL5uMbaUbTmR6tDrSbOoYpfIORVDVByYTJTtVrHqgT6kOAcFlWN6K/0CoEZjZ6+Oi/KIbPZ8iDvDYO6o4FMe+gWUdciZt7uYHW0Qt9LuBPPhFB8ajkjuXOoxZyKJQQ1wtywEdgIw4kENboVuCI8pJRy9se3Hfo8Qm147ZowlRz5sp3yZ661jVW68CJm0TwEth+uWFjF11+8iFiwqMUu5DfGyrb/tLZmPIacHaOZcCIgfWTwAbu4Rd4czK/+bxM7/DYVf+sc9ubrytXHdsARYsBFBzsamo2WUveVrmq7P115pU5qNxkggdpwzjqY4WQeGwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e5bnXc/x5YlnOb3tHqjZ/7Xt84E7Of09T0Yvi/UkVY=;
 b=Qkrg+FDFVz9AxSVzROGrUAmMGMLA6DItTILymqy8MYL8nO8JdXUSj4Y2dHXCt9xF6koxBCjFEFveqcey2505fe26mdmiq5d1StLEAgAQVaGLM+mjcW+PPS/sPI+Ogw1Nz+X6xj/OSjGA/dEgUCFvmgsyiRn+oJnYmCCXg8hlwzY=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 18:25:55 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c%5]) with mapi id 15.20.7519.030; Tue, 30 Apr 2024
 18:25:55 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Li,
 Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Subject: RE: [PATCH v2 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry
 logic
Thread-Topic: [PATCH v2 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry
 logic
Thread-Index: AQHamAe50EhuoCszI0+bUBbpZyLhKbGBJ3jw
Date: Tue, 30 Apr 2024 18:25:55 +0000
Message-ID: <DM4PR12MB53285DDDDF26EBF1B0DEC7EEF11A2@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240426035742.90560-3-Yunxiang.Li@amd.com>
 <20240426182928.98181-1-Yunxiang.Li@amd.com>
In-Reply-To: <20240426182928.98181-1-Yunxiang.Li@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9bf50880-0345-4670-a8d0-44d2720ce2c7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T18:25:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|CH3PR12MB9432:EE_
x-ms-office365-filtering-correlation-id: 9904a04f-4526-47e0-1e64-08dc6942f9a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Xbd+pCL/1RiUqfrRdsJqOi4uD/YJpgYmcfLUJuVqd4gK5CraZ75/vuPY4gdJ?=
 =?us-ascii?Q?6FeEJOrjV+pMQEp70rSwg37c6gQIhOg+wjmCC6lPS8LGC0FD7/h9LMWBABRS?=
 =?us-ascii?Q?NO3s/zUB6C3Jqlb58EWCDtyrmQgpIlzLuU6uvyd9CbX+7nBimlrMB08PLzHb?=
 =?us-ascii?Q?1TVJLOZO/YVqkjLQb0kaTpGClZ7mWR/HtEr+XeJWcuHCNRe61J/J6ESVhIAW?=
 =?us-ascii?Q?iAoDlt0YOko1OPAM1SwZXOHp+/gvrgvYo7+cL0xSQctqWY0vNPmBn8WrihbY?=
 =?us-ascii?Q?Uq4t/UQtn1P40mOlnqDPjkKkj/U87neMbnFR8hWH49YT8DftR76pfDLyrY2W?=
 =?us-ascii?Q?O3JpHB9JdH6VDsTySRDVjLh1oo9NPUozpzy8BCPzLJi2Zreoq3R2ohqEYvuH?=
 =?us-ascii?Q?X8Q2qmd+/4IhEFBSxZTIiLiIcj8istR5dcRgBPzNgoG7KIJP/GqDb2vXj/Rj?=
 =?us-ascii?Q?TXirWtE+us+No+v6JpAuCGtCQbPuHDmh5H0cqEM0xpf82BK5/CaioRnHYEGK?=
 =?us-ascii?Q?tyMSLKM5THF77bmhgejqObZInmFg5D15ON77x57OmZmmeVy2BI+1UWMAAfMf?=
 =?us-ascii?Q?aazsNH7/G6n2UGzE8++aoHgeHwrcdV/XTpxdBIPDS2+fbYJTzLxfaL08LNAU?=
 =?us-ascii?Q?1BcK60k6QPWoRdnV7p8V6GeKX8U9eL1NWdbh3zRpvw+Kj6kzH7/ituNPFtYI?=
 =?us-ascii?Q?Wh1thNKmkqHx1j/t3Snwfp6cQwFTuaIvBt+QWuURyX2YzKXvsYiVs4yC06yR?=
 =?us-ascii?Q?VplQgrk3KnSgVi+QFTDHlOXzKTr0Y0G6IBtdoJthBpGDnYOYR3qDB9JliV92?=
 =?us-ascii?Q?4EvTuH7QxZsdjUCDQxBMdStA2gwu04sGvE/w0FKm8xJU4aYW5jvHFfcqJ7fb?=
 =?us-ascii?Q?JRN/l8vXxyMdoP5xAX0FKqjt2xHbXKzAgVvKou/91pryxdoVC+oXikoSJJkY?=
 =?us-ascii?Q?lvRXuNArXX7m3OKVbmQmRMliuPkcXqfSLHqFNZQCehdRfmOSakWU9wzMQv1A?=
 =?us-ascii?Q?RWvsxtkawdIFjqTmZ2dwZ1lkEclig1I2h7sz5eCkCUXYFYx/T2limOxE641c?=
 =?us-ascii?Q?xZHSyDUXmS6ARBgDL4doBJC7j/9YDpyoPEttUxk45vDIQMC1ceTexdzwyLe9?=
 =?us-ascii?Q?PTenFYBC2N+qqZnMsRZUIBsd6TZiKeQcTfgCi66PlR7TXPf9ffTyKTIVUBaK?=
 =?us-ascii?Q?XZwTQvOr9Duat0irj5G/gsH8Z09FtxU/hlIOhk8hX4BLGvKcAQm2VvhgEw85?=
 =?us-ascii?Q?uBwGOTzDUhpJCgGuyy2NTXcGljg4hOlp0YNkVfJMxa9dTjV5ZKm9IUxKWnDq?=
 =?us-ascii?Q?6eRXDMeMCPMPSqP3KY2YMM+8HgpL8dxuCWuzSoJiTAruTg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HuM4p+Ckp/eOYERIeX39yx4M6aOgiQoA3oGetjhgvuMQ4x1ld+TVnnEIUItV?=
 =?us-ascii?Q?fhTRhw3X06UYmMTrAChrFcE+rZrrYbyLc8k8ltAmxDE+GubBq6YelkFllvSZ?=
 =?us-ascii?Q?ipOohdmctiE6RgI/kDRvYDfKKeh/VwbBrjRkYrjH4sh+MrTZ7z9u9LchL1Oo?=
 =?us-ascii?Q?NDQvDJCR3w4ZtK81f80HrBPT05874PCIqePiKDww4eBoFxWJQHKV/O5lT37h?=
 =?us-ascii?Q?Er8WNi7zmGZhDdIqR7z7L5eAQkXqt4SvD4hfLTqycvEXtOBw1oAckrzm/Y9T?=
 =?us-ascii?Q?nA2mbUVElxOJTF4ZL6yNJ4HXhu+WArjeiAE6F2RIXeUXqkxtgtTJfS17d4PC?=
 =?us-ascii?Q?ThIzOwlQnDiDR3FJWMSSHKeONW1VVYPLQi8/pY27J6uR4vkS+JrAYmg5xatx?=
 =?us-ascii?Q?Ph4C8+Pwl79QIs0w2Y67RyFkc1/B8n/9erWHG6/I8ybWysDK39oSHEd2E63s?=
 =?us-ascii?Q?DOe1bBtyyhNPgQQF0qMdJwTtiCFce/4ykb+W+IVZrQRfVbv01OdIi19vbbEb?=
 =?us-ascii?Q?4f6KYSmEc6inf4INDeTgJgnzVTIRkvVQpdhT5nEw+uPlNDLkUgcHzZXUT84p?=
 =?us-ascii?Q?igzB9vliDjUGq81BmJ8Ro1YM2D+6p/Bg5SqhcpIqCmHy0/24nhRQlRrpY3kg?=
 =?us-ascii?Q?beIGDCRAFUem9uaAL7Asmn7L6DTNnHm8LrCeUgE1UTfliA+yCFYjNliQTb+G?=
 =?us-ascii?Q?ZJ00B2QhrscjBm0/eof+5N4E0iI7qSGYYFGBauUZXtbVUwftviikSqFIVsQt?=
 =?us-ascii?Q?gyU9bw1DgNA394L/4/A1ZT9aUWYoAv29Hkz+MJH1qp3oNE49Fukm17oTZ6hR?=
 =?us-ascii?Q?IrkSDJ9K09QwUCpe7FuP1NDLuAzbR/0CKNMgw3P1RZ7Jsv409hv1fe6Lf03t?=
 =?us-ascii?Q?WX38/4Bbdj8R4F5/RHLC6hUEaHw+mHmzTGOLUgGjyipA1bbUt22eumU9yGcP?=
 =?us-ascii?Q?bGebxNGWUSopGOlMHcGyd7ex3zZAD5BPlclQcDbjvtXPqVaVbJl8X3AaZLe2?=
 =?us-ascii?Q?RInbj6BFkdSlvsHwnYMx+b+DHVbqoDT/iLeUuDUHrGZelBZuIsamVZJvw9WH?=
 =?us-ascii?Q?ixqRyqQgzViKsQDA6am/ktSpheSNoVP66j8mL7XNKG7v4lrrY/D0KJTX71Il?=
 =?us-ascii?Q?oG2LcxaIte/lEzKI2ZJWrPMfgNoe+AE079oeac9y6fR+9NHYzfLi62EalE6M?=
 =?us-ascii?Q?WYl3byipK0R1JGv2oQaXZnRH+dSFzGZtu+oSMpB1QV4oXm3hiVHSsIBoFxGt?=
 =?us-ascii?Q?7GL8Ti1dtdPFrJdlSpuo6OZ+lulgmLbZIhq/eWUkl8ErDWFRwsafRB2bmYBz?=
 =?us-ascii?Q?EaheuBOVqNhXn6g5bhewwuAD0LugJ2MdZJHKFq0YhYq/xdfBRpXK0ibCUnRr?=
 =?us-ascii?Q?m20N0dgwIqBd5enBywGKSYjiO7jA4Vb72u3wp5INnZ0duoXUJEVebDSqnG+c?=
 =?us-ascii?Q?nKF1OHf4HBjaw5U5UniRbvGCwTHCdWADJF9IEKkpSBqqshfrmnZ4TTZeA4pj?=
 =?us-ascii?Q?ab3FhKzVfsHQWu9L5MR09SzCCbBelznCnIjEyU/ShHdGVbY3ceYhhaNjt2DK?=
 =?us-ascii?Q?6CvXrFzPu9D5lKHxJa0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9904a04f-4526-47e0-1e64-08dc6942f9a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 18:25:55.6902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2nPT2D7txMCrsanqEsHqVFQHUi02/FjWM0DWNwPGqf4D7I4ZD8jg7XXrrmi67pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
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

[AMD Official Use Only - General]

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yunxiang=
 Li
Sent: Friday, April 26, 2024 2:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Kuehling, Felix <F=
elix.Kuehling@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Li, Yunxiang (Ted=
dy) <Yunxiang.Li@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry log=
ic

The retry loop for SRIOV reset have refcount and memory leak issue.
Depending on which function call fails it can potentially call amdgpu_amdkf=
d_pre/post_reset different number of times and causes kfd_locked count to b=
e wrong. This will block all future attempts at opening /dev/kfd. The retry=
 loop also leakes resources by calling amdgpu_virt_init_data_exchange multi=
ple times without calling the corresponding fini function.

Align with the bare-metal reset path which doesn't have these issues.
This means taking the amdgpu_amdkfd_pre/post_reset functions out of the res=
et loop and calling amdgpu_device_pre_asic_reset each retry which properly =
free the resources from previous try by calling amdgpu_virt_fini_data_excha=
nge.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: put back release full access and the missed return

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 33c889c027a5..b23645f23a2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5065,10 +5065,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_d=
evice *adev,  {
        int r;
        struct amdgpu_hive_info *hive =3D NULL;
-       int retry_limit =3D 0;
-
-retry:
-       amdgpu_amdkfd_pre_reset(adev);

        if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
                clear_bit(AMDGPU_HOST_FLR, &reset_context->flags); @@ -5088=
,7 +5084,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *ad=
ev,
        /* Resume IP prior to SMC */
        r =3D amdgpu_device_ip_reinit_early_sriov(adev);
        if (r)
-               goto error;
+               return r;

        amdgpu_virt_init_data_exchange(adev);

@@ -5099,38 +5095,35 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
        /* now we are okay to resume SMC/CP/SDMA */
        r =3D amdgpu_device_ip_reinit_late_sriov(adev);
        if (r)
-               goto error;
+               return r;

        hive =3D amdgpu_get_xgmi_hive(adev);
        /* Update PSP FW topology after reset */
        if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
                r =3D amdgpu_xgmi_update_topology(hive, adev);
-
        if (hive)
                amdgpu_put_xgmi_hive(hive);
+       if (r)
+               return r;

-       if (!r) {
-               r =3D amdgpu_ib_ring_tests(adev);
-
-               amdgpu_amdkfd_post_reset(adev);
-       }
+       r =3D amdgpu_ib_ring_tests(adev);
+       if (r)
+               return r;

-error:
-       if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST)=
 {
+       if (adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
                amdgpu_inc_vram_lost(adev);
                r =3D amdgpu_device_recover_vram(adev);
        }
-       amdgpu_virt_release_full_gpu(adev, true);
+       if (r)
+               return r;

-       if (AMDGPU_RETRY_SRIOV_RESET(r)) {
-               if (retry_limit < AMDGPU_MAX_RETRY_LIMIT) {
-                       retry_limit++;
-                       goto retry;
-               } else
-                       DRM_ERROR("GPU reset retry is beyond the retry limi=
t\n");
-       }
+       /* need to be called during full access so we can't do it later lik=
e
+        * bare-metal does.
+        */
+       amdgpu_amdkfd_post_reset(adev);
+       amdgpu_virt_release_full_gpu(adev, true);

-       return r;
+       return 0;
 }

 /**
@@ -5689,6 +5682,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
        int i, r =3D 0;
        bool need_emergency_restart =3D false;
        bool audio_suspended =3D false;
+       int retry_limit =3D AMDGPU_MAX_RETRY_LIMIT;

        /*
         * Special case: RAS triggered and full reset isn't supported @@ -5=
770,8 +5764,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,

                cancel_delayed_work_sync(&tmp_adev->delayed_init_work);

-               if (!amdgpu_sriov_vf(tmp_adev))
-                       amdgpu_amdkfd_pre_reset(tmp_adev);
+               amdgpu_amdkfd_pre_reset(tmp_adev);

                /*
                 * Mark these ASICs to be reseted as untracked first @@ -58=
30,6 +5823,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
        /* Host driver will handle XGMI hive reset for SRIOV */
        if (amdgpu_sriov_vf(adev)) {
                r =3D amdgpu_device_reset_sriov(adev, reset_context);
+               if (AMDGPU_RETRY_SRIOV_RESET(r) && (retry_limit--) > 0) {
+                       amdgpu_virt_release_full_gpu(adev, true);
+                       goto retry;
+               }
                if (r)
                        adev->asic_reset_res =3D r;

--
2.34.1

