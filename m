Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F49C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 15:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B05D10FFE9;
	Tue, 30 Apr 2024 15:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bt03RC/X";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8508C10FFE9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 15:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEg2qsMwfPydOew3w6OJCJHjKY4Xfc1qcxFrIBRVvgRjUzM10k71T5fKkg8tG+x3socXoFWfbD77qwlFU9xMnNZNW7dt5FlNhs5YltFaS9Kv3NLezd7HeBzzMMRSIh/td27nbVZrzrell08t8K+dwtXjLdZHoFcSJbHQSlFB5KUbfhHf5BMeEFJ79y0S3bZdSnT5I4vN9qRvmmWBJv71NFceXbskr5/JklWvA5KV+9nN6PYuPal7CNvCm9E0BxwiFpyNVNBKmWJZvnGXtd42MiidQIQ2bEKOvztArroKP1xyY+E9QISXVlHEMQyfMvwjXARsnDFxT81aVDI49H3irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tay6fg1DQ17LCnKc3bT83ERQdkHG2AS9218uK6c2mI0=;
 b=E9Gnc5Cgo3Wpn8x3E5z5btNsMAkxpfBTeYudZGY8H48XOMJ32RdED6tP+tiMx20yxvfeV5PmnAFMoQmCowzuYvvTGV+JFr34TZ1AAH+Qmi1Os7pCP8mzc4EwKDehwTmz9b5HrUmjFOO6K1fsPUjOoQMl4TnsBlQzUgm3Z5dNniQSeVnUMW1EOglc07OhCuLR4zqyBkjebCmU430yL84ZwhiwSuHDPvhdigAmCrrYV9dubPJyGZ/hSqCg2Ew/49jvzkrjxoKH6AaqXeu0SbdiJqFifCkXRgT6MPsXVLlO6dF9bj1FEshc41vyCq5718qCHabKSBNr6l5YXv1BhG1IDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tay6fg1DQ17LCnKc3bT83ERQdkHG2AS9218uK6c2mI0=;
 b=Bt03RC/XFLZUB+DdmmX2N531cBwizxhrl/cOCcA22qfeYzWEYuWb0aLpvEqhZ3N+qWZMZM2xmmMsvU+5H3A90o+SDxVv1vP3q11nTetv1Xdh6jKmetOoeyr9TURKJd1rmNoEvryD4dHZM3OBWA5yQgEJcDXQruOnUSDTRTQ5RHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 15:06:05 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%4]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 15:06:04 +0000
