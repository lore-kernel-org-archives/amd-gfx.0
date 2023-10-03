Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0719EE7AD58
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 15:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B4610E037;
	Tue,  3 Oct 2023 15:13:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB8110E037
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 15:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/kHLGulilPogS4Cckb4ERoUiO55rAj+M69rWZOGZDCwgUnMXqddCPXrRY96+o/oSJyPv/WP6xcNAkX6q/V2RTwtZbYqkr4hAvMmlAZwmGfgZFHNfI8f0mZzKqbfgaSUnqrBA1PgkSxSmGzWSRwigItwbfUEr2mQRq7ALT7bqrIBvYkdg9FzKIeWAJrRedK4eQfKcRbgOayR+lmlMPEykCZ6YEQT1gCEgBQws4b/feKqfaUyxaDXwWXQQmfTObrE6xjmdSntAbPn8EUpby5gvUEAfsqngGT+65YJZiaWbBrkEKPvLKeDS8dROEgWC0OZQc0hwOI2j+GJ2e1Y7+z5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5JgKgrVu11onhR2DW46FCf738qp6j/6DFj2VnPDlvQ=;
 b=kmRoZQDOM5VVK34RpahZzqJNh9nALuiad9eC0PM6nglaSpB+befLNr90TlD1S+rzwqca/yD5B91EhmwckkmZajc1RMQoYap+58YLCd6vLNVaHa/PUb2Xc3jfimU8N8HvIS93N0ognKJXlrE83/nKqyCNmwvlIF+0noVBBRc/NgvGJ1nCk9SBHyiaOQWRo7jEkks9fUvU3pLFr8Gh1JD5rYVgncNWjTOO+SL3OB1Uf7T/SLjsh331axw02hCWPDp+gg8sz6oACyhigKo4GeQJnhek+WoD/Uch05D9HbShUodDD8ACYqxE/IKqXcPkkVnmgq5L1XrBK91klDOZxuRF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5JgKgrVu11onhR2DW46FCf738qp6j/6DFj2VnPDlvQ=;
 b=XCzFSlHfefARO6BIqdFzNFiIi/YBs1KshipVzkysVQsM/4mbQiJcyREKtDD6IOBP0CMNUrZwF59yZ9Jtn/oiSJZZhph6gCCWheTITJmTqHq7/BxTWGQEbzmAUPpf/Rw8a2edwtE2/VYbFNcoL0rP0w+JqdFsqCLnRidfvU4Haoo=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 3 Oct
 2023 15:13:32 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::4a17:b056:be46:6e58]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::4a17:b056:be46:6e58%4]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 15:13:32 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Topic: [PATCH v2] Revert "drm/amd/display: Enable Replay for static
 screen use cases"
