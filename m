Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F33CC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 14:28:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D4460EB1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 14:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28D4460EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92D66E060;
	Fri, 23 Jul 2021 14:28:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4766E060
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 14:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfZWwPFKtaC8HSmkt/6JwAFQ1fIZ7mGJsgynDJ2dtznrC3pPKChk7xnhOh7AdwPk2SEwjtlUHl7QpnwlRqTGm2G2G56xOjXoHKkcUZzN3veDBgUUsGfyk2YUaWTQOww5Unp5SEOyRz41qG51ERoD5pfWjtJoih8fEuMYasDyd2lUQ0JBcg/x5D6LVKNqzWLAT+miuNtJ04erGbv1YyshCyXK1Ip25otL2jkcX1Rs0ZCUms2hpWVkUlaaqaDn3cH8HLMqnVwQP9fazNhQ5BGOtSUY4Z5wN31hyIZW3okp1GpxgCJNZVWwdfHQWFSti88BmauwKPjUsUgF9Gk35uLGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hNGF4y63QfcwYHtNOzgWOCEiopfdxn9inGTJ5PgdOc=;
 b=AvxYZ4rnCHdK5VjZIzoSURvDjSmxvvW5/zLKrl6vrO5Tc8KbGk0wl5lA6C6BNU/QBFrddkdw0eFBfnXAROY8xH4w0hbcVVdkJI7MMBBT4JImCf74aES2F1MlDZ7chjSIWbFwPA4v2I6ePISnngICplJ3/Q7bpR9nbL68I5A4lCzJ7CrzG7P3HQ+T5z3NzEo4GBBHHOiGKIHjgYCPfZMy0sUH0bibKOJpKSlkh42WLrdGg0YGKsvt8VwdrQqJi3URpdlYgLxOuG5aa9SNDpXv/Y7Dj4U5N7f84FJQtdTEtGI5Iqjegwlv4pNPxaiFU/bINRdeFMf8zT86jFDQRwpljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hNGF4y63QfcwYHtNOzgWOCEiopfdxn9inGTJ5PgdOc=;
 b=DE4YdM94qks4oGbmsLZxu/tkPoIQ3mnT0XWI1mhqzNUxinkc8CNJaXMMaZoGaFOvWZpzQ25FW5Wf/faCvNOHwKYxwjUEXwr32KGv+k4uTEG/dndmh/OsoyB5WzxLQlLX1z/v6e+Plm0PE77NmnAyCxN35BeybT4ssrn4T62VBM0=
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Fri, 23 Jul
 2021 14:28:11 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 14:28:11 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Topic: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Thread-Index: AQHXf6KAJfIwA3vPB0eeJGQa8WRHLKtQVlYAgAA8PwCAAAtV7g==
Date: Fri, 23 Jul 2021 14:28:11 +0000
Message-ID: <BL1PR12MB5349CA058BBDD4B180B143C597E59@BL1PR12MB5349.namprd12.prod.outlook.com>
References: <20210723090933.806633-1-evan.quan@amd.com>
 <1b728523-e245-13f1-b649-ca422d29594a@amd.com>,
 <DM5PR12MB2469EEAE60BBC25160F35F89F1E59@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469EEAE60BBC25160F35F89F1E59@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-23T13:44:56.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d91b8399-0e74-4896-8ce9-08d94de61958
