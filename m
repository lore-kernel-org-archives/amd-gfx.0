Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC45E7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 22:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CAA410E2B9;
	Mon,  9 Dec 2024 22:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="POIUuzgb";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C642810E2B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 22:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX6wG7F0GgMBT/jO80b3MGZG+t5VhOzSoJecBtpWUExHCCZBAl/swogVDkpIOciRpsVoqu9D3Hs1nNVhbb4Np2RGkSRqqvIUDtwA0ZZIfjB3Jg3YmM9SM7jIkuonluq4EME+MZQqXmpd5pJljnslx5IxY6tIoWNkJp+U2kdQTENbAeC+fd/zG2W0FLyXOvnqdKJGNwoK+DBvwS/pB3lIEOEYp/sDL9ACG4bYv4PfvJTcTQqK06ZoGB7TAyzPp3AQAKvfj11+yRlP9NammrRfEuQJf/9VeiUmjd9kr4aZ3X5rRtO3vqjr86b1KAvFJHe8HSNqI5wJMVb1LwrgMkPTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=silkhDqWD13B6JQml9RlXTCDAjm5CQLxZEnwPi7F+0U=;
 b=eSW0g+uPAOmGC7joHe3fTrDc5rvXFd7j0ozqG43uGb+Oc84b95haTmxhUKvefBuNoA31EuiEDVGWXL5DZttC0lKPvv8+ULQ2V8h0TZfyfTO4CfzgHCWMmS0Q3FOy7H2LZnHkQ7rZuN8wpASGX8brLrvnBcH5XEFQgZ+isNM5seDg5rn4sWVedpEmkDB3WDUbJCwb08LAeU8kanpW+X+yqsIF+BHIjKasXGFxkJOCCbXp+YraUL8JUc0fpwSm7fcDwCdLOqis3X2TlYQ5v0F7ew1YSa+/j8chttbmhrcykR4BiAL9D50iu7DeYjzOQQS/uaNRHkHMsxF2BixEQeBOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=silkhDqWD13B6JQml9RlXTCDAjm5CQLxZEnwPi7F+0U=;
 b=POIUuzgb7TgNVUulM/ukgNfJnT76ojxuZBBueYxtWj9DsFkjMs+k2uBcHIwuZ9t97x9iPrMPBNcf7zrKalun9vGNIa4g1XfXYIc01OVZw+/E0K6sh1tuL+VucQmBjCTXeAaxTx7czRyETGYvrYciqGo5dh25Z385a2xfEG1q/f0=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 22:38:18 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 22:38:18 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Tudor, Alexandru"
 <Alexandru.Tudor@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Failed to check various return code
Thread-Topic: [PATCH] drm/amdkfd: Failed to check various return code
Thread-Index: AQHbSCvL1fVM/PNx3k6st+yvoEl+/LLeRh0AgAA95+A=
Date: Mon, 9 Dec 2024 22:38:18 +0000
Message-ID: <SJ0PR12MB81387A1BA62DF8A9C5D50095F53C2@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20241206221110.2898199-1-Andrew.Martin@amd.com>
 <CY8PR12MB70992BD4D27ACCBF5AB8BDAA8C3C2@CY8PR12MB7099.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB70992BD4D27ACCBF5AB8BDAA8C3C2@CY8PR12MB7099.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b40676e1-9443-4515-b385-c7d1164da6f1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-09T18:49:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|DM4PR12MB7648:EE_
