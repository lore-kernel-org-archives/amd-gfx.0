Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EEEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 15:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D75360F8F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 15:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D75360F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3ACA6EB2E;
	Fri, 12 Nov 2021 15:59:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D575C6EB2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 15:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRvcg6kl1qAvr0sIV4m229P6uyjC34xC1EW9+l4hmtoEqzh2Feek6sLXXTO+0mduQ8q80ekJF6NRoVGZlNj87BU1UE9d2Pud3usnkRcGeN97kCTTLxLiIe5MdDE/aHE1F8I68TQEl5MWoOWp2W7Are01B0b4/CZlu4bZ2J7E7pnlF0Z54Vp37mXKW1nJs/DvARxg93X5kiiXnFkK5OSFto9Akf6uQDE7GCMDWY+mRx0bKK+pKOs9yRs/z2e/cTrIy6TJMKQLsHaAO2DkEkmZwJkAFKJCADSUzRcEhqN3G7WhUtjLnIoViwsKwDmFBhlP35ykuFlYGpYnA+C3G7K8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTZkza4ws+ngVxsGle0k7PWUMN5yo8bLJGnDNfVrDQA=;
 b=RVvdjuGErVYmexlSlN6sIOaP3ccocub7ccreW0fiTwlRsivo4pNjpswo21qfIgbJwC2wZdnCkzHryaUXTvx3lOrY19GbvbJIaaDWF3DtLc1FC8h8D2A/sT+Vl9P9Mi2evstwXQcqvWnJIrVfFK0qNKDXWbvXzCkLzqYDffLd/WcxX1HAaNmv9ZrfdB7xLu0Tu3486ndxBzDbFdw8QGgeRfkwpl7mrz1BhfRaRfq+Yx10Bw653IC67qbrITqn5CywRo/NYMqDPQD1YHxOtERaLkazQkubQ60tkvi/nhdDP3wE5klviCia1Oz4DFCBEbmapDv4C2cZK/ZSyVYgijQ8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTZkza4ws+ngVxsGle0k7PWUMN5yo8bLJGnDNfVrDQA=;
 b=aX+7Aq/AHGvu/zhOHVdXaTeI+wG5R8Hzwxmu8H5xwFzvvxNQiC+ovW3WoGNxCpJOteJV8KXKBLbtNn6H91GjKi8aM1pEbiF7NoctA0jhOzoeDp6F8aS5aNZJO/iXRLK/6puCpB+9wshYbnPulo7cR92Z6ZxjGOpUz3eEMOFySg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM6PR12MB5533.namprd12.prod.outlook.com (2603:10b6:5:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 12 Nov
 2021 15:59:26 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%8]) with mapi id 15.20.4669.011; Fri, 12 Nov 2021
 15:59:25 +0000
Message-ID: <e0cc3d04-f78d-f1fe-a0c7-50198690d64a@amd.com>
Date: Fri, 12 Nov 2021 10:59:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: Reduce dmesg error to a debug print
Content-Language: en-US
To: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211112155618.5674-1-hanghong.ma@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <20211112155618.5674-1-hanghong.ma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:208:23c::35) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25 via Frontend
 Transport; Fri, 12 Nov 2021 15:59:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea2dd71d-e2a4-4566-1f00-08d9a5f56697
