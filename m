Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B9BCCA470
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 06:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61CA110E919;
	Thu,  9 Oct 2025 06:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YB1z7+un";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8933D10E919
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 06:20:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvbLBV0QDILn1xlbdsWLFLdwU3r+6DKPdOVOIOullRjca0bFDRFXdcMKxRxst+YQ2vwjNhJGVtIoeC20L12EvzCmEbGKTpx2L+O5etXxQTwom+tw1SiJWvY5c9nkhiHMR7jlikmmvrcQWUJIdeu3VvfDiCNbdsMs4shrkXfU5wX/y3odwMqqy9qNtDK98iqgw0JcMhrIZTmYiRd3fvAXZcEvTpPSvUPjXzo1AO03mLzPOPSmM8b/RCw2L8WiP7Gj6HeD3xAY7otY/imYFntKuZAWSlzfdjFGK/d0d0pulZeDA40JHvlk6iwpBpT/p4Ns0vOD9n1I5CivylRag9M8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbQjpAKd88gXwY22qVNObeC2JRVtrtCfeu8x0/SYVvw=;
 b=BQojN1GrfsYGX5K3+vVCRrpM2hIOyqd3xvrOZYH/V2ris4K8rEDt4YySmDMDycxdzCngIek8Gqrd+uUMcqpmbQ8jGF3Zsc2+A4UmAqEOIw8saMgyhMhIDN+WxVhKvV/CL/8CpdduCf+jtQGE1BxfPnk6jBDZhVoIO2/J6xLjMX6kadoF8gaq8suUYp/+MLXjOKgg/qY6yoFypSo8M2qu9jIPKhKEAyGf2hgZ9Gviht1UtYcJWgh4VOjLPGXCnpciNpnwqHVfFveq2XcE4Scen347oAsONJzOfWXsVtioj6g0x72iZBxIsJL+0aLqkPKinQIXIxGVqWcfglEXK4smlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbQjpAKd88gXwY22qVNObeC2JRVtrtCfeu8x0/SYVvw=;
 b=YB1z7+uns3eJWiedDB/vjsPNe9Ftb3mFvVXjPdU5KM9buASFAsH5+n6FkD++UuQBmI1IXyi1HQvAWqMk9D16WHaW+lq4AikUnZrSKeHBOsY8ZdrvNhKQ7TIsHJ0ZvQA8XPL2JVhmx+L7elgle6gnXuU8KpCSz9DpTgo1+aJDtSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 06:20:25 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::4be:bdae:b21:3fd0%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 06:20:25 +0000
