Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEBFC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 13:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE8810F8E0;
	Tue, 14 Jun 2022 13:08:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E68410F8E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 13:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf9EWO+0IMgVMfeKeK8js+JefTu0ltgT+ojqNxiq8l5SgbvIFNt5yjQGFPDRGsFZD1FmCpZKJluGRZUrtEMEALsqJDuFo9Smnpj6GkyntDi6bgWIzsG91qEEqg9cX2IIboHLipgoCLXnfT4NtxdfyzJMMxkEzyI6p0zt9Z7XlsxRRJrOIx6MsSvTSCE0ewaiWW2+HKC45pprsJs10Z2XyQNE9tWm/aKHt2KDBUHbc1eqv2+mPd2+sZqgPtMxcz2Rg3mgPAQaS+wfQk7238Oiy236CFE+yxiwZaRjI7tkQtwkX0VjNLNz8J6lipyVIUeKi5g0hY4BR2W1MDPXOuvWtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeT9FeVDhTuUCL6u7zqYKfjSoGUohbdrTv4JhfzO/a0=;
 b=Z9CgeV0YhJ+lvrtCFbk0x8U/isFljjl2er7HjDlqXbq4PdMDHKpa+2b+ytYOQbFU4fwz/c5ycxrJ9q1Htyx/6y66am8gcUoETe4F2GHH7lI42hWuzLNR+2BRwWzrRyVmkQh6lIKpOQIkjQ8cl/Yhf/J4LqHh3nSaRFegmnRXjvBMW0m7yZ7oOTwYA34jdoTU5w5fxCcWz06F3LTVqrgUGC1l0TLOkbwgb4nTJHB5iBEwyJyO3jH8PKAOgksFJZwMWp5uhAasXIP5QHywdB/al3h7gEaOejiTktVNdvj/niSTzVlsE+Q0en2wY4xb0gZg7pJu0xS4mh8Ko08Ok/RLSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeT9FeVDhTuUCL6u7zqYKfjSoGUohbdrTv4JhfzO/a0=;
 b=XBXNKTlZhlaKj0YjR1p5x4dfxvkQQcEbqiNIz5XZbk/nCOwEYvu33MS1rIYVGrgbY0dzGkcWOKwmd0OCZcD+U0ObNqg70jMdZHdTI1bC+rJoJFE+Z40ZVnVNr4+pGQs+ws801812chsuE0wN5W6fl8VyHIR0vaW1BTVkkOZEP30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 13:07:59 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 13:07:59 +0000
Message-ID: <240036f7-d83e-61c4-5820-262a97274f44@amd.com>
Date: Tue, 14 Jun 2022 09:07:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 20/23] drm/amd/display: Disables dynamic memory clock
 switching in games
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 "Vanzylldejong, Harry" <Harry.Vanzylldejong@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
 <20220610205245.174802-21-hamza.mahfooz@amd.com>
 <3c4a7856-dc93-8933-0904-0b6f2d270bc1@mailbox.org>
 <MW4PR12MB5668A72B83B72BD7EDB29BFB96AB9@MW4PR12MB5668.namprd12.prod.outlook.com>
 <DM6PR12MB425067D163386CE813BBF02FF4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <CADnq5_O0yYM6vG+R9wf7-v4uNmKqvBXWy_-kKewiBQfN6SmY+A@mail.gmail.com>
 <DM6PR12MB425031A66132DF5CEF04B0B1F4AB9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <467bf0af-5967-63bd-97ad-4b3fd105fb9b@amd.com>
 <a5ec7ade-9386-d9cc-5f08-4a306b435379@mailbox.org>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <a5ec7ade-9386-d9cc-5f08-4a306b435379@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::21) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9a9400c-322c-415b-bf6d-08da4e06e7ab
