Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CBAC5AE59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 13:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B4A10E83C;
	Thu,  5 Jun 2025 13:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rHQRHuyv";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F6910E83A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 13:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wop3+MIqDTY+MIb1X5xTbFQhjogAcVMZiDikpFMbFT1exkiPjzp/lAnYbKJUhp+b4nCsPN3hEndvxDedFHuXpfWH9ETbhbdbT+43JaLmLuH40z5UfHGOkFiwJuPQkz8cg9e5fxwmaskGY1/wQZ3citSEaiygxy5q0EgbNs7LYypQHiAXsrTVNIge1RpfDr8Ft/9XU0VWm3V/wUIxdS2+tpYtDx3k0iVtnUl9JOMJnHlUQS26AE5M/1caLlafOde+HHJAPKEubONS98xcsIyGmNmFMYbfqQHX7pZsWjps4EY2GMNFOdsKCVY2mqEi+A89akyfSexvUd3eNVe73CjSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAixAWyyDE+ZnSgdldkerAh7wVU6hAOu+U+PBCDRCLM=;
 b=D39O0e+v//rDGE8O7+re37meYJAbQ2CLFFPTjKswreHbkgmOYPOESYOOi0W4ALYKtEbeR5H0BDhhvoJzbj8j9ofuG2pXVOEypDt5KS9552hqOpDjHtgE5vZzDNdrfDYTBJXNMp7ZqMnxr9JokwGkbZ4EZ6LXRNtWhGAhh4q+4yG2DQwDXbMBgUX10UZeSWUi4RpvbwoPaSVqjVzHAQVr/XccMtVMGpE+/S5e412K311lwVSaECZB50rDKBR6S/bgP2enMjZ2iuFv62Y6wmWTEIQNewMSMi8rY1hoWYcgjabXfRR38JNhPRGrXZf0se+N3qonR2NYJ49XywoT30oh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAixAWyyDE+ZnSgdldkerAh7wVU6hAOu+U+PBCDRCLM=;
 b=rHQRHuyv13Unah85YdIOG+dqutgQOTELOxGKabN0JY8HhY8e9ekVhi5lGWkfJHRjQLcRE8eNI7M2NH1/WKgfsHjxxTURORyGkIi/sNwNpU+SdghQgmC71zKHyznpjfhVtxnmyNCVkY/+R3kISfPIHBxnMyJ5RZfJKO+E6R7LoCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 5 Jun
 2025 13:38:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Thu, 5 Jun 2025
 13:38:07 +0000
