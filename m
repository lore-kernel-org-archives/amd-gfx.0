Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A28C88CB2
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 14:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05FCA10E28C;
	Mon, 12 Jun 2023 14:18:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02C310E28E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 14:18:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT8i7/Xp+C5m3O4TtrHIxHGQdvZHDmLxAW97FKjeb48qLYmV8fGIKjtSyDPoEYnPoRLiHRxrWJ4wXOQf77Fo0+wJGhQ+mMbbSuoHWPhslWr4R9l5DZMQ9KNcEf8uCcYbA31GhkOcgjN1XnAlR88XYWZcjGMvadcIWY+cSufDb4nONGwaj1LAynyLrgycZIpuZmtc/WQ1uRy60DdpkdwpoHk5v/of22ICBCYCCrn/XglLwI8+E6VYCtpQgDX9hnqAed3bQVb9qNCiKsfoWPjGsNl5Stri9rOVI4xayAkmFcUBvXxpPipgFpW+AOZ/eIPGe2vvmyZrFbfswIWt7i53EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKuRGXTCnPP+Sy0YBaD3O5KVAR1ACRl6BlTh8E8gZ1Q=;
 b=W5fwekN7yN+W86y5gL53OCspzJGS96N4zZxuqhyrE87fclwf1Q7LOjvvotYCJeHcFrMCHKHFm69J0oqJjvxWOIx/rsAx0NmY9gb4P+kFSx889l2O/CteOU6MEPbe5AgNAyfEqTndBFel6JABLoIBC3wuVYcpgBrRP3CTd9oWLaJlYdRK9nfI9mSJ0XPiUDNBmD/NccqM4kyDqjT9eMhD0OQJ2+P4Nf9cLx2Prso1OLLDgyN9zBBR3RcG1Fsh3dobZa2rCE7ka3/fBMOCFg7M/HFlwg7N7v8HQTNTG55VppsVrVHEm7Os3K4DLHuY0cZFk/rYvSi4b0cOhMd9MHcxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKuRGXTCnPP+Sy0YBaD3O5KVAR1ACRl6BlTh8E8gZ1Q=;
 b=R5UHkkwyt7RlNdoyQ4qkfzZ4onW5Z54Kd/yMeve7KTUVMbFMHUSOxbyf+V2bv92Uom63wABcWxyZxrkFEPxjVPTqS1yNXsHOIt4T5O+mI/nIcHTb1ntdAGbojh3pNnGI/CTOH4UCAdVHw+Ez9+w3ZNTiXGeXhLjMHvlGyF01Arw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 14:18:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 14:18:35 +0000
