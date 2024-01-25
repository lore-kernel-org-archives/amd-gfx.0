Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FEAC47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 16:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BCD10E91F;
	Thu, 25 Jan 2024 16:58:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE7B10E91F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 16:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH2ba3g58ylG7x4H/BMV2zImGhqqEWFmDHBXr4dGJnm2SKzCtsZooDsP/VVVya/YRCw2Q1LYtNTlStk9I6NI+KO2Irb+QPttypfbiOEhxtA8uCpGfDIBAidnAiuYNnLi17HHor6/2i5t9dYNV4QuzQqJrs18yY9f62EVBA76xi9FaaB6GqvUHN0CmXpZgrSF0/AcZVph9aJJie3i7Hx6DSIR/kNqSh2I6iw9Siz9Y83vY8WpqKIiSQ4fhqRggAhtAT0pSPN5gY/NQRyvhOZKAyZNxujAYcN0HE7KVnrXQ0GR/4cM5CysxqgBXk/Pi7X+clgl4UTT1dqxmrOVsvLXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWLEicGXPsFxdXzAa3OQQlrv8vZtLGm6NmMISIRLsTw=;
 b=UPJdx85YusJvVxiu5RCpPQb9gs0HqSCPWDwGalqK+7ZsqGgBNGQEeorRpoLj6YJM4b/uMwMT6m5GB35Ck/gwmXEdj4wG4jpFpyrt0KbarGYOlh756l+WJaqjt0lKX0aOXHbfzMXX0ayZZEDgafnLNg47cZdCc4LDkW9zXWhCcTSDaSccWUI+/dJC+JogycW2pzKpHmPCS7ZtyWdtUXaeqOHuq9pELVnu7nx1RgzSvtU0yh7cVW34SaoSO/SyJC1eEcQl6DC0bZw/LW1oDo3Rggdnd0dvyPSLE8LUYiuHYJkWO3hdgG+p1BhLW9j9yLU33OOGP9oBo06OzCeV0GYwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWLEicGXPsFxdXzAa3OQQlrv8vZtLGm6NmMISIRLsTw=;
 b=pyppwgj41ctktzZcwkLgEt0cpJyIxFht/wwiBo+U5nFp5Y9U160sNKvlFk4tyaRqUMGcBlKT+zSiwDPvEEBqz1+gF1CYPHLhbCzVvUgAPbGNNblJW0CxpsUMNtPvpHZjqC+r/XjUZ0R9qmmpHCuJlUucGI/ADSCAF/8oYQylwMM=
