Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32947C3601E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 01:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1CE10E050;
	Fri, 11 Apr 2025 01:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLsAIGO1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC8810E050
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 01:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs1MeTCNncJ9vpYFj+c1D51JTpyUtbKqbl/Dc1kfi6rG/6dJ0zV+EQCe95dwZKYpNgG1xRm7ppLKel8ub6f7xoA63fUT/K4MWM6Y6hL4J2PoEd0/7k86ewQ8JTYpohw1Acm0s5YDLOMB3a5oXMOWYQfJ2hovqT61sfE1Jh/d1O5EOnCepkodCc7G7CeY3ykJSGSc/3Yhe50PnQPd3xoALNNGjnctHwsqWKmsQLDimLOUT5mQyh9vIM/rILJkVdMSw4GofIytfQ3xKUFpS/vQJY4xJOvRW8K6iQblF0DE2IxwmZDnV4WDtZdcWY17wo3emiXWbP4X+9l04kMz+ab/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrUFAX3Ilym2iul2J1aS4W7xO8F7KAg4dbjvvRwcPtI=;
 b=dyw+0MtadnmPNaYdXXF27eS0OMsbQmcCQgc9EI/VWQuOtOERNiZgj0Yiz0PhZZ1PvN+xEForjVHxlc3ahSSH1A5g+WPHKKFaNhA+yF+xTlUNOvT8qS7vk1MCR766mCvGmGsGdUqwWOknOH8GEtmC88tsPtU5wNHurVVEF17tI4LqZ5cAzrIrMawgPXlv3W9VfqhQyGaJc6BmhNd8ABJZA3KVLZFzFKZSyHgeq4c6a94suYMP/f5OBvK9RBKmF9cHk/SNGZmwsIlHOwIbzIqZWlrhteqPCs6LnSqAUgdo/qGhdmFtd0oSGl1lynEb3+I1VmCvAmv1lS7THfecwFpgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrUFAX3Ilym2iul2J1aS4W7xO8F7KAg4dbjvvRwcPtI=;
 b=xLsAIGO1xu8Idvv8od4dpjhzAhmjS5ybMP4gTJV7Zwp0rTgXq8m18xAwoY7+xgSGCg6z2YdgLu+hfQzvPi0QuI+KXk1GCvHGnnZirT0Rg2FsQMn+CTpUnE5a5vWyYjYDQv+1nknlgpeuCWpuqV6mEBVehRW6kPp4wHH0dKQlpmA=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Fri, 11 Apr
 2025 01:52:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 01:52:23 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 13/13] drm/amdgpu/userq: enable support for secure queues
