Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A13C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 20:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EB310E542;
	Thu, 15 Aug 2024 20:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MagoyYDb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F4A10E542
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 20:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm53Nj0cQ6rQ3S10ri6vVPtH/2pvXutkAn5+kglQtjBIOmIiTVSsVDm8UvD3TIbv7HPzQlwAwHvapoSlyisT8O83Xyw1ZdCxW8Ar2IJoNhwU9uO/ZwRne3iTuCqI+CYzezzIFKDKeDjkKttywzJG6ZnzlPrR/5JohH4nEeny+c+NeD/HyEPFICurYPAVusfRUxkoEAF5gMPsgmTGRnWJUSJ2TdBcM987OHZO1wLXguYdPmpo2jQkamC7IGiduQaoXUsKhN68VGqAFOno4bIxSITSLHQWzvqZvRj44k1VLZJd4FQDa6Y/BpMQe7pRz4iiXuULJ2lV+hsdQFY7fod9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWqpS3NKS/XpfyO+EhjFkQE2MR7lpkReEIiYXfRyPOo=;
 b=VS+Jj+1I61WBxtUPL69ZtkOAbBjNpYkCe1SQVQ0mqMBYKvAVGZuG2BSX0H1hYnTr78R5copgevCIrAw6iPWJJV5WDVffp50y7rBYclr097I30nTyV8HHjhiwGolCLlTDktc51pkb0UJe1UVXnxrZxLeICAPVMTtaZKwYR6lh5D29q0zvBJv6HxZoRx0jaVkIFPNkCRGTW5qGqUYnH3cGbCrTO35DmuSBdXtTtFJWLBtuHPwBOZsA4U5xEf2ma++BZNm5jzCaP8Of4guuDrwe+sE1bLO0FEmS9MdXf2rJ0s2zxyaM+d8cg+2jIcmDJ08bTiclyzQv7p4PB1Rw3MUl0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWqpS3NKS/XpfyO+EhjFkQE2MR7lpkReEIiYXfRyPOo=;
 b=MagoyYDbg9Qm2XnBMpTPlRl9dCpLDogdbe3wWNnbqh/fV6StL+vVi6l+H1RJtN2uiXsZKB/LGF9WPkMLRcLgLgpGMEcsQLmQb3T1eQqVlC80UuRFX+pDYe/GuexM8hg3nSy1zG0ZJpGk6FVe5/luKlQ13v0oNMcHmxC56qv7msc=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 20:32:15 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%3]) with mapi id 15.20.7784.017; Thu, 15 Aug 2024
 20:32:15 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCHv2 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs
 for GFX11
