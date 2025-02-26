Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09D3C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 20:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD2510E235;
	Wed, 26 Feb 2025 20:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UcsPOjuB";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F8210E235
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 20:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl8OIKxT6cIgF7nC9MK6c2RHVdfEG7/DpLKQMgVV85hU+Zv6v+DhwPB/nr/vIiIwvjWLPHtlAmu7dnjR8wlcj5furFPBNP1/CxdsGlLShUfCxkdJ/87TUXTd/JXKu5Z1x2InBnhV1hAHsNquckE+F7xYDjKg8Gkbu1MqGVL/uk7VYnWtb/0kYhqXgavaOjxQWyDoOH4aN1JyimYjvU9V6urSJZz0M0pj+5hdSXE9uoYgWIkalAr0an0Ir3UcJstfMaXujxO7xzwkyAjpOQh2xTdQLOO4xbtBqH3qQfGZ//cFTnIbB5yrC3npc+BBTddMtBq1N4N0rAwXz6uco0XwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sn923BKJjwCzQvNLKzfv3a1qeCgBUajBOP2gdQl59YQ=;
 b=ByKjSWJx3Ek40gSawTwaQlEb5GyqXJPtC2WEXz8XJKtP8MRoxh8jSZgqL7H93j8IoqlkFFkyAM923ftZSehBqwgHUCG5r5lAwt9IhKJpDSx/iDT6ZYt8rhep9Br/DszqVjX6ivPOi3SBeKxTvr0uqtWo6ArjntIWvbB29Hl3sJbrE4HMzRurKv23jkIfluJwphGmbf/nmiWZJPg5eJlnvTJEwlix18HmolD+UykqOKYvWMsYQXwHTqoKbERhIF0JTZ8pPhWXFmIElP4KBRq4ciS3smBp/VHdJcidKnfxBeKwwMw0KiVd6PagP5uuaGPNwtlkvlL5obtv+J7Lp+Id0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn923BKJjwCzQvNLKzfv3a1qeCgBUajBOP2gdQl59YQ=;
 b=UcsPOjuB7/Iayjyz8Ir1oqeTHNpmYQM0bxr+4ZCe92QElWSsnd/S2YIaIzp0XzbZ1uSn7PerQ9SbJFnlPpMc3BSHMLS+fqLurfGg6XtGRCFk4hudEuxm7EOUvAUpAKsEH8Ulv+tLEgTwXCOih/Lu8/PDPsZ6obmfrOaDs6zQjAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 20:40:13 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 20:40:13 +0000
