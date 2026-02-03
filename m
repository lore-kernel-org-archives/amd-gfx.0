Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EE6E87834
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 14:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B76E10E68D;
	Tue,  3 Feb 2026 14:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TJtR9vHd";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0417810E30A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 14:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSFacDoYA9M7XmN3E311pfzXMbbZxikL77zPHD+K6ge+MMz9vwh1UF1dg+9qSD+fILQZ3NTUBXHs4heOvEbGY/yo6P19wgbsLn558Uya1cXzS2gVm07BlBMtZ9OB0gWd6UEXmy8+54AwHLjtXuUeyhv2uZvTgfZwjBXw3Ef7mePsLiW5MTbh8Cx7Q9FrON8Gi4b6agF79C/hihV2OPG7rv3xk33I33KZSat/R/XPbaPWalf1LQwt4Qb8GDx7pCC+XidFxS9wNB05O3ddy8M/6tOTBz/+xpOopKCqQMYZHG4duqIvikHsfTNWorEz6Jk1aCAdkTAlRst9+DQYTEXFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDYFHPtnWqlMJPcZTQG2EEc3xowfW7sr72WGLNrQtTI=;
 b=SVJRgaZ/zWPS/bQ7KX31Lu5Bp8Cn82CbkCYiGsllj30dv6WLnkBo5AxpQXW8e+fKdx4W6w0ENfNFr9xnqK/cbaQLDHJrGiCTPA2IKKjG4jeYf43R75EveBi/FiLRU1LhTIGtLYOUsi66V69171y/xgb+yEoWD+TQ1vzkKiYFg/W0qjTfeMM2I0e/CEP5VqQknAEHXzl4KQ6aVg6TuPkE+pE7liXF/ky8lm2cUjf9qCOZi0dvWeUGgi01BBq8FMRuikBNZ7D11bC/DkK+v66XHx2+74Kjj3yu6Fja5dkH6D0A6gpdqY7Rs2W4EIwXb7nDj2x0+yJd7yIbadIWoV74HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDYFHPtnWqlMJPcZTQG2EEc3xowfW7sr72WGLNrQtTI=;
 b=TJtR9vHdCOjTpYDdyG/SgVbJgspoUioyi2WEIpwvI/ki2dVza+FrPb5QnWUSHAW4cmRSILsGJnHQ4ETD+Kj0wy8DiNVCfeaWtg8nUrgwLSg1U0P5v2tlNzn3JvWEaWYQhDr9dxGdM5algK4d7YHjvtYvcBRvTHFzWc0zj7qROVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 14:36:09 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 14:36:09 +0000
