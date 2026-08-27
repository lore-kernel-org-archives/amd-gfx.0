Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583D7C61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 16:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C03A410E62E;
	Thu, 27 Aug 2026 16:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MiMpZfGr";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C4210E62E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 16:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igp2k5vzVw4JQdWhIDmvAwlqoKCBYvbBDLhU2cIoK1AqDAbcBytDZG75KAA9DVcXRcxP3sNxj6UCC8BB33ZiCayGMIOlEPR66ww/qk18QDWAXruAJ3g8f30kCDfQtI+RIlfGgc+jCwGmtrjXZV4ZyktGbyAKiWj+ZiPy7v3AFtvL7uGQcb6h6GosTmZLWCvEXJtALbh2EtEMi25OKH2IZw8xXTRE6Fz4kT46YKxvKgTr+Ya/m/Ejqq+vMY63JNCoMg08E1pkiFVUpGV3kAQZBp65KhcuNxeSjd9RqE668P9f12xLGoYrdtg1C45pO+y017ZSJe16nt87nhwQsyT6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDCutofB/DEVQFkbQxMmSVDB+EcxTWEJQtDBJifkIEQ=;
 b=SiwpYvqXD8919K1pWH9f0yqbNN8nUPiKKMIEH0cPBDi8T4VtXTAhAoXRrcgJvxGeO5FNpme2EvT5qAuyWuMyNyOFihNqobnx7vFL0NWKSCKqqWpKtMg0GdqJi+SEHwG+H57h91KVzfRBCtuwyVrTZ+xdsUVLhCVUa7YGIAarLHRkwWVTci2OQrzS8c++oW53pDtgOVxCQ7IDi3kMI8UDBRsMv7P3eHJ02DeKfYhULUETPKpsFh+3XiOaajhkkjox4wTSHdsSAYSiTmR/IySP323cGyHn22qliVzfyOL3xwxoHw+Qv5/V/8mK6e9OmOgZ9y1a5ipKCsCUHFVMx9WdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDCutofB/DEVQFkbQxMmSVDB+EcxTWEJQtDBJifkIEQ=;
 b=MiMpZfGr/f/aM53NgzLubYasAfNqVWFCsTu5RRzQ2AVZZ+X05J4rCjjRYAclAWuoXYQ3TTqR9kjiAGiIerDVs68AKur4CqWM/hRRbbK+6xsjS19eyjugQCqGPWSGQw1QGOSXPk8zUCPWSmozhXX93/PNR+6Xu0bUrXhTGuEOfpc=
