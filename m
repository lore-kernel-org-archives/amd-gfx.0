Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403ADC2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 09:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DC42074F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 09:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HEBEq9RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DC42074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F8F6E9DF;
	Wed,  8 Apr 2020 09:13:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69036E9DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 09:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e03Z36VccMHZjwmQszr8NRfknI8QaSpiuhR8vQCr7gaSAisd578dIkGfNaqTz+xoOEo7aSjqFeDXWqrIDL8W1sp1eMrI5astctO7/mQquUUIr5SzUCpksMM2imDB6JsmUmTZngqyB9vIz2XRLgmAwenby/Ek12Z4fyrXYjMnhydjafDW1dDdNK8coO0qvnGl9eIaDmIzD+CCQ+F+cd6y6mGeBhbefC3X5PEk30S3l5Io3L6MjqsCULp3HiFkxTOnHx8EVP4QOL9feuVhnYk/TGvkxYka54wCTDY7EbPzBn2E24208u3Ww6CyaG4RT6NY2EoqZ3/xjlsqmt7cHdX/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNoXUzkfC9hjEq90oLU9oI5bFfqYyHYJN3T9FgVY5aI=;
 b=j2q5OmlolGurFqyd4VOkwwYwzcCT9IhzEgLwdrN1bU75syDYuE4lccghF5eDLAyGwEKtAPGmewgj9pWrmv5nefpAcWdjWkl1q3JB/dLj8V97N8UU2e8sNdtN89DAJ71F+yq2XeAZUbjRHIs/ipjvxl1gasdZhlsdWBXPkhJqfULFqZSTukF69ndb9+HIzz+8Y45VA20JZpghSUvHk21NFmJOcVb9ozRK1LTYzZ9t0l0mxEcpRy/zjPpIME2JT+w2O0uMJiDgfm/9qVoROaXMiz0zx2uwpt3ljiRYoituZb/SRjxzFrNq5uz/qzhfFCBx3XLX6AzS4jJ3BUSUTomASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNoXUzkfC9hjEq90oLU9oI5bFfqYyHYJN3T9FgVY5aI=;
 b=HEBEq9RDnqYqHteqiRTeYms45K8ei7hyWyuz45cArm7qRnmvHny6ZXi7c9vA6EPwlOGlayNkNLry/2gZz1tm9+WSoECYAXvFLBB9qZ+cnEBoW0NRwSNX1VR1RymbJo89T36tjHI79eTRbKBXdkpVVb80YA2Q7kcZkpX9yuv9e60=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Wed, 8 Apr
 2020 09:12:59 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 09:12:59 +0000
Date: Wed, 8 Apr 2020 17:12:50 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: unify fw_write_wait for new gfx9 asics
Message-ID: <20200408091249.GA31327@jenkins-Celadon-RN>
References: <20200408064548.857-1-aaron.liu@amd.com>
Content-Disposition: inline
In-Reply-To: <20200408064548.857-1-aaron.liu@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Wed, 8 Apr 2020 09:12:57 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c090721-7055-4a21-5e66-08d7db9d0810
X-MS-TrafficTypeDiagnostic: MN2PR12MB4190:|MN2PR12MB4190:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41906700CFD3A0571B134F5EECC00@MN2PR12MB4190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(5660300002)(2906002)(26005)(16526019)(186003)(86362001)(316002)(81166007)(33656002)(6636002)(55016002)(66946007)(478600001)(956004)(6862004)(6666004)(8676002)(1076003)(52116002)(66476007)(4326008)(54906003)(66556008)(9686003)(33716001)(81156014)(6496006)(4744005)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXOueMTQ3JVvvloU5Ud3jlEQmWhcE3o/EALtbcQTbTH2DLqmAN8FiZ7K4HK+nNXJYlG0DiZeJVcxFO4RGWEx9wiwkdyrGhOCWVW4xl8PzObTrMhBud6A0Qg3pjG9tB7/ne/q+CrUIIcqwdq0WK8EcS4kmBRJ5QnYR4KDm+cyJtl80FHJ1ECWm6vrtjVnz2OAvGTPtLqSxgrsQ35bljv4t/StFH6V4hfDrnWKRQX78TCMjr4F+fVeumpaNycrVqbuqJHcMueyFEjxEjLHmj2TwxAUphB/vm2HiY1MREvBEoaXF8zXvAuDWLKNdbxa8uPkBTEP51COqthk3O0WGCnumyPO6llfRk55BNd++3Xy5lLXGEn1Df+vHB3OMP6lQYxmGL71an+2ksIqYw1CUG9GkRI1m2eUjnsKDouS2/UfImjQlnbRVWq5OzUthe84VerY
X-MS-Exchange-AntiSpam-MessageData: 7JNRtBynH04MYeVyOfmcC0B/PX+qHBn9425kdc1inGh/Ef0j241WXxA0xg2DVYZ4Y3/msNdQh8wt3d9iaNQ8Q17+WL2LAi2FonjujrILxKp6eSqQ6Hh/InM2i8DHxRVI4yQpQO9Z4JonAb7G4geghg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c090721-7055-4a21-5e66-08d7db9d0810
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 09:12:58.9882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xN33DFTWz3v5BgKoybLn+bfWk++ZySUb5Tjtmt+qGx/AdBDeWYNUrgcj3rsGVgSleUXsZyLsxGeyCgFBbq5/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Dai,
 Yuxian \(David\)" <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 08, 2020 at 02:45:48PM +0800, Liu, Aaron wrote:
> Make the fw_write_wait default case true since presumably all new
> gfx9 asics will have updated firmware. That is using unique WAIT_REG_MEM
> packet with opration=1.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---

Acked-by: Huang Rui <ray.huang@amd.com>

>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2d56b06722bc..1d18447129b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1214,6 +1214,8 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
>  			adev->gfx.mec_fw_write_wait = true;
>  		break;
>  	default:
> +		adev->gfx.me_fw_write_wait = true;
> +		adev->gfx.mec_fw_write_wait = true;
>  		break;
>  	}
>  }
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
