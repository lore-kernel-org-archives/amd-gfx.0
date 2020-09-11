Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEADC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 22:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13261221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 22:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e4FhjsC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13261221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8156E12C;
	Fri, 11 Sep 2020 22:33:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08496E12C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 22:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYHGY6GztNql1OIOsLcWsYaW/8YsZ6pM5sqdBYjXhAcVGWkv90wCwgDAmaoi1dvZsGjzm+6bkRwfT8d5s4UmNOC0OqsgFM9YDQ4OJheVoDqApns7uqlWfs1EBawynUzdiJXuxFv/+JaJS0dko8oF7i/YURAp0rEPh6ykOLehLLcak9I/JWoAfO9z13M4h48wXQzN+egcpNFRuV5NgafJNfovvD/ScE1FegQlXNXC5NjyaWONWIBIa9btLKsla8Io7CjP2Jr3g/AMgbjyKoBKha+QzMPUADT5qGYdiIfQYsQG/hTwdyZfi7uykuigzUuB0LQS6Rsvt6GfjGqGk9ku1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St0IZbrfHJ9zPkGCT4IMNsIeZv+EMCRWGoYknuD2Csg=;
 b=cImEo34sBMzigPbByWZ96Sbm9z56GsrVatAceAg8xSjOvWIJaPmwHwjJ0UMjgDxX+jTkqMyb+dk8D/9lA3S56mBGhQxJYUY+cSbYK0cwbNyis9yOrYsXHnXmdGiI+GA1MqhJ16s4guYqNX15sCy/oNz4XN6EyRlV2PiCaJMDHiG/v08PuGZnOI2MbK0KbGcRkajn5XytzCut06Jesf56qkIdGHbtgu4H0TC1v1ModWwT2ykGpq+PQfr0OkH1dPR7knTJyem0jXoXhBnbKPvUN/ll7FiKDTiXrJZkg1xFoFHwrsqqLutxHI50jPzI4/IR2OZbnMpZrWZmw/X9f5pJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St0IZbrfHJ9zPkGCT4IMNsIeZv+EMCRWGoYknuD2Csg=;
 b=e4FhjsC6tM4waIK4RLG8yYeze48Z/oYaK7Dx8/gM4H5DlFinsb1KsmXBmn8WbyVthgi0ibiM5f4oZfHQOptrmloSVpdgjoghPoxWpjMV4bCKCvrTNOybyp06GzV1PQIvyolIASE9pByrDXBU/zNxjysZ5gHDRnPrPyA9rMalROU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 22:33:05 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 22:33:05 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Enable SDMA utilization for Arcturus
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200911213357.17366-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4e46bb34-6aea-93a1-8f40-ddd579231b41@amd.com>
Date: Fri, 11 Sep 2020 18:33:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200911213357.17366-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 22:33:05 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a706602c-e1fe-4e22-48e9-08d856a2a69e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4415B3FBE6254C307124BB3292240@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpAk1IKuDejtGzX76MartfFSpQliVx0K3etfN0IQ0bbswQfIuSWg2L1BsoxFcHmNBWQIPDLwAFW8cIFvR8orC0/Fjt6GUQxdXDnRuM/2MyfTwThaZq7QFBg7VrltCM9l9G0X5m17m8iV0VsdvHDEZCB8jWy0zF9DVXtIDWjeLPDPcHBtgwMIrHsa2cQHIM922T1CbSz4TiTKcdwS1oLuiEIrAZm2cZOTXB3qhaLSK3J0cZwiGzRt+rC6HUzqEK5TusF8IZW4g7bSqK7ohjqlhNgDKaconpc2b1VHc9/Huvhv9qKvbFhieJ8AVAxpksh+IkFG0q5+5sJ+07+qqIVhdMAyf3UzeEFcGa4ErJ2TJ6kW6Eu5C3lX0hZDJr9z7YV9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(26005)(31696002)(83380400001)(186003)(16526019)(5660300002)(956004)(2616005)(31686004)(316002)(36756003)(478600001)(66476007)(8676002)(52116002)(44832011)(2906002)(86362001)(6486002)(66556008)(66946007)(8936002)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZCta75FCSK1bbX55+e2JsCoACOdoEjIVbkLRMbE0+ud0Gjcv+99cdDTK2iah7w1rFbTXuHdunAt3e2WK6ymtBZhnbo1CrzAzK8WPn7aEdmdr45oQCPICPJu57Hdj07vDxk+6W5nZxQOHmksYowNHhhAhbu5tyvu6p99UKH/4x/m1HdypHnuKpGLlAmCaGFgivgC4WsMZmy4ISYd6G97vB1RW5/YaE3I6BDoCUl/fG7wMNMsgiqW3kUJ5Hs3GEUtWxhOHn9WBi+0foJgUlOr9epQCX+gWT5W6yNzxjcyjTX81GgrCF0/A0hg63zySQJeOsyHxA+ffeF3o0QRtGX5lMA7INK8PVah7EMs/iD/EbFv4DTLml3sl5js9goiP/WYUOPn+bFVxrEqXImTGoI1T+iwj8s5GHM1fyS/rmmeLqq/7ST2oKWpU+HpbRYvpvvFofQD9MnENnZf/Es1/xJPJQX54DVUXlOB0+PI7sMzXi8TFsjmwAFi9elphPbwGso30OrIcbfhOD5XH5Y4YMOLScHHDFJVR+6efaK4lKuIQOZpDAwT8VzpwugMkXuqyyxMBpsPNRL8+DWzDrshE15dRt4jW1Y3AcADTQ4X/FGL8EWTh8YW/U/w4QtS7Tun/qzXrG7jj+CW6RdBO2hfzxgaPBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a706602c-e1fe-4e22-48e9-08d856a2a69e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 22:33:05.5095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVHb4653LE5kCB47Mu7OFCmhW+jdknhTYVUvyC+54SIcw6CDM87n/h0aMwIoIBHu1SXsqZdYrtNbuA6q2XGnKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

Am 2020-09-11 um 5:33 p.m. schrieb Mukul Joshi:
> SDMA utilization calculations are enabled/disabled by
> writing to SDMAx_PUB_DUMMY_REG2 register. Currently,
> enable this only for Arcturus.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 856c50386c86..edea8743f26e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1063,6 +1063,15 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>  			WREG32_SDMA(i, mmSDMA0_PHASE2_QUANTUM, phase_quantum);
>  		}
>  		WREG32_SDMA(i, mmSDMA0_CNTL, f32_cntl);
> +
> +		/*
> +		 * Enable SDMA utilization. Its only supported on
> +		 * Arcturus for the moment and firmware version 14
> +		 * and above.
> +		 */
> +		if (adev->asic_type == CHIP_ARCTURUS &&
> +		    adev->sdma.instance[i].fw_version >= 14)
> +			WREG32_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);
>  	}
>  
>  }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
