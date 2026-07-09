Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B9CC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 13:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94AA210E095;
	Thu,  9 Jul 2026 13:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qjQyPE5E";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA2210E06E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 13:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQjchC5oi8TTVi/xGk/vVdFovLQ2LqDPL4qqnxQ8diIxsngxKkoDdQLVrKFsUYLxVk39kLpsjgiZy5mnq/+G/ABsK+frYwxMobzr5UCq3L83ARwFOw0vUJ7Ca7PsuaIj4T7PElHUA+Yp/gbG0m1Cqu4s7MRERulfeFQyDxfy6bzMYD5qlBaP5toEwQ2j7t80FLSqj2Hh7jaxFvXLw8fTlV9YqjArQln4p6fdX6gXr+6xjJpJ8sV4x23EvsgoO79AvFVA0HP4vaR4S5+N2YaSms1OF1ETBJ5Xm7lMiyNKP+qFn6WDfaubtOXlmT+Oz9weSIyXn7Th02Pskw4QYnXa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6LikXnx3lsR/DLvBjMQYQqW0YoM57b9dghuXi5EhuI=;
 b=Ufk3vS5L0pzgoQX8VoRPMidP8jS62KFRUs5UIDs/4N5VEuIuOm7oHpytpsE5WhGb8AKJAOC0/5rt5ygRxEI1+rgc/T/1p478lC5Wnxel7pShyZZvUsIW0Iaf+q9SCSoBWX6p7By7oxLB08ZbowXRM7DT4THH3077mUZOzLe6f+xaezhvSaj/cZNlA1hakWW5qvYwFvfCAzUOxFWnayOqJum7YNzgkEYI4ZP6tj4BxkXJ/f7EOfvrtOo0/wIWhlTIFV5kiE0hIQERoVnDtogmpMgAalK2m255c6cEckNhszEYrbyDzFTFNUaKHGWd+G8+/LANwzvUGqAKG3XUnwjDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6LikXnx3lsR/DLvBjMQYQqW0YoM57b9dghuXi5EhuI=;
 b=qjQyPE5E6+fvQssSEiNDVe0AmoSUWoPKqMekCQ8+M0Pxr9vblUitznRqBDE3vzl5Fyxv7NWPwavgVCoOATX4mtFfDX6UbPqFGb6zijZGl0cKgjY5KJYeaycLar65vIN+rBvbPBHN7iUGSUbjobXivqqlFI+rJGML2pb0DeAGgpo=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by CH3PR12MB9283.namprd12.prod.outlook.com (2603:10b6:610:1cd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:09:32 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:09:30 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu/userq: fix NULL deref in amdgpu_userq_evict_all
Thread-Topic: [PATCH] drm/amdgpu/userq: fix NULL deref in
 amdgpu_userq_evict_all
Thread-Index: AQHdD3mG0koeIREnh0GNAekTjY8V67ZlKVHP
Date: Thu, 9 Jul 2026 13:09:30 +0000
Message-ID: <SA1PR12MB8144666A298CFDE84A5540D1EFFE2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260709080353.1896894-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260709080353.1896894-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-09T13:09:29.319Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|CH3PR12MB9283:EE_
x-ms-office365-filtering-correlation-id: 91a4a6f0-93e0-4617-2858-08deddbb4fd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: c8bSX32uf44Oi4MVYZWg7AbG0QkSZVnUBis+jAx2Yr/U7tYUghCEiFM6Gka5dCpkgE+RestzjRUtwflfklPG+lVqCkYpvoAcR3KKRu/+GYiKgOtnQAcWnVcxgFxO37bBAZLr+9RFXBiNFK381DrrUNUR5vuHMPFHySfkPSyN8+kSeBgwa0ptQ2+USOKZJr8I0tyAahJrX9Vwq5c2jLB2LLpt1GnQp937dk8sEt4JPfzKbfmwiK3IoB5J+uYz/ajCsJ88iNj0ZnDzy8CrFCidTQ3u8ILc4n7++eehjkZJqGCodxmHYyKZUjvH7s4y4tXqUNDv/MYqJdLiZmDH6ukc6Wn66q3je5Sto6JNFeTqpMajpNcdeIvjmFMHe08J+VmRGWcOxmIgDnBFHXsdJnbcLRW4Rk9TwN5ac7aQJtWtaH1xpyP7Y+i37nZ+W96c9U0gmwEbvN7wEub1UAKXaFFqw7y3Z1FM5/u7g9xpJ+JQZXX/CcBzuRmVMZXRIkLSiKfY/fQh6pBJsuClDcHeF+bxm8y0aNwNu1430+QUlvti2cz2Pn1PHStVR24LwvPMGIqxtEqw6vJmC0WobtOVkFjYnq5jU2xl2kJqtKMs+1zAg9G5LnJdH3s5IsFEWXs4iJlnVoDx0S+0SJ7B1W5OwcEXgy6P+osCdLBU+iQk2vP3h6SpyXQTpU6Vl6pxI1jZ+KPer+iHczj4EwUSmXQqprUxo08V2S0iA3MZssjJfBM5wgM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WObt2JpqQrwZfNjJRmrnPoUAVEan99y3iv078nrz7d0+RuS2kjdg1vneL4oX?=
 =?us-ascii?Q?b4v9OuhSIKJ1zcpvyIJzJ7ZlixF6vRqA3Pnj5UG25hNIiVSTYlNKMdXECrYM?=
 =?us-ascii?Q?zufyT8R2tf5m2M+VECnrLWgavJOEgjnR3ARYxNrC5eZg7KFKrSto0kSxUqWH?=
 =?us-ascii?Q?VISaXAc/2DXXgex7FP3WFesRIocqdysAQvQlHs3a3byfZkqkdCpnAqT7eGdf?=
 =?us-ascii?Q?IYtMaB707XnBrck35uRQ3C3UN7ghT8luZxBbTgKr+McgrNULe1V+5+vem77z?=
 =?us-ascii?Q?n7qeFC4jJn3lrQEgePhoOGJcJy8wYTUjZhlyiFuynLX/HavN1lsFWGIR2k4I?=
 =?us-ascii?Q?2HacBriClXqyg3g/aaWU+xJW4XW9/EfMtGe+3L0DoJA4Z8dhm42gS7XE6Smw?=
 =?us-ascii?Q?DzNQ8zW/+2n/iiGPGMBECjVirjAzihj0wvtnvP68XvCdhU5v/MiTYYuidhi3?=
 =?us-ascii?Q?lxF8g/3sy5WVJUrISFOakbI3Ewc3DgrZeSXUs6+CFBsFcHKo6YN+bLRap9zi?=
 =?us-ascii?Q?YO6ejU9YgOCxHm56+ePSsxDOen6gPyLEgcShAbxuxTlw3oAJxDQEtAZ0MPDS?=
 =?us-ascii?Q?UEQFFG0bSZi+ZwuHBau9R2wraX6sCctBp0jgqtqLp4c6yGT7Zu2Z/ibWXArv?=
 =?us-ascii?Q?aeNbglCBcT7ayFZ1er5X9Z59AbenLPRqetaSnXJd9z395ceX2fC+5qWp1gWO?=
 =?us-ascii?Q?cNFy1aIWaY9hsQIjLMyLJ0lZq5wLJVEPKJskm6F6G7272Mi6EXIRiDRQZC+F?=
 =?us-ascii?Q?6WrY+40Ql3b+LTJfB66AehIxHBDouW+PdrJaW1g6OQrSU4rjm4zStXrZvFLh?=
 =?us-ascii?Q?g4MjnlHDhQAXnvr5zZAnxJHyv91hBxYysLtw71PIZjEdgggoF5z1nwbUlKg8?=
 =?us-ascii?Q?TzByAkxVK0X5DpQXM9FzxaVUIAvNCRnHfVF9Y8EFeOuqDWCG+gutvJrv92kx?=
 =?us-ascii?Q?p305mF0Hbc4+pg9L3vmI/A+6GAP/s5txnVdEOeb3p6qwRiBP3zd0ieHVRdFa?=
 =?us-ascii?Q?vGBgg0UgIpMWp9Pq34wcDTgrqOWA/t6+uIOZwSEVkJqAFRGoi703muQ7DfW0?=
 =?us-ascii?Q?nmRGTqthcEqdiuS37/Vp/sBsxU9Tlvay3FTakm0Gv4MAeGbaTKIw5bxdqWjE?=
 =?us-ascii?Q?QVG4Hpujz9vNahEu/NWlvvnpdImiF4aqCLx+QUO4EGx5tNeWd0Jg6GOLqxdk?=
 =?us-ascii?Q?DXel68ulYuAwM3k8jxOHFHq1e2tXAC0GlgEtfYS5lMTaAiWLyFZX/pZ3gwVr?=
 =?us-ascii?Q?xfa2ETgFnusQsFUbamIaIM1XpcACJxyVbXK+Qp0B4nqNG+RnfdTcrI531/NI?=
 =?us-ascii?Q?+ZgFXtHnoEitFcUDdyL+NQgorLNqZngOPVOkPbiWYYLy8QYMH8NEbp2gv4zH?=
 =?us-ascii?Q?HoIYO2bTdu2PFB5EoLOy7bz6ODD91wUGK49Q2HFOhJNjsGFRx+b+7zRnwbSt?=
 =?us-ascii?Q?g5gQLgaAvoTnxG7/jzH4zzL8/wb1xMF0aadniCWkFLUIMipJu0EmPdjeZBpb?=
 =?us-ascii?Q?EVWcrmAQhwlMhVyOee5QPv8UNBurJIv2/ydKQiRSixV0/HGussFJdoqUVJ00?=
 =?us-ascii?Q?LwB6g1Nhpa5k026Om+vrEnf8BmA63GRe7zalaNksrfcW+rro2TracN//8vcM?=
 =?us-ascii?Q?dHRPuHXNE8Etmd1v+/hiGOXVK75/mnh/OwTgWwe4rksxD6/n4OpVbcH7bWcd?=
 =?us-ascii?Q?YSi5nw3f1tjDpMF0G5dY/iLby/9brF7T8ioQR3C6bsQzX7p1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a4a6f0-93e0-4617-2858-08deddbb4fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 13:09:30.0161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCLNnc9Kwq2puSoE4hKbFHGl/CvYNVDCztgvOELD+4KAbsdceNtxgAnPT19s23z8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9283
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

Nice fix

Reviewed-By: David Francis <David.Francis@amd.com>

________________________________________
From: Jesse Zhang <Jesse.Zhang@amd.com>
Sent: Thursday, July 9, 2026 4:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander; Koenig, Christian; Francis, David; Zhang, Jesse(Jie=
)
Subject: [PATCH] drm/amdgpu/userq: fix NULL deref in amdgpu_userq_evict_all

amdgpu_userq_evict_all() dereferenced queue->fw_obj.obj->vm_bo->vm to
reach the process VM when bumping the queue eviction counter. The fw_obj
is a kernel-allocated, GTT-pinned firmware/MQD buffer object that is
never added to the process VM, so its vm_bo is always NULL. On the first
eviction of any user queue, this faulted:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 2941.106372] Workqueue: events amdgpu_eviction_fence_suspend_worker [amdg=
pu]
[ 2941.106585] RIP: 0010:amdgpu_userq_evict+0xc7/0x140 [amdgpu]
[ 2941.106729] Code: ff ff ff ff 48 c7 45 d8 00 00 00 00 e8 92 5b 02 f7 49 =
89 c4 48 85 c0 74 62 45 31 ed 49 8b 44 24 78 31 f6 48 8b 80 60 02 00 00 <48=
> 8b 38 e8 c1 b8 ce ff 4c 89 e7 e8 19 db ff ff b9 08 00 00 00 48
[ 2941.106739] RSP: 0018:ffffd4bd485fbdc0 EFLAGS: 00010246
[ 2941.106743] RAX: 0000000000000000 RBX: ffff8e5bd3358cb0 RCX: 00000000000=
00000
[ 2941.106747] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffd4bd485=
fbd58
[ 2941.106751] RBP: ffffd4bd485fbde8 R08: ffff8e5bdd888000 R09: ffffd4bd485=
fbb38
[ 2941.106755] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8e5bd28=
20c00
[ 2941.106759] R13: 0000000000000000 R14: ffff8e5bd9cf7360 R15: ffff8e5bd33=
58cb0
[ 2941.106764] FS:  0000000000000000(0000) GS:ffff8e5f342c9000(0000) knlGS:=
0000000000000000
[ 2941.106769] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2941.106773] CR2: 0000000000000000 CR3: 000000001d840000 CR4: 00000000007=
50ef0
[ 2941.106778] PKRU: 55555554
[ 2941.106780] Call Trace:
[ 2941.106783]  <TASK>
[ 2941.106787]  amdgpu_eviction_fence_suspend_worker+0xd8/0x160 [amdgpu]
[ 2941.106898]  process_scheduled_works+0xa6/0x420
[ 2941.106904]  worker_thread+0x12a/0x270
[ 2941.106907]  kthread+0x10d/0x230
[ 2941.106911]  ? __pfx_worker_thread+0x10/0x10
[ 2941.106915]  ? __pfx_kthread+0x10/0x10
[ 2941.106918]  ret_from_fork+0x17c/0x1f0
[ 2941.106922]  ? __pfx_kthread+0x10/0x10
[ 2941.106926]  ret_from_fork_asm+0x1a/0x30
[ 2941.106931]  </TASK>

The queue already carries a direct pointer to its VM in queue->vm, which
is the value the counter helper actually wants. Use it instead of walking
through the fw_obj BO.

Fixes: 4c131aa02bc4 ("drm/amdgpu: Add profiling counters in fdinfo")

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index d5316e7bbb48..cf915ec8926c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1358,7 +1358,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
        amdgpu_userq_detect_and_reset_queues(uq_mgr);
        /* Try to unmap all the queues in this process ctx */
        xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
-               amdgpu_vm_increment_process_counter(queue->fw_obj.obj->vm_b=
o->vm, AMDGPU_VM_QUEUE_EVICTION_COUNTER);
+               amdgpu_vm_increment_process_counter(queue->vm, AMDGPU_VM_QU=
EUE_EVICTION_COUNTER);

                r =3D amdgpu_userq_preempt_helper(queue);
                if (r)
--
2.49.0

