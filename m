Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B11C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46ED10E8D5;
	Wed, 10 Jul 2024 19:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2oJnBDf3";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4424410E8D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpvtrt3krgw72tKh9TPv8cwTENOTxC06tbvtXmFJ5XqZbDcG/R0B1XMd/ySlkupsyawwfhsClmga7JTMvcpVnh7WL6mz8/g2gNZ0K1/7+CyfYuCBqXl9lmRZ9W0mrGBqeyi8MV9DI+m7WzyPAN346EgODml4+MeLkzuNPe5Fyr2DV23hKVNy8VgQFk6nZwLJd84cux0BCvIqcY+KAcWPkPuhdao4osNeqI5Fjr1iS7+sQNSTsirBcdzGbR+jTj9w5hcVBuJoj8D2V8ExkM38zZyPUMq4eof1e8gITN62FCt7u/A4kTpyzK98l3jFyD6mzfMnwab+P8AnIaA+uz1MPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sHWBDpOEX0s2aMsbwxhgr8CkE34TUMa4XyRvmZi45M=;
 b=UHsAXuWwj5V65kSOTVHdTjXnDAyx2TcrFg0RiFxopl+xv42meIDMhy0NWanDKJxuRM2jG3Wrg/HaxRSAWTp7POAYAKR0xZUF8EAffhux6r1uoGXpI9v1bu4zWTJeL5ODYA1V5Nfmo7bZa8PqK6/dLrcVFmgg3fzCvD38Y/tqbiU7Un27zTWElRYfiy6CXHCkFiqD/OB7wlJZddBlQQBbwJgTkyyRrBQMa7AMM49zYSj9WXrC05mvpOff1zUJP8Y9dltzR+M26+dKK8JYodYivu+UtkmJ1j1lLjgiiYe7pcKGYL3aFRL2iQNZwPyjk1gyfhT86LyFkcSPfnFtKojAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sHWBDpOEX0s2aMsbwxhgr8CkE34TUMa4XyRvmZi45M=;
 b=2oJnBDf3mvVCbVcahWyhOsp348MJQFHpS3q2nNp2Ems51GI5CN7IrPPSbJNfaJTMX6QQgqaQORoAlm7OOz5T7HYWYOGEUerTjSq43I5ZZ44mwQCVIm4lMmsWLgpPnzhuAz8rPFPWQnA4coPdU2YjVjjMbl4ibqUsT73ZXw9pEuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:47:16 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:47:16 +0000
