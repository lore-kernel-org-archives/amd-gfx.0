Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5439FC5AE49
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0BE10E837;
	Fri, 20 Feb 2026 19:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PRfSNDGc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8BB10E84A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jn1dvdOg7dS2rjGYNYjC5HOR1fzmGR8WmA6XYgJe1PuhtH5Xf/q+KIaIYdVRbcC6D/CVZcIXIpBr0Tgb9e9c1v8xmNH0xOgLgaMVhctfyQOHGxEWo2Gh341YoXmelgXzOL0gkN0zP59VfjCZ5TVzthD4GDpTnBqt2vKLc8CAftTQjiZC5GRTx+3Y8NWjQOnOKjrIXcTNdsg1qfu1xDL3Lr4iyHkas+oE1Q292nPpLkldLy+s0usI+YUwFxcBZmK7hzziF7Wf3lWhG4OgKOSU6achsKO9pE84DQ4iPzRP5XOHC2kWL+Xd/SwWpHaAtyJQ1hlq+DcUnT7J92SWzpWUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcctTczCtV2hSvkglrQC7hYyjpj9jPR7gOGx2ldoS2Y=;
 b=Byipo2poK+nl5KL96qQ9Sap4UWlcQnCMVUDtG8AjHKmB+z3SuSpzSaSpf1QfLPTTToiVotIHl+NGCSByWts3droZp9rmVLxIXHQrgK1IzwNVVC0GzG15NpIodp60QKvXSrytv+SCdzLu1eQqkdbHUrfnle2vaW1WtQZAcXqdlHkQH60wMj0UunsvYAAY+78DHIo3NjSyJ3hrnANDxbzGcVky79Q7XRkvtt+lK2eg1HHQGYYtRvVi9ALgvGaxMurRI4JwCKkJuVp5LkSn7ytJQMma+J/mH8kjFclNpN/NKZNYYLcd98qqPpVtlReWtPhmHRRdeC79n2vi59tc7mcDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcctTczCtV2hSvkglrQC7hYyjpj9jPR7gOGx2ldoS2Y=;
 b=PRfSNDGcux534gfmp/VPyqJ85z3pFDiVY53klR8coA7imMGdn9YumZP4VtX4xaeGklCUiTae4JEpkXULzHdiEWT+X+axDPr34lPUF5NWcf+hgfTVuOT+mRpBbeNLZRQQQJ2p0yftBSpJItnvdeScjkuGLHXb6XfL4UqRg/F4B4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:51:48 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 19:51:48 +0000
Content-Type: multipart/alternative;
 boundary="------------NiYXwYhRyLjikKTFT10jtegk"
