Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50157C2BBCA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 09:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA5510E209;
	Fri, 28 Jun 2024 09:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ja5qv1wF";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C958010E209
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 09:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I85J0iSrzS2aPiEuaQnOQCqDWlVmevywjpFIM+HsJToZdpshwwve3Xb0UdFqEGnCza/YeBByWzDLIRpeDHrwOlbWEwkzrndp+nN6Vr2l6pwuzx33UAipvm8Z6sRZT3FYjJDUdO/m5DnXggwuhpDA/rPMJMLYSM6W4jKAUYI3SBGobTCVMfsPnKLiUgsLdlI+WVxPMtTFRRZdslQAO6HjkgEosKWsOBQhUV39q7pJGdoE1hx775liyPSeGSp/MQrWCv+a/z6wHCzrv9t+XAM0RS69qH6a5djK4uduRHdE6egplhmqrc4URrY/DvhTU7bISnNbqq7ErjtetT5N0OSOuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpdvbOy2K5UB4rDc00XWuhu4dCU/IXhoeSGhBMOi7uI=;
 b=lF5dHBeCH4GYYh6BqsCOxCGp5gjTiGuWOp4aSwcBP6flgBR+4Oj/3sr5cu8pW9l55usFHHGlD/BPDRTgUxY+PQ7cd1p2XDX1aGObxjZT8NBUaaeqXEQB+Y1aK9qmIjeUEhXnes1mKyIzB3ADBvmq/omnw0WXA312gquNKmk9++vUoxrOOUsPLeqCJeJZvAru6epoZ4bIt9jEqs5rOthFmsGosQBlNLOKpbE55YbZBL3hQh/jRRbZxTc8qWIk20sISkXqBMPuITUpKFneS5ynCX9AirKhQHrfJUsaoX0QETsNDdHp0KSoKVUUSXoXG5UwtcGuO3wHCbz6koHtfeyD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpdvbOy2K5UB4rDc00XWuhu4dCU/IXhoeSGhBMOi7uI=;
 b=ja5qv1wFAKcVzPGwnnkPQ+BSyurhdd75PqCliPYTiiDDfWIUdkLfP8dyLOHCDse6pVWQLBYoq39rYl3kfvwfkzY+L+pKImchFpe04h/eG3+jYkxkyP21L2AxhcIEGBmswXdhoRiZcXMRMkFXoal7zN27wmxRMeJzbPEVVS/PNU4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 09:42:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 09:42:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Topic: [PATCH] drm/amdgpu: add mutex to protect ras shared memory
