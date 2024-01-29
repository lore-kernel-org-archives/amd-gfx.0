Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008B7C47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 08:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB0E11266D;
	Mon, 29 Jan 2024 08:45:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 641BB11265C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 08:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJNUk/iUJC2r3ku3HmeCdQSBFpNFml0X9uK1Yrb7TrYUE5apGFmCKJ+kguf3hggkIu+1kqTcdL9XO2qPlXqmQoba9g9dVJVYzLcyfbRIVeUO0f73+JIijMB91fceAnb4DyhCvxzsotvw7oAEqdS8bPbKenIz9YpVOcdvmFWbNweJf1nrcm8b9YkEzA9YZHdJ8JZ2aNglBTVBmT5e/3pha89k6S3hzxJ/s/lP8XWBR5+ZrH51mr4uEMBG/Mi49Twp72FkS6mGnWxvHaswxSVDQzQ7vpDdUZVaTr87zFTKTMizBvwIULf7fkif9q5fL0QFL+brccqsq4Q9cT3gjuFeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bga+wPcNgkazenrVvPblgmfOCgmtJ/Jn4LrGDlUt4w=;
 b=DOWndIvNF5Tc+tWOioYxxeE7O+v+UaJh7XBDPzXOv+t2jnvsFJkBzcTzVEBgDhHyk3X6suPwepNZEsHQhboUOb/3i1F4idhJVGjSFsHpdzrwNzHo1D+6dsNPgA67DUYNkli8mR4s2zswDwYTE/25txelDMM/cTmF//IH32xmjd5P6ETyJH5WCu1cJ7U1aLEVuqyKW7EjQtmmG3MjdppPbgYiGy9fp4Nve2Z3yWtYZXj7+YpwcuL+qBSoUWPvQyJjmYQeXGVLIxa5CaICyi1veUCG4cLrm5KcaypoHsQh7jPACm1P/jgTho+skAWd0AfmnNv+qKireTe9RrzYQWDf3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bga+wPcNgkazenrVvPblgmfOCgmtJ/Jn4LrGDlUt4w=;
 b=RTkPhb770d/HXn2HMqAmZvtnfJ3M3o+129fCWKAe/dcCPqGDbeDtcDCpQ85QxtZjn+N7wNtiij2VecbZqU31pXbtvkVDJDkh7Iyr5UZntJDsw+XT+uos8Arg4+RJUmENqa3U2v3HsrQcia8DAvNrjj5x5MefkdzUxWBFWn9U2gM=
