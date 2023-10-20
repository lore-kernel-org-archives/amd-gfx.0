Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F945C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 19:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ECDC10E5DD;
	Fri, 20 Oct 2023 19:21:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70BBB10E0FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 19:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVMCVWAmIlECdcY8eh8CmxnuRMICoEYbJOdXE/jysi9v97+APde3Ym31ucyhVO1E+LTJMU1FTV62LRFeebDaw2yMOu2nWxIiujQA7rEuGzRT8PZM25thIRFhVjLIciG78A32H5fwvttUU5M5zDuqj4EgCZqDzuobFdlo9PQuRoEnMPkqqkMlpMNbFUwaUOB6aqTvFxIYoOue7+ih0AwHbKas5cYHjAMEU4redwEfq+XjWiC7OAii9zaZCH/6h+OFaG7ggx2czvpw1sDn9pCC6jpS6dDzsgQDbFlc2ED7HYCf+oV8FmLEUcolpXHG/6/eF1Ks00ag5NSsgnIh4BHmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp/GufJT10JpEhq7H5PoiXOgBqhi2vh6BS3bxjUAPss=;
 b=H5KIe31iFNDce38AaSPxffdt++tNs3XTEQDJZsbTCBr8psl12u+Jn7XXiZyMVyV2ESyMLgEnNxuuWXa6zm9eTXtCuEN6yYjE8k+5AIwVaoY5KJq9qYpZjHQpiNiOhEabc+jDc6uf+yWnoLthSNbwiu7wbPW9ZkGJNgMfzp6DqZL6LDTpJ7aWWMH1M2GW0bILBiWSOXysWVueFcvq31dWsEkFnJbq+pwNCQSUpsW1AqhrQPbgOoGAfkB9Jku478vhzh4mrGcz3j+5haqU/ad1G2SlCktDqpbhRo86s0m+Y09rDs+01B1kWTtNU9z2u5Wf8x3OJQcwA3WZVx0xu74o1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp/GufJT10JpEhq7H5PoiXOgBqhi2vh6BS3bxjUAPss=;
 b=XJGg1bng6bWPUyZWIV+WyLc6MHM4WRMt/T8c9RDUyXrb0YDuwxD3EAEW+ybyPwZbIlwHcxhu3OD8r1z9LhgYRlZ6dxv2Fg158mTuZy1Vk5lr96yz4P/uaBNuk4yMa/MNmOeF6f+rVHue+mwoB1LN61QjNUMjniQZOdGos4rgfzc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 19:21:16 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::def8:c635:30da:20ad]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::def8:c635:30da:20ad%2]) with mapi id 15.20.6863.046; Fri, 20 Oct 2023
 19:21:16 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Fix DMUB errors introduced by DML2
