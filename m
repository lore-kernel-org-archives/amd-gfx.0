Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A89D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 05:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511A710E667;
	Wed, 10 Dec 2025 05:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rGoaTWKt";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D2D10E667
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 05:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d95ckfBlT6CZu0lam1TClyxpHFp0hYMXGF7l6iv7/bwC7QC+7N0IiNGJSD/ldrBvBqueT7lAszG+IMLzCGHb19JEQrqzXD5FctdqZ+DUX5NchG6FEhAdg6FNOtkXaFQYg3NpLxmjOsyx8C4LlCvQ6hSYz3kktEDr0Bn6TuXChqSintbEkPYjwCgwM1wsmc8MLzSkJWBEZiqy76dwovBpmASixYDx3xah8YDCqJfA5Cf6DpaqVbUoD0QyNKx23VAOToTWc8SXnR/4u23xKBT2XMh7bvyPq/tRB7fmujAJTOaBSUclhHgjX/321UlfTQyHrdughPDLhJuCdtShXIvO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=906aflfwrXNkd2fVu4C7ql0n1aNrndikdj5rSZRARgI=;
 b=WE1amDVBYhSS6zVBEyRIIsSssQ3RgCcsLrEqeVPB2Z1VUPhlaCmfsTSWd0bFLjAPryPB+urVnRe//lWNzKdtW6lQhegAMPyB7KAoX/VAYjbZ7QofqrIguXyXuuDp6523oakLdMBVLuxRyckbanb0c+tmJkLYKBJYokZ715357C+HYvZoNObVqbXcLgSWNH5tvY3Wwcqi+KiKLTegne4iudppEpnqffuziqZyeGHPNA3L8Ze0R6AEzGtJUdZdqpmxw2OOpKZmEb9YGfHFcefSNg9NV8Fy0EJYBDeqLNAEcFrw7/hM7oXylp9AY4327WJtijrYceFYj1Lv9hP7SjECOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=906aflfwrXNkd2fVu4C7ql0n1aNrndikdj5rSZRARgI=;
 b=rGoaTWKtfQlnIIYqPh15eqH0Jxt2DJW/Z67j5pRur3bs0cQL1l3mUnEwFw+s7xZOL/WgYdOSM9oYLKsvBDQ4e7hNkCR+VlmR+iHEVpRROReJ0PEOjuJTUz6otDgsELFWK4jxiSD+tM13UQ3BfqtQxeeerD2v/pjn5OyEI6CheM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 05:56:58 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 05:56:57 +0000
