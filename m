Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1834ED29C2A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 13:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A5310E053;
	Mon, 19 Jan 2026 13:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TFsDVW3M";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D120410E053
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 13:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlXvvkFRVy1wWIhLgX9wPjgLvjjiJCpQ9rOh5YhDrOiGYePc+D/3dF7DOha7hf9KZi/DS2tMN4qAEvG8oEYWyi+Z3CR25pBNisfmhaYLELtY//bmnzUNTr6GOAizf1A1c74yHp84GivsBzSheJoXMDpn1XXwlVxJ4G3D3jRbtjr0MarNuwpIbKZ0VA3y5Jyh1jc3sfcCt8m17sZS3ceyccVBbsCWFn71YwlciH35c15mu08exLdkRH+ReHDpmMC3jmrxWQ+dCeYT+9oy11BpcJZx5XqmRlkUxZ5WmEypxg5CMOqjc2rxKYcWWQkwJPgyM8eaK1ZsBPyBdPRhnXTQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bCckfBkgnwar2sWybP5+abgiAjib+WN7M6ByoCKzg4=;
 b=TYTLWJpLFQ+WGUNg9GM9Dxc12uQs/fn/tkYOAsuRsw6WmNBSSM5NB7lqIjqlZPoCNmljwpHEF5HVpbpNzZOM5zvBI584Rojb/mFGdNdAYxztMqPmVqELqQzc2zsASRSEEYmmKyeLGFLxdb4i0RoHAQVdzpEW8ZQJSRslLzfIV34v4VI8ygNnFRVmBz92L/cAwTtN/9m6gNtHJvDqRQg2YWK68Rh/zmPqi28b/oMNwbvbbTvBKIbI8C0pDGc+lNWY/v7rDh/NZWVnNyarck7SYAyt8bcl2RecNf3PNJlR2yWd2csv1uhqOptIGPAwxK4vc4cYj8Trzgn4FCqsWi+x8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bCckfBkgnwar2sWybP5+abgiAjib+WN7M6ByoCKzg4=;
 b=TFsDVW3MQfNgBlu6sMx3hLPlTmMW3Ho9iHh0lXssHY2us44mwGKlaLbQAeRKcj4DUIVKG/AvlqHonmbOkKioYBlN0+I/nA1Fx25H50mNBcEwdehadm5o3LQPtRhdVBvOlXUtdxc1YqLaoayiihICziuN3B+x7oKRjyiQ39y4uuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Mon, 19 Jan
 2026 13:20:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 13:20:03 +0000
