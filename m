Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261D1ECD9A8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC41510E12D;
	Thu,  5 Feb 2026 21:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yBRlZRSO";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B899F10E09F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR6PNnPqh9bDT/Kql2fETkf8qZUaB8vf8p+i6moPHSL75+z86dQiom11rWbJkNx1gopwMIMYIMtYNUMlb8fF8DsAznd/4xzgybadoElELpkct0FF+7yqaBw1eQRPY06vz8uR72AoDHCpe8LEhBjyR42AIMHcjLSgUxqFFoUdcyC3JYQdx6PmSyZSaly31Nqp5yXcsueqpL+AzlxA+9NQPS3GVtGEnKlQT91oK7kdIp3ncsYl8cb9DhQOZqa8hRBOOc+w9JzK5PIcOaq89odJozoiVc2no2kLY1Ti/96jKImAh41y4Wl8nNxzt5MRCe95o0kanTeqLQIVVuoZPiFI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVSHDa24yPH11JIjKoCA65yAByPcLuyO89+7t959lZA=;
 b=XSKMU4rdzlgNCzgAp/nlJ7KGy1Xe2oXHUayz3xn2S7de926a7EQzIF3guzkRP6ralhEyVwA9Ba+7Ealn5+8SqIMZlocvYU0sAmsTYaolfn72qN0EQkGEkO1wbRRMBokaChhDEp1Fh+t3pZK/eM6uW+/K80BqpKq+J3SLCj73nWetsUizfxJnl/n6TIQ78e/tC0Mt6liE9u0WSaeCkAM2aEphgX0Mo5ZWqlE/XVl2bYSH6Xa5EyqR6eSibFK1nt6+YBG3S/fctsVGMU9hL4IeAtSWF3kD0jNjE+zwt5v8aIVgEaNz1ZJXF90PNJ7MG5zs8NYrG/afCq4scejmPNhOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVSHDa24yPH11JIjKoCA65yAByPcLuyO89+7t959lZA=;
 b=yBRlZRSO6bsR7PhbJk17hO1STskYEXo9ac7aUnOntiFiZTKD8iVBgtnKf0OAeLmmNlVAPwhA1GzlaRDO/51oFZ3XJa88OWqnz9/J+Ulaz29Vp00CCb9kIosYYpGqOCWb44KewMxAO6EcxRRLTFYPJXMQqDaQKIUSnjufD1d3XhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 21:00:31 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::62e2:3bb5:bf24:5e96]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::62e2:3bb5:bf24:5e96%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 21:00:31 +0000
