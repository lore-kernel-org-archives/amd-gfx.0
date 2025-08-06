Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E5FC87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91F710E793;
	Wed,  6 Aug 2025 14:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5scewFkJ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0A110E790
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 14:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmuIV2GYg09ot/uqIC6bq4JoHut5RE1HPIoOOq8TjaNwT17ENuGkOYlAVc9IzE1I+IXKqiMrIyYrjooqGTD21LQ1tOxCX3reyo2mBqLdCkK50f2YhjJeVlLsn4Ow15EZGV8bQjZwj+3aOzAbFQhrFilkhuO1AT0W7CpSUULHPovXccRoiLUD7phS7PKGKP4+vNstyeHUu6wZwBxJcuPEp0wwM/JD1t1tzbkQseYPa3wKemzBiXScgzALsepTYfFhCfbctucnX1IutUtIGpxD1y9yr9XXghwYfiO0b1iatpRqDvBBEkeN5OfBDspJiOgLZc1/qoxSPp7VDEhSVbRB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03PGA2wBktB9QS4dOcvT2EuU9UIvH1/TdsphDsmplmk=;
 b=LdO1OXoekftrEk55xElJFex3v6GSYWEq/dcScMGKo3m+aPPyr3Ai6bnDYlacdI0mdDqwsjhqpDhok+m+1iE/y+wl3KfXvyTg7PYUBOKz3wFgmh8K28kqW4mFAPHNwgkyP9DnsijRt3hlZidnpWuLFTlyhTNShfE/hnSBZsQ9649RMwHiOiWSRcJ0Wph0vK7mtVcGoxGJ+ufBxntVCQ6/C1TAUKLHlKCU7hcknZ8jCI/fMe/XskLlmHNYnFEFVBniDzs5PN9w6vCoM55XFyHuAr2jtPZ6MLNBXxapVgs1Fx4uOmyPtFxaG05mMxt5mDwSo121Sas2XoCXKkur4Je+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03PGA2wBktB9QS4dOcvT2EuU9UIvH1/TdsphDsmplmk=;
 b=5scewFkJrsqM0hx0PhuWGzC+44z151wzPKNlaH//5ad4afjUEYOterIAS/ok/BOrFx0fJlzEkA3V1301Y/mCyAh3AZJyKcsFHHVNPliIj97+hA+ocpRgxjRsfnooswcC93H12nzdCO8YP2meQSU8+tPaG+G88Y4NAsS6JQiF7g0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 14:56:18 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44%4]) with mapi id 15.20.8989.015; Wed, 6 Aug 2025
 14:56:18 +0000
