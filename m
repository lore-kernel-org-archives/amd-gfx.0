Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D624C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 21:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C478B10E192;
	Wed, 14 Aug 2024 21:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tJ5LgMWp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E068610E192
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 21:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU8URq2174GSkKQ/lAysY5p7Ep/06M1A1H/cxbFQ62r0d8t8STc2VW1KbRxr9AoS8xlntuxR6uTe3h1X9p8VRf5nm6YvM8880RDxkFHMFBhWb+X5ihEoYTCWInXOVKkEDXx+pHfKlNUXxYJd5Ya/DpVWyNv8bkrjjJ8OWOiTR3aLqQwg2Frwehm/wPoYbhTlN+dGKgs5GVvRX8NPOXiuIDA2Mw4M3TPmB/GiY7CLgMKH0A8Xs9O/bqV0YVt+PmTiIL2jMwkSIzQjVA2Vzq01ExZBBjIiUhb8vaCRmz344G5cRPX1gDuZPXdoGOPiqoR9gMTt2/eTEY4J6aDwkCNL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4ryt7aAPl1zLtzwxSnM7glzIDPK3kwyq+LeMyrcEDU=;
 b=ZNUG8c9GVSw6N41/picJZMmIYUgz/UaF2xUonb84d4k3YoJ/HNR41hX9h/zPO2rbxUh2mf4RJVwfKGeE8/hvhP7Qj594OYfSINZCHlxz09e8dJp7IyktCUjNeYkhoqjoOvwlulhxsDErmKvGkqEyFAFgSp/LiyW2TNjYe7VwnXCo4P0NIdlJVmFdQ7g8Tkj6nsnK0/GtLQbAT4aa2UckFpaQ+voD6Ikvrpzu+i3w5nYNyQk1thNGAGZRZ2/e/uGE+8pS+Rfn7dCa3IjmcwRYOOuFi/AzEHU3oXTNykKN26FXngX4RQLMqYkATRtMQoo9pgG8aLBmlPIL8ZqaYjJbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4ryt7aAPl1zLtzwxSnM7glzIDPK3kwyq+LeMyrcEDU=;
 b=tJ5LgMWpe9EdrpH05twkzV7oJHIihUhiofhHhsh0c7bz0QtWRx+Y5MKR6/SlsLC+JuzB6iMuKkCITadOtPumpadashUVhK4xDIFyO/NqMJ5bwDw6fgfaPrw08PFQhgyVoj/S32qa3jIiDl/e3gdbl8OGgDJ+hV7bofcRIDxIgIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 21:40:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 21:40:46 +0000
Message-ID: <b9468cbb-cdd5-43df-ba5c-c15bdb6066bb@amd.com>
Date: Wed, 14 Aug 2024 17:40:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Take IOMMU remapping into account for p2p
 checks
To: Alex Deucher <alexdeucher@gmail.com>, Rahul Jain <Rahul.Jain@amd.com>,
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240814090849.36891-1-Rahul.Jain@amd.com>
 <CADnq5_NVkyrNbYkC9GfB112BSoEzow6P-=EUQJ-gjAquOCyiGA@mail.gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CADnq5_NVkyrNbYkC9GfB112BSoEzow6P-=EUQJ-gjAquOCyiGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e946cf-5c6a-4f14-8d99-08dcbca9c10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTNVM1JhWWlBeEQ5SXVHMW5OSHEvRlJFekZQQnY2bFlNcG1Da3Z5d1lUaU0y?=
 =?utf-8?B?Y3hQdVkwZmZneUVQVnk4NTlBSHlud25UTXRueE03YWVFR0N5c2QxTyt2ZVdQ?=
 =?utf-8?B?THZpNHRXczBFRkZ2VEpLNGpEbkcxaGJ6MXhJRHU0L1c2ditUYmE5M05aN0Er?=
 =?utf-8?B?WUdQblhSNXRKend1ZlZZUGp5ZFFTazNrMmp5RjR4UjZCRUNFRGc4VVFIbm05?=
 =?utf-8?B?L2RsQ3Rwb3M1ZHE3NFpHZUwrOG9SOEdJTlpFMnQ2N1VMRC9VU3d2S2FNdDJ5?=
 =?utf-8?B?NDN0Z21rSURmM08vOHMweGRyOEtNQk5rS1VGYUdzSlR6SEVRUGVwOU9HR0hr?=
 =?utf-8?B?UnVCZUJ3eWFpUFMvZlpkcW1OZENjcTNNOERlSUY3RW1oeXVncVBGZFRXcHl1?=
 =?utf-8?B?cTdlcEl3TGZFYzFtUzJrUDNHKzA4L1BrR1J4bm1BV2M3S1k2WElmUXI2Y3d0?=
 =?utf-8?B?ZWs1dkU5aEZtWTV2bUlBbjRtMTdBTFg3b3JtUGVZcC9weFVhd0xqU1p3Tzhn?=
 =?utf-8?B?bTdGNWVMSlZOeGRBRG1UT25TWW5HZ2Z5T1ZuTEFEd2NTa2gxb2F6TFRZWjBo?=
 =?utf-8?B?U1N5cStXeTBlK3NaLzhCVmk1UmFXTlVvZWRIYThyeDhOekptcTgyZUVLNFkx?=
 =?utf-8?B?alNMcUtoaHdUc05DaHY4Snl4REJzWXZUaSt4VHNIUmZTRGsrL3NQTUEra2FQ?=
 =?utf-8?B?dWlldHNVeDNydlNiaytqbkdOSy9EbHlsZWtDc0M3MWlyN1phN1ZMMmlIcFpE?=
 =?utf-8?B?Ynd3bE5wTDVJS1J3OWVtRVZDRVZkbDRjQUIvZ3BZTUJkOFZyY0FVVmpkMjI4?=
 =?utf-8?B?K2JvYzV5cENUR05aS1dydm5xMlRLQWFZcmtwanoxY3N4ajQrS0NrYnUzN0dT?=
 =?utf-8?B?am92ckt3NW43WC9ueTB4SzBpZW1sQ0hyOXdhbktMUk9uQys4SkRvVkZnbDRU?=
 =?utf-8?B?b2hlSjU1a09HUVRscldNSFA1WmVxcGV6Sm05Z1NZWjZobmo4SlNUNkQzMXhv?=
 =?utf-8?B?RFBnRyttWnBoalVvSVJyaklRT0ZhSWpQREpaNElWUitucloxWDVkM2k4dU45?=
 =?utf-8?B?TFNsbHpFd0FYRTJPRnFGNndLd2lmSEVvQTdzWUJQbG1LcjBHMlBjVjRDOHRN?=
 =?utf-8?B?SDJ6RU9iMXMzZi94TlY4TTNxQnVDQTlXUmFuWm90UmRDU1dncGp0NTVPbklp?=
 =?utf-8?B?UmZUekZpdStScmpsODFvbTlUOE5qd2lJUlpPWGdDK2llWG9HdVZvUk96MlBn?=
 =?utf-8?B?MlhzMHpXUWNxb3dLdEZ1YmtFVjFVSit3cjI1UlpxQWtnTlY1K2JnVjMwaXJ2?=
 =?utf-8?B?ZEdWa2I3WHdoQ0RyeXIreG9zbHZmQlVXTDlIZUlPVitlUkJ6Z3dSNm8wbW1x?=
 =?utf-8?B?bTlldi82WFRaSmFQSW5NZWpRRldqSXpYSjRFNzl5MTV1VENrUnVpaWV3cjZH?=
 =?utf-8?B?V3Q2VU1TWmE0R2d1VkVhVDlYaVdCQTVUYVprZktqQS9BaEFoU3VEVllUYXI4?=
 =?utf-8?B?R2dzVjNlN3Y5NE96OWlyNm12djFlQ2tyQlJ1ckVVNVhOWVNCVkNxTlJKTnhQ?=
 =?utf-8?B?TysvTjFxcW8vejY0bk8rSndYbExhMGE2R1ZKSUx4ZHJNK1BTejliZVh3Y0d6?=
 =?utf-8?B?QWM2V0taaFVsZXY1NWJLQjBjaDFtMUVRV2ppc1lKUHBCZ2g5c0FkZUc0Y3cz?=
 =?utf-8?B?eENranhaYkVyb3BWcWM5Sm05bUpObmFXOTdhSkNlRm9jY1pWT0FlNFdCbXFI?=
 =?utf-8?B?UGRxbUx4aUlTR2lGNE9neWVWS2xSQ0ZzS1pUM3RjZDcrajF0VmQxbWpzWjly?=
 =?utf-8?B?bFdtNnBhMy8zZm5DVEdUZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE84bit4bUN1eUpMbFhHcVVPajdXWmJUajlYUlFUakxyTzFPUFdsRlhENk93?=
 =?utf-8?B?OVhRYXY1cDNVc0JoalI2Q0hlR2FmRDEyYld6RnZvMURpYVZxcGVFZmt3aTlR?=
 =?utf-8?B?VkVTRGhDMUwrZkh5NHl5NXpOWGxHTnlLa25iUkxnOURDSHhxNm03UnloYi9s?=
 =?utf-8?B?UUFIekZJa1p4eE5LYnl3QUw1blg3a0xOU21TMTZRZFdCWkZCRk0rKytLYlBl?=
 =?utf-8?B?QUdzdjlydi81TnpneDJ5SWFqdG9PV1Y5UkJ5UHhSUklqeWd0UmlMLzMvSFBH?=
 =?utf-8?B?T0tJMEo0K0EzRjdsUWJSWXJmMTVSaVZhdnRncUxJNzlTOGk1VUY3QTRsVWd5?=
 =?utf-8?B?WDkweHdJVVhycWhUdU1WeHd2SkZLbGNGYk95d0xYdzFmOCt3UG45Yzh4dy9q?=
 =?utf-8?B?YUhwY0x5MmlGZE1KSWN3eksrcnZZTVJpT09vbjBpdUs0c2lOSFlJNm4yVzUx?=
 =?utf-8?B?OCtSeHZRL0FFdmxsYktHZ1dpaWdDWDArbDRpbXFDS1pKU01vdVBNcytLYVkz?=
 =?utf-8?B?YVNZZ243cUtydm9LQ0d3MWZKUlI5aXZRcTd1TUw4RkRtcTV6dGhvNFFCTmJX?=
 =?utf-8?B?Umg5Mktxb3RnVkFSNFJ3U2VqeHlGNEpiaUwwV0pMdlYremZiSldUbk5WZlIr?=
 =?utf-8?B?RkJDOVY1NlFSTXU5OXdmeUJJZmcwYm5vbXEwWjV2Nll3Yk1FZ0F0cFMySFBx?=
 =?utf-8?B?YW1lM3cwaVpnbWUvTEpvV3U0K0NNRnBZeFFrU0ZxajBHbDFXUGJ6dzN2K0Iw?=
 =?utf-8?B?TkEvRmpQVTlpS2I1ZHRvUmo0V2tuU1B1cUxDT2ZwUDUvQWdwQjAxbWhvazVm?=
 =?utf-8?B?dWc4OVhuSFNFVitlWlpzb3o1NXg4cS9iREp2OTZWQTloaWR1MmEvOWl2a3U5?=
 =?utf-8?B?ckQ0MU1WNlJTdDE5WmZXK0ZZcWxWWndKcWNTeFpkRFZkMDZaMTY2Wi9KUlM1?=
 =?utf-8?B?NTFHQXowbWxtcG5LRGFOUWJvSXduc1BkUXdLTmtWMGxHYVoyakRldGM4dlZw?=
 =?utf-8?B?U2dRUUQ5NUZJai9RTU9VQWVUY2dDUUp4WnpJYlpHamJTRDZIbi9EMkY5My8y?=
 =?utf-8?B?N1k2N0piWlE1blFCbzBhczV4SlJ2Zjh0TmdlYVQ0bXUxMnZEU2hHcW8yRTNE?=
 =?utf-8?B?eEpuV3NvRUhiMDVuY2dkMU03dUlKNFkxOExibHgxM1lxTmFCODRwL2J0N0o1?=
 =?utf-8?B?UE9nM1B0V1MydkFLNXVITmorQmVJQWtsdWFnR0YvNUNvZldOSmtDNkhhdXVM?=
 =?utf-8?B?M1RSZzFRYkg4TFBUVTBSTnRUK2NSbnN0NmY0ZzlOTGZXSFkyZWhRNW5tUml0?=
 =?utf-8?B?RkJGaEt0YjdTbk5NUVJGcnl5eXpPM3EzVzk4cEp3bGttK1M2dTRKT05wK2lp?=
 =?utf-8?B?dzdQUWFwdnljQU1jZUhQU2xhV2xrcUZybXVXL3R0WEZib3l3cTFEK1NaZUpE?=
 =?utf-8?B?U2tpUzMxZUxaK1NsMjREV29KYkNKMU10WklMVHpheTJOZk1yNnplY0hGaEhp?=
 =?utf-8?B?ZGJ6T1FTc2d6eDhBU2dyVDVuZFZMejV4S1lSS0duUnFQQzZFczNJVWQ1a0Iv?=
 =?utf-8?B?Q0xMeFM2YzdiQ3YrZDdPVkZud1cvZ2QrMnVtRXBUdDZsbTZZTzNhODFGUHFL?=
 =?utf-8?B?QTNMNGIrQmtVOFNvS0c1VmRHaTgya2NUbXpxRWMvbm5MWjMwMEZiTTdwRU9k?=
 =?utf-8?B?MUUxZjh1S2lxVGN5K2N2ZXVHaFFKU3VpenFCa05rNG91WE1FYkg0R3RaU2k1?=
 =?utf-8?B?eDBXRUhUZzVFdmRwRUhuQ21NRlVpTmtmWnM1VHFwcW1JbmtyQUdjN1RJUXM3?=
 =?utf-8?B?dm00MFRGK2QvR1daLzlZTUgxWisvc01oeTNGR0diREQwbzVoVWg0Q3ZjZFd3?=
 =?utf-8?B?d3RxM01sam00TXBDcWMrT096NDhSVkVBVURvRU93a2k0UU4yNVl1SjN2MHRG?=
 =?utf-8?B?L1lDQzBHczN6SDFTbTdNQTRHSFI1RXpLTDA2TVNoaDJZRWZyRGFvdm15SHU5?=
 =?utf-8?B?VWxLcVVabnFMV1YxcDFkeTdqTmt4dUlpd0htQ2hiR0NsMzF1WlpwVlcvOVlh?=
 =?utf-8?B?OUsvRW84VmsybzA1Nk9FVXJwT2laM1JVREJVT3hnb3RDS1RtNlJNL3JxdHhy?=
 =?utf-8?Q?LdyLCZFfcD5AfGrVPDNEh4kRa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e946cf-5c6a-4f14-8d99-08dcbca9c10a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 21:40:46.2325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSECrtiwzH+GlJ9u7Wf6Gfof0IkorSs2+4AenNCdiYNEAjlbjgmU/ULvRTR4zQzGfFMrhadENUKC/H06ZSPj2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741
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


