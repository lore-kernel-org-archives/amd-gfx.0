Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31F2EA4FC2
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 14:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB5310E44F;
	Mon, 23 Feb 2026 14:05:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KBA4Zk/h";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8324B10E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 14:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tj8Lz2NVupqK+qN0dcRTdjAQYMnQEKDGEgTtnRnFWnRqSMOXfek/FFInY5wMlpehOKvt1lecR3LkbarPW+z+J27GpUSgIhzXJOHetr6Xpd+davoYG5TQEZkGsfk2U/8tc955JBpPLJfcIaOIjoViMEU55hJL8BWU0O6V/Os4EOjIi3D3+fAlm/EhMLO61UUIIiLQKaxw4PfcN456XNpavOqHkvo9kgxn1ZYlEndViQxnBRO1xkxQ1jzM0CHC3sv+uEFLN4Ubu+1ZHnT9GdEVbIZfhZ/ArrnXEC3RyuBsDXkCsT1zUTr59R4nZR1Jb0Gnso9A9EqLgXehuGg2zlIyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCNVn6Dsql6NQm6Ckg7tvlJsXu5AGKTtDaCqTOxolcU=;
 b=o7sRwKZCHt3xT36D+0UaV2F2y70SzVWqW5Q8KOpEUTihHO6ZvMRq49gOIRGPMqHAopYVi8/ahKnKjcOc59KeKcVApLvEzxTvoeCcg1S0mgT8yEtvw4nTtaTPyzpfDlLNng5of+CKURMsoQRSSgwz2a1rviGEZh0ZnUwfHk8QVY9R4TQ+Lc+oJskyF0MpKKxfjOZEN8QJpTVccnnpm9/sL+dgobUllXu8rdau+0KE4g8EiX6Z/J21iaukDNmia0TVNvTMP2f+dmgcnKFm8XGpuPNEx+wrJs0UYEi8G8WE0W+95Yd76DUeXi/G4nUI/m9vj43MVVpgt5HvxJAsXmor7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCNVn6Dsql6NQm6Ckg7tvlJsXu5AGKTtDaCqTOxolcU=;
 b=KBA4Zk/h1iizmFcOlzoft7xqjTW43lWbCqJ6FPvmJb/rjt8XT8aINBYIbSZwXs+P+eQPBVUdvqUAgAlRmg6Bvw1PH5BqzX3JWR5z7W5Qnc2bJm3jzZcgNTc8Ksst32BgQbeZUfxNhJ4a9SAYqaGSgM+3rCrhL66TEOXY1wiAumU=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 14:05:27 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::43e3:7eec:f4e2:b0e7%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 14:05:26 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, Mario Limonciello
 <superm1@kernel.org>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix kdoc formatting in dcn42_hwseq.c
