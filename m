Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D44C25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 09:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D734E8961D;
	Mon,  3 Jun 2024 09:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+OA8nV5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842B48961D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 09:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbbAcj8/hBVkjmzQfNDjJmplfxDNXtjOTePH/0flKYxKwc4qmRDCZ14izjxNxPqZyaOO+X+ToASi1I/SwOBxyqsJRy9jBTwRk6a3SFww6kvPPeQZoWU6UFQrjY2EBE9pDhLFHLUlrgVDm43WklPnDsEOGHn8oCAss3F5d3k6Vna+6piV1/iPmIIoiKydBmujd97QvHPGeFsD04l67TfI6UbjxqDSkzXM858lQI6aZroKRX8/tEWkycTSaKNdDQnlkw8wDcKjqGn9WEFuiQ+wx7Zeu0dytsR6m1BYXALF5hhZ+mCk2UPWj2Ji/C/voaUbp9VmR2BjjQyDwSjF2aif+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liuDTnGyMrH0/NEVrDlsbh1PLFlWImkmVW9KYll8sto=;
 b=fq9sk6MFmMlH3HhKBrBQvkjcAqClrwh2+qoj1GQjcwy+8+0a8ZDNgtVhyMPERPQClOCwiX7Zy82GFvN7vn3alvV5eY6IbAGYqktDVP1CjEsXtczKbR5dsTQMEcI2mvkQP2qVxsN7FegMMri/0ni3YHmGySrqc89IsIDypDtD7gUKzg6T/8II1rvxg6zh44K80ECuC5GsKubvDUjPkLDBDwyvB/zLJZsVM9RBvsigRIWcpMPYm0+yctW0n7jDhjRto5mf1j0tyQfRL3Ki8MuDHBj+Ob7bv3UH+FpmeRP490RyQSJHMEz4GsS9OMrll6B06ueHxdxohZv2ojdf1DN6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liuDTnGyMrH0/NEVrDlsbh1PLFlWImkmVW9KYll8sto=;
 b=e+OA8nV5bjSWtkO/OO33c2punHEiYz4wmgNc8euPusgqnDdebXCRRIxmylcioKOwwAshheOiEO5+1WiBvCGiGLHTAxKY3iYpmAEh11orYRD6cgm4u4xcyknO48GgLazw9pwSWjmhcDt2kmUFNPVBSBxcBvDVRcKPolIhIeB6v3M=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Mon, 3 Jun 2024 09:08:42 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%6]) with mapi id 15.20.7633.017; Mon, 3 Jun 2024
 09:08:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Topic: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Index: AQHatZK6ONMBj5Sd2USPLcNmrjF9U7G1v1bg
Date: Mon, 3 Jun 2024 09:08:41 +0000
Message-ID: <DM4PR12MB601207AD23D14B7BB64B3CB082FF2@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20240603084730.2569970-1-jesse.zhang@amd.com>
In-Reply-To: <20240603084730.2569970-1-jesse.zhang@amd.com>
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
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|SA1PR12MB6896:EE_
x-ms-office365-filtering-correlation-id: a22f8856-0e87-4349-a971-08dc83acc3ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?lvz/4mCMdAJ6/9wAD0bBky6lN54P11vYR8bph13Ml0ess90t0AgFceuimMTf?=
 =?us-ascii?Q?craYL8z2IdWYbFE2rNxrLVxDhl9Clne27QVDQ7Fwc6meWq8CYPn7/cuwQ05s?=
 =?us-ascii?Q?z27p+B4v1/uYmtU45p3TJ71Ui26aTM6IN3ERPVnmCG3r61ZTK4CBjKOfV0jt?=
 =?us-ascii?Q?es8UK6F2F2YDR+QEIjq7B78ieDCQJP5Q4hG1xf3DMEswAXKZDBJJGv+9scso?=
 =?us-ascii?Q?Jp+Ch5KOAZDBcItIV2XuHxJriwg1mL/ZnmSKeTMpQFjGWBedt3TjoV+frkOq?=
 =?us-ascii?Q?SMRgLpxW8JaWW2kZ4ygw5eKR2APBUaUVj6tWrxeI7rFrbUfb6NVXFwGONM9B?=
 =?us-ascii?Q?UQFYF9gXtj5Ixxml/BbIS/5MCVPIwFf/XtNOhJOGzmnSwguKR+KW9WGterhJ?=
 =?us-ascii?Q?5KhbOGhAE1fhYlI0TSUVpcmgqsG4jjPgZE2JBUzAyqWbrVb688Tgrk0+esJa?=
 =?us-ascii?Q?xzy1KDGO1zUpGf8L82ZbIlFoioT9QNGt9ZrSjMkuNcBJ+bx/tDO1/PlMAGaE?=
 =?us-ascii?Q?Dp0WRBCfWVpnnW9Z4HwPcswy8SAFmise7KyGZvArAJbUSTDn/uqsbCSQn3CU?=
 =?us-ascii?Q?82Jk5QPMNky0pJithECg2UWuBbze4IwrTmwqk4TmYhakflP/sKl47KVl7iwi?=
 =?us-ascii?Q?XWobWI4aL6r9HuwW4dyjT7iYmHbd/UpvbYTzEIuGQINrllwkiTH97/1+6JjN?=
 =?us-ascii?Q?5nhiPophaewFBHEOPLHGzPhj/nqP3Rm0TSJjSmdC75bohpQLnsu9oPaKzX/I?=
 =?us-ascii?Q?yrXqBsU2m1ewNi0IF4PnsMa2W9JWrNXEJURlBbQOPNyoFygm1ttefwC4qqPI?=
 =?us-ascii?Q?8LG4gi4gZJaEmgKbvVj/ih8nF0klqMasrZZeGRCLnlIZAwvZTI0K4A+2U7J2?=
 =?us-ascii?Q?nwZFBjHBqgw8ofmWyS64dqA8Cf9gxh/dpHfPdkq9g5hu/usXGFSyGTLZwaih?=
 =?us-ascii?Q?9K/oG9JHuIFXZF2qXws+FJlXWkhBvrK1ckw2c1UWrI+EaofbERf7UxYaVRBi?=
 =?us-ascii?Q?lB0YB5JLYOv7iQNqeGnBlRuUd7o7dVl38P7ve/Z3kNkinSUtAzp9D+I77DHs?=
 =?us-ascii?Q?VKkVdY9mU2caEVlpMfMrK75oLOpzGNDipS1G6Z0/u/Vs595qkbM1k0wu0Y77?=
 =?us-ascii?Q?wq4V1aawGmZbYXXkRs0hGSJrqoDIu9RQlHXbqqUrLZuujhbsdw0FHevxNtW9?=
 =?us-ascii?Q?YxucBq6zj9TnFiz4RfgAxLzGETb9EpSErK6gtHUyXZTLbaPnZ4KbbrHUyjoE?=
 =?us-ascii?Q?QT5q48R5zjD4y3Sne/HbcVoGWXp7VVpUTDTFNLMjSSFSK/fBK0n6wiCXjWJc?=
 =?us-ascii?Q?40qTgrKOcWPdatr2lTyn22SWhwIIa0+ZIWqqlxyrSPWvzA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lXVOHjVJ53Ur0eHDhvCZvmTUMlZfu7B8LO/T6azAONs558XHdMNxMBac7diB?=
 =?us-ascii?Q?pfnkbd9mlWMqqYNoC9YYI23uRmVamxRXGGeXtyB0LEN0LNS16yeroeojva37?=
 =?us-ascii?Q?y3CWcT++mYl2iklCl/lYvKWWgLHQTX/HZLR0RjRiqyz6WOihvkb3zQSKBHX8?=
 =?us-ascii?Q?lF6vGV2Xfg3xqmemnNMNa2EZod9fEv63XkhT9PDTvVMP9kmc7qPGjRVGBUhf?=
 =?us-ascii?Q?yfYCqV0jB3MkViu0mMoxrS1u/SvDXkLw5XWK3tGx8R7cQttgZIIolMENTb3L?=
 =?us-ascii?Q?UtOUTzAQAVf62+SsCQbJ+iziXPkJJRxQPLLQyWY8jw6VlC20rAxbrURX2uZy?=
 =?us-ascii?Q?UuK1XrsCjCUE6utG4KqG1MvsZsDqBuOz6aXdD/uRjc1S5dbU4LkUGHLqU6n0?=
 =?us-ascii?Q?83TPh9l9zFU6M81XaLQ/xM18iZKo2MsE2Y1KzMO/ERwro4fBsg6OdIaeg72P?=
 =?us-ascii?Q?QRqPqmoOg64ZuGkvOChWC0BKeuneXFIPXpkBTPfertSc0WzLi6w06jYJYQrq?=
 =?us-ascii?Q?zOVRWiF0FFWly/BNi684SQgld0YV/l1rcg2e6dfV86CkftQNxeALuR7FS6n9?=
 =?us-ascii?Q?3l5WpyhHCeRd1lXKW/7NzK2S1epJz3PTGgps9/jd4X0PAYmG4J2YVCRe09Vj?=
 =?us-ascii?Q?xY58BQMfXf9o89StC/caP7MEUn2y5ePmRy+YG37WF1iXXr4Wkhr0sZjaXi3R?=
 =?us-ascii?Q?ASSMNp8TmHeheKwLFR3F69JAjZRs3R6AbPrmFREYoJL4Sct2nV4DXV7NQHae?=
 =?us-ascii?Q?P2kEFDT/RAoXIUj0LX261gUCMSPbx3rwstp8Xn5py4x9dz76Mv/eBO53Tqss?=
 =?us-ascii?Q?VCcYPFw0vCKMNlflGs0zAhkMo2bk5K8A7pmuce+2BTpIwr34bZNTPls9tOd5?=
 =?us-ascii?Q?Y48PUWKSwMGkosxhzDGJ1fWfU2SwG625DgIY/A2Ki3dhGQ2HQ9+NL/+07lCn?=
 =?us-ascii?Q?wA3S9tF7g/KrdaWrr8w1Ss6MyimEJ7Br417QAJ1m2s1zY7QGAqCsAVTii8rp?=
 =?us-ascii?Q?HWhziB27SeR7JI5CrLC6y48Osb0g353Y9LtxchIavUtJysL/dfxLj6R2JAX3?=
 =?us-ascii?Q?6039NHTufM1pBAduguruh366H3qATif7yiTznMWj+ExLIa1UNSeNAQblEZTh?=
 =?us-ascii?Q?UEeP1ClgYfqp3XY7bnhZsPL5FaXgyUH23aWvFoQcr2sgga5mWLzTAsHGT0SQ?=
 =?us-ascii?Q?HBejSZefdkZqNjo0+jXYCXXuoIO+6/XluwwqS2Y48X3Cb+b6z/vJjVlSrsT2?=
 =?us-ascii?Q?Sj7SFu2TmKwpO/GZoE3LbeasJkV7tOD4wQMiCgH3z2gztLXedyHnh+WV7cwt?=
 =?us-ascii?Q?6N8HiuT8koLdWulmTcRKt4q8F6ye91rCZL6TJOb3RCXEQ8smoHU1+bAyJteX?=
 =?us-ascii?Q?6+Xy8/9w/kSH/rTZbtUayhqmcRCYkel5OXr5oyeRRJ9op3722dkaP5ABsDvd?=
 =?us-ascii?Q?NzBwAyyLBy25nJQIjH0UeUsIJ+x9vKVDvQA8qfMb+frPQUAYrKnPa74hiiSg?=
 =?us-ascii?Q?3qybhTfp5dS0VuztVwk3OUsF+VT5NznqmxpDOhFzpaDuX3ahT6LkoXisw4pB?=
 =?us-ascii?Q?yUZWRyeXvFU8Y0CCL9M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22f8856-0e87-4349-a971-08dc83acc3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 09:08:42.0681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+yV48b6DKtxx82wm2KLBdjD7AnQr/9w67MdyxamuS61a7wvzfeQgwKHashhOGef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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

Could you share the problems you encountered?
Some compilers may prompt you to forget to handle default cases.

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
                                                  i, curve_settings[0],
@@ -1594,8 +1592,6 @@ static int navi10_print_clk_levels(struct smu_context=
 *smu,
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

