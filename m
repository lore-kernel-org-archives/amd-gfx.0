Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95070C021A0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 02:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA4C910E023;
	Mon, 10 Feb 2025 02:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQQm/Cvk";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDEF10E023
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 02:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtmFUTvhth/noC1hxjt1C9LXyDimFOjC+z+iuaR1ZySR9XzwhYewo3Ea3xpKLkREv+7vTtmfa0efct5WFHPD3NAxTOnsZOBIM2FWaodpEjITiv84TDBMWqoYpUGxvXhVZa6jQ95eiEPpXAZY/4THNZQcRBvm9U7AlQPczgsyiKoNHNTJ3fOFOiHcyPOqnJZgoXmIvylBWJ4RDIDfWNu1Cmu/9Ml0ort+mMZmOFPkp0ICwL4YTBM1DlUl7PktsZmAE2xVIj35PTOHFFHtKv9rKHwMrLKYm3Ko92QzX+uKTQ36Jq+T/YAIQ3Yy71h3T7El0qGD4YQ42c9aS3uzkAz8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSfGc1zq7wChHHNWKa2ROTwJ4b5OJJed6oz6FclZIXc=;
 b=dUZvhVtnkhY57qdDMOfgTlizx5YuPxZiS+q94D0EmCHQqYEKmzX5P/koxHgHpuN0/yikibk7bmeqea0+a04jJHm4oh5jmglG+BwJ74napkxwlSBXxQSi0EGkvdpe4l3Zhyo2pmrQp5MyBexeg5fVcyIWIP9VUBxQULFBJxxVynSIxfdB2FsZlHO+FHCHtMDEk2i5t2L4qaM9pFr0BrZ1UPESQdLqKvmKGimmhoQms5fIuHKVH8bhO03RnVb6gb7pyB7UwGQJATWvLFIWXz7bxGqkFwwdWQ/AiDj4fP9EgjrlZwVjSOFJPpNE/NRlQAzA0obek1TgCh0fyRkW3CTDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSfGc1zq7wChHHNWKa2ROTwJ4b5OJJed6oz6FclZIXc=;
 b=hQQm/Cvks4N7S+/OlmD3NBsmJRL5/VgdpF/lvuRG7mWqsTlljnKClbOlIHzZDyq/KPOqvHIyzC3pRUvoaDzBBTPSh49CeE6hlsyiU8yxa9GByCY8NgPo1yxkAlsz0moe1jRKFmEGByLNTidUPr+C6Lhgmz6zvPdpxU8g7ovg814=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 02:17:32 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 02:17:32 +0000
Content-Type: multipart/alternative;
 boundary="------------30pdn0hywDVEPpHHAU3i7pDe"
Message-ID: <841a21b8-b0b6-48a9-af2d-62b51d5d6a1b@amd.com>
Date: Sun, 9 Feb 2025 20:17:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250207102823.1565467-1-Emily.Deng@amd.com>
 <PH0PR12MB541778A52306F3BF717609018FF02@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <PH0PR12MB541778A52306F3BF717609018FF02@PH0PR12MB5417.namprd12.prod.outlook.com>
