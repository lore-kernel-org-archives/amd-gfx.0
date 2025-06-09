Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9834C5B552
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jun 2025 17:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557A710E0DF;
	Mon,  9 Jun 2025 17:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WNrJJ5eC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E335110E0DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 17:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GznsGSMvEbTRHcv8CZNwxdsx4kpAG+mTHm8Iz8JYMHk8TqxKX7iCetB/G8TFm3OFSdsQeLsiw9KPuaMx54N3T4Yr6+mzTuJkpOcriITShZ49xx4yUJ21wvQCgsb1fl3oQgh5dSUINQb9xdSscjFlPYNhZLmkVmYhKajS6WW0xGOnILG5HcWrL3NGNQC5di9VybMfukEABzju9xURe3TFAGbJth3e2KiydGrH8bLXNly011u9RovZEOlAJ+Ft171bYLbHAohos5+6EvurtJtFtOIBwTFMVac8vmhvWrkg5sItU3eYLSHHcqzK6W0gfAsLraSNHQLTvp38h2CkZJBNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KECvX7c73nxfW+FD2egcBhw0fGTGtX8+lmBh0dd0bsc=;
 b=oH8Pe0XSCfrVsFP8Qrqh8GeIJBQZlCv2mb8t1YxnPgpLb8k8v0m6s6jx/NcBE4vrFylOusMf+i7WSBDDW+2XjYkEy9hs+AhzbHRTfiMrn/DIBZrDfqv52y01HQsNhF8mBuQbUhBDbiM4Y38i2mQc9krtLfoC3YtCj0IW6O+oJGcId0cM+6KH/3t470Rvxk1qJjsuDngRK+P1S7lwzfI9DPjy5G9bRsTIWyZGdIIU1HRYZrG6lMFA21Q3pvZP2xcHdHUJJHWAmxDExi+efjAx/OPvt8KvuKCear/z393Cg3l/Bx0AUOssW952qgeRwcNyTjL7hoEcBlcjAwn7gpTbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KECvX7c73nxfW+FD2egcBhw0fGTGtX8+lmBh0dd0bsc=;
 b=WNrJJ5eCSdsNLCJq1LViYVgZZ/FXpau6PZfzAX02ESzwUmc7PB2NQiyOrly+TJnrS9EkdQlmi61VMBst04KQoLLCf4d83ag4fz8eJEVEGb5jofmpxv2vuaSeR7+nb3i43vL4FTvIL5PP8EaGNJ4zl/a6PU2EEu+zwBN4vOc+J/E=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Mon, 9 Jun
 2025 17:23:55 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%6]) with mapi id 15.20.8792.035; Mon, 9 Jun 2025
 17:23:55 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mes: add compatibility checks for
 set_hw_resource_1
Thread-Topic: [PATCH] drm/amdgpu/mes: add compatibility checks for
 set_hw_resource_1
