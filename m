Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCFCC71157
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 09:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D33B10E1CF;
	Wed, 18 Jun 2025 09:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lNp3gMKD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015C010E1CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 09:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qubJvXeQAXv6zgUrreCofOxAqz13j2PxDR/+dyVZPkAIlvKSG6dbQmvcbsC1oW8XXW9uhpD4+SrpTXx4Gsk7hDbIkW9Yr5CV2IMcW6ybGIw61KpXAOucCw/jUj9250tVRLkvqZga77m8jLYyxIamA+YNogju0gUNpkUboO9oTu9yT/SvgPQ/NTXHvsTQKyYP7HoHKVZ1q+a7XNW6PiLODrIMG2jVLYzAwJhtZJlYt/b47GsDBCsLTJ33NpeiEKNjSJ9P2Ns8M8FnbiUEja0Yj+AiIYLCZDgEKnFn25ugVKqdKbJZr0UXbJQdy0HjHuIeFkYbogHd84yMSoVd5RfKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9HAEOUs8XzRsq9LCiL/pZQPayDgffquxLB5mQ8EX0E=;
 b=hr8wX3UzeyL20kipaO7pZZfrk1T+ZEwSRCGAl5RvM95E0QMVGQfpQMws49AR9HndOCzpLs/O85eOiyYMpPBa2J+VGzpl3ly6eMfQNZyXo2AwNWNTH7jjYjg1V5L8tPP/w2p2sVXL5KoAgMlXthooyEm5yuuJeq7FGMj283UmTVKJsWO4l43YwOcY3HWcB0A1zGqt0vObwPaJ7Bj400FaAXLB+BUP7pEnljUjYpZc61fQi3OG6ljDodAoGYgeDpJeyDaVqCgn3ner3Vr5jEgkaKUYdTOqNsa0wxgi1+aKgrv6OnAJSxTwEFz8vCxv+f8cxdGe1mUzQFkFz7BTaktUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9HAEOUs8XzRsq9LCiL/pZQPayDgffquxLB5mQ8EX0E=;
 b=lNp3gMKD2uTd5KTYWDzrfAd6uSAhLWoI408LUCR8gEPSU/pJsO2rCLNWfx8b9a3aVUkfWNzgoS/AagX82f/9S0g4ymB6wsUGvP0Yfr33wyQY8y82u61Fq4iHkjiRPmP8phzGodpzS4XqJV1sfUbozyMjUTlHBBsORLKSy36Thm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 09:56:33 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 09:56:33 +0000
