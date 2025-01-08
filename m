Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E598E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED3088DE5;
	Wed,  8 Jan 2025 14:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bFpL6YNr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B3310E198
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mc8voavQG656BzK/D/Wke36PopSIRIrDwn09bAS175MTB4ibfGudpFvCUSai7IwBseiSODU8WfuRYiKVZ+c8UVS9iZPV15g8kWpfOM18k2ssK2hhm8yMYJj9GJWK6zCW+CoGSj09WUI9lPvq2zAblm3GXQKtgUQfM6BM3rqvuKULJJzOT9UkVcDnOAmGqa8A3k+KfEwPLcz79u8FSOH5YpmNoVL4tBzDSbood8avtFnsxKrulgSwvK8UM9EcPZouMmvp3yfpp+Vqbw7tJJwqjg8lpXnmF4IwTbAeAbDoxWtpPKHPLbPu+qQjRjnMYHk4nISTAMCUSDnYdPpvCSvTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rfyf70BEYMRP0uum47h8f/EuvwSppKT7Js0czGydi0=;
 b=iJ8NN2fBJFHsT6P/j6VdOjxT9EfOYi3rcB+P4Ctk3fCfyylxykasyuH+Wvqvd10iDcO4adSrkcGAZPZ0fFg75hgDLYUivZCCWO1GhYSS8h6UZ39qmzdiM07Uf/1GxriYQe/3oVPB2RNzCkEOpeoFtZcWL7R45YZooyvmHwcnE6foClzKObFcTgcMjbK49mm2sXeWhQWWXQwxtn2ixrL9I3t1hICM2t9XmbT4vu9m1WTgjm3p4n75Lb3sxifap5ryqwbemfmLeP0wfcpXkGEejEBbfNLFPylGoRALSJo65bmz+Lr+eY+k0CxkRu03TD1clBFYbCCV9jS2pkaOSmeQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rfyf70BEYMRP0uum47h8f/EuvwSppKT7Js0czGydi0=;
 b=bFpL6YNrt2SNgyaupf6c8W5i9Z5FQzOwl7GDgeu4gC6wTBb4ZdXfwSkB/b3TPQHC+ZCMfvbTH0gMxCfqQhvXZV+D8azIBCjunQSaFhsoLhDGILNyOh84KWSWpqtRb/auUNa0w+doVaR2EOWcOW1ok7bVO7SFJ3Mxaiaky/Iof7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 14:57:04 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 14:57:04 +0000
