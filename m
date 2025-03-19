Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C303C35FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 15:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8482210E513;
	Wed, 19 Mar 2025 15:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G9EHvDXg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7633510E513
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 15:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHPclDL/oetxyTBx7SId13GhfYBRNomAEdQgd0VuWZQoT6E5mKaQjVznEEb/BSC3xe8wDltDTu16FSlzVdXI8Lu89r+8cVtcaqaawIIunvo/9d40kkfAO7NkUiDK0NAKR2opmS80AKOwb/wnGoovwk6RO0WWpvmJfMhB95BQAOb3oGVCZJnaquu8dTuzmnVP6Ki6vg8CWJCDSIXkv3xI8gaiLfZBdvJ15ZD1PimAME+1lBGXq23HZ1diyR4wWQyAMHCQj6f4ihmHD1d+tysCQd+ju4ibAmOxEaKB1kGCWJkU0Sv3iLMdvUmiEz3XIW57dSLrKpPWU7DwWf+XHgITKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxuXgsBqSvZMoFEcJyqOxxPZYapCdYmMTJTI0sx3faA=;
 b=EWMVN/IaW/Z+nhPwDIq4SaWqT3eUsrt1L/wrRXLtA/qti8wk3Z0wTghohsvcn2hX5SoenAx7fqi8mO/D1z5TdfMStcl2OnqNZaqBNK66hQg2cQqMPb/V0fTNmrVe1qP0hMAPqz+Bzd1KeJCdHPkPdP+0w/0f7//OkufEprntAfkXeN9X8NlvohtXV5lNc/HPkLEoe6FBq8Rg+oRUZX0pyRHfoopPzc6orHym3nJ/fi0qECC+JUNwichDOvgoeq2cnmIAY+lmlNZJncISKqzISEaBEF3w+1QOcc+y6ODP/FI2l09J7pJy25g7+Ha6aBQ3Lx+zsT2T/VT+Awpc0uSg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxuXgsBqSvZMoFEcJyqOxxPZYapCdYmMTJTI0sx3faA=;
 b=G9EHvDXgwEfcPw7CF7b7hfNlBWYsX+sEU9mtcPRE8JNz4jg/dakxBV4NruqleGE6tRSpoc9lMA1ieME77hHst5i0z6OBtAU4f8yYyNjD7ZCE0J8/6hRhnpJJCmplx8AXEgRpiTNNXot+irfD1XaydwHlvLpBAUVUe2Qd2bP9Y8I=
Received: from PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 15:14:09 +0000
Received: from PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::cf8b:bdd3:d791:fccc]) by PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::cf8b:bdd3:d791:fccc%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 15:14:09 +0000
From: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Liang, Prike"
 <Prike.Liang@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add UAPI to query if user queues are supported
Thread-Topic: [PATCH] drm/amdgpu: add UAPI to query if user queues are
 supported
Thread-Index: AQHbl4O5xue1FZ2XE0C5YDhW19c+87N43iuAgAAffgCAAZWG4A==
Date: Wed, 19 Mar 2025 15:14:09 +0000
Message-ID: <PH7PR12MB6633E5196B49EE893463241AFFD92@PH7PR12MB6633.namprd12.prod.outlook.com>
References: <20250317212919.1018717-1-alexander.deucher@amd.com>
 <DS7PR12MB600535BFFCEBF5CF5DE68B80FBDE2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PuCvvA_ysfYhmbPXAx1KEqcrDNnO0Q41DQ6P3E5swyOQ@mail.gmail.com>
