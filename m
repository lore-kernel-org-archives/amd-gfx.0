Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CFBC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Oct 2022 15:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D9210E3E1;
	Mon,  3 Oct 2022 15:26:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD4D10E3F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Oct 2022 15:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Garg7BgJsfFilV2agEa1jKIBX/kLrKbxg/FxyFFCurSfqx/smxcG52/MNdqa2mYPwQIrkwhHTPrARHzcTs3IoaOFun+HsRb8PBUr8wIRh9DIubUggbrfnxKCx0S+AixdofrpncwskDaER+XrXqT4TBiDaED+HAHTWLm8ByabaqrTfJhigLKIMK2jjbSxb6bArIfOfHQuFo+Lw93VW/EKv74ycD76rk0bK91paKzH7L4AzN2Hz6f6dRVnF2oecOCqE9jc5NqbOLh9eYtaD3j8oY9sAew95ptBRFmjmiwjZqd4HKY/Tbq2qY7mRtRjISHejhaBUCLRHzbNdV/ozslUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTdQQOSxOHX4bRzCw5yCqT1UD5TMRLP2DkvmpbgNv3s=;
 b=CMzNQHhir0nC18FHTqf+YYj+hGDM2qNTELRcuRAP5MDm0E2GAY7qPauJZFHIzeWWBK3wbQXbgSuoGszHk9vdXsVnhEgsPFQEWgw8fj5oGYE16YqyQxG9Q9oV2DXlo3OlTOs6svKNZVByk9oqlL756OFNcDdajQLSKoAZzn9igWeytAmuuMbTog4kbVw8bxP/mZVQ3dzmXpDH2Ke6JaV7NyHUmgef/PhxuE//pSyFlia2Ns0aXvPchTnOFvyl24+Fzf3W12+6qHLBrBe7UKZPr4VmdILnuhcOyq2FbWV1rotLFco4oUidVprAvT7NdH1aSBU6c1Wj8nzwF4w87kRLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTdQQOSxOHX4bRzCw5yCqT1UD5TMRLP2DkvmpbgNv3s=;
 b=V9Ha2DSjW187t5SRfkALvj+3dPAEC6lVOv873W8hUG0RxxGGDL2APjw82ztlqSAmrBPrwHhL7hFGrYf1qJUNN6w3jwrPt6ctxEVCTHkEH3QELp/41ruxaC59ocYwRWvr2FbI/IAIZj0tTqxD4G7ERs6WXQ+e+DJ9SlZHQAJ2Bgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 15:26:48 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::5cee:a878:4d07:3ca6]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::5cee:a878:4d07:3ca6%8]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 15:26:47 +0000
Content-Type: multipart/alternative;
 boundary="------------IJl9wCufRFZo0ttmp0INL6Ed"
Message-ID: <8ac24a07-6255-3092-95af-40d3a0d3124f@amd.com>
Date: Mon, 3 Oct 2022 20:56:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: disable psr whenever applicable
Content-Language: en-US
From: "S, Shirish" <sshankar@amd.com>
To: Harry Wentland <hwentlan@amd.com>, Shirish S <shirish.s@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>
References: <20220930102705.43367-1-shirish.s@amd.com>
 <184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com>
 <39ecdc96-7fd5-d433-09f2-2af01a36315d@amd.com>
