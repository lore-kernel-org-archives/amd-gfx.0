Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AA0E7E0BC
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 17:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0412A10E180;
	Mon,  9 Feb 2026 17:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oH5AKGWE";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3F610E180
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 17:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhJdBrKVP7QeD+Dk42m7Q+mug/gB/B8JdcCppIhzAphb7kKoHuXBypmWFkbZ2bSd/9N2cOYvxonsoN26ChsjLbzr8MZ1+f3muW6xVlmordLIAP1YEewFf+iIxBc6HodWGcV7s/a3/VClwX1ZXwqyTTUDRKEhPZgCDcxhc+zTGthqjhUtvQ0sr1mxF/nUZ8rlaNNkW9vGfvOMulUiVNIEYHNDlXXZw3obHlbhqbEzMCw46DQtcpoqyJZthn5sbiIDX6Ri0s0DW+Af5BgGtkB+xyKXg2fyudkMF073Z9MzVoJz488xp/TtsJjS8r9/JT138OT7bVMA3iZXavux+6d0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6/gmhedbF/Q7Y8thhf4FohQ8wgXmkxL8xlutB10dBc=;
 b=kJPwH3l6ain6j5K0rmU46AsoqG6BYRuhjxMRlrDm7nDGBmjPnBs4Mq3JJ08e4LzcoQzkeQZulPXCDzQCq1dzMx65Zkx4HmjjZpJqp+mbv6q+qsTtDfr5Mh4TOBmsQw3YJ2cM8IEZJF9EpogtkCOm8Za4GwBzvBiALPJ71RjerhpfCRFCTtG9GMRBgnWB4ilBLyla/dhU97M0DmGKHPlFL5fiRmpnesaveDjo/Lsgh+duAINGFpj2e/hHLScrr6L/UQrqYZa+klMGpzWGiF6IWyHxeiqEAJh2wJjL9qZLLCdM6+kvGdGQxYoLMwwqVE7Vx3SDWeQOFkZt98bQHOtNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6/gmhedbF/Q7Y8thhf4FohQ8wgXmkxL8xlutB10dBc=;
 b=oH5AKGWET4GRNv6pl9ZoUeCK0gySBdmwRzXjb7MXDXbpmndPYsfCkrQdP36K2nXNVXy3u2e8I73mHAVGH2Zk8K5GUx+AUTUw45hnQP5miYgFAQBrcyDjXApPutDIZia6ABYv/BbGmwl71sCtxdpyl/Fh0A8LN87SZDycvWB6xdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Mon, 9 Feb
 2026 17:30:00 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 17:30:00 +0000
Message-ID: <e2c52360-996a-4f22-b6a3-efe503c8e47e@amd.com>
Date: Mon, 9 Feb 2026 10:29:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Reject cursor plane on DCE when scaled
 differently than primary
