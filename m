Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4EAC5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 21:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEA710E92B;
	Tue,  3 Jun 2025 21:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z1/e8uYW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC10010E92B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 21:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b14dVAQpwnwwd/AzSfomWnHmUzGS3CoEl3xl4JDerFk3opkKbTs2CWGc117HrYezVOk8ZwKBaVZa3P9ZI6f6J7LDf9ge8ArQMB8PsWWh/8Y2gB38OSKUKCvUa334Th/FhflaKa69nRX5VHhDxmQBUTqBbnpnhH7NKrtIk0AcZquamOhTwT58QpzRaXy/soVrnX13J7KSN0O13yI+E9RzRqUwFmacGSOga+n+y4soc4SXcOmqBOUdsKdZ0pxNLEhVfKA1z3HQaRIcJGRz+h5FEQxKDW+2JYNRKLxkXCqKO9G4NaKE02xH7G6bI44VQfGDeBiVLr+HU/99Py66Eq0Agg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHxvyxmYPCyYjpxn1b/LyxEstDtcdv2FfnlrYo6fkTs=;
 b=LEtMfBDyr/5ew61Hk77zPXvT84K6V7nXO+2YtF6nl93TWGsk1Z1pScCyuPxV6P9p9CuzAP/MFTolibj1lZwMRyTOiPgc3MZK9LjybSQrozMP/TQ0G8dcT/GhKAp9v6zRqQRb3lc7k2lQfRY9L8p6rcaAUh/iURtQVQGLmfMvSKtq0ibsyQ+OOpnI9BdONmKtPdcJ8hkmIxfQuBJe6oefcMKxInkW6dW0vqIRdYcpDCpq6By8lvJjS0WquzaPK5Nwis5lIs0SG0wRTFD1jILTCfiYhEEFmkPn5OdcOpEaWqmru/IV7ntRDzLhPmp2GidEH9M2pBVFHEBWormdJOd02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHxvyxmYPCyYjpxn1b/LyxEstDtcdv2FfnlrYo6fkTs=;
 b=z1/e8uYWZTneKaDM02CY2EkPTDQQ18+WrlHq1fKzQYzCXELtSyEc3/OISyX4Q72JyCK9b9IVm3JWxlxfbPfjgLKPDhDgyOdxtJ5mwpyV6Ewk+egqnMeviDpes/UGk6U+O6+XRQ6Yknrcs/72agqZUkpAeqatFOt/TyUvD2j5ocA=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by CH1PR12MB9695.namprd12.prod.outlook.com (2603:10b6:610:2af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 21:22:20 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%5]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 21:22:20 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix mes based process evictions
