Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4131CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 21:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF5610EB5F;
	Mon, 24 Jan 2022 21:39:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEB4710EB5F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 21:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3YTgvzh35qnfYQ5g9Q871a3KE/RnV1o7ZXtsny9ORXtAK+HHf+ZCUBNiZ0OvJY5o/rEW9ZXpr3P4DOU6Q+9/NU/JC5Z7cWPZbMXzdDXnH0z5g3RqeNLWJmz/hrsmGRelB+kX+ix5k8RCkPFoY5QH+qd1MsBEDBfW0mgvVwhNfeiZxzWughfo2IurXdN/Rj20nyvTI+LWM0EMyYXwTAiRmFQzeNafY2wQC5UqXydTEmCVRIzXCjOuauXIN7XbqxCqTEmPih3dpomrL0jUX4LgwxLojc4dlIrvwrpn6JCLqJ4evzGuYoZE19lkDhwPXd/3mK14M5KUR1CumQ21qzZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kpZRXmINgHeZAc0LBbP8/wPLRCv7Pdz+4Kp0Dadmis=;
 b=dpqBJ2cWqFqaNkBH8ziEoBvCx8Gknr3b7oQpEHEtIHjEKCsQgmJD+e9Uytw5YnzHXz3gEIv141E1UTtYymGLHNZtULrR1QaR8BqJSWl3RpTB3KNBClDcMbF7rMtkqnxRSNQnOWB1U60MByAswyl9W4r3n5ZlzgwGCOvu2GZjVplituCCBCcw0oIq/KwfxS3vCwpFmDOZAfT/uuU6rgut7cuSJZpg4PDNVNs5zpfJB/PdhrsqrMdtVowGb40OhbKVZLNDc+tQXarymcKHAagYCL4UodEk8YIxGHgbaI2veFJHslcVi2tjN9segwlASlWL/kQagqEeAeXhrQxLdicGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kpZRXmINgHeZAc0LBbP8/wPLRCv7Pdz+4Kp0Dadmis=;
 b=Fu/68ZzYQ5ulem9qgHgfQ+BzxMEd/noNcLvsW/zwfTB2QGNt7T9W3lP2hWiaM4Hma/BnDOa0KJqhFg4jR9EcKRPDA8lPVor4Q5Vybc6jGbG2/2jiMTDdoQz1XzCLUmBKHGKO9A085PI88gvd+yXdzC4kaRhkTCZcLaFLtnLP6rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 21:39:44 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 21:39:44 +0000
