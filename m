Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53246EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 06:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B156B10E35A;
	Wed, 28 Jun 2023 06:03:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12EC510E35A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 06:03:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyUtgWp0aUTvBeaVzwnWWthCkCYhlJ5Tmx9uEIPlTUruyGXV6TXw+4D/hKxXH3yHZ5CVxUG1wYoeGTkU5IxNL5KYDJzdojHFm3M2CRhy/2aEjaIiaRS7wX6Guo3IrQfZP9KYWUByf2PkYFUWKwKrrXuCYroWlkxWP/Cz6DMd1LHvRCJwSZcs/ZwqPlob2FUC6jxto6BvJ6kVjptxnEl2Y6/HuE/cVj6cJoykOv6QqPqb/D1eOOvxN7KDDnFBNqPVgpyB8yurLLKI7K0fWe0r6w65q2m2gPpuFL+eJtMlKbTG2D4vE7crLhuY6FnO49JKvVf/01g85CjZHuT2SkvG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu6pSvCE3U3gOiru+UYqf969+C67Td1y7wikzNrzRbo=;
 b=G4pgzEz4+qZ4F7Rm3hbgu9O2tMloEwlnBr6zz3foqWew18M4yAYp3ODoqDLlZofiPsubk3NMcItMmimUjF2jlg4Xus9ligYBMPqhvdiAkld+b36E5/mNiG/q9lxqNIeKe3bFrAY83acCqhde5PR+pGx2IWw5LBQrRX0Mnp4rINc9tDxVx91rtRnQk5+Q1AbOcdq77NcR3nb6s7+S3cqwGAacbcadfyesjncmOKXFMoJFGJZ+/W623/kMgHNGFMOKnBwT5KLPmGNNn7uWommk0AcPXsT1mEw3LOgM3BE9NWlpuBX8h1X9hB6yiDzNTXS0sj1E7KoBWqyBLdPgNJJ0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu6pSvCE3U3gOiru+UYqf969+C67Td1y7wikzNrzRbo=;
 b=V2FDKCvWEw3BdaGsXg9j4hJ+3iNbz6l3XnGsczYB5gepNOpE/gdTnb4W1XtuevlRYN58p9BLwaeyjj7fohIbIwBLommhd/BmiTg0oHjJERxxHsjU0ycyv6i6DowvrwmHSlDl95prII2WK8h4j3htE+HfjjT8LwJs9S4vIbi5ZTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 06:03:44 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 06:03:44 +0000
