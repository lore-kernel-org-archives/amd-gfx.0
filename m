Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEF4C2A09B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 16:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E3B10E437;
	Fri,  7 Aug 2026 16:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gERD2ZBy";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253BD10E437
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 16:05:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvdcT/t9OyPp6alZnD+06HCyraIKrOGeRgtV3+69w8z+ZQNpXlQiWzEnJKPJOJy/DKChTszHxVGxbkwBhu7tzyZhHNGmq2WG+Qu7cMUWzTZXw5KcOSgB9nZ530Ffe9jiDV7Mj6eMa5a414TZAtrawvEQwk81mWSyV/HoNMMX3Q1qT+ze02iHS4fONlmoh9/cxltWYdU6kXZ1zluBr6jxd2xF5DzZrPxehmIQB5U7SycvkxVCg4QHbEjmJ7j/4sPJVt+fMbIupIlPORqLJeKDpdeOJPE2rAsWkp2Whngp7xjBKkogKJ6JV1ybbcOnSMckKj9LmWWpHniIq8AwXgzQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+PAIREhtm6kV7yLBBO34xLhTfWXNkQQlKxEwXHkFNI=;
 b=AGEkfSn1tM4yqJq3Rh+jiggFH39FQnfm0oSOWj8gNrPTVbyB7U7jHUQ7tzDpcWjPIxOIBX2dADk3uphQXGJovdCX07W+ZOe2CvR0wNyFYH1VN+N6kJ4Xd1p1zH/VvA+7kWiehPVJY747kBK0d76rFcLiOBNfmTBGxs8NUHs687l8iltIVGqjytD+FuEEBNky7IWF+CLhQgb7AdL7SKb8ANVFpG+PYtS3FaESARVBTX+y3DPFml85JfKCvIfJaR6/gwNAZKk8Zesz/KKBCM2+Cpsp2h8yG4YmDJ7cY2AQLDgbXBFC3Z21XwulzzrlYikYuX63Mzhjy9m+Yp34eFIWNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+PAIREhtm6kV7yLBBO34xLhTfWXNkQQlKxEwXHkFNI=;
 b=gERD2ZByCr/p4uOY5+6x0JihzQQTylX9g3RzkmDcPCDdSaow2HF3I8+DtrLCtqw5kcUAgN0Kd3IJw2IHnTwH6uLwCVhgU2hc45BHAmRO3jh1Gp0JbtA7BtMkwiwBaSVOeOu/WIscKdJN78ZQc68onoy4xBnrCOU+4V8F3WyV/x4=
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 16:05:41 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 16:05:41 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Add trace events for pid
 register/deregister
Thread-Topic: [PATCH v2] drm/amdgpu: Add trace events for pid
 register/deregister
