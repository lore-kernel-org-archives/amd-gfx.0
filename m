Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D568C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 04:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 273CF10E075;
	Thu,  1 Aug 2024 04:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xApso4kn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573D610E075
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 04:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhiTmOlKruC+idGOtzJ8PtMGlBcZvMw66xBBwR7wtKrpXz2gMoBGhpBbqt6O4mhuAk1Y9UUm8kkjff6XG3H/7bRIWNK2biUHiyvSlF6mLPkXEQkFm2AvbDt4JOkaS50ZOjK5RGyvWTWG4eIFXOFmNTAp3OtEsoQQx05fq2/re82iMjm6AstnGej8T32640oVQ62XoqeoWvXwQt+2cPNLaqiDiDgeSEtPd95Yvh3Xi3VUxKYl+7qXRH+Bh3UrOgf4uwvCxcswaf0h6inFHab8zZgWI61pkOX7eEQhYCgH+8p5T/lW6DPmRZ84O56HC9Af4wKJkTxBp+PuxrstvjeGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5OsCpWekP/PhE6DGUJZN78//gIEe2r92GbqKK3y9UY=;
 b=FS4ItQ96+1lNzyJJQCeAswslwZSLUNMXtLRsSCr8Ix/PxlZKdli/tIzkgulERV4Uq/smkMJhP5Z5S0Ys9RPy2yNuxOEWUQhoceQK/mnWZmlowHQ5eSAqCd3+nABOG/PsuzAuiEtr9d4LIM8ypaXFoeWIisi/pmfjELnEUEY50kG+dgn3xCoqItB+VZ7ViA91EQH9plwJazCcmQECiqaZbcwlknbEGXLuguxlNXh6XvcE7FyPywZl3C4cMp94xFFA2K0OAb0X0bDdF52w0F0CYwnNFS3GyCnpNytJjum+6MKmfJs2WpKhcq/rQu3/fH7p2KECb5NORaEUysUELpotpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5OsCpWekP/PhE6DGUJZN78//gIEe2r92GbqKK3y9UY=;
 b=xApso4knl2epwT0fkIA55JR93A3SvQ+Czm2vtqGc68VvJ+c4vcYvpvYrZIZeYODpo1WPrFqrVa/ATRz49f4OBHTQX2hOH2BDvs9Q9JkKn4Czcg5+cLjTI6XQtZ93tVpmWFThuMn2aGWo0crBViJFsUIuRa623R+G+Wyl28aKzLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 04:32:29 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 04:32:29 +0000
