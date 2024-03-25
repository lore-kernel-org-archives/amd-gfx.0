Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CCCC54E64
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 20:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A90510E431;
	Mon, 25 Mar 2024 20:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AMjWG7YG";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F0A10E431
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 20:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vgdr3g8LYRJC8gnFZOPuMHqF8umb6gsIuyne2KlLO3VDfM8JUsg8W6XyCm4mv0xGj2DL4J8oEf1zaHCoJSLhjDp7/ASUScyQupoFCi+QP5gAJi1WXwgSd1iTy5ZTB987vLkyqDq5fo5ZDd+EiSMHvL/e3f67aLSN81ieXWFMl0CezS78GJ2tRxAO/nHCojvjcZVmTjWm5xEzIJAupbEJwjRj57laMlPsVHvz6CTmP7ZZ8xn5L/pV/M3gKHzeEVia+OXDuVCIoHWceaJSsZTvGEG4LZwLEEkfyO+Xf1ZWw6doiy1Duzb9Ypd6Zude8+k5Qr3V6PkMJnNNMm2Jk1ZkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMrltT9ceflk//Z29fIko+Uy5eTu5s3eCYXg0z9HL2s=;
 b=SdEj+xHqfdkN/dEE4Ln4nGHeS8JdRBJMcLpP8dQC/7AevbWLNYnKjOWh0nKP2BvA5F10nZmjrwnb2ECx9OGh/tS7T2U2TqHoE0X21WCIPecBes+9Qr3ubbQEW3zdBfIZ1kOW8mnjnGFpBU5SQ9xb4SVcYNjDfthOjdTmQajhMYFbagNt3//DtoZd5ZxzhxjPWIVV/xLSwWMZH713fo3WiaTquo+VjYlNNdl7MbaRpzjwKFNPpGwuIdIMB5mVHOL4U27e1tF5/WpujIUCcIB0GZv6WD7owks4JybTJ1Y43pRD0Z4cxyqwmDPYNKFfzS1wPeFN/jGo+whniwHfWESuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMrltT9ceflk//Z29fIko+Uy5eTu5s3eCYXg0z9HL2s=;
 b=AMjWG7YGu7wkapocXY8GnHo4BRvaoOC4wVhXgOeRVuZrrdRIymzTQDG2lyfQhyDBYcG/3aFUKM1BLRHHL4fCVWDpiNjaJLcbVPLxk0C1R9VoQscdX5j097vCtzmQZ+tcl7vDVpUCARP5SXwBqd2d2dh/uiXCUmUnhQ1SrZfczDM=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 20:49:28 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 20:49:28 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Saye, Sashank"
 <Sashank.Saye@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Yang,
 Philip" <Philip.Yang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 1/3] amd/amdkfd: add a function to wait no process running
 in kfd
Thread-Topic: [PATCH 1/3] amd/amdkfd: add a function to wait no process
 running in kfd
Thread-Index: AQHafsetzO4MWceSGEOdIfoAD86nx7FIn8iAgABJxiA=
Date: Mon, 25 Mar 2024 20:49:27 +0000
Message-ID: <DM4PR12MB532843EF4F181D8052842684F1362@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240325151805.6379-1-Zhigang.Luo@amd.com>
 <BL3PR12MB6425169C6231AE9DA8C959B7EE362@BL3PR12MB6425.namprd12.prod.outlook.com>
