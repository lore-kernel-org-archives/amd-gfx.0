Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE03EE49A3
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Aug 2023 05:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9CA10E2D7;
	Tue, 22 Aug 2023 05:24:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1A110E138
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Aug 2023 05:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpwmRWa3Fyzvwl0F8p6HyI+sWPW4crLXCI1nx2U/HiFeacNm5oGwBzlWh0BoefhpfGNbPhmA7n5/Z8hWuQp4V41hqbNPh/C0803DemBUP9qy4mSUJaJd7l+3Pwpdrytsy3QaaMVH86y8nTAnR6mWYdeGO+4BflRhmhcl4LHiJBh8Oay/E9hTB8cvOZIdg/zPeTSOsskjsGxbiqig1kDclBNNvzl7SshZ85N387je/2pNgPySwLyuhJ2kld1hf2SFV/tpfAm6IXZ2TkuLeUTXeT6z4oZPBhkdQcDu0aUB9orwRoTGC3tAkdKuSgXENKHoc3PmfufyGyqaMRZpqh6nlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwV8koG4O9gjn78+3154cNaFfGIqev8r+OtrYinBCss=;
 b=DNYwyEctcYm6QXrvX3ZgXtq3Gh8QsrwbDsK4pfsMO6lM2bAFXHMSLbZFOBNTmBzuqgVo5nJNB1i3xBgw9LEnHF0hidHwpNWj9+07tuw+VvJOFrXqpDRQMk2otJjrcKw7tI3L7fT7G+pa+x/jwTgej3n0XQZEutv7pGOcBMypMXUoKM45UpgvNT5WQIqoBrDWrilAKh472jyWDAnkGPOgp2YIm85ni3TriVaOy9+a+vnP3CFGWSeVL2g9OTfn9nbwpuDCwYRMx38XosfYX0dSzzzYVSR0Rotgx/ALBlBLw7rykStGNGinICUZIpPwQKbYXc4X7gy8AfBs1sIR8pFsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwV8koG4O9gjn78+3154cNaFfGIqev8r+OtrYinBCss=;
 b=kxQ9gb05ihF9UaCv5Xvzpt9C1dI+Ljvqjpi40J02q/Kvl1EXskKZgA5L0u+eMvCoEWARwF9G/PfJmmXC4BjfyZXZ6f7MTnByBzxLuZP8/OiE50wM3p7KvfhvsVOe/Ypk7A66CPl3Jr+ffBQKvgA70oEbJJMltPHYn9UVGw0lMKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 05:24:46 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 05:24:46 +0000