Message-ID: <4499f369-3a8e-4290-8461-24644e2bf1b8@amd.com>
Date: Tue, 30 Apr 2024 11:06:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Override DCN410 IP version
To: amd-gfx@lists.freedesktop.org
References: <20240430134301.18555-1-aurabindo.pillai@amd.com>
 <20240430134301.18555-2-aurabindo.pillai@amd.com>
 <7f0cdeec-07f2-4643-adde-4bb490bafa63@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <7f0cdeec-07f2-4643-adde-4bb490bafa63@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0241.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::31) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 750b6f35-6748-4873-53e8-08dc69270e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cisvRDFTVUFObXY0TlpTeml2TStNV3F0cjdWNTl1dFpuK05vMlFiakZobGNo?=
 =?utf-8?B?bHNac1pNbmUrNXdqTk5qdU9reSszK0tVSGozMW9LT3lFREVIM2YzaUIxbitO?=
 =?utf-8?B?dVVOb1VvUk9mQ1B6UWNQUXc3L0diMjNGS1N0T3F4azJkNnltd0dZemgxU3Ro?=
 =?utf-8?B?U0d1c1RFRTBaYUpMSkxpVGU1RlNkSTRnK3J1elV5eWxWb25hNCs2cTFZU1BH?=
 =?utf-8?B?MCtzL2JIL3JVUlpZVHg4UDZ0Y3lpYnIxTHRtQnpOa1l5U0RaVnF0YjN2ejJR?=
 =?utf-8?B?OXRidW96bmdLY0FmcXVDbHpCY0krZklBUUYyTG9wV2pUVTBQQmZJVTFDYWJK?=
 =?utf-8?B?M2dkeFVneVc2L0srVTVXRitMdGZRMUJseFpvZTY5OXRySGJIdWdMN2p0YS9i?=
 =?utf-8?B?YktkSXROS3ErWFZ0bGRabXhFQm1lTmRkNWRZQkwyUEszMHBsVDc2MUh0VTRW?=
 =?utf-8?B?djBiWFRjd3ljSnZVdmpZSmVvZzVlZ1BvNVdtTXJ3dVVkQUJweE81ZW5CdEl3?=
 =?utf-8?B?NFdDZSsrUmNFK3AxZ2pMR0ZlNWxnQVo2MENyemJMNXhZQjBadlVPcW1NYVJ1?=
 =?utf-8?B?U3JCNTFmcVZ3c3FyYVQxdWVHTG1aaStnZUdxd0Nvck5GVVdjQUxRWnEwenp2?=
 =?utf-8?B?NUFML05pQSt5UzhzejFjY0JvRTR0NEFpSTU1SjdvaGpCSDZPV1hWUko4amVK?=
 =?utf-8?B?M01uSUNrQkRlOVFuNXVod2FwWUpDb2hsQTJvSGZkUHZObUkxQldFOG5RK05Q?=
 =?utf-8?B?MlB3VDVOSVo3c2N2OXIrNTdVNk4xWnlSWkRxcktYVmgyTHpSMUV4K0Y4ZlYz?=
 =?utf-8?B?dURqSzdUY0RlMzNWbkl4cXZKY2U0WlAvZGpaODBOaWlwTnFCQzN4enRyNlQ5?=
 =?utf-8?B?V0tCeDJnTzJGT2pPeGhlTnppR1pKWFh6T201cGIxUG9NaVhDbzM4YXpYM1lt?=
 =?utf-8?B?QzB2VU1zK1hUL2JzelhNYVFTWmViSTdnRTRTU0tVYWY0T2ZXVlgxWm5MMFZx?=
 =?utf-8?B?cG0wWGJENDBjZkdTR01SOG41N1hRR1JzUnNGeFVOSWgvU003VG0rZDg5Sy8v?=
 =?utf-8?B?bXZBN1BJdFdFaWFMVXRxTStEb09iZE9DaGh6U1pJZFkyakZyOEdwUGlFSkpx?=
 =?utf-8?B?dmp0bkZTRktQVU9hRTh3QnVyQ1lkMUgyNjlYcm52cStDY2hsRXFRSUpBV05F?=
 =?utf-8?B?R0JNYmFVOG5HeStaZFlLRGhPZzBOSHdMODByQTc5alBncEZ1QzNUWGU0VTBL?=
 =?utf-8?B?cWx4aFlDS0ZIeVFkMEZ2c3A3ZWN3K2FCRzM3VzNXaG93WkpZK200OFI1bEIv?=
 =?utf-8?B?anArdm5oQ0duSmhEbS9mVzI1TGhEWlM1aG8xOHlqNGRldGsvdHVoYkM2SWxS?=
 =?utf-8?B?U2ZEZk9LTnNQZDBsUHhmbVpKTlJxSFRMMHIrS213VDJFZUNJM0VaSlp4d2E4?=
 =?utf-8?B?VzNOc3MvWGpGQ3U3akdEcUIvZ0l1QU1lZUFBK3ZzcEhOd3FiWHhJOTJkWjB2?=
 =?utf-8?B?SEEyQUo2NWR4aW1LSVFyc3VsMDNZNkNvMUdZZWpqN2pPdk8xN0QwMTBxRkhL?=
 =?utf-8?B?RU1Kc05pOWhOWndWRTVkOU9ZM21FaThGYVJWZkZSODE1b0tsNHJOR2RBalRo?=
 =?utf-8?B?SUtESE05bUNZL0JLeWhlcUJTdnFlNTF6NFhBMDduWVZQWHlVK29sRkN1ZzhO?=
 =?utf-8?B?cnJJdVRPMlg5RXZjV0lmYVc3TTJ5QXl6d0RLNmEySTNuNHpXMUNSY2lBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2txRGRhNzI0c1hJTjM3WVYrV0RwVUY4WHIrb0JOdklKZ1A3c2NtK2doU01o?=
 =?utf-8?B?VTRzL2traU14d1NNRERSV29wZWlMVE56SUk4NEZMc1Z5b3NkT0x2dnRhZTQ2?=
 =?utf-8?B?R3kvRmNoSDdBWHJWdk9UZ3pVSWVtVUlOeEJkSGRQYkQ0R25IQVl2YU9PYjdh?=
 =?utf-8?B?aFpMdi94VlFEaHc5NUNrZ1YySGNUNmduRzB4Rnl0QUM3alNoZUNGTm9lWG9C?=
 =?utf-8?B?cTMyaGNkWmJtT1ZQSFVpb0JiS0ZISW9ZTFhPbFQyeXRiOVUyRjB0M3ljOXUx?=
 =?utf-8?B?S0JzdnhQZ1pCNGl4TFljREpNbUxtSU9LTXUxLzA4QU9XdEh0KzE3Y2FrQ0ww?=
 =?utf-8?B?Vkt1eStpMnRKY2JwWEVrKzhROHlRY3RGYnRmZjNZcXhXbkJ3MzVlSk9Mc3pU?=
 =?utf-8?B?Q2NUZnpDU1pGSHNBQXhVSS90a1NYKzAyZFpaQU9lc0hsTytmT0paTWtZM1I1?=
 =?utf-8?B?RW1rNDFNeHVzVzJESUJKYWxuMEFPVnNzNGlDaFhZakFGZzhtOUNTN2xJNCth?=
 =?utf-8?B?TlhMWHcvZFd3a2VTQml3Rm9CMnY3eW5qUEJIVGRHWjcwMFBpdlVIY2pOb2dj?=
 =?utf-8?B?aHY2d29NUmh0VUtHSlp3VmFUUmhnUXF5WWcyME03c2RFblFQc1FyT0NRTkJj?=
 =?utf-8?B?WGd2S0NxemoxWVdmMWw0TjBxeUNBREtNVk1JNDg4NGFwcHRSY01MOWJsS0ww?=
 =?utf-8?B?aFRXVFFoMWZPMTNIVlZ4c2l6YW5uTldCNDFnRXpWQWdzUGZkV0VFTWNmdFV1?=
 =?utf-8?B?dkJidi9nd3E4WHUwNE1FYm1HRFJ6d1RTRnBDYUZ6NWNBSVQrN3ExK05uWHJK?=
 =?utf-8?B?WkJXM25jTnJRUXVZQjRkK1VEMjd4NUJaclBqNXpGRGVNeWZXWUhHWG8rRERD?=
 =?utf-8?B?M0RFWDlTM0JEZ090WFBzRlRkUEo1VkJibkRpZm1qWnVNdmJ2RWRmZFZyYm94?=
 =?utf-8?B?djBtSVdUcEMwTlQwRUZHdTZvVko2L0tlcy9XMEtLWlFoM0Q1R3NPRUdIL0E0?=
 =?utf-8?B?TEpUVHo2M2c0ZUZUVlQxYW1JVklpRUh2NFYxdS9GNS9DbWxMSkpYb1Ewb2ZN?=
 =?utf-8?B?V3cwR2V3ZVljN0pQNm1LM25SNjY3cDNvamdmdEREQ2ZaMHErMC9Dcm5PbWsv?=
 =?utf-8?B?dTV4VVVFQWU0dWRLbzRyR2FlVXczbk5hc0lxVURXdFdwQ0ozSWIzUEQ5bEJx?=
 =?utf-8?B?NmFiTjlNMmJnTGFwaTMxU0M5eGJ6WVY1bWorRFFlWmY4Uks3bW13V2Qza0ZH?=
 =?utf-8?B?ZGg5M1gwWWlIRDdOV05zNmhxTnl0dERSVnpENzdhTFdIcHJ5NURRVFZPTXpU?=
 =?utf-8?B?TGJGV29kc1diRHRCQVFGR2I1UEI4SS9DaVF0RlQwVmV0a1NpeXZuRGlORFU3?=
 =?utf-8?B?SHY1VFhmRVE1MjJLU0dDRXBqVUwxTHRsUU5EQkJ3ZzJKZzNHS2Jja2VtMHJD?=
 =?utf-8?B?T1RSUS9UNDUzZHNiRW8yNEk0aFRWTWd1UHNoR3grUldtSWJkTFZIMVJKanhV?=
 =?utf-8?B?TmFFT2FzVzY0ZThTTnRlTVlFMzdBM1RteUdlMmd4UGVsQkdRaVE1OGJnL1hv?=
 =?utf-8?B?R3dnZHVMY3Q3d3NsVCs2Rjg0UzdsS1lEUVd3ckVaeXZVRGpFN0lWMnFORWVp?=
 =?utf-8?B?UnNnbEcvR3M3SzlKdXI1T0dSNit1ZFVIWEdWTUdjNm5wQ3FvOHo1aXV1L21h?=
 =?utf-8?B?UVlBeUVTT3BjOExkK0VnZEgvWTRMTlA1MzM1VjVxTFNuWlJOK1I1MWpCMnl4?=
 =?utf-8?B?UFp2ejE4dXVUcENtSTJodUd4YWJ5SFhkenJTNExhYVBMRjFQandRdGtvbHVa?=
 =?utf-8?B?RitlM3ZuZXVOdnc0S1kxdTgwaW1MNzBIWmVjalZWTW1ZSkxDV3lIUHRYcGll?=
 =?utf-8?B?a3hTRkR6QTV3dWIwOUltWEZad2hFU0lLd3BKdnZRLzdhSWdwMXBkSDZJVEVS?=
 =?utf-8?B?TSs2MmZVN1ZUQzBCSGJ4eXQxbVkxbkFqNzlwYjBQRis4TVo5T2RHYWJlVzlu?=
 =?utf-8?B?N2pNNDRxVStocmVWcWNHRXIyWnRSdU9IY3ZvTDIwYjJJSW80UTFzem4wTktj?=
 =?utf-8?B?NHE2TFhsanRiRlg4NGswc3plejB1N3VDUUZIVXE3ZEF4cU95Q0M4MDNOQVZR?=
 =?utf-8?Q?4k1/OiFhEmthKnwRVcLdBajD4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750b6f35-6748-4873-53e8-08dc69270e56
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:06:04.7190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dT82SIZ71nqzL3lrowLSY7gnAyU2uIIOMjO45UV8WOWXSYpT3LtdSRYUfecAOke1QYj3ZXkPNcIjjloXhu6Prw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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


On 2024-04-30 10:48, Harry Wentland wrote:
>
> On 2024-04-30 09:43, Aurabindo Pillai wrote:
>> Override DCN IP version to 4.0.1 from 4.1.0 temporarily until change is
>> made in DC codebase to use 4.1.0
>>
>> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index d7f948e84e4f..87a2f15c8a64 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -1966,6 +1966,10 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>>   		case IP_VERSION(3, 5, 0):
>>   		case IP_VERSION(3, 5, 1):
>>   		case IP_VERSION(4, 1, 0):
>> +			/* TODO: Fix IP version. DC code expects version 4.0.1 */
>> +			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
>> +                               adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
This test will be called for all IP versions - most of them are not needed.
I can suggest to move "case IP_VERSION(4, 1, 0) to the top and then fall 
through to the rest.
Of course it works without this but it will waste some instructions 
unnecessarily.

David

>> +
>>   			if (amdgpu_sriov_vf(adev))
>>   				amdgpu_discovery_set_sriov_display(adev);
>>   			else