x-ms-traffictypediagnostic: BL1PR12MB5270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB527043592D3E9F7E937BA20F97E59@BL1PR12MB5270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TbPFAJrI9lTmVHSGH4GtlrGm5QP3yqWthocJkQfkLxBeDd5TbJxD7L3BcPZOxXnCJHMSy3YtyRX00CG9gLF08wa2ZXYxN85rUUfET9yCKvzrKl2PIAPbZ4N2g7VFrmVexBIFwO/fom5QJ4c093UTjywnIQy9uCXTg3SQzY8r1V1ra3NjrESLzz/ZVmAITKczZvJdp9Cs29++JGr4B6QIf7Zg+pH4aYak0Ky8eqOIcrj0kf1OlWj9b4Fv3VCo4RIf99vFtgDSefrTiViz7RXnGlSov7KuYjabloV/7Zu7ObeORycqp/DqQ+yWy2mE87tWyXaqnr4DYJQYZ4ALzKW6xqrENtmWGxZXo1Hr32ME+nMvshspD6d1uM2Ex31AbO5Ro4SkIwjVgFfn05Kl6ngpROsF/8tEkhGz1fqakgr2RsOG1h8KfRBWMjI09JKtIQaMgtqVj7v9CJkDo14yT3MGviRSMJFdAsv+kEciiP97gRtY04efNSXWUPEXv19X0tCc6pwuQAOwaBexskxr8qqcdPeJNGVN1Yhmt3roEtZaaKZ9MywtV4jVJziomrRMvW+NN2Uf0gZdHCemDmVr7W7edYsfu6Np8BwsUaOef4GCHVqZc7YzHMmWW7GhK8PGS2/vN9u5n9UvQO2jJ48ZjzsUBoc76S179iv2LOmmJT71TFtXNZZ2bEUfMaej8madE9iuxNfdFunWEGNgE3J42wsA3nZpAetrsKJSRETthYwRVXQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(33656002)(26005)(166002)(122000001)(30864003)(83380400001)(66574015)(4326008)(316002)(38100700002)(8676002)(8936002)(9686003)(186003)(55016002)(66556008)(64756008)(66476007)(66946007)(76116006)(53546011)(91956017)(86362001)(2906002)(52536014)(66446008)(6506007)(45080400002)(478600001)(71200400001)(5660300002)(966005)(7696005)(110136005)(32563001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h5gO/ROUgJB5LFO5yvM2DOCF9CTJRQBWUHWgl33HT+p7p/cN3JsHvwYJeUin?=
 =?us-ascii?Q?4MkuOJSkhbDnfl0UktA/2Q+z+930d+WY2TV9+kXVXPQ/h/qcmvbOMyLbn2o1?=
 =?us-ascii?Q?/bLdapjfXcruQzkGPrswLvWnDeWkPRXdEYGRU4efQ2AxRgMz37grec5nfQw5?=
 =?us-ascii?Q?R+E0srgBAhsmJ8Dusuj4n/59vPgh1h0glY60NIvMQVRN7pX+G+RYEeUfvQWA?=
 =?us-ascii?Q?kRg9t7yoBXsm89vnqWjFVjw/8iIR77mEy1Pf1PN150p6QBXYEew5j5UpaGkl?=
 =?us-ascii?Q?o9yueDbLuB5II4GtcxMvSeCF3eXJj6BtHIzDRVXudqZYjePNn9UbeM3iIXAT?=
 =?us-ascii?Q?YcfT7T/b8iPSHuj3pMDTSRzLj+Ytyd1aVz9voN6tTDJM1Ei0cBtNbOiu8bbQ?=
 =?us-ascii?Q?0+qmuZisAgg57RcCizS2v7L7dCx6jZv0ywHFmfZnjgz0kVjRoIruWQQEKpPf?=
 =?us-ascii?Q?aPmBxiogd5zBMA9gVK3iMdtfusttBryFw5zQekYcA85733s4Qv3oNaR1fsov?=
 =?us-ascii?Q?gLW3L+4nsoAvax+lnA0pxvBxAEQ3ikmO6Oxsb7cw2xL2usE9quQqaJMNNXea?=
 =?us-ascii?Q?0h3Sl2hGg+knBvjGeFqFxuii2W+i6XLoTBPPUzUx04xEKkxLkFl4zjLjdkMr?=
 =?us-ascii?Q?y+dPW3Dr2+55D96lXaDIBVhTP2MURk1eFr6yL/FyWayJjSF78rXGVqFFrsOy?=
 =?us-ascii?Q?Sp6AD0pOhIj9iuoXBzQIkoFsQx9AE+iKD+gpjZ2uQgC+y8ggjE2ldydHAkeW?=
 =?us-ascii?Q?6trM6daarpgheG4rFLJLqrHXneA1IFE8CzNrbudddaz0wibmkjy6HIzsO1zY?=
 =?us-ascii?Q?6Jtz8y4yazIuvaopesQdw5UpY5phCFULIAO06+AE+dXdQkX+06NKGbktHRu/?=
 =?us-ascii?Q?Nuin7I+jkIjkv4WUY3vpncJdaUaYCruMrPleOmg/lQaJiviPfUuHdCkS9ITM?=
 =?us-ascii?Q?A80yMsdEPDpqIk7T/UkvxK5piO3nQhLAJtsIq5KM2VsX1fndxK1D2Yiz/pdZ?=
 =?us-ascii?Q?W064yXmd7zkemAUy4BE4Oy+QUmDj3xuYGrJNxiKGeUgascYKJIRDx9318hXp?=
 =?us-ascii?Q?Iwz9NE/7LQLysEZKt4bCRomVYD9iqJGX2Qszu4110h2NY50OhkAQWTdS8vLn?=
 =?us-ascii?Q?vHMFBcBR6EeLjIn8/XzbdAaoKWA1CJ4NcBGXoFs48FkQrJno1jHA2nLE1R93?=
 =?us-ascii?Q?ND/+xOlHcUoHAObdWM0jex4Z/lR1bMStPZ9PkArh9jAX2upKuJ/qpKBjjazw?=
 =?us-ascii?Q?i2HwcZKmEkOrsz0pAubYkwOrpUeMu+5YfE+PSBcbXq1CIj49Vs8Diny9OvtQ?=
 =?us-ascii?Q?1N82t4ImvndN3rpkpUCXT5Kad6v+Zqggi/4qpFPu5jMYJA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91b8399-0e74-4896-8ce9-08d94de61958
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 14:28:11.0824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: al8jPXPCQA094anzc0cKsszaHXwJ94a1zaFaBXqaSUaI1fX29rg7ZL+kDmZCe46p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============0004457146=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0004457146==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB5349CA058BBDD4B180B143C597E59BL1PR12MB5349namp_"

--_000_BL1PR12MB5349CA058BBDD4B180B143C597E59BL1PR12MB5349namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Good one, that makes better use of flags.

Thanks,
Lijo
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, July 23, 2021 7:14:58 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-g=
fx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings=
 properly for NV1x

[Public]

Just curious that in the patch, it adds a variable *user_od* serving the ch=
eck of applying user customized OD setting. Instead of this, does it make s=
ense to use the *flag* in struct smu_user_dpm_profile for this? As we have =
below bit in pm/inc/amdgpu_smu.h, can we add another bit for OD restore? Th=
is will help unify the usage of *flag* in SMU.

#define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, L=
ijo
Sent: Friday, July 23, 2021 6:09 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings=
 properly for NV1x

The series looks good to me, though I prefer to use a common logic to resto=
re od settings so that smuv12,smuv13 gets the restore feature by default on=
ce they add the user table logic. Don't have strong argument for it unless =
Alex, Kenneth or others have some comments.

Anyway, the series is
        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 7/23/2021 2:39 PM, Evan Quan wrote:
> The customized OD settings can be divided into two parts: those
> committed ones and non-committed ones.
>    - For those changes which had been fed to SMU before S3/S4/Runpm
>      suspend kicked, they are committed changes. They should be properly
>      restored and fed to SMU on S3/S4/Runpm resume.
>    - For those non-committed changes, they are restored only without feed=
ing
>      to SMU.
>
> Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2
>    - better naming and logic revised for checking OD setting
> update(Lijo)
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
>   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 55 +++++++++++++------
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 25 +++++++++
>   5 files changed, 82 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 3e89852e4820..c2c201b8e3cf 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
>        uint32_t power_limit;
>        uint32_t fan_speed_percent;
>        uint32_t flags;
> +     uint32_t user_od;
>
>        /* user clock state information */
>        uint32_t clk_mask[SMU_CLK_COUNT];
> @@ -352,6 +353,7 @@ struct smu_table_context
>
>        void                            *overdrive_table;
>        void                            *boot_overdrive_table;
> +     void                            *user_overdrive_table;
>
>        uint32_t                        gpu_metrics_table_size;
>        void                            *gpu_metrics_table;
> @@ -623,6 +625,12 @@ struct pptable_funcs {
>                                 enum PP_OD_DPM_TABLE_COMMAND type,
>                                 long *input, uint32_t size);
>
> +     /**
> +      * @restore_user_od_settings: Restore the user customized
> +      *                            OD settings on S3/S4/Runpm resume.
> +      */
> +     int (*restore_user_od_settings)(struct smu_context *smu);
> +
>        /**
>         * @get_clock_by_type_with_latency: Get the speed and latency of a=
 clock
>         *                                  domain.
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 385b2ea5379c..1e42aafbb9fd 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct smu_context
> *smu);
>
>   int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
>
> +int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
> +
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ebe672142808..8ca7337ea5fc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct smu_=
context *smu)
>                }
>        }
>
> +     /* Restore user customized OD settings */
> +     if (smu->user_dpm_profile.user_od) {
> +             if (smu->ppt_funcs->restore_user_od_settings) {
> +                     ret =3D smu->ppt_funcs->restore_user_od_settings(sm=
u);
> +                     if (ret)
> +                             dev_err(smu->adev->dev, "Failed to upload c=
ustomized OD settings\n");
> +             }
> +     }
> +
>        /* Disable restore flag */
>        smu->user_dpm_profile.flags &=3D ~SMU_DPM_USER_PROFILE_RESTORE;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 59ea59acfb00..d7722c229ddd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2294,41 +2294,52 @@ static int navi10_set_default_od_settings(struct =
smu_context *smu)
>                (OverDriveTable_t *)smu->smu_table.overdrive_table;
>        OverDriveTable_t *boot_od_table =3D
>                (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
> +     OverDriveTable_t *user_od_table =3D
> +             (OverDriveTable_t *)smu->smu_table.user_overdrive_table;
>        int ret =3D 0;
>
> -     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)o=
d_table, false);
> +     /*
> +      * For S3/S4/Runpm resume, no need to setup those overdrive tables =
again as
> +      *   - either they already have the default OD settings got during =
cold bootup
> +      *   - or they have some user customized OD settings which cannot b=
e overwritten
> +      */
> +     if (smu->adev->in_suspend)
> +             return 0;
> +
> +     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void
> +*)boot_od_table, false);
>        if (ret) {
>                dev_err(smu->adev->dev, "Failed to get overdrive table!\n"=
);
>                return ret;
>        }
>
> -     if (!od_table->GfxclkVolt1) {
> +     if (!boot_od_table->GfxclkVolt1) {
>                ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                             &od_table->=
GfxclkVolt1,
> -                                                             od_table->G=
fxclkFreq1);
> +                                                             &boot_od_ta=
ble->GfxclkVolt1,
> +                                                             boot_od_tab=
le->GfxclkFreq1);
>                if (ret)
>                        return ret;
>        }
>
> -     if (!od_table->GfxclkVolt2) {
> +     if (!boot_od_table->GfxclkVolt2) {
>                ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                             &od_table->=
GfxclkVolt2,
> -                                                             od_table->G=
fxclkFreq2);
> +                                                             &boot_od_ta=
ble->GfxclkVolt2,
> +                                                             boot_od_tab=
le->GfxclkFreq2);
>                if (ret)
>                        return ret;
>        }
>
> -     if (!od_table->GfxclkVolt3) {
> +     if (!boot_od_table->GfxclkVolt3) {
>                ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,
> -                                                             &od_table->=
GfxclkVolt3,
> -                                                             od_table->G=
fxclkFreq3);
> +                                                             &boot_od_ta=
ble->GfxclkVolt3,
> +                                                             boot_od_tab=
le->GfxclkFreq3);
>                if (ret)
>                        return ret;
>        }
>
> -     memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
> +     navi10_dump_od_table(smu, boot_od_table);
>
> -     navi10_dump_od_table(smu, od_table);
> +     memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> +     memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
>
>        return 0;
>   }
> @@ -2429,11 +2440,20 @@ static int navi10_od_edit_dpm_table(struct smu_co=
ntext *smu, enum PP_OD_DPM_TABL
>                memcpy(table_context->overdrive_table, table_context->boot=
_overdrive_table, sizeof(OverDriveTable_t));
>                break;
>        case PP_OD_COMMIT_DPM_TABLE:
> -             navi10_dump_od_table(smu, od_table);
> -             ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (=
void *)od_table, true);
> -             if (ret) {
> -                     dev_err(smu->adev->dev, "Failed to import overdrive=
 table!\n");
> -                     return ret;
> +             if (memcmp(od_table, table_context->user_overdrive_table, s=
izeof(OverDriveTable_t))) {
> +                     navi10_dump_od_table(smu, od_table);
> +                     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRI=
VE, 0, (void *)od_table, true);
> +                     if (ret) {
> +                             dev_err(smu->adev->dev, "Failed to import o=
verdrive table!\n");
> +                             return ret;
> +                     }
> +                     memcpy(table_context->user_overdrive_table, od_tabl=
e, sizeof(OverDriveTable_t));
> +                     smu->user_dpm_profile.user_od =3D true;
> +
> +                     if (!memcmp(table_context->user_overdrive_table,
> +                                 table_context->boot_overdrive_table,
> +                                 sizeof(OverDriveTable_t)))
> +                             smu->user_dpm_profile.user_od =3D false;
>                }
>                break;
>        case PP_OD_EDIT_VDDC_CURVE:
> @@ -3262,6 +3282,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
>        .set_soft_freq_limited_range =3D smu_v11_0_set_soft_freq_limited_r=
ange,
>        .set_default_od_settings =3D navi10_set_default_od_settings,
>        .od_edit_dpm_table =3D navi10_od_edit_dpm_table,
> +     .restore_user_od_settings =3D smu_v11_0_restore_user_od_settings,
>        .run_btc =3D navi10_run_btc,
>        .set_power_source =3D smu_v11_0_set_power_source,
>        .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask, diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0a5d46ac9ccd..7aa47dbba8d8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context *s=
mu)
>                        ret =3D -ENOMEM;
>                        goto err3_out;
>                }
> +
> +             smu_table->user_overdrive_table =3D
> +                     kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNE=
L);
> +             if (!smu_table->user_overdrive_table) {
> +                     ret =3D -ENOMEM;
> +                     goto err4_out;
> +             }
> +
>        }
>
>        return 0;
>
> +err4_out:
> +     kfree(smu_table->boot_overdrive_table);
>   err3_out:
>        kfree(smu_table->overdrive_table);
>   err2_out:
> @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context *s=
mu)
>        struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
>
>        kfree(smu_table->gpu_metrics_table);
> +     kfree(smu_table->user_overdrive_table);
>        kfree(smu_table->boot_overdrive_table);
>        kfree(smu_table->overdrive_table);
>        kfree(smu_table->max_sustainable_clocks);
>        kfree(smu_table->driver_pptable);
>        kfree(smu_table->clocks_table);
>        smu_table->gpu_metrics_table =3D NULL;
> +     smu_table->user_overdrive_table =3D NULL;
>        smu_table->boot_overdrive_table =3D NULL;
>        smu_table->overdrive_table =3D NULL;
>        smu_table->max_sustainable_clocks =3D NULL; @@ -2101,3 +2113,16 @@
> int smu_v11_0_deep_sleep_control(struct smu_context *smu,
>
>        return ret;
>   }
> +
> +int smu_v11_0_restore_user_od_settings(struct smu_context *smu) {
> +     struct smu_table_context *table_context =3D &smu->smu_table;
> +     void *user_od_table =3D table_context->user_overdrive_table;
> +     int ret =3D 0;
> +
> +     ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)u=
ser_od_table, true);
> +     if (ret)
> +             dev_err(smu->adev->dev, "Failed to import overdrive table!\=
n");
> +
> +     return ret;
> +}
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Cad0c1951c4f54d7a88c508d94dc1f9d6%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637626317788023084%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dtq=
9QDYaQmRxqBNRpFZgRQ0DPBSO6AI3YFN033RQUgOI%3D&amp;reserved=3D0