Thread-Index: AQHZ9VihCmnTItEhi0W/ARmiJPwWwLA4LUKO
Date: Tue, 3 Oct 2023 15:13:32 +0000
Message-ID: <PH8PR12MB7279E1B7634AE630985E4E2EF9C4A@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <20231002174754.1596197-1-ivlipski@amd.com>
In-Reply-To: <20231002174754.1596197-1-ivlipski@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-03T15:13:30.793Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|SA3PR12MB9157:EE_
x-ms-office365-filtering-correlation-id: 2dc871f8-e297-46e5-932f-08dbc4234e8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xg3mAnDryyBLLt94Rt8/p1vf00EaNVOi8UG/GxDehGBGandrGdXytvBspezf35wt7HQzPJ+K6q2iaaeYFJZFqo7qzgC3UvNLVkeK74gh621tEsKppS1phM7VJC8PcWIopYEK9ceJXECDAdEj4UjT8VABCiUj1+ZeEMmxWwFlqO+0Iq1nlvfZJvOvvd/HdWQPJe5Rk5eKq/2jxVjpYMLvJtTV/Hwl9cNY5u6fOavdRDWx3h2DR4lkBLJHq8yr4+NH2geeOJmvdxKBd0jaxKQdvr6V8fwxfFOvyGKiXmrxXI0JhmoPIVbpDnpHt2YBvczSSEFWGlHhT8ln80mSDl3A48PoG1vgCNReYOnkiL65h99XWcylP37SysWFfvt2Tc6afszJ7FLhPi2LCXWpAo7PtsiMyOfH3Ao/xqfrxdYt55fhv7Yt5z2PsHrC9if134P1OecYIDI32otnv40OW5ow/GaH4NXFyfSYdomn+vv26aeshkMwwrmzi9nGeu2iiQ+gGqnhvwyLRnW4RPL3kpx9qJsW9kljLomlS2nG1UsqbQj24XYTElPlbGtqf3TYMgu2S8S3ZhDI8QvrBDtxC2k1mdBAmpu2FTYVE0Lzz7hhMw5gHOKEcz/9CQOjPVlUAW5K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66946007)(66476007)(66446008)(66556008)(76116006)(54906003)(26005)(8676002)(4326008)(316002)(41300700001)(478600001)(83380400001)(6506007)(7696005)(71200400001)(38100700002)(38070700005)(122000001)(86362001)(9686003)(33656002)(53546011)(64756008)(91956017)(110136005)(2906002)(55016003)(19627405001)(8936002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y5wUE5g8ZHxrvg1NF+ofWp3ltijUCGnV0rIsfgOsBwx/t8LOJpksrp4coW65?=
 =?us-ascii?Q?sBoULCBncN8CZ5stOISUavlAflGwuqRMlL1cjHMK2D9cC2RPeP94tFSONN1l?=
 =?us-ascii?Q?1dBRNrgk1d8YwY1cdzQJscEZvQVRMdkqETtK7kZBbxywUyxJ/MoYiuuihy56?=
 =?us-ascii?Q?JVV/XzKgKoDMnOiYoTQxubVo93jGbUqP+KEvgwY0vxoRD+YSpu6STtjkTWhl?=
 =?us-ascii?Q?/yHZEumRZwJuDDCdiA8wlyDixW4wUPxnCW9NsH+WUm6FEGBzu0wJXqDfsc9g?=
 =?us-ascii?Q?DWTa3N/P8b1iKPnoEEEelO+sMZ4DaCTEDE4Y8piYGX0AEuHuSnYYmrJFmuAQ?=
 =?us-ascii?Q?QwTOhADQYQNr9eg6avuysUgeP8uDq32GR9nZWXFxXVtvgUvDke39nGPxXsjr?=
 =?us-ascii?Q?uMo5KtGyxtXFEOHT74OeoVNUB4VJPqNEa8AZft/FqNwfF2mRbo7d8W7iRzJV?=
 =?us-ascii?Q?idwano/NSRudpCXvwu8eM8NZLKWyYScAJ+rmk5dnhd7DxTnu0hLsEvCPu0Ix?=
 =?us-ascii?Q?v+z/ATQ8BlPc8yxSLkNtRQBB97KIcTCHDhMd9goHphSxTcdtXc2GcMz5OxXW?=
 =?us-ascii?Q?JpPiInPeQAxHWSFSegBiX2jRoxjTBmFAaecR0XJtNeTae6AWSzpkHBUDIh2M?=
 =?us-ascii?Q?yEuziGI/OnfF+Tm/v093CDIhYYLc9w4oGE9upzhesdkSUKpvPEXUXbo46jO9?=
 =?us-ascii?Q?FQQ5B8gwTjz8v572v42IGgjncwB/6fq0mv/0EU8p4OuaufYyQzrbClbaxPiZ?=
 =?us-ascii?Q?lR3PFbUAzwrxBEnxrvDM8YSUlf4cbiU4/INqtDmnB7CRcC4JWMl406XvRODK?=
 =?us-ascii?Q?bKFfeXMcWogrFDO2yjMXRpuAjf1qokzzzacmatZHvqte+08EFZsXQClt4MAf?=
 =?us-ascii?Q?sou91L+3yYox73nz1fODCvKWWSmvCmIgA/m/9YuVRyqtCp2pkjNc+ynvtZms?=
 =?us-ascii?Q?wMA4S2x+y8op/wgmE9sVxcXhfvvsMuLxHTQadY1HM9jrRFkTSJhM1yopor5h?=
 =?us-ascii?Q?pH9YHqFSpTrr4bjIi8ipylsKC5vUSZyL41br2PUq4U+XID7p3AHqZ//LuN6C?=
 =?us-ascii?Q?ZL/WzNoEYBdb9AAoFpnCgk2guc/e9slUaHgNS+lanRwv3j+UWlAfc0aCGNk0?=
 =?us-ascii?Q?v7yd03sQ71qGx07YY/Y8o7ngPLcaZHOz3GroNa2AQgOfaKRZ94rfr+CfrhHx?=
 =?us-ascii?Q?2pEVa0oiUGuOcoTAodSQqGVlZSdijzIrvNJpmogRdgmmDD/7RAqqwVZ/OMGA?=
 =?us-ascii?Q?G/fRvMd0R/v4XhuEzMXtDLHdu0Tzcmat5POjLLN8QbGcMkXksnwtqnTXQoNz?=
 =?us-ascii?Q?NAk6OAeq7kYmwP00A5xcRmWxNng8GZE/sQ2CkUOXWpF2JAomkQfQKYf6apKQ?=
 =?us-ascii?Q?SjXO7Y+VWsDJ/o5LMBnCXb+34EtZemq5IKcRpbE3Bu7/ZeR0mq85OntgfDJc?=
 =?us-ascii?Q?T2mJIhuNyPtq49MRAZJCrpo1Sw3/5cWq07ER1MCALEI68NE6lqtJXpJYRmJo?=
 =?us-ascii?Q?FztRov1az0kisjvhAHP9KaKtr7w6kXoGTLGCrKAThIEonakG44VRjZXN1fDl?=
 =?us-ascii?Q?+24PV8acXXdThk03S/4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB7279E1B7634AE630985E4E2EF9C4APH8PR12MB7279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc871f8-e297-46e5-932f-08dbc4234e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 15:13:32.3729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6CQw67E7hhnp7MUjxHrNqkOTPN6t/7GolzpOTPf6+vqVu1U2V+XMOq5EiRVFZHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
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
Cc: "Chung, ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH8PR12MB7279E1B7634AE630985E4E2EF9C4APH8PR12MB7279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Any reason for reverting this instead of looking into "amdgpu_dm_setup_repl=
ay()" and "replay_feature_enabled" to see why reply is being enabled?

Bhawan
________________________________
From: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Sent: October 2, 2023 1:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <Hamza.Mah=
fooz@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Lakha, Bhawanpreet=
 <Bhawanpreet.Lakha@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsu=
an.Chung@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>; LIPSKI, IVAN <IVAN.L=
IPSKI@amd.com>
Subject: [PATCH v2] Revert "drm/amd/display: Enable Replay for static scree=
n use cases"

From: Ivan Lipski <ivlipski@amd.com>

This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.

V2: Reword commit message

[WHY]
This commit caused regression in which eDP's with PSR support,
but no Replay support (Sink support <=3D 0x03), failed enabling PSR
and all IGT amd_psr tests.

[HOW]
Reverted the patch.

Signed-off-by: Ivan Lipski <ivlipskI@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------------------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
 3 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 32156609fbcf..f69b2e9ecd98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -66,7 +66,6 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 #include "amdgpu_dm_psr.h"
-#include "amdgpu_dm_replay.h"

 #include "ivsrcid/ivsrcid_vislands30.h"

@@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)
         enum dc_connection_type new_connection_type =3D dc_connection_none=
