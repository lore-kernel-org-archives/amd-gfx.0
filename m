Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B2BD2D0FD
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 13:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C756D10E33B;
	Tue, 13 Jan 2026 13:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uHcyniMY";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D90410E2A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAJ1ZqYxXTHGxz4vpJZ92UyxZcmQTwTcwPPJf2fGezM8m/yXYPptl0u6QJLfJkT7uokqCxT5fwlk+R611VNoUt3k8m4cjHfUyQfB6ibtXgqfwTekq6lLnyNLW6H6LWfPeSSpLV1ezRDxrhFAVjLVGH5mBYAbZXxECv7gBYkfvYbCvFOK5pfh2yRORvQ60ftX+1/D5EwrRZrRAEHtPL0zLJUr1CX/4JevE5WTEzcAH19jno5EMOtkcLdERmUSHEnrp8gGCfLUbnMjRQ7diZ3xJbtGmlt7Lk2ZCcrpYCiU5Es98aee/XMhERI2SWbdI4osjuIF9h7PXeSpkeIOSjxoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yU21YRMfmcrNPKF8/VnmMYE1blaxsyND2looLMZts1I=;
 b=a3Ph5VYWC0+knB5YwEENFnfV7jS0tf+ev3CdcsEXA5cPf8mbF+I38IMBRXBl10NUJQPUZoLXGe32QzYXWWlwPIDDFzQ29IzJM/kSAlAQRqfXlOgWTyY27uCii7uqbZb12uMdwAJBdLX1SqTB74qGne9aBf9JOoWUkp1eBX9i3EmZXtOJ9xmGm1jhadv9Tlo4dwRRyfe7LLhtfRhA0qz6BhDMKLP8u4kkP+htjQI0lKpUdBWQs2fVQhe5xOv8II7sUBhDa9Hm0plSxxImd8mEoHqTngWoJUdIexmC1e4c9WBtJ7X7QJ+0yk90AjUznVfkV/ju9u83rAMNJFeUMD0YQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yU21YRMfmcrNPKF8/VnmMYE1blaxsyND2looLMZts1I=;
 b=uHcyniMYj+rGuF0S87n3QRY1Zd06qQ5/L2JzuH8UCyXH6pSItW61jjQYgtTpMBJMBGNocG1I7D0QO7wE4CqlyKQGWBnvz5A+84xnN0T9qARh1mJZXiJT1JdNTKn4DlcoBfOLPw+Wc9pyBTuqqvFLfgsv5Amh1ieZ5Hqd9exs1I0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 13:31:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 13:31:37 +0000
