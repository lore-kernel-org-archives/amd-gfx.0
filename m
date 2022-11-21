Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213D7C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 16:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2D510E309;
	Mon, 21 Nov 2022 16:26:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5720510E17F
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 16:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxNSQBm9Jn3Yp5fBzL7pK4vvEbjZjVZ7whcYY7gNXt4I2IOyatzpDUmxt5vlNo3Ph2apP+PsBVXble+4cH+IHV1MYGWIjGdlFdS/LIPtLPZNwLkAqxTDosrJw1+KxlvdtwK7xzRz9jgRTRUWljrb/T8vsGAsV2dweXJIsRbk0EhzD5rnx1Tdg3X6w2MtOwrDQBgdasuv4eJe8jycXH8y19z8+AEJw5KcJoxMqHpkU2wNKypdQXCHGosRBNFhNGu8DqKPVaojP6fny+2mxP/d5QGRKIYuT6UDxtwCetLurRYhtkSH/NKComaELzgapfPysbfUYF5NQAS31Gs3Y509kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W2smn7DKU7vW+NfKBP0E1l60HYEcxBA1fArL6a2+7Y=;
 b=gn4sD2yIkTaRrzYlhowfNw+NOth4BbfrHkiY0dE/YeGLImrKUDVvkNBcN2RFyhYCj7U026/3Hcx41JzzMH9ALhCEC7vNPlUQXOhrUuJMi+g1s43W9cXMD4hSzLcYN30nnssxxvUswZGihsfOk8tPXEN8gZHbD/ZThAJ+B1OQeUa3NUOhgVAOTevQsHCcRsIhOU4gHy657IdgWSdT1vNz0lQeZ2r8DrnLKWn2ZWuFywQqMiJeOabNtvwF37MO5Til7Qi5x0fP0zPuRopK1HCh2wkxEObBm4ARTpScoMZRIGn6USkUaADPjwpRze4errFrmjy2UMR0Px0aC0N306G74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W2smn7DKU7vW+NfKBP0E1l60HYEcxBA1fArL6a2+7Y=;
 b=uzCXN2G0sRQ2qMM2keTejCFK33gH8g5EOvVdygww4Ge+RLxgJMTu3pTJ2IAoeax58D9YLETjbKyGTLDWzaE+6LoLqoQcbF1s3shvXEXVz+eaXr6wQh0VEKb6jffz92RbIiGj6tLs7UurEDW6GoYYNZomEwoEKp2mHkWF7h03D98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:26:15 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 16:26:15 +0000
