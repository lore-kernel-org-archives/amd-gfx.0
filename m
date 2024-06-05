Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C251DC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B8A10E26D;
	Wed,  5 Jun 2024 12:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0bKxffA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1335210E26D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 12:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClQ+88U7bzgM+AEhq5CLej/E/y3j9bYgZZ35GxI9eAhK549EElq/dP8Eng0Mw57d656Fxh+P3h/64GkaCFAJYvbDBL/tC+kKEzJcvNqn4orgxyiAi2NkRE6NeURnn4XGR32rlSh48z1HcKYSJ/HVgxEroLHAKrSY08hjoYXaNJZDmCpJfLXUKA9tCBMV74NaHFjRnjVRo9PLkzbfYcpXTxtx6wCvtMNr4lDKwA6NMuUb+ZO3kmb55bw8vHVBfgWKL+2HgwKQeiuLR4wlh6mumejcWSui/MgoltFOa7AEFlzHU9wepX2EXPGtkFT8dpZtSdKLbxBOYIpQTV9+LScnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNFRdvUnIIuQFo8q+HgjgQ0ltcSlkqMH+QuNvI23wbo=;
 b=RBPpqVTFyihO3heMnq6JhYx4/2LfENKnjnv/FN9C7bOLTwJt9gkwvkvK//ZGGKDakFFbRyO8ciVGSneCRyM/PSFx5Y0mdDE77vckvaV0oa2pwDrCxT872CWeiCRKOHcsuNEgw0biaKFdfK2zUvZWAjy9TKn9TNFRjSQ30lOcNSseGdybznOlOXhpWYzCvRXenGkOHF9FYMv4JivJUlBMr6+45OcSyF7muw/pBz3NAaloOpxD5dwJHt7R+BeCwi4/qBbIBPV7i2qYSecPVH6SdzppCFJAzYJg6QRHXGwNsL2DJWMhF1StsReDkp+XA9oEc7R34ngkQUg40el55EHEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNFRdvUnIIuQFo8q+HgjgQ0ltcSlkqMH+QuNvI23wbo=;
 b=V0bKxffAQ2B1ZihTUzp2kOxzNgyEW/n1zklZAyhsPpA7F+WOJb1xqd/5XcXsXI9Z0UfifCGbwNKzTiEgwqztN1rIR4tqksALN90SOMRwAWUdOizdK36zf9BbZVQYfUoeRWy7D+s8ry6s/bU0t9EdBohCZU9se7XQPJXdM83rV+g=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 12:18:58 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 12:18:57 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/display: avoid large on-stack structures"
Thread-Topic: [PATCH] Revert "drm/amd/display: avoid large on-stack structures"
Thread-Index: AQHatqbyN5fPCRkMLkGAesXcx1cyy7G34haAgAE1mQo=
Date: Wed, 5 Jun 2024 12:18:57 +0000
Message-ID: <CH0PR12MB528494CB174C07542018D24B8BF92@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20240604174504.725893-1-aurabindo.pillai@amd.com>
 <36c75f1e-49f1-4e0f-b363-d5e09b21c16d@amd.com>
