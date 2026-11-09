Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE798606A332
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qWNZqQoB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89AD410F403;
	Mon,  9 Nov 2026 16:03:29 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE09B10F3FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 16:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP08VdEtwH+Wx1b/YYCGouMUfXrjNhrur9wayM15itboip9TgArdiyNAVCWU1auSez2GBPwV5qNctvUasbT0PwOkZ7de/oNHyIvLi6Krq/tb+7SgNyDeBd7CdcTUz+agPyMdayji5avgB37ItbE4GinloLK588WksFoaS64nhXxdjriKMTPmN4j+RbSOxoCtJ4IyNKzqiZ8FJPu71+rShQQslRzyqaJyQvHIIB/v7525JrPe7Lu+Fc0l0VcahosIVd7emP05goB+aC5qC8TMOxZVMrEAWa9NG+O5ef34zDrzwIW0g0l8bikI3fm+CpsMxQPWFFEr8ewRfvNmBxpKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVINA7QqWzKGlrcbBf4fIqr9GzMfFxt2vU33hXw5Wp4=;
 b=GRsbvxkuwkvbAwsmmmFw1iulfe5OW0RIscAyk3HCQZtgjEIf8ZaLBVhMtny5aw2CdmUEYvjde/V0l0AEpcu56NV7a5UK+LlHg5wnzWAs/lrAdCDJG3H6FSOjOEVbtwsuteMfVcuv+wPlsEZBcGWWVFbmSYa7r9445TdbLX3dXseVzy0G6B1aFh9WAjJXJX9bJKSs4XJpAivy+dobL6tsJB/zWWMvCAbyJdziWP2XgUmWHInEorWIuZtXnGFVT1Ims+kyyP/uaCRDuTHraGZJXkch24ITi8Uy49/mPQzOBnOM/YqphiEpmo8FN86/j9NYgLIHpS80BqCj+11cLTtd9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVINA7QqWzKGlrcbBf4fIqr9GzMfFxt2vU33hXw5Wp4=;
 b=qWNZqQoBJWqmTyvAp65+lymb7cvDGD/OOio6KjnsHvWnT2Z+XqlgsesZjhl5MJyp6fHL4/gAKeMf0CeHropd/WP+p8tXWxxsjxWILyFRsk/hzKoujL0pXR25ygGSkIPqk7VJVms7FvQLxthitIk1IJHpTQaUFPPbZznRuedIf+w=
Received: from PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 16:02:55 +0000
Received: from PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069]) by PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069%4]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 16:02:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Six, Lancelot" <Lancelot.Six@amd.com>, "Samoylov, Alexander"
 <Alexander.Samoylov@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Add pci_domain to struct
 kfd_dbg_device_info_entry
Thread-Topic: [PATCH v2] drm/amdgpu: Add pci_domain to struct
 kfd_dbg_device_info_entry
