Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4049DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 14:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EAD10E309;
	Mon, 17 Jan 2022 14:50:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC8F10E309
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 14:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyKF3tBZTLKfFJ1vUWplsGgBSTGRp0fBcfND33ZMN2JQS60llBzdwAvs2VjS+M9gBlEBEkm88KMEoAQar5XviU/6oIoYuSQ7cPYRLDp1CFYEorfQsLTLON1Q8zAfX4rbp+sx9yxGrM1s8akvtz2wcySes3dCINqjXbvmUiSibQPBtYPDAn0p7o9AGQwxvW8RSibwimYaRYbfaeLcgMyfJmfity36h5CRzaYk1Dm3wHAgCWiR2RoJjdeJBPcQtcX6Nh0V5HZlOty9G8ivCWehitZieZOlsnjQqFyKhvbhQo69wRoNIxd7663U7d+K9m7yU3fNrQoHo7zUc/QNLj2+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpgwHeRA1sJ/kIVP1KtQClGkMj6JA7SCcU+jUfgM8PM=;
 b=MuGVue0DSqX69dXGrbBQUqzZthBtrZsTGHz0+Xx6fJQYHXK0X/3i2stHePbTWp9Frtzpzm4yMihj+OWRi2tetKtNHmJkA9zW4oxhFaK/yfQOXMrVTRTZLkQho5ICsaSxGpH6mysOUOCK5G3ohe+RjHva8FoHAJe5HmvRc/cStknd3ArkKS/C31y88uh/T7rIjBs+89TN9cDw/Q0YHIjBYdje/PHsKZ1Pd/tcl0R+fjFUPJuatWraLLbhPsWv4/dJgXzHTdSLzlAUme+MIPCjfU/yEMIowveemzvApIrYCxqF6YDhDU9QfHBPi61MjWvoWokqYzaQ5AISkmRBIEEyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpgwHeRA1sJ/kIVP1KtQClGkMj6JA7SCcU+jUfgM8PM=;
 b=WtMBpZ5blTjDinhnzTamDtFcSnx9lIjNn0PY5KDfkF411nRlvVCmHBUIFDWoN7fHZw474uCKs3csVmLqIU0Q68w9fob1t155vE+83f99FPznwwT2OSH+7TvhUJh7a2cX4RaK25xLVOlkV5D3sE1IbiJJAe4sYTt6UvLovgW/2pE=
Received: from DM5PR12MB1531.namprd12.prod.outlook.com (2603:10b6:4:f::8) by
 DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Mon, 17 Jan 2022 14:50:48 +0000
Received: from DM5PR12MB1531.namprd12.prod.outlook.com
 ([fe80::3039:1226:afd7:8ca]) by DM5PR12MB1531.namprd12.prod.outlook.com
 ([fe80::3039:1226:afd7:8ca%8]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 14:50:48 +0000
From: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Phillips, Daniel"
 <Daniel.Phillips@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] Add available memory ioctl for libhsakmt
