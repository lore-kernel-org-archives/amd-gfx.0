Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35657C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 05:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B320010E0B6;
	Mon, 12 Aug 2024 05:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X/LZ32m3";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C29E10E0B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 05:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJc8LVIc3y/rOztmOfkB0MUqcdfnbea/5vJpgTsJzQBrUSO3+h8xUqVytZYDuZiAvRdTuCZFZAE20TCX8ZT58FIeNX4S6SlCgqsJ8tM4mx3KJl8V8+vOaUa/+d6WKmYsLfuuzzT5gSVAtjwaxNVbrjfmFh3AYrCVB4E0scy3UYxcCnvQlKqlLxpR7LzGa/3X2FpsJxG3Ltey2IIJFYlZj/Up3W5svwNuWFaBp9dS0qpduz1I2djm0/muEXXMnTrylSCq1jxWDhFsP01qJxeMi5R16fsVGIdER1NwiTA/lMTdQKCWBKQqRwMSjIgXeM65P5kZzZZ3PnA8YOupPk/0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XjimiVoNKA1CqSQyOhvtKUhp6BgTZE4/3vYfWhThPM=;
 b=uTa1AIHe3RpneTRsA4HK1Htf4kOPnlNy02fXFP25YioXeEfSZHTb9bhnjJ8ekTvv2pVEGXEbxm/tSO8JRjY4coQfhzeZxTAnBZSq7dFA2FR7RBZtwEi6lcsEyZhJkydukOR2Jj0/nAMP/vvkdJomDKh8QMIsFE7unwLnGZKqDCDLMz+nHd2LkXjUmyQUyrFtPUfOJm63iOuxa75HmM5zh0y43+qs/H5JKU2GDTqDKd7UhU7srsv88Hkr3AquFPAiz061sJ0iFlPSstdwoQDfcyt+HA9HPoJwgcHmj9F12FEQqegGQFi3XIVekz7x0iuBRYkaiB+TxRZxx+17HE8GPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XjimiVoNKA1CqSQyOhvtKUhp6BgTZE4/3vYfWhThPM=;
 b=X/LZ32m3vjESTLZsimPuGh1Elaogo0Lk7ZDTGURDk0nU7v78415s0P9YTKNQZNJgYc+oSRMBLudLbnSxUjGlVD95zv/Z3dl48LgNXvu6NrssAxWTV86ENnIU+EdL+VzVZtAkJSIfSkkPL0ZB8+hm4YnZZPRHhsrYXaZvRxCfRCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.20; Mon, 12 Aug 2024 05:16:01 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 05:16:01 +0000
