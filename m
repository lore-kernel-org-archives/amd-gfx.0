Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F75C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 01:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABFA6140D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 01:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABFA6140D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4432D6E931;
	Wed, 21 Apr 2021 01:22:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBFA6E931
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 01:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm5UiS4n5fqM/rp1dXJaVb6w4TBK/NCvrQXq86z4N90s+xg27F9R+kH0+O7iwVvjNGnsZuGaFiyAxa4F8qHK7iP/6ZFlLDu5fLsY/l4HOStdhHVqKe7YS95i625190y5z0OgqbyxUjU+ZEkKBQRuD0UZ4VXzegwTO/BPC6FC19wLbD9RKrcD5DRnO63Bsp0/8LSX5WiEAQ5DOULeAZS6FNe/N/RQySZLqcHJqncDpsqql2TExXFspARyNZj6jVmScuZS5P01L4AIEDzjvKwTsLz0ERarvLnN8UkbrBgSPQbkiNbE2Zn5frD4CxtuWtJovUsIqxFW/WhOkiW0CQ2TSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJo9b0lkZBp4v+8GQHz54qrc1TeEKFPTO7h9uLW3fCs=;
 b=eLkreutH15QziVJ07zTAqyu0zr7c90aRXaz+u4f6kwF5gyFdJzpr/ZvfVK6LsBMLX8RV9qmrI/ku1uWSoBg2h51WkB4DrcjjeKGvLlZOcGzlg3v+OJ/6mkjhTVxHjmIhirL43DjVRSZ6ZzYNGiI+8Xb/cVLolTX3zHpb4bzcTrndqNS3dJE7ZltLMu3QD9siTW8yh6NbAGg5tul53rpk8TSSPD6sPjWEt7S+ITdmNmrDGPR3WaaRrZeUj05TXJtowqls6or6+KowbfSHD27eOF4VSVEr+N229/qGjjg7uk8jVT1rhYWR79zmM/vaMCn9zP04txbJFxB7codmvY6U9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJo9b0lkZBp4v+8GQHz54qrc1TeEKFPTO7h9uLW3fCs=;
 b=gyR7kPuwXY6VjxpjKDR77E/rx93pK26WuAA0hlMq5OMF5GXcljGd+ZtKfnPykcWbRhj1JFITXuZayPXES92AhL6XDHC86UNmRq+VCXXMAzn1ycpcZIf6sepdfrhVq12krHbVIkvLG11NF4NBZK+sRGI/30ldMX+X1SXvEMNNlNk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4783.namprd12.prod.outlook.com (2603:10b6:208:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 01:22:18 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Wed, 21 Apr 2021
 01:22:17 +0000
Subject: Re: [PATCH 5/6] drm/amdkfd: enable subsequent retry fault
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210420202122.4701-1-Philip.Yang@amd.com>
 <20210420202122.4701-5-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8d735d00-1362-4575-2eaf-53ff277e5db1@amd.com>
Date: Tue, 20 Apr 2021 21:22:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210420202122.4701-5-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.180.233]
X-ClientProxiedBy: YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.180.233) by
 YT1PR01CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Wed, 21 Apr 2021 01:22:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 353f99e7-7c92-44e9-d71f-08d90463e737
