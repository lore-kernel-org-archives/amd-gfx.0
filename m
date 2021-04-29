Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929DCC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 14:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C39E61446
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 14:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C39E61446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69B86EEAA;
	Thu, 29 Apr 2021 14:46:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27436EEAA
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 14:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmGXHoB2cPzdGO+vwliKzT75u7EqVe776+vaXu5qivZM4ZE7ZUApwdGU9yrjOtdezHGzkScvPZBIQvrTGBupuuaXNxmCEhfujDHlhz/HUXidNYdZe+T2o7LkR8YidViLfNajCuHQk1I0G2u+yYxieiSX9pDkMN4VIFKN4C6sXH9NVlNiFtz1ePgwGILQ5pKw781mdcWTpGgX1b0gj2OCMPntZGRe/yYDRABAtq1/Qu0kXLknnK37bqwkiTALph1nAZCi4OA64pJ1aRR9o5UuXeSRuctlNgsuCz3Xi+mZ/MZx2pQ2op7toB2AdBw4JGzGRHTmIuOVQixGYZ+ZJZOKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9/GVX5Ma/hZ8EuF5Zc51P+k/ixLy6ap+ro+om4KwhU=;
 b=O08LAGIDWPriyAkWG9YTUzXzYPa2GGIkpUMwjAlx9qgMTGzgoZGbChTNIjNPtm2fEq2FPjNc1Kq/+6p5BAimvbNBVXnVYRiWq2B2IO02/7UUpuiNPCAu4RsybZxY6Z1XYc5iCNGpfkBKVeNGFTdHVBZq380/qmzCkUs4q2IiZQ6XlonSwE8GpQUqWAT2oSKz2eQPqnBRvNUWYTxshNpFloMN5DncuRulxUjQ8gH0Dhwamgi5LXeGu0ddSoA0VIal9QGL2yUv4shuB0E9YvCi02sK3R7h7G0aFKgFVNl9npYa5DtbEuOl3z37geYhcAm+6S9852x4jbC/rzoypHqa5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9/GVX5Ma/hZ8EuF5Zc51P+k/ixLy6ap+ro+om4KwhU=;
 b=rdWqHW0UPsQb6AIqpaBDZpNmmboOB63+XDpN3mPPTKgyWDrha9w6R+pYyuMxfjF1k0uC2H7v7ylImCTA2IoEl+m46xGJAWeP+tJKfyafBLzAn4Iu4ASJBqhLaAzXyhOeQ8sPHAloNIoEFMifwlceNr1gagW7lCpW/08Igt+/nNs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 14:46:46 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 14:46:46 +0000
