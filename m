Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDD0C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 14:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C74110E330;
	Mon,  7 Feb 2022 14:22:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66D310E36A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 14:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0ONsgK2ltbQ7WW13OdW6+3pDgzW2rTw1+Tpo6rVngpqNAM38uSGlFYB1v/Eaq9uMu1Yuq6bs4F3Q85EpN2Rj3qaUlxWciQhZAGmsDW9WoGVbliT9pOKDq+EUJe3y2c5DxYKG+58PN+6MmveqeRmqzUtFNxJG6YZvnradoUB77KXPJJARzQgPTw+aFg+4suxucsXMX6Ej+xV4fzZFUMTqZn+hlk2+seLmWqdImHTeQ6jcqFh2HXqcEJ+jLKgTRSys8z/gDzWLrJXxUcFRiifJhiT0Ml06tddAhBCeqJn484sjG6nVn5dEuaml1e41CU4NG9KWRDx2xTnkWt+brxSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txaS7+RMKEONRMAz6l5wf0uDYN0abwJwulIQQgJ8PJw=;
 b=kTL3WEeoeQkJoLJJzcbjujpBVPBqLrD7hqOFYTYg6ZMjgkkw0xLxJA+n6B0WDdNCySPvjAb3UCstdsjyC8L54CbLqMB0MNjS5AyvR7bUrfdrxCT0XTjkI3qV75Oc0ZQUNlSnrZ69jdlDiY7xZOyPkZXromRJ77opTPULiE41+4qwNegOxcud2i6w1wt+2GpOLTSSwIJb6MaAET1zIMzzrk9Sp4XnjvuOSO1mfwudlTeOXGT3ZrwsaqRk6Z9ckohhodLPgZb0JyFIdvpEMT2iR2KiJDcdMOtMwL7lE5EWRNel7ozTH5maKhC7VIb3vv4nrl0cHTP2Cyp8Dzd1fVjIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txaS7+RMKEONRMAz6l5wf0uDYN0abwJwulIQQgJ8PJw=;
 b=cvKyS4jeVIlnmyvwAiHgqlYG6GSgZK8/S1QfcudccJ+f6Uo+wFTE8OzigXMaDU9ZP41MxjTPIr8LSaUZ/nlW58hdh7XFusuRZvPMCPBnIfP3p9TEOksRUIeezg13/KEgjkyOEoVDJ/pEkAz+OjPFs9Y8iyoi3s65BjE4zAfCreI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1309.namprd12.prod.outlook.com (2603:10b6:300:10::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 14:22:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%8]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 14:22:26 +0000
Message-ID: <2636d68c-cdcc-24ba-435d-da606d1e0144@amd.com>
Date: Mon, 7 Feb 2022 09:22:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdkfd: use unmap all queues for poison
 consumption
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com,
 john.clements@amd.com, Jay.Cornwall@amd.com