Thread-Topic: [PATCH 1/1] Add available memory ioctl for libhsakmt
Thread-Index: AQHYBmRmrjBkbt+UiEyP37kgNrgx0KxcwEWAgAqVFoA=
Date: Mon, 17 Jan 2022 14:50:47 +0000
Message-ID: <DM5PR12MB1531361295346BED5D6B4486FE579@DM5PR12MB1531.namprd12.prod.outlook.com>
References: <20220110205457.3165572-1-daniel.phillips@amd.com>
 <BL1PR12MB51449917D93BE664ECF3E5B5F7509@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51449917D93BE664ECF3E5B5F7509@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-17T14:50:44Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-17T14:50:44Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ecadc547-f717-42d5-ba8c-f48697815101
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7b94fd3-7eef-4e03-8aa6-08d9d9c8bf96
x-ms-traffictypediagnostic: DM6PR12MB3194:EE_
x-microsoft-antispam-prvs: <DM6PR12MB31946ED25684E76BEAE3BE4BFE579@DM6PR12MB3194.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdS4O1Gg8VaGTwf9+gc8IHTQVqfIGoQ1ItQVdGijXwh6s0mJR3CSzs06PGCIO8knyOC4g5PGnuCsJWeAla3HNwheBXjBLzTSOt1p3NziKS94P8gp2F431QE9LOg6yij0Sb1lTv1UcMmvLx2MtQrS6ry8vhphjm0cWCxnxgHzwP8ST0NJtETSz6wHqI119W1PbtcwzAecwIzkQf9kLhYejyw14GtT0Jq/MdJekSri30JpXKppUO+98rR8O4NaUeSgorNqypwCDL6JQ0rvril5u4PTi8gf0hLL5hQkp63kPDvIXaPffO4C8VXBIkNcll7S5E+WXok+RjR8vsipIuKEIGazYor3VwHT3rfflZORX9QzoQIujmTOx/qkpzCnzpzl8qThN7oHrOm1/+xH2v4yVrXbV2kN8s3nHajbeah4Ywpp46gKxB8ayKvHguTF9AbwR5PNO6MzdU2c/EUTLkd5KSzJZZMPwJVhMEm+Nof5JPdjIDNUx5lft7DNb2Liq4rc7cX6ELZkzZxUS1wMIoSBg2y/ZVWi9C5ntams+LJfQArBoFy4VyNKG9IaHDH87Mfx1C61++++Z9RM/e440XWR5oB6iLX55uOST7Mhsi7sDyC9ZkWFOYI7px1hiN9IVCbGOAHz3oGnBmgoJGr3J8uVWNAm49IJeVeWiVfgqEz1jExHVVgfmthqIPhK5XdGR4rIfw+VcHYVV6fnWEG98BdGn4aUCzv1IqIdAs9a2LdCpVDXLevR4to06hbTodbsQPnj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(64756008)(86362001)(2906002)(38070700005)(55016003)(8676002)(7696005)(4326008)(38100700002)(9686003)(110136005)(26005)(8936002)(33656002)(122000001)(316002)(508600001)(5660300002)(52536014)(83380400001)(66446008)(76116006)(53546011)(71200400001)(66556008)(6506007)(66946007)(66476007)(131093003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wf/BUFX/PNlz6ork9muVw6YZTK6Faqrtb55y1giksw/YZhhHSo74L47dsy5T?=
 =?us-ascii?Q?8FrRNeeMBcY2ALWLeaiV4UCxWLowQbUk9SXz+vVX0AzMZAJu6PCWlLIvh9Mx?=
 =?us-ascii?Q?WMGw3Js69gaEZXgOgiMDIZjmMbsphWWFLI7uUwS+qUVfPrj6BKNYBa3qbudt?=
 =?us-ascii?Q?GHPpZuEWbep9017bUiOrtBD0FhOMaUk2ci1Fm5SZa0sKU60KfRMoaYOWudWQ?=
 =?us-ascii?Q?LLIIevZyiZR3LdXpjlHlWoQ/Dta59MGr4K4eyju4/I+K8Z5ouptFX5cpQbrY?=
 =?us-ascii?Q?ZeKEn+UNJ6BtpuPHZPoJwxjV2me2opA67fy2FKsQIwXqXsIdK2SrUoBgGuxE?=
 =?us-ascii?Q?sDy5609sFeAyvyqHPMR5AOUfwd5p0I7SGC+NWqan1BEQQ0xqZqn13FJHtueA?=
 =?us-ascii?Q?6r0zI+1/NfdJDAYi9FGxhYppe5Ld216zGsjOYxPDTJ3hq2GauhRuTRhvgAgi?=
 =?us-ascii?Q?Bf8lnNjDQMXlK5BaAcJEJuhkpA8LWhcNu4BhWGaUBi2VUdgJ3ElkHT3xs0Um?=
 =?us-ascii?Q?gJG7oRz5AXCAJbKtfL02vE5CTZfhefnxKkJLgYyOZ26ND+Vkq+KiY9wYKTMT?=
 =?us-ascii?Q?nxvi/w08oVZhKe59o/S8cYQRnKHqn5q6oepfpg4Vpv+zMXMU0lqFViU/ECvW?=
 =?us-ascii?Q?jo7i/X+K9UTSHNo/bIwMBQkf8RfM8v6kBvjA210hw9EGHKG9FLaFoA4lOCpD?=
 =?us-ascii?Q?lmYatAP8AxwtyuUzEn9rMxPCQdFoPRXb3eFwET1aT/yDj+emReoS3WNe7Y7Q?=
 =?us-ascii?Q?Ue+tzHEayPZTADfeDTB8oBvzlWZlcbktFbjeLJT56eHQ17+nPxwm/bebAr+k?=
 =?us-ascii?Q?Af4ROsmajBdt28WLK32lhHk8WxLNNQUadFX4CpBoS/J8oeHQ/2UsJyxsaicj?=
 =?us-ascii?Q?f1FcaMOh22V4NIqUBtbXGLm9/ogpCLKklyJAjtUlauTsozCDXkNloXu5T26A?=
 =?us-ascii?Q?nxy+2JljaVo3OQBOZVxPS/a4LIYxPa1YANbcSKSib6UKBiRPoJLAOLUDE0OQ?=
 =?us-ascii?Q?75zocI16PcfGc2X5M+aXI0g+ocXc9EoKXqe82JoNBZZUB7bbPOj26UbmsVpz?=
 =?us-ascii?Q?WHF8NA3mGq8dOziyubmVIlAjy7PpXoz1xCdqUOC1zfiwCXQ4PUH0pBp8/MrD?=
 =?us-ascii?Q?qVWHMRM74Dabb/E//3qOv6/JNzfEIw/Yxef7JSBaIBwHjS5Xc5wIPV02quyu?=
 =?us-ascii?Q?DwyOffQO4fVSpzUE0d6GQS/lK1iS5Fqs7Z2rEFqrwlAo1i8DUqj8SvuSI4r+?=
 =?us-ascii?Q?4Od4cKa/wmkJq0BQbB0MPdu+1Wz0mH+d57mNCWgnAaNrBFizAWfx8XAA5+jj?=
 =?us-ascii?Q?X6xRF6KG5PfmvHzpkloSEl1jVovVbv49VG7RrmxPvoxNEmPyIWlWreZkhQ68?=
 =?us-ascii?Q?F8r0r78H49cJLwASZab6NUI1kheTcycD4Qf1iHqQbGlleYFMWH/dd4daCrmK?=
 =?us-ascii?Q?gljOLBMSBWElwgmUmHizqYpLGBvEszHmhU3yVhfjzZG7rO4GByhZPykPXRE+?=
 =?us-ascii?Q?m3JWadVdZm9p2oMSOPZ8ULjf0Oflzopt0Ta8aBJ0rEYb4bfh0zwyflkhEwa6?=
 =?us-ascii?Q?XHdE27BMUIjvTMzabup8ZtySlr2APJgoC3t7HSZgp1a5ntLzrn1acWDINF6k?=
 =?us-ascii?Q?B5LH0zHnri7r40DLgpJxl2w=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB1531361295346BED5D6B4486FE579DM5PR12MB1531namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b94fd3-7eef-4e03-8aa6-08d9d9c8bf96
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 14:50:47.8605 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYlBWcqIstl0g+wy9AcdCUfQ2xVtycqr4Or+zGbmzFcNHTxJYrOyLypgwb61XDMg8wBNpHG9vLkFnJvreSpiNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3194
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB1531361295346BED5D6B4486FE579DM5PR12MB1531namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Monday, January 10, 2022 4:11 PM
To: Phillips, Daniel <Daniel.Phillips@amd.com>; amd-gfx@lists.freedesktop.o=
rg; dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/1] Add available memory ioctl for libhsakmt


