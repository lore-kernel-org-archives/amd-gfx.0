Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E7FC64E8A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 05:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9906320DD4
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 05:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9906320DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FF26E9A6;
	Wed,  2 Dec 2020 05:26:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FA96E9A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 05:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtHF9Yf+M9gFGALECmQtAKxFFbATjW2PbYvzyiwrCqNO3NzjArDrnLM3aNSM9fPFBE8g1aTM5WgMSBbfrbYGYGv5kRSBuyhDESD2MdYkFDzx8wa3q6OmZ9qmiM20DAp5cC4YzavbJHWlBseBBEo1FxrikGyJZrVkocHnXMJUnX5ybWuX7+Q1qplwi+JQxGgPQuSr2PEtml9ALCWYy3Kl7pCYIU1HtzZOzs3yQDA/97/6q9JWf57MYu3KK8b6qAhsY48aSMXQUPwCu9WReizvWETuu6eM2iHTEvqtsdtoTMU90vpBWyCzx9mjA6KlWef82EWFLNzertddiu/ZMDqWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcfb/CcXUVW6klo7HYrSbUuVTwfXCYblOmkFkVKxRAw=;
 b=g8kjsjoFF1NS6XIiikPRi7PkxtJQ0/GNwGQm4oUCAFCIvRQA/XD9DuAxj0g0KRFRWwPY8N6jSxrP/w4zLZz+KhyhpqRRb3oikBVFcTa1SntOg3iG2MvaUujcVRh3ltCTam3RM39TwodWPexEN/CNFFGHxO8LkE5YDzwMaAiVNOlhyV6uSLjbQGik7ZL0VHd34zGzjBmD1CQGm4h0bIsdsTEtZ0r4ra1CXYcj2bCteZwLATCWQahYx3OfwbcTil16Z2srHbSLJr8uLMW6RbZp0pmLaDUnjXgL3+6xVUeWKow7AkPaUXAv7B+i2kRiePNjvvq/UDFrsgwY28UYNYqiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcfb/CcXUVW6klo7HYrSbUuVTwfXCYblOmkFkVKxRAw=;
 b=xAUkLFJlJ5ODNc++bbsTSO2ADD01mG03fc7jNt5VdR5+Rt9x7fLds/Z8TaFdlaS23TmKUxOZ4eadw1orvoFNZDj0bQYhRNEOtvhJ4dr+0SsCwlu9QGUSefjL8y5MFQuJdZnOgmLMDTfF6RRZb/vJHXnMu0Pqj1Jcp2fBnOo14Lk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1181.namprd12.prod.outlook.com (2603:10b6:300:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 05:26:07 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 05:26:07 +0000
Date: Wed, 2 Dec 2020 13:26:09 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/swsmu: add metrics enums for voltage
Message-ID: <20201202052609.GA1084026@hr-amd>
References: <20201202030505.1310154-1-alexander.deucher@amd.com>
Content-Disposition: inline
In-Reply-To: <20201202030505.1310154-1-alexander.deucher@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0149.apcprd02.prod.outlook.com (2603:1096:202:16::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18 via Frontend Transport; Wed, 2 Dec 2020 05:26:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 583784e1-e279-4c05-32c7-08d89682c514
X-MS-TrafficTypeDiagnostic: MWHPR12MB1181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB11814381EEF2E88303CC61C2ECF30@MWHPR12MB1181.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/IjbDzDVQwOa7h3bVbcE3juZ4dYEOmsnbRgIjgA6M/TgAiv83cbPqr/TML6gN5J/s7H0yJ2TpIVRpnJ2RS9OOrPhpkQKqvQq6Y++e+CoL0b0lcL5E1aZT7Z0raXUtaLSIyd6x0Hy4irk/QCdsMCVDKx6VMUKilWGmrBJG1xh3zNM/QXzHwYGLcmiA7V4ehNiuHTWLwMZU3Y6S3M5aBZTk0LO/N2TXQ5GcGgGBrpSCivSL8dhr0ShBjNzyIZKGgRLZEartm8ugQhC7ntDDiWKWibDGTup+OAoLKDrXc7wMZAkKPzXjt+7JIZgXTrLIOAOECvgnn5/JN4GLmPaWoSq+bB4/75I+9a2PubNBEYXic=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(33656002)(45080400002)(86362001)(478600001)(66556008)(966005)(186003)(956004)(66476007)(5660300002)(26005)(1076003)(9686003)(55016002)(16526019)(8936002)(33716001)(52116002)(66946007)(6916009)(6496006)(2906002)(8676002)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Oq/hvSSr7xFWrJ5S4xikNxh7LUOGbxGkLeV0LIlOfFYMDxe7pNO1yk87olYZ?=
 =?us-ascii?Q?TzxJ6inZxw21nekiR89UBMQWxoP+qBWh/ti/LHYllwIY7W3/hW0VjuRCyK4e?=
 =?us-ascii?Q?LdB2SCSyRK5bRtQprmoNEdsBxU/ywn46A/kjqCWOY/9OvnWq7EQyv5+XW7su?=
 =?us-ascii?Q?dEUNxwAc52F2aMGYOKz5sP83ajJBXxPjpUneM/nWARwjV2iLG3nN+gPzeKQk?=
 =?us-ascii?Q?EBk5mIxtV1vpEfw5CewXYbhhwT9bcySrKl6mxGrAMYbwxtQBoUUm5T23z7U4?=
 =?us-ascii?Q?/8rvtB+OufOCybK0T9/nxcYChu1+NjazQuqcLQwo5CQmWHSsBL06frx0d1ln?=
 =?us-ascii?Q?+j5CtlmAp0T+xz9xf5VOdlQJGyvrIXg/13/pf2APx3M1YbxcwN4zoNbpcXQv?=
 =?us-ascii?Q?JFgUt61Fe14uxi25UXKCZDe5cANwjSmSfl+nVuruk5OsP+R/a64f0uCc+IYg?=
 =?us-ascii?Q?UHieXaJPkFaWjZeS16tTBN//FSm8ZrexSwOaMYkGpf+VW3FUPp2FV52Qaetd?=
 =?us-ascii?Q?V8Y5ErX9az31xUKQGv3I1OJIsNDluPpGQo4ROVPZbF0s/J3A/zcvQAwzxYWL?=
 =?us-ascii?Q?n4dNCYe/V29UhMYtU9KRmecYt5vHE5LCGFIUdVS1JgAZFJ2f0hf8dn/+AXg0?=
 =?us-ascii?Q?vqETV1ee8u0/tt09ZfaP5Ij7dYI2MF7SPpFlj3CP6Gl12DDcnSQwIGOKmXDg?=
 =?us-ascii?Q?sQGHgvXd/iz7Z3HsFp8JGD4yVIXk2be59SKFLEsP57t7srWhohb0HOuzByt4?=
 =?us-ascii?Q?8Vqicnd5lAD2/ANvAib3Ni1Hl3Gd40MuOJXqGCsUQJM+LsJ4uM2OvCiNNBxq?=
 =?us-ascii?Q?gcJAhhzpndmn8azB3qLS5aE+TSOUkMWt1wyfGKFenDHB9cAHiVszLKlSD3Bz?=
 =?us-ascii?Q?BYkHY7a8ZfRax22p1wyK87WjGtpAWHA5VKkoHj504DNmPMKnOBGR/JUa2L+8?=
 =?us-ascii?Q?zJDknsiYA1+LAqMLOMtGXLEU7cI8fy3rqRCxVJCNVh949q9cnKO2cb6l9eQJ?=
 =?us-ascii?Q?DCFn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583784e1-e279-4c05-32c7-08d89682c514
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 05:26:07.7081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLFONOnYLr2D6qnvOnlFWU6lp1NqdTF+MdqWDFVHmLCbfOg7AIJcHNIzkglOo0C6wE78OJTdxKzFd2vPoqmyFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1181
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

On Tue, Dec 01, 2020 at 10:05:02PM -0500, Alex Deucher wrote:
> To be used in subsequent patches.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index a559ea2204c1..89be49a43500 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -613,6 +613,8 @@ typedef enum {
>  	METRICS_TEMPERATURE_VRMEM,
>  	METRICS_THROTTLER_STATUS,
>  	METRICS_CURR_FANSPEED,
> +	METRICS_VOLTAGE_VDDSOC,
> +	METRICS_VOLTAGE_VDDGFX,
>  } MetricsMember_t;
>  
>  enum smu_cmn2asic_mapping_type {
> -- 
> 2.25.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cray.huang%40amd.com%7C18e90ecc80b2489d193508d8966f1923%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424751227498647%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=CA8vBrAWkqmnGdGYJEFIxGZuyg%2FYgYxJzkUJNG%2BSBKQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
