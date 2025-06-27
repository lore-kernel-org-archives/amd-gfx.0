Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2FAC7EE33
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 09:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEAE710E982;
	Fri, 27 Jun 2025 09:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="udtLWfje";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C8C10E982
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 09:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7fxwYVhW4w+Kp/k3viSwhKtOVvY8Jqvkm+5ZU98+FSBy1UdBKiuQJynsrJ4PSPJ6slqY+ktUdidguRPY+iNtQhnEzLm43pbOMSTTQZZJPJcOv+6xOxhQZ6uO46g2Y/UNbjwaPVzUvB/IZz/hGQsCNaQnMzqkTB6WzRtZ0CWlZXn+I6bBtJthCiBucr9dy7UYj1GG4c5G/AI7aYlfgM/qbxpBsbgresrPrp3xrpcg0tIu6cNkC29Go28bEdcdQfnqz4EF7x++XRENh8WBg41aydAfAcKVDcrNCrYgXo0bZNfjUDh/58Yw+cBrFo+AOj0fz2CKvXWogH968UiOJZVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xWE9Pp6SlreaIzS/3hNz8aykhpXE5XX00p9w6LE+zw=;
 b=R+YgtdbPA/Y5O1D4A6+e0ZSa/rO/itLIuhlmja5e74Hmou3NiX7Pov3rY+5xrM+LLkpn2tlek4jHwxOl8MGSKPDxnXH0g8MjSmK25Zbq1xLV/RMbjJuVgCzV5gP89boGR89Yo2sW1zmq4t2bJ5DihLCgqGCPQ/wCfTko3PLvoXxbGNwk5drTQ3oWyMWh5I4HlgWkYmlgwmsZKYPkEEigWjhYpqSuFUYFp9p+nD9RbdrsZ9RmO0tu/BiQK74g543N+gsNSCUooAaa9c0FBhQn5Dozd7vRnj5+T974ui4B2ryvXe+dvka+I3/3UOJM66H4V9GjhgWoJzqvexzRl3KV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xWE9Pp6SlreaIzS/3hNz8aykhpXE5XX00p9w6LE+zw=;
 b=udtLWfjez1FYG1YHIvAhaZZt8WkSR5tElgtp8tLlmCuOSRLX6myL/CDhuXqGWHK2/YZymcldbqeDayZTlOLD5S71+2hIFihCOxJCpt/zW5nCDpUYh+/pWPReechDI92h+osXO+eqrsaPL+r9kb3O6BZ1M0VwyYBgQFHKEaQTmVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 09:03:07 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 09:03:07 +0000