Message-ID: <d0359d3e-0096-4d95-968e-b1fc0b344604@amd.com>
Date: Thu, 5 Jun 2025 15:37:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
 <20250530075505.882004-3-Prike.Liang@amd.com>
 <ba16b7a2-130b-433c-a305-fa756bead449@amd.com>
 <DS7PR12MB600514C513A65F0C3298D02EFB6FA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB600514C513A65F0C3298D02EFB6FA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:208:19b::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f0e58b-0666-4966-5e5e-08dda43634ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2haZHJzdWhveVVESDhYU0JBM3k0cW41Mk5tU0xkQzNBUzExUWlPNWdTU1Ez?=
 =?utf-8?B?Qlhyd0I2RFBxMVhEMll5eDFidWNMalZ4Y3piMGtCVndqcW4wK2t5M0RVNEVO?=
 =?utf-8?B?UW0vOEIvbHhVRlFHR1M3OGJwTWxHeDB2dzhXcngralFFSW9kdFZvQi9WcW9x?=
 =?utf-8?B?emYvL0M5MDNKcVdBcllFd3I4RFpxcjREVkphbnZiVTZFUHI2d3kweTR3QzE3?=
 =?utf-8?B?SnlWRGwrVE10V1FHV0diSDEwWGlQOW5odWtzVW5zbGZ3bW9pTlA1ai85MGl0?=
 =?utf-8?B?WmZRNlRsbFdXUnlwLzNDdk5PZ2cvUEFJWWVDeEpBRW5jbkdhMnlpSjk0N1Rz?=
 =?utf-8?B?cHF0OCs0dDdvZ09mRXcxUi93UlhRcEZCakN0QUtBNnJ3aFNJclVJMEtYblpN?=
 =?utf-8?B?MTZHSExkS3JWRlVSaHJaZ0QvdWYrekVnMHh6RW9wcW9vZzVhVHRicGgvZTRj?=
 =?utf-8?B?Y3ZYRnhla2JySWhoOFZIaE12aHVjb0oxSEI2R3hRTkgyclhpKzlWU3VFRjNK?=
 =?utf-8?B?N0pTakg5VDY3VXpNb0FGMjJKalpMWEhVWkorWVptbVBuWU9TQnF3UnJRY1lt?=
 =?utf-8?B?ckFpaStRSHdyb242SFN4RzZOempWUmROQVROTVd3UVh3N0NHb2RYMEdMZkRD?=
 =?utf-8?B?REZ3SHAxTE9BZDJaZTdMdFdXN09wSGJSL1BvdFZNRGNWU0pIcTQwa0k4WHE5?=
 =?utf-8?B?U1N0N0RvM0NkMjQ4TkhDYnlEM1lxSzVDZVh3MUdGSnZUYk9sS1N5VUlmcFhS?=
 =?utf-8?B?OHQ1VWZrdjMyZHNjSlRPMVI2bmczRDRvUXZySlorNWNUUWdMOXh0eDVrc01T?=
 =?utf-8?B?YjFlWXdMemxiN0tLQTJ4eTh3b0V5MXIzc21XMlhlUGdvWVFrTUNZaDhtVEcv?=
 =?utf-8?B?elZiWGZaQzJGYlhUUFUyQ1oxUFVVaC9vN0FJay9HUWlReGEramVleEc3azZa?=
 =?utf-8?B?c05DcnFmUFFMWkhOQytlMWRONkgrWll1bXBaTUM4ZGQrYUtnQk5RSGpRejRz?=
 =?utf-8?B?dGlrK0dqSWtkb3RkbnAvQThjM1ljcDhQZHVRSzJkWWh3RnplTklCdWdJMUdz?=
 =?utf-8?B?eUZWMFE4dXZXTE1wWFBSSnUxY1RPZjNxT05zK3cwODNuM2dTUVpWMjA3NjJt?=
 =?utf-8?B?NUUyMERHb2dRVHZPMXJ5dUprWGNXVi9UM2VEWnVoMHoyb0lDbU5lV09FMjBZ?=
 =?utf-8?B?UWN5SDRvTWhyNDVWRlJ6K0R2MXpMb0o1aWNjSnRJYzFVL3dqUSt2R0lCUHcw?=
 =?utf-8?B?KytsK25CNnVSa013YlpjbWg4OWNVd0dEZEVPbjZUbEFFMEZ5eWxnbWk3RFdP?=
 =?utf-8?B?N1ZHVnl3dmlJSkh4MU0zMS8yTnhUb0dkNG1NQW5PeXFuWEFRQUcxT1hFWHBI?=
 =?utf-8?B?Ry9EbEtOd3l1dHY0U01zREpmVVhlQzByZysrTW5mTklSSkZucTdkOEgwZU9Z?=
 =?utf-8?B?Ty9HdUkzdGNqUmpGUW5yZGdXKzJhRG9taHhXdlo5OUpabGhtWGJteFQ3K1Bw?=
 =?utf-8?B?MmpvTnZZMXRXdjcxOWN3cEpONHptTTU1cmxJdXROSms1K1FTTUc3MUN1SW1U?=
 =?utf-8?B?cnV2N2creDhaY1JLbHhsTTJFZnBxWFYxMWFPOWpYb3NOcUF6QWppNXI2VUFQ?=
 =?utf-8?B?clVkbVMwN3lFbGdsQkF0R1JZczNFcHFJS3lKQzlDNDQ3NWJLOThCVU55eWRO?=
 =?utf-8?B?Ni9RdVVqdDVVV080RS9RbXJJL1B0Y3owSlVxdGlxWHdwTHRnOXZSbkdoYzFz?=
 =?utf-8?B?blM5WGt1L295OGU0N3FkdUJ5MzA3SlhkRGVuUGk1VWFKb1BJMytjT1Q2cGxM?=
 =?utf-8?B?Qm1kQWtOK0czaG1HK1JHUDZ2R0pRMTk2M1NJVlBmWXIyWmY2dC9oclc0cld5?=
 =?utf-8?B?S25pck12Z1BlZWJxK0kxQkVkczJLNUxvRDY3K1hEbmJaLzZNaDM4d0FHMnFt?=
 =?utf-8?Q?3ny9H78jOOg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Visrc1kxTTJ2UG8zaS9WNjBZM3YvODFUcTJCTDVWRG5UMTVnUlpVdndad1VU?=
 =?utf-8?B?ME9ZaXhZNnpXLzBBNVRBRWtrK01jVlU5UWg1KzVwUDI0d1VCUEJlcGV3YVRj?=
 =?utf-8?B?Yks4cG8wN1JhNHdIS0FIdXdQc1A4TXFOSzNBV21zOVJ6ZVdJWVA3cENmTWZ3?=
 =?utf-8?B?RHMwU1RvdmFrOE5Mb0Z0SlBKM1BRT3pob0xVNmpOSWRsYXRBWjM3L1pOemZn?=
 =?utf-8?B?NjlBVmpBUk5QNjJkejlEZDF6bWtiSXdnK09wR3I0NWdwdE5ibDE4TmJFTEtE?=
 =?utf-8?B?czQ3ZGhlU2NyeEgrd2tEK3RxSWxSY0RCVjQvbmh4TmRibWFRem5nNjlNK1JP?=
 =?utf-8?B?KzYxUzhxczh6eE83YWNxVHB2NWVHclBMbkVvUDUrOGtFMThtbUxZckdKK3hl?=
 =?utf-8?B?MTNYM1ByRmN0a0VlR1ZsSCtqQytBcmFzNEhmSEJQdytHSEl6RmZPTnpSZHJO?=
 =?utf-8?B?dDdrSTJYNVZNTHgrUGpubEdYYWFFeDl4Z2QvM0RidUYvOFd4TDV3U01sMktu?=
 =?utf-8?B?em1jcC96Z090UEkzVFdwejdPa3JBbVl0a05UQzAxdGVJeFJHNHFaemNSS0lG?=
 =?utf-8?B?a0RWWklGSlVGLzJMUlluTGI1bW9yYytVS1ovT2RuWmNJWUdXMk41VXd1Yy8v?=
 =?utf-8?B?TWhBYW1udFp4R3dpNVBCUTlNa3lWTkRjS2Q1U1RsUVFMZitGYStmSGdzTmlE?=
 =?utf-8?B?bTNFTFRKMW83eGEvaDRDR3poSEsxTVp4amhiYmJOdkIvWTJKUDdOMmlyclJz?=
 =?utf-8?B?RXgrclRSTENsbUgwbkdDVHBwV1hBNnExS1hXaGFsUHkyOGdNNFNWVUIwMkVh?=
 =?utf-8?B?UmNUb2EzS1NLcGVmLzlyejhNNjdQTll1QUZHd2RjaUJoREtObmI1NC9GNHdp?=
 =?utf-8?B?Y3pjVHF3TUFHY3c4WGkxbXZJOTFZK1hZOVVPUzFIcTdsQ3dyZ05VbkVteGxt?=
 =?utf-8?B?TmdVNC93VUo0c09ZaHJLNnRBdTRhVXZDRTNJL291L3FkUTBMYmhOQzNFWDNu?=
 =?utf-8?B?cVlRZTVKdFFxbkE5NG80N3RVQUd0UUJFakdBS2pTZkF6bGM2VTRVTThWVU4z?=
 =?utf-8?B?d1lCZUNNcTVKaml5ck1TaHM2UmRwUkNmaFRFVm5oSWlXcXJqa3J5L0I4N01W?=
 =?utf-8?B?Q2RKSVZLNS9kRUhRS3NMODJpaXdMMWs0N1pNc1RHMEw1V1hoZUtSZ3BUL29i?=
 =?utf-8?B?eXZ5Y29DVHZhS0ordzdGWmV0bVF6YnhOMWVITTFkYmd4aVZrblJWRUpwRWJK?=
 =?utf-8?B?OTZ4OFFDQmdDMCtleE5kdi9hTzVrdEl6YmM4cWdKWHRGMzcyK1FpNnMzMlQ4?=
 =?utf-8?B?UTBSNUI1ZTlwWVZLQmdPVHF3MHVFNWRRdHhOWGJSdG5YbGg4WUtVNFpLNHFN?=
 =?utf-8?B?d2RyTDZNQlVxVFhVTkw3dVZvSExqWXpSOXdHd1dhZkNvU21WZHYzZEZKWnVz?=
 =?utf-8?B?YVI2eGQrTm9CSStuRit5amRhMTR6Y0x4bi9ybVVOb2Z4cWg5YzYwYzFkQi91?=
 =?utf-8?B?UnVQQkVMMnZwWkhCN21DNTc0U2FPNGRZZllXczl6dTR0RXMwYlBBbXFJQzlH?=
 =?utf-8?B?MUNFYTBMYjFPTlc3Sm4rMU0xaFFsMXpBN20zNDJHUlhKWEZNNTlsT1Zqb0ZQ?=
 =?utf-8?B?Wnd0TndaTkM1bUY4czhGNXBTcHZZTkZFcWNyamlFYURTSWk5RWswcSswcVBJ?=
 =?utf-8?B?VTZCTHRHcmJDQmdCcW1UQWJyWnFNQTBNZUV6ZVZvOWRUMGIzeGF5YU1uMEhS?=
 =?utf-8?B?MlNhdHhhT2NoQ1loRlNMM2Y2V3YxeTMyTlpyb3FmMEY5ak5MOUhEbWNSYzRk?=
 =?utf-8?B?cTVKYkZ6S3BmZGdVa2lLVkwzQnBicDBoSXJnRGVsTzN6b1QyaDhHdzQwN0ZO?=
 =?utf-8?B?OEExaUhkMGg1RHpOalpkcXVqVDFRWm5BTTI4TGxIUHRZODUwVkRoU3F6VHJw?=
 =?utf-8?B?VS9zZ3BsbTAzSURUSjRIdzgrRFZqNGlYRXNJZ3ZCMXBFeDRhSktTRUpwVG53?=
 =?utf-8?B?UDBRd2JycUgzSWlqcHMwcjQ5cWZ3aWZ2THFwcXZwaE9SM3k2dGY2a2pwZGdj?=
 =?utf-8?B?d0FJbGlZZCtmMlo2WVJUNDJ2WlAvdmluVWh0UWpGZmhLL2tGWFEzZENXQlhJ?=
 =?utf-8?Q?8Dw2F4HvQ4esGWtf8+9s2qyR/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f0e58b-0666-4966-5e5e-08dda43634ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 13:38:07.8880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBaG1a4leE8tlkuK/azM0S34b+IIRwOHyA20ODPe0gR630OfG7KlfcVgAIWvs8Ze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
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

