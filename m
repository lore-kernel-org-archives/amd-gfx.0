Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F6CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 01:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6255810E0B0;
	Thu, 31 Mar 2022 01:45:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747BD10E0B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 01:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRuOGTo5ma6GZMIlArcUtLLje/JRzqUMI1CizykJjOfe96+Gi8Cco+QTcGNBsHjLwPU8z6gEtEooPaSJSOjmdEsGi8G1ppdbGj8sOKOORAjFqaLQLHnjDX0a5cfuV/nQHBWfnHyQdIyXa98Q8zP2r+ccHyS1ZcJaWZAU+Z2hoxFcjPtOARppe6sgbvVQ5YFezQIJZ3BwudTazpFpBxUgKQbSUnWXWKuF/QOfNNb9zcJbZIWcS8g/Zmm2w7RxZmrhdqCb0O5NcZX2Ox4c13zQq79HpyFxbn0pn6Ib5D4v6RW43CQ6n11wUOnr4JbLjl/rL/Lk7fc3BFQbjxxrcxOcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6p85Od72i5z1r5WqaAQ7fGk138Dug8Ov+iibwI7nNY=;
 b=gk9BkI0MFV6EIkipMTeGFXvEWxx7kC1w39QzFSV2NEDCBlBnN0btpLFf0u0uHL+7PJ1CvlqcCJBDhI1M6at1E3d741uphc7j11KPhzHYAKUzXeWOM0ICivpI9xWr8K4f0l79UF+fi3my1/XLyL3LnJNhqwrR5ou2kHyVL4KoD1eMZrmBo2qpi/lanhu/9rmMusMShLGEnC4LDxCPnY7zAWNrwhX3b4RezrrqLhaUuspu9vXg2Z1TiJkPmS2YQQnAS+PC22q/w/XuZWql7NdFIa+Q04qc/U2uACDynRvs3SFD1HeVQNa943nZeE8aRrJa6m53uXA7OxXeVQjQk64Q9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6p85Od72i5z1r5WqaAQ7fGk138Dug8Ov+iibwI7nNY=;
 b=IQeQXYOtSBzMQAPkqwhHMz7veaPcxIDHdzckRwDG8M0ypYENecvBRXA/dc+pjholLBNCXFR+QXtX7UbsFWZ5oA9tSriCj63GN84KX8aE86ItEHqUJqsClCclMhpHYj/wIKZRP0Mm+kXBFm2clsp70YuxDH4C0FZ46DZWgW5ui3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 31 Mar
 2022 01:45:06 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::7df7:f003:d827:b5c4]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::7df7:f003:d827:b5c4%2]) with mapi id 15.20.5123.019; Thu, 31 Mar 2022
 01:45:06 +0000
