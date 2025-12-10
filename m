Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB20D3C924
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 15:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D31810E165;
	Wed, 10 Dec 2025 15:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CvOmZbn7";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012001.outbound.protection.outlook.com [52.101.53.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F0A10E165
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 15:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWnIMdg0SlkGpGo276xIVd66Lt0BwaxPL+tTRIIWhsBYV2+yQxLlSTJObEpyi8l1FXUv8xCsqz/mblQv8JmHHIUurNjcWSe/HoTLVWgNnAQjEB56H9ISE/Fwt3ior0+ORKtrEjqfwdzAAIELRKT8er9ABugahBSmOZkTW4E1duhE4+5IiycIPcUSFRezKMZWU4KU2rVyDScDMn5tVa3BdQv90sRavvuiuO///x0S6t+D0omtNEGWGMCcrjUqD+O8eZNgjAKISe66OiUuJFvUqqC1Nsxg/FfhcYc4MzOoxWS/kot1YAxtCGR+dbg8IP/96GEi/Kw2eDu4isERfdW7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKjCKgqF+HkJtK3aYq0k6mwZ0qqpc3Yitn7vkHQLB1A=;
 b=qViMe/zlbxelCe3Qgg9RpkP3UltaqIAIZXpdTl3kE0LIAHXNn9hcubXXvSSwB2k1l2GfYJbuCb0Mt73QI3NhgFGhPWllrm/Bd9h/nG6fhfRzmNInYNawanM6U855pKfPJsma5z8wmgt8HWnK05F/HtBnk/x76VIHgzgODB8hcf/xAOQzgtsVBUuiqJ/8q8niY28Aipox9nSDSL+Pl5xrvlbiuta08ofr62XTJfpQ6bnnEn2g4Kgz95SpyMhHNrYUcRlRqSuVPAGq/tlavwEqGvqv6SiT7X8FP9gwyfSj8jrLSnZS5GtwJ+EHzSV1orqDcbYJ27q0Y0BQF7tT8xN12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKjCKgqF+HkJtK3aYq0k6mwZ0qqpc3Yitn7vkHQLB1A=;
 b=CvOmZbn7aSEgLh5OyUYOBgLrdbOqWjIQnyJOR2y1gFvExlKZTnNWITdYNj1SJWicscM1TbsQqLNqbTHNfUzMBlXp3J4A8g57NvzU0loJNwCCBH9LnSM67/ASYBkLpyH0BpmTiv6UMDC5Pbgl/8MkLW+IRnkCVxB0srdUqm3hM2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Wed, 10 Dec
 2025 15:27:12 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::29f2:4b41:f65f:248d%3]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 15:27:12 +0000
Message-ID: <0b7f7550-2b0a-4da7-a0c0-79745c51f32b@amd.com>
Date: Wed, 10 Dec 2025 10:27:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Fix SMU warning during isp suspend-resume
To: Mario Limonciello <mario.limonciello@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org,
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: benjamin.chan@amd.com, bin.du@amd.com, gjorgji.rosikopulos@amd.com,
 king.li@amd.com, dantony@amd.com, phil.jawich@amd.com,
 Gjorgji Rosikopulos <grosikop@amd.com>
