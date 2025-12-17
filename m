Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC13D6552C
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 10:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B90210E5C1;
	Wed, 17 Dec 2025 10:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ImjKGohA";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCF910E5C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 10:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y32dyNwwyfw1YsNQo2uFaBqIoJvyYm56Nu/0Zdwh2jDmKvBjXtHht+C+n0LaHUUWDD5+SANtA5QFl9ZCjOX7sCz6hlAS4B+NM7tpaniEQOs68zDmgfYUS72HUYr1LvU07OzGMc+Gf/SjyBjz04C/lXEXIRi3mxjCLwZed/v1doVjT3Rwz1AyEXquuFz+CbqdGgUzP9/amXKBySdkisLRj91Um/BSGwizalptkYpEAfup88yVZO0BO4qTuBuwVPuO3HZesLQ1HXkZ9dTlkumzyCjIyzpts8p6HLNP7x27hNWyTDjQIMf6u/0yLGIC+8uREK2CQO7q28dRIhOW8jp33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve5a5zmLFwSR/YUsdU+guV/sjMLK0yX6Ta16mLJqri4=;
 b=rIIU865ireKBrHqY5YvpsgJbeWH+/1lJMcoFZla7v0NqVuXW/e+lkN+IcHLt9/7sDLnxFqa8R/fIgrsSNISz9sPJUbg6/Ii2NkD6ZbeLuvE0kuBG0VbejhqVtHJp62JJU60UPRi3KYONTObMWT13/thsUlvsVYGBzIST+bIdZ4lzFvybC8U6gILSSVH8mCzsxjUJ6mj/SSgGZREJt9vgEQkisJSO0yk451jftCSYyR+TmpTA6JYd15UJe0htMeHUrUhoD7+VS7DFObPzs7l/79vt7mVJF9PnHDZh5c7SGpqZchfO1AJvn5OATd0PrO7GpwROmar3BZoSXex99kkRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve5a5zmLFwSR/YUsdU+guV/sjMLK0yX6Ta16mLJqri4=;
 b=ImjKGohAP/Op6YKhWXXJbKfX36XNZ1QnledRLYr6711bpfQIoKtU8z6aTdHSgD8qaJQeFeH5QKJr0VsORuqO86wkEx1Wv013mKGWN8Y3Bmjus3UIbsVED7pX7v9jhOru3uKx7E11eIs7RmRtI9XLW4N9fsWlEl2o0guuYnIZcSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 10:10:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 10:10:30 +0000
