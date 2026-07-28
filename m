Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710A2C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 13:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1060B10E571;
	Tue, 28 Jul 2026 13:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="famvbHGH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416EB10E571
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 13:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF3937VFw4VmRxap8H8i2q32vRxRIPSLRGIBp/FPhAZyBMA1Jq9aoJTM+EZ65yAkMpG+ZXm1wEfzYERWvpxgOEFwGLi3CN7O92mGZNea+MOlY3UyTf6i+69mUgYob7/xMcWXdcB9cNv6cXsDRpGk9TpgIjmwXUCotHpfJK/VpW9L4p3+PgVw8DA3/DSQnSyCj/re22gKzsDvXNR0dVcsbm/kkb5QlUfZvPnCtQ2fsKHkHeRetiOrjGr+yEXyXj358Ht0ekooYbzVvAvg6emvzi+NMtdRX0gx6O6XkAW4Zusjew4KKL6ooBLnYzTbXs3vlX1tZtcr0xOgSz0ICiVr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJARtyi0eXmkgXC0tjhCz0JTyta/L2r90cQ0BnTAaGo=;
 b=lDLBKoMPy51kdMPNS3cqEaFTQKU08+ncthDB+dSjntGD7yxjoZM39TXOxfG/fFeNP8Jp6pIBAozq9unZchSIrQ/wdVZdbwv+bZXrdOmW8MCjIN6cmTzQleUrMYfbGS5OnDxU2ajVUKQprtgfXtAah7Wec8o1ZmcWpnZhrbCE182bKYjuCAweWIWixhlcdW3CJF3/0ylj56xxwlJ/eiztBrWAMhdL10HhNAyV2QjCwezcpFFjy9qdk3OF1So4Yf/08OaE2ogQN8mWYAYdBukdBj8TRfFEu+nxLthdLv7AHzwdBEAXkJ8cRHTt1wqSOMyW2zgE+mhLZJlntPCdCLx/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJARtyi0eXmkgXC0tjhCz0JTyta/L2r90cQ0BnTAaGo=;
 b=famvbHGHFCEjxwbrgc01KCWQMMvimJvBn4J7jfYhyBf6gE33fbrkC88za4kN7xDAEHIlARudjnlJbsfpjdw/5CC7e1Kdw0uafrxFLTGIsHo3KvU9OCcXA0mTep6+XsbjTh69uFxyIiksyGPZxlnyPiIpA1HyK5wHeCABmoJHs0E=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 13:15:46 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:15:45 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liu, Shuzhou (Bill)" <Shuzhou.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add trace events for pid register/deregister
Thread-Topic: [PATCH] drm/amdgpu: Add trace events for pid register/deregister
Thread-Index: AQHdG29Rd6vEs2B3mU2uO04xolxlx7aC4csAgAAK9IM=
Date: Tue, 28 Jul 2026 13:15:45 +0000
Message-ID: <SA1PR12MB8144502B9A0E12CEBA235AB7EFCB2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260724132100.1337346-1-David.Francis@amd.com>
 <13e91e3b-d134-4175-9a21-19ddb0b01b62@amd.com>
