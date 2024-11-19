Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7122D60D0B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 02:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8DF10E027;
	Tue, 19 Nov 2024 02:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3QlxhY06";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9B310E027
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 02:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEaYtPicsL4hkrNtG4nIlnZ4qRTW6q8vG6HqOsVG5TWJYhUzYwqpL4ZyV7g7yMNb0HTSjlQQStjfPQHFOQ1O27pH5HQoJEvPX9n0kKVI7y4TovPqoi1EdH0fbco67p4hpMeI+C2Vw3Ds1Yjto0KhvAWHdk6R/uD200BxfMrt7HxLgrrzw+s0wm8xM4L6y7wfyH1Nrf64smwChRZLrHQ5cRuSO6gr2cqorpq250/OL9My9AGW8G5rxpbZDDauqQfvUpN0//yDbXSQoafqgehpu6QSiENQitjGLvDnDAX0yoPpKR7EnDc0OMFaIc5uLcXKUAFGhIjxfM5jBfCVTYpvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZNwwR83fIePIo9XsGCjrf2GtFCroO5yoXEYosAbJxA=;
 b=zPCVz8ePkmaHoX8PUgnsEDQ8Q7pY1l5gEracpwNGkUm7jdjI5sQcVIF++pVbRUpWy8nIBDBEabtugVCN+CaQ0m9tZlMdi3jJqHzSl0+4pL4UtKkrZpZlREkGm+Ui4HYkUy94/JzQS0D6s+f81esB6QCQro8FjYTHZI6d1fqfc0aDTu+/vD+Mc6WY6s9uyPR1QINp5vGvRDdNkeZx7GOyNvFFfBv9fe6xSfFEhhRuV6XDKK1EdOvK187iBM+gG2h9mOsU7U2mv1SxqXYnd3NpaxU6TYgcnRziIWc5QTV7eWiAx8w5GLvA0Xlz1Tz/u/PmbygQZVU9Wz5l/E/7OxgtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZNwwR83fIePIo9XsGCjrf2GtFCroO5yoXEYosAbJxA=;
 b=3QlxhY06jSD6z6DY2SDxbVUxPTbvNHauRLxxfBUOAwNsrz9YIZR7x5d6Kt5+sYYZ26xjp+Eh12PxyyRebT87IeT02qed5FUOc2hcXB66XhyxKRDH5hIG2d/Hz8hVqCKAE3w4MaSJDfkfXCkq6Q5r89IG7TZ7OzpCaY5XChSWMOI=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 02:43:20 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%6]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 02:43:20 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Differentiate logging message for driver
 oversubscription
Thread-Topic: [PATCH v2] drm/amdkfd: Differentiate logging message for driver
 oversubscription