Message-ID: <fba517c2-2626-41f7-a09d-31fd028e1aa9@amd.com>
Date: Wed, 6 Aug 2025 10:56:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type more
 accurately
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250723155813.9101-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::28) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ddd364-c5b6-4c39-3292-08ddd4f9662a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUFwL00vR0FBMWJHSENGQ3NyRGNSbUI2V240TERXajZKdFN4Zmt2blZhNFVt?=
 =?utf-8?B?Q3NaVldrcVF5YmplaVNndEl5bnNBTUowUnVncnBIeXVTS3FXOXZncHk0Nnc4?=
 =?utf-8?B?Q3NEY1JHb1ZoWTlaUlBQSXdmbVhRZGNpQnFFQmxZLzMwczNqYjl5aithM1VB?=
 =?utf-8?B?SS81YW5wWVlJdzNBZzNGcXFjZjJSTE55NG80NXlWNkViVFZkRWs5YW1NRGZW?=
 =?utf-8?B?cnJVb2p0TTJOK0dURnc3WndlMnlDTDFlalJEbDU4SXdkWFd2dno1dkZYdkgx?=
 =?utf-8?B?dmxYNi9XT0YwNUhwQUVybU9mVDZleGtuNHRkeW9JNXF2NnJKK0s2cVVid1VZ?=
 =?utf-8?B?bnJCaUhrd3NTSUh0LzRMdGFUQU1QckJPNTJncDV0RC8wWjcwUUlkQVY1ZzVq?=
 =?utf-8?B?cG1EVlB2eE0zc3NLcFc4SUZvZlBpaHAxZ2U0TnI0akZQS3RBVzFZUE1FMHRU?=
 =?utf-8?B?cWp5TldaVGJWek1VYVZqWjArR2IxNm1Pc0tVeXRrWnFEaWFtOENiWExQTktn?=
 =?utf-8?B?OXk5bmg4dzRBQVhjbWxoSDNmbVVNUHh1U0FhUGFEeVJTS0hZcW9GSWh6VlFF?=
 =?utf-8?B?OW50Z1dWeEVEemY5MktocEN6RUkxamtCQlBaOVo1Z1RNcURVOUFXMTVjQjBm?=
 =?utf-8?B?YXh6MHFwNDdYdFFwTGZwRUo5ZXJnNjYvc2hjT2VFZndSRHVzTmdJQ20xdnp4?=
 =?utf-8?B?V25QTTR4QnVBSHY4eXdQV3RNT2llQ2t0QVU3V3FhSEhBOVhxck10cjFoQlVr?=
 =?utf-8?B?TTF4TkhxbFBDUkVwdWZzc1NBaURHVW4zVk0yK2NnU29ocTBkK2hvYUViMlR6?=
 =?utf-8?B?NmlRTDFNWEpudkthMzBrc2xOSG5KSU9JS3hDdFVrRTROV3NsV29IZnN6RzNS?=
 =?utf-8?B?MElQMnBhWGVocEt5QVdONVYrMm0waTdEaTlNQm9OV2svTjdFa0dEdjlVWXRM?=
 =?utf-8?B?b2VJOG9YOHFvNTlNUW5ZNUNTeERmUGpvM1p0NUo5cUJzVTNrTUhwaUZsN1ZR?=
 =?utf-8?B?QkIxSTZDMXZ6cEJCcFo1UUxBVnAxVjZTQ290ZFlTV1hWT2F3Tlh6cXlpbFIz?=
 =?utf-8?B?MzNHQnBMZkVwTlVHNGZDQU5qMkVyTFNYK2MzSUdEaHZWamNXc3VhUjBuQTBM?=
 =?utf-8?B?dlhhVDZ2cTFLSDA0S2Z1d3dnSThLU082c05lWWlrd3BFeTFTemlNc1RqYUlI?=
 =?utf-8?B?TXNCWFZCRmJIMUs5VHpBa1J4SGxGbkVvdnV3MFJ4SXRWSUdCRDJFNTczbHNa?=
 =?utf-8?B?bzdiVDd1RGZFNWRKa3VVUkwralJuZ3RYV0tZSHZ1ZEd1U0l6RWd0TWNQelRv?=
 =?utf-8?B?bjVmRUE1RUhlUlJXMEZTMEs1bW5IdkhLdDFaREs1K1IrOE5pcERFOEhVWGMy?=
 =?utf-8?B?R041eE9uOVB2b21HQTNvdDZoM1EvY0ljdnlkVWwzV2ppUTh4YW9QZlpjK2xC?=
 =?utf-8?B?TkdGandrdWpMVFF3TmFoTG1TRW5IRUNFTHJYNjdLSWVDOG9jYXBKYkxxV2Rz?=
 =?utf-8?B?UWxjYklpRHEyc2plUEpBYXZ4YlliQy9XTXc5NUhEOUEyMStpS0xYUi9vSmZn?=
 =?utf-8?B?QnJmMHovVnlZaXpLc3Q2ZnBXWUlyMkl3TW9YWnhJVVdsb1ZmUDdyTFl6RUFx?=
 =?utf-8?B?UitXd1R1MVlTVkNZdU9EbUtlRWwzWnpMZDdUZHM5NThtME9venF1NlArUjRZ?=
 =?utf-8?B?VWlsKzdIamZ3S3NGZFRBYTEweEFYSDRFQlhzRTByYzVWbUdCZGprRGtsUzFQ?=
 =?utf-8?B?VXJFR1ZrZ0VObEtoYTZuNW1pZjdQdWt5cFVmWGVGRHJyODFNdlVWcmhMQmJE?=
 =?utf-8?B?MU1SV1ZDc2JOUzVPdU5JdmdRR3BnSEZsaGJUNWFuOEl4d0R0Q1RzVjNuZ0xl?=
 =?utf-8?B?V1lVS0l5Ukk0Sk5yMUZiR0poWUNGZmRlVmtneThRRkIxRElIQ2htelZmNlVk?=
 =?utf-8?Q?V1rjZ/YjLIo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFjV29ycnM4N1hwOU84c20wc00xNEpFaWtlSHZtTW40bzBwOHo4MTBqRHBP?=
 =?utf-8?B?NTNLWkYrcnVUM0YwZmIzbzlVQVh5ampYYVNTTW8rRHdlZDAzNlhGUFExeFdZ?=
 =?utf-8?B?bStiK2s3V2NTT1Z2SVpiYmdHVDJJbzhTeFFDQzVvakhIaG5nSHgwSnh4SnNT?=
 =?utf-8?B?ajhoc2RQTnl2a2lIdjBJeC8wRDVzKzB4bXg1dlBjQzBJWnV5QWJHWHZWQVAx?=
 =?utf-8?B?WWFoc3BwZkJtci9GV2UzU1BPRnpiM0p1WTNUaXlJc0VDR3VkSzYxRmJRcmc2?=
 =?utf-8?B?ZjhmRDY4VzNVODhrTmEraS9BSDlRbWFURlhrSWxBSEwvOWZYUFBVMXRBZGFB?=
 =?utf-8?B?NUJWL0FSTEVHTGxXSDFsakNQdFdWSWtpQUNQRnpSdy9vSU5oUmorcWJWU0l4?=
 =?utf-8?B?Y1VsSHJCS1R3L3JUaTArVGp0WlpFWUZiWndmK2RxdEFLOFRFaHVFMWNlQnFa?=
 =?utf-8?B?YkJxRFdVWUJSZ3Fiait6NVR1ZHV2SUgyaGxPKzF0SitXZVVKcXd2WHNtaFpP?=
 =?utf-8?B?YXJ3ZDlWQ2FMV29ieUEyTE9HcUxjQmYvaHFieDQ0eENCSWJQd3ZhVnNqVkpp?=
 =?utf-8?B?VU85SkZ4Tld5MHc5RnBiQTRyMjJuUXpnSWFvSU1LdnBPM1gyN2hyd3Vyc0d3?=
 =?utf-8?B?ckJYK0NrM2dveGI4MXNMRkZRQnpMZTNYZXhrZEcvd3NqMDc3WUdVSE1qVlkz?=
 =?utf-8?B?V0JWbGtJc3FLZy95OWlJUUJPdkNHQ2tEak93bTRsakk4N0ZoZWhoZGxCSTlD?=
 =?utf-8?B?dlFLT245NWU5R0o0SHNqNzFMeDQ5c2Npem5HaHg5YnRuRmJJRXhvQmxxMHBV?=
 =?utf-8?B?YjZXNVFGQ2FneGNlbjlVQ0lOdEE4UWg0ekhwRHNhb0hBTjlBV1lqWHR1aW4r?=
 =?utf-8?B?TnJGN0FLaWZuV2RndHJ1enBHd3FvZElKSTRDUDJXWE1xcC9qVzZJYWw0SE91?=
 =?utf-8?B?dnlIbHNTR0ZSYUlZaUVxdFFMYWJhRE9YeERJcjl6cDBXemF1cTcrSnBqSmxq?=
 =?utf-8?B?cDJiTjRpM2RRZWR1czkySlNKLzRSb3AxZmRSTXdmSmtPa2dEc1ZhNW1ZUG05?=
 =?utf-8?B?UjdzazRqVWdzc3JUdnNwZWhacTllWFplamt4clZhV29nQ0NxZEZyb2IxQmQ1?=
 =?utf-8?B?dGs3Q0plaUN6VDR0MitqU2RYNC9FcERjVEtDSkdydXl4SS9CR2dzSjRjRnlt?=
 =?utf-8?B?WW1nQU05dENYOCtLRHRJOHkxeC9GV05GY01oVGpVc045RWhTQkV2eE9LZmhu?=
 =?utf-8?B?MkVjTnV2a0p5UmdPRHZNdlV1NEZ3MXpwY3J2MW1VNHF5VXNOdlFqM0V3OVhs?=
 =?utf-8?B?aTFqa2c2RXdvU20vbFU3L0VLajRtQU05d3RXM0hPMkZtUFpkdnQweVliRXV4?=
 =?utf-8?B?Znllb2JkYmp1TUF6VkZMUEhpMnBYa3lBUXhqdjV0akhoTTR2bjNMeVJHeHIz?=
 =?utf-8?B?eXNpa1ZFT2p3NTFKN2ZqcHJ5dXYzV0tGcnUzYmdhVkk4N2lDNDFLQVpyY0Yx?=
 =?utf-8?B?VjJBWFN1NHhneTJib2wvQStBSGRnWE1WaFZqUmVUdVZDOGE4N0lGZm1KZlhY?=
 =?utf-8?B?U2NybW9vNmQrWEpGVFloNWVXVWVRN29PQVdSSzBVMmdSVmRVNjdvbE41YVQ5?=
 =?utf-8?B?RmRld3I4V3Y4OXdJaUx4OFh0N3NZckZuRE9jWTRXMnNibjA4MTc1MEZucWRF?=
 =?utf-8?B?Y2lsMnNUTFpINm9lT2p4K3pOVENxb0ZlOUcybXJQdWlYdi9tMGswdDFJNU1N?=
 =?utf-8?B?dnY0czR2UmhBSFhIWEF6eU1qcWtUVHdxRHQ4aGZDV2FjaUkxSDlUa0QzS3Aw?=
 =?utf-8?B?Rzd6Mjg2cER3KzZWeHdQNE5SQmhlYW90TTYzUTExSUw5YVRQYjAvc0RxalV0?=
 =?utf-8?B?NW5ybFRjTDNqN3NiYXRyVFZueDBiY0dOMHBjRHZFdHRnOU9ZbTNnbzYvNnFX?=
 =?utf-8?B?M0o4UWRuc2ltNEcvUVNUeGVkMElERkgvNWJCV2dJaHA2WVA3QlJmVnZVK29M?=
 =?utf-8?B?SHhBT3JlNklJOE83TjR5QTBkbHg4aEgrOHhVV2VLK2pQQVZIZEd0VjlNVFpl?=
 =?utf-8?B?bVgvWDNOM0hOcjJwUW8vK2Y2MmdnN1dKam9jWnArS2doVTJVZXlwUCtjRW9s?=
 =?utf-8?Q?D6KzmrklAjRziIcq5wOmwx9BS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ddd364-c5b6-4c39-3292-08ddd4f9662a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:56:18.4917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mXrujsU2n6pOowuM13KKX8N3OYBWJ/JuoClvb/rG9FJjBubZvEyukmuFXLSYlGqxzddcY3mpEedj+ic5svCKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280
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

