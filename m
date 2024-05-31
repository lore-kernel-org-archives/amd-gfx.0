Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4255C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 18:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1625310E36C;
	Fri, 31 May 2024 18:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qOX4UcBZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC0110E36C
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 18:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKMJW9yNkOKYS0mruzlaFO6dmO9s7L8Vp8G02hnOJfTavs8E6gtrfF7vzJnnhcGKPY2eJxkCUPhsq6vND3lBR2B3nfh3hHIspS9FEM8grBsciuL350FCkEfhaWFxqAe5SRMn3Lszk4jUcU6VDCXHd8itSj5xtX+iqj69MQiV46L8ZOku+YiI8lwTr16qt620HFhVGpMRmEAI5nqRektiaEr1yZT4Tg5xmJ0KjcGg2izTyB8bPCY1gkpdnddHsm0ZIPOjjdVyFvQ+yrrrltWPCGtzGZRDPW4ucarV3exRl7PM07SPCpw4f+QjRRofJVUleW3zIV3Bc+ai4rg/Lz0/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6mgQbD8ddnTtZ48RoGn14F3H5B6Xs9OjRoR/kK1ojc=;
 b=Up6b7NPN6HMgzoFMdAxd8nI9k8aKR/I07if72L0vxuPdkId7HB7iRSJUE2hEU5gjZhARL4NlralRx/PabYVr4e5Ge2VpvdKqD+z2VrX2TTIBLfrICnk/qD8VTrUUEeE1I7WFgSZ+utY1KStDWRATS44Q4cpJDG7RU4z9aHtjCEtihdV5oPO0FnYc3Vd00tqDEwJ9N7IMWQXXo1Wq/o9TkniAPpg5816YW6F4A1xfxSU/vLV853NRhoHbiA+knIaCrJ4LX0vlCAKJ0KNGVTOm6nw58AYagmR7hnPGvfWIq1/R13HX7XhpYpvO6UOQ48zQCeNr41B0KJFFexXmFUDr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6mgQbD8ddnTtZ48RoGn14F3H5B6Xs9OjRoR/kK1ojc=;
 b=qOX4UcBZHz1AVF6BSLdU4UgQjH/mqd1AevsPGF0o8dqXllsOVsmZfF690LOUScadjO0ItxqG9Aw0Fr0XBDf7DGT7RCBrPT+jVvp4fVY+lHzz6vFB70Gk8vcE9PAYWCAACnHMlRPeR866XjCJtJjXyxbEs9xfvek0RpnjzFEHN9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 18:46:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 18:46:48 +0000
