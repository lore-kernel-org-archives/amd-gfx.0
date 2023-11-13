Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50AFC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 11:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D52810E35E;
	Mon, 13 Nov 2023 11:50:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4301A10E35E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 11:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nICBT2kmcO4GMJmp2i2Lu7mThB/PJqWWrXzvRNzJK+TPtQYYKB/v5xkaHH9aVDKHt9wpoJMkyFqxm0I1FgBNzMrL7k+wjGyiYd3fRv9x3xQmmzvVzGe8damlWGGX8swUCOkq2NQhyjDrgyXHE1HX00Ds5wRu4zih3qZMUzU5B601O5s6HLxf++eC22nRG/Gst7VkMaZzxbK9FMu2FsJdFcfo6lYOjXqyXT7KuHTK95eL45BELodY44qZFvh154yK6a0dtIA8/aMnbQ2vOOQELOvSwh8sReKZ/pqYeaz8+TAxA04wVNvqJ30bNjLQDjw+RPzlFlpsb4g0kUcawQ0aMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JllmCmhbXsBCxMELSm7hCJkMm5DsZRHc2yrrz9Q8c2A=;
 b=T87BGkKOO+iH51PZxUcQOsoOvy2ULbk7xXe3QNpva9PthQO/fQJE0CVUn1V/a+/TbDQB8sTHb6aGsY6onelMJ8J5icVTu2jOxyGrGS+6krWyOTc9vTxu8y8PHWhTiWu0/fm82QMNLgBocAPR2/l4nJnccu+DOayeko5Cnzy0UUk7jHXoLBiVMSZLzdWvRO2avB/TgirNaJSC+KeFRqfS7g7Qc1trswRcZrDmWMTqjNLiQEp6GRCrMSvhMlKqJ2pnUZjdmpo/pRrHftp9VXSmkIaDoeazQwkg/bkCmd/ZkuT+0wNuu74zGGlNpOHEU6Y9MxmzDVallGddIUs4F8XFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JllmCmhbXsBCxMELSm7hCJkMm5DsZRHc2yrrz9Q8c2A=;
 b=gomS7F+hoqJ/phEtVGgUlMiLdOds/Wfopejn32R6TCRl/q+ylR48DxgpFD4Cr8myFkQKtp2iDtHNoUTo2YsBsMazNFSDZrPXUhdjgqINTSppzLAV5xqvdRPQTdG+NWo5HU/TrTJMiTuOHXjJ1W/NTS9YOwmlkc6NMJJnu982P/4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Mon, 13 Nov
 2023 11:50:11 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 11:50:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: finalizing mem_partitions at the end of
 GMC v9 sw_fini
Thread-Topic: [PATCH 1/1] drm/amdgpu: finalizing mem_partitions at the end of
 GMC v9 sw_fini