References: <20220207072742.5476-1-tao.zhou1@amd.com>
 <20220207072742.5476-2-tao.zhou1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220207072742.5476-2-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aab818c1-a937-4fe7-1d2e-08d9ea45438f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1309E0AF4AC517F1B4A5C62B922C9@MWHPR12MB1309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jIyeqXPqCaG4Gq5jQSHoF312JFDUZhkj6eQ8odnNOZWtq+waiQnecTkTHuvoRjeK7LizAr04xvPgZaMIw433W2qunOfuOY5Xy7N5wF9RDPGYhlE4hpRlBW/aav8w+jR+2DntblgEHvbHcB/j2lhOOzYe0VdvlaL803+YZOvp23b1dEzcn1CdIE3chQVqYEo4HZcJry+0CpmBPtzf0miPodKmVahbqEORZR7BHs/dAGOBKYcYB3dL1oXThWdEowLl7Qo0I7puD5f+VpmtRBC2bkW1zNmniqOrx69wiRog4wrsozxZPvK69NqjYK0IkvIDDw+Vv3oKRwFHzxrxbxszIpe7svCVNhw3nD2zoTBsHKs3KD8uRqNgTWu+uoR0XqAyEip/cupYYfi1mx+qXUBhIWW9vCAw0CkExsD/Mvnm7i/7sgPMp/SCMRPVWBB6CUIrxvLIyrjfq3ouZRZIVf6A9z8TzC8JP+z2VSH4mZTsQY9stlss9Dl1iCx6NSn4BprfdkLS6QcHyVFAxxdlniAEELzkHftHBpQgDfL2dNnGZV9fF+F740cJdp9MG3UoTdWPevSDXM3TY3F2fO/yoB+klinXTV9jGvGvAAvWdQ7T/55U9fR776WSv7WViRzPgMAqTjdePFtVqYi5NZouAs3CF90ZgvGtA91w5myTRWU+/OiJKyC6qgtsp48R0cuEIzyJXKJ9Dvtl+ZSzCWHiB6ibiLxaeIVZWTHqR8cLSTRA6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(8936002)(31696002)(66946007)(66476007)(66556008)(86362001)(38100700002)(4744005)(5660300002)(44832011)(2906002)(2616005)(6486002)(186003)(26005)(83380400001)(6506007)(6512007)(6666004)(508600001)(316002)(6636002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkloYlMwYUs4cUoyeURnVHNWWTNmcFA0RVdmNnlYb2dEc1ExbkpUR2l2WHBh?=
 =?utf-8?B?VjFlYy8waVZIVUkzUXk4Mm83Smpkc0tmUnoyVWRzYXZTNzBFN2ZEUjNwZWZw?=
 =?utf-8?B?M1UyYnU4TVBBZEJwWmhsZE9MbitNR1Z2VjU3cmFWSnhrNWJ6MXRocUNtMkhl?=
 =?utf-8?B?clhCbCtGcjdYTTluUWQwK0RXaVJQVVRNMThkNUtacUkxSVNLU0lDbUxmZGtB?=
 =?utf-8?B?UHJIcldKSEFibkFHZElxODh0UU9XK2I1TlNCSCtOckpTVTRiTWJqMlB6d2Jn?=
 =?utf-8?B?aFU5VnlHN3FDalAzb0lSeEo3RkY5cFNXRUFtMjFSQzJGUjZ0SHVTT3YvajBj?=
 =?utf-8?B?T2J1RHZFY3NtdHp6RFFCdHR2dE9GUy9zNW5nYWViTnZNbXh1VGpWY2FBc1Fx?=
 =?utf-8?B?bmVWbm5WRWROa3ZTb2o1N0FNVmFtUEVEc3BxbitJMnlFazRQNTJ5YU1TK3V1?=
 =?utf-8?B?Tk54cmdaelJMaFE2K2ZiS1lBSnNKd3lBaVllSXIyMnVYT083RmU2SGFQeXZ0?=
 =?utf-8?B?a3J1OERKZXU2WHdFT0hMc1B6ajNDK3pWTUNPZ3ozWHhNclNpTXdUMzdib2Ex?=
 =?utf-8?B?dHVFblJ1ajJBRGZISnpPSDVkQ2tHVU5vSFJVZjJnME1GbDFzUFNvWnJVSmx3?=
 =?utf-8?B?MTYzbHU4dUVpYlNIUHpQQXVDSUMxM0lhTWVhSEpKd290SWRscFprQWJmbUJX?=
 =?utf-8?B?V2hkcXlQUVJ1VjBXT2VOc2ZDblRzbk1sNFNBdndtOVBMUWhCbHBIT1llQVpH?=
 =?utf-8?B?elQ0MTN0TDNpd0lra3BDc09Kcjl3SG9YbWFNcHAvZlpzOHArR256dGc2MEM2?=
 =?utf-8?B?QkFmTTJnbnp3K2FOMU1OcHVLaXk0cW9UNGg4VXlkZkpBOVc4QnlXN1hyOWZo?=
 =?utf-8?B?dWM4elo0WjFGSHpjUWhIOHdhU0wxOHI5Nk8yTjcwSFh0b3AwRWtnSGVma1NB?=
 =?utf-8?B?ZlYyblhJOTdtdWRQMkZXR2YwMkVNQzZiQ3NKODFqODZidlJEUXRCWUlURHVC?=
 =?utf-8?B?V1NnUjFhKzRUbXk1T2lEeERVRE1kZkdua0xKTmJoOHBBZUp6aFN1NHd2SENu?=
 =?utf-8?B?ZU8xNCsrZnhsNmZxR0ZtTHppUzBpVThuOUE0RVhtL0M1QStpRlY2emZ2ZWJt?=
 =?utf-8?B?WjlBamhtS09PRndJZ1BPNkdoN2xRaTlpcHNqTEowWHc1RG5UYVgybitPR2pQ?=
 =?utf-8?B?R1dGZVNJM1N1MS96a2k5ZmdHQWZwemNJbDQyN0VwMnBkZkJENG41SWhIU3Fk?=
 =?utf-8?B?MllVd0hLV0twQStqMlBvUHVnNWNhRUdWY296Q3NhUXNCNGowdFJ2ZFBHbzcv?=
 =?utf-8?B?SjhlQSs5UitTdjdmZ0hWV2ZjWHlmZEdEUXVSU1RaNGx1V2ZNQ2VPZW4wT0o0?=
 =?utf-8?B?SDhYSE4vckpaUlpKUVlWTGRleXJ0T3M4S2ZNNXQ4WXNiWDE0Q3p0QnQxQkpN?=
 =?utf-8?B?Vkk0dDd0S3pLWWl4LzB6aXhNSHpQK09PdDA2dnhXMkhZOEgxeXJjWWRYR3FL?=
 =?utf-8?B?am9oWHZHK1FWTE9ZSmpLT0YwL2p0eFhUWlF0MGFSNmxqVmt4RmdmVUdwdTZW?=
 =?utf-8?B?YS96SlVPRE83dHdpYTR1eGdyQ0t0UDA0UHlSRndTZVliMktyN3A0aGlNT1VP?=
 =?utf-8?B?d0VOM1c0Q2dPOFdubjlzd2ZpaTVjRWhyczNHRGdCMmJKdVlIOGpjN2cySVIr?=
 =?utf-8?B?VWk2NkFyck1SdjU2a1gxRUpBRWlnVUJxN0djaDY0THRvcldsZ0lNZlBCRG54?=
 =?utf-8?B?WHQ1MFRWR1RKTnFRQ0IwbjJGVi95K1FrcU5ueTBRVTZ0REV1aVFFY05ldzYx?=
 =?utf-8?B?SndvbExOaS9nZCtZb0YzV1lIampyeXhqa1IvNFNYYTQ3TThHRjFRMWRobTM4?=
 =?utf-8?B?WVlOWFFCMm45TUNyRmI3Q3BMSldJbzdWNldWTm1iMGdKN0ZRRFVCOGZCc3Zr?=
 =?utf-8?B?bytqbnZ1aWd2RGFFYXdWcG91OFNlTXVFYWJlSWxveE1PSWVXOFVENzdwclhp?=
 =?utf-8?B?NzNveGl2eG5ORzlSOGJWQlVqcWg2MStoNkFxUThWVEVPRHlZeUFORnVaM2pj?=
 =?utf-8?B?ZGorcWpWNW5CcklnZGlFbWx3VmFDbUZmT3JFRmsxRm5pY245d0hCTGJ5REdm?=
 =?utf-8?B?dms0NjdOc2t1OEJFNjA4ckswV0ZhbjV3M2ZCa1F3dTNrRUxEOG0rOEpUSm92?=
 =?utf-8?Q?3ujsITVG/A6+Cfj7mJi2mWs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab818c1-a937-4fe7-1d2e-08d9ea45438f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 14:22:26.0168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gg6O0ha6IFgLWFJrYFDl9MOt77duSVRxlF4uOtACgTdrgOiioEsc2lVlBPlXSE+lXwdhAgqTJe10KH0rmyd93w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
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


Am 2022-02-07 um 02:27 schrieb Tao Zhou:
> Replace reset queue for specific PASID with unmap all queues, reset
> queue could break CP scheduler.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 7a2b6342a8f2..68ee923a440b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -109,8 +109,7 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   
>   	switch (source_id) {
>   	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
> -		if (dev->dqm->ops.reset_queues)
> -			ret = dev->dqm->ops.reset_queues(dev->dqm, pasid);
> +		kfd_dqm_evict_pasid(dev->dqm, pasid);
>   		break;
>   	case SOC15_INTSRC_SDMA_ECC:
>   	default:
