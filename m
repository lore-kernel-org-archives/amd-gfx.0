Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DFFC83F1D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 08:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABCB10E374;
	Tue, 15 Jul 2025 08:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W4tgz+8U";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C6110E374
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 08:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rt3sMJQ8W7hXKsho+RSnh1JAzgysvbkNuC1YaO/lnjeS5OCt8ZDhXAi4S5UIKpT+/93jxqIejNWCGNry1JGBhOoY9iQhFnYQHQBNSA9MY0oVmdwIo2W+UEEGEsRffUJeBoIyXajnU1Ltv/7vIBeFOMKmI6BDDEgcfR/IaGhE/s0Hy0iCkHXMm8pgj0yxokLylufV/0Ntzrd9Cs6pptg9RR6fP6KjfzeFZAw6c6WmZwn/FNNYMx/pBeYIuZg85+n25YLksbdFwQPz8Wd95+74gCbrzPeei4PbxzJBXvw6SUq2hW0CS3DpKJwJz/4EgGUXvr+8BDySgg3qK9HDNH8qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2/wwNEugEIPX3HEi5/dQzfbeVUocDkDU5NZX8atJns=;
 b=RcBj5aBfyRLRYHLTe/tMd0MStIV8vTWn2inK1eP+i606GBnnnvcdtZK8N8bgqaFG1CaGjf9QCJMH1XgEOO0XoKDsgFMJBtJ7FjucLpzVzqbDnpQ5TXdXJPWMNVgm1xaywJo1EWcKgNfMZ1Fre53B5rsHsFGlPts7qMFey3G6pBwS0Vkz81vriVjTd1BtMY1LNRHTn7VcagMIo+ngu1WjBB6wa032UOwzl6wIL/cpKGASdmWPoN6suw3I1KfkU057u70ZLenYTDWUogI5cCbQHOE1hRoWLKTdaPfsy/Yq+iJwQCnRZq3YvJt7aWwIJ2ORWWhrUnxJ9mXPjDBiIzIIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2/wwNEugEIPX3HEi5/dQzfbeVUocDkDU5NZX8atJns=;
 b=W4tgz+8UVmufPvc+GgwonjdxKCVlisJFW0ES63BWo1B6J/bLe/hpEy9A2IpN1ltjHTnauqB2EkJeipidwkQ6Zqq8Rnt11zyy/L4t+PrcVQZkNPVPH9gbhIOnnxAGKjbU3lCnXzIuB/s1WS82inqD1crtjEjYk+RR06hAJRadg08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 08:41:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 08:41:12 +0000
