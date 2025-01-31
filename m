Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A5CC0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E70F10E3AD;
	Fri, 31 Jan 2025 16:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="da70stzb";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 049B010E3AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gom+UH0tzz0/voIoHBN7EPvG/w2NIsFxuryGWEVMv936W7twjAoKSwqY8UWahdDR0Co0J9VTSaeFpFauEeJDkiRmgkWVDYsGx+lGmJ0JqFmnOLsgzSMycvaHv+Z9v9Jz2wpAmwI0IywcYdGwHEdu5BsiYbHpkj8YXQXBZkVosz04JvwpkJu8KMlFSlr9hEsdcVSYAiwxkOHRB9oN6Gvrq4kBoOUyX+q12GSKdEOkA0E7M0BqDiPR6JiUF0Biijw1yzL+WCqYP3+wrkqjPIQeqBJy7J/rG+Wd+mxHuxawyPhbHrCHLRQYXZEdz7Af7dzTzwpAgPxLsTOqqDXNgVoOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7nEM7ki8KKjcMj45EkDWd2TzIRET+LvV4IkrYS54Yk=;
 b=UzlQrdQG2A8m0mGyR/3W2Lkb1J21c/EKtG4iWygiGcG0SUp2SrMABMRVONcw3DbPE11ZSgrDCn+1H6AzE+AOZlbVf+40ESREapnONNXZg0TUAqRyLit6YLgmfOyRCOqho6MsJrfoXINq+iXXGQy0XGB6GVb3vP7HO+9aWBTDL4ieFN+BCjMv+q5T9JLAkL74JbK9jphxdJQB3AwZLsi0/jrYFJ1EHEuqyjpqQN4XDsEMQFedPlmAYJkqXjKMADqDfyE0FeFe9Wx7k1/iLLvK/t6MDGqfafM/u5s/MP5wuivswXl9i0ymEw5TIkpZyIO00kJ8rYNFBWVOskeKtsCkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7nEM7ki8KKjcMj45EkDWd2TzIRET+LvV4IkrYS54Yk=;
 b=da70stzbqrFhuj8P4m3CoxUkTxzOIFaBrKM6TpaS1vWgcgBzHDrXnwED8ppR4a5SzFJhJmXB1Da8Xrld8BhV7ai0VIfl3O6fw6wCqukJ+Lvram7c9ONcrp28AxX9Rf84vPZsL5aWIHHHV96HJM6CguhHhoCOmXJwHllRSQoEe7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:49:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 16:49:08 +0000