In-Reply-To: <36c75f1e-49f1-4e0f-b363-d5e09b21c16d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T12:18:57.347Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CY5PR12MB6299:EE_
x-ms-office365-filtering-correlation-id: 35b5126e-fd68-4f79-1258-08dc8559aca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?qRylYA+gAIS8y/h9+PkfCC9pnVFRnrtw4+ikb3BlFiwZ7UMlz54F8vxBwLsu?=
 =?us-ascii?Q?QrM/1YmHxu4zVdEzUW6XdSgBoobcA/J2yl5Lx4zaZUn5I9+TMI/wRAU9GBWE?=
 =?us-ascii?Q?CXvp1BAfID8dL2fOVsbGHgyGqeAt+W4J4J1O5eBM3pbdOvYzpVN6N/4AEZJZ?=
 =?us-ascii?Q?PF1r3k7ide2B1s41n4J4eAmug1tzFOnRaBp0gj1BInJR9HshdcUu+KWJ6u31?=
 =?us-ascii?Q?YeCdMZgmWv7qMHZJnmM2bPVTgrKEwbvFxur4Kxe5BoG1hpeqUf/J5gjiI8Z2?=
 =?us-ascii?Q?pfHSihjO6azaflh9d5GvZj2YOn64DCV9L9BbxYAxAPVqDi6NLRnUyvSPCF78?=
 =?us-ascii?Q?ZMTGyQ83VIs3rdqhD3i9bU57bRfNZ6Bql8fKLSRoUPuoDDcEnXPXnCuDPE3x?=
 =?us-ascii?Q?0KrsAvK7aoXmx4UUP6Y5Ljp/KWMpdupRXs3pR4DHFJwP1pxyGdb5/7QZw4G1?=
 =?us-ascii?Q?R7BVVWsgENwuH6jm/dRUnGFlyAYE62v2DkrRjxPx9f8uxFlJxeBFI3x4Q5+n?=
 =?us-ascii?Q?etoxT25Cd/fwFcSn8j5tHFMJSU6NfZQg0l1v7anHPgXZ17TPk+yF2KEY8QE4?=
 =?us-ascii?Q?/na/EiwyodypDTVb3z/H/xGUAUUGdRBfifbuE9AAu6i3OMubwIu5Y8QcEtcl?=
 =?us-ascii?Q?KBdxsUKpzAxwvUI8Flo3E/dht2CZCSCBT9Czyf4WKezq2jnoavm1g70CMOEH?=
 =?us-ascii?Q?BpUODlRPgcUH+9U8TFaqvM99qoJgeLyjQL6zfVBZnHiKgEY5mfFISwujkN0J?=
 =?us-ascii?Q?ervzIVdRz8EcOUiOFVJnFeLa1TtWErLsj4Gu2BYuzrk8tgylg1Bav6Uq3lok?=
 =?us-ascii?Q?wBW5rGBbpQwNxiKxqFcXXygxJTGbrLX5G5HV5IlmxQJYJU2g10e5bvyvHE6S?=
 =?us-ascii?Q?NVP+6HHTGVFh7Pwdd+b/bMq0Rx6xH9Pp1y2LMdkiPiO+WvddCcvM1uWNMQkC?=
 =?us-ascii?Q?zTwf49RdGhkHM2lcMv3R+Yt5L67OAkxGKBZ70ocrmMvBuhtexYnCgEcOkLWd?=
 =?us-ascii?Q?6Cy39dENDaGL4QP7LTbvS1pMF15g95T2NCUrPuQ16lq1mijjvMdpJdicDfVy?=
 =?us-ascii?Q?BtkRdNGjZHUE9FFpkvg7e46uefvWK9wLP8kSvqkpIfCH6g3gF+iDeSWkAOgz?=
 =?us-ascii?Q?azWkP9fcjJEhbaS0wPRfsQiGFd+Vldvfd3WQO90s9Ac0l5W3BnblcUK6n/eJ?=
 =?us-ascii?Q?/C+2MW7RtROs/T1pcqKlV5q/D5F1hH4TW8DZ1ulwXRQ6Zkeuk5pVhxmAu5C9?=
 =?us-ascii?Q?9ZeYUNDgjh2QmokhgtRrb1T123f90rLBd4bki9VGsg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zApVI8dfNeT0pgIxmJEBNDBSjfSIK5tJkpIpeEb64AdhQN80sulX2i98MPPZ?=
 =?us-ascii?Q?qz4E7aetDga2mLx549gp/SyzLSWj1aiggReYLo6YOtkFvr3yYJSePSIZZUCi?=
 =?us-ascii?Q?t8sYXqLCAGLxyBHm1I9SPEey3RAYhVAUqD3vHjD+Nr+HVK7kFcQu04XcH35+?=
 =?us-ascii?Q?1v/WUYowWEuDlQjhhcVF6IvcV6FbwE70RIDAPj5A4FV7zeKOGSQjS9Amvgph?=
 =?us-ascii?Q?+zzDUkdiPyUo5gU4p/9FLhnZPZMB1X+6CWegs9he7eL8n0INthhgqm+q3p80?=
 =?us-ascii?Q?BWNQ/aUp2wn2ek0js//p6U2gs3Tpx+jRWCo4yRriSyHrduF8JbexrLLTdE+M?=
 =?us-ascii?Q?xnKfM2m8pq+iyos2E/WKlCMDbLiAROCuK/7lGDcrZzNU1kmWkg+OK034EdJ0?=
 =?us-ascii?Q?1kVfjYIWJ7KxHyfecdmbcMCo5hZONxogsqigFxRd8fjMCFbvU5gKgWPOFM3y?=
 =?us-ascii?Q?0KKXdp9Jz9rua08hd7TdxC27pvSoVMviPKivAqf9p1ZsuP4c/UIvH6EByijT?=
 =?us-ascii?Q?+zjbLXjgHhMQ23oVTZk8SzCSe/O9IXNPKIMvecidCoON/s4eSq85JJuZ8xpy?=
 =?us-ascii?Q?ku3KvXVeHCV7UbG0jVQXVJItSUI7eAqQ2TBe900btcrM1hIEhhign2aAcDEl?=
 =?us-ascii?Q?I+M37qVNUl/l/gy+M0wCw+67zYIXD05UV38h+N5GmjsrTrJFquD8KXRa5cUv?=
 =?us-ascii?Q?Y85KwVz0We4pFKlYDPPPRiEoHa8XtCB5CTFVQ53407n690OXdU0NtNIIfr5q?=
 =?us-ascii?Q?EgttuIPBg54fBZQulX1oBWcPt9ShGYItRPDsmsWwmi94Xl6RyFy5fx5wrjNu?=
 =?us-ascii?Q?F4GMZORjVdD4+w+MS5PbavpDqHD7O47VXIVrkfDq/nE45gZGKL9UgdZFlHaE?=
 =?us-ascii?Q?VSkP+W7wIP1uOTwZZkrwCqSu8B8nhH4qtRuhdhvxOS765+018UggA+VuOn/Z?=
 =?us-ascii?Q?EKmrWWZz6bdGf3dWnF3tKsxYNO4zKIIiaKR0xLbSU9LR8SEaxpq8gH37c0Qo?=
 =?us-ascii?Q?OtybQTktCaFf0Mlx9OLDI5U8dEakgaQoAFImhIAbR9Jo3W3BNs+PrHhucOAt?=
 =?us-ascii?Q?yg7ns78FeJGpOI2FxrkdtCdQ3NhNSC32BLU/B5bg9Bbo0NVHmckTlBYlZYqA?=
 =?us-ascii?Q?5PXTPkioIJzZtILAgwC+a/V/KOwnTs/xcUmpG+AOHWiUzM6jW7Oev0IQRhm6?=
 =?us-ascii?Q?2g4raMEWaAOqUcQLXhiIWwu7pr/lgX24vjjGxjC57L4tkFm171cKJTE1nBfg?=
 =?us-ascii?Q?CPBExjTSIhbQHbwDKmnUKOHcs3pj6naj2O9RYy77oEn42QT/sekwM3RYUj9u?=
 =?us-ascii?Q?39+rSZoLCyMxZqVeBidg/lJeUIu3chRg4FIR6KoWHJD+iVMfG65fQgK91aiZ?=
 =?us-ascii?Q?SEeGQrjUyChF0Xpz7LU9LZb7KsglGQ9ALqFvjl//rPMQPLbiS4P9oRKzqP4z?=
 =?us-ascii?Q?YwSngkR3b2LLSRc760dRCqGIhlj8F3nMA5B+uZAapZqeeanaXWzc7Nb+sonl?=
 =?us-ascii?Q?vpNlzhGBh6dL4zgptg6Uu4cW4/fp0QTUEFulaUIrBpxQ7Frk6ri4RqzcBBk3?=
 =?us-ascii?Q?xftTPXcGI/naU5MaXOs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB528494CB174C07542018D24B8BF92CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b5126e-fd68-4f79-1258-08dc8559aca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 12:18:57.4636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXuq8sncWjWQGViUm+N7lnRcvwuSjlYqtGqcI3QiPFQ1adCWcV9cJX7RyVbbFeMaQTmB7QZ9HG/eTnJ9YGfEsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
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

