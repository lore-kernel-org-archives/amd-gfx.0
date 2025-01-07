Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3558E77198
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 16:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B6410E0B1;
	Tue,  7 Jan 2025 16:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cU4ZXFZ5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FFD310E731
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 16:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxf2gKfHX9IfBmP9L+ZJ0BejfaCBoWEJNX14UKnVg4X4TfcRqXJIIJYwekccrjZRGQbCOClTqyHh7WL2NPSDZ34IYAHbpgeXAi2IqGb6mbzzvKBXe2iuuhJHYrp3chhhycayi88S464vNYLrfgNutlhtUyPTYgnlQHJanYunPTXEMJaZf8hLsWPVQ8X37BdUes+JPgIPdrbDqxTLNCBlUqSPTRKkJ5ScCWbv71goerAcEMYcxDKPBVT3vfxE5JZOZmduTapM38oz5/jP+jmgpVoFZ60MznmrxCtr/C/vjmyBLh8ft6a6zeTkUeQzyUppyzwjfPbGKx6D+XY49lvHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhwGWxRApHIfQp4OJwCDv8rAHJ3zNRt7zpCNoA6AavM=;
 b=KpHr58+TXf64xPJwCUaDhLifGaKGNsSJmvejj8VdT8/dv5Nzas7kbVJUb/pbhWhYk/sERPhTpXBGc5BNcGRSYIuZSTz6exjTmsrMgjgqmfN64/9RU9vZtECc01uWLs6SD2daF665CcZ3C4u+bv3+89n92noqsK56PUpbY6Fiqoq02abmkQAKXCE/zV1ZZ69hSu3g/9mvajg+BOvTK3MjKef1v9b0V2D5chPxu3TSntVNr8Z5kxAYsoJaTcS64lHPvYm/2jdDTfWkQFD9FawtWWUuRGjuMV68h/JOZ+Cccul4wXBBMcnaFX/a8lBG77T+KB8Rv13FU2Rv5XL5oQGgyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhwGWxRApHIfQp4OJwCDv8rAHJ3zNRt7zpCNoA6AavM=;
 b=cU4ZXFZ5bQUQp2boZ10tKYqegkT5HGbaL3VmpJvY0eythOIpeXPir7ZE6vtZu7NR0CNXrxxOg1hKMjObUyWv7UVjYAia2ozvj47JOWvLvnjq9pMCLVRpYRdnn4rzFfSg3uel8CMLl0v+f2OCAW431f5EDNdofCdToYlfJ7Zmyz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Tue, 7 Jan 2025 15:50:56 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 15:50:55 +0000
Content-Type: multipart/alternative;
 boundary="------------qiaXsBjFtqkg8pAI310TcRuG"
