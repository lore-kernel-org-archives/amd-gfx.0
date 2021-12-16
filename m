Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A564C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 13:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0164F10FFFC;
	Thu, 16 Dec 2021 13:56:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA31F10FFFB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 13:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzNwmk5puOhFCZjGLIzzk2mH9WZKcYp1IozsEhTeQfnc+YWWsSDvUSUH7FJbBZ8vAmoJbzkhiCQMIBMQvOrsPf9r0Op7Y4SOWyyMEFqDTVZr9ZrOXnivep85Zb7PazgavSWEjIuywQvusQrYRWE5Pc+FsLxeLtH4+L7mL+mdNkN8a2cxzWl2nrCHc0ArDFRLPy9JJx7vIKsYu3B92a95Iyj+OYVZpbSoh1juBpXJOae3Lii2fvifmzDgOXoxAT90dhjKjr01w3ulToJ0WhKbrZ8sm1UHhN19EekR01fuTL2nWL092vHsckZKp/RcK4FWibIK0GzZH8YZ4++N6AzulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQZhps+wy+ZrO8vxvnJA3ja7g11saRr+RuQw8v0OhI0=;
 b=eXYCqe03NeL5la0VKzjaGUdpI0wRSvyk11yNBADp+oox3zy8UFigiZEVxKFVem26zKQt/0qDZrI+GPkbnhR9s/lV6MwFSxtXURbagRG/C4EjyYrfEjxRWexQjnFCec+1yyeuyiW1EZFrzAkMGrTuzfiduoNhWw9aa6PvvkRxf0zjFyBKHN6p+7/668IIUc4ZUBl+n0YZbV9+gCKo04tgjh6bSB4jHBSfrkvTxfqmWe82FPkdc94gryJjLi3ZKrUCBlUbufmF0K5sPnLhovuk85fGVgLzIesqSjxLuVhAUqOVtSoOMNkff8gvViE6viBZhlpkST3x7yK25uruDHjf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQZhps+wy+ZrO8vxvnJA3ja7g11saRr+RuQw8v0OhI0=;
 b=UK2EK/xW9INOinTtGS7e4CBOd8CYmN5wa1pQkoMWLaAAjrbxvSWAgHOaGRi83htnqq9p7Edbuxtd2EpkFBItBBvHXnrbPGDLgMeHgkei+O4yIeAhXYrP+lPVGz9yYfB92eXFIFRs+G63n2JIhkQmJvQrBYnZCZTMFud9AaR+Nvw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Thu, 16 Dec
 2021 13:55:57 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%9]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 13:55:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Filter security violation registers
