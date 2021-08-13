Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAA7C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 19:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7225C60F91
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 19:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7225C60F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043116E82C;
	Fri, 13 Aug 2021 19:22:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD456E82C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 19:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVVnhvKMJEdIVetU6CGhzC76qsnFuiq/iwat9Y9fcBgoqf/PaiAjUVdCIoPrCMv677s7B4hj1W+5q+DrFdyhwfimhDnbMQXdDlzkZXpScJ5s4xGE+/XRLC+tQYVoQsKTvlKcZODdIHXrTzLlREZ5JG7reHE86kcffqNyYc56RfAK7SU8rM2tZ24sV4dzhZR8g3Kz0QtcwzMKCYY02lceNpq8kl+PPb2N2kspBHI8ajOasvMr0HLDkugMsdztFc7feW6EaVD9MT7kwPFSIJ1a6CbHpb/jSwaxyMuV7eaR/DKfDKSpU/d569bhrcChyLxVRpOTjKq4CvCxuJhjpeEVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqxtxnCaniKGvUtOl6saSV9niD315aIfWD0wLF+Dvpo=;
 b=Fz0K2JW+j1jVBKqRddn9N/+T0mcmxGM0dGoieEChfTMeGnig1FdBiFdeoXfINv+Z8XN2i2lDBVPtGk+q4sjda23BvYqfgD3tPVDJqUNvzCV3vDGGxeMyTmjAXQ/GAxmGSUfEnwZ4fb3mTzdRTFgMEVp99QCjtyMjM6NZPky3bL2bjebCitmFQ8fdoWwDEAcTXXBKDa8n/oCTrhvpM0PpibZ6Xa1DPERoP5kjrQ6/JDN5Bf/VsfsgDQUk2vSAJXt3Y33IMsWiu8+wzVNT+jALJw9Enx1UOjp4+QlaWGrNNq+AggTIfdEgTI0Zzik+LLbKeqESD5TOEcK2rGjsa2FMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqxtxnCaniKGvUtOl6saSV9niD315aIfWD0wLF+Dvpo=;
 b=zgqO1aKNtRqmV5FnrIxiGX/TfXWXYaiGFv+yluqyw1yD+mmDM8p7P0XzQkSxLk7SXYia0lmgp0yobNnaQDNHHR8fRaXu9XTYyKrypy6XUKwBZjQ0xkUrhW4MzPNwEkKvTTGyHmXvypN0JJkNGGs5P3NaXikBLfJglVcWvy7JJ5g=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 19:22:53 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::1530:e189:a79b:5f8a]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::1530:e189:a79b:5f8a%7]) with mapi id 15.20.4415.020; Fri, 13 Aug 2021
 19:22:53 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Cornij, Nikola" <Nikola.Cornij@amd.com>, "Logush, Oliver"
 <Oliver.Logush@amd.com>
