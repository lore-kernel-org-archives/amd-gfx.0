Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADAFE63C8B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 10:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE7210E2DD;
	Mon, 23 Feb 2026 10:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WG4Rmp86";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD9210E2DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 10:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctUpesnC8UGuFNB5voRVtrflznkzIXD4EtaBHzK3wOOkghMyntQWI4yk89nVZe0LagZP+Xwa3u6XGQI9lfUZYBo/qWyLRp740UdpEM9D0irCuZne9cUEGp1aSeU9GFrSNZ3db9UUs2K7xRCRiTlJQiSbMLQPJJ+q1ZD0WuyoOhNsONkiKCjC3IWsf3skz/JTGnPYfa1bMoJEgOt9K6QUK2txlSIDhKQSFAfn8JE1wQKAH46RyGqofVvD5U0nnxSCED59Di5xk8n98BRF6cz1ueIVyNOHz7XDBMBGz62ei6414w+wsd60fsX/Mol2dTAqKK5XMt2L7AG2XbQJOfzUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilX14YehxWWFhWo0hrf01zrdk8P6sWC3XHTjbkT68g4=;
 b=KAith4NC+tBB5FdEHH1ro6P3qV2nwAh/TTnEijx2HgRhLFTL5kDvl4erDxaUAdmQZ0MtW2+R73not2pzOnz5FYuobw1ChP5o7sWw/tGvybjGo9D9OuDBmEyR7jZcfYhMGQPErJ/TCxnXuAs70XuEZSp1pzsGmM82k6Vl1ky9e8xoWrszqhkqYHbmw2aK0eS3KA9qjBfRAh4gr3jC+uMpIR+rCDN2d882qyZITT1fOnDMHY+hlezZVk4m7SJ+JJNnvwLVGeVaB1MQuLyh7uSbec+TX0yZs3reNaB1claVQB2YycNrCJPUayCyUu6zZf4qmLFxvOAaYiIDRsn2e8o1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilX14YehxWWFhWo0hrf01zrdk8P6sWC3XHTjbkT68g4=;
 b=WG4Rmp86mwD8hRqTBq26O3Cal4bs3ASURY4w4VR7kjVyrktY/58G28v1lxW1lw7FA6rv2ay/ZZVug2a3XiEkilLZPoBoJpQylBAZZpRKGr1NH9dzO97xNtNNMXUeGb/5jivKPSOGy5vTxjHzd3z+eMEsMYwvbzjAzES5YxuMKAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 10:36:06 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 10:36:06 +0000
Message-ID: <9ac4a721-64df-44c3-af17-77dd88988bd6@amd.com>
Date: Mon, 23 Feb 2026 16:06:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update memdup_user with
 memdup_array_user
