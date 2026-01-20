Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D118D262AB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 23:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285E610E66F;
	Tue, 20 Jan 2026 23:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t9JbD1sE";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0FA110E66E
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 23:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXJGOpi6UQW0KHMGrO6ogbinOLqWraZtRoKcJxfME8kpJ+ugdIpRB1JiC96qYA2hBCrzViFucJNM8EdW0tl8aGUGTNfbvvq3h8eeUeueTfc3Xg4gq2hFAHIxLwZPPFXh2wd67pG0xDDqLwhZTj7ahnGLGyAFBBMlnxSAYSShfCvXfPuqCze8zpXPoGqJM4fOQ54TJ5FFiy3iiMQPO08f6GSNNez1o8JUcTq6X26y65iNoh2RB4nXMUPwI6+omIMgqFtgiZDDvhloa/J6kE6BKOC9ED7qmRb9ojc0rwbdZf9cy76qYejMGCGVbLw/sSaguADkfUS19GdUSnH3/Imm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGIipjOhCALiM+X8MMYku2U2zEDI2vovFwzWEYRNQrw=;
 b=VKEx9WOMR6Kcs/Nha3zMkkqwWBOhKBKQb/sUVwmdK5zv0HxxT0yo28Pwp55cRBzvUQZypxvWcmp2fRV+mQsxC7Qz0jHNbsDvgjT8aFahCwY2whxAHHqhenn3Gr1dVa2BTCa5Qb6qOI8bD3Nbrirzh1yUsstiHEABOIIYIIXaRH8ulBargNeAht/i+GouhipVD/JvwO/d0LlM2Pp7R+0obCVspULGSzLGtRiDGV7Y7lrZxbsbAdMp4m4xRXwgG/74GSeSwj2P/gPV/JcHu3EKuZ5NvqYdlT797jCbN6W+HT+PqdP24YUuM+NA+fwT7lgLkEB4UK4lrk8cNFubPZ2B/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGIipjOhCALiM+X8MMYku2U2zEDI2vovFwzWEYRNQrw=;
 b=t9JbD1sEUmGpngjXIcxYE4LKuUzovQPRo2G+1XEC0JAvOP31NRJGu3dclfXZBiqrZuHZXNsh4TG7yxbZee1RXUdrGuoMwPqLcYroBZiTW1NICPIuqfvupWQutaNn8iA9/UtWftpwuwF3vi3qihEgpo3rEhelsDZjaX4qtQfiVQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 23:27:18 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3%3]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 23:27:18 +0000
