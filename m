Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B3CEE0203
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Dec 2025 15:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CECA10E4EA;
	Tue, 30 Dec 2025 15:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bIU1wGnu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EAC10E4EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Dec 2025 15:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCIK9z1yYIVo7Bsi3BrSkXXry42chq+2pIZOFRmbBU+YW31W212dluL2xegdJLIYV3MCGNK/5ycrxWE9l0QqKG894lQdWXoo34BCjnYrjZRlnu4xpE5AKBKPgH54uteRR927S6nntQRwHS7gCu5kBl6S3ggB4TauJFwif3dzPlboHCUbJK/JWuC1L2gLg5pyCDfk+rucysGmbSsIvWejkHRHEXp8CzT/QHDe+W7mEtA7RQrQ3lrRck6nkjvY/0KPTy84m3EGFFEBhys8N35FPt0lTX1pGcd0xiN/x10rgZsdMOINQlTe8/k4txP2lekTbRCXx9+g23D5ekT1JJFUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQFwjpvIH7+zg27Ya9cOHSREkMv8nyhzP4TnlV4iTqc=;
 b=KDMMwAWdHoTdPwKH0AhxsYSdX6doZ6tSQFvaVQi/wsD5UW3oafvSNXVpO5wbckRNwqS+bB++xXrNGF/dsxXS0XPn7Up8RPJffJTxXTsQq1lCfzWVzYpSdS/TCmc8wPmtVgDs6DB3GDK7dOse4FIrbD2TlMbGi5c3+MPweVWkss1aT3+SLg3jvf5n3aqbBHypUUPOI9HAhgHHUFFESJUwXWZ516PYgeWazYIO8YXo4FEBp0Bp8ScgYP2EcWJ2Y71t2YjQOI6lMMNzOEHbYHtL2NT4kLjVwfAXaTKxFl3WJdpVO5S8j+NCFZJ2FWIPMZbWkzA7tmfVE4n0DDO7CmSF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQFwjpvIH7+zg27Ya9cOHSREkMv8nyhzP4TnlV4iTqc=;
 b=bIU1wGnuDURkv5pqpVof5manJ0RZk+lcQTfnJ7FecdDf9reLYMFjVOc+tPDKBkLHUjbVA16VFa5CUb6gqe9sJ38yYOMTJtEwUQHKEWSbpuuGDXKCoSauU5bQlZj21MhXTZnxh/uG9PqW3jyD59scgUBfglbbBSyyfQpdOa5FP88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 15:05:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 15:05:45 +0000
Message-ID: <585583fc-ab78-46fb-a1f7-8dd2dfe791a0@amd.com>
Date: Tue, 30 Dec 2025 16:05:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Skip TLB flush for devices predating the SI
 series
