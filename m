Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4D0D3000A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 13:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C721310E931;
	Fri, 18 Oct 2024 13:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35Bu2wNB";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A743010E931
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 13:38:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKOi2a52WIxQlV3ap/sJZGEUmSgUajxGZd4ZKlK5RaV++B3ye4bysv5htsAcbFpSZ7sqevQYWULQ/wwO6P334+aM0q9v50L7gdw0a7KFJWAIQT3c6OjN9sigVrDfSb0XCkVVif5RDptkzctrbr4qT3qnHy4S5mJ5Qvptz8721jE4KiPDZRxuzRJqInVS4d7yJvDNe7Mnc7c0MeIsLJYLjlqxyVtChcFE/ggZp91I9Y5H8jWCNXf6jGrTSximI8S+ZuEkh8cZLkq/lMBvvrS/WM0NFmuqZPiu+ai7iGisT2hUIBVln2i9DTnCvwUk2BUaT9xzzQolDCRPxKXacgHh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WEh+Z1nGzOLc6XXp26b5UlBVqE2bRoEFPSkiW5Pxh8=;
 b=EG50pxeAb/K96l8iQC7yeBcfzlHFIMq2BMfeM2D/5OUWNS8BIOMuKoFoPWF3SfmGpGcqo8cLO9vpUiT5UF60NeS1jixahI6SLREin1ACDkzElJTrT/kLDe5RQ9CjVcHHkBHepNLnL8YkZOZVKpElE2QPeX02kdDZNI5YGz4E+AeE9yHhzFoPVyzVmDY08shKibquC8SOigdhshOolWaVsGlM6QMyUIP8OE5qFjK3ftoYpLvP3MKDBZhAXX+Q+CmH02zmJq1xO16wuqtn71a7vFpXTgpQd79rbm2nX3eohVnbBtts3acIqJE6YXzQBZB4Nv5CE9q2WDgeXVNIP77xQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WEh+Z1nGzOLc6XXp26b5UlBVqE2bRoEFPSkiW5Pxh8=;
 b=35Bu2wNB6edsFkMXnQ1QP4R5oYQ7kZyxFWmL6aN5X3Znj0tzHV2pTus4R9LE08LX0Xo8HyqT3Fw90y8aRnw/HBgu+ozufMK4YSAN7OBCBYOP/NtkrgwvJerwh9cgLoDAVl8cUIrqfxxnTY+ESxD4pdgNurgTC5Q4bDo2EC6Ners=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 18 Oct
 2024 13:38:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:38:27 +0000
