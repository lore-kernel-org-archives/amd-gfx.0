Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD07FC27C79
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 02:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3090A10E08F;
	Tue, 18 Jun 2024 02:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lalWu/3c";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 178A110E08F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 02:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFolXPOPNfBuSBbelaQ74ALUem0S/QWbyF/PTt93RSCJ440VouKeq5hwah/KbR1DYrwOgxKHCiIXvWoaGGJJx+BErnLBNZ4h2qE2nP/04dJ2WILO3NCswueUAL3/tzuw8IEBjPED+1uFHhXcOSikpPey6irpEs2gq14Jqpf1ThAlwuo7TXvWcWYXCbtEMdpilw4WL/B6xKVQR8hwRj8cXcFrN8i4U5ZMrUPqi4cG0bjWgLix/DTjcYc0tyDmb7ZAydMqSqsDmtbsvXk2+RMUKsbNtvKKGUAfFu4kXVYHkkrHC/ag54zXSYRsj38BkIQdaU+4vxGG1VfRBxAnMixn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjFiqQxFqnieJ5742aa2qJu/D7MTYP5nvwS1jSOWvG8=;
 b=SjRFI4vbnHDRMBkdKe6lfnKUuY95PvKyDf9PX2NIy1RZ85lZn3YfnR6FSwgArvISMLZG4uk31yxS3nlhnvnFlrdpnEFbWUMYy2hYyTNsUwYh5g0uUbw4jn5+qhmjzu2lXjyET9SDEpd7XosmROu9Wo+JT2qzp0YJPvATbTn5tfnnjts5wO4uEkf4Ra4s7Ntpub+DcrekZRzFXoggncKpME8PxQkQhz2V2JE8ywufdoWurYJDZElQQbV8fGYNzFzYUPghT3qwxZVYm4r3vACVYrmykIkBXOSMM11rSTJ1/b8WqaVCMDXSuaidVNiwOaw+OOoEf3rsbf3GSJcOFlxIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjFiqQxFqnieJ5742aa2qJu/D7MTYP5nvwS1jSOWvG8=;
 b=lalWu/3c6V2v0TXY+CSuVw5RboM0uKXi51N4UNlzrsOKr9GaqDIlaIflbJTG6vbn7g9dIHHHDXCaNneYy3d6G5qmM1Pr3r9BVdIK3n92akDC67tJPSxY31YcSQolh7pBpPHYobyzfI6h/cOK9+9KAlnnr85Ek+VJqU1Eh1Lh03c=
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:37:04 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::361d:c9dd:4cf:7ffd%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:37:03 +0000
From: "Jian, Jane" <Jane.Jian@amd.com>
To: "Jian, Jane" <Jane.Jian@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Ma, Qing
 (Mark)" <Qing.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov
Thread-Topic: [PATCH] drm/amdgpu: normalize registers as local xcc to
 read/write under sriov
