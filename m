Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02A7C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 07:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7F6206DC
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 07:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WMHI611U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7F6206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A9606E824;
	Tue,  3 Nov 2020 07:05:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E19736E824
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 07:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD4KWV6eC5BOuv+FXlFK7L/sSiGzJjd1NTiv6fuvCJez3l84qTlx/NRmV0nY/Jw6LIgArxRJPWOk8WegTqOI+prmSlboaDvHyVtj5L+wOGuViX6jiTi5jSN7KJx2TjAOKNS4pVOJkhIoirjggsAB1LMk+D+APYb3e/QTmqa2pBdQhVeLFWj4bNJpu049okBCtIsyPWKKDb9I4TuS4pd4QerBqPuQcDWsuqFnyuwJQAPlaARJ9GrXNZ1x4edFsbyexa5mDzAWWQdw8jfvrU1CUDPylQ8ZErkiWJUWKH8rdsGnOY2elDwNIdBX9h0QMjHWm93rLxWpnCtQ61dqHsCKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5HqA3xo7RoIAFH8biJHTD0eCVYaY12HaeJqww4IoRI=;
 b=HCYgqZQS2++8yiyi9vlTGrsmnH76RFeTToiF5Zklg/y8K9TVfmGuvt+vxLU1vpKzIv1M8wd7WOhuVu+2nM/hqjnCj5m+C2ej3jsV+aw/0N7iLYO95tmhSAXX4L7SEAlwC61aETvwO5jo6Ky75rcqGdpumYTuBUZu5gRqlBIdU2kUZ8NSQwqcvGmjEHRAunXT8Q5br8oHIVeQNaDkAYxZcErbYPYj5XytpyoJMpoj6qarkff43Kq0Z6weOlkRRi2lssfx2DGdHLN8rgEzAHB6zA9SY6ONmHeCuZNC2yv1JEav/2NGQW9jgx43lnjARmqon+UZc8nQLb9TSFfLOhngfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5HqA3xo7RoIAFH8biJHTD0eCVYaY12HaeJqww4IoRI=;
 b=WMHI611UeQk0uCFD4jksjpPXahQDhAeaOo9Gqx9xkVayUQEyFo/T3Q2R7JZ5iZrnhDiG3bLEdY63ZPWI98JsimOwMVPmZBpvREJsBBIhvatwd4HBrozOTcGNqLDJYBEFXmDC4iy866oTQZ4+nJ2AwPnTqKde2BCeEWei15O/I+k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 07:05:05 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 07:05:05 +0000
