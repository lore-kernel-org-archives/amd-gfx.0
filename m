Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD3DCFC264
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 03:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD6610E26B;
	Tue, 15 Oct 2024 03:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XmUixqa8";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7357210E26B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 03:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou7piKqgNm1foDzsoWKpnyyBnGdSFr6H/iEaHa0bfTu+BvmkzrxOVH6mkalRA9KIJu8UhAMT8izg/3EAAnSmGp5up00ELZbhBIkGtm2FbwZooT8ypQcPKuN9Bb8wSvgTerZVF/rlQyUfmvrpCgoaYeBZCYb3Zg0rFDSBpgvGhDkSnbPXrMbz10PIEEqVZpD2HFERW8DQ5NlaF28o0Gu3J9Wsj7dadK1puxmfE9bu1cyBPi8Q/e/NJUE4mOh28meC7n4wrIEIgTr3uLjcWqStDhDZFnx5Op6KWn2WJP2WmryGcdfCsRau8fk9rAEsxQcmekZd8PxBlUMdNqRkB4LcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVuScMe6m3uWodmqT1EeNrOoohlgKc4QnJusPJRZb38=;
 b=j/7CsnVS2nfiRa/yu8wnIBZl3+LZUW3HN7RtEzAUtIQTEJdGZfckZj579N+fnTHfla4JJFotAtlD9O6+mwG14RkO48iAr0MbOQCuEoLv0MvNAAnZAp4J8M0eZHQjWYRSNZLaD0ov/UUWyPW6CofVbQKVqrigg2wkZF/2dT0xwCTjVb5mFyI8uSujuluNeHIVrQDnuqrdtsPEQhoMemDJ1WPbCE4yyCkz1Bq58MtgG1tcMraO/nSbCa1krlD7mT+ukAwSM3vs2LEI9fN4jQ4I7x+f7bMLHwbGTYvKxCw6jG8aSy2kFRRB355Gr5iJhCY4GF6zNbjot1CglIfDjDjHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVuScMe6m3uWodmqT1EeNrOoohlgKc4QnJusPJRZb38=;
 b=XmUixqa8PlTSRPe8BX9PJ45fpWXwsrUdJAhs4wxaGLU3MQnHxElbR0HBqCNQT8foxCkjh7uQ42ayyHZokWp/xCyTthYqS6VvfO5EBjpLJ5LJCbbDM2bS6XI6bhtkPvHh6ojPG1VTtV/Opey+XrvwNoyYVNzgC7QIfDjnB0eKybk=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Tue, 15 Oct 2024 03:42:50 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 03:42:50 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhou, Hao (Claire)" <Hao.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use SPX as default in partition config
