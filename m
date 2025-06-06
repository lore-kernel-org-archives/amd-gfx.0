Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77879C61CE7
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 21:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DC010EB26;
	Fri,  6 Jun 2025 21:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xjmMbCQ4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F7C10EB26
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 21:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrRbBo1iU8bg254L3Fs88hXo0+nzxBQ1CUYrbYGClmQOeNBNiRcH07FGMJhhAhlXgrgqEBz7zFelXcrHDTTX4t34DzZyPKkfnH1+zflXRWI/mWx/dlYPz/Aq5C4wzpCTYGw3FsT0I9rrZf4qWJvtnUKkBE8YamFeH8xmSa2YF/7hJd/lFc54sKofzSFHCYr7e8d+BdJ67WoCQv4Ea3CRc2ztiRU3gDX9vmq+l3se/xbkyuMTMeKyoc5Tczq3c8dI7lIbrFE2ruj0ZnN8Xa7hHxDG3ITxnhjSGyj/q5C6oVF4PhaAAtZeffYzQTNjw0rcy06FpXVj5dAdzyMiitss+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dkojCPVXLw9c8MzezzXFYfe6yoAYv5qP06hKifj1u0=;
 b=Ib/10ue6m1Y+1eXr3erjZDPsuGzI3Vf9AmfQaN8lk1gm3BMHksjO6AGn/SN2Q4GgY0Ru0DXvdWXNwo+jlD+ZbfcI7IvI/cnRugY4wvM9T45qBTup2EL4KeMkihjbGmRh/E6PnI+QNuraZ+2XK+wA0w/jjsP47tPJwgnUXklyWd687i6KvuvYgduKlEBewKtcBgv149OGb5y8h4QnLfOCdJuqwp3cDRMpQ8zw+1ff/8YG7EYSzq6+RUnsofSq6CWHw8h8frY75a4wvt4YlxARSFtqFFPUxEUBD7cdPuqenDtgUj2n1OTABRLwRJpsVVo2Fz5/OKgNUeb2xqOmPrMMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dkojCPVXLw9c8MzezzXFYfe6yoAYv5qP06hKifj1u0=;
 b=xjmMbCQ4qVmtuySOkf4ROLwm1Z5vnYeH7or5yu1/k/nVsgDUG1SZRc225ABmy2+pTVM3c2SpzeZvr6TyinA0yWBDcFUOD7UpwrTq3iXgZTmgPrtgY8CQK7P44kAYhBGMuz8pVwdq8de8W1QEF+hEu/TsvT4JkxJQE4COzMrqGA0=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 21:55:09 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%5]) with mapi id 15.20.8722.031; Fri, 6 Jun 2025
 21:55:09 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: allow compute partition mode switch with
 cgroup exclusions
Thread-Topic: [PATCH] drm/amdkfd: allow compute partition mode switch with
 cgroup exclusions