Thread-Index: AQHawJ6yG9MRHjnr0Eah5LuMwQ1JL7HMzoyA
Date: Tue, 18 Jun 2024 02:37:03 +0000
Message-ID: <PH0PR12MB5481DE5A3D1130C9504953C7FFCE2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240617101114.243566-1-Jane.Jian@amd.com>
In-Reply-To: <20240617101114.243566-1-Jane.Jian@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e5190107-8d6a-4366-9ee1-4225422fefcf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T02:33:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5633:EE_
x-ms-office365-filtering-correlation-id: ae1f7d3a-f79f-4aad-8b43-08dc8f3f89e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?T5b0wf2lYvdVC+MBEnzSXLB6FhrqzMT6+vEOwJ14zkJ4RxI+8w42VTN6lBNf?=
 =?us-ascii?Q?3/Rv/STShloXZxHY+/EET//LMRKINOdqulHQpl3qejdhPjgAmr0Y8QsechPi?=
 =?us-ascii?Q?eJXh3Tn+WKnujJYhH/gwvtG9yrPhODYdTPAhOTtgHzBTDyc3jYoNqudBequX?=
 =?us-ascii?Q?sY1haYzqUfWe/AYLoW9me5L7qK8uJKrhNivT5gfPykHj43BmetccdFtHyjhk?=
 =?us-ascii?Q?X7xiU+UvsFmNUoMUb9B5BcULVUIGfOvigVrR224xxy4apaw3jP3BZNu5v1Om?=
 =?us-ascii?Q?oqT7xLRVVVgh5YV/77evS0MnpwX+EzHm5jTnrLsEJiQkgmxtSKrRD7A3MN6B?=
 =?us-ascii?Q?GlLqRIIGNkuIE4xpaJhEmG9QG9UUdjW4oFtKD2OE1sv5E5wb6+3S8FankkWy?=
 =?us-ascii?Q?JuHMDKxm6VsX/14Mp+sK3mplilJDvjG5n7QYTAdfta657wngyX7fnlPO/WaH?=
 =?us-ascii?Q?VKqsS3irNiQzp88pkDO9zugsCLS82rnsj+QEETRckqB5oL/Aj76BvQBRgK8N?=
 =?us-ascii?Q?176NgAouEMN0DpnzK1KZ3j+oYct/jUgZs1g5HlD/+TTYjyhmK1fJjb9+y2tg?=
 =?us-ascii?Q?HBgrCWx40hUBxMMMOGSQkZGeZNDuS82eHYDDuR6PRmD/2hvqX1i3WDrTypzy?=
 =?us-ascii?Q?5lmYk1o7Dlkqg46F37WfZhyjIb8GtPcrve3ohR9HJz/bqkAW+an/VT9hT9kg?=
 =?us-ascii?Q?I8XS5BrMfbRbhSHZQIXGgzM2VGLAGFtkk/UbuBgRweXO5qZ2w+koMvX1jVaD?=
 =?us-ascii?Q?VtCZ0h2aJ+J/PatrOi3NuuFzWU2CVwRyhrox+L31GqPLU6t+A4NssWdo116V?=
 =?us-ascii?Q?b6oPbOaPCGHi80ePRmvpvDz1QuqaGVm0X3QYQwZF2ujO5cdaDFGizA+/glhX?=
 =?us-ascii?Q?YLmlB95IBbb/ar7pq+E4nxGcFanUP+b8jhqR4HY7WHWFmQUuhRTLVwdu6x/a?=
 =?us-ascii?Q?+QDLNhqy1rKJ7VZk094gllogynjULxNkwqOy9GK5BnZfgclm1Nx4GH3mF8UX?=
 =?us-ascii?Q?bzVc8GTK2mp6Q/TOW3qUKFIA80j7VMpRpqo0auTOCXuxT6LL4niKV3Wo+/in?=
 =?us-ascii?Q?2gqL3PpKLaiXU69jLJHHbOEFPWhJ9vxGV3QPi9MBznM7Us4X0tmz5w3zJkgZ?=
 =?us-ascii?Q?oDzc9xZJPBkPYv66gKBTA31tQbPd+G82SoWUWVTziIF4F0oi6OQb6HMJVFvM?=
 =?us-ascii?Q?wmeHQE2cEk6wLHQYfJYWW9+t67ejXdPHhARlPO3EnfcQKbFRuXL2Xow4/Wpu?=
 =?us-ascii?Q?4CkYd/FHNPjLRT0lMrSboKTnayEYXUCIBOy8mM5WKzEGKqRf1XN5D3pLqRyN?=
 =?us-ascii?Q?gA/hrbr1Oskzt3R5ETDHk9cbp1iP+0Hc+fZAhBChC53D5hJUK0qN5OLsjQ+g?=
 =?us-ascii?Q?F6oBhVQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jxmWIUKd0MAECz4yidJgWrlWG38FOPib2lr4ukP7iD3M+1j4mmFTLtHno4+F?=
 =?us-ascii?Q?PKCz5aEhqmzCxpE6fkEmgF23P02w4PXFbmLfp8LY3lw0haEPiRnSifJ13Ms3?=
 =?us-ascii?Q?QdLjF98+IU8LfiJljeOZv+3FaQ7SfhG3LmHWUZGNnWO+vyg1joNRw/iNYsLa?=
 =?us-ascii?Q?tHXDZ0mpUwnRjcwOzw6a8eii32cqaiw2jPQW9/A/p7PtUsp+O2apjIeqnsbo?=
 =?us-ascii?Q?lH7zHIArB5IHXqk2PgWfsKoWvhpur+Np/EnVbA4wMJONBLDoYcGEeBGIFwWl?=
 =?us-ascii?Q?oHjrChWX1q67HWYjA1Oi9DVLHEiqoLi0IZ9TuYrMJNfbhxomVVDQh9M5/pfI?=
 =?us-ascii?Q?HaWU1TYpGKolCNT2M9aqAbIC7SVL43iXFPlYfnNkqQ6bV1qNzphnc8cTbCsO?=
 =?us-ascii?Q?9nMFcG13yhbWCQeq8HAMgGF8fRr+hWJhitUw/Jm9Idk5PdI9GvLZKHTyzR9L?=
 =?us-ascii?Q?Xho5bUFbql0qZA5DSc6XMeeTHb76y85/FCvIuV588qUbPriTC6iB2N5IqM+l?=
 =?us-ascii?Q?a+E6Fd5+9EcXXZIsQ/bTK6g2fjPu0eHifmtp/vMAehBDQ22eRBkzvgsX0ks1?=
 =?us-ascii?Q?Lr1w88GW/lmalvUsZDuut0f8EMc7LQ6G8+MPCGAApfj4GMr0oKMs1qpNPfgW?=
 =?us-ascii?Q?CAlEkpL0dqCf47C7nsH2QunCkZYi4l0bx2raZB8PK4+jf21WLjIIeu5yuLkS?=
 =?us-ascii?Q?dwvhop8d/RcY/8N4PGE+vXsfIhBHjQooDmrq3cLNmaIr4lQGEWD+hMyheUBg?=
 =?us-ascii?Q?EvZh1/xI0Pjnxy4yKZdHPv31dtItd7dIzgvYNVz29qzg7UgKAxsMBhNZlE26?=
 =?us-ascii?Q?pMZCLNlj9cs1A083rntWagVWQnHOO/nOxUnvE/cGFY6XFesILpVQ5b3RLyE0?=
 =?us-ascii?Q?HFjFuu/hcutl08Gqxsjh/6MwMn4gjoyT72MFxUF10e0rEonW/KpvnUcZVt6a?=
 =?us-ascii?Q?xRHAt2OonIkCwHmfDXcovfQnk2OQpdKbARb00/yEhmf/57YNfddfdBKvbIHB?=
 =?us-ascii?Q?Ew/nCSXL0K8UI4f3I5hTnXIrbxzEGmqvZS1FnRgNdjpqAVJg0TkP68z0CoEU?=
 =?us-ascii?Q?+trKyY2xYOiZdpQHpGFQHGL4qmxfnkTQIXfCp6x/s4C6ydH2nSXWYYf/ULLS?=
 =?us-ascii?Q?M24zeEK9cVUI2Tnx1E5RAo+r6idmJcTMxvUfc782fIue9R0AGP6e5y180JnC?=
 =?us-ascii?Q?MAUIJ8UxE08mFvmtoKkVdLCsoTN+SX2ZmwFv9qDP4dNN2HFGaHnTPIvl+vCw?=
 =?us-ascii?Q?SuhpJXJ4YsUCtCPROC/cTfduH0mD/MW2i6VEvec7qhha+l+9iUjPXsvOCDlg?=
 =?us-ascii?Q?QGF4/22yLuzaQaD9o1VKVQnjbjnHtNfXPoa/eAlrGi65XjtP9qe+yFW2qnJO?=
 =?us-ascii?Q?RnhSryF5vYmSZrRIQjlyMt9ra88D07iIitMNjEONrfi5yYJxdEMw2iGe88uX?=
 =?us-ascii?Q?4S93vnfJXwHBnTo+NdQg6c32M3p5a8qGz6jQOVgOYCCRGHwbq1pD44ga19hg?=
 =?us-ascii?Q?Igo3v0HpfbGLKUChILV9iRKS/6xPx2JE7qq4jxhzK22xzEAYIKqcdgIHUJO6?=
 =?us-ascii?Q?pxb1nL/A8fdKnP02QHA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1f7d3a-f79f-4aad-8b43-08dc8f3f89e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 02:37:03.8514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: go7qSCxbn+1mXqYVlmS3t+D373nytmsSk+lwxOtmBuYng3FY/L8tlsTBiStcTcEypwzrX3kST7+AwwQPitg53A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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