Thread-Topic: [PATCH] drm/amdgpu: Use SPX as default in partition config
Thread-Index: AQHbHhoueIf3P5bpGE+qOeG/vAVVOrKHLEIQ
Date: Tue, 15 Oct 2024 03:42:50 +0000
Message-ID: <DS7PR12MB6071A01B18936FACC10A73EB8E452@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20241014091911.3036389-1-lijo.lazar@amd.com>
In-Reply-To: <20241014091911.3036389-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=fa5aa723-c317-4b35-9c73-3d11307be064;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-15T03:42:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CYYPR12MB8729:EE_
x-ms-office365-filtering-correlation-id: ab0ceb29-a965-4be3-4784-08dceccb719e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?v6fWlbzDY9k7D1cFiXaPRCI3co2jg+aiULcZ6NcmRpgNH0LukTmB6vlx/1fu?=
 =?us-ascii?Q?YimjUK/8/1vfqg54/DgnJ2lcZDakO3bJVss6uWwSi9fquU66e8af6I5tEb2O?=
 =?us-ascii?Q?viNoCjdbsIm79UOUxil0k15IS76RXP/YSsFbbCyabp+BYbfutC0Axt0WM8/X?=
 =?us-ascii?Q?CujSHZYwzB8s7tZfIxrHOUVroS2nI7rj3ImlzZfn1WDZ1bp2dBxtFzRiUrLf?=
 =?us-ascii?Q?3CKGv6aRvHUCfeV7h4dGqPQOuS3z/0wIGGUDLi+HMCd9qBWKVJR8Cr7jG+5n?=
 =?us-ascii?Q?7FHwy1IAPJVeBw2tyhOGYL2LrlWTEB9NxwIQBc5sHgvtONodRDQ75kob46Jz?=
 =?us-ascii?Q?r31gYPc7aNy82CbeG1gT7XuEdy8sVgc0WBp+uFdWxnN5ZSy8zKCQBPThJnis?=
 =?us-ascii?Q?1HgtYbIAAL4fFsIKSStZ0bIPHvbxGfnpdyIv2nxSdVltr9ra8S78EGd6lktH?=
 =?us-ascii?Q?X0kv5DeoZzzug/yJCJ8qMRzqyopUY6qey0iKlQ8rHwj4Muf4HyjG05qfHViy?=
 =?us-ascii?Q?XvkB9PNj/rwFTTUBqs5S1YIeGpmvoUixIqfn2juu2+8FtPLFsowh/2B49zbq?=
 =?us-ascii?Q?fu1eYe5alQLmu/KXcLDUL4OIPRnvtwz8KVXJMBnwZrF8bR8uu2FTqPD/WxPQ?=
 =?us-ascii?Q?+kAK0I5YkrzUhOxRjGPE16w2Eo5dd8L1lUWFx/ht2v1gQeC7jsXQVWdG34MF?=
 =?us-ascii?Q?V+UI6xuUJeIg2R2eZvmA/eKy0RghsFyEgwZNCH1ZMkUAjbOX1ThAMsHpr/ue?=
 =?us-ascii?Q?qIO5KogMxj21KeIvnSsSFfowjDCzMdbBU8thyLB9mnjaAW4KoP7ck6pj4RAF?=
 =?us-ascii?Q?iQYlKi60ZVYbYgV1ATRhD/1kI5DLQr5WQQx08UAEB6zJ/ndmbzxbOu/erGMt?=
 =?us-ascii?Q?k/y92+kz5esid8BtY1ZB1LVtr6VTBtt4asc13wiwafPr+UZr0vFv9QV9Trhn?=
 =?us-ascii?Q?e2yHJH7+sk+rEGxKoJ+cldCF/mYcGWSl7RH9iziOm3l23SIn/UcK7yeZtGkm?=
 =?us-ascii?Q?LK+yO59oGCsrsekrQyha8O5XsbVve37tE0b/J4TFTIkngmfHGW1JX7xcRUSb?=
 =?us-ascii?Q?865lsMw6BhXnoT6vrWGLCmaPde+K0slDemZkVcg7P3yDaB/RTLa0r9yeb3+p?=
 =?us-ascii?Q?1eI8jSfxf/azEybKJWwhp91Z2lg9qzUpxkmfEcnaXmyG9LQxGYUNR49Ni6n2?=
 =?us-ascii?Q?KmpPSiGDj4+iniTQSBzAOH4O9ql5s1RonGnsIf67J/dOQNjVzaLaSJcdc14h?=
 =?us-ascii?Q?HOffDeNhYRdZ6K5Tjyx72jgDTp9z/wKenCWzRuH8J6JspmlngoZ5TcSbOyX0?=
 =?us-ascii?Q?Mn1vj2sdwyHN6TsINDWqdofb27Xkc+cvecb2RF1gZFbhGQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SIbVvKijh3Eay17THjUEQVlQOjQGwmCFkaGxYd3NEKQ4Q9fWsRdRusAI2c00?=
 =?us-ascii?Q?g0JfhhB5jKspCOaHFziZfM6xnJXXEfbXF+rp+vBjRb1aR5m8HRpcgXF/Encb?=
 =?us-ascii?Q?hfhmtVVSfvMAhHeVFNn1E8nFuTpqKBS4QLJjI4Aq5OLbq5TDaQdYUEnW+mSk?=
 =?us-ascii?Q?S1mUOF55WMu1D9CdgJIMVnKelG8j9NuxscpujAbmQyvt5MLq5LGKC3g9GVvF?=
 =?us-ascii?Q?HFACRVrR8tH/tHket4eLmVeApdL+itBCH6r612mvQafQUMMsFk++pGTv/meD?=
 =?us-ascii?Q?KmG++9DYIeSRQXQQDBsznZvFVL+eSRdsCY/YyoEB2iGXyV2JphHhi0ZB4AzC?=
 =?us-ascii?Q?lHsVh8BKDMobzDTdUWK2qCdGu180oqlH9AEUDBgMr40cW2fmVBjBtqbDpvvL?=
 =?us-ascii?Q?/WSApMyp1p6EkJ8Po5B8TiDxwrt18QUCrZ5T+DdfmKcqa37TfFqoE3q/wzLG?=
 =?us-ascii?Q?8zMxDXIbEA7TPlwLG4aGfY4IqUAsrrvnGeeHSnhDgo5Z/YPABshBVnQwqUp+?=
 =?us-ascii?Q?JizwMwiH00OP/PNSLKlMITNlJFFqBe0rK1571VXJuWV5s2lf18L5cTQy64/O?=
 =?us-ascii?Q?SZJrYgiz/9aaRAb+8uoOnwF0DKYUZxOQQSa76+6RYC5H751m9tgEWSHjsvSs?=
 =?us-ascii?Q?k4+xsCKVBSkKJfIDTKTIVkBR4S5iZ1OL8CL/66qa9TAL8cAAHSYqYgF3V84k?=
 =?us-ascii?Q?9idhZKiQ5B97rj+DcgJ0Jk9/X1IhE1nJpioFVnjnkecgK0pDpsxcqR5lf6jx?=
 =?us-ascii?Q?d7v7eXfzktnU/mo/VQKHkn2+5HgG6hkFXxIe6vxxO2kPQi25Z0IZAKd9GnVJ?=
 =?us-ascii?Q?2HSqYTZxVy3ER232IH312FAOgnOJBLKVNGObogUAYhPIl8iAztLDBPBI1pwe?=
 =?us-ascii?Q?zUTuzlzX2/1BQDOzHTrq5UVBRMEqmCl68RvVEzMaDFg+WNpRJpeKKkFq7TTE?=
 =?us-ascii?Q?IlqPkxTd5Z3WUQkbtiFcfZeyGCTZS4JpbTaHcQn8gTqdtDFwDvoEqGHzCtNS?=
 =?us-ascii?Q?nyb/l63iRZBuhHENWx4c/j9zPIIcPAZIJdIHL1K1NSuHEAnlWgaMKwQblzBb?=
 =?us-ascii?Q?VYI3uU5jlpjUhEJVL6K11/X78hxy4luX5W/tq/TdWRR2CRiu2qIF6PVzIaTq?=
 =?us-ascii?Q?+vi8gAQfgAfKrXbBHRWWDUMQhu28yyvD3uhmV9kueX76AKjGyo906VAd8rzw?=
 =?us-ascii?Q?UmoxA0AvArDnyMDPqDgiTm1uGszSG5gvVtjtzgIJnrVaIlkE5dNoc6ObMMrZ?=
 =?us-ascii?Q?k2XgSty7SFS0jtYKDzH4JHK7tM/lUsRUYf8Etr72lEZdFR2hmGlcOTZHefnW?=
 =?us-ascii?Q?89asWtwRIxCJilqrotjKFFJYrO+2TmVjqNU9S8iSlFnczTVO1YFMjBC8b9Pm?=
 =?us-ascii?Q?GvLdQ27DUbesiROeLMiFFU4L8tcCqTeH13Hb+uyJCJxExPZGsga+yIiubb+o?=
 =?us-ascii?Q?ukQJ02GWL4+xRcD9sgZsDGXeCgCzduSkfps8UCO1Rd64RwaVfmjM6I1ZKhai?=
 =?us-ascii?Q?gHV3LzsIO+MO3nqKdPLjUbJWpV6LAmpmWpIH+8x1HrSVLmVKY1L4JtrWU8uP?=
 =?us-ascii?Q?0xWKYmGsPFZsbKyKBXA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0ceb29-a965-4be3-4784-08dceccb719e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 03:42:50.8323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YJ3CTwnlRBWZgihEwiBAdIJLG88WazuVR1A7woNqAsDNulAnHC8gRknkUloFApJfID1TOy8x61f5TMs/pxGpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, October 14, 2024 2:49 PM