Message-ID: <4065e322-e202-7a05-ce0c-65ea4f66fe49@amd.com>
Date: Wed, 8 Jan 2025 09:57:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <4db6b354-56e6-3d2e-0da9-bfd1943320af@amd.com>
 <PH0PR12MB5417148144D18CD9CDB70A3E8F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <48140c5c-bb03-2c47-020f-48132c61d61a@amd.com>
 <PH0PR12MB541759A19799ED2A183A95B28F122@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB541759A19799ED2A183A95B28F122@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::30) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: e64408f3-d0a3-4b45-ae1f-08dd2ff4b6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVdwV05URFRnWVB6VnI2UzBUR1BEeW5MTWhXaVprZ1F2aUoreFFmcXNBbGMy?=
 =?utf-8?B?TUFad3kxbUdUL2VTUDRLQkFjL2ZmRUx2aUQrcjAwQW05NURFb28xM0gySjJ0?=
 =?utf-8?B?K3NRRytmM0hBaFZOVG16SXBzd2hPaytWRGxmdCsrZUt6Qi9SSUVmVUtJUHND?=
 =?utf-8?B?M25BS25FcG9RbmR6eHhnbTVzQmtneG45S0lpWUh2cTBMNk94VVJBY2Q4azhW?=
 =?utf-8?B?ODhsbkZtYWQ3d05XL1diT2U2eVJMOFF4ZzhFNkUxMFlWWUNNMjFmSW1nOEM4?=
 =?utf-8?B?VU5DNmZieVFxU2g3WUFvNkRpMHpTU0FVcmdnWE45TCtKTWhFTjhWc1pRRTBK?=
 =?utf-8?B?djJ4bU1CU1dDRTIwZXc4ZkNmYU0xQXM4eitHWVFpei92clhTV3VpTzRla3di?=
 =?utf-8?B?NUNnbFljLzdyck5EdUlkY0dyY1lBTWMvcGxaN29ubHFnbjZCekN4S3oxOFQy?=
 =?utf-8?B?R1NyTmhRT0xGZjFEWTd6K1hZaWtoenZzNDBKZVkyazJscDVIL1g4OGFoa2ZP?=
 =?utf-8?B?cVVNYU1RbEtFUVQ0K2dIV3lNWURYL2RDOVRFTnZXbU1qYkk2Sjk5M2Q0WXVC?=
 =?utf-8?B?WVhFOWZqNFlJNk9FMzhWeWpOMm1scjJjOCtIKzNTclhqbzRNR0p2Ui9TVSty?=
 =?utf-8?B?YmJvNXFWYjdRWnh4dnc4a3NMZHVXSC9mcUtnc21td053ZEdXMUFjaEFuQW5i?=
 =?utf-8?B?ZTVLSThBL0k2aWRZWWU3bVhDTVlZMFRHakhjZS9qMENVV2lqdFl2RnBXdWta?=
 =?utf-8?B?bktwSHlLb2RwSS9nMVZEY3BiYXhwZnEyeTBGRmN1VytmSFhzMkxnK3hnQ3Q4?=
 =?utf-8?B?OWI4ZDlteWVGMjdSY0JTY1NkTUF0ZWcwTVozcDcxbzBUeVRZNjRkUTlwTFZJ?=
 =?utf-8?B?MTE2TWRlOElpRWV6L0JvdWRKTGVGOEtOR3lxbWY3MGhlNU1COHZKaUFsR21w?=
 =?utf-8?B?LzFNN2lSZTJqRU1kV2dOMHBzUk45cFk1MHFlcHUzUDV6Y2l4Nk1DQnM0MzhU?=
 =?utf-8?B?MEhVOGJxZ0c5UXRDd1J3d0tNUGh3Nm4yZUJwc25wcjc3RjhCaGtNb0hWYzZP?=
 =?utf-8?B?V1Y1b3V1RlhOcktmYlYxemxDUDZFM21hUmp2dXQzeERCQTNoejMxd3IwWlR3?=
 =?utf-8?B?V3RmdHVFS2h3Smh1eHFYU3Q3NHdJdmw1MEdVNi9XaERTOEZQWXhtYklrVm1q?=
 =?utf-8?B?VGxpeDMrZWNCdW5qSmxweFAzSVJ0ZGU3ckxEVk9lTHhldTJ0M29TVnVZSnhq?=
 =?utf-8?B?Vm84T05ycm9OTnZpYjJBUk1rb1lIQS9qUHM0N0M5Zi91c1d3R0ZVdTEvWmhr?=
 =?utf-8?B?aENsaklaYVlzUUs5dEF3U042eHNiOTl4eGtvbFo4NW9GdGNYM0pGdDNKdmdJ?=
 =?utf-8?B?NEcrRml5UHpSWkFNcFZiMEl6aTluaVFKc3V1NEh4dkpNZE13aC9OZnphbTFB?=
 =?utf-8?B?TWE4MnBhcFJPQVR6NmdmZVcxbWRaYTEyNFZXSTFkRTFtays4dHBsbkU5Q3Vp?=
 =?utf-8?B?NkNqWTg3RkQvZlZLSmora2RQRmxZdWU5RGN0YUpyMmtSUmNkK0piM3Z5QkYr?=
 =?utf-8?B?NzV2RWtXNDBRZTNObytTM04wWTVDcmk5ZnN1V2VWbjBURG40RlNWTWlpUEZ0?=
 =?utf-8?B?WjYxa0hDTFFpVDMzVlFWTWtRTkV2aUo4YlRGQ0VjM3lIaVpWWmt4VjZEZzdK?=
 =?utf-8?B?bldHWnozQmFTTkZBcXBGdERVZVI2Zm5wT3BRQ3FIVkhVNzlQWE1UT1llK3A5?=
 =?utf-8?B?M1NuUFgwcU1ITWNmUDlJeTFwZEh1eEovYTNPMFRBMGsvci9MTHVQV1c4ZXpS?=
 =?utf-8?B?S0pZWE5ORE9ENDZwNTFXTDlMZ21VdkNOVjMxS3Q5R294Uy80K09JM2I0bmhF?=
 =?utf-8?Q?90wW+Ny6XQFzg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUsvRVRqeTVZc2xWdVVoSUxocG9WUzA4YVR1K0lCeVNneTZDeVJQOHAzTWhZ?=
 =?utf-8?B?Z2QvYkZwV1Y0Z1JJTnp0SFlCWjFEblBkSGExbkxxVEcxbFVYV2xMSU4wQlZO?=
 =?utf-8?B?Z1pJNWxpOWJxTUJ0UWdLZFVBcFo2N3lQR0FYd2R5cThScWNOQVdRT05NcFhs?=
 =?utf-8?B?ZzREUWdtajhTQk92SjF1eGZkdXVBNXFZUDFuMTFvaFRPdS9UdDBiZXFJRktJ?=
 =?utf-8?B?a1JoRDdYNE1GT2M2RDFlU1lnYkpUdjNVVkJYUDdjT0RqVmlkakdDdE9sZzNF?=
 =?utf-8?B?RG5YRkZaVXhsZnRob1VEWGordlh2TFBqN24yMzF6OEF5eS83U3c1MTB5QnZr?=
 =?utf-8?B?ekhEbkhjdlpXMlNxUGZPWmJMc2Q3cWJpalNiSG5KTDVlT1pqY29oUE9Wdmsv?=
 =?utf-8?B?eFZuRWhiRVBONUJ2NzlWcVRlZGUvbm5NT0wwQTU0RUYxMGpqSmt6TzlYT01I?=
 =?utf-8?B?YVJ3aXVYZlR2VjkyMnlnSThpM2VudE9qcVhneG1DQjE2Q3lMakFpengxaWRz?=
 =?utf-8?B?clZUT2RBL2t2RzFJcGJWK1d2djYyWkZuNmtQcnZvVWI0aHI0T1RzdXdtR0JB?=
 =?utf-8?B?c2lPNEhTSmRVdmdQQ1hqc3ZUZWwyUW5EUDI0WFR2dHFoZGJpSUo2ekk2N0J0?=
 =?utf-8?B?d2tIdzRkZVc5amJiWDVKam0yK2VrR1Vjbk4wYzdNUjI5R01BWTBEVUl2Q3A0?=
 =?utf-8?B?ZVBSNlhJRktFWFVYRHd1dXhMMHkyeFZrYTRwRlhMSkx0V1cyQVFZM1pqL0Fq?=
 =?utf-8?B?QWdhVGh3MjI1aGNRSC9CdjloZnhlNTl2VVBxK01ndDRhV0x6L0pxZHlVV01j?=
 =?utf-8?B?cSsydjNiaDgvL2lxdkhvQjdHRDdiRkJVcWZSaVpUb05oU0J5V1VpR2ZoYlNm?=
 =?utf-8?B?dEVzUklnRjYvcDhtdkJLVklDSzRrdUgwL0xBOFhuMFcrZ3JxL3VoK3ZPNmtt?=
 =?utf-8?B?MWlnM3FRTnM2SkJNNGNOSDFMbDBDaUlWU21uN2Z4cml2bzlTOTlwLy9jQVJo?=
 =?utf-8?B?NURpdmxwam9Ec0lPSUUzcHRjYXVZczJLcnk4QVJENU1ONDVGOW5HVDFJVmZ2?=
 =?utf-8?B?bHZWRWVmMTRMY21DM1pjbnVFWVRuUEQ0S21tZ2NUTXJsdjBXNEZodDJLMzky?=
 =?utf-8?B?WUMzbzlKRzc4eVd5LzRINEhyY3Q1RWRROExSTWxjVFdnMFNxMWFyVFlmZjBI?=
 =?utf-8?B?bmQvS0pETnVEZGFLV2RDN0VUZjBqenI3QjkzNXNzeit2Qk50QjdzOHhqaGRy?=
 =?utf-8?B?VVcycTl0bktIYWZKMy9wbTJPbDhSM1R5Q2JVdHJtTjFsLzRjRitaak9YbVN6?=
 =?utf-8?B?MkZqVUlyejRXNjBZWkVNSWhTTHpqMDdMWG1vR0I5d3pTNk1tOWFPVURJMDFj?=
 =?utf-8?B?MGZHMlVPY3BSM1g3b1dVRlpnaG5abEIzZm5rUklqUS9NMXdBbjM3RnpmckNY?=
 =?utf-8?B?VnZYL1VMZlB5VkhpOWJFTzd6Z3d2ZW1DTld6NWluSHdQM1BkcE9kdy8rWVZ5?=
 =?utf-8?B?dzlvZkxHeGtTL1p3dTFZaTNwOFJNVFUxWjQ2b3RvWGY0M1VhTU1UWlZ6a1FM?=
 =?utf-8?B?S1hSRVFlSHMvWkpzR0tkWEYwbGhhWlM4OTlBaXdBNlpZSkJrN1JiaUFCbnI1?=
 =?utf-8?B?OHNaTS9iTEpLK3lYcmkzdWNHeDl5bkN4N0VJa1Q1Tm1YRHNCZnNFQlI5SWov?=
 =?utf-8?B?YVVwQkpyQStjdWsreXh5a3ZpOXNHb0owN1RBbGNPNW92RzJtYjVFZUZHLzJw?=
 =?utf-8?B?b2xQSU5GWitZYmdlSGJCVjkrWEtwWmZpTWFwTVhzVjdTWVY5alBWOEtpVEN2?=
 =?utf-8?B?K3FPNTk2Ynd6Sy9LV0tWMkw5RjVpMHVkN2VYdUpWbFdBeURXak92eFNnaG5K?=
 =?utf-8?B?SGZTNStQVk5ad3BwVjQwSUNIanJ2b1NJaG0zeVYyNWtmUXl0SkZVckRrdlhs?=
 =?utf-8?B?ZElQUVA0K3pXTGxNTUYrc2Mva1FYaFRFTUdpTS9abCtaTEVvZUw4WWY1OFVX?=
 =?utf-8?B?ZVBQU2lWZm94cWNVOGNzNGFpU1dQbStWWmZScWkyaHd2N2cwWFloN1pXdVoy?=
 =?utf-8?B?NlluREorV2pMUVBTQnB3RExOa3ozMWVRSEhaZFFFdllsQ3ZvR2tHWnZsQTRo?=
 =?utf-8?Q?70XHpSoeHRBSr68JGxCB3tqWg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e64408f3-d0a3-4b45-ae1f-08dd2ff4b6d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:57:04.3635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhwLA59pY7PoEKImUviqwKSW1Vk0I1oVWJjZyRjtdKnPTlw8lCgCTgZ0LvjNBoBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072
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
    <div class="moz-cite-prefix">On 2025-01-07 19:31, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB541759A19799ED2A183A95B28F122@PH0PR12MB5417.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Tuesday, January 7, 2025 10:04 PM<br>
                    <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>;
                    Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix partial
                    migrate issue<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal">On 2025-01-06 21:31, Deng, Emily
                wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                  Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                          Yang, Philip
                          <a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>
                          <br>
                          <b>Sent:</b> Tuesday, January 7, 2025 7:51 AM<br>
                          <b>To:</b> Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
                          <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                          <b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix
                          partial migrate issue</span><o:p></o:p></p>
                    </div>
                  </div>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <p>&nbsp;<o:p></o:p></p>
                  <div>
                    <p class="MsoNormal">On 2025-01-02 19:06, Emily Deng
                      wrote:<o:p></o:p></p>
                  </div>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <pre>For partial migrate from ram to vram, the migrate-&gt;cpages is not<o:p></o:p></pre>
                    <pre>equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed<o:p></o:p></pre>
                    <pre>migrate pages which could be copied or not.<o:p></o:p></pre>
                    <pre>&nbsp;<o:p></o:p></pre>
                    <pre>And only need to set those pages could be migrated to migrate-&gt;dst[i], or<o:p></o:p></pre>
                    <pre>the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].<o:p></o:p></pre>
                    <pre>&nbsp;<o:p></o:p></pre>
                    <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                    <pre>---<o:p></o:p></pre>
                    <pre> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----<o:p></o:p></pre>
                    <pre> 1 file changed, 4 insertions(+), 4 deletions(-)<o:p></o:p></pre>
                    <pre>&nbsp;<o:p></o:p></pre>
                    <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
                    <pre>index 4b275937d05e..5c96c2d425e3 100644<o:p></o:p></pre>
                    <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
                    <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
                    <pre>@@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;struct migrate_vma *migrate, struct dma_fence **mfence,<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;dma_addr_t *scratch, uint64_t ttm_res_offset)<o:p></o:p></pre>
                    <pre> {<o:p></o:p></pre>
                    <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;cpages;<o:p></o:p></pre>
                    <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;<o:p></o:p></pre>
                  </blockquote>
                  <p>As partial migration size is based on prange
                    granularity, by default 2MB, maybe always
                    migrate-&gt;cpages equal to migrate-&gt;npages,
                    that's why we didn't trigger this bug. Wondering how
                    do you catch this bug? This bug will leak svm_bo
                    too, as svm_migrate_get_vram_page reference counter
                    is incorrect.<o:p></o:p></p>
                  <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <pre>&nbsp;<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;<o:p></o:p></pre>
                    <pre>@@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;<o:p></o:p></pre>
                    <pre> <o:p></o:p></pre>
                    <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<o:p></o:p></pre>
                    <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
                    <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
                    <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
                    <pre> <o:p></o:p></pre>
                    <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage = migrate_pfn_to_page(migrate-&gt;src[i]);<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp; !is_zone_device_page(spage)) {<o:p></o:p></pre>
                    <pre>@@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j++;<o:p></o:p></pre>
                    <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                    <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
                    <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
                    <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
                  </blockquote>
                  <p>This should move forward, to handle the corner case
                    to migrate 1 page to the last page of VRAM res
                    cursor.<o:p></o:p></p>
                  <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Sorry,
                      don’t understand what is the corner case? And the
                      place you put has not much different with mine, as
                      it doesn’t have any jump or continue in the code
                      between your</span><o:p></o:p></p>
                </div>
              </div>
            </blockquote>
            <p class="MsoNormal" style="margin-bottom:12.0pt">migrate-&gt;dst[i]
              should set before this if condition (not after if) to
              setup sdma copy migrate-&gt;src to migrate-&gt;dst, if
              condition is true for the case migrating to the last page
              of VRAM res cusor, as the VRAM physical address is not
              contiguous.<o:p></o:p></p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) - 1
              &amp;&amp; i &lt; npages - 1) {<o:p></o:p></p>
            <p>Regards,<o:p></o:p></p>
            <p>Philip<o:p></o:p></p>
            <p style="margin-left:11.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Maybe
                I am wrong, but I couldn’t find anywhere in
                svm_migrate_copy_memory_gart will use
              </span>migrate-&gt;dst[i], it uses the dst[i] directly.
              So, I think it will have no effect. The reason why I put
              it to the tail is because if have some exceptions, for
              example “if (r) goto out_free_vram_pages;”, for this case,
              I think we need to treat the copy as fail, and couldn’t
              migrate these pages, so also couldn’t set the
              migrate-&gt;dst[i].</p>
          </div>
        </div>
      </div>
    </blockquote>
    <p>I missed your change to always set the dst[i] at beginning of the
      each loop, you are right, this works too. dst[i] is vram physical
      address for sdma copy, migrate-&gt;dst[i] is pfn plus flags for
      hmm migrate helper, I think it is better to keep/move them
      together.</p>
    <p>out_free_vram_pages path is incorrect now, I will put fix in v2
      patch review.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:PH0PR12MB541759A19799ED2A183A95B28F122@PH0PR12MB5417.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <p style="margin-left:11.0pt"><o:p></o:p></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                Deng<o:p></o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                Wishes<o:p></o:p></span></p>
          </div>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p style="margin-left:11.0pt"><o:p>&nbsp;</o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div>
              <div style="border:none;border-left:solid blue
                1.5pt;padding:0in 0in 0in 4.0pt">
                <p style="margin-left:11.0pt"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">code
                    place and mine. But it has “if (r) goto
                    out_free_vram_pages;” to handle the error case. For
                    error case, I think the
                  </span>migrate-&gt;dst[i] also need to be set to null.<o:p></o:p></p>
                <p>Please check this change, to add mpages accounting to
                  break the loop earlier. <o:p>
                  </o:p></p>
                <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Good
                    suggestion, I will add mpages in change.</span><o:p></o:p></p>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                    Deng</span><o:p></o:p></p>
                <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                    Wishes</span><o:p></o:p></p>
              </div>
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
              <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
              <p style="margin-bottom:12.0pt">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages =
                migrate-&gt;cpages;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mpages = 0;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *src;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *dst;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t i, j;<br>
                @@ -295,14 +296,9 @@ svm_migrate_copy_to_vram(struct
                kfd_node *node, struct svm_range *prange,<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(prange-&gt;ttm_res,
                ttm_res_offset,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages &lt;&lt; PAGE_SHIFT,
                &amp;cursor);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages; i++) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages &amp;&amp; mpages
                &lt; migrate-&gt;cpages; i++) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt;
                PAGE_SHIFT);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
                svm_migrate_addr_to_pfn(adev, dst[i]);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
                migrate-&gt;dst[i]);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
                migrate_pfn(migrate-&gt;dst[i]);<br>
                -<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage =
                migrate_pfn_to_page(migrate-&gt;src[i]);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp;
                !is_zone_device_page(spage)) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] = dma_map_page(dev,
                spage, 0, PAGE_SIZE,<br>
                @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct
                kfd_node *node, struct svm_range *prange,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
                out_free_vram_pages;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                amdgpu_res_next(&amp;cursor, (j + 1) &lt;&lt;
                PAGE_SHIFT);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct
                kfd_node *node, struct svm_range *prange,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma mapping src to
                0x%llx, pfn 0x%lx\n&quot;,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] &gt;&gt;
                PAGE_SHIFT, page_to_pfn(spage));<br>
                &nbsp;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt;
                PAGE_SHIFT);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
                svm_migrate_addr_to_pfn(adev, dst[i]);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
                migrate-&gt;dst[i]);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
                migrate_pfn(migrate-&gt;dst[i]);<br>
                +<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt;
                PAGE_SHIFT) - 1 &amp;&amp; i &lt; npages - 1) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                svm_migrate_copy_memory_gart(adev, src + i - j,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                dst + i - j, j + 1,<br>
                @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct
                kfd_node *node, struct svm_range *prange,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                mfence);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
                out_free_vram_pages;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j + 1;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j
                + 1) * PAGE_SIZE);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                (END)<br>
                @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct
                kfd_node *node, struct svm_range *prange,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
                out_free_vram_pages;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                amdgpu_res_next(&amp;cursor, (j + 1) &lt;&lt;
                PAGE_SHIFT);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct
                kfd_node *node, struct svm_range *prange,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma mapping src to
                0x%llx, pfn 0x%lx\n&quot;,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] &gt;&gt;
                PAGE_SHIFT, page_to_pfn(spage));<br>
                &nbsp;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt;
                PAGE_SHIFT);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
                svm_migrate_addr_to_pfn(adev, dst[i]);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
                migrate-&gt;dst[i]);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
                migrate_pfn(migrate-&gt;dst[i]);<br>
                +<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt;
                PAGE_SHIFT) - 1 &amp;&amp; i &lt; npages - 1) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
                svm_migrate_copy_memory_gart(adev, src + i - j,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                dst + i - j, j + 1,<br>
                @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct
                kfd_node *node, struct svm_range *prange,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                mfence);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto
                out_free_vram_pages;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j + 1;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j
                + 1) * PAGE_SIZE);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>&nbsp;<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,<o:p></o:p></pre>
              </blockquote>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>
