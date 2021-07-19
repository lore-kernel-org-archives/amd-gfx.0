Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1481C636C9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 07:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E38661019
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 07:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E38661019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C6689D66;
	Mon, 19 Jul 2021 07:21:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF9B089D66
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 07:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeD9dHd3gtB9c+9RQmSBFDuJEAlvBOH02CITnDso3igyUmbi9yebDTfV+MwnACX6EZeSiNeePlQqiER7cE1kcMre87To+ZO0Rqk3oODjuIQcDROWR76AZoAEq45a70QYtBww+08LXBJjDaT/e2ujRorg562U01LceSVBHHRBZoPtLgY1B8DofgHOtyNNBdywqBiluTT8whwfwKqpIr2WPE2CbNIE0nPraNcSeW1TNWc95TPUUykGeV7NBufKdfVp70QczS9H1DbrRkgGFISlDrMWnuPiqVaBojM5M3k3otWKEa7Ou1y2Rh4CIWceorZS2dHunBwzq/I1eKz4hbRHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v18U3u7N6PLqnj0x0nbcQgrFFzFrMRWfabrdQJV5UmY=;
 b=JB14n+r4M7PY/pViEF/OaEwE4uXsXeUrYC6fxtnvp/xiNb9PNphTxPyjpg/JY461UpyEgKrJ/dsB7bEQ99ljuuhZKeVIuc88ExI8HqD47THwu7n3eZJ3kC4bnf8p26RWISMvKknqPu9N9FPJNfnLZKM3tIBAvwL9ygFIxm+zVM8XQITYjvw3t9SnQ2tZCLf/xxocC7wazp0liF170KW+Kw/RbJ0ghYvUoX8dEAGBqQxlInkEkXnnQJnh7NM7LIzurY7xFEBU087fzYCNVwgKlGZMWX0lp8uIoWmpBRCxSGT8B0h44YuTNQKAeivEwSwOQx1MZymq6NTqUOEVvicy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v18U3u7N6PLqnj0x0nbcQgrFFzFrMRWfabrdQJV5UmY=;
 b=fWJ1JOsjarD5yvtTcUrzMSU36rCkvb3d1R3jCpm8/sKQnVHV6Sep2j7lnBUFXerBP7GgN3av1m9J6dNQs5OhquVsY+rdg/lnt+KXSe5WmmJBF6Qskk01etCOpbm5V6Gq3zbyfmwj4DFDKo1e4eqvW3azTEKFe/Oy7bOwlmbdecc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Mon, 19 Jul
 2021 07:21:49 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 07:21:49 +0000
Subject: Re: [PATCH 2/3] drm/amdkfd: report xgmi bandwidth between direct
 peers to the kfd
To: Jonathan Kim <jonathan.kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210716164312.896939-1-jonathan.kim@amd.com>
 <20210716164312.896939-2-jonathan.kim@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <19e8ee08-c4b7-ffd7-0805-84c93402d76a@amd.com>
