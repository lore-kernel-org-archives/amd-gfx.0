Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADAACD8CA4
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 15:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F0110E391;
	Tue, 10 Oct 2023 15:10:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DAC810E390
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 15:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/3GG5Mv+r3JuxPkVRIBh0zildT6xC/KSKKwuQClBxmpPeXrO1jJsLFIBfAzrHbHOZXtowwe4jsFuNwq/33H7skv/wclq03+M5zH+HwpIWMS4mdRxOI96v/cF0T77qwRMh/Wt2j2YWNxz+OBYolzVVwmN+9I2RdqbwjYC4kBxLRGYbgUXKErNavvQ5StP6OMG3X8Ch27MdgOB7gu+y4UXeGESMJbDzBqHnUjwBordEHN4nrtPgKz9bxpAYeX3VAIHl3OlJpm82JiwudrCyQB/SHkY2AyzDsfH+fZVWVO2wcwxgObOhp3MJ7GllHR6lQg879IntDowj7jSHBrsqK6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbELcMuAqchwTRBbGK1shTVXqXtH7OPxhYXh5W6Dias=;
 b=AGrasfmmDpAdFld3ZZPshhj+EwYOwsw1iLVXCg/B6kuUh6xJh7sR/2TinonvQmGEIoQbpBINQguF44ZrxsVu44QCsvbPY0Gzjd9cPQtvGTuwZCjorLOGyp2JPasxmPUzJ+0k4cjI4wDCuT6ZNDS1Tg36N1e/k4fXYk73Fz9VVwyRPdE7pDBJC8TdpXPK5EytWTyag9bmRefA6tbZcgqOhmVnOwliI9vQLESI3asLxN0UCIrHlloF2AAAKjrQM4J+mM5uYWg/zGqDfowOyIjl7og1NbTV3BTFr7/ETGKniyX/c8PIyZ57rzyu0BKvsWF5qRv+gVJuPLheUAtPFLoAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbELcMuAqchwTRBbGK1shTVXqXtH7OPxhYXh5W6Dias=;
 b=Urer/DjlJt2Ss2dxAh2cibm625igB6ct3Rs/t5UwFGys7lUXh8+M+asEKwzrksrPAi3yVhd2BFpHS2vdvKEllQ3V53EituYjUPUigjByqf18+7nrWyAebTDTRgWqVIh6zGnarR8KbOqvHI9Ed1AIsmZvdYlHD6hVP6VauMkd/m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 15:10:18 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:10:17 +0000
Message-ID: <1df5caa4-0975-7663-fb56-3a1ec525c69f@amd.com>
Date: Tue, 10 Oct 2023 11:10:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Make EXT_COHERENT parameter affect APU svm
 memory