X-ClientProxiedBy: SN6PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:805:de::45) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 995c9d22-ace1-4326-a51a-08dd4979132e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCtzUHoxa1NtdlU0c0tuY25GYnhEK2RodUJxem90bzgzVjc0dEgzbG1vM2FO?=
 =?utf-8?B?Z1E0eTRDUHRPNVp6bmRwZGgvWGFORUZqVTFYbWZBS1d1VHU2NWcyUlZrdFpo?=
 =?utf-8?B?cFgwSVh1Vk9jQzMyS01PMmVSNnBBckdBaUF0VkgrRDFmeU5za0NsUTRTblpB?=
 =?utf-8?B?SDd0RThWZjhINDdrblJuWFJUemE0b212S1dmRzNMK2ZSWDF2dnlMc3cwZ2gz?=
 =?utf-8?B?TnA1cmREdGduYitMSUxkOEdLVFRBNGxxSEltbzhUU3dqaXBSWjRlQmQ2amRj?=
 =?utf-8?B?VFVINEtuRFJtUXFPd2ZjODF2SUxJVFptQWExY3p1SGRrVXQ2aXNrazRkVUxs?=
 =?utf-8?B?bHY2RXFtYVZIMk9MVlRZYzlNV3RDeDFDZW9nWnlONHVyMFJmWFdmTkN3VEYw?=
 =?utf-8?B?RkJzRjl5QmxWdStnTTVTK1ErQmlDUStXcjNXK21LbXJ1aUZKUUdsZ285ZDlm?=
 =?utf-8?B?REhUcWhIaVpUTjA4czdCZjBVb0piMjA1OUxBNFh3U3N3UFVRcDlzR1JqNjhU?=
 =?utf-8?B?Z3FyN2NTM2ZSUkZudVFPdXAzc3pLZmdycXJTbkhIam1RclM2QUJpSnF0d0RZ?=
 =?utf-8?B?TUNpbitrd09xYVUzaTQrdUYvV0Q1VHh1MklsUkpGcmFFQkJlVWEreU5BUnR0?=
 =?utf-8?B?eUU0MlVXSTlvK2NXRllkL2huYkNiOGxVUU4rUi9vN25uTjk0eXIxWUhEdWJB?=
 =?utf-8?B?eGFFcXdxZ2J5R3FtUXVPWUFZZHh6Njh2cmRqamlaSVNZeWhvL1I3NFlHZlI2?=
 =?utf-8?B?LzRCRFl6cTdjNlBvSkp2ZmZPcGM0eFI0Ty9oUW9Memd5WXp1R294MDVRWXFL?=
 =?utf-8?B?Qm9SOWY1TmsvNHBXd0s3Wnh2eEdPa1haMTRiOGQ1ZlczeGhSaHRENTJGMTI3?=
 =?utf-8?B?RmdZeDh2aU5tWndhTlhCbCs5Sk9FTEJjVmNkaGdDbnRyNDZEalBDQXpZSFQr?=
 =?utf-8?B?NDVEejZ5Y3ExN3h6bkpwNUI0UTZncDBmcHRVcVJNN29NalFKSlRsSFJnL1BI?=
 =?utf-8?B?VnR1b09XZlZqVC9QMHJldXM4MU5vTEZ2cCtPaHkvaVhINTEzdEZXakVITHh0?=
 =?utf-8?B?dm5rcE8vaDUvT0NPQkplamlBZXdrdXVZU2JTOE40RGVZdXFOa1lpTU1UKzBT?=
 =?utf-8?B?SjY0Uzl3bnF5blZKbTAwY29wVWRzVkJXYTdEZHZoajVGS3RIOE5JYXptT2J5?=
 =?utf-8?B?bklrOUpYTVloK0V4cFh5VEhIVGhzK0hrN0tWQVB5NkFET2pGLzNXaEtrK0hy?=
 =?utf-8?B?b3J5Um52QUlzNGRFMkkyWFVzeUEyVG1zaWUzSUJOU3FJbE9GMjV4TXFOOFRT?=
 =?utf-8?B?clUwQnk3ejUrYldERWJ2YnBPb0FGbDRnMnVpaTF3Z3VmNVdUbmZjNzh0c2hQ?=
 =?utf-8?B?cWJST2FQOEdZNUpKdkFwME1JWlQwRkk4d0NJSTg1ZUxpRCszeGFxaDNYckRP?=
 =?utf-8?B?QXpsdVVuVERiZEpEYUNaSmVsYitIUng4SFFDaEppQzhIY0RaMU5wampjRlo0?=
 =?utf-8?B?L3A2MXNOa1J0NCtvYzc4WThKdFZuY0JUVUlOc0E2MXRNbEpaTDhnR3Z3aE5w?=
 =?utf-8?B?VEd5dGxXR2hWMVBrOFhkVWNlOUh3NkpJSDBoL3FhK1o4b3pFRDFNSHIvR1Bs?=
 =?utf-8?B?dnMrck5tdVZDZ21mNi9UbjByNVBvRUpoU3RleUpxRnV3Q1pqZGxCTTBuWlBW?=
 =?utf-8?B?N1lEUmxBVjF2ZGdiK1oxQlY5em9tUlFsWUN0TUNIS3hVWEYxSkZ4TnUvdURG?=
 =?utf-8?B?S202d3B1Y0dWU3hvMllJWFM4MWpiS0x1c2lRM3JaTGsreEhmdFdxT3lVSk95?=
 =?utf-8?B?Y3ZnMGIremNrUWNEZURCc3g3cGcvYVgzUUhqL0g0SHJDYnhCMlJJWU1Bb1Y0?=
 =?utf-8?Q?6SwvDg3IC8Bwf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjYvamtrU3BWM1BUVEFJWExwMDNhb1VYMW5DdzM0aU50cTE1R0J5ejhtYUds?=
 =?utf-8?B?WnhReTRmaENSeVIvaitPYjRvdXZEVWdpVFk3MVdMalFIQWliUXBYUkQ3eWlH?=
 =?utf-8?B?UE5waXFwdnlQQ01UekZyZ1g0bCtMKzRyRFZBZnV4aEFFRDJwcGlRWk9QS2x2?=
 =?utf-8?B?VFhpNzdMTmFhOHRKc0FxWmwvTW02SDJYbzF2cHJsZTkyWFE2Q2Jkd01kWVhY?=
 =?utf-8?B?RjFSZGxWSVFUK0dVU1hRaXIyZW9DQkp1MUJST2EwWmZoMU04RVdlSG5NcTl2?=
 =?utf-8?B?dS9FMzA5Nnc4VTJpQ0FGSG9CUWJUcFlFdEdNeGFIVTZiNmVLS0NXejRGa0Yv?=
 =?utf-8?B?c1N4YTNjNkZURWR0OVdOTCtqMW9YUUh6dWdCTmc4bXJSYnNmd3Z3SzJYeVpE?=
 =?utf-8?B?TUVWcmwvY2R2dFZ5T3ljNXVsZUJGNHBYRVBxU2o0ajZVWDhGSENkVWJyZHNB?=
 =?utf-8?B?MC9NVUd6VXgwbXdOSVVrN0kreHdvUFZWV1M0SVZBZFoxWUEzdERUYTlTRHQ3?=
 =?utf-8?B?WndpcjJpOStTbnB4REx5SXJpcXZIOENEeEpQYXk0Q1NRazMxazh0aWR4eGYv?=
 =?utf-8?B?elBZWDBUSzBUb0IvMWdaVGovNVhPNW1HYWZnclFlRTYzNVZNRzF4WEJTSWNx?=
 =?utf-8?B?bThZdVRBL3d6YmN5NmQvelJMeWtEVUtvSzlraXc5bWlLSDV1TEwzSXE4bTcz?=
 =?utf-8?B?KzY4KytMbk1uaXRVVzd5azB3NG1KMmNZUkI3aVUvbDM3c0VOelZnWm9ROC9W?=
 =?utf-8?B?UHoxSnArWDBaWDVwemkrTy9sUlNEdGFUeEhUR1NzdE1TZjZ2V0w3eGM1TU4x?=
 =?utf-8?B?OTQ1WjVSUTBURFI1VXd4OEh1L29sRThLV1I0czZ0enB6dTdXNnR1b2tQeGtm?=
 =?utf-8?B?WkpVNkJ4V2JDWTArM1YyRXhOWkYrVStHVWNJd1VzZWpjV254RWlXaktwcUQ0?=
 =?utf-8?B?aHhhbU5SS2QzZm13RldxYmFTOUJ0LzBJZFMybVBpUUZLQ0hqS1Z5YUhtaHQ3?=
 =?utf-8?B?QzRxZklrZldMOTNIQ0lBR1h5MklEMkpYdHpuU2xNckJWK243RmJnakp3a25u?=
 =?utf-8?B?b1VSZG1oWUpkOUZSd2tTWkwxVmVyZTl6eHJ2MGVtYXg5QzZ0cllXcHRpdUw5?=
 =?utf-8?B?b0tVTlVxbFgrZWVoT1ZJcVNzVDFUUUtyVFY0Rm4vcHE2dzFiRVZMblR5a0JV?=
 =?utf-8?B?UmNDTy9ueHZGMzRmQnh6RTh0Yi84S2s4eVZBZ05VMExJRFRaVlAybm44ZG5P?=
 =?utf-8?B?cTlSckRHWFU2YjFwS2h1NHFiTWVLQnRZYlNUUDRNb3NJTCtqYmNrTjNLOEVP?=
 =?utf-8?B?VlNjbFZncVVxVUNWUXZNbUdTWHBMUUV0aWhJcjR0em9GZ2d2ZjByMnBGQ21w?=
 =?utf-8?B?aVRYdFdFL003UGo3Q2JnWU9tTE9ObmFqbjZxZWE1RmI0TGg5M3NoeTRIcGdT?=
 =?utf-8?B?clowM0NiNGUxSkVuS3k0eXp4RHZ6K1Rudnp3angrRU5Yc21oVGdvTFFJdkVV?=
 =?utf-8?B?TDBhZ295dVhZYUovYnRpc0hlSkFEZlRyejlHUWtxY2oyUDFXMm1QM2x4bEUx?=
 =?utf-8?B?Njcxa0FkekF2aVA5Skd5clp4ekNnaGRSM1VYRC9GZUlOenM1bDNRL0VtZzJz?=
 =?utf-8?B?T2kvMmlOODR5cFA4OFczRk9VNk5Tc2hDaEJ1bVYvY0FIVXVmZ0VQdmZsTFhM?=
 =?utf-8?B?Q2pWSEw5M09PTmxNU1VUK3FldlgxTW9sTis3T1gzRVhQTEp3QmduckJxeE5X?=
 =?utf-8?B?cTRVK2N3VnpIKzlUamlzT21rVmpWdTFOSXJITk5lNDVIcDNvanI4V3RiRVJu?=
 =?utf-8?B?aXkycTVQbjIwSDBUaThBT2d2UWE0QmJBMmVaYnBGeVBoUkptQ3U1RDNidkJR?=
 =?utf-8?B?MkplZHFmclJzRUQ2REhMcVhreXdkZG1kUW5xM01DdmhvenI3U0FYUStpbzBw?=
 =?utf-8?B?T1owMFRudkZ1OEZEMWQvTTJIaEJudDFYYTNxWVo1WitZdm5CNHAvbmNXdmN6?=
 =?utf-8?B?TEROL1FnS0VjMkVpVWoxakR4eVVSNm9oZWh5QzBZbG5kK2lWK09EMDFUTkV1?=
 =?utf-8?B?eUtCZmxYRXFsTVE5SzNncGM0UE9xb1JOMm92OUhVYUpsYU5EdUtqNzcwU1Nh?=
 =?utf-8?Q?dlXQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995c9d22-ace1-4326-a51a-08dd4979132e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 02:17:31.9648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMmh1iWIniKcFWeA+zloXFJftZr+sUcC3IJulnQOkCWVGsWzcj9hfM69gJfuD1Bg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

