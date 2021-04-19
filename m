Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973CC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 18:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449E76127C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 18:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449E76127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C067488EF0;
	Mon, 19 Apr 2021 18:53:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B837188EF0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 18:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQ2GWkmz6eoza70GY5kp9uI67yN12cpK4+f4RK0vO61DAP4xQ2/3NoHENRSk3tDO/R3KToBb8loes9YZnEhBB6VIkb7Hu81FblbjolXTkehvZOGOZiHHWyGVIMWKZUu2AHlI/cY2HTGPJH3Jt0jKxTtdTG1n1u0MThP2FfImgB3MU2Jf9hGQbXXGoE0czbNDzUu7tNiJ7HFXvnR5qCGQ7GUUHVd2OaB+DWUro2CMQGhFsjvrfETEfGNBbiMigJV8l2Qm8dDlOMzhp9IHA650O/RZGQb1q4RtTCsTLL+nbfnxu1kl0NOeeM00usXbQisSuJTM8qGXT+WWcnHTFqfIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsELMApSE+AQp3qPBtnZxwqZlWdz0VKKlGPQ3Vs9gkg=;
 b=TnoI4lgllcicJ7nBgSHpfnL8AMKF6SGm1m/MVNwpkfWWWFP09b8u+8hqfo9njl2v+4TYkWzfpAbkOUHKa0IHqXzSv4ltkvlXS2rsVWdsxqPL9vZFpEliQzczf8Sv/TNSN7ibEiNTFV+JtD65UTCylIsA58SZHlXodpTEh61D1K7nlrDwbo0J2uXfdL3Y0edwaUCB/igxdeNt8TuTNWvlDOul0hV+5J1FwKPkcsI6x4pQD2+j0zXUl+bNiW/xQuBjLKGmXbeYzolTMUqklGIHXpw1IMmXcdzrTbqA19RUTxsm4XuBBfprjqHnR7DJRLEfgqepPEg4BFfr44wXmAwXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsELMApSE+AQp3qPBtnZxwqZlWdz0VKKlGPQ3Vs9gkg=;
 b=MY0oQrwINbmwnycdQYRz0ZruR+EvalHlQ3jtxmDxiKPh46IudXymQYRYYWny734tPARRDXpe/968RXcdb0afSbuutU1q02rBEr4nfCR3KuXavLiMcpMxYBXK5419v70Lg2Im9LSdJ5B7iPIFeW14r+dNoN88P77CCwBqqu0jl/I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 18:53:28 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Mon, 19 Apr 2021
 18:53:28 +0000
