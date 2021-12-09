Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CF8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908F210E19A;
	Thu,  9 Dec 2021 16:53:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3358889169
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 09:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4iiazciM7n/5D+bsIB2Xcgtq2S0GCKa5E5e6ywOP/QFnLrypLzn8P07qY5yovhad0q7t9n3KtcdO0hlWw5fH1BUMiTYgS71rD9u8e8J1W9WCvmafEbT5zVW/2jctFR4SJPiMC9X2YeTinujyjxiSA8WjEQevJIjzbsMDAdl8C1IW4ljkDnhq4hT1Hd3pcqrvFEDrfDIiTy9aZ7tGzY2fhZF3828F91hjvgLJnNiMHQH/6OP2SAF0QUBoq9BFh0PA/+EsxtZDTysG/pev5k9hQs+/PQcdYQcchafXaJxypjWQckpHxJL+VVfWzOoUSUc3bbp4LeudBvUoiEEEahz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jCYlqnQ4lTfPE/UEIITJ7l5eVL5kITr3S0CfYrVC9w=;
 b=WYAeyHIAojjj3lvsZuRoujp44SRC/4vqJP9nbGeEebbCW1MlhwIbAQmk4IOZkFYX9y8k0qdM0n/mcy12hekkfVrCDzK79Sw35jBjBnKMOy9hM/wrbiEaeJ03uCZ3JvnxiUamxS2tn0eCa+7Y6za2tGGO2K/vzMErnwoawyy+yL2k1+YpNFUQJ5/67iYsK/ywnZzwdXqdZ4ZTrrFbyd8QZ8H/8P/BJmsgxkTrr4L5BzukBAKxHo38QSnW2wB8ZJXHlf6ZgrSLEMJDSwXcMz+TA5pWQhhNWgeWpOcQrbL7bb26Z8KooYfxyZu7mDNQLovAP5rxEYOnj6/DH6kmw0JDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jCYlqnQ4lTfPE/UEIITJ7l5eVL5kITr3S0CfYrVC9w=;
 b=zjw4oCL54/SA3M9p8p1mmkgusp7Q2N8OwJmnH/FFj3lPqzWEzpKNGk3acrfSzE4+5RwY2xjGKXWJvBZ724oNS/qB48MSf/6WlZ4TqcedDH/AKH+fV4hRovvuFWyqPpiNQcMBY4KwQKLR8HykEOEfLpiR0/6uvzOxlgU5IFRs3ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 09:20:24 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 09:20:24 +0000
