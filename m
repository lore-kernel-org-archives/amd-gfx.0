Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499BDC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 21:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8922810E508;
	Wed, 16 Nov 2022 21:09:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4594F10E508
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 21:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDxC+Do8o2LiNhLxyaQEP8YetqgMv0Eb5asnWbFaPARFnjzfgdQkc0KpNWZNmhKpXB1ZkUsYqM38D8/5eT/h+6Mi6/Zek7WF9ih8K9eoYS3MqufggwnB/2VVPbGHBv0eYhlbjW1HdcN07uFXsuh3dXgqkcJq2BvpAdvl74rcuXoFgkVrcxIRKsHDg+9mAeN0Lptz5rH157DUKUb3IMG/UkQijCN4/HfOMmqmqJSpGTd5u4lDMP1G/YDaweg0ppFqXXpy3wRzxkCXPMz4z70Kzo1mPbkN9dV7pzbx613ShLtWi6LAxx1s5k6+XwIpSDRk0vqtvfFTFpkis8e8uLGRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgYAR41ynST66iPUnyPUeZIeNkgsoNfGw/uuUgdtCKY=;
 b=MnIeutkicktvX78Zj9QZAKH6Ria6Snvji62qHTYyWHLPktog2czCSUzD/EHSYMoAcZbHjx53oAXryiw5UTkX+0/O2TUioUpPp3otuK1FKCaYLNY02HCPqHNNoupsxkZltXy6WmoowqsjZtyVvq2WjRN7tlaCOYqQlWyJNX8S0UWVX8IQFMggbuLqvo+nj/RawmrKC1MIDGPSjDTrPjZTIyLMNkwv+lyOSDj4aRFfFB4UdmxW+fTC4076Dify4bBaHB/xztPlcpStSiTwR9nN8mYpsW7UXFPrO8nzTJdwvDArYkq04LWw63R5APWQYKk6PiNt9dG3hlG6HkU+dVUiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgYAR41ynST66iPUnyPUeZIeNkgsoNfGw/uuUgdtCKY=;
 b=gBYnItOSg0GQJwt8SaqFg9EXZ8sFz6qmJA1hA/37qMWh3Xnu9AYbDRqRd+dPpQ4vij0zdENZFMWlBMu+WnJhombjDt1WxFtA4+EX+bzr4eLe3LY3rkpedYIQCrSrLJGaXahwMLLatAXgaVdZtYI9SJs6XPrmXeM1xaos5UHnyY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:09:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 21:09:30 +0000
