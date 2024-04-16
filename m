Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F8CC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 15:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A289110E427;
	Tue, 16 Apr 2024 15:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HvU7XNPw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F255D10E427
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 15:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y92EHqKb5u3KPxFhIWe62B8CQwCq+w+Fp+AWahjjXkUtH5bh82hQeCYeQuKul1Sw1/7JRSdKGaPVbeA2IR5vlYUa1+MZMkt9Az7tt9fKmtdhcoRKpkIFE/ogq/4vO/qHqNXNfD8L43u0xeYNRDgFOG2IwO25QHYjgXQsQ8AWzuX2db0pgFTCn4xfyFujUi892Kt0D8ICoPdR1U+OGMFB+WSZDQN6sudlDVsXlq58/BIWK2w47+FGlK59W7vPcTSqHsJbO5Jw7CPMGMNDcAg9QsrStCdm8tuBPc0h6ALp1Pe07QLaJa9/F8WHzNU4NuWEcLx/F4np6STLd2sMOfNaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EJ1qp3/sST3/P9YitKzJdtcWhngAv5JtwlTHyFPW8Y=;
 b=YonXRxcUU8DEIudTxhpltlSNpnRwy/G0S0dbl4eHjgP0XCaCPMlo5h7sF4YdMlkQOYlVJteqyBDQNcknFcKLd0O9bAzAOQuNiUlirZgAg5Shm3leiBkWHDjGcOIb0Yb0Qrq6SP13+wzCRyQB6JdMdGJ7T9oC/pgHMT/U62c1FyupWampiRyLidS3UZl3Siqo5/R8hroXkwJ4JtSkB5HTen5nmJtJBX69C3hHH390GT4tgFj145VNv16myIvIdypyg0F9sakH/Ks19Sir99l7HtCA4EHFfTDVhVYj0rJhpoWA3oCQqJhunhJk1ZY5onaRVbUKSy2XqZjVvVD6g1ZVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EJ1qp3/sST3/P9YitKzJdtcWhngAv5JtwlTHyFPW8Y=;
 b=HvU7XNPwAoc5bYZ4+YG+I2MgBEF1rA5cy+HxSrCRWOvXJYhOSrxOkFsXvIN74A63tqgkfDjo0yXgq36Kfubam8zmqc4tqXtpL8U5jaVfk2SwZov+6+5Byg1yHN5ADch5BkNWbmhUZtBmExKnGIPc9xrd1xHI1rycuCwfOnUivfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:43:16 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:43:15 +0000