In-Reply-To: <CADnq5_PuCvvA_ysfYhmbPXAx1KEqcrDNnO0Q41DQ6P3E5swyOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3029e335-eba5-42c9-981f-129d6b528af2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-19T15:10:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6633:EE_|PH7PR12MB5975:EE_
x-ms-office365-filtering-correlation-id: f6e7d03f-18e8-447d-5197-08dd66f8b2f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RmJ2OEFveHlBNHZBeWs5NUVBRy9MSjNoMHNxTzdhc2ozQVpwdFBsOWM2ZGdm?=
 =?utf-8?B?aTVWczlEVVJZL0JPNG1vb0tjYTBoQzZGVnNnUm9zYTZCY1RZTm5TRkZwYWgr?=
 =?utf-8?B?aEJEU3kyVzlBZHBYa2RjSnlKNmxqUUJNd0VDUzRpZ0lwQjQxL3BwQklLaWNF?=
 =?utf-8?B?RXhSWGViRW1OQUZwaG10UlE1UFpDd3pid01acWtNdmM1TWN4dzNQVDFzNjdB?=
 =?utf-8?B?Tm9EVXRjaTJVVkorM3o0R3czZUtveUxWZXprUzY2RW0vV2JBVUNhM2ZxcUJX?=
 =?utf-8?B?Z2twL29HTUozYVlYRzc1cE01OWpkV2NEZHowbHE3a2x1d2ZGNnpoS1RpYlFq?=
 =?utf-8?B?TEhOVkJlOTNQVUt0ZXFucVBjbmpkdWJQVDBvZGFMU29KNWViTGd4dlpVRjE4?=
 =?utf-8?B?aUdYZWllR0ZRNkZXVmlDdCtYMU9TbGtJc2hpM1ZWWHN2SklzcWRtY1paWTls?=
 =?utf-8?B?Z3EvbGwwcWkvSVJ3WnQ4UHFGQi80R0hpbkhVOEw4VWJ3UTloVnQ5alBGbzcx?=
 =?utf-8?B?QlV0MXRjSVdSM3ZQMTZlQU5hSGV0TVpEMXlqOXpvSHJvUlA5V3M0VWdzeVlT?=
 =?utf-8?B?dGkzNFFjcExjZ3dhcWlmcGR0RmVCY1ZUWXZpd3EreVBtRTkzdjFlcnJKYWR6?=
 =?utf-8?B?RlR5Q05Ud21uSkE1NFhvSzJaeHE4Z3o5dUoyaUR4NVUxU3krNHFpck8yK2hC?=
 =?utf-8?B?M045YkpucStKcGorSTV5MncxNklwN3VGdTNwNlBuYWltMXRsdHJnd0dEb1Qy?=
 =?utf-8?B?S0ZMQUZBcDlIUWhmZ1JwRnpJL2tYOThpVnF3aVdZZG1SYzVjaWU5bjYzdlAy?=
 =?utf-8?B?bWc1dHZhTWFJcks5Wm45Y05PUUFRTDlpejJsWXkvc3B1c2lwME5IWGFxNUt0?=
 =?utf-8?B?VlpyckwrZHo3V25IRC9Kb0ZwRzNKbEFWU3JINGUyS0dGdUVZUUxQUWdVaTJL?=
 =?utf-8?B?Z0FwZ2w1c3phcUFNdUFyWlU5VnQxRzJ2L2ZCK3k1SXJZTGFEdTdqbzF0SzdZ?=
 =?utf-8?B?NGFMNUwrcVpFVFNpSnJrcTBOaHIvS3RKK0g0RXk2Vzh6Qi9vcGhGY2NJUmxx?=
 =?utf-8?B?WHU2MHI5cW5ob1ozQnNzZkFSenRrK0F3dXRLNmhaZGxya25mRzdMenU5THRy?=
 =?utf-8?B?dE1NdHVFdFhmZE9IZUwzS01Qa1ZIUTRGOUFDd2E4aEtmNThWV3ptY1VqVnpN?=
 =?utf-8?B?WHhwQjBqNGxiejBkeE9zU0dWVy9acjF1bjlpeXAxbHNRdkFCRzdRRHA4ajRD?=
 =?utf-8?B?NGNWN0NIM2RQcGovMzhNN3Fyb3lNc2IxaTNlQXh5VXlQeWxIRmpLWVJXKzFM?=
 =?utf-8?B?VHRYZlVOd1k2WUhZMU5zRENpVzlwdDhpOUNOSEowZnIvRFA1cFI0MnBWVnk3?=
 =?utf-8?B?KzlEOFh6M1k4UUozUXNJLzRyRWM2TnlEc21MQ0w4VE5sV0tHUDhDYVhaa0pz?=
 =?utf-8?B?enErbW5TZzcvMFU2c2VPZzEwV1pzOWdabldaU2Q5dzNiaUh6czhHWFNqRmxG?=
 =?utf-8?B?ZFkycGFCZnRleUJMODFTQ3FqWm5rMzRLNUtuRXd1Z2VBdW9sSVZRQnlsWFdJ?=
 =?utf-8?B?cCtSOW55akFOdDlndVQ3SUpTWTdvbzFsZlVXTWM4QjkycHJPQUcxQjU1Rkxt?=
 =?utf-8?B?V0x4T2xoaXRGZjRiRWZZM3RRb2Jrblh1aUNvNjdIUklySVF0czF0MUhEajRu?=
 =?utf-8?B?TktoMkl5SXVGdVl6b1k2U1E5TXNKem5hRnJsWjkvSmhzRkkwS2NmZzBMQmVq?=
 =?utf-8?B?cENwdWdXOVd5Uzl2dzE5WE1oUDF0NzN5eXBQWUs0ZTJaenNCdytKQWR5WHVN?=
 =?utf-8?B?Rk1ZVHh1WTdwaUdaSWZWcGtyb0dFVUZQQ014VmhtOXI0WDlPM2ZkNGRmaUNF?=
 =?utf-8?B?RFhFZWNHZnBRTEhaRXh3YkFra3lvZDRDL0lpem1JTjU5N3RzT21idDUyU0ZT?=
 =?utf-8?Q?PXk8fdeUSqrtQl9KNoYp69DkQWIz3Zdj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6633.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXlDNm9qNE1IWjYzUWx2QmUxSkZUSm1kOVdseWhxczh3MWpmN2NTTVRlZDFO?=
 =?utf-8?B?NlVCT2JmbWJFNlRoVTdrTzFBNDhycVhNS3UxeDBVZzNnWFNOMzF3Wmt0U3J6?=
 =?utf-8?B?Nkhwd241TmV5SEc0UHc1MkFDZUNVQ0hYR0N1SXB2SlIrL09EajhGMkdnZXNX?=
 =?utf-8?B?TVFwL05HZ2s3ZS9tNDV5V3hWeWdGUi9jblprSDlsYW1JZmM3Uk4rZ3lNb2lw?=
 =?utf-8?B?aUx4QlMzd0ZUZ2czYXVqSWVaNVlVQ2NEK25LNjFDOTNwVmhSdjVRaFA4a3Nq?=
 =?utf-8?B?OW9sVWkvdEZpdTlOUGRYZVgvR3JFL2J0cVl0alQvRlB1T0V5Mk1FWXNxYXZL?=
 =?utf-8?B?bXFGWjZ6aUMwSW9yWDN4V3VvTHlHS290c21rZitjUGVYd295SGZWVStjMkox?=
 =?utf-8?B?YStSWmZEbHhHdEc5R3luSGxiZVpGZ2lIWVpET2RXRWU5SHBrUGMrQkdmWG1F?=
 =?utf-8?B?cVh2NTRHN1hEUHpITVBRaTdYTzVTWDA3T0FHWlllZHIzcGp6SE9vTkovaW1p?=
 =?utf-8?B?eFIzKzNNY0pMNnNjMWRXYlUzSCsxUHZQNSt5UmhBend6WG9YNVY0cGtzNUlo?=
 =?utf-8?B?aVhoNENpa1VlaEdSRzlUZzloNEorTy9xZ1FMekEwUUNZMk5FNFNhUWozUHJn?=
 =?utf-8?B?b0dtSEttV3A0RDY2Ty9yT2ZRUVduNDZiWDlGZEtsbU1KYnpvR0d4d3RBVWZj?=
 =?utf-8?B?d0duZ0YvN0Q3Z2tNZUI1WCs1VWtkYlFjV0lqOGlJSEwwYnZhM3Y5d0pOeWQx?=
 =?utf-8?B?ZFJ2QjN3aExRak40QlQ4dTlmMnJmVEdNQWNiaWpKY1luSzFpSG54dDhGVmFo?=
 =?utf-8?B?S2V1bmJjRzRJaERneUowbytVeVdvMFFHZUlnUE9IWGFmWUs4VnF6enBQcExT?=
 =?utf-8?B?dTZDNWc5Z05lN3l0dzZQdTVTV3ZFaFRLMy9WN2UvWktRWkpHdjc2T01MaHBY?=
 =?utf-8?B?ODVmQWtGKzAxcGxnQTJOZ01PVEtsOVlLdkNyOHYvVmRmWHk0d3R0cU42RnBl?=
 =?utf-8?B?UWhqbTk0R3RPRjJmaGlxZnpPdTY5ZHZqdTJlYldNU3JHeERoMEVUaHRTS2Zm?=
 =?utf-8?B?bFNTZFNxSjNDZWpXL2VqK1g1ZE05U29vUGRzaUN0UThwSjN0eGkybTNyV2xn?=
 =?utf-8?B?bGRxcm1BK1JMV3c4UktYSUdEWFBHVUhxZmdVczNKMlArUHh1TzJpMENxVjZ0?=
 =?utf-8?B?MENWL3Q2VExsUktDL0hMOHp0WU9ERmVpdzRodHBXNDQxL2crUUJJTlA0Z2RM?=
 =?utf-8?B?d0VjS0tOd1dkYThWS0F0T20yQ2dlRGlpY1lnejlRTmo3YVRyS2w5VjBnMkJw?=
 =?utf-8?B?VFZxR2FINjFTYUUxTmZEOTd5dlU2VVJiUWlHZXo3QndpaXhOajZLS2Y5N0Rl?=
 =?utf-8?B?SGdjSzlWOVFGbFQ1Q01mR0tEeGhoaC9KQkdqcXpmRU9vaTFtRkp4SzF4SXFi?=
 =?utf-8?B?MXVVc3hxWTZaeTRxUEFEbmZMZW80UWxwNVVMS084RUJmMXArNkpsK2dzemow?=
 =?utf-8?B?UFVLZmFnTXFGL1FWL1VkWTBhWnkzVWlScmpKT0w1ZzhYYitaQjhZRVhTT0JH?=
 =?utf-8?B?RE9Uc09uQVIwTkRKQU5TYW9pbDFqb3RodnZxQXBGREkrZ1NZMVozUnJCM3hh?=
 =?utf-8?B?bHFmNTA3Sk9sSHFZWWgrOVMwWkFDR2dnamZGdDg4TnVtM2pCL0dHMmdXa2hk?=
 =?utf-8?B?cTV1dmVjWGpXV3RKR1VOdVBrUTZndGNPZEx0VkZiZ0dCOUpEMmtYbkNyejFo?=
 =?utf-8?B?dkpRRmxsTDlmT3laTnZRK0NXUS82SStxVm1KWTlPRUc5NE9Ra2tmN0J3K0NV?=
 =?utf-8?B?dFkySkx6L3hCZXVRbHozelNKaWp3ay9SZHU1ejJ5OGNIUGFWUnZRQllqZ1FN?=
 =?utf-8?B?SngwK2YxVVVGME8wTC9HbWljc2Fud3NDaWFkR0RveXhLM08xNVNjZlM5Q0Y2?=
 =?utf-8?B?ejBTblBtQXo3L2JadTRGQytna2ZQZXNhUFNWQktmVC9JemN3eWNrbzVuVUx3?=
 =?utf-8?B?WnpiMERrekdQSElaNFhKUXQ2M2hJZVpQcTIxR1lQQzZieVdFbDlFczJMNjhm?=
 =?utf-8?B?Z1N1c1BHWnh5YktROGdEWlhVR3k1bGdNU0x4cmRjaHM1bVNRSzBvNHdoRUZ4?=
 =?utf-8?Q?412w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6633.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e7d03f-18e8-447d-5197-08dd66f8b2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 15:14:09.6784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PnGA9y8Vgt/wow+DE3+BtC5jzIPzpBv9CiERmfRdC3oS9lRsGRPWYWYRNCID66Qu6hLmU5sJecCbLpu0bxkug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQWxleCwNCg0KWWVzLCB0aGlzIGxvb2tzIGdvb2QgdG8gbWUuIFRoYW5rIHlvdS4NCg0K