Message-ID: <89d80032-ba6a-40a5-a621-d65e13ab977b@amd.com>
Date: Fri, 27 Jun 2025 14:33:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amd: Decrease message level for legacy-pm,
 kv-dpm and si-dpm
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
References: <20250626023855.4026084-1-superm1@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250626023855.4026084-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0067.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1a71ca-66fb-450d-e242-08ddb5596eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2NibHUyUld1dHBXR1YrTlJnWU5lcDlNMS9zU0pIN1VNbGJOOWtCNkpxT3N1?=
 =?utf-8?B?d2M1RmZpV2h5bWxYNE8yRXpMMTNuUjZoVDdzQit2WkJjQnZJS0ZTWXNydFM3?=
 =?utf-8?B?Wkg0YWdoQnFWMjN2bGIzeTQ1em5MdnY3YytJZnUwZDVlRE9xK2YvN3hsVVR4?=
 =?utf-8?B?ODZsbVcrYVliQ3pISDZORW1xU1JXUkJQVW5UcXJVNnVwS3JzaWFNRlJHNjNK?=
 =?utf-8?B?eElNSjlTTzFLZ002SkUraGw1T0xFMnB2ZXVXeVhOQ0M3ZExPeHNlUFlFczZW?=
 =?utf-8?B?T2dKQ3RuTmg4dXNaeUcxRERlR0Q1SFd5VUMzY2QwVmtNWHNnN0g1TllTUFo0?=
 =?utf-8?B?RHZsWUJuVWVEMkJuTkVSWEhYTGk4Um1KK2dPVVQvZ3JNTVZ5dXZFSkgyODN6?=
 =?utf-8?B?QURJSFB3MytTaGI3aUU4ekhzNVpaM2JnS3Nhdk8wQkRJMHN4MXpuYUdIUTFG?=
 =?utf-8?B?YkU2eVdCK1luNE9waU5KekpobmFwYXFuYXdNNkVNN3lRbmdvMkovVUNNUGl0?=
 =?utf-8?B?dEsvTjNRWlBmWTFKYWRrVDNLeWRWZW82V0lOWTFPd3JCMlVJU3o2Wjk2SnNy?=
 =?utf-8?B?Y3dGR2ZmTGxjQStJeVlYOGxDMFM2UnQxRGVKd1NYODZRUkd4RmVRSW9XbDBI?=
 =?utf-8?B?c1NtcEF2cW1qZktLUnFwT2RVNDIvYmhQalZ0MlprMkVhQlBoSzNydnJvdmRW?=
 =?utf-8?B?OGpNQkZRUVBMUFlyZm9QYUcvQmZUOGxqbW1xUytRZWJkMitRZjdJLzk3MHN1?=
 =?utf-8?B?V241WGRlUFAxbVRVM0xGUVpGamJUQVB5b0t1VktlVHpRSmxsOFJqN2ZUYWs4?=
 =?utf-8?B?QU1VQlhqaXVaVnAzQkZmSnNLUVFJVXUxYVM3NWF0M2w3TkZaTE9nQ1BmZGN1?=
 =?utf-8?B?NFJNWmNxT1FKd1pzYWtGbVFOUGxMT0NqbUMrNk1QN1Q4QXJCZEhzWjVNN2hQ?=
 =?utf-8?B?eFhqZjJrWWlkS0toZGZSTVFsTjdwWGxTck5EekFkaUxwT3dzaXFBL1hGL3ZC?=
 =?utf-8?B?Mm5uN3Nlc2luM00rOE1JS3FIOG9MYk9obFJQRldxUUNGTEgyd0JyU3hWcFIz?=
 =?utf-8?B?Qk04eGp5QmlZZll5RlpacVM1M0hmMFJ0bTFsOUpMck1RL1FRRTZoT0I0VW5p?=
 =?utf-8?B?TTkza2hEWm4vODd4YkVySXZDMm5RMnhocUNkUmxRSG9Fb3ZUclVxNXZMVmNn?=
 =?utf-8?B?OGYrY0pJNkovTzU1OXFYOW1qeGljK0wvTEFlMFFjV3gvYTE3MCsyb3dxSUxa?=
 =?utf-8?B?Z3VSR3dUWDF1ekhZNzZvQnQrdXJ1eHZSbkJlK05wUlNhdjF3bUE2R2k0RUcr?=
 =?utf-8?B?Tklhd0pZZUJ6MnFOYzdkV2NRYmVQMnVQWXBPMGNkUWZkaWRaZmVtZ1BsclFq?=
 =?utf-8?B?aHRodmszYUEwSzNKQjlWN2d6VUpVQk9kRnVZMG9DenlMcGtiQjhqV21Qd3Ew?=
 =?utf-8?B?Q3JEU1lZNlN2YVA3aENXdzU5TzlBbWtXaFpXSSttbnNSd3VRc3E0NDJoQkVx?=
 =?utf-8?B?VW5wN0VYczBDcnRpOU8xUk15Z3VVY25zL1pXQ3ozbUc1ZHdyVHFwT2FMaGJR?=
 =?utf-8?B?bFNtd2haRkpJY0U1ZUhzQTJGUERYcXlLbHlFZ1c2WE0vU1YwTkhyYkFQcGNZ?=
 =?utf-8?B?aGdpQllxd3hTOEpCem9jYmxJeFlHdHhkNzJZVWFvcDd6b0gyUC9VZFJocUU3?=
 =?utf-8?B?V0FackdtM0ZWdXp3YzhtUy9CeTZIZVh4L0xlQWptYWV1K0FSNnp3MENIUjg1?=
 =?utf-8?B?dXNYNC9CWk9PTnVuQURFbjNBaXBLM1ZKVFJMdHh6KzdlRUNoeWJsa1laVmpU?=
 =?utf-8?Q?GJCaDKWBIBoUyLNGf7ZfxqRmRVYVRl+NPgh9Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEo4SGRRWS83dS9rODF6SmliR3lEcW5lZDVrNGZCelU0c3VqVjRJNFRKSW1y?=
 =?utf-8?B?bDhtemd2UnRPa09RVmVsU0VnMGxxYkZuS1ZzYjZiZmFreDNnbnFzT0MxdUk2?=
 =?utf-8?B?Ti9KalE3NkZiQzZoOVh2U0Z4ZlFUR3RjREFqMzdBRVVnNW5WU045bEpZanhY?=
 =?utf-8?B?aG8wUmN2bUhySWo1ZlE0YnNlUDNjTEdrR25SaVc3Z1V6QkdYQU0vQXRvR3p1?=
 =?utf-8?B?NHBhSGpYSExndXJuQWNiSWpKa2UyMXZhNWNNbDZpNXVleGxpbFprUGVuNjA5?=
 =?utf-8?B?dWpPWlNkY0FoMko5MldhTmd1L0hYVXY1dlA3VWdYQ1MwZjgrVGZhblJqQjU5?=
 =?utf-8?B?MHQrQVFKUUwxZlR1NGx6WjM0bXIzTldsc2NvakpnczBNUzVaeFdER2RHWngz?=
 =?utf-8?B?eTkyUE53WmxEQTZaVFJ3cElaVzlOR3IrczkwYVFMRXBCMk8zNkNERWpKbm1u?=
 =?utf-8?B?VkcyM1Y0cDZ6cHhOYWhBSXlzQTVjT09jS0NaZVRYVkZBYTFuSEc4bjRvOUxF?=
 =?utf-8?B?MkxVMlhnVHZNWGkyWUI4L3lBTnU5SzVYRFJkb1FXQzFaMWdzVXp2L1lmaHRT?=
 =?utf-8?B?QjJkNjgrcW56elFVY0txUHVpZy9UWlh2ZXhINUR1dHVWOHZQR3FwYWd3QkEr?=
 =?utf-8?B?M0I2M1ZvK1pLTlVNNG56RGkyQVdMMzVicHBQZEFjRTRmY0FtdUUycXoyeHVt?=
 =?utf-8?B?dVkrU0paY253Q1dzZEJyOHVjVm95cWJOMDI2dlltZjB2aDJZMmJnWk5XRExr?=
 =?utf-8?B?OHhKRVdKT1pTL2E2d0h0cGZGdUFsbDMxNmhZcGsvQmdQZWg4WFYzNzdubGZE?=
 =?utf-8?B?UWxPbmxVMzk3RzVmbFBVOEkzeGVNb1lwdm5ob3BzK0c3MWEwS1l3QWU3M3Jo?=
 =?utf-8?B?Z2M1Nm9mOXUyTjZYU01TcVp4ZlRCemtvQk9tcGo5Ti9xZ0d3MVR1SDBuc1Ra?=
 =?utf-8?B?NUhwRjVpd09IVmQ4amR4ZEI4OGdoY05EUkRuNUtzNzNLak1hRWVDUkU0K1RX?=
 =?utf-8?B?dnpaTCt6VndmWnI0b2Uwb0s4Sm9XMDU3enVHTi9DZ1k1cG0xa2haeVhXUVFZ?=
 =?utf-8?B?Q1doT3IwMzA2REJRUmYwTWFsVFM4Q0VuRTBNWDRQeUgxQXphZ3MzTURRaTdr?=
 =?utf-8?B?WEJMU1E4Z0lsSzN1N0tvVU8yODBtK1lOdzVKQ0l4RDJIcGNtMmJXaUFtOGhJ?=
 =?utf-8?B?SEsweW96K2RVUWNaREg0aUNYWnpnL0VFZmJDMjdFN2VCNDRjTURTaFlHdmN5?=
 =?utf-8?B?RElyVmdKVnNxZDNyVE1lSHdlcjdNcHI3M0lUVm5RYllrUVhyUkVyWnFGa0pV?=
 =?utf-8?B?ZlV3eHBwWk5YeUgydUFyb0pmS1hJMTAzKzFnNmJOTGVCUFBIcTNzUENFWHZy?=
 =?utf-8?B?Q0g1cE5zVFVyUU40b3JEcUw2aTlkVEp5YmJrZ1FVclh3Y0swK3QyYzZDMk5K?=
 =?utf-8?B?SiswSnhwWnZBYkNvczBwYTkwSzlLQWdENGwxMXROZmhydngvb3hlNXVTc2Vv?=
 =?utf-8?B?M2VsbmxiSEQxYXlFQzlBR3lqNm1RQk1ET3hFYUE5WHcyejBnMDZwb1ZFL0xx?=
 =?utf-8?B?bW13b3dOV2w4ZGVWR2JqVHNBQ2dPTVNQN3d6TWlnNml5TkY1a29GbDNWWVBi?=
 =?utf-8?B?bkIrV2YvcGZWUmhwR0o1RTBQYjZ0ZHVRRlJOVmhIR1hlZFRJQ2RsMm9la1l1?=
 =?utf-8?B?MVRydjkycUl4S0FxY3ZJS2JndWJhUlhtcVdyMmxQSjZsMDk1ZVRlSWhSZXJ6?=
 =?utf-8?B?MnJ0RkE4bXFRT2tRMW85ak5VTyt1VnN0MkFNYWVyNE9VU09nQjI3d1ZCM1Bv?=
 =?utf-8?B?M0pZWVJzdzV4ZjN0ZTF0OU5lMWpCTFhBRHR3ZU55Uk8rK0x2bXkyK0hzZmpU?=
 =?utf-8?B?cWR1ODMzRWw3NG1sU2V5ZFQ5RWJTS0pnM3hYbGFwN0JqZm9UNHdHVWRsTE8v?=
 =?utf-8?B?K0l6SHJDNE9GMERHNXZxeXB3ay9yM2V0bzRrWXlCQmo5RUV0WXNFOUV0Y0pw?=
 =?utf-8?B?eUhXMVlOWk5hUFJTcitGWUc4ajhHTExKWnVnQjlSYWc1QUlOWDJsblZnbGls?=
 =?utf-8?B?U2QvTmdGSlpxM3RrVUhNTmMvUkVzQlBOM1N2VVlxTENUY3lFTUpWR0RKR1dj?=
 =?utf-8?Q?MaOyxvlGf5qYwWhO9NI7TpVUn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1a71ca-66fb-450d-e242-08ddb5596eb3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 09:03:07.4747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF7iNuRuyIDJppqcdD38rMkKNXe2FnDpwK2Q/af3y5IUky8yi1JZESzMbPiECXMR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
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