To: "Liang, Prike" <Prike.Liang@amd.com>, Jean Philippe EIMER <phil@jpmr.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20251229022909.777645-1-Prike.Liang@amd.com>
 <e5967879-9d64-468e-ac85-e0dfb5136d45@jpmr.org>
 <DS7PR12MB6005B8971C288DFBA90C85D9FBBCA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005B8971C288DFBA90C85D9FBBCA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 65201efe-bc8b-4e3c-de0d-08de47b4e864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDgvcFQrSDdGR0JNME1nR05CL1BYYzVGTFFYajROcTVDWHp6SFhnQWZrV0VG?=
 =?utf-8?B?cngzMkxzbnVDbXdEcTFRSS93bUJaeFpUWmdCb2dSU0dHbWNrQWRwaWdvbE56?=
 =?utf-8?B?aGo5MFd2VW1uM1BYUURtOEZmSmtKcFlXQ1ZwaE05NUg4bGZjNW5oMUtZb0hC?=
 =?utf-8?B?MHRWV0xpLzd2d083VGt3M0NnYW9xZFMzRGVIVzhUdmdUTVcvcFZmcHB0SS94?=
 =?utf-8?B?ZWZ0d3ltOUVzSm5aOHZNQzgxbkErT2J5NEs1RUdmSWYrK0ZVUW01aGlpOHBO?=
 =?utf-8?B?NWwxcE1WTGlwazhrTzJIejQyQ01JbzJXMGpEazlwZURyNlVCL3NsdkVOOSts?=
 =?utf-8?B?SURZTG01b1ZPZWVUakRQNi9CRmlQdlhqSDVjNUFQTmd0eUk2QVdWeTNQOGhk?=
 =?utf-8?B?RW5KRHBUQ2ZUOHNOOGg1dVpHTzZrUHBwdVpsbTRzdktDeGMzQ09VTVVCb2Rx?=
 =?utf-8?B?R3l6WEtzbUovV3dDQ2Z1eWhtNVJDOGU2UEtLemVRQXdsOVlscm5JNG9rVW8w?=
 =?utf-8?B?S2xZODBaVGdITjdVUjErMnNyMXF2NFJkUENHbHBuWDAvSHdWdnkwQ0o5K3c1?=
 =?utf-8?B?Y2tITlBoNlB2Y1lCaFEvVjc4Q3dQTjRnbWQ4RHlWWkhXRkFVOHd1NGVzSjVi?=
 =?utf-8?B?MzNDT2tReUJtT0JVSFV4bEh3anVwOW96REZWd2h4U1BreW1taEE2L2NXc0hG?=
 =?utf-8?B?RVhOajVzOWozWWwvVHloMzViTHhVSU9jRHhqVDFYa3FTd1Job0pya3F1aWR4?=
 =?utf-8?B?RDdVdmo5TytTL0g2NTJTYzVqMi9vZU1PaXFwUFFUYmtnNVV3dElydGJBQzIy?=
 =?utf-8?B?aEpxc0J4eFlRNTBsS21GNDNuTk9jaCtjaHJnOUZCaDFTTzMxOWgzSEkvb1hP?=
 =?utf-8?B?cTZHSzNSRm5kMlh2dng2RlQxVnR4STU0c2hJYTh0c3o5UmJiL1NyUnFISzJo?=
 =?utf-8?B?cFEzYjRqODliTjVRSkM3dnBrbFFaZ2J5czdxUk1SSGc1VkRoc2hDbldVMzIy?=
 =?utf-8?B?WFA0dFJubjJwNmk2dnh5eWJ1UW9jUDR1SDFWanF2ZDZQUlRBQXhna0JFeEF5?=
 =?utf-8?B?c2tZZm1WenJ4dnZIM3g4ZkZ6Y0ZZVU5jaEM4ZmQ1K1Fka3NYSnpualduOEIv?=
 =?utf-8?B?TFlNQkVVakVOL0tOMld0aW9WREVlMVRvaGdZVXlwZFJvcnFpY0lIeitWeE1y?=
 =?utf-8?B?MTdHaUtaM3E1YkdIdUhLL24xTDZsblc5UVprS2xpK29BU25TU24xS3Q3L0Zu?=
 =?utf-8?B?anFBN1llSDhPMEpUVnhlNGhKME1FSG5sbnJ5N0NZUkhEeW52UVBWckNkWWha?=
 =?utf-8?B?UnhaZi9LUXpOZHMxRWFxVmFMWUtkQkZWcFAvc2JLdmswWjFxMkIyeDFLaUZT?=
 =?utf-8?B?L29ldi9KRjZqTncxdXU3WGQ1a1REN0M2MkhBY2grY2ljM0xxbm1ac1ZTRlIx?=
 =?utf-8?B?YWpBYWNIa3pMSmErZ1V1UXlpdC85NysrV21OeExGQ2JhZlgxMTdjMlBobkVC?=
 =?utf-8?B?cTJhSVA0S0FRaWlnWG4waWZScXdPaWovOFJLL2dhZmozN0lMQUtMZ1QrbGNa?=
 =?utf-8?B?RmFabmFyVjR6Q09vSU8vTHJRSCtkbHlXbHluQnJ0eWVpSldya2o5ZW5ldlJU?=
 =?utf-8?B?UEgvek14cFNtbUpjTHNqVXl1RDErNUlya1BNS0ZXdXpoT0RLK25ZNXJjUGhZ?=
 =?utf-8?B?TEp6VFNxQ1l0Y0RPN2djYU04eFFFMDFwQkVYTWxCOXBEcWFKcFJhcHlTaC9u?=
 =?utf-8?B?RVR0a2ZJbTUvMHcyWmVWMzFjdlRqN2sxSk4yVGVmZVpRSzkrMXU5Z3pvK2RI?=
 =?utf-8?B?bXEveGk1eXJsVWkzWVltZDhGOEdlQmRRbW9lYU5MWVNSdVdTcHpicUhZWUxm?=
 =?utf-8?B?c0JlcFVmSGlvalBINk80UkNPMWE5ZW56b21DbjNUdHpJK1VnM09JRFZVWlBQ?=
 =?utf-8?Q?VkthcTy3YGakFnLxqg1z4gSP2A46/YEl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFdTM3lQdDNqM01NZjI2TklxNTB4YkUvdVJkQUhNZTdzaXJDbFR0NHE2dlFK?=
 =?utf-8?B?QUg5dDczcDhrYy9BejN6UXorc1RuNDAzd1ZKbFhOTjZ5QVZBRlBxQnhaZkFl?=
 =?utf-8?B?b2J4ak5xOGh0TC9tNm91dDIyQnZnb1Z0QUZUR0Noa2ovc1NaMlJweXBZdzVI?=
 =?utf-8?B?SVI5TjdGOHZVdE91dS9VWmt1bDFwbFBEeGJTZFdLWk1YU2JqYUxCbkJ6K0Zn?=
 =?utf-8?B?M2NhMXNBVGZORlE0YlR5UGpuYTZrc0xCeTQ5U2drSUZ3NDBob0RqNjlWVDFQ?=
 =?utf-8?B?ekUxSEFGakYvUDNCOFhrQURFUGZ3WHpZanNYMTdoZktjMDhEVFNXdjloSmRY?=
 =?utf-8?B?Q2dzS3JrcmdNNTZYWmRxTXlMUzQ3dFhjUkZCUTdiWXBmb3l1bjBIMEpGNTRX?=
 =?utf-8?B?OW9vOWJjUVVZZzBvd1JubmhvN0s4MGphL3JTazBJZThZbUN6VDlDZllwZnZp?=
 =?utf-8?B?OUNaUk1RbzdDUkl3NkxHZ0hINGcxVW9lVTI4R0twZDRmQ3dWNkFMclBuMXZK?=
 =?utf-8?B?TmNFNXFrREoyNUhmSyt0VmU0VjN0bENvZnVKV29IdVUvZ0tBL1FyWDlmeWVY?=
 =?utf-8?B?WFFtcHVYTGhHTUFQbFN6VFRjRmNXc2NKS1VreTd5UW9HMy9PUlRlSjlJOW9O?=
 =?utf-8?B?OXg2SDNyMWxMaDdlSDBpaVNSOS9zU0Q3YS9ZcVFmVGVZeCtQMDBoekFUcUp0?=
 =?utf-8?B?cXBZS295VzZNN01IN2J4ZkdKdjZGTHhvd1N3VDkxTDl2eFZMKys5WVgxNy9r?=
 =?utf-8?B?cmZhaGgzMFpPa3NtZ2xTOW5rWXFhcTVpS04vdkxZL2FucGFlMDVYQnNlT05F?=
 =?utf-8?B?YTBsS2E2UWhLZ2xOdklMUGttTEhZQnZVb3RRNk1Dd3ozTUJidFB5QWRsNWpi?=
 =?utf-8?B?L3F5OUhNS29OdGI3OVFWdGY5d1VONDRYc1JaT2lTdTJKOHdqckN2elRVcFZH?=
 =?utf-8?B?LzZvUEpScHc5dkt3M0kwdWlhRjl4SWEwVTZiV2VWcFBjZzJ6UUhBbzF2NHB6?=
 =?utf-8?B?Ly80WTBRYVExYkFZdDc3d2Z1VnpSdGExSkF4cXRseVZnY3V0ZUlqNHQ2RnVY?=
 =?utf-8?B?TktNZUU4ZTc3S0NEdHJvb0hmVWdDMCt4eUZodXhWelZ4OWxWVlJlWC9pK0Fh?=
 =?utf-8?B?RzZhckE5TEtGSGZzbjhUbGRDZkRYTmdmQlcyUXdISGZ3Zk5oSC8xUGxhZXBS?=
 =?utf-8?B?ME15eGFvQjU2MHlyTC9NRVczUWZsQ2JTamRoSEwvbXNGaUVSaVJJZ0hZWmRy?=
 =?utf-8?B?Y09iRjl1MFMzSjFPS29jdDBlUUpzODBGdXVhbVdPRStId1ZIcGN5cVk3dU5v?=
 =?utf-8?B?WmJUNlljOEdCbkJxNXh0bVVrRmZabFZkVWNlZUZKRzFJUElwWU5HdEpNeU10?=
 =?utf-8?B?K0U2MnlPTTV5L3lnNUVVVWVFWUVrZENuaTdpc3FPVEhpRHo3SUFRVlpWdFRU?=
 =?utf-8?B?bTh2cHB4TjlQWHVWaWNuK3NPajFWQi9Rcnl1OFZ5eHFjbkJRZVdiVGVhZVQ4?=
 =?utf-8?B?RmV6UnViaEpZcFd5ZU4xTDFDcjRPWFZEdDRITzNKaDZLeE5FZGRKbFNjUzJT?=
 =?utf-8?B?S2c3cm9ObGR4bkROZlk0N0JsZENINStjNm9qTVVVZUdxdFA2cE5IeUZpeENO?=
 =?utf-8?B?R2krTmtocU4xZlZBVVNIREtSU3dNQmp6TkFrMUxNRFZYaXQ2MW1saDhudzB2?=
 =?utf-8?B?cnJldGg3elRWZ0w2MGk2UDk1UkdVMjlPVHZxaXZ3cjNTc1Q4azhxMDBQTjlZ?=
 =?utf-8?B?ek8zZU1UdEF3ZlZrNGZ6dXQ0SUwrd0ZLTmg5NkZMRjJnZG1EejVBUGRGLzli?=
 =?utf-8?B?MVU4S20wU09rMTR6L2hPZ2dxSFI4MmxjdTQ4K1BqbjBLVW1kZzM2TmgxTUhQ?=
 =?utf-8?B?d0pZbE0rSFpGaXM1b2JndWxIZWFQaGFhV1RjQXVUUFBQZnU5YmtkdjhiN0JE?=
 =?utf-8?B?QXF6UktJS1E3WGZFMHZTOVB3bzdkaFFGalJieU9IYUJOcW5UdDlpR0ZyRElu?=
 =?utf-8?B?U3NuR1g4d1l3Y0NqRWcwKzdnOHpaZWh1dCs4c1IxTXZGdnBxdDlFOC9pL0V3?=
 =?utf-8?B?S05NL3daRmdPOFQ1cFdkWTNqVHNVSkYyUlRVWUtqMHc5T2RyUTVPclZ5NVFm?=
 =?utf-8?B?NnVmd3I1MGZ6RFZCbXZCWktQSXlJQ3drbG9ISkc4K0VCb1dUT0RIb0JiK2JD?=
 =?utf-8?B?RmZxR1E2RVVlZmNRNk9VVTJvdDlsWWNXeVFPWUNUNngrM1Ywemc0V2hMZElG?=
 =?utf-8?B?bnJzSHdOalIwNTd1WUNVVFNQTnpNTTN6K2NGM3BVNGRuMXRqODRzRDlpQVVL?=
 =?utf-8?Q?XppRWK6NhvSaeLUNTu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65201efe-bc8b-4e3c-de0d-08de47b4e864
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 15:05:45.4936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjnxW2KG+6qjBabGk3IEPS7tvU2VYLixCdSP+YNL8IbAxT3ap7bvTr5XxHRhT/B+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

