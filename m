Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B76C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 03:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB97D10ED7D;
	Thu, 27 Jan 2022 03:45:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE7EC10ED7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 03:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/TklfOz+aLHjt27gX+9Zicco328m81GjIjew0otAFzb9pSMu+gpDn/qkr0oMEkia7F1e1UsoNNWAzzML03yONNQh0H7efpzlbxdfzreNJEeSlXMet6ALfEG8Q5+iFCtYEaIQiwIn64bO0O7eBdCFa18XRrOS0kR9CvScl2msMoJ+Vr38bTsoy42E+qIJ6GLsxk2kcscFDrDtKKrPCyypaV+Fj7q9Ddfhx9hbWdvPrcLfRK26giB3Z8TNlex8JJiecePIzbJIL4QAJ9a/7QRJjwuUX5gpeaR8gzLHhJVn9ORIoYEnSjjWeEcEumwJ4qErbmgJTB/PugA/lw2yYJofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA1GcJ43FTapqywfITgal7HQYpT4BcVOHbpEAC6J3gM=;
 b=cVYdcrx1w5GSuWfbHTVN9C0AeKzsTHWuTH0Ve/s79uHlnnXX9xK01kaEUDftcrgGKcohSJtTlccAgnhQdOdeSNW6yju4PI4xyN6ve4u1zj/aX2CmbGsU9XzjcnMgBgGhb0aTYcglV4ns7LaQ7cU1FGSp8rehWAJWeBXjZt4v571B16JF3High3Lnu+PcfKGtqi2qxIUV5UbJ6O9F5Hh9TpK7IqSLgso42HJyXXScjxDWksgYs/GZj9Pvwq3DcZYSei0x4VeUvnv6aum+obQwGciYEl2QfT1FlgC/1NEqQPsskRGK4pw8sQnHqqPO3rYkwNYwHTa3CBbblclfDNUjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA1GcJ43FTapqywfITgal7HQYpT4BcVOHbpEAC6J3gM=;
 b=Usx7HA/WzvagWWJfd1i9X5rfmnv0XVOSV+OqcwD1/H51VIkRvuxW6li2nMzNnGEFxvc0ezqNsJL4qesxIsi1oYSTY/Ip/2UwAPsGcA/vBhBd9/cXFkRIhH08vHLKXFcIILP81Q7s5aGR1yiAkKlLQw8POcw+7T9VGI9LV++7yoE=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 27 Jan
 2022 03:45:15 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 03:45:15 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Fix unused variable warning