Message-ID: <50548877-3012-2869-21eb-1e5224700a9b@amd.com>
Date: Mon, 12 Jun 2023 10:18:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "drm/amd/display: fix dpms_off issue when
 disabling bios mode"
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230612140019.720959-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230612140019.720959-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0313.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: cd18d4c0-6d3f-4aa5-04fa-08db6b4fe8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAtWMhEy8+kuXZQ6JLXKQW0/eXvebqhphoD3awmwAKk59O+0+2W9o5qMQnxRm6Mjz89+WmZMZZc2sBVxI1XV26ubMcEItjb+ha2qYHum5/6NL+k83G2i3j5iuS6T8bId5ppIXyZ+uAVKkRmsJjql9VNan5tqOhALftRDIekbLI9CAcI/BuP3Th/VQA6ApuL7USbaebqIa2YIl1ss8tIjraTOzKrr+5ootVlXV5o7kv3Uskgm+bdmd3RAmapZnebZihvfwphPVo2zxLviL5XL65qBkuZsFMiauJd/szANjZ07+gMHpkB7MkeaqMT7MbbENzvnjjBE8flggcaqH4odFJG2SMLxyvD5VY8ICdZgyvvjqg+P7aLjbKz+sKPZ+ed1qzbejII6tjwdLkGfs+gUFy6zOELGV9V4hunZP+ISy8eir5yP2IfihEMeG8pbvbrg5lr/baWFfeKmg7ngbiR2vrTdUnrcZ5dhsSbEYaclnKEJe+sYqbLYVjWCifQsw4tEnABSK/iQtVIeExa0NuyCmDznjblo45Hn2FRjAFgke1u1R/eyFpt/TuPaacuWgvTf1U6gyiYmFu1qvBLi93wvEbnqWuG8nUZXe0q9Kg1cU+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(8936002)(8676002)(44832011)(5660300002)(31686004)(4326008)(66556008)(66946007)(66476007)(316002)(54906003)(2906002)(41300700001)(966005)(6666004)(478600001)(6486002)(26005)(53546011)(6512007)(6506007)(36756003)(83380400001)(186003)(2616005)(31696002)(86362001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZCelNxOTEyU2d1THVhei9iZ0xERVRDdkM5R0laMUZoSzNvVllReWtuS0Vo?=
 =?utf-8?B?SWJ3RVJMMGw4K2FHNkp5SXhzVnlQR2E1ZDE4azJ1Tk41b3ptRzRLTDFDMjQ0?=
 =?utf-8?B?QnFQZ2VHUEtDMlpYYUgvZUlIZXRSQVp4S3pod3JsdG1QdThvVHdRSUp1bXRD?=
 =?utf-8?B?STd4NXZSSlRjOEpST3dLSHVPVDA3eXBVNDVEV3A3bXk5d3VmczdIb1N2VUln?=
 =?utf-8?B?bFBGUytUdGpxdHpVRURQb3Z0aDR6bS9CTGNzbURtK1ZYK2RFMnJZdWNhMHdT?=
 =?utf-8?B?aUdxMkRWSXlnU043a2ZOd1NCQ1Q3c2NIS1VpazBCVllsdDhLeGFvUW5ST2FP?=
 =?utf-8?B?ZC9vZzNsU3dHZVY3Wm9nWDB1SHpVaGIzZmV2OFViZVNyaXJrcExHeVJvdTJ5?=
 =?utf-8?B?TkJTNGxoaU9WMVUwRFU5SXhTOEN3V0R6RDRtK1kvZjNuRk5tUWRoRmlKTDRB?=
 =?utf-8?B?d09CbGJlTjMxT2NVb2hjemhjUDZSTmdiU1lURkg4SVpDQTk3dGprZUFrVzZV?=
 =?utf-8?B?ckZPdlVFVXVMeDliMVFHOHl0TDN0UTdWeW5IV2FIaXJMampzZXp4eWxtL1R5?=
 =?utf-8?B?Um00cit6SzB4VnhscXI3czZuaGVWS1JrSDFFdU9IVkxxQTNwc0dEcDEyQjNh?=
 =?utf-8?B?SUlzRzA2UE1mV1hiUzNzd0o1eTUrdzkxdGJsTXVmWU5oNWMxRkRDM1ZuUDZP?=
 =?utf-8?B?bXhJUjBKRU1hdU9HN2I5aFNTd2xQMVNhdUlYMjlNMjV4R29Tb0xWK0kyWmFE?=
 =?utf-8?B?dFBncUNzcDhPUXQ5SFZTeHZXeVRIekVCMFJUZy9Dbm94ekp0YWxFWEFrSHNM?=
 =?utf-8?B?SjUwekdqU28zcldsRzl6QVpVWHlkNXhKamI1UXZNUHdoclo0UDBRQ0ZWQTFF?=
 =?utf-8?B?WDZ0UUw4RURkR3NUbnR3ZzlBalhTS2tKMUdWMCtwN0kycTZic09WMHZvem9y?=
 =?utf-8?B?cnFNcnhDelJQWFQ1WHBVS0JKcTJwcnluaDVLWXBkMUVkUzZnRlBlS2VLVnlR?=
 =?utf-8?B?UHRxcTRuSE04L1ZzdTN0aUhCN2oxRFBwUXpLenJGL0c3cW9VYUcxRytPVVVB?=
 =?utf-8?B?Yms5eGQ4b0E2M2lBVjhqSXpVUGxOZXJ2OVNwcVdiUm5RRFk0Tmh6QkNHZ09k?=
 =?utf-8?B?eXRoVG9KTlNMWnVnL3MzcUpDVXY5Sk5jYzlaYmdaM3B6LzBuRzZwZTFXN05N?=
 =?utf-8?B?RHVtRXpXSGJiNyt1RldQemZDcU93Skl3eTRFT1pvN01JUURvMDI1NmsrcHRG?=
 =?utf-8?B?T01qQnJxZ3drSnNTRk84bHdWYkdsNDUwclhQU1hlUmE3ZWZLUTAxc1gzbWhD?=
 =?utf-8?B?S0IyVnBOV3JlWlRRcVRVSzB1TThJT2N5ZEN6QjhsMDV2RGp3N1JMSjBDY3hI?=
 =?utf-8?B?R2xTc3lENHRtUDcwREVIekJJV1ZLWE5PclBIRnJRUDZvbUR0a05XVCswMldU?=
 =?utf-8?B?bzZWRFlvWXdFZzQ4QmNpQkhscm5tQ3BoVDlNWXVBOW8yTGVac2p2SFRjaXd5?=
 =?utf-8?B?NHhrWWZBb0JuWjNaaDArdzRkanJlWk5ic2RqaDNLR2QrMnVtZkNqMDk1ZUNx?=
 =?utf-8?B?dTI2MzE3ZkxoaHhTUFF3VXd3R3pyeitGeWhJSGhPSDFiSUxQZ0lvc1I0dUpE?=
 =?utf-8?B?dkdYbnBuSklxQ0NZS3pKYVpWaU5BcDgyRTc2aVNPYk5DQjFONVczMXJEdllQ?=
 =?utf-8?B?VDNRMXNLempCOGVPRndKQzZNTjNsNWUvcnNKVDMyVndaTTNHUHdHQ0RzSGo1?=
 =?utf-8?B?SFFnMkxhUnNUZCt0LzF2ZGg2SHd1cTh2MWgxYmNYN1lMS0xHR1dJcGVnZU9j?=
 =?utf-8?B?Y3ZjUVk0c3hLUXVacHNYK3FJbzVPdVFIdSthQmpaVmIvZUl5MUYybDJOUWh4?=
 =?utf-8?B?ak1ITlZkQm9xL0JrT0RTMG42R0NXRTdFR3dUYk5mcUxSR2NEOEQ0SWM4a2R5?=
 =?utf-8?B?V2FHcFJpeWs5S0swaS9nWnBSdHhRMkZ5NkVEcjFCVWRibU4wZE5XSWY0RVln?=
 =?utf-8?B?TFZJMnZaa24wZ1BxcWxQbWRmSHpSY29tdjNDaUM2c2lQQXh4VzFTM1ZqWG5O?=
 =?utf-8?B?djkrb3hPZTJqK3NPZWhOVUZSWVI2aWdZNDZqOU55VEx0RUZKRlhndmNTd200?=
 =?utf-8?Q?4zyRQ6tai5gTo8IlTHSkOK8jC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd18d4c0-6d3f-4aa5-04fa-08db6b4fe8b6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 14:18:35.5254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzBPSBJcdE6KIuzT62Vx4qUIL6lfwU/cmh03XWmSkIlxYcVBa0JjiwJgVYbxcApXoUs/vPZp73x69axqOZwjKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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
Cc: Zhongwei <Zhongwei.Zhang@amd.com>, Mike Lothian <mike@fireburn.co.uk>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/12/23 10:00, Alex Deucher wrote:
> This reverts commit 58e67bb3c131da5ee14e4842b08e53f4888dce0a.
> 
> This patch was reverted, but came back again as
> commit 58e67bb3c131 ("drm/amd/display: fix dpms_off issue when disabling bios mode")
> Revert it again as it breaks Asus G513QY / 6800M laptops.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2259
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Zhongwei <Zhongwei.Zhang@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mike Lothian <mike@fireburn.co.uk>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index be72e03cdf92..5d3d61faeb28 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1296,7 +1296,7 @@ static void disable_vbios_mode_if_required(
>  
>  					if (pix_clk_100hz != requested_pix_clk_100hz) {
>  						dc->link_srv->set_dpms_off(pipe);
> -						pipe->stream->dpms_off = true;
> +						pipe->stream->dpms_off = false;
>  					}
>  				}
>  			}

