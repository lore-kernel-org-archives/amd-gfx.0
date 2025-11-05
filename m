Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D947DCCF9E3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4014110E6A5;
	Wed,  5 Nov 2025 02:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cE03njuH";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B914E10E6A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q++fRrRNsuecvhD9w9PSBgWJZNz/ySaMYL1EGWyrP7ErAFSkZyE2/Mp4LhDObRNBZMDLkkCgnuSgIBbyBkskIRfi3E3Y6tYQChJWr+G2Cz1m30fTImqn1FUYDanMsT9a0mp5LGnD/Ru6BXuOOrvo0qGBGFwcRVjJYESnR91txa8+iUBvjpJYpGQckJSbW0+yP2mX9vMieJmGo1N93lm4k/72R4H/RPydaZIqlGBSx8ixaKPChTEpax1t0LaFV4Y5rjqr6POoRpI/xSN4sATrSZgld0FHYLCmKHeCKN3qtCNlsLTT3DU0meQNDLNDz901w/YnG99JfUVq/jJCe+M7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjNQ8LAmqvKpR4RIX1IUm1ycXtGzQp/tMM3lNE7PU/8=;
 b=c1hSdOLKqL1DZ3QbcJilTSlXn1OejibpUvxnaNM9wGZgrKWRCDSU/zkJqBoIL0+eDJFlGt/DFuZrh91Vb0KUW24J+7KWCcMJqwFw15sLycgp61/T2qUwgnnzBIPYmUgicO6c+av8+xfDjTfuiN3P8Eymmmv+J5boLutq0RhYVcTz2K701uT9gzMoYixxDK8JC9hQLnYSLxXkr1C0Q3QhV067+KdJFRWbsWWEquCPLcj2R/IPaxruPG8XHltLrNcNaWCmHZnd/hGFkr1VdnK7Kx+L7yAJVBO1w37cafYAcDXgthBWSsLCq00z890T47GeWFlHky+ezcuwXdh4+iPEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjNQ8LAmqvKpR4RIX1IUm1ycXtGzQp/tMM3lNE7PU/8=;
 b=cE03njuH8K+J2EEh1ROuiyRHcHgjjdlfkk/O4UPSvlBBZ8cb/i4GusHf8mW1PsdJ8WuLiHkPsekxzFWdbiE8hlbX9q6VUL99gFO8LNSwsxeW90u/Z2Xi1BoXTd+6Ix0mF2o2RbVpkqyPRwa0GnInXmKHNBFaJ+068IUCfmwGYWo=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by IA4PR12MB9786.namprd12.prod.outlook.com (2603:10b6:208:5d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 02:45:56 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%7]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 02:45:55 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>
