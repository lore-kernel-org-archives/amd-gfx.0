Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD482C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8386661998
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 09:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8386661998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347356E15E;
	Wed, 31 Mar 2021 09:00:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4766E197
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 09:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJjDl8JnlYvslpO3RwKeNfLyxrsQqwSUovjsF3gz2Tv1NAqGatna4evgcf+9xObYxvbsEFUrACcWlgUjDuIhWeJrMQfs0z4yGax9Uo075quIXQKUgvj0HKtvZ58Mens1N7URaCqTzGzn26a+Pl5y14xzeHjN5rfhHQbJmKqE6AryE2nxGPxIKqgkyFWCFN0Dup5Ki/KjCWAJAVReObAA6mMwIbzKiC5o/jV/dO+H16MBjMbAlV5TrAJFWtSlRzQG6oJEGL5/wYzDB3cJYCbBATtRjTTzi74FU0kLI8G4eFGALqeSN+wb0UvPCZBY0KF7HKiavsv0yKCNazFjweZ2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW8FZ5Paw0S5t/xZRyHW7lE9m9uZTCw0/pnYqytfSfQ=;
 b=P27Pvjcu2hHVyJMuHPLvvAwYuUyX1kuBeOBVzUDcZU4cVZFG9pb79o4DokMC2lqGtKYRR68LlEb2Z3qw/fLh26MpImbDsTPxHet2r6g1+txPuSnrEXJ/gckiTW9+GhcCpJvsMfkPa4/StwCEKf5JsbUmSMGPFZlIexKqtKEFNP69q5nA/9gfrpVtDbs9m0Y2kSVBdu1wY0UUR41zCoEvNfwH9UYyrdsbKvC400ynuX3xPSocmyQhmrueXzwmKwSFVF9Js64RvhuWKmOkgzEoWwFfmRv2MWnL0igb7YmvjtX/2QdJIcUPMie2uzjCQWRVh9LP2AurXVfb2KvkViniwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NW8FZ5Paw0S5t/xZRyHW7lE9m9uZTCw0/pnYqytfSfQ=;
 b=RqxKUTSW+60Ybe1kPGKhKje2pfhHmE9D+NJ7YDNg7DYdEf/i5NVWsb8gpkMAnvHIKQFEJhhyXyi55CXJ31l5rgI6mT5Y4cjXE/LWifSfK6jUIXDqLoEVFZImJCGRHJBRz20otuPZm+8JiVz+Sj4u2QWWBH1jr1cQhZyINbJBc+M=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3970.namprd12.prod.outlook.com (2603:10b6:a03:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 31 Mar
 2021 09:00:41 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 09:00:40 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/6] drm/amdgpu: Disable vcn decode ring for sriov navi12