--_000_CH0PR12MB528494CB174C07542018D24B8BF92CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks for the heads up!

--

Regards,
Jay
________________________________
From: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Sent: Tuesday, June 4, 2024 1:50 PM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: arnd@arndb.de <arnd@arndb.de>; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrigo <Rodrig=
o.Siqueira@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/display: avoid large on-stack structur=
es"

On 6/4/24 13:45, Aurabindo Pillai wrote:
> This reverts commit 44069f0f9b1fe577c5d4f05fa9eb02db8c618adc since
> the code path is called from FPU context, and triggers error like:
>
> [   26.924055] BUG: sleeping function called from invalid context at incl=
ude/linux/sched/mm.h:306
> [   26.924060] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 102=
2, name: modprobe
> [   26.924063] preempt_count: 2, expected: 0
> [   26.924064] RCU nest depth: 0, expected: 0
> [   26.924066] Preemption disabled at:
> [   26.924067] [<ffffffffc089e5e0>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> [   26.924322] CPU: 9 PID: 1022 Comm: modprobe Not tainted 6.8.0+ #20
> [   26.924325] Hardware name: System manufacturer System Product Name/CRO=
SSHAIR VI HERO, BIOS 6302 10/23/2018
> [   26.924326] Call Trace:
> [   26.924327]  <TASK>
> [   26.924329]  dump_stack_lvl+0x37/0x50
> [   26.924333]  ? dc_fpu_begin+0x30/0xd0 [amdgpu]
> [   26.924589]  dump_stack+0x10/0x20
> [   26.924592]  __might_resched+0x16a/0x1c0
> [   26.924596]  __might_sleep+0x42/0x70
> [   26.924598]  __kmalloc_node_track_caller+0x2ad/0x4b0
> [   26.924601]  ? dm_helpers_allocate_gpu_mem+0x12/0x20 [amdgpu]
> [   26.924855]  ? dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
> [   26.925122]  kmemdup+0x20/0x50
> [   26.925124]  ? kernel_fpu_begin_mask+0x6b/0xe0
> [   26.925127]  ? kmemdup+0x20/0x50
> [   26.925129]  dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
> [   26.925393]  dc_create+0x311/0x670 [amdgpu]
> [   26.925649]  amdgpu_dm_init+0x2aa/0x1fa0 [amdgpu]
> [   26.925903]  ? irq_work_queue+0x38/0x50
> [   26.925907]  ? vprintk_emit+0x1e7/0x270
> [   26.925910]  ? dev_printk_emit+0x83/0xb0
> [   26.925914]  ? amdgpu_device_rreg+0x17/0x20 [amdgpu]
> [   26.926133]  dm_hw_init+0x14/0x30 [amdgpu]
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_state.c   | 16 +++++-----------
>   .../display/dc/resource/dcn401/dcn401_resource.c | 16 +++++-----------
>   2 files changed, 10 insertions(+), 22 deletions(-)

You probably want something like
https://patchwork.freedesktop.org/patch/597044/ instead.

>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_state.c
> index 8ea9391c60b7..70928223b642 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> @@ -193,11 +193,7 @@ static void init_state(struct dc *dc, struct dc_stat=
e *state)
>   struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_=
params *params)
>   {
>   #ifdef CONFIG_DRM_AMD_DC_FP
> -     struct dml2_configuration_options *dml2_opt;
> -
> -     dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERN=
EL);
> -     if (!dml2_opt)
> -             return NULL;
> +     struct dml2_configuration_options dml2_opt =3D dc->dml2_options;
>   #endif
>        struct dc_state *state =3D kvzalloc(sizeof(struct dc_state),
>                        GFP_KERNEL);
> @@ -211,14 +207,12 @@ struct dc_state *dc_state_create(struct dc *dc, str=
uct dc_state_create_params *p
>
>   #ifdef CONFIG_DRM_AMD_DC_FP
>        if (dc->debug.using_dml2) {
> -             dml2_opt->use_clock_dc_limits =3D false;
> -             dml2_create(dc, dml2_opt, &state->bw_ctx.dml2);
> +             dml2_opt.use_clock_dc_limits =3D false;
> +             dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2);
>
> -             dml2_opt->use_clock_dc_limits =3D true;
> -             dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_sour=
ce);
> +             dml2_opt.use_clock_dc_limits =3D true;
> +             dml2_create(dc, &dml2_opt, &state->bw_ctx.dml2_dc_power_sou=
rce);
>        }
> -
> -     kfree(dml2_opt);
>   #endif
>
>        kref_init(&state->refcount);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> index 8dfb0a3d21cb..247bac177d1b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
> @@ -1581,27 +1581,21 @@ static struct dc_cap_funcs cap_funcs =3D {
>
>   static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_=
params *bw_params)
>   {
> -     struct dml2_configuration_options *dml2_opt;
> -
> -     dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERN=
EL);
> -     if (!dml2_opt)
> -             return;
> +     struct dml2_configuration_options dml2_opt =3D dc->dml2_options;
>
>        DC_FP_START();
>
>        dcn401_update_bw_bounding_box_fpu(dc, bw_params);
>
> -     dml2_opt->use_clock_dc_limits =3D false;
> +     dml2_opt.use_clock_dc_limits =3D false;
>        if (dc->debug.using_dml2 && dc->current_state && dc->current_state=
->bw_ctx.dml2)
> -             dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2);
> +             dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2)=
;
>
> -     dml2_opt->use_clock_dc_limits =3D true;
> +     dml2_opt.use_clock_dc_limits =3D true;
>        if (dc->debug.using_dml2 && dc->current_state && dc->current_state=
->bw_ctx.dml2_dc_power_source)
> -             dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_d=
c_power_source);
> +             dml2_reinit(dc, &dml2_opt, &dc->current_state->bw_ctx.dml2_=
dc_power_source);
>
>        DC_FP_END();
> -
> -     kfree(dml2_opt);
>   }
>
>   enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *=
plane_state)
--
Hamza