References: <20251210015140.568540-1-pratap.nirujogi@amd.com>
 <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <db479aed-d96d-414c-88f2-a699accf24f8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::34) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: ce345524-4a8d-4efd-7657-08de38009710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWx0YStFWVN0NE9xKyt2VlMxcmFpbkpEbkVqZ0FLS2tLU3JUcTVFeWpQZGU2?=
 =?utf-8?B?VSs0Q0M3QzlWa0RPZ2lCWGV3ZHBrQjRNRVd3bDArKzJFcFg5eCtYclBLcE5q?=
 =?utf-8?B?alRDME9MS2VUeDAxMU1VU1ZFT2ljSG9lU2MwdmZvS2oxZGJ2NzU4ZlR3eW1C?=
 =?utf-8?B?SUJjNmhwSklwd1hqWkFBeFRxV0VBZFZhVUtVUklUZHVKVEtMVlNhcDJPTEV5?=
 =?utf-8?B?V0lJU1V6NzF4dFg4b3JuNGR1bmFaN1dZeFhRTVdmenRkUUpqN0c5ckNzc0JY?=
 =?utf-8?B?VUxQUmVRTkVJMy9lUGV0bkVhZG9oT0pwUittOEk0RWFmaXRJVVNuN3lnY0J6?=
 =?utf-8?B?QXhTcmtIRDR5bytHMGd2NTRqeHAwT3pzd1l0UFkxVi9vU3N3aDQ1d1NkWWxq?=
 =?utf-8?B?b3NnbnRuNjhaNG94ZDFOczBBcC9lRXB3bTl5eGtnZFh3clVzY1NxZmVOT2x5?=
 =?utf-8?B?Q1lTWUJEQmRrQXU3RGdLNERUMW9INFVyVnpFM3AxWXRTZXZkQmdBdUFiOC9P?=
 =?utf-8?B?ektIUjA2Nzl5Z1F4Skl2NktBcU9QU0JlNDhGdWpqY3h6RFBKZi9FTkdJYldC?=
 =?utf-8?B?aVRzK254YVcxckloTG80UW5YajhWblp5ZVdjaksrb0crTlZ5MHMvc1ZLd2gz?=
 =?utf-8?B?aXRLa3BHUUNZTGQrUU12M1VjNlRQbmUyUzh1aS9GeHl2Sk5sM3BOdmVseWVL?=
 =?utf-8?B?N1BwbjFVZWNUMlFKZjEybkNFSmJsOVFjVVhDbEkvdTVjRGJPREc2cWNscnAx?=
 =?utf-8?B?dnAraC8wRHpsN0gyV2xMa04vRS9KazZremFqYnZhQkFuRlFyemh0aVo2eVFR?=
 =?utf-8?B?OElLS3ViQVNPbmpWRzBJMm5TQ2pIUU9xcjh2c1dYNVQrUmc0UWUwc2dBYThs?=
 =?utf-8?B?WVZJVFdibWloWXZTcXREZDErNE5KVGNMWVJ3Nk1Fa1MrNkF3TC83MVFVMVVK?=
 =?utf-8?B?bmJNL0Rzd3FFWWhxWS8ra0tWMTIyeXNmTGdYMkUxNTZNSTRtMWhja3NscU1H?=
 =?utf-8?B?ZGpLNHJGM2I1OC9mVkZQeTRITVJBQlJIcXFzZzY5RURGUWNwNEJLQlRIZEhZ?=
 =?utf-8?B?ZS9seGdaOGlvdGFLRm5NcDd2RmtUZzBHTW5rQllTNjlUTEVQYlp5UWNPb3VU?=
 =?utf-8?B?RXJFZ1BDa2xtQ2JiaTNXcnVaeGM2SWJRMWk2RUxtZXBSdjYrbEw4SlF6RUdJ?=
 =?utf-8?B?RVBQcFhIZVV6TzVuY0ZKUTlPbU95MjVOazFBV3BpajZCYTFHNTJETGwzTXNR?=
 =?utf-8?B?Y1M5ZEFNS29SbmRKNUIxWnZMbXhsbmpRK3VxMEtuZFZvZWh6K3ZqbzdaUy9O?=
 =?utf-8?B?UGdDaElZMndOMUZrekFIQU93Q1drOG4xNzNrKzhOb0hqbnNIM2JvUXNRdHJa?=
 =?utf-8?B?eWdpdm9ZM2krZXMyZ0FzTkZkV1dTcVVUVm40UUNJckVvNXl2eDd6blJSamN3?=
 =?utf-8?B?TFhmekIzcXFMbDdqT1NmbnBZVHpDOXIyb28rT1U1NkdqWG9obTF6RExrNmVK?=
 =?utf-8?B?NG0wSThvRHJjREs3dC9kQmMraVFnVTJPclJuQmVpcTE3ZkVlWFd0TG04UTcv?=
 =?utf-8?B?V2QvekNneHZwaEpnOTVOZXl5cnN6STkyVEhneWxROFBveUw5czVIblRPUkE5?=
 =?utf-8?B?LzdESXVJak8rMEhnUGVidnV5b09TVEhsMUhaZ0FuQmV2WDNDcElKUEtrVGNq?=
 =?utf-8?B?TTNkdmF0Zi9senZBaHJwQ1FmY2RaYTdNVnZwMTR0WlJxTmNSd3IzWXVOOXE3?=
 =?utf-8?B?Zk1vN1NacS85NGFJZU5sTVdkZTZ6VVBLSnZWN1J0MnNVcS9rQmt6SFRRZ3Fi?=
 =?utf-8?B?bVlobWswSHQvc3UxdGVmQWdRZ1BxMmUyQVVSSmgyS1p4L09oYU1JV2hkNC9O?=
 =?utf-8?B?QXRBTmZjbzE2SmRBY2pQcE5tdUdhbWJ3dWxjY1hJa08vSkcyWk11c0pHekNW?=
 =?utf-8?Q?qRe33tF1RVMbTCmdkfaTqC1gOP2BfVVM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlmODJuTmRwUGlhWVMyeUZRMG54ejlCblk2S1JFa1ArNkRPNnMrdGNoWTJq?=
 =?utf-8?B?emVNM2lGd2hRd21NTmdCdlBySTFYWVJxeXN0T0VWbGd3Qmp1SWRBaHJoZkgr?=
 =?utf-8?B?dHR1ZUVrUnJFMGVTYW5OUi9jeFozcjM5cXN3NE00aU1acG5KNkw5Nk9DTlNM?=
 =?utf-8?B?bmk2MXhBSURtQ09yOGQ3bVJ0NDVYS2VzVjZWTk5pTHkyaFhsekd3YjNISDlV?=
 =?utf-8?B?WjN0eW50ZGJRZmRUeHgvcll0OUNDL0hWK08rdDhVOEJtY2NiUzEzVVU5K0pl?=
 =?utf-8?B?aEVjSUt3OEprTVp0WnRCQU1rN3RJcjV1SVVpbWhXTlRMbEsydVN3bW0vQ1lD?=
 =?utf-8?B?Q0RDNzRTQlZHRVA5clJvTWFTakg1WXhrTWRBZFFGM3dBeks4QVR5ZmUySkYw?=
 =?utf-8?B?cGhuMy9BOXR1ckF4QUV4RUZoenVvNUxDbjJYWUJ2eGNIYUdrSUVuZXVQR0JX?=
 =?utf-8?B?Q1U1algwZ0J2d1BhUHZtN29Zbm5VeVVJa0ttK0U5akx3WEZNSkVxMkU2dndQ?=
 =?utf-8?B?OFIzeGxPQmpobXBpcGk4djBjeTE1WHVyVkFaa3pROVpPa0hROW9BSXVRaWpq?=
 =?utf-8?B?SlRXbG1id3U5L3pPVjE5aHI0cGNSV0NCT1FDNkRFckZRT0RjTXh2ekVxRlhY?=
 =?utf-8?B?Y3E1VTlTUE0vakJyWmt3eUM5czVqRFh1ZThhTjEvd3MrVS9DRThxT1kwYmR6?=
 =?utf-8?B?cXJsMDdsdGV6WmE3cXJpaS9NNXJmaUU0QVBMY2REeUs4NW94cUJFQkZ2QUla?=
 =?utf-8?B?TmF2aUJiZzc4T21aMUJ0NEE2dTkyM0VuZ1NTTVRBd3pRMlZ6SXRjS0JUcjN0?=
 =?utf-8?B?VW5teUdYNWwzdlhFaXRQTFdTZ0lBV3lDT3BORWxhWUxtN2tRWGN2LzRhSHJV?=
 =?utf-8?B?SnZRbTlVdUhDUEt6RjdjTzFPandaRERVRGtxVEkyZjI2eEdOMWU5bHYxSTQ0?=
 =?utf-8?B?M1N1bHBXdE9LYWxxaHVMdHhpY1lDWjZMWjFaT3cvN1UvN3ZQZHRsUmxEaU9W?=
 =?utf-8?B?dnd1Nm5oNmFMZ0dZM0l6cXdvSEN1SWdCZUpaVWk0MS9taWZ5SktuR2c5SDdF?=
 =?utf-8?B?TnFENVZXcHpRSXdUUmRPa2FCd1UzNndONVpKdFduV0ZPZnFYOHRnbTVFQ0tX?=
 =?utf-8?B?UHgrbFFxWlZjUDgxUm53c3ROVmRSUEhmOGl5VExJaUt5K0YzdFBaSkpIdzF1?=
 =?utf-8?B?R3pPZzN2bHVWdVBPSWphMzhXcC9qdmJJRlNUSzRWYk5TTkJHOGlJODMwS3hZ?=
 =?utf-8?B?R09EdzllbytyOFRiOTdMV08zSW9nd0xtS0M1TWFVVmR3dDZHRW5mZGNOOFVI?=
 =?utf-8?B?OFkzeFdYeVF2eDk0bUZHRzY2VkRDR1JMVnFKVGpFUEdnSkR6TDNFRTVVYkRh?=
 =?utf-8?B?NE9FdVNOMHNjRGZVbG5oV0oya0lNc0JjQXlxSVpjNTdqZnlWOXc2LzhYa296?=
 =?utf-8?B?Q0J1NkluZkFGQ0ZzcU5VNUlUVklhNGRuNHdYdDVzT3VHSkY5TzRlK3A5TDZm?=
 =?utf-8?B?U1U3b2dmV1VDZzA1Z2VyU0htYWNCaUtOdlovclpWcUQrY0VBV2plTkw1dGxR?=
 =?utf-8?B?U1l4MnFNUHF6WkFGOExiWDh0Ukp2WWVPMUhFNHNOWTdBQ1hPdVJVd1RDaVdp?=
 =?utf-8?B?T0V6RHhJZGRBSjFNTkJNKzJjQmI2Y1ZLTWxsdzU5VVU3NlJtR1R4VlJmbHlY?=
 =?utf-8?B?Y3JzTzZuSHRMYUFCbW5ENWV3SVpPZG5GTHpKbDBEckpJNW5CdnV3RWRld3cy?=
 =?utf-8?B?WkoyLzY3R2lLOXNKeTdlLzByMFlFVmVPdHJaaDJ6eGtZT0YxeVEyd25CVDhk?=
 =?utf-8?B?U0c1a0daSm5uVno3Mnh0TW1RVUlRdUNxL0ZrZHNLTEY5OWFrWWowQUl1ZEdS?=
 =?utf-8?B?MlpQUGN2TW1EK1kvWUJLaU5wQ3lQWXVVTTVvMUpDcnJhVVltWmkyMzkwNG84?=
 =?utf-8?B?MHdmRTVZSURpcGwwV01SQURHMExPaE13U0haUkpaMHlLaFByVU9SdTkxVlJV?=
 =?utf-8?B?TUpmckc2eFBHRHF1c3BuT201MkEzUnovbjJobW5jZ0JuWHpOUThQWlJiM242?=
 =?utf-8?B?dmlob1VBNXRaZmpDMHU3YXVnQVdNVmVHTE9jdk1UU3ZrTXRYSkFMekdhaDBU?=
 =?utf-8?Q?EJBrKSBlhtwlSxiHj+VUO7t3p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce345524-4a8d-4efd-7657-08de38009710
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:27:12.0346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7ikUJWBUaUnBV4Kx56XjWu/dOEcRlKK12P2pSzVIHByDgwXjzeaiKIdlruAQt9ZH/5G5L3+iRCoshpX4/FzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6
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