On 6/5/25 15:15, Liang, Prike wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Monday, June 2, 2025 7:05 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>
>> Subject: Re: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
>> destroying
>>
>> On 5/30/25 09:54, Prike Liang wrote:
>>> The userq buffer should complete its attached work before being
>>> destroyed.
>>
>> That doesn't make sense at all. We should wait for the requested signal fences, but
>> apart from that it is the responsibility for userspace to make sure that queues are
>> only destroyed after they are idle.
>>
>> If the kernel does this it should *never* wait for anything ongoing, it should only
>> forcefully unmap the queue and destroy it.
> [Prike] Yeah, generally, the userq destroy IOCTL request should be performed after Mesa tears the window context down by executing amdgpu_winsys_destroy().
> But if there's an improper case where kernel tries to destroy the userq BOs attached fences somehow haven't signaled, then it's safe to force destroy the userq buffer object with ongoing work?

What do you mean with attached fences? We need to wait for the userq fence before destroying the queue, but apart from that it shouldn't matter what fences are attached where.

Regards,
Christian.

> 
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 3 ++-
>>> drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 +++
>>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 8eea0e1e1b6a..f45585bd5872 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -217,6 +217,8 @@ int amdgpu_userq_create_object(struct
>>> amdgpu_userq_mgr *uq_mgr,  void amdgpu_userq_destroy_object(struct
>> amdgpu_userq_mgr *uq_mgr,
>>>                              struct amdgpu_userq_obj *userq_obj)  {
>>> +   amdgpu_bo_sync_wait(userq_obj->obj,
>> AMDGPU_FENCE_OWNER_UNDEFINED,
>>> +                   false);
>>>     amdgpu_bo_kunmap(userq_obj->obj);
>>>     amdgpu_bo_unref(&userq_obj->obj);
>>>  }
>>> @@ -317,7 +319,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>>>             amdgpu_bo_unpin(queue->db_obj.obj);
>>>             amdgpu_bo_unreserve(queue->db_obj.obj);
>>>     }
>>> -   amdgpu_bo_unref(&queue->db_obj.obj);
>>>     r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>>>     if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
>>>             drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Can't unmap the
>> queue
>>> for destroying.\n"); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index 1457fb49a794..b46e67b179fc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -336,6 +336,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr
>> *uq_mgr,
>>>                   struct amdgpu_usermode_queue *queue)  {
>>>     amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
>>> +   if (queue->db_obj.obj->tbo.pin_count)
>>> +           amdgpu_bo_unpin(queue->db_obj.obj);
>>> +   amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
>>>     kfree(queue->userq_prop);
>>>     amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);  }
> 

