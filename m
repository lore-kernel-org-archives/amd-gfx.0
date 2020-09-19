Return-Path: <SRS0=7fFe=C4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F4C43464
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Sep 2020 01:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3802085B
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Sep 2020 01:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IFv0sTFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3802085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329DD6EDBA;
	Sat, 19 Sep 2020 01:06:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7156EDBA
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2020 01:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiqJXHm9TMz0BmD2ifQgzq7xUJmyku2hlNUNvVo1QQ5h9YK/tuk2yfd/ulWVIpVcYK36g2i3dgyjnrBKJCJs+bHMbuAJs5+8ajZ5SfOUik+UqnEepwtncy3ujgY4xPtNpJvoEf2frzNzO3iKq/3I7q0BP779VXdfzoTW3TTMbyBdIi03m5KQHWjhvwNkvZLBq2FImJuiQsx7we0jIfMSlLosvyYxuceMLC6R7H5zIdRWEUmMV4t6b6nBLyhG+7b0MrV6HlEy5ilg7W5q6QfCnwqVLOq0um6JKxhh9iCzt5/dl4G4cUdk/lu9RyuVbPdRpcZ9YEW355Dz4/amwGxd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LyhegrCKTGvkMtbpxci8yGtIYBTJfwbg0nF66X9QdA=;
 b=f02fGfGVWejoGvC6VfemXfspWednhdxVkaCbGrqFLLoBzJfXH45zaDUmBJ8U45UsHBHFzZS8OPxG1kK6q6Uc9YLTCpfTMik0B3dPupiEHi+AIxU7PhAPE6R3A5r/QJTqF8p6eGAdpnjeC59SY1g98G4I7mlNYhcSGQsQuROJrZiw2Ygaljiuc9X9OyvQFNiXpOiwFbo49DUzTW4sO1FuqE7WLvGniQ6bI5MugPD1DnjCiUCdqlXrCJ096VoAJIdxbEPUmMbmbEYLb19WsJjW6D1la6H3ue62FoVIz2ixyxlm34s03vX1zyrxfxNP4wKJnzCFSP/UBiP8QQyK7U36hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LyhegrCKTGvkMtbpxci8yGtIYBTJfwbg0nF66X9QdA=;
 b=IFv0sTFrJbN83CEY5qr4hg7ulZzEZKaXHCkO56GL8hQneSYOSinig0U63HJiMQALVD2UuzAd5XJ0mF5nq3ey0aSeDEja9d+lbeIc8CknzQaK7wDm5ITLOIHGAcY778Jf15ggDeZU02Rx6o6a3gYpd7CZ8LQVbbPMOxRpqNAWoKI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Sat, 19 Sep 2020 01:06:22 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d9be:3249:294f:1dd6]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d9be:3249:294f:1dd6%7]) with mapi id 15.20.3391.011; Sat, 19 Sep 2020
 01:06:22 +0000
Subject: Re: [PATCH 3/3] drm/amd/amdkfd: Surface files in Sysfs to allow users
 to get number of compute units that are in use.
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200917171118.2579-1-Ramesh.Errabolu@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <d2118f61-defa-2663-2cd5-e4555b82e357@amd.com>
Date: Fri, 18 Sep 2020 21:06:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200917171118.2579-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::44) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTOPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Sat, 19 Sep 2020 01:06:21 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dd3aa0f-a2da-4e3b-a470-08d85c3838f9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB47781D78030B4ABDC4D867DBE63C0@DM6PR12MB4778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: as7Iw/vvIZikwP0kro/IOR8KQbg2QBuzbMgj5QNsjQ1CEAgBMv3Xl0zu0fy6MZUYetpJNxNsMyaQRQfBG2ElXNQokxlmn16yF9hh80hwTQvP3/7yq7OEFG8V751KF7/crAqOVi7x4eZAynrPeZV8g0CfxI+ScDmNHg5Z/oMBHoQItBBtzqH7W4QZ3U2XM3e7SY5OsNwZlkSmyhbNt1S4qpq1sErDlOz92n9dXAO1zbybRFPTB556X1zhrRmG7Hkj0jw19eh8bXchSGgkY2oHOllQmdPXIkNxFrNAIuF38jdi6mJdCJjQRUAQ0xZ4yzWzf3O6Xub3VPWZGH1uC5/intlep30Nr36C44F8R5OgVnQ6/IweJr8M42DUVb4ogf5/iuj7POxzlzZIMSlC7NZKcTnvLiwTUn1UulaPSdGEBCfCuNimFr+HoXc/6VdYgXhr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(8676002)(5660300002)(4744005)(16576012)(956004)(31696002)(53546011)(26005)(52116002)(2906002)(2616005)(66946007)(478600001)(66476007)(316002)(6486002)(186003)(16526019)(31686004)(36756003)(66556008)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rlDAIjPFwfyezB7xaCtnKfXtpTP9FdunIBhuFUkGSqZN3I6AzGraNKPD9GNxTPISi9O4lcrv3IR4e/GL/R7LX38zK2+11KycMONmDslILWWs0QU/UOlDbLIWyheJFh3U9NG9lQC1kFApdcuyiknFl5fKWKObxUkOtJvZL26En6FYgwNoKSHe29a0DAV1a292RcYhvS9eSfYvkC7fPD29NhLS3dXUYmojafAW8olmtTAqM4y4bZ6kNc+BuE2ASLGHeaotMA72Gd1/Sq5DNGv+ceprywpQ6MZvUgQRCi/I0jBQGPHLR7xnURADeke5xUE2O3RnmGiGtsqpGxN87mFA5GMYnw2NyI8m9mHirG+wZboNbxq0Y8MMtydePF5GRdkxUErY5FQ3SeNkP8fvv1+kdT31gVs7geUaPcOr857S0eT7Tn/IcXRrCi9iVOIaUmtLucCNOPHFutf86UISC5WrT0IU2PeGTi4X5y7dDL4nu8sFo7rLq8E0m4x72mhizXHrndqxOD6p0M6SDqNFSxQyTfFz68CBZj7Hta5k3JG64WUoQsIZxt5K51PInTPPQmg7e5UuMH4yR4rPZjRVhlFyYfksNsrjK0KLnxpc8JppoR4RD3C6kyahPiJ89jfNfcPOo8L4Ihx2ZT2vDQxvUw3jNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd3aa0f-a2da-4e3b-a470-08d85c3838f9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2020 01:06:21.9881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQlmnN2E35uSzuZNrhWTOpE9ebw0pcTuuozdeINjrVjVlTLbkYlZo/UsdRUIbAyn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
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


On 2020-09-17 1:11 p.m., Ramesh Errabolu wrote:
> +	if (pdd->qpd.queue_count == 0) {
> +		pr_info("%s: Gpu-Id: %d has no active queues for process %d\n",
> +			__func__, dev->id, proc->pasid);

pr_debug can be dynamically enabled in dmesg if needed, pr_info will 
always show in dmesg.

pr_debug("Gpu-Id: %d has no active queues for process %d\n",

		dev->id, proc->pasid);

Philip

> +		return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
