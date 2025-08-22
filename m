Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F288CA0EFA
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 02:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FE310EA3C;
	Fri, 22 Aug 2025 02:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AD2cCCAA";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C1810EA3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 02:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knnmnNpS0uxtxtirr+Dvd5G4FYbIgvTKoR5APar1A4vKn33YpPS1lpOAf0EMMC4LtmJucRs4OlZe+F2PK67/G4f8k3Nm+nhkcbUnF3p8+mzwjJr+IOswJenXqxjg74yCnXoBwdCDOt5eC+Ugd3B4SUIZCUtDy6uPmLG97LGrku4RXeG4bFHna7hDSWjYPUPsd79c5tBx5aHubvJ+CzlfHoUUU7+he234j63cO1vya+FddgkQ987DJlVbv0vcmWXVVp3cAH3M8iGqPNqJP3LTLSsJGW35JeiHfXLcIwHuVoK10VVWK0i1d9n/y4naTNBF/wScU9MQaCBoKezbZ1uyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcd0FoCl6+cDIoR7BW2hZUfFowmuscwMRbIqkTAjxvo=;
 b=yngPPFok1QVx855Bv+XJtc9ku4GlZ7pub5nsJoW5+0M6eFaFerhq+LRGw8iWxBhZXfn/9WvmUTS7yo+vPI87tOeTojSer9r4171mZzyfD8ihsm8wCjpmipxdWPsWnnk9zqBITvIVAkYA5z8cB/xPrwJck9Nbbi0XsZhPFh02zC97R5zXF/2pm4DM8S2gBZEOoksbRiqERTVbM0GPow9t08PeWsZn4jqn0GZ8pvaxzNCUUru6sbUfYz72yTZy2tApUC/Y/duhhoKfx40QEKxuGVS72/1WWFnYGIlaAJcHi6dJ49348EEgWNHyfexvLBfD8dTz/pal4FUko0kTp6EITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcd0FoCl6+cDIoR7BW2hZUfFowmuscwMRbIqkTAjxvo=;
 b=AD2cCCAAc1XMsAQEqZj5WtHi3PoRSVN7MLe4zA6HLtVtxccjPj0l8UXKOr2r9gOxv7ZOitu+mcsUqVEw17oLAaZGHnAbmLmgwYpQu0WPD8w1rmcCdHumBnTxv9mbvtq3zs1DYfB1UQZzPqP3Bqtkv6Z+/yCt0/BxlUFzEig4vW8=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA5PPFF3CB57EDE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 02:15:04 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.9009.016; Fri, 22 Aug 2025
 02:15:03 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vpe: add ring reset support
