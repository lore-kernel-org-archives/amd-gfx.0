Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B511ACA0EDC
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 01:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B52510E06C;
	Mon, 18 Aug 2025 01:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SW5C4P6g";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CC810E06C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 01:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjK3W7gVWmjp4++b0XAvGyX9p/0BVCu6ADysxZNy3xSiYAuVHqzeRnT+IRTjri26xOGLQqUPCHxiURR8ke7L+m/kuwqyKdPeEzjr6jPJbOlibw8JVYEX1d0jXoGJjo+NUut20oJ3AP5DxamzNNSBllNVxfBC+IbWnoShmAMcwrw8uNXuHETb8Myx5SvljOTbywZH8CIzUeVlYKitbbwTxm91gOXtup38vrhrdB/hrTJlbj9Y79JdsF3El2Oyqvoj36fPRiix9OjXjMIg9CTqiBPINW4xR5kyeyF7exN93UJ7Izm8orpsmTE91q+bXFvynIH9IvLSF7tjS2xcOBIc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8CbDpZWHM12cKz8a7Ai3EkA7QRZ3QZnMqfTjz225yQ=;
 b=HB3+f082AFfEbEWzJc6jGuDrtoty47HqwCOgv0jtEOgpX3+0xo/QYVGOO4KHAKZ10fFKiR3XylkdOZgvInZwU/c7Cgwcmr0A0rIkt6l+xUVoL7jr2vpkM3BLt2cK+Wymks6lasAXgjnbEJJZeRUlL5aP7U4WIj8s3qknxK/gy85a9jkIf4hZCAmWrZ8RmaAF7OhsM9SNM9O/JokvTlnxFe6+HPZzV4ruT7jBX6egxB/7BEY6/GpL59Cg4hjVrEuJhn8kMhRbPIGgW7nq9R7bxHlGqAy0JU7ZfcjAlfCeIKsECaNzxL6i1YnuoQ/4qNT6frn0tpk6Dfeh7+i7WaHFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8CbDpZWHM12cKz8a7Ai3EkA7QRZ3QZnMqfTjz225yQ=;
 b=SW5C4P6gLpScZClBosK1BGFjOjV6FJ/NAZccWpT99KZ55PKaNDsEqAOldB/5RBqmQcUgemhS/yuOwrZuYY9rMsajikyMs0gC5NF2LEzmTrbxa0Va327Bmsopbf8pKSxwkfsIFjnYpov0aS+M4Hd3hCqZNdIr3wKDcrjjEE2lsoE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by LV9PR12MB9832.namprd12.prod.outlook.com (2603:10b6:408:2f3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 01:32:28 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 01:32:27 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
Subject: RE: [PATCH 2/4 v4] drm/amdgpu: Add functions to get/clear bank count
Thread-Topic: [PATCH 2/4 v4] drm/amdgpu: Add functions to get/clear bank count
Thread-Index: AQHcD1c2EcWfLb453UKjqK7R7SI5sLRnoIHg
Date: Mon, 18 Aug 2025 01:32:27 +0000
Message-ID: <PH7PR12MB59972D4101F4AE98EC0EF8CB8231A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250817091317.308809-1-cesun102@amd.com>
In-Reply-To: <20250817091317.308809-1-cesun102@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-18T01:29:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|LV9PR12MB9832:EE_
x-ms-office365-filtering-correlation-id: a75aeef5-e3fb-402b-1cb6-08ddddf71771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6JfcRpidWrCEBaK+hCwfDJZl377/YURT5e6CVPUtCauLn2Nq02NGa1/tCLsB?=
 =?us-ascii?Q?jfKDcabXbuktNhrpQPPnbZkC52tFG6zfoZPHgF0oCVfEHXHzwBCbW1/Aea32?=
 =?us-ascii?Q?kjwzzHZtvBrujc0ELQJihXJuy0htYtJXMt5wsROFc+vg8tu00gFzSuhZdAAs?=
 =?us-ascii?Q?P5E7b4KRE5+cpJNMXsU5QlhunoSMmVg1JolRKH46Pva4yJDLniO0Pnlhk/0w?=
 =?us-ascii?Q?U00PjlO4Kjg7MS/HV4RzPfHcqkmc+VD1RHNnF50ZW17hlYK4isUsJx52u0OB?=
 =?us-ascii?Q?Ul5eOVQ/Wdv6Gjeg0xq3AizlydRpm1dRyuGhuOAsoPVnjLh+qE0Y/B2nYtg0?=
 =?us-ascii?Q?8HI7pDEGoWMEIlIlwbG3U0wB+fDUg67OOZs+CzapK/hv9v4hc/qRLg/VXPW0?=
 =?us-ascii?Q?Hc2Xp+l4OSZsdpoYtU9d+qltfV5w13T4jP1dl+qgr0elyzXK57kUxnQv0B8e?=
 =?us-ascii?Q?mydirf8oPO6OiUWSr/lh5YELDLEQZYcsrAbF/JhKFzeCiG/rJcCLufrY8RoL?=
 =?us-ascii?Q?h5o8inqvxc9kngRe5Bg6A3WBgvf0O5S/dkviNk8OubA2FbqVSIT0DcyGH0Kz?=
 =?us-ascii?Q?tZs7nxQn11EhvFxPKfrSd1vD3jz61MuqRFv7OwlzjOry0utexwXIWSUhPouk?=
 =?us-ascii?Q?AyMJKAUl7F6moVlImtIwOc4FZvdiXN0dOA3ahXu4wCty1zoET7qqC3hDCCfi?=
 =?us-ascii?Q?UppwVPXPBbBp00HPZDE5oJkN5F0uXD+YW4pZI58VOApWUqLiDfWoCO7OPzQz?=
 =?us-ascii?Q?d/gBJiG0u007u7dW9INmWl8oOmw4SYM8+ZPCTYPpaAcejQX3DAOI82nyyzq/?=
 =?us-ascii?Q?lRRQEiLaQRf5Rh8QywBNbl2PfZ1TEvmRsnuAs9SxQ7MDEPqU3Lf4XoHQ1j1J?=
 =?us-ascii?Q?kSvcAulnPqVi3Sz5qp4MkANzuCp2hAsnmXUPssv7SFWC+fVrwM7oEE6amfmz?=
 =?us-ascii?Q?up1BQqbWi4dHaY7ACddC9snKtYsLO0eRjXRhE4twLhbmdelf/6pjDZkXuEX3?=
 =?us-ascii?Q?GNtkDMxEOP5PtWf3utdAEFLb9fDTUlGE4Mq19dWNSdneSjo45WmBrIW+ZKeT?=
 =?us-ascii?Q?StUJdCQG9JQPbvnxLwobzAFXgLJY2/llSAM2MDGpuICOVnd4oVLOGMaHWAEy?=
 =?us-ascii?Q?Z7fich/bVSf+O0Po2GjxLAFsQMcvO+PeySuyxVO0WaDODJXB9p2fgRAVFEGi?=
 =?us-ascii?Q?rZUNsYzfWfcvD7q3bQ53HZLELR5kHL5FS1V2SGcrpHGEosWvKGglWaXMrJoW?=
 =?us-ascii?Q?SVnV6G/YMUyOnU6JY8p5hs5u5ctw7LhXBOZk/mqVV1yha6z8WHkCfrTm6czI?=
 =?us-ascii?Q?u2FpCAHZjlagqJXDUWn0Nv4nrw2zB9SXe5WXZuxBC7JpE1jTWE9OsK8Jv4Vq?=
 =?us-ascii?Q?taDRkwSUs2W8TQCuKe/y5mK9zI66C//VNTMKWDfVaY2uGcXqF5h/+r0MlJah?=
 =?us-ascii?Q?mYzT2gJCo601yS7OcmBX81a1wE2yHPlvmuPFkZ9k+6ZN+Jx5qdUO+PDkjAoq?=
 =?us-ascii?Q?7+9VsEsvrH8jaZQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?++7yhzgBjBkf0c20XOI1Qp+bypbKM7zm67Urn/6kQEQXg3g78Eetv+ixGhH1?=
 =?us-ascii?Q?OcXEdPXWCi4oBGth0Jh0uCsaM5S6o3sKxxi7rrxgSaUA+0XJ7NDPN3yTy5Ro?=
 =?us-ascii?Q?ogNj2E8qhVrc4prYrldcEyzQat5oGSvKpTJMIqTcOUNxUSa9VN7x6WFASMaM?=
 =?us-ascii?Q?UZLiczxmov4KqAljn4kHbb/XCyiToI/iISYsFBoDzqW9vEFQIm/o4GdzceeN?=
 =?us-ascii?Q?UHCDnank+886XcrhbzETV13ij6dmt87fS3rcSIh8Cw8wrpx+ZUumob+B5qy1?=
 =?us-ascii?Q?+7OyBNn8zI3im5rIr0chjydIsYt8361HmnV7KTUwQzp68USjKOxvu3p2uOjc?=
 =?us-ascii?Q?TjdOjYMCP88B09/lTKmmrIthaCFHYWN22bSj8g/SGAjSLvU4ezCpSwW6HFFW?=
 =?us-ascii?Q?dYiDJAgSIB9eziAfuRDLH0JMLPz67bGdSP6oEy+We5402ErH73V8Z19Xbe7/?=
 =?us-ascii?Q?3PWXHjUK78JptGuIV01xH8AEeRAqzuagjcLw1gvKNae+x0MIkQbGXJwasoT1?=
 =?us-ascii?Q?M6ZGEd2Y98GlumfKLK82BtSlXWG0S5sec8W7EIvaXjzALoKnLtsGr4OgOBa3?=
 =?us-ascii?Q?NqPD66tc7hXkTP4o66fGy1r2VXzB9Zl2QJRcg1UlozpEqTZLcvK5kuX+b9Kb?=
 =?us-ascii?Q?Jh8dmtIXXpz3jM1ZjKC70KxXzQkNbyHJZk7DyQScmnGhHMgFT+zCJIlwK5y/?=
 =?us-ascii?Q?ctqAeVJHxNPMNVJ38IqLv7M3I/jRElMhsBaXy+NvsI28pd5Z4oTGFfY5SqYc?=
 =?us-ascii?Q?sVn14WrmAYxnCcaV2ICYVu0VzR7BTW9a1pv8YpeeNCGxejYbxyg7RHSWuLge?=
 =?us-ascii?Q?lSJlbAfHo0IEeUDYEHOcfaibZHeW1ckp6p/Ayi0wCzO6TDCeKACwtRQsTFDc?=
 =?us-ascii?Q?qf1w5cX8rgDDrneY+S3iebFzn0O3L9TmVJf8u/+qQ3PtPbxsAQgkzp6YpaAL?=
 =?us-ascii?Q?uxSxb/0CTiA4exDCb004NTcrmG3bZvRO+xs7a7sekr43+MNQBlAntQ6gqbrL?=
 =?us-ascii?Q?vaCz17f5fm1+Td0WJb9Y3IheBvKl6u7Qa/D9GFFlXYgcpnfDdfJJoH3NdASC?=
 =?us-ascii?Q?i0B/7VzU6ARSExtiJXeWQJ9CLxcRAC+MCsi1C7HiZKBpNDbEx1G3TO+1sl/i?=
 =?us-ascii?Q?WsugCBUeTbHhtpkVXVEJDcJdn2bDVs5TWWsgAsriPrZ2CQBkv0zGb4DAYsCy?=
 =?us-ascii?Q?Eb9dM4pqPtGO705Ei+ag5nPZP7yjEg3XU8AxbEvzHcTrhsvqAzmXp39VC963?=
 =?us-ascii?Q?7zkrvqAFvCQYoptrGzFwUi0XCjre9/XMI+CvFz6ibZYnuX8RdWy74T4SubGC?=
 =?us-ascii?Q?nsjk7Zx6APGoQI5ZXBkau2Hjcu9QXuxZOJeqWRfXldm7O8ojV9X1/cC5KgPX?=
 =?us-ascii?Q?v357fuRHP7vh33sdL6bxiW3HABpqQWXieqYaYcJeOFF96JPVD796iSHzI108?=
 =?us-ascii?Q?Lyd7FXEV7Xg+mXef7v0YdornS3e7DKsxU2aoLpvFF78TCnJuod7tawRc1xHq?=
 =?us-ascii?Q?L56qBJed7CCTwtnucinKMTZ+KgP/t+Ipo9+r2R1Ht2I2Y/LYIw4Vo0yJEBEZ?=
 =?us-ascii?Q?BDdj6zz2748ardp0oqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75aeef5-e3fb-402b-1cb6-08ddddf71771
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 01:32:27.6398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLjnnhEKpAs+HWs+vXiXqWIW71a5/d+bGJpEPgEx0RxQuJz9gND7525tzdPnjlds
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9832
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

+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev);