X-MS-TrafficTypeDiagnostic: SA1PR12MB5637:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB5637958B65732E7D60A4F1858CAA9@SA1PR12MB5637.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Omd5TkyOhi+vm0MIRzA4/90McZOdKf0dZofSGAOtquMPYBcS031O4lGPXkEhTtt+5BgT3Nda9SEhJGpODsylZonCZwXSObJTBjIZN0t1h3Y0nUsrBtp8xOt4PEsi+jlcuaSRycEtVt1oL1xe4zAB2pXi93wK1NB47JbmD0+gJ3Ze2Vxw5pULkCFQtH97bwQH5R0muypjs6MrOK5nH/eutZ8g7Dw4ieFUXOfpFKMSBlLCfnV5VMD8hX/prLgR7SEYDsywdIQgKzdI4hOVlTHn1MmmRnwIzhxbBL580m6MeRGOjqrrbz2Fe//mE+HeeSeBwGpMsS0Z/0O5+P/WW3pL6W1WzZlI20fJuXU9J9VCdBxj+GY3tlgVaJ/8fDdd8BcxzS1sbhlvDFES2s3Se5Eda07JjLsbVGuN/W67Ucu2CS20PdRsNRaL2JBaIYMdjc6ofcwca+e4MhGFvgSa0d2ceYjVRWDQwE6z4mMllJm5IPK4VoS/hay/S4a3bmkWhzkOFAMMeK1YYzzLpt7LHOylIbvVpVfGZ/56+7I4T00wX+puJy1ecbkfBBJweAh8SlAHNlJxqSmaZ1GDG1qFgcXZdYTS0Hcz4idMXMmYbCf/HKoxzdp8V3CvZcPMUQqyEBNb4Get+VyYX/8rX1HCOkD/CjfxHslYBAELwJ0iWPtlQfBwZ3ujtM0TbMyWTsT5+8sRf580WZ+Lbf5Tl2kMRFt2mdPW2S2USq4/+tl/qR6gIPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(4744005)(186003)(5660300002)(83380400001)(44832011)(54906003)(2906002)(110136005)(38100700002)(6486002)(508600001)(6666004)(316002)(66556008)(53546011)(66946007)(26005)(6512007)(6506007)(2616005)(4326008)(31686004)(8936002)(36756003)(8676002)(86362001)(31696002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEtOdWJMRGJDZ1ljWUh0TjBQa1JlSm1FUkRweFlsZGV2QXpDNVhEdEw0MUw2?=
 =?utf-8?B?SWgyMkVGVkcxUXZvd1B1M2cwdngrTVU5M3Z1UVRDMWlHSmJtK0JZZ2p5ZWU4?=
 =?utf-8?B?dkRPeXgydnloYTVkR2h1MmZ6RUE2YkpBc042ZXFtb1NRMnJCVXNaVy91ZCtZ?=
 =?utf-8?B?QXBGSnluSVhXM1hmVnN2OUdMd0JOQlhVSllhcGk3WUJkaHczWE9TTjFYZy9O?=
 =?utf-8?B?ZmNqSk9SUHphRlF4UDRCQXFDM21tdVAxMWg4cGcwN1NMQStPYW9RU21uaUsw?=
 =?utf-8?B?TDVFbEk1OEpJMFA2enhWUGRVUTNjNm9qeHBhd1Z3bERybWoxOHlZc09pU2lW?=
 =?utf-8?B?NUVkUGZhN3FmbEtwMVFpSDhjd096WGxsZ0tnV2VGS3BqVmtId1YrdldjWmc0?=
 =?utf-8?B?b0hYQ2pCaFE1U05hdWFqbFo1MkR1dlhCQm1YYTVycW1KL3JCUG1qcjRBQUgr?=
 =?utf-8?B?REduK1NUeFV5RDVuRnJlNkRva1lBOXZGOFV0UmM0TDdneHNzMGdIZk4zeFYz?=
 =?utf-8?B?azBrZmg4UkhVdUtMRllDOFhDKzJEdGlQaSthS1NxWVFUbkc0TmVjMXlJUzds?=
 =?utf-8?B?UkYrMnpzdGY2RzlrNVdtcXBKQkFReGFWZU9MNXRqZWhaeW5ZTko2ZXQzUFk1?=
 =?utf-8?B?UyttZlNUbjJ1ZGRIMS9PY2xQaks0UlNhQ3ZoQkg3YnN0OWhvQUdnMTNqUWx1?=
 =?utf-8?B?UldaaW0zb25sd3NFM3ZSZnpvenFuc0QzVC9Jdjd6TXpyRkxKYmsyZzVzWUR2?=
 =?utf-8?B?dThIZUt0OUcxdUs0Z2x4SVMvdGVBaVZ3NlNFWUNCeDVtMjR1ZmswRkdpaHdM?=
 =?utf-8?B?ZERxRVlTdU1yUmJjL3JCVUFzVDRXMSsxd2hYTFh0NkoxZUZ1c3hqYVZEenF4?=
 =?utf-8?B?alQ1eEFCTHIwZXFKeTR6UnVVNjgwY2ZOci9JYTlRanNUVEc4TXl4VWUwZU5S?=
 =?utf-8?B?RHBQZWZOam90SGF2aXg3anIxMk9jMDZOOHE0U01UVkdoMEo5ZGw4YnB4cUNO?=
 =?utf-8?B?TVNrSFdaNWs0bjZaOFpWUDhDSWdSM1FjZE52cFJTajB4QnNkY2Q2MW4xc0VI?=
 =?utf-8?B?aE9IdGczNzhlTHNjMjU1d21GREphb0FkVjlpV2ZaQVBRaEtXbXhHUFNITXBl?=
 =?utf-8?B?b0FJUUZQaDFVaWNFcVk1QkV3K1k3enBIUURhNzhpYk4rbjRGOEpqd1EwaFRC?=
 =?utf-8?B?b05Fbm1zUyt3OHlwQmNEK2twbkF3MEpuTk5rQlZHT2Z6V0poOGhQdTV3aGdF?=
 =?utf-8?B?Z0VBTUhSQ2NSaFo0VXVvZWxlR2szM2tzSzVYSXQ4YzFwT0FPOUd6L3BmZHA0?=
 =?utf-8?B?NE9JOGhPMDVDNkRHTTNvY3ZsVEdPcjVSdnNEZW5raEU2bStrMFFkRzBrUnAv?=
 =?utf-8?B?WVQ5bkpHOVdwbTFSTHNmRzBuZGsxTkVPaTNWOWF5S0t5TXkxKzRMNXU5UEx0?=
 =?utf-8?B?bWxWV2M0T08vNTJ6R1labEp0L1cwSzJmQWhTOFgrZTlBT1F1K3Y1Zjdib1dX?=
 =?utf-8?B?OVJ2eWpaL0xzeDE3VFpVbTl0ZU9EVWRXOXovdzZMOURiUUszOXRLTFBRb0Iy?=
 =?utf-8?B?N0gwL1g0U2Z1d29GYWNOMUhrSzFsbUpNUks5dFByaXZUU0NFYWE2dkxBbGpO?=
 =?utf-8?B?Yi9weXdBQmY2SXRYOVErWW01Y0Y1aUJSYUtqRm11aDU3NUVWKzhuV0s4bVdo?=
 =?utf-8?B?N211TkM4VFlWbXBDcGtkSjh3RnY1TzRJeWppYmFqS0dLRG9sazJlSjNpc1ht?=
 =?utf-8?B?UURYZElMM21SS1dCZUtuUXVCQldmZ3pEdjhpMjQzTUg2RVI5OE95cjZpdk92?=
 =?utf-8?B?VzZReEQrS01VNXhtNTIyT2VXSWh0NjdyaVVmMXVFZ1VQc0c5amZjL0Fnei9O?=
 =?utf-8?B?d2gzRlhQUjQ5WTN0dDhTMFYxVFBmeVA1eENuNDBSSlJwWmtFZ2VKOWVIREx6?=
 =?utf-8?B?L1Mwdk1rSjZsd0dGbWh4M1JnQkcwYmUzekY1b242K3FpanR4VWR1QS91b2Ez?=
 =?utf-8?B?UWNQMTlDeTVmckVjbmNJb2lSb3NWZ0FWdllTMlZsNEt4dGNhKzIyMzZycExn?=
 =?utf-8?B?TjYyajZ3U0RxMG1BalJpK1p2bDAwYm0vNGdRUHVoTVFEOURhWHMrN3NROGwy?=
 =?utf-8?B?a1FhdzlMeDZ2R3A1MTNnY3FWeXZ1NnZsR0U1NmdEV0xEcml5SVJGV2xyaVo2?=
 =?utf-8?B?Yy9RTUdKdU0razZwWDd0aUFoS1AzV0Z5NUwzYWlFSVZJSlpMYzlTVDVZNFRP?=
 =?utf-8?B?U2xyZENCVmZVbTR2RUxmNHU0OVl2NkR2SkdRc0NUdDl4N3VJTVF3TXRvWUFq?=
 =?utf-8?B?Vklob0hqb2lKY0pwU2xzYkNaQnY2K1NHMEJhd3lyZWVkRDVBNzZJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a9400c-322c-415b-bf6d-08da4e06e7ab
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 13:07:59.2565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIoev42d8ciY3bXOZJDLXKB9Hm6rv4fhInCbWpgdU+8VZ1uZpp+Si8ieWAgKjzLGNT5fzJzGiOtrB5hF+yvJhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Liu,
 HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Clark,
 Felipe" <Felipe.Clark@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-14 04:57, Michel Dänzer wrote:
> On 2022-06-13 19:55, Harry Wentland wrote:
>> This seems to be a case of a Windows-centric commit description that doesn't
>> completely make sense for Linux.
>>
>> The code-change doesn't currently affect any behavior on Linux. It just lays
>> the groundwork in DC to allow an implementation to do a memory-clock switching
>> decision based around VRR support.
>>
>> In short, this won't be a problem for us at this point.
> 
> Thanks for the clarification.
> 

No problem. Thanks for your review and for voicing your concern when something
doesn't look right.

Harry

> 

