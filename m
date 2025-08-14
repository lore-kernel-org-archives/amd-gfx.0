Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21741CA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 19:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F85210E0C0;
	Thu, 14 Aug 2025 19:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jfofUUZ2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D856A10E0C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 19:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWTYcCTeKVsb90/yHm+uNFEEjOmBx6BtWK7vwAFvf7fWfaQaX5Glytmo5kZ9urm487eH7DzUYxjPye9R8XVVNF15mn5jbzE9raKR4xGkeTolOhsg7NHWQuiJjZuNrW6hXrUr0YzLHPsK5BUV7bOXqMZopA8GzdgvH5Xwt7Rmh5WBDrOEWGlbpfcUmJ0wncY3/BdokYUoSI8sV0EoLZs5F1Sns8CsvGoXtoZR/RiRCTmAWYvl00ZqKD8KitTYy3RAWKikAu2oj9WnHi5ccTjpGMQHeiGwv+W5egO7PlE9qzjWHu22cPAlUrkOJMfBOjXChb2w2siiEgnknrv+N7afUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WtU4jk38ec8M9XM/pUqQlw156w8DmtbpZF2V1N7xHo=;
 b=aZJrGtAshBeDSg7HiZTilpAJl5fu/v+6LqUmD4rYwXaNOO/ilx++bOuGA3dkMAa6ZR3K1teXU5rqp7gxUAmMOPc/g/G0/NUUca9zhkJugScFG9F9L/j7UmleiiB6lBig0uoGUHGCFyyceAY0EoDagMPXcUn38aAsih/jAa7oyuUQHs3foMwqlkc8lBQFhfEjOC7otCRl6ZodwgPCfRJjK1x99aVS21slmdv5uBzJtH46bwo3WJBTYQSDP02/XlO5k/sqjCYuR5GFEPd7Up12ZyIiVi+JTWQi+sywavAnMUYIy1NujD+4tswgux3tkMKs442hetxCCiMJeDzqhfO1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WtU4jk38ec8M9XM/pUqQlw156w8DmtbpZF2V1N7xHo=;
 b=jfofUUZ2WwOKgo2XNDTcqcqa4Gk+DR34y2t+rfps9cpjAyXy+H4QT1Wx8uMG2tYSN7EsV2UmZOlJJj4iDMldlo0d6rkFld6Zua+r4gyJ+wTp2XkqVQvasmFr1SrW2T+FnH6fcTvjyVoeFMuh5F/ZuHSMtMllIhm+DD9w4PXOr8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 19:18:41 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 19:18:41 +0000
Content-Type: multipart/alternative;
 boundary="------------KvZbyhOMcX0f6PeS4yJV1KrM"
Message-ID: <31283d92-805f-49a2-a0b2-20146b79354b@amd.com>
Date: Thu, 14 Aug 2025 15:18:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <85af1027-5a09-40ce-987e-9f4ad8fe2b5c@amd.com>
 <CADnq5_O2gnR8GtAaL-937R97Kwtb50QNh+Y3V_TzsLGLbT8CLQ@mail.gmail.com>
 <ad01beb5-e17c-4ace-8707-4cd5f52de2c8@amd.com>
 <CADnq5_Of2gkZoyE9V-3ySEMvc20sVG9S8rz8x5uRLCX=OEnnvw@mail.gmail.com>
 <7a8991f7-1eb7-4307-ac72-1281a50bf4d5@amd.com>
 <CADnq5_NutFtDzq3xwcfLr6dHtWaEKDwV5-kXrDpNBCM2DjWb-Q@mail.gmail.com>
 <04e0a9f2-d8ea-4383-8fb6-b7422d6f9ff6@amd.com>
 <CADnq5_M5GGUMmpnVD39i_6K0NJKsXVrbqbRiWjby-NRcZeY7yw@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_M5GGUMmpnVD39i_6K0NJKsXVrbqbRiWjby-NRcZeY7yw@mail.gmail.com>
