Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6820FC55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 20:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5C910E06A;
	Mon,  3 Aug 2026 20:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IdgGGFDd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C0E10E06A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 20:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACYLEn1js02JSqsuI0KLZsHuG247WU0rkcorqS7Fi+i58KOj9GjSjsASxQY/HCMTSzXp7CgKUQbICvRMnqkvDA9t/fOs6YnMKwBuuIDOIzx8UVWmRnmost66Xk0A3GnyE8cp+hLq9v/U5PkOVgEp/Lb1ave68bml4eHEahER2GRR8c3cBNWTD30s6x3CcXtyP3A7ARAI8ALQsNZP1AP/4QrVb5uH0vZyDotdxmp6jqutfMQosXdBv9D69NtWMwesLdfzRELHx0wGAP8YTQdBVJSD7Ca09RcuqGytdOEFg6OeE3fdoQX/FAAYzKnDyibRBqdrRe3fc8vg7bVJWhvimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVcQffT1cg6lk5Vmesf/hwyve8eUP1ssJDpQ0umvAoM=;
 b=MCfwkOE2igb59c+EJOcQmMmZaFW4Z93CnsUooEUMwR9QoNNsHdB1T/S1digh7TMyEfgqULTZcKTeGi3z5Y1Hjq4C81iuguiTXnI4rTvosT/rdH7HVPwgcGbEzrB42KufqFF1BjLp+3pCgVE1vSt+dX1c/AQ6w0Kh9BBwvCu+cDMRMkGewuJIwP5o7BU2nOYINcTihSZDeNk027HdOdX2sbv10vZzIwA4xJrcfKddX9yo24L8H4MEmjgcxlhLEp6KoaMSSGVUj+zSg4qHUy8jvVgTeiaAkfwHY8EIvFUSNO8yxIOt5RBeqExiqQVlXD6evb9hXtp00rBIaRNJS8S2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVcQffT1cg6lk5Vmesf/hwyve8eUP1ssJDpQ0umvAoM=;
 b=IdgGGFDdiGAf03cW5fblVZE/GMkDmfkhjKKgRVD3LO7+2ptayyQ+c1Zwuga5FWPFQ4lbZuiMEHPrXZsjmdB6uhhsysk5NpCNxzVK90t2M0+DKoJQxpdcAwZUHJu0UgbycLLBPUsdm54+SRyZwGBiA6yI5Jm+pAkStupCBXQJnPs=
Received: from DM6PR12MB3611.namprd12.prod.outlook.com (2603:10b6:5:3c::17) by
 SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 20:19:31 +0000
Received: from DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b]) by DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 20:19:31 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu/mes: refactor the
 amdgpu_mes_alloc/free_proc|gang()
Thread-Topic: [PATCH v2 1/2] drm/amdgpu/mes: refactor the
 amdgpu_mes_alloc/free_proc|gang()
