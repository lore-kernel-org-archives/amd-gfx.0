Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F82C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 16:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D51A10E400;
	Mon, 25 Mar 2024 16:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GpVySeP9";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A0010E451
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 16:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY0ffOE5Q88skYX2fpJ5AFjep0Qi/14L3WARRRYv7lU1x8Ue1nfGEa/0rY892BQjFemc6IrQLVqsFy1fA9dxBHsLPbKDcrFWf03q44aEFOlaG6uZkVl9t7EmxEphhl1g+LOCwKeC2jJX3tbKs2GC7vg5xWEf3SwjTkg87uEaQlejE07oP+MRqDEWhsUc4w1eGJi+KozLkJPW3fnHUtv808lusEVTHC834Xen+ubn6jiiVCjYP2KVkIq+kqs/V9NN4SatIUHHFfXyP0iTE2AolqmnH4+UEtpUGdKV2MzwxsDQl8gUssVqQGARPO2LN09D8Y+N4UYpjAb54yYz4koRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RabSE0yZZ2AMLDPhUQemBhEqLCt67hWS3k23EniC7DM=;
 b=iEV9sKzoO2BBAZ3g1MWg/rwnt/mU42iqhUAEIxEeagbarx59o8O0WZp6rNK6QUVUm5UTyrCd0zS7vedmk0EBXhUjU7r0+hnYMbQDjpLWeoGGmUruEKdFnqJ419LmS46EqrUQZ18Gi1VLbfCiX7ojN7pZn4Uuz9IUgqPFpxTFoR/f1YkaHE2P+4d3Y6D0h7fNnf3CadSOoo9MSn6jpJN4HYi+mvWdW6aP5E/4dNE+FITDKKCh9MCTeDrKtnIl8sZu17nnWIiv3te+0yZAWk2MFJaTtaXGheehMQfBve5AIgbodAJKT0dsq9tEFTwCl9d94ONfn75HmJbBnrfJFns2/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RabSE0yZZ2AMLDPhUQemBhEqLCt67hWS3k23EniC7DM=;
 b=GpVySeP9GfWmP3OKsedEZdZSEEk3IW+ClQpY/Hr6rd83NLPHqI6fvhsuEef1J+Dn/s3xZnOMGuyR/jshx5zzYGC9hsu2CxuywLcP6ctv87ou0rFjoI2sErYSOU4+7EXGbexs41dT2w3vyIUwhZFH+v3cMlfOwa78w7xuw3vVNIw=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 25 Mar
 2024 16:08:27 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 16:08:27 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Saye, Sashank"
 <Sashank.Saye@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Luo,
 Zhigang" <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 1/3] amd/amdkfd: add a function to wait no process running
 in kfd
Thread-Topic: [PATCH 1/3] amd/amdkfd: add a function to wait no process
 running in kfd
