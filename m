Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9646CCAC592
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 11:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8E410E424;
	Mon, 22 Sep 2025 11:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Jrzd/lO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E009710E424
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 11:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v30MIRfBlcl8BdIizMbkRLIpWqRWFyVuz9bT42nXhmUt9z+GxISRH9Ru1cbP/I8WdI/KuqSLFqPzox3e51BI7RclR5KVUxsDpFKOgUjBL2vZYAtAaAABROaKAoU3C2MUC38DYDxcScOq0FqZcZNvx86n+fC6Yg9musTq4ieBM6X3ftEXMjUpv3g42bl/X7CAfvphmLWvv33QsD38ryaZlEUZDUSWA+As4eYlBhvD/LkJfVG3R1xzd+1EmrMMMVXRAmQ8ylLWeOr8AdBbLoU8JUVVlp3xhV3zPQ8cP35l9CRSbaLFibjXwMRp/NWfhG3tVaCGUyi2CZCdqp+iIcTZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuSZJG1IbLBxQssu4pdT2G6oD2C7IlelTcUBWorNhs8=;
 b=OQ2a17jkd+kK89MDiaIkmqVOaHOILvwJpkpUeimGxnw4SiVK1kWwV5mVQG34kVLT6St3s5K6JZjwIlHtgierTo9u17e9N/x7t6ZkMUoz3eXhJZ1Y4TL6wvjuepwiUdqQn+e+Ovup9chDpLgZvGqckQM6G1x9JK4UD15tQ46gxGSpxVS/wDdhpY+6T0WXqz0uu6THoMQ+jFZQLpEh2HrqVlWu+FXOMkQicXLSH2kIaiLFERsMpaXT24CtTzpheMAfmfiEio6cAoY8cJFYV2NySIdNyA+M7e4vxFMI9GNkpw7unnxkfu2jncudscfB4W8cqmdq0Rcap+XxenZUEDcJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuSZJG1IbLBxQssu4pdT2G6oD2C7IlelTcUBWorNhs8=;
 b=3Jrzd/lOOvejPGUCHqEAQi9Bjtsw3Tv9gIs3+GsTWH8VtYqM+AemJ/A8ATp85GuxpQJ3mcBnXTTFAwXG1jieakQBtkNLwJPg/ZqN8P0G7X2NbL6yIHzIuVg7Be+fkRr3uyN5RFv9c+U7+0FxqLaXLNRdF4QcYnRy5KS4kRCQUow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 11:27:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 11:27:50 +0000
