Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD1CCD5BD0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 22:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136A510EA6B;
	Wed, 27 May 2026 22:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bwlKfhD4";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 531DC10EA63
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 22:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ah2XjFISt2CaT8QuHfbBaH49+dNQVE6CjKD74+9txbKdgiadWiRVcscGSm2KdUHH7+QyDpfl+VHaxoRwibUM44Du4zw5oVoUCtpr1XNLDpeuo6Z3tx2xyDJRAH1dp8HUFfsAz0gxCeTF6uwKofmfuiMY2duLgV1T0ogEgkG+UgOQBbGU6VAUn+IdaKDcn2tCkYUrFFtzcOAvg8jKZ+zNCjmzo1ASskAVuVSfNoOG9mcCev64OXOSC7cE7VZ0Hiz6zWq1lyiJssAULQcat707N9lesTglnJdGap1R+9CkzZ9qWhOHR98rDuIMonRPNZJJz6kHsd7pUPS/tKUyUnvN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO+tlImXSm7HrtDi70AOHj0USB6rNCVpCTYIISBI+ec=;
 b=p7Qjwrp+ttxtPJQld1ak9Jo6YWIS1mJayniYt9PtE44ufzeZDys5D7Qeh6GfHqXcgwIbZzvZOAvNWQaU7cMuTdU2XYJQ1cXNAevt/4IT/X3kkLNX2rMgp+IlFemk/tQahj5qoSLErfF79uYlMhq534RqspH0h2IVPi4shlDpT+YugjWGgAqjLpxH2n/v0gnDItzFFZ/uePqxDNABtJpgUPIHF+Sr/d3UzK8ggx9m46RIezgYWijKWA0pJoITEhI+AsbVtylAvJ/jvKCemOdX1x5ghwxvsYZwPUE3VFdRgPZxgl9nE8sVlLUqnxaZaMa1h0fb0qunlQu5/JGI+VZ/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO+tlImXSm7HrtDi70AOHj0USB6rNCVpCTYIISBI+ec=;
 b=bwlKfhD4PATFLNUMoh5Y8iwbo+059F+/JyKuuZUU3+IKmRpYVvuF6WtAYMWlqWWAl0w/kv1ZmT0xy00c65veSJ4vnmQXWAfAGxX1Ph1d9OGZHc1X1k+VSzMZpj/2hQgK9SlZ//p4043K7CkpnvtMzLsW3I8MqhztTug/iWJidKM=
