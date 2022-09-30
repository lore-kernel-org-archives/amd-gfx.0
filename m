Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B447C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 13:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A9810ED05;
	Fri, 30 Sep 2022 13:47:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C130B10ED05
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 13:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNJMdN6bcilk9bHBJ/xpxk8yrVVBjmrx9vmETHZXkRNpK114IdABMR9NTaB4n2GlOpgf0ZTqtx2rWib1EhJy/uYie0b5+blylZX3Y/2IiY6S+a84BYxYiWiIEx5K1LfX4aq4tcA5xLYPZHTHluh9zI4FxkVnIVzCrjyFAQn6KhlMxJigj6H6DyfVvCa4oC2m6H5ApJCfnK+2B9mg2IuTI8V7a17T45+Us+2rEldzgm3KMbX9bzyU2juIkJ1c84vTglgKV5sF6HMq9ACVz3lHgIYHs4BBEVHxy9B7Vp6BCI9Kpj8dHFIoHF3pdh1h2n/IqiWWKscfUXn4gtPVl1A2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHUfsRNtNh5UVzTT4nDRU2z1XM17K/lOYdF/0Z+fXAk=;
 b=TFqC3FE+dzQKEGAus5GppYAIVJVgS0+RMaLRrSzo5CrK4eAdEuWxxSP1ERrjq6mWsmcW6NE27P0pt+wkno0fKu9/8wJ9FY6Am0JJtITnX6kPC10xdWooOCC02I5Gte6qBbvFu236e2ho5oHsG1JXH9r25nbcVUg9PBADKL4MAtztKwtj7dRLMq8itvsSyn9VRZFrP7tPcmuPwVl96sxotAVPdXBBdxRvsVgYYZ9IdlXiiwR2cMv3eynQxSzKrgOiYwNlKapx/7CzddAQaeqMx1GQi+Ct7AabKrXaxMZ9BC1XXuHoBCg64Np1Aq1gt+DVv9CfbX3SgFAmnJQC9aZnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHUfsRNtNh5UVzTT4nDRU2z1XM17K/lOYdF/0Z+fXAk=;
 b=Qrg+R/TsHlwjdUq1UQPo6+d2JHLMV6LyerOa6gNYJXBBfdVSXRNNZzxeZMzuhgDfFWxpdKdcNGHjpt5KoBnLrOzNXNxxVQqwNiC+Q3wmn+Np2OzJu4Wunr6y22nKU+sF++s9+e+vDrSoeg/AEbu1KT6cM32qacMiPWRvsYY1nBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Fri, 30 Sep
 2022 13:47:49 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::5cee:a878:4d07:3ca6]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::5cee:a878:4d07:3ca6%8]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 13:47:49 +0000
Content-Type: multipart/alternative;
 boundary="------------VDkP02OuFvfgznKYHJ0oIbBq"