--_000_BL1PR12MB5349CA058BBDD4B180B143C597E59BL1PR12MB5349namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
Good one, that makes better use of flags.</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Friday, July 23, 2021 7:14:58 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Quan, Evan &lt;Evan.Quan=
@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.o=
rg&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH V2 1/2] drm/amd/pm: restore user customized OD s=
ettings properly for NV1x</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Public]<br>
<br>
Just curious that in the patch, it adds a variable *user_od* serving the ch=
eck of applying user customized OD setting. Instead of this, does it make s=
ense to use the *flag* in struct smu_user_dpm_profile for this? As we have =
below bit in pm/inc/amdgpu_smu.h,
 can we add another bit for OD restore? This will help unify the usage of *=
flag* in SMU.<br>
<br>
#define SMU_DPM_USER_PROFILE_RESTORE (1 &lt;&lt; 0)<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of La=
zar, Lijo<br>
Sent: Friday, July 23, 2021 6:09 PM<br>
To: Quan, Evan &lt;Evan.Quan@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: Re: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings=
 properly for NV1x<br>
<br>
The series looks good to me, though I prefer to use a common logic to resto=
re od settings so that smuv12,smuv13 gets the restore feature by default on=
ce they add the user table logic. Don't have strong argument for it unless =
Alex, Kenneth or others have some
 comments.<br>
