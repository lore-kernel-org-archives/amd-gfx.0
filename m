Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F3EC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 09:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814D76108C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 09:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 814D76108C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C0989E35;
	Tue, 10 Aug 2021 09:39:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33DF89E35
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 09:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWQex/sTVEesLipmcRkHt3g2UsLRH+7STik0ZPn/vUx6S9cGU77w6iKAy/AXAYq387YkreLlmIEbVZGsjbRQpUuw8B7uezoRw+s6JjhHHbxyOWYQOpOB4QTksh2BHSOZ50V+ojqSIvlkZxO2qKREyto14dN2M0C05or+AK8z+FVFHtlkD8SvYp4XBnkr4eGSWI+MuGfk0CMdpbDeF5k9KS8OoufhuPigaclAP07EywVIkD7ODCnZgnadXDpwhkQRQfLn+PS90YWGUGUyAN+4/22P/1JTBJC1pHSkucSyt3/x1yvnEXQ4pZnHaWj/P9z6eGvJsPxM+Bosa9lNEDjBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQj+nCrNN/MqoB6ZXCF5cyD+4+KW50Fg/nCsYTeH18I=;
 b=Ca0Izt7IpkX5ZajRvho1xMKJAMG1nFUWu5Q117n5f172aotudefzmyMn+uRqi9sQPJB9WnhtXTLhpiiJ2b7vZu8iKRqFKAZEsIfiTyMo31acBd5UeN87AI1XDhHe7yqcQlYWH/eQO3WGTPe286lLxGBKuybUJD9zopReR3Q9rMfPz6dLS6Cv0+MV+rIremZJT4wWTSTDo045ojNZTfj2pYJ1aHK/QPiG95JetsEa4EbN21IF7q1WZpXQWe6Rgfd/QUn+aDFUX1pix1ZNJGVE/Wr4Ge0zElzpPsDtZFyGbLhA8WGglYk0EIrQT9YBtxxl6hdm/Z+wuj6jgRi6r7/W/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQj+nCrNN/MqoB6ZXCF5cyD+4+KW50Fg/nCsYTeH18I=;
 b=lch2mBa0kYDFHbhRItFfECHPMdkCsbXQwgPLJhM/RgjEOAabXcZvpsZHBtZrDcbRglcnFKCt75l7q6t6TPcnlaDIVCL8lJ81evka+zuCpwgy4jAG11Sh86/2cUWnPdENGeph53qVA/EHWZ0ITpW/jeKV+YgosD5HM60oQozP/j4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Tue, 10 Aug
 2021 09:39:12 +0000