Message-ID: <8a8f4581-0185-4180-89e6-aa4d01260cae@amd.com>
Date: Fri, 31 Jan 2025 17:49:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: Add ring reset callback for JPEG4_0_3
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
 <20250131162321.563314-3-sathishkumar.sundararaju@amd.com>
 <8371968e-e270-490e-9454-b521edceef37@amd.com>
 <8b9995da-269c-4a96-b374-09e40e0df605@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8b9995da-269c-4a96-b374-09e40e0df605@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 9560950a-3be6-4fa7-c037-08dd42172e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEg1NEpFL0lQNzA1a042V0xGYlhweDhvaTZBWCtYbHcvcTUyejFoZmc2dmVj?=
 =?utf-8?B?SEwwQXBVRXpIaE5yR3RscFU5OVk1SGZlQ0QwK3JxU1RXWFpTYTZ4SE5vYk40?=
 =?utf-8?B?cmZLS2xVQU1vbFllZ1VoaHhqOEU3Q3Iva1pMSy9qemdyR1dVR0dkcXJ3ZWF2?=
 =?utf-8?B?eGJKUDZJM1BJUmoyNWppY1RkY1JZZEIzaEhlU3dYN0hqMm1nSWdyek5vQ2Zm?=
 =?utf-8?B?Rm1WVkQrVEhIUVF5aGNTalRpTGxwZ1JxQUtWalVkOG9YcVhjWmtuWXo3NnMr?=
 =?utf-8?B?Vy82bEJBcVplZFBId21FbDEveW1sbklvTFdwTXBNdHNRYXRzUnMwL1BSRHRr?=
 =?utf-8?B?WVhqZlMzMXVXWnBqc1pHMG9uOWE2bHVFanBHN3pNMUZCR1ppTVg5Q01FWkls?=
 =?utf-8?B?K0w3eloySlhBcUE5dWpNWFlRdytsUitTbnFPdDJxOTFsVFYrYXBrNTJWV2Na?=
 =?utf-8?B?QnpGK1g5OEltSks2eGZqNnVySnJQbnduSTNLOFBGVTV0RWswR0R2TjJZa2o5?=
 =?utf-8?B?bjhyOFNFcDhsTDRaYkNCS0ZLVG5qa2pHaklRRVI5YWFyUzUzOVhNSGRNbEsy?=
 =?utf-8?B?Ri9DZTFNNVJySnlVRWZrK1VnRnkzWGd3Yk9MOXN1Z1ovMVBZWHB0aStzRTJE?=
 =?utf-8?B?dGhreE42ZXRseEJxWU5UNW5yR055QThNcnVHV1NDUnhOWlhTNDFvbW9sQkF3?=
 =?utf-8?B?WU4zRzZsR0FWdXdaQWVzMFhSc3VUTFRUTTZzakYxYkhFMnY0SEZxNHBtQ3hH?=
 =?utf-8?B?dFNvYXFNeTJURUFZbFNBQnBrUTNEa1ZxZkNSbm55YzZBc2Y4WTFONXZvbjdR?=
 =?utf-8?B?bzVoVUlCdEp4K1NiUmoyZzJ4WUMrQmZLOW85WlhnUCs2a0pZeXJCNUxYaG1i?=
 =?utf-8?B?K0k1RXptWGJyRnZPczlrNGNXQWRTV0ZKN0NnMDlzOG9IemNiaC9zanVWUjRD?=
 =?utf-8?B?clpKemlUZnA5enRFQnhNai9LcXVpcUdkMWErREZDZ0c1WEhCYWx6QTFpQkgw?=
 =?utf-8?B?RFBubFNLUXExRjQxZUZFM3g0bEVkQmcrYStCbDdlSGZBV1pkelZGZGltYXgx?=
 =?utf-8?B?cjN0M2NxTFVmb01oUEZQZ2VHRU5FeUE3NW91dHVERzJLM3hlNDR1WmFVc1JE?=
 =?utf-8?B?YkM3MWh1Z0tQTXF0YlQ2QTB3RmltNm9vNk40Y2ZMcWtNb2J6cVRDUVRYMTZj?=
 =?utf-8?B?WTduYlVNK0h3b2wramxBYlUzK3ZDUHFxNUNuYW1lbFRTekpNMnA0eHhaaXU3?=
 =?utf-8?B?UkJ4QUtqQ0ZzUXRMRjhrQXpxd3dGREZwUG91Rko2YjVrYkJ3K0FFWSt3ZzBx?=
 =?utf-8?B?UGtYcGVxa1hKeTlBcFkycHp0d0NjNVBnS3JKeHlFTjlRaXVSaW1TbTFMQ3R4?=
 =?utf-8?B?eGZlS1JseGJUNG91YkVieEdSVnE4aUtsSnV5OUdMVnozcXNVNmUxS1hkblpG?=
 =?utf-8?B?bVdscU5kbTdHaUFpWVJKMTgyVG1nb1luK1A1UytpRFAvaEl4eFhtTVpFZTZx?=
 =?utf-8?B?OXg1RWJQMnljWnk3UW1WdXB4ZEVuM09DbGo0b2xGTmtvUHNyTmovL3VlUXNv?=
 =?utf-8?B?amd6NnZwcjV5Undrc2VqM0dQM3JOaTY1MnZUUDd0amMwczVnWXplNWxDRlpz?=
 =?utf-8?B?aWJja3U5bldEczlFeWxJNXVOLzFudG9PU0tHODJQY0dmcDlPTUwySDRwNmdn?=
 =?utf-8?B?NHJqaHFjMGs3Y3U0ZVBmVlhNM1lmMDMzekdmSWVvU0VxSzBYNjNRbnA0Y3U1?=
 =?utf-8?B?WVVDenhzY3JlTjJJRXdpb3NsYlZyd2xOVkIzdFo3cFg2YWN2QVlSTEwreElS?=
 =?utf-8?B?RGZENGtwRVNMaW1XL25oeFc2ZExudHpsR3RpU1Z0SVFOWmY3RlVDYVdwWlNs?=
 =?utf-8?Q?JZBhMPJGL1V0y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHEzS0NFQkluRHQ0c0tseWk1Q0N1NmpoY3N4UWw3NHpPV2JUS1dXYkg5N2tk?=
 =?utf-8?B?ZGJhdFRaOTRtTkNRUitCU1hsbUsxRFBpUUpPNHUyS3BaOUIwVVZrWFZZZ0hZ?=
 =?utf-8?B?TWxEWEZVZit5VzlZZDlORmNSd2h3bVBLRy9pSzIwUXZvSEQ1cVJndU8vay9o?=
 =?utf-8?B?UGxKV2g5TTM5RStYSWRhLytQQnhrN2FFZlpsYWZTbWY2UHN2VCtPOFg5b2ND?=
 =?utf-8?B?ZWJwN0J2ZENlbnpuYm1taExzTlBaSVpyM1pzTmI2QkNQOGlTdzdvOEo3VEdX?=
 =?utf-8?B?OWhydU9idHp6bXZUNTZ5OVFJcWlWM2I3MmV5a2RPR3VvS0VwMXdUTTZxdmU3?=
 =?utf-8?B?V2p4K2MrZmlPb1ZuaHo4a09VL1UzNlRPV2Z3UFVrOGJTUmRneUJJN0dweHR1?=
 =?utf-8?B?ZGFsQ051TWdMRlV3bE9WMjVqTFFOOEVjYTdQM3pqNUxVaUtwVFhYV2t6ZS9z?=
 =?utf-8?B?WXZJRm14MDNMcFlmWVFJVHc1NXlHVVRjSzU1YkU2SDRWbmkzbzVFVXY2ZjFi?=
 =?utf-8?B?TDkvRmhrMzZZa20vVGowNnFnMXNhR2RJT3p5ZWkvZjhnZm1aY1ZTeFdJNlR6?=
 =?utf-8?B?My8waE9DZmQ0NTdWZEVWK1VnYjU1ekhSUFM4bndyaXJzVFdxUTQ5VzRFWlZl?=
 =?utf-8?B?T3NsVkxDMnRSdGh3Um1LYXFld2RFcVQwNW1pQ1VjMnZCbStBR1Nvb2JBQzVT?=
 =?utf-8?B?UVU0bjZGWGZ1WnQ2LzRGMER3WWxIdkplaDkxbzlOVStSTDdCMk54MGZaakh2?=
 =?utf-8?B?SFp1TGQ5T2NuVzU4ejgxTm1idjhQTE9Iblkvb2RvcHNlNG01L1FyQlA5MFBm?=
 =?utf-8?B?TG5QYU4zaWVLL3lQenVCZHZPdEZaSnNZQ1NBcGlYeHpNZjFpNzJSSHptOUhw?=
 =?utf-8?B?RHkxY1QzV2NzVU1ZditPdEVYT0lDQ2dIU0ZGNXdBeHU0ZmJtZ2ttRGhYVmhi?=
 =?utf-8?B?VlovWURxZXZWNURSeFhaMFBIMkpIRGxENHcwRXZhYmRySXNFOWsrL1ZrWC9i?=
 =?utf-8?B?RkwyNkpvYWIwZFl5YlJFSFF6K3FFam8vYVd4aVhka0lWNUQxdVA2cHFLVDlY?=
 =?utf-8?B?L0phNk16WWlUcVpnY0NQaUd3dUlncnpQbE5yRU43enFTbUhNUC9vVTZkVW9k?=
 =?utf-8?B?aVlFNlNOSmJhODNUc3JUT2d1dGhuN3p0YmNweVJ5cm5hait1dU9VQ25tbjhB?=
 =?utf-8?B?S210K0diR0RmQ2VMaXRXdFlUK2dFM2lZR3pmM0VJQURKN3ZxbnMxRTVlUG1J?=
 =?utf-8?B?c3cyNVNjZ29wYUM0TGRlejB0Z0NsSlRUSzhXMVBINElDamh2UjVSS0JMM3JO?=
 =?utf-8?B?ajhHMlBJRXpJMXY3UEl2QjBpWG80Mmc4Vm1ZTnNZaDhUN24rQ1pJK1NoYVhF?=
 =?utf-8?B?UUlUQTlsSnVqUUxZWStFTmk0M3VoRzBwUVhFQmc3QVR0N3ZSYkNXWm5ZcFFY?=
 =?utf-8?B?UHBSTFJBZW9RNkdPK2ZWZ0ZaSGorTEtXa3hjNHZUQ001Vkt3VDlRWHhESzNt?=
 =?utf-8?B?QTRTTXNZd3RSL0w3d1Rjb1A4ZHFtc1NWeEFqelZBSzFBR0JQN2pxbkY5d2Vr?=
 =?utf-8?B?Yld5cVozb2xxekRzbUdkTVV1cUE3a0V0WnppeHBTbS9Pd1hUVWNGd3I4V0VP?=
 =?utf-8?B?RExCQjR2RUQyQi9mTXZ3bEFPT2dlMWJROEgxQUlvRC9xeWdtYUFNcjYyUEdO?=
 =?utf-8?B?QUV5UlhIQ0t0aEJMVGdYMHhnNUZsVi9aRUg2YS9Cbzh6bkE5REZUVDZxVThI?=
 =?utf-8?B?Ylg3WWFvUnRvOFROU1VZZWVROXJaZy9MVy9tYm9GZHY4WWd4SXU5OXl5cDRB?=
 =?utf-8?B?elgvbHVZdUdhT01QTjRDRXdOTU5CR0NTanRmeUs5MGJVd2JRTlpUenA3UCtw?=
 =?utf-8?B?eDZid2VWRGlpekNaVWF6OS9OMjNMb2lsYkFhaXd2MTVlMWtheU9Cb09XNDk1?=
 =?utf-8?B?VFE4UC9UL1hrb2tyRThmeUFHcjZudFVmSlkwNm9rUXNYbU1ic0ZqQklPR0Fr?=
 =?utf-8?B?M1g4TGV5d3RJd04rRWRtaFFoNFpPVGRwVGtqbnZLbk5sZ1czSzVDWWtPWnJm?=
 =?utf-8?B?ZXE1aFhiU0t2WUJ0VWdPRTVuYW1HT3A0RlFkZ0wvdlZ3bnhsbmExMVRxZXU5?=
 =?utf-8?Q?qk8vG+5jf4h8JM4DUoMXEDNaW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9560950a-3be6-4fa7-c037-08dd42172e0a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:49:08.3603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83OokST8R7Ay/htDdOZLirpSJ0LCA6EkM1Y9ZfDYMUagCqoGW144d9L8l6ycv1vP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
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

