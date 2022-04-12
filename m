Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1BFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 03:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29FC210FC30;
	Tue, 12 Apr 2022 03:03:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B5510FC26
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 03:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z54FaqRKhDJAwhH5FZV8+m2xrMPrp64CPcfyv2lFQwy1vE/izL+prJLz2vQkqxp7xc99x3pdr/KQDwu7AR0h5OyP7XaLPJjp2C0eKoAR3i+jIZv2jJHwzgF8tDm95ho0DC9+d1ktaDIk9okSzt1siGo1o0bnZAQYmPyfu4IkFTDPoVMSaYXPQLoaalF8tzuSoDbvRb7MJq9NgwASB8/X7fISdRCMzxp69m+7OKxvp1YLzU5rf0El4Y1qU/s5FMrrfwdZNwhhPIh8hHRdMBo13AIkfhChymMvt7ulILA/VydUlW1tP5AdYxGnrZqoxZPEL6OdfCBU1GpeyadpULcGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6HZvIpOeyQ4Hr7eR+u1mqzNtFaXVjkGexkJocaLhp0=;
 b=Zi7xfaz5m8Mlzp19ZRz8/3hW3jERGIrKFH2sLxvFsBcNtYUT/XmJFA2px0Y2VeV01XQy9KW3L2BY3g52gp1jTm0XTLU1PNYMjHhqtmtKU3KzkFbPPkMtyVf/Bskmp8YIv9YrFAMZByJgXBvnbQJ1SuJMSibfW4sXw8WTsmZd5D6FLrnFpeOOFuqFiysAwtbXWNrYGiVU2c9VL1bZFOxeG0BjSre5cGxzWXMbZaK+ordztZvCK62UuOtuKDobO8gGvW5jpMaDca0KK7srXY8dLzm8qZ5/vTuIsijRHpn9XdEth/sFkKEWyVdk+k8kD3JtPu+7L0E0DB78KRXDcTiEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6HZvIpOeyQ4Hr7eR+u1mqzNtFaXVjkGexkJocaLhp0=;
 b=00kkJa4IqpQ5lJ2E1/SoxTpQ4pMIOxiybq4Tn7/lp9gsoXgAF7x9/intK5WFXfexvMkIRdDSAagmsPTpFISg+fLe6JG8V/OS1rYaAxKggMM0wp2pF1oIgRCiV+qVkJEdhBCiW+5kewZIEFEQQ2vnC4oHs7tCeDSKw2eWpx+lxWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 03:02:59 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302%6]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 03:02:56 +0000
