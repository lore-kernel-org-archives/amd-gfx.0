Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD991C8303D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 02:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E07210E655;
	Wed,  2 Jul 2025 02:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zRDoZFVD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1876C10E655
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 02:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x06Ip6HschRXw40Y3iZzKcLIL2fw7pwirlIjEcTisx/ppuwupjZDB+iB3fRW8cGcWkflq2QcRJZ6BlfUiVyBGG89XgEPj9FPThxTsZ71VDc+zr5VIlMHkOgSyqTudlWd6FbhNMeZ0Fvy1UqIM2k5cdPuQeRt5NQ+FwMqELr+JlSLn8xwAJUFfUbFX/TdzE1qfoNhDjOZI1ckVyTpI60r7kfQZW1vRLI6czkGnoPsCYH3ZFNjico+WXjpFPeiFRrs/14j3t4t9C3RgjJFQafywrx7IIF8KpnX3eqKVwM7ou8RL1fVEkw+02f3ViddTDzWn3qhAeFhQUz2A5MRo2h0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56ptNYxahR6tAfHEJF1AdkEePrS03yvNkJtfuXjz3X8=;
 b=QHCCuVjdQqe8f2dt591Jm34oXFAJBA/VQAsHRgAgpnXmTMVauAB1bKxYBLp+ZnFtpqagEAMRbYuadVnEThApEmks5AgeBHGqkbm/HAVG+aRYOXqyRUe9sDn2++P15kx41uRDwHPPMZdD0ZIRH2M7zY42P5Av35Oj+HMBhdFVMStHCFZ83CQaD8cAVRKhqgW1ffGrn7QMkQCHsYU0mRBG6QSUDLHTYcxJ3D09Dh1IlK4vPyE0PCV6gOEG9AISBDB2qUDUtsG/cXBEn5dDpjOKBj/A8HlcCgvqTMeA4KAfilaabb0LkK9Lbvmm3TtLtYaXnylL5sJ+rIs2MgVw3tdEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56ptNYxahR6tAfHEJF1AdkEePrS03yvNkJtfuXjz3X8=;
 b=zRDoZFVDR/Q87xoTslaKGl3f0Lwq5MThskDO15P4dv4XUvyIIeWbQ6B+ItbuWsp2TFHvSIPJwCtaJUjqh5fcdb7OPNdBDgRoIoAuuayv3H7pGZrUPjLyehXfQ3WzXHYn1E/ecMoWMIPCuv4sPfGKQ/0nIw8yc9Ga0gYK9OTBE98=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 02:55:31 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 02:55:31 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 04/28] drm/amdgpu/gfx9: re-emit unprocessed state on kcq
 reset
Thread-Topic: [PATCH 04/28] drm/amdgpu/gfx9: re-emit unprocessed state on kcq
 reset
