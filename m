Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8BFC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5953B601FC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 14:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5953B601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22F36E9B3;
	Mon, 17 May 2021 14:49:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87CFC6E9B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 14:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJUu4DIHYUWImx3Y2RqKy0HpyFr+9Pps2a5kxzwjeWR/4AYOy+GtsHi34h1qGluWaPcHUYktBO2ByV+QSpELseKBsrwFRkwcSB6MS5FXngyU1LOSulA/1CUO9EtaBoCmi74yDZu4/eyiVxxOvGMNvoP9lhR+Ew+IP5d3GFgvkO7054LbRGYXGPBGz34elIE7MyAdevHtawLA/sX6zDMUs2qVihDVMTtrt3kaKEMpIU5bw6B1jQrDDM6odOJO926BexKNYEKMSCqnmFbPcT0h3JMzSyXGP8xLA6LeEtspVe358utiv7V+hsmspDXFKv+RVE7SIpy9/OMqlVvpouZk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJVHFe2oMse4rY1Jjj7PI8MrYmnbyVE7zW8T0x+C5t8=;
 b=XJagEwGt2ALZBqbGKdufbBJpitrTPsZmD6sfoH20OMFU251WsY3+6VdoT3Q+aKfInyVaoXqYrzG1T7OeClv9uzdKUp+fJ9+YYs85QxL+ZbZMwX8dyllgLqMKKR9zViuTbS3p6Wnf5sLhM5LDinZl3H/oppnjN48KeHy1MGKAk6rTgYN/Naw3kLU/S4NDZZteM04zVzt8GnK97aKC2L07nXmYnrblJJmwuERMZxn9DLrZZ0woM3eQ9YU3rVENA30ToTnw3RbVNWYDwRWHmuLMNz91jPy5rWx8W6GuzzgzHWSy5Emd1Z02nzxGa0Fv2PHK/H6pceTGAetCUZt31sXhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJVHFe2oMse4rY1Jjj7PI8MrYmnbyVE7zW8T0x+C5t8=;
 b=zSAxv+qcaEWE3x9g771Hedy6H3nR5ROJsJJxPaauVhADoHH2VzNRCQvKE5p0SMRARUxqvwUN8J3siAejNhSzWbCEAcMHIZK9i10U+7oAv4TUsSs2IskCg7T2L51KX/jA3ohfFbfwxZ3qH8TG+9g8Ompr4i9lHTZlQoDQ+zpLrxs=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Mon, 17 May 2021 14:49:49 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::4172:11d4:b0d7:63d6%6]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:49:49 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12
 sriov
Thread-Topic: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12
 sriov