VGhhbmsgeW91LA0KWW9nZXNoDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBh
bWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYg
T2YgQWxleCBEZXVjaGVyDQpTZW50OiBUdWVzZGF5LCBNYXJjaCAxOCwgMjAyNSA4OjI5IFBNDQpU
bzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgTW9oYW4gTWFyaW11dGh1LCBZ
b2dlc2ggPFlvZ2VzaC5Nb2hhbm1hcmltdXRodUBhbWQuY29tPjsgT2xzYWssIE1hcmVrIDxNYXJl
ay5PbHNha0BhbWQuY29tPg0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLaGF0cmksIFN1bmls
IDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6
IGFkZCBVQVBJIHRvIHF1ZXJ5IGlmIHVzZXIgcXVldWVzIGFyZSBzdXBwb3J0ZWQNCg0KT24gVHVl
LCBNYXIgMTgsIDIwMjUgYXQgOToxM+KAr0FNIExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1k
LmNvbT4gd3JvdGU6DQo+DQo+IFtQdWJsaWNdDQo+DQo+IFJldmlld2VkLWJ5OiBQcmlrZSBMaWFu
ZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4NCj4gTWF5IEkga25vdyB3aGVuIHRoZSBjb3VudGVy
cGFydCBwYXJ0IG9mIExpYmRybSBhbmQgTWVzYSBjYW4gc3VwcG9ydCB0aGlzIFVBUEk/DQoNCisg
WW9nZXNoDQoNCkFzc3VtaW5nIHRoaXMgaXMgYWdyZWVhYmxlIHRvIHRoZSBtZXNhIHRlYW0sIEkn
ZCBleHBlY3QgdGhlbSB0byBzdGFydCB1c2luZyBpdC4gIEB5b2dlc2gubW9oYW5tYXJpbXV0aHVA
YW1kLmNvbSwgQE1hcmVrIE9sxaHDoWsgIGRvZXMgdGhpcyBsb29rIGdvb2QgdG8geW91Pw0KDQpB
bGV4DQoNCj4NCj4gUmVnYXJkcywNCj4gICAgICAgUHJpa2UNCj4NCj4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT4NCj4gPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxOCwgMjAyNSA1OjI5IEFN
DQo+ID4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IE9sc2FrLCBNYXJlaw0KPiA+
IDxNYXJlay5PbHNha0BhbWQuY29tPjsgTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29t
PjsgS2hhdHJpLA0KPiA+IFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NCj4gPiBTdWJqZWN0
OiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBVQVBJIHRvIHF1ZXJ5IGlmIHVzZXIgcXVldWVzIGFy
ZQ0KPiA+IHN1cHBvcnRlZA0KPiA+DQo+ID4gQWRkIGFuIElORk8gcXVlcnkgdG8gY2hlY2sgaWYg
dXNlciBxdWV1ZXMgYXJlIHN1cHBvcnRlZC4NCj4gPg0KPiA+IHYyOiBzd2l0Y2ggdG8gYSBtYXNr
IG9mIElQcyAoTWFyZWspDQo+ID4NCj4gPiBDYzogbWFyZWsub2xzYWtAYW1kLmNvbQ0KPiA+IENj
OiBwcmlrZS5saWFuZ0BhbWQuY29tDQo+ID4gQ2M6IHN1bmlsLmtoYXRyaUBhbWQuY29tDQo+ID4g
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgfCAx
MyArKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oICAgICAg
ICAgICB8ICA4ICsrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+
ID4gaW5kZXggM2I3ZGZkNTZjY2QwZS4uMWQ2ODNjMDQ4NzY5NyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMNCj4gPiBAQCAtMTM0MCw2ICsxMzQwLDE5
IEBAIGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiA+IHZv
aWQgKmRhdGEsIHN0cnVjdCBkcm1fZmlsZSAqZmlscCkNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gICAgICAgICAgICAgICB9DQo+ID4gICAgICAgfQ0KPiA+
ICsgICAgIGNhc2UgQU1ER1BVX0lORk9fVVFfU1VQUE9SVEVEOiB7DQo+ID4gKyAgICAgICAgICAg
ICBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvX3VxX3N1cHBvcnRlZCB1cV9zdXBwb3J0ZWQgPSB7fTsN
Cj4gPiArDQo+ID4gKyAgICAgICAgICAgICBpZiAoYWRldi0+dXNlcnFfZnVuY3NbQU1ER1BVX0hX
X0lQX0dGWF0pDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHVxX3N1cHBvcnRlZC5zdXBwb3J0
ZWQgfD0gKDEgPDwgQU1ER1BVX0hXX0lQX0dGWCk7DQo+ID4gKyAgICAgICAgICAgICBpZiAoYWRl
di0+dXNlcnFfZnVuY3NbQU1ER1BVX0hXX0lQX0NPTVBVVEVdKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICB1cV9zdXBwb3J0ZWQuc3VwcG9ydGVkIHw9ICgxIDw8DQo+ID4gQU1ER1BVX0hXX0lQ
X0NPTVBVVEUpOw0KPiA+ICsgICAgICAgICAgICAgaWYgKGFkZXYtPnVzZXJxX2Z1bmNzW0FNREdQ
VV9IV19JUF9ETUFdKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB1cV9zdXBwb3J0ZWQuc3Vw
cG9ydGVkIHw9ICgxIDw8IEFNREdQVV9IV19JUF9ETUEpOw0KPiA+ICsgICAgICAgICAgICAgcmV0
ID0gY29weV90b191c2VyKG91dCwgJnVxX3N1cHBvcnRlZCwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBtaW4oKHNpemVfdClzaXplLA0KPiA+ICsgc2l6ZW9mKHVxX3N1cHBv
cnRlZCkpKSA/IC0NCj4gPiBFRkFVTFQgOiAwOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+ID4gKyAgICAgfQ0KPiA+ICAgICAgIGRlZmF1bHQ6DQo+ID4gICAgICAgICAgICAgICBEUk1f
REVCVUdfS01TKCJJbnZhbGlkIHJlcXVlc3QgJWRcbiIsIGluZm8tPnF1ZXJ5KTsNCj4gPiAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkv
ZHJtL2FtZGdwdV9kcm0uaA0KPiA+IGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggaW5k
ZXggNWRiZDkwMzdhZmU3NS4uNGI2NGU5MTAwMmMwNQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2lu
Y2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+ID4gKysrIGIvaW5jbHVkZS91YXBpL2RybS9h
bWRncHVfZHJtLmgNCj4gPiBAQCAtMTE5NSw2ICsxMTk1LDggQEAgc3RydWN0IGRybV9hbWRncHVf
Y3NfY2h1bmtfY3BfZ2Z4X3NoYWRvdyB7DQo+ID4gICNkZWZpbmUgQU1ER1BVX0lORk9fR1BVVk1f
RkFVTFQgICAgICAgICAgICAgICAgICAgICAgMHgyMw0KPiA+ICAvKiBxdWVyeSBGVyBvYmplY3Qg
c2l6ZSBhbmQgYWxpZ25tZW50ICovDQo+ID4gICNkZWZpbmUgQU1ER1BVX0lORk9fVVFfRldfQVJF
QVMgICAgICAgICAgICAgICAgICAgICAgMHgyNA0KPiA+ICsvKiBxdWVyeSBpZiB1c2VyIHF1ZXVl
cyBhcmUgc3VwcG9ydGVkICovDQo+ID4gKyNkZWZpbmUgQU1ER1BVX0lORk9fVVFfU1VQUE9SVEVE
ICAgICAgICAgICAgIDB4MjUNCj4gPg0KPiA+ICAjZGVmaW5lIEFNREdQVV9JTkZPX01NUl9TRV9J
TkRFWF9TSElGVCAgICAgICAwDQo+ID4gICNkZWZpbmUgQU1ER1BVX0lORk9fTU1SX1NFX0lOREVY
X01BU0sgICAgICAgIDB4ZmYNCj4gPiBAQCAtMTU3Miw2ICsxNTc0LDEyIEBAIHN0cnVjdCBkcm1f
YW1kZ3B1X2luZm9fdXFfbWV0YWRhdGEgew0KPiA+ICAgICAgIH07DQo+ID4gIH07DQo+ID4NCj4g
PiArc3RydWN0IGRybV9hbWRncHVfaW5mb191cV9zdXBwb3J0ZWQgew0KPiA+ICsgICAgIC8qKiBy
ZXR1cm5zIGEgbWFzayBmb3IgZWFjaCBJUCB0eXBlICgxIDw8IEFNREdQVV9IV19JUF8qKSAqLw0K
PiA+ICsgICAgIF9fdTMyICAgc3VwcG9ydGVkOw0KPiA+ICsgICAgIF9fdTMyICAgcGFkOw0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiAgLyoNCj4gPiAgICogU3VwcG9ydGVkIEdQVSBmYW1pbGllcw0KPiA+
ICAgKi8NCj4gPiAtLQ0KPiA+IDIuNDguMQ0KPg0K
