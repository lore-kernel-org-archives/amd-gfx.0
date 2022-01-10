Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52453C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 15:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB09511244A;
	Mon, 10 Jan 2022 15:41:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C70711244A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 15:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvftBi2ta97wdaSNIV32Oftj93tYdWi2poBzsKiVQIyrf3QWvbVM6EXlNX5crmFxoKLkSbpl5IJFIt5xCa+E5P45reDL+NFMpdVRuiUGcEgXJ4QCB5bpaM+X2VWyBIZ3cnZU4qYhD8RP1SBQbMs+ZIssdJBaMnp2XDnJENzhKBvej00Axm6M3NKtNVeFqEXKd77KVS9+fLUSFlMLYxE66jWzbSQ8nU7gdXjFVQDI9/E4t+AE4g8IsXi9dId9NmeQThyn1RihuFRJSM3kqiR9PZI1FSJN4R+GDZ4queXrJyc6R8kxweMjDjp5NQDjXfllgvRb5rSobUwy5+uLH1UQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iolF4X0UUb+CAtOqubQSYftEwuEktrQM50JampfbMTU=;
 b=LeiovLZICuXAYnsV03eCgyvUAa5aWwZMKT2EaHb0XvP0E8Pvh1NB9AmPU7tuOVLvjOiEglebZ1CRdd4t5RCUHz17pHMx0RCkQrjqvtspBojcrc/85z8uMM381TaDVgTwbXzTweNMoT4/uJMriyJSBsEZLK8dNa060cveyvKhoXAeRlNZNPt0vzPpeSi6xU3+CwrnT8QaIiK+EO6QJAPRzgG9QTcB/tecfU1jtVGe7FWVAqirELH38AR0+25CuZvqhW5W5mEhFiY/VYE9D7icjqBdV8/GV6EQopzjz0Sk7jchqjDRhHtSL4aCVnqASrD8nGgmBV8ybdcRvcM0vDbIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iolF4X0UUb+CAtOqubQSYftEwuEktrQM50JampfbMTU=;
 b=ccqyk6qZwHNWg46g6fmW8KTccFvST9SYQsU0brgQBLhsjo2lOCAiirQKa/3Whjev/ss7NxQKt8SiJpvD8yxyyPXr/1jbkO46iMeDP4Bdxixe5WlGrIJeWU+BkcANHuigkj3DRuoYUVuL8RQj6Pca29NWNDB66WdQPcLgc49eCTQ=
