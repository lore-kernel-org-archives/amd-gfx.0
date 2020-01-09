Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1548CC32771
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 05:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91D6206ED
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 05:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WUddxiS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91D6206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CD56E394;
	Thu,  9 Jan 2020 05:40:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DC46E394
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 05:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7VeuZJ7ecWA9prFBwzSoZOa7miS6K+xQRn5pzjqJKY2plg2DP4r10pTFvs1hm0K6i8zyOWEUqOGfaYby0AUKueIX+XX+Fkbsqvsz6YJBE5UJ2JSCNYfVxLjcoTbp9XIsPTBDhZwQkq8T0j3NwSWu55su1aQ6gwhjlmhFEiwVjLDcobWj4b25l6wcI7wmThAhYXc0DmZ8DhS8GnrzwfU+s7PN74DpdfJF9zZo5XJzDXT+IOqWk4VJKjvcQnxg+nX0Xs8D5jKSieyFE47GDLbbCuiEs43Txlxez+Zy9tZJWc0MAb+JE5Hy6cIBhM6/AEBSPxeeSBn3joodhlb7CWpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3kvdpRI6S6ofzKg1PY1pxi5PC5IYFyKYqXbalxuqgc=;
 b=O6kaz5hOLeJjV1zNMk4yT0Zk8wwJ64fjyYSar632tjBYFtqVsrhAQECAsxV5GF1aTYk8qdTH2ar3clj5SpryUGtihv13okp+OnwtNuAMqNsW3pvqzzBc2+hmVFSYYnpgsZVxlV2Ghd93aIlcJQnZ2bIspuI8zg47xaczsQYeyFVA7My4iB0I4qEb0x8CdCEN5kUwGyAr5l9fNXBJf3UK02Z5ceHTU8sca5qsltvo9zQxLhkrL83M26kK9T+zxBB4CR5a9P3Zli3OyaHcr66Spy7PjsmaFuKBp+A1TRt9tLcHYPrgfwmyXEmxozx/8mGz6SFHX9ujKdK4uPHpP3VgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3kvdpRI6S6ofzKg1PY1pxi5PC5IYFyKYqXbalxuqgc=;
 b=WUddxiS8pClumFG1TlUhUG+gcgZ4TS3+N55ykKKbQwoup1ccYZpF0ClGGrzRDXICfmtRE8QjNI8KYVM79BIftwj1Bx1y8a+hdzUFV7N86vo3BjNpHfRIJg/QNydaVowt8a4VB0eLl+IOufaEigqsNULI7habBCZNlo9STZHJX3o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4048.namprd12.prod.outlook.com (52.135.49.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 05:40:44 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 05:40:44 +0000
Date: Thu, 9 Jan 2020 13:40:35 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx9: remove unused sdma headers
Message-ID: <20200109054034.GC11669@jenkins-Celadon-RN>
References: <20200108223453.268720-1-alexander.deucher@amd.com>
Content-Disposition: inline
In-Reply-To: <20200108223453.268720-1-alexander.deucher@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK0PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:203:b0::16) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK0PR03CA0100.apcprd03.prod.outlook.com (2603:1096:203:b0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Thu, 9 Jan 2020 05:40:42 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a50bcb4e-af23-4677-eb69-08d794c67834
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:|MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40488099D27A43C984B8FE8EEC390@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(66476007)(66556008)(66946007)(5660300002)(16526019)(9686003)(52116002)(26005)(956004)(86362001)(6496006)(6916009)(33716001)(186003)(6666004)(1076003)(2906002)(81166006)(33656002)(55016002)(316002)(45080400002)(8936002)(478600001)(8676002)(4326008)(81156014)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4048;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRptBUdcg17kLwdVYRsoRy/SyjRTQsMl5/JeBhuS8WUpl0wlCxxoOuJ4jV6UnDY3PVwd0V46cAcmxPnee4ZmAhfQwMbvF4cZyyoZ40QR7BaFpewvolEqW6qVS7K+nNUlGUSCu0WYJQ3GFgqshib93MXUBLhybAEx5LeGccPiYTbYiVtWhk/QYlLlEDYdYJ4HmzvzhnuvNfxpdOEwKHpY78fIPRzRjgIQoroh9OAFsx20rAv1TtJtfclhp+z500dqs7rBfhMxEOcWrosA7buj0EfOHXhb8Y0KscO3FVnCdmBpSaR/AwBsNojURSIl+8nl6Y4ELRH4Ht3pbUxvtwUKrG1vCdyW0/iIaWtdjBBkZDVpb4tAKfukUAgHx37w2hCgoP2NidspWCgSNL/+0y5wqoGRqjDI9MshD8BEY0v+dkk2shStLe0N47WRa4+r+T7eTj+scwzprwMtWs72DeW7mnPaeW2oAoD7isiWx/QVbiI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50bcb4e-af23-4677-eb69-08d794c67834
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 05:40:43.9572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v97Rjo4QsXnobg+lYJy6BKxsWZj6KojNYLoZe1Oy05QY3yOSuCpXpnBoJc7JSgMj/wiUHLlWFYhLB8IKXkjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 08, 2020 at 05:34:53PM -0500, Alex Deucher wrote:
> All of the sdma stuff these were used for moves to
> the sdma code, so remove them.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 951eba7522ef..ce2b02dc7b64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -48,15 +48,6 @@
>  
>  #include "amdgpu_ras.h"
>  
> -#include "sdma0/sdma0_4_2_offset.h"
> -#include "sdma1/sdma1_4_2_offset.h"
> -#include "sdma2/sdma2_4_2_2_offset.h"
> -#include "sdma3/sdma3_4_2_2_offset.h"
> -#include "sdma4/sdma4_4_2_2_offset.h"
> -#include "sdma5/sdma5_4_2_2_offset.h"
> -#include "sdma6/sdma6_4_2_2_offset.h"
> -#include "sdma7/sdma7_4_2_2_offset.h"
> -
>  #define GFX9_NUM_GFX_RINGS     1
>  #define GFX9_MEC_HPD_SIZE 4096
>  #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
> -- 
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C07cfe9dab7bd46ac251c08d7948b0471%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637141197161458107&amp;sdata=BQ%2BKOBUJ4TpYZTfDsen%2F5I3AN1VdGKbNRrTpJBdjOCI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
