Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21A4E6BF1E
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 15:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563F410E50C;
	Fri, 30 Jan 2026 15:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3KAc8Zhi";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C198E10EA0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 15:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDfk9QxcXpR88K0D90ulkXnz2nYo3E7qSlv+Fojmqw8lRRzwUA7UkTJv0/6irpdSzaKdzTaSYi1PbV3CKZrOFM32vE2vOYlJEsGfyEfOBTz8I3Ea0pmnxcCN0w7dzYBWd8ksVw2IjQK7b/XthDR0RjrQbFFE8+RKNOdYdEAx5JGAfptQxhbUP7vQLsEdcA9w76qso5HQXtjWqstDy+Fjla9J+R1b7ABovhjhdiB7XD64mvFq/zAG3H7XLxWcqYu7+qPgRFzOap8JVsS0N1PwOddqFe+U91Cx7T3FqvpiseCoi/1BRxfFTmrZxtmt7baYD9dzm5jiTULVz4IrN7z5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6h4UjPzV1Xe69GtprHbMHV5a5OtIhUSiZJDci6Inn4=;
 b=xfE7Xk/1YHkfXB3rI87J+f82b+Tokjyg6BgmIiBGMA/YaMS+N5pTQNZua0uN8IZlzTNHBogFRiWrqe4K2aO0nZiFfNl+wa45ZTZuSsjfgwpOLn4wW2/uTu31vJig+0pkYK1dHzZKBedI7M/xPDhuvsLy6PrkCIPpVCwrSz7bsJMjevDrTm8gtSXUS5s9zR1GC9HnH+p4FTJSrWWL1Nzh6iBQj7fppe6FwEfCsb2QybsviGvl6MdhV0qeNS6/PcEE+gRkFu52mIRSdB+eKInkv0mQT8xT14aue9JMUK4+TlVW+N6UWky6tOVoQnI4GQszP+YfRq9xxRnp4R/4hxEwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6h4UjPzV1Xe69GtprHbMHV5a5OtIhUSiZJDci6Inn4=;
 b=3KAc8ZhiIgmKf6hezk0eC7pqzV6ZEjZxGsztesjWI2R+l9Og2p205LCKmj80mEvyA88IdOG5zCjMTa/eshtOsYsSuBPw7rCpgeyagNI+Sus3IJRNsivdkiYFTgzk9PTjuLSf2R15mOgLvp2d4d4OWDRHEtQY8CTyv1KePSvoqHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 15:52:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 15:52:39 +0000
