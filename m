Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6EDC021AA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 03:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FB510E454;
	Thu, 20 Feb 2025 03:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DjYjro+D";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A386A10E4AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 03:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj1O3AshVjpyA2Q3I4/FzMjJ8OA7GqcS7W53gLuPUyEEFgBJlVKKSI6PmL39Fyhx2ZbtvNHZ3i2QZUWz3oaD+PmeHJOA4bf7doOOBr5ywgJDMv1PYRloTWetFwDQg813ehBwCf4W2sNmqkbadT8xcEMbqF46neA1thQQ3k4sJ0tot00QgX9YyQxrz3jknyCri2mlo6Wu9mxajgrGB3gjLJlnnHCErIPIY/zLjknMtfqYIcdmXtHuEmJjIownTZf8QIt7LRUpSsiXb2Wu7vv6zPIffGV1yZg9putULqmBd29ONjPAoVrMk4NviHwaEucZ83MGeRNIg7+OAkd4R1aG0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds2XmTwLkdK32rlDGIMMf1ez0/ejwMlmwvk9QC3rWNM=;
 b=UoIJZtgyhamMDHctjHilG1vAAoJQk6ZLuJj2DUDxsI+Y5gwCBwFnxge0CRP6nqpQtGTfybq86EvsDx3DpB8EEY0vl4eabNzlfFChqvD0VIXC7Z1z3/vnVsqGSEnW3IXfzuwhHx7u3QZPi+kfYSE2WdAbvrb9OymKvZODeRhFEiBfeyg2Zx+0sURrKhu7WLHTQGKjlHYcS7SEb1RgF7yNL9z0TRDQHpB3+LADtyCfc0qCq7UsCqfxAGkvNyUqVIUo0QEQYkxmwHJ/pkO9v76tIQVx14LsrfWRHS2e8VBc80SCSVlzsJyC0YeGhz/3dDxwBZz1bhduzud9WJ+iRcc8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds2XmTwLkdK32rlDGIMMf1ez0/ejwMlmwvk9QC3rWNM=;
 b=DjYjro+DEZk//vPZrD6jAuHGmRnBXVTfAqvAh3do92Ktjon2Id596ga9NrLWpKdRDpcUM3pYYRvJHAtpORkQgwksdIla7Rfsl/9pTBt8seG6eTDzVUGNB4FIl2db3weSE3KRpmghEFmlVYmL+O/02UfcFjFa6UGvhWs7wnh40uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 03:17:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 03:17:58 +0000