Thread-Index: AQHafseym7Ez9D39Uk6CW3nnXRO9qrFInx/g
Date: Mon, 25 Mar 2024 16:08:27 +0000
Message-ID: <BL3PR12MB6425169C6231AE9DA8C959B7EE362@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240325151805.6379-1-Zhigang.Luo@amd.com>
In-Reply-To: <20240325151805.6379-1-Zhigang.Luo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e82b13a0-2fa4-4f2e-bd35-33e1ffc28e6a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-25T16:06:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SA1PR12MB7366:EE_
x-ms-office365-filtering-correlation-id: 57060349-0cba-4f1c-18b9-08dc4ce5ce99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X8xQo4NpVGpoGGncijaMuS2O+LR8Dns4FY+m+xHtjCZmNppU3e0JW5tuLNKYhnMD1ehYutb7n8zrkuK58w/VDmN9ZRq3v9h9N4mENnLdbEDFtJs9HNcW8iu80Vn7xgabNV2TnvS0ynoTHrZfR31i8eWbTXIQd2Fa0eq4Ojw+V3E419XE0pfk8Q/E3Az45emU/il1kLDnxBzQlnQLyIobQUd5dhxN38NnBmgRan7VViqC9tM5cVadTP0BRkl2eyRxXH3TdDMdD9SADLzNo2JZueWzSyeLAJWSE8PvOrA3xnzSddeOYYuUqwHKxEnGzZ8X44CWR3NgWyNXSaCgvvwPqXJD+flIlHcBEihw6gzGykZgwHlCFwVP80aPlVGHIoHOusoEyPzl0X8em2dHhGaaJu+mgvUYnO3NzgtfVX/J9G7VqXiNnHCyyach3F0DM49oYX5/7n/mbNNpSJr7tpA8v7QhxucuZ+gnG7Juend+3SybSniAzWqP5cgLw6k1dPKJBzUlJK4WBezd4SfZuJUE3h08wQ6KR50ET5MeXeJbYZwoirUU/3wauYM9XZJSNFzsvPmK7LUzDtfR1TIgt045PiQ2boakafWbfDlSGaixWxEY0xAODSfKAbUbE4+fKnA8B6FlYqku/MpMuDI6Z9U392iEIQWtSAvVDLf6lPlLuPR+cZzSWEtrA6EIQgizbj7aIlSTpvp2mIqEeQwwiy8HPi8Gk8bemx01rl0I/gVVF9U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nEzcIVol9bUx2wIBTBJEU386bOdVnmDUSwe6ag4o21eDVwpwhbJXIrwWoJa5?=
 =?us-ascii?Q?WrWf5mXc3YTov0qAAfGwZTwd302jQfqmBsbPif5LDRYT7LKOEHSdhg5tb1tV?=
 =?us-ascii?Q?unbtXOi101/ihyn9VSk15V09IkcFjlxn2k/8FEUZk/Whb6LQ6pFXnXtegCMN?=
 =?us-ascii?Q?V+1vu8AeE1BX2Pt5wQlsnuFAMuMXaOtXzcc1p3sCfpw2x8zo4wB0/eI8MjaL?=
 =?us-ascii?Q?gbtmO16KfRh8Pq0EYlTc57RquPmIMxjyaJpwzfRG64MPzhz3oL8hQaaYaFCd?=
 =?us-ascii?Q?gMYh4EZVOghREaRe9+Y9EZhHvqSkvtwV6HQY6cfrHShqJkCmBuJkA+j2UfNp?=
 =?us-ascii?Q?cQoJwunKqvcy79/SXtIztaljCO3jSf8V0q+KCKYBFrSYjfdFzcR2CKvI9CSA?=
 =?us-ascii?Q?cInPC70aSDlk4EX9JNUgOwnkrWpsl9d9piAYHjsMggEsZ73Bn7SM6g36rtlI?=
 =?us-ascii?Q?VEVoK4zhYfzypLBXe3AFFFXUR6STjCAuUs9ATRS8CjxActruon2R0+pKsM94?=
 =?us-ascii?Q?3VhR0IRQMYC9rSfE/DgutwN7nPxEiJG4460UbTS2cuo/pOfCzUEOO8MPkp7J?=
 =?us-ascii?Q?CDENHavnCE/i9msoBMP3EESddgl/TJBK2Y7U6psJnkpX5Kzvp9Z+OdCKpP2b?=
 =?us-ascii?Q?CvjId3FtD7lOGWqV5og2K+CzspmvVJL3WjRYIVciLmE0eqAmcvEGmfEmr6IE?=
 =?us-ascii?Q?v90lo7ZrccYCH2hcKpKWNJF3nv1ZEf2gKCFBqvYQPXHSmngxl0CV57voPHhy?=
 =?us-ascii?Q?ABYVWPYaI+tDjz4uym5wND3y8zEqEUHk9AwF2rtsjYPvajoTCUAO1VsGJFrK?=
 =?us-ascii?Q?8T2VuFxQ2mY08IczmQH0UK80X+6hXuyhmJ39cwuzJgM6xIbPv3Fh2crEghR+?=
 =?us-ascii?Q?IaDD+MxCen8porbkvqn8pvwufTDizz8gjpRfpRw1BoepvxuE072qIk2B8FMZ?=
 =?us-ascii?Q?MHG1tuNEIQsezoP0dUPP3X8eOI+5bKHg0ViEMDCiWDvFJH5xJszI7gbDsuzr?=
 =?us-ascii?Q?z4ESqRMObjUhgKNnPcZOHh8qK2crZfpEGwFaj4/WLrM1Sg6+rXZTI2r1Xf9r?=
 =?us-ascii?Q?siaQK+gYO5QFehbLi4KVJH2dNGD6wlLbWXS9NINBMeRxtTf3BOgoOIMF0UQx?=
 =?us-ascii?Q?UnKJKpDys8IKiES5HeZlAEyOB0sqQHDQgs7rVorJkSMh1JR/yMI2n/IhyqEj?=
 =?us-ascii?Q?BWM88IgclIkaUV3tEzIXzHttOaD2x4dIsLsPtdmeQR+CHnVF93puVe9tc8Ti?=
 =?us-ascii?Q?qXgMCEH5w1VqBF5a/fw+QQfKb3q4uG8HHMbcxdvfvqgF3CPVEoXdmIh+8G4D?=
 =?us-ascii?Q?1ek0CUMoB8HfuCuoCjiaQ1wUovzWs01kJQyPYJAVY9F1hbygLmhh7F1cd1rx?=
 =?us-ascii?Q?tgYNj5kT5bB6mzd7CV71Axvo0DY7cji/MLCINlMBm+WQPup/I5Jxe33eIeUS?=
 =?us-ascii?Q?aNT/G1mQ/a2wxl7JcvI081+Otk4dISetWgUorF9aRG0PvWB7UjEiDUwKoQCq?=
 =?us-ascii?Q?dYk87NMBkb09kUX56CWg+mec3BksvMf/RLRQFdHmgHflGiZPpY7Qi8HgAd2v?=
 =?us-ascii?Q?NlyY345uSb9AssXGmOk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57060349-0cba-4f1c-18b9-08dc4ce5ce99
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 16:08:27.6519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4ZydrNFwBPqQxLrlPl5QuxgJiI25+He2YZkpjXkKXgtj1vhNyWkv3QNIHxvvO2KsfpYhaqKiMoT2AKnI625jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Zhigang Luo
> Sent: Monday, March 25, 2024 11:18 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Saye, Sashank
> <Sashank.Saye@amd.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>;
> Yang, Philip <Philip.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Luo=
,
> Zhigang <Zhigang.Luo@amd.com>
> Subject: [PATCH 1/3] amd/amdkfd: add a function to wait no process runnin=
g
> in kfd
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
> Change-Id: I2a98d513c26107ac76ecf20e951c188afbc7ede6
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 20
> ++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 10 +++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 11 +++++++++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index d5fde8adf19b..e02bfcec608b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -261,6 +261,26 @@ int amdgpu_amdkfd_resume(struct amdgpu_device
> *adev, bool run_pm)
>         return r;
>  }
>
> +int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device
> *adev) {
> +       unsigned long end_jiffies;
> +
> +       if (!adev->kfd.dev)
> +               return 0;
> +
> +       end_jiffies =3D
> msecs_to_jiffies(AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS) +
> jiffies;
> +       while (!kgd2kfd_is_processes_table_empty(adev->kfd.dev)) {
> +               if (time_after(jiffies, end_jiffies)) {
> +                       dev_err(adev->dev, "wait no process running
> + timeout\n");
> +
> +                       return -ETIME;
> +               }
> +               schedule();
> +       }
> +
> +       return 0;
> +}
> +
>  int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)  {
>         int r =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index caee36e52a09..d46dccc5bbf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -38,6 +38,8 @@
>  #include "amdgpu_vm.h"
>  #include "amdgpu_xcp.h"
>
> +#define AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS 10000
> +
>  extern uint64_t amdgpu_amdkfd_total_mem_size;
>
>  enum TLB_FLUSH_TYPE {
> @@ -169,7 +171,7 @@ void amdgpu_amdkfd_set_compute_idle(struct
> amdgpu_device *adev, bool idle);  bool
> amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
> -
> +int amdgpu_amdkfd_wait_no_process_running(struct amdgpu_device
> *adev);
>  int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
>
>  int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev); @@ -411,6
> +413,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,  void
> kgd2kfd_device_exit(struct kfd_dev *kfd);  void kgd2kfd_suspend(struct
> kfd_dev *kfd, bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd, bool
> run_pm);
> +bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd);
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);  int kgd2kfd_post_reset(stru=
ct
> kfd_dev *kfd);  void kgd2kfd_interrupt(struct kfd_dev *kfd, const void
> *ih_ring_entry); @@ -454,6 +457,11 @@ static inline int
> kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>         return 0;
>  }
>
> +static inline bool kgd2kfd_is_processes_table_empty(struct kfd_dev
> +*kfd) {
> +       return true;
> +}
> +
>  static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)  {
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 041ec3de55e7..2bec79e0c721 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -894,6 +894,17 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>         kfree(kfd);
>  }
>
> +bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd) {
> +       bool is_empty;
> +
> +       mutex_lock(&kfd_processes_mutex);
> +       is_empty =3D hash_empty(kfd_processes_table);
> +       mutex_unlock(&kfd_processes_mutex);
> +
> +       return is_empty;
> +}
> +
We already have a function, kgd2kfd_check_and_lock_kfd(), for this, which i=
s more robust.
Please use that one instead.

Regards,
Mukul

>  int kgd2kfd_pre_reset(struct kfd_dev *kfd)  {
>         struct kfd_node *node;
> --
> 2.25.1

