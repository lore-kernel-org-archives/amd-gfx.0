Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E63CF6C11
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 08:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E5ED10E055;
	Wed,  7 Jan 2026 08:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l67BLB2f";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9401F10E055
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 08:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGOhfftLYWdCCKHv1yPHNJV0hMQ00c9hxVwyZPpHp0rUyjtkSa6GGHWyD8XYPMUHw2lIyvze/E8FY8OQsJfCQeHwS2TNZi3vpRn+cCLLc281fgs19abTSitoJv5VfRf/fDa6jhlNNs7VYrPDY13OaO3gvcksHGQUYGmiL9iYVM8EcCkW4cSBb+qnU9rIIxY7kS7DxPaZsXEVE6Y7nE2R7Xfjhcrd5gyMja6uwWBkH/eVLfnanYx7to7Q9RnFriNcHLVkI0PlSARQi4KWnvjsT0vquBVk1QE80YG7Jd6PoVv0rsqbZzVK0o68E2ej163GikfTlbwN4T9To5xLc3g+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+4klZ+Lfj+Z2rj5Jh46hpze+q3UF4aY4CqLclBKNXk=;
 b=ncoDAtnvdfde8Z5qfbA321L9C0GsmWL4+PBHYBfG+4lJUjIzt3yUNxMYf29c29uxrMjhkJsgMua8yIQfFGaHsMzGoLfGMefVXph5CkQTrpcTB3/JCYtIg/wjCPlFuxG8UnCF4mbsDiMlDzHCAepM6EzzljptKTICTWACBJ1U2srFmoFOAekuV37P7/dHbgJ41R/pp6Ye/aBJn9Ho1+D3a0lF6kZwzRY5P/FcVtzIBDwcW/4eKJDKb82pJVkiFXmrtZ+PjF2eUc3t3MBzGyWA6Xs+dNBkDEEKaiSyoCsiW4B/UZiEZDgFevouV7w3uIt4CurpjAstYPrXXpEYDGE0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+4klZ+Lfj+Z2rj5Jh46hpze+q3UF4aY4CqLclBKNXk=;
 b=l67BLB2fnZW8Njx9WhwJDEoFi5LCYfQV3jgni44jBdVnICWaiBV+Kv5QcDG1cQp6SnlyQ5x56sej3OZSTJnsfxmq/S3FKOPSOgvT3POF7uAZezCy+Xjx1NejrAgrGgBW5V/okjlrU6muHvg10zjOGrvRD9B45xDBkVQZiwBKvXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Wed, 7 Jan
 2026 08:54:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 08:54:12 +0000
