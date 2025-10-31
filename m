Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E522CCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B93E510EB41;
	Fri, 31 Oct 2025 13:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1kLNkZMy";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C945E10EB41
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc7lyFzJAYn/5kSKI1QVxcp1bG51KUGQ7DRixR0YM0+qKD7avifYIXtmXmked6SpU8RFYw7+x/80vJ9T8Psg3mssw9w50aszDPZRcMPb+qfzLy9ZGJ4K7MMdYfDFBnnlW84CATCUViGnU8OY4wFEFSP2XhTbq5nHUYLPAKX3oPYGo3vIUbJZpiklGZH4cOnyn5R5Nox+Dm5UKCV0XV3ZM3ON0AAIKQbX0HGZEkXZYuNXAlNukNVei99uzgPbmsDKQUlN/KNxYmm9oPzzlSdN9cPb1mmRSJrcGAm18F9gv1E9Q7ONv55QIRjEmXiPiq19Pv8NMD0KFYNuka9xhQBHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGtLflN2t109Fr2S8y2+rE7J7RToqlR/3Irguf2JJL8=;
 b=N98zxXwzjYl0+Q5ug8bTgW6tVSLfztAJ8gcenWZRWtMHzX4czKElGyuV1T0E6wWLOLvba+OmfbbMwQJeIRVE45nCxcTM79St1ZaM8nfYp+r/V6pQ4WqbhwVOyXVC+q79fSfnKL75buKRIemqHxqeimoQ6nxqUoDdPb2QMwKhmdFp/JIRgxkXAlVercfZ10+9+E4CXgfTMDJ86sobub3q2VkKfoJrZvC9v9lX15V1fE16TRmFs+xP+hIfgHOl/MDSywoYDXWHazdJScI8+Q5iZgzDKVQGMJtMt+AcnYP5TvUDqrLSewfSdUGjRWMQQH326Pq8zGwRwc+ZcunzyaB7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGtLflN2t109Fr2S8y2+rE7J7RToqlR/3Irguf2JJL8=;
 b=1kLNkZMy2PtcU6gEFtx8nU+E5a97YOU+V2nlEGxYPFJ8SEkERqZna1F4JgTWfftMRtfjzNdS6biHjrgjQhSRukcivCTheqBPM1OXZFWQsoo7xhY/rcuUAD8b20hDHSeYJ6dBwsiwZH5Fj7wkyBx4LJP2kJC8fEVF5Ju5e6HMEQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 13:41:54 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 13:41:53 +0000
