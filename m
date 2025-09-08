Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC68CAC581
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 17:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D842010E592;
	Mon,  8 Sep 2025 17:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XIBMTWSY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D191A10E592
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 17:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEwAKQgCaNwX7L4x1OJ1G/PnEJ1PllBOIUWeExTXkQp7LJ0Ccd5NSXHFqBBMgYNX44ZjlIuBoX8iOELeoxe7NFiDzhDdK/G3NcAPZ2CYl6pkU6VPcnN8xagZk1/EnQarc+ztsVILqAEUeEXc8gE344tGTHhH6pe9o59k3+8SFPOJvXIxqcPw+HM42saDcZgArAWP/0fB484Cvqi+Q9B/qKqy6sBz8V9lrq/KzgLLRqw368TOAlDpfCwdRh1IvmAI2qQaq7a2NhcntC6zk5AK4qaVJ5fi6FV0Ub54cuFSJx8rNqAttS9pstgNI/rKeSyGPNiYu1gOka4TltWrw2ZQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLdR5C7lkpq9kKlD3lVS5eSuDDehZ9nSmCOmilv84mg=;
 b=R/+8Kaf3xzihsJUQoj4KqtBbrkvVUE+7H4ijQrV5+QHcLhRxHQyvX9v6w901ZoFDwQJ798LyhwgEn8SVOwpvFmMlMMqiBA/IxoM6laGphUm5HvUeTrv7Iit+HNDXx4ElGXorAgWOCwcecwFQVQXHjpFo2l75ehfj6HDmH/hECuOpnviywpA8zkoZAxalKrE2WkVVxpLGAhGwePkBuMHkqnGjBKgjBPEm8lGsPkvediD0Gskwm9ETTr0c+ZwBHyGpqR+RM0FAfn0UYwQBsdAKfh7HpVLqpiMEIU1q+MSUqMSLd7MEayfjxy73JKIElt1jPN3DO9b7w3P/+WUU/i4Jwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLdR5C7lkpq9kKlD3lVS5eSuDDehZ9nSmCOmilv84mg=;
 b=XIBMTWSYvE5wr6mIb6/29hLs3rme8+JsPtETy15+Y7+wHg9Pyu0Deg557Mpse6HHhkELbDxHrTl/mY5/rO6cH5TFhnHO7CoE506wNZsCHDVgZpFIf4x2M8L2hb5q9ZbLBRtjOs2hRf+vdxYM+laymAodRQXmtRdJntoQr95Agos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:40:39 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 17:40:39 +0000
