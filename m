Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F7606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pS9rdsoX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78ACA1122F8;
	Thu, 29 Oct 2026 14:01:38 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7588112319
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 14:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JneN4RXZ7oZ7KCk8/mZyjExDfZVhoz7GPkarNHqnHAxZmoAM1Ikd264Ay2y5K7uLsLjpyUVwZE8vElyQzn9ahCnkSTd0FQY+8swlhdML1kWQxR/8h4GU/zRXt9gs1iJBu+ttI+y5KR/9XPSn6RQ0MAtIPUr+rZHEO+dvMFA6HmyfL7Q5QlmtFhdAKS9V1C5awPvvzzX1TKFKo7PmcVzfneK45Jn66wjsZcfN1id17ajYZCxdQTJuIzTFMwve5Hg4nbhgO7lWFQ1/BQZen+RN9KzSfpw3EJ1JqBvhugcuYjs3Lm2xkdpz/pihMCtznqxr9JTwPQzreUMMKR8od2q+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ/vNJxfzLQXXxCTh3700hipA+QJEwhtNLRqwGM99+M=;
 b=OKnqXGzte43YMECF+5SmK1CiWKe43jANnVxHjHReiSDenHPeLfR90po3X7davByArUP+i4cmBxXq4AQm2ZwOqvOfmgPTyFY+wAwQLceGRZrNgMeQvhVF4u70pcQSCEW+VMqpJcL+lc5b2qFXe8Bzkb3eLuXP+HzyDOpzMk/2okPx9ZXhdxEAywo6Bv0eaqd0KBHCqtf5wVM0iXrFXcpjKORvEwDmBBTyoi2WFbCXrAy4Qcu6Q07UTEBn/JuziHN0Oj9Kx265RINeOe2M8Z9S7pSwgr6stxQpGal4yPdXLWGYDdWXSCLYQi/lbi/+vRXa0jrp126BANIAd+LjKVOSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ/vNJxfzLQXXxCTh3700hipA+QJEwhtNLRqwGM99+M=;
 b=pS9rdsoXq0TEPgOO1VMwZ61808M6Uac/HQb7aodCSbRmgedE8GhE5MiGE5t18lam1VCf2wkj/BCM+QmVIz4oJ2/rcWFcdRvcImrbUImvdPz8KMiJLzvOB0yHc5nbuwSFaOdo5ZEnX4a/j8FH7PY1aSJlRRtApKxQ0bJjZjX6Lxg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:01:27 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 14:01:25 +0000
Message-ID: <eeec746d-6061-45d5-b26f-11b3e5586b79@amd.com>
Date: Thu, 29 Oct 2026 09:01:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu:smu: Update stapm_power_limit values in
 gpu_metrics for SMU14