--_000_CH0PR12MB528494CB174C07542018D24B8BF92CH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for the heads up!</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" style=3D"color: inherit;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Mahfooz, Hamza &lt;Ha=
mza.Mahfooz@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 4, 2024 1:50 PM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> arnd@arndb.de &lt;arnd@arndb.de&gt;; Deucher, Alexander &lt;Alex=
ander.Deucher@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; =
Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Zuo, Jerry &lt;Jerry.Zu=
o@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amd/display: avoid large on-st=
ack structures&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 6/4/24 13:45, Aurabindo Pillai wrote:<br>
&gt; This reverts commit 44069f0f9b1fe577c5d4f05fa9eb02db8c618adc since<br>
&gt; the code path is called from FPU context, and triggers error like:<br>
&gt; <br>
&gt; [&nbsp;&nbsp; 26.924055] BUG: sleeping function called from invalid co=
ntext at include/linux/sched/mm.h:306<br>
&gt; [&nbsp;&nbsp; 26.924060] in_atomic(): 1, irqs_disabled(): 0, non_block=
: 0, pid: 1022, name: modprobe<br>
&gt; [&nbsp;&nbsp; 26.924063] preempt_count: 2, expected: 0<br>
&gt; [&nbsp;&nbsp; 26.924064] RCU nest depth: 0, expected: 0<br>
&gt; [&nbsp;&nbsp; 26.924066] Preemption disabled at:<br>
&gt; [&nbsp;&nbsp; 26.924067] [&lt;ffffffffc089e5e0&gt;] dc_fpu_begin+0x30/=
0xd0 [amdgpu]<br>
&gt; [&nbsp;&nbsp; 26.924322] CPU: 9 PID: 1022 Comm: modprobe Not tainted 6=
.8.0+ #20<br>
&gt; [&nbsp;&nbsp; 26.924325] Hardware name: System manufacturer System Pro=
duct Name/CROSSHAIR VI HERO, BIOS 6302 10/23/2018<br>
&gt; [&nbsp;&nbsp; 26.924326] Call Trace:<br>
&gt; [&nbsp;&nbsp; 26.924327]&nbsp; &lt;TASK&gt;<br>
&gt; [&nbsp;&nbsp; 26.924329]&nbsp; dump_stack_lvl+0x37/0x50<br>
&gt; [&nbsp;&nbsp; 26.924333]&nbsp; ? dc_fpu_begin+0x30/0xd0 [amdgpu]<br>
&gt; [&nbsp;&nbsp; 26.924589]&nbsp; dump_stack+0x10/0x20<br>
&gt; [&nbsp;&nbsp; 26.924592]&nbsp; __might_resched+0x16a/0x1c0<br>
&gt; [&nbsp;&nbsp; 26.924596]&nbsp; __might_sleep+0x42/0x70<br>
&gt; [&nbsp;&nbsp; 26.924598]&nbsp; __kmalloc_node_track_caller+0x2ad/0x4b0=
<br>
&gt; [&nbsp;&nbsp; 26.924601]&nbsp; ? dm_helpers_allocate_gpu_mem+0x12/0x20=
 [amdgpu]<br>
