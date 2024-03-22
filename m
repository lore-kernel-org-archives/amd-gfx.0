Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C276C54E71
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 19:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FA710E1AA;
	Fri, 22 Mar 2024 19:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PPU3SPr6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E821410E1AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 19:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLWm1vZgA1NCV6rLX/JAdceiP3We38xKWEf9frGpJ5tXPw0mFXXTwR6/Rflw2oNgOu/E3/oNVjv1BJGvNvfUlAsFdohQcf/6Fl0/SO2/qZwtjFNpwwsPSHJRE8OAS3USUi1p40YdVdPB1I9zX+9sHChncZwcsFsIr2zR50jJC/34mYGKv4fKJbkXmLtt62tWc/wk6AgHunSmIyhtCNCkPGTP/YG6lc3TugGTjyV9P+TjaMrWl0y+Q3vwUsCq8k1KpcS696k65vneTnSpwvLgZ1g6g//MIuyHmG63SLq/kupNXb1MzIfTE4HmGRJn9u7CCUoXroNWUOUj9LyWD+oWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A7wMLAGHcr0GU4JZQR0XWKeJ6Yrcthf6mBy+oc99Fc=;
 b=C/Pf8pdnCuFalIubHCIRt6hyW+cm6bhOR7KWYBZAWQzrfu4+TIjeRpYgNwvqyhZ3OWAxne+sj+vfYLSdensLrlLhl/SYLoNhlBUcuUpkr0gkJiv4UKBdW4sc5I1e9hVi5cDDcViSMXPi+qEbQFiC5Yy7P/bvLz+f3r7dDajn0aZYiM0xSxIuy5sN9wrOXJpebXIkbz7r8oFeitNLZ0fwRwVyvumo9XsF4SF0a25LL7P7uUq60nErqH3M+Sy11g7toW8+yK7NkUiXUYxkee/73Wx8W8Qca4yk/FL3s1n2gvnG32OzBt0ILVXQhGbCeT4mgt9augmDdDW8DgZoCWdb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A7wMLAGHcr0GU4JZQR0XWKeJ6Yrcthf6mBy+oc99Fc=;
 b=PPU3SPr6bvro/xuiwK81SjjU09v3KNU/wsdK8V/qOI9rME9oBpNOrNuhMviq4BTNTHiw/lkfit/ENdGiokAfvuioBS7rAAiYqVaMqswKUw0REnh88BnRJy13mI20VzdOcFqNue3XAcqAwBQ0k4OqbRVSiIFuJyiQ7uv4IOUuYIE=
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 19:08:30 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::af4f:54c2:83da:38a2]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::af4f:54c2:83da:38a2%3]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 19:08:30 +0000
From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Roman" <Roman.Li@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Broadworth, Mark" <Mark.Broadworth@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix IPX enablement
Thread-Topic: [PATCH] drm/amd/display: fix IPX enablement
Thread-Index: AQHafIqqwO2z9LoyOE66xd+BG4w+ErFEHYZ0
Date: Fri, 22 Mar 2024 19:08:30 +0000
Message-ID: <DM4PR12MB51822C629BD7B610D9B71EABEC312@DM4PR12MB5182.namprd12.prod.outlook.com>
References: <20240322185620.17217-1-hamza.mahfooz@amd.com>
In-Reply-To: <20240322185620.17217-1-hamza.mahfooz@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-22T19:08:30.130Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5182:EE_|MN2PR12MB4301:EE_
x-ms-office365-filtering-correlation-id: 94349ba6-4f5d-4a5a-902d-08dc4aa37653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: thP1LEQYzxh4AzeyRK2lBu46UpTkM8enx3YyPzORi+2+NgiRbOKHpcuPtt4j867lTrxizl+6Qd/LWUblfE/4fyUsR3bXgnYu0V4YYtZztVM1qd4VBbcvk6k9nbkuAlecC3lXd2HreErAnCtEwCwHFYc0Y+tMwnVFf1sLHwNqjBcf6ljARDs2EMIgAz0vCNSgmgQyFM2U7OKwaXYoTFeqAkMPn5PtQRcq+92p3Tt3iv7a8P0uu9+Bq/S43Y8Sb/6CMTprBOL6DuzHc820gqbHCVR5/+LVlvRNAPvBiER96z/r9XLZg0g9JyYSyr1Diy4kxfQXg3PCum4CmKf3VGx/wyqXTweceEZlyAzzsxL6Yo3Wk2/jgZ0RE4gXqbLM7NrLPBu4l4eM2y4TQG0a4nriPZjGA7aEjGMQs/37yxjpUvlBXqFI3okBThIr7r2Fx4XxqgapmIS1TQllnSUBBWKxn9ppoJ1mxYWfcccGTmBGxcGMGEhXrx5WI53yoAe5B35Lj/zwRnIYX9p3nwSqGUEos5sJSZjp108GEGyvtc99FASjVtdHlb2nlX9PTek/+0JwxoOKjdo9BavrSqtHg1wAWIyx49MdTHfMZKSa52K5RR13Mk4y20HRl4LfUtTj08GKTVxn/inhl5AnI8/4jp3LxZUhSezageW3x+19dV1ZwdG+01vBPumO0Tl/6lQ8whIwg9D2zbH131DeMZ9d5OeM8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nbz8ESvBOy5z3qOhHLEucCoqgJuXvMuRfpJ21uWnBJB+wnkDSPwgLJO+bD?=
 =?iso-8859-1?Q?35XdLB7Jbh1ZNgX3mzVqEzCiTJsi7lhWeXD3tGYohJknsCWqfkUP3ZAWHG?=
 =?iso-8859-1?Q?sVtJiQwVl41RAfXfcplk98aYietXyWYd9B1lBeQScNVxH94Pu2C/tH/X0C?=
 =?iso-8859-1?Q?6wFjWBlGvOG2vHe/gszIJna6w/7EIR+SCHJp9MixDiUtZq/FGi3CoA8N8L?=
 =?iso-8859-1?Q?fMl2jdzfyoN4lU9OmXntS1/RQn2L25bJZFTQUa+o7IHTGiG146yB4ZoxK6?=
 =?iso-8859-1?Q?RriVX1iH38TidpynIj4FOCgbHw0LQUH2Bn0Z9aJGeaiOJBwWv/FbIfEpPP?=
 =?iso-8859-1?Q?+f7CmPb2ODrgebH20QMlsWUgxtsXLh+hdaERRF5hgO8wzwjLJ9HFVdIuCH?=
 =?iso-8859-1?Q?e1I+kl8oYbAE+MWVLRoK40GOuHWrJCYYm45oe8LWEeKatorT4PRx5672OR?=
 =?iso-8859-1?Q?tRZ6+EV8xSf9lfQttjW4tnGnaj7vT4NATgtMJcO8AcqSx1wuJePnQblBIZ?=
 =?iso-8859-1?Q?v7FTlTzLyJnm/nT1vUsR9/UzSZFoUjdb26FfnMSkm3zt1av8BGtdgloQyi?=
 =?iso-8859-1?Q?Xervf6d4+/Nf8EZdPQ1NNE+PAYdfMvLPz1VYZMBL0nNT5KatBme6ttG9hl?=
 =?iso-8859-1?Q?yz/i+vQqKRJtdNhaGpOFMBF2pTxO5F7p9TXHTJKEW3i7BVnVIWBn+Xnm5b?=
 =?iso-8859-1?Q?zQCfWi4qj7qaDW4471aHcjvM1brP+yI+79nhsAGQNukB1BzbLp9d3tI/iV?=
 =?iso-8859-1?Q?nyJwmidejXSYvu1LGO26RqDMY7c5NNqlU3yg2I9pG83n0L99wrZba16K38?=
 =?iso-8859-1?Q?KfIv0xoi/tt9ozQn1DBhVgWUQgDiiSQLd4T+1fSyWwmGcqxSobhRoK9KIM?=
 =?iso-8859-1?Q?/yISqc8cdvmhYBPMzn7Tmhj/qZQM1yQIXH3zXXHaNk3rW0y1jxgAaML8ED?=
 =?iso-8859-1?Q?osaBSveTKnhH0UaysdJimpPUa9vpDth1L5iaBU4AYjSx+TrZwJK7Jhfth0?=
 =?iso-8859-1?Q?l1n17lJoCllWAzP3AzxmRJlujmllSftztA8JYCng9GYzR1fYxmpDwb5YLl?=
 =?iso-8859-1?Q?TsPtTrZVMNIyhZFr81Gm8LIwRTMe4sYLvBFlQk6dp1fDoUV8bWOQNXHuRS?=
 =?iso-8859-1?Q?4v70BqrehD4Weyzm+ZrkqDrPACShBpcAV29YZQOKZA/N8ZiBU3zHhWeW68?=
 =?iso-8859-1?Q?xENwmdcwm2yCo27ZWWas0e2Wiz+aiwitDBoe/LcnmQrz7q9KIc3ANvB29c?=
 =?iso-8859-1?Q?wrO+5vvr52J4HoCw2JyHIXP+oEwsQZpN4tvItdb+y8Xg7AuMkzciCOtKIK?=
 =?iso-8859-1?Q?g7MeiTnFFqyDn1AbslMsdnegbLr5BO34bqM/GharRBtSSjo31LuVaCpFbU?=
 =?iso-8859-1?Q?eZzyowU9rOPblNPVw6+/cf6vPY6JYTDIuuxxCOYMf6ALYezyxWWBunkqs7?=
 =?iso-8859-1?Q?DYTcm+tjDEF97SZuSwXpFUuY0CkPaz2nvksYUrTg+qUM0EmZ/hic/bB3/X?=
 =?iso-8859-1?Q?T5E0Ufi5ecFDBwYpQ6OsGwTF49HwCjVjsAEjtdDL7054tBo85Urxr9XMqI?=
 =?iso-8859-1?Q?ikMq2O5Cyx1raJeP9JIPRKRDt0Jeucglhhctvc0MK99MoOYxXaPbzZFu7f?=
 =?iso-8859-1?Q?uImzJCMr/ZXH4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB51822C629BD7B610D9B71EABEC312DM4PR12MB5182namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94349ba6-4f5d-4a5a-902d-08dc4aa37653
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 19:08:30.4784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L31vtCnaIFsrcpyAthLsT3gYlapu2ZSZsdDJPqeUGpfSjp99/gCox39F8/eoQ2Sgm7QSU4SWKVCpK5+fsiFnXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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

