Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E8EC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 07:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37EE910ED9E;
	Sun, 28 Apr 2024 07:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5gc6SPM6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE7F210ED9E
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 07:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm/9dB3DM/jPFQpvNqjAMo8oZyfxqtzZeDR377n8CfSiWcV/CSFQ48Tv5povmw4VflQrIR16I/Azk7JnwHEt3jfqVJ0w2lwqXuPGj/ifXYncYocPquiSTG/7rf67DMyAUm/PWafPLlWkY+N+sIVaBZ2eOKXrxFymxMNXP5VhHnIv+WkxJSwwRgJbtgg7c7/i+27QdIVsDyxdpgzHNqd4j9wvilaiEJULO/5T+FEIwV9yK30QDEJZFGOtp9iWtzuc9N+ibkCaa+qF2hTLuuV0kHYgU4XILi3ipfVcBwuOEfYwNOSw7nkP5S2UYvnBaDej0UTxgxudH6TPmzMgfniJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbrFEoP4MDFP+OLoOszGFN+hJw9heLNPu9/Mvjyzixk=;
 b=D8/Y3DemxZUquyV+FsNsDNex4x6rx+Hm1lH9sJD/f60QubxYHdF4th+8Qcnn1wdl0Da+Hiyo990yv6Xv/ekrGxAdrCVaS/9ti8zeedii5M46AKgSvEUQ5r7M6I1Z5JmUCxA3CzIHq/BzYwVcn0/HAsLhgICtAok0yONW40lJbDdgchHqFf51EHgihVD0I3DiJFIilp8LVvtm77006m+DMygUcJURgTiQnuaAvQs4eLOfgFNrQUWsEO1uVRVT83l/6Jk+0XbCStxYIxstjbfmfujloPrzI0GfG75pG0Z8Tfx9zvznH9kMZY7d+BE/kwK7Xu0ALiZfpec2RqA7gf/5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbrFEoP4MDFP+OLoOszGFN+hJw9heLNPu9/Mvjyzixk=;
 b=5gc6SPM6C6LV69oz0WhF71naqI5qp4kf/Cd1HfO+Um9wM3DpLKPb9LyGVKAqeM7WnQlwc6CzY8f4Eujovceam69RpKmUCqwXmxnejuzy7P7QAvfmM+pYEeSG85lGCgJ/WdJvFnGkFbyJvF4QY/b+xWW9ZJTNgwcqPu1VPPyXdIk=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 07:16:05 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 07:16:05 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v2 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry
 logic
