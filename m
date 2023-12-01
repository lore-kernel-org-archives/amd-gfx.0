Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90687C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 14:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1523410E108;
	Fri,  1 Dec 2023 14:39:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8566E10E108
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 14:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVMiB+49VwMQ773PBabv5ztEUsuqXl6WbXSE093kZObOVH0wgtbfFWEqqp1J32+LW3BP4EdFGPm/ueHmG8Yfs1HDZ3V8Ng1j8Wnn/nepSsUPRyfrt/5T7GpVNb86MvhyZTIYmnAbMj4kpSll3Hjxs8zoTT8AllIBAYP3HvHaXDZCtiHkwZ/Aeul5ta69p5e1ZwI/a+K+6ucu0PbHE9tQsoaOzifMmvULo+bmFFjUnLCV5bbz2J4cxr/tAsBVeSBjZPRFxMCi6Zctjvlik3O8uXEdGDcAhpvXlysefF+v/17QJ2/r74T6qhoDUl8V+sNfZCQAmiSbvneSxKQge8qy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jxNZFNIi3KecSEYdkW9GFcT7Pz9HrFz0+2RwauF2BM=;
 b=QRuuvZ4eYJAAto5365E3DpyH0tds4wqzkSR+2s0Se8cEJHIx+zZKBXEPZCZCNk0CrRD3BtaL1Pydnirz1zgfzyrTZ3OntsU1zCAiEBvNoP9UTNUuCYr/5UDzshh+gafnqccLObFAE/bHte+/ggmwjsZu3TLGr84d++Immg/maJQ3QsbVEkG0ZTr3Ckpd/cAA3CcGj9HGErYCPYHDWOMlqdi4Ozws6TWcM6ZfmjyzFZSRipuiRDM3AURIir37JvttJjLQXQxEbShUcUvJTUEEBx1MPu/352EUPMU6twOoS+a+JwLlP1Ojvspnq4uhmbdoJ1MYq/YQuraKClLJAM9mHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jxNZFNIi3KecSEYdkW9GFcT7Pz9HrFz0+2RwauF2BM=;
 b=SfMG+SCzetiZuQgOXPynbh4n1tw5ZZbstD5ZnCqNts3Ib41lHMG1skccz/oVOm70x8oGJtChV0C2FC9bYdATqWsiREK3og5S0iTi95GQ5ycZLx9SsAViSI4LASASPLyM+oluJslV5YmmSVBnf3dDM4l41a5JprFHAEio6s71vBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 14:39:22 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66%6]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 14:39:22 +0000
