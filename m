Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC85CC48BEB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 08:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B1210E0D9;
	Fri, 16 Feb 2024 08:30:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P/NQOWxc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13C710E0D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 08:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JarCUP1+PGwhsT7vsCFGhIoZyxCgbxXo76DmxUTd0IhVKuHVrUF/qmJRHDxFAFH+bIg3vKWJoh+jzlAUy8Y8tuK0hwEFVXxtDHBiTaNnvuEuLg4ZSWzp2vlq90lq959vUVy5d+mAz58vGy7I74barmStnqoUgaMCaJKTEV+KoBZwWpUrdsWv6oRsVu6TMqKRmwCJL4y39Zz2ndRk0H3eIsAi10l0Ej9ezfrrLVwRjQwo2tFt8OVfwTmp/W2hIlQWSFZRqvKHw81xaobxjdloY6gE8o6S3slHJ7Jth4NXpu2urBgFHQqgrT6HXocfPM6bzwi4w0oOQGqxB/WMSJ0MQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gOp0eibB5z9oia34QQjHtUy4mkTqMJlJx86p4rSlUE=;
 b=WhmOpCc05boeHQPPni7RqfZGm7XceEspevzXk6yEBJk397tZhSmu2S2a8wiR9MOknjRbFLRrvR/qMXKLXX7nwUSmzWnUgwhz1porJ5RswCXbx2rU0DMKOQ/WPPg6ZaoNl151z48n98NNJwAEAlAyQBTnCorhxvArTQ+reTvYSNwdazavjaC78SLzjaYOR44U7jktsGd/2Gq3l/ktfmnZi2ubJhM3VJ8zx1QSQKoCypGRz6FFT2gE+FIUS9vv0BwewSvEhTgmCteCXHJkBS9+g8MZxks7w97L9LCGnyBKUz6ex4vzwopqnHbGwAQpxjKFQbxiKoQO7OFwXwiBLl+wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gOp0eibB5z9oia34QQjHtUy4mkTqMJlJx86p4rSlUE=;
 b=P/NQOWxcxz9AhvFKBFSk4GEPFvtZI9u2JCxF+f+3+DuuWsjcsLoliK60lvCwpMF4hhf23rWMl0NZ7WxE3MNNCXDo2T1lnSliA4DMO4eDhSCCMEGHk8qPRAfi1GSzSq22ijJKM6j0Zc5jhMIJYSBBK/E4+4e6POqtXU1Hg9w9UMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 08:30:18 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::6b6c:cbf4:9ab:59b8]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::6b6c:cbf4:9ab:59b8%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 08:30:17 +0000
Content-Type: multipart/alternative;
 boundary="------------H2BMj9C0n0NXDSj7SXF2Preh"
Message-ID: <c662c1f7-4cf3-42c8-a120-9d38b72b2c4e@amd.com>
Date: Fri, 16 Feb 2024 16:30:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add 'replay' NULL check in
 'edp_set_replay_allow_active()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
