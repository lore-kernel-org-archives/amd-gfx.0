Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5533FCCFA03
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 10:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA29C10E871;
	Thu,  6 Nov 2025 10:04:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HIxwZgTo";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6856210E871
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 10:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdkU2UKUj4THxON5Dk3j1aNjJMchi2ekkxj5/t0xISTzf/Up7lzGtebMfsmKAe2m189UXhdpF/IGeci2Im0YLoG8xut0SdCnKmUNegtSBhN9orFBArwq7mC1lOUo/6pSutxkwWl+AyZEzL0cLw92y4LPWD8OeyDUt9NxN7hTyIJ6GnSiT8X5RQHEVFjiP4aR8MSYkR6FVE2zDoWbRHUOZWXNgWpzsgLE+gfcfnfbUmAcT1bDXjeGKHaOoHmTjLFOtuKzm5Weg7Vs3i32fIE729Dl2ktz/da+26TnK98dohEbG9yU6uujLeIIE+wCqJLEIvJpHbLQV0jPG2f298Ph8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0ntFoTT++/oR7D26wh49gpbfmRkhf7MQf627p8VOiA=;
 b=im5UCw0rihB054K+YZC4bfvGM1ELj3ZfSc1RnwpKOdp0ItDLeGcENwhIycFyzcH39e8YBUTJv2IpVg5OT2tIhuAokn+/fbtuOyXsbXE/YZGcWIFPtFchJLVdU794fPnaTjDwo7jC7FwsgRbXuYefm9PiAmSZbOO0+1hcEugyhyT1xW6Rkrhfe23l151CZ1ogowtNE2DeGDTAYGiOWLjJeXsSSNB/DfTXbr80hFBxdifKMw8qnIWR1n9c5qAd66xDtS+2bZILkDoBVy67ZsEjTChRQGih2LcRK5lrYx0o/R5zRTC/B1BT2OfqWTGGSbsyhyhkx5IQMBvxTpRutrmYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0ntFoTT++/oR7D26wh49gpbfmRkhf7MQf627p8VOiA=;
 b=HIxwZgToHjvXi5gkd3pEKHBwyNls/e695ogf4dWLU4eXQn/DgqmV5+xQ2Nfu9PLzv8TF/+d/THju6weriAZbWbdN7xKu9ENII2mlRg1LsZLdlODv6JR7mroI7OSosNT9c0+EH74WsAiUyBjue2MF0sPelh+a1yHbf/7Uv6bTlRk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:04:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 10:04:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Avoid xgmi register access
