Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D00C55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 16:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F297110EB0E;
	Tue,  4 Aug 2026 16:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VunOPGv4";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52CC010EB0E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 16:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfDwhbDCPdX2FeT/CxDhnZNZ6vT4HSup9AvS8SiXS5dAPaytiRTz5UuzJhyxlAba/BdiqRYBF71fv/CFDTizluyO1/SoR1YQ88Ba4+P8+B93+5LvvJHW1qS4Ow0xT2oyynRPHGq63o2w6D8mdohhm0CAKD8TyAngOU/ImdA1mnk6m3F3mTdJJdQFenH8THdTkffJpQbag0Pu3n4htQSmBnHnQycF7qs1yl9b2njYbNnYojiRFc4A9ll8D7hwJPjbavXHEjHEys2s5Sli7596rfdinHz+h6/UNdjxHCeEVakPoW3n8ckdpzNTxYGJ/DEbPZEzmaRbZvxqTrySS7iMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3pptKQ78i0yKCQn4UOqDyeJEz4I2tIkmzCcSq0mT2Y=;
 b=RVYQlYG7K1OCrEWgnS3ai4+5APUaf7oAYlF0t1+9iZsmtyXn9zi5OWHcheT46fdU68XrvHO3FltPuFOLzo66JulS6R095X68D/94Hrvh9YDPjUr7gsv3fBw7gMV7ovHD0m7XgymRYVKJ4K+oQb4nv7CqtLmjguzyCtt2XN2+YSDxBQbbaPcjg9kaso8LgCHI833h+BkmZq6S1sl+3eqaoorPeP2wEu4tDqOIlRDfknTFMwdI3FVnDrc2JushgsSl8b9Uy+M9jyuzYgiisFarJdjIl1+5X13p46RnQwgsFKPQoH/nDhOOBqCC6kC7/pFS6IQ7VVD31/0es/nqiUILPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3pptKQ78i0yKCQn4UOqDyeJEz4I2tIkmzCcSq0mT2Y=;
 b=VunOPGv4GR1rE1k6cAf7PU26LpWF9fjx6dQuwVG5sXmDk2DrcP/cIG7V/kCE6j/gc9kCVaqBn78GWbetzrVCmLF5S0rNirb2GWNgyKUPLWRkh/Z0HMcbztT+v77UoV2J5kN5eeFYP01OwdL7/OKJ6xf2qQl4KkQ18aWn+w8D01Q=