References: <20240215133129.2345398-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240215133129.2345398-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaeb62e-abd5-4ccf-0e85-08dc2ec98170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TggdWPRsa3qdWnT3rw4OWzXFAVkoOAkC8kNczSUrhDRKCFFk3c36PpNH51gifYxUJpmoqiLPAPi6F4uzqKUjWB34NiaI+yIi6TUpubHDZDxvqX0iC4lhegrySXgpDGytaUoDblN6ZemYPnbHaxHNefTqcHD89rFPCNo2CQgJm9UDjAer7TxFLBvjqzkyMCSfuFpNh864UC3H9/HcUMH7rPS4FwUUmMZfKWvxmNnA7wKzMa9vnRdN/X4PTQZO4ICJs5VrSdFISbHO6sW1JvIOVDLDhW90VacNDu4V+VWNo6WfjO4lWFDNpsrE5nI04+cUk4SWGlsd2sI06g6CcJ0GYS2kjnDqe6c8mD7qh0mVZkdCVDVhuy3vmz/AIzaUSHQqXDXvu2vSfQOql16HAq2X4bgj/TRMuHhGj3mlrYcefb86cI7rrbAdv4sTPX6f2/R4d+S7EU0+OZY0pUgTFJyb56No37rGFtvw55IuufNvOXXd4vqszYiLXeJ43e/PmY8UL9cBYQoOd5PPW7CND36I01jzdgk5U+JLbKmqAUPmIl11zRIl5kuomUD+Y7J7sPW+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(2906002)(5660300002)(26005)(83380400001)(2616005)(36756003)(38100700002)(33964004)(478600001)(53546011)(6506007)(6512007)(6486002)(31696002)(66946007)(316002)(110136005)(66556008)(66476007)(6666004)(4326008)(41300700001)(8676002)(8936002)(6636002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlRKRTNGeC9ETVU4NGhOSGdTd3lnRnBaQ1NodlJ2YnNiYis2K3FZNGJrRTVr?=
 =?utf-8?B?WEJGSit6N2Rjc214NmowdmxDU0RPSzYxRm5Kd2ljYk01ZjZKY050OFZMcXpK?=
 =?utf-8?B?dktOdi9zeVpYNXEzZExKdG5FQ3FuOW43TTkrdSsxeVVwL1VYVEhJdEFJd3pR?=
 =?utf-8?B?ek54UkJsb1czV1M2MitCTnF5bGZoYlpPNDhyYmtTbWhEV05OL0RmQVE0THlO?=
 =?utf-8?B?dGNMOUFuaEg5OWR5a1gwVmZONUtEcnNjNVRJaTNzeWNES1ZvQTlzbThiUzF3?=
 =?utf-8?B?ZU0vYkpsMnZubEdPVzZ2L2pKSHFGaGxDaGJHdS9sVXZjaUZVT2d0c3FjUm1E?=
 =?utf-8?B?d2VMNFRDSU1nMlkzWTBEc3lzSEgzUUdGM01sR1JIUGhuUHAxNnhRNXF6c1oz?=
 =?utf-8?B?UG9KQ3lySkpHTmZaN0s4V2hiZy91cVdTZ0FyUFFiN1h4aVdOeWhLbmhhSmhV?=
 =?utf-8?B?bnk1M05BcEhTMFRVb0FFdkVXVk85RVpRK042QnZtdTNCNTRMRm9lZmJaK2U3?=
 =?utf-8?B?ZVM0LzZSRENnZTlna2RtQ0FqbldZaWhrMTFCNXU1UkNuSEljZllObjlCQk91?=
 =?utf-8?B?UXJtM25yS1BwVkV5Z3VZVnZReG1WV3NIb2t5ZHhZWHhTeHQvZWo4Ylcva0NN?=
 =?utf-8?B?QytBNFRZYnUycU5wbzIxcFZHOU83bWtGRVBXSWtzMGxGZlpIZ05UOGtaNjFX?=
 =?utf-8?B?RjN0NzJtRHA4WVRzZmJMUFcrZkNPbUV0dGxCOUNkVndYblRuUmNFNXprMzhN?=
 =?utf-8?B?TktxVWQrcHdHUHZFZHB5RTk0Qk9rWUs3ZXJvQkkzcGpVR1NhMGR4MWQzMEdi?=
 =?utf-8?B?Uzk2S0tFczBpYkQ5azlpVldDRStrdFBxL2ZMTW55Wi9sSUpJUjBVY29RS3Fs?=
 =?utf-8?B?eU0rWTBBNytSUDhMcEJzZGEwUVpCL2JsTXIwTTN0SmEzNlR0ZTVTOTZrKzlu?=
 =?utf-8?B?SHJ2VDh2RUZNSS9QS0FMcHQ4YmRzUnN0aVEzMWVJZyszMDExNUVZR3V2Y1JO?=
 =?utf-8?B?STVKamZ1ZXM0Nmd1eTU1c3cvYzU3dzIyMTQ2L0krUmFMckpFcXRNWGZSWTNv?=
 =?utf-8?B?T1FpMmVReTc5TlZ2WnZDRzVuRlU3dGVnd1hEQ1ZlYUUwdEcxWkFPMUx4ZzVh?=
 =?utf-8?B?NFZlYzZ1Ty9iL2QxcWNTZXE2S1BSU3J3aFZyOTU2dFpLZGJsbCszc1g2R3ox?=
 =?utf-8?B?b1ZrdW9EdGxNWmUwcnBOSTdmZXZCekNRZWwwMVBmL0Rvb3QyNDBlajJiSnhx?=
 =?utf-8?B?RTh0ZEJJUnZ0NjFZWU5ENXBzTGptTjMzSmtYOFM1aGxXZUV6bjZQNnZaNXAz?=
 =?utf-8?B?T1JVcHJwd2xQTDJsSmgxSHRRZm5aVnl1cjFoT1dRUGNJWnFrbFBRSng2d3pI?=
 =?utf-8?B?bU9leFVwL01YeWl4dm93VXJ6SVlVWGQ1V2gwVTVSMzExaDB3aklBUW1TRUFv?=
 =?utf-8?B?QmlvL1BaUGJXZXF5RjdBVXlSU0VFMCtjOW1pa0Y3cUlEYWtsZUFCNDJoSjVq?=
 =?utf-8?B?cEw1UUFMSHhZVm1oU3VKTnU5VlArckdMQTlqSklYRUZFR2FTUnV6UzB0ampz?=
 =?utf-8?B?NElpWTAxMGp5c0tVTE15cDNEellYaS8rWkh6TTJFOUQ1NGZsZjhXZmdtK2hI?=
 =?utf-8?B?WGF4N1VOWEdZb3V0RmhETGhiQVUwbGg3ejdUV0QzLzNiejRVR2l1ZG5PN2Zn?=
 =?utf-8?B?dHNJWTJ6eVQxTzJjeW0wb3dzeXVZMEpwaHRFakdtUWlvWG5JSjVYWXI4eU1D?=
 =?utf-8?B?clFna3d6QWk4TDMyTFIxYXovSDlTRXlaZ1NESTl5aDVPNnpDUms1QjVINUl3?=
 =?utf-8?B?L2FKT1FVRnVCNzhCV3I0aHdKRlBnMGFrVFViTXd3RUZnZ1pYNmtXSUl5b0g3?=
 =?utf-8?B?STNHUVlkMlRpWTNRREZpSFpCV1hyRFgzR1h5RzJxZHdkRC9FeEZGdHN6UERn?=
 =?utf-8?B?akYycmtLZng2Z0kwU2V2Z1dCQjVrZWQ1WG4rVlVjclFieEVreWlpb0dyMGVL?=
 =?utf-8?B?TmJxTTVRNGMyQ1NyY3RVWmRDeEFwRWVudlBPQWtLUXhISmFFQm9PYllkVzYr?=
 =?utf-8?B?VWZlUVhLbWVleEk4Rm9mc1FaeGVMdFQ1Rmw1elg0QVNveVIvT05pY0pFcGtp?=
 =?utf-8?Q?SKfpDnzJjJwVfhywSW0HE12y4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaeb62e-abd5-4ccf-0e85-08dc2ec98170
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 08:30:17.7623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8D7EpjeacikW2Ewz5d4pJsZi3EhZ54e8VtFsU/yT5rU93798e6CZBrCtKb7Wou9jdAz7bjyRgdGTq95ld75Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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

--------------H2BMj9C0n0NXDSj7SXF2Preh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 2/15/2024 9:31 PM, Srinivasan Shanmugam wrote:
> In the first if statement, we're checking if 'replay' is NULL. But in
> the second if statement, we're not checking if 'replay' is NULL again
> before calling replay->funcs->replay_set_power_opt().
>
> if (replay == NULL && force_static)
>      return false;
>
> ...
>
> if (link->replay_settings.replay_feature_enabled &&
>      replay->funcs->replay_set_power_opt) {
> 	replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
> 	link->replay_settings.replay_power_opt_active = *power_opts;
> }
>
> If 'replay' is NULL, this will cause a null pointer dereference.
>
> Fixes the below found by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:895 edp_set_replay_allow_active() error: we previously assumed 'replay' could be null (see line 887)
>
> Fixes: c7ddc0a800bc ("drm/amd/display: Add Functions to enable Freesync Panel Replay")
> Cc: Bhawanpreet Lakha<Bhawanpreet.Lakha@amd.com>
> Cc: Roman Li<roman.li@amd.com>
> Cc: Rodrigo Siqueira<Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai<aurabindo.pillai@amd.com>
> Cc: Tom Chung<chiahsuan.chung@amd.com>
> Suggested-by: Tom Chung<chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> ---
>   .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> index 443215b96308..acfbbc638cc6 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
> @@ -892,7 +892,8 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
>   
>   	/* Set power optimization flag */
>   	if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts) {
> -		if (link->replay_settings.replay_feature_enabled && replay->funcs->replay_set_power_opt) {
> +		if (replay != NULL && link->replay_settings.replay_feature_enabled &&
> +		    replay->funcs->replay_set_power_opt) {
>   			replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
>   			link->replay_settings.replay_power_opt_active = *power_opts;
>   		}
--------------H2BMj9C0n0NXDSj7SXF2Preh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">Reviewed-by:
      </span><span style="white-space: pre-wrap">Tom Chung <a class="moz-txt-link-rfc2396E" href="mailto:chiahsuan.chung@amd.com">&lt;chiahsuan.chung@amd.com&gt;</a></span></p>
    <p><span style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"></span></p>
    <div class="moz-cite-prefix">On 2/15/2024 9:31 PM, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240215133129.2345398-1-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">In the first if statement, we're checking if 'replay' is NULL. But in
the second if statement, we're not checking if 'replay' is NULL again
before calling replay-&gt;funcs-&gt;replay_set_power_opt().

if (replay == NULL &amp;&amp; force_static)
    return false;

...

if (link-&gt;replay_settings.replay_feature_enabled &amp;&amp;
    replay-&gt;funcs-&gt;replay_set_power_opt) {
	replay-&gt;funcs-&gt;replay_set_power_opt(replay, *power_opts, panel_inst);
	link-&gt;replay_settings.replay_power_opt_active = *power_opts;
}

If 'replay' is NULL, this will cause a null pointer dereference.

Fixes the below found by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:895 edp_set_replay_allow_active() error: we previously assumed 'replay' could be null (see line 887)

Fixes: c7ddc0a800bc (&quot;drm/amd/display: Add Functions to enable Freesync Panel Replay&quot;)
Cc: Bhawanpreet Lakha <a class="moz-txt-link-rfc2396E" href="mailto:Bhawanpreet.Lakha@amd.com">&lt;Bhawanpreet.Lakha@amd.com&gt;</a>
Cc: Roman Li <a class="moz-txt-link-rfc2396E" href="mailto:roman.li@amd.com">&lt;roman.li@amd.com&gt;</a>
Cc: Rodrigo Siqueira <a class="moz-txt-link-rfc2396E" href="mailto:Rodrigo.Siqueira@amd.com">&lt;Rodrigo.Siqueira@amd.com&gt;</a>
Cc: Aurabindo Pillai <a class="moz-txt-link-rfc2396E" href="mailto:aurabindo.pillai@amd.com">&lt;aurabindo.pillai@amd.com&gt;</a>
Cc: Tom Chung <a class="moz-txt-link-rfc2396E" href="mailto:chiahsuan.chung@amd.com">&lt;chiahsuan.chung@amd.com&gt;</a>
Suggested-by: Tom Chung <a class="moz-txt-link-rfc2396E" href="mailto:chiahsuan.chung@amd.com">&lt;chiahsuan.chung@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 443215b96308..acfbbc638cc6 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -892,7 +892,8 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 
 	/* Set power optimization flag */
 	if (power_opts &amp;&amp; link-&gt;replay_settings.replay_power_opt_active != *power_opts) {
-		if (link-&gt;replay_settings.replay_feature_enabled &amp;&amp; replay-&gt;funcs-&gt;replay_set_power_opt) {
+		if (replay != NULL &amp;&amp; link-&gt;replay_settings.replay_feature_enabled &amp;&amp;
+		    replay-&gt;funcs-&gt;replay_set_power_opt) {
 			replay-&gt;funcs-&gt;replay_set_power_opt(replay, *power_opts, panel_inst);
 			link-&gt;replay_settings.replay_power_opt_active = *power_opts;
 		}
</pre>
    </blockquote>
  </body>
</html>

--------------H2BMj9C0n0NXDSj7SXF2Preh--
