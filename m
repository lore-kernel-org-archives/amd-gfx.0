Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264BCD49228
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 14:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0DD610E4E3;
	Mon, 18 Nov 2024 14:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yni4LfNA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D9D10E4E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 14:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMuADBBs3KvmC8h9QwpXfoFYkLBo3B3G3GiNXy05vKdZB9CYBlQ3FqEj7/eM+DT/mZSK60amxQ6pPilj8/wpUsNAN+EhmkU0ez+EJUdv+l+cbuRkwAVRHhBbIukMrDkEB5OnTn/VBzh8D+OnDBuE9TEB/PV/qwPRzcBfQPklzIzgYXaOCaf3lcMCHr7fluRRYA5zmWAeApmvjIOt+//P+x+3FubTm7zQ/QPcprXXFN9ngHRSNIWAkF/1qc4vLkNt4FN7jiAesBKOrGXHfVDRvRP6BU0SrupwbEz5NVFGfCZNjFK7NM4cTOzA3g1aTiM/q78Tz8Fcy+Q956NTkGl8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEWP5n6WQg5R267Qy8f9tYZUp44Fvn/NIMmi5QCzBmA=;
 b=Wxz2bijbxmosXobINqmVw0JnBUW3If0ZY52CkyOekHvNja6ZgGqrXBimHUqB3gfyaRfCJh1CgZzd6FMIxB3qA1pP8r1ApxaxZO543nzc4PrwAk2w3802kLWPAtyqGL0g61JavPqeNGSZNSev05Dl4wHzxh+aAtevimxLAQHKml1PYaAH3CNxvYBRDcWV73FkTo5XCRStWTzi1rLuHC6FDAXcmiUYK65RcTmdDPcKE49bbCMfuLvCe0JyLsBy8cvVCGtdWAU1AYUp+bBg1m8m5g1qV3pVEAo41fjPLuUqiggfST1TaHwlJVlUe2muP+rHKpJFoa8GnYr57TsdxLQfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEWP5n6WQg5R267Qy8f9tYZUp44Fvn/NIMmi5QCzBmA=;
 b=Yni4LfNA9RrQIOOTnsdPrKH/15lSI3bRS+Sxus3Olm3q5PsbJfnn9rLS1P2OKHWylmdFO5PS5aO7i4hhMxSob9vMYQ+utNTjxwxSD3yDXQ7GtLE/hPMdds+xrlMFAG/DbJpFanBUwn5CdFVUGab9yueDmcKycyWDlSyzuFMvtUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 14:27:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 14:27:50 +0000
Message-ID: <cfe6e877-dbae-45ff-bbc0-3968f235370a@amd.com>
Date: Mon, 18 Nov 2024 08:27:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SWDEV-476969 - dm/amdgpu: Fail dm_atomic_check if cursor
 overlay is required at MAX_SURFACES