Message-ID: <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
Date: Tue, 13 Jan 2026 14:31:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/42] Improvements for IB handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260108144843.493816-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc75a40-b189-4dc3-eaf9-08de52a813f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnYwWEo3eXRNUkcxU1IxOEpwQUtCSjhsa3RLSm5kU2VDN1FnYWVNUU9VLzB2?=
 =?utf-8?B?WmNjZGdjN04yZ1lyTGJIYVQ4OHdvNzh0ZFcyYU91ZHVORUFaQ21JemxPSHpx?=
 =?utf-8?B?aVhQN2IxblJ6Zk1WWVF3WldJTXJHVXVJSWxVK2lhU2FlWDlKZ1NXa3V1U3Jo?=
 =?utf-8?B?V1pOeXBwSWJvZVl4V1VYbW42U0dqbnhTNzFBL3lzeXE2cHpuMjYwUnpGcndh?=
 =?utf-8?B?ZVNOSTVhbGZNS0tGYjhnZ2dGVHhaa0tFNFBSR2tCbnhJNmkwbUhNNjIxYmpX?=
 =?utf-8?B?aVJXMkZjQkJsMk5tenhXeVRzWm9KQnoxVXhXRUEyYnBmQ2IrbFRvaXJtd05p?=
 =?utf-8?B?c1BrdjBIUk1nM2U3a1VyWGx2WlptZXZtQ0VpNlZYNXdUbittcnJSZ1BOZktp?=
 =?utf-8?B?dHNYU1JMZ1ZvL3drU1luWnNGbXRCem85Nm5VRHM4QVVQVjJ3emo0NVpOZkU2?=
 =?utf-8?B?ZEN3STVYZUpzYzY1UWZ0RjFSR2U4TXFMYWJxUTZqRlc1dHVWNzE4clVmTTZM?=
 =?utf-8?B?WlVxcTQ5ZGRlMno5b3RtelIyUHV3WWZhTTVXbGh4Q2xaZW1HczZDeEZpd3VZ?=
 =?utf-8?B?L2NGVjBNMWhGT1hkYUZZVE9Sd2FyN2N3K1IvZDIyUExYUXNrbWVjRlB5ZVRj?=
 =?utf-8?B?eTFMYmp3VnM4VGcxV2NzNy9Oa1RMbGxDUDdTTEYzbU1JRGh3UkhzVWlEZDhG?=
 =?utf-8?B?a09tZXZTRjNBeFJ1SFZEdEJZMTNLb0oydDJUMEpRb0lsc3B0K2QrZ2hxbmk5?=
 =?utf-8?B?a0Z1TkxCRDlENEpqZGVyWTFJVWtPdHBvdnVOYWRJeWhjdTI4RktDZERjZ2or?=
 =?utf-8?B?Z0hyQTYvdU54dFcyeGtBbXhVVGluOXdjaVpJOFg0WjNEWlkrbTRnVmd0K1VX?=
 =?utf-8?B?bEE2TmRJOGxOTDBnbUFyN0NMNlhjTGJDak5STW1Ja25adE0wZ29OcklxUUJH?=
 =?utf-8?B?dGsvVTZLU2VaM3kxL0Y4UHNCTEpwczdnbEs4aEZpU3ZDVTczTkQydndEZE5r?=
 =?utf-8?B?OGZSeXlxQ1pXd3R4OENEN2VJZnZHUS9TSkp3NGZnZkFnaDc3WmxnWHdHSXdQ?=
 =?utf-8?B?bmt0TVovWlZFeTduR2JDWUs3TDV3S1RQbVFWc0dCWnY0VWhQL1RMZGVlZzNN?=
 =?utf-8?B?ZU14YkNPMHJQYnJJbXl2QkpuMWZveGR1THY1WlZFRWFyWDk2R3R0NjNic0VK?=
 =?utf-8?B?aFduNXpSalFaZXc3VjFzUE9OZ0Mvck9qbFNJK0JkeWtPZDB1ZENjNS9hYnlr?=
 =?utf-8?B?UTg2cjY3QnZDczlCUFAzUU1pVVQrODczOFlzVnZ1RU5WaUtuTFFYOGpyQ25Y?=
 =?utf-8?B?akd5QitkZjB2aUgrRURWVFk3ZVpBL1NzMHRLNjF6SDVMQXE4QWZzQkl1WkFD?=
 =?utf-8?B?cU9CRTVsbUx2Z2ZSL3Y1K0VwZjlPMVZ4RFVpZEx6ZzRwRnFDRGduVVNpMEk4?=
 =?utf-8?B?KzhyL2FQSnA1ejRvRktZTHRyNHRURVhLSFZQMmxKQ0xzWmMvZDVMVE5pRlpa?=
 =?utf-8?B?a1FUSXV0MUs5THZFY0JoMXlyV0VvSjlNY1ZtOVFYZUp3akpjRWVJMTVQNFVv?=
 =?utf-8?B?YVQ2Q25RRUJtb0tCbTY0M3drZ2tJdzBhcTBRTVBQb25kV1JTbkFFS3ZBcWgx?=
 =?utf-8?B?S3RzUndVRk8rdlJ6SlM0WEpvT3c4OURnS2dEbE1hdndicCtWTTl5NlIvMnYv?=
 =?utf-8?B?UWZ1cTdxS1c3STlUam1yL1JVOWRkZERjb0s0Y0JmSE9ZZW5vMjAvakVHRFlw?=
 =?utf-8?B?WmoxODFHaEcya2pwdkhKZ1B0elgvYzVaaTlzWVNYcllvU2ZXMGVjaXBGRkU1?=
 =?utf-8?B?WjIrM2xkdUtyMkFjUSs1MlJXVGtLY3QxaU9xaVFlbTlPcStCZUx1VzBrZWl6?=
 =?utf-8?B?ZHYzY3NXcWtsSGZPRkJwTE5ydlBmZDNLeFF2c2V1SkhNR3V3Z3lkdnFSanlV?=
 =?utf-8?Q?8GdgP4amEe143j8H3EnREmWpzuLO7KZ+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJUOFc4UFdKK0NCNS9kSTNJR1Q4WjM0M096SUl0S0J4WnVPeVVkdzdLUFpF?=
 =?utf-8?B?eDA5bFQ5STVLeGo5RmlicEREbUJjVXRqb0YybVMrZGl6VEFFNldLb0NoMmZm?=
 =?utf-8?B?ZjJoMGc1emJ5TG95VkcxeC9VZUZqQWhjUHk0Wm5vbERDcGgrWDlVOG02Vldu?=
 =?utf-8?B?S3p3NElvbVdMOWVjZEVveWphWVJTZVh4cWh0SG8reXh2R2hxMjRZT1k1STRn?=
 =?utf-8?B?WkJ6K3RqMHNoOVBObmt4TlJ6MnBPcWNxVkoxZ2dmZmxtZHQ1YTZCeDFHdWNv?=
 =?utf-8?B?NFFwdHNoYXNtYTJrSHlQd2wyaFBiaVArQVgrbVVRSlRvWjNZT2FZalg0Y3kz?=
 =?utf-8?B?NFBLNGZYb2Mxa0ZKa0gycGJFL3o1OEFOVjY2UFhiVks0UWlqeU1yWHV5UkFp?=
 =?utf-8?B?dDdkOEE1dU1QWGZTYWZxMkFaK2VxRzhGZHZMeFdoT25WdXByTlZpNFAwckpJ?=
 =?utf-8?B?aC93NHBLV2I0cEgvRTFiYnN3b1RYTGttbHMzQ0czNkpja1NEd0VsOG90dHJP?=
 =?utf-8?B?TUVVYktPR0RSdUdlZkdiZi9aQnN5VnRPUVoweDBPWkl0V2g2MW44YmpMeWFH?=
 =?utf-8?B?NjRMNVJXN3pUQ3RNMk1rbURZS09nV2wwS0pncVBUbVhFTW1OSUVNa0RUdWdI?=
 =?utf-8?B?aVdKUnkySHNtdzJnd21JVVltdzZLb2VzSUVKYzdPQTFXS3YzcjBSMjFkOTY2?=
 =?utf-8?B?czJMcjUyQzdoK0YrZkc1bFppa2V2QnBpN24zcEVDTkZwYThYZHFQWW1CTlBw?=
 =?utf-8?B?bGNCTW5aTEk1QVFKTWJyWHllRGtDMHpsYlA3cG0rN1ZxOGlqOTlTTVBuTEhD?=
 =?utf-8?B?L25IcDdlRVR0L2gzZFZUdm8zMVd2bnRVd3QyelZYdzBEQjRnTnJrcjV4SjJw?=
 =?utf-8?B?alB3Q2JFMDFTdmRwT1RXQUlGdWNqUEsyY3lVMmFHU0NIZGlyTU13a01vV0xi?=
 =?utf-8?B?TmtYZVFLRTZjTjR3b0ZtdERydmYySW1HTHpSQkZzRERmVHo2aXNSS04xN2JL?=
 =?utf-8?B?NDVhUzRNYkVwM01UVFBZRjJpQWR3QmNwVmxmUURZQkordVV1NDd0YmN6RXJO?=
 =?utf-8?B?eFFPeVVJdExSQStwdjdsSzhUaGM4RVRvQ1loeGNVZHh4VUdVTUdCUi9XdHlw?=
 =?utf-8?B?RFE4R2FWMkVEcXF1YmIvdmt5MVlPQXF3dEEvZFFJVHdlSzI4Nk5oekxlem0w?=
 =?utf-8?B?VVNGdnpETXZnbWxURWpoQU9aQkozMHYyOHJjTGJwc3E4aDIvSmI0RHFzUjBZ?=
 =?utf-8?B?cGhQTkJZSFJQbnlTK2VDenJFQmJGNnZjL25VRC9RUnExOUd5YnZiclZ3b2Zo?=
 =?utf-8?B?aS9tMm5VbjFVUmhBaVlBUTROYzBCZEdsT3h1RVVSQXJzVjJnMHJsUld4czNX?=
 =?utf-8?B?ZXVmeWt3YTlQS0ZkZE5aUjdJTjE5L0c1K2ZUK2J5bERITE5JbVpJWU02QVA1?=
 =?utf-8?B?RUxTQmQ3dWhYREkzbmVjNWVNV1ZlbzhYbTNOOE42UXc4NmdxV04wdmYrUkVW?=
 =?utf-8?B?cG4ya0pTUlFpWGJyRjRVN0VlcVBNNjB4ZTZ0U2VqeDZkOFVJTjk4QkpJR2Nm?=
 =?utf-8?B?OG1qRUJzQ2d4M2daNDloZm1MQlhHaG9Yenc5TWg2QzQ1empRcUtVYTJMM0ty?=
 =?utf-8?B?a3NUNmJFVmdoSElEbXFxa1RTcmVQeDFZWGlyY0g5UlU4MGxzcVI5akZuT01K?=
 =?utf-8?B?WUlUaE9kbVZwdTg4SWY5SzVkNDFMUnhtc1hINEZIZWxtQnNOR2J3SkRKQlph?=
 =?utf-8?B?SEVCKzBXZy9henI2aG5TZjBqOFlOQlROYjZFM0pPZW5OenBZTGRXcW4vUjN1?=
 =?utf-8?B?TXJjb25PSFBTZGc4MFBEaGdVa2h4REhpVm1YSXE2eGNZTmlxaVBOcUJGN2sx?=
 =?utf-8?B?dXQzVXE4SStvTGZuRjFBSDUvUFI4Zm04dEtHVVdlUWJTS2taVGJOU0tMclo1?=
 =?utf-8?B?R1JKRER3MDJaSXRKZzdwZmdGZzBFY0dMdktRQlZBeVdkMmRFMUhYcmFkTENW?=
 =?utf-8?B?NXFKQUw1RktrTmxlVWxJWXZPRWxrWkhVQ3ZKZFdqSnR5RS9iMGY3MGFzVTMy?=
 =?utf-8?B?MUwrZWNaTDVwdUN6cGhyQnZpYjNSUVZKd0t4N01WNDRjNXI4SDhQVXgvanMx?=
 =?utf-8?B?Y3AwbGJ0NnJySStKMkRCQXdoUGd2UmZGZjk5UENpdE5jUWJzcENpbTJlQ2xt?=
 =?utf-8?B?TTU4QzJkR20rSHNUZkhUYVphc2ZQdEFNOG1pVVgrVEY5OHU4eXQyM3MwdTZ2?=
 =?utf-8?B?YWlob2xFcmZXeFNFc1daYWJDSENONENzaGNtWmZNZXZOcG82Rjl0OE02NkVV?=
 =?utf-8?B?S0dsejJsK0pUdDVuOG5PZkJiOERiRUtLWFNkWTQ4Rk9tK0JmcWJwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc75a40-b189-4dc3-eaf9-08de52a813f2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:31:37.7015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+HvOBy5j2FaSpquQjy6rPvXEOX6hFGoACTH+o1TWE4n4nkG58wiOi0cIo473oaS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460
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