Message-ID: <758aadf9-1719-4cc6-8c72-6db43623cca0@amd.com>
Date: Mon, 12 Aug 2024 10:45:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Do not init ta microcode from guest side
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
References: <20240812032221.29060-1-Hawking.Zhang@amd.com>
 <12589748-95c7-42c4-9670-31cdf499a18a@amd.com>
 <BN9PR12MB52578F3FEECB00427FF010B5FC852@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB52578F3FEECB00427FF010B5FC852@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed9c8f0-9ac7-4b5e-6120-08dcba8ddb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ly9MbDFEaXJERkNEQ0VQMWJXc2tsc0tuM2JEYXAxdU5GcW9VQUlyOE9ydXE4?=
 =?utf-8?B?UmM4YWFmRHBYekovL3l6Y1JCY2pHTE9CeXkyZWwrb01iWHBlTzg5Z2JYWlUx?=
 =?utf-8?B?dUd4OEJSYjRRVXY2dS9MWms5L3haWnRCNGU4ZDc5a3BrWHNBRVlIMnYyWkg0?=
 =?utf-8?B?aWtaNnpWdXIvMGx4LzRTSFRMVTZGd0U0cHZydjZTeW5jeVlhYWJ5aWUvYWFM?=
 =?utf-8?B?T2pEbENTRTVCT3h4T1k5TTBkWWt6QUE2N0krRlk1TzdKZUc3dml6QTVaY2h3?=
 =?utf-8?B?blRWcDNIQTdPNXd2L1BGaHlrT0JtdGRZL3JubFpRc25XWE5VY1MxZUtlOXcr?=
 =?utf-8?B?SHdpQ3IycnUvckdqOUZPR0UvaXNMckp5cEJNbGhjV1dXaEMzbzZ1MnpJcVdz?=
 =?utf-8?B?M1lzTkw2RVN4dVNQSVhSVE5QenpyUm9UTlhxOG16M2NObkdiSmZQUUZFK0E2?=
 =?utf-8?B?K08zdEI4YUt2d1BNc2I0VDFmRnQyenlFdzZ2ZVVRam9ISHorL2dJTk1PWlVI?=
 =?utf-8?B?cGh5NUVIcXlxZm5ldWdLQ1prZTRVaWs4aUNyZUFxK29ENVlYYWVsaXF5S1d3?=
 =?utf-8?B?ZDV4ZnBRZlZiSFNYK0RZOWlqby8ya2E1T2FDQWtoNUs5ditaaUVzamppVUpn?=
 =?utf-8?B?bWFXdHRVSFZtYjYxcGEwaFpuTTZ1WFIxY3hPd29kUEdHNlF1bS9yU3NCMHJE?=
 =?utf-8?B?SE1YVTRLd0JEVVFvMFhLdGxYNnJ1NHBZT3hSVE1jTDA0enF6QUcweUNwUmxH?=
 =?utf-8?B?ZllxNFY2SWtoYmZHRFVtTW0vc0VZVDVGbzdjc3VEdlhJakdQSUxYNTlrcUJV?=
 =?utf-8?B?OVVYcHIwWTNHYkgzQTNQYXZ5cWt2d3pmWEVaWG9pRVNmcnpyeE5lU0MyV3dx?=
 =?utf-8?B?bWNxL2NOTkVDV2d3b2w2QkFaWWJDdGR3SXJGRStLRjB2QU1TUWJpblNTM0hL?=
 =?utf-8?B?QzNPdnRCbFRvaFptbjNMVzJ6dTFhNkFJeGc5MlJ0NGxIWHVQSTcxNTcrN01i?=
 =?utf-8?B?RG5sVlVPZm45YzhXZ1ZGZ1RnMGJtV04wNUkranByRVBhNnUwUXEvU2lzS3k0?=
 =?utf-8?B?eFpyU1JjWGRyb2J2U1lWNEFPa2Z1VlU0SlpqUmlxVXFPV2NURWJoVlJPaHJs?=
 =?utf-8?B?N3ZGK3Fla1N6endpS2k4cm1qbTVsL0Vya2twOTZFWHdsRnlUYmJIN0RaODZO?=
 =?utf-8?B?c3dPKytLQjcrblh1VFR6SFl4MXJORkY0VkJDK3NNVlEyeWZtRzJKRFRmVWdL?=
 =?utf-8?B?VjNBVEVCSDkxaUpQY2lYS0g2cHV4bWR6cWpEQk9MTDFoNi9MNUFLeWtralIy?=
 =?utf-8?B?QkorcDdFSVdJUTIzTEp0NnZNU3FLVWVrN0dSUk5oZTd0NlBYczJuWFE2WmtZ?=
 =?utf-8?B?dFdIak1qb2s2Qm1lakpheWU4eXEwS3ZqclJPdC96VzdmMXhNR2UrYyt3ejJE?=
 =?utf-8?B?TlpsWkdrVStnVTIxQi9IcTUyWGVwSmtkKzhHWHhwa01TMzZiZ2lhSEJRZ2hm?=
 =?utf-8?B?ak9peVhLbjRyc1lXTGM5ckNjL2JIUi9XVHR6bkNNYUtOamk1MUxWZFBPVWhi?=
 =?utf-8?B?OE9lTUh5YUQ1dE9lSXVxT2NHOUNtMGZGeW10Zktrbnd3MDhJZUJOc3JCY2x4?=
 =?utf-8?B?b0hTemtjazJwWW1XSC9rTjl1TFlYTC92TlFKRWZOZkF4SDdJYmFLNjBDNnJz?=
 =?utf-8?B?SlVXdnpjVWdoNWlONlhvVXB2Sko5YmxIMFEvMHV5Q21oTTViZisxbE4wVEsz?=
 =?utf-8?Q?3qW/3vcz8Nwo69CvDs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTE1UnJvUWErVzhWVENJek1SYXlnQXMwWi9CaWdFMXVIS09vbjZYZ01pRkRJ?=
 =?utf-8?B?bXBOblFlNlo1Q1V4ei9KN0phVlFuR3dSczBDQTJmTEFaOE9YdU1KSTV3SXRw?=
 =?utf-8?B?ZGdYSmpQUkxrbzMwaTZPbFdmS0oyV0grNlI0S1ozUVAyQ0dSN2cvVGhlVTI5?=
 =?utf-8?B?OXBNbGJjamZGWmNqVSttMnVjZERKOExiRXNhY1gvWS9VcmowanlwN3NDRTA3?=
 =?utf-8?B?WjZKSzBDK0dvL0xRcjY1cXZsRGpwNzE4M1pBa1VBeXl6Z2t4YWN1Y3ZsQkZy?=
 =?utf-8?B?akVuMlBkK0dUdCtXQWRuVi9xdFpmZ2dFVFJPVldEdjhZNnlLSmxQaEMvYy9s?=
 =?utf-8?B?cG02T0pMNFdjL3VkZngrZmNmWElQNVg3VFZJbVNpR1NsbUhrQ05LYVRUbHky?=
 =?utf-8?B?c2M3S0NpOFdVa25hNEhCMkVxcFc2VHZTaE1vU0YwRHhVZnBZQ3dBanNON29m?=
 =?utf-8?B?OWZFUXQrNkxMQVpKUlk5TndBek4zZFlSU0hqSG84S0hIclJOdXhjTUpUdHE3?=
 =?utf-8?B?VzkrQXkrZW00Vnh5M2VYWnk5NktyczlqZStUMlhnR2FHeWlwY25adHZDQVJu?=
 =?utf-8?B?ODhiQUhTWG9tRW9oV1MwQW04Ym45T24rS1dnWVRnVFI0TEt5RnNKdk82OE1K?=
 =?utf-8?B?SU9XbllSd1VBZmlEdk5jdHY0OXdOTlIvcVJzNnBISlJYSTU5bE1KaDFnYTU2?=
 =?utf-8?B?aURrc3c5emNjQVpsK3EwVFJUS1NjRmpUclAwelRvbHYyNEhqMlJRMjFLa290?=
 =?utf-8?B?N3RkUldxN2VoSUh6UG1uN3ZpWCtKTU9nMXJLNUtzb3JtQTQrQ3A0VUpJdW9S?=
 =?utf-8?B?ZThKd0ZBTVdyWDVJTTVia2lrdkRyUklwTEpDRzJoUzRnODJ1Smt4K3FWNk1R?=
 =?utf-8?B?VVB3aXVlRkI4a0JxNkRwRmdJbVpDL3NnSEs2N3dPU3V6ZngzREg1RHNqTUxv?=
 =?utf-8?B?bXFSU0cvbFhiWFU2S0VEaTVWcERvRlZ0MWpyazBRb3hFUnRWdmU2bDNINnZ1?=
 =?utf-8?B?c1hqbnNPUlBYV1Fuc2ZRYnZzblRtdHhwd0lRZkwzNGxzRmVGakptSUZyQkxp?=
 =?utf-8?B?dzZHNCtFRmxVSEN5ZlIwZzNhbGlURXh5dmVSczB2d0RyN2paS0MxN0R4TWZh?=
 =?utf-8?B?U1UxREF3cmJiTDA1Sncxd0JGbVY5UXVoQ2hUdXAzL1Nubk5HaTR2QU13TlRB?=
 =?utf-8?B?OUs3ZFJjNkxGamVaZHlsbTk1SkNwSUZuSS9ady9wVk9pU0ZhY1VLL0xidnRP?=
 =?utf-8?B?TmZWS3A3QzA5aE5WY3IyRnA5WTU3V3puVWdtd2hxZzVMR1BuRStjVU1hME5D?=
 =?utf-8?B?Q0dxbnJHTE9Wd0VYdzNIOERPZEsrSSsrNE5ScTZzQytub0s1WXR4dXcrL3RM?=
 =?utf-8?B?dStjUml3ZzVrbHk0SzFQWm56U0NJRm4zems2S2NTLzgrcndobDB4YjV5bEVQ?=
 =?utf-8?B?cVFFb3JDN0dkRkt4Q09SaE9vVTZyV1RzMlNtOHJIZWgyaHFIWnBVZEVCdUZq?=
 =?utf-8?B?Yll4WXJqN250b2J1OGR0a1drS0NzSG45WFYrNmJQdnBtTlNDcjBhYjdkcGRz?=
 =?utf-8?B?MURYQmtoTWJYRUVqdUFMMTd3OTIrbGlCcThDa1hBSXJHYjgvT1BOcnl1bzBz?=
 =?utf-8?B?TmZ1NDdzWTZueHZlQmhzRy9EK0JucHRqMy9JZmhmNzlWOU1VazhIQ2JMY2ZB?=
 =?utf-8?B?Y0kyVitJQ3Z1b3k5YnlFQWUvdG5CV2VBa3RWd1NvQ3ZxRnh4YnR5OTJwemRq?=
 =?utf-8?B?YmJ3QjkyN0krK2lnTDBMekhkT2ZnMUhnRnFnZS9JWHRTdTdXVUtHTUhnZm9P?=
 =?utf-8?B?TmE0QncxeTM4c0dyaE1tZXUxUlQvamx2cythOERHaENJb2wyK0NLNVY2aG1G?=
 =?utf-8?B?aE80aHI2NU1FNEgwQS9YdTZjcFQ2YkVUU3Z0SG95akRLNWpJNXdxRUhLZ0Jt?=
 =?utf-8?B?SlVGaHF0UkNuU2E0NXd6dGJDMTlhMkVzNUovcitna3REM3JrUnBKL2p2YzBy?=
 =?utf-8?B?SS9FVE40bkJmQkd1UFF5OEdmZmNYWTExY0JvcEExM2hXZkt4UTZKdzg1YkV0?=
 =?utf-8?B?SzRXZ2tocXh0S0JEOVNwT0hWRmR2NCtYRzlEZXRlcTdMMW0za1dZWkt4bDlN?=
 =?utf-8?Q?HC0COwEd0XjaQ2TkXeLxb1wGF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed9c8f0-9ac7-4b5e-6120-08dcba8ddb42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 05:16:01.4506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23pug2bEXV2EYjnuFfxcYwPMFUPDSgw3/gmAxx4k/GzHgaIe67kSBTP5XGU/KQlx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
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



On 8/12/2024 10:35 AM, Zhang, Hawking wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Yes, this applies to all types of Tas
> 

Presently, we have this -
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c#L925

which makes use of XGMI TA commands in VF mode.

Thanks,
Lijo

> Regards,
> Hawking
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, August 12, 2024 12:52
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Do not init ta microcode from guest side
> 
> 
> 
> On 8/12/2024 8:52 AM, Hawking Zhang wrote:
>> TA should not be loaded from guest side.
> 
> Does this apply to XGMI TA?
> 
> Thanks,
> Lijo
> 
>>
>> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
>> Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>> index 85ec9e35690a..749d8143b1e7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
>> @@ -132,9 +132,11 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
>>                   (adev->emu_flags & AMDGPU_EMU_dGPU_SIDEWINDER))
>>                       break;
>>               /* It's not necessary to load ras ta on Guest side */
>> -             err = psp_init_ta_microcode(psp, ucode_prefix);
>> -             if (err)
>> -                     return err;
>> +             if (!amdgpu_sriov_vf(adev)) {
>> +                     err = psp_init_ta_microcode(psp, ucode_prefix);
>> +                     if (err)
>> +                             return err;
>> +             }
>>               break;
>>       default:
>>               BUG();