Thread-Topic: [PATCH 13/13] drm/amdgpu/userq: enable support for secure queues
Thread-Index: AQHbqkn9Vt5Wp8QnoUub3xJo0Qdnc7OdtAbQ
Date: Fri, 11 Apr 2025 01:52:23 +0000
Message-ID: <DM4PR12MB5152297A65EBD5F921C96A4DE3B62@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-13-alexander.deucher@amd.com>
In-Reply-To: <20250410185402.2352109-13-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5bd66a6f-301e-4e9a-ba6a-6132f27d00e8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-11T01:51:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SN7PR12MB8820:EE_
x-ms-office365-filtering-correlation-id: e88e294a-4b68-42a8-2bef-08dd789b80bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EeeQsu/WPm0QDiVcVagYPWWEBJsRW33XzB+eSmPOVeykvY0EAtqEjz12/xj/?=
 =?us-ascii?Q?/LkP1Kg/Io9936vBSk5K8lz4v54pIBAxR/TsCC2Yup4o8XQSTev0znL2PF+0?=
 =?us-ascii?Q?oCrvs4rxLeXhzG3WuCHoUusFURm9StBqh+/7NS/Sb9lacuu6jW3xAGieWNkW?=
 =?us-ascii?Q?RjlDHO5MTuuphfwsCgxDf0PXiHGL5V2wFhEEcA0+mexhOVtD+bh762qZHBkp?=
 =?us-ascii?Q?rT7+p2SZIYwbR3LKg0tEEAcarxHMZ0keuU+LPfBCf9hCGZj+iDcBOf3ssDt0?=
 =?us-ascii?Q?VYI7Mqe5KGNIrhSLrXGArVTJUlfOovJudekcFLcgXBzhWaH+gEX1sJCzhi/S?=
 =?us-ascii?Q?UKDt97vrtebialN3vzEETQhUBQq2H+jWlVas6oJYu/tnrs9r5Uj3xs7LGfp0?=
 =?us-ascii?Q?KBSTW7vFC4bK9LTbEUbNPYdY/3hCXBjKvueYreLx8AQ+tSBJVI3YJ7pwpQcb?=
 =?us-ascii?Q?EBRdKddM90IH/29OccIMFnYc7TMzIsqjw2BO8gkeGm43/F4qkOA77D3ikGNL?=
 =?us-ascii?Q?UhCk1dEUjvhndriluuRw5HA4WEhYTBvRJ1ZSMxL3/NoavYdCKClTav31RihF?=
 =?us-ascii?Q?IT+sHzl8fZC6Nu12TdLyB6ChgCozGLPDGY13r2GldyNIKHepWpxhV6IsOiZJ?=
 =?us-ascii?Q?paNkHsC3KhS330RujBqcTQ4kf5vR8RYzDqEAMBRK7tEqbbZghtuNJ6QZYvlq?=
 =?us-ascii?Q?awfnN7whBECSmpSPMpN95iCXnv/q8fUVkqul5MFaoaYGr0ANmr4b1bQgVeXn?=
 =?us-ascii?Q?JwSkf3exXG+xzlfeqSpLA3C7/gr+VKXfW6IDMAlMu8W3NmMkp9PVBzgYTeEK?=
 =?us-ascii?Q?TBhQ6mrLLPoFOR+fGtfVhqd4qREZ0hRIkMXwzpWOv3Ut/cDGm0v+cR7oZ35/?=
 =?us-ascii?Q?+HPoZpUL/WGWe6N+t1CNoGWqgUuaUdwV3g6sshSgMTTLHxDfH4tW1uzLXQDS?=
 =?us-ascii?Q?RPkW3CBbDeBJFmLcysU8AGEP+ypBulbxJnSOMcgfUL7dYw67fu6Hnm5TCCA9?=
 =?us-ascii?Q?Bi6ZcUhVhPJoov9o8sFvXHeRHcX/NYre7WCJVHc7OqwPHJyR5uuF/v1+NCaF?=
 =?us-ascii?Q?ZmH3XS4zSEBSFCYWWqwgxfEsJ9jVNHSRtfK4TyEjBQ6afjPuvKkqSeDW4YWB?=
 =?us-ascii?Q?ZpSQzLdxo9Qo4OAWmziFBQOhBky4VhEdXDA9+ugT2BG6ClKpMEp5/4XoErZy?=
 =?us-ascii?Q?kuVRrWJageSXncTbEyBqThBmTdsCJQMMfFVbB96dRK0+/hYQG7iG1dtlhvFT?=
 =?us-ascii?Q?tEnyQkuptdX5u/xSFX0YbDd5ADqoXIGKwqQvxmWOIkOkqFF9LkZcwF1QhyIT?=
 =?us-ascii?Q?r0macs8NnFd6F88ED88vh1uRxx5f+Jtqu+AR+bIfYHr+lVQan6xn4bjbMcw7?=
 =?us-ascii?Q?lzx21RHl48f3zNqPTrK0JEzboNKXWFye7u3IOac155wTZZjEhzghFWGeBXbk?=
 =?us-ascii?Q?H6AHxaYvY/xjCNwezkfIoN4A2enmEs08?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ddK+nScphJYB8APxQgeQ7XuNG3+n3VlTuogisYn8dqefPd2w8X3UXmLtHUQP?=
 =?us-ascii?Q?7bzAw0o5UW0pu5NPjiTMsoootGx7UbJzFxY067OYh/z/3y1yMK4SSGPqw9Aw?=
 =?us-ascii?Q?HTdpDzEusuyp3yu2YWdO6/6jozW+3EwGM4qdgi38Bo4k0M9W8LmrkmqslXvP?=
 =?us-ascii?Q?PvmgKkJxvlCTUe0+8MBxKGxG2nXpzmZLP73yNfHa6n4RNsHZJpuUDAFNiXsV?=
 =?us-ascii?Q?aEqFb9dRAIQOrAn2xNjpPQ/cY7ePdInuwRxb3hCZzCufljsCHIKQb6CnRlqi?=
 =?us-ascii?Q?UADxVxDBRpXFZh19ivy+1B1iAJ3Rsn5GTMGBl6wKAe8h8OTbpfxX7FObWTsr?=
 =?us-ascii?Q?csDey5tHdc2hSqCO0M/avzJEde5F5W0Yin1kMiUWCnVpE4WEmPeXmVdmlL3e?=
 =?us-ascii?Q?KopQwGMmqIRQLSoYyAepsf+5EYEp7nWExG9jDNcsbGiTxWiSzKvZtAleGWpy?=
 =?us-ascii?Q?zgP0sioXePO4lpNX6GdBiQPVqXNm70MFkzLZSyTeN2i3YkjURcaZdDQCd3ZP?=
 =?us-ascii?Q?pXK70ZS37UEbNxKmtcRJ3aBgMK5rL++T0T+QAcfC96JrMa00wh0MzIY3OnH8?=
 =?us-ascii?Q?5CSnvs1F93Pn6JLSNRs4MS6UyI/k5DfYNyFGgr7mzOAS+MJNwUlGlvHYcDKS?=
 =?us-ascii?Q?3SBDe41yDuSu/GFOrB9bJdAuNrAZYw6ZwTpZkAKRxGicJcvYOaUwbBG/aoNz?=
 =?us-ascii?Q?itatUQH9b1QXANpTHN/kfyj0bazgocIg5PVbMJNokCywdQpwhtA6CUBCwLbP?=
 =?us-ascii?Q?Proz8U7XLSXK+c9tHT2PHVTRyutnOfiC1tEjubMgb2+Be9w55LbhVN1bgek8?=
 =?us-ascii?Q?AoDpN2HwvdM18P1j4dUCOnVM/cF29mkE4ZTTXclI0iTAsYfbeBHN5UlTIOSP?=
 =?us-ascii?Q?rNw/U1rsrnnqjK5KKr99otmUwnRhAegAvHUg47CApx4CkNM+FTvaGELPx7nh?=
 =?us-ascii?Q?qUIqyvryo6kmiHs2MSDNuoY6VKyvvj1RWp2uQfN6Yr5h8HRsG6YbvayRxmeX?=
 =?us-ascii?Q?Fshz9Mf2YP7XNBQl8IlmFQWo5HVC7BYH7NGKswWupsMZ9fKlLxYEqPdZnOHJ?=
 =?us-ascii?Q?yQNh9woEL030q5TQPLfLiK6IBKK9bAPizdz86dHB4RTwVg/Rmi+Yvmd4UlPc?=
 =?us-ascii?Q?AYnjEeJ98U+aecU0JqvMFrHzz8d7TeTGWGnxhqAsrg3EcW5dKTRunX99JIIL?=
 =?us-ascii?Q?I7BSQVwM8HEpJuwDfgU7anaH8nIh9S0907+VeZAH+PxGIhyzUWkF2+NBCahF?=
 =?us-ascii?Q?lUk6ZuSEqJbs+2zapJ8MWrDa0WHIqeZg48us1bsUDdWOiGUWF6uXJU9rHzEw?=
 =?us-ascii?Q?VGb51XQv4zbJiUZzBvuXu1U/+W7jW01+WYjmswRQX9iin/4JsQRSP1QgYqPV?=
 =?us-ascii?Q?EtGC+iJprZz5Xypz4XRIhyP8NDI3nYgVSiJ6d2ROoh8yn2NMnk5JGo2u4leB?=
 =?us-ascii?Q?dw5tj990lAVJlSa4kcymGVOL3iNj7p0kdAgmposTOL0SvLtxf6uy5Zp+0s9f?=
 =?us-ascii?Q?6ZBwIH5DRUunYlrMKospV8YbwqjEwWQxZQVwIIDXF1N6vMphZbuTHZ9NudWj?=
 =?us-ascii?Q?MFU9MPebt+zDTMVL544=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88e294a-4b68-42a8-2bef-08dd789b80bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 01:52:23.1467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbmCZwXet2flbtQu8ZGXMmxsuFHmmL/o5NNknHkNyDrI6GQprrniblc/GoCHHOjiNxUNPudCekdIGbPSBagq7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820
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

