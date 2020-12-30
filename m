Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDD9C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 10:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BA220759
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 10:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BA220759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7411989202;
	Wed, 30 Dec 2020 10:08:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2192C89202
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 10:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQVnq5tJrCjtsePVfNL3SoSIzY/jHk8Up679gC/hKKnphtsrsACl8pG5c9h5agH8m/9rFKiPO1FJxX3doEOH3eSRpVbf5ifmorGlRndKLBFJI8qDpX9TWJdkfIh0Hi0fyjGGY7bERY7MIkt5hk8hR8MrV63ZPMi0E7m2Nx+kaV4yDxTrHITbh5dOz49YVQBP3ukX/I3TNoHvLE+7/FxVX4cTbM4Xvu/RVjgEFOPpux8QbWirYFIzBcLNSsEOQ9V+piVarMBuO5Uc93xYS1F/vqidWGkeXWlNaKxqil38J8kCoYuzt/DyCVx9MuoP2QOupMLwZKN6tiVxWdCEzZmQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOxZtCd6DQIn887ZL+Wd+dpn765xER+Ovjy23ELNcVw=;
 b=RquidxbW4NWUyUk7IQVTIiKKUITKynbGECbfX/Nj8C8V8cyVwCOuD2YbxRlwAIXsD2Z5UKB6U3RSyCsBRcV4D9iFGprXOjtStOO6fgM6fFMudQsZpcD561oeHcprSYa0IlX2AKc6nG1gqWfojwWW05NzkTZz1sqQgNS8TSKQOco6wsaPn/FadL+gE3oIfT08mIGzi0Shj+h+UnLD9f4dEdIxPUs8SKMNnh3/rS0x1U3qv2u3gd+y6R8Rfbt/6nbfhr/cvhKqzlaZ7zwoW/5CHKaiIR9lSyL6RPk8IC1+6agG9eigMY5EH4n/j9Q4aQh5xfzA1gI48GoZhsCM/IxxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOxZtCd6DQIn887ZL+Wd+dpn765xER+Ovjy23ELNcVw=;
 b=JikD6vAiOvhWhNoCUEYZsjbQS/PIdYIYNR2HKYnMMVcIrgfoBaAvYczlgaxBhce8CxgNjm5XQ9x1TWlShuCYzjyWlA1B+bRZyS/ENMLtsYbGA+BK/DOxU7Mxtr+7Pyn0n4It/ZBGcklJpt68LiaKSPxAt+aJ4xOxSnZUsaEPcVg=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB4695.namprd12.prod.outlook.com (2603:10b6:a03:a4::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.29; Wed, 30 Dec
 2020 10:08:00 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::74ae:d6e0:a9c3:1e6c%8]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 10:07:59 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct releasing the same sdma fw repeatedly
Thread-Topic: [PATCH] drm/amdgpu: correct releasing the same sdma fw repeatedly
Thread-Index: AQHW3o1mPQr7tc2ejkKip3630S150aoPaJsAgAABabA=
Date: Wed, 30 Dec 2020 10:07:59 +0000
Message-ID: <BY5PR12MB48859930786809CCC6AFF5DEEAD70@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201230092253.3137-1-Jiansong.Chen@amd.com>
 <DM6PR12MB4075516C663A786B8BC04BF9FCD70@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075516C663A786B8BC04BF9FCD70@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-30T10:02:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3776f79f-fee7-43ab-8325-ee9aa6a105cd;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03a5d663-1f11-429a-888a-08d8acaac993