Message-ID: <819092ef-78d4-493f-9ced-cac7d2d6b55b@amd.com>
Date: Wed, 17 Dec 2025 11:10:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: Donet Tom <donettom@linux.ibm.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kent.Russell@amd.com,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
 <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
 <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
 <444bfeba-deae-4f7b-84d7-29048256b69d@linux.ibm.com>
 <50dee2c9-bcfc-462b-bf46-f110a082e2d3@amd.com>
 <c0e24bd4-bc4e-4a6f-9229-57cbb85d0d7e@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <c0e24bd4-bc4e-4a6f-9229-57cbb85d0d7e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: b08041c3-1296-4ac0-a4b0-08de3d54826e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0NLV0syRFZ3WlpVYSt1YnNuU0x3MmVCWml4YjBKc2ltQUpmTkhGdWJNTDZQ?=
 =?utf-8?B?Y2pDNzkxZUV5S2N0OVJZUTc1MVZtVjZKRU5SMklOOFpmRUpNaDNhRWpIaXVO?=
 =?utf-8?B?SG5tQWRjeEhiM3c1NDY2eWQxOENaMDhab0Fza1c3SmpHZUpaeitsaU5pZlVq?=
 =?utf-8?B?aHFmVU9NYmpNQlJmY0RIYi9KY0VwbGd6bEU3K1lWRHpXVGVvNjUzM0tIaTBC?=
 =?utf-8?B?WTdTOUZQcDRlODBQaEFRcjBXMFYvYmpkdjBDSUd5WmptRm4xQzdubTU0b3M2?=
 =?utf-8?B?MHNnY24wNEI0Q21sbW5xOE9VZlp4RGhnQXVpUGFyaUVoVFhTODJobUVFcXpN?=
 =?utf-8?B?YW5nRGZqT2QxTEVkM0xGb2h4cmdPYUxaL3ZOSGpJb3FOcE1tanlBTWZqRFNJ?=
 =?utf-8?B?OEVBc3ExRHJMb0ZKNkt1am5hZjNpcXdobVlQUnZOei9FR2V5OTZhdkpRRnA4?=
 =?utf-8?B?TDB2WFJpMnNYVVZiUXgxYXV3S2wzb1M2a2VGVU5SYXNJRjJxUWxBMm13NWdz?=
 =?utf-8?B?K2VSd1daS2lOS0JtUldkV3N2b09EWlZJcjY2b2RNRzhTc201N3ZJMG5jVzhy?=
 =?utf-8?B?V09tQ2RGZjZNaVp1NzBFL3ZiQytPektKUmF2MjVGRXBBOVk3bWI3VVdnQkF3?=
 =?utf-8?B?djNFVTZLY0JRc0dqYUFCM200RVpINFdKVS92dWpodjF0cktmc0puQ0V2VGx6?=
 =?utf-8?B?ZmNkd1hpT1JGTDZyVGNYSFJXbklNUEV5VU11bHlYV1VJYzQ4OFhHdnFDZHk4?=
 =?utf-8?B?OHdzTWExa1c0eW1SSzNGNEpIdGVHL2laWVJDbFlQNmhtejFFMlRRbmxWL3lu?=
 =?utf-8?B?N3ptdGJhRkNmZ3lIQUlIaVZRQWNkQ042LzA4WTJ6S3ZsL2Z6REw2cXpLdjlu?=
 =?utf-8?B?TU5yN2daUEU3TWZPd1NCdVp0VE14MnBCaHIxdHFEREx3M2s3cUcxZFFFTDdB?=
 =?utf-8?B?MEdyZTR5ODdyUVJVblF0YkpUWEtIY2hBRExYdDdiOThrZ0t5RFA3ZkJqcWJG?=
 =?utf-8?B?SGx1enBEWkRGSlRESzlxTkZrS2ROQnJ6QTdZZXFBYXExQjB5R25jNGU3Yy9O?=
 =?utf-8?B?eUZtMkNyUWlocUZKNlJsRng0Z0F2UHM4SFB6S29xaVBWUWl3Q3M2aHNzeEhR?=
 =?utf-8?B?U1dJNzRpRk9ETTVBTXhQNnNPN2JVNVNDYm84QlBUS21hcVk4enNmV0Z3eWE2?=
 =?utf-8?B?WTN0ZVdKMWMxTzJYZW9FRHkvRmkzZTRHWFpVdzQ1clRMSW5yMk1WeWRyN1BE?=
 =?utf-8?B?SVVzK1lmb1NkZXBidmNZL3paY0xYak8zakxhTUVsaHlYMXI2NGdHMENZeDlC?=
 =?utf-8?B?bTFCd3NjYkJXTWNickFnQytrS0xFaiszMDRaZ2RLUlFTcWl5aWhHVUxqUERD?=
 =?utf-8?B?RUVGZUhGNTdKUGpYdisrZ1JYL1hxVXViSDlaOUVuK1hSb3BDaTdlSFZsNnU5?=
 =?utf-8?B?Ujl3Zmg5RDFNRGxDZlhrTW5BcHp2VGpIQTVVUTAyWTZzSncyaWxKdHRGdFhR?=
 =?utf-8?B?Tm80UWl1M3dwWGxaaC9QTjhJdWJ0ZzdrUGhFbWdqLzlGVk1kVUEzUmhCWUNv?=
 =?utf-8?B?N0dkTUNoUEEyU3NJQi9xUCtpOXZUWVJpSDZ5WkcwdjR5RDdVTGRWQ2NjVGMv?=
 =?utf-8?B?NVdpb2dHUGFuL2p5UWZMRXVSMDkzVzMyQkJiK1NQa0FyM1lkNDlmMjM1QUFj?=
 =?utf-8?B?OEY3aThNcmJOM1BSMjFHMHAzMzViY0JGUFBZTmcxRk9uOFV5WTdGMVlaRlcz?=
 =?utf-8?B?T1lqYTdXRW9qNmZ2YThnQUZqSXdOeTZCRkR1Ri9Zd2VTeFdoeVNYWVlURXRC?=
 =?utf-8?B?WS9aWEtMc3JPQ3Q2djQ5NDhsRWpWSU1BYTZMbXkvOGVGSlh1QzV0MGxaT0Fz?=
 =?utf-8?B?RHRackUwdUxrRG1QMkY0UnFQNlhRQnBxMVIyUW1xUXRNOEtyYTY1SjNzUEJj?=
 =?utf-8?B?OW85ZWhjd3NEcWZXaWZKR3VTcS9wVVBUaXV3RG55N0NxekhJK3NiM1FWRk9t?=
 =?utf-8?B?ODBMbHJudTJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnEzZDUrYk45dWY0STdsVGpOWHJNaVNlRmdsUzZ1b2NQTUlFbzAzbHl3L3pO?=
 =?utf-8?B?d2pLTTJtQkNkTlZ0S1FjUWxpYUxObmF3eXo3dVF0NUN2ZTlwdnZkSWdwOVhR?=
 =?utf-8?B?N1NjRE5salloYWh6U3gvOTNjOHVlVXN5S0JlMXBsbExDcWVJT0pWZ1lxMDRh?=
 =?utf-8?B?Q0xMcE5ZVHR0TnVQVlc0cGptcWRHZlByZlN0U1BzMUp3bVo1TTk1TWt0b1FX?=
 =?utf-8?B?bDh2TDA3T3JiTDJIMnBaVnFxT1FDV3RtRVRGQ3pOQW96M25YTkpJTW1qVEZ4?=
 =?utf-8?B?MTNHWHpXeGd4NDE5VkEzcG8wUUFjMGZsUzI3L0lyYmdSZmF5YmhzQjNZOXVo?=
 =?utf-8?B?bHQ2cG1MZFhaR1E5MkMvUVZ4dXBLNHJEKzdRT3E1enJ4bFZ5Zjh6K0FlNWhu?=
 =?utf-8?B?bExDNFhjajVOS1lSY3B1eFNtSEt0d0N4VkxOUTlZUHpNSCt1YzY4Snl3eVdP?=
 =?utf-8?B?NDg1VlZzOGZmdVpsVmpNRzdoSEE0VVdoa3lRVjZkSGN3UEVjbkV4blg1RUwx?=
 =?utf-8?B?Ly93bktpUFBKQUtNaWFwQmltUUhIbFgzY1BodEZJYkZJNDgyblpyUGhHOFRN?=
 =?utf-8?B?bG1vWXBaWER3WmtWV1o3QWRDVEQxY3JpckJhc084YlFmOHArSkEzTThpT2hW?=
 =?utf-8?B?Zi90WVp6dkNzOW5uc2VTQmJlcm9WRTFlVWR2THZxY1dmMkhWQkhtYVNuY1Yr?=
 =?utf-8?B?bTJSa21IemI1YUFoVHI0Zkoza04zaFhvMVowTUhIRWVwNk94b0xxNityRitX?=
 =?utf-8?B?ZVowb2RSN08vbmFOMkFvS1F5bEFPUFpYMlF1QlpSNHhHUVUvdnYyUlgwTldp?=
 =?utf-8?B?NXh2bmQ3TGdFbUNqTDZxQmFqekRhNDVmc0RHQ1llc1FYYzc3YUtiRVRLUjYw?=
 =?utf-8?B?M1AzUGpMcjJEd3NjZ1lySFFJRldQakkrdDdEWm5tbXNUcGpvclBuQmJzRmdC?=
 =?utf-8?B?dXVWdThrazBJZGZmalIwYkdsOTRhVmpNZzhVLzFWNUlGcW4vSWtzcWxPbEFL?=
 =?utf-8?B?c0Z3ZkNpTlF3L0J6VDVVQyswNFFWaUZjYno3c3FKZVhxNWN4clFkOVJ3ZEtq?=
 =?utf-8?B?QW0rQy9TYW5jbDFZSnBCMjRwUFBkR2U3ZlhacnVHUFlzZ0JQd05hVGduTEta?=
 =?utf-8?B?bjdXaHRTckVYUUFRWU5Sc0UwWnh5VVoxSUNxb3lHN1VYUzRzMkpLaVNkVnRZ?=
 =?utf-8?B?aWVZa05KT2hqcHlrNVdxV0RDQmRUT1JRMGp2cU5pamUxYmR5VXArM2pvUWgv?=
 =?utf-8?B?aGYza3NEN0JFWVovSEdiSTJEY3h6Z3VVbVV0TnRZaHpKeW9VYjNTQTJXblV6?=
 =?utf-8?B?VDNJbklZakVNOGlZT1M3N0tzNFExbzZKRTN4eDF4aEJJNDUwNEZBVytUNVIy?=
 =?utf-8?B?WXN5RzFpTGJQSnU3ZW1VZFU3NUg3enJxN1ZwdnQyK2kycVNWUW8xSVEvQm1o?=
 =?utf-8?B?TnFZT3dLYURMNE1uKzZEWDIwMTN0dWM4L2xmV2ZoS3lEcFQvSmxzZmltNlBK?=
 =?utf-8?B?VDkzb2JIR094LytxWEc1VmEvRTVGMG1HRm9ldEYydE13R1ZjUjEwZ1psZ1V5?=
 =?utf-8?B?cUtqRjVmYkExSnF5OWtxUFZYSDdVZGZmbXptSHRIM3JmbkdEdXptN3psWC9v?=
 =?utf-8?B?VmtZYVovOWViRFpBMEhMYk91TW82ck9XcW9nQnNmeWZUUHhQcmQ1MGlYTGQr?=
 =?utf-8?B?ajB4bG84YTdQZXBsbkVQdC9oZW5uVnNkNldSTnV6cGt6MnQvZWlkUHVNamJt?=
 =?utf-8?B?Z283WmJlbFFNTGlNK1VQejRwcUp6Z2VDNVBLM2JRT1JhTWF1MjQ3YjVYUHRM?=
 =?utf-8?B?VExDQWdieHkwZ1RHaVV4bGRZSEF1c1JNOEZFZ3VqbjE2VEpFSnUrSFZSN1hF?=
 =?utf-8?B?cEx0M0l2YXRYVWpyaHFCYlRCaVAreXQ1Tkx0dnc2WFpuRnQ3Z2k1bWJvdVB2?=
 =?utf-8?B?VThWeVNoMC8rKzQ4dFpMTWVMTUk0S3ZBdXpyeGx5cEZtaStjdCtzSG5MS0I4?=
 =?utf-8?B?elJ5Qm0yTHVwR1dNNTY5anBnYmtRR3Z3T2VyNHR1Zm0vUVlnRC9ZZm5EYnpj?=
 =?utf-8?B?NmtxM2o2ODZPNzlyWnJiME4zc1V1dzg5cUFyVlcrRVBkbG0xL1I5a0phQkll?=
 =?utf-8?Q?hLSnzmTjwc7Tmwo17/QFRxKOg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08041c3-1296-4ac0-a4b0-08de3d54826e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 10:10:30.9192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXVJ2CT40j1/F4KsMy5biVxgPX7mgBYYNvaXuwwNlaGO4TNAqtio3/c/fha+pXBg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
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

