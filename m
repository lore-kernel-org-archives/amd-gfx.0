Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48B9E7FDF3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 00:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549CC10E2F1;
	Tue,  3 Feb 2026 00:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CrMVqDYp";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA35610E2F1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 00:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwEcY3eq/8BRQeb9NW+Ha+5WedSn0o5d9jqefUy5YkGsJUFTfG4CuiQM3TZk2uWfiSji7QDNwnHnLDqKQoxiD+Nbz+uleZMG8KAMliVN1J/tugr9kLfjnN3L+QZQbj4fhzIYFXItsrD/WOIw+T93keIPStktj0DotZS0lZEwfLRwlCFEdgMySPp6A3xbnSEkL4Tc86fH0lO9oszKcVHrMtybRthokgecyNM+IEKiSxPyPrBgmAMB/HHd4TNMda3OVh+d4YGAO9AtMAM+yZXboNjouJDLbK3552Z52GeBnYmAGisoQ1XCGWJtKtWyRCX/Ywh0jke6h/pF/78K11vVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlD+pWhfnW+L/hj7+xSN+Don8Wak3X5wbz9QZQ1mPOQ=;
 b=nVuY8f4uuITjFOXMEO4yzn7aD/VsQK2Iz2bDJpiBJ9W8YegYnB/dXPogTcCAGd3b9ss+UzOUKpK2wOKZiYEDnLW2IgagE8/LM4L4pXHaIl/l30Sc8mu8xQsXE05lyTz+mj7cowhRIv2N+ZsgmTSDVG+V5v8QrGk3V4v7j+QBrMV07bi8dKGsdH0lZfAtsNUxys7GPrXVGb8WXZuaUGcEySLBi+3TXrfMMvYBBVN2IXigGtjIapW4HRVpT2WPIpCx3iFSyNy3fy774NfzGc1HCsE1G6UCghnYMpGZ9htWhwng6nfdfZ3DdwRMGxQanaoRL4H8tT7V26QZYj4wi+iQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlD+pWhfnW+L/hj7+xSN+Don8Wak3X5wbz9QZQ1mPOQ=;
 b=CrMVqDYpIQqhI4PxX4e9uS/5Ktc6muKFG8VhLLNTJmlhx+F9qhMVFEQtqaAQiDpfKx54UrEJWFm2sKlekKby1Ld5ZPJQn8CL/EIxgPa3OpjG7+BGpBjpELYb+f0ksKvUS+GLKEUdjAcMymjdp3gWfTa1B10oEbn8JeZyxpYEhnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 00:47:21 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 00:47:21 +0000
