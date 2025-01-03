Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082EFE7718F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 06:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B052D10E808;
	Fri,  3 Jan 2025 06:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uIWZLm4L";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D5910E808
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 06:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJquBSpnKkc7ccSWFEMWjuttIUX1Fbelft5Jxf7ZfVMp9wr5EA9rPWfnUgtcIXwg+NNUcNf56eojNl7oKZTuDM6oBxY37wk0XG1EPje3bdeQszTlk8WuHZ+8OP3BrujPFPkYl29rDQ76XHY8tKMG8d+pBcbONtoIJiFjMKWxSiKT8RVtCfMpDPPnLA1Qaq4i2U+UDXUN+AzVde7FfUL+Enc/p8GesVmBe0eFBIt6t+tcLnHk6hONp3192Y8DKh8V8hZ9JsR5GwFXZS4kNisGOCyENPNNufaIbTnLJT3N62k2PBV3/pnEXXHFrydWKA+SZtwvsXIPLVJCiyyXk666dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQiCmmC42hu1aOP8ELDXup9mHIwaPFEDBBznLJ+JYds=;
 b=tWNLhWj9T2XD9YlnDCA66/kJpgTf6PD0S9vgWl/uZweNepf9Ip1tVCJMNynivjSMppKVPhXUKZFsVM/WcKqnOsmu5FvWyrwZn6jLrcOPkV8NvOYR2ugR7JIajmpomiv6qSPjGaGynTfTXkwbXb2QD7jjPfINc2CoXwN8afTV+9p4ZS+2x+uFuhGH0HDe22hGucFVG+DHG63JSC1cMXciB/j+KMm6tr3SUyhkYOIKF8tDKvKN8xOcHcjp9c4QzYG2x0kwgwvTuG4m1D5zg5+Oohn2NfRqc5G3qn3Uae+C5Dg1EUxEykeFtYk/zqux29MglAjua+fQVIR2dOvaZCMTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQiCmmC42hu1aOP8ELDXup9mHIwaPFEDBBznLJ+JYds=;
 b=uIWZLm4LQIyIZUSUQb82l5zeEedcwwqyPZqIIX1+C2MvIzW8JOQnNecnNn4rIrPF7hUGuPCDsEh1EYp4Atpldnl2w/wUaNENH0CaXqa3sP8KIRsTNNHlqhQJSKmyZFXTPq0VEhqsUE59cHVYoBcsE0Z+AFokI8tu63bGTKYE+dk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 06:43:56 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%2]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 06:43:56 +0000
