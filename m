Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28B4C9833E
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 04:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48C9010E769;
	Mon, 28 Sep 2026 04:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OamOeabx";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4D310E769
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 04:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOL4AC8+ANFzK9Y1nonn3h+0yCWrpFyxzou5vr0qMyiXgJKtTD8Xpp/CSx/qD/t06cy4YTWGybi7Om+YK7QYXVbhwiPnEqm0FW4glEfgTuFqp62IVrCnoVDuMW7YjH9kRrmuu/9ON9UqMKrRpAtCIqkw2JVD9+eoUDeg/Jra5giWKawm9//AURfz+rokCUFY8/fw4Sca2gasI6P3mpzgmyv9jXF6VAsIWlDhFBQwvlKTXTeQgk2QCLBrilJY0qsrdU5D135829Ckum52YFcNMLz0BpGNlD1hk0UChfK354T3Uv4Vjj8HF78hF3lOPuYK7ksi/LIoyUli6fscvTnBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uazI7R8HNXrbRvqbH13f/lzM0S3fuInKM4ZTzXO7qyw=;
 b=GSDhfa8pX3l+RHlQOgpIC5n0/TcukLiuKaDom/oxShhhUlb+TlJt1zdSC4d2YjMT83uSHxPBfJjjI2FIGyO3EeOEptxVD7v0Tbn2Be2m9nWx0aL1wpVHis1sKF2vEy0RaLMCcT7aNop2kMv+7fG38E22ki+qHs2mGPkpmgkPWrxdnrbPB5CIwzXWSN61vEKYVzuS09aC6OH0dER8iObQyYvZLSAvI6S3hdN5UzkCo73xf8PVlEsi+vE8iFuK0NyCd467A0DUh2SnaGMe5BNnLfOdRI9c98/+ZGDb4O1KH7IWv02FCZhDQZo1kt2ss3a8FOpAIC3OFs8S0dtdTQmKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uazI7R8HNXrbRvqbH13f/lzM0S3fuInKM4ZTzXO7qyw=;
 b=OamOeabxakNa8FZwYimxooh6J9SezDwE6XXWZ95ilfslmX19WpdoVq29u2cz60VVWOGNGC67hcYkI1KMZ47EuON9az5b8KkfeEnC0O3e0+5DG52s4cJUOzc3dKTK/Z8o8hJbLkfsYdQjNZXr0s4mURZiEQi9uSJ6fbAJV94wtUw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:51:26 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:51:25 +0000
Message-ID: <07b76e7a-08bb-445d-8441-bb51835802d2@amd.com>
Date: Mon, 28 Sep 2026 10:21:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/mes: Support 64-bit register reads
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Shaoyun.Liu@amd.com
Cc: Davis.Ming@amd.com, Gavin.Wan@amd.com
References: <20260924063519.688340-1-Victor.Zhao@amd.com>
 <f20b4b97-1334-4190-b1e3-ae8b6fcca69b@amd.com>