In-Reply-To: <39ecdc96-7fd5-d433-09f2-2af01a36315d@amd.com>
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR12MB1264:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: a20345d5-b330-4ece-fd77-08daa553af90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkeaJ0xtShq8h2UNr59nU8I0QeGM72VGkqrRzRcvlrUzfBJCw+zFuQNQBVGAgfK9qMVyAdtUai0R3A+dwdLCaI6qG62YMxz9EV/hisob/Gcy/8MVD3/AXj9/fy351x/+Xhm7pJcGm5Uo8rTyC2LqhfcNg6nn07KcHU1FNcojmClpaf7+1ECZkrtU03gEIaURq4BGLLGqUHM/C94117ntmerFtU+YOCU2gprsvj6Eg1dgmpR4A5Q1tpPOjsnGLaJcnXiI0uDjekO4Qm5dnAZ5sY826F1/uPs1Kq+B7uS/ym/JS6Ces6zssiRXlFVu63kIzjL1m9vHS0tdag7mWPIIFtz1M+YsoBoGex8u3wNrzzxrN8ta6BKQUuzH1V5U7STYcNnse5gLgkEol6ZdtHAVNl/YjOkpAjiDq6vKjoRVKwXNm8/EkazfeX1Inn3x8auugGq72imoVQPCfmpXdDeeO3qd2LlUwWe3tTmD47uFUzMB99lkDPVJtvzS88uE/BYCluPwhoN4cz3cOAjJ9C0TAt4bufh/+oZV2zvGDzcMhb1c8lylVTaFiQzLbe+o0vqs+yCGbahP4GC6MYZi279TsirqgEjbihsC2DztF3k+QnTVI3k5LDheIGE1EY5hb4DYJHE2zbj5pCTIgfHCuQE8cOznNOr/FVtaPoAkO/w7uLBQMOyKYqJ24qiOKdrswO596C49jwzLV+lvPKWsO8BYyLUaper3l8hhucUvTjk/Z+1uV2iV/bSSPX2QHB+1wPck0DOZFZkFGfm/WJHQf/ZkPTlr5PkyoZcWgQNFU235G9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(38100700002)(36756003)(31696002)(6486002)(8936002)(478600001)(2906002)(83380400001)(5660300002)(4326008)(8676002)(66476007)(66946007)(66556008)(6636002)(316002)(41300700001)(110136005)(2616005)(53546011)(6666004)(6512007)(6506007)(186003)(31686004)(33964004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1Rld2VJaWYzSXliaTZESkVva3JwczQrWEptTnNOc0tzRlc1aEs5dkNmeUVQ?=
 =?utf-8?B?NVNsZnlEdDJiOWJWbGFoVlB3SFlPclFVd0ZCVC95UEJxcmpadzZteGxycVJ3?=
 =?utf-8?B?WjhKcjhHRUg4eGdMSXFCaHZ5QlpnZFJhK052d21MTFFoTCsyUjIvTXJlbTZ6?=
 =?utf-8?B?NEdYU05HdTRmQWwxdUhiTjJia0M0cTQ1NUJXZXlBL2VSb2JLaGQrYlZ5ZEZK?=
 =?utf-8?B?UEtTa29yWFpiU2VDYUdVT0hYb3BjcGZCd21lZWtqcjFNWmdNWXpZM1I0a0Ry?=
 =?utf-8?B?Vm54WkFaVWcvUU5EODZWaEZ4d21TTkx5SlV2MHI0MHlWTHBZdTY0V0FXK0p1?=
 =?utf-8?B?ak43TXA2bzMrSlBLSGJDVXpqWUhHWXhWc09OMHFzZnFYeFpIU1FIZWJ2a1Vn?=
 =?utf-8?B?WE4weGRoeVRZWWxQeUVuYkpJUGNUNjZlb1VjZ1pOZlk5ejQ4M0NRbFRuY2o4?=
 =?utf-8?B?SWo2Nkh1RHcraHVCTjVGcm1sd0FDMkFSSi80TG5qMXBKUEdDSm1lUFFCbzNm?=
 =?utf-8?B?bzdJUm1MN000SGNLRlZranJKb2c3UzRkWnBjSUlKS29IWWdQK0ZNR05xMml4?=
 =?utf-8?B?ZytjMFRDZ0wvY2hFMGtxQUpKNHBwTnVGaktIZ1ZZYkhkTXBOczF3T0J5am9B?=
 =?utf-8?B?cUdveC9kT0Z6MUxLWGM3K0FySWV3aWM5c3lJWTlEcmZ0dzhIYUxGejAyaEEv?=
 =?utf-8?B?czc0aEFyVVpjS0NHajVlRkxIaDUzbGhzYk5UcEsvbE9xWmhYU3ZKUDRRSVNv?=
 =?utf-8?B?NzNLSTU1QUN4TzVodHIyWHVxVFJ3QjRnYWVoU1NZUW5ZNGRaMGhseHV1OFhk?=
 =?utf-8?B?c0tsUHhiVXByeHRLSWxGQ0NIYmxnRmhXQ0xYM0JEVGNHMW5wMmtnVzQvQzhI?=
 =?utf-8?B?RVpoYmUwVHpsS1Bxc1lYc2t4aUFEWFZ6ZFJnZkZWWWVDRWZEcnpybHVvL05F?=
 =?utf-8?B?Tk8xajFlVTVTTzRWOW0rZGFyTDhCR0RmTkVjdVFCaGViWThPMUJxRnE4dFgz?=
 =?utf-8?B?cm9obUx1MXQxSWtRdytNKzkxNk1GYXBjdDUxMjAwSjQ0QktVSzVJY2FBVkFW?=
 =?utf-8?B?aUtwbnp3Y0RSUSsvMkYrZk1TQk5DZElmMkYvdmx1WHVKSWlhdHpocm82dzRm?=
 =?utf-8?B?NVU5eXVzR0VnZ3dzUHlMVnhxQitpNlIwMVJIbjNxOTVOMkZEN3BWK0cxU1k3?=
 =?utf-8?B?YVJocHNiOHllTjJ5alc0Rk5KNTRzNmVkSmlQNXB5SGZzc0RBK1k4R1AxUytM?=
 =?utf-8?B?dWRIYXpsa2o3VEJtM2JyRGUwQ2k3WFJSQVA0dmorYktUaXRHQ25ObkZHVlM1?=
 =?utf-8?B?bm42UGtqUGttQkc2aHIyeFA0RmtkQnRacWhrOTl3QnpzMitOMkRnUCs1QTlR?=
 =?utf-8?B?ZmRhUlZ1NTAvV2xBUnNQTWw1Z0RaUCt3VmcvNmpXYlFPbnZLRTJoeHhWRGFh?=
 =?utf-8?B?SGtWM3ZhRFM0eHZ0VkxFZHppcmlJSncvZTNNdTNNd1IwaGNYNEFSNDNoanFa?=
 =?utf-8?B?QmEyNExHQzlQc3pLOHdzN0RkT0YyZXpLeklKN1oxTEdGaVZBY2RSQUV4SFdD?=
 =?utf-8?B?a0ZkV2hjNmdoUEdrSFVhaElMdTV2UUp3RXdsRkRKZDdhbTdXRHdmRG5DL0JY?=
 =?utf-8?B?ZjBxMGNFbllXNnVIMDlHbzhsNE4rN3BnYUliWUFXWnpvYncrVGZDbG1yVSs4?=
 =?utf-8?B?Z3VUR25DUy9Sd05idWVBZ1VpT2pIL1BORis4UEV6STZDeE9RbVNMbTUwWjkw?=
 =?utf-8?B?RWorQWsyK0xmVEtkZUpoYXp4S2llMmNLS2NvTGpIbFFvYzNLNUxYWnYvZDhZ?=
 =?utf-8?B?REpwQk9wRGZYdG51WjZXV2VmYjI4R1hLSGpsNm9pUkRENGpUS3I1NERWVk16?=
 =?utf-8?B?NzQreXIzeHgyTE1Pd2JaYXRreldvdTBvRWxQNGpzTnZobElLamFnL2RmYkpq?=
 =?utf-8?B?dERkTDRUWWsrZzVpSEo1NFVvNzFCNHkwZGw0cWNXUmFpMm9pendScFQ4SEZn?=
 =?utf-8?B?b2NVOXBOTkhtT3JTSDNneFl5SWtmRXhJMjVPaGVzZWJVSnMxMm5hTmxCRGhR?=
 =?utf-8?B?dGNEbHc3ckI0Ny8zQ1ZhSXdnTUdEdzBpUks3RGVrYlM4bmJzYlNSL3JabzhT?=
 =?utf-8?B?TEVERm9VUFEwaUV3ZHU4UXhsZXhNRXlGV3EvQWQwWHB0Y2tCbkNtemNLeVBG?=
 =?utf-8?Q?laA1z65ap1snCXAqhp19CobZEPMMbLXh7qe+fonMG6uC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20345d5-b330-4ece-fd77-08daa553af90
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 15:26:47.8510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhwHlbpQ24HarvvZNDGCJnBRa6zFnyNaAXkYHGPVCh+HTAqevXipA+oTHDSsyJNvuAd3N1xnrhMAAcZmMQtGeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------IJl9wCufRFZo0ttmp0INL6Ed
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping!

Regards,

Shirish S

On 9/30/2022 7:17 PM, S, Shirish wrote:
>
>
> On 9/30/2022 6:59 PM, Harry Wentland wrote:
>> +Leo
>>
>> On 9/30/22 06:27, Shirish S wrote:
>>> [Why]
>>> psr feature continues to be enabled for non capable links.
>>>
>> Do you have more info on what issues you're seeing with this?
>
> Code wise without this change we end up setting 
> "vblank_disable_immediate" parameter to false for the failing links also.
>
> Issue wise there is a remote chance of this leading to eDP/connected 
> monitor not lighting up.
>
>>> [How]
>>> disable the feature on links that are not capable of the same.
>>>
>>> Signed-off-by: Shirish S<shirish.s@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>> index 8ca10ab3dfc1..f73af028f312 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>>> @@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct dc_link *link)
>>>    */
>>>   void amdgpu_dm_set_psr_caps(struct dc_link *link)
>>>   {
>>> -	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
>>> +	if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
>>> +		DRM_ERROR("Disabling PSR as connector is not eDP\n")
>> I don't think we should log an error here.
>
> My objective of logging an error was to inform user/developer that 
> this boot PSR enablement had issues.
>
> Am fine with moving it to INFO or remove it, if you insist.
>
> Thanks for your comments.
>
> Regards,
>
> Shirish S
>
>>> +		link->psr_settings.psr_feature_enabled = false;
>>>   		return;
>>> +	}
>>>   
>>> -	if (link->type == dc_connection_none)
>>> +	if (link->type == dc_connection_none) {
>>> +		DRM_ERROR("Disabling PSR as eDP connection type is invalid\n")
>> Same here, this doesn't warrant an error log.
>>
>> Harry
>>
>>> +		link->psr_settings.psr_feature_enabled = false;
>>>   		return;
>>> +	}
>>>   
>>>   	if (link->dpcd_caps.psr_info.psr_version == 0) {
>>>   		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
--------------IJl9wCufRFZo0ttmp0INL6Ed
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Ping!</p>
    <p>Regards,</p>
    <p>Shirish S<br>
    </p>
    <div class="moz-cite-prefix">On 9/30/2022 7:17 PM, S, Shirish wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:39ecdc96-7fd5-d433-09f2-2af01a36315d@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 9/30/2022 6:59 PM, Harry Wentland
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com">
        <pre class="moz-quote-pre" wrap="">+Leo

On 9/30/22 06:27, Shirish S wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[Why]
psr feature continues to be enabled for non capable links.

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Do you have more info on what issues you're seeing with this? </pre>
      </blockquote>
      <p>Code wise without this change we end up setting &quot;<span style="color: rgb(0, 0, 0); font-family: &quot;Source Code Pro&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: pre; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">vblank_disable_immediate&quot; </span>parameter
        to false for the failing links also.</p>
      <p>Issue wise there is a remote chance of this leading to
        eDP/connected monitor not lighting up.<br>
      </p>
      <blockquote type="cite" cite="mid:184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[How]
disable the feature on links that are not capable of the same.

Signed-off-by: Shirish S <a class="moz-txt-link-rfc2396E" href="mailto:shirish.s@amd.com" moz-do-not-send="true">&lt;shirish.s@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 8ca10ab3dfc1..f73af028f312 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct dc_link *link)
  */
 void amdgpu_dm_set_psr_caps(struct dc_link *link)
 {
-	if (!(link-&gt;connector_signal &amp; SIGNAL_TYPE_EDP))
+	if (!(link-&gt;connector_signal &amp; SIGNAL_TYPE_EDP)) {
+		DRM_ERROR(&quot;Disabling PSR as connector is not eDP\n&quot;)
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I don't think we should log an error here.</pre>
      </blockquote>
      <p>My objective of logging an error was to inform user/developer
        that this boot PSR enablement had issues.</p>
      <p>Am fine with moving it to INFO or remove it, if you insist.</p>
      <p>Thanks for your comments.<br>
      </p>
      <p>Regards,</p>
      <p>Shirish S<br>
      </p>
      <blockquote type="cite" cite="mid:184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+		link-&gt;psr_settings.psr_feature_enabled = false;
 		return;
+	}
 
-	if (link-&gt;type == dc_connection_none)
+	if (link-&gt;type == dc_connection_none) {
+		DRM_ERROR(&quot;Disabling PSR as eDP connection type is invalid\n&quot;)
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Same here, this doesn't warrant an error log.

Harry

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+		link-&gt;psr_settings.psr_feature_enabled = false;
 		return;
+	}
 
 	if (link-&gt;dpcd_caps.psr_info.psr_version == 0) {
 		link-&gt;psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
--------------IJl9wCufRFZo0ttmp0INL6Ed--