Thread-Index: AQHdT05CT7cJ+p26mESjFc6wiSgllLcmKLzA
Date: Mon, 9 Nov 2026 16:02:54 +0000
Message-ID: <PH7PR12MB6812C7E862716A869A9D73ECF7732@PH7PR12MB6812.namprd12.prod.outlook.com>
References: <20260928133511.155752-1-lancelot.six@amd.com>
In-Reply-To: <20260928133511.155752-1-lancelot.six@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-09T16:02:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6812:EE_|PH8PR12MB7254:EE_
x-ms-office365-filtering-correlation-id: 9fae1cab-3a2a-4d9f-68af-08df3e7aea60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: r+XD7gPsiJ4QCRWMRhejYuMhcN8nHWcUbu8TtehIrFwErD/4y7/mbTPE1MMz+uZa5n67z7VYvYbKaRr8cixsE4CP6Ch+NPrxOzpVBq6MQwzhn1LK3ZfSe6dkSgqm+Ci/TstzSiRvFvK2HWl/kbPHDj1h29UltJrSXVtSOwQu+/eCcDvbfqodKYvTVChMNlt0RS4ui5EmQeXUc0bklwJL1q1Fssr6pWl1gJO4o20+xI14UR5XilVjdeKXvtI7H6bfo6XtRcvm9i9Ik7Jj95+uFcehSpdA8r9BeqS79CGMXEWVK+55YkzbE3pteOfNi9GNeaHREXdfsQmYrksf5N3cU2HI0H4MFGk6MgKE+pUKQQ2r8vQeaCuZlRUt2LjhlFgAhc/uWdC0oQHl1TO8ztcOIQKl1B0tPc4b6oNKXJRRLHnOBBHWBPqaK778cSos2nvBrPpmqVoiT5ZJKzM/weHVLHicaj+t+hxUxrO3rFybgn+xvPGQkdJtVobzvLRj/+USGXGVyLORbkto/dUxbvljP/YWug7+pkfJON3sXqeKF3DU/sE4EydCtEBbEo0MrPmgGrDyzqIhdoOYqgZ6zb/pTUokP8H8HjNTltOlf5NhTk6PEWjbsCrnYKdOgKRJ06Qdovy3sLHKsQaQOc0x28ThzMK8XvmET7KSEk6xvzJ7kxcXD032rzs8rQJJbWf3MzMG+JAP+6Oa8dxMkfM9TObegmd6QKgYm9wnfgTkBu9LKDE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NIAO7g0xD/BptGlQYY+XiVVZqaFbO1wC+iAmSqxtTCTrqudYxmyD8QgxI9Yb?=
 =?us-ascii?Q?bKgOKAycdg8AmFKusrzE/2aO1pauX+y37INn5m26HhJhYUlc6T9ZuR1vEWHE?=
 =?us-ascii?Q?igzEYnQSTYmyvzJryMt333qlfHbCwiCxrIU0ulfjsiFqKaVIiogRSBSybq3H?=
 =?us-ascii?Q?qwrZzaExaoc0TtKM8n1fI1voPOcErsbFSF692guvEKuqJUc6ClgbkwImUaca?=
 =?us-ascii?Q?fleiVZdo5IwlSkB4wpc+qEzy4b2aVdTA7Gjm5cIrpG4CvmgGlHtAhDxK030J?=
 =?us-ascii?Q?zQg0+PkPgRBfaI/aaI4ntWySsGtga3qWxPPhET3DeMY+EeR39qQe50KOrVJp?=
 =?us-ascii?Q?hefUnXJdSOpVMlG2oF6LSyMQYaCXcHzrVe8yhFEEx5Ijd1qNCyBgTa8agZFB?=
 =?us-ascii?Q?2H1JJhYbOOrmc7gZ9EIQploIamEbMpEeUM0au31l0N8kh5gX7g3uWvsYPsRR?=
 =?us-ascii?Q?UXU2arALCWGTi8AYCE6UwXefcyUvUzCt+yfJlS4yeDdWX4ILVggn2OSWjOS1?=
 =?us-ascii?Q?SLKP0UJOQ3o8b/Tn0wtYiErClQSnfonS6tJaaQ0NSflWBiAQLRX3K2HnO5xW?=
 =?us-ascii?Q?o1Gjc1Xhbir8tsdGd06BH+zweFLreBoHFxuqhOYReuzyjGADKRLUURjWTMZr?=
 =?us-ascii?Q?vGpjqE8CBt4hIFNlHSmOtjyN3MlW0v5JyLLnn5Bw355dvUQwnVJqR6IM9GPH?=
 =?us-ascii?Q?YWSyjF2Mbw1ZgoRnfRGPKkMr1FsUz5u2EMANF2aUtrxTdxqpH0OCdtagAVJJ?=
 =?us-ascii?Q?vVyKzXRRV0T04Q9ktF8kOEhC73bhvP/rHtjwip3CymG/v9OIGlgMHk9tCqhS?=
 =?us-ascii?Q?LtgBr7hvo83iDHswp7caqQQTWpv97JscOqenkxFKl7V9dTJPk34E+z46dVt7?=
 =?us-ascii?Q?VENjV9mC6DmS+O/VvVsacWRkm38q0QFaI686i3Sp6YdKkC/B5CUoTJVZRFRg?=
 =?us-ascii?Q?6Ke/NpvEh8Oi+b9hC/oAdb5yvh/ZTW0KMuD4qbJdTsGctCiqyH08gC0QNYYq?=
 =?us-ascii?Q?ULcmWqO6C0dI0jZ9JzAurDQhxOdm69VnfIeTugwj5CucyTFzaFNIp5bExiyA?=
 =?us-ascii?Q?dFfU+A9xs/mKikabVD4Nf+V5wLSF+9b93BnXP6qD7jrWqBEphTOWf4enXvf7?=
 =?us-ascii?Q?Aq3DlvksHqb1KTbKvJ90vyQYgtEu4lRJ7ov60yweniTWoTNl3plTe5HS/7bm?=
 =?us-ascii?Q?LJWCuzZkrxUlT9NMroKPvBuMb6BJfzYeQZ9hs2sVxz4sTs7MSJutLhSR0oNZ?=
 =?us-ascii?Q?mhVz2sIpxoIhldiK125p39LdHIaupi50j/P1qaVIKk13GxV3xy+iZXKErFns?=
 =?us-ascii?Q?S2YeQmJQlMBrNIJWQR05wQCtS3zPGkNaaZImAFWZLrs+4P0hqqdkNQ5yhIgi?=
 =?us-ascii?Q?ZDFXcS+txzth7dyvzIghNkHJPxrLQLx8FmzkYhxpB5wnE1egCH5S5gZuWk/E?=
 =?us-ascii?Q?6T5qzZZa9Z/OfQCa/d1lZJl8uBriGgmWkU4Z3dK18NRovPxf17FBJnQnr/dG?=
 =?us-ascii?Q?gWyknQ0zOB0Nu7TJQ5ggGba7y+LrMWvEVOc0Z5W5NLiau8YjYaOFUxtDAiHw?=
 =?us-ascii?Q?d/3PYBS1z9FeGfvJGVQ3WEA4p1ONP1DtWyR22proJgjG17iwuKddscsIuR+W?=
 =?us-ascii?Q?1HROJnMqfCF0mR9mtJIA9zpqTWXLuAXwtw8DOn97Ag+EQonhYYZQx1qn/JHr?=
 =?us-ascii?Q?UBHJpVENcvqTorv4M9vcN1ljo9WB5LTGww+Koc4gTig1E2NO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fae1cab-3a2a-4d9f-68af-08df3e7aea60
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 16:02:54.8978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/Yg6tbP8REXR/311r8eto3BPuUJx9o+CqbwAVApgNmtFKwkmSr02vFVo/0uW50TXK3Kly0pivTLNV9T7EAzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lancel=
ot
> SIX
> Sent: Monday, September 28, 2026 9:35 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Six, Lancelot <Lancelot.Six@amd.com>; Samoylov, Alexander
> <Alexander.Samoylov@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Add pci_domain to struct
> kfd_dbg_device_info_entry
>
> The device info structure returned to the debugger via the
> KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT ioctl contain location of the
> device on PCI (bus, device, function), but is missing the domain this loc=
ation
> belongs to.
>
> This patch adds this information to the snapshot structure.  The overall =
size of
> the kfd_dbg_device_info_entry structure structure, this new field is plac=
ed in
> preexisting padding.
>
> Tested using the following topic branch for ROCdbgapi:
> users/lancesix/read-pci-domain
> (https://github.com/ROCm/rocm-systems/tree/users/lancesix/read-pci-domain=
)
> and the regular ROCgdb testsuite (https://github.com/ROCm/ROCgdb).
>
> V2: Add reference to the userspace code making use of the new field in
>     the public interface.
>
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
> Tested-by: Alexander Samoylov <Alexander.Samoylov@amd.com>
> Reviewed-by: Jonathan Kim <Jonathan.kim@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 1 +
>  include/uapi/linux/kfd_ioctl.h         | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 0dd1fd448059b..2c14b03df0781 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -1129,6 +1129,7 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process
> *target,
>               device_info.capability =3D topo_dev->node_props.capability;
>               device_info.debug_prop =3D topo_dev->node_props.debug_prop;
>               device_info.capability2 =3D topo_dev->node_props.capability=
2;
> +             device_info.pci_domain =3D topo_dev->node_props.domain;
>
>               if (exception_clear_mask)
>                       pdd->exception_status &=3D ~exception_clear_mask; d=
iff
> --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h i=
ndex
> 749d196e2114b..e7908a068d3d1 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -49,9 +49,10 @@
>   * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptio=
ns
>   * - 1.22 - Add queue creation with metadata ring base address
>   * - 1.23 - Add profiler control ioctl to enable/disable profiler on a p=
rocess
> + * - 1.24 - Add  PCI domain in kfd_dbg_device_info_entry
>   */
>  #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 23
> +#define KFD_IOCTL_MINOR_VERSION 24
>
>  struct kfd_ioctl_get_version_args {
>       __u32 major_version;    /* from KFD */
> @@ -151,7 +152,7 @@ struct kfd_dbg_device_info_entry {
>       __u32 capability;
>       __u32 debug_prop;
>       __u32 capability2;
> -     __u32 pad;
> +     __u32 pci_domain;
>  };
>
>  /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_pol=
icy
> */
> --
> 2.43.0

