Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDE8C7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 07:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AAC10E514;
	Tue,  1 Jul 2025 07:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+RL4U95";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C252A10E514
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 07:28:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pL4fYfEmHjl4y39Lf9dxsqpZ7sSjOwm5TLi/9XGfMrdSpER1OtObLPS3mmFP22U7JTHdcrgByo6l1pfzyZNtpq+hPbl+iQ3trXU0F1iwunrnJS6nQUVsC138+FuxAuhOO8rTiZmDAETt25aC4jniVTqT6rw4IGCjMiofRNwBa2JQliSx+fjtsmJweV4+pxZWRFywh4Th8E6KxgP4Ez7JWO9zyQZY9P4w9jbJyR0ArMDahDy0UBGU519K+xGWd7v6p6cXUCUPlUNmWjy0bHj3FKRcJCAWFywPJVKSi5ChmHJ5p/wViKABgbrDvmmSt7coB9yOBkCvhOABWEMkeV3PHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhrhnlylLQcUtkCzCtQ1UwdLsLoEmPrzAjlpQjmgXBk=;
 b=a3h+WDCFmKnZ2fcd18G6vB0qZuoZWFt3tEFonSbsfwY5LLYc6pufwYRz7Vt2PE+MqiRObwQ+FpN+8MuZaJnKfTdvD38CUHL4hpinJT07/5jIFoIkWuScT1IObkLr7umh9ILsa3tjXLKjcF2ow0/CtfndJhtF+x+D/qftxhrov4TDA4QXeIZ2q10GydHECsaRs22HTlHyDd/kKF23V9nyxd8DQhz37dqVXw2IeLfByC5N8hfXZG7IVdsD7mgZ20UaR0UGbS9vwu82+1ih9Lp42PWZ3P6xiXHh55pdy41vLRMn6T7Rox0EZKBawG5lYJ1QYauDJqbqrtknVRV9B3wpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhrhnlylLQcUtkCzCtQ1UwdLsLoEmPrzAjlpQjmgXBk=;
 b=B+RL4U95vCQhGarleBBw53iC8CAqwETpe0EOq94Uo8/mVRrTifceQ2WbPLkVGsu2FOWPWuZH5w3FErP6aHsOGb2/py1gpJsV4sL+GZod4hdQ52XtUczZ9M7RWotFYYHFmCiA9VQNrqDGvhWbsS8DP8WXY9d1vAommaWJcjywvmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Tue, 1 Jul
 2025 07:28:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 07:28:09 +0000
