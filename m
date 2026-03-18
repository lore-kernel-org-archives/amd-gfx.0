Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C744FCD0D2
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 08:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAA010E0BD;
	Wed, 18 Mar 2026 08:25:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VnR7PQ9C";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E61410E0BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 08:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5z5nm3LkIQkDQDkSoDzQld060QLtGMhyTU/52PyA4Xsq1U03cBuYnxd4dBpzOXesQvdIYg4+Ppvuw8vdgFdBZuBZx1vPpaq+tVUHl10uoAX4nN701XNTjFMB8Hk+NLWmDwafzD3+GO/PbbjIP3riiSB5dAu8QdgpXVEOHQhL2BezzAUCCOXBYAp8yNyzbPqq/9sS1CtY3Z5QEOjnkzlsCxNNsE+CJBFrc/e+BYHBjB/BVk7G981Za1yRD5aKYxTbCoScX60cRtNKI8eomSX9X0Jb9uba6a6mr2nB8pTEMzZ4vfXdjTt3ZsWlbX/P4BS3zj3xJAIf9Laqe+EORKbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd1dZMVJeIncyA2lA1yPPsbiv7UB0h64UkTO04lgQJ4=;
 b=lE0o6SQxlVACwkLbFxJkl+4kqTjr3dus1dfgAEi1fSxvL1ikQ3UcbKJKXmiMfn+P86YpdvPKAFCqp9geQh0cPvhJ3ENENoM92hJ75oHe9TOPX5hi2gsW7ge+GfMq4KZVbLjK0VCT6mkLElfwxEVpnZvuFqjURZ7g1IZ6H4I8UaYpVPYt6lDoGGfrkQi/JW6V/8PkHDtIWlme2H8XUt8aCNnJpO4BDhVcu3m9TCs/fYa1pNkRoqU7nV+OIh5NSh37Er6PK7R/CeU3mwI7AFCP7/SKsvrvErBeaoThXJx4eG8Dscu+9pOK0KU6egg6oSc4MkFq9s9O5VA0H12F0Qc4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd1dZMVJeIncyA2lA1yPPsbiv7UB0h64UkTO04lgQJ4=;
 b=VnR7PQ9Cti0JPNtcebJOmm3j3nWugypP1MHNseV244juJSBMFBNK7CKgtgDgDewt/QZQ6SUY5NzFDYDQAoI1TUIw/lxriK0NKiUuvS1I81R1QiuhtzHAT8oqg0+r7RRmee1HVhLaA49mOrGRJMCpHwdSIokMw3LkKIbwR7ZrtTA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 08:25:38 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 08:25:38 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use stack variable to fetch nps info