Thread-Index: AQHbNS/dKcHmyacfB0aWjoxWk4/fhbK97guQ
Date: Tue, 19 Nov 2024 02:43:20 +0000
Message-ID: <CY8PR12MB7099404D7477689CE0AD61498C202@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20241112182549.88964-1-xiaogang.chen@amd.com>
In-Reply-To: <20241112182549.88964-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7beb22c1-76fa-44e2-9455-dab7cf98d202;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-19T02:39:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|LV8PR12MB9408:EE_
x-ms-office365-filtering-correlation-id: 9214a4a9-5b0f-4195-df57-08dd0843eded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6mHqCp+PxZiizsAdXJCEN+LITxnjOinqZt38tQFVRzTN+SNHaCVcSrL4GP2C?=
 =?us-ascii?Q?G6Irh+kEqbd1O+NW/eGBT0WlizvvmnG9+kA1XNVG22nNhXdiUbIiz0ZGZqI0?=
 =?us-ascii?Q?wI+wx81TTLsPTRDJnC8oWGkFsp2hCMaSdBalDzNfmSP0xWx0CmUC5d8Vbk0R?=
 =?us-ascii?Q?vpdLa42ZTEi+oJZqPomrsG67Ul6qG9ucczakkkGbfehX6YobKgCDZHmi3jye?=
 =?us-ascii?Q?HLTSlMDxNY/5pe051h6fEQyupR2jvijAPM8L0tDftQTpE0X5kf1LJtuPXWKe?=
 =?us-ascii?Q?vEwyDo2y5I1jiggMUVQUBkEp6YM3MQ2f9tCcyZgQvbvqOrAXAo0mQ54/cPnA?=
 =?us-ascii?Q?kQ3hdwSmcZzV//5ujCfiqJXPXutxelxy+BzOS/9N6nxfwKVZlRLYVdnRqSVZ?=
 =?us-ascii?Q?tGqggAafggg+KUjEdXd333CGKiDXQLfvAg8+3k8NOFBBDaQg1Nc8oTuWQG1H?=
 =?us-ascii?Q?S+yF73kBmq2oOSqqaRCwhcelEGUSoXtiVURNwBVGul9cTu0J5MY01smhH4p7?=
 =?us-ascii?Q?J7atnj2bwzFxtVK7Im0Q1qNlwYmk2lItMuaT/lYrEx8uKM1UUSXyxgx9xLEI?=
 =?us-ascii?Q?QDuTJg34J5PYDi/fR5WBS7FmzA121RS1yftN1ItlX68JLjw7xD9VAmA6XC+8?=
 =?us-ascii?Q?VIiQvEeIrv0BfRHuHJCGOzORYArwpAoFwmw380/Ia611VGcPI4GNXYJLrvtf?=
 =?us-ascii?Q?md4xmd14TX9PlUVcR8pOXgYUD9XNK+PsyDgauKOeIzqERQJiiSIDCwY4A2Gd?=
 =?us-ascii?Q?HIleQDgwOspa6Qy3syU2uZ0UiT8y8aixlaEV5zre+SM8sAo+S4jDJWx2wcQT?=
 =?us-ascii?Q?VDIsJR/M+Gv7q6plz03tI0fQI481CQhQDo7T8+YXtVDtaCCjcGZbj9EKUAge?=
 =?us-ascii?Q?SImuFnScjxNqrcWBmqD0v6euTAjKxQZ1EVAHmBRHOO6G/5XbA+6XtpOnl4JA?=
 =?us-ascii?Q?p3atQSBwWe5Y2WCzv/sMH5Zsr+D1cHIy8WgJPusqjb/G0W/aDHHcwTSHyltL?=
 =?us-ascii?Q?wZGI8dZY2NfB4E5bagaYBwcM1VHl3kDvMd2euSST5ENQOec86wUT5u59AjSF?=
 =?us-ascii?Q?1om0FPgOnn3UUcSztzvAsxFqnmuk1m0IOPwJni6rroADgsQ7iOt5JusRvxiW?=
 =?us-ascii?Q?uoZCFkqD2XYRkTeIPx6M2MBK/FxG2X59YlhVizFD87C9AQmpvhoXrMshJB41?=
 =?us-ascii?Q?hp6BlQOoWBI19f6gmQ8ZbVBIWvJ5KR/D+lAz5cF8eNeWEeIYQhx6sEtdZB0q?=
 =?us-ascii?Q?E0x/SX5mR8mW874xjGAA1iOMq2juQglnuwoOrplnvtz+9ZzjmikWGTL3J1QG?=
 =?us-ascii?Q?ngp19v1WVUItqmHgcC3/AfGEOqT2M7dwZhchUn6mNgGszwaUG3cwri5NKyK7?=
 =?us-ascii?Q?vT2RqTw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i1ZFJeDStvZPiLgy1SwRjvW9UGjlFbQ+k51iY9Oyo+K39jfefE13h/4BxAKp?=
 =?us-ascii?Q?bCPi70xGcdOI6o2WLd9BY+Nrfi9q4NeoPT+RSCqRHuWkgHxP8noN7J7IV4Do?=
 =?us-ascii?Q?94Mgxr7p0EDXiQWcrCS8CtjoXYqm3cqhYV68KI6LpWoYjt5hh82FrCbNQ8Wy?=
 =?us-ascii?Q?qLuXTrgDWTr+LsyshOS/B5surl4T/zbiGSMY0m4+hGtg4OO8byg2AHAkJhQx?=
 =?us-ascii?Q?AIkwxjjcxiSwt3yivBu8D7IAMQRwfYmExRd5dxe66cALI7CGCOu9hQcV75I1?=
 =?us-ascii?Q?zi2NixqrhbHHulDDiOq6G5YMIJ2t1pCnH26L4NVtEmTZNwe+/TLdwwrF3pjZ?=
 =?us-ascii?Q?I8ynD7tWxG/fVtKyso2XfKrx9dEBWwsrN9fn0XZYGfZPYPtbn7AXbebm+qlP?=
 =?us-ascii?Q?TA0cc+lA0d0TrLuGmzWPvi2VCfmu6J9+ynU8eQTf3VPgRWUWTvrw23hSW00J?=
 =?us-ascii?Q?AThQCRXE4fCqj+zUIaEGLCBBd3NWBmKzBTXqLw552O2mA3j6YoH1tddeEx7X?=
 =?us-ascii?Q?cN+FatLjAKX5YDEZv9yIfgtxgj/HQ2mMwenbr+m4byr6pT6B2b0fvQZHAzTf?=
 =?us-ascii?Q?zchRE2f+DacxQKpwpGphH6kMOu3ZwnIYRNbKEVoTN4sYIUyOlQM4f4cajVOE?=
 =?us-ascii?Q?vQxc0DLwAkn+JeE+A6E7wGMXvtfC5XRF46+SBTaMrSPyvzFcAifkKTSrf7M9?=
 =?us-ascii?Q?kHZGZay3PtPVuHYqWiXPq+F6ADgYeUk4v5CJWEvD+yqfTy/zspJXzBD9elrL?=
 =?us-ascii?Q?LjG3S4RH90hBaT1J9iKY10ouyRCpLsPDw4EmfbcvBzr+/A7a1/2ywhfz5L5s?=
 =?us-ascii?Q?tvxumCtwJGMAF0OOzsHFg2Ava8h/passxwHVyUWqLOCEoN2b+Wldsvq9KLCk?=
 =?us-ascii?Q?t5FxgNa/oeT0aD3bv+8CjEO0orl364f8E+GPsepdMAZ+E6u8WiACzyVicnzW?=
 =?us-ascii?Q?OarnTCcC2kq4YmRkvuNdN1JVogX6mi5MRVCHeUZeHB1P/J8myjLGYUhgCbQU?=
 =?us-ascii?Q?+xwuxiul6q0X3jeDJVVpizyQ3/SQr7fa/DxLx2pmA0DZhjdO5ROIO5k8qkwo?=
 =?us-ascii?Q?N7jXao5X9Cjlb/02mvB/c7lFrRMacWocOzZUayVLfAa7o2vW+P4ZmpROd5gH?=
 =?us-ascii?Q?Kr+AxNp+y41L2NlfHyRj4ygWmTM7yz65pBJBu9DELLCuQkMZi4bnRk0Zf5LN?=
 =?us-ascii?Q?RJ/Ewvct3pqjcr1aLyLgeNXv3NKEm0u4KP+GdeboF9sjAk086c1kvjS6Dhyx?=
 =?us-ascii?Q?LBxxXNZMIL+SLUQDA63QAV6yjmD6KkUlh46cg5uGrbZtQtfAFBdOlbzaXUQQ?=
 =?us-ascii?Q?x6uF4aq9Ad0FSR+8v942+DLKeZGo+H8Ww/K8agod1pcUd6lgbgWu7BaM01Lr?=
 =?us-ascii?Q?ko0CM3Jh0fi76EqA4MIvp9Z/QuyTcYdoUCKLo1OfWo4s1gpt0IqAlT7DukV+?=
 =?us-ascii?Q?LWVKgbjVV6NzNBfM54WK4AXv+i5KwXP8hnI0nRgF4yqz/wlU3GY7BzImrXTf?=
 =?us-ascii?Q?oL1ce3ErT4igvXpGF97OknHzH0Pf2TYnFxjioR+2DKtnOMWTbqmMhHW/x55l?=
 =?us-ascii?Q?g2smBcAe/jgPDYN0BAA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9214a4a9-5b0f-4195-df57-08dd0843eded
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 02:43:20.3819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCVHs2MBiUD/SXAANoffL5kxCXPytk4eQngqLoP4lFyrfLASBO7wKuxorzVdpcJ2sPJAkzGqptJl/Zajtxie6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

