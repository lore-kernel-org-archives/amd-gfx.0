Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB12C3600B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 15:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D79E10E6F8;
	Wed, 26 Mar 2025 15:36:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p9FLHjbc";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CB510E6F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 15:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gi7zTjb2HYjBD4FQ6whQH+liscGiSWcrds2KOxhhkiR+H3S74YADOXWmZv8eGCPRaxPhbokMLq3kIyigFvSYRXlh2kGCDpVCtYq0BN6HC0q2IGu/tZ71wpmvt45ZS6JyVvCZDuXKEc8ySSlLDxFVfk+JLLZxy0C7Gp3yWS6zBLFhIftPJs6JWEA8cdwrgD20/a6hjVVutCoUp577Eo4wt0JFX+U5gpd03IqaW0qYTK722d60Pw++kkuSDaJte+N/gec2VsEZ/hUgbxmP43rYaq7Rp5ReaHpdykJxcc9jk3gXC3wkmsG9LOYJli36wemvcRZr4M+NpuNquzcM67W0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCXEdsKUu9CnGG3PvSH2Bm88eF3l2nJUZPvOA0K5ODA=;
 b=DUerR9fuvKQ+R7u0Mr+HYtIIVBTEMZZi3NG1o5crVpdtIFK6YcSULCdEY3/amonr5HfE3K/2IfVGGTWL/vnFUm5PbXB2H8ip3FxbDMR56Ibf5DUen/x9aCE1yB1uquDcH/GTa7SpI3Ez1/7ggLlVu3ER2TCs6VvH0uhJzSxeWp1XFrXCmMMP4/8tnTPH4XCKJZ1grc07LUJ/TLKQFlJWTLVihi8zGIcYso/5zU2KHLuUpBefC2D6uM4J21bITdnY7ZDGGAUaFOsmBHN7oK3LHeoMdPT2fed+CkKdJbSWHkZXnt9OPA2eNlqoPXWzmV3IV/EiUo5xjRnon8E+jMN0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCXEdsKUu9CnGG3PvSH2Bm88eF3l2nJUZPvOA0K5ODA=;
 b=p9FLHjbcJTRk3EqNwcpYMwddRsdexWpEeD/ejayMtK8PUj3eK3r2ft71iGrwllau1gpHMaV13mchHILYdYMKaOLpLYvWF5vI0Em00aYStKdp2pV0x5gvvGTBy1DqYP7W0uZxg5UE88a/uxjQhss+LSEAvTzciqmKOHyYz48d/Rk=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 15:36:21 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 15:36:21 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec
Thread-Topic: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec
Thread-Index: AQHbnlUN5JUU5TwLhECEvzQHs0koULOFjG2Q
Date: Wed, 26 Mar 2025 15:36:21 +0000
Message-ID: <BL1PR12MB57532C62D07EBAE311ECB23893A62@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250326134301.1012270-1-alexander.deucher@amd.com>
In-Reply-To: <20250326134301.1012270-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7977a7c7-690e-40f0-8e7e-ee8552dfa1f1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-26T15:34:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|IA0PR12MB8088:EE_
x-ms-office365-filtering-correlation-id: 25e8b938-158e-45a8-d469-08dd6c7bf5ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NFnqw38q+NRn2OeTfg6W90hqL5It9BPXPH935xpVmlIuW0/HxPSVrj4x2FrX?=
 =?us-ascii?Q?609kWTcuejKeT57Z15CfroKnfKlHRRb4jmENYDTqXdFFBKy1NQcA5iJG9d5P?=
 =?us-ascii?Q?A8rvgRvrqH/wxL4XoLcX9R15i8dautx5/2mydMdICIMUf/xt9Z2gcjCsstEj?=
 =?us-ascii?Q?+exk0afW6/2dGgpsEKl6NXrR+FgYv4geqBqh3WbJ24aYJ+IjjKJ3ky1exHs7?=
 =?us-ascii?Q?JUnTdL9na0oZHiFeP4mAXkCRdi8CweV14HYyoiYH+wW+0SYdKgCjZmyGSyoq?=
 =?us-ascii?Q?y3bCCYPr2JpcfpM4ZB11PubLRC3a+ZUngvziToUWZ9GkC/EwbmXiAVK7Z8lt?=
 =?us-ascii?Q?4WDRv0CbHNH3Bxsq64vIRoEXNGwBCTGVYVFXg0rhjbw1aVXEN67TTKJhALci?=
 =?us-ascii?Q?B//+dP6DC4U5N9JVlyJnjejBqAbVv23nqibuen8+tYvXDw4oCTDVYMfVWxfq?=
 =?us-ascii?Q?A4LzZGPzQCgsRP1QjZSNlSETEwtajbhT7rjNi/E+/njZyOAgot3+g+9aMtb+?=
 =?us-ascii?Q?ej+ZthyD+8ZuG5IiUpiEjJvvFfk8p9RBP823AFtGD8Tk/FCmcIEAVUqemMHc?=
 =?us-ascii?Q?HhJdZhPsp1Q551CxfaRgpXcJdzTGPwW4USPzAB1eFZMtoKUfd7LZrjqjqFc4?=
 =?us-ascii?Q?pcCyxcaII9UCc85sCa4CvDq5xF5DKB/qYpzY/vULeA40QcJUQ+al5yWFg911?=
 =?us-ascii?Q?fip8dmzKTBgBPi3s3QSs9F+K6on40vTYMzBc/zJot3yBnlsjJE62HgiubNkn?=
 =?us-ascii?Q?SPUa+A1fm85XMlY2+NlTtRkO2DRjMRMMDJMY+2j6h6gd4A2Io7zo1v//P8Cc?=
 =?us-ascii?Q?wduIgEvAHgey9K/NQAkABxZLbV4SH+wIPStxgoz/Web+L5OCd7B8EbbUcQ7W?=
 =?us-ascii?Q?hJbyuw65gFlxwMPxXUUasuf3fAK5WPDD6/B1kTPjViQictTGmEQn7tnSYvK2?=
 =?us-ascii?Q?ABCmUKmk+gi7ND8pnmHP7a90TlWCIMermcsDdgKCz57ccbVOzw5AYPQ2HYJq?=
 =?us-ascii?Q?PkL0K17n8brJh8Os/wjdi/rrcvMg04tlm1ystiO+29XtdckUnPExjbrAJlnd?=
 =?us-ascii?Q?pgMqsRIHpY8yAIRd2pv/6sGDxQiAkA2op0eF0Wf92CXXNMCOQAcM7EMofPEe?=
 =?us-ascii?Q?RoRKbvkR54LBYRb3np4QHdUDMvS11DSvAaRG9fC0ZGWsnRQJULxKSPBvRP55?=
 =?us-ascii?Q?lC8ua/YkDlKBkwGHnvDHqENLiqs7MMmUVHsgVSMPSo1Vzr8JUfL4ZnCZyYgh?=
 =?us-ascii?Q?VBFyWgJjerBr8z4oq8f93sAa50f8TIj+qeaelanv8G+Qin8JN62lZhbfz133?=
 =?us-ascii?Q?u/aj3FrWeIoHIJzvkl4tlEufohBVzoCoJgtbzy3jv31rjsyXQJmSJyvgDAdn?=
 =?us-ascii?Q?cktdUBE2YxTBkMaN3r+kSJ2+tNQM/BQ2iLiC8l5hgPM7pTm7IKhsmsi/Pb/x?=
 =?us-ascii?Q?nFkCiF2dKzoTwiIhUzJUGuWjgEFELphyu9Ssp0QfpXXYdcjCj99JpQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rlUcXVfP2DCU+zRIj3Tbj8sWd3y2IkUIyT6O9T5RvIq6h2AnsAXKArrqHhRm?=
 =?us-ascii?Q?ByNxlE2XomUgvyR2gKO8ImimbmsIMKy0BoZBx9Jn/KsbRJ0uCtYpx16/+TSv?=
 =?us-ascii?Q?8NbwvaTxrP8+pxY9nizU7k7iIyIAFnvDOhLoks+z9H9NCKmYUykczy9luwDZ?=
 =?us-ascii?Q?k4W98sOLSutnGDPbJyGDbX945MUsQCDqaDUlZ776+tLo9wx9KsyZ4IBXbO+5?=
 =?us-ascii?Q?bDx5ACQZ3nu8r3nqLCyjGwEITma+u4r+iacICJjLZUmkuXgiD+bgYTzj8ZNl?=
 =?us-ascii?Q?mc9DEAsIsmBt24WpEodts+esZlct9haWtsaLNJt7GUcjfCtW756nv7bH3Fl7?=
 =?us-ascii?Q?YOsQ34gRJz4l+EoKBeqYOsZejJvkGEbuYHVB1DlCPRr+Az9ySJds/Uvvuu7a?=
 =?us-ascii?Q?O//DyVCW1/Jg6QqPH2BYATcD94Fi0NOE6Hg7WL92OdweqIxctDiL72rVw/XS?=
 =?us-ascii?Q?5dXrcU18E23xoI7+wFSXuhVBrsC8zeSIU69Xfh9Q6a9LNp6w6h+q3P34vNCn?=
 =?us-ascii?Q?kuu616JH/nOn94gEGUDeUikATj9GTXnU8r10rGrhdYocgiduotkNNb7bYhTx?=
 =?us-ascii?Q?rmHi8Yf1/NVZT3eqxTcshFKL/Gkq4R0Yl/V6fXJ9/va64usnhLWzHUV+KYkp?=
 =?us-ascii?Q?JE8JyDimqwhO2o1qAEfiai9J02pAMaw0kCI4tO32E0TKIyk0HP/YWsj79Uyx?=
 =?us-ascii?Q?+aGtQ5oyHgiscMS6S2lGVVQJc/ibCNOlAKr4qhPQ6Iby/PKg0Nd3Mp42/z/x?=
 =?us-ascii?Q?EOll6weFmVmgYKsqW4v5ZVY/RaVmgHSgk1K/OnYJFc9/rdkFr1ZVewdHeSLr?=
 =?us-ascii?Q?PEQBx0bmZiN8be9/ETi7SBAvvT6eocZpBmJpA1tXYyOGJ6LO1yVP+UNkcEPl?=
 =?us-ascii?Q?SdEY/6AdW221yGvbd4w2zQholYYUEHVRwMC1Z/p2HjFDibOqCwRLEdfvsBE/?=
 =?us-ascii?Q?kNCoAE3HWYMmxkcFpB1qMflpsyZk1BVwNE8X+Wluc1zRseFzRd7m4dCWNdUW?=
 =?us-ascii?Q?8ZaPObQ4JRAHh7nhUbZH8yjpxAT9191d485lVyMNgGvZuGtyn8P4a2+/PsST?=
 =?us-ascii?Q?zrEroojtWr6js+zfAkHJHgvUAOVx4yZAdnUt/FxRnTlEEy7uWgTiiMAkx1BQ?=
 =?us-ascii?Q?hnwmCqfVI4byogmp1oCrcC9GL8IO5n7GBBTuhJXZlrhVA3js7v0Accw9KEwK?=
 =?us-ascii?Q?Gdv5Gbpzg3H4iLCsizJEMGFSKLJEWcvANLK4JIL4VQphSe0qwr/ibK3jNAZT?=
 =?us-ascii?Q?ph07++zAANo1whqi31gARVb4OdvUYfi3f6K/YVWVWw//FyrBDsaMTdIaLl2M?=
 =?us-ascii?Q?wNYls3iRvoXMsbjXNh7PytdsAVEN0gHWxCLrD9aMFdm5OG17G84xkHN2xzA8?=
 =?us-ascii?Q?No/Lal3g+gJ5QBYxRf7NEcw4SsNsN0fBMfT6KjiStaLv7IyQktdhDlG3AmcO?=
 =?us-ascii?Q?QZecj8D6t3S+XCnWDN3eU82H6kQk36aTTChV5fwQE6ECGOTZ5DLuEJBMSNOC?=
 =?us-ascii?Q?XuxLPmNMsZGhkZEFUZ3gSmH0I1esRdLLCSQPlBpwp6t2x0c1Ss1rzYLH0OVT?=
 =?us-ascii?Q?f/2YGZYAwysPOckBL5o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e8b938-158e-45a8-d469-08dd6c7bf5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 15:36:21.6743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMU3P/HjASJkozh2FZ53VcBBCyUgWZ2//2W0cj9x+VRdHBYmX7L7ovwZMIMtGixowxH+bIM2oDy5tuRi+ql1LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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

