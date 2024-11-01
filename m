Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C760E6B240
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 10:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B810B10E973;
	Fri,  1 Nov 2024 10:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ok2MEX6D";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64AE10E27E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 10:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAITyj3Ku3DjMO/2J5Po0xx4h67wsoKLfkRLWsi4cjI4ChtP4vudxiKTCmYwzr5R7MEHVTPiobNeyTzO57WJZkf1BpdCj4OIQLJv6DEsyjqbOV3YpfXQLoSCWcvRZtzmf+MsXZQLlGYuWnVdPTVaLq0hOJvPeaJkhNKzRflx+WPu736weTlx5AroPkuB0CFX1CN8qVCMJ1jMn91Hirdfn7k/bHIDekNH48Qt60f0VcL7X6wnYZ+KO5zsRILPhWlZaYQ8Lg9rEeIHHgRGZh/TW1gU1KDYN3o1GdUhZnBS8xlJ3Fhd6hRsv/IhpLhqzBhXcIsRWzey/6ZQwXLSFA2xYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Ohag9d0TIKYJa53kfr83Ent4oT05QvXZpxuka6Fig=;
 b=wg9Tmqugbl3MeC6OnGaX3lL49amCnhiUAdIF4lmypL5uQ6s5fOzeyf7UGxjNI8t6aKEndO1UrKHpfTynX5bOTK52dkmaBtAgzq+2HH0vGL1oDnimkNR2r9PknBw9B/p0I8w/+d2xK1wI8s2lnPcoxWgMBDZuKuWgLK6fRwdgTRdeVqyE0hjZoWga4BWNXQD2pVpqHsbcYeKVEv7DW8LWHh30brQRpBaymZ8nZcpPSva9tTHJDLR3CSXjzv88CH31qkwSaIQoMvEIpQdQoXVuk+9x1TMCXJ9cIi+FSkzsKoaKS4P46YpDpOgc4dNKhmZWAVp2dxAlp0fgXQviN7wjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Ohag9d0TIKYJa53kfr83Ent4oT05QvXZpxuka6Fig=;
 b=Ok2MEX6DWg4ExN+Xc2UFlx24A2CSAUXZyDEiYAITJ0YQnQatxpJdCrxOvOK7oPQ40MpsMjt3dzRGzHS9Y6ixJc5U1iA5N8s4O93Ve29hnrJ3TlOnGWnN8uNy5YXLS1aebt6YrBXkRx0qo7/zQIOigpDwhOpmfd6XCr/aNqTOAgc=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Fri, 1 Nov
 2024 10:14:39 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%3]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 10:14:39 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add compatible NPS mode info
