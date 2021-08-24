Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF4BC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC6B6127B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEC6B6127B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B86189BA9;
	Tue, 24 Aug 2021 12:54:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 917C589BA9
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 12:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZJmQxPitoIVpMZsmeZmpt3DozhsgEHK29qyuOJTwWNfaq/H7HykE40E+hUZnRXuBF/l+nCPffbJ2Nrp5uhBBoG7A22BKuM/re9TOHJ6DflGquNM29fqQmC7KntUshzkBG5hVoW6owVkwFHzFJX/MFwfPJ66gAp+1uxGBURbd9hcI7VEONXc6tOxszeH8QVxGT736IfB45pVJObMLNkjaZ5mCyWTsJKmlicTL7kZSpPob4CQ9HPX51bM4gEfBW+DieSCRorWO62uKeZUZW3gMeuc/UxAy5WJLdN0ss26DI97lP9g33aY1X7J8MxSyvz/yhJ/pp8AfoPwHZK0LLMrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxgf4rZq3IXmlTODER0enjLRMU+X7W3oGtArDcXEddI=;
 b=Tv2jzPrc6tyt+hO3NS4ouxldRNPV1HI6u6VAY3k3pOfu8Q660OEWIpt30NF3SEu3HVPudmOjtML5XHMYnvas7RcS74k0oD0JxxlXi5WHOJhXaTpKXKmtg/vWpmLAnCH6b1ioYaKVGmybLhsKO8BS/A3KF0NmV/gcv0kdEuHwWMeUue7iIIGtz/K7Erj3PJnD5qPpz0ahligR5GBe9dtDpMnKuUwWIxbMlaCjv7a/MoQx4CWWADuyJrOieaLmqExhbIcETLeiavSsREFLKUr2bzYy+0r5QLU6gmqsXSd2asuyambiwFoSOEioWLxfX0SeTEiYrGOqOpBbnPlC/rHJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxgf4rZq3IXmlTODER0enjLRMU+X7W3oGtArDcXEddI=;
 b=FtfPQsl2jdK8sFWxt2S1GaV2kEu1E1ITV8pFmehzjA60q2FTru/IpdECKNYTLlBQIH0xFNBl6JIBUbqFDEU8Vs4iBrWimUXh88qwHVhQdWWXBH702YwbPjsGRVlE5fpqP32GWdZ4z4ToUyH+hjhzu8L3jDpq934QlRFNp98meKw=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 12:53:59 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::545:e133:60d8:d646]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::545:e133:60d8:d646%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 12:53:59 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Keely, Sean" <Sean.Keely@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Keely, Sean" <Sean.Keely@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Account for SH/SE count when setting up cu
 masks.
Thread-Topic: [PATCH v2] drm/amdkfd: Account for SH/SE count when setting up
 cu masks.