<br>
Anyway, the series is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Lijo Lazar &lt;lijo=
.lazar@amd.com&gt;<br>
<br>
On 7/23/2021 2:39 PM, Evan Quan wrote:<br>
&gt; The customized OD settings can be divided into two parts: those <br>
&gt; committed ones and non-committed ones.<br>
&gt;&nbsp;&nbsp;&nbsp; - For those changes which had been fed to SMU before=
 S3/S4/Runpm<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend kicked, they are committed chang=
es. They should be properly<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; restored and fed to SMU on S3/S4/Runpm r=
esume.<br>
&gt;&nbsp;&nbsp;&nbsp; - For those non-committed changes, they are restored=
 only without feeding<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to SMU.<br>
&gt; <br>
&gt; Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
&gt; --<br>
&gt; v1-&gt;v2<br>
&gt;&nbsp;&nbsp;&nbsp; - better naming and logic revised for checking OD se=
tting <br>
&gt; update(Lijo)<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 8 +++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 9 +++<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; | =
55 +++++++++++++------<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbs=
p; | 25 +++++++++<br>
&gt;&nbsp;&nbsp; 5 files changed, 82 insertions(+), 17 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h <br>
&gt; b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; index 3e89852e4820..c2c201b8e3cf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
&gt; @@ -231,6 +231,7 @@ struct smu_user_dpm_profile {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t power_limit;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fan_speed_percent;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t user_od;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* user clock state informat=
ion */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_mask[SMU_CLK_CO=
UNT];<br>
&gt; @@ -352,6 +353,7 @@ struct smu_table_context<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *overdrive_=
table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *boot_overd=
rive_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *user_overdrive_table;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics_table_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_metric=
s_table;<br>
&gt; @@ -623,6 +625,12 @@ struct pptable_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_OD_DPM_TABLE_COMMAND=
 type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *input, uint32_t size);=