;
         const struct dc_plane_cap *plane;
         bool psr_feature_enabled =3D false;
-       bool replay_feature_enabled =3D false;
         int max_overlay =3D dm->dc->caps.max_slave_planes;

         dm->display_indexes_num =3D dm->dc->caps.max_streams;
@@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct am=
dgpu_device *adev)
                 }
         }

-       if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
-               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-               case IP_VERSION(3, 1, 4):
-               case IP_VERSION(3, 1, 5):
-               case IP_VERSION(3, 1, 6):
-               case IP_VERSION(3, 2, 0):
-               case IP_VERSION(3, 2, 1):
-               case IP_VERSION(3, 5, 0):
-                       replay_feature_enabled =3D true;
-                       break;
-               default:
-                       replay_feature_enabled =3D amdgpu_dc_feature_mask &=
 DC_REPLAY_MASK;
-                       break;
-               }
-       }
         /* loops over all connectors on the board */
         for (i =3D 0; i < link_cnt; i++) {
                 struct dc_link *link =3D NULL;
@@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct am=
dgpu_device *adev)
                                 amdgpu_dm_update_connector_after_detect(ac=
onnector);
                                 setup_backlight_device(dm, aconnector);

-                               /*
-                                * Disable psr if replay can be enabled
-                                */
-                               if (replay_feature_enabled && amdgpu_dm_set=
up_replay(link, aconnector))
-                                       psr_feature_enabled =3D false;
-
                                 if (psr_feature_enabled)
                                         amdgpu_dm_set_psr_caps(link);

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index fb51ec4f8d31..440fc0869a34 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -29,7 +29,6 @@
 #include "dc.h"
 #include "amdgpu.h"
 #include "amdgpu_dm_psr.h"