Message-ID: <6339ba5b-70f3-47b6-8989-5fbff8edec14@amd.com>
Date: Fri, 18 Oct 2024 15:38:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] validate/clean the functions of ip funcs
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241018132327.1638247-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241018132327.1638247-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: a1183692-2554-408e-26f8-08dcef7a2582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGFLQityWGN2L254b2k0RGllZVY4dWFoR0pITEN3cE9GQ3NFTElUYlB0YVYw?=
 =?utf-8?B?cm1pb2hiaUJ3SzNPNUM0aXhYWmRsdVViK2VRRm5CVmdUbmJNS0xldzY3TVBC?=
 =?utf-8?B?WVBnOUZpV2xhT01vbTAvSkQwYi9VandQRGN2aWpkQUVIWHA2eXg0bTlDQXZn?=
 =?utf-8?B?VmJaNGZ3V3JFeGp4SVRKZE9RSHlIVkMzcVozSlFpQXlFMC9DajZCdlRmWUgz?=
 =?utf-8?B?TkdtSVNpbmxBU28wOUtncDNsdFVra2JEanNqay95UW51eENlMFk5OWs1RDhY?=
 =?utf-8?B?UC9ORi9ZU29BazQ3UmlWRGF6UkUrL2JHZFhvMUp5alBNbHRrbmtBOS9QTk5p?=
 =?utf-8?B?c21vY2dGZytRa2lwUHJCZEYydC9EZFhGZmJCcDNTN0hFQmpMdTZlcHd6bnpT?=
 =?utf-8?B?SzdyNnZ0QVoyYWM3MzhzY0U5UHpxUGdwSkhEVGxmNWN1bisvM0JsSnFkcnJI?=
 =?utf-8?B?L3pJa0d5WmxrZGg3SnVRQzdOb01vVGNkMFhXcEFuZEFDSmh4UlhuNmdnYUdv?=
 =?utf-8?B?aTNSUmhtdVNSSDV1dStDZDhSVW55UThwS1ZtTUN3ZXFOMGxWRXVXMStaWW9E?=
 =?utf-8?B?ZDdtd0FyZ28yZm9BT3JYeU9DWHpjcURnRlE4QWY0d2VHb1hPeWRvOXVQWUxK?=
 =?utf-8?B?Wi9XM2VYOXVrbWhpVURBcll2WWdsdVdka2hpQ2dmS3Y3STZQNlJoOVIyNDNJ?=
 =?utf-8?B?alZ5RjNQcnhvQzRiZmlpY0c0WVZLN3kzMWUweU83NmEvOXdqcGZEQ0lsMllZ?=
 =?utf-8?B?eEltbHh1cEJ0cm1rWnlSUjR0ZlY4Tncrc2JRR0tsbXZmWnprUUZhMXpiOWYw?=
 =?utf-8?B?TGlIOFJXZDB3SU5ody95a240MklIUFFvR3NGWjZnd1FZT3MvSEVSeTlXaWhU?=
 =?utf-8?B?Qk10dTB1cVZDcmU0LzI4NzZWTE5hUEpoUkp4RjBybE1mZEJkUDVMQXo5bC80?=
 =?utf-8?B?ak9uMmFjSzRXYW03RytEQjhzbVFtQ2kwSzdpUnFvUGVDd3NtNHRJM1JOa2NZ?=
 =?utf-8?B?UmlibDlSaWJzUzJIS2xHZWRHaTRDRGd6REZ2alpsQ1pKY0FtZExqWm1RN3FU?=
 =?utf-8?B?UEpKQmxxcHJpTzAvbkV5ZkRVRS9BcXVuQVREd05RZGpVSzZKVmpQNHlsYm1W?=
 =?utf-8?B?VmlyWFJ3Y3J5Y09ienpHbzFtM1NCOEhRSE9WSkxJeHprdnl2THhCRUU2MkJs?=
 =?utf-8?B?RFFSOHdGWEZiSU1JVUZvamZwSkY4eTkrSlRlNXFOdGR0eEJHR1hCOUJKQkwy?=
 =?utf-8?B?Q3lIamlJVGwvQ05EdFpDREdVMWpKcWViSmhJWkxEOUtXU1FvdG5RTzNYV1Zo?=
 =?utf-8?B?UXROL3Uyb1dVL2p4ZlNmOEkxUEMwZUxzWlA4cVBudVlpOXZqM204N2tLYXJS?=
 =?utf-8?B?Sll2c2NkUUhidG5xVjNUaDE0b1lYTlVuNUgrOCt0RkZscmpvL2o1VkNEcEtN?=
 =?utf-8?B?YW9Mb1pnb1V3V1FyRTZ6aVBKY3RpVWc2YmFUSC93M2tNMGJ5NCs0UW13Nk1n?=
 =?utf-8?B?b0lIYlI4cnJ5QXBQVDEyUGxsUFN6NDBQeVhyVnRoWFhHc2RoVkJnN3FGeVdp?=
 =?utf-8?B?RG10TnEvWG0zTzRxOGl5c1ZyZnZpanFmeW1WNnFPam9WMVRoMXFkVkxFajFM?=
 =?utf-8?B?dHlYSFo1dUhkZDBlT0Y4bWhFaDhVckN6R3ZYaTdOZWN2bFNWTUFQR1dZV3F5?=
 =?utf-8?B?TmxkRk1BSVJKZDhNaVZjSXFDMVlaRmNtcGN1cXc1VmpPQnh1VnJVSnpEdFpD?=
 =?utf-8?Q?fuJTy0EfQG+Eh1CpOV+7OWWmcRxx4/lLrVNrPKM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3grQUVaYnlVNmRuNTJSWjhyMzZYaDJPOHVwcXlObHlQNEpLRU56eDRuUHF2?=
 =?utf-8?B?V2ZVSzFoajRlTlhsN0N6ZTJKdC9tYUtHdHdTVkE2NjZFbnFxUFpUZzZVTUF5?=
 =?utf-8?B?NkJBVnBWdnpZL2lCSEZLTFhmMWxDNDhHdWYxMTduMlQyeUdiUk55cnpuMDZz?=
 =?utf-8?B?aUhPYjlSRG8xczIyTjdNcHJ3TWppa05ENVdoMmdBWHVrYkRoYUFPcFYvQjZv?=
 =?utf-8?B?cWZickNPcVdEQzNEZTM5Y29mYXBVOXIyeEVtdHZ0UzI0NzdGbUlmSG1aTjdv?=
 =?utf-8?B?d1haTkM3VDN4WVRIUHdNTXFjSExiVHFNNWdpV0ExMHdmdEhMTXZYNm45SzV6?=
 =?utf-8?B?N2M5SEVIRXpPRVRYWjFaNUxnbFgrMGhkSmY2M0h0SXZrVkU3akk3c2JxWTg4?=
 =?utf-8?B?ZmRGNGFhWHhyY0pDRjBGN3FLZFd5SCtFa1N5cnlnUEcwL2N0YXBBbnJldjQw?=
 =?utf-8?B?UnFCYWN2eWkyRU15QWF0Vnl5cytySWs1NUQ3Uk8zcmdqSlJ4NHBLenpBQytU?=
 =?utf-8?B?OFlzYWJ2SEtEc1BaWmgvck1rRHBMV1BVNU9yTTRuSzJEalkwN2YvZjJXZUdD?=
 =?utf-8?B?QVh5Y3RBY3ZkcFNMckdINXVXMlJJQ0FIajZNV2xEMklWN2J2c2RFNDZTTHdQ?=
 =?utf-8?B?MFBWZkJ1clRIZ2JPVkxxb3JOZTB2YmVmYW5sRTBrcmxrZHFkU1dHUlh6VWVY?=
 =?utf-8?B?YklmOFVWN2xjbDFzMkh0RFB4T01UU0lSZHRtRWpEYzZUc3ExeVIyMzZVbXVD?=
 =?utf-8?B?UU1ORnZyU1RURitNVWRDM0MySXFXdXRxVXp2d2EwTXByU1lmQUxpdXd3NUt5?=
 =?utf-8?B?bnl6VkE3U2lIM0Rob29JTUdtNUU3Nk42MUwxeGY4S2pBams4SnVQQ0loeTZa?=
 =?utf-8?B?cmJGUEJPNmR0TjlXSVV1N2ZsNEJTWisxdXlqNTl3ZWJDa0NoVXhzbjJaVXk3?=
 =?utf-8?B?bzBLbFludW5yeEJVTURFS1J1dXZOaDRlaFdDZW42MFNER01ldzkvdkxzbWZN?=
 =?utf-8?B?UnRRMk0xNzBZZ3paVmNiUmFVY0EyUjZ0SWZpZkdLZi9ZTy9HbEtzdi9LVGpO?=
 =?utf-8?B?a0o4YWY4WTVBbXJTc0kyZlhNclZuTjRZL3Z4Wkh1dmk2VnlaS1FUVE00SkND?=
 =?utf-8?B?cmNpUW9Kajc1ZXU2a0lVcmFYK1p1Mi9hUlJlSG92NHdoaGdoOW9ZTUtuM3dH?=
 =?utf-8?B?S0FSWEVCQjJZbUhwRU9oSk5wY25HMmhPNU5yenBmaFFsYnAra3lUTmhDM09p?=
 =?utf-8?B?aWNXR25CWVA2L1h1T2xndTYwTXVUZEtET3VVdE9ZTGlZU2NRbk5FQUNSWUdr?=
 =?utf-8?B?Zk1aWXdHQUFpYnhxOS9oVHg0a0NXMnIrWWZNSWJvVC9ORjV1YnAzTE5MQlBS?=
 =?utf-8?B?MlQ5WkRKajcxZTBuZ2Y3Sk9aMXd3SGFqRDZFZXZCVC93Z2hhck5EUjRtRVo5?=
 =?utf-8?B?SGVXeit1QW1MOEdselJZaU0ya1dZTEUrMzh5UzB3dkVYSnMrRnBqR2hONXZI?=
 =?utf-8?B?ZEozbEJTNys3TFJzTnhacTc5ejhIMVZyUXdzMit1UjhXYjMzWFh6bCthMEhj?=
 =?utf-8?B?amQ3eEYrRDBqWGs3amtGRWhPTDAzeXI2UmJMNkt2eUpWemJQMWtJNXBSZXdB?=
 =?utf-8?B?NC9RcnBWOVUrdGoxSmhlRVZCeVdvZ2NCNGVPRWVBUUh6c3BRbzZ3eUpPYzlJ?=
 =?utf-8?B?QWNOUGw2N0xrTGhsTTZDdG50T2IrRThETUQyNDBiTGxoTDdaNlA3ZFJZY2NH?=
 =?utf-8?B?RXN4TnZscTNBR0hmZVE3RkNEQ1R3QmppR3U2SmlXUG5ObDdMMU9pTHFKMFV4?=
 =?utf-8?B?MTJBc0p6MGVHY1VsK2g4ZE9xNHo5eHlBOCtUcU5qWEQwSmt0MURhTUljWEdK?=
 =?utf-8?B?MGZYYjNCNFZ3T3dxbzEwZzUwUmlnVlFLVEFqV1ZFS3lnWXJQc0ZWVk13QUtI?=
 =?utf-8?B?NUhrWU5oeTVLUWFMc1J6ZWVyWlhaOXk5Q0RmNGgzT0JFTGxEWHZ3U2J4UnlW?=
 =?utf-8?B?WVBLWWZESmRCcmZGWG8ydkNMcFpMenJ1NHZML0ZqY29qRFJPaFRwM3JvdWNi?=
 =?utf-8?B?d0gwblF4VEpsVWV1TzVBcDVnTHlzdDBmZU4vUFc5ODFGTDBXUUZZcFhlV29U?=
 =?utf-8?Q?IQTQePjhiihxti5Mtav61OtMu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1183692-2554-408e-26f8-08dcef7a2582
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:38:27.5701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9dWV2XyypQQuUS6OHt6cLEe6MpMv5VKr47gQWJWesxnvcZx0otrfKP86APmwD0p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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