X-ClientProxiedBy: YQBP288CA0047.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::20) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bcc168-1bc2-424e-9ae3-08dddb676116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWZiclZxVFU3Y0ZESzZ6dXN1WnFjOUttL0dUZjdlUVdTdWM3blR0SmMvQzl2?=
 =?utf-8?B?YkNZS3dkY2VSYmpCS1VBSCtOaVZOSEppbFl4SzR1U2IvdC9PMms1NnFHcGlM?=
 =?utf-8?B?dG1HYkVGdEVRV3l2TE9KS2lYLzV2VEVnc2JoaXpiRFFaeGp6MzZxZ2VJaTJI?=
 =?utf-8?B?Q0lPZ29zbkdscWM4L2ludWJKS1YyTWdLMU9yMi8rclpmc1k2UXR3a1JISXpX?=
 =?utf-8?B?T281aWRBTjhnY1JtelhWcDdKKzVkUVhlaS9qc1JhQnZCN2ZjVG5qck9hM0E1?=
 =?utf-8?B?SnQ2QXh2WTRYb3p5QkFLdmFMWUhXcEEwVFROaTIvalpLbDQvVnhJeEVsSExH?=
 =?utf-8?B?ZmpMa1pRUjFOSTdrNHNhVitwdUdGc3ExQk5CbDZ0THpjbjBlK043d2txWjU3?=
 =?utf-8?B?TWRoK3czR0Mybm9jYjNPVEVjZDdOWDkxb0p2R0pmQStMOVQ5SmlyR2ZIcXdT?=
 =?utf-8?B?YmtJdi9SQjN1a3pOQlZrMEpNclJXZmtVaHFpS1EwSFdNTXU3eVhOU3RXYU9i?=
 =?utf-8?B?M1lXTjhRL3dYeXNOVHFDQnhiUzN0ZjRLYUdieWRQanFzUXpvTmpHZlFzWHpL?=
 =?utf-8?B?YXRWWFc3aFptUlBKWEpuaWd4UWp0elJDSEYrMmFJaGwrN0tJMndUS0prZWtQ?=
 =?utf-8?B?TjFlN29HSFlJTUlnOVRHb2pKVmRuYTc2YkdobDFSZTgwOGZ4TzIzM29aRkxs?=
 =?utf-8?B?eS9LbnUwRnBoVDdyWXNYYU1xTGpSNDA3dTFDOUFjL0NvSjRYMjZmeXR4NkxL?=
 =?utf-8?B?S3pYMTZLYnZkUnIzSUN3TGhVN1JlVTZ4SFBMbHZ3NiszRWcwYVpkTzBOQi9w?=
 =?utf-8?B?SUV5eGM3eVcvdlptd3hYVjV3dE5lQUZqWk5WVGVkUlBwMkc1dGhsaEY4ZHlN?=
 =?utf-8?B?VzNleWFvUVVXazJnK0w1VnYwUlNjRHQzNXdZOFpzRzRUYTArZjdXMEpqeW0w?=
 =?utf-8?B?U3BaMXd3NjUzbFpoblNFQVljNzh6MkVUZEtWbjhMUnRrYTYwQ2Z6UVRKZ3RZ?=
 =?utf-8?B?SmJKTkM3UzJRMzd0WkpiMnhBcktGNitsK21NeFpBR3NyYThPblB1ZytUQUpW?=
 =?utf-8?B?UElTeVJycEVEV3F0YXhLd0U1S2FyWWJ2ZzZlbUVTTU5aV2tlTUVHQlRvT1pl?=
 =?utf-8?B?ZmQ3Y01SZGpjd3FWQ2p0YktkWjl3WTBINE4rdmJacklFenBFdTVydjdicEYy?=
 =?utf-8?B?QXplV0xzMWJWYTUrSlJBTFBPdHh4cXJTNGlDaUJ5QzZqRzhGT2lQS2YvblJ0?=
 =?utf-8?B?WVZyekozK1ljc2VCZ3FVR1hGUTFiS3lWS0RQV0plWnBMUGpaWGpTVUtuZHYx?=
 =?utf-8?B?TytkVVpFZjI5cVphMHZWM2xPY29xaEs2Nk13WDhvZm9RNVdCRW9CVlgvWkRK?=
 =?utf-8?B?L2NDb3g4dmFIOHZQOGMwNG1nTng3VG9NWUhrL01PSXpzOVBabXZRSHR6bTVW?=
 =?utf-8?B?K0pvTFRoZUp4U0lTODBqUHA4NkVWbC9rOTJIa3NkMkk3aHF6NDFsTE9MQm5J?=
 =?utf-8?B?NDlzRTUxOHFmZlMwb2h1VVlpN21jN1ZzdnlWMTdUYTJGUFR4UnFwNmZEY3lE?=
 =?utf-8?B?Q0lpdHFabnR2Q0RkWGVCS1hETWpGOTNEM1BPOGJ5VlpvTnUvcFZoZnRmTWpu?=
 =?utf-8?B?Z0ZMYS9WeS9KTzJVWEtCK2thVktTaFU5eDNtUENwVHpnOG05S3MzY3p0aTd0?=
 =?utf-8?B?d0o3dFF6eldOUm52dEM3dmJjM2tVempNYXNHU1pvWDY2M2RmNnBBa0FkNTlh?=
 =?utf-8?B?NmFHN1lBVjZ1NzhhMzFHeGZOS1dwNldDUjB6aFZDWEN5cWlIaVBMT1h2Ymx1?=
 =?utf-8?B?N09zTW9RLzRjZkJNSVpyQXNoNW9yeUlPQ05ra2NKRmJ2akhkUFFZMXFDbzJ6?=
 =?utf-8?B?bC9iSmtGY1RFMnY3U2c0enZ4bGdLNHVxR2p5R0k1ZC9zMXZtQkdtYnJIQngv?=
 =?utf-8?Q?lxm6EzUYQkM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2pMRWJCZFJYbFdLQ2JQbnhJeGJKSWEzeXBCRUY0VGhxakpabHc5MVlwY2di?=
 =?utf-8?B?TkplYSszUG1CS050cUFtb3UxcmgyNkg2ZTZWSE1ubDhPMzhIa3UzNFZOODZk?=
 =?utf-8?B?azN2c3UzdU91WVlsOWhPaUNzTWpzZTJncC9rR1VhY3JZS2tETGFSYXJ1Ylp5?=
 =?utf-8?B?NEhGc3RBQk11UGhHVTZmem4yVWZJVXZzVmQ2aE1rT01HamRibHJJRm1lM3J4?=
 =?utf-8?B?QmZsOVhSWEVSWFpuRDBiOTZicHdtNzVCN0VSWkF0V3pkNnZ3aitaS1Z4Zm0z?=
 =?utf-8?B?YUVZYVQxMjdVdWFPZDliSTVONHdQQksrdUUzZ2U3c3Y3d1liczlBYlc3d2xy?=
 =?utf-8?B?cit2ZzI2bWxFaWRKSU1tZS93a01WbENNV3NsMnU4VDFDVnJqTHBUM2dzWFhX?=
 =?utf-8?B?UjRnNkZoa3oxRjUzYkEwbTJSZFJVK1VKMGlPUEsyTzhqY0cwcXlOMlZSakdJ?=
 =?utf-8?B?YVQ5YzJ3QXd0Y0RHeWhuS244SzQvVWJZZGtnMnREODVrV3pETDBabVJXR0tH?=
 =?utf-8?B?cWlEN0NMWEhWTGFlVThpRS9sYnVyS2d5U3I4WDRvamhPWnBPWk01emh1cHdt?=
 =?utf-8?B?ZmRKS1FFenlzMlVsTnBkVGdQVFVGYXZwR3FHTjNhSnlWQ1lja29lcXZzRWdJ?=
 =?utf-8?B?SWFiM255ZmtoR3RBcjhkNHMxcWliU3VNUmpoV1JCQXZWNE9Yc1grRHNkZXp5?=
 =?utf-8?B?MTEvR211Y0ozdWJ4ZTA3MTlIZG04YkF4SWV1TWtiU3RVU0F0dGVyNzB6dGFC?=
 =?utf-8?B?Y0QzdEVqRlRlakNwdE95RXEvQVM3aHk3ay9BemJqbXY4TXluV1NHQ2I5bUNz?=
 =?utf-8?B?eXh1dWNRbHZGZzczQkkvRjZTR1dtdVdkU1h3UEUvdXpHbGxpU2J1Yks1NFAw?=
 =?utf-8?B?ck9GMC8rcTFydWZmZ2dOMGhMUmV5OVBiN1NGZTVLYVpNbGxmeXlKMHBzM25r?=
 =?utf-8?B?bmc1U1o4ejhsQ25tcTFBNVFKejBlK0ZLaC9STE41YUJpamRyak1IdThCWGF3?=
 =?utf-8?B?K3Ridkt1cDF6WGdOTEhxL1dTdkRmUmhpZ2tURmRQQTcrTTVSMlFlZGhTRzlZ?=
 =?utf-8?B?cHBzMXZqaWZ6NEJMYldSczlaODJBWVNtRXZlcVgzckhCTDNIenRjYkdOREd5?=
 =?utf-8?B?SWV5c0ZyekRvWWFJL05vb0MwSGxlTi9Mb2VRbVhZbkxGNGlDUzZSSnZGK3JP?=
 =?utf-8?B?Y3BNRHUyN21ObzdGZlVlbDlZYlB1T29GMlBMS2pNbGVoeGtwQWFBTVhmd1V1?=
 =?utf-8?B?MktsUmprZFpDN1NjalBRZGtFMVBvWlFISlgybGtDYlNhQk0yWkZkOWtHZzhx?=
 =?utf-8?B?cEV3b2tiTWsyMGpiaEZ6QlNQRlVmZ1FsK2ZCN2hxalMyZEF5VGRiTmVacG5y?=
 =?utf-8?B?WmJOZEE5ak4xR0NFUFlXdW1HUWxyQlRtRFU5YTJPS016OU13anFxWGhHeXRY?=
 =?utf-8?B?aU5tdEk1VUhMM0ZUWHpuQk85Ni9uOUxYbmhLVU1rajQxdnNiUGd5bzk2VjVU?=
 =?utf-8?B?WGNOeTYrWFM3QjM4cXZvdk5RNzhGb2s5MHBhTjlDbE45U0lhb2VnMjVaTjRi?=
 =?utf-8?B?VEpvTTdTZUNWcGdCdnZoZmh4emQ5NW10d09xd2xKUmpBUC8yMFo5b2I2YUdK?=
 =?utf-8?B?a0hXMmZyTjZ0enNETnptZlljVC9GVFg1bUdPOUQyQXkvWWQzWTI2bTJueWlV?=
 =?utf-8?B?QVZTdlZQc1dQdUU2NkdFWWFGSzdhQnNyWmhIbG5lTUoyNVJTZVhCTU84YjVt?=
 =?utf-8?B?d0JBSGVIUCtCSU9QMGpuQUZkMWU4YlA0eGZnNUhJT3o5NFh4ajJMWERVQVIz?=
 =?utf-8?B?VHdYTUlRb0JvaDlBUjJWUmFqV1NKUU1iQVNQNWNmSUY3OERlejdJem0vZkhi?=
 =?utf-8?B?S1QzYWpKRTRiOTZsNzVBR251MXlhdTA1Z2FMbEhYZnZiSTBGMm1sUGM1V3k1?=
 =?utf-8?B?V2Frc095U3dzWXpwVEhuTGVuYUJzS0d0aTRpNHFhbGlPV0wrK1QyS0pqUU1E?=
 =?utf-8?B?TDZzaVdsUFdmSFlVSDBQQTVCTTNKcS9oaEtkVXpjemwzaU5NUFEzNWwwUGdy?=
 =?utf-8?B?NU9EVW9FWUM0OExhVkVud0lMdGRINGpWWHhIWXZpeEVOaE5BSDFjbDNQOGJo?=
 =?utf-8?Q?Mrpd16FQW+BGlR6wZzIT2LCep?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bcc168-1bc2-424e-9ae3-08dddb676116
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 19:18:41.5562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7eR/G58BqT/tD1iZGnJNTjdI4NvkJpNe8ROzIbML7u7+F9G/7sOCtJ0Z1+Dnh3RLvQwdpPeL9mfpZsXQGSLfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

