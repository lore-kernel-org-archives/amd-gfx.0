Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1750FC3F2D7
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE3221D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MOiuD/CQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE3221D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B55A6E5D3;
	Mon,  2 Mar 2020 16:48:06 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750043.outbound.protection.outlook.com [40.107.75.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4855F6E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoyLQFI7qUhLLED0dQUSEr9knc3aTLaRGooqVJ5tUHUhOXka3Cl1db2uzZ5ntKGkOoGCkHG1rQCM/LL/Lr7P6q1oKLoaGQNjZbMEL1LOmjqd4CdvWNehMiNZCCscRFoyd72WdaAx+yGyIeVVxoqXRjNM0UP/tgCgfGiW/zfULgnRaDSj4JAIQbzqpf2ommgrDvYnAXahtT/l5qysm6ylqcCyFSf2XfeRdSXmlIkBXt5RIyYoIAZGsQU7owRC5trq29kmd22iU5YYPqTqHc36xpiTxzUpTGJZmQp2pSRFxhmQC3nf9Wsns2Nd6zWQ5nepofe50+Cqnt/9+ZNlwTnn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V98WPUsQ2InYztd9WOSX8LyDdzJYqmXUbyL+2vpI9BE=;
 b=DTTRj7268uCY81NnHB0vecgepQR44a9jdY3J+qHJVps2SKpYTAhRcNSX3HOc0t0vysCTLGoATrvIWcoEPEp4KxstjzcmqPq/IM5wpXxHaOTrI7hBMecgmzXnSrDXmz5mMIKMc5sQ5JuyvRJ++cCU9iwWvn7TQt5cu7gNBv56KsTvw85nvqG1FJ0FgnRu6fHh4qC05YKhGH9G/+L/OaXUgcvJolUKRryNw6Qi6zsxKsHxAjqNwli4oxNq0qAKAFJdqAe0g6R2jFU9coLSaV4mKy2H42f14TDnLCSKLrAP/5yltQedDcIvJyaBw/F8JHUPvmBXBCCwuPLQ7F2utMy9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V98WPUsQ2InYztd9WOSX8LyDdzJYqmXUbyL+2vpI9BE=;
 b=MOiuD/CQ/YOxZG3ZbKy4N1LGIKmEBkvriRF8wTYz62kKSGnMW2I4FwMftMxxeyxaziv3jQ9sWwGku1emUfoZxWIcRIzobbZZgiT6leFVguXWd9T5sa00oSLkgZckhwv7MS0xg14rBwEEV39VItcnjSktaJsDN32ac1cvZL9u7Q4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:48:02 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:02 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/22] drm/amd/display: Disable freesync borderless on Renoir
Date: Mon,  2 Mar 2020 11:47:27 -0500
Message-Id: <20200302164736.89429-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:01 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e5a4260-b5d3-43a8-6895-08d7bec978d3
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB241152D82C2E17C2E914E69C98E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRW6wuF90a7MX3yv4eGjrvOWO/Yot2TArfvtaXT7qkRv1+jSkZqi4PWbotkgl11rLBgRyKmLSYMguH4BY7vKTJUWU+f7RryJxw58Mnv/gJW/fhSzxO+s0GFd60LW9jO3jJml3A+e0ZGmLvnqpFhdlE9KBpi5O/5ctkXaeYNSx2KjnG6DiyrknpHo8iWhiku/ivDXbaB1smq/Ii7wUIqSz8eG0aXijISedt9cJ9p5bvc9svM5GyY1C+BB1rd/GKKVuRsyCE9DXeeoUWRev0O2jG6xRRxDZm76XJ4BUGWhPznucBHZu4AxEIJWW1CRx1dt9Jyn1mQZZEKtqdEJUu4irw1MZJHZtg56Zxn5uga0GDg9Pmh5MWnFsBImGqBOxgulM5wUQIjEIpHw1quoQ9AGFuKmzT/7sSLR1FUqolCI6FfdBHUdWjI3aSG6ZsbvLzwF
X-MS-Exchange-AntiSpam-MessageData: ogPuChI+Hza4V25qJoH3ek43zfwfGlocum/xqTQ7eSjqXXa33wxFdefqmbs0FNv22Qiv1jvcStc0F92/5gUmP2QvSzL78jJmEFeMnUG2hXRvOaZUPX33f+Kg82tPzdog1uM8diWqmfCJHbfzTmOHyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5a4260-b5d3-43a8-6895-08d7bec978d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:02.5226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZA19iVmgr2Nmq6hpGuT9WRuRN/ypDXR9ON+EiMqYRUPXW+T+ObVHkI9MCTKmt+Sfw4GY0OzANMBXiCeT4UFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>,
 Michael Strauss <michael.strauss@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Freesync borderless is not meant to be enabled on any APUs

[HOW]
Add is_apu cap to dcn21_resource_construct for correct recognition

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index cae3f49416b5..c87eb7b9c060 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1799,6 +1799,7 @@ static bool dcn21_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
+	dc->caps.is_apu = true;
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