Thread-Topic: [PATCHv2 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs
 for GFX11
Thread-Index: AQHa7qHD0N89QxgKM0+HKSGzjptgJLIoxtWw
Date: Thu, 15 Aug 2024 20:32:15 +0000
Message-ID: <CY8PR12MB70995C3CAC6AFDEEAD83DD128C802@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
In-Reply-To: <20240814232754.1119319-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f9e57a81-6eda-4070-ae7b-fb9838723530;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-15T20:31:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SJ0PR12MB6991:EE_
x-ms-office365-filtering-correlation-id: 1e614e83-84a6-40c6-b369-08dcbd6959e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?49C3loIC5+V/TZSElyaBYnnjK7Xe//8d6j5+ynnDPGFmT3LVS3b3VKY/Xpk5?=
 =?us-ascii?Q?zDt9JmeroEOiUHKwsuTbTkMCsOieiu+uzqI47KPDkuqszUUeTY6Zf/dTXcM4?=
 =?us-ascii?Q?IYZGh4EiRpr+QCvh127LZ02eFEbFY8g3wmDeUwP1KfsQhnOqkG2qFG+r+wa6?=
 =?us-ascii?Q?j/1m9dlFBTzBMzz6pM+5XyqGCTVlqkL59/pJ0OiDjU6/XBgEcscQP1CD2eqI?=
 =?us-ascii?Q?O7LbjQBNLxQCdZfo9Ks2hTdoWvjFViafHv52TeqeLWfEGuUiutcRRbNaRINt?=
 =?us-ascii?Q?2tK/aRVgbJDOU+suPC192V03LT6RkaVY/K4xyUBLh63B4UCsxxF9qMEJ9V86?=
 =?us-ascii?Q?TIJEFfFheXaZNggqwqSrWEJVD9XLeJRKjBuItLOOfCTSB+Z7rcSvkV9IVrnv?=
 =?us-ascii?Q?HAZPYgyeu+fsGCZxqBjBtY2e9BukmmZ1hMlBaALPLZ3dCt/mFzLqzarrqBDl?=
 =?us-ascii?Q?QJIwR+yaZDiylqgudwZVV0A6aOBtWSl9xFWYb7YK08d+3KlSg6joT2F2G8Kk?=
 =?us-ascii?Q?l86n9YiHmyUvu/Sygrzk0DH3hDL5m9zNextyBYtpYTYhB29VCHTCHV4mN1zv?=
 =?us-ascii?Q?qBhsz1ylbuCGAJzJwVtFBLoxUo8qtpR2prCHfSojUSbRyGnIq8qng0UynS4U?=
 =?us-ascii?Q?iB31q6kWHPiPNpM5wzl1ZezeaNiTTh6RN0NqsHR1y6rwMUayF0fZuc1DCuUc?=
 =?us-ascii?Q?A9N8XMK0QZALSCvj7FHUYKW6fZXqu5sForGRVohEH/A49ELVam/r9t6KBMQz?=
 =?us-ascii?Q?AjawGTUDii/HiivD9DB1ygJUeo7gS5Tpz5R3zZ8aOQh9ZaYSfJofBG7Xxrha?=
 =?us-ascii?Q?kWFr0sSOTtscV3tzt69ndUAu6fRtoU4DEAbgkTEJLr9yb6PXQIdXvjjQLMZ4?=
 =?us-ascii?Q?vcAOCNSyUzN4HrcdLcf0aH63f6uBngcZtBZdcoODPbTvajejUIjO4ERwFHwV?=
 =?us-ascii?Q?+tdgrYZCcrqdvi+Sk9T6m/Dp2rrdda1JO4DX8FgHHoRu2jcvX6x8t1mI92vd?=
 =?us-ascii?Q?o4a0ZdFYkX9EwCW4O+c9gsBGYzz3AsqtJJcaUWWVIjWA53B6Op/jt/c1W2Ky?=
 =?us-ascii?Q?iiP1cNJLIMW59TO9D0cfJvCTcEKwkRSl01yuWkRHnp3ygfqrJbDLOUFbufqa?=
 =?us-ascii?Q?BBgq8jcjKOdbgifXTbYy/BI6KYy4dDlT/zhztQH30k1Vy6lVscW1fjkW8rMd?=
 =?us-ascii?Q?eBZgBsBVW4rtg7kSzWAqwfFgHFYJIZfppbNUZOPKbfyB6I1Pem8PL2M0q/Li?=
 =?us-ascii?Q?5JmUJf481tEREfuESasDmKSYc2JdjURltPZLmvLPvz2buahMQXFeQMqZ6Zyy?=
 =?us-ascii?Q?frZmKXAZNEBGkVm1TVLY8ViNDcp6F5uQRJiOClteOzGTX0E49fqPJVdcNtEU?=
 =?us-ascii?Q?h0vEGTh5Y6cGllQC6TaDsNGCyhBesCfZcQk5lO/K7c/OccN0rw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/ZFnzMpBSq5+qi6/fnxSH1DB+IgOV72aguqV0zBnObER7Kea9dkqE99IJwjW?=
 =?us-ascii?Q?k4sa4UHxNFEl+Mr1YokbTiV294dnc4yg0g6h8jgTTpeO/ZSxQoThjUD48+HI?=
 =?us-ascii?Q?ftUaimZTJvAH+HuLg4kBjv1BvuMBex66QSd6+zOefbUVKZVkbfjsxbd5PLyB?=
 =?us-ascii?Q?NA58hzOKLXqc0P/U9oIDTbMefIS/h/IQqIsyjx4RLyfIT5pnNFw2igTGZ1Q7?=
 =?us-ascii?Q?RFXrjwZEpexeGXdPmpFtGfQ01mgxutOmpuWuiyNSxwwexR5az+NUje6mxtAB?=
 =?us-ascii?Q?6LOZ0wWBZAqeiEmJ+PfBQcqMpt/E1S4rva1BM+1w+/FT1+NaCA5dmnMIqrHt?=
 =?us-ascii?Q?WSdcxfsmdPmqxWbrWNVrxsgqoONJ7+UtdwSg46ASrw4mUczXbDrR2KN5slIi?=
 =?us-ascii?Q?fAgH0UtgJInZgf9LTutjOObyIzbarxdSkOzv7gKWV/A3i13554Dk5cwms/1F?=
 =?us-ascii?Q?h+SRYFdiDI00bbbyxVsUkiv0aGIKEaQgeC4kiCF3iRDCMEzDjMO6zV9kVRI2?=
 =?us-ascii?Q?4D77NrL6H1Fq4TFnPPP8P+D/cQ9y6JwB7exGAPabz1W5BBB8YCy2/nbnbbU/?=
 =?us-ascii?Q?hZse2R3Bi+DITlIJg9aYY3hvk7VKrn3jMCY51ZNrn7NaUf+3ORIORPfTHKVO?=
 =?us-ascii?Q?2erpoV5kVi8j9AiFcCthmWE9GBFg3x+lVNWcVkNKU3S1LrkR/koRBRZ2qZMl?=
 =?us-ascii?Q?9ac5ZPQ+Ni4be0S2Q3nafh4qjH91WjGNG4vzuqYA5ANZ4SOdVlL5fhCDkAqn?=
 =?us-ascii?Q?4kjeRFifW5OGR/kGrLG2JfZc5Mzq29HnB2ttpFJYoBiYIHEShZxSsWZdUx+8?=
 =?us-ascii?Q?6jCqhiidObyvIwAjyjkcjwgxuD0tuI8vePipRAkQW3tFzqxiHUKIjTc126RM?=
 =?us-ascii?Q?9MNTqogIT8mYMyhFzE/PxbIcdIflHfY89OK0gzGUCUqbAN069KST7kizCmIf?=
 =?us-ascii?Q?H8S2+cysmVMeTJePU1frAUkzamZ7LC9B6t0CrWbyis3sbz5NdXOjGbkBMBHJ?=
 =?us-ascii?Q?SfWG5ky2NUAciDP+QL05m2C9zylo3+8pywmkokfsVtsR0d7RjFnbQ+AfPu17?=
 =?us-ascii?Q?1u3xFDRBAK5wBrap45vDK/tFYri75P5U8vPLhhmYXvprdOZxcpqSxeYZvXM9?=
 =?us-ascii?Q?r6pkfdaDWUBRAqbNkj1ubM0ynlqenbOsb1TQmQyobYB0g1FePuwD9exa6+nC?=
 =?us-ascii?Q?B4LqP3BE8Ai077bqByymyP4eXrb8WvBXqsOOtdscCb1YmAcZ2fJRUUN3bPDZ?=
 =?us-ascii?Q?EUspMi7klr4OdFd9sYjaOVPHquNHJmFqezrXO+8KGTt9vWS+QqphyLPvDFbE?=
 =?us-ascii?Q?bXMu+As46fKvSVRhl7py21wtiZqVJ7QxTiNzGtYfCaS8VuowGEDNvOC81zyj?=
 =?us-ascii?Q?8qXa5Ikhy7YxGS0hxaQ1aaw7jtshA3IfK6IIjODq8C9kXOo0atQxgc+Ee/0X?=
 =?us-ascii?Q?TLZfX3t1p+cfAdxPVJ6V5Z48P+6cDcreYAK0puT1bNbnvJcaiPD3qjQc7Dxt?=
 =?us-ascii?Q?z3BHFwbdaKftizapIy+FcOaDN/fPPw174l2J1mKgzWXfhdk/ebfx74ViYfDP?=
 =?us-ascii?Q?IOKkpbo5VSP/q1YXj3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e614e83-84a6-40c6-b369-08dcbd6959e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 20:32:15.7094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqNJ59FwY57Bx7j8eE9VmsewD2doQgNL2FvS7UgiCoiE61Uy1ccoqi5X4DueKClWtINftg4T2ggVyw1czCnUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Wednesday, August 14, 2024 7:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCHv2 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs fo=
r GFX11

Add implementation for MES Suspend and Resume APIs to unmap/map
all queues for GFX11. Support for GFX12 will be added when the
corresponding firmware support is in place.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Add MES FW version check.
- Update amdgpu_mes_suspend/amdgpu_mes_resume handling.

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 71 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 32 ++++++++++-
 3 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index c598c3edff7e..e551943da77a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -501,60 +501,50 @@ int amdgpu_mes_remove_gang(struct amdgpu_device *adev=
, int gang_id)

 int amdgpu_mes_suspend(struct amdgpu_device *adev)
 {
-       struct idr *idp;
-       struct amdgpu_mes_process *process;
-       struct amdgpu_mes_gang *gang;
        struct mes_suspend_gang_input input;
-       int r, pasid;
+       int r;
+
+       if (!amdgpu_mes_suspend_resume_all_supported(adev))
+               return 0;
+
+       memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
+       input.suspend_all_gangs =3D 1;

        /*
         * Avoid taking any other locks under MES lock to avoid circular
         * lock dependencies.
         */
        amdgpu_mes_lock(&adev->mes);
-
-       idp =3D &adev->mes.pasid_idr;
-
-       idr_for_each_entry(idp, process, pasid) {
-               list_for_each_entry(gang, &process->gang_list, list) {
-                       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &in=
put);
-                       if (r)
-                               DRM_ERROR("failed to suspend pasid %d gangi=
d %d",
-                                        pasid, gang->gang_id);
-               }
-       }
-
+       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &input);
        amdgpu_mes_unlock(&adev->mes);
