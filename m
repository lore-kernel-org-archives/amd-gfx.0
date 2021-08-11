Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D4DC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 01:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B7460EDF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 01:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90B7460EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D666E067;
	Wed, 11 Aug 2021 01:15:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ABC26E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 01:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8PcM48TmuCz2R5xcNIY3UYZNlUwQnHQ8vVwKJb7P7lQEREQkSZFva2vVpB2UJuHEMj6SLzdsQY3TUBwQZCOIphiWu6C6bz8XoBDzUaoHe27rH2CDmSXoGgtCnpub0UVDufcrAqAo7R+Hw8BluirNskway1keFwARaJk4I4WzBaHaQw9KH4+fCUFbe/QYhP6vJ3l5ffi21b8hV7Rx3c1lLZRNE8V3KhOG0TPPw4baNORxP5zIxVhvGba9SFh0IBSyy2LNpeHlsHRk8E4t+sWW0rlT2BoM1hfJRtI96EFk3LLNuiu8GQVnhpqlWlLpNkjEBDji2UPSjxyNFYFjy+gyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC4V8WXcWtLqhyjF2bMZ3QmMei5ya2eRCWlZkYS2QPc=;
 b=BaCeX9NBpAtPaJ9nvdM1MiYstcpoNrSQ+LOh77Xpd7pPyF4Gzy7JEaBZzZnXFsp57DUJGmbjWbf27v82fioDIdwm4z3hyaBjad2QNA3MalJg3WPBTGldj+mCTH3utk02IGz73bzQiCHblPK+KzqZD0WOhpPiRbLal5hoFf20AvNbX8iD18uRdtamXwEzPXN2ld9iRo23LYIQOQi4/QRNiN3y3Go66TaroWTuYbP+ERb4HAywK+3QY32IZ+kD6695vSgyFavQncSr88ASPlb1fo3nnY+ORjnmcIok4OlVkVkH9puO9V9aDWSdipuMIX5GIg1ndkUGy3yg1CWzS/8iFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC4V8WXcWtLqhyjF2bMZ3QmMei5ya2eRCWlZkYS2QPc=;
 b=0fPenG4FZnSmyyxfQWtlOSyzMl1G6XvLuSmMvhL2cniMBy4I0Xn4vtc5tnbxe7ps3VAPN3bYILZg+4hLqBj0D+7Lc9mwe7iJM1JBr/k0yY8svhe+JoVIPl6Zab6JUXEzMLgRKEh6ECehz03vpx6gS481H1ARHrE/F33dfCFci64=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (20.176.118.91) by
 DM5PR1201MB0138.namprd12.prod.outlook.com (10.174.107.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17; Wed, 11 Aug 2021 01:15:09 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::99e0:f44b:512e:f7a6]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::99e0:f44b:512e:f7a6%7]) with mapi id 15.20.4415.014; Wed, 11 Aug 2021
 01:15:09 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Cornwall, Jay"
 <Jay.Cornwall@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH] drm/amdkfd: CWSR with software scheduler
