Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883CACCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 20:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF9D10E13C;
	Thu, 23 Oct 2025 20:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aVBQB+ZK";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C871110E13C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 20:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhdzd0Lrc3aJsOOpotuC4KwiuOsGa4mYVcoh/ZSe6XBoloeRV280T8VGDSJE0SPEc2IhZd1JELjYuZcGMYOrJ9G/nAyHtOvrq97oZunaEi4av6+/3/ef1oPoP6iEaXlPLVZ+N3Q/7/zEz66t9SFdBWcf097+xlxTw2+HhbpZb9nFVqQUqXESgwTniaMlc1YUBs6KseSeTn5yCwvtH/vW6Iv5WwXlqwplGzRK/8IXzclWDs+6KiTD2fooMiPcXr3X5Ra9cFebwsnqTk9jUUwhO0J+cggZo/dOWInpRkUVV0Pajlwo0XRntGpOKyjbrMjPxzCqTfbL34F50850uXshkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv4Td7oKOIaTYFuswf1GWoCJZU27JdqKlrxyyDSF69A=;
 b=rf57dujqC4OjRPAk42USSY8nYoCajUshOO4fhnE3/T2Ui7K0BpuNU0/BifgPU6u9EfD46A2zxQNDXGI24idGrckuM4QLcdBR3LVmFw6bXVQgDTw8ASqLbNXcHy22fR1dOU0yoUhB1tb/4U+8kCJ4/rfLVlx2U9Y2b/7x26fXbcCJpK9S7GvN/qbXamrjRzKnDPUUTorC5cRxg9q2KJp/gQJkpo37KnownJKY5Q7axS6sZzgE5M4aLxJXY/HtWTufTeMTqu4bvPiYFF6UdmIQwAo431ZwstWGom4ieYrtsj0Jg3g6oeUtGBKj32jY3bDrHq9arU5jLSCXgWIyW8E7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv4Td7oKOIaTYFuswf1GWoCJZU27JdqKlrxyyDSF69A=;
 b=aVBQB+ZKz/TGHHA8Cvpcu9H2p54B9kdA7djR4SAi8rGSIJa6LqU3aaPiyfudrw2IV28o07qWRG74UYmng1E3+WA6zKxIcoagE8yCrNKfSioXW6TKM8T0Jcvgu4rfrgUakcnfYeBe/aJcpE4RbNPAGcJTQ1RYLbkQ3Hpf80wO7Lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 20:13:49 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9228.014; Thu, 23 Oct 2025
 20:13:43 +0000