Message-ID: <066e77b0-7740-f8ce-5586-e3338b8e58b0@amd.com>
Date: Tue, 22 Aug 2023 10:54:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amdgpu : Updated TCP/UTCL1 programming
Content-Language: en-US
To: Mangesh Gadre <Mangesh.Gadre@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
References: <20230821124704.3746697-1-Mangesh.Gadre@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230821124704.3746697-1-Mangesh.Gadre@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dba2e4-706e-4be0-aa2c-08dba2d018c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHheKcKUgcpeRKa0H+0zYaKJiMxEdh+iyEblslj9bvVcTDNFQ0tJ1Xp6SzQDTZ6FM8kWKiJ6ysKDRk6P85ibAVl4mtptio8JNG5XsezYJ/lWeFzTgTdcrvxoXUURzsAAewU36U8heEgIzbfjFilmRgMoyigoh61y/soq9n7SrPEJ+Bk+xY0KtQ0xjixfx2IHSJEIiCRPLDACGJN5jO3dnavbtKrns4FpEzmje2QPxYVOMQ/7i896z7UU92RJieKRRVGeRb91xaeV8ZXPmdPwMRQZhxhE/y2IHXEHxE7nGfoLbIHa/iSLY56doI8n0iDWlHu0SXoVCV2OQw9pXUA084DCz4WY8Sp3GE1X3po2KRGj1ap0UIjL28kJ2xmk4parmOFbVHMr9qF71BlgXcmekGx62pGUzdgRjXz7dtykcfBYlWVPwX7Y1GJratrSjdicrhUYq2WFHc31E+XaqFGSh+G0oWoOiOQlxlRZp9Tk0Wg/3pagHTAGBbF6eTCp0r/vdDflMuUowfAxwcHKeKnqzk2qCgr/Y5xk05jxVcmoyibFYjBHOjrLxIkbHsCH5fX2dZm4lm0mDn22qVQ/XLIDV05sdnBgxrujBuaxP0pemEiX2XRWsqek/qPGuZ6y4eg33yc+Vwr+pNFqmzaHE7wX6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(186009)(1800799009)(451199024)(6636002)(66476007)(66556008)(316002)(6512007)(66946007)(8676002)(8936002)(2616005)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(15650500001)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEhCZ1hBbEN6ck1QZlZQbzhvL0FxTXJ4dzBuYXhEZVljR01yYkxkRjF1SkNM?=
 =?utf-8?B?Q2s3ZVpjWWJJMzBOUDFld094VTdjaVJvQUhiQ3NEcHJobUhKVzFoaXcyaFhC?=
 =?utf-8?B?Zk5LN3Jnbk5Bb04zOHFFcFpGQU5RSUs3ajhkVHlEZjFBZy8xemtZckttTkY5?=
 =?utf-8?B?YkxGKzA1TmNoZisraDhjejFHSy9IbDBUV2RUUlNFWnRyaTNaQ1lIVGlaM3NY?=
 =?utf-8?B?WU5OUzZ3T2dNakZrNHE1aDhGZ2JvaEx4S3QrOFd2ZnpJL1pua3lqMHhBTjU5?=
 =?utf-8?B?ZXo4ZHhjNjRjMUxxbk52UTE4UVAxL1l1V0x0N1JmTXgwclZEQlAyTGl1STdw?=
 =?utf-8?B?MS9wRWF4QnVYanpaNVR2OEg2bTJLZG1lcTdWMGtOTys1YnB5bzNSMlJDMnVr?=
 =?utf-8?B?d0xiWkxpNU94am03c2NCR25MOU5MQnVWelZRTk12NG12NFI2c05zc052andQ?=
 =?utf-8?B?U2pJQzQ2YjB4UjNRMmp5M1k5MGtjeWFZSGgvZzhBcEE2RHJtL2szZTdCb1Nw?=
 =?utf-8?B?WFQzMmR0Q0U5STBxUlJRNHJ2VzRNaGhZK0VwaFpJV0IwSjk0RzVIbHNxdXln?=
 =?utf-8?B?SlM3QWdrYUFoNHdNbm1YRHRsQkp1YW1DY0l2WkQ1c0NoWStsVW5FMEhiOVVM?=
 =?utf-8?B?S3FhOTBWaHV2QTB4TWF4TGx0NENIL3VwU3lJOXQ4cjdYUklvTWpqdzM4TU5u?=
 =?utf-8?B?RUZyWnZQMDcvaWJOdUZ5dk8yZXp6bk5FWUVPeWl4d2Y3RE5aTEhMeWtIMmlS?=
 =?utf-8?B?aWVkd00xSkI5TjBaZjZwVTZaVU1WZjlkU1IybmJVbEVnT3ZuU3dZNkFCOVZT?=
 =?utf-8?B?MlMxc2VjR1VmVTZTYTdpN0pCNnBYRXdWK1NvNHhrUTNMbmdPalB3a3ZTc3RC?=
 =?utf-8?B?L245TXJhUm1qSk9ucmNYYURZMjJGTlB6T3BLdHJEN0IxZ1Q0L3gzbldpTnlK?=
 =?utf-8?B?QldtK1h2VUg4SXVSQlcvSG84WVFOU3NLYWszck4xMXgxRU9OMmdGWis4cDBU?=
 =?utf-8?B?cEhGY3prT1RVSXB3NHJCelA1bEdnZEZ4NitpMW1iNjBoSUg4eVlIK2RJbkhD?=
 =?utf-8?B?a2thRnRkdlJYN0NvREJReWFxOXVKRE9wVGxJMEIzQ3JYSnVORXBBQzI4M1Fr?=
 =?utf-8?B?ajZ1c280RjhhZGw3WnhLS0Z0ejltdmlFMUl6Q2ZOWlJEREFEMXcrUlh0L0Iv?=
 =?utf-8?B?N1BXZS9xWG9FNW9Yc2tIMHBLWmkrbEl1Y1d2eHYyUnFJM2V2T1Y5RUhFWGZa?=
 =?utf-8?B?STlJWjFUQUhjTWU5aDJCazJ5NUtya09sZFVmRWtaQ2dDZDFXdTBLSHlGVmxU?=
 =?utf-8?B?bDdwK2duSVkxTzdmcEVSWU1idjdpMDlMbnhTN1gzVGs0eUpkVnNuaXhMZFdR?=
 =?utf-8?B?ckhoQkUwZHJUTVNFQWhHM1prOEJOWDduTkNQM0tjUXZSNlNWUi9XYWlaOGtF?=
 =?utf-8?B?UHdCci9KYWszU3JVVnZnSzBjb3FxQSsvYldEL3ZkVFh2VEpHaHVOaWRJaEdO?=
 =?utf-8?B?TnEwUEZWQkUycHloZDltMnFxeFdlOGRxMm5LUnYyczd3Z25tMU9OaElqWDVV?=
 =?utf-8?B?dnZpNGZKMUdGNnFJY012SEc0VnU3d2ZRcGtnVVFBSnZnaVZ6dWxEZTNxd0hP?=
 =?utf-8?B?cW1Qb3NYSTNZM0loZEVGREsvQzdNNUkrSWdyRHpDS0taYTRhdDVINGFPb1Vw?=
 =?utf-8?B?SlN5dm5FZFUwNjQwMjdCY0x2QXorbXFDYlhQTGd2a1Q2a2hXd0ZlSTY0Qlph?=
 =?utf-8?B?UDZqM2thdEswSGV5WVBtNG4zVmhsSnlwem9YRm9jajNtNUZsVDVJc0NGbExQ?=
 =?utf-8?B?R3FBMjIwTitWZzBpTVI1NmVTMmxhcHJxbk5FWlRvaUJQbTJQckxBTkllaEg5?=
 =?utf-8?B?N1hGWDZCbXpQQUh5dTRyd3ZkZ3MrL3R1MUdieEZtQkxCaEs0aGI2dDZraWlv?=
 =?utf-8?B?NXlLZElmNnNIOE1uRUgxRGY2aktWaWI5YUdrUWlnM0tHK0JDUW14MnpqV0s3?=
 =?utf-8?B?NDlEYkxqeTJ3WDdteGxLRkoxamVMRlh2M0o0N1U3UlNyd251KytBcU9jWXJF?=
 =?utf-8?B?QWdqaVFzT2RzVUoyTVlLRUdEWUFGT3N6ak1WakVQaWltbFdkeWtBWkw5cVZj?=
 =?utf-8?Q?NYdjkSyNuHCtQgRqQaVJhVjye?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dba2e4-706e-4be0-aa2c-08dba2d018c3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 05:24:45.9312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqVhbnTLPoIJVfp4y0nFMcDcvFBD6Q6owXBZFeIgcq4EjuVpgny3XIwmMTJdfS7v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
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



On 8/21/2023 6:17 PM, Mangesh Gadre wrote:
> It is required for TCP/UTCL1 thrashing
> 

Description looks a bit odd. You may rephrase as 'Update TCP/UTCL1 
thrashing control settings'.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> v2: updated rev_id check
> 
> Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 93590adf2b04..8b84ca80d80b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -203,6 +203,9 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
>   		if (adev->rev_id == 0) {
>   			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL1,
>   					      REDUCE_FIFO_DEPTH_BY_2, 2);
> +		} else {
> +			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL2,
> +						SPARE, 0x1);
>   		}
>   	}
>   }