X-MS-TrafficTypeDiagnostic: MN2PR12MB4783:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4783A1C5C2EAD8AF0C44B3A992479@MN2PR12MB4783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ih7q6+vm0p97woG7TGHbeR25u6C4CYlFkX5H2QMATIyX/TTEbDR3ryw37lkVSDzMKg01evQUVsS5Z4d+Wb4quhznse4ljXgIumo4S4KhGPWIrhWxyPHvwQtGFP5ZFCq1Hss39fzPbmCfTrlDDGVCv27FoQRvacAlKzW6bPHf+90bEUExlMwzqI1Zcq87C25CLieoQTcnY9lY2PEdfGZEDRdHjwWJAVYdZ6fSPKZRgdU0ho5TCNIbqhtoyCn/23GikkljbfCmQcrT+N775E3nTNoEVhCXTDgTCuEWcqEWJqqMOd3ffjfZ4HrSdyj+I5h17SVaGftbW6DqSGvcJPNTWU1Vb4JzMU8fVVlhK9ci4r3WZyXLDM8s09VJHbBJMSb0PWniVg4CdPQyH47x6MkZfS7vpF0Getnhew4ZJkHqXMPMQxa0MushIT/151mjjBp4QMkVT7VP+fln76ABSPvIBSCZDS2dHejEIe3l7ksYaT3OblqOaWsAE27DfBavFdN3aexww21TTaXBbBTfhmltFVPmgzXIEhl3GB3KasKg3neex4kQSTb5B8LxSBrEVsKoqoozkwrUy/VltD+Sk+tBqv3tvTk+vSDcHgbZOYOq0vaK//THEisL2ZVKp0E9M/Z42JnHk6MhO4khn+248sgnksigdTAWAS1zoSAG8NEEeEkle7bpQSnFKwzEjD6yJ4kC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(2616005)(316002)(66476007)(6486002)(16576012)(36756003)(5660300002)(8676002)(66556008)(31696002)(31686004)(2906002)(956004)(478600001)(38100700002)(8936002)(16526019)(86362001)(186003)(44832011)(66946007)(26005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZEI5RDgxazR5T0hYcnRrbzI5N25NQWswd1lqMmxvd1hjSjdPTjNRejhwc01B?=
 =?utf-8?B?MXR2M1JJeTA4eW5Dajh0bThKeEZ4Q0hzRE9ZY2hOWDlwMlRYQldTckllVkJF?=
 =?utf-8?B?RTBaQlhvVWJPbWZ5VlNscGllS1phMnBXSWthdXk5OW4xRjNQbzE4VHdER1oz?=
 =?utf-8?B?TnNROXVLSlF4Sk9yVEJiTVpMekVGb3JMcDl0V1pjTzdjbEFFWmdEbndHeWJx?=
 =?utf-8?B?akh2bHdUZ1RjOFBYRUJFaHE3QTBYSlduNXA2TGZodzdBaFJFdzFtbC9FKzRB?=
 =?utf-8?B?ODlqMkcrS1YyNkl3ek10Z2l5UWVLN1dqYjRrRnFTN3A0VzR0QUhxRnB0M2RW?=
 =?utf-8?B?VmNSZmxTYUdLbEJhWUl5WkZ6TVR5YVZSYTZsTDdHbmhiWGxKVzNaSFl4YlIx?=
 =?utf-8?B?SmdxV0pmN1F5VzVscExkdll1c2ViRlJmb3BxaHFYMzVBZEE0VEFyMUhsdGRh?=
 =?utf-8?B?SzNvbGpuV3pESXBUczNXdnh5S0VOaENSZnQ2SDNBRThSYVpRUjhSNmtJR3Rt?=
 =?utf-8?B?b0V6OFV6a2hhcnd2L2pWOGZ5OHRaTXg4MEtubjZTVUphVldNTk5NMW9scng0?=
 =?utf-8?B?amdrMTNGV0JuSDhETm9OR3U0QlJ3b0hmc1UzRkY0MTJ0UWpnS3EvbHBnQ2VO?=
 =?utf-8?B?ZnJXcW9qSndFRkpPUFBFcklYczExTmZsUHpkV0d6QTV2YTJXR3lKRFF0ZTB2?=
 =?utf-8?B?KzI5cVh4THBWdGppSUdheVlnVjFyZ20vKzVDZS9pRENUd0RsZ042SzdIVGFB?=
 =?utf-8?B?U01GZVF6TFpQQlpKbXVJTVU0VGdwSzJ6SXBnNHBDdktFWVdQZVVwaFdRKzhr?=
 =?utf-8?B?RGcwSVFXTE5qLzNGeVg2cDBHaTF4Vzl5R0RPZjhJZUZtakFjdkNybDFwUU5z?=
 =?utf-8?B?c1BnWFpGcVdpajRrekRWT1FPd3F0M0xKbVhYNnVReXV5UEt3eW9RMXgvc0Rx?=
 =?utf-8?B?dW1aSHlwTjFoWnpRbk16c3JIVS9pVkxwQ0F0bG1tTjJyVlRZeC9JbExGazhv?=
 =?utf-8?B?VGNuTlRaclNvWTUwSVEzMGZoWUhSUWhZL1YxYytRcVVpT2F3N25LZlN4bjNK?=
 =?utf-8?B?aDQ3dkh2VExYSmx5d2VJU0xOeUoyVWM3NDhMVGhqUStjVjhjbHcxa3dtdHkv?=
 =?utf-8?B?d0NWM0NPOHV1bkdjb1J6UFVhVjdBbzc5TGgyT3FBbWR0OVV6TnNXNDRjOXp2?=
 =?utf-8?B?WVJiUFJOb0pEbXNYZGlxWU44OGlZN0EvWUZCS3o5d0xoU09pcWIxclNObHVi?=
 =?utf-8?B?RmxMZGtZTWNjWnJOZ0tDLzZ6bEhabHE3QUpjOE81SzIzeGNnamZpMjVlYXQz?=
 =?utf-8?B?NldGK3VCUENqaWt3WFhPUThCVEtCY0t2VktKbDBEQ1hzRmdsVGRRWUVsVVk4?=
 =?utf-8?B?bEg3ZG5PeEpjaThIcGtrcGlIYkU2NDRzMkJ3dmE4UE83SENlak9kRmhGd0hP?=
 =?utf-8?B?WVBaZ1VOellNYVpXTlp4QmEzdjg4K3BLbkxFcVJoRWEwWGg1a2NFdXFoSStJ?=
 =?utf-8?B?clVHNXpoRE1vK0ZVcU5XU1ZVM3ZnaEt5Z1V4ZGNOSTQwSFlRUWE5TGQ4Sm4r?=
 =?utf-8?B?dWZwT2kwMUh1YTdNYTJRckRsOE9uQTM3R1JPelM1MitGWndrUjEyL2tuMXBm?=
 =?utf-8?B?dVFLRExaR3RQWmRXbGVpQXRreGNMT0Z5QTd4NThnenVPRW15SXhra3JqcTRS?=
 =?utf-8?B?L3FiYjZ2UTl5cjF2dk1TZVZlSUptQVBHa3d0aFdwbUEzSi96NDNwQ3VNNTc0?=
 =?utf-8?B?d3dPd2NIUUh0bmV2VTU0QTJGNXVHZ2w1a09sTzBPRDdNcVkrZ2JnMnVkZ1oy?=
 =?utf-8?B?eXRKZ1UrN0taTEVJM0s3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353f99e7-7c92-44e9-d71f-08d90463e737
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 01:22:17.8708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QfrYo+g9bTzT6qaRinmvq+IR5Ua8TyY+r6WGwJNtb6hCXSUcNhgxtXkrMWazQanZDv4B+wRSiwCU4Akha9OAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4783
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-04-20 um 4:21 p.m. schrieb Philip Yang:
> After draining the stale retry fault, or failed to validate the range
> to recover, have to remove the fault address from fault filter ring, to
> be able to handle subsequent retry interrupt on same address. Otherwise
> the retry fault will not be processed to recover until timeout passed.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Patches 1-3 and patch 5 are

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I didn't see a patch 6. Was the email lost or not send intentionally?


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 45dd055118eb..d90e0cb6e573 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2262,8 +2262,10 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  
>  	mutex_lock(&prange->migrate_mutex);
>  
> -	if (svm_range_skip_recover(prange))
> +	if (svm_range_skip_recover(prange)) {
> +		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
>  		goto out_unlock_range;
> +	}
>  
>  	timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
>  	/* skip duplicate vm fault on different pages of same range */
> @@ -2325,6 +2327,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  
>  	if (r == -EAGAIN) {
>  		pr_debug("recover vm fault later\n");
> +		amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
>  		r = 0;
>  	}
>  	return r;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
