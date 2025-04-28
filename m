Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EB9C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 12:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF1910E095;
	Mon, 28 Apr 2025 12:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Az+UCleR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5015910E095
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 12:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlDM71FSefYeLLaO5VHU3i4lOTunyWh2B0ttewst5Neg/FCUUqhbcc5vmmAcCLo1Z1inWH6VpIN989oG1LA6wlWMBgWzJ/jzDFXTihufOpYOXv99gpSICXfkbYxjq3886ElTfG4DXsE1DT5WJLP6wC3OwAuJWEH5bbWWkcChfgqQG7sWWclNyC6dRx/ZcLb3KZppGj8dIYEd3RJCcKV/mub+cD8OCRuZYcAcXzPULJ3V9n1DlxeIM0+9lJJQrWHQuJtwm9VTaWnng2RihOuJyGgZcRdN6pGp8GcHiyK059cHsmdYt9FbjWUEmfq4ATOuAIlpk9sf93A4MtOSW77j5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azD6hCjeZw6WXbtp3ka2gI+IiGQPbdNSOVyJcZXIUkM=;
 b=LTo+4UNwJX8zJQBIMuQjs8N/UridrI7lpsRbESHdSQA47qsujKzdrQtP+nd87PUpLDGAG1yKsrcqGmH6pEYcBFDRixObLvF4/XjYkGc47NTMAUbJjutXVzHOYfFWQZ9D0swFQ6FQwtk0gWzcznNDrZrNX/128x+XqqCTIgJ4p4KFoNcIsbyJxh/XJHVa3ssRuXVYFWI3qUpAjrhQ6rNnnkpq0mwwVnY9MHqwdyQMxjwHSNfdoxUX4NfUJWq9MwSHHXwtYfJFbwyo2JqFelM4zGHObhJSlqQpu4swfhx/01QBu9b4A64VKizAZOfZxb+qIAwjzO7D1CSK5/BfNW86yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azD6hCjeZw6WXbtp3ka2gI+IiGQPbdNSOVyJcZXIUkM=;
 b=Az+UCleRCXhsGKnwKqPgau2ZHoysmmCQyS6OSNgjNtBzTmEA+u3mIJLm54DrKkSkqeqYMDyknWyJ1eRHrdrd8ILoK9xWI3q4iwHWVxZi+pWatdASN3pFbUW1+/rWP4qbHTG7r7+6X3HPCwM154rwliflC18ngKwtfVgAizKE7YY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 12:24:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:24:34 +0000