Message-ID: <e60db8ca-0e17-4958-bd83-16543afdb533@amd.com>
Date: Fri, 31 May 2024 14:46:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/amdkfd: Comment out the unused variable
 use_static in pm_map_queues_v9
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240531025143.2457099-1-jesse.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240531025143.2457099-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0029.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: c21e87db-b404-46e0-807c-08dc81a20709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWdmZllHUm1UMVpXVS9TSlFSV2tSSGdMVGxncWlMRkEzUWNFZE1jZHR0djFW?=
 =?utf-8?B?dUNFSmh6aXNJSFFML3dKV0x2ZE0vcmZ5aVlsUVNqbjNwOVNXb29kV2NoVXpN?=
 =?utf-8?B?QWZwSEsyUXNMRDVRWG42eXlRSGEyQkRDUkNaQU5yZTlSb3gvYkhtdFlXQmF1?=
 =?utf-8?B?ZUM0aGtXdytXcFAvdndERU1JNytOWVEzK1BzcFh3ZE5ndWtTb0dtSFhkclZv?=
 =?utf-8?B?THcrRWJhSjhoNndpWElpd2xyTmJCb3JtanNIL3I1MlpHUjhFeitCb1VORWc1?=
 =?utf-8?B?eEpJbjdMY0hJWmllVndTQURGdzN6NFFOTTFwaEJrZzRpRmkzTXlvMm9BWk9l?=
 =?utf-8?B?bjRQMHZQaGVSMGFTTkx2cEhYYWNZZjczQ0c4OUZPdmZLTElNN2ltdjhKa1FV?=
 =?utf-8?B?c2toVFRkK1FQdmpRUzArSkRqcVpPVytoQTN6VFBUbXBieUoxYjkxeFh3NlVC?=
 =?utf-8?B?UG92MEVIYnpGVVdoNXFzZk1NRHMzODVQbGZJeGh0UU8wYlpVaFNCejZHTGdo?=
 =?utf-8?B?eDBFZTBYZFMyWmsyWitYV1dpWSthbVZTTXF0a2txZGk2VUtBUU4vYmRjNHdi?=
 =?utf-8?B?ZGNNV0lPRDFOc0VxaG95d2NBM1ZRRDN4VDFtSUtrOHBWZk9KYUVaQVBGRmZE?=
 =?utf-8?B?SHBOWDY5bVlmbE91akFrWXVwZHp1UTV6RkNEdHpvRXdRNm4yb0IzandBSW5E?=
 =?utf-8?B?Wk9aczRFRnBobzJ3aEYrOEY5REZhSE1MeURSQXk3bFlsN3dLUlV0TUNoZVIz?=
 =?utf-8?B?UU1kbVBtR1NuTDR0eXc1NDI1d2U2RnBlVEVzaDNiTU5BcmhvUFUzNm1qZzVz?=
 =?utf-8?B?eW4zbG1SMGs4a1RDUm54eWVTYTYwcFA3bm1vYnZIalRaRTlXWWFxSzJzakll?=
 =?utf-8?B?bEtGQXAzNFMzaFdwTXduT1ZEYzBTbGRSTWhGajFUV0owZjhyRFNsNmdwQ040?=
 =?utf-8?B?Q0RhN3pFMy9vY3BKY0V5T1Brd1F6NlpMenRia0kyV3NJVEZzL280RjRCb2Jn?=
 =?utf-8?B?MEdlT1RzNi9vNHl4ME1DUEx1QXJjK3p3V1p5L2ozZTQ4dk9OREZ1OGtnV0t6?=
 =?utf-8?B?MW1jdk0yRHpHenQyWWw1VUZDWjhBVmk5YW5ZNnB5cENPeUpOTHd2SVBYT2VG?=
 =?utf-8?B?ZXZDdHh6NXlkSUorRzUwQVhrWmNKT2U4ZCtMVzk2ZTRmWjNVdUVRTFZFTXRZ?=
 =?utf-8?B?RnphNlB6SjNDcHV6SnlFODlENVc3UUJqcnNHaU1WS1NnZmVSRmh1UmNRQXBW?=
 =?utf-8?B?aGNrS2Y3NDNlYWJ4aU41OHNLWGhubEFtOW9YRks3K1h0WjhWZUdKV2hYekFy?=
 =?utf-8?B?K05HRjYvdTJ6WUZBR1hDcEllS2tIOU40dXlUQ1NaRUV1SnhPMmMwa01kdEFK?=
 =?utf-8?B?WTNSVkhLWWVtWWNRT2NMYjNoZ3ZjdDdNaFJJQzgzZU5LMEZGQ3VGNksyeGRD?=
 =?utf-8?B?ekhRYjRoSHNlQ2JBZzVzTUFMY21yci9STmZjWi9FaXNlcERqaHltdWtDQmk3?=
 =?utf-8?B?NEpGKy94NkRxMzBvYy9rYkxvUkVIV0l6d1ZVR3o4bDFMWHZzOWpmTGRGbVpy?=
 =?utf-8?B?eGxMMXl0REtKbzErWjMySWVsdFN4ZHdNUTZGUEQ5Z0p1ZW0rYkNuWGw2b2hs?=
 =?utf-8?B?L3ZldENKSEdJaHRoUk5oS2xGYUVKaUUvMzhYSFUxRTZwalNYKzk4Lzg1K2cy?=
 =?utf-8?B?U2g0djNra2ZDeUF4aWMySlk5NEJLOTRqVGNaUGt3RjBMTDAxcmhmK3FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFR4WnlsTUptOGZDczdXOFNOVGFVL2tPalAzWC9IVWVqZFFVaFhqSjVaNm96?=
 =?utf-8?B?MWN3NGRRNkZKaWxKYzZRUjF4YlI4ZXhPNjh2UnJVNm1aa2dhb2JaK3JNcVVs?=
 =?utf-8?B?T2pkY3Bvcy9IbkVySkhxRUZzRmh0cDhnVTFVNWtvWjVDdCtDSDU4TjdLNDM0?=
 =?utf-8?B?Vm9CVUFFdjQzOXpvaW5WcmxJYmg3UmtOVDd0Q1dHV0w5cllWNmhpZzkxdTVi?=
 =?utf-8?B?OEhpcmoyemRiUitjZCtzdm8vQWpyOUdCRzZYZlFieGIyajNiWDhMN1dsbG9l?=
 =?utf-8?B?QkxoSE1mcXFZaUZYN2hXOXJMK2ltZDhUUm1GcUlwY245UGhxRWRXYjIwcGoy?=
 =?utf-8?B?K0RTQjFoNFIweHQwdUl5ZnNIOTdWWXdrTlBOSzczS2VHL2graEtUWldTMHVn?=
 =?utf-8?B?VTcxNGl3UWltUVZQL21yUGVwOW1CWHFqZUdYMmEwZFNDZUhoNXRvSEVoT2pZ?=
 =?utf-8?B?NmYvN2Z1UElBNkZ4SGZ5S0dOTUdCMjRqME1Hb0Z2SHF1aGlCZCtLYXpZY3p1?=
 =?utf-8?B?NExYSWMyd09CU1R1SWQzNmhmZDIzR2pta1hTVFI5UHlWSG80cjJYaWtrM3dE?=
 =?utf-8?B?ZEFaOVovenVzVDRzS3B1NGRmU0p5NytkL2VFT2VVNElJTEpZWlhKUDUvS0RH?=
 =?utf-8?B?cnBGSFhabHEwdGdDNE9YZTdNKzdmOE1nWjZmZUFIck5WcFYxLzY3dXI1VTFl?=
 =?utf-8?B?YUp4OHdFVmxQbGtaVm1aTUwwZ0hqZWt3U3hIY04vcStrRDNzMzNHbmNoTnJq?=
 =?utf-8?B?ZTFUdjI1LytqdEhlVTkyQVdZU3BBVEpDQVFsMEhVM2NoWHlOVG5TYUx3Zk5h?=
 =?utf-8?B?L3I1aHE3b1dtaE5lcHNsaDJMVXdvaHY1cXhManlKMDM0Tis3cXVRMHZqZm1B?=
 =?utf-8?B?b1Nia29RMVpFeHRkcXVGZlhhUFFyQlFKZVdQdTFhVi8wMitPL3JzUGEyOEpw?=
 =?utf-8?B?dktLZkI2TG5INXBybkxCSFV1ejNTZTRqdE1JL3hsU2xSa0JMSXRRQzlueUZ5?=
 =?utf-8?B?bjhmbnQrQmF0bUpEZ0FzZ0N6UWJFZjF0TUJVTTNxdTlQRkFkanZuSDZhaXpa?=
 =?utf-8?B?bjFCQk9rclFGaFV2MjlYNjVORFhrU0d6Y1gwRjBMV1NJRENKVjFWa05ISk1l?=
 =?utf-8?B?M2puUXdkVWo2bHNPWCtVOCtjMnZkVDFCcDBOZ3JqWktOTjNLODUzS2s1UUsw?=
 =?utf-8?B?Wm1pZndSUkNENTJNNkpiVDBJUmlhY1RuOWh6elJ3aUxkclFoa3FIYWFPQ0kw?=
 =?utf-8?B?NXJDVkdwODZybTQrVlpPTGFFUklGQ3A5V3g1YlpsZmxIM1Vla3VERHc1Q2Iy?=
 =?utf-8?B?WG9WQXhZMDZMSE1iR013ais3LzRmb0JiWi91MmhRNHArU2hpdEJKR2pWaEpX?=
 =?utf-8?B?aUlDOHd1V3FxdDQxa256aGw1VGZncC9XbE1XM3pDWGlGcFpRRm9pOFE4cktr?=
 =?utf-8?B?UG80eWE3emtIR2w2bEdFUW5NdkdmWUUwZjhRWUZkbEphS09HS2NoUExQaHky?=
 =?utf-8?B?MU4rSmVnMzdoYmVCR3ZndVlmcDN3dEFtK25QZ0Z6K29HN1BJOVZvNGRDSFFm?=
 =?utf-8?B?b0I4ck45QmlXNW9zUVBNRGRhMEc0ZG9IRTZydGdlenZXelBacGcybnV3Q045?=
 =?utf-8?B?NmVVSXR0UnB2SWplWWNDTlg2SEtTbU16Y3g0NFR4L1hHa1ZWR05nWE5TZ0VF?=
 =?utf-8?B?OTRsWHpaWXRELzZlTTE1MStxdEcxVHk5S0Y2ZFBDQzhZSXpQMGNoWi8wOFZy?=
 =?utf-8?B?T2owYVpVV2VtVnk4SlNsNzBJb3R2ZDhOdzY4SnlkWU1CNW5hbHREQ3FtcWlr?=
 =?utf-8?B?K2RnajNKUTF6dEZoWGVka1V1cDdlOE8wQnBzdEQyeTNOOVJObTNnT0JaUWcw?=
 =?utf-8?B?czJUNG84VlJXZjNDMUhWY2NZOUQvZk1QNHI3K0Z6dGY1VXlZREZyMGFrendC?=
 =?utf-8?B?cGQvRzdyNVdrY3FSOGxZaE1tNGE2RFZTQk9mK0VSOGVac25wbk4rdS9ZOVVz?=
 =?utf-8?B?RjBOMlppMzR1SStVdEc2MUR2RXptbmkxSmhRRHMwbTV3UG5EeGh5S2k5cmFW?=
 =?utf-8?B?QVhiR3pSditMYkFkTElYeWFuZEVjMEtDZkxJTHpKSEhHb0ZtbjBVSThWdUdF?=
 =?utf-8?Q?IHbVGFAjFtLC2zl9quEfT/eFM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21e87db-b404-46e0-807c-08dc81a20709
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:46:48.3799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYzahn+5EUZFdbYOs4ayyYQWNVjjKI7WoKieeh0LeZUpvZlazhGm8ZCw/LDTdA4wmzFxa/dJOITzVOthKa4Tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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


On 2024-05-30 22:51, Jesse Zhang wrote:
> To fix the warning about unused value,
> remove the use_static and use the parameter is_static directly.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8ee2bedd301a..00776f08351c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -213,7 +213,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   		struct queue *q, bool is_static)
>   {
>   	struct pm4_mes_map_queues *packet;
> -	bool use_static = is_static;
>   
>   	packet = (struct pm4_mes_map_queues *)buffer;
>   	memset(buffer, 0, sizeof(struct pm4_mes_map_queues));
> @@ -234,7 +233,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   
>   	switch (q->properties.type) {
>   	case KFD_QUEUE_TYPE_COMPUTE:
> -		if (use_static)
> +		if (is_static)
>   			packet->bitfields2.queue_type =
>   		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>   		break;
> @@ -244,7 +243,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   		break;
>   	case KFD_QUEUE_TYPE_SDMA:
>   	case KFD_QUEUE_TYPE_SDMA_XGMI:
> -		use_static = false; /* no static queues under SDMA */
>   		if (q->properties.sdma_engine_id < 2 &&
>   		    !pm_use_ext_eng(q->device->kfd))
>   			packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
