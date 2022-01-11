Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E747DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 08:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758D312BE17;
	Tue, 11 Jan 2022 08:04:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F5B12BE17
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 08:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQGevtUUcfnHYsL5NQHvg/4WsEpxo9qkItTDvFSVwpck8sX65E/uv8dlXjLNTg8Vu2W1/3zjvdVi51e1/oa7WLmokEca+H/2X6firLTq4bc7lafGQ2nLoYe1+IaJVo1zw+wJfYY874q0ZDaut/OA7ixq9K/SSSe6OlXEJh7pR4jv2jWK4uY/CvewpnCgcI8OjvdZgmngZsaxQNX49ot81gM/7kYatP0ej1gdN7ouUvexoFTrg+9/AKUL4jzCsoOURxjyDU/RiPV9avFJGzS7TrFbfSr6WJDbNg6e/to/UF2t4oK8fa8amHmzaAL3YNs9mzRC2rZotQB7Dl9W/P9NQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBHQoXyLGa2vpWmi2ShzxkUsgYQpLuu0F2bs12z/dQ0=;
 b=YBg+7shQ2FdTt5fy6NjN65ga4xj9bySZZIqapB2pdq4QDyfG9Ccq04PoRu31HE3moOR+zU0Jsl4rCaAZjXHb/BL9smD4NDwUewjFgKgCVC6GKjbz3W+1TX96mDXBUztMRx6nptsXXy9llfuAniZgxv8FcD5KTaioR/YF+c3/tIvF2E0PaHzrztbHEXWL9TBKdCJo7IcbGMRN3X20tYkpQFDPPpYPiiygOcp5ZEb6w04JuwPntwIeanzRq2sEnTz+y4IA1ihwgKnGVGCCijUM2S/rOri7dJYP3pIdnPIQ8Lu0/X+imj0LH6NUFIiEIYJx117iyAMnZfMJlmK9VACFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBHQoXyLGa2vpWmi2ShzxkUsgYQpLuu0F2bs12z/dQ0=;
 b=AcfCQ04G9i8/HaiArWsQmB37iSSrSilOntyyDnhbqJflARuSynJ1QqxLdr2DSwqB+Ts+pBnkAh7hNE9m32NWpvy9nL6UkecnlD6oPw7CxuO+L2Ds9ulssPn+RKyofQ8YSj6usF0o8xydU0oCiQyKv5eCwsJd6qRWBfFmASpC4I0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB2886.namprd12.prod.outlook.com (2603:10b6:a03:12d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 08:03:59 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:03:59 +0000
Message-ID: <2d9e5368-8a8e-bc74-8d57-ef44b086d3c4@amd.com>
Date: Tue, 11 Jan 2022 13:33:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: only send GmiPwrDnControl msg on master die
 (v3)
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, Evan.Quan@amd.com
References: <20220111074508.27385-1-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220111074508.27385-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d279f52-636f-483a-6a40-08d9d4d8ec2a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2886:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2886121FC7530F49DCC35C5E97519@BYAPR12MB2886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkdVo/5uZv8f4GwQsziZoPg28GB10Y/tCpOdJ+FcTipM9QBjoJUc929vAPAw8YM9JHyFuG+7XiUYh2c/X8TDCTh+a5UZJkUo3u94g8KDlsVdy3kvApddU2L0IAerc2rgZIJ5hjMGLyrLgswEbULXMC/gCEeYpKlMJGMdfnTLAKODLSbq7UWghBM241r/36C0NJro9pDAjyuAW20V3alsBk7jq8Kq8Nv8tdT3Tk8VBoXhF4/f7WkVGtQVmq3WkWQzWqJQS9/2TOlhwjxaK3mDxyUCYGNCAgSH+NXeoTXSiF7wXEc5Bojr1b4FnH2F2twxEgGySYIO5fuiD/kIM98xBP77CMmW5NbBKTsGg6tQPvHsszoRV51yu1KnXkEF3HlkQFNiNnbNmTEf6Lcb9zGMuNjENU7kJJAvWG8pb4SxVoTIxDejqO1Bktp5XZo+wYM6qSEXytwpNHqCyEHCec/xMfbSL+PNvXgxbIAgMH8O2y3ZJyMPy0GuIxKKUpGtKum2VWODQfxLRI86b3k/YuwG54g3akRpx5XrcVaUCkFMx3d4N4GcQtxfy0TeQI9dduw42a3Mmy+IjDGem+o2Rm8QF/Q5cCaeNDrqjcqiH9rPAegzwBGe5AbPja9xV/fuKsr+w9yASQ/SkSHR/C5RxTrti+Rc95KRJIowIOY2WAkAjNzVmnuGf+unFyCIl9iH1PkWqPAqqLiPvcXTbUb6Z4uoiXqpVGQQWWap7B765o+TBvbZ9lIqZrSNj/axiWUBWVsR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(6029001)(4636009)(366004)(53546011)(6506007)(8936002)(316002)(83380400001)(38100700002)(6636002)(8676002)(2616005)(66946007)(66556008)(6666004)(66476007)(5660300002)(36756003)(26005)(6486002)(31696002)(86362001)(2906002)(508600001)(186003)(31686004)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXQxby9TWGw0MGNrNUkwWnNMdFhFaCtOQUxGYUs5WDlxalBzQWoxNldIT3Zi?=
 =?utf-8?B?MS85cDhlZDZTZFVZZXNYdVptTUNzZlJFbCt5YjBvdnR3cFc2c1ZUNG9jS2Rj?=
 =?utf-8?B?bm12bldOeklrRDE2NE1mamxtTnA1QkRQTHl1N09yeGV1WXN5SjgxaUdGRUV5?=
 =?utf-8?B?Z09ab1pVcm1QREd3RFh6dytHMU5RUFZaTzRBTVF0eE9mWENCYXJrQWdWODJv?=
 =?utf-8?B?Rmo3amZFSXQ2ZVpMTEZuMFN3aGJWM1pFYzZ4ZHRob2M5NkZLWkxrVzVzK0hO?=
 =?utf-8?B?KzhONHYxOEk1TnFtSDVBZFFYWHpRWURJTTA2eCtZaFlrWTZKOHBzcEtQWGpK?=
 =?utf-8?B?Q1JXZGlVallpUU95dWtmZFNWQUk2dTFDSU9VM1ljSWtuZ1pCdCtUM0R5NGRx?=
 =?utf-8?B?YnU1WmNxTVk3Y0xxc0ZhZ0dIVTA1UnBId1g4RG1MSS96Q3p0SjU2K1liWDc1?=
 =?utf-8?B?OGxWa3dyMm5RNTlsdkpseHEyVWRrdkl4Nlh4ZGJ1UktmQlMyZGU5UE9vOFZV?=
 =?utf-8?B?QVN1TGRpbGVHUndkOXRLbmFGN25xSXQxQ0MydTFqRytubU02bmp0TE12ejFT?=
 =?utf-8?B?VG9JZ0J3V3pBeXNnYlNOM1drOHF4eUVvZHhiUUlHd3d6SmhYRGVTVmdnaFla?=
 =?utf-8?B?dG4vbGxxckFzdWtCb1RqU2RsY0Z5T1IzY1BZa3pmK3BrUzh4eDZkSWl0eFZt?=
 =?utf-8?B?ajdFMCtENjN4MUNiRmpLS3ArY0xDdHErdlFMMC9IRldiNFFrcjI4bW5acmRU?=
 =?utf-8?B?MnhjSkJmS2NOc0VNeDc2akZDMGdOVFlDRmpzc0hqeVBMTERqdG5IUjFLMVJo?=
 =?utf-8?B?a2VQMFhvZWtneTMyc05jeWM2azBCM3Z5M3k2Sk8zQmRQS0hFWEdrcW42UmV1?=
 =?utf-8?B?cng2Q0ZybC9tR0JLYUNocjAvMEl5aUtxUmJiUjdTblA1dEo4UVFoNFpZaFp2?=
 =?utf-8?B?TjhKNllpTGwvd0EzQTIvSzEvWFNvSEIyYll0YmxZWkM5WHhjMjExYm8zNVRZ?=
 =?utf-8?B?TThROWEwOGY1OXRub0lSRE9FZEJLVG5tRWlXY00vOXNvZERWSHQwa3hWYUln?=
 =?utf-8?B?bXRxeDVqajNjRTAyekVYeVA2YmtJVmxsQTVNcnF3ZXUyQmtZL2pUVUFrTUl3?=
 =?utf-8?B?R3p3ZS9XU3pYV3czMkZOWWpJNHVwVWRKQ2N5MjF3eUluWTJocGRjTGFIZk5j?=
 =?utf-8?B?ZDBSWWhZMDRVMGRSakFkZzRHYWJtWURDVDJoUXd5a1puVjI1TmI2enhqcC80?=
 =?utf-8?B?QmRTVEprRmRrTFZxekJVVU5oQnllSnRady84aVhTREVUOWxWTVdZME9qNkdD?=
 =?utf-8?B?TWpsc3FRLytCTlBBSVYwZVRPa0l1Y2hMK0Fud0VvN3pDQkhTSlJ1NlI1NnlF?=
 =?utf-8?B?NERzNm80Y01wLzJ3ZVZQaVVBMHJnTWlqaE8wUFd5RXFxOHNTV3YwRjZBYVBZ?=
 =?utf-8?B?b1pGdGtqQXBQMGRSd2d5TU5QTTFGTStNYmRNckhkTlBRYXRZMy8yNTB4WkJu?=
 =?utf-8?B?YVNyWitzSWRGaUtRTEdpUlUwRXZRUVByN2tUSmtSYXNJNUdVSnAzUEJKdy9S?=
 =?utf-8?B?bitiVGlid2pzakdGTWJlaGQxSTdtbUdKU2QybXJVT3lJNWFSeUVBQlJvSWRR?=
 =?utf-8?B?T2JzRUpraVBPc210eFRmamdweENISm9vdWJhSUQ5Smx3MHhnYnI3WGN0ZEZD?=
 =?utf-8?B?c21kNWwvdXdPZmhvdnJRWXVLQm15SXQ1V251QmVYV2k5N2VNSEUrL01Vc3FS?=
 =?utf-8?B?RWJzZWhUY2ZjbFEzdTdjTVZRNmNsdHBiVjBMYmFqYU9mNlpQdStXcnBKQ1R3?=
 =?utf-8?B?R3JiY3E1a1dEK0Fnc3B2UG5EaHc3OWkxWEJMVEpJUFNxZjdvRHVQcFRFMVJn?=
 =?utf-8?B?Mk5id1RleHY3Q3BaMGVEUEZLbzMvMDNIT0RSSUJxdWQwcE1RNVQvN1JwcmVo?=
 =?utf-8?B?WHZJc2VvUXlWbXQ0aTk4amptd3pQREc2TzJ0RWhiL2htTWVGZnZXK3pGVkhW?=
 =?utf-8?B?UWV3RFZIS1EwbjdlNU9wSWxVSDAzVVVxTWFMY1dXdmpCa0JGQWcvMkJCMTVM?=
 =?utf-8?B?ZStYRXlVak45RVc2NU1Yc01IRXpkdjFBd3dXUVBsRlNXaDBXLytHeWl3a0FN?=
 =?utf-8?Q?Rq9c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d279f52-636f-483a-6a40-08d9d4d8ec2a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:03:59.3143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQGKLPFcf7qvLn0jflqHBsEQNbf9jBh6Ze09bFVXERbtSFtC2KUxmGEDuXvnTUu8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2886
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



On 1/11/2022 1:15 PM, Tao Zhou wrote:
> PMFW only returns 0 on master die and sends NACK back on other dies for
> the message.
> 
> v2: only send GmiPwrDnControl msg on master die instead of all
> dies.
> v3: remove the pointer check for get_socket_id and get_die_id as they
> should be present on Aldebaran.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 261892977654..ac8ba5e0e697 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1625,10 +1625,18 @@ static int aldebaran_set_df_cstate(struct smu_context *smu,
>   
>   static int aldebaran_allow_xgmi_power_down(struct smu_context *smu, bool en)
>   {
> -	return smu_cmn_send_smc_msg_with_param(smu,
> -					       SMU_MSG_GmiPwrDnControl,
> -					       en ? 0 : 1,
> -					       NULL);
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	/* The message only works on master die and NACK will be sent
> +	   back for other dies, only send it on master die */
> +	if (!adev->smuio.funcs->get_socket_id(adev) &&
> +	    !adev->smuio.funcs->get_die_id(adev))
> +		return smu_cmn_send_smc_msg_with_param(smu,
> +				   SMU_MSG_GmiPwrDnControl,
> +				   en ? 0 : 1,
> +				   NULL);
> +	else
> +		return 0;
>   }
>   
>   static const struct throttling_logging_label {
> 
