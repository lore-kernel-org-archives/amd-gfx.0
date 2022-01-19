Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBCBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C99E10E250;
	Wed, 19 Jan 2022 22:45:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDFB10E7F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmqp612urI9AjgLlg0lgfAOROxW2s+fs1X7tDVEpzSCk8SNrqOzjpBa+VxDDKjqqEiqijnG4DzOCyZzA46XbFvsAfLU0Nu82ivXI4pNOnsRQ1fHykHTyH5Khukm2t0+OudyfknU5e8bR8ioqsOSOSfmPk32/jfFnnB/3B6RiPPtPlItZ62NTgVSbR1+UNMewj82zLDD0UKVuN6m9lZS02Fzn41a6FYbDpVD45jd5oNxU8IuWrOkYY2orHSxV1Gv9fJaIA01lhWvSLLuKmuVo7nR9y5PGlUguDK4yfNX3Nfkc4Tb/ahD286Y3dpmw2NJmjOgNWTq1IUzLajAFstmUMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzZsCVBhnQTKIwoRPBjTXORzX/8xKQFL9aXii1rivm0=;
 b=btsIRuXuOy5gT/ysGCDZV0/ngAcDguO3uiEafB4PrU8sjeX72vZ0f1YKcQtguKqTnXQde1uepeFiNI0lXDSj3XsHnsmq5GBl9zvwd6npb+PmgRff19sCnBlYgDOvrSGMlXb2oJVNOkKxbZkxl0HczEoHjzzjB+zHu59xCXk96QdJj4CIOC/wMWrxHgt6ytwbe/MMst6SsNBflLlrnl7/OLqTpdMvNSsJZU1vMyz0kyY5PX74EzMoFksj6QHvOBytClv6o7730GceV4D3jS6/aoWIbTRzOBVOCOMF0KtDjhLrGU7aLZ6O0x8gKZDk4Ps1ZkMyO1yjCp4V+UjKNqOKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzZsCVBhnQTKIwoRPBjTXORzX/8xKQFL9aXii1rivm0=;
 b=avHG5lEo2f1FQpTXVZd16iWVERZVRfeEZM4d1WvL3trr+jP/7bXI3ZN8efjvqkvEtgAlNf5R9Zc/oLuAglMbEeeh+xuxFe+ZN6qDVF58Tsl0F+oosvS/tXvfdbhS1cH8DlqRz/1duidyllHu59OeOZYBg3VIxvY8k+iIxtJVgcI=
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 22:45:13 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::e9b5:34b7:3680:6f15]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::e9b5:34b7:3680:6f15%8]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 22:45:13 +0000
From: "Liu, Charlene" <Charlene.Liu@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: change FIFO reset condition to embedded
 display only
Thread-Topic: [PATCH] drm/amd/display: change FIFO reset condition to embedded
 display only