To: Melissa Wen <mwen@igalia.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20241114143741.627128-1-zaeem.mohamed@amd.com>
 <61209a80-9796-42db-8d3d-0b5de317c338@amd.com>
 <db124999-db4e-4f42-b0ed-86249dd20bbd@igalia.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <db124999-db4e-4f42-b0ed-86249dd20bbd@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: f02ebaf0-23f6-479d-ef08-08dd07dd2e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDFpa0RpMnBTQzNVT0ttWjhuZE8rOXdURGljK1lKRXZlWFZSc1gvdUF0V0FY?=
 =?utf-8?B?Nm5zMkppRkd0aUN4UmtDRHVVQTM5dUxEOFVETFNTc25Rcjh4L3UrTkNFWjB0?=
 =?utf-8?B?b2lnV3NLUGdsMGpjV0tXSTN4VWVxVkh4VDdMMWJHbGQ2eDl4b2l4TlMwTUMr?=
 =?utf-8?B?eFNzWkFMK0o5ZzI0NnhQWFYySjhuczlJRm8yQkh1VE5FNy9mU3hsLzJucjI1?=
 =?utf-8?B?OHUyVlE1MXJnbFVvVGVSczVFa09OaXNMYmVGZFcxWHBYd3FLbldNZjBDVXlJ?=
 =?utf-8?B?MmNHQmhWcjVCTE1aZTNsdytMS0tLM2pxZG01UU0wRVM0dm9ReXRGclNwNjRI?=
 =?utf-8?B?QXRjSTlyTTdaTG9CSTEzdmNZczBmK2Y1N1p4NGhxTWlkOUhRZVZEdTlZSGQr?=
 =?utf-8?B?ZE5NalJIRFkxU05zYlRqempzZ1hNRHVXN1Z1U0dtNElNYjFoMUc1N2xpWVE0?=
 =?utf-8?B?RHhNUDFBNjFhc3FBYll6dnZuMGRGTUMwMW9OMExNUWt3c2JsRmhRRFJXZ0dl?=
 =?utf-8?B?WC9hcGthNWRFalEzOGp3ZkxCeGVaaVlYaW1CbVJqWnJYc2JjR0lJWjRhazZm?=
 =?utf-8?B?ZEtnTVg4RS9YZDhsTHlXeWxrMEZtUXRTSG5tOGhJUmRiaU4xc1NmNzkxOHlj?=
 =?utf-8?B?NTNoMjZ5L2QycjlFQXFIaElmOUZSdGlqUTB6bW02S29iSGhKa0MvNnBLU2FB?=
 =?utf-8?B?MXM4RnVwRWQvdE9aeEtNQUtWMkpXM1RFNnZNQjgxay93VmVvbmQyYy9hR2JI?=
 =?utf-8?B?bnRwNDE4V2w1L1RqcEc0d25PQWJBZURPZURDRkZqWXAwV3lDZHF0QUdJWGU5?=
 =?utf-8?B?RllEamZ0S3Z0Vnd2aUlPb3JNVkJ5a1lJY0U1REJtSEgvaXIySXBwTU1LUzlN?=
 =?utf-8?B?ay90cWpoWCt3WnFWVTFJQ2ZLYkhESWE4TzdtaHVYaUM4TldXL1FXOWFFcWor?=
 =?utf-8?B?NENtS1hQaE9Rc3lUTVdQeUZtVVJyVVNCN0VVUzRUNHRwZnAveDg4ek5jME5l?=
 =?utf-8?B?Tmw3NVJSeHhSYzF3VTdCL3F0b3NxOGpuTlNZMlNrNkhIODdZb1ZRTk5qcjUv?=
 =?utf-8?B?clNyVnR1L2lQOXg0OXpxM0tJSWVFczY2Um5HaVo2c0tkaCtWbXhjeHgySzZY?=
 =?utf-8?B?NVZzS3VVTnM5SWk1TENsYStLdStBRHdGREhxdm5VRmExYnhrK29TUTZ0RUlY?=
 =?utf-8?B?SkdhYXEvSDE3bjNWTXo3Z0NzY0lkNjNON2x4QmxqT3ZhVUJwa2VwV05YejVx?=
 =?utf-8?B?N1VLeDY5VzRNZmdtRjdGRXA3dG9UMW95L1pMZ3dGRjNubzRIMzFvTjRzQzNE?=
 =?utf-8?B?Y1YxL2RZVmxEeVdRWVpOK252bWpBL3RKdWhaN0x2UUhlWXBaayt6a3o3VzZm?=
 =?utf-8?B?QlhXVHh0UnN1bGJJQkVmeE5BQVg1NVQybDFxN3c1UVFqUExGR044akFqMWEv?=
 =?utf-8?B?dmgzR1ZzK2F6RSthMEllVE9IVkhhbnJiL0IzZk0yZGtMblc3ZHV6M0NGV3Ju?=
 =?utf-8?B?K0lYR0hESUF1RDJVMUxDQkRSM1N4ZTlKOS9ueGVLQ3l5LzhNam0rRXo1K2NW?=
 =?utf-8?B?aWllSERrc1FLbkcwdnV4ZlNOdE5DdGtLa2NVdThUZ0Z6amp4UTEyejFRQXRS?=
 =?utf-8?B?OW5kRXNqcWxEaEpiekhFaU5haXhEcGJlTXY2K1dNdEFWWkJ4RURaWnpTTkxr?=
 =?utf-8?B?TzViT2R0eSt0V2t6ejF0Y09rZUsyUTdtNjZyVUxPYlZid0UxRlRseXF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUtRVEtmZ21maUpweVJGZmtaWFJDNUZHOFh0Z3R4T0E3M253OU9FZFBPR1Mw?=
 =?utf-8?B?aVBpeTBIeStRQ3hTbm1tRW5CWnlBdDRuQVdlWEZjb1VlTlJ2b3JCbkp2UE1v?=
 =?utf-8?B?NE5NR0tsOUQrVzhGeml6RXVieXhldmJDRlhCSHI3Um5nVUdyaG1ZdU5raDRJ?=
 =?utf-8?B?Z29iZ08vQmJmODRDS1ZRSGFxQitJVGhMOUpLaGN5czhkemhnN0djRVFvZlg0?=
 =?utf-8?B?VWgzaFU1YWlxWWxBSE9NS2NZTkM0UTJ1cTdnZWpZbHdLSWJOUS9WUWRya2Zu?=
 =?utf-8?B?dy9tN1gxWktIb2ZKWGk0elV5K3pzNGExYUd5WEpGbGNEVHd1YlN0ZWpPQWJ4?=
 =?utf-8?B?NTNXYWcwRDFqR25PaVdKSWk1dEVVcFVERDhDZVVod2lsNFA4Qy9tUml6ZUNH?=
 =?utf-8?B?dkw1aUhkTzdOcWZrVStUSFdzYU9vMTZabjE3R3l3dVdnaUh4Nld0OFRCNmpm?=
 =?utf-8?B?bDFCT1NOZDlTQ1JZTGp0bVZZbVdvZ1QxZ2xqS1Uvd1V0SHpiVUVheUFHejlY?=
 =?utf-8?B?ekdTRXBJVkhMMm93TjRsUXg1WDJzYTE1OE5TT0pPTHRLY1VLRjQ0eVNvWStF?=
 =?utf-8?B?bGs2cExzOEduVnlDR0w1Ry8zeGFpbjBzNkhhc0cvS1F0VGxlbDBjMDJNV0dT?=
 =?utf-8?B?OXZjRFVpMDlNb1kwQWNIOVNGeXp4YWJyQUk0THNvTFFCWlAyaFVpWUVsSGJ0?=
 =?utf-8?B?UVUrQ2s0ek5SUHBneGJEaGVyVWMyRitYRW9MSDdmRE5ENEtjdnRwM1VXeEpL?=
 =?utf-8?B?NXdma0dHTWpMZ2JzQmFtTTRHS0NxRHovS1pCbG9EcTMrN2Q5RU1YZU9XWS95?=
 =?utf-8?B?ckgxVnRZQjNQcUNJMWxkSW9YZ0JSbUxDY0xPNFlaeWZKcGRFZml1K2ZDNWdz?=
 =?utf-8?B?aG1ja3d6b1k3SDQxZWdURmxWajhqdnhNVlVCTEczUFdGdng2d2Rjdml4OFBH?=
 =?utf-8?B?NjArdWpEdzk0NFBKMEpmaStUdkRoSWo4WUhCc2Z5b1JjSkRFdnBHaGtXSlJC?=
 =?utf-8?B?SHByN2psNWdWZkxxZm41Rjkrd05JWkxRdmtvbzZxL3U5NzdOQjc3NVIrVkRF?=
 =?utf-8?B?aWpoSXUrQXRkLzI0MHMzWGRWMzNoRU9tMjAvU05qazd4V3FIR3IzTDJHM3or?=
 =?utf-8?B?NlRuZGtOUDQzMmtUN0hIaUE0S2M2WWF1VmMxOE81Nlh3WXUvS1hEb0U5eHkw?=
 =?utf-8?B?dVdoUk5rUjhGR3dweDdlSi9pTms1eWRKN0RySE41T2VZT0c1UXdiZm5WRkRP?=
 =?utf-8?B?emxpNFErOEtsUmxpaUxnbm82eDlPVU1vMzJYRXdpamY0NXZDcGMyVHZTa1NK?=
 =?utf-8?B?QnlpRE1xZVZXMzNIellPbVU3ZkFGS0hpZmYwZkhRNDVXaTZBZzdxbXdWRnRD?=
 =?utf-8?B?NDZQVzNBMzhTRU1adjVzSDJML1RUVXEyaDVSQldQK1hJSkVSWm5sWjdkYVlS?=
 =?utf-8?B?a1Q5OWY4cFlXMmlaZjgvejh2bEt4bzQxZUthZkx0Vmx6RzN5cGpEbDg3NWJa?=
 =?utf-8?B?aCsyekc1dzAzM1NDUnNpaC9MaitaSnVjWDFrTlU2Ykw4QmNQaEIreUNyOHRI?=
 =?utf-8?B?MER1YTRnR0c3RzdhTHpyY25ZaXVySCt2aVk0aWJjNkNzWVZLV002TS9QaStk?=
 =?utf-8?B?eHF4U2VhMnQycnZvVjFHaEczWmF2WkxoT2k4NkMxWFFYQlA2cy9CblNHdkpm?=
 =?utf-8?B?azlGQk15bUtCQlo1R05ub0FYNHhobThLK3AySHlSL24rcTFRQTZKd3o0T3Fk?=
 =?utf-8?B?aXh6NTdJUW5RMzdLNTcrbzNOc2dBc003MTBpT09zUWNIM2dOOUhJTlBieVdl?=
 =?utf-8?B?MHI4R25ydmJMQ0JmZkt5c0wzc3dRTnBPTnJvZm1YNzFWUkgvM1FUMlhkR2Q1?=
 =?utf-8?B?a245MHFlMTM5Y1VURzFNbmFuc0QxMHpMeDErYUlFMEdqZmk2Wi9WQkRnN2dO?=
 =?utf-8?B?dXpXdmprOS9pYVdYUGQ5eTlEb2hLQkdXeDFwZkZlMEkrblZsbnVFNUNraUJP?=
 =?utf-8?B?NWtpSEN1ckNrUWc5dHZCZzNaZGZkMXdyMTBUOEtIUHl2M3l4c3dqQ2ExeTgw?=
 =?utf-8?B?Slg3empsbFYraG1WOFVoUXkxUStBTTlxNlVDRm9RM085UTQ0YjZ0NElLaDUw?=
 =?utf-8?Q?NDroe0ok1Z8o+z3WyncfPNtLi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02ebaf0-23f6-479d-ef08-08dd07dd2e0a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 14:27:49.9696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9lWs699D94A+51dui0zHzvM7i0vTR7sHeBPMWiJg3LyVkUefpFH4fLyZOdtVMhem8otm01KvDITxz2j4z5PKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811
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