Message-ID: <c9a824aa-9524-b93a-16df-c77c9454da16@amd.com>
Date: Wed, 16 Nov 2022 16:09:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Enable Aldebaran devices to report CU
 Occupancy
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221116165407.2285608-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221116165407.2285608-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: ced941db-1f7a-4085-73db-08dac816da05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FooVeVlcaA+7sFbrX8V75lAP7wL4ADhiN4sVKtGxlaBNWngfYdEhfai5EJgUNh5sFVLrWxhCCsKRIPyQK7kZAA8xwa9yd1arxk3ZEKAbh4FTmNemsEfYOvSEh42ZBbNlHw48Luc59tRm0eC3rzCjlHUhAQya0hDqDVncXOUQ3gZEZ6NSmI3LhnAGN9A73haEfAfwQUOoI6vAxQMHX5EngVkoBNA1cmiVXrthSRQduxUvdq3HP6jWRD+PMxK54UuoSDReP5Z/y4k+0tYzlrqxepOaI2yKqqZq+sym/CDbSlsUCqImCU8K0miiCdkdDQUdYkyA6tlLpfIgoYZI7hUb8Tlv2uAKZsbOlLBCs158TT0K/B3QnId+A44x2X9TWnijG9w45qjoYpj1FL7sHDv2MKe1HDuM1WdTGwQU4fktA1O5zgd07f0qYyQVgk4nVN87A+hanHloUwiFLOgaStUMdOietq1woglLz2LZtGbGUcoC2V9RdgwB9GR8cKJX0PUevhfshu1jw0w4J62bnyhOLcIavAFAqAvNvcBkYmd6jrlAzQxutMR3AQ9UgNdOzkm04i7u2jxGZkGzXlh5b55WqCgFaBiXUQBQsHkeFCpxnT/o7Ak+nrI4YJv7CjkNLDBra9J9UTCYzW1FLHFEy+oOELoWfJGnckI9xLGOYKyF/nmVTBGn3MCSNjaN6ar/sLKh/1umhxegzSKKF/ztR4dxw1S6UWJT7dcn0+ohDcuREMkeNseSWhY0Q5oBDxd8Iq0QblfNtJg2JZTGd5vm69XsoOL4TXjU0TDK+O5VjhEPRZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(44832011)(2906002)(4001150100001)(316002)(66556008)(66476007)(66946007)(8676002)(6506007)(36756003)(26005)(6512007)(8936002)(5660300002)(186003)(2616005)(41300700001)(86362001)(31696002)(31686004)(478600001)(6486002)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNsVFZSN0pMcUVUQVV2UEV6bUI3MHRtQnZjckVCbXNYZGx6WStDa09KcE1N?=
 =?utf-8?B?OTdMNnBFMmdGMC9OeXRZcFVrVVR0VWxwcHY2MkhvdlIrUmsyNTdMQlh6dHRH?=
 =?utf-8?B?NHN2LytTZXNMR3k4RENlL0UwKzNHTC9xYXBRT0RIZm1Xa2p1ZW9wa1JreDZ1?=
 =?utf-8?B?MWtkeXM4RWFUK3hZVWVIWjlEOTRYTjhVZ3hhdFcxTTAzUjNPRW9SYlVVREk2?=
 =?utf-8?B?cWJTd3Zyakc2TWU3dElQYmJnbU9XcmRGUldQbDgyemRuWU9RbkhxeVB4YXFI?=
 =?utf-8?B?cTRUMXord2ZEVWdzSWRJaTNVTmc3UmplWTh0V0dIVGpCRlRKd0hmRzFBZThM?=
 =?utf-8?B?WmxlMkl5ZzY1bnlNWVJtL2M4eUNiaVlkTkhlOXZubkJjZ1JrWFZ2cDRPL3RV?=
 =?utf-8?B?U3J2b1BMNlIySXlma1MyMm8rQnVjUnZ2cGl6MjJoYktEY2duOFRFNkhYWVZ1?=
 =?utf-8?B?ZUpVUjM0VXVNSVcwUG5kekhMS3kzTFBKM0hpZzY5aGhjMnRObGRQQ05NT3Vz?=
 =?utf-8?B?Q3dUcldQUTJJemdUUUFhRTIwTFNHbkQxZlo3RHg0SVBBVFJhZkQ1ZFBXdjNq?=
 =?utf-8?B?L24vQnVBM1dqSFVxaGVvNUZDaDdxR2RxTmV4NHpQUlVRbkZ6MW9RQkNOaURK?=
 =?utf-8?B?QXplM2cyMEJjMzQ3TGR3clJZVEp3a1d2aFhRSzBaa01GRHpvRWUzd0RqY2th?=
 =?utf-8?B?VVFNenMvRU1mTllyWlJLWS9HVGZ2SUdsUnlhd0dRUEJOOXIwemt6TUptS1RH?=
 =?utf-8?B?RExudXhESW1qcmo2aWNGbXJsT0MyOElka3pYR1RlZENrT2g0SWF3bGlCSFV0?=
 =?utf-8?B?ODR5QWtseXo4NkdpbmFyNTFWcEN6alpHcVIxSEdHb0I2dm9xYWxocG1sblFB?=
 =?utf-8?B?N0VHdzU4RWVmVVhSSWZLbEUzR2FnVytacStWZXdlazlxaFBwdFo4OGpWdmo4?=
 =?utf-8?B?MllTYVpJWmU2L2V6NFplU0NzT3l5OHM5emtmYi9Cd001aWo0MHVNdTE5RTJ2?=
 =?utf-8?B?eHdNeW9zNng3V25Fa0RMa1A0ZFF3MVpKcnYySGp3ZGc0RG0xbDNLY0t0MWJJ?=
 =?utf-8?B?MzhnOGVma3Q2N21wNHJ1MHAxbTgwb21QRGpmNDJINEpDYjJ6MVpLTzNLN0o5?=
 =?utf-8?B?NTdLeEJrZ1pZOVhNc2ZLVSt2RzVjRjVTdEU2THZ0SWJmamp1S3NpZDRyNjdM?=
 =?utf-8?B?eTFOSEd1L0dPa1dGTzRicEgxSzZQaFdvVHJlZUZhaTN3WWJ6NVhJZWE4ODRt?=
 =?utf-8?B?S2dVUDNkcXRjTEg4UHVKbyttaHhURmFHV2ZXREJPdlpiWDcvN3ZqYkhXVGZX?=
 =?utf-8?B?UUsrT0ZweWJoZjBRbW10MVYrZ3dzaGhxdm9FSVdUSm1OVGhrT1ZuZFV1YWxr?=
 =?utf-8?B?NWRORjVDNHpTMnJlcC93UmlQSG5YdHhQcUcwSktmanpURzJCSFZqd0ZnZU1u?=
 =?utf-8?B?STltdUh4azBRYTBpUVEvSGFMd2dDTlBNOEc5N2hkVkM3QkFwTWpoSkVsd0g4?=
 =?utf-8?B?ZWtrTjZYMWRBaWFyUUtwVW5aVFVFb29MM05xaFNkYVQ1S3RJQXBxMTlUa1c2?=
 =?utf-8?B?bUU3bGg3ZjJlSHBoZ1gxcld4TG9NYlQzbGtDVUhZd1ZiblViVi9nY3pOV3d1?=
 =?utf-8?B?djNzakFLWUtQa241S2lGNDNjR0RMMStaZEpuTVNkbEhkOCtlWkc4dmpIWklq?=
 =?utf-8?B?eGJwdjVhZWVKNXRpbFFkQU15elY4VW95b2QybnNlMitvSmNiOHoxd29sQ3FP?=
 =?utf-8?B?YWJobS8wWnlyZFRsUHoyMVRpbUJ1eG54YVUxQXg0b0kzN1VUQ29YdnYreVFW?=
 =?utf-8?B?dVA3RUlYM21aMVdpaG8vbmloK2NsK0FRNHJsbVV1ak5kTmovbnFvemRVZUEw?=
 =?utf-8?B?LzcveldzeHJLSEdzeitsd010TmVmcncxNGVreFZWdCt0Z0hNblJHZDFFc1Rq?=
 =?utf-8?B?cEZyaWhqN1N2bGNHNGJQV0MvcHdoM3phYkoybG56Y2ZLb053YWNmWHdXcml3?=
 =?utf-8?B?WHdqbTJIVXFKMjJJMEdVem9BTXJ0STBHVlc2V0c4VUV1T0FOZTUrN1RPak11?=
 =?utf-8?B?VGFRaFJFQTVwUnhNUS9lYVl1c3dUenZrMU9kUVdpUUhsQ0VVbjZ4VzhuaXh0?=
 =?utf-8?Q?iugTqZJC4dIYoU2ymE7lY2yLl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced941db-1f7a-4085-73db-08dac816da05
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:09:30.0378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zL6jRnGKEDDfc64gJfpyz05fGn9kQEe/8g0MivUnj88OiL1E40cTGj9FvF2XHCtej4DziwP+AFISDBow0deVpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
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

Am 2022-11-16 um 11:54 schrieb Ramesh Errabolu:
> Allow user to know number of compute units (CU) that are in use at any
> given moment. Enable access to the method kgd_gfx_v9_get_cu_occupancy
> that computes CU occupancy.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index c8935d718207..4485bb29bec9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -41,5 +41,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
>   	.get_atc_vmid_pasid_mapping_info =
>   				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>   	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
> +	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
>   	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings
>   };
