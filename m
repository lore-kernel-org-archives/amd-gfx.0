Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC64CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 07:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FABB10E67D;
	Wed,  1 Oct 2025 07:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0meBe7JO";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD5310E67D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 07:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxEQrR8NR0cMeaKCfnGp0K9n0n0p8J2VKyJLm8nvYiJvby4NYwEIptMf5ZW8FtiaW27O+TAuLjdpyUlHlIt3LIQwjRbh/yVFrkDbMov3m8aPvrF9cJM/c11p217Sw0vq1yX/+U9vapfosFiMZ9ui9jkTPBU8vWlHvjvaa9jvdSy0VitAqDZixpKiwhqOZZomxGoJ13YW2oNNYNDAd6vSJgJywuWnfChNcCgYEn+V7bMuamrdiQ3lqKgfVFc7W9lLKc9E8kU3hlL+DGsNOIeglkI33l7BQxYGwTpTDABgtfbGXgf34nHC0xyazfyYKaVt7psh1DS5RyCU9PmiAXRmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTQBI63bXx6IGHpPuCABoBSYDnsEToEORrZBAqUQKxk=;
 b=Cet0re7TZR7akEw2KxbM0Lu3LNxdeLO2bV3c3DL1F4nX++c2G42Bn3wdvh0wAUXqA7Kyl6g9RCklu/ZgxPW+7uTWf7t70oTLt3fIlT45l6OuT+up/qclvlQ3ePeNql4zFE2CtD1vOWKYGaIJJ/b4bhEPPdOnSAow1IKonFM8zrW7LAo/7Xm0eg/hYqFxO8URmcio4L5dUthqSCxuhWUP/p8CtT8nlH/IqALsgLfI3yqBVU3KinvUYmvl8kQPc17cM4sq6+IRzHXEp6VfDrWptm1pUgkh9EioU3LKXggTcP9ZHgrWu3SQgTykDQEMYTu3ucnvHAAkHskG+Kq9qVPEFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTQBI63bXx6IGHpPuCABoBSYDnsEToEORrZBAqUQKxk=;
 b=0meBe7JOglyJmFgjHe2wH2wZebWwAVRxI6EZKw6VXtXibiDSfTx1Yc3sWaGDkr1D+qOCN/AqdRpt6zrNgF1RqJ3HivBWIWSoIq2wBXBytUAfBlrJJfXwrsaeKOFft0ENRFdHYL8fDiV+LfKFy/m08ONf53sOJyjA0PihjS0gfi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 07:32:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:32:22 +0000