Message-ID: <253c9618-12a4-4913-92d4-a3510e94c4d5@amd.com>
Date: Thu, 9 Oct 2025 11:50:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: drop VCN and VPE doorbell handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
References: <20251008191316.957075-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Saleemkhan Jamadar <sjamadar@amd.com>
In-Reply-To: <20251008191316.957075-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a1615d-56df-462b-bc19-08de06fbef34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWhBU2d5N01zTlBlUHZVdStvOXl0a3NTWWIwWXBGRG15aG44WnJjdnIwU3M4?=
 =?utf-8?B?WjFnTVg1ZDVRdXRmSGhnMjBDUFRYRDl0MERQekpoOWlLNXJONFlEdUdsSS83?=
 =?utf-8?B?QlUzSkN0aEpBSzZWQUp0dE8yMm5UUTJaRExiRWpzRHpaRksvanltVlRyci9L?=
 =?utf-8?B?K2laNytmWkpmR0JXbThNbUVjYnNEWElGZTF4cnFNM2tCVGtPVDdoeHhZSHNC?=
 =?utf-8?B?MUcxeERNc0tCY25SYnRVb3lQZ0dTT2NIRTY1WG8vcWIzV2tMYVFraVQvcGx6?=
 =?utf-8?B?MG5STkN1ZjNFRWJTUTNvYk83c08zRmRMSXYxN0pTaXl3WFNXbFUxVnY2OC9P?=
 =?utf-8?B?M0pSckdocXVWZ0NzYTNSTFNnUC9Xak5YQmlaSnRjaDBrWmJqTWhzVnpsQkhs?=
 =?utf-8?B?RUxXUlltMmVTcWdDRFhpc2piZjVJcVBOWkorOFRaS2EvQ3RoU0w5ZjB2UVpr?=
 =?utf-8?B?VnZTUS9FSHpKc01qVzZsM0ZURG5weGJQa1NQRmIxenp0dnM3M2dHM0M0Tzl6?=
 =?utf-8?B?cFBVOFlGamtwRElYOU5ndGxXczJyb3FOem9WOTd4b0kveXlCeGMwd1QxdFYr?=
 =?utf-8?B?WHVqbWZzSjdaNHVQazlyQU1ZY3FMVEFqenlwTUZ6eEViNk5lYk8wYS9DR25I?=
 =?utf-8?B?Q3Nlb0tDeTFCK2k4bFVqTWptVWVmVEVDQ3hibE04ZzJuUDJ5aHA3Z3pheGZT?=
 =?utf-8?B?VXJyR1FNb0xIT3J1SnV1UUNnK3c5KzVlRFdEbVc2cjZXWHJkNkM0aVBHdUZ2?=
 =?utf-8?B?T3RybzMzZ3JzMEU0bVN3Ynp6dGtYaWpLeUdiTDZpdEZGV3JlRTZFak02VEUx?=
 =?utf-8?B?cFRobWl0QnZnV2pyZ2ZyelhoZTluVXl3NEZadkQ3b3Z3VHJlYTRFQnFoVitE?=
 =?utf-8?B?NVpCZi9CU2E1MUZQOTM4aDBtZmJwS2hTOUpyZURJdE5STlZVQ21ZKysvZFpV?=
 =?utf-8?B?Q3dXeitveTZ0K2gxTVgrZ3ZZcFU4TDIvZjJtWUNLb2FwS001bC94RHd2MlE3?=
 =?utf-8?B?VVhhUUZTL3lQWmxuVktmdUMyeGpuRFgrRVhhcE1IdUZhaW9mSkZuOGlDVzNh?=
 =?utf-8?B?OWMxWlZzUE9CM2Q1NE1lMVJlL2o4VDJ0T0VZUTE4NzhrYjVCajlNaVQwb3Vl?=
 =?utf-8?B?dFdBYUNmSy9Qd3lwRVJ6bHcxTU5JWXdQZVZXRko3ZFpXVlZIMjh0RXRYN0xl?=
 =?utf-8?B?d3JSUTVHMU1WTXREL1RIRXk0L0hjbHZSS1RRbTB0WEJKOEdsVmE3RGY5UTIx?=
 =?utf-8?B?dzVMc0tqYk5OaHZwMFlESTEwZUg4U1h5d2NwdlZ1WkFwSnA4aFNGY0tUT0xx?=
 =?utf-8?B?eUFndmcreG5KTmlEZURyaEprWGJDSlkzdVRDSDFuUEcya0NTUCswMmFiQ1VC?=
 =?utf-8?B?am0rZEs3aVFPVHVPZnNYY2ExcW1pRUxhVHJ3WHVDekprMVpxQU4ra2c0SFFv?=
 =?utf-8?B?RU5UbVQrNG4ycUtSczE4ZXY4T3ZIdmp3cVVpQlhsSHVFQ1ovZnNqeEVIdW5G?=
 =?utf-8?B?QWJQWmU2NFJqbXQybUhoUlp1N3R0Mm85K3dzcDhKVEJiQW5aWEhzUmJsQk0y?=
 =?utf-8?B?RHQ1MStTUnpGZGdMbXgrMlRqRkFLb29vT2Zka3dUZFNnMUJLajBJSE82U1A4?=
 =?utf-8?B?bzVXN2YvTEVrcnZNZXF1K0ZuSWNUTzNqWHRNWXJodFVGWndSRDFaNVB4c0Za?=
 =?utf-8?B?bVoweTJiNisxa0NONkhJQ2lRaUpBZEhDbDI0YitDQmk4MDBvbVBGVWp3THIr?=
 =?utf-8?B?SFV2THN6TXg5dGNjUGl1dUlGMXZxenkvYlk0N3doLzVNYUdkbWhvcnkzQ3Jy?=
 =?utf-8?B?V3FsTEFaYnJtbUZLRlVyd0ZoYmh6ZGpiQ3l1UXFGWW4zNUphRGgvaXdjQjAz?=
 =?utf-8?B?Y1Urai9XTE1FNnJWMG5VaXUzTC80U2RSeFVHd3FoNTNpdUoxeFMvczUzVTVV?=
 =?utf-8?Q?DPTHYcfeS2tUoCny/P9LeYUCmns+Xkut?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2RLdUxOSXFGV0draTVWanBRdmVVYkdGRmxkTFRXTG5pNStYZnVKVUFiL3Az?=
 =?utf-8?B?aSt4dWlabzd4dTZZMXB0M1V1dXp6cmFvdDVZTlg2SXpPTUI1dnZBcStPd0Fo?=
 =?utf-8?B?UkFZYzhWL21vK3FPcnB2Wmpab29RRkpNV3grNERwOHlVTkxUMzFWMUFrdG1r?=
 =?utf-8?B?cytLMU9BOHVHcUNjYUxhR2FMTXRGWjgrcUJTdllUckNEZUJCWFY4TC8xOHlq?=
 =?utf-8?B?eXEvUXdzUFNPYWh6c2Q2RUtVM1NXdld4ZDJnOWkxK0gvb01XUlBtdEkvV2hX?=
 =?utf-8?B?RkRvYTlFKy9EVGFmdUhuK2RpKzd5Mmw2eHp4aVZCNFFwTHQrSnpDbEhVZHFD?=
 =?utf-8?B?TStPNlAzbW40WkdlU2FMb2t1OFAwcisxVk1MbTdjclcra2c3NWc5SHFrOWlj?=
 =?utf-8?B?NjRlOEFRa0J5U3o0WFZLM1ZtSGhIeTI4QW5Md2dEZkRyVmtQcE1URGFtYkZL?=
 =?utf-8?B?T25jdnZzWnB4M3NpRkdISkVvWDQveFhHNWtyMVRocno1Zk5CNFpyMmVhWGJn?=
 =?utf-8?B?TU5iQllZaVZrcW5VZlhPMFhqNlo1NXNvV2JLcjNxcjVBbmNSY3RIUm5OYjhw?=
 =?utf-8?B?UWUzOE5rdkNMRnEzUFZ4enlOK3VYMW9TZHVTbS9PZGwzV3pDMlcrbWY4MnVn?=
 =?utf-8?B?Z05BUG9YNXMrV2wzbzByc2pWdEwrU1l0c2paVDhGQzlnM09OVjk5NktiQWhR?=
 =?utf-8?B?RDM4b0NqcHB3ZFRkblBIdW1SN0FEN0ZZUkwwVTRXUk1SWWp1YUpXWkozS3Ro?=
 =?utf-8?B?eUFacjBaTStVaVMvK2V0a0tjQ0tiRzZnb1liVjNWaFhRRjZEWGdUTGVmQWtE?=
 =?utf-8?B?R1gwcVJ5aG05cTZKeU5oWHAwNjRFSktnTnpYL05pbUEwMisyRFF2WEc0QTJ2?=
 =?utf-8?B?R0Z6RXpxQjBweTB4UTEwMUZQenVTeWxWMFJXNkE2VTVSR2p4dEdRSUJOMjFZ?=
 =?utf-8?B?VzY2cXM4QkU4bFo2d0VvUElLMkJrQ01meFhUVGhQbXNReVdPZndtYVZvMklO?=
 =?utf-8?B?dnpUaC9RMlVESXVaaHkweExUQzF6QUZZMlQ5K2V1M3dJNEhqdnFrMHF4NWR1?=
 =?utf-8?B?emJucDZJbzB4RmJLbkhsd2hyWm9hZytOd2xmbzg0T3EvNUY5VS9nMndGbFlN?=
 =?utf-8?B?cjFueEJNdm9Hc0ZoYzcwVzMxTThhS002RkloU1RmRHdWbDlCL1RtQXVCbmNL?=
 =?utf-8?B?Sy9JU3FYTUhXNndJUVphdnh4STQ1ZmtjdXhHSGI0cnM3T1hCbzdkbE9IL0pT?=
 =?utf-8?B?NXIwNlFhQnJmNEdxanpPSjg4bktxZXZYTWxMYmNKRTQycUhWdWswbWNZbnZY?=
 =?utf-8?B?THVlNGVDRjJWMWUrbHR1Mm9SMzRVQ0VNUWkwc0pzYVJPRDVhaGdxeHR0UnBC?=
 =?utf-8?B?NVZKV1QxaE90VkF5RVpZUytwWWxNMDFPTnpKYW9YNWprWlJuYjhXa29IZ0No?=
 =?utf-8?B?MVRVVENlTTg4QW0wRjkyVWFJN1BPUDUxSWxocTVlbXBoOTNrRTdkNmVOcHhT?=
 =?utf-8?B?WnNLTGMweU9vUm1ySm9jalE4TElSdkxaUytwRzI4WUNQTUg4bU4ySWthL09R?=
 =?utf-8?B?UU9qRXVrWU11YUtqY0ZnYTJxMi9KSEZrdmVwVVJ6dFBsblppMi85aXVyaGZo?=
 =?utf-8?B?MmNTLzQrRnIrZ2ZPLzNvUjlGd2JLcHlMdTRBRlpoNWpYY3dVbkhoYnZlRHJR?=
 =?utf-8?B?ZmJWUk5lZFFJZFdSdTJNVnVNZlB0V0RSTFYxZDk4WVcrdnhycklUZFZRNHJs?=
 =?utf-8?B?SGp2eS9WY2EzYnFacnR6QWtxZG5yMlptRmxNYkJxUUZSK2U3MEl2cXhibDlO?=
 =?utf-8?B?M2dNcFlCQWVjWEhsUU9wc2N2UkdXM2U4QkdaYUJlUWdqMG0zajF4aldMaWJK?=
 =?utf-8?B?aFFTZ0syNDgrZlhJSVFLZ01UY1pXb000aks1eHdpbHdTS2NLWERzY2sxbWFs?=
 =?utf-8?B?bCtSK215T0p3anppRnRpdUxmYW9peTZ3Y2d2TkZ6STRDY1kyc2l3NTVzZHNQ?=
 =?utf-8?B?SnphODVPYW9acSt4aDZPWHZYNkNUc0FYTzF0SzNrQ0FlaXVBUWFBcHFMb0RK?=
 =?utf-8?B?WThEWmJ1dW9taXBFNEczbjlXZnM5QVpwWmQwcTFGejFmcXRQeXVUSHFCTFZl?=
 =?utf-8?Q?ncwRQgFesg0/aegr5+xP5Z6me?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a1615d-56df-462b-bc19-08de06fbef34
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 06:20:25.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIdZmPDfwYTL/QOBLQzgGsGJJr30eX1S1ETmNc8vMijI3JRWAhYo7RvxBZtVqn3malS7Op8UJL/1PMwUEEezYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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