It's better to change the function type from 'size_t' to 'u64', and the 'si=
ze_t' might a risk on 32bit system.
With that fixed, the patch #1- #3 is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Sunday, August 17, 2025 17:13
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH 2/4 v4] drm/amdgpu: Add functions to get/clear bank count

Add the amdgpu_aca_get_bank_count/amdgpu_aca_clear_bank_count interface

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 10 ++++++++++  drivers/gpu/drm/a=
md/amdgpu/amdgpu_aca.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 090bf6cf1b91..32164d62c4dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -480,6 +480,8 @@ static int aca_banks_update(struct amdgpu_device *adev,=
 enum aca_smu_type type,
                goto err_release_banks;
        }

+       atomic64_add(banks.nr_banks, &aca->bank_count);
+
        ret =3D aca_dispatch_banks(&aca->mgr, &banks, type,
                                 handler, data);
        if (ret)
@@ -766,6 +768,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)
        int ret;

        atomic_set(&aca->ue_update_flag, 0);
+       atomic64_set(&aca->bank_count, 0);

        ret =3D aca_manager_init(&aca->mgr);
        if (ret)
@@ -781,6 +784,7 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
        aca_manager_fini(&aca->mgr);

        atomic_set(&aca->ue_update_flag, 0);
+       atomic64_set(&aca->bank_count, 0);
 }

 int amdgpu_aca_reset(struct amdgpu_device *adev) @@ -788,6 +792,7 @@ int a=
mdgpu_aca_reset(struct amdgpu_device *adev)
        struct amdgpu_aca *aca =3D &adev->aca;

        atomic_set(&aca->ue_update_flag, 0);
+       atomic64_set(&aca->bank_count, 0);

        return 0;
 }
@@ -865,6 +870,11 @@ int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device=
 *adev, bool en)
        return smu_funcs->set_debug_mode(adev, en);  }

+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev) {
+       return atomic64_read(&adev->aca.bank_count);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)  { diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/am=
dgpu_aca.h
index 38c88897e1ec..fd0b55469a2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -202,6 +202,7 @@ struct amdgpu_aca {
        const struct aca_smu_funcs *smu_funcs;
        atomic_t ue_update_flag;
        bool is_enabled;
+       atomic64_t bank_count;
 };

 struct aca_info {
@@ -225,6 +226,7 @@ void amdgpu_aca_remove_handle(struct aca_handle *handle=
);  int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_ha=
ndle *handle,
                              enum aca_error_type type, struct ras_err_data=
 *err_data,
                              struct ras_query_context *qctx);
+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);  v=
oid amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *=
root);  int aca_error_cache_log_bank_error(struct aca_handle *handle, struc=
t aca_bank_info *info,
--
2.34.1

