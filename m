Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3964BC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 10:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49B910E8A8;
	Wed, 28 Feb 2024 10:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWI+GzLf";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1574510E8A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 10:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdSESIHje9lmNdOIXX919tr9D4DTBhEBLNuy/vhkJuHrw6vF8BUHJL6Nf/RAj7FcWflMG4FNIB175iPLfafmxM+I/j1N2Q6VoeDVB6zqsREKPMQ3Egkx3S0lNRnjVG81cfG+xy4joWEsB+SNebqoCi17SeCDUUljf6ZjCO8NbLIhVrhTmhDeY8XQlWCbHlFD+GiButkyAeeHVdimzbDJxxvwXuGHUdsKn+dCq9pbi3eB3IXYkxbARqcazUWXSnSCcyWQkgQ5vDZJC0I9zOSw/E18gTslSfwmgrftI9sVjHRA1PJK+VRb/3pBjhaPZai8TnUnvvMc2Crru59BGR81MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JZ2TXC1FSPKeApe1np7sQWLHRprULfhz7k17Ovh2C0=;
 b=gdNf0+Yn8a3jVDBwDQMqkmWviDVrtoVFFbYQ4dbigQyte24pUuMP1rf2+MU7i17DgQxtUdNal38PvRfU60gZzQC5OkQn6/km0xXnH6ZnTzuRD9izEw19HnFylVa+F2p7rxpQ5nfWnn2sWM0XMeyUUQUH8b/ewvr9hM5c+G3lPvIEhXVwzvK5PPzNggc7tNtPsQX/H8rHXsPCD/5/A6iNkiZGdm0uUyBGcT/+VkMYN9XlJjV0aPFA18Vd5imL0dFwEWxkO4UUg/L3y5+4ge3b8vjmnOv2iQnuT1v4IYqSX4MnuK8K7SdueKzh1CJ+xsk1DnUt7DFPefTLhzj9ZAvwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JZ2TXC1FSPKeApe1np7sQWLHRprULfhz7k17Ovh2C0=;
 b=WWI+GzLfyxH1L5Sq32ybq9JpO0P0aSt1nVy5+36yFqElHjsYJYhFtsq8pi5W3VHjnZYyzSSxziWnPFwhOiOvZZch608Bm51SQOMUanCPAzrXTWeRj1qQRc8UK0JZ+Q4xwaVdy6mbgt+lumQXOcwl9s+PA+QDz4ctgHF2UC3XaUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 10:04:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::a397:19eb:d2e8:a596%6]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 10:04:35 +0000
Message-ID: <39d49b9f-be42-4fa1-8976-68d6b7c09b58@amd.com>
Date: Wed, 28 Feb 2024 15:34:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix multiple truncation issues in multiple
 driver files
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240227163510.2934013-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240227163510.2934013-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 56134c1e-5bc3-46f6-a096-08dc3844aa5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3v0ueFEPgtPziI7JjqINAmOMBw/Embl8kz36coJsS9XNQZdVBf2u7SajR33eEAZ1EgL5B9e5iG75W9U6aGxXC4Bj3xJtv+0JA8YtbwFaEn6BlbwPuPPCtRIx609hM16Q8evBhhMthaAgNfAyD5GYEcnpik1Ms/Juf6erQgbnOaSK3zgVxn0pvoRLBEi++DZNlEmretXII4dNo0cIbLz9KxoHFjg0uZnYzFTx8znvLVpecRQvPVRgr5O55yR/z1acQspeh/WyhQSvRE6cw10dLzkfkBZuOmcX+sXQeut4cw2Wq7Er3sOTxIZIeMeiRrHeAleuc/GlDOGfCwZ9ytTr+pUUoDHdRXslZjBa/XgaUvFPnj5KYnZEQ4MNDxGpr5+ZJL+0YJ8IJPP+TiqTw8xEron5R0O+WVM8nk1DtPfZHqUoNkEHFF/IlQ4AEUMVJ2i03xNQyUm5p8B6+fyF/4hlhHBoKVHLZrJL66JrymWotnh9Cc9gQ/pXktxrzvDI4axcQCs/TqtMiItaUh1FQWDyLi5JQX1WsNQ7xHi+EPMgiAqm7GxmVhPiHWES4AT44plTN5lqvtNO5JvaaSKe0ZvvUAufpAFk0G2r8So4lcorgRyad0WF/7bRVi2H5fwGntShvxQjQGAdwTN5LLyYzfV8ABO6IA7KqJVQ7gF85rdi9hU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0x2QlpHSEF5RzdPclNqR1VYNFh0UjZXUUNOYkRseGMyMGY1RUNhOWcrY1BC?=
 =?utf-8?B?MGEwNDNMeFJvWmw5Tnd5TkFUdTJBMVlTaENNKzFBdUU0TXhnR1lqL214OVND?=
 =?utf-8?B?aXN5VlpQd2JkOGg4dzJZYTdWb1UyM2tBdkxDeEhNcXErV2hlZGlJWVZ4Z3B4?=
 =?utf-8?B?YkJ2Y3JoNFVteHAzQ29LOGRWcnlOQWtJZUQ4MjVIWVcxY3NIbU9yMEt0QTBJ?=
 =?utf-8?B?eDI4Wk1ncnZYS1A2L0JyeXpUVG9SQkJ2Z1dLU0lHRDZIUjBGRVdvaGpGWmlV?=
 =?utf-8?B?RFVQUUxibGtFTEw4U241VGZTYWF6cFJGQ1haRzFjMDhORi9aWjAvVEwrcDYy?=
 =?utf-8?B?WlRjODU5ZWVnZDU4YkxMSGVmalJ3Sm9wZkxMQlQ4ejEwYnFickdZWDMxREJV?=
 =?utf-8?B?NHJYQndKVEp5WFp4WWtFMmpwWDJucEthRzk4cHhNcEl1N05HK3c0dVljVHlE?=
 =?utf-8?B?Q3BiNDAwVGVKRENnS3ZXazNBNnN4QVN1YncxT21vNUEvOWNJN1VvR2tKak16?=
 =?utf-8?B?bStKbnc0bUdJcWlFNk1wZkZIZEJYUlloKzk5amMvdDQ4ekxHYjY2VG1mWEIx?=
 =?utf-8?B?eEh3b0VpamVVK1k1UTlNblE4UFpoUEVXU2pVZFFmU0krNSt0VGcrTStqT1NE?=
 =?utf-8?B?VE5PbkQxZ2ZaNGhDaE5jTVpwNWlNTHNxSndBMHpNSU81ZFpjRkdEbHFEekdM?=
 =?utf-8?B?c3J6blBWV0IzSWhSWmQ1VkZhSVIvNTI1eWN3bVZTRmJCWUJRNGxFY3pISDc2?=
 =?utf-8?B?aTlQVmJnYUUxeFBucWl3WHhiQmZSWnZsL2d3ZEg5MENBbUVrcjRObHpYNW0r?=
 =?utf-8?B?akVsYmc4NXFnT1FpdkFUdHpWWlllU0tQRGswdlZsQitQVWlRZy9oKzhsZDJa?=
 =?utf-8?B?WjkzYVZCWEJxa2UxYWU2WDZFTFVza3RxclhFdXFPOTRSRnJqVE5ZZGlhT2E1?=
 =?utf-8?B?MnpnU2RyaVdIVEdtQ3JXMklENU5FNGZEenV1cjQwZEg2eXZzUlhlREtEeEJh?=
 =?utf-8?B?ekdXSm9JQ0xBb3Z6L0ZkdjlQd1NqNzQ3UVY5bkRYSUJVTkJjYXVjSzZ2c25u?=
 =?utf-8?B?NUNYR1Z1RmZ4WFhZQW1uR0dvekE5Mm5IRkFKOVdCQzM4aHdJQ1AzY0tuTUta?=
 =?utf-8?B?aHhsOVBQemp5U2FEdDhqa3lXOWhwSzE3Z0ZvdTc5VGRoUEFvdzFnZ1Y5ZWVi?=
 =?utf-8?B?RkIwV0lTZXRmSTcyVFpMUi9BWUdsb0gybExPZWdrNjZVUUZsSXdwSys3TUVC?=
 =?utf-8?B?N3BIdThsZlJvNTJ0RHZlTWppZkFPdktyTWducEJnbXVMRTBMSnRFenNmM1I0?=
 =?utf-8?B?MElUR2VjQndrZ1BQVFhkYlplWHIxZXhrVVVaeWNucHJYVVV0VG1qSCtBcjlW?=
 =?utf-8?B?bHkyaURNZjlKOEZyN1VlSW1oYkJTb3FQV0dha0c3cmVuUkI3eWNCaVR3Zzhx?=
 =?utf-8?B?OUVKMWNXdGs2ZVMzT3RhcWVRSngzYXMrNVZtQ1h5cFNweUxGaWRUQndnYzdl?=
 =?utf-8?B?T0ZiTVNNVzc5TzZKUTZIK1kzeE5ZdXB2YmUzb1hXZEd5dDlyNGFEL3F6akpN?=
 =?utf-8?B?NldValJHUXM1ZTZTTmwrV0hGSExhaTVBTDE1MHYvSGdsS25aUHF4MzlBWG5X?=
 =?utf-8?B?RFFsTVlJaU5wdkZtOUovaElXNkZDcUhZTUI1bDJGUXNRUU5zVE9xRnZHTmJP?=
 =?utf-8?B?NG5FWjJlVXBpUWtlSFQrMWF1NDZzRDFuRmtESk80QjFuUDJEOU5VNExOZ3hV?=
 =?utf-8?B?Um9PeVhNVXR4VzNNUEpXTTIxNCt6MXZGaURZblh3N2Z2bFBIa1FTZ0xuOW1n?=
 =?utf-8?B?eGFYMnJtQ1pVcXZCV3k1eGVidFVzMW5xVXBmdGpYekVmVXRvUndwbUJLSW42?=
 =?utf-8?B?V2l5V29zZUtrR0FRcHZaakpTa0NyQlRYUDhlNGM4Q2dLcVVUM3FRS0pUclMz?=
 =?utf-8?B?VzdNcTBxK1lGT2JiV3RuOTFtQVgvSU1TZDlnaWp6ZjFaRXRXQjBlckNudGI3?=
 =?utf-8?B?N2Z5R3V6TDZRUTdWNmNCMEthTitXV0k2dGtqN1o4R2JhN1gwUUdJUC9Kc3NE?=
 =?utf-8?B?RnBnbGd3RkJFV2NLUC85Znc4dmNFSGZCSlNqdVRsMEpFTFJhT2tJcGFWWm5t?=
 =?utf-8?Q?39pqSx948odOb6MBJ0GD9yt3S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56134c1e-5bc3-46f6-a096-08dc3844aa5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 10:04:35.0274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMlmsaeAknKS4OqZS62SHnyLFCx7GqiB/q32mwpGDIbgLgpgvL5MbGlEztFCAwT+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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