Thread-Topic: [PATCH] drm/amdgpu/vpe: add ring reset support
Thread-Index: AQHcEtWIxnURn862hkqsQ0TT5bOqobRt7ntA
Date: Fri, 22 Aug 2025 02:15:03 +0000
Message-ID: <DM4PR12MB51523E0371953E27072C7DE7E33DA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250821195451.1063991-1-alexander.deucher@amd.com>
In-Reply-To: <20250821195451.1063991-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-22T02:11:30.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA5PPFF3CB57EDE:EE_
x-ms-office365-filtering-correlation-id: cd84c508-500c-4f60-8bad-08dde121b452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2TGGfxI25Q0eBhjYp9ZE73nWliMzhTpcFWpkH47xohloIPJmB9Al/PozUWF8?=
 =?us-ascii?Q?4Y60wuxI5FEMOVqoUjKs848HRrdFpeJi8LiYqBpvyO5i4l6AdZjkNbjo8p4I?=
 =?us-ascii?Q?C5DBW/8ilFeU3KAIjFD+CdVpAupFAupvfM/9j31VUi9ceIFd28JEqB/xxlag?=
 =?us-ascii?Q?1KX8iiKtInKd6fZcowvboIHmnAIUefQjm2jwoYhv5CEux3IR3L/cMPq2v9v8?=
 =?us-ascii?Q?OWMdkS/nub0qQ7/Sg8Mcq4ZrOeyftHJ464/qgEaf1YXHXc0v5z9lfMCrGLPP?=
 =?us-ascii?Q?k8Gse4S2snAoIsogKZb4wpe7JHIi7JUuvksq9nK/AxbeIncZ5sBAfoOnMIcd?=
 =?us-ascii?Q?nINM81UIhJFg2N2OgSBPVImbvwKXFD2z05iDCycNLFK79GvGBEemqxpKj7WR?=
 =?us-ascii?Q?2jmS/zvSa8XBax6uZLw1QYhFeHJAz3EUKDa02BA90zEiK6YG0PakrvoXou5z?=
 =?us-ascii?Q?KSPLgU81pc053kZYIfhDZIBovlOlALbEorFLTLfr4e3ZSJjatwyA8i2VU6FT?=
 =?us-ascii?Q?0PO0I2nU0gWjoOKCyW1qsf6dHQGDTY3nHiiEW91Ye4QwBYy7vWIFgX8682gj?=
 =?us-ascii?Q?eyD7N0F43WvjyQ3mnaNPxPSwR0B7sCfkRWYyLJeliI08hgz1GwizCu09lwbh?=
 =?us-ascii?Q?HlcMO+mSvHuhLLykEIXBJcHakW15Lti5MtwV636ETU8EX8SGPCvaw9A4LxHz?=
 =?us-ascii?Q?PPJurU5hKDiCv7Td28O9wBaBOpHLrHTf3ND04D0SFUdxIH+QnEi8m1xcNo27?=
 =?us-ascii?Q?H5WBC7Ex6oz/+qsdWv9bSsGNB8O1lI7rYG7slsaMWOk8KZeY/CVCFdYAop9D?=
 =?us-ascii?Q?458gpv6BmtigXxzplmFFhPeTu5y6DQqELDjph4MQHXvx0uYUVDOIB8a4fW87?=
 =?us-ascii?Q?vzJzdCkLeBLenOkmz+EO6EVBP7uf7YD+QbJ3Hu1rigofYMwSS05VB19ndMLl?=
 =?us-ascii?Q?WROUMZY4oZTjnUVzsZcrd6xx6CamB2Ps/+pGsQ6EhABLWsg2JekdXO/f3Tq6?=
 =?us-ascii?Q?885KBjRe97tMNZF0MOzN5y1bdlvrpxw+lKbSakkUxlKFRr1yQhaHyDpws/iG?=
 =?us-ascii?Q?XwY2+gQQHSm8GVCw0oejRuTGDHRIy2Zw7JbyaeyHn4fLzBrNRd179t4LVwzJ?=
 =?us-ascii?Q?n78IjTS4hGijxe/f6+i2+P7ygb80SUnv+NnP+yw09lyuOvAA7Qw/0K3t3EK+?=
 =?us-ascii?Q?EThxKbZjUYb6FB38Fz1GxBh51hl22yxesm8b3Tuz4wizJuAxCPAm9Zi8JboK?=
 =?us-ascii?Q?LhFp6jEuJQDsyufZWuYDs+BL2ht7dAQ5mKq1VRhY0Fx2+gL4kmIz+Gl2iGI9?=
 =?us-ascii?Q?jIBE7AGOfpYUCbHjehQEWvRBKlc0rCaNn6VU1VZNKLuSeINN3tA/ChklKMBq?=
 =?us-ascii?Q?yy39opXqoXz/MjCH3FzCGmrdXkxD1mHYOPtiIYBwBdTr8W9dDa44uoJH0blY?=
 =?us-ascii?Q?g+cRxbPiUCYWdDNYCP7bnWc0ECNviXDQ91+YhVCt9iKt7RjNTlppGQE4iC2G?=
 =?us-ascii?Q?cUYHsMm+1mpzhjg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wPg9I3QuPF01hC5gg5yKt+4vNmtThIxyN5xQaXl0BQWX0URFtkdr2hbA9dXj?=
 =?us-ascii?Q?geOhLAT+QnCpQwNxCLaBvqa71lQ+IrckHWxTj1utwfRm1JDSL9MUF2aD0sgU?=
 =?us-ascii?Q?Z3nydltsZMdAMVxMtRzxaCXm8kWE3Z2w9zZ+dsX2vFL7RWqSIPMLsCLSDIKf?=
 =?us-ascii?Q?XVwMEVeq5TSNOCps2maLzp5ejrIZ8/CPNHOdnq3zkXUZMMZNP4aroN82/55a?=
 =?us-ascii?Q?Mt6GzAaun9wQqNjOl7vdHVoYSa1jQtLOKJP0mS2zC+C7RYngfwuaqEjpZ2lq?=
 =?us-ascii?Q?Anez+/AgdDcrHLPro6AYEcIXbQbBLYf3EsfvXQyDb4WdDIzAIg4vvZf7ke4g?=
 =?us-ascii?Q?LDGB4KJcqUePwsbcj24PAkYLvtQ6Xz5bQbGEBLObzZWQe85+3fB2Dmf6si/x?=
 =?us-ascii?Q?l3H7sBhXaxaEmkeA/4QK0jrFXj5Tf6Gb8T/RByzVdO1Pt4wZxdXFM5JnPI90?=
 =?us-ascii?Q?h3YaRW9/9f7aq0rT0QApCVCZCqgfypfJLOfX+qMpAnmOuuZrNw5oBCLxbOdQ?=
 =?us-ascii?Q?JCnbT48/sP0E9MUpPee158v3HVq1K3yGeoTHpqRx/RC/WmWw3MXc4KoiWFyu?=
 =?us-ascii?Q?yyrYvsrNHJZatGXT47ZEc6eikYfBE7ZXI+UtVCPY8HidU4JMK1XoPOX9khYf?=
 =?us-ascii?Q?8JO5+KugYqWegNBxRttynPZVqoV9yx/iaS5Kd8XtLmXPnvdziIgrSdowbiZw?=
 =?us-ascii?Q?qvmCXrdCQYbmesTKJKSlQy7PVonBGucYuodVWpF2T1XaYastpmUb0FUqldEV?=
 =?us-ascii?Q?AtytBq/ipvZA1ZwG1j+/M/4wQcS2do/GC4kCxMuIl8LZNAkeGU7B/oqYDZvy?=
 =?us-ascii?Q?80/GNbMlUnTZan2LiUarKjp+SM9epilMJghsJkYAkjxXD2cSY+79HVqWlUjY?=
 =?us-ascii?Q?ZJOArSjg7NBghWy6uAORi0hPygEj7KhgTetHFjPq1JQuEs9XBe0f6zJSqHC8?=
 =?us-ascii?Q?hmvv78HsdhJB8o3R9QPyJZZBCwgh164EoHX1uwDbJWZYQDG0+kcGeTVyks5v?=
 =?us-ascii?Q?f9uRMwNr4weq2wwzEEFuy3zZv+9CZg0N9pZFyhvg+h6wV1Hqex47skGhcPFi?=
 =?us-ascii?Q?H8VhQpGp/qDp8i3MTyq1xEEsmDds2DE+SXXlvWPbRWz+PE8kMU6E6yJyLxA5?=
 =?us-ascii?Q?Bg3DRsIwY09L6z+LpMIkq+tuooivjdJjxBYz927HzdtKD8Iv51ldtM2SWgac?=
 =?us-ascii?Q?mQTDp0WJmVzoCq2ap3noGosdwLN+rrg9aRPxbi2/bWIiIjSaq1XMfSN+Bl+x?=
 =?us-ascii?Q?wN6PljbpKqidlO8tvBYkkukRM1EWGSAwnX6z23dN9c9wEpYmhzo5zvRWv9rW?=
 =?us-ascii?Q?YQvoH08DaxX2dFJ2dJmwlbvY+nUYV8ZrMwKp1Mn7Rx4lJfwhs+RRollYL5s9?=
 =?us-ascii?Q?p8Sr4V1cW9ghbE8Jet49h2bLBWtkAStP7WX3wMoG5vd4G9MG9TTFcI6RnToZ?=
 =?us-ascii?Q?tEXiLyAc1g8R6Uh4Z6pyPO3O+liHVj6IT+CjCZ/kw+eEg5EGyEq7HK6G/HCm?=
 =?us-ascii?Q?JO/kRnSs5DMibq9fZr6L6iM/bcgwtXCrrb5yEqrGMjnOloJhg8ZvQhYG/oj4?=
 =?us-ascii?Q?Ybu9CuIuHg8bCdxe2kg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd84c508-500c-4f60-8bad-08dde121b452
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 02:15:03.1527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcX31C9cgB/fclEvwdPFAzonFLtPOYrMaeRS/9vGrl67hd/0go7HCiyQN77b9Z+Rz2eo2IMlT0IgqKnU/G6/4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, August 22, 2025 3:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vpe: add ring reset support

Implement ring reset for VPE.  Similar to VCN and JPEG, just powergate the =
the IP to reset it.

v2: Properly set per queue reset flag

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vpe.c
index 121ee17b522bd..4cf5f273a3144 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -382,6 +382,8 @@ static int vpe_sw_init(struct amdgpu_ip_block *ip_block=
)


Maybe we can remove the following comment.  With that fix,  Reviewed-by: "J=
esse.zhang"@amd.com"

Thanks
Jesse
        /* TODO: Add queue reset mask when FW fully supports it */

        adev->vpe.supported_reset =3D
                 amdgpu_get_soft_full_reset_mask(&adev->vpe.ring);
+       if (!amdgpu_sriov_vf(adev))
+               adev->vpe.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
        ret =3D amdgpu_vpe_sysfs_reset_mask_init(adev);
        if (ret)
                goto out;
@@ -874,6 +876,27 @@ static void vpe_ring_end_use(struct amdgpu_ring *ring)
        schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);  }

+static int vpe_ring_reset(struct amdgpu_ring *ring,
+                         unsigned int vmid,
+                         struct amdgpu_fence *timedout_fence) {
+       struct amdgpu_device *adev =3D ring->adev;
+       int r;
+
+       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+       r =3D amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYP=
E_VPE,
+                                                  AMD_PG_STATE_GATE);
+       if (r)
+               return r;
+       r =3D amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYP=
E_VPE,
+                                                  AMD_PG_STATE_UNGATE);
+       if (r)
+               return r;
+
+       return amdgpu_ring_reset_helper_end(ring, timedout_fence); }
+
 static ssize_t amdgpu_get_vpe_reset_mask(struct device *dev,
                                                struct device_attribute *at=
tr,
                                                char *buf)
@@ -942,6 +965,7 @@ static const struct amdgpu_ring_funcs vpe_ring_funcs =
=3D {
        .preempt_ib =3D vpe_ring_preempt_ib,
        .begin_use =3D vpe_ring_begin_use,
        .end_use =3D vpe_ring_end_use,
+       .reset =3D vpe_ring_reset,
 };

 static void vpe_set_ring_funcs(struct amdgpu_device *adev)
--
2.50.1

