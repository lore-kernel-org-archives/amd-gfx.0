Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44B5ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 12:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDAF510E09D;
	Tue, 30 Aug 2022 12:34:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD3610E0A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 12:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drZtXrQFOb1e5CLvbe33z+9eWOnmj0ZdbNc/tcvISOXqGw+FnAsafwNVUzJ63O/RkosuaNpRakfPA759zYLoQNqm2Kue8WOEGsWjxlnYyGjsajtHGXOkPT/Qxat0XQ/RgfwCNIOPA2XmyX2KkFrobRldxcAcimntxlfiqHeFowo2U01kSqsigDUUTcnj21yml8hocVn04BNfFxbMhjjJAk4bmHSMv0PpewFWUJhjmcS4l7aONU3PASdAKoveVlyXO9j3ds0AyzyuQnVSUzgi85GSm07MA3K94bm1SJk74oPU+q9E5dgj/pfhiGf5UkLuspV76IgmfbrKedOObqEZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeZvz/ZtBkJav49foJFJyDqpHHl6NJoKf2AKPOctjkM=;
 b=e9PcUI1CzTmmXq6yeEc5zJXJUVmNgQ7NTTBJsE7KryPvpUfiP3wREJrjTaVhO2e3YUDjLQ7IBwpEx6SPSoPrgx+n0BCIWc2mLKgzvLMXvKW2gsoGDlc09EUrChw4cBxaaMqz66RwT2a1IT4oDcF3C54aI8FDkB6EgD6eVPyDXBitE1UE9s997er5Y+FZq66Ea9AySMACFca/U5PvKYH4OSXa82lTqYs/7t12yswZc5j/IyPxiXPjnLTkdGNhQcC3HtH4kCzRi0RcAZC1HYsxZX4mg7h+mZZDVwsCWdPs41iwMxNCVaxwa6SPBp7ZSyJ63ILcUY3LAJV9oim+pvGQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeZvz/ZtBkJav49foJFJyDqpHHl6NJoKf2AKPOctjkM=;
 b=yhBiDukyLcsiBLqlgmQj7lJlQwvsq2RjO2m6wbRLvDwN5A4QxQbn6pOPCeV39JK+bDbUlVIm0Zga6q/40yVpVfnDoIF/vo/DxQq4KwfNQa06dnm5pwDMeXYym+v+eGltsUlFVd45RiZ87Kp1D0brz87souHza1GNfYDSO5bg37k=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Tue, 30 Aug 2022 12:34:10 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46%7]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 12:34:10 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Remove redundant reference of the header
 file
Thread-Topic: [PATCH] drm/amd/display: Remove redundant reference of the
 header file
