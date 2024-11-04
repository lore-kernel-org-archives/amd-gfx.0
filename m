Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31FED111A3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 04:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9023C10E0A5;
	Mon,  4 Nov 2024 04:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="USBY5gjm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD1D10E0A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 04:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeT2KWrj+4vjvmzFQPeRQXDow0rZ6Lx1X5QNThsdqoTyes/nBkYPmlMs8ZbQOn/qick6nFSQam+ndl4+HfqMIeMVTnkriH1rjUquiSayensiTSb1navnCYddQIXWAgahTX9ACXnk6mNjUZgX/7s9rVYPqhynriY9IYGXLNBv40TtvV+2137EMpgVpfj/5C/DPzlyxjjcfFXACB07O123NFA7UQU+v2JqrbFoWEEQg/lG5S8PdfyHPrdZm2ESAAtuq+n4Q/bII3oCbZb74gV4tQG6TC8QAwyZcq41DftAwfmJivzWrl1u4EDvlav2tBKqOW06yxbd/WkPMTUFQ9JeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgR982pLRCYKIV1/UKdYbgzHkW1azSXEbodp5SpFjm8=;
 b=gnOzjNZ1YQshXP87fndxniL1IQqbh3s+yLudtZL/+MpfW8Uey71254OLh5teRWRBMRO9BBy2kxtOqPIklln3wi8MHS+4lkn8l00e24CA4Ic7dDFtWlX7/8eNgF+dJ526ww1LPzPrDOsTT43MqaAhmW6RDpiQteeXajtio3TYCtyf/Hh0kLOLUiE9/Kj1WnG9n4XR/j7be3sGMNi0jUS268DDCDbiBeeWiBXmHutZ2oy3Nd3B1JhayuBzCdjM1+/kvzanYfV9kaonxlUwiZ1PYL/wzuGcZOjTPm0IcW2htNmOtRSOcXdXheKrzR8t06oxoFySARJvV8pjxIz2lajI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgR982pLRCYKIV1/UKdYbgzHkW1azSXEbodp5SpFjm8=;
 b=USBY5gjm0E/U/qIhHoR6Qr4Zzu7K6wLihBwq7GYb9qZfT0srNanN5AYl0ijYRDoX+DKFStSUmSXrdlNGLNSUffFAozREsQawmAweVF2Jz6Ra42TylC7b+R8VVFsXAN86T9LjHHeC+iyOPXntCHmcwPrxaQSZskTs+6AmYWkBHcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 04:05:54 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 04:05:54 +0000
Subject: Re: [PATCH v1 9/9] drm/amdgpu: remove unused ip_dump from vcn device
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241029135020.2494491-1-sunil.khatri@amd.com>
 <20241029135020.2494491-10-sunil.khatri@amd.com>
 <85a76c07-5a04-45da-af1c-08909c4ca578@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <e3d110f7-3132-c5a5-da7f-fc990d6e9838@amd.com>
