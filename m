Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB21E77188
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 00:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A5B289B01;
	Tue,  7 Jan 2025 00:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ztwtFVgX";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D01689B01
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 00:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz8Sd+umbb21svIL5+l4z30vi/VSYkiTfFce5XrW9/MLNsd7KplvQYYSweni1n8S1Tngh+k5FeH7PeUK+lobnk4/6UMqem0yC5Yk/gLtvdOE0Uj1TX42oS4IRyZtwKDmhwb9tqssFMD7F3jCBfdxYdli6j/AcM1GJhYuSNmLrOb7GEwyMRx1S9YddA4U9gp5jlHWyYr2jdf+jXm7mrN+Q7geBeKwUs1bRY8f60fakt0+2KJXSZiRh11zcK5EXdWejZb3VSvaNz2R8hc+MX18733L7MGIZ39HzPZfIt5WFzZbOx0SSx6vJY7OPjr9rW7j0qLDj3dbGDj35PNZUytT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEbP07/2ZNeAatqNAN5dDeIz2pfYiz/XYd0gnMCkomI=;
 b=jR9dq4ZK24Rr4f8hbgLV6lf09l4WmlaE1/wIoDP1maBMpWFaBgnuEdsdgVwhuoqTUMserfqfMst+nKjF/Fxch1A3vWCKIlZ/I5TRodnW4zQswcdUJaCZq+tZmXkcFV8B/v4pR0en7h0m5eJ/mHEiu0jwq6HqQ4rRmoc45Mu4HHbQxjUJYbRG3rM/WxFjHF1zZsl1uFt2LVhk5Tq1sa9DV3xiA3B4vc00wHOt0ju/OoNV3GQJl14ub1C8kFxxZNFp0Kf4pU/715lrQfRLIekd0s+gBYPRNYLLZxJUJ008Jq32l/nHYgtgpZysTU1Ujkoojywj1ItSrHcEVBA7G/Mbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEbP07/2ZNeAatqNAN5dDeIz2pfYiz/XYd0gnMCkomI=;
 b=ztwtFVgXNF0mzavhk7G4DKnurQtHlq67ZvYuIUVGx2Z45u99kTWdVqYkLa9zIxJtFjPmiFLSDv7u7OY/01jwPHK8TQfFehdrWDEDajhgYioOBqwZ+8XpXQrKMGxCDX3vBroDJHzlMRDSuYWIPIkUDTM5YD474QM5gR8MzK0Fj6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 00:20:28 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 00:20:28 +0000
Content-Type: multipart/alternative;
 boundary="------------aD0ekUI74IBpPXxXKjlCyYQ8"