Message-ID: <319c9084-a3a0-4e65-a0a7-c7523c288a9c@amd.com>
Date: Wed, 26 Feb 2025 15:40:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Fix mode1 reset test failures
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, lijo.lazar@amd.com
References: <20250226171421.14436-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250226171421.14436-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: d82858f1-5b08-4655-0a49-08dd56a5c515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0ZORTlsTzdtb2IyY0tFc1BWdlhQTTRmMUJseS9DUkxlMHNOcEpsdWliUW1O?=
 =?utf-8?B?OWlqM2g2eFQ2UHdJNEVCV0NIZ3JwOGJ1Qnd5NTlyUklVVURNSDVya2pOVWVr?=
 =?utf-8?B?WThLNldzaUpwdGtCK2ZweDdGWXNZWWdxNHdMTmhCM29xQlhQZFc5RjltQm1E?=
 =?utf-8?B?SGwrN0djZGdoT01zZ1Q0ckQ2dVg4UEc0Y2czVlZzVGZ0bnlmNFEvc1A1Zldu?=
 =?utf-8?B?Mm15OStja1VWZnlrMTJBd2dCSU9VNmVvNDhBVlFWTGx1N2htOC9TNFAzTnhn?=
 =?utf-8?B?NWZQaDM4T3Y0STl5K2xKUXUxcHBMd29ROHU5V3RZdDdaV1NZeHg0YnpSdWRI?=
 =?utf-8?B?UjZINlp4VU5FNTVIUFRXZXhzQWVjVy96M0hsNEN1cVFlRCtkbDNVRCtJa2F6?=
 =?utf-8?B?Uk1vWG41QnJYcVVCWjFCMnh3a2x6K0xGQ2JzOGFRV0drdUJ5Mlg4dDJBdXVY?=
 =?utf-8?B?ekMvaVVRN3FZRFZyTFVlR2k2R1V3VWpkUnlKUGNqNG94bDZ2QzZFazZScFZB?=
 =?utf-8?B?MGxJT1pXblFWMXpXajQzelJqR1lmdGZYaGNONHpWSVJjb3R0aTFjeXl6a042?=
 =?utf-8?B?TEtPSlVmTEJpeHZIL3d2YTFySHVPMkNkSjZtcjRDYWhxa09XTndQYndXei9z?=
 =?utf-8?B?UVByRGlPYjNkUDU2cnJ2dEthZ25mWUREeGpyZGw0T0JEZE41T2REQXE3R2ww?=
 =?utf-8?B?Z1cwL1N5dWxsWHVoT1lBMWRveUIyQXJhemIzV1NuYVJPbjhMaUhjemlVTU9L?=
 =?utf-8?B?WlN0NUxpVmlNV040dlVHVVB4TzUyS05tc29lNjc5SGtVQk51QS9JbWdBS3dt?=
 =?utf-8?B?OWIySGpMaE9xNXdmY0FGamtlRTZ6bzE5ZnFVVmFiN2Nrb1g2dlVwK3NONm1B?=
 =?utf-8?B?WEh0MlNCcm1rM3F3YmNGV3V4Z2tVMDJHY3dmZm94emNWNlAway8xOUZWZHkz?=
 =?utf-8?B?REhkR3ZJT1BpRFFKNzFjcG5vNS9DREdKSkVsa2ZYVG94TUZBbENxQXplelMw?=
 =?utf-8?B?SGJJT3ZIR2RFUXNBUHZseWRZcUdmam1XTEhBcENwKytEMHBiUzlLMFdsR2hD?=
 =?utf-8?B?elFyd1JzcCtkOGN3alFtcEdLbkVDMHJjVThMbzM4VzlYbXdIKzlPbEhFYUwz?=
 =?utf-8?B?aXN4RWw1bE1lT0g0UjdiOFV1TWZrcTN0OGpVbVp0MU52RVYxUGRoanRRU09u?=
 =?utf-8?B?cWk2c2hZTTJBY0NzWGxPcEoxSkl6WHpxVlRXNjYzdWV0dzFNUW5lSGRvZmNh?=
 =?utf-8?B?MXNHSGREQzljK2M0aU4rWVAvOUl5c0VGOXZid2hQRDlHV0VwWU8xRkZNd2Qr?=
 =?utf-8?B?SG5LWWFZN2RJSFFJOXlJczFPY1k0VElpdzVsa3BUcWJCbTgva3RoRXp4NW4w?=
 =?utf-8?B?SXFXK01vNW5hM2dhSXV0Q2ZjSkNjdUZEOVdhV0lwRTMxeVpHUVlHVXYyMWd0?=
 =?utf-8?B?eitERmtDRVJLeGQxVE5OQWF4UG5MaUJST2tndGMzVUt2MkJSYmVRU0twenpJ?=
 =?utf-8?B?eWJKelVaeFFYS0sxcW13dDZLbkx4WGFqSVJ5NkN3RXRvV2JOOGpOSUpqZFZq?=
 =?utf-8?B?b2xqVEtsMTVOSGk4RThDTXJIR0tOSGdJWmtEdlZUWnlmRmtTWlA1OGcrRGlB?=
 =?utf-8?B?bHAybUNVYllidnNJMDNDVkZCQkZYWEsxMVlmNzFqQTRqbnRPT0JDN3UwWE9k?=
 =?utf-8?B?eEhuMmNxa2k2Ris5ZVNhL3doRE4veDg2RUhkVklWbE5wTDcwQlhqbFJEbGg1?=
 =?utf-8?B?RHh6RGdYZUtmeVNmQ3ZwTTYvWDQxcmIyUDE3U0loZ0xHY2ZVcUNQa1pwMDlr?=
 =?utf-8?B?YnZPWUxQZVdWVUFaNVZ0Z2NlVGRjSzhVUVVxVWY4WElURDBMekI5RmVGMDVh?=
 =?utf-8?Q?eI37QI7GlU+hm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFVnVVR6OVpoWThJZjJRMjRvbS9pQmtkYmYyeHZZUmlobG5IL1IxY2pnR3Jm?=
 =?utf-8?B?eWdkQWR5ZnpIV3Z2cThpMUxKbXJaWHU5QzNKM2NjejY3Vmg5QWVPdmF4K2Mz?=
 =?utf-8?B?VWNLNU5oWEIvd2RaV3F2SFk4RzJ3a1dvU2RRclZHUnNJbVkveWNxWk85OEJo?=
 =?utf-8?B?eUIyM3pIV2hCcjlHdk9xbno3SFJaMVlWTCtOWFhsaG1RSDBFN1BmVWttWjFX?=
 =?utf-8?B?SHJOOTQ5UjF3RmdPMWQ4MWREUjV3dlFwNTgwUEsrcnRaakNIaElTM3BYN2lQ?=
 =?utf-8?B?dTZHVVhtTmFEamltdWxDVUxHUk9KbW1ES3hnaWs0YjVHd08yY1NsWGtXd2w5?=
 =?utf-8?B?WGNkRUJoY0xkTVh2MHFYVWtTUUliTE9qZG5vVVphVEJQT1FiSTJ3RzlOK1hG?=
 =?utf-8?B?bHRJelFBQlJEOXovQ0tkUmRxWWpmWU9oajRqeWtTak00TjlyYnZ5aGZpL2Ry?=
 =?utf-8?B?NXB2N3FYdUlUMndIc1N3akVyOU9iZ0VIbXJXQUJUVzNycWNUWWxBbzcyOGJv?=
 =?utf-8?B?Y0h5Y2xMUmtMM2V1cENDSXB5cmROcTZPZ3VTRkREeDJGbjBoQWNDSWNzR3l6?=
 =?utf-8?B?d3ZJWDI0RmZ1SWpWWnBLbzZtcnVwanRVZE5laTRpVXBHdUdhaDMzeGovZUVl?=
 =?utf-8?B?K2FrdDB3U250VVF3MndnNStDV1BzQ1Z3T1JBVnlLQVpiYmZrYmpmMUs1amZH?=
 =?utf-8?B?UnhjcExmRVVhd0M5dDJOc3JORmN1YVlTaW5veUhPWW1Eelpud1lKa2hMU0Fl?=
 =?utf-8?B?aW1ITVYvZm9pbmQwc2NodnpqVnAzUVNZMjB5YW1qdG9sOFpRM3RIZ3d6cUJ6?=
 =?utf-8?B?KytiU09wcVVtankrTjhRUFFsVWpib0hmT1h4Y250L01UdVBOd0NTU1lzSGhm?=
 =?utf-8?B?MTZRWlZySjNQUWI5a0tGYW9BWEpDeXdKeWZWUlVpWVdrR0xSOFViUkYrbjRZ?=
 =?utf-8?B?NFhzeDJNRzRaaVRlakIzb2lVbXhXVTBEclc1V25NeGFIU0FrSm1LeUZtQU8r?=
 =?utf-8?B?SVFMQ1F1aG5hV0JWTWxBTFFzWFJKd2pkaWsyeENMTHp2cURSNDZEYmlzQTAy?=
 =?utf-8?B?ckhtYVpEeUFhTVZTK2xqM3dzTkErV1JDaEdYZFR1Q2tuQVFJSlBPRU8yOWJE?=
 =?utf-8?B?YmIweDhKUTQ1aXB5T0x5YTErWmNaU3BYcks4bjF1dVNlRDR0OWVjOGEvNlRz?=
 =?utf-8?B?b1VhUU1yWjZsQmJydCtuY3ZLWEFhZVc4NjZlQXhKVHpLRFZHWk1MaVU4cXk4?=
 =?utf-8?B?Qk9vaUpwalNzOEJPZ29Bd09zM2pFTnhWNTJ2YzJvRTRBTWZRclRPNkF3bWFD?=
 =?utf-8?B?Ym5UN0RFQnNKVmEwNHJqQ0cwZk5PM0ZNbzhpaXFQZm4yaDJhVHJYZGtWSG9Y?=
 =?utf-8?B?aVFtQjEzazRmT0lhMG1IUW5hUThJVEJhdlZoSkt5dWJZMVZyQWo3Z1JiS0ow?=
 =?utf-8?B?dEVjUlcyM2lESDlldnU2alRDK245d1E1cVRhV1dUalNOSTZPTUx2SUZXbmov?=
 =?utf-8?B?T2owVzE0SWNWb3hKei9iS1pKYm4rVXVQeUk0YktibUMrNks0SnlmTVBNbnZC?=
 =?utf-8?B?cTF6SEYrUks1WXVSd1FRclVaZS9YZ2xTd0NYNndOQVUvZC9VQ2tBajdtZTFP?=
 =?utf-8?B?c0pnc0kvbFlqeStOTHpoeGM5TzZKYTdONEgrV0paNTB2R0d0S3dkN3U3cGNu?=
 =?utf-8?B?WkJUUjZrdzV6YXIwVW0rQkdLTjhTeTFSa0Z6dDlReUR0NTZSd28vTXlFQnZw?=
 =?utf-8?B?YnlxdlRJMVh4ay8rU0VZRVc4aGVqRjRKcjdtVHVwTzJ1MzhyNVBXdmVRanlZ?=
 =?utf-8?B?MU03dHFBYXlPR3VUNTlqbzRDRmhxRW1NV1JRa1M0eno4dDkyUk5mN2E1UFdV?=
 =?utf-8?B?eFR3NURRNGxhaFdFR2JoSWcwYlpSRGRLejVMQ3pHWUdqK1NpNEkrKzF5QmFR?=
 =?utf-8?B?dUdIc0ZMU01BdUg1TUsyckxTUnQrMHpRVUNpdFFXU1grOHNtS0t2K0pka1Vy?=
 =?utf-8?B?bENlRUhES29zWXR4d1NBbUJ3RnV6d3RvanZWclF2eEl6VzNXVGdDVDRrZlU5?=
 =?utf-8?B?SzBtRjVvMlJsVUkxZXRmTHI4dEw2bmtRSDJMZHBuOGNGSzJTU0YzOS8zazNM?=
 =?utf-8?Q?UPVdTSewaHmElkoIg+RWXWI/E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82858f1-5b08-4655-0a49-08dd56a5c515
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:40:13.4611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdlYghjMopGzyc190JaNg6mvzgdfDcNkUc8/EqlfkTtedIdycmEIQwfAv6AtWREOj9qXBefBNVTyG3A8PjdQ4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
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