Message-ID: <cf272efe-c0d4-47f2-a62b-7e47973632dc@amd.com>
Date: Mon, 2 Feb 2026 17:47:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] drm/amd/display: Fix and cleanup analog encoders
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com,
 Mauro Rossi <issor.oruam@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
 <CADnq5_OKvYO6ibNLmzuK3tW_sEaaCB82FgoLUc+NPb2asuck=w@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_OKvYO6ibNLmzuK3tW_sEaaCB82FgoLUc+NPb2asuck=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a851e93-0633-4e9b-ac23-08de62bdca2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHBqMGRWcU5aNXpYNk1qU3RoZWtVTTNUc04vbUlpYkxqOTlVUngzOWgyODBJ?=
 =?utf-8?B?SGk3d1dCajJBeC9PZUtpaDVpRDFoKzRVRzROZ096OEw4K3pYTFJSWjdSWDR5?=
 =?utf-8?B?WEJQZkkwK01QbjhPbHduTWpxSTd6RGRwd2lNdXRlV2g1WjloL2IweHRYK2Ru?=
 =?utf-8?B?cjZNeWQwNWNMeU8xQ051UmhGZnI4S3hWWCs1N1dqbGxUK1Z2NlJPYlAwUi9L?=
 =?utf-8?B?Wkt3TzBVa1l4V3BNSDBhdmdwby9JK3QwWFhBRzllYXpEaXpjOU1sQVd0ZHhn?=
 =?utf-8?B?Qm9xSHU0eFJhUVhidkxiaFpFMjBlR2swUnFsTkVJY093REJoblQ3cDhUWkhx?=
 =?utf-8?B?bktLR281TVJoRnNIQVY0R2pIU2pyVy9FUk95clJLTnppMGNwcmpseHFuME5m?=
 =?utf-8?B?UzNHTkN1N1JkNlN0Q1gxQ3hYdWFlUmNudU9mWFdmOFBLUDZ6dTFqSzlyS2Yy?=
 =?utf-8?B?U0F6RGN0dzJQV1lMRit5UFBXZGtwaEprdlFkNzd3Q0lBcFdCQ3dZdnltTnpJ?=
 =?utf-8?B?NXdwaFhvTXZBRGJJWitETmhkcGZ0OU42Zk5JYytCN0tsZGh1SElPZ1FMRUNB?=
 =?utf-8?B?cjRxZTJiNlE5UWkwM080T3dlRmdVS2swdkZHeGd5Vm1DMitHMjlPcW5hUXhO?=
 =?utf-8?B?d0dpV1JGVklMK3BubTBhdUJMNlArbTRyZGExd1RmOHV5UlVUK2JwcXppd2gv?=
 =?utf-8?B?MG1hbjlOY1pRR3h1WFB2REtSSUJTVVN4TTE4bEhuS3ZacjRHSzVhaDhRNXZL?=
 =?utf-8?B?VXA2d0V6RXB0ZEJnV2EwYzhkZXVFM2F2YXV6OVhRUjAzcjFYa1VBVjQ2YmdJ?=
 =?utf-8?B?Y3NVVy9RdTdtRnE4aE5oOEVsY3N5T0xJRWR0aXN6dFMzRU5URzg5R3RTUGla?=
 =?utf-8?B?Z0ZFY2szaHpDNUFCdXFiYVlwb3RzNWFiVE1Ibjh2d05DYy9CYU8ySlZBank5?=
 =?utf-8?B?ZkhQN3pyUzFCYVVFaGdMemFPNG5qTkdQM1BKQVRiVmozNHhhNjUzRlVLdXMv?=
 =?utf-8?B?QUlwMENDd3dGaGxNcERSNFQwUlB0V1hDdHhzV3lFRVIxMG15bmFQaXM3R1NP?=
 =?utf-8?B?VVMyN1lBQmRUSG90cFJLMVBtL0dSOEJlaDQ5WlVVTWxqdktMVk9zUVlybUcz?=
 =?utf-8?B?SkVTMklJWGYrKzZ3SENNZ2ZSTmNnZTRNQkRFNS8wd0ZsTWs1bGtLYk5zeHBH?=
 =?utf-8?B?cFM5OUhpcFdoU1hteXRyT0h3KzJxZUNkZGxBanpMbEJzajJMUFJ3QS9LZzlq?=
 =?utf-8?B?ay9lM0N1NVVNS0J4Z0xwRHRFdUhEOGhFUkh2OTZReHdLSWQ2WjhzaXJERXJx?=
 =?utf-8?B?aTZqM1hFUnIrZ2tGd3BSekdZdWJjUldBenR1azlGc3ZrNE1YT2tzcEZ6ckdt?=
 =?utf-8?B?RTRKRFZzOUdaSzV1c0tqeE1YSkJqMFRHb2owSTVLSVNDQ1pWRHkwZVFBaUQy?=
 =?utf-8?B?RXd4U2pSRjE3c1JrUXVzVE04M3BGZEorZmhiM0l0T3JBSVJpVXdxU0dUTDdy?=
 =?utf-8?B?ZGhBaUtvZjU4cWo5SDRsNDV4OTFWTHptRE92NmJqMWtkemtxcDd5NWZSeUNN?=
 =?utf-8?B?MTBTWjhkV2NEWUk5ZlR2aTdjeFJ2UDRDK3l4MmVPaFB4SE1mUG5PeFQ3cXB5?=
 =?utf-8?B?SGcyWmcwcmhtSXRoRjVNcDJmNVdlVjgwU2tYSDBXQm9WZ2RTZWxsc1lJQ1o4?=
 =?utf-8?B?ekxEQ3dLU3F4Z2dWZkVrRkUrZWJZQzZzT2I5MEllOHl6YTE5ZTVJVzJKY2da?=
 =?utf-8?B?R3ZCMlQwaTEwZUFpZ2V3ZkM1ZWlnT2xVa1YwVFFnZWtTQktKa0tyQlVScEo3?=
 =?utf-8?B?NmhNbTR0OTBEMWk4MXNYd2pMQzJ5QUxPYy9TN2Y2dloxMGpONmZLVlM5elBx?=
 =?utf-8?B?TlBqd2hrdUpvL0RWUnlSc0xCVUxJNHFVM01nY1dKcDMxTHU1Y0JpaXlxY1FJ?=
 =?utf-8?B?WXEzeGE1bWhudzlrL2lXaU92UG4vZVdtWHlhcklqV3pYVkdUeEljQkVNR25O?=
 =?utf-8?B?M04wbjhBZDRKT1FWMmdEZ0pYeHU3ZEdpUHh4UkREVXpnbjZLL0hrQjJYNkNm?=
 =?utf-8?B?L3R2cDMwK2JCQ0xOUDFCcmNKcXhZb2lvTnRydTZtWEc3Y2p1NWg5citlS2cv?=
 =?utf-8?Q?BOlY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGZmeXlidVY1QVpEcERrcURKV2IrQTlFV2VZOVR4aVRXSXJkUWp2WkZxSkd3?=
 =?utf-8?B?OXVoRVFub1VXUklCYVVSZmVKWnczajBqdEhZNHRCdSt1dnZ1ZHk1amlTZXZj?=
 =?utf-8?B?d0d1UWdkWUlGZExuc3k4bGZvSmkzM2Q2emh0ZlRnOWZsZlRTMUMvQS85Q0Q5?=
 =?utf-8?B?OUVaNlNDRlVWZkVJdzRZQkFpRUNleVNBVGtiUVhKNEhPNW0rVU9BMGpBTVVh?=
 =?utf-8?B?RUZqSlVPRGQ3SmFsTGlnK2t3QlpTZDB6WFFUcGdETU01MzNaY2ZYTU5HNzQx?=
 =?utf-8?B?aFIzVHVRYWRoTStBOUErVVFQb1VrQzB0MFdtM1Z5Zm5KbHBoNU5KbWdFMit6?=
 =?utf-8?B?dVNVWU91MDNDZXZIT1FURGg3aWVucVZFd0k1WUJBcEk3eUo0VlJBZUhYS2tP?=
 =?utf-8?B?eHlLMjV3b005QjVkYlIySkw4d3FQYXRKRU1WQVlicERGb3JHb1E4WXhQbHJH?=
 =?utf-8?B?U3EzZXdMVEs0bUE4em9MMTlseUYwOTFMSWZKSkNqT1RCMGd6aUZ4eFM1RGJT?=
 =?utf-8?B?c1psVWd5WTErMXdYbkE5Zy95YUE5eWtoM2ZGM2cxbHhxdmhoN0hZaTgzUmNO?=
 =?utf-8?B?NUpiZDBGZ0RzSUlpV1lPQTJQZDBkKzNKK01NZzRYOEhKRHJXQ0Y4eWZsd1Ba?=
 =?utf-8?B?MWtsVU4zempjRmxrcnpyVjhaUVhXTHRmVXhidkZsczNqTFlURVRWZ1Nqdkxh?=
 =?utf-8?B?ejVhMmlPaUFva0hJbUZYVlVGeS9KVS9Telk5Q0VnZGdvM01LQ0pZOEdlRS80?=
 =?utf-8?B?ejlrSmRJMGg0TGtmOTQ1aWhPT0RTK3UvNWUxdHhPcW40TWh0MTZUd3lPbGpB?=
 =?utf-8?B?TlE1ckd2U0oxYU0wWDc5R2FHZUpFUjNFd0JYSUExczd6RGdUbXVLWHRWU2xK?=
 =?utf-8?B?WjJWWFQreVdHeVEwRmJTWC8wN2Zrc1JHN0NjTG41SjF3V3ZQTWsxcVRUK0s5?=
 =?utf-8?B?M21JRjViNTN3Z3N4dzhyY25jUENkcWFDTWpHdXVuV1Ryc0Q1WFFJcUx4R0hC?=
 =?utf-8?B?R0hzQUo4UERub0FJYko5RE1hbE5QY29TQ0U1d3kwN0g2MmlpV0h5RURFbVpu?=
 =?utf-8?B?UDdBaVpBWmRTalVqNC9CVXJtR2h2dDJpN3BiWWI0cVdRQ2hvMXVBQUY3YXFv?=
 =?utf-8?B?dlF1aVNNbHVwcmNnV3h6RDd4a0c0WFhvVDU0Uyt4TkpXQWNuWEdZdTdoc043?=
 =?utf-8?B?U251V1B5Y0dKTjkydG9wQUdLWDgrZUNGajFrWTQ3L1BjQUpXZ2Z3akowY3Ir?=
 =?utf-8?B?eG04NXQ3SWI5eTlPdG81WnQ2bWZVdTNwK0RhR20weWpEcVYreVVrYnJMdjZv?=
 =?utf-8?B?UzIrc0NRV0RDcFlZWUI4cnFDN3BGOFltOU5DWlpjYk5RZXJvWTZybEFkYWkr?=
 =?utf-8?B?V3doNWoxdVR2WXBUNTlGdVRZc1EvNi9zcEx1VnAxbS90OHRWOGpIR0MvTk95?=
 =?utf-8?B?TkJZb2EwVkllUXpsVGFrVEoxbDJvNitvSnFvejRib3ZUdzh6S2VkM3IxZXRl?=
 =?utf-8?B?Q2NpeHF3bEdvMzFDNXZQVDBDVEZERmtTdG5QRFU4dkVRY0haVEUvWFlhNmJy?=
 =?utf-8?B?MkJtRWFicFJUZ0R6Rkhkclk2Ui9KN1Y2VkdLKzdvdytZeHBNeHdiN2hBME1J?=
 =?utf-8?B?Wjd2aGRtcGplUk1ibGVnRXVIcmFIMTJ4OFRweEZ6RzVaeEFJaHBWazdlVWFS?=
 =?utf-8?B?TzZyQjl5Q0MzY0tSOXJXNVRML2J6QzYydTJmblN2WE5lK3B5dTUrTVJxdUhj?=
 =?utf-8?B?b1RNYTVjMDBwRHZPM2ZJSW5jU29xVGpieEE1dzlmNWZGQVU0TWE2QmJCSTVU?=
 =?utf-8?B?MTBuVXBIU0d4VlVyUHJFeDNQVlloMElIYTJCU0ZYQXcvdHU0UDFWZVM1M1Rx?=
 =?utf-8?B?ckJIM2lYcm0xc25qaUtyUWJlMGxLK1ZPcDBuM3FJTFZxV3RmMmdqYXMxaGZk?=
 =?utf-8?B?R0ZXUGlBQlM3QXdHWk1Ua2hDQk5oWXIrVE42SVdYS2NaUHBzdC9zcVBxU0hp?=
 =?utf-8?B?bnBhV3NjK0Q1QzFBOFg2eUo1QTNVQWkzNFJrN1RJM1hZNVh2UlpKWFkvcDdq?=
 =?utf-8?B?N3dGcmJySEY2L01Lcy85b3IzenBYVzZPakM1RWxnOFpQR1l1MDdxQ1hGdjNq?=
 =?utf-8?B?dm5UOHNVam4zd0tOd2Z1aTBJQlYrVTN5SzZXbFg2THZadUZab05XYjNtTjNQ?=
 =?utf-8?B?aXdkNDdlUEQ1aXhTOUdCc25JTDYxZU54TE9tTVdhdkMzRCtFMks0SVVEME12?=
 =?utf-8?B?NkllYzYwTDBNMWp2dFVzc0p6aXVYV2JlMDVEdC9EVzVxWHZnZnlxdUgzVDJq?=
 =?utf-8?B?Ym9LeG5yRFc0QldveVRHSkh3ekVHMXkxMy93SVY4NGE2eFd1OFFxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a851e93-0633-4e9b-ac23-08de62bdca2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 00:47:21.5590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLEqOnlh1d6bJlLQGKcrDdd4yqq66eSAvb2JGuf1xX8eN1+WTWm8vDJoL789X7P7BRBI7l4gc6PTsOPvm5jl2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
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