Message-ID: <ad3b602a-45e0-4441-aa3b-e5051c17c5a7@amd.com>
Date: Wed, 10 Dec 2025 11:26:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush hdp.
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>
References: <20251209073831.1426657-1-chongli2@amd.com>
 <4e4a99a9-5fff-42c1-ae5a-b2f925df2633@amd.com>
 <MN0PR12MB5761696F1F3009C6F4EB2F969BA0A@MN0PR12MB5761.namprd12.prod.outlook.com>
 <815a5f79-1eb4-4001-9274-605376744d8a@amd.com>
 <e5d81888-054d-4d77-b3cd-e72ce54a1dbe@amd.com>
 <DS7PR12MB57683953AFB4CB71B06E2AE09BA0A@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB57683953AFB4CB71B06E2AE09BA0A@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c79816-4889-4b53-8b32-08de37b0edb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UllIcDZkL29tTFNuTGxOYUlIN0VSYVVsTGxCRjBCcTZmMU5Ka1JIN00yWW5z?=
 =?utf-8?B?WG5Gek5jcHorMTBibnRWSXhCcFNUWjIySG40V2ZtYlNoN1RHWVBVNlhGdUxW?=
 =?utf-8?B?WkQ4ajFZZnJzcnVTNktQSThWTkg0NldHMVRTUTZGNFhxVEJFUUl6T3RKbUN4?=
 =?utf-8?B?d1UxQXVhQlN4bURvVEZ5SklPYVBFWUY2V3prU2IvTXdJd1lRYzVwcFlLUElG?=
 =?utf-8?B?Z09QZHJQd2lwZyttTm5iQmlpQkdBNFBveTlzSzZwbUY4dlI5eHVDV3h0emhn?=
 =?utf-8?B?Ly82TmxrUHhuaHNlamVuZWxwOHEvcFhTbkhKNWpkSVhhazRRaXNjc0tBZUhR?=
 =?utf-8?B?T29iM0lCelhYZjg2ek00Zi9VaUgyWFR4VDkyZituZHNjY1p2SU1OTUt5enUr?=
 =?utf-8?B?bXVIM2ZEU0tnbjB6dDBhUDBRL3hPMmloQ1N3MnhZRXU2Z0tqalB6c0JNSmNn?=
 =?utf-8?B?SmNYRXJEZjBIQnJLYmtZQ2hSajV0SmhrRlFLZ2h0andNUHhBYUttbXQ2WmpC?=
 =?utf-8?B?RkJwSFZOV0lXS2VZaWFLemQ4WktWcTBCRkNLMkxObm1aRGNveW5BOWpoLzlT?=
 =?utf-8?B?M2NlSHYzb29pQnAxMGZlZjlWdG54by9oZi9pL1ZXMzdDMlhCSERNaGlMR3dz?=
 =?utf-8?B?SkI4RFgxVkM5TE5DWm9WeThHcUV3WVNXa0tmQUtNaXVyY0laOWI2QnJKZnFI?=
 =?utf-8?B?M202aWF4L2xZanNTTTRHZVJYWmVBUFRlR3RCN2xrUDhZMVNRbTU3VGdmaDlp?=
 =?utf-8?B?c283dFdNRXhicTF6SlVhOXVocFBOanhER0VCWmVmeVcvRktIQndPSk9nN1pV?=
 =?utf-8?B?L0VjekRiNWl6bExiNHdIblRzZU96a2ZGTU1YTVlhQ01GT0xRQyt1VkFheDRx?=
 =?utf-8?B?Q1FrZXA2YlNlRFNFRnNqZUFqMGcrMDVpM2VKdEFEa3dqdWxmaHNHSk9UeXpN?=
 =?utf-8?B?OU1NeGxqNWVUbk1qQW1pL0VoQ1ZJcVZGb1Y1ZWxWQ2h0WEtvWUVhR2dqVTlv?=
 =?utf-8?B?UW9IRDhnQ0RTOFArRVQ4RTRRQjF5MXEyeDdCRXlGS3FabmlmR2JSd3pPS2k0?=
 =?utf-8?B?WWRVTCtGOExTME9HeSsyQ3NYYlBEbnlDTzArSXVuRU9RMDF4MGZ2RzRQTERr?=
 =?utf-8?B?bCs0Y0M3WnhBY3ZMSHFDRXhvSjE1dlBFSGZnR2hvNzZQbmpzS1pqczhuZjhJ?=
 =?utf-8?B?VWRaSmk5elpGZzMyWnRSejYvYkY5N2QybWkxSTJ3LzAxelVIZUh5dC83N2My?=
 =?utf-8?B?SDRsVExOdTlrR3FJeDV0d0VlR2Z2L3BHbms1WWJpaDJZeUhLRmZqT1IwTGNv?=
 =?utf-8?B?UzZISjA4Qk9SbFl6UXFsd1JoNklCRENuVjNjVFJZVXFuNkFPVVFENEFoOUtp?=
 =?utf-8?B?N0VRckhwRVhlN1JKWHFwQ0UybW9IRUJRMlB2dmxNaHI3Z2x0c2RzQ0VLUEhE?=
 =?utf-8?B?ZGlDa3QydmVyOFhLUGI2RjdZWDV3Y09pOTFldkhlS3hQdnRJcExjcUdqQ0hE?=
 =?utf-8?B?VHZ4bGN4UVkvdkhBRllLS0daSDhsQUZuSWxZS0w3UTJPMVdvcXFUcHBJZkNX?=
 =?utf-8?B?bUxsQnhFUFZYR3JBTzR2Q1RsLzRvcTN2VDdQMVBXQ3c2NyswSHhSMHFOSzZS?=
 =?utf-8?B?NjUzd1ZtTTBJTDdNK09NaVlPNVRIRjhLd2gvWmMzeUFHbW1kZnJPY3E4TFpv?=
 =?utf-8?B?bDJXTFRZdUFGak5OU2RZd3ZkVDRUL1hiUWlIM0JqNHpFbmdPWnpZd2RMQWRQ?=
 =?utf-8?B?WWtseE9DTklocjYrK2lMbk5QZmVnVUFMb2U1eXc0TzhHRGZ4RkF3K05LNWhP?=
 =?utf-8?B?MXZoUm9rY1M3Y0Zicmo3YWMwazdyNFo1clJQWVlKLy9iaFpENTJkbHkyVTd6?=
 =?utf-8?B?UXBrUDgvMytDVWczRmxLSHVxNkNjZ3YyZVFoRjdDMVZIRTRUR2lxVFl6R3Vw?=
 =?utf-8?Q?gNPoc7nmjjT74aTcvAt+4lxUQx/lnOI7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djgycGJmNGg1OFJLUHpNWVBHRXQ4YW1sNndQQXd5RnA2R2R4bEFtbFNqenV0?=
 =?utf-8?B?ZGdVVlU3RWFIeVpTL29ZeWlOREZSdEhOcnRIRW1EbnRhOFRPNEo1MHEwQ1lW?=
 =?utf-8?B?U2k3ZHA0WEFRLzJKZzlhSUFmcGJSRVNQRlRqblVyQmNzaldqUU03MlRYNkNF?=
 =?utf-8?B?SUNjUGFRT3FCYkZ6Y1hkUm9lMDBUQmRkWkYvdTBXeEpyQ05yeWVramFqZU1F?=
 =?utf-8?B?RmVWbHdId2R3dVVaMzRNeGZlWUprOXBONFNoWDQ5LzYraXpFQmVqeVpPajlR?=
 =?utf-8?B?WkIydFVzOWZpc2RWRUUrSjZFSTFHMXhnTk9TZ0tDdGhEeWdmbWIyTXJFRmVW?=
 =?utf-8?B?QmxINnpkNSswM3R4NjJCZXovZmVqbmNla3h1KyszY3hhTU1MTyt5OVA2S1VY?=
 =?utf-8?B?ck1ya2lXZTkwd3JXUlRYekNnWDlvZmVIQmhPTFdqZ3VkQ0NRSEN4ZkloMTI3?=
 =?utf-8?B?VnhoODBJZE11N09PQW1PZGRrai8vcHA3enV0MlNKcERkZTFOQlYyblRBM0FI?=
 =?utf-8?B?WHgwK1dNcHBDTDFGNkQxckxzL0dSdVBjMWtDVnRTcEZhRGVENTY5eDl5NzVI?=
 =?utf-8?B?WHlOaWtpdFlGNmlxUUd1Rmk5SGYxdjg0YmswZGRjY0p2TFk3Umw3eHNTRm12?=
 =?utf-8?B?cHpjaHFaQ2ZBUk0rMi9xOW8yMG9NczlFRDVNSW1MNy9KL1BqK1hqc2owcmtF?=
 =?utf-8?B?dm1mTnFuWVo1VXlWYVN1eFdDbk5pUHBQazhzOVY4TUNiTTZLZlV4SzBueVFY?=
 =?utf-8?B?YzQrYk95bzAzQjNKNm82Ym1XNXkxWEdhaGZuMXJnbWRHczBSWTdTbEwyUnhz?=
 =?utf-8?B?b3JMVUphWHJzVG16WE9LdG8wWjFJbjhzeEo1MUEveEFMVnUxd1kwN2ZiMGxD?=
 =?utf-8?B?eHFSdmNJWkR6aW9XaGpzOEdtY1hSUkpmVlhNYU5PNHZmZFJtc29XQjRLYm5J?=
 =?utf-8?B?ZTkxKzMxb1BQRGlweFg3M1Iwc21wZFNJWjBqa1dFaDBZU25sNUo0ZjZ4VVpr?=
 =?utf-8?B?L0tyS3gyN0RVUVNyU3RWVmtoV3hrUzZraFpqZjBkbkdtZUp3bjhmWk0rcFlI?=
 =?utf-8?B?RTZVZXFqRDhVTXp3VThnTXpVK2hiWU0rbXo3OWZRL2lPTDVlY2NjUktRMnMr?=
 =?utf-8?B?QVV4Uk5VRUxUV0t6NHpPd2lVZkd1VC9UWExtRERkY2tOeEZjNjB1VkxCeUkw?=
 =?utf-8?B?aU5wRWRqNlpDZGExMFVHbWxWUUNDNlFGUE1HeXVDR3JUMjNvdlY3eFU0UWFo?=
 =?utf-8?B?SkRQL0ttK25hY3g4UlVYbFd5TFZkb2VOdy9yQUhaUUdKQlBZRjNtcTQxZHdI?=
 =?utf-8?B?OU1kTGRkU0xINmp3V3NLbG9vTUV1OUwwUGg4bEY2ZmxzbDhuWS9uek12Z2Jv?=
 =?utf-8?B?YzFWYm5obFVtTWl6RzFsM3FRWUJjZUdSSXVENWlvbjNpUVgyVmliQk43YkVC?=
 =?utf-8?B?RE9wdGN2SWhGWEwwMEdxTkZVTmg5ajdiS2J0ZEdxaTQrM3VnQ0ZQRGIyaUE3?=
 =?utf-8?B?bzdndmtHNm5KK3EvekZTYURGNVBsVjJFZlo4a1FtRnAvRDdNajF5WjYyUEMy?=
 =?utf-8?B?RU9zaTdwQTFFQXc3M2JpNkhFSUNuVTdzSVpjMStTQmFmZ0haRnIrWGIwZHZK?=
 =?utf-8?B?UGRpZkllbnlDcDh5WUdqZmRrWkNmL3cvaDVLWXFxUmpNT09zUE1LaFY2V3Rp?=
 =?utf-8?B?MEZxcUVsNFVHUUxmT3dEbzlMdTR2RzJtcWJnUlV2ZWNvUUg4WEdQckQxeGtv?=
 =?utf-8?B?dnN3bWVqa2pMOHdBcytIazlpRFlwOE5zZkJOL1ZDZXZhdFFXbVRnQ0dXbkR5?=
 =?utf-8?B?YWUzU2oyVDlad3JyR2FJNGNhWUhuOVhIL2ZiWkF5a25wU2syTkkvVDNDR1Qv?=
 =?utf-8?B?YnlRSWdPNGs5RUFaUHhXcE1maVhPMFhJaFIwaWd1TXZBQkdiS0gxRU9kNTJS?=
 =?utf-8?B?RmxPWXpNMUFiSzlJTnFyZXBYRG1zNTlHdlk4WlpxeTlGUkF0ZXZPeU5wY0R3?=
 =?utf-8?B?ZndlRkNnS0hDTnVVQlRncTFsZExVS2RzU2ttY3JTMDF5bXBMTDJWM3lpNE52?=
 =?utf-8?B?OGduTkYwUW1FN3dXZzYyNWtiWThQaEJ4bk5XREN3NlJCTTJOcnFzQ3FoaFkv?=
 =?utf-8?Q?JEeH+QVlJyd952CFpGXaDgcRK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c79816-4889-4b53-8b32-08de37b0edb7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 05:56:57.9266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMOJvEmdEd+Puu5GZ2GD3GshnOON9X5OlKjotz5psW7VifrkPA40cwKwVeDexlvu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274
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