x-ms-office365-filtering-correlation-id: 6056a9a2-b93f-4d40-3ef0-08dd18a22dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?wnpic1H6P1Ma/O8AzkJzbXaV73r4h7+WTfN/LMt3vGmSVvrJJtVMeMHp/YUO?=
 =?us-ascii?Q?jKR3BeEGnvDkC7EzaqhNaTACQcLD22WLqEV+j/0ez06gG80rRUIxAHU4MR8k?=
 =?us-ascii?Q?SHKnbzOEAyhwdPmQEOSvipDDsUm/Dp98j9YZN90qM7ECNfGPBwuXmWQrTfQy?=
 =?us-ascii?Q?koZRn/dsLUO8xkWk92te7fVUxEEXAIk1qIuMdnnaoQzgesVOQbFnaTKMCqvX?=
 =?us-ascii?Q?gXSCPSl21cqnG5cj4j48GGdSWBwWzI2K2i3CajZZA1YNk3oSEZ7YD0nOgbD5?=
 =?us-ascii?Q?7yR1bovcT2nbvHpKlUTCWxA56Pi1a0AJBYvDZ1xK0095kXpY9B8tFDDjPDcJ?=
 =?us-ascii?Q?OlqsCxFN8Cfbsns4KL22cFdsaa7Gy9usTZg5Rg9FFJPZI+Qg59zeM//dZEzD?=
 =?us-ascii?Q?5EvrsUe+8y+++FPulce5iMLJw+16OPIu5g8im0k7cvuab1GDXX99rXz+Xnm3?=
 =?us-ascii?Q?avi7NI2t/OWvx74wl4HCz8wcUPhz5QedXXhv75C/BeBj+FMrVbyp92XTvtRZ?=
 =?us-ascii?Q?y1j8OKgUyfdDhtoT63ER5MNtAGi6WgWVFRWEstuYn2zKInKk7exsW7hlkMa2?=
 =?us-ascii?Q?Mq/YTlw8Gv2tID6WZa0SpzMVYKb4mP3Rmvf1XGGcf6axNrWl0re7Xkkw8P7U?=
 =?us-ascii?Q?p89Eq5nFABkq87ny2mplmZJM3XziAv0wIrCRChrO1upM5AYddnbZwFzxp9uc?=
 =?us-ascii?Q?iHkU4qUujxqv35fNpk6sYznlJ+mo5GXUI0QzrPQ6o7o1ea55HxdzjkWFmR3h?=
 =?us-ascii?Q?CVoG2oIugLZKr2x4BrAE5KP/XJI8y2KOVO+FhbTV+juZIPuH24ALXfa1LJ7r?=
 =?us-ascii?Q?CS8XS5qf/25uauBmAkRM63YfahWDfs/x6zJnCJQtzUPUKwZMCIXQCTNAStyc?=
 =?us-ascii?Q?ovCbbeJ+wtqL0FI0PPkqKoPbE3D81CZcRZmD3jHzqlG2FEHIUGdFPo8mSpN/?=
 =?us-ascii?Q?7YgCq7uVBY3Z2kvcdMNitC7jz9Y8un2GYT4NKFYQWFMEPGLKVTB0LS548fJ3?=
 =?us-ascii?Q?ZutzKWJYvlNoS6wB9weCmqRRa+oa6XwsiXKnjBhZPmSXDDKX033iQiTXWklh?=
 =?us-ascii?Q?qqY0TU+Sey3ogKYPlx9ULN0Iv8AO0fv4KcK8DhCDgoFMDAxZWfKb9JVx2LQi?=
 =?us-ascii?Q?e3KHVyr8jkFlJq14TFA3iF4SLNa2XftIQtMMMg0j7TBSkSwwReNEqmXB3Kf9?=
 =?us-ascii?Q?RXGhdrzI5nob2CSdkNidfhjzUNhilrARJ0JZFlA41zceZNKbztSBoAOivuOD?=
 =?us-ascii?Q?koe8fjpFVhmOOu957j/cjfPinp9TwsZdLUUUOnfvtwEht/gov6x0HTlWownZ?=
 =?us-ascii?Q?lb26DWhUO1SjkGTjnBzk4i9AkkDCfeez0mmxHubhTtrvwm3x0Mw0aFakOCFF?=
 =?us-ascii?Q?8dkxg5eQrcZ+RBJOEdQ+jGQ+oeGVaKP3Ec2Aj/b6ISpHQr8QOA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lAEFW2O1IQFjsYMsqCf7n9OyGI9LIPUj7rX3TfsP8IM5CfTseKUvwNN5Ub3s?=
 =?us-ascii?Q?Q/Rrb/ilERoWXsF1eMbyWpmKPVkipEa/AB57uvr+J2Vm4T8AEMRlda79qGzM?=
 =?us-ascii?Q?OdRszfKHCnyU/Z19fKEYK7FBGpSgM4dj4uEngj27P6cSp45dlFok93/93S+w?=
 =?us-ascii?Q?D0CHQlb+iIqYsDOEdS9aQpgjabvz8kX/FYeZm3Bhktq9qLN21w/0fzzQI5Ys?=
 =?us-ascii?Q?g+uuOpCUnl/3MpahtcDS1Uw6SlWZ+4VuHbp148NRigyKWIaqJI+SBYaDeeSw?=
 =?us-ascii?Q?pCWbnacR/WAeTs0MfjcHOnJa/0L23lB/GRaklKBy4xtzfSjoII9tr/eYmNVN?=
 =?us-ascii?Q?VXPPMURXKGDDe1T7EFcuC3GkCX6iwHayNJBb53JFO3DFqmQ1JIjhTC6JRraZ?=
 =?us-ascii?Q?KGdIbzdtylZFfvL0kY64M6FxGz3I3QAkGxZEoBDJRiRjOtqwVfS0fgVmF6BY?=
 =?us-ascii?Q?yOhCyTJoQ2HqJpz3hljWq/1OldpV/YZucm9FdJi1IbUVr/t8Mc/DMn1vneGh?=
 =?us-ascii?Q?riCpNLvbtaXjeiqt/bNKahSyS2LYQD72NBF9tN1WLrs0SAT12oxZ8mj6IVhK?=
 =?us-ascii?Q?yqSOY5AOKoiSnhMubLczkzRuUE8+DYC1J+gdc8bbqa5g/YcDBXM1WbjUQwRF?=
 =?us-ascii?Q?FjQfFVRNP1G9A4KfwQ9VXP+IW8o2WdGju8z9CNyU1v7OLKlcSlSrPmj58p+R?=
 =?us-ascii?Q?JP1uVJIZ9SGHNIf3jvd2no08wthH/J98m0IV/IyrfsvOVgEdSUrNUoPu8sws?=
 =?us-ascii?Q?p7xvDqttiZrDVsnN2VOB9Anrw7Jg2WeaSr+7Tz1KfR+Kw63FpQ2EenLvJcpr?=
 =?us-ascii?Q?kOgJB5fzf2m28y6vumdivA3aISv94gwwbkY33BBRg0NUu3lCnfJxNSBx9nit?=
 =?us-ascii?Q?jdFDxy2P/vUglzbtEu3o95eNwPYo75EmFEuUCZMEVvQHJWoL3qp4TsgdW6Aw?=
 =?us-ascii?Q?XvFzAQybqnUzKZU7BakOQakoqoOa0D1ZWH3A0K9x/B83+WQ4nQ/bEnjY7Xjg?=
 =?us-ascii?Q?nbEIfAjup6N7qVd2A3612US60h7/uUX2Tb4yOITnfL5CYM6xiwyc4fF3kvIj?=
 =?us-ascii?Q?cv4BFy7mz+yahvByJ6scTteYGAc8U/4TPwovszbC9J/rlawY4KJ4CBVxZYO/?=
 =?us-ascii?Q?rhWBqTeyXk1Po5VzAgzkap7NaadPj8WO2a8inFgtp/RbO2aM94VU42ESqZ84?=
 =?us-ascii?Q?0QSB7z6sEHoLoiuovIUwphsEu1W5/AgxaNYs3bxVjPpPbnsBvRPNvtYNo8H2?=
 =?us-ascii?Q?WhXXLnv9fGA6rSN+nPNn+taaLh0LC1NYuNgNCDrLdABtU+j8o3xMvcx7qAKL?=
 =?us-ascii?Q?07Asi6GwTZdpRqn3n09XC4GkF6kRLcLh1fDvU9LTipTF23xOPsaY3F3PobUU?=
 =?us-ascii?Q?VLH3lnM1bGQD+O15xjKKVAGI9LNEdtP5AuZ1/6xJD0/z3eGCJsAZanU1QGZa?=
 =?us-ascii?Q?5bAiFqSi4ElXvFomKaW4+PsYqz48eJjFel3Ve9GjfxPwyvTOejC8trWElywC?=
 =?us-ascii?Q?DqmAAikFvplubGAM9VNSMCYCb5q3Zg263A9B734vO7dMMfD/w9P5ZTqsW+he?=
 =?us-ascii?Q?O88Dpiv0Ct5sSc+tM1A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6056a9a2-b93f-4d40-3ef0-08dd18a22dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 22:38:18.7469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gVyn1uPeVDxsf6GVKZs1AD2PlFDYM+TIhbgyzhTmoDVmr6TpP7SUsqLIUJBzQKKgq4B3vfn9TiWQTvnbvqRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

