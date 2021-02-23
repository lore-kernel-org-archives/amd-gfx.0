Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A1C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 17:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D3764D9F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 17:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D3764D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58186E9EB;
	Tue, 23 Feb 2021 17:54:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C4D6E995
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 17:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8XEvhFD50dMG7qDfL+22ZON0r95SIuDLlhqIBEknnhAAOzFdmwo6+oVZTd8dFRJU6AJh4K0lZiSi/5WkU16fetD4J7L6a18rhoadnsxik0f25B/idY421RrsgEcmoQG8aip4lhvsoGArGNRN1F0GcbD6b3+LdztFgZc8hmvuMo9EABNgaIXJRwcndq69glqRHit/Pv3yMQrzlpqnkBg/24Qq6qDGw9+zEtVIRW7+aVGRCIY7w7/X6JqbWu9r3Tab5dthc7F6NFn5g+57A4PrQmp+7Rz/c+THI47mNuXhIwig/8zG5n0H1L5YgJh+pw229rgxtcXgUsu7MUccSYvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUQikLfvLZdwyZSIyB75btDsqvosv22B3ocqXkpe42I=;
 b=SiReLRl7rIhRt3ITryZmymjIzFLvJBxxPgdcchZUMCykaHASBOjPTOpR3Mus1/PXDuqPK2n0zwejxfm1/5YrptQGWY25/skZ3u5bY35Qq0lUyzTbsnhMc403CGigExg6iITEjvE//arypSUlihhQPu9mD/ZgDO+WD7Pac+07K2iXxFc1AGXN3GS/T2BnWmR/nt6T5zXWtnCas3PFVUReiXToJ9TN0n0Z0H+LBftt/SN7WyowdJjRntVF/BKWLOAL0gTwMY/6IDtZRsXM8u9yrxCDwbzPrRL7z+YhMnqr8b5PHaICZFsJ7s5izKh32eIkVRpVWW2TEpxU2OPSpZuiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUQikLfvLZdwyZSIyB75btDsqvosv22B3ocqXkpe42I=;
 b=LROrzO3u8EUJPhmpfJ4X8YoAeFkhjq8poX+G/3kwE2+7FTWMh7uFTjA+2mgFXAwfSUcH/yBah6QusiD0QLyJUktyFElQKt62xZYt3mkr2Qemyky29pSC0MK4p8YBzQPJa6i9Zp21nRUz7PQ1O87Wk9KhxMI+irYx/s7PdR+5DCw=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.36; Tue, 23 Feb
 2021 17:54:39 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Tue, 23 Feb 2021
 17:54:39 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXBl01v0ZbFS6gCEmvb376iost8qpl+kgAgAACc4A=
Date: Tue, 23 Feb 2021 17:54:39 +0000
Message-ID: <DM6PR12MB3835980BDB0B1E61A78E003CF4809@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210219011846.28413-1-shaoyun.liu@amd.com>
 <CADnq5_O=oTMZse8k9iWp+5PDO4R9KK8_uiFy2rY2dbnm-N4HOQ@mail.gmail.com>