Received: from BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7]) by BN9PR12MB5035.namprd12.prod.outlook.com
 ([fe80::e8b5:25a3:551b:6fa7%8]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 09:39:12 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn:enable priority queues for encoder
To: "Das, Nirmoy" <nirmoy.das@amd.com>, leo.liu@amd.com
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20210810070954.4480-1-satyajit.sahu@amd.com>
 <782566d7-4b9b-9595-fd26-94dfb2406161@amd.com>
From: "Sahu, Satyajit" <satyajit.sahu@amd.com>
Message-ID: <05a3c762-87a4-b5ca-23b1-771cc09d61b5@amd.com>
Date: Tue, 10 Aug 2021 15:08:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <782566d7-4b9b-9595-fd26-94dfb2406161@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::30) To BN9PR12MB5035.namprd12.prod.outlook.com
 (2603:10b6:408:134::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.86.199] (165.204.159.242) by
 PN2PR01CA0145.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 09:39:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f2c7a66-58aa-4115-3396-08d95be2b5cf
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB530845C34381EE18C9F59D37F5F79@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZTaSVP4HNEJtM2BLduyIhz/TwTRlET3FyWOwlcD856XQS6GCUCt8tFNahpyx9l7xTxkQ1adt8dpUZNUM4V05WeQk/qOsP3AUhXkw4IeRuioOjoGKLi8DGEGN2xhmji1LccwaKGQfKesqb/HAUwozNTeRtHCndpVIlWB0nP49k7k8CkYlzPnw5mLI8fc9zvc2DERxdQtQgvvifXmuLHLCbIMaZcg/4O9lzv2OG41iCjOsJUY9IbP8yPiEztLzXQQdcZTVgZSvMdtWFDS2ITSWTj/PpHMRVhPxeb4ucZ4jWSzvM5tmNicxxEw2SLowjM7KXI683nZ0s4xypYZjmEFvzNbYqCqBCplSZCIQVdsgfbRp7PqC+BI7FKHqyRLYTm94Mnz4t4XFASkQrfSD5E4nKXFotMNmZ7yhlo0Iz1/0Nmpi3/3QKWEj9eZ5rPSTzQl8gZfbUSmSwLUOK79QrK0xx/Rnpq3AhjtSmKaOjreQ90k3Qt0PO1gGBa49CbImkAHCDO1B6fQOu+ASEya6S3zs//wmA6K4zCFW5O9WV+EHLfSEkLf5Jdc4xNiSZqFkGuAYpHtpgDxL0Ts0VaG5RdPFaEKUzIOoMXn2hS4SVF2XCVOcWjeOnkmSLFAejQjjiUZvVSGEnEuaoj7xrQgZ+3Z8c4fGFUI6W8r6t7BIITCYV63htntbUug66XRn0ZVyA2eE/0nyDG+0CNUGbRzKOiBFxOOJ8S0U5VJQoWBrrHvDx30ZMxk1AnZ6RjLW021U0s6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(31686004)(8936002)(86362001)(316002)(30864003)(6636002)(6666004)(956004)(2616005)(6486002)(31696002)(83380400001)(36756003)(16576012)(26005)(5660300002)(38100700002)(66556008)(478600001)(4326008)(53546011)(186003)(8676002)(2906002)(66946007)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elRXMUpObG0vczVyR2FOTXdWVUU2WFBBOVpKbW5sbStzUzFraTZ3MjBtSE43?=
 =?utf-8?B?WC9YSkZvY25WNVo2QStScG5IWkd0UTJ6Tll4UDJyQit0OVQ2ZkdTcVF6TlVy?=
 =?utf-8?B?bGVmWTFXMnMyaGxJTitIZzZySnpOL0t5cmJ2WTU2RURhSzhrQzlhSXFqS2Nl?=
 =?utf-8?B?OXI1NGV4MXZBS3JJOU4zdDFnVXZFYjRrTUtoQnBsdDZhaU9xNEhxWjR5SXVm?=
 =?utf-8?B?RXhaNjAwTXpBSjE2aERVbnRodW9XcmVwSHcyMENNakswYi9LNTYzT1IzSVhz?=
 =?utf-8?B?ZFlwZWVWbkVkTmRBdWNYbTZvK2l5YnFIdG5EOERMbkhkd3JYOUs1cS9FbkNi?=
 =?utf-8?B?bEdnQ2pSUy9mcWRtVDBIVGdTdkxrSVFvU2FBdCtlSUl3MDNrb1R5UldsclZn?=
 =?utf-8?B?NE1LaDI5c1FVby9ZMGJLTUpFdkJYWDdHK0w3czRkbklRNXRQOWxHMkhZWDVF?=
 =?utf-8?B?M1EzS3lPZEw5MFlFTzB5Rm1wUFdUODN4RDRaUUVZd3Z2K2FGZmk0cHJPWVk5?=
 =?utf-8?B?V2l5d2w4SjNwTXRhMmFJVkx3WnBUR2ZuYkQyNE11YU5sS0I1VERNbDluTkpx?=
 =?utf-8?B?bjVhMFNYSkVSTGtLeHRZdk5nMERoZDhMMEI0aWl6V0EwRlU2S0l5MlBIK0kr?=
 =?utf-8?B?alNTL0k2OUg2a0FJc0xlbnplYzExcjBKdDlXSVBDZkZKUHY5eW5walFGcFV2?=
 =?utf-8?B?VUh3cTJKZGxVZnhGVm9sTHBhc0tCVldYOXNGai8vcVdUU2QrNXVsZXA5UFpH?=
 =?utf-8?B?RUFqdml0QUl3MDJUN1dXR2gxVUtLN3FxbVdqcXZ0WTBjclhsdmRHckJEVkhL?=
 =?utf-8?B?TjJtSTBsa2kvc2I2aE0rQTF2Mkt5bDNDTUFYNG9lVTE2NWM3TlZmU0lzU0ZL?=
 =?utf-8?B?d1V0cVY3V2lNQXVwTmd3MlZSUHJaVWxTZVFZeWJiTlpsNmJ0MTFDODVHUFZV?=
 =?utf-8?B?bFhyNU1pZXJNd1RXNHhRVWNiMFI3RlRzTWZiRVMzZTZQWmV1UXdyREV6d29u?=
 =?utf-8?B?b3FuUGswL29Cd0dIZDVEeUFKYXlqeGhhNzd5b24zaDVsVmltTGFXZ3FuWnB6?=
 =?utf-8?B?OEtJZFNFVmI4MWJNOXFrWmFmWmszZlhWaVhMR29WcjhWRFkzMHoxcjEvSFBr?=
 =?utf-8?B?K1FKRFl1aFhZc2I0VnNIa01qbmZIUHVMVnZ4djdPbXRod1hFd09ZYnlwalhx?=
 =?utf-8?B?NmdoeVAyOFVnRzV5dFBBWWdsR3h4cUtRNG91d1ExdXFuRUU0TmN0Um9Ua0Ez?=
 =?utf-8?B?aG5vajNEMkd0MDdoaGxzdDBtcHVvSVZMazM0SU5DNWc4WXNiQ0N0WHNCMUdQ?=
 =?utf-8?B?a2NXMDI5R2hQZFhGT28weW9vM1Njc2lLZFJNei9zdk1kdFdYQSswN3R2dmxq?=
 =?utf-8?B?SFlnS0xNN3hKdGthWjhGQW5ZaUxHSlpSZXg1MHJmb05HZnI1RkhLZHNoaE5a?=
 =?utf-8?B?dytjYlZPekJubktxY2dDTmFUQVEvQmtsR1BTYUNtWjU0MDVaUUNLVi9zS3pU?=
 =?utf-8?B?MlA5VjYzSWhYTlZWdWhhWWs1eVIrb2NZM2RJekVRaGtTQkZjSHhBeTZZdW1j?=
 =?utf-8?B?TStSOERhU0RnUS9RMk9TWWh0T3krRUxZN0Nna2dmQVJ1V3JydEdxWWR0Ti9K?=
 =?utf-8?B?Mkt5VzF4WTMzODV0Y0JDeW4xcHJ6RXJSdTkrVXRVM3dXT3NBV0Z4dzRMbXFw?=
 =?utf-8?B?RHZKOFNDOWMxcVJxaGFZQVlBa01ydURuU2ZXelcxUDZqSmM3MGx2NkVyOUpK?=
 =?utf-8?Q?P8Uyj0gDO5O5vpEjuIgDX3iUrFiUub0yL8idx8f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2c7a66-58aa-4115-3396-08d95be2b5cf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 09:39:12.3684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCoO0lY8gZNb09nSknCPrgC/iz1ioWGAjrz0yKRxuJIfiahtKXfup6Y4h0KaCkLA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
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