--------------KvZbyhOMcX0f6PeS4yJV1KrM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-08-14 14:00, Alex Deucher wrote:
> On Thu, Aug 14, 2025 at 12:44 PM David Wu<davidwu2@amd.com> wrote:
>>
>> On 2025-08-14 12:01, Alex Deucher wrote:
>>> On Thu, Aug 14, 2025 at 11:35 AM David Wu<davidwu2@amd.com> wrote:
>>>> On 2025-08-14 08:56, Alex Deucher wrote:
>>>>> On Wed, Aug 13, 2025 at 7:06 PM Wu, David<davidwu2@amd.com> wrote:
>>>>>> On 8/13/2025 6:11 PM, Alex Deucher wrote:
>>>>>>> On Wed, Aug 13, 2025 at 5:47 PM Wu, David<davidwu2@amd.com> wrote:
>>>>>>>> On 8/13/2025 5:03 PM, Alex Deucher wrote:
>>>>>>>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>>>>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>>>>>> Hi Alex, Hi David,
>>>>>>>>>>>>
>>>>>>>>>>>> I see David's concern but his suggestion yet wont solve the problem,
>>>>>>>>>>>> neither the current form , reason :-
>>>>>>>>>>>>
>>>>>>>>>>>> The emitted fence count and total submission count are fast transients
>>>>>>>>>>>> which frequently become 0 in between video decodes (between jobs) even
>>>>>>>>>>>> with the atomics and locks there can be a switch of video power profile,
>>>>>>>>>>>> in the current form of patch that window is minimized, but still can
>>>>>>>>>>>> happen if stress tested. But power state of any instance becoming zero
>>>>>>>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>>>>>>>> Consider this situation, inst0 and inst1 actively decoding, inst0 decode
>>>>>>>>>> completes, delayed idle work starts.
>>>>>>>>>> inst0 idle handler can read 0 total fences and 0 total submission count,
>>>>>>>>>> even if inst1 is actively decoding,
>>>>>>>>>> that's between the jobs,
>>>>>>>>>>        - as begin_use increaments vcn.total_submission_cnt and end_use
>>>>>>>>>> decreaments vcn.total_submission_cnt that can be 0.
>>>>>>>>>>        - if outstanding fences are cleared and no new emitted fence, between
>>>>>>>>>> jobs , can be 0.
>>>>>>>>>>        - both of the above conditions do not mean video decode is complete on
>>>>>>>>>> inst1, it is actively decoding.
>>>>>>>>> How can there be active decoding without an outstanding fence?  In
>>>>>>>>> that case, total_fences (fences from both instances) would be non-0.
>>>>>>>> I think it should be non-0.
>>>>>>>> I do see a hiccup possible - i.e the power switching from ON to OFF then
>>>>>>>> ON in the
>>>>>>>> middle of decoding, i.e inst0 idle handler turns it off then inst1 turns
>>>>>>>> it on.
>>>>>>> How would that happen? As long as there submission cnt is non-0 and
>>>>>>> there are outstanding fences on any instance, the video profile will
>>>>>>> stay active.
>>>>>> there could be no jobs but it doesn't timeout yet and new jobs will come in
>>>>>> any ms - note all fences are done at this time. The idle handler sees no
>>>>>> fences
>>>>>> and no jobs so it turns off the power - but just ms later a new job is
>>>>>> submitted
>>>>>> from the same decode session which could be mpv player as it does not
>>>>>> need to
>>>>>> submit jobs without delays. This will turn on the power.
>>>>> I'm not following.  Every submission will start with begin_use().
>>>> yes - it does - it can power on vcn but this happens in the middle of a
>>>> decode session which has 10s timeout to call its own idle handler - in fact
>>>> the other instance's idle handler will power off vcn because it does not
>>>> know it needs
>>>> to wait until the decoding session times out.
>>> I don't follow.  If there are no outstanding fences, there is no
>>> reason to not power down the VCN instance and disable the video
>>> profile. If there are still outstanding fences, then the VCN instance
>>> those fences are associated with will stay on and the video profile
>>> will stay enabled.  If the engine hangs and eventually gets reset, the
>>> fence will be signalled and then there will be no outstanding fences
>>> so the idle handler will eventually disable the power profile.  The
>>> idle handler will keep getting rescheduled as long as there is still
>>> oustanding work.
>> inst0 and inst1:
>> inst0 sends jobA, then ends jobA and no more job submitted in 500ms and
>> job queue is empty - at this point  inst1's idle handler sees no
>> outstanding fences/jobs
>> then power off.  However inst0 starts to submit job after 500ms - inst0'
>> idle handler
>> has not started/scheduled to run but inst1's has finished already which
>> does not know inst0 has not timed out or called its own idle handler.
>> This violates the
>> logic for idle handler's timeout condition. (i.e 10s timeout designed
>> but timed out in 500ms)
>> all this means it powered down too early for inst0.
> I still don't follow.  Here's a sample flow.  Job comes in on inst 0
> and then slightly later on inst 1.
>
> Inst 0 job submission
> Inst 0 calls begin_use().  This cancels the current inst worker
> thread.  It enables the video profile and ungates the instance.
> IBs and fence packets get submitted to instance 0 of the engine
> Inst 0 calls end_use().  This schedules the worker thread for
> VCN_IDLE_TIMEOUT jiffies in the future.
>
> Inst 1 job submission:
> Inst 1 calls begin_use().  This cancels the current inst worker
> thread.  It sees the video profile is enabled and ungates the
> instance.
> IBs and fence packets get submitted to instance 1 of the engine
> Inst 1 calls end_use().  This schedules the worker thread for
> VCN_IDLE_TIMEOUT jiffies in the future.
>
> inst 0 work hander runs.  Sees outstanding fences on inst 0; skips
> powergating inst 0, skips disabling video profile. Schedules the
> worker thread for VCN_IDLE_TIMEOUT jiffies in the future.
>
> inst 0 IB completes and fence signals
>
> inst 1 IB completes and fence signals
>
> inst 1 work hander runs.  Sees no outstanding fences on inst 1.
> powergates inst 1.  Check if there are any outstanding fences on other
> instances.  Sees the no fences from inst 0 so disables the video
> profile.
now there are jobs coming from inst0, so inst 0 idle handler won't run.
> inst 0 work hander runs.  Sees no outstanding fences on inst 0.
> powergates inst 0.  Check if there are any outstanding fences on other
> instances.  Sees the no fences from inst 1, sees that video profile is
> already disabled.
inst 0 work handler runs? could or could not - right? depends on if 
there are more jobs for inst0 and also
if VCN_IDLE_TIMEOUT jiffies has passed for inst0. There is possibly a 
point in the sequence that inst0
stops submit jobs but its idle handler has not run yet. Should we wait 
until all instances have finished their idle handlers?
if not then we will run into a power OFF(by inst1) -> ON(by inst0) for 
the active instance(inst0, expected ON). (active - I mean
those have not timed out in VCN_IDLE_TIMEOUT jiffies and still can 
submit jobs in any time.)
if this could happen then we powered off too early. (I did not say we 
cannot do it but it is not expected)
> You can insert additional job submissions anywhere you want in the timeline.
>
> Alex
>
>>>
--------------KvZbyhOMcX0f6PeS4yJV1KrM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-08-14 14:00, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_M5GGUMmpnVD39i_6K0NJKsXVrbqbRiWjby-NRcZeY7yw@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Thu, Aug 14, 2025 at 12:44 PM David Wu <a class="moz-txt-link-rfc2396E" href="mailto:davidwu2@amd.com">&lt;davidwu2@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

On 2025-08-14 12:01, Alex Deucher wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Thu, Aug 14, 2025 at 11:35 AM David Wu <a class="moz-txt-link-rfc2396E" href="mailto:davidwu2@amd.com">&lt;davidwu2@amd.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On 2025-08-14 08:56, Alex Deucher wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">On Wed, Aug 13, 2025 at 7:06 PM Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:davidwu2@amd.com">&lt;davidwu2@amd.com&gt;</a> wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="" class="moz-quote-pre">On 8/13/2025 6:11 PM, Alex Deucher wrote:
</pre>
                <blockquote type="cite">
                  <pre wrap="" class="moz-quote-pre">On Wed, Aug 13, 2025 at 5:47 PM Wu, David <a class="moz-txt-link-rfc2396E" href="mailto:davidwu2@amd.com">&lt;davidwu2@amd.com&gt;</a> wrote:
</pre>
                  <blockquote type="cite">
                    <pre wrap="" class="moz-quote-pre">On 8/13/2025 5:03 PM, Alex Deucher wrote:
</pre>
                    <blockquote type="cite">
                      <pre wrap="" class="moz-quote-pre">On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
<a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com">&lt;sathishkumar.sundararaju@amd.com&gt;</a> wrote:
</pre>
                      <blockquote type="cite">
                        <pre wrap="" class="moz-quote-pre">On 8/14/2025 1:35 AM, Alex Deucher wrote:
</pre>
                        <blockquote type="cite">
                          <pre wrap="" class="moz-quote-pre">On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
<a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com">&lt;sathishkumar.sundararaju@amd.com&gt;</a> wrote:
</pre>
                          <blockquote type="cite">
                            <pre wrap="" class="moz-quote-pre">Hi Alex, Hi David,

I see David's concern but his suggestion yet wont solve the problem,
neither the current form , reason :-

The emitted fence count and total submission count are fast transients
which frequently become 0 in between video decodes (between jobs) even
with the atomics and locks there can be a switch of video power profile,
in the current form of patch that window is minimized, but still can
happen if stress tested. But power state of any instance becoming zero
</pre>
                          </blockquote>
                          <pre wrap="" class="moz-quote-pre">Can you explain how this can happen?  I'm not seeing it.
</pre>
                        </blockquote>
                        <pre wrap="" class="moz-quote-pre">Consider this situation, inst0 and inst1 actively decoding, inst0 decode
completes, delayed idle work starts.
inst0 idle handler can read 0 total fences and 0 total submission count,
even if inst1 is actively decoding,
that's between the jobs,
      - as begin_use increaments vcn.total_submission_cnt and end_use
decreaments vcn.total_submission_cnt that can be 0.
      - if outstanding fences are cleared and no new emitted fence, between