Content-Language: en-US
To: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Pratik.Vishwakarma@amd.com
Cc: Veerabadhran.Gopalakrishnan@amd.com
References: <20261029135455.1822487-1-Kanala.RamalingeswaraReddy@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261029135455.1822487-1-Kanala.RamalingeswaraReddy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::9)
 To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: f646af4f-ca5e-40c8-c3e8-08df35c51f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261028144727099003|11063799006|56012099006|261022105027099003|261009223027099003|261026130827099003|261026121527099003|261021133027099003|261021130227099003|261026135527099003|261026140227099003|261021135927099003|261022113327099003|261022075727099003|261022115727099003|261021121427099003|10067099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CB7gvzCWDnBW/ekrv+ACPntwsoFT1Uz5ySUfAHVbQUm/QtiBopjq2BVzlAddcmuRgQg5gJ9HXF5T68m6o2UmBOTxejot3AJ2lXwN1AsLavDU4DLOzD3xpCr3f+pK8+cQODhJeII29dopIV3errc6OROpuNs1tt8ti9lB8UG3TNZg1tvWr6L8D+NMzyY5wfIh+CXQl89LCCcXnpcvFOyNMgKf8hJM8Jm7NmQpGj96mRQDVubj/doAUTP5ALgX3G2BRGtZ7/Cvkg1ZJjxg+BL3GytuXpGFgZLj0xi9AF8sJYX1eEpyhAG6u4/D9wleHuAKTmIcj2DS6lyf+gZGTjzctets15LK72PlQR9Ftxp08cQ8FM6TJquJw1dDwvZPmBLk/XBj/9pXwZCZQMjYSzZPEfkX001LfjkhJJBTGtGpuKIGba8nc0mB6o3LyoWWpXqibOAS/i/hC6LozvvbCsVvq6AIBlcTyPGVyaZwN+D5UKnGxqRBSj/i7Dy1oRVstBT/mt4HiQmZ6vchDudfjR646wLW4pS3NMGHPED8SUt3P/WQNz3TJo/Gv+1HB7DCfPoV041/mD4NDaZJDhNlUowp6/I2T93qBDn1ywziugMx+RUIzLhdYxKN/2Eo9Ilb7WwOa2ZjdrglZGtAqaD3RW7I+c+E8+vXVLHwQqQjXP7dMeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261028144727099003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261026130827099003)(261026121527099003)(261021133027099003)(261021130227099003)(261026135527099003)(261026140227099003)(261021135927099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021121427099003)(10067099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkZTQUwxWUltOFYzZm5xbUFNVUpxNmgyVlBUNEh3dTAzbUQwem1iTU02Mzdn?=
 =?utf-8?B?bHhuQW5XNE1lQjlycDZJcC9raG1USFBVNlZ5cm93d004OTBQNS9JYm1kMDc0?=
 =?utf-8?B?ZnpFejdtMXczKzdDRTV0NzFTR1Z1UE9ra0lLRzJSSnJYb3F1MklhR3dKWlJR?=
 =?utf-8?B?Y094LzRKeGVLUmFPZVJyeTlwMlJyN3JOMm94alNtSVRITEc1TzErK2JWVGlO?=
 =?utf-8?B?dEJRbXdad1hOTW96ZEgyNXNzWlBzNU1HUXhYN3FkQXNBK0oxKzc1MVhWWEVm?=
 =?utf-8?B?WU1PMDJjUW1BdGxwRnpXcDM3VG4xM0RNT2dmN1NmbHFxZjlraFV1dmJOcEVK?=
 =?utf-8?B?WnZtNDVCTklDRTFWTlQwdC9pemxBVXFpV0ZKeEx5ZVlYRG1xSjNyS0E5SHF0?=
 =?utf-8?B?c2JtQUV1d1VYYUd4MThHVGNCKzNGU3VBTUhlZUhrYThobjROcW9tb3piUHRt?=
 =?utf-8?B?VGl3UlpJb2J3OFZrSFdaK3RlYjJvVUQwSU5pSWx0MEdKVm4xWHRtSmRPeDcy?=
 =?utf-8?B?V0J4Y3BsUmdacExQQnB0cVZLL0dyQ0dKVHJHd3pxZHNlUEE2Tm9xRytmL1Zy?=
 =?utf-8?B?YjFoZGhadjJaenpkNkFQcklickJ2bjFRaEZkMUJxRUhTQndXQUg5enMxbm9l?=
 =?utf-8?B?QUVKSEtObFBHaTRxSjh3RzlxNEUrWTFmNzVFMlkzRDgzRjZTU3BSakxvYnR3?=
 =?utf-8?B?eXZIWGZwKzlqSm5lN0lCMGh0eEJsYXAxU0tWM1VWUWxRdERnVTNrLzFJbXpt?=
 =?utf-8?B?UjJ5NThZS1NGSnFGQ2l2KzAvMVF2NzRsWXVQeUJUam9HcFUzeTN6cWtlaFJK?=
 =?utf-8?B?MHFjZStwY0ZCWFhmMmw4a3RXSGFFODFGdEx1UHZCWHd2Vkg4MXBmZXNZYlds?=
 =?utf-8?B?OHFnc3FWdGJKcE1valpWTXFkWmxkeFlrUmFZOVMzMWk4RFQ2MXpraUxhRnRo?=
 =?utf-8?B?Q08zRmFnMHFzRjUya2JuK1h3WXFaNWlEZHRNeUJEaVA1VEpadGltRWNCWUU1?=
 =?utf-8?B?NWtoRmp5NzQxWnU0VTI3K2x2cWhma252WWpTUy9MaGVxSmZRUzlIMjZEVlN5?=
 =?utf-8?B?TEJDek5HRXZvbDdZeCtONjhQU0xOM1YzZVdSQXdrQUIwWEYwSjgwMlY2VXFk?=
 =?utf-8?B?RGplZC8vSVZLbG9VYU1FSEF2anhLdStZM1p6TXZYVlRiVG51UmxOTDA1UllL?=
 =?utf-8?B?ajROYzVIUEZGdHBwamY5aVhmQzNYZ0pyQmVMWng0MXNhNS9WT1hSTy9iUm5J?=
 =?utf-8?B?cCt1SXBNbHFXQTd5ZW44MjMraGlIMWJrdWVTb3J2azViQkU1bUlnTEg1aGV5?=
 =?utf-8?B?RlhwaWdhb1p3U25sektTSENvT1JMbmVYeFIzcmpiT2RxWG5UYlYyMHptN0Ja?=
 =?utf-8?B?TGpZSzN0c2Uvc2V0QlVNS0pyd2FRQ0hLMWFzUy9FbUxhbldCeUFnNit2YTNv?=
 =?utf-8?B?czdwRHJ5dzhvcHhmWjhtMTZhR28vdFBJaEdOczJMTU5RL0lscXd3Y3hsaitl?=
 =?utf-8?B?VTRxOW9sR0w0WTMzcm4xd3RVcTg3bjF3am9tK0RZVGNkMkUzZ2hJaHEwamta?=
 =?utf-8?B?N0JHYllwUFFaVmZycWFteVhCdjNRSUluMzZwSUg0MTY5V0RBUStKRmxlRm9D?=
 =?utf-8?B?NzVqb2NvZ1RWTThkNU40b0lQRHRpamhhMkZja1VyZHJWRXJHSUljZk1GT3hQ?=
 =?utf-8?B?aG40UzNxc2tDZlBsRkl4K0FMU3lzZkh6NlFsNzQwMWFQcGhVdGpxSHpwaWht?=
 =?utf-8?B?UTlaY01acDd5QVNXWXhVRW5qUjFCQVM4WTVjZkUyQ1pBa2s1c2l6SGhGSWFj?=
 =?utf-8?B?WkZEaHFLREFGbFZVSVZGRjJxWXVzcDBTRzZFUS9IMHVxUFZMeGdobENSQU15?=
 =?utf-8?B?UlRrNkZVS1V6Z3M4eXlXMlFNcDA3WUpkZGpDV05zTTRLTnJqOVJ1ZWJhTExx?=
 =?utf-8?B?bExydGZzZWVFbGx2QWUvajVra0hNMnlRUnhMa1pOR0lDQWhXOE93cG01aExp?=
 =?utf-8?B?YStXaGNKdGVGQmtUeG9McVE3dzU2YXVEdDhsRWhmZzBiSWJTR2tQQU1tWkJX?=
 =?utf-8?B?TDQ2Z1o1RVBDQ29EdXRlM1dJWnFNVzNlcTJXRm9IbVowNVh2MjFYZGN0R1hT?=
 =?utf-8?B?Z0RDQXVoYThpVUZhQjU2ZGZmeDB3RS9QUTlXaHZwODJjdFVqYVdWRllkYlM1?=
 =?utf-8?B?U1NNZnczbHUreHNUQThCeHRidDRRM2R6M016RE5PZmZlbTZKZURKSmpGTHFq?=
 =?utf-8?B?a0V4RFFmWEk2eTh2U0Fmd2Y1cUhlS1VNcVUwOVhyQ1RaSUFmUzRVL1krUGpy?=
 =?utf-8?B?VlFNNFJwQTlRUkdXeUxVRG5pbkVyT2h6M1JwVXkzMit6QzUzdGxIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f646af4f-ca5e-40c8-c3e8-08df35c51f1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:01:25.8823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKkdhTpqEasVjQBfXgTjtUTNycPB2LANvRlIODj3pSIwXJ3+j5233SZ4pBXSwGihxmFG+LvGLPSYXeFJetZttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/26 08:54, Kanala Ramalingeswara Reddy wrote:
> Allow amdgpu to read and update stapm_power_limit and
> current_stapm_power_limit values in gpu_metrics
> for SMU v14.0.0 and SMU v14.0.1.
> 
> Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index c83c58d5a2e2..94e3401b000a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -637,6 +637,8 @@ static ssize_t smu_v14_0_0_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->average_dgpu_power = metrics.dGpuPower;
>   	gpu_metrics->average_all_core_power = metrics.AllCorePower;
>   	gpu_metrics->average_sys_power = metrics.Psys;
> +	gpu_metrics->stapm_power_limit = metrics.StapmOpnLimit;
> +	gpu_metrics->current_stapm_power_limit = metrics.StapmCurrentLimit;
>   	memcpy(&gpu_metrics->average_core_power[0],
>   		&metrics.CorePower[0],
>   		sizeof(uint16_t) * 16);