Thread-Index: AQHb2VP8SAFTa7CKu0ydK636gQ2DDbP7EMyA
Date: Mon, 9 Jun 2025 17:23:55 +0000
Message-ID: <CH0PR12MB53728EB1FFAB23EE7789405AF46BA@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250609153410.15977-1-alexander.deucher@amd.com>
In-Reply-To: <20250609153410.15977-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5e2591cd-2b5e-459f-80a2-a63ab1ff3717;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-09T17:12:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SA5PPFCB4F033D6:EE_
x-ms-office365-filtering-correlation-id: 3f4c0775-f291-4ff1-1276-08dda77a698f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?I1S5D4L5wV6+HFmG1E6slXSpJzDjYQFV6kQ+PnQKOvbN3X8eDFp/VoHQBvpk?=
 =?us-ascii?Q?QQ1Gt8Ru3pJQe9i3iSJMMuC5/tazwHhqWBRUyE2jbkbSN9dlDtmOK/Kk/vrO?=
 =?us-ascii?Q?eAnMmp0+ToD6Mw/GUpye1ZPjyUDHjpHtmrZvMtHdK/E2l8hpa0rWi43RqWic?=
 =?us-ascii?Q?BTN5g1eCtqpvae8R6FD/ev8UMdcqtx3T9aEYsQBbDo0xwS/83VDSSV2pJAmF?=
 =?us-ascii?Q?qV7etlN/v5+64kcRMlP4eDCYWSDX6LQxZsUOPszCZgsMQLCnNj9kRNQMX+Ki?=
 =?us-ascii?Q?wbEnSaybQ9ZmukQGcIUlvhDe4nKzd01QlW4wYIg5Xncen4zgaPdKKggpvIaL?=
 =?us-ascii?Q?pFWcgC1QSxulUZdku3c2yHBjchxqyNblK9bnFU0rKGB5Cu0XSe1E9En3aQQ5?=
 =?us-ascii?Q?7/FPt8ksBCMmy2nsDdgrMDKXXJGcgZyyoVGzuu6pQKMzLmF3WpfqH6uE2tHz?=
 =?us-ascii?Q?80LJ0LPQMWXuMxBRO3RSLM7gca+8xH2s2t3ORLc9yECoxquImNX3mTwbRIna?=
 =?us-ascii?Q?GujKUx3XkeFcctmlv+qFg2rUJJMcy8S+Hnd/lq+bUHmOpuuhryMa9MJjCZMd?=
 =?us-ascii?Q?SbYMYKqwvEM6v2RRYbuf91dhz+ehwF0y0LjrbeNHZ6qft1PyhM974JZI9taE?=
 =?us-ascii?Q?rCCS1Pbq4vzW7J0yd9dYjQ0TIRcCalCSLgxTauuQUmaQSjkUCqRufAA77dWT?=
 =?us-ascii?Q?wlcV66dDNau3KPdbPDye3jZGgjDnb6ccem2gZSEuuXZPuvYie0VlnAhoAkZx?=
 =?us-ascii?Q?wiIBrXvB8ocfys2xl/tc7XfmtfsZccswO2+/OuBbACuc/FiO7+6sqQPEo62E?=
 =?us-ascii?Q?QUKlRjXtEtpcSCP4NQpz5aDhx2NN/WREdev5Z6EAhpqQeXsLx2/jg3JVAuMn?=
 =?us-ascii?Q?G7U6Tvw72bGKMHk8hl6RbEB2FTVyNjFlEpUYZzf2DzLnZvVDqOISaKikUzsz?=
 =?us-ascii?Q?+YT8X4ikYPXKS7sPQmzGiOYsULiq9aZkCksXQVYz8TmrQzk3eH8494W7bjQj?=
 =?us-ascii?Q?K4+IFJyIaSgUoyMspRLo+rbsELg0iA7iCk6ALMR5W+tRycv7AYnDS/lcXpOi?=
 =?us-ascii?Q?ZUViMmsSk596B/8RKAeD/lZaLnyVXXfC63gylNNUdGrOeVRbyZ5O0ZW6rEAE?=
 =?us-ascii?Q?3b651ExurU7nayc8Z8tvOWXvQHe8L4XK8RH2zjVWBcnuiEvbPEKOWlTyzfAv?=
 =?us-ascii?Q?kqGMxqXAa0ZxM6dVGoZaQuonhdiwcmADyX13CnTAMHeNqpPIckunTBieSag4?=
 =?us-ascii?Q?84moE/fZLIm/nB9EbPik5hfbBW6DZhauDWgzqfC98f+EqLvYgX683cWTKfRI?=
 =?us-ascii?Q?31I3VfuPphJdUjGlYD7gvBxTaloexWPKZdCKPCD0o4O/hzxjgij54KsOwYcT?=
 =?us-ascii?Q?rHFH3YL59YLu8QSLS/FI165gYM0fKvQD1ZuO2ewplnmA2UmJrVD0I0GQBSzD?=
 =?us-ascii?Q?WqB7Df8f8DU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HpCOljH81ZAx/OJDR/v1Nsv86wRfy6qvIpndar3pH/NcocCFA93z1tFfpt5Q?=
 =?us-ascii?Q?iuHG00VQw+WVgWMnkLX2TW9BXz9viHeeibHkWOM3tbE3Bjy/sq0EmKfPUA83?=
 =?us-ascii?Q?hfBDVzKzIAMdzAnhfcSY0TEu7DLAh/JTpQGC5cSd53Sdo16RWZUnTTXJwkQs?=
 =?us-ascii?Q?iepbDyFEEjbtDDVwT/pEBF5n7RdH4czpdoPMP20Y7OlmVKPaH7qOrrdQik04?=
 =?us-ascii?Q?dwBBGVl+4nijb9k+ZjZrQrCYGUAx6MS+/n5v0NYO+nbrwnApD97AD31XkfKr?=
 =?us-ascii?Q?ez09dNE+cBRzIDT0vlzok0t7fyCEMfMIIHBTaSxiT4yU3CuTtY3e0JO8iequ?=
 =?us-ascii?Q?zYhKYNnxxyyEOBY9GkoysHkYtaPv+7CJLuYI5qTZHTQHYS8wYdJhcrAmnEiD?=
 =?us-ascii?Q?V6B8TwmOKihwf1ay9xgyfh75O2y0F2C9/yUj9JVZOENAiOkMxMJLbLW/WjJA?=
 =?us-ascii?Q?OTe8QIgTsXsSG//xr33uyv4j1tQbVux0nvYPPjv8u7NI11Y0QNTPQmL6ZRGZ?=
 =?us-ascii?Q?4WTswlhAFla4Ww9YMOMKmwNuMJh5DANw96XtXqiVJeyz1eajSzj6RsALQZ19?=
 =?us-ascii?Q?V6Zhqtp56Wpp1RfcfBxb8PR1k3qeTbeiViVkMUG6ll7wqSst2LAcYoqXZcbw?=
 =?us-ascii?Q?Y5M2/jOPzgZpZYZEZXecX2312zgmz8BZAWnaf+6PMArkNM5vD2fJngdf400H?=
 =?us-ascii?Q?0xRx7kJvki7zIOEQFFryIHe08DsJV0y91kSXU3jCCeUL7DeNjQyvTUSe/5rl?=
 =?us-ascii?Q?Vu63cHz2w1DK7sNz6flok08BBkYpUrLkkEnXO2kVs4987da9LbQHJ4rPs/La?=
 =?us-ascii?Q?hINiuvl7dHAtn40l75XR6hefek9JIQeoojg/8CRUiiubOEB6nGyHidy+lkAZ?=
 =?us-ascii?Q?Yl32s4Yyjq1THYxYepwvADTub+v9keAJ40aYaE+SPeTYltDnG1hcfRonhAWP?=
 =?us-ascii?Q?e5gXaS50rHtotJelH+fotDXv7Uhm4y0UxPep4MQYJR+Vmek15+TaG7nd7dhk?=
 =?us-ascii?Q?sHDJqmOe+d/pRHsiH84N4dTG9qJcx4rV2Nie3DVn8As1hlm6n2tagl9BGLlp?=
 =?us-ascii?Q?kU+WEDE6nKFMrRwyPP20RI76mUyf5AMX47gvo3RTOj6LVRWnJbYIw6n9lU2N?=
 =?us-ascii?Q?NuOB5bdCr+x4/ZQwvZJZCeoJ+4SqFJuN34ujXD4EkotJz8NbqfV351PcdG6w?=
 =?us-ascii?Q?5bI0pS2s2qxYU73OEL3YILb7/E5RQJzJ0Wo2q5drhBKNDv1l4/ovkTYAD7Lm?=
 =?us-ascii?Q?isNkWmWiEdDMsa9j3MRQbBDi7n4ppGuNWAd1LiNdFJQRhpD8bYnhPVWW9+Sz?=
 =?us-ascii?Q?acvosVSvzotrVwz+M3TtYRORp+2Aya8ajAKKRJi+nd7J1QZrGz2OR0QPslwN?=
 =?us-ascii?Q?VqEa2huLN1hZcC7b8pWhEawdRdlCChBi/Lvp4jq5TOgEkdmY7nROAmzu2uL/?=
 =?us-ascii?Q?CExc8ZwNlc2rbhAM3wLsYL0M/1GTZW/qiioLysWW3CFhkBtOmZ5sV3MdJTPR?=
 =?us-ascii?Q?2An0M5zR2bXkpVdwg+bj+og3pzYYMwjnzYHmptyyZAvWjFiYJu416n/cn5pq?=
 =?us-ascii?Q?vlt+XzSDsCcLXTL8ag0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4c0775-f291-4ff1-1276-08dda77a698f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 17:23:55.5102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khZrAn+TgYmcFaZxutWfUfCrWV4I3kBiRGVYN5AB4w4Vd4MRwIzOeICtuNjblW7zvrflYNVpXsS075y9Iu+Yuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
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