In-Reply-To: <BL3PR12MB6425169C6231AE9DA8C959B7EE362@BL3PR12MB6425.namprd12.prod.outlook.com>
Accept-Language: en-US, en-CA
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
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|CYYPR12MB8921:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: By0sBoWy0ZD/4Du3G311JWe0f+eh3F8uwj+5EIMUw8BgUv7v6Gp9sDsHrobi9oSZ6TgoiErulUOLNG9eOqsHKczb1CiUvye6XCyh5bbKaNP+LxNkmTGT933qoYHolIYOxGNZIzUVbrCMau734ya1Qqhj1Cs3TrLYfiZ/akvRoAId47CL8zCTKKtkkaMkBLznCE1fy7fvfDstgzbyhnt3eABiQzbIHxqcT3raIi+QrVWLOW0Mr52qI9Q/4qCnvFvqDVYhAnYbPDzxmR9OzcndLGUsSOfLG4965CR2LofyQkaoo9FTrjaePSezFj7Sg/VYXxuIjmbSFgtV+uAD5H/Ax2oz+Z9LWyGwo9RA7zJ1D2HTvF4OFTnFIXWLQ9c/qQUPl86gQ+y7n4hqNH3QB77N84N15bmwO+1aUXBzXTzqY5A8DKfbF5G0wtFYV4BG0ko6TJydk6INfr5HICc66aUbuj5xMGu3PaxLy+0EjMcAZr/LoN5iv1KJ1nLryjZqAMu0QrVoqh74yLulFT1b1YkVxjpVo0OdZKkUVr0mbO1VL3q5cxl45WoTBt6/VeMN3+31U7WjVxX6dTi/0oo32pNfjR41RyBeqIzeO6oe3U2B06pBVhwOcBICNMwpgjJepmtd8QlGMgT3Wpk1SxuO0yyaso4BWP+GY7V312yVFcpHC0k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IxskZT1hAlH5pwPrrHD07XvOFP1RUfSYjePpAFn61J94jPE5txraFKcjo+n4?=
 =?us-ascii?Q?aaxQ4mfkoPeoBMifYxwbaahrmH35IMiAbl6AyYl6zqDjKLOk/QwUCwYpEDgh?=
 =?us-ascii?Q?HW0aDvvilm+I3NkiN5QzkyKxKXKjvWFStbntcPGSHZ6+bvE6at/ytZPe2Kwi?=
 =?us-ascii?Q?dkUIVH3NdBygD1NAsQMP+SmCrJkZBF07FMlWKAZLBsnxp8Ci8hW3CBlqkfiy?=
 =?us-ascii?Q?S9dafYipMIlsl5JfGIw9g0xvmN+7zGwyPChqXK83gAokuZfC38kzfhqewPJ8?=
 =?us-ascii?Q?w2BRmDeZCoszMEBE/Tgl/0U1rTmuXTJWzBqqsthiZanBA9r8BY1fw3tYPk/D?=
 =?us-ascii?Q?/eRe69Ps9A4vUbc7Dx64Xm/EBlOlVXNZ+SRS27SHKO2jlcuGG9SuBjPH0i/2?=
 =?us-ascii?Q?cADUMajAOaT7y0B7/ZkDSAwx64oHkjO+xEV2EiKouOe5u7/7TUQrOI7/71XC?=
 =?us-ascii?Q?UcVpF42oScH9IRNKGdlT/inf0TFlASJLSHWybqBHJRRbvMzHibB2sMGBEbUm?=
 =?us-ascii?Q?7GaLFGl6LqVrlX28qzxvoaBLYBj/kM4oiYR0mCelwM8amxT4QQe0fU0x0yWE?=
 =?us-ascii?Q?PhQvTt5xkrr1hlxKIZ7I2mkZ8T7t6mrIyxCaYJsCW4QEN/RvtBkAuNZ5WCxO?=
 =?us-ascii?Q?Icz5bKFFo7elfgt2velyvN5ldHI2PjPUfB8wjcPxSD9BZp9f2nHRdak00Edq?=
 =?us-ascii?Q?NAEqJIiciZ4F89ibdp04MSjAid+k3Jnzksk9tY3Jzx4jpEwNCNiP5KfbhUBw?=
 =?us-ascii?Q?RjeNZNH+QkfFcCU0jUx2xrpcohr8Uy0Ckq7mL/oiCrT9B5iSkQJcnfTB3fIq?=
 =?us-ascii?Q?FxuIgrS0WOCpNaf8tP9T77pZmGpC0YYn3imOp+r7hn+HVmREAKt965PKJg3r?=
 =?us-ascii?Q?0SKiqK28UKZjDr4iMgQpJbSDYZlMxZLQEm1nf2wKSQNHDuARUTtDlSwQsnXd?=
 =?us-ascii?Q?SH4WH4JuJk1nUa03XIfiidKDPL9pho7wJZfLw7W5fH8dWY5eCe/+OLHyQ0I/?=
 =?us-ascii?Q?AGvpBDoSoxatpZkt24ElsZoxrL634IxClcNvcHZdatHujxxqdz1b8t0WTICn?=
 =?us-ascii?Q?Yn8f0b1bIXQJSPA5Azus3nTPJJ3rqDgIxqF6IzNOvEJ0U5wkvv5UyzEtTkiK?=
 =?us-ascii?Q?e5qBxuXZjv0+Lgitc6JlmPxrnrMkkjdc3FKfKlsKrePcEXU/MwQvoomyuYI0?=
 =?us-ascii?Q?eV4fuaodvkfMpmT6d7lU5XiZDOAgjzVGrvzdKgw0iM6Z+Y5vuiT6QY7FYrLL?=
 =?us-ascii?Q?JvfWFWysbbYMDgHdpWRmocUqgtaoVHasK0wwmPTagaikxTV2ye6AFUn9hinG?=
 =?us-ascii?Q?TcA24Zp7ZFGrTm0+6vPh72Sz1JqnezHhWBPMoLyXUuf4qSo4opfHnurk+Zbp?=
 =?us-ascii?Q?KBiN4cjpRsaWfjz1RJzUCi8VwG4SVPyqGcJR0hfj105Oa35T6fSB0zxep48e?=
 =?us-ascii?Q?bK6a5et5q8RrDMzC9dtpPmveLAoQ4SFVQkVSNF3dhsZ1B2R4nV0fIAXUdgM7?=
 =?us-ascii?Q?JDFX9E7DgEAaKrT6y4PTzhTHMXSUsok3bE3Td+gv+EBghel4u4Bhr1if9/2A?=
 =?us-ascii?Q?RP35jNfTvSYavUED18o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d816979-3c47-4e3a-d5cd-08dc4d0d1013
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 20:49:27.8861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEMfFiHWqkTpFSsssgUV+Gagh6DRWmMgyXgCq5krpSsKBBFPJNcW4kW0h9c9akPT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921
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