Content-Language: en-US
In-Reply-To: <f20b4b97-1334-4190-b1e3-ae8b6fcca69b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: ee23303a-3acd-4023-cb3e-08df1d1c26d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YV1bCwWJD29mDS61A6pRvDhHt++78F4gc0Rhis4d22+lIKe/vVRjyUx0CFG/DLBrOnS2D2PRdo9bWXheKrXTKeYLJaSkKL1sT1XS8QOdnvh4/CC4Zx6QlEhqONurLvIFb8skPcC8Ff98DVm33q3HK3FfMEDq+BXbWNowicj2Umis1qwFmGvLO8igz1KdHXYTGbnoPb2x/2FUhrozyDQNUldkqRZBsSEn3KtSRvrfDpiO25kTJ1L3H5b+1Ae2WALQM7nI+4ofbusTWBz45CPF9K9WTaHwzqh7x/5ECA1t+gSk2xiZQ+/v7m3+6hYjaqDVtyO+R9FG4mhh6Fm2ITXxtUyBTx3JugPsW6iit5MQfo5z6v56daiAAgVLgo11ZJWjteZa+SnUfh9HVBXVhGiEbjTYQACoilnsDnbR3tyXBJtO9W8/eaJupO8iop5syQOvyOt98tpaQbB0dH/Bs1cQ37SKeo+rzUIzIpuOCOMweSZrIRpxWx0Xj8xJAFxfuKnUuCr7Z0MrlltSOefMHdY+uNJWbVcjSzVrWrO/37iJEpPkBDigANbxF68TVdTQpdkYgUYNz/NWIUTZd9hzP9ouPukcqYfuQasXHEFz6x8KhQf2ZQHiw17cKj63nGzTwL44Jv36sdOtyP0buJ7WsRQZ5/p7+aonQHoe1vRiyXOoAog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZqakthQmVpNEMzM0ZBWUVQVkpvb3NHbTNrWS9GZUFHcGpvNEhKZFNLNkFj?=
 =?utf-8?B?TGEyTXB6d1IvR1NwKzhWMVZlUXRLNW1VK0RMWnBXQ1l6SGxIdnlORmg1YXpt?=
 =?utf-8?B?VHR1UmFMTU1PalV3dXgrTmdLZDBRUzB5RjNZeStUcEdxOEdIWTJOeFp1eURq?=
 =?utf-8?B?Y2NBRkw5TmU1ZHRxTzF5aE8xUUVucDZsa3o3NFJ6R2M3a2FWVmNVQ1pQdVh2?=
 =?utf-8?B?Qy92cWVKbGoxRzhSMTZudFpRRFZRbGU3UVJ2ZWhUV0VNV1BKU1dGMVlxSVlz?=
 =?utf-8?B?cjlBL1BjWVVGcFF6SktRNU9wWDRTTHJqTG1Ib3RrK082WnhGeGY4Zi8rMitR?=
 =?utf-8?B?WUdzODBpS0hFUzJjVUl4djZsZ1lKU0tuV01XRmI2RE81NUF3MmtYS0JGWndY?=
 =?utf-8?B?dVRQMlV6ZGFCTEE5bWwyNFl4aGVYR2I2V0FVVVplTHArdzg2a0ZFek1Fd2w2?=
 =?utf-8?B?TnJDTmhrL1lMMkdCNHlldHlSSm9nMEo4TUYyZzRwZFgyTW0vS3VLeDhGbEZM?=
 =?utf-8?B?TjRQUEZkOEIzRm8vMFl6N1loWW8zOEg3VVJrSTBRZkdBajRKMm9pbURndGtu?=
 =?utf-8?B?THBGcGluUG83WDZjSjhLUWZycU45S3FqbHg0Rkx0TUJUYjhtSWROZ3RBRlhw?=
 =?utf-8?B?VjlNR3pzTnNsQjJ0V2JhV2tHQVZwUnc4L1VCcEFyQkZPaHpyUThkWW44SmtX?=
 =?utf-8?B?dWNoc2NkQlJLdmpmVWhXaXhJS1N0Sk1IK2J1aXpHdFRmaGFxR0dxcUJ2WDdz?=
 =?utf-8?B?L1pjQmx5RWlyQVZqUzdLUEZxNHVXNjAybytlN2UvWlVUMEZwbnRPMml6dUZl?=
 =?utf-8?B?ZEVhMS9FZE5xaDFQNVVuT29vYlJ4b0tBYTJMUUd4bG9KcEJkcWJVN2oyb2Fk?=
 =?utf-8?B?MUVBMXkzbVlDdXVKNHdNSUZDeXRJM25CekJXZFE2UlpWdEM1eEx1VFlZeW5C?=
 =?utf-8?B?bmN3M1lvZHRMa1UyV0hKRDBvTlJxVHFtRkxIdTNQSmsrUytLZHBFNzRyYk1X?=
 =?utf-8?B?eCt5VXNvTUlyZUsrMTlQblNmL3dZWXJ4cHJDNXpxekM0M3hkRXlJdWtpNDlD?=
 =?utf-8?B?Z1dabGw5R3RRYklrNjk4cHVqTm5CWENDRlVacjlzbVRJdkdrdmc1dHF4a2FT?=
 =?utf-8?B?Vy8wWHJVSE1Qd3VnQnk3NzJ0VUJ4M3VMYVBraHdRcG1KS1EwMHZMcDlBejdI?=
 =?utf-8?B?OFdtQ3dkeDJ4Skt3djNXR0pvVUk1MEJ5YnM4TDR4NExzUFVDR0dmQVpnc21l?=
 =?utf-8?B?NmlsMnpadVBpbWZzRGpZWnRSUjFibDB5WE5VMThkODFzUFZvZHZCanZkU2ox?=
 =?utf-8?B?RHVoSUJRVlNsZkw4Wll4djFiRnFiQ3Q0ZHpmMkZsM2pYVkVnQTh5d3pzK1Ja?=
 =?utf-8?B?eVBoTEt2WmVYZlh1NmpFNEh2ajEweDlHakdTNnhkYTIvSGJUZVQ0VG8vUzB1?=
 =?utf-8?B?YWE2WXVCWEZXbGJ2TjFmVHVGZElkSmVlaU5uN0Nud05VK241YmxmbEtXKzdz?=
 =?utf-8?B?RXBBSjNCVHhkMmR1MmdvQnREbDZOZGQrVHhsNVVnZWZFeStrc29FbnhnM2lT?=
 =?utf-8?B?MnFWang5RWRjZ3NETnVGVFVIU3lzRTNnYjlaZVR5T0dYaHMvODNOVTBXcjl3?=
 =?utf-8?B?VmZzVHBXWnh0WWg0UTk4b1FJZmhObFNiUnVYTlhHL2s5RC9nV3NxNlVpV296?=
 =?utf-8?B?RElWem1Ucld5L3FHa1VsK0EvOWtaWVZzN2JlYkpUalFYcHZzZzk4OXh3Nk1L?=
 =?utf-8?B?TWNMdU5UendSOFhMTE8rdVhiTWN1MzJJRmI3YW1LOURpUXF5RVBWTjAxclk0?=
 =?utf-8?B?akwzY1I0ZFMybnBZMUViRzNmMGhlYSt6WEhIYVFON2d0aXR6amZHekhUb2Fn?=
 =?utf-8?B?TTFtb3dIQWtlbTVxNW1UOVhTTjhPSm80eHZ4dVFad3pJS3VTN3FMN3Z5RGJs?=
 =?utf-8?B?RXZJSzArNjNRUE5qeWYxWjlGRis1MVMvem1kWjRLVys3THNxUjFOQStHSzJj?=
 =?utf-8?B?SWhjRnpyL0diOFdaSFRySS9sTmFnVFE4Y3pOWjBpVkwvM3RSN3J6cWlsd2VQ?=
 =?utf-8?B?S2NPdUZqeE5LN1lHYlVmekV6RDZoT1M2dExseUNlSVl4ODNPbytmSzVDVWh3?=
 =?utf-8?B?dEY5UEE2TEZQRGFXemZoa0FvcHFVRHZ0WlhTa2pMcXFaUHNoUVJtQ1MrWGRk?=
 =?utf-8?B?SUFUeWtybVRLUHlFbjh1L0pvOThMUW15N2IyMGdrYTV2b0R0RmszQTROWnl2?=
 =?utf-8?B?bUtCUmhCeWJtd2RNZWpGNUJqNEMzdEdkdzhvSlREdzF4OVZhZklZWlErZllK?=
 =?utf-8?Q?8GxwPwBTb/BR8YZacK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee23303a-3acd-4023-cb3e-08df1d1c26d3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:51:25.8961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Nrkb201NFX4cY39rMIJmxv8ISCHGLV7EhdxymJ0dASMqcBraUKu5/+zP9J8eFPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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



