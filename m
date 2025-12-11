Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C920ED3E79C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 07:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C97F10E088;
	Thu, 11 Dec 2025 07:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uvcbk6Ba";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB88110E088
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 07:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbFo0JbRdpreO2vCiH5hh1vqHGiBW3QAvWbMqWm2b5ew71urRc3Hu1mXnEllj7sYjh4GNR9oboNcjoX1VnkIi+MvEK4qc16Z5O7bbO6PL1mUmyUCTOOEQPteq9TE39kFc6KLdwJ7eT7K3bIlZiiB058dY/1F51ySg7PERgZkqdxgJEOLy7iRI0+xZYaETzAeW63ZIZl8YQFgDS7jP3xd/OWh/5fdqSen5FyjlWy0noqGBKUCDVSP/Jj6GaDjWVqGTFqe5z3OJvLimoWZsFmHvChCWhlsIfWTZoUUnpaNcFCD/98pRZlvvWuYKDwA+e5gIKyt47ItUf4LKjLqHnHNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjR8Y6bmR+AmgEW3dm69oqe31HL06Zdjcy50aE+5LZM=;
 b=WnBr+tUQwnrm5z/AhFjT5Lr1lHEWNme7X6Vei9gluVaA2moMVgwWaO0g/1v86STpvjItN3NZBlG24x/nBCDrYLE6Dg+WKekOcm6gUXymAaFaepv4oURC8VjsK12QVurKaDypGCE8G7DTmvIclBaDfmyuF+N2xW4zOSX5ZbDxoFlYX85R9gWOJQMGARBuMUk13E1rI7kNJ8Iwx+xMkcFkIa6NqpwjigAS9qVjVlL4BKIhAFwNQsZhm6CXlEyHIwPwpjbuCfMFFFGCGrod7pZAclGSArwA71B0VoAvAuYdGt5piz16k1wOmYa6xlLoE2AKSGLwoSvfIWnWe8PBiavYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjR8Y6bmR+AmgEW3dm69oqe31HL06Zdjcy50aE+5LZM=;
 b=uvcbk6BaSVSYKPEdK54MPZXe3uE0fNU3mAxjsJhHevQR30zWEainEAmiBnZfWvkQndOwKSnNlk8FETOKyCslT4qUko4RRlJeoWLG+3VYj3LkXKMt2X4BYF/TKKzgOU7ijCySO4bRzuQrwzuqd4C0a+UXIEVNRo5PeuxkOM+w8XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 07:15:55 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 07:15:55 +0000