Thread-Index: AQHaFh08HmpPqgacB06i7ofC1qDUTLB4Irsg
Date: Mon, 13 Nov 2023 11:50:11 +0000
Message-ID: <BN9PR12MB525785F6456E91F083ECDD45FCB3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231113103607.12366-1-le.ma@amd.com>
In-Reply-To: <20231113103607.12366-1-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=33dbe28b-23bb-401c-b3fd-2689924627b7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-13T11:49:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB6993:EE_
x-ms-office365-filtering-correlation-id: 2ec0df53-507e-40a3-f8c0-08dbe43eb123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFhOCxb5M7OJANkLYQsrKfihjBLmo8OI/FztR++cUic37nZsn32sC/0hF21jjhPIlgakfsqJ3wep0joMNhSFROsR7agi03ltuBDUedVBbnKufSwMrnpIiVoQ1L+x1OHjrmJdmFPzPRjcrIToon5yUyVhIQkxa0B2DX4APoUZKSOX/qgrqDJrC4RVZv6HZX8airkdm3oZzQtdun5gs8ryU0PCmiPlanIp03B0aCCLvB+Ar08A28H0KfzB2Q40PFHFyBz+qbZSmWQPnJ9KwovDS+ULVzjHgFgVIDSCYemA6IHfvMgRDnootvDxJEpEBJOM8l0knvyp2PvoV079mBwKYArq/Xp9lxZgcosG8WSmJQBg6nSJkrpN8rWgOVexumlYnBGBktFOBvQQD+fFdDDTMxRdMaJUi5oOnMnvnYAqk9KUphCJmHzu6wyW6YqQbH0Uh8uVBwUZQkUyPzTCiQtx094/laJDj17hwTh0YqYv0/an0LywBc0gRmVkRW+Va+wLMKkOQ0fP8Nvkeny4ymnp0GGIBqBZZqkHEvl6rvLHUkfLztRPaYEsgclHUabTKq9ehIBK+DQjIhJ1+p4y8XQZMcExvv839yoheXgtJ/Y1SScOIkzXrW4i8ZslIabuTJco
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8676002)(8936002)(52536014)(316002)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(110136005)(2906002)(33656002)(41300700001)(86362001)(5660300002)(83380400001)(55016003)(38070700009)(122000001)(26005)(38100700002)(478600001)(71200400001)(9686003)(53546011)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hEIjx0CIA4IxfcLZ0WMxaIRbVfLrT4XvVKwDcHRTGA69nGmFSY3EH07Hz9AM?=
 =?us-ascii?Q?+4clrZY3H49Fhe8sz7KlecF1gRIVA6CQNziubQH+mYroAxU20y69kEo1K2jh?=
 =?us-ascii?Q?zdiOqKe25P2L+13BJJfIQsQ7eDkBsNN5QG0C8M/wjBAZrpJMux9uOc1F7AQP?=
 =?us-ascii?Q?QcFjYOl28gBfCOtDgAj4utEbLgQ+Yik/v/XehSOTmHdSO/53siE843aWrlZc?=
 =?us-ascii?Q?Qqb7qmda86AI73Mu+JTI3wNZOtXudoLLwbzwEsbVxDHaRy3aMrCA0FLbuz2i?=
 =?us-ascii?Q?YQBaM0GrGApg1WZoJ1HzLQv4ZVIXffoFnQUfoa06RAkAxHdRMI5kREQJBPz7?=
 =?us-ascii?Q?QOzbXqPUtLU/GAj9O/AUojWdOuGCXzXIAByFifEOAnBpPYJgAcdQD3/Xlcsw?=
 =?us-ascii?Q?LSw4htE+4/zcOJgjO7gpgMjcVlZBtYp7aXfY5SUrtzB10ncd+9ZWJlBxBEF9?=
 =?us-ascii?Q?1RGlyjZ6EWBKccsmnyfZPaHZgiqTJ/TaDCrMzVJsXVpQ7nIIMIb2RteZDEji?=
 =?us-ascii?Q?siM7xJeAQq7sAzYD/unmgT9MzSyHl/JHgOik+sybngaTd7SQaqzrP+2pzXkt?=
 =?us-ascii?Q?bY6CrHBbMa0AbZgVEtfOjCcWa4FruDJjm4S4oNZcPNA1++CjsxYYYLCh8sMK?=
 =?us-ascii?Q?nNrxoXdiR06OARjBYxgk+u+/RB9AB49v62mqJh/DSyLJlmEYv2tDW5g+mPfw?=
 =?us-ascii?Q?27yeiLzsxAf9z+xUEn3Hwf4z2tcdRq3yfMSbYOHFWtn8/1mT7UE93AxLFY7f?=
 =?us-ascii?Q?Wose+RnQYptZQSkZ9UwrsLkFc7TTRaRYmQ3+eHImHqdbmvyUqOLP6A7vixjK?=
 =?us-ascii?Q?3igdan+9ldHHu/bw0Dyyurex0RmfkXoa+XV1MGjJE+QjJM2+LfRMLHyevZxz?=
 =?us-ascii?Q?K8VSsDJXBWzYSoQYoILlVxAKR/ESuWUdIEYyI+rUDfrAbu4aIghbZlZvsp8L?=
 =?us-ascii?Q?vrb7yVP194368kMUsV0KhPxhR00yKLRPE1JxeTCY0gRLbfquqxrzxjjJVhQ4?=
 =?us-ascii?Q?SnCETMxueuoWTZ8s5MXTD2t/OIh6vCHWHhlgRbigjWw6sYuK9nlN8KoVAmXc?=
 =?us-ascii?Q?qJJ5NOKWs/vOdoy3+0fCy06bBDJ9unfmAEtv+Eu86SJKqlJYVcayQspqi2cR?=
 =?us-ascii?Q?M1tHx0xkK4yzebksuQHySP4jOlNnf5lGYr02s/PATXsoqz4cztVvbkM/nPdo?=
 =?us-ascii?Q?xQsvyiLBLDtrxWJAOOyKSnTL2m/dLAz4NnphLnSg0mQ25yQPXxWz5JNp5Ems?=
 =?us-ascii?Q?3jHehnVQFaSATO2K/NAs1x1IWUDJxTMCt9tzeO8SFTimUNO9x7jkFtmgwRTm?=
 =?us-ascii?Q?H7KAsKvhnLVNLc8qxkTcknAKiUuA/bCOvMFIrMtmVDdryV9tzNxPrk+1tYBC?=
 =?us-ascii?Q?BYCyztUkoDBqdQj5E+WEr8DlhUUCwisuI2Uv7LYOaNsRotRp5YEOujW3KSgt?=
 =?us-ascii?Q?497rouChw+C1gXBrpzGdwgVsd0SvUI9pycV5oeQorHssaw1Kb+gBrDV9MzxQ?=
 =?us-ascii?Q?+38c005mSZhQ1Q3+dt4emyDvZCfegCKSdXTDOM42CpdpfRQpbMs+G/TVLjam?=
 =?us-ascii?Q?RYQVUjCcw/z+cEnE9rXVfFy/fW4RKwbNFtehm3ac?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec0df53-507e-40a3-f8c0-08dbe43eb123
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 11:50:11.3982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6/Yahb2YwSpoHd1KfKzcbrVwZNqGc7l9txjHQqnEmYcWFaA/WpN/HtaargsECzC0iqlUHxGLur4AUDzjQoURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Ma, Le <Le.Ma@amd.com>
Sent: Monday, November 13, 2023 18:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: finalizing mem_partitions at the end of GM=
C v9 sw_fini

The valid num_mem_partitions is required during ttm pool fini, thus move th=
e cleanup at the end of the function.

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index bde25eb4ed8e..c1f2f166f064 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2170,8 +2170,6 @@ static int gmc_v9_0_sw_fini(void *handle)

        if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))
                amdgpu_gmc_sysfs_fini(adev);
-       adev->gmc.num_mem_partitions =3D 0;
-       kfree(adev->gmc.mem_partitions);

        amdgpu_gmc_ras_fini(adev);
        amdgpu_gem_force_release(adev);
@@ -2185,6 +2183,9 @@ static int gmc_v9_0_sw_fini(void *handle)
        amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0=
);
        amdgpu_bo_fini(adev);

+       adev->gmc.num_mem_partitions =3D 0;
+       kfree(adev->gmc.mem_partitions);
+
        return 0;
 }

--
2.38.1