Message-ID: <604bd35e-1714-4764-898d-f4a30c6e39d3@amd.com>
Date: Mon, 6 Jan 2025 18:20:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
To: Philip Yang <yangp@amd.com>, Emily Deng <Emily.Deng@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <4db6b354-56e6-3d2e-0da9-bfd1943320af@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <4db6b354-56e6-3d2e-0da9-bfd1943320af@amd.com>
X-ClientProxiedBy: SA9PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:806:24::20) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca1fb1b-54e0-4339-7c99-08dd2eb116a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1BaY3pHbnBVUjNhN1FHdVQ1UnRFeGU0Q2hQWkpoV0JsVFc2Vkt2WWJvRGYx?=
 =?utf-8?B?S0sxcFdra1NqSHN1cUxGb3VXbE9CSzZuUmQ3YWFDd2pRbmlHNXppdGpuSWJs?=
 =?utf-8?B?VkxXL2lqWU41QTFyUzNOZU9EZG8xc1lDdHU2aFNkemdZZk5QUlp3aFI5SzN4?=
 =?utf-8?B?RXZ4aEs0YnVKWjh2TitRZGV1NFRGbEFTZ20vSG5neXBpY0g4NWQ0dmtlR1BG?=
 =?utf-8?B?SUdqT1VmbGcwdDJkem04b1I2UVhhalJkMEtia1VGSXU2TUZnMW4vSTdVM0l1?=
 =?utf-8?B?Nkx4M2RsbU1BYS9wY1l5RHU5dVFnLzVRa0tCaUFjSDVnU2lhbU40MEdGNUlt?=
 =?utf-8?B?KzBJb2VEUVpxOEpQRmNRWWVoYk1WMnhkRnNONDl4L0ZPbkNsOE1wU1oxTkk0?=
 =?utf-8?B?cXh2bkVnY0hFeTBmcE1ZZE1ISWFQTXhhUklzbUYrVkw0bzJpREdUbU96bmgr?=
 =?utf-8?B?YWRZZ1JiTWd0cjNEdmYyMldqN200bVgxek5jU2JyZGlNRHV3S3NsZDlqTUpB?=
 =?utf-8?B?a25OZUgwaFlMZnNwOVR0dGZCQTN6aUY2eUtFMThBOFVxOUpZbGNpVFpxL3Q5?=
 =?utf-8?B?ejJFQTlla1FrV21kTlQvQ3lqdUNXSm1ybmsvUE5rOWtGdEl6VGVlZnVrWWpw?=
 =?utf-8?B?OHpla013L2JoL0k0Nno4MVVuREJBS1N3MVZZazR1ajRYTXBkbWpBczIrblpS?=
 =?utf-8?B?ZVN4d2djUTFVVmVNS3F4QWlScHF3cko5VHBsMVdHcHZSN1I2Ykw2cWJFa2wz?=
 =?utf-8?B?aHVXWG45QjJveWt6Zkd6cm5pUGVOYXgrNmNFZXRqS1l5TzA5RHdJdGdMTlVW?=
 =?utf-8?B?bHNnenFlV0t5SFp6a3VpMXFVSFNDTzJYM1VqTUgwUUd0KzZHVVpwOHdpcHJM?=
 =?utf-8?B?K3krczdlNHp6Z0NuUUVpV1loeHlaTmJJUXVBdjZ0Vnc0RnZ2bXB3NzBJckpy?=
 =?utf-8?B?d2Jxakpod0Y0dHB0Y1lzUWtMeW10dUFRcDUxRk5nc0F6bG1LR04vUkFFbk1s?=
 =?utf-8?B?cjVsUE1Gd3QyZlBoME4xaVVLV3RMOGVJOStVY1VNK0hoSXk0NmZPRmFGOVZi?=
 =?utf-8?B?TGNXT1AxSVdWbUdld1V1VmpZVm9yeGhueVRTVmRSYk05aXczLzZ4d2t3VVdK?=
 =?utf-8?B?dkNyLzlEMlBNNVZMT0ZkcGJXKzNacmhuZTYyZnMvMU1IR3ZqWmFXemxwNnFY?=
 =?utf-8?B?YU1weUNwMEM4Kzd4S1hpV1doQmtrZExjL0ZVaDBlLzhObUlzbjlCQWVkZERK?=
 =?utf-8?B?NWI1cTUwYTVLeEpaQkNsenRVTlN1OGMreDU1ckFlSkY1cE42ZlJoSnpHcG42?=
 =?utf-8?B?Y2RycllIY1ViMyt4TjQ2TGcvQ0RQS0p6N1ZnS0hkUEErWTJzaEs1YmlFOTN6?=
 =?utf-8?B?ejIySGhiR1JGcHhGRXRpQTlSaUJFaFFTYkUzdlpMZmlmT0dOTXpwL3JNL0Vx?=
 =?utf-8?B?eU5DZGlHc2NQbTJQb21mTEliYXp1LzFkc3ZoTWRIQ05KTEZNZkNPenMwem5O?=
 =?utf-8?B?d2hPVEU1OUNGUFYxbTEvc0YvR2xZdWxhZ1JNVTZNOGRxN3pjcm1UcmtQVzAx?=
 =?utf-8?B?dEdtaEh0dUpIb3hIaWNGMXZ5c1FaeGpxY09hcWxmbFR3bUVvclVCbnNsUlV0?=
 =?utf-8?B?cXNVcm1JTlgzWGYwT1JFMGV4c1BaQ2dvZGtDdHIzdjBRWnN0VWFtUmtGRm9s?=
 =?utf-8?B?WUxVOVVkbFc1RlR6aTNvbjZIT1FZWCtvaGI5MDZXNitQUUs4R1haaUtWTCt3?=
 =?utf-8?B?RzNmZUJkbWRYL1pkVGkzSlNvQjdWbTRxU0ZyUlhsejJEQ0NaTC96Y21mM2l1?=
 =?utf-8?B?d0xqaTdoaWhNYU80RW1wQTFUc21sblBVUU1xVUgrOW5QN2k5MU1oT091eGVX?=
 =?utf-8?Q?IY6KT/lhuFjqb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1hnZDRoTHZuUitwU3B3N25oSTJhcjZSSVNlYU9SdmJRQmttOE1UNW9OVGJh?=
 =?utf-8?B?V0s0N2tWNHhsU2hVd2xXeE5KUjZTeXphVzhlaHg5eGRhbGZjQ2o1UHNybmFP?=
 =?utf-8?B?QURmcEJ1R09VeERuODc1WjlCR1RSeTVsRStWV1NScGtKaG02UlVCSk12SStY?=
 =?utf-8?B?YTRpL2JDUSsrZ2ZndTBTZTNXUjV5OURZcGMvQ1JDeVNKMjhOY2prS2ZwclRG?=
 =?utf-8?B?WlNjVW92QzhBc2hkdTBVSEI0dVJ1eEhkUU9IaEFvK3RhY3U5WkpSRzduWXla?=
 =?utf-8?B?TmRGOUhSdGhEOGgxNWdLRExnemM0djE3dG5FMGxaU2RzQkRxbWVQSFNBVWdr?=
 =?utf-8?B?UTlPbFFGcDJVWnlFbWNCcnNmaTBXYUoyYWczZE1mUFBzNzlLUWlWbHp0bi9L?=
 =?utf-8?B?ME04c01rYUNya2lIck4rcTQxdnREVllPQ2NuZDdpTk12cmx2TDYyZTJNM2JP?=
 =?utf-8?B?dklyYmdBeWd5NVNPWG1YTWlMVHQySjcrZm1uYlJ3c09zWjBkbFJ6OFNCaFRB?=
 =?utf-8?B?UjBTV1VMYXVEVU9QMm84YzZQTFdxTVFySWhveGxhVW04dDdLZW5ZcExwNm5M?=
 =?utf-8?B?NEpNYU1zeHFJbEVrWVVzMHQ0OC9HUzdOdHVoZmpFc0NmWHpPOWViMlRNNE10?=
 =?utf-8?B?cVdMQ0RUUk1ZdzFRa216YndMNmFhRzc5aWtBK0R2VDBaZzZPenUxYnZsY1lI?=
 =?utf-8?B?NG1KNEFyZjBtM1hIZmNRdFJXVld5MllNekJSVW5QSlAxcDJCT1hMMUdxSFpS?=
 =?utf-8?B?Nlh0ZVNvRkI5ZjFDN0psdU9vd21aeU9DSWVUcjZ4WGNPZGhQR3BWY3hjcHE2?=
 =?utf-8?B?bEd4RFVBQU9sd2IxNXlGRXlpbU9XbElacFlQS1k3OWo1eC9LeDVqS3dFYkJP?=
 =?utf-8?B?UHpyL1FjZjFWQVpibmFYQlIvM09xdkQ3c3F0ZGoxR2IvMytma05iMDUvRTBt?=
 =?utf-8?B?ZzBtOXRSNnErQTRJLzExRjJzMmlCN2JDalFpWFJNZ0RneFcxVFZERTdhVlR6?=
 =?utf-8?B?L3lVbEtJTGV1RS9JODhxeEFzQ2NpcTNMMERjbnBWRjc1WEh6b0RlbTIyaTdP?=
 =?utf-8?B?Z1hVYzNMNmtJWnArQjlPbDVQRG9aa0prK250aUNqTFU2cDlXTWdmejVSREl2?=
 =?utf-8?B?aFFwU2VQdGtORDRYYUNDSkEwcjdlMFUxMW9zZk1URnJScnp0aERRandqdDd4?=
 =?utf-8?B?RlM3SE50aXJxVmREWGNsVithdmN1RzArZUltd2tTQkZlUTlSdVBUUlJzVy9C?=
 =?utf-8?B?ZkUvYk00VitVbkNucFBFQTVVUG52YjBkYllnaS9PajBBUHBBREVkNElaOWZh?=
 =?utf-8?B?UklPZ2s0WGpDbGNFQ0hHNXp3RXNzNzI2T3I3OUdOTW5pUU5tdU1zRVlVM29n?=
 =?utf-8?B?M29NRmRJV25IaVkrZlVnZDFlVWtXMU5WZCsraGZMU2VtWEs3akFla0tWR3lh?=
 =?utf-8?B?clVRV1pDZ3BjUDgwU0pvaGM3MER6ZEJ3eGR5YXA0U0szanRmNTE1R2NhVGVM?=
 =?utf-8?B?RlZ4ZXdnWDROMFkrLzE3K2FSd0RUalZrZy9xQkFzdUhDemdOV0NLeWdsK1J4?=
 =?utf-8?B?L0VxWTMxVU9zUGt5Y2NMTFpLL0lvRGdFa2U5VHBSb252dnZOZWQvQVVuQU5B?=
 =?utf-8?B?UHJXbkU4Sks4NGtxTittWnB4QzMzTXpYeVJuY2twd3BVcGNNOTZ5MSs5SHNh?=
 =?utf-8?B?SklGS0ZMME5LTFdiK3o0QUxMemE3bm1Fb1lWMGhRL2NFaWFGUDJUSGFGclBT?=
 =?utf-8?B?TzBadTFOVVNoN2h2UXNVTFlhK1lSZG9qR1QyZWp6MDdHUFV6akFEVVhVSGpW?=
 =?utf-8?B?YkZjY1lReEt2NFFsWFp1eHN5QWVLNmpUcVppSnpWR2NYM3FCb2I4angvVHpO?=
 =?utf-8?B?WTRNajBoWDVSemlycm53OXA2SXJ5SDNkQ3dDUzI2NENxdGg1dlBleWJxNStB?=
 =?utf-8?B?ZUhIVkF3UlNuWVpyNHNqWW9pNjhGbzI5QjhjRW1YZHBYT09PRjZnSERxQ3ZZ?=
 =?utf-8?B?c2RSTzFCcU1MK3lGKytXUXYyZ0E0UkZEQUJFblA3QTZkNHBLRTJvR3A4a0hs?=
 =?utf-8?B?ZEZnTzduaWpib0JpY1FuaUJSUVNTOXJvRWxTOFBrNFg3SUprVVpPczNnQ3Rm?=
 =?utf-8?Q?BQmU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca1fb1b-54e0-4339-7c99-08dd2eb116a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 00:20:28.2190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlNT3TYWMwGqBfYBl076hNtGD3fPDgPNULOD7xMkDv0XaavCG9ykCx9NTGemPipX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
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