Message-ID: <16cdac52-5e75-435d-9212-cabebbfc5e70@amd.com>
Date: Mon, 28 Apr 2025 14:24:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
To: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "Zhang, Owen(SRDC)" <Owen.Zhang2@amd.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-7-guoqing.zhang@amd.com>
 <0ca1a883-4ddd-4bc5-8d58-9865a6d497b5@gmail.com>
 <DM4PR12MB5937E0B16D42C51FFC0D3E45E5BF2@DM4PR12MB5937.namprd12.prod.outlook.com>
 <DM4PR12MB593776A65DBB235A1A9780FBE5852@DM4PR12MB5937.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB593776A65DBB235A1A9780FBE5852@DM4PR12MB5937.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: e863fe36-aa5d-4dc3-8968-08dd864fa269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGtnbWlJY1hVNG5sRTdSY3pISkl3b2hOY05EOHhBL3c0S3VrdGlyOHV2TmtW?=
 =?utf-8?B?SVJ5Ujhyek1TazJZMm9ZUzBzY0YxNXpGaTJmUEtrdGZ1VGpFTEVjL09EOUhN?=
 =?utf-8?B?UDUzNVBvd1FMNUM5R3FCaWhxOVBZeDE3SWVKVlhyMTdDS2huT3lzcHdaNko1?=
 =?utf-8?B?QXhNdHQrbmJHRVlkd1RSV3NQWnI1cVgvRGhJMTBOY3ZwbWN6dGRwcHcwcTcr?=
 =?utf-8?B?Z2R5YzNsajYwZnZvWFA1ZEdXVVZtNE1TMmY4RlNma0poeXJ0aHdhRkJYTjRU?=
 =?utf-8?B?bmlYRkhRbURrUmxUekNxamRQa2Nndkhjb2V6MmQxcnluYWxlczlPTWdSTFZs?=
 =?utf-8?B?QnB1cEtXU3F1bTkybHE0RjZBVWc2WFpNN3JFK1ZzZmdlSkRKM1VkQnBETGVQ?=
 =?utf-8?B?OVJZeEZhSiszSFIxZzNySDNsRFR4N04xU2tyeWRvZVp0ckJ1N0Z2aHJXaTh2?=
 =?utf-8?B?bFc2RjN4N09xSjY1TS9RVmFublVmY3RhYzNJNVdxbGlnYm41OFNjclQzN3RT?=
 =?utf-8?B?blV2cGh4M1hrYk5ZVmg4clgveTFZMVQxVVd0bkJVdU10NFNKd0FZZjhOQjhk?=
 =?utf-8?B?R1BrYkJFVjdmb0xuS1dEMHRqMDVGWXJiZ2hEU25XZnJ3R3VDbUpIOEd3RWpS?=
 =?utf-8?B?Z3ZwVUltaXdUZ1hoZ1I0OUtsQXFwclJRYUhiZzRaNVQrMjVaZFhHNUtpTFJE?=
 =?utf-8?B?a2kwVy9XT2YxV0RnNlVBNExUdkJWTmlWbDNtOWE0MzF5OHhtaUhWMjB1NnJj?=
 =?utf-8?B?a2ZqWnBHV09SdDVhTnBybXNpSHNucG1pZUtqN3YrTUtjSy9leno0VnllWFVF?=
 =?utf-8?B?cVQzK2pTSDhQYWUxNTdjdHdnUWxRa2pZdXVvNWl6T3Q4TUhCRVRvMEpmT1p0?=
 =?utf-8?B?V2dYT1VXcXFUOVA5ZllnQyt0bTZDeURrRzVuVlNCZllCQjZHTG5jQk40YTc4?=
 =?utf-8?B?blQzbmsvQWJOZ1lISVVrd2tZRVN5alo5MEQ0b2N2RWkvVGJWeG02N3UxdWov?=
 =?utf-8?B?RG9ITTNjOXpPZlErK0VuNkhYV3FEWWEvSDBrcnZQNVNZS1h3ZVQvalhTOVRS?=
 =?utf-8?B?NHZYZ3A0emJhcFFEV21qbW5CSTdOVlN4VENWRTlPd1ExRkUxMnRhaDVqK2gz?=
 =?utf-8?B?SVR0RmJaSnNhMmJENWhyZ0FvazNuTlcwTEtVSUhFK1VLNlNLQ3h2a1dLVUJP?=
 =?utf-8?B?eEQ3YWpvRHZYS2d4cGhVY1hZREZKK0lZaHIxU2VJWUZQQVJZSEVmSnpoaWUv?=
 =?utf-8?B?UHpJQ0MxK0xvNDZ6WW1Za25Fay9jSzVHNUFzdW5VeWFMaTZMRHUvUnhTaEFh?=
 =?utf-8?B?bCtkR2JiN1BOcGFWOUJhbVQ3R3BXZ2hYdHRTS2VjbFNxVG9iWDNsSEJYRnlC?=
 =?utf-8?B?K0JISjNyaHVMdWtMK0VXK3U0TmVTVDdWQkRkM2Q0NXlQdUpsanljQ1h6amxZ?=
 =?utf-8?B?TWk0aDQrTTFOZHpndm9Ea3d2cGdNNjNSYXN4c0p4YUwxV1BydkxqY0JFY2pL?=
 =?utf-8?B?WlNJWHhOSGhBc1pCSVVDVDZaYmVPdjV0LzIxMDJBa1dSV3B1WWFjOE1pM3pN?=
 =?utf-8?B?VEQ4N0t6OHRWeUhVb0JYeWFGVkU1ZVB1SzJIMVVLMzJJNmFSdUo3bDhpZnlR?=
 =?utf-8?B?eXZIZHJZcm80czZsT0d1eTlacXJYVUhkaDJDNXl6b1MrMWFlZEs2Z3FMWm5G?=
 =?utf-8?B?ZE1ybTdoK3RpR0Rzc3ppOVdQRS9nNGtOYlkrUG5Db29aaFVZL3ZTZ1Nsc2I3?=
 =?utf-8?B?S2l4TzAyaTR4bXNRS1JsM3EwOGFWdVVwZ25scW1jcHc4RkpDTGhCSURnWjF1?=
 =?utf-8?B?M2c2UUUyOUdaMXk1NHZZTzJGNVJhS1U1bURobzZFL09Bb3c3WDNDS29oZlBh?=
 =?utf-8?B?V2F2bXFEdG5LckpSNEQ4LzluNXp0bXdxbU1Fa24vNmxOZFdDS1lTUWhWZWh6?=
 =?utf-8?Q?9tHg/LGZKhw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWt2MFZFWExsemhqUElXbVhUakJobndoM0ZINGhGQk1JSXBxaC9Sb3Fjd2tv?=
 =?utf-8?B?Vk5JL2d5WG9KQWhIVzVsQnFZSGt1N0lRcUpNR29JeE5qK2tlc1FzcE5pNGZw?=
 =?utf-8?B?NUtZQ3lpSEdQUFZta2dvWWxqSFpncWpKU0c2Vi90WG0vdHFzcDNwTG93UVFX?=
 =?utf-8?B?OEQ5WmRzdlFWdHg3dFRvaUh6UzNCRjdwRFRMQ3pENGxjSG1YU0pUaWNEaUxw?=
 =?utf-8?B?d2FhWEFKRy9XNzVVSDgzTnl1eGlTL0tXblcvbGplTy9MOEFxbkFRdVF5S3Bx?=
 =?utf-8?B?Wit3YXNqOUZCUVFvS1NaSTRiczQxOU1PRGt1VlZvVHFOa1hiNy91d3AvNk9Q?=
 =?utf-8?B?YlUvcko4aFcwZW1oaE1pRDRLZXVxTW84c1F5ZFgwUmlqS3cvUFVabTQ0VFZB?=
 =?utf-8?B?NHlKYkdWaWtYU3ZUWGxySWdmRU80K3ovQ01EbmNxODJMdWY5Y3ppN3E5azI5?=
 =?utf-8?B?dGdNTTUxdEJYK092SyswN1R6blZtY2lKVVNxTm9EWTNzRDN6YnZCR2JpbVMv?=
 =?utf-8?B?OEJoUkhUSUx5QXcyZStnMUpXVnBpSG8wN2JhK2dJbklWYUhtT3cvN0FzSzY1?=
 =?utf-8?B?aHNyc0V3Vm83V3RJQldCc2QrbHU1bUM1NnFRSVN5QktxLyt2WEx0RlBQem9L?=
 =?utf-8?B?dGkySHUwK3krVDJzTWdsQXhXK3NjRjNXWDJiMmRqN3Exaks3U0swaVB0UFVP?=
 =?utf-8?B?dGFQalMvUWZpSlhPNFlGS2ZhcTAwN25YQWZOM0pIUEhUdS92N3RuOUIveXFk?=
 =?utf-8?B?LysxTWh4dlZobHJTZ2F3RkEwRzhlZmUzR2RSOXdzNDlHWTl0TnZVbk8vS1pr?=
 =?utf-8?B?RVlvdU4vcWFhYVNWNUxYZ3p5NXF3WnhwbktLU3hWdGNNY3g2L0Z2Znc3eHNz?=
 =?utf-8?B?d0ZvNkY1NGtmaFFnam14L2lpK2ZoQXNHc0hCVkRNbDdBbWRKT3VRRndLT2tF?=
 =?utf-8?B?c0RyOXFBSFJ4WlhuNlRzWTJEZjFmdFczcVdkOVhPc1IvWDRvZ1RhR0g3UnRX?=
 =?utf-8?B?RnlCSlI2Uk5YeksxNWNpYmt3M0hmb292UmVlVzY2NlBhM0dmM1l2MGtpVVk2?=
 =?utf-8?B?Qk16Q2lqcG5MT3lIeTRPdHppZWdUSW0rMXhxSlVNRHAwVC91cllrZXEyY0FK?=
 =?utf-8?B?ek1ERE0wQ011L2FLb0ZlbktKaGx6MmlNMExyUVp0eWt4bndBbm1MWUZvZDBs?=
 =?utf-8?B?WmEyZVhyQnZ0SzcrNC8raUxDMm1mdEZCN09OOG1PVTRhRG81WndSOXpaeFNL?=
 =?utf-8?B?Tnk4SVkxa285Qy9SRnFpeXM0dFN2Q3BIMXJqV1YvQTZIaVAyZnFEWFFFQU9I?=
 =?utf-8?B?cGdibGl3emt0ejRySjYyY0NmMmNLenJYYldhVStrNEtaWitYQUZtT29vaHVR?=
 =?utf-8?B?RmNHTVlsRDVTSUxzazB1OFp2TFhtdC9oQ0t3ejlzWjhVTlhEUU5OUzhpVmNS?=
 =?utf-8?B?M2VVZE5HZVNad3YyZkVGbCtCSEFzdnRpY1l1NjV4SDZoek9yWmFaMDdLM254?=
 =?utf-8?B?ZUp0K3NneGQ3N2kvUEp1bzJkWVNiU3ZBYU03UDRkUnAzNUpoUnllWE80QWJ3?=
 =?utf-8?B?dnUvUzhtUDBxWnlqY2lPT0xEQXBZODZUZHBPaFBQdG9zVytRK0tCZ1djRjNU?=
 =?utf-8?B?QlM3MHlMSWJ2dTFVbjh0Y2xkZFR4SUJzTkhUUnlwNEZJTXpNZ25aZ1JxZ0Y5?=
 =?utf-8?B?UFFUc2R5SGRGUGV4OU9zY1FUWDVQVFcvcUpwL1lvYkxqb0dSS05qRFIwMkZm?=
 =?utf-8?B?ZmR0YmF2NHhMWkF3NWVVdmhielhEa0g0N2tlZCtOM0N0RXdVSkZ4ZW55eTJk?=
 =?utf-8?B?R0EyRFF6cXFkbUFrbjNLVU5nUnFaNmFHOGdqVVRaZFdWUURKcDZBMC8xclpp?=
 =?utf-8?B?UEtzUDRtTGFQQUpoZXNnbDM0aW04MmR0M1g3UnhwK3dOa0Rxc0p4cWpZaUlO?=
 =?utf-8?B?UENickhRZURseUFqTEFueXVXYjdRK0F0Yk5MRFp6dndsbHhxaEFhbGovTmtr?=
 =?utf-8?B?clZJeEZYTk5aZGhxRHVSV1pXdlRJbUlVbnNQd2JyNTBveFdZUDlodlJTRFc0?=
 =?utf-8?B?dFRDTHJnZ2lKU2Nydy8xdGtjN2RRYUcwcDJ1UEJ4MlNpZy9ZMlIxajViaDB5?=
 =?utf-8?Q?M9wBif5RigMGCFxiKMntQ033Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e863fe36-aa5d-4dc3-8968-08dd864fa269
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 12:24:34.3340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDqJMVCllyzbDWhWvhD9bjiSMq4fAuLlU4kJV9sZkq/cB5RTmmxTUMTRMvgUo8x+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223
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

