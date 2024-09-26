Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA198CCFA15
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 05:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A0F8952F;
	Thu, 26 Sep 2024 05:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TIjt+ddN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D226510EA9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 05:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkgymBN8u9aK5h1OB6vVx+Dwmf6AT2nh5C0+LOiSeauPT/rIh+1A9x9zmDWD9HICijMx+62JjkyPpPU9y+7J0s8hTG7Yko1kjntX+3lvcyTsjBwMtYZlA9G9zOPeqpqp+uSxuLzDNslf3AsLM2oVn/TMVule4rFbUD4ELeCsYDselrttGaNCWFmk7sy3ughfRImAlthF0x9f+z2xPUNZivu2KOEl20baEzISoFJMYFJQJ/sNoSyXL3L6QH46cgFR6pkQxPipUY5F+5hqBtNQ3w7ab3iUImFLpImqIG6DLOF6ohyKTL/q0v8HnaW7hsW4XUWOnxQT18bgLEuPnh/oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zEw/QtTgHP8TsIZy1uHvHg+YI5oMQSZrx0fn9Ar8tc=;
 b=b6timDlJKzLt0ykHxYUizvy99A27byo+icbkzcjewe4Hawj+QprXiMf/WA+oEkX0gTAgWlKhUaE6L3XGz/PWGuG42PZKUJjjVK/t5hJqKr2EJqO6Gt3Bs4ZrWbksX3/8PO4LAcsSHUp327uEbDwGOuNCpp/iHo/lCuCCR2TZ6fdnQGrhziNfIqg0kP5C0+kxS6VAq35hXCKsIxpSA8UOgksgbhAitPMiaHUk3BQNyAJiU0ucbQi6RZQGHxFtgquNJFR7agmq/DHxu3XIScUDZGihHKoTAE4olFvdqpIq5cFyG/fyivhkRh+kJ6jS3yBSVMRrqer5Ncdlw+RRdrKx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zEw/QtTgHP8TsIZy1uHvHg+YI5oMQSZrx0fn9Ar8tc=;
 b=TIjt+ddN8ayXCmFywWh/PYP6BxH3mJVC0tLSzmCH1oAQIxeQow6U++bfKSYG1R/J5XLnRvIJj4lx9ljUe96Ij+b5ll/kmwerGcPCtjxTIYEsHkXnHY+OpFcYhX66ESFvWR0VpBlV1PesPhUCDS5ct9F59CBVDmc8pQORJwWYqZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 05:09:33 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 05:09:33 +0000