-#include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
@@ -124,12 +123,7 @@ static void vblank_control_worker(struct work_struct *=
work)
          * fill_dc_dirty_rects().
          */
         if (vblank_work->stream && vblank_work->stream->link) {
-               /*
-                * Prioritize replay, instead of psr
-                */
-               if (vblank_work->stream->link->replay_settings.replay_featu=
re_enabled)
-                       amdgpu_dm_replay_enable(vblank_work->stream, false)=
;
-               else if (vblank_work->enable) {
+               if (vblank_work->enable) {
                         if (vblank_work->stream->link->psr_settings.psr_ve=
rsion < DC_PSR_VERSION_SU_1 &&
                             vblank_work->stream->link->psr_settings.psr_al=
low_active)
                                 amdgpu_dm_psr_disable(vblank_work->stream)=
;
@@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct *w=
ork)
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
                            !amdgpu_dm_crc_window_is_activated(&vblank_work=
->acrtc->base) &&
 #endif
-                          vblank_work->stream->link->panel_config.psr.disa=
llow_replay &&
                            vblank_work->acrtc->dm_irq_params.allow_psr_ent=
ry) {
                         amdgpu_dm_psr_enable(vblank_work->stream);
                 }
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h
index 314fd44ec018..ce75351204bb 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
         DC_DISABLE_LTTPR_DP2_0 =3D (1 << 6), //0x40, disabled by default
         DC_PSR_ALLOW_SMU_OPT =3D (1 << 7), //0x80, disabled by default
         DC_PSR_ALLOW_MULTI_DISP_OPT =3D (1 << 8), //0x100, disabled by def=
ault
-       DC_REPLAY_MASK =3D (1 << 9), //0x200, disabled by default for dcn <=
 3.1.4
 };

 enum DC_DEBUG_MASK {
@@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
         DC_DISABLE_PSR =3D 0x10,
         DC_FORCE_SUBVP_MCLK_SWITCH =3D 0x20,
         DC_DISABLE_MPO =3D 0x40,
-       DC_DISABLE_REPLAY =3D 0x50,
         DC_ENABLE_DPIA_TRACE =3D 0x80,
 };

--
2.34.1


--_000_PH8PR12MB7279E1B7634AE630985E4E2EF9C4APH8PR12MB7279namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Any reason for reverting this instead of looking into &quot;<font size=3D"2=
"><span style=3D"font-size:11pt" class=3D"ContentPasted0">amdgpu_dm_setup_r=
eplay</span></font>()&quot; and
<font size=3D"2"><span style=3D"font-size:11pt" class=3D"ContentPasted1">&q=
uot;replay_feature_enabled</span></font>&quot; to see why reply is being en=
abled?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Bhawan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> LIPSKI, IVAN &lt;IVAN=
.LIPSKI@amd.com&gt;<br>
<b>Sent:</b> October 2, 2023 1:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Ham=
za &lt;Hamza.Mahfooz@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.co=
m&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Deucher, Alexa=
nder &lt;Alexander.Deucher@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@a=
md.com&gt;;
 Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; LIPSKI, IVAN &lt;I=
VAN.LIPSKI@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.LIPSKI@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] Revert &quot;drm/amd/display: Enable Replay for =
static screen use cases&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
<br>
This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.<br>
<br>
V2: Reword commit message<br>
<br>
[WHY]<br>
This commit caused regression in which eDP's with PSR support,<br>
but no Replay support (Sink support &lt;=3D 0x03), failed enabling PSR<br>
and all IGT amd_psr tests.<br>
<br>
[HOW]<br>
Reverted the patch.<br>
<br>
Signed-off-by: Ivan Lipski &lt;ivlipskI@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ------------------=
-<br>
&nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_crtc.c&nbsp;&nbsp;&nbsp; |&nbsp; =
9 +-------<br>
&nbsp;drivers/gpu/drm/amd/include/amd_shared.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 --<br>
&nbsp;3 files changed, 1 insertion(+), 33 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 32156609fbcf..f69b2e9ecd98 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -66,7 +66,6 @@<br>
&nbsp;#include &quot;amdgpu_dm_debugfs.h&quot;<br>
&nbsp;#endif<br>
&nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
-#include &quot;amdgpu_dm_replay.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;<br>
&nbsp;<br>
@@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_connection_type ne=
w_connection_type =3D dc_connection_none;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dc_plane_cap =
*plane;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool psr_feature_enabled =
=3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool replay_feature_enabled =3D false=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int max_overlay =3D dm-&gt=
;dc-&gt;caps.max_slave_planes;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;display_indexes_num=
 =3D dm-&gt;dc-&gt;caps.max_streams;<br>