On 4/24/25 05:38, Zhang, GuoQing (Sam) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
> Ping… @Koenig, Christian <mailto:Christian.Koenig@amd.com>
> 
> Thanks
> 
> Sam
> 
> *From: *amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, 
> GuoQing (Sam) <GuoQing.Zhang@amd.com>
> *Date: *Wednesday, April 23, 2025 at 14:59
> *To: *Christian König <ckoenig.leichtzumerken@gmail.com>, amd- 
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com>, 
> Deng, Emily <Emily.Deng@amd.com>, Zhang, Owen(SRDC) <Owen.Zhang2@amd.com>
> *Subject: *Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi @Christian König <mailto:ckoenig.leichtzumerken@gmail.com>,
> 
> On QEMU VM environment, when request_irq() is called in guest KMD, QEMU will 
> enable interrupt for the device on the host.
> 
> When hibernate and resume with a new vGPU without calling request_irq() on the 
> new vGPU, the interrupt of the new vGPU is not enabled. The IH handler in guest 
> KMD will not be called in this case.
> 
> This change is to ensure request_irq() is called on resume for the new vGPUs.

That doesn't make sense.

The MSI state is saved and restored by the core OS on suspend and resume, drivers should never mess with that.

If this doesn't work with the new vGPU for some reason then that is not something we can work around inside the driver.