--------------30pdn0hywDVEPpHHAU3i7pDe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/7/2025 9:02 PM, Deng, Emily wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping.......
>
> Emily Deng
> Best Wishes
>
>
>
>> -----Original Message-----
>> From: Emily Deng<Emily.Deng@amd.com>
>> Sent: Friday, February 7, 2025 6:28 PM
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily<Emily.Deng@amd.com>
>> Subject: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
>>
>> It will hit deadlock in svm_range_restore_work ramdonly.
>> Detail as below:
>> 1.svm_range_restore_work
>>        ->svm_range_list_lock_and_flush_work
>>        ->mmap_write_lock
>> 2.svm_range_restore_work
>>        ->svm_range_validate_and_map
>>        ->amdgpu_vm_update_range
>>        ->amdgpu_vm_ptes_update
>>        ->amdgpu_vm_pt_alloc
>>        ->svm_range_evict_svm_bo_worker

svm_range_evict_svm_bo_worker is a function running by a kernel task 
from default system_wq. It is not the task that runs 
svm_range_restore_work which is from system_freezable_wq. The second 
task may need wait the first task to release mmap_write_lock, but there 
is no cycle lock dependency.

Can you explain more how deadlock happened? If a deadlock exists between 
two tasks there are should be at least two locks used by both tasks.