The series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


On 2025-02-26 12:14, Philip Yang wrote:
> mode1 reset test running with compute applications trigger many different
> failures, such as machine reboot, kernel crash with general protection fault,
> NULL pointer access or cpu page fault etc from random calling backtrace.
>
> With KASAN and slub_debug enabled kernel, we capture slub left-redzone
> overwrtten warning, but no KASAN warning before crash. This can confirm there is
> system memory overwritten from GPU, not from CPU.
>
> Change hanghws test to evict user queues first, then do mode1 reset test, no
> crash anymore, this can confirm the system memory overwritten by user queues.
> Because the user queues keep using GPU while KFD cleanup worker free the
> outstanding BOs, the freed system memory is allocated and reused to create job,
> resource. Then the data structure is corrupted by user queue and cause crash.
>
> The fix is in KFD cleanup worker, after evicting all user queues, flush
> reset_domain->wq to ensure ongoing mode1 reset is done or user queues are
> evicted, then free outstanding BOs.
>
> Philip Yang (5):
>    drm/amdkfd: Remove kfd_process_hw_exception worker
>    drm/amdkfd: KFD release_work possible circular locking
>    drm/amdkfd: Fix mode1 reset crash issue
>    drm/amdkfd: Fix pqm_destroy_queue race with GPU reset
>    drm/amdkfd: debugfs hang_hws skip GPU with MES
>
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 +++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 33 ++++++++++++++-----
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
>   5 files changed, 32 insertions(+), 20 deletions(-)
>