Test-by: Jesse.Zhang <Jesse.zhang@amd.com> ,  Series is Reviewed-by: Jesse.=
Zhang <Jesse.zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, April 11, 2025 2:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 13/13] drm/amdgpu/userq: enable support for secure queues

Enable users to create secure GFX/compute queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userqueue.c
index b8b13b6ab4631..cd279f8164158 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -303,6 +303,14 @@ amdgpu_userqueue_create(struct drm_file *filp, union d=
rm_amdgpu_userq *args)
        if (r)
                return r;

+       if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
+           (args->in.ip_type !=3D AMDGPU_HW_IP_GFX) &&
+           (args->in.ip_type !=3D AMDGPU_HW_IP_COMPUTE) &&
+           !amdgpu_is_tmz(adev)) {
+               drm_err(adev_to_drm(adev), "Secure only supported on GFX/Co=
mpute queues\n");
+               return -EINVAL;
+       }
+
        /*
         * There could be a situation that we are creating a new queue whil=
e
         * the other queues under this UQ_mgr are suspended. So if there is=
 any @@ -401,7 +409,8 @@ int amdgpu_userq_ioctl(struct drm_device *dev, voi=
d *data,

        switch (args->in.op) {
        case AMDGPU_USERQ_OP_CREATE:
-               if (args->in.flags & ~AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIOR=
ITY_MASK)
+               if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIO=
RITY_MASK |
+                                      AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECU=
RE))
                        return -EINVAL;
                r =3D amdgpu_userqueue_create(filp, args);
                if (r)
--
2.49.0