Message-ID: <05e24703-dda4-480a-9c6f-8874c5f5c401@amd.com>
Date: Wed, 1 Oct 2025 09:32:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] drm/amdgpu: use user provided hmm_range buffer in
 amdgpu_ttm_tt_get_user_pages
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250924100156.3746229-1-sunil.khatri@amd.com>
 <c5b52ba0-efe1-497e-9d35-a752a2b35267@amd.com>
 <662c2254-dcfc-46d7-b11c-51111c26f23e@amd.com>
 <0ebd74aa-3628-470a-bf37-3b11bcbcaf5f@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0ebd74aa-3628-470a-bf37-3b11bcbcaf5f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f68049f-b8bf-483c-fef6-08de00bca8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anVhRVpkQWp5V0lSM2hCb3hJU1lteitTUVlUcHczMFN2K3pUQWp4MktWM3g4?=
 =?utf-8?B?YVg4WUF5MEhEZGdxR2N0Zm81R2NabnE2NnVNdGQ2UFBxelhzVHpqZWJzdWsy?=
 =?utf-8?B?VlprQVdiWVZmRE1yR2pSc0c2UWhzNlZLTmpPanBGcFFPRlVMNXEzNk1GTFEz?=
 =?utf-8?B?WnZkenE1VVdzQ2RXUHZmTUlkNnM0OCtqZHlhNUg5M2ZCVVBPMjhmalUyQ1A0?=
 =?utf-8?B?SlhzUUJvUEYvK2VJbk9MM2gyc21YK0l1NW1mbWQyU29OTFVZdEZDSWVxVmE5?=
 =?utf-8?B?bitaMlY5MXNjdDE4NEppakdYMHlYVFdjeXllaFArcG83TngvWWRMSUtPODlh?=
 =?utf-8?B?TFhURnQ2MmZ1Z05YVmRvZ0JhWXhKM0hmUzJSU0ozWlNLbmhKdjdEbTlzL0tk?=
 =?utf-8?B?M2JTVktvWnBuWHpEMlJzbHJUMjcrVnFQYTRUV1JXa3drS1VTZXJlUURBTEdW?=
 =?utf-8?B?YWgzWnRJNG1PazFML0g1RFkrY1RhRFM0OUp0NzEzcWlmYkRyOTNycTNHaDR4?=
 =?utf-8?B?MGNkcmpGZ3hzM2xGL25wV0dSVndrV2VRd3VCSXVXaUNRdFNmRXNGald3Q0hh?=
 =?utf-8?B?L0p3RE5aRVlrQVl5UXYrWnpVQ3ZMZHFMSnRyN1drR0oxZ0hNOGtwSDgzZEF6?=
 =?utf-8?B?NHIyaHkyUzB4M25BVEdXaUFXcTlCbHRnMG1RbVRuajNuaUxEQkIzeWJXS2xC?=
 =?utf-8?B?cFVqMnljSlVPZS9BZllybTl2aWhQMHNockVlMEdqSFd4V2V4aGFXVC9CSjFj?=
 =?utf-8?B?K2FDbXpWNTFKakxCRzU4aWFMaFhYcVBHU3gwR0VWaVFKMlU1cmY3ditXcnBF?=
 =?utf-8?B?SU4rRVFDcDVRMlRrRStYUUpBdTBzWjFYeisrT1dxS3plYjBWK0RVTVRMbk96?=
 =?utf-8?B?NlZmV2RTRERsb2dWU3FzdHZDSG8zcmFCRk50V1h2NDlDNW1YL3YrUVZiLytl?=
 =?utf-8?B?YVpFNWtsekdUOGRicEFWL0lNRUFXVGpCVDhTMytZeXBoZ0lKWW5aZDQrZFRo?=
 =?utf-8?B?Tkd5cDQ3OFErMG9mL2NpaFBVODRoNUFXdGg2QWc4OUpoN3pQWWFkWHFrZEVp?=
 =?utf-8?B?TmlUVWFlemNCUjlXajdSWi9uTVl5RmRaSlhBendBVDcrd2hXZ1BTaUU1S2xL?=
 =?utf-8?B?OXZ6eHR5b2N1eVZ5ek9NdWk2UkRZOUVNS3g1cDBnNnQ3bFhuZGdPTUNnMFZi?=
 =?utf-8?B?WnBPQU8wOEl1QTZRSmw4VndNZGV3c2tPTExOWVZBb084Mm9QQlRJYTUvd1ZX?=
 =?utf-8?B?M1hOa1RZVE9pWmFGcW9scG9vWnhqSTBGOFdUcGthaWFyc3dGdTY4VVRleDBQ?=
 =?utf-8?B?czBMQ1RIZFZUdjhaS0hMb09qSnFZT0lIZlZpZWtha3dRdkNJTjh3c3RIUS90?=
 =?utf-8?B?dXBFbS8zTU9mTEhsaWV3NjZyeE9MN29xZzJxY05nVkVMSVRGY0hialFrNHlY?=
 =?utf-8?B?QnpSMVlCY2FWNUJGemxQY1VTS05jQUJ2YkVoS1hlR1JCOTNZSGFPT2p4Vjg5?=
 =?utf-8?B?Z1VxRXJkYUJIRGpYRmo1VzBnNldnMkM4bk9SU1Y4cmtPbW5MQVhwYmU4SHYx?=
 =?utf-8?B?ZkF3ZTcxRDk1Um9nY1pFQjJsdmNzQitLNlpEcGJXVHRIc2diTFhucGw0S09M?=
 =?utf-8?B?TnNKTmg4UWpUNk53MnNZalZxMmUzZ1ArWDhKNjZwMWVVWWZPYTBDdW5wbkVs?=
 =?utf-8?B?clcyMkdaSTB4WDh2aUdOUDVuYnJhMHY4cjZuOEtEQ3RzT3A3MDlHTFlNTllx?=
 =?utf-8?B?SDhaNHFlRlZ6TnlVQWs2aUhGUkNLVFRUY3p3Qy9HdUhYTzdFWndJd1B6M1Nn?=
 =?utf-8?B?enpIVjZJZ2ZVblZ5NWw5OWJFdmV6QVpsZHJhYTZQazF2OUdkWmwvMG1BRE5k?=
 =?utf-8?B?bTQ4Q1FmK2RlMGVXQVZWaUVwanZhLzVGTGdNTVZ6QThMUXN2QXlSWW55dmRM?=
 =?utf-8?Q?ZadvWRHdhcVw1Qx6lzgRh5E1CHJ6FSwL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWo4Uzk2WVQxcldQNHRQenR1aTV0bVFTcDlkNHZpVU41NllCZGNZaDk3Ukw4?=
 =?utf-8?B?UUhqZDdiQTRwSk9YS3FoUVhoSXZrSTd0MlY2bms2WE15QmRzSHVuY29yRElM?=
 =?utf-8?B?MlpQRlV6TEFEMDZVNHYrQ2VZN3dLZy91aUdkTFpTREE1RjhRMmJZSVh1c0xF?=
 =?utf-8?B?TkpMVy84RER6dTRwaEMzUW1pNlh1bGxnbHJuVVNyRi9kYkdGRHpQTVhKb2d2?=
 =?utf-8?B?by9OT0lEY2htWWFrcW05VjFYSVpsNTZVMjVzUkY1cE9aMWVONVB4ZEtIQmpF?=
 =?utf-8?B?WmtBT0ZwbnlRem1SMFp6ZGpWQjBGMDBldFUrNXdIc2Mrdk9taVVlYjNLSGNt?=
 =?utf-8?B?azNvVnZLWEVzVHdaYkp1Q3hmRVc3enphZEs5OVJvYlVpNVJnNGpyMkpXc1ZI?=
 =?utf-8?B?ZDBsQVovd2pEblgxOThnTTFWR0ZPNUZwSUtGN3hjWWpFcTFjSC9GNDVYOUVU?=
 =?utf-8?B?R3NocTFtUTUxMEMzQk9pdFRvWnRXUjNoa1JnZUgzUC9KRDNuZHE2YjE1OGZY?=
 =?utf-8?B?OEZTNzZEenZIR2xaVUh1Vi94VTFUTWEwQ3grY254cVA5U3Q4c3pPdFJVcEJ1?=
 =?utf-8?B?YlBPcVhkckhsV0RMT29qU2drK2JDT2lWcjNjaVpmM2hGNllYdUZHSjBNNjBT?=
 =?utf-8?B?TWYwNEp0dUdNRjMvaG5pNHBxZkVBaTB6MUZ5UVdsQmNUdFFYWk1DN0dhUm9k?=
 =?utf-8?B?ck5RbTFBUEU1Z1JhUzZPVlZ5c1ptOUZ0RERrNVBNZU1LaDUrdTg5eDB1VlFK?=
 =?utf-8?B?WTVlekpUenZFWjBVVU8yYWpneVZiT0Fhd3pVbHV1NmVTbXFkZG95TVNSdlc3?=
 =?utf-8?B?RkVBRVV4ZEFRYU00Uzg5NXVxMTVraHdqSEowcnM1VFlJTXVWSzFWSkw4ZDU2?=
 =?utf-8?B?RWtHVE5nNTVSWmhFK2huR3ZZKzd4dHVPWHpOckVmME1GekRLWXRncTkwendB?=
 =?utf-8?B?V2lpdy9QbHVaTTFMb1JPUWpRcS9SMEE5Qk40bkYxbHY2b092RU5waE1TY0dD?=
 =?utf-8?B?NGh3WVFhQ3BnQm5MaUpiWk5RRk5MZEVVTGZOTWtNbzd1OUUvblVIMHB2cC95?=
 =?utf-8?B?Y1VmajdTSkJqNTJIMG1yZjRhbGJHWDV0aXhza3czekJSZHMrVGdPYlo4MFor?=
 =?utf-8?B?VlJYdy9kYXllcHgrVUQyN2ZwZjk5YmlEaUk1SmdqK0ViK2RrRWw1RG5vcDgz?=
 =?utf-8?B?ZjhUZWRPaU4vWmFHMytCRnR2anJ3OS9EOUZ6dWR1WWNsNklzUkswSGdUVVVu?=
 =?utf-8?B?T0ZEZjVHaTdFOER3bktaYU1HUmhQdFBCQVVidmptRlhLNVZLRlNoSUxFWVZn?=
 =?utf-8?B?TXVmZnRMM0c0dStxdnVXZlJVQmFjTDJmM3c4eUsvQjVnd1RzZngyckFqVDli?=
 =?utf-8?B?KzRrMEpCNVE5Y3VyR0FORUh6ZDZnNUx2WDZ0ZzdzVlJSdlpvV21sQkxZdEQv?=
 =?utf-8?B?OThtTTFJdDVJVStPUDdNZmtGRHhMcXRaZ1QyaUtnUDFKenB3dVQzT1VVVmRH?=
 =?utf-8?B?SUpYMVZFRnJIUlNhSTMwWW92YlZPUXR4dVc3UDdoQ2NYZWRySGt2b3M4aUx0?=
 =?utf-8?B?bWVUb1VJbWpBWlR4QzJuMWxNY1hOb2V2MHhjN1lNQXU1d3Ewb1QyRHExNmtr?=
 =?utf-8?B?TXFSSkJBSk5aaFFyU1FaQjR5dWZDRlVwMnB2YnZUMFBOaHc2NEZrQk90bVV6?=
 =?utf-8?B?ZTRVbGVsZFJwZWF0SmM4aldqWnBFTUk4QkFlOE5Db0lzRGR4c1NQYmVKajJp?=
 =?utf-8?B?NzZmTW53bGRPOTFMVkRNWVIwRG5tWExqbWxWNStjS045RjY3ZWk3TnFhUEUy?=
 =?utf-8?B?MHRpWWRrQU5sYko1YTFNSlZGNWxVWEc5SmxMNzhPT3BNU0lmZzhqWHRWMS9L?=
 =?utf-8?B?UlBQSC9NWlpMNVdITU9GTlFMaWg0RC9lNEduQzZPQ0lMUFpldzhReUFjWkx6?=
 =?utf-8?B?MTMyaUU2MVdraHlwYVhjZ3BRemFVTjNPQXorN1FnMk5uelNRSWZINHNjMld4?=
 =?utf-8?B?eEEwbld3d2J4b25MbkdvTlBYdC9vQndlQWJqWnVZK1pWSGk3bDNNQWtiU3po?=
 =?utf-8?B?ZWU0VzZjVmtIbFQ4M2ZIaE5XM1VNU1F2TGV6ckxJRUdmU1o1aldoMnRLS0lp?=
 =?utf-8?Q?bmez0a+qg2IgfF15k8xDs9M7S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f68049f-b8bf-483c-fef6-08de00bca8da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 07:32:22.2596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh+A5/G+BPw1FJUzLh1Vorhh61biHU6pcHP/iF8Vm5zSdElE3ay5tdypbn3cNRPn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
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