To: Tvrtko Ursulin <tursulin@ursulin.net>, Sunil Khatri
 <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <3c7f24f3-d1f7-4724-bf2e-8540fa2e2648@ursulin.net>
 <4a824f5e-5279-4cb7-b6a9-fb4c6f87cd91@amd.com>
 <3c4c8c6c-5bcd-426a-bd39-fb24db8fc5f5@amd.com>
 <b05a405a-c9a3-4276-85df-daf223fd2a7b@ursulin.net>
 <a55ecb91-8aa2-41c5-bd76-b3ffa7d6c23c@amd.com>
 <cf512004-18ae-44e1-bc4f-63bb279a40dc@ursulin.net>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <cf512004-18ae-44e1-bc4f-63bb279a40dc@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: 00121912-0dcd-49cc-eac0-08de72c759cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHhyS1JyZXlGYjhERkhiU08xL0RxUDc4THpRekJrTlNlZ2s3cnppOWVTK2FD?=
 =?utf-8?B?WVlEeWV1Zys5bjBkSXdaVEozN0JZSXJaK1N4MjN4eEU2ajdNY1pzQURrQkVu?=
 =?utf-8?B?dGsxbHV1Vm5PQWx1eFdTUjhDckRSM0V6ZGNDUlh0c1JoZGY5eVVJR1YycGRh?=
 =?utf-8?B?Q2lwNzJ0TUlwaTlFeU9UN0dPa3ZrZVBjTDV0U1JLWmVPSXp4MU1VeUVrME81?=
 =?utf-8?B?ZFkzYTI2cTNtbEI0Vm5Wbm5FY2huYUVrUzF5MkF4UEtaWjFlalFiZjcrS0l1?=
 =?utf-8?B?aDVFUVk3OHhMeUNCa09lQ0RxVVhkZjN6WExKNHdSRmJkN25kNklJUXJFWjhQ?=
 =?utf-8?B?NGRoTldTKzlPRXBVSDJ2Ly9WNEtOUVhBalBNUFlqMUx4dHY0T0ZmNHVmYlpF?=
 =?utf-8?B?MmQ3RG16T1BhRmdQRmxta0lVVUFFZmFvekVobmcxNitRSWhlNTNaSHM3RkxE?=
 =?utf-8?B?LzZvY1ozUXArV1pkZjErSDhhMXlTWUh1T3pLWUpDY1FwV0FTQVluNWxIRFZ6?=
 =?utf-8?B?eHdhT3VHZGU0OXoyQWhzUS9qWjZNQ2UzOVlyVDBBM0NsTkZEak40TVVOMjho?=
 =?utf-8?B?L0h4enVkTUdOcGI0SDJpNW8xeklSZjVjMjgvZmxzZktFWG9pOFI2elBxaXlj?=
 =?utf-8?B?dUFOcXRDT3QrdUd6UnArbzNQQkR4UERLL0RCWmNtbmtZQnBGZ3NLOFNVOTQ1?=
 =?utf-8?B?Wk5PREo3cFlUWXB4ejdXbSs3K1dJckNCRmIyLzJ2YVdRZWJGbkliaFpTN1Ur?=
 =?utf-8?B?a0FlTTB5M0NLbFRxVVFYeGNlVkFaOVc0Rjkwb0gwOFYvT3FPZDNmOXFva080?=
 =?utf-8?B?cVpIRzNxdnlmNWVSODNjZ2E0TVRwMVFvK25URWhWRXBMclh6b2dKZ2NOVWw5?=
 =?utf-8?B?R2JaZlJQMWl1MTdIVXJkZTh2ckJqdFh2TXUydmNXMFJCcEgzaEtUSXFtZ2tT?=
 =?utf-8?B?Slk5ZFhQdTh4S0xBa0kxS0NLand6NGVzZ09UaTJaV3V0RksyYjlQT0sraHJX?=
 =?utf-8?B?QnlMV1duQzVFazJ6emdta1FYSUJyMm5xNFZNRVJPeDJmL1J4YlJTb1dUTFor?=
 =?utf-8?B?Tm92SE5WYzdIUzdmMmxWdkR2TEloM3dUMlMza254cmNTY25HVnM0VjlsTEE0?=
 =?utf-8?B?SlBkaDEvWXVEL1MyQWkvUEhCUkRHM3g2ekhpOEtHUS9Tb1d5WEFDM3VYcmU0?=
 =?utf-8?B?T0JxUlJGaUhXYTdzSUExdkRMMTNyUlp3aHhTWjVMYTJuS2lMLzFTZnh2ZWV6?=
 =?utf-8?B?UHB1c0JLNm9CTkF1bU5oTWNMdGpna21TTzQ1T0doUjVkTTVtYlFaNFJZUmtm?=
 =?utf-8?B?eGR4UENLaTV6ek5CY0lCMml6VFMvZnEya0ltdkQ3cm51WS95VEsxUU5jWkph?=
 =?utf-8?B?VmdnVUZ5amdMTXZjOXovVzlJanBEVGdMZHVOejJjNSt6ZkNXVXhMdEsyMjdk?=
 =?utf-8?B?RVRXV2pJWjdpLzFab2ZVbkVneUNDd1VnWDNNUWlqYVNoMVBDTzh2Zy81RzVn?=
 =?utf-8?B?NDFmT2xiTXc1V3g4TzFBai81Z3A4WjFQMkM5OHdqcWthQjYvbmx3clRDRXlv?=
 =?utf-8?B?b1lrQ3RSck9nRzZqRWRqSk9xbzJaR1lXcHFoT2gydmV3Nkh2UkdGZVdobWNn?=
 =?utf-8?B?alJNWTEzMW9jeUFya3RUWTlCN1NWOU1TekxCOGhhcDU5RGJZVUxJb3JxNHhh?=
 =?utf-8?B?K1BBb1NMS1JIcEdpNEx3YlBWaWNzM2pnWTFFMk02NUwrdnk4ZVNxbUtEVjBo?=
 =?utf-8?B?RkJLakdDbEpTN0dIUWRTYzcxNkpHQ2VoQncvaFJxTFQrQnNublRZUE1DdEdk?=
 =?utf-8?B?d0JpUTJ6ZEZReTZCQXV1eDd4SkNzaGJYZklDUDc1WnhzR3NXNlhIYm1hYVoy?=
 =?utf-8?B?ZnBoSWlBd1dUWHpzRnJhZGg4cFdVVDF1cE41M3daemUwWTdhWVFZSXREL2l0?=
 =?utf-8?B?d1BZN3phNjRwWXRXQkJvSnJtWk9ldUhmS3pxY04vczlvdHRrZWtHM2N4bGt4?=
 =?utf-8?B?b3gwaE85VCtDdkNNTGRObWcrZUp4dnNLVnZkZFk3dWNwWG5BN3o3SnZvWHU1?=
 =?utf-8?B?dlBPaTJGL2ROWTRoTnRHSW52TkQ4YzlUNk1KQzNZZC9BVlhjYkNIRTFpN0JN?=
 =?utf-8?Q?QGsnn9srtTC8lkfLOqdXisOjZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXk4TU81VXlRNkF1b2RZcGMwYnI4S2I0UW5EbzQzNkJPUzVJN1p6MEovQ0xh?=
 =?utf-8?B?YXZkeGRPUThVWHZaZGw4MVlhakJMVkpIdjRPYncvem9lb3VyeWY4czV0UFhl?=
 =?utf-8?B?bEthbm14OStSMGdqTzJqeDlNZW8vWDRqSW9NNXhMRGREZG5MQURGSURBUksz?=
 =?utf-8?B?RnNJWmNCd2I4WWc5dEptZHhnWG0zVjBjUUVNL3c0M1JkMHVVV25FbVZ1K2R6?=
 =?utf-8?B?TmFIRDZ1eTZLVzZ4OHdCTjRWTitWSU9veWNISmpjZTRnOWU5cVd0d2ZzR2dp?=
 =?utf-8?B?M0pMNW90ZDE0cFRVNDFjNCt1WGNVeHhoMHlOcDc1bldXNHNoUXNicmpHeFFl?=
 =?utf-8?B?d2FvdThrWENJSDg4RStQL3BDVkcrbmUybUExRDNxeTBGbEp5K01Qd1FpTDZZ?=
 =?utf-8?B?TE83NllWODNLVytyZGh3MTJ2UWZRU2RndTIwaDdHaUdReWxUSTJJdFpXTUxD?=
 =?utf-8?B?amQvSzQzdHR5VzZzM0puRUpNdmhDZjdnNExlejRpZTQ2UVdPUHVQaGtEYjRE?=
 =?utf-8?B?RDB5ZlNWVm5KSTFwUVNCSXZtMUQyOTdFWGxRdE9tc3BQRkh2bWJEenQyUEh4?=
 =?utf-8?B?ZHRmNlVoNHIrakYrYWlOdVZnMGkwZ1IrNzlwZGRYV2tscTg1NUdqN0p2N0lS?=
 =?utf-8?B?ajZjQmJ1WjZoRnVqNGRDQlphU2owSVlWSkJZbGdYWmtFVFdMcndxcm9SenNo?=
 =?utf-8?B?RWowYnd1cXhQbWJSSzdIRDljVGJCcmpmWG0vSjAzRExNcTBTTWRGK2UzSTJL?=
 =?utf-8?B?QlhrYXRrNVJpQ2lrMDZKRWtKdUNJdnR0aHEvcHVTUVJvVTlwV0UySGN4VG13?=
 =?utf-8?B?YlVDbG11TVVOeGhXNy8vWmtKUXhkSmhaS3RDZ2VBVUJkMzhwMWZqM2RYbjd4?=
 =?utf-8?B?ajY2SkVhYWY1S0lGKzREQ21CTE9LQnllWGY4cEYyeGpGeUY5TkVZaXdjSVA0?=
 =?utf-8?B?WkRFVnA3WHhCOFh4bHl3R0E1UDdhcXgrOVgra0M1aFJ5b3YxbHdSTEJHWU8w?=
 =?utf-8?B?U0ttKzhBaVBmd3BsTHE1RDRMbHM1QTczaUlkUXhtZ2kzdW40b1FYWjdTc3Br?=
 =?utf-8?B?akUyRE43ajE3OFhKR0M3M1RETUkvSlFDK0ZnM2JMZmJDUG4wcUdQbmJIcWVw?=
 =?utf-8?B?WmNmUGJ3YVBScEhjMHhNUEpoRVNpUjJuSEVqc0FUckNXM2hDMEpKY0QyT216?=
 =?utf-8?B?ODFyZ1gycjVKWE05Ni9sbDlFZjJXSUVvWWJIWTBZcmQ0ZTZtZkJzMXFncFNq?=
 =?utf-8?B?cnl0SzFUanZqdEFnZkgvL0s1OHhLQWVOcUMySGczcmVpNWhrZXZ0dFdhRTNY?=
 =?utf-8?B?NkJjcktyYnpSMkJLbVpTVDBxYU85WTE2cDg5akVRanIwMUM5aHJUQ3JobUUz?=
 =?utf-8?B?N09zQmNzdWVXYTdQQVduMSsrd1NIVFNoSUIxaTB1SVBjUnlna29RRmNMeVIx?=
 =?utf-8?B?cWVvakphYWlTeEpBVjltczJSYkdvT21NV3pzZHFuU1BKMnlaV3FHZFNyU2cz?=
 =?utf-8?B?SGpiTFBGaHpoRlZvdXY2Q3haQlZ4QjAxdTA3cEZ4cnIxNzlLeXc4WmluOXpC?=
 =?utf-8?B?QUhVcmJXaUI1b0ZkcGdWMU1sU1BIdStGbmJOb0x2a081cFJDRkxJSnZWZ1hn?=
 =?utf-8?B?d2NLeFpNR1Q4SXc3VE5hUXFJZ0l6TlZqTiticzFFUjFKa0Zxb3QvWStuMzVC?=
 =?utf-8?B?VzBEd0NTVWUrMk5ET1RtNmVROVpRNW8wd0lmemVIQS9pQ1JCalFqOHdZOXFF?=
 =?utf-8?B?bWhHTktwWlVITmNEQWJmNVB2dFB6bnhaYlRmWm5OQ3A3NUh0bTV1M0N6bWda?=
 =?utf-8?B?dElya0k4cmYzNFNNQnRldXZmdk95dDVQR1NETlhSVW1PbUozUnlFeFVJbVox?=
 =?utf-8?B?SXlmbGM4ajRBU3BEV3B6VzBPMmpueEt3MSs5a0o3VURvOFBoZHdBVHorZ1lL?=
 =?utf-8?B?R3pJaFRwUllXNmYydlhPcnF3UEpRUlZTN0NucXJvdmpFaXpSdS80c2NGK3Nv?=
 =?utf-8?B?bjdBc1RyRjZwSkFpQUxzTllSZ0I0dnBZVzEwQ3Z6R090ck0xdTgvUDdmbDQ4?=
 =?utf-8?B?b25GQWE1WnovS05GQ1hQOU1WVHNDVUZVVVFsTGpLNGdNbTQvN2ptYmxjMXVG?=
 =?utf-8?B?azhFeXl6QkEwSVJsSnZjc1hBNWVYUWlxTXhFelRHS0NRR0E2YS9kMnFhRFA1?=
 =?utf-8?B?ZzdZUXVKZnUwZy93OU5nK1M2bzErUlBOS01pWmRjVVFDVDM3cmppZzdQaFNa?=
 =?utf-8?B?QVUzOXNjaE1BVFA4RlZDaW5UeDg0dVAwT295V2dlTTBPTzlOWmtPb2xSVk8y?=
 =?utf-8?B?YW93d0h4dnpweGxMSUtnSXUwRXYxK0k2KzdjMWNkUWtQQ1VyVVVOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00121912-0dcd-49cc-eac0-08de72c759cd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 10:36:06.7140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIKXQ7mxu8yFZqjNX3zHvpz2uyCu9Q5GEN8x1U8pNuWpoidOHjb78kYp/+s6AsREpYbza2tv1PFxZuAtVauQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608
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