jobs , can be 0.
      - both of the above conditions do not mean video decode is complete on
inst1, it is actively decoding.
</pre>
                      </blockquote>
                      <pre wrap="" class="moz-quote-pre">How can there be active decoding without an outstanding fence?  In
that case, total_fences (fences from both instances) would be non-0.
</pre>
                    </blockquote>
                    <pre wrap="" class="moz-quote-pre">I think it should be non-0.
I do see a hiccup possible - i.e the power switching from ON to OFF then
ON in the
middle of decoding, i.e inst0 idle handler turns it off then inst1 turns
it on.
</pre>
                  </blockquote>
                  <pre wrap="" class="moz-quote-pre">How would that happen? As long as there submission cnt is non-0 and
there are outstanding fences on any instance, the video profile will
stay active.
</pre>
                </blockquote>
                <pre wrap="" class="moz-quote-pre">there could be no jobs but it doesn't timeout yet and new jobs will come in
any ms - note all fences are done at this time. The idle handler sees no
fences
and no jobs so it turns off the power - but just ms later a new job is
submitted
from the same decode session which could be mpv player as it does not
need to
submit jobs without delays. This will turn on the power.
</pre>
              </blockquote>
              <pre wrap="" class="moz-quote-pre">I'm not following.  Every submission will start with begin_use().
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">yes - it does - it can power on vcn but this happens in the middle of a
decode session which has 10s timeout to call its own idle handler - in fact
the other instance's idle handler will power off vcn because it does not
know it needs
to wait until the decoding session times out.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">I don't follow.  If there are no outstanding fences, there is no
reason to not power down the VCN instance and disable the video
profile. If there are still outstanding fences, then the VCN instance
those fences are associated with will stay on and the video profile
will stay enabled.  If the engine hangs and eventually gets reset, the
fence will be signalled and then there will be no outstanding fences
so the idle handler will eventually disable the power profile.  The
idle handler will keep getting rescheduled as long as there is still
oustanding work.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">inst0 and inst1:
inst0 sends jobA, then ends jobA and no more job submitted in 500ms and
job queue is empty - at this point  inst1's idle handler sees no
outstanding fences/jobs
then power off.  However inst0 starts to submit job after 500ms - inst0'
idle handler
has not started/scheduled to run but inst1's has finished already which
does not know inst0 has not timed out or called its own idle handler.
This violates the
logic for idle handler's timeout condition. (i.e 10s timeout designed
but timed out in 500ms)
all this means it powered down too early for inst0.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I still don't follow.  Here's a sample flow.  Job comes in on inst 0
and then slightly later on inst 1.