Thread-Topic: [PATCH 1/6] drm/amdgpu: Disable vcn decode ring for sriov navi12
Thread-Index: AQHXJR8Bp6NJPWAUI0egesokufsMSKqdzlxw
Date: Wed, 31 Mar 2021 09:00:40 +0000
Message-ID: <BY5PR12MB4115F835283344FDA725BA178F7C9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
In-Reply-To: <20210330044147.57802-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b43f1b08-2b8a-4700-8258-aae3ce376974;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-31T09:00:30Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3b57c5a-1aa1-4762-85dd-08d8f42375aa
x-ms-traffictypediagnostic: BY5PR12MB3970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3970084E3B17231F06F5AD518F7C9@BY5PR12MB3970.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GxXBL2ipLvCfmsYIqwq7hBFKTS1dn6/xKAA3Oh3x0EbNhndRcw++yBcYBcXEhDanN6pJHr6R/OyQExm7x56gUXbkFRZ3MAJyjOX54dkbP4zevdE8Q3QR3KeZa+RiL5z6MRe3hx7zaaeuEyOivZdUoz+qVMpNT10je4/Wbd43qgK/99eLsp/anbrIJl5IC9P5y9PGWcvPlCplfNyNNiBe6siUtgapxA1IKJyMzU+b33/wWGV9OozX4kdPT4UtjvobeBQyQKZUeInXM68BMYeIDFDSc0cFlEkyFYAf3iu8bhVwUqqPbAVBTt1gd37Loh2TuYTYr+favYLQm6rS6XfB5oRIc98UaPVRz/0qBxWWIxQxDjVRvnmSc093GtHT5lCiycdIwK+p++aBgelOhbM2bPjRagz9pS5/rECXJF+ES2KZEr97TQGlBKMmb68LZV+Dpdx69ewg0h/o6hcxVB4gLrahI0gn8RKphfT00agkEynht8qgnNF60j7lWRXPTMuvlEvShRHKJnp9+5zGhTj+p+Zj99uUSBTc0o/BnhkWXyV7gSezP/6ezoyULP/P7RwydtImetxYT2HSqmhGkIPJUzVwiUi+Wfgle9EY7bxGiGQlhXQxminN3RMcYjEx29JhwL58kER0zaSSLVIT81LDCMIH004yGoI8gbKP6Eg1hJo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(55016002)(38100700001)(26005)(478600001)(83380400001)(110136005)(8676002)(66946007)(71200400001)(64756008)(8936002)(86362001)(66476007)(76116006)(7696005)(6506007)(4326008)(52536014)(5660300002)(66556008)(316002)(33656002)(9686003)(186003)(66446008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FXLFLqfItAPHoeDLVXGWpJeGjv6aiOnTKdO5xmUtZ0CUejNdbuh4DH6Lb/D3?=
 =?us-ascii?Q?LkXqe7xRFNDKmy1cxEM/GVW6ncralmcdYgIUvdqkUH63C+2hC8yZNpTlzBBZ?=
 =?us-ascii?Q?YS71pNnTAr94cAFOI95eloshsXxaVgz+VmTDqsYwIsKweWPweNE/cQYgMNo9?=
 =?us-ascii?Q?g1+wU72CEEmHcZUYi3HKJPdYwTXjd9rcyjdtXghBrY4tsquDou/t0eyXd10c?=
 =?us-ascii?Q?fmtkoPqDlzM1ChlJdXmdETc4bBpqGEgfePzhPLneObhNIsjAjzP3kMCzXI4j?=
 =?us-ascii?Q?QNmCrMSHLyuVHX8Qd7/2V97BRgHC72YmFo2NlWs8Sagp7sgql9/2nXc9eyxu?=
 =?us-ascii?Q?L6yB2A26QqElJlhQjsT6vnBj9C3yff5A+aZwlx09PxplkLx15WhKODvRXPtq?=
 =?us-ascii?Q?ncmv6i8bGURg0ypIC1Z0/FgrBFKR4/CkOjl4SrmToCvAke5fwnY8nWbMXSVb?=
 =?us-ascii?Q?1mbNJzOwUrJgbHBwMwERw+LoymrMAoxC5Fli8RkzAKWxvj72Aewdn3ARY2lu?=
 =?us-ascii?Q?U2hsw4HiHg5lg3LNhYWlmjNYJKqMGog4TfqP3EH3yWCmOjMreg+BdwqSuSzz?=
 =?us-ascii?Q?c/DUicZmcpNdf+vmXjIq8m6jQPRRcsmVXFvDgom8MXlOv4kJGq4NcoiISKLW?=
 =?us-ascii?Q?fnRXC/Kn1APE2F601+DdPhjItc5ffi7vQaNQdjLCMg2VimMZ3HK/z9rhI/6S?=
 =?us-ascii?Q?QTWlo6Z7f+Ts0EsK0oODWAE+/JYTp4EmsW3UiVF3v+d6Rgb00iWsls+KQRha?=
 =?us-ascii?Q?W+mVFIj80LVBFIl26f4RvCitBt6jDHsub0DD3172zKwL6R84eInybByBDpcY?=
 =?us-ascii?Q?zJ06yBck3vbuVTyh0GGfh1xlkDESfVketjvAuRFFaUiHWb+ejrNXuydTr3E/?=
 =?us-ascii?Q?/Bhw9aMGG1qyrpyjpPztcwu1LgLCP4Gd6iuqCWxudr7zQVkVlCHwbwC4/CEw?=
 =?us-ascii?Q?PkrMd5N7T0T7H/0qbFPOzdjHPCIb5U9RdqkuHCx0k0Y1AKatooWKLFnWmkBQ?=
 =?us-ascii?Q?G9MCvPlQKKxhyb1bklSJFG2tzeEhKAwLOyPskkMOO6XaxJwyVBVRJ0o/DtTH?=
 =?us-ascii?Q?933zF/JI34PQ19T3Vm5mO1TmBal5re2/AEy/R+gNGsVAOP3FJkaOOT3Xfty9?=
 =?us-ascii?Q?JgNiZMvdPCzzDFA2+uWN9lf94BnPM2eI+BO/RoNBQavnTBDIm5phjMoTpeel?=
 =?us-ascii?Q?FlJ1KY6iluZQZoq7UYkiPexbW3wXIve8RQy3Aij4jRs2JsnkQRWtyOchu5sc?=
 =?us-ascii?Q?UAkX6J4jupSrxsrzbZZL4zszFLKSW1V3UNZLQYWgGgc4ekGOgYw5Uk6/ba5p?=
 =?us-ascii?Q?QHYORIddcwaizlDNGzIqqJbv?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b57c5a-1aa1-4762-85dd-08d8f42375aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 09:00:40.5996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBT+TbqwnUl7l9iZvDN0avH1hGFgoXI6qA0RhwmXmdhrZzntRu4D/2NnYyE/quG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3970
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
Cc: "Min, Frank" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping......

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Tuesday, March 30, 2021 12:42 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>; Min, Frank <Frank.Min@amd.com>
>Subject: [PATCH 1/6] drm/amdgpu: Disable vcn decode ring for sriov navi12
>
>Since vcn decoding ring is not required, so just disable it.
>
>Signed-off-by: Frank.Min <Frank.Min@amd.com>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  4 +++-
> drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 29 ++++++++++++-------------
> 2 files changed, 17 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>index 8844f650b17f..5d5c41c9d5aa 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>*adev,
> if (adev->uvd.harvest_config & (1 << i))
> continue;
>
>-if (adev->vcn.inst[i].ring_dec.sched.ready)
>+if (adev->vcn.inst[i].ring_dec.sched.ready ||
>+(adev->asic_type == CHIP_NAVI12 &&
>+amdgpu_sriov_vf(adev)))
> ++num_rings;
> }
> ib_start_alignment = 16;
>diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>index 116b9643d5ba..e4b61f3a45fb 100644
>--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>@@ -220,21 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)  {
> struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
>-int i, r;
>+int i, r = -1;
>
> adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>      ring->doorbell_index, 0);
>
>-if (amdgpu_sriov_vf(adev))
>+if (amdgpu_sriov_vf(adev)) {
> vcn_v2_0_start_sriov(adev);
>-
>-r = amdgpu_ring_test_helper(ring);
>-if (r)
>-goto done;
>-
>-//Disable vcn decode for sriov
>-if (amdgpu_sriov_vf(adev))
>-ring->sched.ready = false;
>+if (adev->asic_type == CHIP_NAVI12)
>+ring->sched.ready = false;
>+} else {
>+r = amdgpu_ring_test_helper(ring);
>+if (r)
>+goto done;
>+}
>
> for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> ring = &adev->vcn.inst->ring_enc[i];
>@@ -245,8 +244,11 @@ static int vcn_v2_0_hw_init(void *handle)
>
> done:
> if (!r)
>-DRM_INFO("VCN decode and encode initialized
>successfully(under %s).\n",
>-(adev->pg_flags &
>AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
>+DRM_INFO("VCN %s encode initialized
>successfully(under %s).\n",
>+(adev->asic_type == CHIP_NAVI12 &&
>+amdgpu_sriov_vf(adev))?"":"decode and",
>+(adev->pg_flags &
>+AMD_PG_SUPPORT_VCN_DPG)?"DPG
>Mode":"SPG Mode");
>
> return r;
> }
>@@ -1719,9 +1721,6 @@ int vcn_v2_0_dec_ring_test_ring(struct
>amdgpu_ring *ring)
> unsigned i;
> int r;
>
>-if (amdgpu_sriov_vf(adev))
>-return 0;
>-
> WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
> r = amdgpu_ring_alloc(ring, 4);
> if (r)
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