Message-ID: <0578f426-2053-406f-8527-ea174be96d89@amd.com>
Date: Thu, 20 Feb 2025 08:47:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
 parameter for SDMA reset synchronization
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
 <20250213054715.3121445-3-jesse.zhang@amd.com>
 <f61682b9-59cf-487f-9d83-a79d4555ffd8@amd.com>
 <CY8PR12MB74359FDE16AF97D324B7EFB285FA2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <BL1PR12MB51449A0FA22045FA57CB3162F7C52@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CY8PR12MB7435A90C377278B3CDF1174B85C52@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CADnq5_M1V6JOB8vfWSUPz2CoCB7VcGWrUZcbV3-P8NAY=9Uq7A@mail.gmail.com>
 <CY8PR12MB7435C6714F11F813E249144585C42@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB7435C6714F11F813E249144585C42@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa773ab-de90-4db5-6daf-08dd515d2c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzR0UWVzenJCYTFram5hQW5kN254Q3NUNXlBQTFyQ3o0NkxVNXFvZWxBK05U?=
 =?utf-8?B?NmdxZFg4VFpVOExlUFNURTVjZU9odlpoUU9CbXlpNEhrR1crdzFpczdKMjYx?=
 =?utf-8?B?MktnMHN0TkthOGk1b1MzTUg0VVI1VlRYZmJ6aVV6TmpjRjFhb09leUgxWlVY?=
 =?utf-8?B?TnRaNWZWQm1YSFhIM1A4cHg1c3dsb1hDV0NyMzNMUkUvRFQzVVM2RkRXYUEy?=
 =?utf-8?B?YVhPRUVFTVFKU291dVNVLzRNYWpvV0MzZkdubG5OZGY0cHFlbzN6UUxnZDkz?=
 =?utf-8?B?WmxpUFJHMjBkQ1hEV0Rma1NDZmFtbW9hek9DYmd3b0g0UWZVZmFqK3J1S01R?=
 =?utf-8?B?cWRuT29vOTRTLzlnUVpFc3lIK1BNSlg3UFpwVC94ME5Kc0oxK2JFT01rb05h?=
 =?utf-8?B?RFU1VjVkaWd4Vk5WVzFLZ0ZWSWMrVWpZTEcyVHZZQkRkQkMxWlRIK2pMektP?=
 =?utf-8?B?QVZUNzlnZjYvVUQxNWhUTkNjM2puMkFUUnBGMVdEeHFyZWdmUkZuWDdYb1Yr?=
 =?utf-8?B?TkI3WnRLR2xHN2VPRG1LTFlSaXJERHMvNVhkQnkxYzkxVlM3R1VseVJld2Yx?=
 =?utf-8?B?eG1LOVhWNEVSb0ZYcmtWbStJZjh4N2d1d2htY01tK2tTTzJ5NHBzK0VyeVRY?=
 =?utf-8?B?Tmt2eEV1VFllTHhVR0JFZCtmZkg0ZVBiRFY3MnBpbTMyKytNcGNFL1haV1Z6?=
 =?utf-8?B?dEdjZU80ZDZZUlpTQktGUWp2QTdDc3VTYlhlRjhmSnpJUkc0ZlFqckkwVFgv?=
 =?utf-8?B?aG5abFBWOExaZXdsMVBXZFQ4ZWVEaW1LdTdHVVNUUENhUEtPVEFlYzNjMkhF?=
 =?utf-8?B?LzZBdzhRd2MySWFCRnduVXlBd0tlb0x0VExSaFVQTWs0WWhMNVJlUTJqQ015?=
 =?utf-8?B?MHR0UHkyWFkvQS84c0lDdE1LcXlCYlpmYW5nY2dBUit6T0Q2T2N2N0JadVBK?=
 =?utf-8?B?YlJtWmNzTDJyQ3g1S25WdFhsWEZ0NHRrdDBQdGxtR0JxOXkvU2c0ZXVLYU5I?=
 =?utf-8?B?M0gyOFIxR1dsaG9XTEptOEhRTFJDbHJSS0FNTncwOEszSjJnVkFYdGdldDBq?=
 =?utf-8?B?ZHZld1F2RmpSSlBsV2ZxUThGbUNTR2VOcnQvL09FVHpJdDZSZ2RCUEpGZlJz?=
 =?utf-8?B?NmR2OVZVN0hjS2xkWlI4OFhzYno4M0M1NFRPSk9RQ1dhM2JzOXNxWm8zMGY2?=
 =?utf-8?B?d3FuQkJBWlBZTlY0b3poQ1FTVEM2YkVzdm92UVRTUGlXeHBVOWV6Q3RHaUt6?=
 =?utf-8?B?Y1dBWWZZZ1JhQWFndmFoUi81elJGUTA3T0J2ckFuc0thRU5hemZWUWZ1WEFZ?=
 =?utf-8?B?OFFUOG1rVGhETnNldUZHRDhidFdnd2FTQ2UxR2tudy9JV2R5N3p3SnVsV2pz?=
 =?utf-8?B?TFdsaWRZa0N1Y3VpZk43V2tka1ZEaU8wQzVnT0w0MWMrV3dUVGhIME9PclIy?=
 =?utf-8?B?NUdXUkptTzFvVkFlalZtbGJJWHVwVlpVUkV3VTVJZnE0SHNjSGo4d1FXc2hW?=
 =?utf-8?B?WUE3S1VIcUFoMWlDeVlyMnMva0RUZlFUOEx4YnFCb2NrMlZITlI2KzFEQ0pE?=
 =?utf-8?B?OG00WlhXRkdkbEJtOTBKWW9kTjIvckxCZ2dxZHNqbWdzZUtKZlBDR3ZYL3Uz?=
 =?utf-8?B?QUhUZDlCS21JQTROQnN2aThFcHNKekZOSWlIbnRjU01BZ0tCWGRvODNlMFZs?=
 =?utf-8?B?K1UvZEVObVlHb3h4NHBsSkF2ektTUmJ2MkRGa1NhQ0lrU0pyL1dXc0xMa0pU?=
 =?utf-8?B?OWJXMmhsNmhCc1ZlWUdqcm9NMHAvTXd3bjM5Z3ZuQTRUUHFnMld1ekl5cFBa?=
 =?utf-8?B?NElBUnRBZnlnaW1LYXQ5TExYNnBDTTd0U1NMUWsyZFRYcjdaa0JrUDVWQTlN?=
 =?utf-8?Q?hJzZ5Nu3GSSqh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVVqNi82ODhUUE9pbTE1TkFPRjJwMG5XUHlUYWxSTTNRWklPNXVaT2toZjVB?=
 =?utf-8?B?b1dSY0FOalowSHEzZ3J2TzJGT0RObEl4UkhqaDlOSWlKdWJrYVA5TXJFVm83?=
 =?utf-8?B?ZTZ0ZWd2YkhKeWxtZG53MWFwWEE1T3pLK0JTY2dmMFBsWS9zS3FzQ2x6cWtj?=
 =?utf-8?B?RFk2US85amsyaHhqR1g4dDRBOVFsdi8zSFB0bDVKQXJFaEFNV2NBU01PUVZU?=
 =?utf-8?B?OHlDYWo5dUs0c3FwMG53R2gxUEQ1VnBtZFlUbURod1pFbFArNDd4STB6TFJY?=
 =?utf-8?B?aTRzL0pNdGd6RE10SmdpTEJsL3h5OWtGa240WlVxSERBRkpjSVFTUThTK25P?=
 =?utf-8?B?RlEwa0Z5bTFkMS9USjEvcm1kS3Q5TnFEZjBCS25Vb1FPaTJrR2Qyb0JDM2k5?=
 =?utf-8?B?OER6WjU2dlhiTlplRUVvVmJiWHlnMDhTSHZPa0hVRktRWjlDeTNjRmNzSE5n?=
 =?utf-8?B?YmtqbzYwYTgraWJxVXNUbW1SVFVGaWhidVF6U3dLUk13RC9leEdkTG5qc2li?=
 =?utf-8?B?cEtGWlpFZi9ubnppMnBqd0M0M1RSUG96VnlCSDJRNVg3eWFMNUZGVXZMWFc5?=
 =?utf-8?B?N2RjZnVTUDdyMkdFaStGM2h2VWFRYzlxR2NLcnVqYzFBYzU4aHUvMk40OHpy?=
 =?utf-8?B?aEhWQ2xRdjNydXgyaWFxL3ZBVGZmN0hLdlVyMDlSSTNWS0c2ZVhwTkNKTzFL?=
 =?utf-8?B?VEJuV09POU1Rb2lxS0F6OXhQM0UzaFRrL1lhY0xtbDVxeG9FWldVNUFmUVVF?=
 =?utf-8?B?bm5DWEt3UnV2SGVnR3ZKUndJR2pma1d4aDRvWXRGRUFITWd0RVJEeThQVHl2?=
 =?utf-8?B?RENSZHpFdnpIQ3kzTWRtdFlHaUhwOExYbVd0QW5LSXhLQm1mcFgza045SmZX?=
 =?utf-8?B?WU5zMncrRWFKdlQvbFA3MkRYbFcvK1VOZVdVWnMrNENVVk50bDJSTWpFcTBO?=
 =?utf-8?B?YzFGZXd2ck5ZOGRGSHVUcm1kREliU1UxbkRNekMraDg3ZDBQWnAxN283Vy84?=
 =?utf-8?B?WDIrUHdDVXI5dTI0Snh3YWpEZW9LSVVialFQTFZmejE1Mlkya3FmYTg3T3ZT?=
 =?utf-8?B?ckRiNUsvWS95Y2g5QkJiczRsU1Z3ODFIV2xoN1JCYitaYU1YWHhBQU9wajRC?=
 =?utf-8?B?NTIzRzdobkx4eno2S1d6SElnZmtGVjcrOHJMSDU1NnluYzUzZ1h6bjJJS3h3?=
 =?utf-8?B?OHFHVXcvVkZ2Yit6WkRtNVlyUHJ6QlJ1MlozWG81dWtudUVKdnN3WkJpdzdM?=
 =?utf-8?B?bDM0dGY2RUhneUdONGtGWVc1c1cxcTV5UlZ0dXk1MHpzZTBHcHJMVjhLZnpS?=
 =?utf-8?B?NFdQVEoyRnBtTWt4VFhOa28yV3l2T2tMbE9tbzRvWDk5dGxYK2pZYjZlazlC?=
 =?utf-8?B?V2ZjTmhnTHI0bFhWaFVrNUtpZitkcWhBcit1S1F5c0xUekxwUWVSQUMwMm1k?=
 =?utf-8?B?K0ZBczVlN0NpTnBnMEo2QUdMZHpNVGhnbXlOTS94ekZzQURTRThycWg1c2JT?=
 =?utf-8?B?TS93MnFzOVJmRTU1dmc3aEhqSlZPZHhBVWw3NmNjRzFSczV6UU9TS0hOdnlT?=
 =?utf-8?B?Nkh2Mmh4L1V3eVVIc0U1RTNkUlJDTXFTaFlna0VYTHBYY2xpdXFtWHp0T3N4?=
 =?utf-8?B?VTRpVUtyTEJCS0tROFgzclFJZzZLelZMaVhjOFowMGRTU3FkZU1BT2NsQVZN?=
 =?utf-8?B?K29LaWZROGZOcVRDcDFIWU5BNjN4MHhJUHlMVEZScVhZcFJ0RGs1TDBSbnA2?=
 =?utf-8?B?Y2hMTUYrTCtheG83L0VIVGhRWFVlNFNGSEN1ODI2czIydG0vd3pBNDlXbWIr?=
 =?utf-8?B?TXRML0ZtSEpDL1NxOEl4b3BpNjJMVWY5SU1GenEwZDJsbnA2Mmk5ZXY0RkxQ?=
 =?utf-8?B?dTdZbmlEOVlQNXFGYitxTkZIRHRhbmhvTjVyYWpuZXl2OEg4Ykg1NmhNTm9p?=
 =?utf-8?B?VS92UkM4Wnlrd00wNlI5TFZnV25taldvOXozNmpCOG1OZnplbW1iK1pMMUl2?=
 =?utf-8?B?cTlMWjlqRkl2U3NJNGswY25ubThhbFE0VVA2T3RUeTdmbmdZd0FvQ2VFUTVG?=
 =?utf-8?B?MTk3SVpKUFV3V1dPRkNYVGRKUHJIcnlzTnhoRmVEU21mUHYrbTNWc1Evc1l4?=
 =?utf-8?Q?lJ8iy45P3gfKdrOMpmsN4NDVQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa773ab-de90-4db5-6daf-08dd515d2c6b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 03:17:57.8897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmtiRuPmvWXk4MjaRgasWGVEdAFieJDBklGJaV+hX1junm7XCcz2QeXmq1fMck4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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