Thread-Index: AQHdH8hz8uDzaGafd0KOxFrK5DdUmraMyA2a
Date: Mon, 3 Aug 2026 20:19:31 +0000
Message-ID: <DM6PR12MB3611478BA8E7766040313BBB94D52@DM6PR12MB3611.namprd12.prod.outlook.com>
References: <20260730020911.234193-1-Prike.Liang@amd.com>
In-Reply-To: <20260730020911.234193-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-03T20:19:28.184Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3611:EE_|SN7PR12MB7273:EE_
x-ms-office365-filtering-correlation-id: e19c31ff-7098-4d2d-06b8-08def19c86e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|11063799006|8096899003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: 1hZTXZrU/69lwp8FlInol42b6jFHOJUDxw+Fn87OR2obzgWExjhFA03wYSypzfeC7+Dw4WQNzOPy9OC66xmd8V323dMq7cRVGr9zTHUYel1W1O8LOR8eDtNNTBn0ksQnK2xBbAZBDMcXEorZ5U0JVUM78cxJsyjBUtNa3dTvMEixZpVpKwP9eLEzOkJLZw7iCQabQlCzkWX85alCAMouZGvqkuWe8LXIDX2ILtTaTVoHAWKfcUijAb9zM+m+ql6O2hxhQF/g61KrsHw/isVyaPXTuzq74jBmy5DCJ8TPjWU+p43EnNiQLBvhiDvD2ji3mOXytDaDviejxoR6YJcxpcboz+4EPe6mjtDa9bbiIv+mUBMylOEMHcmQPAUXXXqHBJAlCGO5WThuUtRiQHwNLI2oaLGD+ldMdOLjLwgSls1yfD36tTzCuHExyhLzog2U029R4j7R1S7vvGJSvaseuKlyBbkw5burxgMCvOjjD1XrmAFOz7wBs0pZJc5KdQo2IovFwMpFrRSjo8hrN0OG71h3KMHgHtTXB5lyoDkj7maDCIcixX1n5tWexUcWI10r2NHjFbpdJ8rEXHmJiJaMQ/asjKDPdOS7uLLaEOKKjfK4Kq2RSi8H/t8jishuFICB6oWwxKO3RzNwPcTuO4PmtDSOHD/xwWXicXf2GnXBuzbItU2QmAphQ8lOsCNBO2WUHFV8858QGxZpqHmiOL5bYt57RJCN9kKK9Qs/Tr1lkVg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(8096899003)(38070700021)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0LQS/0Plbr+8GtQen3MuXrylWWYbQEq/vm8Qo5xQHkZBLK593pcBA/RSxG?=
 =?iso-8859-1?Q?Iu6ewpzbjVwEH1HWfVE9sZQd1c7b2Me2LnVgsd+90v23LhMXgIpzWOZscv?=
 =?iso-8859-1?Q?MvOkZbPdI1HV5s0UbPpUuoP3yiSJLBI7ZOyYg5+/Q4A2hMgoNwyqZm79W0?=
 =?iso-8859-1?Q?J6z3n2dNNkKeluYDJfY89On719zWVbBdL4aIkZla6h/b6WZIDeUfM4syWA?=
 =?iso-8859-1?Q?kZ6tVyxlYydDQyR1KCQDlUw3YEpSzEkXV1cyW1kDzdup/vEZ8UOcEouzJ1?=
 =?iso-8859-1?Q?xkVRslz6ID2lP8nXFo5gvFgTpVPTJthKWqlxlz8I0CtpVHfFojrWT+LpxP?=
 =?iso-8859-1?Q?w5Rogi0mdZ9Wx4jksNIs8r7loaSkTlHtLtYZAjr2HEPqA35DNvCXZJsGfF?=
 =?iso-8859-1?Q?FHOYYZM46eg8HJ+5L55qbrTW6bg9f1f0Oj9bxco6H3bYF8YkuB2QB0uCdc?=
 =?iso-8859-1?Q?RiNlHjwcwThFUgF7aQ4oswxYTKcwKLgB0wFXxmPWtzJfChZ+QTMayStYL3?=
 =?iso-8859-1?Q?dK3Hatqz3MRFSSULMGGecCC415m8ceZ0G2HpdHdq9BMEtQYfA1GlSDdYSi?=
 =?iso-8859-1?Q?RBhdACYiPbyTh6gHL+V6AEG0RHRO6PPROMqSAAENMIiIO/ldegP7epi0m9?=
 =?iso-8859-1?Q?XTWnHrqejGIdyDpX7jp2fQd7ORUHLG6V9N9vBhUBeoFzZRs9Xf4WrRqkTw?=
 =?iso-8859-1?Q?AEn7/JRjmbrKsEl7SxqU8Vq6gdvifyvDrp5IwZy3thS3pFaIlVeAV7GT38?=
 =?iso-8859-1?Q?FVYkY49T31zVcnU0zVncXLLYgZdw5R4c2/WWnye2uVFKqt/WI9kdzTu50Y?=
 =?iso-8859-1?Q?LyFjiH1scl3lq0jcKpBF0a/pGqmeFrKYvO3TRXdEp9osGfYC+kpeYMczFt?=
 =?iso-8859-1?Q?pkYa+r1KonENF8UrT2GiL8SNmpW9/EEUVlHoqf7Fc+OgA47GaA4IC7Tugm?=
 =?iso-8859-1?Q?x/9Tw3TNtmyHAKK/cN3mbDnKHPGn6LzFkAVA3phs5Lb5Ft6+M7dQFMu/8a?=
 =?iso-8859-1?Q?j5j+52WAyrlu6N97Tr8xSQNsD18CJjHFzjtjMWtDJDcBN7WeMckKk+XUGs?=
 =?iso-8859-1?Q?qI2ecdtXhjqq/6y28MvLd6Zoz18UYZOwhGULpeCqnM4SiOVWUV/+sEcfKb?=
 =?iso-8859-1?Q?NwuHNfBXP2mVe8HZ4AESu/Uzzx2cR/sOOW1YwaYzfVOwUGFQvrlDXbtjOx?=
 =?iso-8859-1?Q?roAHoYNWHA7YLuVATax/FDpwVjvNIGMB+TD5YC7PRXH5K+d71Bvwm2h0X1?=
 =?iso-8859-1?Q?fyh5Sn6Cxn2Y8u00Ay+KegbPdQcicf9jFBrZSDq5Dnp64hpVN/zCHwD/FO?=
 =?iso-8859-1?Q?myYXmHPq0aZkXaA/JSfwNoItinx9RJVrrb8Ctfj4kgg6q+p0L1PkDaZAeK?=
 =?iso-8859-1?Q?31YiZ/KncIlV0tvUuHsGDMqVPz7jjJdTRLpiC22x/ZXtMOibnYKD+AJj1w?=
 =?iso-8859-1?Q?a0a9AMfsKR20lmGsI6N9yVZTGgZlbj+wBm/cQqtkPLxlhjNlEckfeXIZtH?=
 =?iso-8859-1?Q?8YEADqL2QUUwFp/KRRnkXw+9MNpbr6AsmcNmEkDuqBepsbSY66wPcCpi+0?=
 =?iso-8859-1?Q?HxP94bSr9fSkSOC5iQsZhdzsGLGAkfJp7U5QE818jPyWYwIagCvyNyddGj?=
 =?iso-8859-1?Q?hD4C6v/AidizbeJ7vxKXkhVMjm3i72iP2ieTiY6LVvmcci030hHO+tS9oC?=
 =?iso-8859-1?Q?9rQaSx4mDkxcVqaBqwND+bbrbImEjriYfHQupA8kzew+UVlkqCTFWC3VYY?=
 =?iso-8859-1?Q?akOwP8s5vrvJd80J3hBQNlVOP+rg4ye2YRpumsc8Anuy4k?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3611478BA8E7766040313BBB94D52DM6PR12MB3611namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19c31ff-7098-4d2d-06b8-08def19c86e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 20:19:31.2690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLH/U7X+69yIlXrkvgRuCwWiWi2gQz8SW1sNkHDlw9bSZp7eNrrttYsSlRqacgWrWwpWbNqfwDwLV2QLXJGasw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
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