Message-ID: <28c78efd-a139-1339-fd1b-442f80708790@amd.com>
Date: Mon, 21 Nov 2022 11:26:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: add drv_vram_usage_va for virt data exchange
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221118025608.612986-1-Tong.Liu01@amd.com>
 <cc27db74-09c4-7b38-f120-acbfa833eca7@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <cc27db74-09c4-7b38-f120-acbfa833eca7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::30) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BL0PR12MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 414ebf60-f56f-4932-9f08-08dacbdd1cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txJDNO4r3SgqegMMt+GaJrdBOy1FbtLbU2iqRGnsKCu9S3H7IcHEm9QcU9+RbSaspp6bSkhudyTO0Nf+jtsbk5/rrRvL5KBolO/rkzdq4paA1p9wm6b7xyWjlZ4ESIDNb39QLgl3VLYcL9x9P/zDmhLvWzqR+cbq2hOtDeE5IStvr/L9lUlmvMRe9E4kO+YG104Wft7lOt9NhPZtGMZudsE7ZJDt8oOTfxppc9KDli0Zhp5yFw0ZgCEbQP5BLVqz3c4pHT9zjwArdec2MPPBm2rCj2P9Tbcvgk6Vt49sIxLZxR//qkuKgiwB89XhlKjZjQpInUqCmo07qTXM6hIMN7eVR/c+dGFqtjaGJvm7K/nipIJAuAron+xMM1p3wGNb7+t96c6kT8TnAd9lu0ERCb1S93ujhKDWg+4GBd/M0Doyp+W7wBSL/ODIjZ4JKqUNUMYvBEMBEDXpiodmqdNGAKC2FMgV+dv5OA8+USWOWyNJTq7Ft0GVl5EWdATKv86ILIlgD/v21Hvr0i3MhRlUFoyEeDxO3ZNiShp7E3oDarLqsB72gWo7N1e7QtiPFjNueblX3oMai1Lhfbjn6ebWkuWzN18VMAGcN1lIJioIuDAY8EtW6S4+Z+BdbW+AzI2ATo6TLE7U9NAhFAusXxf0njJcLDrfbufhGrEK/dRuv4l8JacmC2PDaB0umRS/bgfLtkGOGsSS5lGY1VKoqDHxu4cryPmo/sNKuhKHOrjErB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(31696002)(86362001)(36756003)(31686004)(38100700002)(66574015)(54906003)(2616005)(186003)(83380400001)(6512007)(316002)(26005)(53546011)(478600001)(6486002)(41300700001)(66476007)(110136005)(66556008)(4326008)(8676002)(66946007)(6506007)(4001150100001)(44832011)(5660300002)(30864003)(8936002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2N4OUJuS21Hb1Z4dGp0MUhOSWl3cU5tMnFHNTJvUXJZZCsybE1rTEgwYlQy?=
 =?utf-8?B?N2JyMHNoQ1MvU0MrMFdEMGxCNkVHdmlCVjBpUEVJU1c2S3ZlUGIwbDZFT3BW?=
 =?utf-8?B?VjZvcjNGVGIzcm0xUVgrRkc0WTBRRVZxeWg3d3owVGNsV0ZTR3lUV3lKdnFy?=
 =?utf-8?B?TkM5SG5QTzdVNHVzMEtJSDdPdVhNR0cwcDN5TVF1V3pWU2IzdEUxc29ZaVho?=
 =?utf-8?B?WVhPY3JZNWN6SThuMVA2S01LZHNaUnlmMVN5NVpqN0JucmhpYmhTeGN2R1U3?=
 =?utf-8?B?L3Q4eS9mcXYzRSt6R0Y3V1hmeitIS25lSytKN09PWm5nVkk0cWxPWTBDYVFy?=
 =?utf-8?B?dXJsbEd6MStoNnVrUlNkNmljdWQvQzkyMTRkMlNTVTgxdm1zRXI1UlI2QzBx?=
 =?utf-8?B?L3k3Sk9hSnE2RnFkTzhzYWJ2OHNLcS9tSEZQbDJkOENiMkZOOGczQW54UEdL?=
 =?utf-8?B?dmQzekZ3bDlmbjdZa05iNEJyMUFwbWJoSndQK3BCcS9wS2YybkhjVHZkOWtS?=
 =?utf-8?B?K0NxSGc5QnV3Vzg1K25aYU9tZkNEdGNEcEwrM09KNk5GRjc4Qml1NEs1blFu?=
 =?utf-8?B?dlNOOFVaRzkvZlcvRjR3SlVIY3FqWUt5azhLL214OGM0VUpzT1BMUnd2ODZq?=
 =?utf-8?B?cWg3ejVQWSt1REIzMXkxWGIvdG8wQXdwcklqMkt6VXhZVkVRSnh4VTRDYVBS?=
 =?utf-8?B?UFFycks5MU04WmdGQUllTjRHNHpuQ3lnQmVWalQzRHh0b1BlcFkvUEgxVnFu?=
 =?utf-8?B?Q0x5UTlPRnhFS0NOR0JGQzE5ejVRRzhER0xaSWRQQ05xN29aTlI4Z05QR3hv?=
 =?utf-8?B?VktjVEtVbFZQYWRERmR1ZEczbWdST2MzZUxLaVp6UHZBZW53MlhXK1Z3Z2dR?=
 =?utf-8?B?dnZ6ZjVmUnAvYnducUVmUCtvSmVXbFpiRFB0N3g5LzJ0OU5wZFpDRVF6Rk9R?=
 =?utf-8?B?Q3hUSi80dEVwZVZRTTRTOTZZaUw0ejhSQ1AveVB5RTMvTnJmNjM2OHlFdksx?=
 =?utf-8?B?ZWtGVHZOOUZFQkt2cmdZN2xLcTYyWmdnR2YybGJuM1hnSVFhTkdQekxQNVFE?=
 =?utf-8?B?QWlaWk1YNHlsRXJzbjkrdjVzRHBTZHQvNFN0V1JYYmczWTc4R2JMYkZHVU9I?=
 =?utf-8?B?L3dQanlIbkt2STZFa2ludHNzMmgzSlNLbitxTXhuYkJmazl5K1RDR09zTXIr?=
 =?utf-8?B?ZWdremtYdEdIbVZydGhhLzhhTkZDSW9JRU1Xd0p1REVobFloZTVENHQwWkFQ?=
 =?utf-8?B?WnMrenZaa3paSnk0cS9vaVJ1NGd2YnBoRkRFQnVTS1RiVzNkRHlSRko3MVhT?=
 =?utf-8?B?cW5MVlJmb2ZHalFMY3RCTU5HNE42NWFyMVZEdEJnUDRXVzBsUmU2dEJ5d1VS?=
 =?utf-8?B?d0pGTFdBU3pMZGs2ZDIybU9ZZGEvODhXRVNaVEZoKzVkbGZ0NjNDaktyUWJD?=
 =?utf-8?B?akxXaXRXTDNRQ3FZeWZxeDFsa0FFNzlLRHFKTnJLM3pnd2lQNWJ1TFpjWno0?=
 =?utf-8?B?dlBFRDZmWUlZWGFoN2hTQlhlTzlXanlSN1BHb0xsSlZIR3RjQzlGMkFWTWJ4?=
 =?utf-8?B?MU5ab2lRYVJiell1dVd1MTlUU1B0OFNCTEZBaFEzTENQakhGWTdDeUFqNEN4?=
 =?utf-8?B?a1dRZWFiaFJSdUlxTkdYeElrc3FSdm50alMwVTVMOFJwWi9rVUNIb0lyLzcr?=
 =?utf-8?B?Vk9PMUhmdTZwNnVLSzUyOXhlVUhUeG9pZVZTa09HMFZ4ZzhsWUVrT25taVFm?=
 =?utf-8?B?RFpnUTJFTUxNZTZUdG1jVHZ1NjZmZElHUU9KTHFvbHdubXJKT0w1bStkWjg0?=
 =?utf-8?B?NFZnRW1FcnNXam50OHZKcCtuT1d0My8zdXA3elRuNFg5WHl3cXFuSEpIM2Rm?=
 =?utf-8?B?M2c0bnZaY2xZdHdYSWZRSzVSRy8wT3JWaXFpaHQ1S1YzbWVIaFpwblpXUDhQ?=
 =?utf-8?B?OHU0K2VCZStCdXZ6QW5OQlcvWHFXLzAyTFhtMjJWV0lPdXRxNGZyY0VOZjkw?=
 =?utf-8?B?U3BMVlZOWDNzUmEvL0ZUQzV0Y3ZEL0RJMzU0U3djejFtSjJMdEhpQTlQM2lR?=
 =?utf-8?B?eU5WN1dvTUM4TWMxRVZtczhkaTF6Q1RmZVBBcjhkYWd2TzVTcW93S1NZd05i?=
 =?utf-8?Q?DLi6zWRagM7P1hk+lx3NZHlqb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414ebf60-f56f-4932-9f08-08dacbdd1cb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:26:15.7759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NPBTMrEi3Id9eFiQ/iewQp3HaJ7/Ii1FMrSNHkDAvQJkVC/HTaO8Yodp9yz3XSg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, yifan.zha@amd.com,
 Evan Quan <Evan.Quan@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-21 03:24, Christian König wrote:
> Am 18.11.22 um 03:56 schrieb Tong Liu01:
>> For vram_usagebyfirmware_v2_2, fw_vram_reserve is not used. So
>> fw_vram_usage_va is NULL, and cannot do virt data exchange
>> anymore. Should add drv_vram_usage_va to do virt data exchange
>> in vram_usagebyfirmware_v2_2 case. And refine some code style
>> checks in pre add vram reservation logic patch
>>
>> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 16 ++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 59 +++++++++++++------
>>   4 files changed, 54 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> index 9b97fa39d47a..e40df72c138a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> @@ -104,7 +104,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>>   static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>>   	struct vram_usagebyfirmware_v2_1 *fw_usage, int *usage_bytes)
>>   {
>> -	uint32_t start_addr, fw_size, drv_size;
>> +	u32 start_addr, fw_size, drv_size;
>>   
>>   	start_addr = le32_to_cpu(fw_usage->start_address_in_kb);
>>   	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
>> @@ -116,7 +116,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>>   			  drv_size);
>>   
>>   	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>> -		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>> +		(u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>>   		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>>   		/* Firmware request VRAM reservation for SR-IOV */
>>   		adev->mman.fw_vram_usage_start_offset = (start_addr &
>> @@ -133,7 +133,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>>   static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>>   		struct vram_usagebyfirmware_v2_2 *fw_usage, int *usage_bytes)
>>   {
>> -	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
>> +	u32 fw_start_addr, fw_size, drv_start_addr, drv_size;
>>   
>>   	fw_start_addr = le32_to_cpu(fw_usage->fw_region_start_address_in_kb);
>>   	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
>> @@ -147,14 +147,16 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>>   			  drv_start_addr,
>>   			  drv_size);
>>   
>> -	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>> +	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
>> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
>>   		/* Firmware request VRAM reservation for SR-IOV */
>>   		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
>>   			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>>   		adev->mman.fw_vram_usage_size = fw_size << 10;
>>   	}
>>   
>> -	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>> +	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
>> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
>>   		/* driver request VRAM reservation for SR-IOV */
>>   		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
>>   			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>> @@ -172,8 +174,8 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
>>   						vram_usagebyfirmware);
>>   	struct vram_usagebyfirmware_v2_1 *fw_usage_v2_1;
>>   	struct vram_usagebyfirmware_v2_2 *fw_usage_v2_2;
>> -	uint16_t data_offset;
>> -	uint8_t frev, crev;
>> +	u16 data_offset;
>> +	u8 frev, crev;
>>   	int usage_bytes = 0;
>>   
>>   	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 52f2282411cb..dd8b6a11db9a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1570,7 +1570,7 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
>>   {
>>   	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
>>   						  NULL,
>> -						  NULL);
>> +						  &adev->mman.drv_vram_usage_va);
> 
> Your indentations of the second like with "if"s and function parameters 
> like here still looks completely off.
> 
>>   }
>>   
>>   /**
>> @@ -1608,8 +1608,9 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>>    */
>>   static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>>   {
>> -	uint64_t vram_size = adev->gmc.visible_vram_size;
>> +	u64 vram_size = adev->gmc.visible_vram_size;
>>   
>> +	adev->mman.drv_vram_usage_va = NULL;
>>   	adev->mman.drv_vram_usage_reserved_bo = NULL;
>>   
>>   	if (adev->mman.drv_vram_usage_size == 0 ||
>> @@ -1621,7 +1622,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>>   					  adev->mman.drv_vram_usage_size,
>>   					  AMDGPU_GEM_DOMAIN_VRAM,
>>   					  &adev->mman.drv_vram_usage_reserved_bo,
>> -					  NULL);
>> +					  &adev->mman.drv_vram_usage_va);
>>   }
>>   
>>   /*
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index b391c8d076ff..b4d8ba2789f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -90,6 +90,7 @@ struct amdgpu_mman {
>>   	u64		drv_vram_usage_start_offset;
>>   	u64		drv_vram_usage_size;
>>   	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
>> +	void		*drv_vram_usage_va;
>>   
>>   	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>   	struct amdgpu_bo	*sdma_access_bo;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> index a226a6c48fb7..e80033e24d48 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -428,11 +428,18 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
>>   	struct eeprom_table_record bp;
>>   	uint64_t retired_page;
>>   	uint32_t bp_idx, bp_cnt;
>> +	void *vram_usage_va = NULL;
>> +
>> +	if (adev->mman.fw_vram_usage_va != NULL) {
>> +		vram_usage_va = adev->mman.fw_vram_usage_va;
>> +	} else {
>> +		vram_usage_va = adev->mman.drv_vram_usage_va;
>> +	}
> 
> Please no {} for single line "if"s.
> 
> Apart from that looks sane of hand, but I'm not the right person to 
> fully judge the technical implementation.
> 
> Luben can you tale a look as well?

I looked at it and I thought it looks good, but was waiting for other ppl
to take a look. I'll give an in-depth review now too. Thanks!

Regards,
Luben

> 
> Thanks,
> Christian.
> 
>>   
>>   	if (bp_block_size) {
>>   		bp_cnt = bp_block_size / sizeof(uint64_t);
>>   		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
>> -			retired_page = *(uint64_t *)(adev->mman.fw_vram_usage_va +
>> +			retired_page = *(uint64_t *)(vram_usage_va +
>>   					bp_block_offset + bp_idx * sizeof(uint64_t));
>>   			bp.retired_page = retired_page;
>>   
>> @@ -643,7 +650,11 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>>   	adev->virt.fw_reserve.p_vf2pf = NULL;
>>   	adev->virt.vf2pf_update_interval_ms = 0;
>>   
>> -	if (adev->mman.fw_vram_usage_va != NULL) {
>> +	if (adev->mman.fw_vram_usage_va != NULL &&
>> +		adev->mman.drv_vram_usage_va != NULL) {
>> +		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
>> +	} else if (adev->mman.fw_vram_usage_va != NULL ||
>> +		adev->mman.drv_vram_usage_va != NULL) {
>>   		/* go through this logic in ip_init and reset to init workqueue*/
>>   		amdgpu_virt_exchange_data(adev);
>>   
>> @@ -666,32 +677,42 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
>>   	uint32_t bp_block_size = 0;
>>   	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
>>   
>> -	if (adev->mman.fw_vram_usage_va != NULL) {
>> -
>> -		adev->virt.fw_reserve.p_pf2vf =
>> -			(struct amd_sriov_msg_pf2vf_info_header *)
>> -			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
>> -		adev->virt.fw_reserve.p_vf2pf =
>> -			(struct amd_sriov_msg_vf2pf_info_header *)
>> -			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
>> +	if (adev->mman.fw_vram_usage_va != NULL ||
>> +		adev->mman.drv_vram_usage_va != NULL) {
>> +
>> +		if (adev->mman.fw_vram_usage_va != NULL) {
>> +			adev->virt.fw_reserve.p_pf2vf =
>> +				(struct amd_sriov_msg_pf2vf_info_header *)
>> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
>> +			adev->virt.fw_reserve.p_vf2pf =
>> +				(struct amd_sriov_msg_vf2pf_info_header *)
>> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
>> +		} else if (adev->mman.drv_vram_usage_va != NULL) {
>> +			adev->virt.fw_reserve.p_pf2vf =
>> +				(struct amd_sriov_msg_pf2vf_info_header *)
>> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
>> +			adev->virt.fw_reserve.p_vf2pf =
>> +				(struct amd_sriov_msg_vf2pf_info_header *)
>> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
>> +		}
>>   
>>   		amdgpu_virt_read_pf2vf_data(adev);
>>   		amdgpu_virt_write_vf2pf_data(adev);
>>   
>>   		/* bad page handling for version 2 */
>>   		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
>> -				pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
>> +			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
>>   
>> -				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
>> -						((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
>> -				bp_block_size = pf2vf_v2->bp_block_size;
>> +			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
>> +				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
>> +			bp_block_size = pf2vf_v2->bp_block_size;
>>   
>> -				if (bp_block_size && !adev->virt.ras_init_done)
>> -					amdgpu_virt_init_ras_err_handler_data(adev);
>> +			if (bp_block_size && !adev->virt.ras_init_done)
>> +				amdgpu_virt_init_ras_err_handler_data(adev);
>>   
>> -				if (adev->virt.ras_init_done)
>> -					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
>> -			}
>> +			if (adev->virt.ras_init_done)
>> +				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
>> +		}
>>   	}
>>   }
>>   
> 