[Public]


[Public]

This is missing your signed-off-by.  Additionally, for UAPI changes, we nee=
d a link the patches for the userspace component that will make use of it.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Daniel Phillips <daniel.phillips@amd.=
com<mailto:daniel.phillips@amd.com>>
Sent: Monday, January 10, 2022 3:54 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; dri-dev=
el@lists.freedesktop.org<mailto:dri-devel@lists.freedesktop.org> <dri-devel=
@lists.freedesktop.org<mailto:dri-devel@lists.freedesktop.org>>
Cc: Phillips, Daniel <Daniel.Phillips@amd.com<mailto:Daniel.Phillips@amd.co=
m>>
Subject: [PATCH 1/1] Add available memory ioctl for libhsakmt

From: Daniel Phillips <dphillip@amd.com<mailto:dphillip@amd.com>>

Add an ioctl to inquire memory available for allocation by libhsakmt
per node, allowing for space consumed by page translation tables.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 17 +++++++++++++++++
 include/uapi/linux/kfd_ioctl.h                  | 14 ++++++++++++--
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index fcbc8a9c9e06..64c6c36685d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -266,6 +266,7 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgp=
u_device *adev,
 void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
                                         void *drm_priv);
 uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);
+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev);
 int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
                 struct amdgpu_device *adev, uint64_t va, uint64_t size,
                 void *drm_priv, struct kgd_mem **mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 86a1a6c109d9..b7490a659173 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -190,6 +190,20 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdg=
pu_device *adev,
         return ret;
 }

