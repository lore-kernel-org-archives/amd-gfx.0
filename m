Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9EEC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 21:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E198689E1A;
	Mon,  6 Jul 2026 21:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p2s2iEGo";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92ED210E3F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 21:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ze96tT9z1adHsNASr8tCpX1uvuGmisFjHO4bNqdt6VC2mw5Mq1nHOmhhcIwzM8ojcJ37dsnOeSGmVWR12lUoZMNwWusW+5piL4Qwyzu+2yswZoQKzIph7UUE9sqCIR6BIvdLWyzFG38F7LUv3ttdvDPxN5ogH7uDKl39p8UkunQJ+WitOs3tz3ZC56gbLJrQQPWPX/gF8ifgasHExHB6y66oL6XJI1seDqLFjMxfUlNBUBThNSDfLEZ61Trrdq9BTXmct+CnzEFa2hVS3kYeObBw0bP9HSkRBOo59h8BEB29lOwEwuWuDYfX3GKhiTqx0PjldGZD8PsI2tL8Nc7Edg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV47wuwqB3WaDf9dMTCiN/IepAydzXwnPlhQdCDVmQY=;
 b=aQMBIyEJHL127zTcRlBZ/3GeI2sdie5wX82MWYw+dWDTJLAATrephG8uvcue4+XhOYFKZ8bGOINSMwG511xC9/YGdZAIQ46tcu4w9RHNsJHeYz/LnOydspTwGqHkmypzQBTT6J7Rr/rBrM06qkdRJySSmZ3qEtD1ZPQZf2qMJkVsqByRIP1ZLoJK5Thc+SaBEwfmztUqQUR7f+F815wBUsA31LdsA7EaGT2YD1vDzAgpnDPDH+UoX/dbs0NuC9g3S6VyOKzwr3EiOwIPp2JcPOSmFSCMm5FVVg/xTxaIiZUnzmICMXmkUDPbzfU9kmVAB/3gkirb05CbARlh9Afd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV47wuwqB3WaDf9dMTCiN/IepAydzXwnPlhQdCDVmQY=;
 b=p2s2iEGofaMEZy/d1kKPlwh9AvMrBNTMwFJlZ1DujZll2HPkdHDCdrWOHJaYxlq4G6gaZyk1wPWVpPabgK199b8cZVB5meEQOhlNiKhS+Q5Att4l0GpjX51uRNe9iuwzpgHvNCkvW4OrPz2bREYFogK4ckR25pFhzZkcUweuues=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 21:13:45 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 21:13:44 +0000
Content-Type: multipart/alternative;
 boundary="------------LijcY78hM3s0PwtzpRWfpYDK"
Message-ID: <7d8bd73a-a446-4c1c-8fde-b41948e081ad@amd.com>
Date: Mon, 6 Jul 2026 17:13:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: update mmhub 4.2.0 client list
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260618204550.753250-1-alexander.deucher@amd.com>
 <20260618204550.753250-2-alexander.deucher@amd.com>
 <CADnq5_PNXLwpcZCHF+q9ZLMgHwq5DWK=Z6BzR+VRGi9KPUE=9Q@mail.gmail.com>
 <CADnq5_M1A9b5D-L8U6cc5DXWOCSh8+neNuBvBrofJMGPkZV64w@mail.gmail.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <CADnq5_M1A9b5D-L8U6cc5DXWOCSh8+neNuBvBrofJMGPkZV64w@mail.gmail.com>
