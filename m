Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0A606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=K03JUfca
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCF210E208;
	Tue, 20 Oct 2026 18:14:36 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D91610E027
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 18:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNpzD8y0DHzcW1hyNGcgZ6bAe9gHfNR1T3eN6cB96+u4AQYkRdMsTU2LiabbjN417Zey+Eueqs4QuCs3PwdqzYi/ciMwSCfSHiw456yUeNsnecroxrM2Dug2otpi60ShPbi/wfat0HWWW7T56yVOZeBhFjzMkAnsxkPmCiVYfZ4fJZYQz/0WoUjRSDoqyZHkyvCw7Wv/x51K6Gkw1as/wrXkK/hRDSpoKvHR9YHzLuoiWxCNtJcBxPQHEpTgi0yCjreRh8Q/WQtR36FTzThVjrh7cehESHPOFE5YlFZa7M3w8uzVUEnE6UiAYi7YZhI0LuEmMLHe3mcd3RLYqKafgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IMioFxW1I02+y5ShxjHnP7k7vsZeUCt+sfnwt8EwoU=;
 b=PjM6vR+URLaPVgVjyCnZhZJILAc7nOnP1zJJAoP7LJT/JLWdAi/T+0oRS8TvVcZjAv0xDxXgWpSjMXJTS6YIizulSkKrCp7YC6QqgDCKrSr8MgoUsedGtQx1LwmRRnUUq3Q37nKmaEz8Mk06zNifaebeL+/zSF4WrJglYKGPQsKMZLJdsWBfSrRY4rKe0bDZgpDoBMgD9w23xHztQdzjM1umA1lFlk4KuJxCSM19bCXwvmXOjMMJSZUoXro4fx+OUSx6fRCc/dt/6D9KxxHear0qUZTKswqcRMfcAwoGMtM4437o9vusBjVKj820jdw8T3UAc85CQkQIfKAYAVadcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IMioFxW1I02+y5ShxjHnP7k7vsZeUCt+sfnwt8EwoU=;
 b=K03JUfcaXSqXA8o57X3tcM3DHNJfnjEPNI/BN5lz4FdP4bhdj4xKRkBKBqUZt1nrhnzVRW3fltsJOydTYKakHnzqZ3dn++Fxz74feXzMle5KvJNVpBDpfDX4+6f6cQ7Zq6xLy5HI5ZEvtQDqgR1YeNjRVGC/ymTp+Cj7q8VZ6GU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by DM4PR12MB6421.namprd12.prod.outlook.com
 (2603:10b6:8:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 18:14:26 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 18:14:26 +0000
Message-ID: <60c8c3f5-553e-482a-9cd6-108f9bed487c@amd.com>
Date: Tue, 20 Oct 2026 14:14:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Bump KFD ioctl version - SVM no access
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261016232458.3343066-1-David.YatSin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261016232458.3343066-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0471.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::22) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a65eec-40fa-435a-a052-08df2ed5f979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: ehW9QYFZs0nrdTBC/vFWbn2N4QvCRQHTziK9n/1cd4Y+fABIJoS90goewxHEO+zpPYtSh1pInuImYf+XgIfrHLWey0SKFDY7ckf/vezi7gHz2L4pDE4cZJHeJd3reypbuVBN2G5sKipEYItjuK1SbgP6vtPSpjbtzVmvOdk1unbV9CH/9v/mR/rW3es8I7Oa6dO0/2RWMq6YLJGEtA7wjzPX8mUsmy0frhAai3/zB6MorrTQiT1yMcM9nFJYwMaECGLmId38HCbJYxP6xJEBDgc6VWxPSEuBKkQBsgvWhr7AJ1mU65mTVJSxA2v/1PeSI6MK1sggLar5Wb8m+DQZ7Td6We1NTCFQvwHuWfEkG5G6B8FFPPlN2HbGbaOKDLvFj3+2wfHrK23/OSOSXyVX4YFw3/ByZMbIHYuN7E09o0nn3ZhpRYjhAiJEmakispG+px/nT3r4pdqWUQMGbRPqmLRcJ7FX7pU7RT9hfwuJBXISJ4vBK7K3R9n2fjNgwQxgxkc1nDYRPvIeypAgObpMejtSGYguTCTz1+iQDG+ntbJYcFG+loznrPOgVIaasdKupYHSIJMsXBLOniw9wUC6GgtIuamRJfjNtgftrbtuxkR0y4blirwI1F5RcvP1KC6MDznStqtKH27PcWskW84mxH4GYzOUeTzbPyEnAMiFC6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlljQnFCWmdza3o1TklUZEJ3c1FPb2tKTE9PQjJweW5CZC90cUVrbm9BWDBT?=
 =?utf-8?B?VjVwbWtVZUdXTkFuVUloaWZjV0dZM2lBclIzK1JiSWFsWldsdk1VRzBvdjFZ?=
 =?utf-8?B?Zzdvc2llbmU0NmVzMW5GaVJaOCsyWnZpMnZtQWVOWVpLckFnek9kdDgreTNk?=
 =?utf-8?B?U2M1aVZNNW5HOEord2dpMTVjcVF5VmxSSUFTU3VCRktyVlR5NWlnUUxqZkRU?=
 =?utf-8?B?Wnc0UGU0NzJ5RlEyZXAvZ0syeTQrR1pnNFRJSDEyYTdOaGo5SHVDQTFWb3p0?=
 =?utf-8?B?R205T0FpVG82SGVKTnViOTBuWUZlUXU2dDh4ZzdvWTlyMnJmMnVZcFFHQnVZ?=
 =?utf-8?B?WlpWeGxMNXI2VnVyeWdvcWQ2Z1lmaVV4N2NnTWxsQVJ2MzVzZEREQzh5QXYr?=
 =?utf-8?B?cS9yTzh6RTdEMkw5ZmkxUHlyaTdRZkJVQTRiQWR6VldJdEFIUTVkTHJPVTVw?=
 =?utf-8?B?Zmh6Q0xiM0RjdnBqUlFYWndXcmxYeG84emdKdVVPZmJDUEVXNHBWRklaSXVD?=
 =?utf-8?B?VzdKR2tsSnAramFIY2dnUGxYQ2lITG9tMWpTa01xSFY4SWl0WGNqRkdCd25k?=
 =?utf-8?B?RHN6aGM3MkdBTDNidFRJRitxdnk0NzhOckwrYmJ4ZEVaWjVVaUpldmNxQ1Fx?=
 =?utf-8?B?SytLcmlWVXlXZDBreVJHcC9VejY0REJOZUFFRVBqdHpPTStYSktvZVVXNzV0?=
 =?utf-8?B?Ym9hNDR2QkpUbW0rd2wyS3RKVjdlK1dUY1BNL203MnNYc2NJTzhJSklkT21k?=
 =?utf-8?B?bE4xSnJwY3ovcnd6U2ZxNDR1YVBqK1ptOE9BanVGeHg1WExkWXp1QmZUbnhZ?=
 =?utf-8?B?bkd6aisvc2gvTWNDa0E4VWgxL0JaZFdraElNUHkyNXM5QitsN2ZjMlMzR1Ra?=
 =?utf-8?B?dGJMSEludG5JRXJ4VjRuVEI4SmVZa3VoQ0VaKzdRa0g3T29PRHRVMDhhUUxt?=
 =?utf-8?B?YVZxcEZHbURkTEJZZk9ydVp4VE01THlONVlYT2hlQk8vNEVCeWRsVzNXRC8r?=
 =?utf-8?B?Q01UdEl6SC95cVA1cGJQM2x0b01zVFRINVpiRXJYZHFBRVlQYTdwb0NEdU03?=
 =?utf-8?B?dGZDa242aW4zWVZhL05taTJDT1JPNW1HQm1tU0lkL3htN1p4UkhMMVgxWkdQ?=
 =?utf-8?B?Qi82L2dZQkJyaVUrblFCZUdlT1pOR09PMnlRYUZidlBoUWlBOUx2ejM2dTdo?=
 =?utf-8?B?M0hwUkR6WkNNZDdjTWdIY3AxeTBuVUtTVmpaZGtsU2NYT0h2T3ZudTE3c3Jl?=
 =?utf-8?B?dTFrVnBBZHRBakw5U2k2d29mR0NPN2xJWTcrNUsrYi9TV0kvRjArRVBUbUt1?=
 =?utf-8?B?YXBMc1JEcTY5WS9GN0Y0ZG16L2hYYkxMcWR4bEIrQ1FQMzFZMkh4bnFzTDBI?=
 =?utf-8?B?cnN1WVFCWUM3eGVXd1g3UmFXNWFoMlUzUVozL0VnRXM3U2J2aVpiRGkzcDFk?=
 =?utf-8?B?RDJBbjB0elkvZjkydTVCRGFCdi9hdVd3b0FGVFFaLzVrM2VlVW5RaFdnZ1Jo?=
 =?utf-8?B?VXBhcGpGVzJhSWdXL29qTENZQUFSaDU4MkVSOFRaSnptVXNJNXRtcEMwOVRJ?=
 =?utf-8?B?bjVpdkt2b2taWEJnRzZZL1FrVVN3VG91RGhFR1lLa0p6Szl0WjgyQU1zU0Vk?=
 =?utf-8?B?Z2l3QVJyYVkvY2EvOWpMdXowRjdad2djREtyNHh3Nk5WbzZpRUdxMVBZdlBC?=
 =?utf-8?B?ZnQ1ck9HRTVCT2Fsc3YyTXhmSGtsbXBaY2NocWk0M3NtbHlSZEF1VnZFczF0?=
 =?utf-8?B?OWllb1BtUENMSlRVQ0hyOVg2ZWRVekxMRlZEQzFJb1lGeUdRT045aURheFVL?=
 =?utf-8?B?NUU1bXNPMEptTXYwMjhoQUxXZWIvOS9SNXdKank4SURVUWw1aEhIK0FjSTZl?=
 =?utf-8?B?dS9ZZW0zQTh1OHgyVVN0c3lDWXlud0xjcmRZM05IdEo0aTV5b2ZSeU1odHpQ?=
 =?utf-8?B?VXlHMHFsVVFtUVBwczlxT3VqMWJlc2luaTcwYkllZlFZZTJvaXp6a091YUh4?=
 =?utf-8?B?T0lXK1N4ZmJSallCNnhzbi8reWdZYmdYVVZubkZlbDNpRXRTdjhodGgydFZ5?=
 =?utf-8?B?UlB2bDI2N1FHQ1crdmdQN1JrbDQ3S3kxV0RXVit6WEYySzNaVHFWYmNTdmdt?=
 =?utf-8?B?MHNlMWVBbGkzTGhLd3ZyNFZ2QmVHc1dPaTU1MVRabFdsWXltdzUxRzR2UGtO?=
 =?utf-8?B?TUgvbXh5SXArQXNyM3p0eHZQN0pteTFBNEJGc0M2Q1pkN2NYMU1PQWl5eXUz?=
 =?utf-8?B?WHErd3lzL01SbGlONWRWc0g3T2tUTDNLMXh2RHMyOWZWVGtSVExLLzhTUm5h?=
 =?utf-8?B?TG9BSWVob2JoTHVhMWlIb0pHT3ZkYkJWU3FFTDYyZkgvekFaMXJuZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a65eec-40fa-435a-a052-08df2ed5f979
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:14:26.0495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BarBcNq1l8rMpI8qLG1QXhfCmuQ9F8pmxBDecSJoDZfYVR8TNsasToOPR8lCNOwkAiD4/KhFFKtawNd4YmeN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-16 19:24, David Yat Sin wrote:
> This is not strictly a change in the IOCTL API. This version bump is
> meant to indicate to user mode the presence of a number of changes and
> fixes that enable setting the SVM no access attribute.
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   include/uapi/linux/kfd_ioctl.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 749d196e2114..564faefe6978 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -49,9 +49,10 @@
>    * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptions
>    * - 1.22 - Add queue creation with metadata ring base address
>    * - 1.23 - Add profiler control ioctl to enable/disable profiler on a process
> + * - 1.24 - Enable SVM no-access attributes
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 23
> +#define KFD_IOCTL_MINOR_VERSION 24
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