Content-Language: en-US
To: "Francis, David" <David.Francis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <MN2PR12MB2909BAAE46A5FAD2E4549FD7EFCDA@MN2PR12MB2909.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <MN2PR12MB2909BAAE46A5FAD2E4549FD7EFCDA@MN2PR12MB2909.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4a4bf0-0573-485d-c3bb-08dbc9a30365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFmZiy1+VeYjkmrt430BcTSa6/Rtr+1d0ArIutoGETb0d53LBYam8i4EU3twWMJEqFQD9oqNCAoUi9SRZ6oU8ngJeBxjwFA5PRSV81+u4pOCtLbQ0d8QexcrDjjM3MzTsF13nNqTJEe38Q752/wRqhRyb2yvdK6ulABVdvy+/GgiUbWqvf4RshFnF8Z4cjM58kB6Sys4aTHsFTppCkdY6ZNQ5XSJVt56+7K9mZIIHT+LOBzd1jzNt23TgN/u+xTRb5BzusTn06B8iI1e3SizPday9YPtI4LMr4OgPXNFLovIQKLbFQX/drqYGAcn2S/reZWnwd1kDOWe9qxW9HIwMWHLulEotGCqYy6tJvq/qnouQ+aX7JzMGeRQ/piJzotZuzlP8mhJgEsKBZFiDvD2CuMQmHyCOipM6eb303MIi8DPg5Yz7drQhEcx5al9zI8RjaWE2kFHn4XkUmAQvn/NqkNjYjnkdhZWJFIuTL0ICNtJE6n4qFxxZkjGwbyCNF3lv8xuEVSId9EVxZ1RCJdQKi5LTuiDlw82IJHGNOmh+m6erqeyl5qm3LUyDJ2CHcSZ5IlQdd8IGtgOuF6cEobPVwS8o5Qjax4LPvSMi8tzO8aHEYnAUPxOZ+7uIl447kbWKmGG0KXOsFrF3BwRPsesww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(2616005)(83380400001)(26005)(66556008)(66476007)(316002)(110136005)(66946007)(8676002)(53546011)(5660300002)(8936002)(41300700001)(6666004)(6512007)(4001150100001)(6506007)(6486002)(478600001)(36756003)(31696002)(38100700002)(19627405001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1KN25hQ2RsZUpLOHFhRDdaRC9QcktuVFg4YUg1cVFOSjN4eHNCa0t5UGtp?=
 =?utf-8?B?bDZhYSthRlhDWkRqN25iQ0F6VXhPdnFpS0RNdUtVRXlQK1E1bjJoaGlRZFZm?=
 =?utf-8?B?eUQ0SENvVy9Hb2ZtSG00RnQ2OU5jbmt5cUVSMldOVytTdE12aytJRFkyZnNu?=
 =?utf-8?B?V01tR09DNytMRUJKa29jdHdLZmJ6cHZjRmhWWmREQitBcUJaN3FZT0JBemp5?=
 =?utf-8?B?Z3hGNU5sdnFpcFFLamhBbklhM3cyaHFqcWo2dVZRN0YxU1h3dGx5NFI3eDJ6?=
 =?utf-8?B?Zy95QytpMTdQQU9Sb0JJYmdoakFsQ2hwTDFwQUhsUi95WHpvNHM0VXYycWZ2?=
 =?utf-8?B?dHprS3NIa3R4dEtpbHd2Sm5vanNWNEdxei94MzRkYVdXOVlTQ1YxRGYrdTJW?=
 =?utf-8?B?NzF1UjU3T0FEZGh0WDFLUm9JbmxwdUw3Z0RXWmdwK1EvRk9ieHVjLzNsMEpV?=
 =?utf-8?B?WElOSjZVQlg3Rk5aVkpobWdwaUdua3dnMUx6TDlhdVUveDRjaE9vVElpYmFK?=
 =?utf-8?B?UUYzZTdMeVNWSlcyK2lBcUoyR3hpN2lhM2FOcVJRQy80N0hnamtBN25ySWUy?=
 =?utf-8?B?OFFWK2owaWdBdWVPUXExVzRuS3BBVEcwUGwvQUtCNjZSMG5aOFNrMitCaDI5?=
 =?utf-8?B?SVZRQkt3cVJ3MkE4VXg5SUp2QkNlT0RseUNhaktMQURJeHE1Mkd4VnpYTXFB?=
 =?utf-8?B?empPN20wQ24wbjFjR2dpcHNSZmd2OGpJR0tzOTE0bGZYODQ4bzNKalVrbi9Y?=
 =?utf-8?B?cjNEdjVubWdLSDlIY09Iak5wcXViYzBwWHdKVmp1aWRlM213VjJnQTh6ODVp?=
 =?utf-8?B?WC8rYng0SlV6NUNvMFdBV2NscENLb2tSS1lleE8rYlhTbGdQMkdKc3dqSkNx?=
 =?utf-8?B?Wk5MdVQ1bFpqWVg2RWpRWFlJN3JrWTlpRVFPalh0Q2xlcGtjUldIRFNWSHov?=
 =?utf-8?B?RXBhZUhOaFdLQTRhS0tVSnltbmsyUmpBU29XK2ZGVmgyNThxL3FpOWVlaWgr?=
 =?utf-8?B?dHJVS0dPN2ZodXltYXBJSldPTzVWL0Y4MTdvUXF4aGc0c0tENlIwTzB3SjlC?=
 =?utf-8?B?TTJIdEtaNE01ZHlUT0xpOVBMTG83cEp5K2ZqSEdua0hsbGlRclkvZHBPcHM2?=
 =?utf-8?B?N0tHQW1LY295UVhmekU1czMrNzdZQkQ0RXRQT0krd0xMR1ptakdCVE5OeXlo?=
 =?utf-8?B?RDZtbUdJek5Kd1RUdHVJbW5EeEhWMFQreWEra2FwRm55RUluNC9ReTRXeHBN?=
 =?utf-8?B?WHREa0sxSmt0a3ZkUXhRdmlnTFVOOUZ6TUV6SmNlTU5QWTh6Y0FPUUVUODhO?=
 =?utf-8?B?Q0dqckdSQ2lvODVBMU10b0J6L0MrK3RFYzV5Uks1Zm05U2VDZWhUSGxFemJv?=
 =?utf-8?B?clNxcWRpUkdMYTZYaEc2VFRxS21Mc1VOVmljMzhoZUhOV3dqa3VuOWZEU1Iv?=
 =?utf-8?B?NFlUZHdDSWU4Um1JZkJZWWhOazNJTGJzM2F3anNSQmtkMDJwQkdML0ZEVURn?=
 =?utf-8?B?SkdPdW1DUTNMS045dWJyVHJ6UEJabHFBMUlNd250YkZGdXF0dU11UXUrS0F4?=
 =?utf-8?B?VTJFVWk2MzVUN0FnTzFGd1J0T2J4Y1NFdzJqbisxOWcyZmhuK3dwSnhmUjY5?=
 =?utf-8?B?c1ZSbFFWREZYcktHM3o2alNTMmt0Z01NbG52NHlaM1dIL1poVHo4T3h3VTZt?=
 =?utf-8?B?blBtRlp0TExhMlpPUURnaHAxa2wzUzEwVDFrRW5aMC9LanNNVXZHWU9YdTlS?=
 =?utf-8?B?bjhSNDg5SmVabzdRei9BbDBUeVEzNUVqaDNLL1ZDdTdnT3BaWWlraVlHTzVz?=
 =?utf-8?B?TGFTZlc0NEd2bU8xeXV0bmNaSTE0VmlYOVVyNGpQTm5iVTFWczQ5R21EZCtZ?=
 =?utf-8?B?eGY3V0x5MU5OTU1iRm50cG5KK1VwcUVTbnc2UkFlb1NzakljVkNhcVNidmhU?=
 =?utf-8?B?eU9zTHRZT1JtaDI3MzFEV2hsS3VJV2x2Q1Q2Nk5lWEd3RU90d1lsMkRVWnls?=
 =?utf-8?B?S01iWU1OaVk4NW8ycU96ejI1V3pTaDNFVGl1d2RQd3N5eVA3U2hkaS8yR0F5?=
 =?utf-8?B?bmVSV242ekVoWjlYZGhMei81b1k0ZlMvdzZTWG12cGpZc3NLVGZZRTZYS0xt?=
 =?utf-8?Q?JhZ4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4a4bf0-0573-485d-c3bb-08dbc9a30365
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:10:17.8274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUIzqPDc5buXJwcatCGIn0ZUBmgkzOBXhGcynMaNMkHSWpH/vRBX8NtC1O4849gH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-10-10 10:32, Francis, David
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB2909BAAE46A5FAD2E4549FD7EFCDA@MN2PR12MB2909.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
          [AMD Official Use Only - General]<br>
        </p>
        <br>
        <div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">By the
              intended semantics of the EXT_COHERENT parameter,</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">it should
              cause the driver to use MTYPE_UC instead of</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">MTYPE_NC on
              non-local gfx9.4.3 APU memory.</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">Signed-off-by:
              David Francis <a class="moz-txt-link-rfc2396E" href="mailto:David.Francis@amd.com">&lt;David.Francis@amd.com&gt;</a></span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">---</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_svm.c
              | 2 +-</span><br style="font-family: &quot;Segoe UI&quot;,
              &quot;Segoe UI Web (West European)&quot;, &quot;Segoe
              UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,
              &quot;Helvetica Neue&quot;, sans-serif; font-size:
              14.6667px; color: rgb(0, 0, 0); background-color: rgb(255,
              255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">&nbsp;1 file
              changed, 1 insertion(+), 1 deletion(-)</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">diff --git
              a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">index
              7b81233bc9ae..d9ef937308ed 100644</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">---
              a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">+++
              b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">@@ -1286,7
              +1286,7 @@ svm_range_get_pte_flags(struct kfd_node *node,</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              if (num_possible_nodes() &lt;= 1)</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              mapping_flags |= mtype_local;</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              else</span><br style="font-family: &quot;Segoe UI&quot;,
              &quot;Segoe UI Web (West European)&quot;, &quot;Segoe
              UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,
              &quot;Helvetica Neue&quot;, sans-serif; font-size:
              14.6667px; color: rgb(0, 0, 0); background-color: rgb(255,
              255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              mapping_flags |= AMDGPU_VM_MTYPE_NC;</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC :
              AMDGPU_VM_MTYPE_NC;</span><br style="font-family:
              &quot;Segoe UI&quot;, &quot;Segoe UI Web (West
              European)&quot;, &quot;Segoe UI&quot;, -apple-system,
              BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
              sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0);
              background-color: rgb(255, 255, 255);" class="ContentPasted0">
          </div>
        </div>
      </div>
    </blockquote>
    <p>Thanks for finding this bug, I think on NUMA system with
      ext_coherent, we should use CC for local and UC for remote memory
      from another NUMA node.</p>
    <p>The NUMA locality check is done in
      amdgpu_gmc_override_vm_pte_flag now, seems we need refactor and
      move the check here in order to use the prange-&gt;flags.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:MN2PR12MB2909BAAE46A5FAD2E4549FD7EFCDA@MN2PR12MB2909.namprd12.prod.outlook.com">
      <div>
        <div>
          <div style="font-family: Aptos, Aptos_EmbeddedFont,
            Aptos_MSFontService, Calibri, Helvetica, sans-serif;
            font-size: 12pt; color: rgb(0, 0, 0);" class="elementToProof">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              /* system memory accessed by the dGPU */</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              } else {</span><br style="font-family: &quot;Segoe
              UI&quot;, &quot;Segoe UI Web (West European)&quot;,
              &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,
              Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size:
              14.6667px; color: rgb(0, 0, 0); background-color: rgb(255,
              255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              mapping_flags |= AMDGPU_VM_MTYPE_UC;</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">--</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
              Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; color:
              rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
            <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe
              UI Web (West European)&quot;, &quot;Segoe UI&quot;,
              -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica
              Neue&quot;, sans-serif; font-size: 14.6667px; display:
              inline !important; color: rgb(0, 0, 0); background-color:
              rgb(255, 255, 255);" class="ContentPasted0">2.34.1</span><br>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>