+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
+{
+       uint64_t reserved_for_pt =3D
+               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
+       size_t available_memory;
+
+       spin_lock(&kfd_mem_limit.mem_limit_lock);
+       available_memory =3D
+               adev->gmc.real_vram_size -
+               adev->kfd.vram_used - reserved_for_pt;
+       spin_unlock(&kfd_mem_limit.mem_limit_lock);
+       return available_memory;
+}
+
 static void unreserve_mem_limit(struct amdgpu_device *adev,
                 uint64_t size, u32 alloc_flag)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 4bfc0c8ab764..5c2f6d97ff1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -486,6 +486,20 @@ static int kfd_ioctl_get_queue_wave_state(struct file =
*filep,
         return r;
 }

+static int kfd_ioctl_get_available_memory(struct file *filep,
+                                struct kfd_process *p, void *data)
+{
+       struct kfd_ioctl_get_available_memory_args *args =3D data;
+       struct kfd_dev *dev;
+
+       dev =3D kfd_device_by_id(args->gpu_id);
Once CRIU changes land, this need to change to kfd_process_device_data_by_i=
d() and then use pdd->dev


+       if (!dev)
+               return -EINVAL;
+
+       args->available =3D amdgpu_amdkfd_get_available_memory(dev->adev);
+       return 0;
+}
+
 static int kfd_ioctl_set_memory_policy(struct file *filep,
                                         struct kfd_process *p, void *data)
 {
@@ -1959,6 +1973,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[]=
 =3D {

         AMDKFD_IOCTL_DEF(AMDKFD_IOC_SET_XNACK_MODE,
                         kfd_ioctl_set_xnack_mode, 0),
+
+       AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE_MEMORY,
+                       kfd_ioctl_get_available_memory, 0),
 };

 #define AMDKFD_CORE_IOCTL_COUNT ARRAY_SIZE(amdkfd_ioctls)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h
index af96af174dc4..94a99add2432 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -32,9 +32,10 @@
  * - 1.4 - Indicate new SRAM EDC bit in device properties
  * - 1.5 - Add SVM API
  * - 1.6 - Query clear flags in SVM get_attr API
+ * - 1.7 - Add available_memory ioctl
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 6
+#define KFD_IOCTL_MINOR_VERSION 7

 struct kfd_ioctl_get_version_args {
         __u32 major_version;    /* from KFD */
@@ -98,6 +99,12 @@ struct kfd_ioctl_get_queue_wave_state_args {
         __u32 pad;
 };

+struct kfd_ioctl_get_available_memory_args {
+       __u64 available;        /* from KFD */
+       __u32 gpu_id;           /* to KFD */
+       __u32 pad;
+};
+
 /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_polic=
y */
 #define KFD_IOC_CACHE_POLICY_COHERENT 0
 #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
@@ -742,7 +749,10 @@ struct kfd_ioctl_set_xnack_mode_args {
 #define AMDKFD_IOC_SET_XNACK_MODE               \
                 AMDKFD_IOWR(0x21, struct kfd_ioctl_set_xnack_mode_args)

+#define AMDKFD_IOC_AVAILABLE_MEMORY            \
+               AMDKFD_IOR(0x22, struct kfd_ioctl_get_available_memory_args=
)
+
 #define AMDKFD_COMMAND_START            0x01
-#define AMDKFD_COMMAND_END             0x22
+#define AMDKFD_COMMAND_END             0x23

 #endif
--
2.34.1

--_000_DM5PR12MB1531361295346BED5D6B4486FE579DM5PR12MB1531namp_
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
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Monday, January 10, 2022 4:11 PM<br>
<b>To:</b> Phillips, Daniel &lt;Daniel.Phillips@amd.com&gt;; amd-gfx@lists.=
freedesktop.org; dri-devel@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 1/1] Add available memory ioctl for libhsakmt<o:=
p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">This is=
 missing your signed-off-by.&nbsp; Additionally, for UAPI changes, we need =
a link the patches for the userspace component that will make use of it.<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Daniel Phillips &lt;<a href=3D"mailto:daniel.phillips@amd.com">daniel.phi=
llips@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, January 10, 2022 3:54 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;;
<a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-devel@lists.freedesk=
top.org</a> &lt;<a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-deve=
l@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Phillips, Daniel &lt;<a href=3D"mailto:Daniel.Phillips@amd.com">=
Daniel.Phillips@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH 1/1] Add available memory ioctl for libhsakmt</span>=
 <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">From: Daniel Phillips=
 &lt;<a href=3D"mailto:dphillip@amd.com">dphillip@amd.com</a>&gt;<br>
