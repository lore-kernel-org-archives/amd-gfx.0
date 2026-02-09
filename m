Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1260E94625
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 23:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EEE310E077;
	Mon,  9 Feb 2026 23:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G7eaP1GO";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5B3510E493
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 23:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpCUgizHmhoeju3ZEI3I0XwGdMS5tG1iki+gQz/c/Gn9a04phTQ5IOi1NTtJixKduGm/idgWtkpuIttKa52XWZMcPh8YbfF/o0PTZj8BVKZO2DrycwzTFixdqxTZHwUnSfIhiJhiLSy3JIW8olwpSxePhdCUP/OxjWc/qupEqCdE3TOwGtecxrSLepLk6Bybpb/I3UD5SoURFofk/3GfT9mZtOh8Hr1O/rkqd0+CnpX1RC+XiQhV5KbFIBGNjF4ZA4xOm348l9hkGOH1GzoY1zFNIyHWJV1gl13LnPOTRYdhbj4HlMNADm2BkWxqPs+Rcyg/OgQ5p/3TuqgOttIuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hrUGKgmS/Q9E8EUxVmZjPJNB7T2apb9jIB0Q50kvh0=;
 b=cOWy8Xfi55MT5ELYNYS7MISN5Ei4c2WZ6wL99uTOsxH16l5iwkKjmy8HL6ARWuc2qXqBouMokqHaYGDgioFR0RVado28i8fIpm1fSHCLgwH6K5uaP+BoWAOcToi0t9TK280oTEzThcaBAbvo+oeI1SM/QNRPQQxpwoudLAgt/+DkaOyJtf7gbzeGprE+R1L2eRa3R/WrB2nAqv5okYHxjVGz7JcPE2D0XXLG0AujmLZxDLOMpVUYZByTenZse/OG/SDF6MBEVLI8c3so9DpvMUx4XPZF0zoQpFW1BO9Z0pyBUlsUhqG1J93ps+OK45jTgdmNVgSXymCCX75rYWPZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hrUGKgmS/Q9E8EUxVmZjPJNB7T2apb9jIB0Q50kvh0=;
 b=G7eaP1GOUVefOhXErd2DwXb3EtNI7q9SqLsnxkrpXIk5wI5NFtbSUG+q9JQ7mu1VYRRd8EDzRZivO064N2iERRNpyAPx/jk3OfPRswXwmnpOM60TnpIlAvpCFYoPX8EjyoP/DRvrHq7ou/PwoEIBPTS5SQnByDXsK35cvUB8M6E=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 23:34:08 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 23:34:08 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, Mario Limonciello <superm1@kernel.org>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix out-of-bounds stream encoder index