Message-ID: <0448e4af-8d00-4e0b-da42-2541a69cfd86@amd.com>
Date: Mon, 24 Jan 2022 16:39:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Revert "drm/amd/display: To modify the condition in
 indicating branch device"
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220124141714.1199710-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220124141714.1199710-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 596521b5-eb70-42da-6079-08d9df8208c7
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2438E402B781D5A7B1ACC2B48C5E9@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0qLh5A9iMb48KZ8mnfkfGoGwUzDZNqqdCVv+UaClLDs2/oFU1c2Az3evCqHIYbzD8RHCBfnsiY2axOInptmrgDHE14V8j320I4XNkr/w0pWtDBVGSwbmKXljL1ftVZfekxp0S4T3IPsb7EJfDF/OYKkmZsbqhfRQGkcooqYK3iGzaiI79GqMFVc4gYOVYjHBKowH21+EqVxkSIixd3Dum+nIzmqDMGuYtY7OVvnDzYh8/xSfkEQmJmgmHgXlVSZ3+Mi4kGJil9tOaRtNof29y5GdOLCz2DeetEX7H+5ilIE/9HQWxAe/12x/uNqZXa2YlzJRtK4KnfxY90jcEic3Gr3UMQtXALYyI1ilsTkmNWjZl2vxT12KZsxpNRhqIsk9jIHa4kzR+MI7DaLGNv6tN54sRdVj3ST6xaRT3HYKBWhy8A83EfEWsYdPTHNiTdM+vv88LqgtxCTK6COdh01K8uHMwUlymiEZaIKs/udY7WDv7p9esfCjqQtUcXZSdJUA5GHJOuRPLvDjSJaBcYeNY4kEfnZJVblQGwg7dXqu8kv2ug+exeRo0jH3VHh3oJbGguCeslNaozxq5SH54D19A7N14g0EqwErfNznwgpjh4F6AbES0eTobTArdj6+/GCxdhA36ucwiQ0kiGds3BHCiUXxdaQslTyFTWyoa77yBkTwRggYkn+k+l30eYGpyLVSYnaYvtWpH1NoT5wNkF1XLNqyMriQEd1WLkwzCOi8PA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(6486002)(2616005)(36756003)(316002)(44832011)(8676002)(31686004)(6512007)(86362001)(38100700002)(186003)(6666004)(26005)(508600001)(31696002)(53546011)(6506007)(8936002)(5660300002)(966005)(66476007)(66556008)(83380400001)(54906003)(66946007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmNMWWpVdXA4QTRvdnY3QUJoNFQxMHE3ZXdWeFVIZ29VUE4yaW1paDJxQVAw?=
 =?utf-8?B?MExDNnpyeUFGWHZabUw2VmVVa2poQy9seExGb0VjNmRoNXJFNStJMzJXaFhj?=
 =?utf-8?B?NG9wbGdpR0t5WnQvNlYyMzluY2k3QWRPU2xlRHExa0FZMHNrUkZRNDZ6Y0Rk?=
 =?utf-8?B?bXdPTDdueHNpVkhSTmlyQU5wR1RLdFBVZ3Boa3doRnBqZG9JU0h0UmRZY2k4?=
 =?utf-8?B?QUxjOVp5VXp1a2gyS05yaFd3L0pFb3ZMc0VKYlhudnN5YmtwbHVnV3o4dHhE?=
 =?utf-8?B?d3R0T1hxemZ5TW5QZzI5d0JxLzB5V0pCUlBiR0hIMEhpQktpVDF4SnJ1cmpz?=
 =?utf-8?B?VU9MZUszT2ljNnRILzFQYnNqWjdUWHpVN0tYelhIaVd3c0NscEIyR0Z3TEtQ?=
 =?utf-8?B?RDhqbE8vUUk3c2dNTi9ma0JWdHh5N2dxa1JMN0Y1UTFOVVZKU1pQd0JBVEE4?=
 =?utf-8?B?ZUNCMUQ0cHRVOGtuN2pyM0NQR295VUNMYklYYy9DOXg2Y1J6NzMySkVpS3BL?=
 =?utf-8?B?TldDeU81VlZ1L1A1TU1MZXRzdWE5UWV6Q3g2V2pkR2lXSW1VWHV2NVlRMktD?=
 =?utf-8?B?b2pZeklxMitiZmV5bmx0ejd0akZnQlRQaWRyVzFPTVBKMjI2bkZJK0tXRDcz?=
 =?utf-8?B?a1Nvd1FFNHV5dHFxMXg5eFlZRGpQQ2NUdS9hWFJtV2RYZGk1a0FpSHl2cnRo?=
 =?utf-8?B?eFo2STNCdHJJNHA4Y21UOVNHS0ZyeUwwSWMvcXlldnZrNHMrSVB6UXBJakhv?=
 =?utf-8?B?MFM3bnNTNTRubTY4RjdxNTBQc0VtMFQyYUQxVTFpSXNGN3lLNVNKZjVMQmhI?=
 =?utf-8?B?R3RhMXZKRG93c3pndzJSWFFVMzVqeGRUa2Uwb3NKcGtWaXV5TWlpOHB2d3lP?=
 =?utf-8?B?ZWhFK05uYzl5MFY3dEdWK0ZuckE5MEVFUklDVHYyQmR5MzVEZCthSjN4UVZM?=
 =?utf-8?B?TndDMHQ4VXpCYWtJL2x2dXluWkpuLzBscHI5eFR2NVN1ZW5DeXZicXhWVzZj?=
 =?utf-8?B?TmtjcktpLzZvZU9PYy83OVh2Q0l5YVNUOUxpQllaR3Z3RUlWaGZLRklQejEx?=
 =?utf-8?B?YnlQaGRxUFpIZm8yY3o2U2pEeHZHUjB6SnpaelZLaFExMkFQbmxYUis2TnJH?=
 =?utf-8?B?ZEZ3N1owN2NXMlg1djhvS0JFUkUrR2k2enlHV0pFL1Rxcno5b2hlNytyNmVT?=
 =?utf-8?B?K1hYalU1U1dwVGU3cm9HdzFGaXp5RFhmNzkxQ0FmdTBiYnY0NTF4UUloMWd6?=
 =?utf-8?B?WGt2YmdYcEpkZUlQQ1FvRWxhM1I2N2FRZElGeVgwWGVXVnU0cnUwK3hsTmto?=
 =?utf-8?B?K3ZIY0FyaXhhb3Z2UFloSjBSWFJJOFlUUmp6bjdGOU9qU0NtSmR6dDZnMTdD?=
 =?utf-8?B?VVVLVXBLNngyZll1Wm40ODUvaUM0cjh3OUY5ZU9EZzQ2Qks3MmY2ZjNoLzRx?=
 =?utf-8?B?VmI1c3VKUFFiNHFWeDBWaGlJNEphakkyay9ET2ZlV1pZVFk3MzlQaXJTN0hJ?=
 =?utf-8?B?UFlYYTc2Z2o0eGZtM1lXaXpvZ1JDdjZwdUhobU9TNUJrT2dRZUNCV0ppdndH?=
 =?utf-8?B?SFdzNE5oZzd5S05iMDlpUG5LdjNUSFdiS280ays3T2h1b0MzWElwOTdtWnZl?=
 =?utf-8?B?K1prV0ZTVFJRWVVuVnFBN2FxcTZKQm9hOS9WU29haVl4WTFxWDRGbUxscUNY?=
 =?utf-8?B?TDlHdktRTGVJb0xIbndBR1dYdGMzam5HUTROVlhXcCsrWmpBNFBadWFUaXQ0?=
 =?utf-8?B?WGQybmRzWmZlbUlsOTBrejBuTW1qRk9taVJJZ3QvK09RRTh4RVJSWVJSV2Rz?=
 =?utf-8?B?U3NQYXFpL0tDTnI4VStYWGt5TFlPc2o4K1ozU2hxemJPc3k3eEFka3pvWUFI?=
 =?utf-8?B?cE9uOGdRdlhIM0JmN051eTdPY0IxcHV5UDI0WHRXOFB1b3R3N2RiU2hncHBD?=
 =?utf-8?B?YmtidmwzeC96UFJWSTNaUWx2Zkh2cTl4NmpxUlY1d1plWVRxR25Kb0N4RXFJ?=
 =?utf-8?B?WnJFZlFHNXV2SUVnVXRWcXo1WGo0cXNmRGdxSkc0aGFoQy9VQUw2TTZvT1dO?=
 =?utf-8?B?NWJzSWE1K3ZYOUhaTWNLeWErMTlOUFdXTVhvWnhLNVZnSXlpb2dGVzZ2NVMr?=
 =?utf-8?B?bnBwRytsY2RWNldlZ0ZyZXYzSzBxNXpQTmpTQXpIV2h6VHdpMHhVUWFSWDht?=
 =?utf-8?Q?lXJUAPniZBtgDyFj+Rz/Bps=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596521b5-eb70-42da-6079-08d9df8208c7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 21:39:43.9880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiX3N8iSA22//tNo+BLZNCiOtioKrKN1RfbDZqdDfHbdo68oa8/XSZy5UiJri1FVU7D7kBw85GN/cy92HuGtiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 Martin Tsai <martin.tsai@amd.com>, Bindu Ramamurthy <bindu.r@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-01-24 09:17, Alex Deucher wrote:
> This breaks HDMI audio.
> 

Do we have more info? This is DP code, but maybe the display is connected via a DP-HDMI adapter? Or via a n MST or USB-C hub?

As Siqueira mentioned, we couldn't reproduce the issue and the original change was intended to fix an issue with some receivers. Simply reverting it would likely reintroduce that bug.

Harry

> This reverts commit 9413b23fadad3861f5afd626ac44ef83ad8068ab.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1536
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Martin Tsai <martin.tsai@amd.com>
> Cc: Bindu Ramamurthy <bindu.r@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 6f6929435885..eb4432dca761 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -5039,7 +5039,13 @@ static void get_active_converter_info(
>  	}
>  
>  	/* DPCD 0x5 bit 0 = 1, it indicate it's branch device */
> -	link->dpcd_caps.is_branch_dev = ds_port.fields.PORT_PRESENT;
> +	if (ds_port.fields.PORT_TYPE == DOWNSTREAM_DP) {
> +		link->dpcd_caps.is_branch_dev = false;
> +	}
> +
> +	else {
> +		link->dpcd_caps.is_branch_dev = ds_port.fields.PORT_PRESENT;
> +	}
>  
>  	switch (ds_port.fields.PORT_TYPE) {
>  	case DOWNSTREAM_VGA:

