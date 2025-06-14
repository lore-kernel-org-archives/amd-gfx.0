Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FC9C71135
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Jun 2025 12:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54CBE10E052;
	Sat, 14 Jun 2025 12:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIrY8tSX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAD910E052
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Jun 2025 12:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0kkEGWqGgYS68X1hN2oNi5Ruzhygaqk90GJkMQ8qo/2c2n4L6PJAcAajQk16sKW5Phq9RHV2Cn51F1fXiWsk0waInmNYj8HYjevopXTpFNVDmB7dCbEdxDXWygg5iqqO8nYO/t6FMHoijPjiHlBXKs71Qtc4BcKhbH4z9LCvgHvSu0cdcnmHt3n+N4R9V29ZOzHvcDE8gIHOL+EpLf77q1tohp+9Op56KzRc3VKF9xcV5uVPuY2t164R7CvoA07Y/NfPbVPbLA5NxDD4Ki9MFPx5tSNjoVY4M/6lKYoP0vV7f38ze/QdoMWoy5iZbGsOZXN335C5o6OEjRDNSMAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ay3dnhpgEgGMWoeRiFKx/xXO9uhuP9sJkL72dn5SsIo=;
 b=vlsYkWrEFHMjSVy1djCy+RYAzoeMr6QW/6oP8CYunRzjNeYvhy35jbgyBRKdUcZdHvXW5TGT99ofhZTsyhKPkKUJx+zdzUr/n29mIpZsqGf1NetOo78mKg1dtZKAg2rwFgkf0Jid1t6lsx7zmy8BAPRYzkzF3uSUh259nvgIR0I3DhOU9NSrm9reXBtOMTB88FUXvBG2m2hvPOqklErlh+Dl1st98dvoR4Cw1iRv6+uIcH0RFFloJsfham9rGxz2Ew21MbPV7t37flJnFQr79k1fy+CSPgDmGdp78N6lhtYMlUEn7qU4VBJ0iYGO6+SRgoRCAgjDUW7/0QYIaVIwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay3dnhpgEgGMWoeRiFKx/xXO9uhuP9sJkL72dn5SsIo=;
 b=uIrY8tSXh2Cl45fSMUzlc83C0lUdHw2rniT5zwgAq3NKyLDgGQKIhUZxx4QZXmYjJM1S8hlbd6vBaleqklmw9NtRmSPsUAIA3PeBDIQglWiQj3giRn8J0u4cLpCsbBT3jIlFrrgdGuC1bjcvFkwvQJaIDuEMaSHdBppydOsrcXU=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Sat, 14 Jun
 2025 12:31:51 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8835.019; Sat, 14 Jun 2025
 12:31:50 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 02/27] drm/amdgpu/sdma: handle paging queues in
 amdgpu_sdma_reset_engine()
Thread-Topic: [PATCH 02/27] drm/amdgpu/sdma: handle paging queues in
 amdgpu_sdma_reset_engine()
Thread-Index: AQHb3KzhyMoUGErzSkq1AYdg96jV9rQClLDg
Date: Sat, 14 Jun 2025 12:31:50 +0000
Message-ID: <DM4PR12MB51522F56275CC122AFD94814E376A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
 <20250613214748.5889-3-alexander.deucher@amd.com>