Hi Mario,

On 12/9/2025 10:28 PM, Mario Limonciello wrote:
>
>
> On 12/9/2025 7:50 PM, Pratap Nirujogi wrote:
>> ISP mfd child devices are using genpd and the system suspend-resume
>> operations between genpd and amdgpu parent device which uses only
>> runtime suspend-resume are not in sync.
>>
>> Linux power manager during suspend-resume resuming the genpd devices
>> earlier than the amdgpu parent device. This is resulting in the below
>> warning as SMU is in suspended state when genpd attempts to resume ISP.
>>
>> WARNING: CPU: 13 PID: 5435 at 
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:398 
>> smu_dpm_set_power_gate+0x36f/0x380 [amdgpu]
>>
>> To fix this warning isp suspend-resume is handled as part of amdgpu
>> parent device suspend-resume instead of genpd sequence. Each ISP MFD
>> child device is marked as dev_pm_syscore_device to skip genpd
>> suspend-resume and use pm_runtime_force api's to suspend-resume
>> the devices when callbacks from amdgpu are received.
>>
>> Signed-off-by: Gjorgji Rosikopulos <grosikop@amd.com>
>> Signed-off-by: Bin Du <bin.du@amd.com>
>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>
> Who is the patch author?  If you guys worked together, there should be 
> Co-developed-by tags to represent it.

