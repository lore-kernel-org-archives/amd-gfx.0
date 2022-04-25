Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42105C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 19:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D390910E7F5;
	Mon, 25 Apr 2022 19:18:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E28EE10E7F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 19:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbHpKaNM+Rnou95ByXzWfEU7JxzBtYofludZFYHMPz8Mx+FbLONO+HDX+xPW5/cRUp3yIal/C2DuYwVZfF3rZWubRlut9rCB0aGnsPi+o/ygdA4z6QMl6I0ypHic1BwJHQvTzFAibClrwDYgR/ypekE1KM2WGNGCllSNP7DdcXLqPYHDG8+YSzns++fmtKtF1qbGMubDhuDUP0znpNCmg5CAUO5w1g206TN0Qq/72kOHrNDPR2soFFr5c+I1AEbkw4brzEYiRow6q3iMqXA2UNC3vL9/kZjowUMz2EwN96zDdnevLGYEIDHWXCa4El5eFeHCFQIrfnywV5n7KZmVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow817mtNPI74vf98YpcsERJjyBhz9/n6GJw5DOcLErE=;
 b=QjjDxKkQl/27veeZ+1QKTHhaLTk0B4k5aWyuc4Ic672KaEw600B2fYBzz8s3z6xnAcTr9JUOIFrO13GbU8KQHaYBkVff+W/1oN3POHMncT4FYZVkVjUmOwMgdX0mjJuov9zWSPi2WehxhCI3u0wTgg/S/MKw7c4RChibqVgpawmhjlZPN/X81o11Lv7aYaiEoLwc48+V2CgUaava4m35D7LyGlWqC7BWtLM6/5A79TXKbyps4+7WwVD9PtyoPWXXDysnNferwVcFZ5w9JpB9ei6fHbZiUPt9cz+199uOj9hfKtrP7WsSo1mbXp0fm+gMEryRiGlcowlDsmvW2ebkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow817mtNPI74vf98YpcsERJjyBhz9/n6GJw5DOcLErE=;
 b=QKQRM8Wwi17GgburUy6reQdQK4moEdu58uj7zY5IzGf52odoin++eD8eoUDkYBfxZMcAVTQnpDAJHzfAUEch3WkvG8FiOockIPoqJLjonav7dD1wbj5543YEggYSznIy1DrDNs03AUADJxMcwnOUgVCVcBrUjHz6sh+pqfLL2Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 19:18:15 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 19:18:15 +0000
Message-ID: <0e2f7ba5-461a-6df4-f694-7d0b4198dfbb@amd.com>
Date: Mon, 25 Apr 2022 15:18:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amd: add dc feature mask flags for PSR allow smu and
 multi-display optimizations