Thread-Topic: [PATCH] drm/amdgpu: Avoid xgmi register access
Thread-Index: AQHcTvactV/QQVWRNUOmpGMHP9zgQbTla30g
Date: Thu, 6 Nov 2025 10:04:32 +0000
Message-ID: <BN9PR12MB52575C2C101A7E5F46E2C9B0FCC2A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251106082255.935782-1-lijo.lazar@amd.com>
In-Reply-To: <20251106082255.935782-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-06T10:04:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL3PR12MB6569:EE_
x-ms-office365-filtering-correlation-id: 25f3d42d-02cd-4e46-f4b5-08de1d1be201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?S9ic+ZEuhk9P2m+VJpCI0RxEgAFhvaXcVS2q/S6s1A23PRlPIp3ilFHX+e4u?=
 =?us-ascii?Q?xUnZVoOPU20rN6vjYBtVRLQYJXoYKHJ1BSE7L6RgdM86mYyoxYQKoljXQf+e?=
 =?us-ascii?Q?5c/fiMBUXP6wFZmuYQ3aUVOwm5AC9Tw9ydcSzjEz684kv5nXjJrfwgKI7lrB?=
 =?us-ascii?Q?KmRQMWUHFGWNNR+a4kYpupAAPzvYQpAduhQ6Zxzbz0MA7lSY/wP3sNezrEPh?=
 =?us-ascii?Q?nIo0HlhuSkz8nmKD1zs35Cz8ZlHeFtboEpCcvuLNYsmWyKwo4VcfH7Yw4PaJ?=
 =?us-ascii?Q?nvxBYnpsCIQSkE60mVmpvZ0aeSH99IGx/1g2BM7W6A4/gpvn0peSSjAyPIv3?=
 =?us-ascii?Q?dXv+q+RMMRP7kkQktGj60uoWCu2GRhHlqk8iKcTHHme38Ymb48es0BlmvYLR?=
 =?us-ascii?Q?p984twcllMFFKAP4mIXb9aLZkeGKqFBUJf2B3uL0+JXQPZDVIDKwEbeulYcg?=
 =?us-ascii?Q?1FJ+O3B/1BhAjgZG1MHEz4fNegAaex4oS/XqFjW+8I/K5EhpqCvJvJCUl35Q?=
 =?us-ascii?Q?jqCmVSGa6oZMsZnvpbTYgU3K8E5KUsE0b1XrZEzmbchFtVbffJlrR+uuGYBq?=
 =?us-ascii?Q?O82HjY202/kwwf1Ih5dUDqQL+BHShcB2R3EZYT/d8icfveN1RF/oLWlfKl5z?=
 =?us-ascii?Q?EcYNY3hAqgjqpMZhLUcyYan4GoVGtAvVe42QG6U4zrvM8VY5mSn0DxuIoYMY?=
 =?us-ascii?Q?qXz9NtZURDk1dgpfhNUfKs/AHlMxj6XS/cp+TcDXVev3+0ec93W6qcaS4rpA?=
 =?us-ascii?Q?e0NJGORjQI7BGT/ezZCXikGySLnWWM2mTszX9gb8nyKenx6oNIV3VIhW+RcL?=
 =?us-ascii?Q?8fM3lHBs1KmObRTUbWacW4Fy5ZwYwZX3jQuShbZIvUfqIApeWp5LOHuksocl?=
 =?us-ascii?Q?c2TI9+pd/SckXuF1IhXI09TuDxRkwvw4ZSHYD89vOH0P8b2zliXAVeTlZGN+?=
 =?us-ascii?Q?QCCU3dlW4YIsrjFGcvKnLYRVjTND+eskiRdsRvN1eq8k3Ij8kMRp56FAe4R3?=
 =?us-ascii?Q?fvmML4IlX/DW5cQ2rnb/eijBQ7c5kzPoygnszLW0E5D8CXemBU0RKJYd0fUc?=
 =?us-ascii?Q?bGOs23Koym4e7HHdTVfS6z+E2eCBlfbVYOZDI8OVBLgTy2O+tBJOOKMRvU0z?=
 =?us-ascii?Q?ouKKnaRqunaVIBCP+K0TCte1YGO7Z2CeR3s47lpFMB/n+8h9YnM2fd19QRGk?=
 =?us-ascii?Q?rUae66s5a429hbkd5eUlTFZTGxHjSZ7bexM/Srt8+gew93WVuc6QOFdgKwKC?=
 =?us-ascii?Q?oDzflurnEkzeClgYh4UGf5J1+RvTZoWpqQOQExTXNv6JsZziC+MCWhmM28Io?=
 =?us-ascii?Q?MrJW3Y10fY38yq7aoXux7GOmsOGAG7vgwQlk9MsWH8mkfb9gnHcKuM41jdeY?=
 =?us-ascii?Q?3lPCkKA59RAhwmrHrZds7VDQoa/DwJCOGknDOLAX+kwvo9sz1c4hDs8q3X4C?=
 =?us-ascii?Q?Ax6lkQh7if2FOoM9eLr8YcrdebZifHTthA/br+SM0oJKSbuWwHYfg+lVV8YQ?=
 =?us-ascii?Q?SLrpPruvHrE1xReYGQFJtocYwtahE59stSkt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RtIrgRrPlClRXP2TVroVc89G18v+tQFxHF77a9CaXlDD/5gyCGW0EhbRUp+/?=
 =?us-ascii?Q?Kbf0/efKAQuB7BEW3A7fGGaLfJMNSRK4NYgy1sdzHPkUQYeqPZYyPtbDeIhb?=
 =?us-ascii?Q?cn5ulS8wOTfWu94CKkeP5d6lfuzmQv2gGut/TJiAjdcrIRzKL0k8cdw6DSSV?=
 =?us-ascii?Q?7XrsEXdzKhlSB2dqHJEY+nd2D6nab5dmHJwIsNfAyL1FAeWNBqhzRmoJnvnE?=
 =?us-ascii?Q?o/b7XUbs50RohEhJTF0aJnEyv+tUZZFjBf8I3Z0+YPklrddhXjlCNqVQLNo+?=
 =?us-ascii?Q?jbbcKZUi0b8i3EJxPV3mVlR1hZd/f0Tq4FHW7n4WsRwl0lOgMSGRHmJjpOJ3?=
 =?us-ascii?Q?Kz9M8ZUB3OhcIntM2GglkpYr28YYkXHG/rGQGolgVVnPJyp9aafnR7Sk9oDl?=
 =?us-ascii?Q?idKW0g/BxdjYe4GgWsZQ6mp0fT5fFt75Y0J8BqaQHvD6FpuUKgibVotk+FZk?=
 =?us-ascii?Q?DRh/hkjLpFzl3mWoZ/BiqUA+LnX+f4hfx+6OKOh+gKpf32Gc12a2V9G7tsM/?=
 =?us-ascii?Q?7XwXL8CnfCDvqmTqgxNfew/9io3sn53+G59ZXJHGPiGdRJvnAMKGNwEVvMC7?=
 =?us-ascii?Q?bTkw/K0OSy0smjghzNdXA83nl5zYu6gJEezEWRnpg1lfA3LDmcSB1uN2iOf7?=
 =?us-ascii?Q?JhE1e9HgMQkxplHgkyZQaZVbAXz3cstBkqZolRbkviy4GJ8YPm0CJhon27bc?=
 =?us-ascii?Q?BhBiaizBSwE84x/5/DhNyoChZEHOunvAc1rgKxl0EUMVpJeAnHOTkcg4nBfI?=
 =?us-ascii?Q?fXyTVCteyzbfMtqXmGUyY/yFHYCt+9kGfW1e4nq5+D9QoDFHzRepqsfFSb0+?=
 =?us-ascii?Q?Qt6QZbM41OipQL3gL7t0hfAUMaZgdVtTED2Kzqyks36Mdelaijetdvb7WLdy?=
 =?us-ascii?Q?8tw7MnF7wE1FbKXv0L+RnfuGN5fX5dv2DgYGHfJkg89P4uuZBEWEXVBurqtQ?=
 =?us-ascii?Q?+yxChKtpyRsE68Kfc2y597tvOJWCj1B/U1cBvOyXv9eAib54vOxUqY5jC0iP?=
 =?us-ascii?Q?4U4xN7Lc9bHErsHvZUtjzqRaInZRcgYvrs5aSqPBabBIIbbDFMTeokrAE7kB?=
 =?us-ascii?Q?zlMu1kvQZfuYw+Z+LBE3JF/rsGufxz++Dh0tlX4jwTPOUM931t1SqUNW6y/V?=
 =?us-ascii?Q?2wX+7kU6XIphmGRHwSfelVDPlD1aAHd2un6doej1cLjwKPr9XigQgWj0zblw?=
 =?us-ascii?Q?0FlseiI3F5sKZ6MIE1Yh6yd9+frShB51BCgTAiyrp/w3tJtwew3MWcY4fj1W?=
 =?us-ascii?Q?29YLcP5HPTHXU+H6R5fRL8vGClR4ehypcjQdAVTOiVY62wgv5X7yAVjPbD0T?=
 =?us-ascii?Q?+ev8+6GXYIYKN1wMZWOhkVnjNmizbsUgahwPlleW98tmzVIG6OUPYnziuEWV?=
 =?us-ascii?Q?svOo3CMJEaivOBDzAkgo4OS2XgskwdWeZb1fHCixdEIV/A8HwxVVyWMRngZy?=
 =?us-ascii?Q?1n5fbqgfx7NDd5ENkQyZWb4ArBU3x9U8VhOPVD7Z60KiI+jaMgwRUKU9EMTs?=
 =?us-ascii?Q?iKssF+1V9eS+9OmoSqQ620etvOMZJLr95vt7JgECs7KkfJnFXq5/IqlK8w/Z?=
 =?us-ascii?Q?xPpbi9gghsb50ESC5Gg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f3d42d-02cd-4e46-f4b5-08de1d1be201
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 10:04:32.5872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dbtugz3cM7Ap2dejBmHBs7i3v04KuFr4AwRmzH93BJBGVTHMc249I6C7xrGJR1grBW5EZGSuwmRkSOxwofW7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, November 6, 2025 16:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid xgmi register access

On single GPU systems, avoid accesses to XGMI link registers.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 1ede308a7c67..1823ce74b990 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -298,6 +298,9 @@ int amdgpu_xgmi_get_ext_link(struct amdgpu_device *adev=
, int link_num)  {
        int link_map_6_4_x[8] =3D { 0, 3, 1, 2, 7, 6, 4, 5 };

+       if (adev->gmc.xgmi.num_physical_nodes <=3D 1)
+               return -EINVAL;
+
        switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
        case IP_VERSION(6, 4, 0):
        case IP_VERSION(6, 4, 1):
@@ -342,6 +345,9 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *a=
dev, int global_link_num)  {
        u32 xgmi_state_reg_val;

+       if (adev->gmc.xgmi.num_physical_nodes <=3D 1)
+               return -EINVAL;
+
        switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
        case IP_VERSION(6, 4, 0):
        case IP_VERSION(6, 4, 1):
--
2.49.0

