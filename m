Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4022C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7B52080A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 20:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AtyhstI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7B52080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7871689F33;
	Mon, 28 Sep 2020 20:50:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290AC89F33
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 20:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca9NDIOzoe6hMLwQLEO/Uf2NzRxVHUfV6tDHKWL5k6XpNlC+a/x2sIfZuHMjzO7T9lxqM1Z+e6cAPB6aKFlblSoAMiaDJy+TVgBIP5JgAd4U4238tB3A+jp1awvhtpF7aLmef+H+l/cpfAWJlPFliWnWr7EIqpoxf+wAc98KU9Dpdu00b7ZwHIQmm4bGRAldu7ci1IB4TYdtEsI608l8DEr/h0t9E4V1jALYTpNi6TgH+VqUgGGh4pJ1c8tp+LsLoOgKAVcyPyi0LQXiIo3Au4Kh0gU6NviI9/Dvt9VFfDGsubFiaJK74mw5dKrBU9uO8tx3sfwsOzIlFYtSSTQxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31vrcaaP5XLe+kqjUPGc6vkO71HNWQ9U702Z+ZtFtMg=;
 b=Acz8VRkZ53uUROialV/sLFC5jUUjVs0ij+iIrNT1FmWGTdVRjet1No36PMQ9+HwsvP8plaQ4P/aoamp+T90bRTECFH5TAZgKMSVrdU7t1S3W/m91ocNTj25rebiw7q+m98+uGodYr+/Dai3IZTvl1dmyYyO26lvwHE0ioFbg6uYithBO7lsuXCgnCkhm5HSq4nNqgGcThACXjUGhUOs/M6rnSd3eUNuSv0nLj0cEZY4BXoxIP/P4eQSAsyIaDGRsebPlyFHB/S5cB6FqCNQIozvbuhxZ2kanoEp5+eDCvFnCZ9mS/UOOYqdIrbnM6FaWLG4SztAOg3DKaomAzCWE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31vrcaaP5XLe+kqjUPGc6vkO71HNWQ9U702Z+ZtFtMg=;
 b=AtyhstI8q7R1D7tz6B4XaJ0gr05T8Qemu8kbqB2pq9PkcxSqrKR+QAXMOe2bgB3zANhE7we08zxNjmlO2fEFCOtWXZxlSvUkL+SVVf6kjVlrMlYId22xdahBbOBs5YsXHoBn4kvVix6vHwYYYIwa5UuhyTY7iIKPDx7S6oVZgGQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 20:50:09 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 20:50:09 +0000
Subject: Re: [PATCH 06/45] drm/amdgpu: add nv common ip block support for van
 gogh
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-6-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <f99715a6-ddec-b9c1-8cfa-c44a55e1e609@amd.com>
Date: Mon, 28 Sep 2020 16:50:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925201029.1738724-6-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::26) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.23 via Frontend Transport; Mon, 28 Sep 2020 20:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8709f666-4806-4efc-20b3-08d863f01631
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30811D38D30154AC3BED514999350@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c84aMd+F0D4Olz8hkCh7rKv9F3b/Bw0h5Ti2V9DP0d8a4DExihIRZGbZ3Qn2Tmo0MlyEpjC5+ZUi1KgEff0YqCds7PgXOPXTLEmZvZSyQ46bvJ7HThpnDg5RllfgWRUXgTlwsCTKdfXs4f6hdQk2bzr2KMVUHXrW8g7tHKGndJxJ/cajFJRstu7O6iD2uQbgmzj+/gf+NOSDPLMCswAHtmJ4NQ0ERVZGBbsf70CUjQ9z/66yaCQk1e8Zvag3tiR0mzyaKt/kTuEMGxuEWrx/oAJ6dcyMYZSrCIlq7NHKgN8dE7m8DJV4NmzDrpVI7fHqTnCEqWo+/hQSgJkK55IQ36Ve2LXOEM1rL5cXYpa/MOpLYKp+SuJUqlcfthGCQT0/6HKlWo9ncywGcQQhkdHq4nZDqqe1RA7SySzhqkWvc8Zl4vPahvKuOAyFeMLArR/Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(52116002)(53546011)(2906002)(6506007)(16526019)(956004)(2616005)(186003)(66556008)(8936002)(26005)(31686004)(86362001)(83380400001)(54906003)(44832011)(66946007)(36756003)(8676002)(316002)(4326008)(5660300002)(6486002)(66476007)(6512007)(31696002)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cO9Pf1Ln45HL0lRKpRvTqIj4P8yjgTX6vZSVelBTuj42/osIT7DipMhS0Uy5IyeDUQlQd3QnFJccdXLysCmXqkcEZq+3l4gRLhd1u7WF3QO8x11juPRhzAGtx47bpkFPPsYrJjP6eOp8Ro58EkG9UkecOjy2fQla9K7CkoZXQwdfCezrEbUh7UPNbNhbKdamnS45iQsQqi945f8kfTvKWZRtdSXyNMn4moGiVvbrofRuj70AE+kaCCFfdicBcn7xg2dTFtSY5Ot/ogAZkTrSGxFaeXgDmtbwFBHDTjOTc1Q99U0STR21lHpGMTMTil56H9Dw2T0clk5W1Ix/xehnIBNU42nSFSDby2E/pZYqlnqc+AGwCQwkW2EEXoUdpYAbgvJBJRrPU03TyGBhq7XOyq2ODJ5zYD/zqVo4X5uTcUFcpJ28NC1s9Vb85I8CTqwiOOyYzWIVh13Wr6doSSyUoVXdO4f3JFN0F0J7PKwT9JYTJB90az8z1Rs9oVcEVvqbE9Dbs4Gjg6OK4pD0G4Ar6Qj+4OTpOMDwT9BvUNfUJ+JIpEvpN/c6ptYsitT4CTopXjSK77YkE0rX+VHaHgd0jUingmRjwMGJ8c2NqLLewwR8xCDSumO+9TyFPRwrfowT+aIprta1Q7r+5k0pPhnfPw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8709f666-4806-4efc-20b3-08d863f01631
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 20:50:09.5120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhLu1txH2BIMJv+dETZNsV7X3p0qWAAu7KacpDu3td/mzezjmpJ7SSDr/u9Qfnf4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-25 4:09 p.m., Alex Deucher wrote:
> From: Huang Rui <ray.huang@amd.com>
> 
> This patch adds common ip support for van gogh.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index bc894cfba60c..2077f897d6eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -478,6 +478,9 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
>  	case CHIP_NAVY_FLOUNDER:
>  		sienna_cichlid_reg_base_init(adev);
>  		break;
> +	case CHIP_VANGOGH:
> +		vangogh_reg_base_init(adev);
> +		break;

That's gonna throw a warning when compiled, since you're not
collecting the return value. As per my email to the previous
patch in this sequence, define this function as "void".

Regards,
Luben

>  	default:
>  		return -EINVAL;
>  	}
> @@ -858,6 +861,11 @@ static int nv_common_early_init(void *handle)
>  		adev->external_rev_id = adev->rev_id + 0x32;
>  		break;
>  
> +	case CHIP_VANGOGH:
> +		adev->cg_flags = 0;
> +		adev->pg_flags = 0;
> +		adev->external_rev_id = adev->rev_id + 0x01;
> +		break;
>  	default:
>  		/* FIXME: not supported yet */
>  		return -EINVAL;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