Hi Alex,


With this change the expectation from userspace will be to provide 
offset starting the doorbell range received over INFO_IOCTL.

Change looks good to me, we will have INFO_IOCTL to share doorbell info 
userspace


Reviewed-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>


Regards,

Saleem


On 09/10/25 00:43, Alex Deucher wrote:
> VCN and VPE userqs are not yet supported and this code is
> not correct.  Userspace should provide the correct
> doorbell offset with in their doorbell page for the IP.
> Adjusting it here will not work as expected as userspace
> and the queue itself will have different offsets.
>
> We need to add a INFO IOCTL query to get the offset and
> range for each IP within the doorbell page to handle this
> properly.
>
> Cc: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 -----------
>   1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 8dc12064da495..916ce142b3c92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -319,17 +319,6 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   	case AMDGPU_HW_IP_DMA:
>   		db_size = sizeof(u64);
>   		break;
> -
> -	case AMDGPU_HW_IP_VCN_ENC:
> -		db_size = sizeof(u32);
> -		db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
> -		break;
> -
> -	case AMDGPU_HW_IP_VPE:
> -		db_size = sizeof(u32);
> -		db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VPE << 1;
> -		break;
> -
>   	default:
>   		drm_file_err(uq_mgr->file, "[Usermode queues] IP %d not support\n",
>   			     db_info->queue_type);
