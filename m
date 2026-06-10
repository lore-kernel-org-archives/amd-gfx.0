Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A377DCD8C90
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 17:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 284F310E4BC;
	Wed, 10 Jun 2026 17:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C2LcviKB";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D7610E4BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 17:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsaI7JqmMbOZWyVmPXrUJW+hc2ysTmSyFAKj/BBfF2XqmvOZOQjdpfvFTpVcsbL4z1tngtUNghRNL80Ju9Zpmj+vlnYlTansJa6cZxa3cRNnvexucUeafC/LAjfeSLtbAig41IHSAIbRWax12lZJ78/5ofEGUP8KODbF5fhHiDNpR/KMa+Nix4uz1vKqINTDgFqA1+oFiP1T5vb5XyjCku3RHkzJ5MvZcLjGrrMItqijYbusKnPfibqP0LW+jnJfwyqbE9aPTli7chR5DaV4TPHcCCcJVzF/Y/8oOawhq5CEyrgrH/hSJ56qFUFvbHae8UfTBc3imkJzTgIQUPGx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2wCg4UwiZEoTUfRBqtVoO/11JBy6beDGPITn7ixD8s=;
 b=r45/YhPYnpUyPF7ePYxGWIJr8GD4SyUNEYsofH7euadVcoxH0jjRqFheO+u6r16EdF7ak3cL5aMaK38DJiNIacqUuJhg1lGBwk+QUJTrP8uHeOPuBRVq+zdR5t0rhavJioSNCnTpP7PGC3yjObeKX/PSuTNd92qUuX2B3/8iUyAIiCRq/Q1frEQ+QvGQswTnTFD8pGJft7BJA84pH2CnUXKdgutzDIhp2CLTE/7ftndnU+3f0j40TgOoj43MgvGFFtCLnbkvm4WN+puPOed6kJ6uuS95Cc6nekDdCDBVUSraGgq39ZixlGpWLdHoRKQnL9R5LbAvV0eMMbDGfg4dNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2wCg4UwiZEoTUfRBqtVoO/11JBy6beDGPITn7ixD8s=;
 b=C2LcviKBSISNhnUrfiupYqx5fTBKg5nQ0FNDj1fQdRoCnemd1yoTfyShFFb0a6F4EWFWbb3eY0HCOU0GoNMHkEbbel+9yezpLmLErOQE2pZW6sVLrsZjcT0lbB6xfOyIHz43jt92rCCcKPNrG+oX9WexuExE06l3SlDijQVw1oY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 17:06:02 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 17:06:02 +0000
Message-ID: <09101f54-50f8-4c14-b255-d39e2be360ea@amd.com>
Date: Wed, 10 Jun 2026 12:05:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/pm: smu_v14_0_0: add DCLK and VCLK1/DCLK1
 metric handlers