Message-ID: <a6c1ddbc-263c-4639-ac92-ec41e8e98019@amd.com>
Date: Fri, 30 Jan 2026 09:52:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Set minimum version for set_hw_resource_1 on
 gfx11 to 0x52
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "danijel@nausys.com" <danijel@nausys.com>
References: <20260129194722.2331593-1-mario.limonciello@amd.com>
 <CADnq5_MKvLhziwueZQ2HU7RUD8tr5NZH_a4TmDnYQMr+_UcCgg@mail.gmail.com>
 <CH0PR12MB5372A7C30E269B3DE6EB4D20F49FA@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CH0PR12MB5372A7C30E269B3DE6EB4D20F49FA@CH0PR12MB5372.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: bda31a94-f744-4d0d-7cd5-08de601798a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0RVTmF4WFQ4Y3FHanAxR1ZGUjY3eVFOdTVFd09yWk83NVZpdTJKQ2FIT3F0?=
 =?utf-8?B?SW8xazV2Z2p0VVNCNTZxSE4va3lMaW10WWhzNS84Q1FkYjVnNmEreW1GWmFP?=
 =?utf-8?B?eHhEMkxkTUc4M0VPWFUvUFR0dDAyakNOVHZaTDFDd0ZySGFsS0FhNWkzR0or?=
 =?utf-8?B?QUlMdG1XVTk5YjV5azBvNk0xYWRNNE0xWityYStJZU9WTTVOSFZjZGVwRlhK?=
 =?utf-8?B?QjhmeWpZVmthUjNxWVl5dmNPcnlKSTBNYlFMTGJrT1Z4RWRRcVZQNmd3eXJP?=
 =?utf-8?B?NGZGc1h3MjFtdTBBZ3ZXNldabFlSSXExeTNKdjF3ZGlnWEdhSVBzVHZoQitj?=
 =?utf-8?B?Vmt4R3VpbkhLNytjS3pndWN3NVdsd05ZWlNoeXpFTXFLL2I0T0s5MlFjaVpF?=
 =?utf-8?B?NG5jeVRnSFc2alViR3hPZkh1N1hMemNkRTFhd0d1QkRMUklUQ3YxcHRaODBS?=
 =?utf-8?B?cnRRZURuUUJEK21HL3h6WXhKYjVuY3BYWHR0bk5hMGFYZ2h5TmxnQXB6M1pu?=
 =?utf-8?B?cUpPSXMweURLaWplRHJ3N0o0R20zT3QyTkY3TklrVkp2aHdqNUxLb2pTV2NU?=
 =?utf-8?B?OGR3STlqR2EydzJ0QXFmQUJjQnhWTHd4blNQeDlUS1VqcThUYk9mTUQ4ZkVp?=
 =?utf-8?B?d3Zub2xobVBXNllNeFFQbk0wTDJZL3dobmplVDN6S3ByTzNIT3hnei9KRWtV?=
 =?utf-8?B?WlBXd2JVYnlpNGJsWTJxUjdVWnBhcnpjclg0OFc2cDVsbmtsN1ArVzZoZlhj?=
 =?utf-8?B?bmFBTmw1bUdqZThvZUhFTFpPS010TjkyRUxkc2VZNCsrYlZzWms5cHNmeGNF?=
 =?utf-8?B?dGxEMXVMWFMvcjdObURKbjIvR0VSU2YyRm1CYmNBSzZQQi9WRmlldlBRN3cw?=
 =?utf-8?B?dk4yOWxVVlp3NXB0Z1QyT2FUaXNQdDNhV2pwaDIyYzBRRDZkODRrTHJhVzIz?=
 =?utf-8?B?Um9mcU1xbmJvVU0xeUZqNEJTalVBNEpSbWZOYmkxYVYrSU1WUzhGcmYzMk4x?=
 =?utf-8?B?S2lCNGREcS9DSVI4YittWk1VMXBHK2QzTXFZd2htUFNQSU5TY0ZDY0NqU3Fs?=
 =?utf-8?B?RHpic3A3b05oYTJWd0hpcW05SXNpM3Q1RkgreUpoQWgzWi96WHlhbDVOZStI?=
 =?utf-8?B?aGNlSFZZRWN3SHkyY0ZOOElqNk4xWENESS9rdWdUMFRCN2NadDl6d1VXby8y?=
 =?utf-8?B?K0RUNlZzSk9aVTBGL0lxQzZkTk1uOVRZRUJwMEhQRXhlN0ZtRDhoMXFNWnJO?=
 =?utf-8?B?bmhCWGc1T1Z4dzE2Q3phV3JORi82NXovOXlQcFNUZ1lvT2N1cnQrT0RhZ1ZT?=
 =?utf-8?B?N29kRHpBUkcvTENPeHBNUG1sZ1c2Q09HZDcweEw1ZEthQVRiVjJFazVpb2JJ?=
 =?utf-8?B?SzZzZkJZd2FFSFdQSDR6TWcyeDA4TGtGZ0RXVmxSYnFocytmcjNIRDY5TWNL?=
 =?utf-8?B?SXhKb1d5Q29USUxNMnpNYlB3bjNwQUtFTkRtTFVZSjN5R1FhdXRRTkRYY3Rl?=
 =?utf-8?B?aWZvUkZqdFF3VHhKUjBkUy9lLytCQmZKQjNhV3lBVmovRHhQbDQwemNmU2c4?=
 =?utf-8?B?UlBjRTNERzU3R05iUG1VTHpjNEFkMTMxaTBPWmxRallkWHZVOEVCendNMFkx?=
 =?utf-8?B?WXhXTU1KMGR6TjJZUUJ6K0dpZXNxK3JqMUhoNjRQMFdVY2ovbU9LUC9TdHFJ?=
 =?utf-8?B?NmNuL0ljWXVRRGtOeko2YktoM2R6WGxJanRRR2toeG5sMnowbHByVnI1UXJT?=
 =?utf-8?B?cFpDc1hmUWJjdnVuOEMreU5iajB4a1ViQjkvR25DRFZlM2IySDk2VHp5bWUv?=
 =?utf-8?B?ZXhWQjdoaHpJVlRIU3lTZm4vY0ZSZWdLZE1NVXFnWVFvcUNkKy9WQVhHVURW?=
 =?utf-8?B?ZDhHckxUUURBd0dNTVFLQ1YzWkRtYXFwUWFyL1V0SHRBK2p1dzkvbWJVYnJs?=
 =?utf-8?B?WkNlMzlzZGdFQ3M0MlNPVkhqd0FCYWNlQmQxN3p3d3hQcHhCWFVScU5paDdh?=
 =?utf-8?B?NVRtVnc2Q0pzdWd1cGJOZzVzZy9tOVl2TFFFNnBPdzZhVVZIVy9jV0gwclZJ?=
 =?utf-8?Q?OFGl0J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXB0cVVJS3hLMEMxbWIrTEtrb2hISURkZFFSdWpkMGErZ0I3OXdtYVBTRklm?=
 =?utf-8?B?b2doMFR1R1ZWSkh4NGhFaWV3Q0w4MlljeHY1WkJjeWJORVFNcHZnWDZKZktp?=
 =?utf-8?B?ZFYyQTBxZlVacDdSeXJram44bVdzdy9rR2xZUHNmQ2luQ0xKU3hxMktYci9W?=
 =?utf-8?B?VWdNc1QyVWd1aldJU2JKNVlFVkU1bk9ROHMwRmpKTkREdXdZZVdaQ2JKQlZP?=
 =?utf-8?B?RURNbXdpV0dlTS9uNVE2cGJsSk1ITDVhTmVjOTdkZ0FkM2puTmlqR1h6NXEw?=
 =?utf-8?B?aW91VWdXL1k3YUNIM095Z200Z3hZWS9pMmZPZlNsZlE3dUgrWVVaQ0xPRlNX?=
 =?utf-8?B?ck83T2EzRm8xdlczNTRORGhhNG1VREhGdFNKQ0xHWC9YOXNFOEQ2MWJqNTFR?=
 =?utf-8?B?enRhRjB6Q0NoTEppODVHL3B3c2lISzBqUTB1alpCUERBTGlVaHNOYWlOZ0Yr?=
 =?utf-8?B?L1NtQ0l5Q1RSSmlxbXNWcGdtc2l3ajF6Mkd1VFJQTDNMUnB3Wjd6c1NLdXN6?=
 =?utf-8?B?NFJUQlZlUHZGRnFqaDk3eHBaZUFHcHNwcHdBbFBJUEJteHc3Tkd4SFRoMTNu?=
 =?utf-8?B?eEVaRWJOc0tqUjI4MFRPQzhERFhvVmNKZG52NjU1VzRQc0VDaE1Vd2F5bGZT?=
 =?utf-8?B?WXBYQzJTb0xmRnNmWHo3czJNZ092TG84OE13WU9tVUNpR2N2OStpT1F2SnlM?=
 =?utf-8?B?U2xRdDdxSEdRTlVnQ1dkMGpFMHBjeG9BMXJmb2I4VGphQ2ZkcDhJYlRhMitL?=
 =?utf-8?B?T3BwSURJTHJPeWxEUEJkSWs0RDBUNEF3eUpvekFlOFJicURNaXpnZ3VNZGtC?=
 =?utf-8?B?K3JzR1A3d2hyUnNPRHpmeVc1UHExUWFsUDJZVXE1b20rQ0NZa3hFYU1FaXJs?=
 =?utf-8?B?Z0VPRkd6N0RzVTZrVUdZVXEzdlhSMGxkT2xxeitMemlPZC9Ha2hnRjZGQUlJ?=
 =?utf-8?B?WTNETUFyVGxQNCsyb1pxTGFQZUcvdVFpTDA4S09acHR3YWgzdWtxSXBGdzFw?=
 =?utf-8?B?R1NUdFZUZ3VBRHFkZG5BaTVKK1RpcVVKRWtTUVIxYWRuc1pvOXlUMUU3ZVR0?=
 =?utf-8?B?Z2NPNll2WlpXQXBlQU9NSEdOSHF2R3hRYnc2eVhVTUtlNlo0dlNLRUdyRnNV?=
 =?utf-8?B?NjhxeVFsQitjVlVaclJNWWJJVjVqanRQc3Bpbkc3S20zNFVGR25wR29RYlNa?=
 =?utf-8?B?Y2dpK0g2RlNRUGx5SEdLeFlHSWpEbjVJb3REdVFoTEJYdm9IdW1ZcGNySm9M?=
 =?utf-8?B?NXZETWk1T0JHYnEwUzAzNVZnUzI2VG5VajFIWGxFOTlZSkVVeDdRWXRrNFhI?=
 =?utf-8?B?NFhEWjcvTGNyd3lNM3kvOWVVUnF4QUR2Z2ZFUjkvbGZ1S2ZYSkdMUzlZckVD?=
 =?utf-8?B?cEUvbWxCMXprUng5QUpFOFpNcmp1cU5mZk5KbVZoMktqa2dTVW5TZ3Y4ZStR?=
 =?utf-8?B?R240cExYSytjODJTMDRDWHkyZDBVUDI3cERIUHVuRW5LMXZqOFNrdktpcVBo?=
 =?utf-8?B?UE9oRDlYTVBHNit6blhuazdzMjREQy9QVzYzWTJoT1V3YWswVVA2QjNFMkda?=
 =?utf-8?B?NjJlSDJlTnBnL1V4dGgwWGtXekdublFXeHN1UnJ6NGEvU1J6a08xUGRYNVBT?=
 =?utf-8?B?QXBUTjRBcjJyR1Y0TS91Q0FDSzZRY1krQ3o4R2dQSFhzSWVIbWVjZFhibzVx?=
 =?utf-8?B?akh0OGpQQTJpTWpva1FaMm5RUTRGbWowOTVIQ2xTaStNcXF0UWpqaW1wM3Z5?=
 =?utf-8?B?NmlMZVpkU0pHcC93U0NwRFpWeStORVdIeDk0eGNXeUlmUjYra3RJRjc4bXhW?=
 =?utf-8?B?TjdJQzE5aTBNbHQyRUdDME1FcXdOQmgvajlwQ1R5ZzQ1dS94S0VtYjc3N0g0?=
 =?utf-8?B?a29BU05zbjlyVVpRSTZyY2svZFVYYkZESnM5Q01mOFpVSG11bjBWQmh6V0RB?=
 =?utf-8?B?amtJamV0WFdPK3pQc2wwaTVrQ3dsU1dwNmZ3SGl3dFFoVlFkZlptRGpsTmN6?=
 =?utf-8?B?L2xGc1ZxNGt3N3JtbTd4UlloMjNaRFVvdnk2QXV4bDFLZGxENU15M213ZHJV?=
 =?utf-8?B?SHcxZlYzSEh4THBPN1NzZGRsN05UTHZ5MGRXUUNPY0RDeEMyOVMvQXNNOEJD?=
 =?utf-8?B?NXpROVZzZFplS3lEeWVmOE5WaG1zU0gxWXdTalBrU2trUjViazFvY3ZxWnA4?=
 =?utf-8?B?cERHYkkvNjhWam9ta09jVkhFR3pHd1F4clZtMzM0Y3NsVVJhdTEzSm93Qkh4?=
 =?utf-8?B?eEJKZTFGTWs5TUJEOTlwQTVJUW9XZmZOeENyNnFUeEpRMXI1bkJjRjBJcDRv?=
 =?utf-8?B?all0K1BQTVUzVGpoZVdXVFVIVngzY01rR1RGVlZTVWxIZWtDUlJWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda31a94-f744-4d0d-7cd5-08de601798a9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:52:39.6299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeXJ/UskfxLF2io4DFwBRfKfitS4tB5GflcJRdiTkM0iRX8rli/p3F9KluVOGJ6sc6hRfeORRMkZQumqaVBJmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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