--_000_DM6PR12MB3611478BA8E7766040313BBB94D52DM6PR12MB3611namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General



________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Wednesday, July 29, 2026 10:09 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu, Shaoyun <=
Shaoyun.Liu@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu/mes: refactor the amdgpu_mes_alloc/free_=
proc|gang()

- Unify amdgpu_mes_alloc/free_proc|gang_ctx_index to provide
  centralized RS64mem bitmap management for both KGD and KFD.
- Retrieve the bitmap bit for userq contex index based on a
  per process granularity.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 28 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 20 ++++++++++------
 5 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 9af7c97af5be..e3862095ff99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1040,13 +1040,13 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_=
mes *mes)
  * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot
  *
  * @mes: MES instance
- * @queue: Usermode queue receiving the allocated process context index
+ * @index: the allocated process context index
  *
  * Returns 0 on success, -ENOSPC if all slots are used, or
  * -EOPNOTSUPP if RS64 local memory is unavailable.
  */
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue)
+                                   uint32_t *index)
 {
         unsigned long bit;

@@ -1061,7 +1061,7 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes=
 *mes,
                 return -ENOSPC;
         }
         set_bit(bit, mes->proc_ctx_bitmap);
-       queue->proc_ctx_array_index =3D (uint32_t)bit;
+       *index =3D (uint32_t)bit;
         amdgpu_mes_unlock(mes);

         return 0;