On 01.10.25 07:41, Kuehling, Felix wrote:
> On 2025-09-26 06:53, Khatri, Sunil wrote:
>>
>> On 9/24/2025 10:27 PM, Kuehling, Felix wrote:
>>> On 2025-09-24 06:01, Sunil Khatri wrote:
>>>> update the amdgpu_ttm_tt_get_user_pages and all dependent function
>>>> along with it callers to use a user allocated hmm_range buffer instead
>>>> hmm layer allocates the buffer.
>>>>
>>>> This is a need to get hmm_range pointers easily accessible
>>>> without accessing the bo and that is a requirement for the
>>>> userqueue to lock the userptrs effectively.
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>
>>> What's the reason for this change? In the current code, the hmm_range is allocated by amdgpu_hmm_range_get_pages and freed by amdgpu_hmm_range_get_pages_done. Your change is breaking that symmetry.
>> Sorry i missed your comment. For userqueues locking the userptr bos and making sure we have valid userptrs at the time of validation seems too complicated, so along with christian we decided to use hmm_range list instead and have reference to userptr bo and via hmm_range private field to be set to bo.
> 
> I don't think this will work. See my reply to your other code review. hmm_range->dev_private_owner is not a device-private field that you can use to store random driver-data associated with the HMM range.

Ah! Thanks for that very valuable information. I thought it was just a void* drivers could use for their purpose.