X-ClientProxiedBy: YQBPR0101CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::22) To BL3PR12MB6425.namprd12.prod.outlook.com
 (2603:10b6:208:3b4::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6425:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a353ef1-d5c9-475c-3820-08dedba3762b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|4143699003|11063799006|56012099006|8096899003;
X-Microsoft-Antispam-Message-Info: Az7rHcRcSao3KV9sHyi3LRUC/4TgK6FvGt3a+okNJbuq7S/hv7JEPYLMfh7M2seSRSyp3b54yOZIXQHL/qFwlIivUxozTYc5Lyv20WdMAWwru5WTX1+68u6ZOYvHzzYFgpY8wmIIfxhePZZC76hBK5HOK1ZIhnEUXkUYvonjK1dsL/j6USeXXB8w+3A2J/WdaLiLjfjgN8sUetZbXTQdRheq4/myss6zx4wRAeqEYAc340YL1MiCOHpnyQzArSTWStdoCoIak7hN7FdIa+FYY1yhpa/bgwVPSQkdSAZhIGXljwIIKqSCJt/LZLiGsU6YIE6aPrMvAPFfuphIU4LeMVWYPA2KObphWW/gxV6wtUXdJPMiDL/XUKb/AUty2tpEheBZGnpOotYbJzZMtC0KjwJno498ykyae4tnGxQhTWlhXRw+v1l9SIE116F6vWE6+qWHDpEm6eJ8FvA23g3ZqRao+J/jBAVIYU0LFUW/Zfts/JJPydqz7s72BWrDR3+tBIYreT1IgAgsRQ+X+SAIu+Miu0Q4cgtw9Wiv7fDNwc/v1+9BRmoQxo/wLi/WVjI1qHfFI0WgOpGJ/iRf1GUWVqOmdra74/uSfmC6zZYZt2GaEshm6ik9z+2nzuwvRMN/aVcvmedrhR+ti/oY9jcSI+CsHD15srtOzpWTaXdhaas=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z21hTFlvZDBzNi90WUdpRmo2Vm1IYzJTNlZWYlhwWG12bFlWb0Y2UTI5Yjcx?=
 =?utf-8?B?dUVJdVhLYk00VG5HWHZOcTlsSlQ0WVh6NkxGWVZ5TjZxVTQ0cjZwVTl4UUJC?=
 =?utf-8?B?U1hCYlFKMFV5SkFmRVU3SWtQSEI0Z1JMQ0hFQjkyazFleTl4WVQ3QTJrcWt5?=
 =?utf-8?B?L1kzZDBFSVFnZkphd3k4MUtKblFzQmpuRVR6d3B4bXdJNGtsckJqcmhxSGM3?=
 =?utf-8?B?TnowU1djblVLVjE2ODJ5UXB3QU95U2s5aU1IU1NYMlJVT1dzUFpYSFhtZ1hU?=
 =?utf-8?B?ZitiMFloZjY4aVpGZ1lvdi9ETVZBVlNaeGR2K3NGM0IwTXYweXBOTHo3ZE1F?=
 =?utf-8?B?M2RBWFF4TUJLZ0JUaDdxa1FXOEw1RlE5ckMwanVsc1ZnNHh4MjZpSzFFTVNa?=
 =?utf-8?B?WUp2TmNqMWpPUWErdVBVUUlLV3kzZzdCdkZyMUlTelNTNnpHQkhEa0h5ZW5E?=
 =?utf-8?B?eFlxd2FyMmtuMlRMclJYRkVhSXR3bjV4L3FtRlVCVVNXSDNjQlF3TUNYUXVa?=
 =?utf-8?B?dkhJZ1A3U042dHVVb1NVeHAwM3hhaSs3M3FpT2tubkVza09ycWRiMi9MY0E3?=
 =?utf-8?B?YjVTSUc4UXV2ckpWYUpNQXc0M2p3YUlBZVR2Ulk5NE82a2VBalV5bi83MXhu?=
 =?utf-8?B?WU1qTVRGL1k2S1RuRzdKTzltckRiYWtTTDZSdmhGSXIwclhsRWJlTFJqNEtm?=
 =?utf-8?B?TVRIejdhSEJwbFU4ZGF2b3M4dEVHS25SN3FwQWdmSTkyZHBSRnhZVGQzTGNX?=
 =?utf-8?B?MmpvcUh3bDN0d1V3MUhCK1Ftb0xlTFExZ1Jzc0FQWXJCcU50Y0NXSlZzL2R4?=
 =?utf-8?B?bkhJNXo2cEMzOFkzaFJaMmNYdS9hbHFSWld6RlhQUXczK0t4VWNyMW9FZXAw?=
 =?utf-8?B?ZVk3aCtXZTVYNmVUSVNZVXJpVGtTbFV1THF4MG4yZlA5VFY3dWREZytVQzdm?=
 =?utf-8?B?WEVjcGJXeW1ONjVadkI4cGU5T05aNytpaTlXNksydEZLK21GZkdKTXFaY0k1?=
 =?utf-8?B?MEZJRjZrall3UEFwa3Vsd2xiM3FCRU83eGQvVVpmdHJCZTJzRVJPamhjUGJa?=
 =?utf-8?B?QmcvOTlQZFI0WXJZSWMzdnlPVHp0YXRZaUlHdkNnNXBoYXd0STZLUjVuNlRY?=
 =?utf-8?B?TklOVU1iV2gyeW9VQW1xeEduSnBDTWVWc0h0OUxlZS90aGxUQ0l1WVJMbVRJ?=
 =?utf-8?B?VG1aWUQ4MGg1UnpRTTg4M281RzkrQWRmYUlILzF0QUxIbEVEeHRSSGRiVTd5?=
 =?utf-8?B?aTZWV3duVHpSZmZnM2FaY3pFTUZBSHF2TU5aSXFOdGtmTUpOUE5oSkZiS1Mz?=
 =?utf-8?B?WHkwTWl2MkF3YjZXM0IyZjVzSy9OVnNpRi9XRE55UXYyR1ZzR0dDTlFmVUR6?=
 =?utf-8?B?TnpTaUhsWFNESkdNSkk5REl0dEJmQlE2ZHFKWHVzdUxUc2JQTjN0V2RNV3lL?=
 =?utf-8?B?V2doNEJzYU85NlFwNmR6Z1JlT1FDWGFoazVlU1RUQWU2b1JFeWJZZHFQeTkz?=
 =?utf-8?B?WkxNY3c5b3VhbkhPQVhsb1ZIdm9ITytGcUtma0drZDNhRGNGT01jZkxaY1M4?=
 =?utf-8?B?UHczaVBJRlRkb2ZFOTFZTGk1ZzBmTzlpaENteWZZeHZ1dHZTYWVTWHlEMHJo?=
 =?utf-8?B?ZnhVY2hBKytFYjR0L1JXOVlmVFFUTE9rSVdsZmthSnk5Q3IwY0FFemd0WnFx?=
 =?utf-8?B?QVN4ckNTblpRKzBwaE5pcU9EcHpJSERKdDNmektPVi8yem0yay9UMVhjMHRs?=
 =?utf-8?B?eEkrT2V5YWNEYWxxazhNQ0FIMHY1Sk5ZSE1zZ092Y1hVQ0x5ODlvVnRUemdW?=
 =?utf-8?B?dXVINXQ2TDNmMkdCMDZMSE1BeVU4UkRkSC9YTmE1YUdsTnZ4bmhIWlVCSGoz?=
 =?utf-8?B?anBlRTJlYndJOEllMzJUZzBMWUxxemVZOEc0Uk9qbW5SWkw3MHZTYTBoRWhO?=
 =?utf-8?B?Tk10TVNYN25pRWovYVVWbFF4aUluOGl3VnJWR3NMcEtiVXE4blBqWDAzWWZX?=
 =?utf-8?B?RDFycGZ5bGF4ZjcySUxSQkRLUnFpQnJsUzg5YXVxMDJUcmdoblFYc253WWU5?=
 =?utf-8?B?QmFMOVFTekh2UFFnS3dscHJCSlc0NnRIb09yK3BmMnV5NEowL00zSk4rRmE1?=
 =?utf-8?B?MTRYZkxqM2xHcWM1WEVJYms5QU5YNlZSaHVwdnpobU8wdEFwSVlqc0drTGtu?=
 =?utf-8?B?NEhqd281UXhMODhpREZTdVUyUnBqUHFGTmFuU2dNWUlqS3pmOGp4UmxJUkww?=
 =?utf-8?B?WHZmbk8vL2xNSEh1bVY5L2tCbXgvUk1ZL3dtRU9MSHZqbEwxaWNBaWNxWXVB?=
 =?utf-8?B?RWg0Q080UkljVVdiVFhKWCtDVHdkVlFDRllXUlNZUExmZUVpcWlFQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a353ef1-d5c9-475c-3820-08dedba3762b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 21:13:44.6203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EcCcm+bZi4iUhAmYCb/LZ1BaM04QRE4Rp21I95GlJqY/kuqwdpVKnEikMe+/14arM63mLfLdwMmSko9seB5hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299
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

--------------LijcY78hM3s0PwtzpRWfpYDK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>


On 7/6/2026 11:01 AM, Alex Deucher wrote:
> Ping?
>
> On Mon, Jun 29, 2026 at 4:27 PM Alex Deucher<alexdeucher@gmail.com> wrote:
>> Ping?
>>
>> On Thu, Jun 18, 2026 at 4:54 PM Alex Deucher<alexander.deucher@amd.com> wrote:
>>> Update to the proper client list for mmhub 4.2.0.
>>>
>>> v2: fix typo (Alex)
>>>
>>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 65 ++++++++++++-----------
>>>   1 file changed, 33 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
>>> index 49b7f16a941f6..5827c758b373d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
>>> @@ -36,40 +36,41 @@
>>>
>>>   static const char *mmhub_client_ids_v4_2_0[][2] = {
>>>          [0][0] = "VMC",
>>> -       [4][0] = "DCEDMC",
>>> -       [5][0] = "DCEVGA",
>>> -       [6][0] = "MP0",
>>> -       [7][0] = "MP1",
>>> +       [2][0] = "MPNHT",
>>> +       [7][0] = "MPIFOE",
>>>          [8][0] = "MPIO",
>>> -       [16][0] = "HDP",
>>> -       [17][0] = "LSDMA",
>>> -       [18][0] = "JPEG",
>>> -       [19][0] = "VCNU0",
>>> -       [21][0] = "VSCH",
>>> -       [22][0] = "VCNU1",
>>> -       [23][0] = "VCN1",
>>> -       [32+20][0] = "VCN0",
>>> -       [2][1] = "DBGUNBIO",
>>> -       [3][1] = "DCEDWB",
>>> -       [4][1] = "DCEDMC",
>>> -       [5][1] = "DCEVGA",
>>> -       [6][1] = "MP0",
>>> -       [7][1] = "MP1",
>>> +       [11][0] = "JPEG0",
>>> +       [12][0] = "VCN0",
>>> +       [13][0] = "VCNU0",
>>> +       [14][0] = "VSCH0",
>>> +       [15][0] = "LSDMA",
>>> +       [32+5][0] = "MPRAS",
>>> +       [32+6][0] = "MP1",
>>> +       [32+7][0] = "MP0",
>>> +       [32+11][0] = "JPEG1",
>>> +       [32+12][0] = "VCN1",
>>> +       [32+13][0] = "VCNU1",
>>> +       [32+14][0] = "VSCH1",
>>> +       [2][1] = "MPNHT",
>>> +       [3][1] = "DBGU0",
>>> +       [7][1] = "MPIFOE",
>>>          [8][1] = "MPIO",
>>> -       [10][1] = "DBGU0",
>>> -       [11][1] = "DBGU1",
>>> -       [12][1] = "DBGU2",
>>> -       [13][1] = "DBGU3",
>>> -       [14][1] = "XDP",
>>> -       [15][1] = "OSSSYS",
>>> -       [16][1] = "HDP",
>>> -       [17][1] = "LSDMA",
>>> -       [18][1] = "JPEG",
>>> -       [19][1] = "VCNU0",
>>> -       [20][1] = "VCN0",
>>> -       [21][1] = "VSCH",
>>> -       [22][1] = "VCNU1",
>>> -       [23][1] = "VCN1",
>>> +       [10][1] = "UTCL2_NHT",
>>> +       [11][1] = "JPEG0",
>>> +       [12][1] = "VCN0",
>>> +       [13][1] = "VCNU0",
>>> +       [14][1] = "VSCH0",
>>> +       [15][1] = "LSDMA",
>>> +       [32+3][1] = "DBGU1",
>>> +       [32+4][1] = "DBGU2",
>>> +       [32+5][1] = "MPRAS",
>>> +       [32+6][1] = "MP1",
>>> +       [32+7][1] = "MP0",
>>> +       [32+8][1] = "IH",
>>> +       [32+11][1] = "JPEG1",
>>> +       [32+12][1] = "VCN1",
>>> +       [32+13][1] = "VCNU1",
>>> +       [32+14][1] = "VSCH1",
>>>   };
>>>
>>>   static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
>>> --
>>> 2.54.0
>>>
--------------LijcY78hM3s0PwtzpRWfpYDK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="monospace"><br>
      </font></p>
    <p><font face="monospace">Reviewed-by: Mukul Joshi
        <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a></font></p>
    <p><font face="monospace"><br>
      </font></p>
    <div class="moz-cite-prefix">On 7/6/2026 11:01 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_M1A9b5D-L8U6cc5DXWOCSh8+neNuBvBrofJMGPkZV64w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Ping?

On Mon, Jun 29, 2026 at 4:27 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Ping?

On Thu, Jun 18, 2026 at 4:54 PM Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">
Update to the proper client list for mmhub 4.2.0.

v2: fix typo (Alex)

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 65 ++++++++++++-----------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 49b7f16a941f6..5827c758b373d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -36,40 +36,41 @@

 static const char *mmhub_client_ids_v4_2_0[][2] = {
        [0][0] = &quot;VMC&quot;,
-       [4][0] = &quot;DCEDMC&quot;,
-       [5][0] = &quot;DCEVGA&quot;,
-       [6][0] = &quot;MP0&quot;,
-       [7][0] = &quot;MP1&quot;,
+       [2][0] = &quot;MPNHT&quot;,
+       [7][0] = &quot;MPIFOE&quot;,
        [8][0] = &quot;MPIO&quot;,
-       [16][0] = &quot;HDP&quot;,
-       [17][0] = &quot;LSDMA&quot;,
-       [18][0] = &quot;JPEG&quot;,
-       [19][0] = &quot;VCNU0&quot;,
-       [21][0] = &quot;VSCH&quot;,
-       [22][0] = &quot;VCNU1&quot;,
-       [23][0] = &quot;VCN1&quot;,
-       [32+20][0] = &quot;VCN0&quot;,
-       [2][1] = &quot;DBGUNBIO&quot;,
-       [3][1] = &quot;DCEDWB&quot;,
-       [4][1] = &quot;DCEDMC&quot;,
-       [5][1] = &quot;DCEVGA&quot;,
-       [6][1] = &quot;MP0&quot;,
-       [7][1] = &quot;MP1&quot;,
+       [11][0] = &quot;JPEG0&quot;,
+       [12][0] = &quot;VCN0&quot;,
+       [13][0] = &quot;VCNU0&quot;,
+       [14][0] = &quot;VSCH0&quot;,
+       [15][0] = &quot;LSDMA&quot;,
+       [32+5][0] = &quot;MPRAS&quot;,
+       [32+6][0] = &quot;MP1&quot;,
+       [32+7][0] = &quot;MP0&quot;,
+       [32+11][0] = &quot;JPEG1&quot;,
+       [32+12][0] = &quot;VCN1&quot;,
+       [32+13][0] = &quot;VCNU1&quot;,
+       [32+14][0] = &quot;VSCH1&quot;,
+       [2][1] = &quot;MPNHT&quot;,
+       [3][1] = &quot;DBGU0&quot;,
+       [7][1] = &quot;MPIFOE&quot;,
        [8][1] = &quot;MPIO&quot;,
-       [10][1] = &quot;DBGU0&quot;,
-       [11][1] = &quot;DBGU1&quot;,
-       [12][1] = &quot;DBGU2&quot;,
-       [13][1] = &quot;DBGU3&quot;,
-       [14][1] = &quot;XDP&quot;,
-       [15][1] = &quot;OSSSYS&quot;,
-       [16][1] = &quot;HDP&quot;,
-       [17][1] = &quot;LSDMA&quot;,
-       [18][1] = &quot;JPEG&quot;,
-       [19][1] = &quot;VCNU0&quot;,
-       [20][1] = &quot;VCN0&quot;,
-       [21][1] = &quot;VSCH&quot;,
-       [22][1] = &quot;VCNU1&quot;,
-       [23][1] = &quot;VCN1&quot;,
+       [10][1] = &quot;UTCL2_NHT&quot;,
+       [11][1] = &quot;JPEG0&quot;,
+       [12][1] = &quot;VCN0&quot;,
+       [13][1] = &quot;VCNU0&quot;,
+       [14][1] = &quot;VSCH0&quot;,
+       [15][1] = &quot;LSDMA&quot;,
+       [32+3][1] = &quot;DBGU1&quot;,
+       [32+4][1] = &quot;DBGU2&quot;,
+       [32+5][1] = &quot;MPRAS&quot;,
+       [32+6][1] = &quot;MP1&quot;,
+       [32+7][1] = &quot;MP0&quot;,
+       [32+8][1] = &quot;IH&quot;,
+       [32+11][1] = &quot;JPEG1&quot;,
+       [32+12][1] = &quot;VCN1&quot;,
+       [32+13][1] = &quot;VCNU1&quot;,
+       [32+14][1] = &quot;VSCH1&quot;,
 };

 static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
--
2.54.0

</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------LijcY78hM3s0PwtzpRWfpYDK--