Received: from DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 22:24:06 +0000
Received: from DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce]) by DS0PR12MB7536.namprd12.prod.outlook.com
 ([fe80::6a2c:d797:8fa4:72ce%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:24:06 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdkfd: Fix SMI event PID reporting for containers
Thread-Topic: [PATCH v3] drm/amdkfd: Fix SMI event PID reporting for containers
Thread-Index: AQHc7h4FxP2WEamfZU2oIMAbNwyyCLYicRwAgAABiiA=
Date: Wed, 27 May 2026 22:24:06 +0000
Message-ID: <DS0PR12MB75363567B125EDD245CF51CAF5082@DS0PR12MB7536.namprd12.prod.outlook.com>
References: <20260527211525.75006-1-andrew.martin@amd.com>
 <CH3PR12MB8658A352781C51E9A2743E0B8C082@CH3PR12MB8658.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8658A352781C51E9A2743E0B8C082@CH3PR12MB8658.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Harish.Kasiviswanathan@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-27T22:17:57.7940000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7536:EE_|DS7PR12MB9041:EE_
x-ms-office365-filtering-correlation-id: 952af4c9-b4b1-4fae-d731-08debc3eaa68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|8096899003|22082099003|18002099003|56012099006|6133799003|4143699003|11063799006|5023799004|3023799007;
x-microsoft-antispam-message-info: xrGEPlVaafQs/LC7N9NOgFDuEdu8LIPcdBQ1kFuMHsaaN9BKu13PeIWlEnmcagbX6iNOOznrjMQaFOb8asLkxtUpyn99hU9E9G9GRvmwWOQwxEqLnKNMzZ+AXFZpobV8NiOUJM0PF8xd1GQAgHcLLU3wiIpVbeyH/dlp+0/h4BebqpGzTBuIZJVATijRVYoMmhglOuSYADsUw1ydn9WWKZDBBMFZdRhb+YOCgBm1J2TQ8c8fRV/xSydW9F+1NS7BzXpMNWaFQdYb4Icw0Ot+CeiWKCXoGIeJ7Pry9pTP7tpiXketJFRo0kwiQuoTm1ya5aXcB0Cadz/CXalxDkd9pGSWISruoJpSvpbL/0/gY4DmeU0BoSPVpKt/2Pw8CUT5IJ60DCiQEqZ084DKxuA7FbQhuhLwB1U03nJkLw1ZjbEDNQbif34w48VPyWZOdp5kSaOCy3qdkX0tscEOHS5k92WIw/crQnCPRZihdXSuP126QjBVoeaHLZ5e9sVUo+Fvvj952ya4dECWhFI8wqSAHDVKjaIK7+BzpC9XA6pLUbdKgwlLXjd9j5KC9QviLXbCr4fF1AwYiuu1JiUXNDJQixjAqeQyL6ja7CQndr2tphnG8oL0liOonDID5X6fu3B4ERw9yJx1+2EK4IY9Lia/ShmMC9deDVBx446AUqI9SknQJbqmT7n+80SZvthEwT7KvaTtUjlw0w5U3QV2SOrlc2VbUPJhvwbvrOLrjpBplUSKLY7suiAueWMJGCVKviss
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(11063799006)(5023799004)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oJhqJnUW36PCZYafD4+oHTVd5RRZB6UmzyR3fZlTBnqPI4VwsNTccJMEK4fC?=
 =?us-ascii?Q?Owodr8c1gbeoRL5WN7mNdfUHmx2IS8HZhvpLyZMG7LPtYDsxQi9P50+LtHiL?=
 =?us-ascii?Q?suQd3FlV9AAA3N8BQZcJuHN3LbpIqj9IXnX3LtE7E0xW+0X+UAAso6kNIylO?=
 =?us-ascii?Q?tJSlNwueyQgkYzfXt8N4QyAHhE4E7CFlWtfFoyhesMJ1HDPpPgIClf9h3D/y?=
 =?us-ascii?Q?+QhMGs5CSUBnj4CMXkI6LVTAO6VORuWTV0oXcKdrOJ5SqFxt2zoDIYdCr+wG?=
 =?us-ascii?Q?YwiQP4ycYMdH+7nwu7BLU+Fn7nOhEaUlF4oPnFgNsNU4pE4ho67Q4QYu8hX2?=
 =?us-ascii?Q?UjA6nLYyZiADgjZLhnb1n0OWefZfaMey7Tyd1Qxnt/TFdJjmFr6eRBTg8C6i?=
 =?us-ascii?Q?yhPerHPfbN5om5gprfAGTjUE+YdrpNdTShHpy3Vgq2sP3E8bP4c+uXigBFMo?=
 =?us-ascii?Q?z0ac16dmxnNQr5LBqx0R1i3hEbYDe8X8fQzrCihHbdvn72I+cTKx5nON+lAk?=
 =?us-ascii?Q?U1tAYY9kh7KvqViJpy4GO5E9HNYVCUocziRsx0A7LduLFAWOuT96QPTn7mkr?=
 =?us-ascii?Q?PX6kP0S8VzLTokZOET3nUMggwm/1nQPTqagidtLOmceWHk3lBpjDej0tG36t?=
 =?us-ascii?Q?LC/EmA6tubRHL7TLhQg7kWOaHYvK4b/g7o2soVFRN7ih6XlTyziA+3DWDovs?=
 =?us-ascii?Q?yiOdw20NjQ2pAfKEMaUcjrFFhZrCfNXWgKGDw0SWK+6rN26Vmc2mppSXuQ1x?=
 =?us-ascii?Q?3IHmzwVaumCymFG+GubCAnVx1j6flHhklsV7dbVn96a7sUIcOCpTOmahvBu9?=
 =?us-ascii?Q?FfL/Mu/a/RqOHIya718CsEPiGKx3eXgH8BrKCxRKukdHSZAXJjLzuihp+m/G?=
 =?us-ascii?Q?JUarq+9ngdb9ZFVSShJJPlc2Svmfbn6a4+ng3wknX+MLgJNnzBktkOBHti6a?=
 =?us-ascii?Q?kHMFT1ZIe5JiGxDIlVKbLeBZzvC2es9FQlE3Cg2g+AFGtS0P6y4DhtqWAPm4?=
 =?us-ascii?Q?2pymgID6PV1jOgzTJGC14gmltzSFw+Upvuf1egKF/IKcIgrzAc4vj0VbDYT9?=
 =?us-ascii?Q?KYgS+wLb9Iq6PBgJywQWsA//8CmlVKfI7VlPZohpBln9vLV5N3oV7ITSvruU?=
 =?us-ascii?Q?yuCyoSDnfn3SGJT+Sw7h00d35qYdEoVyMMguSaj3Mr2XC5B02tmm1o6SRM+1?=
 =?us-ascii?Q?YhQTg2OsdkeRoreXmFzey7A0TSUuxND3W0nxeuj7LmoKpmnmnk9mo4S/8GZt?=
 =?us-ascii?Q?0Gly/12a8u7TwEAAADgL+PWR8zlxlEj/LESja2gK8pQn7CBpu3QedBvlXAVu?=
 =?us-ascii?Q?lkzY+nQV8GdY/KR0UK8ip0k8898W5tEvvWQelovALlsa4g1fNqvZc+2MOLtO?=
 =?us-ascii?Q?5TC0VMHd/yJfubHEOr9yRPpV9M0XCUlbmiTcBlVJ7ncvq8DNPt0uItL89yBR?=
 =?us-ascii?Q?FQR+KF5a1UYDoZWFKKEwS/D0U4avb+vp5NsmEolgfMF/223K5SmNGxgb5eBM?=
 =?us-ascii?Q?Nznv0b95JRRQO1Io7Eq4RXuDe1RYYbXi5ckhloHa66MdCJhv6Exb/4miatQK?=
 =?us-ascii?Q?HWuWtewI0FEXBtfLFTVW+Jb2qayvqAGkqhzuYK8Or3i0KkGcE7Jsmapob03j?=
 =?us-ascii?Q?KNSvovhr7GZqjACKEQMFB4DzjrNswiX3iMV1soAbXZoyDRHIHK7ZUV8HIFpw?=
 =?us-ascii?Q?vL266vpSeg/nIGwOS/AwA8GylDgcmguPlM/fSL05oWwX9l8z?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB75363567B125EDD245CF51CAF5082DS0PR12MB7536namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7536.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952af4c9-b4b1-4fae-d731-08debc3eaa68
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 22:24:06.5848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5o+ncMaYd/shN+3qDvd2fKcKi3g8akZ1YVE8jNjxhPqIlXEALQZFdnn8qPdojux80815iHcs1l7/HS5YcLLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041
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

--_000_DS0PR12MB75363567B125EDD245CF51CAF5082DS0PR12MB7536namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Public

Greetings @Kasiviswanathan, Harish<mailto:Harish.Kasiviswanathan@amd.com>

Thanks.

One love!

From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Sent: Wednesday, May 27, 2026 6:18 PM
To: Martin, Andrew <Andrew.Martin@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Claude : Sonnet 4 <noreply@anthropic.com>
Subject: Re: [PATCH v3] drm/amdkfd: Fix SMI event PID reporting for contain=
ers

Public


Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com<mailto:=
Harish.Kasiviswanathan@amd.com>>


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Andrew Martin <Andrew.Martin@amd.com<=
mailto:Andrew.Martin@amd.com>>
Sent: Wednesday, May 27, 2026 5:15 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Martin, Andrew <Andrew.Martin@amd.com<mailto:Andrew.Martin@amd.com>>; M=
artin, Andrew <Andrew.Martin@amd.com<mailto:Andrew.Martin@amd.com>>; Claude=
 : Sonnet 4 <noreply@anthropic.com<mailto:noreply@anthropic.com>>
Subject: [PATCH v3] drm/amdkfd: Fix SMI event PID reporting for containers

SMI events were reporting incorrect PIDs in containerized environments,
causing test failures where container processes expected to see their
namespace-local PIDs but instead received global host PIDs.

The issue had two root causes:

1. Event functions were called from kernel context (page fault handlers,
   migration workers) where 'current' refers to the kernel worker thread,
   not the userspace GPU process that triggered the event.

2. PID conversion used task_tgid_vnr() which returns the PID in the
   caller's namespace (init namespace for kernel threads), not the task's
   own namespace.

This patch updates the SMI event interface:

- Change 8 event function signatures to accept task_struct pointer
  instead of pid_t, allowing proper namespace-aware PID conversion

- Convert PIDs using task_tgid_nr_ns(task, task_active_pid_ns(task))
  which returns the PID as the process sees it via getpid()

- Update 10 call sites to pass p->lead_thread (the GPU process)
  instead of p->lead_thread->pid or current (kernel worker)

This ensures SMI events report container-local PIDs, which is critical
for containerized GPU workloads to correctly correlate events with their
processes.

Tested-by: Andrew Martin <andmarti@amd.com<mailto:andmarti@amd.com>>
Assisted-by: Claude:Sonnet 4 <noreply@anthropic.com<mailto:noreply@anthropi=
c.com>>
Signed-off-by: Andrew Martin <andrew.martin@amd.com<mailto:andrew.martin@am=
d.com>>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c    |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 95 +++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h | 14 +--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        |  6 +-
 5 files changed, 76 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c
index 28dc6886c1ff..226e76ae0be7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -424,7 +424,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct s=
vm_range *prange,
         migrate.dst =3D migrate.src + npages;
         scratch =3D (dma_addr_t *)(migrate.dst + npages);

-       kfd_smi_event_migration_start(node, p->lead_thread->pid,
+       kfd_smi_event_migration_start(node, p->lead_thread,
                                       start >> PAGE_SHIFT, end >> PAGE_SHI=
FT,
                                       0, node->id, prange->prefetch_loc,
                                       prange->preferred_loc, trigger);
@@ -462,7 +462,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct s=
vm_range *prange,

 out_free:
         kvfree(buf);
-       kfd_smi_event_migration_end(node, p->lead_thread->pid,
+       kfd_smi_event_migration_end(node, p->lead_thread,
                                     start >> PAGE_SHIFT, end >> PAGE_SHIFT=
,
                                     0, node->id, trigger, r);
 out:
@@ -727,7 +727,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct sv=
m_range *prange,
         migrate.fault_page =3D fault_page;
         scratch =3D (dma_addr_t *)(migrate.dst + npages);

-       kfd_smi_event_migration_start(node, p->lead_thread->pid,
+       kfd_smi_event_migration_start(node, p->lead_thread,
                                       start >> PAGE_SHIFT, end >> PAGE_SHI=
FT,
                                       node->id, 0, prange->prefetch_loc,
                                       prange->preferred_loc, trigger);
@@ -766,7 +766,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct sv=
m_range *prange,

 out_free:
         kvfree(buf);
-       kfd_smi_event_migration_end(node, p->lead_thread->pid,
+       kfd_smi_event_migration_end(node, p->lead_thread,
                                     start >> PAGE_SHIFT, end >> PAGE_SHIFT=
,
                                     node->id, 0, trigger, r);
 out:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 419bb8086ccd..0ed315eb0bca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1975,7 +1975,7 @@ int kfd_process_evict_queues(struct kfd_process *p, u=
int32_t trigger)
                 struct kfd_process_device *pdd =3D p->pdds[i];
                 struct device *dev =3D pdd->dev->adev->dev;

-               kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pid,
+               kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread,
                                              trigger);

                 r =3D pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dq=
m,
@@ -2005,7 +2005,7 @@ int kfd_process_evict_queues(struct kfd_process *p, u=
int32_t trigger)
                 if (n_evicted =3D=3D 0)
                         break;

-               kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
+               kfd_smi_event_queue_restore(pdd->dev, p->lead_thread);

                 if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->dq=
m,
                                                               &pdd->qpd))
@@ -2028,7 +2028,7 @@ int kfd_process_restore_queues(struct kfd_process *p)
                 struct kfd_process_device *pdd =3D p->pdds[i];
                 struct device *dev =3D pdd->dev->adev->dev;

-               kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid);
+               kfd_smi_event_queue_restore(pdd->dev, p->lead_thread);

                 r =3D pdd->dev->dqm->ops.restore_process_queues(pdd->dev->=
dqm,
                                                               &pdd->qpd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.c
index d2bc169e84b0..a08fdef97917 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -195,17 +195,35 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_=
node *dev,
         rcu_read_unlock();
 }

+/**
+ * kfd_smi_task_to_pid - Convert task to namespace-aware PID
+ * @task: task_struct pointer (typically p->lead_thread)
+ *
+ * Returns the PID as it appears in the task's own PID namespace.
+ * For containerized processes, this returns the container-local PID
+ * (what getpid() returns), not the global host PID.
+ *
+ * Returns 0 if task is NULL.
+ */
+static inline pid_t kfd_smi_task_to_pid(struct task_struct *task)
+{
+       return task ? task_tgid_nr_ns(task, task_active_pid_ns(task)) : 0;
+}
+
 __printf(4, 5)
-static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
+static void kfd_smi_event_add(struct task_struct *task, struct kfd_node *d=
ev,
                               unsigned int event, char *fmt, ...)
 {
         char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
         int len;
         va_list args;
+       pid_t pid;

         if (list_empty(&dev->smi_clients))
                 return;

+       pid =3D kfd_smi_task_to_pid(task);
+
         len =3D snprintf(fifo_in, sizeof(fifo_in), "%x ", event);

         va_start(args, fmt);
@@ -234,14 +252,15 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *=
dev, bool post_reset,
                 amdgpu_reset_get_desc(reset_context, reset_cause,
                                       sizeof(reset_cause));

-       kfd_smi_event_add(0, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
+       kfd_smi_event_add(NULL, dev, event, KFD_EVENT_FMT_UPDATE_GPU_RESET(
                           dev->reset_seq_num, reset_cause));
 }

 void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
                                              uint64_t throttle_bitmask)
 {
-       kfd_smi_event_add(0, dev, KFD_SMI_EVENT_THERMAL_THROTTLE, KFD_EVENT=
_FMT_THERMAL_THROTTLING(
+       kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
+                         KFD_EVENT_FMT_THERMAL_THROTTLING(
                           throttle_bitmask,
                           amdgpu_dpm_get_thermal_throttling_counter(dev->a=
dev)));
 }
@@ -254,65 +273,67 @@ void kfd_smi_event_update_vmfault(struct kfd_node *de=
v, uint16_t pasid)
         if (task_info) {
                 /* Report VM faults from user applications, not retry from=
 kernel */
                 if (task_info->task.pid)
-                       kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, KF=
D_EVENT_FMT_VMFAULT(
+                       kfd_smi_event_add(NULL, dev, KFD_SMI_EVENT_VMFAULT,=
 KFD_EVENT_FMT_VMFAULT(
                                           task_info->task.pid, task_info->=
task.comm));
                 amdgpu_vm_put_task_info(task_info);
         }
 }

-void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_str=
uct *task,
                                     unsigned long address, bool write_faul=
t,
                                     ktime_t ts)
 {
-       kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_START,
-                         KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pi=
d,
-                         address, node->id, write_fault ? 'W' : 'R'));
+       kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_START,
+                         KFD_EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts),
+                         kfd_smi_task_to_pid(task), address, node->id,
+                         write_fault ? 'W' : 'R'));
 }