On 23-02-2026 03:26 pm, Tvrtko Ursulin wrote:
>
> On 23/02/2026 08:21, Khatri, Sunil wrote:
>>
>> On 23-02-2026 01:41 pm, Tvrtko Ursulin wrote:
>>>
>>>
>>> On 23/02/2026 04:31, Khatri, Sunil wrote:
>>>> Applied the changes @Tvrtko Ursulin <tursulin@ursulin.net>
>>>
>>> Thank you! I am glad they still applied!
>>>
>>> Also, you were suggesting in your last week's reply to "Please make 
>>> sure the changes are made for all memdup_user". There are also 
>>> patches in that series which convert to drm_gem_objects_lookup() 
>>> which remove some more, but, for those I think I need to check if 
>>> they need tweaking after
>>> dbce431756f8 ("drm/gem: Make drm_gem_objects_lookup() self-cleaning 
>>> on failure v6"). Maybe it just works though. I will wait until the 
>>> ones you merge appear in some branch and check.
>>
>> I am in process to merge only two changes patch no 6 and 7 in the 
>> series. There were conflicts but i fixed those but still there are 
>> some more memdup_user which i will fix with a patch which are left 
>> after these 2 patches gets merged.
>
> The before mentioned object lookup and syncpoint lookup. For the 
> latter I also had cleanup back in December but did not send it:
>
> commit ddb4985391907155a9cf5ef6f5262c1cc8f334c6
> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Date:   Thu Dec 4 13:56:56 2025 +0000
>
>     use syncobj lookup helper in amdgpu_userq_signal_ioctl
>
>     Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> commit b21686063a5858833a09bb8f84cfbae2376f0c18
> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Date:   Thu Dec 4 13:36:15 2025 +0000
>
>     export sync obj lookup helper
>
>     Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Those two I was planning to send together with some more syncobj patches:
>
> 27cf1f1dabfc drm/syncobj: Add a fast path to drm_syncobj_array_find
> e7efbf50342b drm/syncobj: Add a fast path to 
> drm_syncobj_array_wait_timeout
> 363279cd8eb4 drm/syncobj: Use vmemdup_array_user in 
> drm_syncobj_array_find
>
> Which are interesting for graphics since four stack fast path slots 
> avoid 99% of temporary allocations. Not sure for user queues how many 
> sync points are typical.
>
>> Also if you want to take that up its ok with me. Let me know.
>
> ¯\_(ツ)_/¯
>
> Not sure if you want to re-do it because what I sent has a flaw 
> somewhere or something else?
i do not want to redo it for sure :) , could you send the patches for 
review if you havent yet and add me in CC. Also i am here focusing on 
fixing the the left over place for the same function.

