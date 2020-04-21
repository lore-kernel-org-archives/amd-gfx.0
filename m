Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47346C54FCC
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 21:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CCC206D9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 21:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BScvu0d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CCC206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F94F6E339;
	Tue, 21 Apr 2020 21:08:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8AE6E339
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 21:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZX9Os25B2PG6tNDz7jHu6Dq0fTFway+avIJyuZuQP0yqKQLfQFHFEiL+4skqfx2klFCLLY3HEgq+gTPVzm3wwM94CquiOWFVTpzLcW4FfLJPzF4gucoLmDByEGbDMZ7KIx4nM75Vw4AX/kjFfXjqOC0liZT5hfC4j8tqVa5Dd/+kqS2r/XPZYV0Ma9JsDiQtdXCZfz60zGYeYYRdpowtwyYubEpv4dE1sPQ7hslddUbXPaqeLiJZIVWibHQ9TqmKQZmjkeUhxAWfMilZ6SazPAkMX5KtXDR9LELa/T5MNCsRvehO9IpIOELNICNg727Zxa58rs1RB6jgXD/NU9ouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDQZ9IxLOSr7B0wK/MYsiSbjuj1YS+YZg14kdnlpf0E=;
 b=G5qSN3fr71kIhAN/WqhxkElbqMz7uf+8nX0CxIMajH84d9N31SADDQE1V4RimaGrug7bRK7s4R8ZHuKDSZjuCwW19K4EtjaxmoSdtodQCvma1DmqoRLzpuMZQp7pMhaXwmU7iUyV7KrkmeFNGJQhzqH6E8KT2W90r5ty+51wQGowXVhFqtNxuxWXeJEJheEpP7pO+MgnhRjXLUwYg4/fpaIdJCjLb1rGu7XBPRylkF9Wq/gxja7sy4/51ol/zXv6Y1OfUAuwMNdstqKRBeHxudZrXMyexoRZxemiRTA5iA2qVJtZ+P5Tr1gOWccHtaWD/AF99tVVegxpZvPlwwIwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDQZ9IxLOSr7B0wK/MYsiSbjuj1YS+YZg14kdnlpf0E=;
 b=BScvu0d+IcqhW6ornsR1nppV6qKE5LWW0ANyi+nXcMGHTz814VwWKjs3mYTVRT0UrqisbX65itE3TXgattqJTZmrw0NNnh6bfrtflc3jJ/5b+HkWxjRGaPTfahCdeU5rN+/n643wNjMNCgutDJQ2ZyAxJgqRVS28C3TdsoFIghI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 21:08:15 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::943d:4dcf:f18e:5df]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::943d:4dcf:f18e:5df%2]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 21:08:15 +0000
Subject: Re: [PATCH 0/4] Some XGMI related gpu reset fixes and cleanups
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200421052342.23037-1-evan.quan@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <08017473-525e-9302-3def-161a8936aea7@amd.com>
Date: Tue, 21 Apr 2020 17:08:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200421052342.23037-1-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN4PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:403:2::33) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.7.162] (165.204.84.11) by
 BN4PR12CA0023.namprd12.prod.outlook.com (2603:10b6:403:2::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Tue, 21 Apr 2020 21:08:14 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7e39ebc-655b-48ba-551a-08d7e6381bbc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:|DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3817846F5D7C626F9317560AEAD50@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(6486002)(2906002)(31696002)(956004)(8676002)(81156014)(36756003)(8936002)(86362001)(4326008)(31686004)(4744005)(53546011)(5660300002)(186003)(26005)(16526019)(2616005)(16576012)(316002)(52116002)(478600001)(66476007)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGMyZpaeENYJUi9rvFfL0eD/+VG/CQyZtzImZZRRpE0l2KayTSEpz35abnFFIWPLXJ1icmLOyGFm5YeYk4VRdCYTj9k+VN+YMvKp2lQ5U2TYb6o0WgROa+iAcjwVMpPsV9KWso++itTm7Bt437MDbQkmlU5P9A+3bROXJn7Bmk89ahchL0Ww9jrvad4+VUMqwGgYH6i6ap2hLDhaRuLf4dgqcIr9uz2Bvf5C8YtZllLxeLdnk3FxPFv3ABoLjwvcdzga3HRUaCA4dS9H3xl2zKwIWX2X5FWIzypCcRxEl7Ripnx/l7HkAybB3H2S/XBxXLWCxAwgFcaq2k5O/SYXWIbK24t2PbJyeev85zlbZDd/te5TSWGJ8ueCyjSZ8wJskv8kqPFtXwJQKgNdo4g2Z3Bp94pjvRVVgjANcHrsSRLV1niZTwGNCV+/PEkoMsqt
X-MS-Exchange-AntiSpam-MessageData: 3PyO2rH181jACue9E9DrvqK6oqjkQ/iCEgyDbuM1lGll2nOjf+HiyDpZLjFwlMWI4+u/9q+mHen5hkPkhVjxSmcqsRVZzrPsfai3rf/LqYi/uxQxGJA4sNZAl1FKI0EPz33M9JnFZhC2kVyLg8NShg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e39ebc-655b-48ba-551a-08d7e6381bbc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 21:08:15.5990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFU8b8Av+2mUcX8hIenNF2etdb3WxH3urdqTTDp1FQMTqCpJPpUfGc59llowGVeI7dd+c37qmmYN8FkOTZLA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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
Cc: Alexander.Deucher@amd.com, Jonathan.Kim@amd.com, hawking.zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patch 1 Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Patches 2-4 Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 4/21/20 1:23 AM, Evan Quan wrote:
> Patch 1 and 2 are the necessary fixes for XGMI setup. Since these
> operations are needed for other devices from the same hive. That's
> missing now.
> Patch 3 are 4 are basically code cosmetic.
>
> Evan Quan (4):
>    drm/amdgpu: correct fbdev suspend on gpu reset
>    drm/amdgpu: correct cancel_delayed_work_sync on gpu reset
>    drm/amdgpu: optimize the gpu reset for XGMI setup V2
>    drm/amdgpu: code cleanup around gpu reset
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 92 ++++++++--------------
>   1 file changed, 31 insertions(+), 61 deletions(-)
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