Thread-Topic: [PATCH] drm/amdkfd: fix mes based process evictions
Thread-Index: AQHb1KS+Ju5kThIF60yiWrGeJWwnTbPx8Fdw
Date: Tue, 3 Jun 2025 21:22:20 +0000
Message-ID: <CY8PR12MB7099B08A13F18F0E620123B38C6DA@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250603162934.154349-1-jonathan.kim@amd.com>
In-Reply-To: <20250603162934.154349-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5d511c5a-f9c5-47a9-88e5-131e2d391373;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-03T21:16:58Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|CH1PR12MB9695:EE_
x-ms-office365-filtering-correlation-id: e27fdaec-9bb1-4d4c-7fdf-08dda2e4b947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rFzRDYGRT+aQiJaBtEvPr4pF4+J+G2Qya0FGBuqFOAOeRcPVSzAZkoV6B5Tu?=
 =?us-ascii?Q?1zvd+N/lkTJNMBSPl08jCd3M6z/hskOTAzoUrQiZ3OQ4oywQMkyAUuk+JIZy?=
 =?us-ascii?Q?AKsC3G6jaDlgvQyxaQ5vJhGWukw9TOvLmHFViCFhq/6eEE9WoW3KcSH3jyxv?=
 =?us-ascii?Q?gnuQ9sO0vAVaPPk+Toy+cybU0hwoXz23rz9/ntimGk7ZYp77dpL9RPkaGi72?=
 =?us-ascii?Q?zAayvJ52EilOIkvDMjxIoYOyHSl0QwLfvwesu81EuUcuR1M8CYckvkpyj2vL?=
 =?us-ascii?Q?izEyD7WOq0LZch7N8pQgkLdBGV09Y0FdSHoJxxghNX0DjjtgmIlxkRvwlZ25?=
 =?us-ascii?Q?6e1wBtG+Z+hk63ZrtI0oC1yVCD+Fh11ZXhDd+D5o3nKalROnzqYxbYz/S6g1?=
 =?us-ascii?Q?rZDBqNn5NCvN/rVO2fDjeN7ltUO2L+5Hm4/b6MBhZPimmqZ2/RIjSlaOFkhQ?=
 =?us-ascii?Q?3231ChnHBs31TZExn2DOxyWoAOFEoByA1pGYvbStWkuO8DrXNqyd+GXH2wKA?=
 =?us-ascii?Q?5n/MqP+VOaUMz8lR1QL2VLbw52AJ6miw8O2YZRH8ec2l8MU0yVzpMr38XIl8?=
 =?us-ascii?Q?xdUVXk5sfZgSTtEYWQ7ndnpchA362S4HzHvZ6Q6PwfuXlDAGh6GN5a8RXjnk?=
 =?us-ascii?Q?P86gs+oFK2My/tsCWW1UmpxteO90DzGYavOivfxaDsD85TxZkLmcX3/Gffku?=
 =?us-ascii?Q?t6byuZxW5nwQ2JPNBb0e0g++j692A2V5U7uIzJTfytltgrfV2yteTbm25Ymt?=
 =?us-ascii?Q?Xp2zbL1uq2A4IlKP/I3vZH/PyH9ufzXAMF7B3yaxCREXUcZvJqhlszSPseTT?=
 =?us-ascii?Q?PIMmJQaE0JOpDynmuOUcH24z7sNErTK7RKGmK3WaY4WKdxpzY/HD6JD1/9/v?=
 =?us-ascii?Q?Q+09tmTzkwDp1iNGEIAPdfOWiknKSy/rZy24YJUdB/bqUJ9FeliCgMER30W1?=
 =?us-ascii?Q?HTmYxzX7KaRTcnATxTd/qg4M7T7lWp+4dHuptyAxVooAaukfhBFWNcKncMg4?=
 =?us-ascii?Q?mQVUcXJk630M1Nz8UHjc6oyefe3+1HtWWfcjV9hyKE90MRTth3vqsyxF3eE9?=
 =?us-ascii?Q?PSPPKM1mb5oG1k9uRLbl0hheeM13gp83qZjGkcFIchk7AZg26HSrp459HLQs?=
 =?us-ascii?Q?rX2orqmLJuWqQFN2Pl7CunZjarHitfm9DXD58hJgwiH2bxCjCfecYb7Lc6Y2?=
 =?us-ascii?Q?fFtTdVhQYumP4scTZeRU+6iSdTWCaikNR8IQ+NMgAOf6+dSjTaW+9tTG6yz5?=
 =?us-ascii?Q?AtcDM5uF7kWUDdhfmaQvi1h1CBqlYf95T8+JhNxi2l22cPMyZXlAIMrLzKBo?=
 =?us-ascii?Q?4xOazPbkOCJGkD1CBWOTOoVyP8DtV7wKCDZRg8MErQaHSmTrtCtXFHxESfwI?=
 =?us-ascii?Q?TEB+WFLd+tiBtexJiIKfMMKIemwkLlDNvIBqcY19lcseC1LiM+28lE9KAF9o?=
 =?us-ascii?Q?RFxA6E4uM0GxM7vxr5RVCTO0XLU0sTMoBtJYTayyUyhjbEYgE+HKHep/BaQD?=
 =?us-ascii?Q?CeDbIPoIsKepRQU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qms0WP5iTVWWc6tEVglcp09NyZLJm+SFJQtt9lVdOv62MKuccfQTCZV8G9Js?=
 =?us-ascii?Q?udYNmkkK71UABxW8vnpUpfjaLd3XjlxDd6DeOnwbQ5sDzisykOYQSwbXp8JY?=
 =?us-ascii?Q?Mrzl5mU1gBItvORQdIq+Tux51+YWyyGwpVRIzYqcPpqJbQXYavdvOlty25Pz?=
 =?us-ascii?Q?MUO1sNeLGbD7ZoxsBfh2f3UUV/72fP8gClUKD7zdRowmiFogg6BiJNWIxjR5?=
 =?us-ascii?Q?pnnHVEUSO1cMS5DgB3a7xEOO1KMejiH8Hm5mPGlrkscVu3vPnKT0z7TWn3UU?=
 =?us-ascii?Q?CSLOuU2lUo4qq/W++mhSnUWhuTSikik5lPpkJnvlIcrd6IA43bsYVj/K8yXq?=
 =?us-ascii?Q?sGtw/b9ZI3Hakzv3LDZmvzydTEi34V1e+cs5FKuPHY/cnZZeRIFGYs6+0BE1?=
 =?us-ascii?Q?wYpnzOEjgPKVrtDwkpGL88r38AiuSqOcz/mBCGAMNMQ28cULfdsiGnjQS2/X?=
 =?us-ascii?Q?Gz2mxXkutSe219VDlUh/ZiQz1FIyqa1PQLqIbdQ0frF0YOoZTO8Km1bHMrkr?=
 =?us-ascii?Q?K2m66VzE6ihmDg1BxyG05vCh8hyNNfBvB/Pqe0AGEkAw5z6DhZU5uq43GEj9?=
 =?us-ascii?Q?W5EmWeyUS1SCYdKpXB4oNmGhS6i3j9uA0dV37geJDKJB1yxYz+2eEuOocCei?=
 =?us-ascii?Q?mN+8w3/9ftTkSoZRLgaINGOVjl7Hzthk63gXxI2Cbf6WrBK1p4KVdm4Nj9uU?=
 =?us-ascii?Q?RL22yxUoLeNGit3nKrs5h9/4+CwM138KyZ/SpqUsE64rwIMIdwvqa0fOCgw/?=
 =?us-ascii?Q?8QHUHOFTEPbEz5sLW4qg8nvp6/KcKfS3EvnayfBnTZ+SkfUdQtqf2rRxFMHR?=
 =?us-ascii?Q?f2Y193g/DW8wvs37AkVighEPj3p1uwXC2/viIm1dF72nuAOnYisM51VYJfB6?=
 =?us-ascii?Q?QJq597nakMHKOIQTS+WHIHK8CD+WF1RKJz6Y2lI3CAIB8qsxLxgeZRN6GVkf?=
 =?us-ascii?Q?VHZw1GAkYGupISleMo1siHcWzrWgYAkDtF7xCbOwaTrr/18lA6hlo7pdsfyw?=
 =?us-ascii?Q?AaluCSJz51JvGLTqu7i8ihlDjVkhc7dI0Spk9CoENHk9qFluGYQwpbjywv2y?=
 =?us-ascii?Q?8MXbIebYYKuGMkOqzcUM8kaN9nAHygirp8ypVKwlH1/zAyhmso7Qd+CveUBJ?=
 =?us-ascii?Q?FuistXhAMznQrI7bGhJz5MmBwXUQG5W9TlHOW9OtaOjHntooixe6wH58i3QQ?=
 =?us-ascii?Q?czxh4fkaFQHOvYU+FEO3wikYaWPiuZsezapa9Eanjmb8ioErpVBrmgZ5cWJD?=
 =?us-ascii?Q?KvS7wX/ansGh5+fWdylCEFgNPS773efoxNfAqO2spMJ2LLcLr0Kz/ls3EIkm?=
 =?us-ascii?Q?NnZ2QSZWtNuIVui8hfSCv0NVSC1AfBC8cTXPpkB1N55BiiYcvVwx/Lz0VXYV?=
 =?us-ascii?Q?vyEgtoyj8ai5VSZMMr72d3NqpVXQ+FzbNj090GwxhDSWBuu2yBkqxO5ulBfT?=
 =?us-ascii?Q?59+PzDIl9ySdhSMbfO+LbpMiAztDcG/mnutKiUQHuB4CewOGpc4lGxRFjI7R?=
 =?us-ascii?Q?P42b7lihY2Mp9jABZb0epNQG7boB7c0p6pU+3qQlwVO+wSMCYjk993LDyeZe?=
 =?us-ascii?Q?hyCk3/5d7ncRnRYXscE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27fdaec-9bb1-4d4c-7fdf-08dda2e4b947
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 21:22:20.0974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbGrth6/jyjPMkvA06g0Sv/Ob2XZ/yFiNm4liWph4P3S/fQgjmIAiFq+ghmMlj1PfmCTMFMG8nYcDHWJRp0FgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9695
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