Subject: RE: [PATCH] drm/amd/include : Update MES v12 comments on RESET API
Thread-Topic: [PATCH] drm/amd/include : Update MES v12 comments on RESET API
Thread-Index: AQHcTai8jGBsuab0IUC++U4oqRkzlbTjYTyA
Date: Wed, 5 Nov 2025 02:45:55 +0000
Message-ID: <CH0PR12MB5372C5FF155E206C175E37E1F4C5A@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20251104163300.545619-1-shaoyun.liu@amd.com>
In-Reply-To: <20251104163300.545619-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-05T02:45:41.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|IA4PR12MB9786:EE_
x-ms-office365-filtering-correlation-id: 41655e75-6973-4841-fb29-08de1c157178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aX2qdJrFrT8TJru5WGB+t48Uki93r7dN9sFmAiiKnf8A8X8BZsENg3uSqbYu?=
 =?us-ascii?Q?Vlpcz6+db/YHCHfdp1vD28RN3Dl+cssrXuIoS7ZlW50LZ9X/NZ/gVfYNb/pG?=
 =?us-ascii?Q?kuOFbpd7CgJT+JBAwyV2ZI3bgSduVs3NzT1wsQckCtUzrzPo1SbrjIrckZVL?=
 =?us-ascii?Q?7CZQhumbEN3K5vbGhA7vyb9h4X6LYL9ZFG3m8mjYXON2fU/b48HZgCcIJ6Ur?=
 =?us-ascii?Q?n8NjU8UXv0LUv+mAPXB6itvDOm6yEDKVHLnt7X9bYgh0DmhVB3sJ6JuZuZuN?=
 =?us-ascii?Q?n3FGEOJYxLcewUmL3YIVrLWPnZMKBAH+f+XkJkDZWqQ1AsBNbpXAbCHyVOFY?=
 =?us-ascii?Q?nWwVlDffdwuOrhyxDQjp6ciNvOYFJu8W187oLyK6tjBeaAc9uFR93+Nikn5/?=
 =?us-ascii?Q?Eb0AGBLXbZ7XEHfGIcK6d/AgPxGT5LjLDHTFZvM5sp51i4hGBvO2QyGjUp/J?=
 =?us-ascii?Q?M4TxDFOcKVRa49RNBJ4QxUxUOxLTzeUc/10sKGo+NYnSlSmTK91yA612RwtM?=
 =?us-ascii?Q?cod5p2/z48lUxS//DWRnYskJ/SPyO9VnAvPX7zN5OVNlhzZGJg2j4gxr60di?=
 =?us-ascii?Q?9oTbDACE/c0E5a3UENWxfuMN91n+sxxWUBP9ua23dhsed8CiB6f/8s6lJ86M?=
 =?us-ascii?Q?jX7NQ2sDTp/tiiOZC1iDkqiYFn45qZ76sHjTtUNMHTpnvQzFfy9L0Os2IQ7X?=
 =?us-ascii?Q?1nNWE7FOQb61R2xl27CnA6u75PJm10N54AQ5mchOssrqJBixu8BnfP9MYBnM?=
 =?us-ascii?Q?FYi7iZwDLpm49spjwS/V3wbmAqTVAdBgNfIzr7CovWjC8XKYryc1s6VEoMRw?=
 =?us-ascii?Q?HBpM2T2wZHj9VgUzEV1j+EUPmWfPbQXZUtprgIb26ak9LO/cS6MLzen9qTNb?=
 =?us-ascii?Q?yL4SJb7/LR4rR5nPBCMaMKWbzJoqXhfXH4xYdD7l0zyMhRrJGr0D4l3p9wjt?=
 =?us-ascii?Q?t1Yb7pjXIvkkh8SFTjwdfd/0m+pIc+LCX8wXolTOkoFANnKod7saBOjWrHqf?=
 =?us-ascii?Q?TkEtlbPYZfIGdN+kaTOlL5ZIx99eNlxH2dQZ2FwvVxpdZ8PBnle488+d1AzR?=
 =?us-ascii?Q?BM3RAHJJb+hNpyTRm6zfI+8VtBMBuK/r8b+t00/CnkpMA8XKXotRrhGuoRdv?=
 =?us-ascii?Q?lM3RgTYFn3PJQNuasYFZvsgW1xvo8oSZTbVfpWNwy67ClK5R1THDhZ+NJhKV?=
 =?us-ascii?Q?U5uYpd6jun/jKFKGchYSc+dsUgZw+d2aJqSWl8P8E5tE2wXgQxbeb+lw62LX?=
 =?us-ascii?Q?UpZR0cXvuYditQUzcG38kg0uyAdNbK0iLC4b6lC8J5b4TYAjutIf6raPgtjb?=
 =?us-ascii?Q?1H6MlgF0B2t5o8Ev8byIGUP2QEPCn3xQX3IefP9ppPZdJ022t/DO2qbvebnl?=
 =?us-ascii?Q?Vwh74edpjIryV0R3g2Q0vBi1Qi6dl9TQOe/2JT44q24pD8pNQ2NvCUAwQedw?=
 =?us-ascii?Q?O0euP3Syz41cj1U0Cx+Hycqj0Q9NV/oSRPHt6Z9RaWJ1LI0iipWpZNwnfoUr?=
 =?us-ascii?Q?9LLjn9REqHKT3HTQwBrzjVLVr9Kd+XqlmZAs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XOKw/Hpd+ifAaDXrtbtFZyjH15PFbIwypxbVZ9VqpPDQAJDpGVlAi13jmLGX?=
 =?us-ascii?Q?P7DvX15iJSnvJrdYCexGwgbkooCS/ejSa6qjFJ9QU00CSVKDZntKle0cNQhH?=
 =?us-ascii?Q?4q1hHm2XVUGYtlHxZrMTbNZza5xPxTlzjSeXjsvD8Dnd5MPFGghP1jzc7SKy?=
 =?us-ascii?Q?AvxRZRiO7UmxlPD8Oa4u+OsvkpuA34vL0glZKly64eJ6hFxKSUKLC7s168xe?=
 =?us-ascii?Q?v6X8yvEVHJU5nq2rA+Wf7hiEyMNteNSpAGGqtrYhN/rC/8NPdsRZLfgQpnlv?=
 =?us-ascii?Q?3Ax84WHllJnPMDzHSxhrpzJduMM8VIr/zDG2uxIiCHriumR4Jo8mopYQAGXj?=
 =?us-ascii?Q?Iiv5+CVAerKvt0zFZhGulhK+bqRjDf6WnIfPQ4kbtHnaqlFTLmoKAHWkqLtD?=
 =?us-ascii?Q?b8I62l6PtpMuFeDqflP1VOkDUFcyWAwdUCyWOghTnFrycz7nNBGx+AP3CBMk?=
 =?us-ascii?Q?4MyOtLISJQy/x9VXsD8UbTc2b68BDyzVA7UPzxPPzla0qCUkPbKevxk+N41m?=
 =?us-ascii?Q?x+YlULCynKwQSy5ToSDp1ueYbDJTuMF0LW6nXTIrFHFt3Pg0gZxWIFtekGPk?=
 =?us-ascii?Q?FidJIKbUCiqJwVDzVDzJqgbVqFDAnnA3I9/OyPD3wpdO1D/bmsBk5oxvyN28?=
 =?us-ascii?Q?r/3rM4t7CQFXjEAbMa856Wp4q2RlD9H0nhzJnq8hSBiS1nJ2AwbXAtTD0dt+?=
 =?us-ascii?Q?U/nHWH+M5lnM0aFTlZF3FHS6UQ5H2XKB3NlZ5IgmnynR3XvjUDvTke9ZQ4ei?=
 =?us-ascii?Q?ahfyCjcnks5tq0RgCUU/CN4/3j+uv8R8MrAp3YSJqGs9yij2AfM4VTUgKIlr?=
 =?us-ascii?Q?q3D2c1Ie1OKJY5J43hkq3w9wC+9cVRTZEzyudMLnOLFS5Zj9Q+gieMJsnuu7?=
 =?us-ascii?Q?xz7QjiIZC/qmlT7HJ29eo0XfKeJypk8LzflMeyQvwUS1G0mDnUqvQKEXY9xu?=
 =?us-ascii?Q?7frU9JSFp6TS/cvcCli3q9Njx9TwW3nALqwE6sX8apaRWoDOtyyhnWYlXn/t?=
 =?us-ascii?Q?IF76EwiYoWGxDhtWTJ5sCnhNsyHcMFHTl+Jgkphx3IcuTlq0IWF25PGRJmR0?=
 =?us-ascii?Q?HcnPiT7T+t5JtyBPOIe1QEDwSv8ZegwHs+6I/JydZJEpGTIXgVQcM36DQYIk?=
 =?us-ascii?Q?0LAxi/g3hMXsC47M/T2b5sQCnXNdv7CTRrC/fBhfRbzq68vs6mbxve3VBI2V?=
 =?us-ascii?Q?/5QZPiyozYlp2bqu5UuhoALmgOIRU+y3DlXUW3Xr2HEIILQg0ebaZ39auA8B?=
 =?us-ascii?Q?vWYurv8wLcM5PP56j9VQKUUlR8IVRebn6eNTeutMWIuvp43RiyhI3EJBriTa?=
 =?us-ascii?Q?tbmY0CV18Hz+cXJvKmKaT5JGcHtE8BnkI1M2qDf3WqojwOjcn3bLL8LNd2H2?=
 =?us-ascii?Q?ytRa90BacQHRSdQqSHVeC8+q2NoOrEidkpxYsjkRIH9VGVTeSgr2yzqA6hTo?=
 =?us-ascii?Q?pdvZrYdKPgMJL6IAzpCD73KgMctH7MC8JApX8vMqH4Xxh7SM7zz10MasWHEM?=
 =?us-ascii?Q?ntF3tfL23E9H60gHQH7rEHQCaI7miJmtCbOINyaSs8FkDN/q7OuL1Aye0kRG?=
 =?us-ascii?Q?8yHl4SLm9Ot/JEU29fA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41655e75-6973-4841-fb29-08de1c157178
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 02:45:55.6539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADMwMxtsFr2UE7NM6QpXxjNnTtt8skF1Y82t6t6u4HQY4SHzCQ9/bq9MvINlRvjpAwzOTRcARsd1rcXw0NVKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9786
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

Ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Tuesday, November 4, 2025 11:33 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amd/include : Update MES v12 comments on RESET API