Thread-Index: AQHdJnKqga2xOoriekOBTZxYnPXddbaSwBpw
Date: Fri, 7 Aug 2026 16:05:41 +0000
Message-ID: <PH7PR12MB7794F72E338BB74FDE8C679093D12@PH7PR12MB7794.namprd12.prod.outlook.com>
References: <20260807134241.845819-1-David.Francis@amd.com>
In-Reply-To: <20260807134241.845819-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Christian.Koenig@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-07T16:05:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7794:EE_|DS4PR12MB9820:EE_
x-ms-office365-filtering-correlation-id: 9b7ef188-bd93-442f-4250-08def49dbad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: BCyAQ0AyaXUtvjkPM6ZF3GlHpyW60uE8qzsihgnDchImyGtxpMhPGEw6WXIpiNCu9DpLnOD0gAmqvcBUOVAb6ankvciNU3RGol2cNskB3NBKu7o525wLXKkFtpG1r7OFKCAUI+1+b8tA5Sh7P8Vi4D84YFdRjKoCjAuaPfNqGM4B7IesdPtXoLXQGgMJLZOawPAgvu3ob/BsxAVzTd6SCAGMZSWVcKCT+ajArzRIHF3Ege8UTt8KSQBDkc2+WvGN9TIwgau/+R5R0SAih5MEcd8gE4XSL3YVidjqcxn1Aqfsi3D65oD/aTdBhuU9+vRUFs9vHsLAEhGWcPCPdt6SBfj4+mRes0gzOK0u1unoO7v62mZDneiBxb/Q7g6IgNit5uRPZ0JQhuHG/pGLeiWVWaGF6lMTcunJD68I+P+MOSuWj3cE43Dmk4hyMrT3nNeeV8lpB93vouAxH3+Pugs8NhMLBpSIPv07Ojp7fptrDMQ+AR6IxNLhIRL9SRa56NM19F7jLtGOtOABfcE/G7t+Kifr8l6NWe0qtN0mecv8peozvqR/yF5JnWOcJa9QbgglXByInUJGv9au16P/9axsIPj+d0Bk6FQHax5OrAeagDwPTEYiGOEzGv3DHLaBoSkl/gvl0U4RAdhWwordfqQMMnBCdbHdCQC5QYJ3QgOdPfnnGp7S9TeYh/Mu15nJqSDsnQRQRZRN0r1vJG1csO3DeLDN5F9lbZpigfTIkuHL+SA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+SYZVWdFTdIp57gTO/hZl0tnJFk6+azyGLKIBTZOl623/lq9SE3kaNRav4qu?=
 =?us-ascii?Q?AW4w+V31NbOJfh0W6jlk1aTp9Qt9QuP39cs4ngidIXGjATmXLl0qn5MzEi7r?=
 =?us-ascii?Q?sPS41OeYEyK0aDvEm2LBXV6rQp5H8f++C6y7EBOq9UHw5t/HtEuXPZg4cejf?=
 =?us-ascii?Q?jRoMm4fcPItXzXw5p+db++D9BqzryzEn7fNWUSWVlwt0eXNAsbgNOEB7DALk?=
 =?us-ascii?Q?aEsKhLIpMZIGIcE+VcyLHt66kDhAxiqlaoqvNjGSevEM+8uqSbS81qWhT0NY?=
 =?us-ascii?Q?TXiwa7bF4JNbfs+F3e4bfHhza1FcXsGGhFcyokgu/axpOjvIcqeYBZPppxSt?=
 =?us-ascii?Q?GOjnPuaAoHYeDyC+MlfITFmpuXsOZvEYBd4/+hK5NK41yn48RbnEN2ozm0a6?=
 =?us-ascii?Q?7uLmUEZKw4lIE5mf4BPfwumQR3IRqIriQ+ghKn2/gv/0hgDQDtEmht3AX+os?=
 =?us-ascii?Q?OSNuLtf7az29d4amWIIbkQ9wZ68kPWhHvlf5VfYcVI2IvufjHP8j8UfN77ky?=
 =?us-ascii?Q?HHKIE7LI6UNLKiqxuCUi8ybZgKHa0TGzXzfhYw2ZNWAv4LgBZo41ns2uXdzr?=
 =?us-ascii?Q?Yvt/HSeoQq8wAnIqtYde5niPSDyWryDwzHoWSTuIKHaYhEY5pfRWHDNK/dC3?=
 =?us-ascii?Q?/DQktHW8tRsP149SBSGOsd2CHXNzPxT/BCPKOgbe4CdeY988qaSvIOxhj1wb?=
 =?us-ascii?Q?OauJ72dSNIL68p54uglir4uidjZ0r4zGfaBTAbFzXEebKQ21V2Q96RkCgjhy?=
 =?us-ascii?Q?8O3V3ErwpRgN0VTATXYjLEUn/5UASPtmhrX8MXURPVfdQ81SXgVC6JWsw06L?=
 =?us-ascii?Q?FNYk7y+R8FTqGIgzzMirNZdqqaQUIIsaFUNpvxBBrUCGEOj0y3w6gp+PR1nE?=
 =?us-ascii?Q?vVGBERwKS2fKupmrJIGZ84GUXSSq5cJ9wVimvQFqLbWWP60CL1XSfP9ZHRap?=
 =?us-ascii?Q?I7qjHqqMN4j8MCkzzg7xI5b9xPvELO6bIzJR5vZNSJwR636CQoMFySFhXqwn?=
 =?us-ascii?Q?sqrPjIN443zdPbkFEIeeUOZY/SiyIYJz8Zv1i8zPloOmqFS8nBG2AVwi8J6U?=
 =?us-ascii?Q?PTrA1R/1XC9t/SpY+HJQndiRS5Q2djX/hQculPUuLHIw3zJSLjBh7Hlgy8Ip?=
 =?us-ascii?Q?XO/ETzOPI6mdeaJPPgT48FlgDGZNmFze6OOmyCQPU9AmmWL9HfuZR1UIumt9?=
 =?us-ascii?Q?G16oXhPdmG3LCJf+OVnTVSI17+PaYonokMu8bqg5Olf2GYYuFNl0phA52ZPU?=
 =?us-ascii?Q?YPy9Qnqsiv5+CQeoyhSAlDhbNBwS7c/l8wi0BfpI+wwXOqPcgAgcE0iRHtEh?=
 =?us-ascii?Q?9u6BEnELIV6mTeK/RSwzYPyuNjOkCwq41AOpuLCpsp+JCLatwzo5/c0iwynP?=
 =?us-ascii?Q?nPhKwvNpqagcbE4LbgaxBGs4CYK2Ho5YAgA0PSK2mgxFTN8iVbeWw+jVGYmL?=
 =?us-ascii?Q?o02mQRZM2TYlFSLQo9pecaOZIuo08vmxoJSxuaz4iiYM4gOQv+0+IcXhWj2h?=
 =?us-ascii?Q?bs9QQt0thQjmJV70XOKnEe+ZB16pyHX3cXppXrxjZ9H2wuL0weZKR7pNQ/Vb?=
 =?us-ascii?Q?1SeqpYiNZ/cKFDxup/w+a5SnL41QkiFDoC/3hBl6BExVlv3FSpUAx6VvdRTA?=
 =?us-ascii?Q?kKLlhSIDl4lwX/9wSStbo0ViuIf0o1i7rjgyFdA0Z9M91ItZ+DFsHvUQTpph?=
 =?us-ascii?Q?50KYtdmCBvXxTiePMsN202z4NX7+IiA1zpDaQKq81NHyoHJS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7ef188-bd93-442f-4250-08def49dbad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 16:05:41.4398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBS7N/TymWoHUijgXXb61/mDru2T0GuO+Z2zCicOgyzCsZ3oh48xbySL8UJ02G4hI2fvwxa1a5tPB+2k2F2Arg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820
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

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
+@Koenig, Christian