@@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_dc_debug_mask &amp; DC_D=
ISABLE_REPLAY)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(3, 1, 4):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(3, 1, 5):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(3, 1, 6):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(3, 2, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(3, 2, 1):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case IP_VERSION(3, 5, 0):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_feature_e=
nabled =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; replay_feature_e=
nabled =3D amdgpu_dc_feature_mask &amp; DC_REPLAY_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* loops over all connecto=
rs on the board */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; link_=
cnt; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct dc_link *link =3D NULL;<br>
@@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_update_connector_after=
_detect(aconnector);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_backlight_device(dm, aconn=
ector);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable psr if replay can be enable=
d<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (replay_feature_enabled &amp;&amp; amdgp=
u_dm_setup_replay(link, aconnector))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; psr_feature_enabled =3D false;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psr_feature_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_dm_set_psr_caps(link);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
index fb51ec4f8d31..440fc0869a34 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c<br>
@@ -29,7 +29,6 @@<br>
&nbsp;#include &quot;dc.h&quot;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_dm_psr.h&quot;<br>
-#include &quot;amdgpu_dm_replay.h&quot;<br>
&nbsp;#include &quot;amdgpu_dm_crtc.h&quot;<br>
&nbsp;#include &quot;amdgpu_dm_plane.h&quot;<br>
&nbsp;#include &quot;amdgpu_dm_trace.h&quot;<br>
@@ -124,12 +123,7 @@ static void vblank_control_worker(struct work_struct *=
work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fill_dc_dirty_rect=
s().<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vblank_work-&gt;stream=
 &amp;&amp; vblank_work-&gt;stream-&gt;link) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * Prioritize replay, instead of psr<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (vblank_work-&gt;stream-&gt;link-&gt;replay_settings.replay_f=
eature_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_replay=
_enable(vblank_work-&gt;stream, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (vblank_work-&gt;enable) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (vblank_work-&gt;enable) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (v=
blank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_version &lt; DC_PSR_VER=
SION_SU_1 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; vblank_work-&gt;stream-&gt;link-&gt;psr_settings.psr_all=
ow_active)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dm_psr_disable(vblank_wor=
k-&gt;stream);<br>
@@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct *w=
ork)<br>
&nbsp;#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; !amdgpu_dm_crc_window_is_activated(&amp;vblank_work-&gt;acrtc-=
&gt;base) &amp;&amp;<br>
&nbsp;#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; vblank_work-&gt;stream-&gt;link-&gt;panel_config.psr.disallow_replay &amp=
;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; vblank_work-&gt;acrtc-&gt;dm_irq_params.allow_psr_entry) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_dm_psr_enable(vblank_work-&gt;stream);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd=
/include/amd_shared.h<br>
index 314fd44ec018..ce75351204bb 100644<br>
--- a/drivers/gpu/drm/amd/include/amd_shared.h<br>
+++ b/drivers/gpu/drm/amd/include/amd_shared.h<br>
@@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_LTTPR_DP2_0 =3D=
 (1 &lt;&lt; 6), //0x40, disabled by default<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLOW_SMU_OPT =3D (=
1 &lt;&lt; 7), //0x80, disabled by default<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_PSR_ALLOW_MULTI_DISP_OP=
T =3D (1 &lt;&lt; 8), //0x100, disabled by default<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_REPLAY_MASK =3D (1 &lt;&lt; 9), //=
0x200, disabled by default for dcn &lt; 3.1.4<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum DC_DEBUG_MASK {<br>
@@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_PSR =3D 0x10,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FORCE_SUBVP_MCLK_SWITCH=
 =3D 0x20,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_MPO =3D 0x40,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_DISABLE_REPLAY =3D 0x50,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_ENABLE_DPIA_TRACE =3D 0=
x80,<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH8PR12MB7279E1B7634AE630985E4E2EF9C4APH8PR12MB7279namp_--