Message-ID: <19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com>
Date: Tue, 7 Jan 2025 09:50:53 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <40e6b31e-c77b-4d89-a051-215eb4ddff46@amd.com>
 <PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: aa22c78a-b2e7-4d25-c366-08dd2f331269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUlZUzg2T0M4N0NHbkMyTXBJaHdhUGw0S3hwM3VKTTRGYXhSS0lOZGRMcUdL?=
 =?utf-8?B?VjJkQXBqa3FIbEZFOUFiZ2ozeVpJRlVKUWVsRVVvem9hSVdYWWFpOFdySGN6?=
 =?utf-8?B?ckRMUmt0Yjk2dmMxY2xRZVhQZUJOVWR2VFhRZVJjemJ2ZTUyOGhKa3dUemtl?=
 =?utf-8?B?QzhkZDFObzRJMVZwK0lIbW1vTFp6NGx6cml0Y0ppZy9ydzlaZ0IzMy8wV050?=
 =?utf-8?B?bXdPcXZJSzJpcTlQaWdWcnA1WnF6c1IwSjAvNFlMb2IzcmRiZWZQYTFZdDMz?=
 =?utf-8?B?YnNyeDliTXJueUwyMVFBZUROVFNqQTFwbjFiVlN0MTk0dkNEdzc5NFBlSmYy?=
 =?utf-8?B?NWVMRmlncFhqQXhsQXNLRFhnKzdtWjJvUkI3YVN3YmsrbVBGVXdpNTNMa0Fn?=
 =?utf-8?B?MnhuKzcwSW5sTU13WTZYRVZKNzB1RStlMTVvZWVMZ3JTVjliNFJ0bnZvN0lI?=
 =?utf-8?B?NWpPTXEzN1NJbXE5c3I1WmlNM3Y4U2dYakE3a3ZDQlhTNVdvVmt6SUMzeFJs?=
 =?utf-8?B?ekFBQTBZa1hxdEplRjZ5WkhGd1NvNWdHb24vTkZVbjM3NVhvRTI3dk5BZmUw?=
 =?utf-8?B?UGthb0ZxNWVCVTlYZmlha1RHeG9iUWpRU2dodnR6OWdROVRkK2tSVFFXNjZz?=
 =?utf-8?B?MTBRanY5ckxzUWttRnZwME5TeklOTkwzWXQ0Q3pzUmlrNzlYblVkVTRTWFND?=
 =?utf-8?B?OFgxNXlYMGl6dEN1ZWI3YUE3OUJnbHZlbGxSRTdFMnE4OHFLMTRwMEVYcEE1?=
 =?utf-8?B?VjZDRUFUQkpxdXJmcFJxcEVWUnh4TjZlUHdnT0VISVhSRTQ5cGltY05RRGVq?=
 =?utf-8?B?aGlwSVh6bWJNd0xNeUduejB2L1NzVlA4bkJMNkJEQjN2MUpHRUZPTVVyWkNx?=
 =?utf-8?B?VjVFV3B2WjBzalBFMXI2UTRQeGtRRzJLR2RTTUprSVJYelRKZFJyWVNQNGxz?=
 =?utf-8?B?RFlmNkRtYXUzU3BPak5oYkVxU0xKYXZwYmRkUWdUeTQ3ZWlVNE5PUGRrNXRW?=
 =?utf-8?B?ZElJVk0rUXJwNGpWWDZMSGhFRlhDQU9WMGF4cjJLSVRya2FjeWVOdERGR05r?=
 =?utf-8?B?Qk5IL1dOTWFEa0ZpTnZPK1JuOFVQb1lkMTZBZnU5ektaNzlTY3FvU3dkNkNt?=
 =?utf-8?B?Y1lQenJ4NWFDL000SzBCaWJGdjVMc1ZEa1BnU09BbVhQSGJqYzJZRFlIZ0wr?=
 =?utf-8?B?c3pzdHhCN1MzeHlreCtXZzhWcmpGVEVNRXVETFozU2doOWFua2h5YzdwRXpG?=
 =?utf-8?B?Y1dJR210dytmZk5SQzR4cFIrUGY3MC84RG9OcGdjb2I3bEdaQ2dNa0R0UVV3?=
 =?utf-8?B?V3F3OTVIbW1lSmtGcUcxQVRPbE11QnRKTkZHajNYTVBEZ25WMURHNGhxM3Ns?=
 =?utf-8?B?cjBsVEY3NHBDR3ZSZFRrUko1YnpUNXM2Rit3RHN0VVR1SE1CTEk4K1hYZkht?=
 =?utf-8?B?a1UwZGpqVnZlRHFGWG85NmtIZ0lDQUcvTFByeHVYVlBDNFNkektqRXlFeDlS?=
 =?utf-8?B?bDJpTmFUamZxcnZvMFpaelZqTVpIWVE1V2p0d0o2TWdqcUlWbkJmbzVrMjBX?=
 =?utf-8?B?cy8zRTdsQWFNaGUrWDloRTlnR1d4Zk5wa0l5cm5GYWFtbHl1YWpwZTVTVzA5?=
 =?utf-8?B?VlY0Y0YvbEZPY3ZXbjZWRFB0d1FSNm14WHUrLzBDYmRYM25KTVR5UmUrL2o2?=
 =?utf-8?B?QkRDM1F1SzZ2MzZhWXlDSTlwVW0ybGZhNy9TNXJlN2hubFpyS0Q4bzJzK0Fa?=
 =?utf-8?B?a2pEYU1ZQ3ozSGRZVG1Yc0JFdlVtbkxrOUJ2Y1BMM0hTSW5pS2tLU1NMaXZa?=
 =?utf-8?B?VURDWkhlSDdtcUlqeUJ6amNLNDAvV1cxZEFmVmpYSU45ZSt1V2pUb2kvM2pO?=
 =?utf-8?Q?5gWCKjNSupbfM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3h4UVkzVGZkTWFaT3VKUUl5T1c0SklTMUQ2THE3OVM4RUFyRGl2NTE1T29W?=
 =?utf-8?B?MzR3dTdOcTI2aG11VTFralVWSE1xaXZLblZ2anR5Z0FwT2xoSDJpSlFsUWF1?=
 =?utf-8?B?Z2FuK25XdkZZVVV5S1NPVXgySHRoYW1pZVcwajE5UFNMekVZR2pLU1RWSTRT?=
 =?utf-8?B?STVYa3QwL0xpNEFVMDVSUnkrYkRiK0gwU3JYdXh2Sm9jSngrTjRUYytqZzJK?=
 =?utf-8?B?VW1QMjduQnpQaGwxMEQyekNHWFRLak5EVXlKVHJoTEhaWjQvMFlJY0V0S2hx?=
 =?utf-8?B?LzNuYTcxSmxoNjlaQXZlRXhTR1U5ODdnZW9nSzdrTlhMc2tnNkozLzkxWitL?=
 =?utf-8?B?TS9vaEd5UDY0UmpHQWlMeSs5aVNOTkFSc2FhZTJIbzk5Z3BTSVF5ZmpiZGRn?=
 =?utf-8?B?YmR4TWlNam1Hek8yQ2x5SkpQNDhGVVVmQVNrS0d5QTZQNndNeUJYQWQ0VC9a?=
 =?utf-8?B?Q1dBZTJJSUhqMWcrSHRHMTd0bkRqMnNCUUt4WjlJREl3VjRrVnhlZ3VYbzZn?=
 =?utf-8?B?OWo5ZDB0V3RWWG5raGRlMzJlTVZEaTlEb2VQZ0VtNHhUdzVoRUdUQTlhNDhY?=
 =?utf-8?B?UGorWXFLc2R3WElnWWp3c1NSbjl0SXg5am1LMGNzL2U1a0YwaUJ3SlRzNXo3?=
 =?utf-8?B?bmtKTldnQm1Jd3RIUW9yZE5CanE1MkI0YXFEZTRuQU93eXNGMWRWSXQ2YklP?=
 =?utf-8?B?ZGRVQTdhM2NvUGVjc1JkQmUzRVk1a2twZHFUdHQ0aXhpY2NqV09iUlAvcDJw?=
 =?utf-8?B?akthUGFXZDBTSzNMUk02amxtYUZzZ1lNTjQ3V1ZiRnd4WFdvN0NGckN1Smpx?=
 =?utf-8?B?ZHJlaUx6d2JNVCt4QWR1c0ZURzcrdEhqTzRpdFltQ21MMjRwMU9ab1RUVXpi?=
 =?utf-8?B?cUM1UHBTWjc1MmhrR3lCRzY0WjNCTkZaYmZhUUNZc3JXSldZODNna3g2UitI?=
 =?utf-8?B?WWNyZ09mclZJUjkwRGRPUXIyVVpvbDQ3KzYzYStxeWNqbG9wOHpnR3E3SDF0?=
 =?utf-8?B?bU5sdmYyQ01YSVlITFo1aFhmSit2ME9DbWNnd244bjNtemZpSXdhQnF4SGNh?=
 =?utf-8?B?OFR4aG5JZi9LMlhlOEUvdHpjdHlEV0UxMXhOVVE3ak13a0ZHQWk5L09HQnBj?=
 =?utf-8?B?Y0QzajM4ZkZSQWZuSEkvK1VSTEp3SUFJcXhMSzdWNHRndkZkeG9MMktnQUlL?=
 =?utf-8?B?YWY3Y29nODBJV2tlUHo3cEFwOFVCMk9Ec25wbWxRYTZQWXJzaDRQZHh6Uk9H?=
 =?utf-8?B?U1ExVDgwTmVkUkJLeEM0aU5EdzZvbFVvZ3Uwc1VFRHNCeHZyUjVNYXhreTRZ?=
 =?utf-8?B?RERGQnc2ekorUFhzVmVOaXZQWTFSRUQwSjk1QkZiUE9XY0x5SGtVcis4YnB2?=
 =?utf-8?B?ZGRZYUlhc0p0YjhSVCtvTEk4MmtoTVZRZEFRZzVwMHFqejB3U25PTW1zYlRl?=
 =?utf-8?B?b1FvTC9ZTkRmK09jbzNZQUtTbkVJN1JPU2JEdDhnM29iRDZpOHVzTWduV2Jt?=
 =?utf-8?B?emk2dFdwa0tYWnJTVjZJb1FoeTVHb0dlWjZtY0dXWTV5dUs1eXJReGR6NVJL?=
 =?utf-8?B?emFSN09vcDBiVTFQQXFERytWbUFnNnowRDZqdlFBN0VtcFZmTjhQSVB4THo0?=
 =?utf-8?B?ZUsveFE1SHlZU05vWEJ0bW5nNExVOTNadjU0djlXNVRlWDdiakZzKytHU2o3?=
 =?utf-8?B?L1NtM0R4bWVFVzd0d3k3UHFmQytueGZwNFgvMktWM3gvUElhaFBvanhxK0s5?=
 =?utf-8?B?VFhiS0lxU01YcWxVVklCd3EyVjdJcUxmUjRpMW5nWnhQSlIwcVM3dGJGaW9o?=
 =?utf-8?B?UGR1MVdZVWVBV0o5L3Fyb2h6RmcyekVxL3FlRUx4T0o3eXNsS1dOR3BabGlh?=
 =?utf-8?B?SDdBaUNmS0VBbndDaHJacVB3bFpiV2xVUjZKRjY0eUZaWDB1OG01QWFqTjhX?=
 =?utf-8?B?SFNMYXhHSzFrcVVmbHJGYlg3cFdNSm1yTmkvbzljZG5LTnN4U3M5bGJEaDZk?=
 =?utf-8?B?cVBzMDNNQmRtNWF0MVBhMkV5cGFxT2c2NU5lOHRxQ0JHTGp2OUt6L0x2NUZB?=
 =?utf-8?B?emd5a3J1TmVYQWF5dFIzeGl0RTRLWUExakRvcVB3Q296MUsxRE5ZczhEZktq?=
 =?utf-8?Q?Jt5Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa22c78a-b2e7-4d25-c366-08dd2f331269
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:50:55.6850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJ2ChqP4GvI53RozU6N8M8iBSxlS5hTi8irJPyVZKvSDZuQ/kTjXB+sk5D2Qj9fG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
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