Am 31.01.25 um 17:40 schrieb Sundararaju, Sathishkumar:
> Hi Christian,
>
>
> On 1/31/2025 9:56 PM, Christian König wrote:
>> Am 31.01.25 um 17:23 schrieb Sathishkumar S:
>>> Add ring reset function callback for JPEG4_0_3 to
>>> recover from job timeouts without a full gpu reset.
>>>
>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 
>>> ++++++++++++++++++++++--
>>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> index be0b3b4c8690..62d8628dccc5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> @@ -204,9 +204,7 @@ static int jpeg_v4_0_3_sw_init(struct 
>>> amdgpu_ip_block *ip_block)
>>>       if (r)
>>>           return r;
>>>   -    /* TODO: Add queue reset mask when FW fully supports it */
>>> -    adev->jpeg.supported_reset =
>>> - amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>>> +    adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
>>>       r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>>>       if (r)
>>>           return r;
>>> @@ -231,6 +229,7 @@ static int jpeg_v4_0_3_sw_fini(struct 
>>> amdgpu_ip_block *ip_block)
>>>           return r;
>>>         amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>>> +
>>>       r = amdgpu_jpeg_sw_fini(adev);
>>>         return r;
>>> @@ -1099,6 +1098,60 @@ static int 
>>> jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
>>>       return 0;
>>>   }
>>>   +static int jpeg_v4_0_3_wait_for_idle_on_inst(struct amdgpu_ring 
>>> *ring)
>>> +{
>>> +    struct amdgpu_device *adev = ring->adev;
>>> +    struct amdgpu_ring *r;
>>> +    int ret, j;
>>> +
>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>> +        r->sched.ready = false;
>>> +    }
>>> +    /* publish update */
>>> +    smp_rmb();
>>
>> Using smp_rmb() to publish the update is 100% incorrect.
>>
>> What exactly are you trying to do?
> On JPEG4_0_3, there are possibly multiple contexts submitting jobs to 
> all cores on the affected instance,
> so I am changing sched_ready to false and using smp_rmb() to publish 
> to other cores which are trying to
> submit on this instance , for them to read the updated change 
> immediately and stop submission before
> I wait for idle on this instance, which makes sure other good contexts 
> of jpeg get a chance to be migrated
> out to any available instance before reset starts, that way good jpeg 
> contexts get a chance to continue
> without issues while this instance is being reset and made ready to 
> continue decoding after reset.

