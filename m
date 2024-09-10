Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D63EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 04:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735DE10E099;
	Tue, 10 Sep 2024 04:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M3oxpHY7";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B1A10E099
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 04:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ3hMCE2J+IGq0aR2ySwSyl2CESATkupwY4bkMzHTQOD9xZCKWVq0I6AKCQjwemo0Yd1YzPflC8zNSbNVI2U1v8/YTPFv2d80jpWKib+0FVy3h6aOFmjczizKfjICMxGwHNuWfW0Kmp6e8S21oECcsmXv+Jc23bBXeE/AQ6BskQkWNE31e06z5vusgSZGwcW1q0odAsEut4XAD3C4xzRShwo9kuQMuNuerrGSTPmNSvoQBXfZKgkniylTgwpSSw0uWVS1elsq0UMKQn2ywpRMewZwSMKr6dJeqHiWpMbSJNq64Dk5Q6YyoCs6+bz5yIsAzfERVVnxHXBzstpXhQUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgHT/hrKj6qdTJ/zz5zHJPQ9L0mASjKlchq4tJ+tv10=;
 b=bCeSi+mdrcUltaG6/tbyuM2CgDvRNJeUpzqFQn++uelmz+iU0heTyl64D876i0kB2Xg2xWBV/fkUc/bMl9I3udr2ET4S83DbJ+ef0LSO/VdDbdGyyd0fIFxOxpeKiMrxEMrrQJuNZjFmOIN89NWmI8YxvJ8bOiLRhTfLXUud7Gzqfm8yJ7lNgDF8YOjuCLW+WDyD2hJ24sDf0UCIqJrminLlnlvfT6pS/bhz3lOH+6qgglUKBu9OqN1oM+ympqw4de46EVj16XGwKj2iYrC04kbcXhloc6QBTVMUvIwX6hbXUAJ7n7Ok1BZlwnwvSuNXDDnFPxJRujPkb6DDLVxIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgHT/hrKj6qdTJ/zz5zHJPQ9L0mASjKlchq4tJ+tv10=;
 b=M3oxpHY71bI/RJ4gQqFBBQGZHCMOXoTD3RI0oRoGgpOWmcMv5TP0Ae9LEQpwxLHIU7Gnrbi62zleVRMa1SEyoibUc/XEjXbAiAZUicRBdQjaKqi3wV2lJR9UagaZnMeX8VAkouC26rrKKEVgXiPLvUsLKYSBXEAn/YOwGYJyAmw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Tue, 10 Sep
 2024 04:17:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 04:17:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific
 ASIC
Thread-Topic: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for
 specific ASIC
