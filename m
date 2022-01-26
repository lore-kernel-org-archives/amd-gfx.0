Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35DAC63684
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 15:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52EDF10E700;
	Wed, 26 Jan 2022 15:17:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4D510E700
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 15:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLdodyIWYAeX1znSTcqGQz9VwiqrTyVJT508kVBvRZvNDQop3GixWsQ1xHspDJ/feLefmQABs8NnYX8oLuUHnqdiS6bfs4beyuysviTtNENtBMtzTwKGr4viiQmjfUTt5KhWzIXUX0PYxllaLMkM4sQSgEgQ5qvHMyg2ViEVw4rBnUMJSOn+cmcnWix387Task2WL1JWSrR94+q5ulme78riY7mCbkvkKKshjIXLcGawZuTgXqDGOXJ3fFZ0P7WhX7f/1BMyxVhzuzG7SO4cMUX5a+w3AwGqW3sbKzWnV9AE2xGb7ove1leEbMLtYfzuFII1Cecc+ij+0M0E+ws8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTZkp5sV+r+wZD1BfUxI2JC9rn6tNBRUtB//Kc8kSmI=;
 b=BeFOD4I79fDvHt4X6PUp7sOuXcJgO7GaZJnMjyhh8+M+BZIqneNFYz2Q99JeKl16grUyytJWkGUeanp+t9XoqYUY1wfys4Obh6XelyoUEvPQ89GKIx53Quy98Mmxf3p5h14nMIiVwGMZV2kKkrACUTxpQxRHvv6fbbkVrb9luDBXewwa8tVkhuoMp40CkUfJDelOpPGaMl1eyezUPVRosbpQPZrRvbWrzTGypP74qAkGoTtSah6KLPTQIGMnQviowVDP0ywOYwiEy+i/gOKK7nlrvLa9fqA05xvjM4pMY+XHVzdkLb/iVNKXtIGAbTI6bealmv4fpgIdI1plhqTctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTZkp5sV+r+wZD1BfUxI2JC9rn6tNBRUtB//Kc8kSmI=;
 b=B8HBmMIfFbLqia9iUg5JP+0CE0+psPceoO3GkMtIEGvXxsgSTYlaTnK6I4ESHe+qinL2slzz4Sgh/BNqmVj2p8Oe4uaVsdGWgKyD/zPWU512gm45ZWGHNYK5qmeFuoi4p3PpFQE839TA6F6u0MdVPjaeNdDTXSNfI14N2OdsTts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 15:17:39 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 15:17:39 +0000
