Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF48CD98F2
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 15:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEAD10E187;
	Thu, 18 Jun 2026 15:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2R5AIxeM";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D200910E187
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 15:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciI0+kJe+D/w/vmW4gdaCb4OAy/WV+/Dvdms5e0RtcSGUsbopu9+YlKfSrYEdER1OZdWvE+93D6l2YfToNiRqI5C7Xd0Sl0bxcsgEdviRFfDQlz9MRQVovxGdXyXlX2cHo97oeQLSVqfQxc2ekCzBsv0I7UF2Z+Ojr5j4F/8RlKZS5FlEKd7o3ZfHodvX49tphdcxvmZ7zVT5bNvbRMwbAY22nYe3LAebnq2YTeAXsvCEmGwl0B67UNHpaChwyuZEmzzR+839T4yifiiVgOO0qjQbAymetx/G2gW0qzVdrPq9anz+FRLS8n7wEFMqt+mTzrd9pGnzE7ARLCHC6AR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhxQy7derP9K9A9gKfjus9GTiGmGit6gh8xn/keZ50w=;
 b=QVRhNWe2UOK1JSMlzI4K+b4R8lPYZryYFMU/Il320k5tqKaBPAQ3XrPTkTcdc/7aKW9zBSc71c5rOu1uuaIBGLg1UyoQXAWwL6WdDRCWpSN93pzIy87mt0z5ExZ6F4njxT6d0EXzqwvljyHPczG2pakBJ3+CLvi+irK7lAUuvEWrw36hgpMjGtnFVPrU9iwYaufnAnDuD1eghcufATQtW57jZpxeXhyaKnlSed2gJo/KHsAT1mjEh7FObF/mQGyHXVcvlomoHpXAEdQ0SkMZd7CMWw6cX7aRNjC/4SleGAUHZ+7xqNdkvopPnXObX19RlPUR6nOUgWf9ydspYHhnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhxQy7derP9K9A9gKfjus9GTiGmGit6gh8xn/keZ50w=;
 b=2R5AIxeM5aBSNU3rXtQta5vKKqAu2gqjN7dWiG7CHid+PbYCesTN5URFwSkiq5OVKJb/HjQ3XTxD2E707LWg2wXlammkVjmQ9xqo/kBuN74FcdGLOvUX/JpE1CJhVP/HcEpFbZbY5zzm+9RLa5HXJzHVw9S0q6x+49MBA9tHpA0=
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 15:44:28 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 15:44:28 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Guard m->cp_hqd_eop_control setting by
 q->eop_ring_buffer_size
Thread-Topic: [PATCH v2] drm/amdkfd: Guard m->cp_hqd_eop_control setting by
 q->eop_ring_buffer_size