Thread-Index: AQHb6rhN5BFgcpUVnECfU9c/MMhDgbQeJAng
Date: Wed, 2 Jul 2025 02:55:30 +0000
Message-ID: <DM4PR12MB5152599A2DC361D499303229E340A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <20250701184451.11868-5-alexander.deucher@amd.com>
In-Reply-To: <20250701184451.11868-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-02T02:55:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BY5PR12MB4210:EE_
x-ms-office365-filtering-correlation-id: e136bcb9-d9b7-4bc6-7d1f-08ddb913e84d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xjMbKc4nju2Z6Ho6z1nR38L91hn/RSyVecR44436YamLGnC0hk25zKcOoQfQ?=
 =?us-ascii?Q?iXZTbMD/0uf3xyvl7FDfg6OMEPU7TcC0HQFveL5fbU8zrmnymNe/zKjhPxTF?=
 =?us-ascii?Q?hn620jR6B7zE8wqE7/ic3KXLLVfTxQhEati/1SR5k4g2vFgxYvPLodrC+DCv?=
 =?us-ascii?Q?0yfRiDiIJ2vW3tWrBAN7v1ptElpZWQNQFEs+a8kgk1wLCrbcGas1tscbqEJx?=
 =?us-ascii?Q?0PiuA3cLuGJg0ZjPGSn9uNfq/IU5138BCpQt1KbJ/9+UcXhZfpiyusKw3AuN?=
 =?us-ascii?Q?/fYPSToOkZuI+A0eSsVT8VeIJXKIZ1D0jRYkVJHyCuLdTHbVZ7ABHCt2eZoA?=
 =?us-ascii?Q?yO+nr33MqkjZdSp87eXgjQYwCSCw/jL3e9uEiFQJdhec35Qdz8+kPEU0ICP1?=
 =?us-ascii?Q?eSsae6l6SN+UMro2jjdTULGyVLmb28dq5XIM4FYKytVl6vv0ilp7w+OwNTAL?=
 =?us-ascii?Q?zKP7o0fCax2wp5+2xYgsRTyJJSJII8trlOMaPBEvLzSYe+FWtbHgRzIApB4P?=
 =?us-ascii?Q?IrRf66H+notZrT++zAA9qJSAgYOOS0evzJNEF5jaYFKCsgiK/jJgwRnmo8GY?=
 =?us-ascii?Q?1i/PR3ZxCmlsYzUnuGNonMwS2R8akLhIgdzMmBFMhTJNP/0immi9vkcMTdqX?=
 =?us-ascii?Q?RbM/H+HjgRK0ZMkKrdJkv9mRCmzq0fZeZhvw7nliLPUIDfLHEqyspgNkZcK7?=
 =?us-ascii?Q?H3ZttYym+rSaKgt4d9LHSK/MkPI1Q+dQOng3TfhrGrIRWa83C/TBADBOKSQO?=
 =?us-ascii?Q?TO9+LGYkYnwppNRj0AQONPiA4iqGvyuduqdWuK6vK2K35HvLOp/1ohJcIIHq?=
 =?us-ascii?Q?GjWgGStK/ijn1HuA+6eHz4AY197k0NN7iT7VibP4C5scEazc5YDrj5cbiCKK?=
 =?us-ascii?Q?xwKgjTGAjDV7kQExz+VUP2DQ/Y64GyaqRw8Fzu6De+mJgfTX7GQwrHAWu5Zm?=
 =?us-ascii?Q?MeEWNRuOAHa+7yELL5AM+YnCnVN4Z3i363S2BbmyjlWZy9Jrs6FOJA3wJ/eK?=
 =?us-ascii?Q?KE5GYrWSzCFHK95qlpzpfvXLcdeu6iDx7W4GqJ0Nf7CBntgaYhQoldCXanle?=
 =?us-ascii?Q?/5HXahitsC7zT0v51tzwuPpqTk7GvHg8RPL2t3NUBWfU6lOZ2oinnvYU9eyh?=
 =?us-ascii?Q?/EDMsoO3ePGL3iRgFGpyIxa8rR6+sDqhc1pyOuPJEX5MPoHzDkhEmopzlmoA?=
 =?us-ascii?Q?tTvrgFrSXO0AGzCjcgoRSgbCEaZCy7yLSyaGh3Dn8MZpw0RSt7SNd8AjYjLx?=
 =?us-ascii?Q?CX2dcE9OuNvGnhYEJAtZwvJVT9ui4IEZHwTKRAv4H3kTYXVIdh6oHYH+4oOE?=
 =?us-ascii?Q?nHIr41qD2ykG3Zwa3CyCcnVZjdiWcflwAEv3o37CfsSf8a6FpUVm/2I5TJ6y?=
 =?us-ascii?Q?kDW8yWI1THyswPciQXe3vtmu1XybXxlZ4ZElUdQxKRi16uW02QW2hrJ8Wsv9?=
 =?us-ascii?Q?nsqXBOWXKO7isY1sJ1EJpymeSg6mz7POShgJx2NEt/44aQbTPA01HMTuFZB9?=
 =?us-ascii?Q?ewVIXwBIqw3sIXs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GoCwr0sVHPb45mAJ1uWrr3a6B0qnm/y4juUzexnBQQtZ2x0vPccNhA3rBIWv?=
 =?us-ascii?Q?WIqQbJO12fxDu6XUUzwugjkY1a4h3AeG36MLmTT7rqs6XKUWbCRiJIy6cD7/?=
 =?us-ascii?Q?yxMc995MOWXrIrAsfpEWfBNecPM44pUjY1P3aHfqIOBYnW83GpMswwvSdNmS?=
 =?us-ascii?Q?aN05F4Zy1ms8Vb9d5iHV91wmCuTISutmt5/TnQHpAtRU8t4JeA3UoXkb8riP?=
 =?us-ascii?Q?LcbUPZHrBXqhyWkL7MkDYy8lTcsGcIKBGCHZKd5nH2zzZkMeNZ/I5Mg4yOGE?=
 =?us-ascii?Q?MaDqAZLhui64QYpRfrmovyhBw/TKeo7IzoUHxphmEJYYbqRJNITCaGU96+m9?=
 =?us-ascii?Q?I2iwuhRyUreuYdFsumsm7p2aDeAMJJG/jYxhH9yQUcryfJcXuUeAEzPtD8V1?=
 =?us-ascii?Q?4iC74DnNwh2XwoyvoKJvL0XlSS4LCbOA0WIWZ2hSZGtBjWczz6qgVzfpFGtC?=
 =?us-ascii?Q?pifaOgTKHt8no1G7uDvIfYSg5KXVWxOj+drK7fJLF18Y6sq3m/dnPfh4IhFH?=
 =?us-ascii?Q?JCXmxG81u/FhkYQqToEe8zrXCil1bgx0we/IZdR9goaL5gHnMXcR/huGEUlO?=
 =?us-ascii?Q?/SRd2KjmmmBg5SG7GBKZ25MGVfyc6OKfk2PiO7LPCOHr1vw5QD6Gddix/vPK?=
 =?us-ascii?Q?inzgUhV+nNwaVX6W10tDc+iOrZ+Cy/C2alpTtZ5n1RtQZcw+gOxsUm1i+5AW?=
 =?us-ascii?Q?zIuarHJv1nYD7iqRGB1z0UD+taI3efdMwWV/1paLFQpB5Swgi5pS/iclSjbt?=
 =?us-ascii?Q?nCECN32Q28iVwzmC01qd0h5h3sio7hVCe3o3aquMgDPav9C+7eN3UPirjRIi?=
 =?us-ascii?Q?voL7vuSZD0H45OSzMW0YMA+ZO8/sA+KfSRKNlRdQuHL5Dqvuz78HVrgiBJwe?=
 =?us-ascii?Q?tbfoVj0Ne3FV9ZHDbziSoKls0pfrOqDHz78tCNXTEd4ExrMEQluNuN1qiVpb?=
 =?us-ascii?Q?D236VOjKjgihSeC/u6zX4OE+v3B04EgwIVn4LoYeI5I+zInUeiMkDP4DtQ8e?=
 =?us-ascii?Q?cLAO6gkHeBa21XyWyEZO2K3MBxEnu9bBqpAlleZDd7HdEqvxyAPHGPXs1ZB3?=
 =?us-ascii?Q?/3ohpXOemvUG6Bky/rWJNBFCeY9mVeVKlhPB03IdaVCqQCqJnhPr/OIUZQ2t?=
 =?us-ascii?Q?Ntvuy5yombOZbDTM/b4B04n9xi+1z9o41GkoN1zPn9mHAr7AQgkk2zTUuHhG?=
 =?us-ascii?Q?8A1nM5oFCjSBE+jkLqCyM6QBSc9yHtklV5yrCKPBi0HGENUxSVgjOKN3HZWE?=
 =?us-ascii?Q?D4B03NketOAhCGfjRauw3fJpfD61moMTuoz4Sz8bdZWyyqLUDsjx+S9AIFfN?=
 =?us-ascii?Q?RpJegqQfQQRpWIQsE8tLMohMqkpfntbpO73WPaDqqwKhI1pL+Tw1DncRnLhc?=
 =?us-ascii?Q?2Ir8NuJ7Gwr8wEtsIyQkwpLJbLwArWWtSWmDJYld/rJkxYhEHs4BghkJjY5w?=
 =?us-ascii?Q?oJMc2zax62a0FkpmYyqeDr7XqcXkk6TfMMrP2naKPP6VYsWYtHxhbsoPhQ36?=
 =?us-ascii?Q?I2xRg8C8tNPR0PC0OVAU8CJLNVo/G6Bz0KELx/BS9EOqpqH5N7RHufx5ZgO2?=
 =?us-ascii?Q?GpejBuq3TSqUxE3McHs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e136bcb9-d9b7-4bc6-7d1f-08ddb913e84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 02:55:30.9247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hceRlU6pJoc2d5qNT5sAZKOrORT2moyoaP33fPMFzi1lQdxYZzdHeDOs8UNnffi/+JVMcjVhmOArXYy7j0feJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

 [PATCH 04/28] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
 [PATCH 06/28] drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
 [PATCH 07/28] drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
 [PATCH 08/28] drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
 [PATCH 09/28] drm/amdgpu/sdma5: re-emit unprocessed state on ring reset
 [PATCH 11/28] drm/amdgpu/sdma6: re-emit unprocessed state on ring reset
 [PATCH 10/28] drm/amdgpu/sdma5.2: re-emit unprocessed state on ring reset

 these patches are Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, July 2, 2025 2:44 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 04/28] drm/amdgpu/gfx9: re-emit unprocessed state on kcq re=
set

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 76ba664efecb3..30f6b04cf82e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7187,7 +7187,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *rin=
g,
        if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
                return -EINVAL;

-       drm_sched_wqueue_stop(&ring->sched);
+       amdgpu_ring_reset_helper_begin(ring, timedout_fence);

        spin_lock_irqsave(&kiq->ring_lock, flags);

@@ -7238,19 +7238,13 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *r=
ing,
        }
        kiq->pmf->kiq_map_queues(kiq_ring, ring);
        amdgpu_ring_commit(kiq_ring);
-       spin_unlock_irqrestore(&kiq->ring_lock, flags);
        r =3D amdgpu_ring_test_ring(kiq_ring);
+       spin_unlock_irqrestore(&kiq->ring_lock, flags);
        if (r) {
                DRM_ERROR("fail to remap queue\n");
                return r;
        }
-
-       r =3D amdgpu_ring_test_ring(ring);
-       if (r)
-               return r;
-       amdgpu_fence_driver_force_completion(ring);
-       drm_sched_wqueue_start(&ring->sched);
-       return 0;
+       return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }

 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_p=
rinter *p)
--
2.50.0

