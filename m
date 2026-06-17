Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D105DCD98F0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 12:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B3A10EFD2;
	Wed, 17 Jun 2026 12:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/s/tXS7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FB2D10EFDD
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMEIIhTmpZkRI3+dNtGr05VBSiarYSFx0NiyamN/ngQt7xXJ/QRVLVXwu2LxjKYE6wbgsD/+meW34wXqvYYoz5/+WMXlU5nAegllxzFUWVEjQCH+Y+bl00/tGoR6Ekjakm4bnTA+wVisXplrJcTtLglra4+HQ2sC4KlHU+AauE5T7br0nvx1YMAgYplwkLBbbCIO9h8sBtrRsLbqsliTc+KK+NLghFxAHonYHAkXWYeXKfxuFF6pAfkzKfIh6rcndFpNuzYtl71hdYF6X6Sq+Z6fs/aONynFQWjNlIruVhXsecVGFqxFjAkvhO4Y1kzjrcySTfSDOdpGwThqtPcNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qr2rt6o6x93svllkUXoqX0C4bxewtgFvFglQwBmmEhs=;
 b=wpzrSIjkrlJpp3QS+ORgQTUYFciDYLMqaGztY+RC9s1z/snnG+X3DO6ZqaIQcavgqIYBWxHbrMtuBNaoHTuodtzNHtaseO7K4sISrj8f7/ptorXS8ZWsB3C4ZloxvjxnVrBVqmad/yoAPayn5fA3rEoO9zsFlX7o28uE50TO7i4NWLg5lffnXuIcmsksoVY5yyruAhYwXywKtPwmAoSYwTWdsobecbndmVDQAjmFnnQbT3boK0ObaYXyrUNtGafo+bk3T1GRVS6aJxsXT1BMAiXEYsBNswtE+n3bTMDK77F3C8+cKddt6Ta1ee9177IBK7zylEgMxg3ZBJsYuTKkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr2rt6o6x93svllkUXoqX0C4bxewtgFvFglQwBmmEhs=;
 b=W/s/tXS7nTpW0YZiuLrF2dxZZxCUFwyGzgZQOgt0K8gFoMb4kMgK2x1MEFmtOQqK5XR8NMe+QvX7VtgEZuuEy1H7xRdzyGLspuFdzMJr72rZErVLx0bpQpsCCI10LFSA74huSfwqtEsbgBVPAQ+PWrBVJNnWAX9Iq0y8h+Yh5aE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 12:00:45 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 12:00:45 +0000