Thread-Topic: [PATCH] drm/amdgpu: Filter security violation registers
Thread-Index: AQHX8hc+L045Ux245UuLdkBFJmuzhaw1JOpP
Date: Thu, 16 Dec 2021 13:55:56 +0000
Message-ID: <BL1PR12MB51447C1A00D0FDACCCCA9141F7779@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211216005226.24834-1-Bokun.Zhang@amd.com>
In-Reply-To: <20211216005226.24834-1-Bokun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-16T13:55:56.001Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: a8026f8f-c831-c145-94a7-3315a7cb9747
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f10231d-6748-491c-2e5d-08d9c09bc8ae
x-ms-traffictypediagnostic: BL1PR12MB5111:EE_
x-microsoft-antispam-prvs: <BL1PR12MB511175106E5BD3F372DB9972F7779@BL1PR12MB5111.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUhbu8wtvyIeJSBJJoqQ4PYaocKWnxKl6jZwKtziV215esn5Ige5uFdxGACeUE8RjKB1b1tyaM3l8JQ3ipTqGht7sKT1t7Sa0jhclFHTPk5T8EQPPiL3/AWZRLzkLuFOcKnUBNAvwRm+QlOp6Ylrj0xv3pT8OgEGzRWH/0wFJ46ltxf/bPHpQ2y5rJzERW0l94Lw+kioRP9wS04rg0i4zeVhJlqhPaX67QhgWl2rKmw45LOOQMcU+nSfSzUJ+TgiskFgDvjQK7cfP2X40uZR8vEuFwrBviwm2Kx5dqiLyuATOr+GOTx5wrU7o48U2Fva5+iEr4/jsxoDnQpd39MquQgGraZa2783Y+3fhHGnYu4eCO9xv3QQIkDKYX0/2U1XMYUoOZ9XazdTsKY1CSfK8W5aNRga8Zaepji5eMf74BnEDK7T1I6GAdwdIjjbME3w9JF335/AXFDk0pvzp5kRBHGElgP31cXIV7rXop3JUZ8a1txBx/k2tz4Dstimd4ZvvpxNj7W7P7Axev/wOygHP9deE3nIjguBsvtEDc8MYMC9BD93GuqXUG9li8uQSeqnH4hyeAf61UlCYlEFw4cBNQ26nKgcg1JaTTGFmZccBV+fj39gQnnH4Z1/VJucYa9fMKP7YtLbYyFleDX/ftX/jJWtwWD1OOmcJ39ZavzK8bBaXGROXofErC50NPsZF175ebPk1LCJycrmaOYKVYN4nA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(53546011)(66446008)(86362001)(15650500001)(186003)(33656002)(2906002)(122000001)(52536014)(83380400001)(7696005)(316002)(26005)(6506007)(110136005)(38100700002)(64756008)(508600001)(76116006)(5660300002)(8936002)(71200400001)(66476007)(66556008)(38070700005)(19627405001)(8676002)(66946007)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QMGC8G2vPWWGB6CA1ZSyHP+JqiWTM4bX3YjXe+hKvAwVIBbTjPMg+6FS0YS1?=
 =?us-ascii?Q?aac83decxsmhhLZSjbxThpzVsK1d65Cqerudq8FdWymLiEYAjB9pCcnUdMD9?=
 =?us-ascii?Q?/3WJ4GK/kho1a7xKz39bBTQlR3B6TLq8Hvh04bcy3srbI22LIIZUBTlbD9h8?=
 =?us-ascii?Q?YgfPH5GRQtYa8OHbUcCgYVghp2R3wCbJOX9OEMCEIxAPTBdMcdkVRcX6dlKH?=
 =?us-ascii?Q?JKhX9blEs4l1cerxXYZ1W+rWe6xujWiwYmSBDxWce7FMZ33BSNrvECyv0vrZ?=
 =?us-ascii?Q?8iCQx7oI/dkKyGaPXfjviWpt59aGgSfA0HUAwzJMNdzC0qFltyZENjeX63WE?=
 =?us-ascii?Q?EvHpwOJBaFRhGP4wbzH9breHUmDpu6VRROAeolvYbC2ngFsEuko0QkYE5Ksn?=
 =?us-ascii?Q?Uj+nHBxb9u4T1My5ruIIDhllq3TOFAvufe9bG59nFaFMxfHFlOgzwibXVYs2?=
 =?us-ascii?Q?4ljs5LhgiV1h0UMMnyvMrl1HHpaiKtFFkb+/W/72N4frMeI8wAjHo8zfi7Zg?=
 =?us-ascii?Q?/rzRUELKnWodJj1LV0IfcTLJkwkTd4RwA1YPGC9L+bC2jzd5robMqSTA/6fh?=
 =?us-ascii?Q?OS8Gwb4/9aoKIHTp8QFEPDgJVnBJmhkNJOz0mqzO9YIF203xqOz/uvI0slUK?=
 =?us-ascii?Q?K4St5Lz8U+NOn2GzlvyTsakECq2hCStNxqhdU6gYwdXKep5brLh6mygWz/Mi?=
 =?us-ascii?Q?IqaerqkBoISVeFTt+I+gV/7wbxz7VE0mTJ7jmPpfNHm/MsT7PvU2h+SUPurd?=
 =?us-ascii?Q?KTejFUmSk227oPmkH1x3oQTuZZJLEGYUW6dMR3LJGZ8FHVuCReyF/icYL2th?=
 =?us-ascii?Q?YlXeBXQTzopWmOpjNp2d7v0lQc/4/X/bABGFNJsLG839WQDIaM3VcgMXvUE6?=
 =?us-ascii?Q?WA/ZDL/vHkYLWGoFUgsxS7myThiLG9Ue9yE01Go5niO+zzCMnmaiQNzzjiw1?=
 =?us-ascii?Q?V4cIv5cojL5F41mq48Pya4B+NKfn97jJA8cgA8XpOO7DymbkxK4cFP8iT+qJ?=
 =?us-ascii?Q?KzsJQuio1q/TfI7Ez6pNneuVLsOG2uqcl1vDkRaIvIbxQ0xB2BeG1QqrulcT?=
 =?us-ascii?Q?jVRIZ+T3DFZKuGILAR16Mr/BUXDxodw05+sFt4EIXWiXfD5/iLhXLDpcHnu7?=
 =?us-ascii?Q?vK2MsS0ahi9Z6Tebc353ne9GfLK6z266DPkAS0eCV9eMGCAuUWdZ//NC14SC?=
 =?us-ascii?Q?+nEqggNOk34u4AJUCYIh8EoyoeRa4wW050pkX2gSrdnaR0+NhPTTGDsLyfH0?=
 =?us-ascii?Q?W2iljxdqh9+WrkL2JMFKCrhnK+8zFb2P4th5L1zK+gwQepi2C+T7CqSvjiPF?=
 =?us-ascii?Q?XjEdn9MaaG5q38gZbgFLqMMk9mMSlUem5i7evizRnc0Fat2ukDUchCNcllO5?=
 =?us-ascii?Q?jR+TbIQEaZQPk3zSAb3S6ZFcUXJYVm5ywTvVesDwTS3YdLDLH2xXP0/v5JiN?=
 =?us-ascii?Q?oRW7yW1/54wzfn5TZ+0czU4057AlILKvcNCbaZBmbkvcNl5S3/QWh2xrpJm5?=
 =?us-ascii?Q?B31s3+OwbygwtxAB7AtfQ4YiblipqoiCM//gNUkuFEGBkpFYCw/oh7AMcSHD?=
 =?us-ascii?Q?gGBUVSkHIy+tgJ4AMR1u4kZFxKRKcDpcOKYg3DPTuBcmoLFwxtCRMTfveCzi?=
 =?us-ascii?Q?JvjyG6mewuq+SrzlmLjhUco=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51447C1A00D0FDACCCCA9141F7779BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f10231d-6748-491c-2e5d-08d9c09bc8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 13:55:56.7095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGmuNntlfHonrXzSuzpjIhA8gyBQTNEM02/VfJGgtOY1lJTzj1x0Yf8YLXEUBJN89Cau5Yke6wICQsmfSqAdNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
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

