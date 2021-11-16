Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802D0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD9563214
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AD9563214
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C53A06F419;
	Tue, 16 Nov 2021 08:56:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC456F417
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 08:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF1KA0WCs+9tQ8fyt6Zn31XhvmaroxKjAgtcsgla35b4YdmHuqUBaC7/tnUiTXT8jYsjH1fvonciScFLyLdR6YUIdJxn+D3+vD7apDPWIN4I38ZSoYkWLZLWciv/K3ecDZ0VOStefjMOmi2n+S5NrH5rhFJWkJIqN/PKb0WSrAeewMrMUJy9uxDTfVCuCLXgNmxedSX+sYQbLy8KWZePw5pkWZ9PJPjNhIKNjKWNbw4RLrxdwPSjUgznlVBSpttg58dSLuC8R6XOatpPx3Gme1ioi1Rq2YlZCQmYuQVBwwYeDmQJgwtZwlpTSKdKb/rBMIzBoOitEE0UPIxAthZYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI2dhTQf2XWoNi9snJUUhEQCtfKRSxVSUefATa01LwY=;
 b=b2GuPz405xI3e9cFkHG8dWwo7FpxGUhN6WMVZXg+KaMUYCiFYcHVDUcaSoEpP6GpT3bxOpIS7KApuATJlQfZ05rBtgLDnJ8NjhednZGaMNBCIAdi3FKkcLQuGcSMlp57Hiw/DXDvn9tf4uAXd2M8DvGpDGQLGaLXR4MVQEt18XnLBtVlnlMGtLsf8eJaM/g0+E1enpFYyNRlq+Jle6iwpyaGofFZHPEb3XR5yjFFxP0Y7j+hgyiuYOmEH+3T1lYaYCq9vKd8j7hMhUiL21OdT9ftlomqEVgylz8ei4K4atFijQcY4PIcfUsEX05rnHDGshqmksiSY4tRKvy/uve3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI2dhTQf2XWoNi9snJUUhEQCtfKRSxVSUefATa01LwY=;
 b=vrw8c1l8qB7xjzWS+PVr5Az3o2AZSfmge/w7rDdtUg3jc31epcJmaJ9+znuGr/38KhZbkOZsJmcaFnP9bxLyjkGRP8ap+BS39Yyu/C8bF24gIkIRCC3gzXqezr8Pw5brQnF6iK52RRJ4XkZcy5WnrZydgTFgLfaDuV64/+as7QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 08:56:48 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 08:56:48 +0000