In-Reply-To: <CADnq5_O=oTMZse8k9iWp+5PDO4R9KK8_uiFy2rY2dbnm-N4HOQ@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-23T17:54:33Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c6408d0d-a816-4a74-87e2-9431f53ccb97;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:c0d5:387b:19b:615f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0904eed5-8649-4fde-349a-08d8d8241770
x-ms-traffictypediagnostic: DM6PR12MB3020:
x-microsoft-antispam-prvs: <DM6PR12MB3020E63596DF425260E6839DF4809@DM6PR12MB3020.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swY3vPLFd6YX0Qh96U2LSu86Jpsg6YroEFUMZKj8/VNsks7a2+Q8BEbYguCNT54b9xI+IhwsKQp5gsrZnzptJa0Net5x3giFgfCHyZfOC/bmzA7sv7RtzeZIpAx2FJxOFoo0mRSJMFA9d3R5z67XY0ZJkSQZaLQMYOnyD740qc7sT5exVvSih+cbOaK6pz1R+lYiyJnsag0szjBEE55kgdQDA54/KnFRyXXWB9hDbJgf9mvt/8lvKF2oHfDbkTCRfyZJtdPXjqCpLD7O0e8xaP+82tW8yFCv4XCt+Dzsy1NebXHI4h1z/LYLykJbVBTIsDVXFZxa2BOjSaseyPpJpUzmInet214PzQvhlD6JcOSq3oeocKjFIoUjSOLlwvy/CW60g2WMHWSwwZPGuOGJVyGGdVty6MsXrnYPhguHYleBogu0QwbMulYmHLFBPN8DCi7ffIV40BVFUbr1OQe5liWUIv7ktE9lhi00WhdcWJ2vvD3cUSq9o5HDnhiNaJq3e0pIsNwJ/+elazy4S/e1ayQwlp5eq/8UzlN6QMlMWUlQaYFFDpKftR+SMmCYNhnUGH72vOv67d/Q2Dj840141SB213qCflmEcHqKShIm9AmHYNnV6ZfX4GeB8zZvU7pbXB39A/FcJi5r6WbKiKTufw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(8676002)(66556008)(186003)(7696005)(9686003)(83380400001)(6506007)(64756008)(76116006)(53546011)(86362001)(71200400001)(66446008)(66476007)(5660300002)(45080400002)(52536014)(966005)(66946007)(316002)(478600001)(6916009)(2906002)(30864003)(55016002)(33656002)(8936002)(4326008)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PcqHHAzz05/b8hq3twAOPNdPRz6A72awk1EPfAbmdjxFzT+OwMJSR7nGwe5F?=
 =?us-ascii?Q?K1jFb6PpAes/rBdORr1Ukx8nPW8dbCorzCAwwolJniRaMktbnb+9orhIVDMb?=
 =?us-ascii?Q?6qbv7b9IovE6wJgBoFio6isfDQqWkuyJVR6UfwCXWR4Rs4eS45h2sS/0Bzrf?=
 =?us-ascii?Q?gy2qvvpDSDfm7Rq4eZTV8vQetO75PZsILKf/n2lEpPGslNnhetPFafsI+K+4?=
 =?us-ascii?Q?kA8UpPkaTQfNpBrSqEOoEUZkNhMtHhmV5NEJ2huWC5YI+9nVY4ZiAW178DDd?=
 =?us-ascii?Q?qWcc4kLKTxcrm5xMxHI1k/M7aYPx/167lCeg+9AX38LhsNulbx8+w65kI8kM?=
 =?us-ascii?Q?7/1U5CLWpXg/AaKipxybn6jPw5v/D0KDz6nPMD5tgJVJl46rf8CImryV1yqX?=
 =?us-ascii?Q?yteLSea2I6syqKOKtjQL/zkE6OYj6Y3Y1Uf5G0w1o7eZ1Hg/eCoNfoEo/M61?=
 =?us-ascii?Q?iFoM1MwmwmW4XKhHAPlqK75GwMC4bP5AfeQMTKzMzfuTpB63ZJBYlVJJj6yp?=
 =?us-ascii?Q?YGSxfXbqtgfGL5iSjVHwR7/0RpzW/enQBdkaxW5+RxE1DoSNQqiPkMxyMXdN?=
 =?us-ascii?Q?AzoDcphWlhmQxB4AXCuA7a/WjimXbHDaVDSeUMu5SY8MkyKwj16j0ng8iPfZ?=
 =?us-ascii?Q?ufnHZFeGIfff6DI3qzsYZJxBi0JGcKRk+XJTXF6qm52btEnOW0gmJNnznVKy?=
 =?us-ascii?Q?galK9qBSZ5Xdk4yWojcOjIHlbLe4Yqo+t3JZFLkUZVXZCHxtWabvjaL+C1yg?=
 =?us-ascii?Q?sNn7lm0XzvC5eaff0sPlWHWy7hsSn8JEujk/z9FRVSbMef8VecGK4vlL5QUW?=
 =?us-ascii?Q?/zKRM5vkegiofE6GyvFCv3I1UmhjDe2TR5zHYSvRsmdu+F0vOgPGGu1rCRwb?=
 =?us-ascii?Q?3poeoRHCzF29kRBKfkV4Nasi+UCT4Jm4qNqH0yWUGAodIIJLBexurt37g/WJ?=
 =?us-ascii?Q?MUaXp9eUM7GdtNKiBsf/bzJZlwioINhKCpRBRVXSk/5j8/XaDUVhIyq+SrGf?=
 =?us-ascii?Q?ccvKCKdeL3bnYs6Lwy5UuV5wM3SWvJyYyp1ymrnVCMPI1vMOua86NeCLVU/6?=
 =?us-ascii?Q?F0SYBXlXwLSfZ5/M///Nex+MTgL6OIpBX/lvd+olU0DacrzUWBA1WcTXMDsG?=
 =?us-ascii?Q?Zz1i8RVLirueLn7reEWHEXAnmrIxIHyqnCLXj8gRiZoLOKs6jwTdfMyK5gAn?=
 =?us-ascii?Q?6ZngNFHA06MrO58fDDmAUZnaVkCiDWABlsQfCCOoPpn/lKme4UfGUQiTTSA5?=
 =?us-ascii?Q?w3fnY0R+ZifuiaeL/C9ya1NSOXvBmK/lR9JXG4ju2NRMojVn7eu3OwSdKf/f?=
 =?us-ascii?Q?4EXIC116m0SWsbpZLFhJGBF0kUx3ekWRbI0hQxhRo66oJX78/PaMJN5bAkgU?=
 =?us-ascii?Q?qKYa7iHlwpXISKUUZ+nWDoM8c0Mg?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0904eed5-8649-4fde-349a-08d8d8241770
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 17:54:39.4957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nq+gO+P1RErXPAHR7eDgAfuOrSqx7nr0wlBArOQhSX8eWVaZgOSHEN/VdNjnd4gHAh9i8dRg23i9KyZTSfgq4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Comments inline , 

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Tuesday, February 23, 2021 11:47 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