Subject: Re: [PATCH] drm/amdkfd: report the numa weight between host and
 device over xgmi
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210429093427.71281-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <11263e18-c2d1-d86e-79af-1950cf8c15ef@amd.com>
Date: Thu, 29 Apr 2021 10:46:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429093427.71281-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YT1PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::12) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YT1PR01CA0103.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 14:46:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf5715c-6593-415e-cd70-08d90b1d9d0a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42237B7A2EFD31624E725572925F9@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +UxIi7M7yLRF8lcQxiBT/qM7oMu+TLx7QUWARiv8pIRIw0C7H1e1xRejL8Tdgv6OAM1vu2IZJRplr8EdSEZHzsagHPyczJZQ41QAUeS7+ftQEII0OhPxLo9H29dIyu6Ou5peuXV8PkKiyIcT7DBntCt2QTb1H3vnA07aii4Y8nvJskauYP038PJ54DbkIPPsAliJUjDZruRDgaXeu0TuG2JSojmBQjiR6OLBau4BHc68PJKIiUQqizdO+K6GtpM7x4f3LEMYSgwkJO7ll9E9umwXtg0gToDIUy6mCZrKLaXQt/ZJGzQmKVwz7nPyRBAiFFkP4CYdoQJQpJCNEKIfLf5Bl/r+ej9D3bxmO2+3jU7YIJEXfV4HBQm3LiU0GUXOn2jzaMdCL2u3fiM80eRotkpitkrSqNpOfevtQdu+xtHjalk9Orau3EGeo78RUlYzWk3kJQ1KuJlN45NlWhbZEL7JPd9eAuXF6znPhDDbvnBQYFIext5OEP+U05Vs4Pg1PDhVFDVJ/M9+WRQRbUPJVU4l76NO34UzEX3UqTE5jzAHMVA/QZ8exdjbDO49iEiPPNQVsOxw1E6fJwZmPwhdz7I9SHpPPqSRH62V6KpGoYqm2v1pEmDWkW9omSwEKkvPS23GU/ObmR40MJfRA8LXfN3OHXZdSEUmtopv0m2E0l1jngILVdKRMCGNPg3oD3VyIvXNuL7FHi4k0WVJduR72usJqQZ+LQy8yPXFUFclM6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(8676002)(38100700002)(26005)(66946007)(31696002)(86362001)(36756003)(4744005)(44832011)(8936002)(316002)(31686004)(4326008)(66556008)(66476007)(5660300002)(16576012)(956004)(2616005)(16526019)(6486002)(186003)(478600001)(2906002)(16393002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?alBITzNPMS9sbW1ZR05VNFlKL0VTdit5YkF3cTA4S05aSmZhM20zZ2VRWHVG?=
 =?utf-8?B?aVpEZFBVQ0dKcHlYbkxOV0NJbVd2VFU3RGhiVEZTOGZqSU53R1dNWHROVEZh?=
 =?utf-8?B?TlZQb3QwcXg5Sjk0SGk1TUJOQmhqdnJWM3BDM3YxTVVyRFZFcG5lTUZEZTha?=
 =?utf-8?B?UmsrY2ExRWVNZDBhQnYveU1wMklNakhWdjRGVFlwUXpCNFhxTG9nbTJ5bGt5?=
 =?utf-8?B?bmpzTjV5Z1EvbkdVVHdWWEZNSk5IRDdGZzVxT3JJcG5MQkltWEt1cEh4Kysy?=
 =?utf-8?B?SnlqbkQ2eTdrK1dJTUxQOWtCNE9xcFdDaGp3NlpNbkxmSlhIOFBJR2RVMXhX?=
 =?utf-8?B?dmtTSmVqN2loZVdoRlNDVzVwM0pKUXU4eFdqWS81YzZCb1ROSGE4SHJsaEVT?=
 =?utf-8?B?RDZxUitjNm9jR0hDM3JwUUxpYVpBU1dVeTZmVWNMRS9TeEJCMG8wbEhXeXJ2?=
 =?utf-8?B?WXBnUFg0QW9hM3JrcHVzVndQdUdBS2JTSVN5WDlaZGNBbmk1ZzRnb1JqRE4z?=
 =?utf-8?B?Y0xqOGJCcmxPd0MwK0dwTlF6QnNyK1o1SGRidzFEVWVvZ1VpalFmZEZxalAw?=
 =?utf-8?B?Q2gvSlBvbU12TmNhNjhrTll5bFFsNElRSFo2WDV1MWhQajBIZytxVUUycE4z?=
 =?utf-8?B?VklzbWJDQU1zcSsvU2xSS1IxNGwvbEdScjVXMUdKTFpPSEk5TDZNczFsK0gz?=
 =?utf-8?B?ZTFwM2ZBcjBKNFA5enMxdC9TZDV0bnptdlFaeEhtUUxMQlUrbHpwemR5cDRq?=
 =?utf-8?B?QTFxeXJSQ1JwQlFPVlVaUk1qdXN2R3hKRit6VnowcW1ZZzlta0habkpiNjJt?=
 =?utf-8?B?Z2w0cUlCcnl1R2JWOHY2cEU2OG1CZnZpbHQ3WWVGSFIwTXBSTlJ4WFZxaVZQ?=
 =?utf-8?B?N2tISnJvR3B3UHVlQzhUYVQvdk9EZlVFK0xDVENKd3lOT1lkY2psVHY4ZGUz?=
 =?utf-8?B?SHh6dnNLVUpiOGVXYXU3QVZIV1ZmZDl6UEJRdmV5VEZwaUxJK0pFdE5Edzc4?=
 =?utf-8?B?Mi91U2c0RkVONHlVSkJ3aDJPTjBxK3N2aEwwMXVoSGpsdEhyNGJmWHVRMzJ1?=
 =?utf-8?B?QzB2MzJieUVFZWk4Sk9GWGlzZi9CSHRoL0NWTHk2Tk9rc01VWFBPK3FVZ0lk?=
 =?utf-8?B?STlWL1F5QnZzbWh5Rlc4dVB6eVFWVEllaGF4UUJSdDhiZng4c05PZFlVSThI?=
 =?utf-8?B?YlBZTUdPYkM5QWQ1cytSTFRrRHNFWFpHblNUcXAzYXFORU5XSHdVV211OGhu?=
 =?utf-8?B?SlVidUN1UTRNZjFVMzdpTjVGZnNzQVFlL0Q1VWIxczZLL1ZBVWlVeXpxVTdN?=
 =?utf-8?B?SERKWTlBdkY4RVU4TlJVSm9zcW5IQnN3ZWdXclFBb2NFdDFjbnNkcGtORm5M?=
 =?utf-8?B?andkTElrQ290aHRvWnRpQ1dCTUFaZDMzWHg0elF2T0E0eTZwVVl6M3Yrc3JP?=
 =?utf-8?B?WHFsQTE1MDUvUm04aFNJdjd5MitGTjJ2dEZqYTNGMHBrVDFCOEtQa2xWVnR4?=
 =?utf-8?B?NStmcHRGNm44c0tXKzQ5cWprSDUvNW1lRTRlV2ZoR3VXeDZQZFAyVzlCMHBj?=
 =?utf-8?B?cnBWL3NVR0NhTm1wK0RYT3NUa2ptSFB2clZUSHp0ZVBZKzU3YXN4Y0IwUU9G?=
 =?utf-8?B?RGlWRnJ5R2dhZlcvWEhERlR1T1FDNUxVbmNJK1laQVZNRXhwL25CNk42OWhs?=
 =?utf-8?B?eTFTcHRYSEx3QmpsU1cvUWxGS1VndjM0eTFmNkVVSEc3Wi9hcC9zaHBCU05K?=
 =?utf-8?Q?tfxnQbjrRjoOfcubfwJEm5ue+e4rfP7VkIrlp5e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf5715c-6593-415e-cd70-08d90b1d9d0a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:46:46.7548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gle+/O3uNLfliNUYaPHn14dxYE0yV7BEeHW18e+O9DERi3iJNzPgjHCyrvhB48KHjvP5yUtVldUon02GRa3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Cc: Oak.Zeng@amd.com, Ramesh.Errabolu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-04-29 um 5:34 a.m. schrieb Jonathan Kim:
> GPUs connected to CPUs over xGMI are bidirectional so set weight by a
> single hop both ways.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Tested-by: Ramesh Errabolu <ramesh.errabolu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index eb30324393a8..ca90b710d76a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1789,6 +1789,7 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  		 */
>  		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
> +		sub_type_hdr->num_hops_xgmi = 1;
>  	} else {
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
>  	}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