Message-ID: <ecd7b192-84af-4e3e-82d9-4283ca14fe4c@amd.com>
Date: Tue, 1 Jul 2025 09:28:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: delete function amdgpu_flush
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>
References: <20250627051204.62029-1-YuanShang.Mao@amd.com>
 <PH0PR12MB54205C1B34B693720538A914E045A@PH0PR12MB5420.namprd12.prod.outlook.com>
 <a3b5cc3a-f863-b845-989c-ddd6ac953a52@amd.com>
 <CO6PR12MB5409AF9DD130FFD6323C1A49E041A@CO6PR12MB5409.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CO6PR12MB5409AF9DD130FFD6323C1A49E041A@CO6PR12MB5409.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb9efcc-d1eb-4fb5-0345-08ddb870d3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czV4cnJUUUdRYTB4TksreWlZcTQzQmNTeitLTlkyNTR1TnFKbkRsdnEzMmND?=
 =?utf-8?B?a1FxT0owRlQ3M1lmdzFFUG5MczFwclFseW9meGRjeUVhRVI0UGZOVHhKOXhO?=
 =?utf-8?B?a1ZvTTMzWlpaNVllakNHcFh2bzhTVENaVVFjN0FPd255dG9SN0JBek9mWkgw?=
 =?utf-8?B?Q0xVd1BnZzJjRWpTSE5DcEVDQVpoN1NBMkxVcno1TFV2VlhIcTJWa0pMUGxU?=
 =?utf-8?B?TUdvMzdQeHdCYTEybVN0NFdkcXlVZ08wYWlpMEhFZkJtbFBRY092NFgzSVVD?=
 =?utf-8?B?Z0VXN05aRVB3RjlQaWRYZkRSZTZyYUpUSldIcVRqZ2lyckUzczNiSnI5a2Q3?=
 =?utf-8?B?TGhscG15VTJETEphRE5xQmdPNGFwS3JSbHFwYXdxWXZITzdhOWlpNkt2QUtk?=
 =?utf-8?B?WkNBbFhkQWJRcnBQNjQ1cmlrdzluMXBXV21PWHc3UHFUZkJ5ejlvRU05bEMr?=
 =?utf-8?B?cnRiNHU2b2UrdVRzLzZzRERaaDArNUdMcTRRR3RlZWxqUjNCbmlraXBiS0Ro?=
 =?utf-8?B?SGttV0J3blJyYnd6WHFsS0lJalNvVWVGNUVmUGRVd0xvajUwcWs4c21YRnZQ?=
 =?utf-8?B?NnVOZ2ZLNzcrdG5VL3ZkRndWdW1obzFEam9wOGZncjlVcVRSb1F5a0RwUm56?=
 =?utf-8?B?OEJuaW5KSUVraGRXZlBRa1hEblJmSndoQW1UZ1U2RWVIZTMzNG1CREU5Nmty?=
 =?utf-8?B?R1VuelIxZjhSKzNMZ3FlSlRxdzlwNUNlMCtHZHRFbGhCSDVKY2U2ektjOXM5?=
 =?utf-8?B?S1Jjd2RBY0xkT1RLOE11R3krdFQ5eXBZd2pPZVVkSVRxQUF3d2NqbGlQVVJn?=
 =?utf-8?B?blcwdWtubEZiVm1qS3hab3BrWHFtNGZUTXhKdG55aUY0bzRCem5raTdxRVkr?=
 =?utf-8?B?VTgrc3RSRnJibTRTV3JpZnJNUnNGVWV2SXJROC9YUHpKZXJ2OHFSSmRkU0Jk?=
 =?utf-8?B?UjdBNkJrcC8zQ3Ardy9tcmM2T0dWQXhCU2ZheDlXZXgraDlKdFRuNm1MUThs?=
 =?utf-8?B?T044NWtFL2U4M1A2eUwzd0k3UXc1MHVlL3p5eDZ5bXhBVCtlVERaSW1sWVIr?=
 =?utf-8?B?YmswZXhkQ0hEWmtWT1pabWkxamZQYnVxUXRuaEFNZUI2dXNsMFFIbUlEaWNP?=
 =?utf-8?B?djFwZzZobXJjdWhuSkRBSmJLSWl6S3RrODMxT2J1QWFRSUFDOWxlT1dqbXd0?=
 =?utf-8?B?VXFtU3BpSUFDL25Bay91N2tyQ2hJcE1GOWFNdHhocWtoRU9hU29ZcllWaEZx?=
 =?utf-8?B?dk4yaXVpRDJpTUpDY3JSN2Y5UGF3Mkd4cHc3WXpmdGdBa1c3eGpybWE1d2Nk?=
 =?utf-8?B?ZXBIM092MXJXL0s0VGVvV3ZPd05QczE1RFRVaVRiOFRoVi9rMnFGbHIydFVY?=
 =?utf-8?B?cjhab2M0M0Q1QVd3QktCby8wd0pZYVBreTRuR2hnV0IxcExwNklGUEF1RHRl?=
 =?utf-8?B?UU5RbGVXUG1yeXR6Rk9aQnMxa0FsMzZFcmdhZmIvZmR6OWwwdW5UdXlZU0ZN?=
 =?utf-8?B?ZXJxdnJrWTMrRHNMbEZ5djdKaHRZSXdRc0N2WEZwM3JZUEY1d2p6eXlHdlBt?=
 =?utf-8?B?ck80WVgrZUYvdmVoM2lkdDBGemxDR2ZjazNuZlozbWlsYUhBdlNBTmx4R1U4?=
 =?utf-8?B?Yk15aEd0LytLdHpRbmR2SVh1aHRwcHFWbDg0Q3BUVFBUWFdWcE5EQnJMSVZG?=
 =?utf-8?B?OUg4TGdMelBCQjM0UWtqN3dHOHZKT2g4ZHB6Rk51aHdWdnc0RTMvV0RLZzI4?=
 =?utf-8?B?Q3lSNXdwTTlZYWFhVnJhK0p0QjQ1RGh3SEZ3NFVlczJ0eU53ajZrQ0lDeHNa?=
 =?utf-8?B?dFVqS0ZJRjZQK2ZydGJ6SkRGRlhiakhrZE43cHlVOTM4bFJ3MnhhN1pwNGFB?=
 =?utf-8?B?MW9SNStZRSt6bzVwcklORmRaZjNLcHMzQmJZZ0hhdUZEcks1MUlySlNQNE5N?=
 =?utf-8?Q?2CklAEpIxBs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTZsd3JXYVNaUzNSSHFEN1o5ZzhvaVpzMjJZRG82VS90bElrSnRnTmFCSFNO?=
 =?utf-8?B?cVArd0xZVkdwNFU4YzRLemFMNW5PU2NTUXVNQTBOWHloK0J1KzZ6ZDR6RHFM?=
 =?utf-8?B?MFlqUkN0cnVMem4xRWNXQlBQLzA5Rk9NVUxaZTN0YmswZ1l0aFJncjRYS3NT?=
 =?utf-8?B?RXo4MDdDU0VMQ2puU3BXbzV0NjNkSzZjYUVEVm0vM0JFTGxEWDVhTHVhMVha?=
 =?utf-8?B?MkhBTEVZMnBadUx4UXFCcXlxd2dReU9wc2tQQ3BUdndCbFFOWm5lM3pBckJN?=
 =?utf-8?B?cDd5V0l0YjJudUFySGlPTkgyUGtVcGZoNDhkZG5KWkFKS0dydng1V1Boa21i?=
 =?utf-8?B?MGNYYUc0TEl4VHNreHdnWXlhejY5Q3kwVUFxWEVnbkdoaU9vTm4xVG1Eek50?=
 =?utf-8?B?QU81dHVGRjdVUEhDQ01WVElZWlBKdzE2ZDZwMUVSZ2F1V3NTZ1RSYS9HUGJv?=
 =?utf-8?B?OWdQbDZPMXFZTGdOeWRkemJIbk5vcXJMSURvR2FZV0c1MTRZa0VvUUh4NUE0?=
 =?utf-8?B?bUNWRVVpWExvTmNBa2t4Rkl5eURDaFErNFpzaVA3NWtSTFY4VmExZGhtYnpy?=
 =?utf-8?B?OUFqWk9sT0tFM3VzdmpjWmFpQUdXRXk2UForSnliejRHMlN6OVVqb2VYaEEy?=
 =?utf-8?B?M2hwT2s5cXBacGNhVFcwRlRnY3IwUmxPbnFXSGRKSkVsYVZCTG82cUtMYWhD?=
 =?utf-8?B?K0JvMnk4TkMyb1luVnpBQXhLSThET0ZwTVZJdnNiZFNuR2ZMVmZWbXVZcERY?=
 =?utf-8?B?d25IQ0trU1ZmUzB3d3MzSURLbFl3ZHpBYTFHMnZGdFNVQzcyV1V6a05VY01k?=
 =?utf-8?B?dUkrcG9oT0puSU9BcmFobEFYUWgxMmcrcklzaUlGMkRNZnNicjBtcThCWGtv?=
 =?utf-8?B?OFZsZEZaK0hxcE5FV2NVNmJnOWdwdTBVZFhHMmJPQzIvVnBoU29ITXh0cFJo?=
 =?utf-8?B?bHR3d2FRWmFrZ21td09wSTZMc0ExWlRxS3BENGtUSUtOMjRVU2daV0ZkWjFm?=
 =?utf-8?B?MmJKU2tNNlpPZXdVaDhIYjJOUDlYSkRmR29QNmdsLzFXK3pZSm9XWEtReHdj?=
 =?utf-8?B?aFh1U0xWODc3TWZNVWJ3TGVVUE9qVi9hSjVFYXYvSnZaaVdnL29vYk4yS2tT?=
 =?utf-8?B?TW5veHJIeGNCaENBUjN5Y0lOZFhoaEFYVkVYY29DNmE0eFVNdGhYRTRRV1FF?=
 =?utf-8?B?TzQyZ0grbkJidm9VM2VxSURYWUpZTTBZV3EwbFdkZHBZMEliV0FzeEpMRWJR?=
 =?utf-8?B?cW5WWUtrTzdpUEl2NlRGeUZtcXJPTDNOWVhCaTljbmZGRFhFSmF0eGMyTDN4?=
 =?utf-8?B?Y1hnV29aM3k2T25RTzN5RXU5emlDeFM1US96L1p4NGgxS1BKUURuR20zem1O?=
 =?utf-8?B?VFYzaFJUMDdqcStYQWxCY2VGREVCUk1hMWY4SnY3QjRDNHBoeGtvTjFLZkJr?=
 =?utf-8?B?NUozaXd5Z25abGVNMnFVL2VoOFQ2ZTlkMEdEK2w0ZmN5eGxyTUM1V2J1UnNh?=
 =?utf-8?B?L2s1ZEExT0xrVWxqcnpwb2pkbFovam9nakx2QW1IYXhyWjBZWGlLRlp5aXdL?=
 =?utf-8?B?UC9TYUZab3hBTWpCcXRiKzhpV256dzBhb2srUEp3YUJJK20xUktaaTl1TnND?=
 =?utf-8?B?czlYUk81SE5sRjdweU5Vd1pNQTBKL0p2TUtiUnQySkNlWFZKeW9YTHVNOEFJ?=
 =?utf-8?B?U0lWM1NobllQMDRUQTg2Uzc0MWkwVk15bzNEM2Y2UUxRV1YyeVh0QmF1RUNz?=
 =?utf-8?B?NXpRTk51THhQQk1YK20rT2ZqUTJtcWM1VjJROHdqWUdvVDVIeUFNenp5SFRn?=
 =?utf-8?B?NXVuNVNvNFZ2amF4SGlSZTFTU0pHTk16S1FTMjhHQ3ZLQjlJaFUwUWo4ZUt0?=
 =?utf-8?B?eStsdU9Xa2lxM0lZTmxUVFdpajdJeVVuUzRia1lBNUpUem9QQW9Fdy9QZ0FY?=
 =?utf-8?B?dk9MdjJhL2hhc2JKK25IdW1vbVFzcHRnRlRLOGZnL0FaU1FVOEFiVm1peGl1?=
 =?utf-8?B?L214aG82dHBSck5wRFFxYVN3REE3dzV3ajNFVzg1RHkvWlpCV2dtYjlUNFBT?=
 =?utf-8?B?bFNhdW1pQ0dtWERHZkVKVVU3RHFhMTVRck9wV2ZvREV1M2xzeGxPQ0l0c3Zt?=
 =?utf-8?Q?wcJJ/7Ey+IL1wv5rS00jlc9xa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb9efcc-d1eb-4fb5-0345-08ddb870d3d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 07:28:08.9861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGbTVokoUVEVfJbS4i54tQMeeCFHH2zYIIwSieT4OwqZUB2+Y96lIxpWOZa+UMoB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431
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

