Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BAFD3C54C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 05:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C209B10E364;
	Fri, 18 Oct 2024 05:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aumnVYBS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DEF10E364
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 05:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIjy16zs2IFrV7FHEsWBeqbJbHAVtQI1uH3LKoClrQMDsGEMtO7I+BWSB3nAowuhERtPo99y+L2l4G81dHC/Hz7k3QwzVLtfRY9xwXI+2eOxmCkRZ/sZe9zNA0z2qf94Pmoh2QAyJE0QSrrM0kddsAxyNnapMBgFyCjGWojpOb66OAqyr+hevQe9qqmqgQCJWCte36GefkN54/mhLS+RdOzrrgQ6xJDlSjaQwVvcYkEtO646HwKk5J4bwMicSkgDcH1CRIuH/TYOyFLlU93Px7yfWUf5knfqUsuKYLtRvEdFvQXGcBm3PAb/XaetBkqMbik5cAYi9lpoJGaaJ4cKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lGUFPjD4qOnV1YPLdBzGEM55z3c/m81Pq1D3ekQrqc=;
 b=kLGrbR8x9bYfuKUTYdXZnM1+2K5YDawqfmoh6xGplgxrtWYQrcMMs5YcGdmY8K4i2WImruS+zyoY67y24FB0Fv1sAeLtoxb2AuUIV2CUkppBux3nVFsOV8SKtRh8yceSES8Iiq4+zYN0cy5XbCVpIpHV+aE9yVC4+HqUSHdhIpy7X/9gOBcdIIKp3qkwrNG0VF4FbTQFFjjI0eibBzSwQ3jNw1HhP1Se7Bl7Ze1yLxtF0mLu6NLKA48bq/rj4keLXglulTUjzk5Gkf9uupoJpGrkKp0t/WbFrn+XB22ZpwlEM69ZoeizaRPFR1PtXEDUg1XELZGMErc9RcsRVraTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lGUFPjD4qOnV1YPLdBzGEM55z3c/m81Pq1D3ekQrqc=;
 b=aumnVYBSOM8StbuR7kkAaHCtWWZddCBU+w4rDP/W9XEHTA2X2J5ZcDO5H2/VG3OhfwX4nLc+QzCUB1yUOYdH0Mj6VUzgacT7rfGu8FZ00+QhP3NZOfi0Mpl2bQDFsB9OZvXiadfjrNMrne2VdDzK9wQksiW8vxfYDdrJsr8l6R0=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 05:31:07 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::bcdd:c459:3f9:5bb4%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 05:31:06 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to
 fence_addr
Thread-Topic: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to
 fence_addr
Thread-Index: AQHbIG98KT+by9y8V0y4SUCwBjXTdLKL/Kqw
Date: Fri, 18 Oct 2024 05:31:06 +0000
Message-ID: <DM6PR12MB434046E7907D855106E4475DFA402@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20241017083457.183631-1-Victor.Zhao@amd.com>
In-Reply-To: <20241017083457.183631-1-Victor.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7a85212e-c79d-421b-a9d3-4768edf4fcde;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-18T05:29:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|LV2PR12MB5775:EE_
x-ms-office365-filtering-correlation-id: 337ace8b-8c1b-4d26-326b-08dcef3610cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IOT7QqVl/eB1bnaJx1LAtktKFTQkHmunbhFLlaMrH8q9a/tL236qBgokv4we?=
 =?us-ascii?Q?XKXwUwKAWo9+b6Pmcv+R/J2MwvH9zHKNuVrdiDG6qS3jOHxaeRdn6I/C3+yt?=
 =?us-ascii?Q?NZ8KvEjL4bE6Yb3xxGbjqOX9UzI/pqX4YfOmjSFOn4VGHrUmJzWQf4NyTcyd?=
 =?us-ascii?Q?TaHZmjirFrIaeoi4TkaVJfgA77GKZtMOaWs54QtSrPKCn0bkXZgqPowC1pEq?=
 =?us-ascii?Q?lak+1jPt/oqt/JfxHv4v6FVXOMDw815Yze+JSB1K/TEVFk07i0FIEwt/dTUh?=
 =?us-ascii?Q?lUwt08rakdIw8Zpabw1N8z8/7f4W1PeguWsQadMi67ac5oL3zS2Wx28Gc5Ok?=
 =?us-ascii?Q?9Ay1JMVRwyEfmeg1KA5wSfDMVG5BHWHdAqRSBZRjbuzvr5tG2bhySGydxeSO?=
 =?us-ascii?Q?9kPF3QCsjCEQxn8JTkqSAXjH/GXNcHL7lf2uKFlRNNTYnt4HL+YQ2L07mp9Z?=
 =?us-ascii?Q?k/AMfFQJomzYZ48Ej1Cpyurz/OSu1renY+4LBSKqOeRt0QGNCbscH5sW+nCR?=
 =?us-ascii?Q?D6X1IdtmPfHwNmRxUt65eGmEEUL3nM6vj2+phtvA+Vt8BaR6vcfAArY7c+0m?=
 =?us-ascii?Q?yqcq/A1FLvgZvHlC8o+gN5x7h9gL+GTX/mxR/j13Qika8g7YGjas4wwMQgbS?=
 =?us-ascii?Q?WpWhguMlNxgYGW6ehZwFzhDsjPescjMUcko4tIvKMRhzAPljfGDBkmz6CdC9?=
 =?us-ascii?Q?8N7ABoNTVtUIKoWqdxsqTPpFs85dFXEJuOldybgDQAYpslZ7SeH5QGJYzHzY?=
 =?us-ascii?Q?VVDdLGxYHSQgN/2nbX7NrRYSJvE/gEFebGBXRYR9fQe1Bp0uvvzFMd8C8TEt?=
 =?us-ascii?Q?Q/onCLapJmQK4NFs93s1pQRAlhaz3z9z3nTRY6zWPpDWXd2nC5fojZu/Bexr?=
 =?us-ascii?Q?7UBdJdKCfyYXRSe5aSnvqXgGdxbGXb7Lyhn934zHL4fNwnWnWoAgsc7y7aDO?=
 =?us-ascii?Q?qwXY+ZOt05nw14pgTKbvKoyScpkf/bkGEbCG8tbGDtPhFRWNdBSF3Ue8Cq5B?=
 =?us-ascii?Q?sqqkwb6n6caMXPUGckVfAF/6b6x1YzLDNH8YqTun1ftpB5BnAq/VBNVNMk5e?=
 =?us-ascii?Q?YXNWjfmEaqD8GY836YhnVbrsqndw+i9EElJzFiH2TIoWLCH4BrtcYvp6cj39?=
 =?us-ascii?Q?5CKUug2nsxEV1/Gmyl/azCJl8F2nera8cAaVsV8ZZV0EaUwdhOJBL3WKXn/r?=
 =?us-ascii?Q?h+qEgrPQ7T45LFgaZ/M182AnQkfqw+Q0dozFWFlpOb7beMYiSRvT36dNo7Ai?=
 =?us-ascii?Q?ZwQfbwfDr/i1N3MqJw2sx5sNqf27wr2B85sFKFyFOH7ufBGZBUbycjc1g4Pg?=
 =?us-ascii?Q?D1kRW610Hsj5uDhgRO+G0dDnfRa8JUIj4zp/mUOiNpjxKszSiVHwvD+TXg7I?=
 =?us-ascii?Q?XU7hyoU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?24W5TLQ/j+ndT4CUOnhKh1d5mfFPbEneKqXl2yF/5tnC1imIh2UjqCLp+A65?=
 =?us-ascii?Q?IJOgBlnu6XkWBC2Y4b+A59jh6fyWvDfpdjFOTqanuIUOCgxOYSaYS8mrpMRz?=
 =?us-ascii?Q?fr9AAKSJ7rFBJE1BSq95zNBRZvK/HdyY2FUg1GaVwXCihOH3thqkNivWKiXj?=
 =?us-ascii?Q?ZwrG4JJvHF0nVQjA9yOQ6tEKO5F4FeVzui+8jz3vpFtrTtG0K+PABFCNbBwt?=
 =?us-ascii?Q?LsJbJNblYHbJVcYeL2qck8/hQWEHJYhe85RVCpmdcF8j9NuXh7aGzExnd0dJ?=
 =?us-ascii?Q?Lo/MIxXRLeNZlzLcyagr/ln0ZbvN86mgkbA6EdGtaYZCFN72akB18aMtLgEU?=
 =?us-ascii?Q?N0cPN2n5NdSrdoRjzCOVtC9afew89wYAGGgM9z2JH7AQ7O6ShA3Nyv7hB1tU?=
 =?us-ascii?Q?UHAzSIG5G/dz8Frbrod3jzkcUGzSRm8dnBsuzaLTX/ah+drfGvgu7T37Srbq?=
 =?us-ascii?Q?3/udw7dNdt0yPhNYCRfVuwu7O3+FjdKrI6pzd8aD60E7IgayRWplmsU9HaqJ?=
 =?us-ascii?Q?+rCALjHI/4k9pdHMfAGY2AU//xKm5JS8+GVYcUmtU4zpRnFzsg3zfTvDPVIR?=
 =?us-ascii?Q?VxJ3yfH25/fSwKfGwyHrWwxb1FPZGYiiGx422Q/zj5HIwsTzUfv4LuqHD24d?=
 =?us-ascii?Q?mfwVOROFaMYjjXi+RqrUXGoT8Y+98rhOK5CbxUZEz968gdakB0NpgSt+oC8K?=
 =?us-ascii?Q?stIqKzZgX09y0etVRCRB+07+MkDfFymm5Y964rBTIMx0yqAIFRt5wCk+yxgx?=
 =?us-ascii?Q?s4WNc5rONmKL7rOo8R4KiKy9NPLAE/K4qVo/VuR8/NFt9V2UmrHz1Jt9oq0V?=
 =?us-ascii?Q?BVd0yaepFjtfjS3ImGpLN3wDlX2L8MedSI6B9Xd0wlHl030WH8xwWP0lbQos?=
 =?us-ascii?Q?VcpUfin1hw16Cx+DWU1MQu2WRqlBfjJTIaPQr3mXp0Pxp81WjSOL+x3L0LuR?=
 =?us-ascii?Q?f5MuJBBFe90RYWaRS1tRG0bpn5yf7oydcIMhCtlqSzqgVHyoCN1qbEeG76kW?=
 =?us-ascii?Q?PCHAbmdTC4DMd69ozwQDiTkxkMVYvrqNelx8UyHHE2tmHA7LrY5LObQjo1l6?=
 =?us-ascii?Q?vRSBmfPOPBY9PoxKeQZJ7NYaz/Kpq8q5ZGKYIMFh+XvXDx+30I2hGlJXSraR?=
 =?us-ascii?Q?QGmXg+YvEMXDv77nerjUC+TaJT1V9rzmBw2FKXQ08PEJgE6DwmtbMCUCHegs?=
 =?us-ascii?Q?gQ/XDaWN+fAYw30DU0Bk2QX6HkD7xztEICbJY08y/EmmlGElxmQYlwolS3CB?=
 =?us-ascii?Q?1Q4AgJZqnEmAzwx/fr3Kj0A482Vsshu92mmfh0+qnZxfs1q9whOS49lS9VCL?=
 =?us-ascii?Q?Xqvfd4DXoWye0HTOc5T52tW4BOyx6VgjI4vvvikZrjy7FGna5B00q5qX0E8n?=
 =?us-ascii?Q?b9opDFxcswlmdJEgp/JQ9sUVgcBrPwfWChvlBHI6eVa1KBFNiJ1kGOOAx02I?=
 =?us-ascii?Q?hWFJRdqr5Uqt0oUVpRpT1J0p06b3oQv6WPPmZnzL8K62pYewScUb/gaaWKVx?=
 =?us-ascii?Q?FtxdxvJl4fadKVOrqVvNO8IHG4TfP6i/rvRUybnk2SIh6tH1ClLX/E/3xL27?=
 =?us-ascii?Q?6fIsifrJKAKGdKaIUH8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337ace8b-8c1b-4d26-326b-08dcef3610cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 05:31:06.8559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/UZuAg9ReJTzMpeeqEyWLLtKafUXt1Xfq36uN6tXvMWU3G+zE0+cWWScegRbruO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping. Please help review.

Thanks,
Victor

-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>
Sent: Thursday, October 17, 2024 4:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to fe=
nce_addr

make sure KFD_FENCE_INIT write to fence_addr before pm_send_query_status ca=
lled, to avoid qcm fence timeout caused by incorrect ordering.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +  drivers/gpu/d=
rm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b2b16a812e73..d9264a353775 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2254,6 +2254,7 @@ static int unmap_queues_cpsch(struct device_queue_man=
ager *dqm,
                goto out;

        *dqm->fence_addr =3D KFD_FENCE_INIT;
+       mb();
        pm_send_query_status(&dqm->packet_mgr, dqm->fence_gpu_addr,
                                KFD_FENCE_COMPLETED);
        /* should be timed out */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 09ab36f8e8c6..bddb169bb301 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -260,7 +260,7 @@ struct device_queue_manager {
        uint16_t                vmid_pasid[VMID_NUM];
        uint64_t                pipelines_addr;
        uint64_t                fence_gpu_addr;
-       uint64_t                *fence_addr;
+       volatile uint64_t       *fence_addr;
        struct kfd_mem_obj      *fence_mem;
        bool                    active_runlist;
        int                     sched_policy;
--
2.34.1