Message-ID: <4555c86e-58d7-3a1b-1633-1a3064297d7c@amd.com>
Date: Wed, 28 Jun 2023 11:33:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/2] drm/amd: adjust whitespace for amdgpu_psp.h
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230628044522.600-1-mario.limonciello@amd.com>
 <20230628044522.600-2-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230628044522.600-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::33) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 819b70d3-cb4f-4c52-cdc5-08db779d6d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XyYtkx7FUMIEDjjxj3u3TOieT17ThyBYpPH7iEyBp4VAqpySLEf/ReYNCtP2zxPuSv1hSW891h1iXjFWYqwesMFeJQ+vnws/ul8R1jbRQa+SBYhpPKTBhvC53B1Z5MTg5hblM+YCYUUcGADRkz9Do5h1f+VPlq8ZsbEWdHsBBCW9g7sqhtvvYokYjSQo2Jf2RlTNiN0bu8pCqXJsfkepy+4bztC4KbowSsOujfptY9u95+68ZC3aXqBhyIjbgRlqnCE1i++KJ+mMjWwYiBPS1YdSeJe21BKuqOpZQsOJ4la/YtdGkINbbLPiiuOi13Jfp4FZNU+X1fREUsqiAeGgoItMy998BZvdAZuZqRW4PF2sdk4ZpZw17ci6PkGsR1GRTT9NPBgEMNbttDNczmbPYTMjkGkieIY46X0TZpQOu3qh6ls3vgD986/DL1v+2DwEUwIBxwNpyvYHx7pwWchQ7UvfP9Y80SNwd7ArQjZkjjpekjkpVjSYk2IwJjpzyJnkqRohYnhgJcuHrkmrBt/ABCvunFDFVZRtS/bENa39oDYbBRAHHhUTKN/DtE5x1QEJdsG1RPtK3H8qqsJvnMKfd/xY6iRBmqGF0YYLzkP15yR/DwQ2pRtWmsj9FbjJV2yzzkkKwk06cpdw1J+7p2yXdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(66946007)(66476007)(66556008)(316002)(478600001)(5660300002)(36756003)(8676002)(8936002)(31686004)(6506007)(31696002)(86362001)(2906002)(41300700001)(6486002)(26005)(53546011)(6666004)(186003)(6512007)(38100700002)(83380400001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTA1NWc1Mys1ekdQaUpYSFRJMzRDMkZoWDBYZGVObEVFZHlMbUJQQ2dkYzBa?=
 =?utf-8?B?dXNDS0lrc2FtTHI2UUxBcXVFcGxkWWhpNEpCWkJ4RlJwTDVNTlAzcU00eW00?=
 =?utf-8?B?SFp1UmZ0MDdNa1FrcUVMb2R4RDA2QkxmNHJJamhZMFlTUWUzTGRFMUp0QXBT?=
 =?utf-8?B?TVFYZmJhK1YreHlxRDdqNG94S3ZTc2lDN24vV25YQ2RPdE9rMmdQQW1Ra0JV?=
 =?utf-8?B?cXBQMXJ5TDN3blVKNldzNUdyTzh0RE9kQld6dk5GR250MG1Wc21OQXI2M0FL?=
 =?utf-8?B?b210aEtqdkdiaGdaVjA4a2ZQcTQ0eFVDRm1kVFF1VFBNeG1YQ0NnUk5MNm5U?=
 =?utf-8?B?bkxLQXM3ZkVmOWdTWmNOT2dXVkIvVUVnUExxc0RjVDZ4K0x4Y2xsTFhyNmpl?=
 =?utf-8?B?SklNYnBad2ZwaWR4cEliQmVFdkh4YTkxUVRXMnpJUkk3V3FwUW5XRjJtbGtJ?=
 =?utf-8?B?UDZucUpMYWVqRDk3ZDUxOUxvajhKY1ZuNDVkSHZQODBLREFRMGVNWkNjMzl4?=
 =?utf-8?B?TGZ6a1U5clNQNU9mNE1CYmtxaGtNVkhMR0RrSWdseTQ0Y2g5YnpiOVhlandQ?=
 =?utf-8?B?aEphakRoNFFGNGlZSWFTT0N5bU5RVFZMSmdlbEVGcWNiL1loa3Z1S3pCVTMr?=
 =?utf-8?B?UDVzS2ZHNnZ0ZzNDa21zM295L0thNy94WE5uRzZtd2JFeGRVM2MzcXdOVWtQ?=
 =?utf-8?B?emNrMkdObTd6SnBhekZxZWpPZzFGbVNIS3dyZklkSG5jWHBNZFgrekNyNHQ2?=
 =?utf-8?B?RU1xMElXU3VWa0RNelhPaEJ0UjNFQ2I4TVA5UTQvN2x6Yy9NNklRQk5RT0gz?=
 =?utf-8?B?ZUlRZ0JRRVNDTnBBRGhQb2hOT2YraGdTVUdnSGNxa2ZjZmhlcGNBeHhrMTI1?=
 =?utf-8?B?dk1rVVpjcUwrNCtkWFA4T0VuM1A5SUlER2k2UVI0aVhpNG05KzNCV1M0RDh0?=
 =?utf-8?B?ckxNeG9EVmtpTnlSZjlxY3A4aWhjMWJ3dWV3Nk1NODYwQ0ZiNzd0SEVhUFh6?=
 =?utf-8?B?ZlgzTFJqNjRkNXNOenNzUWVOdEJYZzJlSGNzSXR2TFQzOGlpTGo3TDdlWUVN?=
 =?utf-8?B?U2w3UXdockxUUWs2REFDV3psRnVnUUNmaEtqSVJCaTJIQmdNcVJqdWpKNkg0?=
 =?utf-8?B?UlpCbi9reGJJM2p5QjB6SGNwZ1JEaDIrVUo1UUtRVnVNM1pBZGxROGpVY3Jh?=
 =?utf-8?B?azYwQSs0blpsQStteE00RjZMV2pkVER6b25TYUp4Si9TNnpJUzBvQWtBM2pT?=
 =?utf-8?B?azVMTEpuYkdOMGV2dytDWklvMHZYdVNlQ1JFbFJZeCtjOENlcVArWVRadCsz?=
 =?utf-8?B?dWlMUkJPb2dkaVU0NkNwd0p6bXNldlhSOVZQMWwvNkpDazI0TzJHQkltN2Fl?=
 =?utf-8?B?OEFHY2ZzMlVuMUxzZm1RTkJocXBEZEJrTFhtbStsZUdvcmlOWHhjdjZ0cExw?=
 =?utf-8?B?Q0MyNVpVQnA2MGlTZHFjM2RydEhROHJlMTltMzhYWDkrV2hnZUc2eDczRm9P?=
 =?utf-8?B?a0tqLzU4YTJqOU1hQ2dPbEtMZkoxUkdUYlNWYUhzWm5nMWRwTDAvKyt2WUZJ?=
 =?utf-8?B?TE5GcldYcTdiMUdDSCtGcFhoc1E0SWxGaWxlY0hWQ1hxQVVqbG85WTBuc1JE?=
 =?utf-8?B?VHpUYWhxT3VVWTNHUDhMU2RkQ3J5ejJtdUdjelEvVXpxb0pHTWhSQkp2VE0v?=
 =?utf-8?B?K2drK0tLbkpBVDVOL3ZvN0I1K0ZYVGk0U1ZkWTZscXY2b09iSnpvbUVpa0ZO?=
 =?utf-8?B?dDAxcTdwc2VEd1pUWEhjY05pTEx0ZUY3RGxHS3dCQytETFpQOWx3Y3lIR3VV?=
 =?utf-8?B?djlvTXZoSTNlSnZOb3k2UVRrWGtUekZNblM3UkwzYTFtaUxrWnVPeGVvSThx?=
 =?utf-8?B?VXJHYUpoSTl6bzhQQ2MxZzRBVTFZM1ZxUG1LaGpTR3NtMGdrTUhZNlFZamZZ?=
 =?utf-8?B?NUkzNkpEK21rSTd2MlVUWElZY1owc2RrajZ0Y3JVdXlPZGdJQkM4ZktZOStk?=
 =?utf-8?B?YUY2aUNhK0pHYzhFOW13Uk9sZkpIYldHMTM5UklhYWlEcEdXWkxKVGExQS9z?=
 =?utf-8?B?L3htbzJNck04ZkRydVYzS0NHb1VLaXd6b01zWHRHd3pOQzN5MzJrVTl6VXBF?=
 =?utf-8?Q?RAKCm+tRNY6lFnxcAWN5jdXaP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819b70d3-cb4f-4c52-cdc5-08db779d6d95
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 06:03:43.8903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuSmMlyDEKUmpVr2WWDltLsKi9K2eupMJDKIMWqDAxh0fShKJtgFI2PgI7dhi9NF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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



On 6/28/2023 10:15 AM, Mario Limonciello wrote:
> Adjust the whitespace to be consistent with the rest of the
> `struct psp_context` structure.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index e176cf204202f..050230114e88e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -309,8 +309,8 @@ struct psp_runtime_scpm_entry {
>   
>   struct psp_context
>   {
> -	struct amdgpu_device            *adev;
> -	struct psp_ring                 km_ring;
> +	struct amdgpu_device		*adev;
> +	struct psp_ring			km_ring;
>   	struct psp_gfx_cmd_resp		*cmd;
>   
>   	const struct psp_funcs		*funcs;
> @@ -339,7 +339,7 @@ struct psp_context
>   	uint64_t			tmr_mc_addr;
>   
>   	/* asd firmware */
> -	const struct firmware	*asd_fw;
> +	const struct firmware		*asd_fw;
>   
>   	/* toc firmware */
>   	const struct firmware		*toc_fw;
> @@ -388,9 +388,9 @@ struct psp_context
>   	bool				sup_pd_fw_up;
>   	bool				sup_ifwi_up;
>   
> -	char *vbflash_tmp_buf;
> -	size_t vbflash_image_size;
> -	bool vbflash_done;
> +	char				*vbflash_tmp_buf;
> +	size_t				vbflash_image_size;
> +	bool				vbflash_done;
>   };
>   
>   struct amdgpu_psp_funcs {