Added comments for the layout of contents that addressed by doorbell_offset=
_addr in RESET API

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/dr=
m/amd/include/mes_v12_api_def.h
index 2f12cba4eb66..39aee6b4aaa5 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -553,7 +553,26 @@ union MESAPI__RESET {
                /* valid only if reset_queue_only =3D true */
                uint32_t                        doorbell_offset;

-               /* valid only if hang_detect_then_reset =3D true */
+               /*
+                * valid only if hang_detect_then_reset or hang_detect_only=
 =3D true
+                * doorbell_offset_addr will store the structure as follows
+                * struct
+                * {
+                *      uint32_t db_offset[list_size];
+                *      uint32_t hqd_id[list_size];
+                * }
+                * The hqd_id has following defines :
+                * struct
+                * {
+                *      uint32 queue_type : 3;  Type of the queue
+                *      uint32 pipe_index : 4;  pipe Index
+                *      uint32 hqd_index  : 8;  This is queue_index within =
the pipe
+                *      uint32 reserved   : 17;
+                * };
+                * The list_size is the total queue numbers that been manag=
ed by mes.
+                * It can be calculated from all hqd_masks(including gfX, c=
ompute and sdma)
+                * on set_hw_resource API
+                */
                uint64_t                        doorbell_offset_addr;
                enum MES_QUEUE_TYPE             queue_type;

--
2.34.1