Message-ID: <189723d8-0d3d-745f-2ddf-0c138cc99678@amd.com>
Date: Thu, 9 Dec 2021 14:50:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] drm/amdgpu: fix incorrect VCN revision in SRIOV
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Shi, Leslie" <Yuliang.Shi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211209082639.1296627-1-Yuliang.Shi@amd.com>
 <ca6f5212-05d2-2a18-c951-a296723f5a72@amd.com>
 <DM5PR12MB246909B8A593B576BEB8BE7DF1709@DM5PR12MB2469.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB246909B8A593B576BEB8BE7DF1709@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::34) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e14541c-80b0-45c8-d16b-08d9baf5213a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2809673FE6302BFD0B51F19997709@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfjVdiXkkxAXedrKXgYefw5dbP5NzdOUUtK/pOCJWrMk6Ku2FpHxXUHdMZT6rDYq7lu0lbRhuL2A+C5XwAMxGOBBpS7SvbiWmJWUkPVBE2j797BeQY2/t4qEKoGPs082cDavS+YZxWgMmUHdqlMHRvu9BjSrvfvKjXsuHSckej7cuB5qVwRB3ZMN9RXYOqv/QHqBoWGL9io4EA5fLQA+ad3DvVdsi85gCrom01MuEwZgkWIzV413WYe5cmw4sfZhBaKmWYJ2W8WPUNP6GbfuYwyYGbMsg7fCVpa7zzpnL4ta+xSonoT7H291GF81V1oHFEDad4qAY92MT+MGbjRmikpjKJOEFayBONCxEoQoRuaraLHTVtN4a+1Ovofzn2aD9yUR5UB7NMjf9AaHHe9CFiBQAM4KKoqUY5kA335iruzXrP0Zc13mghNJal+oZYCC/XjAbLohihSjnNzzK6Cclx1oXgbv88KPlrxBVy28mfgNjz2DU1BVkffzJ60Z+W4uQr16694Q9YWmp6axWIEu8YBDdhjog/NGE5a/xDRkX5vONj2xgqNlcKKzAzYBy1A18yQTF92wxrHs2SyOCaVDgfUBCQJUf9HOEEMECU5r0FcKddxrBramqy3gdOmHxkyj6CgkgNWIpdHQOyB1cuG0AO2JYUhnF6KlI4tgdVUAwrac1A1kbHvtmxDRO+U3abJPW9gHo5mhBtQ/fQgjPCKDHAVY9tIhrZbIBf9oHfDoJxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(8676002)(2616005)(6512007)(6666004)(26005)(5660300002)(110136005)(31696002)(38100700002)(8936002)(83380400001)(36756003)(186003)(86362001)(508600001)(66556008)(66476007)(31686004)(66946007)(316002)(6486002)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1Oc2trUXQxYmdqaEF4VFhsaXBlc25GaE9naFlSOGFVMTJSZGwrNmtJSmV4?=
 =?utf-8?B?ekhPU3A2YlhiUVovMnhlajJwdVVFT3hXOUp6SkNURTZZOUdsTldMd0dzUnRT?=
 =?utf-8?B?YjhKQkY5a2VoeklwWjFpN1k3VXloK3I1WlkwUnRQbVh4THRPUWhXa0lIQnp5?=
 =?utf-8?B?T1RYWDVYK3djblNEUkl4QU15TUx1eEtzdndsMnZmRVROMXU3Yzk2UVF1dC9V?=
 =?utf-8?B?Z001U0dGcHcxQWIrQnlLenE3b011UVFCcTlLWVE5RE8wcGtQdTdEZzVTZWdk?=
 =?utf-8?B?ZTVXQ3R6eFlaTFJvZlBoMWhGeWZIcDhzaWRFUDhPcFRjSTcwR3NDd2VFNWJh?=
 =?utf-8?B?RTNCS1dvbTh1ZG1LMGlCdXRxU25oWFFMSFZPMVJ2dHgrbVBQY1RIU0dvTTg4?=
 =?utf-8?B?czJLRS9oNStqOHYwSFMrQ05Xblp1dFdXczdUK0J5K0Y2OFlTQWVhN3dWQmJF?=
 =?utf-8?B?Z3c5SGlNbWZlMlA3SHE4NlREWXcwSzFZTERIUks1aDFHQkVOTk9RcmlzOHVG?=
 =?utf-8?B?UzFDN2tmcjh5U3lIV0lHVGVDVTBZVjBTT2R2MXRKcXFMNGt1VW1raXpyeG9v?=
 =?utf-8?B?cll2M2IzWTl1WjVVOC8zSHFDQTVaK0R2Y1Iwa1dYRGhWSk5HczhLYVlTeUk0?=
 =?utf-8?B?blZaWFBaQjJLQzNsVFlFU1J2TUxWZkEvL2JsWlg1dnczM0hLcHZKVEk0V01t?=
 =?utf-8?B?czNYN3NJZWY3bk5UN2xtOGpQZkZUT1R4MXhSNUh1YTREVGY0UHd6WXQ3ZUo0?=
 =?utf-8?B?RkZpbEpBYWhSYW1OUXRvRUdZaCtlQ291RmRhRFI1THdmSW4zTFBKUjBCSGZU?=
 =?utf-8?B?dW9rRjd0QWlEWVJwL3VXVEJxK3U0M05pQnhaUGdaZ3MzQ2ozaGs3VzBZMGx2?=
 =?utf-8?B?L1lwTWxsL2lHNDVlZEpwNTVRZkt2VUxLZjM3ZHUrZUlJemZvdlpLcFQ1ZzNE?=
 =?utf-8?B?SG52OTlNSmlXUlJ1WG9WZEYwNGc3djVHLyt6TnNlVUU0cmNQRksrbVRJeS9W?=
 =?utf-8?B?SVpLa2cvaGJuWlRkeWtQSWM5SXBkWFhWeUhVS3lQT09vQnI0ciszUWtWVld2?=
 =?utf-8?B?RjExMlgwdFd3OUJTbUw0SmlTbFJHaFR3cjVaQk5nb3NDeU16MzVkQVNIVXlT?=
 =?utf-8?B?VkdnaXkzdktscWU4MGZISW5lTFVkc25xclhnb3hhN1h5YVNoSDhzSzZ3NGR2?=
 =?utf-8?B?ekpubVdCTyt1eDFPanl6V2Yxckx4RTh4NWhBSTJBSzkzdzBFeENBR1hDaTYx?=
 =?utf-8?B?ampuTEg2SzR1M0dPK1hwdm1yK2lSeWdQSHZEcHU5dlhrV1BsTlhyVFJXUXh4?=
 =?utf-8?B?TS85NElBQjgrU1VIeXRQYzVnTHRVcG5PY2Z5UnNSaThpRFFncFh1dndXc2k5?=
 =?utf-8?B?UFB6Qmp2bFlNWHAyKzFVSHNNK1JSSjNZQUp2bnZxTVlUMVNjVCs5d3Fja2U2?=
 =?utf-8?B?cGFqdVk0TjBwbExzaTB2UjZPcDd6anVldmNMNXdiSkI4TUViYTNPWmRPWFM3?=
 =?utf-8?B?SW13NkF4ZUw0cHhEZHdIbjVtWTFLclVpT0tJbjg4UDUzbDQwZkJubmhMbkhY?=
 =?utf-8?B?WFZuTEpwZWZmaXBLeHJCSVpIcHJpWWgvOHkrejZ4SnlSRXRyelpWSUF0S0pp?=
 =?utf-8?B?UnJEOFVKTWJnQm1PWTdzN3pzVWFBNzgrQmpBcTRsMkZMQlcrSUpzd0l3ZWs5?=
 =?utf-8?B?STloeEpNdGpMTXpKRDY4WmRIM0JOaVBGdHZnTXhmbk1mMG9DeWJSMXIyODdQ?=
 =?utf-8?B?cWdkOGVNL3FVMnh5bUQvWitKdlBpaHY2UEhnQ1ozbVNSYTh6WHVuM1VmQTVo?=
 =?utf-8?B?RVdtd01DeSt5WnRiNkI0U0ZvbTRtMmFlQjUxR1Ardk1wRVVPY29Mekp6L2Yz?=
 =?utf-8?B?RDVuQTRwMXJpVDJUWEhDZGlZeW1yeEdhM25FZEc2dHV3YzFQK1JMMXBIUVdq?=
 =?utf-8?B?S0xqajdMTko3eFRhNDFmWXVwVG9rRmhNTXl1ZnhwdWJRTERxS0tlNUk3VmtS?=
 =?utf-8?B?aU1BRlVVUUFVNE9TNFN3QWs1ZUZ5MTh4czZISjBDbG9SSHk5bHpTL0NPSFZ3?=
 =?utf-8?B?RmxjbmlVWHVRTk9qQ1NIMDJqT2NpVmdMMGxiMGxWY1RXWjR0Q0R4dVgwZmh6?=
 =?utf-8?Q?BZaY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e14541c-80b0-45c8-d16b-08d9baf5213a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 09:20:24.0370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdY8DsPc5mRsmirSFY8hC42jtVDjKgwqgzrShCbgQixcqb8PA2h2y2lAF7HzE9aL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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