Regards

Xiaogang

>>        ->mmap_read_lock(deadlock here, because already get mmap_write_lock)
>>
>> How to fix?
>> Downgrade the write lock to read lock.
>>
>> Signed-off-by: Emily Deng<Emily.Deng@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index bd3e20d981e0..c907e2de3dde 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1841,6 +1841,7 @@ static void svm_range_restore_work(struct work_struct
>> *work)
>>        mutex_lock(&process_info->lock);
>>        svm_range_list_lock_and_flush_work(svms, mm);
>>        mutex_lock(&svms->lock);
>> +      mmap_write_downgrade(mm);
>>
>>        evicted_ranges = atomic_read(&svms->evicted_ranges);
>>
>> @@ -1890,7 +1891,7 @@ static void svm_range_restore_work(struct work_struct
>> *work)
>>
>> out_reschedule:
>>        mutex_unlock(&svms->lock);
>> -      mmap_write_unlock(mm);
>> +      mmap_read_unlock(mm);
>>        mutex_unlock(&process_info->lock);
>>
>>        /* If validation failed, reschedule another attempt */
>> --
>> 2.34.1
--------------30pdn0hywDVEPpHHAU3i7pDe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/7/2025 9:02 PM, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB541778A52306F3BF717609018FF02@PH0PR12MB5417.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

