Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D1AC3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 17:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C060110E233;
	Mon, 22 Jul 2024 17:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oQ0791aC";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419B310E231
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 17:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvT4tPZZPwjbnCbnA1jkJYasHGiiqIU6B3gBaeNbJMmak3dlWee++nTl5SgM5XFfnjceAHfyIRVc/W13s9D41BJ30XYuIOA1TUGNUBlN4SPUt1a5XQO2ZT/bMp779VB9+V44BGG+uQwM70eRZiHgoeZ/OaN1TnuUTrnI/AyvpuRVxBI+Y0Ac00hWRUKQG7/T7rLvMDoI+pDMohMR7K8RdCi0U+TrTsfhpYt+muFFXXDkX9HxzDvJeY6qcJG/eyEnOCfK6W3fyXMX5hxodnsLs48KyKFdEl5LfJwPyRhOU8+amcsYTRD9l2ks86ISgY9myeLbJXAuaKEVqgUzp6uOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0FmehjsnXCF6CTtbENEd+YpCYcdZwfcsI9k5eicNis=;
 b=BVtoTF/QB9IN00Ddv3ICwFS5aRvL3cO/0CrRpBwGR8KUJJCCXZJYSLlBupfLw8gU5MC3sGp8tgSCPJufIgQg4QhJ73j1syu8G26fypZ1pAppH+F1oHGkCl1olt1swqSxCtp/pUZCieWkpDa9J9cyGAFA/M72N6aAT2J8/Z3pYM7DP/eKzpmnAG9ceFIOHjoT8H5KQtJ0HgOD37KoedCIYgn3xK6wYaod7vMPf3cS9txQK9Limgh4ufuhRfcWiXfXqG2xbm1VnBHDVkqEACdj5iVUX8LI6yjYXowEZaTUf2cSmYkZwI+e1FSR0EqNoGvdKwsP43Ri4G9TMMF6Z9I7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0FmehjsnXCF6CTtbENEd+YpCYcdZwfcsI9k5eicNis=;
 b=oQ0791aCq+OiB6qces4pnbX14Mf9arEQansC/ykALVqZK1Xv8dubcHCCpo1DDNyJEB1mWs/Vg4UgrMkr0YphxCim/bJ/rGl6G8eqSKRTAWjEvovPhOHKsO6Uu5PlOoGcqr1wKJhDhQ789cHv+GgunUI8D7xechMLCkw4R4AER5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 17:25:05 +0000