--_000_BL1PR12MB51447C1A00D0FDACCCCA9141F7779BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Bokun Zh=
ang <Bokun.Zhang@amd.com>
Sent: Wednesday, December 15, 2021 7:52 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Filter security violation registers

Recently, there is security policy update under SRIOV.
We need to filter the registers that hit the violation
and move the code to the host driver side so that
the guest driver can execute correctly.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Change-Id: Ida893bb17de17a80e865c7662f04c5562f5d2727
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 83 ++++++++++++++------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 4f546f632223..d3d6d5b045b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -542,9 +542,6 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_d=
evice *adev, bool enable)
         }

         for (i =3D 0; i < adev->sdma.num_instances; i++) {
-               f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_CNTL));
-               f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-                               AUTO_CTXSW_ENABLE, enable ? 1 : 0);
                 if (enable && amdgpu_sdma_phase_quantum) {
                         WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev,=
 i, mmSDMA0_PHASE0_QUANTUM),
                                phase_quantum);
@@ -553,7 +550,13 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_=
device *adev, bool enable)
                         WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev,=
 i, mmSDMA0_PHASE2_QUANTUM),
                                phase_quantum);
                 }
-               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32=
_cntl);
+
+               if (!amdgpu_sriov_vf(adev)) {
+                       f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, =
i, mmSDMA0_CNTL));
+                       f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+                                       AUTO_CTXSW_ENABLE, enable ? 1 : 0);
+                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CN=
TL), f32_cntl);
+               }
         }

 }
@@ -576,10 +579,12 @@ static void sdma_v5_2_enable(struct amdgpu_device *ad=
ev, bool enable)
                 sdma_v5_2_rlc_stop(adev);
         }

-       for (i =3D 0; i < adev->sdma.num_instances; i++) {
-               f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_F32_CNTL));
-               f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, =
enable ? 0 : 1);
-               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL),=
 f32_cntl);