Message-ID: <f075e9cf-4e76-4345-be59-644014fa08ee@amd.com>
Date: Thu, 11 Dec 2025 12:45:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
To: Matthew Brost <matthew.brost@intel.com>
Cc: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20251210202347.63243-1-alexander.deucher@amd.com>
 <adf41aa5-3172-4e9e-9bfc-c8b853b7c0c0@amd.com>
 <IA0PR12MB820858B3F15710B5E2C6255B90A1A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <14ea9e1c-0deb-4d2b-8bea-ef95300b753c@amd.com>
 <89b93863-b8ef-4629-979c-5a3d1e906594@amd.com>
 <aTpnGZQjQUbuxcsq@lstrano-desk.jf.intel.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <aTpnGZQjQUbuxcsq@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::31) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9d8ab5-e0cd-419d-d7fe-08de38851fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zzc2Z2h1TkFkSjdjQytCWTNFb1dXZnZybmErUFdoNU1DV0s1OHh3WkI1TGZr?=
 =?utf-8?B?bitPVnhxOVVZOGJrUUJYMkdqS2NINXhxdGdtWW0xNlI5OTVTY1Z5R050cGJ0?=
 =?utf-8?B?OHlzaW1PSDVkdlFvOFlxK095SEdnZjRUaHFhQ28rN2VIVnhTUUMxZXhFVVFJ?=
 =?utf-8?B?eFp5VDg4R1JNN1RBQjVWME9INzV3VWcvb3Njd01PQ2pML01TRHFoOUlSNFo4?=
 =?utf-8?B?MGNEdnZ6bnF2Z3RiSUtGa3Y0cTFtMkhWdzNVWkE1Z1hHbVBmTGpzN1piSy9v?=
 =?utf-8?B?enFaSWJMR1pQN3JtME4vTTNRcXlXK29nSFZVTEttQTVJOFZXOUdtT3cxRUV1?=
 =?utf-8?B?aGJqMm4vK2doK0lvVFlJY0k1TTMrVVQxWWtWcEdad2J3M1BzbFdkTnlQWGxB?=
 =?utf-8?B?Y0lJR1BXTkpacTYvUndTaUhVUG03dlZoOHpCdXJZaG1iN3d1YkJsUDhnanY4?=
 =?utf-8?B?eTEzYklwVHUwaDNYMno2eXBidkM1WDBGYWdWQ09aSVhMbUF0eldValV5YU9o?=
 =?utf-8?B?T2JhZlcyMU95bzh4dlM4dEZwOFpNdlRXbzJZRDdIeXdnZW4vQ1FCV2tRVysv?=
 =?utf-8?B?MDIvaUg2Q1UzcXRSeFFUeEtvb3o0eGxtR3JkYTZ3U1lGU0JjTFZhcGVweXF3?=
 =?utf-8?B?N3hGRk5UL2EvSXh5Q2ViRmxhQW9nUGJJMm9JaDVaK2QxUFFsWmhheGpJWi95?=
 =?utf-8?B?eXF4NDljL3pqVTJLVTJJbmx0V1gwV3duYUtFR2NlWHBJTk1kWmJLWnNiR3hS?=
 =?utf-8?B?YlZsd1ZlcEV0cGhJMklBS0xwVUdzMWNsTkFDL0tsck9taU0rQXp4aDlhL25q?=
 =?utf-8?B?SlZiQWFnTzhmUmI3N2YxcUc0SGRIeFRVNFE3dWdXcm96U0c3QUNEbEVBMWVm?=
 =?utf-8?B?VzUxRm1udjkrbm5GWXU2LzZuUWIrZjAxMGdJZUx2cVRrUkVQR2QrTXNiWmRk?=
 =?utf-8?B?QzZNZ1VPOVp1U0xkQkJ6T21hR3pRQTJCVEhLZi9jRTQyZzZXZWhuejNRcHR1?=
 =?utf-8?B?cFBDdkl1eEp0czV6dDNSM0dZLyt2ZzZFMnVsa3FEZXpRZ1dLSjgzNmxwNi9o?=
 =?utf-8?B?UVNRUGU4alZvUktFVW5rdXQ0eHlVUkxDNFoycUd5QzBTNTFCeE9FVGxuMlp6?=
 =?utf-8?B?Ly9FOGsvblc2eEpkMXNIbWp1bVEzS0Yva3N6OXdGYlExb2k1LytGUU1OUHlW?=
 =?utf-8?B?TkFuNG4waHV6MTVzS2lXOHhxNTlWOG4yTDliZ0xEMVJ6dkd0TWxheVduaWky?=
 =?utf-8?B?eEo2UmF2STZJeVhBUEo3dXpSYnpNd0JjbHh3SzlxTDNwYW5GeVQ0MEthc0Vw?=
 =?utf-8?B?UnQwcFZKUkFTb3FrNWtsY0oybVpSa3M3cnVSUVRHcG1tZTU5ZmVpWXNkODFr?=
 =?utf-8?B?UzZOUjNwaWdObk5KS01oOXJ3NTlORnlWRTZLV0l0NklOY1FSdzN4SmgxUjI1?=
 =?utf-8?B?VGNpNUgvWUoxb0RpZk85OG1nNW40UTdDbG1rTkRwTG5BMGMxVVFpeWJBcURR?=
 =?utf-8?B?Y2t2VkJqTzlsY096UnJNdnoxN1VvY3pLSzBUcndNUlFkSDMrRTg0TU9Hbkpv?=
 =?utf-8?B?ZlFiRmdUMXJmQmpFbkluSEFhajRZSExNU1NSeFNCMHJ0SmRTTUdRQW1wWkFT?=
 =?utf-8?B?ZlpRbmw2MGxZd2VIRGRSelJTRHI3WjZVQ21sQ1hXQXJaSVZtNU14UlZXeWlD?=
 =?utf-8?B?NWtkVVBWa082LzFWZ0J3OWRKcEU1U3ZoczE0SkNXRzZEemRjQ1BaTGFxZXM5?=
 =?utf-8?B?clZDUXBtTFQ4eldvTUtaNFZhYk55bm9sUk1lM2l2ZHdSdktjR2d0RkZabDVN?=
 =?utf-8?B?WmFkTFI1NDREK2tZMlBTNytvT1JDcVF4ZUxSRFVHcWEvOE5DOWdqUC9pSVpy?=
 =?utf-8?B?ZjhEOTN6MS90L3k3RXQvOGZwNWViMmpwV0x6eHE2OStVd2ROK2tyLzdGRC9j?=
 =?utf-8?B?TzJyQ3NtRThUbkxoSERJcm5ydWpqeklqdjRoZXFXQStVRmdHcmc1K1BwUGVR?=
 =?utf-8?B?MEFkSlQ2c2xnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmF3VUt5V1RMNEFzdkxpbzc0TkRselB4N2l2SHJMbUt5ZEo5bjN6ekcrZk9j?=
 =?utf-8?B?WUUxYlFvYlNCNjJuWk14Z1g4QW5PdThRaUNYRG9JdjVyS0pUSTBXLzB2Rk5H?=
 =?utf-8?B?ci9XMFVtbGc2T2FsZHFUbThuZ3BRaHRkaW1KMzl4RjNSeEpBZUU0cFpremJw?=
 =?utf-8?B?Nk9IMEVKRHp2c3FOWUlDVm5PejZWOVdxTHF6aWFpNG1jUldmVjhjaU9KMHNE?=
 =?utf-8?B?dXk0cUVkdUkzOVpvZjFXMzRVUzlPUkV2b3VycHpnaFgxbDg2N1NXQVdyVTl5?=
 =?utf-8?B?TWUxVlBUMGlEbEUxYmxrQjVuZnZIVzFTYk00RXZIUWZ1NXFDQXM3bnplbTlE?=
 =?utf-8?B?RHVQRlhCU2JQUU5PSUFhWjVLR3NBV0M0TlNzeDVveEJuRTdHaWdxUjROMDU0?=
 =?utf-8?B?SXlyUjR3MzlxYytVVnA0WVMrdEIvUTRGWHJUM21xOWpydlh6dXk3RXBBaFVh?=
 =?utf-8?B?MnFyc3l3Q25aNzNRSnhOZFkwN2RRSUIwSVJXUEtLaHBkVmxEQ3E2NkJUSHJN?=
 =?utf-8?B?NjQ5UnorWW55YWJkdjZrNDkyTXZaWVNJR1dUWm5xa09WaVNZMWF1eUNFcHhV?=
 =?utf-8?B?VDFuN3RXeUFEQk52cG1WR0hNK1hhSmk5bnZLeFBUWWtldTV6SlZ4dEExbzFi?=
 =?utf-8?B?TWVNN2ZCcDNCcGJGOERWMU1NSVRQelNKbEUxSWRCQXVQbjB5WXo0eERmbGdJ?=
 =?utf-8?B?cEtodkNOaTgycnlKdWRwTy9xUFJ5TEh5a0p3NWJxZkVqT3hsWnptcWw2V25B?=
 =?utf-8?B?RkJYSGhkM1loc0d5dk9ONi9sb0cvcWxWK1I0Z25YSnBPODVLa1Z0cHFZWnR3?=
 =?utf-8?B?WVF5aTV4YjFyaW1OaUUvazJKWWNWQWJ4VlVOVng2cTF2RGZlTVpneFR2TWoy?=
 =?utf-8?B?aGVXUVVyVWJ0dE92QkhiN1E0Nkc4bHJyVWk1S2lCb2o5bXptdSsxakpVQW03?=
 =?utf-8?B?NDVzZStiWnMvWnVmSXZ0YTJrUGZjOGlCclgxWWhVejE4Ykx2RU03SG1tOFRG?=
 =?utf-8?B?SlI4QkpmaFZ1cEdDdWNUVEZIbktZdmJWMDJBY2RSZEhxcWpPaUkyTjJCWHRu?=
 =?utf-8?B?S0VyKy9YU0UxRVU4czdzM0Mrb29Tb2IrU1dQeVoyQ3dHQ3RIakF2ekRiWlpN?=
 =?utf-8?B?K2lLdVUyYkFVVnNoSVR0OGtMUXd0NEd5ZkV3VXdnbktaTXFKRlVNNW5OVXhV?=
 =?utf-8?B?dWNveU1BZWRYd3F1ZWtRN2J0OGJsL3V6TDREZXFsNnR6UjNhc0kvRFU3dlFD?=
 =?utf-8?B?V1puYXl0VTRxVExZaUxTYy9DOHFRTEE4eks2ay9Lb2l0Vi9uaDFaaUpaSFIw?=
 =?utf-8?B?V2k0NFh3eVpIWnh2cDRnZUdBSzVCc1Rud1B2RTVzajRJQUNoalhKTTZmK3RE?=
 =?utf-8?B?REI3RzI1ZE5XRWltK2tMVlBPZS9lelEwL09CODVwc21VeTlvaEZWck03dS9z?=
 =?utf-8?B?Q2tWS1JkbUlmNHJody9Wd2tqd1k4ZVlyTC9acFR4MDI4VWNudTVDZ1liTXAx?=
 =?utf-8?B?aWhjZmtyd0J5THE4Zm9RRVBOc3ZlckR4M0lwRmZuMTdxTmMxM3cwcllRbFNP?=
 =?utf-8?B?WlhGK1pKZzVXUFR2d2cwRHlHVmwwSnpDaDIyWmFRYTJCQSswTFBkdXVBWS9P?=
 =?utf-8?B?MWV3bTM0NEVHY1dpVEtXWkZiNldSTDVTZWlUUXlYcUErUzlKWDcwQVdCcjAw?=
 =?utf-8?B?RHZBZUR6d3ZieHRQRFkvVGhudzVmRVlMMFNaRTNpOVNscjNKQXBKc1FsdmtZ?=
 =?utf-8?B?THozaUkyV0JsaXVuUmJ5THp0a0J1NlZ4aXEwamR1Sm91Tm5ISzJSM0tYdDBR?=
 =?utf-8?B?NFp5aFU1a250UzYwQXI4ZXppZk91THlmeVhqc2ZsdWhBekhLa2VMZ0RjWmNV?=
 =?utf-8?B?SmQ1RjNTUTNnYnNoZnh6WFp6b3pyd3Jxc2xCN0d5d1Y4TFhPcGpJWkRWdEoz?=
 =?utf-8?B?Y0ZHQU05VHNrZ2dWYW1nN05FU0wrUTEyamluVDhSSElaVmljY09hNm8vTkVF?=
 =?utf-8?B?aHR0dXRHWURYZEg3ZUw5NzBWR1Rud2xDVjdzSHJsTFVMb2NGRUZPTW5MRk5E?=
 =?utf-8?B?WWpiNGJMU2x5aU5ub1ZCQSs2ZWxOSk9tMUxUYndjekxCRlpyZWNWd055QnRs?=
 =?utf-8?Q?dz04v5uINavjTGdWixgGQIjS0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9d8ab5-e0cd-419d-d7fe-08de38851fa4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 07:15:54.9981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fHmAT6F76Ch7BjJioD8/Wjch+gUvoJ9haZU6d9NYlmJDQxhDyZcv+Wdeoh7N1PG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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