Date: Tue, 3 Nov 2020 15:04:55 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add GFX Fine Grain Clock Gating flag
Message-ID: <20201103070455.GA2331016@hr-amd>
References: <20201103061621.10549-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20201103061621.10549-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK0PR03CA0105.apcprd03.prod.outlook.com (2603:1096:203:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 07:05:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e63e5249-484c-4f97-004f-08d87fc6ca81
X-MS-TrafficTypeDiagnostic: MW3PR12MB4364:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB43645A7C6B94133351372288EC110@MW3PR12MB4364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yp8uKjEisj6Tofb5QPckgT1QUaVuKMiTkxtGlHSNkW/OZCOGQ6cZJgyDsuKJJX+kW5HghnBhtAIRYKBIyiHQU8GE9EoiQ5vHvs8opTjHLTi7wFR5geGrU756JHfJlX+i/VCHDGAKxnnDns8ZNc1p1LD5MF83ypAlqJHQ64b81/sMH5EH/puCtn6vdwxxkzuxQsWOuViCiDIQubs1FGAWVjU9z9oUGTm3oOP8RzSsTXJpPgpJzmrltkoWgCSj3tk3KaFuTbXSn/g0fI9kVhrVQarwD2TWFK1Nj5Z7gQrHvL7yq04K0LKRkuxxr6FbViPvMfbDKeUbFQpCgySWuvP2YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(5660300002)(6862004)(6496006)(4326008)(33716001)(316002)(52116002)(33656002)(8676002)(6666004)(1076003)(8936002)(16526019)(186003)(9686003)(26005)(66476007)(66556008)(66946007)(478600001)(2906002)(956004)(86362001)(55016002)(6636002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mu3hDf7n7ehaxx5fGJLLGi047Iojfzun5qFZDgJDHW7xxGwY/MRxmM/6YQeVtMMJg2Wa9Ezp1NJhpX7tAa38dRKDJwNykbpXxIKNGXijbLX9S5LvP5g/PuOlUm2LNVNR8YgrLFULGss8KVG9c7l7l+c8+w1ObgH38JzY7qYSP2hM6cHGXR7ywsvnm185X0gnC1NBr8Kn/8jLNTZFXem5WiUrgPB9K7eEfISP24TN0qqGKc+xtBKoG0QT4uLhnVZS68bfqRkdMZyuF+iBSmDyMLxbahfui9xs1JZ2EMfRHKFJ62uzPVDjrtPIC8AMLHXHqN9EFQFCdjQf9uu9yinVuw3qX/P5tC05L/zOjw6a6GSqdP4LGlo2AWTomdwTopOeWebRTAwu58eEO7aq2YgJmaZcDNagtaZiYMvcYfmX7IdWu5NujV+dsN1SzNTL+lf3c2csIeOfR8vTBhQJj6ehXZ5c0vq6jFmeR9VWxxbwYxZY2+Va8XcTS8lH6GNKgGVId8XzUD6XlT9kEAHBlMJ3TzHfuumQCoprUS5WjTugjKCsqBRPW/3x0KRI2QV4nBcy5jUGxPwMT9eQujeb3+GNDm3KO2mSQb0L8sFSkgzdetdAtnoyA/aZfBp4U5w0f4S25DTXqh8Phmkd3a7ipawTDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63e5249-484c-4f97-004f-08d87fc6ca81
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 07:05:05.5147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOQy2nrgZnhSdX5PenBO2TBDQECnafpC59LhXhe/DxCRjeupYd+tS5MUe8SnEMtM8yUnpnrw6jtbPjulvXZc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


With Kevin's comments addressed (remove change-id), the series are

Reviewed-by: Huang Rui <ray.huang@amd.com>

On Tue, Nov 03, 2020 at 02:16:19PM +0800, Su, Jinzhou (Joe) wrote:
> Add AMD_CG_SUPPORT_GFX_FGCG for FGCG
> 
> Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
> Change-Id: I97e10e258e25a60de2604b8a31514421f6819448
> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 1 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 412602d84f71..9676016a37ce 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -144,6 +144,7 @@ enum amd_powergating_state {
>  #define AMD_CG_SUPPORT_ATHUB_LS			(1 << 28)
>  #define AMD_CG_SUPPORT_ATHUB_MGCG		(1 << 29)
>  #define AMD_CG_SUPPORT_JPEG_MGCG		(1 << 30)
> +#define AMD_CG_SUPPORT_GFX_FGCG			(1 << 31)
>  /* PG flags */
>  #define AMD_PG_SUPPORT_GFX_PG			(1 << 0)
>  #define AMD_PG_SUPPORT_GFX_SMG			(1 << 1)
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 080af05724ed..e57153d1fa24 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -39,6 +39,7 @@
>  #include "hwmgr.h"
>  
>  static const struct cg_flag_name clocks[] = {
> +	{AMD_CG_SUPPORT_GFX_FGCG, "Graphics Fine Grain Clock Gating"},
>  	{AMD_CG_SUPPORT_GFX_MGCG, "Graphics Medium Grain Clock Gating"},
>  	{AMD_CG_SUPPORT_GFX_MGLS, "Graphics Medium Grain memory Light Sleep"},
>  	{AMD_CG_SUPPORT_GFX_CGCG, "Graphics Coarse Grain Clock Gating"},
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