Message-ID: <ef75f61e-e763-c257-2b2f-c32c2e6c0086@amd.com>
Date: Tue, 12 Apr 2022 08:32:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH ] drm/amdgpu: fix discovery ip failed
Content-Language: en-US
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <DM4PR12MB51525F878057240AE5C91F14E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <bbd6939b-227c-f197-5d10-ba9194fd2b76@molgen.mpg.de>
 <DM4PR12MB51529669CBDA773CD36D420FE3ED9@DM4PR12MB5152.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB51529669CBDA773CD36D420FE3ED9@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::24) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 672deeb0-390b-44b6-fbac-08da1c30f133
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5363AE69D4851854008167E797ED9@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7lcWMX6RmPv9GiY9IdU5eEz2GmJeOkyld0DD/ILJCLRQ4T9x50DWQhalkppq3kevvA1gQONKgI3Iru0m+CKhsC8mKBDhq3mIvkHmg8husaa9kEvSnAnLjX6IYiQzgyg/TrEuaxCC8XkZX2tmP7pOQK84YvK5J1ouskEQvuhl/DDVCZttdSRXzWEbHgUQwM3PbVNodJrPaF55B7defLgVSzjZY2XSZ7IOmMjUbICLr5MweNYkYkmitQD4TPPY02HiBrBD5cX8xE4RNjcK4PHJSQ4vsd+05ijHTq3cgdbEeFvtzPF/tnNXI821ZibxdK8oFMNInDeJGIC//63XUWijdl+3tQNYOEOl8V5bT7/zwK0AWlQd42MCA/fJUX1vKGVRdTzE/P29na2dpIutTNL6gOvIl9oLi5PoJSxEdU6d7lMvcPwd504CdeRFduoPz/BoNU+tdMsskpZIEJ7CDupG7gnb9XivEYK6RMUIYruCpM8l3RSt6PQslRLQdzqgoMEZbqbqlnmuRQBGMa29/5jyMdlsFCdKzA/0K+YT2KIJZFju8UVg/odSDgsXJQE9fy13a6UPb2388yTBpd1Dk2TOeR7+TeSgKtNJbKRWTNT8iehiEd+5CWokDV08VmCaadB/HW9bufl7B0z/L5GGT7p9vK/TeJ2xr0GjJdjY2x8za49JioOQy3GmfhQ5IpHg1ruhdVan6mcctOPVsJR31iHzvq7gnpZKskGCy3A0ASPBko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(38100700002)(31696002)(4326008)(66946007)(66556008)(66476007)(8676002)(6506007)(6666004)(6512007)(5660300002)(54906003)(110136005)(508600001)(53546011)(26005)(316002)(6486002)(186003)(31686004)(83380400001)(2616005)(86362001)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1lTMm1uRnhMZDU0NjVOamhCc01UZkx0djRSTWlSU3FWLzZXOFd3OWFsVjhk?=
 =?utf-8?B?ZmY0bjZSc3pLQnJKMU9hUHExUzJwdlpJZWdxaURheDUwbmE1ZGVpNFVwcTc2?=
 =?utf-8?B?d29rRUNTV1hXZGZnb2UvMGowZ0hUZ1pRa0lHQXJGN1hBcHRFdEwxbUt2Z0ZC?=
 =?utf-8?B?SjBUQ0NjTS91ZmdxRWxQY1o0c3Q1aGlrQklUeUNidU1zRjZHUTYrNHNEWUFl?=
 =?utf-8?B?cnovNG9vOHgwQ1MrOXFPUDF6NVpoREZOeWRUM1VhaXVxbnhyZE1EZDgyZUM2?=
 =?utf-8?B?OTZCSWdNRGJ5S0grV3RLMGVaalhOMU1FcTluTi9HdkJKN1NSTndPbHVaV3ly?=
 =?utf-8?B?TWh6c0lKSndKQVNBenRGVlBFSGJ1emFtTERIdjdLQnJ3VERIVGlXOG1aeGdr?=
 =?utf-8?B?TC8rYWN4L0VMNHdXdEJaaVNNSGlreFVEaVlFSFAyTXgxYk5pTTN1R3kvZmFx?=
 =?utf-8?B?REg0VXZYZ05iTVhXcDR6T1l6U1RTOXM2UnJnM29FbXd6UUJnblBhR1lFWUN3?=
 =?utf-8?B?aUpBUHRiVmRqQzBLY3NVTnp5WHlRZlhMbmpIdnRhcUI1ckJaZjY4UVkzSkM5?=
 =?utf-8?B?NVNaTXRxN1pRM2Y2RW9ibHhYSTh4K1JLNFNtUmRLclVWUkxwOHRGOUZEUEp5?=
 =?utf-8?B?R1ByUFRxMVNCYlpaVnVjdjV1Zml6Zjlic1lDYWNUODM3YzRiTWJ0WlZtTXJi?=
 =?utf-8?B?bHB5L2hYQVhXQzQzbzdxTG01L25NNEU2Mjl0YlcwN0czTUNCWllESEdPbGlT?=
 =?utf-8?B?SXl3SDF5RU5NdVBrRmJzNG9IOEd1bnYwWWhoeUwwSVJtemwyUHF4T1craGJ4?=
 =?utf-8?B?Zk5kZDlSekZGYi9Ra0o2c20ybzFpYkZ1ZkNIbGVmOElLRVRwN1k4VEJ6RC9u?=
 =?utf-8?B?RWpPQTNTMTJNb0pYVW1ZeVlKMDZZU3lOZE1qS2lvSHc5Vmt0dVFmOTl4Zjlu?=
 =?utf-8?B?QXhoUzdYUUtpZG1wczhEdzBERndNTmlCYnBqdUc3dDdTV2RXWGxGZVUwMHpw?=
 =?utf-8?B?MmlWMWIvMTByNkoxeVpvVEEra3pVSmg4QWxEb2xlOXR0WHhwclFscEVtZ3Nm?=
 =?utf-8?B?b0tmamdVcmlaWXhvS3QzbG1pYnJLeFpMMVlpbUtpZ3BxaGFFbXliMU1tb21E?=
 =?utf-8?B?VmZvWXZ4eWhwNHVTZkVSYjhPN2dyVEcxNDBnUTY4d0ZFaFJNTFFud3Q4emph?=
 =?utf-8?B?a2dIWXJITHh0NlluT3AxRHFON2VpUDFTY3dVTTE1VDN0bXJYNGRBSnE0bUtl?=
 =?utf-8?B?bDJmM0xYR3BGMGlSRmpmT0NqVHR6VjlEZFhtVktKaThpOG1aTEdnaW84OGYz?=
 =?utf-8?B?NjFrd1lJdmVtOXMydnJtaWViUVZsdndSL2VPRkJObk00VXBLUGNmREE4QmFp?=
 =?utf-8?B?KzUvWnZVYkNvNVZTRVV3WTlEekJLdkxnN1BZbHBGUkFHdjYyMVI1bHEyZE45?=
 =?utf-8?B?NExqeEhvL3hWVnVaNGpHVHNpTmF2ZXFRTjY2L0FKakdoMHU2NDNWTXUrakxh?=
 =?utf-8?B?TmRvVHExSGZWL3gyN2JteXFHd1dkSlpZSHQ5VW0ybGtBa0ZlQXJJSUhteTFG?=
 =?utf-8?B?S2FXSko0LzQwL2lPZmpZLzBZSWdwS3dHT2F6MTdKZjd2MnFicEVGQXBXaEsz?=
 =?utf-8?B?LytnaUJiOVBRS1VpYU9UZm9kVUtRc0hjRnhxVFAveitKVW1IUDhDSlBUOVp2?=
 =?utf-8?B?dkVMUUJoZWk4alRRU05kUHRyVExqWWRJSGNJZU5hY2k5eDN1UG9uRElBWXVt?=
 =?utf-8?B?bkY0dVBMUllSMExsS0NzRUdwK1MyNUlDUmZjeHUzd0lJekdGUW1MNWltUTJl?=
 =?utf-8?B?TFRiSDFXbWc5UmQrb1Zla1VZY1RraE16bmlpbFQ5b3BkSUhmTGgvNk1xeDZi?=
 =?utf-8?B?V0NaSXUvd3UxUnBJaDdodGsxNm1HSGtQMzBUZFhvUmtmdVJ0OWlGQ2laOWF4?=
 =?utf-8?B?RFQ5bmZCV1VLSkd4Mzk5WCtERXV1ZklJUTRiVE12Q0w1d3VHZk5lLzBvNzZD?=
 =?utf-8?B?dExwbk5vTUtnVXZPa0NxV3RuZ3kveEtRM2xiRFh6K2pnQXpiaExRakV6MCsv?=
 =?utf-8?B?NWovdlhRd2ZKNnQ0WGJmSU4rMjBzTTBNTTdYUmkxQU1IZ2xZZGlOY2UvUXRK?=
 =?utf-8?B?SmJCK2U5ZmZOQW15aWUwdUUvQkJvWEkxSDRkK3IzVFhPdGFBTDAzanZCQUY2?=
 =?utf-8?B?RkNLck9LSjZMdXBRdzR5NVE0RkJmWWl0ZW9qdHRGSTdVQ3duN3ZMWVhjNXJi?=
 =?utf-8?B?Q1gwT3NCMnZ5V1p2a3oxNU1SVTlJNWpYSDhjb2R1V2I0ang2bm1yTTlwa2NQ?=
 =?utf-8?B?UFNrNWp1am9RcEZiUTUyTjV3bXB3ZjM4RUZ1L255bGVOTVFvcFpBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672deeb0-390b-44b6-fbac-08da1c30f133
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 03:02:56.1601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F99zTA+zRfh7EmDkOpJ26MUEvLw3Zs0q39lrdhs22CJ7xfOF6RfSlUOknLFSUiKo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Thanks Jesse.

Please also add below before you commit.

	Fixes: 1ef60191b259 ("drm/amdgpu: Use flexible array member")

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


Thanks,
Lijo

On 4/12/2022 7:22 AM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only]
> 
> Thanks  Paul Menzel
> Attach  the patch file .
> 
> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Monday, 11 April 2022 11:21 pm
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Zhang, Yifan <Yifan1.Zhang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: Re: [PATCH ] drm/amdgpu: fix discovery ip failed
> 
> [CAUTION: External Email]
> 
> Dear Jie,
> 
> 
> Thank you for your patch.
> 
> 
> Am 11.04.22 um 17:15 schrieb Zhang, Jesse(Jie):
> 
> You might want to add a space before the (.
> 
>> [AMD Official Use Only]
> 
> Please send a patch with `git format-patch` or similar.
> 
>> Fix discovery ip failed, and the log:
> 
> On what system?
> 
>>      56.129549] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from ip discovery blob
>> [   56.130129] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (45056) from ip discovery blob
>> [   56.130701] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (66) from ip discovery blob
>> [   56.131283] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (45568) from ip discovery blob
>> [   56.131855] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (66) from ip discovery blob
>> [   56.132436] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (480) from ip discovery blob
>> [   56.133053] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (608) from ip discovery blob
>> [   56.133626] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (640) from ip discovery blob
>> [   56.134207] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from ip discovery blob
>> [   56.134780] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from ip discovery blob
>> [   56.135360] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (28672) from ip discovery blob
> 
> Please describe the reason for the failure, and your fix.
> 
> A Signed-off-by line is missing.
> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 766006a075ec..a778b0392e9f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -798,7 +798,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>>                           res = kobject_add(&ip_hw_instance->kobj, NULL,
>>                                             "%d", ip_hw_instance->num_instance);
>> next_ip:
>> -                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>> +                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>>                   }
>>           }
>>
>> @@ -1063,7 +1063,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>                           }
>>
>> next_ip:
>> -                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>> +                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>>                   }
>>           }
>>
>> @@ -1113,7 +1113,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
>>                                           *revision = ip->revision;
>>                                   return 0;
>>                           }
>> -                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>> +                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>>                   }
>>           }
>>
> 
> Kind regards,
> 
> Paul
> 
