Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A84C54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 12:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D224D10E2EA;
	Thu, 21 Mar 2024 12:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UEE7hMEm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F093410E977
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 12:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwHPmjU4pQUqSbaEm6uKViQFtqS7SntoSFwmw9AHNLvWkNkuXtcq/j9WekgL4OIBjoMEMCm12oNYK+4Cy6OMJpycrA62kvrev8RcAZvpcSUXTR7XEvLW6qy0BryMxd6s9o5457REdKXQLvTbAM3ld8oukAG54CAACW347EFYwdVtMY7u4Ql8TEIoQOCV+U+xdmkGCQXBClRs7abZMqyzOafKYrLZZk2BWGm4pSWHJvR/zJ1fQJp2PcPWrYBnQ6xekeJGZA82wjkrCYiXZEnd7/XLq0HxpNBRRiWd8BkJ9iDl2Cc4QWOAyKh0wno/eBOha3OHZDvJeppaeTOGIfc5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euFDtvZiQZEMXy1dMhkkjG+CbBE1dY0ihJKiM9xrlgk=;
 b=ERccwZJ4/mHEnsaYUtLAGF2tO2FDYpOj4bmmEQwPFCdBzVYqSnRjj9NQB1BBHEThVq5ac4T2OFLgMLLAzupI6L+Ir4Lc2S1xZQOJJDGElsj09QnIsTtb1j27NsFRf66qqwLI1AXhRM83bstNF+oPEH+DXHfzQ8KrS94JcS4wy/ksNELZmTMyFryqLn7rjCJ2mcXYC93u9xDxd2ecnpi6CpIjusqvVn9ekABNF6l2Ikmh2plB0DriARwb6+wSCAWRRLBsUUvDNvUBdIaYAqqQDF2Su75R6EFRAAoZH+W4SFLaxyqLWwkaiF7MRSQqInEONlC09ddNH7a2leUJemDz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euFDtvZiQZEMXy1dMhkkjG+CbBE1dY0ihJKiM9xrlgk=;
 b=UEE7hMEmMgiqPxYQ/+goOrSsduI5X2LTAHSVr+4SoOlPeo4CpXCL9u2KdfyxyN3IlcLHlADwptlTL42lZ2j3hBvF7TjamKzIbs0nxU2/EPr4fV5LB9I0Co+27kvcWsbBH8kBfSZSLc8C4JV7q94zK1JXoK3mGKH0YX46vU6AK9I=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Thu, 21 Mar 2024 12:47:16 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%5]) with mapi id 15.20.7409.022; Thu, 21 Mar 2024
 12:47:16 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Refine IB schedule error logging
