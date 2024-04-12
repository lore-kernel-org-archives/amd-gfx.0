Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB132C00A94
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 16:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7033610EC37;
	Fri, 12 Apr 2024 16:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QYJWVvMp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D7F10EC44
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 16:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGZ+q3OPSE2zXZvbTNOT9gvqQe7vXoyvR2Ctyo4bsl/SvUAXZRrhFKriIsmUOxieFGk/3w32vCYNzRf+AHl/CdY+z4/iorSYAQ2yYxoGOEOpm9uBG0xUHgVzsnHBdBYrmiFeAsDMiE0vMyX716JddRzjfdHP1Suig1VsMizJsbqBvFrT4Wf0/DLy4/7zNxqo/ruRQBMk7/uoRkI3dWHX9PbilqgPcWx0ge7HDogZ5j2QdGXnnbVZ9DRIRXNf0vPzawSkQ4rrzYLacu/92eZkQ5JHzEeqLOiAb3EB7S2vWGGQYI00Wzm1bgvzpjJrnYrqwBQV7SccPjw2zbd+tQrmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH+wYgrS/RTSppqTbrybFERCcA5tPvuwRgXdv3T2wng=;
 b=XhiFFKn5qknkKvhNI92TSLOjFeOOIwTJHleoygxUHLavB+iAzyBcyYlvvBeNtTdsIg28ybT9f9BCQJp9MCuMBXCpdRQH06c6tLWu1h5IOXUYfaCYp4XHAcCkvimI++K3snPJoAqG43OElORoJceXUMuDk1JdO674brP/G71cpmrQ2AZRcmOvUa1183PiBOwki1nRMD1eUN9oAwoBr70EHLw6nhEbAam6V1zfwFQJbP3yYpIkjWF4rHQ1pweAQWScjJv9DY5hAvK+Re8ZoDvdGuO6t2iViIq7kQX54raLhX+yamiNceaxj7jpIVUFXYwcQ6hTsGdLjgjyE4noC2dSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH+wYgrS/RTSppqTbrybFERCcA5tPvuwRgXdv3T2wng=;
 b=QYJWVvMpZ9YF0X6nGsDHdy3K1nba0VgHShOCjX6kk6+o6UsqtWbURhCJ6exrk6wLq6TZ7WLhWqSvWKKOPPa5UC25mj76bmpi3UulJbm8TwSR9fSVJ+X2HK441ElAFVNtKFN4KTypZgeg8ik/AnJyMzvVRtYRvNs2HmRJ5MStnL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 12 Apr
 2024 16:49:23 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 16:49:23 +0000
Content-Type: multipart/alternative;
 boundary="------------abvcYj0tNDViwrtwHwdlgnin"
Message-ID: <69a8b47b-227d-4c35-96cd-13d4576b7aa2@amd.com>
Date: Fri, 12 Apr 2024 22:19:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add support of gfx10 register dump
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240412140034.65565-1-sunil.khatri@amd.com>
 <20240412140034.65565-2-sunil.khatri@amd.com>
 <CADnq5_OY3Kkad2JQz99qRVX3Xh4tk4CBvGPC2FYu4RmQ9yXORg@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_OY3Kkad2JQz99qRVX3Xh4tk4CBvGPC2FYu4RmQ9yXORg@mail.gmail.com>
X-ClientProxiedBy: PN3PEPF00000186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4c) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfa9f9b-0ec1-41da-1396-08dc5b10813f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: it7k1vwoT3OVborbv3VReKWIIQGugf0Q/n1VD6JPHixBfa0DfzUeW8RBYuIpvDYklYhPQPBojYKXVnMSZNS5B/atfWa2RjP/8WvrADuD8lEE4F76QTe0ZdnAB4hDhHxICVQMRGQ/Kz71rXGxHyJalQ8zkmLq9RXW+BuxgiFNb/ae9MWo8a9oP+VM5f6eo9bD6fF0H52RxiDtQZm4rEpC+3Cmf2yENBAS0UKZdMiTPnV4+wRRc8gp1Jm+T/KMnQbTWBcdQ8j0CzfxZ+VD4W+0PJHiZMtV0tMvbFW0R1R0hvOSzejWsZttqNgbLmkQdfuCArT3kHCrGTTUYU7BVBuXyif962Zi7kA5UT8mNMBZhaPLhqCNNVKuqiPSm4AtZCiBmKituRraUpK0U24Fs4jfBsFllKoIo+J1W/EdCJQWVtVIN4h42t1lUhnnUZAI4CY+bcJkIICDV/KUl3ssJZ9jxJI2De9X80G/eS3p/cotPHCysDuvBot0rzeFuMti5ILI7haeXI3PfatY7fWJ2rUjZ9m2dZK2YCWNaRcBjIAzsuSNsYrRb/z1rumG0TYHJxaiy4MU5vPGM6+rcWGqEEo3arimXJuHUePEGcyc+gcQDu/AtqNh+yHjmQaV3e4x7rWgTwgNDA8cGT779wLGWs6i7Ho8QR1ozfwXTWLdoqs8ndE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZ1TGZPMXhPVk1mbHdZcktCbi9UTi9yT2JpTmc4eHU2cjA1T2RhRWNQdEw3?=
 =?utf-8?B?ck16Z2lsbkRoU2taNC9Ya2cvUWZKdHNRVy9wUy9FQldSeG5YWHh1dDVPUHdW?=
 =?utf-8?B?SUR4L0ppa0I1bkpsMGJHTG16Um5mQ0FKNVFCeE1zWGZoWmFZWGduSndpcGZE?=
 =?utf-8?B?RmlVTnhrWkJxKy9ENW5mem1UM0VsRkNUekRJQjBqaWx6RmxwV3lCeXVMRWZr?=
 =?utf-8?B?RzFBU0tjbHhheTJaYndwbTUxQUhKTWRsUU1nSGFNQ2c3aXd3NFMyM2tiRlZp?=
 =?utf-8?B?dkJHdmg0cVBLREJnWTI2MmdwN3l4K2Jydmgzc3V2aFRrTUdhMXQ5QXFsUW9E?=
 =?utf-8?B?Q09lNlAxTTJpNXVROWhCRG1lREpFdW0wNEVlMUFXSldPMWJMNStiaVlEd2RB?=
 =?utf-8?B?YVMrWklmRVUwWDdLNXk3dFRkQUZ0eHRZNno5Q0dSckhjb2lQbkF1dkJjcVpB?=
 =?utf-8?B?M2wwU2ZsUjJSSUxsSkh3ZjVXSXdpTlJNeXF0MWZ4UkJZNlc3aERuMnN1SXM3?=
 =?utf-8?B?M1YrUUtBcGg4UldzT1VBUThiaU1udFJtS2tVdGpKY2pRb2JYVVlzNm9nYTFj?=
 =?utf-8?B?SlhUUzhVL3N4NVlzcWxLMmN6S0hGRDRxZCtjbHZ1T1lxMnc0c1Q0NnI5VEM5?=
 =?utf-8?B?V1h3MVgwWGdKd2MvSWw4Mm1IcDJSZTVURlY2ZG1TUWJXbWJyb2IwUGNEV1pl?=
 =?utf-8?B?cVJhNVRrTmdwS3hlb1JlY00zc3VuMThtVk9YR1I0ZjJjZHZLcEpyS1pMVVpv?=
 =?utf-8?B?a2xvYkcwQUZmQUk1LzNjNjhNTVpkM003R2o2UHF2ckpBbC8wR3VhWlliUUhj?=
 =?utf-8?B?ZHZSVmhJRkZCeloxbk9JLzhVa1hkUDZmUzhpVEhncEgyOVpaa2tGcHNuUVJi?=
 =?utf-8?B?ZVUzdnNkdjB0TkZDT2tIT0tuOVRRZTRxQ0oyK2l6SmNTL3VwcXJBbEhVN29Q?=
 =?utf-8?B?SEtmK2lGbm02SUtKdkdqeURlbTVhOXlmeWJKbFc0K092TDBYczlmUFZzcTNm?=
 =?utf-8?B?TUc2OTBkVnJpbVVBRURrcFQ2eFFsQlJKdXBqanllWEM4REZTdU1MNUlYOHNQ?=
 =?utf-8?B?QVZ4akFLYWM4U1pEclB6QjFvYW9WTFVNaGJGY1h5RHRnR0Jsa3hsSFFEOGlz?=
 =?utf-8?B?d3R0NXRSRGxMZjBwNGxTQmpZemNRbUp0U3RiU0lXSzBuWHAxdEVvSXg0cDFv?=
 =?utf-8?B?aFl2MmxLMUt5Ym05SHRNai9jNDNBNFpnRytrVUJ1RzB4d0V2T29GanV4Qmlx?=
 =?utf-8?B?UDBScWY0NE9Nd0QvK2RKOXVZU1V3K2R3eGZVeTJKVkNjMHh1dTVHZzZoK2JB?=
 =?utf-8?B?Zld3K3lZeWhPNVl6ZkNINzBKamFMa2UrVWsrby92KzF6WHdhWUt0SHpyWmt6?=
 =?utf-8?B?UXFXT1VFVm8rUklxVG1LdjFJNFpPTkptd1dxQXF0aVJJSE5NOElMRVJESTY4?=
 =?utf-8?B?Ujh6WEozT21jR3ZCZHNrSVBRSk5BdlJzYkdUTmlCdWQxVnRGd2tOeVp0d3k5?=
 =?utf-8?B?L3h1Z3hSVEFyNkpwV0FUNnJSRXNYMGRzWng3b0RpdjlaaWxRV3VpRndSbEwx?=
 =?utf-8?B?TE1Yd3RkSkUwZWNPZ3VkSmdvNUMrbVFkZ3g5RUxvTDJ0QzBOZERuWkJNa09q?=
 =?utf-8?B?cGI0TjhFYlI2aVRLNnRBdFUvQ0lPbGFVR3NUZmRDVGFWeEkrYitwUEk1Nlk1?=
 =?utf-8?B?SzM3SFlQK3BzQk9GQlRsQ1ZzNWlNMlVFM2ZkZnl6aUxla0ZMVW51Q2tDZENM?=
 =?utf-8?B?ZVg4a3N3WHpVcUVWcGFUZUZzLzhtdGhjaEI5bW54N2N5SGEvdWhkSFZ0MXN5?=
 =?utf-8?B?N2VKMjk3bEUvS2NJQXVKZHUwcC93V3FrcGpxY1hHSXpxNFJXem93WFMrbmtj?=
 =?utf-8?B?Zks0LzRFVUx5b1RnT0cwZUFHL3FoODV0NmVzOVRPc2sxY2t2Y29ZamJuT1dG?=
 =?utf-8?B?cW5mcnZEd3FKaTRIcE13cVZIeEN6L1kyaWxYUis4VTF2eGlMaGVoNjZiWXl6?=
 =?utf-8?B?VjUzeTNleTh0OWhkdFhHUUtIZDErUUhpWkI1d1dnUFl5UkhiQUZEMk1DTmlS?=
 =?utf-8?B?ZktUbHF5akRGQWRtOWVwQW5XYjZvZDhyYTRjVkQ2Z0I3clFHMmU5a3BMWDF3?=
 =?utf-8?Q?vEp4j2z8aYE54wjSpPrGI12jR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfa9f9b-0ec1-41da-1396-08dc5b10813f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 16:49:22.9237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0aAUt41xGTY8/lrAPHc3uKlpgIs6gCIgAy2VvI5X0SWbvdVQM3JaJJjLDcRfWhJDnal7RLZE4TtWdoBLNswDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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

--------------abvcYj0tNDViwrtwHwdlgnin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/12/2024 8:50 PM, Alex Deucher wrote:
> I would split this into two patches, one to add the core
> infrastructure in devcoredump and one to add gfx10 support.  The core
> support could be squashed into patch 1 as well.


Sure would push the v3 with the changes.

Regards

Sunil

--------------abvcYj0tNDViwrtwHwdlgnin
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/12/2024 8:50 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_OY3Kkad2JQz99qRVX3Xh4tk4CBvGPC2FYu4RmQ9yXORg@mail.gmail.com">
      <pre>I would split this into two patches, one to add the core
infrastructure in devcoredump and one to add gfx10 support.  The core
support could be squashed into patch 1 as well.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Sure would push the v3 with the changes.</p>
    <p>Regards</p>
    <p>Sunil<br>
    </p>
  </body>
</html>

--------------abvcYj0tNDViwrtwHwdlgnin--