Subject: RE: [PATCH] drm/amd/display: Use DCN30 watermark calc for DCN301
Thread-Topic: [PATCH] drm/amd/display: Use DCN30 watermark calc for DCN301
Thread-Index: AdeQeDJ9W948wDE7SUK137chTFtOtAAADzpg
Date: Fri, 13 Aug 2021 19:22:52 +0000
Message-ID: <DM4PR12MB5214A80B5D8A8CEE0AC2F3A09EFA9@DM4PR12MB5214.namprd12.prod.outlook.com>
References: <DM4PR12MB52146EC560946C5875B085FE9EFA9@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB52146EC560946C5875B085FE9EFA9@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8829440f-eb5a-4d27-99eb-0b2dd38f82d9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-13T19:21:45Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6763999-39ae-4ff9-ae40-08d95e8fbf2b
x-ms-traffictypediagnostic: DM4PR12MB5166:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5166B513054F1F64E079862B9EFA9@DM4PR12MB5166.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:38;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KU+4zm0m/dY+qehh2bfR1biB7ftR+mNJUH6lpAFio7/s6+uqEnGG1YCekZSwPJVg+h6pz9IHtcNvBornKU14h2mbgvFZdCowkEEWws/BEZnXyhsrnmD6HFH2A8o1j/zY202wUwuwQGtONNwO37r8JR5rigmYT+7mfavMzEE57OUjywlAWsEHAEqisE4GOUvnHSPfOmE2PR7uZBTYQ85Og6JdkBHDam9wl4yMaM4FM13oJwQcez2hye6VqKfNnCelWB52KB4OrmIAU0bmASbZdsx6+Fgk91TtmvoJXVqUcnLwxOME+1bvwg46ZL5LZTjh/gOx60eGFh+3ORF01AURBzKWmKtWZX7HOg0priVeqDn6R3HyMZouIanHgPfVNAM8nBRUwKeDFv20TZWadjoXhg6bg6IGdbxYd6Ov1VwFmwCcgomlef9kIYzKqxCcvrBTFyuYMq8CW+YfAx/Ga8mu9NydLsw4MYxaYB9rEw8SCAuGvql18saDdmq0ZgVLDPl5m+Awt+OyWCCBgd1xY9tfhrGUsritf9S78Vd96WaMSIWsuVkapirxZJzZWsaNMOkHMm4nqdAsINh4IdB1ru2mkcHTHrQcwJWwRd5IVarTisfR+DTMS4CG+v2c7nJ8Od+XeOG2r2JbxTBorat5gYrXd7P+AgDouDtCi49ckx/PxIeA6mrnSwxkc7lZ8wY+WioS2KoEEj+ODjLDU4e6wWDC7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(2940100002)(66476007)(64756008)(66446008)(66556008)(9686003)(66946007)(86362001)(2906002)(71200400001)(52536014)(55016002)(4326008)(38100700002)(8936002)(38070700005)(186003)(53546011)(33656002)(6506007)(122000001)(7696005)(6916009)(83380400001)(5660300002)(54906003)(8676002)(316002)(966005)(508600001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KHVfnt1IpfppbtmdwpwWv+DlRs7voaQ7G06R7THECizkcCW06nkgno1igZwF?=
 =?us-ascii?Q?Zz2AHZNAwNeUeoeQQws535SvWl2fzoo/1NzPtIzb9/1ehIkL4LEVsejW1GE1?=
 =?us-ascii?Q?fReLjBuHh96h8YAIy6B/PJYIp8vmOY+ljrXMfApEyJRSHShxsxgDcytJMkbN?=
 =?us-ascii?Q?YTCGvyxQDyq9A+TNWsUrbUQ5Isini5pQNUcjAd+Dqfjk71E9YhUlKfMhoeyQ?=
 =?us-ascii?Q?l+5GkodhR2Dr3mjJ7tx/SoRIaVQAHls09gS8Aj2dQaHIXb4cuAHcpCHERlou?=
 =?us-ascii?Q?ETrb3EmHMpGny4/xCLwchZU1qp0wHh5p2awOhKJ6tX1XOEcw6AeVBUgDPWSo?=
 =?us-ascii?Q?1qJHzf93FYwEdkbbG8vNEfOG+hLoKezFA0fsOKX76MnX98NIx/+qdoUaalyb?=
 =?us-ascii?Q?w/zpljYzB2S4CdEwqUyhT8qkjcTER0HDWwsTMa8AN9wC/0DG+5hmTO4FZMXr?=
 =?us-ascii?Q?ltq0asPtOOOImdueVKDNdfIQg2hpnP/KrgfZs6L5PwWqwIETsWeI7Cq3/5YN?=
 =?us-ascii?Q?xuqzLiHKfO975hTjUcJM96/28S9MpllVXRX6INZDk18JxgLmdlsXFAvu0L9o?=
 =?us-ascii?Q?ixBa7wg0nK2A0tDDbjo3MCdBVu1DYbXZ6wMph6lDtEFka8ZSjIjfvR5+oaCr?=
 =?us-ascii?Q?BzPScHAV7hQIJsMbW3prkUQHwpkLZWdXpWLcgoWQnDc1iQHeppiUwcUrL8mu?=
 =?us-ascii?Q?WXOJ1q7cVzk6d0qYu4vyEehfaWVgAsneEkjT5nkMrqjIY6wHYZy9vIZ5Uy/o?=
 =?us-ascii?Q?PbUmlWSMms0sv/iuRJNUfKq62snqcdOMNaXRiS3UG8fyVXe3NylFY4gxEkh1?=
 =?us-ascii?Q?yoOp2Pm7aid26pVXv8iL7L7nUbbyd6szsjj0wUmysvYppQerkZtn+f5C9Avo?=
 =?us-ascii?Q?FjXQQ2sXR85R36msHUnruu+ioD9kjFgF+zCCuIMFyQHfuWZFf4QQVuF5qym6?=
 =?us-ascii?Q?eykHHFKYFROSsIgMq3Ybr5gsagUvDSk+J1Tu1svuXRqDVhfupTvEnIwUHgtE?=
 =?us-ascii?Q?O6Vr/cerakeT2dDbzubyCX/e17bqe0n7Wsk2DeGVXBzuusNvaZgwGxcld44Y?=
 =?us-ascii?Q?Mt2yX4KKx2wbQPFKu0tcCpYXqbkqGYlV7Z3Rc6RvWhFSCNSil0jQsxrWXSuC?=
 =?us-ascii?Q?xTUQGZ3X0w0qicyKXo+ggOuZD2jJ40oO+gyDsloT97owVGuMCZANSvJakeNU?=
 =?us-ascii?Q?Fm0o7hKPFczIDujfSsDpcyt+X3zmoIln8dFDvcB3EWo6Em5wWaudCel5G2hC?=
 =?us-ascii?Q?zB3XtFI8V04kwDTSu8vWxtB4CvzgoIEHOuF1flwrrYyQtXBfuH3nI2N5bK9t?=
 =?us-ascii?Q?9AgxdXYpZHdjg1qBqH+IzEBe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6763999-39ae-4ff9-ae40-08d95e8fbf2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 19:22:52.9066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e91p1BTfb8gtdx0BsciBNRsf0ijq0y+aFHgLkdZMroTDz5Bu+zN0FS2fzY/j2ckU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
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
> From: Liu, Zhan <Zhan.Liu@amd.com>
> Sent: 2021/August/13, Friday 3:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Cornij, Nikola <Nikola.Cornij@amd.com>; Liu, Zhan
> <Zhan.Liu@amd.com>; Logush, Oliver <Oliver.Logush@amd.com>
> Subject: [PATCH] drm/amd/display: Use DCN30 watermark calc for DCN301
>
>
> [why]
> dcn301_calculate_wm_and_dl() causes flickering when external monitor is
> connected.
>
> This issue has been fixed before by commit 0e4c0ae59d7e
> ("drm/amdgpu/display: drop dcn301_calculate_wm_and_dl for now"),
> however part of the fix was gone after commit 2cbcb78c9ee5 ("Merge tag
> 'amd-drm-next-5.13-2021-03-23' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-next").
>
> [how]
> Use dcn30_calculate_wm_and_dlg() instead as in the original fix.
>
> Fixes: 2cbcb78c9ee5 ("Merge tag 'amd-drm-next-5.13-2021-03-23' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-next")
> Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>

Reviewed-by: Zhan Liu <zhan.liu@amd.com>
Tested-by: Zhan Liu <zhan.liu@amd.com>
Tested-by: Oliver Logush <oliver.logush@amd.com>

> ---
>  .../amd/display/dc/dcn301/dcn301_resource.c   | 96 +------------------
>  1 file changed, 1 insertion(+), 95 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index 9776d1737818..912285fdce18 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -1622,106 +1622,12 @@ static void
> dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
>         dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip,
> DML_PROJECT_DCN30);  }
>
> -static void calculate_wm_set_for_vlevel(
> -               int vlevel,
> -               struct wm_range_table_entry *table_entry,
> -               struct dcn_watermarks *wm_set,
> -               struct display_mode_lib *dml,
> -               display_e2e_pipe_params_st *pipes,
> -               int pipe_cnt)
> -{
> -       double dram_clock_change_latency_cached =3D dml-
> >soc.dram_clock_change_latency_us;
> -
> -       ASSERT(vlevel < dml->soc.num_states);
> -       /* only pipe 0 is read for voltage and dcf/soc clocks */
> -       pipes[0].clks_cfg.voltage =3D vlevel;
> -       pipes[0].clks_cfg.dcfclk_mhz =3D dml->soc.clock_limits[vlevel].dc=
fclk_mhz;
> -       pipes[0].clks_cfg.socclk_mhz =3D dml->soc.clock_limits[vlevel].so=
cclk_mhz;
> -
> -       dml->soc.dram_clock_change_latency_us =3D table_entry-
> >pstate_latency_us;
> -       dml->soc.sr_exit_time_us =3D table_entry->sr_exit_time_us;
> -       dml->soc.sr_enter_plus_exit_time_us =3D table_entry-
> >sr_enter_plus_exit_time_us;
> -
> -       wm_set->urgent_ns =3D get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->cstate_pstate.cstate_enter_plus_exit_ns =3D
> get_wm_stutter_enter_exit(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->cstate_pstate.cstate_exit_ns =3D get_wm_stutter_exit(dml,=
 pipes,
> pipe_cnt) * 1000;
> -       wm_set->cstate_pstate.pstate_change_ns =3D
> get_wm_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->pte_meta_urgent_ns =3D get_wm_memory_trip(dml, pipes,
> pipe_cnt) * 1000;
> -       wm_set->frac_urg_bw_nom =3D get_fraction_of_urgent_bandwidth(dml,
> pipes, pipe_cnt) * 1000;
> -       wm_set->frac_urg_bw_flip =3D
> get_fraction_of_urgent_bandwidth_imm_flip(dml, pipes, pipe_cnt) * 1000;
> -       wm_set->urgent_latency_ns =3D get_urgent_latency(dml, pipes, pipe=
_cnt)
> * 1000;
> -       dml->soc.dram_clock_change_latency_us =3D
> dram_clock_change_latency_cached;
> -
> -}
> -
> -static void dcn301_calculate_wm_and_dlg(
> -               struct dc *dc, struct dc_state *context,
> -               display_e2e_pipe_params_st *pipes,
> -               int pipe_cnt,
> -               int vlevel_req)
> -{
> -       int i, pipe_idx;
> -       int vlevel, vlevel_max;
> -       struct wm_range_table_entry *table_entry;
> -       struct clk_bw_params *bw_params =3D dc->clk_mgr->bw_params;
> -
> -       ASSERT(bw_params);
> -
> -       vlevel_max =3D bw_params->clk_table.num_entries - 1;
> -
> -       /* WM Set D */
> -       table_entry =3D &bw_params->wm_table.entries[WM_D];
> -       if (table_entry->wm_type =3D=3D WM_TYPE_RETRAINING)
> -               vlevel =3D 0;
> -       else
> -               vlevel =3D vlevel_max;
> -       calculate_wm_set_for_vlevel(vlevel, table_entry, &context-
> >bw_ctx.bw.dcn.watermarks.d,
> -                                               &context->bw_ctx.dml, pip=
es, pipe_cnt);
> -       /* WM Set C */
> -       table_entry =3D &bw_params->wm_table.entries[WM_C];
> -       vlevel =3D min(max(vlevel_req, 2), vlevel_max);
> -       calculate_wm_set_for_vlevel(vlevel, table_entry, &context-
> >bw_ctx.bw.dcn.watermarks.c,
> -                                               &context->bw_ctx.dml, pip=
es, pipe_cnt);
> -       /* WM Set B */
> -       table_entry =3D &bw_params->wm_table.entries[WM_B];
> -       vlevel =3D min(max(vlevel_req, 1), vlevel_max);
> -       calculate_wm_set_for_vlevel(vlevel, table_entry, &context-
> >bw_ctx.bw.dcn.watermarks.b,
> -                                               &context->bw_ctx.dml, pip=
es, pipe_cnt);
> -
> -       /* WM Set A */
> -       table_entry =3D &bw_params->wm_table.entries[WM_A];
> -       vlevel =3D min(vlevel_req, vlevel_max);
> -       calculate_wm_set_for_vlevel(vlevel, table_entry, &context-
> >bw_ctx.bw.dcn.watermarks.a,
> -                                               &context->bw_ctx.dml, pip=
es, pipe_cnt);
> -
> -       for (i =3D 0, pipe_idx =3D 0; i < dc->res_pool->pipe_count; i++) =
{
> -               if (!context->res_ctx.pipe_ctx[i].stream)
> -                       continue;
> -
> -               pipes[pipe_idx].clks_cfg.dispclk_mhz =3D
> get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
> -               pipes[pipe_idx].clks_cfg.dppclk_mhz =3D
> get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
> -
> -               if (dc->config.forced_clocks) {
> -                       pipes[pipe_idx].clks_cfg.dispclk_mhz =3D context-
> >bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
> -                       pipes[pipe_idx].clks_cfg.dppclk_mhz =3D context-
> >bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
> -               }
> -               if (dc->debug.min_disp_clk_khz >
> pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
> -                       pipes[pipe_idx].clks_cfg.dispclk_mhz =3D dc-
> >debug.min_disp_clk_khz / 1000.0;
> -               if (dc->debug.min_dpp_clk_khz >
> pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
> -                       pipes[pipe_idx].clks_cfg.dppclk_mhz =3D dc-
> >debug.min_dpp_clk_khz / 1000.0;
> -
> -               pipe_idx++;
> -       }
> -
> -       dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
> -}
> -
>  static struct resource_funcs dcn301_res_pool_funcs =3D {
>         .destroy =3D dcn301_destroy_resource_pool,
>         .link_enc_create =3D dcn301_link_encoder_create,
>         .panel_cntl_create =3D dcn301_panel_cntl_create,
>         .validate_bandwidth =3D dcn30_validate_bandwidth,
> -       .calculate_wm_and_dlg =3D dcn301_calculate_wm_and_dlg,
> +       .calculate_wm_and_dlg =3D dcn30_calculate_wm_and_dlg,
>         .update_soc_for_wm_a =3D dcn30_update_soc_for_wm_a,
>         .populate_dml_pipes =3D dcn30_populate_dml_pipes_from_context,
>         .acquire_idle_pipe_for_layer =3D dcn20_acquire_idle_pipe_for_laye=
r,
> --
> 2.31.1