Thread-Index: AQHax29z9IS8lmbmuUqb++wg6PvQw7Hc7yMg
Date: Fri, 28 Jun 2024 09:42:18 +0000
Message-ID: <BN9PR12MB525743E2957686C33851547AFCD02@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240626022001.1139403-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240626022001.1139403-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=66cd1c4c-c409-4098-a1ce-1c02a6aacb55;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-28T09:38:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ0PR12MB8137:EE_
x-ms-office365-filtering-correlation-id: 4e53c3e4-fb92-445e-6df5-08dc975699f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9MVG/p2bW2c1qv2mz+19rDGA2WXsIqrCIB5J3HcmPm7fCxXTA4PgnKFTwpU+?=
 =?us-ascii?Q?PiXUvb3jjMdQFLDAxW/PMXNG6WQ6S9XwSUtZ8vAX4IB0Y1KKt//aciuImMKC?=
 =?us-ascii?Q?Vuh4ZvnUOaq1deuKHOA5VBM5Wtm5nbW4tuOiA6MSQP4YCL1abBGIkAYkkV5Z?=
 =?us-ascii?Q?4qlQx1stcxBovEksF/45GznCqiRmdCkPGF7sZM4QU1zDVMEAlpVj+CJlnq6/?=
 =?us-ascii?Q?whoizq0ZqsMqki26kGVUaEO0l+0fSbVrCM7Hr1ONT/PXObUENTU00RMMKy08?=
 =?us-ascii?Q?nBON7DR7cTXuoN6Tcusg4PnF57r9RCR67YCAl6kOPmbdOOgt4tWGk3uM2QCX?=
 =?us-ascii?Q?j7ZDbefb4VwJW6OjVJxcdog5sYZ1TdhTc3Tkdz4PJA2a6D0xk3B/sVa8uBDH?=
 =?us-ascii?Q?duYULzaKSEjSuw/7kTFpLt9mPJEsl5EZRvqfDZaQjlKxZl0b9U6PUVmzFDiV?=
 =?us-ascii?Q?R5nWfqW5LG+2C0GiFNQ3/tgB0pMbtJOpUqkxbb8sXGljwoe78gTvG4co32WV?=
 =?us-ascii?Q?/tWH0lfExZx2LqJKPDzJZKAyri0P29i15xRQPYNaw4p5tTAVBBi/oz6Xbdjy?=
 =?us-ascii?Q?bRmECLarZFRy+VA/V5P07VM5TsD1+7w57LOze6cunyQzB9Het9HQ9hE2zpwh?=
 =?us-ascii?Q?5+6VN9Sc5vBWlRjrwUKRVnNmh3bNRhl4qa3egy0bWodiksXFMgM2c4RqexMd?=
 =?us-ascii?Q?0IReRdDq0h9lDIIKXcmUe6QOlDUYTWuiCe3VmfZj4Wk1lR0Fkow+s6zANfpL?=
 =?us-ascii?Q?HwkinCNIY1LTvvkEPAgUt+5FFeUsIzy4ylpSdVglknNtDLav7aEADZY0sqCO?=
 =?us-ascii?Q?NPkJPSrqYT69re1cOVidqfK/vZ9zXlrfEIK4fd3WDDT+xrNbiGQqNnxJH0KE?=
 =?us-ascii?Q?TgdO1sj2rF7zFPSCpuySiOauytXK7tUDiGT0Dqpuxb3+kcvTQpNGysUg1yXt?=
 =?us-ascii?Q?qSj+8+mahu0xv2iNarGNzpYRRAa29iWCkccw1o3vGQqVLhQRhDWJElKKRxPn?=
 =?us-ascii?Q?GnmaFoqp+cIGpHclfar8fkLdYuiXAJkauk/Wt+aKB2gb0TNCHb7BTn+qA+vz?=
 =?us-ascii?Q?1IPy/GSiPg3FGbG5xDXYSO4OmCeyaUdB+Jgz5PNq6FcpMDbA5vwDWKE87knx?=
 =?us-ascii?Q?dwtB8BQ0gC5Woo4NgpSffV1UfCk3KbZVzZv8Wb6NMS5l6vrtaELTRi9feR6E?=
 =?us-ascii?Q?PD2c12zasVtaHzqHYLmevT4Ug9BItXYObpGu0qrxi8+eBoEXUCnrid5rDxZr?=
 =?us-ascii?Q?hLWtdcJ8tURYtAtitqad8zBeTnBcn4nnzjT8rdiLsrqEdtyyPEP+TQxoOiNL?=
 =?us-ascii?Q?5zlJvGUG47JHaK4VAZQIXHjEXik8O/TcnGWhNXNxN8PeN6lC2EXxYeDhQdac?=
 =?us-ascii?Q?sd2T/Nq3oMmuZ2FOdV2nxXiJpVc4YLn/Zu/j6t7BJ2PEW21tJA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N5qele3Bg7juOMfNQ0UgxSr3feL/QX3uyZkilWrvhP/nDN4DKsYaKPiH5hsc?=
 =?us-ascii?Q?RzkNcgElUECIXic/6XzTyA0RHUnqZVyR/7cY/1svebrPdBSx/NrUkk74eqNv?=
 =?us-ascii?Q?nXG/u90yzqG0LCM49hTYi9x4DNePoNXMxQrhO/0pHDjV+iM3ZhVQSzD4YEMQ?=
 =?us-ascii?Q?0E5IQhN7yUoQq4/7XayWZY9f3yK9dCjvUyVFodMEqlMmYaepapSJTp5YQfwj?=
 =?us-ascii?Q?5c11VSatMYaCxZ31jwSGgd5WNjTfZER+r7hdM06UlGszbA/b47RAgcIh+I3i?=
 =?us-ascii?Q?PSN/awBbdoXvkx0agNVUuduQ33QswgWyFgCLMmq+PSkf3o7w5nvd7TzVBy7E?=
 =?us-ascii?Q?VrlaZn+ldT8lteeM1/4zOmY47KVOa7h04XZBBp8lSLJu3yoy3cjmcHTZqhND?=
 =?us-ascii?Q?E+HJQIESqNvOX9IQcXlwXwmsTdGGFiWbiJyVxBBDdLISRos9RCPQD8rhcGsa?=
 =?us-ascii?Q?hU6ucz5brJ2/yyZVlZoQ0jLGB93oXcreHQXkICmHQuePbzV8v5SBiQZOfJjc?=
 =?us-ascii?Q?dTr0awuwKqgveGtBrGTf6xp33e8jaJb/Qw7jS0Yb4LiaEufyquUDqvMDDy8k?=
 =?us-ascii?Q?TsIcW4nMUfSiu8YSlBKPjLtYzH2S3hT/akbkk19DCCwJh7OIFTMe2uX4smdl?=
 =?us-ascii?Q?u+jXlbOsWkmUVBpNlFvU5HC4zobYe1YvIMSTom3APKBnFeE6Ic4873Wi7VHq?=
 =?us-ascii?Q?MKECQ8BPsmKLQFTE3PXLVvvGP+qaMOGSkosCd8SJxmVxUj0wthfo34FNpMJl?=
 =?us-ascii?Q?nxvc47LqleQCztRL8rxgs+dsDNjPGGWU+4DdtmdB8Aa0GVTtiwdT3JBR/bj5?=
 =?us-ascii?Q?oR803Tcr/ZzvWhCgjD7HIf06IIo3H1FZUWEGg0rX5RFi1kCc7d9AIpYXQbXM?=
 =?us-ascii?Q?uv9qL256hBmyVbpflbNMDbZhuWxD1uoLAUImbBYy+3T+w0OznFil7N82jI5m?=
 =?us-ascii?Q?nSCTpF4rudAoY6YcjWCD/SjkvL3CS2AP+ECDx28zLBFqwxaNhnq9XUJboZ3a?=
 =?us-ascii?Q?tsR7QdQs+UPN5NgZj76w0O9iML2VhDcuWdTC2zJN7qQeTmZQ9GTr5vZJMQrN?=
 =?us-ascii?Q?mfLxXx4XjWzTKsn0Q1vvqWQ0tLIfU67d3tf8eL4PhutDarWX5oaCe1D9zp8H?=
 =?us-ascii?Q?Lf895H6SM0vsfYH+QhtSmkK0nVjHrkxlibmNYPghgihak1TztKNH8o7o71/K?=
 =?us-ascii?Q?5gBcI3TBFmsp34wbKFfrRv+Yepl5m5+NGistPvm3+gdhA9cJbdC63XrArgqC?=
 =?us-ascii?Q?KAL4P4wRafQuT+eiU36acqf7ulVaUo5xfKr1jD/qS4DByRGCX0tHQJ5FvMD+?=
 =?us-ascii?Q?beh1ib1g3op0AFs5cvjXpG0SOQotxJ6ItSgwCFc2nV1uww8HevmybDJH/js6?=
 =?us-ascii?Q?tFdh67vxJB+ZYPck4o/Xy3Qk7ntyG4tYyGLlus6rotJTDr17B08vyTDjV74T?=
 =?us-ascii?Q?EEy8eCyU1iPrUeG2JFRKLbVYy6+GxrRqVlsbtUrmB49CgCRmvTtZGDrVmeWm?=
 =?us-ascii?Q?y/zMycZ7rePhBVPFBlShqLtjdWBMdyb2TPs2CoqyE0ZTQefyJlIYrk41UwpG?=
 =?us-ascii?Q?9835YrebVss3wWzSoqcxEg1uCw/LglznEglex0RX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e53c3e4-fb92-445e-6df5-08dc975699f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 09:42:18.5703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGCYjot0ycDC4jDIZnCHNztkUlSLGYZ8+2xAtx4+sftn4oSKJd11kUnXjNIMX3gw0wY9LTFbtXyHeDYPS3Nlcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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

