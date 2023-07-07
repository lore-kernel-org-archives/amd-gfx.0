Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE9DEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 11:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA2F10E568;
	Fri,  7 Jul 2023 11:53:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3628B10E56B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 11:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF9y68xUAXZSV2G7pnHqu4p+yapM4O77Kl1kkleNommAzCNQ3dCCQHs+Vap2lMrrtofBKE7g8+RBwN4Cakx1/EnqIyxBJ/q7WJGsnB01BCzI4VhbM0Vnd28TQnbN/tdL405C5BmJc1mHXs0nm9bh6l3oEJD9796DNya/IN74ErYnnLVLayh9UL27q1vKNBTvn9GtPsTig1aqk/Um7t0m4JbD7OdnxC8SODxzHjnOdCZJRSetyTA2xkLcn6+m3PI6A3jKRbmeXnNOFOmke833sGpo2rplpk2apVeQBOMcYLO5aXVYvoAu9bWArtmygzkIvl+R89Blj9g9gus573k+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/kXVbtlzr4uxsQGBcdeDDUGYtaZlEWWqsktxGQHT3o=;
 b=I5KTPEDCayfHPtDCKmpTpMncVNA/qoR5UJsqddp7XG/EnBLtCNAW/iay0lQujujIjPzUYhZ1AMSMjgHOITsT6XYUtXJ6pXH/PHBfBgx5ZwsbIjWP5zPn1cRQxfy0x1zrcW39c5SFGHMi40xP9mu16GRYmW7k0cuTz9HHXzUeUqeR+3rZ+W5zigZlDGy+zT+qRSTiHUMBTd+zGaB+GNDUeiNtlmifITUMkgOpz3CQJ6ILwqCvc9T7n238OYnukXgnld4Ozvtk204bAnumCNebbZ9/j7eoHF+5e6To8OebvtnQNlXLWtHlCpex2IPrpbwPTHg2B2geJx6UWMj+6LFqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/kXVbtlzr4uxsQGBcdeDDUGYtaZlEWWqsktxGQHT3o=;
 b=3mjxHdDd0LPze3Y3u/hu1AwRTRiXBMfvG7hXGgOzuHS5AXqplz96Ka0/qDzuGF64p8cdhLBjwjYb5Dc9fV7R10vYY3ZH7SHbOhd1O4HqgoyA2B278aPvyk244RafhhrQbULczpSi05wQNGEnQULkPFIcU1tAukdaOwPypJOAbQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Fri, 7 Jul
 2023 11:53:16 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 11:53:15 +0000
