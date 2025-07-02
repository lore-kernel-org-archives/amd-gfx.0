Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22502C8303D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 02:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DA610E303;
	Wed,  2 Jul 2025 02:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S8HOJwYY";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1090D10E645
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 02:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiCNzEvP9GJG/yhWpQrEmgSXY1k6p6zi+HOu1UXnXfsoNrqtiaiA1mZU+orj9edLGE0EkgzK6ItK5iJU4BJkcUU/Omr5qVuJ5HucumLe7gYj0lZWHCONXb3YhrbC4Piy4T0Rh0KnK5h/v0ROi1l89yeJJrh34qv3DHqaFkUwLF17HBbk3E02RZVBGveNvwOYT7FMY48gCwgsuiJMtKOe0bWaVx4jiReXYmuweto5R2nW3n9KN0IdU1WOweFcPMftgllw3JfuiLus8OgKIzrH8q63H8DM5hET0RjC3dcSkeEpgDFVxemALRpq0z+WrB2oKwWAyXYxasGWKGLzpaLIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM7nXtm4gxb2VrQuJzFqHnaPmxH8l4dxvjMwRCCHxmU=;
 b=ymOl0TLYfYjfeT9w+e3+GGEaPSwoNBBwaNddBxRjnKeRS/82eQ15vWr2swjutZIVJvzC6YIHVE4MUvag/9H3piYLwFq7iLB6GZQrpl2jk9Z1JZZlvF51sy7LeRVfIx5Dar3L+N5bvnefm3pl5pXc6eSrOLQMAoMRMxpbLICBU2qRTloEmiA0iECejl2MD9r99nlwihIo16OTdI9rpeHJh3/1Qvpny+SCwgdKgDfQ/dgM4wymLMimwcskudwhb4Br6kd1tlG5AXhL+1v1Q1BEH1nxA80KzjT037naQSb0Ht4yaM68X7WCnAt17I2odYP4sLwW2IY5URwHXvLI2vaE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM7nXtm4gxb2VrQuJzFqHnaPmxH8l4dxvjMwRCCHxmU=;
 b=S8HOJwYYiVn6IyajxVqlRFLRhP/ckUSwSKPwN2MesN1PyXeStm2eKWinX+B5jyBeFggZqjpUF89p3s4muMh6m9Vr6W+bgZ+J/EFYejlEWXgAW5c/Ml1hakFcESkm2pFiiVuwaXOrHBHQiCps94HBfVkcY3ehi4RIKAFZSij3C3M=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Wed, 2 Jul
 2025 02:45:45 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 02:45:45 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 01/28] drm/amdgpu/sdma: consolidate engine reset handling