Clear NAK to removing this!

The amdgpu_flush function is vital for correct operation.

The intention is to block closing the file handle in child processes and wait for all previous operations to complete.

Regards,
Christian.

On 01.07.25 07:35, YuanShang Mao (River) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> @Yang, Philip
>> I notice KFD has another different issue with fclose -> amdgpu_flush,
>> that fork evict parent process queues when child process close the
>> inherited drm node file handle, amdgpu_flush will signal parent process
>> KFD eviction fence added to vm root bo resv, this cause performance drop
>> if python application uses lots of popen.
> 
> Yes. Closing inherited drm node file handle will evict parent process queues, since drm share  vm with kfd.
> 
>> function amdgpu_ctx_mgr_entity_flush is only called by amdgpu_flush, can
>> be removed too.
> 
> Sure. If we decide to remove amdgpu_flush.
> 
> @Koenig, Christian @Deucher, Alexander, do you have any concern on removal of amdgpu_flush?
> 
> Thanks
> River
> 
> 
> -----Original Message-----
> From: Yang, Philip <Philip.Yang@amd.com>
> Sent: Friday, June 27, 2025 10:44 PM
> To: YuanShang Mao (River) <YuanShang.Mao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; cao, lin <lin.cao@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: delete function amdgpu_flush
> 
> 
> On 2025-06-27 01:20, YuanShang Mao (River) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Currently, amdgpu_flush is used to prevent new jobs from being submitted in the same context when a file descriptor is closed and to wait for existing jobs to complete. Additionally, if the current process is in an exit state and the latest job of the entity was submitted by this process, the entity is terminated.
>>
>> There is an issue where, if drm scheduler is not woken up for some reason, the amdgpu_flush will remain hung, and another process holding this file cannot submit a job to wake up the drm scheduler.
> 
> I notice KFD has another different issue with fclose -> amdgpu_flush,
> that fork evict parent process queues when child process close the
> inherited drm node file handle, amdgpu_flush will signal parent process
> KFD eviction fence added to vm root bo resv, this cause performance drop
> if python application uses lots of popen.
> 
> [677852.634569] amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
> [677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
> [677852.634820]  dma_fence_wait_timeout+0x3a/0x140
> [677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
> [677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
> [677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
> [677852.635208]  filp_flush+0x38/0x90
> [677852.635213]  filp_close+0x14/0x30
> [677852.635216]  do_close_on_exec+0xdd/0x130
> [677852.635221]  begin_new_exec+0x1da/0x490
> [677852.635225]  load_elf_binary+0x307/0xea0
> [677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
> [677852.635235]  ? ima_bprm_check+0xa2/0xd0
> [677852.635240]  search_binary_handler+0xda/0x260
> [677852.635245]  exec_binprm+0x58/0x1a0
> [677852.635249]  bprm_execve.part.0+0x16f/0x210
> [677852.635254]  bprm_execve+0x45/0x80
> [677852.635257]  do_execveat_common.isra.0+0x190/0x200
> 
>>
>> The intended purpose of the flush operation in linux is to flush the content written by the current process to the hardware, rather than shutting down related services upon the process's exit, which would prevent other processes from using them. Now, amdgpu_flush cannot execute concurrently with command submission ioctl, which also leads to performance degradation.
> 
> fclose -> filp_flush -> fput, if fput release the last reference of drm
> node file handle, call amdgpu_driver_postclose_kms ->
> amdgpu_ctx_mgr_fini will flush the entities, so amdgpu_flush is not needed.
> 
> I thought to add workaround to skip amdgpu_flush if (vm->task_info->tgid
> != current->group_leader->pid) for KFD, this patch will fix both gfx and
> KFD, one stone for two birds.
> 
> function amdgpu_ctx_mgr_entity_flush is only called by amdgpu_flush, can
> be removed too.
> 
> Regards,
> 
> Philip
> 
>>
>> An example of a shared DRM file is when systemd stop the display manager; systemd will close the file descriptor of Xorg that it holds.
>>
>> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: amdgpu_ctx_get: locked by other task times 8811
>> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: owner stack:
>> Jun 11 16:24:24 ubuntu2404-2 kernel: task:(sd-rmrf)       state:D stack:0     pid:3407  tgid:3407  ppid:1      flags:0x00004002
>> Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __schedule+0x279/0x6b0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  schedule+0x29/0xd0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amddrm_sched_entity_flush+0x13e/0x270 [amd_sched]
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_mgr_entity_flush+0xd6/0x200 [amdgpu]
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_flush+0x29/0x50 [amdgpu]
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_flush+0x38/0x90
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_close+0x14/0x30
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __close_range+0x1b0/0x230
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_close_range+0x17/0x30
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x1e0f/0x25f0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __count_memcg_events+0x86/0x160
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? count_memcg_events.constprop.0+0x2a/0x50
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? handle_mm_fault+0x1df/0x2d0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_user_addr_fault+0x5d5/0x870
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit_to_user_mode+0x43/0x250
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit+0x43/0x50
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? exc_page_fault+0x96/0x1c0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x762b6df1677b
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffdb20ad718 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000762b6df1677b
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 0000000000000000 RSI: 000000007fffffff RDI: 0000000000000003
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffdb20ad730 R08: 0000000000000000 R09: 0000000000000000
>> Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000007
>> Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>
>> Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: current stack:
>> Jun 11 16:24:24 ubuntu2404-2 kernel: task:Xorg            state:R  running task     stack:0     pid:2343  tgid:2343  ppid:2341   flags:0x00000008
>> Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  sched_show_task+0x122/0x180
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_get+0xf6/0x120 [amdgpu]
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_cs_ioctl+0xb6/0x2110 [amdgpu]
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? update_cfs_group+0x111/0x120
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? enqueue_entity+0x3a6/0x550
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl_kernel+0xbc/0x120
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl+0x2f6/0x5b0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [amdgpu]
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_drm_ioctl+0x4e/0x90 [amdgpu]
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_ioctl+0xa3/0xf0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x11ad/0x25f0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? ksys_read+0xe6/0x100
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? idr_find+0xf/0x20
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_array_free+0x5a/0x80
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_reset_ioctl+0xbd/0xd0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/0x10
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl_kernel+0xbc/0x120
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __check_object_size.part.0+0x3a/0x150
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? _copy_to_user+0x41/0x60
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl+0x326/0x5b0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/0x10
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? kvm_clock_get_cycles+0x18/0x40
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pm_runtime_suspend+0x7b/0xd0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? amdgpu_drm_ioctl+0x70/0x90 [amdgpu]
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __x64_sys_ioctl+0xbb/0xf0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x250
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x250
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  ? sysvec_apic_timer_interrupt+0x57/0xc0
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x7156c3524ded
>> Jun 11 16:24:24 ubuntu2404-2 kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffe4afcc410 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 0000578954b74cf8 RCX: 00007156c3524ded
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 00007ffe4afcc4f0 RSI: 00000000c0186444 RDI: 0000000000000012
>> Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffe4afcc460 R08: 00007ffe4afcc7a0 R09: 00007ffe4afcc4b0
>> Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000578954b862f0 R11: 0000000000000246 R12: 00000000c0186444
>> Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000012 R14: 0000000000000060 R15: 0000578954b46380
>> Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>
>>
>> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
>>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 -------------
>>   1 file changed, 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 2bb02fe9c880..ee6b59bfd798 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2947,22 +2947,9 @@ static const struct dev_pm_ops amdgpu_pm_ops = {
>>          .runtime_idle = amdgpu_pmops_runtime_idle,  };
>>
>> -static int amdgpu_flush(struct file *f, fl_owner_t id) -{
>> -       struct drm_file *file_priv = f->private_data;
>> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>> -       long timeout = MAX_WAIT_SCHED_ENTITY_Q_EMPTY;
>> -
>> -       timeout = amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr, timeout);
>> -       timeout = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
>> -
>> -       return timeout >= 0 ? 0 : timeout;
>> -}
>> -
>>   static const struct file_operations amdgpu_driver_kms_fops = {
>>          .owner = THIS_MODULE,
>>          .open = drm_open,
>> -       .flush = amdgpu_flush,
>>          .release = drm_release,
>>          .unlocked_ioctl = amdgpu_drm_ioctl,
>>          .mmap = drm_gem_mmap,
>> --
>> 2.25.1
>>