Message-ID: <17480d64-d72e-4903-858a-7f7d914cd390@amd.com>
Date: Fri, 3 Jan 2025 07:43:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [drm/amdgpu]: user queue doorbell allocation for IP reqs
To: Saleemkhan Jamadar <sjamadar@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 veerabadhran.gopalakrishnan@amd.com
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250101060338.402215-1-saleemkhan.jamadar@amd.com>
 <5d460846-9400-4821-a371-72388093f85b@amd.com>
 <7dd29048-2d87-4583-a43f-b4fc5c69c06b@amd.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <7dd29048-2d87-4583-a43f-b4fc5c69c06b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 57172863-4580-450a-5ecb-08dd2bc1ff19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzFMWnRsWUY3Y3hRck5Zc3Nra3RSdms4MXA2OWozaWRnNkFjQWFaOGlEY29D?=
 =?utf-8?B?Z2hSL1BlTWVnODR4STNicUhCbkhEQm5kNnlrVDE0TzU4TXRZeGtFZkNudzU4?=
 =?utf-8?B?QnROZGJyRlFGSUZXU016eTBqamU2aXhudDByZXdIM0dnck1sNWJlVEZ1ZTRr?=
 =?utf-8?B?dHp6cW43YTIwMVArOGhPMFlCVTQ1dU5FaUJ4V1RLZWVNL1ZybnVlQUlKazFX?=
 =?utf-8?B?Njk2T09mMnVpUGZtZk42bVVWbk95U25rV0xheEZ3MXhhUTZDcVdUak53aUlW?=
 =?utf-8?B?SVI1NnM5OXI5RXUxblBnY3pCREtxaVlLVkxJbWxLcDdvc0hHTU5JU3ZnTFhQ?=
 =?utf-8?B?c3dvWHpPdGJqTW5JdEdlNG9saUhqUnhlZlF1a2hnTWxESnRTenNuZm9KMCtK?=
 =?utf-8?B?WE1pb2FNRmNrRGE4V2NmUG5qblhUeWZwaTJBTGNqd040Z25hN05vY3dlRFdj?=
 =?utf-8?B?SUhmaDRpV2NxZ3NsdHJhazNMY3BlYmwzcWdGUjVqQXd4MHpnRmF5RWRaajNE?=
 =?utf-8?B?eThSSWJmV2F4TnpIaEpQU05LSEc4TWI0aGhySG16Um9uS2JIaXI4R09JNmpT?=
 =?utf-8?B?NTk3dTQ4dHJva0x0aVo3dGpTbkxjNzh1MC9RYk13bDB6N093YUVEN1o5Umto?=
 =?utf-8?B?Y2krdzgyanJoRlNWMXNwcHdldFd1NnJvZVZFZGIwU2k4RHVKMmdYWU9iUWRs?=
 =?utf-8?B?SWh1WEZHM3RqOHBRSzZkVWFocDJENXVSazc0MlkxbzlVWm9TT1g0QVN1dVNq?=
 =?utf-8?B?SFk3M1htV1BKc1dlMU03blNpc1RHdDhzMTZGU3FjWFRkRzdHSllqZ2V6cnNM?=
 =?utf-8?B?TEZvMzlCYnBFd2R5QlRiU2l4dTZqR2psNVRhKzJCRXFWVHZGcDk3YkhhQ2p2?=
 =?utf-8?B?bEtZUEx3UklVWjlXc2tZU25wbWh4SjFEdW9WUjdIZTMyQ3JSOVpSbVZLeloz?=
 =?utf-8?B?NjRpMENtcnJRM2JoQzJvYkNwa2VyVG5MVHVNUE1JYWhnMXpMWGdtMWJwZldh?=
 =?utf-8?B?S1BUZmxwWXVGZ1pCMWwzVnF0UmVJU2lXQms0Wk9BakJsaUppeHgwNXd1bXNj?=
 =?utf-8?B?a3V3bURTb3FlZXhhQjV1KzNWOGNGV3gybHBRUDkxVGZ6STNiMElDc3VONWx3?=
 =?utf-8?B?RWlvdkp1NzlhZGlTVXZYSWJIK0tGRTVMQk5uYWpVdXFxUkRzUWk2ZG9LVWxn?=
 =?utf-8?B?SW1mM0VESDVRbS94dE16YkRuMVNHUFh4eS9rZmtNZHE3bzlUcXN2bjJ3UjBr?=
 =?utf-8?B?T2hNdzVISWRhaWpNckFESkNGNjBCdERacWs3Ni9VWDRjUU5HRmVuQytKSEZS?=
 =?utf-8?B?aHQzbnBiT2x2TXhBclV6S0tIR0dTblpTb0xXZ0FiMlVZeWRKVkYzalp2V3VY?=
 =?utf-8?B?MWc3SGsxK0ZoUU1QT3lza2NTaG14UkIvVTVCMXJqbXp3OFNNOFBwQXpwWXlr?=
 =?utf-8?B?a1lsOVdiczdHMmlMWGhnTU94eGRSd3ZqUWpacjlBdm1wZmw3K2JkcmdQTlJv?=
 =?utf-8?B?L1dxSW84TktrbVhGOGVwM1VTbHFhUEsxa3c0TXo3NGwyem1RVlg5V3orbDZz?=
 =?utf-8?B?cGcwalJkU1Q5VzJXZGVXM0o1SCtzOUloazNiUitJZ0UrM3FyUTN5NnJkYzVY?=
 =?utf-8?B?QlFYYnRieTUvRFhjOHdkSjhXdEwvZE1lVnQzSHlDR1dZVlY5TC9FNnB0OVpR?=
 =?utf-8?B?V2ZGblVWRGFPZWNHWmEySU1oUmo1dFR0UVVNM1N5UkhYK2JTK3l2ZlFKNW9x?=
 =?utf-8?B?VVFWYU5LdlRERTA1N1F5OUZ2cEFEcnY4THJrMjJNN2c5MC9yUTNubXIzMjgr?=
 =?utf-8?B?OGJVbTF2WlBPazhpZ0JLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzI1ZC9wUGZBUDNXQlgraEw4MEFtdVdCVTF6cU84NXBEOFQwTVRIbGxhdEpj?=
 =?utf-8?B?UHpzcnR5bVVFNGZ2OFh2S2JHTzBXeXk3THh2QWVnbWRWVjFieXY0Z1FtdCtk?=
 =?utf-8?B?OXhPSEdDREZIbEdtejRwNVJXYUQ5NlprT0d1ekh5bmc1aHJFY244Qk1DTklY?=
 =?utf-8?B?WWxGWFRBbzZucG1vSjRKM3c5REN5L3dsSUxhTDMzTVVraFNCVFRySTByU0FO?=
 =?utf-8?B?d2lJTEdpUVlRWHQ5KzlEZ0phVGZiYnFoUit4ZHVTSmRJQitSRHBqVkpoNThh?=
 =?utf-8?B?RHdCTndkY3FQUStVeDVKR3lxN2tJejFXL2MrMTAvaFJUc0RJcmNhZlpGV1FV?=
 =?utf-8?B?UG5YVTdlbkRsYTFJSitIamFvOUZuSXoxbTRKM3BtODdBbHZEb1RiVXJ0RHpR?=
 =?utf-8?B?V0c1QlZRTGlDaSsrVWxWN0g5ejZ3dk1mWGs4SlI0TFJQd3UrK2dnVnVPams4?=
 =?utf-8?B?SnlUZVVON3M3dGRyOWpGcHAxUXFwdDk5LzlEcDVzYkNSR01mek41SytuQ2FY?=
 =?utf-8?B?SnRWRnQ4LzhWbGJPc1NRTSt5Y0VZZ3dDdzdraURrOHN2RmkraG5oM2R2VkVk?=
 =?utf-8?B?a05VMklueEJTSXBDME14KzNnaEdJaHZMeFY3M0JDWStUOFlhdGNGU2VkZklE?=
 =?utf-8?B?ZklKY2VVcW5qZ1NERkF0L2V0TkNCVTQ0aDBXRzRYWWwvdjdEeW5VTUtpcFhM?=
 =?utf-8?B?SktlVGQ1RmM3Rm9BWkJvUU9YRVRxVThHYVUzMnB2Zk42ZVNpa3REUHNlbzNE?=
 =?utf-8?B?THN3dW5lNzJqRFdJTFZJamxtNElSVTV6YUZQWWkvTXRmdUw1TG53cEc1YjVk?=
 =?utf-8?B?T0xTRVBNbUhWWCsxZklaaTRmYmw0cEpGcGJOQmcxQnlENDdtWHBEN0YxeWhO?=
 =?utf-8?B?MGFWVkJtNmR3Y3ZtRXZ3L2xHeG1DMk9oRXVjR0VwcUdJaEJYL2gwdDZWNWlh?=
 =?utf-8?B?MkJpV2w2REZhdTVRdW5mR2gwU25rR0FNeHlnbjJ6OXBTVkxwTUxHMHVyYjZN?=
 =?utf-8?B?dVZ4UVlHVTltWjJOU1psc2kvcnFGM1Z2c2dIMHVtN0RXVEkwd2UzUkVLdTdp?=
 =?utf-8?B?eFpxQ1VoQjduVVo4dEY0SG5mczhYOFRPQU1ndS9GcHdrRDRGalh1WHhWSitM?=
 =?utf-8?B?TjZRQ2s2QzBFOUVNbmdqTVVLOHZBdlQzcG8yWHB3d0tia3dpY2FnS20vRG5L?=
 =?utf-8?B?a3Y3VFpxQjV3bVh6QWV0N1FLS3dtYUtEb2x5YVhYc0lmeFdzSkdTcXlHdVoy?=
 =?utf-8?B?cE52WmtpL0xzeXJPNFFPVGZwM0xvTkxCOHZZUUxGVXJyWWRFU1h3elh5bFdK?=
 =?utf-8?B?c1BYUWNTOTJLaE9waDlGU0dMNXZkZnNNeVlvS1hSSEZoZ0dEREFQSlppeFVZ?=
 =?utf-8?B?NUtZOGlISktWNUxDa28zckZXcm5GZ09QZ1htbjgwaEoxdk1RYlRTNm82K0Va?=
 =?utf-8?B?cndJbkF5SnFGQ0hGWmJJU0FKMmdDVEVRRXJ6djViemN5b0pST2lZYlNUYjZS?=
 =?utf-8?B?alF3dGFSdTRCSS9aaEN4ZHRwL2UrZ0dmRm5OaEtwRWdkUzlDeWQ0eWlIZXlk?=
 =?utf-8?B?M0RTYVdMV0gvQzFTenZGaUFDZHNrQTQ1eVJxcjdidkQ0VTZwWXJlSGhjNlN3?=
 =?utf-8?B?MXRDa3BvaTJ1NjN3bmdhNWhnYTllbmdjY1Vvc1ZXY3ZiZUVleGZjV1VUR01u?=
 =?utf-8?B?aWdEZ29Cb2RlN3BTcWtkdW9ZWXFvU25lZEYwSlNQZ0prcjBCT0l0aXhiQWNo?=
 =?utf-8?B?N1A2c0ZIaDAvSTlBUjdWYW5maUU3eVY0QXl2Ymdtek9TMENVdEM4cDFSOVVq?=
 =?utf-8?B?Zi9aWlp4VVQ3cmZRTGRHdThRLzFyWmJjc1UvUlJQTnBUZGxJRG10OGlPUlZV?=
 =?utf-8?B?b3VQRFFnRkczbUhYUFNmZ2RqUHN5RXBRV2VJUStiRHZPTG1BamhualpsUmNj?=
 =?utf-8?B?TkhKMGw3OUpoUDJpeW5BVmErSmZTZ0ZuTVlHdUpmMFVoUWhvQmZhdFYrMmFu?=
 =?utf-8?B?b1FKUmgra2JWZHVNOHRvMUg4MURtYUxSMXBCblg2YkRFR0c1QWdqSjFwTllI?=
 =?utf-8?B?WExTOXBKdVllZVdNM1VmQnNrM0F3RUQwdjN6TjlaUzNuQmVBMm9EYUs1L0Rn?=
 =?utf-8?Q?7Q8W7W+mqWXnruOYWFD31pvoV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57172863-4580-450a-5ecb-08dd2bc1ff19
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:43:56.8379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHlSs0gyhgq0fwTzcAkOG4NjwCN2+RGMsJcDWQOzuxuMpiGQUIouocjkSKQR6i9zS1HsyLwss+TiouRUlIm8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
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