-void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_page_fault_end(struct kfd_node *node, struct task_struc=
t *task,
                                   unsigned long address, bool migration)
 {
-       kfd_smi_event_add(pid, node, KFD_SMI_EVENT_PAGE_FAULT_END,
+       kfd_smi_event_add(task, node, KFD_SMI_EVENT_PAGE_FAULT_END,
                           KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_n=
s(),
-                         pid, address, node->id, migration ? 'M' : 'U'));
+                         kfd_smi_task_to_pid(task), address, node->id,
+                         migration ? 'M' : 'U'));
 }

-void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_migration_start(struct kfd_node *node, struct task_stru=
ct *task,
                                    unsigned long start, unsigned long end,
                                    uint32_t from, uint32_t to,
                                    uint32_t prefetch_loc, uint32_t preferr=
ed_loc,
                                    uint32_t trigger)
 {
-       kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_START,
-                         KFD_EVENT_FMT_MIGRATE_START(
-                         ktime_get_boottime_ns(), pid, start, end - start,
-                         from, to, prefetch_loc, preferred_loc, trigger));
+       kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_START,
+                         KFD_EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns=
(),
+                         kfd_smi_task_to_pid(task), start, end - start, fr=
om,
+                         to, prefetch_loc, preferred_loc, trigger));
 }