Content-Language: en-US
To: David Zhang <dingchen.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220425191008.775902-1-dingchen.zhang@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220425191008.775902-1-dingchen.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0339.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 582ebb99-d9c7-49a9-06e5-08da26f058e6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5131:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB513119E882829235E2A7D9DA8CF89@BN9PR12MB5131.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmFxHfCzIQMQ99CsYseiIx4Y3M5X+/VtPUaQMhR/EK/hKdCtH2i1iIrVICjA+xZgofigbHC2tSKgTIFDurLrkOIAtpCdEhu5huuhrDMw9oAIZdpjoXRRXsX7IliKCHVkUYYwvq145r2pVqcAELnsMMO/bbpGRcokRRYpYHUWNLAZz3xnz97gOPYuqL8geEeOPg/JdZoYgKEPznDuvK4wT/0ErEzisqC9nBD4YTgVl5mYcbHh1tZxyxB1PV9FQ+jq4B0Bs7Ye7fIbg+HmIDNE6bp/nTiDxmYN4YJl25A9r0Bpf7w9Wue0KkZFiSMkW/8vUPuaU0ZiHE74aWUYbmjtj/m/K6pI+3Hr5z2mwzwxVCF2/lC2ak6CWpQ1uOO93NCZ3NikbvXpMfhXNJulG7/JI81NprMBLf0tK0EVUqWxh8hxBGBhEkcb0Xf0A6A1lmpu1ZI8udvmqZ956RjxaKEv1uJHopvmoHEQdv1pC7h++C1GA2Usfs0tlzyFTQxIXu8u0JTxGftX49g/E4KowSy7t9YT5SRMBbUYFJ2NTEm6dAlzsA0iiWeZJdbgHPckZd3oQKlkWQRRGS1V69dwg/oji7zTwOLsT9uChTvfNDuy+3hpQUJ3L/SiwW54eYweYUB31dVdfwATWpdJHqOKnlUiX6aV7tDyu6JikVmu3JQy8YP+f1bCNP0hefd0eqi8Nl1391AUKPLRy5YI3NpzUepfqPLmZvj4GuNE2Z3NOonG2jBz9RnEXafLOby1dWaYCGlG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(66476007)(508600001)(38100700002)(5660300002)(186003)(31696002)(86362001)(4326008)(6512007)(53546011)(6506007)(66556008)(8676002)(26005)(316002)(6666004)(66946007)(31686004)(6486002)(36756003)(83380400001)(44832011)(2906002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy9uai9jV3RVNmpIODdmNjczZnhaTDNGL1N4cTZjZVNydzBFZnZYY1l3WlFP?=
 =?utf-8?B?M1ZVSzZ6dkxHL21TczN0U0tTbStEVzhWcUpYT1FvNDJ6YTBQTGpYbUU0ZkxF?=
 =?utf-8?B?Y2pMSkVPQUgzYWxXUTRhSll6VE1KNVYxaGZicXVLM2h3bk9UT3krYVVyZUc0?=
 =?utf-8?B?bVVRR21Uck5OaDNORHgvTUNvakwrbjlYc2ZseUkxMklpZHlPc1VXOHhEOTUr?=
 =?utf-8?B?SVlLd0pkZ09uTXZmeGFuWDdjb3JvOEcxYW5nY1VvTFF6c1pqb0FqWUg0clZX?=
 =?utf-8?B?cmMrcjV2UXd6RUhaSFA2WC9Gd2o2U1k0cG9WNHNETDUxMStzVE5WemxBVzFL?=
 =?utf-8?B?Yldxb3VRRy9saGp3eEJYblAwUTBpY0Y0VEkzOHpOTEtXZnNkcDErMlpGazlX?=
 =?utf-8?B?dEFQdjB4Njl3cWh5TDlSbnJtNkhIRmVMVEVJNUJoSHcrb212YVFteWNqcjZr?=
 =?utf-8?B?K2hoM05yM3lncHY4ZEo2cVZPZ3ZzYy9NYyt2Tjk1dU9UdGtFK2UyallMUFVo?=
 =?utf-8?B?RDJyQWlkME1WRGhaWDc3dUxiQkoyMjRqUlAwVzRSRUpDYlVoWlJJcWlyeUFp?=
 =?utf-8?B?Z2VUayt2UEFUeGVTdWxUVTZOSUtQUk9YenF1WFhqWGh6bVdERTdTMFU3TjM3?=
 =?utf-8?B?OHZzbXEwV01RNk01L3VwVGxYYk1JeWpTcGRmWGR1eUltM241Q3p3NUU0YTk0?=
 =?utf-8?B?MllabE4wRDBobTJLMGkzQ3pYTkoxbHJQS1RXbzlydWxvZytFdzl6SXpyWkFt?=
 =?utf-8?B?TEUyM1lxRWVua2tNVFFmaDJLTDBVb2xCMllWMFF0Y3hSd2I5MDNpWUFWT2Jn?=
 =?utf-8?B?ejVNaW4wSHY2TXpUdVRoQjEvT3pmVmR1dHIrb2lnU0JLWXRKdjZUblY0Vnla?=
 =?utf-8?B?S0kxK1JvWmZYdlZnYU0yWVppUzluMVJ4YTk5amYrRlhROW9NV0l6Lzk4TVJp?=
 =?utf-8?B?cE1HNWR6bms5NjI1TU5NZThUNVRMWG92Y0JpTkRYSXlDM0RFQ0U0cHhud2Nn?=
 =?utf-8?B?N1dwbnR5emh2N2JvSjk0aC9wTENkaFh1OVlqS2FDbWQxMlFUQWlOaCsyaG02?=
 =?utf-8?B?THhPckR2RTh5bEwzU3YvZWNac0ZjdjZLOXk4T1lCaEtSU1BjMGZPVlNSOEVr?=
 =?utf-8?B?Uno3V293RnBRQVpoRzVKWnErUEJGT1lXTmNqU3J4Z1dRNXU5WWhRVlpYa3Rk?=
 =?utf-8?B?aVBhYWdkTUtqUEhoT0FpWTJXS05TclNueVNvOTJZNE91OEI0eEg1Z1h3c1c2?=
 =?utf-8?B?LzNweUFyZWtIbzczd21iMkFMMnpoTkJZYWRTMFdLVERsR0JxNCszR2F5R2Z2?=
 =?utf-8?B?N2k3WGxJSDdTakI1enJiSmtVZGVjTm5yS2NyRVJHTFdFeGxOSEd2NFRBU0tF?=
 =?utf-8?B?M0xLbWRkUzJzRFRaNDV3WUFWejVlTE1XS1JQOVhTRytJampodmVEVkk0OTJx?=
 =?utf-8?B?V2EwNjhCdDBId1JrVEFxWHE2d2VjeEh1TnRoRjR4ME5MNWZ1U2dYY09WTUlk?=
 =?utf-8?B?cVptMnI4QWVmbmh4UE9XM2lYVE9XbndvaXozTC9LUVpZNHFwbzBUZnJhZEhP?=
 =?utf-8?B?TXNaRFZxVyt4NXd5MGsrTjU0YTZOQ044QStZM3k5Nk9zK3FLNWtzdm90N0wv?=
 =?utf-8?B?ZDdCdlo0Lzg4RzZQaWxiUGlLVFphU2VDVy8xRDdDV3VrUWgwN2d5dEtldCtT?=
 =?utf-8?B?L0ZHemhrUUpPM0NWM2RmVElHdlVMNjdPRGk1dEc5REdwUkg0YnZGbzZDSmZ5?=
 =?utf-8?B?dFErQUI4MWJ6K2xTSjZWKy9SZGZuYzkrWWdTcmpNdGhuekQvV2crV25wZXZ2?=
 =?utf-8?B?VGNGREY3L0hmNk1sZHNFOFhVb1ErRzhkZCtHdTdzTmVUWUF0eTJZVW5xMlhl?=
 =?utf-8?B?cmFQMzV2SXNVUXlEWGN0NTBnTjFDZnpTUWVITkV0SjYwUmZsZzZIakxLbkpW?=
 =?utf-8?B?aDl1RG8yMTZhSnRQYWNtandkMnZZMDNkU3d0R1dhNzFmY0ZTN0RmQ0JYejlS?=
 =?utf-8?B?UWRNYkdGMS9ndEIwNVFQRTI1TVNtM211QVEyVGJRa3BObWR6Ymt4S2p1VS9D?=
 =?utf-8?B?UFFHanpjZDIweDkwOVFJU2dVajQwU2VXTjdoVVJ1dU8wZ0dLKzlCbHFwOE1j?=
 =?utf-8?B?VW10eUJWVm1TVi9jV2NrTHNwYTFORC8yKzg3NkJWb3JCK2hnZFdhVytvUEdN?=
 =?utf-8?B?TVlzK2o3czRPQTRFTmp2OFZET2NqRXZyaTVmWWdTYjBYbG5RN1RqV2t1cFdL?=
 =?utf-8?B?UGMvUVRhZEpzS3pzYytMMk9DNEN6ZGtpb1BLMEdpc0FyNU9DTzFpaVA2TVpz?=
 =?utf-8?B?eHZBczQ5TitnbnR5TlZvTUNoc21lT0llT3RLT1FoNllia0o3N2w0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582ebb99-d9c7-49a9-06e5-08da26f058e6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 19:18:15.4937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79l925IpzePNLltTHN8rUVveeKv6/5bmrUDHHNP56I/cH2rNzG4DVBLOSs2cAZBIHKy8KkCBjKvWyG2oQ0GWRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-04-25 15:10, David Zhang wrote:
> [Why]
> Allow for PSR SMU optimization and PSR multiple display optimization.
> 
> [How]
> Add feature flags of PSR smu optimization and PSR multiple display
> optimiztaion, and set them during init sequence. By default, flags
> are disabled.
> 
> Signed-off-by: David Zhang <dingchen.zhang@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/include/amd_shared.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 741dae17562a..06f21e9008c6 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -234,6 +234,8 @@ enum DC_FEATURE_MASK {
>   	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
>   	DC_DISABLE_LTTPR_DP1_4A = (1 << 5), //0x20, disabled by default
>   	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
> +	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
> +	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
>   };
>   
>   enum DC_DEBUG_MASK {
