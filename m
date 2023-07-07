Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B3CEB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 14:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC0810E5A9;
	Fri,  7 Jul 2023 14:59:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D43810E5A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 14:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecXcxD1oC/gGCXbV4XWQMeIpebUM3SJ6xq2GrtcVBh59Vziex245D9mRFLuYkC1IYrW91IGNBZHAjpGUbR/w6/RDX69C4N8JBBeY0giTzRmsqanpu2i2NXhngTDFXa8eVnDXVLZ9FeLHJQRDs3h5PVHk1+vgq5MmynIfNA5wD8Gvc11Uj1o4GahtCXG7sKMd3Sub3ViL5CjHoNYkbeFXxUYiSkpKhqQ371TwUXCaR1EL6RdiydKH2Kiz8LTfSvumyIZ6qs04ieW8o5DJysBHwsayn4jkmpWx29fdBedKBhvAVlxIG1Gm/paR4YqKtebz9mO7v34S+xmdfV5eDNWaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUirjdZRU+qxn3DHNJhteKbcm4uRmmNpaxeJF2iahIw=;
 b=lCR59CmeAj0d7vkHyotvT9BvVITN3FqTJBTHz9MEMQGL36OxwOFunHNSRdKtPHZn116qAOHLdbwImIvmyJmFr4j1RapVP6NtgjMIINAMU0X+5MPnyRkqy3y4GrynzF9dSMOw5fEs5FZtaEuPa/m4HrdAmjH1dIcjHUgeS75393dMdkli0e5xzuQB72v9NXkrFkNq0ZjZ+Ss7dVvdHZOfp/05swxzVeiACWd+dXEpIv/qby8P/QYqq33zFFyCGL/gNDY+i9EAPxJsB+xrIx4IK3a+v4mcndMD+EemjYNCC/XAvSpLK/1OC0FoCq/eElUuPdxfwR0aAiJOVEYNeZq+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUirjdZRU+qxn3DHNJhteKbcm4uRmmNpaxeJF2iahIw=;
 b=s+CjC5bcyLtRQdBMAlrmgq5357/MKzQY20WFmw2qqNrQN/nSEpp4f8G+ztuKQuEnxTnlyKKx0atev2vvKd/bEguiKISFkQawhqQJaM+/+IVW6+szHWLLW1wVq6KfEaF2orAWUHC2ev21WxpcFkxrfpQtLkYGksnJOndKiR3GIOE=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 14:59:33 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 14:59:31 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/6] drm/amdkfd: enable grace period for xcc instance
Thread-Topic: [PATCH 4/6] drm/amdkfd: enable grace period for xcc instance
Thread-Index: AQHZsDZx/jIdikqW80K6BXqWQ+dx5a+uZFTg
Date: Fri, 7 Jul 2023 14:59:31 +0000
Message-ID: <CY8PR12MB74359A316EAE92978FA47386852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
 <20230706181918.189722-5-jinhuieric.huang@amd.com>
