Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BF7CA1016
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 10:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD1A10EA6D;
	Thu, 11 Sep 2025 10:11:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dyhuPSej";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C8310EA6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 10:11:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQsmAmWhtYPMunSchyVTwg3YGDK2A9jRqYRK+tmZ89GuJonG5ls/lqfIukKcpvnJy5JbhxdjxOCg0Sjlf59eDxE1/N8Kc3vYdtVe6EqDkqaQzcyjt0R4nbKgJ8BntzUlQz9PvR+aAC3LVPaIdR6Z8LeiwZxoBeOKSI+p4OVgr69nMC6WFIrc8+xQ7HgxBPrLSZHCa9ok/zy/LP7H4ojNt99CrleXax4vHBosaQ1tOd51YVCT0y+T82NpIJhOuvAS+i6H1uKTQoHxDARwXJNDyTl7/c9L1JJRZpFqxLZvwu3+6svGlmxwPMXRA1vEjuupgji6a8m0s0qSTiQrQ6/S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNSNTxZp/zRolmBvIJDW5BjvHxcgVsRzkEwLEdiG1Uo=;
 b=Mfxx4ilt6miOv1LXu1diELDISAChxH9tLElQR/S+PIXunwwyo8OeOsBxLWmmGsdOj9XCRq3TPT0ylnB1KctvW7LirqB+ib/PIUqieNCD2tmYQsgjnHcgL5XjYMlke/q+XM5UZLSSm7NHo0HpiaKbX1pmj0+bBOGSj3zxYsxUG/z7sLJF8gBXulUqsok7PU8cXAeK5K2B0LSQnWAFXbUN6XUmCPs3FyrkwwKgmj3ilXraZ7H8kGmh+Dx6cJkWKu8XWsysWP1Xp7aGXpRlGbUE0t7BKkrxkUiLwFrfRiBP1ZYkdUJh8ICdKEFqLc3y+K3s3hKtlkmQ3pXAfx714WoJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNSNTxZp/zRolmBvIJDW5BjvHxcgVsRzkEwLEdiG1Uo=;
 b=dyhuPSejzmxldbOdU/LgeN5uKQfUTAU1PG4fDLGzdmcVmaYQUdZBiXdNlyGp1frQWSkMy+rRkJ8XpEsxgJj8R2YOS34Zaw01U2vGJINXfIfUmgJx/YcEBIPmaGFurc/kqFIxNpZZpilkvJgtvaqcIDUOKTwqM5hzCw7nEuQ3KPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 10:11:21 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 10:11:21 +0000