[Public]

So, the code now loops two times over the list of queues. Couple of questio=
ns.

(1) Isn't it possible to call suspend_all_queues_mes(dqm) before the first =
list_for_each_entry()? The first loop only does some housekeeping. That way=
 you can still do get away with single loop.
(2) Also remove_queue_mes() is called for inactive queues (q->properties.is=
_active). Is that intentional?

Best Regards,
Harish



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jonathan=
 Kim
Sent: Tuesday, June 3, 2025 12:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul <Mukul.Joshi@amd=
.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix mes based process evictions

First, MES suspend/resume calls should be consistently held under the
KFD device lock (similar to queue invalidation) so consolidate
MES based eviction logic with F32 HWS based eviction logic.

Second, save the last eviction timestamp prior to current eviction to
align with F32 HWS timestamp logging behaviour.

Finally, bail early on failure to remove a single queue as something
has gone really wrong post-suspend and a GPU reset is going to occur
anyway so it's more efficient to just release the device lock.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 73 +++++--------------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a..c1f0207eeb9e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1219,25 +1219,36 @@ static int evict_process_queues_cpsch(struct device=
_queue_manager *dqm,

                q->properties.is_active =3D false;
                decrement_queue_count(dqm, qpd, q);
+       }

-               if (dqm->dev->kfd->shared_resources.enable_mes) {
-                       int err;
+       pdd->last_evict_timestamp =3D get_jiffies_64();
+
+       if (dqm->dev->kfd->shared_resources.enable_mes) {
+               retval =3D suspend_all_queues_mes(dqm);
+               if (retval) {
+                       dev_err(dev, "Suspending all queues failed");
+                       goto out;
+               }

-                       err =3D remove_queue_mes(dqm, q, qpd);
-                       if (err) {
+               list_for_each_entry(q, &qpd->queues_list, list) {
+                       retval =3D remove_queue_mes(dqm, q, qpd);
+                       if (retval) {
                                dev_err(dev, "Failed to evict queue %d\n",
                                        q->properties.queue_id);
-                               retval =3D err;
+                               goto out;
                        }
                }
-       }
-       pdd->last_evict_timestamp =3D get_jiffies_64();
-       if (!dqm->dev->kfd->shared_resources.enable_mes)
+
+               retval =3D resume_all_queues_mes(dqm);
+               if (retval)
+                       dev_err(dev, "Resuming all queues failed");
+       } else {
                retval =3D execute_queues_cpsch(dqm,
                                              qpd->is_debug ?
                                              KFD_UNMAP_QUEUES_FILTER_ALL_Q=
UEUES :
                                              KFD_UNMAP_QUEUES_FILTER_DYNAM=
IC_QUEUES, 0,
                                              USE_DEFAULT_GRACE_PERIOD);
+       }

 out:
        dqm_unlock(dqm);
@@ -3089,61 +3100,17 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *=
knode, u32 pasid, u32 doorbel
        return ret;
 }

-static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
-                                  struct qcm_process_device *qpd)
-{
-       struct device *dev =3D dqm->dev->adev->dev;
-       int ret =3D 0;
-
-       /* Check if process is already evicted */
-       dqm_lock(dqm);
-       if (qpd->evicted) {
-               /* Increment the evicted count to make sure the
-                * process stays evicted before its terminated.
-                */
-               qpd->evicted++;
-               dqm_unlock(dqm);
-               goto out;
-       }
-       dqm_unlock(dqm);
-
-       ret =3D suspend_all_queues_mes(dqm);
-       if (ret) {
-               dev_err(dev, "Suspending all queues failed");
-               goto out;
-       }
-
-       ret =3D dqm->ops.evict_process_queues(dqm, qpd);
-       if (ret) {
-               dev_err(dev, "Evicting process queues failed");
-               goto out;
-       }
-
-       ret =3D resume_all_queues_mes(dqm);
-       if (ret)
-               dev_err(dev, "Resuming all queues failed");
-
-out:
-       return ret;
-}
-
 int kfd_evict_process_device(struct kfd_process_device *pdd)
 {
        struct device_queue_manager *dqm;
        struct kfd_process *p;
-       int ret =3D 0;

        p =3D pdd->process;
        dqm =3D pdd->dev->dqm;

        WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);

-       if (dqm->dev->kfd->shared_resources.enable_mes)
-               ret =3D kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
-       else
-               ret =3D dqm->ops.evict_process_queues(dqm, &pdd->qpd);
-
-       return ret;
+       return dqm->ops.evict_process_queues(dqm, &pdd->qpd);
 }

 int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
--
2.34.1

