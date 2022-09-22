Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF21C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 14:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7371910EB38;
	Thu, 22 Sep 2022 14:13:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0135310EB38
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 14:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILa1WZ7fvwx1ELcH4UGpejvoehrqELXZ4xxeHhToIsj5Dwis0cwzK8ZsUnr7beSZGNJvAhwwaeL/WUEjm6CFor58xdawZaLvzBvmFoi0dySJN2HtH/WfJhKd3yUQ1HrMZWZs/TePcCUuVVklCgldk4aw2+dtb+VgW9AhKWmRIhS/NNVCpsmsA1weSp4NT0AqvGcDZEYYqaWBdyAJtg/4rt0IvWY0oTBQ5CqfjbXBzAhMN0nQPhHPgTHecagOvCPmjPMScW2TV5rITS9ATSjJ5Z5yVRCFVNBonrdgZ+1f9CiupunRygYASoLynlvProqhC/H1LAbOJ+2Ug9t5kFYdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HXqZaN+80t+aizMsjwwD9MPE3MtYxQu6XzBhmGw8eQ=;
 b=gP5gweJXJEhGaY+NCflYaaTsc/6Qk9ed9Uz39RIctGKVdsghSA/EqK0wrqChaujomEH5ya6ScMCiMwkzVucRb/p7oK1Pm/N+gZkcSGumkma6ZjgWxRwBOUKh0snbulDn/fx8AwE+mUKRYR387OFoYq1Ngc8hby4DhDfO0CcgcoxMJZxh1AxhqFqdr+mV4q4eJ9ifkPLgIg7lxWhPpTQsmIEkDISvN5/jzmWroc2yXpKH6qwYryi2RD4OQqa6SBYYe503XeTmMPVUjvzFQcZjGKSmG1a+YYlDNGo2NV6rVXxNzSV0ta/VmOso90RH3tnEqkgJDgJCSTDn65395Z7VUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HXqZaN+80t+aizMsjwwD9MPE3MtYxQu6XzBhmGw8eQ=;
 b=tZwoM7U7iIrMw/0xBLU7NJ/1nEsluj5ZPY3Mw4xvACnECca1RVpGdPWvpZwddTydC68BT/9Fa6rJNU2cOScP0EsYz3aeE6UPL9++HeNJ78CasmJhJMA0jvFzwfkM9mfjvUKtvhAt5GAHjNN+Fxuoyy8twQneTu30TH/ALDjmeOE=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 14:13:14 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::cd37:1141:7fec:389d]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::cd37:1141:7fec:389d%4]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 14:13:14 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 23/31] Add debug option for exiting idle optimizations on
 cursor updates
Thread-Topic: [PATCH 23/31] Add debug option for exiting idle optimizations on
 cursor updates
Thread-Index: AQHYzhj5vPBkIl3LFE6kvz8qsllFGq3rfoz+
Date: Thu, 22 Sep 2022 14:13:14 +0000
Message-ID: <CH0PR12MB5284C47A2865B6BBC567CF698B4E9@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
 <20220922001821.320255-24-jdhillon@amd.com>
In-Reply-To: <20220922001821.320255-24-jdhillon@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-22T14:13:13.641Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CY8PR12MB7145:EE_
x-ms-office365-filtering-correlation-id: 65a7f804-9556-4e8d-a8c5-08da9ca49695
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PwO7AdehyAjzC0S5WY7QZXU93l97/ynmtre0N6seno/0FcFLUdluybNrxpw2eb8TMqg8Kg2vDSD86Iug7eJU5s9YBr/Fw1HyZFsuJRtQeJcZIKat/BoicA6U4OweJh4aoRMQGPDVkADIXYB7gSGsCnZX6PQXko5iHAUUbulNAxfo8ApIHs/B6MoM0sBlTHIegN/0SfulP5Yx3FgX8g5Oeb/mEfA4UJviSlarCVpv0rIPm8TY4sYGTPO8c9OYzDdK42mOqJU0ZfIDdnYpK1dydwJtEr8psvNMwvHPljqLay+6sACJacW7OZm4sJV8qtmcaG1b6bFqybmGBTN8dBt6zkwk2f0Hs7eICsQN0Blmi/il0OPIfa+lp1UlUe7hNHqlisCCL7AywBRGXcGpj+gnDPWXK+nnPowqMP8ZoXTmjmZbimapZ3+sTv2NwVe2lSP/TEnPpi118b5rUWyJNT5jp0ukkQnq/oVpRqlFQk7oqZEB6IDAjYUy0XhETRCN+G0WBjhfqL9F6PO05wlB9Ya5QiSmpmNxr+pAThAyYi8EBrcUfOR6hj/MmizA/Ka1x9iCjAPTAh1ddTRTN+VmAB736yX1Yrl24paC6mOAQ0jSmxcfK2L2xwHKJPl2TGkXr6lcRiFNk0e5PsloHf7+mGD14CHcytxfX34NmaBQt+PYoZTl7pJLlEO6SfwZK6ob72S/QNvckN/TPhbKKz4mPz1gKM730D8QhHqrysNXyeW998doXwxZ3D/EXzT40Bw1PzdPC1GQkeYlA+wtUVaLl0oPlw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199015)(52536014)(41300700001)(86362001)(71200400001)(8936002)(478600001)(5660300002)(54906003)(110136005)(66446008)(8676002)(66556008)(33656002)(76116006)(66946007)(316002)(66476007)(4326008)(64756008)(186003)(38100700002)(55016003)(38070700005)(122000001)(7696005)(6506007)(53546011)(9686003)(26005)(83380400001)(15650500001)(19627405001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OS/qoD7oXJaz3YjP1jD8khy0IHp/QL0uI7dJI/A4Lt1Eh/zxFqSyoYKLdnM+?=
 =?us-ascii?Q?m4HTmyNOoPcTOV3/iGpWTom6YY7ImJZl1J1K+Bs4RdsM9WYu2w6eGWL8M+lf?=
 =?us-ascii?Q?e++Xzjopd+2NvSHxNeJN1ARmccCkVFYclHeFBBirzjqF2pGPi/oe67ztJfjL?=
 =?us-ascii?Q?HfifyzllN/E0VgFFoRuojy5CHArD/7inVvcqpnxzuECX42CygpdQ0feQxYQO?=
 =?us-ascii?Q?ahZag3uSu9pCBWqB3/YTN9y87FnMMllnbjXR9LzCIEc4Yf6ZkE1g0Eyc9ZnA?=
 =?us-ascii?Q?AKMsIIkDZgXUFN5ysF4wxTTEHc7NGX0PmYl7KEWef7LvNWAiMUzgpI3JaSz6?=
 =?us-ascii?Q?ktmu4WXsW4uQ234uJjidVv2uYoPRKGmoq8Q1CPhs4o0/7xHRlqYykAajz5ey?=
 =?us-ascii?Q?KT/k+G/Fy85d1799XXxu5LigmKRTCrdr7gZbrgtAYtSfvwec/0rCnxsnElPv?=
 =?us-ascii?Q?F/Ig5B3Sds1g3ftT/mYQGFyY6iYJESGTjBuNTciBxFeLEoVO5oyqfBP7EcoP?=
 =?us-ascii?Q?UASmlcw1Wf1DNa41lw1WQYYy0oT3TcqN4DLdnn7GWyTZU9hYQUyGvZ1QuVTX?=
 =?us-ascii?Q?k6RFKZjPVmJugHy8mQOU/tKPuXKePhvDfyduHyuDIVod+MNTYL3v1X1+FpZ5?=
 =?us-ascii?Q?5Kd65L0dfZz8qe8JXVscdcFqmeLuoh7WxxMXvkeHQiqGe1NnmZ4Ryi+D4Ssg?=
 =?us-ascii?Q?UO1VMwE8Vkjch038UXzljglDK1XHryGNS42CS1okeKWDZ27K2HCKUpWJbI3D?=
 =?us-ascii?Q?naBOQqVihkGoYcxaJM891p8BwOuWJOC+Uu1MjZlxYZJWhoWRJ3zsXCQdTxLv?=
 =?us-ascii?Q?ei5J0xhwvvOyps4cCkpGu619DHVTpQaXb98f2VP3vk2BqXvcPFMhuevgiEet?=
 =?us-ascii?Q?diil2ZKeyUkODwxuwt8no2BSaS3HrrNGkYC7zEKgpLYYjuUdPOizNo5eoN3+?=
 =?us-ascii?Q?BxCymjXxsT/Y011iOHNtq/9vpmMRAPaYdaUpKHfB7dk1sEbC6fWfRcSYQ8ET?=
 =?us-ascii?Q?O055nrGtzlv6yIExXRiBKg25E0JwFywnq8ll3yslCcmu27nYOLUyOj73DkXA?=
 =?us-ascii?Q?0D965RtMgqNEKQZ0duh3MBAqfG/WLwt4IiO2H+DgOmUra3Vxm/fEA2LgDscT?=
 =?us-ascii?Q?VOC3uSwH0oJ5nyXQ83Z37hZSxa3OhCh5Xku7G/Lj217ucHnoy7EcrtQ4hvjy?=
 =?us-ascii?Q?ukz/g9MN1KUQWcGfMJRg0cUGLsXGIaJWjDSNxNfCu7mM+aGiYlPTQnOV8pja?=
 =?us-ascii?Q?h/y0OVb7uMF6lsUk9eEJxnFOfzPdyIdWeX2D4Jer0ASa++XoB00vDzuH0T5c?=
 =?us-ascii?Q?JDnuiaHXcfvxzAn6+thTD6Ha2ZjmoBUcMmmnA1VkfEssLVJCVjv3GbCC5IiH?=
 =?us-ascii?Q?TYK9ERFADI+uA3HEVa53x6T8ElgBSwbQeYNsHsuex/LnOGd1KE03pb36rY9J?=
 =?us-ascii?Q?i1E+AmTB4330g0vXR8g76/rgbBW3ZMyoQXI6TpG1z+4xueZCHGs6xwGxrzey?=
 =?us-ascii?Q?XzQP14kea0jPkQFvnT5Iiiezc8abiVPAWGdAzJL3upikNmeqq26Wdnd5RfB9?=
 =?us-ascii?Q?ptsIuPswwUuc97vO6lU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284C47A2865B6BBC567CF698B4E9CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a7f804-9556-4e8d-a8c5-08da9ca49695
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 14:13:14.0681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dsmsu9L9O8gIiadCQ831rD7RW8I2OMxBcbpID1vr9y5DzeyuPuYKRpLh/Pq/parXg552jzkDcshzmG4MP2wKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Cyr,
 Aric" <Aric.Cyr@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Syu, Brandon" <Brandon.Syu@amd.com>, "Lin,
 Wayne" <Wayne.Lin@amd.com>, "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284C47A2865B6BBC567CF698B4E9CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Jas,

Please add drm/amd/display prefix to the patch title

--

Regards,
Jay
________________________________
From: Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com>
Sent: Wednesday, September 21, 2022 8:18 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Syu, Brandon =
<Brandon.Syu@amd.com>; Cyr, Aric <Aric.Cyr@amd.com>; Dhillon, Jasdeep <Jasd=
eep.Dhillon@amd.com>
Subject: [PATCH 23/31] Add debug option for exiting idle optimizations on c=
ursor updates

From: Brandon Syu <Brandon.Syu@amd.com>

[Description]
- Have option to exit idle opt on cursor updates
for debug and optimizations purposes

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Brandon Syu<Brandon.Syu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index f6f3878c99b8..3a3b2ac791c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -724,7 +724,8 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
         .dwb_fi_phase =3D -1, // -1 =3D disable,
         .dmub_command_table =3D true,
         .disable_psr =3D false,
-       .use_max_lb =3D true
+       .use_max_lb =3D true,
+       .exit_idle_opt_for_cursor_updates =3D true
 };

 static const struct dc_debug_options debug_defaults_diags =3D {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 0c2b15a0f3a7..559e563d5bc1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -700,6 +700,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
         .dwb_fi_phase =3D -1, // -1 =3D disable
         .dmub_command_table =3D true,
         .use_max_lb =3D false,
+       .exit_idle_opt_for_cursor_updates =3D true
 };

 static const struct dc_debug_options debug_defaults_diags =3D {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 4fab537e822f..b925b6ddde5a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -93,7 +93,8 @@ static const struct dc_debug_options debug_defaults_drv =
=3D {
                 .underflow_assert_delay_us =3D 0xFFFFFFFF,
                 .dwb_fi_phase =3D -1, // -1 =3D disable,
                 .dmub_command_table =3D true,
-               .use_max_lb =3D true
+               .use_max_lb =3D true,
+               .exit_idle_opt_for_cursor_updates =3D true
 };

 static const struct dc_debug_options debug_defaults_diags =3D {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index d97076648acb..527d5c902878 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -77,6 +77,7 @@ static const struct dc_debug_options debug_defaults_drv =
=3D {
                 .underflow_assert_delay_us =3D 0xFFFFFFFF,
                 .dwb_fi_phase =3D -1, // -1 =3D disable,
                 .dmub_command_table =3D true,
+               .exit_idle_opt_for_cursor_updates =3D true,
                 .disable_idle_power_optimizations =3D false,
 };

--
2.25.1


--_000_CH0PR12MB5284C47A2865B6BBC567CF698B4E9CH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Hi Jas,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Please add drm/amd/display prefix to the patch title<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dhillon, Jasdeep &lt;=
Jasdeep.Dhillon@amd.com&gt;<br>
<b>Sent:</b> Wednesday, September 21, 2022 8:18 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd=
.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aurab=
indo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqing (Lillian)
 &lt;Qingqing.Zhuo@amd.com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Lin, Wa=
yne &lt;Wayne.Lin@amd.com&gt;; Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.=
com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Kotarac, Pavle &lt;Pav=
le.Kotarac@amd.com&gt;; Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt=
;;
 Syu, Brandon &lt;Brandon.Syu@amd.com&gt;; Cyr, Aric &lt;Aric.Cyr@amd.com&g=
t;; Dhillon, Jasdeep &lt;Jasdeep.Dhillon@amd.com&gt;<br>
<b>Subject:</b> [PATCH 23/31] Add debug option for exiting idle optimizatio=
ns on cursor updates</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Brandon Syu &lt;Brandon.Syu@amd.com&gt;<br>
<br>
[Description]<br>
- Have option to exit idle opt on cursor updates<br>
for debug and optimizations purposes<br>
<br>
Reviewed-by: Aric Cyr &lt;Aric.Cyr@amd.com&gt;<br>
Acked-by: Jasdeep Dhillon &lt;jdhillon@amd.com&gt;<br>
Signed-off-by: Brandon Syu&lt;Brandon.Syu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c&nbsp;&nbsp; | 3=
 ++-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 3 ++-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +<br>
&nbsp;4 files changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
index f6f3878c99b8..3a3b2ac791c7 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
@@ -724,7 +724,8 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dwb_fi_phase =3D -1, // -=
1 =3D disable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dmub_command_table =3D tr=
ue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_psr =3D false,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .use_max_lb =3D true<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .use_max_lb =3D true,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .exit_idle_opt_for_cursor_updates =3D=
 true<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct dc_debug_options debug_defaults_diags =3D {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
index 0c2b15a0f3a7..559e563d5bc1 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c<br>
@@ -700,6 +700,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dwb_fi_phase =3D -1, // -=
1 =3D disable<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dmub_command_table =3D tr=
ue,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .use_max_lb =3D false,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .exit_idle_opt_for_cursor_updates =3D=
 true<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct dc_debug_options debug_defaults_diags =3D {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
index 4fab537e822f..b925b6ddde5a 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c<br>
@@ -93,7 +93,8 @@ static const struct dc_debug_options debug_defaults_drv =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .underflow_assert_delay_us =3D 0xFFFFFFFF,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .dwb_fi_phase =3D -1, // -1 =3D disable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .dmub_command_table =3D true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .use_max_lb =3D true<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .use_max_lb =3D true,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .exit_idle_opt_for_cursor_updates =3D true<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct dc_debug_options debug_defaults_diags =3D {<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c<br>
index d97076648acb..527d5c902878 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c<br>
@@ -77,6 +77,7 @@ static const struct dc_debug_options debug_defaults_drv =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .underflow_assert_delay_us =3D 0xFFFFFFFF,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .dwb_fi_phase =3D -1, // -1 =3D disable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .dmub_command_table =3D true,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .exit_idle_opt_for_cursor_updates =3D true,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .disable_idle_power_optimizations =3D false,<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284C47A2865B6BBC567CF698B4E9CH0PR12MB5284namp_--