On 2/2/26 14:25, Alex Deucher wrote:
> On Mon, Feb 2, 2026 at 7:17 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>
>> Fix a "black screen" issue with analog connector support in DC.
>> The Radeon HD 7790 series seems specifically affected.
>> I recommend backporting the series to 6.19 to avoid regressions.
>>
>> The series also makes the analog connector support more consistent
>> with the rest of the DC code base so it doesn't feel like a hack
>> anymore, ie. it brings analog connectors a bit closer to other
>> connector types.
> 
> Series looks good to me.
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> I assume Alex Hung or Harry will pull this into the DC promotion testing.

I will send this series to promotion test next week.

> 
> Thanks,
> 
> Alex
> 
>>
>> Timur Kristóf (8):
>>    drm/amd/display: Use DCE 6 link encoder for DCE 6 analog connectors
>>    drm/amd/display: Fix disabling fastboot on DCE 6-8
>>    drm/amd/display: Don't call find_analog_engine() twice
>>    drm/amd/display: Turn off DAC in DCE link encoder using VBIOS
>>    drm/amd/display: Initialize DAC in DCE link encoder using VBIOS
>>    drm/amd/display: Set CRTC source for DAC using registers
>>    drm/amd/display: Enable DAC in DCE link encoder
>>    drm/amd/display: Remove unneeded DAC link encoder register
>>
>>   .../drm/amd/display/dc/bios/command_table.c   |  3 +-
>>   .../drm/amd/display/dc/dce/dce_link_encoder.c | 58 ++++++++++++++-----
>>   .../drm/amd/display/dc/dce/dce_link_encoder.h |  8 ++-
>>   .../amd/display/dc/dce/dce_stream_encoder.c   | 23 ++++++--
>>   .../amd/display/dc/dce/dce_stream_encoder.h   | 12 +++-
>>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 58 ++++---------------
>>   .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 +
>>   .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
>>   .../gpu/drm/amd/display/dc/link/link_dpms.c   | 14 ++++-
>>   .../drm/amd/display/dc/link/link_factory.c    |  1 -
>>   .../dc/resource/dce100/dce100_resource.c      |  8 ++-
>>   .../dc/resource/dce60/dce60_resource.c        | 11 ++--
>>   .../dc/resource/dce80/dce80_resource.c        |  8 ++-
>>   13 files changed, 127 insertions(+), 81 deletions(-)
>>
>> --
>> 2.52.0

