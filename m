Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C27C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 12:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62599222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 12:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="saC/ysUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62599222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287AE89E3B;
	Thu, 19 Dec 2019 12:01:02 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750071.outbound.protection.outlook.com [40.107.75.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C78B689E3B
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 12:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhcrsoJvazIEhhu1Fz4Vpw4cpfJ/VLzW5bA1GMcTmbCAOIoX/RxyoFCdMNZhRGaMVu0TOWCixNO3fcAGkx07tZIylKTaLl4D2T0/ggH+NFurbuD0OUOil5zMCAVwGnMU6T1L4Y3KfHToO85IK2R8qax2LdlfOdwKIMIzl0iPoWb2RMZ26fCQJMHUhP25ZcxOgUdM+g/hvqrwtWAfl3H9AHwjL3TXIC3lKeQm4b+TOJ1TvJ7dq2xjefa9eLT4CyL4kY/MRCeG8P2C0tHCOHPUy4i/7EHVNO8ExoqDxUwZP3VU0qQZm9phRM3MT18jw1gegqg703J1avALMCRHj+RNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Snf03DqXXziH1eDy4o4R59yBfYJY/DEPi3zlhH9nIw=;
 b=Zuk27XrJ2jbZ/A5CA7ir8KFDP9QcNhdgeHmWeLKEbUV7Tj/tlL9by7mJBULnwmH9WXNS/RZa+4m/2AaEM+ullITt0OSLgZ0RUQm5wZZt6RN61z1z1AGSdV5Dsb1sgp8VqxRb7wvkvEGZBkJHe2JaQEhPfk6EMoKdQ2a1uRqqhMDbK/wpQNKsti1BnelcevaPJoT+ZODDDPE/MvxrM9VRAlwNNhM8k6Lq1WNz/FxF2afnSnH1GdMqRmE077JepUCwGe4GPBnHMjx+Wu4SJ/GxBc+6RCJmKYmzprs/oK+DjC+Y2CXgN9jQJyksGCf7HGx6u8cp6/v5eCX1UnjY7HL3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Snf03DqXXziH1eDy4o4R59yBfYJY/DEPi3zlhH9nIw=;
 b=saC/ysUw7eKoWyPPaMuSgNsp9x7OHHm/7KLYtx/ZaIbS+724CmCA2ErAxRjCtwp6ZbGKBDm5pGPHjr6zSQHNYzjb8APEAWrzfHbVcLYwBkxSyCiAJ/EnRSEY7qxwxtgUwodgWcONLgrJVn71S+YC2oF2mtRG520iAVKHnObuWtc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1130.namprd12.prod.outlook.com (10.168.237.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Thu, 19 Dec 2019 12:01:00 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 12:01:00 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: fix ctx init failure for asics without
 gfx ring
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <1576755748-9800-1-git-send-email-le.ma@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <468e6ef3-e08c-17ad-8c83-f3efc3b04f85@amd.com>
Date: Thu, 19 Dec 2019 13:01:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1576755748-9800-1-git-send-email-le.ma@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN7PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:408:20::23) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-Originating-IP: [2003:c5:8f2c:6b00:4ecf:d385:4343:2461]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33969beb-96b1-44a7-4f9c-08d7847b1d16
X-MS-TrafficTypeDiagnostic: DM5PR12MB1130:|DM5PR12MB1130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1130E01D9DAAF1004561BBD08B520@DM5PR12MB1130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0256C18696
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(4744005)(316002)(81166006)(81156014)(186003)(4326008)(8936002)(53546011)(6506007)(478600001)(66476007)(66556008)(6486002)(66946007)(2906002)(36756003)(52116002)(2616005)(6666004)(5660300002)(31696002)(8676002)(6512007)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1130;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPK6XWtIl4UIQgUB1leHggN9I3VGTx/RVVBTeDakeaCVMB1breelQ54nFHqhQnx6vBVovzYSVtGA9fkGpfl6r6WjWJhQ+aVuWodqBlbb4y88zNYn5sDDCHvBZQ4oUDBZvr9xKRcc/CpHE6EPVjbuNfP3mnwg6s31ULtzTcaNE7vhg2N8nssRuwBSkd0OzhJ6mEcuKYjTGgEFLck/aK2qdLkv9ibv0XL498ck+XanvVC+575wDph0/Bysb/Skwo3tx9OkBjca5z6lTeKge88Bqkdfjg8vDwKBIWT3pXBuxJMUWN8EMBYueRa5QkiToWl3YfUP1PktVMsqWPCup07FP4F17O+W0s6NFnMKRpgIyhkZff53zhR7Xo99aU8gEeHJzaq1ihacSXF1XmT7adYfTTyPlHB5rKHFq2JfQF7Or9BiwoUAVTjg0gbJMMzlzhPa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33969beb-96b1-44a7-4f9c-08d7847b1d16
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 12:01:00.1618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAqfQnz9lAbEIMSgGMAmqDHOoCSX2rqH3I/6Mqx7I1Vn2enjRXzlegec9dXet2rTBGhEyZpIRbjif103/K3ryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
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
Cc: Feifei.Xu@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 12/19/19 12:42 PM, Le Ma wrote:
> This workaround does not affect other asics because amdgpu only need expose
> one gfx sched to user for now.
>
> Change-Id: Ica92b8565a89899aebe0eba7b2b5a25159b411d3
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 63f6365..64e2bab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -127,7 +127,8 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
>   
>   		switch (i) {
>   		case AMDGPU_HW_IP_GFX:
> -			scheds = adev->gfx.gfx_sched;
> +			sched = &adev->gfx.gfx_ring[0].sched;
> +			scheds = &sched;
>   			num_scheds = 1;
>   			break;
>   		case AMDGPU_HW_IP_COMPUTE:
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