In-Reply-To: <13e91e3b-d134-4175-9a21-19ddb0b01b62@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T13:15:44.902Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|IA0PR12MB8984:EE_
x-ms-office365-filtering-correlation-id: 3beca3c6-d168-4920-0259-08deecaa556c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: aunub8iyNkZEr+7B/E4veWs+UiPGmrqyV8Dmifq3UbnmblG9XsxxDagm03aNLCakpX6xkSK9hzRJficVBqYJpQcRpluZ1IrbPes4U2QNoD3QJGUib6j19WE5IuB9mSlgj8HnyYRlPI1pqDPyavEZMlpnosHkgwQdPiR3rui6ANys3I1fKbIJtiQIAr+0v63u8uk60powqrRHvDTI/hgWCbP1QMqB4Xp4/rG3G27L6djSJ19TutgDb0eJW3fvfk8sgcfcGGUtsVvEIK0iG1IlL5j/1aJmsZOecOW6trnmcYhMm0Gqhq5yHPv+aNo+jDc4CgcwzPcJnEaVsDjqY719Pw6rFuRBqq1HA1TWB3NOywcsDYyHJDwnY3VpYHzLCRs+xUPpBgBfxpUXTLWdSaE2Sy9f8vrKhDSmTZ0tno4KIjRINOcbC3IZpBAgvmhcGjFE4vkKjVxYKK5+aD5gTsUN6S8GeRGFosidPzvkgiQgLdhn1nkDqR8tIprw8ZcZZ6CLjL4N/6VcCGfzoXrGE2QbBQ3BLgqrbY7YXr4Fd2hGA0m2l9cFj9gJHspY0PPLCKye1fK538F39u+POixmNKBGdGlXU2TKcHL7Lu7DqsWza1afX70k9sOnd9EM9fZI497f3Pg/qZt1uFjSK00eA/5xnWih3cppE5DEDrQGRTcT9US4hJr4dTYCjKL4XIriO2NqSGXMiPCQDEIB/V5pte4S1ui/kkYrgvd2VDpAhnmsQLM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ml97d3hcnrT2Tq7FnPE4MBRxToK8ZX2qn4KlRhYxQ8FWWzZU3GH/hvomM2gp?=
 =?us-ascii?Q?x/NB6jRM6o0XanMtatwzr7q3scjz1Wakgp+ATzSm84Z958Urd5QoSekomJdQ?=
 =?us-ascii?Q?XVLJbHP/Bfy8KvGPYQ69kkuiL+2SYIStuzpcYEPAn7gr3OsK1Qfq3eS+yD6w?=
 =?us-ascii?Q?Um3WkdKEGFHnW/t/d6y6iMjHp05bpFV+QO1FPyryJLrngZq+eBHkFw0sPu4T?=
 =?us-ascii?Q?aJ8uxE3tXh+WVUvTUvOfyXmlWxoMQYyBAt2YiIhfLjX4zM8smuiYKnxDJjJc?=
 =?us-ascii?Q?SyXneRzXX3P/he3ElAYbQgRt52x30LQs+4loVwpGkxNxdI5fc0TT8Jfn29fB?=
 =?us-ascii?Q?CrCHBETu5P3a18TRDLjXWCg7YOdHuGgP5wqyIFdfxpLj81XIxm76svjtSnjd?=
 =?us-ascii?Q?t7mNRIDdwmEfXU0WGFVht7WGIGBXV2h0rPNjFlQar8Bgg8KshMQrlslTbNbJ?=
 =?us-ascii?Q?SJetpzBDdyt94LgVfXKrWzjLpefP0CZUybRxj4Q+V0IzPL5OCGYuXVvqFWsG?=
 =?us-ascii?Q?C5DPOYESjiz46BLWGQQXrmFzwZsxsEIYzNKJcw0QUOMM/6+mGYAibTToxE7Z?=
 =?us-ascii?Q?EroW9NgdYDFG9zRg7xLlnjkCLiaWK2ZDPX1Mp3yLtlv8YGMcDlG6sNaiijyL?=
 =?us-ascii?Q?/1f7a8IR+5bt5eoy1XMgmAgyxjLPpWgj6KfWjzJhwXsRzWETAq6DtPvP7hyn?=
 =?us-ascii?Q?e2l5DfgS9OeJXH1UoDF/JIOk5LN4GpCn4rFOcduHtxpnzjRuSefdaZjjm5HW?=
 =?us-ascii?Q?Zvq9gWUp8WQBu4U07LwNFCvZMrmATC19H9+dmCqpAmxu/QARi6vCmt2BvS8Q?=
 =?us-ascii?Q?ifEFi5a8nhyd75eP/4GYLPIo13mUoJw2+/tzVYw64+TIYmKmR8UXpopHj4BN?=
 =?us-ascii?Q?SbcgLcD3Ds2SGIy7Dh8onv7RfFXWokDB3ju9jCHezHckEQr0lCDxkBP49rZG?=
 =?us-ascii?Q?8blDfU6n25gSaU2ZhewBN0iyEabzNhjKT+oC6orpOV9EnBd+6kW3yfkL534G?=
 =?us-ascii?Q?kMialfUpSNU35B5+MOkaue5SjrA7rbRTuheyUVz01BuWj2o9n3XJwrizR6X8?=
 =?us-ascii?Q?37q3MkVhCw0W7Gc/NWRZFe+Kp67ydF9F6uiShp4dAO2nQVOo3FXnPUiBQiI1?=
 =?us-ascii?Q?TdZPnqtDrp/JqxblsH3jRsOYePxYscBFKU+g7Ip9GBPnQqo8ve61OOK93p4I?=
 =?us-ascii?Q?j3jFLCnmn0UQLHHSQzAJAK2vpMdIR69Tp8R06Rf7lPBbo3VI8hSwA5o0AgBG?=
 =?us-ascii?Q?AN+XWlCQLaaXc4uDvE0/CV6Gb+imkl6Ghthk8P7EsypdAzKF7QPunvAqy5wd?=
 =?us-ascii?Q?fRnKZ7jpDFmNAfQtKYbM36wL5PWgmNOVR9xBTBAwHGbb6xmAub4t6n7AFIZe?=
 =?us-ascii?Q?8wshOKTNgSU4vSBqPzegfNFdYn39wG60Y+/FK+5cJ6AIBLny05OIqj8BBWUg?=
 =?us-ascii?Q?QdBMiuuLQbadJhcCFmpxmSVJ090uJcxiVhzL0ca91wntXWCSJ69VcJAtNpUq?=
 =?us-ascii?Q?5WirLrfqcapgBHjBxHfGiJjqvgB2ep0Lnn54pX5ibDyRXAJ8IrfKjBXyzz+R?=
 =?us-ascii?Q?TQKNQpsYfbuwBPARHBffFYT7OE5fEcFB6EVA4Y3fEzGW7WqO2T4kNDRs7rAS?=
 =?us-ascii?Q?aalg7J+/FTYrlHqeQOw0CLtU2EfAzVVczK5HOL4UC6JUoJUW/q58ouU0/Gi3?=
 =?us-ascii?Q?vLGun0x9C0MJ7kOWOjXU/jD670Q+tn/oMAgtEdgZlTnHcBcX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beca3c6-d168-4920-0259-08deecaa556c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 13:15:45.4460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iyEjKbNWP0GLPeTRtLS6VKtqsvD6qkn8gLbwFBWR5QDoX6HBB90drzGBMumegeTb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