[AMD Official Use Only - AMD Internal Distribution Only]

Greetings Harish, sending peace

Thank you for the tutor ledge, acknowledge below!
> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Monday, December 9, 2024 1:51 PM
> To: Martin, Andrew <Andrew.Martin@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Tudor, Alexandru
> <Alexandru.Tudor@amd.com>; Martin, Andrew
> <Andrew.Martin@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Failed to check various return code
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Minor comment below.
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Andrew Martin
> Sent: Friday, December 6, 2024 5:11 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Tudor, Alexandru
> <Alexandru.Tudor@amd.com>; Martin, Andrew
> <Andrew.Martin@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>
> Subject: [PATCH] drm/amdkfd: Failed to check various return code
>
> Clean up code to quiet the compiler on us failing to check the return cod=
e.
>
> Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 14 +++++++----
> ---
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  3 +++
>  3 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 503051352922..de30143ea51b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -368,7 +368,7 @@ void amdgpu_amdkfd_free_gtt_mem(struct
> amdgpu_device *adev, void **mem_obj)  {
>         struct amdgpu_bo **bo =3D (struct amdgpu_bo **) mem_obj;
>
> -       amdgpu_bo_reserve(*bo, true);
> +       (void)amdgpu_bo_reserve(*bo, true);
>         amdgpu_bo_kunmap(*bo);
>         amdgpu_bo_unpin(*bo);
>         amdgpu_bo_unreserve(*bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f30548f4c3b3..1e998f972c30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -730,7 +730,7 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem
> *mem,
>                 return;
>
>         amdgpu_bo_placement_from_domain(bo,
> AMDGPU_GEM_DOMAIN_CPU);
> -       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +       (void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>
>         dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
>         sg_free_table(ttm->sg);
> @@ -779,7 +779,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
>         }
>
>         amdgpu_bo_placement_from_domain(bo,
> AMDGPU_GEM_DOMAIN_CPU);
> -       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +       (void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>
>         dir =3D mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
>                                 DMA_BIDIRECTIONAL : DMA_TO_DEVICE; @@ -98=
9,7
> +989,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct
> kgd_mem *mem,
>                 if (!attachment[i])
>                         continue;
>                 if (attachment[i]->bo_va) {
> -                       amdgpu_bo_reserve(bo[i], true);
> +                       (void)amdgpu_bo_reserve(bo[i], true);
>                         if (--attachment[i]->bo_va->ref_count =3D=3D 0)
>                                 amdgpu_vm_bo_del(adev, attachment[i]->bo_=
va);
>                         amdgpu_bo_unreserve(bo[i]); @@ -1259,11 +1259,11 =
@@
> static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
>                 return -EBUSY;
>         }
>
> -       amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
> +       (void)amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
>
> -       amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
> +       (void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
>
> -       amdgpu_sync_fence(sync, bo_va->last_pt_update);
> +       (void)amdgpu_sync_fence(sync, bo_va->last_pt_update);
>
>         return 0;
>  }
> @@ -2352,7 +2352,7 @@ void
> amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem
> *mem)  {
>         struct amdgpu_bo *bo =3D mem->bo;
>
> -       amdgpu_bo_reserve(bo, true);
> +       (void)amdgpu_bo_reserve(bo, true);
>         amdgpu_bo_kunmap(bo);
>         amdgpu_bo_unpin(bo);
>         amdgpu_bo_unreserve(bo);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c79fe9069e22..2f955c76fc56 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2373,6 +2373,9 @@ static int wait_on_destroy_queue(struct
> device_queue_manager *dqm,
>                                                                 q->proces=
s);
>         int ret =3D 0;
>
> This should be a separate commit. This doesn't match the above descriptio=
n
> and falls under drm/amdkfd.
> The above changes looks fine, just use drm/amdgpu for the commit header.
>
> +       if (WARN_ON(!pdd))
> +               return ret;
> +
>         if (pdd->qpd.is_debug)
>                 return ret;
>

Got it, now it all makes sense.

> --
> 2.43.0
>

