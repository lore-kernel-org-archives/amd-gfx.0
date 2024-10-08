Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0412CF0428
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 22:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 446F910E261;
	Tue,  8 Oct 2024 22:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3w41rrti";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC37310E261
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 22:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gduZL+dNVAwFG5aCu/OSpBy7A29NI+UZOfDOUFlmYLoM04Gej4ei+uwd5TDoMWkpi9k99spGpHNV7NybnvKkKeaBqhhNEvYxSDmpCzqFqhjFX09RQSWbXKj1O3O5lhVW6JCFLI986okWbVtFug1YDQaWdWqNyOqudDvLtuT2C5WuYBmBP0En3lZITFlH3LHFBUpxLL32+o/D9k1B1NnCuWpq+jNUtdJpygNCXKrHa6BQVZPojz0WIsJ9Nn4IMLJDjwXiYdrJXkuFs9zx94e8Q4/Y38mx7xNSGoZTuJgVeQWRXSfmQlmQOAbJBHiCUCr8Ke/+74/EYZ3Wd77rkMyK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ajti5+yZD1ET8ZxP5COyzUkV47LWPs83OlhSnZJr4c=;
 b=WaKJ0m8lCbVSt5MODA9MGm84B1g5KVMzFQUtV2wIlJ8GVgO4ild6e4HY7e1PJxAJFWTpa3893gU5Wpa2mmYS8ujG+fNqLtR01jbrEv7NLypETKwL0nFzCGdG7IW9x3+hbhqbz+PgMWEJ9DKTG5ZV3aVZwysdIflkbY6oHmg7QQpDV/PeeYxuUH1JP8b3UBXm1niWXQ1HIfnz7o/8WGa/s/PGVIgILGgL61l12XAQU6DyqcKnIA77N8OywKc6vxU6zDSmLxvM8e7fTfYYSQoYx6igiNOmxY+RkZ2jjs3iaU6GeWyOfol7KzaD2JTTc6iCaVCLWtTfk/tpsGu0xhnaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ajti5+yZD1ET8ZxP5COyzUkV47LWPs83OlhSnZJr4c=;
 b=3w41rrtim8PQmw+13zHlgC2x9Yq0rQz+jXwA7HuEOv+xgf2wFj/vXinpBbJSRXuYjoh+s7H7TEQkLiU3e6OTZQkFMHyE7wk7MkfU9Kj7e2lzr6vmAG28jmrs7JE4d8l+GpkZkrUZA0Gft/U7/zBGbcjAyByTTslouYDsjJLfm3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:04:10 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 22:04:10 +0000