To: amd-gfx@lists.freedesktop.org; Kamal, Asad <Asad.Kamal@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhou, Hao (Claire) <Hao.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Use SPX as default in partition config

In certain cases - ex: when a reset is required on initialization - XCP man=
ager won't have a valid partition mode. In such cases, use SPX as the defau=
lt selected mode for which partition configuration details are populated.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: Hao Zhou <hao.zhou@amd.com>

Fixes: c7de57033d9b ("drm/amdgpu: Add sysfs nodes to get xcp details")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index 111bf897e72e..83a16918ea76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -606,7 +606,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *ad=
ev)  {
        struct amdgpu_xcp_res_details *xcp_res;
        struct amdgpu_xcp_cfg *xcp_cfg;
-       int i, r, j, rid;
+       int i, r, j, rid, mode;

        if (!adev->xcp_mgr)
                return;
@@ -625,11 +625,15 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *=
adev)
        if (r)
                goto err1;

-       r =3D amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, xcp_cfg->xcp_mgr->m=
ode, xcp_cfg);
+       mode =3D (xcp_cfg->xcp_mgr->mode =3D=3D
+               AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
+                      AMDGPU_SPX_PARTITION_MODE :
+                      xcp_cfg->xcp_mgr->mode;
+       r =3D amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, mode, xcp_cfg);
        if (r)
                goto err1;

-       xcp_cfg->mode =3D xcp_cfg->xcp_mgr->mode;
+       xcp_cfg->mode =3D mode;
        for (i =3D 0; i < xcp_cfg->num_res; i++) {
                xcp_res =3D &xcp_cfg->xcp_res[i];
                rid =3D xcp_res->id;
--
2.25.1