Message-ID: <39ecdc96-7fd5-d433-09f2-2af01a36315d@amd.com>
Date: Fri, 30 Sep 2022 19:17:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: disable psr whenever applicable
Content-Language: en-US
To: Harry Wentland <hwentlan@amd.com>, Shirish S <shirish.s@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Roman Li <Roman.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "sunpeng.li@amd.com" <sunpeng.li@amd.com>
References: <20220930102705.43367-1-shirish.s@amd.com>
 <184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com>
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR12MB1264:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 940ea990-d042-41a4-f3b2-08daa2ea5c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tf8lPK8RF+AceJo+dj5UscFYK708nj7B/l7LMzCrybD6vmI34Dw4WQBeD/Md3MFtzyvStCqRpGemEQUT2q5naYREP92Mao/SnZkicEpbzIt001xlWWDl2w0AW9q48knQ9i4XPqS8UFTJuVEOHWDuGYKH3gTKZVyHtG3U0s8n4biBtWfEpDaisCJwPXH1X4Hk4g9Tdk9ajpY0qI6uktJ7EFhZgEGoinVFENsq7nHF3QYvcOJne0pnNNfpsiFtyCotbIw19qxftWXstSzFoo6tIl6itW3Nhl2LFeVoSFUVaatTUbghO0vjfohalSrN/uz8mbKL4hpH9cN0YWbFvnwWJxGm+Mh2MGekvax4jp0w5qyHU5ljw3QyOCu4zZ5mbaTi5vS1vmRZkIcnJ37Y9m1z1RJ2I6iapyLHVlMo/bEUdVS1B+1ih3N3NAxM/72755MICbH7rUC21Cbus1vBmxdR1kvHEfNhhcaeKBQthVAjleD5jhylbp/uWetK9+BxGm20zNdhg1G5m275fNnuzdrTMP5UNsZe7SQC7k8lEhYNoxJ46bITaIVE2bFpfNlrMilSx9Ycy5Jg9iYdDyaDnS3mZM/FvXJl7EmkdpD0v51JRjdJicojvhOoA0vt50k6dtMfNOqgcH9Rhs5u11ZwXaPR3O0Wu9tycqqHaXXpdswe/C6Hl1p03h4idShuEKAIGnIPj8Fb5dcQnCa38S5n0Iu9gvQawsD/Ej4yuqXrJoUixNQjrpqm/a8ifn2yPlD7gGhsADqvuHL1W4OJ4pnxdc2BtOf8s6xqDY0ecIcMLKxbq3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(31686004)(186003)(2906002)(6666004)(2616005)(4326008)(66946007)(38100700002)(66556008)(8676002)(66476007)(316002)(5660300002)(26005)(478600001)(83380400001)(6636002)(8936002)(41300700001)(6486002)(31696002)(53546011)(6506007)(110136005)(33964004)(36756003)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OThKZm9leEIwejRSNit5eit3T1pVdXcrTWlJSXhybStUMEFhQTRsNGNab3g5?=
 =?utf-8?B?UU5qTEVxR2pyeHY4Y3BZZStEcjQ3N2QyVmRZYzF3NVVVUFNsOHJXYmpESGJM?=
 =?utf-8?B?NjNUNXU4Y0ttNmlQdVI5NDVkcThLaitwVFVONDhyL1UxaVM3VVRIRUR1RFBD?=
 =?utf-8?B?ckVoMDBqRzV0amRlQ0FGNVpjcG1mdi9rb3J2ay9JZXFDcHg1TmhOMExNYzlS?=
 =?utf-8?B?aU5hbjE2RE9Fd2ZuRmVuNDB6dnFBbExhSU55SGJiZFlqcndIYUFGa3dPMEI5?=
 =?utf-8?B?TGEvdkx3Y082WUFkamZSWTg2YWJwWjNRaTZkSWpUb3RFblJVUk03elRaY3VT?=
 =?utf-8?B?K0tQcnhQZE9EZytmUzN2VXFDRi9rVlB2cmp0amZwRjlSdFVhTE84eEI1aE9I?=
 =?utf-8?B?U2xGR3NHU3JscUNIUlNvUTRZWGpJQlZkSTRjb0ROdHNjdWVxL2FpaXZZc1BV?=
 =?utf-8?B?K2pKSjhlNWtxakFaVzhRY2g1MWcwdUQrRGgwWEpwa1lKNllPZ1cwSVM5SUNH?=
 =?utf-8?B?YkNXRXdQbnFWU081UlV1SFVxVmlhcDJITjFFbE1XOU4vMHJnazZqZUJmY2lq?=
 =?utf-8?B?NDUyT0tYdE1TOVUwcTNCVzNkUDR3OGcvZllUWnJnV0h3R3gxUlFMUzBuL1dJ?=
 =?utf-8?B?RDVFbGpzWHdiamZFaEQ5RnlidyszS3VoUmRxTmpSVjNyZWpFeHVFbXUzUXpS?=
 =?utf-8?B?MWE4VzdERjFnajhWcnk2cithK1pONktYOUkyNzZSZVdKcUR6U245b25lcWZv?=
 =?utf-8?B?MHU4K3dCcVJFNmljN09udU1JR201SjQwNzJjR3pKMHNWVlFlVWw1b2FPTERq?=
 =?utf-8?B?MGwzbFRtSEI3MEoxTExPenVFWGRwRUFoZ1RTUzJWMzdZQjdlVGhxRmticUl0?=
 =?utf-8?B?cVZiVjNxanJzek1uRWw2QmhxRGpEa05mbFFnbXAwbHlMOEs5ZitCQVZNWnNR?=
 =?utf-8?B?L0Z4bUhvODVwRUZ5SFN1TnVOMzRqc0Ivdlk2NDAxbmJHMjRadWN0UlA4bWRt?=
 =?utf-8?B?MTZhOWlxVStwRGhDYUhXNjBGOHMvY28zV0JvQStMbDhWaGswNncyaWQ2a1Qv?=
 =?utf-8?B?MzFvT0t6TXdBQWNtWVp6eWp2WDBxNG1tajg2dUN2cGljWkFUdU1zVEt4bkJM?=
 =?utf-8?B?WGJZV01PZjBvNXBkdXhjeTF0a3NKQ0ljOU1Sa2duRzAyQmxNMHhGUjF6Q0xJ?=
 =?utf-8?B?YkdGeUFXZVJYUjRLTytyL1gvcWdTVjdwd3VRMGtlcTYrNFRTZHhuMTQvR0JK?=
 =?utf-8?B?d09oV2dlWjFUQXVEemd4WU50VnB4RWJBeFdFVkdHZy9wdnRuemk4Unh5MjJB?=
 =?utf-8?B?QmlCaTB0Ly9pZlFSV09JcG5DaHR2VGQxNTd6Y2I5dXQ1eDVPV3k4TkNWdUkr?=
 =?utf-8?B?KzFWUVBHNGpKNUd3RFBpb1VpS3NtdkZWUjNxZnl2dkZRSVNvc3BtV0tMOXJC?=
 =?utf-8?B?YzR6OUp0ajJhaEpORFFaMUR0Ymczei9WSEh4cDYrWjZQem1hTU96eUVOWCs5?=
 =?utf-8?B?V1dHNGluQWlZY2MrVGF6VlIrcTRmTEpwcGlYK0NmcFU0a2ZSaDl4eHZ4bkdB?=
 =?utf-8?B?R0lOaE11dERCazVRYjZCdXVKRjVPOHYyeTFJT0h5bysxSmdXbmM5YVZETHlp?=
 =?utf-8?B?clRyN1p6cTF1VlVRT3BFVW5xMjFsSlRsejZReWRyQXd1YUx5N01iNEFxRnFQ?=
 =?utf-8?B?ckM1THRqWmpibm1TZUs4WGFMM1pVb0QzMUpIZC9uOFV5WldSc3J1UXFPUGhi?=
 =?utf-8?B?WmhCU2w5OFpJNTkvODNhcWcxaDM3Mm9kZFNESFQ4VTIvZm1wR1BpOTk3NDZD?=
 =?utf-8?B?VThMZWVIZFpvbmJIc0QvVWp5SnZBWlFvckdMSGg3UWV1eHZnNXpnaFJOOFFX?=
 =?utf-8?B?OGVLT2ZBVmxEc3RzeUFJT3E0ZzhpS2s2cDg4UDdvcTQrMTVTalcwaU1tVEhV?=
 =?utf-8?B?L3NSWVNDZDlHT0ZCWFMrd3B0Qlc2cU5udUkxMFNMcEI0UlMrTE1ubStRWXRq?=
 =?utf-8?B?Si9NQ0dWWmQ4NE5BUXJibzJmYklmTnN0Q2pGdTFKMHpjb2pqSGFvZUxzY0hy?=
 =?utf-8?B?VzZNWFlUcjd0WG5oNXlKakpudXp0NnVHMjRRVWhkTElpd2JhMHpnelowSURF?=
 =?utf-8?Q?UA7xgfMd0hZ9Vhj1DYaToHdVI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940ea990-d042-41a4-f3b2-08daa2ea5c93
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 13:47:48.9187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0rYZAvQq6rzy3QzPYnNmDzAqTDPGtxT7LTz6kWrIBPLAJF2tVHLHZfG5pT8GkgI3NwZWLTV/BSRCjAFYdSshA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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