Thread-Topic: [PATCH] drm/amdkfd: CWSR with software scheduler
Thread-Index: AQHXjV7lejSx0kVw3USLzatEjt7N/KttgAow
Date: Wed, 11 Aug 2021 01:15:08 +0000
Message-ID: <DM6PR12MB27613B1C5C6926052F80A81B8CF89@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210809204048.2735-1-mukul.joshi@amd.com>
In-Reply-To: <20210809204048.2735-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-11T01:15:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9ccec323-9df5-475a-a808-02e53911fc4c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 546f8fad-59e9-4609-2fb1-08d95c657634
x-ms-traffictypediagnostic: DM5PR1201MB0138:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0138F5FC5ADB8A08B1E5E63E8CF89@DM5PR1201MB0138.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFAVsETDulUw26iDghd8TLM4l5FKObEtDVBzsBO5wZ9IuOjQUot9iRXqDBArUMaXB2fMJlyv+6+LLGsBJvH3N+ctrKmauZpU02SF0H3rn2vxkHSMbhQ90XKSIfzmHde0Ydu9ZHtHFlui6JBhhtOZfDpqdS+e4MSE9X93xETjISTj4Azh6c/0yRyNEcdXSa+ujAJ6lwtaeedumeCg3peK34HiEbkTHnu58oRmxfAcjjx1LaH3mAwGbvRYyYZOY609151iSMu3e/+1xWjfT2MSFyVXtaPYybXJc0yfFe8TWJUPH3FS986nuuVuAo4QzGfyb/C0k1gFGmLKYEF9OeGLxOE53VGASa7h7YUHdG+wfocZaCEjlj2aZUVsAOBI0jdK41nVRxv8G0/3pZtn47QZ8vw9eELb0wUQiK7sPEu6vSA9s5hB4KndLmkzCINcKuOSP69x1OCcWhN1AFOHbU59MLxLq/3q/a89PZGnZy3KJnteQAlCwtDTkP+KHCa9tNWSG6RJ8tSoRKk9rXB0JZjy8ynDVZWcYJ8tJDVr8Ct0C0L7bCUgplZ7PdQ46XW3heE8dIjmeEIZFDvqs/dEsU9Y+4GQXXT9ro9GrgZcl8Rf8kWh/CJqgMOqmLaR/1dUngphZM364usCQNPlD9IIzFEv/RpImmWl/l7ujt7sVDAx20ckZ+ZrzNvY9JaA2zbw56/4wSjxeaviol3gzZ+pdBwlMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(8676002)(5660300002)(316002)(122000001)(2906002)(83380400001)(38100700002)(33656002)(54906003)(66946007)(7696005)(86362001)(478600001)(76116006)(110136005)(4326008)(52536014)(55016002)(9686003)(71200400001)(66556008)(66446008)(64756008)(66476007)(53546011)(186003)(6506007)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1t26geX6Srb6VwNDhNabjuHHYO2ms1zkyzPhjPOaie5Qfw6msJSxk2IQiMN9?=
 =?us-ascii?Q?cDSVBrWrj3fcr5MEOAcg7qQydVkfYKNEQdQjjaDTTM70f1qL8TxYWsSiMhze?=
 =?us-ascii?Q?xNvNKlLmzaoT56s16fcEzWqeHlTi5s4fYh9MuvbIrH2BokSf5tBsi/bko908?=
 =?us-ascii?Q?7+eHtE2vZ8vhOQYp1G0v7KkwALC92gzQ2t2xykDIMXOjvxVbV7iEKiHsqXKf?=
 =?us-ascii?Q?GIdjq2Cj+U25mC0q+AE6PHySzso/kyhEwqG543HptsfEeen2Ey2B9jnmhscg?=
 =?us-ascii?Q?QiBRXfquGoYxStT4lpFMZx0Y42ZF6AxjF0ej69jpdr0H21bELceb4+zrgYvJ?=
 =?us-ascii?Q?IrmSTJ3g+8DhSY8iTHRgx9TeRyYyAycARhR/B9qiIaC9H+LePqm/qrkoASQh?=
 =?us-ascii?Q?hJjZOjFlP0mH2An3g8EzXOwMFm5K0ETlv/6XQm34KLCvW3j6RNGVOu04+Id7?=
 =?us-ascii?Q?JPOk5Qqka2J0lHx3RLCIo5fV+pmsDYSBYRp0QI5AtgW9dhsL8Ak2v332OxTB?=
 =?us-ascii?Q?rvrojjCIdLwF/zbl0ilVMETfAQndr1+ketRxcWhZ9fwBr8X3ARzgQ+cop+Yb?=
 =?us-ascii?Q?537PGOHdM6ZfVkceX844h8zWPpRWwC3YJPjdtaxnF5OHTlsOJv67CiYsZpXx?=
 =?us-ascii?Q?mo80WV52r/oHdcKlpgJV6qyEMGJVqsgw2a1F49qD/xF+EBBdebaQtakiGomH?=
 =?us-ascii?Q?ic2aKN+W3hfCZFzSMm1TYU4m5XR58iYr11Uslad2bYJOdXVpDPKMPImLUmBN?=
 =?us-ascii?Q?eawJbqV4H4A9JN8OnbUi/7Fx3yTdOAC/hotUzUPpDmyOC/NcDGElv1KvdJg5?=
 =?us-ascii?Q?gR+FR1/dnHQUe1BVf611ezDbIHsUSVL4sEiLUfpS7ktcverZ+QTuDO+No6j7?=
 =?us-ascii?Q?Hu4KF+nCY42vn2USb5DioBM5zcS1bvltOpbHXNsBjWO2OK6Ygzqh121EKfjq?=
 =?us-ascii?Q?cwftHF/6pGs4PFWEVrn/mbdnynlLb6uCeDeGE5y/yTh3V/TrUDvyxPL5xIj+?=
 =?us-ascii?Q?fL9Ih7EJ13GmIqYUZUnwIUFSfbcwm4m+jiU0Y4VTOj74UUKSXhwgpTdGnFY/?=
 =?us-ascii?Q?Aw/6HZVxyVaWIiqQHrxuQN/J7ycdz0MJ97iTGoqo8PInzENKu68HP3mBjxKj?=
 =?us-ascii?Q?ZSlLXfWf8sMT1G9tfln6FI92gxQb6URQQUF8xRRaULLWKjYVYHooDreLUc5U?=
 =?us-ascii?Q?a2zj6a81XJPlqzUu58I6jTcgEAs0Dw+zPEDbq21OQL/qmPNo1kEqXpvo2oad?=
 =?us-ascii?Q?av3jYtPD1QnsfnDjKEbfV2wRYCSvJPez3OvKpWNCE9a9dt+3eU9j4ITQxtL/?=
 =?us-ascii?Q?DvvBc1+ooFZj7LE53aAs0wTFKqL95jA76p35D/YtGkyo3+tW/WDsGXq9RFC6?=
 =?us-ascii?Q?qtTgxQcznz3qVH6Sg2EeSBJNA6Wc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546f8fad-59e9-4609-2fb1-08d95c657634
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 01:15:09.2680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qF/y+bom41yyoJQJLOtWggNsZK2NiKkWB6PAwzurrXzLJ+2Fym0hnBV30PKbusUodzvBgHQMzKkumqDP+RF7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0138
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