Message-ID: <668f7ed1-8022-c706-875c-126ee2961cd7@amd.com>
Date: Fri, 31 Oct 2025 09:41:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Fix GPU mappings for APU after prefetch
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
 <CADnq5_MMZ+mE1=0aRRLE7dbfpndVOXL9UCODB7BeQg9QMyspJw@mail.gmail.com>
 <0c8c8f75-a4ab-d0c3-067f-cb389d7c61f1@amd.com>
 <67f96c31-e0e7-4e1c-9ea7-d77c8e345f8e@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <67f96c31-e0e7-4e1c-9ea7-d77c8e345f8e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd6e047-8ed2-430b-00ed-08de188340a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk1XQWNyV1g3NGw4Vm8vc2dwekZjOGN1Si9rQU5hOWxwczVGN2E5T2EyYVB1?=
 =?utf-8?B?QTNoM3phTTBHOXk4UTFDZndxTDkzK1pETW92RTY3ZElvYkZNdDNCbFRIa1NF?=
 =?utf-8?B?NVpMTEI1WVVwVjBOVEFvSWVJSjFTdytleHVjWU1FM3p0S3FuUXo1SXIyQWtE?=
 =?utf-8?B?RXNxN0FianA2UndRdkl5eGExZ25PblFRN1F5TWdpSDNWeVZpQ0loT1EvWUxM?=
 =?utf-8?B?eE5nekNPd0dhK0NpM3JxSUxUaFYyUDc3WDlZa1M4cHV5eWZURUYweDlBcWNS?=
 =?utf-8?B?Y3pvSHJQd2F4MGVKenpVeTkvSmdjZkFyRXRwWTR1NnlpUUJYSENRWmNaRTI5?=
 =?utf-8?B?Zmw1UFIyZFBsaUxVRnVMMU1qTDE1LzRxdUZGTHBjUVp5L3ErVDdTT1g4dEpw?=
 =?utf-8?B?ZElGRmhUbGVybXE0SlFSSllocGV0M2tNa2h0dElsOFB3L1pTN2VGV1hDSktj?=
 =?utf-8?B?cWtld1FDYnVBVHlQN2FTWUpYVkRkN0g2amhLUlg1TllpME14V255T3BqMVNZ?=
 =?utf-8?B?N2NXTzh5TmJkamhtQS9JK3V2S2NuUU5RS0FuS0RrSzRnQ1JyTTBWWnlKaE93?=
 =?utf-8?B?K2psUjArWU94ek50YWVZRk0vYVNYZE1QQmlXSGtZYzRmblUzWUlFMUZrS1RI?=
 =?utf-8?B?Ti9hNTgwNW9xa3ZEWGZYbVQycSs1ZnFVQmJoWjNoWkVRNkFveU5neEhjeGRL?=
 =?utf-8?B?ai9zdmV4WTNtTUlGZm9aYWlRMmUrZnhJeUVuSjh3eW5zSFlBSmRWQzR4RW42?=
 =?utf-8?B?bjRwMHRMU3p6NHNKQkhaVmRBTk9tdE5tNG5BU3hlY09PdzBPWEZDYmxiVlBz?=
 =?utf-8?B?MG9CZHVKS3k3M1pZdEtzTzN3eVMvSHhFVm5lditwVW5OZloreFBTKzZWVnRJ?=
 =?utf-8?B?WFhSS1FnOVRZSGNsZ2lCc3lFRkJkQk1jVld2QW8wdmJ0aXgrZ2M1ZW85T08x?=
 =?utf-8?B?cGsxOSsyOC9NNnROcFc5MDZaTUFhRWtQcGNjaVEyeGM4cVhmK2JFNTY2WWIy?=
 =?utf-8?B?UlZySmdYMmhTalRlQkdSMExqSzR6S0F5T1c0Z0FGUTYwT1F2WmMvM29Gd1dT?=
 =?utf-8?B?RjRlbHJZbElBdjRBM3FZK0JrTjBUODhVRGZKTFZkQUxycFBMM2N4d1U0Q0Vz?=
 =?utf-8?B?R0JaNnFuTHlOWTRBS2dHSFYydHVXdHREbnVZVkdzbVJEVHptSGZYc0RGT01S?=
 =?utf-8?B?N25BbFRHWm9TVFVFKzI1RmR2dUtXTGhGaEhFcmlTRWhISE12Znp3bGJmWVgv?=
 =?utf-8?B?a1MrY0tuVVo5Uk1Zdi8yTHlwZ00xVWtzZXFzdFllQjRMQTdjblN6dDh5dUJS?=
 =?utf-8?B?NEYwWjNJb2hjeC8wNkhGREt3Nm0wdkhwclFOb1laVzdQZGE5SlRXcis0aUVN?=
 =?utf-8?B?T2ZZYUZzVkxOTktkWTFZU090MDA0TXozMjQ0d0VQTDRvZGlEUU9CUklZdzVr?=
 =?utf-8?B?RG5WVlA0NVY2a3dzdG96a1A4clRybm4wMWNBMldmYmMzdDdWTVZvd1gveHZ5?=
 =?utf-8?B?cHpjZFdYNDI2MG5wNFRGc0ZqMzdPU2lVYkNqQk5JVHFLb3ZWaER1VloxUjR2?=
 =?utf-8?B?RjVjSG5rR0dIcmN2Z3JEalQ0V0F5bGc0RElPMzlLOER2ZXE4S1U1Rk9scWlm?=
 =?utf-8?B?TGRWQlYzZHpUOHBPaXY1WmdHMXdpbzBodjNSRFE3MnZxdHRPQlRGS2U2Sng3?=
 =?utf-8?B?TUxINDc0TXBJU3RDM2hZbmhod0VyajZUSVo2WUZVR2pmNWhSaWpiU2tVMXl0?=
 =?utf-8?B?eVl0d2xGVWNHeDVCWk5DTk52aldzSGtKL0JnUXZPZFZsaU1wSXFRZmJWb1JF?=
 =?utf-8?B?b3lRYXdHMXdQYitGb0VEODFNSzVnem5uSkVoZk5oK2lMQmo0UWtiV1J4ODlQ?=
 =?utf-8?B?OWlDZGd0MUxSWkRmNGtjanZxdG13VERPZHlDZk9acTZBa01zSEZVTEtoZ0E1?=
 =?utf-8?Q?DMVAWQHWForJaiGB5l+Mi3NxnWSMNtgh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZObXNrUy9BcFBSK1piRHFGenI1UVI3bGNXS3lKTnJxT3M0aFM0aGQ5dzBl?=
 =?utf-8?B?cmVwRWl4SkdyWHNWQVA5WHVxazN3K09rMVFocFJ5cFg1cW1raW9TUURBSUQz?=
 =?utf-8?B?SmtRMHVQNkNaTWJsT2ptdDhwaEtPYTZXV0l2OVFYakl0MXF4N2llTmFuWVJt?=
 =?utf-8?B?WTUrZjJrbjhxSXl3Tk16cHhLenFTZCs4RnN4cVJBbVM2R3l3cW56endyNHY2?=
 =?utf-8?B?ZFZNVGtxMmZmVGlFWHh3S0Q0aHM4N3pnakpnbDk1dWdvU3NrYk01NXBJMmp5?=
 =?utf-8?B?SUJXNDlJbkNxUGk4TzAzOEFlaEF6WEZDaFJYNUJYTDJBcStuVUxlNHJMVzJm?=
 =?utf-8?B?dEd5YlVRN05nZkNDSjRTdzVxQnA0M2RHTmVDSmszSjB4WEFVclBYQ2x0WS81?=
 =?utf-8?B?NklDbFBGK3l4WTkxUVA4WmR4YXlhR3g0RS9rOFIyN3o1andUWTIrMlpmaGZJ?=
 =?utf-8?B?TExlUG82Nmx5V1VoajJ2TWhwOWVPc2Q4eGNPYXdpV21nWXp1T0lDSy9DTFEz?=
 =?utf-8?B?Z0J5M2JWYUtFdXNmd3ozZ0pGWGIrT1lWbFZMZGJFTUFCaGhTbzkzS2JTQjZo?=
 =?utf-8?B?eVlnZ2REeEU3bUdvTThvV0Qyd2FoWC8yaDBSRmUvZElTS0RCZHBEOUpWZkFG?=
 =?utf-8?B?ZkhKZ2VJQ1pzYlZ3NGJNOGxPUVBsREtjbGRSZ1pzSVBBY0dkM2V4YnRYNzlq?=
 =?utf-8?B?bkthNzhubTVXVTdjM1MyMTdLMmxHeWFoNlJWbEJEeXBhYi9qSTlBM3BjNzNJ?=
 =?utf-8?B?ZkhEcW81VWF1OXZ5NTlQYjliWnFFR0hIOExGSU05QTVMRDR0bC9TQ1hGaGNQ?=
 =?utf-8?B?NnJOMjl3WjFDcE1FZkFjU0EzTlFVUjBYcUdXMm9HNFRjMVowb1IvVkkvYlE1?=
 =?utf-8?B?N0dWNVJpeUVxSitjcFRnM3B1d3YxUlBKUGtxUDEwUk1Ndk1DaGdQbkVNWHV3?=
 =?utf-8?B?cFkyTzNaQWs1eWVTMjJ5Uk1TempxQUUzYkhlcnJyU2wrWEwzTWsvT3poVnJn?=
 =?utf-8?B?cGRWUUZ0Q3JJbHp4MDcyTkhoUStjaDlrVG9GUjhIeGQ4Zkh3RUlTOFppTHpH?=
 =?utf-8?B?M0QyclZBdGYzWmdNcjdpbHBOMTBCZTFGMFQxWWdULzNtQ0xsZ05PK1hYaUx1?=
 =?utf-8?B?emFidWRRcFdZbDZTZHdJSHlNRnlteld5VVgzeXJqYTdWMTVieW5lWVhKQlcy?=
 =?utf-8?B?ODR4QlBGbUNIdStJeFI5alZrUnZYZStaK3JrV05Gc0pQK1JEeUxSaURORHgv?=
 =?utf-8?B?N2h5S2JVN0VXMTFhRUNZRk4zUCtJSjZORWExbmw1dlNuODU5L25UQUE5dGl1?=
 =?utf-8?B?WEFXc2duZWl1d2UzYytrNjlJTDAwR1g1UmhKRGM2SVBLdmhEUy94YkRXOTZO?=
 =?utf-8?B?aThDdzRPN3lHSEVhL1Q5cXJDZXVROHIrYTlFbkMwM0JnSHdYS2NBZVRleWFu?=
 =?utf-8?B?ZHpPSUt5Nmd0SThjT2xReTRJbk16N2RxV1RzQndXd3I0dmhZMGlXWEs1U1Fi?=
 =?utf-8?B?YVhBOTBzb2JTaXpDY2RSUmg1MHI3YWZNYTlybkRQL2pONm1yRWYwMkxxZ0ly?=
 =?utf-8?B?WEFXZGxlR3B1bk5rT2dZaGY0cmdTZWZyalptbjZ4VFdMaWlFSHlERThpODNs?=
 =?utf-8?B?dlg4d3pKTGFkT3R5MkJjc3pIRC9vUzJkb3VnZTVyaG1NSExGdVlVSU5wR2NR?=
 =?utf-8?B?OXhxRGFpMnhBY3VwWDlGY1VRWUZkVHpiVjN6T2ZOb0lhWWYwTzRSS0ZFQVU3?=
 =?utf-8?B?VHk0N1lkNmY2WFJFUWxpSGptZCtsUUVFaWI5Z0w3Q1ZGcVNLOVB6aTlxYVJp?=
 =?utf-8?B?V1pqR0tqUzVITURKcUFrdlNhaEE3KzBhYS9aN2lVSzMvZlZLOE9PdWJFYjhS?=
 =?utf-8?B?d3lmMkhoOHBZYnAzQk5yT0Z0Qm1sWHNDVzMySXdFOG5FS3J0aDNxVEpGVXI3?=
 =?utf-8?B?bEMxZ25UcjRxT0pkdVNkWm1vbzEzZnN5UC9RR2VwMzVRc2l1VXlvZXowOW9m?=
 =?utf-8?B?QlJSeWFoRVc2aDhhMWFUYkdxbUVIc0NJL1hYMWl6QlpQNjEzSm4yV0Rkcno4?=
 =?utf-8?B?cVMwbzRmWkJKZExiQ3dUS3c0YkVJSm9IbXJGdlo5eTd5TEVRNFZEVWFhZDUv?=
 =?utf-8?Q?L2ZpJn4Mm3RPdUY3zAZuIcUFB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd6e047-8ed2-430b-00ed-08de188340a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:41:53.9338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZM6UuEKEIXwd9i3+PhEES3Va5ULWtS0fCMPJQaV6DQOD6GUj5HYA7IEZv1WNAncJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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


