Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5147C5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 06:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BE7210E0B8;
	Mon, 24 Aug 2026 06:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FuGdpXeT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012020.outbound.protection.outlook.com
 [40.93.195.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D9210E0B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 06:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6TggNbdDfgqiwE9M2CF7YB/IFN7DDOa6Dl2kqRweIOCKQGdQkR/w7GGCN5og6gKUv8H+xcfx7KycfPytCDyyNk5svNth6lP6dUCm0FadDU/+pbnA4v6y2a1KuVXdd72ky8DhaNSKJ5n17fHcRFWnvC/OSF7gJA/iad5h+U+m3WFPyTJZcDa+WBcjuaDdXZVTTdU0Q4ZZWx+2ooreoFHX+HEzHnUpAyi2Adz/tbSh1bd/GDNDPVUUUXdnu0vPA/xwQUOZz4NEsqVQcH+hGkdg16pdrXHXZGAQA0PKvCxCbi1Z+p09/mXgQCff6koVzn9p3g7WlfA1nFDKmqLcby6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DhJFhIdcRblLfqg++dT/187EN/7M8Q8U0TI4jgMDew=;
 b=uTKG+DlODeEGcgXa0SWLpqT+oQcyjrDd/J9OynTqqRMQDMCZ+s5KRYhVQsGDBh4YKS31c0P4/voOkAB/1gPtU4oswfq7NiCZkewgBhWiqUgQjgY+MN8XlU3GIBPXJXwDV9qdFGFI7jUbbgjINyCTVLGvUKM0NeQId5aiCBy434jDUuldHrPNnQ2uF29bAPHj3CNZurBWoVvTtri6DVSFkrrE1h5fLLzQ/w/n9z2YZxtuWUxuYfVQgmSkq/uB3blybkbVCwIoDwzLncHPs7sYOLxUcdRnin1mdsYdR8+IOax4vLe25IzjztHDtvEJ03dYelwgK4qTigS0fWr0XF4SFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DhJFhIdcRblLfqg++dT/187EN/7M8Q8U0TI4jgMDew=;
 b=FuGdpXeT0r1dEHQxodnSNFOIimCk8dNN3gSfqBnHmfhneZ7KbXTdF6EsIWmVJQZDF7I3Ci2qhekN/JlF2SXY5X+lmowKHtZH/cNL0ZdyPU8PjoqpR2YXtlxu7IVLWqpGQcutrSzBzEosx5z/fttTr5dDz84xrmX8VtOjCrAS+WA=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 06:39:37 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::17d6:3ce4:21e6:8c8d%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 06:39:36 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset
Thread-Topic: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset
Thread-Index: AQHdMJJ6sAp4+FJoG0WIyvpypN/0+rasxHgw
Date: Mon, 24 Aug 2026 06:39:36 +0000
Message-ID: <PH0PR12MB5420452B1526CEBBF8EFF704E0A02@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
In-Reply-To: <20260820105537.3138777-1-YuanShang.Mao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-24T06:35:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|LV3PR12MB9166:EE_
x-ms-office365-filtering-correlation-id: a626d82e-96a9-4794-94a6-08df01aa775b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: du4qsj3+8D6NP/w/ffx5uiNYrJMGvr/G9op53UHf5Udh/Daoxxj2d7Xh+dJ+efia7T/lB7ZhujNl70BsOvBRs2TRHBnTe8S9qJ91ocLJ4ZVBWzIgWWpSKzS14/SX0RqJuOZmFT2KD1ParjtDVSuc97m1pKtk044USrtA/PAr9+R5A4NT47E5DEQ1xhVf8dYU8g8+h2C9lszV4sv1jSs4ZecvlkCBglRtLwMSkYoRiGRzUP1omV7jz6Tnlwk8m/XH1A4a+cH9jlPTLdJgGWQBZGi3lV7NRPM9dMHEn59rV/ZKk0lxtVUhPD9utZcPpa2qZx4dqFziJeNSdWoTDO/fRYvsE4OpiNiznS2wtYKYpYtyeI0EsLucEGHQQL1IPdKWWTtxZLYkhi4tMr4YVgYlonp03GQ9vMx1xsAzI9ZXg8hJYPmFUotkV8xcisWEmr7WbwHlfSZD4KyP0b+Da0ggXrEv+BDWknm5sYA0t5I4c1azld83CtAYLjSXFDfIKxtefH2NxZdqcacmfhcdMyGnp1397oyuQYZW0KE/HEne0G636XI99T7ti2w89amQMPNtpEY9juFl3tXqnRwK6e4qWWIv8RoI1P5LRIy1l/bUkLOzUTtgTv7G2Vk+MW2GuAHa0QXxrVOi3RH0hzWMJYy8jtSPTl0N23jUO3KI3WpJSMvqf9JSEuyVviS+tNAS+4D9vLLOPFR9R6yoXFVy+COkH7H2JIwu/LamLuINc+6CqLs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wSCkIcjBME6VskVPpc2b8cRNKuxvmVmIqHXtkByLR86Beuge5v0NjlcsPkoV?=
 =?us-ascii?Q?iu66T6YKDJqBYX6/OP30PovwFViW+KhNGAC6YUxMhdmxWCvTPmNNYt6/3dTF?=
 =?us-ascii?Q?f5rDYATO6c9EE8hIO6z43ZoX+8DK4DRo5tvwKrtlfRN7p/N+UdTw4iVp1S/4?=
 =?us-ascii?Q?/ML5X1/BD+3E0Nh2G4b0QLer6ZjFAxSVRqThnEti/RUhRqzX7s7VlevU7di0?=
 =?us-ascii?Q?Joeke92t5Gey79M5g9pGOVklWyPui7XKReHJ60RUWmGpuCpjMqQExxhaWOpo?=
 =?us-ascii?Q?DGvRpheCQ9Pa9hxn8xoDsWPtcX0jA45uf+gzCDZ/C86s04KzH3tRP35AdQza?=
 =?us-ascii?Q?EekEfrPGM0iGF1/o9x5KcwFTmSrdy0aX0skEFAYU4wPPRxfmURwxQ2Et9DMv?=
 =?us-ascii?Q?w0idjqi/dIBoEKJdcbNHLZ1I5L3MPayXI4mC6HSiGqpwd8mGLnQmoAB+H8Dx?=
 =?us-ascii?Q?RO7AWT3ER5nT4OdOa+gOrB1jDe1vdkaKW/v2jg2RI42F5UNKmNEgX32WJlPZ?=
 =?us-ascii?Q?HDTRblIv1WYgJjl5ETCGiar0RqbyEKOQ2PorbA30ctt/gq+n4ft1gmy+E1DO?=
 =?us-ascii?Q?qQ1x+HUcenQG/HZG2sM9A4TYENJ4NwYbxCYQraUBqh7WHE2lXn6Ydh8F0enw?=
 =?us-ascii?Q?JzJD3wKNNNJJVNuSsE5/p67hL12rrewzXy4+U5UC7Lq91hKRzpgZRz7awTp3?=
 =?us-ascii?Q?r0o4J20TGhadKl4bxfkNGrh/wyauCYDKgPAMyfmm8tU5pgO6u8kbNKKpag9K?=
 =?us-ascii?Q?LHM4awEBoTsRV6Mxem5kc7fmxSeBzaWwlU5mG8Zsr41pV/5u/Da3EklO/FU4?=
 =?us-ascii?Q?f/Cr8G3au7KmY6IH8Z9MgRWquuH9UYcpWC2WFDhdK/Y1kZvMcAZ7qXl91LeU?=
 =?us-ascii?Q?Isb4BUFepMLJas3ejf3yD9WPCeQEZA1CBSDoN4IBpDQO7x4djXu85PJcv2DH?=
 =?us-ascii?Q?O3YYoS3TTfcv07NksNFpDiuB/6WT6qRv9AGFbMj8kvwgk56Q8iRYJh6iyUNq?=
 =?us-ascii?Q?QeDrYdKrKGdtrlrPR31Fczx07+IvG2lzGtkce/VyjS+FZgOaxl7BUBZN2ull?=
 =?us-ascii?Q?iF0rsDuq2nRk0IOfr7z9cgy82Ivwr9mAPkWUlmzJunmyudTs45co9ORP1mG0?=
 =?us-ascii?Q?VWaiobQeKkkUs3uE6anJCdzJGSuqMGK7+HCFyWvR0bvm4a30htI/3OP6wuhK?=
 =?us-ascii?Q?k33sRhnzINb2WEf7AMsJwMWrpGWLSqpHkhHssmfG1gIDbLZrPfT+vjorNcJ/?=
 =?us-ascii?Q?1XNWBOkYLHMIFjZkmIwdvCUhh9B1iesm/8RygCc32VE8gNfFYpAjRx7euiDc?=
 =?us-ascii?Q?mjKktX5VDhRKFiXfqJl7hO2YUQNUBHkpIIwK0+NB5TNNOnAZiAc6RU/1via/?=
 =?us-ascii?Q?BRXyLEwlMeFUafzb4g4sYYhu9Zk3zJS5qsRGDBR855tDEi4prU1UEBOkm+Yk?=
 =?us-ascii?Q?A6B4EhbTTeonXDnkdel9OCM4VAFoZYorcNogJnyvods835AUsxEz4ahQuAY5?=
 =?us-ascii?Q?7miSyVrfW3QzPlW+psXpiHNmNZiss/9NsqQsvhpa+Bj+Nk9Bc7i6zNDiK0gB?=
 =?us-ascii?Q?ZrJDXLgywZecW4f+B01wkfVZBUy/8hHB1KLSyUccTMjgDOZ/XkJdtx4xr8Bk?=
 =?us-ascii?Q?BIwgtkjYG95V+6wuOxgpelWm63e8wh96F9PjTha8ODHMyIhxT5Ukgaab5R0r?=
 =?us-ascii?Q?O2x/VPvovt3DglUrTVT7hD0tNVIJUXsnVN+2ahCvEQk1ytFD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a626d82e-96a9-4794-94a6-08df01aa775b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 06:39:36.8356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtlF9pH1hZX/fpi2C2nDb8khiVHg88MSY4wuuIrAQXFmZBoYN3EQMURbU0snSmtyKT1R5rNRHEY5dB2Him3UgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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

@Deucher, Alexander Could you help review this patch?

Thanks
River

-----Original Message-----
From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Sent: Thursday, August 20, 2026 6:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amdkfd: mark queues as reset after a full GPU reset

From: Yuansheng Mao <yuansmao@amd.com>

A full GPU reset reloads the MES firmware and wipes its queue table, but KF=
D keeps the queue objects with is_reset left false.
Pre-reset cleanup cannot fix this: it runs with the reset domain write lock=
 held, so remove_queue_mes() fails with -EIO and the cleanup loops bail out=
 early.

When the process later exits, process_termination_cpsch() sends REMOVE_QUEU=
E for doorbells MES no longer knows about. MES rejects them, remove_queue_m=
es_on_reset_option() mistakes the rejection for a hung queue and ends up in=
 kfd_hws_hang(), requesting another GPU reset. On SR-IOV that resets the wh=
ole card, so one injected hang costs two resets and disturbs the other VFs.

Observed on Navi32 SR-IOV with a compute workload running:

  ring sdma1 timeout, signaled seq=3D239, emitted seq=3D240
  GPU reset begin!. Source:  1
  Failed to evict queue 2
  GPU reset(1) succeeded!
  [ ~34s later, when the killed process is reaped ]
  failed to remove queue from MES, doorbell=3D0x1002
  MES might be in unrecoverable state, issue a GPU reset
  GPU reset begin!. Source:  3

remove_queue_mes_on_reset_option() already skips queues with is_reset set, =
but only the per-queue reset paths ever set it. Set it in kgd2kfd_post_rese=
t() as well. Suspend/resume is unaffected:
it goes through kgd2kfd_resume(), where queues are re-added to MES.

Signed-off-by: Yuansheng Mao <yuansmao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 586e640f13dc..d326e41a8656 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1033,6 +1033,27 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
        if (!kfd->init_complete)
                return 0;

+       /*
+        * The reset wiped the MES queue table. Mark the queues as reset so
+        * that teardown does not try to remove them from MES again.
+        */
+       if (kfd->shared_resources.enable_mes) {
+               for (i =3D 0; i < kfd->num_nodes; i++) {
+                       struct device_queue_manager *dqm =3D kfd->nodes[i]-=
>dqm;
+                       struct device_process_node *cur;
+                       struct qcm_process_device *qpd;
+                       struct queue *q;
+
+                       dqm_lock(dqm);
+                       list_for_each_entry(cur, &dqm->queues, list) {
+                               qpd =3D cur->qpd;
+                               list_for_each_entry(q, &qpd->queues_list, l=
ist)
+                                       q->properties.is_reset =3D true;
+                       }
+                       dqm_unlock(dqm);
+               }
+       }
+
        for (i =3D 0; i < kfd->num_nodes; i++) {
                ret =3D kfd_resume(kfd->nodes[i]);
                if (ret)
--
2.25.1