Thread-Topic: [PATCH] drm/amdgpu: Add compatible NPS mode info
Thread-Index: AQHbKqYpWKBfP2ufI0Ka8cn3ilwxBLKiOFvQ
Date: Fri, 1 Nov 2024 10:14:39 +0000
Message-ID: <DS7PR12MB607198FC8ACEED7EE90CF7B48E562@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20241030082937.3185224-1-lijo.lazar@amd.com>
In-Reply-To: <20241030082937.3185224-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cb4448e6-1fe9-432b-b048-8cc225621523;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-01T10:14:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MW4PR12MB6706:EE_
x-ms-office365-filtering-correlation-id: 0482fa33-cc33-48fd-7087-08dcfa5dfec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?G4ZJxauLQdQsDsybvud7RnCJYNkwM6DeQDoaeZ8l/EYHE0jSCN2/Ph5HZpqr?=
 =?us-ascii?Q?5NApn94DMVHJ5QdxxHJOSmh8FCUB2hnI030p6E262WYPAFL7fpTBALidqZ2O?=
 =?us-ascii?Q?5h3mFzrj6/uAYnI/x22Jx/MCKJ75pZ5oBFPou6K0SkspmXPWRPm+X04E/ytd?=
 =?us-ascii?Q?mIxOa52HNIWLSvx+FYlARRd6sPPYGPunwMlfQnUprzAFCNqPjQ9nwkUA91kp?=
 =?us-ascii?Q?8EZVFcP+IBUMf+yXnITOIHFR9EzbSS9qDpJsegIUF+fCs//yChvlYhCDtSr/?=
 =?us-ascii?Q?wg9HRf3zob5yIZHpKmdKk8iz8+ToGTuCyCTShAe8JCkJEwMmEGYS+Y+aN6Qb?=
 =?us-ascii?Q?dlpTGiU19OCzvvr1A/17GYkOA10RFEaMoch8RwfKt9hHDATywcqLqE8Xdixf?=
 =?us-ascii?Q?1asihID8Lfn5F57KsSX56YNLPenYd6UVy594QxhFnIq6odhjEAMqJoAQsQpd?=
 =?us-ascii?Q?XcQct86zp95pXfs7N8IuA2ipQ/XEgCxetl5hu3JBTs1ReXCT1QbE8CgZW/Op?=
 =?us-ascii?Q?V8u21D8QC473+OtoJbl+qygqh6sZcKsVOi7oSFWxXka+lM7BWnL9fTpVtIPX?=
 =?us-ascii?Q?3SwtaBhic5GjiAdxXich6l5zaqpAmQD9xOMSa3NMO/PwJvmU8DogZRscNk0K?=
 =?us-ascii?Q?rbMdQAskgpZcNvzoZL5ukyej0C43EWXoSq2b/5WytsRiknrA1934IRgIYP12?=
 =?us-ascii?Q?r1lxPMSz3QwAltPIjQ0F6uUj3IkRxHOppSP2VD//zV5O6Yq2m/AHF96DokEM?=
 =?us-ascii?Q?xikQi1IVvaaQyq9Pxcw8jLcXpDetiP9HbMiCjfF+47zToROf4Oy9rju4YtTE?=
 =?us-ascii?Q?Kj6lJoA6WZwFqd74hZquYZDoGrpZ3KBDQeQa5oWxWdK4tDxuKfa46PjDLVLa?=
 =?us-ascii?Q?KW7eSLyfaEECbBd5B8r/nixYWgR8zrSP8tuQ5HyKLVC1fieUEEUdPvNezKHX?=
 =?us-ascii?Q?ssH057E2xeWuhjve7TqgwA+vvelpELo/Idk/u3Y+wHIiVgH9Ud4IHrYZriUs?=
 =?us-ascii?Q?Qp10XZuOxAiKm8A+HBpI2anst2JPnZ0Ib5HQTd5qket50KPylU5cDejbA61r?=
 =?us-ascii?Q?8qrzN/Kn+b2yMKBf3kmZRyMoWV8W7dM8gKSfiHM8JabxDWBSgBalTsbcI5Hh?=
 =?us-ascii?Q?g64RGZ2JtOavASpaZuicxkYjG92GxJ2EDDDSwxWbCbOpUpsG3OGWoY9o8PMo?=
 =?us-ascii?Q?JSM8kCZrjqnOkYwPeKSWpTnB0ZVMZ/UUGUHmJ9i160+hQVNDeGido0FgAjIn?=
 =?us-ascii?Q?dxBkxkvu1iIFewe0ua4ySwvhj8WVJIbqbLW3hCZnJ8OtMAAgqtOopfhm42HH?=
 =?us-ascii?Q?BWQrKuvo/4VFGPyzM1/eHJvC1Z0vCEQ7QWuCzB6u3Z1nLDCkg0zIc58z0SNk?=
 =?us-ascii?Q?hsOqnyU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KdFIk0R706uSnE4E53G5oXm/w0TjZjvx+roQmhS3DPIueQXbt/aBGR0y1/r9?=
 =?us-ascii?Q?86pVE2kn7BiBhwAj3NtqgBomFQx3648vG8Xr5Y24TJo4N3fM0YNY3wFE5ZrW?=
 =?us-ascii?Q?5GxHvG/6r9vLQbQq2BC0wOUVBQykFH5OQ1IzyzyRERDEPCLBlqAMNrPYSRjQ?=
 =?us-ascii?Q?Y5JD4zJ4S6psO+xDE1bHDDnjjsFynRo1KbRw4YHMAlB9nMK5RQ4mAyb6z9NB?=
 =?us-ascii?Q?XH5Rsbpv2w/At5HZjRCOvW0rVygIc8YlpF0ym1CmZpCfBjQjK8rbNdXwVIZi?=
 =?us-ascii?Q?a8zNG4C9FC4DjjVvJKm0rQAixG9gn2XF5AEjsbGVNJLwMb3GI/wqRBsnj6PL?=
 =?us-ascii?Q?DX6NtM/Ab88DRpyPtIr08ZANB822U8HnCrN6Qkx5BxNHOSpQ0ZJ8EJRiDiWp?=
 =?us-ascii?Q?X2pBgVtEgNazCOdR5M64n9ZpXWseoO3FRf6LEW69FRheUfUBJYowjGBxjjmd?=
 =?us-ascii?Q?ns8LP3uRH36lwcs7fGBt5YbfxxkA+RFuTERp0F7Lj8hSbWr+8TP1/LxQPX/u?=
 =?us-ascii?Q?JkAa+0OfqXIPuNvwC8HeNNa9Bv5XPhyZeqmI+3/feL3dV/XHSdDd3eA66tIY?=
 =?us-ascii?Q?6tsl3x6W82HbSTSpTy3IcdGMlRqd58h6PKiieZL9iQ+a3g6nR+sFi8NGx6dw?=
 =?us-ascii?Q?rnaUD3hT5/8n/wwwKZXaXZ7SL6H6vBY1oJYF7APTjvKZYz2dSojk1loOCAvM?=
 =?us-ascii?Q?h8OORZ/J6VLDcWXBy6rqk8sG65+aQZHTs5vV+yo3Tm48OUjdW59wNCKP5Fut?=
 =?us-ascii?Q?jEQcs33juw/02qgJ6x5G+FLsj8CN75E+2Rt/PZIWuo0N/PZXCxY5j4pfxLrY?=
 =?us-ascii?Q?d0tuAjhXVomE73tOnSXPuPioRzm8UNjCWw6I0zS6HMh1qRCH+C3lvm/xFu3Q?=
 =?us-ascii?Q?RYombaYELT6PwNxrx7QleqG3GOG+rwqdz4q/IHIX4EOWswmwaPhdh5toh6XN?=
 =?us-ascii?Q?vx1aFZ3fsfgxEH/79oECGFf5XXrOevajQhzQ4q2haGjd33TG9smhYalQ1V7r?=
 =?us-ascii?Q?XTl1CrKtWTVhGINJaFC1Cn8z0JzuZroiU0nc3liBOrpeGbq+DXCI1T4z/97o?=
 =?us-ascii?Q?wAbvFS4+9+GTh+6tvLk6u8Sxm6YVNR/4j0k7Av6IeQENp0bruNBDfietcniY?=
 =?us-ascii?Q?AzzJZyPmDYNc7K8PhVdjA5Zp4RcWnmybWTxNEMGELdY0JRdVNOTFxjndWdeR?=
 =?us-ascii?Q?fLpNDClXuOZgsmwUZciX2wQsNY5G7FgVHsEW5ly2xjInjVUWhTts0rMmiaDO?=
 =?us-ascii?Q?D80bPV8kEZOJzGB/cszntL9wA7JAb0t66ubtQuXc+0uewjR6MWbK5SzisPLW?=
 =?us-ascii?Q?uqcevP5hoFJdqEt1bOFcrEb8rt3ETkHBT30GAl1jRpGmi6Q6i31Mm+osToeD?=
 =?us-ascii?Q?aZYRKrnhfOcO0pnV052K8ffPIZ3XLNpHHCaoM70sfo/+L7hXJMX2YZz4zicy?=
 =?us-ascii?Q?f+FTxNXgiMGcFxGj0AeoLma2p1cRTa9V0H5rKQ5hmzKGhdsa2clnShllcX7S?=
 =?us-ascii?Q?ckUS+AO8TQl+xnqHEYnlEnEC6z9Ikqy0PgSXw9zyo8Uy7/bkZrAKplvcfSUh?=
 =?us-ascii?Q?YpsYfmSuIMnIpliukQc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0482fa33-cc33-48fd-7087-08dcfa5dfec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 10:14:39.2549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Up/B9wxxpIQ9kftbaf1VoDBiCZtEfMQ1G2T3l8ZtQUtdWUmHf76PJ2XrqqnlxZl+6qCTIteXiYVE/oIbMxhUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, October 30, 2024 2:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Add compatible NPS mode info