On 11/18/2024 06:52, Melissa Wen wrote:
> 
> 
> 
> On 14/11/2024 16:04, Mario Limonciello wrote:
>> Although it's really useful information for AMD people, the Jira 
>> shouldn't be in the "title" of the commit message.
>>
>> "If" we want to get into the habit of including this information for 
>> display code we should come up with a prescriptive field that goes 
>> into the commit message during promotion and it should be part of all 
>> patches in the promotion that have it.
>>
>> Something like this:
>>
>> AMD-Jira: SWDEV-476969
>>
>> Probably need to align that with other stakeholders though before 
>> starting that way.
>>
>> On 11/14/2024 08:37, Zaeem Mohamed wrote:
>>> [why]
>>> Prevent index-out-of-bounds due to requiring cursor overlay when
>>> plane_count is MAX_SURFACES.
>>>
>>> [how]
>>> Bounds check on plane_count when requiring overlay cursor.
>>>
>>
>> Any link to failing bugs or anything like that you can include?
> Hi Mario,
> 
> About this question, these are the related issues:
> - Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3693
> - Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3594
> 
> You can find more details in previous iterations related to this bug:
> - https://lore.kernel.org/amd-gfx/575d66c7-e77d-42ea- 
> acbf-412d6e508a0b@igalia.com/
> - https://lore.kernel.org/amd-gfx/20240925154324.348774-1-mwen@igalia.com/
>>
>>> Co-developed-by: Melissa Wen <mwen@igalia.com>
>>> Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
>>
>> You're missing Melisaa's SoB for a co-developed patch.
>> IIRC this should fail checkpatch.
> I already mentioned before, I don't think I actually co-dev this code, 
> so Zaeem can remove it in the next iteration.
> 
> ---
> 
> BTW, about the implementation:
> 
> As I don't have the proper environment, I asked reporters to check this 
> patch up and it doesn't help prevent interface freeze.
> It seems to prevent the out of bounds bug but is causing a page fault now:
> 
> kernel: BUG: unable to handle page fault for address: 000000000174e354
> 
>  From their feedback, I found curious that MAX_SURFACES -> 4 prevents 
> the freeze but not completely solve the problem.
> MAX_SURFACES -> 6 solves it, what let me consider that the MAX_SURFACES 
> vs MAX_SURFACE_NUM vs MAX_PLANE mismatch might be related.
> I'm going to analyzing the logs but you can find more details here: 
> https://gitlab.freedesktop.org/drm/amd/-/issues/3693#note_2658994
> 
> BR,