Received: from IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692]) by IA1PR12MB8495.namprd12.prod.outlook.com
 ([fe80::97d3:87e9:1c4c:c692%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 17:25:04 +0000
Message-ID: <0a81257e-fadc-434a-af5c-b0659241de32@amd.com>
Date: Mon, 22 Jul 2024 11:25:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Add NULL check for clk_mgr and
 clk_mgr->funcs in dcn401_init_hw
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tom Chung <chiahsuan.chung@amd.com>,
 Roman Li <roman.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240721062216.3151119-3-srinivasan.shanmugam@amd.com>
 <20240722112832.3908202-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20240722112832.3908202-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0194.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::19) To IA1PR12MB8495.namprd12.prod.outlook.com
 (2603:10b6:208:44d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8495:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbc7490-ec7d-4095-0687-08dcaa733990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ylh0Z253WGJ6ZlZjNG5KNElGbGJpa1BidXVuUWluUXBiWUcycUl6VUVJZjkr?=
 =?utf-8?B?OHB4VGNNQXdVZUc3QmRwM1ZnV1ZWMlo0eS9JMkJYSVJydEcvM2YwNjlWTk4v?=
 =?utf-8?B?MmNLUlRWa3ozT0FndU9yZ3FMTzNsYWZjVi9pTnVid2hzWmR3MFNYUm5BN2Zk?=
 =?utf-8?B?SFUxM21SankxVFA2U21MNlZuQ2xUYkJDZ001cys2TjliZ3pnVDI5R1pFdFBN?=
 =?utf-8?B?V1hYVWl3dWY3ZzFmaUh3MUMwWGNmK01EdVZBNW55bWRKcHAxOG9RWUpUQ0lE?=
 =?utf-8?B?MUVHS1ZWUUJEeFFvamNicm1uNy9EbnRmOVZIMmZBK1VLYkpTNlg4eExOeTJN?=
 =?utf-8?B?M0dsZkN6Q0hJOFN3QUU3UlZacnNRaDBaTkw4S09WSThjSlB1S0tKcVVlaVlt?=
 =?utf-8?B?dXJIUjduaXd5RnJTN0xkbzRoeVdCNCs3M0d2aVVzZzZFZTA4UFgxT0NUWVBv?=
 =?utf-8?B?bFBMQlZ5UzlNVXc4YWlHaFpseTdXa2ZOdE9mQWIxblRlUXFuVkpCSEE5NEZY?=
 =?utf-8?B?a2NGMEliQ2d3TXVGZkRjU1hacG54dnlRM2tpN1ZzQlB4cy80NVJJUi9iOHhR?=
 =?utf-8?B?bGxQNW40cjF3Zlp2blJBQnJQQUIrL2Q3ZnZ1ZjdIZEEzRGtYbVFMODZtejRI?=
 =?utf-8?B?bjhPUlNLYit5YThSSUtlTmxIZDVCODIvbUI1RHZyMXdWRENVKzl1Vkw3SmNV?=
 =?utf-8?B?WmdSOEtNdFFVV1Vqd0dEWXZsMVZZWVZ1OGIzaUFWaUgwUlNWV2piMUhteXVY?=
 =?utf-8?B?QzZ3aVVNUmN0OE5jbjBxR1pOQzJ3Wm8wbzFRcHNNTmVwM3FjaUpweGhJMEtS?=
 =?utf-8?B?RTRZbnNVdTAwdEdsYmpoeWY4TDZUbGZwMk5XbmxhYmtSeEdnZndXSENrVzFW?=
 =?utf-8?B?TkNTVUxmRkVZUjAxZkhwU0pGdUxYdEJNWUlONHM0NFBjK1l2bHh6bVViQ1Z3?=
 =?utf-8?B?MmNJU2c0TTN0U1ZnajBEeTE2SDhmNzlZZEVneURpWUhoMUVkY3dqellrMVJE?=
 =?utf-8?B?Y1VHaVU4ZDhuMFFIN1NBYUFQWERucVkzc2NiNlJoRkhBdUNTYXNmWnEvVjhy?=
 =?utf-8?B?MGl3aFh2NVpxMWozMU56ZWs0NEdTU1NJNFZHUW9WY2IzQ2VpeVN6V2hJOUpM?=
 =?utf-8?B?N0VpV0RNeUxzc3hVVzBoZzdTUWY0OFkxMGhta0FiQk1uTXRHbU01cWpPSkZq?=
 =?utf-8?B?NUQybGJMSmhMOGxnSlUyN0NGWHhhc2pkRlRHaXhRSS9VUExOU3J0cTFOY1JZ?=
 =?utf-8?B?NWg1ajk5MXA5NFBlLzUvMnFjYi9NVWc1empaNk5OZU81b0lTVlZOVFJRUmpl?=
 =?utf-8?B?anlmaXpweHMzMW9Fc25NR1hzTjRSQW9QcUwyM2NOc29SUG5EeHVGOXArbnFE?=
 =?utf-8?B?TE1uTzZwTUJBTVNoRVlIam1FSWNOc2lPT2Q2QmM4MjZJNitPUFR2WkREZVQx?=
 =?utf-8?B?aktoMmo3Vmc1bkZaSTVpU2gyMnlGaTF4TjA5Zys5SnVEcDk4VjRaTVFSK2pF?=
 =?utf-8?B?bjhYQXpYZUxZRFE5ekZTeEFBZXJ3ZkRqdCtQM0haUUhJQkE1VE1yYzhIT2g4?=
 =?utf-8?B?UkNXVm05NVV3c3dCWWRyUHlPYS85T2tkMUR0RzRvQXhXOWRKMXJXdVZmbnlV?=
 =?utf-8?B?Mis2NDNpa2FjQU5mWHJqVlJjNmxKckNmMnB1THVQWVBZdmtDT25BVFhPUk1Y?=
 =?utf-8?B?WWZwMk9Jc28weks0TUxMWGdNY0pyd0dJRzYwRVNTZW51RG9MS29QZlVoSUNU?=
 =?utf-8?B?VFpxam1Zb212Wm5OZ0k3ZWN6QkRPUTNoWTJUZFE2ZVhxdytWOVZxem9wRUx6?=
 =?utf-8?B?YkFIMlJYR1JwNDJaNmQ5UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8495.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eldTSUtZcXZxQmJ0R1Q3bzd6Qkl1cUpRREM4UDErbjBWYld0MVp5MGpXUFlP?=
 =?utf-8?B?N2pwWWZuNXAzbTJQcXhkV0REWXhYWHhnemZscXRxLzNIZGNvT2loaTBEc2pR?=
 =?utf-8?B?UTdveEtZSVRqeUNCQklSdzY0TUZUVjhDWlNib2hXMk1ZL0RWUDFzbnB2WCtj?=
 =?utf-8?B?UGxIK2Flcm5CenJRUkRQRE1lakxjMk1nVlVCTmZzOUhDZGZJMVNkdWFQb2Iz?=
 =?utf-8?B?NDJpbFRMNWhlVTJ6ZmVpOWRxRnF3WVU2cEFUd00zcVFESE85Mml4VDhXM1B2?=
 =?utf-8?B?QXZORll5YjlNallHLzZjWXdpQW1VRStpYjRsMHpmUVlRSGVTeENOWDhta015?=
 =?utf-8?B?NFZzam5CRmNqaENUSVI0Vnc0WE9pblY1d1VXNTN2aDlMUnpzcFQxbCtQZE9w?=
 =?utf-8?B?ZXFzS2tlRkRJWXByQURCTU1NMFhVRmw5VWtiVnpxbUlMdjkwWldNVDRmT1Zl?=
 =?utf-8?B?WHlkUFpjc1dXL2c2Z3ZLRUFzMTFEaTZ5OHRLTDFKUU1pZml3bTZwbDNUSE5t?=
 =?utf-8?B?VmM0OUdiUFlUOGh2UmxYR0g5UmJxMVAyZlBBbmo5MTV3a3dMcVNjOW1qR0FO?=
 =?utf-8?B?L3prSVhPWXhUT2pSZVdvbEdCUm03eFN0NW9aTFZVVmI0Tkd2b0dkYWZCQ2JT?=
 =?utf-8?B?M3VZbGRndXFnei8yNXRUbGo5TlZsbkxJbHB5QzRHdkN4NVF4UzhBSjJFeGJK?=
 =?utf-8?B?Sk1oV0JHTTBBL09SYzBhbDR6N2tQeHpVdWkrMjFMVk9pY1hkZWxUd3dsRDI4?=
 =?utf-8?B?K2xDR1IveXMzNlVzUmxYNlFHTTdtS2dxR2UzNkltemdSL3FjU1I4VHJnQ0pF?=
 =?utf-8?B?aEYzZ2lhRUFiUmg3Nm9JMTlBUXpkYUR0RnU1ZlFPTGJPOGxuTzdYanhjNk9t?=
 =?utf-8?B?Ui8yVlBzbDVHMVNneEpCdkR5TkpqdzdqTlFrTVB0T1ZQcHlsK1hSamxxcnMr?=
 =?utf-8?B?YkxoYXgwQm5hVnZoVWxwUC91bGl2NkZBSzJ3Wnl0SE56ZllNdEdLR1VGNi9G?=
 =?utf-8?B?RmxsWnNkUGJGUHkrMldubEtxemhTblY3NHNjT1VLU0FwQVVTRkx1aTc3Q29u?=
 =?utf-8?B?RzF2cy9FVHFCbUxxYWc0UHlGbnE0cUNKSlRzdnFuOGg1aytOT2dpRFlPcnh6?=
 =?utf-8?B?WFl6Z1FseHFnYnJteEJqd1dSYnRZR05zOEhPUDllMjBMR0xnOE1nWTZKaE5W?=
 =?utf-8?B?RUxzQ3R3aUxwOFVVWmtuYXVDbzRZQmlVeEtJYTNZV1g0Tm5QZGc0ZDRYOWV4?=
 =?utf-8?B?b1ROdWZsMElCSFdVdUFqdklEV2daOUp0Vnh3cmY1SFRHSXEyVjVhZUU4dGY1?=
 =?utf-8?B?VU1jUlkyOHY4QTJFaS9aNlJXRmtodVpuN3dMQnYrbXdwa1ladlN3T2o1Rmxa?=
 =?utf-8?B?SlFacWZNcnUvQlVvWkxBVU4wMU0yZGZBdSs5N3h1M1diejM4QWlYUmVzU1Ix?=
 =?utf-8?B?S2tGZ0crV2R1Mm92Z3REVGNER0NPMW84T0V3SndUZTZ0RmxXeFRXWFNDNDFh?=
 =?utf-8?B?YmdRZFJ4anRacUdQVHRKSFlhMTY5bCtCeGZXRzNHK2EySXJ3cWl0VU52TG83?=
 =?utf-8?B?ZFB0YzE0TWkvNFVVVkVFcE9IMEVuemtsK3RaUVZ5cTlJTVZKcXR1VGpMTlRF?=
 =?utf-8?B?MVl5R0JWN0hZdmNmMk5oTVNTNnpXNU8wRmFVMkViREJPK3pxdUMySjZObHBQ?=
 =?utf-8?B?Z1p6aHhzUmlpQkFHdmlFczBxdnVGeU1ZdDlRejZYRXlBRTE3UGR1aEpodGc1?=
 =?utf-8?B?a3BjUmZpOWY2U3NRRkMrK1RTektxOTM3OTNGUGtPemNWRCtmK3NFV1RMUjFC?=
 =?utf-8?B?WUNFdmtwdVkzY2Z4dExtcVhZeTJFUnVtQWRFbFBFV244a0JaOEhkc0xHKzRz?=
 =?utf-8?B?M1JiOTQ1NGtBa0lBaFBCMm04dDVEejVqOXlSZ1grMVJrRHdkK1JFT1ZCcktL?=
 =?utf-8?B?dEE5bis0N0Y2RXhjbE9ZWERQcWpJaFdPVTQ1Y25FNXBVZFFzSC9uWFVRazlR?=
 =?utf-8?B?aURaNHdzVnhMTWptWVdqc3M3dDZiblVRSitkL3BmcUN5R2NwR1o5UW5rRExW?=
 =?utf-8?B?V1RMakhobHRWVlg3dnlrSVVLb3pqck5CWTNzRDNUUmhKc25peHRMaFBvY0xr?=
 =?utf-8?Q?4K1kG19Airhq3wCrUrbDMnmol?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbc7490-ec7d-4095-0687-08dcaa733990
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 17:25:04.4783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPL/qpaDvcamNI3wtBQz2BtWCyEatiyeUN/wq6iNRkDpDoWBzLDaWLKzwvogD1lyZw7zgZ/rbm85yJhZUZNFiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2024-07-22 05:28, Srinivasan Shanmugam wrote:
> This commit addresses a potential null pointer dereference issue in the
> `dcn401_init_hw` function. The issue could occur when `dc->clk_mgr` or
> `dc->clk_mgr->funcs` is null.
> 
> The fix adds a check to ensure `dc->clk_mgr` and `dc->clk_mgr->funcs` is
> not null before accessing its functions. This prevents a potential null
> pointer dereference.
> 
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c:416 dcn401_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 225)
> 
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2: Along with "dc->clk_mgr" add check for even dc->clk_mgr->funcs" (Tom)
> 
>   drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> index 87c5ef579ecb..0fa610590245 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> @@ -222,7 +222,7 @@ void dcn401_init_hw(struct dc *dc)
>   	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
>   	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
>   
> -	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks) {
> +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
>   		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
>   
>   		// mark dcmode limits present if any clock has distinct AC and DC values from SMU
> @@ -413,7 +413,7 @@ void dcn401_init_hw(struct dc *dc)
>   	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
>   		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
>   
> -	if (dc->clk_mgr->funcs->notify_wm_ranges)
> +	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
>   		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
>   
>   	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
> @@ -435,7 +435,9 @@ void dcn401_init_hw(struct dc *dc)
>   		dc->debug.fams2_config.bits.enable &= dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver == 2;
>   		if (!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box) {
>   			/* update bounding box if FAMS2 disabled */
> -			dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
> +			if (dc->clk_mgr)
> +				dc->res_pool->funcs->update_bw_bounding_box(dc,
> +									    dc->clk_mgr->bw_params);
>   		}
>   	}
>   }