Message-ID: <ab4e2e75-0e36-485b-86d3-9daf345033cd@amd.com>
Date: Mon, 22 Sep 2025 13:27:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdgpu/dma-buf: Add helpers to map/unmap BAR
 I/O with dma_map_resource()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
 <20250912111148.833465-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250912111148.833465-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: a42586cb-5f25-43b3-c520-08ddf9cb1035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1RwVzYxN2tUcklnZWlueUQ2ZFBLblhiZ2NOMnorcU5Ucy9sZGx0T1hJQmUv?=
 =?utf-8?B?OXlUdENPWUEwaEdHZENycWdBNUw3S3NCU2V3ZjFQYy9HN0FnWDlYWmEwQkN5?=
 =?utf-8?B?Rjl5QzFLdVVtQmxDU2hMZ2k3aEt2TGJEbjF3YVZVOW84Q1JPYmo2MDRma0Zn?=
 =?utf-8?B?L08ybzQrUFoxcURmbzN6UW03Nzl3ZzBzaXUvRzhhODFTV0FmTmhubm0wQjhK?=
 =?utf-8?B?eDRHdHdNcUNuaXdpeFZMZHpGYzNZdU12bGFsSkNiZXVXalc3QU9mcDNUb1FU?=
 =?utf-8?B?ZHJHU3Q3SEF1NFI4dGZwZWp4d2c2eHdVc1FNdWJqay83WFgyczB2WnJMeng2?=
 =?utf-8?B?L1hJdHZOWHQrbVRSUmpURTZoZzY0VndCNHhFVHZjMHNreDFzZnY4K08vK21G?=
 =?utf-8?B?TVVEamd5alpTVHFvNWE3eTI4aDVHRGZUN2VQTk9iWXZORnNFZGR4N1RPZEJD?=
 =?utf-8?B?WFQxWk1Zbmcydnk5QXdYU0VQbmlCZlh3aTY3M01JQ1R4YTdrM0Q5SGVXZ1FK?=
 =?utf-8?B?dzdGNWhaOGloT2pYWWUvd1Y0V3NnOW9tUTlnZ2lxakxWMHM4cTNsUXhCMW9Z?=
 =?utf-8?B?ZmlJYXBUTDdHNDl2dzRZdnkrWm1DdGtXaWI3SmhYL0FMcUtLcG42VVlWNlFa?=
 =?utf-8?B?UlBHVFE4Y1FLNU9FWDV4Nmh5TnhsV3VzbFUrak93VWFydmdhclRkeUlxODZu?=
 =?utf-8?B?eWJOZTZvN3FDd2IwUmF2N2Iyalc0RWRacTVhWWluZkJoWG43d3B0ckhNckts?=
 =?utf-8?B?UTRobEZVQ3VHbDRjUGNTOGxuY1FGTlI0UWlLS01DL25JQ1pFZzR0WmFaekdw?=
 =?utf-8?B?S2ZhOXJjNTdtcHhPb1k3UTNubmFETCtSTUJnOFJTeVRNQXhjdW1kc0xqbVdQ?=
 =?utf-8?B?US9DdTdUejgyeVpyVTdmOTA4RTRZeC9LL1c5dU5wanQveHcvRjJ5SmJPUHls?=
 =?utf-8?B?aUdLVHBPaTBrNnU5aFBuM3ZqOXZQMk1GRUVCS0hsT2d6YVczZzhRNW1LeUtR?=
 =?utf-8?B?NUNZNVcyWVRVTjhzenVrZnNTNmJiK2VYNlMrMVJ6b2FscS9zOTM1NDZUdWlH?=
 =?utf-8?B?T3gyTWMxckd1K2NyZW16VkxBSlY0b2Q5SFp0NXJwMk03eDg4Y0Evbld6RTdq?=
 =?utf-8?B?cHlMbjNOUWR0dHlPRmlVSi93T1FodzM0dHdPS0NGMnV2dW1zamhBMGpnTW1h?=
 =?utf-8?B?YU0vdnZxY3V4VzZVZk9VL3Vjek5tWk1XZWRTZEFaMXBGS1JsRDBQMi8reXBX?=
 =?utf-8?B?VmpjUVlYM0dHRXh6WGFwSWwxTFYvRG1qUHk4c1gyV2U5Q0t5MmJNc1U1d1Z1?=
 =?utf-8?B?YlZhc3RudGtibnpXbzRqb0t4TFluZXlXRC9aUkFoODBFNDBZb3NjbjVnOE5q?=
 =?utf-8?B?NFVnRlZCOURjZTF0eldzVzE2NmVmUjh5eHRzUlhMVG5TbnBWY0orb090ckxq?=
 =?utf-8?B?RUU3ZDFnSG8wU1d5VFJMajd2aUxYa1l2K215R3BuS2haRVVna1Q5UnVBREJj?=
 =?utf-8?B?MDFySklTWlM5dWdyaTdwV2RpQVJiS1VQZE05dWNOZHA5azVzS090aWUzUDdv?=
 =?utf-8?B?VEVtNGVCYWgrRWo2ZkhPK2dzY3RvVWYzQm5aaDN6VkZVdVVPMjNiZXFFbk9o?=
 =?utf-8?B?aHN1VTR2OTRWN2JLT3pSYlJ3ZEZZVFpjMWtQRUd6bGNGUTlHelJtblBRK0Vy?=
 =?utf-8?B?VGk1enRpOXJEQUhsQ1hLOHZEMHdxamFtdUpqb2dEcjhHMThqVXdlc1RMTTZN?=
 =?utf-8?B?SHpoTGw0eHlFZXFDbHJuOEFwZFlCL2ZZUFNhWmladVlWTTJZY1E0THVyQWl4?=
 =?utf-8?B?a0g4Rkt3Q0tDTFVkUWdWUE1SOFRydCtZekVxL0YrS0tUR1RNOWdHUnJob2d6?=
 =?utf-8?B?ZFo1VE5IMEprUVFNcGhWRy93Q2tkZkVwbUtZZWUrTkpsWklYakg2dWhEMWtR?=
 =?utf-8?Q?spaGAFM+6HE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnlrbHpRTUp6K1owVTk4RHdpY1EzZ05qd0ZoMnBqSGlNbkJ1Njd2Tkc5d2J2?=
 =?utf-8?B?aFNrVFU4UUtpc2cvNExNU3JPREttTmY2eXRaWmVGUlkwV2V0ZmdMUDdDQ1ZX?=
 =?utf-8?B?d3dxSmNlL0dnRTRBMkE1aG5XanJ6WkRPMlBPSnBSN1JZN0JELzlrNTZQUHFD?=
 =?utf-8?B?RnBkNVNxN1piVjJpbDI4RTBxQ2lueUp5VWpaSHNkR0hCZTdlYTZhSDlmRHZq?=
 =?utf-8?B?ZUlPRStmcjdnZjN2QldlSXlQYkd0aGY4MnRHQlBrbklKMTA2RWN5NHB6K0JX?=
 =?utf-8?B?eVk5cWpILzNjeXZrY1hYTnFGNUI0ajQybzRCdGZxOXBnRC9vU3BqaE41NFhX?=
 =?utf-8?B?YnE5NHJ4dlV6Z3JqUUY1UTBKSlhTQWdGTGJWNUpSaUYrdHk0cTlCQWpVWjZx?=
 =?utf-8?B?NTdaWVVhUS9Id3FPaTIzWkVFcnRTcHl3VVhsQ2xQR0RsaTNjNnZpQUllaVNQ?=
 =?utf-8?B?MFZ0Z2ZoTVAycWk2VHVrR3NodllDNWc1V1p1OFhYNXJtMzRYd2xRQTlQU3cv?=
 =?utf-8?B?cWcxUnF1bFh1Q2pWTGo2cG5ObEVPdmhaUjl0SlNKb3cyYTAyaVNOYzdya2hC?=
 =?utf-8?B?Wlg3QlorbXMrd1VvcDd4TDEzTmx4WWdOVEtMUENiRk5vWWF5RWFNRDRnS2JJ?=
 =?utf-8?B?bCtlK0hEQWZnaCtHSDQ4U25mcGxRUWdaVUlxQm00TnV2eVBEbFR0NCt3eEti?=
 =?utf-8?B?VDN5M2FScUhzSHRTeDJYUXE3WXVxdVVLSEVvNU55VU1ySU52VDRTVi9sVHVh?=
 =?utf-8?B?STZRaCsyMVhhOUkrQXZubmJJQU5YbEVTTE1pTFhnWWJwVFNFWElVeXIzKzkx?=
 =?utf-8?B?UnFoRk04V0dlbGxKYVpEcFBEVXMxSzJxeVpObEpGOEFMdUl1RGxwRWJoWlFW?=
 =?utf-8?B?RzZLNkw2VDJab2FsNlJ2ak94QTJ6emF4TS93dktXcXBqZHZIakl1MG9TcEgz?=
 =?utf-8?B?dzY5ZzAyZFFUT3NKRDdZeGxYVzcreXFNM0c2S2FuZGhtNjlyeSs3azRWUldG?=
 =?utf-8?B?OG9MUGFHYS8zYk53a08yQUs5TUJ4all4Y3Y3WEJ0LzBLVTRzQ3dXRGpiRG9I?=
 =?utf-8?B?QnR3ZmdLSlNnblZoZFVXY0EvQUNXdmFTTGV0ZDhJVHNFNmI2SnhqbzEvWUxF?=
 =?utf-8?B?alE5bEtDNDFJUjd3WW44ajZRb0hKRk9wVUsvYkh1UlpvdXV6THBVQXY4RXNY?=
 =?utf-8?B?UGI1RWxkT1pUMVFYTEdCT2hFZ0FSYTloTzU3bWlHYnNnRDRvTkJTNys4MkZh?=
 =?utf-8?B?SWdCTjJTSGcvWU01NXFvUzFLeXdEd2FaekNxN082elpERzNOdnNpNWQ4Y1J3?=
 =?utf-8?B?NFdYV3BIelh4QXFBbW0rd2FGamVhbndKNUxOL3dNaHljcFVBUFJNakp4Q0V2?=
 =?utf-8?B?dU41K3RqZjFOb1g4cWprUnJtQXZYS3NLeFA2ZmFsSjlia0FqVExtNEVsK2hV?=
 =?utf-8?B?SlhRQWhhcU1BaWVIYTFWR04zYmsrWmY0blM1NnZNbERJTElGRUptVDEzamhV?=
 =?utf-8?B?QkljaU8xSjE0L3dJUitiWEowVDZuaE5CVjY3Zk05VDNGSVpUd01HS000NUJW?=
 =?utf-8?B?UURxNVMxZzA5eGJqRkdiVzUrZ0VCbFc3K0JsVXRiRkJHTmZzbUFEWkpWSEIy?=
 =?utf-8?B?SVlPelMrSk50TktwQ2M2SGRXYzl0MFdsNmYxUVJSSnQwTnZrSDlTUDh1Ykh4?=
 =?utf-8?B?ZWsvRDNZR0xOT2F1cERPdUZ6cHE0L0lpZTl3cWcwZHZNYWJCdnlYL2FQRERP?=
 =?utf-8?B?OG9ZOERvZVRNS2MyK2p6dVJLcGc3VUUrV0lNZVZDOHo5MnorUzNlcE84RnBk?=
 =?utf-8?B?UGFYVWJScnlMejZDU0JqTEhwdDErSkVRTmNNWEVEekxhS25BcUplOUI5VDZI?=
 =?utf-8?B?SDltd3hJcUNNS3d0RHY5ZVFHZ3REcGlKblZzY3lOcTZ0ZDcvbHZ0T0s1OHNp?=
 =?utf-8?B?TXBXTzMzVC9MMjhBWkZvSzN2OGxaREF0ZTQwRjV6bnNHc2laTUExVlRkcW5w?=
 =?utf-8?B?bUQ4MmZWNHYyRmZ1VTJLcFdzK2JwekwrSlhjZ0w5V0hpK1JtZ00rdGloK3dr?=
 =?utf-8?B?VUZuSjZFSzU1WE1TK0w1Q2RYYmpIOWl6ZmNWSlRlcFlyanpybk1IaDJUOERM?=
 =?utf-8?Q?oNBfJqhVb6G6edoQ5lO5t9JkG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42586cb-5f25-43b3-c520-08ddf9cb1035
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:27:50.3837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUq0fmKknePt9zq1GcscsjAwkQQGldzC8C4Jpa4R3TsaxbUmU8a10NYftbdB55Ly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