On 12/17/25 10:46, Donet Tom wrote:
>>>> But don't we also have problems with the doorbell? E.g. the global aggregated one needs to be 4k as well, or is it ok to over allocate there?
>>>>
>>>> Thinking more about it there is also a major problem with page tables. Those are 4k by default on modern systems as well and while over allocating them to 64k is possible that not only wastes some VRAM but can also result in OOM situations because we can't allocate the necessary page tables to switch from 2MiB to 4k pages in some cases.
>>>
>>> Sorry, Cristian — I may be misunderstanding this point, so I would appreciate some clarification.
>>>
>>> If the CPU page size is 64K and the GPU page size is 4K, then from the GPU side the page table entries are created and mapped at 4K granularity, while on the CPU side the pages remain 64K. To map a single CPU page to the GPU, we therefore need to create multiple GPU page table entries for that CPU page.
>> The GPU page tables are 4k in size no matter what the CPU page size is and there is some special handling so that we can allocate them even under memory pressure. Background is that you sometimes need to split up higher order pages (1G, 2M) into lower order pages (2M, 4k) to be able to swap things to system memory for example and for that you need some an extra layer of page tables.
>>
>> The problem is now that those 4k pages are rounded up to your CPU page size, resulting in both wasting quite some memory as well as messing up the special handling to not run into OOM situations when swapping things to system memory....
> 
> 
> Thank you, Christian, for the clarification.
> 
> When you say swapping to system memory, does that mean SVM migration to DRAM?