-void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct=
 *task,
                                  unsigned long start, unsigned long end,
                                  uint32_t from, uint32_t to, uint32_t trig=
ger,
                                  int error_code)
 {
-       kfd_smi_event_add(pid, node, KFD_SMI_EVENT_MIGRATE_END,
-                         KFD_EVENT_FMT_MIGRATE_END(
-                         ktime_get_boottime_ns(), pid, start, end - start,
-                         from, to, trigger, error_code));
+       kfd_smi_event_add(task, node, KFD_SMI_EVENT_MIGRATE_END,
+                         KFD_EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns()=
,
+                         kfd_smi_task_to_pid(task), start, end - start, fr=
om,
+                         to, trigger, error_code));
 }

-void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_queue_eviction(struct kfd_node *node, struct task_struc=
t *task,
                                   uint32_t trigger)
 {
-       kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_EVICTION,
-                         KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_n=
s(), pid,
-                         node->id, trigger));
+       kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_EVICTION,
+                         KFD_EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_n=
s(),
+                         kfd_smi_task_to_pid(task), node->id, trigger));
 }

-void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)
+void kfd_smi_event_queue_restore(struct kfd_node *node, struct task_struct=
 *task)
 {
-       kfd_smi_event_add(pid, node, KFD_SMI_EVENT_QUEUE_RESTORE,
-                         KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns=
(), pid,
-                         node->id, '0'));
+       kfd_smi_event_add(task, node, KFD_SMI_EVENT_QUEUE_RESTORE,
+                         KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns=
(),
+                         kfd_smi_task_to_pid(task), node->id, '0'));
 }

 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)
@@ -327,21 +348,23 @@ void kfd_smi_event_queue_restore_rescheduled(struct m=
m_struct *mm)
         for (i =3D 0; i < p->n_pdds; i++) {
                 struct kfd_process_device *pdd =3D p->pdds[i];

-               kfd_smi_event_add(p->lead_thread->pid, pdd->dev,
+               kfd_smi_event_add(p->lead_thread, pdd->dev,
                                   KFD_SMI_EVENT_QUEUE_RESTORE,
                                   KFD_EVENT_FMT_QUEUE_RESTORE(ktime_get_bo=
ottime_ns(),
-                                 p->lead_thread->pid, pdd->dev->id, 'R'));
+                                 kfd_smi_task_to_pid(p->lead_thread),
+                                 pdd->dev->id, 'R'));
         }
         kfd_unref_process(p);
 }

-void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, struct task_struc=
t *task,
                                   unsigned long address, unsigned long las=