On 2025-10-30 18:12, Chen, Xiaogang wrote:
>
> On 10/30/2025 3:14 PM, Philip Yang wrote:
>>
>> On 2025-10-30 10:20, Alex Deucher wrote:
>>> On Wed, Oct 29, 2025 at 9:36 PM Harish Kasiviswanathan
>>> <Harish.Kasiviswanathan@amd.com> wrote:
>>>> Fix the following corner case:-
>>>>   Consider a 2M huge page SVM allocation, followed by prefetch call 
>>>> for
>>>> the first 4K page. The whole range is initially mapped with single 
>>>> PTE.
>>>> After the prefetch, this range gets split to first page + rest of the
>>>> pages. Currently, the first page mapping is not updated on MI300A 
>>>> (APU)
>>>> since page hasn't migrated. However, after range split PTE mapping 
>>>> it not
>>>> valid.
>>>>
>>>> Fix this by forcing page table update for the whole range when 
>>>> prefetch
>>>> is called.  Calling prefetch on APU doesn't improve performance. If 
>>>> all
>>>> it deteriotes. However, functionality has to be supported.
>>>>
>>>> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with 
>>>> carveout
>>>> VRAM
>>> apu_prefer_gtt is used by small APUs as well.  It depends on how much
>>> VRAM vs GTT is available on the system.
>>>
>>>          if (adev->flags & AMD_IS_APU) {
>>>                  if (adev->gmc.real_vram_size < gtt_size)
>>>                          adev->apu_prefer_gtt = true;
>>>          }
>>
>> yes, if apu_perfer_gtt is true, then no page migration because 
>> best_prefetch_location is always CPU. For small APU, it will have 
>> same issue if KFD is used, prefetch split range page table not 
>> updated because no migration. This patch can fix the issue on both 
>> small APU and APP APU.
>>
>> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>
> Is the case like that: the svm range got split; the pages are not 
> migrated and attributes for the pages are not changed. Then why need 
> update pte as page physical locations and attributes are not changed? 
> Basically it used huge page pte, now you split the pte into smaller 
> ranges. Or I misunderstood the scenario?