Thread-Topic: [PATCH v2 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry
 logic
Thread-Index: AQHamAezkEjc/1jsfkGQZHCad9kQDbF9R3qQ
Date: Sun, 28 Apr 2024 07:16:05 +0000
Message-ID: <PH0PR12MB5417BD456D1006F8BFF686338F142@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20240426035742.90560-3-Yunxiang.Li@amd.com>
 <20240426182928.98181-1-Yunxiang.Li@amd.com>
In-Reply-To: <20240426182928.98181-1-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a9807d50-2f3b-4cf3-a9ea-075bb5797585;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T07:14:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|PH8PR12MB6841:EE_
x-ms-office365-filtering-correlation-id: da930ef3-5ae6-44dd-f53d-08dc675311aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?6liJuMmcspFm8aDBc4bRJmhiZ0NRmQC30R4Iyn8/qfPOsURrupA6jeQQ/Cdj?=
 =?us-ascii?Q?iuAScPomV5k3oWtGO039455u0PlCXrx6ieo5+P128TbS2DFDSj2YTdBX5DgU?=
 =?us-ascii?Q?muXE5RTd9q56NKmeF635GKKatb/12Kc3SXzNsBB24fUzU0Axt+7TdAEmj1kD?=
 =?us-ascii?Q?UHxdAv2VBeV6pzE+mreU4X9i39q3pie5xB8bTJ+BN/Zmhlpy89TClLMSmp+a?=
 =?us-ascii?Q?pSIcGsj/zL6QKdzMSZywV+rs6V8payaM4Pdn0FBPeOShwAoE5mI8JqTTBU0L?=
 =?us-ascii?Q?TuqZhcjekjD41CDDVGZx+5tETu74iME1Cx60XZPYXHW/Ihr6zCJ8IUTTwrmu?=
 =?us-ascii?Q?24ab/ZSbUfNzH74Hbw4TEbCHT0wL/MXM/iwFsGaSLUksZOKcua2iY4K/MOPN?=
 =?us-ascii?Q?dI8hrwotnvexovME+F0+t4xF3FylHX13FNkE0og+s6mK3H/2nZYiWjxz32dq?=
 =?us-ascii?Q?mKRu0Fzl87yDq6vC6USfK92q6AgZImjFfzseACLwWNlpcSkCcwAabAjKyFfo?=
 =?us-ascii?Q?w9ow6w0Ncc/985jCQHF2SOJZk785VU69t/DSj+DQ266rWpe2vGyIOrnDWECr?=
 =?us-ascii?Q?LDalLvXTAs+cfus3Dd1UfYbAgcuxIrFADOkMmMMEFvSbtqBxnKWC5vjPoQpW?=
 =?us-ascii?Q?Y2w+bGo1lwTv5cNWxXtf7pK6h+oZPpGynRsebAhij6HHXUBijKesNqZNtACT?=
 =?us-ascii?Q?lLQyT2UAXRsq6V/k5pxTYQp9mFDmx8tE3JoXQ/Qj7yzp2RQrzJIdJ4i/XSkL?=
 =?us-ascii?Q?efla8bevGHV+1w5qoehjCJLlQ1PZGBUezc7+dMuo4S0jr5nONZLswV+nzjwc?=
 =?us-ascii?Q?hroy8Jec/AOxelEWJgVIlZzVPfaLtaVRofzw/UiL4C6k8rKOGun8WKxnukZn?=
 =?us-ascii?Q?1RlG0dK4roOQ3gwUfkHy46QJ/aiUrRFwh8IwrEyXwE8KBJYeL8WApjZf8y9S?=
 =?us-ascii?Q?+yoQj2bq2ovPK8oyiKmmroea3aoeoGX6hD+P+6/352vtYwCFvpTYAd/FAuLs?=
 =?us-ascii?Q?dMV+kHik8GSexkzzf2R3Gs/HLDbxL6PAA9s9mP+rhEVYhSsifcfvliFUJMru?=
 =?us-ascii?Q?1kWcIIdsIA/kq+Dg06+wHYGk+P2jB8Ct1O/HrobDgUJxDH9FHuaOXJ+HvQs7?=
 =?us-ascii?Q?kfBTLqSJmmpHYZlbtk5JJw8uQlG4WQEdzr7siy81UNG4FqRobfx1jfemrKeq?=
 =?us-ascii?Q?WG9/N9dPmsLewxu8NOxAtJ2qQiN1gETVnrcngixmJx5kbry4JSAMQGAzBYWs?=
 =?us-ascii?Q?Xx53joXS/vzCL3tOt4bFLq2D7/RTe+/6aeqg1TIS2VqjQRCXXsm5jz3tTvsJ?=
 =?us-ascii?Q?XPZDP2XiPIby9/syRMs5N9ftyKpnGMJonfT5ksClZYQQ2g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X0Vpu4LEqXs2y2T5NcfMv9TuhE8RiuDdP/P5+Ca290GaZ74L76vN7pG+6PiV?=
 =?us-ascii?Q?wcwBE+2DzPPSHZkMTJv0zaA0OrYk/6b448IpNkeG7OCL/a0chOTUGcvjq3Yr?=
 =?us-ascii?Q?S5ko71iJdmOS6TNGpJSlBx8hIVKa9qyVhne0Nwrv6cMNQCpFqM6e012ZYvy9?=
 =?us-ascii?Q?wQnhKGPNerAcqmKvb+8X2lIsjrc7hWNnySFU8zgAoOlhKn/F4NkPiDCfTzbC?=
 =?us-ascii?Q?vLPHOIoD96E/270s8J6Hl60XM63ucTNtoTRyZ3E/d8FAYB6XPHhfWybM/x2B?=
 =?us-ascii?Q?piuBH/NrhrgMwsQ1HjZvsdtsgkcjfBVLCWJ0B7VM2s25kOX83fVWNayLzMGV?=
 =?us-ascii?Q?Wp/wiN+OVscsGtzjy6HqnTvz6O7iDvdij4UuXpLeGsUCEpD4wleul/jKWhhR?=
 =?us-ascii?Q?+R1CAzRueKr7zmZAQZIpwzwqpTJjKkAPhB17txlW8OQdP+ZRzYkJKlwtZW3T?=
 =?us-ascii?Q?T2NnvKq54KzZj94R+cIrdcrwHbODj9ILbS8C78KgPqIYaqzpIgWqMnNMWPWk?=
 =?us-ascii?Q?0p43rBnyQ2XXeFQLUPpwaOkOYTQ6Yj9yXLYD5F7UNC+LPfDJdyAbqq9ztlf6?=
 =?us-ascii?Q?iSGLAA663WPLMXmN4jPApvDbGekp8+1NgCGmJaZjNxP9gE3aTX4+m2wfANIv?=
 =?us-ascii?Q?c3I5GJjPuzN5C5Q4OJ2019xVeXtYFUtoPKG/P409wCiKSkaqH7XQE7YRFtFx?=
 =?us-ascii?Q?inYbD/W7duvOKYPgGLN2dwc5bY7iXh6ZtaFAHD1KoQxKV2jJMuItmH6hDMKw?=
 =?us-ascii?Q?2KLkYgneJi20PcmAS6UkSRFV4RSE/sDu8wsu0W1D4FjGqaqSvV2dqvzfGvER?=
 =?us-ascii?Q?j+VXUB+FFpeaEaw2ZepFUVQ4p3F4aRmDJd1Kl5JBYFjStJqeTuw5oR74ByWg?=
 =?us-ascii?Q?XcWQ98nhbEe0zva4c4bX4Un//AOyf64pvzJpKLNUtvgGMLTgSV6qIulj6Bev?=
 =?us-ascii?Q?4CN4WZMpvPoutRyEPl2Pdq6GGdXrkzaHV+7LsMA07cIu6LBWnn5GPbXNWD36?=
 =?us-ascii?Q?utpWElQxfJKv9ySTm3YbY6NiST8xjvmzL/YOHGnrpk7/6q4xrHASuxXubTll?=
 =?us-ascii?Q?ppFKd6hEdtlnVoxw0HdE8qbooiefrqB4v/zTh4lbSxewxCcTUFywDFscLtDv?=
 =?us-ascii?Q?KZvatykE51z5Ls+UQgkQKXbCD+1s6ztcqfX+BHYJj1RwbonMbJcifF0gQu52?=
 =?us-ascii?Q?8JqgrLcV+EuaEG+SDwXVzktKDRz3GQpwlk4a5SmZflJOWh3L59v2TpXURYNq?=
 =?us-ascii?Q?MXMNcMWt8WrXzPSw5H+fQoa/Di+Uds8T1JRRMG2eWnDcSLxVvvyhjUqgr78t?=
 =?us-ascii?Q?aA5FC+6MiZth+ZcAmZ0ge5vyWmrRaBbZo51q2E6Qdwur4+pK5zs2dLZ8OFJA?=
 =?us-ascii?Q?Fv0rWNqDRUWdlyTw+xzsPDWrSJxjbNkjvOgzaUNwj8KctS2yHtXvyPKOy3f/?=
 =?us-ascii?Q?HIvVvEPtH0hYUMziPGis+KG2EKAsmO2fDIDjRhrukfkiCHrFB1g163Hzu55C?=
 =?us-ascii?Q?pQpGwwtafGEyPE+Wg6eCXdMqsFLPcduChNSETbK6xsB0wFUXN/l6T0MUvQk6?=
 =?us-ascii?Q?OGel0kwFmCAaiVVuMJg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da930ef3-5ae6-44dd-f53d-08dc675311aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 07:16:05.6039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQUNqBBC40LkjNd6LTOxonHLV6pZiN1ELYlvzIzTQoT1fAqsVgB75nKcWXGLSB2T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
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

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

Emily Deng
Best Wishes



>-----Original Message-----
>From: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>
>Sent: Saturday, April 27, 2024 2:29 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Kuehling,
>Felix <Felix.Kuehling@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Li,
>Yunxiang (Teddy) <Yunxiang.Li@amd.com>
>Subject: [PATCH v2 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry
>logic
>
>The retry loop for SRIOV reset have refcount and memory leak issue.
>Depending on which function call fails it can potentially call
>amdgpu_amdkfd_pre/post_reset different number of times and causes
>kfd_locked count to be wrong. This will block all future attempts at openi=
ng
>/dev/kfd. The retry loop also leakes resources by calling
>amdgpu_virt_init_data_exchange multiple times without calling the
>corresponding fini function.
>
>Align with the bare-metal reset path which doesn't have these issues.
>This means taking the amdgpu_amdkfd_pre/post_reset functions out of the
>reset loop and calling amdgpu_device_pre_asic_reset each retry which
>properly free the resources from previous try by calling
>amdgpu_virt_fini_data_exchange.
>
>Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>---
>v2: put back release full access and the missed return
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 47 ++++++++++------------
> 1 file changed, 22 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 33c889c027a5..b23645f23a2e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -5065,10 +5065,6 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,  {
>       int r;
>       struct amdgpu_hive_info *hive =3D NULL;
>-      int retry_limit =3D 0;
>-
>-retry:
>-      amdgpu_amdkfd_pre_reset(adev);
>
>       if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
>               clear_bit(AMDGPU_HOST_FLR, &reset_context->flags); @@ -
>5088,7 +5084,7 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
>       /* Resume IP prior to SMC */
>       r =3D amdgpu_device_ip_reinit_early_sriov(adev);
>       if (r)
>-              goto error;
>+              return r;
>
>       amdgpu_virt_init_data_exchange(adev);
>
>@@ -5099,38 +5095,35 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
>       /* now we are okay to resume SMC/CP/SDMA */
>       r =3D amdgpu_device_ip_reinit_late_sriov(adev);
>       if (r)
>-              goto error;
>+              return r;
>
>       hive =3D amdgpu_get_xgmi_hive(adev);
>       /* Update PSP FW topology after reset */
>       if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
>               r =3D amdgpu_xgmi_update_topology(hive, adev);
>-
>       if (hive)
>               amdgpu_put_xgmi_hive(hive);
>+      if (r)
>+              return r;
>
>-      if (!r) {
>-              r =3D amdgpu_ib_ring_tests(adev);
>-
>-              amdgpu_amdkfd_post_reset(adev);
>-      }
>+      r =3D amdgpu_ib_ring_tests(adev);
>+      if (r)
>+              return r;
>
>-error:
>-      if (!r && adev->virt.gim_feature &
>AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
>+      if (adev->virt.gim_feature &
>AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
>               amdgpu_inc_vram_lost(adev);
>               r =3D amdgpu_device_recover_vram(adev);
>       }
>-      amdgpu_virt_release_full_gpu(adev, true);
>+      if (r)
>+              return r;
>
>-      if (AMDGPU_RETRY_SRIOV_RESET(r)) {
>-              if (retry_limit < AMDGPU_MAX_RETRY_LIMIT) {
>-                      retry_limit++;
>-                      goto retry;
>-              } else
>-                      DRM_ERROR("GPU reset retry is beyond the retry
>limit\n");
>-      }
>+      /* need to be called during full access so we can't do it later lik=
e
>+       * bare-metal does.
>+       */
>+      amdgpu_amdkfd_post_reset(adev);
>+      amdgpu_virt_release_full_gpu(adev, true);
>
>-      return r;
>+      return 0;
> }
>
> /**
>@@ -5689,6 +5682,7 @@ int amdgpu_device_gpu_recover(struct
>amdgpu_device *adev,
>       int i, r =3D 0;
>       bool need_emergency_restart =3D false;
>       bool audio_suspended =3D false;
>+      int retry_limit =3D AMDGPU_MAX_RETRY_LIMIT;
>
>       /*
>        * Special case: RAS triggered and full reset isn't supported @@ -
>5770,8 +5764,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
>*adev,
>
>               cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>
>-              if (!amdgpu_sriov_vf(tmp_adev))
>-                      amdgpu_amdkfd_pre_reset(tmp_adev);
>+              amdgpu_amdkfd_pre_reset(tmp_adev);
>
>               /*
>                * Mark these ASICs to be reseted as untracked first @@ -
>5830,6 +5823,10 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
>*adev,
>       /* Host driver will handle XGMI hive reset for SRIOV */
>       if (amdgpu_sriov_vf(adev)) {
>               r =3D amdgpu_device_reset_sriov(adev, reset_context);
>+              if (AMDGPU_RETRY_SRIOV_RESET(r) && (retry_limit--) > 0) {
>+                      amdgpu_virt_release_full_gpu(adev, true);
>+                      goto retry;
>+              }
>               if (r)
>                       adev->asic_reset_res =3D r;
>
>--
>2.34.1