Thread-Topic: [PATCH] drm/amd/display: Fix unused variable warning
Thread-Index: AQHYEy7TTtM8k2HmzEKY1if6zvdyo6x2OifA
Date: Thu, 27 Jan 2022 03:45:14 +0000
Message-ID: <BL1PR12MB5237A6B4BCC1CDC4C0DF006BF0219@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220127033350.2550086-1-tim.huang@amd.com>
In-Reply-To: <20220127033350.2550086-1-tim.huang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-27T03:45:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3205d35c-d572-4773-8091-f89012876593;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-27T03:45:11Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 620abf0f-8b6e-4dd6-8b72-83a203e70dd5
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8a46134-f2b6-4fa1-51f6-08d9e1476dcf
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3873B9780F562A0BA25F148EF0219@BY5PR12MB3873.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWrqzMeSfAaoNq9Y+tfeM4DbVMsMsREErRcZ96hXfmXQUGW9CcC4ff8b7wvxFuUFaUA6ZDdXMwlQlWXWqbAerkOsWbvQpVsRjTyxZvikfNXNYWcarzYchAPbifBZSrO/XIg/sXXQilykSaqJm6IkilPFy6h5BbII/KZ67xoOLsHIAj26TYQWEV8UK0zYJTk4ksiGpmho93qJMMXlLvK9gL1SUu9JgE8/P1HEXZCkGx8zwOBCviwJfWrT7p1eigtpsN5s/RPRShrLSoiPE4Q/CBKfBVI6UU9OJR3opWmgyUC4LRONt7MELD0MUPCZtCQLo4BgyG7S7i/fNrhGTTyPx16nJdMGSPt4IWVSEOqNXEPYPLxLY/dCSbComIhmPYco37e2bJhQWbl0pl93ZnC7o/x+mlcvGgZmcuRIa5OSQKJ8f/wpcTbP3HsZFC04Bz+yt47bcZNv69p2o4ga+tyEEaCL4mR+LmvgkalK/fgj2GNzMEIIjwOYJPW3y4YeZajgEwCnnX0peRj4EInmZE/LmJkWQoRGRs9pFzPNa6By330xZ4uXI0i1gwLsMEIZrVDl65/kT7XkTOc6/zsEvgNE6nl3xcalhq/zlU1QSa8M97+7+SLOG6Bpl2quQoPRGTBIQqCqMhmVaiT9MRfKANEkhA1BFpnMmI53jDoUQeEIroh13/EY5p1/W0oT26aCbviSUqxeYrndRn33tf7CBYXUWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(9686003)(33656002)(38070700005)(66446008)(8936002)(55016003)(66476007)(64756008)(66556008)(2906002)(66946007)(71200400001)(86362001)(508600001)(122000001)(38100700002)(76116006)(5660300002)(4326008)(52536014)(7696005)(83380400001)(6506007)(54906003)(8676002)(316002)(110136005)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EwEkdRVVXXlw0l2e/upoprLjngN9Ur216iwbRZvV9js2OpQYQe6tYYrzC33l?=
 =?us-ascii?Q?yncwa3Xi86B0Dga7bRafynBexvelwL1w047tGONn9QQJBio/RV388nuOol5H?=
 =?us-ascii?Q?azNwIZszrFeefyGkCLs5keOF+wgecOLh7iQqZQYwWMx12si0zhA23kKTBpBI?=
 =?us-ascii?Q?CbBlbQJUh+qHe2+6DbVAjulbyApvSmcJvYtuDF3/T837EkFzqDyKfQaKWpt4?=
 =?us-ascii?Q?Wes/8RwfOMiGWgpETW0V8N/wx6PDktNfBHy9aY5gG9CVEU3TdqRGCeDE5rRk?=
 =?us-ascii?Q?PDkyAHt2iEjGE+SyEpNHP2N/4SfMYHZN8V6EYhbhg0SKu1gwQIXCj0SaYbFW?=
 =?us-ascii?Q?GnlvB1vVk0fho/+Eq/Ix+N1WKXjBGw0puZWG/kERzR2rULbSEre+/63ehvyt?=
 =?us-ascii?Q?DF9uTdVZuOTLcl3XQASHllA2LqAOZjBCuExC3Pib00SYEr3WIWgVdhe65Yrz?=
 =?us-ascii?Q?PcWcUt0N2MONlF0AsG8yYfPsWyvNkpgrhZ2vXEzBKg+GBwuN3doJBJWqyuNU?=
 =?us-ascii?Q?5LqIzk3EGlM7AtHdSoOOy/pdCIqukL7pUcKEKT81RF5JXlwmP6BJdrh3FV94?=
 =?us-ascii?Q?cwEiup5SFaffHKZNj9ibukc7N/Chx7zrbBYIt9zWZAAad4RRL1Q9KLGLCIiH?=
 =?us-ascii?Q?LRYy6ViWdobBxHUsUFVnoznjgY8u60enudDnej2cSHnoZgHfga2r94s10qkG?=
 =?us-ascii?Q?+QVXNHbZPnvqvaXaoDjy21u+4t7QXZZ8I53DnDDdTvO1CTEmJJX9z16UhHAD?=
 =?us-ascii?Q?GbHShmH65r5TvXLsFG1gmaM0xcCTLxh06lRO3bHlmkMJA2VZJOrWwhEkTPYn?=
 =?us-ascii?Q?jZu1ClOpMO0rfKSXMuH8SIJEaXta4384tLWu7/b8yC/qXZuoibCDz3SVttvM?=
 =?us-ascii?Q?W9fjyyzletjzaNHfCNesFv2M2R22S68maLgnpvIZVIFagfBlCvsrRWVaMm5r?=
 =?us-ascii?Q?VBmOxjGnahcdmCnlXBzlkEm+EfmpnVtLr/eoVbK0IEfNzs36UYCtOKPo/z5D?=
 =?us-ascii?Q?3exJd8SatM3ZgZSrz0VoxZwYvlLPsS4YyE9gvuqxS9/M9FL3PS7J66kGL+AG?=
 =?us-ascii?Q?N26dOWR9jN7bueStVH4ZzK4YBUk5ELBrF3va+dSR57jfCpZAiy1YwG5r8aT/?=
 =?us-ascii?Q?ILs4gkaxopnhZHdvI6/viLxvEAjUltnmGB40CeOGmkAV4XnziKvqg0UeWoEB?=
 =?us-ascii?Q?MSw9fcH7Z8dElNuXeHi7XjYSQhoMMbKUTOb2oFFV1KXLQunuh7Qo4K2XbZ4e?=
 =?us-ascii?Q?tqBsVvuAKdP1EQN1hamDF0ReSBzVG39UxjTOc/cNuU/9NxI2QI/BZs7718NX?=
 =?us-ascii?Q?KBzLCGmsQNzVTVowFVU9w+noci5zwKcuTUg8n7nsKX7qBO2yjxu2g87hqNg7?=
 =?us-ascii?Q?aYAm10qZ+mPeexxpeqchKOvqZcm+FFLadFZFd35RDEekZSc29UAXWbUHAcBP?=
 =?us-ascii?Q?+L4/HJ+g3+zlRSCY4J3hSO5KeBTF/snkashB0l+TPpDTuNQySVTh0qYVqlqu?=
 =?us-ascii?Q?/ldI1jRfxiAgefzITkpPCd/Umn2b1QLUzw1cJMIdKbXlehMfcEMwCb5uztfV?=
 =?us-ascii?Q?5fJzwZub30OecVHvY9s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a46134-f2b6-4fa1-51f6-08d9e1476dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 03:45:14.9304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPaCPLeQQc6BnX+66+hDrpVhMsr1euXS/EBvLv9CSs3olf7w6BkTS2MAUU2/OMsj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3873
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Thursday, January 27, 2022 11:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
> <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Huang, Tim
> <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amd/display: Fix unused variable warning
>=20
> [Why]
> It will build failed with unused variable 'dc' with '-Werror=3Dunused-
> variable'enabled when CONFIG_DRM_AMD_DC_DCN is not defined.
>=20
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1057f976bec7..8f53c9f6b267 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1027,7 +1027,6 @@ static int dm_dmub_hw_init(struct
> amdgpu_device *adev)
>  	const unsigned char *fw_inst_const, *fw_bss_data;
>  	uint32_t i, fw_inst_const_size, fw_bss_data_size;
>  	bool has_hw_support;
> -	struct dc *dc =3D adev->dm.dc;
>=20
>  	if (!dmub_srv)
>  		/* DMUB isn't supported on the ASIC. */ @@ -1123,7 +1122,7
> @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>  	case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */
>  		hw_params.dpia_supported =3D true;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> -		hw_params.disable_dpia =3D dc-
> >debug.dpia_debug.bits.disable_dpia;
> +		hw_params.disable_dpia =3D
> +adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
>  #endif
>  		break;
>  	default:
> --
> 2.25.1