Message-ID: <2aaa99cc-9ca6-43b2-b5a2-59f0f573ec93@amd.com>
Date: Wed, 10 Jul 2024 15:47:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/50] drm/amd/display: Re-enable panel replay feature
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, chiahsuan.chung@amd.com,
 Arthur Borsboom <arthurborsboom@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
 <20240710193707.43754-30-Jerry.Zuo@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20240710193707.43754-30-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::22) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7b1a68-f8b1-49ca-89b4-08dca11919c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGhvNDBiRU9vc3JjZ3BNb1V6NzFVbXVjMFpkS3FvSUhWTlg1SmNNdEhzSGpG?=
 =?utf-8?B?NkZmRDVtbjI2NVk5eDc5T0QxdmVhVjZUSE16dmJMOG1aMnB1TGs5Z2Z1Vkxu?=
 =?utf-8?B?OTFlKzdtZXJ1NXVZTnd3V01QMTdXMy8yMzRKVmJ4L3BjZDJoaEJub29TL2Ru?=
 =?utf-8?B?YkNHTm5TakdKU0dkNjJZcmVZMnpYclcrMVhwMWNJYy83dUJEZjlxMzMrcGVU?=
 =?utf-8?B?em5kajg4aVowVTBMa0N5MUR3cFpkRVJsdDc0cm5idW1YTXFJa3N4MkVFdEQx?=
 =?utf-8?B?eXNNLzM5enQ5U1hXWXBQZFFySFZwTVRVb1dTZnFsbXBoVXdGbzZXTnlwK21R?=
 =?utf-8?B?WDZGbTFFUm9NTythZU5sck9rSmhKZTFDcVNRYWQwVU02ZTUxbmdRMTdGdmR6?=
 =?utf-8?B?UVBsSGhCWVpSWUJvT3VnYmppTmRDMnIzbVpNSE5ORDhpUHZPamZGOUFZQkly?=
 =?utf-8?B?OTVxdjU1Q01mMjk5T2psRlBMOFZ4dzJkKzJvTHN3bTl4VHY5RE1USzRVNmZ5?=
 =?utf-8?B?a3FRL3Yza0JPL2tCelZZa3dVRXFta3QzWVVXSlN4RFQvekZYWDV1SERXUDkz?=
 =?utf-8?B?V0NhcDdveWQzVFpzQ0RwdnRmdEIwMmYxZTFoZUVvM2t6MGNRTDNIL0xtMjAz?=
 =?utf-8?B?dU01ZlJuZ3FTekJoZUpZQXNXRGFUczkxa1dyTEpFQTRFNzEzYWFRSVROcXZx?=
 =?utf-8?B?eS9WU2c5Wm0yTXRlLzA4ZWgvM2Q0NkwzZUpuSmJnTGYybmloZTVDMmJueXRI?=
 =?utf-8?B?TVhySVRwckNWdE9mRGkxREJHdDFneW0xY0NsS0liNHBQbkRIazEwSjVrYS9Q?=
 =?utf-8?B?bkZ5a0xraWptK3dtVXdjYUFRd21jZTR5QXFhaXhnYVZ3L09UTDZ3ZXNDZmxB?=
 =?utf-8?B?RkljK3prMDZFdUVuR215bklFbldmcnNTZ1RMaVArSHY5TmZBc2h3WVRCSnF4?=
 =?utf-8?B?MnVBS3hwUkp4K1NucE41d01rUUtSSEhLeXhManJBdm5veGU0YitzV2ZhVUky?=
 =?utf-8?B?bUUrNGtXWlBKZ25XaUw4NW9LNXl3SHdkTVZpVzV3ZCs3RmtWRDM4VmNDVlA0?=
 =?utf-8?B?YmlXTGR1YkxSSFpSWnh1Q2czbWlDSU5HRE45bDBnTVd6ZXVqQ2tLakpHVkw2?=
 =?utf-8?B?VlVtTVR3N3NzcFo1ZkU5VWFuRmhvbXRURUhwU0Rob2hwdGpxT1A4REJiamJB?=
 =?utf-8?B?clIyWm0raEpWbHlaRHEyZHVnTGJob2JFZTA0djBabTNyYTVTWWYxdSs5dFg5?=
 =?utf-8?B?Mi9HN1VwSGwwL3NIU1Fib0RINkdvd2U3VTlCSEE4cVZUSUJkdzVwQnlYNThv?=
 =?utf-8?B?dllzb2F5VG0yR3JaUXd5NldQR3V4SGhlU09SZ2VUNHpWUHJveEFIWHNkT1BR?=
 =?utf-8?B?OXZ0SGxSeW1hbDg0bUhWaGRJMU9KcG9qWkpKREV0anF6MENiTnY3N1pPZ1Y3?=
 =?utf-8?B?cm9xUkRTSDRWR3JPYm9XbFQ0TENtbHd4aUFETndPZVJzd0Ztb1RHZjJjWmJt?=
 =?utf-8?B?OEZnVjJjc3JCWEJkU2Y5dC9wYUJneHk3WDdOWkNoZk9nU21hdlUyZkxRNXBa?=
 =?utf-8?B?SU1CRElTcFhaUSt6Rmd5ZXVNU21WeEY3dFMwcVkwck4vWVNXVU01U0ovbGoy?=
 =?utf-8?B?YkVhZnppZmRNRGxNS1FlQ2IzeFNmankyQ2JxRUtyR25LNXBFSUhFLzJzb3NE?=
 =?utf-8?B?VGF0Ri82YUxVLy9PTjlRVnlSdGdDU2t4N0lwSm5XWXJBVWk4eStvamhUVXBp?=
 =?utf-8?Q?6zz/X/9JpnvaEnI1yg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUE0YXZHMmdOelRNaU1vemZkdFZ4cTBDdmFjTUl3Mk45bTJ1aE9LT1cvc2p4?=
 =?utf-8?B?S05HblVEdWJDSVZVekZXZ2ZicmtLMXpReGdCSXM5OXp5WWZWQm9iWkhFV203?=
 =?utf-8?B?aDRjaEh5cW91TERoUkJRK3RqeDIySkI3MkFBQWpoRXRrOGl2djZGeGRITDNJ?=
 =?utf-8?B?Z2lId0ZTRVFtTU4yWlhSeHpWUUFFWmRUSDluQ1ZzbU5NRFVMVWZiOE12OVVk?=
 =?utf-8?B?eXJrWUd4SjRIaDl3U2MxNTIvMVlTQkUrMWJPUU5aL1F1MzVyRFlJR0hSbkl1?=
 =?utf-8?B?Sm1UNjVlWG5aMXJNU2xwdHFsRzArVVUrVEpmMmFYV3VTWUNNV2tuOVU3VkNt?=
 =?utf-8?B?MjduWlRiRk8wYXBFTStoZEszTnJoMDFDVUJtdGNZKzFVK3NkU3FXUDIyWGNT?=
 =?utf-8?B?TUlxcWFwdVNBUXJacWgvcGxiYXk3WWt4WG1LSmJYZ3Z3bExBanVMbE03NWZB?=
 =?utf-8?B?MXo4bE05WG5TeGpFWW9KVnM1bmsxeUhmMG5NR1U4bzBlaCtQZnlFZ2RKVmlK?=
 =?utf-8?B?NGFlQTVWamZjQnpvY3hpb3czQVdaeUx0SUE3bHdKdkFScTNpRUtnNENldVo3?=
 =?utf-8?B?Rm1YbVBocU00aGdKaEJmdk1SOXNZK2J5dW9NeEhYaFlOTzRQN051Z0dQVFBz?=
 =?utf-8?B?VmdIMnlxSS9za2RtNTZaSkI3Z0M0a1hob2RhY2lxakVzMzNhT0t0eXFUbTdU?=
 =?utf-8?B?UDZkdlF2ZXlRL3NBeE9obWVMeVZtUGJyOW9ibmZ4bkI5SERGaEpGZ3lsY2xD?=
 =?utf-8?B?clY1WEQ3TE1pTjI3b2FSZW8yNUxkc0Q5ZlNlcEtSTjVmdUdlbzNVa0doZTUr?=
 =?utf-8?B?NDhRR2J5NTBuTGRNcm1mMkZpN3dza2grVEpPOXJJQlBwS1lNL0dyc1U1Q2ZL?=
 =?utf-8?B?Z0tBaGRMUGhBV0sxa2tzbHJOZlIva2tsVHkzRGdmUWhOWWxtcTVCZmFhQnBm?=
 =?utf-8?B?OXJRdXlPWVlMV2daVzF5UHYvTGQrejdkQkFjYm43cHNMcUtOMzRBWnRZMnds?=
 =?utf-8?B?QVpTNVNnZ0s5bmxEVXFaVUJZTXFHNnBrOEdlM2ZqZGNPZkVENVZVS20yUlpx?=
 =?utf-8?B?ZWpyc2w2U1ViY2lyYWdlUlJjRUp5ZWtKZkZEVy90dzArQUxaSlcyR1IvQ0ls?=
 =?utf-8?B?cXdHdEh4YnErUFF1b0dxMnB4R0YvVTBSSUpFZGE4NjBvbUFoUjFINXdVQXRt?=
 =?utf-8?B?ZHBxN09YSlB4bFV2UHVCcHN1VFkyV3dld0NiQjBXSFBuY0pMeXg0N1JkM3R5?=
 =?utf-8?B?SDQyYjdyL0txTTloVmVQYUZWeTgzK09LaVd0bGp6dFdJVlVNV2diUWtvd0F1?=
 =?utf-8?B?aFI2d0svcDBSOHJjMDMyUG5MZGxBdVYzZ01hM0Y3VXRsRFVLaFRMNy9WS3Qr?=
 =?utf-8?B?dWQ0MFMwRm5LekNIUkp3VHVQcnYvUFROWXBjOE5HVFl2dkg1YW1oLzdHZHlh?=
 =?utf-8?B?a0F4T3RTcFgrYTRxWjZDeTJBSXlLM2dzM1l1VjhDMDlvT1lJVEJ6U1Qrd0xi?=
 =?utf-8?B?ZWxXZGhrb1BDdTR3SFNqamJTdXIya2tlMmRPakMzUnFQOHA2YTZLb21UTjVF?=
 =?utf-8?B?UVZPMFBHUVpHM1RQWEVaajVZeitUb3JLMS9ScmhRWUlzYlBnZk5MRFh3QjJ1?=
 =?utf-8?B?UGxZcjREVldjakVvd3gzNnlWaFZ5cEFaeHRaZFl0OENiaEZuS0xlMDRTS0Q3?=
 =?utf-8?B?VnlvdHhGTlY3eld4Skx5UDlCVGlieG5BampPUzgxYlpyTUNtUmdMdnpnMXFu?=
 =?utf-8?B?TTdUMWhrTnFPKzl6VzBZQmJuR1cwT2VNZ3VKUjVoVkZyUEgwWHpUYm1ubHY2?=
 =?utf-8?B?SDdPeGF5S3RjVFFGdGd2M1pEZk1CTUJjdkRHUE9CaTI0NGZnQlpkYlkyMTU3?=
 =?utf-8?B?YnpXT3d3NHc3bEVlL2Z4c0NSRVBaT0NHZHBpVUxWakVyM0NNK1U5Zm1BTzJ4?=
 =?utf-8?B?Z05CL1MwcU1hUFZIdENSWHUvMXZkc1ozaHJrcURpSFEyRGo1NXMrUmE1OUov?=
 =?utf-8?B?YWY5SGNlc1pDOHlzbHUzZnlDZko1OUM1OW9sb2p6cy9NOVQ5OXhGNTducHp0?=
 =?utf-8?B?N3VPRDJWeHNSVDdlajJieSs2eCt4ck83eXErNWNIME5xaXFJYmJJM01vVDhk?=
 =?utf-8?Q?JQfrDMbIQ2+Q9Xvzv3ihuSRZN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7b1a68-f8b1-49ca-89b4-08dca11919c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:47:15.9692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewnw094kv54azcbGmnJ7vMDTcsTLYfzG8lqRN3WSmvc/SnHz/ar2oLB7FTAnoZ2e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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



