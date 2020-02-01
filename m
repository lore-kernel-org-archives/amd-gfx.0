Return-Path: <SRS0=aySl=3V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A8EC33CB3
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 15:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03FD206F0
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u6n9ohpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03FD206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8B46E500;
	Sat,  1 Feb 2020 15:21:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60E56E500
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2020 15:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+IisJmjjMblsYDHWWpLfkDfoyOCOpotg3rXEp8SmcsBDWV+ZT/fcuS61nWnZaHUBHOpWhzvJ8Gn3z4MQyoYn8/XFROk3tEaf1oN/iUwxrku1bMDd242M4oNvMAjuEd2DAQ/ZLdEX71ZVL8uv25zDWf0qaE7wWxtTUsjdNm7INTk9g6Lv5/0kwc5l3WMfzNPiF8EH8fju8d15gIPxWNlT9Ii2CLpn+TRHnq/9A0blwg5fKyOibHrhrb2h76rdeN5hHpBW+xOjxEtPfwR9TnXU73xT4V6OA0miXRpmVNHqbxwqQJut1L2mlDNhJNZffCN7HWXG7BXLTiovBHW7h5k2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NXhh3BNRNnDfPYbRu4o57oSXKHQxONxApNuBhOtBD8=;
 b=Km9knYuojdPJTExdfGIGBKXm6MqLh7fhKmqJ5yWN1KfLQVCjM7bEbbodS8cE+yIoGcn4RJC0h03cGYDFFFRuP3sB7JPwzUS1QYq98F8YBKnaxKa9Kvq+U/fdurgwZbYQYGZeSsGUgNnVANtHNi2+r//9NTZiwX8tlnI9Ar5uWTEqi5FRoPgpwLkEnUacRQu/t74lwvEVNzlNP2YVBD81cXvzMxIGo0LvFk4z9cZLckF3XoNk/50j1I50B04rvF0tP37wOksGYzxJJd5rTncq1bpfgDBAZzRg/LGQ+JmYMQvuOwFW/pdpDxVpgCR/LZHbZhhVZ/HUMBLU4phlyOABkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NXhh3BNRNnDfPYbRu4o57oSXKHQxONxApNuBhOtBD8=;
 b=u6n9ohpm7+CQc25LdmASfSfumluQp0ZQhuU3blH0llztnAx/NoSd7rc5Talm3yb5SmCeWmmr/ROo4OfXuLSkcLi7CyGGf/ELmK5NEpM+SrmAg+98ehWPlLpRoJlnGa5GeaasH2bgKfxWTxJrRaTomne4NT4GXwxt5yhdWD2WZgA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2512.namprd12.prod.outlook.com (52.132.200.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Sat, 1 Feb 2020 15:21:55 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2686.031; Sat, 1 Feb 2020
 15:21:54 +0000
Subject: Re: [Patch v2 3/4] drm/amdkfd: refactor runtime pm for baco
To: "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
 <20200201033707.16351-4-rajneesh.bhardwaj@amd.com>
 <BL0PR12MB2580A03910EE0EFAE1D6DE5F80060@BL0PR12MB2580.namprd12.prod.outlook.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <27c6811a-f5e0-33e0-ba36-955d61267e08@amd.com>
Date: Sat, 1 Feb 2020 10:21:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <BL0PR12MB2580A03910EE0EFAE1D6DE5F80060@BL0PR12MB2580.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from [192.168.2.34] (69.156.99.251) by
 YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Sat, 1 Feb 2020 15:21:54 +0000
X-Originating-IP: [69.156.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 158c7e38-fa5e-4dc5-7dc8-08d7a72a783c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:|SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25126D8537277640345FD6F2FE060@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03008837BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(39850400004)(366004)(376002)(199004)(189003)(53546011)(16576012)(316002)(110136005)(54906003)(478600001)(186003)(5660300002)(16526019)(52116002)(956004)(6486002)(2616005)(66946007)(4744005)(66476007)(66556008)(31696002)(81166006)(8676002)(81156014)(26005)(8936002)(86362001)(4326008)(36756003)(2906002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2512;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7sHH6SvNF4I1SXMqhWXO71izaqxEnMUGh3jnGZESqvQk1gj/ZMEmaa8A2C2vu6s5OXeQU1xlAVNjZDaVU0E44DXwKCoxXHjv9dMZkWWOo83cjaHM9ljvS+tZJSjOQLpQO8AIkQtVJMleR9FIG/RzX9nMBf+OnpFLkqEDh2v8wNWXIOjxODryQ3PVgVYKJPwx5EWrVaHKxFknikjKMenN3PvBs5mFkWHKv3dphPVgD/tuCHfezbaG6/VcEW1YEZhPY/UHuGpNC5J6PZEbM6KQGxWlkWqU7gvag3mLE/7NRXLIhQSxvYoe0Y+BU9YCtsYDYtnQtrmM19jN16hHDqX1UauuHugD1oKKMxfKll/G4gBpFE4xXxBTqkeOA0rpNr/C1dF8ye4EOZRo5S1zJKmWV5KxrZUKt9xopBmLs4CUIkhncTquSrVXnRfGJTQVsBh
X-MS-Exchange-AntiSpam-MessageData: VNunPLiIXv8rqtabDT6eo9UoQF4eLNPTjnzj5WO8ESoHr8LPBGGEezOsmPSANuGalLFbF8ES8kT44PFmWhGf27UF2qTnoY7cUVUBpTu/dGwNsPCJg/Ewiq9ESrze7e4BiChrhx0S8GOtcz+0dKqNIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158c7e38-fa5e-4dc5-7dc8-08d7a72a783c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2020 15:21:54.7777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A93FpWGsaXLjbmV8hJXrrHoKFFodbuDI7oBnhXZid8CPweDpzmvoqPzt0m83TPcBqVFRv7RhXP6ESt0rvEVHiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/31/2020 11:21 PM, Zeng, Oak wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Patch 1,2,3 work for me. See one comment inline, otherwise Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
>
> Regards,
> Oak


Thanks for the review and testing! My response below.

----8< -------------snip ------------------------>8-----------

>   
> -void kgd2kfd_suspend(struct kfd_dev *kfd)
> +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> [Oak] I think parameter run_pm is better to called: call_from_pm_runtime. Or you can add some comments to the parameter of this function to say when run_pm==true it is called from pm_runtime.


The main purpose of passing this arg is to skip locking kfd for runtime 
suspend and its already described in the comment above the block that 
skips locking.

Thanks,

Rajneesh

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