Message-ID: <e212145c-6c77-49ec-a0da-48cacb031fd9@amd.com>
Date: Tue, 20 Jan 2026 23:27:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdkfd: gfx12.1 cluster barrier context save
 workaround
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Gang Ba <Gang.Ba@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Vladimir Indic <vladimir.indic@amd.com>
References: <20260116203932.988704-1-jay.cornwall@amd.com>
 <20260116203932.988704-4-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20260116203932.988704-4-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: b52b91ac-4527-4586-5276-08de587b73b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlRmRmkzNkx1SE1VSVAycXRNckNKQ3lTODhLYytLU1NISnlZa3lpbTh1NUJR?=
 =?utf-8?B?VHdJUVgyT0xFd1NLekU0cUU2d2tkeFI5Q1hOd0lTV3VnYUdzTXlHRjlERFBM?=
 =?utf-8?B?dzdrNTRmUUg4OVpGcGNHMHRIanJubm02b0NDVUNic2xaN05PRXlSZWlIQndD?=
 =?utf-8?B?bWJyb25zblQ4Nm5kbDVCMW1YLzM4TUpoaXF2bjR1eTIrbGJlUXd1R2ZiMGtV?=
 =?utf-8?B?cG1WMXZqeXpMNkxRNlJkU1FTQnFZWXZZalY4RUloelRXcFBjM20zdWY0bWZD?=
 =?utf-8?B?Vm1rN09YUFdvckVKOU5JN1p4UmROWlVFTHQ2UDZYKzlOaWxXMWVOTlgrMi94?=
 =?utf-8?B?UTBLZFRBY0hsUXhzb3hQbzRVNks2cGM5cUszdEIydTdVM3VsTXZTMkg1cHUr?=
 =?utf-8?B?VkZkWFdoQkE2ZFgyODdHTFJ4Kzl3QjRxcWZCVWtoTElWNXJGemhyd0NYRjRk?=
 =?utf-8?B?NGx1TnhFL21yM0Zjc05FOHkwMk03amU4Y3ZtdC92NnNEenordWlFQmtDaVVL?=
 =?utf-8?B?WERWUStqejBCMG9XT0NlTWllbXZBNjEwaW0yMHl1b3VXRGQ4bUxFYlYrZkFS?=
 =?utf-8?B?VGN6a3A5TklYRFg5NW92aCsvMUpyd0MvUThKVGFUamlIRktwR0RoRExIelpX?=
 =?utf-8?B?T1hvanJhQzFTY1ZTTWpiUTR3VW9hazJDR1daNm9Qb3BHT0VzWjg2aGhVV1JC?=
 =?utf-8?B?Z1FjUW9jc2pKekdmRTFSTzkxSWs3ZGJJWUYxUDNRV0tSZGtCeFBHaXg3WnRU?=
 =?utf-8?B?YWR5N3pvSk96MFMvdUQ0d0toRThlS3FMdmZtVktYZWlYTWswVW5tN1c1cFUr?=
 =?utf-8?B?dTh0T0EyNGszTlFoM1RHeHpiTlh0SXNNOVNjUEVFU2srUDhwUnhxUlVjUEtO?=
 =?utf-8?B?OXRFQmRqOHZxYUFYenMvNGtnU3RHalJNRk1lUlRNb1gzN2U1MFNONTdFVUxv?=
 =?utf-8?B?elJKaE1RcGdCelB0MmNlRmF5SUltVXhuL2tNYUVucUVva1J0VXJVQnZ4TnFJ?=
 =?utf-8?B?TnJianFTKzRoUTBwTnRBVlR2OE9qMjR5dzFNaVU3TG94eGZTSHVNLy9yMmVG?=
 =?utf-8?B?NVdyYkUrczE3TUxxR1c4WVpudkJ3RkNKTDB6R1dXdWdaWDNQZk5icEViOStj?=
 =?utf-8?B?M0lSNEJlc3o4aENXd1p4dTdGUTY4M0psVXlzRkFDTERkYk9lVGJ0dndDZkp0?=
 =?utf-8?B?aHo3UVlDd2lidFhEUWhOWHFLbzVPMWFTbEdDRjYyMzJjckwyTGZzeHpNd1BZ?=
 =?utf-8?B?a1NoaU0rNm9QNkxueTBwNFRrWFRHdm1uR3dNOVRjYkpBTlBnMHRvQzR2WTAy?=
 =?utf-8?B?aUhUckFMdEZROUwvbXpWOVVsSXhFNGtDSmlzREVlRGlaNGVHZVZQZUY5TXhj?=
 =?utf-8?B?cEVCenJkUVVGZzdydSsrWVdSVXl3VEE5UW5CL0VDTWF5WFgwR2paL1FQNzU1?=
 =?utf-8?B?VEc1U25aMFBna2Y2RmJsV1l4OWJpc0RzQUkraVhZZGFCWEsyMWR3dTRFZG96?=
 =?utf-8?B?bFNTNlRYTWlsa3l4RWFKSG5aN1I1QXRrdHdlRllISFJua3NsTzBueGhjZm5q?=
 =?utf-8?B?NWl1bEVIT1lqWFVYdnZjbHc3dTY2Umo3VmpiNzY2YmNJckYvb3FRTDQ0OHMw?=
 =?utf-8?B?RjZ1anV1NTFzTXdPU1hFWm5aZVRGamR0a29ocmNsZ1Q2Z01GK0pyc1JTZ1Vs?=
 =?utf-8?B?VDBEMFVNcmhBcXR6MXRPWjFZekxTTWVKYkhuMnlmL3AyYmk4aDl2WjN2UHFm?=
 =?utf-8?B?QVlSbmxvNVZrSm9QNUNzZUpUalZLZUNwbmFrVU9wRzlKZEdXcENOcnhodGsy?=
 =?utf-8?B?L09XUmxLZTZvZnlyeVpXYzJRTlcrRnIvZjVyVmpIWU5GVGtINmFLUmNmeU1W?=
 =?utf-8?B?MDhBVU16emZXMGFlbUsvMERRZmhlcU1MNUlFdkIvb1ErcVgvWWl6dTVtdWxl?=
 =?utf-8?B?SGxXNFljdWtCeHlnUWE1YXFpVlZrWGxWMVZFUC8vdVV3MzdraHNjb0U3TWpE?=
 =?utf-8?B?Sy9XbnVUOVhBbEYwckY4OW9qd01mQ29DZUpYZzZrODF1a3dYZlkwcFowTENi?=
 =?utf-8?B?Q3VRUzVoVE5VMDJ0TzBpdG9TbUU5ekRWTDBhTXM1Y1dRaEZiM1RBeXFvUlkr?=
 =?utf-8?Q?er9Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekhnbXREWU9tZm5hcUQrRXdpR2g5a0ZDK2pRNzNwOVVSM3ZaZzVzb1NBSUZa?=
 =?utf-8?B?NWJudTBESEV3RENtZWlGakVJZC9Nbm5BcWZOVlhpUzM4Y3F1TitwRm41dVVn?=
 =?utf-8?B?M1IvTFlWRUhGUWoyOUViRDMydlRqWCtkL29rNktoVnpxTzl1dlRFc3ZsSWxD?=
 =?utf-8?B?NlVCSmFNczRQcTlQUExOT0ZjU0E0SVAzZW8vWWp1RjdJV3Njd1U2WXVIZldi?=
 =?utf-8?B?Sy8xWWR3dXBueFFEeFRjZjdpajVnSVdneXhLWkZPQ2dmY2RFY1JkRy9xUTkw?=
 =?utf-8?B?VTA4bDJCdXptekRjTWVWR2lhYmVlUVNoTUIvZVpQbDJ3VjF4cVY3M0xNNFZa?=
 =?utf-8?B?MTNiQlhiME1wRkN0RHhCRWtEcEV3OVJjWFB2bUZZVGRUc0d1bHM3UHBRQ0Fi?=
 =?utf-8?B?VnBNQ214SHF1UjRkOW05WlU0VGpKMEE5MUluajN4RzhxRFZteEF4YzRhRkZ1?=
 =?utf-8?B?RDNDWlVUZUVMZUoxSkx1czh2eDFYak1ub3E4T2ZGVkJ2STFseCtrVWV5VHlv?=
 =?utf-8?B?ZGM3TzhxN3VMSTJjcFNSMWVVQzlmM0pXZlBIMWROdFhWNUpiSGVncHpQN3VK?=
 =?utf-8?B?cHVzbHdCcEVVSGw0cUdXMHF4N2U5YUJjODloZ09mQ3pJbTJxN3VBM0Q5YkFq?=
 =?utf-8?B?a0xlcmxLeHgzS09KOVNYeEpnQXVWaE9wdDZMa1ZrSk1BN3A3YXVCWFlDSWFD?=
 =?utf-8?B?U2VybEt2YVlwZFNBanRTckQwU3JYS3B5TWZOdjhFK3lKdkRkMVlLc0pjUVVr?=
 =?utf-8?B?MSt4QWhBMExTYStqM291YUpibkJHK3RtUmY1Qi8yNmtqaW9KMGhmcFY5OTI0?=
 =?utf-8?B?eTFVaHpLeG1qQnU5QkJCQ3pNQmEyY1p4UCs5dHQ3dnF0WHpiWWV5Nk5IMVdZ?=
 =?utf-8?B?eDZlYnZOWG54MnBWZVZHWmhOM2pnb2tDN2svVklBeVNTUFlRSTBUZDd1T1Rz?=
 =?utf-8?B?RFdsVVdYRCtrNWRHSlhHYlM2YVk5aHVpSWZMdFFTZE1aRUZSeCtEbTNiUXVo?=
 =?utf-8?B?a3kzbEVYRVljZnFlencvb3VoTlJPbGVmYlZUdy9DOHVsWTBHMWtRL1RaNnZz?=
 =?utf-8?B?MFBta2N4Sm1GNHJJQ29TMmxQVGlzdDNobkJsZ2dscEFDaHY4bjJYSEIwMEZB?=
 =?utf-8?B?ZkV4MHFmS1IvS0F2N2dJUFZ5cjhtMlNpN1FXU1NDaXdObTA3YUVjUkNjTmwv?=
 =?utf-8?B?QU9NWWFaVkRjQld4eFZEMlp0TmoreGdnaG9aZndGYTZDdVU3UEwwMDlKTk14?=
 =?utf-8?B?YTNnME9VdmlnSlRicnE0SlcyMmxaazV1QUNTZVZON1NLRStHM1BQbkZSNVpT?=
 =?utf-8?B?SVBwV0xjdVY2WHVnRUR2Z1k1a1BlOUlSbk4yWkZOYlR5SEZOKyszMFZCV1ZE?=
 =?utf-8?B?bGhTbjBlNmYxb3JkekZHQmEvb3JMQ05EWnB5RVAzbDhqT2dwSWkrSWV6RnB4?=
 =?utf-8?B?aERNaTlmL0FQL3dONlQ5YWFOdzhrSUxPa0tGY1FUc2ZkL3hlT2lrSmc1VjUr?=
 =?utf-8?B?U0FSTkpqUERoSHNscmdvWmlEaEtDdU00TFdxSll1UFFaZlFRUTZ6R0dJMXBZ?=
 =?utf-8?B?Z251Z2owdkswaVhva1hBaEtZOFc4Uk9nNVhzbjVHaXNyc2dYTTlqL0VOU1Y5?=
 =?utf-8?B?RkpiN3BiRUxhSUphcnp0TGcrY2QyN0FOaTRpTFJDTndzdTNjT05EbnU2bm5j?=
 =?utf-8?B?VStNM0FFMFFvMTFtZHdmWDdYOGs5T3BLZW9XaUlqeTNaYjBsdk1zNExYd1Zt?=
 =?utf-8?B?YjhzdURGanZ0dmlKeVVUdWErVVNCbjVURW5Hb3VpcnoxREdSUkVTaHFoYkpn?=
 =?utf-8?B?a3JRdmJHc240RHNmT0Z3aDlaa1RiY3FXbGw4ZGV4QU9SNkJwakV1SzgwZnlU?=
 =?utf-8?B?NFVESkw2OVU1ZFpMSkpUdU5NUFJOcElUL3lrQVVtM1BxSlJzUUZlVlY0czFB?=
 =?utf-8?B?UXV5eDh3S2djKzBWM09pbmM2NW1nWldXM0tWdEtvV1VkRzFPTlcveDRLY2s1?=
 =?utf-8?B?MWlQV1E2WXdaS1FKcHhGN0I0Y2NIOHF0SmEvU0k4dnNPTzZESStxMzNNbGdY?=
 =?utf-8?B?NnZUTHg1aFNHYTJkajlkQUo1Tkkxd3c2aGdUOWdoSDIzek5ZWEp3Q2lySmR2?=
 =?utf-8?B?TE9lRWVFS0dQUE1yb0F2Mi9sYkdVNDE2cjI4ZDdFSDdkRGZDeGZqRFE0eEdO?=
 =?utf-8?B?YnZJWFEvS3UxLzFKVEg2ZUkzYUI4Zmk5Y3RNOVJUNkY1M3NmRUNBem55MVFm?=
 =?utf-8?B?Nnc2UUdhQmhFZGgwSUM2b01pSWRJS0xncWE1aC81c1VLVWpMU2tBdHBXTVh6?=
 =?utf-8?Q?ssO5nHFJJ4pdY/4Pon?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52b91ac-4527-4586-5276-08de587b73b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 23:27:18.3070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaBzlIg7qzLACcmPdA9peWD7opkTNXI+H6CuaVIuRsqMVtq9ouYx1Pwc3QPFoAJgkAmMEHYFG35UTjm/J6RQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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

Hi,

On 16/01/2026 20:39, Jay Cornwall wrote:
> Trap cluster barrier may not serialize with user cluster barrier
> under some circumstances. Add a check for pending user cluster
> barrier complete.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Tested-by: Gang Ba <Gang.Ba@amd.com>
> Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Vladimir Indic <vladimir.indic@amd.com>
To the best of my understanding, this looks OK. Thanks.

Best,
Lancelot.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>