Message-ID: <840ac8de-f27f-438c-ad45-bcd0c76dccfe@amd.com>
Date: Fri, 20 Feb 2026 14:51:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add an option to allow gpu partition allocate
 all available memory
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260217162424.991875-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260217162424.991875-1-xiaogang.chen@amd.com>
X-ClientProxiedBy: YQBPR0101CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::34) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fa3aaa-6f99-49d9-aae3-08de70b97bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0dFYm9qVExGZU54SjJLdE5NczdwTktFcTF1MzJMd25PVHhoanVBUUxhSWdu?=
 =?utf-8?B?cnA1cGc2Y0RRK2libzBUMGRLNWNPemZuYitRWHF2WVprZVpiRnJtNkV6aG1j?=
 =?utf-8?B?R2NBOXBTZXVQNlBwY3pBU3ZzbEpHU2FjalVmRFRsRmlFK2pjRkdPZUp2OUN5?=
 =?utf-8?B?VjY4bkZvL0hlRXN0WDFvNndyQmhxS1ZpWnRJaEFyUG5uejNpZ0FIVldTWFM0?=
 =?utf-8?B?eS9uVEZjK0lLck5rekxqeEcyVlN4RjNYVXRhMzQ4UkEvSHRMUldObldnUWpM?=
 =?utf-8?B?T1cvMFBIVzNKd2J0ZXY3N3Y1QVZZVm9sSWM5QUloMGpUbUpqUVc1cmZ0aFAw?=
 =?utf-8?B?UFgzUWJsWkp0ZnFQeUtLVHllTHVQeXFnbE5FYkZoWU9xMktYTk43OGlKM2lX?=
 =?utf-8?B?SEpWRElLOXpuTmc0TEU2TVhINmpXRGxOa3ZqVi9BczFOQjJOdEJRQ3pIUnRU?=
 =?utf-8?B?cVJMdUE4MVh5MFNaV3V3NG15cnF1VmM3Rkt5SC9MbUlONTEwU3RHKy9RSTMy?=
 =?utf-8?B?WmhHdUgzK3lidlhWNnBaS2VKUzlVQ0xMaUtaRFdSV2VrSHZsVlgvZU5SY1Z6?=
 =?utf-8?B?Q0o1ZjdpVzI4VDljcUlXNjVZaUpYUVphcktFRlpKeE9ibHJvd0o2T0dEaVNC?=
 =?utf-8?B?NkRqUms2N1ZETzR0ZnNyNlNtdkYxR1pKNzFCeFNzd3Q0S1JyeUh5eEdxZktk?=
 =?utf-8?B?OE9IT29CTWFVTDJwMGFOZXgzdGM1b3dhUXA4ZEFPdXA4TVV2S296Z1h4Z2M1?=
 =?utf-8?B?RW02Skd6T041cTNnU044WGFxOTk0YTVkR0xaV25wWG1DS2tCQ2lxZ3hsRTlX?=
 =?utf-8?B?a09NUWRXOWYxVzdkUzBXNzdPSFJtUDd0bkcvSGJkc3VmZHVtVWhSNFJDR3N1?=
 =?utf-8?B?cHRCTkc1aG9HMGNxc0haMTA0M3NpdmZUaGhucEJPNUNLNGxtM1Blckk5akpw?=
 =?utf-8?B?dExNR2drUGlYYWdnTHltWlZka2MrcTZoT051dXMxbkpaUUc3bWlHZWhvZ3dp?=
 =?utf-8?B?WUxtczg2RzRGaUw3SlhCR3Y3dTFRYnZhblRUT0twVlhQeHBDK3B0Wm9ETWZS?=
 =?utf-8?B?cXBxMWZJN3VOdGNhZ1J3N2YycEQrUWZHeG5aUnRXVDFWOC9Pd3NVUXRZbGVO?=
 =?utf-8?B?eDNvRkIvQWpzbXJpNndXTklvbmxiQUpLNGVaK3pCVzlndFVhZURiWm9PTHRZ?=
 =?utf-8?B?NDJ1RmppVjlxQmdWL3pDbGRubkJFQW5sajZhV2l5NU5rVVN1cnhlZzZGeUsw?=
 =?utf-8?B?dzk5REJEZW1oQVZBcEM5eFVVWVFPR1dYc1o2Q2UwaXM0djkrMmJYUWJUZXpT?=
 =?utf-8?B?bWZaN1hVbFlpMkExWmxPZ3JqQ2NFTUdBMWM3WGszZVBFZlhnRDRCNExCY3pC?=
 =?utf-8?B?Sk83VURYNVdPRldhcWloYXZDUGF4V1lCR2tGRVJWdGJhdmszYjAwV2J6ZTBC?=
 =?utf-8?B?L2MvMlgwOXhGYVNnL1N5eEtXWkpWOHRaNFFxQ0JIU29aZ1NuMUlHM0JXVDI3?=
 =?utf-8?B?dUFlYTNFaUtTdlJPSWJ2UzhQRUZCVUxZS1V2cnlCaGkxVFBaK0daSzVQUk81?=
 =?utf-8?B?K2JEZmJ3alJlcEM5MDV1WkZHckJrVnFlMVpoUzRzdzNqOXoyT1E0b3RsZlJq?=
 =?utf-8?B?dzVyS3RSR0RSOVZ6QnVUT2hhemZ2YklQL3UrYXI0NkxpdVVqU2N4cnhOT245?=
 =?utf-8?B?ZFJNcW1CbmowcWFVTCtzRVg1cnozZi9aU2hCQU9Pa2NPZ2l2alNqckhIK2d6?=
 =?utf-8?B?MVVzRDd2dU5sdnNrdGdQaFk4NTE3N2RIYm5HMGgyTTA5YnFsQlVvN2phS2RT?=
 =?utf-8?B?RFloejgranlTb2FUUzc3NmF3c1NtQTRpeUtCOTVSMVhlYy9McEdUbjR2WUoz?=
 =?utf-8?B?QVFHL2Jldy9NcXBrSXFrZTFVbnljUXh2WFZxcnVnYyswVXo2Tm8xTHRSZWxu?=
 =?utf-8?B?NjhkQ1g5VHR5RmN1WXFONVhibktjRjJqWCtkWkVQeWxiakJFNVViaHQyYUt6?=
 =?utf-8?B?ZHZFNTNxbWJVbDhkeXpkTWExTER5TGNoVHEwVm81Q0pBdDhNd2dRS2VOaWNQ?=
 =?utf-8?B?Q0oyMEQrM2pGdEE4VUhIOUZBVGh5YStUWXFIWDhGd1lmRXBYU0Y4c1dBRVVN?=
 =?utf-8?Q?9Tgo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU02WmdjMCtGTXB0SURSazB5Vm0xeERyNnB6bGlBdGNxN3RQM1V6T3M1Z1dV?=
 =?utf-8?B?TXdJKzFXVnJILy9WdUw5REJOdkhhNmo4SWl6eUtSSUpvdUxiMCszZWRZV1gr?=
 =?utf-8?B?dmR0NWRpZlB2NHNiemdJUFNNdTQ3UDVaU3BhaEFFbnFzaHkySGxaQUFyT2U4?=
 =?utf-8?B?VE1ISlRxNmhsQ0svcGplL2xMRnNzYWE4ckJKUUk3RVVsdnRybmFLZkoxZTl3?=
 =?utf-8?B?MjhzN2JFdHcvSHUxNzhsb3J6TGt3cTJLRmV2S2FtK1dSMm81anFSMjBCV3d2?=
 =?utf-8?B?NHgwZ1dzekY1TE5DdmQwaEJmU1djaWlhUi82aVgzdDZnSEk0Zmdodjl3VGFQ?=
 =?utf-8?B?SHYrYm9YOVdjeHNZcWRSQmN1TkNFZkEvbi96ZDhEWmk5MlBPSVExTWY5RjQz?=
 =?utf-8?B?ZCtES0h4eUV4ZW9JenNHNEcyelU3a1ZuaVVkR0NLK1JaaEtwbW1mWXhZVFoy?=
 =?utf-8?B?dU1oTElMcS90RHBBU28rK2xBdW1pbFdDVXVubC9XUytUcnVZbVEwSjlYZjFO?=
 =?utf-8?B?Sy9ienY5LzRRSkViTndmWlFCalBLZ21jQ2Y3NS9INU92Q241cWhIMHVmTVhT?=
 =?utf-8?B?dzhqWWFhRWRad0FOeEN2NXRRTkk2UEE4ay9KMjRqblEyeUVNTFJZZkFEOEpJ?=
 =?utf-8?B?T2ZLQXdmeHI2ejVPZ3VZRUVhdVY5N1JWb1A4RzM1cDFjNGxQM21QTTBmNzBX?=
 =?utf-8?B?Q3g0QjdjczF1WmNiUWhoa3J1dW0zV0I5QUFsd04zYUh0a242eUQ3ODFIc3JX?=
 =?utf-8?B?TXNtUXh4YzFJclZIK3h1dG1uL1JqVlMwTHhJSnFuWVNDQU41NmZiZXdzQ3dW?=
 =?utf-8?B?N3FKdS9KNENONWhlZnJIcjhQUGtvSW0rU3VvN1ZPTkF5V1RnTVZ3UUU4SXlv?=
 =?utf-8?B?VlE3K1BtSDM5SkRYU3hCT0s0N3ZJbGxPTDVrNTJTRUU3RndZeW5uVWgzQkl6?=
 =?utf-8?B?T1U5NngyUG9XNnlNNWZ4N1pxZnNBTzgvcUIxMXpac1F5RGFEaHlKMW9aZTBa?=
 =?utf-8?B?dndHL0FFdnljKzBXbzdDTlFzYTQ2LzNUdkl2R2R5WlFzZTRkWFE5TGh0YS80?=
 =?utf-8?B?RTBmRkNUcktvWklVOE9EMGprTFRsakxqVG9uMzl1TlVPaDJQbkZuelFVQkVT?=
 =?utf-8?B?WWoyT0FrNmc2QkVodGpieDZOLzFVQmRoU1lLVnIzRUp5VERGbkhZTEY3TDVs?=
 =?utf-8?B?L3o1L1JvSktodnJyQ0VrNDZBNWlDckFLVU9HR1pabXVEeFVVQjlwcXlPRm1B?=
 =?utf-8?B?WFhtS1E0b09zZmlHZ3BleU1EMWswK3Y2SUxHU1UwQ3JPM2ZzSWlkMjlzMld1?=
 =?utf-8?B?VkF3a1VDUHR2bW5jTUZPaml0SVRjVW85MUgzMmE3YXZFZ1hTNlRYVzJyOFRL?=
 =?utf-8?B?YlJ5Mk9Ha1RZRXQ5blh3cTdRQWYwOWl0ZjIrV3NYTng5SktLaW1PbG5ETDlO?=
 =?utf-8?B?UHdraFdwTUhtWlhLRDhqSjlVRVZiWjdDekZmK0psT1paL1JWb3hZeVJNQTdE?=
 =?utf-8?B?RVdXcDIvOGtLVk14WmhnRnkyc1R3dXlYLytiaXl6NnJSWFdvWjdQbDRVcVRZ?=
 =?utf-8?B?eU5OeitJbkUwcDBna3lFdU9Ha1BPcmp6ZTE3dWc1c3QwM1QxZDBoVjROd3Vw?=
 =?utf-8?B?NDQvcGhwZENXZldwbXhSV0pNbUtaMFBlU2VhbVl2TE9xZXZEVjd2cENFWWIx?=
 =?utf-8?B?ZWY5UHczT0lmZzkxTEJNQlNDRDk4c0swY0hieGZtbldJay9KWlV3djY3V3lm?=
 =?utf-8?B?dk9oU0hJdWZkVFAyb2YrbXlvdFJBNC82a094bWIxRGhyQ3dqOTZGZ3NqT1FB?=
 =?utf-8?B?eGtBN1h4WWY2K0hxUEhBdzJuUmxzOTViWXZZQ1ZxTHFiWEQ0ck1NMFVSanpv?=
 =?utf-8?B?bGNFWk0vQjdTTExtdk9XdE84bWtCZXRXOGlvTzBnbURUSFFoVzlkRU9FWE9u?=
 =?utf-8?B?QkM1bnJuUjNLazNDQmw5a0xZMStlUUtJREJ1RUI5ZWtFT2N2WGhIZi95K0Zn?=
 =?utf-8?B?OVRTZWtWUzZvaHVBQVBtWGNMUHBNWjZUWklOaXprVXRCMWcrcEY5NkFwZ1RF?=
 =?utf-8?B?MFMycmZtOVYwbkpvRVhoZUdRQTRBUVFMUElzcTIvckNMd2xBd2w2UE9pWm91?=
 =?utf-8?B?YzZXajFVWDdXUUEvLzdoT1BkS00xNE5qa09nUm9RaU1ibHllaVRuclpNSFZW?=
 =?utf-8?B?Y1Y2R1BSY2taZEFsbit5YkRmWU1HZEdzRmRwUUo0NllESEFkeVU5K2tWeDAv?=
 =?utf-8?B?aUEzVk0xTVl1cEQxdnF2QWtlU1ZDeURWSDJ5MlNWOUdhTGNSMit0THhMOGFU?=
 =?utf-8?Q?t6M2F0sCohptpOy9Tq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa3aaa-6f99-49d9-aae3-08de70b97bbb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:51:48.2192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fvp1fhHAsVjd+YnoSDBPKzB41ihRvTv411q5TRzkOj31DiTx0B22GVsyuaKAoUk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621
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