I authored the patch and is developed by Gjorgji and me. We 3 discussed 
and verified different approaches and finally concluded that using 
amdgpu suspend-resume path with pm_runtime_force api's is the most 
effective way to handle ISP suspend-resume. Will use Co-developed-by 
tags in the next version.

>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 24 ++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  2 +
>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 59 +++++++++++++++++++++++++
>>   3 files changed, 85 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> index 37270c4dab8d..532f83d783d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> @@ -318,12 +318,36 @@ void isp_kernel_buffer_free(void **buf_obj, u64 
>> *gpu_addr, void **cpu_addr)
>>   }
>>   EXPORT_SYMBOL(isp_kernel_buffer_free);
>>   +static int isp_resume(struct amdgpu_ip_block *ip_block)
>> +{
>> +    struct amdgpu_device *adev = ip_block->adev;
>> +    struct amdgpu_isp *isp = &adev->isp;
>> +
>> +    if (isp->funcs->hw_resume)
>> +        return isp->funcs->hw_resume(isp);
>> +
>> +    return -ENODEV;
>> +}
>> +
>> +static int isp_suspend(struct amdgpu_ip_block *ip_block)
>> +{
>> +    struct amdgpu_device *adev = ip_block->adev;
>> +    struct amdgpu_isp *isp = &adev->isp;
>> +
>> +    if (isp->funcs->hw_suspend)
>> +        return isp->funcs->hw_suspend(isp);
>> +
>> +    return -ENODEV;
>> +}
>> +
>>   static const struct amd_ip_funcs isp_ip_funcs = {
>>       .name = "isp_ip",
>>       .early_init = isp_early_init,
>>       .hw_init = isp_hw_init,
>>       .hw_fini = isp_hw_fini,
>>       .is_idle = isp_is_idle,
>> +    .suspend = isp_suspend,
>> +    .resume = isp_resume,
>>       .set_clockgating_state = isp_set_clockgating_state,
>>       .set_powergating_state = isp_set_powergating_state,
>>   };
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> index d6f4ffa4c97c..9a5d2b1dff9e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
>> @@ -38,6 +38,8 @@ struct amdgpu_isp;
>>   struct isp_funcs {
>>       int (*hw_init)(struct amdgpu_isp *isp);
>>       int (*hw_fini)(struct amdgpu_isp *isp);
>> +    int (*hw_suspend)(struct amdgpu_isp *isp);
>> +    int (*hw_resume)(struct amdgpu_isp *isp);
>>   };
>>     struct amdgpu_isp {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c 
>> b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> index 4258d3e0b706..560c398e14fc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>> @@ -26,6 +26,7 @@
>>    */
>>     #include <linux/gpio/machine.h>
>> +#include <linux/pm_runtime.h>
>>   #include "amdgpu.h"
>>   #include "isp_v4_1_1.h"
>>   @@ -145,6 +146,9 @@ static int isp_genpd_add_device(struct device 
>> *dev, void *data)
>>           return -ENODEV;
>>       }
>>   +    /* The devcies will be managed by the pm ops from the parent */
>
> devices
sure, will fix in the next version.
>
>> +    dev_pm_syscore_device(dev, true);
>> +
>>   exit:
>>       /* Continue to add */
>>       return 0;
>> @@ -177,12 +181,65 @@ static int isp_genpd_remove_device(struct 
>> device *dev, void *data)
>>           drm_err(&adev->ddev, "Failed to remove dev from genpd 
>> %d\n", ret);
>>           return -ENODEV;
>>       }
>> +    dev_pm_syscore_device(dev, false);
>>     exit:
>>       /* Continue to remove */
>>       return 0;
>>   }
>>   +static int isp_suspend_device(struct device *dev, void *data)
>> +{
>> +    struct platform_device *pdev = container_of(dev, struct 
>> platform_device, dev);
>> +
>> +    if (!dev->type || !dev->type->name)
>> +        return 0;
>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>> +        return 0;
>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>> +        return 0;
>
> Could we store the mfd_cell pointer instead and just compare the 
> pointers?
sure, will switch to comparing pointer handles than doing a string 
comparision, will address it in the next version.
>
>> +
>> +    return pm_runtime_force_suspend(dev);
>> +}
>> +
>> +static int isp_resume_device(struct device *dev, void *data)
>> +{
>> +    struct platform_device *pdev = container_of(dev, struct 
>> platform_device, dev);
>> +
>> +    if (!dev->type || !dev->type->name)
>> +        return 0;
>> +    if (strncmp(dev->type->name, "mfd_device", 10))
>> +        return 0;
>> +    if (!strncmp(pdev->mfd_cell->name, "amdisp-pinctrl", 14))
>> +        return 0;
>
> same comment as above
sure, will fix it in the next version.
>
>> +
>> +    return pm_runtime_force_resume(dev);
>> +}
>> +
>> +static int isp_v4_1_1_hw_suspend(struct amdgpu_isp *isp)
>> +{
>> +    int r;
>> +
>> +    r = device_for_each_child(isp->parent, NULL,
>> +                  isp_suspend_device);
>> +    if (r)
>> +        dev_err(isp->parent, "failed to suspend hw devices (%d)\n", r);
>> +
>> +    return 0;
>
> Shouldn't you return r?

yes, thank you. I should return r here, will fix it in the next version.

>
>> +}
>> +
>> +static int isp_v4_1_1_hw_resume(struct amdgpu_isp *isp)
>> +{
>> +    int r;
>> +
>> +    r = device_for_each_child(isp->parent, NULL,
>> +                  isp_resume_device);
>> +    if (r)
>> +        dev_err(isp->parent, "failed to resume hw device (%d)\n", r);
>> +
>> +    return 0;
>
> Shouldn't you return r?

sure, will fix it in the next version.

Thanks,

Pratap

>
>> +}
>> +
>>   static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>>   {
>>       const struct software_node *amd_camera_node, *isp4_node;
>> @@ -369,6 +426,8 @@ static int isp_v4_1_1_hw_fini(struct amdgpu_isp 
>> *isp)
>>   static const struct isp_funcs isp_v4_1_1_funcs = {
>>       .hw_init = isp_v4_1_1_hw_init,
>>       .hw_fini = isp_v4_1_1_hw_fini,
>> +    .hw_suspend = isp_v4_1_1_hw_suspend,
>> +    .hw_resume = isp_v4_1_1_hw_resume,
>>   };
>>     void isp_v4_1_1_set_isp_funcs(struct amdgpu_isp *isp)
>