Thread-Index: AQHYvGjq9nJaq69lhUGXWWeuORkJ6q3HYEcA
Date: Tue, 30 Aug 2022 12:34:10 +0000
Message-ID: <DM5PR12MB246903B9942CB68ADEB72CD5F1799@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220830120553.1482014-1-Jun.Ma2@amd.com>
In-Reply-To: <20220830120553.1482014-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 220002ad-da77-4ab5-0537-08da8a83f04e
x-ms-traffictypediagnostic: SN1PR12MB2480:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/oEEFXrBzHLkN9+gD372rqCI4PINgnsP2ugihQbkjQsEFsG20Lw9mNqtUusVMJhfn4ovDU67SDXwEhmxALlAoO+4ihtTObO4/yEZ3DgXmnu/LoqHPSVWzIcK218GEqp56WLzW673kw7Kf+PE+UJXNe1JgtVtmFZDwwNjrpSUfZEiMWOPqdSbjsoQ2nhMbmwvBTH6veh3/wpkAn7HgDrmQQpzEZLVmK9xQ3f8T2XHoW/pNQ+lwSDULEwNd/VdNQsOW3W/B5ZxW0GI8nYTzT6AOL7aZUozeW4uRCfAzoroyFJikxD8KLElKqYoUEuJ5XxBSQKXsRFrJKGgTs5qFI0CbLlsVR38m8KxMT+FDpIUECjBwZZgvogfezc9tUy0T/Y6cFA1g7hm2me9MIZy6g2CYUUcvquylanZKjPeP4cU+E7RkHWionB3VnGL/1vYiGDZ+GIR5NupNkqWxHjocrrkGTVcc3KPvzHDtqUJXtD35iwZi8BKrsyDFujQ0qnDLNZAbs/em8uw3T6t1SXEffxltopiABM4EUmIA2y3isgKqqr5EoEXwVu4gk+emYUhx/lCeSXAXvDMLK+irg72WGZPdQdSzi4jbazTzGXbZn85QYNe1zM68EinPRA9QGzqR2XK0EPGXnYW5YIf+EYAaNcd0mAdm7ti5FB17afts75E6OMJYr96hHVxi0cBCrAJzVLlwrmOXLpaXgaW0GjUAw1OaIosevL504ynMxcOdzmDxL6/WU8lynpk2DFQVjKwDwM5ZdhN6q16Xqw+j5SEqzedQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(64756008)(66476007)(4744005)(186003)(38070700005)(66556008)(55016003)(66946007)(8676002)(7696005)(6506007)(76116006)(53546011)(71200400001)(478600001)(86362001)(316002)(6636002)(66446008)(9686003)(41300700001)(110136005)(26005)(2906002)(38100700002)(122000001)(52536014)(33656002)(83380400001)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O7Ztwlm01j3g2uElN3N3CKXx0KLy0AcvczRPr88PAXNmhEn3lO0FfzKX91rZ?=
 =?us-ascii?Q?qfOXrf35lnBR9n3epfoMJSYgQ0wk8V6yJojR5P/mXeYzA+zeWNyxvui68AY3?=
 =?us-ascii?Q?4DwQlYw+Xh7a9+0MJE++zVBOQAoL3LmtCYpCOt9LfGOT41HzYnv+UVn4d9Gt?=
 =?us-ascii?Q?eHiJKiEqbSOTziNskrB040X0/UP2Gph3u5IvN8M7xW6dEaiixpfuI0QLIeNS?=
 =?us-ascii?Q?leBn/U/usPTzFbBSSfSqqbo/QNp7bZEvsIMpsqcz+lppODrHpmtRK5P+nA6r?=
 =?us-ascii?Q?n24PaO1BuM+/H+f2W9dbxfmX0mrM/NmD1a8bOxw9A+t4FUyo2NWYM0DmpqLH?=
 =?us-ascii?Q?9jUJIOC04gWRHrJJXuZtrUZJ/oV6w28jHBsKnAdyLECFrphH1bOtPM9mVHfj?=
 =?us-ascii?Q?XxfbFNCNkWgDnXDDB7JS1ht53gHaq3xr46Lq5eFRK9RbT/xUo91uP5cZ/DBo?=
 =?us-ascii?Q?HlHcf1dHKSbxseKKmApA98VcdlGqsO7R14q0bp7nE1Cib27kfbsj0W9RpHmD?=
 =?us-ascii?Q?MIlXktcsISbkYnNSz05IJzW/pevLjTwyZOjUJxpubDQIdXkyW+1jKo7Rsu1m?=
 =?us-ascii?Q?s1nfreDtTyQJzzAjsUaJp32Z+7PvVT3D6jO8CAL36FVphAFEu5iz3MoFPfQc?=
 =?us-ascii?Q?hTT+gLdJY+PbiMprB0UkuJU3h9bWsmNqshxwzbuLtZbAiwGQPr3vFTb/dFCP?=
 =?us-ascii?Q?fAiwNRaFLOLZv1NJzv2sECToHJBh+7YBpoUlGckXtzab3gy1UvDdksbqWI9O?=
 =?us-ascii?Q?Twjc94dR3RZ8PuSsMW3aI4mM2P5UsULkvCBSMRc9cp69y9/D+FYNb1ulwhBq?=
 =?us-ascii?Q?jwgKY2OWZwwtsCYceOdH9Ox5Sdq4Hbzi/tI6Yfw+zt6e26zRVvCYaY/1WMeJ?=
 =?us-ascii?Q?S3kyQ0QM8XrbaxuUFWn6gT+jv7slUGrvgmxZAkFkCuovmS5/uxO92Nkwpejb?=
 =?us-ascii?Q?5qj/trq9dHkl+WazkXiP6kKwvXZ6laYa8wglF4NzDUTRdyulOeNbqU0NI+nt?=
 =?us-ascii?Q?zMSFtmpfRfEHJOuRLEFlCYdVYS9Beed/MvHGi10+17eC83cMRZSDRvDYTD/e?=
 =?us-ascii?Q?hEW7014MvVNbqleKg4tDr56h9V/zd1QhB9sLoQqY1ZMtvjy3PYBOKj4uoFsW?=
 =?us-ascii?Q?MFcHKAA/v4tLiYbNZbWXO/+Q0pjwFiEQ1iU3p90qB6L2D2QoAxmL+GGEAcJT?=
 =?us-ascii?Q?cSGmqQ7NYbR6JXHseMT4LAMBeXIVUJDdjALL7Gs6YfVAV6qTug6hSEGWPC3B?=
 =?us-ascii?Q?y3SgVELzb+X7P3/stCgKnkNfKqOlq0bIk30gJHP3CS6PpzUpZFAMwIk4r1r9?=
 =?us-ascii?Q?DY3+v9Jt2afnXzvF8muNdUvYeaFkW3I/QyIIfOVyaMjGiKXqLmMGW3jbPyy+?=
 =?us-ascii?Q?s0AN7Dmr8Z8wmZhytwlAUaenVST0RP3/LO16c2cCRRnY131qfF0VyPLSQ6H2?=
 =?us-ascii?Q?z7LAFNOK4LuxSgiVJDBCAReILH6iCYDBgN5xgIdhqk3MLuuriMlvEycgt0Va?=
 =?us-ascii?Q?dpVKgPo/oFsai/0y8gSxB1QeMmsaWhmewjzYMnR3d3pSslH+4+I3nr49RCa2?=
 =?us-ascii?Q?uepbm6Aw0f1sPGgatnqFpM9zCP9vJ2M4v+Hwum+5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220002ad-da77-4ab5-0537-08da8a83f04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 12:34:10.2715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vWdtso1c2Utvw7n1OCYIdkNeeBVGvA+f58Rhlfbsv1mqM7xuXVC1qHaXDXzIlXbZnSyGLkoskjtgM7dU9QJig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2480
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

This patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Looks it needs to add it to upstream instead of amd-staging-drm-next branch=
.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ma Jun
Sent: Tuesday, August 30, 2022 8:06 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/display: Remove redundant reference of the header =
file

From: Ma Jun <majun@amd.com>

Remove redundant reference of the header file drm_gem_atomic_helper.h

Signed-off-by: Ma Jun <majun@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5140d9c2bf3b..b4019c4661c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -87,7 +87,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_audio_component.h>
-#include <drm/drm_gem_atomic_helper.h>
=20
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
=20
--=20
2.25.1