Patches #2, #3 and #12 are Acked-by: Christian König 
<christian.koenig@amd.com>

The rest are Reviewed-by: Christian König <christian.koenig@amd.com>

Maybe give others till Monday to take a look as well, could be that 
Alex, Lijo or somebody else point out that we are ignoring the suspend 
return code during XGMI hive reset for a good reason.

If nobody objects by Monday feel free to commit the whole series.

Thanks,
Christian.

Am 18.10.24 um 15:23 schrieb Sunil Khatri:
> v6: Fixed the missing return statement on suspend and update the code
>      with V5 comments.
>
> v5: Fixed review comments. Dropped hw_fini patch and need to look
>      further why such functions exists. hw_init/hw_fini are mandatory
>      functions and we should have a valid definition.
>
> v4: hw_init/hw_fini functions are mandatory and raise error message if
>      these functions are not defined.
>
> v3: Added 2 new patches to clean get_clocking_state and hw_init
>      validation.
>
> Sunil Khatri (12):
>    drm/amdgpu: validate hw_fini before function call
>    drm/amdgpu: return error if phase2 suspend fails
>    drm/amdgpu: return error on suspend failure
>    drm/amdgpu: validate suspend before function call
>    drm/amdgpu: validate resume before function call
>    drm/amdgpu: validate wait_for_idle before function call
>    drm/amdgpu: clean the dummy resume functions
>    drm/amdgpu: clean the dummy suspend functions
>    drm/amdgpu: clean the dummy wait_for_idle functions
>    drm/amdgpu: clean the dummy soft_reset functions
>    drm/amdgpu: Clean the functions pointer set as NULL
>    drm/amdgpu: clean unused functions of uvd/vcn/vce
>
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  24 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |  16 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 150 ++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  25 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |   2 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  19 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   2 -
>   drivers/gpu/drm/amd/amdgpu/cik.c              |  15 +-
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   3 -
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   3 -
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |   9 -
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |   9 -
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |   9 -
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |   9 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   9 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   6 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   6 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   6 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   2 -
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   3 -
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   3 -
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   3 -
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   3 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  14 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   7 -
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   7 -
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   2 -
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   3 -
>   drivers/gpu/drm/amd/amdgpu/nv.c               |  14 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |   3 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   3 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/si.c               |  21 --
>   drivers/gpu/drm/amd/amdgpu/si_dma.c           |   3 -
>   drivers/gpu/drm/amd/amdgpu/si_ih.c            |   3 -
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  30 +-
>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  20 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  14 -
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  14 -
>   drivers/gpu/drm/amd/amdgpu/soc24.c            |  12 -
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 275 ------------------
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   3 -
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 274 -----------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  10 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |   5 -
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   1 -
>   drivers/gpu/drm/amd/amdgpu/vi.c               |  14 -
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 -
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  15 -
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   8 -
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  14 -
>   78 files changed, 114 insertions(+), 1122 deletions(-)
>

