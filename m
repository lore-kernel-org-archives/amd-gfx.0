Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09EDC71153
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 14:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473C510E345;
	Tue, 29 Aug 2023 14:23:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C9410E346
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 14:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeqsefIyugVysmjwfkd9QdFmb0lU1rQDtBWP7VbkIaPB1TT7Mde/ZF5m2SzAtPzyBN3S+HUWscPwpnbjW2fyOi7FYOtJFyGF4nwk24aNPIz/GYq88IBUoEZatxadhXpmiesJ3QFj3TfBLaw6zP3ira2fGLyRJqpWs/zB4Bp7ubbrOrxYqcj/MZQCez4MQazmj0Ypk1czKiqrdyxPIiIGD/zO89fSJAAiwbhujJoueMW6QNaXUso+0PHeY8FHAUDZnibQ1UTGuVzi2yf8FrtAlrQmUhnoM7KhpBRBMdDm/nKDh1Frxoks4L3dKSAsM/OupBBk5sFPA324WwWCDeMZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2aR0iHrc2wf2NK8ZKnElyJ6YuQvjpFPFBBKRI5+Vf0=;
 b=XOR24ibQrvDTadgzyau+xlKKhmEl+/PLLBEcK5Y52jGlm50MmD9+lZipo73F3IwO/GDPYRgUOJft2xFZPv+X3gPLO4lChozUUncYiiQy9EKR2w8q4J5r8s1JqQDY/G7+R5nVHAKPZH7LdoXk6Ucvp1nh56I7+ioFmDi4+k/g8rpC1pDd1SIXAWrTTvQHVmoz0NhOAhe3lVYUKrrZS2c9wii8bAcPUUeOONbSmKKgjbECrWurbayuQqDkMs6Sv2Y7+w5jbHzEeCNUrYSeF8Di4/iX33F4Jc8NA2PpIHugrcXWdELHfUhSLmeqG+KsyjIqhlfZy/kbI8ImDz6aId887Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2aR0iHrc2wf2NK8ZKnElyJ6YuQvjpFPFBBKRI5+Vf0=;
 b=AzHaWNjeQjGGSuSevEI4X9ILtus4qHSAH6bm8HlWavXz6Eo8KgeKD8pPNZHTHRWZAF8gbfLJ/NciuZN7swAq3lQFNyO7Bw1Bkxlg+Zl8B0DB2nFE4Jd+hhh5jkT850DpXgZ/IRky1ucwk6y7WwViiR5RSlweWKHrfm/OqfLqvVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 14:22:56 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::33a6:f24c:da30:4f38]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::33a6:f24c:da30:4f38%5]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 14:22:56 +0000