On 2024-08-14 11:17, Alex Deucher wrote:
> On Wed, Aug 14, 2024 at 5:15 AM Rahul Jain <Rahul.Jain@amd.com> wrote:
>> when trying to enable p2p the amdgpu_device_is_peer_accessible()
>> checks the condition where address_mask overlaps the aper_base
>> and hence returns 0, due to which the p2p disables for this platform
>>
>> IOMMU should remap the BAR addresses so the device can access
>> them. Hence check if peer_adev is remapping DMA
>>
>> v3:
>> - remove iommu_remap variable
>>
>> v2: (Alex)
>> - Fix as per review comments
>> - add new function amdgpu_device_check_iommu_remap to check if iommu
>>    remap
>>
>> Signed-off-by: Rahul Jain <Rahul.Jain@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 +++++++++++++++++++---
>>   1 file changed, 40 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a6b8d0ba4758..040c75c491cd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3952,6 +3952,25 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
>>                  adev->ram_is_direct_mapped = true;
>>   }
>>
>> +/**
>> + * amdgpu_device_check_iommu_remap - check if iommu remaped BAR
> change this to:
> Check if DMA remapping is enabled.
>
> since it's not just the BAR, all system address space accesses will be remapped.
>
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * return if IOMMU remapping bar address
>> + */
>> +static bool amdgpu_device_check_iommu_remap(struct amdgpu_device *adev)
>> +{
>> +       struct iommu_domain *domain;
>> +
>> +       domain = iommu_get_domain_for_dev(adev->dev);
>> +       if (domain && (domain->type == IOMMU_DOMAIN_DMA ||
>> +               domain->type == IOMMU_DOMAIN_DMA_FQ))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>>   static const struct attribute *amdgpu_dev_attributes[] = {
>>          &dev_attr_pcie_replay_count.attr,
>>          NULL
>> @@ -6127,6 +6146,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>>                                        struct amdgpu_device *peer_adev)
>>   {
>>   #ifdef CONFIG_HSA_AMD_P2P
>> +       bool peer_remap = amdgpu_device_check_iommu_remap(peer_adev);
>> +
>>          uint64_t address_mask = peer_adev->dev->dma_mask ?
>>                  ~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
>>          resource_size_t aper_limit =
>> @@ -6135,13 +6156,26 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>>                  !adev->gmc.xgmi.connected_to_cpu &&
>>                  !(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
>>
>> -       return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>> -               adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
>> -               !(adev->gmc.aper_base & address_mask ||
>> -                 aper_limit & address_mask));
>> -#else
>> -       return false;
>> +       if (peer_remap)
>> +               /**
> These don't need to be kerneldoc comments.  Replace /** with /*
>
>> +                * IOMMU is remapping DMA for peer_adev so all accesses
>> +                * should be within peer_adev's DMA mask
>> +                */
>> +               return pcie_p2p && p2p_access &&
>> +                       (adev->gmc.visible_vram_size &&
>> +                        adev->gmc.real_vram_size == adev->gmc.visible_vram_size);
>> +       else
>> +               /**
> Same here.
>
> With those fixed, it looks good to me, but it would be good if Ramesh
> took a look as well as he wrote this code originally.

Looks reasonable to me. But it could be refactored to avoid duplicating 
a bunch of the condition. Maybe something like:

	bool is_large_bar = adev->gmc.visible_vram_size &&
		adev->gmc.real_vram_size == adev->gmc.visible_vram_size;
	bool p2p_access =
		!adev->gmc.xgmi.connected_to_cpu &&
		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
	bool p2p_addressable = amdgpu_device_check_iommu_remap(peer_adev);

	if (!p2p_addressable) {
		uint64_t address_mask = peer_adev->dev->dma_mask ?
			~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
		resource_size_t aper_limit =
			adev->gmc.aper_base + adev->gmc.aper_size - 1;

		peer_addressable = !(adev->gmc.aper_base & address_mask ||
				     aper_limit & address_mask);
	}
	return is_large_bar && p2p_access && p2p_addressable;

Regards,
   Felix


>
> Alex
>
>
>> +                * No IOMMU remapping so make sure the adev's aperture
>> +                * fits into peer_adev's dma mask
>> +                */
>> +               return pcie_p2p && p2p_access &&
>> +                       (adev->gmc.visible_vram_size &&
>> +                       adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
>> +                       !(adev->gmc.aper_base & address_mask ||
>> +                       aper_limit & address_mask));
>>   #endif
>> +       return false;
>>   }
>>
>>   int amdgpu_device_baco_enter(struct drm_device *dev)
>> --
>> 2.34.1
>>