<br>
Add an ioctl to inquire memory available for allocation by libhsakmt<br>
per node, allowing for space consumed by page translation tables.<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp; 1 +<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp;&nbsp;&nbsp; | 14 +=
+++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; | 17 +++++++++++++++++<br>
&nbsp;include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 14 ++++++=
++++++--<br>
&nbsp;4 files changed, 44 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index fcbc8a9c9e06..64c6c36685d3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -266,6 +266,7 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgp=
u_device *adev,<br>
&nbsp;void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; void *drm_priv);<br>
&nbsp;uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv);<br=
>
+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev, uint64_t va, uint64_t siz=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; void *drm_priv, struct kgd_mem **mem,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index 86a1a6c109d9..b7490a659173 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -190,6 +190,20 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t reserved_for_pt =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t available_memory;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;kfd_mem_limit.mem_limi=
t_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; available_memory =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gmc.real_vram_size -<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;kfd.vram_used - reserved_for_pt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;kfd_mem_limit.mem_li=
mit_lock);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return available_memory;<br>
+}<br>
+<br>
&nbsp;static void unreserve_mem_limit(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 4bfc0c8ab764..5c2f6d97ff1c 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -486,6 +486,20 @@ static int kfd_ioctl_get_queue_wave_state(struct file =
*filep,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
+static int kfd_ioctl_get_available_memory(struct file *filep,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p, void *data)<br=
>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_get_available_memory=
_args *args =3D data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D kfd_device_by_id(args-&gt;gpu=
_id);<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Once CRIU changes lan=
d, this need to change to kfd_process_device_data_by_id() and then use pdd-=
&gt;dev<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;available =3D amdgpu_amdkfd_=
get_available_memory(dev-&gt;adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int kfd_ioctl_set_memory_policy(struct file *filep,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct kfd_process *p, void *data)<br>
&nbsp;{<br>
@@ -1959,6 +1973,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[]=
 =3D {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKFD_IO=
C_SET_XNACK_MODE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_i=
octl_set_xnack_mode, 0),<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE=
_MEMORY,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_ioctl_get_av=
ailable_memory, 0),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#define AMDKFD_CORE_IOCTL_COUNT ARRAY_SIZE(amdkfd_ioctls)<br>
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h<br>
index af96af174dc4..94a99add2432 100644<br>
--- a/include/uapi/linux/kfd_ioctl.h<br>
+++ b/include/uapi/linux/kfd_ioctl.h<br>
@@ -32,9 +32,10 @@<br>
&nbsp; * - 1.4 - Indicate new SRAM EDC bit in device properties<br>
&nbsp; * - 1.5 - Add SVM API<br>
&nbsp; * - 1.6 - Query clear flags in SVM get_attr API<br>
+ * - 1.7 - Add available_memory ioctl<br>
&nbsp; */<br>
&nbsp;#define KFD_IOCTL_MAJOR_VERSION 1<br>
-#define KFD_IOCTL_MINOR_VERSION 6<br>
+#define KFD_IOCTL_MINOR_VERSION 7<br>
&nbsp;<br>
&nbsp;struct kfd_ioctl_get_version_args {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 major_version;&nbsp;=
&nbsp;&nbsp; /* from KFD */<br>
@@ -98,6 +99,12 @@ struct kfd_ioctl_get_queue_wave_state_args {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 pad;<br>
&nbsp;};<br>
&nbsp;<br>
+struct kfd_ioctl_get_available_memory_args {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 available;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* from KFD */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 gpu_id;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 pad;<br>
+};<br>
+<br>
&nbsp;/* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_=
policy */<br>
&nbsp;#define KFD_IOC_CACHE_POLICY_COHERENT 0<br>
&nbsp;#define KFD_IOC_CACHE_POLICY_NONCOHERENT 1<br>
@@ -742,7 +749,10 @@ struct kfd_ioctl_set_xnack_mode_args {<br>
&nbsp;#define AMDKFD_IOC_SET_XNACK_MODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x21, struct kfd_ioctl_set_xnack_mode_arg=
s)<br>
&nbsp;<br>
+#define AMDKFD_IOC_AVAILABLE_MEMORY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AMDKFD_IOR(0x22, struct kfd_ioctl_get_available_memory_args)<br>
+<br>
&nbsp;#define AMDKFD_COMMAND_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x01<br>
-#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x22<br>
+#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x23<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.34.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1531361295346BED5D6B4486FE579DM5PR12MB1531namp_--