Message-ID: <a085a690-5d17-470a-8403-e54113fd6075@amd.com>
Date: Thu, 26 Sep 2024 10:39:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add support for dynamic NPS switch
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, rajneesh.bhardwaj@amd.com, Ramesh.Errabolu@amd.com
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20240924055652.2678433-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a829c1-b9f0-416d-a037-08dcdde9686f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVo3bDR6UGU3M2RwazhFbVI1Njdhb1F4clJ3VkxQQlVJRlNRVGpLeXhvRTNB?=
 =?utf-8?B?WTd5RTdUdHFIeHpMS21mQjlyYXJrdFNWRk14dmx4U25UMjJuWmU0anY1b2kz?=
 =?utf-8?B?eHljSWRMeXZ3M2hLSVV1M2pJbDl6NWxkRmVtcFRXMm9jK2lvS3hXdjh5V2VW?=
 =?utf-8?B?dHRodkRrZ2NYWFhMc0hkMFhWOUNaczlhNldyNTdQQ0lFWWhwWnFxMXJsb0NZ?=
 =?utf-8?B?akVZaUdURmNja1ViWFlRb0tGZ1FCV1VteTZ0SDJEYTZCcFNCckIvMW9IMnVo?=
 =?utf-8?B?UDc1RlI1TTF4bFU3RGJzc0ZkbmMwekI1WFR2dTJaVmtaYm0xd093MWxsbmlm?=
 =?utf-8?B?aFlYWXJjVVhteGZrdUlNVS9zdSsxb1RGZmtiZmEzOE1yQlNXTzRUUytZTGRq?=
 =?utf-8?B?blNHM0h0WnhzUFZVelFLWWhqdHNzMlZrbXMzamxUd3ZrdEJYYlhERUV1bVhm?=
 =?utf-8?B?M25JQlU2ZXhOZVp5R3ZLZTlHSkROSnNtejBCSm5nMzEzOE9qanYzeThCNFNT?=
 =?utf-8?B?Q1AxRTlxMWpkeEoxaGtOMDVuT242UDcreHdTdU05VkxJdkh5bHpzZDAzTlZi?=
 =?utf-8?B?WFpJbWVrY2FGcG51V3Jndm5zUjE2VTNnZHpGU1p0TlNOdHljbmdWT252cHIw?=
 =?utf-8?B?VW44RHk0MHJna0cvRTMxQjMvSFluKzNPOEpFK0d1aklwelJ0dEVyUWV6NXpt?=
 =?utf-8?B?ZUhzdmN5dXpnbHFZOEhZbVlxUFNhUVRDOUFMaExUTVpmaVVGMTZMN0FnYnRw?=
 =?utf-8?B?Nm1FcnNrTDhKQWphQkhHeDJQNThUbU9GZkRsdXh2c0hpbVc5QjNyK3IzZ0h3?=
 =?utf-8?B?SDBJSlFlNzd3cStpenNoWmZ1dlk5bGdQOG00M1Z4WWhuMlZLejhldWZFRHZ5?=
 =?utf-8?B?VEVoalJQMjh6eTlzUUVlVzRSQVlKclVFekpDbUl1Qjhkdm1GTVl5YTFzYm40?=
 =?utf-8?B?bnJ2WThWZjAxTjdKbWFXWC92UC9Udk5nZWFFKzRweVJSaGNPdWo4Qnp5TDkr?=
 =?utf-8?B?WFV0UnROSjROWnhoa3Z1eTB0RU1xQ2hlbXRKNHNRSnJGR2FLbmlhbTNTRGpl?=
 =?utf-8?B?ekpHNlpMUFoydXA5YUdXc3lrWXhFQXR2TW9kQkFKYmMzUHVDOUoweE5WR2ZP?=
 =?utf-8?B?aWt4Nm03K3pWY0xUem5Ldi9QS01sVCtQVE51QlR4c24wclpNRFAwN3BPLzdV?=
 =?utf-8?B?V3cyMXZoY1hOREhwK0ZnNWhRVnNIUDlhakhIbWRjRkcvUWZtSFg4WDNDbVdH?=
 =?utf-8?B?a1ZKK1cyRWx0dzQ5cWNHRGgxelVkMmRKekI4TTY5bTRHR1h3Zkw3U1U3MDgw?=
 =?utf-8?B?QURYZW93ZGpMT0crKzVEM21YdGRXNk5yUWZ0UnFmU280QmlyZ0pqZTN1dlA5?=
 =?utf-8?B?RkJQQUphc25xS29NRjUvWDNURzRTdGxpeXR2OTZpN1VGN09JdExYbkcvSEZD?=
 =?utf-8?B?OVArM1lUNU9kUTZ6ZmszREhZeEJ6dEtZckZYZmVjVzNNWTk1a0RNTzAwSUhn?=
 =?utf-8?B?MEtMSml4OUcrMlQ5OHJkdXRrQWFqZndydUI2VWljVGRkOXh6cHlMOW5wUjFh?=
 =?utf-8?B?MlFnNHdsNGlDKzFTOVJDTmR5dnZ5TVYzYm83YW5XMzZ2RFV3QTlKMWZYTG40?=
 =?utf-8?B?MTBJcGFCdExjcHlyYm9vRmVUc0hPZWxac2dJT2QyNU50QzE3eXJpNWc4VDEr?=
 =?utf-8?B?ZGlMZlVteUM3TUtRZ1dTUmlYaTNYaEJOZUtqdjlBUm0zUkNhNVlmaWI4UTFE?=
 =?utf-8?B?OG9jbk15ZVNHTHFiNGZzL3VzekN3SGJzSUpRVjRzMVdBVU1iTWh1dlIrQTI1?=
 =?utf-8?B?SEl2Y2ZINEFUbmRPQ0daZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzhYMHp5RUo3WEIyRTloLytGUG1odjl1MjNJa3NJUE9oN21RSmpuWmNqU1FR?=
 =?utf-8?B?R0s3ZGR0ekdsRk52UEU3b3hIWXltQlVMcXBEVzIvNk9zWEkzNStvSnN1RzR4?=
 =?utf-8?B?aVNLTHBTckNQeWlWWUVOQXJMU0cybVpWR0pUWVp2a2lMUmdnYmQycTdlMjEr?=
 =?utf-8?B?Wk1DVVNpdmJ2NTRNdTZkMzZ6VTBvK0UwM0s0N2hmVWVtaVNSaUY0Yis4KzlL?=
 =?utf-8?B?RmdPUzdnbnp3OU01V3NDU1IrSTd6ZGtQRWlNdDJURXYwMGJOTEJCa1FvVFQz?=
 =?utf-8?B?Myt5UDNZVFc2Q3NVZkxENDN6S25Sei9CWVAvblhCR2l2akQzM2dIY1cwVUNH?=
 =?utf-8?B?SVQ2NUJRZFdpOXhPN2Z3ZEpxT0VidU15VURkY3V0U0NWWEhIZUFoRnl3dnJn?=
 =?utf-8?B?UWtFZjZ1cEJGMml1ZnZ0b3FRL2JMQ0tYZ1ZGZHhMWlU5Mkx5RjRXeTBkeEdk?=
 =?utf-8?B?dmt1dHpJUzNka1FIcDE4N2pVRjdNU1FwV0RxZTNaS3A2NFBmYkxWM1gzNXRB?=
 =?utf-8?B?L0VKaGNUOGU5NGxpbkVaVHJkTWdEMDJIVXBxMmMzdm9IbjZYRTU4WnBCTC9B?=
 =?utf-8?B?alNNSC85RFhaSG5QVktrb2NrNXFkZ29qWjd2YktQdDBhMmMvdXRMY29FanUw?=
 =?utf-8?B?VXkzb0FmWmhhd1BGQXpZWGthK29iTjQyWWVlem9QY1cyTWtLWlRDYjJseFJw?=
 =?utf-8?B?RGpscTlhNkt6VThzWFVrd1YvZDdsMXlsbjZqZXJ2UTcwRTN6Z0NrMmhrUWFG?=
 =?utf-8?B?SmI1cVBxRlVNRW1jU3QzKzJqK2UzQmU3WDV1cWZUTFYrUGd3M3IzMlFDTklN?=
 =?utf-8?B?bjZmRStXOUFhQjdrMHFzM1NUc3BXdFhYTmM2OUc1WHBEVDBCcDBHTXNsSy9Y?=
 =?utf-8?B?NS9WMTl2Y05HQ0RkeWMxeXRydXRkb29HUjR4YnRZVm54Q0hRUzB6dllmL1dl?=
 =?utf-8?B?aEdEMTV1VEFNNFFHYWIxUTJ6K2lTUDVSaGlDeWlVYWdrTE81ZjVJUWh4bWdZ?=
 =?utf-8?B?RFVCY0hyQ2cwMitVbjRyYzdQWnhwcS9HL2RRL0RTMVRhaEFCa050bHh2RUI5?=
 =?utf-8?B?L1VrYXRUYU1kR09yUzNNWVQ5TXE1WmNOaXZTNzBxSG05SVVPQ0ptQmJQcEJl?=
 =?utf-8?B?R0NZd0lYak5uSFpTVHRzRHZtdjd1aFRQdC9KOVVFTHphTHU4QUVkdmo0WTZ4?=
 =?utf-8?B?dE93NnozMkhyTnRxcE5sbXJmVjh0OStZakkvbWZFd3c4RmFMSm4zTjFySy9G?=
 =?utf-8?B?RkFtZnJZT3l5SGdmaDZPRHV0K1FSWVFtMUpXWmlLc3BWWXlwaFRUR2lOY1Bn?=
 =?utf-8?B?Q0grdGNGSkkrR3RLYWpta2tDMXl2SlNJZWNPNVhzeVk5TzhFNklOOWN0STI3?=
 =?utf-8?B?WXAvcUlmelRHRGZsOXg2V0FScTRCVkt1UHpNcXZsSVErMmN5TzBJTlpWaVAy?=
 =?utf-8?B?bmdZcjZaSWtJZGtxWUx3UDBpTXNDYzZPaEZTeFZ2MHlqQXQ5eXVmL1kwYVlU?=
 =?utf-8?B?ejFkcmIrNDVvemNzNWZZd1hyTDJHdlB5QWF0VHJXRVRERTljTEVkV1ZyenVK?=
 =?utf-8?B?TFBsQUljdE9IUHkyNUtPWDFJMzdybldyQjdIYk1VMWkvNWdjeHREOURVZlhP?=
 =?utf-8?B?S3R6ZUNCUUNtNFB2TUI3RjJyM2FscGgzVkhUWjM1Z3dBZXBZZ3UrT2FlenZS?=
 =?utf-8?B?SlhQbDg2WC84Sm1KcmFqRnFmNnBLTGx5UTBGS0ozcVRVanBpblhjMEhCeWhH?=
 =?utf-8?B?TkRJamRyUGhpek5pSkIwRUV4eFRJS2JqV3NKKytCYUZiNmUwVmlIcms3Uk1x?=
 =?utf-8?B?L0N3TE9CdFhVenYxcjNzK0JFUUU4dmx3Yk5hY1NXVUdqaUF0VU9GVkx4QzVl?=
 =?utf-8?B?Q0Jpdlc3eFFDSm5VOTVaTFlETHdTNVdnTkNzV3JLdE9sNk5wRjEwVkg3UDRN?=
 =?utf-8?B?SEhTcEhadVZXUnNYQXg5Z0I0aGs0UnNneklSZ2dWRVNFNWR1dXo3dFowU2kr?=
 =?utf-8?B?STBZU3hCY2dnQ1dnL2F3THM3UFowYy83RzFYUnlZd0dkc1E2bndCMHZrc2c4?=
 =?utf-8?B?YkJaRHBza0NEbzYyZnJoOUF4N0Fya2F3U0tSc2hzQTdwVjNBdHdDc2VETk0x?=
 =?utf-8?Q?Rz9aAIP/YevCOegqb51qN0dDo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a829c1-b9f0-416d-a037-08dcdde9686f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 05:09:33.2068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1JKaFnihUm98muWUoQC09p4WmFKczuAzJUE/U2KM9TrF1X7iMxJF3UwgMV+gdVb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
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