Message-ID: <c37c154e-6bbe-46fa-ace9-ef9a1a259748@amd.com>
Date: Thu, 11 Sep 2025 15:41:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: revert "Rename VM invalidate to status
 lock" v2
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
Cc: Sunil.Khatri@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, Prike.Liang@amd.com
References: <20250905112701.2443-1-christian.koenig@amd.com>
 <20250905112701.2443-3-christian.koenig@amd.com>
 <CADnq5_P7W5B4Li_q1zr1rK=mdBKT_z6z4g3b8dCvid+pGEKNRQ@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_P7W5B4Li_q1zr1rK=mdBKT_z6z4g3b8dCvid+pGEKNRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7848c7-a8cb-4f21-fd75-08ddf11b8e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlZtU1F4eE8rQm1od29zR2lLNFBtZjN0aDFLZkMxMXdKaGk2WGwxTlMzT3VN?=
 =?utf-8?B?eUVhVS9FU2tBK21IeXVQbnJRU1lRZ0JPMXBwS3VEQyszd05wM1QwRmFBUFd2?=
 =?utf-8?B?Z3c2T1EzU21xT21DcjA1RDNXclA2YXRsV3MwakF1UEwwbHV3WkR6VnJvOXpW?=
 =?utf-8?B?RUxFRlNzSERwM0xSNUFJVFpXTXJDVzNLYXpjRnZlOFV4c203QVEvVWNyZEN6?=
 =?utf-8?B?bnJmb0RYb0ZiMkozRXhxN0pEM3FqaVBwbXJ5RzloMWNmWEQ5NXBobU11Wm5r?=
 =?utf-8?B?Z21VdkxOdTY0Vksrbmt2VDZOQmhXT3c4NGs1aHdOMjBMZlZ0WlVTbDhZMEM1?=
 =?utf-8?B?cVVtR1Y0NU1OYjVWdnB0bHcxT0tGblVNUXo1UFl2aEVKa0FyemxRL0ZCU3VU?=
 =?utf-8?B?THNxQThtbS8rWkk0R25qbmZFb3FyUlQ0TzQzUUk3dElnOWxhZzVCaHIvRWhM?=
 =?utf-8?B?ejNySEwySzNCWTNrSkpjSldpM1REdS8rV0FHUXdZWGZ1SEVJSVF2Q2RIeGt3?=
 =?utf-8?B?cXJPa3NaRi9xYkhwL1VNZzRzaFd2UVNCQWhBRjBNcmkzKzIxb1FGeVZweVVL?=
 =?utf-8?B?RnJVMldNR0JzY1lrcHN4dEZwQlBEc2VpVWdmNHh1aDhuak9aNVJIR3N4emJO?=
 =?utf-8?B?WEIvTjRtWlpxQmNVZzZmY1BEUjRRWUNOOEdZMzVUMk9TK1ZWVk53N3U5Qysy?=
 =?utf-8?B?QTg0cVhtMzFjMzhIWk85dlNYZHJmWEFqOXVOZm5LbHk4M2h5cjUxazF0VjJp?=
 =?utf-8?B?VU9ZVHFZM2hhMnl0Vzlqc0U5Tk1oT1lONDlTeFhtekd0U090STcvbCtIUDZ1?=
 =?utf-8?B?QnRLNC9RYmJxWlpPZTRNVHFtV3FId3JSYjBWYzZDaXYrK2JpZUxSd01mM2VM?=
 =?utf-8?B?SDBzQmtHc0cxVmxuREJiQWVKWDZXR0VOeEY1eHlhdDdLWEg3UEl3dlVFVHdt?=
 =?utf-8?B?ekd5a2RuejJGTkUrcUwrNkx6SVJGbTRIeElvemxrL2wvNlpwdUFmRjRGN3Zl?=
 =?utf-8?B?Y0lXUDRzbjlNZjhJM0dVVnJiNkIyQWY2K2lmVTZLKzNSSXhTV09WZjYwVFFp?=
 =?utf-8?B?UW16aFA2YmFJb2x1bXBwQXlFTGpJNFBSdWVPVDFWOUg3SmU4aTZGaGw0SnJk?=
 =?utf-8?B?RC9ESm9EUGQyMWRHVHZvVlg5WUZ4dHgxVEh5d2lMRGhmakhxcUtucWFYVTdw?=
 =?utf-8?B?aDlXWnRkQWFkd3NRMW5rNzZOcGM4S3M2ZWNsSFJybWZIakcwZkpXV2lMZ0dk?=
 =?utf-8?B?V1RYK3NGeUZ6TGZFSDFWTzZrYkNEam9BdlFDbnAwWXBBdWo2clR0MGFUMzd2?=
 =?utf-8?B?YkkrN0JobVkzUmVVWUZEaWNLSmx4Uml3YkdUbkxkTjdTMmR0Z1pyVWordHpF?=
 =?utf-8?B?UUZtOTZSSm9lejh3cVIxL2lNMUE3emZiOWVPTXVhNlhycUo0SjluRStMWlJt?=
 =?utf-8?B?STI4Um9tR2t2dmlrc3d3dnVueDk1ckM2RWJqWGJ3aDFrRjVsTGQzdXpyZzdT?=
 =?utf-8?B?TGorS2NTWU83WklNYTlPUlhvbVFtam5neFF0ZUVqeTFVcTZISWp5eFU2VlRh?=
 =?utf-8?B?ejBTM01nUGROV3pSNkprZDRpaGljd0pRMjlvMThPUmxGdnVFR3FQaUdOM3ZC?=
 =?utf-8?B?a09lNUFzRnBzU3J0S3d4QzhiUDk4L0FKQ0phK2xpM2loV1ZzNGZ3TWNzVVlz?=
 =?utf-8?B?R2RjR3h6MTVIN1BJUnc1VUdQelNFazVyYTBRRTFIemdzOU1EOU5nSFFCaENp?=
 =?utf-8?B?aVVlUXZXSkNMVUFuNmpHQndmOXpsM3J3Y3lqTjlzdU9NWUlXY0krcGFxbmtQ?=
 =?utf-8?B?N1hqdjZYemE2M1VyanFCWVZKNHhHQ2VEaDJJSzhRcXNQMTZpMFB2VjBXWGlk?=
 =?utf-8?B?UWx3YzhVNHlNSmhnTDhYcjdiYzErcm95bXBKamg4dE5YWSsvS1JGbFRjbnM1?=
 =?utf-8?Q?NNrrhuZPkWc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2c3a095dVY4QnYzTUR6eVlld3dRczVMcFNNaHJQOVViR1FlVjlwSWtSd0pG?=
 =?utf-8?B?T2prTVpZd1A3ZWY1TVA5Wld0OVZTOUQ1US82dTlseGZkOEhqRWRPSzhZelJW?=
 =?utf-8?B?NXhhYWFUMzhPS3prZDloY05NNXJuRmtIcUVZZlFobys2R1NnNmV5ZjYwN2tR?=
 =?utf-8?B?WU9qNUw2UFRHaU15VmtuZ1ptQmZ2REQ4YThPeVBTK3R2QXY5RFpDYW5mVnlG?=
 =?utf-8?B?RnRuZXBFV0dMOGRIK0NIa3ByM0k5ZWE3d2poZThYbXhNT3pFWjhRYWNLU3Vx?=
 =?utf-8?B?YjY4Ris4Q3Nqcm0vekNteGVVYmRXRHYyeVY3eGtEcGNhR0cvdzdiRVdzblhE?=
 =?utf-8?B?N0F2Ym9YdSt4OGFFQ1hBS0ZtYUV4aXQ4UE9IRGlKSTJnWWxKT1BpbE1uVXNZ?=
 =?utf-8?B?SGV2NjM2V3cvQVZybkU2aSt5UmNwNmVuK3hjS1BDSis3Um5MYmtWYnRZdUps?=
 =?utf-8?B?NTF0TUJ1OWZEak5Zd2VXZE4vekMwWXNvaDlsblFiQ3ByUWRqalhqWm5OakZC?=
 =?utf-8?B?S2UxQUNRRVo2cXBXekFlOWNNSzFHQkJmcXdlZFBXRWg3YklsZk5tQjdXT0py?=
 =?utf-8?B?Mm1XcS95ZHZTdUZyNDVxRDhMOUJ1bXFWVjBWTTg0U0xSRGt6WjQ1NWd2bVBE?=
 =?utf-8?B?ckFVejRMbHVFcDZUbEtXZnlJYzR5SGpoekF0MW1HSWFHRWtBdUx3amhIS3Vv?=
 =?utf-8?B?WHFnaXphRmhTZmhITTJrWG0rdTdVb05wbkNjTUJFbTdMb0NqMHltakYrczJM?=
 =?utf-8?B?dGx1VXRLbnFSOENQT0lwTktsamc3MDZydkVFKzdseFNLMXA1TmI3aERLUVZV?=
 =?utf-8?B?MnFCRW9GbVhuQWpRcURRVGlDbVl6TklscklZMUswZjdzbnBDb3V0UDZqSDFS?=
 =?utf-8?B?VDF4S0xlQzFGcTQ4QXZ0MjlQTUR0S3BHeUF3TzZTMTV5YXRkaklWY3NOL0ND?=
 =?utf-8?B?b3B2TC8yNXp1T2l3K2VZSFBWMVowdVh0TUhGeS9xVUF6V0JxUTNrRnkrT3BC?=
 =?utf-8?B?ZGxyd2NLODlIcjBXQnlYY0tnRUJRZSt2WmpPaXdvNnJDUk1WWVJnZ1Nrd205?=
 =?utf-8?B?OUxwK2RYZ0NKRnlhYnJRc25ZbURSMXAzbEJ3V1FXcFM2dUVNbXBNUnpaUmxQ?=
 =?utf-8?B?U250Q09FTVI3aEpHRUhnTTEzN0xPUmhlWjByWmdySlBMTkdWZ1A2dm5qL2R4?=
 =?utf-8?B?amZ0d2xtK05tdkZ3K2tubjhVRUF4NGhzbGx0WUV4dGh5SzVnalFvVXdaSzRh?=
 =?utf-8?B?cnd3b25MZCt5MExpNjFxaUlteHZNVFR3UGJhK3BBREFSdVF6T3ZaOElTbVUv?=
 =?utf-8?B?VVBXNW0wam82RGFRTy9zQXdqY1Y2SnhlYjJOcFp5TExTTEFmS0Z3RkJYeW4v?=
 =?utf-8?B?OGJkZEpBZjhXMVBFWWhhWkZxbnIyYlBQWC81cUZjcyt5b1JkSWtLWCtnK0t2?=
 =?utf-8?B?REV1djJ1TXV6L2J0THNYd2ZpOUFJK3djNWp4dHowaWlLcHJOYXpNMjI2UUln?=
 =?utf-8?B?ZTZ3Yi94RG9DWEFDdGlLUmNVaGdPVW5xYzRaYVhWTUJjWGI1Q21FMEt0cXp5?=
 =?utf-8?B?dGRzVndWR3kxVmdjcWJ6UjBwYkRBWmVrN0pySXlONDZDRTVQM0p1aHB2V3Vz?=
 =?utf-8?B?REhNZlFSVm5UOUI0b1JyNS9rdU1mQ3hrakZiNzN2QnlPcWdvZVRCZFhzc3hB?=
 =?utf-8?B?cHp6SGZIY24vWlRVSVlUb1IyQmhvaFdoMDE0dkZEakRZOVZFVHQwTjFGamZF?=
 =?utf-8?B?RFVmU3o5dlZOVWRuRmRoS1V0YVJ0dFQzVFdoQld0bnpwNkc4am01Z2Q2dXBI?=
 =?utf-8?B?dHJ3RmpmeXlpMm5kbmV2L0FuNlUyblh0S1BPVnNaWkRGUjgybDEvOVVRZ1VQ?=
 =?utf-8?B?dlZmUk5jdnVyalBBNEhaM2hwdFlEeEZMaTZuaUU1NUhrdkJ0QlZWTmZLTFJu?=
 =?utf-8?B?cXc3a0dtWmM3UzVUQTB5enh6MXR5T1ZjZnBhdDFKbEZ4WEhYN2Q3dFJyOGhr?=
 =?utf-8?B?OFltVE05ZGpWRkx0VHJ1SHZ2TzRPWHlJdms2cFM3U1FBL1hsREhqSzB6M3M1?=
 =?utf-8?B?czltSTVQTW5NWHh1aHBhT1ZLME90VjJBK0NNT2lNOGZNU2FleWkzd2NFUmJs?=
 =?utf-8?Q?U1g3Loqan/GSJ0erbOo8ZqLlp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7848c7-a8cb-4f21-fd75-08ddf11b8e28
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 10:11:21.2309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQrw3ouNfPsVjb9xCTAVZMC0C+sU1BeMSEspimc6X8Bc4SFEhvopJhcED30fjxg05eS1qXjNIAt6Xm5KXd3FAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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