Ping on this...
Thanks,
Jane

-----Original Message-----
From: Jane Jian <Jane.Jian@amd.com>
Sent: Monday, June 17, 2024 6:11 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;=
 Zhao, Victor <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Jian, Jane <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write=
 under sriov

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher=
 bit violation RLCG will mask xcd out and always assume it's accessing its =
own xcd

also fix the typo in sriov_w/rreg:
for KIQ case, use xcc with xcc_id to read and write

v2
amend some typos

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c  | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  2 ++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 63f2286858c4..d43652a38484 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1075,6 +1075,10 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
        if (amdgpu_device_skip_hw_access(adev))
                return;

+       /* Select lower 16 bits to write in local xcc */
+       if ((hwip =3D=3D GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
+               offset =3D NORMALIZE_XCC_REG_OFFSET(offset);
+
        if (!amdgpu_sriov_runtime(adev) &&
                amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,=
 true, &rlcg_flag)) {
                amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag, xcc=
_id); @@ -1084,7 +1088,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *ad=
ev,
        if (acc_flags & AMDGPU_REGS_NO_KIQ)
                WREG32_NO_KIQ(offset, value);
        else
-               WREG32(offset, value);
+               WREG32_XCC(offset, value, xcc_id);
 }

 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev, @@ -1095,6 +1099,10 @@ u=