X-MS-TrafficTypeDiagnostic: DM6PR12MB5533:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5533F23C1401E998BEC59C8FEC959@DM6PR12MB5533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLzUrKGBUbbHnT5db7jTg0oz8CS/AgDkMd1pavFeoL53UifqGHvZgnICj8bqtmuA+ZgoY8IuWm/EfrRGKS2CpxqtriOLuq8HBQefux+z90g82SfW9oitYPqtnyyHkU3/gF/9e1Y4ktO2g++ZGDVIChHIRdpoUT/h4TMGMaS2tkxys/dqkI3VaMZHZkOsWsG92IC6FBsbtWTBEudhI475rHfG867tn/cr/uoT5/2yJ+GVY1vkOyL8ZWOvSt4KyYWGA9pCCsyvZ40Hzj8esFqJAJ28RqcYRZc09JJdxcg8bIgLPe/bqVzNZED7zmaiEn9/BBvsRgmVUM2Ft5W2LT1dsAw67ERQOWKrb+kHOc6bZivLHXxdttW4XOetE2naJOUdx6raTe4QPgOcrMUpqg8Zd0dPjr/MGVDkBpKRZEjniwTrjXVrMEv9UywpkGpzLsCopuAx3j+b3leLNOzoGmAFdszv2TaCSDb17LM4hhT8OdSbVzTcWTKLOgD/6QH7NC4C5jhrDiUVGII67rgXWyMZ8kJa8QZni4fY+i9i4xsu1EEvrk4CDtcFz1FMFgBVcls65wBddTxglZ8IEIsHlig7GYnpZM9+zD6RHScm3WaAuw6pS0/x4FKepI/mAxv3Y/UbX9ZCIun22y71lQo/UQRnuvH7ShVFh8XY26ADDijD1vmPZ+5kXZ+iQvJS7AkJPYk5eEzsn2x/xhVbfqg2gsYsxQkPo+KLw8aLbTvwfYQ03LU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66946007)(26005)(186003)(83380400001)(2906002)(4001150100001)(31686004)(38100700002)(8676002)(86362001)(4326008)(6486002)(53546011)(36756003)(66476007)(66556008)(956004)(508600001)(31696002)(2616005)(16576012)(8936002)(316002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1BTeUlsSFc0U0NlR3dKb2RsUXRMRmtWbHFGMGs1bUNKOGJWQVFGdEtOYmow?=
 =?utf-8?B?ZFdGM3VSY1RNUDhvanhPUk1lUnJVcVRRWEtDWU1Idy9uSHljckpJUTVra2k1?=
 =?utf-8?B?dTNHTlB1V0x0V051ZGxoOTVGa0lYSWJFY05BSWUwbmFKdjhWUUROekZIOVJw?=
 =?utf-8?B?bDNXMkNhVi92NkEyVUFhbkQ2L3I4ZjJSUHRjMzNjMlBMWFJXbnd3QnBZb1FC?=
 =?utf-8?B?MGgwMWVxSC80QjlXOVJOQUpoNGptanFmNmdjZ2w0UEVWUXdGNTFJM3pxUnlk?=
 =?utf-8?B?L09UR1NRQnc5QXRpaG1ZQmE1YzVUNW9jeDNLTTVMMW5sbzdvVnI5UGh5SjJM?=
 =?utf-8?B?eWsyclp0cVM2anBYS2c0elBKTmNLa3RBNHpNYkxReFo5VGdEN2kvMGd1S1A1?=
 =?utf-8?B?c2ZLU29IQS9sd1UybG1jK08xT0x0aTkzSnl4cndSUnJ2cFBWbkNCSmJ6QkRZ?=
 =?utf-8?B?bWNZWWRtNzdJbndNTXVDOElMWFVDZU5OdUZ6YU1CK1I4b0xKVGp2S09LZkJ6?=
 =?utf-8?B?T0ljdGpiN2QxaU1HU0ltVkJSMnBGcEc4MnFFNGZuRUgwN1NFZTh1bFJ3blJ5?=
 =?utf-8?B?VXA1SUJhNFFOZ1ppenFGalR3TUZzOGZNb04ycnNPeDhGeXZZMGdVVDZ1RUNs?=
 =?utf-8?B?ZHVTY0JvTHlaUjFORm95QlhVU1lFVDNiNXhWN2l2NjF3T3lscnN4WFA3ZFZr?=
 =?utf-8?B?V1BzU0xuZUEzeTFKaEp2K0QxRkVNa2d0VnJOTXJDQ01iYllYaGJsY2JaaEtz?=
 =?utf-8?B?QTloMitUMDBRZlZCV1JCZWlINFAydU9LSnFTY3lxbHpFaHFPSzRQTEhhTHVi?=
 =?utf-8?B?Yk1pQjI5Wnp6MkdhZEhhUGVnakJZdnBLUjgxRCt5TUlOYUdWQURjMUx2a0hL?=
 =?utf-8?B?VzZqclVmWEFKeEErNGF2K2s3NXBrMlpjV21FcnRvQ2RqM3pjeUQ0amNTMTdX?=
 =?utf-8?B?NXhyVVpveHkwVCs4TWZONWx4QnM1RXRTMVd5enJjMTJCd3B2MUJXNGpZWm1U?=
 =?utf-8?B?a2Y4Y0pUdEp5dDNmVUxlSVdsK0hwWjdwV2h0QmZ6R1gwNEJ3UUxsdDlOM2lL?=
 =?utf-8?B?S1NkOUNQb1RwSzZOTVhJc1JUakdpNzBtdW5zRjY2MFYvQTlWOE9KTUhlOWhU?=
 =?utf-8?B?Z3dacXZmbi9zRlVPZVJDVGpBMjRHYjNKd2VCcFViOGs3aWV2ellzb25UcSsx?=
 =?utf-8?B?QytjUHJ3Z0hia2YvRWVJV0RmQ01UNWVFNGVrakI0YUh0SHM4bmQzNU5qWU4w?=
 =?utf-8?B?WDJoMHF0VEhONWFQZDRiMmF2c0J6SmRralZIZnJIU21OdDZvcHhLeVdKMlAv?=
 =?utf-8?B?Mm5Kc3FXTXdwZ3FTM0FEWWdMQlBIaFN6YVIvL3BwWkpIQmE4Wk9TWlJqWURL?=
 =?utf-8?B?VW5wOFJmd1EzTDFkNDJZQ1dxWGhuSzh6M2YxVzYrQ2t1VFozc3ZMZUJ5Z3Q2?=
 =?utf-8?B?SVlGVGxHY2M5cDVSVTc5ZkxpUmlVQVc0WmNPKzY0VHNZV0JrZmVKYkNRSUdG?=
 =?utf-8?B?dkV4V3BKYmI3amZQeHRuaElhbzZkNkRNZHpZU1F1ajcvdXNJMWRhRkc5OU4z?=
 =?utf-8?B?eG51Y3JZR05rZldxbnhLd2lwQ0c2NGJDd3Y0ZmVGaXNZempmOUg3WWhVdE1j?=
 =?utf-8?B?WEdiTjBvcnhqMUVqRXI5VWVmYXdqU0hFV1NuWjNGMDNZSDNORkFWOE5SOUpO?=
 =?utf-8?B?aEJHR2RhQzdaTS9uTmE0dS9SMnhtR0pXQUdtZEt5Q0piT3VhazNDS3ZYVnhs?=
 =?utf-8?B?U3R3by9zQyt3U0xORm5ydWQ3b3hxNElHeEhLRUNSK3c3eTZqNDljR0JhWjUw?=
 =?utf-8?B?dWVlVnFPU3lnMTNBY0VheVdxNDZndzc0eTVNMjZLRFNBWUFSM2hUMlNkQkpG?=
 =?utf-8?B?Skx0TG5rbjRpejV6YWZMNUpvbCt5YTd3U2JtNGgzRHVSN2U5b3hwRFJBR0xp?=
 =?utf-8?B?a3UzazJuSzUvYmlWR3FlbkV4U1FSaEJBczAwS2ZWSDFvRXJZMCs1U0pVQzY1?=
 =?utf-8?B?VlZyM25TeDVEY0pTSC9pejJLdEpQcXkraGZjTElId3RYd2N4OHZYUVZvcGg4?=
 =?utf-8?B?cnREV3k4blJPeUFBQUpOUVBMelpFbEZRMmIwSzZpOVFkQXpPV1dzRms1YStT?=
 =?utf-8?B?ZW9vNVptVDZFVVlCdmNzMzR4SnBHMDd5MXIzajRSVjdpUTREL1A0Z0tzZGJO?=
 =?utf-8?Q?cZ9A9UaF0EtUvB6QrRmdpuA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2dd71d-e2a4-4566-1f00-08d9a5f56697
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 15:59:25.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCvG/RUB5Q1wAdOUqUXqK+9utZbN26FySLIDa1tsWy4VVU5DzSG3rcSbjVaWrFaAmJElyYVpeVWYWu6sh0DMNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5533
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-12 10:56 a.m., Leo (Hanghong) Ma wrote:
> [Why & How]
> Dmesg errors are found on dcn3.1 during reset test, but it's not
> a really failure. So reduce it to a debug print.
> 
> Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>

This is expected to occur on displays that aren't connected/don't 
support LTTPR so this is fine.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index cb7bf9148904..c7785e29b1c0 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4454,7 +4454,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
>   				lttpr_dpcd_data,
>   				sizeof(lttpr_dpcd_data));
>   		if (status != DC_OK) {
> -			dm_error("%s: Read LTTPR caps data failed.\n", __func__);
> +			DC_LOG_DP2("%s: Read LTTPR caps data failed.\n", __func__);
>   			return false;
>   		}
>   
> 