> This function is called from many places and will not match when a
> process start and similarly for stop. Better find a unique function,
> also this will be called for KGD and KFD processes too.
This function is called when the last ref to an task_info is put.
Many places in the code temporarily acquire references to a task_info
but only amdgpu_vm holds the long-term reference, acquired in
amdgpu_vm_create_task_info and relased in amdgpu_vm_fini.

Tying the trace to the lifetime of task_info also guarantees that
there will be exactly one such trace for each task_info, matching
the register trace semantics

David Francis


________________________________________
From: Khatri, Sunil <Sunil.Khatri@amd.com>
Sent: Tuesday, July 28, 2026 8:26 AM
To: Francis, David; amd-gfx@lists.freedesktop.org
Cc: Liu, Shuzhou (Bill); Khatri, Sunil
Subject: Re: [PATCH] drm/amdgpu: Add trace events for pid register/deregist=
er


On 24-07-2026 06:51 pm, David Francis wrote:
> Some debugging applications need to track when a process starts
> or stops using the amdgpu driver. For those processes, add ftrace
> events that track when a amdgpu_vm task info is changed or destroyed.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 17 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  7 +++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_trace.h
> index 5324030a13f5..c79604b9dda1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -732,6 +732,23 @@ TRACE_EVENT(amdgpu_userq_state_changed,
>                     __entry->client_id, __entry->queue_type, __entry->doo=
rbell_index, __entry->to)
>   );
>
> +TRACE_EVENT(amdgpu_register_pid,
> +     TP_PROTO(uint32_t pid),
> +     TP_ARGS(pid),
> +     TP_STRUCT__entry(__field(uint32_t, pid)),
> +     TP_fast_assign(__entry->pid =3D pid;),
> +     TP_printk("amdgpu register pid %d",
> +               __entry->pid)
> +);
> +TRACE_EVENT(amdgpu_deregister_pid,
> +     TP_PROTO(uint32_t pid),
> +     TP_ARGS(pid),
> +     TP_STRUCT__entry(__field(uint32_t, pid)),
> +     TP_fast_assign(__entry->pid =3D pid;),
> +     TP_printk("amdgpu deregister pid %d",
> +               __entry->pid)
> +);
> +
>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index aac8ace9d7a6..8d31a61e8c26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2457,6 +2457,9 @@ static void amdgpu_vm_destroy_task_info(struct kref=
 *kref)
>   {
>       struct amdgpu_task_info *ti =3D container_of(kref, struct amdgpu_ta=
sk_info, refcount);
>
> +     if (ti->task.pid)
> +             trace_amdgpu_deregister_pid(ti->task.pid);
> +
>       kfree(ti);
>   }
>
> @@ -2543,6 +2546,10 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
This function is called from many places and will not match when a
process start and similarly for stop. Better find a unique function,
also this will be called for KGD and KFD processes too.
Chose a better function to add the trace although trace in itself is fine.

Regards
Sunil Khatri
>       if (vm->task_info->task.pid =3D=3D current->pid)
>               return;
>
> +     if (vm->task_info->task.pid)
> +             trace_amdgpu_deregister_pid(vm->task_info->task.pid);
> +     trace_amdgpu_register_pid(current->pid);
> +
>       vm->task_info->task.pid =3D current->pid;
>       get_task_comm(vm->task_info->task.comm, current);
>