Content-Language: en-US
To: Priya Hosur <Priya.Hosur@amd.com>, Lijo.Lazar@amd.com,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Kenneth.Feng@amd.com
Cc: Veerabadhran.Gopalakrishnan@amd.com, Pratik.Vishwakarma@amd.com
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
 <20260610120944.124040-2-Priya.Hosur@amd.com>
 <008079be-50a9-44c5-a5a7-aeaac2047957@satlexmb07.amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <008079be-50a9-44c5-a5a7-aeaac2047957@satlexmb07.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:610:e6::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 926fce9c-bf0e-46eb-a6ea-08dec7128cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 5Ms2BxzKtBQSgbRZw9J59/1uh3yCyAtxSkcEKGRz1xISypB5u09Pefl1Jy1TBwnu8kSWdDwI4okEbxxwAoD0FvH8xYo6VCeI7QZgbJuctbglhuGchQgZ7VYPYu7Hao1M6CC0hfpOdra6e99tLn0zNjEWmZcV4Z72rpnUsn8sdZJlfUw7yJKWud7EwlHKXfpdNObSFYo0eMYincfgIHtsUrXYBjoNhEkBwAQ7eH8pJiTAgwhe/kFx7ezstgfk37zEvZsEGBEFix+a3SLw03JFTgZ/v5q79YEsto5MCZLgaziH/TxV/mtoXOVqIHUDIKV8hyatLXPF8a/2Pt+G1mQbGEtPhg7WKuthVmKKtdg+HC1AK5TldppzuoQl5sSPRfAy74TPAuzY6DedYclqM+i0F7dYTeglypuNHKS03J5MnGCUIsdsYxZkeTx2YHw9nCeyOFt4cG20ri9H62T/EL/bh0TYN6r3+zHpgmgKSDxHT4TTiTuKdP18oIDYO/6ULeUp3psqZCdScHfp5pA0c8lITc2xKoCiLkKDz6XLJ0Hsbu9DyxQM53m9Z2tXndAu06fs0iTd98quIwccOu84HIH7s05NHHvpJtg1SGeP0cROlwDlNCK936w/5SPglwOhHKR3Rieh6VEb57+2ZFiXkXGoQOHiQlPIyRW35SyvWdIquzDpnojLOUZOsz7Fv8FAJr7j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFpydHZSbnhqZTd1bHVSbmlBSG5ZM3pmN0MzL250T2J4QWt6SU1DV0dCWEVF?=
 =?utf-8?B?aFBXQzhsaHVxUVIvLzV3MHdUTlcyd0xLdytLWW9uVlpqc055bnJZZWc4OTNi?=
 =?utf-8?B?R3lad3M2TmY2VlEwNy9WSU5IQkk4MlZCQVhPZGZXK0hKVUtmRStIU3kyUXBr?=
 =?utf-8?B?MElJdGQ5bVRVT004NlpxaXBwT3ZDUEc2ZTJ1SENNWkVCZXBoT1A0c29EK0hU?=
 =?utf-8?B?WFU1clBLMm85Qk1lSDdYUXFBUFhFQWFpNXRjSUM1bHZZY1lEUHViZVd2Zlp1?=
 =?utf-8?B?K013WnZPUEhTcDNXOENxYkhMMHFVZXB1RUlpcDRPcGJOb2JqQkdLcmp2R3FY?=
 =?utf-8?B?ZG14MXZuQ2orRkpOSVF2allLa1ErSno1Z3JrbjBmeGtTZ3Vpa2dCRTZtN2FN?=
 =?utf-8?B?MG1yRXZQUEJzdVIrMlFJQlpRemJzSE90bE5MUFRqN2F0L0FsbTk1bUpSb3dX?=
 =?utf-8?B?NzY3cHpXM0JvS2VkWXpBTTJKd2l4SlNTWUg3d05qRmpzbERyOFd2RDJyYklK?=
 =?utf-8?B?ZnFVa0pvb2IyYi8ya1NWMVJteEN3MlNYN0tmMnpIaFl2RDk2dTRNVm8rZGU0?=
 =?utf-8?B?Z1FvVmdGNVBwNlhyWk1uUldpZ093VWRrOXUyOXR2anZCQm1FMTM4WmdYdXRQ?=
 =?utf-8?B?TmREbHQ0cWR0MDhvcVZFbm8zU3dMYmdZV1ozNFpBVWV4NmdzRjdaTFpsMTk4?=
 =?utf-8?B?YWJWUFN6cXg2ZUsrZzZva1NnSmlHSGFDenA5a0IyL05pZ2RYQnh0azNRM1lF?=
 =?utf-8?B?cmQySWNpaUVaTjJXMEpjK282UDNSWnRVS2lDZllSZUpUUmdsT0hZeDVaYTl5?=
 =?utf-8?B?bnJFcHlWOVI4M2R3dllHUVZMVFI1eEt1ejhmS1Z2bXAzMGdSUFJHaEFZMnpD?=
 =?utf-8?B?L1Q0K1lBakxsbDZPeUZCVk5xU1Rqc0c2N0Fwc1RFZW44dGs4bVFXVWJMYW1B?=
 =?utf-8?B?Y2Z1OVJQMkxSY3djZ1ZOSENsaG9lWVpwU1RYTFNtUDdvSUpKRnJ5VVhibFRK?=
 =?utf-8?B?Tk1CWFhZdUZXUHBvT2QvSG9ObTNVWFFSSzBTWW9TVVRuanJ4OThvUi9BR0ln?=
 =?utf-8?B?K2E2QXNzbVQ3OG5CUWQ4SnM0UStkMEplOHQ5Y3dLOHhOQ0NxZnVFcDVheFkw?=
 =?utf-8?B?TVF0SmxSVVhoSUgrc096b08wbDZZdDYrS0phTCs2azRDWGJnWEFYcmVYVzB4?=
 =?utf-8?B?cTFxemVTZ1ltMlhGbVJVUG5NWFhlZzc5dHlodGliQWFnY3RRTjAweEFYanVD?=
 =?utf-8?B?MWZ5bG9IRTM3SXdEeU93RXVzVXlMY3dmQVIzMUxHRE5NZnhOODBaZENkZ0Zr?=
 =?utf-8?B?UzZ2MDlzMGU4MEI4emxwVkFIWGRzbXNZMnJiMDJMWG4yYStVMFZSS2djZlg5?=
 =?utf-8?B?Ymx6aTEzQ3dFemp6WGpnSVJNcmppYmp1UE9zVitnQmtoczhjY2JrTUdTWS8z?=
 =?utf-8?B?dVVkLy90bTFqTkZQbmxZTUZXQ3NkdzYwZ01LNWlKVGdaRHVqUmRzZzdwSFNn?=
 =?utf-8?B?aURrMjR2R1hxWTQ1SUZ2czlxU0RXb1ZjK3lucnpTQjE1TGZKanV2a0tMSDZT?=
 =?utf-8?B?aDA0YmFVUFRBbEVnT0hoZnZ2V3huNWp5UlYwM2NyRlVnTVlpMXJjN011Mkx3?=
 =?utf-8?B?MlNtRjh6ck1QZWp1SGlESnVIVTFBZWNuYkRsSk41a1Y4c216Nm5ES1F1WWdk?=
 =?utf-8?B?LzNmSDc4L2h4YlhJRDVpbVN0dmxhRjBHM0xRY3gydG41bWxaekNPa3hzR0ZU?=
 =?utf-8?B?bk9XWFQ1QzJFbUwrT2Q0QW00MVJBa0RFd1IyVjc1MGxycXdLVk5nK3hvUzRU?=
 =?utf-8?B?SXR4NEVISGdMdVZqakErZUVZc0tmVStlaWZMUHV2R3N0ZHJMZWo2eFBMV2w4?=
 =?utf-8?B?V2sraFVlZU9QL0xIY0xZNFdIZWFWMzJycGNid1MwTUlJK2RaenU2eUYyR21o?=
 =?utf-8?B?RTBCbWU0d3NMUnJEL2w2YUgvUkc4VXJtMTdCeXJ1UHJpWWZ5eDhHM3E3OXdC?=
 =?utf-8?B?cVZxZWlubTFBcXRvQVR0ajZTMFk5cWlUYjNuVnBZUGZ2MU5rYzIvY3FYRzlt?=
 =?utf-8?B?QU5vWDhSSno1OXNQVHFsckt3V3NTKzQwSEZEcGFiYnZ4ejBPTUZyZXREQ2Vo?=
 =?utf-8?B?Y3dsM2xza2tmWXk4YVNOZVJGTGlhR21FblpJWnE1YmxCU1F6ZDRNUWJuT3FN?=
 =?utf-8?B?OW0xZXZ1a0ZNQ09VTFZWNHQrSTFib2pJSCtJcEdVc2JpczNVc1FqVS9zOUc0?=
 =?utf-8?B?QjNlWUp2OHNGUm9xNnUrOG8wQ1RDZHBXUWVxK2lLQnNhQmRQTXVyM2w0Q0Vq?=
 =?utf-8?B?Z2cwcURQcVI5YVBOaUJtNzdIQlF6NmIrcGtnUkJ5ZkM1VW5tT3pRdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926fce9c-bf0e-46eb-a6ea-08dec7128cc6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:06:02.0114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpONGDvaSUe7uxxvl1yV6eY/1oIHJ3Femjmc9mjwT0Q2irN+irBuB72/4eucvVot9XzRdFjtcUw8EznYjAhcBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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



On 6/10/26 12:03, Priya Hosur wrote:
> On 6/10/26 08:29, Lazar, Lijo wrote:
>> These are clocks for the second VCN instance. If adding them to FW
>> metrics is not an option, then reporting the value as UINT_MAX is
>> better as that indicates N/A (not applicable/available).
> 
> Agreed, I'll drop the VCLK1/DCLK1 handlers and let them fall through
> to the default (UINT_MAX / N/A) in v2.
> 
>> Do the two instances share a common clock?
> 
> On v14.0.0, there is a single VCN instance where VCLK and DCLK share
> the same clock domain -- the DPM table comment in smu14_driver_if says
> "Applies to both Vclk and Dclk". So mapping METRICS_AVERAGE_DCLK to
> VclkFrequency is correct here.
> 
> On v14.0.1, there are two VCN instances (Vcn0/Vcn1) with separate
> clock domains, but SmuMetrics_t only exposes VclkFrequency for
> instance 0. There are no fields for DCLK, VCLK1, or DCLK1 in the
> firmware metrics struct.
> 

Then I agree with Lijo's suggestion that it should continue to be N/A 
for second instance.