On 03/01/2025 07:34, Saleemkhan Jamadar wrote:
> Hi Shashank,
>
> Replied inline [Saleem]
>
>
> Regards,
>
> Salem
>
> On 02/01/25 18:58, Sharma, Shashank wrote:
>> + (amd-gfx)
>>
>> On 01/01/2025 07:03, Saleemkhan Jamadar wrote:
>>> #resending  patch
>>>
>>>  From 79cd62f882197505dbf9c489ead2b0bcab98209f Mon Sep 17 00:00:00 2001
>>> From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
>>> Date: Wed, 18 Dec 2024 19:30:22 +0530
>>> Subject: [PATCH] drm/amdgpu: user queue doorbell allocation for IP reqs
>>>
>>> Currenlty doorbell allocation handles only 64 bit db size.
>>>
>>> In case of VCN we need to allocated AGDB and per instance
>>> doorbell.VCN/UMSCH doorbell size is 32 bit and offset
>>> calculated is from specific range from the allocated page.
>>>
>>> With these changes individual IP can provide specific reqs
>>> for db allocation.
>>>
>>> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 41 
>>> ++++++++++++++-----
>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 12 ++++++
>>>   2 files changed, 42 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index cba51bdf2e2c..4fff15e0d838 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -163,18 +163,17 @@ void amdgpu_userqueue_destroy_object(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>>       amdgpu_bo_unref(&userq_obj->obj);
>>>   }
>>>   -static uint64_t
>>> +uint64_t
>>>   amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>>> -                     struct amdgpu_usermode_queue *queue,
>>> -                     struct drm_file *filp,
>>> -                     uint32_t doorbell_offset)
>>> +                     struct amdgpu_db_info *db_info,
>>> +                     struct drm_file *filp)
>>>   {
>>>       uint64_t index;
>>>       struct drm_gem_object *gobj;
>>> -    struct amdgpu_userq_obj *db_obj = &queue->db_obj;
>>> -    int r;
>>> +    struct amdgpu_userq_obj *db_obj = db_info->db_obj;
>>> +    int r, db_size;
>>>   -    gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
>>> +    gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
>>>       if (gobj == NULL) {
>>>           DRM_ERROR("Can't find GEM object for doorbell\n");
>>>           return -EINVAL;
>>> @@ -196,8 +195,23 @@ amdgpu_userqueue_get_doorbell_index(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>>           goto unpin_bo;
>>>       }
>>>   +    switch (db_info->queue_type) {
>>> +    case AMDGPU_HW_IP_GFX:
>>> +    case AMDGPU_HW_IP_COMPUTE:
>>> +    case AMDGPU_HW_IP_DMA:
>>> +        db_size = sizeof(u64);
>>> +        break;
>>> +    case AMDGPU_HW_IP_VCN_ENC:
>>> +        db_size = sizeof(u32);
>>> +        db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 
>>> << 1;
>>> +        break;
>>> +    default:
>>> +        DRM_WARN("User queues not supported for IP (%d )\n", 
>>> db_info->queue_type);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
>>> -                         doorbell_offset, sizeof(u64));
>>> +                         db_info->doorbell_offset, db_size);
>>>       DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", 
>>> index);
>>>       amdgpu_bo_unreserve(db_obj->obj);
>>>       return index;
>>> @@ -242,6 +256,7 @@ amdgpu_userqueue_create(struct drm_file *filp, 
>>> union drm_amdgpu_userq *args)
>>>       struct amdgpu_device *adev = uq_mgr->adev;
>>>       const struct amdgpu_userq_funcs *uq_funcs;
>>>       struct amdgpu_usermode_queue *queue;
>>> +    struct amdgpu_db_info db_info;
>>>       uint64_t index;
>>>       int qid, r = 0;
>>>   @@ -269,19 +284,23 @@ amdgpu_userqueue_create(struct drm_file 
>>> *filp, union drm_amdgpu_userq *args)
>>>           goto unlock;
>>>       }
>>>       queue->doorbell_handle = args->in.doorbell_handle;
>>> -    queue->doorbell_index = args->in.doorbell_offset;
>> Nack, this is going to break mapping/unmapping for GFX UQ. Nothing 
>> should be removed from the queue structure, as all of it is accounted 
>> for.
> [Saleem]:This assignment is not used anywhere, moreover it gets 
> overwritten with mapped doorbell index below.
I see that your patch is removing the mapped doorbell index from the 
queue as well, whereas the mapped index of the doorbell is required to 
map a queue in the MES (see amdgpu_userqueue_map() function). So that's 
wrong interpretation of the code that its not being used anywhere.
>>>       queue->queue_type = args->in.ip_type;
>>>       queue->vm = &fpriv->vm;
>>>   +    db_info.queue_type = queue->queue_type;
>>> +    db_info.doorbell_handle = queue->doorbell_handle;
>>> +    db_info.db_obj = &queue->db_obj;
>>> +    db_info.doorbell_offset = args->in.doorbell_offset;
>>> +
>> I can see that all the information you are adding in struct db_info 
>> is coming from queue only, then why to add a new structure here at 
>> all ? Instead, you can just do this in function
>> [Saleem]: In previous impl you can see that db_obj is fetched form 
>> queue structure. In case of vcn we have mulpitle doorbell to be 
>> allocated, to accomodate this and to avoid the another level of check 
>> to identify which doorbell is being allocated this db_info (structure 
>> used locally) helps. db_info shares data for which allocation needs 
>> to done.

