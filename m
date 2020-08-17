Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB54C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA5F2072D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 08:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PWM6u/pB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA5F2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08146E051;
	Mon, 17 Aug 2020 08:38:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58966E051
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 08:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5EXzmq1f1LLZJoJ2+wtYL/Wcl0t3jRCHOWSVmiCNaWPQqSIo4Nq/iIDuoecH2WX9W5LmzHYbXHMasxf9ceK2KUe99/JjPtzJDnJTwu4EMUJ2HozT1gGiAzxfsPZQjX6A19zNK3fo4TSkqsA62xb28Ab9/m1LrAqk1ycv1MNFcCZWq77uXZ+Eo+FGQNJv7GP9gcsuKw+ySrBwGocuCcjEeD+FYgWqtuqBllxElnm0IRlnsFv3E7OXTVBJvqQ/zcW0NKWOvU0U2ZqitXGtAJzw6627hTPX/0RYjmqHicQw30E+NgBkTj+lwXl1P6KLnPrAwF9c+EiK5ssZRD1TK94Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE5D1RFjXQnK2scRcDLvxroNbzkLl9CSblQdKrrZhQQ=;
 b=lhlXeZK66ijMl3b9zKxsbnGgVEwjF9WciNC+3JcvLWM9H5ev7kBZOkNYusCo7S1ugC7Naju83utn9+9YBThBmx8QqCtOJ81352f5oA+LGhhBWLJ3UZ2rbkxu1t+xTXc1YF9a74UZvB2doLKwR09EUDSF082CCintvGOkjjIO3n8yfnFMeGaWoRMFUJuNC9itVWD51zUGNyeyVBKjDf5oA/zp4yVkhEIisSatTvefJJnLVB/WHK3I5b2RtxXQcfmpHShHaLh4I8MhhcJXhyycVGlfLDCBjSC202rbUkFzNCzBPmPHAaKcT12VPjt7OKmY0/wx1S/nfZIasqIhgc3hpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE5D1RFjXQnK2scRcDLvxroNbzkLl9CSblQdKrrZhQQ=;
 b=PWM6u/pBObctAXdYA5fDzEl0L6lNyiOuyVdVZHr2D2hRAf4EwQpgl1er96oHjRI6LV9H6qAvz5xoqXf4yusCdR+Yicgxvi5HT+jJsQxXaZRPm3pWxzjPKvH+Gll+l8k1/SNT51AB1xhY70rEmy9MannSS7LkUV5INxdEk1qwLDc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 08:38:01 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 08:38:01 +0000
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_bo_release_notify() comment error
To: amd-gfx@lists.freedesktop.org
References: <20200817073535.699-1-kevin1.wang@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <0b07ce69-4c73-9347-2222-eac2c1ab310b@amd.com>
Date: Mon, 17 Aug 2020 10:41:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817073535.699-1-kevin1.wang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0069.eurprd03.prod.outlook.com (2603:10a6:208::46)
 To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.32.148) by
 AM0PR03CA0069.eurprd03.prod.outlook.com (2603:10a6:208::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 08:38:00 +0000
X-Originating-IP: [93.229.32.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68b73dc0-66f0-41f3-fe87-08d84288d9da
X-MS-TrafficTypeDiagnostic: DM6PR12MB3068:
X-Microsoft-Antispam-PRVS: <DM6PR12MB306813FD5A50345B69FEF8CA8B5F0@DM6PR12MB3068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/uEhgg3RB+/mLgH+HVxo20YS4G9YHK9z5pgPqNra5g37N9h8VgWLT+4kriBfhw3YFdJRjXgSV8a4/JgTZdmF2DAyTiYBPa7EZ+GMnY9wPZXFH6iQ9E6NraJ+ZyR8/bOQvt0AhA4GvowLUtGUPYk8MBh5/a2Xe5feWUZuEs/6B7tha9kBaM+CrcnFoWA3PxNZ1yA+CkolETc9J+ZQ1IzCE8BHJItoUxZUww151hD8LSTwS0lw9w0Q8l+pLtHpODzIz2WN1mxZui9p/8vK1Y5GRXLNnrNhgIqBGhh9s/1sBwTGAj6jK+4HdrZDP3Zd0vKEeibQb5z9e4V1T0Bt79qWZpvq7Qp6tvqX7XbMs+sgTbGtYWcxajp5Ct6PBqPUOkq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(316002)(16576012)(478600001)(6916009)(2906002)(2616005)(956004)(31696002)(8676002)(5660300002)(31686004)(8936002)(4744005)(6486002)(83380400001)(66946007)(66476007)(66556008)(6666004)(186003)(16526019)(26005)(36756003)(52116002)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Lu/SHrHGKg4xIMQNVRl8h6BzVlPpdTAk7ynmHDP23j10K8osvHCMZUAU3o8WdHc6whseTFPv/7+FMU8KQr+BmJ8LWTrNJ5UIQ2m30pzYMMPcFaXsNi2l074wwn6hdyCrWfyZYyEi/u50F8kVr+oCJ3EEHa7YEOCPLVOQ4hvYXVQLB8y1ZMgj1h4zoKjSDh1xX+fCI0Jhz9uHetkmYRFG5XEGOmgbCRXVmr5ljTPHm94bJdwsqmaWkR+vSaCmiVCCYaGJmEXs0PL5ly4ofnNinzgq57sk7lu35k5+Y4c/9Cw9Z15eeK8bV+ULI8IJStezzq7k1suGOpQDwPEUNIOCXeeCeZ5XSD5aryvTGB/NT+TBMN7nohNgVxxlkJnsym1KwPqOTpcK9rFBU3gHRJiM0EeW196Xy/6WYbKOocjL0CzevwxNLvItbXD/nN/+tSX9C8uuTtTxKHHF+UzVQtn/4wZdtQBbk2vuFQJXkfs8XFHFeb6NGfF++blWvZRv5OJxC+lSrKietnfFVGRf6kZGhIHxx+gZhan1DmJenTvplz3TnX/9vJZWXvM/xin1LlOmYX3Je1GpTurao2R9YPc6VfpCfhOe4tsQuUyrKrNtZ8YCkSPO4sjo8tFIuCR4WlXSJO6EIQP9rN4ILwC1dregUA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b73dc0-66f0-41f3-fe87-08d84288d9da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 08:38:01.2897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FyezGurLh3QGZCn6zTF8bK5TEMcp5Xv7ldBkel4ObESQvE97Oc0/yq6KB8jv0AtqsS8xWcYNTJZfbbSwirvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
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

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 8/17/20 9:35 AM, Kevin Wang wrote:
> fix amdgpu_bo_release_notify() comment error.
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 3d95b3edb635..4cb750ed6851 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1301,7 +1301,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>   }
>   
>   /**
> - * amdgpu_bo_move_notify - notification about a BO being released
> + * amdgpu_bo_release_notify - notification about a BO being released
>    * @bo: pointer to a buffer object
>    *
>    * Wipes VRAM buffers whose contents should not be leaked before the
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