Message-ID: <d3d74058-5e36-4470-a1e9-33773dba842c@amd.com>
Date: Tue, 29 Aug 2023 08:22:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix up kdoc for 'optc35_set_odm_combine'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20230829045048.1369376-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230829045048.1369376-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0591.namprd03.prod.outlook.com
 (2603:10b6:408:10d::26) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d6d58f-67d5-4ac4-b606-08dba89b703c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmJ8f+Jdsk1w1gC2p47+PH7YyxkMeBxnDOrwrLp532+sVkjPfDvSiQGaIqFk6aqjXF4wKWtx8BCvikzw7M1fScdDkN51qZiYivNUhoYFsVomU06IbBGy6FGogvsIlIJjkgKEgNQfSl4u6MbkEv/jNoGaNIibBTkdTe/0A3Y0niQcyo+q/Q8JJTve0QXdJz2IsJJVL6L/Gwm/mDTUb9cEIVxiEQ48Lz2DsQ3fDo/KghePmWMJuq9ELtHVyiQopnHBpRbaadd8S2xvD9ml3AZIZZTFW8MeFzm5whvGuAC1EL/2xdSTwG8GfIa2H7UCUQDofyU34UC1gT1NcgOwNT1yWrK+ZM+ecZPwxEyRltAtoDxzN6agEjHluMPOJbeQ38w90UMWB9uy+wWalZoiXMBcp0ZkMXmDmWNZhDm3UUty5FHzbh0wYmzZnRODsicS95uVpIxDckCMzKUHbRW8WPSrEWlCOWUWBhs/l/7nYG15MXNvJZf/Jqdh+cdwjSIAY4Sseg/xMNoppqUrySl18PvwdSA3utBJL6yq6aE9wd91n53psQhb9wVXm9A81fcHTWxGTAJMTqE4dqe7p048wMRKXmE7Gz0jiBtW/nl0WtGcLiKmw2NyBQ6EPhKtA6xfDJiWB/DcRRV+v7eYB+SuEmP4aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(37006003)(6636002)(41300700001)(6862004)(4326008)(2906002)(83380400001)(31696002)(86362001)(2616005)(26005)(36756003)(5660300002)(8676002)(8936002)(6666004)(6506007)(6486002)(66556008)(66476007)(54906003)(53546011)(66946007)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFUyRElZQlFnckJQM1NSMkdteHhqcWpwQ2VqOTNZcWRialg3WlBNUHZGRjVu?=
 =?utf-8?B?dVhRcFJGMmJpQUJkYTZoeFUxWU50SDhCS2JKNEtNRGZ5enhmaHp3THRPZ1ZP?=
 =?utf-8?B?MEVIdnVRMThZaUc1ZUlnZ0pZWElleU1TQ3NMeTd3UVpqVVFwSkNTV0N3SWhC?=
 =?utf-8?B?ODAwbkZZdWU3QldGYkhCQW9iMVY2aFM1alZzOUEzY3lyOVJzM2t5UlJCbUc1?=
 =?utf-8?B?LytuVHJHdFZFRFJVNXBaUHZ3eS94M0FNb2hiZzFQTVBCRStYWmEzUENRdEcv?=
 =?utf-8?B?V2x4ckx2MmZqUTZyNUxocGhob0ZwK2U5bW4vUG1iMlZJcVhPdWVwN1hQbjNk?=
 =?utf-8?B?Q2lnUFN1UmRuKysybjM3anBKdDFvaVRWRldyMkdoREh5SFdoclV6MWNLV3JJ?=
 =?utf-8?B?ZU9ESjhiSktMLzZsZzd2MGVleXFrTFBVZEkzV0Z5TzIvTkE0SEd6TUt2WEhJ?=
 =?utf-8?B?bzJGOHNwWS9HMmRxNDBKK0wzRWZmRkxiMlR6SUhxM04zOWtwaE5HdE1xWDBJ?=
 =?utf-8?B?WXZYUGhKVmc0VGQwZmpKTnJnZHR3QXplaGdCSDE5Q0JCeGRmbkp4NUtaVVZL?=
 =?utf-8?B?VGVxSHJqek5hakZpOUxJelFGMVYzWkxSMHA3eEs0VU0rQ2xENDRQRThyMTVu?=
 =?utf-8?B?QU0ySDhldTBZSWt4T3dUZVZwWG9kcUJqSGRIRnB2VmNsdlloRmdzVktCakFV?=
 =?utf-8?B?NzFFSC80cWRGejN2SWdpSFJKMUhGZG1JRHBZN3JycmhiTlFuZzdSNmlJU29j?=
 =?utf-8?B?OVZDSEZTSTlrdG9uWnRMUmFLdFRIdVhWeDl1Um1aNmRLTkEvUTBLdHRNaTlS?=
 =?utf-8?B?N3ltK2FmNTdINFJud3NhTkJPYVZ5Vm5WK3ZZc0ZrcW9DVExWOXQ5VTUxV3Rr?=
 =?utf-8?B?WnIveUswVXdPdW5Yc3FTUG5ScFJERFVUZlJhR2FMNmtQS3ZJRGtMMnlZaERJ?=
 =?utf-8?B?M2pDT2F3MWtqL3Qxc0o2VXVPK3ZkalgvRVJJUDRrMUVpaFZ4U1ZrSW91TlZ2?=
 =?utf-8?B?RW82QXV2dVRVblM0WjZmZEhFSHJZOTFhNkFmeVRidjZBNnUvZUhsQWJ5Q3p1?=
 =?utf-8?B?MXJVck80ZUEwTnMzZk1PVkNFS3gxQndQcTlUTUhISGswU2RtallzYVhHb2FK?=
 =?utf-8?B?UklyUmlmVGRndmpyQ1RmY0hIck1iak94VjREWFVlZ3NPNyt1WlVwYldnN2hJ?=
 =?utf-8?B?dWZZVG13WmwreXMybEpNcmlVL0ZEeUdOU2RZbmRvcjZzN3dvRzBMTGdHSVEv?=
 =?utf-8?B?bGp2WVQ1SWpJajl5YzB3VUN1QUYrM3BNbG1lVm96TkJzK0VkMHpLdUp3UW9U?=
 =?utf-8?B?TUJiUkdKS0w4SzJST0VuNHhHSm9zSEJZUjNPd0JMS3FnczVBZWthUnF6RzdG?=
 =?utf-8?B?eFExei9rdmg2aGJ3SmkzU2tSUmN1clVqZURKbzJiS1pINmNKd0FNN0VtUm5J?=
 =?utf-8?B?RFhPM3NnZTA0ek43MXJ5T0s0VUc4T0lhcDV5dW1MSDFJVUpKU1RCSHU1UkZU?=
 =?utf-8?B?Ri8zR1pqUXU2bnk5aHBlbjU4ay9ycG1BT3lGUEJjeEd0S2FuNEZtenNvTHNz?=
 =?utf-8?B?YW1XMk1KcytaTEEyYis2K2lUN3cvTk1XdU94YjYweHhZcDlZUngrMHFpQ3Nw?=
 =?utf-8?B?aFVEQXpPY0VPWC8wRWQ4YlNzazdSUytVcDR2aUVUVGgyb3Z2L2FqVHJyZEN0?=
 =?utf-8?B?dlZtRVh1aDkrVGZvcEc2NStXOEtzNTZ4U0tLZzNOSU9sa3N1SDB0VG90NVlW?=
 =?utf-8?B?cFBralhZRDdGWTQrWm1DTG5OVXZXaTF0L3ZLLy9Pbk5PN0loUEZGQnNLaXlN?=
 =?utf-8?B?bTM3bDFQRWd5QkUyR3R4UlVoZVErNGxISS8yMnZpZEdWRGpodkNVZVcyeC8y?=
 =?utf-8?B?a2VTYndialZuaEJTLzF6QjdoYmQzOURCNDUxbCtRdko5dlhPVlBiOHRQZDBD?=
 =?utf-8?B?eE96RlR3SG9ybDZscDlLalhLVzdWY1lwRlhiZWRaUXo2c0VsUEttSVNtZVVW?=
 =?utf-8?B?Q0dDUnVJVHZzTmErdU5yMEtHTlp0Tm4xQ2pxY2NyRVJkclptRkpHSVJCOVlh?=
 =?utf-8?B?WXVpUXk2UkFBZ0o0Z0FFbnBpQUN2TVJIa2JhYVpWYTRGZENkZWhTZGorNWJm?=
 =?utf-8?Q?sAm0NEsTlIYSH9xcOT8WkGaXD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d6d58f-67d5-4ac4-b606-08dba89b703c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:22:56.2887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKm+5jqmloE7s6z9FF7Ja9O2fqqX3oZbwZ4v7aUJlL0jFLZlrNQv6h6WFE5xO+sYuTekGOFy8CWKJX2FjJmGMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Consider renaming the commit title to something like "Adjust kernel-doc 
for ...". Anyway, avoid use the keyword "Fix/Fixes" for kernel-doc.

On 8/28/23 22:50, Srinivasan Shanmugam wrote:
> Fixes the following W=1 kernel build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_optc.c:46: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> * Enable CRTC
> 
> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
> index 5f7adc83258b..294799d8c34e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
> @@ -43,10 +43,15 @@
>   	optc1->tg_shift->field_name, optc1->tg_mask->field_name
>   
>   /**
> - * Enable CRTC
> - * Enable CRTC - call ASIC Control Object to enable Timing generator.
> + * optc35_set_odm_combine() - Enable CRTC - call ASIC Control Object to enable Timing generator.
> + *
> + * @optc: timing_generator instance.

How about:

@optc: Output Pipe Timing Combine instance reference.

> + * @opp_id: OPP instance.

How about:

@opp_id: Output Plane Processor instance ID.

Thanks
Siqueira

> + * @opp_cnt: OPP count.
> + * @timing: Timing parameters used to configure DCN blocks.
> + *
> + * Return: void.
>    */
> -
>   static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
>   		struct dc_crtc_timing *timing)
>   {

