Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B3C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 19:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51ECC608FC
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 19:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51ECC608FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843BA89D02;
	Fri, 13 Aug 2021 19:21:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B3E689CFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 19:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Anm1UkFdKlcZ5QHQQnbqvBB1QtzCehLw0JhH6VAYGJfaC6juKGajio4JBoTYnvw6SLmeVKewjPez89a1fSbOnPz9r9jGUYcKaW6QuzVlkzvV9EpyapUSqV7XVnaHxcJgHVh6XiC+11z22wIKkiR0bpSczNz4FRnt6KhulTCj4WQWljYe0L+5mlv8iBQe4mvyGmaUXbhJvOOT0rukMikkgE7apfbzxwvOr0sclJIcqGXBleC+DRDF6x1WXCxYQ4XNJCMQg0SKYxwn3wWoEliVth3WgTMzc5xnB/iil68t5scGl8xzDGNLfYKF8PIr4lAu1NxO3nr2HjUM5XepLeaciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxLunaCtuI9LtVZeA4bV3b8c7Qnb3e4yoxLk0PTkkl8=;
 b=N3IvQEkXox6gsQKqoVXb8XVEaeqQtN57H90+xID8w3Hwv3KEpHqyhplwEWwxTdvqKTEq3AFqYS4Hrc2PPuFVjB654LwfNrU2ebtOoEZ4wMBfJOHybnyqIfVdEaQ5Q1d2R7gW9ctNNH5Rjnpj4xMm91gkGzBPzGvHPNE85tRTPgjxJw9Ij2gUv/kY9UI5xz4n7wudMm+s53VRj8NUqX+nuorLFjFW3GPZVZ8KLi7dDw/qVoaxnmEydwDE6PzZZc8SpSZi2E66QSTdWiuEco1O10zP/Wjyaj02MLUzPrcTl9Hz0jagYej5bOKHL9ICIqvKcO5o/wFsvK4ZqVSXqPI7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxLunaCtuI9LtVZeA4bV3b8c7Qnb3e4yoxLk0PTkkl8=;
 b=jQdhDFGj2LOUbZ9cxuqptzAlEKzQ7SQjK4KDf+67TzIEF250wUapqGuh0SRmAcmCPUUEGoXXBhwLusB3iWWUewoRb7QOgtIAphK1JCudG2V6ZChnyQb8Vjs5tduynDuv6oi6cG+DeqC24uOukxvpXjGbnLb56FxCNbFWd/RzfUE=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Fri, 13 Aug
 2021 19:21:26 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::1530:e189:a79b:5f8a]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::1530:e189:a79b:5f8a%7]) with mapi id 15.20.4415.020; Fri, 13 Aug 2021
 19:21:26 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Cornij, Nikola" <Nikola.Cornij@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>, 
 "Logush, Oliver" <Oliver.Logush@amd.com>