Thread-Topic: [PATCH] drm/amd/display: Fix DMUB errors introduced by DML2
Thread-Index: AQHaA3SBhOw2KhPfCkytl7qR7LNpVLBTDjAA
Date: Fri, 20 Oct 2023 19:21:16 +0000
Message-ID: <DS0PR12MB6534D54B82A08134C5AE0C689CDBA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20231020164241.463789-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231020164241.463789-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7be26458-1752-480b-823e-5740796ee40a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-20T19:21:12Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MN2PR12MB4551:EE_
x-ms-office365-filtering-correlation-id: ef40a5c3-39ab-4e6d-05f9-08dbd1a1bb5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dW/BdiKdNYzxFBcuL/2bEeJtm3A64GtXVGD6xn9WxF8GD3NrV0Ri/aviTUlitcc/+1jQuQT0imHo41siuhzoHSz+07o5NWtirqUEP/WokYz1USIwYJIfCn3xjZaVV0n6Fa8xUE0duwQDZ/aN5VhZwaDHR+puH1vzjrJiw7vpFbPViU4qNqaQGEWlagGCIy+3+jSNMkpuwAH/xyUreznTqPpoiNSOFawxrOIwwepj7SZM0qrZJjsa1snyivRhaXo/X5KN8qmksvu+xFwW96igGIULFhwNOtrijOAlp3aKbyOujUbkpgj0d6oO4YbKzSSWUJPiJAffhwo39FT94BgygX3Vc1M6LJ6MJXNrt0sUYm5Qdf7LHnFQQpxRjBL8JlZf+z+XnTDuoDkiwpZyZKeiAzNH3fB+18PqT5qrg9NdhKPj4QBLF+2eTZePO8GqiSKtM68xe7vfalSgtwWb3xep1wCWfTapp1IYxzrhIugWVwvn1ZSDjxVNpeNmixIZRVEJYpG2bgozex5YX/7VQhvVf/0w+yOvr/w5wZ0dIVgBI0lvr1mmvODNqosMUR0uSraQbH5WzYyX/dukpZeveD7Hxf3bTtpDnwN/dq1+za8OpXk/3j3S1/gqlQwWZgqk9cEd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38070700009)(38100700002)(7696005)(122000001)(33656002)(8676002)(26005)(316002)(66476007)(52536014)(110136005)(54906003)(55016003)(478600001)(66946007)(66446008)(4326008)(5660300002)(76116006)(83380400001)(64756008)(9686003)(8936002)(53546011)(41300700001)(6506007)(86362001)(2906002)(66556008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7nY08LFqp40iGCoDKg8ioko29DU9h78aUdQa4EottKrszyns74VCbC9Hkf?=
 =?iso-8859-1?Q?PV886r0CpbJDrfrPkIWNZOZnqlFJtKpSOJMl6Dt884BNtV7TvZfPsERe0S?=
 =?iso-8859-1?Q?X7dVzRU3KZY+wzVoFFv67sQPC+Gpu26QLFHyrB0Ubf9bJMRpWJQpc1somV?=
 =?iso-8859-1?Q?anYIL9yu0iwXvkc2reRvoRj3G91/mm6vjcZKNek/sM+aKNhLVWEseakPy5?=
 =?iso-8859-1?Q?wfBB54nH5LLPF2j4nIw1F1xvwV4fMwvB2T15QeGG4kV/gECK+CFd0RVjyk?=
 =?iso-8859-1?Q?0T8nE1YVLtlFRQN4i7yzkLdQpT9xYrPAJYHKXLWzfR3QKcUQKZoPALSoEt?=
 =?iso-8859-1?Q?ZB+41ykWT6iEEqfgwway5qlj2rrxXLz3+SaWY/NyZRt30UMOYN+SZgAFR4?=
 =?iso-8859-1?Q?PUdGMH4NUMxNuJzE1166o1q6PN4R74VhHBQy4DFQlZnkUAVYe3mX29dWPp?=
 =?iso-8859-1?Q?TeUIQbYAXmLqdp3zU3gKgOpnU3QHf5PsfMr3gFTbqZmz8BKHo7RCymS8Ny?=
 =?iso-8859-1?Q?cDlMp8uG6N6aVkUUvePEDyl9fO9cDcx5mLRNA3VS7WQmdGpJ9j9X32jwSB?=
 =?iso-8859-1?Q?B+zb7QXf/ykVaXoGY46SQLYASmLRys3JVaHT2aE2LWFDlWEDR66T9GI9D0?=
 =?iso-8859-1?Q?CZ+DXKYZZypoOQduoxz4C3qfiyD6RT1i/hpspS1C9axRhj0mBYHunihCOD?=
 =?iso-8859-1?Q?8IAothb/+dfrw521aqSLM4UME5zmNenolEcsptWDknFZsFTnHsjGEojN6K?=
 =?iso-8859-1?Q?8h1o7Ez1o4RGIrHZcjx042vunPi7m/UK4PnuIfosIsaMRd8Psuc8ubbMOt?=
 =?iso-8859-1?Q?CgJM9mygvCQ47SPjKDBSLcNq+6Z+MAG+SvE5UTeu6ThZIs7hebnBJwm9ZG?=
 =?iso-8859-1?Q?7O+EEplYkoT/wxJzW6SBvyKOCdYkFt79fTDUGUiygZeGGntfAjLCFiTA2U?=
 =?iso-8859-1?Q?lbkKsBmreqQXFm4IKCWD08lDqouYxUaRmoYQsXi9CxsEpIr7jqihfmoVHa?=
 =?iso-8859-1?Q?YXkzNXRVE0pOoURYwakWSv1rXf2hzPmmfq6u+l9jPLJf0RsnEVKFjJHZDs?=
 =?iso-8859-1?Q?yd3aikHtsnWXx3NiiwXEuVL3LRiXunvvhXXSrWFwCIx6QQf+vzmMc943Vk?=
 =?iso-8859-1?Q?Y9xAbSlA6k85qpXUBBD9punjRVcZYFbdpGHAH//jVe8nMNvj32iEKgnZ9x?=
 =?iso-8859-1?Q?ckBkE+Lp/tw6ctv2xhSOXydmX2+yjRXU9rQy4+mPqIPgTToNLLBE3F3rxL?=
 =?iso-8859-1?Q?yg1KetTifzxLumtGoNIVsNnDIWLvAPx9kggxNT0SZ4A95jjnRuL1lISJeE?=
 =?iso-8859-1?Q?+cFhU0AV+mt9cQD26YqDootuMFBxt699uSvPhzhOmKu9cPuvFC63QsGuAg?=
 =?iso-8859-1?Q?YUwIo5IwaovUaBEkS0Rp9cOLjxVQEB16aZlp42XAWXdsXbC4x3oqb/Xqc7?=
 =?iso-8859-1?Q?QH3IP/t7GpkMB126NRlqjDeyrg9cD5aA6B0ukb5n3O4zdI4BIhczpJXL1t?=
 =?iso-8859-1?Q?oYUR4FvuOm8szG35KGbsU76/YJ15/8fU1JwvrltPIWQjozKdCGQMoJe3R3?=
 =?iso-8859-1?Q?JdZIywk84qKOlFDGSXlKCSv6EejdFYYFiqkhBD2tuaj5JxDCElvOSsvZId?=
 =?iso-8859-1?Q?TbJhKsiIB4c1M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef40a5c3-39ab-4e6d-05f9-08dbd1a1bb5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 19:21:16.6194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGCSe7UduA2/xdQRVmclcM1cg+8kjOXoexulTfYJlt3mgf9KqiL+mbFshsXdAd/C0HY1Bpx7urpasVpo1cuXeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhuo, Lillian" <Qingqing.Zhuo@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,

I verified that this fix solved both a GPU init error and a hubbub2_get_dch=
ub_ref_freq warning when re-enabling the amdgpu module.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Friday, October 20, 2023 12:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Prosyak, Vitaly <Vitaly.P=
rosyak@amd.com>; Li, Roman <Roman.Li@amd.com>; Zhuo, Lillian <Qingqing.Zhuo=
@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Deucher, Alexander <Al=
exander.Deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix DMUB errors introduced by DML2

When DML 2 was introduced, it changed part of the generic sequence of DC, w=
hich caused issues on previous DCNs with DMUB support. This commit ensures =
the new sequence only works for new DCNs from 3.5 and above.

Cc: Vitaly Prosyak <vprosyak@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Fixes: 7966f319c66d ("drm/amd/display: Introduce DML2")
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_resource.c
index 97f402123fbb..73cc6e1b0e65 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -321,10 +321,11 @@ struct resource_pool *dc_create_resource_pool(struct =
dc  *dc,
                                res_pool->ref_clocks.xtalin_clock_inKhz;
                        res_pool->ref_clocks.dchub_ref_clock_inKhz =3D
                                res_pool->ref_clocks.xtalin_clock_inKhz;
-                       if (res_pool->hubbub && res_pool->hubbub->funcs->ge=
t_dchub_ref_freq)
-                               res_pool->hubbub->funcs->get_dchub_ref_freq=
(res_pool->hubbub,
-                                       res_pool->ref_clocks.dccg_ref_clock=
_inKhz,
-                                       &res_pool->ref_clocks.dchub_ref_clo=
ck_inKhz);
+                       if (dc_version >=3D DCN_VERSION_3_5)
+                               if (res_pool->hubbub && res_pool->hubbub->f=
uncs->get_dchub_ref_freq)
+                                       res_pool->hubbub->funcs->get_dchub_=
ref_freq(res_pool->hubbub,
+                                                                          =
         res_pool->ref_clocks.dccg_ref_clock_inKhz,
+                                                                          =
         &res_pool->ref_clocks.dchub_ref_clock_inKhz);
                } else
                        ASSERT_CRITICAL(false);
        }
--
2.42.0