--------------VDkP02OuFvfgznKYHJ0oIbBq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/30/2022 6:59 PM, Harry Wentland wrote:
> +Leo
>
> On 9/30/22 06:27, Shirish S wrote:
>> [Why]
>> psr feature continues to be enabled for non capable links.
>>
> Do you have more info on what issues you're seeing with this?

Code wise without this change we end up setting 
"vblank_disable_immediate" parameter to false for the failing links also.

Issue wise there is a remote chance of this leading to eDP/connected 
monitor not lighting up.

>
>> [How]
>> disable the feature on links that are not capable of the same.
>>
>> Signed-off-by: Shirish S<shirish.s@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>> index 8ca10ab3dfc1..f73af028f312 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
>> @@ -60,11 +60,17 @@ static bool link_supports_psrsu(struct dc_link *link)
>>    */
>>   void amdgpu_dm_set_psr_caps(struct dc_link *link)
>>   {
>> -	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
>> +	if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
>> +		DRM_ERROR("Disabling PSR as connector is not eDP\n")
> I don't think we should log an error here.

My objective of logging an error was to inform user/developer that this 
boot PSR enablement had issues.

Am fine with moving it to INFO or remove it, if you insist.

Thanks for your comments.

Regards,

Shirish S

>
>> +		link->psr_settings.psr_feature_enabled = false;
>>   		return;
>> +	}
>>   
>> -	if (link->type == dc_connection_none)
>> +	if (link->type == dc_connection_none) {
>> +		DRM_ERROR("Disabling PSR as eDP connection type is invalid\n")
> Same here, this doesn't warrant an error log.
>
> Harry
>
>> +		link->psr_settings.psr_feature_enabled = false;
>>   		return;
>> +	}
>>   
>>   	if (link->dpcd_caps.psr_info.psr_version == 0) {
>>   		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
--------------VDkP02OuFvfgznKYHJ0oIbBq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
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
      <pre class="moz-quote-pre" wrap="">
Do you have more info on what issues you're seeing with this? </pre>
    </blockquote>
    <p>Code wise without this change we end up setting &quot;<span style="color: rgb(0, 0, 0); font-family: &quot;Source Code Pro&quot;, monospace; font-size: 13.3333px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: pre; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">vblank_disable_immediate&quot; </span>parameter
      to false for the failing links also.</p>
    <p>Issue wise there is a remote chance of this leading to
      eDP/connected monitor not lighting up.<br>
    </p>
    <blockquote type="cite" cite="mid:184d25c2-7af5-8a89-94bd-117c71c4c3fc@amd.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">[How]
disable the feature on links that are not capable of the same.

Signed-off-by: Shirish S <a class="moz-txt-link-rfc2396E" href="mailto:shirish.s@amd.com">&lt;shirish.s@amd.com&gt;</a>
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
      <pre class="moz-quote-pre" wrap="">
I don't think we should log an error here.</pre>
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
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+		link-&gt;psr_settings.psr_feature_enabled = false;
 		return;
+	}
 
-	if (link-&gt;type == dc_connection_none)
+	if (link-&gt;type == dc_connection_none) {
+		DRM_ERROR(&quot;Disabling PSR as eDP connection type is invalid\n&quot;)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Same here, this doesn't warrant an error log.

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
  </body>
</html>
--------------VDkP02OuFvfgznKYHJ0oIbBq--