Message-ID: <44b39851-9775-4bb8-9558-3cd4f298120c@amd.com>
Date: Mon, 8 Sep 2025 11:40:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 harry.wentland@amd.com
References: <20250825213333.612600-1-timur.kristof@gmail.com>
 <CADnq5_NwQCGgsgVZ1T3ofxrLJhDkq0FO3GKOViWtn8JhFC+vfw@mail.gmail.com>
 <32f1bfca9b0deb97084390be7e44a47bd8265f04.camel@gmail.com>
 <CADnq5_MnBztaCye3fEgT17u5A50ZVCKsm5T4qLy7KCF_s3gRwg@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_MnBztaCye3fEgT17u5A50ZVCKsm5T4qLy7KCF_s3gRwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 7612a47c-7f23-42ab-5b24-08ddeefed385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHdQTXovOUY3M2UyZnJpZlJ2Z09RSDBCVTlHMnRtMG0yekJuV1B3b29VbFJC?=
 =?utf-8?B?cTVnanZYb0w4UmRoenhQYks4aHNBZTJ4R25mQktKTEhtb1J4OTJkTDl4dW5Y?=
 =?utf-8?B?bHdmWE0xcDhhRC9FanI0VkJabXREQzd4ZWo3RGVBQ2pLQUl5RVZmdFJiM0V1?=
 =?utf-8?B?QVh0dEpHL1cvdm9lUUFzcmFVSEZHT01jVWlMTE5PKzVqenZxZmJ0bkdUSXJM?=
 =?utf-8?B?RjBvZDNzaUNBWXk4NzQwWHRmeE95V0V3MnFDUDFrTTlIbGJURC9ZUmxoOGVW?=
 =?utf-8?B?VExiZXQ5QUMyWk5WMVhrNTM3UUcweDY5MWhMaE95NnFXSEtqUitUelpqOTE4?=
 =?utf-8?B?NTRvU0RpS3NZNzREdGhzY0NPSTdzbmlKUXZXVncyKzF4TGxwMzRwSmNPT2dY?=
 =?utf-8?B?Y2FXVnAxNW16NEdYTmpNN1lzRldzME5wdE1OOHNUNlppaWM4RTVGbDdjZGcy?=
 =?utf-8?B?Z1FnT28xTGJEUVl6VFk2blViU2pKNml2ZElWTlU2VldBUldqNWRBVXU1L0pK?=
 =?utf-8?B?QlBJRm1oTnB1dGlNa3FramR4OWNFRmFoY3VsaGJQa3RZODZmVFB4amZkbTYv?=
 =?utf-8?B?a0l5aWtBZ1FrK1BiN1RsaU8vNjNUeEZNMlROS0daQWM3d1VHQVpVRjdEd3ZB?=
 =?utf-8?B?TExnS2hQOFA0S2ZlaGszOXdDalRwenRsRVY0TUNTZFVwVUd1Q2R0YkJhMm5H?=
 =?utf-8?B?bXQralRyT3dET0tqNVp6dEtNWURLL2VWdWpVSUdBeitDUFQvZ3JMVEM4enZp?=
 =?utf-8?B?OHdlRWt1eTdKaDllSmJwR1NOWkUxejA4YWJ0dEZBa2gxRllZVEZPK3lJTjlD?=
 =?utf-8?B?S0kzZVcvdzJYcTVQWHNkWG5zUDR1SEhEN1B1clA3OURocDQwdHMxTlkzTFBK?=
 =?utf-8?B?SFJid3VTMXkwQmhxTEl2dWUvQzUrMm1tZ2VHaUN4dGtaUkxxUVF1bmd2NTY1?=
 =?utf-8?B?K1lrZy9wZS9qNGx2dXJyVUlLSTkyOW50dm1ydE8rTGgyZkczRDd6YmVLcXc3?=
 =?utf-8?B?YzVERnRZTDFsNmgxT1lyNXMyM3I2MW53WXkwOHF5TFhoaUF5OFVWdGt1OXlU?=
 =?utf-8?B?eGVWZ0orcStkblc3K2JyL2NQNlpjOHcyWE5SRXV2bGxCOFJxQ2ZjaTlkdXR5?=
 =?utf-8?B?SmNVUG5jUUFHcFQrWmtTaW5SUndnd2pJT3RtdTBKTEN5bDhVVi8vSDZvK0cr?=
 =?utf-8?B?SlJrSTF3Q2gwYlVoSnZjWExMaVgwMXZnUlNUTlpQc2ZPbXprRGJIbG9LRzhy?=
 =?utf-8?B?eWp5UlJCVmVUaVh1Tk9IYkxwaC9nYk5UQ0VWSzhpUWVYN1E2NjRTZzBQNjBW?=
 =?utf-8?B?aW5kcGFqbzN2REJSbUFFZmFxc1hFRC8yQUt5bHNFNUR3ekFkV3B1SVRZNDFV?=
 =?utf-8?B?eE9ZQnBic2RESElhNWt4Vk1zWlRZR1FPblZhdit0UWlyNGZZbHIwd1VVL2NX?=
 =?utf-8?B?NzE1R3l3SlZuNnI4b2kxQ1BNMWFrVTRmMWcvMTQxa2hRSjZKNHJqalkyc0FN?=
 =?utf-8?B?Wjk0OWlrUDNNWVF6ell3azMzUEpnSjd6cjJ4NVVMU3RUNmNEUHZvNTNod25m?=
 =?utf-8?B?TnlJNWdFOVlZNE1YVFQ2ckR0OUhhcVdvYk9hQXQvMldOeVdNTFVROG1rK3U1?=
 =?utf-8?B?UkhjQW43U0lsdEdSR0Y2b0hBTUpVbzJEaEJ5TGtKUjdraWFUYjY3YnhhZkpY?=
 =?utf-8?B?Nm1oRVI2U1REZjZMbDhwbTNXY1l1K2gvSlBheElhZ3FPWG1FV1B1clBQbFMw?=
 =?utf-8?B?bUdJN1Npa09tbkVlTWFSd2JJSERTczg0N05QaWNhNnNVL1Z6OTZ0bHpoeTNx?=
 =?utf-8?B?dlFzcDVPaUhCNmQxMEZWTExud1R5RzlCcmlEZ0FzV3dFQmFzQWV6NzcxUVRH?=
 =?utf-8?B?NS9jTlN0NG5QK2F3NmNkeWhSdlpsRHpnUGpRVkh1K0Vta2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVCcWR0dGxlWW4yTmRnandzZnh2cysvdm1jWGlVUTVOazdvVFREaytSbDUz?=
 =?utf-8?B?KzF4THU1bEdQVGJKZnFkTnBtSDFsK0srNThQT1Q4Z0hKeUJRUDZPelJUejky?=
 =?utf-8?B?R3BQNHZHOVVaMitJRXR0cm5hZ29BZE50RThaYXZwMTY1ZVBnOTNJY2p5TGRJ?=
 =?utf-8?B?ZnJidTdFZHdObDRoT3NPM2ViQUhsZmc1NmZSKytDZXd2c3pZbTBheUN6d2RQ?=
 =?utf-8?B?aFpiUlQzMEVuUjZ3cHViWHRFYkhhMjNSczAweVpmeEQrbTFiTnVXckNjcXRB?=
 =?utf-8?B?c0dUZk9UbEhUeVdXeDllMmZWRS9JeFBzaDV3ZVBlaHVBOUxiRjFGWE9NK2pt?=
 =?utf-8?B?bk9PZHAzRVFsZUkySzhab2dTM2w1aThBMnBLa3l2UUpyckdPYWJlSGlhaG1y?=
 =?utf-8?B?S0FvTmExVk1Ea20yZzdDMUtvNC8zVjF3REVZY3daejJOR1VkWnRLMStYVWJv?=
 =?utf-8?B?Vlh1djB5aGRnQzhrVXVSTzU2U3gxTFBxZlIvVjlLUU9JTXlTUndPdnozQXFS?=
 =?utf-8?B?Ri9qbnFRYy82VEYxVUdBcnJCOGVoOFRZRVVxTDRCMEVJWmkzMTdtcC81NXNL?=
 =?utf-8?B?RXRSc2h5ajEwSjRTUTVRTEJJd0dqQmZ0SlhtWnprRHVMSStYY0hrZUh6bTU3?=
 =?utf-8?B?ZkExZ0xSQ1ZaWXNCa205eDdrSXhIYklIY3N4VFFFTTNnaW9yU3BhQzVsU01J?=
 =?utf-8?B?K29KT21BejlFckJkd0JTTGRiQnNlL3ExL3ZuN28zYU5TTE9iQklpTW5zRGkz?=
 =?utf-8?B?RmNCT1RldHcvSGtwQ01PWmlpVTQyU0o3bURJRm01cnJhNmc2b3hCTktRUGFz?=
 =?utf-8?B?Nkx6d1M2NGxucmdrV3d5UmdOZ1g1Y0pLUVNNTzhIUUtld3hkdy90b09BZjRx?=
 =?utf-8?B?NmM4UDdZeVBtamhwT2NIdHNIbUZzdkN0SUxvYmg4Y0hjQ2NwbUxnaC9qRjNi?=
 =?utf-8?B?TFMzbU1mQ3VTMG9tVU1lSERiVU9kSnp6blRlcEU3Q3laMDFMSjVkTUkzMFpF?=
 =?utf-8?B?WldsaXZrQ2hwTGlDSTVySlhRbnd0d3ZIekRIaCtUTFRoYTg3MERYaS9vNWFQ?=
 =?utf-8?B?Yi96QldmdWdzbldLcUNMZUhWbFk5Rjd5b2hDZEN2VHZNRTdldW5RZFVuc05O?=
 =?utf-8?B?RmYwMWd1M2RiZkxhT1lxYTlaNFIzUVVTd3JsV2NVUW4xMEFYUVY3b2F4UUxk?=
 =?utf-8?B?Q1JQbG11d2tqdVgyUmZ2bmdDVHdnWk5hSEFxRzliYUNRRFR6TFoydmp3aFlr?=
 =?utf-8?B?L1k0dzFDUFlrcktCUVhZN3lVQS9mVmk1bjBqcHd1K1FGRXE0UUhnY3pkOWFT?=
 =?utf-8?B?WUlHZDNRelFseVZHQ2w0L2RqdndPYWg1SkQyN2MwN2o5THNEcE9QRTBDWU9R?=
 =?utf-8?B?dUtiVXdlUlNUd2p2clNjRGtsZUpMNjhCODdYZzF1bXVOczl6bkdVVWZ0MkhD?=
 =?utf-8?B?aGp2V21iaU5iaG5XNFZFd1I4azV2N2M1N0JIRmlCWllqZFVXSmwrUlZKUWFl?=
 =?utf-8?B?OGlYdlR1MG1MVGc3RFBzeWF0a1ZLUTc1Ym5SQXhSNU1Ecjd3VDJLcEZnVGZh?=
 =?utf-8?B?V0RxZ09ZWGNRZ3BQYkJFSHZQNUV1QzFSTmpIYzdHTDlyY05MRXhsYlBDV0FN?=
 =?utf-8?B?QkxBY2MxekVicWFnSmpIVVZSdnl0MHo2bWJCMnlFMjQ0MzRIM3BtQUtwZzMr?=
 =?utf-8?B?ZWhCZkdNV3crNXg1TnJiL0FqMEZMeUgrY3ZjdXZMZkpzcmp1K0IxaGVNNTU0?=
 =?utf-8?B?bk1WYllab29rcXJJQWFIdlUwWk40S2M4dmsvZ2NSa0RHWXl3aU01MElKRzEv?=
 =?utf-8?B?Rm9uejkyMFhTVEZBcm1zU3BwSnZJMFczT3dxdkZpV3dWYWlLWnJUK1FCaVFL?=
 =?utf-8?B?dDFUQzZEK3libER2OGJSamc2RGlSa1BWZHRhbTR4NjJyZG8yZmJKUEpPVWpT?=
 =?utf-8?B?b2FjNnVlcURtRVI5RHdhUlhHKzU4KzFHYkRJS2YzUVQ5V2EwRUEvK2lOUmpl?=
 =?utf-8?B?cmlaREtvRkN4YmlRRjR3aDEyZ0taL2hpMTQ1WHltcGN3ZzJKaE9oRXVOMFdP?=
 =?utf-8?B?cjJuUHdUcFB5b283d0krOW9qQ25vTTIwYVMzWWZFVmJFaVcrYWhMR1J4U3dw?=
 =?utf-8?Q?LlOaYQqzg1/rh81FdjCc2kWRh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7612a47c-7f23-42ab-5b24-08ddeefed385
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:40:39.6597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRooJxYUEJjiJW4wHWfWcfX/4t6Slx/gEKEu/7ezvMDCFHwpmE56flZXNYWtDqprYPtGY4HPFZu3ZEHTDPPJ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
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