Thread-Topic: [PATCH 01/28] drm/amdgpu/sdma: consolidate engine reset handling
Thread-Index: AQHb6rhMMgnpe5lYVUS5TK8FC1SACbQeIVsg
Date: Wed, 2 Jul 2025 02:45:45 +0000
Message-ID: <DM4PR12MB51520DB904905176083BFA68E340A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-2-alexander.deucher@amd.com>
In-Reply-To: <20250701184451.11868-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-02T02:45:40.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CY5PR12MB6371:EE_
x-ms-office365-filtering-correlation-id: 918d0f21-701a-4a73-c4e5-08ddb9128b67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cpF25pVE9ARPH36PPElNWl5MJwmif59QRfXUA6DEu+0Tpo8FgfISiPxaiNCR?=
 =?us-ascii?Q?Wcya/zavu/jW3BxsJ7I3IW5E07k8ajezhD9s56/E2hxrhU80IjyZk3bH+oEW?=
 =?us-ascii?Q?R8yGXTEamdx+PSo2Cu5eZ6+NW19jRx2xMq2U6gioFAEv2C8hSJdYBVrJjeQs?=
 =?us-ascii?Q?hhKDymTYs5EfEY7+Fb+p4siWL5zLtud1j02//YBjBfV/9DNs/hiie4q6q4yJ?=
 =?us-ascii?Q?b68sTZ7P0A6hg4/7UgFhrwor72HUem0op2IFEhWm1Cvc5Cbij0XEr2KsuILm?=
 =?us-ascii?Q?rj6I5UzFU9Mn5MWgl1vs/Axk13Zg8hjhHtjrCbj7ou+MQ8Lkzj9UabFVm1M2?=
 =?us-ascii?Q?Jn8lJfQFRZF3aesBlYO4Xc5YAlKBv0EZkecKJmdcAwYJDFTApM7N+J4gSbyk?=
 =?us-ascii?Q?cGg3MiKRb76dZfSF1TL7Llg0hkQXYXO2H5SGQhSGASUh9Rm6nNqvQVLgpC+L?=
 =?us-ascii?Q?xMU1t5HJgGLDT/yzRkJoUHb3Qeukyvj7CG/HsIWOZUpHY0HeSHCDCsmnpGMt?=
 =?us-ascii?Q?SDPLI9J+nnkypNEsv9QG5TWcxL4vuAm3txGqFc6cDUShYxThL7/pyg8mJ5Lj?=
 =?us-ascii?Q?szBnKpZVm9Q8yFjurdtABfzEqa0mqTyvfkuoJQ4ZZ9MAhzjtzCEGfsihbDkF?=
 =?us-ascii?Q?OVKjDbLNtF72vnNBldNwwpCLcdpCNzwGN7wlbr6A25sfC+domIw04V7GH3Z5?=
 =?us-ascii?Q?0LbpItBmdNp0+HRyl8Kxe6VD9z95Nr3CgX6FfmRZOldrklvf62JhSPb3fFCq?=
 =?us-ascii?Q?fv513czEiqCadYI18DOlbuElSpVqvAcDe6f8T8qnEpPEN4oeckIf1OZjSb5b?=
 =?us-ascii?Q?h3ISfAbHu/kazc8niVf7i30fS8jwypamuI/sRsFMAkB51/R2cIlMk02FGRCt?=
 =?us-ascii?Q?p4vQj9R22fyLeWpVMnjlKFf2E6itb0y/dMgPuAHwFfPmI7WFsCWzHSkOh/B6?=
 =?us-ascii?Q?Kl9pjVMCr7a1lksoQHfloN+ij1+WMLMMNu62C3a5E/yOU3IuQte5F0cwwZ72?=
 =?us-ascii?Q?BK2DPEix3nFJldABbOZmEPzuwdRGEEywKWOnxAv5F4PCnYdAGFLVtyF/v7Ph?=
 =?us-ascii?Q?mk4YTUJrLTqEdNGfc8ulwoeZJyD4X5SwESeSCnDAFGvtc22q7lGPylC/12BC?=
 =?us-ascii?Q?eBOQ94XMowaGumAXyz5l+U2xuuLUvbn5jY0XJizDmC1cH00izLqRiibizq5O?=
 =?us-ascii?Q?wtSaAXNRyDZpgiAyG3mrkTKZ2dPxVyIWLtqk7qCEYZRxfTzEtLD74t2s1RR5?=
 =?us-ascii?Q?EHfS6w0lSheRn0rJyFnTmFj2qtA/mHeq/f9djH2XC+zQAt98YI5vu/l6k4lr?=
 =?us-ascii?Q?ZgLt+kSJz4jN8O4kc38BmLxVUu1h1Wq0EDOVzY0v/xBLqL8ScSiTBvVyZ76V?=
 =?us-ascii?Q?n2eXwgEx8YQw9tYZk6SMfJ0Ki9uF1kUHrmQ2jGZk79teP9oqj+xmqIoosacX?=
 =?us-ascii?Q?IQ8rKOjmb6ONvxQxecRjQ0tYfQ+9dsCAOvlLG8mUaQcZeXDsPj8+/W1xagvb?=
 =?us-ascii?Q?ZEVUjdZ8ldE4z7o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gL0ROSclbjZ1dWaFzlhI0QaebEzxJmWx6kb0qrKBnAS/YXengWXSXDD+X5fy?=
 =?us-ascii?Q?p6nAQ9+E+gWOWk4N5hJQOxq7XcdIOM6giSOs2A1P7BsZyzZokcY/ZrrevtYa?=
 =?us-ascii?Q?H5/Kjb7dfQjRwpDhyEUrmstQArunZskoBSv1YffcgtK01c55K414NOUXW9Os?=
 =?us-ascii?Q?jw8BGOvyz0lyXHyong2T+ok8KDe7MG4pc8nRCwhs5rqWULQp/+kA32AixiNe?=
 =?us-ascii?Q?bw8KDvd5wOlbhHlxxC1Ol7WQJjGxjVmQCRDd1HMPL6YaQYUOhW5UIEbXIkYF?=
 =?us-ascii?Q?Y80SKOna9Zh4sBgvtBU9O7Grk771rihJmyez8l28Oj6XE/XUk+wM5/KDudv4?=
 =?us-ascii?Q?Yrq5ldwZjD/4115Ez7gqkzgbyEt+YHhr38ZNyznd0mK94A1rSXBPfowftgF5?=
 =?us-ascii?Q?+n4L/1/p+Nr6FhKZ0rvc566qdnEh6bluHPiOdtFhndUa8HLB30ElvjxxJEsC?=
 =?us-ascii?Q?eZceQqUzt0I02KPKXZ818uuHM1DGOXwy0jy3qZXEN3XjXRMNOJl3sdEKPPbC?=
 =?us-ascii?Q?XEoZdLjqlZA3XVcJAlqA2p8XAKCZFuhXH1a4LccTmKRxNgrr+wFz+xtAFjKH?=
 =?us-ascii?Q?+pQ+Ni+J73qDUrlN5NzUye2IdPlMBiXX69cMYrxwhxqPdLoO1//CwfBVW1C5?=
 =?us-ascii?Q?GlWO2vCYPcE384vRlV90nq/MCEbe13o/dBDX3Ly0b3ePpMvQr73tKNOtVjHx?=
 =?us-ascii?Q?GpaIpFMPz+RVsvHgT3m8Yqni3tQe2tdEx98i9yVbIbgTmXZvWzTDHgV3fNLB?=
 =?us-ascii?Q?3AeGXqqXRzJYBVRK84YI3RPXc36In4Akifa8apj1mtqHB3GvVQCGjqO+lBin?=
 =?us-ascii?Q?FuhHj5Y4UEnEBPGIZ+rMWhWSfmsfT2fKh6FHlUvfharoJhu/N/T0rSMextFn?=
 =?us-ascii?Q?qKBGnMs6U0hdY2F4ELjBhDdWdVOLlLYONLyCSgsSRdK2oz7PVKlmSffdWQAC?=
 =?us-ascii?Q?JIhnsCNKgZkILPADP2G7Uq8dzY6cxfhuI4Ak0QHd7kP4vQ+e3D5EPiWyEx+Q?=
 =?us-ascii?Q?kXtpeIrWKX8UB0OcJuEPRv6WTwD7xLThwyLJ2BtdL8VZWoiYjniBANFI6i1m?=
 =?us-ascii?Q?yuSpaBR0GUJq9nAl0NuI8AdK/4jKV7xouySsdPFDVu+OsuhibskS5lTK769a?=
 =?us-ascii?Q?+HNp0ikce2G1b6YMwdpniWJ7CaEFwGKo1HJFxdR+yvIQnVsyAZr9cpj4tQhx?=
 =?us-ascii?Q?F98X3GkHNY2a2CsSBdJFqE819FHUU6OKHapd9K2U5Gj8693FHN1UBaV2fkHK?=
 =?us-ascii?Q?nKheTAetRWiFv83OrkwqEvLi1MZqLzqO1+abY053VckSlbFi98jWYJwoqr+U?=
 =?us-ascii?Q?WiHIombUELCjeijZ723hzGJrMdzgOYwyqJmcYgyoynx6oZwKrgTlltGaVPJn?=
 =?us-ascii?Q?JDU8P2pqq9Ah3Ogf35+ozGzVlER3U8uBOVO4Ys7Di6VJDhf9IskyjKeFgWqq?=
 =?us-ascii?Q?+khTiafJmdf9HZTouScIl6nP4QMY5mYGLTJBGHl4iz5QYY64SttmbcBUyEdx?=
 =?us-ascii?Q?Uu5CCfzz4BHSKzFlVHpYA4LxTcpsB5jz8h5+WaesOFCsoqDGtn8TcZuQYuQN?=
 =?us-ascii?Q?6Ax4mZYKOGUmLs/WY/I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918d0f21-701a-4a73-c4e5-08ddb9128b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 02:45:45.5756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcDZl604ZJru9S4daqsuMHTN6G1GHNGIm8XHfPmouHpn+/V0qxdCXKNlIDgTvHbtqQp5m4MdXnISlzTjEskJag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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

this patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, July 2, 2025 2:44 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 01/28] drm/amdgpu/sdma: consolidate engine reset handling

Move the force completion handling into the common engine reset function.  =
No need to duplicate it for every IP version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  5 ++++-  drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_4_2.c | 17 +----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 ++----
 4 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index 89a849640ab91..91e8f45fe886e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -573,9 +573,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ade=
v, uint32_t instance_id)
         * to be submitted to the queues after the reset is complete.
         */
        if (!ret) {
+               amdgpu_fence_driver_force_completion(gfx_ring);
                drm_sched_wqueue_start(&gfx_ring->sched);
-               if (adev->sdma.has_page_queue)
+               if (adev->sdma.has_page_queue) {
+                       amdgpu_fence_driver_force_completion(page_ring);
                        drm_sched_wqueue_start(&page_ring->sched);
+               }
        }
        mutex_unlock(&sdma_instance->engine_reset_mutex);

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index d3072bca43e3f..572d105420ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1714,7 +1714,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring =
*ring)  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)  {
        struct amdgpu_device *adev =3D ring->adev;
-       u32 inst_mask, tmp_mask;
+       u32 inst_mask;
        int i, r;

        inst_mask =3D 1 << ring->me;
@@ -1733,21 +1733,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_r=
ing *ring)
        }

        r =3D sdma_v4_4_2_inst_start(adev, inst_mask, true);