Thread-Topic: [PATCH] drm/amd/display: Fix out-of-bounds stream encoder index
Thread-Index: AQHcl3wGx7ojTgB8yUKlb5bVa4B/67V7AioQ
Date: Mon, 9 Feb 2026 23:34:08 +0000
Message-ID: <CY8PR12MB8193570B0F1446F4E65B346E8965A@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20260206151923.1479783-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260206151923.1479783-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-09T23:05:41.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|DS2PR12MB9798:EE_
x-ms-office365-filtering-correlation-id: 25f9f35e-7a71-4b90-8c44-08de6833b8cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?whuP8jdR1NYRKEH8e0suYovMuvDxS3pjk/02mCBSFChybaBg8UGalct00F5F?=
 =?us-ascii?Q?Csgj6kk45kB43GMvhJTPAlXZ7igfTUPxu8Uu2CnMlHpzW8tCzDTjx/mXgtKr?=
 =?us-ascii?Q?pkXxfsaCHfbLSfIVWLghmsIH8uKEIvgpDEmMlrga/WryuIxzpfFsuSLLPy7x?=
 =?us-ascii?Q?nqwna3OYJDuGUTq6N3SUulkFkLDBLUuw1mr2mHjI5upxxeOXdJOhATVvwBE0?=
 =?us-ascii?Q?naZCdCIDTAowH6xkzXW/zde++Q5e2g7Tkw4d2aqd3lLKHzJCSwNuoCS6N729?=
 =?us-ascii?Q?frqeheDCKmOpmuvcthWEA61xeXtYmOvjF0iLe4KqekKDLpy5u/Uu+KQikt7U?=
 =?us-ascii?Q?LOypzVpaUqQTcbcKw1eR8FW3lFCDtC1h4o9JRH/OSe+qWg1blM/j0XTvj8l0?=
 =?us-ascii?Q?7EENGWLAZydlBgByjatklz3x+QKmE5MFlixLh35Yol1e+JH101EwBgbOKxoh?=
 =?us-ascii?Q?KtY7yRsOMtDX4JaO7XtojXRv0kSvSrUpdep3P+ge25EPTOaUUGsc8T4Au+1I?=
 =?us-ascii?Q?NwJEm4z5C558aJW53LATKNQkNEXGBWyyPexY5tBCOv/60ECmyS+q1TwuTUol?=
 =?us-ascii?Q?Rcpb/uJlH6Yxk5PhTm9+my6qc65Exv03ltajw425YeHN6Rc+XGAe7Q3jovyp?=
 =?us-ascii?Q?193erbOpv5EOYO3KCxwz3BYUmFi+8L4qDnIsB8d8ylhkRsdcNIaUDftlbE1x?=
 =?us-ascii?Q?bhWy4qGXD1EXgjuzPA8YfrdgihLWLRs0FSWzzSXZPw+3y5tmq6v56EBnmJrb?=
 =?us-ascii?Q?su5rqnJ23vINyQlz/9BVUYxYU0vqTiH0BIcNHGDzOk0NOT3u1jorfVQ96HE9?=
 =?us-ascii?Q?H6adeRh2Ir9hHXrsw+k5UxCDabpmovn8qDonouQ4qtAU/r133/ZwymdeWnB1?=
 =?us-ascii?Q?AhnWdecV8CEZWNRhUDhH8Zhdk/fd5Tdi7xv9TTxnBMQ/Yxuv80I9W9LiMHyV?=
 =?us-ascii?Q?DlIEqta+DGiIGdCTPc4jOt+gUMsI5jCkwWVCMvJX/ZaI5281hfSc07OBsMuV?=
 =?us-ascii?Q?b+BTnC8Ihu6QjqwjvZyx2dqQSSsKVZ09Rumpzb8LqoBToh69aKPLrtZ/BNzK?=
 =?us-ascii?Q?+pR6kwiDNouoVWw4fEmaZpQwLehOB/VMXU11WUkiLseHRzhWAImNhA+iS9fX?=
 =?us-ascii?Q?Bum3bE7boez9lcVeho2L2CAalQ3U8CoaqaENCmtT2WZS0WKEB8VmM0LsAxhZ?=
 =?us-ascii?Q?SfLyhFBIIRzZUesGynNbWO5ryuukAzgHVXsGYsMQhy/TBACu2DX+HidEtuFi?=
 =?us-ascii?Q?rsuVdpvhava1kCwdLM9DNQD/zdz3e6x7Qbhf6sW28oW2KFLgOCfF30nuBJJ2?=
 =?us-ascii?Q?h5Vo40sgfVHR1VYJmZhYYT5nd2B8PJStbJ6Qn86ITp2IutGCsfxxkKd8hSbC?=
 =?us-ascii?Q?TJCLA8EX45Myt5yWSCkzoGv876tVjKdCND2Kq7iao7aWnS75Ot1YgYKqG1Q4?=
 =?us-ascii?Q?doT7bY0yJwr5GKkh7DkCxm86GyE8fP1YL6MrXUHhHyicJa89neRftC3z25gs?=
 =?us-ascii?Q?94eYTfoBNL2Tfh7DUNNaQeqU61cD8dgA5tfk2mWDixn2DPJSQbxfzjT0RcOi?=
 =?us-ascii?Q?iKtx8KBtXlwE2Q1srtBFuojPWwpH+KJXJFwXJit/nkROZQ1vAJ8SXm7SfYtS?=
 =?us-ascii?Q?sXY/8ba81kvVsL0iXqC6FFM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7fZiY4CZlzt4OYBDEqcb6WPEg3WEo7Fjnzvx7Y1TZh6q8kjHw2Hm3f1c4h7w?=
 =?us-ascii?Q?EhZsI6XF7qKGU9ciXuoGznB4AH4f0UZKXYFAyXjve/G+Vp0vq+Yrnv+d7+Hc?=
 =?us-ascii?Q?ctZsOiyG/IVaxLlUZHpvKTTWFcS0KQho5kVnPPn9/ls/x7KQMae5682S7v0x?=
 =?us-ascii?Q?1dcTTeFQsEO7HYT/kCfGfMQVOQUQsO4ndLwCJHFqe8wmAWxlUUnSAcMj+JUr?=
 =?us-ascii?Q?l1wU1iJ3wvOBxhnhkO0fktTHvCyZW4zpweUm9ram46tdCdjacqrC1e5Y/Xs/?=
 =?us-ascii?Q?+FM+r7KfXX4h3h3eSF7p7S2KK3zo2FErPtHlwo+CmWzf5xndKd1fveQhEzum?=
 =?us-ascii?Q?zFmUmULpGfbeeGYsyKDR5V4YwOnkXYThgKwGgaZe2L2uDxLqXjxG+UorXA2H?=
 =?us-ascii?Q?XCebMcmJFxhAS7Ubspgb1dq7TxvJZ6VRCxu3ektN447ufqOpZ7G/7AHhN7Vm?=
 =?us-ascii?Q?mm2h+f41AWLMhcy3nHedzHCo/E4sAsSWlmp+z6fc7GcwlEomPLY0hhXMvjyU?=
 =?us-ascii?Q?MOtG/kYgwm0xrmHf09Gd+Q8mZwOoLGIAPeFw41qdINByoNuVUM0fzCjhihVL?=
 =?us-ascii?Q?VhC3KrVrERw0mX93qRunAsSo++YYgnNSDagq4R7n3sxSL7rC3yU61tElD9FI?=
 =?us-ascii?Q?172fn4mBoh8GdhRfmRn1gWKG1dExwPR44jV0cAx7HQ3djNcPqqwtswRI4gsn?=
 =?us-ascii?Q?JTtGeUT2IaWBZ8SPc2DNu9u98p9tbCpY5yA/2CetLjn6oBlbGhlh2qJXIz0m?=
 =?us-ascii?Q?+VUYzox5auDaX8SiW3Vus9p5pgZNHFAtEVKEOPjBBA+I412qdwO2+tOzyr8T?=
 =?us-ascii?Q?7tbZl2InBFs/VY2Mp8dgK3anbAc0jQ1LxcMyY1LV7o5QdDGFSvgtNyF+oTt9?=
 =?us-ascii?Q?EjZ8cNTpgdwTFb7Pl+OZ370DdcubYEp7KINNq8cDMU8itlnQK7t/1ynXTj4J?=
 =?us-ascii?Q?knaHYH8w/+znmP971rDxGaFPHlSLF9cMQCgS8Z/0ajV0naun16mVR8BIDdk7?=
 =?us-ascii?Q?yKohh4Wpr/7RNQUaCpGGAGVWteXX6b1kioz3vhj+27isLR/M2JQ0HYTd/BT4?=
 =?us-ascii?Q?jV2ipxvMR5IfIbLdqOyb16ew9ZyxA/FolT9HHfvFGKKggQst80gHbUC8zd/g?=
 =?us-ascii?Q?RmoOZCemJODGlYi26G+aiG0m00YL2yQGh88wcB/pR7iLtCB3DtWGOhBta+99?=
 =?us-ascii?Q?ENPeVwJX1ftte1goU8Q/Lzo15xVJ1EJarj+AASf2uMGG379ax4K8OJ5XqoyT?=
 =?us-ascii?Q?IbXKn+WIOEDo4Zf/9uVyzCyK/SwSrQw/naIwk66zhWhf5aE3P2YV+ro7NbMB?=
 =?us-ascii?Q?F3CQPowhehPDQBIK6HINq4RRfSuVzhtUzEa+YEUTVUHbMyj/4bA/lKoZESEA?=
 =?us-ascii?Q?XA183clgQda0WOwNK/HKJMMMJ774eyj7nbLkOz8fs9rslDNMQxSBXo1ZEJ/6?=
 =?us-ascii?Q?UNUZWjBbjI1sLabwJMPt2/fxMYbnQxFm4Rc8M1XpdK3qdX+mdqLfWz8ol7BU?=
 =?us-ascii?Q?AJb7kbQgk14C9mHMpC2MRFZ4wrvReB8CiM3akc5sArJa1af5d3kp6DAA0lqV?=
 =?us-ascii?Q?avd6qRhHl9uFXjkpnwwZVdLncqITYJCBIPGBVsnEim/PDHLPERLYtSl8+wNY?=
 =?us-ascii?Q?Co88dimSPNZVZHRSyHkTYmrHtQHvmzx6D0RNXp2hG6vpvWfaMIKvOnjADFKO?=
 =?us-ascii?Q?Xw3Q7+qZ4D0ss0WlsdO6i1rTN75xkQIGy6ozqZS9vTs2tr6W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f9f35e-7a71-4b90-8c44-08de6833b8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 23:34:08.5118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAj/CMCocCDqLpgQ7SJfctKggqSEU6Fphb3S3oWG1llR9KxSiR27dxfY6pC5gyji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798
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

