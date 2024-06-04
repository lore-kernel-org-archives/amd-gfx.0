Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A08DC25B75
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 02:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B8F10E0E6;
	Tue,  4 Jun 2024 02:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b0U3tvav";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA0910E0E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 02:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcCbyrX/8RMiBaoDKMCcNiA9zVsNn/KKlzl7WYrRv2ZVUXLX6P9bvCH2uf1/9fPlcy/rM0VFRIZdJRu32OTc6klaH4viSC0XY0yVhOJBnfoWRsHJShKhKkup+I08duUO6oUceL9IIy+uawDHv18mqznpCLyScmdb1DKSxB5EnllU3EhSTZ9gYvIqq0ByuohhRmHDRjQsBtj9D7bq3ubzhXQErCel3wi1GoH+mn7ldbrpGNa8tEWKGaGJPBUswYzTrK0E0jsOQ6aJbPZUsTxiOb1iXbi/OaW6KH9VXoOMd0lQQtF+RHVG++JO0uRrZnsXvBXI5t2qxqtW03MbLkE8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyQCEGR6giFJxY184dD/cKqtzqoUs+MaMV1a55K3Meg=;
 b=UqbrIs5v9w68345Ys0uJPtECjD8ArZ53hwqlCYiVkm80pii0zOVBXshiczihuYDAJaZxQUaA+qXT9HP9YyY/hYF91J5R1+6hYJfmThxjf0oCDfIRYVm1kWhxVMwTJQNffR1ziFMqbD9QvYJgdME1Xx1PPITnTzlYPQZhN1EtgBibM74PKB6huytPtuNAR0TbpmOkRS7FjEvkQQJY684sawmTH8Ryk2joFdGT4aF+zAzd6hGrsO4rroj2/KlJaXdbuMM/TS44Pto1qpkDR7LBD4UwLMV+D7i5gTfvmA8mYzs+N3r/K2VXyzhxqWeug+iuSmhwg3oQ/0Axeb808XxvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyQCEGR6giFJxY184dD/cKqtzqoUs+MaMV1a55K3Meg=;
 b=b0U3tvavRWnd07RKAIV4Z6YuUCHPlRL17vwtYlHmcm20tMzwX/uzNcEcZIrgQhkRl+qP8MjlrJm/c4mUB7lgiuhe4A6IQ0fYOm1QyGqxplEJtBMvHYnKcALAql49iBSMz+/+TlSnM7u9JysLZo1/Q9afX+NCzxm0MKBXirFtXgE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 02:39:05 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 02:39:05 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Topic: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Index: AQHatZK6ONMBj5Sd2USPLcNmrjF9U7G1v1bggAEQ9YCAABMKAA==
Date: Tue, 4 Jun 2024 02:39:05 +0000
Message-ID: <PH7PR12MB5997EDE36BBA361D761AF9D482F82@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240603084730.2569970-1-jesse.zhang@amd.com>
 <DM4PR12MB601207AD23D14B7BB64B3CB082FF2@DM4PR12MB6012.namprd12.prod.outlook.com>
 <DM4PR12MB515268FF505C25FCC69D0724E3F82@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB515268FF505C25FCC69D0724E3F82@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=689ec0ae-dbd8-4a02-a8dd-a477a98b33ef;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T09:05:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB8142:EE_