-----Original Message-----
From: Francis, David <David.Francis@amd.com>
Sent: Friday, August 7, 2026 7:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Francis, David <David.Francis@amd.com>; Khatri, Sunil <Sunil.Khatri@amd=
.com>
Subject: [PATCH v2] drm/amdgpu: Add trace events for pid register/deregiste=
r

Some debugging applications need to track when a process starts or stops us=
ing the amdgpu driver. For those processes, add ftrace events that track wh=
en a amdgpu_vm task info is changed or destroyed.

v2: Deregister in fini, not destroy.

cc: Sunil Khatri <Sunil.Khatri@amd.com>
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_trace.h
index 5324030a13f5..2aeda13e49dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -732,6 +732,23 @@ TRACE_EVENT(amdgpu_userq_state_changed,
                      __entry->client_id, __entry->queue_type, __entry->doo=
rbell_index, __entry->to)  );

+TRACE_EVENT(amdgpu_register_pid,
+           TP_PROTO(uint32_t pid),
+           TP_ARGS(pid),
+           TP_STRUCT__entry(__field(uint32_t, pid)),
+           TP_fast_assign(__entry->pid =3D pid;),
+           TP_printk("amdgpu register pid %d",
+                     __entry->pid)
+);
+TRACE_EVENT(amdgpu_deregister_pid,
+           TP_PROTO(uint32_t pid),
+           TP_ARGS(pid),
+           TP_STRUCT__entry(__field(uint32_t, pid)),
+           TP_fast_assign(__entry->pid =3D pid;),
+           TP_printk("amdgpu deregister pid %d",
+                     __entry->pid)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index aac8ace9d7a6..48a725a0154e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2543,6 +2543,10 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
        if (vm->task_info->task.pid =3D=3D current->pid)
                return;

+       if (vm->task_info->task.pid)
+               trace_amdgpu_deregister_pid(vm->task_info->task.pid);
+       trace_amdgpu_register_pid(current->pid);
+
        vm->task_info->task.pid =3D current->pid;
        get_task_comm(vm->task_info->task.comm, current);

@@ -2803,6 +2807,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struc=
t amdgpu_vm *vm)
                         ti->process_name, ti->task.pid, ti->task.comm, ti-=
>tgid);
        }

+       if (vm->task_info->task.pid)
+               trace_amdgpu_deregister_pid(vm->task_info->task.pid);
+
        amdgpu_vm_put_task_info(vm->task_info);
 }

--
2.34.1