Received: from DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 16:58:30 +0000
Received: from DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::52a5:5005:2cf6:b97f]) by DM6PR12MB4545.namprd12.prod.outlook.com
 ([fe80::52a5:5005:2cf6:b97f%5]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 16:58:30 +0000
From: "Koo, Anthony" <Anthony.Koo@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix potential NULL pointer dereferences
 in 'dcn10_set_output_transfer_func()'
Thread-Topic: [PATCH] drm/amd/display: Fix potential NULL pointer dereferences
 in 'dcn10_set_output_transfer_func()'
Thread-Index: AQHaT6bspTveqVue1Uqlpkba/PbdULDqv/Wg
Date: Thu, 25 Jan 2024 16:58:30 +0000
Message-ID: <DM6PR12MB4545C4E353A2A45490248604F37A2@DM6PR12MB4545.namprd12.prod.outlook.com>
References: <20240125155505.1258618-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240125155505.1258618-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=45feedb9-ba1f-4ef1-98f6-c6c801985524;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-25T16:57:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4545:EE_|CY5PR12MB6033:EE_
x-ms-office365-filtering-correlation-id: dd2732b1-cbfc-49ad-478d-08dc1dc6db8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Cq+n3+tych4RG3iaYEwAVg7+fqBi0C+Lh73gaLu/0NpOQ6gYXX9DiCmaU0xKnj7NGjYWEfzDoU8iQHi1UofEfTQ90/JlerNCDpuFnQyNuGHYhpAkoNQUbjxBqltDkD9aw4uhN3KxPJQRE0U8wyFMgfXC+cUpJdRTAJzCKNcXFH8XxCqKr7NpCAQsGxmMqJ7vYwazDAnlV33mhRxsPwhDmz7vY/+o8Qm0ntYwB3I02fFtZh49UnEaJnB+TarAKzUMeoHx/wBvy1moj4kuM4YBYqLsCL7bRX7cWZioZdI6fXPkBmJue9kyZfyateP5nib+/LAZDTRSfeSC5gLHkujZzJlWt7+Bm7S6hp1yEiWkkhqVxSh73jtzM55atpGP8dTlBWsYf0eHV5orqD7e4+L0fqbdooVRJztFIu7ECtOM6dOzW4QAklEJzWOnWxzO8bK0dkJqfnz462x4iN63fY8Xz4Fbxm+n82dSNZaHqIPBCkRb459QKzo0uoYoJOByXrBrbe7ZEJbGgP2VkvDGcKJ2K1tFPTy1TiPEa9YRO9HZU2kIaotQBfjjOEAuzygkutsCcC9o3L4KMQiKQTIZ8t+v28k6lw3vjHxdU58pJQbHlziKh2gaY98mlw4jSH+JwdZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4545.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(41300700001)(9686003)(38100700002)(26005)(122000001)(8936002)(4326008)(5660300002)(8676002)(2906002)(52536014)(478600001)(7696005)(6506007)(66446008)(53546011)(71200400001)(54906003)(64756008)(66556008)(66476007)(66946007)(6636002)(76116006)(110136005)(316002)(38070700009)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9WRWzzyod1JCBG4/1NriMTX9j4jA9lZJgUGIwfdpR3/twm/lDdPwlbdJbmML?=
 =?us-ascii?Q?LXAuQoC5BrIXvoFlq9mto2aaqasO1qP/79pKGF5ViJVxbCudxXRSJ48/rrVd?=
 =?us-ascii?Q?XKdTBl/8E1CAuqqrnxngnL44Fk0QjuRkICBAlO1JLVHMBEwpXEaWeucU/W30?=
 =?us-ascii?Q?PEhEJoI3aq079Mj69QPulwxKUKM3+VYKJPK4nDIUEU4YZHWYXyP0HxAOZBPz?=
 =?us-ascii?Q?PC/RFjLo6rbEIqRrOnCBkJq/bYV1O0shFdDwls3m7pJRpCSRRNURR2Zbx9iZ?=
 =?us-ascii?Q?LJe7yZiqX/r/bq8BMKbU/MZdO0NM7qF3NuXpvx24TvwGCrCNmcLjKJdu9h7Q?=
 =?us-ascii?Q?AMRcEc5MVbdjrfrJ6yV+fCTbSEHL5ZsE25QI8OncO7+gg7zeQa589+qJYItd?=
 =?us-ascii?Q?46OvGVAcHbUP4+bzMPYZh+TmCWdJ9FKUZaUN6ARf4NM17km2WzvY0hlOTdOJ?=
 =?us-ascii?Q?wmRAYNpn5+T8CnX6t7bXX9eI0tdPuoLIA9V+kv3j8MhX4Za1oxwnipf2aYFm?=
 =?us-ascii?Q?Xov1ZtrmAy1nfqpbJCcZ0rtafaVyE7W+5TCu8DQV8PXsaoY3GAhfhFqgay8y?=
 =?us-ascii?Q?k7aVbTFzd/WZHAkTMaP+XCmCuECPxSWCrvLUqTxEkxuKfpkh5u/s+UA0Cbwg?=
 =?us-ascii?Q?XVh9oV8c+T33xhO1Eq3kfKTDxMyLDIf7p1zIwiGSGMKmhDqQfCFldtnunUYR?=
 =?us-ascii?Q?lEBnLeEuwL98t/z3jnXIT6drcPnad9IteJatuKGmWI75lF2SNLXLv9FFPQhc?=
 =?us-ascii?Q?ZeMEAAccZVwI/amMXJjCDlGcse7q/k/3zan5E0nLz64FnVViHTnGqpN1kJ+9?=
 =?us-ascii?Q?dNzThQAaulFO4bnrb9JUFq/FPlYfnqLE0CAbx2ryl6UaXMtDoZXkHIYYDJrJ?=
 =?us-ascii?Q?D1K2gf8/KIXDTuEmWtgTXGnK/twIvJ/uBdQBDZsUBHYyj0Jvm97ZhjWnip9i?=
 =?us-ascii?Q?XOu5Uz0ag18qa1Ya4Ki6gRCgC9R9Q17iWpb6RFxdHLmkgQBPhLPo1tZklriK?=
 =?us-ascii?Q?ONh10n60UEtRjiX+FQLpMIZN0QSyXSpm6cKIY8P8pgdiEN53jCKUbQwFuWSL?=
 =?us-ascii?Q?DyGH6fS+ChLV9fU2eWBJbi9JzgGvJx+2Qt/9vEh5K8x2+3Hh5W/fXpfTIIKE?=
 =?us-ascii?Q?SzP6ggvpUxaCmIS4Sjh35zanjf7mqAw6ikqMq9BiGXBP1j5MtQpx1Migc9HQ?=
 =?us-ascii?Q?b01tB0xnZ6DL7/DAEBlzCY7SQvBDl94fUZeFgWtJ+BMuAH7HpMKyXAN1WC+r?=
 =?us-ascii?Q?WITW6vzD85usNjOYh7EfEFIISWdMmf/tuEFAn/zVwrSKihrZy3l5rdl+nMGQ?=
 =?us-ascii?Q?7mG4YqwQXdHQ+oxHMX93iWsW7k+S/PtBAHDUkxfF77iDjHSdJRM9e14g7Cj8?=
 =?us-ascii?Q?oo93qiYNlUAYBSJOA44hHDJyU+kZHKwOi6zmgcIl4lSLRBFH0nlJI4dZreM9?=
 =?us-ascii?Q?6rdPCmp5JG4Oy0YCbuxDL5/Rg+So0Fz7RU5atuYpKeNA5Lp5ERV/JQRrLUMU?=
 =?us-ascii?Q?+tjEHx8oSDPCmM1w3ZelU/XlirHp9m0NQ+ELvbYRf/OqDTMf1MpFPOCSKihq?=
 =?us-ascii?Q?Lg7j1afx/IiCo9cMAcE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4545.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2732b1-cbfc-49ad-478d-08dc1dc6db8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 16:58:30.3671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtPu/GoREyvk8BgJroOCaFwTbn7Xml7XVv2pFRofGhaG1NbgXsCxlJwuK0Vhx4Fg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Wyatt Wood <wyatt.wood@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>

Thanks,
Anthony

-----Original Message-----
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Thursday, January 25, 2024 10:55 AM
To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabi=
ndo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>; Wyatt Wood <wyatt.wood@amd.com>; Koo, Anthony <Anthony.Koo@am=
d.com>
Subject: [PATCH] drm/amd/display: Fix potential NULL pointer dereferences i=
n 'dcn10_set_output_transfer_func()'

The 'stream' pointer is used in dcn10_set_output_transfer_func() before the=
 check if 'stream' is NULL.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1892 dcn1=
0_set_output_transfer_func() warn: variable dereferenced before check 'stre=
am' (see line 1875)

Fixes: ddef02de0d71 ("drm/amd/display: add null checks before logging")
Cc: Wyatt Wood <wyatt.wood@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/driv=
ers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index d923d8d915f9..22cce2b58f95 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1890,6 +1890,9 @@ bool dcn10_set_output_transfer_func(struct dc *dc, st=
ruct pipe_ctx *pipe_ctx,  {
        struct dpp *dpp =3D pipe_ctx->plane_res.dpp;

+       if (!stream)
+               return false;
+
        if (dpp =3D=3D NULL)
                return false;

@@ -1912,8 +1915,8 @@ bool dcn10_set_output_transfer_func(struct dc *dc, st=
ruct pipe_ctx *pipe_ctx,
        } else
                dpp->funcs->dpp_program_regamma_pwl(dpp, NULL, OPP_REGAMMA_=
BYPASS);

-       if (stream !=3D NULL && stream->ctx !=3D NULL &&
-                       stream->out_transfer_func !=3D NULL) {
+       if (stream->ctx &&
+           stream->out_transfer_func) {
                log_tf(stream->ctx,
                                stream->out_transfer_func,
                                dpp->regamma_params.hw_points_num);
--
2.34.1