Message-ID: <9195d612-ae59-4f17-8ca6-632d338b4851@amd.com>
Date: Wed, 17 Jun 2026 17:30:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Guard reads in pcie state readout
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>, "Li, Candice" <Candice.Li@amd.com>
References: <20260617093518.753118-1-lijo.lazar@amd.com>
 <DM6PR12MB2972C8561FA2EE6A75DD1A1982E42@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2972C8561FA2EE6A75DD1A1982E42@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0050.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::16) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 83415f9f-2440-4af7-5b78-08decc68102e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: /mMJ7bCyUtqiPbDKo8WXjqksw9GvA8MbNZ6McZTAPPXKY9rjDGVI294980xoUlwBQWiQolLIj4D59D6wdOT47tJD7PxLx+3aPuTCBinX/wx4fPnK3oHySHFhUtDl5+IXwHZANEbATr/vrO1Zs/UyfNhQ853zr4ejckc+t8sn2KXtMdoH1ZQYayiq1onZS3RkcpJyQF2P3A9/PtxMmgt7Ci7tIbw9EJ9GWS/3G12OAtG7OsVVHEg4ImZ5Q25VZYjLUgsyk1s1GZAbguF2achzC8XTVlwMPP78wEX5da1pLi9Hnj/F4yHtQNxICUDPHZlenr+DLh2IxoAPV3mVpLqNC+jxeop/7AfP46U9slg0t6yPcSiC9b6diVxotvS9nau6N+Hv+bAwngOeG1dxgYxjKlM8+LYTfwkxey2qkeJ25RWqKeomyBnE8YjMUHF+ZL4NlJWaImF/7lyorsf/v4jwutWQ+OuI/OY9bFnu0W8O8WOBoQkO+7E4yX3krCLNqfUKgOqCR+pTa2ElcI6ti2XEvKWoi3SJGlRfaAjtl5Oce6S7PvURGdZCh5O8MT+GToSKzS3PwX87qD6syQLJ1z3IFWmoFMWoQ6ghDo1Rk2fVN7YecAWoClG3wBFP1a9fuhsmJG5EOMLKzDCeGfXBPJXnvTplUG4EGDpVcLr/3/jzy4Xl3BWBfztegQ8WzHQRUc5m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNOY2NLUFRUUnBLZWxUTDAzYVFLOU1teWgzbUM3cWM0dFRWRVZFL0ZBL1oz?=
 =?utf-8?B?RDFZNGhaNC9xVEZFZVg5ZUdDTWF5OFhQZEk0aW9rWHNZTVFUNEdjc1EyZXFo?=
 =?utf-8?B?eUNmV2M3QjdOeTJVSTBUWGxsbmhwUWVPK0dxTWpOV1pmejZJUDNma0Izbi9K?=
 =?utf-8?B?aTh6WHJJOGlpTi9RbzI0bWlGd3FMVU1TbDRSQ2VoWXkwR2Fha243N1ZlWG0z?=
 =?utf-8?B?SHRsSmUzTjhmeWFlTnNIdUdFUFNjZGNYcFhEMFpBVklMVWFhek5PVTRXdGlG?=
 =?utf-8?B?WDVqNEpXM0gwaU5vb3k5d1FrMXU1dWxYMlVld2tUbUhwako1S1lZajFaRkV1?=
 =?utf-8?B?WllQUC92ZU04eGNFdHQxU2ZjYkUwS0REaHVqSWJKeTZBT3JIWlhXM1hNbUFU?=
 =?utf-8?B?YUlUdlZVYWlUK1pTZlhjQWtJWWxHZkRTbTBORmtXbHZ3d3NyVmRxeVE3NFlM?=
 =?utf-8?B?NW9RUmdxR0JtV21jeUxkSWtpNUgycEpBS2N3WFpiQWxwU2lvdFhUMHl0VlZz?=
 =?utf-8?B?OGdlRG5KUUl4QWgwazRBT2R4dHlYZVBCOWFvVEFlbC9SSzBrM2VPZnpYN1ZS?=
 =?utf-8?B?aVdlTVdRSEw2RWFkSldNOHVpaDVYTnFEb1E4R0puWkRyVENkVXVYRTh2OUxO?=
 =?utf-8?B?UU1EOTdKQitYVXpQQTExbG9uelVZS1AxQzJjVkpwK04xU0g5TzJOTktqazZs?=
 =?utf-8?B?UlJxUXF6NUt2eTBYSmZUanltL0ZVamV5TllLS3BiaGRxQ2NSRkRJQUdGclRO?=
 =?utf-8?B?UlV5ejJEb0xqNUZZMCtxOU16NlNONEtkd1NERnh3Rkd4SVl4cUZsL0syY1A4?=
 =?utf-8?B?RVBYbDlhT1hxQ0g4cVJQYmtyM1B1aWZLQW00bUU3TGhQY0lLbDVjWnkveEVZ?=
 =?utf-8?B?M09OQzU2T0NYMWhodmpTQm9vME1DT3p5SE5JOTdPYlBNTnAyWDg5R2N1aFVK?=
 =?utf-8?B?TExuRVA4VHhRTnN4TlhSeGNKdUwxMGlSeDNmRDlUSklka0lNVDdIeXc0dGsr?=
 =?utf-8?B?bkpwcHYrSzUvaE9PeDY3RFlSVTVCa05BUDg2MGtZTm41azZCQjZwbC96N3p1?=
 =?utf-8?B?elMvcnRPSklNRkNlV3lsdWd0S05OREVPTnJwVjFMcjFmK1ErbFJka21yUnl2?=
 =?utf-8?B?a25FL3lJUkFWYlZJSlJURjUxTDVFb0tjYjc1Z1JtR0h2UVhTQm9vSUJrTEU1?=
 =?utf-8?B?SXdhUWhub1cvRVRwaGtaM20wOVoyMEVWVzJFV2c4Vk9RZUIzZDgzMDZ1M0pN?=
 =?utf-8?B?TklHTVp2TG9BMjZmamVGcG5ORGFIdU5pVWEvZk5ucjBYN0hBRGxmK2J1eTZm?=
 =?utf-8?B?VllHT3Z1L0J4clArSHFwSVYySWZKaFp6Y2xyaENwK2NDc2dkQ2hSdkRqV3dS?=
 =?utf-8?B?SDM3eWg3QUsyR2dLdlV6L1NCQnYyUlRmRkE2Z0wyUTg2Z1pFT09oYUdZNWl4?=
 =?utf-8?B?Sm55MG43T29wQnhQL3hjbXc0ZEo0QzBlRENNU1lLRWNmeXFXSEpHQmZ4b2M1?=
 =?utf-8?B?b0VrSHRBK0o3Z2lIT0dpejBEdjlaUGhuZ3IvVXFjR3p5dVNjOWVMT00zN2hx?=
 =?utf-8?B?MWx3bkVGZVRlMCtHR3hOYitHWVNuY2tGSnpacnl6WlFGV0lJSlVXK3hOd0NC?=
 =?utf-8?B?eGNuZVNoZisvY2I3SWEvc3NuRi83eEh5TTloOGl2N3RyWkFDUFhkUEQrM2cy?=
 =?utf-8?B?OFBjK1JOZlhIUXVzTXNqbUpEUHl6MzJzcGYycE9yT1JRL2dxZU5aWjJnd3l5?=
 =?utf-8?B?REFVZjg5VnJqc0xGOGwveWpTWXUxQjRkekhrREh4NmY1cDFqY1d4TEttUDRJ?=
 =?utf-8?B?bVBPZkJVL3UvVkhjdHpjc0s1U2Y1TjV6U3NmT21PNWl4b3lCYVg0cnVUNUhh?=
 =?utf-8?B?SHd0aU8zcG96YWtRNEFkaVc0S2FUWjNBeUZFN3doQ0ZFMlRsZTc2cjZIbldh?=
 =?utf-8?B?Z3hOc0VCdHBHQlRnUHExa2pIT3k0V2x5MVNCM1l0eGsvQnFRYVNpcXcwTTFz?=
 =?utf-8?B?Nk1OOTBzcWV6YzMzUTdOc0JqTTd6ZFQ2TUNLV21NVFlMY0NkU3ZvZHZodUhp?=
 =?utf-8?B?SFB3NEdKTVhKQ0NDS09pczVaclFjVmxUZ3lEM3A4VCtydUVMQllENmRnRjFK?=
 =?utf-8?B?Nk9mSXA3QzhWTHVzS3dtWTRqTkJVT2J4QmhrNldBNWJITFlwaE5mZWR1THRH?=
 =?utf-8?B?ZnllcU9keUhNb2ZLZU5MekYvTmg2aUdRNHJrMjNEZXRpeCtvZ0UvQW8yUTNB?=
 =?utf-8?B?YUlacG5VQTdBaXMwbWMvOGR6bFNKZnFYSmRFRWo5eUQzWERzQytreEpocHlG?=
 =?utf-8?B?L0VzemZycWx6ZUU3b2E0SFJ4WFhueDhPRHcrOG0zRS9DSm9hMXVNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83415f9f-2440-4af7-5b78-08decc68102e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 12:00:45.5181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSVw3dCmWp0bcZZDeRhSpWbdmbtpb5Af67/7TvnAHuRUZxGP4kGXW5Qi9bB1dKhq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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