Message-ID: <1ac476ca-a12a-4ca4-bc8c-b44186fe8ef9@amd.com>
Date: Tue, 15 Jul 2025 10:41:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/11] drm/amdgpu: validate userq buffer virtual
 address and size
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-4-Prike.Liang@amd.com>
 <2f056c77-8c26-4bf3-aa89-2965c7896139@amd.com>
 <DS7PR12MB6005D9F97038D8E42C79656BFB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005D9F97038D8E42C79656BFB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 686f736e-375f-4a6a-69d3-08ddc37b5a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUhwOEhuaEdwMTBoV040RzdGZGpkMFdZK2hnWTdQTlgrMlFSb3pYV1lpRzBz?=
 =?utf-8?B?Z084NTNWQ0JCSzFHdHFrMkRFejhCRTRydWQ1N2doMDBiUzNFTzZtUGxYME5r?=
 =?utf-8?B?SXBSRzlvbUJobmVjOVBNaEJCbWRyeFFjOGNUUmdmUk1ta2VNcHpZVlJFUC9s?=
 =?utf-8?B?M1lGZUEvUFhPaHMzR2xVTzNoY3dQdlRmY1hTQnZFaWJCTEp3KzBFNEc4T0Ri?=
 =?utf-8?B?S1loK3J4cnBRUkZRUkZiUmp1K244UXBLdDhKS05ySERqTWZaM3M1L1BCR20w?=
 =?utf-8?B?WkpyYzVUK0htbnd1K29CUjBCUnp4K0E5QS8zZ3FxQmsvUEQ3VW0zZnZmSnFT?=
 =?utf-8?B?aC9OY3c5TUd3UWNXR1Z6eWxxblJ0aTJ3akdvT2svQUhSUU5rUkpzQnRFQzNG?=
 =?utf-8?B?SU96cUlDcjdLVVhHZStIRkJDNjN1L201bUxlMnNBbGxRdnJSMUNSamhLRU84?=
 =?utf-8?B?QTk3VWx6QWZNbTZjTUh1T1ZzS2FLbHVqKzdmOVVuQkpCd2FnM21MbVpSdTU2?=
 =?utf-8?B?V2ZHTGdKMGwzc0kyOVd2R3VGT29rblNDWktvYXJLVEFwNjh0aEcrQ2xNYVhz?=
 =?utf-8?B?dkVBOExsam1Bb2FNMmViZ2RsN1NNQ2xsaWppMkpqYllhZWNkTzlKSjNremE0?=
 =?utf-8?B?bzFjRUZhUSsyak5vbHNjQjkwbUMwL21odFVkbWQ1MlF0c1IwdzBzYU5LUlEw?=
 =?utf-8?B?Q2lKYUxpTHFaUnlVMkxuWWRmQit2NUZvYnZSTEFNOURQYXRnMzJ0SVI3Tkc0?=
 =?utf-8?B?M2hremJ5bjNhb0J3djZlL2RYSGFvM1JDclBFYmxNd1JZQ2JrZlIvZVpQU1p3?=
 =?utf-8?B?Nk96MHJPdUVMeTE3VythQTQyU2lCMytybThXL3ZOMzRPTXdZNW5UNldFSW03?=
 =?utf-8?B?dWtmV2Q3YXZIMndRS0tBMUE5ZHFFR2JjYnFvdXhVV1NwWlFrRE1yUjljcmF6?=
 =?utf-8?B?Q3VyK0lSWW1MaGE2eENvSlhDMi9KRjdONDRtR2IveDJPYitsb2JKMDk4VTh6?=
 =?utf-8?B?dnRjaXdDVGNwUEpML1E4MjZ3L2dVRUs3SzNueXFoSmMwTUphYitORGhSVWtP?=
 =?utf-8?B?NXdHSGhZSzV3aGlmTDdKanhXQitaVFk1anJBVk9BSFlvQWpsUEZQVk5nTFd1?=
 =?utf-8?B?MXZ1UDl2UHNqMFpLTk4wWnU2NWpKQnNXMVR2cWxYbzV0elJibDB6RXNMdzhL?=
 =?utf-8?B?TFU5ZlA3bUxoL1oxVUg4OE44UVc2RkRkVUNYa2didXREd1pJRmtHL0IxZHlo?=
 =?utf-8?B?R0dIRTJadGdvVUlQc08zeE13WnUrUjF5TXB5NkJyeE1iYnJCYUV3WC9wcTVj?=
 =?utf-8?B?TCtpaEFIWmhiQlIzdlFqVVJNS1MwcnZhem9vNXhlRHF5WW82OG5jUEdNSU1i?=
 =?utf-8?B?OXdSdHoyZ3htc0hMTWNlYnFSZG5nZjJMeFk2Q1ZJSEVKMDYrc0hBSU5ia2dZ?=
 =?utf-8?B?OTVZYnVaOWp0WGRKQjNLaVg1YTlkK0tRd2dJSzV0SHB4aVRmR0VRU0hMZVQv?=
 =?utf-8?B?UmxjMUNQQkdwbTJFTGI3WGg4K1drWnF4dWpwdk05alJYTHU0b1pLT0MyQm9o?=
 =?utf-8?B?V2xIN2N3UXJXQWwvai9OaEVyUzNmUGRuT1RvbEw0QWp5OGFOa0JtWDFKSlpR?=
 =?utf-8?B?OHJJc0ZLV01LZjY3UEdVVHczR2lXRDVRMC9rWU00ZTJuTnZlUEYyY1hobHZw?=
 =?utf-8?B?S2dzV3ZiNUthcm0rNVN4NDJuT1QzeHBTY0M5Ti9HTWM0YXlDVWRXeHZXUUl4?=
 =?utf-8?B?aDAraDNPcmZ5VFJFYzRYU1M3VkJsWThmbHFEWmR0emowVXRoamlXb29OV1hv?=
 =?utf-8?B?cHlJZnNnWDIrUWh3bW4ySUZJZlBpV2ZacjlvWGhwZU54UWhZQ3Q1cWJaQ09o?=
 =?utf-8?B?N3JLeDh2SlAzazMrUFJtMjVVN2xzSys3VDFGeEZIZTFxRGFNb2daQVRpakF2?=
 =?utf-8?Q?X3ZTtKSLMVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0lxd0V1ajZYaFpIQnNpUElMTEM1bHcweUsvWGpDeGdjUzhEUjhta21OZVdh?=
 =?utf-8?B?clFRZzVKeXBIQ2RiNnZJb0pyYkJaR3JYbmtWZDdSeG5leXJVNFB3cVZPa3dm?=
 =?utf-8?B?L0xEMUwrNFhSZG5XWU4wSUJqMm9la1BXNTRnTUxBdk5vQStncTh2MENJVWlN?=
 =?utf-8?B?dWNCNnM5SE1ZNTlQeFQzeVhpQmtjTXYzMCtneisvSm1MWUl2TU1YeFlxc2hk?=
 =?utf-8?B?a3RObUp5cEc0ZDZQK1pWK1hPYXowN1BXaVlMUHM5VUNwYXUvc0pVYm95WWF1?=
 =?utf-8?B?Y21GRUJ6RGFickUxWVNDbzJNN05YRmRsbSs2MFNnRFRQanE1bEFDaUlrOGRJ?=
 =?utf-8?B?Sjh4eGRjZzZSUXZSQStOZ0RvWGwyNUUrVGVkRzlScjJadGhnQS93eHBId1h0?=
 =?utf-8?B?VFloamlVcGE5Q3JnTkJ2YWNVR3dNdTZpbXh3bFJSa2N1VmNHZDBNQ1YreFVw?=
 =?utf-8?B?TEtxMGpPMWRYVWh2eWJRRm1QejZkU1YvZm1odDM2Z2l6MGd2VGk1N0x0RWsr?=
 =?utf-8?B?aldBMndYa0QrQm5vWWoyR2tEZXlsOWhlVXUrUXV1MGVUMGdGVERXaUtzSjF4?=
 =?utf-8?B?K2ZVSWxzZjRqdno5UjVmRWtPS04zMzJMZ3FSK2h5YW5tbEUvY3ZYUTJBSUw1?=
 =?utf-8?B?cVVtNjVvZWxINVgvVXVPalpSUE5TcTlJS3RPU1hjYjBaWmJwYUtQaXhFN0dn?=
 =?utf-8?B?ZkFIM3pyYUZVbXRpYXA4cjA4TkdibHNVd2pKczlSeDU0OVhwZVE5dElvaGZH?=
 =?utf-8?B?c0ppUG1wT2E1SWg1NWlrSm5rN1NINWo2TDRBbG02M3kxOE9hNnpMb2x5NzhX?=
 =?utf-8?B?YnVGb1J4alNvNXpEMklDRTZNTEp6SUkvLy9kMnFMTlBBUG1ka1lSY2NoRHFm?=
 =?utf-8?B?TlNOc2R2MndnTVQ0WTdmMWtUZ2FxNDV3QkdoSnFidTlZU3IwWkczalRGVHpi?=
 =?utf-8?B?WVNnaTYwbnlad3BjdmhKc2o3cHFNSnBWWmo0ODRqWTE0MU5WY24xR3FKS2Zw?=
 =?utf-8?B?UGRLTFdObVhqK0xsYzlyVmlXYmdHZjd2Z3l4MGtsVHJUQWIyVnozK25JWU03?=
 =?utf-8?B?L0dvNTBQU21Jclc4S3VWRzMxNDg4TnhVUkVQZFQ5R2JncXgrcXArSXFKSSt6?=
 =?utf-8?B?cnRDT1BhbUhDRU1URkpLckRGeTdGYXVsMVZyRlBTUXR0R3dLRk5SYWhMcnIr?=
 =?utf-8?B?dnBNQjFMMUlmQVFBVEorVmowWk4rSU80YzRjeVhhUnQzSHVUc09NMGZUcmp1?=
 =?utf-8?B?REVUb1ZjV01qWWU3OWZDM1dzWm03OHhvK0dhRnp2d0djcmV5SmMvZG5aUUVu?=
 =?utf-8?B?ZEJlU2s2aVJwanM1WFhZa3c2ckxBS2lSZU55bFFacm4zQ2dOWlduUFMrTWdB?=
 =?utf-8?B?Z3NGRHpta3ZDNmhaMFF4d0NxempYbmR3TkJWVzNEaDRvdUY3djlndXpZSVBM?=
 =?utf-8?B?SEJ0WDM1c1NxOUNOVHpEOC84blRUZXUrWWNTQ1E1YUFOcWJiN3pVU2p6UTkw?=
 =?utf-8?B?TXhTd2Y0UFkwMEdSbkJITW8zOWh3RFVBdEpzUk5nTEhTUjQxVXlEaE1IUHdD?=
 =?utf-8?B?a01iZEtOazZRVGttZkVZQVJweDZUM0xMa0VVbCt3TTV1dzRMb2RGY2JsMHIx?=
 =?utf-8?B?MUZ2L2IxaE1mMUVYS1Axc001ZzA0UUkyMGljSmNhYm1HS2NhUGx3L1BhU0xM?=
 =?utf-8?B?WjlyejRJTEtBSUptYUdrcE9iTnBJay9mZzR1YW91NVFiN0ZGRVFhcHJST0VD?=
 =?utf-8?B?Z2c0RFAwa1N1Z202blpPOGo0RjZuQjdURlBjU3ptMEl2bFkxMTQzZklBUnY4?=
 =?utf-8?B?K0VUeE0xVk83UGpQanIyYWhhN1RjWEttTTBIT3YyaEk3ZUVVanVhWHd1U0VI?=
 =?utf-8?B?ci9MQjRJQjAxc2E3WUNhZFVnc2dEM1UyN3FHSmp3M3M2MVpicytJam5hM1pL?=
 =?utf-8?B?ZHB6eTBUSjhiWllaOWUvdXFEdG8vN1d1MmRBUExVZDdOWFhsckF3clBZcVhN?=
 =?utf-8?B?MEVYM1g1R2dpU1VyYXI1czFSTmtDZHdWWEhvWGtzOHRSR3RTdXRIc3RWSzdO?=
 =?utf-8?B?U3JzaE9LNjZjdE82aU1tTERDNGNTdEJlSmVONVNmUHo2ZURpRWgvUjhnYzZD?=
 =?utf-8?Q?j++z9pvcgK67cfcPppq4BR26B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686f736e-375f-4a6a-69d3-08ddc37b5a8d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:41:12.6969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xf4dsMqic7BuL2SdMdf1xs4UoblRApijV+CXNmywyTm9W20mCsSdwhFUC33AzSRy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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

On 15.07.25 10:19, Liang, Prike wrote:
>>> +   /* Validate the userq virtual address.*/
>>> +   if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, args-
>>> in.queue_size) ||
>>> +       amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va,
>> PAGE_SIZE) ||
>>> +       amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va,
>> PAGE_SIZE)) {
>>> +           drm_file_err(uq_mgr->file, "Usermode queue input virt address is
>>> +invalid\n");
>>
>> No error message on invalid userspace parameters please.
> OK, why can't give the alert log for the invalid user case?
> It's useful for catching the userq invalid VA/size case, how about change the error message to a debug level?

Never ever write into the system log that userspace did something wrong. That allows userspace to spam the log.

Only every write when the HW or the kernel detects that something is wrong. E.g. not responding HW or similar.

Regards,
Christian.

> 
>> Apart from those comments looks like the right thing to do to me.
>>
>> Regards,
>> Christian.