t,
                                   uint32_t trigger)
 {
-       kfd_smi_event_add(pid, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
+       kfd_smi_event_add(task, node, KFD_SMI_EVENT_UNMAP_FROM_GPU,
                           KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_=
ns(),
-                         pid, address, last - address + 1, node->id, trigg=
er));
+                         kfd_smi_task_to_pid(task), address,
+                         last - address + 1, node->id, trigger));
 }

 void kfd_smi_event_process(struct kfd_process_device *pdd, bool start)
@@ -356,7 +379,7 @@ void kfd_smi_event_process(struct kfd_process_device *p=
dd, bool start)
         task_info =3D amdgpu_vm_get_task_info_vm(avm);

         if (task_info) {
-               kfd_smi_event_add(0, pdd->dev,
+               kfd_smi_event_add(NULL, pdd->dev,
                                   start ? KFD_SMI_EVENT_PROCESS_START :
                                   KFD_SMI_EVENT_PROCESS_END,
                                   KFD_EVENT_FMT_PROCESS(task_info->task.pi=
d,
@@ -385,7 +408,7 @@ int kfd_smi_event_open(struct kfd_node *dev, uint32_t *=
fd)
         spin_lock_init(&client->lock);
         client->events =3D 0;
         client->dev =3D dev;
-       client->pid =3D current->tgid;
+       client->pid =3D kfd_smi_task_to_pid(current);
         client->suser =3D capable(CAP_SYS_ADMIN);

         spin_lock(&dev->smi_lock);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.h
index bb4d72b57387..afa93d7cfa7f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -32,25 +32,25 @@ void kfd_smi_event_update_thermal_throttling(struct kfd=
_node *dev,
                                              uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
                                     struct amdgpu_reset_context *reset_con=
text);
-void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_str=
uct *task,
                                     unsigned long address, bool write_faul=
t,
                                     ktime_t ts);
-void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_page_fault_end(struct kfd_node *node, struct task_struc=
t *task,
                                   unsigned long address, bool migration);
-void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_migration_start(struct kfd_node *node, struct task_stru=
ct *task,
                              unsigned long start, unsigned long end,
                              uint32_t from, uint32_t to,
                              uint32_t prefetch_loc, uint32_t preferred_loc=
,
                              uint32_t trigger);
-void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct=
 *task,
                              unsigned long start, unsigned long end,
                              uint32_t from, uint32_t to, uint32_t trigger,
                              int error_code);
-void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_queue_eviction(struct kfd_node *node, struct task_struc=
t *task,
                                   uint32_t trigger);
-void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid);
+void kfd_smi_event_queue_restore(struct kfd_node *node, struct task_struct=
 *task);
 void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);
-void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,
+void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, struct task_struc=
t *task,
                                   unsigned long address, unsigned long las=
t,
                                   uint32_t trigger);
 void kfd_smi_event_process(struct kfd_process_device *pdd, bool start);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 25b3ecf85f30..b9f62129a825 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1408,7 +1408,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, u=
nsigned long start,
                         return -EINVAL;
                 }

-               kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread->pid,
+               kfd_smi_event_unmap_from_gpu(pdd->dev, p->lead_thread,
                                              start, last, trigger);

                 r =3D svm_range_unmap_from_gpu(pdd->dev->adev,
@@ -3205,7 +3205,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, u=
nsigned int pasid,
                  svms, prange->start, prange->last, best_loc,
                  prange->actual_loc);

-       kfd_smi_event_page_fault_start(node, p->lead_thread->pid, addr,
+       kfd_smi_event_page_fault_start(node, p->lead_thread, addr,
                                        write_fault, timestamp);

         /* Align migration range start and size to granularity size */
@@ -3248,7 +3248,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, u=
nsigned int pasid,
                          r, svms, start, last);

 out_migrate_fail:
-       kfd_smi_event_page_fault_end(node, p->lead_thread->pid, addr,
+       kfd_smi_event_page_fault_end(node, p->lead_thread, addr,
                                      migration);

 out_unlock_range:
--
2.34.1

--_000_DS0PR12MB75363567B125EDD245CF51CAF5082DS0PR12MB7536namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
Public<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Greetings <a id=3D"=
OWAAM0F2E2BA61B204719B05F743C5456C84A" href=3D"mailto:Harish.Kasiviswanatha=
n@amd.com">
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif;text-decoration:non=
e">@Kasiviswanathan, Harish</span></a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><br>
Thanks.<br>
<br>
One love!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Kasiviswanathan, Harish &lt;Ha=
rish.Kasiviswanathan@amd.com&gt;
<br>
<b>Sent:</b> Wednesday, May 27, 2026 6:18 PM<br>
<b>To:</b> Martin, Andrew &lt;Andrew.Martin@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Cc:</b> Claude : Sonnet 4 &lt;noreply@anthropic.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3] drm/amdkfd: Fix SMI event PID reporting for =
containers<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">Public<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">Reviewed-by: Harish Kasiviswanathan &lt;<a href=3D"m=
ailto:Harish.Kasiviswanathan@amd.com">Harish.Kasiviswanathan@amd.com</a>&gt=
;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black">From:</span></b><span style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:black">&nbsp;amd-gfx &lt;<a href=3D"mailto:amd-g=
fx-bounces@lists.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>=
&gt;
 on behalf of Andrew Martin &lt;<a href=3D"mailto:Andrew.Martin@amd.com">An=
drew.Martin@amd.com</a>&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, May 27, 2026 5:15 PM<br>
<b>To:</b>&nbsp;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@li=
sts.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org=
">amd-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b>&nbsp;Martin, Andrew &lt;<a href=3D"mailto:Andrew.Martin@amd.com"=
>Andrew.Martin@amd.com</a>&gt;; Martin, Andrew &lt;<a href=3D"mailto:Andrew=
.Martin@amd.com">Andrew.Martin@amd.com</a>&gt;; Claude : Sonnet 4 &lt;<a hr=
ef=3D"mailto:noreply@anthropic.com">noreply@anthropic.com</a>&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v3] drm/amdkfd: Fix SMI event PID reporting for=
 containers
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">SMI events were reporting incorrect PIDs in containerized envir=
onments,<br>
causing test failures where container processes expected to see their<br>
namespace-local PIDs but instead received global host PIDs.<br>
<br>
The issue had two root causes:<br>
<br>
1. Event functions were called from kernel context (page fault handlers,<br=
>
&nbsp;&nbsp; migration workers) where 'current' refers to the kernel worker=
 thread,<br>