On 2025-07-23 11:57, Timur Kristóf wrote:
> Previously, DC determined the DRM connector type based on the
> signal type, which becomes problematic when a connector may
> support different signal types, such as DVI-I.
> 
> With this patch, it is now determined according to the actual
> connector type in DC, meaning it can now distinguish between
> DVI-D and DVI-I connectors.
> 
> A subsequent commit will enable polling for these connectors.
> 

Hi Timur,

this patch regresses the kms_bw IGT test with Navi 31 and 48
with a single 4k60 DP display connected. These subtests fail
when they should pass:

linear-tiling-2-displays-1920x1080p
linear-tiling-2-displays-2160x1440p
linear-tiling-2-displays-2560x1440p
linear-tiling-2-displays-3840x2160p
linear-tiling-3-displays-1920x1080p
linear-tiling-3-displays-2160x1440p
linear-tiling-3-displays-2560x1440p
linear-tiling-3-displays-3840x2160p
linear-tiling-4-displays-1920x1080p
linear-tiling-4-displays-2160x1440p
linear-tiling-4-displays-2560x1440p
linear-tiling-4-displays-3840x2160p

We confirmed with a revert of this patch.

Harry

> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++--------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 096b23ad4845..c347b232ae06 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8038,24 +8038,26 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
>  	return 0;
>  }
>  
> -static int to_drm_connector_type(enum signal_type st)
> +static int to_drm_connector_type(uint32_t connector_id)
>  {
> -	switch (st) {
> -	case SIGNAL_TYPE_HDMI_TYPE_A:
> +	switch (connector_id) {
> +	case CONNECTOR_ID_HDMI_TYPE_A:
>  		return DRM_MODE_CONNECTOR_HDMIA;
> -	case SIGNAL_TYPE_EDP:
> +	case CONNECTOR_ID_EDP:
>  		return DRM_MODE_CONNECTOR_eDP;
> -	case SIGNAL_TYPE_LVDS:
> +	case CONNECTOR_ID_LVDS:
>  		return DRM_MODE_CONNECTOR_LVDS;
> -	case SIGNAL_TYPE_RGB:
> +	case CONNECTOR_ID_VGA:
>  		return DRM_MODE_CONNECTOR_VGA;
> -	case SIGNAL_TYPE_DISPLAY_PORT:
> -	case SIGNAL_TYPE_DISPLAY_PORT_MST:
> +	case CONNECTOR_ID_DISPLAY_PORT:
>  		return DRM_MODE_CONNECTOR_DisplayPort;
> -	case SIGNAL_TYPE_DVI_DUAL_LINK:
> -	case SIGNAL_TYPE_DVI_SINGLE_LINK:
> +	case CONNECTOR_ID_SINGLE_LINK_DVID:
> +	case CONNECTOR_ID_DUAL_LINK_DVID:
>  		return DRM_MODE_CONNECTOR_DVID;
> -	case SIGNAL_TYPE_VIRTUAL:
> +	case CONNECTOR_ID_SINGLE_LINK_DVII:
> +	case CONNECTOR_ID_DUAL_LINK_DVII:
> +		return DRM_MODE_CONNECTOR_DVII;
> +	case CONNECTOR_ID_VIRTUAL:
>  		return DRM_MODE_CONNECTOR_VIRTUAL;
>  
>  	default:
> @@ -8440,6 +8442,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>  			link->link_enc->features.dp_ycbcr420_supported ? true : false;
>  		break;
>  	case DRM_MODE_CONNECTOR_DVID:
> +	case DRM_MODE_CONNECTOR_DVII:
> +	case DRM_MODE_CONNECTOR_VGA:
>  		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
>  		break;
>  	default:
> @@ -8631,7 +8635,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>  		goto out_free;
>  	}
>  
> -	connector_type = to_drm_connector_type(link->connector_signal);
> +	connector_type = to_drm_connector_type(link->link_id.id);
>  
>  	res = drm_connector_init_with_ddc(
>  			dm->ddev,