Also i would recomment to split the change into two
a. Revert the status locks in one
b. Rest of the changes in another one.

Agree to what Alex has proposed as its not more the same revert anymore.

Regards
Sunil Khatri

On 9/5/2025 10:19 PM, Alex Deucher wrote:
> + Philip
>
> On Fri, Sep 5, 2025 at 7:27 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> This reverts commit 0479956c94b1cfa6a1ab9206eff76072944ece8b.
> I would come up with a new title.  At this point this is more than a
> revert and I think calling it out like that could lead to problems in
> stable kernels if someone just tries to revert the original commit in
> an older kernel.  Moreover, 0479956c94b1 really isn't what is actually
> being reverted.  That was just a renaming patch, so no functional
> change.  The patch this is actually reverting is whatever patch added
> the invalidated_lock in the first place.
>
> Maybe something like:
>
> drm/amdgpu: rework VM invalidation locking
>
> It turned out that protecting the status of each bo_va only with a
> spinlock was just hiding problems instead of solving them.
> Add a separate stats_lock and lockdep assertions that the correct
> reservation lock is held all over the place. While at it also re-order
> fields in the VM structure and try to improve the documentation a bit.
>
>
> Additionally is there a reason why the programming pattern changed in
> the list handling?  Most of the instances of:
>
> while (!list_empty()) {
>      entry = list_first_entry();
>
> got converted to:
>
> list_for_each_entry_safe();
>
> but not all.  Would be good to explain why if there is a reason other
> than just coding style.
>
>> It turned out that protecting the status of each bo_va only with a
>> spinlock was just hiding problems instead of solving them.
>>
>> Revert the whole approach, add a separate stats_lock and lockdep
>> assertions that the correct reservation lock is held all over the place.
>>
>> While at it also re-order fields in the VM structure and try to improve
>> the documentation a bit.
>>
>> v2: re-add missing check
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 168 +++++++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  25 ++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
>>   4 files changed, 96 insertions(+), 109 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index cb3432b12221..dd57e034ae1e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -619,12 +619,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>>          struct amdgpu_bo *bo;
>>          int ret;
>>
>> -       spin_lock(&vm->status_lock);
>> +       spin_lock(&vm->invalidated_lock);
>>          while (!list_empty(&vm->invalidated)) {
>>                  bo_va = list_first_entry(&vm->invalidated,
>>                                           struct amdgpu_bo_va,
>>                                           base.vm_status);
>> -               spin_unlock(&vm->status_lock);
>> +               spin_unlock(&vm->invalidated_lock);
>>
>>                  bo = bo_va->base.bo;
>>                  ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
>> @@ -641,9 +641,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>>                  if (ret)
>>                          return ret;
>>
>> -               spin_lock(&vm->status_lock);
>> +               spin_lock(&vm->invalidated_lock);
>>          }
>> -       spin_unlock(&vm->status_lock);
>> +       spin_unlock(&vm->invalidated_lock);
>>
>>          return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 31976ef75014..2d5e78a14124 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -127,6 +127,17 @@ struct amdgpu_vm_tlb_seq_struct {
>>          struct dma_fence_cb cb;
>>   };
>>
>> +/**
>> + * amdgpu_vm_assert_locked - check if VM is correctly locked
>> + * @vm: the VM which schould be tested
>> + *
>> + * Asserts that the VM root PD is locked.
>> + */
>> +static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>> +{
>> +       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
>>    *
>> @@ -143,6 +154,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   {
>>          int r;
>>
>> +       amdgpu_vm_assert_locked(vm);
>> +
>>          if (vm->pasid == pasid)
>>                  return 0;
>>
>> @@ -181,12 +194,11 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>>          struct amdgpu_bo *bo = vm_bo->bo;
>>
>>          vm_bo->moved = true;
>> -       spin_lock(&vm_bo->vm->status_lock);
>> +       amdgpu_vm_assert_locked(vm);
>>          if (bo->tbo.type == ttm_bo_type_kernel)
>>                  list_move(&vm_bo->vm_status, &vm->evicted);
>>          else
>>                  list_move_tail(&vm_bo->vm_status, &vm->evicted);
>> -       spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>   /**
>>    * amdgpu_vm_bo_moved - vm_bo is moved
>> @@ -198,9 +210,8 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -       spin_lock(&vm_bo->vm->status_lock);
>> +       amdgpu_vm_assert_locked(vm_bo->vm);
>>          list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
>> -       spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>
>>   /**
>> @@ -213,9 +224,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -       spin_lock(&vm_bo->vm->status_lock);
>> +       amdgpu_vm_assert_locked(vm_bo->vm);
>>          list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
>> -       spin_unlock(&vm_bo->vm->status_lock);
>>          vm_bo->moved = false;
>>   }
>>
>> @@ -229,9 +239,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -       spin_lock(&vm_bo->vm->status_lock);
>> +       spin_lock(&vm_bo->vm->invalidated_lock);
>>          list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
>> -       spin_unlock(&vm_bo->vm->status_lock);
>> +       spin_unlock(&vm_bo->vm->invalidated_lock);
>>   }
>>
>>   /**
>> @@ -244,10 +254,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> +       amdgpu_vm_assert_locked(vm_bo->vm);
>>          vm_bo->moved = true;
>> -       spin_lock(&vm_bo->vm->status_lock);
>>          list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
>> -       spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>
>>   /**
>> @@ -260,13 +269,11 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -       if (vm_bo->bo->parent) {
>> -               spin_lock(&vm_bo->vm->status_lock);
>> +       amdgpu_vm_assert_locked(vm_bo->vm);
>> +       if (vm_bo->bo->parent)
>>                  list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>> -               spin_unlock(&vm_bo->vm->status_lock);
>> -       } else {
>> +       else
>>                  amdgpu_vm_bo_idle(vm_bo);
>> -       }
>>   }
>>
>>   /**
>> @@ -279,9 +286,8 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
>>    */
>>   static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
>>   {
>> -       spin_lock(&vm_bo->vm->status_lock);
>> +       amdgpu_vm_assert_locked(vm_bo->vm);
>>          list_move(&vm_bo->vm_status, &vm_bo->vm->done);
>> -       spin_unlock(&vm_bo->vm->status_lock);
>>   }
>>
>>   /**
>> @@ -295,10 +301,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>>   {
>>          struct amdgpu_vm_bo_base *vm_bo, *tmp;
>>
>> -       spin_lock(&vm->status_lock);
>> +       spin_lock(&vm->invalidated_lock);
>>          list_splice_init(&vm->done, &vm->invalidated);
>>          list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
>>                  vm_bo->moved = true;
>> +       spin_unlock(&vm->invalidated_lock);
>> +
>> +       amdgpu_vm_assert_locked(vm_bo->vm);
>>          list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>>                  struct amdgpu_bo *bo = vm_bo->bo;
>>
>> @@ -308,14 +317,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>>                  else if (bo->parent)
>>                          list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
>>          }
>> -       spin_unlock(&vm->status_lock);
>>   }
>>
>>   /**
>>    * amdgpu_vm_update_shared - helper to update shared memory stat
>>    * @base: base structure for tracking BO usage in a VM
>>    *
>> - * Takes the vm status_lock and updates the shared memory stat. If the basic
>> + * Takes the vm stats_lock and updates the shared memory stat. If the basic
>>    * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
>>    * as well.
>>    */
>> @@ -327,7 +335,8 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>>          uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
>>          bool shared;
>>
>> -       spin_lock(&vm->status_lock);
>> +       dma_resv_assert_held(bo->tbo.base.resv);
>> +       spin_lock(&vm->stats_lock);
>>          shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>          if (base->shared != shared) {
>>                  base->shared = shared;
>> @@ -339,7 +348,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
>>                          vm->stats[bo_memtype].drm.private += size;
>>                  }
>>          }
>> -       spin_unlock(&vm->status_lock);
>> +       spin_unlock(&vm->stats_lock);
>>   }
>>
>>   /**
>> @@ -364,11 +373,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
>>    *        be bo->tbo.resource
>>    * @sign: if we should add (+1) or subtract (-1) from the stat
>>    *
>> - * Caller need to have the vm status_lock held. Useful for when multiple update
>> + * Caller need to have the vm stats_lock held. Useful for when multiple update
>>    * need to happen at the same time.
>>    */
>>   static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>> -                           struct ttm_resource *res, int sign)
>> +                                         struct ttm_resource *res, int sign)
>>   {
>>          struct amdgpu_vm *vm = base->vm;
>>          struct amdgpu_bo *bo = base->bo;
>> @@ -392,7 +401,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
>>                   */
>>                  if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>                          vm->stats[res_memtype].drm.purgeable += size;
>> -               if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
>> +               if (!(bo->preferred_domains &
>> +                     amdgpu_mem_type_to_domain(res_memtype)))
>>                          vm->stats[bo_memtype].evicted += size;
>>          }
>>   }
>> @@ -411,9 +421,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
>>   {
>>          struct amdgpu_vm *vm = base->vm;
>>
>> -       spin_lock(&vm->status_lock);
>> +       spin_lock(&vm->stats_lock);
>>          amdgpu_vm_update_stats_locked(base, res, sign);
>> -       spin_unlock(&vm->status_lock);
>> +       spin_unlock(&vm->stats_lock);
>>   }
>>
>>   /**
>> @@ -439,10 +449,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>          base->next = bo->vm_bo;
>>          bo->vm_bo = base;
>>
>> -       spin_lock(&vm->status_lock);
>> +       spin_lock(&vm->stats_lock);
>>          base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>          amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
>> -       spin_unlock(&vm->status_lock);
>> +       spin_unlock(&vm->stats_lock);
>>
>>          if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>                  return;
>> @@ -500,10 +510,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
>>          int ret;
>>
>>          /* We can only trust prev->next while holding the lock */
>> -       spin_lock(&vm->status_lock);
>> +       spin_lock(&vm->invalidated_lock);
>>          while (!list_is_head(prev->next, &vm->done)) {
>>                  bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>> -               spin_unlock(&vm->status_lock);
>> +               spin_unlock(&vm->invalidated_lock);
>>
>>                  bo = bo_va->base.bo;
>>                  if (bo) {
>> @@ -511,10 +521,10 @@ int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
>>                          if (unlikely(ret))
>>                                  return ret;
>>                  }
>> -               spin_lock(&vm->status_lock);
>> +               spin_lock(&vm->invalidated_lock);
>>                  prev = prev->next;
>>          }
>> -       spin_unlock(&vm->status_lock);
>> +       spin_unlock(&vm->invalidated_lock);
>>
>>          return 0;
>>   }
>> @@ -610,7 +620,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                         void *param)
>>   {
>>          uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>> -       struct amdgpu_vm_bo_base *bo_base;
>> +       struct amdgpu_vm_bo_base *bo_base, *tmp;
>>          struct amdgpu_bo *bo;
>>          int r;
>>
>> @@ -623,13 +633,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                          return r;
>>          }
>>
>> -       spin_lock(&vm->status_lock);
>> -       while (!list_empty(&vm->evicted)) {
>> -               bo_base = list_first_entry(&vm->evicted,
>> -                                          struct amdgpu_vm_bo_base,
>> -                                          vm_status);
>> -               spin_unlock(&vm->status_lock);
>> -
>> +       list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>>                  bo = bo_base->bo;
>>
>>                  r = validate(param, bo);
>> @@ -642,26 +646,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                          vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
>>                          amdgpu_vm_bo_relocated(bo_base);
>>                  }
>> -               spin_lock(&vm->status_lock);
>>          }
>> -       while (ticket && !list_empty(&vm->evicted_user)) {
>> -               bo_base = list_first_entry(&vm->evicted_user,
>> -                                          struct amdgpu_vm_bo_base,
>> -                                          vm_status);
>> -               spin_unlock(&vm->status_lock);
>>
>> -               bo = bo_base->bo;
>> -               dma_resv_assert_held(bo->tbo.base.resv);
>> -
>> -               r = validate(param, bo);
>> -               if (r)
>> -                       return r;
>> +       if (ticket) {
>> +               list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
>> +                                        vm_status) {
>> +                       bo = bo_base->bo;
>> +                       dma_resv_assert_held(bo->tbo.base.resv);
>>
>> -               amdgpu_vm_bo_invalidated(bo_base);
>> +                       r = validate(param, bo);
>> +                       if (r)
>> +                               return r;
>>
>> -               spin_lock(&vm->status_lock);
>> +                       amdgpu_vm_bo_invalidated(bo_base);
>> +               }
>>          }
>> -       spin_unlock(&vm->status_lock);
>>
>>          amdgpu_vm_eviction_lock(vm);
>>          vm->evicting = false;
>> @@ -684,13 +683,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>>   {
>>          bool ret;
>>
>> +       amdgpu_vm_assert_locked(vm);
>> +
>>          amdgpu_vm_eviction_lock(vm);
>>          ret = !vm->evicting;
>>          amdgpu_vm_eviction_unlock(vm);
>>
>> -       spin_lock(&vm->status_lock);
>>          ret &= list_empty(&vm->evicted);
>> -       spin_unlock(&vm->status_lock);
>>
>>          spin_lock(&vm->immediate.lock);
>>          ret &= !vm->immediate.stopped;
>> @@ -981,16 +980,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>                            struct amdgpu_vm *vm, bool immediate)
>>   {
>>          struct amdgpu_vm_update_params params;
>> -       struct amdgpu_vm_bo_base *entry;
>> +       struct amdgpu_vm_bo_base *entry, *tmp;
>>          bool flush_tlb_needed = false;
>> -       LIST_HEAD(relocated);
>>          int r, idx;
>>
>> -       spin_lock(&vm->status_lock);
>> -       list_splice_init(&vm->relocated, &relocated);
>> -       spin_unlock(&vm->status_lock);
>> +       amdgpu_vm_assert_locked(vm);
>>
>> -       if (list_empty(&relocated))
>> +       if (list_empty(&vm->relocated))
>>                  return 0;
>>
>>          if (!drm_dev_enter(adev_to_drm(adev), &idx))
>> @@ -1005,7 +1001,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>          if (r)
>>                  goto error;
>>
>> -       list_for_each_entry(entry, &relocated, vm_status) {
>> +       list_for_each_entry(entry, &vm->relocated, vm_status) {
>>                  /* vm_flush_needed after updating moved PDEs */
>>                  flush_tlb_needed |= entry->moved;
>>
>> @@ -1021,9 +1017,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>          if (flush_tlb_needed)
>>                  atomic64_inc(&vm->tlb_seq);
>>
>> -       while (!list_empty(&relocated)) {
>> -               entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
>> -                                        vm_status);
>> +       list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
>>                  amdgpu_vm_bo_idle(entry);
>>          }
>>
>> @@ -1249,9 +1243,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>                            struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>>   {
>> -       spin_lock(&vm->status_lock);
>> +       spin_lock(&vm->stats_lock);
>>          memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
>> -       spin_unlock(&vm->status_lock);
>> +       spin_unlock(&vm->stats_lock);
>>   }
>>
>>   /**
>> @@ -1618,29 +1612,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>                             struct amdgpu_vm *vm,
>>                             struct ww_acquire_ctx *ticket)
>>   {
>> -       struct amdgpu_bo_va *bo_va;
>> +       struct amdgpu_bo_va *bo_va, *tmp;
>>          struct dma_resv *resv;
>>          bool clear, unlock;
>>          int r;
>>
>> -       spin_lock(&vm->status_lock);
>> -       while (!list_empty(&vm->moved)) {
>> -               bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
>> -                                        base.vm_status);
>> -               spin_unlock(&vm->status_lock);
>> -
>> +       list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>>                  /* Per VM BOs never need to bo cleared in the page tables */
>>                  r = amdgpu_vm_bo_update(adev, bo_va, false);
>>                  if (r)
>>                          return r;
>> -               spin_lock(&vm->status_lock);
>>          }
>>
>> +       spin_lock(&vm->invalidated_lock);
>>          while (!list_empty(&vm->invalidated)) {
>>                  bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
>>                                           base.vm_status);
> Why is this not converted to  list_for_each_entry_safe() like all of
> the others above?
>
> Alex
>
>
>>                  resv = bo_va->base.bo->tbo.base.resv;
>> -               spin_unlock(&vm->status_lock);
>> +               spin_unlock(&vm->invalidated_lock);
>>
>>                  /* Try to reserve the BO to avoid clearing its ptes */
>>                  if (!adev->debug_vm && dma_resv_trylock(resv)) {
>> @@ -1672,9 +1661,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>                       bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
>>                          amdgpu_vm_bo_evicted_user(&bo_va->base);
>>
>> -               spin_lock(&vm->status_lock);
>> +               spin_lock(&vm->invalidated_lock);
>>          }
>> -       spin_unlock(&vm->status_lock);
>> +       spin_unlock(&vm->invalidated_lock);
>>
>>          return 0;
>>   }
>> @@ -2203,9 +2192,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>                  }
>>          }
>>
>> -       spin_lock(&vm->status_lock);
>> +       spin_lock(&vm->invalidated_lock);
>>          list_del(&bo_va->base.vm_status);
>> -       spin_unlock(&vm->status_lock);
>> +       spin_unlock(&vm->invalidated_lock);
>>
>>          list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>>                  list_del(&mapping->list);
>> @@ -2313,10 +2302,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
>>          for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>>                  struct amdgpu_vm *vm = bo_base->vm;
>>
>> -               spin_lock(&vm->status_lock);
>> +               spin_lock(&vm->stats_lock);
>>                  amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
>>                  amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
>> -               spin_unlock(&vm->status_lock);
>> +               spin_unlock(&vm->stats_lock);
>>          }
>>
>>          amdgpu_vm_bo_invalidate(bo, evicted);
>> @@ -2583,11 +2572,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>          INIT_LIST_HEAD(&vm->relocated);
>>          INIT_LIST_HEAD(&vm->moved);
>>          INIT_LIST_HEAD(&vm->idle);
>> +       spin_lock_init(&vm->invalidated_lock);
>>          INIT_LIST_HEAD(&vm->invalidated);
>> -       spin_lock_init(&vm->status_lock);
>>          INIT_LIST_HEAD(&vm->freed);
>>          INIT_LIST_HEAD(&vm->done);
>>          INIT_KFIFO(vm->faults);
>> +       spin_lock_init(&vm->stats_lock);
>>
>>          r = amdgpu_vm_init_entities(adev, vm);
>>          if (r)
>> @@ -3052,7 +3042,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>>          unsigned int total_done_objs = 0;
>>          unsigned int id = 0;
>>
>> -       spin_lock(&vm->status_lock);
>> +       amdgpu_vm_assert_locked(vm);
>> +
>>          seq_puts(m, "\tIdle BOs:\n");
>>          list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>>                  if (!bo_va->base.bo)
>> @@ -3090,11 +3081,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>>          id = 0;
>>
>>          seq_puts(m, "\tInvalidated BOs:\n");
>> +       spin_lock(&vm->invalidated_lock);
>>          list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
>>                  if (!bo_va->base.bo)
>>                          continue;
>>                  total_invalidated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>>          }
>> +       spin_unlock(&vm->invalidated_lock);
>>          total_invalidated_objs = id;
>>          id = 0;
>>
>> @@ -3104,7 +3097,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
>>                          continue;
>>                  total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
>>          }
>> -       spin_unlock(&vm->status_lock);
>>          total_done_objs = id;
>>
>>          seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index f86b1a6afb0c..03219ba110b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
>>          /* protected by bo being reserved */
>>          struct amdgpu_vm_bo_base        *next;
>>
>> -       /* protected by vm status_lock */
>> +       /* protected by vm reservation and status_lock */
>>          struct list_head                vm_status;
>>
>>          /* if the bo is counted as shared in mem stats
>> -        * protected by vm status_lock */
>> +        * protected by vm BO being reserved */
>>          bool                            shared;
>>
>>          /* protected by the BO being reserved */
>> @@ -343,18 +343,13 @@ struct amdgpu_vm {
>>          bool                    evicting;
>>          unsigned int            saved_flags;
>>
>> -       /* Lock to protect vm_bo add/del/move on all lists of vm */
>> -       spinlock_t              status_lock;
>> -
>> -       /* Memory statistics for this vm, protected by status_lock */
>> +       /* Memory statistics for this vm, protected by stats_lock */
>> +       spinlock_t              stats_lock;
>>          struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>>
>>          /* Per-VM and PT BOs who needs a validation */
>>          struct list_head        evicted;
>>
>> -       /* BOs for user mode queues that need a validation */
>> -       struct list_head        evicted_user;
>> -
>>          /* PT BOs which relocated and their parent need an update */
>>          struct list_head        relocated;
>>
>> @@ -364,15 +359,19 @@ struct amdgpu_vm {
>>          /* All BOs of this VM not currently in the state machine */
>>          struct list_head        idle;
>>
>> -       /* regular invalidated BOs, but not yet updated in the PT */
>> +       /* Regular BOs for KFD queues that need a validation */
>> +       struct list_head        evicted_user;
>> +
>> +       /* Regular invalidated BOs, need to be validated and updated in the PT */
>> +       spinlock_t              invalidated_lock;
>>          struct list_head        invalidated;
>>
>> +       /* Regular BOs which are validated and location has been updated in the PTs */
>> +       struct list_head        done;
>> +
>>          /* BO mappings freed, but not yet updated in the PT */
>>          struct list_head        freed;
>>
>> -       /* BOs which are invalidated, has been updated in the PTs */
>> -       struct list_head        done;
>> -
>>          /* contains the page directory */
>>          struct amdgpu_vm_bo_base     root;
>>          struct dma_fence        *last_update;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 30022123b0bf..f57c48b74274 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -541,9 +541,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>          entry->bo->vm_bo = NULL;
>>          ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>>
>> -       spin_lock(&entry->vm->status_lock);
>>          list_del(&entry->vm_status);
>> -       spin_unlock(&entry->vm->status_lock);
>>          amdgpu_bo_unref(&entry->bo);
>>   }
>>
>> @@ -587,7 +585,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>>          struct amdgpu_vm_pt_cursor seek;
>>          struct amdgpu_vm_bo_base *entry;
>>
>> -       spin_lock(&params->vm->status_lock);
>>          for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
>>                  if (entry && entry->bo)
>>                          list_move(&entry->vm_status, &params->tlb_flush_waitlist);
>> @@ -595,7 +592,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>>
>>          /* enter start node now */
>>          list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
>> -       spin_unlock(&params->vm->status_lock);
>>   }
>>
>>   /**
>> --
>> 2.43.0
>>