Thread-Index: AQHbAzXixmXuZdgmgE6dgEBYOzqdmrJQakqQ
Date: Tue, 10 Sep 2024 04:17:55 +0000
Message-ID: <BN9PR12MB52571DFB965CCD095A7C92C4FC9A2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240910035914.20273-1-tao.zhou1@amd.com>
In-Reply-To: <20240910035914.20273-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=98f6c1b2-d97b-464b-b7fb-a51956cd5179;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-10T04:17:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB6761:EE_
x-ms-office365-filtering-correlation-id: 25ab30ec-9528-4e83-6ea8-08dcd14f8b98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OXLlri625aHQuxFOlm7XgA1nmoQts6GIxL7aCzlLsBv4W3jIZSTdGZXfo19M?=
 =?us-ascii?Q?kWqeAxXu58R+EOvCS4YhGYY7CzVT/MXjk1piHq6PUX/gVS5Q/a1ehSsHrGUo?=
 =?us-ascii?Q?g+6IJcr2m7YBS/jYaVXvBDeO9UXP4t8bphv2a9N2sMtz5mee4UjhzeJ46MB6?=
 =?us-ascii?Q?Yeady6pU5wNMRD49cIdEcv1zkVAtHBfEkoXmWnMTwWDR94PxxDPwtzTbvTls?=
 =?us-ascii?Q?d2zuokr3w5sOzYb8T2ZnnyQkGapKx4dNiQZ7j27venGW0MWXL+RkNuy9bOO4?=
 =?us-ascii?Q?zUY4r/jph1gh384zXng2bexmGoo+4A7CQliCV3JKDADCFSDS+13yINCDAMPx?=
 =?us-ascii?Q?6ZHbZI5IHmmbQfS/F1keZVXwKeWmEX/bMRMSSBJZ3VOFTT+sZCwRK9LGbqHV?=
 =?us-ascii?Q?/7jLdblF9uTCkdShUwSEmb27CtJ8kq9t5i7pFQyW4rgLz9VZE5S15buN52XI?=
 =?us-ascii?Q?2ffHrXvdU723bZRYsVfD2D+M5ProByhs0X62EEAgXIc95pCDnQSf058BDJrC?=
 =?us-ascii?Q?NMdHXunLT3u2tcvr727PzjgrSsSY8PZsPwRP5+RIzSjnTFQ1s75heH7VjOYJ?=
 =?us-ascii?Q?UT4Bcp+tVqdTsCibVQVlp6+24sJDgjO9iOV275cyrhL4IrGNmOC+6x2YRo6g?=
 =?us-ascii?Q?vk/GoF3wta2p8FV75NEwerWZ86c8hNETBKTmsANYW5XsKEEN9itRPTF/zEAw?=
 =?us-ascii?Q?xLiyTKX0m6X4X5Cj2Xutdzdivw2Yc/WlWN8PKC1twmgHYCfBVOn8KQx9J9t5?=
 =?us-ascii?Q?hmbJ/Mi+i2KNDxvBWDCaJG+e+GAKIeHjk4hCl/Bj6W3GcxRDZhB/NPVpYd9I?=
 =?us-ascii?Q?ExG4LxINEmRWBvu5OMsKG6qAlRDyKHm4WBcQf519CLOOyJ5gWbvUhMadkyG4?=
 =?us-ascii?Q?MPyCWY6NHNX1MS3W6/fjwI7O3WMIa+owE53GFDSSCIqORjrU8MO5j/QUyRGg?=
 =?us-ascii?Q?9cftMS9vBmGW1dwIRH8MUjsbjFHvUmEMOL9wA8cW6ip4he9S8ZWaWGBBfjEO?=
 =?us-ascii?Q?uhAZdeHRruKX0qKJtBSjHGTMNtRVs+uYrrf9endRKdE3Vow6+wWF31doTI+G?=
 =?us-ascii?Q?VcqdJmPnNeCDgu+ptKB/chKxtUNhCcVutJ2/4jcNyaNog5p630KQg6bVtzFR?=
 =?us-ascii?Q?wwlsmx5ZRlRPg0hSipe9yxxdR0KOI2bIkHbbDmSmAXn9yjDwuvbGzPLle4Zb?=
 =?us-ascii?Q?PcachV0M5Q1GIA0HB5fTui7ib5b6PKsSbnPsPfvgBKNzPTlQqrH0baqB7flH?=
 =?us-ascii?Q?Yj08i8d7QJSXs+dCXqky2ye50afzkOhOEjAVPmm3jQL4BXDSzC2e46RtIGaj?=
 =?us-ascii?Q?BdlseaYyz1LRMwt4TTZ6eJC/uoZ5AcYUz+Q/ynItsagFCYgo2zcmey8EovRB?=
 =?us-ascii?Q?8F8Fz9Jt5uRIvSFIGy01wsmCRdjvbvPpy7vxad8Z3BqLUTjOPQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NY2MvJhg+yowTuP8xScPW8CJIi7lLi/+hCZ/YDWgPWb5b/VOW4aQrGqzDUpQ?=
 =?us-ascii?Q?N2m6kc9gvR1TIjNNla3QYUU4GloQRbEKJLO3vXFVXoIz+9PBO82uu9Ch3IMC?=
 =?us-ascii?Q?+NbUYNY+GgGIeulY0C0nunBl10AWgj6itviKmUYcYv6J2DtHvT42k5PAe90E?=
 =?us-ascii?Q?VyaDduGbwsmvwH6RO5HHP8isaCkPI31FctqLTxytX57l3biHVTd846LZgkPQ?=
 =?us-ascii?Q?gT7U5RRpLzz7S6GhHipcRduFdvhRcOrbA5f+rEzMtIT72xA9bU+dJDA6Dllb?=
 =?us-ascii?Q?/XYy0vbUSQbP60PVOy/bpYA4yAfRbz0GqPtxellNuX13lN8VBOHoXohOxagT?=
 =?us-ascii?Q?1IfAuC2ohb5ujl9cbTrebK7kClBzK3tUzD/o+PfSGbZH8eP2TYfUo5YAkOr8?=
 =?us-ascii?Q?cGueYLNeBdUdKuGNycBJbNRz1wOvGT7GOEGce0DURxDkmcVXZzlCuafHPTvK?=
 =?us-ascii?Q?gUKuop5TilZdOvYdIQLmw/v0HG6jpa+uZv1KW9Gd5ibSRRErWjZQ5A/GHSFL?=
 =?us-ascii?Q?muu9R8qr8wLnD+jHD0FANmgmRK2r7QAb0odbelwBzkdkQB9UaIZLcRF4TFD8?=
 =?us-ascii?Q?zaax0Z6BiP18rfarqjzKa+oANaeuCGN1C5Yk3KQTyGBi1tHcSKvJHaKOJ/u3?=
 =?us-ascii?Q?SoVD0zUpPFSf2k0KZI0GgL0A88cFPiGkqZnKSmWfjcPwvzeAyk2Pdk5Hcdvg?=
 =?us-ascii?Q?UkFcmF19orb3A/bLNT4iRzNNdAgZTIqWMtfwGLjP/+7B6rggQVx3nrljclpg?=
 =?us-ascii?Q?6bukouMg9BfZE2mFr9vwafYS5eOGJtoYDhNX9Wd7faZ6RWazkhwdcQ0R9fR0?=
 =?us-ascii?Q?f5NZyl9CKZdBweaeNu8Tb0ds+v/c1YGfDoBE16G7KpWo9+XSsL8iT1Pb/J6/?=
 =?us-ascii?Q?W637/1bIyhrE0TXohFhOfx4QFUpUqi2bIrcIt2LCGayEpICA9RCBjjdQP90K?=
 =?us-ascii?Q?zYnHp+7IjM5IaYQ/zJUSV8HThvk1B4AybDQZeRPi1ojKQwESjgIFUCJSDnl2?=
 =?us-ascii?Q?/ijfox0uHcph5JuBz0Hg+g1OgTBatk0GlSFvFLDCDvy+kbQPEA6b0MsBahBM?=
 =?us-ascii?Q?U4TSk1ErKRSG6GQMyDifEQx2BD6DPiDM87YErvCXZ57zJwU9Q02gl9oGiBCS?=
 =?us-ascii?Q?V0kEJWqvAMimwbmgActPU0hQYFpjopZpSE+wtqDCJRd7cNxH7cSImJALPeuE?=
 =?us-ascii?Q?dZUJxOwSGnB+DdSlVD4lAApqUyExoJwW/6vvIa0AWbWK4FsKayz9wxvq7EIM?=
 =?us-ascii?Q?HEySjCZLMq5LQ60KF0X9qgZ+Ed56WPbqOZ988EFBDFbKzsPWsKQHkG5hUcFF?=
 =?us-ascii?Q?Fc80VjuL5uULr7HAH3KTqz59fFOlQ5WisG3JkvRD7MnvriEgIfqQXwQC3zIw?=
 =?us-ascii?Q?pWeuCsYuD5SU1kZTv5rzLkmwYh8nKbxTClRTGfnCfrN0zy4cJtcET49I21L1?=
 =?us-ascii?Q?cksDpRl8UUuRy7ZhiLlxskuQBVuAjnSp4fBg9X0RGKl6/rKx9i21hRv/QsFw?=
 =?us-ascii?Q?103YSRfgxIr24H6H4QR3N+jmbmqg6jO1H0XYEif4fr041TMMJUNgKskcBGXL?=
 =?us-ascii?Q?JzpaYLlbc68SDeQUDSppo1lJJFgSd0o24EZ3GliA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ab30ec-9528-4e83-6ea8-08dcd14f8b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 04:17:55.3824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9b7KBav8t2AY3VIRZYVeODFiqK2wlJx090mtMor+0WgHxN5yADqTa0Oqy54LHFJ2GBAmR1H0XidYe3MbM2CEWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Tuesday, September 10, 2024 11:59
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific =
ASIC

The feature is not applicable to specific app platform.

v2: update the disablement condition and commit description

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index dbfc41ddc3c7..08efc9121adc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2055,6 +2055,11 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *=
adev)
        con->event_state_attr =3D dev_attr_event_state;
        sysfs_attr_init(attrs[3]);

+       /* bad page feature is not applicable to specific app platform */
+       if (adev->gmc.is_app_apu &&
+           amdgpu_ip_version(adev, UMC_HWIP, 0) =3D=3D IP_VERSION(12, 0, 0=
))
+               amdgpu_bad_page_threshold =3D 0;
+
        if (amdgpu_bad_page_threshold !=3D 0) {
                /* add bad_page_features entry */
                bin_attr_gpu_vram_bad_pages.private =3D NULL;
--
2.34.1