Which state exactly isn't restored here?

Regards,
Christian.


> 
> Regards
> 
> Sam
> 
> *From: *Christian König <ckoenig.leichtzumerken@gmail.com>
> *Date: *Wednesday, April 16, 2025 at 21:54
> *To: *Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd- 
> gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.com>, 
> Deng, Emily <Emily.Deng@amd.com>
> *Subject: *Re: [PATCH 6/6] drm/amdgpu: fix fence fallback timer expired error
> 
> Am 14.04.25 um 12:46 schrieb Samuel Zhang:
>  > IH is not working after switching a new gpu index for the first time.
>  > IH handler function need to be re-registered with kernel after switching
>  > to new gpu index.
> 
> Why?
> 
> Christian.
> 
>  >
>  > Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
>  > Change-Id: Idece1c8fce24032fd08f5a8b6ac23793c51e56dd
>  > ---
>  >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c |  7 +++++--
>  >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h |  1 +
>  >  drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 18 ++++++++++++++++--
>  >  3 files changed, 22 insertions(+), 4 deletions(-)
>  >
>  > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/ 
> amdgpu/amdgpu_irq.c
>  > index 19ce4da285e8..2292245a0c5d 100644
>  > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>  > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>  > @@ -326,7 +326,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>  >        return r;
>  >  }
>  >
>  > -void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>  > +void amdgpu_irq_uninstall(struct amdgpu_device *adev)
>  >  {
>  >        if (adev->irq.installed) {
>  >                free_irq(adev->irq.irq, adev_to_drm(adev));
>  > @@ -334,7 +334,10 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>  >                if (adev->irq.msi_enabled)
>  >                        pci_free_irq_vectors(adev->pdev);
>  >        }
>  > -
>  > +}
>  > +void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>  > +{
>  > +     amdgpu_irq_uninstall(adev);
>  >        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>  >        amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>  >        amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>  > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/ 
> amdgpu/amdgpu_irq.h
>  > index 04c0b4fa17a4..c6e6681b4f71 100644
>  > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>  > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>  > @@ -123,6 +123,7 @@ extern const int node_id_to_phys_map[NODEID_MAX];
>  >  void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>  >
>  >  int amdgpu_irq_init(struct amdgpu_device *adev);
>  > +void amdgpu_irq_uninstall(struct amdgpu_device *adev);
>  >  void amdgpu_irq_fini_sw(struct amdgpu_device *adev);
>  >  void amdgpu_irq_fini_hw(struct amdgpu_device *adev);
>  >  int amdgpu_irq_add_id(struct amdgpu_device *adev,
>  > diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/ 
> amdgpu/vega20_ih.c
>  > index faa0dd75dd6d..ef996505e4dc 100644
>  > --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>  > +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
>  > @@ -643,12 +643,26 @@ static int vega20_ih_hw_fini(struct amdgpu_ip_block 
> *ip_block)
>  >
>  >  static int vega20_ih_suspend(struct amdgpu_ip_block *ip_block)
>  >  {
>  > -     return vega20_ih_hw_fini(ip_block);
>  > +     struct amdgpu_device *adev = ip_block->adev;
>  > +     int r = 0;
>  > +
>  > +     r = vega20_ih_hw_fini(ip_block);
>  > +     amdgpu_irq_uninstall(adev);
>  > +     return r;
>  >  }
>  >
>  >  static int vega20_ih_resume(struct amdgpu_ip_block *ip_block)
>  >  {
>  > -     return vega20_ih_hw_init(ip_block);
>  > +     struct amdgpu_device *adev = ip_block->adev;
>  > +     int r = 0;
>  > +
>  > +     r = amdgpu_irq_init(adev);
>  > +     if (r) {
>  > +             dev_err(adev->dev, "amdgpu_irq_init failed in %s, %d\n", 
> __func__, r);
>  > +             return r;
>  > +     }
>  > +     r = vega20_ih_hw_init(ip_block);
>  > +     return r;
>  >  }
>  >
>  >  static bool vega20_ih_is_idle(struct amdgpu_ip_block *ip_block)
> 