Thread-Topic: [PATCH] drm/amdgpu: Use stack variable to fetch nps info
Thread-Index: AQHcsR0ZJw+Mm8LsnkGAq2L9L+aDv7Wz/z1w
Date: Wed, 18 Mar 2026 08:25:37 +0000
Message-ID: <BN9PR12MB52574DA97A85441F855AFAFAFC4EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260311060517.4010519-1-lijo.lazar@amd.com>
In-Reply-To: <20260311060517.4010519-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-18T08:25:09.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB6970:EE_
x-ms-office365-filtering-correlation-id: e52e83d6-c255-4561-daca-08de84c7ef3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003|7053199007;
x-microsoft-antispam-message-info: JXpvpQumu3acYp3kZNPDSF92fBl+j7clPmeCm+GiEiSFuLKm1E7StdkkC+4Q1mZN7LHnn0KmaOkz3c8WcI2EHgJMVWXC+sX1uTssh4tNIhWiEX0JZZyUxatGfheLjBFnLNYLbJF/0pQLc+ueuQ93GmhrX0JE9mDM63Rqjc5u7dLBvmXupa2NG5ZucTjiZh078/2sExkE4XOOfrmVztck1dGqfzJBhD6OeX6qemr09bL0dhzrON4T9lZfoeq2rS7n2ku1TPgIgMj++PZLB+kpX48JFsSQg2tWrnm5rB+Pj8R2Js81klhU09q0iyNUlXfDRguT7JMZbKnMXEVKzIezNbDsv6ZsyNs7VWwGXiruArz7XGEipu48VfgJFpoIY0av3wbZA7WIT0UwejBnfOVZX9AUQOtDgOzRws9TMjYVQirfZzBEB7Vl1BLcfa1A6q1KL84J4VasTMIQXEESArVEYhiYKZIa9CR8890tIqAKfFBocDJKwWXO4uSJR3qECSyC7k7Zuvg67vjW1I46uYhec/z7DW3XkyhDAn9JDOi0dGGpe4psRZGZ0ysJ52440TlFgKU7KRH/xYPSyngZlAqMwolJgQDMQjRlRI3y/20bOfeoFgnkNFW3CyJzZydLD2WVvqWEq7pGK3EmWqIui9th6ILoLupSHH83TWpuUTTVDN2Hq7sMsCRVKo+ODfx492GRTGXN/1mMerKsfqL9n1LbXqvztoESflULwvsM9L4AjIrxeiRiWzesh8tgIMgFqr0ErILOx+vR+ld6pkpl6w8cDXsZpxM/KYmRpGWMOGQd5mM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FRkUmhdhd9+uYY2j69ma8z/kuhiDOzzp5aB3B1vFnx7L0T29gHHRsAs0jEAi?=
 =?us-ascii?Q?HqlQz6YVB8abbiiFENesR9R0Me7/mQ4HQLGXjhpyAFirIfXLEE2pQS3sXIFb?=
 =?us-ascii?Q?rI+dGShyWqVBEVjaH7KORocQYMir7b62nnmGKWROxxWesJUeNrNzK/7uX6Hr?=
 =?us-ascii?Q?mZCkwEQmfvO78SEKDT7Cna1XLqurDcLFYtG5YE+YccHbb0H7cATe2tpErW/V?=
 =?us-ascii?Q?6MWX2VuX4bnuhpEyaIYOhsAMaEqzDPdX2gB0/4qGFjQknxSrjr9jsFigoVpV?=
 =?us-ascii?Q?Zvt6RGZBj28bRHvfspYHyQpXTPHVxQJJzqhit4ucnH7ZrxQ2dW5Rs1qN/k+1?=
 =?us-ascii?Q?caE2MrKIPqcDsvar9o10vUtX/8w3k3uXS10pwbIqxF7ARSR/o7pE/tDpe0VF?=
 =?us-ascii?Q?a2ejc7Bx3+xTPq901fOwc+GjvWTmHm0ass3I75vN7Q/uJa3hYxzvjKic9Sgj?=
 =?us-ascii?Q?pWrAB3ekSm8l87ot21o6lOMasUkJ0bjj+xLYKVFULpO7vz6EDEy2Gq0CJIUd?=
 =?us-ascii?Q?gBJ9Cmog5OdVbTpcCHsOo1hGnmr7FXZkPr2wOS+Quk3U3diYw7zG6SmxbhRP?=
 =?us-ascii?Q?c8LyU7qX9Fu3TKPbyQKYYNFgL7L6HRlsXwhlXwfn+IbX0ocpiX7qSqhiHCcT?=
 =?us-ascii?Q?eg8P/cr4zQmrca52qAt8DRb4uf2F2Oiorge2z687NQ/Mz2Q5WJEWkbwMhmPH?=
 =?us-ascii?Q?ESbdURr4vytQs2rj1yAHnzy8V5N+F4FqP1Jusx4VMK+GGyY/67E9WqK2CY78?=
 =?us-ascii?Q?t8CvDSHGVlPfe/Vju8cTrzB1/Vd4HnuCpOY92pimA+Hujny/W7L5SggzfjgY?=
 =?us-ascii?Q?dTvJ4MQ+Snbvhhjfh7jxl0yusZkYpqz/IXOxmHXcxAEejwyzJ5JA9ZGeqFgi?=
 =?us-ascii?Q?aFW4RFe3KETgtkBZu19WYul7C1G5NO4NVMxLCElB6ncvh+D4AO2JHmWrFMF9?=
 =?us-ascii?Q?poMe34TA0d6Lbnstk60I5KAV5EgpZOLfgA3MGRbGQV9psa8OKp3dX7meI7X/?=
 =?us-ascii?Q?F4hRxVUQ6TOhpQGrc8kei7U8AJWE3HfhAROQoNptqqdaDS6zpLh+DE9i9UiP?=
 =?us-ascii?Q?8tH9xdozuYp/12FAG+jfzWnlPwFn3PxSh4+8I2Nyp9IbEeEOqe8eR1s+fIwM?=
 =?us-ascii?Q?WXmQX9BgG0aO6FgDa/8SzYXkEK5a5oP9mUgQ//Yz1vbyR+kEeg3aZsAXF5TU?=
 =?us-ascii?Q?B/Wkt7qVcigXVST4u25BtgT2AOD+a7VveSrmGODQnHAfcyF/c4NF2QYf620w?=
 =?us-ascii?Q?sdSsJIwxB8D/IdyOKVlwXcXrBH8rfj3uFFonKFT6RQmlkLfKerPe9tgxD7go?=
 =?us-ascii?Q?wRr1fx0cOXO5GrsrmQr92OstXiEz+0XdSooofFydJWCK8sI/0AJ7454tWTma?=
 =?us-ascii?Q?RpwUfiwmMHxKtCjFn92LE7f7I/4Bc1ddl9RCvWJ0NjihsdJXW14e60birFes?=
 =?us-ascii?Q?Dfbo5Bz3Nm4RdpaAZiCBsBL/PIDzdQHHId2d1St72jwQDVTOuPHSM3WIjLEz?=
 =?us-ascii?Q?+dJznzrvrFItr6dku9V8a7Fo4gHOnc4y0ZDTa94WxP20vRytWuXc17yNoTh1?=
 =?us-ascii?Q?HQBcTzl/5OqZcSn15cTS2Gdynz3R+5m7RvRvaBZ+jy8PIEKC9B56LvyDuXfQ?=
 =?us-ascii?Q?vgUv2J/0ZrEhzPyAC+Y/3vr8b3O2k9fNTSp+1VCxWCLQdlvoN9V5ZgGQBvxA?=
 =?us-ascii?Q?NoCyql5tF/Lp3xEmZprMR4hRQISiCX+rvcqB6jotba22d1GD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52e83d6-c255-4561-daca-08de84c7ef3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 08:25:37.9965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0a4mF5K32o5BhmBFtTNWb/JYZm1zKbDiDCB30va2OanNjLRcqTXBej+44jpw1sAGTXdPxiOH6jGlAq714NAcIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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
