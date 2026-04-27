Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB461FF8862
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 07:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3CF10E5E1;
	Mon, 27 Apr 2026 07:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FXI/WN4G";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C688810E5E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 07:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STdBGpsizww4sk8w0toLfvJKJYaNwTSI+UB2XKzQLA1JvT6PBFyFS37I6uP0JlqywTk6LKuEgJ/SyBlXhmRwQPJSZ/gZTiLhb4eJHT5NHa6stjPGldfy9CN2lmLMW+0Qrw8OOGJc3XAP0fWZzCY7Q7EVqwBt3HwbJhSwoKazooGwbTRcrvL0PKi8RXfdbP8F6sZUZwf/JGpTlc7fKOSkLH2ocGH8+quk0Oue4VWYbJW7uQp93+mKJKvPJ4DyJX2ZR/u1PAJkcPeP1zPecnO+KSVpkZV6Tl0AruVBO1bBpWbePRONy/O9L39sg4t8U/HvBaa5Ys18ZNcbdroAmrIH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvJOJxbcgXOnN+M6+nv4NAmzwVyxFZafEwrjE7kFyqg=;
 b=cxvezYl0hwuCNiQXUtrst7ihiUaNGTRDfx5rO5tomEZxyXAIwgerIYw5D1CJU7qeLXHdwBK65ah4QlEv2GuoDFfBYGFZu0ttUKu5j7sbfe/4HQcVFwSC6O3DUBwtDlIgdrzY3YZiN05FzPow/KmwfEAolK8hgTOVIG9qotoyZkngBYC534woT5TTaj+YuHa623nWLrpqafJZODpkFNmsqaxB9oZHoNmLhCCdYj9Iwz7U1tgRdc9TwsjO6xFGbMWzIbi1IoLNv/dzLbJhS9mzTtkkkgeCm/k1ZMxH8pWilBpbhFowGbntW688JqJsOAneavfEloObLJcOI0aQBdjbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvJOJxbcgXOnN+M6+nv4NAmzwVyxFZafEwrjE7kFyqg=;
 b=FXI/WN4GIs2LPpHpasHwiGDX6yCzPZoMg7dh8sE9+WxbeUhgS8PeuQwOv/pyHwjWsmEuqN9javT0t6DZyvmklalFXlLIM1o4U6EasqA4oFQNZz6X2b0CJ26oaKb6CnFhxLBwB7mKg9bds9vdDxShyov6Dz4TKAajrro3KzOnNbc=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Mon, 27 Apr
 2026 07:46:44 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 07:46:43 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