Message-ID: <e3d0e7c1-df00-4391-af3a-b51c598fb86e@amd.com>
Date: Thu, 5 Feb 2026 15:00:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
To: "Liu, Alysa" <Alysa.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20260205162846.106865-1-Alysa.Liu@amd.com>
 <f05102ad-0902-46ff-8bc2-29ed809b11f1@amd.com>
 <CH2PR12MB4055670B034D6220F3577151E599A@CH2PR12MB4055.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <CH2PR12MB4055670B034D6220F3577151E599A@CH2PR12MB4055.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::12) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 4108ffec-f7c4-4ed4-1751-08de64f99926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWIzMys1Rjk2ZGlyQ3NxajZUNU1XV1R4b0pzNWNYbnZzQTlwRE5vb1dCNWFY?=
 =?utf-8?B?a21qWTd4SHZaa2Z5NDlJRDlDcEM3cFBwK3FmTDRJMFlrKy9aQm5hQ3RhT0Jz?=
 =?utf-8?B?WXZjM0xXYW5Yc0ZyZTc1czJlSjM0RG1lenhEUVJSdXluVU9rWEJYL1BKSFQ2?=
 =?utf-8?B?K3pEV25GS0diYUNsdWYrcDRPZmtadktqNGJuSUx3QklEVXpuQ0pENEFmKytQ?=
 =?utf-8?B?S29VcGIrZnY2Uyt6bEVPQWNrOWZucWVpZ0ZFUHFTalZnQjQzdnE1ZXNHaEo1?=
 =?utf-8?B?REtJRW40enlsVmxDUmV5czcyYjVUTVoyMXBjWDRwa1EwWVB4VnpacWE5VjRI?=
 =?utf-8?B?Z0NFMktaSnIxZmp4OERCNTRacjFpYXJvY09yTldpQllLY0VoL3JNWEE5VFZk?=
 =?utf-8?B?ay9RamNYTnlDd2liQjhXVU1FYUdCRGVMbmg3L0s3QSswZHpnOFgwL043SDh2?=
 =?utf-8?B?ak9IdTZ1cTR5SFRjdkVuSDBaUVVicTJyT3d1RnA1Z2I5aC82UDRpaHd1S05K?=
 =?utf-8?B?NzRMUjhuc3ZYM2tjUWpFcVVVTWt3bUp2M3lQUDlOeWdhczU0ZHJyU244Tlcx?=
 =?utf-8?B?VVZPZWdKR3VENVZDbk5uWXdlT3k3YU43bEVNQ3Uya3J6Q3FheUlFcWN4aXNH?=
 =?utf-8?B?R1NBdFFWUTZVN1FUWmdKblRZQ0o4NXA3V2l3ZzhuSzNSTk5kOGVlZk9kWHhu?=
 =?utf-8?B?RjN0Tnd6MXY5V3RCekJ5Mno2T1A0ZXpJM2ovbmVGZm5pUHArM1c0WWpZZUp0?=
 =?utf-8?B?YWlrUE5YNVpuOU9EMkVWai91KzBlQnhZVlN3ei81YTh2RmdMZnk3QmlrcWhw?=
 =?utf-8?B?Unl5dmlaYXFYNDZlMFdiNExHNU5QSmZiNCtwZDZyWVc0cS9jRUxJeHUwWjZr?=
 =?utf-8?B?cjZPbGs4YW1MMnlXanlWcW5hS0N4enorSjZUMUJhdjV0aU4yc0tDN2ErWkND?=
 =?utf-8?B?b2xVMjAzU29SQnp5T1lDc1dNVS8vL2Jycm5rcVd0cUNocVBkQUk4ZVlXbGlw?=
 =?utf-8?B?Rm0xRWVaUjNmcEh1RWxZdjRBTnk0Qk5RcnYyVWZ3TmxRa2pRSXcrai9ySmlQ?=
 =?utf-8?B?aE1IYWJla2dOamQ4b1FBanNXWm5lMkR0UUw4TVp0WWlyTjhwWWtZUSt5NURB?=
 =?utf-8?B?NUVDZk1FUitsMXh0ZENwWnNwN3Jvb1lrYXVYRVhrVmhuOU1kelpWTlpXS040?=
 =?utf-8?B?N2l0LzEwUi9XaTQ1WnQ4cGxrYlVEQnlWVWEyNGREaDRuR1JVQ1BxMk1XM3Jv?=
 =?utf-8?B?U2J1SUpCenJaMmJmTEJIZ3pDZ1B6c2YzaVZsbm1TU2cwSElzVlN5dHJWM2tZ?=
 =?utf-8?B?S3psblRvdzB4NitmWjB0T2Y1K1ErdmpOZnBkTjN2Ulk3Y25UaVI5bzU4WjAr?=
 =?utf-8?B?OEJ6RC9nK0V5c3JzanNZYW9UN21PV1J3OXNWTEdud0h2V0VaOU9Ra2J5ZjlW?=
 =?utf-8?B?bGd6V2ZicWc5QTlYdmdkaE1VTkdZajV4UWd5dnp4NmovRTJWeDJpNHc5NmRE?=
 =?utf-8?B?YzJMMFQwNStmVTl6bFJMRWYxbEJHbld1dnZyODhPRDdFMWsvS2VOYTVJb24y?=
 =?utf-8?B?NGRETFJ1bmJGRUE5ZW9idEk3eUVCN3JQVXN2YytEMGZ4ZFFka290Rzd3eXlP?=
 =?utf-8?B?Q2JwSEp0ZitWckVzOWVqaWoyWnVpRERhN3hwZ0VpdUZxeWNhVlBGOWZLRGtO?=
 =?utf-8?B?MGhqUjI1Q0tDd25DSzRoOGoyMiszeExwRkZiSWpjaFYzSG1rTnh1aS9BT1NY?=
 =?utf-8?B?OTRRMndHcGdGc1NSOXhROE9OMkpiL3JHWlE3NFA1eFA4bnRGb1pRYmdOSFZP?=
 =?utf-8?B?bnR4UDZlZ1c2S3h2VThJc2huVTN2SU02OWwrVUUvSEo3TndZaHFidWdHdC9P?=
 =?utf-8?B?NCtTY2U2VHVPZzZmc0NVa0gvV2RjYUtrUEhJRk1qZWZLU1pQUTI0M3cyNGJB?=
 =?utf-8?B?Ymh2Q2lncU4valh4b3Q2TDE0NFZDRnBLakNqV2lHR1NOeUlYWERlWU40eFBL?=
 =?utf-8?B?cC8zR2lRaVZMU2I1RmV4YUdseVNPZWJEcUdKS3FIZUJFZFVzN1ZZK2hLTkNT?=
 =?utf-8?B?dUEwRUtEU1NlcUVUZ1oxMTFzNDF5b2xqckJSY1J2N1RqY1M3NWdLekwyTHc2?=
 =?utf-8?Q?a1ik=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THFSRG1aSHJsQXpXTC8rejI1M3RVaFBhZDRqeC94eXBNVHdIeS9zTXZxdVIy?=
 =?utf-8?B?OTJnYWpIQ0JXU1U1VFJMb3hSRHJ4OStxRHNWQ1dXN0t2VWJkdHR1OENaWmdx?=
 =?utf-8?B?WGhOcDJTNGdKeTgyTkpETWVmNGRjN3NKOFhKOUZjQXl1SHpFVVgwVW1RL3Jr?=
 =?utf-8?B?WFo1Q3BFYnhwWXNua1lXUVJvQVJOcHl5a3BuczN3TXBYZ3Nwd0c0Wkt5WHgr?=
 =?utf-8?B?dXNuVVdxMHBiVm1GQlBjRkFNQXlvQTNJTGVTc3RpRVNZVkd1TlkyV05jYmxR?=
 =?utf-8?B?U2d5NnN4ZjM5QVI4T3RhWlBRaFZoZ1UvdGxaNVBMVWRBdUZDVGp1QUlrTHU1?=
 =?utf-8?B?TS8xOWFiQy93S2pLc2lvN1o5dlBoVmQ0R3RvcUQrTG5KNUpvT0pLLzhOdkth?=
 =?utf-8?B?M0V2c1k1aTV5NG9wTEsvejRwbjMvWU9sWmZqUXNNVjM1djZQc2Via2JNdHRG?=
 =?utf-8?B?WHhJa3lMMzNrR0NmQ3hWT0hoMjFGUlFTdkV3ZUt4UHhWcVkvQklCN2wweVp6?=
 =?utf-8?B?aHNZMnBMaVZqYm9kdkd6ckRqRjl0L1JkZk8wRnJNNFJxdzY2Q0FkY1MrMStD?=
 =?utf-8?B?R1QvZU8rL2huM2NnOGduUGFHVzl6MHFQaE41UWlkU3NHVTRZUXpNd3dFVjVW?=
 =?utf-8?B?Q0loTnI5UU1XTzB0YU9kaEE5YzZETmJWaXRIWVpEd2FSTHRQNjhFVWlGUW1h?=
 =?utf-8?B?clRGazNzaDM3Qk04Z2FEK0Q0UlB1S0dIOWQvdUJzNmMzdkpxQ2RNLzlCcGJJ?=
 =?utf-8?B?R1BjbU5lMkFWVzBWa3ZVcnhLRlFQSDQvQlpUMWgvSk9KbkowbW5kc25yTXZG?=
 =?utf-8?B?cXBUSkRvbHBoNE0yNlVDejNCOTlIUEFsYnVWVVFYbWVxRG5PL0tMWlEvejRa?=
 =?utf-8?B?UHhOTVJDZk94M0NDU003b2VBS2lHSWNrQzJ0aUFGOGEvdWpsekU3VzRDRm9M?=
 =?utf-8?B?SjhscFlGWkc0bGZLNThTMUlLMEV4c08rMjFqVFZ2WE9Sa09sZXZIT2g5Wi95?=
 =?utf-8?B?ek9kYXViVk8vMGIvUnJmdm9XWXpUUFdUdGw3eU1zNWhXK1BMME1sNC9JZGtm?=
 =?utf-8?B?aXIxRFdQck5GQnkrTFZsVEMxQ05saXJvQkhndXJBVjBEcnVXU2tFanFtcm5z?=
 =?utf-8?B?SWxTL2xSZDdvWjhRamJCZ2tJdCtaa0RPaW52UGpJbXZHaGJhNDN1UzFXelJv?=
 =?utf-8?B?dnMva1lHemQyQkZJQTZoZkVYWWtaSU5sMkNnVTFmZ2xzTTIyQWxzN0ZLZzVS?=
 =?utf-8?B?bklhenBtcFVWMG9qNnVTejVGOFpkRHNRY25FVGlPdFN5VTlSTGU1ODNNVjg5?=
 =?utf-8?B?aGRtTnBETTZpbWJvdUlBTCtlNXYrNFpiTlIremRuQ1NEL2gwNC9nYmZsSkVj?=
 =?utf-8?B?UTNHZ0JnUCt2U1ZNTFJuVUVUelFXUllUUHZ1TGVXYlRVNEVMTGxqcmt3TW5S?=
 =?utf-8?B?WE56dmxtV0g3L1hST3BUTmZLdUxuWTVyN2FGbW9jRUhzcThMOUtxRXhzSmoy?=
 =?utf-8?B?K0FRZ20vRXpuNUtVcndxNnBaaTdpMmFxbzlRYjl3bHdZRm5WMlJYajZlajFx?=
 =?utf-8?B?elZIQjBiQ0QwV29jKzRZMWphendacjZiTjd2emwyVEVuWjgzVjR2eG1VMVBp?=
 =?utf-8?B?eFFaNm0rUHRVeTFvdktxRkUrWWQxS3A0R1NEbUQ3RFl0STd4RGJGU2FQYzA4?=
 =?utf-8?B?RlAweXlDeUxRM04zOWN3OGYzZHpKaFBVaklubVhtL29iQzBKNWg2UHh5ek9i?=
 =?utf-8?B?c09yakJBd2FSQnlDdDJIb0t2L1VVb3RDVmVrTlBsKzV5YVBWL0N1cVIxeFJX?=
 =?utf-8?B?azRhWEJOeGFYVWNrbkovVnEvcHQ5WnIvZms1TDYrT2dMdjBEcDJxc2lDYldT?=
 =?utf-8?B?Q2hFWVhaeUp1a0pBTmJYUXl2bDhsTG5MQnNmVk1yNnZBenJqZjNNVzhpNHgz?=
 =?utf-8?B?cjJLaWFESmtzcG1BRGNtc3EzUTlHT3YwaEhUc0grak0xWFh6WGhFZTBuZ1Bl?=
 =?utf-8?B?bFpURWpBSmc4Zmo4SU5HQkRYN2U4TUZBSWo3ejdVSytpY2NCbUVWbUFpcmZK?=
 =?utf-8?B?NHhmSmRiK3pLd0tTbWtlRmYrZm84dS9HY2dXWnQvc0xydlBJZHVZT0VhWTRv?=
 =?utf-8?B?YUhlMFlWL3BoVW1VOTc4Y1BtOG5sUTRWY2daYXJGMlFubnVZM3kvMFZZcHU3?=
 =?utf-8?B?Nm5qUmRrVlZJcWxWRDlUZmk2OWpORVJHNGRsUXNiNEZBRXdLR3BWcXJqOWFo?=
 =?utf-8?B?S2lMdlpSNk5DZzZuNzQ5MWNkRjhEYmhiZ29hWnAyL0RXU3lyVEJyaFhlaGs0?=
 =?utf-8?Q?K8oblQfNaqSh+X0LFt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4108ffec-f7c4-4ed4-1751-08de64f99926
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 21:00:31.3623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cezAjAlh/HdzDb3nWwqXSIzLN+CvuXEwDZ/jiSyy8OsRiiXcxgpPTvhWl3WHY8ds
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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