In-Reply-To: <20250613214748.5889-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-14T12:22:39.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BY5PR12MB4292:EE_
x-ms-office365-filtering-correlation-id: 9c6a2847-d7a4-4ae4-2ab3-08ddab3f6ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Tmpjb9s8zYTWSglh4j5QES6Dgq5Q4qLOsV3EW63AiSR8eeKDHW4SuPo7WxNW?=
 =?us-ascii?Q?FpOV/ST2VtaQiUk2u+vJweDKWAV6Zm1ZINsq8ac+WZyeejZ82Jlc6QlNGm93?=
 =?us-ascii?Q?Vr+WiNNDnBKjOYTvai01WT3EuOnZB/z/ZsFyqu2pJ4PajKRW6zRu3piBTCts?=
 =?us-ascii?Q?HVNc8qXxwt/ZNVTA4JLCGaOVKGdcSECcdWJNgQ+3wUqo9RgOlQ9veHgvLchf?=
 =?us-ascii?Q?OTOqdbCffTiq8VYkDR3PS9kwQ9wVYNN1iLezxXn3dgCd1GZL9XR8ylSTCbd0?=
 =?us-ascii?Q?M6Yd1ApbZaThMKp/KTIyX7mTdKxbuQ1CcgObYPpEZKW1jDOv6u3wHPWHiJcP?=
 =?us-ascii?Q?nOyKW+O+SCkfB+wBxxWgAD54TdHwNRKRBwyr2hkLwGfJwn6ouihHXUKBahol?=
 =?us-ascii?Q?gksJbe+OFn+45Y6pJ96kxkKvD4E2vGNxw6sevQgfMGnGrddLz2rsbE8+AHx0?=
 =?us-ascii?Q?ln7XucUQmQ26fr5Uk+NrvFKwNlLQ/f7D/dpkN4qAYQtWNTbXsYa9O3CdkBfH?=
 =?us-ascii?Q?BFYquE0DDvSTkw3/HU1K1Nx5DhErTAktCzAs+DJiuG7ANf3BxMZPSiRwiDPA?=
 =?us-ascii?Q?x7C3mnJ3NMl0W592fFQnIAy+XDj32k/F7LpvWbo8fQoFQnZHMxVRlbQKoKRI?=
 =?us-ascii?Q?GpZwTFExtQNiXOFim+Pbe9UYwMUbfqAZ8z+VP+9+SkJJrWtLhgqnRX3XGp2f?=
 =?us-ascii?Q?So/XHtm/aFNzNaoWq0WYLydqIBVHQ3obMlZ/eAAQQezWmtibomAHFZK6oDFs?=
 =?us-ascii?Q?v0rSkRCYHCvYC2a9aKP+ulW4TQFYEtgVLM8h2Q4fOD6z+SvKKdMbAbk0mrXo?=
 =?us-ascii?Q?X9zhDMBWxHHx4YnUw12e54aJZlWR5VW217Y6bIPrY6YP0fi6LYOH+yQN/vVW?=
 =?us-ascii?Q?xODPXAnDjwsl0jE+ewhmgPzeTc5nzSufxJk83lnJSsqanAO2jVE9wofkmsSO?=
 =?us-ascii?Q?U1nI/iULNZPmiq8sGStTCGhSMN/biWJDzNKryUv75F01AzIrdFtD/vrYweVJ?=
 =?us-ascii?Q?p0SPGy8jYKajsz/pEglIhENE2W+6cuZwe+5h/a340onqj1iOAAhmIVPXbtmi?=
 =?us-ascii?Q?WkfZEHalrK/M8Sgh8bkfDUXZl/W0QH+x7g9Q83l46TQaA+SJ55Xk1rjE5Kwx?=
 =?us-ascii?Q?pO4rc6awOu7J9i7s1xJfn97OOvldDUsfd2ah+YLS7tAJcEOJoHOmBZB6nRBp?=
 =?us-ascii?Q?ctvV6yfaCRqop/lsbyznuj74H+DnyWCwNR0CpxZZSlZr3zkORqTm/JIVXUQW?=
 =?us-ascii?Q?NIQOTxiHKB4cpJHdL1RHCVcf5nCMlmsrFbaP3kMN3/2umdtrEWCjHwRKY2ZR?=
 =?us-ascii?Q?gzXma5eFEovPeO59PkU7BQOzaC72XUJ3iMLjih/vDQqOiPhHRN+JGJu3UTuG?=
 =?us-ascii?Q?Y6WPduvkQPLadmVy05Ce/V4aLrahEqB+358kp+LFg5pF458R63T249GXrskn?=
 =?us-ascii?Q?pGJlY/0dSxa17UBa3q0g/UE7setNiOeylBNcOKwKJP1b0VZJuSdTDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CzN9NnsjbIkw4m1UrAvMailfFraebmdZhnFGjEZy7K6hagYAzXE3aJwJ7kDu?=
 =?us-ascii?Q?sgTxHVH5+tQjnVWTKVh2ifhCXeyV/PqshZHpurR209YB2aWT2Ft8SDjNv6c4?=
 =?us-ascii?Q?lwMw9eI1ZXHSFo5OZFK2+Fl+ALi882i3PkpxgZmi+cTPu6k0ENdumFo5IzNp?=
 =?us-ascii?Q?65YOl0AQtjW1IYFd0VkRsuWH/gVeNU+BZAyI6EnR8TLGr6+0egXjZrtCx1kw?=
 =?us-ascii?Q?P+MYspKPqXKn0tHvrFNRkrzDUGO4ewU/AbN0jaD/4ukesS5ZC1P0kMMA9pOJ?=
 =?us-ascii?Q?SKDnfnnbGfqDH3GXxL1gvDjHu7J0HnqXrOSgFXiUHvOgiiLFhqJc1/JiFQPT?=
 =?us-ascii?Q?cu8AKwNNuZZ4LJAExoghDI4vOBAJfsqBYN4VksnJWCVCTk9o7njcWZMgUy4E?=
 =?us-ascii?Q?blsayHLMg0exS3tENLVxt1IlFDO862n4KT3nAhJazDBZ/I+ekHZrnPQJlTF0?=
 =?us-ascii?Q?aUQuJv6smVB8y0ZOFLofMzkPWMUG9khl08tDEimE2jnNG2cQmO469ILwWj9w?=
 =?us-ascii?Q?lEqmfLUvAZtc2MC6MNaELYw3DQ+t0twUpJdsq47ERztIh2fdv0zVEjowkkdN?=
 =?us-ascii?Q?FzTwUyCResXQYk7o36oJRaeLcxWDb2UEVFtNcf/HprL+2kS2nnECy+BS3x8q?=
 =?us-ascii?Q?OJeUoPVqa+f0r9R2tVYm9KXlhUM8IBjKUVt2r3iuojKeVSjic/FjgFe8+QSv?=
 =?us-ascii?Q?fQQXmPOx7Sdc1Z8rBrKm8fkgCTA1F8jwSlM+SCNnFhGFOl2SX45abhYCKaTm?=
 =?us-ascii?Q?ZCrmDTwtni5eje025lb44UWOIyfl5J4RxaKy6EsvqJWR6XmzUyIz3v39tPw0?=
 =?us-ascii?Q?KrBJ698tjNCV5LtvN1PoMPsjdwbFmWkCkpl6bQm+dxQdPkiNs0+AZW/q2hnq?=
 =?us-ascii?Q?dIzrx+2lDUBKwI60kPtUwYvPNc3Aa1fxaKC8z71xcGB9CNKRCSR+ZBs71SVu?=
 =?us-ascii?Q?RZKy2fvQq5CCg6R4q3RuZktwgxAGWa1U9YeAxwM77kY/v72XaCd78DVwhQO2?=
 =?us-ascii?Q?F0p7DHuCQ5kdXTfNJALM7EHTishVbAbbijmuEz6+jQgB3TDgmr/xSBIwb7wy?=
 =?us-ascii?Q?3g6TfUHw8iFqcg//jefED1Un6PkO+YreN9MGQK3g3i+npyqmaV3BZyhu+Mbv?=
 =?us-ascii?Q?NJ9O79LWFPFtJFhODQMpWG7VUwnAsGdZQyGb/YOEHscrtRt4o8I642gXKab+?=
 =?us-ascii?Q?Jv6NgprjPhCh4o3s3a/V1fIilDBlIJ4xzyjKIbPjId6korRb6FUskKDFbvyd?=
 =?us-ascii?Q?//+rX/eypOl9MU4OxDtfTD7uLBUyclz8FY0ZfxDrgwqL/RlOqvL2wHbYqgfx?=
 =?us-ascii?Q?/zHlbV/2vI7XgWWZgHpTG6I4VF3GQ0VqwuknglCRShaLvuMsxH1kx7/UAGKG?=
 =?us-ascii?Q?iRMmMXTagEVXf9l5QfasvjB2VIezcQV1b80dhAf7YwHwXI7F3EI4RVHsbiT/?=
 =?us-ascii?Q?WuNfAsCrLTDs53+9oll660+YEwfDdqSHRygGh3xxeXizqzshPiwX0ztQBil/?=
 =?us-ascii?Q?O8lNYc0SFqVT6YM2/KkQxn5QmMNfCGRyBMJwEN8djH0oEGnUwCMGnYrUEUIk?=
 =?us-ascii?Q?ftO1sBT74zMbIX3EJK8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6a2847-d7a4-4ae4-2ab3-08ddab3f6ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2025 12:31:50.5461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbW71/4sqXNsH9PbXBSeB2GGF/UEaqiacdNQbcXvxkP5WLvfhco5FC8nZ2EJ8F9QduqLdDM/YhxQNVTQKzvM8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