Message-ID: <ca96231d-3152-49e4-9fac-750d6ef3c868@amd.com>
Date: Mon, 19 Jan 2026 14:19:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] drm/amdgpu: rework ring reset backup and reemit
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260116162027.21550-1-alexander.deucher@amd.com>
 <20260116162027.21550-11-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260116162027.21550-11-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 337d9c91-8fb5-4508-465d-08de575d74a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFZKclpJVE4wUGl0QjBUUVlLQmdXRkJYUHU2TFM4WE9mWGNkQ3YrK1NMd0tI?=
 =?utf-8?B?QSt4Qm5UaExjL0NFWWhZUUtBQm4zZGZOK2lUMGkxcWUwcHR5ZTQ2bnVDdWxX?=
 =?utf-8?B?ZVozYWRhUVhoRFJWS0dCYTE2VmgxQTh6cm84TXlibURZQysvWmF3bkNzVWxK?=
 =?utf-8?B?U01QT3IvMDRQcnRSMU9VNjVRNFRDUzk0UTUvSERSc3NWakc1WGhtVERsTXFL?=
 =?utf-8?B?MG9HbmRZM2llNENpUyswOXRZRm9xR0I4TTc1REdqbmk2UU1hQlM0RWxrRlVj?=
 =?utf-8?B?RlR4dmwvMDNyVUgrV1V1Qjk1aENNV0I0aG1aUGQvTmhPYlRGdThhbnNTb2ty?=
 =?utf-8?B?alF0NUUvQ3hjRENpeUYwaTRQeklSeGxIMmkrTGpiWWhHVTJnWW1sN0Q0Rzcv?=
 =?utf-8?B?eDUvRzR1aFE5azI3SDQ4dDBTQmttN01DUEZldExjNlBQOFBhYTlxR2JHNmky?=
 =?utf-8?B?WlR2eHNUTFltYWdiUmNNMFVVbGJPWFovU0NodmxURURtbXUvRzJNZmNGOE9k?=
 =?utf-8?B?NXAwQUc2VW02RERUYXJXN2l6MzBCVk5wWW10bVc5SkxjN2kySkVrWFBhbTc2?=
 =?utf-8?B?R1JXUVh3elY1RC93WHZHaUM1RTVZVXN5WThmRDhVYVhJa1dMR3VTZkF0YUpN?=
 =?utf-8?B?Smg4S3Rpc3VLci8rYnNoRmhDakZOOHlzU1lsUzBIUGJZSWY3SHJSMjV3OFFU?=
 =?utf-8?B?Tkp1cllPamNCMWhZYWdLY3ovSFBmbWs5SHFSQ244UU5lRDR2U3I1aitpbTZz?=
 =?utf-8?B?RDdCdWVROXdibjZpNEUzeGhjWVkrL2h5NzVjdWNXQ0hRM3VVNHdpblQ4VTgy?=
 =?utf-8?B?YVlybFpVQlZWcDZLcmwxSEZlNmY3ZUxUVVNCZ3hYUmlXSm9XN01RcnJORllX?=
 =?utf-8?B?aHVsVmFnWjZJMEg4Y3g3bDY4akpCSDlyT3RWeitkaFpPV1NrYnFaajhpNDlt?=
 =?utf-8?B?VnBCYjBDVXpnV0VDNEo0VVZUTVZZY2NBSDZyTFJMSkxYSlVlRThTd1BzZVkz?=
 =?utf-8?B?OWJZeW9GdFl1QVBYbXpkTnV6aVQ4ZkFleTlEOFE2Z3M2VVBoSnYwVlFpZGV0?=
 =?utf-8?B?WDZNcnZDN3htNVJMTlIrR1lYOHlqOVFSb2tlMUJ1bEhNN1FsY3poQkszbG92?=
 =?utf-8?B?OGlnRERlR0NlY29LeGlwU3Q5MldmKzhRKytVd25tc2ZFV0tpdlRGa0xreCtk?=
 =?utf-8?B?dDl6amJPaVU3YTRvUEtNQ2VzT1duMnQrYmtGTWxhQWZWcW9acEdtSjFFTEht?=
 =?utf-8?B?UnBMemdVVDY2emRVbWcvSUFmTW1ReW4wNHJwaTkzN2tsSHNzTkN1RHhPcElE?=
 =?utf-8?B?eFUzeitxcWhHUFJaeUJuWG9jMDZzYlp0b2FuTGxxV2RSMjlaVTNmejl4TEU4?=
 =?utf-8?B?QytPYkVQcUZCWXVpRXJXR0Iyekp1TjhmNW1JWWYwc0lqaVNUQVBJZWg0K2xH?=
 =?utf-8?B?NVBReFNTTmltcmc5Mm02THYzc2tPYXpyNWxMVWdBTUZvN3Q0ZTljZzZOaTJL?=
 =?utf-8?B?UnlrRXpFck94cFBwQzFuc0dySVNCTHNLODRVUE50WjZKdDNaMDFNTkpqNDVD?=
 =?utf-8?B?YVVvQkwyV1N5OHZUN3pwYWZ0MHJMeGdFeXBlUWF3NFVMVVczUVVXVkVRSUJ6?=
 =?utf-8?B?YWQrVU5lL2hZeEp1U21QbStHNkNwRmVvKzArMzJxT0tCb0ZveFBMeGx4c2Qx?=
 =?utf-8?B?MEh2RGpQV2N2b2ZEWGM2TjhTNnpmSFRBcmw0aG1YaHhidHM4NjNwQWNTd0tR?=
 =?utf-8?B?c1VxWEthOUpxTld1SDJES00vaWpMb1R1UkVGSzdWQlhIK3VhSlhLMDFEeHBs?=
 =?utf-8?B?VFI2NW9WZDRpYWdid3NpTHdqVEhzeVRNSlBhOE9pVlEvbUNVdmwvMm45TnBz?=
 =?utf-8?B?cjdCSXBWeVFFTEp2aTBOei93cHEveDhBdENRV1dDOXdHcVpYVnBWZ0MyUXRn?=
 =?utf-8?B?WDNtREswS0VkdGpJK0k1U1o2MWpkY2kzOE1NekorK3BuYzZQVGJPMFlXeVo5?=
 =?utf-8?B?R0htZkN4bi81aHhieTVQZjhqRVlna2FCMUxPMnNjaktGSUJrbzdiS092NS90?=
 =?utf-8?B?clpNRVNGTzFMaUcxN3oyVzZmUXlEMmJ1OHhGSVkrQ1lDb0xxMXAvRTRmTU4r?=
 =?utf-8?Q?/ysY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdaNTg3MDRvaUY3RCttc256bTY3cmlXNW82VTZycnFINVdvclV2dVhOdmY2?=
 =?utf-8?B?cGhhYk9IUmVXWkdSelJ1bVNhalFkNlprSEVocVI0YmxmNXU0ZFV2SFlZbFBn?=
 =?utf-8?B?Q2grRmJPR3BpRmdHdGpvS2h1VCtVYmhlVi9hSE5CcnNvS1JUMUhBaXBIdTQv?=
 =?utf-8?B?OEtwVGRFOS80eHcvYk1HMnRTbzFZaFhOL0ZaYnp4Wnl6RGEybWh1RkRhRDk2?=
 =?utf-8?B?OHBlSXBOdndiTE5IK2wrUmp6UVdNWVJEdk83R3NQYURzcXROOFJMWWtaY054?=
 =?utf-8?B?Y1VPQzg2a0psZ2tpQlVtY3FkNWpZZUcvUytuMFUrUmNPdjBGK0RESWxXSHQ4?=
 =?utf-8?B?Ums0ZUNlN3E3aC96aDVpY2lZSGZuTTFXNDRBMHpLNXQ5RGthd2RvY2RZcWNT?=
 =?utf-8?B?VkdVSnZmUFZGallwSDdDWHZ4eWhLRlJVOXduUzAxUDdzSGthUkRLeitmUGVG?=
 =?utf-8?B?R3RPc2pQbWFOUmhBTVM3YUNmVTFQeEFQNkRndXBsK0RUNmFBQjdkRFp3MlJ5?=
 =?utf-8?B?T3k4cUd6TDFCUDlHM2pEMGV3TjFzWUh6dzk1cmRtMmUvcHRKanpueTh0QnNv?=
 =?utf-8?B?UGhDRVRpU2dKbExWWXhTN3hlZXBMc29qZktWOHo4STQrRWF3dDlxRE1LdkFE?=
 =?utf-8?B?NWdEY3hYWW5XelRQbGVMbUUxdmdaaDdZSmt1NmkvYXF5T296NWx2T1NXcnk3?=
 =?utf-8?B?ZDJFUlk0V1dwR0wyVHV3bTRFeUNHN1hZMWpxWW1ONXFNTFZkSVUvRnoyWlQw?=
 =?utf-8?B?S1MwclN2a3JLSHllYkZwNjFYWVNVb0hucDlQamZ5Tis4c1Bram5iWHpqdnFx?=
 =?utf-8?B?ZDVLN2tvVU42cjBjTi9lSmQxb09sV21FMG01WVgzSHkzd2tBdUxvNWVOd1Bu?=
 =?utf-8?B?ZU1pR2hZd3RBSW5WN2hmWjFIZTkyeTNPWUQwUkNNUDQvR2ozNTA5a09oMDh4?=
 =?utf-8?B?QkcxUVlFTHBCaDErUVVZNzhRa1dETkRJVzBpS3AyK3VoYU5TeWloS2o3RXVW?=
 =?utf-8?B?MWlwVVFyL0NLK1ZGcmp4c2VYTHh2SGFrNlhadTUrUlhlVi9rcG10TkkvWUdj?=
 =?utf-8?B?N0VGY2FQcWhLZDh2Mm1oczIyMFpFR0dEdlptWWliYnluMDRzSHY1am9EcWVo?=
 =?utf-8?B?OVNKTTNNLzBtSHRoNGZnVkhrVEEwZ0loMWcyRkFuWWllclR5dTRtZmhqd09q?=
 =?utf-8?B?VGg4eU0rQlRkUy9QRDZ3YXN5bkpPbzdBRC9JM29uN3RBNTFrMURiOWRKZG9Y?=
 =?utf-8?B?eXFHUllnN2o1b0NWSDVrRUpva0JyMytva0VuSHA3L3lJQVJ4NVQ4M05hNEVj?=
 =?utf-8?B?aDBlU3ZIN2xvVUVWUFdiMWxKMDRxdXhqczM2bW0zM2tUMlJjVGNDbWFpRi8x?=
 =?utf-8?B?ZHRFdnlTQkZlend5NzJVWEpRbHl1Q2dmMFdxbTlXc3A3R3g2N2FVeVhLMHBO?=
 =?utf-8?B?a3dXdlk5WjhKRFpxTlhHeHVtOHI3cG1GazhFNWZtakpSbDhJR0FmM0hKL1Ro?=
 =?utf-8?B?V0V1d2wrZ3NQNlhJUEJXcTBoNmx5NGN2d0FCbERpdmJHMWIzV1dGT3VSS0xi?=
 =?utf-8?B?VHdTWTE4Uy90OEhCYXFkRjR5NzBXZWxid3VmUmxSbFRNU2EvT0pweEIyNVg2?=
 =?utf-8?B?NVhuMVJXWDhwMnhnOGFVLzBDRGhOTFp4VWluOWdtRzJ4Z095MDgvYVhpNkt2?=
 =?utf-8?B?UFZBNVh2UisvVkR3OVlqRHpQdVJvNk8zNGNLdlZPNjh3L05ZcWVRSUJMaloz?=
 =?utf-8?B?UU81cEpNNVZEUkpPVW9xRXJBR3B1Yi9jaVQ1VDdqbVJNYmdDb1NKQkp5bU5s?=
 =?utf-8?B?WUZOblZhK1JtcE1zOG5NREhDTXY0emhvOW1Xc3JmTFNidmlNOU1xRFpMekph?=
 =?utf-8?B?MDkzbVhmQkVvZExsc0NIVVNPUWswL3liTEt3TDFGdmU0eDBJTlczdDh4T1B3?=
 =?utf-8?B?T0NzSlJZZlpkTEE5TVFXMUFFVmIvZDlhY0dOTmVMSy9YWVZkWlc5ZGt1b3JZ?=
 =?utf-8?B?RWxPRUIwT2o5R0FGSzJZb0F5b3I1UXh2b09aWUlyUk5rUU9hZ2JLSytzZXJu?=
 =?utf-8?B?NVFtQ0ZETFMxLzRtUUdrWjhubnh2K0l6ZnFKMjgvVmNFdFkxRGMyWnRuZDRI?=
 =?utf-8?B?TkVCb0haVVJDSkkzSW1nd3NTY3Z5K2VyRmFiNEpEV2JRRHl1bVcxUFhPY3FH?=
 =?utf-8?B?RmVSY1Q4Z2V6OWVLcG41bE5wQnk3cEVIQllTT3VvMU1RNnljRmpwQitMVmVN?=
 =?utf-8?B?VUhMbms3Q1p6d1FSOVk5YjV0TzNObHpFR0YvVHdvbUNPZzd6a1RRcllFMy9L?=
 =?utf-8?Q?oTFCLy4Slb7ELI4oIw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337d9c91-8fb5-4508-465d-08de575d74a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 13:20:03.5631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /k1NdfTJZLdS8bjFFDiB32/SAMUzt5opnZibUSxv5QmHLjg+WkcJn1Jo5dEpsDPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
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

