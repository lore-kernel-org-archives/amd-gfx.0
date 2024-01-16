Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A54C3DA79
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 00:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7F510E3CD;
	Tue, 16 Jan 2024 00:03:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E8710E3CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 00:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCgK3e+ax51pPN0QxCfCi510rlH5KJ3LkDRvXRh38JyqxCHuzSTmmQeXAMUvrqkRYkjt3KrsvOimQxlRwliCSIS9G/lV4MxHq+GcP61kBO/oMQJbV53GBZ53XD4Q2aaoDVaN9kgSbq7S2sqVUogIVsfMCz8mRKXqqKtetPXHslfkTplGtEzilBc+4xIl7hyrmK4oFT28S6eLcpg7qrifRBrl0KNDFEAyWAUWEdsbGMXVXAnhTfgNMEoLFOzNRF4MsB0Prn2dkRjUQVPYIMw+UlNNoi305CMtFtWYLWplahQtLICK3PqVIRL3S7fLLzPXoWNfwAFxoqry1p/lQ5jHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTpTsPXkd5kNwoYNHz7FZ1uvj+TMOtzNFQ402yhaXxE=;
 b=Tib3oADo0n/onyM663EOKoSnnzyMiZ5gNbUNJAh20z0ci5AOOdDfvFaCa6miO/q3e3m6cjnLb+0gveqBmZu/B2j66i1bqT3EtsrJR3MWym7/bnFenPvacWTLP/2lAumFmgojSASPZaHCp/IG2SFV9Kg/VGQVGsiBSDdIEIk3cH6XRDZPyugDdcyRRVWqjcvJsyzIMrw0hb9IoqAPM0DMeEgD5T2sAwOaRTvHbwKSMQ1A4YI02nXKH6kTCimU5X95f49oWnkyn9dOrfrmrUbqj9taF2KKNVWaw5JrQWEg3z0P8hcaxI5EbcHuxQx06OaBSroKYW8Yc63oj29mLB/6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTpTsPXkd5kNwoYNHz7FZ1uvj+TMOtzNFQ402yhaXxE=;
 b=uOFputqO+qtxWdOUmsR/Zq+gMNMHfR8wOZmFb24YrpVocS6VaONy/wMRuz3QiUgfwRuJzy5smCIyGt0uF8qq56+ageOOPYpdkLruQJWOIbyYybJRFrLAfPgQ+hfnZyp8nQ7kRhL+GYcq5+j25wpHCRyLY3imaaiuxf2CjbkKKzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 16 Jan
 2024 00:02:50 +0000