Message-ID: <31d0aba7-29d7-5ca2-8978-2bd94907c05c@amd.com>
Date: Wed, 30 Mar 2022 21:45:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3] drm/amdgpu/vcn3: send smu interface type
Content-Language: en-US
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org
References: <20220331005949.34007-1-boyuan.zhang@amd.com>
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20220331005949.34007-1-boyuan.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc6e7924-7df3-461d-7ea6-08da12b81488
X-MS-TrafficTypeDiagnostic: PH7PR12MB5656:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5656E71B4496DAF6EDA264E6E5E19@PH7PR12MB5656.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EXNvOMFV/LggnhXe/i8jZtfrMu1PBiQFN+c6IUte5TNHy0kRt3C8Zk2LVCpiSY7Hnq0ES3geTbZROU4TcKU8tmSsEfobdtAgJaeHKxfYZYFk4tK1AaBf/HFJL6DtKBXfPP4pM8xe239U51f5xThoHrpp7OFbPdDz3suDWAeHOYXhowTmjHHckF+dxAveJj9NjkU820eYhaAZseBiiMG5huNwlN0pSW3dHHyPCFh4/67pWIXlilaJqHKW5NnfFqMCjHgC4uqm54UQ8a47QreBBRKkgYEQfnXCpd5UNiJmlcJsBIAJWOzVBSqYog2Q3O22A90w+TuuF2nwklXRUvwxeEOV2WPu91KPObSzYUqAYdmcjTFJYRCByPkwdsKR4LwvS3PzqKGLEvvlZdmNxB1pwTQm03kYjJJbIA/WzkVh3Jp1leVt/LagraZ7RHhPTwIagBXRrSsjYu4gyeWMiNd69KzrMXnPlrE59iTvuMM9c9rnAEVNJhBcp55Up13vuySEnE7X0HfHQj+cNhxR220SPDGZKu7snIoFg0HXcQto1hIF7sdPNtXpOAoJf07JVX8Z3mcQ5MOZV/oJevmARazmXeqaSpdZUhHFGLhpoXsNiDzC/2lBiSagc3pNs0TzJyPdL1qkpFACSrsVZRd2GI/IJyDJH/okuxIsNQiQpgYwdedNCMID9mPciDTqvDIN4wxJjuZfRsv0nuzxg7JquhvByAOlsX1eAKzfydzK0UG5Pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(6666004)(86362001)(31696002)(26005)(66476007)(6506007)(186003)(38100700002)(6486002)(2616005)(66946007)(4326008)(508600001)(5660300002)(44832011)(31686004)(6512007)(2906002)(316002)(8936002)(53546011)(8676002)(83380400001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZPcVRUUWY2UDBEcjBvbzZGT3hzQnhyR3ZhVENVaDh1S2JTTE8wQXdNYjU4?=
 =?utf-8?B?bGlRdkVxaUkwbnhvNGtuUFhGV1ZkMXFoSWJzV0dDdWJpV1UyRnQ1THlya2Zx?=
 =?utf-8?B?RmRKaU0xbFV5NkUvVTc3aUEvMjBFQjJ2a2xiNkcxaEFiNnlOZ0tOczQveU1Y?=
 =?utf-8?B?Ung5djZSNys0S20rOTYyUzFodVM0K0IvcEhCYmNta0F4c1BZSDBkQnk0T0Vo?=
 =?utf-8?B?c1ZhZ3NFN0w3bVk0ZU9Ld1F3blphaDVVWCswcDJIT1JYSEVLdjFMeDNZYmI1?=
 =?utf-8?B?aklYRFhRSTdPTnh4MlZVUzl3Z3FDY1BlN0Yyd3NIWHZkVkpXeXFhWlhmZS93?=
 =?utf-8?B?aHk1MjI2MWZIM3h2QUVaQXdRMjl1dTVhb1liQVR1V1Y2eW44SmZYbFd4Zm5t?=
 =?utf-8?B?bTNvdHErWURVdENZbENKWmdzSEY2ajUyRStQN0Rydm9CMmVRRVlWZWZnTzVE?=
 =?utf-8?B?WnYxUXFpdytxVGF6bnRjR2hDd3FXM2JlM3ZIOTZxeWhyTkRQaGVrT0UwRXY1?=
 =?utf-8?B?NXE5d2hZNld5RVZVem1wOVlMRWdCenhMdkJIbnlNaWU5eFhCSkZGV00xaXVl?=
 =?utf-8?B?RXJWRFZvUlhteUJ5cmg4ZWIvWHU1T3pOV0tSM1E3c0Nack9TMVFJc0hRVmV2?=
 =?utf-8?B?ZXBiYlVyUGNYVDlud0dFakd1cjhBa2lLNzJsZDhnemIxR3QrZkdhL2FhL3h1?=
 =?utf-8?B?U21mRzZCRmtZdEtNb3hCQVR5VkZsTUNrT2dkcXdtUG5Za1cxQTV2TU0vMVhj?=
 =?utf-8?B?ckdCRkVWRCtORWtIdHJOZ3BQWTJqVXk4K3JaVFhleDU3LzdkemJVLzJoeTFo?=
 =?utf-8?B?YWczSHBPWVVkUTljUm54TDVEY091N0g2VGhIVzhUUlNuL0hXMHdkajkyR3E2?=
 =?utf-8?B?VzJ6TmlERE5UT0piRVd5TmZWbWRveUFzaXdqTjR4RFpSNWM3VDEzY1k5NWYv?=
 =?utf-8?B?MW9wRnlGUkFmR0haVXM5ZzJrWHRHNVFOemJlZ2JCSElNeVZiRGMwQ3JNQmkz?=
 =?utf-8?B?eitEUEgrRmlFdEkrQU1DZ3ZGa1pDVFR2RmFJSlNobjJiVUVRMkZNZy8yeGlV?=
 =?utf-8?B?NVpWNHdPWll0SHFibzFXVzhVcWlJeGd2dk55SERGSGRjMHpYNUkxc0JCcEhT?=
 =?utf-8?B?Ym8yWExDYWg2WnUzTWZEWFFoNWlFNkhMUFNqL1RuK2NNMTU1UWFQQW9BUkM1?=
 =?utf-8?B?Q0pvTUx6U0c2N3RsbHFzTnU5S3hTN0ZDS1dEUUhoclBISHgweVZqMG9aU2ZR?=
 =?utf-8?B?bmUxcmovZUE2bk9qem9KTzU5b0pMNFFFYkFnNGM4NEpvQ2NwUzJYVzhPZUpU?=
 =?utf-8?B?Z0g2VEVTQlJDODhnRnRUeXFvbUg3Zkp5YkRIUjFGVWdzMHBySW9aTnZjd1g3?=
 =?utf-8?B?ZCt0eVBkQzF3dTAyUDZOTHkwWS94UXFLR2RoYXFXczMwaG94ck9uL3BzU3FV?=
 =?utf-8?B?d21OL2hZQnBoOG5oMzZmZzgzTFdBTTNXWFlHVUpBZUVDcVZjSlNuSmxOdFpN?=
 =?utf-8?B?Vk9qSFdyTVZ2a0xqbDlSeTVPNVBBTXRwdXN2ZnlFWG16d3YvVXBzRCs1bmxH?=
 =?utf-8?B?cys1RFZpbDFtNVZUeTFoUjg1SGlITjRhalJ2MVdFYWNvU1Q1RnFoUXdtVnAr?=
 =?utf-8?B?MFNtUmRwSEFlcytXM0VOYTh4NEp2NW5rRzk2UC9XYTVvYSt5djlOVmV0VjFK?=
 =?utf-8?B?cEVJcTZhb0UrREl3czVxblVKY090L1BqVkoyeVBiRjQ0ZGYwNlpQVUpaSVFz?=
 =?utf-8?B?UXk1OFlLMEJxL0t6eHhjekVDUGZWMi9mRWlicUVnT2wrNFc4ZUh2bVJLYWlJ?=
 =?utf-8?B?YlRwMFB0Szg4cno3V3Z2UjNManpFbmpWSXdZRG9mWDdvaFVxZ05IYWlJcE93?=
 =?utf-8?B?c1o4SlFYZCtWNjM1NmpCbWZzWUw3eEdHZWcrbWFqU04yQXYvWnQwbENLMXZj?=
 =?utf-8?B?WSswbVpDbHdXVmNSRElWUkJuT2lML20xZXJXbHozejVjZkhjbnY2ck9LMW9M?=
 =?utf-8?B?WlAwdHdlUzdHaGR5c3NvcEprZysvTVorMnppMmlZRHNvcFdzRHowb3RyMDR6?=
 =?utf-8?B?TXZZMUpaWE83ekNBR0c0U0cybTVZL1BSdnB1VUpjWDlMZFhtRDM2TnhGQllT?=
 =?utf-8?B?Zmp2TnJnYTBybXFHZUF0ajlLTVNEdllMVFIzb2l0UVBvYjJKQmk1eFErV2dY?=
 =?utf-8?B?RG56M09FZW5nV09HdDMvS2o0YThFWUlSZ2lpeDdMdVBlSkRTU3EzYWJETTN0?=
 =?utf-8?B?ZDAvem9NUXVvbFo1SXMvRjl2ODJ1ZVpjWGpuemR0TEwxSHF2OWFicUJVK2V1?=
 =?utf-8?B?RGRsYnJnY2txZVlLRERrK1kyRXBCWGNrZGNqcXJlTU1JQi9rUGtVQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6e7924-7df3-461d-7ea6-08da12b81488
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 01:45:06.0537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW6zpVAL8YX9LWfexOtWQVxa3hJMIqzkXLmqO8oD/wVGYUaIql0Uy3dKPGQZojXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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
Cc: alexander.deucher@amd.com, pmenzel@molgen.mpg.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2022-03-30 20:59, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> For VCN FW to detect ASIC type, in order to use different mailbox registers.
>
> V2: simplify codes and fix format issue.
> V3: re-order if/else condition from the smallest version.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Acked-by Huang Rui <ray.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 5 +++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index e2fde88aaf5e..f06fb7f882e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -159,6 +159,7 @@
>   #define AMDGPU_VCN_MULTI_QUEUE_FLAG	(1 << 8)
>   #define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
>   #define AMDGPU_VCN_FW_LOGGING_FLAG	(1 << 10)
> +#define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
>   
>   #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
>   #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
> @@ -279,6 +280,11 @@ struct amdgpu_fw_shared_fw_logging {
>   	uint32_t size;
>   };
>   
> +struct amdgpu_fw_shared_smu_interface_info {
> +	uint8_t smu_interface_type;
> +	uint8_t padding[3];
> +};
> +
>   struct amdgpu_fw_shared {
>   	uint32_t present_flag_0;
>   	uint8_t pad[44];
> @@ -287,6 +293,7 @@ struct amdgpu_fw_shared {
>   	struct amdgpu_fw_shared_multi_queue multi_queue;
>   	struct amdgpu_fw_shared_sw_ring sw_ring;
>   	struct amdgpu_fw_shared_fw_logging fw_log;
> +	struct amdgpu_fw_shared_smu_interface_info smu_interface_info;
>   };
>   
>   struct amdgpu_vcn_fwlog {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0d590183328f..508b3d8464f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -219,6 +219,11 @@ static int vcn_v3_0_sw_init(void *handle)
>   					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
>   					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
>   		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
> +		fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
> +		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 1))
> +			fw_shared->smu_interface_info.smu_interface_type = 1;
> +		else if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 1, 2))
> +			fw_shared->smu_interface_info.smu_interface_type = 2;
>   
>   		if (amdgpu_vcnfw_log)
>   			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