x-ms-traffictypediagnostic: BYAPR12MB4695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB46951FB760E60C6E2B2A8DC6EAD70@BYAPR12MB4695.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c0TVZ/VSs53HmDwb1WC1AZTenLP1iG3M1XFrGz1nSBcF5ADLIMEfrG7BvspospZCD+VOYLZlUghCPySyzowg45W9ptaIClu0i+Au5zi+nZcEEvos3bim5qpYm165WyMFLyzwESy5KbOR8KR74dPCzRmktv3+IRJd6msQILa38NEBPwUDxwxRR/O1HyHtaNi6ziaEODO2IeNyPRdaYkeQ9PmZi6yJKj3VRQpsYwzx+OABoLlPF82rnuD71kvFfoSnQD7wNwZLphPxrVff+pAeXmm89fxFtMymP1zciJeQHMn/N4GX//D0m4jJGgyM7mIkFw5uklp33tuIvooa+3+leFhc5Bu876nDx1vBP0PGJDhUD7RMkKNb30jCkRUi2575oxfTxgSGU2cxIpHfDi9aLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(66556008)(52536014)(66476007)(66946007)(186003)(66446008)(478600001)(76116006)(9686003)(55016002)(5660300002)(2906002)(7696005)(64756008)(71200400001)(8676002)(53546011)(86362001)(316002)(6506007)(4326008)(33656002)(8936002)(110136005)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4J+2UnKKcPSvm2+BFMvBpq9sxWxUqv9exwlxUo3QlPIbddaiB+Zx237WJdRg?=
 =?us-ascii?Q?Ol0NbAohoWYS1xQLMnAbW5dmjobXlpSaBUJQCizn5PmiY4GONSWfVSn7f7VY?=
 =?us-ascii?Q?EIcn+uZSzJQWCLjus5nDj12u9X+QaZBEncVJO1ZvWAf8bl+OpU4TEeP3kkMl?=
 =?us-ascii?Q?rl/J3WbfZRMhwwB0F/3/doGy/lwiStXioQ7mzK28ccX7k/jjejuJT8aa5keI?=
 =?us-ascii?Q?f/nYopBTBWGUwa8QerCUYfaaIJ0g0wZ9VDEUmuNVEG5QzhV8Vl7qESADcbQX?=
 =?us-ascii?Q?V182ay8ka856XhG2ESFwGOMZ5n70ShmDRYVyKO8mSI+sW0UWrvhImpsiYSMe?=
 =?us-ascii?Q?MXo0YRlQ8pTGSBJauarVlWEdz3q23fuNuGgz1o46rYn4Sy0mVbsNzw0kTZTy?=
 =?us-ascii?Q?ZhY/XYb1nMKfybQhc9EhOMWA6MgCbgxkZbVqTg0x09tZCwY1XNtnLpRYAPn2?=
 =?us-ascii?Q?2jtsPphTU1PdDnX7Ys/+FhIeP+V9E6FBUjEo8nxaHoPpmkomjFjX5HP79m+u?=
 =?us-ascii?Q?2/RmY56DcvduyboxJjuKfdMD18RMTDtYLS+wpbf2bSUJGbFJfyIUts8tjFaj?=
 =?us-ascii?Q?lCG3UP1c9O99+PObjB/lL25KWuHBO3YgBN2KBQu2CczarqfIjFLEbjPG9WG5?=
 =?us-ascii?Q?DoYItyKhgSvPyuVNBv0Je7xbtXQiJoqELH7EaHxjiRolCkfoQSchK6UnxKH3?=
 =?us-ascii?Q?z4M4ujhvDCkkVKBuPT9fHyKWk66MDQ3RpJ1VpzQ+m6aXWTTt1sd1HW59+CL6?=
 =?us-ascii?Q?HnTkg4ILMM30zxJ4RUCPVs91wHYVIVqJrRnK79YM0EPw3JAWHKDslbifUvXm?=
 =?us-ascii?Q?0pQX5HkEh64xUex4vhZtZeoOyiPcvcwqY81Tk7gXzxQ7N69mIkGyHxAeHlIs?=
 =?us-ascii?Q?vvGKkPESzI1dD4r2jIyKeqIAJb60L3CidSx3RRNqs5wu+N+a8uI09nYa67v5?=
 =?us-ascii?Q?VU8U87tQh1ly1fakiGYgADoRPCn/SEbxV5ap09AWBbc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a5d663-1f11-429a-888a-08d8acaac993
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 10:07:59.8445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjLWxGqyhYvsKWkMKfBNT66XAyTQHcQxWz4dVcYpAOGVCus20E/2A4lrpB4OTiGXWXf7CqWNfCuRz7UKnsGlCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4695
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ok, I will send another patch.

Regards,
Jiansong
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Wednesday, December 30, 2020 6:02 PM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct releasing the same sdma fw repeatedly

[AMD Public Use]

Shall we ignore this patch and wait for your latest fixes that remove the asic type check for sdma_v5_2.

I agree with you that should be more reasonable approach.

Regards,
Hawking

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Wednesday, December 30, 2020 17:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: correct releasing the same sdma fw repeatedly

Same as sienna_cichlid, dimgrey_cavefish and navy_flounder reuse sdma0 fw for other instances, so free it only once.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I9dda4a9b73e20243ee48f54d8f0c7593d7e7354b
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index f1ba36a094da..6ac314c8be32 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -125,7 +125,8 @@ static void sdma_v5_2_destroy_inst_ctx(struct amdgpu_device *adev)
 		release_firmware(adev->sdma.instance[i].fw);
 		adev->sdma.instance[i].fw = NULL;
 
-		if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+		    adev->asic_type <= CHIP_DIMGREY_CAVEFISH)
 			break;
 	}
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