--------------NiYXwYhRyLjikKTFT10jtegk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-02-17 11:24, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> Current driver reports and limits memory allocation for each partition equally
> among partitions using same memory partition. Application may not be able to
> use all available memory when run on a partitioned gpu though system still has
> enough free memory.
>
> Add an option that app can use to have gpu partition allocate all available
> memory.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 43 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 17 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  2 +
>   5 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3bfd79c89df3..006883c31342 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -805,7 +805,10 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
>   		} else {
>   			tmp = adev->gmc.mem_partitions[mem_id].size;
>   		}
> -		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
> +
> +		if (adev->xcp_mgr->mem_alloc_mode == AMDGPU_PARTITION_MEM_ALLOC_EVEN)
> +			do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
> +
I think amdgpu_amdkfd_reserve_mem_limit should change to account total 
vram used, to prevent vram
over-commitment for not ALLOC_EVEN mode.
>   		return ALIGN_DOWN(tmp, PAGE_SIZE);
>   	} else if (adev->apu_prefer_gtt) {
>   		return (ttm_tt_pages_limit() << PAGE_SHIFT);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index cab3196a87fb..1da46eeb3f2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1580,6 +1580,40 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
>   	return count;
>   }
>   
> +static ssize_t amdgpu_gfx_get_compute_partition_mem_alloc_mode(
> +						struct device *dev, struct device_attribute *addr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	int mode = adev->xcp_mgr->mem_alloc_mode;
> +
> +	/* Only minimal precaution taken to reject requests while in reset.*/
> +	if (amdgpu_in_reset(adev))
> +		return -EPERM;
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  amdgpu_gfx_compute_mem_alloc_mode_desc(mode));
> +}
> +
> +
> +static ssize_t amdgpu_gfx_set_compute_partition_mem_alloc_mode(
> +						struct device *dev, struct device_attribute *addr,
> +						const char *buf, size_t count)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	if (!strncasecmp("EVEN", buf, strlen("EVEN")))
> +		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_EVEN;
> +	else if (!strncasecmp("ALL", buf, strlen("ALL")))
> +		adev->xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_ALL;
> +	else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
>   static const char *xcp_desc[] = {
>   	[AMDGPU_SPX_PARTITION_MODE] = "SPX",
>   	[AMDGPU_DPX_PARTITION_MODE] = "DPX",
> @@ -1935,6 +1969,10 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
>   static DEVICE_ATTR(compute_reset_mask, 0444,
>   		   amdgpu_gfx_get_compute_reset_mask, NULL);
>   
> +static DEVICE_ATTR(compute_partition_mem_alloc_mode, 0644,
> +		   amdgpu_gfx_get_compute_partition_mem_alloc_mode,
> +		   amdgpu_gfx_set_compute_partition_mem_alloc_mode);
> +
>   static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
> @@ -1955,6 +1993,11 @@ static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> +	r = device_create_file(adev->dev,
> +			       &dev_attr_compute_partition_mem_alloc_mode);
> +	if (r)
> +		return r;
> +
>   	if (xcp_switch_supported)
>   		r = device_create_file(adev->dev,
>   				       &dev_attr_available_compute_partition);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 720ed3a2c78c..f5713891f205 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -71,6 +71,11 @@ enum amdgpu_gfx_partition {
>   	AMDGPU_AUTO_COMPUTE_PARTITION_MODE = -2,
>   };
>   
> +enum amdgpu_gfx_partition_mem_alloc_mode {
> +	AMDGPU_PARTITION_MEM_ALLOC_EVEN = 0,
> +	AMDGPU_PARTITION_MEM_ALLOC_ALL  = 1,
> +};
> +
>   #define NUM_XCC(x) hweight16(x)
>   
>   enum amdgpu_gfx_ras_mem_id_type {
> @@ -676,4 +681,16 @@ static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>   	}
>   }
>   
> +static inline const char *amdgpu_gfx_compute_mem_alloc_mode_desc(int mode)
> +{
> +	switch (mode) {
> +	case AMDGPU_PARTITION_MEM_ALLOC_EVEN:
> +		return "EVEN";
> +	case AMDGPU_PARTITION_MEM_ALLOC_ALL:
> +		return "ALL";
> +	default:
> +		return "UNKNOWN";
> +	}
> +}
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 73250ab45f20..a2d50f90a066 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -181,6 +181,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
>   	}
>   
>   	xcp_mgr->num_xcps = num_xcps;
> +	xcp_mgr->mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_EVEN;
>   	amdgpu_xcp_update_partition_sched_list(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 8058e8f35d41..878c1c422893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -132,6 +132,8 @@ struct amdgpu_xcp_mgr {
>   	struct amdgpu_xcp_cfg *xcp_cfg;
>   	uint32_t supp_xcp_modes;
>   	uint32_t avail_xcp_modes;
> +	/* used to determin KFD memory alloc mode for each partition */
> +	uint32_t mem_alloc_mode;
rename to mem_capping_mode?

Regards,
Philip
>   };
>   
>   struct amdgpu_xcp_mgr_funcs {

--------------NiYXwYhRyLjikKTFT10jtegk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-02-17 11:24, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260217162424.991875-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

Current driver reports and limits memory allocation for each partition equally
among partitions using same memory partition. Application may not be able to
use all available memory when run on a partitioned gpu though system still has
enough free memory.

Add an option that app can use to have gpu partition allocate all available
memory.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 43 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 17 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  2 +
 5 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3bfd79c89df3..006883c31342 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -805,7 +805,10 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 		} else {
 			tmp = adev-&gt;gmc.mem_partitions[mem_id].size;
 		}
-		do_div(tmp, adev-&gt;xcp_mgr-&gt;num_xcp_per_mem_partition);
+
+		if (adev-&gt;xcp_mgr-&gt;mem_alloc_mode == AMDGPU_PARTITION_MEM_ALLOC_EVEN)
+			do_div(tmp, adev-&gt;xcp_mgr-&gt;num_xcp_per_mem_partition);
+</pre>
    </blockquote>
    I think amdgpu_amdkfd_reserve_mem_limit should change to account
    total vram used, to prevent vram<br>
    over-commitment for not ALLOC_EVEN mode.<br>
    <blockquote type="cite" cite="mid:20260217162424.991875-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
 	} else if (adev-&gt;apu_prefer_gtt) {
 		return (ttm_tt_pages_limit() &lt;&lt; PAGE_SHIFT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index cab3196a87fb..1da46eeb3f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1580,6 +1580,40 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 	return count;
 }
 
+static ssize_t amdgpu_gfx_get_compute_partition_mem_alloc_mode(
+						struct device *dev, struct device_attribute *addr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int mode = adev-&gt;xcp_mgr-&gt;mem_alloc_mode;
+
+	/* Only minimal precaution taken to reject requests while in reset.*/
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+
+	return sysfs_emit(buf, &quot;%s\n&quot;,
+			  amdgpu_gfx_compute_mem_alloc_mode_desc(mode));
+}
+
+
+static ssize_t amdgpu_gfx_set_compute_partition_mem_alloc_mode(
+						struct device *dev, struct device_attribute *addr,
+						const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!strncasecmp(&quot;EVEN&quot;, buf, strlen(&quot;EVEN&quot;)))
+		adev-&gt;xcp_mgr-&gt;mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_EVEN;
+	else if (!strncasecmp(&quot;ALL&quot;, buf, strlen(&quot;ALL&quot;)))
+		adev-&gt;xcp_mgr-&gt;mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_ALL;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
 static const char *xcp_desc[] = {
 	[AMDGPU_SPX_PARTITION_MODE] = &quot;SPX&quot;,
 	[AMDGPU_DPX_PARTITION_MODE] = &quot;DPX&quot;,
@@ -1935,6 +1969,10 @@ static DEVICE_ATTR(gfx_reset_mask, 0444,
 static DEVICE_ATTR(compute_reset_mask, 0444,
 		   amdgpu_gfx_get_compute_reset_mask, NULL);
 
+static DEVICE_ATTR(compute_partition_mem_alloc_mode, 0644,
+		   amdgpu_gfx_get_compute_partition_mem_alloc_mode,
+		   amdgpu_gfx_set_compute_partition_mem_alloc_mode);
+
 static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev-&gt;xcp_mgr;
@@ -1955,6 +1993,11 @@ static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = device_create_file(adev-&gt;dev,
+			       &amp;dev_attr_compute_partition_mem_alloc_mode);
+	if (r)
+		return r;
+
 	if (xcp_switch_supported)
 		r = device_create_file(adev-&gt;dev,
 				       &amp;dev_attr_available_compute_partition);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 720ed3a2c78c..f5713891f205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -71,6 +71,11 @@ enum amdgpu_gfx_partition {
 	AMDGPU_AUTO_COMPUTE_PARTITION_MODE = -2,
 };
 
+enum amdgpu_gfx_partition_mem_alloc_mode {
+	AMDGPU_PARTITION_MEM_ALLOC_EVEN = 0,
+	AMDGPU_PARTITION_MEM_ALLOC_ALL  = 1,
+};
+
 #define NUM_XCC(x) hweight16(x)
 
 enum amdgpu_gfx_ras_mem_id_type {
@@ -676,4 +681,16 @@ static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 	}
 }
 
+static inline const char *amdgpu_gfx_compute_mem_alloc_mode_desc(int mode)
+{
+	switch (mode) {
+	case AMDGPU_PARTITION_MEM_ALLOC_EVEN:
+		return &quot;EVEN&quot;;
+	case AMDGPU_PARTITION_MEM_ALLOC_ALL:
+		return &quot;ALL&quot;;
+	default:
+		return &quot;UNKNOWN&quot;;
+	}
+}
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 73250ab45f20..a2d50f90a066 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -181,6 +181,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 	}
 
 	xcp_mgr-&gt;num_xcps = num_xcps;
+	xcp_mgr-&gt;mem_alloc_mode = AMDGPU_PARTITION_MEM_ALLOC_EVEN;
 	amdgpu_xcp_update_partition_sched_list(adev);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 8058e8f35d41..878c1c422893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -132,6 +132,8 @@ struct amdgpu_xcp_mgr {
 	struct amdgpu_xcp_cfg *xcp_cfg;
 	uint32_t supp_xcp_modes;
 	uint32_t avail_xcp_modes;
+	/* used to determin KFD memory alloc mode for each partition */
+	uint32_t mem_alloc_mode;</pre>
    </blockquote>
    rename to mem_capping_mode?<br>
    <br>
    Regards,<br>
    Philip<br>
    <blockquote type="cite" cite="mid:20260217162424.991875-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 };
 
 struct amdgpu_xcp_mgr_funcs {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------NiYXwYhRyLjikKTFT10jtegk--