On 12/10/2025 11:01 AM, Li, Chong(Alan) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi, Lijo.
> 
> ----------------------------------------------------------
> Is this about mes kiq? There is a flag to check that as well adev->enable_mes_kiq.
> ----------------------------------------------------------
> BTW, the idea is to have a unique bit assignment for each engine. If you have two pipes using this (ex: mes kiq/mes sched) and assigned the same bit, that is a conflict.
> ----------------------------------------------------------
> 
> 
> Sorry for reply later.
> 
> the kiq ring and mes ring are two different rings in here.
> 
> Let me explain the code to get ref_and_mask in gfx11 and gfx12,
> The value of ring->me in mes and kiq both 3,
> And the ring->pipe of mes is 0, ring->pipe of kiq is 1.
> 
> So the ring of mes, get cp8,
> and the ring of kiq, get cp9.
> There is no conflict.

Thanks for confirming. What I meant is, in general, you don't need to 
focus on MES KIQ vs non-MES KIQ. As long as the assignment is unique and 
not used by other ucode/firmware engines, it should be fine - meaning, 
the focus should be on the ring type and bit assignment rather than 
ring->me.

Thanks,
Lijo

> 
> 
>          if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>                  ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>                  ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>                  switch (ring->me) {
>                  case 1:
>                          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>                          break;
>                  case 2:
>                          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>                          break;
>                  case 3:
>                          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>                          break;
>                  default:
>                          return;
>                  }
>                  *reg_mem_engine = 0;
>          } else {
>                  *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>                  *reg_mem_engine = 1; /* pfp */
>          }
> 
> 
> I manual add the log in kernel driver:
> 
> [drm] ring->name:mes_3.0.0,    ring->mes:3,ring->pipe:0
> [drm] ring->name:mes_kiq_3.1.0,ring->mes:3,ring->pipe:1
> 
> 
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, December 10, 2025 12:35 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush hdp.
> 
> 
> 
> On 12/10/2025 9:43 AM, Lazar, Lijo wrote:
>>
>>
>> On 12/10/2025 8:32 AM, Li, Chong(Alan) wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Hi, Lijo.
>>> ---------------------------------------------------------------------
>>> -------------------------- It appears like gfx v9/9.4.3/10/11/12 all
>>> can be kept in some amdgpu_gfx_get_ref_mask generic helper, then it's
>>> not required to repeat the logic.
>>>
>>> if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>           ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>           switch (ring->me) {
>>>           case 1:
>>>                   *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 <<
>>> ring->pipe;
>>>                   break;
>>>           case 2:
>>>                   *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 <<
>>> ring->pipe;
>>>                   break;
>>>           default:
>>>                   return;
>>>           }
>>>           *reg_mem_engine = 0;
>>>           return;
>>> }
>>>
>>> if (ring->funcs->type == AMDGPU_RING_TYPE_MES) {
>>>           *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>>>           *reg_mem_engine = 0;
>>> } else {
>>>           *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>>>           *reg_mem_engine = 1; /* pfp */ }
>>> ---------------------------------------------------------------------
>>> ---------
>>>
>>> In gfx10, the ring->me of kiq is 2, this code can pass.
>>> But in gfx11 and gfx12, the ring->me of kiq is 3, so this code logic
>>> does not work.
>>
>> Is this about mes kiq? There is a flag to check that as well - adev-
>>> enable_mes_kiq.
>>
> 
> BTW, the idea is to have a unique bit assignment for each engine. If you have two pipes using this (ex: mes kiq/mes sched) and assigned the same bit, that is a conflict.
> 
> Thanks,
> Lijo
> 
>> Thanks,
>> Lijo
>>
>>>
>>> As the value of ring->me has changed with gfx version, the code logic
>>> is not repeat, I suggest keep the origin way to assign ref_and_mask.
>>>
>>>
>>> I accept your suggestion of add params check, alignment mismatch and
>>> delete the unused variable "usepfp".
>>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Tuesday, December 9, 2025 6:03 PM
>>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deng, Emily <Emily.Deng@amd.com>
>>> Subject: Re: [PATCH v3] drm/amdgpu: fix mes packet params issue when
>>> flush hdp.
>>>
>>>
>>>
>>> On 12/9/2025 1:08 PM, chong li wrote:
>>>> v3:
>>>> Unify the get_ref_and_mask function in amdgpu_gfx_funcs, to support
>>>> both GFX11 and earlier generations
>>>>
>>>> v2:
>>>> place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
>>>> since this function only assigns the cp entry.
>>>>
>>>> v1:
>>>> both gfx ring and mes ring use cp0 to flush hdp, cause conflict.
>>>>
>>>> use function get_ref_and_mask to assign the cp entry.
>>>> reassign mes to use cp8 instead.
>>>>
>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>> ---
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++-
>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 54 +++++++++++++++--------
>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 58 ++++++++++++++++
>>>> +--------
>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 58 ++++++++++++++++
>>>> +--------
>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 55 +++++++++++++++--------
>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 55 +++++++++++++++--------
>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 54 +++++++++++++++--------
>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 54 +++++++++++++++--------
>>>>     9 files changed, 275 insertions(+), 128 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>> index efd61a1ccc66..090714127cba 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>> @@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
>>>>                                      int num_xccs_per_xcp);
>>>>         int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int
>>>> ih_node);
>>>>         int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
>>>> +     void (*get_ref_and_mask)(struct amdgpu_ring *ring,
>>>> +                             uint32_t *ref_and_mask, uint32_t
>>>> *reg_mem_engine);
>>>>     };
>>>>
>>>>     struct sq_work {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> index 895b841b9626..5c7724f203d0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> @@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct
>>>> amdgpu_device *adev,
>>>>
>>>>     int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>>>>     {
>>>> -     uint32_t hdp_flush_req_offset, hdp_flush_done_offset,
>>>> ref_and_mask;
>>>> +     uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
>>>> +     struct amdgpu_ring *mes_ring;
>>>> +     uint32_t ref_and_mask = 0, reg_mem_engine = 0;
>>>>
>>>> +     if (!adev->gfx.funcs->get_ref_and_mask) {
>>>> +             dev_err(adev->dev, "amdgpu_mes_hdp_flush not support\n");
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>> +     mes_ring = &adev->mes.ring[0];
>>>>         hdp_flush_req_offset = adev->nbio.funcs-
>>>>> get_hdp_flush_req_offset(adev);
>>>>         hdp_flush_done_offset = adev->nbio.funcs-
>>>>> get_hdp_flush_done_offset(adev);
>>>> -     ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
>>>> +
>>>> +     adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask,
>>>> +&reg_mem_engine);
>>>>
>>>>         return amdgpu_mes_reg_write_reg_wait(adev,
>>>> hdp_flush_req_offset, hdp_flush_done_offset,
>>>>                                              ref_and_mask,
>>>> ref_and_mask, 0); diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> index aaed24f7e716..ed79ceafc57b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> @@ -4566,6 +4566,40 @@ static void
>>>> gfx_v10_0_update_perfmon_mgcg(struct amdgpu_device *adev,
>>>>                 WREG32_SOC15(GC, 0, mmRLC_PERFMON_CLK_CNTL, data);
>>>>     }
>>>>
>>>> +/**
>>>> + * gfx_v10_0_get_ref_and_mask - get the reference and mask for HDP
>>>> +flush
>>>> + *
>>>> + * @ring: amdgpu_ring structure holding ring information
>>>> + * @ref_and_mask: pointer to store the reference and mask
>>>> + * @reg_mem_engine: pointer to store the register memory engine
>>>> + *
>>>> + * Calculates the reference and mask for HDP flush based on the ring
>>>> type and me.
>>>> + */
>>>> +static void gfx_v10_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>>> +                                     uint32_t *ref_and_mask,
>>>> uint32_t *reg_mem_engine) {
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>>> +adev->nbio.hdp_flush_reg;
>>>> +
>>>
>>> Need to do NULL check of params (this and others).
>>>
>>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>> +             switch (ring->me) {
>>>> +             case 1:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             case 2:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             default:
>>>> +                     return;
>>>> +             }
>>>> +             *reg_mem_engine = 0;
>>>> +     } else {
>>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring-
>>>>> pipe;
>>>> +             *reg_mem_engine = 1; /* pfp */
>>>> +     }
>>>> +}
>>>> +
>>>>     static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>>>>         .get_gpu_clock_counter = &gfx_v10_0_get_gpu_clock_counter,
>>>>         .select_se_sh = &gfx_v10_0_select_se_sh, @@ -4575,6 +4609,7 @@
>>>> static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>>>>         .select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
>>>>         .init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
>>>>         .update_perfmon_mgcg = &gfx_v10_0_update_perfmon_mgcg,
>>>> +     .get_ref_and_mask = &gfx_v10_0_get_ref_and_mask,
>>>>     };
>>>>
>>>>     static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev) @@
>>>> -8614,25 +8649,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct
>>>> amdgpu_ring *ring)
>>>>     {
>>>>         struct amdgpu_device *adev = ring->adev;
>>>>         u32 ref_and_mask, reg_mem_engine;
>>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev-
>>>>> nbio.hdp_flush_reg;
>>>> -
>>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>>> -             switch (ring->me) {
>>>> -             case 1:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             case 2:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             default:
>>>> -                     return;
>>>> -             }
>>>> -             reg_mem_engine = 0;
>>>> -     } else {
>>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring-
>>>>> pipe;
>>>> -             reg_mem_engine = 1; /* pfp */
>>>> -     }
>>>>
>>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>>> +&reg_mem_engine);
>>>>         gfx_v10_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>>                                adev->nbio.funcs-
>>>>> get_hdp_flush_req_offset(adev),
>>>>                                adev->nbio.funcs-
>>>>> get_hdp_flush_done_offset(adev),
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index f4d4dd5dd07b..c3d8e7588740 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -1072,6 +1072,44 @@ static int
>>>> gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>>>>         }
>>>>     }
>>>>
>>>> +/**
>>>> + * gfx_v11_0_get_ref_and_mask - get the reference and mask for HDP
>>>> +flush
>>>> + *
>>>> + * @ring: amdgpu_ring structure holding ring information
>>>> + * @ref_and_mask: pointer to store the reference and mask
>>>> + * @reg_mem_engine: pointer to store the register memory engine
>>>> + *
>>>> + * Calculates the reference and mask for HDP flush based on the ring
>>>> type and me.
>>>> + */
>>>> +static void gfx_v11_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>>> +                                     uint32_t *ref_and_mask,
>>>> uint32_t *reg_mem_engine) {
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>>> +adev->nbio.hdp_flush_reg;
>>>> +
>>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>> +             switch (ring->me) {
>>>> +             case 1:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             case 2:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             case 3:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             default:
>>>> +                     return;
>>>> +             }
>>>> +             *reg_mem_engine = 0;
>>>> +     } else {
>>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring-
>>>>> pipe;
>>>> +             *reg_mem_engine = 1; /* pfp */
>>>> +     }
>>>> +}
>>>> +
>>>>     static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>>>>         .get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
>>>>         .select_se_sh = &gfx_v11_0_select_se_sh, @@ -1081,6 +1119,7 @@
>>>> static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>>>>         .select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
>>>>         .update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
>>>>         .get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
>>>> +     .get_ref_and_mask = &gfx_v11_0_get_ref_and_mask,
>>>>     };
>>>>
>>>>     static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev) @@
>>>> -5833,25 +5872,8 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct
>>>> amdgpu_ring *ring)
>>>>     {
>>>>         struct amdgpu_device *adev = ring->adev;
>>>>         u32 ref_and_mask, reg_mem_engine;
>>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev-
>>>>> nbio.hdp_flush_reg;
>>>> -
>>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>>> -             switch (ring->me) {
>>>> -             case 1:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             case 2:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             default:
>>>> -                     return;
>>>> -             }
>>>> -             reg_mem_engine = 0;
>>>> -     } else {
>>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring-
>>>>> pipe;
>>>> -             reg_mem_engine = 1; /* pfp */
>>>> -     }
>>>>
>>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>>> +&reg_mem_engine);
>>>>         gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>>                                adev->nbio.funcs-
>>>>> get_hdp_flush_req_offset(adev),
>>>>                                adev->nbio.funcs-
>>>>> get_hdp_flush_done_offset(adev),
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> index f9cae6666697..b805ed4f88aa 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> @@ -929,6 +929,44 @@ static int gfx_v12_0_get_gfx_shadow_info(struct
>>>> amdgpu_device *adev,
>>>>         return -EINVAL;
>>>>     }
>>>>
>>>> +/**
>>>> + * gfx_v12_0_get_ref_and_mask - get the reference and mask for HDP
>>>> +flush
>>>> + *
>>>> + * @ring: amdgpu_ring structure holding ring information
>>>> + * @ref_and_mask: pointer to store the reference and mask
>>>> + * @reg_mem_engine: pointer to store the register memory engine
>>>> + *
>>>> + * Calculates the reference and mask for HDP flush based on the ring
>>>> type and me.
>>>> + */
>>>> +static void gfx_v12_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>>> +                                     uint32_t *ref_and_mask,
>>>> uint32_t *reg_mem_engine) {
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>>> +adev->nbio.hdp_flush_reg;
>>>> +
>>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>> +             switch (ring->me) {
>>>> +             case 1:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             case 2:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             case 3:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             default:
>>>> +                     return;
>>>> +             }
>>>> +             *reg_mem_engine = 0;
>>>> +     } else {
>>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>>> +             *reg_mem_engine = 1; /* pfp */
>>>> +     }
>>>> +}
>>>> +
>>>>     static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>>>>         .get_gpu_clock_counter = &gfx_v12_0_get_gpu_clock_counter,
>>>>         .select_se_sh = &gfx_v12_0_select_se_sh, @@ -938,6 +976,7 @@
>>>> static
>>>> const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>>>>         .select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
>>>>         .update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
>>>>         .get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
>>>> +     .get_ref_and_mask = &gfx_v12_0_get_ref_and_mask,
>>>>     };
>>>>
>>>>     static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev) @@
>>>> -4389,25 +4428,8 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct
>>>> amdgpu_ring *ring)
>>>>     {
>>>>         struct amdgpu_device *adev = ring->adev;
>>>>         u32 ref_and_mask, reg_mem_engine;
>>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev-
>>>>> nbio.hdp_flush_reg;
>>>> -
>>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>>> -             switch (ring->me) {
>>>> -             case 1:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             case 2:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             default:
>>>> -                     return;
>>>> -             }
>>>> -             reg_mem_engine = 0;
>>>> -     } else {
>>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>>> -             reg_mem_engine = 1; /* pfp */
>>>> -     }
>>>>
>>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>>> +&reg_mem_engine);
>>>>         gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>>                                adev->nbio.funcs-
>>>>> get_hdp_flush_req_offset(adev),
>>>>                                adev->nbio.funcs-
>>>>> get_hdp_flush_done_offset(adev),
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> index 66a4e4998106..b3ea45e3c60f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> @@ -2068,23 +2068,10 @@ static int gfx_v7_0_ring_test_ring(struct
>>>> amdgpu_ring *ring)
>>>>     static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>>     {
>>>>         u32 ref_and_mask;
>>>> -     int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ?
>>>> 0 : 1;
>>>> -
>>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>>> -             switch (ring->me) {
>>>> -             case 1:
>>>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             case 2:
>>>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             default:
>>>> -                     return;
>>>> -             }
>>>> -     } else {
>>>> -             ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>>>> -     }
>>>> +     int usepfp;
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>>
>>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &usepfp);
>>>>         amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>>>>         amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write,
>>>> wait, write */
>>>>                                  WAIT_REG_MEM_FUNCTION(3) |  /* == */
>>>> @@ -4075,12 +4062,46 @@
>>>> static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
>>>>         cik_srbm_select(adev, me, pipe, q, vm);
>>>>     }
>>>>
>>>> +/**
>>>> + * gfx_v7_0_get_ref_and_mask - get the reference and mask for HDP
>>>> +flush
>>>> + *
>>>> + * @ring: amdgpu_ring structure holding ring information
>>>> + * @ref_and_mask: pointer to store the reference and mask
>>>> + * @reg_mem_engine: pointer to store the register memory engine
>>>> + *
>>>> + * Calculates the reference and mask for HDP flush based on the ring
>>>> type and me.
>>>> + */
>>>> +static void gfx_v7_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>>> +                                     uint32_t *ref_and_mask,
>>>> uint32_t *reg_mem_engine) {
>>>> +     int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ?
>>>> 0 : 1;
>>>
>>> This doesn't look used inside this function.
>>>
>>>> +
>>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>> +             switch (ring->me) {
>>>> +             case 1:
>>>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK <<
>>>> ring->pipe;
>>>> +                     break;
>>>> +             case 2:
>>>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK <<
>>>> ring->pipe;
>>>> +                     break;
>>>> +             default:
>>>> +                     return;
>>>> +             }
>>>> +             *reg_mem_engine = 0;
>>>> +     } else {
>>>> +             *ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>>>> +             *reg_mem_engine = 1;
>>>> +     }
>>>> +}
>>>> +
>>>>     static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
>>>>         .get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
>>>>         .select_se_sh = &gfx_v7_0_select_se_sh,
>>>>         .read_wave_data = &gfx_v7_0_read_wave_data,
>>>>         .read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
>>>> -     .select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
>>>> +     .select_me_pipe_q = &gfx_v7_0_select_me_pipe_q,
>>>> +     .get_ref_and_mask = &gfx_v7_0_get_ref_and_mask,
>>>>     };
>>>>
>>>>     static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = { diff
>>>> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> index 5d6e8e0601cb..cc5acfcdf360 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> @@ -5211,13 +5211,46 @@ static void gfx_v8_0_read_wave_sgprs(struct
>>>> amdgpu_device *adev, uint32_t xcc_id
>>>>                 start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
>>>>     }
>>>>
>>>> +/**
>>>> + * gfx_v8_0_get_ref_and_mask - get the reference and mask for HDP
>>>> +flush
>>>> + *
>>>> + * @ring: amdgpu_ring structure holding ring information
>>>> + * @ref_and_mask: pointer to store the reference and mask
>>>> + * @reg_mem_engine: pointer to store the register memory engine
>>>> + *
>>>> + * Calculates the reference and mask for HDP flush based on the ring
>>>> type and me.
>>>> + */
>>>> +static void gfx_v8_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>>> +                                     uint32_t *ref_and_mask,
>>>> uint32_t *reg_mem_engine) {
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>> +
>>>> +     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>>>> +         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>>> +             switch (ring->me) {
>>>> +             case 1:
>>>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK <<
>>>> ring->pipe;
>>>> +                     break;
>>>> +             case 2:
>>>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK <<
>>>> ring->pipe;
>>>> +                     break;
>>>> +             default:
>>>> +                     return;
>>>> +             }
>>>> +             *reg_mem_engine = 0;
>>>> +     } else {
>>>> +             *ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>>>> +             *reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
>>>> +     }
>>>> +}
>>>>
>>>>     static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
>>>>         .get_gpu_clock_counter = &gfx_v8_0_get_gpu_clock_counter,
>>>>         .select_se_sh = &gfx_v8_0_select_se_sh,
>>>>         .read_wave_data = &gfx_v8_0_read_wave_data,
>>>>         .read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
>>>> -     .select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
>>>> +     .select_me_pipe_q = &gfx_v8_0_select_me_pipe_q,
>>>> +     .get_ref_and_mask = &gfx_v8_0_get_ref_and_mask,
>>>>     };
>>>>
>>>>     static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block) @@
>>>> -6000,25 +6033,9 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct
>>>> amdgpu_ring *ring)
>>>>     static void gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>>     {
>>>>         u32 ref_and_mask, reg_mem_engine;
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>>
>>>> -     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>>>> -         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>>> -             switch (ring->me) {
>>>> -             case 1:
>>>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             case 2:
>>>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             default:
>>>> -                     return;
>>>> -             }
>>>> -             reg_mem_engine = 0;
>>>> -     } else {
>>>> -             ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>>>> -             reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
>>>> -     }
>>>> -
>>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>>> +&reg_mem_engine);
>>>>         amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>>>>         amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write,
>>>> wait, write */
>>>>                                  WAIT_REG_MEM_FUNCTION(3) |  /* == */
>>>> diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> index e6187be27385..f2ebacc73eb2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> @@ -1997,6 +1997,40 @@ static void gfx_v9_0_select_me_pipe_q(struct
>>>> amdgpu_device *adev,
>>>>         soc15_grbm_select(adev, me, pipe, q, vm, 0);
>>>>     }
>>>>
>>>> +/**
>>>> + * gfx_v9_0_get_ref_and_mask - get the reference and mask for HDP
>>>> +flush
>>>> + *
>>>> + * @ring: amdgpu_ring structure holding ring information
>>>> + * @ref_and_mask: pointer to store the reference and mask
>>>> + * @reg_mem_engine: pointer to store the register memory engine
>>>> + *
>>>> + * Calculates the reference and mask for HDP flush based on the ring
>>>> type and me.
>>>> + */
>>>> +static void gfx_v9_0_get_ref_and_mask(struct amdgpu_ring *ring,
>>>> +                                     uint32_t *ref_and_mask,
>>>> uint32_t *reg_mem_engine) {
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>>> +adev->nbio.hdp_flush_reg;
>>>> +
>>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>> +             switch (ring->me) {
>>>> +             case 1:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             case 2:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             default:
>>>> +                     return;
>>>> +             }
>>>> +             *reg_mem_engine = 0;
>>>> +     } else {
>>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring-
>>>>> pipe;
>>>> +             *reg_mem_engine = 1; /* pfp */
>>>> +     }
>>>> +}
>>>> +
>>>>     static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
>>>>             .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
>>>>             .select_se_sh = &gfx_v9_0_select_se_sh, @@ -2004,6 +2038,7
>>>> @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
>>>>             .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
>>>>             .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
>>>>             .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
>>>> +             .get_ref_and_mask = &gfx_v9_0_get_ref_and_mask,
>>>
>>> Alignment mismatch?
>>>
>>>>     };
>>>>
>>>>     const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops = { @@
>>>> -5380,25 +5415,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct
>>>> amdgpu_ring *ring)
>>>>     {
>>>>         struct amdgpu_device *adev = ring->adev;
>>>>         u32 ref_and_mask, reg_mem_engine;
>>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev-
>>>>> nbio.hdp_flush_reg;
>>>> -
>>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>>> -             switch (ring->me) {
>>>> -             case 1:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             case 2:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             default:
>>>> -                     return;
>>>> -             }
>>>> -             reg_mem_engine = 0;
>>>> -     } else {
>>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>>> -             reg_mem_engine = 1; /* pfp */
>>>> -     }
>>>>
>>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>>> +&reg_mem_engine);
>>>>         gfx_v9_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>>                               adev->nbio.funcs-
>>>>> get_hdp_flush_req_offset(adev),
>>>>                               adev->nbio.funcs-
>>>>> get_hdp_flush_done_offset(adev),
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> index 89253df5ffc8..b4ba76110c34 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> @@ -838,6 +838,40 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct
>>>> amdgpu_device *adev, int ih_node)
>>>>         return xcc - 1;
>>>>     }
>>>>
>>>> +/**
>>>> + * gfx_v9_4_3_get_ref_and_mask - get the reference and mask for HDP
>>>> +flush
>>>> + *
>>>> + * @ring: amdgpu_ring structure holding ring information
>>>> + * @ref_and_mask: pointer to store the reference and mask
>>>> + * @reg_mem_engine: pointer to store the register memory engine
>>>> + *
>>>> + * Calculates the reference and mask for HDP flush based on the ring
>>>> type and me.
>>>> + */
>>>> +static void gfx_v9_4_3_get_ref_and_mask(struct amdgpu_ring *ring,
>>>> +                                     uint32_t *ref_and_mask,
>>>> uint32_t *reg_mem_engine) {
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>>> +adev->nbio.hdp_flush_reg;
>>>> +
>>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>> +             switch (ring->me) {
>>>> +             case 1:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             case 2:
>>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6
>>>> << ring->pipe;
>>>> +                     break;
>>>> +             default:
>>>> +                     return;
>>>> +             }
>>>> +             *reg_mem_engine = 0;
>>>> +     } else {
>>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring-
>>>>> pipe;
>>>> +             *reg_mem_engine = 1; /* pfp */
>>>> +     }
>>>> +}
>>>> +
>>>>     static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
>>>>         .get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
>>>>         .select_se_sh = &gfx_v9_4_3_xcc_select_se_sh, @@ -848,6 +882,7 @@
>>>> static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
>>>>         .switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
>>>>         .ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
>>>>         .get_xccs_per_xcp = &gfx_v9_4_3_get_xccs_per_xcp,
>>>> +     .get_ref_and_mask = &gfx_v9_4_3_get_ref_and_mask,
>>>>     };
>>>>
>>>>     static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle, @@
>>>> -2818,25 +2853,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct
>>>> amdgpu_ring *ring)
>>>>     {
>>>>         struct amdgpu_device *adev = ring->adev;
>>>>         u32 ref_and_mask, reg_mem_engine;
>>>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev-
>>>>> nbio.hdp_flush_reg;
>>>> -
>>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>>> -             switch (ring->me) {
>>>> -             case 1:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             case 2:
>>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 <<
>>>> ring->pipe;
>>>> -                     break;
>>>> -             default:
>>>> -                     return;
>>>> -             }
>>>> -             reg_mem_engine = 0;
>>>> -     } else {
>>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>>> -             reg_mem_engine = 1; /* pfp */
>>>> -     }
>>>>
>>>
>>> It appears like gfx v9/9.4.3/10/11/12 all can be kept in some
>>> amdgpu_gfx_get_ref_mask generic helper, then it's not required to
>>> repeat the logic.
>>>
>>> if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>>           ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>           switch (ring->me) {
>>>           case 1:
>>>                   *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 <<
>>> ring->pipe;
>>>                   break;
>>>           case 2:
>>>                   *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 <<
>>> ring->pipe;
>>>                   break;
>>>           default:
>>>                   return;
>>>           }
>>>           *reg_mem_engine = 0;
>>>           return;
>>> }
>>>
>>> if (ring->funcs->type == AMDGPU_RING_TYPE_MES) {
>>>           *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>>>           *reg_mem_engine = 0;
>>> } else {
>>>           *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>>>           *reg_mem_engine = 1; /* pfp */
>>> }
>>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>>>> +&reg_mem_engine);
>>>>         gfx_v9_4_3_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>>                               adev->nbio.funcs-
>>>>> get_hdp_flush_req_offset(adev),
>>>>                               adev->nbio.funcs-
>>>>> get_hdp_flush_done_offset(adev),
>>>
>>
> 