Message-ID: <44276ef5-3d8d-42f9-a24f-f3f9093df2a2@amd.com>
Date: Tue, 8 Oct 2024 18:04:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] drm/amdgpu: power vcn 2_5 by instance
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-12-boyuan.zhang@amd.com>
 <4a7b5736-f60b-433b-a021-fef2cf4f2338@amd.com>
 <2d260d2c-d052-4b07-9cbf-0e5fc4199f98@amd.com>
 <5f4babf7-f8b9-4a93-8858-849b8b32c3b9@amd.com>
 <CADnq5_NK2fQMo=N=KEnnw3Not9PnWAw4nBK4+JUfY-Km7dX1Aw@mail.gmail.com>
 <7d48c870-2313-4af8-baea-6b0c423406ba@amd.com>
 <CADnq5_NWsADDzLhQbN2xVdiskX7Bm7abg2NSmP-iWXN===OORA@mail.gmail.com>
 <a4b3d506-1bcd-438e-a264-983c175c71cb@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <a4b3d506-1bcd-438e-a264-983c175c71cb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::12) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cd4112-1d39-4e91-725a-08dce7e52309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elQzdnBUWmtkVk5uTElzMjdLNmJNYWptb3psc2g2NUF2RHJGd0x2QUducjlI?=
 =?utf-8?B?YUg1SXBIUUhFOEVJanA0TzVXYU1XdFlpYUhzV2tLV3BPTXNKeldMRUt3Nmpw?=
 =?utf-8?B?MU9raW0xVXpZVzFqSXVOSXZtcTJRamd6NkM5aXFDUm93b3pRVHdCYWttN2dD?=
 =?utf-8?B?clNtSWc4RnNOb3VzUVV1V3FCeU5DaysxQ29hb0JRbWNIcndFRmFDZHUxOWkv?=
 =?utf-8?B?V2ZxVk1GVHhVME9pbkVjbG50czM0QS9leGpZbWRJc0FQV3Vma1dielVIaEk2?=
 =?utf-8?B?dU9ySjc4Zm1iaDQ5dXJHNVlzL2dTaUVrS3Fkd2hLSXZUbTdFNG8wUVpsZzJE?=
 =?utf-8?B?RmMxbnNvdXpDdjY5N0FuUW5MVUpTckQrN0toOUJTQk1yb05kVWkxUHJqUHg0?=
 =?utf-8?B?N2JyQW1Td1gvdklBaFNVL0xkSzVxQk93NHM0VE5LekFrdkNxMEFLQ05YTWh6?=
 =?utf-8?B?Tk10UFloQUpyeGNHRDliVFNOQWJPVlcyWjFiNVVrT3phR1lFL2JBeXZKTWFh?=
 =?utf-8?B?b3Y4L3FaOG9CMk5pYkVJVU15Mjg1dTNKZ1JIK2tFSW4xZ2w3Y3hMcjJuVFZS?=
 =?utf-8?B?Q0RUWWQxQzhmNStwdCtDcW9pMXhLWkNobVB2OHgxN3R0dG1ERVBpOVMxOWdG?=
 =?utf-8?B?V09qTnp5WFdNOVR2TkxXZE9oUlRic0tjNzBiY0hESDBBZUdGK1MvY3U0T0E2?=
 =?utf-8?B?UEJyVjZiQUhSUjV5ODFSK3hDNWkzRlFmNW5qNGNVWVVjV2JJVTI1NDhmZmYr?=
 =?utf-8?B?bHNXWU9WUkZEUmRac1dYeWFrV2VkWFhkWUcyM1BmVTJoL3hTRmEwTk9Yd0k1?=
 =?utf-8?B?TE5tdEFxYllpUnlvUkdTTStkVFREYU5RMnpWOHR5cENFei8rdy83VDM1Mlg2?=
 =?utf-8?B?K1QxakFuSXVIOFZOSER5OEV3ZFZWU0hPZjY2TzgwWEtHVG5GWlEreFVnQ0hl?=
 =?utf-8?B?WUdNdGtCVG95S2FvU0F2ZkNpUTQ0TUk4TkNNSkNBclB2bU92UURHcDEvN2Rx?=
 =?utf-8?B?WTVieTByV0daUGNIRk5rRTkwK3p1NWhaOWRHVzh4MTkyRVUvR3BYSGNaSjFH?=
 =?utf-8?B?cmJCSVBOcEVkd0ZxUVFMUjEvOStxZEdmNXlpSVE5dWFaRnkvT0l4cjhGeWV4?=
 =?utf-8?B?L0hyLzI0OElYVUFXYll5ekVRV3EzRm5jOVY3SEczaEFGc1ZaMGFDbmw0UXNT?=
 =?utf-8?B?VytSczVoRlYvR2xaVmV4SjY4WWQ0bG9yQmtrUmRLa0xGTTkrdUZCN1R6MUVa?=
 =?utf-8?B?TWpObUs3U1JnL0VkVWRrYjA0OHJockZpL3BidENPR09CcjBRc2NsRnNUbVBC?=
 =?utf-8?B?RUwzdmxiV24zUmIvTE9jU3ZuTC9ZMzk0aVVFVzhmWW1DWUI5cDVDVFV2eHY5?=
 =?utf-8?B?YStMNTFFSGRtT1d5SEt1SHYyeUpRUEZmalJUUExJZDIrN1RhSDRJUnQ0ZHFP?=
 =?utf-8?B?a01MLzBjNFdYVzJuZFEvWlNtWkxyQ1RLK2w4a3gxanI2QjZmRWkwRklJdE1L?=
 =?utf-8?B?eWJvdmFlMlo5dUFsUlNsK1gzYWRBYVFKRnhGSG91MWpGWmFKcGRDM2VLamF1?=
 =?utf-8?B?MFM3dklBVFVNVHFMbWhKY1VYRGlkYnl1aVlUQUp3WjJPQVdBZ3NqK1JwQUdU?=
 =?utf-8?B?ZmFCSzN1WWxjeXdRM0d1RkxjalJCRHhCZmVwd1RhY3hvbVdTRXFMNWNzMFd6?=
 =?utf-8?B?ckpIWlpsUGxQbVN4aC9oLzBzdFgyMXNkelRKNEg1bFBmdllNaS94M3NnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWFrYnhyQ1VpbDR0YWFXbm9ZOXEvYTlJVWY0K0hsbUJaSnRMcy9aODEwYmp1?=
 =?utf-8?B?d1FKSEszV1ZKbXpkSXV5Y2x5SVM3VmlvNFNLL2xYZjZZN0RSWnlWbVJ1ZFVL?=
 =?utf-8?B?RkRuUnBTQUhra3dPWXN3NFlVU1BNZVZlT3JwQ2FkcTRrUzhtYlh5M0lCcVUx?=
 =?utf-8?B?d0plNmdBOFVrVitaT2MxN1VYRFZtVlhmTjd4YWpETTc5d0VCL1lzYms1M3R4?=
 =?utf-8?B?VEFiTjNFa0hGQzlDQkI5YXF0QVJnS280cG1nV2xXWEdjeHBmZnRjWnBJNlZj?=
 =?utf-8?B?aURrOGlnRFUzZU9TTERWanRJZzM1cDJlS0VFTG9LY09qVEcxTS9SK0RWUlFy?=
 =?utf-8?B?YTlVVWcyL2xOWFd5V3hQT2VBUzZtTHlpREcwZzlXSTkybTZ2WGFoZjFlaDFv?=
 =?utf-8?B?V2hRcXhHdDBKWGQ1SGdwRllWVVJSS2o3M1lHMzYzZjAwQjRjem5ZNmhpOVBa?=
 =?utf-8?B?dWlqL2ZFVFhTUnF4dUNjbzVhSWNEalRhN1N4aG8yS2k5U29rdlZ3NXJ1NFdI?=
 =?utf-8?B?enJOOVNUcmlocmVrbmhkYU80dlNZTTZNTTNzVnR4QzhocE5JeUhidXJzaWY0?=
 =?utf-8?B?eVJjVXVQa2M2cHZkQW1NVksyZWJ4Z253dUFYdVNka01KUVE1S2ZUZnE1N0Zh?=
 =?utf-8?B?ajhmc1I2ZWZRai9DcC9zMm1XeHNXTzFzbWM0QWMyb0RZQUx5Y0lNbmQ4NzUw?=
 =?utf-8?B?M1VObEczSWhIZy9DcWpjYXAvSFpCcDJjNnpYam9rNnJrR2t3ZzFkUUlhRVFh?=
 =?utf-8?B?bCtiS29qOTVSMDRsZFdybEh6NVphV3VHY0VwUWxsZmVnVmsrNFFaWTl5QXpz?=
 =?utf-8?B?ZSsyRUtxSDZLQlRNMVhjRjgzaEJIbXR6TUdzZ3FSSWlvWk9NWlp0THRKVG9I?=
 =?utf-8?B?L1Vhc0JBb0pHeXd2R2JSZEU5amVOZU5aNnpEd3BDcEc5dzMxbnM1eTA2dFRt?=
 =?utf-8?B?SUZLbUFJaTVoWlc2aVRVSEtJNXJ3K1lmNFpYeUYrbndUNCtkUGJ3VTBIeklH?=
 =?utf-8?B?bTNieHF4QjZlNlZxY3BOdU40MGQ3bUY3SzZoY1FSbXpKaGdTbnJRakpWeDdQ?=
 =?utf-8?B?UVg0bnh3b2ZUaGJsL3RRYmhiNC9qRlR4TDU4NFRKVC9rMmFLL242MXpzZFNW?=
 =?utf-8?B?OWhTU1RpdkJHR3gwaEpadk1MSnZjVnN2dVNDQVA4Z1kvelc1czNrdVdLZFBk?=
 =?utf-8?B?TnRDVWpvTlVwSGZuR2ZhWnpVMHZKVzZsMHpuenBsbnBqZFlaSGQveVdaa0lV?=
 =?utf-8?B?enJLdDRRaHh0V3EyN0JGMlFld1Y0K2NkN2xmSHZoK0gxcWU2dEFocCszeE9K?=
 =?utf-8?B?MmlIaXYxYnB1dUZxVWZvK0xnOE9rbmlibVFzSmh0ekVGNSszQm1GdXhPMjl0?=
 =?utf-8?B?VTJvUy9uQXllc3BscTVmNEpxUWdLZzJNNzdmTjFnQ0V3enJGOVlRRHZDanBT?=
 =?utf-8?B?cEVhbFIrMFh3Um1YSWNNTlpScFducEN6UnFwWEtPeWxFUUhrTm8rdjAvdks5?=
 =?utf-8?B?Si9MU0VkbUI2TWw5ZFV4NmR4SSthRndmMmlOVnh3WHZmYlN4ZlQ2UHRlUFZs?=
 =?utf-8?B?cCtzYzR0ZVRzL3VBL2JSSnAwOWJYR0RQZ1dTaFhZb0JpdW42bUlIL2xPVXdo?=
 =?utf-8?B?OFNhdkNXYVprNnhMN0VlRUtuRGNtZDZGQzkxVGpXS2xneWJldXRYbGMrdm5K?=
 =?utf-8?B?aEllT2RlWHFHdjJMOUc3T3o2WllVSm9na0p4ZVlSWVZSTjd5OGYycnNaVHZN?=
 =?utf-8?B?OXArSUpXVXBEU3M0M2cxbklZSHRIenZaYkU0VFZuZTM3Q05ZVzFDVGZOS0tl?=
 =?utf-8?B?MXlSeGhzdXlOdzFSbkJ2WCs2U2lkdDVSZHJYTW1ScUVxNFE3enZ6aGtqUUZL?=
 =?utf-8?B?RmxkUUZJMU92L0hENFNZc0srcGN3OVR6WEtIUzl2ZzFMNU1GWXhJMzVQdTRM?=
 =?utf-8?B?QTM3NnpUU3dYdU9ZQisxSHp6VWdSZlBldHY2cDJmQ2xsRmdPeHVta0hjQUpN?=
 =?utf-8?B?alZEZmFoK2hUejBNbTE1dVQ2ZVJGYnRVMm5nVzdpRkFKTVJ3Q1U1R3IxMWF0?=
 =?utf-8?B?N0w0YjM1MEdsV2VSZmR1T3ZyUEFRMU9KVndvVHZRTmQrMEQvdHM0dmhvelFN?=
 =?utf-8?Q?rkjk6Wl6fuztJajC3BKrc79rA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cd4112-1d39-4e91-725a-08dce7e52309
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:04:10.3009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pP5taKHmfivZ9rZTze+ShTrwPNn9jHDJcT3GU1AQaItzdqFw81Zz1TxTUx86q1AYl9odOZ+zIj9eOyVC/OixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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