Got it, thanks for the context!

Zaeem, please add links to these in your next iteration of the patch.

> 
> Melissa Wen
>>
>>> ---
>>>   amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/amdgpu_dm/amdgpu_dm.c b/amdgpu_dm/amdgpu_dm.c
>>> index 97e0a1bbba..964497c613 100644
>>> --- a/amdgpu_dm/amdgpu_dm.c
>>> +++ b/amdgpu_dm/amdgpu_dm.c
>>> @@ -11821,8 +11821,16 @@ static int amdgpu_dm_atomic_check(struct 
>>> drm_device *dev,
>>>             /* Overlay cusor not subject to native cursor 
>>> restrictions */
>>>           dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>>> -        if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
>>> +        if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
>>> +            if (dc->current_state->stream_status->plane_count > 
>>> MAX_SURFACES) {
>>> +                drm_dbg_driver(crtc->dev,
>>> +                       "Can't enable cursor plane with %d planes\n", 
>>> MAX_SURFACES);
>>> +                ret = -EINVAL;
>>> +                goto fail;
>>> +            }
>>> +
>>>               continue;
>>> +        }
>>>             /* Check if rotation or scaling is enabled on DCN401 */
>>>           if ((drm_plane_mask(crtc->cursor) & new_crtc_state- 
>>> >plane_mask) &&
>>
> 