Mhm, that makes the implementation even more complicated that it already is.

Regards,
Christian.

> 
> Regards,
>   Felix
> 
> 
>>
>> Also i did made sure that wherever we are doing get pages and allocating range the freeing part is taken care of. Specially for freeing the memory is still done by amdgpu_hmm_range_get_pages_done only. Please share if anywhere i missed something. Also Christian brought out the point to have separate alloc/free for hmm_range which i am working on and will share soon.
>>
>> Regards
>> Sunil Khatri
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++++++++--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 10 +++++++---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 11 +----------
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h          |  2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  8 +++-----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |  4 ++--
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  7 +++++--
>>>>   8 files changed, 38 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 7c54fe6b0f5d..4babd37712fb 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -1089,8 +1089,15 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>>>>           return 0;
>>>>       }
>>>>   -    ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>>> +    range = kzalloc(sizeof(*range), GFP_KERNEL);
>>>> +    if (unlikely(!range)) {
>>>> +        ret = -ENOMEM;
>>>> +        goto unregister_out;
>>>> +    }
>>>> +
>>>> +    ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>>>>       if (ret) {
>>>> +        kfree(range);
>>>>           if (ret == -EAGAIN)
>>>>               pr_debug("Failed to get user pages, try again\n");
>>>>           else
>>>> @@ -2567,9 +2574,14 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>>>>               }
>>>>           }
>>>>   +        mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
>>>> +        if (unlikely(!mem->range))
>>>> +            return -ENOMEM;
>>>>           /* Get updated user pages */
>>>> -        ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
>>>> +        ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>>>>           if (ret) {
>>>> +            kfree(mem->range);
>>>> +            mem->range = NULL;
>>>>               pr_debug("Failed %d to get user pages\n", ret);
>>>>                 /* Return -EFAULT bad address error as success. It will
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index 744e6ff69814..31eea1c7dac3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -884,9 +884,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>>>       amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>>>>           bool userpage_invalidated = false;
>>>>           struct amdgpu_bo *bo = e->bo;
>>>> +        e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
>>>> +        if (unlikely(!e->range))
>>>> +            return -ENOMEM;
>>>> +
>>>>           int i;
>>>>   -        r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
>>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>>>>           if (r)
>>>>               goto out_free_user_pages;
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> index 8524aa55e057..12f0597a3659 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> @@ -571,10 +571,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>>>           goto release_object;
>>>>         if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
>>>> -        r = amdgpu_ttm_tt_get_user_pages(bo, &range);
>>>> -        if (r)
>>>> +        range = kzalloc(sizeof(*range), GFP_KERNEL);
>>>> +        if (unlikely(!range))
>>>> +            return -ENOMEM;
>>>> +        r = amdgpu_ttm_tt_get_user_pages(bo, range);
>>>> +        if (r) {
>>>> +            kfree(range);
>>>>               goto release_object;
>>>> -
>>>> +        }
>>>>           r = amdgpu_bo_reserve(bo, true);
>>>>           if (r)
>>>>               goto user_pages_done;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> index 2c6a6b858112..53d405a92a14 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> @@ -168,18 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>>                      void *owner,
>>>> -                   struct hmm_range **phmm_range)
>>>> +                   struct hmm_range *hmm_range)
>>>>   {
>>>> -    struct hmm_range *hmm_range;
>>>>       unsigned long end;
>>>>       unsigned long timeout;
>>>>       unsigned long *pfns;
>>>>       int r = 0;
>>>>   -    hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>>> -    if (unlikely(!hmm_range))
>>>> -        return -ENOMEM;
>>>> -
>>>>       pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>>>>       if (unlikely(!pfns)) {
>>>>           r = -ENOMEM;
>>>> @@ -221,15 +216,11 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>       hmm_range->start = start;
>>>>       hmm_range->hmm_pfns = pfns;
>>>>   -    *phmm_range = hmm_range;
>>>> -
>>>>       return 0;
>>>>     out_free_pfns:
>>>>       kvfree(pfns);
>>>>   out_free_range:
>>>> -    kfree(hmm_range);
>>>> -
>>>>       if (r == -EBUSY)
>>>>           r = -EAGAIN;
>>>>       return r;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>>> index 953e1d06de20..c54e3c64251a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
>>>> @@ -34,7 +34,7 @@
>>>>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>                      uint64_t start, uint64_t npages, bool readonly,
>>>>                      void *owner,
>>>> -                   struct hmm_range **phmm_range);
>>>> +                   struct hmm_range *hmm_range);
>>>>   bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>>>>     #if defined(CONFIG_HMM_MIRROR)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 901e0c39a594..046ff2346dab 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -705,10 +705,11 @@ struct amdgpu_ttm_tt {
>>>>    * memory and start HMM tracking CPU page table update
>>>>    *
>>>>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
>>>> - * once afterwards to stop HMM tracking
>>>> + * once afterwards to stop HMM tracking. Its the caller responsibility to ensure
>>>> + * that range is a valid memory and it is freed too.
>>>>    */
>>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>>> -                 struct hmm_range **range)
>>>> +                 struct hmm_range *range)
>>>>   {
>>>>       struct ttm_tt *ttm = bo->tbo.ttm;
>>>>       struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
>>>> @@ -718,9 +719,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>>>       bool readonly;
>>>>       int r = 0;
>>>>   -    /* Make sure get_user_pages_done() can cleanup gracefully */
>>>> -    *range = NULL;
>>>> -
>>>>       mm = bo->notifier.mm;
>>>>       if (unlikely(!mm)) {
>>>>           DRM_DEBUG_DRIVER("BO is not registered?\n");
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 6ac94469ed40..a8379b925878 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -191,14 +191,14 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>>>     #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>>>   int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>>> -                 struct hmm_range **range);
>>>> +                 struct hmm_range *range);
>>>>   void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>>>>                         struct hmm_range *range);
>>>>   bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>>>>                          struct hmm_range *range);
>>>>   #else
>>>>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>>>> -                           struct hmm_range **range)
>>>> +                           struct hmm_range *range)
>>>>   {
>>>>       return -EPERM;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> index 273f42e3afdd..9f0f14ea93e5 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>> @@ -1737,12 +1737,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>>>>               }
>>>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>>> +            hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>>>>                                  readonly, owner,
>>>> -                               &hmm_range);
>>>> +                               hmm_range);
>>>>               WRITE_ONCE(p->svms.faulting_task, NULL);
>>>> -            if (r)
>>>> +            if (r) {
>>>> +                kfree(hmm_range);
>>>>                   pr_debug("failed %d to get svm range pages\n", r);
>>>> +            }
>>>>           } else {
>>>>               r = -EFAULT;
>>>>           }