Date: Mon, 19 Jul 2021 12:51:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210716164312.896939-2-jonathan.kim@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 07:21:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1663e6b5-6fdc-4e11-81ac-08d94a85df70
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5063952665118486CD54000497E19@BL1PR12MB5063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gu3fwnr/5IKlsDL2+CBM0YWA8QunOjIXRYefolfYoEGalKAtDXJfLyiGnHIO1FJYf6jx3mxL5l9ztVaQGGG5ExByYDJL88Vc2uK0KtzxonEJq7nxCUxdKSCmdVkLVz7+24sUTs5QRAH4fffMhthV1+ih1ArUjdAcjf3pl0elNzkeWaKqCzc9o07mTvqsbIonxhxMRkit0TgvOdUF2MnYSopBnnhhtsQNsR28VaLLy71gbIPEfLnvok2MeJ5sq/w7/AJIegkhb69VJSNYX3yv0B8vjk4ihWOiYDAoPjIZRdhrixkL5cLdjETQuy6gbypCB/qAsHnkEvKOhSV9pGZkiiKDJxcax+yZW32NvMJmJAqTwYQzs48gB4okcWrVV0VJlUrIIQlDI+rSei6h0Ttb90VknPBKMru+s1Pk83tPmBFTj1iEpxAojXCmSIfnapkJzrWJQBfejfh+/0SqlDRqChTFcqsnd/B8l6rdub8ejk221nbzlVb7wkYc1+SAbw1U9Insv4k+zrHVOD517QwqfrHE2rXLQxadMLveJa6pLMumKsm4qHRRu7HN+pzhzadhv/R0FmDyTh/GwZJCe5/JlixW9mrzqwt0ndFEhdOE6Wgy3AqBmMcpZuqWYz3/WwDDN2AOGws2eCrhj+4EtBg/swowIzAiyFjIvBdJSyzeY/OUIXu6MhVsLmFi+P1e7r5Ase5GqFPCniGagt4dYluo3X8fNoJmFWCgNdppz2VE1Tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(2906002)(31686004)(6486002)(5660300002)(110136005)(316002)(186003)(2616005)(26005)(66476007)(66556008)(38100700002)(53546011)(956004)(16576012)(6666004)(8936002)(86362001)(83380400001)(8676002)(66946007)(478600001)(36756003)(4326008)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJVdVpwNFRJK2laSyt6N1RMTmxCMUhwME1tbDhBcUVnR1pzaStGMEZFaHov?=
 =?utf-8?B?TDkxQ2J0REZicy9XQk10MEI3YVQ0NC9RbGwxOW14cTVaczhRWjY3SUo1T1Bn?=
 =?utf-8?B?OWUwOGREZDNjSi9NRDl0WldXUkRCY1RXM0g0R0hXbk5CYlJMMXBLc3BxRGU0?=
 =?utf-8?B?NFhUL1JJZm43V0RHTDFNdjZxVUtlTGdrMzlhRWNwd0JvaURoVDZpc3J5amk4?=
 =?utf-8?B?RUp2RFNIYm56cVRrOVRNN0FVUmE4aC91dWllOW5MakJhK0dBSUZ2eTZpMzFs?=
 =?utf-8?B?TjdHc0JUZ0hsQjJLaDk4ODA5SW1LMGZDY0RuU2h1NFZzdS9ZZGdvQlV5R3Ft?=
 =?utf-8?B?TjIrK1Q5Qlc0bitveU1ubW9jSWkrOUhPc05tOTlhYXhPRWRQSWdGVkxQOTRu?=
 =?utf-8?B?R0hYRU50OEFXZXhLZHJTMEE3MWR1SmY3ZDNxMnB5Tk5RRVlZaFozQ0xqUS9k?=
 =?utf-8?B?ZjBKeVo1aW0yVmEvYlpWa3Z0dFpIbGJDK0RDaGZqMkNEalZhRFBDSUhHZXJK?=
 =?utf-8?B?Y3FUdzlJYjJ5andiNmFVUU14Uk5ObDNvMmZKYklGR0dqR0lGQVRwMHM3WUsy?=
 =?utf-8?B?SE5xKzVLWUhLYXpTS1Bjc1NhVElabmxyZytTbTRpeFVrNGNTOXloak9hRXBO?=
 =?utf-8?B?YTVaQTVlTjc0cUVzanM1YVRiSm53cGdUa3NBS2pINzAzb2h3VWF6eHk2WG9l?=
 =?utf-8?B?dFJmUlMrOUJsOFRSb3F3Y2IwbGdybVpFSFZKaUpTMDRaTkJRRnBYRi9iaHFP?=
 =?utf-8?B?RE9pWEtCcU5UKzdXak1Zc29KZjJ3c25oRUNyTE0rVndPUHNUSEN4RW1hMkpN?=
 =?utf-8?B?dHdnUzBQdDdGRGhGUktvY0ZrUTBMakpsd0cycW1vam81d05XenlRN0pIc244?=
 =?utf-8?B?Q282eUZONThITGJHeXFVY2hDcUMyd3RZeUF0akFWTFpyek5kbVpVcjFtc2tW?=
 =?utf-8?B?c2VDd3lRZkJ4QmhsRmJDYWNiY0s1L2JPVExueDRoLzBrR0V4S29DcnRSbUhj?=
 =?utf-8?B?dkFYc1U0QjFJUGlWU2tvTUVyaHFmMjI0Y05EajRicG9ZemIwRS9TN01tRDFp?=
 =?utf-8?B?SUMxVmp1dlpUcjF4LytNaVM2ZmlFcTZHRzdQQmNzOW5objBuWVdoY05aS2wy?=
 =?utf-8?B?cWFhcUszYVBUcDF4UHNzalhYZlpYWTQrdzNTaVVLU2RJRmxvQ3ViNjdTRDdN?=
 =?utf-8?B?YklBMVZLSElUWG9rbGgyTitBUHljVGxESFVWUmFoMFVCWWswQk9OUXlNSXBr?=
 =?utf-8?B?Y21lT3pLaS9FcG5FSGZ0YkVmVUplc20zZ2FGUmgxR2dPbHVMSThqQTBQNVRh?=
 =?utf-8?B?MmlETkdsMUJjd2hqa3FuRnBWV0V2bXZoTXlid0RIazhYNzdoQXk1MGhQUVAr?=
 =?utf-8?B?cndZTzYybTBkMk9HRmE1RWRObkV4UmtLc1pKb2dab3NMT3dyUmZ0eENoTThx?=
 =?utf-8?B?bHBtSVJHeTZCeUpwVlZIUUEwNVZYNDlJS0pndFFDK2ZreXQzejNVQnd3VHF3?=
 =?utf-8?B?QTAzaFR5Ykw5cy9jTVk5V2REOU9nakdpNFVlSnBIUkVxYm1ORXhoTkFieUNy?=
 =?utf-8?B?dlFnenAxZVNRTnl3U05nQzJ2dW4vL1draG1hcTVrUG1HcHhqbWlzanRNY0M2?=
 =?utf-8?B?R2FmYncxcWN5NWk2RUNCTnhsT0I1Rmx0NTJyVjdzNWpPQ0FLL1VaZGJrSmk4?=
 =?utf-8?B?cGRVNHhqdFZweis3MXVrQllKeXdGWldRTDB6MlkvN1JUK0hNN3Y2SW9SNEY4?=
 =?utf-8?Q?kANgWnoUcdkpXgS/hReXSepOCFKdV3p3AL3moDC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1663e6b5-6fdc-4e11-81ac-08d94a85df70
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 07:21:49.0907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYHNm3HFirllX979+Rmjl0X1/+QcREdJ64ioIGjYbYYm1fLXsbdnjWoMqREqfW5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/16/2021 10:13 PM, Jonathan Kim wrote:
> Report the min/max bandwidth in megabytes to the kfd for direct
> xgmi connections only.
> 
> v2: change reporting from num links to bandwidth
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 23 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 12 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 12 +++++++++++
>   5 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index bfab2f9fdd17..3978578a1c49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -553,6 +553,29 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
>   	return  (uint8_t)ret;
>   }
>   
> +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dst, *peer_adev;
> +	int num_links;
> +
> +	if (adev->asic_type != CHIP_ALDEBARAN)
> +		return 0;
> +
> +	if (src)
> +		peer_adev = (struct amdgpu_device *)src;
> +
> +	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
> +	if (num_links < 0) {
> +		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d. ret = %d\n",
> +			adev->gmc.xgmi.physical_node_id,
> +			peer_adev->gmc.xgmi.physical_node_id, num_links);
> +		num_links = 0;
> +	}
> +
> +	/* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for bandwidth. */
> +	return (num_links * 16 * 25000)/BITS_PER_BYTE;