Sent: Wednesday, March 11, 2026 2:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Use stack variable to fetch nps info

Instead of a dynamic allocation, use stack variable and let the caller pass=
 the maximum ranges that can be held in the buffer.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 23 +++++++++----------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 10 ++++----
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index fad53d8344b1..948c5f40f366 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1932,11 +1932,10 @@ static int amdgpu_discovery_refresh_nps_info(struct=
 amdgpu_device *adev,

 int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
                                  uint32_t *nps_type,
-                                 struct amdgpu_gmc_memrange **ranges,
+                                 struct amdgpu_gmc_memrange *ranges,
                                  int *range_cnt, bool refresh)
 {
        uint8_t *discovery_bin =3D adev->discovery.bin;
-       struct amdgpu_gmc_memrange *mem_ranges;
        struct binary_header *bhdr;
        union nps_info *nps_info;
        union nps_info nps_data;
@@ -1973,22 +1972,22 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_dev=
ice *adev,

        switch (le16_to_cpu(nps_info->v1.header.version_major)) {
        case 1:
-               mem_ranges =3D kvcalloc(nps_info->v1.count,
-                                     sizeof(*mem_ranges),
-                                     GFP_KERNEL);
-               if (!mem_ranges)
-                       return -ENOMEM;
                *nps_type =3D nps_info->v1.nps_type;
+               if (*range_cnt < nps_info->v1.count) {
+                       dev_dbg(adev->dev,
+                               "not enough space for nps ranges: %d < %d\n=
",
+                               *range_cnt, nps_info->v1.count);
+                       return -ENOSPC;
+               }
                *range_cnt =3D nps_info->v1.count;
                for (i =3D 0; i < *range_cnt; i++) {
-                       mem_ranges[i].base_address =3D
+                       ranges[i].base_address =3D
                                nps_info->v1.instance_info[i].base_address;
-                       mem_ranges[i].limit_address =3D
+                       ranges[i].limit_address =3D
                                nps_info->v1.instance_info[i].limit_address=
;
-                       mem_ranges[i].nid_mask =3D -1;
-                       mem_ranges[i].flags =3D 0;
+                       ranges[i].nid_mask =3D -1;
+                       ranges[i].flags =3D 0;
                }
-               *ranges =3D mem_ranges;
                break;
        default:
                dev_err(adev->dev, "Unhandled NPS info table %d.%d\n", diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_discovery.h
index c8242992c912..1220c0327275 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -45,7 +45,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *=
adev);

 int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
                                  uint32_t *nps_type,
-                                 struct amdgpu_gmc_memrange **ranges,
+                                 struct amdgpu_gmc_memrange *ranges,
                                  int *range_cnt, bool refresh);

 void amdgpu_discovery_dump(struct amdgpu_device *adev, struct drm_printer =
*p); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gmc.c
index 20e1395b3988..f165d4e401e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1374,18 +1374,18 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_devi=
ce *adev,
                                 struct amdgpu_mem_partition_info *mem_rang=
es,
                                 uint8_t *exp_ranges)
 {
-       struct amdgpu_gmc_memrange *ranges;
+       struct amdgpu_gmc_memrange ranges[AMDGPU_MAX_MEM_RANGES];
        int range_cnt, ret, i, j;
        uint32_t nps_type;
        bool refresh;

        if (!mem_ranges || !exp_ranges)
                return -EINVAL;
-
+       range_cnt =3D AMDGPU_MAX_MEM_RANGES;
        refresh =3D (adev->init_lvl->level !=3D AMDGPU_INIT_LEVEL_MINIMAL_X=
GMI) &&
                  (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
-       ret =3D amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
-                                           &range_cnt, refresh);
+       ret =3D amdgpu_discovery_get_nps_info(adev, &nps_type, ranges, &ran=
ge_cnt,
+                                           refresh);

        if (ret)
                return ret;
@@ -1446,8 +1446,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device=
 *adev,
        if (!*exp_ranges)
                *exp_ranges =3D range_cnt;
 err:
-       kvfree(ranges);
-
        return ret;
 }

--
2.49.0

