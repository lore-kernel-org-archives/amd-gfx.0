Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC082C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:47:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1AD61931
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1AD61931
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8B56E923;
	Tue, 23 Mar 2021 17:47:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA096E923
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 17:47:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGUxSyAarvkn7Urph3mjZG3GbOKrAlY6Su/wmfWXox+7mY1aq/wuYuhLUN1oRRx/58HHw37i5PR+lKmrLxhMrqlLcnfGb4Bj3mrJanXoJp/DGlL2tWXm0VFZrdOLWTV2D2r9sZxOyGHsHs+v0yGY8EkfbCA87Mbx0LpKBP/sSAXJ9LBTgdX3wRuhwfMf5VuJ+PfO7F7lKtLoxlNZm8Yhs5IsKw1EMJxtxrQ88ErgMQ8rfi3ddNyib539p5rlJ866Yn6TZzobaaZ1wTD7q90H/jd/Qv0rRsNOAX59VTd583Pw/rYm+rfU5cqNgPvVAP8QraW3/zmkgTX+az62+GBc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2nZC2ken3W/BKSF0tBqxiWBRC3C27ytwUKK7vLNOfc=;
 b=N1dablDyaeeCx8zkpzUo8OpooI6icC2eks2KX12lkvz6F8F0ei+MUwR0c4ipNeKbPxDKOQuSuyxTBTaf6grzjT8LSJJxMA7OJa8NshISh0Oxc6gBByu1GuhS/QxkJMqpDKutNHImiDdvqflZrCkc9JIvktVdqjuBBzZF7boAR4YpUWQT05EpgsgEJK6cOzLlyy99YFXcYGqyXRvGB+yOtC3tMF3nQJi1JOnMsroNcnRNVBmYYeW4DpqmZxOulDwXJp/YDgycQlw9x11nQWSZ8Vu18B+uAsGrgvZpc1Hm/kfSd42PtW/RS26YFlRthi8MT5/EU466P5IpG2ifEz30jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2nZC2ken3W/BKSF0tBqxiWBRC3C27ytwUKK7vLNOfc=;
 b=iAolYO1T1Sw0Wsl7rnau02wc+xhgapnNb+3Uh7UU3E1ixtGKmZgcZPend7IWLFcmIN1MYmXnLKGyBmOW3mC/gFTcoikX/kZHvbBFAPDFdtf1eEMOMH06ikLpmazIR8yxEub4Pk0zOvydRdnsE3RYh1JXKCTER3RGB08yRzYVtxk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 17:47:07 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 17:47:07 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix clkmgr for SI
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210323170603.1223424-1-alexander.deucher@amd.com>
 <20210323170603.1223424-3-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c0fc073b-2f41-ee0f-547e-ef1e776e9330@amd.com>