Inst 0 job submission
Inst 0 calls begin_use().  This cancels the current inst worker
thread.  It enables the video profile and ungates the instance.
IBs and fence packets get submitted to instance 0 of the engine
Inst 0 calls end_use().  This schedules the worker thread for
VCN_IDLE_TIMEOUT jiffies in the future.

Inst 1 job submission:
Inst 1 calls begin_use().  This cancels the current inst worker
thread.  It sees the video profile is enabled and ungates the
instance.
IBs and fence packets get submitted to instance 1 of the engine
Inst 1 calls end_use().  This schedules the worker thread for
VCN_IDLE_TIMEOUT jiffies in the future.

inst 0 work hander runs.  Sees outstanding fences on inst 0; skips
powergating inst 0, skips disabling video profile. Schedules the
worker thread for VCN_IDLE_TIMEOUT jiffies in the future.

inst 0 IB completes and fence signals

inst 1 IB completes and fence signals

inst 1 work hander runs.  Sees no outstanding fences on inst 1.
powergates inst 1.  Check if there are any outstanding fences on other
instances.  Sees the no fences from inst 0 so disables the video
profile.
</pre>
    </blockquote>
    now there are jobs coming from inst0, so inst 0 idle handler won't
    run.
    <blockquote type="cite" cite="mid:CADnq5_M5GGUMmpnVD39i_6K0NJKsXVrbqbRiWjby-NRcZeY7yw@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">inst 0 work hander runs.  Sees no outstanding fences on inst 0.
