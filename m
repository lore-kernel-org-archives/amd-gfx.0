Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCED2CA0EC7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 22:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F92F10E7A3;
	Thu, 29 Aug 2024 22:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gBCL5MEO";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10CA110E7A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 22:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnt+HD2YxeluysGMJ1UUAVskcyttZOT+maYYgn0QqlPy3oS9WcHQM6PoCYG22Bkjyj62TtHCaqVyF/owsFX/SuiQC1hs/LGxl0hHpiqwE+78+/iIx0DvNC8deNwjbMcZvTJETeO70vK+mWw5JlvzwqgXk7GlBZbku4WQHyMOHjOIlMAZjHtMV32mtDDur/KB+nuVecUvfJ0eTCeK1ntM//VrVRI0w+k7WWknZnjkIo6lDpylOMa5jl34KIBDwWwWwaF0ax8jO4goDu8qiiP8m57avkWBc0k4hUZrjfMfemfE0SQKJox5HJ2AQaswa7vX3Z+OUU5ROwkRwfdB0BwJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5NU7fgBPCdNs+W8SefwIs9D2emJCsfd+eAtwYwIIgs=;
 b=eGOmwr4D0+oIL4+CPZLofPqrJjUjHnlVRM9IsTd+TSvGTJNSsCS3el56sy077Xpw3+o0h8s4ecHvUEDs1458sdJ12KVghINbsv+lRFf3ozfEVA1ebelbDEGBuu2QkytGYklyAzFTV3JeVpeIkhN1dcTKtKW6jXIDtnBqChVOK9F6pcCgar7eqaWxUwurH49jq1+Ud1oidY/ap+3DovG6AdS7tV1mzDI+i4Y5yhhrCF1m8azJHmn3JGjbXycdqm7FhdIXUnzpsKMoSdpBWKxEhg8fIw/P2RoS9rn+UhC5bXTiuEb9mz2giCFyMiVfoJfxh25V4v3J5ue6Vna1eeMX8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5NU7fgBPCdNs+W8SefwIs9D2emJCsfd+eAtwYwIIgs=;
 b=gBCL5MEO6MeVVnFpEDGQK36dHdcc3JsNSBp4+kFcKK76eUBhfs1O80oRX+TGToIdw7GYWtJ+VipeCJc0QoMbCCInKO9MRwTpdXf4vFms4EzmIz2cbHWznvFDuXbHIdL1AHjbjy9ZvgId0COqQMC6zi2/XgLfo9gg/0sVz4QCZ7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 22:16:50 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 22:16:50 +0000