Example below, these changes are still left even after your two changes 
that i pushed. So i am assuming the patches you mentioned have these 
changes accomodated this way or some other. Please send them for review.


+       bo_handles_read = 
memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
+                                           num_read_bo_handles, 
sizeof(u32));
         if (IS_ERR(bo_handles_read)) {
                 r = PTR_ERR(bo_handles_read);
                 goto free_syncobj;
@@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
*dev, void *data,
         }

         num_write_bo_handles = args->num_bo_write_handles;
-       bo_handles_write = 
memdup_user(u64_to_user_ptr(args->bo_write_handles),
-                                      sizeof(u32) * num_write_bo_handles);
+       bo_handles_write = 
memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
+                                            num_write_bo_handles, 
sizeof(u32));
         if (IS_ERR(bo_handles_write)) {
                 r = PTR_ERR(bo_handles_write);
                 goto put_gobj_read;
@@ -666,14 +666,15 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
*dev, void *data,
                 return -ENOTSUPP;

         num_read_bo_handles = wait_info->num_bo_read_handles;
-       bo_handles_read = 
memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
-                                     size_mul(sizeof(u32), 
num_read_bo_handles));
+       bo_handles_read = 
memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
+                                           num_read_bo_handles, 
sizeof(u32));
+
         if (IS_ERR(bo_handles_read))
                 return PTR_ERR(bo_handles_read);

         num_write_bo_handles = wait_info->num_bo_write_handles;