Message-ID: <99ba4887-a1f4-4db4-9846-394019b63a2a@amd.com>
Date: Tue, 16 Apr 2024 21:13:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/amdgpu: enable redirection of irq's for IH V6.0
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240416133423.3346-1-sunil.khatri@amd.com>
 <20240416133423.3346-4-sunil.khatri@amd.com>
 <CADnq5_NMw0c5X4MqiFA6Zoyx2NFn1aKffjEun_w7onT6O10UUw@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_NMw0c5X4MqiFA6Zoyx2NFn1aKffjEun_w7onT6O10UUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb1dab2-b26d-484b-67af-08dc5e2bee52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NZt1bld7hNOFfD/+JWBvc7PaF9QbQkT6S0g6C0rd4kVRMvjF2GK8lgzdKwfrCmJAMxwuYYTpR/EugaY5DIM1Gi0pEr2R3o1W2D9L50GtSkSBGmsOAVH6j4TxjOoaJ2dWiJbOyIlQvqsrRyB74MDLRSFE4VBBS+RRRzG9pPPrnu6lsJtn2bV2KLWPlUHXrlWtktmkpBY+B/5kw+ZhOfZqIV8DhbLTdb9cmVSkpPm59DzYQ1pDrThT2rc/kMzM56M+oeVvQMZQlJdzvlFI4cd5Irmgw6GfvETBv/I6M9kuMOblK50oKmTzkWweZlTo+RD72oTvhhzSHX/RS9QGWWlOZpccP4YDMYXHqbh4BLByJQcG78Xh8RnX4rgfv7t5HxxT8Nz1yXUzqeMO/MdIq9Sxxan9IzcMBGi7hnyjFK2VX4QvMcFrINLChioTvH6/rhzV5gwsSOTOrAH2O58YtsrAPNxScvaL3KoZee/ltqClAPMSAKaGTPexOPSB/4VrOcpEiM8vKpebgEaj8Mot+TqUiXwZS7KhXc3HEq+p6vEXnw4uL09/SYNRBBAt3H2LaxYVuIfSnEUtlOCNIzwIl3hDWb5aX8gqrsegm91cxDUMrG5jcWWMtkNYvecLcYxv9sYmi2I6H7UZHdzbqDejXQiJ71KlUsbEQREoBmQa3903eI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU14YS8wc0RyNlUzSjY3Q3I4VitMcHE3MmI3QVVCRkhXMTlJMnc0QUJHY1ht?=
 =?utf-8?B?SHRjNURLYUs1K3B3OGhDZGlqNjJXR0h5eXhyQUZkcHJMb1lkTCtYcCsxYmF2?=
 =?utf-8?B?a0lUWHJzdDdmWHZrQ0JlZmhwbXF4YUZ2NUoxMis0VU5Mem9Kbk5KRTRmMnVX?=
 =?utf-8?B?Z29Mci9qOTc2Q0tLaHh6ajNkR0w3WjlvR2ZWenFyMjJUNmRzSlBpU2hEbXlI?=
 =?utf-8?B?UnRmNGdLUk81cTNPWFlWeC9LUXZOZ3hFVW9tVFlDMXBpNDJPQlF0TUJncDhh?=
 =?utf-8?B?YkVzUzFDSmxkOURzbis2TFJnZENLU1F6RWJnSWhJS0FzSmt0c3NhOW94UFVX?=
 =?utf-8?B?L2VVeXhBMkRrcFk3MU9mNTZlcDgxdTRuaWluczAxQ0xMTFprOU9talJwcUUv?=
 =?utf-8?B?c1JORC9Qcy9WNzB1OXZIWG1BNkJtcmQycGxGTGZkZVozNm1kWmVqQmIxa0Q5?=
 =?utf-8?B?d3MyZkhVRHNNQkxoR0ZvZFczN3RlRTBuL0FEMENsV09VRSt6SnlsYS9RSEwr?=
 =?utf-8?B?dTFFSnI4eisySjExRnpkZXlFZGgzT2JEcHNNY1Z4UWlXblN5U3FrVk5sYzV0?=
 =?utf-8?B?YThXOTMvYTNBTXE2ZU10SzlNKy90a1RENjRvZ0xQSHpVR1Rhd0dnSE5xSkt5?=
 =?utf-8?B?WDVlUk9DZytaTDFlMDU3OW1hS2tBaFJVS0Z6YWZlZXJHd2dJWFlyWGhTa1Zh?=
 =?utf-8?B?L3Qwem51TFliVkhEK2s5aHZWc2ZXSCtYUFJpc2ZaSFU0cG9abW9SVDUwK0Fl?=
 =?utf-8?B?ZFNrQWZhYVdBWWxzNlZrMlNxbjBPbGwvN2lSOUhZZ0Y2SG5hZEhHSWRiRmk3?=
 =?utf-8?B?Ry9lZEIxY21HZlhCbE15NU5BaGxDOUxoVldUUjFLMUs3c3loM3NYSTBybDhD?=
 =?utf-8?B?OVhBUStSWFE5TWJOL2FVVHg4WS9hMDVoVklVOWMrUGtmN1dsR2Q2enNDc2VZ?=
 =?utf-8?B?ZTgyMG14VHBNdG1MVTRZLzhKTVFOS0JseHcwRXVEaDUxUzNFbTVEUVpEZ1Y3?=
 =?utf-8?B?cllTYXZBMlhCUTZCVnM2VWtlQmY3S1dVUlZRM3h4RDZFemdUdFptbTdWUWxz?=
 =?utf-8?B?TDZGa0Y3b0UxVFAxaVBKM1NoY3RVcnZUV0ZycU00dFNoWjhRTFd0SmtsOTZK?=
 =?utf-8?B?d3ZXVm5KTUQ2VWMvWFNVUTBpSXJuZGpCbENqTjlzK2dlUnpxSzVvNDVsVWJs?=
 =?utf-8?B?dXhVQkxWMFAwd0l0VDZzU1daOVV3V0xhT3poczl1cXR6YUNwc1RCWHF3K1FT?=
 =?utf-8?B?UE9iVFRTVzdiNUNRQzRWcHFiRTlZZGJpMWxNVHIxNzQ3S202TkhMS2FySXFl?=
 =?utf-8?B?RWgwSkF1cXhDVWhNcEUvRkw0RXAxaHZvd3E5bFBwVHlIRHRMS1JjRlZjQUE4?=
 =?utf-8?B?RkRuWmNSVjd6b3BxTWxUQU01WlBacytkSFYzWi93N0FTVWRZSTNzMG8zWFZH?=
 =?utf-8?B?TWR3K0VDN0gzbDJCSmltVWhpdFFyOXZPbVdPazk2QUVGWmZNbExaZ0ZNdjdv?=
 =?utf-8?B?d0s5V3VPbTl3TUh6ZUdKZWxvVEcrNVNrVTBmYnhHY3FTZCtISTVuT0dkSnl2?=
 =?utf-8?B?UGtrS1duVVRVOWovMlYxQ0tGeE1ZbUg5OUdsUUlIbmlaSk9qSHRNSGdrRCtz?=
 =?utf-8?B?UzNPV3ZjZ1hSOWRkNkpJZXJoQ0lSS0JQRGUrVGRzdHM1bXhxY3phMVRqcGZ3?=
 =?utf-8?B?dm5iR2VxZWt6OHBoMzBreFF1bDJ3bjc3TXl6VVp6S2ZlNlNqdllJQlpwMUdp?=
 =?utf-8?B?V1NHMUpaWUtFRjhuUzRDU1piaXE1RlR5SEdQK0VVd1JCRU14YnZoa2ovQ1pM?=
 =?utf-8?B?MkUvb0NUc1l6Zm1OdmN5elMva2ZJa1lUdUpjOWhtK3gzMGxVUW40ZmgxOHdr?=
 =?utf-8?B?Q1NSU3diaEYvNk1oVDNzZk80NUZnTDQ4M2JUdHpWV3J3NU92TWhHM2F2dll4?=
 =?utf-8?B?QXEzVVJCSzdDL09IQ0JkVjFSeFoxSDdVK1RpTlJCNnAxU2NLMUt5MXRqMHZI?=
 =?utf-8?B?TWcxQWYranl2c1pSUWlCb3hOcVNrRHRSUGRMNkFadldxcEUyeW9iUURidjUz?=
 =?utf-8?B?VnY1Ukp1YmVJdmZmVFpXSUt2eWJQNy9jUEIzbzJWZ3JWaHNjdWpXUitEMFc5?=
 =?utf-8?Q?qq8K2udlVQcoN/XyDQksViK62?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb1dab2-b26d-484b-67af-08dc5e2bee52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:43:15.8038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssgqaWEC2CAd7X7+1r+Omroc6A07IjXnwT2vzUL6k2WCEpWFLwuvAloTykZz6qgvUuynnOIZGlWn7g2x0UbU/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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