Message-ID: <3df3482f-0762-bf08-561d-06d4c44456b6@amd.com>
Date: Thu, 23 Oct 2025 16:13:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
 <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0303.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f958fe-e1c5-44d0-702b-08de1270a9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d05XcXJyYnAwckRLWG1SSVNUbXgzL2RheWpRUDFvQzczRVc1M0RLR0JRajZx?=
 =?utf-8?B?bVYvWHpWODJzbXUxUVZxNi9FSFR3Wnl3UWVYWENuT2NHZ3IrdzZNOWtVeTdr?=
 =?utf-8?B?ZEdDN3FRTGRlSWlNOE9YTDVJYXhnZG1VVFpEdUtQZTJ4YWRYUVNtbGhWTndw?=
 =?utf-8?B?U0JWV2Y3MjFQU3NMM1JJSk51V1JCZU9MbGZBMllZcG5yY3FIMkdTclhsOGN0?=
 =?utf-8?B?ZkM0bVJOazQ0d3I5Q08zNTdOL2JNbFlJaHlhMGMxNWVvQlJmS3RLZUFpN0RV?=
 =?utf-8?B?WDFhUWUvNjdsNDl0ZDc4SVNBSVhzZGdreFRPZllRK3JyLzJJZDAyT3Q2RDZq?=
 =?utf-8?B?S0wyczhpeTBUd2NhTXI0S3YzU0IwRnZEeTh3d2h0WnNOTFB4TUZ2c3NOV1dt?=
 =?utf-8?B?WlBTcE52eG8ybVdMd1FMSFJaUmwvdTA2WldSTDlQb3V4djA3bTdOK3F5cTVE?=
 =?utf-8?B?NngrVVNIMkptMzlNdGJJNFBENWJZYWREUWJzbGhWbGRXdWRwMUlxeTI3QU1r?=
 =?utf-8?B?QzZnTXlVaFFibWFIOHBXYTFsanZPOXJZYXgyOWpHNy8vVTdCcGp0Y0ZLRlVa?=
 =?utf-8?B?Uktjbk5BUjBKRGliUCtuaC94SzJvS012cmZ2eHlOT00wU1Zuc0xRZjhVb3Ru?=
 =?utf-8?B?RDJMdDc3YWMvd1Z4NFdqQmwvZWhSaGkxOXhnQmkxbCtDbHVFdm9BWkJaeC9w?=
 =?utf-8?B?Nk1MVXFIU1FuRW8ySVo4aHZIVEc0aHg4NDVTWHp4dWpHZUJDdkJteEdIdDVO?=
 =?utf-8?B?bUFwc1I1dWJiMGZlUlM5Unh5ajE2MUJEVUJSL0VpTDZtaGlMZWQ1NlpGOVlm?=
 =?utf-8?B?LzRlR3E0eTMyR0g5M21yR1NlSld3b2p1YXpic2p2RlRhR1A5QktJYnZJalIr?=
 =?utf-8?B?Tm5lY1MzV1RnWHBDV0RxbUxSdDZqdmoxcVdvWEFTZkNmOUcyVmFJNmFuNjhk?=
 =?utf-8?B?bUtzcFR1YVhkNDhYTmRoV2RFeUNtclN6L3FNbkVaY3Z3eXJQRVA3c28rM3Ft?=
 =?utf-8?B?NUFoNzRVdzNZV3hkLytka0ErRXFhMXZBWi9Weks2VGlJRWh6MExIclNST2lS?=
 =?utf-8?B?NFFKdnY0U2FZa1Irc3U4eTZRNzRKcFVyeUxVY2xOZ3FMTlBqbjhXS3p5SlB5?=
 =?utf-8?B?cHlDZTJVMm9COXA3anRKT1Q1bXFJQ2NQM3QzVTlYVjIyWS9qaW8rV0ZKemJB?=
 =?utf-8?B?MnFnL2ZuTjB0eDg2ZkZLUHRCYStXZUp2ZmlURE1rU0xNcENGR0QyNWpRT2o1?=
 =?utf-8?B?aGllMnFIamprbGU2cms2VHkvU2VCNVB0aDZqNGNkTkVObVNwakNXdlVmeWM4?=
 =?utf-8?B?MkZJWHhIRGRjYXZPNVJENFpWUmJraHhxOVFOMS9oMk41M0lFQW9XWWpVVEZW?=
 =?utf-8?B?dmRrbmQ1MFN0SVdkSlJoUWk1S2p6U3NNWmt3WjhwS0poWjhBMmtSUjdvZnZv?=
 =?utf-8?B?a3hsaFZXVHBRd1ViaEo4U0R4Yll3NGJxbjdXTTNDOXFLNEV3a2Z3V1V5cmxH?=
 =?utf-8?B?aEg4SzhpMDJ2RlhFTnRKUktxWXJ4QWkrdW5CcXlCMnB6VU12eStQeERqQjBu?=
 =?utf-8?B?U2ZpMnlrNmIwSFpvQ25QSXNPNEp4dldFclp4MDF5dktkbVdSSkNiSWlQWlJE?=
 =?utf-8?B?aGNKaHhGdC9VRk5rUnBjaEw4cTJ2SXkvS0tHd0JEN0NQTDFqa000aUJTTVBu?=
 =?utf-8?B?R1U0d3F0NWZSeHRqL0U4RVJPRlNYUkd4SmxoLzIwVmJmbmxUM1NWNG5semkv?=
 =?utf-8?B?UDN6SlBpeWpodHRRV3l4RTArdHNzb0xOZzBlb2pCcEwxY1hlMXQvOHpMY25s?=
 =?utf-8?B?bmpwVTBsNUNQdTVuaGFnNEo5U1laZlhlRUZxV3pSbGFZNEtnQ3hwM1VFd0Jr?=
 =?utf-8?B?WnQxZ2lqUWpGQ3RRcW82SURuNjBaNDVHeGZieURTcFZQclJMMlpmZW4zVzhD?=
 =?utf-8?Q?ZIfneYSh3Tpd10/B08FkRQM62ajnDjQo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRDa1Q2UEZiREV1cE9iZ1EwaTB3bEFoWDRCc0JDVlpwV251Y2tmcXROTnUw?=
 =?utf-8?B?K0p6Tk05Q3dRR2hKNC9VZmM5MVhrazhTSWRqcng3bi9JclVLRkJnNnJzaksv?=
 =?utf-8?B?bjdpb1FDdWs2Y3l1M2gvbTdqQjh6TTJWTFFzeGVscENNa1EwaERZSmtYWGRB?=
 =?utf-8?B?d2duVHhsWnkzdy9adGdNNFQ2bTdndkFCOUNyN3Nrb25PREhiWmxmUGZlVDkz?=
 =?utf-8?B?cGNEajRYVGtrc3FjM0lsanZDcU5FcVFsMFJSMzJJZ0owajNuOGVEbWlQeEVM?=
 =?utf-8?B?dnI5YWxVTlZjQVE1OG9mc3dNQ0dQbVJBV2Zrdk9YZWl3NnFDaGFQVTdWS3h0?=
 =?utf-8?B?TnUzOHQ5SWZVZXR1UnM3bGRqVGNGYWxHNXEwUXZqWUhtL0FlS3lYUFBEQ1l3?=
 =?utf-8?B?ZUNXMk9lc0VVRGRtd0hZNU10TXV6bGhQWGhFM3QzS1V4UTRleE1nSUV0Q3g5?=
 =?utf-8?B?ekdNb0JsZW5xcjBOb2w5YUt2UjFyVzJHekllNzF0bGxYbEh3NUc0blQ0ak1J?=
 =?utf-8?B?ZmR3RUg5QkkyMktBZytodGpGVUlLdlJoWkVjekIvVHBHQUVhUjZSalM1bE9Q?=
 =?utf-8?B?VEZYcEdyRURZeTRuN1MrVk90WVoyOHY3azhBcUdCcDNjclVyWEg3c2RDTVN0?=
 =?utf-8?B?RkVXb2gxeTdmWjBRZWl0TVFSN2JSOFB3NXdCR2FiYk5uMER6OFJPdWN2YjNY?=
 =?utf-8?B?cUdkWk5HVW1xM1pjcHM2UlEyT2QxQkNiK3dPWnlUNmkrWGZjSHZYZ1lmTCtF?=
 =?utf-8?B?anoraCtzZVpCSGN2VklaamJlVVZ6NzhIajBpTXhCMHkva3lJWjRtYXNMYUpu?=
 =?utf-8?B?Z2NJeFlXaXdOMy9jRHZJSkhGODFXcVdaTHpJMzA3ZDRoZ09tMjZtZFJRdzVP?=
 =?utf-8?B?TWtFdEl5RXFmU3RXeGFoZHlGclJOVFBPaWI4TGJuQ2t6anUzOTJ2K0dOZWpr?=
 =?utf-8?B?bTVBamQ1VC80ZmZUN0VhZUptS0VuNjZuc3ZxT21lWTM5NElueWtnQzgvN1hr?=
 =?utf-8?B?N3RoZEk3K01SNEZWeGV3aTduL3JKaWdkZ0VscjZDNGNLcGMwVEFxVktBYlJv?=
 =?utf-8?B?Q3ZRQ29mMGw5WFg0SkViVEl4cDhEK25mSFZRck5DbXNBODF2aFZKQ1F5TEVh?=
 =?utf-8?B?cXNlVVpxUU1iU0p6NExzMjNsVUUxSTBWZ1BpNndLWnc3b1ozVzhtNXlGbmQ2?=
 =?utf-8?B?S1JkUkdRQXUybHUwWUxuMG1UT1RSOW96T04raUVtWU1NeWoxeXRRR0JLaW5u?=
 =?utf-8?B?MHhnSGp4Zlk1UUhaMnZUTVZQV29KVXdKZ2VBRmtsS3ZDUVhScU9oSTltZVo4?=
 =?utf-8?B?RXRueVNMNkJ3cC93eVRsWERwSjliQ1h1eWRGbE1RK05QYWc5bWoydllURHdL?=
 =?utf-8?B?NldOZkhUL0pMeU1EMWJMcjZENlhmcVV6d2xsQ2xITC9qelZoSllZMVR1Y1ly?=
 =?utf-8?B?WlAvd29DWHBodEF2Z0ltQUp5MlVzT2lGYzF2UDBFcjYrd2NLSW1ER0xpTlFJ?=
 =?utf-8?B?QlR4YXgzZ2xreFAvaStNTmNmeitLUmVMbnR2OGYyTkdQNVNzbHFOWWNOaG5V?=
 =?utf-8?B?VnYreU5rZDJPV1l5TWxwK0xlZ3NUeEIxUlJkVjZmOVh1T3krSzRXTFB5MlYz?=
 =?utf-8?B?emh3dE01bFBObkZLeVlld3o0RUsyb3cwb2Q1VW5oekQ1UnNoQUw0c2RrRWk1?=
 =?utf-8?B?YjdiMHNINnJGKzdXbGFkYnNrT2JuejlybkNPMXAwa3R5ZUJqanUxYzlwcnBH?=
 =?utf-8?B?SWxEdXhwNkQ4dkptK240VkY4c1hGcVYzcjd0UDV2bzRUMnNjaG9wR2xjWnB0?=
 =?utf-8?B?cG40eUdkR0QxU1liK2FrRTFHNU9ieXFoNjRQVmI4TFJYWi9tMUd1eWlqVjNK?=
 =?utf-8?B?NVp5U0xDY2QzOHRQOTNCeFd5bm9Ra0xiV1o4RW1xWWV5TGFDZENKVkF1ZmpE?=
 =?utf-8?B?bDd4c3J4VnF0eFhCMkFodVZSeEU2eWREdi9OVUFGQWVGQkpFcEFPUVFHdnZ0?=
 =?utf-8?B?WXZ3QkY5R0ZDQmtIeURuUDZwY3ZwWjBDSHdRQ3BUN2dKWVFROURuOW9XdkRW?=
 =?utf-8?B?dmJ1dUlOMCt5NlR3eTRzWFRaVnh0QjNoOGFNWG5raUtOTFBRUitRZkt4N3Rr?=
 =?utf-8?Q?L9LA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f958fe-e1c5-44d0-702b-08de1270a9f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 20:13:43.2021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ew00nwrUdt8FQkik/dXCvPxLJ3sqakOhMBiGqP6rNEZFmmufSDLWLgpFphdD6Jv0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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