To: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Dan Wheeler <daniel.wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>
References: <20260118145741.36198-1-timur.kristof@gmail.com>
 <aXv-e37PeACx549L@atmagalia>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <aXv-e37PeACx549L@atmagalia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::8) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddf1be6-4b8f-4a75-8b66-08de6800da43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVpENGtkbDFFSU9UaGwyOXYvTWdzTE5ReUlxMytJdFc1dVZpaDFBZDMySTJ5?=
 =?utf-8?B?THI2c3hhdzUxbyt3VUIvTXFlQ01tKzkwMnBQQUhkZ3NiUmhEK1V0eVJRZWRC?=
 =?utf-8?B?VGJEQVZCN0xqMS96azMrSTBGSVQ0NzBtYVlaMVZwUGx1dEM1aVZUNEgyUUR6?=
 =?utf-8?B?cFE1VWovNWJkME5OQWt4M2FoNVlsd2g3dGJJQlY5UWpQdUNRRkU1MGdZUWtP?=
 =?utf-8?B?cGtnUEUrb050bzA3ck1oSWMxZUlKQitybWt3K21NZS83c0JYQS9oUHJzRjRZ?=
 =?utf-8?B?a3dvNnlaSGVZOXNsMmx3UkNwYzQyRkt2S094UW1DWEJpZUY1OWN4RTYyNVZC?=
 =?utf-8?B?UjhadE9OVDdZcnJxWWxoOHVYWEtUZWttUzhIWlNyNG82cDFWZUZydFg2cTlV?=
 =?utf-8?B?LzlzRXdvSkVKeml5SEEwejFzWmhBRUQ5QUorRXpxVVYxYTBXenNROEFldEdR?=
 =?utf-8?B?d2VNVWp2Zng3MXcva3pEcHpvdWg1WnJreE53QU4xZjVkamdOU05ZRWRYUUxr?=
 =?utf-8?B?azFTR0RDM2d5eDlwUVVaNzQ4R1hBREtpYVFBMTFaSkttbFBZakpCSjZxMUZj?=
 =?utf-8?B?aDFHbHZIZTNhbEtOaUIyeVVrY3AyL0t0UEZBcjJ1eHkyM1BEckUvZlA3dmxv?=
 =?utf-8?B?M0Z3U21nVkhKS2E3bExoR0RQdXdRL3VnK0FmYXhJQVhKeG9ZZGVuUEF6V29Y?=
 =?utf-8?B?amFYeU1Jb3dxeVlvakN0bHNQTTJkai8xSWljcU9qTHFmWDBaRjNHM0FmM1Zs?=
 =?utf-8?B?YklCQ0pBckVXMENoZFYzU0JCN2N1T3M0SGJDOHdZNGJtVzRuQ2owQkR2Nms0?=
 =?utf-8?B?RkorYnRNMXFwVnpRTXVtMmFUUGUyZXdiTy9IMU42VnI4andxS0hKb2VyeWYx?=
 =?utf-8?B?dFFlVy81ZTJKdmtURlRkTUxhM2dxZjVrMmt6MjFYYmwxQStVZTZJY2JraXEx?=
 =?utf-8?B?dnBmY3B2TTdnYjUyVVRGZGlQa0IxRXBMRzlBR0oxZElYNGNCbkFLWlU2ency?=
 =?utf-8?B?eFlGcmo5TjY0UmFvMjI4NnhmeU4vREZKQ2F3WmVIeE5qa05YdDVxMFNsN0h4?=
 =?utf-8?B?WDdpem5obkZkakl6c1gybDQyT3RrMm9iQlQyTXpjQUN5NUkzSUVOVy9NT2Rm?=
 =?utf-8?B?dnArNmMzcDB4dEt0WG10RjIyOHZJYkYvZG55N3RYc0hVRmZUbzA1OHExdTg0?=
 =?utf-8?B?dzFzSGs5dlZlUHBWZzN6Ty9ZOUMxTUR5UjBoN0tlcEdKSVN3VlZOVjBwWHhq?=
 =?utf-8?B?RjcvQU1SRFRrbFhNVjlVRnlMUjgzWDd0Qlp2UEp3Sk90Y0FpaVl6V1V5R0dy?=
 =?utf-8?B?ZWk0RzJnNWZtdUFZeFpoZFZad3h6SkJMQ1cwNklxVzNsVzVuYlBxTEN4UDdl?=
 =?utf-8?B?UjZ0R3NYczBMLzZhZXUwYWViSG1yZDl0MWsvQitjR1g2MzVyYnRNTWJ4bjZF?=
 =?utf-8?B?S0JWR3NRdDRFZ1RQbXRlMzVuNXd1N0IwZlUxWnhDeVNoWUtJWGZPOVdhaDV6?=
 =?utf-8?B?azFBUmNxcDZpUk0rVEJZdEVMWm5NVk8wQUQ1REhIWXhVV3FRbnFldzVvSjNz?=
 =?utf-8?B?ZVgvR3duTk5EczRzZjVpZFFQRlcxVlB4VFJiMnczcmZmUE9nK3l1WW9wbzM4?=
 =?utf-8?B?UDJscDIzNGF6ZE1UYmFPRGxWaXJ3L3VOWDNxRnFkWXYyYkl1TW9mbjJ0NmF6?=
 =?utf-8?B?Ylc5ZHBma0tnbTNNR2NGTCtNY2UvcTlLQi9IU2g4eG9uTkZRckUzMEdUN21q?=
 =?utf-8?B?d01CWjZCdEFqOWJDU0FHZk1qYUsxeTBycHlNd0IxZkNWT2ZhZ3VwUGZpMks5?=
 =?utf-8?B?SzFraXVLVVMvUWx2MWNWOGVYWEExS2k5WHNHaGZBRWF3ZzV4WkdZUU9vaTFV?=
 =?utf-8?B?ZnhET2s0dDFqOW43NXRyS2Q2MTJQRThqbkZ6dGhFY3FOWDZXU0JRMVFyY0Vr?=
 =?utf-8?B?Wm1OSlVxdVMrdGY3c2x5bzgyVXVlRTY1TzNmM25mMmp3bzF4dWpvUGRHVkVs?=
 =?utf-8?B?SUc4cFpTTmV1LzJGcXNON3kyTUF2ZVhkdFZWU2h2WElJZzBUL2JWUUloUklN?=
 =?utf-8?Q?AmJCw9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVc0UVNCeHplSGlvbWdQWS9LQnYvVEI1VFZKOE5ZTGZZNkEzVG9WdFRTc0FW?=
 =?utf-8?B?MlE5QlQ1bVJoZ0pVdHp2T29hQXBYUGF5TWVVcDRRbzBYbkxCTTl6VWdENlNp?=
 =?utf-8?B?OGcwTDZqZWM5Y096ckIwRHgvTEU0RE5HMkZ1RVUxSU85VWxDMFpiVTZOdGg5?=
 =?utf-8?B?dnUxUWEyL3FuY2NJZitQd01rZGJlTURzMDBoQ0xlcWF0ZHA2RUFKSnZwaWhU?=
 =?utf-8?B?RFNPbkFWb2JST1h6cWdSZHNYazBIQUNGalAxMXd3RmlBMzRST1lsQ3FjTk96?=
 =?utf-8?B?aUpDckJiWENwMUZIUkkxbTJLWHFwUUxiL3E2dFYwY1c1VlV3ZVh0NHhFRERs?=
 =?utf-8?B?S0VEUm84VWRzNmhpUXQ2QUNFY0l1bi9WblBaUktDN3hmbU95K29UR3Q1Qkhp?=
 =?utf-8?B?ZlF3ZVdlN3h2VHpsV3Y4cnBHYWxxYzhGdDVGQlp0UDlaVlBrUWdMZy9wVWdP?=
 =?utf-8?B?VDdHMEVZcGFQRWFNby9LSHVzWHgyR0VrbkIwVkU1aGNUWGMwdUFWcE5uWkpx?=
 =?utf-8?B?SFpDSTlxaWVEY2pvVEtHaWcyaXNWd1l6ay9PdW5NYTR5TElNOUlZMk5JQyt3?=
 =?utf-8?B?WElTNzJWczYzd2NoMHkyRDBiRkMzTGFra1hwYVEzVlVJOHA5bk1GZDYrdDVk?=
 =?utf-8?B?ZUo4OWlXVG5VbnNKQ3YzSTB1VUpDY3NBWmJvSmpUdmZrWngrdS9yZVphZkdG?=
 =?utf-8?B?YnRrMDBsb3JjZW1aMWhnVEFZSFQ1bTRTazJvY2d6c3Jna3NVNFR6UTVoMGRq?=
 =?utf-8?B?WUt6eTdTdkhEeC9DR2c2MkpnK2t6RVZiOFRxOTkvMzdYT01rTzFsRHpsdGMy?=
 =?utf-8?B?SFIvb2ZUaXNhTklvK3pOWHJUZGFQQWRvaE8vL0h1aWFtWnpUOUFRbDlpTUlr?=
 =?utf-8?B?VlVNVHlQa3pqS3dwd1Q3d2JrQlhJdllsNlpOczhQTnNYVzZ4KzVQNFN2cjVI?=
 =?utf-8?B?ZWdhbVNsNG4rRmlJUTZIWUdKODg5dDc1UDdHYzQxV3MyT09ROXVmNXpKdkFH?=
 =?utf-8?B?cE4xS2p4Vnk0UmpRSkJYelIxZ2Q2R2RKM3JRTEUvandDQnh2ZGFERjJsNGsr?=
 =?utf-8?B?Zng4RCtyUVhwMm5SVDkxWlBndlFmclhBeGV0YjZyaEo3bHpEcGtMWm9RZkJR?=
 =?utf-8?B?cmJING5TOGJQa2wvZWRGK3I3dzRDRkVwQS9ZRy9JcC8vRC93SFFocFYvUmxS?=
 =?utf-8?B?dWhnL0ZtSFNLVnpONklITW1UU1Y2V2t4Z2JpaUlDa1lqU0xCVzhnekdVOUZp?=
 =?utf-8?B?R0lGbWNmeklTMmxaU2JsUDlUWDZSVWc3SDlOcHk5QUwrVHVkY2t2eER6ajZm?=
 =?utf-8?B?UlliS1B0MzZHUTNON2JPQU15QjJMSm5KelJlWnk0WnNZZ2poTEtJV1Y2czA5?=
 =?utf-8?B?VkNUWk56djQvaWtNeUlqZytVUllPbzQ0L3FoRHFZSmpPclhmYSttaTgrZlhx?=
 =?utf-8?B?bmI3NlVpcHkvYUdlc0NaT01BSE9xN3AzYk94Zlg4R0c3SUtTRyswN1MvWWJv?=
 =?utf-8?B?dlZkQktzMDEwSXRtYzc2aURHdEtlazE0UzJyQTVOL2x5Tm1PSlMydWVmSVBt?=
 =?utf-8?B?V1Rzdjkra1FpNXppUXF2dG90cS9hUktySVF2ck41QkhzRkdWZnZ3K0wvWnJL?=
 =?utf-8?B?MXQzNFBOOFlzSEpKL0FSZi9HZXBzNHlLZ3lEZWZ5YTFNazNHUHpzWjFPUHVz?=
 =?utf-8?B?UkNndnFraURWTzAvU0k0MThzYTRhZWh3Nmh6RVZGSzV2S1E3eHh6d1hJNFcz?=
 =?utf-8?B?NlF4ZWFnL25GNitkVmh3ZmxadHJLWXl0b2x4VjNuRHpTbkNLQVVIMC8xL3pD?=
 =?utf-8?B?OXpVa1dsL25raWd3TUU0VVU4cUJYakM5NHJhV0VDMFhpYlRaSnQrNklsbnQy?=
 =?utf-8?B?QXhqZC94a3JVbmYzSjloVDA2NU5VSElYaFYxOVB3dlhmRHhiL0UzRTNkdUQw?=
 =?utf-8?B?RVlFdFVHUDR2anZ6OHNYb3g4STNVanJFUDVKTkJDS3pUbkliV0FyMm9PRkQz?=
 =?utf-8?B?OUx1ZjZPQWIzWUFSKzlkbjNVdVUzcFJTczNEUFpqaWNOL293a1dZQVpNRy9U?=
 =?utf-8?B?bzV1aStOUXdWd1BaaEx6SVV1cHMwL1JWRWVuelc0U3E2ajFJRFI0cnJxRGhx?=
 =?utf-8?B?Y01zOEpiQVhmMitOQ3RLc3dMT2xkc09ZYnNobVRrRDYveFVVeHdBZ0pWT1p4?=
 =?utf-8?B?ZW5UdC9jNXBNeUdJWUxSb1BYeVB5QWQ2Mk9GSU1nemZ3NlljUjJRZWNmZXRD?=
 =?utf-8?B?R0l2dmZZWHE1TnBRbXJRV0RlRnFCYyswbzZtbkZPbjErRFovOGZmT3Ricmxi?=
 =?utf-8?Q?h7RG5AvpcDw/vkOZli?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddf1be6-4b8f-4a75-8b66-08de6800da43
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 17:30:00.6070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suKqAKhz0zEiOrGKahpanUa3ZfESVRYZ2Gqabj+fVR6Mf741+KOMkjOmQ+HqEDuxFvmhZQYUBmtwpsrms4MUUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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