[AMD Official Use Only]

Just few comments inline. With that acknowledged Reviewed-by: Harish Kasivi=
swanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Monday, August 9, 2021 4:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Cornwall, Jay <Jay.Cornwall@a=
md.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdkfd: CWSR with software scheduler

This patch adds support to program trap handler settings
when loading driver with software scheduler (sched_policy=3D2).

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Suggested-by: Jay Cornwall <Jay.Cornwall@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 31 +++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  | 31 +++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 33 ++++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 20 +++++++++--
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 ++
 5 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 491acdf92f73..960acf68150a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -560,6 +560,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *m=
qd,
 	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
 		type =3D RESET_WAVES;
 		break;
+	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+		type =3D SAVE_WAVES;
+		break;
 	default:
 		type =3D DRAIN_PIPE;
 		break;
@@ -754,6 +757,33 @@ static void set_vm_context_page_table_base(struct kgd_=
dev *kgd, uint32_t vmid,
 	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
 }
=20
+static void program_trap_handler_settings(struct kgd_dev *kgd,
+		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
+{
+	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
+
+	lock_srbm(kgd, 0, 0, 0, vmid);
+
+	/*
+	 * Program TBA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
+			lower_32_bits(tba_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
+			upper_32_bits(tba_addr >> 8) |
+			(1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+
+	/*
+	 * Program TMA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
+			lower_32_bits(tma_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
+			upper_32_bits(tma_addr >> 8));
+
+	unlock_srbm(kgd);
+}
+
 const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
 	.program_sh_mem_settings =3D kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping =3D kgd_set_pasid_vmid_mapping,
@@ -774,4 +804,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
 	.get_atc_vmid_pasid_mapping_info =3D
 			get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base =3D set_vm_context_page_table_base,
+	.program_trap_handler_settings =3D program_trap_handler_settings,

[HK]: Naming  not consistent. program_trap_handler_settings, program_trap_h=
andler_settings_v10_3 and kgd_gfx_v9_program_trap_handler_settings

 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 1f5620cc3570..dac0d751d5af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -537,6 +537,9 @@ static int hqd_destroy_v10_3(struct kgd_dev *kgd, void =
*mqd,
 	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
 		type =3D RESET_WAVES;
 		break;
+	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+		type =3D SAVE_WAVES;
+		break;
 	default:
 		type =3D DRAIN_PIPE;
 		break;
@@ -658,6 +661,33 @@ static void set_vm_context_page_table_base_v10_3(struc=
t kgd_dev *kgd, uint32_t v
 	adev->gfxhub.funcs->setup_vm_pt_regs(adev, vmid, page_table_base);
 }
=20
+static void program_trap_handler_settings_v10_3(struct kgd_dev *kgd,
+			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr)
+{
+	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
+
+	lock_srbm(kgd, 0, 0, 0, vmid);
+
+	/*
+	 * Program TBA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
+			lower_32_bits(tba_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
+			upper_32_bits(tba_addr >> 8) |
+			(1 << SQ_SHADER_TBA_HI__TRAP_EN__SHIFT));
+
+	/*
+	 * Program TMA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
+			lower_32_bits(tma_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
+			 upper_32_bits(tma_addr >> 8));
+
+	unlock_srbm(kgd);
+}
+
 #if 0
 uint32_t enable_debug_trap_v10_3(struct kgd_dev *kgd,
 				uint32_t trap_debug_wave_launch_mode,
@@ -820,6 +850,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd =3D {
 	.address_watch_get_offset =3D address_watch_get_offset_v10_3,
 	.get_atc_vmid_pasid_mapping_info =3D NULL,
 	.set_vm_context_page_table_base =3D set_vm_context_page_table_base_v10_3,
+	.program_trap_handler_settings =3D program_trap_handler_settings_v10_3,
 #if 0
 	.enable_debug_trap =3D enable_debug_trap_v10_3,
 	.disable_debug_trap =3D disable_debug_trap_v10_3,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index ed3014fbb563..154244916727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -42,7 +42,8 @@
 enum hqd_dequeue_request_type {
 	NO_ACTION =3D 0,
 	DRAIN_PIPE,
-	RESET_WAVES
+	RESET_WAVES,
+	SAVE_WAVES
 };
=20
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
@@ -566,6 +567,9 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *m=
qd,
 	case KFD_PREEMPT_TYPE_WAVEFRONT_RESET:
 		type =3D RESET_WAVES;
 		break;
+	case KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+		type =3D SAVE_WAVES;
+		break;
 	default:
 		type =3D DRAIN_PIPE;
 		break;
@@ -878,6 +882,32 @@ void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, =
int pasid,
 				adev->gfx.cu_info.max_waves_per_simd;
 }
=20
+static void kgd_gfx_v9_program_trap_handler_settings(struct kgd_dev *kgd,
+                        uint32_t vmid, uint64_t tba_addr, uint64_t tma_add=
r)
+{
+	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
+
+	lock_srbm(kgd, 0, 0, 0, vmid);
+
+	/*
+	 * Program TBA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_LO),
+                        lower_32_bits(tba_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TBA_HI),
+                        upper_32_bits(tba_addr >> 8));
+
+	/*
+	 * Program TMA registers
+	 */
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_LO),
+			lower_32_bits(tma_addr >> 8));
+	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_SHADER_TMA_HI),
+			upper_32_bits(tma_addr >> 8));
+
+	unlock_srbm(kgd);
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
 	.program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -899,4 +929,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base =3D kgd_gfx_v9_set_vm_context_page_table_=
