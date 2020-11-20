Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B0DC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 15:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AD120706
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 15:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kCpvRiKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AD120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E966E8E2;
	Fri, 20 Nov 2020 15:43:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C166E8C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 15:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9kJGC4Lz0yrFwlft5+wdVqsqvr+G+4Fp2D12jFYcZILO9LKe8cOM6vGnx+oV8EgEyK4AEbluc9nmX+I5ddo2yvSFXNZqCJYIxBRyZmbitNmZmUSZc4TrHhxjpPtNMBSCtJbwxa/38j5J71HX0aWzqiaJB+2myGn+ExKNpyVCBV6Viz7LOD8yjMK3tUQE8I2QTb8lhkHX34NUWUaYQt94kWkI7SkR17XO1XCDBpOLiya7n2DUk0lR7baTdm3PfPPCI0mvEN32q/8SCjaKkUS43FsH8LXd+IahzTKLNuJWWOGDnmHUC8/GPHqZ1aDcBZ4jJ7goe/qwpcmWo+qaJinrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJfbpOkjD7hhAR7yY6Sv0o4/j2A2loWT0daEanc7cyE=;
 b=mF1AveSpjklgmNN1Q8fZ1BbioGPXFgMjVNnB/z0f5tj4gbHGy9XMBT30jsqWw5Phweqss9vHewhEGKcU92Gn4mQVgwaUrfpInHAsfVkWtXgDYPhIdbxDoEBxPGIsonO9dC6sJ7MhPm6dWoPU7qsL9Ayk/2bfjdkYSrvl2sfHxPaD5aHjfsvjgS/Gp/pGV3/NRMxzRPHqr7y74jcO5KaLGCmUNem72COpEl+/FWlsz6JMsxRoUpLkHf8yAze2B35NxtfH9rJC2L2HI9rMYlNvQrySrhoGeBw7O4Sw58bZ3/Rdt6IRQA5uE4oaHQPLztVoq4scgGEAId1BorvgrPndmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJfbpOkjD7hhAR7yY6Sv0o4/j2A2loWT0daEanc7cyE=;
 b=kCpvRiKYfZpv3782KfTaj16GPISoSO5IfM9+Bxhh7K2n0hZTp7JD7QSQSAef6ZojgoFGyXdZE9x4+03irnhzYcwpw97a8+G9WE6qFILJPrVOtjyBerzcNJFZIcpOkWRuU8YH99lZDl2uIyNv5e5akTj4ohj35HIkKxvcdzcXci8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 15:43:22 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3589.021; Fri, 20 Nov 2020
 15:43:22 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: use generic DMA API
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201120154104.37432-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1b812740-ebed-4d03-aaf9-4c0143a1b94f@amd.com>
Date: Fri, 20 Nov 2020 16:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201120154104.37432-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.122.114]
X-ClientProxiedBy: AM9P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::24) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.122.114) by
 AM9P195CA0019.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 15:43:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c916cbe8-1058-41ab-0f35-08d88d6b02d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44185AF978F7BA4F315D4BA08BFF0@DM6PR12MB4418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMRy+9kcvQbxbhDeuFnx2AssXlMljRJswEbRkyLmGiRhiGxFzBAlNiiT8DtFWXLwhFiMYUACz9PkmT7LDiantnV6IJpDe/mDrIKzRW//EXY+RAiZNjygckCwV3bP9qwK3pQmWQJHlj3lu+1EgOMLf8hH9xdLfT+Dorwvrfv26hHANL/ceaOp7j/Wt/EYuyGQwkiGiIVzOul1d5ch045/rrbbhYH8DUc0liAfqQQXfu3tzJeESL0el7mQJjqWTSrHhCVkLlA/8ducxI3c+soG8vKlOJLsf1TM6JaiahdjeBygU6p28Xt/PJw3X+SaQQ4ey8Ai5TPadgBfOkmY9Sm0NIsRbdD27OdrViJrtyTf9Vz2XRqCG0YdACYbD50ISjEa5ffXlrs/aLSK0l1dz4oPxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(956004)(2616005)(186003)(316002)(16526019)(26005)(8936002)(4326008)(31686004)(8676002)(16576012)(52116002)(53546011)(6486002)(478600001)(66556008)(2906002)(5660300002)(6666004)(31696002)(66946007)(66476007)(83380400001)(36756003)(4744005)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /BIxBG5CtTHOZMI8ZfrQNQlNYvqY3yieNhzoGIg3HmNlFn0Zdwc8R8E/UpBu3WVb0zm8Y91HaokkNaR66TxEKzzz6mtpDiPQSB/wkJE+baKNMU5MsOLg5KtGwCnnj9IOZ1WNrNqtDuolPEgzDNuTkSreTZxApbgsc1TdyOHIY/i2OazxqxQJ6Ej26ZLYoF4gjJm6hImTvgPy12gpsXTrwYJDAtP2zlmpczCftgm5MK0ZCZyOnus+KR+sHXTU8posiyoSGa6p/WpI9l4iSM3xGvzJfk8MWrA/VeOlp6yRUw0/V0PbHs/Enl7u3kGMr5AnUYGq0p2R2rupWOf4BmR1ENkUJrEb76r62xkdhLDU3oauevDkvSIl1KIj/bkJojh062F5wYZ0R3/yTQQxXvYbMu0IU0jfvRWo7UevgOb3tPsxU4kwThbg/Ss2ldcNPdvRKqoWuMDEh/qKO6ybTN7El9DlIjfAxypa/HTB0O18ttFpZQjZJ5TjMAxQx2oZzylJb4rZr0sMMqWoCENO5AFn3+dm1/qouH2cMu0HYbf4XbFzF2Ry9HEM3GniuU3+08pd7Cjt2z73oNxWSGZyfdnwHaBe2ZCNSwsq6W5dIBLXdjVfCvZGYyDEZXb0prRadBfgYGerTVDITj1O6/KBbMxMWhBTOWfZnqrYVJ+Vchh1eEiD5Oyhd7QJSKfwEFkRqS69eldvQzQ/4NYVKZh+ZPmeCGBFponXAz6VTziYOZhtxiQ8N+S/sJBFS6140yGU378/PSkSkxoVTIHz4bTUa5ETvs3sW9tLhCNaKBkpOSNH0yLnErGycKB1djmWGIK0T61AZaOXb6FHwZPz1u/DRQkQ42lzY1WUYxCpBZkR1mkhWOlOyqp1wnAHf49rjZrEjyJUgHF9J+kI/BumQ9Q0RIph0w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c916cbe8-1058-41ab-0f35-08d88d6b02d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 15:43:22.4624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISs6W3fyYtJTvePwpJNjsN4vo/d6xIfzvo1ZsfpSovMXNzmSPqM8ps4e6o9ujaSmRrljdk3hBMZ1DHlDFsubTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sorry, I missed pci_dma_mapping_error() :/ I will resend.


Nirmoy

On 11/20/20 4:41 PM, Nirmoy Das wrote:
> Use generic DMA api instead of bus-specific API.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index e01e681d2a60..ea55d66b3ef6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -75,7 +75,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
>   
>   	if (adev->dummy_page_addr)
>   		return 0;
> -	adev->dummy_page_addr = pci_map_page(adev->pdev, dummy_page, 0,
> +	adev->dummy_page_addr = dma_map_page(&adev->pdev->dev, dummy_page, 0,
>   					     PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
>   	if (pci_dma_mapping_error(adev->pdev, adev->dummy_page_addr)) {
>   		dev_err(&adev->pdev->dev, "Failed to DMA MAP the dummy page\n");
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