Received: from BN6PR12MB1171.namprd12.prod.outlook.com (2603:10b6:404:1b::21)
 by BN6PR12MB1874.namprd12.prod.outlook.com (2603:10b6:404:fd::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 15:41:47 +0000
Received: from BN6PR12MB1171.namprd12.prod.outlook.com
 ([fe80::9a4:2eaa:6ef:c35c]) by BN6PR12MB1171.namprd12.prod.outlook.com
 ([fe80::9a4:2eaa:6ef:c35c%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 15:41:47 +0000
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Huang, Qiliang (Warden)"
 <Qiliang.Huang@amd.com>, "Zhang, Bokun" <Bokun.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by
 local interrupt
Thread-Topic: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by
 local interrupt
Thread-Index: AQHYBeDhd4c0iNDegEuh1qV6ayG/NaxcZP3Q
Date: Mon, 10 Jan 2022 15:41:47 +0000
Message-ID: <BN6PR12MB117124D8D3DAE8FA8B75464BFE509@BN6PR12MB1171.namprd12.prod.outlook.com>
References: <20220110051344.29134-1-guchun.chen@amd.com>
In-Reply-To: <20220110051344.29134-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 658d3c2d-50fe-4f37-472d-08d9d44fb63d
x-ms-traffictypediagnostic: BN6PR12MB1874:EE_
x-microsoft-antispam-prvs: <BN6PR12MB187400AE871631FE7642DCBEFE509@BN6PR12MB1874.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rgt9IjyvbrSjr0vY8aUx4SbjLfBiq5aw/FPShqr40HQJx7OZ4cW/g2PgmLKjStQtRN2m3vbAxATnMhKXUSyhtcjiZjeTL5jP/M8cGS9IYRiVBddj7/yYTdgQ1q0qEPywyDsj/N8VXLyTGQYQaduNV3WJ0q2IWMEQffvx6jSaJwvR7MscbQWSq6j9tukg2jMg+ZLMNltNAuYYer/cbZ6uaR1Z3kouI2DpAKWMmiw3iRO24G/hhxiNOKiomC9+tjcrpVt3kJKEM0Cj2y/MkpE1JvNWvwG75bhymQu4cequseT/Fwl0KMavv3Ia5vtmyTThYKFil2Jnh2dYEZ8zquurKZJmYvxE4rFN1zECMY7sPAihSQ9bBKIaF/IgMU8Q2Ua4ESzfDo/3B/nyFW/mSpx83tmYa36HyZCgr0NdjtTIUIVW3R+NdtKqAFY6AMhV2/YPkMWAGeluwoq7ugPas90Lf9zSH322Ln5gkepneD4JgLA673XOp3t4s76oIwFcUe+/08bzHIT40xAXqsM+At79R5//+6qjYjK5EQ4se14W5a3fCy6OsxlAZnAQHcNC7h1cy6ClJ/HW/FwUwjowd8gNGiF7MBdbn2qZImh5IC/JYEq4nZzEFrt97//TD7Llas0d0dFGWukHSdvmNURiQdTw5uZv1nosElUHWlFJHSkjp+8Thhd3HcZkqKjitOvo4aFJBeNUVboIrUpRXCMouEOZzDAgVkdHAW1V25VoSdo0js=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1171.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(26005)(6506007)(53546011)(64756008)(66446008)(110136005)(66556008)(66476007)(52536014)(38100700002)(38070700005)(122000001)(2906002)(5660300002)(66946007)(921005)(71200400001)(316002)(83380400001)(186003)(86362001)(55016003)(9686003)(33656002)(8676002)(6636002)(508600001)(7696005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J8j4C1NMIxA90DvVRY9SH4NLaOsnFJxJhUbkfilP5Yh2nF1JH0VY5aVuqd0L?=
 =?us-ascii?Q?4FwUyV8dgyNewO0/bekz0F04o7M1gAkrD9dVfGWJs/tFh0JDfdK/iGoHKlWZ?=
 =?us-ascii?Q?sCXOkwuRUAvVxi4od2VSgsXIqO6vTztlV2s2vNtrNRb4vA1+QLlEez6Eykmz?=
 =?us-ascii?Q?lZkk0wRj7GoUHz1wNf6loj720kEMbNm2TKFm4TJ6aNh3dBZHXP/FQKD0Yo9Q?=
 =?us-ascii?Q?3G1a2uvwyyjgkkGhLr1IufDJmkm0H/lgQcxzd7I/UgTPIETgNxca7LV/RgVa?=
 =?us-ascii?Q?xHRlOLSBQLpk+1S8sJIfjhT4CXhdoefvpkJb7BzHw06qmhULpuWR5BoHYjJn?=
 =?us-ascii?Q?qlkVWWkDL6B/tcE6orAaal3LiH7ZjSctgP8iNkso0x7EIL6qLJxfbrTN/mgA?=
 =?us-ascii?Q?OH1wVTGuCBp53G5fKIqBLPDGL/ocrsA+Uu5mM7r8FCEaru3KI3QOQ3mJSR19?=
 =?us-ascii?Q?nCfQsUQgHCBTFSWPfWTx0xfJKKjx0JHye7GDzs2IaUWH3AUjNAxPYMi2JSzs?=
 =?us-ascii?Q?+k60F9Eh6686B+PmBo+g6kcSIfPARfukjVGBrvRwPtwoSywQoPltTQuNw6BW?=
 =?us-ascii?Q?yooP2kuOY3wGzCSIJdUtcH0ww4CBR40Q2Mkpn6EdMWQYuiYLAt/wJSaIdVqm?=
 =?us-ascii?Q?NuGOK4FKHPRZoe+fs0Mx1JdzQAE/db8ABlJrWyLiMA9IcmPk4qjQaZUK1SxD?=
 =?us-ascii?Q?ZiEuKr0vxsYIWsjEjCQ8ygqi2ygyEoccpxzoLVuK4mIAGMrbgoofz7W5b2b1?=
 =?us-ascii?Q?/93HZCrKRMIxT84bqRYMEeOVVUBh176oNlNybV1+YArCiC2jIp8aFiz96vCH?=
 =?us-ascii?Q?WHgA7nRjl5ipPjUbwhjqfHZX+WQcKTdLtJViGwbDrawEbKQ3sOB5rvigcOnz?=
 =?us-ascii?Q?Z0DAMCrrkrf3SBWh7s3m4FXyN+swPPs3l/OC40Pc0dRJlJ8kJOA2FH0saIfr?=
 =?us-ascii?Q?zH/qqsUy4EJ++hwKJ1m4b74GF/g1es1Z3/k+MvHAbpeaazSyyWBhxkDZlnsV?=
 =?us-ascii?Q?d6kguVggM2B+mgb3qRShgW5IycTuuArAtYE9ThomOQVWAA/ir/vM9u3wku/D?=
 =?us-ascii?Q?NKYNzw5tPNGF2bvsW+kC+sVDyuI6D8rM6GDiY+US+PVUtFnA3N/tFFO+Bcv2?=
 =?us-ascii?Q?XGKRCcQDjIPtitss0RC5MfNEue1LJ03rIItLBR8s555y0ONW8ixF8CyHNj9Z?=
 =?us-ascii?Q?mxGI67QGBXYPzJSLetS3S5VNW0sdJ30PNdrYS9cRQXu3so3QS0XXFvRzRFBU?=
 =?us-ascii?Q?tEOZQvkytoPZjkaY4iMtHDLrtkxZea6xKvDzAbnOwhoQbxYl8sH9rzRkA12j?=
 =?us-ascii?Q?icGyQxSvEhHrfD8VL73fDigpbvE2Fqo9ZLmkTUfiVRKiCFSeA2pRr3D46YM7?=
 =?us-ascii?Q?2zKm2nDtQ4VgmQmEkM3R5USzMwtNiCc/7cJGpNvRtzn0TiA2Boh0N4iS1/28?=
 =?us-ascii?Q?AX5Xyqia7cxqpjdxHtFTquDuti7IZ7dC5NU0cCpzvVMJjhjPJe5Y5K67Sow1?=
 =?us-ascii?Q?yIcP1ZLbBhwO1krsIxwdYnck4oEGkyg5q+T6Zjmn0fAEzFCdhM45mhRsZTy2?=
 =?us-ascii?Q?L5NnPdXpH6avEMPrjWKbZlSfDgu9tktp1X/3RBpPOazE3XtXWcBpW1F22m+A?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658d3c2d-50fe-4f37-472d-08d9d44fb63d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 15:41:47.2578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utc+ocudm6QPNSI2LXcVx5iFKFcCSnmKs14COdvAnTHq1d26N5cqdAvKfm79Ei8zveCsDSjZbP1h50YihQpxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1874
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

I can confirm that the fault no longer occurs when the patch is implemented=
.

Thanks,
Kelly

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: January 10, 2022 12:14 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.P=
an@amd.com>; Zytaruk, Kelly <Kelly.Zytaruk@amd.com>; Huang, Qiliang (Warden=
) <Qiliang.Huang@amd.com>; Zhang, Bokun <Bokun.Zhang@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: use spin_lock_irqsave to avoid deadlock by loc=
al interrupt

This is observed in SRIOV case with virtual KMS as display.

_raw_spin_lock_irqsave+0x37/0x40
drm_handle_vblank+0x69/0x350 [drm]
? try_to_wake_up+0x432/0x5c0
? amdgpu_vkms_prepare_fb+0x1c0/0x1c0 [amdgpu]
drm_crtc_handle_vblank+0x17/0x20 [drm]
amdgpu_vkms_vblank_simulate+0x4d/0x80 [amdgpu]
__hrtimer_run_queues+0xfb/0x230
hrtimer_interrupt+0x109/0x220
__sysvec_apic_timer_interrupt+0x64/0xe0
asm_call_irq_on_stack+0x12/0x20

Fixes: ba5317109d0c("drm/amdgpu: create amdgpu_vkms (v4)")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c
index 2dcc68e04e84..d99c8779b51e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -144,15 +144,16 @@ static void amdgpu_vkms_crtc_atomic_disable(struct dr=
m_crtc *crtc,  static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *c=
rtc,
 					  struct drm_atomic_state *state)
 {
+	unsigned long flags;
 	if (crtc->state->event) {
-		spin_lock(&crtc->dev->event_lock);
+		spin_lock_irqsave(&crtc->dev->event_lock, flags);
=20
 		if (drm_crtc_vblank_get(crtc) !=3D 0)
 			drm_crtc_send_vblank_event(crtc, crtc->state->event);
 		else
 			drm_crtc_arm_vblank_event(crtc, crtc->state->event);
=20
-		spin_unlock(&crtc->dev->event_lock);
+		spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
=20
 		crtc->state->event =3D NULL;
 	}
--
2.17.1