Patches #1-#3: Reviewed-by: Christian König <christian.koenig@amd.com>

Comment on patch #4 which also affects patches #5-#26.

Comment on patch #27 and #28. When #28 comes before #27 then that would potentially solve the issue with #27.

Patches #31: Reviewed-by: Christian König <christian.koenig@amd.com>

Patches #32-#40 that looks extremely questionable to me. I've intentionally removed that state from the job because it isn't job dependent and sometimes has inter-job meaning.

Patch #41: Absolutely clear NAK! We have exercised that nonsense to the max and I'm clearly against doing that over and over again. Saving the ring content clearly seems to be the saver approach.

Regards,
Christian.

On 1/8/26 15:48, Alex Deucher wrote:
> This set contains a number of bug fixes and cleanups for
> IB handling that I worked on over the holidays.
> 
> Patches 1-2:
> Simple bug fixes.
> 
> Patches 3-26:
> Removes the direct submit path for IBs and requires
> that all IB submissions use a job structure.  This
> greatly simplifies the IB submission code.
> 
> Patches 27-42:
> Split IB state setup and ring emission.  This keeps all
> of the IB state in the job.  This greatly simplifies
> re-emission of non-timed-out jobs after a ring reset and
> allows for re-emission multiple times if multiple resets
> happen in a row.  It also properly handles the dma fence
> error handling for timedout jobs with adapter resets.
> 
> Alex Deucher (42):
>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
>   drm/amdgpu: fix error handling in ib_schedule()
>   drm/amdgpu: add new job ids
>   drm/amdgpu/vpe: switch to using job for IBs
>   drm/amdgpu/gfx6: switch to using job for IBs
>   drm/amdgpu/gfx7: switch to using job for IBs
>   drm/amdgpu/gfx8: switch to using job for IBs
>   drm/amdgpu/gfx9: switch to using job for IBs
>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
>   drm/amdgpu/gfx10: switch to using job for IBs
>   drm/amdgpu/gfx11: switch to using job for IBs
>   drm/amdgpu/gfx12: switch to using job for IBs
>   drm/amdgpu/gfx12.1: switch to using job for IBs
>   drm/amdgpu/si_dma: switch to using job for IBs
>   drm/amdgpu/cik_sdma: switch to using job for IBs
>   drm/amdgpu/sdma2.4: switch to using job for IBs
>   drm/amdgpu/sdma3: switch to using job for IBs
>   drm/amdgpu/sdma4: switch to using job for IBs
>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
>   drm/amdgpu/sdma5: switch to using job for IBs
>   drm/amdgpu/sdma5.2: switch to using job for IBs
>   drm/amdgpu/sdma6: switch to using job for IBs
>   drm/amdgpu/sdma7: switch to using job for IBs
>   drm/amdgpu/sdma7.1: switch to using job for IBs
>   drm/amdgpu: require a job to schedule an IB
>   drm/amdgpu: mark fences with errors before ring reset
>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
>   drm/amdgpu: drop drm_sched_increase_karma()
>   drm/amdgpu: plumb timedout fence through to force completion
>   drm/amdgpu: change function signature for emit_pipeline_sync()
>   drm/amdgpu: drop extra parameter for vm_flush
>   drm/amdgpu: move need_ctx_switch into amdgpu_job
>   drm/amdgpu: store vm flush state in amdgpu_job
>   drm/amdgpu: split fence init and emit logic
>   drm/amdgpu: split vm flush and vm flush emit logic
>   drm/amdgpu: split ib schedule and ib emit logic
>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
>   drm/amdgpu: add an all_instance_rings_reset ring flag
>   drm/amdgpu: rework reset reemit handling
>   drm/amdgpu: simplify per queue reset code
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
>  54 files changed, 952 insertions(+), 966 deletions(-)
> 