[Public]

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Friday, February 6, 2026 10:19 AM
> To: Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Dan Carpenter
> <dan.carpenter@linaro.org>; Wentland, Harry <Harry.Wentland@amd.com>; Mar=
io
> Limonciello <superm1@kernel.org>; Chung, ChiaHsuan (Tom)
> <ChiaHsuan.Chung@amd.com>; Li, Roman <Roman.Li@amd.com>
> Subject: [PATCH] drm/amd/display: Fix out-of-bounds stream encoder index
>
> eng_id can be negative and that stream_enc_regs[] can be indexed out of b=
ounds.
>
> eng_id is used directly as an index into stream_enc_regs[], which has onl=
y 5
> entries. When eng_id is 5 (ENGINE_ID_DIGF) or negative, this can access
> memory past the end of the array.
>
> Add a bounds check using ARRAY_SIZE() before using eng_id as an index.
> The unsigned cast also rejects negative values.
>
> This avoids out-of-bounds access.
>
> Fixes the below smatch error:
> dcn*_resource.c: stream_encoder_create() may index stream_enc_regs[eng_id=
]
> out of bounds (size 5).
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn351/dcn351_resource.=
c
>     1246 static struct stream_encoder *dcn35_stream_encoder_create(
>     1247         enum engine_id eng_id,
>     1248         struct dc_context *ctx)
>     1249 {
>       ...
>
>     1255
>     1256         /* Mapping of VPG, AFMT, DME register blocks to DIO bloc=
k instance
> */
>     1257         if (eng_id <=3D ENGINE_ID_DIGF) {
>
> ENGINE_ID_DIGF is 5.  should <=3D be <?
>
> Unrelated but, ugh, why is Smatch saying that "eng_id" can be negative?
> end_id is type signed long, but there are checks in the caller which prev=
ent it from
> being negative.
>
>     1258                 vpg_inst =3D eng_id;
>     1259                 afmt_inst =3D eng_id;
>     1260         } else
>     1261                 return NULL;
>     1262
>
>       ...
>
>     1281
>     1282         dcn35_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bi=
os,
>     1283                                         eng_id, vpg, afmt,
> --> 1284                                         &stream_enc_regs[eng_id]=
,
>                                                   ^^^^^^^^^^^^^^^^^^^^^^^=
 This stream_enc_regs[]
> array has 5 elements so we are one element beyond the end of the array.
>
>       ...
>
>     1287         return &enc1->base;
>     1288 }
>
> Fixes: 2728e9c7c842 ("drm/amd/display: add DC changes for DCN351")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mario Limonciello <superm1@kernel.org>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/dc/resource/dcn315/dcn315_resource.c  | 8 ++++----
> .../drm/amd/display/dc/resource/dcn316/dcn316_resource.c  | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn35/dcn35_resource.c    | 8 ++++----
>  .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 8 ++++----
>  6 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resour=
ce.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> index 4e962f522f1b..d8c1f1911c37 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
> @@ -1230,12 +1230,12 @@ static struct stream_encoder
> *dcn315_stream_encoder_create(
>       /*PHYB is wired off in HW, allow front end to remapping, otherwise =
needs
> more changes*/
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if ((unsigned int)eng_id >=3D ARRAY_SIZE(stream_enc_regs))

Could you replace the unsigned cast with an explicit bounds check, i.e.
if (eng_id < 0 || eng_id >=3D ARRAY_SIZE(stream_enc_regs)) return NULL;
It would be clearer about what values are being rejected.

>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> index 5a95dd54cb42..732f7bfb9103 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
> @@ -1223,12 +1223,12 @@ static struct stream_encoder
> *dcn316_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if ((unsigned int)eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index b276fec3e479..9c4a31c0224b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -1211,12 +1211,12 @@ static struct stream_encoder
> *dcn32_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if ((unsigned int)eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn32_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn32_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index 3466ca34c93f..3e760a9a8812 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1192,12 +1192,12 @@ static struct stream_encoder
> *dcn321_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if ((unsigned int)eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn321_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn321_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 45454a097264..09ed0d5e50bc 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -1274,12 +1274,12 @@ static struct stream_encoder
> *dcn35_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if ((unsigned int)eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst); diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index e3c587165807..39ec7d5e6803 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -1254,12 +1254,12 @@ static struct stream_encoder
> *dcn35_stream_encoder_create(
>       int afmt_inst;
>
>       /* Mapping of VPG, AFMT, DME register blocks to DIO block instance =
*/
> -     if (eng_id <=3D ENGINE_ID_DIGF) {
> -             vpg_inst =3D eng_id;
> -             afmt_inst =3D eng_id;
> -     } else
> +     if ((unsigned int)eng_id >=3D ARRAY_SIZE(stream_enc_regs))
>               return NULL;
>
> +     vpg_inst =3D eng_id;
> +     afmt_inst =3D eng_id;
> +
>       enc1 =3D kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
>       vpg =3D dcn31_vpg_create(ctx, vpg_inst);
>       afmt =3D dcn31_afmt_create(ctx, afmt_inst);
> --
> 2.34.1