Gfx11 now we have same values, hence we don't need to differentiate between=
 two sets , only one set is needed like below.

As below
case IP_VERSION(11, 0, 0):
        case IP_VERSION(11, 0, 2):
        case IP_VERSION(11, 0, 3):
        case IP_VERSION(11, 0, 1):
        case IP_VERSION(11, 0, 4):
        case IP_VERSION(11, 5, 0):
        case IP_VERSION(11, 5, 1):
        case IP_VERSION(11, 5, 2):
        case IP_VERSION(11, 5, 3):
                adev->gfx.me.num_me =3D 1;
                adev->gfx.me.num_pipe_per_me =3D 1;
                adev->gfx.me.num_queue_per_pipe =3D 1;
                adev->gfx.mec.num_mec =3D 1;
                adev->gfx.mec.num_pipe_per_mec =3D 4;
                adev->gfx.mec.num_queue_per_pipe =3D 4;
#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
                adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_funcs;
                adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &userq_mes_func=
s;
#endif
                        break;

Regards
Sunil Khatri

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, March 26, 2025 7:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx11: fix num_mec

GC11 only has 1 mec.

Fixes: 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index e0a9b10d645c6..a9ef33205c541 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1573,7 +1573,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *=
ip_block)
                adev->gfx.me.num_me =3D 1;
                adev->gfx.me.num_pipe_per_me =3D 1;
                adev->gfx.me.num_queue_per_pipe =3D 1;
-               adev->gfx.mec.num_mec =3D 2;
+               adev->gfx.mec.num_mec =3D 1;
                adev->gfx.mec.num_pipe_per_mec =3D 4;
                adev->gfx.mec.num_queue_per_pipe =3D 4;  #ifdef CONFIG_DRM_=
AMDGPU_NAVI3X_USERQ
--
2.49.0