@@ -1071,18 +1071,18 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_m=
es *mes,
   * amdgpu_mes_free_proc_ctx_index - free a process context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue whose process context index is released
+  * @index: process context index is released
   */
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue)
+                                   uint32_t index)
 {
         if (!mes->use_rs64mem || !mes->proc_ctx_bitmap)
                 return;
-       if (queue->proc_ctx_array_index >=3D mes->proc_ctx_array_size)
+       if (index >=3D mes->proc_ctx_array_size)
                 return;

         amdgpu_mes_lock(mes);
-       clear_bit(queue->proc_ctx_array_index, mes->proc_ctx_bitmap);
+       clear_bit(index, mes->proc_ctx_bitmap);
         amdgpu_mes_unlock(mes);
 }

@@ -1090,13 +1090,13 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_m=
es *mes,
   * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue receiving the allocated gang context index
+  * @queue: the allocated gang context index

The parameter is "index", not "queue".

   *
   * Returns 0 on success, -ENOSPC if all slots are used, or
   * -EOPNOTSUPP if RS64 local memory is unavailable.
   */
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue)
+                                   uint32_t *index)
 {
         unsigned long bit;

@@ -1111,7 +1111,7 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes=
 *mes,
                 return -ENOSPC;
         }
         set_bit(bit, mes->gang_ctx_bitmap);
-       queue->gang_ctx_array_index =3D bit;
+       *index =3D bit;
         amdgpu_mes_unlock(mes);

         return 0;
@@ -1121,18 +1121,18 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_m=
es *mes,
   * amdgpu_mes_free_gang_ctx_index - free a gang context slot
   *
   * @mes: MES instance
-  * @queue: Usermode queue whose gang context index is released
+  * @queue: gang context index is released

The parameter is "index", not "queue".

   */
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue)
+                                   uint32_t index)
 {
         if (!mes->use_rs64mem || !mes->gang_ctx_bitmap)
                 return;
-       if (queue->gang_ctx_array_index >=3D mes->gang_ctx_array_size)
+       if (index >=3D mes->gang_ctx_array_size)
                 return;

         amdgpu_mes_lock(mes);
-       clear_bit(queue->gang_ctx_array_index, mes->gang_ctx_bitmap);
+       clear_bit(index, mes->gang_ctx_bitmap);
         amdgpu_mes_unlock(mes);
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index c67db2d6e122..977c057dcce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -636,11 +636,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes);
 void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes);
 int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes);
 int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue);
+                                   uint32_t *index);
 void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue);
+                                   uint32_t index);
 int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue);
+                                   uint32_t *index);
 void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,
-                                   struct amdgpu_usermode_queue *queue);
+                                   uint32_t index);
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index a1f19888dc55..0e9657f2dbe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1249,6 +1249,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *us=
erq_mgr, struct drm_file *f
         xa_init_flags(&userq_mgr->userq_xa, XA_FLAGS_ALLOC);
         userq_mgr->adev =3D adev;
         userq_mgr->file =3D file_priv;
+       userq_mgr->proc_ctx_allocated =3D false;
         mutex_init(&userq_mgr->proc_ctx_lock);

         INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_wo=
rker);
@@ -1277,6 +1278,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_use=
rq_mgr *userq_mgr)

 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 {
+       struct amdgpu_mes *mes =3D &userq_mgr->adev->mes;
         struct amdgpu_usermode_queue *queue;
         unsigned long queue_id =3D 0;

@@ -1303,6 +1305,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *=
userq_mgr)
          */
         cancel_work_sync(&userq_mgr->reset_work);

+       if (userq_mgr->proc_ctx_allocated) {
+               amdgpu_mes_free_proc_ctx_index(mes, userq_mgr->proc_ctx_arr=
ay_index);
+               userq_mgr->proc_ctx_allocated =3D false;
+       }
         amdgpu_bo_free_kernel(&userq_mgr->proc_ctx_obj.obj,
                               &userq_mgr->proc_ctx_obj.gpu_addr,
                               &userq_mgr->proc_ctx_obj.cpu_ptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.h
index 8333bab537d4..6412a7f7b6ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -101,7 +101,6 @@ struct amdgpu_usermode_queue {
                 u64 va_array[6];
         } userq_vas;

-       uint32_t        proc_ctx_array_index;
         uint32_t        gang_ctx_array_index;
 };