-       return 0;
+       if (r)
+               DRM_ERROR("failed to suspend all gangs");
+
+       return r;
 }

 int amdgpu_mes_resume(struct amdgpu_device *adev)
 {
-       struct idr *idp;
-       struct amdgpu_mes_process *process;
-       struct amdgpu_mes_gang *gang;
        struct mes_resume_gang_input input;
-       int r, pasid;
+       int r;
+
+       if (!amdgpu_mes_suspend_resume_all_supported(adev))
+               return 0;
+
+       memset(&input, 0x0, sizeof(struct mes_resume_gang_input));
+       input.resume_all_gangs =3D 1;

        /*
         * Avoid taking any other locks under MES lock to avoid circular
         * lock dependencies.
         */
        amdgpu_mes_lock(&adev->mes);
-
-       idp =3D &adev->mes.pasid_idr;
-
-       idr_for_each_entry(idp, process, pasid) {
-               list_for_each_entry(gang, &process->gang_list, list) {
-                       r =3D adev->mes.funcs->resume_gang(&adev->mes, &inp=
ut);
-                       if (r)
-                               DRM_ERROR("failed to resume pasid %d gangid=
 %d",
-                                        pasid, gang->gang_id);
-               }
-       }
-
+       r =3D adev->mes.funcs->resume_gang(&adev->mes, &input);
        amdgpu_mes_unlock(&adev->mes);
-       return 0;
+       if (r)
+               DRM_ERROR("failed to resume all gangs");
+
+       return r;
 }

 static int amdgpu_mes_queue_alloc_mqd(struct amdgpu_device *adev,
@@ -1608,6 +1598,19 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *=
adev, int pipe)
        return r;
 }

+bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
+{
+       uint32_t mes_rev =3D adev->mes.sched_version & AMDGPU_MES_VERSION_M=
ASK;
+       bool is_supported =3D false;
+
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0, 0) &=
&
+           amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0) &&
+           mes_rev >=3D 0x63)
+               is_supported =3D true;
+
+       return is_supported;
+}
+
 #if defined(CONFIG_DEBUG_FS)

 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unu=
sed)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 548e724e3a75..b2db62e50454 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -494,4 +494,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes =
*mes)
        memalloc_noreclaim_restore(mes->saved_flags);
        mutex_unlock(&mes->mutex_hidden);
 }
+
+bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index c0340ee3dec0..a5c582674db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -421,13 +421,41 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu=
_mes *mes,
 static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
                                  struct mes_suspend_gang_input *input)
 {
-       return 0;
+       union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+       memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+       mes_suspend_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
+       mes_suspend_gang_pkt.header.opcode =3D MES_SCH_API_SUSPEND;
+       mes_suspend_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
+
+       mes_suspend_gang_pkt.suspend_all_gangs =3D input->suspend_all_gangs=
;

Only suspend_all_gangs and resume_all_gangs are set by the caller. None of =
the variables below are set by caller. Is that ok?

+       mes_suspend_gang_pkt.gang_context_addr =3D input->gang_context_addr=
;
+       mes_suspend_gang_pkt.suspend_fence_addr =3D input->suspend_fence_ad=
dr;
+       mes_suspend_gang_pkt.suspend_fence_value =3D input->suspend_fence_v=
alue;
+
+       return mes_v11_0_submit_pkt_and_poll_completion(mes,
+                       &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt)=
,
+                       offsetof(union MESAPI__SUSPEND, api_status));
 }

 static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
                                 struct mes_resume_gang_input *input)
 {
-       return 0;
+       union MESAPI__RESUME mes_resume_gang_pkt;
+
+       memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+       mes_resume_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
+       mes_resume_gang_pkt.header.opcode =3D MES_SCH_API_RESUME;
+       mes_resume_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
+
+       mes_resume_gang_pkt.resume_all_gangs =3D input->resume_all_gangs;
+       mes_resume_gang_pkt.gang_context_addr =3D input->gang_context_addr;
+
+       return mes_v11_0_submit_pkt_and_poll_completion(mes,
+                       &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+                       offsetof(union MESAPI__RESUME, api_status));
 }

 static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
--
2.35.1

