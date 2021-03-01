Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E98C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 01:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44F664E0F
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 01:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44F664E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F48788161;
	Mon,  1 Mar 2021 01:42:30 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680041.outbound.protection.outlook.com [40.107.68.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C469388161
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 01:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKuJUdKFMB4JqhJcdS693cluuUH63bXSRXy+fm4oOZ5N7JueKuSTMz4rd7KEp3vB/JKSutA6Ef/Wot1ug9NtGdGujwUy1MCfo6gii2DXVwXCRfzJPSrY5spoL0OJwX6P5ZRF/lWHjGLfR8u8HvJwZfOa/KC+emVcpLNYBIpdXOPr1Tgp+7Y+EWrvFSJ+LlPQCfx8aJ8B3J6JowSoexrbzWZX5+dN1ZjBl0y9gW81M3z2DGTg/+3qzPpSiRQKk6CrBMIOMI83NEaF1bCL+/ExkpBCcyhjPSj1d076DkMuT5m2uNjHy9yBFOEkoXKmDkPptLRMDlYV/kii8lj3FEx3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO4895j55D4q/tQSRz5yKDA201ZLH9XnzRCRcvziros=;
 b=WI6ky7HRLlzTj/oOxRBETJ0GTzjdFUDOuf0nuA8WGaVWmg5Gr4Iywls/y0BxipJzD/MSDXEOYLUU07/i+tO4RM8XVwICRGGtuVBKYRoQjQ5DFAAcpcOFYLyWIZN9XnBuZtRMiU7+r6rHBs4ycHMheWQLjUyguoKO9xIo6EdTY54mXjmPq32ssnBlUxHoKiENVvPZ501OZ6yY+L/9amlv9fYcxuPhYASu5RUs5KaCzS6ExcBHHspZoRbC1jIPS9b+31T0mPXEykIc0Qe29hsVdUEGbeqvvJKoW7uYd8xe1nGUUkV2c/0WGiOQ8lkCiFXWYouIclw7Z5TCU+UVwm4kcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO4895j55D4q/tQSRz5yKDA201ZLH9XnzRCRcvziros=;
 b=HLIauaAW/1BJyrvewEhE6EBg8yIEH+cYSQV1lNXWc/RvvYoUOmilPSGPk1GfS8KYjlAKDTB5+IhTFQWfJCvhJD/Qd5O+SgcwZ72STULyO/jCiD0ozbegTYIuSGsN64jYWPuG+jcR99z22i85KZhH8Sk8dk5Q0mlp03tVykGdtFA=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 01:42:22 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 01:42:22 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Only check for S0ix if AMD_PMC is configured
Thread-Topic: [PATCH] drm/amdgpu: Only check for S0ix if AMD_PMC is configured
Thread-Index: AQHXDI60DyQaUF195kOR3dtOTPSqm6puXnaw
Date: Mon, 1 Mar 2021 01:42:21 +0000
Message-ID: <BYAPR12MB32387CB720F13C9F12443E2FFB9A9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210226222758.1454716-1-alexander.deucher@amd.com>
In-Reply-To: <20210226222758.1454716-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a396dab2-85a5-490a-953d-a853de576a02;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-01T01:39:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79e75412-bb20-4ac1-a81c-08d8dc534205
x-ms-traffictypediagnostic: BY5PR12MB4997:
x-ms-exchange-minimumurldomainage: lists.f#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB499773D78489604FC76D3EA1FB9A9@BY5PR12MB4997.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 51/XCfKpi9M5I2cNBXypM/AyXZ/ruU5FBIXoWD9BF93rvyKynbMRAtLB1pnoQ8ul4YD22ZfwJBC8V+B7beT2yKAjD2uEex24hsy8TPA+kJB+zRij9jdJLOuruZgLed8A8lSRxrCnX+4h3rFUSJU7dsZFcj0U3Kbe1emCaOvQ/8TVhE41hKIEp3DWVlmbaBFJfK7Q5P1J7ETme7jFMobDxcgHeWDucZwoATtn8E5cgxQR0oOxoXqlGIguYU2lnPr8TpUvECsx+97tBevQBgrIVbvwijS7u+f2G5V+G8uqSnmSvuErzugVjOJNfruKch9WM85Ip/6ku89K9CS0gFqkgpMTNQTyF093EGUeBr80ODgBF3jGEoHd1Cc5tQV1mmvOuQiX351V7yDeod2txbVG8FXM3/dpDgn/QiDTDNh9PyKTz1tmGtX3JQGPK+AuhTA48651JiutwwuQyoG8JKJchVVs64id+lo16TqRZV/cEj3x7weTgSOqIjZ7rqxBdnE672oYlkprzayOFDLiEujSUmEsejZgBEFppdQr3KKzOQe0SwnB8j+UHbKUhzzCbBxX3Wv9Qj/E7RnJ6B2zvirFBKGD6PneU75hQsSn0TeFEhnWYW758AgZiM506ste+SAyHyMgcAZa3mIvGZ7SHAojrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(66476007)(66556008)(7696005)(9686003)(83380400001)(66946007)(5660300002)(76116006)(478600001)(55016002)(66446008)(110136005)(8676002)(71200400001)(966005)(45080400002)(64756008)(186003)(8936002)(52536014)(316002)(33656002)(86362001)(2906002)(53546011)(26005)(4326008)(6506007)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IOXfGwE6h0zW6R0dFyK69lNtEtLmy7YlnIHJU1ny9O5JfSDxop5mnR2oCab7?=
 =?us-ascii?Q?SGR7JNVO6bU1ib4Olz8GGBoipUpyVcs5no03HIt9vAdCzNJKStNeV/OxAk0s?=
 =?us-ascii?Q?D0rZKj6nLX7ttjUsKDawCAIXhfUjZhNZlEvxHWbNb3l3jr/Z2ai0zgzBzWaK?=
 =?us-ascii?Q?kEAR4G3IY0anF0kf0ECW9lEyxSV9AD7sGI3MgpOb53urvPmtW/rte2JWRhrL?=
 =?us-ascii?Q?DYSHi8aHimzB1NMavMmDkwJ3J0NmgogL+/c2VjI5e2ITQo7HJwo34Y9/qCpP?=
 =?us-ascii?Q?Hxoc+NJWWbh0AVlcrewIYj0C2Q+T2m7jbBOR9Ouz4lvFaJmQ07Klek7z5Mav?=
 =?us-ascii?Q?6dkN9khniXZF1aaghWJesZvg+aY0puNLesv1xHtyUzADUv/I2Gb+f+wzPAXR?=
 =?us-ascii?Q?10XbAk2bVAN7wnFpSIgIDZ3iZ03vNmG6RSz6+bYuNlRjOHzGUXypzBX7Lkfs?=
 =?us-ascii?Q?UJMVdFghDIyxTmLVm4j36QuFWbWG7wXk/HLSrYZRIKVcKwwCGLscaN2dDbjN?=
 =?us-ascii?Q?BPgwEzzeLlrpHYi0Uphry4GVDzaqo3SWt/pZG+NfltROfYz+0j1O+4C1T+XI?=
 =?us-ascii?Q?EcEva59odRrC7sw5aQ6jxcjlesB3vlj1dr8PqQb260LeGHAuQ2+MOOphRp6T?=
 =?us-ascii?Q?Ga4ZQMgglsfwTQSFTVJVcbBJ4KOEL4S9aMKjTDi+4YDPbMinRDAJSINuNUx0?=
 =?us-ascii?Q?fZSxieRCOiRfT3rR1hnbt7TgBbwF3pintaM7TRD8WWxoHsY/wBQW3D1N6pMz?=
 =?us-ascii?Q?X7ckJ8J9vXwGx7OTscbGIbLdlwwsthnLD44X7Jxy3ua1h1SEGQ7KUYJYYJgu?=
 =?us-ascii?Q?UeszGrKXSPmUIlsd5vCymJlNCnyy+lz7O5CJ8gBJ6b4yPTE/1eM/K4xdDR7t?=
 =?us-ascii?Q?jNeX4WnrzKqc1Qhid4JkYF3EsbhToMqCPkopqb29cPTSQTVoJFbjI0ZJGR5i?=
 =?us-ascii?Q?SXUPCW0Rdtd+Lai8ssvHgV18CgpguvJseqV0UT8ix9LmQGuWXAVe9R1KVVS+?=
 =?us-ascii?Q?GpyK6Ai1iMozLUuHq6hz+7OWKmkRfuthj9UEdBS1TR9k36QFdz8VFyaI17a6?=
 =?us-ascii?Q?eK9iSQ+TBPUSSA/N8fWF3fiChSsON4zze+n1mPgkjfGYv0I0MHqv2Uwff9JZ?=
 =?us-ascii?Q?gLjVD8y/l2qH8fVzLxe1Xhdt2BdmbNFezmi0UiIEXweOrI6NiCKUxskBpSEC?=
 =?us-ascii?Q?WNC40JwCfKTlbJa58Lzh+cX3/bDdmsIOdWgJP4in+BnDC4nTnb0FW40+HT1h?=
 =?us-ascii?Q?c56tep2RcfpNoFY4YRb1B241oy2IOdr5aQxUyPU5vH+CXzIkyXS3Ni+xrVS1?=
 =?us-ascii?Q?LarBbwt6IzuRcURXNOiMw8hm?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e75412-bb20-4ac1-a81c-08d8dc534205
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 01:42:21.9889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdP4mDuD/QAE6wCl0ZA0Mlr4cpv7VrBy9O+c4MyriIi7qmYup2Z4aFZCo7Fk2HXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, February 27, 2021 6:28 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: Only check for S0ix if AMD_PMC is configured
>
> The S0ix check only makes sense if the AMD PMC driver is present.  We need
> to use the legacy S3 pathes when the PMC driver is not present.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 8155c54392c8..36a741d63ddc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -903,10 +903,11 @@ void amdgpu_acpi_fini(struct amdgpu_device
> *adev)
>   */
>  bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)  {
> +#if defined(CONFIG_AMD_PMC)
>  if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
>  if (adev->flags & AMD_IS_APU)
>  return true;
>  }
> -
> +#endif
>  return false;
>  }
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7Cfe79a895d34a4d25
> 47cc08d8daa5d4d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
> C637499753082442990%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd
> ata=LKHdOptexAF4NF%2F7nhMyjvh7rGcQN%2FnpTQS7yKT%2FAPM%3D&am
> p;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