On 1/16/26 17:20, Alex Deucher wrote:
> Store the start and end wptrs in the IB fence. On queue
> reset, only save the ring contents of the non-guilty contexts.

> Since the VM fence is a sub-fence of the the IB fence, the IB
> fence stores the start and end wptrs for both fences as the IB
> state encapsulates the VM fence state.

Most looks like a step in the right direction, but that is not such a good idea.

Even for a gulty fence we still want to re-submit the VM stuff since submissions from other context might depend on getting this right.

Regards,
Christian.

> 
> For reemit, only reemit the state for non-guilty contexts; for
> guilty contexts, just emit the fences.  Split the reemit per
> fence when when we reemit, update the start and end wptrs
> with the new values from reemit.  This allows us to
> reemit jobs repeatedly as the wptrs get properly updated
> each time.  Submitting the fence directly also simplifies
> the logic as we no longer need to store additional wptrs for
> each fence within the IB ring sequence.  If the context is
> guilty, we emit the fence(s) and if not, we reemit the
> whole IB ring sequence for that IB.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 98 +++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  9 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 37 +--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 20 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  1 +
>  5 files changed, 54 insertions(+), 111 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index d48f61076c06a..541cdbe1e28bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -89,16 +89,6 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>  	return seq;
>  }
>  
> -static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
> -{
> -	af->fence_wptr_start = af->ring->wptr;
> -}
> -
> -static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
> -{
> -	af->fence_wptr_end = af->ring->wptr;
> -}
> -
>  /**
>   * amdgpu_fence_emit - emit a fence on the requested ring
>   *
> @@ -126,11 +116,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>  		       &ring->fence_drv.lock,
>  		       adev->fence_context + ring->idx, seq);
>  
> -	amdgpu_fence_save_fence_wptr_start(af);
> +	af->flags = flags | AMDGPU_FENCE_FLAG_INT;
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> -			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> -	amdgpu_fence_save_fence_wptr_end(af);
> -	amdgpu_fence_save_wptr(af);
> +			       seq, af->flags);
> +
>  	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>  	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>  	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -241,7 +230,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>  
>  	do {
>  		struct dma_fence *fence, **ptr;
> -		struct amdgpu_fence *am_fence;
>  
>  		++last_seq;
>  		last_seq &= drv->num_fences_mask;
> @@ -254,12 +242,6 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
>  		if (!fence)
>  			continue;
>  
> -		/* Save the wptr in the fence driver so we know what the last processed
> -		 * wptr was.  This is required for re-emitting the ring state for
> -		 * queues that are reset but are not guilty and thus have no guilty fence.
> -		 */
> -		am_fence = container_of(fence, struct amdgpu_fence, base);
> -		drv->signalled_wptr = am_fence->wptr;
>  		dma_fence_signal(fence);
>  		dma_fence_put(fence);
>  		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> @@ -727,25 +709,27 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
>   */
>  
>  /**
> - * amdgpu_fence_driver_update_timedout_fence_state - Update fence state and set errors
> + * amdgpu_ring_set_fence_errors_and_reemit - Set dma_fence errors and reemit
>   *
> - * @af: fence of the ring to update
> + * @guilty_fence: fence of the ring to update
>   *
>   */
> -void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
> +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
> +					     struct amdgpu_fence *guilty_fence)
>  {
>  	struct dma_fence *unprocessed;
>  	struct dma_fence __rcu **ptr;
>  	struct amdgpu_fence *fence;
> -	struct amdgpu_ring *ring = af->ring;
>  	unsigned long flags;
>  	u32 seq, last_seq;
> -	bool reemitted = false;
> +	unsigned int i;
>  
>  	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
>  	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
>  
>  	/* mark all fences from the guilty context with an error */
> +	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy +
> +			  20 * ring->guilty_fence_count);
>  	spin_lock_irqsave(&ring->fence_drv.lock, flags);
>  	do {
>  		last_seq++;
> @@ -758,39 +742,41 @@ void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
>  		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
>  			fence = container_of(unprocessed, struct amdgpu_fence, base);
>  
> -			if (fence->reemitted > 1)
> -				reemitted = true;
> -			else if (fence == af)
> +			if (fence == guilty_fence)
>  				dma_fence_set_error(&fence->base, -ETIME);
> -			else if (fence->context == af->context)
> +			else if (fence->context == guilty_fence->context)
>  				dma_fence_set_error(&fence->base, -ECANCELED);
> +
> +			if (fence->context == guilty_fence->context) {
> +				/* just emit the fence for the guilty context */
> +				amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +						       fence->base.seqno, fence->flags);
> +			} else {
> +				/* reemit the packet stream and update wptrs */
> +				fence->wptr_start = ring->wptr;
> +				for (i = 0; i < fence->backup_size; i++)
> +					amdgpu_ring_write(ring, ring->ring_backup[fence->backup_idx + i]);
> +				fence->wptr_end = ring->wptr;
> +			}
>  		}
>  		rcu_read_unlock();
>  	} while (last_seq != seq);
>  	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
> -
> -	if (reemitted) {
> -		/* if we've already reemitted once then just cancel everything */
> -		amdgpu_fence_driver_force_completion(af->ring, &af->base);
> -		af->ring->ring_backup_entries_to_copy = 0;
> -	}
> -}
> -
> -void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
> -{
> -	af->wptr = af->ring->wptr;
> +	amdgpu_ring_commit(ring);
>  }
>  
>  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
> -						   u64 start_wptr, u64 end_wptr)
> +						   struct amdgpu_fence *af)
>  {
> -	unsigned int first_idx = start_wptr & ring->buf_mask;
> -	unsigned int last_idx = end_wptr & ring->buf_mask;
> +	unsigned int first_idx = af->wptr_start & ring->buf_mask;
> +	unsigned int last_idx = af->wptr_end & ring->buf_mask;
>  	unsigned int i;
>  
>  	/* Backup the contents of the ring buffer. */
> +	af->backup_idx = ring->ring_backup_entries_to_copy;
>  	for (i = first_idx; i != last_idx; ++i, i &= ring->buf_mask)
>  		ring->ring_backup[ring->ring_backup_entries_to_copy++] = ring->ring[i];
> +	af->backup_size = ring->ring_backup_entries_to_copy - af->backup_idx;
>  }
>  
>  void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
> @@ -799,13 +785,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
>  	struct dma_fence *unprocessed;
>  	struct dma_fence __rcu **ptr;
>  	struct amdgpu_fence *fence;
> -	u64 wptr;
>  	u32 seq, last_seq;
>  
>  	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
>  	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
> -	wptr = ring->fence_drv.signalled_wptr;
>  	ring->ring_backup_entries_to_copy = 0;
> +	ring->guilty_fence_count = 0;
>  
>  	do {
>  		last_seq++;
> @@ -818,21 +803,12 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
>  		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
>  			fence = container_of(unprocessed, struct amdgpu_fence, base);
>  
> -			/* save everything if the ring is not guilty, otherwise
> -			 * just save the content from other contexts.
> -			 */
> -			if (!fence->reemitted &&
> -			    (!guilty_fence || (fence->context != guilty_fence->context))) {
> -				amdgpu_ring_backup_unprocessed_command(ring, wptr,
> -								       fence->wptr);
> -			} else if (!fence->reemitted) {
> -				/* always save the fence */
> -				amdgpu_ring_backup_unprocessed_command(ring,
> -								       fence->fence_wptr_start,
> -								       fence->fence_wptr_end);
> -			}
> -			wptr = fence->wptr;
> -			fence->reemitted++;
> +			/* keep track of the guilty fences for reemit */
> +			if (fence->context == guilty_fence->context)
> +				ring->guilty_fence_count++;
> +			/* Non-vm fence has all the state.  Backup the non-guilty contexts */
> +			if (!fence->is_vm_fence && (fence->context != guilty_fence->context))
> +				amdgpu_ring_backup_unprocessed_command(ring, fence);
>  		}
>  		rcu_read_unlock();
>  	} while (last_seq != seq);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index fb58637ed1507..865a803026c3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -185,6 +185,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
>  		return r;
>  	}
> +	af->wptr_start = ring->wptr;
>  
>  	need_ctx_switch = ring->current_ctx != fence_ctx;
>  	if (ring->funcs->emit_pipeline_sync && job &&
> @@ -303,13 +304,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>  		ring->funcs->emit_wave_limit(ring, false);
>  
> -	/* Save the wptr associated with this fence.
> -	 * This must be last for resets to work properly
> -	 * as we need to save the wptr associated with this
> -	 * fence so we know what rings contents to backup
> -	 * after we reset the queue.
> -	 */
> -	amdgpu_fence_save_wptr(af);
> +	af->wptr_end = ring->wptr;
>  
>  	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index b82357c657237..df37335127979 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -104,29 +104,6 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>  	return 0;
>  }
>  
> -/**
> - * amdgpu_ring_alloc_reemit - allocate space on the ring buffer for reemit
> - *
> - * @ring: amdgpu_ring structure holding ring information
> - * @ndw: number of dwords to allocate in the ring buffer
> - *
> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * doesn't check the max_dw limit as we may be reemitting
> - * several submissions.
> - */
> -static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
> -{
> -	/* Align requested size with padding so unlock_commit can
> -	 * pad safely */
> -	ndw = (ndw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
> -
> -	ring->count_dw = ndw;
> -	ring->wptr_old = ring->wptr;
> -
> -	if (ring->funcs->begin_use)
> -		ring->funcs->begin_use(ring);
> -}
> -
>  /**
>   * amdgpu_ring_insert_nop - insert NOP packets
>   *
> @@ -877,7 +854,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
>  int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *guilty_fence)
>  {
> -	unsigned int i;
>  	int r;
>  
>  	/* verify that the ring is functional */
> @@ -885,16 +861,9 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	/* set an error on all fences from the context */
> -	if (guilty_fence)
> -		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
> -	/* Re-emit the non-guilty commands */
> -	if (ring->ring_backup_entries_to_copy) {
> -		amdgpu_ring_alloc_reemit(ring, ring->ring_backup_entries_to_copy);
> -		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
> -			amdgpu_ring_write(ring, ring->ring_backup[i]);
> -		amdgpu_ring_commit(ring);
> -	}
> +	/* set an error on all fences from the context and reemit */
> +	amdgpu_ring_set_fence_errors_and_reemit(ring, guilty_fence);
> +
>  	/* Start the scheduler again */
>  	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index ce095427611fb..6dca1ccd2fc2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -121,7 +121,6 @@ struct amdgpu_fence_driver {
>  	/* sync_seq is protected by ring emission lock */
>  	uint32_t			sync_seq;
>  	atomic_t			last_seq;
> -	u64				signalled_wptr;
>  	bool				initialized;
>  	struct amdgpu_irq_src		*irq_src;
>  	unsigned			irq_type;
> @@ -146,15 +145,17 @@ struct amdgpu_fence {
>  	struct amdgpu_ring		*ring;
>  	ktime_t				start_timestamp;
>  
> +	bool				is_vm_fence;
> +	unsigned int			flags;
>  	/* wptr for the total submission for resets */
> -	u64				wptr;
> +	u64				wptr_start;
> +	u64				wptr_end;
>  	/* fence context for resets */
>  	u64				context;
> -	/* has this fence been reemitted */
> -	unsigned int			reemitted;
> -	/* wptr for the fence for the submission */
> -	u64				fence_wptr_start;
> -	u64				fence_wptr_end;
> +	/* idx into the ring backup */
> +	unsigned int			backup_idx;
> +	unsigned int			backup_size;
> +
>  };
>  
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
> @@ -162,8 +163,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
>  					  struct dma_fence *timedout_fence);
> -void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
> -void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
> +void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
> +					     struct amdgpu_fence *guilty_fence);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -314,6 +315,7 @@ struct amdgpu_ring {
>  	/* backups for resets */
>  	uint32_t		*ring_backup;
>  	unsigned int		ring_backup_entries_to_copy;
> +	unsigned int		guilty_fence_count;
>  	unsigned		rptr_offs;
>  	u64			rptr_gpu_addr;
>  	u32			*rptr_cpu_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6a2ea200d90c8..bd2c01b1ef18f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -848,6 +848,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>  		if (r)
>  			return r;
> +		job->hw_vm_fence->is_vm_fence = true;
>  		fence = &job->hw_vm_fence->base;
>  		/* get a ref for the job */
>  		dma_fence_get(fence);