yes, the range mapped as huge page, use 2MB PDE entry as PTE, after 
spliting, the tail range mapping update, not 2MB alignment huge page, 
alloc pt bo for PDE entry, then tail PTEs updated, the head PTEs is 
invalid entry.

Regards,

Philip

>
> Regards
>
> Xiaogang
>
>>
>>> Alex
>>>
>>>> Suggested-by: Philip Yang <Philip.Yang@amd.com>
>>>> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index c30dfb8ec236..76cab1c8aaa2 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>>> struct svm_range *prange,
>>>>   {
>>>>          uint32_t i;
>>>>          int gpuidx;
>>>> +       struct kfd_node *node;
>>>>
>>>>          for (i = 0; i < nattr; i++) {
>>>>                  switch (attrs[i].type) {
>>>>                  case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>>>>                          prange->preferred_loc = attrs[i].value;
>>>> +                       node = svm_range_get_node_by_id(prange, 
>>>> attrs[i].value);
>>>> +                       if (node && node->adev->apu_prefer_gtt && 
>>>> !p->xnack_enabled)
>>>> +                               *update_mapping = true;
>>>>                          break;
>>>>                  case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
>>>>                          prange->prefetch_loc = attrs[i].value;
>>>> +                       node = svm_range_get_node_by_id(prange, 
>>>> attrs[i].value);
>>>> +                       if (node && node->adev->apu_prefer_gtt && 
>>>> !p->xnack_enabled)
>>>> +                               *update_mapping = true;
>>>>                          break;
>>>>                  case KFD_IOCTL_SVM_ATTR_ACCESS:
>>>>                  case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>>>> -- 
>>>> 2.34.1
>>>>