On 12/11/2025 12:09 PM, Matthew Brost wrote:
> On Thu, Dec 11, 2025 at 11:37:58AM +0530, Lazar, Lijo wrote:
>>
>>
>> On 12/11/2025 11:14 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 12/11/2025 10:52 AM, SHANMUGAM, SRINIVASAN wrote:
>>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Thursday, December 11, 2025 10:34 AM
>>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>>>> gfx@lists.freedesktop.org
>>>>> Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>>>> Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Koenig, Christian
>>>>> <Christian.Koenig@amd.com>; Matthew Brost <matthew.brost@intel.com>
>>>>> Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
>>>>> recovery
>>>>>
>>>>>
>>>>>
>>>>> On 12/11/2025 1:53 AM, Alex Deucher wrote:
>>>>>> Avoid a possible UAF in GPU recovery due to a race between the sched
>>>>>> timeout callback and the tdr work queue.
>>>>>>
>>>>>> The gpu recovery function calls drm_sched_stop() and later
>>>>>> drm_sched_start().  drm_sched_start() restarts the tdr queue which
>>>>>> will eventually free the job.  If the tdr queue frees the job before
>>>>>> time out callback completes, the job will be freed and we'll get a UAF
>>>>>> when accessing the pasid.  Cache it early to avoid the UAF.
>>>>>>
>>>>>> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
>>>>>> Cc: SRINIVASAN.SHANMUGAM@amd.com
>>>>>> Cc: vitaly.prosyak@amd.com
>>>>>> Cc: christian.koenig@amd.com
>>>>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> ---
>>>>>>
>>>>>> v2: Check the pasid rather than job (Lijo)
>>>>>>        Add fixes tag (Christian)
>>>>>>
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
>>>>>>     1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 8a851d7548c00..c6b1dd95c401d 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct
>>>>> amdgpu_device *adev,
>>>>>>       struct amdgpu_hive_info *hive = NULL;
>>>>>>       int r = 0;
>>>>>>       bool need_emergency_restart = false;
>>>>>> +   /* save the pasid here as the job may be freed before
>>>>>> the end of the reset */
>>>>>> +   int pasid = job ? job->pasid : -EINVAL;
>>>>>>
>>>>>>       /*
>>>>>>        * If it reaches here because of hang/timeout and a RAS
>>>>>> error is @@
>>>>>> -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
>>>>> *adev,
>>>>>>       if (!r) {
>>>>>>               struct amdgpu_task_info *ti = NULL;
>>>>>>
>>>>>> -           if (job)
>>>>>> -                   ti = amdgpu_vm_get_task_info_pasid(adev,
>>>>>> job- >pasid);
>>>>>> +           /*
>>>>>> +            * The job may already be freed at this point
>>>>>> via the sched tdr
>>>>> workqueue so
>>>>>> +            * use the cached pasid.
>>>>>> +            */
>>>>>
>>>>> amdgpu_device_gpu_recover() is run in tdr workqueue.
>>>>>
>>>>> Now if this is the case, someone has to explain the logic  -
>>>>>
>>>>> Timeout is triggered here -
>>>>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/
>>>>> scheduler/sched_main
>>>>> .c#L559
>>>>>
>>>>> This calls amdgpu_job_timedout() -> amdgpu_device_gpu_recover()
>>>>>
>>>>> After that, there is this access to the job -
>>>>>
>>>>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/
>>>>> scheduler/sched_main
>>>>> .c#L566
> 
> Yes, the DRM scheduler is broken. Luckily, if free_guilty is set, the
> job isn’t in the pending list, so it won’t disappear. It is actually
> safe to touch this in the above code example.
> 
> Complete nonsense, yes. Is it safe, barely.
> 
> I feel like there is concept in Linux which solves this whole thing.
> 
>>>>>
>>>>> At least, in some condition, job is not expected to be freed.
>>>>> Then I'm not sure if this
>>>>> is the right fix.
> 
> It isn’t. Fixing DRM scheduler is. But until then, I’m fairly certain
> your driver won’t explode with this patch.
> 

Thanks for the details. In that case, I think this description - "via 
the sched tdr workqueue" - may not be accurate (assuming the real path 
is yet to be traced?) and be dropped. Instead, it could say something 
like under 'certain conditions' drm scheduler could drop the job, hence 
avoid accesses.

Apart from that, don't know if the "Fixes" is really required. That 
patch assumed sanity from scheduler. At this point, this seems more like 
a workaround for drm scheduler issue unless amdgpu timeout handler is 
also doing something unexpected.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Matt
> 
>>>>
>>>> What is that "someone", "some condition" you feel like? Its better
>>>> to bring proper justification, and take up this as separate
>>>> refactoring task
>>>>
>>>
>>> Basically, if scheduler code itself is not expecting job to be not freed
>>> after timedout callback, then why callback handler needs to assume the
>>> same?
>>>
>>
>> Taking out double 'not', following is what I meant -
>>
>> 'if scheduler code itself is expecting job to be not freed'
>>
>> Thanks,
>> Lijo
>>
>>> Now if callback handler does something else which in turn frees the job,
>>> the fix needs to be there instead of having this kind of fix.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>
>>>> Best,
>>>> Srini
>>>
>>