<Ping>

Thanks,
Lijo

On 9/24/2024 11:26 AM, Lijo Lazar wrote:
> This series adds supports for dynamic NPS switch on GC v9.4.3/9.4.4 SOC
> variants. 
> 
> In order to do dynamic NPS switch a sysfs interface is provided to request a new
> NPS mode. If the device is part of a hive, all hive devices are required to be
> in the same NPS mode. Hence a hive device request is saved in a hive variable.
> For individual device, it's saved in a gmc block variable.
> 
> In order to do a NPS mode switch, the workflow is -
> 
> 1) User places a requests through sysfs node.
> 2) User unloads the driver
> 3) During unload, driver checks for any pending NPS switch request. If any
> request is pending, it places the request to PSP FW. 
> 4) For a hive, request is placed in one-go for all devices in the hive. If
> one of the requests fails, a request is placed again to revert to current NPS
> mode on the successful devices.
> 5) User reloads the driver.
> 6) On reload, driver checks if NPS switch is pending and initiates a mode-1
> reset.
> 7) During resume after a reset, NPS ranges are read again from discovery table.
> 8) Driver detects the new NPS mode and makes a compatible compute partition mode
> switch if required.
> 
> Lijo Lazar (7):
>   drm/amdgpu: Add option to refresh NPS data
>   drm/amdgpu: Add PSP interface for NPS switch
>   drm/amdgpu: Add gmc interface to request NPS mode
>   drm/amdgpu: Add sysfs interfaces for NPS mode
>   drm/amdgpu: Place NPS mode request on unload
>   drm/amdgpu: Check gmc requirement for reset on init
>   drm/amdgpu: Add NPS switch support for GC 9.4.3
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  68 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 190 ++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  19 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  25 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  39 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |   5 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  44 ++++
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |  12 ++
>  drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  14 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +
>  14 files changed, 387 insertions(+), 36 deletions(-)
> 