In-Reply-To: <20230706181918.189722-5-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1eb6fe2d-a059-4ed1-8f26-3a60dfa85fc0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-07T14:59:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DS0PR12MB8319:EE_
x-ms-office365-filtering-correlation-id: 2aab6757-a8fd-4eb2-ef40-08db7efac4ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JIBGx6sKsbrP08mtT28iKfgvDLEJkM5nDH/rdPzeVQYy8fpylzgLtayyX6aoIYiCi9IDsqMZ/MTNjdpoaVWpFuFfhld6Y0rEzvPVrPfFqepHXiPbmPgQLsQmfBtLCY98oHLXWG0lLz+e3/RF3itcgZKlaqd1YNvGmUztJqnXu9rZwvXdiKTNnpmvxjOZ93UEmvzkzdXd4UB6QHnA+8vhm8rg0TBGaiiVM7NkIcEXDczPTduwsUxJfyPGJRuu6BZw8LaxW46cZmlYtpW1w80pM7hNOxFTNNDSafBHKFFaOQSowkxF5uqQe+RaSvy2wGTbQpCU0i2uTlY4+/my2J2RZjZdf0KGfgQ3ZOrvwVujXPGz/sG5bb1Pejw9XSVkrC5O4HdaNnBPSlP0WSzJlcQ0wNC/cX851eBEHFeISHNzXy4+8Q26fXCiquqhUe3uwdSmuts/Ta1ulKNU0xaL800UdCPqXkBeMAntiX6nZGm4fbY6EdDZ82n1PNle7wWOa9Mz6dueUzGbFohRiT5WAOOzacJIC7r2MZ6/r9kN0pKMjDbOag8B3azOjaBtUO8kLrc7YTEcHcOuIC3le4Z7d9o0vkRDqBU+5HtLPU4XzWihv73vrdvjF+9F5R+H0pR7JQ8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(41300700001)(2906002)(316002)(8676002)(8936002)(5660300002)(52536014)(38070700005)(33656002)(55016003)(86362001)(478600001)(71200400001)(7696005)(83380400001)(186003)(26005)(6506007)(53546011)(9686003)(122000001)(66446008)(64756008)(38100700002)(66556008)(66476007)(66946007)(76116006)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rX3L+cmhVfvE02wVeaV4Ju0NmLplgRdxamwqoAGQa/nwI49BiTrjh7ieRqq+?=
 =?us-ascii?Q?Bkt0M4cKzXqg6k5XnBCFMpi+8KHjWk6so0GnQYOuzC/kkBSRHDlP3x2Fjnok?=
 =?us-ascii?Q?34QC0n0Nr3CGvQagjMdus5D8oJ1i+mcgAxWPVewiDo+DqjNma+GhPE8xgzrA?=
 =?us-ascii?Q?KNocBMA3o1x7HacYOqMMKdAXdQYzU1T6fyIo/xjdGAILn722UvtPIo3lWR1e?=
 =?us-ascii?Q?uM++pi23wCCPztub21csHm2Rur5gRV9oX3NA4aVzRChl4UamQ+RFiKsAao0J?=
 =?us-ascii?Q?ZJSbrwasQ0w1FVwgvZrH/PvyFsTXolpM/naKsObTUfdxUFF8/KIuyNgdqxtG?=
 =?us-ascii?Q?jom9eIo3/SFN+vsrVd7l0mnWIeazEtt1Wig8ZVXNAQtzTv6k/St9VMZO5FlH?=
 =?us-ascii?Q?Z9J2z+SmIGwijNTB5rpH3cyOSLfqN8c6cANAbeuS5RUPcTe9gnra59YDd9O9?=
 =?us-ascii?Q?XMoKGyxP34GRqnC9OoWhpdKFe4zX6qb6+HqycRCom4Vs6SyljcZdsllqkBP6?=
 =?us-ascii?Q?Nu8K0H4BGgP18jpbkitxOtiv4KLMBMOHGXp7s8ZqD2H+DFfyumTvzpeDdGee?=
 =?us-ascii?Q?AeZYUD2a/ODeeIOBLdoRBNT76NcInvCeUTTS5F/V3KQ04r2ewcOnh3FezqZz?=
 =?us-ascii?Q?w8DrcG+EH+cf+Bg48LgCOFl1JWd75GNEPR2N69FGuenwkZuvMLaeuTnHQP3n?=
 =?us-ascii?Q?pOLf9zArDysVoLsb4TfiTgIHs1wMYVsJeDfiAD0hhCDef1ONsjYJRPIll2wK?=
 =?us-ascii?Q?h52NHAV2HlwC4IsQdT9Rg36uC4ZwCUsad5GgKziCUKt6ljYh7OvclEygUMnO?=
 =?us-ascii?Q?O25epubygO5Dkir0COB4Qw9Zn6ySiZICx1clC2ml7mIqzhaguzHKHGneVhr/?=
 =?us-ascii?Q?MaUOR/eX6JnrvFkcddzeCLzfx6xCACsZvtXmSL6WstC/43Gpm4Wm1bIph+oZ?=
 =?us-ascii?Q?OAA1yKMR/diHQUmrrV00RrgB3YTPTW3X36/Ug4PcRSMXHP8TMQ+rH8BywLIw?=
 =?us-ascii?Q?mHDZNpusNVLoiP7QF/qibSuJmILZfM7HUXJqswDVAc5xaND4a1OKs/Pix7ws?=
 =?us-ascii?Q?y8IBKlrgbT7QtIcBGRru28l8bSw5pNXURj9aJlzM/TbAkWA7IyNdJGQZksO1?=
 =?us-ascii?Q?JHt/igvCWFCldNMXwvvYGlam8RZfcJjcj9RMUa6giyOSMB8BSIGqPY48mFgT?=
 =?us-ascii?Q?9PxCfaXZxTEeqeNodzPTl9IpbISReaZ4JCHc2R4u1+w1EWzqcF/qdz5Crqj/?=
 =?us-ascii?Q?KLOxVBCJpPyhihTahPe+IgjhogqAOb1EvlPNLeuRom+xnOd1YeM1X6jmETW9?=
 =?us-ascii?Q?BXhYSFj5YM9DgndyQzMDNqVjmMi39PC2Oe+uTDcWrc3RnKJhHRLeGukXEKec?=
 =?us-ascii?Q?LBk5nPryEpoELneiijm5UMdZnPo4V6p6YzrJoXHYnKPHHzO5oeujyWdM4XXV?=
 =?us-ascii?Q?crmf/tGOjkjf/IUXQpP0vre1PK1Y6h9o4e5FdwHqEw2ocifKP0pU66gwgq1F?=
 =?us-ascii?Q?Mg84/T2Tsug4iwJgBCX5+RnDyhk1QS8x1xinHxu2kt1xXBl1d5v0Vf7BY8r5?=
 =?us-ascii?Q?MOHGQCBboo5mq8q4dz4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aab6757-a8fd-4eb2-ef40-08db7efac4ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 14:59:31.1413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DX6U0GQHGK0j/ZAfG6F/5mjMcnmdea0Adm+ZKpzyq4N4Tls73vJZxRkhjKhafI8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