This patch is Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, June 14, 2025 5:47 AM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Sundararaju, Sathishkumar <Sathishkumar.Sundararaju@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 02/27] drm/amdgpu/sdma: handle paging queues in amdgpu_sdma=
_reset_engine()

Need to properly start and stop paging queues if they are present.

This is not an issue today since we don't support a paging queue on any chi=
ps with queue reset.

Fixes: ffe43cc82a04 ("drm/amdgpu: switch amdgpu_sdma_reset_engine to use th=
e new sdma function pointers")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index a1e54bcef495c..cf5733d5d26dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -571,8 +571,11 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ade=
v, uint32_t instance_id)
                page_sched_stopped =3D true;
        }

-       if (sdma_instance->funcs->stop_kernel_queue)
+       if (sdma_instance->funcs->stop_kernel_queue) {
                sdma_instance->funcs->stop_kernel_queue(gfx_ring);
+               if (adev->sdma.has_page_queue)
+                       sdma_instance->funcs->stop_kernel_queue(page_ring);
+       }

        /* Perform the SDMA reset for the specified instance */
        ret =3D amdgpu_sdma_soft_reset(adev, instance_id); @@ -581,8 +584,1=
1 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t inst=
ance_id)
                goto exit;
        }

-       if (sdma_instance->funcs->start_kernel_queue)
+       if (sdma_instance->funcs->start_kernel_queue) {
                sdma_instance->funcs->start_kernel_queue(gfx_ring);
+               if (adev->sdma.has_page_queue)
+                       sdma_instance->funcs->start_kernel_queue(page_ring)=
;
+       }

 exit:
        /* Restart the scheduler's work queue for the GFX and page rings
--
2.49.0