+       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);

+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               if (out) {
+                       uint32_t *ras_status =3D (uint32_t *)out;
+
+                       *ras_status =3D ras_cmd->ras_status;
+               }
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;

Shall we make the following check for both TRIGGER_ERROR and QUERY_ADDRESS =
command?

+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Wednesday, June 26, 2024 10:20
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH] drm/amdgpu: add mutex to protect ras shared memory

Add mutex to protect ras shared memory.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 124 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c |   2 +
 3 files changed, 87 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index fec968d8340f..323b3c470c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1573,6 +1573,69 @@ static void psp_ras_ta_check_status(struct psp_conte=
xt *psp)
        }
 }

+static int psp_ras_send_cmd(struct psp_context *psp,
+               enum ras_command cmd_id, void *in, void *out) {
+       struct ta_ras_shared_memory *ras_cmd;
+       uint32_t cmd =3D cmd_id;
+       int ret =3D 0;
+
+       if (!in)
+               return -EINVAL;
+
+       mutex_lock(&psp->ras_context.mutex);
+       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
+       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
+
+       switch (cmd) {
+       case TA_RAS_COMMAND__ENABLE_FEATURES:
+       case TA_RAS_COMMAND__DISABLE_FEATURES:
+               memcpy(&ras_cmd->ras_in_message,
+                       in, sizeof(ras_cmd->ras_in_message));
+               break;
+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               memcpy(&ras_cmd->ras_in_message.trigger_error,
+                       in, sizeof(ras_cmd->ras_in_message.trigger_error));
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               memcpy(&ras_cmd->ras_in_message.address,
+                       in, sizeof(ras_cmd->ras_in_message.address));
+               break;
+       default:
+               dev_err(psp->adev->dev, "Invalid ras cmd id: %u\n", cmd);
+               ret =3D -EINVAL;
+               goto err_out;
+       }
+
+       ras_cmd->cmd_id =3D cmd;
+       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+
+       switch (cmd) {
+       case TA_RAS_COMMAND__TRIGGER_ERROR:
+               if (out) {
+                       uint32_t *ras_status =3D (uint32_t *)out;
+
+                       *ras_status =3D ras_cmd->ras_status;
+               }
+               break;
+       case TA_RAS_COMMAND__QUERY_ADDRESS:
+               if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.st=
atus)
+                       ret =3D -EINVAL;
+               else if (out)
+                       memcpy(out,
+                               &ras_cmd->ras_out_message.address,
+                               sizeof(ras_cmd->ras_out_message.address));
+               break;
+       default:
+               break;
+       }
+
+err_out:
+       mutex_unlock(&psp->ras_context.mutex);
+
+       return ret;
+}
+
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  {
        struct ta_ras_shared_memory *ras_cmd;
@@ -1614,23 +1677,15 @@ int psp_ras_invoke(struct psp_context *psp, uint32_=
t ta_cmd_id)  int psp_ras_enable_features(struct psp_context *psp,
                union ta_ras_cmd_input *info, bool enable)  {
-       struct ta_ras_shared_memory *ras_cmd;
+       enum ras_command cmd_id;
        int ret;

-       if (!psp->ras_context.context.initialized)
+       if (!psp->ras_context.context.initialized || !info)
                return -EINVAL;

-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       if (enable)
-               ras_cmd->cmd_id =3D TA_RAS_COMMAND__ENABLE_FEATURES;
-       else
-               ras_cmd->cmd_id =3D TA_RAS_COMMAND__DISABLE_FEATURES;
-
-       ras_cmd->ras_in_message =3D *info;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+       cmd_id =3D enable ?
+               TA_RAS_COMMAND__ENABLE_FEATURES : TA_RAS_COMMAND__DISABLE_F=
EATURES;
+       ret =3D psp_ras_send_cmd(psp, cmd_id, info, NULL);
        if (ret)
                return -EINVAL;

@@ -1654,6 +1709,8 @@ int psp_ras_terminate(struct psp_context *psp)

        psp->ras_context.context.initialized =3D false;

+       mutex_destroy(&psp->ras_context.mutex);
+
        return ret;
 }

@@ -1738,9 +1795,10 @@ int psp_ras_initialize(struct psp_context *psp)

        ret =3D psp_ta_load(psp, &psp->ras_context.context);

-       if (!ret && !ras_cmd->ras_status)
+       if (!ret && !ras_cmd->ras_status) {
                psp->ras_context.context.initialized =3D true;
-       else {
+               mutex_init(&psp->ras_context.mutex);
+       } else {
                if (ras_cmd->ras_status)
                        dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_=
cmd->ras_status);

@@ -1754,12 +1812,12 @@ int psp_ras_initialize(struct psp_context *psp)  in=
t psp_ras_trigger_error(struct psp_context *psp,
                          struct ta_ras_trigger_error_input *info, uint32_t=
 instance_mask)  {
-       struct ta_ras_shared_memory *ras_cmd;
        struct amdgpu_device *adev =3D psp->adev;
        int ret;
        uint32_t dev_mask;
+       uint32_t ras_status;

-       if (!psp->ras_context.context.initialized)
+       if (!psp->ras_context.context.initialized || !info)
                return -EINVAL;

        switch (info->block_id) {
@@ -1783,13 +1841,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
        dev_mask &=3D AMDGPU_RAS_INST_MASK;
        info->sub_block_index |=3D dev_mask;

-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       ras_cmd->cmd_id =3D TA_RAS_COMMAND__TRIGGER_ERROR;
-       ras_cmd->ras_in_message.trigger_error =3D *info;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
+       ret =3D psp_ras_send_cmd(psp,
+                       TA_RAS_COMMAND__TRIGGER_ERROR, info, &ras_status);
        if (ret)
                return -EINVAL;

@@ -1799,9 +1852,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
        if (amdgpu_ras_intr_triggered())
                return 0;

-       if (ras_cmd->ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENI=
ED)
+       if (ras_status =3D=3D TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
                return -EACCES;
-       else if (ras_cmd->ras_status)
+       else if (ras_status)
                return -EINVAL;

        return 0;
@@ -1811,25 +1864,16 @@ int psp_ras_query_address(struct psp_context *psp,
                          struct ta_ras_query_address_input *addr_in,
                          struct ta_ras_query_address_output *addr_out)  {
-       struct ta_ras_shared_memory *ras_cmd;
        int ret;

-       if (!psp->ras_context.context.initialized)
-               return -EINVAL;
-
-       ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context=
.mem_context.shared_buf;
-       memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-       ras_cmd->cmd_id =3D TA_RAS_COMMAND__QUERY_ADDRESS;
-       ras_cmd->ras_in_message.address =3D *addr_in;
-
-       ret =3D psp_ras_invoke(psp, ras_cmd->cmd_id);
-       if (ret || ras_cmd->ras_status || psp->cmd_buf_mem->resp.status)
+       if (!psp->ras_context.context.initialized ||
+               !addr_in || !addr_out)
                return -EINVAL;

-       *addr_out =3D ras_cmd->ras_out_message.address;
+       ret =3D psp_ras_send_cmd(psp,
+                       TA_RAS_COMMAND__QUERY_ADDRESS, addr_in, addr_out);

-       return 0;
+       return ret;
 }
 // ras end

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 3635303e6548..74a96516c913 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -200,6 +200,7 @@ struct psp_xgmi_context {  struct psp_ras_context {
        struct ta_context               context;
        struct amdgpu_ras               *ras;
+       struct mutex                    mutex;
 };

 #define MEM_TRAIN_SYSTEM_SIGNATURE             0x54534942
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index 8e8afbd237bc..0c856005df6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -348,6 +348,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *=
fp, const char *buf, size

        context->session_id =3D ta_id;

+       mutex_lock(&psp->ras_context.mutex);
        ret =3D prep_ta_mem_context(&context->mem_context, shared_buf, shar=
ed_buf_len);
        if (ret)
                goto err_free_shared_buf;
@@ -366,6 +367,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *=
fp, const char *buf, size
                ret =3D -EFAULT;

 err_free_shared_buf:
+       mutex_unlock(&psp->ras_context.mutex);
        kfree(shared_buf);

        return ret;
--
2.34.1