Message-ID: <e7c030a3-9109-475d-8784-e6ba8ee119e9@amd.com>
Date: Wed, 18 Jun 2025 15:26:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
 <20250617092243.2769580-8-Jesse.Zhang@amd.com>
 <69db08d7-4976-40e8-845e-b125efa9fa9d@amd.com>
 <DM4PR12MB51523E85ACDA7D14C4D12D60E372A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <6b355dd0-f159-4390-b02c-63e793c6fd81@amd.com>
 <DM4PR12MB5152DF1151C8448FF0869800E372A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB5152DF1151C8448FF0869800E372A@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ea658a-ea41-4ab9-2e0d-08ddae4e67e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tzdac2J2eXlGQ1Q0cjFsWW5MaFpCQkF6WVZEa1JVZ0tqS3BScmtQU0xDZmFP?=
 =?utf-8?B?ZmM2eisvMnE0K0xKbnMvNmVvY255aWo2cmk5TmNvZzdhUzNyQlQ4MzFyc1NQ?=
 =?utf-8?B?bmJNNk9wYjRucEZtcDNlUHdtOG1GZ0h3M2xWcEJOMnV3OG0yUnpYM25wY1VJ?=
 =?utf-8?B?cW5RTU5Bd3dVU2VkMURuM0YwZDFXT3NLTzRpbkVPU3Mrd0d0blN4ZWdVbGkv?=
 =?utf-8?B?ekMyRysvWmFiRFQxWTBYVFhFaGVpZi9SOVFIeUdsVEtjTUV0Wm9qZUJHSy9q?=
 =?utf-8?B?QVF5MkIveHJJRWpkaHFPY2xjWHBxZktIMnBTNTA2REhYeUNGWWNrRUFJdHBZ?=
 =?utf-8?B?Szhad0pLbkxkK0pic2JFUDZ0Nm9FVC8zbzhzSXkvRS9neWFDMUl5ekdJa2l1?=
 =?utf-8?B?S2Y5WFFtbGRjdWtSbFRHa2Q0aTcyOXIzVitHZEFIdmE1WWl2YzU5Ylh2QWY3?=
 =?utf-8?B?UVFMK1ZmMGt0QUR1b1I5VlpBQS9hdDVxQWVBa3ZlZng3blV4bVVFMFVlSUhL?=
 =?utf-8?B?RjRWZUgrd1pmMEduZk5kd0FzUGlxdDJnN29BZTVuemFFMFZ3SitFaDBYdTl0?=
 =?utf-8?B?NkVRcFc0R2k1OTcybXdVeWJNK1lPV3IwYVN4bzA5eVJXYm5vdWVvUWdQbjJT?=
 =?utf-8?B?OURyN0xDZEROb1NZd2QzTXpyWGMzQ0FyeklybjZqQU5VS3h0Z3Y2Uzk1eHMy?=
 =?utf-8?B?VlNRcUpZemZlenh6bjd5dzh2elROeERlZTJVaS9sZ042Nm5jZ3l1UDE0RGdF?=
 =?utf-8?B?V2dscTdJVjhKbFNtd3o4emhGUWtiTEpRc0FSSjNlWkNtQXBWYVExYlhFVE0v?=
 =?utf-8?B?VHBRclVycmdqMDRmVzM2NlpjLzlGK1RJL25jd2lsZWRSSUxoejFOd25ET2lu?=
 =?utf-8?B?V3l6QlFyd050V3hVWTdhMGFIbmw4WEk3bDZMem0vT0UrejVNVVFqc1ZLbVdy?=
 =?utf-8?B?WnZOTVVrUmt5Q3FUQ2t4MzR1NG5wa1VGNTBKN0xEV2FsaVdMbG1Ycy9yUUlX?=
 =?utf-8?B?eWVYLy9kMUwyMFRNS1JoTitaNDFZLzUzRGVHVXpmc2ZRZE1GRlIwUllDSDNL?=
 =?utf-8?B?ZWdUNktYREtKOEY2NVdaeGd0RUkvRzdBeXd1TC9hbEJHVXpqWEdpWlVxcFc5?=
 =?utf-8?B?dS8rZk5peHRFTjJiMlBYUHp2T0kxaDQvZ1dqdTlVbXZZU29rUEJXQ2ViTElB?=
 =?utf-8?B?MWpBbTNBSUFMR2FodWpvNGRmanV6UGZ0RVVpaUJhMFhXMm9FSlNRaTdGeGZp?=
 =?utf-8?B?eDhJUzFkL0lvTGtEbW5SUFg2TmlxSG43UE91SmtpWGl4WGg5RittSXNvblNZ?=
 =?utf-8?B?OUovcHdVMHdJMDcrTEhRNE9IWGpUb3gxYlh1RzZ6anczOVJuQ2toZit1YXJV?=
 =?utf-8?B?NVdUem5ZWFNlaGsyK0J0N0tjaXFOWUkyaUthVDNlQXVsWllwRFpMbStuRWRj?=
 =?utf-8?B?YzlOdG51Y3dOaTY5Q2FHaDZMVnl3aTc2N2JLSkRnanJTd3dIcE1wRElZNWlD?=
 =?utf-8?B?dHBwNTNSeXpaRFJIZ0JCb3B2NFMxVnlNMC9kaFlNMXlQc1F6bFpjTVRxWjFP?=
 =?utf-8?B?bHFZb0JOQmRUL3AwbGJ3ZXpEb2Ixb1ErVDBOY2tSNnVKcGwvYXlnZ1BPd0pR?=
 =?utf-8?B?MlQrVzFzVkJydnhKSForaUdCUmRDVmZkaGQrQytYRXQ3NWVRakRLSnVsSGtW?=
 =?utf-8?B?eVh4RXJLUmpFY293UUlYSUhwRXd1YUtpR3g0dlZkMnRTcjR3WHNJZytXMlNX?=
 =?utf-8?B?N0RRRlptT3hOL05GUGduMWNabXpiS3JuNGR0MHNEVGtlakxtMjB1ekhHcFRq?=
 =?utf-8?B?dlRpc2lkL1JDME4zb3ZEeDdnbnBBNTF2SWM4d2prdmtSc0JMN2p6ZjFnREpV?=
 =?utf-8?B?QjZVOHE2am91WHBta0JMRHhOVWtnRGVjS2FvcVJCWG9mRXQyeG80czZFckRt?=
 =?utf-8?Q?67hElA74mAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TElnYXBiNHRRazVrMEFJaEZuakYvcHFsV2JmRjZCaTJKTXB4Nlc5MUwrR01k?=
 =?utf-8?B?Z2IrZVRJVzU0MUQ3dDhjN2V0cHBOakVDcDFhNkttMjRhRmtJZlJXQ3NtT0ZW?=
 =?utf-8?B?QmNOTjF3eUFZMEVkWUR5OXZ1aDA1eWlvQTRnVzJ5SVdmQSs4L1hPQ3JQOGdO?=
 =?utf-8?B?VUx0K0ZYQWs1L0Uvc29oellEZ1l3am4zRWw2TlRVam5ieWhDS3dMSk8rSVF0?=
 =?utf-8?B?cjMrb3E2OFgxVFY5QWhVL0ZWM3B5YmZ6Zjk1cElaa0hORHc0RGtzMGovWmJC?=
 =?utf-8?B?RmZTQ0RJMWFpT0MxKzhqQlJJNFpMR1prN3BFRVgyNERsYURXR0lRQVZjbVIx?=
 =?utf-8?B?M3Ivb0pEVTNuR0xqR0dublVkMG1tdEllRlQydUhYZDRORm40MVNYT2pObW9h?=
 =?utf-8?B?alJYMWNRVUpGMXpnVjZxYWIzekdlU3c4TFRyQ3Y0QkdlZDlYc0lGTHNQSXRK?=
 =?utf-8?B?TWhpMmdmY1Q4eTJNVWxUbStXaWQrWlVFalFBK1lzM0ZaUzNSUnNMYkRRVW0z?=
 =?utf-8?B?R1pPTXE2ZTBWZVZ5b0RuMTh1OHp2M0VLRmwrR2cvUUthZlB2Y0RabmxNR0hj?=
 =?utf-8?B?bVJtd3luMitjNVpPL2FTTDNsbGN0bjIxcVFUZ3JiQjZ1MGhnWWlqUGFkcmlE?=
 =?utf-8?B?VjJsWDlxaHkwcnloT1NyeEVreWZPQlE0TkNESzFHWmZTT1hWRlhNYW9oOCtK?=
 =?utf-8?B?dmp5aFpQOWdQUEk1Wi9uVGhJaTYvWHlYc0sydmJ4OVp2VmZwNWcrcmZCdFcw?=
 =?utf-8?B?QWMwSGxUQm01ZmViVWZEcnlrQVhtZ3MzMFFBMFY5cVpnS2JKRUdQTmc5ZHll?=
 =?utf-8?B?aHF0eTdQZ0ZhZCtpcVE0MzlITTJCZFRIaHp2NmlDdDZSQkhFU3VSTnNkanAr?=
 =?utf-8?B?aUQ2WDd0YXhBQllWVVh0S1JJbHBacmpLYXFXZmJ4RGZRaWZkUlNQVjYxZ0wz?=
 =?utf-8?B?NXY5SmVZSW1SUnpCUFhONWhuMnh6Q0trZ3NiVFlOb0pmVWJCb3pNQXovNFQv?=
 =?utf-8?B?S2xVWXVnTEJpUTJ4SHdUNno2UFNqVytRUm9oejJ5MDdEZVNuOHdicG16L3FQ?=
 =?utf-8?B?eFJ6NU1wT3QvTkRoZzE5U1YvdTNlK2R5NkJQeTQ5djc4WGFvblJzb2w2dVJy?=
 =?utf-8?B?b2NSR0dBVTE5d0JkWTdmVXdiZk1jY2pmSm5KRnFXa09OMzdEUktUdW5HZ0RO?=
 =?utf-8?B?VU14TU9IYUVpUXRWUVpNaTVuNXFQbjVXUVNsRlJ0WnRSdG5OK21Ya2lPQk9I?=
 =?utf-8?B?dTRLLys4d3FhQ1BBbWR6emRBZVJJWmRmN1VQSkc3YXRrN2syVVZEcnFJUHl5?=
 =?utf-8?B?b3dybUdHd1RwZzJEUVdSbHQvcytDSExsQ1Y4UEd6bFV3L2FyY3V1K0Z4SHVu?=
 =?utf-8?B?TjVYZmRmNHNzTGtUdHVUTUlyMnA1WEZLbEViTWJCdmhzV2x3NC90V1FkSXpv?=
 =?utf-8?B?amk3R3VJaFcvNzNuVVZlL1I0NWp3NkpCby9USHI1Z0RIMGVEaWtBUWxUSk4z?=
 =?utf-8?B?OENDWGd4WTlZbkFRVnp1K2Fhc0gvVE9MZVdWZ0tRd1RkcklpNEZEMDZuZFhj?=
 =?utf-8?B?RzJzNE5nY2VlKytVTG1veHNiN3FWdWdCSENBZnRyWVErMmtCV3RIRnc2aWhC?=
 =?utf-8?B?cCt1MUdvdTlVNVMrcFFJcUV6UFpRQ3VoK3BiU1lSU29Ed0VPN0JqOGU3SXV3?=
 =?utf-8?B?c1AxcnZjMllFZVQxejVweEovajdoQUEzTk9ML2ZhblFSRnBzSHd2YTMvQVRw?=
 =?utf-8?B?QXpBVHEvRzQxTU0rL1lQUHFzRCtWbHNVYlB4eExjeGVEVDByTDVqM0Z6UDR1?=
 =?utf-8?B?bkMrb2crejhmcFMzeExZU0ZvZWViSy9UT1lZQTZRMlMvbjFGM1Z4WUVlZWN5?=
 =?utf-8?B?Y0lScGd3WW1LSGp3V3pZZjRuQUNrZDJVNkgvN1pkWHBob3JkamVkNEhGYjlQ?=
 =?utf-8?B?NDk0NGF6elo0cFYwNUNuTFB0YWxQcjYrcngyUEdaaGthb29kQnZ4bGowYldF?=
 =?utf-8?B?T2ZtRDVrL0FveGxseHpnWFRUOFhuVWFXc2NXOXhsK2dkT3dzMlQ0enIrckgr?=
 =?utf-8?B?ZkJDMGVsYWJheHVETE9tM2FvWEJidUFWM0FTQmNLRjYybXVySTFtQW1oUkk4?=
 =?utf-8?Q?wjf0oFYKPCA1tz+ZYx15g7XNB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ea658a-ea41-4ab9-2e0d-08ddae4e67e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 09:56:33.4918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8v7IUW+hYXI9RizUuuYjR7doL2EZ5IXY6VoQw7+AVUMTEsz5q4cINJaubQfaRLx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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