+       if (!amdgpu_sriov_vf(adev)) {
+               for (i =3D 0; i < adev->sdma.num_instances; i++) {
+                       f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, =
i, mmSDMA0_F32_CNTL));
+                       f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL=
, HALT, enable ? 0 : 1);
+                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F3=
2_CNTL), f32_cntl);
+               }
         }
 }

@@ -608,7 +613,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *a=
dev)
                 ring =3D &adev->sdma.instance[i].ring;
                 wb_offset =3D (ring->rptr_offs * 4);

-               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+               if (!amdgpu_sriov_vf(adev))
+                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, =
i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);

                 /* Set ring buffer size in dwords */
                 rb_bufsz =3D order_base_2(ring->ring_size / 4);
@@ -683,32 +689,34 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device =
*adev)
                         sdma_v5_2_ring_set_wptr(ring);

                 /* set minor_ptr_update to 0 after wptr programed */
-               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_GFX_MINOR_PTR_UPDATE), 0);

-               /* set utc l1 enable flag always to 1 */
-               temp =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_C=
NTL));
-               temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
-
-               /* enable MCBP */
-               temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENA=
BLE, 1);
-               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), tem=
p);
-
-               /* Set up RESP_MODE to non-copy addresses */
-               temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev,=
 i, mmSDMA0_UTCL1_CNTL));
-               temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3=
);
-               temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, =
9);
-               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_UTCL1_CNTL), temp);
-
-               /* program default cache read and write policy */
-               temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev,=
 i, mmSDMA0_UTCL1_PAGE));
-               /* clean read policy and write policy bits */
-               temp &=3D 0xFF0FFF;
-               temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-                        (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
-                        SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
-               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_UTCL1_PAGE), temp);
+               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_GFX_MINOR_PTR_UPDATE), 0);

+               /* SRIOV VF has no control of any of registers below */
                 if (!amdgpu_sriov_vf(adev)) {
+                       /* set utc l1 enable flag always to 1 */
+                       temp =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, m=
mSDMA0_CNTL));
+                       temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENA=
BLE, 1);
+
+                       /* enable MCBP */
+                       temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PRE=
EMPT_ENABLE, 1);
+                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CN=
TL), temp);
+
+                       /* Set up RESP_MODE to non-copy addresses */
+                       temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offs=
et(adev, i, mmSDMA0_UTCL1_CNTL));
+                       temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP=
_MODE, 3);
+                       temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO=
_DELAY, 9);
+                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, =
i, mmSDMA0_UTCL1_CNTL), temp);
+
+                       /* program default cache read and write policy */
+                       temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offs=
et(adev, i, mmSDMA0_UTCL1_PAGE));
+                       /* clean read policy and write policy bits */
+                       temp &=3D 0xFF0FFF;
+                       temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+                                (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
+                                SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
+                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, =
i, mmSDMA0_UTCL1_PAGE), temp);
+
                         /* unhalt engine */
                         temp =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, =
mmSDMA0_F32_CNTL));
                         temp =3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT,=
 0);
@@ -1436,13 +1444,14 @@ static int sdma_v5_2_set_trap_irq_state(struct amdg=
pu_device *adev,
                                         enum amdgpu_interrupt_state state)
 {
         u32 sdma_cntl;
-
         u32 reg_offset =3D sdma_v5_2_get_reg_offset(adev, type, mmSDMA0_CN=
TL);

-       sdma_cntl =3D RREG32(reg_offset);
-       sdma_cntl =3D REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
-                      state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
-       WREG32(reg_offset, sdma_cntl);
+       if (!amdgpu_sriov_vf(adev)) {
+               sdma_cntl =3D RREG32(reg_offset);
+               sdma_cntl =3D REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENA=
BLE,
+                              state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0=
);
+               WREG32(reg_offset, sdma_cntl);
+       }

         return 0;
 }
--
2.25.1