Yes and no. It's mostly the normal BO based swapping of TTM. SVM is still an experimental and extremely rarely used feature.

> 
> From my understanding of the code, SVM pages are tracked in system page–size PFNs, which on our system is 64 KB. With a 64 KB base page size, buffer objects (BOs) are allocated in 64 KB–aligned chunks, both in VRAM and GTT, while the GPU page-table mappings are still created using 4 KB pages.
> 
> During SVM migration from VRAM to system memory, I observed that an entire 64 KB page is migrated. Similarly, when XNACK is enabled, if the GPU accesses a 4 KB page, my understanding is that the entire 64 KB page is migrated.
> 
> If my understanding is correct, allocating 4 KB memory on a 64 KB page–size system results in a 64 KB BO allocation, meaning that around 60 KB is effectively wasted. Are you referring to this kind of over-allocation potentially leading to OOM situations under memory pressure?

Correct, yes.

> Since I am still getting familiar with the AMDGPU codebase, could you please point me to the locations where special handling is implemented to avoid OOM conditions during swapping or migration?

See AMDGPU_VM_RESERVED_VRAM.

Regards,
Christian.

> 
> 
>>
>> What we could potentially do is to switch to 64k pages on the GPU as well (the HW is flexible enough to be re-configurable), but that is tons of changes and probably not easily testable.
>>
>> Regards,
>> Christian.
>>
>>> We found that this was not being handled correctly in the SVM path and addressed it with the change in patch 2/8.
>>>
>>> Given this, if the memory is allocated and mapped in GPU page-size (4K) granularity on the GPU side, could you please clarify how memory waste occurs in this scenario?
>>>
>>> Thank you for your time and guidance.
>>>
>>>
>>>> Christian.
>>>>
>>>>> Alex
>>>>>
>>>>>>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
>>>>>>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Please note that the changes in this series are on a best effort basis from our
>>>>>>>>> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
>>>>>>>>> HW & SW stack) to kindly help with the review and provide feedback / comments on
>>>>>>>>> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
>>>>>>>>> supported with amd gpu kernel driver.
>>>>>>>> Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.
>>>>>>> That's a bummer :(
>>>>>>> - Do we have some HW documentation around what are these limitations around non-4K pagesize? Any links to such please?
>>>>>> You already mentioned MMIO remap which obviously has that problem, but if I'm not completely mistaken the PCIe doorbell BAR and some global seq counter resources will also cause problems here.
>>>>>>
>>>>>> This can all be worked around by delegating those MMIO accesses into the kernel, but that means tons of extra IOCTL overhead.
>>>>>>
>>>>>> Especially the cache flushes which are necessary to avoid corruption are really bad for performance in such an approach.
>>>>>>
>>>>>>> - Are there any latest AMD GPU versions which maybe lifts such restrictions?
>>>>>> Not that I know off any.
>>>>>>
>>>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.
>>>>>>>>
>>>>>>> - Maybe we should also document, what will work and what won't work due to these HW limitations.
>>>>>> Well pretty much everything, I need to double check how ROCm does HDP flushing/invalidating when the MMIO remap isn't available.
>>>>>>
>>>>>> Could be that there is already a fallback path and that's the reason why this approach actually works at all.
>>>>>>
>>>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.>
>>>>>>> So these patches helped us resolve most of the issues like SDMA hangs
>>>>>>> and GPU kernel page faults which we saw with rocr and rccl tests with
>>>>>>> 64K pagesize. Meaning, we didn't see this working out of box perhaps
>>>>>>> due to 64K pagesize.
>>>>>> Yeah, but this is all for ROCm and not the graphics side.
>>>>>>
>>>>>> To be honest I'm not sure how ROCm even works when you have 64k pages at the moment. I would expect much more issue lurking in the kernel driver.
>>>>>>
>>>>>>> AFAIU, some of these patches may require re-work based on reviews, but
>>>>>>> at least with these changes, we were able to see all the tests passing.
>>>>>>>
>>>>>>>> I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.
>>>>>>>>
>>>>>>> Thanks a lot! That would be super helpful!
>>>>>>>
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>> Thanks again for the quick response on the patch series.
>>>>>> You are welcome, but since it's so near to the end of the year not all people are available any more.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> -ritesh

