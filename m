Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6873AC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 01:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8A822C9F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 01:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8A822C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6D489AC0;
	Wed, 13 Jan 2021 01:55:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B8A89AC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 01:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTv7FR6BifpzQGAN0A0YfAOQQT5m/omKnixeswOHc5Qnqz/MwtQfuKzjazvogfh1BYc7rSpyz3ZJ+9c18bWb3FgSpBMr3lAbqY6E5Fp8AZ2/6VZP88o6YsIs030mqw9Zw7LSP9Bkanq3HdvXhAPF4KNazjZCWt/ytLImd7c6yFMescQKRg6cEWRUbisGggf038zPB0WPeYI6GULXyp4pPV7vSCnQSmcKqYuBVAzNvZVBThTC/QtPjPfXIgdjSTA/CrSms+DmNzdGERBeNeiFeHrK/lUClg+2vNSkIis3DXIFXTECALI3en+gga8vlH/vM3ZRgNM3Dr4g7P1d7MhK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mONOD+GKXaqtO8eya4XGamQXSogcUg+2uMp+rk2y2MI=;
 b=io9eugm0dtVGuQRjC8QpaMAslT8vwPQIjOFiCBcNra26o3gtwmTdpe905QLJK5mx54SmGKvoZwxDVk4qBqJgFrtzvcg9h6HNOjEDlIqbqZZxDNk/zidwCc0SWyZzQV8GO2ze7ZR2sIW3X/Lw8FwhjGdj1YQIZs9bGLJaIyb0Mgn8fw6T60BECr5JJSqH/UYR/4WYRMPctFIEVAIhTwSd0BbsIvo6MjNTY4IYcpJoZGwrcKuiz2IZySR5TS8xNLEMyeonDgH5x0pvYld3eBkgXtIy33fsfwzxXiZVuKJEJ8I0anrGZjZPrR+/AAWjP3D3mCtRGvnbvEbJI0T50CZlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mONOD+GKXaqtO8eya4XGamQXSogcUg+2uMp+rk2y2MI=;
 b=M2AeO81DkYvANDFmu0TzUeZWWRstmozjEZeAtKei1fgA3C2JtJtenGKYo2QZ5Wcs6ApWmrWv5WA2+mZE1wvpgrg8e1vlciDigcxwf9MFvxeG+rDMw23JgRt/dfLTyy8HuJZBVdGcEsMxzsPKOwaRqdLD/FBlDX9mYBRXFnMzaHg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0125.namprd12.prod.outlook.com (2603:10b6:301:55::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 01:55:31 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 01:55:31 +0000
Date: Wed, 13 Jan 2021 09:55:22 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix the return value of pm message
Message-ID: <20210113015522.GA135893@hr-amd>
References: <20210112102508.82417-1-ray.huang@amd.com>
 <BYAPR12MB364043FB791CA966A139ECEC8EA90@BYAPR12MB3640.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BYAPR12MB364043FB791CA966A139ECEC8EA90@BYAPR12MB3640.namprd12.prod.outlook.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0151.apcprd02.prod.outlook.com
 (2603:1096:201:1f::11) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR02CA0151.apcprd02.prod.outlook.com (2603:1096:201:1f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 01:55:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2465616-4821-4d0c-459f-08d8b7664edb
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0125EEB8C3E650255948FCFDECA90@MWHPR1201MB0125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMMRHHRy5iyNsge7NODK0AYbmHvyJwgwU01Ycf0QQqtNnEy9aLN1QKXlLRp8bJ0aY0KDvyQXiHYWbACdm0PH5ov79pKb+KPfVmX38ooqcK8SpseuYvUqP90QTOUdo91HujifDlhmNboaLAkn9HlBClxx2fpsa+PfnFu/9kS2M2gIAuUdOdrrRdaXNxxYR3KVjcdB8OYGZU5vQYcWg5hEQbA6VJvaKbWsVeeHG1J1BlRnP78S9xEoiPSjPoQ6rXF4jd6MqCmfJyyyUjyUhJKJ9U6trwAnXWyNlPRVKfYlAhNMtZ6HZOX8lEIIqaT7Pds3AnUrPQBC6YNOaW8pngOwUUNPPYBK6ox8ji5BuMi3TeVfd25ofoY2ALY/LWGAvSByP/3QDTAX9izHqfhtoo6hxZGpq/3ubL6bFg/B/CH7M6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(316002)(8936002)(1076003)(8676002)(66946007)(33656002)(9686003)(4326008)(6666004)(66556008)(5660300002)(6636002)(86362001)(66476007)(6496006)(83380400001)(54906003)(33716001)(52116002)(55016002)(15650500001)(966005)(53546011)(478600001)(956004)(6862004)(16526019)(2906002)(26005)(186003)(45080400002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hGBnnHZ5ty0qasd/il1zJRX7vHqTWIT/82EDmHL1HYwFQA/9tHlSEJaS0kTR?=
 =?us-ascii?Q?N7KA3AO87HRKDLARtYy/zQ49Xj4XTDUq0jSmAxHSuKDkBumDxjU7Fdic0X9F?=
 =?us-ascii?Q?d6qN+byI/YPA+gJZukjiPlGzAfCcleC7Sj6lxhF07LgYOaelu+/rYQguiPzF?=
 =?us-ascii?Q?b70gZ5ZMYfKuyZ9+V6JKhP79luabw8nDUAo2Cj3/HaVYZpUEPfuMJ4ExAgau?=
 =?us-ascii?Q?BUz33ZJjlqe+hJLIQ6eY5KWNIFfuezzx2U+PCrLBEqoQU/C4NP63uvaKQOUP?=
 =?us-ascii?Q?0GgLKIN4BQxT558T2Vfhesx6jfVaMenDCtFWK9VjkZiDpMCEHYmxbXYYsd3w?=
 =?us-ascii?Q?l4elXmqgyiOpFqlMRH2R2DdHRsAIPwXhueUWLQ7qNPzZjTQ2pSiBSVhQ3p0G?=
 =?us-ascii?Q?uwCUVAQ++JGhsnM1fJ+b2k6OcLNj1vJ6S2Lp72Et4YPqYyt+Cv+8HkYYDm8/?=
 =?us-ascii?Q?8zUYM9mpwnCdcb/ewuu5ftzyBAJ4WLMNwDL2hcFmJWZ+/PzdqUpnEdgmjI/k?=
 =?us-ascii?Q?bGDxO67RKaUSs40blnHUUfbeIG3zTIHfnfJxgRCrjwSiePgZp+8Ui+o//9YD?=
 =?us-ascii?Q?klkeOGgayjp13hTj0Q05Uw9B0Xp+Dvch9PJkcPxoNM29MnVna2n9ZHmSUOF0?=
 =?us-ascii?Q?HW9CabYB4MBcJWOkc/trGjHvCnxtQSNbef2fyc5HzIb+pUM8qaIfA+BtZ9pw?=
 =?us-ascii?Q?lqsOdqQPUUFJMFmLnVEI5Uc+rBO9zROVumwBA3QFNmXi8229641wdl+8u7EC?=
 =?us-ascii?Q?ZYFEekoH8q+s4cFPFoIawVVsIQw2ARr6kbCq265JLHrSOV+rAt+c1DW3UADj?=
 =?us-ascii?Q?pF53sUfRC40D3Od8eFJH5Ck3e6VRldHOG4XCWbw7A564h95duRzfBUh4NGai?=
 =?us-ascii?Q?cFwBbnaNSkTYIbN5tH7F2ZNzPh6ANDequMn42VoCbQ9qFqqB/6qFYVMQQ9lO?=
 =?us-ascii?Q?jekMoAhrO5eFfCHTeEyn3bGaNvUQPNBM/0A1EFUP41JeFmepW6l5rhIp0z2G?=
 =?us-ascii?Q?sjTQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 01:55:30.9146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: e2465616-4821-4d0c-459f-08d8b7664edb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9XgcjmozBeKtS7ePCQP7CfGBGYSXiJeQos5uWFfpnqObH1n40Rd/8WnjuhZxKzr14PByccdAkNMjA+bzmkCWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0125
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
Cc: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Hou,
 Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 13, 2021 at 09:45:31AM +0800, Feng, Kenneth wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> This can fix the problem of the below commit.
> But I'm not sure what is the real purpose of the below commit. Or can we revert it?

We perfer to print firmware return values like below:

#define SMC_Status_BUSY                0x0
#define SMC_Result_OK                  0x1
#define SMC_Result_Failed              0xFF
#define SMC_Result_UnknownCmd          0xFE
#define SMC_Result_CmdRejectedPrereq   0xFD
#define SMC_Result_CmdRejectedBusy     0xFC

dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
        smu_get_message_name(smu, msg),
        index, param, ret);

-EIO is not very useful on debugging.

Thanks,
Ray

> Thanks.
> commit 72a33b4b7433780df5334f9cfb23ff51669431a0
> Author: Huang Rui <ray.huang@amd.com>
> Date:   Fri Jan 8 16:27:15 2021 +0800
> 
>     drm/amd/pm: enhance the real response for smu message (v2)
> 
>     The user prefers to know the real response value from C2PMSG 90 register
>     which is written by firmware not -EIO.
> 
>     v2: return C2PMSG 90 value
> 
>     Signed-off-by: Huang Rui <ray.huang@amd.com>
>     Reviewed-by: Evan Quan <evan.quan@amd.com>
> 
> Best Regards
> Kenneth
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
> Sent: Tuesday, January 12, 2021 6:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Du, Xiaojian <Xiaojian.Du@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: fix the return value of pm message
> 
> [CAUTION: External Email]
> 
> 0 should be right driver return value, 0x1 is the right firmware return value. So switch to 0 at last.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index d7d86fd79e1f..41d5c65a2f21 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -149,6 +149,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>         if (read_arg)
>                 smu_cmn_read_arg(smu, read_arg);
> 
> +       ret = 0; /* 0 as driver return value */
>  out:
>         mutex_unlock(&smu->message_lock);
>         return ret;
> --
> 2.25.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7Ccb87272dd89a4b4a6bef08d8b6e463fc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637460439339749600%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Hzm73NA1Y%2FSS3plnWpZ%2BcOxyIvEnySRBTTUV5%2FV6Lxo%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