@@ -133,6 +132,8 @@ struct amdgpu_userq_mgr {
         struct mutex                    proc_ctx_lock;
         struct amdgpu_userq_obj         proc_ctx_obj;

+       bool                            proc_ctx_allocated;
+       uint32_t                        proc_ctx_array_index;
         /**
          * @reset_work:
          *
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/a=
md/amdgpu/mes_userqueue.c
index a914198a4d62..1fd72f18e9a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -143,10 +143,18 @@ static int mes_userq_map(struct amdgpu_usermode_queue=
 *queue)
         queue_input.doorbell_offset =3D userq_props->doorbell_index;
         queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queue->vm-=
>root.bo);
         queue_input.wptr_mc_addr =3D queue->wptr_obj.gpu_addr;
+
         if (mes->use_rs64mem) {
-               amdgpu_mes_alloc_proc_ctx_index(mes, queue);
-               queue_input.process_context_array_index =3D queue->proc_ctx=
_array_index;
-               amdgpu_mes_alloc_gang_ctx_index(mes, queue);
+                if (!uq_mgr->proc_ctx_allocated) {
+                       r =3D amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr-=
>proc_ctx_array_index);
+                       if (r) {
+                               DRM_ERROR("Failed to allocate userq process=
 index err:%d\n", r);
+                               return r;
+                       }
+                       uq_mgr->proc_ctx_allocated =3D true;
+               }
+               amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array=
_index);

Need to check the return code, and handle error (e.g. running out of gang c=
tx index).

+               queue_input.process_context_array_index =3D uq_mgr->proc_ct=
x_array_index;
                 queue_input.gang_context_array_index =3D queue->gang_ctx_a=
rray_index;
         }
         amdgpu_mes_lock(&adev->mes);
@@ -179,10 +187,8 @@ static int mes_userq_unmap(struct amdgpu_usermode_queu=
e *queue)
         amdgpu_mes_lock(&adev->mes);
         r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
         amdgpu_mes_unlock(&adev->mes);
-       if (mes->use_rs64mem) {
-               amdgpu_mes_free_proc_ctx_index(mes, queue);
-               amdgpu_mes_free_gang_ctx_index(mes, queue);
-       }
+       if (mes->use_rs64mem)
+               amdgpu_mes_free_gang_ctx_index(mes, queue->gang_ctx_array_i=
ndex);
         if (r)
                 DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
         return r;
--
2.34.1


--_000_DM6PR12MB3611478BA8E7766040313BBB94D52DM6PR12MB3611namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b> Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, July 29, 2026 10:09 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Chen, Michael &lt;Michael.Chen@am=
d.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; Liang, Prike &lt;Prike=
.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 1/2] drm/amdgpu/mes: refactor the amdgpu_mes_allo=
c/free_proc|gang()</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">- Unify amdgpu_mes_alloc/free_proc|gang_ctx=
_index to provide<br>
&nbsp; centralized RS64mem bitmap management for both KGD and KFD.<br>
- Retrieve the bitmap bit for userq contex index based on a<br>
&nbsp; per process granularity.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c&nbsp;&nbsp;&nbsp; | 28 ++++++=
+++++-----------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h&nbsp;&nbsp;&nbsp; |&nbsp; 8 +=
++----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c&nbsp; |&nbsp; 6 +++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h&nbsp; |&nbsp; 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 20 ++++++++++------<br>
&nbsp;5 files changed, 39 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 9af7c97af5be..e3862095ff99 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -1040,13 +1040,13 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_=
mes *mes)<br>
&nbsp; * amdgpu_mes_alloc_proc_ctx_index - allocate a process context slot<=
br>
&nbsp; *<br>
&nbsp; * @mes: MES instance<br>
- * @queue: Usermode queue receiving the allocated process context index<br=
>
+ * @index: the allocated process context index<br>
&nbsp; *<br>
&nbsp; * Returns 0 on success, -ENOSPC if all slots are used, or<br>
&nbsp; * -EOPNOTSUPP if RS64 local memory is unavailable.<br>
&nbsp; */<br>
&nbsp;int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *index)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long bit;<br>
&nbsp;<br>
@@ -1061,7 +1061,7 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes=
 *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOSPC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(bit, mes-&gt;proc_=
ctx_bitmap);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue-&gt;proc_ctx_array_index =3D (u=
int32_t)bit;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *index =3D (uint32_t)bit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1071,18 +1071,18 @@ int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_m=
es *mes,<br>
&nbsp;&nbsp; * amdgpu_mes_free_proc_ctx_index - free a process context slot=
<br>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * @mes: MES instance<br>
-&nbsp; * @queue: Usermode queue whose process context index is released<br=
>
+&nbsp; * @index: process context index is released<br>
&nbsp;&nbsp; */<br>
&nbsp;void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mes-&gt;use_rs64mem |=
| !mes-&gt;proc_ctx_bitmap)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue-&gt;proc_ctx_array_index &g=
t;=3D mes-&gt;proc_ctx_array_size)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt;=3D mes-&gt;proc_ctx_ar=
ray_size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(mes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(queue-&gt;proc_ctx_array_in=
dex, mes-&gt;proc_ctx_bitmap);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(index, mes-&gt;proc_ctx_bit=
map);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br=
>
&nbsp;}<br>
&nbsp;<br>
@@ -1090,13 +1090,13 @@ void amdgpu_mes_free_proc_ctx_index(struct amdgpu_m=
es *mes,<br>
&nbsp;&nbsp; * amdgpu_mes_alloc_gang_ctx_index - allocate a gang context sl=
ot<br>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * @mes: MES instance<br>
-&nbsp; * @queue: Usermode queue receiving the allocated gang context index=
<br>
+&nbsp; * @queue: the allocated gang context index</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">The parameter is &=
quot;index&quot;, not &quot;queue&quot;.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * Returns 0 on success, -ENOSPC if all slots are used, or<br>
&nbsp;&nbsp; * -EOPNOTSUPP if RS64 local memory is unavailable.<br>
&nbsp;&nbsp; */<br>
&nbsp;int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *index)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long bit;<br>
&nbsp;<br>
@@ -1111,7 +1111,7 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes=
 *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOSPC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(bit, mes-&gt;gang_=
ctx_bitmap);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue-&gt;gang_ctx_array_index =3D bi=
t;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *index =3D bit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1121,18 +1121,18 @@ int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_m=
es *mes,<br>
&nbsp;&nbsp; * amdgpu_mes_free_gang_ctx_index - free a gang context slot<br=
>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * @mes: MES instance<br>
-&nbsp; * @queue: Usermode queue whose gang context index is released<br>
+&nbsp; * @queue: gang context index is released</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(0, 0, 0)=
;">The parameter is &quot;index&quot;, not &quot;queue&quot;.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
&nbsp;&nbsp; */<br>
&nbsp;void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mes-&gt;use_rs64mem |=
| !mes-&gt;gang_ctx_bitmap)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (queue-&gt;gang_ctx_array_index &g=
t;=3D mes-&gt;gang_ctx_array_size)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt;=3D mes-&gt;gang_ctx_ar=
ray_size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(mes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(queue-&gt;gang_ctx_array_in=
dex, mes-&gt;gang_ctx_bitmap);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_bit(index, mes-&gt;gang_ctx_bit=
map);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(mes);<br=
>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index c67db2d6e122..977c057dcce8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -636,11 +636,11 @@ int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes);<=
br>
&nbsp;void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes);<br>
&nbsp;int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes);<br>
&nbsp;int amdgpu_mes_alloc_proc_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *index);<b=
r>
&nbsp;void amdgpu_mes_free_proc_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index);<br=
>
&nbsp;int amdgpu_mes_alloc_gang_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *index);<b=
r>
&nbsp;void amdgpu_mes_free_gang_ctx_index(struct amdgpu_mes *mes,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userm=
ode_queue *queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index);<br=
>
&nbsp;#endif /* __AMDGPU_MES_H__ */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c<br>
index a1f19888dc55..0e9657f2dbe7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
@@ -1249,6 +1249,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *us=
erq_mgr, struct drm_file *f<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xa_init_flags(&amp;userq_m=
gr-&gt;userq_xa, XA_FLAGS_ALLOC);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userq_mgr-&gt;adev =3D ade=
v;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userq_mgr-&gt;file =3D fil=
e_priv;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; userq_mgr-&gt;proc_ctx_allocated =3D =
false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;userq_mgr-=
&gt;proc_ctx_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;use=
rq_mgr-&gt;resume_work, amdgpu_userq_restore_worker);<br>
@@ -1277,6 +1278,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_use=
rq_mgr *userq_mgr)<br>
&nbsp;<br>
&nbsp;void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mes *mes =3D &amp;userq=
_mgr-&gt;adev-&gt;mes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_usermode_que=
ue *queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long queue_id =3D=
 0;<br>
