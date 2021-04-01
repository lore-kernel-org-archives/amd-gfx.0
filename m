Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC85C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2046023B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2046023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BF16E0C2;
	Thu,  1 Apr 2021 19:49:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DAC36E0C2
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 19:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ociInbjnds+jYByhYI1LgZ96jAv8+wZJNNrnIvIWYsY/+opH92ZeNLtkIWoGUA7wi3pdSoZgPZHe2+UsZqQ0vs1lXOI56T87CX81Sqb4x8uD5liJjUAQcQEn5PyEd2NDVX9dOj06IH6cZ5dwy8Gw3g8cwEe5c3+qvMuk7k+2M669S4A+QUVVz55NXAqxzC2089sSmhQr4ALYqAj//yjJb0S1OXpxDYgq+w2po6ZM/MDklwnDBUdjkPNJjkcDpNX2goyuTmm6VXE3LSV046/thcFZiF1J68z3BYgld80SL0xqwjakuMmSf/zEFJYa4kdsjfK6GTJEh6+F+WSIn9LEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOoiPSB+N0EEvwoUxfu9vMbYpR9egyHMRCNrcVYzbZk=;
 b=nfkV6c/SXRlVdXA0Q6mQc49zTx/M67VAB8tMNGHIMnX+nZNreXHN4MFR5EkVkZEmFVHkje1T/NANGQsp88lb7UYT4WxuRWNkvOU9ZC3Sfv2PGaYYCoZ8zvNtxVu+2z8XVis1XVRdf+vpuZ7s0QDyOCTHq0JCgnmzKHT8q8Y6WNaXlRbnl41O/cQ46nyUNONjj0e2NfVTEv5x+IzWYF7UupLI/HKHCGEX6O+ZxQjoGyqvuVMx3hEg9Jjbw6Zy18SyS61WARxAN9OkW3QXpB+kbUhxiyiuMfg8PVG+GVja1WTD4QDqMgKq4DwRaL6tckxHS/q+HJ0UrT3q74QGqvEN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOoiPSB+N0EEvwoUxfu9vMbYpR9egyHMRCNrcVYzbZk=;
 b=UHTXRJIOPdpt6d1U06Htrme+ZdCvA+zGd8Uy2zNVCkj2+snBlxcndKWOgPxv+lEupQockFsf/yKjJJro7pzvtOElc+KSl67pEf50FeZn8rsi+gqetMmB/X4JN1K3jjW4XQW/mu+kwK0qsrQNPGYFkaj8Q2PCkFfh0KMT+8HRKXg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1504.namprd12.prod.outlook.com (2603:10b6:301:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Thu, 1 Apr
 2021 19:49:24 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%8]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 19:49:24 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix warning on 32 bit in dmub
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210401142218.234671-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <b296ac34-091c-a4b3-d32e-46363872b38b@amd.com>
Date: Thu, 1 Apr 2021 15:49:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210401142218.234671-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::33) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YT1PR01CA0124.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.31 via Frontend Transport; Thu, 1 Apr 2021 19:49:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ba50343-2006-44dc-48c1-08d8f5474011
X-MS-TrafficTypeDiagnostic: MWHPR12MB1504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1504AD3FE8C534B0AB11D4628C7B9@MWHPR12MB1504.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zauw2zHc3kb+Gl51erg4DtqKPaOEBMFgrtzUvREm9ZOhUaWYC/py7E1Ggw8g9jgyMI4k6FBTJzFqJZFzFNx24XGDN9DnkCWo+7SR5VIOlH69/zw6e7xYPrtp5ScHhivctLyXHxo1dq+4Rg0TJdkxoqXg8ooily2Da+8xgZtxqQFpKd8AihOED+Ph7tdWO5MLVvGiODkgKgM5Zd0PjlsphZsqgeUNch5CKsiRAgyBhNyNYYnQHm8wbxiE8HPnduILO9gdNi/AvdTixUQAPWZH2lWjeuTKb/8vV11fDCznPDVKIQjAdZ+RoEAj7zoPXSyPHuLJQs8X9ECf0gtprXUC8D/c3OL4vPgsTmZTnJyUXk44ng6ZrEYjWkmtN5mxK4hNy6xKjUbgREfGgbUwEgacae4JneF1CRFnb0fXVfK3xN9j+zYTa2vh1rb7fqIMKH2PGFtw9+e8ft4JCF2zsPHDSy0G4SgUkPqoBxTOx4J51T/xOSfYiofA8GlYQ04Vq+XUmR8atW6wjn49KwuGYJEboA+XTmmJjR+7SHS7NdPQEDAfpLBTXO2+27c1SHavSdT+pRIi00aizvzM8UojUEJfi+odCtAXsRUJYfFsDFnwCTN8JOf7OD9HNA/KY4HDENUNXl7zGUqObwLTlnG61PPtqVW8NGjaBnTHEOz5pwfI10e7zXEtWT7RiMU8ygEWvZGzGCctt9zqC/CsOOEGQRs2qdqZkNbVPBCqAASYYXoYnkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(26005)(16576012)(31686004)(36756003)(4326008)(2906002)(5660300002)(2616005)(16526019)(186003)(956004)(316002)(6486002)(478600001)(83380400001)(86362001)(38100700001)(31696002)(8676002)(66946007)(44832011)(66556008)(66476007)(8936002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c3VUelk0NS9ZMkphYzJrYmRJNWNpNVRDcWdkcVltV3dFd08wSlp6Wk9hQzEy?=
 =?utf-8?B?RWpzT0E5OWJMR1Q5NDU1cE5aWFRlRnN4STRFYXRJTnNRSjRyaVhtSyt4YlVj?=
 =?utf-8?B?aU9idFR5Q3E5YTY4eDZoODljRDlxdXZ3Q1hKc0FaUlhoTkJuM1hCUENQd0Zs?=
 =?utf-8?B?K1RkTXhNSWRhNXlxcmxlNGp2MmFob0wyOHlTeURZeWdqcVhydWtqNmFyWTFm?=
 =?utf-8?B?SmRIYURMSFJVanlHcm9yQ3dBT01xdGt5RFdNejA3eFFhRURTL3U1Z3JEbXRo?=
 =?utf-8?B?c0lhUG9BTUZybDVzdVMwdWZ2WjBEZjROVW1LdSszVU5vWnBKMU8rWiswNUFj?=
 =?utf-8?B?MTZiMjMxWVBFcHNVeGErRmZteTh5eGVpWnM0RGlGcFUzNkMxNjRuQ1JtUVor?=
 =?utf-8?B?Y2VtcE5CVmdiemVYbmtjeXV3Z2lYcjgxa1lRNG1uSFY2U2NrU1dNRGtKVTFk?=
 =?utf-8?B?c0o2U3dQZGNJNkI2NUE2dU5FYXZQVjFjWHM4UFdiVmZrRGw5dDJkZHFOUkt4?=
 =?utf-8?B?L3Q1MFdDakFJOXhNcGdhNi9KbXRuRGltOVZCN3FwUGpFN0NVMjl5Yjd2Y3Jm?=
 =?utf-8?B?ak5sMHNadnRPUzlqMjVLT1VUMjZya1BiTmxuZWtzckhaN2EvVXJpQU9MZmM2?=
 =?utf-8?B?bmk2WDNrTjZ2Mml6N3hieUpGVmpleEhMdlhiYkZKc2tDTytNLzNxdzk2RXE5?=
 =?utf-8?B?WDJQcmEyRHBVL0p0M1J4S2N1Zk96Z041TUk0cy9nRWIvN0dpK05aNU0xazNP?=
 =?utf-8?B?V25qYk5QTmsrazZFTkhvUDFWR2ZBSXJIYWV4aFJ1Z21vVDRiazJ2eXRGT21a?=
 =?utf-8?B?QjVKd1BFT0lJdjk4OUYrRUIvWjV0UDdkZ29WdVU3OEZYMmV3NUM2eXowc3Uy?=
 =?utf-8?B?QU1zTFh0YWpDNHh4RkVpbmxYVEpFTU1kVGRXYng3allDSXpQTk8wLzYwRXgv?=
 =?utf-8?B?UDRMQ3grRzhGQTJXMGNRaDdvdVRmSkZ3eUxJMWxNczg0S2QxVDJwSWZmSWg2?=
 =?utf-8?B?c1pua0RVWHhNR25XTXdDaE9VQk15UjhhUGxzN20zcG5ybmcxbE5KNFd5bG1G?=
 =?utf-8?B?WURCV2JzUlBCeDVnVCtkWWhYZDZYZnlrSjBRQjRxbVdEdGdFc3Z4SzgvUGtX?=
 =?utf-8?B?bDJQMXIycWc5UmlzWDl0czllQjdWYnBtQUprM2VDOXZrZGJjdkxrWlY0V1VX?=
 =?utf-8?B?cjhBakt2S1dnZ0JBUUxHUzFMdHhTL29zNzdYQlFUZWhDa0ZpZUJVc1l5akdC?=
 =?utf-8?B?UDljazdlWDcrTDJkbEpOWjVFNGduTnpCOFBnYXkrRlRSUW52RXczV0JYVWJq?=
 =?utf-8?B?OFQra2J4ZXlUOVcwSkVZNGMzRXBSMmc0ZDBnNnZFY1h6NUVRQUVIWUk3N2g5?=
 =?utf-8?B?WVRRNThxU3dJN1liakt5bkhZNERPSCtHUEN5cUZLenBWK3dmRUdrY0xkbUhx?=
 =?utf-8?B?ZlRzRXVuYitFbFQ0clM4NU91S21PTXowVFFPSWlHbnRQS1U2SVpCU0llTWk5?=
 =?utf-8?B?QXVacDZVb0k4WW9LWjZNWCthMnpVRURBdExoQ1REUGNUZVNhZm0wY2lGK1Ey?=
 =?utf-8?B?bHR3VGprdSs1MmpiK3VTc1BqWVhLZU5MSGRQR0ZkdjFTTlRkNkRldHZSRis3?=
 =?utf-8?B?SXBibk5hMVJTODVrT1d4LzlTNnNKQ3paMnlzMUY2eDExU2RLMmU4SzJsMk9x?=
 =?utf-8?B?Q0FmYSsreHBuRHFSKytCZ3pUWC9mSE1UUXhhTzM1Wk0vYkVaYlc0UGlHU0Vn?=
 =?utf-8?Q?zkF+EpycwzgLKlmUj5pKLEYbTGQR3+EXUHn4YOI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba50343-2006-44dc-48c1-08d8f5474011
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:49:24.1104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RalVOGqaqeqD9UnA4iWFjU3iWGlvO9uev7W7j/n/b9vqJ7Sg5lipJqrZiC9yc/ObzvDzl3Et2YH8SOtiA0/eUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1504
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
Cc: Dave Airlie <airlied@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-04-01 10:22 a.m., Alex Deucher wrote:
> Use uintptr_t rather than uint64_t.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> index 743d3b7f6f24..e36e89157703 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -510,7 +510,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
>   
>   	dmub_memset(&outbox0_rb_params, 0, sizeof(outbox0_rb_params));
>   	outbox0_rb_params.ctx = dmub;
> -	outbox0_rb_params.base_address = (void *)((uint64_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
> +	outbox0_rb_params.base_address = (void *)((uintptr_t)(tracebuff_fb->cpu_addr) + TRACE_BUFFER_ENTRY_OFFSET);
>   	outbox0_rb_params.capacity = tracebuff_fb->size - dmub_align(TRACE_BUFFER_ENTRY_OFFSET, 64);
>   	dmub_rb_init(&dmub->outbox0_rb, &outbox0_rb_params);
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