On Thu, Feb 18, 2021 at 8:19 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> In passthrough configuration, hypervisior will trigger the 
> SBR(Secondary bus reset) to the devices without sync to each other. 
> This could cause device hang since for XGMI configuration, all the 
> devices within the hive need to be reset at a limit time slot. This 
> serial of patches try to solve this issue by co-operate with new SMU 
> which will only do minimum house keeping to response the SBR request 
> but don't do the real reset job and leave it to driver. Driver need to do the whole sw init and minimum HW init to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time with existing gpu_recovery routine.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  6 +-
>  4 files changed, 87 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2f9ad7ed82be..9f574fd151bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>                 }
>         }
>
> +       /* Don't post if we need to reset whole hive on init */
> +       if (adev->gmc.xgmi.pending_reset)
> +               return false;
> +
>         if (adev->has_hw_reset) {
>                 adev->has_hw_reset = false;
>                 return true;
> @@ -2147,6 +2151,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>                         if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>                                 continue;
>
> +                       if (!adev->ip_blocks[i].status.sw)
> +                               continue;
> +
>                         /* no need to do the fw loading again if already done*/
>                         if (adev->ip_blocks[i].status.hw == true)
>                                 break; @@ -2287,7 +2294,10 @@ static 
> int amdgpu_device_ip_init(struct amdgpu_device *adev)
>
>         if (adev->gmc.xgmi.num_physical_nodes > 1)
>                 amdgpu_xgmi_add_device(adev);
> -       amdgpu_amdkfd_device_init(adev);
> +
> +       /* Don't init kfd if whole hive need to be reset during init */
> +       if (!adev->gmc.xgmi.pending_reset)
> +               amdgpu_amdkfd_device_init(adev);
>
>         amdgpu_fru_get_product_info(adev);
>
> @@ -2731,6 +2741,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>                         adev->ip_blocks[i].status.hw = false;
>                         continue;
>                 }
> +
> +               /* skip unnecessary suspend if we do not initialize them yet */
> +               if (adev->gmc.xgmi.pending_reset &&
> +                   !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> +                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
> +                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> +                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
> +                       adev->ip_blocks[i].status.hw = false;
> +                       continue;
> +               }
>                 /* XXX handle errors */
>                 r = adev->ip_blocks[i].version->funcs->suspend(adev);
>                 /* XXX handle errors */ @@ -3402,10 +3422,29 @@ int 
> amdgpu_device_init(struct amdgpu_device *adev,
>          *  E.g., driver was not cleanly unloaded previously, etc.
>          */
>         if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
> -               r = amdgpu_asic_reset(adev);
> -               if (r) {
> -                       dev_err(adev->dev, "asic reset on init failed\n");
> -                       goto failed;
> +               if (adev->gmc.xgmi.num_physical_nodes) {
> +                       dev_info(adev->dev, "Pending hive reset.\n");
> +                       adev->gmc.xgmi.pending_reset = true;
> +                       /* Only need to init necessary block for SMU to handle the reset */
> +                       for (i = 0; i < adev->num_ip_blocks; i++) {
> +                               if (!adev->ip_blocks[i].status.valid)
> +                                       continue;
> +                               if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> +                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
> +                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> +                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
> +                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
> +                                       DRM_DEBUG("IP %s disabed for hw_init.\n",
> +                                               adev->ip_blocks[i].version->funcs->name);
> +                                       adev->ip_blocks[i].status.hw = true;
> +                               }
> +                       }
> +               } else {
> +                       r = amdgpu_asic_reset(adev);
> +                       if (r) {
> +                               dev_err(adev->dev, "asic reset on init failed\n");
> +                               goto failed;
> +                       }
>                 }
>         }
>
> @@ -3536,19 +3575,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         /* enable clockgating, etc. after ib tests, etc. since some blocks require
>          * explicit gating rather than handling it automatically.
>          */
> -       r = amdgpu_device_ip_late_init(adev);
> -       if (r) {
> -               dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
> -               amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
> -               goto failed;
> +       if (!adev->gmc.xgmi.pending_reset) {
> +               r = amdgpu_device_ip_late_init(adev);
> +               if (r) {
> +                       dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
> +                       amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
> +                       goto failed;
> +               }
> +               /* must succeed. */
> +               amdgpu_ras_resume(adev);
> +               queue_delayed_work(system_wq, &adev->delayed_init_work,
> +                                  
> + msecs_to_jiffies(AMDGPU_RESUME_MS));
>         }
>
> -       /* must succeed. */
> -       amdgpu_ras_resume(adev);
> -
> -       queue_delayed_work(system_wq, &adev->delayed_init_work,
> -                          msecs_to_jiffies(AMDGPU_RESUME_MS));
> -
>         if (amdgpu_sriov_vf(adev))
>                 flush_delayed_work(&adev->delayed_init_work);
>
> @@ -3565,6 +3604,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (amdgpu_device_cache_pci_state(adev->pdev))
>                 pci_restore_state(pdev);
>
> +       if (adev->gmc.xgmi.pending_reset) {
> +               struct amdgpu_hive_info *hive = 
> + amdgpu_get_xgmi_hive(adev);
> +
> +               if (atomic_read(&hive->number_devices) ==
> +                   adev->gmc.xgmi.num_physical_nodes) {
> +                       /* Trigger hive reset when all gpus within the hive is ready */
> +                       dev_info(adev->dev, "Trigger XGMI reset during init.\n");
> +                       amdgpu_device_gpu_recover(adev, NULL);
> +               }
> +               amdgpu_put_xgmi_hive(hive);
> +       }
> +
>         return 0;
>
>  failed:
> @@ -4241,7 +4292,9 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>         int i, r = 0;
>         bool need_full_reset  = *need_full_reset_arg;
>
> -       amdgpu_debugfs_wait_dump(adev);
> +       /* no need to dump if device is not in good state during probe period */
> +       if (!adev->gmc.xgmi.pending_reset)
> +               amdgpu_debugfs_wait_dump(adev);
>
>         if (amdgpu_sriov_vf(adev)) {
>                 /* stop the data exchange thread */ @@ -4304,6 +4357,7 
> @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>                 list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>                         /* For XGMI run all resets in parallel to speed up the process */
>                         if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) 
> {
> +                               tmp_adev->gmc.xgmi.pending_reset = 
> + false;
>                                 if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>                                         r = -EALREADY;
>                         } else
> @@ -4343,10 +4397,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>         list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>                 if (need_full_reset) {
>                         /* post card */
> -                       if (amdgpu_device_asic_init(tmp_adev))
> +                       r = amdgpu_device_asic_init(tmp_adev);
> +                       if (r) {
>                                 dev_warn(tmp_adev->dev, "asic atom 
> init failed!");
> -
> -                       if (!r) {
> +                       } else {
>                                 dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>                                 r = amdgpu_device_ip_resume_phase1(tmp_adev);
>                                 if (r) @@ -4790,6 +4844,8 @@ int 
> amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                 if (audio_suspended)
>                         amdgpu_device_resume_display_audio(tmp_adev);
>                 amdgpu_device_unlock_adev(tmp_adev);
> +               /*enable buffer function after reset */

Space between * and comment, e.g., /* Enable

> +               amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);

Will this cause issues with any of the other flows through this code?

[Shaoyunl] it won't , the function internally will check whether it's in reset state . so for normal gpu recovery called on runtime , this won't have side effect. 

>         }
>
>  skip_recovery:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index aa0c83776ce0..8c71d84a2fbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>         struct list_head head;
>         bool supported;
>         struct ras_common_if *ras_if;
> +       bool pending_reset;
>  };
>
>  struct amdgpu_gmc {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 839917eb7bc3..5e127a59b121 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2261,6 +2261,12 @@ static int psp_load_fw(struct amdgpu_device *adev)
>                 goto failed;
>         }
>
> +       /*Don't do the real PSP HW init if we are pending on XGMI reset.
> +        *The above init probably should move to psp_sw_init
> +        */

Space between * and comment.  E.g., /* Don't

This whole thing seems kind of fragile.  Is there some way we can restructure the init code to provide two code high level code paths?
One for regular init and one for this case?  I feel like this will be prone to breakage if this code sees any changes.

Alex

[shaoyunl]  Agree, current psp code mix the SW init code in the HW init function,  to fix that will  involved some  changes not directly relative to this XGMI  reset and  other more tests . I would like to separate that from this serial change . 

Thanks 
Shaoyun.liu


> +       if (adev->gmc.xgmi.pending_reset)
> +               return 0;
> +
>  skip_memalloc:
>         ret = psp_hw_start(psp);
>         if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 659b385b27b5..b1c8fd90c1b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>         if (!adev->gmc.xgmi.supported)
>                 return 0;
>
> -       if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +       if (!adev->gmc.xgmi.pending_reset &&
> +           amdgpu_device_ip_get_ip_block(adev, 
> + AMD_IP_BLOCK_TYPE_PSP)) {
>                 ret = psp_xgmi_initialize(&adev->psp);
>                 if (ret) {
>                         dev_err(adev->dev, @@ -538,7 +539,8 @@ int 
> amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>
>         task_barrier_add_task(&hive->tb);
>
> -       if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
> +       if (!adev->gmc.xgmi.pending_reset &&
> +           amdgpu_device_ip_get_ip_block(adev, 
> + AMD_IP_BLOCK_TYPE_PSP)) {
>                 list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>                         /* update node list for other device in the hive */
>                         if (tmp_adev != adev) {
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Csh
> aoyun.liu%40amd.com%7C0641a47202924dde84c308d8d81aaaf3%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637496956338383230%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C1000&amp;sdata=Yvp3D7pFpvK%2BRP4StG%2BTH8O0UlWYsbPJ54MzdyKbFGQ%3D&am
> p;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
