Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278D7CDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 09:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA17E10E1A6;
	Mon, 23 Oct 2023 09:31:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0FC10E1A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 09:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaI92l6Pzql5ZrkIb892SNTH0c0EpyBSYUntwVgrXoz09nHnE1wooCYZ6xw1Xlmo5JYwxkdHOGcDx66r5cOi3YrUCVDDjDtLUEUWMFqEdGj8vJg6uVuuuogTKaTcuY/Vbr1j/MTr7eUv24zkVLYvkFDDlv6qZs/5MEOI4ztVafCx5OWfOn9DBdYSxnoYEtw4uynAUW/Wy7/9SzGNqAbN6C0L6uiTkOhLL+E6gO/a29SxZ/YxGhdLF/07RWHKhNWUt2mTwm4Dy5OkDwhByoClruAttLwdI5olEQk+uNoAZls1RmEfEGxsbkhhqYgp1NG3YEUljCljpa2EuY1/aJLLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GstuGIE59avu6LJrVAxEhxXO2IoK2E9C0W3o0QwagW0=;
 b=UL6CyHn2d5VC7pi0VzPhKxXlSsqGyRpXvtoSbkxNwx773cXR4YROaFUYxShKXdSzGyymLCZCUlVdXNriO62GsI6Kq3L/8mZ5/Zu21KRkDkDOxIxNUCR/a4SWh4lSmqX/7ILUOJUAr4bMDQXqlEtcsgSbZvB1wwSkTJZoUrh7UTaB/p9NJM9FgPiOdZsoEl0DvhwfjYecRwcX4vpIHoRomBeUp2Lz/F7JO+CJMEjSWQ8g4PZn0QJjErXdjlIqrpixhKjWOcSJGn/XwEnGgzQwhv2pVWNtzOvhJ+uiVOXdBBvYIIwplxjouDqryyaSnlVGmSEAI8cM8xsyFBPXy40wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GstuGIE59avu6LJrVAxEhxXO2IoK2E9C0W3o0QwagW0=;
 b=Pj8S9b+1L1Y8NmY28LCCbwCD5eQ5D1YpKvB+0042xwAtuLWOyE3sfif0qAtj0QyUGd7mDiz1GQjtDWZMGV+oJbq4I184sLcCOzp2N9aFLjoUmS6CfqMrMHISvPTpH2eqrVcK4U8SVe481s0d5XmyAqKiIp8HFY9rUG89R2Dt8aI=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 09:31:42 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 09:31:42 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vpe: correct queue stop programing