Instead of having ASIC family checks and bandwidth info in interface 
functions, better to have this info come from base layer (amdgpu_xgmi or 
xgmi ip). That will help to handle other ASICs.

Thanks,
Lijo

>   uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 81264517d532..e12fccb2d2c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -226,6 +226,7 @@ uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
>   uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
>   int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
>   uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
> +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min);
>   
>   /* Read user wptr from a specified user address space with page fault
>    * disabled. The memory must be pinned and mapped to the hardware when
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 8567d5d77346..258cf86b32f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -486,6 +486,18 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
>   	return	-EINVAL;
>   }
>   
> +int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> +		struct amdgpu_device *peer_adev)
> +{
> +	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
> +	int i;
> +
> +	for (i = 0 ; i < top->num_nodes; ++i)
> +		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
> +			return top->nodes[i].num_links;
> +	return	-EINVAL;
> +}
> +
>   int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   {
>   	struct psp_xgmi_topology_info *top_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 12969c0830d5..d2189bf7d428 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -59,6 +59,8 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
>   int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
>   int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
>   		struct amdgpu_device *peer_adev);
> +int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> +		struct amdgpu_device *peer_adev);
>   uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
>   					   uint64_t addr);
>   static inline bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index c6b02aee4993..40ce6239c813 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1989,6 +1989,13 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>   		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
>   		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
>   		sub_type_hdr->num_hops_xgmi = 1;
> +		if (adev->asic_type == CHIP_ALDEBARAN) {
> +			sub_type_hdr->minimum_bandwidth_mbs =
> +					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
> +							kdev->kgd, NULL, true);
> +			sub_type_hdr->maximum_bandwidth_mbs =
> +					sub_type_hdr->minimum_bandwidth_mbs;
> +		}
>   	} else {
>   		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
>   	}
> @@ -2033,6 +2040,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
>   	sub_type_hdr->proximity_domain_to = proximity_domain_to;
>   	sub_type_hdr->num_hops_xgmi =
>   		amdgpu_amdkfd_get_xgmi_hops_count(kdev->kgd, peer_kdev->kgd);
> +	sub_type_hdr->maximum_bandwidth_mbs =
> +		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, peer_kdev->kgd, false);
> +	sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
> +		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, NULL, true) : 0;
> +
>   	return 0;
>   }
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