On 2024-10-08 03:03, Lazar, Lijo wrote:
>
> On 10/7/2024 8:54 PM, Alex Deucher wrote:
>> On Mon, Oct 7, 2024 at 10:32 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>
>>>
>>> On 10/7/2024 7:47 PM, Alex Deucher wrote:
>>>> On Mon, Oct 7, 2024 at 9:58 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>>
>>>>>
>>>>> On 10/7/2024 7:03 PM, Boyuan Zhang wrote:
>>>>>> On 2024-10-07 01:22, Lazar, Lijo wrote:
>>>>>>> On 10/5/2024 12:14 AM, boyuan.zhang@amd.com wrote:
>>>>>>>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>>>>>>>
>>>>>>>> For vcn 2_5, add ip_block for each vcn instance during discovery stage.
>>>>>>>>
>>>>>>>> And only powering on/off one of the vcn instance using the
>>>>>>>> instance value stored in ip_block, instead of powering on/off all
>>>>>>>> vcn instances. Modify the existing functions to use the instance value
>>>>>>>> in ip_block, and remove the original for loop for all vcn instances.
>>>>>>>>
>>>>>>>> v2: rename "i"/"j" to "inst" for instance value.
>>>>>>>>
>>>>>>>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 565 +++++++++---------
>>>>>>>>    2 files changed, 280 insertions(+), 289 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>>>> index 9f9a1867da72..de1053cc2a2b 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>>>> @@ -2278,6 +2278,7 @@ static int
>>>>>>>> amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>>>>>>>>      static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device
>>>>>>>> *adev)
>>>>>>>>    {
>>>>>>>> +    int i;
>>>>>>>>        if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
>>>>>>>>            switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
>>>>>>>>            case IP_VERSION(7, 0, 0):
>>>>>>>> @@ -2321,7 +2322,8 @@ static int
>>>>>>>> amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>>>>>>>>            case IP_VERSION(2, 0, 3):
>>>>>>>>                break;
>>>>>>>>            case IP_VERSION(2, 5, 0):
>>>>>>>> -            amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>>>>>>>> +            for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>>>>>>>> +                amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>>>>>>> This introduces a totally confusing design now. At a higher level an IP
>>>>>>> block type manages multiple instances and their power states. Now there
>>>>>>> is a mix where no definition can be attributed to an IP block. Or, if
>>>>>>> this were to be done uniformly for other IPs, then for some SOCs there
>>>>>>> could be 16 SDMA blocks, 8 GFX blocks and so forth.
>>>>>>>
>>>>>>> What is the reason to do this way? Can't VCN IP block maintain the state
>>>>>>> of multiple instances within itself?
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>> This is part of the fundamental design change for separating IP block
>>>>>> per instance, in order to
>>>>>> handle each instance separately within same IP block (e.g. separate
>>>>>> power/clock management).
>>>>>>
>>>>>> Part 1, Change all adev ptr handle to amdgpu_ip_block ptr in all
>>>>>> callbacks (hw_init/fini, sw_init/fini,
>>>>>> suspend, etc...) for all IP blocks, so that each IP knows which IP_block
>>>>>> (and which instance) the
>>>>>> callback is for. Most parts of this changes have been submitted by Sunil.
>>>>>>
>>>>>> Part 2, Separate IP block per instance.
>>>>>>
>>>>>> Part 3, Since callbacks can pass in IP_block now after Part 1 change and
>>>>>> instance value can be
>>>>>> obtained from each IP block in Part 2, IP can then choose to handle
>>>>>> callbacks ONLY for the given
>>>>>> instance of a given IP block (or still handling for all instances as
>>>>>> before).
>>>>>> For VCN, all callbacks will be handled only for the given one instance,
>>>>>> instead of the original for-
>>>>>> loop for all instance. As a result, each VCN instance can be
>>>>>> start/stop/int/fini/suspend separately.
>>>>>>
>>>>>> Part 4, Change all VCN helper functions to handle only the given
>>>>>> instance, instead of the original
>>>>>> for-loop for all instance.
>>>>>>
>>>>>> Each instance can have its own states, so we think it makes more sense
>>>>>> to separate them on IP
>>>>>> block level to handle each of them separately.
>>>>>
>>>>> Such a change should not be done unless all IPs follow the same design.
>>>>> You didn't answer the question - what necessitates this change? What is
>>>>> special about VCN that it cannot manage the states of multiple instances
>>>>> within the IP block?
>>>> We want to be able to manage the powergating independently for each
>>>> VCN instance for both power management and VCN reset.  Right now power
>>>> gating is handled at the IP level so it's not easy or clean to handle
>>>> powergating of individual IP instances.
>>>>
>>> Still VCN block can manage the powergated instances (FWIW, it's just an
>>> array in SMU block). Also vcn block gets to run the idle worker and
>>> knows the rings (and corresponding VCN instances) that are idle.
>>> Maintaining instance states in VCN block and modifying idle worker to
>>> just idle that instance alone doesn't look like a complex change.
>>
>> We already went down that road and it's really ugly.  We end up
>> duplicating a bunch of code paths for different driver flows because
>> set_powergating_state() and set_clockgating_state are at the IP level
>> and we want per instance gating.  We could add a num_instances member
>> at the IP block level and then convert all of the high level code that
>> calls the IP functions loop over the number of instances, but that
>> seems like just as much work and it's not quite as clean IMHO.
>>
> Sorry, I'm not seeing much difference in this design. All it does is
> just split instances to IP block at the same time it's going to keep an
> instance parameter in IP block APIs.
>
> 	amdgpu_device_ip_set_clockgating_state(blocktype, instance);
> 	amdgpu_device_ip_set_powergating_state(blocktype, instance);
>
> Also, VCN continues to maintain an array of amdgpu_vcn_inst. I think
> it's easier manage this with changes to amdgpu_vcn_inst. Since it is
> continued to be maintained, what about just moving the states and
> idle_work inside amdgpu_vcn_inst.
> 	
> 	int inst;
> 	enum amd_powergating_state cur_pg_state;
> 	enum amd_clockgating_state state cur_cg_state;
> 	struct delayed_work     idle_work;
>
> At the end of ring usage of corresponding instance, just invoke the
> corresponding instance's idle work.
>
> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
> idle_time_out);
First of all, separating idle work and state is still needed in current 
design.
Separating idle work by instance is already handled in patch 17/18.
Separating power gating state is already handled in patch 10/18.