Thread-Index: AQHXmIA1rsr2nn5wlk6jGfKYbfcZ16uCnD/w
Date: Tue, 24 Aug 2021 12:53:59 +0000
Message-ID: <DM6PR12MB33245E6641A4E2EF152EC5F685C59@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20210824003658.84092-1-Sean.Keely@amd.com>
In-Reply-To: <20210824003658.84092-1-Sean.Keely@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-24T12:53:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b8dbb8a0-792f-48b6-8689-4559da78c981;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7761d828-61dc-44d7-f231-08d966fe3dc6
x-ms-traffictypediagnostic: DM6PR12MB4169:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4169AE7DB34A4E782F2A351D85C59@DM6PR12MB4169.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3JqSFuHlcVWPdzzJBzqC2MX1pHOOZvWxUOeuJNetkW2JmiaqxJ8Nvf/9x2L82z7QQE0GSNtXmtDGAb3wqA/VT2VIzPPN2EkUseNQTPXXITD82uCG+i2CxGTvnSa5vWOsKOWcpxhscwLgucC3+zYJIwJYNoT3vMIrvL7IMuBQ3fQvQkJCE2lFM4aKnJT2ZOhrx4hgZBSTP+ZKPs2YsZ5OL/HYNGGHsgoMgjeYDayasao25ql85JR7lhqE/in1YijH32h8NUiHS+SRrilgaO6xGI93+/C3WcToDb92r58VCBHLKMXnTbg1pOAkKG0+PH0kh3yCTr+hE73rIqdD7v/UI1VGUrDWEqROa8+PXq0VvPEU67sHTQhH4ssIXkpu4vr7y/l0OgE+kqGX1Drrw5xteoTbKZhuh+xulcwKNMh0Q0uvCYodJsiTO6GrKX89radFpsAxPTCtZdsBj/BiT35lkNglxHTCMm6qCFH7qV87W0gM24DPOdlPyrmoSuFgtel+9rop6WJmQkRHT53mf/4Al73ELdX8pashwisRYSaunAJnAi5PSnQK3qam6bdDLqX2/doHBhlDjuXRColJenuSTCTz7UVS6OWCSXZGFN39h/DY3AYVmrbogCS87xqdBEC1UzKnxApBNYoPwoEnfkR/ZDJV/rnlTxmrZ/4qta0YPGsHUG0Gpy/D6cE1qIxFgqjl3e9pry2R9QkO7OtW1fMGeg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(71200400001)(66476007)(478600001)(110136005)(64756008)(66556008)(66446008)(15650500001)(8676002)(33656002)(7696005)(316002)(76116006)(5660300002)(8936002)(6506007)(86362001)(38100700002)(55016002)(4326008)(66946007)(53546011)(9686003)(83380400001)(52536014)(122000001)(2906002)(38070700005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rQ0ZjuP93sf4u8wptoJaLDE6ex53+IPR+trS3mkG4vCIIGiQw1uZKt5bRElT?=
 =?us-ascii?Q?Z2ZPJqgEIUE3rT00KsB0aSD3jRIL+4+zx417iJiI1NeBSrVJJ7rvcsqnzR23?=
 =?us-ascii?Q?2a+hHmamSZDazTvddNrqFgb5IlptPJQv76Cc2y5z2Td0bo6Rs3GrcxL6pseY?=
 =?us-ascii?Q?0oC1gKmdsEkAsf8JQ8jiJjlJhFcIxawKFH88Ixkg4EzVH3aP0UNfUtgO53x6?=
 =?us-ascii?Q?s1NVTR5izq674Ge+LfTGBBu64juUEm56RE03WOguwhbKN+cr2dXxCfyUMXG5?=
 =?us-ascii?Q?Z3dsM1z7Fx3o3YQYK/tTM2b7nH5I63F0GX3CnhAFHbwXrUWmaWb4YX2wUC8G?=
 =?us-ascii?Q?izOizorzzSHqbzdgNFQIE7gKLLgHtnaB/IYwBRh5VO3c3dKze9ZUcSUrCiLN?=
 =?us-ascii?Q?IxANXti2MXZcIE1TA0utvkoXxdhRwGHpuP7d/0+WHlsfgX/lLN77wzlecdAQ?=
 =?us-ascii?Q?VDUjGiI3ZMQH6GpqabF1ka8G7X+V8fwu2OQYvavfa/80ijx1V+86nD/I+qbn?=
 =?us-ascii?Q?gIjqCIF7yEZI4pcZALb9QuAjMNtMGNmeI2RzOUzN7GT+rbgQ4ZZnFecT3hk6?=
 =?us-ascii?Q?RDw5hKKtEYQC+Pa84hM86lpdk0M8A76nSTsK8Yct+biHVOLN6e8oIM5wbWQo?=
 =?us-ascii?Q?Jk81/E746RftcG6yZpaAX6iubvNUowJVaYGJ2fudFpO5ObQLtTAuW98ShnIb?=
 =?us-ascii?Q?/37Q64XbTkINXbElFSdpDjkQtU4h0s9kIKn5RAP5mVIq3S3veBWXo5ZbVMie?=
 =?us-ascii?Q?si2oVEo8LHJFt4uzbgy8jplu8Idb5erGl1x4wVE9gD7DRnXYDFXYrR11bkKg?=
 =?us-ascii?Q?9X+JLfFyPs75wLyFl7mgGyw16pHtSk1LuaHNXu32lUSP3T7ViM3znU50yhoH?=
 =?us-ascii?Q?e8hI0T++3dxVjAE+gBrQap7k6Vcgp0ipWYVbuZ7wu+I83m38QUJSk1MCUqma?=
 =?us-ascii?Q?yhLTJDNB34ag73ccKdtnnVNDOJmw4GSUu5RcRxL3x6/ky9qivr78iFMSyWFc?=
 =?us-ascii?Q?uvxvhx2CjMoDmUGWnRIbw0ix2nsLubiacjviF0ySLWGQlaMICL/2Mt84PkU/?=
 =?us-ascii?Q?m5HJlCrvyul3/30WbPK5+tpF0nypLDWpoerK3ZUbcxzxyyDmXEaezOOIzdMj?=
 =?us-ascii?Q?p7Im/GYGoBLNU95/nacIrrkULjGqwZE5eHyA4RQ5QK7/PWcXgVhSoHq9Up0Y?=
 =?us-ascii?Q?24nsfmI79a/9RaVOiINh78Ogxv64+doxp+Nlt6Db3PFS0TsFrAPE/jlej48I?=
 =?us-ascii?Q?MIenrfiwYU5Sr1Rk1T/FeTLmw4sDO2ZRsBPcm8Tj+hcjj+k8glFpVhS4VOzR?=
 =?us-ascii?Q?ldnT+HRGIgDnkFkwbZsvqcjz97hOsncYPyYhyElCxiXrqfcIZxqaHOIz29AQ?=
 =?us-ascii?Q?smdo8xhxGHRO6dvWhCd6gHJeIKtS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7761d828-61dc-44d7-f231-08d966fe3dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 12:53:59.3390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6crHPzvqKhvFUgYi8/jvvUFgP8RWrAdd6r5EpXp43Nxt91AhazDXqtzRXzoSIcOCwn8aBqeGq+AbQe5zFdV/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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

Minor comment inline

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sean K=
eely
> Sent: Monday, August 23, 2021 8:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Keely, Sean <Sean.Keely@amd.com>
> Subject: [PATCH v2] drm/amdkfd: Account for SH/SE count when setting up c=
u masks.
>=20
> On systems with multiple SH per SE compute_static_thread_mgmt_se#
> is split into independent masks, one for each SH, in the upper and
> lower 16 bits.  We need to detect this and apply cu masking to each
> SH.  The cu mask bits are assigned first to each SE, then to
> alternate SHs, then finally to higher CU id.  This ensures that
> the maximum number of SPIs are engaged as early as possible while
> balancing CU assignment to each SH.
>=20
> v2: Use max SH/SE rather than max SH in cu_per_sh.
>=20
> Signed-off-by: Sean Keely <Sean.Keely@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c | 79 ++++++++++++++------
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h |  1 +
>  2 files changed, 59 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 88813dad731f..5d7016928d24 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -98,36 +98,73 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager
> *mm,
>  		uint32_t *se_mask)
>  {
>  	struct kfd_cu_info cu_info;
> -	uint32_t cu_per_se[KFD_MAX_NUM_SE] =3D {0};
> -	int i, se, sh, cu =3D 0;
> -
> +	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] =3D {0};
> +	int i, se, sh, cu;
>  	amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);
>=20
>  	if (cu_mask_count > cu_info.cu_active_number)
>  		cu_mask_count =3D cu_info.cu_active_number;
>=20
> +	// Exceeding these bounds corrupts the stack and indicates a coding err=
or.
> +	// Returning with no CU's enabled will hang the queue, which should be
> +	// attention grabbing.