It is why I asked how it could happen. Is there real case? If there are 
two processes share context of a render node it is either intentionally 
or forbidden at user space.

Xiaogang

On 2/5/2026 2:22 PM, Liu, Alysa wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Xiaogang,
>
> I think this is a security vulnerability, the race could be intentionally triggered, so it doesn't matter how thunk opens render nodes, the kernel should handle this case safely.
>
> Alysa
>
> -----Original Message-----
> From: Chen, Xiaogang <Xiaogang.Chen@amd.com>
> Sent: Thursday, February 5, 2026 1:09 PM
> To: Liu, Alysa <Alysa.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
>
>
> On 2/5/2026 10:28 AM, Alysa.Liu@amd.com wrote:
>> Replace non-atomic vm->process_info assignment with cmpxchg() to
>> prevent race when parent/child processes sharing a drm_file both try
>> to acquire the same VM after fork().
> I wonder how parent/child processes can share same drm file? The child process should close render node after fork/exec, then create its own gpu vm. Thunk open render node with O_CLOEXEC.
>
> Regards
>
> Xiaogang
>
>> Signed-off-by: Alysa.Liu@amd.com <Alysa.Liu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 00ea69baa126..f7b2358a0303 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>                *process_info = info;
>>        }
>>
>> -     vm->process_info = *process_info;
>> +     if (cmpxchg(&vm->process_info, NULL, *process_info) != NULL) {
>> +             ret = -EINVAL;
>> +             goto already_acquired;
>> +     }
>>
>>        /* Validate page directory and attach eviction fence */
>>        ret = amdgpu_bo_reserve(vm->root.bo, true); @@ -1472,6 +1475,7 @@
>> static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>>        amdgpu_bo_unreserve(vm->root.bo);
>>    reserve_pd_fail:
>>        vm->process_info = NULL;
>> +already_acquired:
>>        if (info) {
>>                dma_fence_put(&info->eviction_fence->base);
>>                *process_info = NULL;