On 4/16/2024 7:56 PM, Alex Deucher wrote:
> On Tue, Apr 16, 2024 at 9:34 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Enable redirection of irq for pagefaults for specific
>> clients to avoid overflow without dropping interrupts.
>>
>> So here we redirect the interrupts to another IH ring
>> i.e ring1 where only these interrupts are processed.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> index 26dc99232eb6..8869aac03b82 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
>> @@ -346,6 +346,21 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
>>                              DELAY, 3);
>>          WREG32_SOC15(OSSSYS, 0, regIH_MSI_STORM_CTRL, tmp);
>>
>> +       /* Redirect the interrupts to IH RB1 fpr dGPU */
> fpr -> for

Sure will fix it when pushing the change to staging branch.

Regards
Sunil khatri

>
> Alex
>
>> +       if (adev->irq.ih1.ring_size) {
>> +               tmp = RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX);
>> +               tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_INDEX, INDEX, 0);
>> +               WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_INDEX, tmp);
>> +
>> +               tmp = RREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA);
>> +               tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, CLIENT_ID, 0xa);
>> +               tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA, SOURCE_ID, 0x0);
>> +               tmp = REG_SET_FIELD(tmp, IH_RING1_CLIENT_CFG_DATA,
>> +                                   SOURCE_ID_MATCH_ENABLE, 0x1);
>> +
>> +               WREG32_SOC15(OSSSYS, 0, regIH_RING1_CLIENT_CFG_DATA, tmp);
>> +       }
>> +
>>          pci_set_master(adev->pdev);
>>
>>          /* enable interrupts */
>> --
>> 2.34.1
>>