--------------aD0ekUI74IBpPXxXKjlCyYQ8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/6/2025 5:50 PM, Philip Yang wrote:
>
>
> On 2025-01-02 19:06, Emily Deng wrote:
>> For partial migrate from ram to vram, the migrate->cpages is not
>> equal to migrate->npages, should use migrate->npages to check all needed
>> migrate pages which could be copied or not.
>>
>> And only need to set those pages could be migrated to migrate->dst[i], or
>> the migrate_vma_pages will migrate the wrong pages based on the migrate->dst[i].
>>
>> Signed-off-by: Emily Deng<Emily.Deng@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 4b275937d05e..5c96c2d425e3 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
>>   			 dma_addr_t *scratch, uint64_t ttm_res_offset)
>>   {
>> -	uint64_t npages = migrate->cpages;
>> +	uint64_t npages = migrate->npages;
>
> As partial migration size is based on prange granularity, by default 
> 2MB, maybe always migrate->cpages equal to migrate->npages, that's why 
> we didn't trigger this bug. Wondering how do you catch this bug? This 
> bug will leak svm_bo too, as svm_migrate_get_vram_page reference 
> counter is incorrect.
>
The commit message is somehow confusing. It is not partial migration 
from page fault recovery. It is the case that migrate->cpages != 
migrate->npages after migrate_vma_setup due to some pages cannot be 
moved for some reasons. For that only part of src pages can be migrated. 
Ex: some system ram pages got locked by kernel. Usually this case does 
not happen during normal tests.

Regards

Xiaogang

>>   	struct amdgpu_device *adev = node->adev;
>>   	struct device *dev = adev->dev;
>>   	struct amdgpu_res_cursor cursor;
>> @@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   		struct page *spage;
>>   
>>   		dst[i] = cursor.start + (j << PAGE_SHIFT);
>> -		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>> -		svm_migrate_get_vram_page(prange, migrate->dst[i]);
>> -		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>   
>>   		spage = migrate_pfn_to_page(migrate->src[i]);
>>   		if (spage && !is_zone_device_page(spage)) {
>> @@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>   		} else {
>>   			j++;
>>   		}
>> +		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>> +		svm_migrate_get_vram_page(prange, migrate->dst[i]);
>> +		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>
> This should move forward, to handle the corner case to migrate 1 page 
> to the last page of VRAM res cursor.
>
> Please check this change, to add mpages accounting to break the loop 
> earlier.
>
> -       uint64_t npages = migrate->cpages;
> +       uint64_t npages = migrate->npages;
>         struct amdgpu_device *adev = node->adev;
>         struct device *dev = adev->dev;
>         struct amdgpu_res_cursor cursor;
> +       uint64_t mpages = 0;
>         dma_addr_t *src;
>         uint64_t *dst;
>         uint64_t i, j;
> @@ -295,14 +296,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
> struct svm_range *prange,
>
>         amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>                          npages << PAGE_SHIFT, &cursor);
> -       for (i = j = 0; i < npages; i++) {
> +       for (i = j = 0; i < npages && mpages < migrate->cpages; i++) {
>                 struct page *spage;
>
> -               dst[i] = cursor.start + (j << PAGE_SHIFT);
> -               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> -               svm_migrate_get_vram_page(prange, migrate->dst[i]);
> -               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> -
>                 spage = migrate_pfn_to_page(migrate->src[i]);
>                 if (spage && !is_zone_device_page(spage)) {
>                         src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
> @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
> struct svm_range *prange,
>                                                 mfence);
>                                 if (r)
>                                         goto out_free_vram_pages;
> +                               mpages += j;
>                                 amdgpu_res_next(&cursor, (j + 1) << 
> PAGE_SHIFT);
>                                 j = 0;
>                         } else {
> @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
> struct svm_range *prange,
>                 pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 
> 0x%lx\n",
>                                      src[i] >> PAGE_SHIFT, 
> page_to_pfn(spage));
>
> +               dst[i] = cursor.start + (j << PAGE_SHIFT);
> +               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> +               svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> +
>                 if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages 
> - 1) {
>                         r = svm_migrate_copy_memory_gart(adev, src + i 
> - j,
>                                                          dst + i - j, 
> j + 1,
> @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
> struct svm_range *prange,
> mfence);
>                         if (r)
>                                 goto out_free_vram_pages;
> +                       mpages += j + 1;
>                         amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
>                         j = 0;
>                 } else {
> (END)
> @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
> struct svm_range *prange,
>                                                 mfence);
>                                 if (r)
>                                         goto out_free_vram_pages;
> +                               mpages += j;
>                                 amdgpu_res_next(&cursor, (j + 1) << 
> PAGE_SHIFT);
>                                 j = 0;
>                         } else {
> @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
> struct svm_range *prange,
>                 pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 
> 0x%lx\n",
>                                      src[i] >> PAGE_SHIFT, 
> page_to_pfn(spage));
>
> +               dst[i] = cursor.start + (j << PAGE_SHIFT);
> +               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
> +               svm_migrate_get_vram_page(prange, migrate->dst[i]);
> +               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
> +
>                 if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages 
> - 1) {
>                         r = svm_migrate_copy_memory_gart(adev, src + i 
> - j,
>                                                          dst + i - j, 
> j + 1,
> @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, 
> struct svm_range *prange,
> mfence);
>                         if (r)
>                                 goto out_free_vram_pages;
> +                       mpages += j + 1;
>                         amdgpu_res_next(&cursor, (j + 1) * PAGE_SIZE);
>                         j = 0;
>                 } else {
>
>>   	}
>>   
>>   	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
--------------aD0ekUI74IBpPXxXKjlCyYQ8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/6/2025 5:50 PM, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4db6b354-56e6-3d2e-0da9-bfd1943320af@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2025-01-02 19:06, Emily Deng
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20250103000644.1398643-1-Emily.Deng@amd.com">
        <pre class="moz-quote-pre" wrap="">For partial migrate from ram to vram, the migrate-&gt;cpages is not
equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed
migrate pages which could be copied or not.

And only need to set those pages could be migrated to migrate-&gt;dst[i], or
the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 4b275937d05e..5c96c2d425e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate-&gt;cpages;
+	uint64_t npages = migrate-&gt;npages;</pre>
      </blockquote>
      <p>As partial migration size is based on prange granularity, by
        default 2MB, maybe always migrate-&gt;cpages equal to
        migrate-&gt;npages, that's why we didn't trigger this bug.
        Wondering how do you catch this bug? This bug will leak svm_bo
        too, as svm_migrate_get_vram_page reference counter is
        incorrect.<br>
      </p>
    </blockquote>
    <p>The commit message is somehow confusing. It is not partial
      migration from page fault recovery. It is the case that <span style="white-space: pre-wrap">migrate-&gt;cpages != </span><span style="white-space: pre-wrap">migrate-&gt;npages after migrate_vma_setup due to some pages cannot be moved for some reasons. For that only part of src pages can be migrated.  Ex: some system ram pages got locked  by kernel. Usually this case does not happen during normal tests.</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang
</span></p>
    <blockquote type="cite" cite="mid:4db6b354-56e6-3d2e-0da9-bfd1943320af@amd.com">
      <p> </p>
      <blockquote type="cite" cite="mid:20250103000644.1398643-1-Emily.Deng@amd.com">
        <pre class="moz-quote-pre" wrap=""> 	struct amdgpu_device *adev = node-&gt;adev;
 	struct device *dev = adev-&gt;dev;
 	struct amdgpu_res_cursor cursor;