Please squash that together with patch #3 in this series.

On 12.09.25 13:11, Srinivasan Shanmugam wrote:
> Add helpers to map/unmap a hardware MMIO register window (PCI BAR) as a
> 1-entry sg_table using dma_map_resource()/dma_unmap_resource(). This
> will be used by MMIO_REMAP.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 51 +++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index ff98c87b2e0b..33fa17a927ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -37,11 +37,15 @@
>  #include "amdgpu_dma_buf.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_vm.h"
> +#include "amdgpu_object.h"
>  #include <drm/amdgpu_drm.h>
>  #include <drm/ttm/ttm_tt.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-fence-array.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
>  
>  static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
>  
> @@ -146,6 +150,53 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
>  	amdgpu_bo_unpin(bo);
>  }
>  
> +/* Map a BAR-backed I/O span as a 1-entry sg_table via dma_map_resource(). */
> +static __maybe_unused struct sg_table *
> +amdgpu_dmabuf_map_iomem(struct device *dev, resource_size_t phys,
> +			size_t size, enum dma_data_direction dir)
> +{
> +	struct sg_table *sgt;
> +	unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC; /* no P2PDMA attr */
> +	dma_addr_t dma;
> +
> +	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
> +	if (!sgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (sg_alloc_table(sgt, 1, GFP_KERNEL)) {
> +		kfree(sgt);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* No struct page backing for I/O regions. */
> +	sg_set_page(sgt->sgl, NULL, size, 0);
> +
> +	dma = dma_map_resource(dev, phys, size, dir, attrs);
> +	if (dma_mapping_error(dev, dma)) {
> +		sg_free_table(sgt);
> +		kfree(sgt);
> +		return ERR_PTR(-EIO);
> +	}
> +
> +	sg_dma_address(sgt->sgl) = dma;
> +	sg_dma_len(sgt->sgl) = size;
> +	return sgt;
> +}
> +
> +static __maybe_unused void
> +amdgpu_dmabuf_unmap_iomem(struct device *dev, struct sg_table *sgt,
> +			  enum dma_data_direction dir)
> +{
> +	/* attrs must match map side; we only used SKIP_CPU_SYNC above */
> +	dma_unmap_resource(dev,
> +			   sg_dma_address(sgt->sgl),
> +			   sg_dma_len(sgt->sgl),
> +			   dir,
> +			   0);
> +	sg_free_table(sgt);
> +	kfree(sgt);
> +}
> +
>  /**
>   * amdgpu_dma_buf_map - &dma_buf_ops.map_dma_buf implementation
>   * @attach: DMA-buf attachment

