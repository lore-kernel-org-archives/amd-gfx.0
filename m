Return-Path: <SRS0=8Nbv=34=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B60C35254
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2020 15:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E4121775
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Feb 2020 15:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fmwq5Cbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E4121775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20C16E364;
	Sat,  8 Feb 2020 15:54:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C066E364
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Feb 2020 15:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EILjznz3rinOdEZq9JUJt4mI0dqyBbpTvYLZlzfMZBRo2e23vRx9TqoP+z7OLULUklhOtNAhgkbv3jgjwYAk6DW4tnW0MjZP7fmiSrQrdnmTMgw3/NlmEMeNya1AAcxJg25JO0flGwHWwp40uTL9CDHCb+YgMEE/CTKn7MyKqS/TpUYFnh6TkLUnZ7dg8yKpsUrYIjj9Yp5j3lHW9aBGRB0o27/cf14W9LVkGFq5hvDCqSncYBT34ruUpmm2OSRWpIvDqv+PugMZJ4FBzhSdna+H8guRh99xgrUGUhSlWUjj3xVwrf1SMWgePNAvMjwI2z+EB1JhNX8EOs3gpZ8+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHjxXdcLlyOLkc/asHOcBNys/Vvlh+M/6th2RVOZ9vI=;
 b=jJebcuqGyfPTDTlsJSzcmOR8aQ2KWcItEUL8QpE+NtY8oVmkXFYdsYPRh9cRbueO3AohkMyoXlVLlPKEBx6MlyX4mSHiXsObz/TdY5ZQ9Dnen1iihZR/O1F8yHyH2LB5X8wpkjYh6GE/JjGTZX4J8qD4bezmAcMAIvvE6ECHoy+egQili7sbcrTbn3ca7BF03XBNIfqQ7c6Lhl+JvDji6sMId5f9icciqUnPRrWrmUTrXWy8u9BgYZI6CIPRA3+PLi/O83Ragu0oNeBR42u/cjDwylde9uD+Cyup984Dx39vZlgaXF5L8fvPS7pifry2gzxTRNJV9S2qxEY2MkRaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHjxXdcLlyOLkc/asHOcBNys/Vvlh+M/6th2RVOZ9vI=;
 b=fmwq5CbluFADCaKdtdWodSkxktfGtMrSZ0MBBk9M/TULRdesmS1NWvGLw/RUXWxiRjH/juYOXI1HuCmvwFZ8ApqsRw8UdRNEMrJGrSIzvey/mdGX8paFwQG3CLWAXCaiKoNq9hQLDqgfYYR076kSDTBbgr7v/jhT8td4A4yt28A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1593.namprd12.prod.outlook.com (10.172.40.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Sat, 8 Feb 2020 15:54:45 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2707.027; Sat, 8 Feb 2020
 15:54:44 +0000
Subject: Re: [PATCH] drm/amdgpu: skip update root page table
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <SN6PR12MB2800F8DC45A5824E5AE9DBA4871F0@SN6PR12MB2800.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cbb4f8bc-b580-dff1-3f0a-49e9d8f31d9c@amd.com>
Date: Sat, 8 Feb 2020 16:54:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <SN6PR12MB2800F8DC45A5824E5AE9DBA4871F0@SN6PR12MB2800.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Sat, 8 Feb 2020 15:54:43 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f85f6c37-5397-4f02-a16c-08d7acaf375a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1593:|DM5PR12MB1593:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15938DB89362BDC6F5423FE1831F0@DM5PR12MB1593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(2616005)(52116002)(15650500001)(6666004)(8936002)(8676002)(186003)(16526019)(81156014)(81166006)(36756003)(31686004)(6486002)(2906002)(5660300002)(86362001)(478600001)(4326008)(316002)(66946007)(66476007)(110136005)(66556008)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1593;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWmauayNFJErjbAWXumlWitLD5Vtt/3VV5e2Wq7uPTJy95lRYxCsJ5sMRkiGRZIvpduC8LewyBfE1CV5gKRKmnEbl3UokWqqL0bijkqqI5qg5ONA3KpmAi6Mrww4S23FWUISuWTOj1kStV7I0WDI65fBW1lT3t1UGsZ/0qgNDwY1Ts+WXHu/xEGB5NXlH3sqvCjo9mZIgAxTylGGbCsidrhJiwcBW10DtfYE4pW6DBnB4AW92ep7XndyR0FGtq0qiC/Efk4KjhExChWaWU1E3CYho6rHwqS5wO2F7pRdejcEcETFw/Mq+qxhj1jXJCwKrgjtvSOjXHkUqu0Doh4FVPHt5dYqgJ0Wn0On6PQGk6lEg80terDT2Z2N6BUB7YdBXf3Hzohs1qcmAmPVmTbLIv0LNAtGZH5VLXZiJQjwZDPRcuW5v/Hr6fDSKkh9Xcy9
X-MS-Exchange-AntiSpam-MessageData: aYua9a36salQn/ZsarkH3vGGsuVHMokhXZlAMroSxKdkAkEBNAHo1quaDS14zdULYaYS8wnx573K65+7aNkJYaKqi/FOpUqZGEQfJ3iRUOSogDgEDr4wmAHD/UwJUhyyTJsbFVxFtfFeFA43PmePXrfLrqKA354GQCMFw0jVga2AOSg1N4uyheIA1TZNdrgW2umqgJiMbXItxY9C6ji0EQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85f6c37-5397-4f02-a16c-08d7acaf375a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 15:54:44.7283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lSar4/pc4SEAjB+C11+rt0IoJwJalYTWkNdgwzFeClZxoZWBc4sEMO5ZaTMysbo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1593
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.02.20 um 16:12 schrieb Pan, Xinhui:
> The pde is on root page table. No need to update parent's page table.

NAK, the caller is responsible to never call amdgpu_vm_update_pde() with 
the root PD.

Otherwise you could end up with empty update commands and that is 
illegal as well.

Christian.

>
> Change-Id: I2ec1015736039cf0278bdfa9bec35185ece506b5
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index cc56eaba1911..247f328b7223 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1235,10 +1235,14 @@ static int amdgpu_vm_update_pde(struct amdgpu_vm_update_params *params,
>   				struct amdgpu_vm_pt *entry)
>   {
>   	struct amdgpu_vm_pt *parent = amdgpu_vm_pt_parent(entry);
> -	struct amdgpu_bo *bo = parent->base.bo, *pbo;
> +	struct amdgpu_bo *bo, *pbo;
>   	uint64_t pde, pt, flags;
>   	unsigned level;
>   
> +	if (!parent)
> +		return 0;
> +
> +	bo = parent->base.bo;
>   	for (level = 0, pbo = bo->parent; pbo; ++level)
>   		pbo = pbo->parent;
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