Thread-Index: AQHc/d7DGZdBTixohEGR2kxurIIOzbZEduHQ
Date: Thu, 18 Jun 2026 15:44:28 +0000
Message-ID: <IA1PR12MB851768A7DDA25A7F75A5A77BE3E32@IA1PR12MB8517.namprd12.prod.outlook.com>
References: <20260616222303.466318-1-xiaogang.chen@amd.com>
In-Reply-To: <20260616222303.466318-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T15:44:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8517:EE_|MW4PR12MB6780:EE_
x-ms-office365-filtering-correlation-id: 715f9542-a713-478e-27db-08decd507b94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: LyK2hjc6nE5QKhgaZowTNuttrbbsEhfMvV/tjvwIwKaiGX6nzTJ3uCzuRlRy4cBOxlpTOVm3ai3z/M5j9h3d10ZGmp/tdxqrEeHpaonDTWoxyak9qz3VNS70QgEWKNlR8NdlH9/5yApz5jaSIFD4ldUgs6xDwohTLtHPaq2ZcQkJtySPnZuMbpyUrIPaPpwsbs9K4lkgQQR2ZdIn839JYVpQEO43S/jisCX3Oid2EmfJ7Mc3B1CCN2HFg30q+2c5ylf/YARZTiKbDXVcgkZFSKORD4eH4+HXL83w/bhrMrNDCMS1+AxsgM3XGYpxR8N8IiN96xbVEmvj6FWnmt90tmrRF1PtKwzfsxIF6ffkTobBAJLyRcDA9uOoLdsAX0xLr1+pN5vnpJyTpbCb+HTPI+kzD+9A7rKVk+zYIajIvv+orLzMRBeGcT3MH09v2yOC8898VjjK9zAYMjOUKCZce+031vUILOlQq/CwPe99et+S36Z/7sSGWIMk3s+UQMbhoTny1shZY/+mvUR7Z1D66yLfhyuETzUCQHrpfGMZO/oq1aGYmNr3R/XSEjPYn5QaV+m5RcmqZbaJkOyzpnK1m9GyJSubFSg4Nf1fJVQCHATWst/Ppx47EcL/1mlvJbWKbk5UuuqjGR0An3hWXV+4rr3whaq1t+XvMQ2kRHBmCr1g3fQCEzjKxJ1c93U7au7sv6nL7k3ZqXwN37EwkEvBVYuHlUyAbo20XmN+Fm2BwWherMDdvhLxYPd+inJ7HlN4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KXKM1eZD/GTDW2m1zXP+JytFP6aCxPeR4aXFNaClRggfButNa1P/yE8bswni?=
 =?us-ascii?Q?3XmE3p4ClL1s2QIpC8N65Sh7rkdhWaHp3qfT8nFbcB/DFkP4kaRnBf9BxufB?=
 =?us-ascii?Q?jPM0Kwqe/+tqIy/yyqIeszUktiy7cIiCDmZ0iFsa/q9hWiI7DoNro6ZaN8Iz?=
 =?us-ascii?Q?PO4IWkmaGm1bx0IFJW0Lb/bGm7glWfCLWgHsURdBcXOfkT7HuMOBQQtMq/Az?=
 =?us-ascii?Q?v/fTRrXP5vqjBBhV7foSkbLW3m1PCPh8obuKfDs6ADewWNcsyiWIKhwoxnEJ?=
 =?us-ascii?Q?y1mNG/YnVHD5cOY8qh6rludvhvqaWDsPnKCZYUiwuJbocNPu9zKohHhQ+FsI?=
 =?us-ascii?Q?3/Z9ELds8BkWsfGjZmPm3nC48ODmzo1zlmLCyf0ZzcQtyx6g2+TP5yXYmMNd?=
 =?us-ascii?Q?s4wqnBXW8HNRpW7suJb1b21y2BFl6mQRuDPJN3s3ptv7Yk2FrkC3AtFsgP3s?=
 =?us-ascii?Q?tOdwRbRT1k34ye5UHeki8N/9qymOva8ZraO+aYTqXTVWQ7+Uh0o/33s/sFLj?=
 =?us-ascii?Q?xyJacNKPsk2YOPot4KN/7INECt7POZ+Is2zo10opM33b+VZvvXmT2vPhn3YI?=
 =?us-ascii?Q?HDGi5RbLrgZT4sQ1490Eux+PxnfUf7BvTVPq2uroBItRtvgO6nhk3K4Hpkk+?=
 =?us-ascii?Q?t89qVONGjsNc7mYMHwgXIDN/m55a0h5x8q2NYteKRvl+okLUXh5B8TZu5213?=
 =?us-ascii?Q?iJIVMtu35p5xYaDIwTI7OD4X9Qva2o1BemSZ6MfPPC7Meyqzta5QxcddagnE?=
 =?us-ascii?Q?UBEoe7okntAg4tpaZyA8CYd9vRSlYYgPppeQR0fK61A+PS/THhJAUpzyh7cK?=
 =?us-ascii?Q?hIqXmhmeoR5fVsSLtq+MXhuxv9p2lXBRzZGWc1xrSIFHbTs7bqFBNvU4ZHnC?=
 =?us-ascii?Q?jdpIr1eleLPTMx1FpGpNyMFIJUmmg4/KHpqvW60xSkZ3wI3HBm4ShRMToIyh?=
 =?us-ascii?Q?xNAWDrR/qU0RCGUhKFulhsFp4EX4jEeUz1mS8HTlVxMc/EC4jSVBp6SKEk/4?=
 =?us-ascii?Q?2DzghEaRel3lmxWAiNt4KCI5xloNJY974MqX3sLZ9bfYBPEL9DgyiyVrZXsw?=
 =?us-ascii?Q?IWTXsFMaOK0GxhCapvOtKbzgGranKoPDHr0KURETLbI7VjzDYxhCSO5YYauU?=
 =?us-ascii?Q?Uu5vbXH9qoYekf9qILoKVpZ24AbUoxFstgI6nL7FyljpSybU7U6KtLnAKBPe?=
 =?us-ascii?Q?e8dDOrkk7roD+RlDfl4jUKA8kry5nhGAM3kDuG3Yft5OOhR7JsTw8XQbhHzM?=
 =?us-ascii?Q?eW74Tv+ajx0K6sjCl3STdD2ca8Ys97D9AopJ/yBpOaqhG8rpeR9iEkkm2frW?=
 =?us-ascii?Q?Z58kPfW6X4ZUqomuK2NUnhOR7s7g22T55c9ucOSYMfiCKNM50F6zrW2LBrZm?=
 =?us-ascii?Q?PK5yDReCeGA0b51aqAXDZDVVrUkYmqmvMfj/WR6+DNkR6komTXWb33/b0JPa?=
 =?us-ascii?Q?ZJCNJhDoXAXI8FqdTLDezutVaMnlNd3H3XG8NdSX392gEH2DBm+uiUblsUW/?=
 =?us-ascii?Q?4Qh6brD9JKLHVspP5R6EP7o/gdx96fbnuFLeHO//dQD1w49lBCVCzwWTpbEo?=
 =?us-ascii?Q?x+53TQum0Oz4l4TPS1xv/IBxdR8sE2SkkLVXWxfDrxLHV/3wBTeYaINNwhEh?=
 =?us-ascii?Q?cyRkADjWJtFRe4kztD7HfXKwsWw72UHmUVmo5lthHJs5/iqJpSUtHLVEmWp3?=
 =?us-ascii?Q?H67LXxTWP09Qeg1b/LJFI7/1Zbo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715f9542-a713-478e-27db-08decd507b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 15:44:28.6918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnzVJf8Y/Py01D510GDeiHa020GSgjPL9xi0znB5q+UmhO7JGOdx8wpqAVPFm+Mb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
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

ping

-----Original Message-----
From: Xiaogang.Chen <xiaogang.chen@amd.com>
Sent: Tuesday, June 16, 2026 5:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: Guard m->cp_hqd_eop_control setting by q->e=
op_ring_buffer_size

From: Xiaogang Chen <xiaogang.chen@amd.com>

To prevent getting incorrect m->cp_hqd_eop_control value.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 82f194ea2a21..5f8bf87f475e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -203,8 +203,8 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,
         * more than (EOP entry count - 1) so a queue size of 0x800 dwords
         * is safe, giving a maximum field value of 0xA.
         */
-       m->cp_hqd_eop_control =3D min(0xA,
-               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
);
+       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
+               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
) : 0;
        m->cp_hqd_eop_base_addr_lo =3D
                        lower_32_bits(q->eop_ring_buffer_address >> 8);
        m->cp_hqd_eop_base_addr_hi =3D
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index dff016c9c65c..7506a1410385 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -241,8 +241,8 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,
         * more than (EOP entry count - 1) so a queue size of 0x800 dwords
         * is safe, giving a maximum field value of 0xA.
         */
-       m->cp_hqd_eop_control =3D min(0xA,
-               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
);
+       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
+               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
) : 0;
        m->cp_hqd_eop_base_addr_lo =3D
                        lower_32_bits(q->eop_ring_buffer_address >> 8);
        m->cp_hqd_eop_base_addr_hi =3D
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_mqd_manager_v12.c
index 51dde2c86eb3..f1f923eb0ea5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -216,8 +216,8 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,
         * more than (EOP entry count - 1) so a queue size of 0x800 dwords
         * is safe, giving a maximum field value of 0xA.
         */
-       m->cp_hqd_eop_control =3D min(0xA,
-               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
);
+       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
+               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
) : 0;
        m->cp_hqd_eop_base_addr_lo =3D
                        lower_32_bits(q->eop_ring_buffer_address >> 8);
        m->cp_hqd_eop_base_addr_hi =3D
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 9014912ed82c..a6fff8032dce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -294,8 +294,8 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,
         * more than (EOP entry count - 1) so a queue size of 0x800 dwords
         * is safe, giving a maximum field value of 0xA.
         */
-       m->cp_hqd_eop_control =3D min(0xA,
-               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
);
+       m->cp_hqd_eop_control =3D q->eop_ring_buffer_size ? min(0xA,
+               ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1=
) : 0;
        m->cp_hqd_eop_base_addr_lo =3D
                        lower_32_bits(q->eop_ring_buffer_address >> 8);
        m->cp_hqd_eop_base_addr_hi =3D
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_vi.c
index b3c3833b6874..14b4240de6f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -214,8 +214,8 @@ static void __update_mqd(struct mqd_manager *mm, void *=
mqd,
         * more than (EOP entry count - 1) so a queue size of 0x800 dwords
         * is safe, giving a maximum field value of 0xA.
         */
-       m->cp_hqd_eop_control |=3D min(0xA,
-               order_base_2(q->eop_ring_buffer_size / 4) - 1);
+       m->cp_hqd_eop_control |=3D q->eop_ring_buffer_size ? min(0xA,
+               order_base_2(q->eop_ring_buffer_size / 4) - 1) : 0;
        m->cp_hqd_eop_base_addr_lo =3D
                        lower_32_bits(q->eop_ring_buffer_address >> 8);
        m->cp_hqd_eop_base_addr_hi =3D
--
2.34.1