[Public]

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Thursday, July 6, 2023 2:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 4/6] drm/amdkfd: enable grace period for xcc instance
>
> each xcc instance needs to get iq wait time and set
> grace period accordingly.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 ++++--
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 32 +++++++++++--------
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  9 +++---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>  5 files changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a2bff3f01359..0f12c1989e14 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1606,6 +1606,8 @@ static int set_sched_resources(struct
> device_queue_manager *dqm)
>
>  static int initialize_cpsch(struct device_queue_manager *dqm)
>  {
> +     uint32_t xcc_id, xcc_mask =3D dqm->dev->xcc_mask;
> +
>       pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
>
>       mutex_init(&dqm->lock_hidden);
> @@ -1620,8 +1622,11 @@ static int initialize_cpsch(struct
> device_queue_manager *dqm)
>       init_sdma_bitmaps(dqm);
>
>       if (dqm->dev->kfd2kgd->get_iq_wait_times)
> -             dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> -                                     &dqm->wait_times, 0);
> +             for_each_inst(xcc_id, xcc_mask)
> +                     dqm->dev->kfd2kgd->get_iq_wait_times(
> +                                     dqm->dev->adev,
> +                                     &dqm->wait_times[xcc_id],
> +                                     xcc_id);
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 7dd4b177219d..62a6dc8d3032 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -262,7 +262,7 @@ struct device_queue_manager {
>       /* used for GFX 9.4.3 only */
>       uint32_t                current_logical_xcc_start;
>
> -     uint32_t                wait_times;
> +     uint32_t                wait_times[32];

I think wait_times[16] should be sufficient.  We only get the hamming weigh=
t of 16 bits for NUM_XCC and I believe the xcc_mask is declared as a uint16=
_t in the KGD portion anyway.  We may as well align to that.

>
>       wait_queue_head_t       destroy_wait;
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 401096c103b2..f37ab4b6d88c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -374,27 +374,31 @@ int pm_update_grace_period(struct
> packet_manager *pm, uint32_t grace_period)
>  {
>       int retval =3D 0;
>       uint32_t *buffer, size;
> +     uint32_t xcc_id, xcc_mask =3D pm->dqm->dev->xcc_mask;
>
>       size =3D pm->pmf->set_grace_period_size;
>
>       mutex_lock(&pm->lock);
>
>       if (size) {
> -             kq_acquire_packet_buffer(pm->priv_queue,
> -                     size / sizeof(uint32_t),
> -                     (unsigned int **)&buffer);
> -
> -             if (!buffer) {
> -                     pr_err("Failed to allocate buffer on kernel queue\n=
");
> -                     retval =3D -ENOMEM;
> -                     goto out;
> -             }
> +             for_each_inst(xcc_id, xcc_mask) {
> +                     kq_acquire_packet_buffer(pm->priv_queue,
> +                                     size / sizeof(uint32_t),
> +                                     (unsigned int **)&buffer);
>
> -             retval =3D pm->pmf->set_grace_period(pm, buffer,
> grace_period);
> -             if (!retval)
> -                     kq_submit_packet(pm->priv_queue);
> -             else
> -                     kq_rollback_packet(pm->priv_queue);
> +                     if (!buffer) {
> +                             pr_err("Failed to allocate buffer on kernel
> queue\n");
> +                             retval =3D -ENOMEM;
> +                             goto out;
> +                     }
> +
> +                     retval =3D pm->pmf->set_grace_period(pm, buffer,
> +                                     grace_period, xcc_id);
> +                     if (!retval)
> +                             kq_submit_packet(pm->priv_queue);
> +                     else
> +                             kq_rollback_packet(pm->priv_queue);

In the event of partial success do we need to roll back (i.e. resubmit defa=
ult grace period) on failure?
I believe the default grace period is put in place for better CWSR performa=
nce in normal mode, so leaving fast preemption settings on failure could im=
pact performance.

Thanks,

Jon

> +             }
>       }
>
>  out:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8fda16e6fee6..a9443d661957 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -287,7 +287,8 @@ static int pm_map_queues_v9(struct packet_manager
> *pm, uint32_t *buffer,
>
>  static int pm_set_grace_period_v9(struct packet_manager *pm,
>               uint32_t *buffer,
> -             uint32_t grace_period)
> +             uint32_t grace_period,
> +             uint32_t inst)
>  {
>       struct pm4_mec_write_data_mmio *packet;
>       uint32_t reg_offset =3D 0;
> @@ -295,14 +296,14 @@ static int pm_set_grace_period_v9(struct
> packet_manager *pm,
>
>       pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>                       pm->dqm->dev->adev,
> -                     pm->dqm->wait_times,
> +                     pm->dqm->wait_times[inst],
>                       grace_period,
>                       &reg_offset,
>                       &reg_data,
> -                     0);
> +                     inst);
>
>       if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
> -             reg_data =3D pm->dqm->wait_times;
> +             reg_data =3D pm->dqm->wait_times[inst];
>
>       packet =3D (struct pm4_mec_write_data_mmio *)buffer;
>       memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d4c9ee3f9953..22c4a403ddd7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1400,7 +1400,7 @@ struct packet_manager_funcs {
>                       enum kfd_unmap_queues_filter mode,
>                       uint32_t filter_param, bool reset);
>       int (*set_grace_period)(struct packet_manager *pm, uint32_t *buffer=
,
> -                     uint32_t grace_period);
> +                     uint32_t grace_period, uint32_t inst);
>       int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>                       uint64_t fence_address, uint64_t
> fence_value);
>       int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
> --
> 2.34.1