Message-ID: <33df0fe4-95db-5663-eef0-0ad23b9cb149@amd.com>
Date: Tue, 16 Nov 2021 14:26:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: support new mode-1 reset interface
Content-Language: en-US
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
References: <20211116072337.29600-1-tao.zhou1@amd.com>
 <d7384968-1a5c-bb76-2b5b-010f42fe65c2@amd.com>
 <DM6PR12MB46504CA4EDBDF823266985DCB0999@DM6PR12MB4650.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB46504CA4EDBDF823266985DCB0999@DM6PR12MB4650.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16 via Frontend Transport; Tue, 16 Nov 2021 08:56:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fca8ec9d-777b-4e4f-f1d8-08d9a8df05ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834E25785338025A8CCACEB97999@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZlKQ944vT9n+gYa8QFD8vZX0dJLiTdjaXm3rrX93xJRvPgc3MJ+7SoEx7Sh7qj7NxayDiWWTRYtb1ezWpB6sSIgdT1+4e94p+P62Lq7jl9ZCFTm/Mj83sp9LN5dSPyez40up9gpgpZdTWFT0UPtmtCOaqFg1fMOJNB6uIlVI/KmV6pdbrr4mIljeLN4C/HJ/Ym8ygK1YyF71lSQJ8EaOnRGyUT6SrhjxUAjSXdAK8D1Nf4hAbBI3Ct/5N+jigL/CTK1tizl5HRSRk+84Kpz9cHxceEbw7ucYk9vT/3Nn4RApQZMqwdJFImOmbZh+G6TAtsbebzJw2bakMmAtNTJ8tECLLuO+vWNillSCWazS0vpmO6+qt+G8eels4QxQ3o+FVTy4qYepgUSXuRxhI51BEQInjcot3NWN6XOlLhXbnCO8nJnayult24tnvY1xflavY9+xFDJXAyIWhmFPGD8N9cKPDRpLWmH04aXQKiwGINig9+asL03u4CiHv/Fplr8w6l6p8Q1eBmDi7xjk80q/NEp4z8hn34QxpOq3AksKjXFDZLLn4+NfHWRcHSwM3TF2OZ3wS4EUaf49uOdcrk7L7y/J68DyhymHiEsQ5owu7kKS/57wxkCWbsxfY2UCszCXX0E2YTvq2EmR2EQ6r1H1tLYBzJsg+V+jwHtKbtpOyrZ/AYdcDTjId/YWx8vySLNvr/Li7qG0cwV2JkA0QtVh0t27zPfOKAHS10zgotvWkIwr6BcrFX8l1eaO/6OFGEenzsxlfwJ5n22tPpYTanmIX4CiaDyjvB6BLQYSqWWGz4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(316002)(38100700002)(2906002)(508600001)(186003)(66946007)(36756003)(31686004)(8936002)(110136005)(6666004)(53546011)(8676002)(6636002)(5660300002)(66476007)(66556008)(26005)(2616005)(956004)(31696002)(6486002)(83380400001)(86362001)(921005)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5TT094YWhyK1VxSTRSRDUrRGgxRDFSWXpST3pSWkdlbXFQQ3dwQUl1ZFNQ?=
 =?utf-8?B?QnAyeUUvUVYzclRXaEZNMmx0QUs5ZmxtSEJISzZPMlZ3M0Z0Q0RIbVJhWjVE?=
 =?utf-8?B?dkFDRmxLcnhnSHkydUpxVkVUM3RVY3ZTR0VEcTNodmF4OGJHTHNGRlFJM0x4?=
 =?utf-8?B?T2FtN0loMzNhNHFXSlpueGZpZ0o4QXBEMDZXTlhqZE9sb1dJK0FMNzBTVlZo?=
 =?utf-8?B?SVA5bmg5Q3JRTDBIeC85TWt0aG9ZaThKc2Q5em9Oc3RnaWVVcTd5R0Fhc09i?=
 =?utf-8?B?U01IQ3AvS0Rid0RJVXcyQTVXZmRUc1MweWpiUFJqc0pzVnRVZFBsUU1CK2Zj?=
 =?utf-8?B?a2VNUEVxTWI1emJPRXpVazE1VDVmOW5oUXlOMlVYaEtzWDVTZ0xRS0JxU01x?=
 =?utf-8?B?K3dERFdwWkt4eTJDZjNDK09ZQlhKaDllOVRZNVM2VC8yZWluYmwvMkJKQWQx?=
 =?utf-8?B?ZHA2VGw5Q0pnd09KSnMrOCt3bVdhRHF3SktZbTdWODlVT2ZiYU1pekNaWHVa?=
 =?utf-8?B?Smp2dHZ0Y21qSDZkZ0ZZOVYvWmU5bURpb2dTRW52STlNMmF6dTNBelZrYXlU?=
 =?utf-8?B?TDh2d2RkVUE2R25Yamd3U2hXVDd4N0xNK3Bub1laUWFKaG90emVhbytRUVZY?=
 =?utf-8?B?NmdHNS80aWMyelBoZEVrY3p6Ry9MNHEzSHF0R2hvaTR3UDcwVEliUDlQMTFE?=
 =?utf-8?B?MVRER0xTZEE1N3Y0Mk5FdzBiYWxESEpLS2FGOFgraVhZMUp4bjZYWkRGdU51?=
 =?utf-8?B?T1RWYWxDTm1VdEY4cSt4eXVvNU1FUUFBWEpCdzRMZmdaRVJwZ1FNTU5IQWpu?=
 =?utf-8?B?WkpwN2xmMnFRbkRPQmttcVJIdW5uMDNaUXpJNUFLZUJxakl6ZTJzNG4xazNZ?=
 =?utf-8?B?K3JUUHRLWllla212MURjYlg1dUlSMzJ2amMvQnhObTlHaEtUcFd4SlB4UmRy?=
 =?utf-8?B?dGwyanV1YXFubmZuR05IclRqOWtmMVpDclBYazM1bDRVd2dYVHNnM2JHblJW?=
 =?utf-8?B?UExSSTNlNnhTOXhwc21ueDVBbUNscnlPNGticGFMTU9yRmFtdFJHdzBUUWJa?=
 =?utf-8?B?Yjh0K3dzWGVxWmkyVWZqZ2FzY3lTVVMyYS85VXlNRHRyM1U5STlpdmpwRkpk?=
 =?utf-8?B?TkMvYkVVTzVETkZ2b2x3MjE0UjNtZTQ3MitDSTFJdE1mb0FwZXhqb3J6V1VZ?=
 =?utf-8?B?eTQyUlpoaTlRWW01RGcwKzRrdmxkMUpuZHB3VzRscERHY3B2TDI4UFZkZzBU?=
 =?utf-8?B?cTRES3NpaStPVGlqSjltME1NRkp3azdsUVVXS0plYkswdDdBVGNVNE5TUDM0?=
 =?utf-8?B?eXFaUWV5UGpDMUhIRURQR2UrOVUzQkFxTUJIT1JzQ3U2a2xadG55cXZpVjZQ?=
 =?utf-8?B?ZVBiejBHR2FoYVVha3F6cnlIZW5TazFaS0tQUmtZbDJaZ3BHbitCTXJsdmJM?=
 =?utf-8?B?UERiQ1JXMFQwQmNFKzQ1V3pFVWkzb2ZHcncxUERDTUJIa2NqWXUvREt3VG42?=
 =?utf-8?B?UmlwNDgwa1hOd2hnS1Jnemd4N1Ezem04bXd1aEgrU3lOWDhzTjJYVDdrdno4?=
 =?utf-8?B?Snp5V1Z4WnZyMTJBdm1NcDczNkhURmNaVnVKMVkweHBqYTZYVHdCU1lrRGxP?=
 =?utf-8?B?bloyWmd6L09paU1sckJ2QlZqLzcxdmpNaW96QnludkY4NkFmSHBBZzE0SWo5?=
 =?utf-8?B?N1I0dkFGcFdhQjJmeTJORWhnVXpiYWx4d1hkUTlWMUVlcTlKb25OTy8vcGFu?=
 =?utf-8?B?NTZXVGJlQ1NkTytKYnRpL1FMMWdPd1BBd1g5WmxSQWJvcFZTV0lEZ1lGdm1z?=
 =?utf-8?B?OUUvR0dpWnB2T1BuejNYN2g4SWlEelpCbjIwZGk3YW5xeERKaHY4MEhuTTdO?=
 =?utf-8?B?NUF0VW9kSlVjaExrY1pZaTVLbTZoWWFCREJOeWZlYmhwUlU5K2dVQmVJallP?=
 =?utf-8?B?QmN3OER0eCtNUDZqc1l6WTZLTGNZODNxUkgwcWZCMUZoWnBvMCs0SDZ3dmlH?=
 =?utf-8?B?KzR2S3AzWnR5RFpZcXZSUGZhQWpEUWxia3JCRmFmTk1ld0ZNdFJJa1BWUGJu?=
 =?utf-8?B?eDc4bG1KOGd6MWlwZ0RTajlpS20vOWdNR3QvRzd0SVRUMk11TWw4VEVMWEF6?=
 =?utf-8?Q?4dG4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca8ec9d-777b-4e4f-f1d8-08d9a8df05ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 08:56:48.0276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltHWIhWGBUn3XAAuU6E+3TH+eycxX8ieS+Xllu7umLq85YW568l/cwh1KZEp8+eY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
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