32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
        if (amdgpu_device_skip_hw_access(adev))
                return 0;

+       /* Select lower 16 bits to read in local xcc */
+       if ((hwip =3D=3D GC_HWIP) && !(acc_flags & AMDGPU_REGS_NO_KIQ))
+               offset =3D NORMALIZE_XCC_REG_OFFSET(offset);
+
        if (!amdgpu_sriov_runtime(adev) &&
                amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip,=
 false, &rlcg_flag))
                return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag, =
xcc_id); @@ -1102,7 +1110,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *=
adev,
        if (acc_flags & AMDGPU_REGS_NO_KIQ)
                return RREG32_NO_KIQ(offset);
        else
-               return RREG32(offset);
+               return RREG32_XCC(offset, xcc_id);
 }

 bool amdgpu_sriov_xnack_support(struct amdgpu_device *adev) diff --git a/d=
rivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.=
c
index 88b4644f8e96..5bb275b96e6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,12 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
         */
        if (adev->gfx.kiq[inst].ring.sched.ready &&
            (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-               uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance *=
 eng;
-               uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance *=
 eng;
+
+               /* Select lower 16 bits to write in local xcc */
+               if (AMDGPU_IS_GFXHUB(vmhub)) {
+                       req =3D NORMALIZE_XCC_REG_OFFSET(req);
+                       ack =3D NORMALIZE_XCC_REG_OFFSET(ack);
+               }

                amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
                                                 1 << vmid, inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/am=
d/amdgpu/soc15_common.h
index 242b24f73c17..9ddf68e7d06e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -210,4 +210,6 @@
 #define WREG64_MCA(ext, mca_base, idx, val) \
        WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + =
mca_base + (idx * 8), val)

+#define NORMALIZE_XCC_REG_OFFSET(offset) (offset & 0xffff)
+
 #endif
--
2.34.1