On 2025-10-23 10:34, Srinivasan Shanmugam wrote:
> The function svm_range_validate_and_map() was freeing `range` when
> amdgpu_hmm_range_get_pages() failed. But later, the code still used the
> same `range` pointer and freed it again. This could cause a
> use-after-free and double-free issue.
>
> The fix sets `range = NULL` right after it is freed and checks for
> `range` before using or freeing it again.
>
> v2: Removed duplicate !r check in the condition for clarity.
>
> v3: In amdgpu_hmm_range_get_pages(), when hmm_range_fault() fails, we
> kvfree(pfns) but leave the pointer in hmm_range->hmm_pfns still pointing
> to freed memory. The caller (or amdgpu_hmm_range_free(range)) may try to
> free range->hmm_range.hmm_pfns again, causing a double free, Setting
> hmm_range->hmm_pfns = NULL immediately after kvfree(pfns) prevents both
> double free. (Philip)
>
> In svm_range_validate_and_map(), When r == 0, it means success → range
> is not NULL.  When r != 0, it means failure → already made range = NULL.
> So checking both (!r && range) is unnecessary because the moment r == 0,
> we automatically know range exists and is safe to use. (Philip)
>
> Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Philip Yang <Philip.Yang@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Add amdgpu_hmm_range separate the hmm range alloc and free into multiple 
places, and it is harder to handle the hmm range free and error 
handling, we may revisit it later to simplify the logic. With that said, 
this patch is