I need to double check, but I think Alex already fixed that.

But fixing that can wait till after the holidays.

Regards,
Christian.

On 12/30/25 02:26, Liang, Prike wrote:
> [Public]
> 
> Thank you for the feedback, I will rework the patch a bit and send it for the test.
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Jean Philippe EIMER <phil@jpmr.org>
>> Sent: Monday, December 29, 2025 5:53 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Skip TLB flush for devices predating the SI
>> series
>>
>> Unfortunately this patch doesn't solve the hang I reported.
>>
>> Please find attached 2 logs obtained with the patch applied, one of them being from
>> a debug serial console.
>>
>>
>> Le 29/12/2025 à 03:29, Prike Liang a écrit :
>>> SI does not support PASID or KIQ/MES, so there is no valid TLB
>>> fence entity available to perform the TLB flush. Without a fallback
>>> return, this will result in a NULL pointer issue due to the invalid
>>> TLB flush device entity
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> Reported-by: Jean Philippe EIMER <phil@jpmr.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index cd4acc6adc9e..965ae02232e0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -772,6 +772,12 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
>> amdgpu_device *adev, uint16_t pasid,
>>>     int r, cnt = 0;
>>>     uint32_t seq;
>>>
>>> +   /* SI does not support PASID or KIQ/MES, and there is no valid
>>> +    * TLB fence entity available to perform the TLB flush.
>>> +    */
>>> +   if(!adev)
>>> +           return 0;
>>> +
>>>     /*
>>>      * A GPU reset should flush all TLBs anyway, so no need to do
>>>      * this while one is ongoing.