Message-ID: <8cadf7ed-a464-4c09-a50c-7f3ae733dac0@amd.com>
Date: Tue, 3 Feb 2026 20:06:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/sdma6: enable per queue resets on more ASICs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260202202850.992745-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260202202850.992745-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0216.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 418e0317-f023-4355-706f-08de63319241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXNRcFZHQ3ZhcTZTMVFSVnFhTXlLUzRDekN0YU5zci9rVkV2clRxZ2hVWTBw?=
 =?utf-8?B?QU5UY3NIZ1RRKzJUQ1hlZ3c4cnl6TGpBMmhEWDdPNUwxMEdBU3FLYUdhNFpD?=
 =?utf-8?B?dHlCMUV3NGh5OVRxU0thMi9rVEZTcDZQaXB3MDRyUmd2MkpmSk5oZFp4OTVY?=
 =?utf-8?B?b0JPblJ6NHFpODFpMGpoMVl5dkx3Si9yQ0pVWVNZbzd2bC9QVkx6UkVjaktS?=
 =?utf-8?B?UjlKRWREZVRNNzhCTnliUURmc2NEYlpkY3dmOFBuWFk0bXJHWUM2L3NoUVJx?=
 =?utf-8?B?T0sxWms2N1NLNm9uYXJQaldSOFhGQ1JSNTdib1NxbWZ0UE0yZ0kyem1HS1pz?=
 =?utf-8?B?bXRpRlgvMFhUNnF5a0dqYitudU94SndNbzBGS055b3dWWGVxRlVqd2pIYUNX?=
 =?utf-8?B?YVdPRVhEUlZ4dURBYkdhNzJBcnRhSFR1MStsT2tESlgwckV1QnJtTll2WGtu?=
 =?utf-8?B?eTFlNW1nU1ZncERiZ2VOcWFCazN2S0prZnNpU2lvVmtwZEdmaXJkWnBrUFJO?=
 =?utf-8?B?UlduRnlzbW5GaTRDbnF4d1dEaitHc3NiR0xRM0t5Sm1JeG03aDVuSy9pTUk5?=
 =?utf-8?B?RGUwRVVpZVJ4TkpGZWxSR0dDM0hQSlM2UGxQN3ZpZWljQkQrSHc4YUpTUjZF?=
 =?utf-8?B?WkR0S0J3Y3F6NEk2MElmaHAyMlFoaVBuR2lVWjYwTkhWUXZsVXFQemhvS3Vt?=
 =?utf-8?B?dlRyRkdRWDhVL1ZEYXA4aDRVR3dFU3pWYjRFekowUjdwWUFiSzdPRjc5UmZK?=
 =?utf-8?B?SmZwL1lTSGY5N256MUV2N3kzaGx1djNzakRLcGdkWmVGVmhtOWFrczRvbWcw?=
 =?utf-8?B?Z2lmRGN0MGlCTVRZWXNXVThiYXVQenhmQklFSWVmSWJXeEF1SHdqQ0ovd3pE?=
 =?utf-8?B?WHlKayszV2IyZDl1aThMNm12R1B4SFZRb3U1N0xtN0VmdEJKZ29OVzRycEho?=
 =?utf-8?B?RUJWTDFYSEUwZmwvWDdkM04rcHpYakc4UGdMT2tBbW5sVk56NUJsTzBTbXk2?=
 =?utf-8?B?TmRJd0N1ZG44UG9vaEpwb3pSNjF2cklVTDZOWDlDWm8yZGNEMUdkY25DUXR4?=
 =?utf-8?B?a2hGL0dDZHRDeHFsc1g2cHhXem1GMXdkdnVQQ1FjN1B4TzBubEx0RHl0MVVq?=
 =?utf-8?B?c3FuSmh1eCtLWWVvd055UzlrNEMxeDRTTlNuZlBkL3Awc09GZ0d5aUF2bnU4?=
 =?utf-8?B?eFJTek05YVVOemlDSzhURDBEcHBIRXRmSG5JNWZxM3lQV3N3WGRjTUNUL3B3?=
 =?utf-8?B?VzB3NU44U2d0c2RLV08xQWFObm9yWGdLMnpyUlFYYlNSZFZhRXNPQitXWXZN?=
 =?utf-8?B?OXhqTGJrM01USWZlZThvdlFyNkFQTS8zMFZ0b3pTQTJFcDhMYnRpL2ExdW5Q?=
 =?utf-8?B?QytLV2h6Z0c3Z1RyVjl6aDVTazlYWlU5ejhSai9oMUtEN0xRbFV0aFc4YXhT?=
 =?utf-8?B?SFFQaDJJSmZwbGZsVjZtYVZ6ZDc5VXBZUTQrYzUrdE1JWDNpWitDU3hBd3FF?=
 =?utf-8?B?TDVDMlU0U1NkUEhPZzNxUVBxT3QxQllia2tkTDNGUnhYTnpudERvNzJQbnk4?=
 =?utf-8?B?WVNJeEZmL3FLWVUrTkovbEY5bVJmOTNjeTZhU08yTHFCTTAxRFMrK1Jsdm5Z?=
 =?utf-8?B?NXZuVnNlUlM4dkIzY2JRTmFBRjRVMkpHaTBYSW5UMlF6akppWXBXbzR0VmRj?=
 =?utf-8?B?Nnl1elIrdjhuLzhpaUVub3pucTlqZGl1am1sc3BBd0VoMEFMaDhXYzRWK281?=
 =?utf-8?B?aHRycXZySVhNNXNYWVR0WG55KytpbURKdnZuUHJqTmlnNlJKTEVMVHFaYjd1?=
 =?utf-8?B?YWJDd1VoWkEyblN3ZHdEZHlscjNuZlR2QzdlUTJvVUJzYzl3RkNTYmtWKzhu?=
 =?utf-8?B?MlJ3WkpHWW45U0dWNjRGdDFscWNkbllFTW1Sb3ErMFowcnRDbE1lbHpra3ls?=
 =?utf-8?B?bG5xa0Iwc3NTZDBvTk13MEpJN1BWOUVTTnAxczFYQmUvZ2xIbzBKWHpKaFJp?=
 =?utf-8?B?SFdBOCtRNVJQTklnejFWUklhcVZyajVjaFo1QVNTbkdTK0Z2enNXTkkxT1RO?=
 =?utf-8?B?WkdaNldUOEdIbVZEZXFucG1Ib1ZPbGRldnA1RVgxMnhVOG80UFNoS09ydEcv?=
 =?utf-8?Q?KzWw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTBsVWpmVHczNXFoM2hBWXVWVFBUQ3hBK0lnQXcxcjBMZmMwazNvUzRCbm02?=
 =?utf-8?B?M0NkYzc3bXlvcDc4dXB4dHVEUXdXdFQzb2F3M3NJWEZuZDlHb0FBUXdNbDhV?=
 =?utf-8?B?NldlRm11KzV4N3RBdXJiRWppaVVJT29EWkVsM01mZkF4a2EyVnh5M1hHZzdH?=
 =?utf-8?B?cGgvZDhTZnY4VnpWcEs3NUNPRGZGeExHVHpJaUk4M1E4L01jYndnazZLZjRz?=
 =?utf-8?B?NmxzRTlyaE8yVENwTkl0TGpTY2tvdjUxTlFiNS9mNU5iVDQybjAxWjBWT2U2?=
 =?utf-8?B?L3FwbndRRHZ0V0hTR1VaK2lNdlVwUy85TUR1VlJEdHBESW8xV0gzRndxZDVX?=
 =?utf-8?B?YmJVc3kyajZiRGp5azdxRzcrMW1KSkErRUk5ZFhLMzNybTRFbzZQcXlLbVJB?=
 =?utf-8?B?alE2L0drZzdheDFoVUp4TmhXTWU1c1NXS0E2cERTR1NqYzYwc1E2MVNKcDAx?=
 =?utf-8?B?bVVjUUphQ001dHB0SGdhVzJmczlHWWh3Rk4zbjdMUm5uWVR6SDlhOUYwNnEz?=
 =?utf-8?B?QlBoelhXQjVia2hlQjZEYVhhd2VYcDlpUmJQakpqMzhuTDlpb0VaZk1PSCtE?=
 =?utf-8?B?Y2ZWWUt4aVV6cFFKWXVtTXhWRGhobFdyQUFNSkVWSHVrSkREUmUxakhTcUpl?=
 =?utf-8?B?RHlBRVBMQXhvRkpMbGxDNHdYUTlZeHdFWDRvZExYWFJHY3FDbXlvUWQrVUdT?=
 =?utf-8?B?aTFuL2MzNlNRUVByTWdxTlN2U1Qra2hNUTBTaTN2OE1xT3J6Wm1XNGgwcVpr?=
 =?utf-8?B?cXUvb3p1SkY1MXMvUDNQYWsyRFQwbXUxUHF3akNvWmUyTHpzZE5BbldiZnFL?=
 =?utf-8?B?c1R4SGRQc29HZmp5RmJkUFdsRnQ3aUxpZG1XSklCMmlEdHM4N3Fxc0VDUENB?=
 =?utf-8?B?YTd4VkxHNjVPMXFmaG9kYzFPd2hPc3pUZWcyMEZyVG9RNVZDclpTZ2VmVy92?=
 =?utf-8?B?Mm55YWFVTDNGU2ZtNjNpeFVWaUVyQVUvSWRaYWtraXhPb2hMWGRQVHRvZ1Ev?=
 =?utf-8?B?WmFGbUtEalJOcUpUYjJrcXNpU2lUc1Ryck1xZmNNVXBBUGZ1L1dtRnRkYTFO?=
 =?utf-8?B?cTFNVlBNWXlLSUpua1ZJbExQSVNaV1I0K0dSUkV1Y0hFMGViaVUxY2h6MFpk?=
 =?utf-8?B?U0M5dURURTRkZmhFYi82aExpNC9BN3U5TFhwaEEwNjRpZE1DUlhGUjVwbW1U?=
 =?utf-8?B?TzZnYXJ5MldVR0p1RXU0bEt6NHZpdmJZYitTaE9COTVkNW41dG5aQkYyd0Yr?=
 =?utf-8?B?enFBalp3OUdXUDRqdGdKdzdINHdML0hwL3JnQy9jWlFSYkRrR1g1cUtpNlNu?=
 =?utf-8?B?ZXgyQjdnR0tHWSt0REN6TFNrd1dyRVNJamR6Q3ZheHMrMXI3SkgwOW1kbmIr?=
 =?utf-8?B?WDhWN01FcEVsUlRhSDRhS0dSdmlYdExkcVZkZ1Zndnk3dHR1eTlTMDVVVktU?=
 =?utf-8?B?TTBMRzBBWUVyVnVacjAyNEhBY0ZZQmdoNkpTT2tBTEpJdVFFYzl2TzhUWDJ3?=
 =?utf-8?B?MUx0T1MyWktYRCtpZUg4elY3QW83ZHhmYVBkSm1nT3c1clk3NWxDMExscnhv?=
 =?utf-8?B?Y24vUUI4Sm5xTGVTU1M0TjErSDJnT0VGa2krTElGMVRVSGpIL0Y3K2JaYzBz?=
 =?utf-8?B?YUF1UlhVYStIVmo4RkROVDIyVjhtT2kxTnJSdTQwd0dvWEt6VlZkVTA5ZUE4?=
 =?utf-8?B?bkhLMGlXeGtBVURUbE8zUU5EVWN5dThKci9XT0dnV0xzekd2eWt2czh3U0ZV?=
 =?utf-8?B?UXY0UkJNTXovRk5KOGIva3NDcmxHR2NtVnB5VC9xUzZ4Wnlsc1MzVHlUM0N0?=
 =?utf-8?B?WDFxaXFjZFVsZEE5U2pKZ21TUitHK3ljS2crY0tYeFJwQm8wTHFBVUNhT3Zo?=
 =?utf-8?B?TjJqZEhiYjRmTWtaZ3ZHVTVVS244aXZwVk9kamFGRU92R0tWcUpCQlBLZzJT?=
 =?utf-8?B?NXl1UE41cnY2b28xcEg3UVlQNkU4V0FtV1puMzlvQ3EzTVd6R1RvaHI0SGpH?=
 =?utf-8?B?Qy9PSnJLb2JCQWxQS1AzNWtLR3dra1Byc0FqYlB3bTJqMG5FRGNnR3ZITlNh?=
 =?utf-8?B?bE5UNnlJOU1KWjh2bUV5YWIwYVZjZWlKQzdFRTV0SFlhbndyYmlxTEJnNk1p?=
 =?utf-8?B?ZWZQcWdXb2RuekV4THBLczlXdlFBUHh2RzhtTEZYR0JDYmJGemxTaGlxaHNS?=
 =?utf-8?B?eE96VzJjand4OGcvMHlVMld4TWVqZjJyOFdGTWw2U2R0MGZ6ZGpXeHhvbG5y?=
 =?utf-8?B?UnAzcjk2TXhuY0hpaXhJMnQ0K2pNM21FR096dmp4cER2NjJ1UDB4VVFZbWhT?=
 =?utf-8?B?ZnlhSG5zLzVrbEtTSFVZSGxyY1JKYnlPbzI4bG9aM3ZOSzYrZ1E4UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418e0317-f023-4355-706f-08de63319241
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:36:09.6737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKFMshO+OVqjQPKTenZOzeSN+6NzP7TNN1eu9bsBxsKe7kUHARHE3LLX/GvL/WTb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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



On 03-Feb-26 1:58 AM, Alex Deucher wrote:
> Enable on the other SDMA 6.x ASICs.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 35e00ebba0300..6f4704c1b3a10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1380,6 +1380,9 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>   			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   		break;
>   	default:
> +		if (!amdgpu_sriov_vf(adev) &&
> +		    !adev->debug_disable_gpu_ring_reset)

No FW version check required? Also, better to fork this out to a small 
function instead of repeating this in every case.

Thanks,
Lijo

> +			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   		break;
>   	}
>   