Received: from CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:45:00 +0000
Received: from CH3PR12MB8902.namprd12.prod.outlook.com
 ([fe80::cbb9:aa1d:5ccf:9d38]) by CH3PR12MB8902.namprd12.prod.outlook.com
 ([fe80::cbb9:aa1d:5ccf:9d38%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:45:00 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole
 (v2)
Thread-Topic: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole
 (v2)
Thread-Index: AQHaT93RqXKM1VNCzkWM9QsKm4Jx97DwarMw
Date: Mon, 29 Jan 2024 08:45:00 +0000
Message-ID: <CH3PR12MB8902F83CE713AD38C49C346BFB7E2@CH3PR12MB8902.namprd12.prod.outlook.com>
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
In-Reply-To: <20240125222748.2089791-1-felix.kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e03d5dc2-81be-4159-a5d8-e3165918879a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-29T07:31:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8902:EE_|BL1PR12MB5707:EE_
x-ms-office365-filtering-correlation-id: 14a930ed-39b1-472c-73bb-08dc20a6943a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VfDSws00P8knGHXvxyxVAYAr/xSsdw10RnzG/se1OG3uP2u2FzkdWuhw1qjhxGGBYAt1FadEoRYTfmrUtgXYCKJww6+4I3jKuvue7NZBls6Ezin/boJWyIu5tfb0NF9VCEt+EhGHWpI3t7ADR0978zwgP4GXD/KbN6QX7/cd0OimiLAENRy3YXKUoFONLKesV58oQbvvvyEvw/WbYSK4v7kP2c2M3sXE7futkpvKv4FJYX9HgZD4IUhkT2Vk3cHwohJgHntRgchmSMTUL78wgt/kuFoR9/J3mDng2R43JIrXvJ7dEV5YDXD2CjisO0xc6B9bcGODaguqrZh9pSPcbhQirlfGovlL2diMj0N/HMJepWtHoA9LeBp0VslVH9q48fq+ylFfApmCKoK60a8olB/f8G9Od8d805KOao6dy8K0DgWaczI5sWDJupbYb8pGEzzECSmg3G5h3DSBkpDH3/7a9vYycxfde8NZZE19RafDtTQOSeFKuFXk7ASHPlwehilVpFuN9s9HCyLBwjmWqWJTNYsGXdvZQP6fVMK4Twx3TsUe8/IORD90fHMgJ8Usc8wnwPgcuTuECnv2SzRQaM0NVz4f3nLMa8Fx/M4jkgnM5aA2DtOrCjHl1NBLgxJK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8902.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(9686003)(6506007)(7696005)(55016003)(83380400001)(26005)(4326008)(8676002)(8936002)(76116006)(54906003)(64756008)(66446008)(66476007)(66946007)(316002)(66556008)(5660300002)(52536014)(478600001)(71200400001)(110136005)(86362001)(33656002)(122000001)(38100700002)(41300700001)(38070700009)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cEIvfs5wRr1cnzMLlxOzRUkNzYM+9djFjow5SRKTFeQ8sJ+FC+Kn+Zb3N2fq?=
 =?us-ascii?Q?e2Kyhi7ho9Lc/388gJCNibJkgo+xISKKUe7pgbe8lbXAJLSlLFtNZujWOwcm?=
 =?us-ascii?Q?+67OIiCjuTyxBqJxkPRSCRqQaK2seJEq4PvkXKAUnL59bHJYvhDj7Q1RVNBv?=
 =?us-ascii?Q?qeOU+ZAMRRhYgah8eA0oxazaPHPMKrnxk+RrMwbJf3FvycoZef4RaKsV7dYD?=
 =?us-ascii?Q?raJdBg+7LfwJ+Wovs0OyKz+OG4BJkEIN6jrf+fgOz7nEDOUxP5sgFob2m32v?=
 =?us-ascii?Q?1RpqZx6sI1jdp/WFP541fyZP7UUg7UgHNOytMZ1jQ5/caLXleB/04+Fjc3QO?=
 =?us-ascii?Q?hS6fyAPS8qgQPmoj6wsa1o1eJvdKE7tmkIem+MptHc8SnqmEP28NoSw6Ly7i?=
 =?us-ascii?Q?EpKuo2ILK6cAUvv3DzTN5FfD4jRfDwhJXmAGtMjLYWbFuypM3v3P4x8E3xW8?=
 =?us-ascii?Q?E6M12ur16T8UnMiCzyuxMpDMheQXsVR15FYHL3R8xElh1ndBaAMRXjq3emy5?=
 =?us-ascii?Q?xSug6Lnu6KYGHegv82YjsyViyN5qLmt8BYZFJ7gN7rLosPBvOCEOL74OO1am?=
 =?us-ascii?Q?m1CciAPvP9sVbdpeIdtqvcdcY/BMAjFods04NIzIu0oMPinWinLZ/GtZ+SYg?=
 =?us-ascii?Q?/EPoNdJpole7ycvQhA7qz2F/MyI9/J12pl3l7Rl1IAe84h26bl6ih29FTq26?=
 =?us-ascii?Q?4c+usPMn0WZvmMC4nkt0osMGykstrJzLOaLfmHhQBsGsZG+arlfgJLVaOOev?=
 =?us-ascii?Q?ZELs10L0wy8qSeLpML9bfI2hABwvvZMyOAuhtH28yDv/sBeqwq/ugVxUoown?=
 =?us-ascii?Q?s5A+EGwLZsWFCwjt1NAYFXYJdPQuQbAihm2wbpu2gq7jNxan8E5FRzRSKfon?=
 =?us-ascii?Q?rdBh/ikQ4dDoSEyx8LlI1W8I71wy6H9Ttfl+T5GVK8v1wxF6QlSozR6Lbxi6?=
 =?us-ascii?Q?dOLTcMHIr/SzjTGNPt2hQpskLP/F/TrQ6k6TycAqSJwANMl1KQmXYjMoVmd0?=
 =?us-ascii?Q?y3OZATgWRcXJWxDagxZ2KVP5emm7wObhnelFygunsGwPnOpUo4Zct3OyPC+p?=
 =?us-ascii?Q?3z4J01Inigo3oudSpma3NQOnN1QD17VOAxoletDEOE7gZoxhxBX3yP3Xw+bC?=
 =?us-ascii?Q?F4WnPyNaUWUtLa3gCJYvKflCor62nuIat+K/f6V58RCtVI81zb9OTns7PZLj?=
 =?us-ascii?Q?d/RTWsLpcXIzpSbOph6yDyylLDLXx24h3K9pNkI7U6MqgE8EpRxoV8OfsAEX?=
 =?us-ascii?Q?MXMLqVfmnYVt8fGgWtGF6M12GuAP4AWXLwYsQZM9gNoQw/fsWbki1fqUvZ1p?=
 =?us-ascii?Q?+XFUbjEvnCR9ulD7SzOcPROwynO91UcqE2efnTE0oUhnlaRuSclxMV+XCfAo?=
 =?us-ascii?Q?ue3f82xNKadnT9imQ7oNbLqqlqOdmwrHdIPrVexAzDXHvtXB0MTiz0OZPZnN?=
 =?us-ascii?Q?JtL3FxyuwPTkhwLx2ZbQjurMig+tpO2hwkIWga9VkVXG7sy27SzPfQKgs80Y?=
 =?us-ascii?Q?2/JU940cH5jgNGog2hgKFywRmhVkCb7VZBRyLehubzA85Y8c14eg3W/LuBNP?=
 =?us-ascii?Q?brE9QTRK8OPIwHfrR7w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a930ed-39b1-472c-73bb-08dc20a6943a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:45:00.3017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofBKKbLs8luQhjrh49kA9a1wC/OpNkuUZCgtjHuA1nH1rE9A+OHi+TZGTfu6exU2a17yXfxWlxp8uyuv48zgqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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
Cc: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
>Kuehling
>Sent: Friday, January 26, 2024 6:28 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Paneer Selvam, Arunpravin
><Arunpravin.PaneerSelvam@amd.com>
>Subject: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole =
(v2)
>
>The TBA and TMA, along with an unused IB allocation, reside at low address=
es in
>the VM address space. A stray VM fault which hits these pages must be serv=
iced
>by making their page table entries invalid.
>The scheduler depends upon these pages being resident and fails, preventin=
g a
>debugger from inspecting the failure state.
>
>By relocating these pages above 47 bits in the VM address space they can o=
nly be
>reached when bits [63:48] are set to 1. This makes it much less likely for=
 a
>misbehaving program to generate accesses to them.
>The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL access =
with a
>small offset.
>
>v2:
>- Move it to the reserved space to avoid concflicts with Mesa
>- Add macros to make reserved space management easier
>
>Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
>Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c      |  4 +--
> drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c    |  7 ++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 12 ++++++--
> drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 +++++++++++---------
> 4 files changed, 30 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>index 823d31f4a2a3..53d0a458d78e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>@@ -28,9 +28,9 @@
>
> uint64_t amdgpu_csa_vaddr(struct amdgpu_device *adev)  {
>-      uint64_t addr =3D adev->vm_manager.max_pfn <<
>AMDGPU_GPU_PAGE_SHIFT;
>+      uint64_t addr =3D AMDGPU_VA_RESERVED_CSA_START(
>+              adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
>
>-      addr -=3D AMDGPU_VA_RESERVED_CSA_SIZE;
>       addr =3D amdgpu_gmc_sign_extend(addr);
>
>       return addr;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>index 3d0d56087d41..9e769ef50f2e 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>@@ -45,11 +45,8 @@
>  */
> static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)  {
>-      u64 addr =3D adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT;
>-
>-      addr -=3D AMDGPU_VA_RESERVED_TOP;
>-
>-      return addr;
>+      return AMDGPU_VA_RESERVED_SEQ64_START(
>+              adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT);
> }
>
> /**
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>index 666698a57192..f23b6153d310 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>@@ -135,11 +135,19 @@ struct amdgpu_mem_stats;  #define
>AMDGPU_IS_MMHUB0(x) ((x) >=3D AMDGPU_MMHUB0_START && (x) <
>AMDGPU_MMHUB1_START)  #define AMDGPU_IS_MMHUB1(x) ((x) >=3D
>AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
>
>-/* Reserve 2MB at top/bottom of address space for kernel use */
>+/* Reserve space at top/bottom of address space for kernel use */
> #define AMDGPU_VA_RESERVED_CSA_SIZE           (2ULL << 20)
>+#define AMDGPU_VA_RESERVED_CSA_START(top)     ((top) \
>+                                               -
>AMDGPU_VA_RESERVED_CSA_SIZE)
> #define AMDGPU_VA_RESERVED_SEQ64_SIZE         (2ULL << 20)
>+#define AMDGPU_VA_RESERVED_SEQ64_START(top)
>       (AMDGPU_VA_RESERVED_CSA_START(top) \
>+                                               -
>AMDGPU_VA_RESERVED_SEQ64_SIZE)
>+#define AMDGPU_VA_RESERVED_TRAP_SIZE          (2ULL << 12)
>+#define AMDGPU_VA_RESERVED_TRAP_START(top)
>       (AMDGPU_VA_RESERVED_SEQ64_START(top) \
>+                                               -
>AMDGPU_VA_RESERVED_TRAP_SIZE)
> #define AMDGPU_VA_RESERVED_BOTTOM             (2ULL << 20)
>-#define AMDGPU_VA_RESERVED_TOP
>       (AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>+#define AMDGPU_VA_RESERVED_TOP
>       (AMDGPU_VA_RESERVED_TRAP_SIZE + \
>+
>AMDGPU_VA_RESERVED_SEQ64_SIZE + \
>
>AMDGPU_VA_RESERVED_CSA_SIZE)
>
> /* See vm_update_mode */
>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>index 6604a3f99c5e..f899cce25b2a 100644
>--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
>@@ -36,6 +36,7 @@
> #include <linux/mm.h>
> #include <linux/mman.h>
> #include <linux/processor.h>
>+#include "amdgpu_vm.h"
>
> /*
>  * The primary memory I/O features being added for revisions of gfxip @@ =
-
>326,10 +327,16 @@ static void kfd_init_apertures_vi(struct kfd_process_dev=
ice
>*pdd, uint8_t id)
>        * with small reserved space for kernel.
>        * Set them to CANONICAL addresses.
>        */
>-      pdd->gpuvm_base =3D SVM_USER_BASE;
>+      pdd->gpuvm_base =3D max(SVM_USER_BASE,
>AMDGPU_VA_RESERVED_BOTTOM);
>       pdd->gpuvm_limit =3D
>               pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>
>+      /* dGPUs: the reserved space for kernel
>+       * before SVM
>+       */
>+      pdd->qpd.cwsr_base =3D SVM_CWSR_BASE;
>+      pdd->qpd.ib_base =3D SVM_IB_BASE;
>+
>       pdd->scratch_base =3D MAKE_SCRATCH_APP_BASE_VI();
>       pdd->scratch_limit =3D MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
> }
>@@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct
>kfd_process_device *pdd, uint8_t id)
>       pdd->lds_base =3D MAKE_LDS_APP_BASE_V9();
>       pdd->lds_limit =3D MAKE_LDS_APP_LIMIT(pdd->lds_base);
>
>-        /* Raven needs SVM to support graphic handle, etc. Leave the smal=
l
>-         * reserved space before SVM on Raven as well, even though we don=
't
>-         * have to.
>-         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that =
they
>-         * are used in Thunk to reserve SVM.
>-         */
>-        pdd->gpuvm_base =3D SVM_USER_BASE;
>+      pdd->gpuvm_base =3D AMDGPU_VA_RESERVED_BOTTOM;

Hi Felix,

pdd->gpuvm_base changes from 16KB to 2MB after this patch.

The default mmap_min_addr(/proc/sys/vm/mmap_min_addr) is 64KB.

That means user could get a CPU VA < 2MB while the corresponding GPU VA has=
 been reserved. Will this break SVM?

Regards,
Lang

>       pdd->gpuvm_limit =3D
>               pdd->dev->kfd->shared_resources.gpuvm_size - 1;
>
>       pdd->scratch_base =3D MAKE_SCRATCH_APP_BASE_V9();
>       pdd->scratch_limit =3D MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
>+
>+      /*
>+       * Place TBA/TMA on opposite side of VM hole to prevent
>+       * stray faults from triggering SVM on these pages.
>+       */
>+      pdd->qpd.cwsr_base =3D AMDGPU_VA_RESERVED_TRAP_START(
>+              pdd->dev->adev->vm_manager.max_pfn <<
>AMDGPU_GPU_PAGE_SHIFT);
> }
>
> int kfd_init_apertures(struct kfd_process *process) @@ -407,12 +415,6 @@ =
int
>kfd_init_apertures(struct kfd_process *process)
>                                       return -EINVAL;
>                               }
>                       }
>-
>-                        /* dGPUs: the reserved space for kernel
>-                         * before SVM
>-                         */
>-                        pdd->qpd.cwsr_base =3D SVM_CWSR_BASE;
>-                        pdd->qpd.ib_base =3D SVM_IB_BASE;
>               }
>
>               dev_dbg(kfd_device, "node id %u\n", id);
>--
>2.34.1