On 8/10/2021 2:01 PM, Das, Nirmoy wrote:
>
> On 8/10/2021 9:09 AM, Satyajit Sahu wrote:
>> VCN and VCE support multiple queues with different priority.
>> Use differnt encoder queue based on the priority set by UMD.
>>
>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 35 +++++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c   | 14 +++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h   |  9 ++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 14 +++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  8 ++++++
>>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c     |  4 ++-
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c     |  4 ++-
>>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c     |  4 ++-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  4 ++-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  4 ++-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  4 ++-
>>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  5 ++--
>>   13 files changed, 99 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index e7a010b7ca1f..b0ae2b45c7c3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -73,15 +73,44 @@ static enum gfx_pipe_priority 
>> amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
>>       }
>>   }
>>   +static enum gfx_pipe_priority 
>> amdgpu_ctx_sched_prio_to_vcn_prio(enum drm_sched_priority prio)
>> +{
>> +    switch (prio) {
>> +    case DRM_SCHED_PRIORITY_HIGH:
>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>> +    case DRM_SCHED_PRIORITY_KERNEL:
>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> +
>> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vce_prio(enum 
>> drm_sched_priority prio)
>> +{
>> +    switch (prio) {
>> +    case DRM_SCHED_PRIORITY_HIGH:
>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>> +    case DRM_SCHED_PRIORITY_KERNEL:
>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> +
>>   static unsigned int amdgpu_ctx_prio_sched_to_hw(struct 
>> amdgpu_device *adev,
>>                            enum drm_sched_priority prio,
>>                            u32 hw_ip)
>>   {
>>       unsigned int hw_prio;
>>   -    hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
>> -            amdgpu_ctx_sched_prio_to_compute_prio(prio) :
>> -            AMDGPU_RING_PRIO_DEFAULT;
>> +    if (hw_ip == AMDGPU_HW_IP_COMPUTE)
>> +        hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(prio);
>> +    else if (hw_ip == AMDGPU_HW_IP_VCN_ENC)
>> +        hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(prio);
>> +    else if (hw_ip == AMDGPU_HW_IP_VCE)
>> +        hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(prio);
>> +    else
>> +        hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>>       hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>>       if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>>           hw_prio = AMDGPU_RING_PRIO_DEFAULT;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> index b7d861ed5284..4087acb6b8bb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
>> @@ -37,7 +37,7 @@ int amdgpu_to_sched_priority(int amdgpu_priority,
>>   {
>>       switch (amdgpu_priority) {
>>       case AMDGPU_CTX_PRIORITY_VERY_HIGH:
>> -        *prio = DRM_SCHED_PRIORITY_HIGH;
>> +        *prio = DRM_SCHED_PRIORITY_KERNEL;
>
>
> This change looks unrelated to the patch. AFAIK KERNEL priority is 
> reserved for kernel tasks, userspace shouldn't be able to set this 
> privilege priority.
>
>
> Regards,
>
> Nirmoy

VCE has 3 rings (General purpose, Low latency and Real time). From the 
user side when priority VERY_HIGH(1023) is set, real time should be 
chosen, if available. That is the reason i have mapped 
AMDGPU_CTX_PRIORITY_VERY_HIGH to DRM_SCHED_PRIORITY_KERNEL.

regards,

Satyajit

>
>>           break;
>>       case AMDGPU_CTX_PRIORITY_HIGH:
>>           *prio = DRM_SCHED_PRIORITY_HIGH;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> index 1ae7f824adc7..9d59ca31bc22 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> @@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring 
>> *ring, long timeout)
>>       amdgpu_bo_free_kernel(&bo, NULL, NULL);
>>       return r;
>>   }
>> +
>> +enum vce_enc_ring_priority get_vce_ring_prio(int index)
>> +{
>> +    switch(index) {
>> +    case 0:
>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>> +    case 1:
>> +        return AMDGPU_VCE_ENC_PRIO_HIGH;
>> +    case 2:
>> +        return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCE_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>> index d6d83a3ec803..f5265f385890 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
>> @@ -32,6 +32,13 @@
>>     #define AMDGPU_VCE_FW_53_45    ((53 << 24) | (45 << 16))
>>   +enum vce_enc_ring_priority {
>> +    AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
>> +    AMDGPU_VCE_ENC_PRIO_HIGH,
>> +    AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
>> +    AMDGPU_VCE_ENC_PRIO_MAX
>> +};
>> +
>>   struct amdgpu_vce {
>>       struct amdgpu_bo    *vcpu_bo;
>>       uint64_t        gpu_addr;
>> @@ -72,4 +79,6 @@ void amdgpu_vce_ring_end_use(struct amdgpu_ring 
>> *ring);
>>   unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
>>   unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
>>   +enum vce_enc_ring_priority get_vce_ring_prio(int index);
>> +
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 6780df0fb265..ca6cc07a726b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct 
>> amdgpu_ring *ring, long timeout)
>>         return r;
>>   }
>> +
>> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index)
>> +{
>> +    switch(index) {
>> +    case 0:
>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>> +    case 1:
>> +        return AMDGPU_VCN_ENC_PRIO_HIGH;
>> +    case 2:
>> +        return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
>> +    default:
>> +        return AMDGPU_VCN_ENC_PRIO_NORMAL;
>> +    }
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index d74c62b49795..bf14ee54f774 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>>       VCN_UNIFIED_RING,
>>   };
>>   +enum vcn_enc_ring_priority {
>> +    AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
>> +    AMDGPU_VCN_ENC_PRIO_HIGH,
>> +    AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
>> +    AMDGPU_VCN_ENC_PRIO_MAX
>> +};
>> +
>>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
>> @@ -307,5 +314,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct 
>> amdgpu_ring *ring, long timeout);
>>     int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long 
>> timeout);
>> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index);
>>     #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> index c7d28c169be5..2b6b7f1a77b9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
>> @@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
>>           return r;
>>         for (i = 0; i < adev->vce.num_rings; i++) {
>> +        unsigned int hw_prio = get_vce_ring_prio(i);
>> +
>>           ring = &adev->vce.ring[i];
>>           sprintf(ring->name, "vce%d", i);
>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +                     hw_prio, NULL);
>>           if (r)
>>               return r;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> index 3b82fb289ef6..5ce182a837f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
>>           return r;
>>         for (i = 0; i < adev->vce.num_rings; i++) {
>> +        unsigned int hw_prio = get_vce_ring_prio(i);
>> +
>>           ring = &adev->vce.ring[i];
>>           sprintf(ring->name, "vce%d", i);
>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +                     hw_prio, NULL);
>>           if (r)
>>               return r;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> index 90910d19db12..c085defaabfe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
>> @@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
>>       }
>>         for (i = 0; i < adev->vce.num_rings; i++) {
>> +        unsigned int hw_prio = get_vce_ring_prio(i);
>> +
>>           ring = &adev->vce.ring[i];
>>           sprintf(ring->name, "vce%d", i);
>>           if (amdgpu_sriov_vf(adev)) {
>> @@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
>>                   ring->doorbell_index = 
>> adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>>           }
>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +                     hw_prio, NULL);
>>           if (r)
>>               return r;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> index 121ee9f2b8d1..f471c65d78bc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> @@ -145,10 +145,12 @@ static int vcn_v1_0_sw_init(void *handle)
>>           SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>>         for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> +        unsigned int hw_prio = get_vcn_enc_ring_prio(i);
>> +
>>           ring = &adev->vcn.inst->ring_enc[i];
>>           sprintf(ring->name, "vcn_enc%d", i);
>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +                     hw_prio, NULL);
>>           if (r)
>>               return r;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> index f4686e918e0d..06978d5a93c7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
>> @@ -159,6 +159,8 @@ static int vcn_v2_0_sw_init(void *handle)
>>       adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, 
>> mmUVD_NO_OP);
>>         for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> +        unsigned int hw_prio = get_vcn_enc_ring_prio(i);
>> +
>>           ring = &adev->vcn.inst->ring_enc[i];
>>           ring->use_doorbell = true;
>>           if (!amdgpu_sriov_vf(adev))
>> @@ -167,7 +169,7 @@ static int vcn_v2_0_sw_init(void *handle)
>>               ring->doorbell_index = 
>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
>>           sprintf(ring->name, "vcn_enc%d", i);
>>           r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
>> -                     AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +                     hw_prio, NULL);
>>           if (r)
>>               return r;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> index e0c0c3734432..fba453ca74fa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>> @@ -194,6 +194,8 @@ static int vcn_v2_5_sw_init(void *handle)
>>               return r;
>>             for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>> +            unsigned int hw_prio = get_vcn_enc_ring_prio(i);
>> +
>>               ring = &adev->vcn.inst[j].ring_enc[i];
>>               ring->use_doorbell = true;
>>   @@ -203,7 +205,7 @@ static int vcn_v2_5_sw_init(void *handle)
>>               sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>>               r = amdgpu_ring_init(adev, ring, 512,
>>                            &adev->vcn.inst[j].irq, 0,
>> -                         AMDGPU_RING_PRIO_DEFAULT, NULL);
>> +                         hw_prio, NULL);
>>               if (r)
>>                   return r;
>>           }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> index 3d18aab88b4e..f5baf7321b0d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>> @@ -224,6 +224,8 @@ static int vcn_v3_0_sw_init(void *handle)
>>               return r;
>>             for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
>> +            unsigned int hw_prio = get_vcn_enc_ring_prio(j);
>> +
>>               /* VCN ENC TRAP */
>>               r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
>>                   j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, 
>> &adev->vcn.inst[i].irq);
>> @@ -239,8 +241,7 @@ static int vcn_v3_0_sw_init(void *handle)
>>               }
>>               sprintf(ring->name, "vcn_enc_%d.%d", i, j);
>>               r = amdgpu_ring_init(adev, ring, 512, 
>> &adev->vcn.inst[i].irq, 0,
>> -                         AMDGPU_RING_PRIO_DEFAULT,
>> - &adev->vcn.inst[i].sched_score);
>> +                         hw_prio, &adev->vcn.inst[i].sched_score);
>>               if (r)
>>                   return r;
>>           }