Thread-Topic: [PATCH] drm/amdgpu: Refine IB schedule error logging
Thread-Index: AQHae4xkH2S/bCpXvku/8Iqzk3cDorFCJJyw
Date: Thu, 21 Mar 2024 12:47:15 +0000
Message-ID: <DS7PR12MB60714D39EB1FD5DB5CEFC30B8E322@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240321123606.764092-1-lijo.lazar@amd.com>
In-Reply-To: <20240321123606.764092-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6b5ac4cf-d96a-41cf-9696-02ff95455e93;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-21T12:46:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DS0PR12MB6559:EE_
x-ms-office365-filtering-correlation-id: 1f2e85e6-49ce-448e-164c-08dc49a509ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U09gsJ0aKzWVh0lpfgd2Sby18HV6hsRWw+AmIVUlwW90Jaf/AwTqYIGUIkUCq7QMrhNws2/1hnqCKBNv6ABu1ot7WqNqAK9ulDQwOTan5yVgYgx8xuAjJ18IqVx99j6xHaaM6VY9mWTxZJQM6iMmBl2ytv4RqARY2ufiZP+SaYhZXvrIIEnHpb8XAdKqbaFabo0+k8iHIyvXRmfTJqsdBSVcoN/ZQDVeDut/wNYs+MmjaSmbCAu34+ruFlb0y0tzJ8IwCwGQff+b1NR31fGLoTn+dJ9/NlLi1AjmOV8BkbUiLAeKCEFT+OGJEvfnWnGS+GRmVLsB0PtgSv4orUiZrMiDhEWDUrvjav6vK80P9uQre8NCrISFeBkRPDdCoIOjJIMpYtApx7EXmel0avHCaQGvZzRDwix/csJYE408giAh+KtW26xhjybVHdEM1PvqsD2GeTibgBx+EOg+GwjBKk/F+fgHQYLDozGV01QLuqo3XHWhA+FYd6cpLlXv6OtidYIDRqUG/nUQgRH6AlYJiwwZHG38sFwz8J37QRx/4LzMIgIce/Ok7QUEDhSJdunPyb1wmY4vNqo+NFbHnvWsHTaGCvKyE5OIxQfHni3KgDX+YEf11k0hE4q5fI+WUG+fw8B9T8WapqItVxHnsv8mDxb34t+PiC7lXuyBXq8Tzuuu6LwN/bANDHz9qw67Oeb8Js5xjiZoPdkLXhxxGZ3tzDHvqSYNVwnCp3jlnIAxYQU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zu4oM+DOW8B4p0pDbhgCZ4iMgQrcdw0P4PtfhV4nAQZrPNucj4p4VgNyh7O7?=
 =?us-ascii?Q?EAbJahYNDWKKe3EPVZ51RgOi5j1i4fGfaZWqrmnwOrLxnQRxPZgXLTlqtV/X?=
 =?us-ascii?Q?FA6vWH2n4ujDIeT/XddUNZkWsTzzxa9R+ggBh2haPTzzdgbndHejzQkA8/o1?=
 =?us-ascii?Q?0dzrbRgefnpjLdR+ZGW90pc+ZRji4MjcN2ONF13CRLgCwv09onFKLro7mtaM?=
 =?us-ascii?Q?vbKuTaG3jZLeeLM76qu+pJFnoG8Tie2xsZNuLmPAUTD90z3Sr4E4Nj0nWtTh?=
 =?us-ascii?Q?+OAZuhjtHyxVE3Oxr6yJOJGgdzoeQpyCSLzSYLA2sFXWoIPqNb4y0dHf6VUv?=
 =?us-ascii?Q?1s/f7GrOjUy9UW8B3DOYjsadulyVBLorgD93rh0TyaO1FbOv3nWA4dyplgRB?=
 =?us-ascii?Q?O5iRHCtuOD/w4kIoxHm2A1ubrj/Hfc5Ygeim/7z3vgTlZoPjmehuZTEmBFiH?=
 =?us-ascii?Q?iI8+vpu7L12ClT4/mDrnLHN+SlxmhKdOeuF1hecuL/cPUX61yTsukmNNCHhf?=
 =?us-ascii?Q?fWoVSFl3fpUtfENW1F9xHnULHF0m4uy5o83nm/k3d73arpUe+1ZNXNI7wH4Z?=
 =?us-ascii?Q?KAAtijp0wWRyaNVwKKzMf5tsQGSz6FVt5QanRwsT9i4yU9+STE1ct+bz0WN+?=
 =?us-ascii?Q?zFG1G6Ms8nZUkvrL2RWc2HB6QLYi4jFwTGz6ONjkxmdb+cSO+oued4DqOf0x?=
 =?us-ascii?Q?Lc5VMKZttcvyTU6W5tVrAsqcwMqmMif+hgXwjVr8EBXfGr1LLh99E5LO9H55?=
 =?us-ascii?Q?MEDko0RjyA1lw21WwJnOsDXxqRUxq8l+nnqQfXeDMDkC7svvrsQEHrik3Spu?=
 =?us-ascii?Q?YaYgkMdEK4rNZK3wdw0qX2FG+fVsfDv4LlQTeSuZA9En0gD3gjh/4gLGg55l?=
 =?us-ascii?Q?kC4z4LAskLbS/rR70HlukgeAmoSCrxyxYN0oph/iTdUlZExRW4okfMgAfK5I?=
 =?us-ascii?Q?h7OuUTs0GmQIfXZKp0e446DJ3ikVVYy474ZnVXK/AiZ1tqKFnfl+ESdrwhJE?=
 =?us-ascii?Q?FtMkIqrD63xPXHptSaPLnO6rCv6H8dno48pp9QMiIggq3FfOj2POTXi5+62d?=
 =?us-ascii?Q?EJGO8gNR+GNnY2V47aXFCUOZ1PKkNqFr9caQ4qjj82wshH5Rr7t1OjvBbG1n?=
 =?us-ascii?Q?OIZ/cifx+k4qRrlYfefvLRPdHOr9B65C9PdSKGDEt+q/N86fWg24aFHZujTG?=
 =?us-ascii?Q?DVeDZtoMPow1o1owDI0yUR6wMQss/fgrPq4BugtiAN++cwbb/FsDW/oE+orE?=
 =?us-ascii?Q?tp1fJ4/P/giXZBN+DSchSFkgzEG024bypPe01prVNGZPEXocXmXGFvh0HbWp?=
 =?us-ascii?Q?7lPZ2HSOEguOKmWH4PgbfDhbc+tcH8K4gy8i9V5RLLvYJ8b7TsbtimG1PHB8?=
 =?us-ascii?Q?GA7//knbXbcIl+QoxlsD1God0i5yC4atZtmK7z+AD25Op0lHxoSmwRRvAmBH?=
 =?us-ascii?Q?MZaN3BXwc2oP0w6KpCquU34QS+ofAkwPU1QRdEAcmmuMnRrxnIamLD6yAK90?=
 =?us-ascii?Q?Oj5NOgGdvqXNAQ/eV7h7pQHke/ORJhbGS68IqEUAOD9BrjUXm9ceYu1olblo?=
 =?us-ascii?Q?+tUczT1KoA+nS2aH5mI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2e85e6-49ce-448e-164c-08dc49a509ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 12:47:16.0275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQSVTqZ7qPFi11oE8TmB+iq+P9WsXR9mU29WnX7R2go4oQOXPItCbwtvgUXIFtmWAZvKlPalkcnP1accE8HbsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, March 21, 2024 6:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Kamal, Asad =
<Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Refine IB schedule error logging

Downgrade to debug information when IBs are skipped. Also, use dev_* to ide=
ntify the device.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index 4b3000c21ef2..e4742b65032d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -304,12 +304,15 @@ static struct dma_fence *amdgpu_job_run(struct drm_sc=
hed_job *sched_job)
                dma_fence_set_error(finished, -ECANCELED);

        if (finished->error < 0) {
-               DRM_INFO("Skip scheduling IBs!\n");
+               dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
+                       ring->name);
        } else {
                r =3D amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
                                       &fence);
                if (r)
-                       DRM_ERROR("Error scheduling IBs (%d)\n", r);
+                       dev_err(adev->dev,
+                               "Error scheduling IBs (%d) in ring(%s)", r,
+                               ring->name);
        }

        job->job_run_counter++;
--
2.25.1

