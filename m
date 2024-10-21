Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65498D3E196
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 17:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39B110E571;
	Mon, 21 Oct 2024 17:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="py1FKkSP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC6610E571
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 17:35:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE6ZxyR66jVbmr8RMb23B4y2mDBku9QBwGa+eOX9oQybrwd/hZ2qLSDvscMZQH7y3JpjQWHMtHsaEJBYYiMJxvTaI1Dl4sGmNx6OEQ1d6URawFvFB5pdvJri4CepK4vDnWhsYt1b8sSC6miM9CXKUtdGrqvyQjvQWzdwZqOmC2jR+VzlotixAnt4CJ2vPWkdzdIvr5rUzY7q8SD6MzybjmAXKlNsufusQt2U49hJAoYZ/8Xg81Ell1Go33XD0trI1oAg+osfD5FTpP+SILOsNp54NSt2zqYkAY+T2x8WOzQ8CgWapSlVMr8JTDa/ZYzzLxCxsX01x2SgliMEhBVXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6JaKy78Zu6CcbM11q7awM7ETNTwWcjji9fu0PH5EA0=;
 b=vyn+NYz/6IaS1ted3q2pRP6WZuKIlhN7nfuegZuS8t+E8oCxPayy6IE0K6ILi7sXXsHcjD7jdLzXGsY/KJwf5Atw637o6qTAkAfnz+l/3IZR59297vT8/EU1WhfJR2kPwJSuFefZXrKgGNAgWwzMQZniL1YFzhN5VyLE7rETH5Dynkl/A6C5zha4Grt5iIeX8lyb1+fQejf9Y2faWy5kMh10ETav5p6B8hq11gyQll75mL/DCy/Vwa1y61qPPzE71dc4bZCQC2k8FVHEFeyIwf0nToz4A0R1bEOKv5kewh+gWJnGT7O1uLzsBjzv0nP6VxZIdYT4Vjd+H4CCsEeYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6JaKy78Zu6CcbM11q7awM7ETNTwWcjji9fu0PH5EA0=;
 b=py1FKkSP2EueopffNpGCIf1Tl6/R2d7/rqnaasEJyOim+SQgDRQF7WNLPFm9qvBOSmPEGr4XvRGwWe6+6VNPN7XwkgNl45FoFDhCedgENN1eUMJTng8sv3pc/SeJXDZ/WzLcUzxjeV6mqTNaFII4vwAHu6/LwFc/2E91O0B9WTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 17:35:15 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:35:15 +0000
Message-ID: <4a4be2d3-da50-4b60-abe6-2be01867aa5d@amd.com>
Date: Mon, 21 Oct 2024 13:35:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: sever xgmi io link if host driver has disable
 sharing
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yao, Yiqing(James)" <YiQing.Yao@amd.com>
References: <20241016155833.956478-1-jonathan.kim@amd.com>
 <CY8PR12MB7435752CDBFDEF81C128F44D85462@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