Thread-Topic: [PATCH] drm/amdgpu/vpe: correct queue stop programing
Thread-Index: AQHaBZLQqV/y+OB/5kW+00r/cinAFLBXHDJQ
Date: Mon, 23 Oct 2023 09:31:42 +0000
Message-ID: <CY5PR12MB63694D2499A81E1A970B98DAC1D8A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231023092452.616747-1-Lang.Yu@amd.com>
In-Reply-To: <20231023092452.616747-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=66c06559-2b3d-4849-962e-01840639f080;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-23T09:31:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH0PR12MB7078:EE_
x-ms-office365-filtering-correlation-id: b6fc9ab2-ebd8-41da-5674-08dbd3aaddf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q1660t5SIDkLP0xq6Vyh34W+GTVyfVvdQxGo3ci0VNsXCK2XuwwVBdbrbAnQChtgur9o5jYSH+Z8XnQ0mRarnqMk0Rb9/rPzQeE9oU0AfLI7Ex7UQGP9urzbFGfyZo4bfAv3BTtuzAqgLDv9EnX4aeNlPACYjnSuaLmEba8KQnX5xCC9wS+d3sp9VzUJXTaU+8qefYTn5Ug/5KfXpmhw9+ZkW27a+vf+t8GtxowRqqrd+NseMbJw7INI5dGKI/DB2H1x+rYY4AEaZhYmGEXj9a743p3HJFmvyDYsJgEPO+ySL1xBRp6hdvCONBslVu97r66XeLDIxG8y6x9jM+b/Uhreh/XAX2n4x4v49EHXVeoLyoi1ICbBSsa1092GxK33l4Z2U4clE8WFC2j88Ly6I55Vl5lY9Qswx3w05Ezy6zxa4v9l7s6zcYr5axVzdSllrYpazSctsFJJqqz32ADT5yXv12jCix+R8iicuEK7kHSlrKOHlnXIDTpxtkgCUJH8goONeOy3fucVqN3M0qqGnra/BwELewPeoaH/UmCyT6SfZmwKEYO2JJLMouzqgoNp+WDziS0SP933arKqUTZBM+xOIwZBQcXM7Q96u8tdTrfa6iyE0XaMkUIk4/tWhZox
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(38070700009)(38100700002)(2906002)(55016003)(41300700001)(86362001)(52536014)(5660300002)(8676002)(8936002)(33656002)(4326008)(7696005)(6506007)(478600001)(71200400001)(110136005)(66476007)(54906003)(122000001)(316002)(76116006)(66946007)(66446008)(66556008)(64756008)(83380400001)(9686003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bkHXRDhqmxiIFieSGYYKpNEcTY2dKZ05i1htvJ/zVzDraD4/ggF98DKug05a?=
 =?us-ascii?Q?JkNs63S40MqRbpe2fgXp3vJ0ydiRdzGpI8KhSGHMt5l5ghJNE2kAn/HJWL4a?=
 =?us-ascii?Q?4ZIDnkszbsWkE35P1e96KNzQq3ta7XnazJmcdiIL8AoNdouPAZCrz3Z/uU9y?=
 =?us-ascii?Q?KdGDTTnlJ8gDKXTH4GCwcXOlAdaZfmW3wMaaxO0PiFOe4SI2iUmEsOZnY/33?=
 =?us-ascii?Q?SiXmetj1vBLCI9Y6cfr8FS5LjWKa97Ko+2tNcDzEMCC1RZv7/+oaW5hlV/EX?=
 =?us-ascii?Q?ZllBe9xhuhEnryL5YNj0yfJaWb3tXEIDAnpLHIDUO/UfUaoAxhAeAHppPgNp?=
 =?us-ascii?Q?fDCpZv3/IQ4RW+DoafVAIYxxBcJn4vgDDUHzjwo3iVowTxCivC6q4k3kmTN9?=
 =?us-ascii?Q?l9HsPoSKpbMnxyBS/oa+x8z6v8xpZstpMpQwqchWVz/5mnCGLeg+vDDycXFH?=
 =?us-ascii?Q?jzG0MTikXg0nfgMUpio+PcSKTrJyPhIkM8mGw6v5mscWXontOVaiv11y9w4o?=
 =?us-ascii?Q?lMAC3Mhtx97qn9BRa4bjFkbQnU9H2HbEAjuCodkTczE6W2YPP9Don2gCrHL/?=
 =?us-ascii?Q?m0qtCfhHIBmSXx8XMls9N0z8CbS88B03dG+A5T0tBFG/fEuJ5e0InHP2zGok?=
 =?us-ascii?Q?oX9R0dw+jnWqhm2WwbubTIF+WulfNCa0wqx0WJk5vf7mwWbTKJ3WWCFmb9xM?=
 =?us-ascii?Q?EOUz5uAfwci1CQavWnG0Sj61OaVdFV+a3Ddc++LcS5FPlT+a7CyuHRQFOp41?=
 =?us-ascii?Q?6J7vY+tnWl5rlDxEt1GnW4L/Pw+YmfdL8HvaTw9388HSyvfwiUPpDqTaMwgM?=
 =?us-ascii?Q?6BsOlbODN0XAD7ffs01xRdl0gLXhmRlMEjI+BRumP4cFcNSyHO55agSu0/83?=
 =?us-ascii?Q?/4fi4yNW2bG+cBKNM+H9cDX8en+jMy9sC2EiICJCnF3SvvIpneqC5JHznz+5?=
 =?us-ascii?Q?UTkuyoYBfMv9q047VBxHiprwjyyTVYX9Zi3MHJyeVeHZrI/M1RygOsWHSDCy?=
 =?us-ascii?Q?NOihK77JgyxvTzuz4lRtBK9bvHO3p1onAv13fRop9R4PSenoNRlqCL7kpT2l?=
 =?us-ascii?Q?9bNyXPd9f+eDi7HwHPMqXEE58bx85H6Y7fbgnUCtoXHbablTuJX0FUIrU6Uq?=
 =?us-ascii?Q?A8NO658QDA5YR7BuTQZltqEFDhFK4iQIE4rvBVE7DSsToNqrOfN4ROvc1d9k?=
 =?us-ascii?Q?trDq+042rf/URc+7Ns6tAcZIm/YdJTLicRyk1nXDb7uUDwPCnl0Uc7+DbVP6?=
 =?us-ascii?Q?d2UoQBdOeSjYRmaTKodt2Ze7QCL/UbjUHebcuivQPdZXluiyp83vm++qsGUD?=
 =?us-ascii?Q?j904dtVqdm7MI4TNrwAzSROmtojyoVGYT+kX+9+pVr1g34YnB12Xo5c6xDwr?=
 =?us-ascii?Q?crZAxhMUytbQL7L3w6LyzsDcQ7NO4X7A1mHZHIvUMgMzHtqo8KAVMG1W2TWX?=
 =?us-ascii?Q?h1Xw7YNyxla0a6vgPcLfKP5KadZZ2mhtRVOIQzIrytI6k670gDvkdZJ/g77k?=
 =?us-ascii?Q?YkE9SO1ht8cP2e+MR+FtU3HyNOHERooeCyVXNjZ5WtbveV0WkdcbgibIHJ6I?=
 =?us-ascii?Q?D2qHA9Ir9x47s2FKlTE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fc9ab2-ebd8-41da-5674-08dbd3aaddf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 09:31:42.4179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwvdU8YPjABpScOnLp7qIsoWmaNUqnDrQHjU8rUPi3mCSuirHvsriZY1r6hhmPiq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Monday, October 23, 2023 5:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Yu, Lang <Lang.Yu@amd.c=
om>
Subject: [PATCH] drm/amdgpu/vpe: correct queue stop programing

IB test would fail if not stop queue correctly.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/vpe_v6_1.c
index 756f39348dd9..174f13eff575 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -205,19 +205,21 @@ static int vpe_v6_1_ring_start(struct amdgpu_vpe *vpe=
)  static int vpe_v_6_1_ring_stop(struct amdgpu_vpe *vpe)  {
        struct amdgpu_device *adev =3D vpe->ring.adev;
-       uint32_t rb_cntl, ib_cntl;
+       uint32_t queue_reset;
+       int ret;

-       rb_cntl =3D RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNT=
L));
-       rb_cntl =3D REG_SET_FIELD(rb_cntl, VPEC_QUEUE0_RB_CNTL, RB_ENABLE, =
0);
-       WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_RB_CNTL), rb_cntl)=
;
+       queue_reset =3D RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE_RES=
ET_REQ));
+       queue_reset =3D REG_SET_FIELD(queue_reset, VPEC_QUEUE_RESET_REQ, QU=
EUE0_RESET, 1);
+       WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE_RESET_REQ),
+queue_reset);

-       ib_cntl =3D RREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNT=
L));
-       ib_cntl =3D REG_SET_FIELD(ib_cntl, VPEC_QUEUE0_IB_CNTL, IB_ENABLE, =
0);
-       WREG32(vpe_get_reg_offset(vpe, 0, regVPEC_QUEUE0_IB_CNTL), ib_cntl)=
;
+       ret =3D SOC15_WAIT_ON_RREG(VPE, 0, regVPEC_QUEUE_RESET_REQ, 0,
+                                VPEC_QUEUE_RESET_REQ__QUEUE0_RESET_MASK);
+       if (ret)
+               dev_err(adev->dev, "VPE queue reset failed\n");

        vpe->ring.sched.ready =3D false;

-       return 0;
+       return ret;
 }

 static int vpe_v6_1_set_trap_irq_state(struct amdgpu_device *adev,
--
2.25.1