Maybe  it's better to use the  MES FW version . Here is what I got from the=
  MES release.
For nv3x : 0x50
For nv4x : 0x4b

Regards
Shaoyun.liu

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Monday, June 9, 2025 11:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Shaoyun <Shaoyun.L=
iu@amd.com>
Subject: [PATCH] drm/amdgpu/mes: add compatibility checks for set_hw_resour=
ce_1

Seems some older MES firmware versions do not properly support this packet.=
  Add back some the compatibility checks.

Fixes: f81cd793119e ("drm/amd/amdgpu: Fix MES init sequence")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4295
Cc: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 11 +++++++----  drivers/gpu/drm/a=
md/amdgpu/mes_v12_0.c |  3 ++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index c9eba537de094..8a3e3aa86c5d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1630,10 +1630,13 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
        if (r)
                goto failure;

-       r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
-       if (r) {
-               DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=3D%d\n", =
r);
-               goto failure;
+       if (amdgpu_sriov_is_mes_info_enable(adev) ||
+           adev->gfx.enable_cleaner_shader) {
+               r =3D mes_v11_0_set_hw_resources_1(&adev->mes);
+               if (r) {
+                       DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=
=3D%d\n", r);
+                       goto failure;
+               }
        }

        r =3D mes_v11_0_query_sched_status(&adev->mes);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 68bef36aae3b8..c1311de397f30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1736,7 +1736,8 @@ static int mes_v12_0_hw_init(struct amdgpu_ip_block *=
ip_block)
        if (r)
                goto failure;

-       mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
+       if (adev->enable_uni_mes)
+               mes_v12_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_P=
IPE);

        mes_v12_0_init_aggregated_doorbell(&adev->mes);

--
2.49.0