-       if (r)
-               return r;
-
-       tmp_mask =3D inst_mask;
-       for_each_inst(i, tmp_mask) {
-               ring =3D &adev->sdma.instance[i].ring;
-
-               amdgpu_fence_driver_force_completion(ring);
-
-               if (adev->sdma.has_page_queue) {
-                       struct amdgpu_ring *page =3D &adev->sdma.instance[i=
].page;
-
-                       amdgpu_fence_driver_force_completion(page);
-               }
-       }

        return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 4d72b085b3dd7..ed1706da7deec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1618,10 +1618,8 @@ static int sdma_v5_0_restore_queue(struct amdgpu_rin=
g *ring)

        r =3D sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
        amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-       if (r)
-               return r;
-       amdgpu_fence_driver_force_completion(ring);
-       return 0;
+
+       return r;
 }

 static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring) diff --git =
a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_=
v5_2.c
index 42a25150f83ac..b87a4b44fa939 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1534,10 +1534,8 @@ static int sdma_v5_2_restore_queue(struct amdgpu_rin=
g *ring)
        r =3D sdma_v5_2_gfx_resume_instance(adev, inst_id, true);

        amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-       if (r)
-               return r;
-       amdgpu_fence_driver_force_completion(ring);
-       return 0;
+
+       return r;
 }

 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
--
2.50.0