Received: from SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 16:09:12 +0000
Received: from SN7PR12MB7856.namprd12.prod.outlook.com
 ([fe80::a3e7:285e:e0d8:24c1]) by SN7PR12MB7856.namprd12.prod.outlook.com
 ([fe80::a3e7:285e:e0d8:24c1%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 16:09:10 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chen, Michael" <Michael.Chen@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/mes12: fix dropped dispatches under queue
 oversubscription
Thread-Topic: [PATCH v2] drm/amdgpu/mes12: fix dropped dispatches under queue
 oversubscription
Thread-Index: AQHdI+KMv//LSIzo7UCtMRWd1snz9raODzxg
Date: Tue, 4 Aug 2026 16:09:10 +0000
Message-ID: <SN7PR12MB78563D0DF1F03F847EF8AF97F4D42@SN7PR12MB7856.namprd12.prod.outlook.com>
References: <20260804072606.2710051-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260804072606.2710051-1-Jesse.Zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-04T16:08:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7856:EE_|IA1PR12MB7735:EE_
x-ms-office365-filtering-correlation-id: 79155e7b-6f05-455f-b4f4-08def242b82c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|38070700021|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: hkYZs3QcscaUtTb9t3W2s+v7WpS1JOxIoXBQckMVv+HgCOhYPAo+vrv/NmZlqADXauSzZjyuYaOWYjdpJXYcp+IO2Qk/c5z+mm0fTW4J8W93u46LyrdnKCw2Hl/ups2pIfYOaTXsI4wXGemLy8j1yXnIuOnwb6MyfUyTyEiJEgjv4w/FUx+O98fRx/jUWz+oJ1rMAoq3Cs6T1gtXOyRNpxwUE26VcnzTUTCAiPDbJyFekmJXREoSQLvoUoOyuk10ORqof/YU5j6baL95KE781ZyEenzegYA06/IrnPyhLhMY2Anh622sm9H34ihvo2bGOj31wvEgXa/7b2WfyMYFsp09lYRoR6AZ4956cfEfg1/+4/6FrnUi5C9fvpEf6yq+qXl6PjY60OayyJ5zci50hCYgvh7ZV4THU7PWG4nxBLHB2lBPQlaq3dtCs+8Sud0x+MCeT7KjzTnG+nqYOSwqe03bNxBjRIU0aKEyQDa1QyXeXgnwde0iOe7tPnC/NGblvL0rQZB75C9zOUoGHb6GTmfpKQGSJQfmt/zncDyQjw02foj0SJtg41eUuEyYM1aupNTzVGh0UlJvJ662TzUqdzoKx5udPrTx7XojkH1+0RO+wvVA4JciWo0TpGiNo1EHXSikAUi7yvH96sXOVuSeP368+r24TsfXkxVyPMCFDP0mMZ0v8zwiRBitTsLFaKWhCNj7TlL5tyQoG64M/jv0r/fnfxVDi49EAIP0RZGO0e4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7856.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(38070700021)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2mLqvIyTpVAiF51NazqgkDRZfzFljCs4goHh3Z6vumnQvgmyvYUSz7UKzPnU?=
 =?us-ascii?Q?2MgE3fTlnn0TGhjXvMUEKjXL7uEo7sxzHWoxlEMFdLWVbS9zKBNoYTfAlrRl?=
 =?us-ascii?Q?Ez8VJd/lE59Nu6rDjQR54tXhmdH6qHS6ISr214zoZicQ+HSi2mzF+7fZyH0w?=
 =?us-ascii?Q?TEcES25Py7mh4GwOxd34DZvcievPy9+O4i5cXohjZnyBtz4hhXS2Xz4hLxtc?=
 =?us-ascii?Q?Qp5ZDNm3ZolaybF+b7+0Yb99OFApadhzthuX5eW14ZSmvDMeoFMmNwVnGzma?=
 =?us-ascii?Q?G0phyrmr43iPKi53cRghizMh/Ds8qar5qjBh5NDhgaHmfEIYEgYzSdUKxgjm?=
 =?us-ascii?Q?XEMdqF7CUFLmgFSrvR5cLIaM5oLBZfZ81ySBQfbSo7QjtOCeDvfJb2Mi0KZ+?=
 =?us-ascii?Q?nh2NcXukF8p8A7b73ZQOPC6QvzUMyDogwFSDqVZDmbmn3UoteLo6/7fY8SEd?=
 =?us-ascii?Q?1kcYd8w48WRQbfCNz4HFgWBhnqXShyofPCvb5bmEhCSKgdTEAn4uDR5u783r?=
 =?us-ascii?Q?sAeTJsHaF58gUEveiE1k9NKJhaf42CYClUDFPOl1ld5T8L4VhHan75Y5BBnK?=
 =?us-ascii?Q?Ml+m/3c8rGTH3/F2ZLLgDqZjMDfNdTjVdl3ABqU1RC5hPNo1iI4N+h0iAB0e?=
 =?us-ascii?Q?TsLywdRri2/6UpqaU8VKNQxv5q1VzxIle1uq99sPY6cuHAa9D9bPh3Jn/FLt?=
 =?us-ascii?Q?+2mQa2d5VzU04IqLdPOGVDcxb8OjFZP+xkQ5DaptXIQK8rU2sHsLDwrlUDc4?=
 =?us-ascii?Q?n3+M9gLEmspn6Mqwr4oP0T41u9cCuhM8X36vpw7qhwSY36UDQ8+fVpE6SlWq?=
 =?us-ascii?Q?0bq0azt/A9wUNojZUUlhy7K5qDVLDUQBRkLdAVe/p+BerRYL1380E7m1hPfs?=
 =?us-ascii?Q?uls8os339fRimdSEnGZLPg2+iMfYhDnr+bRlyEg6R/wJg9IK0cnSzNwOlaiG?=
 =?us-ascii?Q?nvo+j7tMfkOE6t/axFZfHPayeIX6WT3jkat9ocW3gKJ0ER2Y+ARifpNWt/Qy?=
 =?us-ascii?Q?AqfqVd0unOcHbeoJbmW9rrDp5sj72EA0BaMH4cS8KuXNuxKwW7ygt0O5ViSD?=
 =?us-ascii?Q?YTzmcLPqUIGEr6vQMepP5KT3MACJ0juqU58dSv+OiqvtrVM2HmAmPxUxaWcJ?=
 =?us-ascii?Q?fJ6EeoJ2eiVnGawgkheGuwYEhZbRT2ZbfaFEIyVp0MuOTUGO7si20Iw8fD0C?=
 =?us-ascii?Q?mvsdpc3q1B9KJBrxpZV2ciEmuVw9MTT9d0hMTZinEKYgc3evbaXLOIuB8563?=
 =?us-ascii?Q?BEEuDENykY+dPFnVWYb3bjyOegZOB1lQZTOVBKP2iQPwqjzOBttYaKc6RTY7?=
 =?us-ascii?Q?OvDTm9XpFB5oMINHXigoKB7HxuVd/CaTPpDUfiCE5gx7+eYnk5MazjrBxxDL?=
 =?us-ascii?Q?Hz71ttjrKPQldvF16ID0Dpbj5Z0KV5aCAQL3DlptZsQjzBGv424jY2aIAg0L?=
 =?us-ascii?Q?cU9OGjhTZjVKEAw4ycMxNPed3FrziatXGIchqoB56Gvd43A/DV8ZjKVDNMFR?=
 =?us-ascii?Q?d7QurIaGE6dOcvbikw8kAKxGjrzTIGd5VFi4GM6Cj4zc/BmHd883K4RunVOq?=
 =?us-ascii?Q?1fEJ8Li3hcCq5jioznHVglxdvzyGt7FD8R6HAoT94WOBCr+zFhFjqZVLusJa?=
 =?us-ascii?Q?/mZ9AddgGPvObVyiaMOHmRnFnwC2JsqNk4Ma4c1bFfFJr6/AIJOBxwupc9K9?=
 =?us-ascii?Q?uqdqbD8m//MGIqyWQ3XeyI0tEXX78aWVtQ3J3HsjrKASkDbt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7856.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79155e7b-6f05-455f-b4f4-08def242b82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 16:09:10.4794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X37B564+WcDg4q0blRcV4vic1NRBpuF6dLRgna92I47dPrxYPCINsta4uxfSPhRv3aFwNTqh3TxwPoxZ9ODoCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
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

AMD General

Looks good to me .
Please add me as RB .

Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Tuesday, August 4, 2026 3:24 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Chen, Michael <M=
ichael.Chen@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu/mes12: fix dropped dispatches under queue ov=
ersubscription

On gfx12, when more queues are ready than there are HQD slots (oversubscrip=
tion), MES keeps queues unmapped and maps a queue to an HQD on demand when =
its doorbell rings; a queue is only refetched once its per-queue work_done =
is cleared.

Historically oversubscription was handled via the aggregated doorbell, but =
that is a shared level-wide signal: MES cannot tell which queue rang and ne=
ver clears a queue's work_done, so it relies on the coarse oversubscription=
 timer to rescan. gfx12 therefore drives GFX/compute through the per-queue =
unmapped-doorbell path instead (the aggregated doorbell now only serves SDM=
A), which can pinpoint the ringing queue and lets MES stay idle otherwise.

But with unmapped-doorbell mode 1 (basic) a ring only sets a coarse level-w=
ide ready flag and does not read the per-queue bitmap or clear the ringing =
queue's work_done. A queue still marked done from a prior dispatch is skipp=
ed and its new work is never fetched: the completion never signals, while q=
ueue creation succeeds and no dmesg error is reported.

Switch to mode 2 (basic+): MES reads the per-queue CP_UNMAPPED_QUEUE bitmap=
, identifies which queue rang, and clears its work_done so it is reschedule=
d promptly. This affects every queue MES schedules on gfx12 (KFD and DRM us=
er queues), which share the one MES instance and this global setting.

Tested on gfx1201: concurrent multi-queue dispatch that intermittently stal=
led under mode 1 now passes on both the KFD and DRM userq paths.

v2: update commit message: describe the oversubscription case, why the
    aggregated doorbell is not used for GFX/compute on gfx12, and why
    basic+ (not basic) is required.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 8d1d1bf9091c..cda83e6533cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -1015,10 +1015,16 @@ static int mes_v12_0_set_hw_resources(struct amdgpu=
_mes *mes, int pipe)
        /*
         * Keep oversubscribe timer for sdma . When we have unmapped doorbe=
ll
         * handling support, other queue will not use the oversubscribe tim=
er.
-        * handling  mode - 0: disabled; 1: basic version; 2: basic+ versio=
n
+        * handling  mode - 0: disabled; 1: basic; 2: basic+; 3: basic++
+        *
+        * Use basic+ (2): on an unmapped-queue doorbell ring MES reads the
+        * per-queue CP_UNMAPPED_QUEUE bitmap and clears the ringing queue'=
s
+        * work_done so it is rescheduled. basic (1) only sets a coarse
+        * level-wide ready flag without clearing work_done, so a queue tha=
t
+        * rings after work_done was set is skipped and its work is lost.
         */
        mes_set_hw_res_pkt.oversubscription_timer =3D mes_rev < 0x8b ? 0 : =
50;
-       mes_set_hw_res_pkt.unmapped_doorbell_handling =3D 1;
+       mes_set_hw_res_pkt.unmapped_doorbell_handling =3D 2;

        if (amdgpu_mes_log_enable) {
                mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
--
2.49.0

