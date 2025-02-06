Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A882C0219C
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 22:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E80710E995;
	Thu,  6 Feb 2025 22:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SN00s7XQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA4010E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 21:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWr9A2kB98j4CdUkdjI9Sx5GDdJwIzIiZ+NZyBe4mxWCJld3I7dgfIlUwaehxoeqpwDc51PI1Wqe/vgsmjKCI8+eo8lYFMki+pLsrN7xaRmjG+Zwp9gU40r4mMP/Pbz7FsMyA88gUXvdFBDLp/5UkKyYUfN3tHtnvVNPEvTlAOX8Gl4GJWNOsAuy0s9FLGYPN8vUEbpkjJBhvLc4CdeZPgQT+aR83MZYVk4k32CEsP7nhs/mzN3HMdjVZvCNdqol9xVsNiuJGCgSS3VOW4PyXD0PcMffK9x4IwhAhhQFxIgl7B1wEjO9vKJuoYO5NkiFy3jtqAyqAbNmTCydYOsgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqWayDLFyhpeNs51EahQVKGKDwFJ5QJ6JmAJU3mGO8g=;
 b=TmW1ycstcTIUwEf2Bzsg/iQjG9kPLyVuKf0znu3aOhR93E73jxsaoYz8fDmVyplEdhotjQ+XRcsF4FWyBoVh0wOCHLnGZTpRWP16wR9n+2AUvKwqxJkhF5a6WjsPzorkiqQZi5YRIyuPwTNiKg8C9aeNF1Sm2SKxUnns8OJtZzKLaPbnEgR4wrEdZL8pquUxwv/NWh2QG3JpR6h/xotHOk+VQOzGcgo98fQgsbNulp8BVdKxtNU2mfx8s4kTpFYnlZhlIvV3mhnpsNoOkB/1uPbNYIoRIi+pLPSKliugTyUq6Yj4qqPlO6YEpMXtRxKNTYs8bN3iELNKdhJtnhAiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqWayDLFyhpeNs51EahQVKGKDwFJ5QJ6JmAJU3mGO8g=;
 b=SN00s7XQyDfH/IONKq0SIKi6hlksAfrJZeCAbgnbZuFoI0MqVxHx+BBNL5P8KUAEus8hVmjjDo7WmLTmgEUPhznYyn+NLVrnXSiS2aPmcJBAfmfSoqP9nXp4X5OeuAnPBKHYq99zlwjdNxRXZaeiUS+UV/duVzdEDcjSf8Dz0Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Thu, 6 Feb 2025 21:56:23 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 21:56:23 +0000
Content-Type: multipart/alternative;
 boundary="------------N8PzaZEvr9QrA2D5eNp5qLGq"
Message-ID: <f95bfa89-ddd2-4dc8-9bb3-d2b04dd441d0@amd.com>
Date: Thu, 6 Feb 2025 15:56:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdkfd: Use asic specific fn to configure grace
 period