For consistency (and for kernel style), these comments should also use /* *=
/

 Kent

> +	if (cu_info.num_shader_engines > KFD_MAX_NUM_SE) {
> +		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
> cu_info.num_shader_engines);
> +		return;
> +	}
> +	if (cu_info.num_shader_arrays_per_engine > KFD_MAX_NUM_SH_PER_SE) {
> +		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
> +			cu_info.num_shader_arrays_per_engine *
> cu_info.num_shader_engines);
> +		return;
> +	}
> +
> +	/* Count active CUs per SH.
> +	 *
> +	 * Some CUs in an SH may be disabled.	HW expects disabled CUs to be
> +	 * represented in the high bits of each SH's enable mask (the upper and=
 lower
> +	 * 16 bits of se_mask) and will take care of the actual distribution of
> +	 * disabled CUs within each SH automatically.
> +	 * Each half of se_mask must be filled compactly, LSB first.
> +	 *
> +	 * See note on Arcturus cu_bitmap layout in gfx_v9_0_get_cu_info.
> +	 */
>  	for (se =3D 0; se < cu_info.num_shader_engines; se++)
>  		for (sh =3D 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
> -			cu_per_se[se] +=3D hweight32(cu_info.cu_bitmap[se % 4][sh + (se /
> 4)]);
> -
> -	/* Symmetrically map cu_mask to all SEs:
> -	 * cu_mask[0] bit0 -> se_mask[0] bit0;
> -	 * cu_mask[0] bit1 -> se_mask[1] bit0;
> -	 * ... (if # SE is 4)
> -	 * cu_mask[0] bit4 -> se_mask[0] bit1;
> +			cu_per_sh[se][sh] =3D hweight32(cu_info.cu_bitmap[se % 4][sh + (se /
> 4)]);
> +
> +	/* Symmetrically map cu_mask to all SEs & SHs:
> +	 * se_mask programs up to 2 SH in the upper and lower 16 bits.
> +	 *
> +	 * Examples
> +	 * Assuming 1 SH/SE, 4 SEs:
> +	 * cu_mask[0] bit0 -> se_mask[0] bit0
> +	 * cu_mask[0] bit1 -> se_mask[1] bit0
> +	 * ...
> +	 * cu_mask[0] bit4 -> se_mask[0] bit1
> +	 * ...
> +	 *
> +	 * Assuming 2 SH/SE, 4 SEs
> +	 * cu_mask[0] bit0 -> se_mask[0] bit0 (SE0,SH0,CU0)
> +	 * cu_mask[0] bit1 -> se_mask[1] bit0 (SE1,SH0,CU0)
> +	 * ...
> +	 * cu_mask[0] bit4 -> se_mask[0] bit16 (SE0,SH1,CU0)
> +	 * cu_mask[0] bit5 -> se_mask[1] bit16 (SE1,SH1,CU0)
> +	 * ...
> +	 * cu_mask[0] bit8 -> se_mask[0] bit1 (SE0,SH0,CU1)
>  	 * ...
>  	 */
> -	se =3D 0;
> -	for (i =3D 0; i < cu_mask_count; i++) {
> -		if (cu_mask[i / 32] & (1 << (i % 32)))
> -			se_mask[se] |=3D 1 << cu;
> -
> -		do {
> -			se++;
> -			if (se =3D=3D cu_info.num_shader_engines) {
> -				se =3D 0;
> -				cu++;
> +	i =3D 0;
> +	for (cu =3D 0; cu < 16; cu++) {
> +		for (sh =3D 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
> +			for (se =3D 0; se < cu_info.num_shader_engines; se++) {
> +				if ((cu_mask[i / 32] & (1 << (i % 32))) &&
> +					(cu_per_sh[se][sh] > cu)) {
> +					se_mask[se] |=3D 1 << (cu + sh * 16);
> +					i++;
> +					if (i =3D=3D cu_mask_count)
> +						return;
> +				}
>  			}
> -		} while (cu >=3D cu_per_se[se] && cu < 32);
> +		}
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index b5e2ea7550d4..6e6918ccedfd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -27,6 +27,7 @@
>  #include "kfd_priv.h"
>=20
>  #define KFD_MAX_NUM_SE 8
> +#define KFD_MAX_NUM_SH_PER_SE 2
>=20
>  /**
>   * struct mqd_manager
> --
> 2.25.1