Ok, completely NAK to this approach!

First of all setting r->sched.ready to false is a completely no-go. I 
can't remember how often I had to remove that nonsense.

With the exception of the KIQ the back-ends should *never* touch that stuff!

Then the Linux kernel requires that ever use of smp_rmb() requires to 
document the matching write memory barrier.

Over all please completely remove that code all together. The wait for 
idle function is *only* supposed to wait for the HW to become idle and 
nothing else.

Regards,
Christian.

>
> Regards,
> Sathish
>>
>> Regards,
>> Christian.
>>
>>
>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>> +        if (r->pipe == j)
>>> +            continue;
>>> +        ret = SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, 
>>> ring->me),
>>> +                        regUVD_JRBC0_UVD_JRBC_STATUS,
>>> +                        jpeg_v4_0_3_core_reg_offset(j),
>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
>>> + UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>>> +        if (ret)
>>> +            return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, 
>>> unsigned int vmid)
>>> +{
>>> +    struct amdgpu_device *adev = ring->adev;
>>> +    struct amdgpu_ring *r;
>>> +    int ret, j;
>>> +
>>> +    if (amdgpu_sriov_vf(adev))
>>> +        return -EINVAL;
>>> +
>>> +    jpeg_v4_0_3_wait_for_idle_on_inst(ring);
>>> +    jpeg_v4_0_3_stop_inst(ring->adev, ring->me);
>>> +    jpeg_v4_0_3_start_inst(ring->adev, ring->me);
>>> +    for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>> +        r = &adev->jpeg.inst[ring->me].ring_dec[j];
>>> +        jpeg_v4_0_3_start_jrbc(r);
>>> +        ret = amdgpu_ring_test_helper(r);
>>> +        if (ret)
>>> +            return ret;
>>> +        r->sched.ready = true;
>>> +    }
>>> +    /* publish update */
>>> +    smp_rmb();
>>> +    dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
>>> +    return 0;
>>> +}
>>> +
>>>   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
>>>       .name = "jpeg_v4_0_3",
>>>       .early_init = jpeg_v4_0_3_early_init,
>>> @@ -1145,6 +1198,7 @@ static const struct amdgpu_ring_funcs 
>>> jpeg_v4_0_3_dec_ring_vm_funcs = {
>>>       .emit_wreg = jpeg_v4_0_3_dec_ring_emit_wreg,
>>>       .emit_reg_wait = jpeg_v4_0_3_dec_ring_emit_reg_wait,
>>>       .emit_reg_write_reg_wait = 
>>> amdgpu_ring_emit_reg_write_reg_wait_helper,
>>> +    .reset = jpeg_v4_0_3_ring_reset,
>>>   };
>>>     static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device 
>>> *adev)
>>
>