To: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
References: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
X-ClientProxiedBy: SN7PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:806:126::10) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f41200-a449-4f3c-81f5-08dd46f918c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkVaRHBSQm4vVzROYURtUTczSy9FUlBUT25sQ2JpYjFvMVhQaStMK3Z1T3JJ?=
 =?utf-8?B?eDlyS2pOL2R1ZGtjdzJMTCtjVmZXdS9WVHdWWktCUXhCeUF5U3NrTDh1RmJn?=
 =?utf-8?B?U3ZKeUNDb3FqdnVoVUpiOGVqN0hhZ1VrbHN3SDE3T1RBVVV0RVowNzVQR05l?=
 =?utf-8?B?TzY3ZDMxOHRldDZoSHZONnZkL2JVN293ZUFBaHdwUlFNckhrWHltMDJSOGxO?=
 =?utf-8?B?RjR2WU5VNTVVaTU3WlZCazJyRUdLRzd2Y2F0QjVOMEVoUUN6UVU2OGFFS3dy?=
 =?utf-8?B?NExxVTY1SFUyTWxJZFc1eWFJeEp3eVV1VXZ5aVM5UkhyRE1OOFlJY3RFR1VR?=
 =?utf-8?B?SExDeGxydUcxUW4zcDdSNTZLT0NJQmI3TVlXUk1NMlVQZUFWa2dFVTZqTWJV?=
 =?utf-8?B?d3NwWmNraVN6dlVrUDdHNnNMbElReWhKNE1SZy9xM3diUTVUTXhIbGI2eTNi?=
 =?utf-8?B?YzJNQlF5UVlhMmpYNHJDRjJaOEdRalJRWWpUK1NjSzU0WEpNa2tvdVRPa2dk?=
 =?utf-8?B?cTZibk1LRlppZmFjV3loOXZ2UVNVUDFCUC9UWEI2b1pxZW1HVk4wWEZHenNE?=
 =?utf-8?B?U0g5alBsWm5jWkpvVDdQNmF0NmM3UGtzb0tIRjdubmgrN0dRNFBlTEVpb096?=
 =?utf-8?B?ZDFmaWFEL29VdDJWY2RYZTNydFJNM3JBd0NhV0JxdHhIbkEzTUVoRTZlMVJW?=
 =?utf-8?B?cE1CaGhEdUxZZmdhNnpwSkJiMDE0V1poZ3pYSmJRWXJuenlNUVdTUmdMSEtv?=
 =?utf-8?B?OUJ3K3ltMkFZNnhOZkE4Sm9BUEVFK0c0d0FVTTNtMExXdU4vdlFCWERSR05Z?=
 =?utf-8?B?OGUzc0ZGWkVSOEtYZktVMmpRT0FUTjFDY1pDWktZVllIeFlOVGdNR0VWNmFi?=
 =?utf-8?B?Ym16VUw4aGszVU8yNnlqU3hjSmQxR3dRTFgvNW5GUG8rTGY0OWxhME8xRm1V?=
 =?utf-8?B?SGVhMmxLNHkyWkU1VFVUbjhIaHJ4RFJIeGt4MndlQ2Y0NW1lZjhlM2I3Z1NO?=
 =?utf-8?B?ZHdnbUJyYjJLUEZEdE1kSURaS0l1M3paWXh3b0VYRG1BVzUwSW1sV3pHTlpp?=
 =?utf-8?B?eXVxZWpKbnF0K3NoREc1NWVjSkNmb1pOa3lNZU5tQmp1ZTRnZUo1QU1qYkoy?=
 =?utf-8?B?NTZlNHRoSWFNem8wT1RScVhHVW92K1BkYUtuQWlaRUttMG9MVUpVTEZzOFdY?=
 =?utf-8?B?Qy9rRm01QmkzQkZ3SS9mcUVLQytzVCtJRVRUQlFEMXd4U3lYazYxVzdPQ2Zu?=
 =?utf-8?B?UDlTUXozUUVIMnFOdzhCK2FxN1Rxa1VwWUp6NGprOTdqY0dSbGg4WVI5QUIr?=
 =?utf-8?B?Q0pCbkVlNjd2MjY4V3FqbnN5UXgvRTdQVFJ3M0tJaGZBdzJDdWtyWTdsa1Np?=
 =?utf-8?B?cG52cEQzSnc0M2Z1dlYrN1FTeWt2Zm0xdkViS0pYZXoyc1h2bTVkKzdGbitx?=
 =?utf-8?B?VHRJMDczVDBwN0paNFZ1OTZIUERHNStxZWtFWElyeHJRWStaakVUbWRKSGNx?=
 =?utf-8?B?M0ZOempuTnM1QWowVk5aMElnWFhNaHl2YzllVHVpdlRCWGRQdE5seHhiWXlE?=
 =?utf-8?B?dkpaQzBBdE1CZUZoY25mSEk1R2dIT2RXRCtUZEZSaWxRaDlWQmkwb05GNzRk?=
 =?utf-8?B?bWNkVUxtWlRYczM0SzBnbVREbXZFTTk3Ym1aK2RUTXJHY25xYjlVd29rUzlR?=
 =?utf-8?B?K1R1TXE5TlIzeUI1cFR2V0FMdTRBZmduS2pmcm9rQ2ZULzRiVVVUTXgxcVg0?=
 =?utf-8?B?YmxVK3BpMGtWQnIzRmJiT3ZPeERhTXp1TG11VTNKMW8va3g2WjFxeDdMOGIz?=
 =?utf-8?B?UWRLazluSGpjSmV4YldiKzc5TGgrY04yVnhvQk0wL280S0RRWnlCM2tpNlI1?=
 =?utf-8?Q?pwWtTmUiH8YrR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0VwZG9PNlZHZ2NoVkROcWVlUk1vV3VFZHBkdGRTcVpKSUpBc2hwY3dVQWx1?=
 =?utf-8?B?ZHNPSjVCcTR3dVJxeWt3YWdOaHJ4eC8zY1UrV1ZUamh3UkI1SWhtOXNiN0o2?=
 =?utf-8?B?b21hN0h4NDlaVTdjc1oydWJTTFZzSmY4NXErUkVIR09hTFJQR0dUME5VdWYz?=
 =?utf-8?B?TnBxeElmZnRrNzlIZ0xzdlh3a3E0anpvSEhpbWYxNTJQcVprTzNrRHJlUFNh?=
 =?utf-8?B?eDNpbXpQTUROVkNEU05FTjY4M1U4ejR0TmZScjllbWlJWlZKNkRqcmd4U3ls?=
 =?utf-8?B?T2ZIYnQrQmxyV3k1bzVGaG5SU2dKc1FiLzNZa2piWmwzUzd6VTREQnlMUXAz?=
 =?utf-8?B?UDVZd1BoWkc2L3BpWEZqK0pzRFAza1Q1dG1GTTRETi9iV0kzZ1N0anBkSUJs?=
 =?utf-8?B?Q3pQc0dVY1BKcWNrNy8zamNHVDFHRzRTWGd3aXk3RHNFTlhjd0pRaWFsR2ZT?=
 =?utf-8?B?eG9tb2g4UlVFejhFTTdmbDVVYmR6TGpsR0hhZGFVVG8vMUd1V0lZZjcreUVn?=
 =?utf-8?B?VmFRYS8rZWpiaGQ4RWhVYVl6V3RxOFRjSlcrVXUyVktjMnBzRm1uNXlobGN2?=
 =?utf-8?B?emRWdENsSnFPRExocjFkazIvSEQzMlQxakRBVDlQUGFRdmExM1FRemFLZ0Jm?=
 =?utf-8?B?S01QMFE4b3BaMDh2UXdSUkJOcTE3VzZGc2VvblNkZGl6VEI2cks0RVFrSWFp?=
 =?utf-8?B?TCttMTdmc043dE5sOVBWa3p4YkFrTXZoSGJXeDhjQXVnaFZNUmV6cXRIcUVF?=
 =?utf-8?B?MUFSY1Z2VzJQRGU3dk16TVJqN2tBa0xFNEE4ckIwcEQ1R3hZZTU3eUREQVZZ?=
 =?utf-8?B?bDk0VnpwV1BKM09RVUtuMGgrK2kzU1dyOVFVZ1Z4U05xRmE0Smpjd1FOUE9w?=
 =?utf-8?B?UzRiR3hwejBsWkZ4T1JtMG40NUsxRUxQaVdBbkZEdXlpa240b1V5SHBQNzlv?=
 =?utf-8?B?OEpYajdRVWdqejFOZW5ibzNuR2lURGJGemtnMTI2VWF2WUZicWZ1c0hDSFk1?=
 =?utf-8?B?WFBVdkNuamg1WDhrUHdoT1Y1UjM3NHE5aDA5Y0pGVHdURnJTcitQS0FhMGZS?=
 =?utf-8?B?ZUVtZHVyc1FXcDlvVElycDNhb2hKam5oWUNaMUJjZk8xdDE1ejZOUEZQNFpM?=
 =?utf-8?B?WHNGVUV5dWxtdlBpODFSL1VicjVuQXFlQnpaaXQvSzh0RkJVSFhyTVV6K3N5?=
 =?utf-8?B?THFzTysyWFB5WTNRWUh2QWlRcENvV0lGR0Z4dU1nN2lLajVzRGFFWlVERTE4?=
 =?utf-8?B?OUNxRU5sdzRmWGcxdm1xZ01KaU8vNHpLTEcyNWdaN2lhVDZlZUlFeVViUjVR?=
 =?utf-8?B?MjBiWHVkWmV6T1dEY0lRTHMzYUZCYlB0ZGk3enp2ODdXTzU0T29ldU5Icncw?=
 =?utf-8?B?U0crZnoyeVVaUXdNVjBuRklYcU5WRkd6OXBjYStqMXh0NnA2UHNxWDY5UFZJ?=
 =?utf-8?B?d0xCSThKYUxGZkp2YVZqWVo0UXd2UlZwR2JKT1lvWStRYUowK3lnRk54SWZp?=
 =?utf-8?B?NjJPVFIvN2xoTTQ1dmxhWkQ2Znc5ckQ4WWRpa3BYMDltODdCYVYxVWZqVFhD?=
 =?utf-8?B?c0ZiRzgvZHFQeWRvMFBtQkI2K0lZTnJiRDFVOGlsS3dRU1Jjc3BnOWoyYml4?=
 =?utf-8?B?MDl2ZmhpWTBERTdjN3YremlDMHdMOTlpc21LMlFNeGtvclFlQi95aThoUHNO?=
 =?utf-8?B?WjFxU1pVVm9PUGtCTDBLVXZaekY0eUVrOThXdDAwdGExSHZ5SnFzTlVMVnlo?=
 =?utf-8?B?d1pKeHlJNUNvL3dFWk8wZ0g4ME5hT1lIWENMd1RLcU13QWJreHFUd09tRjFq?=
 =?utf-8?B?S3drMXZKbjBGSkUzUUlPeUpBYlRoaEFGQXNoV2QwekNzMitmVGxjTitneDJt?=
 =?utf-8?B?MzRQV3NNejhBZkk1NVJxZUVCR3N0UHN5WjM2RkFQMDB5b2t4S1Q1TUZhemlT?=
 =?utf-8?B?bmdBRDNSSW5xQmtIWnl6blBJalVxRytVRkhwc0ZXSE9POEErd1l1WWRELzlP?=
 =?utf-8?B?dWhzTkQ1K1V2dHlmdWNra21VcXJxbHpYQTZkMTlRblVHNWtBbXFNaW5xc1Zh?=
 =?utf-8?B?OXdDbXgzemExWE96MTd2SXlUS2txWVY1YitXcVJTakpvRmdxQ0pVWUpQd3kx?=
 =?utf-8?Q?k290=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f41200-a449-4f3c-81f5-08dd46f918c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 21:56:23.4440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHDCcEvXGsUEyz5SBWGx/npXg/VBmROs8ysYlwrsFki37klDo3vp2G9aWmThBahP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
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