Received: from BYAPR12MB2600.namprd12.prod.outlook.com
 ([fe80::8323:ac7:8a82:64e8]) by BYAPR12MB2600.namprd12.prod.outlook.com
 ([fe80::8323:ac7:8a82:64e8%6]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 00:02:49 +0000
Message-ID: <aa8d4d01-bd3b-1b1f-66db-852fec75add2@amd.com>
Date: Mon, 15 Jan 2024 18:02:46 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Correct partial migration virtual addr
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240115220026.11436-1-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240115220026.11436-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::19)
 To BYAPR12MB2600.namprd12.prod.outlook.com
 (2603:10b6:a03:69::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 98263455-cc49-4f60-56c2-08dc16267a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vL3HjUWnoF+JhvcjeSUowxPtS1+27foB5iScJKACKgOL9tPUn75pcC5skXq051JxoGb0CPHCpzpVTs3xeYypzjDEZ1BRHf6b7QgmWBsURxMMw6KsBGuk4ADH4NR0Epk2Xx0CARROZgD3V8pH7jSbgeP8LLNuw8YFW0OhAbUwsabaFdGXYjWCWftQm7m9rT8dp6M+kA4I8+mcXiGuHjfHZDSFWpny7wBYRvRgmUYIpZk7O1UdJh3tfB6e2elT8JrUB19riXvRsYs2hLXP5VgNIgVrQt66sq3J9FMyO3X/xoXH+cR4l6UsQYcMDKu2fpRnV0VuZaC8abcYefUl0tsEzlSHbAcnkD+MCrEKh1WX7CDOQVHo3uJVYyx9KwKMaiI0s2vhu4cKfJZP8gMiTEYXCsEUivDfQumn1/CHJF5kbOZr+UnJf8xJL5Jy8h0aj79tJtbwsmQIn+WLr57ItYbXfNRR3hvNPYCpMCgbLViwCDzGY73RBf7brhvpy3HA+nzNi01aHSfjprXdvIkKmJhdlFH19YRNz1AleW5ZwS1EkgxXp2+Zif2EBSQOFqWUjvU7HQlfxWQb5Rlh9Hu6Hi1KKMJLA+NaBm9KaBRRTdXrSQFTeg+XVsSPYgpDyWgAlmDoST6zmDheIB9v0bN67ajuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(83380400001)(31696002)(86362001)(26005)(66946007)(36756003)(478600001)(5660300002)(38100700002)(53546011)(41300700001)(6512007)(6506007)(2616005)(66556008)(6486002)(2906002)(66476007)(316002)(6666004)(8936002)(8676002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDFoZzJmN0t2bkRGZ1V3bVVHejNQSWV3UTlKSFdYNkhXQldYNSthT05Nd05v?=
 =?utf-8?B?MnVIU21SdkltQ1EyQWFyWFp0YTNkYURacGZXKzJ1SnN6ZDlRYnlERGdISFdS?=
 =?utf-8?B?VlJHRjJ2emxZcDBJNUxOZG5GblRnMEkyWVhzSEd6c0IyN1JWOVU5SXVDTG1G?=
 =?utf-8?B?bUpnVUR5RFI1eElhZy9rYXdWdGhsdTJISE5KSGVacytGUG1vTjhIVHRmYVUz?=
 =?utf-8?B?VURTT1VGUGtlaENXSGNtTERwVmtEdzdPeVpGODh2TUJvcmtJbXBoeGFmeUJH?=
 =?utf-8?B?WVJnd0RncjE1cmJkZVpGSi8wc0VBdUxzK2VnRmFGSUZhbmwxZU9COEtvY2xL?=
 =?utf-8?B?ZXpEVnRuZ090SmxHQ29ybjQwOVhRZlRVTlFEcGIyYU9QY3JDZC9NNzdCeW9w?=
 =?utf-8?B?bTI3Q3d0V2NQem5ndHBjWE1DQnJJM0QxbUFNaW9ZOU5VVithM3B4QmNOVlAw?=
 =?utf-8?B?MFJ4VlRzOFlidEYvcGZOS09OK05rckw4VEhndGxRWjVJbW9kSGM2MGh6bGJn?=
 =?utf-8?B?N3oxUy94TnVvUHlJdkh2MEV2TWIvYy82U1hTUkdHaTFsd0FLZGhlNHZJNGhl?=
 =?utf-8?B?THVrWlk3NTFpb291b3N1RWVDMmV3YU4vdXc0ZVBhUkUxSFN2MGgzd1VDaGRF?=
 =?utf-8?B?QW1QRTRmRk1zYkM1MkFDRG5OSUxUWlNQclpnZ2xjL2VoYWN6RTFMdDh0anl6?=
 =?utf-8?B?VGNXRENQaEFhS2t3a1R0NUsrQmV5czBpRk54UFRQb3BlaUNhVWxvVDZxZSt6?=
 =?utf-8?B?d0MzdWU2Y3lxWTVsalJZWG5xZVpvRHBQbTBhMEZNRk5KUEtveVlncVpWaENE?=
 =?utf-8?B?dVpONm13ekc5S0pkTFBhQUxYNXMwQ1EwM2UvZklyYWZveUxlMWlIMnFZYVZs?=
 =?utf-8?B?cjRoaHc3VlVneVpOQWoxY3pUckpOblR6bXJFNmFVR0xJUWZscDNmRkNZQjZF?=
 =?utf-8?B?cjZ2TUpkVnY0SlB6Q3ZrRWIzeUxXcnBTNVg5NUttL2lxUlRlbTJQTnlYa2xQ?=
 =?utf-8?B?L0prdmR0MVhIbkxScWVVb1ZNcVlxM3lCT3FrVE1jSkkrNkEzaEdZaE0rUVpa?=
 =?utf-8?B?eEJ3ekhUWkxTSUZzU0FYRzVBV1ZvSTE2S0dJblRESTU4Y0ZBVDk1NHB5anQ1?=
 =?utf-8?B?aFg5dzhKL29RbXltSXFCTmNlWWtiN2Evd1BHTEpFUmRFY082S3Jqc0s5L0Zo?=
 =?utf-8?B?UTNBUDdkdmoxbVhXd0M0MFRxT2xMSjZzVmZDVHNQR2tqOG1SYTk4YmdvNG04?=
 =?utf-8?B?a0wyWWk2VFk3WStiU3lwcTlsdmVJMnlpNTJVODlJV0ZHR3RsWnFYYUNEVkFr?=
 =?utf-8?B?WG1zT3V2T2NGd2FlS0Z1bVN1MFJuWk9ybnZoZkNvSVZZVkRCaS9IZ3lCSlpB?=
 =?utf-8?B?OTd0ZHkvbWcwQ0NFaDhVTG01ZzNvU0hldENQbnRoNTYrMUpIdXl0cUVwWTFp?=
 =?utf-8?B?amJkRW5EMWc3TmdVeDBsN1htdjQ0b29aRjJkQlRuaU5ISXVzRndVdUltOHBS?=
 =?utf-8?B?TVhPYUYrRnlhcW5EcHpuL0l1VXREYVNXMG9MMTVRaUNOSmFVN0prbTNka2FG?=
 =?utf-8?B?RTlwYW5rbXcxdFNOTGsyMnpjdkZIK3B0ZWNJSXc2cG1obkdwUUtKT2pRbWVj?=
 =?utf-8?B?bm44UmY1R0tXN3dWU0NsUFNqbW1lbSt4NXZrN3hkQXRiRUFlZ3FDUHl6YTBX?=
 =?utf-8?B?SXZWM0p5azRmVmRyTG9TdHpPK2c4SFdVTnRsb3RwOG9tQXZmZStjamQ5TXcx?=
 =?utf-8?B?bWpWWWJhRmpKWjNjc2hqcHlVUDgyT0tsc3U5ZWdHeWw1UUdrL3Nqc1lTbkpu?=
 =?utf-8?B?cUZ4WittVHdMSW1HQ3NVbWR2bWp2ODRZVjF6cVhvdTcySUtnWkxmMlc3VDZK?=
 =?utf-8?B?OXZKb2UybkNoTkhybFZpQzd0cTI5U3VHRm1VbkpFbTNDS2lsckdZcFdrT05Q?=
 =?utf-8?B?UXJJa0dUR2o3K25qRG9idlFKb1NBTVJ1VFRUMUNvMjI5MExWZWIwS3ZmaG5o?=
 =?utf-8?B?RVZGWHpuamFGdkN0ekViT1Zxalk1a2RTYmZyYlFJc2ZDa21kSC9HWFNBcVor?=
 =?utf-8?B?eVIvUURNU0lXWm9VN1NmM2QrVDlhZndDbWpvSk5zNWd1VWFiclR0RDhlWGI1?=
 =?utf-8?Q?4ic4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98263455-cc49-4f60-56c2-08dc16267a2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 00:02:49.5931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSSRQKPND0w1QSbILsNwJiuoisrAg5EG+b9At9ZFEbrYkaKHGBLInuSg8oNuTNhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is:

Reviewed-by Xiaogang Chen <Xiaogang.Chen@amd.com>

On 1/15/2024 4:00 PM, Philip Yang wrote:
> Partial migration to system memory should use migrate.addr, not
> prange->start as virtual address to allocate system memory page.
>
> Fixes: 18eb61bd5a6a ("drm/amdkfd: Use partial migrations/mapping for GPU/CPU page faults in SVM"
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f856901055d3..bdc01ca9609a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -574,7 +574,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
>   		 prange->last);
>   
> -	addr = prange->start << PAGE_SHIFT;
> +	addr = migrate->start;
>   
>   	src = (uint64_t *)(scratch + npages);
>   	dst = scratch;