Hi Mukul,

The purpose of adding this function is to waiting user applications to be k=
ill after calling amdgpu_amdkfd_pre_reset().
If I understand correctly, kfd_locked will be set after calling amdgpu_amdk=
fd_pre_reset(). So, I added this new function to only check if kfd_processe=
s_table is empty.

Thanks,
Zhigang

-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Monday, March 25, 2024 12:08 PM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Saye, Sashank <Sashank.Saye@amd=
.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Yang, Philip <Philip.Yang@am=
d.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com=
>
Subject: RE: [PATCH 1/3] amd/amdkfd: add a function to wait no process runn=
ing in kfd

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Zhigang Luo
> Sent: Monday, March 25, 2024 11:18 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Saye, Sashank
> <Sashank.Saye@amd.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>; Yang,
> Philip <Philip.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Luo,
> Zhigang <Zhigang.Luo@amd.com>
> Subject: [PATCH 1/3] amd/amdkfd: add a function to wait no process
> running in kfd
>
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
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
> msecs_to_jiffies(AMDKFD_WAIT_NO_PROCESS_RUNNING_TIMEOUT_MS) + jiffies;
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
> kfd_dev *kfd, bool run_pm);  int kgd2kfd_resume(struct kfd_dev *kfd,
> bool run_pm);
> +bool kgd2kfd_is_processes_table_empty(struct kfd_dev *kfd);
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);  int
> kgd2kfd_post_reset(struct kfd_dev *kfd);  void
> kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry); @@
> -454,6 +457,11 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, b=
ool run_pm)
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