I agree that "adding instance variable" in amdgpu_vcn_inst requires
much less effort, but as mentioned by Alex previously, we already
went down that way to use "inst" variable in amdgou_vcn_inst as you
listed above and track this instance value all the way from VCN to SMU.
However, this is a no-go based on discussions with Christian and Alex.
Since set_powergating_state() is at IP level, it will be clean to do
per instance gating at IP level. With the change of passing ip_block to
callback functions, all ip functions can now choose to handle only the
given instance, which is a clean separation between multiple instance.


>
> I don't see any change in this series for other IP block APIs.
Yes, currently we only do this per instance IP block for VCN. For long term,
the plan is to change all other IP with multiple blocks into this design.

Regards,
Boyuan


>
> Thanks,
> Lijo
>
>> Alex
>>
>>> Moving to IP block per instance for VCN alone is not a change that helps
>>> to define an IP block. If that needs to be done for every other IP type,
>>> that's also a massive change.
>>>
>>> Also, then it's no longer possible to have something static like this -
>>>          struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
>>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Alex
>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Thanks,
>>>>>> Boyuan
>>>>>>>>                amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
>>>>>>>>                break;
>>>>>>>>            case IP_VERSION(2, 6, 0):
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>>>>> index d00df51bc400..1f8738ae360a 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>>>>> @@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct
>>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>>    static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>>>>    {
>>>>>>>>        struct amdgpu_ring *ring;
>>>>>>>> -    int i, j, r;
>>>>>>>> +    int i, r;
>>>>>>>>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>>>>>>>>        uint32_t *ptr;
>>>>>>>>        struct amdgpu_device *adev = ip_block->adev;
>>>>>>>> +    int inst = ip_block->instance;
>>>>>>>>    -    for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>>>>>>>> -        if (adev->vcn.harvest_config & (1 << j))
>>>>>>>> -            continue;
>>>>>>>> -        /* VCN DEC TRAP */
>>>>>>>> -        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>>>>>>> -                VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
>>>>>>>> &adev->vcn.inst[j].irq);
>>>>>>>> -        if (r)
>>>>>>>> -            return r;
>>>>>>>> -
>>>>>>>> -        /* VCN ENC TRAP */
>>>>>>>> -        for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>>>>> -            r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>>>>>>> -                i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>>>>>>> &adev->vcn.inst[j].irq);
>>>>>>>> -            if (r)
>>>>>>>> -                return r;
>>>>>>>> -        }
>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>> +        goto sw_init;
>>>>>>>> +    /* VCN DEC TRAP */
>>>>>>>> +    r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>>>>>> +            VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
>>>>>>>> &adev->vcn.inst[inst].irq);
>>>>>>>> +    if (r)
>>>>>>>> +        return r;
>>>>>>>>    -        /* VCN POISON TRAP */
>>>>>>>> -        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>>>>>>> -            VCN_2_6__SRCID_UVD_POISON,
>>>>>>>> &adev->vcn.inst[j].ras_poison_irq);
>>>>>>>> +    /* VCN ENC TRAP */
>>>>>>>> +    for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>>>>> +        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>>>>>> +            i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>>>>>>> &adev->vcn.inst[inst].irq);
>>>>>>>>            if (r)
>>>>>>>>                return r;
>>>>>>>>        }
>>>>>>>>    +    /* VCN POISON TRAP */
>>>>>>>> +    r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>>>>>> +        VCN_2_6__SRCID_UVD_POISON,
>>>>>>>> &adev->vcn.inst[inst].ras_poison_irq);
>>>>>>>> +    if (r)
>>>>>>>> +        return r;
>>>>>>>> +sw_init:
>>>>>>>>        r = amdgpu_vcn_sw_init(adev);
>>>>>>>>        if (r)
>>>>>>>>            return r;
>>>>>>>> @@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct
>>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>>        if (r)
>>>>>>>>            return r;
>>>>>>>>    -    for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>>>>>>>> -        volatile struct amdgpu_fw_shared *fw_shared;
>>>>>>>> +    volatile struct amdgpu_fw_shared *fw_shared;
>>>>>>>>    -        if (adev->vcn.harvest_config & (1 << j))
>>>>>>>> -            continue;
>>>>>>>> -        adev->vcn.internal.context_id =
>>>>>>>> mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.internal.ib_vmid =
>>>>>>>> mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.internal.ib_bar_low =
>>>>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.internal.ib_bar_high =
>>>>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.internal.gp_scratch8 =
>>>>>>>> mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>>>>>>>> -
>>>>>>>> -        adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN,
>>>>>>>> j, mmUVD_SCRATCH9);
>>>>>>>> -        adev->vcn.internal.data0 =
>>>>>>>> mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j,
>>>>>>>> mmUVD_GPCOM_VCPU_DATA0);
>>>>>>>> -        adev->vcn.internal.data1 =
>>>>>>>> mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j,
>>>>>>>> mmUVD_GPCOM_VCPU_DATA1);
>>>>>>>> -        adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j,
>>>>>>>> mmUVD_GPCOM_VCPU_CMD);
>>>>>>>> -        adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>>>>>>>> -        adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j,
>>>>>>>> mmUVD_NO_OP);
>>>>>>>> -
>>>>>>>> -        ring = &adev->vcn.inst[j].ring_dec;
>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>> +        goto done;
>>>>>>>> +    adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.internal.ib_bar_low =
>>>>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.internal.ib_bar_high =
>>>>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>>>>>>>> +
>>>>>>>> +    adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN,
>>>>>>>> inst, mmUVD_SCRATCH9);
>>>>>>>> +    adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN,
>>>>>>>> inst, mmUVD_GPCOM_VCPU_DATA0);
>>>>>>>> +    adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN,
>>>>>>>> inst, mmUVD_GPCOM_VCPU_DATA1);
>>>>>>>> +    adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst,
>>>>>>>> mmUVD_GPCOM_VCPU_CMD);
>>>>>>>> +    adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>>>>>>>> +    adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst,
>>>>>>>> mmUVD_NO_OP);
>>>>>>>> +
>>>>>>>> +    ring = &adev->vcn.inst[inst].ring_dec;
>>>>>>>> +    ring->use_doorbell = true;
>>>>>>>> +
>>>>>>>> +    ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 <<
>>>>>>>> 1) +
>>>>>>>> +            (amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
>>>>>>>> +
>>>>>>>> +    if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2, 5, 0))
>>>>>>>> +        ring->vm_hub = AMDGPU_MMHUB1(0);
>>>>>>>> +    else
>>>>>>>> +        ring->vm_hub = AMDGPU_MMHUB0(0);
>>>>>>>> +
>>>>>>>> +    sprintf(ring->name, "vcn_dec_%d", inst);
>>>>>>>> +    r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq,
>>>>>>>> +                 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>>>>>> +    if (r)
>>>>>>>> +        return r;
>>>>>>>> +
>>>>>>>> +    for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>>>>> +        enum amdgpu_ring_priority_level hw_prio =
>>>>>>>> amdgpu_vcn_get_enc_ring_prio(i);
>>>>>>>> +
>>>>>>>> +        ring = &adev->vcn.inst[inst].ring_enc[i];
>>>>>>>>            ring->use_doorbell = true;
>>>>>>>>              ring->doorbell_index =
>>>>>>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>>>>>>>> -                (amdgpu_sriov_vf(adev) ? 2*j : 8*j);
>>>>>>>> +                (amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2 + i +
>>>>>>>> 8*inst));
>>>>>>>>    -        if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2,
>>>>>>>> 5, 0))
>>>>>>>> +        if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>>>>>>>> +            IP_VERSION(2, 5, 0))
>>>>>>>>                ring->vm_hub = AMDGPU_MMHUB1(0);
>>>>>>>>            else
>>>>>>>>                ring->vm_hub = AMDGPU_MMHUB0(0);
>>>>>>>>    -        sprintf(ring->name, "vcn_dec_%d", j);
>>>>>>>> -        r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[j].irq,
>>>>>>>> -                     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>>>>>> +        sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
>>>>>>>> +        r = amdgpu_ring_init(adev, ring, 512,
>>>>>>>> +                     &adev->vcn.inst[inst].irq, 0,
>>>>>>>> +                     hw_prio, NULL);
>>>>>>>>            if (r)
>>>>>>>>                return r;
>>>>>>>> -
>>>>>>>> -        for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>>>>> -            enum amdgpu_ring_priority_level hw_prio =
>>>>>>>> amdgpu_vcn_get_enc_ring_prio(i);
>>>>>>>> -
>>>>>>>> -            ring = &adev->vcn.inst[j].ring_enc[i];
>>>>>>>> -            ring->use_doorbell = true;
>>>>>>>> -
>>>>>>>> -            ring->doorbell_index =
>>>>>>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>>>>>>>> -                    (amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i
>>>>>>>> + 8*j));
>>>>>>>> -
>>>>>>>> -            if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>>>>>>>> -                IP_VERSION(2, 5, 0))
>>>>>>>> -                ring->vm_hub = AMDGPU_MMHUB1(0);
>>>>>>>> -            else
>>>>>>>> -                ring->vm_hub = AMDGPU_MMHUB0(0);
>>>>>>>> -
>>>>>>>> -            sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>>>>>>>> -            r = amdgpu_ring_init(adev, ring, 512,
>>>>>>>> -                         &adev->vcn.inst[j].irq, 0,
>>>>>>>> -                         hw_prio, NULL);
>>>>>>>> -            if (r)
>>>>>>>> -                return r;
>>>>>>>> -        }
>>>>>>>> -
>>>>>>>> -        fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
>>>>>>>> -        fw_shared->present_flag_0 =
>>>>>>>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>>>>>>>> -
>>>>>>>> -        if (amdgpu_vcnfw_log)
>>>>>>>> -            amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>>>>>>>        }
>>>>>>>>    +    fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
>>>>>>>> +    fw_shared->present_flag_0 =
>>>>>>>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>>>>>>>> +
>>>>>>>> +    if (amdgpu_vcnfw_log)
>>>>>>>> +        amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>>>>>>> +done:
>>>>>>>>        if (amdgpu_sriov_vf(adev)) {
>>>>>>>>            r = amdgpu_virt_alloc_mm_table(adev);
>>>>>>>>            if (r)
>>>>>>>> @@ -1005,197 +1002,192 @@ static int vcn_v2_5_start_dpg_mode(struct
>>>>>>>> amdgpu_device *adev, int inst_idx, boo
>>>>>>>>        return 0;
>>>>>>>>    }
>>>>>>>>    -static int vcn_v2_5_start(struct amdgpu_device *adev)
>>>>>>>> +static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned int
>>>>>>>> inst)
>>>>>>>>    {
>>>>>>>>        struct amdgpu_ring *ring;
>>>>>>>>        uint32_t rb_bufsz, tmp;
>>>>>>>> -    int i, j, k, r;
>>>>>>>> +    int j, k, r;
>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>> -        if (adev->pm.dpm_enabled)
>>>>>>>> -            amdgpu_dpm_enable_vcn(adev, true, i);
>>>>>>>> -    }
>>>>>>>> -
>>>>>>>> -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>>>>> -            continue;
>>>>>>>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>>>>> -            r = vcn_v2_5_start_dpg_mode(adev, i,
>>>>>>>> adev->vcn.indirect_sram);
>>>>>>>> -            continue;
>>>>>>>> -        }
>>>>>>>> +    if (adev->pm.dpm_enabled)
>>>>>>>> +        amdgpu_dpm_enable_vcn(adev, true, inst);
>>>>>>>>    -        /* disable register anti-hang mechanism */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
>>>>>>>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>> +        return 0;
>>>>>>>>    -        /* set uvd status busy */
>>>>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) |
>>>>>>>> UVD_STATUS__UVD_BUSY;
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>>>>>>>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>>>>> +        r = vcn_v2_5_start_dpg_mode(adev, inst,
>>>>>>>> adev->vcn.indirect_sram);
>>>>>>>> +        return r;
>>>>>>>>        }
>>>>>>>>    +    /* disable register anti-hang mechanism */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
>>>>>>>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>>>>> +
>>>>>>>> +    /* set uvd status busy */
>>>>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
>>>>>>>> +
>>>>>>>>        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>>>>>>>            return 0;
>>>>>>>>          /*SW clock gating */
>>>>>>>>        vcn_v2_5_disable_clock_gating(adev);
>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>>>>> -            continue;
>>>>>>>> -        /* enable VCPU clock */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>>>>>>> -            UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>>>>>>>> -
>>>>>>>> -        /* disable master interrupt */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
>>>>>>>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>>>>> -
>>>>>>>> -        /* setup mmUVD_LMI_CTRL */
>>>>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
>>>>>>>> -        tmp &= ~0xff;
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
>>>>>>>> -            UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
>>>>>>>> -            UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>>>>>>>> -            UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>>>>>>>> -            UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>>>>>>>> -
>>>>>>>> -        /* setup mmUVD_MPC_CNTL */
>>>>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
>>>>>>>> -        tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>>>>>>>> -        tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
>>>>>>>> -
>>>>>>>> -        /* setup UVD_MPC_SET_MUXA0 */
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
>>>>>>>> -            ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>>>>>>>> -            (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>>>>>>>> -            (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>>>>>>>> -            (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>>>>>>>> -
>>>>>>>> -        /* setup UVD_MPC_SET_MUXB0 */
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
>>>>>>>> -            ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>>>>>>>> -            (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>>>>>>>> -            (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>>>>>>>> -            (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>>>>>>>> -
>>>>>>>> -        /* setup mmUVD_MPC_SET_MUX */
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
>>>>>>>> -            ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>>>>>>>> -            (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>>>>>>>> -            (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>>>>>>> -    }
>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    /* enable VCPU clock */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>>>>>>> +        UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>>>>>>>> +
>>>>>>>> +    /* disable master interrupt */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
>>>>>>>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>>>>> +
>>>>>>>> +    /* setup mmUVD_LMI_CTRL */
>>>>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
>>>>>>>> +    tmp &= ~0xff;
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
>>>>>>>> +        UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
>>>>>>>> +        UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>>>>>>>> +        UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>>>>>>>> +        UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>>>>>>>> +
>>>>>>>> +    /* setup mmUVD_MPC_CNTL */
>>>>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
>>>>>>>> +    tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>>>>>>>> +    tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
>>>>>>>> +
>>>>>>>> +    /* setup UVD_MPC_SET_MUXA0 */
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
>>>>>>>> +        ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>>>>>>>> +        (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>>>>>>>> +        (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>>>>>>>> +        (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>>>>>>>> +
>>>>>>>> +    /* setup UVD_MPC_SET_MUXB0 */
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
>>>>>>>> +        ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>>>>>>>> +        (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>>>>>>>> +        (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>>>>>>>> +        (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>>>>>>>> +
>>>>>>>> +    /* setup mmUVD_MPC_SET_MUX */
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
>>>>>>>> +        ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>>>>>>>> +        (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>>>>>>>> +        (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>>>>>>>          vcn_v2_5_mc_resume(adev);
>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>> -        volatile struct amdgpu_fw_shared *fw_shared =
>>>>>>>> adev->vcn.inst[i].fw_shared.cpu_addr;
>>>>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>>>>> -            continue;
>>>>>>>> -        /* VCN global tiling registers */
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>>>>>>>> -            adev->gfx.config.gb_addr_config);
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>>>>>>>> -            adev->gfx.config.gb_addr_config);
>>>>>>>> +    volatile struct amdgpu_fw_shared *fw_shared =
>>>>>>>> adev->vcn.inst[inst].fw_shared.cpu_addr;
>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>> +        return 0;
>>>>>>>> +
>>>>>>>> +    /* VCN global tiling registers */
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>>>>>>>> +        adev->gfx.config.gb_addr_config);
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>>>>>>>> +        adev->gfx.config.gb_addr_config);
>>>>>>>>    -        /* enable LMI MC and UMC channels */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
>>>>>>>> -            ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>>>>>>> +    /* enable LMI MC and UMC channels */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
>>>>>>>> +        ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>>>>>>>    -        /* unblock VCPU register access */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
>>>>>>>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>>>> +    /* unblock VCPU register access */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
>>>>>>>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>>>>    -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>>>>>>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>>>>>>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>    -        for (k = 0; k < 10; ++k) {
>>>>>>>> -            uint32_t status;
>>>>>>>> -
>>>>>>>> -            for (j = 0; j < 100; ++j) {
>>>>>>>> -                status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
>>>>>>>> -                if (status & 2)
>>>>>>>> -                    break;
>>>>>>>> -                if (amdgpu_emu_mode == 1)
>>>>>>>> -                    msleep(500);
>>>>>>>> -                else
>>>>>>>> -                    mdelay(10);
>>>>>>>> -            }
>>>>>>>> -            r = 0;
>>>>>>>> +    for (k = 0; k < 10; ++k) {
>>>>>>>> +        uint32_t status;
>>>>>>>> +
>>>>>>>> +        for (j = 0; j < 100; ++j) {
>>>>>>>> +            status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
>>>>>>>>                if (status & 2)
>>>>>>>>                    break;
>>>>>>>> +            if (amdgpu_emu_mode == 1)
>>>>>>>> +                msleep(500);
>>>>>>>> +            else
>>>>>>>> +                mdelay(10);
>>>>>>>> +        }
>>>>>>>> +        r = 0;
>>>>>>>> +        if (status & 2)
>>>>>>>> +            break;
>>>>>>>>    -            DRM_ERROR("VCN decode not responding, trying to reset
>>>>>>>> the VCPU!!!\n");
>>>>>>>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>>>>>>> -                UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>>>>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>> -            mdelay(10);
>>>>>>>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>>>>>>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>> +        DRM_ERROR("VCN decode not responding, trying to reset the
>>>>>>>> VCPU!!!\n");
>>>>>>>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>>>>>>> +            UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>>>>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>> +        mdelay(10);
>>>>>>>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>>>>>>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>    -            mdelay(10);
>>>>>>>> -            r = -1;
>>>>>>>> -        }
>>>>>>>> +        mdelay(10);
>>>>>>>> +        r = -1;
>>>>>>>> +    }
>>>>>>>>    -        if (r) {
>>>>>>>> -            DRM_ERROR("VCN decode not responding, giving up!!!\n");
>>>>>>>> -            return r;
>>>>>>>> -        }
>>>>>>>> +    if (r) {
>>>>>>>> +        DRM_ERROR("VCN decode not responding, giving up!!!\n");
>>>>>>>> +        return r;
>>>>>>>> +    }
>>>>>>>>    -        /* enable master interrupt */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
>>>>>>>> -            UVD_MASTINT_EN__VCPU_EN_MASK,
>>>>>>>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>>>>> +    /* enable master interrupt */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
>>>>>>>> +        UVD_MASTINT_EN__VCPU_EN_MASK,
>>>>>>>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>>>>>    -        /* clear the busy bit of VCN_STATUS */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
>>>>>>>> -            ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>>>>>>> +    /* clear the busy bit of VCN_STATUS */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
>>>>>>>> +        ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>>>>>>>    -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
>>>>>>>>    -        ring = &adev->vcn.inst[i].ring_dec;
>>>>>>>> -        /* force RBC into idle state */
>>>>>>>> -        rb_bufsz = order_base_2(ring->ring_size);
>>>>>>>> -        tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>>>>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>>>>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>>>>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>>>>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>>>>>>>> +    ring = &adev->vcn.inst[inst].ring_dec;
>>>>>>>> +    /* force RBC into idle state */
>>>>>>>> +    rb_bufsz = order_base_2(ring->ring_size);
>>>>>>>> +    tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>>>>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
>>>>>>>>    -        fw_shared->multi_queue.decode_queue_mode |=
>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>> -        /* program the RB_BASE for ring buffer */
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>>>>>>>> -            lower_32_bits(ring->gpu_addr));
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>>>>>>>> -            upper_32_bits(ring->gpu_addr));
>>>>>>>> +    fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
>>>>>>>> +    /* program the RB_BASE for ring buffer */
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>>>>>>>> +        lower_32_bits(ring->gpu_addr));
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>>>>>>>> +        upper_32_bits(ring->gpu_addr));
>>>>>>>>    -        /* Initialize the ring buffer's read and write pointers */
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>>>>>>>> +    /* Initialize the ring buffer's read and write pointers */
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
>>>>>>>>    -        ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
>>>>>>>> -                lower_32_bits(ring->wptr));
>>>>>>>> -        fw_shared->multi_queue.decode_queue_mode &=
>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>> +    ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
>>>>>>>> +            lower_32_bits(ring->wptr));
>>>>>>>> +    fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>>>>>>>>    -        fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>> -        ring = &adev->vcn.inst[i].ring_enc[0];
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI,
>>>>>>>> upper_32_bits(ring->gpu_addr));
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
>>>>>>>> -        fw_shared->multi_queue.encode_generalpurpose_queue_mode &=
>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>> -
>>>>>>>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode |=
>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>> -        ring = &adev->vcn.inst[i].ring_enc[1];
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2,
>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2,
>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2,
>>>>>>>> upper_32_bits(ring->gpu_addr));
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
>>>>>>>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode &=
>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>> -    }
>>>>>>>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>> +    ring = &adev->vcn.inst[inst].ring_enc[0];
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI,
>>>>>>>> upper_32_bits(ring->gpu_addr));
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
>>>>>>>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode &=
>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>> +
>>>>>>>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode |=
>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>> +    ring = &adev->vcn.inst[inst].ring_enc[1];
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2,
>>>>>>>> upper_32_bits(ring->gpu_addr));
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
>>>>>>>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode &=
>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>>          return 0;
>>>>>>>>    }
>>>>>>>> @@ -1424,72 +1416,69 @@ static int vcn_v2_5_stop_dpg_mode(struct
>>>>>>>> amdgpu_device *adev, int inst_idx)
>>>>>>>>        return 0;
>>>>>>>>    }
>>>>>>>>    -static int vcn_v2_5_stop(struct amdgpu_device *adev)
>>>>>>>> +static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned int inst)
>>>>>>>>    {
>>>>>>>>        uint32_t tmp;
>>>>>>>> -    int i, r = 0;
>>>>>>>> +    int r = 0;
>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>>>>> -            continue;
>>>>>>>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>>>>> -            r = vcn_v2_5_stop_dpg_mode(adev, i);
>>>>>>>> -            continue;
>>>>>>>> -        }
>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>> +        goto done;
>>>>>>>>    -        /* wait for vcn idle */
>>>>>>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS,
>>>>>>>> UVD_STATUS__IDLE, 0x7);
>>>>>>>> -        if (r)
>>>>>>>> -            return r;
>>>>>>>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>>>>> +        r = vcn_v2_5_stop_dpg_mode(adev, inst);
>>>>>>>> +        goto done;
>>>>>>>> +    }
>>>>>>>>    -        tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>>>>>>>> -            UVD_LMI_STATUS__READ_CLEAN_MASK |
>>>>>>>> -            UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>>>>>>>> -            UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>>>>>>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>>>>>>>> -        if (r)
>>>>>>>> -            return r;
>>>>>>>> +    /* wait for vcn idle */
>>>>>>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS,
>>>>>>>> UVD_STATUS__IDLE, 0x7);
>>>>>>>> +    if (r)
>>>>>>>> +        return r;
>>>>>>>>    -        /* block LMI UMC channel */
>>>>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
>>>>>>>> -        tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
>>>>>>>> +    tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>>>>>>>> +        UVD_LMI_STATUS__READ_CLEAN_MASK |
>>>>>>>> +        UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>>>>>>>> +        UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>>>>>>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>>>>>>>> +    if (r)
>>>>>>>> +        return r;
>>>>>>>>    -        tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>>>>>>>> -            UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>>>>>>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
>>>>>>>> -        if (r)
>>>>>>>> -            return r;
>>>>>>>> +    /* block LMI UMC channel */
>>>>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
>>>>>>>> +    tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
>>>>>>>>    -        /* block VCPU register access */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
>>>>>>>> -            UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>>>>>>>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>>>> +    tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>>>>>>>> +        UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>>>>>>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
>>>>>>>> +    if (r)
>>>>>>>> +        return r;
>>>>>>>>    -        /* reset VCPU */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>>>>>>> -            UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>>>>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>> +    /* block VCPU register access */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
>>>>>>>> +        UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>>>>>>>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>>>>    -        /* disable VCPU clock */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>>>>>>> -            ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>>>>>>> +    /* reset VCPU */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>>>>>>> +        UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>>>>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>    -        /* clear status */
>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>>>>>>>> +    /* disable VCPU clock */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>>>>>>> +        ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>>>>>>>    -        vcn_v2_5_enable_clock_gating(adev);
>>>>>>>> +    /* clear status */
>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
>>>>>>>>    -        /* enable register anti-hang mechanism */
>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
>>>>>>>> -            UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>>>>>>>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>>>>> -    }
>>>>>>>> +    vcn_v2_5_enable_clock_gating(adev);
>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>> -        if (adev->pm.dpm_enabled)
>>>>>>>> -            amdgpu_dpm_enable_vcn(adev, false, i);
>>>>>>>> -    }
>>>>>>>> +    /* enable register anti-hang mechanism */
>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
>>>>>>>> +        UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>>>>>>>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>>>>> +done:
>>>>>>>> +    if (adev->pm.dpm_enabled)
>>>>>>>> +        amdgpu_dpm_enable_vcn(adev, false, inst);
>>>>>>>>          return 0;
>>>>>>>>    }
>>>>>>>> @@ -1838,9 +1827,9 @@ static int
>>>>>>>> vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>>>>>>>            return 0;
>>>>>>>>          if (state == AMD_PG_STATE_GATE)
>>>>>>>> -        ret = vcn_v2_5_stop(adev);
>>>>>>>> +        ret = vcn_v2_5_stop(adev, inst);
>>>>>>>>        else
>>>>>>>> -        ret = vcn_v2_5_start(adev);
>>>>>>>> +        ret = vcn_v2_5_start(adev, inst);
>>>>>>>>          if (!ret)
>>>>>>>>            adev->vcn.cur_state[inst] = state;