Thread-Index: AQHb0M1CvXxTMa5BZEClrcqWIunwObP2uCpw
Date: Fri, 6 Jun 2025 21:55:09 +0000
Message-ID: <CY8PR12MB7099C620221639EF31947D358C6EA@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250529190945.4052-1-jonathan.kim@amd.com>
In-Reply-To: <20250529190945.4052-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a4530b9d-aa61-4f2d-8984-ec04cb6e4224;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-06T21:49:40Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DS7PR12MB6261:EE_
x-ms-office365-filtering-correlation-id: 68985633-65ef-4490-f42f-08dda544ce3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8zNFq0WTWsS67p6cCEaDzTKBo4v/MxQrwSZc5lTu8S2SWgotAf4sbMeYd1HH?=
 =?us-ascii?Q?Lrd1HxYp3eIgpoRnV7qrWTpURpuaDF/kMaHdtz1GzhfF53NRNsmMXNZHKvAR?=
 =?us-ascii?Q?4u0iS/ACV43tipIEf7UFTmdoLcO5AzfT36tdu/lWgz2ae8dzxhVKpB/kjAcx?=
 =?us-ascii?Q?xiSSxDm+A37vM/Fdjx2AZUGyu+E430yVAj1vcTHguHinr8UQl1uVzv+CT/1q?=
 =?us-ascii?Q?g51HRCC1ImGvoXagkYBdf9TgekHg8yLSnzdoaYutziNCyn6ZrlNpWrrUqGGD?=
 =?us-ascii?Q?bZ0tAZm+8hJ6PH5TJzf2c3Mg2nwoCj+XEcHw5+kxQbZzSF026FYL4i6zOhqO?=
 =?us-ascii?Q?mfEwzxIqPaf1pPDT/y6uGhOY4hKSNkTbOAbxw+yrQcmO5V9aaL+uyRM1C/Dj?=
 =?us-ascii?Q?kJd2X16wjsd1diN5+/FpedNOin7P8ieTKhDw3YhKSKEjOfKrqcUZgl6NiJBA?=
 =?us-ascii?Q?sKppQiMaFkBitMNrjqiy1awGPcImyMS3fBbfuxeSf0xU03xMfp4js0PVxCew?=
 =?us-ascii?Q?SscHq1mntAwKZqXRQQkz7ATAzKTvsfcIvksUi7A/NY07sR7OoGLOWQu1rVqx?=
 =?us-ascii?Q?Sglwrd/FJJuPqXnmuq2VkasuLKOkvE+N5x0NwRKYDxVCPno8rp01XrPaiwfj?=
 =?us-ascii?Q?YsX3MGjpZ4bZ0bN0f9wh7kOoXrvTyXoGtZ2c3F2eCaigH8W2oaAKNjuReKL8?=
 =?us-ascii?Q?Hi/VI6HibArrsgspJO83WwsUWQ/1PIx0dAV2FacObMHkWbSUEpLrfcUIvPZZ?=
 =?us-ascii?Q?MsJMA+0UrZvd95PoVEPDuIQotdsBJrWEjPrRTvrX0W/cfZeb5WiSWmnSwNKC?=
 =?us-ascii?Q?NNAVWLmlpusS36pZbtBBaCPvX6vt9ssHZc13M7oP53801yBbw5PpF045P7F2?=
 =?us-ascii?Q?S9ycvx9svbHM/NiNZpJEKTv4yw0ljZPZEQKSfgsT6vU4dtlIOwyJvXLZsB5m?=
 =?us-ascii?Q?a5LUrXFdly3O5tY4VMvDVVwWVTyFPrhca+Lm7Uwf3i5QCsoVZW+ts6XBmcsT?=
 =?us-ascii?Q?McKFS02QRkGFVhr2XASJF3zf8dnwi6CWnz55+VT5UEUS+CD7QjRLlRgmFsIk?=
 =?us-ascii?Q?uIGhTCgC0sNhIDNGSI/MVgWhkB049H6epK+HA6C1KZCtqALbZBVDxyzfS2zq?=
 =?us-ascii?Q?+ZJWQR9CJyzBN3/RSDSzVNx78q/8M50zrGb2mRbI1Q0ps8BbWV2ICI7vxGqg?=
 =?us-ascii?Q?ZYzJYhxWJvS5OAPT2LXKhIVeb+OHtyV3sa8sluGDQ9Ww6yCEa4VyrxYJ/HrD?=
 =?us-ascii?Q?DgmDDNYuqbISOGbKF8VNTN3DVsBnonJUMbxd5gWwPhBMyNzN/X4bZdT0tjOv?=
 =?us-ascii?Q?dZ364/eTHvLSSNtWgGNJDHKkBL1H6l52i5lH9XwR1ya8nchXtKgmFnG8G/sj?=
 =?us-ascii?Q?yAf2jOlkaXIKEErr6GUalCLVeAJBWlyOpC0o+wVPLv331a+FSHXyUd7W5Z36?=
 =?us-ascii?Q?VuOQJbXvq8ZHg1aa/ow7IM05iiTagki+O8FIsn3N10SuOlo6S1ZCdg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KO85Js9u0uqQAKPNYwxSKi1GsiDn7C2UtijetEpfgwDKriURlXKgRDNZT23z?=
 =?us-ascii?Q?VVu/etFtJBhdVcurHcKZJD01Y1gc5y5YCMGenqEr5JeE2z8XESH2ySccl2N0?=
 =?us-ascii?Q?G6+3//Tvwv2CnPfg5bUHWzSkPQ/tD4aMwCwqw5S9U2E0CSKqHate70BedKXb?=
 =?us-ascii?Q?70xJTr9nrpRWhkxMhYzZ+1YApnHL9hdTiE67pAdddzihupV82YtrMNAR+HlV?=
 =?us-ascii?Q?RuqhvtdLBJ0cGrTXg124StNDEfcfp2g3RWLvO3yKV008Iiu0Dg65Bm9xyMdN?=
 =?us-ascii?Q?5jk1rOfGl4BB/A8l2qLdkCPMg2JTnI2+mcGnOQSFRhP3qm+3Ls7vBnlcavwy?=
 =?us-ascii?Q?2EUUC104rSeTuesWq2RuIzvpqoth08SQqs3hI/QckmOM+f/6PHPta7FlDTe6?=
 =?us-ascii?Q?mN01BUQ2hKXakjmuMdaZYC7WVvM1wgs0XbUOf0xPUF5hhCGqU4rLRymHaJLK?=
 =?us-ascii?Q?grCEbHcBiIT7wxCYeQjGkXcKamYWOlvOyxWOsbgzEwiDeG1tdcKGRWwwZBN0?=
 =?us-ascii?Q?bpmiHp346BaKypX0QNAGnyJK7pwy7yfVMFPb6X5zQhM7ubsYKscn7WPAcjdN?=
 =?us-ascii?Q?QuUv86GYVB8KB58K8CuR+Og/kn68oaLz86+1kleUl0gwoYjjW4c5oMAlWuJ9?=
 =?us-ascii?Q?7hJT2cUPxWoynrTHGqiriHbHa3TCbiZ/T7AQZDvgL4uTAQODBuGcdEQrpkwU?=
 =?us-ascii?Q?tw8XLZZoh+BrS15ogdkeg84JeNCArc7nzu0G9bZchB4lvrmfYks+CDoTX+zB?=
 =?us-ascii?Q?kYqgxQ4JuWzJpXoeq1azVj/oH1JOMNDMsTmv09FUc9k3RDBl4Mykk0hcekuI?=
 =?us-ascii?Q?oeMUQmzdhUcoTyJawnkNzjSIhjxK31TAUz93kRayL2vSMVJOkmhf3tqIsTvE?=
 =?us-ascii?Q?R7BUgUuS2nwqq6subec2N7BUGXPKSZ43R3GrrQzvuGUBCgZPrdWMJ4mCcBiS?=
 =?us-ascii?Q?kLob/9q7DyiZOEHiJSgd6FezUZ9I62fTX7zkM56nndbBnvzAO2AHd13eugZo?=
 =?us-ascii?Q?bxOhWo2VFqpvGtXEwMA1GCQIs0bIAt28FJj9KmhhcPRc5PeECblNvS7qyhVA?=
 =?us-ascii?Q?1L6ALXaNpZIVcwpY8xMWSr3m/L8/z/wFNLMXrzk2LwK0D5LlLZWAIQ2GNgiB?=
 =?us-ascii?Q?UpKNmnN3lBz7G4TIipO2C2Y0Io1+sxu8WcQEG/acrO9nhngAK7vI4xajQCfJ?=
 =?us-ascii?Q?xD2d93UhXcwsmlcZ1nfcwy6IgagK92nh3unrYkVch53hcTgblpe9WIL3gtkI?=
 =?us-ascii?Q?+CRfjrMuRVlojG1d5fStrCIvFeKTUqYqzVH5gBiJRI8blYmRvWGNkj4tdGt+?=
 =?us-ascii?Q?bxiWm39xCgkhOY5icICCksNgNOLw1/6yGdpYaxil+JcW0y9GnVVegpFP6YJh?=
 =?us-ascii?Q?Sl/zig8IIlT0FkHsKfRi+xZgYe4+mjP8OU8B1SE6nZD/M8WNIJsT8qp3GOdi?=
 =?us-ascii?Q?aZVAEYoUB4UAsbV9ph+6zIIVwGt0YEL6ipneKWECJFhXKUGOYM73YECLzJ5w?=
 =?us-ascii?Q?Nd+2cU6JBgMOeTD2t7914+AJngQ9GmjCER+deHRqYHD7Hjkq97tk2pfecx5x?=
 =?us-ascii?Q?FBwc5qIVh8IQci4Dfas=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68985633-65ef-4490-f42f-08dda544ce3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 21:55:09.2803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EocuFgUrWgneS8sY4YhUE5JlhcJqMF/M4sYS1JD/5lOyIlMcnECIAoX7NsUavqECMSBvgLvriadIGh/Cy+IwKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
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