@@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		struct page *spage;
 
 		dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
-		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
-		migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
 
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
 		if (spage &amp;&amp; !is_zone_device_page(spage)) {
@@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		} else {
 			j++;
 		}
+		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+		migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);</pre>
      </blockquote>
      <p>This should move forward, to handle the corner case to migrate
        1 page to the last page of VRAM res cursor.</p>
      <p>Please check this change, to add mpages accounting to break the
        loop earlier. <br>
      </p>
      <p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;cpages;<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mpages = 0;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *src;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *dst;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t i, j;<br>
        @@ -295,14 +296,9 @@ svm_migrate_copy_to_vram(struct kfd_node
        *node, struct svm_range *prange,<br>
        &nbsp;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages &lt;&lt; PAGE_SHIFT,
        &amp;cursor);<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages; i++) {<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages &amp;&amp; mpages &lt;
        migrate-&gt;cpages; i++) {<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;<br>
        &nbsp;<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
        svm_migrate_addr_to_pfn(adev, dst[i]);<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
        migrate-&gt;dst[i]);<br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
        migrate_pfn(migrate-&gt;dst[i]);<br>
        -<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage = migrate_pfn_to_page(migrate-&gt;src[i]);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp;
        !is_zone_device_page(spage)) {<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] = dma_map_page(dev, spage, 0,
        PAGE_SIZE,<br>
        @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct kfd_node
        *node, struct svm_range *prange,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
        out_free_vram_pages;<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j
        + 1) &lt;&lt; PAGE_SHIFT);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
        @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct kfd_node
        *node, struct svm_range *prange,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma mapping src to 0x%llx,
        pfn 0x%lx\n&quot;,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] &gt;&gt; PAGE_SHIFT,
        page_to_pfn(spage));<br>
        &nbsp;<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
        svm_migrate_addr_to_pfn(adev, dst[i]);<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
        migrate-&gt;dst[i]);<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
        migrate_pfn(migrate-&gt;dst[i]);<br>
        +<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) -
        1 &amp;&amp; i &lt; npages - 1) {<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev,
        src + i - j,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst + i
        - j, j + 1,<br>
        @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct kfd_node
        *node, struct svm_range *prange,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        mfence);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j + 1;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j + 1) *
        PAGE_SIZE);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
        (END)<br>
        @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct kfd_node
        *node, struct svm_range *prange,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
        out_free_vram_pages;<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j
        + 1) &lt;&lt; PAGE_SHIFT);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
        @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct kfd_node
        *node, struct svm_range *prange,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma mapping src to 0x%llx,
        pfn 0x%lx\n&quot;,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] &gt;&gt; PAGE_SHIFT,
        page_to_pfn(spage));<br>
        &nbsp;<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
        svm_migrate_addr_to_pfn(adev, dst[i]);<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
        migrate-&gt;dst[i]);<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
        migrate_pfn(migrate-&gt;dst[i]);<br>
        +<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) -
        1 &amp;&amp; i &lt; npages - 1) {<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev,
        src + i - j,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst + i
        - j, j + 1,<br>
        @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct kfd_node
        *node, struct svm_range *prange,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        mfence);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;<br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j + 1;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j + 1) *
        PAGE_SIZE);<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
        <br>
      </p>
      <blockquote type="cite" cite="mid:20250103000644.1398643-1-Emily.Deng@amd.com">
        <pre class="moz-quote-pre" wrap=""> 	}
 
 	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------aD0ekUI74IBpPXxXKjlCyYQ8--