&gt; [&nbsp;&nbsp; 26.924855]&nbsp; ? dcn401_update_bw_bounding_box+0x2a/0x=
f0 [amdgpu]<br>
&gt; [&nbsp;&nbsp; 26.925122]&nbsp; kmemdup+0x20/0x50<br>
&gt; [&nbsp;&nbsp; 26.925124]&nbsp; ? kernel_fpu_begin_mask+0x6b/0xe0<br>
&gt; [&nbsp;&nbsp; 26.925127]&nbsp; ? kmemdup+0x20/0x50<br>
&gt; [&nbsp;&nbsp; 26.925129]&nbsp; dcn401_update_bw_bounding_box+0x2a/0xf0=
 [amdgpu]<br>
&gt; [&nbsp;&nbsp; 26.925393]&nbsp; dc_create+0x311/0x670 [amdgpu]<br>
&gt; [&nbsp;&nbsp; 26.925649]&nbsp; amdgpu_dm_init+0x2aa/0x1fa0 [amdgpu]<br=
>
&gt; [&nbsp;&nbsp; 26.925903]&nbsp; ? irq_work_queue+0x38/0x50<br>
&gt; [&nbsp;&nbsp; 26.925907]&nbsp; ? vprintk_emit+0x1e7/0x270<br>
&gt; [&nbsp;&nbsp; 26.925910]&nbsp; ? dev_printk_emit+0x83/0xb0<br>
&gt; [&nbsp;&nbsp; 26.925914]&nbsp; ? amdgpu_device_rreg+0x17/0x20 [amdgpu]=
<br>
&gt; [&nbsp;&nbsp; 26.926133]&nbsp; dm_hw_init+0x14/0x30 [amdgpu]<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/core/dc_state.c&nbsp;&nbsp;=
 | 16 +++++-----------<br>