Thread-Index: AQHXSyptilLfNdTJpEC7Uq6pCXE4iarnvtEA
Date: Mon, 17 May 2021 14:49:49 +0000
Message-ID: <DM8PR12MB5478B352B7F1D70855826CB2F82D9@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210517143910.2125-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-17T14:49:39Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=053e5205-a5d7-4149-afdd-3529f2b0e29d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: drm-next
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [223.166.164.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3342eb58-75a3-499d-a5dd-08d919430559
x-ms-traffictypediagnostic: DM4PR12MB5136:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB513639B79A044467E3619A02F82D9@DM4PR12MB5136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7ppkSGjEzUk0yNebbv3Gg/LTCWQjjxe47gpUtXOjgYre6Wo4kzoY1RvDGIIWGT19Gp0jrxe52N0uzOwzwW1jd7HGH3BQtV/n37byELvBTXLE5iPsFXnX+nBEtSsEx2dHrTe0Pr3dl7GyKdv2P/K8+bhLfkjvsromtOFu3ForN0Xx66JxWXnaQwbU83AAZEvU6mzVtHqkahEp/0q5dcfspOqDdTXvsfWBD1ljsSlNRXRDm6JjFg5Vw9M66f80eGzn9C1+a6uBI+K7Daavu5DFd6ULZMaRWZ3RJzpU11FS6bA9OwcIU2MfGmHc11v+MGYlIzPwG8d+nx2JooPU5mBj1l5D6y564GwoxVcFoW+USs1XcdDCKTRMSuUon4I+BZ/yPegfSFPFwBnYAhJD28zqY7X4s+IP6yHIbUWYXH+s1xVCByEDicNjOksxsTyDhM6jU8Xh9aExN8waHE4n4a9l29XMlsfviEyCjVfOcOtY3OzDz50yxke9eHmhcL4wJzScEKx99Fv7AKm1/a92KI7kSyyRGN99FJHbLVq6eVrRv8DO8PBheGhxn0eHN0Pp9tbcDFB3kMxZEfjrJ72w+LzXq+0kchQAMC1HKA2ZDIN5DI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(366004)(7696005)(83380400001)(186003)(71200400001)(52536014)(122000001)(478600001)(316002)(9686003)(55016002)(33656002)(54906003)(38100700002)(86362001)(8936002)(4326008)(76116006)(26005)(84040400003)(5660300002)(53546011)(110136005)(66556008)(66476007)(66446008)(64756008)(66946007)(30864003)(8676002)(6506007)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?w5fnHiM34dpeZkhLmAtmu19Rfm8CiJnbcmZ8SmNs5sST7idZb3U4zWTNPrcg?=
 =?us-ascii?Q?J8w+rJJ9H9KlixcF27k11iK9crtWyy/KdjB7yr12s+eIlufXLA7rTQzj7NF3?=
 =?us-ascii?Q?IwiWbMuZvqVQfWcfYLm67jXjNcvzT1/H5a0PSrCIYmGymheREdmXMRY0gadT?=
 =?us-ascii?Q?hCfcTSTIq4W42kEKHZyuRXKulrOBygzuqF7GhTxFOucZFcuO8pCueECl/MFR?=
 =?us-ascii?Q?oNFj4mJNzc/24BQgCe3iJnM9hHcjX89Q8J+awtIf9wUiSrTmh9/yalzh2PsY?=
 =?us-ascii?Q?IDZj9vpLosQ19LXrqaB+dYKadPX/f6iuY2kpD2oDYJddh4eoM41x0ZttBiXM?=
 =?us-ascii?Q?YYGNyFr1rili0543454xOwIGZjxddufxhRZzywvCnTFx7dyNeMCfkwblPQC1?=
 =?us-ascii?Q?msyWLzIY/u524buXapYs182pQypqBQl+883+in438rcaSzKxPblAiX0UArrf?=
 =?us-ascii?Q?Xy3fzVcIc4moOxixUdBMRIWib/uxs4upCkgv0eYKS79Xh9NEL2WgkWOBbfgz?=
 =?us-ascii?Q?ZzRKMHRY8+KLV6tta+efBt2C7LKv57/wJrzPjiw2bImiBniWdFn9VIUTurA8?=
 =?us-ascii?Q?FaSnsdV6LWUuY3guS3kQuSDIEvpymq1Jnlz7Z+xLYbYTma85UYBJOp7bI5rD?=
 =?us-ascii?Q?FyDT0+vSJP7NLt5J4DCj0Thd5XCv2fDl4t0Jmr25EUi6YORuG9v85F48Kp2z?=
 =?us-ascii?Q?sG0WO1JCT+25kEfp4dtgmKuQJQUnnLDvH/XxA4IQ7c6PlgAFBvj+rINKqXoJ?=
 =?us-ascii?Q?ZKzuqSMRgYL7q9cKqwwWq6XVmenel0fMm68LUuG/dTg6Gema4ScxD3k6bE8b?=
 =?us-ascii?Q?Ck+dJ7l86q3DC10PP0ZlDsu9bJ9qaYB5KZPKVqjSop3jceS1D4gr3MMtu+54?=
 =?us-ascii?Q?upOugphQ2FciZUEubhDk/1wAmpgKpZ+bC5QjZSHIGhg8cjHr7O7qd2bZ2/FK?=
 =?us-ascii?Q?nm1BYbUOskeEXCF8I6WEUHM8JiITO1ilGXl/OpWHP+jGktj52bRvnrQBxPgm?=
 =?us-ascii?Q?VBFfYejCGCyFoqVz2otCZmwCBNJPZOhshHxaQp6diqWnUOHiWqTJOrxio1Ve?=
 =?us-ascii?Q?Zuo7qUUbpYyjPPjlg6AJA3BiZrCtzf80Vo8qia9QFVXFhAw/FvynxIafvILH?=
 =?us-ascii?Q?w+3Fdp1TXTgoylELZfpSN4EC5j3TGv42kNW9C+R5Kb4sZ76sXqC+ZfdyTs4x?=
 =?us-ascii?Q?+PakZMUk8vRFbisJaP8sNgkf9beIi3wFRJ4tgZ/Hn3STupBNnEEBAIVZuCO+?=
 =?us-ascii?Q?zoGdHBYZ0OED9hEHOU2WpEJt9I/g9pSJrLlLIVb3Upb7VAlff/tdOkRI/Q7H?=
 =?us-ascii?Q?QCqopoFFIKmDFo3IXRShSCda?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3342eb58-75a3-499d-a5dd-08d919430559
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 14:49:49.1924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35PihKm3X5pB+dea7TPfv7H/mvpbzzwhjRi1V+2Be2xx0iENfoTkVP52D3UGirswEc6arX54gkpqUHQMjSqhRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Ming, Davis" <Davis.Ming@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex
About your comment:
"I think patches 1-4, 16 need to be squashed together to avoid breaking the build.  Please also provide a description of how the new macros work in the patch description.  Describe how the reworked macros properly handle sending GC and MMHUB accesses via the RLC rather than via some other mechanism.  It's really hard to follow the macro logic."

I squashed patches 1-4, 16 and add more detail description in the patch description.
Can you help to review the patch series?


---------------------------------------------------------------------- 
BW
Pengju Zhou



> -----Original Message-----
> From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> Sent: Monday, May 17, 2021 10:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou, Peng Ju <PengJu.Zhou@amd.com>
> Subject: [PATCH v5 01/10] drm/amdgpu: Indirect register access for Navi12
> sriov
> 
> This patch series are used for GC/MMHUB(part)/IH_RB_CNTL indirect access
> in the SRIOV environment.
> 
> There are 4 bits, controlled by host, to control if
> GC/MMHUB(part)/IH_RB_CNTL indirect access enabled.
> (one bit is master bit controls other 3 bits)
> 
> For GC registers, changing all the register access from MMIO to RLC and use
> RLC as the default access method in the full access time.
> 
> For partial MMHUB registers, changing their access from MMIO to RLC in the
> full access time, the remaining registers keep the original access method.
> 
> For IH_RB_CNTL register, changing it's access from MMIO to PSP.
> 
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    |  4 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 78 +++++++++----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  9 ++-
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 87 +++++++++++++------
> ---
>  6 files changed, 97 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3147c1c935c8..4e0c90e52ab6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1147,6 +1147,7 @@ int emu_soc_asic_init(struct amdgpu_device
> *adev);
>   * Registers read & write functions.
>   */
>  #define AMDGPU_REGS_NO_KIQ    (1<<1)
> +#define AMDGPU_REGS_RLC	(1<<2)
> 
>  #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg),
> AMDGPU_REGS_NO_KIQ)  #define WREG32_NO_KIQ(reg, v)
> amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ) diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7c6c435e5d02..a2392bbe1e21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -490,7 +490,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct
> amdgpu_device *adev,
>  	    adev->gfx.rlc.funcs &&
>  	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
>  		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
> -			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0);
> +			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0,
> 0);
>  	} else {
>  		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index 4fc2ce8ce8ab..7a4775ab6804 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
>  	void (*reset)(struct amdgpu_device *adev);
>  	void (*start)(struct amdgpu_device *adev);
>  	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned
> vmid);
> -	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32
> flag);
> -	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 flag);
> +	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32
> acc_flags, u32 hwip);
> +	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32
> +acc_flags, u32 hwip);
>  	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t
> reg);  };
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 2a3427e5020f..7c5c1ff7d97e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -1427,38 +1427,36 @@ static const struct soc15_reg_golden
> golden_settings_gc_10_1_2[] =
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff,
> 0x00800000)  };
> 
> -static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset,
> uint32_t *flag, bool write) -{
> -	/* always programed by rlcg, only for gc */
> -	if (offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI) ||
> -	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO) ||
> -	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH) ||
> -	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL) ||
> -	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX) ||
> -	    offset == SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)) {
> -		if (!amdgpu_sriov_reg_indirect_gc(adev))
> -			*flag = GFX_RLCG_GC_WRITE_OLD;
> -		else
> -			*flag = write ? GFX_RLCG_GC_WRITE :
> GFX_RLCG_GC_READ;
> +static bool gfx_v10_get_rlcg_flag(struct amdgpu_device *adev, u32
> acc_flags, u32 hwip,
> +				 int write, u32 *rlcg_flag)
> +{
> +	switch (hwip) {
> +	case GC_HWIP:
> +		if (amdgpu_sriov_reg_indirect_gc(adev)) {
> +			*rlcg_flag = write ? GFX_RLCG_GC_WRITE :
> GFX_RLCG_GC_READ;
> 
> -		return true;
> -	}
> +			return true;
> +		/* only in new version, AMDGPU_REGS_NO_KIQ and
> AMDGPU_REGS_RLC enabled simultaneously */
> +		} else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags &
> AMDGPU_REGS_NO_KIQ)) {
> +			*rlcg_flag = GFX_RLCG_GC_WRITE_OLD;
> 
> -	/* currently support gc read/write, mmhub write */
> -	if (offset >= SOC15_REG_OFFSET(GC, 0, mmSDMA0_DEC_START) &&
> -	    offset <= SOC15_REG_OFFSET(GC, 0, mmRLC_GTS_OFFSET_MSB)) {
> -		if (amdgpu_sriov_reg_indirect_gc(adev))
> -			*flag = write ? GFX_RLCG_GC_WRITE :
> GFX_RLCG_GC_READ;
> -		else
> -			return false;
> -	} else {
> -		if (amdgpu_sriov_reg_indirect_mmhub(adev))
> -			*flag = GFX_RLCG_MMHUB_WRITE;
> -		else
> -			return false;
> +			return true;
> +		}
> +
> +		break;
> +	case MMHUB_HWIP:
> +		if (amdgpu_sriov_reg_indirect_mmhub(adev) &&
> +		    (acc_flags & AMDGPU_REGS_RLC) && write) {
> +			*rlcg_flag = GFX_RLCG_MMHUB_WRITE;
> +			return true;
> +		}
> +
> +		break;
> +	default:
> +		DRM_DEBUG("Not program register by RLCG\n");
>  	}
> 
> -	return true;
> +	return false;
>  }
> 
>  static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v,
> uint32_t flag) @@ -1518,36 +1516,34 @@ static u32 gfx_v10_rlcg_rw(struct
> amdgpu_device *adev, u32 offset, u32 v, uint32
>  	return ret;
>  }
> 
> -static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32
> value, u32 flag)
> +static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> +u32 value, u32 acc_flags, u32 hwip)
>  {
> -	uint32_t rlcg_flag;
> +	u32 rlcg_flag;
> 
> -	if (amdgpu_sriov_fullaccess(adev) &&
> -	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 1)) {
> +	if (!amdgpu_sriov_runtime(adev) &&
> +	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 1, &rlcg_flag)) {
>  		gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
> -
>  		return;
>  	}
> -	if (flag & AMDGPU_REGS_NO_KIQ)
> +
> +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>  		WREG32_NO_KIQ(offset, value);
>  	else
>  		WREG32(offset, value);
>  }
> 
> -static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32
> flag)
> +static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset,
> +u32 acc_flags, u32 hwip)
>  {
> -	uint32_t rlcg_flag;
> +	u32 rlcg_flag;
> 
> -	if (amdgpu_sriov_fullaccess(adev) &&
> -	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 0))
> +	if (!amdgpu_sriov_runtime(adev) &&
> +	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 0, &rlcg_flag))
>  		return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
> 
> -	if (flag & AMDGPU_REGS_NO_KIQ)
> +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>  		return RREG32_NO_KIQ(offset);
>  	else
>  		return RREG32(offset);
> -
> -	return 0;
>  }
> 
>  static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] = diff -
> -git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index feaa5e4a5538..fe5908f708cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -734,7 +734,7 @@ static const u32
> GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
>  	mmRLC_SRM_INDEX_CNTL_DATA_7 -
> mmRLC_SRM_INDEX_CNTL_DATA_0,  };
> 
> -static void gfx_v9_0_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v,
> u32 flag)
> +static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32
> +v, u32 flag)
>  {
>  	static void *scratch_reg0;
>  	static void *scratch_reg1;
> @@ -787,15 +787,16 @@ static void gfx_v9_0_rlcg_rw(struct amdgpu_device
> *adev, u32 offset, u32 v, u32
> 
>  }
> 
> -static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32
> v, u32 flag)
> +static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
> +			       u32 v, u32 acc_flags, u32 hwip)
>  {
>  	if (amdgpu_sriov_fullaccess(adev)) {
> -		gfx_v9_0_rlcg_rw(adev, offset, v, flag);
> +		gfx_v9_0_rlcg_w(adev, offset, v, acc_flags);
> 
>  		return;
>  	}
> 
> -	if (flag & AMDGPU_REGS_NO_KIQ)
> +	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>  		WREG32_NO_KIQ(offset, v);
>  	else
>  		WREG32(offset, v);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index 14bd794bbea6..c781808e4dc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -27,28 +27,51 @@
>  /* Register Access Macros */
>  #define SOC15_REG_OFFSET(ip, inst, reg)	(adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> 
> +#define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
> +	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_wreg) ? \
> +	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
> +	 WREG32(reg, value))
> +
> +#define __RREG32_SOC15_RLC__(reg, flag, hwip) \
> +	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->rlcg_rreg) ? \
> +	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
> +	 RREG32(reg))
> +
>  #define WREG32_FIELD15(ip, idx, reg, field, val)	\
> -	WREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX]
> + mm##reg,	\
> -	(RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX]
> + mm##reg)	\
> -	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg,
> field))
> +	 __WREG32_SOC15_RLC__(adev-
> >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg,	\
> +				(__RREG32_SOC15_RLC__( \
> +					adev-
> >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
> +					0, ip##_HWIP) & \
> +				~REG_FIELD_MASK(reg, field)) | (val) <<
> REG_FIELD_SHIFT(reg, field), \
> +			      0, ip##_HWIP)
> 
>  #define RREG32_SOC15(ip, inst, reg) \
> -	RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> +	__RREG32_SOC15_RLC__(adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> +			 0, ip##_HWIP)
> +
> +#define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0,
> +ip##_HWIP)
> 
>  #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
> -	RREG32_NO_KIQ(adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> +	__RREG32_SOC15_RLC__(adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> +			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
> 
>  #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
> -	RREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> + offset)
> +
> +__RREG32_SOC15_RLC__((adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> ++ reg) + offset, 0, ip##_HWIP)
> 
>  #define WREG32_SOC15(ip, inst, reg, value) \
> -	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg),
> value)
> +	 __WREG32_SOC15_RLC__((adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), \
> +			  value, 0, ip##_HWIP)
> +
> +#define WREG32_SOC15_IP(ip, reg, value) \
> +	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
> 
>  #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
> -	WREG32_NO_KIQ((adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value)
> +	__WREG32_SOC15_RLC__(adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
> +			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
> 
>  #define WREG32_SOC15_OFFSET(ip, inst, reg, offset, value) \
> -	WREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
> + offset, value)
> +	 __WREG32_SOC15_RLC__((adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, \
> +			  value, 0, ip##_HWIP)
> 
>  #define SOC15_WAIT_ON_RREG(ip, inst, reg, expected_value, mask) \
>  ({	int ret = 0;						\
> @@ -77,12 +100,7 @@
>  })
> 
>  #define WREG32_RLC(reg, value) \
> -	do { \
> -		if (adev->gfx.rlc.funcs->rlcg_wreg) \
> -			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, 0); \
> -		else \
> -			WREG32(reg, value);	\
> -	} while (0)
> +	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP)
> 
>  #define WREG32_RLC_EX(prefix, reg, value) \
>  	do {							\
> @@ -108,24 +126,19 @@
>  		}	\
>  	} while (0)
> 
> +/* shadow the registers in the callback function */
>  #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
> -	WREG32_RLC((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> + reg), value)
> +
> +__WREG32_SOC15_RLC__((adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> ++ reg), value, AMDGPU_REGS_RLC, GC_HWIP)
> 
> +/* for GC only */
>  #define RREG32_RLC(reg) \
> -	(adev->gfx.rlc.funcs->rlcg_rreg ? \
> -		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, 0) : RREG32(reg))
> -
> -#define WREG32_RLC_NO_KIQ(reg, value) \
> -	do { \
> -		if (adev->gfx.rlc.funcs->rlcg_wreg) \
> -			adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value,
> AMDGPU_REGS_NO_KIQ); \
> -		else \
> -			WREG32_NO_KIQ(reg, value);	\
> -	} while (0)
> +	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
> +
> +#define WREG32_RLC_NO_KIQ(reg, value, hwip) \
> +	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ |
> AMDGPU_REGS_RLC,
> +hwip)
> 
> -#define RREG32_RLC_NO_KIQ(reg) \
> -	(adev->gfx.rlc.funcs->rlcg_rreg ? \
> -		adev->gfx.rlc.funcs->rlcg_rreg(adev, reg,
> AMDGPU_REGS_NO_KIQ) : RREG32_NO_KIQ(reg))
> +#define RREG32_RLC_NO_KIQ(reg, hwip) \
> +	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ |
> AMDGPU_REGS_RLC, hwip)
> 
>  #define WREG32_SOC15_RLC_SHADOW_EX(prefix, ip, inst, reg, value) \
>  	do {							\
> @@ -146,12 +159,12 @@
>  	} while (0)
> 
>  #define RREG32_SOC15_RLC(ip, inst, reg) \
> -	RREG32_RLC(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
> reg)
> +	__RREG32_SOC15_RLC__(adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> ++ reg, AMDGPU_REGS_RLC, ip##_HWIP)
> 
>  #define WREG32_SOC15_RLC(ip, inst, reg, value) \
>  	do {							\
>  		uint32_t target_reg = adev-
> >reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg;\
> -		WREG32_RLC(target_reg, value); \
> +		__WREG32_SOC15_RLC__(target_reg, value,
> AMDGPU_REGS_RLC, ip##_HWIP);
> +\
>  	} while (0)
> 
>  #define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \ @@ -161,14
> +174,16 @@
>  	} while (0)
> 
>  #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
> -	WREG32_RLC((adev-
> >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
> -	(RREG32_RLC(adev-
> >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
> -	& ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg,
> field))
> +	__WREG32_SOC15_RLC__((adev-
> >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
> +			     (__RREG32_SOC15_RLC__(adev-
> >reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg, \
> +						   AMDGPU_REGS_RLC,
> ip##_HWIP) & \
> +			      ~REG_FIELD_MASK(reg, field)) | (val) <<
> REG_FIELD_SHIFT(reg, field), \
> +			     AMDGPU_REGS_RLC, ip##_HWIP)
> 
>  #define WREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset, value) \
> -	WREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> + reg) + offset), value)
> +
> +__WREG32_SOC15_RLC__((adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> ++ reg) + offset, value, AMDGPU_REGS_RLC, ip##_HWIP)
> 
>  #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
> -	RREG32_RLC(((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] +
> reg) + offset))
> +
> +__RREG32_SOC15_RLC__((adev-
> >reg_offset[ip##_HWIP][inst][reg##_BASE_IDX]
> ++ reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP)
> 
>  #endif
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
