Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDB9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A02F10E62F;
	Wed, 19 Jan 2022 22:21:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1531810E62F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vswio+Goww9/tGgLWwlNJl0ovhEDNSDKCdXhG7BxCgSUiHxtQwfMEY/H8dVasXpHuQmB/m7/J5twXBDJezYq+KgtyfLijc0OXFgETwMirdJrPALFdIGd021U2ykiEh8d0+syjDiFX6tquX9+q0yutDXtm+fTWPi2B2GGSMsxi92iKHwGu6oxzHK7T3xm2+WIteEaCWtSwe3WxJI1fvLj5Corybj37+q603gatlcU0H6GWItjF2tgGRBtAyZar9ulNI7a4xUVonsuOrC7d0kRvQzRKwhRM/pn+jf457nnT1Mmg/gal/077LNS2jXouMf97BoOgcVZBz2MzbfAzUoLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQiEjz/K8JQHmfMB4ers4LRw+75rpkv1drNWFAi9hoU=;
 b=GMnBceGLguopMvo6m+S0fVlUAR6V3lCaaWlRYP4fn0oBhU2AMCsCEPYXDtWs0fODp3o2ek+U5S+f5QlMxg6CcFMnX4kaZnglfYdAXwairqEX7Wi1SU03ZdKoaY1xdecNJEG5EYsH7hdIMWYGQ+BMIsk1A1qAHQR6QIs1uFuUuub574lXuP8VECJ4zo1obKy4qVYmDh+UaLYBEfsPHAtm6mFMb3WAL8Hj69njf3hXF8lIwpqpmwLxcHjMTp90TI+G7zhEETDLSJ2NupPS8JFEFXp/EoFuoOcplz/y4/dEzI88wGccj4yiIJ0gLkMjyebvGn+Ibvl9v8ob4w5NXsXZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQiEjz/K8JQHmfMB4ers4LRw+75rpkv1drNWFAi9hoU=;
 b=AkDmdpO1ulZzPY2FWFibOVha9o9sJf6Lae78lQWNKnjHPtDxO720ZhwF9VhYa0ctKdAp2TrAVELSYl/i5T0qS8dqpPYR5qowJnl3VJHouwNHCekWTr6o1tFh2GK2NV92uZ/k2Aa7tDTdzwVDbrwKRH/LoxyhBInixxJse3nKfVE=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by MWHPR1201MB0047.namprd12.prod.outlook.com (2603:10b6:301:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 19 Jan
 2022 22:21:37 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 22:21:37 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: change FIFO reset condition to embedded
 display only
Thread-Topic: [PATCH] drm/amd/display: change FIFO reset condition to embedded
 display only
Thread-Index: AdgNgscNmtFgM/THQ6ukUnxVYUOtOQ==
Date: Wed, 19 Jan 2022 22:21:36 +0000
Message-ID: <DM4PR12MB5214E88D148D9643F8CE62199E599@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=65770657-ed85-4a74-aa3d-9695f2f12656;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-19T22:20:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60d2be6e-539f-481b-61d6-08d9db9a0ed8
x-ms-traffictypediagnostic: MWHPR1201MB0047:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB00473A4D927ACD5FB7B433209E599@MWHPR1201MB0047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d/MDcU0t/qz3D8vt6DSCzSOUEKnS9e1DbqFsteWW4ZEq179hMR7Nq5X89KIHpqYteFqbXnJBE5yY1OrlyD7o4cDvF2CMR3dJurWicgxQBf6+jMSJvVK0tlWi6ZpsOl6Tuee+BsGvhiiQTuyuxOm8Cq/lAyY28G9ctGw14sbQ2vSo2QDtWt9aw8mjrXvCs2jmsCh3G8dyCp7AYK+5f+iC/fgmbSCuXEzPBoa/6Dtkh3OnTGqgQy6e70qlVC5gbdIyXC1fHBPYpfCXECI8pVmRaoqf5MhbjmJIRJ1zyn6lryLbkKb6jB8zX+YjSY3XL6ZBylkjQcLBrwkPaE1LJ+KaTMsK8xNU3uxbLLmRRcbHahodCXREUPzvPXN9agj39pSACzcZLgE/QNJiA+SexifMY22EbokO/FSDvCXmlZDdGAnq0TyJ+JTIYjqYOTrdZjY2xQZazVbkDj+I0ZgJQY3xv5obRQgm7nMq878LmBtBxidX9SAzICQruTpg0rWOxCMB0YDc98T8ryrvRabLirKXLKPyzJ3vxZMuTPv33JVnZ6evzYA7Mk6G06GyrN1rc7JMD2Y6pvmFeoNzM+FR9BMmJzm9E6hnQ03LKWscNoR0XyjYh4ovV1Sz4JRgpTka/Z5aXH+Y/XiJ5LByDeUQErNDwYE99PhNsEub9pEjfLzBqh7JXvpjVW3ucrX2RGTP9ZkdTxlpSMOWGqaSdoxUkiVQkA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(2906002)(66556008)(7696005)(86362001)(76116006)(38070700005)(33656002)(71200400001)(54906003)(5660300002)(64756008)(66446008)(66476007)(6506007)(9686003)(55016003)(6916009)(122000001)(316002)(8936002)(26005)(83380400001)(66946007)(186003)(38100700002)(508600001)(52536014)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bQW20oWpphFccvoMOaD0ydhh7kf4rAqppzHnACHyV9tPDsBMDVnM7mBHAUns?=
 =?us-ascii?Q?1NswDXMflikJp4+LlcZLm07cFdxDUyH3zm4WiPwt9+zeVFN3a0mgYaXbaZ7y?=
 =?us-ascii?Q?m5dcUGo9EmQTgz2OncDyZqK64h0OANWqp9O2JYmWBsqIuwk8ARlDAlhosjyo?=
 =?us-ascii?Q?NPcDWVvF2egvi+752ymUdx5paI208iwp+EnxL0O0oyG1El95Ic0ndLAFkrKP?=
 =?us-ascii?Q?PAuK4Uz8esMtVkt4VJtICC0/PD3vzMyt/vCt8B0np8WLCSUzjwgdUFaNhb8b?=
 =?us-ascii?Q?xLnD2cmUlBlaRF3aDeSk59qDyl61kJ3Rvwi+ijRGcLtDeEK+lu/3SN8B+CVr?=
 =?us-ascii?Q?QWyHNgBAlCy/iaeHH/Qx6iQOc5LK4otcO5RUPGqBIRcP4x8m+A/K4HI/XhvL?=
 =?us-ascii?Q?dnfLKnG4DhbHPOnZF78BzXmURCv3gPYw4O32juXn0mDCuUGC9wfLGmXVU69R?=
 =?us-ascii?Q?FdwOzO1ospCwVru9J9D5OrUuj2hfaUoZ7O2zTzfpPvhbU9V5wTjycqRtehex?=
 =?us-ascii?Q?MQ1eO5YcGPWfJH7LFo8vrl4lXjmvN0z+aHpgnjbZ5xGnv/bC82maFUzZePcM?=
 =?us-ascii?Q?/mylha6ZXV7hKEUaD1Tq++45Wn0BGw5SJs4tqP4dN9/r0FPobhv82P0cm6LN?=
 =?us-ascii?Q?Hv73y5O4m1dtmUGrDd8H06MpD3d5lQXUieGBW7rreWoziHHtpLgyBSsdesof?=
 =?us-ascii?Q?zgz579W7GK7cEsgcK7tyzkCxV4/4vco077e0tyl8X68L21Ad7LLy/He6EnOc?=
 =?us-ascii?Q?ePoRql8Wlwev7XKDUeQiEf5kYrnHiq/zaxilFtrtRo9S3nG4wjliZNit8xD1?=
 =?us-ascii?Q?xvT11ytYgxJhLvCgZCNVTtMRkRd4cTgEqCXdGxZDV35nn7kJ1Kz1PbAicw8z?=
 =?us-ascii?Q?/oHgY0FRKsk7rcNLRDHvIuG1TiR/4lLUElBV1qntHEpuMhRJfhVHE47YVIC1?=
 =?us-ascii?Q?/PSTG40tvSZ8U8EjK4xcdCxPs8VOSIvx7EOxDqrek7XjM2Bplx+a4kJeic3r?=
 =?us-ascii?Q?ZRbbHKrX3KV0g1jFkFpX7pSz+kBFlhsCotyM6MLzOgEtmj465VZI/b6ifJu+?=
 =?us-ascii?Q?vLGsN7mq/dSBN3kX/uWCCefXSS+FpOXLSzjVO3Oq+COj2fSMPV0Sy/GRX0NW?=
 =?us-ascii?Q?zyttoIkvib4Q/XjbuytPTHEhf9ZqGTdZhUleCn68YoY/r4aDo5MzZqd3Gemg?=
 =?us-ascii?Q?dkS3n13yoshwcVGGuy4smWXZlKErEdVZonyT9BkcfPZeLJWObgLYRqR8nc+X?=
 =?us-ascii?Q?7ZNlANDs1l5z/b4nDQ5/kppqBVCdrTketsVnTrfia05V7lbH51/o/05fSlCy?=
 =?us-ascii?Q?1YruofEKxOFKTsZZLr+gk+lhui02fQyPWqyKrFnn7sb7O5UiT6Fz9ua5rXHb?=
 =?us-ascii?Q?db4EDliBubqQyJ1JkD9TI4pjRkwMp6lSsC/oxvX+/bP+fCuMcz8Ood0j5rXV?=
 =?us-ascii?Q?YCThp45ectk2Nd9Nz0W+TTalq/c5GkL5bXGyl2GXoulWTNyxm0oSzVgqjJm8?=
 =?us-ascii?Q?LPDzEHuWyyAbY+hhHmQdKXjwBJWnQb7dkaM6wlP4+Nl9jfbAMPVlVtez+cyG?=
 =?us-ascii?Q?ElN6BD0jmNH9AONJBwk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d2be6e-539f-481b-61d6-08d9db9a0ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 22:21:36.8425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BTJkueiN/Hkq/Y8CiRSA6EWgEyqmXa3m7aJQ1cRztLRDOQqtM6ukyP2tmerode/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0047
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Cornij, Nikola" <Nikola.Cornij@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

[Why]
FIFO reset is only necessary for fast boot sequence, where otg is disabled
and dig fe is enabled when changing dispclk. Fast boot is only enabled
on embedded displays.

[How]
Change FIFO reset condition to "embedded display only".

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index f1593186e964..f3ff141b706a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1608,7 +1608,7 @@ static enum dc_status apply_single_controller_ctx_to_=
hw(
                        pipe_ctx->stream_res.stream_enc,
                        pipe_ctx->stream_res.tg->inst);

-       if (dc_is_dp_signal(pipe_ctx->stream->signal) &&
+       if (dc_is_embedded_signal(pipe_ctx->stream->signal) &&
                pipe_ctx->stream_res.stream_enc->funcs->reset_fifo)
                pipe_ctx->stream_res.stream_enc->funcs->reset_fifo(
                        pipe_ctx->stream_res.stream_enc);
--
2.25.1