Thread-Topic: [PATCH] drm/amd/display: Fix kdoc formatting in dcn42_hwseq.c
Thread-Index: AQHcpMs8y24e2XCc30KLAgyEROynXrWQUTOg
Date: Mon, 23 Feb 2026 14:05:26 +0000
Message-ID: <CY8PR12MB8193A77187A3826AEC297E038977A@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20260223134914.1625954-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260223134914.1625954-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-23T14:05:11.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|IA1PR12MB8586:EE_
x-ms-office365-filtering-correlation-id: 957d7d6b-0394-4c9a-fc40-08de72e49874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lPWyPrv62pKMhoF3pOijZN2LH9RCDdaepXUs7fDIidT3LOajVDCh/MkfNh0O?=
 =?us-ascii?Q?PsUIQXOKgnOYqpfMK27CgM5p5EgLrjweelYLv91O5G/6E7XIczhyt4b40L5j?=
 =?us-ascii?Q?pa9bnfmkGyPqOg3sQc0vbxGyjKTRzefqQRgtE5L2XMp+WjXgmT3lJ3woxJcU?=
 =?us-ascii?Q?mHw2LTjGsrgbnlsVOV6xS1+1gvH8zFRDiF20I/i8YUm/dHbt+XBMCtr6NK6e?=
 =?us-ascii?Q?cVO4sub5kplNQKNjXzuvo9+v5TcWDHBQMF0bscqYO1+Ar0ThsJyA5e+5stSB?=
 =?us-ascii?Q?dlKQY+Vx4OeEHMIbeYGec7oaHdHSLpNXQYk7uTt65dE4pIZFfCSGSMWB+SUd?=
 =?us-ascii?Q?JWnu+ao3HD1ekIxrZhzs6FWp/MqAQpgngte4mPdFC6f5i12QlFH1wVxVAr6h?=
 =?us-ascii?Q?vlRIzWeOnRXkmi4hE2VWqHLs4gboDsqdhg9nzNHKz3KXqrokfnOIQc+vOPVo?=
 =?us-ascii?Q?4IIFsJzx4nLNlxuh6oWfzZ2tgmsnfPpX31/Qke+bbrSKDIvVGXHvb5GoMUmv?=
 =?us-ascii?Q?8uurR8ZRhRbLZG0G4RhtPZ78lWOCOnHeZmCx94LhtdHOH/C9jah0uI+R8MEK?=
 =?us-ascii?Q?owSnkICmCy6iFVa7YQNaGHH1E0dPhGJYCJj5PGgIb4io4IBZ7eA4NTmxmn5o?=
 =?us-ascii?Q?aY+UxMt5kFCdTOs9m+LHkq0qJRzEC86EaOUV4h6SXtoNFKC+fY3wt2ieeE5j?=
 =?us-ascii?Q?h26exnhByhN2ZBAeI/EWnkW6a+mGr9W44RIdfdoUHKwRRqwIlG/UKHhrhrtX?=
 =?us-ascii?Q?AqWsL/SrF2dBE49RPIvMN8uR7xmCm5Jyh/SAZj0RbK8W89LWsLPOEWwejFCc?=
 =?us-ascii?Q?UzLI/XVkRIhoGOQ717MbDdSWOU7dBBlGiwFmhdUKay3tEjfz3HPuYcPLhxt3?=
 =?us-ascii?Q?DUof1jMTEK+hdC/5H2VyA/sY7O8xBwHXT4vqzTN7YhcpvBajm0PAqn2iLGcb?=
 =?us-ascii?Q?nApY5WKr5Is6oUgUeZPvybQl48AEHTeEzAUuWACmlHE9rV3t1i3noOTkiXE6?=
 =?us-ascii?Q?0YOIf2dfWMnfsWcpCukH35Vo7DlTI23Xn1ZDWCrI8t5O3++i2YqkiwU2/WpG?=
 =?us-ascii?Q?s9YNALQXVLALxLv0FH4RrRxBLgdb+0g9t+s7KbCXd5AT5DGXmirmD9T9utzd?=
 =?us-ascii?Q?tTV8m6zftQbBgkLRmzFbORHRsZoNGx9QGKCTt+7g+hCGU+nDp2Lzxl/rRLs8?=
 =?us-ascii?Q?DQk2qv3EtKeVA9TgcUNSHNW51wgxFiUTzobO4T9xXW9sHKRxg0bLrHJb7UR1?=
 =?us-ascii?Q?xe4e6o/WAH8+XTRHou8VVIDmUtUS4TW+6hs9F6G9WhJeRSSrNuA+EUG3WTTx?=
 =?us-ascii?Q?iI/2dstgyNQdwhXnOyt9EtG3aEi3etnIsy08f+cIolmM4hLLClmUnI8r1AxC?=
 =?us-ascii?Q?MXsvfhQV0tscY1PKaWlsWiRYVzsLK7DXw5EEodRMCRhBLGDwFcp2WrvN0wuH?=
 =?us-ascii?Q?ww3rzHh08kkSw3Upi2bAcZ62lCIInrqf+RcSQ55SMBT43l+96tU35fz++sFC?=
 =?us-ascii?Q?vhrNwZoLQePeISjYlrJXIze6kUliXd+XQpTntjY8ga7dpwFTuHK/nmlCWapi?=
 =?us-ascii?Q?OBSXIQM4b6A592LG0Vyu4PCDtr1lX7aoipDHqwceByGSmgNjPd3BifMiHwPU?=
 =?us-ascii?Q?nl2IbrZlwk+eZB69IWXlyGw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?965yxfCRFadVZGcv0H+5M6d1hR0lC4Mj9Hhmqa+JksE8jp6Ei6uTAFH49OoV?=
 =?us-ascii?Q?MsTiPDNUwr+O7aU2+UF4qBR0UJ90faddSYgk9uLsj0paS/7Oyu8JJ0TOuXoe?=
 =?us-ascii?Q?rlxrxsjCBbGFwxkpIk/MM2bjd+se3UxixFVB+cIa/udhEcTNZ8sWUoa4Vboq?=
 =?us-ascii?Q?m4srzlFhcBk2Z344oiE+3nrmTGy4106bqEoM0o8wzu/Jt4BadbSBNDWzN+c4?=
 =?us-ascii?Q?Pl90MH7EBd5Jm92v4rF2umg8+FOkz3DMwFV+eUMIKXLV1gGDhETy5SYGoAya?=
 =?us-ascii?Q?HIfMdE6EH+w28fOhKOW3userXToyqHvrsVSpxrh3ePPoYawnv47cpn+kQZDe?=
 =?us-ascii?Q?NBDmGtL4Cf4XqvF4AU6Qcm3kmaSx13FNqI+SRAE9/78T/sDPZezThKSNjLjM?=
 =?us-ascii?Q?gOb2GnPhGC4ioLxIUdw/cCKCYmns/dozL6r6Yp/EJeuqrjDRPGWeExjsoQvl?=
 =?us-ascii?Q?4BvNvaIhE2yX0pzEisD+GAG9dmXFBNzBQ3jql6PZcwre+gBO7Ma+41+YizUA?=
 =?us-ascii?Q?P5aLHoQDNRydekYgr2LBDU3PUKKi8CisMBVyRf98py2D+gipdopmhMu1Bmjj?=
 =?us-ascii?Q?rPA90fKU/6Mv7ix4YmapNRhqoVOhK0DMpG1CgMHCs3QU5S0fKUJPAc33c5Bk?=
 =?us-ascii?Q?yA48VkMKfLTbvPDN0qzX7so3wai8V2YJASoWmUxeeSxNbAMjG9jb8mfNJSSe?=
 =?us-ascii?Q?F7K+UNYEMzgKAwGAqYDAWpBnKGDtQ6Wd+zzIaaKJRZ9JB0zigG7Zs1fo1JTV?=
 =?us-ascii?Q?qG5WQSu79qFtTJnrhdErTXQe5kEPMMXr9Lm9chy0/vBcNY2HZBNF3nOXgbNt?=
 =?us-ascii?Q?/QQgFIjmx4NIBIKFvMP/FgKPRaLKSgoEmQeuYRx2eaUIJkyryzXOmCYqaJx5?=
 =?us-ascii?Q?2VBFeDCjAsFt/n021e3EcGF/d8VDRERGwmGg/GBVDeRv7H9vFjbGO46VK0cg?=
 =?us-ascii?Q?5XS6NxRPhFSBtQ6CDSSOmwKK6Eps2HCXMMF2TQz2cBOpCf6/lM7qqZIFFm/L?=
 =?us-ascii?Q?hqAl8HLtXXMF8q4/KKKl7QwRmEzmsXhRhIT7HbfgY0YyheZ1JT3PIz5VYEFH?=
 =?us-ascii?Q?12WRyS5n3lJJJ863jCSg+miC4GlH0rIzAbGkkMkFXrmDs+3AI1+DmA9ZMfLb?=
 =?us-ascii?Q?ssp/xqx7b2p5HfP0rwzpl99WhRlN/FFfZk0zUr/JhAIYgudNm6d/dZxjiDQj?=
 =?us-ascii?Q?WDR6BFxmUb+sq0G16UAE5dZOV3D/yGb9lfP5vnrs39hmEyL3eMr+0MmgBsKq?=
 =?us-ascii?Q?wFProCoBvwHatLeaN4FsCVlZIvcdft1SfwNzYdHcCZMpS4jrp3AmFe3uoPkX?=
 =?us-ascii?Q?qb6ap08plXEvzZvpSoxLqlApagYX2+7IB8Gtiy5NaBrGjKlr/R9j2yHfYzNi?=
 =?us-ascii?Q?RZ0Cvv7ZAY5sj3CnZdBkG+KgGUQUD0pOPCp0TtqnBrHVs07I+pSWTrMogkwU?=
 =?us-ascii?Q?AN3+z9rXrXO8gyjzGzYH7VwwOt5bUZ3PvgdorbWptYia+jUw8bIUuwrM7qoj?=
 =?us-ascii?Q?IYBsRaKel44Vhmvf0RaGi3KxsYqlLqg1k27s60eaamFoYCOC3QSY+yoYNCaq?=
 =?us-ascii?Q?H7y81YJ+S2u1Kj7uzykQRSuWhwKSl4PqcvQHPPxvlS6dwoKZ12gC29q4lnlc?=
 =?us-ascii?Q?YWjZSoo7A2qKLCRqP74x+kFiUBtQbZ5wGctyQVsBpl3AEOYSVvkAweNd7i0B?=
 =?us-ascii?Q?uGIJ6hWTaEtN6WK8yKi85y26zzgYWFrtqZbvKNXBbJljbc9X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957d7d6b-0394-4c9a-fc40-08de72e49874
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 14:05:26.8738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2w8Zg2jb7oTuyZiptnuRSYkVRgb6BVGhohvljqpIAockcZTtx81gY2d9Mzgj8mss
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Sent: Monday, February 23, 2026 8:49 AM
> To: Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Mario Limonciello <superm1@kernel.org>; Chung,
> ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Li, Roman
> <Roman.Li@amd.com>
> Subject: [PATCH] drm/amd/display: Fix kdoc formatting in dcn42_hwseq.c
>
> Kernel-doc requires all lines within a documentation comment to start wit=
h " *". The
> previous empty line caused a "bad line" warning during build.
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mario Limonciello <superm1@kernel.org>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> index c9c6ef8236ed..0d9871f9864b 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
> @@ -1294,7 +1294,7 @@ void dcn42_calc_blocks_to_ungate(struct dc *dc, str=
uct
> dc_state *context,
>   *   ONO Region 9, DCPG 2: dchubp2, dpp2
>   *   ONO Region 11, DCPG 3: dchubp3, dpp3
>   *   ONO Region 4, DCPG 25: hpo
> -
> + *
>   *  No sequential power up/down ordering for DCN42
>   *
>   * @dc: Current DC state
> --
> 2.34.1