Thread-Index: AdgNgscNmtFgM/THQ6ukUnxVYUOtOQAA02PA
Date: Wed, 19 Jan 2022 22:45:13 +0000
Message-ID: <CH2PR12MB42627CD49EE7503903EF0EC899599@CH2PR12MB4262.namprd12.prod.outlook.com>
References: <DM4PR12MB5214E88D148D9643F8CE62199E599@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5214E88D148D9643F8CE62199E599@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-19T22:45:11Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=65770657-ed85-4a74-aa3d-9695f2f12656;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-19T22:45:09Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0a5dc86a-4771-4733-b4f2-8df8953050fa
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f72ff83-0e95-4a99-e134-08d9db9d5b24
x-ms-traffictypediagnostic: SJ0PR12MB5501:EE_
x-microsoft-antispam-prvs: <SJ0PR12MB550136CD744F08774AABA12699599@SJ0PR12MB5501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8aRDypa3oEvAgMbMD9AMooHLV3PlR3+XNWpbES8eHb3OAcd0ojNlocMzWloT5dPDBrqJphuXaYB6jBLqAPu6pT82Fzd4NtSvqYSiz2S0fdKpXpCbGnOW4+1hYQgDP0MeEtebMLjxwfIxGh5Y9/tj1fT2zM5nsVzDwWvlHkELKDWvbVa75RnDc+nTikMpXaxK/CWpO+kvhwfpeI0d7fnSXDJ5nOeaLgaGo3ZoYT5Ub0YTWyV/fR3kVzB+zXRYNmjV3+kcVkyxjsQNPk5ErQdQlm2FCwaW0hkqrvMe0yp0B5CqYMUZczJUAzRhwQ/wPi6UaSHg1Q+di5cY0jajCgnV3S/Hhv4Ta0tN0PlLisvG7z/tQWimjOO+lyWXGSUKIApZ90pF3Ilxs+N5ZssYyp4eY3rt+dK5/D4Hi/goqas4ljMs2rQ26Pl97iHVrLicpWyuHBwdu+/xsvB8/K3wL0rcsFxC2R+BUiI/XwZLYGDeTiJOp3EaNoe/Gh/HU0pyyjd+hn6p24S+qXmc0VdZ7ZGZPxuffIlgR09e9HaqxnzBKinjK4sVRvQPjkicRrmGJVuCkW6uQiPsZoFV+Gfs0ygtxx13eKHXVQz0c8e7D9Hs7r7G4JqVMBoX93k0lOpbca3HBK/JWH0Ml8o2zGhjMHclHYuiNMXiNi+EvICgE8sOXulYuWS8V7zv/zYi/AdC/NkzirCX5rATWawC69MJ87TIJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4262.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(38100700002)(38070700005)(8676002)(122000001)(2906002)(55016003)(8936002)(7696005)(53546011)(86362001)(6506007)(5660300002)(4326008)(316002)(76116006)(26005)(52536014)(110136005)(66946007)(66556008)(66476007)(33656002)(83380400001)(64756008)(508600001)(186003)(9686003)(54906003)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L8fAws3V7HZRAxC2PXngNlvBYAG+G3ylcdrJjE+Am39ouTpzo5qSZL0IkqRs?=
 =?us-ascii?Q?fzYfoUKt5vK9+8Fenl4ByRD/kyJGGuCq11+AkZXiYoI/+ztkniHN7joWJgLH?=
 =?us-ascii?Q?YwCJlUN3K5HW+fvHjt+1WmWmfoQ21vuc8FultnGunijH9lyBWE9z1EIcz3k/?=
 =?us-ascii?Q?NXvarCkgn+0jkz1vIN6YTKKFoR7QOpwCHsqnuKiYrZHkKNFkQhEQdsRIyWkJ?=
 =?us-ascii?Q?ix4qTh44Cz/3fzlK5Rqc3JrevvXmsELdTkZnrN4rM2M6U1NFAGVl8HfWvTDq?=
 =?us-ascii?Q?XEikmkFRjC5CHY2lEXM43xOEq6JxA9WirFTml2zU+Gy3myHgrzMOf8F5ERVN?=
 =?us-ascii?Q?4/fifzvl5j7KC0tdl3IdMdtK1cQ8VQ9sAkKTO7pHLzjTrr7GOaazMeRB017V?=
 =?us-ascii?Q?xMGq5o9NlMdnCe2qc0Xm5Xb243yagPkhdZTmnfRT5OSe2xFOZjnx4b2+ye6P?=
 =?us-ascii?Q?OflTqW5b4vqPbJ0+yEDAoRUpMfrorF3EtRPjW4qPPOBb7zNsLg4Jghn5NgZ6?=
 =?us-ascii?Q?7iop/bgNaGv6ddH+Gx1drPwpIJ4wUeMOtAGuo5N+2Xdf8O09eUIvCjTXAD6Y?=
 =?us-ascii?Q?cXG3svBLvW+PWn3MFBbvpyBUBhwqPih3IikG/IMUpOIY9z7b0kY+Dter7LJX?=
 =?us-ascii?Q?UjZMpMZFcTFOAh4rx3WUl7yX7B+Iai4eKHGgRPA1xGyvuuV60NOlTrwp/dWb?=
 =?us-ascii?Q?RdJL5y1qdU5b5P3opB7YgIQBQ2oFdy/JeJcZgfC/zEkWNTq8dcsdsRmUEINT?=
 =?us-ascii?Q?3PrVvxBK5JJvtTEVo4De2ARZ6+Ecl+kfNj5l2lYNgfA0LJKxhWOVjP6jMhnH?=
 =?us-ascii?Q?u1JE8qS33e5A7Uf8HSqFt/ENfNMK7r7ISalGXOwBiqm7uIBtELDOmnO0qlhL?=
 =?us-ascii?Q?FzjXNbgCMt/0aPnP56szP5ALeFjICJpne9IqluWGb4aR5ySJWfOZAmvyXn89?=
 =?us-ascii?Q?PGHPVZPijQD0w+xHqe0+9l8IOlxKNxtEggDAAr5fYt4huWdc2Bt/pD7jnkKy?=
 =?us-ascii?Q?TGYVeGgGJb2T+xVfI4LHIWxMaU5Im42P1OJu31Ox2xK0DI9jBDcEeYKLe9On?=
 =?us-ascii?Q?3/cN9BP3gfN1K/DicPbwXZCM4CmdNTS1BZlbv7UxN85rS8QTRjRo2ZQTK+E1?=
 =?us-ascii?Q?vtFbr+iMOzY1ZP2ETRIqBHOdG3Wh7fY6fndQ8nCLYLAmYfbZmb/2vwdlk5dd?=
 =?us-ascii?Q?UrnPmiNO6qr8bXhU5Ds76iOfNWMeCXUuTEINkXp6OTSpqTL8ZrskEmcBFPJA?=
 =?us-ascii?Q?7XJamR+tc2ScN8n/bytyinWhwqZvGGJBem7Nsl7sAvy3V2rJptLuqlWj78Np?=
 =?us-ascii?Q?EOUIjxlfc3JFd6QC3ISBU685k0iwwDGknImuvNzW8cCIjR5cyY8WPmPq5ZN6?=
 =?us-ascii?Q?ORAzEZh1Gzz3BGLx24YBv8aVKLat55azp9WKVvT/jSGtggLaB5hMBeIsmNYn?=
 =?us-ascii?Q?+Vfi+tpMXwxaDYbjKzrPSI7o9ZBqp89VcLPzGDClJyfSnIucp+LeraIK9U9B?=
 =?us-ascii?Q?rr9U6BmwHw0QarSQdhb56P4kxOKv9bv9sf59N1+8QiQ5Wd/41tVL89v/boEz?=
 =?us-ascii?Q?R+PWaWvTHH7R+1qwYak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f72ff83-0e95-4a99-e134-08d9db9d5b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 22:45:13.4192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXk1QfCvYPuiG/A5z6CypxphqX1GUE19FVlXprwo7QmxdCvAOTtbAxvHRHmxivE6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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
Cc: "Kotarac, Pavle" <Pavle.Kotarac@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Cornij, Nikola" <Nikola.Cornij@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



-----Original Message-----
From: Liu, Zhan <Zhan.Liu@amd.com>=20
Sent: Wednesday, January 19, 2022 5:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Charlene <Charlene.Liu@amd.com>; Cornij, Nikola <Nikola.Cornij@amd=
.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavl=
e.Kotarac@amd.com>; Pierre-Loup Griffais <pgriffais@valvesoftware.com>
Subject: [PATCH] drm/amd/display: change FIFO reset condition to embedded d=
isplay only

[Public]

[Why]
FIFO reset is only necessary for fast boot sequence, where otg is disabled =
and dig fe is enabled when changing dispclk. Fast boot is only enabled on e=
mbedded displays.

[How]
Change FIFO reset condition to "embedded display only".

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
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