Subject: [PATCH] drm/amd/display: Use DCN30 watermark calc for DCN301
Thread-Topic: [PATCH] drm/amd/display: Use DCN30 watermark calc for DCN301
Thread-Index: AdeQeDJ9W948wDE7SUK137chTFtOtA==
Date: Fri, 13 Aug 2021 19:21:26 +0000
Message-ID: <DM4PR12MB52146EC560946C5875B085FE9EFA9@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a5cd413e-22b1-4fdf-988e-daae20ddea0e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-13T19:18:31Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ed6429-120c-4983-3365-08d95e8f8ba2
x-ms-traffictypediagnostic: DM6PR12MB5550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB555014DB5021625651E20F099EFA9@DM6PR12MB5550.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:38;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHv2BD+KcOVdHtzA4L0/XH0Pr4Ed+Pr/5DS2dYXk5wA7SFVbFURLE6XP5m8rzC1nCgYZe0tUr9cMXLhI6z0wDaExBq0swR/DzAAtNFFQicrrihh2ttBJnJ1FRxQ8Rk1PvBaVFnS1t5qEtYkyddb3N3hsbf5Mcaxdkftl8L/FMn8d5STuK5AupxtRdHzWqSksIfEbwxvlSW3PA+l5O7E0trLhGtRHPXYVcdwkWTaZhNukjOhqJWxRpLBjq2YRIzPEGuuQ8PO1wu7srTBC7P2tJmApmJR1sGesAQO2d3DxIA4Pxf/coHZDDNYzMQsJ3G/AHiIGpEK/4K3YLycTd9XRrMWNWtPckg4HH5XbcPB96TYsdnkQhCqyfuj5KFYm9moPKVs36za12r1JXTkv3RjAB7W0uUDrkt7yqvoqBLogTSa8d1WV4PiIIZkLKwqnnZPdzKuzmratzZoaNSPDnfmcJgVCR6n7GxtV4e1rNOtZaC6DYHCx8qjzpdiQ4MdrzRi7oAD2XXLbk6S48xX5kt05qe8n+Z10JmPDVr0Y7qBa+R9MDl6TDKb7Scddo5rCu4MuyiA8J+xegtV9/LXDr0Tgd5KDB+N2TyCwsxAOQxodncZmQS0tjfyMM/BxGTEK1fyc6I+SY8tMKkxo48z6VWJ147KODiCVC33MZ3QwFFvjAShF8odCNijUcKIrUOl8fVSW9/vxLPJ6px7lE2qrxOKWtA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(316002)(66946007)(66556008)(64756008)(66446008)(71200400001)(478600001)(66476007)(76116006)(7696005)(83380400001)(966005)(86362001)(55016002)(33656002)(9686003)(6506007)(2906002)(5660300002)(6916009)(38100700002)(122000001)(52536014)(54906003)(26005)(8936002)(38070700005)(4326008)(186003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lIlN5+VzLlwug/GuRaXZT8IfX8VPEUDfbNKOBOq5xyakftKVInGT7e715v3K?=
 =?us-ascii?Q?r1EHnSY1GSsEsDpWi4uOWiQN0g5k1kMoxZ8YKPt/A9prLGn6yxySB3fYxH4s?=
 =?us-ascii?Q?UzbhUrCtrmeC6j/xuqYI4VPN7VXvsuqkMccgYzuX0oTqVchpFc0Q7fmDnSIZ?=
 =?us-ascii?Q?hcMI0dkouG/962mBLS2zfP5G6ZGJ8T6K5JBvK3W5iG0mfIoiWHMx00eFLHJi?=
 =?us-ascii?Q?KeGTO3Pa0HwGkHIk0QinZNSV+sHtyqQ2qvid5CkSRKXq8X79FlUFWEgkPiIi?=
 =?us-ascii?Q?miJEx/TjXdsM5CEE5ENhaLyDUFdf9IHFrg6CbcciaXdm0oiD+mif4iT9gD3K?=
 =?us-ascii?Q?e6q2g1QkJtMEDi1m9bllJGgLOcMY2yZgz7QeLdAsnDKRlmqHoUvhQY/FeQPu?=
 =?us-ascii?Q?9QCfoHMzDJ2o28ET6nqoUx3BGVQthHvms6g/WJxuw4DNp0o3HdU8GAWkRD6k?=
 =?us-ascii?Q?snpNPG1wjTfCebSTsk0hfvEUlkaQYHkjA3zTAgOvwRzmyKqQQhVzbcdFLQZm?=
 =?us-ascii?Q?YRXfIAyrDEiBoSVvGUzF+qlIOvUTK6ay46p4jVGzVI9wzUflu5mA2nR4hT6w?=
 =?us-ascii?Q?DeBPKJy5Wea+559L76ryFuNeif/V0Xhox97Mj2MWvDiAHtaUBRN2Kz7O1SXK?=
 =?us-ascii?Q?v+FLyWbuJjbFnk6lndduaszwCspt0NbPuQfjxf5K/GjEU+CLp7Z/BQPu5sfk?=
 =?us-ascii?Q?OhsoO/U2vlBYHIYxYL9ADYFjzgRz3t2KrCSymGz+ELVZqNPdAtz1qGghFK3Z?=
 =?us-ascii?Q?3NX7dmhTWdWSnLKPF6uLMf7HsdjIpXRTXTrghzB/ZVU+rs84eGXBLjc4/xRm?=
 =?us-ascii?Q?ya6wlKySryfxeUa2+qHyB6XZ3k6NMvcmyVRmsLlwKW0BxCn93S3dBx8AfwJf?=
 =?us-ascii?Q?17TKymVPYdNbLSHwRtgwYBC1t1ku1MwzQBR6SivJaXoDP+ZtbEzVUi46zB++?=
 =?us-ascii?Q?oLm9u9qx8IBosxsyB8L5mA00gEqNeUZgc/lhp1cxGuj5F3pPpUeSsLv4iPGO?=
 =?us-ascii?Q?lk9asjmzAduqkaUc1iqaSJ/mOMCsOE3a6S4tKk5TTAG4fqwgAo7OVQnu26pP?=
 =?us-ascii?Q?UViYsItb62DeXFsnS0Q4DKH8z+EIz1W35iOtWBkSNjrxrxxV8u/j0sISJsa6?=
 =?us-ascii?Q?C8WpKNAIS4fI9Nq4PK/YuoJM4hw5Jfbr3VApEFBy6UmjzHIxxJYgdxBVD6qC?=
 =?us-ascii?Q?0eydOAoDFffwHGIimegyLbZCmnaFM3u3DNCAp5DfbOdXppGoNbJ/elw6FH0B?=
 =?us-ascii?Q?ANACT3F7diXSQrz3oJyD6+/AvjmMbYUMEVX8wOTC7og01jNI7oa4nCcVva5f?=
 =?us-ascii?Q?XecTiW2j1l2hvRfQFGj+58JJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ed6429-120c-4983-3365-08d95e8f8ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 19:21:26.4408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSd/RYZTRY1IbXN+ubbkL9ZhWRIkra7sOLCAI55EaqAhGZvDySUm/vfQER7FmkHZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
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

[why]
dcn301_calculate_wm_and_dl() causes flickering when external monitor is
connected.

This issue has been fixed before by commit 0e4c0ae59d7e
("drm/amdgpu/display: drop dcn301_calculate_wm_and_dl for now"), however
part of the fix was gone after commit 2cbcb78c9ee5 ("Merge tag
'amd-drm-next-5.13-2021-03-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next").

[how]
Use dcn30_calculate_wm_and_dlg() instead as in the original fix.

Fixes: 2cbcb78c9ee5 ("Merge tag 'amd-drm-next-5.13-2021-03-23' of https://g=
itlab.freedesktop.org/agd5f/linux into drm-next")
Signed-off-by: Nikola Cornij mailto:nikola.cornij@amd.com
---
 .../amd/display/dc/dcn301/dcn301_resource.c   | 96 +------------------
 1 file changed, 1 insertion(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 9776d1737818..912285fdce18 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1622,106 +1622,12 @@ static void dcn301_update_bw_bounding_box(struct d=
c *dc, struct clk_bw_params *b
        dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_=
DCN30);
 }

-static void calculate_wm_set_for_vlevel(
-               int vlevel,
-               struct wm_range_table_entry *table_entry,
-               struct dcn_watermarks *wm_set,
-               struct display_mode_lib *dml,
-               display_e2e_pipe_params_st *pipes,
-               int pipe_cnt)
-{
-       double dram_clock_change_latency_cached =3D dml->soc.dram_clock_cha=
nge_latency_us;
-
-       ASSERT(vlevel < dml->soc.num_states);
-       /* only pipe 0 is read for voltage and dcf/soc clocks */
-       pipes[0].clks_cfg.voltage =3D vlevel;
-       pipes[0].clks_cfg.dcfclk_mhz =3D dml->soc.clock_limits[vlevel].dcfc=
lk_mhz;
-       pipes[0].clks_cfg.socclk_mhz =3D dml->soc.clock_limits[vlevel].socc=
lk_mhz;
-
-       dml->soc.dram_clock_change_latency_us =3D table_entry->pstate_laten=
cy_us;
-       dml->soc.sr_exit_time_us =3D table_entry->sr_exit_time_us;
-       dml->soc.sr_enter_plus_exit_time_us =3D table_entry->sr_enter_plus_=
exit_time_us;
-
-       wm_set->urgent_ns =3D get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
-       wm_set->cstate_pstate.cstate_enter_plus_exit_ns =3D get_wm_stutter_=
enter_exit(dml, pipes, pipe_cnt) * 1000;
-       wm_set->cstate_pstate.cstate_exit_ns =3D get_wm_stutter_exit(dml, p=
ipes, pipe_cnt) * 1000;
-       wm_set->cstate_pstate.pstate_change_ns =3D get_wm_dram_clock_change=
(dml, pipes, pipe_cnt) * 1000;
-       wm_set->pte_meta_urgent_ns =3D get_wm_memory_trip(dml, pipes, pipe_=
cnt) * 1000;
-       wm_set->frac_urg_bw_nom =3D get_fraction_of_urgent_bandwidth(dml, p=
ipes, pipe_cnt) * 1000;
-       wm_set->frac_urg_bw_flip =3D get_fraction_of_urgent_bandwidth_imm_f=
lip(dml, pipes, pipe_cnt) * 1000;
-       wm_set->urgent_latency_ns =3D get_urgent_latency(dml, pipes, pipe_c=
nt) * 1000;
-       dml->soc.dram_clock_change_latency_us =3D dram_clock_change_latency=
_cached;
-
-}
-
-static void dcn301_calculate_wm_and_dlg(
-               struct dc *dc, struct dc_state *context,
-               display_e2e_pipe_params_st *pipes,
-               int pipe_cnt,
-               int vlevel_req)
-{
-       int i, pipe_idx;
-       int vlevel, vlevel_max;
-       struct wm_range_table_entry *table_entry;
-       struct clk_bw_params *bw_params =3D dc->clk_mgr->bw_params;
-
-       ASSERT(bw_params);
-
-       vlevel_max =3D bw_params->clk_table.num_entries - 1;
-
-       /* WM Set D */
-       table_entry =3D &bw_params->wm_table.entries[WM_D];
-       if (table_entry->wm_type =3D=3D WM_TYPE_RETRAINING)
-               vlevel =3D 0;
-       else
-               vlevel =3D vlevel_max;
-       calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.b=
w.dcn.watermarks.d,
-                                               &context->bw_ctx.dml, pipes=
, pipe_cnt);
-       /* WM Set C */
-       table_entry =3D &bw_params->wm_table.entries[WM_C];
-       vlevel =3D min(max(vlevel_req, 2), vlevel_max);
-       calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.b=
w.dcn.watermarks.c,
-                                               &context->bw_ctx.dml, pipes=
, pipe_cnt);
-       /* WM Set B */
-       table_entry =3D &bw_params->wm_table.entries[WM_B];
-       vlevel =3D min(max(vlevel_req, 1), vlevel_max);
-       calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.b=
w.dcn.watermarks.b,
-                                               &context->bw_ctx.dml, pipes=
, pipe_cnt);
-
-       /* WM Set A */
-       table_entry =3D &bw_params->wm_table.entries[WM_A];
-       vlevel =3D min(vlevel_req, vlevel_max);
-       calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.b=
w.dcn.watermarks.a,
-                                               &context->bw_ctx.dml, pipes=
, pipe_cnt);
-
-       for (i =3D 0, pipe_idx =3D 0; i < dc->res_pool->pipe_count; i++) {
-               if (!context->res_ctx.pipe_ctx[i].stream)
-                       continue;
-
-               pipes[pipe_idx].clks_cfg.dispclk_mhz =3D get_dispclk_calcul=
ated(&context->bw_ctx.dml, pipes, pipe_cnt);
-               pipes[pipe_idx].clks_cfg.dppclk_mhz =3D get_dppclk_calculat=
ed(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-
-               if (dc->config.forced_clocks) {
-                       pipes[pipe_idx].clks_cfg.dispclk_mhz =3D context->b=
w_ctx.dml.soc.clock_limits[0].dispclk_mhz;
-                       pipes[pipe_idx].clks_cfg.dppclk_mhz =3D context->bw=
_ctx.dml.soc.clock_limits[0].dppclk_mhz;
-               }
-               if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.d=
ispclk_mhz * 1000)
-                       pipes[pipe_idx].clks_cfg.dispclk_mhz =3D dc->debug.=
min_disp_clk_khz / 1000.0;
-               if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dp=
pclk_mhz * 1000)
-                       pipes[pipe_idx].clks_cfg.dppclk_mhz =3D dc->debug.m=
in_dpp_clk_khz / 1000.0;
-
-               pipe_idx++;
-       }
-
-       dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-}
-
 static struct resource_funcs dcn301_res_pool_funcs =3D {
        .destroy =3D dcn301_destroy_resource_pool,
        .link_enc_create =3D dcn301_link_encoder_create,
        .panel_cntl_create =3D dcn301_panel_cntl_create,
        .validate_bandwidth =3D dcn30_validate_bandwidth,
-       .calculate_wm_and_dlg =3D dcn301_calculate_wm_and_dlg,
+       .calculate_wm_and_dlg =3D dcn30_calculate_wm_and_dlg,
        .update_soc_for_wm_a =3D dcn30_update_soc_for_wm_a,
        .populate_dml_pipes =3D dcn30_populate_dml_pipes_from_context,
        .acquire_idle_pipe_for_layer =3D dcn20_acquire_idle_pipe_for_layer,
--
2.31.1