Thanks!

0x51 was only made available for GC 11.0.4 AFAICT.

On 1/30/26 9:51 AM, Liu, Shaoyun wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Yes , I can confirm that  from 0x52 , the  mes have the set_hw_resource_1 API support on gfx_11.  Actually , I don't see a official release on 0x51 from mes side , maybe  it's an internal testing  version.
> 
> Regards
> Shaoyun.liu
> 
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, January 29, 2026 3:13 PM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; danijel@nausys.com
> Subject: Re: [PATCH] drm/amd: Set minimum version for set_hw_resource_1 on gfx11 to 0x52
> 
> On Thu, Jan 29, 2026 at 2:57 PM Mario Limonciello <mario.limonciello@amd.com> wrote:
>>
>> commit f81cd793119e7 ("drm/amd/amdgpu: Fix MES init sequence") caused
>> a dependency on new enough MES firmware to use amdgpu.  This was fixed
>> on most gfx11 and gfx12 hardware with commit 0180e0a5dd5c6
>> ("drm/amdgpu/mes: add compatibility checks for set_hw_resource_1"),
>> but this left out that GC 11.0.4 had breakage at MES 0x51.
>>
>> Bump the requirement to 0x52 instead.
> 
> Do we know that 0x52 actually has it?  @Shaoyun Liu can you verify?
> Assuming that is correct,
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
>>
>> Reported-by: danijel@nausys.com
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4576
>> Fixes: f81cd793119e7 ("drm/amd/amdgpu: Fix MES init sequence")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 81bf9385d55a0..09ebb13ca5e81 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -1673,7 +1673,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>>          if (r)
>>                  goto failure;
>>
>> -       if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x50) {
>> +       if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=
>> + 0x52) {
>>                  r = mes_v11_0_set_hw_resources_1(&adev->mes);
>>                  if (r) {
>>                          DRM_ERROR("failed
>> mes_v11_0_set_hw_resources_1, r=%d\n", r);
>> --
>> 2.52.0
>>