On 6/26/2025 8:08 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> legacy-pm, kv-dpm and si-dpm have prints while changing power states
> that don't have a level and thus are printed by default. These are
> not useful at runtime for most people, so decrease them to debug.
> 
> Reported-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4322
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 14 +--
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 90 +++++++------------
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h    |  4 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  8 +-
>  4 files changed, 46 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index 34e71727b27d7..81a6134bd56de 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -2886,14 +2886,16 @@ kv_dpm_print_power_state(void *handle, void *request_ps)
>  	struct kv_ps *ps = kv_get_ps(rps);
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
> -	amdgpu_dpm_print_class_info(rps->class, rps->class2);
> -	amdgpu_dpm_print_cap_info(rps->caps);
> -	printk("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
> +	amdgpu_dpm_print_class_info(adev, rps->class, rps->class2);
> +	amdgpu_dpm_print_cap_info(adev, rps->caps);
> +	drm_dbg(adev_to_drm(adev), "vclk: %d, dclk: %d\n",
> +		rps->vclk, rps->dclk);
>  	for (i = 0; i < ps->num_levels; i++) {
>  		struct kv_pl *pl = &ps->levels[i];
> -		printk("\t\tpower level %d    sclk: %u vddc: %u\n",
> -		       i, pl->sclk,
> -		       kv_convert_8bit_index_to_voltage(adev, pl->vddc_index));
> +		drm_dbg(adev_to_drm(adev),
> +			"power level %d    sclk: %u vddc: %u\n",
> +			i, pl->sclk,
> +			kv_convert_8bit_index_to_voltage(adev, pl->vddc_index));
>  	}
>  	amdgpu_dpm_print_ps_status(adev, rps);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index c7518b13e7879..287a22082c9ed 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -47,7 +47,7 @@
>  #define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
>  		((adev)->powerplay.pp_funcs->check_state_equal((adev)->powerplay.pp_handle, (cps), (rps), (equal)))
>  
> -void amdgpu_dpm_print_class_info(u32 class, u32 class2)
> +void amdgpu_dpm_print_class_info(struct amdgpu_device *adev, u32 class, u32 class2)
>  {
>  	const char *s;
>  
> @@ -66,71 +66,45 @@ void amdgpu_dpm_print_class_info(u32 class, u32 class2)
>  		s = "performance";
>  		break;
>  	}
> -	printk("\tui class: %s\n", s);
> -	printk("\tinternal class:");
> +	drm_dbg(adev_to_drm(adev), "\tui class: %s\n", s);
>  	if (((class & ~ATOM_PPLIB_CLASSIFICATION_UI_MASK) == 0) &&
>  	    (class2 == 0))
> -		pr_cont(" none");
> -	else {
> -		if (class & ATOM_PPLIB_CLASSIFICATION_BOOT)
> -			pr_cont(" boot");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_THERMAL)
> -			pr_cont(" thermal");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_LIMITEDPOWERSOURCE)
> -			pr_cont(" limited_pwr");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_REST)
> -			pr_cont(" rest");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_FORCED)
> -			pr_cont(" forced");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE)
> -			pr_cont(" 3d_perf");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_OVERDRIVETEMPLATE)
> -			pr_cont(" ovrdrv");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_UVDSTATE)
> -			pr_cont(" uvd");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_3DLOW)
> -			pr_cont(" 3d_low");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_ACPI)
> -			pr_cont(" acpi");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_HD2STATE)
> -			pr_cont(" uvd_hd2");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_HDSTATE)
> -			pr_cont(" uvd_hd");
> -		if (class & ATOM_PPLIB_CLASSIFICATION_SDSTATE)
> -			pr_cont(" uvd_sd");
> -		if (class2 & ATOM_PPLIB_CLASSIFICATION2_LIMITEDPOWERSOURCE_2)
> -			pr_cont(" limited_pwr2");
> -		if (class2 & ATOM_PPLIB_CLASSIFICATION2_ULV)
> -			pr_cont(" ulv");
> -		if (class2 & ATOM_PPLIB_CLASSIFICATION2_MVC)
> -			pr_cont(" uvd_mvc");
> -	}
> -	pr_cont("\n");
> +		drm_dbg(adev_to_drm(adev), "\tinternal class: none\n");
> +	else
> +		drm_dbg(adev_to_drm(adev), "\tinternal class: %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n",
> +			(class & ATOM_PPLIB_CLASSIFICATION_BOOT) ? " boot" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_THERMAL) ? " thermal" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_LIMITEDPOWERSOURCE) ? " limited_pwr" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_REST) ? " rest" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_FORCED) ? " forced" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE) ? " 3d_perf" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_OVERDRIVETEMPLATE) ? " ovrdrv" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_UVDSTATE) ? " uvd" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_3DLOW) ? " 3d_low" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_ACPI) ? " acpi" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_HD2STATE) ? " uvd_hd2" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_HDSTATE) ? " uvd_hd" : "",
> +			(class & ATOM_PPLIB_CLASSIFICATION_SDSTATE) ? " uvd_sd" : "",
> +			(class2 & ATOM_PPLIB_CLASSIFICATION2_LIMITEDPOWERSOURCE_2) ? " limited_pwr2" : "",
> +			(class2 & ATOM_PPLIB_CLASSIFICATION2_ULV) ? " ulv" : "",
> +			(class2 & ATOM_PPLIB_CLASSIFICATION2_MVC) ? " uvd_mvc" : "");
>  }
>  
> -void amdgpu_dpm_print_cap_info(u32 caps)
> +void amdgpu_dpm_print_cap_info(struct amdgpu_device *adev, u32 caps)
>  {
> -	printk("\tcaps:");
> -	if (caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY)
> -		pr_cont(" single_disp");
> -	if (caps & ATOM_PPLIB_SUPPORTS_VIDEO_PLAYBACK)
> -		pr_cont(" video");
> -	if (caps & ATOM_PPLIB_DISALLOW_ON_DC)
> -		pr_cont(" no_dc");
> -	pr_cont("\n");
> +	drm_dbg(adev_to_drm(adev), "\tcaps: %s%s%s\n",
> +		(caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) ? " single_disp" : "",
> +		(caps & ATOM_PPLIB_SUPPORTS_VIDEO_PLAYBACK) ? " video" : "",
> +		(caps & ATOM_PPLIB_DISALLOW_ON_DC) ? " no_dc" : "");
>  }
>  
>  void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
>  				struct amdgpu_ps *rps)
>  {
> -	printk("\tstatus:");
> -	if (rps == adev->pm.dpm.current_ps)
> -		pr_cont(" c");
> -	if (rps == adev->pm.dpm.requested_ps)
> -		pr_cont(" r");
> -	if (rps == adev->pm.dpm.boot_ps)
> -		pr_cont(" b");
> -	pr_cont("\n");
> +	drm_dbg(adev_to_drm(adev), "\tstatus:%s%s%s\n",
> +		rps == adev->pm.dpm.current_ps ? " c" : "",
> +		rps == adev->pm.dpm.requested_ps ? " r" : "",
> +		rps == adev->pm.dpm.boot_ps ? " b" : "");
>  }
>  
>  void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
> @@ -943,9 +917,9 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>  		return -EINVAL;
>  
>  	if (amdgpu_dpm == 1 && pp_funcs->print_power_state) {
> -		printk("switching from power state:\n");
> +		drm_dbg(adev_to_drm(adev), "switching from power state\n");
>  		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
> -		printk("switching to power state:\n");
> +		drm_dbg(adev_to_drm(adev), "switching to power state\n");
>  		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.requested_ps);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> index 93bd3973330cd..62967876888a6 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
> @@ -23,8 +23,8 @@
>  #ifndef __LEGACY_DPM_H__
>  #define __LEGACY_DPM_H__
>  
> -void amdgpu_dpm_print_class_info(u32 class, u32 class2);
> -void amdgpu_dpm_print_cap_info(u32 caps);
> +void amdgpu_dpm_print_class_info(struct amdgpu_device *adev, u32 class, u32 class2);
> +void amdgpu_dpm_print_cap_info(struct amdgpu_device *adev, u32 caps);
>  void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
>  				struct amdgpu_ps *rps);

Since nothing is printed any longer, it's better to also rename the
functions as amdgpu_dpm_dbg_print_*

Thanks,
Lijo

>  int amdgpu_get_platform_caps(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index 4c0e976004ba4..d806471a5ce11 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7951,12 +7951,12 @@ static void si_dpm_print_power_state(void *handle,
>  	struct rv7xx_pl *pl;
>  	int i;
>  
> -	amdgpu_dpm_print_class_info(rps->class, rps->class2);
> -	amdgpu_dpm_print_cap_info(rps->caps);
> -	DRM_INFO("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
> +	amdgpu_dpm_print_class_info(adev, rps->class, rps->class2);
> +	amdgpu_dpm_print_cap_info(adev, rps->caps);
> +	drm_dbg(adev_to_drm(adev), "\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
>  	for (i = 0; i < ps->performance_level_count; i++) {
>  		pl = &ps->performance_levels[i];
> -		DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
> +		drm_dbg(adev_to_drm(adev), "\t\tpower level %d    sclk: %u mclk: %u vddc: %u vddci: %u pcie gen: %u\n",
>  			 i, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pcie_gen + 1);
>  	}
>  	amdgpu_dpm_print_ps_status(adev, rps);