Reviewed-by: Philip Yang<Philip.Yang@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 6 ++++--
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index d6f903a2d573..90d26d820bac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -221,6 +221,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   
>   out_free_pfns:
>   	kvfree(pfns);
> +	hmm_range->hmm_pfns = NULL;
>   out_free_range:
>   	if (r == -EBUSY)
>   		r = -EAGAIN;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f041643308ca..103acb925c2b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1744,6 +1744,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
>   			if (r) {
>   				amdgpu_hmm_range_free(range);
> +				range = NULL;
>   				pr_debug("failed %d to get svm range pages\n", r);
>   			}
>   		} else {
> @@ -1761,7 +1762,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		svm_range_lock(prange);
>   
>   		/* Free backing memory of hmm_range if it was initialized
> -		 * Overrride return value to TRY AGAIN only if prior returns
> +		 * Override return value to TRY AGAIN only if prior returns
>   		 * were successful
>   		 */
>   		if (range && !amdgpu_hmm_range_valid(range) && !r) {
> @@ -1769,7 +1770,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   			r = -EAGAIN;
>   		}
>   		/* Free the hmm range */
> -		amdgpu_hmm_range_free(range);
> +		if (range)
> +			amdgpu_hmm_range_free(range);
>   
>   
>   		if (!r && !list_empty(&prange->child_list)) {