<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @restore_user_od_settings: Restore t=
he user customized<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OD settings on S3/S4/Run=
pm resume.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int (*restore_user_od_settings)(struct smu_c=
ontext *smu);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @get_clock_by_type_w=
ith_latency: Get the speed and latency of a clock<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; domain.<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h <br>
&gt; b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
&gt; index 385b2ea5379c..1e42aafbb9fd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h<br>
&gt; @@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct smu_context <=
br>
&gt; *smu);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; int smu_v11_0_set_light_sbr(struct smu_context *smu, bool =
enable);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +int smu_v11_0_restore_user_od_settings(struct smu_context *smu);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c <br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index ebe672142808..8ca7337ea5fc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct s=
mu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Restore user customized OD settings */<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;user_dpm_profile.user_od) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (smu-&gt;ppt_funcs-&gt;restore_user_od_settings) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu-&gt;ppt_fun=
cs-&gt;restore_user_od_settings(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to uplo=
ad customized OD settings\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable restore flag */<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profile.fla=
gs &amp;=3D ~SMU_DPM_USER_PROFILE_RESTORE;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c <br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; index 59ea59acfb00..d7722c229ddd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
&gt; @@ -2294,41 +2294,52 @@ static int navi10_set_default_od_settings(stru=
ct smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (OverDriveTable_t *)smu-&gt;smu_table.overdrive_table;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *boot_od_ta=
ble =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (OverDriveTable_t *)smu-&gt;smu_table.boot_overdrive_ta=
ble;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *user_od_table =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (OverDriveTable_t *)smu-&gt;smu_table.user_overdrive_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_=
OVERDRIVE, 0, (void *)od_table, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For S3/S4/Runpm resume, no need to s=
etup those overdrive tables again as<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - either they already ha=
ve the default OD settings got during cold bootup<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; - or they have some user=
 customized OD settings which cannot be overwritten<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;in_suspend)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_=
OVERDRIVE, 0, (void <br>
&gt; +*)boot_od_table, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to get overd=
rive table!\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!od_table-&gt;GfxclkVolt1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!boot_od_table-&gt;GfxclkVolt1) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;od_=
table-&gt;GfxclkVolt1,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table=
-&gt;GfxclkFreq1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;boo=
t_od_table-&gt;GfxclkVolt1,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_od_=
table-&gt;GfxclkFreq1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!od_table-&gt;GfxclkVolt2) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!boot_od_table-&gt;GfxclkVolt2) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;od_=
table-&gt;GfxclkVolt2,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table=
-&gt;GfxclkFreq2);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;boo=
t_od_table-&gt;GfxclkVolt2,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_od_=
table-&gt;GfxclkFreq2);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!od_table-&gt;GfxclkVolt3) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!boot_od_table-&gt;GfxclkVolt3) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D navi10_overdrive_get_gfx_clk_base_voltage(smu,<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;od_=
table-&gt;GfxclkVolt3,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table=
-&gt;GfxclkFreq3);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;boo=
t_od_table-&gt;GfxclkVolt3,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; boot_od_=
table-&gt;GfxclkFreq3);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memcpy(boot_od_table, od_table, sizeof(OverD=
riveTable_t));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; navi10_dump_od_table(smu, boot_od_table);<br=
>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; navi10_dump_od_table(smu, od_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memcpy(od_table, boot_od_table, sizeof(OverD=
riveTable_t));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memcpy(user_od_table, boot_od_table, sizeof(=
OverDriveTable_t));<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -2429,11 +2440,20 @@ static int navi10_od_edit_dpm_table(struct smu=
_context *smu, enum PP_OD_DPM_TABL<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memcpy(table_context-&gt;overdrive_table, table_context=
-&gt;boot_overdrive_table, sizeof(OverDriveTable_t));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_COMMIT_DPM_TABLE:=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; navi10_dump_od_table(smu, od_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_ta=
ble, true);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&g=
t;dev, &quot;Failed to import overdrive table!\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (memcmp(od_table, table_context-&gt;user_overdrive_table, sizeof(Ove=
rDriveTable_t))) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; navi10_dump_od_table(sm=
u, od_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_=
table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to impo=
rt overdrive table!\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(table_context-&g=
t;user_overdrive_table, od_table, sizeof(OverDriveTable_t));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profil=
e.user_od =3D true;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!memcmp(table_conte=
xt-&gt;user_overdrive_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;boot_ove=
rdrive_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(OverDriveTable_t)))=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profile.user_od =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_EDIT_VDDC_CURVE:<=
br>
&gt; @@ -3262,6 +3282,7 @@ static const struct pptable_funcs navi10_ppt_fun=
cs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_soft_freq_limited_range=
 =3D smu_v11_0_set_soft_freq_limited_range,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_od_settings =3D=
 navi10_set_default_od_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .od_edit_dpm_table =3D navi1=
0_od_edit_dpm_table,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .restore_user_od_settings =3D smu_v11_0_rest=
ore_user_od_settings,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .run_btc =3D navi10_run_btc,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_source =3D smu_v1=
1_0_set_power_source,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_feature_mask =3D smu=
_cmn_get_pp_feature_mask, diff --git <br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c <br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; index 0a5d46ac9ccd..7aa47dbba8d8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
&gt; @@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 -ENOMEM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto er=
r3_out;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu_table-&gt;user_overdrive_table =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kzalloc(tables[SMU_TABL=
E_OVERDRIVE].size, GFP_KERNEL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!smu_table-&gt;user_overdrive_table) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -ENOMEM;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err4_out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +err4_out:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;boot_overdrive_table);<b=
r>
&gt;&nbsp;&nbsp; err3_out:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;overdriv=
e_table);<br>
&gt;&nbsp;&nbsp; err2_out:<br>
&gt; @@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *smu_=
dpm =3D &amp;smu-&gt;smu_dpm;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;gpu_metr=
ics_table);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;user_overdrive_table);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;boot_ove=
rdrive_table);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;overdriv=
e_table);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;max_sust=
ainable_clocks);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;driver_p=
ptable);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;clocks_t=
able);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;gpu_metrics_ta=
ble =3D NULL;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;user_overdrive_table =3D NULL;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;boot_overdrive=
_table =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;overdrive_tabl=
e =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;max_sustainabl=
e_clocks =3D NULL; @@ -2101,3 +2113,16 @@ <br>
&gt; int smu_v11_0_deep_sleep_control(struct smu_context *smu,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +int smu_v11_0_restore_user_od_settings(struct smu_context *smu) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =3D =
&amp;smu-&gt;smu_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *user_od_table =3D table_context-&gt;us=
er_overdrive_table;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_update_table(smu, SMU_TABLE_=
OVERDRIVE, 0, (void *)user_od_table, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(smu-&gt;adev-&gt;dev, &quot;Failed to import overdrive table!\n=
&quot;);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +}<br>
&gt; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7Cad0c1951c4f54d7a88c508d94dc1f9d6%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637626317788023084%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3Dtq9QDYaQmRxqBNRpFZgRQ0DPBSO6AI3YFN033RQUgOI%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7Cad0c1951c4f54d7a88c508d94dc1f9d6%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637626317788023084%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3Dtq9QDYaQmRxqBNRpFZgRQ0DPBSO6AI3YFN033RQUgOI%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BL1PR12MB5349CA058BBDD4B180B143C597E59BL1PR12MB5349namp_--

--===============0004457146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0004457146==--
