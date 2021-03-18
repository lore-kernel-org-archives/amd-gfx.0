Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CAEC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5647864F18
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5647864F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C714E6E89E;
	Thu, 18 Mar 2021 07:57:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243226E89E
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 07:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX5BoTwA3nlxFyZXh6k/O5zxp7obB7BmnrjSoNLr1qC8uicdJjwAOvsmLcfw7FRV3rB+OzGQv2Bxqf/IACThpW/AdIW8jgr3gElVwQT5jq5vcGxDnk3YDLMobg4Svkk7VH7L98pVJkUO3Nxl7dW48rWM5JeGIhtLXrd1uUYM3tnx/Y/WjUIrsvjz6nG6VACDiPJsFQPIRuS6yylyEYNkoF0QYc6Kl1O1OJHPVl/dH6T2wZwW3KMvFMbLIW4YQu5ls4bY/He+6qW3Pgk1SsaxfTiY28snMW+LRAfaN5eSkkRRrnTYAjWnt64QK3iehZ56/tVgNJ347OQbi2SwZWWT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kswWeef38JbfI5amCrlPaaNjJZXp/T+l331+S67sEUk=;
 b=oTZpThCUja5nrLEumei6R10BMWuNuEccMTR/Egu9irI+oLkbCT7zrXJbGKXhnFWs7RR0xIB0VezJrX6JOYBrDVBuEVfyb2TgjWM/vp0Dlb2zTo1I7U9NpaM+J0kDSyxqV4KTGA29z72Ql3McxBFuN4Zf39v/SGd48UTq+Hj0/mCy7lSnlMD+fizyO+Kw1NAXnGh5Ngod8TwyrFiJDcpt4+/4grQeU34HnZxxVVsyRBIIxAdZY2tpz3zPbTfm4zP3eN032V7rJ+XQjAdo2aym8LKOO3M6slPAckRNE7cGGnValWZBIsWdkJgme/N2Par0Ih+vbFNFXAo9a0nDQtImdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kswWeef38JbfI5amCrlPaaNjJZXp/T+l331+S67sEUk=;
 b=WQABtPbZVTCJhwS1FoDWkfQlg9MPa3WabFp+sN6CHNWibWCPFiwQsZZBD6PRoRpXTjhfcWJvoQhlmxFQJ+LEeMTsMr0KVQL/7733HVcpjQ9M2qLjyl7fAnpmpC8mYbzlErEDUy8epLJ8Ug086HH3wZyNr7ysZ5i2RHIXT/1Hg20=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 07:57:01 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.033; Thu, 18 Mar 2021
 07:57:01 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: refine the GPU recovery sequence
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <20210318072339.28736-3-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <123ba10f-f0d7-bbf8-8e99-7948cfb5024d@amd.com>
Date: Thu, 18 Mar 2021 08:56:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210318072339.28736-3-Dennis.Li@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:44e7:a99a:b86c:e453]
X-ClientProxiedBy: AM0PR02CA0210.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:44e7:a99a:b86c:e453]
 (2a02:908:1252:fb60:44e7:a99a:b86c:e453) by
 AM0PR02CA0210.eurprd02.prod.outlook.com (2603:10a6:20b:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 07:57:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ef270c2-823c-4425-b4ac-08d8e9e369a6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4335F0ECFCD12B7B20EBD00483699@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhXjoRyOW/IjAblQrgEiGiWWKLB8SZdn1kmJeIJntMC0NbRzVTklyXCPT3GQ0rYICk4YTnfaiyzezgtmBX8zuNMN0ah454LLtj7iSIcJsXajoGnF6u6Q0FmkKGIgIWV+6YTU6VMUzoI1MAm474PD8L9ohEw6I97POIuhYUdAfx8Jb1G0Esr1AeLJfsL3g6k7f2cSoG2UFGbqR7T/mVZq+8Shdbo/XFnCSELBZTbasMyQTHX71lmeZy2rBFtj1a/cjeWZUxfFZaqR8ldA6gxKSx0RnNLbUZQplmwNOtrKXLt5ETHZ/hQ9pIN1TKWNFCb+bO0VgT1oDlwoQI+u3wcfVZb3hBu0W2eOY3Xh6yHatpQbjNAfE0NVj70pESdRkZ51IXNWpJal49C+8Lc3O3Xt+on3qxiylmV/b2h9v3pSWJCi4Jnqkh7hQwMtUABaPif3/CTkZa38z7KwPjFURxxyyLkdwOTLJeJ38dDoekXB4AXilX0LZSsKVEE7f4/GziMNwbKo4IWDq65YtYq7jlM2Dny3qSEGJenIB0qF8O5cfSHUuyZP+6A6Oyalazs66srGvBelHSrkGqeSdd8oYlcTLYZ5z4VtKoZl73NUT+1FPwxM4i+WYtuBhifC+vc2OcdqsOg94r7XqpxjB4yPXunI14/r71aNFFJlnvpHPF4SSkFS+VywHqfRDBAKcifMvwMu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(8936002)(186003)(2906002)(66476007)(31686004)(36756003)(6636002)(16526019)(6666004)(5660300002)(66946007)(30864003)(31696002)(478600001)(8676002)(2616005)(316002)(86362001)(66556008)(38100700001)(52116002)(6486002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFhiZk8wa0E3cWdDa0pJdDVCN3BWdkJGWFhOVFNGT2dZNzI0VEhqbHUwajB6?=
 =?utf-8?B?b0RoRS9RRC84QmRrdWZ1eFZBaFRKZGkrMkp2OGhtbW5nd1FYejZPallrdVRE?=
 =?utf-8?B?NE95TmI2UmwzaTQxUEVBWTZkUi9oK29tUExOK0llbUNidHFLN2drQ290NGNj?=
 =?utf-8?B?U0FKQUsrNmhQWldTczRsOGFXdE9qZFdFSUpPVXAvQnJKR3NjNHRUYWxoNGMw?=
 =?utf-8?B?RXVwVkw5WDNEdW8vNFh6V1hrbmtWRE9MNThHdXljcXAyQnFLSDk1bnMxb2ND?=
 =?utf-8?B?Qyt6M3FDMG5EaGpzeWlOS0dDQk8zN2FaVXhUM3ZlQUF6a3BWcCs4YzZGVXZy?=
 =?utf-8?B?aUd3ZkRWck53NnkzZ2FOOE5MaEl4UkFGVmtFRGUyRUdFUjVRcEZybzREazNW?=
 =?utf-8?B?OGl6S0RsRXlMVUwyT0dQTDFLWDdRbFN3ZTErY0JlUE1aYjAyc2RuNkt3YWlG?=
 =?utf-8?B?T2RQeG5IYS84RDFjL05jbzJUbXkyRUJOMFFpdk5DNnF5OE1ndlNqcm1jUFlI?=
 =?utf-8?B?b3JCcTdJcVVkUmF1SmJqeUY0ajJ4aW5OK2dTOWJhTjVPb3F2Rm9xQkUzY2cw?=
 =?utf-8?B?dlpBR21MY0JaNUJMeUYzYjJ2cnptOWphb3RMZldMTkNSb29mU3R1OS8zeWxs?=
 =?utf-8?B?YmNDQXhTZ0xwMzhkQjBYOGFFeXpOZjhsVGl1S3plVmJ4dEk3SkwySi9jT1Er?=
 =?utf-8?B?K2hCRFdEMkUvQlhYdnk3ZGFyaUY1UHNLLzllZEU1ak1TNjZaNm15cndIQmJP?=
 =?utf-8?B?VHVPdk5zMFlZeVNLYXFmemR5YzhLblFzZ201Zy9uaTNiK1JwNk82ak0vb2xZ?=
 =?utf-8?B?WnhUR01IZFp0MkNJekhlS1NjYzJXOGJma1A1SGdyM0VJZngvYkJBTWRIL2gr?=
 =?utf-8?B?STlXUncrd3o0K3NTSTVlNloxeU1BdjV4MFVYTU9kSmZRT2lDQ3JYREJydy85?=
 =?utf-8?B?QmZjb3NsNE0xTGFrWVFDYXdTS0FDNmZnczVDZW4xcTVlNHhrU0xkS3I3bDAx?=
 =?utf-8?B?Tm9sbnJpclBMWW5VeTNSMTJ1SzAzTXVpekZwM0JONjJUVzZSMXYyTTZWRDZL?=
 =?utf-8?B?R3p0ZVRpdTJGS2s2QnBaN1U5NldkYUhhdnZlbEhCUWpHVzhCVkVOekhJYzVO?=
 =?utf-8?B?VVJiQXJuRUxYd1BFcDV3TG5PNXZjNytXWlFBL2JycGlvazJWc3BCNjViMnpS?=
 =?utf-8?B?TGVhZUc2U2xUTkV3YjI3dTNNMFBMczI5YXQwamdzMDNheTJoMUJQM3BqVGVM?=
 =?utf-8?B?aHpRVU85am80S21PYk9mOUNROUxaQUVUMDRyNyt5UEI0MkxkZnRlK09OVkhy?=
 =?utf-8?B?bHR5RGFtZ1JCZytWNC9JSnd1Q2tQeWJ5RFBpQlJBWDI1REIxS2Z0Q3ptenNY?=
 =?utf-8?B?Y1FJV0tSZmlJS2N2MjVROHJkSUFXVVgxdHE3aFpLQ2R6SlRzTEQ0VGxKRDlj?=
 =?utf-8?B?Z05CVkdjN2dQS041RFRQSHFQenZjR1dkcGlUQXNkTGU3ZFdFa2ZpdWYwUzg0?=
 =?utf-8?B?RUY3Q25CUWh5bTZCdHk1MzJqbStWVXhyV2YwTDRzV1ozdEZwemlBSk93WW1n?=
 =?utf-8?B?VzVLL1p6SGZ1M3hSS2dNRmVCc0x1b0JYUWFxOGJmb3RZbDN4akxOakdyS2dw?=
 =?utf-8?B?VkplR1IxUFZBL1RIS2lIT1RyNlAvaDNuZUtwQTRjeHRoYTlGVXdKSkVPMWJU?=
 =?utf-8?B?Q1Brajd0QkR5MVp1K09DdHpOdnpCVkZOMmdmY1RDbnBUSUJJUjNrcVVIVVJG?=
 =?utf-8?B?em9SRExtdE8zN0pqNHE4dmI1eDIzTVgydkVBYStmQUd3d3RDZ2xPWXczMm5q?=
 =?utf-8?B?YXpMNlNIMG1URkErZDZuU21qdkhLZENZSFFXbWJHbzhDaTFrUDZNQ3NoYTI1?=
 =?utf-8?Q?VGOU2nT0Jo90u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef270c2-823c-4425-b4ac-08d8e9e369a6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 07:57:01.3895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpOPSgyPlUofasZTFj1phFJpVX3g2tO9MXyljcqViA/01pVD1on5Lknbrc4RdQID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.03.21 um 08:23 schrieb Dennis Li:
> Changed to only set in_gpu_reset as 1 when the recovery thread begin,
> and delay hold reset_sem after pre-reset but before reset. It make sure
> that other threads have exited or been blocked before doing GPU reset.
> Compared with the old codes, it could make some threads exit more early
> without waiting for timeout.
>
> Introduce a event recovery_fini_event which is used to block new threads
> when recovery thread has begun. These threads are only waked up when recovery
> thread exit.
>
> v2: remove codes to check the usage of adev->reset_sem, because lockdep
> will show all locks held in the system, when system detect hung timeout
> in the recovery thread.
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 02a34f9a26aa..67c716e5ee8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1044,6 +1044,8 @@ struct amdgpu_device {
>   	atomic_t 			in_gpu_reset;
>   	enum pp_mp1_state               mp1_state;
>   	struct rw_semaphore reset_sem;
> +	wait_queue_head_t recovery_fini_event;
> +
>   	struct amdgpu_doorbell_index doorbell_index;
>   
>   	struct mutex			notifier_lock;
> @@ -1406,4 +1408,8 @@ static inline int amdgpu_in_reset(struct amdgpu_device *adev)
>   {
>   	return atomic_read(&adev->in_gpu_reset);
>   }
> +
> +int amdgpu_read_lock(struct drm_device *dev, bool interruptible);
> +void amdgpu_read_unlock(struct drm_device *dev);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 24ff5992cb02..15235610cc54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -211,6 +211,60 @@ static ssize_t amdgpu_device_get_serial_number(struct device *dev,
>   static DEVICE_ATTR(serial_number, S_IRUGO,
>   		amdgpu_device_get_serial_number, NULL);
>   
> +int amdgpu_read_lock(struct drm_device *dev, bool interruptible)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int ret = 0;
> +
> +	/**
> +	 * if a thread hold the read lock, but recovery thread has started,
> +	 * it should release the read lock and wait for recovery thread finished
> +	 * Because pre-reset functions have begun, which stops old threads but no
> +	 * include the current thread.
> +	*/
> +	if (interruptible) {
> +		while (!(ret = down_read_killable(&adev->reset_sem)) &&
> +			amdgpu_in_reset(adev)) {
> +			up_read(&adev->reset_sem);
> +			ret = wait_event_interruptible(adev->recovery_fini_event,
> +							!amdgpu_in_reset(adev));
> +			if (ret)
> +				break;
> +		}
> +	} else {
> +		down_read(&adev->reset_sem);
> +		while (amdgpu_in_reset(adev)) {
> +			up_read(&adev->reset_sem);
> +			wait_event(adev->recovery_fini_event,
> +				   !amdgpu_in_reset(adev));
> +			down_read(&adev->reset_sem);
> +		}
> +	}

Ok once more. This general approach is a NAK. We have already tried this 
and it doesn't work.

All you do here is to replace the gpu reset lock with 
wait_event_interruptible().

 From an upstream perspective that is strictly illegal since it will 
just prevent lockdep warning from filling the logs and doesn't really 
solve any problem.

Regards,
Christian.

> +
> +	return ret;
> +}
> +
> +void amdgpu_read_unlock(struct drm_device *dev)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +	up_read(&adev->reset_sem);
> +}
> +
> +static void amdgpu_write_lock(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
> +{
> +	if (hive) {
> +		down_write_nest_lock(&adev->reset_sem, &hive->hive_lock);
> +	} else {
> +		down_write(&adev->reset_sem);
> +	}
> +}
> +
> +static void amdgpu_write_unlock(struct amdgpu_device *adev)
> +{
> +	up_write(&adev->reset_sem);
> +}
> +
>   /**
>    * amdgpu_device_supports_atpx - Is the device a dGPU with HG/PX power control
>    *
> @@ -3280,6 +3334,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	hash_init(adev->mn_hash);
>   	atomic_set(&adev->in_gpu_reset, 0);
>   	init_rwsem(&adev->reset_sem);
> +	init_waitqueue_head(&adev->recovery_fini_event);
>   	mutex_init(&adev->psp.mutex);
>   	mutex_init(&adev->notifier_lock);
>   
> @@ -4509,39 +4564,18 @@ int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>   	return r;
>   }
>   
> -static bool amdgpu_device_lock_adev(struct amdgpu_device *adev,
> -				struct amdgpu_hive_info *hive)
> +static bool amdgpu_device_recovery_enter(struct amdgpu_device *adev)
>   {
>   	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) != 0)
>   		return false;
>   
> -	if (hive) {
> -		down_write_nest_lock(&adev->reset_sem, &hive->hive_lock);
> -	} else {
> -		down_write(&adev->reset_sem);
> -	}
> -
> -	switch (amdgpu_asic_reset_method(adev)) {
> -	case AMD_RESET_METHOD_MODE1:
> -		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
> -		break;
> -	case AMD_RESET_METHOD_MODE2:
> -		adev->mp1_state = PP_MP1_STATE_RESET;
> -		break;
> -	default:
> -		adev->mp1_state = PP_MP1_STATE_NONE;
> -		break;
> -	}
> -
>   	return true;
>   }
>   
> -static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
> +static void amdgpu_device_recovery_exit(struct amdgpu_device *adev)
>   {
> -	amdgpu_vf_error_trans_all(adev);
> -	adev->mp1_state = PP_MP1_STATE_NONE;
>   	atomic_set(&adev->in_gpu_reset, 0);
> -	up_write(&adev->reset_sem);
> +	wake_up_interruptible_all(&adev->recovery_fini_event);
>   }
>   
>   /*
> @@ -4550,7 +4584,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
>    *
>    * unlock won't require roll back.
>    */
> -static int amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
> +static int amdgpu_hive_recovery_enter(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
>   {
>   	struct amdgpu_device *tmp_adev = NULL;
>   
> @@ -4560,10 +4594,10 @@ static int amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgp
>   			return -ENODEV;
>   		}
>   		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> -			if (!amdgpu_device_lock_adev(tmp_adev, hive))
> +			if (!amdgpu_device_recovery_enter(tmp_adev))
>   				goto roll_back;
>   		}
> -	} else if (!amdgpu_device_lock_adev(adev, hive))
> +	} else if (!amdgpu_device_recovery_enter(adev))
>   		return -EAGAIN;
>   
>   	return 0;
> @@ -4578,12 +4612,61 @@ static int amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgp
>   		 */
>   		dev_warn(tmp_adev->dev, "Hive lock iteration broke in the middle. Rolling back to unlock");
>   		list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> -			amdgpu_device_unlock_adev(tmp_adev);
> +			amdgpu_device_recovery_exit(tmp_adev);
>   		}
>   	}
>   	return -EAGAIN;
>   }
>   
> +static void amdgpu_device_lock_adev(struct amdgpu_device *adev,
> +				struct amdgpu_hive_info *hive)
> +{
> +	amdgpu_write_lock(adev, hive);
> +
> +	switch (amdgpu_asic_reset_method(adev)) {
> +	case AMD_RESET_METHOD_MODE1:
> +		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
> +		break;
> +	case AMD_RESET_METHOD_MODE2:
> +		adev->mp1_state = PP_MP1_STATE_RESET;
> +		break;
> +	default:
> +		adev->mp1_state = PP_MP1_STATE_NONE;
> +		break;
> +	}
> +}
> +
> +static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
> +{
> +	amdgpu_vf_error_trans_all(adev);
> +	adev->mp1_state = PP_MP1_STATE_NONE;
> +	amdgpu_write_unlock(adev);
> +}
> +
> +/*
> + * to lockup a list of amdgpu devices in a hive safely, if not a hive
> + * with multiple nodes, it will be similar as amdgpu_device_lock_adev.
> + *
> + * unlock won't require roll back.
> + */
> +static void amdgpu_device_lock_hive_adev(struct amdgpu_device *adev, struct amdgpu_hive_info *hive)
> +{
> +	struct amdgpu_device *tmp_adev = NULL;
> +
> +	if (adev->gmc.xgmi.num_physical_nodes > 1) {
> +		if (!hive) {
> +			dev_err(adev->dev, "Hive is NULL while device has multiple xgmi nodes");
> +			return;
> +		}
> +
> +		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> +			amdgpu_device_lock_adev(tmp_adev, hive);
> +		}
> +	} else {
> +		amdgpu_device_lock_adev(adev, hive);
> +	}
> +}
> +
>   static void amdgpu_device_resume_display_audio(struct amdgpu_device *adev)
>   {
>   	struct pci_dev *p = NULL;
> @@ -4732,6 +4815,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
>   	int tmp_vram_lost_counter;
> +	bool locked = false;
>   
>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
> @@ -4777,7 +4861,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	 * if didn't get the device lock, don't touch the linked list since
>   	 * others may iterating it.
>   	 */
> -	r = amdgpu_device_lock_hive_adev(adev, hive);
> +	r = amdgpu_hive_recovery_enter(adev, hive);
>   	if (r) {
>   		dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
>   					job ? job->base.id : -1);
> @@ -4884,6 +4968,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	}
>   
>   	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
> +	/*
> +	 * Pre reset functions called before lock, which make sure other threads
> +	 * who own reset lock exit successfully. No other thread runs in the driver
> +	 * while the recovery thread runs
> +	 */
> +	if (!locked) {
> +		amdgpu_device_lock_hive_adev(adev, hive);
> +		locked = true;
> +	}
> +
>   	/* Actual ASIC resets if needed.*/
>   	/* TODO Implement XGMI hive reset logic for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -4955,7 +5049,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   		if (audio_suspended)
>   			amdgpu_device_resume_display_audio(tmp_adev);
> -		amdgpu_device_unlock_adev(tmp_adev);
> +		amdgpu_device_recovery_exit(tmp_adev);
> +		if (locked)
> +			amdgpu_device_unlock_adev(tmp_adev);
>   	}
>   
>   skip_recovery:
> @@ -5199,9 +5295,10 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>   		 * Locking adev->reset_sem will prevent any external access
>   		 * to GPU during PCI error recovery
>   		 */
> -		while (!amdgpu_device_lock_adev(adev, NULL))
> +		while (!amdgpu_device_recovery_enter(adev))
>   			amdgpu_cancel_all_tdr(adev);
>   
> +		amdgpu_device_lock_adev(adev, NULL);
>   		/*
>   		 * Block any work scheduling as we do for regular GPU reset
>   		 * for the duration of the recovery

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