Message-ID: <00e7303a-e7cb-43ed-b2a3-8aebc388eeda@amd.com>
Date: Thu, 1 Aug 2024 10:02:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
 <CAAxE2A7CcN+ePP83Z55X-gqFdBg0YTPxRniLtphiJdMrZEXAcA@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CAAxE2A7CcN+ePP83Z55X-gqFdBg0YTPxRniLtphiJdMrZEXAcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::16) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: da645c68-f6eb-4caf-6c4a-08dcb1e2f40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzFOT211QUt0VDcyYmNyZUN6SDlJZVpkNlREUVRFQ0txeWlMcHNOeGVVYisx?=
 =?utf-8?B?NndvR1cvV2dreUVIWVczaEMwZy9YY05SQThxcWtPMzdDdVI2UUozWWl4ckor?=
 =?utf-8?B?QVlXNFFtY0FEZldwa2t5akFBQXQyV3BlV0VIaUlOWWljbkMwYkV4UUQ4cnh5?=
 =?utf-8?B?TkNNZW5UZThua0l6R0xSMm03VE9yOUZHTjQvN0JDT3llVEtZUG5oeWtpRjBX?=
 =?utf-8?B?V1JFeEloQzlTM1JVVWpWM2diSk5wb0lIVW5WQVQ4bU8vdkdKNTM4TnRYYk1D?=
 =?utf-8?B?NjNOWk15YkNBWkFDbjR5WWo4STZkdmtXYnNvZUltQXJMcnh2Y0RNdW5GWGgv?=
 =?utf-8?B?WWtiSnpRSWQ5UWNuU3d1aU1FMEwxTXdrT1BDM2M0NExGMmxsRnFBNlVQL1hk?=
 =?utf-8?B?NldieXNIU0ZiWGlySW5xWE42OWs0WnlLL0hOZ1VoOHdqMVRkcnFjTHFYMjVZ?=
 =?utf-8?B?V2RrQW5HSW5sYTlCNkMvOTh1eFpNRlk1UjNTN1BCdmoxdldoTFRtbUpYdjdY?=
 =?utf-8?B?VWVJZjlkdVMwMjF3UU1JckVCTGRIZG9yQnBkTThlWTNRbFhNcmpqL05hWDF4?=
 =?utf-8?B?TjVKOStBTWs0U3Q3RmhVa3hVRGcvMnFoSHVmNzNzSmxZV2czOEROM2UreEpP?=
 =?utf-8?B?Q09sUjIzVFJUQUxwQmg4WlZ3TXRpUUtXVlU0RzZRTldkYW1iY0EyekV5Mkp2?=
 =?utf-8?B?SUlrWFFaRS92a2hSN1JBd2h3RSswM0R0NFpuUStqV28xL1pGYmZyNWRNWUpG?=
 =?utf-8?B?alJvVU9MUGJIWkVEL1JpVmREZWsrczI4WXJ2UVZqWHlpQjBOSjRocDMzUU84?=
 =?utf-8?B?K0VBSUl2YTB4V0l2SDd5MFpJd1l4UktzazFFeHVHQWJnT2JzVGFrSkk2K2Vz?=
 =?utf-8?B?VlBoejM4eU0zNzBMQk9yQmpsbUpaYzRmUWV2U0kxOEVOb3ByQlBhYVQvUkph?=
 =?utf-8?B?cVFUTFBkOGZKdjNEWHhRemQ0R1pkL29LSG9hNktab1Y2TE1LSGp5ZjgzT1Ex?=
 =?utf-8?B?WFVmVms2cTVBb1BmY3FxKzlPQ282N2cvK1FJNHM4ZGRDSUVBb1QxeE10L2V2?=
 =?utf-8?B?bUlyTXg3VVE0U1JaYktRc1ZnWjd2QkhiOXRHODJhRkRjZjV1b09VQ0haSlpX?=
 =?utf-8?B?TEJ2QlZBTCtEQ2p3RXNOSTB3QXZoSkpmNW1aaVJ3UmpNaW5KNG1aNExWQ0l1?=
 =?utf-8?B?cWN2YStCY0daTGFpRVluS3cwSTlVdjdWUEdycDlQR1dqR1RMTkZkUVJPK0JB?=
 =?utf-8?B?ZXBEOVhhZ2d6U3hCRlU5b2RoclBqRzN6MlQ2d1RSa29MeGJPNFlIT1BSNkV4?=
 =?utf-8?B?KytMZ2FqcXd3blpGclQxWC9HdVBDRW9uekl3QVMwanNteWVKM0tFWE9KN0dI?=
 =?utf-8?B?L3BDMkk0cmhQRWZJVHNOM2o5T0pkbVUycktnTy9ac21CNzIzM3U2emNtMk14?=
 =?utf-8?B?TWVDK1BzL29GV3FMNGVZcUNGQkloUlBLcndPWVI1NFh4ZGl2V3pVUVpLU0Fl?=
 =?utf-8?B?S1N4anh4WmhWRytEUExvWmtic1J4RUpHeEJGdVdMWkJlYkU2bkQxU29IWlZk?=
 =?utf-8?B?cTh6UVpUVGc3TGloUnVFWDlGK1FMZkNESU8vdW9JSDdzOVYzem5aVzBtVTFT?=
 =?utf-8?B?MWJ5N0xLY2RzYVNBTzhRZ3RrdjhyY29VaXlqRE9DS0dtcWNzVS9aK29nSTQx?=
 =?utf-8?B?ZE5FcjI1NFJnejgvT3cwaG5nR0VOdmRBRW5GNDAwdmVrSHBjQUVUSkpOYkxD?=
 =?utf-8?B?T1BUMEZtc1o1aU9DNW94eEFSZUJ4NVYrcURkT2IvT0lnQVVRSkdQbnA0d2hk?=
 =?utf-8?B?b3dGeDVYbHdvZjRHUXQwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clVrWk4rUGV5cGFYYm00Q1ZrTk9ablBnRWFPaUhvVEtQb0hDazMwa1kwWFhs?=
 =?utf-8?B?WXZrOFZKYXo4S2ZtcDFSOFlNTGpETHFsRXcvSnJjUEt0Vm0vTUNqS0NRVFoy?=
 =?utf-8?B?cStLdjhnU3Y5MVZWU1JWdkw0eGUvTEs4ck1kcGdSVEZ2RVZjUWM0akUxeXJt?=
 =?utf-8?B?WWNVYTdKU3ZWY1JPWlFBS0xiTnl0SUdCWDlVNGRRdlNTU2IybmxqRFJOSHlT?=
 =?utf-8?B?ZzN6V2JjNHBjamxEYnkxejVWZDAxYkxHcE9JYjcxakVrdXFnOXVzU1A1aG5Q?=
 =?utf-8?B?YUFTSS9IWkpzRllza2xLaWtqR2RhU3hITmZUNXYrYUtVVDRycjB4bFhWK29i?=
 =?utf-8?B?dXhKeXhtbzVJSXUzaDJObWhqNUNIa2NUakR5c0FlMDBtaWhNRmF4YjZocWpa?=
 =?utf-8?B?T2JtYmtnVys1SlFzeFZjOXJ2VFZieDlmYkR1bUUxVUFNdlpvTnRQL3dtYlh1?=
 =?utf-8?B?aS9yK2Fpb2x1RVNHNy9CbzhadjMvTmN2dWJYbExvbU5WOTVCeHlVSnQra2My?=
 =?utf-8?B?ZXlxdUFFbFRPNERHKzNkN2NiWmNkb3Z2UnBBUGRCNDV3RzVCa0MvMElXNERa?=
 =?utf-8?B?eGN5cGdteXQ4RVNNSWdKQW55Z0dDYmVCSVIzR1YrUGUyNjlLQS9ucFB2MHYv?=
 =?utf-8?B?OHFpb3ZmS0hLNElKRDA4WVlxNXRlTmFPOXBjcGlXM2hEalYvZjFPQjA2dFRm?=
 =?utf-8?B?bFlLdUc0VXdVUmY1NW9ibnI2Y0NKckdIY3NrV3BXMytCM2hXQkRLTU1ZcU91?=
 =?utf-8?B?RVMwUkxEZE9KV3N2MWRyT1ZCR3UzUEtWRHcvV00xMlVQTjFkSis4N1NvL1pX?=
 =?utf-8?B?bHcrN3FrYjZDQWcrRG1idWp1bkw2SytOR1h3VkgwSUkxUU1STXc0THgrNkRF?=
 =?utf-8?B?VnhMVmF6eGdKTUZZSXlFeDdFamZlV2NOSytYSnhuMFgrSGZMeHd2UEZiV2h5?=
 =?utf-8?B?Wk1UZTY5ZDFBcU90Si9weFR3Tkoyd1YxaGNzWTVtYmZ3MXNiQUQ2R2F0UXda?=
 =?utf-8?B?VVRjNjEzbkRVWUF3TGZLVHlGeWlub3dDVEIra0x2QWJQZWpEQ3FYWGFSTHBh?=
 =?utf-8?B?cXcrTDBRSnNYdUZvYmJLVjJWcWhpTHdoSDRZQmRRbnQ1ZHZGcjUrL251UmVj?=
 =?utf-8?B?WGxPZnJWZlcxK1NxOHRBODZDMjBDcThaZmFIOE4zamZQeTYxeVozTjJDdGpE?=
 =?utf-8?B?ejc3ZnUyMUNnNms1Y09CTmlPRXRXQVpVZkF4ZENUWDZQNkFIMjNKemhmOWtB?=
 =?utf-8?B?VTZRRjUxTU9IRG1Ndi9CWVdrQkVOd0I5Q1duT0puaU9yakdoL2JxOWdZYVBu?=
 =?utf-8?B?VnoyckZIbTRlaVNsSzNuV3NhUDFiM0JnbGNOQkFncyt2dEJ5UnpzWndBc0JO?=
 =?utf-8?B?SHFadytucFZ1M1AvbHYrOENlMFR5dGJ6S2RVVTEvWjE4UktCR3NGQVpNRXBP?=
 =?utf-8?B?U1RwOHljbmZmUFlSTmx5cDV0cldncldVZ0xGUldIWUora3pjVFBJMjFYUUQy?=
 =?utf-8?B?ekJsajhYUWNQQVkyUitjMDdrSlJpUWlPaDNmWUNTTXRheW9UZ1NLK0hTS0dU?=
 =?utf-8?B?OWtGL0dycUpzMHRWSTZuS3liUTEzdWw4MlZnLzk4MFRSZGlIZTFiaFQ3dTVI?=
 =?utf-8?B?SE5LckZWSXcrV0RIV3g2MFE5RDJ3MXc1Z3N1cjM4TGh6TVV4WGxjc2FCOWpE?=
 =?utf-8?B?SmlWSmVYUEpTV3Z1UEZMRlFoQlhpK1IyOTl5Mmw4ak52ajZTU1lIOEkwcm1L?=
 =?utf-8?B?UEFWV3hBcEt6VU5oQm13b2o4Wko4M1ZoZCtWR0d5NkNNcGNlcGwzM1JHempJ?=
 =?utf-8?B?VTF6cnl0cXBjbWxrRU5EejA5TTF3a3lVR1Y3czZ1M2duNDZuMjlyR1JxTG5y?=
 =?utf-8?B?aUViM3lOUzdOelBYTFpRTEZia3BsOFo0WHdJUjgwRWVaMm8wOXd2RXdVVGdH?=
 =?utf-8?B?ZE4xazFKcFFLUCtNak4zSlNaN0lZUjFtdGNGeDM2UUxPeVRpN2xySy9EeXBL?=
 =?utf-8?B?bHZDbE5XbmN4K1NzZlRuMUVWWEltNEpkT2xQZ0FpZHNoS2h2VnVTdm9UQkRF?=
 =?utf-8?B?UG1wRGxPdHRKcmhSZUY3ayt3MHhkTEZWb2kyTkZvK2RybFJ6cXFvd0xUSEpL?=
 =?utf-8?Q?SZL8eQ0HitJxmNX7Edt6MVMiI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da645c68-f6eb-4caf-6c4a-08dcb1e2f40d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 04:32:29.7890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IudDu05r8APFbtzlM2Z4x8GUh9xU041FHRt8slgwweVat5n6GXGxtqMyZmUnOX7HicNulmui8jVIvSEJWXF2oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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