--_000_DM4PR12MB51822C629BD7B610D9B71EABEC312DM4PR12MB5182namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

________________________________
From: Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Sent: Friday, March 22, 2024 2:56 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Li, Roman <Roman.Li=
@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.=
Wentland@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Limoncie=
llo, Mario <Mario.Limonciello@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira=
@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Broadworth, Mark <Mark.B=
roadworth@amd.com>
Subject: [PATCH] drm/amd/display: fix IPX enablement

We need to re-enable idle power optimizations after entering PSR. Since,
we get kicked out of idle power optimizations before entering PSR
(entering PSR requires us to write to DCN registers, which isn't allowed
while we are in IPS).

Fixes: bfe4f0b0e717 ("drm/amd/display: Add more checks for exiting idle in =
DC")
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 +++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index a48a79e84e82..bfa090432ce2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -141,9 +141,8 @@ bool amdgpu_dm_link_setup_psr(struct dc_stream_state *s=
tream)
  * amdgpu_dm_psr_enable() - enable psr f/w
  * @stream: stream state
  *
- * Return: true if success
  */
-bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
+void amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 {
         struct dc_link *link =3D stream->link;
         unsigned int vsync_rate_hz =3D 0;
@@ -190,7 +189,10 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stre=
am)
         if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
                 power_opt |=3D psr_power_opt_z10_static_screen;

-       return dc_link_set_psr_allow_active(link, &psr_enable, false, false=
, &power_opt);
+       dc_link_set_psr_allow_active(link, &psr_enable, false, false, &powe=
r_opt);
+
+       if (link->ctx->dc->caps.ips_support)
+               dc_allow_idle_optimizations(link->ctx->dc, true);
 }

 /*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index 6806b3c9c84b..1fdfd183c0d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -32,7 +32,7 @@
 #define AMDGPU_DM_PSR_ENTRY_DELAY 5

 void amdgpu_dm_set_psr_caps(struct dc_link *link);
-bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
+void amdgpu_dm_psr_enable(struct dc_stream_state *stream);
 bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
 bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);
 bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
--
2.44.0


--_000_DM4PR12MB51822C629BD7B610D9B71EABEC312DM4PR12MB5182namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Nicholas Kazlauskas</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, March 22, 2024 2:56 PM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; L=
i, Roman &lt;Roman.Li@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.co=
m&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Limonciello, Mario &lt;Mario.Limonciello@=
amd.com&gt;;
 Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Hamza &lt;Ham=
za.Mahfooz@amd.com&gt;; Broadworth, Mark &lt;Mark.Broadworth@amd.com&gt;<br=
>
<b>Subject:</b>&nbsp;[PATCH] drm/amd/display: fix IPX enablement</div>
<div style=3D"direction: ltr;">&nbsp;</div>
<div style=3D"font-size: 11pt;">We need to re-enable idle power optimizatio=
ns after entering PSR. Since,<br>
we get kicked out of idle power optimizations before entering PSR<br>
(entering PSR requires us to write to DCN registers, which isn't allowed<br=
>
while we are in IPS).<br>
<br>
Fixes: bfe4f0b0e717 (&quot;drm/amd/display: Add more checks for exiting idl=
e in DC&quot;)<br>
Tested-by: Mark Broadworth &lt;mark.broadworth@amd.com&gt;<br>
Signed-off-by: Hamza Mahfooz &lt;hamza.mahfooz@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 +++++---<br=
>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h | 2 +-<br>
&nbsp;2 files changed, 6 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c<br>
index a48a79e84e82..bfa090432ce2 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c<br>
@@ -141,9 +141,8 @@ bool amdgpu_dm_link_setup_psr(struct dc_stream_state *s=
tream)<br>
&nbsp; * amdgpu_dm_psr_enable() - enable psr f/w<br>
&nbsp; * @stream: stream state<br>
&nbsp; *<br>
- * Return: true if success<br>
&nbsp; */<br>
-bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)<br>
+void amdgpu_dm_psr_enable(struct dc_stream_state *stream)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_link *link =3D s=
tream-&gt;link;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int vsync_rate_hz=
 =3D 0;<br>