--------------qiaXsBjFtqkg8pAI310TcRuG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/6/2025 8:02 PM, Deng, Emily wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
> *Sent:* Monday, January 6, 2025 11:27 PM
> *To:* Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdkfd: Fix partial migrate issue
>
> On 1/2/2025 6:06 PM, Emily Deng wrote:
>
>     For partial migrate from ram to vram, the migrate->cpages is not
>
>     equal to migrate->npages, should use migrate->npages to check all needed
>
>     migrate pages which could be copied or not.
>
>     And only need to set those pages could be migrated to migrate->dst[i], or
>
>     the migrate_vma_pages will migrate the wrong pages based on the migrate->dst[i].
>
>     Signed-off-by: Emily Deng<Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>
>     ---
>
>       drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
>
>       1 file changed, 4 insertions(+), 4 deletions(-)
>
>     diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>
>     index 4b275937d05e..5c96c2d425e3 100644
>
>     --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>
>     +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>
>     @@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>
>                               struct migrate_vma *migrate, struct dma_fence **mfence,
>
>                               dma_addr_t *scratch, uint64_t ttm_res_offset)
>
>       {
>
>     -       uint64_t npages = migrate->cpages;
>
>     +       uint64_t npages = migrate->npages;
>
> I agree this part.
>
>              struct amdgpu_device *adev = node->adev;
>
>              struct device *dev = adev->dev;
>
>              struct amdgpu_res_cursor cursor;
>
>     @@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>
>                      struct page *spage;
>
>       
>
>                      dst[i] = cursor.start + (j << PAGE_SHIFT);
>
>     -               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>
>     -        svm_migrate_get_vram_page(prange, migrate->dst[i]);
>
>     -               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>
>       
>
>                      spage = migrate_pfn_to_page(migrate->src[i]);
>
>                      if (spage && !is_zone_device_page(spage)) {
>
>     @@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>
>                      } else {
>
>                              j++;
>
>                      }
>
>     +               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>
>     +        svm_migrate_get_vram_page(prange, migrate->dst[i]);
>
>     +               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>
> I think what current code misses here is that migrate->dst[i] should 
> match migrate->src[i]: migrate->dst[i](vram page) got set for page 
> that will be migrated from system ram, otherwise migrate->dst[i] 
> should be zero. Your change makes migrates->dst[i] not set though its 
> page has been migrated by svm_migrate_copy_memory_gart for the case 
> that cpages != npages, because you set migrate->dst[i] at end of loop 
> and use 'continue' after migration.
>
> The page migration happens at svm_migrate_copy_memory_gart, not 
> migrate_vma_pages that migrates struct page meta-data from source 
> struct page to destination struct page and has mmu notification.
>
> Regards
>
> Xiaogang
>
> The migrate->dst[i] default value is 0. The purpose of the change is 
> to match the migrate->dst[i] and migrate->src[i]. And for 
> svm_migrate_copy_to_vram, it only will call 
> svm_migrate_copy_memory_gart to copy those pages which need to be 
> migrated, for those don’t need migrate pages, it won’t call 
> svm_migrate_copy_memory_gart.
>
Yes, the issue here is we need match migrate->dst[i] and 
migrate->src[i]: migrate->dst[i] need be set only when its correspondent 
migrate->src[i] page will be migrated or the src page has dma address 
setup by dma_map_page. Then why not set migrate->dst[i] at same time 
when have dma_map_page for src page? That way will simplify the logic 
and not need use amdgpu_res_next to jump vram cursor.

Regards

Xiaogang

>              }
>
>       
>
>              r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
>
--------------qiaXsBjFtqkg8pAI310TcRuG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/6/2025 8:02 PM, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Monday, January 6, 2025 11:27 PM<br>
                    <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix partial
                    migrate issue<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal">On 1/2/2025 6:06 PM, Emily Deng
                wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre>For partial migrate from ram to vram, the migrate-&gt;cpages is not<o:p></o:p></pre>
              <pre>equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed<o:p></o:p></pre>
              <pre>migrate pages which could be copied or not.<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>And only need to set those pages could be migrated to migrate-&gt;dst[i], or<o:p></o:p></pre>
              <pre>the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
              <pre>---<o:p></o:p></pre>
              <pre> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----<o:p></o:p></pre>
              <pre> 1 file changed, 4 insertions(+), 4 deletions(-)<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
              <pre>index 4b275937d05e..5c96c2d425e3 100644<o:p></o:p></pre>
              <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
              <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
              <pre>@@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;struct migrate_vma *migrate, struct dma_fence **mfence,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;dma_addr_t *scratch, uint64_t ttm_res_offset)<o:p></o:p></pre>
              <pre> {<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;cpages;<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;<o:p></o:p></pre>
            </blockquote>
            <p class="MsoNormal">I agree this part.<br>
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre><o:p>&nbsp;</o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;<o:p></o:p></pre>
              <pre>@@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;<o:p></o:p></pre>
              <pre> <o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
              <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
              <pre> <o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage = migrate_pfn_to_page(migrate-&gt;src[i]);<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp; !is_zone_device_page(spage)) {<o:p></o:p></pre>
              <pre>@@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j++;<o:p></o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
              <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
            </blockquote>
            <p>I think what current code misses here is that
              migrate-&gt;dst[i] should match migrate-&gt;src[i]:
              migrate-&gt;dst[i](vram page) got set for page that will
              be migrated from system ram, otherwise migrate-&gt;dst[i]
              should be zero. Your change makes migrates-&gt;dst[i] not
              set though its page has been migrated by
              svm_migrate_copy_memory_gart for the case that cpages !=
              npages, because you set migrate-&gt;dst[i] at end of loop
              and use 'continue' after migration.<o:p></o:p></p>
            <p>The page migration happens at
              svm_migrate_copy_memory_gart, not migrate_vma_pages that
              migrates struct page meta-data from source struct page to
              destination struct page and has mmu notification.<o:p></o:p></p>
            <p>Regards<o:p></o:p></p>
            <p>Xiaogang<o:p></o:p></p>
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">The </span>migrate-&gt;dst[i]
              default value is 0. The purpose of the change is to match
              the migrate-&gt;dst[i] and migrate-&gt;src[i]. And for
              svm_migrate_copy_to_vram, it only will call
              svm_migrate_copy_memory_gart to copy those pages which
              need to be migrated, for those don’t need migrate pages,
              it won’t call svm_migrate_copy_memory_gart.</p>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Yes, the issue here is we need match migrate-&gt;dst[i] and
      migrate-&gt;src[i]: migrate-&gt;dst[i] need be set only when its
      correspondent migrate-&gt;src[i] page will be migrated or the src
      page has dma address setup by dma_map_page. Then why not set
      migrate-&gt;dst[i] at same time when have dma_map_page for src
      page? That way will simplify the logic and not need use
      amdgpu_res_next to jump vram cursor. <br>
    </p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <p><o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre><o:p>&nbsp;</o:p></pre>
              <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              <pre> <o:p></o:p></pre>
              <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,<o:p></o:p></pre>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------qiaXsBjFtqkg8pAI310TcRuG--