On 11/16/2021 2:17 PM, Zhou1, Tao wrote:
> [AMD Official Use Only]
> 
> Hi Lijo,
> 
> Your concern is reasonable, but in fact smu_v13_0_mode1_reset is used only by ALDEBARAN currently. I assume the PMFW of new smu v13 ASIC in the future will follow this design, otherwise we could move the implementation into xxx_ppt.c.
> 

Actually, this is meant to be a common logic for SMU13 based ASICs. The 
version check in a common file is not maintainable. I see there is a 
version check before also, even that is not proper :)

It is better to do it properly when support is added rather than 
thinking of refactoring with future ASICs.

Thanks,
Lijo

> Regards,
> Tao
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, November 16, 2021 3:44 PM
>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
>> Hawking <Hawking.Zhang@amd.com>; Clements, John
>> <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Quan,
>> Evan <Evan.Quan@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: support new mode-1 reset interface
>>
>>
>>
>> On 11/16/2021 12:53 PM, Tao Zhou wrote:
>>> If gpu reset is triggered by ras fatal error, tell it to smu in mode-1
>>> reset message.
>>>
>>> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>>> ---
>>>    .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21
>> ++++++++++++++++---
>>>    1 file changed, 18 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 35145db6eedf..6f3d064a8232 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -1426,16 +1426,31 @@ int smu_v13_0_set_azalia_d3_pme(struct
>>> smu_context *smu)
>>>
>>>    int smu_v13_0_mode1_reset(struct smu_context *smu)
>>>    {
>>> -   u32 smu_version;
>>> +   u32 smu_version, fatal_err, param;
>>>      int ret = 0;
>>> +   struct amdgpu_device *adev = smu->adev;
>>> +   struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>> +
>>> +   fatal_err = 0;
>>> +   param = SMU_RESET_MODE_1;
>>> +
>>>      /*
>>>      * PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
>>>      */
>>>      smu_cmn_get_smc_version(smu, NULL, &smu_version);
>>>      if (smu_version < 0x00440700)
>>>              ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset,
>> NULL);
>>> -   else
>>> -           ret = smu_cmn_send_smc_msg_with_param(smu,
>> SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_1, NULL);
>>> +   else {
>>> +           /* fatal error triggered by ras, PMFW supports the flag
>>> +              from 68.44.0 */
>>> +           if ((smu_version >= 0x00442c00) && ras &&
>>> +               atomic_read(&ras->in_recovery))
>>> +                   fatal_err = 1;
>>> +
>>
>>   From PMFW version, this looks specific to aldebaran. Since there is version
>> check as well, the implementation needs to be moved to aldebaran_ppt.c
>>
>> Thanks,
>> Lijo
>>
>>> +           param |= (fatal_err << 16);
>>> +           ret = smu_cmn_send_smc_msg_with_param(smu,
>>> +                                   SMU_MSG_GfxDeviceDriverReset,
>> param, NULL);
>>> +   }
>>>
>>>      if (!ret)
>>>              msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>>>