Date: Tue, 23 Mar 2021 18:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210323170603.1223424-3-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.110.215]
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.110.215) by
 FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.15 via Frontend Transport; Tue, 23 Mar 2021 17:47:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9ae3178-9946-442e-64cd-08d8ee23ad2c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0231B279B19486E02BF56F3A8B649@CY4PR1201MB0231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6IUW6TiCZzAQKvFlN/kJ0HZFFHBIRchR5sm2PCBByTQV+3dYcOkLmzuQNztg0STdSIfpRaRl5jNLpR48CaSL9n6nBcPfzItNrDjo/lojYhuMfWx5EuF9Cw4ziWsAgfekoodt54N37pN3sEEzgvmaPe/tha/KGtSk1ywRLd1eNLa21xwBz0k2b1nzhYBBkwVpDABvhvDYkvz6AIX9gNvURj/VudOUc30DXjpcggo6nsCgn7+VPOfjciqNYCVo05Umnc+HjKxXIUw7uRqwHNUjfVi5/BA2OuQWO51kWRpUzV5SRDBBriqu1VjX4ZxJyXFhfU/JVZBHi/82lYGnw+U6p9QT2o9Cu8SF2khGzQVh7fQFUhuffEmDdHM0/aC5VaTmEdES5CX/+5skR9yAgfSbTWQ7PjCBaVHTvBUh6qR4Hmb8TQ2BTKEv5a3hqjd1NwZWgTIQVsybMRlTE+kk3T/1O95Mal4gUipu/NoEMSyFAVQWsOlWKfxAcEBvb1QvV1VpMcaFlQQHdmi6dKAB4MpUvoGRAg3HoNi0yzQQWQQDYrgCbltaSNQeU1G7ha09X+xTLsRx2HK+9NVMYJYIp3Franx7EtBysYg4gwroxRCTe0RHJLR8EKvDkTvJNAsjedyyakVeZRdp79Dh6qnqJgBTGSb0sWgKuqOLrj7msYBdA7wUS2HDmgWb5b5ymeX0Jpr2uElLa20jMhFKAzOw6zXvbs1choxeTR5kVc/DahDd+7Sx5xGXvUkysVPFSQ0sPjG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(38100700001)(16576012)(53546011)(52116002)(16526019)(66476007)(26005)(6486002)(5660300002)(31696002)(8936002)(186003)(31686004)(316002)(4744005)(66556008)(6666004)(2906002)(2616005)(36756003)(8676002)(478600001)(66946007)(956004)(40753002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aW42eGFCUitCY05qSTVRSjN2cmVpaEVMdEdPTStFUWprOWljR3pRdE90STd6?=
 =?utf-8?B?eWY4RVY0Yk50aTNIVDNJTGVoNzFYMGRDU1ZNKzJTR1FVUjAyY3J3azZNU25Q?=
 =?utf-8?B?YkY2bStoTXp2V1V4Q2JYeU9oOGluSmdBSG1qcVd3cGZUWnRBcG42VDhnWk56?=
 =?utf-8?B?Y2Vmei81ZkxSWWRxVnhKUDJxcnd1UVhRNUZwTVBxSmtZVDRxUTRvc0orMmNK?=
 =?utf-8?B?L2RCWVdmQVpjbmwySkE0aEhkZUFFdTJCNzNYMjhnZjd4UW94MG1TTm04emsv?=
 =?utf-8?B?cGtEOFZqZkc0c1ZrNTk4by9yaHlCU3VRUythdUpDQUF4c0hpazdIblRRWDJI?=
 =?utf-8?B?bXg0KzVwN2t5YmpjRXZmTGk4RjZZak96SUNmdjlkdGgyOWtJVDYyQzF5NlBl?=
 =?utf-8?B?dnJnYXRvZmZkNUFRZ2NFVVJVc1VNRTZ4dDNFbXFwQjFaNWUwbngyZmdRK2cv?=
 =?utf-8?B?dnFlSXlkM3FCeU8rUURzd0huR0o0eXFMUTZndGxicktOQlY1RUdTWUJoTUJD?=
 =?utf-8?B?b2p0QW1CcE1nak9BYmFrUVZ5TWx0MmZZWDRKalRUMzI3Wk5Oa0N5ZXNab2kw?=
 =?utf-8?B?YTZZMHVURU1XbkltdGhHSjJFZDZtUXFoRE5KaEVOclF3WlIxMFFTQnpMa2k1?=
 =?utf-8?B?bHRiSkdMZDJZRUg3UHpac0NnUG9QTEk5bjIrMjBmL2tMTlJqd0FiWUNNUGlR?=
 =?utf-8?B?azRab1ZQZDR0L1BGRHRCdFBmdHcrdXNEUmhNWCtSN0FNTC9mcWQwVmZyQlVX?=
 =?utf-8?B?aW4rNWcyRDM1QitaajRqcHJsK3lONWlZbUZRR2NFVU55SWxFWXdSOE1MMk9x?=
 =?utf-8?B?UFRJVFVhRG1PRGUvRGxSdm5XSDJCTHcrZUNEbUU0R0JOd0h3THpacXRzeWxZ?=
 =?utf-8?B?ZkFEOHlyV0JSNGZQRkJlVmZLU3lYamdyanczK2VURWpZL0hibnNzWFlxdkly?=
 =?utf-8?B?TnpiSFhCZGl1dlFBMngzSUNjbllqN0ZCalQwZlYwd1BlQzl6am9jUzdmakpv?=
 =?utf-8?B?b29TQ1NwTmloZ1kyVWY4bXdQaGtiU1BuNTU1NE04elZDeXZzZFpMM1hmYWNl?=
 =?utf-8?B?NDIwS2ptY0hMeFNMenN0YW1IazRnSG9UOURMVjJNY0hDSWQyYXpSbVlyT0RZ?=
 =?utf-8?B?L3N0dDZmOTl5WE5TWEY4SFNmNkxnQkZuOXVGMlBtVXU5VjlmVHpVbHA0aU0w?=
 =?utf-8?B?QWZxRGY0OC9WQ2c2MFRtN24vMXNURnBrZ2tMSFlaa0wrY1lLSnYvb0lORHBl?=
 =?utf-8?B?M1p6Y0hvdmhXUUpjSVQ3R3B4b2h0RGUzTUlESE51STBFK0VCZFdlazFsUnB0?=
 =?utf-8?B?dlRUbFlkV3VnZ1J3M0svWXFyL2JlckhLSVF4U2lkYU9QYlJBVlIzRVJvZFFG?=
 =?utf-8?B?NXcyU2tHMTE0V3VBUnU2Wmd2YlpKNStxSWR4N3VGeWFTbVBDLzZtaDAzTVRp?=
 =?utf-8?B?emhCT3VKVnJjcldKTXJ3bGhFOE9QRXlGK0RKZjlaelpqR3NQRXh5UEtNUG8z?=
 =?utf-8?B?dGZ2anY3NVU3M0JWTk5xTGp2bDh1TVRNV2l3OVVMTkFIRUluU1lVOXRadC96?=
 =?utf-8?B?dWx2NXl0VkRTYWpBeXhxeE9HLzFOZjRtYzZ0ZVhGWGRUb2NZMmQrYzhQR2Vy?=
 =?utf-8?B?OG4zcjhJVHpoU09lRnE5SklGMldMeGZaK25nOUV5NEgxMHNPLzJvZm50VWFn?=
 =?utf-8?B?SDd5M2xyRklUb05LSVFsVTc2ZDhnMStYZmY0WHh4bjJVTTJsYUNMajF2MjVK?=
 =?utf-8?Q?PXuhZPmktDBEjatlqurczs59iw0ZCbCDeclstGX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ae3178-9946-442e-64cd-08d8ee23ad2c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 17:47:07.4147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1m4u0Jc1dLvCxTDwqzqBs+6/9MtJdFurHkgAXawJanXQxrZ2nrhJc9zjTB+lMqiIy5QZMfrsS5FWxIwaNvqvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
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

Found the fixes tag for this:

Fixes: f4a5cbdcb1 ("drm/amd/display: hide VGH asic specific structs")


The series is Acked-by: Nirmoy Das <nirmoy.das@amd.com>



On 3/23/21 6:06 PM, Alex Deucher wrote:
> It looks like the SI case was missed.  Need to return
> the clkmgr struct for SI.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index c81da30faf03..7d6c68c5dea9 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -136,6 +136,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>   		}
>   		dce60_clk_mgr_construct(ctx, clk_mgr);
>   		dce_clk_mgr_construct(ctx, clk_mgr);
> +		return &clk_mgr->base;
>   	}
>   #endif
>   	case FAMILY_CI:
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