--------------N8PzaZEvr9QrA2D5eNp5qLGq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/14/2025 1:52 PM, Elena Sakhnovitch wrote:
> From: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
>
> Currently, grace period is modified only for gfx943 APU. In the future
> this might need to be set for other ASICs too. Either ways, asic
> specific values should be handled by asic specific functions.
>
> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
> Signed-off-by: Elena Sakhnovitch<Elena.Sakhnovitch@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 24 ++++++-------------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 ++-
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  3 +++
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 10 ++++++++
>   4 files changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f157494bfdb1..4369308a74e7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1859,26 +1859,16 @@ static int start_cpsch(struct device_queue_manager *dqm)
>   	/* clear hang status when driver try to start the hw scheduler */
>   	dqm->sched_running = true;
>   
> -	if (!dqm->dev->kfd->shared_resources.enable_mes)
> +	if (!dqm->dev->kfd->shared_resources.enable_mes) {
>   		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
> -
> -	/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
> -	if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
> -	    (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))) {
> -		uint32_t reg_offset = 0;
> -		uint32_t grace_period = 1;
> -
> -		retval = pm_update_grace_period(&dqm->packet_mgr,
> -						grace_period);
> +		retval = pm_update_grace_period(&dqm->packet_mgr, SET_ASIC_OPTIMIZED_GRACE_PERIOD);
>   		if (retval)
> -			dev_err(dev, "Setting grace timeout failed\n");
> -		else if (dqm->dev->kfd2kgd->build_grace_period_packet_info)
> -			/* Update dqm->wait_times maintained in software */
> -			dqm->dev->kfd2kgd->build_grace_period_packet_info(
> -					dqm->dev->adev,	dqm->wait_times,
> -					grace_period, &reg_offset,
> -					&dqm->wait_times);
> +			dev_err(dev, "Setting optimized grace timeout failed\n");
>   	}
> +	if (dqm->dev->kfd2kgd->get_iq_wait_times)
> +		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> +					&dqm->wait_times,
> +					ffs(dqm->dev->xcc_mask) - 1);
why put it here? it seems not related to this patch.
>   
>   	/* setup per-queue reset detection buffer  */
>   	num_hw_queue_slots =  dqm->dev->kfd->shared_resources.num_queue_per_pipe *
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 09ab36f8e8c6..fb3419993612 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -37,7 +37,8 @@
>   
>   #define KFD_MES_PROCESS_QUANTUM		100000
>   #define KFD_MES_GANG_QUANTUM		10000
> -#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
> +#define USE_DEFAULT_GRACE_PERIOD	0xffffffff
what is difference between the two lines above, or just add spaces?
> +#define SET_ASIC_OPTIMIZED_GRACE_PERIOD	0xfffffffe
>   
>   struct device_process_node {
>   	struct qcm_process_device *qpd;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 4984b41cd372..518c6ec23a75 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -403,6 +403,9 @@ int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
>   	int retval = 0;
>   	uint32_t *buffer, size;
>   
> +	if (!pm->pmf->set_grace_period || !pm->pmf->set_grace_period_size)
> +		return 0;
> +
>   	size = pm->pmf->set_grace_period_size;
>   
>   	mutex_lock(&pm->lock);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index d56525201155..fde212242129 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -302,9 +302,19 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
>   		uint32_t grace_period)
>   {
>   	struct pm4_mec_write_data_mmio *packet;
> +	struct device_queue_manager *dqm = pm->dqm;
>   	uint32_t reg_offset = 0;
>   	uint32_t reg_data = 0;
>   
> +	if (grace_period == SET_ASIC_OPTIMIZED_GRACE_PERIOD) {
this patch purpose is setting grace_period at asic specific file. Do we 
need check "grace_period == SET_ASIC_OPTIMIZED_GRACE_PERIOD"? I think we 
can set grace_period directly at asic specific file.
> +		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
> +		if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
> +		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
> +			grace_period = 1;
> +		else
> +			return 0;

why return 0 here? that skip following build_grace_period_packet_info 
for no-GFX9.4.3 AP. As above, set grace_period directly is more straight 
forward at asic specific file.

Regards

Xiaogang

> +	}
> +
>   	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>   			pm->dqm->dev->adev,
>   			pm->dqm->wait_times,
--------------N8PzaZEvr9QrA2D5eNp5qLGq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/14/2025 1:52 PM, Elena Sakhnovitch
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250114195251.42661-1-Elena.Sakhnovitch@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>

Currently, grace period is modified only for gfx943 APU. In the future
this might need to be set for other ASICs too. Either ways, asic
specific values should be handled by asic specific functions.

Signed-off-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
Signed-off-by: Elena Sakhnovitch <a class="moz-txt-link-rfc2396E" href="mailto:Elena.Sakhnovitch@amd.com">&lt;Elena.Sakhnovitch@amd.com&gt;</a>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 24 ++++++-------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  3 +++
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 10 ++++++++
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f157494bfdb1..4369308a74e7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1859,26 +1859,16 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	/* clear hang status when driver try to start the hw scheduler */
 	dqm-&gt;sched_running = true;
 
-	if (!dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes)
+	if (!dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes) {
 		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
-
-	/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
-	if (amdgpu_emu_mode == 0 &amp;&amp; dqm-&gt;dev-&gt;adev-&gt;gmc.is_app_apu &amp;&amp;
-	    (KFD_GC_VERSION(dqm-&gt;dev) == IP_VERSION(9, 4, 3))) {
-		uint32_t reg_offset = 0;
-		uint32_t grace_period = 1;
-
-		retval = pm_update_grace_period(&amp;dqm-&gt;packet_mgr,
-						grace_period);
+		retval = pm_update_grace_period(&amp;dqm-&gt;packet_mgr, SET_ASIC_OPTIMIZED_GRACE_PERIOD);
 		if (retval)
-			dev_err(dev, &quot;Setting grace timeout failed\n&quot;);
-		else if (dqm-&gt;dev-&gt;kfd2kgd-&gt;build_grace_period_packet_info)
-			/* Update dqm-&gt;wait_times maintained in software */
-			dqm-&gt;dev-&gt;kfd2kgd-&gt;build_grace_period_packet_info(
-					dqm-&gt;dev-&gt;adev,	dqm-&gt;wait_times,
-					grace_period, &amp;reg_offset,
-					&amp;dqm-&gt;wait_times);
+			dev_err(dev, &quot;Setting optimized grace timeout failed\n&quot;);
 	}
+	if (dqm-&gt;dev-&gt;kfd2kgd-&gt;get_iq_wait_times)
+		dqm-&gt;dev-&gt;kfd2kgd-&gt;get_iq_wait_times(dqm-&gt;dev-&gt;adev,
+					&amp;dqm-&gt;wait_times,
+					ffs(dqm-&gt;dev-&gt;xcc_mask) - 1);</pre>
    </blockquote>
    why put it here? it seems not related to this patch.<br>
    <blockquote type="cite" cite="mid:20250114195251.42661-1-Elena.Sakhnovitch@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
 	/* setup per-queue reset detection buffer  */
 	num_hw_queue_slots =  dqm-&gt;dev-&gt;kfd-&gt;shared_resources.num_queue_per_pipe *
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 09ab36f8e8c6..fb3419993612 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -37,7 +37,8 @@
 
 #define KFD_MES_PROCESS_QUANTUM		100000
 #define KFD_MES_GANG_QUANTUM		10000
-#define USE_DEFAULT_GRACE_PERIOD 0xffffffff
+#define USE_DEFAULT_GRACE_PERIOD	0xffffffff</pre>
    </blockquote>
    what is difference between the two lines above, or just add spaces?<br>
    <blockquote type="cite" cite="mid:20250114195251.42661-1-Elena.Sakhnovitch@amd.com">
      <pre wrap="" class="moz-quote-pre">
+#define SET_ASIC_OPTIMIZED_GRACE_PERIOD	0xfffffffe
 
 struct device_process_node {
 	struct qcm_process_device *qpd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 4984b41cd372..518c6ec23a75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -403,6 +403,9 @@ int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_period)
 	int retval = 0;
 	uint32_t *buffer, size;
 
+	if (!pm-&gt;pmf-&gt;set_grace_period || !pm-&gt;pmf-&gt;set_grace_period_size)
+		return 0;
+
 	size = pm-&gt;pmf-&gt;set_grace_period_size;
 
 	mutex_lock(&amp;pm-&gt;lock);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index d56525201155..fde212242129 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -302,9 +302,19 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 		uint32_t grace_period)
 {
 	struct pm4_mec_write_data_mmio *packet;
+	struct device_queue_manager *dqm = pm-&gt;dqm;
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
 
+	if (grace_period == SET_ASIC_OPTIMIZED_GRACE_PERIOD) {</pre>
    </blockquote>
    this patch purpose is setting <span style="white-space: pre-wrap">grace_period </span>at
    asic specific file. Do we need check &quot;<span style="white-space: pre-wrap">grace_period == SET_ASIC_OPTIMIZED_GRACE_PERIOD</span>&quot;?
    I think we can set grace_period directly at asic specific file.<br>
    <blockquote type="cite" cite="mid:20250114195251.42661-1-Elena.Sakhnovitch@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
+		if (amdgpu_emu_mode == 0 &amp;&amp; dqm-&gt;dev-&gt;adev-&gt;gmc.is_app_apu &amp;&amp;
+		    KFD_GC_VERSION(dqm-&gt;dev) == IP_VERSION(9, 4, 3))
+			grace_period = 1;
+		else
+			return 0;</pre>
    </blockquote>
    <p>why return 0 here? that skip following <span style="white-space: pre-wrap">build_grace_period_packet_info</span>
      for no-<span style="white-space: pre-wrap">GFX9.4.3 AP. </span>As
      above, set grace_period directly is more straight forward at asic
      specific file.</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:20250114195251.42661-1-Elena.Sakhnovitch@amd.com">
      <pre wrap="" class="moz-quote-pre">
+	}
+
 	pm-&gt;dqm-&gt;dev-&gt;kfd2kgd-&gt;build_grace_period_packet_info(
 			pm-&gt;dqm-&gt;dev-&gt;adev,
 			pm-&gt;dqm-&gt;wait_times,
</pre>
    </blockquote>
  </body>
</html>

--------------N8PzaZEvr9QrA2D5eNp5qLGq--