Message-ID: <83273bfa-7bbf-4eb5-17c0-05d1fa9b72a4@amd.com>
Date: Thu, 29 Aug 2024 18:16:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: restore_process_worker race with GPU reset
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com
References: <20240823194901.25068-1-Philip.Yang@amd.com>
 <1376d3e2-f978-418d-9aee-c8282565d236@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <1376d3e2-f978-418d-9aee-c8282565d236@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::12) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfd1e33-7caf-4d9e-e7a6-08dcc878477b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzlkRnlKRXRrd1ZzSmsyVEkvNDh2REYvamUxODhnaG1iV2NxdEN0WG1QYzRu?=
 =?utf-8?B?WjlmWnpkakJhMmFmT0wzbzdpTDh0TCtpUm5QaEd4cTdZNzErSnRXNWVCekZ6?=
 =?utf-8?B?Njh5Y0xpT1Zham1uVndLMmtzNXM0WklmbXRqTXdaTVhRSC9nVWczTkowcUVF?=
 =?utf-8?B?VFk3VWgzN1JSTGxkalc5dnBtZkpuWTNRZ0lQODA0cUU2MnVvVkgzNEk3ZzM4?=
 =?utf-8?B?WUVTZXJKVnllUXdUVlQ3TUpURlN2dEtZaHBOYzRJYnJkTzJ5bWhKUW16TWRK?=
 =?utf-8?B?QnZwb1d1QmNDOXlVOTFnMUhndEh6WmpZVStuamFHR0pidlZyR2N5djFwZU9w?=
 =?utf-8?B?YmRxdUR4dTY1MmxGTWU0MHkzRUViUzJtT0Q4cUpvcGVzQkpmMmJpRjN3Vkhn?=
 =?utf-8?B?SS82RExmR2hUMUV2YnhmdnJha1d4cUJSd3g2aHA1OXVhY3BXVXhjZHdEL2Z3?=
 =?utf-8?B?QVJneDRUdGRaamQyRWtUOEdVUkNEK3VveHlBZ1JGNFljaktkQTl6YU9SQldR?=
 =?utf-8?B?eXFlWHpVbE50QXB4d3NzTjJDUXMvWmJwQW5FVTZlTlprZXlFK3puYmIrZXRi?=
 =?utf-8?B?T25aSnJGMHR5QW5OMFNxOUdkcjJBaXIzcklHVGhBUzhQM0dBMDJGQ2cwY1B4?=
 =?utf-8?B?YkxJc0lrSGU2dG5sY3BlR3A1N0l0RDRtbkhlWlhKZ2VOUVFBMHhSRzNwRXl6?=
 =?utf-8?B?SzRGVy82ekoyMTY0b1JiR09MUnhPQWRSRTk1cjAyTEUrYmpoZkFCL3c5VFRI?=
 =?utf-8?B?TTlmRklvS0V2ZXRjajdUMS83Ly9NSjJKdzlCTlFZR1FBbEFISjVhSytPMmRx?=
 =?utf-8?B?dzVzOU1YVVc2NU8xb0M5d040SDBRSVNyUlB4bkMzQVZkQ05rNUdEQ0NSSjFB?=
 =?utf-8?B?NmpHbElHRDI0MGZKKzZNMFQ1NnZ1dDErbTRUNlhDN2Z4L2grRHpvTTkra3V2?=
 =?utf-8?B?SExaZG4rWFhWQXZVZFJqVWRaMHA0Zm5reWFlZG1YRnQxSy9VNnlMQW9nY1Nm?=
 =?utf-8?B?cy9adkhPVGkrSTM1dzJuTzdhNEFZQStOcUdCbE5ldGVsT3hFZWpGeWRyV0Vo?=
 =?utf-8?B?Ym1Da3AxTk5UOWtPeWJGRzR0NU5lQWYwdFdyZ0p4cFFiVkdFQlViN2daaU4w?=
 =?utf-8?B?TmtHSDAwR05xUlAwMTU0eTd6L2xudkRwV05sZEROZzBXZE9kSXFubzFNaUpI?=
 =?utf-8?B?aXZGMGFyL2ZNVWlUU1pRdjRkNlB2Z29IdXpUcWlBYVFDQ0dBOXBxcUhNUUFy?=
 =?utf-8?B?SEc1OElLOTlEQjJLNmpQUmZmcEJpUjd4ZDEyTWJEVUVvM2VJeFU3cCt2MHlL?=
 =?utf-8?B?bFcrVTBaZ0VLUGZqWEZiZ0txTXRmQ3B0eG9OUm5lTDB6blUwbGl0clUxcnR4?=
 =?utf-8?B?MDA0Z0lMZEhuT1ZJcVZTOXVYMXVFY0syMysyRFEzRnFZMDJkTURFN29FeW1J?=
 =?utf-8?B?M3FBQXlFU0FpZzlzd3ExK3R0ZUt3N2Y4VjlyVU5Xa2JqU1NzTFdvL1UzVkgz?=
 =?utf-8?B?RE9LNXErcGN1N0RsbDBTNmlHeGRQY1NwS0V1ZXRpQm45b0kwV0JMUERwVEIw?=
 =?utf-8?B?ZUhldk5vTjR4a1IxNEVCRjUzZXJLSk9qMnUvUjFEZzJxQ1NWb1hiWmd0d2Qz?=
 =?utf-8?B?THoxRHN3L0xmcTVJVkhJZmQxc1NmUTdYeTEvTzNMenVIRUE5aVM3OHJNQ0s5?=
 =?utf-8?B?UnNmL04rYjNNZHNOMU1nOU5DMTlabmRyV1dkWmJML05zbFhPT1E2b29HdzRu?=
 =?utf-8?B?Znl0d2FMZTBnV3JxZkNNVVA1WGp5aFRESTE4TFpIYnkwMjN2b0RXOVRDaXE5?=
 =?utf-8?B?SWM0cVZCLy81bGt2RjBjUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JXcE9WbVVzTG1IS1BuTXdOaGZRbE0zUXo3cjFMTk9iN3JLOVNFTE1Zc0Uy?=
 =?utf-8?B?SU9DR0dGVmI3dTFLTGRrR2lEN3o5WldOb2pJWUp4bjBCcUZqTUs1ZkVhd29Y?=
 =?utf-8?B?YmN6REFWWmUwR1FKT3k0Yytlb1hUNXdzYnl6SFlDbDVST3BjZkhpNHNzbXRQ?=
 =?utf-8?B?Zm8zbFlvdm5HVjg4dlBTMWppc1lTeGVlK1l0cGxBaWRPMC85dytCU3BmZ1Ay?=
 =?utf-8?B?b0FLR2EwYVBmUnkyaURqaStsRG9kejNFTUl1ZWtvc1pCTW4yMG5rY3RQd0J5?=
 =?utf-8?B?UlBoRTNCcXgyeXZhVldEZEZ0MWo0M25lclgvZ3NpUSs5L0FFcW4xekFYc0pR?=
 =?utf-8?B?VERlNWhENy83R1M0Z2ZZdEZnbU1IYWhKQ2NlNnFUcDVnSVdyU3JPR3ZzWHly?=
 =?utf-8?B?d0paeEdFVWdxSHRMWUJEWDZjOCtTSHIyK0hVL0ZsS2NGOU1JUnE4bS83UTA2?=
 =?utf-8?B?OEZwQ1pKUndtNlZWdXZwRForc0kzSXZrdFo1Mm0vdFZNelRKZE9la29TdXpa?=
 =?utf-8?B?WVBSbFNTaGU0ejBubGUySnE1bzY5WkhIYkdzcklRQjloWXJDeE1kbllGZy9q?=
 =?utf-8?B?MmJZbjhvdHB6U0tsM3FyaW50bmE3dnpLa2RJQ2FRVU1UeHlBTm1lKy9EaHp5?=
 =?utf-8?B?eHhvcVJWYlJtY2QzakIrZndFOUhWdXFPOUxhRTUwdjNNWkw0Qi8vZlZzUEVs?=
 =?utf-8?B?MVExNU9OcXNsRVpwT0NIRFRuYmkwbUQ5aHZyUmloSHVXWTRuNzFVTWVaU21t?=
 =?utf-8?B?WjlCWVc4ZWVzS1N5bDRVU1lLaGN1ejVpZklDVjh5MXdTMzJNZ2hWRkNoSlEy?=
 =?utf-8?B?dUJJaDRZU2NiT0k4MWJKcWgvcmRnOXd5MFBmKzROQ0JkWGZ0QkdRckZLNjJq?=
 =?utf-8?B?V01IaXJGY3EwTzFwQStiMkxpNGdTWEFQUWowMk1RbzgwOXRsQkNMRytmNUd0?=
 =?utf-8?B?dmdhOFFHUEJTUHN4R09yaE1lcjRzQWxhNGE2cTVOSlJVcnlMMjNCM1ZYYjFJ?=
 =?utf-8?B?RFh1VEZRSDQxekxJR29IRFVuaU92STNsa0dJZldHSUIxNHRqOUY0TTJkL0ZS?=
 =?utf-8?B?aVhLSHRMb3dBOVFTOTdjNTBDRzBLUXVaQ2lWMXFiSWlZZXRBWnRkazgrTVdJ?=
 =?utf-8?B?dll0NWU3UzVYNWdjeFVzT1djU0RZZGg3endXS3ROZ1FxOXE2ZG44elNIVWxC?=
 =?utf-8?B?UU16dFVadEpwZ1llL1gxbUpFQyt5c3gyamxoM1BHTHJ3YWJEbDRyVUpQRk4x?=
 =?utf-8?B?TUs1UVozK2tqclVSaW1CWHBVN083Y1duSnlXWVM5c1loV0VUenpkU1UvNFY2?=
 =?utf-8?B?NzFKTndNc293VVlpSk1zdWtUQ0MzOWZMbmg4ZXVIY1gwS2ZMTy9UMEVRKzFp?=
 =?utf-8?B?OUMwcThndWVucXhKMjE3UkxKY2JkVmh6YUlkeG9UWTlCMTVjV205RS9WOHFJ?=
 =?utf-8?B?MlE1T1BhU3g4dmNCd1A2eVNtcUhFY0MySjFDYmpmVnc2ejBjNzg1YWlUZXhS?=
 =?utf-8?B?UkJCem9JUCtSS1R5OVVqZDRSQk9nVUg5b1VBQk1ESlRVRkw4N3RpY28wWm94?=
 =?utf-8?B?NVp6Q3RtWkdSSDNzdXdNT1I4ZXA2Z2hSK1N2Ny84ZkJFYkJOSjhTVEQ0aFVy?=
 =?utf-8?B?WThIejcrdUQvUDZleU9CUSttaWJWMEtaMUh0Y0x4UHFrREJiaEIrS3F2V3I5?=
 =?utf-8?B?ZVV3NmhJQlM4VnMzRWx0ZUZDZGY0WHJsOGMzcHB4VFNDQTdpODRwWkErbVV2?=
 =?utf-8?B?QVUySTlxeUJmZWZCUzhEMjcxQldXTGxPQS9EQ01jM1Y4MkNiZXlSbU1OUTdF?=
 =?utf-8?B?SENVaVdEN3ZvOWFoYUdxTFBnM2NXRUtGaU5yZWM4bTQ5ZWduaDMwVC9saU5K?=
 =?utf-8?B?M0VlTWY2WFhnRkdWdjYxMGFRWnR6eGs2aGZPSS9FRnRVNWNPL0E0alZHWkQ4?=
 =?utf-8?B?eFgrTk9acmpKSzJVM3lXQzFORi9qbDJpTjlBVVJaOGxWSzFiTEZLYjIrMkZV?=
 =?utf-8?B?MVdqdzZZcXVvZVBnN3h2bjdTckQ2QU5CRFYvWFhXRkp3eStMWGp6VUhqY3Rn?=
 =?utf-8?B?TSt2QncxUE5SMkNiMlkxRnpUWjhqSVY5UStIbFJlUXRPWEMwSGtaVEdJUjZW?=
 =?utf-8?Q?j7mg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfd1e33-7caf-4d9e-e7a6-08dcc878477b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:16:50.2188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ih8f6W9DoTDdzDznSdNZe61pNpY7PUPzyF3Bqb27bNp4tqebD6ujKJnO3axWIRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-08-29 17:15, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1376d3e2-f978-418d-9aee-c8282565d236@amd.com">On
      2024-08-23 15:49, Philip Yang wrote:
      <br>
      <blockquote type="cite">If GPU reset kick in while KFD
        restore_process_worker running, this may
        <br>
        causes different issues, for example below rcu stall warning,
        because
        <br>
        restore work may move BOs and evict queues under VRAM pressure.
        <br>
        <br>
        Fix this race by taking adev reset_domain read semaphore to
        prevent GPU
        <br>
        reset in restore_process_worker, the reset read semaphore can be
        taken
        <br>
        recursively if adev have multiple partitions.
        <br>
        <br>
        Then there is live locking issue if CP hangs while
        <br>
        restore_process_worker runs, then GPU reset wait for semaphore
        to start
        <br>
        and restore_process_worker cannot finish to release semaphore.
        We need
        <br>
        signal eviction fence to solve the live locking if evict queue
        return
        <br>
        -ETIMEOUT (for MES path) or -ETIME (for HWS path) because CP
        hangs,
        <br>
        <br>
        &nbsp; amdgpu 0000:af:00.0: amdgpu: GPU reset(21) succeeded!
        <br>
        &nbsp; rcu: INFO: rcu_sched self-detected stall on CPU
        <br>
        <br>
        &nbsp; Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
        <br>
        &nbsp; Call Trace:
        <br>
        &nbsp;&nbsp; update_process_times+0x94/0xd0
        <br>
        &nbsp; RIP: 0010:amdgpu_vm_handle_moved+0x9a/0x210 [amdgpu]
        <br>
        &nbsp;&nbsp; amdgpu_amdkfd_gpuvm_restore_process_bos+0x3d6/0x7d0 [amdgpu]
        <br>
        &nbsp;&nbsp; restore_process_helper+0x27/0x80 [amdgpu]
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
      </blockquote>
      <br>
      See comments inline. I'd also like Christian to take a look at
      this patch since he's the expert on the reset locking stuff.
      <br>
      <br>
      <br>
      <blockquote type="cite">---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 56
        +++++++++++++++++++++++-
        <br>
        &nbsp; 1 file changed, 55 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index a902950cc060..53a814347522 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -35,6 +35,7 @@
        <br>
        &nbsp; #include &lt;linux/pm_runtime.h&gt;
        <br>
        &nbsp; #include &quot;amdgpu_amdkfd.h&quot;
        <br>
        &nbsp; #include &quot;amdgpu.h&quot;
        <br>
        +#include &quot;amdgpu_reset.h&quot;
        <br>
        &nbsp; &nbsp; struct mm_struct;
        <br>
        &nbsp; @@ -1972,8 +1973,14 @@ static void evict_process_worker(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_restore_queues(p);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Finished evicting pasid 0x%x\n&quot;,
        p-&gt;pasid);
        <br>
        -&nbsp;&nbsp;&nbsp; } else
        <br>
        +&nbsp;&nbsp;&nbsp; } else if (ret == -ETIMEDOUT || ret == -ETIME) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If CP hangs, signal the eviction fence, then
        restore_bo_worker
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * can finish to up_read GPU reset semaphore to start
        GPU reset.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal_eviction_fence(p);
        <br>
        +&nbsp;&nbsp;&nbsp; } else {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Failed to evict queues of pasid 0x%x\n&quot;,
        p-&gt;pasid);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static int restore_process_helper(struct kfd_process *p)
        <br>
        @@ -1997,6 +2004,45 @@ static int restore_process_helper(struct
        kfd_process *p)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; }
        <br>
        &nbsp; +/*
        <br>
        + * kfd_hold_devices_reset_semaphore
        <br>
        + *
        <br>
        + * return:
        <br>
        + *&nbsp;&nbsp; true : hold reset domain semaphore to prevent device reset
        <br>
        + *&nbsp;&nbsp; false: one of the device is resetting or already reset
        <br>
        + *
        <br>
        + */
        <br>
        +static bool kfd_hold_devices_reset_semaphore(struct kfd_process
        *p)
        <br>
      </blockquote>
      <br>
      I find the function naming of these functions (hold/unhold) a bit
      weird. I'd suggest
      kfd_process_trylock_reset_sems/kfd_process_unlock_reset_sems.
      <br>
    </blockquote>
    ok<br>
    <blockquote type="cite" cite="mid:1376d3e2-f978-418d-9aee-c8282565d236@amd.com">
      <br>
      <br>
      <blockquote type="cite">+{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;
        <br>
        +&nbsp;&nbsp;&nbsp; int i;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = p-&gt;pdds[i]-&gt;dev-&gt;adev;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_upread;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; return true;
        <br>
        +
        <br>
        +out_upread:
        <br>
        +&nbsp;&nbsp;&nbsp; while (i--) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = p-&gt;pdds[i]-&gt;dev-&gt;adev;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_domain-&gt;sem);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; return false;
        <br>
        +}
        <br>
        +
        <br>
        +static void kfd_unhold_devices_reset_semaphore(struct
        kfd_process *p)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;
        <br>
        +&nbsp;&nbsp;&nbsp; int i;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; p-&gt;n_pdds; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = p-&gt;pdds[i]-&gt;dev-&gt;adev;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;reset_domain-&gt;sem);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; static void restore_process_worker(struct work_struct *work)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work *dwork;
        <br>
        @@ -2009,6 +2055,12 @@ static void restore_process_worker(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * lifetime of this thread, kfd_process p will be valid
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = container_of(dwork, struct kfd_process, restore_work);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (!kfd_hold_devices_reset_semaphore(p)) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GPU resetting, restore bo and queue
        skipped\n&quot;);
        <br>
      </blockquote>
      <br>
      Should we reschedule the restore worker to make sure it runs again
      after the reset is done?
      <br>
    </blockquote>
    <p>After GPU mode1 reset, user processes already aborted, it is
      meaningless to reschedule restore worker to update GPU mapping.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:1376d3e2-f978-418d-9aee-c8282565d236@amd.com">
      <br>
      Thanks,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Started restoring pasid 0x%x\n&quot;, p-&gt;pasid);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setting last_restore_timestamp before successful
        restoration.
        <br>
        @@ -2031,6 +2083,8 @@ static void restore_process_worker(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_restore_queues(p);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unhold_devices_reset_semaphore(p);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; void kfd_suspend_all_processes(void)
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
