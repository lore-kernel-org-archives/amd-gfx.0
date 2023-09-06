Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5873EB8FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 11:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1F210E608;
	Wed,  6 Sep 2023 11:07:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F69710E608
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 11:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw4Kr6fnPoVTrfBxYklGbWo4JyIFrvfxYTT0UF6q3Xdn73yJPHaK1E0Od+papy1BS2pzH3kilBnFZdD17vRAJmXwokJSSv2tWzaAB3zUM7LfUiWSRMJoPcX6uC2WCJ0sv+FTWwuJxGArTrCGY2pNA/zuP9r+yQ/dS1H4ouRXT97bXao8CJR2+VpLKTLwdKi12ds4WZxnX4TecaFuoLnvqEIlTRs4x/b/Ww1yqdlmLV54YDPvNSo7P+XSpRadApZQx0FldSZGNnQNZKCG7wX2kK/7qwkvmXZDNdzrtVfidKN/DyDYFEMyzoJ6sbVowr0E5DzsIxpfxBwRAoxveORAkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3Teke+kBPmb6K76qMfe9qOzVTWnsspoIcSLNPJfnGw=;
 b=l6zjgPrhOx4aJO42dPWd+waWv5sc3AIvow8DyQJLl8vDVWswtjQozqMcu1iCqVmAngvUA9EOieGlSKH3yY6nyFf/foMWpS3wTlcoAnP3X8MBjJNwIyfexhoyqlEXvjPKzOvwA64gBqXt2fCKduBTODm4qcHwk2qkLr8WNuP/9iAgFybm8Yy/UMhLgmyl8dTbt2LMdw/BOS3KxkjWbkEn+vyQbeWPtyXTkGrx1Jls0IHpQevnP/tXq/SRJnFbnrxthVkv5uEyrHpYBJLwXLY5tzdhrbjYbg+VOxIhSqIRJfg18Z+4h6B2YUkrX1AV6y1JucCBiPrWPvNBIH6H3UGUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3Teke+kBPmb6K76qMfe9qOzVTWnsspoIcSLNPJfnGw=;
 b=HChtwiJ12qFrmQR5tnamFTZ9Jj8ZwNBl7zN/RPUNFHUmSaADapuWGV0Mlwn45AsZCdX8sd17B/kOZ21+KLSGQWA0wJII6nm6z1sy/mMUxb20A6G9SxupKxIX2LW0z4UZzUN1AkxUfWFUnj64OUB9tC2sFA3QQxH5WNwR3KXiBDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 SJ0PR12MB5406.namprd12.prod.outlook.com (2603:10b6:a03:3ae::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Wed, 6 Sep 2023 11:07:43 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::279:f29f:4831:9482%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 11:07:43 +0000
Date: Wed, 6 Sep 2023 19:07:32 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [bug report] drm/amdgpu: add selftest framework for UMSCH
Message-ID: <ZPhddADtKmOuVyDq@lang-desktop>
References: <dd425f64-868a-470f-b78c-8bf6a7b7daa9@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd425f64-868a-470f-b78c-8bf6a7b7daa9@moroto.mountain>
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:EE_|SJ0PR12MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1437c7-ce40-4ca6-89b9-08dbaec97e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4illWxUk3d60jDuSoyIj/s1Fm6BpdkoikxdmF+cwuyzHVvO1jq53bQTdWo8BlVDeWhlAfw+rC4mI1rETjej8gyna1jyh7On3TgdC9ZkXfKxY5ZINEPYOoqVN38EbewYoqaF8meC8t5jHySRqelmywcn2xbNSm4Mh4jhIFjMRgqDBd+zZm6CP+hgc2l5vB2c0t9lt0o3Y7LVDNmcidf1wyITSZ7LqYG5wjvUCfbIEJROh6V3DIH0yEnOIgJOYEtt3P84eG3o7cvydOVXeKzXuV84YBbZWr/7K0xwNtDWP7Xutqfzf5mfzG7fxqpne6DBDdtXpmwUrZpS5kyHykMsH42s0Yo8hhAlbgWiolFeiVcL9YBW+TTOV/OOQEUm5Tjqd8IJtX1wVYihShuWuieeI28Ug57+SYGrDcPZD+iSXplx3piRDRZCniRSKyIJNW2fsvsCpTFk7v/b94qrV08NUkH6qLiL9ez1OfuKYlRzlHZU6X/FDqvsCmu4yyh79kZuMZhbtk5R4T2Pvsn5fDzOeawNV/73OeTSzxYuCFyqIa6U5E+tIU5dTnM9vj9ZR6vKQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(376002)(39860400002)(346002)(136003)(396003)(366004)(186009)(451199024)(1800799009)(38100700002)(86362001)(33716001)(6666004)(6486002)(26005)(5660300002)(6506007)(66946007)(66476007)(316002)(6916009)(66556008)(6512007)(41300700001)(4326008)(9686003)(8676002)(8936002)(2906002)(478600001)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FCBK8jBO9EPn9sRAzCg7r+kaIPu3W7Zq9t3doH25oZ3nldK7K6f4FDekU3Hl?=
 =?us-ascii?Q?BTQkQgzVYuNyJ11kOLmDKV0tHJnIhOzy5dc/zfpq23xXOy0N0NHai1XHg0nR?=
 =?us-ascii?Q?NrFN4TzDm+dB+YJ5Nu9B3DwiTCxu3NgyKMp/chvekpKkWx//fmveV0NN1WEn?=
 =?us-ascii?Q?bgZquHAN8XtnYF4HpLtd3TYVP8YaRp4XQxN1CkY3RwcoN8pfM4u0CRgQwwhK?=
 =?us-ascii?Q?kLyAkWBVM8GuLpV32Qu8Rh4JwbcOm+51vFL6F78FzKy1HNXqVmiSI9EbY8Xd?=
 =?us-ascii?Q?uwuHjs/uRA4+jpYGRisndy4JtO0KNBUBMP/dMq4/6FM4d5lyEkDHLJs50ndE?=
 =?us-ascii?Q?HKhBbwHrTwOCrK/w53Bxzb81dlKNlH61GzPvML4VtRSwE5AVtW3rqSiXa3fn?=
 =?us-ascii?Q?44ddMWT5ygALLIxzVf3v+PgumFqQYH1OZ3PQJkXRj/mfQOkP9mpmc5DaA+LG?=
 =?us-ascii?Q?aLBaLITPCZR7gLoZWWyyeIEFd1dbmifoxRV5MlWqhV2a2YaKHXNYN5kPIRhp?=
 =?us-ascii?Q?OvxILCNnf3yFCdc1zW26wwW5PcWQ3JDGnI8gbFqqsrEIz1d8lhMp2THs9Dyw?=
 =?us-ascii?Q?X1ud4yPRKhrstSyKo9ISZCTDzWgXisVwq/dcpl/0X3jcPyAwgzMYXa486hys?=
 =?us-ascii?Q?6EpCrcSIbbK001B2esBxyQIUcXArhmiV4dhsKdj+4hTI8EWQGEOjkM39mksZ?=
 =?us-ascii?Q?NvtL0pfX4tRAQf+2nO4YT0sBws1Fpwd8TrgTPUlBpwWCdSRC24vuhIVT9kpE?=
 =?us-ascii?Q?NUZFhuqAbOIbyyDkzw9u/faraXTBbiQWOVV7ahQawChqIWi3ZhbAfnKYvG6M?=
 =?us-ascii?Q?uZb3WWXMXJbw+szD9sH/7XwnQ2xNOyuF2SXIJFKQC7vgMa3X8NNoyfu3e0S6?=
 =?us-ascii?Q?SiSRXACUu5lHDCLyxEeWLOkmL7v1ObpzY7y3WVRfEiWmskFvwhjiR/Kf06cR?=
 =?us-ascii?Q?UUBIiN4IAAZW6vdgy0OcRtGv8UtDWiwuWuUZnp3hcT/owKfnGWNg3N9wkNKO?=
 =?us-ascii?Q?dCEC1xJweKZJ3KdEwAECqkrbySJ36m6ZggSzFbESm8d06kO6WLcs2wX9QLXW?=
 =?us-ascii?Q?rT6D2F4ptybDifqfA27zIjr+lWREuw4IpvxZGi5AyFrFNDzlmVJ69O8UMLXl?=
 =?us-ascii?Q?I633LHTZdEKzt1bMR8gsxTWDIn12PvzIGvtqIngXk/W1ShHLUSyYT5Zk6u5V?=
 =?us-ascii?Q?X6Pdd6yZxHX7jeBE4GIfOfE0277MN/a3coPEyS2WmhTWBROVlDW6wSv+P+TR?=
 =?us-ascii?Q?SbFsvfDqr5CMfGUTjnUaKrBbEjnjsmskXlfn1ACFe2v4jkifTllFmQLcEoAo?=
 =?us-ascii?Q?jjDdsMoaE/J7koOznkKdsIIlIAOt9amQ5e/wF9sT7zQRMvxQFaI/ZAm7RUc3?=
 =?us-ascii?Q?JcuMf/Zmgrw5CP9mWUSTIs8E0SRLooyFvxhkdphfqF4LHGJbVKOvggzL8pCG?=
 =?us-ascii?Q?hBq11TjzudWVNM+JRIpnRuur7xDYlz/HGByfftcnQUYLGqcs8QswhqjDrRJj?=
 =?us-ascii?Q?SGASYDgGMqadEThUM1l36bTDTflSznX3int6ki55Cd32k5EI9UhBpCk2GylT?=
 =?us-ascii?Q?Bi9T1DR45UIPsqLDFV/M6MEzPX57ov0umow/dB9p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1437c7-ce40-4ca6-89b9-08dbaec97e07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:07:43.3085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLMYZviO66ZTqPAQxx0M7D2ZEUt4Qbsjf3MDGI4JcUUuUuG1EqI9Ygf0p9WVniYyo+zxyNOUSZYLwhwaheYc2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5406
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 09/06/ , Dan Carpenter wrote:

Thanks for reporting this bug. Can you give a link to this bug report? Commit message requests it.
("Reported-by: should be immediately followed by Link: with a URL to the report")

Regards,
Lang

> Hello Lang Yu,
> 
> The patch 5d5eac7e8303: "drm/amdgpu: add selftest framework for
> UMSCH" from Jun 21, 2023 (linux-next), leads to the following Smatch
> static checker warning:
> 
> 	drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c:338 setup_umsch_mm_test()
> 	warn: unsigned error codes 'test->pasid'
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
>     319 static int setup_umsch_mm_test(struct amdgpu_device *adev,
>     320                           struct umsch_mm_test *test)
>     321 {
>     322         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
>     323         int r;
>     324 
>     325         test->vm_cntx_cntl = hub->vm_cntx_cntl;
>     326 
>     327         test->vm = kzalloc(sizeof(*test->vm), GFP_KERNEL);
>     328         if (!test->vm) {
>     329                 r = -ENOMEM;
>     330                 return r;
>     331         }
>     332 
>     333         r = amdgpu_vm_init(adev, test->vm, -1);
>     334         if (r)
>     335                 goto error_free_vm;
>     336 
>     337         test->pasid = amdgpu_pasid_alloc(16);
> --> 338         if (test->pasid < 0) {
>                     ^^^^^^^^^^^^^^^
> Unsigned can't be less than zero.
> 
>     339                 r = test->pasid;
>     340                 goto error_fini_vm;
>     341         }
>     342 
>     343         r = amdgpu_bo_create_kernel(adev, sizeof(struct umsch_mm_test_ctx_data),
> 
> regards,
> dan carpenter