base,
 	.get_cu_occupancy =3D kgd_gfx_v9_get_cu_occupancy,
+	.program_trap_handler_settings =3D kgd_gfx_v9_program_trap_handler_settin=
gs,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a972ef5eae68..6fd6b2248992 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -211,6 +211,14 @@ static void deallocate_doorbell(struct qcm_process_dev=
ice *qpd,
 	WARN_ON(!old);
 }
=20
+static void program_trap_handler_settings(struct device_queue_manager *dqm=
,
+				struct qcm_process_device *qpd)
+{
+	return dqm->dev->kfd2kgd->program_trap_handler_settings(
+						dqm->dev->kgd, qpd->vmid,
+						qpd->tba_addr, qpd->tma_addr);

[HK]: Since, this is not defined for all GFX generations, safer to check if=
 function pointer is not NULL. I see it is called only VEGA10+

+}
+
 static int allocate_vmid(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd,
 			struct queue *q)
@@ -241,6 +249,10 @@ static int allocate_vmid(struct device_queue_manager *=
dqm,
=20
 	program_sh_mem_settings(dqm, qpd);
=20
+	if (dqm->dev->device_info->asic_family >=3D CHIP_VEGA10 &&
+	    dqm->dev->cwsr_enabled)
+		program_trap_handler_settings(dqm, qpd);
+
 	/* qpd->page_table_base is set earlier when register_process()
 	 * is called, i.e. when the first queue is created.
 	 */
@@ -582,7 +594,9 @@ static int update_queue(struct device_queue_manager *dq=
m, struct queue *q)
 		}
=20
 		retval =3D mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
-				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
+				(dqm->dev->cwsr_enabled?
+				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
 				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
 		if (retval) {
 			pr_err("destroy mqd failed\n");
@@ -675,7 +689,9 @@ static int evict_process_queues_nocpsch(struct device_q=
ueue_manager *dqm,
 			continue;
=20
 		retval =3D mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
-				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN,
+				(dqm->dev->cwsr_enabled?
+				 KFD_PREEMPT_TYPE_WAVEFRONT_SAVE:
+				KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN),
 				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
 		if (retval && !ret)
 			/* Return the first error, but keep going to
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h
index 95c656d205ed..c84bd7b2cf59 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -44,6 +44,7 @@ struct kgd_mem;
 enum kfd_preempt_type {
 	KFD_PREEMPT_TYPE_WAVEFRONT_DRAIN =3D 0,
 	KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
+	KFD_PREEMPT_TYPE_WAVEFRONT_SAVE
 };
=20
 struct kfd_vm_fault_info {
@@ -298,6 +299,8 @@ struct kfd2kgd_calls {
=20
 	void (*get_cu_occupancy)(struct kgd_dev *kgd, int pasid, int *wave_cnt,
 			int *max_waves_per_cu);
+	void (*program_trap_handler_settings)(struct kgd_dev *kgd,
+			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
 };
=20
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
--=20
2.17.1