&nbsp;<br>
@@ -1303,6 +1305,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *=
userq_mgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_work_sync(&amp;user=
q_mgr-&gt;reset_work);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (userq_mgr-&gt;proc_ctx_allocated)=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_proc_ctx_index(mes, userq_mgr-&gt;proc_ctx_array=
_index);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; userq_mgr-&gt;proc_ctx_allocated =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;userq_mgr-&gt;proc_ctx_obj.obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;userq_mgr-&gt;proc_ctx_obj.gpu_addr,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;userq_mgr-&gt;proc_ctx_obj.cpu_ptr);<br=
>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.h<br>
index 8333bab537d4..6412a7f7b6ef 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h<br>
@@ -101,7 +101,6 @@ struct amdgpu_usermode_queue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; u64 va_array[6];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } userq_vas;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; proc_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; gang_ctx_array_index;<br>
&nbsp;};<br>
&nbsp;<br>
@@ -133,6 +132,8 @@ struct amdgpu_userq_mgr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; proc_ctx_lock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userq_obj&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; proc_ctx_obj;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; proc_ctx_allocated;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; proc_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @reset_work:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/a=
md/amdgpu/mes_userqueue.c<br>
index a914198a4d62..1fd72f18e9a8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c<br>
@@ -143,10 +143,18 @@ static int mes_userq_map(struct amdgpu_usermode_queue=
 *queue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.doorbell_offse=
t =3D userq_props-&gt;doorbell_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.page_table_bas=
e_addr =3D amdgpu_gmc_pd_addr(queue-&gt;vm-&gt;root.bo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_mc_addr =
=3D queue-&gt;wptr_obj.gpu_addr;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;use_rs64mem) {=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_alloc_proc_ctx_index(mes, queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.process_context_array_index =3D queue-&gt;proc_ctx_a=
rray_index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_alloc_gang_ctx_index(mes, queue);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (!uq_mgr-&gt;proc_ctx_allocated) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_mes=
_alloc_proc_ctx_index(mes, &amp;uq_mgr-&gt;proc_ctx_array_index);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to allocate userq pr=
ocess index err:%d\n&quot;, r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uq_mgr-&gt;proc_=
ctx_allocated =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_alloc_gang_ctx_index(mes, &amp;queue-&gt;gang_ctx_arr=
ay_index);</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Need to check the =
return code, and handle error (e.g. running out of gang ctx index).</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; queue_input.process_context_array_index =3D uq_mgr-&gt;proc_ctx_=
array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_input.gang_context_array_index =3D queue-&gt;ga=
ng_ctx_array_index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(&amp;adev-=
&gt;mes);<br>
@@ -179,10 +187,8 @@ static int mes_userq_unmap(struct amdgpu_usermode_queu=
e *queue)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_lock(&amp;adev-=
&gt;mes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;mes.funcs-&=
gt;remove_hw_queue(&amp;adev-&gt;mes, &amp;queue_input);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_unlock(&amp;ade=
v-&gt;mes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;use_rs64mem) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_proc_ctx_index(mes, queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_gang_ctx_index(mes, queue);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;use_rs64mem)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_free_gang_ctx_index(mes, queue-&gt;gang_ctx_array_ind=
ex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to unmap queue in HW, err (%d)=
\n&quot;, r);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_DM6PR12MB3611478BA8E7766040313BBB94D52DM6PR12MB3611namp_--