On 9/8/25 11:36, Alex Deucher wrote:
> @alexhung@amd.com@Wentland, Harry
>   Were you planning to pick this up for this week's promotion or should
> I grab it?

I will send them to weekly DC promotion.

Thanks.

> 
> Thanks,
> 
> Alex
> 
> On Wed, Sep 3, 2025 at 11:27 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>
>> On Tue, 2025-08-26 at 10:06 -0400, Alex Deucher wrote:
>>> On Mon, Aug 25, 2025 at 5:33 PM Timur Kristóf
>>> <timur.kristof@gmail.com> wrote:
>>>>
>>>> When the EDID has the HDMI bit, we should simply select
>>>> the HDMI signal type even on DVI ports.
>>>>
>>>> For reference see, the legacy amdgpu display code:
>>>> amdgpu_atombios_encoder_get_encoder_mode
>>>> which selects ATOM_ENCODER_MODE_HDMI for the same case.
>>>>
>>>> This commit fixes DVI connectors to work with DVI-D/HDMI
>>>> adapters so that they can now produce output over these
>>>> connectors for HDMI monitors with higher bandwidth modes.
>>>> With this change, even HDMI audio works through DVI.
>>>>
>>>> For testing, I used a CAA-DMDHFD3 DVI-D/HDMI adapter
>>>> with the following GPUs:
>>>>
>>>> Tahiti (DCE 6) - DC can now output 4K 30 Hz over DVI
>>>> Polaris 10 (DCE 11.2) - DC can now output 4K 60 Hz over DVI
>>>>
>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>
>>> Makes sense to me, but would be good to get input from display team
>>> in
>>> case there is anything I'm missing.
>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> @harry.wentland@amd.com or @alex.hung@amd.com Can you guys please
>> review this patch? Thank you!
>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> index 827b630daf49..42180e6aca91 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> @@ -1140,6 +1140,10 @@ static bool
>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>                  if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
>>>>                      !sink->edid_caps.edid_hdmi)
>>>>                          sink->sink_signal =
>>>> SIGNAL_TYPE_DVI_SINGLE_LINK;
>>>> +               else if (dc_is_dvi_signal(sink->sink_signal) &&
>>>> +                       aud_support->hdmi_audio_native &&
>>>> +                       sink->edid_caps.edid_hdmi)

nitpick: probably need extra spaces to align with dc_is_dvi_signal, but 
I can fix it manually after this patch passes promotion test.

>>>> +                       sink->sink_signal =>>>> SIGNAL_TYPE_HDMI_TYPE_A;
>>>>
>>>>                  if (link->local_sink &&
>>>> dc_is_dp_signal(sink_caps.signal))
>>>>                          dp_trace_init(link);
>>>> --
>>>> 2.50.1
>>>>