On 2/20/2025 6:57 AM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Wednesday, February 19, 2025 6:09 PM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
>> gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhu, Jiadong
>> <Jiadong.Zhu@amd.com>
>> Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
>> parameter for SDMA reset synchronization
>>
>> On Wed, Feb 19, 2025 at 3:29 PM Kim, Jonathan <Jonathan.Kim@amd.com> wrote:
>>>
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Sent: Wednesday, February 19, 2025 12:39 PM
>>>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>;
>>>> Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhu, Jiadong
>>>> <Jiadong.Zhu@amd.com>
>>>> Subject: RE: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
>>>> parameter for SDMA reset synchronization
>>>>
>>>> [Public]
>>>>
>>>>> -----Original Message-----
>>>>> From: Kim, Jonathan <Jonathan.Kim@amd.com>
>>>>> Sent: Tuesday, February 18, 2025 12:42 PM
>>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie)
>>>>> <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>>>>> <Felix.Kuehling@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
>>>>> Subject: RE: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset caller
>>>>> parameter for SDMA reset synchronization
>>>>>
>>>>> [Public]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Monday, February 17, 2025 10:36 PM
>>>>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
>>>>>> amd-gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>>>>>> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
>> Zhu,
>>>>>> Jiadong <Jiadong.Zhu@amd.com>
>>>>>> Subject: Re: [PATCH V7 3/9] drm/amdgpu: Add common lock and reset
>>>>>> caller parameter for SDMA reset synchronization
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2/13/2025 11:17 AM, jesse.zhang@amd.com wrote:
>>>>>>> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>>>>>>>
>>>>>>> This commit introduces a caller parameter to the
>>>>>>> amdgpu_sdma_reset_instance
>>>>>> function to differentiate
>>>>>>> between reset requests originating from the KGD and KFD.
>>>>>>> This change ensures proper synchronization between KGD and KFD
>>>>>>> during SDMA
>>>>>> resets.
>>>>>>>
>>>>>>> If the caller is KFD, the function now acquires and releases the
>>>>>>> scheduler lock
>>>>>> (ring->sched.job_list_lock)
>>>>>>> to protect the SDMA queue during the reset.
>>>>>>>
>>>>>>> These changes prevent race conditions and ensure safe SDMA reset
>>>>>>> operations when initiated by KFD, improving system stability and reliability.
>>>>>>>
>>>>>>> V2: replace the ring_lock with the existed the scheduler
>>>>>>>     locks for the queues (ring->sched) on the sdma engine.(Alex)
>>>>>>>
>>>>>>> v3: call drm_sched_wqueue_stop() rather than job_list_lock.
>>>>>>>     If a GPU ring reset was already initiated for one ring at
>>>> amdgpu_job_timedout,
>>>>>>>     skip resetting that ring and call drm_sched_wqueue_stop()
>>>>>>>     for the other rings (Alex)
>>>>>>>
>>>>>>>    replace  the common lock (sdma_reset_lock) with DQM lock to
>>>>>>>    to resolve reset races between the two driver sections during KFD
>>>>>>> eviction.(Jon)
>>>>>>>
>>>>>>>    Rename the caller to Reset_src and
>>>>>>>    Change AMDGPU_RESET_SRC_SDMA_KGD/KFD to
>>>>>> AMDGPU_RESET_SRC_SDMA_HWS/RING (Jon)
>>>>>>> v4: restart the wqueue if the reset was successful,
>>>>>>>     or fall back to a full adapter reset. (Alex)
>>>>>>>
>>>>>>>    move definition of reset source to enumeration
>> AMDGPU_RESET_SRCS,
>>>>> and
>>>>>>>    check reset src in amdgpu_sdma_reset_instance (Jon)
>>>>>>>
>>>>>>> v5: Call amdgpu_amdkfd_suspend/resume at the start/end of reset
>>>>>>> function
>>>>>> respectively under !SRC_HWS
>>>>>>>     conditions only (Jon)
>>>>>>>
>>>>>>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
>>>>>>> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
>>>>>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 +
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 65
>>>>>>> ++++++++++++++++++++---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>> |
>>>>>>> 6 +--  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 +--
>>>>>>>  4 files changed, 67 insertions(+), 14 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>> index 4d9b9701139b..5b86e12ff9fe 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>> @@ -43,6 +43,8 @@ enum AMDGPU_RESET_SRCS {
>>>>>>>     AMDGPU_RESET_SRC_MES,
>>>>>>>     AMDGPU_RESET_SRC_HWS,
>>>>>>>     AMDGPU_RESET_SRC_USER,
>>>>>>> +   AMDGPU_RESET_SRC_SDMA_RING,
>>>>>>> +   AMDGPU_RESET_SRC_SDMA_HWS,
>>>>>>>  };
>>>>>>>
>>>>>>>  struct amdgpu_reset_context {
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>> index fe39198307ec..808c7112ef10 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>  #include "amdgpu.h"
>>>>>>>  #include "amdgpu_sdma.h"
>>>>>>>  #include "amdgpu_ras.h"
>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>
>>>>>>>  #define AMDGPU_CSA_SDMA_SIZE 64
>>>>>>>  /* SDMA CSA reside in the 3rd page of CSA */ @@ -485,6 +486,7 @@
>>>>>>> void amdgpu_sdma_register_on_reset_callbacks(struct
>>>>>> amdgpu_device *adev, struct
>>>>>>>   * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
>>>>>>>   * @adev: Pointer to the AMDGPU device
>>>>>>>   * @instance_id: ID of the SDMA engine instance to reset
>>>>>>> + * @src: The source of reset function (KGD or KFD)
>>>>>>>   *
>>>>>>>   * This function performs the following steps:
>>>>>>>   * 1. Calls all registered pre_reset callbacks to allow KFD and
>>>>>>> AMDGPU to save
>>>>>> their state.
>>>>>>> @@ -493,20 +495,49 @@ void
>>>>>>> amdgpu_sdma_register_on_reset_callbacks(struct
>>>>>> amdgpu_device *adev, struct
>>>>>>>   *
>>>>>>>   * Returns: 0 on success, or a negative error code on failure.
>>>>>>>   */
>>>>>>> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>>>>> instance_id)
>>>>>>> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>>>>> instance_id, int src)
>>>>>>>  {
>>>>>>>     struct sdma_on_reset_funcs *funcs;
>>>>>>> -   int ret;
>>>>>>> +   int ret = 0;
>>>>>>> +   struct amdgpu_sdma_instance *sdma_instance = &adev-
>>>>>>> sdma.instance[instance_id];;
>>>>>>> +   struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
>>>>>>> +   struct amdgpu_ring *page_ring = &sdma_instance->page;
>>>>>>> +   bool gfx_sched_stopped = false, page_sched_stopped = false;
>>>>>>> +
>>>>>>> +   /* Check if the reset source is valid for SDMA ring reset */
>>>>>>> +   if (src != AMDGPU_RESET_SRC_SDMA_RING && src !=
>>>>>> AMDGPU_RESET_SRC_HWS)
>>>>>>> +           return -EINVAL;
>>>>>>> +
>>>>>>> +   /* Suspend KFD if the reset source is not SDMA_HWS.
>>>>>>> +    * prevent the destruction of in-flight healthy user queue packets and
>>>>>>> +    * avoid race conditions between KFD and KGD during the reset
>> process.
>>>>>>> +    */
>>>>>>> +   if (src != AMDGPU_RESET_SRC_SDMA_HWS)
>>>>>>> +           amdgpu_amdkfd_suspend(adev, false);
>>>>>>
>>>>>> It this has to be done here, what's the idea behind registering a
>>>>>> separate pre/post callback for KFD initiated resets?
>>>>>
>>>>> The problem is that for SDMA v5.x and below, a single soft reset call will reset
>> all
>>>>> queues on the target SDMA engine.
>>>>> If the KGD calls the reset, a transient KFD suspend/resume around the reset
>> will
>>>>> guarantee that healthy user queues survive the reset.
>>>>> If the KFD calls the reset, it will only do so during preemption failure, and we
>> don't
>>>>> want to suspend and resume the KFD again when the KFD calls this function.
>>>>> The KFD needs to call this common function to not disturb GFX and paging
>> queues
>>>>> for the same reason KGD resets need to be wary of KFD queues.
>>>>> In the case of preemption failure and a KFD initiated reset, the KFD is holding
>> the
>>>>> device wide preemption lock, so if the KGD is trying to reset as well, it will have
>> to
>>>>> wait on its own KFD suspend call until the KFD is done its own reset.
>>>>>
>>>>> I think SDMA6+ can target specific queues via MMIO reg writes, but I see in
>> the
>>>>> KGD code that soft_reset for SDMA 6+ does a sweep of all engines so we
>> would
>>>>> still need to keep KFD queues safe (I'm not familiar with this chunk of the code
>> or
>>>>> the need for sweeping all engines on the KGD side).
>>>>> So I'm not sure if Jesse had concerns about potential multiple calls being made
>> in
>>>>> other parts of the code and maybe this was some way to simplify things.
>>>>> Either way, not sure if it's simpler to drop the reset source param and have the
>>>> KGD
>>>>> remember to unconditionally KFD suspend/resume around the soft reset call
>> for
>>>>> each IP version, or keep the reset source param here so that we only have to
>>>>> remember to do this once.
>>>>
>>>> Could KFD keep track of whether the hang was detected by KFD or KGD?  E.g.,
>> if
>>>> KFD detects the hang when suspending queues, it could set a flag and then KFD
>>>> could include a call to amdgpu_amdkfd_suspend() in its pre_reset callback that
>>>> would depend on the value of that flag.  At that point I don't think we'd need the
>> src
>>>> parameter any more.
>>>
>>> Hmmm.  Something similar to GPU resets?
>>> The thing about GPU resets is that the KFD could just detect the flag, schedule an
>> event then carry on knowing the driver is going to die and re-init at some point.
>>> SDMA resets are different because the KFD would call back into the common KGD
>> call immediately because it wants to fix things right away, and the KGD has to ensure
>> the KFD is quiesced in any case.
>>> So any flag would have to be locked as well in the KFD pre/post calls.   Which
>> means we'd probably have to conditionally lock it based on a new reset context that
>> the KGD would have to supply anyways.
>>> This was the main reason why I wanted to simplify things by leveraging a
>> conditional suspend/resume call in the common interface.
>>> Maybe I'm not looking at things clearly atm, but if feels like we're pushing the
>> complication from one part of the driver into another.
>>>
>>> If we really don't like the idea of adding flags, maybe we can just add a param "bool
>> suspend_user_queues" to the common interface?
>>> Then maybe it's clearer that the KGD, as a reset requester, wants to be careful of
>> destroying in-flight user queues while the KFD doesn't care about this for its own
>> needs (since it's already in post-preemption recovery).
>>>
>>
>> Having the src for a parameter is fine with me.  It just seemed
>> logical to keep it in KFD since presumably KFD would have detected
>> this condition after calling amdgpu_amdkfd_suspend() itself so it
>> would know whether it would need to be called based on its own state
>> so it would know what to do in its pre and post reset hooks already.
> 
> The case of successful KFD suspend during reset isn't really a concern since the KFD cannot get into a preemption failure at this point.
> It's the corner case when the KFD suspend fails on a KGD initiated reset because of a user queue hang and KFD has to reset through the KGD call again.
> In this case, KFD suspend from the KGD initiated reset is in limbo and this initial suspend call is holding the lock for all KFD processes.
> The KGD is still forced to pass some sort of SDMA reset trigger hint to the KFD when it calls suspend (or pre-reset) for this corner case.
> Otherwise, the KFD will deadlock on the on its own recall of the reset function when it hits the KFD processes lock again during kgd2kfd_suspend.
> So we're stuck either way with the KGD still having to pass something to the KFD (new reset context, bool, flag hint etc ...) if we want to avoid this deadlock.
> 

The reason why I asked about making use of pre-reset KFD callback is -

Ideally, this is a reset of one instance of SDMA instance (even though
it's termed as queue reset). What amdgpu_amdkfd_suspend() is doing seem
to affect all processes running on all instances. Basically on a system
with 8 or 16 SDMA instances, this is not really making sense if it's
going to affect all other processes.

Is that really required? Or, is it like KFD can identify the processes
using the user queues of that particular instance (pre-reset passes
instance) and only suspend them?

Thanks,
Lijo

>> I guess we also stop the kernel queues explicitly in the same function
>> so it makes sense to do the same for KFD.
> 
> Yep.  We definitely want to minimize reset damage from either caller (KFD or KGD).
> I kind of look at it like the rest of the amdgpu_device_reset/suspend/resume calls that need to consider the KFD as well.
> I think I'm fine with just passing a bool suspend_user_queues here to do the conditional KFD suspend/resume instead of coming up with new reset source context(s).
> That way we don't have to force callers to use extra long strings in their calls that have no use anywhere else.
> They can just pass true/false according to their needs.
> 
> With that fixed, this patch is:
> Acked-by: Jonathan Kim <jonathan.kim@amd.com>
> 
> Jon
> 
>>
>> Alex
>>
>>> Jon
>>>
>>>>
>>>> Alex
>>>>
>>>>
>>>>>
>>>>> Jon
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> +
>>>>>>> +   /* Stop the scheduler's work queue for the GFX and page rings if
>>>>>>> + they are
>>>>>> running.
>>>>>>> +   * This ensures that no new tasks are submitted to the queues while
>>>>>>> +   * the reset is in progress.
>>>>>>> +   */
>>>>>>> +   if (!amdgpu_ring_sched_ready(gfx_ring)) {
>>>>>>> +           drm_sched_wqueue_stop(&gfx_ring->sched);
>>>>>>> +           gfx_sched_stopped = true;;
>>>>>>> +   }
>>>>>>> +
>>>>>>> +   if (adev->sdma.has_page_queue
>>>>>> && !amdgpu_ring_sched_ready(page_ring)) {
>>>>>>> +           drm_sched_wqueue_stop(&page_ring->sched);
>>>>>>> +           page_sched_stopped = true;
>>>>>>> +   }
>>>>>>>
>>>>>>>     /* Invoke all registered pre_reset callbacks */
>>>>>>>     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>>>>>>>             if (funcs->pre_reset) {
>>>>>>> -                   ret = funcs->pre_reset(adev, instance_id);
>>>>>>> +                   ret = funcs->pre_reset(adev, instance_id, src);
>>>>>>>                     if (ret) {
>>>>>>>                             dev_err(adev->dev,
>>>>>>>                             "beforeReset callback failed for instance %u: %d\n",
>>>>>>>                                     instance_id, ret);
>>>>>>> -                           return ret;
>>>>>>> +                           goto exit;
>>>>>>>                     }
>>>>>>>             }
>>>>>>>     }
>>>>>>> @@ -515,21 +546,39 @@ int amdgpu_sdma_reset_engine(struct
>>>>>>> amdgpu_device
>>>>>> *adev, uint32_t instance_id)
>>>>>>>     ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>>>>>>>     if (ret) {
>>>>>>>             dev_err(adev->dev, "Failed to reset SDMA instance %u\n",
>>>>>> instance_id);
>>>>>>> -           return ret;
>>>>>>> +           goto exit;
>>>>>>>     }
>>>>>>>
>>>>>>>     /* Invoke all registered post_reset callbacks */
>>>>>>>     list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
>>>>>>>             if (funcs->post_reset) {
>>>>>>> -                   ret = funcs->post_reset(adev, instance_id);
>>>>>>> +                   ret = funcs->post_reset(adev, instance_id, src);
>>>>>>>                     if (ret) {
>>>>>>>                             dev_err(adev->dev,
>>>>>>>                             "afterReset callback failed for instance %u: %d\n",
>>>>>>>                                     instance_id, ret);
>>>>>>> -                           return ret;
>>>>>>> +                           goto exit;
>>>>>>>                     }
>>>>>>>             }
>>>>>>>     }
>>>>>>>
>>>>>>> -   return 0;
>>>>>>> +exit:
>>>>>>> +   /* Restart the scheduler's work queue for the GFX and page rings
>>>>>>> +    * if they were stopped by this function. This allows new tasks
>>>>>>> +    * to be submitted to the queues after the reset is complete.
>>>>>>> +    */
>>>>>>> +   if (ret) {
>>>>>>> +           if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring)) {
>>>>>>> +                   drm_sched_wqueue_start(&gfx_ring->sched);
>>>>>>> +           }
>>>>>>> +           if (page_sched_stopped &&
>> amdgpu_ring_sched_ready(page_ring)) {
>>>>>>> +                   drm_sched_wqueue_start(&page_ring->sched);
>>>>>>> +           }
>>>>>>> +   }
>>>>>>> +
>>>>>>> +   /* Resume KFD if the reset source is not SDMA_HWS */
>>>>>>> +   if (src != AMDGPU_RESET_SRC_SDMA_HWS)
>>>>>>> +           amdgpu_amdkfd_resume(adev, false);
>>>>>>> +
>>>>>>> +       return ret;
>>>>>>>  }
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>> index f91d75848557..2ef2da772254 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>>>>> @@ -99,8 +99,8 @@ struct amdgpu_sdma_ras {  };
>>>>>>>
>>>>>>>  struct sdma_on_reset_funcs {
>>>>>>> -   int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
>>>>>>> -   int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id);
>>>>>>> +   int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id, int
>> src);
>>>>>>> +   int (*post_reset)(struct amdgpu_device *adev, uint32_t
>>>>>>> + instance_id, int src);
>>>>>>>     /* Linked list node to store this structure in a list; */
>>>>>>>     struct list_head list;
>>>>>>>  };
>>>>>>> @@ -166,7 +166,7 @@ struct amdgpu_buffer_funcs {  };
>>>>>>>
>>>>>>>  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device
>>>>>>> *adev,
>>>>>> struct sdma_on_reset_funcs *funcs);
>>>>>>> -int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>>>>> instance_id);
>>>>>>> +int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
>>>>>> instance_id, int src);
>>>>>>>
>>>>>>>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)-
>>>>>>> mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>>>>>>>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b)
>>>>>>> (adev)->mman.buffer_funcs- emit_fill_buffer((ib), (s), (d), (b))
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>>> index 29a123be90b7..50a086264792 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>>> @@ -30,6 +30,7 @@
>>>>>>>  #include "amdgpu_xcp.h"
>>>>>>>  #include "amdgpu_ucode.h"
>>>>>>>  #include "amdgpu_trace.h"
>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>
>>>>>>>  #include "sdma/sdma_4_4_2_offset.h"
>>>>>>>  #include "sdma/sdma_4_4_2_sh_mask.h"
>>>>>>> @@ -1480,6 +1481,7 @@ static int sdma_v4_4_2_sw_init(struct
>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>     if (r)
>>>>>>>             return r;
>>>>>>>     INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
>>>>>>> +
>>>>>>>     return r;
>>>>>>>  }
>>>>>>>
>>>>>>> @@ -1608,10 +1610,10 @@ static int sdma_v4_4_2_reset_queue(struct
>>>>>> amdgpu_ring *ring, unsigned int vmid)
>>>>>>>  {
>>>>>>>     struct amdgpu_device *adev = ring->adev;
>>>>>>>     u32 id = GET_INST(SDMA0, ring->me);
>>>>>>> -   return amdgpu_sdma_reset_engine(adev, id);
>>>>>>> +   return amdgpu_sdma_reset_engine(adev, id,
>>>>>> AMDGPU_RESET_SRC_SDMA_RING);
>>>>>>>  }
>>>>>>>
>>>>>>> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev,
>>>>>>> uint32_t
>>>>>> instance_id)
>>>>>>> +static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev,
>>>>>>> +uint32_t
>>>>>> instance_id, int src)
>>>>>>>  {
>>>>>>>     u32 inst_mask;
>>>>>>>     struct amdgpu_ring *ring =
>>>>>>> &adev->sdma.instance[instance_id].ring;
>>>>>>> @@ -1628,7 +1630,7 @@ static int sdma_v4_4_2_stop_queue(struct
>>>>>> amdgpu_device *adev, uint32_t instance_
>>>>>>>     return 0;
>>>>>>>  }
>>>>>>>
>>>>>>> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev,
>>>>>>> uint32_t
>>>>>> instance_id)
>>>>>>> +static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev,
>>>>>>> +uint32_t
>>>>>> instance_id, int src)
>>>>>>>  {
>>>>>>>     int i;
>>>>>>>     u32 inst_mask;
>>>>>
>>>>
>>>