--_000_BL1PR12MB51447C1A00D0FDACCCCA9141F7779BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Bokun Zhang &lt;Bokun.Zhang@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, December 15, 2021 7:52 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Filter security violation registers</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Recently, there is security policy update under SR=
IOV.<br>
We need to filter the registers that hit the violation<br>
and move the code to the host driver side so that<br>
the guest driver can execute correctly.<br>
<br>
Signed-off-by: Bokun Zhang &lt;Bokun.Zhang@amd.com&gt;<br>
Change-Id: Ida893bb17de17a80e865c7662f04c5562f5d2727<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 83 ++++++++++++++-----------=
-<br>
&nbsp;1 file changed, 46 insertions(+), 37 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 4f546f632223..d3d6d5b045b8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -542,9 +542,6 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_d=
evice *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;sdma.num_instances; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CN=
TL));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUTO_CTXSW_ENABLE, enable ? 1 : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; amdgpu_sdma_phase_quantum) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phase_quantum);<br>
@@ -553,7 +550,13 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_=
device *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phase_quantum);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl=
);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f32_cntl =3D RRE=
G32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f32_cntl =3D REG=
_SET_FIELD(f32_cntl, SDMA0_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AUTO_CTXSW_ENABLE, enable ? 1 : 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_v5_2=
_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;}<br>
@@ -576,10 +579,12 @@ static void sdma_v5_2_enable(struct amdgpu_device *ad=
ev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_v5_2_rlc_stop(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.nu=
m_instances; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F3=
2_CNTL));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enabl=
e ? 0 : 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_=
cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.num_instances; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f32_cntl =3D RRE=
G32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f32_cntl =3D REG=
_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_v5_2=
_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
@@ -608,7 +613,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;sdma.instance[i].ring;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; wb_offset =3D (ring-&gt;rptr_offs * 4);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SE=
M_WAIT_FAIL_TIMER_CNTL), 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP(=
GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Set ring buffer size in dwords */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; rb_bufsz =3D order_base_2(ring-&gt;ring_size / 4);<br=
>
@@ -683,32 +689,34 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_=
v5_2_ring_set_wptr(ring);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* set minor_ptr_update to 0 after wptr programed */<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GF=
X_MINOR_PTR_UPDATE), 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* set utc l1 enable flag always to 1 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL))=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* enable MCBP */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, =
1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);<b=
r>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Set up RESP_MODE to non-copy addresses */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, m=
mSDMA0_UTCL1_CNTL));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UT=
CL1_CNTL), temp);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* program default cache read and write policy */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, m=
mSDMA0_UTCL1_PAGE));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* clean read policy and write policy bits */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp &amp;=3D 0xFF0FFF;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT &lt;&lt; 12) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (CACHE_WRI=
TE_POLICY_L2__DEFAULT &lt;&lt; 14) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA0_UTCL=
1_PAGE__LLC_NOALLOC_MASK);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UT=
CL1_PAGE), temp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GF=
X_MINOR_PTR_UPDATE), 0);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* SRIOV VF has no control of any of registers below */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set utc l1 en=
able flag always to 1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32(=
sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D REG_SET=
_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable MCBP *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D REG_SET=
_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(sdma_v5_2=
_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set up RESP_M=
ODE to non-copy addresses */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32_=
SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D REG_SET=
_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D REG_SET=
_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP(=
GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* program defau=
lt cache read and write policy */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32_=
SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clean read po=
licy and write policy bits */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp &amp;=3D 0x=
FF0FFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp |=3D ((CACH=
E_READ_POLICY_L2__DEFAULT &lt;&lt; 12) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (CACHE_WRITE_POLICY_L2__DEFAULT &lt;&=
lt; 14) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_IP(=
GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* un=
halt engine */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =
=3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =
=3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);<br>
@@ -1436,13 +1444,14 @@ static int sdma_v5_2_set_trap_irq_state(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sdma_cntl;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_offset =3D sdma_v5=
_2_get_reg_offset(adev, type, mmSDMA0_CNTL);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_cntl =3D RREG32(reg_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_cntl =3D REG_SET_FIELD(sdma_cntl=
, SDMA0_CNTL, TRAP_ENABLE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IR=
Q_STATE_ENABLE ? 1 : 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(reg_offset, sdma_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_cntl =3D RREG32(reg_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sdma_cntl =3D REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(reg_offset, sdma_cntl);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51447C1A00D0FDACCCCA9141F7779BL1PR12MB5144namp_--