&gt;&nbsp;&nbsp; .../display/dc/resource/dcn401/dcn401_resource.c | 16 ++++=
+-----------<br>
&gt;&nbsp;&nbsp; 2 files changed, 10 insertions(+), 22 deletions(-)<br>
<br>
You probably want something like<br>
<a href=3D"https://patchwork.freedesktop.org/patch/597044/">https://patchwo=
rk.freedesktop.org/patch/597044/</a> instead.<br>
<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_state.c<br>
&gt; index 8ea9391c60b7..70928223b642 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c<br>
&gt; @@ -193,11 +193,7 @@ static void init_state(struct dc *dc, struct dc_s=
tate *state)<br>
&gt;&nbsp;&nbsp; struct dc_state *dc_state_create(struct dc *dc, struct dc_=
state_create_params *params)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMD_DC_FP<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_options *dml2_opt;=
<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dml2_opt =3D kmemdup(&amp;dc-&gt;dml2_option=
s, sizeof(*dml2_opt), GFP_KERNEL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!dml2_opt)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_options dml2_opt =
=3D dc-&gt;dml2_options;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_state *state =3D k=
vzalloc(sizeof(struct dc_state),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KER=
NEL);<br>
&gt; @@ -211,14 +207,12 @@ struct dc_state *dc_state_create(struct dc *dc, =
struct dc_state_create_params *p<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #ifdef CONFIG_DRM_AMD_DC_FP<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;debug.using_dml2)=
 {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_opt-&gt;use_clock_dc_limits =3D false;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_create(dc, dml2_opt, &amp;state-&gt;bw_ctx.dml2);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_opt.use_clock_dc_limits =3D false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_create(dc, &amp;dml2_opt, &amp;state-&gt;bw_ctx.dml2);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_opt-&gt;use_clock_dc_limits =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_create(dc, dml2_opt, &amp;state-&gt;bw_ctx.dml2_dc_power_source);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_opt.use_clock_dc_limits =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_create(dc, &amp;dml2_opt, &amp;state-&gt;bw_ctx.dml2_dc_power_sour=
ce);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfree(dml2_opt);<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_init(&amp;state-&gt;ref=
count);<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_res=
ource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c<=
br>
&gt; index 8dfb0a3d21cb..247bac177d1b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c=
<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c=
<br>
&gt; @@ -1581,27 +1581,21 @@ static struct dc_cap_funcs cap_funcs =3D {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void dcn401_update_bw_bounding_box(struct dc *dc, s=
truct clk_bw_params *bw_params)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_options *dml2_opt;=
<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dml2_opt =3D kmemdup(&amp;dc-&gt;dml2_option=
s, sizeof(*dml2_opt), GFP_KERNEL);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!dml2_opt)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dml2_configuration_options dml2_opt =
=3D dc-&gt;dml2_options;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_START();<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn401_update_bw_bounding_bo=
x_fpu(dc, bw_params);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dml2_opt-&gt;use_clock_dc_limits =3D false;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dml2_opt.use_clock_dc_limits =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;debug.using_dml2 =
&amp;&amp; dc-&gt;current_state &amp;&amp; dc-&gt;current_state-&gt;bw_ctx.=
dml2)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_reinit(dc, dml2_opt, &amp;dc-&gt;current_state-&gt;bw_ctx.dml2);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_reinit(dc, &amp;dml2_opt, &amp;dc-&gt;current_state-&gt;bw_ctx.dml=
2);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; dml2_opt-&gt;use_clock_dc_limits =3D true;<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dml2_opt.use_clock_dc_limits =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;debug.using_dml2 =
&amp;&amp; dc-&gt;current_state &amp;&amp; dc-&gt;current_state-&gt;bw_ctx.=
dml2_dc_power_source)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_reinit(dc, dml2_opt, &amp;dc-&gt;current_state-&gt;bw_ctx.dml2_dc_=
power_source);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dml2_reinit(dc, &amp;dml2_opt, &amp;dc-&gt;current_state-&gt;bw_ctx.dml=
2_dc_power_source);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_END();<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; kfree(dml2_opt);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; enum dc_status dcn401_patch_unknown_plane_state(struct dc_=
plane_state *plane_state)<br>
-- <br>
Hamza<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB528494CB174C07542018D24B8BF92CH0PR12MB5284namp_--