x-ms-office365-filtering-correlation-id: 36809df6-1b18-48ea-a7be-08dc843f8094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?o1BeJvtEKSsL4WhZm3f/8iV5qPG0AjzeWeo1qakaR2wTH8lciX+aSkie7fta?=
 =?us-ascii?Q?TncgyE2evDDPO8KhLShV0IPqDjA9onI0ogUhO4uBr3tiRg7L5JWoDwAZDi9F?=
 =?us-ascii?Q?n1wj76W1tsGuNO7YeZk4ZxEppniAJVtAHynZBAcdOjlutFYVeRbi/UM2Lvcd?=
 =?us-ascii?Q?FxxtSLEtJgtUhGLFZunylhqiodAMFPiP4AM4u4tvdqwbYM7bGzvG+L/B38lg?=
 =?us-ascii?Q?0tMKuIOwaV+EqXiZxilXvVKLBhFMCjfyI5oOHgHC38eb8N6LZp6qzpZIkSkZ?=
 =?us-ascii?Q?QT4kEn6fmtDntyxIAkPzqIrQ9WlcE2WfT7qlcTjMlF+YEVuZ+NOFuJz6zQf8?=
 =?us-ascii?Q?JN8t+V3zg01k2Zffni6y8qZ4kJFIZqJkeEpvM494wTwNO+2gpvT+qGOoqKNq?=
 =?us-ascii?Q?AL+Qq9mKujSM9tG1rcsbb0qnBC52Gu60lZTBF29F3Zn++nSzGTqlPAlPcwCp?=
 =?us-ascii?Q?6JAOX9SymqREYunDyGQBEtMh1ViOZR3dzwtXSQN2Kc/TDdULiJhaxTFME2BQ?=
 =?us-ascii?Q?xBOt7XEFdvJgvMnHm2DE9GfBZWMbIkAMTtqQSN0tlj/NEUe0EGvm1eC7Q/+u?=
 =?us-ascii?Q?kj4xmUZasx4p7+OuvilxyI8XVgzlgTSW/CsW+c2ugCLNxfN/ioCb0JIxU2Tn?=
 =?us-ascii?Q?+u704BtPFvxCSuUo5lKfgdbpo78ErY/MDcQel6zZLTMjMyOsasRch5lzyVOF?=
 =?us-ascii?Q?7RNfO53ykN2jk0nk4RZ3Z8/itfF33ScMuyOFvQdsBvX33+q6dXWPcCv4GfHb?=
 =?us-ascii?Q?7rFzH/T+MB1SyG/b2Dkwz4mJdBtqBTuc8VGif78SjjA+m7vTKr2/S3NrRNhA?=
 =?us-ascii?Q?42tCt0j1GMiGcvNwR3zVRQVyU9th9VWmu4eZXDxm2d8dLH6a8g8ArQrgvW3B?=
 =?us-ascii?Q?UL75M0dNFM5bxk78mIHPpstPRqL1J1POGioyInewforpIjxcyzrTbi3uXR5g?=
 =?us-ascii?Q?q+p6WnMazRv2V4CH0CuBsgwiRWo7ez1kLdQoDSYTH6pVGbaEBiCyxkJ8b5Le?=
 =?us-ascii?Q?ygVKH/ZrYQUzpiy+nwPYnIivATvJf6qBllpZj16BzDsNXPg+y5hO/88NseWF?=
 =?us-ascii?Q?TJraNk3FD0dq6fFsa5+1AH+4Y1/UH6Aaute1afM0yGAMeoLaFKOKAnsO24Qg?=
 =?us-ascii?Q?ind6MtqSYL/er3q0krDef4Rlqj+NlViwLumdbbK7qIhddISJl9JqMbANxAfv?=
 =?us-ascii?Q?xFaH96DYV3JUQoDxJGtzGEXXe4A4DUE1dO7C1oKw6CShWV8zermrEYydEjIv?=
 =?us-ascii?Q?Kr844HPzrc1NCkmhD6mDVQdDcjkV5Mn4w87YEZTT4iVjB3vZrdaO6Ay9zQn3?=
 =?us-ascii?Q?ZARJFj+J1GI3+s/JdIf8F3qyKapZVg9WvauZ6bv0c3/Zyw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N2eTCwgdhJiU4x7rwWzzpKioYZ3+GhMyvu4knHPq4dVVSL9QBtRa5s4lAeY/?=
 =?us-ascii?Q?gYejxL4tXIhXOr/ekUy8BV2A478B9WgWV75xULqO8SpBKHHXEYuYVbTMIne1?=
 =?us-ascii?Q?apJpe0JNK8ZvfLq6OzHSqZ511wgOaWOU1aHQJZCk3xUmRN1rbCQKvuEfk2Lb?=
 =?us-ascii?Q?ITPosugeDqjnmoAo1BQLzzO+LNoZVrTgB89rlEu9/RvBxftrTFdjpsgSTG6E?=
 =?us-ascii?Q?qX2UWb9aKpv9ZRK8+wKAnvey+8xwWgCTryv+AnSSNdcq65Nmh76ni75xFHwn?=
 =?us-ascii?Q?K29sH3uBIkfJEBcGZSXuM7yn1AtIloXzSzzlR9khq+QPdjYapK96CPANigrN?=
 =?us-ascii?Q?ZThSb689jElvs2iLsMqMglTYQJAxsoCJHZHBZWafIFN3BKJ/5NogLVsGpwNf?=
 =?us-ascii?Q?WBDy8x0NNJfi76NG+vwsllxvUoLvR5voypEBZdWIWRUKzPqO8nQPCn4mR3A0?=
 =?us-ascii?Q?QXMshE1Wr7weN1/zNHzOqCrIE/UJKlqPhHqWVaYqdeczwvFGLhCgFn91ZmiF?=
 =?us-ascii?Q?eQYfn1WJb2xtq9nwBNioxq4OnUG/FVRFNua0/6V4P/Km6cG/CEmO4m+yFzAw?=
 =?us-ascii?Q?F99+x87NfWV1HG2OFSU4h8ku/mHBWf0QtP0kBgs2wohAAAZww/aMdsakbCQi?=
 =?us-ascii?Q?1jurjqEeLmgv9dhWgM5FHK0JU1FEd+oj1Z6lnhHaTMvo5hd5DZXuwCSbOlXe?=
 =?us-ascii?Q?ViAEAsm49szwfycTGnMbKydcaImHaHei3OCH5nMtuWI7nIBE45vsnX1oBVAG?=
 =?us-ascii?Q?tLnPkr9xHgQwgxuwgqgtgwDtn/43Yl1rk5iUdo7dommzeYF5zmwPeckzqDRK?=
 =?us-ascii?Q?JhArafCJsuPaB94NgfIz2tzGtkE8LUYehwJ2a/gSvfgXO4k5Aq+OMt3pp1Qq?=
 =?us-ascii?Q?AxZabTgkhjNcCIrPWrkHOq3XFdHgUdWvYmv0whVO4oPy75ELErUPYCVGwCcO?=
 =?us-ascii?Q?NhbvXiFUc6cc47KSOMkkJhwH5iNUhXwG1kwjSFTbo03YTHfalC00XLFZCHEu?=
 =?us-ascii?Q?8sMrQp6t0J8+4DWFI29qgwY1kA2VR7Os9Q5S+ht/0LjfgTeYafj5Lsx2e7P1?=
 =?us-ascii?Q?kiiDSmBqfz/X80JMDZ1bflj/jQVFLf172JU9RnQxcikuQKFYee5r1y9oK1Mk?=
 =?us-ascii?Q?tSYV22CGUR/1kEPCR0lTNKWnuMPa/E9+Uo3dnibxx7uC5C0IE4GKdsxjlX5w?=
 =?us-ascii?Q?2WGbDSgP6XnAU7hA69hICbHkQpYSAyY+8Qelf+nO8UYRWM9kVGwcUA30CDZA?=
 =?us-ascii?Q?+lmFsNca8b5INIDb+avNiKynxEXqlzwP0btiVapwaJkTml68X5+g6zOMks/j?=
 =?us-ascii?Q?QA4qXg8tiacbmLId5Qas9Sn/cSICyed/QS63nE8EM+9kb8OnFTBqLObOvw+M?=
 =?us-ascii?Q?RpEBiMGWFDP7P4WbVDw5sxksT53xWRci7pFIsqmtL+AeQ3bzAYeUUzzqFi4q?=
 =?us-ascii?Q?g0VcLFaDKcHKfwxtdXgo5QOsOxxrd2PeJaA79+UonK79vLOvzwd+IwIXMB1y?=
 =?us-ascii?Q?yqle3Y2ZAkioMG4B8ZI8/PF5reVdjueWLhisvVuzjJNLemk3hbkkRr4raMk2?=
 =?us-ascii?Q?3tVjg3a86JO/dugwSjE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36809df6-1b18-48ea-a7be-08dc843f8094
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 02:39:05.4213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAqou2dXcHBxhDruS4ng9A9L7P0wpgNtU/a7hNv41mZjR6QzRgpptHtiWcJJa+EG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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

  CC [M]  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.o
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c: In function 'navi10_emit_clk_levels':
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_VCLK1' not ha=
ndled in switch [-Wswitch]
 1275 |         switch (clk_type) {
      |         ^~~~~~
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_DCLK1' not ha=
ndled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_ECLK' not han=
dled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_DISPCLK' not =
handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_PIXCLK' not h=
andled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_PHYCLK' not h=
andled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_LCLK' not han=
dled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_CCLK' not =
handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_VDDGFX_OFF=
SET' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_FAN_CURVE'=
 not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_ACOUSTIC_L=
IMIT' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_ACOUSTIC_T=
ARGET' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_FAN_TARGET=
_TEMPERATURE' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_FAN_MINIMU=
M_PWM' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_CLK_COUNT' no=
t handled in switch [-Wswitch]
  LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o

After applied your patch , the kernel will show above compile warnings with=
 'W=3D1' flag.
# grep -nR -A 1 "default:" drivers | grep -i 'break' -B 1
And the above command will show all similar cases in kernel driver folder.

So, your patch is not necessary as my understanding.

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Tuesday, June 4, 2024 9:23 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Kevin,


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, June 3, 2024 5:09 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

Could you share the problems you encountered?
Some compilers may prompt you to forget to handle default cases.
[Zhang, Jesse(Jie)] These warning scan by Coverity. These are useless redun=
dant codes.

Thanks
Jesse

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Monday, June 3, 2024 4:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_leve=
ls and navi10_print_clk_levels

Since the range of the varibable i is 0 - 3.
So execution cannot reach this statement: default.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index cf556f1b5ed1..076620fa3ef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1389,8 +1389,6 @@ static int navi10_emit_clk_levels(struct smu_context =
*smu,
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
-                       default:
-                               break;
                        }
                        *offset +=3D sysfs_emit_at(buf, *offset, "%d: %uMHz=
 %umV\n",
                                                  i, curve_settings[0], @@ =
-1594,8 +1592,6 @@ static int navi10_print_clk_levels(struct smu_context *s=
mu,
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
-                       default:
-                               break;
                        }
                        size +=3D sysfs_emit_at(buf, size, "%d: %uMHz %umV\=
n",
                                              i, curve_settings[0],
--
2.25.1