On 8/1/2024 8:52 AM, Marek Olšák wrote:
> On Wed, Jul 31, 2024 at 11:19 PM Marek Olšák <maraeo@gmail.com> wrote:
>> On Tue, Jul 30, 2024 at 8:43 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>> Adding NOP packets one by one in the ring
>>> does not use the CP efficiently.
>>>
>>> Solution:
>>> Use CP optimization while adding NOP packet's so PFP
>>> can discard NOP packets based on information of count
>>> from the Header instead of fetching all NOP packets
>>> one by one.
>>>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> Cc: Tvrtko Ursulin <tursulin@igalia.com>
>>> Cc: Marek Olšák <marek.olsak@amd.com>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 +++++++++++++++++++++---
>>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 853084a2ce7f..edf5b5c4d185 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -9397,6 +9397,24 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>>          amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>>   }
>>>
>>> +static void amdgpu_gfx10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>>> +{
>>> +       int i;
>>> +
>>> +       /* Header itself is a NOP packet */
>>> +       if (num_nop == 1) {
>>> +               amdgpu_ring_write(ring, ring->funcs->nop);
>>> +               return;
>>> +       }
>>> +
>>> +       /* Max HW optimization till 0x3ffe, followed by remaining one NOP at a time*/
>>> +       amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
>>> +
>>> +       /* Header is at index 0, followed by num_nops - 1 NOP packet's */
>>> +       for (i = 1; i < num_nop; i++)
>>> +               amdgpu_ring_write(ring, ring->funcs->nop);
>> This loop should be removed. It's unnecessary CPU overhead and we
>> should never get more than 0x3fff NOPs (maybe use BUG_ON). Leaving the
>> whole packet body uninitialized is the fastest option.
> If you remove amdgpu_ring_write, you still need to move wptr somehow.
> amdgpu_ring_write_multiple gives a hint about how to do it:
>
> ring->wptr += count_dw;
> ring->wptr &= ring->ptr_mask;
> ring->count_dw -= count_dw;
The reason i gave in the previous commit why we just dint just move the 
wptr instead or writing all nops in the ring. I also tried exactly what 
is given above to just move wptr but the device dint boot.

Possible the calculation is wrong or on some target the NOP isnt working 
as expected. With this approach if the NOP is working as per spec it 
would help in saving GPU cycles and if it does not in that case

also it wont crash as NOPS are still there in the ring.
I did not spend more time in analysing the crash due to just shifting 
the wptr for the reason explained in previous commit. Original 
understanding was to just move wptr but based on christian feedback
we are still filling the ring with nops.

>
> Marek
>
>> Marek
>>
>>> +}
>>> +
>>>   static void gfx_v10_ip_print(void *handle, struct drm_printer *p)
>>>   {
>>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> @@ -9588,7 +9606,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>>>          .emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>>>          .test_ring = gfx_v10_0_ring_test_ring,
>>>          .test_ib = gfx_v10_0_ring_test_ib,
>>> -       .insert_nop = amdgpu_ring_insert_nop,
>>> +       .insert_nop = amdgpu_gfx10_ring_insert_nop,
>>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>>          .emit_switch_buffer = gfx_v10_0_ring_emit_sb,
>>>          .emit_cntxcntl = gfx_v10_0_ring_emit_cntxcntl,
>>> @@ -9629,7 +9647,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
>>>          .emit_hdp_flush = gfx_v10_0_ring_emit_hdp_flush,
>>>          .test_ring = gfx_v10_0_ring_test_ring,
>>>          .test_ib = gfx_v10_0_ring_test_ib,
>>> -       .insert_nop = amdgpu_ring_insert_nop,
>>> +       .insert_nop = amdgpu_gfx10_ring_insert_nop,
>>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>>          .emit_wreg = gfx_v10_0_ring_emit_wreg,
>>>          .emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
>>> @@ -9659,7 +9677,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
>>>          .emit_fence = gfx_v10_0_ring_emit_fence_kiq,
>>>          .test_ring = gfx_v10_0_ring_test_ring,
>>>          .test_ib = gfx_v10_0_ring_test_ib,
>>> -       .insert_nop = amdgpu_ring_insert_nop,
>>> +       .insert_nop = amdgpu_gfx10_ring_insert_nop,
>>>          .pad_ib = amdgpu_ring_generic_pad_ib,
>>>          .emit_rreg = gfx_v10_0_ring_emit_rreg,
>>>          .emit_wreg = gfx_v10_0_ring_emit_wreg,
>>> --
>>> 2.34.1
>>>