On 17-Jun-26 4:01 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
> The original intent of this function is to collect the real hardware PCIe state from the AMD GPU's internal upstream/downstream switch ports.
> 
> However, under QEMU/VFIO passthrough, the guest-visible PCIe topology and PCI config space is virtualized.
> QEMU/VFIO can intercept, emulate, or selectively forward PCI config accesses, so the upstream bridge information seen by the guest does not necessarily represent the real hardware topology or state.
> 
> Therefore, in a VFIO guest this function no longer has practical meaning for retrieving real HW PCIe state.
> At most, it reads the virtual/emulated PCIe state exposed by QEMU/VFIO, which may not reflect the physical device (which depend on the implementation of QEMU/VFIO & kernel VFIO Driver source code)
> 

This function reads mostly the endpoint registers (mostly SMN) which I 
think are not intercepted (driver will have trouble otherwise for other 
reg reads). The particular reads addressed in this patch are related to 
link status for which it needs the real physical link. This is to 
avoiding that particular path.

Thanks,
Lijo

> So, I suggest that it is better to hide these interfaces under PT or SRIOV mode.
> 
> Best Regards,
> Kevin
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
>> Sent: Wednesday, June 17, 2026 17:35
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Li,
>> Candice <Candice.Li@amd.com>
>> Subject: [PATCH] drm/amdgpu: Guard reads in pcie state readout
>>
>> Internal US/DS switch may not be exposed in passthrough. Guard the upstream port
>> reads to avoid a NULL dereference.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 59 +++++++++++++++-------
>>   1 file changed, 42 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> index 72ea37dbfea8..5f1389901504 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> @@ -589,6 +589,29 @@ static struct aqua_reg_list pcie_reg_addrs[] = {
>>        { smreg_0x1A380088, 6, DW_ADDR_INCR },  };
>>
>> +/*
>> + * Return the GPU's internal US switch port, or NULL if it is not
>> +visible
>> + * (e.g. passthrough) or the EP is parented under an unrelated bridge.
>> + */
>> +static struct pci_dev *aqua_vanjaram_get_us_pdev(struct amdgpu_device
>> +*adev) {
>> +     struct pci_dev *ds_pdev, *us_pdev;
>> +
>> +     ds_pdev = pci_upstream_bridge(adev->pdev);
>> +     if (!ds_pdev || ds_pdev->vendor != PCI_VENDOR_ID_ATI ||
>> +         pci_pcie_type(ds_pdev) != PCI_EXP_TYPE_DOWNSTREAM)
>> +             return NULL;
>> +
>> +     us_pdev = pci_upstream_bridge(ds_pdev);
>> +     if (!us_pdev ||
>> +         (us_pdev->vendor != PCI_VENDOR_ID_ATI &&
>> +          us_pdev->vendor != PCI_VENDOR_ID_AMD) ||
>> +         pci_pcie_type(us_pdev) != PCI_EXP_TYPE_UPSTREAM)
>> +             return NULL;
>> +
>> +     return us_pdev;
>> +}
>> +
>>   static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>>                                             void *buf, size_t max_size)
>>   {
>> @@ -596,7 +619,7 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct
>> amdgpu_device *adev,
>>        uint32_t start_addr, incrx, num_regs, szbuf;
>>        struct amdgpu_regs_pcie_v1_0 *pcie_regs;
>>        struct amdgpu_smn_reg_data *reg_data;
>> -     struct pci_dev *us_pdev, *ds_pdev;
>> +     struct pci_dev *us_pdev;
>>        int aer_cap, r, n;
>>
>>        if (!buf || !max_size)
>> @@ -628,25 +651,27 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct
>> amdgpu_device *adev,
>>                }
>>        }
>>
>> -     ds_pdev = pci_upstream_bridge(adev->pdev);
>> -     us_pdev = pci_upstream_bridge(ds_pdev);
>> +     us_pdev = aqua_vanjaram_get_us_pdev(adev);
>> +     if (us_pdev) {
>> +             pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
>> +                                       &pcie_regs->device_status);
>> +             pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
>> +                                       &pcie_regs->link_status);
>> +
>> +             aer_cap = pci_find_ext_capability(us_pdev,
>> PCI_EXT_CAP_ID_ERR);
>> +             if (aer_cap) {
>> +                     pci_read_config_dword(us_pdev,
>> +                                           aer_cap + PCI_ERR_COR_STATUS,
>> +                                           &pcie_regs->pcie_corr_err_status);
>> +                     pci_read_config_dword(us_pdev,
>> +                                           aer_cap + PCI_ERR_UNCOR_STATUS,
>> +                                           &pcie_regs->pcie_uncorr_err_status);
>> +             }
>>
>> -     pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
>> -                               &pcie_regs->device_status);
>> -     pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
>> -                               &pcie_regs->link_status);
>> -
>> -     aer_cap = pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
>> -     if (aer_cap) {
>> -             pci_read_config_dword(us_pdev, aer_cap +
>> PCI_ERR_COR_STATUS,
>> -                                   &pcie_regs->pcie_corr_err_status);
>> -             pci_read_config_dword(us_pdev, aer_cap +
>> PCI_ERR_UNCOR_STATUS,
>> -                                   &pcie_regs->pcie_uncorr_err_status);
>> +             pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
>> +                                   &pcie_regs->sub_bus_number_latency);
>>        }
>>
>> -     pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
>> -                           &pcie_regs->sub_bus_number_latency);
>> -
>>        pcie_reg_state->common_header.structure_size = szbuf;
>>        pcie_reg_state->common_header.format_revision = 1;
>>        pcie_reg_state->common_header.content_revision = 0;
>> --
>> 2.49.0
> 