[Public]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Thursday, May 29, 2025 3:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim, Jonathan=
 <Jonathan.Kim@amd.com>
Subject: [PATCH] drm/amdkfd: allow compute partition mode switch with cgrou=
p exclusions

The KFD currently bars a compute partition mode switch while a KFD
process exists.

Since cgroup excluded devices remain excluded for the lifetime of a KFD
process and user space is able to mode switch single devices, allow
users to mode switch a device with any running process that has been
cgroup excluded from this device.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 69 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  2 +-
 5 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 4cec3a873995..7cfe4677bf56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -746,12 +746,12 @@ int amdgpu_amdkfd_send_close_event_drain_irq(struct a=
mdgpu_device *adev,

 int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev)
 {
-       return kgd2kfd_check_and_lock_kfd();
+       return kgd2kfd_check_and_lock_kfd(adev->kfd.dev);
 }

 void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev)
 {
-       kgd2kfd_unlock_kfd();
+       kgd2kfd_unlock_kfd(adev->kfd.dev);
 }


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index b6ca41859b53..3d5812269ea0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -419,8 +419,8 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
 void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bit=
mask);
-int kgd2kfd_check_and_lock_kfd(void);
-void kgd2kfd_unlock_kfd(void);
+int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd);
+void kgd2kfd_unlock_kfd(struct kfd_dev *kfd);
 int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
 int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
 bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);