Message-ID: <c5870444-d0d0-aae6-5de0-177983f1f224@amd.com>
Date: Fri, 7 Jul 2023 17:23:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: correct the UCODE ID used for VCN 4.0.3 SRAM
 update
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20230707113144.536043-1-Lang.Yu@amd.com>
 <cb85f638-50dc-e921-d7e1-726df48e5357@amd.com>
 <ZKf7rMHFKWOwwHME@lang-desktop>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <ZKf7rMHFKWOwwHME@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdade3a-a772-46d9-1a84-08db7ee0bf8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWuL5ImUHc6Ncc7Tu1npfaXng1fSxgmv08m+uYbeAz3wIqJAk8BY3S+x0eCRt0T5gc3a4L4Vfr55BVFfmHG4zDLv5VpsyxdpzPOhAZ+aHgt+QvDzFiLKhtm6z7KNjpeMBYp5+oNoCgf0c4OMFmKQu/P0Ctf1MP1pEEgK1CkQlL1cytKtWJgdgDqAd/UcfoiFNQVMq1W7FaHuQpubas820dHb8Xnot8AZ6ktE7CiU1VbqaoTBZVFywGBkbASIJfv2WyX2SY/IjBWV3IkSLVZiVScK6cTYS7Oq5IqOl+xxgTmtA+QV2P094tY5PKwPaF1n4ARBr5BlozOUI3baOmPEh9BsVbOSLep4UOWZDP3FNrimFi/DjBmQmJkx05hAOLoso+gC1YjSZdIra2ArY8V4+tJsxQ4swbozog2P0suBkC/y59j1KQBhG04TUhFK2UDBv2sYPvoOKzHRFIuhTLZMG5r2oY7Zcz7AWZtD2/A+3WXdMnVt4Iy3WKdH6x0pGVhaPYE7zvIzbU1ymDfhJzP4pNFeB6egy94SqqZy/wtwcEB0Xoi0hz1AhusCsxG6bLqYIElVu3uplKM4Nm/L7djyL4EQg7B433RB0pSNl6GhPOnFMIYVRAun+py49HlAh6VvumI1Gqt2Bq4XiNNYTQgj+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(2906002)(41300700001)(8676002)(36756003)(6862004)(8936002)(31696002)(26005)(186003)(2616005)(478600001)(5660300002)(6506007)(6666004)(6512007)(31686004)(6486002)(53546011)(316002)(4326008)(66476007)(66946007)(66556008)(37006003)(6636002)(38100700002)(83380400001)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk9pVmRqazBHR1JTTlh2T3psNC9HQnJTbUlCTzNxWnZNazdZTmV3N1lnNXM4?=
 =?utf-8?B?VkhaSHFVNkZyV1VQL2xvNWIyczF0WXZlSm1saTZQNTZWTGhJRVkyMmlLZWVm?=
 =?utf-8?B?dW5DVyt4UWhjNlVGM3ZOS2pXUEo4YXhBeko0bVkwc3RCVXJnSnN2cVdjbzI2?=
 =?utf-8?B?elBEZFp4aTdDMnBkYVEva3ZpNm5uYjZLbGJnUUhPRnVxdkorYkNaUDNKYnZt?=
 =?utf-8?B?SkNVckhIZWNtdk9TSXhHMVVLWjFCL0hBb0VzWkNGdE1ndmp6R3Fmd0dOMC9U?=
 =?utf-8?B?bzhoT3FuOHB4QkxhZ0d6QjRUanlpcEdIMllHOHR1QXplaE5MVDZTcUhpc3VD?=
 =?utf-8?B?cmxxNkk0Qk4wbzMrT3NVNStqOE81WjBHaHhtcUN2L0JGZkE1WmdDQVlIQ05T?=
 =?utf-8?B?Y2lsWHg5NExJTkdlMU5pMXlrMjFxRTk4ZlhSTUlwNGF3Q3VoZ2k0ODRJQlRD?=
 =?utf-8?B?WTVNK2d1UkpWZlg5YTRBaW5iRHo1R2d4Zko1OTMwMVNteWhlUmg5NE5pbTJm?=
 =?utf-8?B?SS9KTkhWdmVWV2lZa0NXUDVIcmhSRkIrQTRMUGNvMUdwU3laVDlXMkJJYllX?=
 =?utf-8?B?US9JRFhIMVZ6dUtzNXkyUUZ2UlFaNFdjN3ZXZHh3UEdtS01NOXZzK2V4UGRZ?=
 =?utf-8?B?Nm50MVkyVE5DT1hGZjVRNmpYV2ErQVk4RUxhcW9WSGhiR0xPRG42Ym1NdnBB?=
 =?utf-8?B?N0plV3hwWnBkZnFqN0tCMkY5WGRpMTlnYXBSbjlhUnpYU0c5eHQzdWpHRUhI?=
 =?utf-8?B?NFZ6ZEh6WTRrQmVxTVVZVlMwWVlYV3hQQmhXZG90UHlVcjJUY3NnSTZDMnZH?=
 =?utf-8?B?d0swRXBLV2s3MHQ0TEI0d3lFVzRvM2xzS3dLclBuK2NwR2V0TFYwbE9sdm12?=
 =?utf-8?B?ZlVDRVJINCt0aHpVdmYrWVVJMTg5UXFrQnhMOVdzOFpPQTQ1T09zNGZoclJJ?=
 =?utf-8?B?MVRPS0xCS21la0t0eUUzZ25UK0o4NG9uS3VWWmcyS0Z2S3lzNmZnMUdheDNH?=
 =?utf-8?B?aU4zNjVBVndacTBQMndhUDdOckNGTGJmLzRwUERCd29RT0F0a284L0VsWmpv?=
 =?utf-8?B?OTRENjhWbHFJb1hMNzJHYTBTaHBRZjNkeUZ3VTAzd1BJZUdRTkdEakpKN2VI?=
 =?utf-8?B?Y2ZsTE5lZW4xc3BFbm55M2NiN04vTVpMUFQyNjQ4TlpHWUpFS2o4aTZyMUZC?=
 =?utf-8?B?MFl0Y09LOWxKZEQyUkZ1VnFrVmFObVhKUi9uUDdkemhQWVgxVUVCdE1kVVBT?=
 =?utf-8?B?VWYwWEdmVmxGMDdyNURGR1lVV0d6c2JzKzBRa2RKS2g1NGkyRDdIbEROdktU?=
 =?utf-8?B?S05kWEs1cFpoNE11bEdTMi9vaFk1ODIveG5ndFZjc0ROZXBSeEthVHU4LzRz?=
 =?utf-8?B?TmVTUXdvNkZpejRPVGdWRTJmeE5ZbGFEdlFQNWwrNDRLQStpMHRmelhHUWcy?=
 =?utf-8?B?dzk5OTFmUklJNk1vMUNSMXpXWWlHWHFZUGVodi84NG1TRzdtUzM1L1UyUnZ6?=
 =?utf-8?B?VUhBcWdtL2NSdDdQYnBHSDQxc0hZU0JJUEozbWpPWHVSSDVTWUxESml0MGt3?=
 =?utf-8?B?YUx5dDFieTBUWER3bWIrb1MwcDZZZiswaXBXdWRmWDFLNnQwcGRFSi9BK0hQ?=
 =?utf-8?B?WDRqN0FrSHJsUmUvOUdWamdmOG5rdzdJb21EbUhPcndNLzQxM0dYeThzUUVW?=
 =?utf-8?B?YWZxcW9nTTU0cG1TZFB2YnoyVnNQdGdyUDdxVGVGdk1yRlN0bStIS2FKOUVF?=
 =?utf-8?B?dkltcDMwVTlZdVZwWDB2SDBvUG15RWJ5bGFkcy8xNFBsVUVZWWtYMTkzZ21r?=
 =?utf-8?B?NDlFNGMzcytCeWtEbFhHZ2MrVnV5MFNBQU1HOTQ4N0l6eUtzZDZ4Tk5pYkxN?=
 =?utf-8?B?Q0E4b21Wdk54WjArQTcreWRNaytUaHYzMks1bUE1ck40K2U1eDJ0UThLRG5S?=
 =?utf-8?B?YzlWOGZRWWg0eEtLOVBPMEwrdmF2WjdHR2xKUG1qN2VDbGRvUUFGbjBVTWJl?=
 =?utf-8?B?YWp5WDFNMkNvQWdWaUlVM1hlM3hEbTd6VlUxZUNNRXI0Q1lvdTVqMjVzQUQ4?=
 =?utf-8?B?b243ZnZtWjEyWEgwblozcjNlSkNITFpnUFhoU3ExY0JBaGF0YUszcFF5YVJR?=
 =?utf-8?Q?t6K5xLj46Ii5scRpecSmKS547?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdade3a-a772-46d9-1a84-08db7ee0bf8f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:53:15.8029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ruiWbNygOyMcUbGC7ISNwYvZD5ObhPtVnNDKH9NtyWqp2BciwjECwOuCQyqB5MC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/7/2023 5:19 PM, Lang Yu wrote:
> On 07/07/ , Lazar, Lijo wrote:
>>
>>
>> On 7/7/2023 5:01 PM, Lang Yu wrote:
>>> It uses the same UCODE ID(VCN0_RAM) but differnet cmd buffers
>>> for all instances.
>>>
>>> Fixes: e928b52c58dd ("drm/amdgpu: use psp_execute_load_ip_fw_cmd_buf instead")
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> index ce8c766dcc73..8ff814b6b656 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> @@ -778,7 +778,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>>>    		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
>>>    	if (indirect)
>>> -		amdgpu_vcn_psp_update_sram(adev, inst_idx);
>>> +		amdgpu_vcn_psp_update_sram(adev, 0);
>>
>> This doesn't work either for passing the right buffer. Could you revert the
>> two patches? Not seeing any simplification with those. Previously it was one
>> psp API to be called.
> 
> Oh, thanks. I got it ...
> 
> The purpose of psp_execute_load_ip_fw_cmd_buf is to serve other IPs,
> they have same use cases like what psp_update_vcn_sram does.
> 
> How about just call psp_execute_load_ip_fw_cmd_buf in VCN directly?
> 
> Or revert the two patches and add some functions
> like psp_update_AAA, psp_update_BBB, ... for Other IPs.
> 

At least for now, I think VCN is the only case which requires an extra 
specific ucode API. All other ucodes are loaded during psp hw_init.

Thanks,
Lijo

> Regards,
> Lang
> 
> 
>> Thanks,
>> Lijo
>>
>>>>    	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