powergates inst 0.  Check if there are any outstanding fences on other
instances.  Sees the no fences from inst 1, sees that video profile is
already disabled.</pre>
    </blockquote>
    inst 0 work handler runs? could or could not - right? depends on if
    there are more jobs for inst0 and also<br>
    if&nbsp; <span style="white-space: pre-wrap">VCN_IDLE_TIMEOUT jiffies has passed for inst0. T</span>here
    is possibly a point in the sequence that inst0<br>
    stops submit jobs but its idle handler has not run yet. Should we
    wait until all instances have finished their idle handlers?<br>
    if not then we will run into a power OFF(by inst1) -&gt; ON(by
    inst0) for the active instance(inst0, expected ON). (active - I mean
    <br>
    those have not timed out in <span style="white-space: pre-wrap">VCN_IDLE_TIMEOUT jiffies and still can submit jobs in any time.)</span><br>
    <span style="white-space: pre-wrap">if this could happen then we powered off too early. (I did not say we cannot do it but it is not expected)
</span>
    <blockquote type="cite" cite="mid:CADnq5_M5GGUMmpnVD39i_6K0NJKsXVrbqbRiWjby-NRcZeY7yw@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">You can insert additional job submissions anywhere you want in the timeline.

Alex

</pre>
      <blockquote type="cite">
        <blockquote type="cite"><br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------KvZbyhOMcX0f6PeS4yJV1KrM--