On 28-Sep-26 10:13 AM, Lazar, Lijo wrote:
> 
> 
> On 24-Sep-26 12:05 PM, Victor Zhao wrote:
>> [why]
>> Some register values span two consecutive dwords and must be sampled
>> with one MES operation.
>>
>> [how]
>> Add amdgpu_mes_rreg64(), set READ_REG read64Bits for MES 11 and
>> MES 12, and combine the two returned dwords into a 64-bit value.
>>
>> v2: add MES 11 support with the same read64Bits option
>>
>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 42 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 ++
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +
>>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  2 +
>>   drivers/gpu/drm/amd/include/mes_v11_api_def.h |  7 ++++
>>   6 files changed, 58 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_mes.c
>> index 5bebe74de01ad..52b05dc7b74e2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -582,6 +582,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device 
>> *adev, uint32_t reg,
>>       op_input.op = MES_MISC_OP_READ_REG;
>>       op_input.read_reg.reg_offset = reg;
>>       op_input.read_reg.buffer_addr = read_val_gpu_addr;
>> +    op_input.read_reg.read64_bits = false;
>>       if (!adev->mes.funcs->misc_op) {
>>           dev_err(adev->dev, "mes rreg is not supported!\n");
>> @@ -602,6 +603,47 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device 
>> *adev, uint32_t reg,
>>       return val;
>>   }
>> +uint64_t amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
>> +               uint32_t xcc_id)
>> +{
>> +    struct mes_misc_op_input op_input = { 0 };
>> +    uint64_t val = 0;
>> +    uint32_t addr_offset;
>> +    uint32_t *read_val_ptr;
>> +    int r;
>> +
>> +    if (amdgpu_wb_get(adev, &addr_offset)) {
>> +        dev_err(adev->dev, "critical bug! too many mes readers\n");
>> +        return 0;

For the comment about patch 2, this API should return an error code. 0 
could be misinterpreted as a valid register value.

Thanks,
Lijo
>> +    }
>> +
>> +    read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];
>> +    op_input.xcc_id = xcc_id;
>> +    op_input.op = MES_MISC_OP_READ_REG;
>> +    op_input.read_reg.reg_offset = reg;
>> +    op_input.read_reg.buffer_addr = adev->wb.gpu_addr + addr_offset * 4;
>> +    op_input.read_reg.read64_bits = true;
>> +
>> +    if (!adev->mes.funcs->misc_op) {
>> +        dev_err(adev->dev, "mes rreg is not supported!\n");
>> +        goto error;
>> +    }
>> +
>> +    amdgpu_mes_lock(&adev->mes);
>> +    r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
>> +    amdgpu_mes_unlock(&adev->mes);
>> +    if (r) {
>> +        dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
>> +    } else {
>> +        val = READ_ONCE(read_val_ptr[0]);
>> +        val |= (uint64_t)READ_ONCE(read_val_ptr[1]) << 32;
>> +    }
>> +
>> +error:
>> +    amdgpu_wb_free(adev, addr_offset);
>> +    return val;
>> +}
>> +
>>   int amdgpu_mes_wreg(struct amdgpu_device *adev, uint32_t reg,
>>               uint32_t val, uint32_t xcc_id)
>>   {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_mes.h
>> index 33a426f58e723..d67814124f9e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -373,6 +373,7 @@ struct mes_misc_op_input {
>>           struct {
>>               uint32_t                  reg_offset;
>>               uint64_t                  buffer_addr;
>> +            bool                      read64_bits;
>>           } read_reg;
>>           struct {
>> @@ -545,6 +546,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct 
>> amdgpu_device *adev,
>>   uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
>>                uint32_t xcc_id);
>> +uint64_t amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
>> +               uint32_t xcc_id);
>>   int amdgpu_mes_wreg(struct amdgpu_device *adev,
>>               uint32_t reg, uint32_t val, uint32_t xcc_id);
>>   int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/mes_v11_0.c
>> index d8b4d3deff605..304087b851644 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -905,6 +905,8 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>>           misc_pkt.opcode = MESAPI_MISC__READ_REG;
>>           misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
>>           misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
>> +        misc_pkt.read_reg.option.bits.read64Bits =
>> +            input->read_reg.read64_bits;
> 
> 
> Is this only a missing interface definition or does this need supported 
> FW version check?
> 
> Thanks,
> Lijo
> 
>>           break;
>>       case MES_MISC_OP_WRITE_REG:
>>           misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/mes_v12_0.c
>> index 04465804c2544..0d2a60528802e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>> @@ -858,6 +858,8 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
>>           misc_pkt.opcode = MESAPI_MISC__READ_REG;
>>           misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
>>           misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
>> +        misc_pkt.read_reg.option.bits.read64Bits =
>> +            input->read_reg.read64_bits;
>>           break;
>>       case MES_MISC_OP_WRITE_REG:
>>           misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/ 
>> amd/amdgpu/mes_v12_1.c
>> index d17ced46d5f73..e0a488e516c09 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>> @@ -581,6 +581,8 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
>>       case MES_MISC_OP_READ_REG:
>>           misc_pkt.opcode = MESAPI_MISC__READ_REG;
>>           misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
>> +        misc_pkt.read_reg.option.bits.read64Bits =
>> +            input->read_reg.read64_bits;
>>           mes_v12_1_get_rrmt(input->read_reg.reg_offset,
>>                      GET_INST(GC, input->xcc_id),
>>                      &misc_pkt.read_reg.rrmt_opt,
>> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/ 
>> gpu/drm/amd/include/mes_v11_api_def.h
>> index 1fe824b41f2a5..b27ec78da3b08 100644
>> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
>> @@ -635,6 +635,13 @@ struct WRITE_REG {
>>   struct READ_REG {
>>       uint32_t                  reg_offset;
>>       uint64_t                  buffer_addr;
>> +    union {
>> +        struct {
>> +            uint32_t read64Bits : 1;
>> +            uint32_t reserved : 31;
>> +        } bits;
>> +        uint32_t all;
>> +    } option;
>>   };
>>   enum WRM_OPERATION {
> 