Nope, there is no difference in information available in the queue->* vs 
db_info->*, so its duplication of code for no apparent reason, so it 
doesn't make sense to use this here in the base/IP independent UQ file. 
Just update the doorbell offset as suggested before in the queue->* 
itself, and then if you want to have this structure, you can introduce 
it in the vcn specific implementation (vcn_db_info*) and move this code 
which you added here into the vcn_userqueueu* file.

- Shashank

>>
>> amdgpu_userqueue_get_doorbell_index():
>>
>> db_size = sizeof(u62);
>>
>> switch(queue->queue_type) {
>> case VCN:
>>     queue->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
>>     db_size = sizeof(u32);
>>     break;
>> }
>> [Saleem]: This change I can make.
>> <same doorbell offset calculation as usual>
>>
>> - Shashank
>>
>>>       /* Convert relative doorbell offset into absolute doorbell 
>>> index */
>>> -    index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, 
>>> filp, args->in.doorbell_offset);
>>> +    index = amdgpu_userqueue_get_doorbell_index(uq_mgr, &db_info, 
>>> filp);
>>>       if (index == (uint64_t)-EINVAL) {
>>>           DRM_ERROR("Failed to get doorbell for queue\n");
>>>           kfree(queue);
>>>           goto unlock;
>>>       }
>>> -    queue->doorbell_index = index;
>>>   +    queue->doorbell_index = index;
>>>       xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>>>       r = amdgpu_userq_fence_driver_alloc(adev, queue);
>>>       if (r) {
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> index 2bf28f3454cb..3d54601c6a24 100644
>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> @@ -39,6 +39,13 @@ struct amdgpu_userq_obj {
>>>       struct amdgpu_bo *obj;
>>>   };
>>>   +struct amdgpu_db_info {
>>> +    uint64_t doorbell_handle;
>>> +    uint32_t queue_type;
>>> +    uint32_t doorbell_offset;
>>> +    struct amdgpu_userq_obj    *db_obj;
>>> +};
>>> +
>>>   struct amdgpu_usermode_queue {
>>>       int            queue_type;
>>>       uint8_t            queue_active;
>>> @@ -93,4 +100,9 @@ void amdgpu_userqueue_destroy_object(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>>   void amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr);
>>>     int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
>>> +
>>> +uint64_t amdgpu_userqueue_get_doorbell_index(struct 
>>> amdgpu_userq_mgr *uq_mgr,
>>> +                     struct amdgpu_db_info *db_info,
>>> +                     struct drm_file *filp);
>>> +
>>>   #endif
