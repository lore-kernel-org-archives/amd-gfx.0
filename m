Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5803C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 18:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3389F2072E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 18:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sbUBvisQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3389F2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE40C6E0C4;
	Mon, 30 Mar 2020 18:06:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2BD6E0C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 18:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irxbcsj2OS717U044lJFpL+SD2LJjdkikWoGwqSHFC1vZqUqidTfP/Kx7GOW1Jxr4Y/oSfxob1YLOsl1CTLjU/6o7iKfYJulwFtn31p12YrKlk8TdMROzvjMEbASdI6Jmi51jdQrsBZqtfIJOOj8qEM6JVKmjuf3TQRkLswQZfEsPoZgdIj61pHEhXruVTT1su8/taqB3OUtcBshx1IaFXPAKAJArodC7QpE5dQ3UWCYZIxpM9SFDMLvxAJcP9+Gt01q4PLkyTwjN3Isx6Q5kiKhROoJGr0O0ZxH7oOwEKxjzBMaC3xelOs+LfGxjWGDto9TMIKvojMwfOKijPjjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQS8MxBerv87/KH7u2+pmAc4F5XDRDwmVMnejAr/JkY=;
 b=e9f2gGsiSx6DRmf5plbDepq91yjAbLvijzTMGy2fo6z0dWWZbVJOjpDdWHZAyqA+rIzRJ3I5sxpVS4G7tz6Qec5ar9LMVnsfvmHw/3Qn2t1nGzK8vcSeY+oTMwupDQb+uV3h6KAsA++vHv+PC+YdW1lVvGhjqWsUJtfguW92JYxjT4z/ZuQ6jx2GYERoUdWWY0xgXRl0G6PlxzYlByqiqMdrXTVD+aJM4vmnOF05ogOIN8/2Jyw+wKAeL25AVOZigdwrBydckpLXt3K0b1AsA5/HegQvEaFTAz5mHQeOk7wxd2UiEHCKkJ2CxPbx7y0lGLXpTFeisoPWft9Flj9UWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQS8MxBerv87/KH7u2+pmAc4F5XDRDwmVMnejAr/JkY=;
 b=sbUBvisQECF2r1HxrADuEghZcwztWpcgp2Qhx6+uqDFjyyfdMa/MWuMd+UvTkUpCu56jZOA3iTxfJ0ixTNfuZGVmqlz908VfhUEACBkGbiDO62LggN9GK+Rd4Fga57+kTh4CLymdWuFnrhjyBrcvwsR4EDHuIFcEKnlpjKheNKI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3237.namprd12.prod.outlook.com (2603:10b6:a03:13a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 18:06:39 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d%5]) with mapi id 15.20.2835.023; Mon, 30 Mar 2020
 18:06:39 +0000
Subject: Re: [PATCH 3/3] drm/amd/display: increase HDCP authentication delay
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
References: <20200330180025.21433-1-Bhawanpreet.Lakha@amd.com>
 <20200330180025.21433-3-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <4f699a2b-36ee-f6d9-dc1f-b8d23d3fedb1@amd.com>
Date: Mon, 30 Mar 2020 14:06:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200330180025.21433-3-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 18:06:38 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ad287da-10bc-4d62-3f81-08d7d4d5182a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3237:|BYAPR12MB3237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3237F71BE5D457AAD9AA4ED0ECCB0@BYAPR12MB3237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(26005)(5660300002)(16526019)(186003)(31686004)(8936002)(81166006)(8676002)(81156014)(2906002)(36756003)(478600001)(31696002)(86362001)(6486002)(4326008)(53546011)(956004)(16576012)(316002)(66556008)(66946007)(2616005)(52116002)(66476007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwgrZadZNsc7wZpAXNug6T81JC24nMQw5BrZoZl2rITgrhNenGcRBFVA5BAbiRsfSWnQw70Kumn0FCcatKX73nOIlf8rtnfGvypDmFN4qMIs4UZOUDmXfjCLi1RJ6IC5lRPQaQMSJVjldXoHwADvGJn30gTjrZC3k3R8SIjn9j1bw3HDsw9XUctWBJ4+CX0uq8TJ9FclSeBlYgLTjcwVQRPt1h7+FL4cP8FsejWeCpOPS5C1HwBY0Pn0/gRQI5pSez7UQ3fkns7NyS6aL305E/0+k6iGNBy6eC1cWak4SeU8dTjoBwr1TRTsTSaOWq/dG7XhCkDATOq5xE8sq+BFhmDSgWsT04VletTQ1XvSMycGI1mOztYUG6mpepU6HevfrKyUfMa0iXPzoEmS8O8McG4HDYuHTl4wkBgPrS5N0QY8G16qaT5xkzanwuyV27Uu
X-MS-Exchange-AntiSpam-MessageData: 8ZDbgHD8Jyrq+I01xks7rPSST5TGl9PQZXcbYQ2N8UUGbC3AIfZldvT4v4Fp4M5cGCQU1FGv2TamFBSh+vCoHPHD456QkSnU5Iju5rbYkBIezyK1Qe9B/cTwqaID9Gqw0NsAbJ2fpsUTa+ExIbETKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad287da-10bc-4d62-3f81-08d7d4d5182a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 18:06:39.6897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43ww2MGpE6pB6aQwlDnvu9VMev15DLd27FGDBA+A1C/0nhmbgtqojwVMrJFVpzlIcY1nfa78yeY4t3rLyYCEfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3237
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
Cc: harry.wentland@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-30 2:00 p.m., Bhawanpreet Lakha wrote:
> [Why]
> Some displays have an issue where the hdcp chips are initialized after the
> display has already lit up. This means we can sometimes authentication too early
> and cause authentication failures.
> 
> This happens when HDCP is enabled and the display is power cycled. Normally we
> will authenticate 2 seconds after the display is lit, but some displays need a
> bit more time.
> 
> [How]
> Increase delay to 3 second before we start authentication.
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Series is:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 39804d2df9df..78e1c11d4ae5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -419,7 +419,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>   	link->dp.rev = aconnector->dc_link->dpcd_caps.dpcd_rev.raw;
>   	link->dp.mst_supported = config->mst_supported;
>   	display->adjust.disable = 1;
> -	link->adjust.auth_delay = 2;
> +	link->adjust.auth_delay = 3;
>   	link->adjust.hdcp1.disable = 0;
>   
>   	hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