Message-ID: <a7a57aa4-5a5d-d7ba-c2b2-ef6d90023978@amd.com>
Date: Wed, 26 Jan 2022 10:17:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] display/amd: decrease message verbosity about watermarks
 table failure
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220125233547.31314-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220125233547.31314-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5cecfc6-65b5-47ae-81e3-08d9e0defda6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51918E7741226AEE4E5EAF198C209@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uc+omCCD9UK2z/fXUwOWCWuHeJQl84yR1YhYell/bOAehY+GpASavlkZ/aXPc3fDH+swYPP8RbtlSjlCzDzUaD3h7iUIojODe0QwH5Z5vgHjabs5+OPRsyTWF8ftjoiRycbdBHnhsDHxyjDOBiGX068Lj4+6oWMp2dIbI9nRJvV2JKTmJp1BF3GEo/1kRMHa+TSBdyoCLMKyYMu1dVCv2BcqvBmr+oqn/toMLBt74Cu/dZ1dCbKipjefWHCkLlzAge0c3Ph5SdJzH4G7Ng0sgoIdGMlPOiLxheiSQxNo1462IzNdUZwYO7fxf2nJgBEQCBgcjRyirnJl0ZWOomnzL/XpUwwQOqkHVzP6j8Q76rt95bKLooOIxHEWqKXnT0uMmwr0QDeY03iOQHxtMl8hfYpKop9cqgg1Fb1HtFsNpg+lb5HyUd1BSl26x6G6BwBiBFfpJLYa/GE0vZCghUbvLweu/DXpsO7fk+tyz1MCF+OLQlHeggYPQWkSRUxy78pZBhmCStHQ13ApDhSOI/ZWjrmaQxiwRrsciE4O5OAQpwsMeCCLlcX7Jb+PTYboVnfMBhjAzKhszBfK+Mmgd93HKFrz8Ezf/1IqjS7X/XTuUYL7MzVRF3WAsnqdzwfP2Q6tt9VANvLftbwcvHA8Bpf337pjRFG/FdfqPk78fK+A6qARNPq4BKcUdizvpW7nmN34rcruqyGuYHh3Oi1nLQ5+Q6G3pbbJJCWwf/s5Xma0q16PWW0t0aozMDjfP5SCpMTk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(6486002)(19627235002)(26005)(186003)(36756003)(316002)(66476007)(66556008)(31686004)(66946007)(2616005)(44832011)(86362001)(6512007)(6506007)(6666004)(53546011)(8676002)(4326008)(5660300002)(8936002)(38100700002)(31696002)(2906002)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZ5UmhRcDN1S2tZOVBNcjlWZVRuY1Ira3Z0cEQxblc3elozc3dYK3hrdE1x?=
 =?utf-8?B?MXRHWlBBQWh2LzFtZXVoYnBXRFRNSEZ2WkJXL2JQNXZVYk95SjBZQTZJYndt?=
 =?utf-8?B?MnFhbmtqN2NTUGgrZTBnUHBvdHliYXVxcU9sanNFUTJCUWFvTllLOGl6TFBM?=
 =?utf-8?B?ODhZWTViVzEwckF5S0hLWnRjTERpdnlmanE4ZDN3d3lxNlR3SGFFaUFYQ1Z4?=
 =?utf-8?B?RE45Q3AvNEdQaUppcjc5amw4SHlBSVZXaUJrT3F1UVBrR3dNU1JER2ViT2s4?=
 =?utf-8?B?MWFxUDhYT2R2YkF2ayt5L25yRHBmblNCd3h5MUFmVVFncGpzdEFua1BOU1Fo?=
 =?utf-8?B?ZEpQdHFnRUhzVEtZRXVwUFh3dCsxMFZXakk2QlhuMnRqcVF3QVowZTdCOHlK?=
 =?utf-8?B?OHQyUldRbGRUdWR5eWgwazlwajc3MUFtNlVnTmNuU3RYSmlPOUU0WThabnRJ?=
 =?utf-8?B?VUJzSHFFTnFQRnh4TTdCaVNJbjM2QjJUZTNiUk93YVorb2hpTUhYMDQ3NWpy?=
 =?utf-8?B?QmJIalFQWnQ3L1FGa0QzSzkvaWdDR1NpTll1ZU9vMDlUT0tQa0pNY3NqczJq?=
 =?utf-8?B?RGhlM3doRzI0R0RpZ29mbnYyNENyTUpkNVJYR2lqTXY5Zjc1dHZTa084dmk0?=
 =?utf-8?B?dWM1c3Z5Z3NQaDFNU1NiaWh2bzg5UTFMNEV3SHB2WGo3TXJkZjdXZ1JSb0Zq?=
 =?utf-8?B?TldPNGppcWFWUmpkSkI0a0lzUkp1OWlyK0E0emNnWmx4QjlKVG9mMVVyMSt0?=
 =?utf-8?B?Mk9zY005SEhrVnJHVWpzZmZtMkhsM211VW4weGs5bnBad0Z4cHdKY0U2RmtB?=
 =?utf-8?B?OHVoWVRaNS9NNWZvb3hIOVFDQXpaSXFtMWJaclBqMCtYbi9oVEJncUhJTTVv?=
 =?utf-8?B?QW9Zai9kYmNMQzljQ1cvMjVKT0x0NnNaSmdkUU9acE1sMVhFNXJDLy9SbThs?=
 =?utf-8?B?c3FwaU02ZW5hRFZLS2h0QjkwdVhhbDRZRE81bGcwS3RrdkI1R3RSYzlFdEtI?=
 =?utf-8?B?dEhOYStsSWtyeDVOTUtHdUZTODBTYVNDSkI3Y1NzTmtKc0s5NzVPVnMxYTE2?=
 =?utf-8?B?dElqZmN5UTg1dlpTWmNiam1hL0NkL21Xb2Q4bVpEMVNaU2o2NWJmNm1KTmNs?=
 =?utf-8?B?ZGJpd0lUZk5EcDF6dlVJR1ZVOUZVNzhNam4wNEUrMTJqbUZkOHBUbURyYXV6?=
 =?utf-8?B?cjJVL3RwdTN1QVRVT1NZMFdLbjdLU004TTlGZ0lQbHZLYjRUU3BBK2MvdmR0?=
 =?utf-8?B?alBVVnp4V2FWcVRWYmFKUW5UQ3JMQklxbDI0WUZML0c2dmhiYjNBUys2dkhw?=
 =?utf-8?B?Vk9rM0VxZmhNRVlEMnFSQ3hYTUpuamNJWG55TVB0MVJBdlZTQmdwUThDK21T?=
 =?utf-8?B?Mll1a3M3bWQwaXMydUxHN0VSMXpNWkxMOXJVVkw2ckk1MlFrQkQwQlkvY2Nk?=
 =?utf-8?B?eEREblQwcWJlT0lxTTQzOC9zMkM0VmZvcVYzam5ldmViQ2dMYnFkUG04V3lu?=
 =?utf-8?B?NVNJbTgyTytqMnVIelE2dkNmQ2JWWHJUOXd3VWVrdEpuWW1wYnVudStoNHhB?=
 =?utf-8?B?WFlZNWR1UEJjWWppL3dlb1ZNYklpcGdmSlQxa3RQbjcyTERXL2FSQjhsa2hJ?=
 =?utf-8?B?Yk0xRWtjWlovcnBCaTROVkVjSFBTemVPbW9WWk55TG5JVjFmK2M0VURFY2xw?=
 =?utf-8?B?ZHc4OXN4MDg3U0ZSamtHbVZZdkEzZVdFVnM5d0dwdVdrUjRmdHRIbm9QK2k2?=
 =?utf-8?B?TFlZVm5raXNQcGtFRldUMU9zMitmeXpKejZOSHJHcjV5ZXkzbC9OYjBKOFAv?=
 =?utf-8?B?YzZCeVU2a0tPVzZMV2h6LzhqYTB2bzhTWHpMNExmWkhobW0wWmpFYjlJdzV3?=
 =?utf-8?B?VTBWZkxSREU0YWdScEN1TUpkRCtUNzVsQWdrdko5QmYxdmNuTjBvMnVWUEJD?=
 =?utf-8?B?MEpoSFJ5RUNMSU1vWmVXeWtUSC9UcG9HUWtCdGZTczBiTmI0ZVExa1Q2dDhI?=
 =?utf-8?B?Ri9DUk5jTityQ0VGdDdQQ3Rld0lpamtQLys1K09MSFBQdDMyRXhudXhOMzgz?=
 =?utf-8?B?cVgxdUh6Mlc0UUM4R0xwMzFmaVMxdW0raXNlTWpseHdMWEVhR1BQMVlSSjdZ?=
 =?utf-8?B?d3BNZllDa3V2Nlg1UXBtbGdmYU51eXR5dEFHWjk5aVZEN0tNUjYwZ3QySzlq?=
 =?utf-8?Q?Su8Yt5CESdfWU48pf4/sgNY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cecfc6-65b5-47ae-81e3-08d9e0defda6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 15:17:39.4744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bNXK2RGYWyciGR6dER/ONH6xK37gmM0rgJK3W1PhPGC7xrD8cPzh1/6fyLQlE4PmckBoQHjO64RVa9i57Q0ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
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
Cc: Nicholas.Kazlauskas@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-01-25 18:35, Mario Limonciello wrote:
> A number of BIOS versions have a problem with the watermarks table not
> being configured properly.  This manifests as a very scary looking warning
> during resume from s0i3.  This should be harmless in most cases and is well
> understood, so decrease the assertion to a clearer warning about the problem.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> index 162ae7186124..21d2cbc3cbb2 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
> @@ -120,7 +120,11 @@ int dcn31_smu_send_msg_with_param(
>  	result = dcn31_smu_wait_for_response(clk_mgr, 10, 200000);
>  
>  	if (result == VBIOSSMC_Result_Failed) {
> -		ASSERT(0);
> +		if (msg_id == VBIOSSMC_MSG_TransferTableDram2Smu &&
> +		    param == TABLE_WATERMARKS)
> +			DC_LOG_WARNING("Watermarks table not configured properly by SMU");
> +		else
> +			ASSERT(0);
>  		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);
>  		return -1;
>  	}