Thread-Index: AQHc1hfT+/g/mRxeyUi136i5frsG/bXyhjYQ
Date: Mon, 27 Apr 2026 07:46:43 +0000
Message-ID: <DM6PR12MB2972472A5F44139A4439029C82362@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260427073042.3547935-1-lijo.lazar@amd.com>
In-Reply-To: <20260427073042.3547935-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-27T07:41:03.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|BL4PR12MB9505:EE_
x-ms-office365-filtering-correlation-id: b90e02f1-1df5-4205-f0cd-08dea4312072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: W63TOzX2hzAVS3g9haArxAqUDXAfoXj4dHHDYDEv8kmPCttAPFI+UTG/2G3oRmIZHgxqS7XLQh/BZodUkHh4uzHa2lPM/2QnsJjCr2qlQpJ1wIH89b3KmtMrzmJgzNb2YWuiZdJzWW6AmoPj4uovRwX+cnyTSTEA/aOktNZNnxGU5lGOL1RaiZ1MEH9vmNqZwb24Vyp3e6pbWVhBmpAD6/OFKQkmQJ4yCSHTGIIdtBZ73ST71Okn7ijV6BNQmaojMDRSUrBdU7GzU98KbqkNge7vAjZ0NnZGLjv6bO19VlQvL34VGsWxGNZsgY17zywSafdaZrMCqzetGQTM4/rh0mYVPj8U5yFNOluulUMuxdNn6qbcqdOQD1oFknzZs3N5ZTGwz2bPn7IQYcNAsuFEOCTVlM6BzlM/v9yfCsB426UIOrOa25lFVXkxhyi5VpGzohcHfqTxzVfxfeVpFaDOWosBB/RNXPlEp96mxW7qVQLIgV9T+TqlIXRc77Y04P+de5hetged5F9gueaWkRyCpE0rXa/+A1RZYOJl5vYdvqM5LguE7SG6OjKBxuetCam/y8RhAMVqJZSFPLTPYT/8hvoEF0Fmtd8wE5NK3ywW+M8UStKXK8XQnxg5i1KvnRTXLheR2m/1JcLhDEZH22J4eJhVfqL5c7uNKWK/aD1DTDuIwviQVqM6ZIFak6WUh8yRu1b3l6mMdT9CNja4fQiL9qOYmDgONXfick+eyaLzqOYdEPlE/hbBtQUDayg3ZOcnFXJLWw39Vs0IUkO2RiwGqjdanKWWF/4V6gQQqj7F+og=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2H/4m9Wja4jGPY4hZ2L9NSI0b6Btv8n3vEvSwv6NxnmoAQRTC40iY3oOvKAv?=
 =?us-ascii?Q?DxtJJTNjiByQQDr8Jx+Jp+OB27NLvVUSKC2PC0/mmHFeiILtXCWFryBIyj2F?=
 =?us-ascii?Q?3KqwPcSwxWI+N7f2FllOB+KGlDzPSaLvxagEJ4NpACDh6DoYX+EghV23FfyS?=
 =?us-ascii?Q?ReTKoGHenmaq3dIDwVpWdeBCC0mCpaMiNu2KJKGUDQ38XK57x7WW8fGCLLMw?=
 =?us-ascii?Q?x6Yzf/Pjt9eH+qAY7BtlZJzeSFVJksXk6g2f2z7w7jz6cGT3PDiC6MG0Nlht?=
 =?us-ascii?Q?ggbsVRS9ytpTWzkZLQU+/8zL3PToF4XmzLIh6nP4M8cHjA4L2xoRYpw3c7pM?=
 =?us-ascii?Q?p7JjThxZM1a+qnMOOjBPS6kv5WmkNHkA7Q8LR4HFJ4LbqMACHlTKFVAoEiaO?=
 =?us-ascii?Q?oPR0U5F9s+iQFjlMBd5EqRF3C6wQ/AAupaNF5a+rnYBzWvNO8kQ0SdJqOn1v?=
 =?us-ascii?Q?qsL5B+YPh9pfV/RkNxeWLr8Jd3RKeI3tJ88IC0x727LswJbEGsrphWJKRyI4?=
 =?us-ascii?Q?81dzT7rBc8XjzKJExYhqJsMq5Q/e8Pjs3dAsUm+vL0HjJ0VS7x4g9QO+z00Y?=
 =?us-ascii?Q?FXpKwQB8nDQEfY4ZHb6Qd1uJBB9j0vC6L+jOUUMi1nHouKENwGya9cJxyTxb?=
 =?us-ascii?Q?5zRLTX8w6fC7OEHb6tdE0iJ0USdzuFQVx5GnJwwVbyasCKyl1V5Re4Focyf/?=
 =?us-ascii?Q?c8OjxmllfSrOl66ONBKhTo8LsO7G9RBHmEHnigM5VlZ9nTnaGNJylXRuSxCc?=
 =?us-ascii?Q?XvWecFhaJxOALwdnx6EmopRPfhpLakqHOBPq79lFVIBwuGv2re/nq/rYZjH8?=
 =?us-ascii?Q?CfzkoHncMsmGzzqKEZdDaSkFyRLrQBoRdaEHxuWi/e2rjUUjVsZ8OqgprsFG?=
 =?us-ascii?Q?E8JfJ0w0Or9WmeSlXPW1hSNI9Sbjcc3h6o5jxwynvqZSdvxBcnxxWm49/KeM?=
 =?us-ascii?Q?bkpTkRPs3Z376VOEm0pg9TSlaIr8CPlYWmETpow+D1BpRkzuxakCOIFEFXKi?=
 =?us-ascii?Q?sbMGgiFCnd4wbTaioS0OY6kDF+3xNCJWa+3Un72aFTYhTbqmEWwkJ8SGm3ev?=
 =?us-ascii?Q?WTa0oBOMXGybVeypBSx6Qr84Y9awPsNI38pC2xNyOIG7ikIxYPJQnG5ObVsh?=
 =?us-ascii?Q?/8xyFhYUKlkMilsyszxBWNKZ+Rvlob6eWUYcIoVM7zrJ324T+wz5Qp8J4KTf?=
 =?us-ascii?Q?yvZExcPhELFH4DUAt/7dJqOAFxHw6g/I3zQDciOenBeKfGickRTua6UqUjFT?=
 =?us-ascii?Q?4Ur91iRteynS0SL6igZlW6H2jWN039NFgeUVSHEsB5/RcAYvkSWs5M+RgDLC?=
 =?us-ascii?Q?vBosE9Mgqm09xxMm92hn/mM4EghBiHDXw9ckQI2covXNPKr99R9gDQo6HxDI?=
 =?us-ascii?Q?+xU/MtRGRLfy9BAcAD/0WqYjkcO9C/UE0mtMHhlKZhcD/vy6wwpfVI9hY9g2?=
 =?us-ascii?Q?RAkN0LHpxy4PCXN5pevr1SHXu7wNXFe7AZ0+WV2oo5g8NL30/0qKdH2wVXwF?=
 =?us-ascii?Q?/q1JB46Q4FVzna3eRlRrTFVXqAufTxu2nsSqicg/WH+fgkryQ/MctbejAvKa?=
 =?us-ascii?Q?QxDxb5FbDvFU1zpCGuSuuV4yFh0NLETNazIKUSUm+3G4x+RlJmAszrllDhdY?=
 =?us-ascii?Q?4EdqOe6dZj8D4DSHg0w2NeVd5NlfPWFYaYIiRb+tqx02xSSiqIxlrVLsjf9p?=
 =?us-ascii?Q?GW+2X7ry44ioEFaZZWHA6bcCnPDKPpZrmfFadOrrCgnh27wv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90e02f1-1df5-4205-f0cd-08dea4312072
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 07:46:43.7317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reV5fFgu+69OhaSZAC6nB+edng1uME4QZtYpmT6jqU6lPP+q3L8lA69IucORmT8w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
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

AMD General

+       dpm_table->flags =3D SMU_DPM_TABLE_FINE_GRAINED;

You need to move this line of code under smu_feature_is_enabled() to preven=
t subsequent smu_cmn_print_dpm_clk_levels() errors.

With that fixed, the patch is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, April 27, 2026 15:31
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6

Gfx clock is fine grained on SMU v13.0.6/12 SOCs. Add the flag to report cl=
ock frequencies correctly.

Fixes: 7380228401c4 ("drm/amd/pm: Use generic dpm table for SMUv13 SOCs")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 40f0d8a685bf..8d04f6e73fd7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1133,6 +1133,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct s=
mu_context *smu)
        /* gfxclk dpm table setup */
        dpm_table =3D &dpm_context->dpm_tables.gfx_table;
        dpm_table->clk_type =3D SMU_GFXCLK;
+       dpm_table->flags =3D SMU_DPM_TABLE_FINE_GRAINED;
        if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
                /* In the case of gfxclk, only fine-grained dpm is honored.
                 * Get min/max values from FW.
--
2.49.0