Ping.......

Emily Deng
Best Wishes



</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
Sent: Friday, February 7, 2025 6:28 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
Subject: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work

It will hit deadlock in svm_range_restore_work ramdonly.
Detail as below:
1.svm_range_restore_work
      -&gt;svm_range_list_lock_and_flush_work
      -&gt;mmap_write_lock
2.svm_range_restore_work
      -&gt;svm_range_validate_and_map
      -&gt;amdgpu_vm_update_range
      -&gt;amdgpu_vm_ptes_update
      -&gt;amdgpu_vm_pt_alloc
      -&gt;svm_range_evict_svm_bo_worker</pre>
      </blockquote>
    </blockquote>
    <p><span style="white-space: pre-wrap">svm_range_evict_svm_bo_worker is a function running by a kernel task from default system_wq. It is not the task that runs </span><span style="white-space: pre-wrap">svm_range_restore_work which is from system_freezable_wq. The second task may need wait the first task to release </span><span style="white-space: pre-wrap">mmap_write_lock, but there is no cycle lock dependency.</span></p>
    <p><span style="white-space: pre-wrap">Can you explain more how deadlock happened? If a deadlock exists between two tasks there are should be at least two locks used by both tasks.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang
</span></p>
    <blockquote type="cite" cite="mid:PH0PR12MB541778A52306F3BF717609018FF02@PH0PR12MB5417.namprd12.prod.outlook.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
      -&gt;mmap_read_lock(deadlock here, because already get mmap_write_lock)

How to fix?
Downgrade the write lock to read lock.

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bd3e20d981e0..c907e2de3dde 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1841,6 +1841,7 @@ static void svm_range_restore_work(struct work_struct
*work)
      mutex_lock(&amp;process_info-&gt;lock);
      svm_range_list_lock_and_flush_work(svms, mm);
      mutex_lock(&amp;svms-&gt;lock);
+      mmap_write_downgrade(mm);

      evicted_ranges = atomic_read(&amp;svms-&gt;evicted_ranges);

@@ -1890,7 +1891,7 @@ static void svm_range_restore_work(struct work_struct
*work)

out_reschedule:
      mutex_unlock(&amp;svms-&gt;lock);
-      mmap_write_unlock(mm);
+      mmap_read_unlock(mm);
      mutex_unlock(&amp;process_info-&gt;lock);

      /* If validation failed, reschedule another attempt */
--
2.34.1
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------30pdn0hywDVEPpHHAU3i7pDe--
