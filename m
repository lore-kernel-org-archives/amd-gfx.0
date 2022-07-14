Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C162C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 02:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCB19B4D4;
	Thu, 14 Jul 2022 02:51:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D399AAD2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 02:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcSHQ2iiDjyaETsJb5s5RUM1d20e8kA6/Uhn2MEw63ihYYFbFByqIrXMwS1HpQaFIV5kpM0YsLi4jdAyervqVqvzE2D8WuOndtr2bab8QwntVGeXrPsJ73tjPYShhP8PoK3gd63+gQjF+bxlv7y2SQUSMrkZFSLJ/N2OptMgbio8CUyg5EUKkZmUm8+HtX5Zp9yHbLX42Q34bGDkbyyezeSVH33zWrUWdw350Ud0gX9xSFFalynDpHH4KSW3TY4T0ygQL2wCqUYX8u0x6LiMDdMEo0UwoMJk6oXtXagBPj1dOUIJeQnI4nSdljpR8xUpRWdsZusOIysUQ83Kh8P9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDAc5NNYZGx2jj7jWYwN1SIDJdvbZaDGgjwRxBpxfjw=;
 b=Tskzy7SDKjZD/8cUWpcwggRoT2E/6TghRxTV2U7hi4cf3bmTCJQv4d4UBiR3Y0npo5xSzRtiWcdS7qovbCL2pKYi5MQGq/y+coxybH+EFP/Ykc2EIYS2xiInTskPs/6BNNYvqhcKCApBTq2fDVMLNIfLy3NsnV0hqoax9lBhbhFA991PBgZvFl56zKQhWuJJsImoGwIFnvUFx9/xYfycJ7Cz9nv3hykabE19PWSiHDtsq3qlxp+iBmh3c27R3DBX40wHa295gKK/g6INQBdJGWPI1D8RYmrkdjxY7DgVfMRsrtROJSY5hBpbgdtoUaMm4FaBLVhhNHlz/JwpW/yERg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDAc5NNYZGx2jj7jWYwN1SIDJdvbZaDGgjwRxBpxfjw=;
 b=S38LVt/PvQb46BGpNU8uwAZa2Rkx324jjSqwg9TXVtIRdhlaM7BkvNkieYOAKc3JWzQNXjecOJXgi2GbUyhJ/pFF0FS75OOuGL4O7QgR3RohS5THgRqAc1ZJN8VB8XOi23e8YvV84NE3NbTVcrQmK9g8iXvxLuc1lIf5QnQ5pcs=
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 02:51:05 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::20) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Thu, 14 Jul 2022 02:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 02:51:05 +0000
Received: from [10.65.149.18] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 21:51:03 -0500
Message-ID: <1b7b25b7-d51f-bece-e5f8-00830a770614@amd.com>
Date: Thu, 14 Jul 2022 10:50:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH] drm/amdgpu: Call trace info was found in dmesg when
 loading amdgpu
To: lin cao <lin.cao@amd.com>, <amd-gfx@lists.freedesktop.org>
References: <20220714023111.46015-1-lin.cao@amd.com>
From: JingWen Chen <jingwech@amd.com>
In-Reply-To: <20220714023111.46015-1-lin.cao@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddbc5403-1813-4605-828a-08da6543b24e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5118:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpxDQIe88AEUNiPOsHphqEvp9PN/tTkCeeA7xeI4VCqO05QwnDuIKKuqNifFmnlJSjonDHrOHxpx9k7EQEIYYBiZW88RyOAmck20IrWslyCiwNUNEDF8/SiR+Q+7FlHh5d5LRj+FEPY7KnoTAfULycIaQusIeBhu3WTD0d/GGeMf0mzltxauJsrfLrosAQo7aGhKLwVt/yq5hyuB/dcqRK55xSeKlHhU5wibxIjpTS78FREv7CDRvtuukVBapB0jcEOPeM5srFXHsSuh5aiCyJeWFfLpM/6KGtjbUS/REFnJI9xb7tiT1SagPEXK339i4TBdgRUwhgfPm1iybsMDLVjUHBWB1h9uD6H+jDOL8K+Yo9ipykbcEUNz5hj3It2RIfAnZwmAg1PpIq42TyAhE2ic2DfeAXc4bKx2+BRF6iLH/NK0bPS6t6bsYnWb6UtuicHgpm3/xvA0uuxOjjPI5PltKdhl6gOYTQqPBnIVX2xRvG42zsOT57aPu4ZvPkE4qSiwgoWta6UTZR2TQ7czr/cK8rLUW5+5VV+zcVlzTGoeSDSntR7EadeEKbaYsk1eNOh9CrS6kOiTPV/nKWjYqAMtYIGGPVd4ylzdBbU5GMNqgK4Lb6Ky5sANWQCv8qVdII81sMMqMew0LQZx/pc2XryHHnyl2vHPJpm89QKvxnmFhHkujS8FcF7O9knJOjfNqtIyzJZ6dRCmW8v1/mGzhAWuAKzv/SVUZP/5LOoDGcKJfsyk3Hb+D2og36K37xW4nzZShAklD88b0FFf7hJJ0XLtgbVAFZZgMDYJF1/qdaOSgRMVy/TR+LcYIApj1UXyL1MHngnms79BEj4rhi2nbu2gj8OBoCPmEp2qBPWsO9XZXVYgWoPyN60LXYGBoiEy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(40470700004)(36840700001)(26005)(478600001)(40480700001)(2906002)(41300700001)(40460700003)(426003)(6666004)(83380400001)(53546011)(47076005)(186003)(5660300002)(8936002)(2616005)(36756003)(82310400005)(16526019)(316002)(16576012)(81166007)(336012)(110136005)(31686004)(356005)(82740400003)(70586007)(70206006)(31696002)(8676002)(36860700001)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 02:51:05.3175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbc5403-1813-4605-828a-08da6543b24e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

feel free to add

Reviewed-by: Jingwen Chen <Jingwen.Chen2@amd.com>

On 7/14/22 10:31 AM, lin cao wrote:
> In the case of SRIOV, the register smnMp1_PMI_3_FIFO will get an invalid
> value which will cause the "shift out of bound". In Ubuntu22.04, this
> issue will be checked an related call trace will be reported in dmesg.
>
> Signed-off-by: lin cao <lin.cao@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b71860e5324a..fa520d79ef67 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -886,6 +886,7 @@ static void sienna_cichlid_stb_init(struct smu_context *smu);
>  
>  static int sienna_cichlid_init_smc_tables(struct smu_context *smu)
>  {
> +	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  
>  	ret = sienna_cichlid_tables_init(smu);
> @@ -896,7 +897,8 @@ static int sienna_cichlid_init_smc_tables(struct smu_context *smu)
>  	if (ret)
>  		return ret;
>  
> -	sienna_cichlid_stb_init(smu);
> +	if (!amdgpu_sriov_vf(adev))
> +		sienna_cichlid_stb_init(smu);
>  
>  	return smu_v11_0_init_smc_tables(smu);
>  }