Populate the compatible NPS modes also for providing partition configuratio=
n details through sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.h
index 7ac89d78a5bf..b63f53242c57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -77,6 +77,7 @@ struct amdgpu_xcp_cfg {
        u8 num_res;
        struct amdgpu_xcp_mgr *xcp_mgr;
        struct kobject kobj;
+       u16 compatible_nps_modes;
 };

 struct amdgpu_xcp_ip_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index 890976b7ce77..fccccea0d2d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -455,6 +455,7 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgpu=
_xcp_mgr *xcp_mgr,
        int max_res[AMDGPU_XCP_RES_MAX] =3D {};
        bool res_lt_xcp;
        int num_xcp, i;
+       u16 nps_modes;

        if (!(xcp_mgr->supp_xcp_modes & BIT(mode)))
                return -EINVAL;
@@ -467,23 +468,33 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdg=
pu_xcp_mgr *xcp_mgr,
        switch (mode) {
        case AMDGPU_SPX_PARTITION_MODE:
                num_xcp =3D 1;
+               nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE);
                break;
        case AMDGPU_DPX_PARTITION_MODE:
                num_xcp =3D 2;
+               nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE);
                break;
        case AMDGPU_TPX_PARTITION_MODE:
                num_xcp =3D 3;
+               nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE) |
+                           BIT(AMDGPU_NPS4_PARTITION_MODE);
                break;
        case AMDGPU_QPX_PARTITION_MODE:
                num_xcp =3D 4;
+               nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE) |
+                           BIT(AMDGPU_NPS4_PARTITION_MODE);
                break;
        case AMDGPU_CPX_PARTITION_MODE:
                num_xcp =3D NUM_XCC(adev->gfx.xcc_mask);
+               nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE) |
+                           BIT(AMDGPU_NPS4_PARTITION_MODE);
                break;
        default:
                return -EINVAL;
        }

+       xcp_cfg->compatible_nps_modes =3D
+               (adev->gmc.supported_nps_modes & nps_modes);
        xcp_cfg->num_res =3D ARRAY_SIZE(max_res);

        for (i =3D 0; i < xcp_cfg->num_res; i++) {
--
2.25.1