-       bo_handles_write = 
memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
-                                      size_mul(sizeof(u32), 
num_write_bo_handles));
+       bo_handles_write = 
memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
+                                            num_write_bo_handles, 
sizeof(u32));


Regards
Sunil khatri

>
> Regards,
>
> Tvrtko
>
>>>> On 20-02-2026 06:49 pm, Khatri, Sunil wrote:
>>>>>
>>>>> On 20-02-2026 04:54 pm, Tvrtko Ursulin wrote:
>>>>>>
>>>>>> On 20/02/2026 08:28, Sunil Khatri wrote:
>>>>>>> memdup_user could return invalid memory allocation if
>>>>>>> there is an integer overflow. Using memdup_array_user
>>>>>>> make sure we validate the size requirements upfront
>>>>>>> and return with an error.
>>>>>>
>>>>>> FYI:
>>>>>>
>>>>>> https://lore.kernel.org/amd-gfx/20251205134035.91551-1- 
>>>>>> tvrtko.ursulin@igalia.com/
>>>>> Are you awaiting for anything to merge the changes Tvrtko or they 
>>>>> are merged in drm upstream already? Since issue is reported now so 
>>>>> we need to fix this.
>>>>>
>>>>>>
>>>>>> And later:
>>>>>>
>>>>>> https://lore.kernel.org/amd-gfx/20260202125149.2067-7- 
>>>>>> christian.koenig@amd.com/.
>>>>> Yeah i am aware of these Christian changes and we decided we will 
>>>>> fix the issues first and reorganize the code later as needed along 
>>>>> with Christian changes. So we are going to push the changes
>>>>>
>>>>> on the existing code base first.
>>>>>
>>>>> regards
>>>>> Sunil khatri
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Tvrtko
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>>> ---
>>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++ 
>>>>>>> +----------
>>>>>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>>> index 212056d4ddf0..a6eb703b62c4 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>>>> @@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>>>> drm_device *dev, void *data,
>>>>>>>           return -ENOTSUPP;
>>>>>>>         num_syncobj_handles = args->num_syncobj_handles;
>>>>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(args- 
>>>>>>> >syncobj_handles),
>>>>>>> -                      size_mul(sizeof(u32), num_syncobj_handles));
>>>>>>> +    syncobj_handles = memdup_array_user(u64_to_user_ptr(args- 
>>>>>>> >syncobj_handles),
>>>>>>> +                        num_syncobj_handles, sizeof(u32));
>>>>>>>       if (IS_ERR(syncobj_handles))
>>>>>>>           return PTR_ERR(syncobj_handles);
>>>>>>>   @@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>>>> drm_device *dev, void *data,
>>>>>>>       }
>>>>>>>         num_read_bo_handles = args->num_bo_read_handles;
>>>>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(args- 
>>>>>>> >bo_read_handles),
>>>>>>> -                      sizeof(u32) * num_read_bo_handles);
>>>>>>> +    bo_handles_read = memdup_array_user(u64_to_user_ptr(args- 
>>>>>>> >bo_read_handles),
>>>>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>>>>       if (IS_ERR(bo_handles_read)) {
>>>>>>>           r = PTR_ERR(bo_handles_read);
>>>>>>>           goto free_syncobj;
>>>>>>> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct 
>>>>>>> drm_device *dev, void *data,
>>>>>>>       }
>>>>>>>         num_write_bo_handles = args->num_bo_write_handles;
>>>>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(args- 
>>>>>>> >bo_write_handles),
>>>>>>> -                       sizeof(u32) * num_write_bo_handles);
>>>>>>> +    bo_handles_write = memdup_array_user(u64_to_user_ptr(args- 
>>>>>>> >bo_write_handles),
>>>>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>>>>       if (IS_ERR(bo_handles_write)) {
>>>>>>>           r = PTR_ERR(bo_handles_write);
>>>>>>>           goto put_gobj_read;
>>>>>>> @@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct 
>>>>>>> drm_device *dev, void *data,
>>>>>>>           return -ENOTSUPP;
>>>>>>>         num_read_bo_handles = wait_info->num_bo_read_handles;
>>>>>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>> >bo_read_handles),
>>>>>>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>>>>>>> +    bo_handles_read = 
>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- >bo_read_handles),
>>>>>>> +                        num_read_bo_handles, sizeof(u32));
>>>>>>>       if (IS_ERR(bo_handles_read))
>>>>>>>           return PTR_ERR(bo_handles_read);
>>>>>>>         num_write_bo_handles = wait_info->num_bo_write_handles;
>>>>>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>> >bo_write_handles),
>>>>>>> -                       size_mul(sizeof(u32), 
>>>>>>> num_write_bo_handles));
>>>>>>> +    bo_handles_write = 
>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- >bo_write_handles),
>>>>>>> +                         num_write_bo_handles, sizeof(u32));
>>>>>>>       if (IS_ERR(bo_handles_write)) {
>>>>>>>           r = PTR_ERR(bo_handles_write);
>>>>>>>           goto free_bo_handles_read;
>>>>>>>       }
>>>>>>>         num_syncobj = wait_info->num_syncobj_handles;
>>>>>>> -    syncobj_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>> >syncobj_handles),
>>>>>>> -                      size_mul(sizeof(u32), num_syncobj));
>>>>>>> +    syncobj_handles = 
>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- >syncobj_handles),
>>>>>>> +                        num_syncobj, sizeof(u32));
>>>>>>>       if (IS_ERR(syncobj_handles)) {
>>>>>>>           r = PTR_ERR(syncobj_handles);
>>>>>>>           goto free_bo_handles_write;
>>>>>>>       }
>>>>>>>         num_points = wait_info->num_syncobj_timeline_handles;
>>>>>>> -    timeline_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>> >syncobj_timeline_handles),
>>>>>>> -                       sizeof(u32) * num_points);
>>>>>>> +    timeline_handles = 
>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- 
>>>>>>> >syncobj_timeline_handles),
>>>>>>> +                         num_points, sizeof(u32));
>>>>>>>       if (IS_ERR(timeline_handles)) {
>>>>>>>           r = PTR_ERR(timeline_handles);
>>>>>>>           goto free_syncobj_handles;
>>>>>>>       }
>>>>>>>   -    timeline_points = memdup_user(u64_to_user_ptr(wait_info- 
>>>>>>> >syncobj_timeline_points),
>>>>>>> -                      sizeof(u32) * num_points);
>>>>>>> +    timeline_points = 
>>>>>>> memdup_array_user(u64_to_user_ptr(wait_info- 
>>>>>>> >syncobj_timeline_points),
>>>>>>> +                        num_points, sizeof(u32));
>>>>>>>       if (IS_ERR(timeline_points)) {
>>>>>>>           r = PTR_ERR(timeline_points);
>>>>>>>           goto free_timeline_handles;
>>>>>>
>>>
>