On 12/9/2021 2:46 PM, Chen, Guchun wrote:
> [Public]
> 
> Hi Lijo,
> 
> The check is not necessary. It has a guard by for loop in the caller.
> 
> for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> 	.......
> 	if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
> 	......
> }
> 

Thanks for the clarification Guchun.
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

> Regards,
> Guchun
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, December 9, 2021 4:53 PM
> To: Shi, Leslie <Yuliang.Shi@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: [PATCH v3] drm/amdgpu: fix incorrect VCN revision in SRIOV
> 
> 
> 
> On 12/9/2021 1:56 PM, Leslie Shi wrote:
>> Guest OS will setup VCN instance 1 which is disabled as an enabled
>> instance and execute initialization work on it, but this causes VCN ib
>> ring test failure on the disabled VCN instance during modprobe:
>>
>> amdgpu 0000:00:08.0: amdgpu: ring vcn_enc_1.0 uses VM inv eng 5 on hub
>> 1 amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on vcn_dec_0 (-110).
>> amdgpu 0000:00:08.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on vcn_enc_0.0 (-110).
>> [drm:amdgpu_device_delayed_init_work_handler [amdgpu]] *ERROR* ib ring test failed (-110).
>>
>> v2: drop amdgpu_discovery_get_vcn_version and rename sriov_config to
>> vcn_config
>> v3: modify VCN's revision in SR-IOV and bare-metal
>>
>> Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
>> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 29 ++++++-------------
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 --
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 15 +++-------
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  2 +-
>>    4 files changed, 14 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 552031950518..f31bc0187394 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -380,18 +380,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>>    				  ip->revision);
>>    
>>    			if (le16_to_cpu(ip->hw_id) == VCN_HWID) {
>> -				if (amdgpu_sriov_vf(adev)) {
>> -					/* SR-IOV modifies each VCN’s revision (uint8)
>> -					 * Bit [5:0]: original revision value
>> -					 * Bit [7:6]: en/decode capability:
>> -					 *     0b00 : VCN function normally
>> -					 *     0b10 : encode is disabled
>> -					 *     0b01 : decode is disabled
>> -					 */
>> -					adev->vcn.sriov_config[adev->vcn.num_vcn_inst] =
>> -						(ip->revision & 0xc0) >> 6;
>> -					ip->revision &= ~0xc0;
>> -				}
>> +				/* Bit [5:0]: original revision value
>> +				 * Bit [7:6]: en/decode capability:
>> +				 *     0b00 : VCN function normally
>> +				 *     0b10 : encode is disabled
>> +				 *     0b01 : decode is disabled
>> +				 */
>> +				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
>> +					ip->revision & 0xc0;
>> +				ip->revision &= ~0xc0;
>>    				adev->vcn.num_vcn_inst++;
>>    			}
>>    			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID || @@ -485,14 +482,6 @@
>> int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
>>    	return -EINVAL;
>>    }
>>    
>> -
>> -int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
>> -				     int *major, int *minor, int *revision)
>> -{
>> -	return amdgpu_discovery_get_ip_version(adev, VCN_HWID,
>> -					       vcn_instance, major, minor, revision);
>> -}
>> -
>>    void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>>    {
>>    	struct binary_header *bhdr;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> index 0ea029e3b850..14537cec19db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
>> @@ -33,8 +33,6 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev);
>>    int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
>>                                        int *major, int *minor, int
>> *revision);
>>    
>> -int amdgpu_discovery_get_vcn_version(struct amdgpu_device *adev, int vcn_instance,
>> -				     int *major, int *minor, int *revision);
>>    int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
>>    int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 2658414c503d..38036cbf6203 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -284,20 +284,13 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>>    bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
>>    {
>>    	bool ret = false;
>> +	int vcn_config = adev->vcn.vcn_config[vcn_instance];
> 
> Missed it. I guess there should also be a check for valid instance, otherwise it could return false (by default nothing is disabled for a non-existent VCN instance).
> 
> If the check is not there in the caller and assuming instance is 0 based index,
> 	vcn_instance >= adev->vcn.num_vcn_inst
> 		return true;
> 
> Thanks,
> Lijo
> 
>>    
>> -	int major;
>> -	int minor;
>> -	int revision;
>> -
>> -	/* if cannot find IP data, then this VCN does not exist */
>> -	if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)
>> -		return true;
>> -
>> -	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
>> +	if ((type == VCN_ENCODE_RING) && (vcn_config &
>> +VCN_BLOCK_ENCODE_DISABLE_MASK)) {
>>    		ret = true;
>> -	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
>> +	} else if ((type == VCN_DECODE_RING) && (vcn_config &
>> +VCN_BLOCK_DECODE_DISABLE_MASK)) {
>>    		ret = true;
>> -	} else if ((type == VCN_UNIFIED_RING) && (revision & VCN_BLOCK_QUEUE_DISABLE_MASK)) {
>> +	} else if ((type == VCN_UNIFIED_RING) && (vcn_config &
>> +VCN_BLOCK_QUEUE_DISABLE_MASK)) {
>>    		ret = true;
>>    	}
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index 938a5ead3f20..5d3728b027d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -235,7 +235,7 @@ struct amdgpu_vcn {
>>    
>>    	uint8_t	num_vcn_inst;
>>    	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
>> -	uint8_t			 sriov_config[AMDGPU_MAX_VCN_INSTANCES];
>> +	uint8_t			 vcn_config[AMDGPU_MAX_VCN_INSTANCES];
>>    	struct amdgpu_vcn_reg	 internal;
>>    	struct mutex		 vcn_pg_lock;
>>    	struct mutex		vcn1_jpeg1_workaround;
>>