Subject: Re: [PATCH] drm/amdgpu: extend xnack limit page fault timeout
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210419172211.17096-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e19e72ed-ba55-daf2-4055-20e2b52f8d66@amd.com>
Date: Mon, 19 Apr 2021 14:53:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210419172211.17096-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.180.233]
X-ClientProxiedBy: YTOPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::48) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.180.233) by
 YTOPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend
 Transport; Mon, 19 Apr 2021 18:53:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6b59f6a-2351-48e6-b2d0-08d903646b6c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42235D066DACBE52BDFDF26C92499@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xrt59wshPxTFXV67JqstO8dOLU3xMw9xsL2yoJ4G4iOCPs+NnZgedhNGM5vI4gd++4cUgz6W7gYUcv2RrxKheGa9Q52rX4vgiFr4ajYOca4ljWANeK2y93nuSCJjm9GDFnRZDPg5ZS0aWNM25FYZ38elDTzuYPSll9keOuyqvzhkJiEyXsxBirxsNimd99hZrntC5evndu0HMdZvkLCj7e4I6ab3OK0sDAQuQ1375RcfLxHLYl6TX1Lv3EgR0aaFDEIweY+4jA4Su/lGX8v8pLCPUkPjDqdQpYetYoNvOqzgEPvCjvRyZJ3bFARbblty3xGMfEiXyPG6CFgSPLUWzvVmiQjP39Ds+KJ160G9DMPp0YSpUe7scWNyYk7jewBUr0/M3072/WcxryKvBRAC5ej0rEjrwsBVPoK0RbCjdf1dVwKLdWwPZPqjPk48xCCBC+r6k/zcy3I6OS9AtlzUEmnQ6u6yXuwTS7nH19icX95ukCazggNBbjV6z14DFHUS0vyhQmpg7yYfUbHFKK1hNhUZkYOMg2LV/qC3ixu6NUzhM8pUDbp7LudC6ZsAqzyr7tjtU2TwmhEOWrpNnBmXM3377AEZxcdA+N4O0JASI5EBP+HzYhwVzysIksFA6nqraCmEuPCi7T6XpS2Xr9Ximm5s+YMTqvpU0vLDgWseY7kq4ppUiDP0QOz266UAtgge
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(31696002)(5660300002)(26005)(316002)(38100700002)(86362001)(36756003)(16576012)(2906002)(66476007)(186003)(8676002)(66556008)(16526019)(956004)(2616005)(31686004)(6486002)(8936002)(478600001)(66946007)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WDdiSGpJdHV2akovM3U1cC96M0s2L3pSUkVlQVlIcG1STWlFOVNSY0hyR2JI?=
 =?utf-8?B?dUtyajNva21pY1dNOGRMK2N1eWppT0VuWmpmd0ZXMDF6ZjlSVDl4RGJJeVJ4?=
 =?utf-8?B?emFhTmRTa0dXLy9Gc3ZmTUdoNHczNWN6ZmRQQWxBU1dhZUhXVGY0bDFZU05y?=
 =?utf-8?B?Wk5vTytKdUl5ZG9SM3lSTFV1a2d6Q1p3YlUxMXZseW42ZU1ZNE1XV3R3K3A0?=
 =?utf-8?B?T25QYldZZFZGU2lFWGZJbHdPOXVpR25JVDFwMFQwZzR1YlFZWHpqQlNJWVkv?=
 =?utf-8?B?SnJ3Qjh4TGdIV3MrSTBUQkRSS2w4ZkNSTnZZcGtWL3UzL3VDVTVqYlRON21z?=
 =?utf-8?B?RzVZNk1xVytpb1VnWWdwWk9XUVVqbFBzdEw1MmdUWGY0RG1SUDVHTzc2VzZ0?=
 =?utf-8?B?UlJKV1BxQW1uWlRFTGUvOEJLaFI1bHd2cEhTelRDRHhzWkc5djFQVUdMWWpp?=
 =?utf-8?B?TVRIRE1OYjNhYS9BVFNyaC9YVnllVjhXbXFyRDd4SXM2aGQzaFpKZHdZVDk3?=
 =?utf-8?B?NDFTRzlsK1VZVEtvcW9aM3dycXNVUjdmcWJDc1VLVUl3NnArUjRzOGMvUzVz?=
 =?utf-8?B?b0tWZlJzQy8wTVQ4Znc0NVM4cVI4RDRZckhtOWlnbTJDVk5qVjJaVW5WNmw0?=
 =?utf-8?B?Q3JpaXAxaUpUTEc1aWdpRWVhQithRmMyNDhpMi8vMXhweWVpNFlMeGM4dWls?=
 =?utf-8?B?MkFZSHYzcHpFdVJmV1J2dDVudy90UG8yNXZvaG5BdXpiRGJCZ0pCeVlEYXNU?=
 =?utf-8?B?VjN1RnhLYmQ0ZVRJM0NvYnpJOWY2QnUyMmMzdU8yNSt6UEt4Z0x1T3Rkb0Iw?=
 =?utf-8?B?WFBqTlBzTFhtQXQycTh3K2xhOGt2ekdJaHd4aTEwdTVVTkEzaDdEbzFOQStI?=
 =?utf-8?B?YVFWSitEOE90TFAxYlc1Tk9ub2lZaXJuZlc0dW91TDl3Q1JHUTMyOHlrVjVJ?=
 =?utf-8?B?K3FpUndQeFUwYjhtZDFyTXpxQ3poYUI0RDB6TklRQXR3a3Q5dW15cTlxU0o0?=
 =?utf-8?B?TGtGcWVmUTVjS2JPZGJnYnc1Lys4T1pLZEF0MDVYSHoyajl1MVoreDJpT25H?=
 =?utf-8?B?bG5YdlgvUWc2eWNDczFUUmpsUzVYWTluRTg5aHF4aVJXaVdnZTJlNm5Kb3o2?=
 =?utf-8?B?aWhhYSs5MGtvbTRLamJzOWZCUitDc2ZGUXNrSy9td08wTDV4NjZCeGI5TVdT?=
 =?utf-8?B?MXh0NzJCN3VYTksxbVdSQWRwMEV3VTJBcks2cHkwVzRTK2o1amttajZ0MTV4?=
 =?utf-8?B?cjdaTXUyMmpLazY2QTZnaHBJMEdzbDNKbnpicWRGQlE2VHo3WXVYeks2M0pG?=
 =?utf-8?B?UUN4YnBHaEN0ajJEN1pFSzhVRHJhNnNackwxRFBwSHRzRnNkeHpsd0NxZUhw?=
 =?utf-8?B?VkdHdFZPeXM0bjd4K0pJb0Y3Q3BBYVkrVVJLaloxQnVBcXRTUGo1ZmR5Ymht?=
 =?utf-8?B?Y3hIaWhOTHAwbG55dFN0UFArQzJEZ3Y3emNHK0NRd01uMzEzVjlzbkRLSXBn?=
 =?utf-8?B?SVdVeE8vOHZtOUltV3NaVXk1ZnBZSkRoTi83NCtmR3FhVGVISFZwdHZJRExp?=
 =?utf-8?B?Nyt1TDdDam5jNTBvVnpadzJ1MTdXTkVuaG1tWno1M2JDRWZNRDhUaHRQWEx3?=
 =?utf-8?B?aFFvbktuUmVLcENYT0NROVpFUWlPMkRTM0dlRXl4QlJEMmkxMnVSMFZya2JK?=
 =?utf-8?B?V2pqbHI1Nnl3V0dvbUxaYVNmU2pQL2kvVWJxOCttMXI0OGpzTGpBQ1d4cFR3?=
 =?utf-8?Q?WJVmk6EPV/5HYSFwBAq4FW7Onkrqej9eqAbUEdx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b59f6a-2351-48e6-b2d0-08d903646b6c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 18:53:28.4420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ffBRkm2pNRVI0JHwk/z0Ye7qNtqBbUq0e4Aj5oEDxmx0EMEzJRUmF//GxodyoFALXqig9VBjjRVld5VD7fDSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2021-04-19 um 1:22 p.m. schrieb Alex Sierra:
> Extending this timeout will prevent IH from storm interrupts coming
> from SDMA while a page fault is active. Currently, on Aldebaran,
> handling that many interrupts can take a lot of CPU time
> (up to 4 seconds).
> This eventually causes timeouts in other tasks.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 5715be6770ec..823a367990bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1109,6 +1109,8 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>  		if (adev->asic_type == CHIP_ARCTURUS &&
>  		    adev->sdma.instance[i].fw_version >= 14)
>  			WREG32_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);
> +		/* Extend page fault timeout to avoid interrupt storm */
> +		WREG32_SDMA(i, mmSDMA0_UTCL1_TIMEOUT, 0x00800080);
>  	}
>  
>  }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