&nbsp;&nbsp; not the userspace GPU process that triggered the event.<br>
<br>
2. PID conversion used task_tgid_vnr() which returns the PID in the<br>
&nbsp;&nbsp; caller's namespace (init namespace for kernel threads), not th=
e task's<br>
&nbsp;&nbsp; own namespace.<br>
<br>
This patch updates the SMI event interface:<br>
<br>
- Change 8 event function signatures to accept task_struct pointer<br>
&nbsp; instead of pid_t, allowing proper namespace-aware PID conversion<br>
<br>
- Convert PIDs using task_tgid_nr_ns(task, task_active_pid_ns(task))<br>
&nbsp; which returns the PID as the process sees it via getpid()<br>
<br>
- Update 10 call sites to pass p-&gt;lead_thread (the GPU process)<br>
&nbsp; instead of p-&gt;lead_thread-&gt;pid or current (kernel worker)<br>
<br>
This ensures SMI events report container-local PIDs, which is critical<br>
for containerized GPU workloads to correctly correlate events with their<br=
>
processes.<br>
<br>
Tested-by: Andrew Martin &lt;<a href=3D"mailto:andmarti@amd.com">andmarti@a=
md.com</a>&gt;<br>
Assisted-by: Claude:Sonnet 4 &lt;<a href=3D"mailto:noreply@anthropic.com">n=
oreply@anthropic.com</a>&gt;<br>
Signed-off-by: Andrew Martin &lt;<a href=3D"mailto:andrew.martin@amd.com">a=
ndrew.martin@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_migrate.c&nbsp;&nbsp;&nbsp; |&nbsp; 8 =
+-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp; |&nbsp; 6 =
+-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 95 +++++++++++++-------=
-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h | 14 +--<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp; 6 +-<br>
&nbsp;5 files changed, 76 insertions(+), 53 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c<br>
index 28dc6886c1ff..226e76ae0be7 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
@@ -424,7 +424,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct s=
vm_range *prange,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate.dst =3D migrate.sr=
c + npages;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch =3D (dma_addr_t *)=
(migrate.dst + npages);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_migration_start(node, p=
-&gt;lead_thread-&gt;pid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_migration_start(node, p=
-&gt;lead_thread,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; start &gt;&gt; PAGE_SHIFT, end &gt;&gt; PAGE_SHIFT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0, node-&gt;id, prange-&gt;prefetch_loc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; prange-&gt;preferred_loc, trigger);<br>
@@ -462,7 +462,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct s=
vm_range *prange,<br>
&nbsp;<br>
&nbsp;out_free:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(buf);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_migration_end(node, p-&=
gt;lead_thread-&gt;pid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_migration_end(node, p-&=
gt;lead_thread,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start &g=
t;&gt; PAGE_SHIFT, end &gt;&gt; PAGE_SHIFT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, node-=
&gt;id, trigger, r);<br>
&nbsp;out:<br>
@@ -727,7 +727,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct sv=
m_range *prange,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate.fault_page =3D fau=
lt_page;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch =3D (dma_addr_t *)=
(migrate.dst + npages);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_migration_start(node, p=
-&gt;lead_thread-&gt;pid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_migration_start(node, p=
-&gt;lead_thread,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; start &gt;&gt; PAGE_SHIFT, end &gt;&gt; PAGE_SHIFT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; node-&gt;id, 0, prange-&gt;prefetch_loc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; prange-&gt;preferred_loc, trigger);<br>
@@ -766,7 +766,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct sv=
m_range *prange,<br>
&nbsp;<br>
&nbsp;out_free:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kvfree(buf);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_migration_end(node, p-&=
gt;lead_thread-&gt;pid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_migration_end(node, p-&=
gt;lead_thread,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start &g=
t;&gt; PAGE_SHIFT, end &gt;&gt; PAGE_SHIFT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node-&gt=
;id, 0, trigger, r);<br>
&nbsp;out:<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index 419bb8086ccd..0ed315eb0bca 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1975,7 +1975,7 @@ int kfd_process_evict_queues(struct kfd_process *p, u=
int32_t trigger)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd =3D p-&gt;pdds[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device *dev =3D pdd-&gt;dev-&gt;adev-&gt;dev;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_queue_eviction(pdd-&gt;dev, p-&gt;lead_thread-&gt;=
pid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_queue_eviction(pdd-&gt;dev, p-&gt;lead_thread,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trigger);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D pdd-&gt;dev-&gt;dqm-&gt;ops.evict_process_queue=
s(pdd-&gt;dev-&gt;dqm,<br>
@@ -2005,7 +2005,7 @@ int kfd_process_evict_queues(struct kfd_process *p, u=
int32_t trigger)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (n_evicted =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_queue_restore(pdd-&gt;dev, p-&gt;lead_thread-&gt;p=
id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_queue_restore(pdd-&gt;dev, p-&gt;lead_thread);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (pdd-&gt;dev-&gt;dqm-&gt;ops.restore_process_queue=
s(pdd-&gt;dev-&gt;dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;pdd-&gt;qpd))<br>
@@ -2028,7 +2028,7 @@ int kfd_process_restore_queues(struct kfd_process *p)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd =3D p-&gt;pdds[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device *dev =3D pdd-&gt;dev-&gt;adev-&gt;dev;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_queue_restore(pdd-&gt;dev, p-&gt;lead_thread-&gt;p=
id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_queue_restore(pdd-&gt;dev, p-&gt;lead_thread);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D pdd-&gt;dev-&gt;dqm-&gt;ops.restore_process_que=
ues(pdd-&gt;dev-&gt;dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;pdd-&gt;qpd);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.c<br>
index d2bc169e84b0..a08fdef97917 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c<br>
@@ -195,17 +195,35 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_=
node *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rcu_read_unlock();<br>
&nbsp;}<br>
&nbsp;<br>
+/**<br>
+ * kfd_smi_task_to_pid - Convert task to namespace-aware PID<br>
+ * @task: task_struct pointer (typically p-&gt;lead_thread)<br>
+ *<br>
+ * Returns the PID as it appears in the task's own PID namespace.<br>
+ * For containerized processes, this returns the container-local PID<br>
+ * (what getpid() returns), not the global host PID.<br>
+ *<br>
+ * Returns 0 if task is NULL.<br>
+ */<br>
+static inline pid_t kfd_smi_task_to_pid(struct task_struct *task)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return task ? task_tgid_nr_ns(task, t=
ask_active_pid_ns(task)) : 0;<br>
+}<br>
+<br>
&nbsp;__printf(4, 5)<br>
-static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,<br>
+static void kfd_smi_event_add(struct task_struct *task, struct kfd_node *d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int event, char *fmt, ...)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char fifo_in[KFD_SMI_EVENT=
_MSG_SIZE];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int len;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_list args;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid_t pid;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;dev-&g=
t;smi_clients))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid =3D kfd_smi_task_to_pid(task);<br=
>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D snprintf(fifo_in, =
sizeof(fifo_in), &quot;%x &quot;, event);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_start(args, fmt);<br>
@@ -234,14 +252,15 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *=
dev, bool post_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_reset_get_desc(reset_context, reset_cause,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; sizeof(reset_cause));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, event, KFD_=
EVENT_FMT_UPDATE_GPU_RESET(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(NULL, dev, event, K=
FD_EVENT_FMT_UPDATE_GPU_RESET(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; dev-&gt;reset_seq_num, reset_cause));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t throttle_bitmask)<br=
>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(0, dev, KFD_SMI_EVE=
NT_THERMAL_THROTTLE, KFD_EVENT_FMT_THERMAL_THROTTLING(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(NULL, dev, KFD_SMI_=
EVENT_THERMAL_THROTTLE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_THERMAL_THROTTLING(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; throttle_bitmask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; amdgpu_dpm_get_thermal_throttling_counter(dev-&gt;adev)));<br>
&nbsp;}<br>
@@ -254,65 +273,67 @@ void kfd_smi_event_update_vmfault(struct kfd_node *de=
v, uint16_t pasid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Report VM faults from user applications, not retry=
 from kernel */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (task_info-&gt;task.pid)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_ad=
d(0, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_ad=
d(NULL, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAULT(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; task_info-&gt;task.pid, task_info-&gt;task.comm=
));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_vm_put_task_info(task_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_str=
uct *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned=
 long address, bool write_fault,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t =
ts)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_=
EVENT_PAGE_FAULT_START,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts), pid,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr=
ess, node-&gt;id, write_fault ? 'W' : 'R'));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(task, node, KFD_SMI=
_EVENT_PAGE_FAULT_START,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_PAGEFAULT_START(ktime_to_ns(ts),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_=
smi_task_to_pid(task), address, node-&gt;id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; writ=
e_fault ? 'W' : 'R'));<br>
&nbsp;}<br>
&nbsp;<br>
-void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_page_fault_end(struct kfd_node *node, struct task_struc=
t *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long addres=
s, bool migration)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_=
EVENT_PAGE_FAULT_END,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(task, node, KFD_SMI=
_EVENT_PAGE_FAULT_END,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; KFD_EVENT_FMT_PAGEFAULT_END(ktime_get_boottime_ns(),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid,=
 address, node-&gt;id, migration ? 'M' : 'U'));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_=
smi_task_to_pid(task), address, node-&gt;id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migr=
ation ? 'M' : 'U'));<br>
&nbsp;}<br>
&nbsp;<br>
-void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_migration_start(struct kfd_node *node, struct task_stru=
ct *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long =
start, unsigned long end,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t from,=
 uint32_t to,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t prefe=
tch_loc, uint32_t preferred_loc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigg=
er)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_=
EVENT_MIGRATE_START,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_MIGRATE_START(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktim=
e_get_boottime_ns(), pid, start, end - start,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from=
, to, prefetch_loc, preferred_loc, trigger));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(task, node, KFD_SMI=
_EVENT_MIGRATE_START,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_MIGRATE_START(ktime_get_boottime_ns(),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_=
smi_task_to_pid(task), start, end - start, from,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to, =
prefetch_loc, preferred_loc, trigger));<br>
&nbsp;}<br>
&nbsp;<br>
-void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct=
 *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsig=
ned long end,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t from, uint32_t to=
, uint32_t trigger,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int error_code)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_=
EVENT_MIGRATE_END,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_MIGRATE_END(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktim=
e_get_boottime_ns(), pid, start, end - start,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from=
, to, trigger, error_code));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(task, node, KFD_SMI=
_EVENT_MIGRATE_END,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_MIGRATE_END(ktime_get_boottime_ns(),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_=
smi_task_to_pid(task), start, end - start, from,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to, =
trigger, error_code));<br>
&nbsp;}<br>
&nbsp;<br>
-void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_queue_eviction(struct kfd_node *node, struct task_struc=
t *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger)<br=
>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_=
EVENT_QUEUE_EVICTION,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(), pid,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node=
-&gt;id, trigger));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(task, node, KFD_SMI=
_EVENT_QUEUE_EVICTION,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_QUEUE_EVICTION(ktime_get_boottime_ns(),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_=
smi_task_to_pid(task), node-&gt;id, trigger));<br>
&nbsp;}<br>
&nbsp;<br>
-void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid)<br>
+void kfd_smi_event_queue_restore(struct kfd_node *node, struct task_struct=
 *task)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_=