On 1/29/26 17:45, Rodrigo Siqueira wrote:
> On 01/18, Timur Kristóf wrote:
>> Currently DCE doesn't support the overlay cursor, so the
>> dm_crtc_get_cursor_mode() function returns DM_CURSOR_NATIVE_MODE
>> unconditionally. The outcome is that it doesn't check for the
>> conditions that would necessitate the overlay cursor, meaning
>> that it doesn't reject cases where the native cursor mode isn't
>> supported on DCE.
>>
>> Remove the early return from dm_crtc_get_cursor_mode() for
>> DCE and instead let it perform the necessary checks and
>> return DM_CURSOR_OVERLAY_MODE. Add a later check that rejects
>> when DM_CURSOR_OVERLAY_MODE would be used with DCE.
>>
>> Fixes: 1b04dcca4fb1 ("drm/amd/display: Introduce overlay cursor mode")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4600
>> Suggested-by: Leo Li <sunpeng.li@amd.com>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 655c9fcb078a..3e1ba5521f2b 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -12262,10 +12262,9 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
>>   
>>   	/* Overlay cursor not supported on HW before DCN
>>   	 * DCN401 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
>> -	 * as previous DCN generations, so enable native mode on DCN401 in addition to DCE
>> +	 * as previous DCN generations, so enable native mode on DCN401
>>   	 */
>> -	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0 ||
>> -	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
>> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
>>   		*cursor_mode = DM_CURSOR_NATIVE_MODE;
>>   		return 0;
>>   	}
>> @@ -12585,6 +12584,12 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>   		 * need to be added for DC to not disable a plane by mistake
>>   		 */
>>   		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
>> +			if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
>> +				drm_dbg(dev, "Overlay cursor not supported on DCE\n");
>> +				ret = -EINVAL;
>> +				goto fail;
>> +			}
>> +
>>   			ret = drm_atomic_add_affected_planes(state, crtc);
>>   			if (ret)
>>   				goto fail;
>> -- 
>> 2.52.0
>>
> 
> Hi,
> 
> This change lgtm.
> 
> Alex, Dan,
> Could you include this patch in the next week promotion?
> 
> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> 
> Thanks
> 

This was tested in promotion test and no issues were found.