Message-ID: <58d1fb51-c319-4a53-9187-f858769019fc@amd.com>
Date: Wed, 7 Jan 2026 09:54:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] drm/amdgpu: Remove unneccessary memset in bo
 list creation
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-4-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0428.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c635e41-ff1d-46e1-7a3a-08de4dca53d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2U3c0p3VkNSSkF6QlhlVjRvMlpUSC9UNjJsZCtGeEZuR1h1L1FwM0UyMHZo?=
 =?utf-8?B?SjdQSll6WFJ1akdpQW4rNEZNTUZ3a1QzMlVsTEZ2bGZYNW96OVhWRmYvb1Zm?=
 =?utf-8?B?SUJXWmVka1NkMU9QbzdnRU1vV0gra09tTjJnbTRUYmtzbWhPMFFxMEExR3gv?=
 =?utf-8?B?a2FsKzZoOUV2aE5iajBXOHB1S3c4RGJabWprUXZ6WlMzSm9nUkdrWFpDWmFC?=
 =?utf-8?B?T3pPUlM4VmZMNkFKWmhVcFltNC9yc1IybzF5UjV2Z2JkWHVjalJDazJDbUVQ?=
 =?utf-8?B?MWlyVmcyTm1GM2UyVkpvQ2pLWHlTTjZtd3N3TDlQU2tZdHMzMXVJK0dST2do?=
 =?utf-8?B?NGdaSTN4ZS9hQ0ZjNDJQSHltQSszRWh5TlBic2p5S3IvVnRWS0FhTnRyT1pU?=
 =?utf-8?B?eWRadHZUVE5kOXJHTlY3SURKMjl6TFVDWHlmK1Rod2Nqc2R3NnFJNkZ1bEZ2?=
 =?utf-8?B?MDExY09oUC9YUEpQTnp1WHp0bm5UWlE3SFN1TXJHcnJvZWxoMWFNdzY4VVdH?=
 =?utf-8?B?YWNiK1FZUW5CUzBGVmdGMkwrVjN4RUhPakZTL3VPcUhKVlY5MTgxWE1GZzBP?=
 =?utf-8?B?bUdKb2RERnhkZjViSGRybE5UclRSc1NMV3lYenZGck1ubndpa0JsMytON1dW?=
 =?utf-8?B?NU9ScXFvczJkdnZ2UVQ0YjdBM1gxcjZ0UXJyYUVDRHlaSVFzYURHWlY4MEVU?=
 =?utf-8?B?Zk1tRXp0ekQ5TTdMNlkrQ1pJZVI0RTJyQmZuTGd6WFRLTWg3Q2NoY2IxVHpV?=
 =?utf-8?B?YmVBWEluMlhsc0U4bWNBU1VzTmJybUtxUkZuNzhKSytVZzV4R2FvWlFDQ1A5?=
 =?utf-8?B?a1pOU1pJTThYcDNLVFJEZW1TaGRSTEpvQkpJV08rb2hpaDNVeWdmZnJYbkhI?=
 =?utf-8?B?SHIxZ3QxTDRWQlhsbzhCVEc5Wk5UQVRNTkw2M2h3MFFaT1hpRFllMnZia2ZQ?=
 =?utf-8?B?eHdackdqYjNmWjdWQktPaHZtUzZSK2pNUE12SDlDbWdMVzBMMlhYU3BPYnVi?=
 =?utf-8?B?L3orTE5OTFpMcG9xZzZRaVBpQUlIZFVJbyswOFI1Sy8yWi9rS3ZSUndCb2hR?=
 =?utf-8?B?WmxZRDUyeVArODVGZEdIYTgzUnkwZUdZdS9VeWtSeHQ2Qm05WE9nV3Azd3FY?=
 =?utf-8?B?eGUyUXhuMHc0TnViNUY4bmtvUnFSTkNCaUI4MTdxNmxJZjJuckpyMWZuaE9K?=
 =?utf-8?B?dCtNbzJuNUlDWUdvN1AvUkFLbFdOY3VjcHZiWnhocGkzLzdkbE5VWXk5bHlS?=
 =?utf-8?B?dVh2aUI2dHViUWx6cWNEOXlPaXlwUTFWOUJIYlR4eGFoUGpBNW9Xd3EyNjQx?=
 =?utf-8?B?ZXFLSTNESUo2WStUaWE5VllDVVFLaWJFV2xEK09DdE9lYTN3N0dEVENLTUFp?=
 =?utf-8?B?MVpNWEpRQlR6aUFFV0txSG54bkV0cDd3UHdxK0IzRnJuNDd4ZjNmRkR0MlYw?=
 =?utf-8?B?NFhCZ2pOSk4zQWRqT1duNGVXTVUxYWplb1JYNiswUXcwMDlZeFd2RzViaVlQ?=
 =?utf-8?B?cTFLTGFVTEN2R1ZBc3RuQ2xVMFh5UGJHQi8vUnVOSzd0TlZoeW02REIrbUs5?=
 =?utf-8?B?T1RTTEd0N3VMWUVzYkNlVjFOVU5EdEN3MGt6dmR6N2YwWTdhOGxHMnF1OFFT?=
 =?utf-8?B?MWhaVHhzRmplcGJhU04wam9JMWVFSC9ORnBKTjZ3aENnZks5WkFzQ0dTT1I3?=
 =?utf-8?B?eHpEVG92VitreDFnYTV4SlZhREMwc25hbXdZZmw5OUhmOG92OU0vZkhKOUZB?=
 =?utf-8?B?eUNPcWNTZnRFOUhLejVOMVpvd1lvU3ovYlVjN2NCZkJvcHA2NWhMWFFvdVV3?=
 =?utf-8?B?TG1YZWVKMjRZSDNUSEJpMG5keitwN1pZSEJSd1ZQUkovNS9yQW9iQ25RaGRC?=
 =?utf-8?B?YjN4cnRCazhibzlPM1hVZTczZ0RJVkZrb3NzME9tdTc4VWpha1hqMVBaVVNw?=
 =?utf-8?Q?TTmyBWoWa9r9Ip00MhIOh3KX9ZnPtPZK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZrcThQTGk5eitCRjcyVzBPaGkwUlNlR2VRZUQ1ZEk5WnV2Wm1KZHpuWWxL?=
 =?utf-8?B?cG1RcHF0bzdJVHBTTnQ3anoyWVJTNGs4NDVKckI2RFV4WmE3L3VtZkx0SjRa?=
 =?utf-8?B?Q2hpN1lXUHZMMnI4S21iYkxWRktER21jN3B4UWJCZEhlSHErWVp2T2gzTWpF?=
 =?utf-8?B?YTJuU1NrRCsvK0Zoci95ZHk0eG5VUlR2aUh4eEFzTVZrWDdFbFhtTW11RWZl?=
 =?utf-8?B?V1lGMXdHU2Z3djNINm44dHViVmRZcVMxWUZzMU1nc1hXSEVOdHJRNmtLQUNX?=
 =?utf-8?B?NjJkc1NJYTBaRCtUelFKMlo0RE1hdDMzRk1MTjV0bWc1SDNoeSs0d1VEdWJF?=
 =?utf-8?B?dzhPR2NpRXVlb0xtV3RRTXhTTnh0NG8zZWc4V3I2bzRISTQwRmZiUGo1OXFv?=
 =?utf-8?B?dlJBazhwRExIaElMTDNidjBPNlZNYS90dVhUN1ZxQVlybG9EeSt0cE5rRzNx?=
 =?utf-8?B?a2Q5enhNZS9WSi93RTdSSWtSci9WRDk3bWdzeWVLTHliU0RqamZYY3paL3k3?=
 =?utf-8?B?UmV0NHdYc1Voc3Zhek9qOFFhZnRKNkdIU2NvZHhGRVJORGFDdnVoOVk5K0pn?=
 =?utf-8?B?YmF4SFNZbDkxOHNpRXJhNk1lcGtwMnNSNHVJT3NSUWVvbTBMdGF5RHRLaHJ4?=
 =?utf-8?B?WDVqS3pXRUNqYzVsalZEZWhxY05KNmJBZVJENyttdGN2NTQvUGIvekJJL2dx?=
 =?utf-8?B?L1pNRldieVNJYmxsWXlJcTc3Ry9TcHpYVVkwVU1QZTJvK3Z2Rkw0OGxmeE5w?=
 =?utf-8?B?MWY0eU9jQ0ljSGJPaWVmcmhxZC9iQm9ZQmNGQ0ZSZ0x4b2c5cUxnak5PTFli?=
 =?utf-8?B?K3NoWHZHc3ladWJ2SWRsemw4bDFia0kzZGN1ekFVTUhDU05GMCtpVXN6bTYx?=
 =?utf-8?B?SnFhWlpJeHZvMjRFWjB3MzlnMTBEcHZFYks4d291WGpQaERyZisvUlZHR3ZX?=
 =?utf-8?B?dDlkclN6cWpBWk15SXZSY1Byd00vSHY1QThGaHhpMXczdElPOU4xUnRRRS9w?=
 =?utf-8?B?Sks4TjVVSGRzS0laU2lTYk5Kc28wQVUwVDhPK2dUeksvaUF2dEI5ZU5PeFBH?=
 =?utf-8?B?V1ZSczB1WnJhY3BKbkgvcWNwNEZUV2dsdGM1NWV3bmM3WW9YbFNQTW42aHN4?=
 =?utf-8?B?VncyeHdmOE1XVE9tVDhUNWtMb2JLQk1xaE1DS2NjWFgvOWhwR1l2SXo0aUQv?=
 =?utf-8?B?czV4M2lMQmxrTENkL0xVb2pSdnpkR0RMcnRBcS8zbU5jZUhRSnpkc2hVeEZ1?=
 =?utf-8?B?SXF0SzM2bS9TSFcvWkZSamdoMUVRTUt1RmcvVUR3ZC9Ec3lOSG1SREhValha?=
 =?utf-8?B?eFphNC9JLzJGKzc0M0VWNk9JejA2VUhyclRvaFdLNjRHVWg5TTRCbG1jd3pO?=
 =?utf-8?B?cHRCM1lnZG4xNTNOVDFTbDFyU2tScnhYQWFmS1c5WGtIM0xocXpiMXFYQUU0?=
 =?utf-8?B?RTF1STNEVnQvbk5ZNWFabGVRTzNrSzZwZzJOOCtSZ2lxTWZ2ajFjRzEyL0w1?=
 =?utf-8?B?OWVDMFE3ZmxQbmthWVFPZ1d3OW14TVZEbHQzRWJjN3EwV1JiSzZGaEZtT1lQ?=
 =?utf-8?B?ajZJYTYrejNUR3VvY1pZeDFXUlhhYkl1QWVLcXpGTGtOUmNCbHZkcmVaWkJM?=
 =?utf-8?B?WFIwUE1vYWxqVkxRUUZqZnRDMzBDanJjQS93ckp1VFhDV2pwZlc4QzlFdTUw?=
 =?utf-8?B?SVZveUNpRVhWSFlSbE8xVVJVNjdlSVhiWWZsSm1iVyt2REovWXBLcDZKbEhO?=
 =?utf-8?B?Nm5MQ0M4bVJtRGpGUWFTRlJqVXQyT2JBVS91UWdQeGt2aHdZWDN2VzYydWtk?=
 =?utf-8?B?ZVlzY1h3b1hQOFhxK2lqZGg0RHNIRTdnTFU2cTdRRVpLa1c2YndkbEFnRHhZ?=
 =?utf-8?B?OUhLR08ra1Z3bHJSZVRVcHRpQ015THJqeENRcjlVVnVFYnd4MzZGcnJzOVNu?=
 =?utf-8?B?MEJwa0tXcFBjVHNEMEdDaVdsSnA5MHpyRXpNRFh6WWRFeFRyTlk2WDgyWmVP?=
 =?utf-8?B?MG85MjBLNXFtT2xmUmRoQ0R0Z3VNOTJBRlRKbHhnZ1JFVTJrTkk4OSsycU40?=
 =?utf-8?B?U041am8va29EY0g4dVJBazhSNHlVTVdHOXB2aVV0MVN6Rnd5ZnpRSHFEK0Ri?=
 =?utf-8?B?UFBzSGNjSG95UEIwSDhuRTdwcHB5eWNyMkpTa3VnK2VoWmtyVnd1YU5YZExl?=
 =?utf-8?B?TlR2elozLzc2dlVFRTc1T3ZnVnVCU2UxWDBpMURpbmhaUkQwc1NRcUFOY1JI?=
 =?utf-8?B?QjBGaUFhYTJSRjBGc3hwS0N1SjhOWU0rRGJ0czZjYXJxOHZaR3BPTUFCSHQz?=
 =?utf-8?B?UzVyZkllNWNFd2hNNTBFVjlQbjNzalgxaXRqMVVydTVMSU14RWVtQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c635e41-ff1d-46e1-7a3a-08de4dca53d8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 08:54:12.6743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdOF0GktRVyicHXc4j9n30C0buZ1BAuUNEHfJGM0GK13K0dJWn2urX4WmGG/ODhu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
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

On 12/19/25 14:41, Tvrtko Ursulin wrote:
> The code will either fully populate the allocated array with userspace
> provided data, or abort and free the memory, so there is no need to clear
> the array before populating it.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 87ec46c56a6e..72c5096c3b18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -201,7 +201,6 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  		if (!info)
>  			return -ENOMEM;
>  
> -		memset(info, 0, bo_number * info_size);
>  		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
>  			if (copy_from_user(&info[i], uptr, bytes)) {
>  				kvfree(info);

I think we should just nuke the complete else branch this code is part of.

The case when in->bo_info_size != sizeof(struct drm_amdgpu_bo_list_entry) was never used and most likely will never be used.

Regards,
Christian.