On 2/27/2024 10:05 PM, Srinivasan Shanmugam wrote:
> Fixes snprintf function by writing more bytes into various buffers than
> they can hold.
> 
> In several files - smu_v13_0.c, gfx_v11_0.c, gfx_v10_0.c, gfx_v9_0.c,
> and amdgpu_mes.c. They were related to different directives, such as
> '%s', '_pfp.bin', '_me.bin', '_rlc.bin', '_mec.bin', '_mec2', and
> '_mes.bin'.
> 
> The buffers sizes have been adjusted to accommodate the maximum possible
> string size.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c:108:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:523:54: warning: ‘_pfp.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:540:54: warning: ‘_me.bin’ directive output may be truncated writing 7 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:557:70: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:569:54: warning: ‘_mec.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3979:58: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3985:57: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 1 and 30 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3991:57: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 1 and 30 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3998:62: warning: ‘_rlc.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4014:58: warning: ‘%s’ directive output may be truncated writing up to 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4021:54: warning: ‘_mec2’ directive output may be truncated writing 5 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1255:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1261:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1267:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1303:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1309:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1311:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1344:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1346:60: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1356:68: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1358:68: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1486:66: warning: ‘%s’ directive output may be truncated writing up to 1 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1481:66: warning: ‘%s’ directive output may be truncated writing 1 byte into a region of size between 0 and 29 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1481:66: warning: ‘%s’ directive output may be truncated writing 2 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1493:62: warning: ‘_mes.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c        | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c        | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 6 +++---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index dd2b8f3fa2f1..cfe82f399558 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1471,7 +1471,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>  	const struct mes_firmware_header_v1_0 *mes_hdr;
>  	struct amdgpu_firmware_info *info;
>  	char ucode_prefix[30];
> -	char fw_name[40];
> +	char fw_name[47];
>  	bool need_retry = false;
>  	int r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index b2535023764f..8e8cf44acfcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -92,7 +92,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>  int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>  {
>  	char ucode_prefix[30];
> -	char fw_name[40];
> +	char fw_name[42];
>  	int r;
>  
>  	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 691fa40e4e01..c91283b38b02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3961,7 +3961,7 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
>  
>  static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>  {
> -	char fw_name[40];
> +	char fw_name[50];
>  	char ucode_prefix[30];
>  	const char *wks = "";
>  	int err;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 0d90d60a21d6..9cde763bbc3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -509,7 +509,7 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
>  
>  static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>  {
> -	char fw_name[40];
> +	char fw_name[46];
>  	char ucode_prefix[30];
>  	int err;
>  	const struct rlc_firmware_header_v2_0 *rlc_hdr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7669f82aa1da..ad2a5c6ecb93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1249,7 +1249,7 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>  static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
>  					  char *chip_name)
>  {
> -	char fw_name[30];
> +	char fw_name[46];
>  	int err;
>  
>  	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
> @@ -1282,7 +1282,7 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
>  static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
>  				       char *chip_name)
>  {
> -	char fw_name[30];
> +	char fw_name[53];
>  	int err;
>  	const struct rlc_firmware_header_v2_0 *rlc_hdr;
>  	uint16_t version_major;
> @@ -1337,7 +1337,7 @@ static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
>  static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
>  					      char *chip_name)
>  {
> -	char fw_name[30];
> +	char fw_name[50];
>  	int err;
>  
>  	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 48170bb5112e..93a1b730726d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -92,7 +92,7 @@ const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
>  int smu_v13_0_init_microcode(struct smu_context *smu)
>  {
>  	struct amdgpu_device *adev = smu->adev;
> -	char fw_name[30];
> +	char fw_name[42];
>  	char ucode_prefix[30];

At least for swsmu, we don't expect fw_name to require more than 30
chars. Instead, expectation ucode_prefix to be shorter like
"smu_v13_0_7", "smu_v13_0_0" etc.

You may refer a similar fix done here -

	5575ce213241 drm/amd/pm: Fix warnings

Thanks,
Lijo

>  	int err = 0;
>  	const struct smc_firmware_header_v1_0 *hdr;