Date: Mon, 4 Nov 2024 09:35:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <85a76c07-5a04-45da-af1c-08909c4ca578@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 098d565f-a33a-41e7-b37f-08dcfc85fa66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjkvV3ZOdWdCYk0wNy9aVUxnblhyVk16Q1BWc01BTFR5WXpFRVY3ZVBzR01G?=
 =?utf-8?B?QU42aENFMnppZGxvQzJ5M1NlQ1Izc3VnNXlRZkdzK3FoZDRBR2kweG1SUENP?=
 =?utf-8?B?RG1Pdmxra2NKNkZTcFJiWUJqdDZoeEdudm1QNFdaNzJnT0NjRVB3QzkwdUN2?=
 =?utf-8?B?ODdqcDdlZThvZE45c2ZTZjVjbDc2Uy9yT3BCVmREL3Y4MG50cnhFK3cveUdu?=
 =?utf-8?B?RFNmaEtkU1h6SkhPeEZoczRHU1F4T21EdmlLTlBuMUp0T3FpQThvSTZwS2wv?=
 =?utf-8?B?K3UxZGgxN3FwblNmL0N0R0RSWUp6L2Z0SlF1RmxILzMzdFZqczY0RU8yZlpI?=
 =?utf-8?B?bWV6Q05td2QzdWpsazRVTEhCUzhySS94Rmhkc0djYzdsSCtTSkJwZEd3Qlpw?=
 =?utf-8?B?SmNWcTNXQmZ3TGxuaHVkV0c1QW0wcVc4S0JEaWthcjNmeUdSSlp0WkVBem9y?=
 =?utf-8?B?NStTT0lwcXJiV1NFYUR4VDk3MDBzbU5KaWpQY0VnRmF5VDB3WU9jSmJ6ZWQ5?=
 =?utf-8?B?em5jSC9iK3FFWkcrK1JCQnczSlFQbk9rT1ovWUtuQWw0a0VZdld4S3pLQjlG?=
 =?utf-8?B?Mzc1Y2FIRisyV3ZDUm5QZmpPZ2Q4blY4ZWkxVTdyQjhBLzhBblpwekI3dU9v?=
 =?utf-8?B?NVZJYjNEa1RPMlM5Z0ZtTVFJczNEMERPVWx2NzZiMkpUTmZqbEYvbmYrazl3?=
 =?utf-8?B?cHd0YnNSWlRScG9PK3R4ZmVnWFNoYytEZXFXbDFIQlVUOHJlSWFXMHZMckFZ?=
 =?utf-8?B?a1huVWdQTEVNNU9WMjhLc0M1d0k3dUV4ekpudmQ5eTU4NFNORGt6TjNockZ2?=
 =?utf-8?B?OWl0dUNyNk56WnZTN1BiaXdGWE5vTEFuSW1MVkwzTHE1K0lkTWUzYjY5R0Rj?=
 =?utf-8?B?ZXFKTjhuVUJTUFcvVW53RXRlMFh3VVJKL1JiQlJSWDZuV2kzTVRNTHFodS9n?=
 =?utf-8?B?YlRKaWJZMVprMmlzb1RyNnZOclhRQStjYzdwclJ2aElXQUpMSW5aSWMrOXg1?=
 =?utf-8?B?SlJvRVNWWXFFMk1LN2tnOG5oRkJTQ0tadzNpSk41VnJhQkgyZ1VmbW1NeERl?=
 =?utf-8?B?SC9oTzRlQTcvZ0tJTkFlaWhvaTJvQmh6QlREZysvdHV1VFMzdEp4MnQ4dUpn?=
 =?utf-8?B?d0dJajYxV2V2MmhESnNzNkJHeGxqN1BGMTd2a3hqUUtlRDdZUGFuakJTVVJj?=
 =?utf-8?B?N3k4eFRuUWRMaGhHQ1ZZUnpDRjh0cW1rYzNzK1BwZkoyQ0JwNzlxcGJiYUhB?=
 =?utf-8?B?aE1uM0g4VlpkV25vT29VdFJYZnZHTXg5RkwweW1PS1NGL045dlQ3bEJldWFi?=
 =?utf-8?B?WGFNZ3p0QWZSK0JaWGpmcmZ2WS8xVC9CQmtxZHljOWZhbmpwdEU4eGNnNHk3?=
 =?utf-8?B?SU5CSnE0d3JWMTdIN0xtcUI5bkMvTHdwMGc4WjV0QTlIWUdxelhQclp5STJD?=
 =?utf-8?B?TUtuNjhyQndBSUN5WEFWVEd3NDBkZXFGQnlTVzJCOWMvejFnU1dsQUlZanlW?=
 =?utf-8?B?RlNYVFlYYSszbkZyb0JqQ3ozZnl6aHBZTDlnMlQ4Nm02UVpFcmxScnZQRERB?=
 =?utf-8?B?RGVLQStxelBSOGlxbkZQMnp2NmNiYUw5T1dGb2xaa0RRYXlmWjlzNDFDYnhY?=
 =?utf-8?B?L3FVMGRLUTd6Tm5WK0I3MHJET3ZaRTNSbnNySXFoaWVrUXc4b01CVDBPV05w?=
 =?utf-8?B?Smp5dTdTR1g5MlFMelQwOERQL2pmTlpuRkNMOFhmd2traDVINlpjTTRDT0t1?=
 =?utf-8?Q?w9r8VeeOcOXV+mqYGH5p4Ccy3ZfI1+OLIERtdrX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFBRHhmd3JYTHNhWjdNUDF0dUoxckhES2xLV1ZsU21PeGJzb01iaDYyd3gx?=
 =?utf-8?B?Wi9BbFU4eW1sdjBaNFRnbUp1MERXUEsrWlB6bHR0dFVOK3NiUVhndE44YXN6?=
 =?utf-8?B?M09zbWttcFRiRDk4UGpuRlk4cGdDZ3hVZzRDTDZqek0ySmZmcDhVSGVDMStW?=
 =?utf-8?B?UUZKNWZZei9XNkRFZTh2bjl1bzlpcWcrWVYwQk5qeFBMdHM3dXlGUjN0YVNK?=
 =?utf-8?B?Rit1VVI1MzJKdytaVWhBUkVZVkVyOWltd1RybUhVL21XVXpaWER2RXdYblNt?=
 =?utf-8?B?SXlJVDVDKzNvcFE5YURud0VSNXp5QTlDOVNJOEJMaDZHcDNkRFNHZ3dKVTdz?=
 =?utf-8?B?NndlQUhmd0YraGw4dkJVMzZPSkNjbEhaMFRWdFlZYjg3dlhNdXZqdktnRmNX?=
 =?utf-8?B?eXVHTnJZeFprREM1cmxveWRjcmtjTm4zYVdXa3ZoSTZnMktBdkRLUGRjSFlZ?=
 =?utf-8?B?WmgzYWxCb3lZR01jdVlteTVFS1Z1YUE0YXN2ZlE1S0V5NXVLYk5JSU5uVkRm?=
 =?utf-8?B?WCthM0ZrUmk0OERHZm5MSno1OUdVY3I2YSs1WlNWV1FMenM4cklBNnUrZTVJ?=
 =?utf-8?B?c0w4c3QvcjVsWUZsd3YxUGp6RElFbGs5K3AwdXZQK3Jva3FPb1J1QzlKZGcr?=
 =?utf-8?B?aFNaclFnbUk1UWsxU3BFWWRsYjZndFdYdUJwNytaTkpQbUJ6cmZvSzU4UlVE?=
 =?utf-8?B?WktvenNYM2NmOVFIMHNnQUJKWVp3eFRBb3NVdEx6S2hUenRtanZhMWdYUEs0?=
 =?utf-8?B?RE1kZG1MaEF2bTdDNEZNaXpXSldxMGFzNVJFczlKclYycFVSQzFYQkFIbGJR?=
 =?utf-8?B?WVp0VXA0T1d4b3NRRU85cWhvYkUrSXRXWHpsR3Y4Q0xaa0g5dytuSkt4Nnp1?=
 =?utf-8?B?QWFCUmNNcVh2aGZJZy9iMjNJTktWRmgxN09vVW1PYmJrTDYxdkRLMmRRQzRN?=
 =?utf-8?B?eUhZYjB6UDh5OFNDTFpyUDU3Tjh4L2dYTGhPcTc4dmNEcmdJMFpocUZkbzQy?=
 =?utf-8?B?bGlocjJRLyt1TVdYQzQwK0RvZGRsaHNFcFJmVWR6VzFGUkczWjlqRVRTbTB0?=
 =?utf-8?B?ak5mY3cwUHJKVFEybTJPaGF4bjJGNFFpTHFnazU0eDVtMjVjZ2g0VHBRTHRY?=
 =?utf-8?B?VXlnaVpYQk5mQ3lLNGZsZUdXZFNGbC8wOGg3M1NhZzh4TkVTZzZBTHZ1Yzl0?=
 =?utf-8?B?Nmc5U3JldEFIK3plT2dobjBDcXEzaE5jR0lzS0g3K1lDN2xOUVMyTmJIa1lF?=
 =?utf-8?B?ZTA4L00wcXdRTFczVDRUVWh6WUttSlVEM29FR1hzRTVES3JKMkRLZVQ0WHpz?=
 =?utf-8?B?N2xiNmpKdkpoajQrWVpETVVCZm9aR1FRdlpCRzljOFlSUFJ3TE1GMzc3eTFM?=
 =?utf-8?B?NFlxVG8wKzIrOGVBR1NoR29qODlzUXpVSUNLRjdxdThRT0FCWXVJMis5NmQx?=
 =?utf-8?B?Q0dRZW1yTWh3V3NkVHBPUDRaVnF1OEZHYnFENTB4djJJRE9EMEl2WXFGcVJ0?=
 =?utf-8?B?WkZLYmJRNERKU1NQbUl3UXI2WEhhVHUxMlNXbnViZzA5aFdFUjJvbnFmQ1Rl?=
 =?utf-8?B?dDFMNFpjYWJpakxZV0ZwV3p5RXMwSXlwaDlIdXN4WEZpNmlvbHV5eTF6MUdY?=
 =?utf-8?B?NmlyY01ZVFBmWmhiSzVWWmlvcDNKYjI4TWdxSHJ3Z3c1Z1VFZjE5ZisyKzNi?=
 =?utf-8?B?NXVsYzFRSE1TVlNoK1Fyd1RvWHNncklPa3crQnpJYXBkVndXZ2RsRHdmRURG?=
 =?utf-8?B?eEZza2ZzOHRmRHpyZzR3UDd2ZlhubG5Tc0hQMUVJa0ZoOTk3Y2VPTndHZmtu?=
 =?utf-8?B?YXF5SlZHMVozem42WjB4Z2Q4a1o4MVh6aHpGMlVzUnh6dXZ1OGYrN2EzWXB0?=
 =?utf-8?B?SS9URTY5ZXRjM3ZQR2VZWmI1eDZMUmJTdE1IK1RuZXl3SE96bEtETnUxMzNS?=
 =?utf-8?B?d0hqZ0JaRGovUVVzRjkrTlBORHZuazZ0aTBwRzRLNE82dE9rNi9Mbk53V0x2?=
 =?utf-8?B?VzFSVGplRHg4c1dCeHdabTN5dVFKMm9kZ3o2TUJzNWtTeVJMdXlHN3NOVGNN?=
 =?utf-8?B?UmVZMXRrUENmSzVrMzRUdVhTMWVtV3RHTUVwNndOVERDQWtiTmdlQ1BjSUVH?=
 =?utf-8?Q?U0bo3nsm3NdKuN3eywaFGSZB3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098d565f-a33a-41e7-b37f-08dcfc85fa66
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 04:05:54.2655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de0IOl3aBR0W8kJ+RiHXo3odaNPG48elUUDLlVkG3cxq+tyaueBhl0PgWZY/P8FGwkgMvePD7Rk23/bw6qqgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
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


On 10/31/2024 3:23 PM, Christian König wrote:
> Am 29.10.24 um 14:50 schrieb Sunil Khatri:
>> ip_dump pointer for the vcn has now moved to the
>> per instance ip_block hence clean the old pointer
>> from the vcn device.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com> for the entire 
> series.
>
> And Alex is right we should really look into moving the harvest config 
> into the IP block state as well.
> I guess Boyuan will be taking care of that.

> Regards
> Sunil Khatri
>
> Regards,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index 6cd094ee8218..7aa52a04b488 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -332,9 +332,6 @@ struct amdgpu_vcn {
>>       uint16_t inst_mask;
>>       uint8_t    num_inst_per_aid;
>>       bool using_unified_queue;
>> -
>> -    /* IP reg dump */
>> -    uint32_t        *ip_dump;
>>   };
>>     struct amdgpu_fw_shared_rb_ptrs_struct {
>