I would change the message slightly. See below. But either way this patch i=
s Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Xiaogang=
.Chen
Sent: Tuesday, November 12, 2024 1:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul <Mukul.Joshi@amd=
.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: Differentiate logging message for driver ov=
ersubscription

From: Xiaogang Chen <xiaogang.chen@amd.com>

To have user better understand the causes triggering runlist oversubscripti=
on.
No function change.

Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com
---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 44 +++++++++++++------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_packet_manager.c
index 37930629edc5..1848578dd5a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -28,6 +28,10 @@
 #include "kfd_kernel_queue.h"
 #include "kfd_priv.h"

+#define OVER_SUBSCRIPTION_PROCESS_COUNT (1 << 0)
+#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT (1 << 1)
+#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT (1 << 2)
+
 static inline void inc_wptr(unsigned int *wptr, unsigned int increment_byt=
es,
                                unsigned int buffer_size_bytes)
 {
@@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned =
int increment_bytes,

 static void pm_calc_rlib_size(struct packet_manager *pm,
                                unsigned int *rlib_size,
-                               bool *over_subscription)
+                               int *over_subscription)
 {
        unsigned int process_count, queue_count, compute_queue_count, gws_q=
ueue_count;
        unsigned int map_queue_size;
@@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm=
,
         * hws_max_conc_proc has been done in
         * kgd2kfd_device_init().
         */
-       *over_subscription =3D false;
+       *over_subscription =3D 0;

        if (node->max_proc_per_quantum > 1)
                max_proc_per_quantum =3D node->max_proc_per_quantum;

-       if ((process_count > max_proc_per_quantum) ||
-           compute_queue_count > get_cp_queues_num(pm->dqm) ||
-           gws_queue_count > 1) {
-               *over_subscription =3D true;
+       if (process_count > max_proc_per_quantum)
+               *over_subscription |=3D OVER_SUBSCRIPTION_PROCESS_COUNT;
+       if (compute_queue_count > get_cp_queues_num(pm->dqm))
+               *over_subscription |=3D OVER_SUBSCRIPTION_COMPUTE_QUEUE_COU=
NT;
+       if (gws_queue_count > 1)
+               *over_subscription |=3D OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
+
+       if (*over_subscription)
                dev_dbg(dev, "Over subscribed runlist\n");
-       }

        map_queue_size =3D pm->pmf->map_queues_size;
        /* calculate run list ib allocation size */
@@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *=
pm,
                                unsigned int **rl_buffer,
                                uint64_t *rl_gpu_buffer,
                                unsigned int *rl_buffer_size,
-                               bool *is_over_subscription)
+                               int *is_over_subscription)
 {
        struct kfd_node *node =3D pm->dqm->dev;
        struct device *dev =3D node->adev->dev;
@@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *=
pm,
        struct qcm_process_device *qpd;
        struct queue *q;
        struct kernel_queue *kq;
-       bool is_over_subscription;
+       int is_over_subscription;

        rl_wptr =3D retval =3D processes_mapped =3D 0;

@@ -212,16 +219,25 @@ static int pm_create_runlist_ib(struct packet_manager=
 *pm,
        dev_dbg(dev, "Finished map process and queues to runlist\n");

        if (is_over_subscription) {
-               if (!pm->is_over_subscription)
-                       dev_warn(
-                               dev,
-                               "Runlist is getting oversubscribed. Expect =
reduced ROCm performance.\n");
+               if (!pm->is_over_subscription) {
+
+                       dev_warn(dev, "Runlist is getting oversubscribed du=
e to%s%s%s."
+                               " Expect reduced ROCm performance.\n",
+                               is_over_subscription & OVER_SUBSCRIPTION_PR=
OCESS_COUNT ?
+                               " number of processes more than maximum num=
ber of processes"
+                               " that HWS can schedule concurrently." : ""=
,

Number of processes are more than hardware VM slots available

+                               is_over_subscription & OVER_SUBSCRIPTION_CO=
MPUTE_QUEUE_COUNT ?
+                               " number of queues is more than assigned co=
mpute queues." : "",
Number of compute queues exceeds what can be mapped to hardware at a given =
time

+                               is_over_subscription & OVER_SUBSCRIPTION_GW=
S_QUEUE_COUNT ?
+                               " cooperative launch is more than allowed."=
 : "");
+
+               }
                retval =3D pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
                                        *rl_gpu_addr,
                                        alloc_size_bytes / sizeof(uint32_t)=
,
                                        true);
        }
-       pm->is_over_subscription =3D is_over_subscription;
+       pm->is_over_subscription =3D is_over_subscription ? true : false;

        for (i =3D 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
                pr_debug("0x%2X ", rl_buffer[i]);
--
2.25.1