EVENT_QUEUE_RESTORE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(), pid,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node=
-&gt;id, '0'));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(task, node, KFD_SMI=
_EVENT_QUEUE_RESTORE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_=
EVENT_FMT_QUEUE_RESTORE(ktime_get_boottime_ns(),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_=
smi_task_to_pid(task), node-&gt;id, '0'));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm)<br=
>
@@ -327,21 +348,23 @@ void kfd_smi_event_queue_restore_rescheduled(struct m=
m_struct *mm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; p-&gt=
;n_pdds; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd =3D p-&gt;pdds[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_add(p-&gt;lead_thread-&gt;pid, pdd-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_add(p-&gt;lead_thread, pdd-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_QUEUE_=
RESTORE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_EVENT_FMT_QUEUE_=
RESTORE(ktime_get_boottime_ns(),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;lead_thread-&gt;pid, pdd-=
&gt;dev-&gt;id, 'R'));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_task_to_pid(p-&gt;lead_=
thread),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id, 'R'));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);<br>
&nbsp;}<br>
&nbsp;<br>
-void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, struct task_struc=
t *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long addres=
s, unsigned long last,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger)<br=
>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(pid, node, KFD_SMI_=
EVENT_UNMAP_FROM_GPU,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_add(task, node, KFD_SMI=
_EVENT_UNMAP_FROM_GPU,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; KFD_EVENT_FMT_UNMAP_FROM_GPU(ktime_get_boottime_ns(),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pid,=
 address, last - address + 1, node-&gt;id, trigger));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_=
smi_task_to_pid(task), address,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last=
 - address + 1, node-&gt;id, trigger));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void kfd_smi_event_process(struct kfd_process_device *pdd, bool start=
)<br>
@@ -356,7 +379,7 @@ void kfd_smi_event_process(struct kfd_process_device *p=
dd, bool start)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task_info =3D amdgpu_vm_ge=
t_task_info_vm(avm);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (task_info) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_add(0, pdd-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_add(NULL, pdd-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start ? KFD_SMI_EVEN=
T_PROCESS_START :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SMI_EVENT_PROCES=
S_END,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_EVENT_FMT_PROCES=
S(task_info-&gt;task.pid,<br>
@@ -385,7 +408,7 @@ int kfd_smi_event_open(struct kfd_node *dev, uint32_t *=
fd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;client=
-&gt;lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client-&gt;events =3D 0;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client-&gt;dev =3D dev;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client-&gt;pid =3D current-&gt;tgid;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client-&gt;pid =3D kfd_smi_task_to_pi=
d(current);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client-&gt;suser =3D capab=
le(CAP_SYS_ADMIN);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;dev-&gt;smi=
_lock);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/=
amd/amdkfd/kfd_smi_events.h<br>
index bb4d72b57387..afa93d7cfa7f 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h<br>
@@ -32,25 +32,25 @@ void kfd_smi_event_update_thermal_throttling(struct kfd=
_node *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t throttle_bitmask);<b=
r>
&nbsp;void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_r=
eset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_reset_context *reset_context);<br>
-void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_page_fault_start(struct kfd_node *node, struct task_str=
uct *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned=
 long address, bool write_fault,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t =
ts);<br>
-void kfd_smi_event_page_fault_end(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_page_fault_end(struct kfd_node *node, struct task_struc=
t *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long addres=
s, bool migration);<br>
-void kfd_smi_event_migration_start(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_migration_start(struct kfd_node *node, struct task_stru=
ct *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsigned long end,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t from, uint32_t to,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t prefetch_loc, uint32_t preferred_loc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger);<br>
-void kfd_smi_event_migration_end(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_migration_end(struct kfd_node *node, struct task_struct=
 *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsigned long end,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t from, uint32_t to, uint32_t trigger,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; int error_code);<br>
-void kfd_smi_event_queue_eviction(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_queue_eviction(struct kfd_node *node, struct task_struc=
t *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger);<b=
r>
-void kfd_smi_event_queue_restore(struct kfd_node *node, pid_t pid);<br>
+void kfd_smi_event_queue_restore(struct kfd_node *node, struct task_struct=
 *task);<br>
&nbsp;void kfd_smi_event_queue_restore_rescheduled(struct mm_struct *mm);<b=
r>
-void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, pid_t pid,<br>
+void kfd_smi_event_unmap_from_gpu(struct kfd_node *node, struct task_struc=
t *task,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long addres=
s, unsigned long last,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t trigger);<b=
r>
&nbsp;void kfd_smi_event_process(struct kfd_process_device *pdd, bool start=
);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c<br>
index 25b3ecf85f30..b9f62129a825 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
@@ -1408,7 +1408,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, u=
nsigned long start,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_unmap_from_gpu(pdd-&gt;dev, p-&gt;lead_thread-&gt;=
pid,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_smi_event_unmap_from_gpu(pdd-&gt;dev, p-&gt;lead_thread,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, trigger);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D svm_range_unmap_from_gpu(pdd-&gt;dev-&gt;adev,<=
br>
@@ -3205,7 +3205,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, u=
nsigned int pasid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; svms, prange-&gt;start, prange-&gt;last, best_l=
oc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;actual_loc);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_page_fault_start(node, =
p-&gt;lead_thread-&gt;pid, addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_page_fault_start(node, =
p-&gt;lead_thread, addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; write_fault, timestamp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Align migration range s=
tart and size to granularity size */<br>
@@ -3248,7 +3248,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, u=
nsigned int pasid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 r, svms, start, last);<br>
&nbsp;<br>
&nbsp;out_migrate_fail:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_page_fault_end(node, p-=
&gt;lead_thread-&gt;pid, addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_smi_event_page_fault_end(node, p-=
&gt;lead_thread, addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mi=
gration);<br>
&nbsp;<br>
&nbsp;out_unlock_range:<br>
--<br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DS0PR12MB75363567B125EDD245CF51CAF5082DS0PR12MB7536namp_--