On 2024-07-10 15:36, Fangzhi Zuo wrote:
> From: Tom Chung <chiahsuan.chung@amd.com>
> 
> [Why & How]
> Fixed the replay issues and now re-enable the panel replay feature.
> 
> Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3344
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>

Hi Jerry,

Please drop this patch as there's a known PSR SU regression caused by a patch 
that originally fixed the aforementioned replay issue.

Thanks,
Leo

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++-----------
>   1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index fe5a96e5c70a..864a66406f8a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4836,18 +4836,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   	/* Determine whether to enable Replay support by default. */
>   	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
>   		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> -/*
> - * Disabled by default due to https://gitlab.freedesktop.org/drm/amd/-/issues/3344
> - *		case IP_VERSION(3, 1, 4):
> - *		case IP_VERSION(3, 1, 5):
> - *		case IP_VERSION(3, 1, 6):
> - *		case IP_VERSION(3, 2, 0):
> - *		case IP_VERSION(3, 2, 1):
> - *		case IP_VERSION(3, 5, 0):
> - *		case IP_VERSION(3, 5, 1):
> - *			replay_feature_enabled = true;
> - *			break;
> - */
> +		case IP_VERSION(3, 1, 4):
> +		case IP_VERSION(3, 2, 0):
> +		case IP_VERSION(3, 2, 1):
> +		case IP_VERSION(3, 5, 0):
> +		case IP_VERSION(3, 5, 1):
> +			replay_feature_enabled = true;
> +			break;
> +
>   		default:
>   			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
>   			break;