In-Reply-To: <CY8PR12MB7435752CDBFDEF81C128F44D85462@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::31) To CY8PR12MB7099.namprd12.prod.outlook.com
 (2603:10b6:930:61::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7099:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: c314b084-b46c-4186-07c4-08dcf1f6b930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE9wbCtKY0taNFpONEgrUWNnaTNYanpOYTBUdUpPRDRrZHBjbmV1QzhhUGgw?=
 =?utf-8?B?T2NaYUlsbVNFYVVJWnFBamxrQTJEWTJxTS9vU0UwSXhrU096Sk9seG0zaE5E?=
 =?utf-8?B?YUxLOUp4amdiZ3Mwb2VNc2pkaUk5K243eHliR1BhaWtEVUlhd1poY3FERDBs?=
 =?utf-8?B?MFdVd0h5UWNJaTlPcUlCclNBUms3YmlOZ2dYTWdObHdsbVpLazFtZFdtbEQ3?=
 =?utf-8?B?WDE3ZHRhMTNycGoweEllWUNEQkFWc3VjejZlaEZSelRjQ0ZYOTJEWUdSbGMv?=
 =?utf-8?B?aFM4aGh2RTBPTE1aK3Y2bHB3elNpenF5ZTNLUEo2TEp4Rm84eTgwOUNkb01L?=
 =?utf-8?B?Z29QVVFBakQrTWpHUTJjRzFLZUNTNHlnenAzb3hTK3p2ajkwT3N5WHpDWmNN?=
 =?utf-8?B?K1RkY0RmNDNlRG9DaE8yblRzTnorRTluZ2NNWHFpUWZIalY3Q0ZDTElrVEk4?=
 =?utf-8?B?aG1McWNZZXNQLzRUQzlFUGpHK3ZVV3BLVjZjeFlmOS9sT2pzTk5VaGgxeU45?=
 =?utf-8?B?MlN6azRpWStEbmFYNHZCWWFmcm15NTZkdDNyZS8xMnlqWHJjUllvRndjYlN6?=
 =?utf-8?B?VllXSlIxdG1VUGljRGdReER0VGgzejFPNVZkTkdtL1FpZFJPVHRsUGV1Q2U1?=
 =?utf-8?B?dDBKc1VOS3o0RStzN0RXNEY5TUZrd1BEYmY5ekJBdzFIc3BFaXZ5VmNBU1hF?=
 =?utf-8?B?b1BQM285VmJHaVlrQ01wZWQ2cnNwTEw2RHhBNU80M3hUT1g1RTlOWjUwOXhz?=
 =?utf-8?B?ZlVMU0Zudng4S3R6ZitDV1ZHOFVldkdtOU9mZVJqZlh0bUttWGZpZEE5QUxY?=
 =?utf-8?B?bjBFN0pVZ0E1bkN6eEdRamFvdWdFVDY1enp1N2tRWWx2YlZUK3ByTEpIcTl5?=
 =?utf-8?B?OUFYZ05hUnVnSjNxRHV1cUJGT1Fya0kvS1VaVklSa1lod3RBT205NXlkbjBt?=
 =?utf-8?B?RmtCdzRScFRjelFnUTNTaVNBK0lMZjRyU3hGTXNEU2lPYlJiZi8xMkpXUE9z?=
 =?utf-8?B?ZklGQ3hoWlNXczAzTG4zRjZWZE9yRmxla3NBNnRsNi9XSDNNUVFObjBxZzJi?=
 =?utf-8?B?ZXBYZzN4MGE0TFZRSXlNMS9OS3dZQ0dRdlk0SjliRG8wbTZvVjZ3TjZlSVVM?=
 =?utf-8?B?cGtQUnVJVXcybzZEdHV4Q2VUWVd5OEJxYjA2VDRBVytJOWw5aVROQndYMmRo?=
 =?utf-8?B?MWdGZ0hQaThxK040a0JlbjB4RnVuVHprazd4ZE9HQm9IT1J1UkdrdDRmY05I?=
 =?utf-8?B?SHVNeW51QW5JdW1HT1lTcGo1QXJpZTFFRXNIL1lHMnBNL242U2JCQUVBK1dq?=
 =?utf-8?B?Nm4xMG5RVWtkZGQ3VEFUSlMrcmZ0b1pFWmRxbTdpa1crdkxpK2lNSGxrbkJ6?=
 =?utf-8?B?cytuaHFwWnFqWkVnSUNFcGxObXRETnZxanNjVldUWkhHV3dTeDJRaFRpZ3Vq?=
 =?utf-8?B?bmt5WE5LL0gvdzlWdGR3YmVwcmZRQ0o3dHJuYVgzVG5Udm4rVWNNblpQSnRI?=
 =?utf-8?B?WEZPRUQ5c1lKcXJWL2djTWUwVkJGRnRPdWxyTTFGUm5TRlRNLzlDVmlxTExW?=
 =?utf-8?B?azFuUGhjcTdYR01HbTkyMWF6SmVhS3RERzMwRC96aXJ4cCsxMVczVDZmUGVa?=
 =?utf-8?B?bjhRMlFUSGVOeWRVMy9qa1JuS1ZBVnB0UncwWWF4VGE0aXc5c21ibkFvOHpQ?=
 =?utf-8?B?NFhYUVdqWkVaVlF3bWRJeHQ3elVpTzJ2Z1F2cGNwVFhjN21DSVhkaHlRR2I2?=
 =?utf-8?Q?rKzdPS4SqgL2pVOglHFuldb/6SB1m33bOdS1SUS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eit1bFAxMkZtN2ZheU1sWGdkNFdJWERidE1vdlJYTEoxVUp0enAyYXExcmMw?=
 =?utf-8?B?ZEFZUEVCU1RZL293V0NNM0Ztc3BYYm9yL04xRGFqL1ZNUjhHMTR4cXc2VDh3?=
 =?utf-8?B?LzlOUlI0NnNidkFqekx6RXg2VHJxT3lWZnNWbktNVklJd3hMK2FsNDF2bDFr?=
 =?utf-8?B?d3VDWmNVYXk3U0NaVkVBVy90clBZWm5UVWY4cm16WEl4cTNVanAxTHZGWVIr?=
 =?utf-8?B?UXU5VUQ0WXFQS0xxbEcxVWh4ei9aQmwzZTB1cHJYajk2OTBMcmM0TytZYzdJ?=
 =?utf-8?B?UjEyUUZNOGtsSkcvYjFRaEd1b3FkY3IyZ1kzY3lBcGR0bmhxb1BETHk2Q3Nm?=
 =?utf-8?B?MVdkRFM4Sk9mNlk1aU8xK1NSVStRVXBtQ2g3RUdQMWlYalo1QVpkUlJDTXhJ?=
 =?utf-8?B?VFdMOUFuZUROWHptTnE3Ylc0ZVFhMXZKOVF4RjNGdUt1ZjgybjlhY2x6SkZn?=
 =?utf-8?B?bUR5dWhKbWlTcDZuQ3NmcTluTEFrcENWVityYitaVlUrTDM4K0F1VFh3Skp1?=
 =?utf-8?B?eWNWYjVDWk03NWM5SW5HeG9FT1FCd3lVSFFndmMzUTQ0OVlwKzhjUHBqdFdF?=
 =?utf-8?B?Y3NTb2NrS3JMWk9pcWtqZmhnNHY2U1RqTUtYU3JrR3BKZUpzeDFCQnVCOXFR?=
 =?utf-8?B?OFdrclJHRWhvTXlxZ2JQS2s5R0RrcVFTWnRFdG0vbWlHUzcyVnhPNTh0NnFl?=
 =?utf-8?B?MUh5N3VCTk9PSHQ2Qnd6S1J2UzdheGN4dFlIQ2FGT1FIL1JhWUw2MlVvdkFL?=
 =?utf-8?B?L3JIQzYzWWVDTUdXQzNFSjRvalhIZGFyaURINlU3eS9yN2g3Zyt4YkhaYzRx?=
 =?utf-8?B?Y3VCbDd5UlgxaWhkRUJBTyt6b1J4V1lyRnVEbDB4VmJVbGJCK3dQeHQ0OWNH?=
 =?utf-8?B?bTg2Q0ZrcmxLb3hlcDhtS2FnNGNuWWZDRUxCRjZqN1JMTHF0UTNQR05pck5i?=
 =?utf-8?B?cGNMWTVPcGdUck1scGlGRUVJcEdkUlh3cTl0V1o5ZFpwcUdkSjNWMFFNKzVO?=
 =?utf-8?B?Vy82VW9NeE14bzhPN2x6NU1rR2k5RnJmUFpKcU42cEM0bzdqWkVwRWhLbmRS?=
 =?utf-8?B?OTlORUhaNEl5cEhvRjhnNUR3V3FoRFhNR2RPSUxNRzBwUFhrZERjWFJkVUI5?=
 =?utf-8?B?c1dXcnVyS0VIWXNqWitVYTNNbFFqMVppWkNGM0ZRVVhMS1l6OXlmSHJMYkFG?=
 =?utf-8?B?Mk9OQzAvaXdmSGdqVzV3aGFLNk0xM3Nsems5N2VGdG9PdXBFR09PMjdlM1B5?=
 =?utf-8?B?UG91WE8yeiszaXlmKzhJelc0Z01uNkczaHhGQ0J3TS9qVkJOKzFCYjVBaVVW?=
 =?utf-8?B?WlV3T0ZmVkYxK0MxSENNaXFwU3Y4dlg1WVdyRzdOTFdVMU1UcVpOMWIrbHFP?=
 =?utf-8?B?cURrL2YwaTByK3BTYVVqYklNclZvWWVjUHQwK25TdHZBeUd3WUpHTzZvNzVO?=
 =?utf-8?B?MDI0UWNHVCtJcmpOZEZlbWtTai9sL3Jybm1hUEJtMGFIZ2ZrUkM4V3VFanVr?=
 =?utf-8?B?cFA0dkp5bzErRmhyd3ZQeTZTKzE2aS9WWUV0UTZsbEJrZzQ5YmZaVkxXSkY0?=
 =?utf-8?B?Y2tJYWFVL2xOSjYveXl5ZHRsdVVZSEM4WTA5VUJFRkFvVVFJeExzUDViQjEy?=
 =?utf-8?B?Ris3RWtDT2ZKcnV5V21HbFJMakR0ME5vRTlzaVdxNzV4Q2hUNVhUaFYvQjNl?=
 =?utf-8?B?UngrRFQvZmZnaTI3S0lUT21Qd3hzbllOQm1ZdlBrU3E5bGFKVGNtL0djYVhL?=
 =?utf-8?B?TVA1eTV2cmYwM0U0b05qcnVDd3g1SUh5ZmdWMmp6bVNDRzRsS0U5NFBsVGxH?=
 =?utf-8?B?bDdqeC9uSnozRGNvMkVaMGJaUFR3Y3lNWlZIT2dDSW8yOVFUbDhxUitiVHdj?=
 =?utf-8?B?eWgxVXc3T29IOEhycVBmRW4wenRWTitlbWNVaVpVWkR2eC9KL2l2UU54d3RT?=
 =?utf-8?B?UFRpWG96ckk2V1pZNW5uUTFBMFljY01ubmhSRytRbytXZ091OGdYd2xTNDN2?=
 =?utf-8?B?VUdtNlNuMmhVaWlBUEMrVC9wWXpIdGhIUXNibndTakcrcWw3NVZnOEtoNUVL?=
 =?utf-8?B?L2RldDF2R1ZSN0hLTHd3MlcwTWpNQXBXbFJnblJHZVczNldESUdFakUxb2lT?=
 =?utf-8?Q?gF9XGEB1RmHgGhK0Sj3642bU1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c314b084-b46c-4186-07c4-08dcf1f6b930
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:35:15.3038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VN186tQic8NkTLq74aJsDMlkHRZ/6C3dPfBwgNw264XldqcG19QBx2QWtG53O27FxA9J1mSAtWwUZEfaTluc4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

On 2024-10-16 15:08, Kim, Jonathan wrote:
> [Public]
> 
> Messed up James' email in Tested-by tag.  CC'ing James.
> 
>> -----Original Message-----
>> From: Kim, Jonathan <Jonathan.Kim@amd.com>
>> Sent: Wednesday, October 16, 2024 11:59 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Kim,
>> Jonathan <Jonathan.Kim@amd.com>; James Yao <yiqing@yao.amd.com>
>> Subject: [PATCH] drm/amdkfd: sever xgmi io link if host driver has disable sharing
>>
>> From: Jonathan Kim <Jonathan.Kim@amd.com>
>>
>> Host drivers can create partial hives per guest by disabling xgmi sharing
>> between certain peers in the main hive.
>> Typically, these partial hives are fully connected per guest session.
>> In the event that the host makes a mistake by adding a non-shared node
>> to a guest session, have the KFD reflect sharing disabled by severing
>> the IO link.
>>
>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>> Tested-by: James Yao <yiqing@yao.amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 17 +++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  2 ++
>>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c    |  3 +++
>>  3 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> index fcdbcff57632..1d50f327eb08 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> @@ -801,6 +801,23 @@ int amdgpu_xgmi_get_num_links(struct amdgpu_device
>> *adev,
>>       return  -EINVAL;
>>  }
>>
>> +bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
>> +                                     struct amdgpu_device *peer_adev)
>> +{
>> +     struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
>> +     int i;
>> +
>> +     /* Sharing should always be enabled for non-SRIOV. */
>> +     if (!amdgpu_sriov_vf(adev))
>> +             return true;
>> +
>> +     for (i = 0 ; i < top->num_nodes; ++i)
>> +             if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
>> +                     return !!top->nodes[i].is_sharing_enabled;
>> +
>> +     return false;
>> +}
>> +
>>  /*
>>   * Devices that support extended data require the entire hive to initialize with
>>   * the shared memory buffer flag set.
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> index 41d5f97fc77a..8cc7ab38db7c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> @@ -66,6 +66,8 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device
>> *adev,
>>               struct amdgpu_device *peer_adev);
>>  int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
>>               struct amdgpu_device *peer_adev);
>> +bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
>> +                                     struct amdgpu_device *peer_adev);
>>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
>>                                          uint64_t addr);
>>  static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index 48caecf7e72e..723f1220e1cc 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -28,6 +28,7 @@
>>  #include "kfd_topology.h"
>>  #include "amdgpu.h"
>>  #include "amdgpu_amdkfd.h"
>> +#include "amdgpu_xgmi.h"
>>
>>  /* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
>>   * GPU processor ID are expressed with Bit[31]=1.
>> @@ -2329,6 +2330,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>                               continue;
>>                       if (peer_dev->gpu->kfd->hive_id != kdev->kfd->hive_id)
>>                               continue;
>> +                     if (!amdgpu_xgmi_get_is_sharing_enabled(kdev->adev,
>> peer_dev->gpu->adev))
>> +                             continue;
>>                       sub_type_hdr = (typeof(sub_type_hdr))(
>>                               (char *)sub_type_hdr +
>>                               sizeof(struct crat_subtype_iolink));
>> --
>> 2.34.1
> 