@@ -489,12 +489,12 @@ void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, =
uint64_t throttle_bitmask)
 {
 }

-static inline int kgd2kfd_check_and_lock_kfd(void)
+static inline int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
 {
        return 0;
 }

-static inline void kgd2kfd_unlock_kfd(void)
+static inline void kgd2kfd_unlock_kfd(struct kfd_dev *kfd)
 {
 }

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index bf0854bd5555..a12e1433943d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1013,10 +1013,30 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
        return 0;
 }

-bool kfd_is_locked(void)
+bool kfd_is_locked(struct kfd_dev *kfd)
 {
+       uint8_t id  =3D 0;
+       struct kfd_node *dev;
+
        lockdep_assert_held(&kfd_processes_mutex);
-       return  (kfd_locked > 0);
+
+       /* check reset/suspend lock */
+       if (kfd_locked > 0)
+               return true;
+
+       if (kfd)
+               return kfd->kfd_dev_lock > 0;
+
+       /* check lock on all cgroup accessible devices */
+       while (kfd_topology_enum_kfd_devices(id++, &dev) =3D=3D 0) {
+               if (!dev || kfd_devcgroup_check_permission(dev))
+                       continue;
+
+               if (dev->kfd->kfd_dev_lock > 0)
+                       return true;
+       }
+
+       return false;
 }

 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
@@ -1442,24 +1462,53 @@ unsigned int kfd_get_num_xgmi_sdma_engines(struct k=
fd_node *node)
                kfd_get_num_sdma_engines(node);
 }

-int kgd2kfd_check_and_lock_kfd(void)
+int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kfd)
 {
+       struct kfd_process *p;
+       int r =3D 0, temp, idx;
+
        mutex_lock(&kfd_processes_mutex);
-       if (!hash_empty(kfd_processes_table) || kfd_is_locked()) {
-               mutex_unlock(&kfd_processes_mutex);
-               return -EBUSY;
+
+       if (hash_empty(kfd_processes_table) && !kfd_is_locked(kfd))
+               goto out;
+
+       /* fail under system reset/resume or kfd device is partition switch=
ing. */
+       if (kfd_is_locked(kfd)) {
+               r =3D -EBUSY;
+               goto out;
+       }
+
+       /*
+        * ensure all running processes are cgroup excluded from device bef=
ore mode switch.
+        * i.e. no pdd was created on the process socket.
+        */
+       idx =3D srcu_read_lock(&kfd_processes_srcu);
+       hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+               int i;
+
+               for (i =3D 0; i < p->n_pdds; i++) {
+                       if (p->pdds[i]->dev->kfd !=3D kfd)
+                               continue;
+
+                       r =3D -EBUSY;
+                       goto proc_check_unlock;
+               }
        }

-       ++kfd_locked;
+proc_check_unlock:
+       srcu_read_unlock(&kfd_processes_srcu, idx);
+out:
+       if (!r)
+               ++kfd->kfd_dev_lock;
        mutex_unlock(&kfd_processes_mutex);

-       return 0;
+       return r;
 }

-void kgd2kfd_unlock_kfd(void)
+void kgd2kfd_unlock_kfd(struct kfd_dev *kfd)
 {
        mutex_lock(&kfd_processes_mutex);
-       --kfd_locked;
+       --kfd->kfd_dev_lock;
        mutex_unlock(&kfd_processes_mutex);
 }

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index d221c58dccc3..67694bcd9464 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -372,6 +372,9 @@ struct kfd_dev {

        /* bitmap for dynamic doorbell allocation from doorbell object */
        unsigned long *doorbell_bitmap;
+
+       /* for dynamic partitioning */
+       int kfd_dev_lock;
 };

 enum kfd_mempool {
@@ -1536,7 +1539,7 @@ static inline bool kfd_flush_tlb_after_unmap(struct k=
fd_dev *dev)
 int kfd_send_exception_to_runtime(struct kfd_process *p,
                                unsigned int queue_id,
                                uint64_t error_reason);
-bool kfd_is_locked(void);
+bool kfd_is_locked(struct kfd_dev *kfd);

 /* Compute profile */
 void kfd_inc_compute_active(struct kfd_node *dev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 722ac1662bdc..5be28c6c4f6a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -854,7 +854,7 @@ struct kfd_process *kfd_create_process(struct task_stru=
ct *thread)
         */
        mutex_lock(&kfd_processes_mutex);

-       if (kfd_is_locked()) {
+       if (kfd_is_locked(NULL)) {
                pr_debug("KFD is locked! Cannot create process");
                process =3D ERR_PTR(-EINVAL);
                goto out;
--
2.34.1