On 6/18/2025 2:09 PM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, June 18, 2025 12:14 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
> 
> 
> 
> On 6/18/2025 8:14 AM, Zhang, Jesse(Jie) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, June 17, 2025 5:57 PM
>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>;
>> amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [v3 8/9] drm/amdgpu/userq: add a detect and reset
>> callback
>>
>>
>>
>> On 6/17/2025 2:50 PM, Jesse.Zhang wrote:
>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> Add a detect and reset callback and add the implementation for mes.
>>> The callback will detect all hung queues of a particular ip type
>>> (e.g., GFX or compute or SDMA) and reset them.
>>>
>>> v2: increase reset counter and set fence force completion (Jesse)
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++
>>> drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51
>>> ++++++++++++++++++++++
>>>  2 files changed, 54 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index ec040c2fd6c9..0335ff03f65f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -77,6 +77,9 @@ struct amdgpu_userq_funcs {
>>>                    struct amdgpu_usermode_queue *queue);
>>>       int (*map)(struct amdgpu_userq_mgr *uq_mgr,
>>>                  struct amdgpu_usermode_queue *queue);
>>> +     int (*detect_and_reset)(struct amdgpu_device *adev,
>>> +                             int queue_type);
>>> +
>>>  };
>>>
>>>  /* Usermode queues for gfx */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> index d6f50b13e2ba..52d438b5dcef 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>>> @@ -21,6 +21,7 @@
>>>   * OTHER DEALINGS IN THE SOFTWARE.
>>>   *
>>>   */
>>> +#include <drm/drm_drv.h>
>>>  #include "amdgpu.h"
>>>  #include "amdgpu_gfx.h"
>>>  #include "mes_userqueue.h"
>>> @@ -198,6 +199,55 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>       return 0;
>>>  }
>>>
>>> +static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>>> +                                   int queue_type) {
>>> +     int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
>>> +     struct mes_detect_and_reset_queue_input input;
>>> +     struct amdgpu_usermode_queue *queue;
>>> +     struct amdgpu_userq_mgr *uqm, *tmp;
>>> +     unsigned int hung_db_num = 0;
>>> +     int queue_id, r, i;
>>> +     u32 db_array[4];
>>> +
>>> +     if (db_array_size > 4) {
>>> +             dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
>>> +                     db_array_size);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     memset(&input, 0x0, sizeof(struct
>>> +mes_detect_and_reset_queue_input));
>>> +
>>> +     input.queue_type = queue_type;
>>> +
>>> +     amdgpu_mes_lock(&adev->mes);
>>> +     r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
>>> +                                                 &hung_db_num, db_array);
>>> +     amdgpu_mes_unlock(&adev->mes);
>>> +     if (r) {
>>> +             dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
>>> +     } else if (hung_db_num) {
>>> +             mutex_lock(&adev->userq_mutex);
>>> +             list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> +                     idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>> +                             if (queue->queue_type == queue_type) {
>>> +                                     for (i = 0; i < hung_db_num; i++) {
>>> +                                             if (queue->doorbell_index == db_array[i]) {
>>> +                                                     queue->state =
>>> + AMDGPU_USERQ_STATE_HUNG;
>>
>> After a reset and force completion of work, why is the queue state maintained as hung? Does that mean no more work can be submitted even after reset? Where is this state checked?
>>  Detect and reset will be called at umap, and if the queue is hung, umap will be skipped.
> 
> Ok, this doesn't match with the inferred meaning of amdgpu_mes_detect_and_*reset_hung_queues*. The API name gives the impression that queue is reset and now it can be used to submit other work. If the queue is not useful after a reset, why not remove it from the list of active queues?
> 
> This API detects the hang queues and resets them, 

To clarify my question -
	After reset, are the queues usable? If the queues are usable, then a
user can continue to submit jobs and later submit a free to unmap. But
the above code marks the queue as hung. If so, what is the purpose of
reset? I see a detect only mode also which indicates detection of hung
queues (without any reset).

I believe unmap is not the only case where this API is called.

> and returns the detected hang queues.

Is it like FW detects (X + Y) hung queues of which X queues could be
reset and Y queues could not be reset. Hence it returns the details of Y
queues?

> Queue removal is done when the user calls AMDGPU_USERQ_OP_FREE.

Thanks,
Lijo

> Thanks
> Jesse
> 
> Thanks,
> Lijo
> 
>>   Thanks
>>   Jesse
>>
>> Thanks,
>> Lijo
>>
>>> +                                                     atomic_inc(&adev->gpu_reset_counter);
>>> +                                                     amdgpu_userq_fence_driver_force_completion(queue);
>>> +                                                     drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>>> +                                             }
>>> +                                     }
>>> +                             }
>>> +                     }
>>> +             }
>>> +             mutex_unlock(&adev->userq_mutex);
>>> +     }
>>> +
>>> +     return r;
>>> +}
>>> +
>>>  static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>>                               struct drm_amdgpu_userq_in *args_in,
>>>                               struct amdgpu_usermode_queue *queue) @@
>>> -352,4 +402,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
>>>       .mqd_destroy = mes_userq_mqd_destroy,
>>>       .unmap = mes_userq_unmap,
>>>       .map = mes_userq_map,
>>> +     .detect_and_reset = mes_userq_detect_and_reset,
>>>  };
>>
> 