Message-ID: <7c7b45d4-addf-4abb-95d7-dc0a9101e37b@amd.com>
Date: Fri, 1 Dec 2023 09:39:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add a DC debug mask for DML2
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231130215630.885802-1-aurabindo.pillai@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231130215630.885802-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::19) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BL1PR12MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f7743b-16ff-4176-23f1-08dbf27b4f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/3s4YU/T4HZW72bfNPzj7V3/can3WMWEQecQQ87lr4GxaMPLdeqUeshQYvrkXCUq7pummOR/CIfrQSJHZLUCAcxBOtL7k1F+/sp2c9OCp03g71ftjI89vpBr6RaYQ7WIM1CCobkZaizX+xK055wPhLEeiKCJw93w8GSGnMBreR+swdNzPrLJjYlOY5496qDyLOcDmgPp/XnevFtTqFvMqYESxcj0Bhb/d6u2Dp3LO2bi680eEQzFJ5ghcbMYeV7GLmy35DxP1cHjDWZudLX2eBw4Ck4H5+AK6+qhMZzItphiu4h862Kr6iMLyXBBIQUimdylNjTCbkaGJpff2P7LSyUYLkSf3Be4St68T92p8cB/5h3mW7dnRwlhUQLajNk2+pQR7GjSXU0qUybnEODCdPWH73azRsz8ZcG1yJpm7vYvJG2gl4PSwtUU4g/38j3YThnXHOFE7893eXNne2ZCJLdoNh0uMtMKPFy8OWhKYZFn2deRZ4CuhCtZzskcL+OqmC9cPbrf/vzh6ki6pGhhG42EZYVN6e3ER6OjvX5O7b8/CXenvHNDoleXgVJaiQfo3mS2/g9yMnLsvy+dTJWBIBIuwV6DPhYJhRDJPqORkO5g9hvUdxOMphy6sdY+CjI31DGp8NQXlcgyhjJdPi+Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(86362001)(66476007)(66946007)(38100700002)(36756003)(31696002)(4001150100001)(26005)(6506007)(2616005)(6512007)(53546011)(2906002)(316002)(66556008)(4326008)(5660300002)(8936002)(8676002)(44832011)(478600001)(41300700001)(6486002)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmhqbzlxYk1iS0QwNUdTZ1RxK0ZrUUdUbmwvSGJpKzFSS2FKUm1MS2gwKzMx?=
 =?utf-8?B?NjRCTlBMdUp4TDNQYXluSlNTUzZhNEpMcjFoRWhOKzVkTmVnbldIRG0xWUk1?=
 =?utf-8?B?UVNucUNXWE1TdytzQjluenJqZWRjMEJPR0pJcHVzQ1hZb2U4dG1VMzRvSkpJ?=
 =?utf-8?B?d0RBOWFZMVZ6dDJYcG40WEZEaU9wZTdjcnRUUnI5dCtyR1NYYjROUlJ4QXR2?=
 =?utf-8?B?VnRzOXJRaXdEd2V3d1dFVlFhWEFoRjQwVExvc1EyRGVRYWV3RGFVVWdQOW1L?=
 =?utf-8?B?bG91ZVpJZUE3ZHVwbXZ6TWNJaTZSWDRsVUNjT2ZjaWZGNE1meG8vWUYvMVdu?=
 =?utf-8?B?UHhXNHJDd3h5TmUzYXYvM3hLUXJMRFMvRWhQTU9XcHZGZHBuWFk4ZmlBRUM4?=
 =?utf-8?B?enQ0ek9ZN3c1RGtrSzlYODVZdWpLVjBxWEVjb2JCeTlnRkFVS0ZFaWMvN1RV?=
 =?utf-8?B?OWJKTVZqdCszS1VkSWZIOFpFVmRna0MxQ3hZZVc4NVJrTWdnRjVSTGpnemhy?=
 =?utf-8?B?VCtoalcyTGV5NFdCMFRhRFFTTHVkTUhWVjFDYlE3V3ZNcGVBRStoTlBodGRZ?=
 =?utf-8?B?aGhDSGFhdUdjbStOcXM0V1YzKzdJWEM2dmgvZE5BNU01c0VlYUtlSllYMUlC?=
 =?utf-8?B?cTFjZ2tFR1JNeWMzek9QMnhQOXltcHhyS1ptY01RaVg0VnpVS2w2UWYrNy9K?=
 =?utf-8?B?NG02TkhYUVFCVFFWZHY3ODRlZFBlY2xjeGt3Tm1ZZUFITEtwMjdoSWhmNWR3?=
 =?utf-8?B?TnBIalQ2dnROM1Brb09CMnNwdk9LSnQyMWJ5T2RHZWRZcnZHOGRvQWdJTnZE?=
 =?utf-8?B?UmdXK0RsdXhXbHVNMzh3QkcrZktmWG8xaGd0R0JZMGJKQzFxdEpad0dnOGg2?=
 =?utf-8?B?WDRYNE9qOTFnYVZualBIaFRDdG1qcktFM1lPdE9ycnFiNFhLWFg5dytKVXpP?=
 =?utf-8?B?am9tNkxRcEZvemhXK2lOcUpOM1VCc2lpMEtQRlhUQ3VUcU8zSVRIazlQaitZ?=
 =?utf-8?B?aWh2eUsyQTVjODgvelYyL2Y0c2JwSjdLMmQyRnJ3czF0blZweXVLTTBQTWpT?=
 =?utf-8?B?T1RUejVWVi9oZHdwaVBDbU5yM1lvNUcxUXB5Q0dKYi9XQmNZQWZKTTZGODhv?=
 =?utf-8?B?WmNIWllPbExRenNyNzlrQmR5VzZEQWhIUnhkbDRoMHpWNll2Wk5uVEwyUXJn?=
 =?utf-8?B?eU5SWkFodHhydCs3S2pFMHNoV2VJay9VZ01meWg1c0ROVkl6Zjk5cDl3dlJu?=
 =?utf-8?B?bnFlQndKRzNtcHl1RVcyMUJkMk5Hc0F2a2N2azFzKytoOGRZMlZYaWdWMXh1?=
 =?utf-8?B?SDRkNUFobHZLZ0Zld2hHbGgyVGZySWxSNVFRaGlvVDdML245VklONTMzT2N0?=
 =?utf-8?B?Q01GSC90UldmZ3BONnVPVGthWmZtNXVQQUhFV3RyUlgyd2kvVlNVREt6d0Z1?=
 =?utf-8?B?bGdXVmNidTlaOXFRYXZPdVJLaGJrMFRmZFJialc2eWRlUlhLR1RFTHNacHhh?=
 =?utf-8?B?OFE3Y1lobU5HY2Uxb1Vza2ZWMXg4YjZTWGlURzV3YzBIWkgyRG1WQUMrR2pi?=
 =?utf-8?B?QTRkNStva0MvVjhwYm1rM3RsVGVFZHFCMldLdTRPblZWc3BubEVvdm4vWUFm?=
 =?utf-8?B?Unkrdjg1OWhQMFdqYktIMGRMbkIrSng4WjNVNGpyVGlzbHh4elZKSzdwand2?=
 =?utf-8?B?a1R0VFFoQlpDSmpxb01KdzA5REtjb1ZUS2xRejVSOElWVi8rd2ZUQnNtZkl5?=
 =?utf-8?B?am5NVnpsYXQxQzBhSk5BZWs5dkV6L0NQRHU0N1R2cndEUkFuMmJ5YjBSZ0Z5?=
 =?utf-8?B?cEw4STU0a3V2OVpUNEt1TTlVczZIVTZyRHFXVVdCR1FoMHhMRmtlbzRXZmpX?=
 =?utf-8?B?cjF4aFdDQmNWc0xKanNmc2pqU3d4RXlieC8yUHFPSjQxQ1RYbVJCUTQrVFJp?=
 =?utf-8?B?K1NNSWh1cU8wTDArdXl6OFFKalVlSUdjSWJ2TDY4Tk5xdUJFbUhXS2lXQWlW?=
 =?utf-8?B?RmlyVVNIdGpBeE1YVEYwWTB5ZFI3bTZmQmJnV1lHQ0haZTFqb3VkRlVpNXlT?=
 =?utf-8?B?VHVOWVovKzEwRXJiUVVvZkQ1dXV2aWFIN1Y3c3kwMnhMZ1duRTlTK25GQkU3?=
 =?utf-8?Q?K4bSoi5gPreeZN+c6S0mkbmta?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f7743b-16ff-4176-23f1-08dbf27b4f09
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 14:39:22.5692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOLNA4Y24OwQsTDceQbBKDJze9LsJixTOwqsaKLx84RuZAst/smKeBlQXAx6e65grfnhx+NV5YY1pfHxsF79+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
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
Cc: rodrigo.siqueira@amd.com, hamza.mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-11-30 16:56, Aurabindo Pillai wrote:
> [Why&How]
> To enable testing/development of DML2, expose a new debug mask for future use.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 579977f6ad52..ade68972ec28 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -255,6 +255,7 @@ enum DC_DEBUG_MASK {
>  	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>  	DC_DISABLE_MPO = 0x40,
>  	DC_ENABLE_DPIA_TRACE = 0x80,
> +	DC_ENABLE_DML2 = 0x100,
>  };
>  
>  enum amd_dpm_forced_level;