Received: from MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 16:27:33 +0000
Received: from MN6PR12MB8590.namprd12.prod.outlook.com
 ([fe80::ac74:86e4:cd33:432f]) by MN6PR12MB8590.namprd12.prod.outlook.com
 ([fe80::ac74:86e4:cd33:432f%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 16:27:33 +0000
From: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Enable SDMA queue oversubscription for GFX
 12.0.x
Thread-Topic: [PATCH] drm/amdkfd: Enable SDMA queue oversubscription for GFX
 12.0.x
Thread-Index: AQHdMLmtPxX7GggsHUWP2H1dJzv5ErayIFAg
Date: Thu, 27 Aug 2026 16:27:33 +0000
Message-ID: <MN6PR12MB85901310CE38E0B747AC704BFBAD2@MN6PR12MB8590.namprd12.prod.outlook.com>
References: <20260820153609.2264412-1-Sreekant.Somasekharan@amd.com>
In-Reply-To: <20260820153609.2264412-1-Sreekant.Somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-27T16:26:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8590:EE_|LV2PR12MB6016:EE_
x-ms-office365-filtering-correlation-id: da89b0fa-3ace-40bc-b5d2-08df04581927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: c4j8ddH0QHfyGns8N7waJHgPFYuA1IAOg1GiPSJ9wYLqKMNlz2w3TDLILtBoymXpRtq9EH7Z39w4C5lsMio0ws8xaMNH51Mz/vmkOUGq7Z5cDDdIaCTqL+ZQCf3F3DunwEtQpKjoU9L/RNvuAnlKSRx9Jcn18R+mKrsG3YpCA5dO6Jz2WEmY5gL8aU/9UwS889eIIN5zBZHtD+Nqh9cEApD257uVWpegEorcsTdHYPTNmm5ULzG1XgDQAlW6pCwhwe2cAqE6JGiJ0pT3YEGT6duZmRXYj/Xc6OP18gDx2bRuBE/zCAeJd3vXG6sYpnywIUDIEeHVLACwiLC4vaKY88GJ0JEBrGZ8meldY4Azv/hBPJUR0L5NQu6s+8gQk/Yd+B5Ve4Pby5q335CHqX+cwO0VwXF+ojn4XJ7nNv/fqXXF3kNEMBbRlk45ZjP1FijNROVJARYdKxKVRwIOHZALVGyloVd2XEhGBb/Ma5AAwCoaJ7koqs766g784bnSfkiZoo2C6opiuj/0upYAOMUp63OH3jJ509YbLHLcX11S8saKBwmd9GbC4EjShy/sjZL544HxFXkCh+ZG1maw7/NyfoD8/Ki5KmD3eGerl2Qyfr9eg5EecNAVPakQyHYnw6ZAZ4YUJAlVI+UoT+gE+/z3Iie3KvHNL8KzDTeeZw5We5B20rzCkiWumbbHO/odL/Q2cM6bNacaaSkkgnpX4hasnTGsM0IlIfh0OpUSLGBOJzU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8590.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2C34ADu+9GfehToq8nLB80ml0jteVJNVTisMAv8QHsL4QdiW4U74UaYQeQ10?=
 =?us-ascii?Q?3hiAS6EycQU+pCWnh4b4knpf3iYmSt97l6SLL/AWRb5XZv5hVc8h4e8FGc+y?=
 =?us-ascii?Q?J7ds4uC9eUGUHkjzEThrjDQDa69HHvfJ719WvwUly0aKTTnzGMkFBJm+dGpX?=
 =?us-ascii?Q?3fNV+5syekk1EjUL17qDPbfUNtxJ/6MaYLj6c6OrQzjPHJsTGkmgo8tFwZY1?=
 =?us-ascii?Q?84A4wak0y/qEmvQH4iLLhBoFhXO2j96h0xdSMEv0F4IYRh47EtyPIn/Z7nKm?=
 =?us-ascii?Q?hTEFbMpSHoS/PH2glqhjoc6uutCo/b8iF0oGjghF1mXunGuSdEwN9OfGw6OP?=
 =?us-ascii?Q?lcO6EHQsxQt73s3OBXyPajQz9jw6VUl7rXrZyaGcKfw+7l8YXvNR4kLPUv/K?=
 =?us-ascii?Q?r5ImYhu0JR6TKhUF2Kzx9wYqlfjUhNHamOJmigNeibwbZNogvHwe75/zFQYE?=
 =?us-ascii?Q?4e0iWGx0w8Kp5HLRnEiP7iSDZ6VEn8Hge6BeARlNgCN/p/LVpqBdCLE6oCH7?=
 =?us-ascii?Q?8dT8qMVmdbHYVc9fgXmwcDMRt//p2+R29BubGOx7mtzl9FcF8gae0XXlKXt3?=
 =?us-ascii?Q?jbNOe+duLR7ZIWw14/GVlC8kCTvwOG7QWjWvh7vMjl4zDqDU7ffVsQd2rywB?=
 =?us-ascii?Q?W5FjuWbJTpDc43Bvup5U3YDOH2Ruv7rkze/v06paS9sHQt6ITlPaxaXlVjDz?=
 =?us-ascii?Q?N4abkY1G5ZnHhULSi7lrgjfqn88Cv7cdaGhOJLUuewWxTsixvDguQKD2I7xc?=
 =?us-ascii?Q?r9jOq3tikuIdJgv9PuwqSzJI/QIxGMTqJdK8TxwcP9jYvDYgkp89qO9dfSxm?=
 =?us-ascii?Q?w2hGDm6sr8gA95T6l3PzMpaliHjrPMSjxRBMhVx/avbjkS5UawEzSUZyhc1W?=
 =?us-ascii?Q?FzZ886KJB9Wg1mCDP1oa4dOiyxSbRAZGjkpqoOkKtMSt+9iUh4WDIsuoPhhk?=
 =?us-ascii?Q?UuEMtRVrC1MkB8LCXBfvWJCz5FCON8ySMjSFSauP2QcWjWs+dSnaoc3H+J3A?=
 =?us-ascii?Q?QLyZyLS1/cSut5jhURyNEn+0uxxRS1IQrk+pObOYYnh5J+F0GjBcZ4Zx2M2s?=
 =?us-ascii?Q?m2IK0kP907YqmHBzV10eHjJxAb2nvbpfI62Zu67ShuzTu97PgJsrYgidFmLB?=
 =?us-ascii?Q?KOv+bPia5JRsb0nJA6rObdmN6uRk883Tv238gEBh7rgM/4YdIurbCSrG6Xk5?=
 =?us-ascii?Q?dtbfVdflgNrfyw+UaH1CqrkSnVW0K+AjKY1kIo1XyJ19y9GkJiY/VILEPOTe?=
 =?us-ascii?Q?GqWJSaCHdtmwxDpUtsghEn3rqnlLs5k5HEd6dPs8YO94HpOsxzhIOs0SLkUB?=
 =?us-ascii?Q?WaPmoVWKEN675wSa7uBupRZmqc2cvhYIJSY+EIdbGEu69EKT5y+LIb46U7Gn?=
 =?us-ascii?Q?gmZx11cUODpbz/Ca13/XoJ7hE2DLApxZyuu//t1tT7sPvyNZQw6O0+ZLPxfV?=
 =?us-ascii?Q?X4xSxQr+4z6Nh3/mj4Tmn7Sz35os64jQW7g1NR0a4LzPX0RxzkNbCOY6t0x8?=
 =?us-ascii?Q?ClJfmE7guGN5BdfiAEoz5cHu7M95GN5k2jDrIerLySAY0pJ1yAC3+2JIbaNu?=
 =?us-ascii?Q?bRkxMNw7+/wg+p1UrJ/SmeIgbIJWgopUI0GWHbAzbiT9LtejR/NJd5AySO1j?=
 =?us-ascii?Q?D4HP0RFm2qoYnWrCExZSo9YI4syXsWIMetNERWpDsAtWCooybYEJI0Zbja/U?=
 =?us-ascii?Q?uMiWcxkhFYafU9RAaVhUDXMl4SSYeXb/85fYMcIv4uXpgfVJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8590.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da89b0fa-3ace-40bc-b5d2-08df04581927
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 16:27:33.5041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FVEgxleGFY4t5thYwNKMmN1EdsWC2obp1yKKpkPcY5JWtUyVYBm5vUB819fiLSroBGwx5U78xTT3kGAnx1iww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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

Regards,

-Sreekant


-----Original Message-----
From: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
Sent: August 20, 2026 11:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Somasekharan,=
 Sreekant <Sreekant.Somasekharan@amd.com>
Subject: [PATCH] drm/amdkfd: Enable SDMA queue oversubscription for GFX 12.=
0.x

When all HW SDMA slots are exhausted on GFX 12.0.x with MES enabled, allow =
new queues to reuse HW queue IDs round-robin via a dedicated monotonic roto=
r. Each oversubscribed queue gets a unique doorbell from the per-process bi=
tmap pool so MES can multiplex them independently.

Normal SDMA queues and all other GPU generations are unaffected.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 54 +++++++++++++++----  ..=
./drm/amd/amdkfd/kfd_device_queue_manager.h |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..10a672b87ca5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -556,8 +556,9 @@ static int allocate_doorbell(struct qcm_process_device =
*qpd,
                        return -EINVAL;

                q->doorbell_id =3D q->properties.queue_id;
-       } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA ||
-                       q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)=
 {
+       } else if ((q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA ||
+                       q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)=
 &&
+                       !q->properties.is_oversubscribed) {
                /* For SDMA queues on SOC15 with 8-byte doorbell, use stati=
c
                 * doorbell assignments based on the engine and queue id.
                 * The doobell index distance between RLC (2*i) and (2*i+1)=
 @@ -583,7 +584,10 @@ static int allocate_doorbell(struct qcm_process_devic=
e *qpd,
                        return -EINVAL;
                q->doorbell_id =3D valid_id;
        } else {
-               /* For CP queues on SOC15 */
+               /* For CP queues on SOC15, and oversubscribed SDMA queues w=
hich
+                * reuse HW queue ids and so need a unique doorbell allocat=
ed
+                * from the per-process bitmap pool.
+                */
                if (restore_id) {
                        if (*restore_id >=3D KFD_MAX_NUM_OF_QUEUES_PER_PROC=
ESS)
                                return -EINVAL;
@@ -621,9 +625,14 @@ static void deallocate_doorbell(struct qcm_process_dev=
ice *qpd,
        unsigned int old;
        struct kfd_node *dev =3D qpd->dqm->dev;

+       /* Oversubscribed SDMA queues allocate a doorbell from the bitmap p=
ool
+        * (like CP queues), so they must be freed; normal SDMA queues use
+        * static doorbell assignments and must not be.
+        */
        if (!KFD_IS_SOC15(dev) ||
-           q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA ||
-           q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI)
+           ((q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA ||
+             q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) &&
+            !q->properties.is_oversubscribed))
                return;

        old =3D test_and_clear_bit(q->doorbell_id, qpd->doorbell_bitmap); @=
@ -1800,15 +1809,33 @@ static int allocate_sdma_queue(struct device_queue_m=
anager *dqm,  {
        struct device *dev =3D dqm->dev->adev->dev;
        int bit;
+       bool is_oversubscribed =3D false;

        if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
                if (bitmap_empty(dqm->sdma_bitmap, get_num_sdma_queues(dqm)=
)) {
-                       dev_warn(dev, "No more SDMA queue to allocate (%d t=
otal queues)\n",
-                                get_num_sdma_queues(dqm));
-                       return -ENOMEM;
-               }
+                       /* All HW queues are busy. On GFX 12.0.x under MES,
+                        * oversubscribe by reusing a HW queue id round-rob=
in;
+                        * MES multiplexes the SW queues via their unique
+                        * doorbells. The non-MES HWS runlist path cannot e=
xpress
+                        * duplicate sdma_ids, so it still fails with -ENOM=
EM.
+                        */
+                       unsigned int num_reserved, num_available;
+
+                       if (KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0)=
 ||
+                           KFD_GC_VERSION(dqm->dev) >=3D IP_VERSION(12, 1,=
 0) ||
+                           !dqm->dev->kfd->shared_resources.enable_mes) {
+                               dev_warn(dev, "No more SDMA queue to alloca=
te (%d total queues)\n",
+                                        get_num_sdma_queues(dqm));
+                               return -ENOMEM;
+                       }

-               if (restore_sdma_id) {
+                       num_reserved =3D kfd_get_num_sdma_engines(dqm->dev)=
 *
+                               dqm->dev->kfd->device_info.num_reserved_sdm=
a_queues_per_engine;
+                       num_available =3D get_num_sdma_queues(dqm) - num_re=
served;
+                       q->sdma_id =3D num_reserved +
+                               dqm->sdma_oversub_rotor++ % num_available;
+                       is_oversubscribed =3D true;
+               } else if (restore_sdma_id) {
                        if (*restore_sdma_id >=3D get_num_sdma_queues(dqm))
                                return -EINVAL;

@@ -1901,6 +1928,7 @@ static int allocate_sdma_queue(struct device_queue_ma=
nager *dqm,
                        return -ENOMEM;
                }
        }
+       q->properties.is_oversubscribed =3D is_oversubscribed;

        pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
        pr_debug("SDMA queue id: %d\n", q->properties.sdma_queue_id); @@ -1=
914,7 +1942,11 @@ static void deallocate_sdma_queue(struct device_queue_man=
ager *dqm,
        if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA) {
                if (q->sdma_id >=3D get_num_sdma_queues(dqm))
                        return;
-               set_bit(q->sdma_id, dqm->sdma_bitmap);
+               /* Don't return oversubscribed queue IDs to bitmap.
+                * They are shared by multiple queues and managed via round=
-robin.
+                */
+               if (!q->properties.is_oversubscribed)
+                       set_bit(q->sdma_id, dqm->sdma_bitmap);
        } else if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_XGMI) {
                if (q->sdma_id >=3D get_num_xgmi_sdma_queues(dqm))
                        return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c9f9f7a87111..81626e657055 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -255,6 +255,10 @@ struct device_queue_manager {
        unsigned int            gws_queue_count;
        unsigned int            total_queue_count;
        unsigned int            next_pipe_to_allocate;
+       /* Monotonically increasing counter used to round-robin oversubscri=
bed
+        * SDMA queues across the available HW queue slots.
+        */
+       unsigned int            sdma_oversub_rotor;
        unsigned int            *allocated_queues;
        DECLARE_BITMAP(sdma_bitmap, KFD_MAX_SDMA_QUEUES);
        DECLARE_BITMAP(xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES); diff --git a=
/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_pri=
v.h
index d8631847f0eb..5fff5e55fb09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -531,6 +531,7 @@ struct queue_properties {
        bool is_dbg_wa;
        bool is_user_cu_masked;
        bool is_reset;
+       bool is_oversubscribed;
        /* Not relevant for user mode queues in cp scheduling */
        unsigned int vmid;
        /* Relevant only for sdma queues*/
--
2.43.0