@@ -190,7 +189,10 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stre=
am)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;psr_settings.=
psr_version &lt; DC_PSR_VERSION_SU_1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; power_opt |=3D psr_power_opt_z10_static_screen;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dc_link_set_psr_allow_active(l=
ink, &amp;psr_enable, false, false, &amp;power_opt);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_link_set_psr_allow_active(link, &a=
mp;psr_enable, false, false, &amp;power_opt);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;ctx-&gt;dc-&gt;caps.ips_=
support)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc_allow_idle_optimizations(link-&gt;ctx-&gt;dc, true);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h<br>
index 6806b3c9c84b..1fdfd183c0d9 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h<br>
@@ -32,7 +32,7 @@<br>
&nbsp;#define AMDGPU_DM_PSR_ENTRY_DELAY 5<br>
&nbsp;<br>
&nbsp;void amdgpu_dm_set_psr_caps(struct dc_link *link);<br>
-bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);<br>
+void amdgpu_dm_psr_enable(struct dc_stream_state *stream);<br>
&nbsp;bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);<br>
&nbsp;bool amdgpu_dm_psr_disable(struct dc_stream_state *stream);<br>
&nbsp;bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);<br=
>
--<br>
2.44.0<br>
<br>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB51822C629BD7B610D9B71EABEC312DM4PR12MB5182namp_--
